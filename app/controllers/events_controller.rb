# frozen_string_literal: true

class EventsController < ApplicationController
  def new
    @users = User.all
    @user = User.find(params[:user_id])
    @movie = MovieFacade.movie_details(params[:movie_id])
  end

  def create
    date = DateTime.parse("#{params[:date]} #{params[:time]}")
    event = Event.create!(day: date, duration: params[:runtime], start_time: params[:time], movie_title: params[:title])

    UserEvent.create!(user_id: params[:user_id], event_id: event.id)

    redirect_to "/users/#{params[:user_id]}"
  end
end
