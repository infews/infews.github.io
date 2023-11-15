---
title: Dynamic Polymorphic Forms in Rails 7
date: 2023-11-15 16:18 UTC
tags:
  - web development
  - ruby
  - rails
  - forms
keywords:
  - ruby
  - rails
  - dynamic forms
  - polymorphism
teaser: "Relearning Rails modeling, polymorphism, and dynamic forms."
unsplash: 
  url: https://images.unsplash.com/photo-1589010588553-46e8e7c21788?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NjkxMjJ8MHwxfGFsbHx8fHx8fHx8fDE3MDAwNjg4Nzh8&ixlib=rb-4.0.3&q=80&w=1080&utm_source=dwfs_journal_big_pencil&utm_medium=referral&utm_campaign=api-credit
  title: "Colourful food 🍱"
---
[planning]: /covid-19-inspired-meal-planning/
[forms]: https://guides.rubyonrails.org/form_helpers.html#building-complex-forms
[poly]: https://stackoverflow.com/questions/51564463/polymorphic-has-and-belongs-to-many
[alexis]: https://medium.com/@alexischvez
[turbo]: https://medium.com/@alexischvez/hotwire-supercharged-rails-forms-with-turbo-6de79bb9e374
[cocktails]: https://stackoverflow.com/questions/71713303/rails-7-dynamic-nested-forms-with-hotwire-turbo-frames

It was time to move [my Meal Planning app][planning] from AirTable to a custom application. AirTable's pricing for the size of the database wasn't awful, but I'd moved past the free account limits. And there were some features I wanted to add that were hard with the basic AirTable features.

It's been a while, so let's write a Rails app!

I exported CSVs from AirTable, ran `bundle && rails new` and got to test-driving. Rails 7 and Resource scaffolding just worked as I expected. `Recipes` and `Restaurants` came together very quickly.

As soon as I tried to model a calendar of days, where days could have one or more restaurants and one or more recipes (a key feature of the current solution), things got complex.

I ran into three problems:

1. Rails and forms with `has_many` associations
2. But the association is polymorphic
3. But the form really needs to be dynamic in order to add/remove things from the association

## Complex Forms

I had my `Recipe` and `Restaurant` models and full controllers. Now I wanted to add a `Day` model that has a date as well has `has_many :recipes` as a starting point.

Rails has gotten pretty mature when it comes to the `fields_for` helper that basically gives you a nested form that includes your association. The [Complex Forms][forms] section of the Action View Form Helpers Rails Guide talks about People with more than one address. This is great for explaining how `form_with` and `fields_for` work together.

To keep things simple, I only tried to add and edit one `Recipe` on a `Day`. It was working great. Now it was time to make the association polymorphic.

## Polymorphic has-and-belongs-to-many

I needed to be able to add one recipe _or_ one restaurant. I tried several different modelings of the associations to get a polymorphic `has_many` to work and couldn't get all the tests passing. Then I found [this StackOverflow post][poly] that was. I needed a separate join table with some `has_many through`'s'. 

Of course! I needed something that looked more like:

`Day <-> Meal (Course <-> [Recipe | Restaurant])`

Which got me to these models:

```ruby
class Day < ApplicationRecord  
  validates :date, uniqueness: true  
  validates :date, presence: true  
  
  has_many :meals, dependent: :destroy  
end

class Meal < ApplicationRecord  
  belongs_to :day  
  belongs_to :course, polymorphic: true  
end

class Recipe < ApplicationRecord  
  validates :name, presence: true  
  
  has_many :meals, as: :course  
  has_many :days, through: :meals  
end

class Restaurant < ApplicationRecord  
  validates :name, presence: true  
  
  has_many :meals, as: :course  
  has_many :days, through: :meals  
end
```
(Note: I'm not thrilled with the name of `course`, but it's close enough.)

Now with the form, I could put one `Recipe` select and one `Restaurant` select and be able to have one or the other. There were some bugs, sure. But I was creating, updating, and saving `Day`s. Progress!

Next question - how do I get the form properly dynamic, adding as many recipes and restaurants as I wanted?

