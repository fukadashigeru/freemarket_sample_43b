class RegionsController < ApplicationController
  def index
    @hokkaido = Region.get_hokkaido
    @tohoku = Region.get_tohoku
    @kanto = Region.get_kanto
    @hokuriku = Region.get_hokuriku
    @tyubu = Region.get_tyubu
    @kinki = Region.get_kinki
    @tyugoku = Region.get_tyugoku
    @sikoku = Region.get_sikoku
    @kyusyu  = Region.get_kyusyu
  end

  def show
    @region_name = Region.find(params[:id])
    @region_list = Region.find(params[:id]).items.includes(:likes).order("id DESC")
  end
end
