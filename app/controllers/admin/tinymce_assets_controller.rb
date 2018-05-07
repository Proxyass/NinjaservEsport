class Admin::TinymceAssetsController < ApplicationController

  def create
    # Take upload from params[:file] and store it somehow...
    # Optionally also accept params[:hint] and consume if needed
    asset = NewsAsset.new()
    asset.file = asset_params[:file]
    news = News.new(JSON.parse(asset_params[:hint]))
    asset.news = news
    if !news.persisted?
      news.save
    end
    if asset.save
      render json: {image: {url: asset.file.url}}, content_type: "text/html"
    else
      render json: {error: { message: asset.errors.full_messages.to_sentence}}
    end
  end

  def asset_params
    params.permit(:hint, :file, :alt)
  end
end