## Dynamic Complex Polymorphic Forms

There's a nice caveat at the Rails Guide for forms:

> Rather than rendering multiple sets of fields ahead of time you may wish to add them only when a user clicks on an "Add new address" button. Rails does not provide any built-in support for this.

Whoops. I'm on my own.

To recap, I knew that what I wanted was for a `Day` form to start with no Meals, but then be able to add or delete many `Recipes` and `Restaurants` and submit that form at the end to create or update the `Day`.

Time to learn Turbo and Hotwire.

I found two great pages that helped immensely. First, was [Alexis Chávez's][alexis] guide to [Turbo & Hotwire][turbo]. The concepts were clear - it's a bit like old RJS, but more formal thanks to how Controllers have evolved. But how do I structure the form?

Back to StackOverflow, and a nicely detailed question [Rails 7 Dynamic Nested Forms with hotwire/turbo frames][cocktails]. It models cocktails with ingredients and looked a lot like what I needed.

I had some patterns! Time for some code.

## DaysController gets new methods

First, a couple of new routes:

```ruby
resources :days do  
  get :new_meal, on: :collection, path: "new_meal/:course_type"  
  delete :destroy_meal, on: :collection, path: "destroy_meal/(:id)"  
end
```
Then in the `Day` form I added two Turbo links that call the `#new_meal` method: one to add a `Recipe` and one to add a `Restaurant`.

```ruby
.meals
  ...
  = link_to new_meal_days_path("Recipe"), data: { turbo_method: :get } do  
    %i.fa-regular.fa-square-plus  
    = "Add Recipe"  
  = link_to new_meal_days_path("Restaurant"), data: { turbo_method: :get } do  
    %i.fa-regular.fa-square-plus  
    = "Add Restaurant"
```

Then in `DaysController`:

```ruby
def new_meal  
  helpers.fields model: Day.new do |f| 
    f.fields_for :meals,  
                 Meal.new,  
                 child_index: 
                   Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond) do |ff|  
      render turbo_stream: 
               turbo_stream.append("meals", 
                                   partial: "meal_fields", 
                                   locals: {f: ff, klass: params[:course_type] })  
    end  
  end
end  
```

Copying from the "Cocktails" post, this method:
- Creates a form helper that will build the tags for a `Day` and then one `Meal`
- Passes the `fields_for` form helper (`ff`) to the view, along with the `course_type` that came in from the `GET`

And then the `meals_fields` view...

```ruby
- div_id = "meal_#{f.index}"  
  
%div{id: div_id}  
  = f.hidden_field :id  
  = f.hidden_field :course_type, value: course_type  
  .course_edits  
    = f.collection_select :course_id, 
                          course_type.constantize.order(:name), 
                          :id, 
                          :name, 
                          prompt: "Select a #{course_type}..."  
    = link_to destroy_meal_days_path(id: f.object.id, div_id: div_id), 
              data: { turbo_method: :delete } do  
      %i.fa-regular.fa-square-minus
```

This builds a `div` with a unique ID (from the timestamp in the controller method) that renders:
- Hidden fields for the `Meal` `id` and `course_type`
- A select with that type's list (yay, `String#constantize`!)
- A link to destroy this section of the form, if the user so chooses

And that link routes back to `DaysController#destory_meal`

```ruby
def destroy_meal  
  Meal.find(params[:id]).destroy! if params[:id]  
  
  render turbo_stream: turbo_stream.remove(params[:div_id])  
end
```
Which will...
- Find and destroy the `Meal` if this is a `Day#edit` and so an `id` is provided; but ignores it if not
- Removes this `Meal`'s `div` inside the `Day` form

## It's Alive!

![completed form](/images/editing_day.png)

Phew! Thanks, Internet! 

## Links

- [Rails Guide - Active View Form Helpers][forms]
- [StackOverflow - Polymorphic Has and Belongs to Many][poly]
- [Medium - Hotwire: Supercharged Rails forms with Turbo][turbo] by [Alexis Chávez][alexis]
- [StackOverflow - Rails 7 Dynamic Nested Forms with hotwire/turbo frames][cocktails]



