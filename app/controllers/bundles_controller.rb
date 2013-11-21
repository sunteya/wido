class BundlesController < ApplicationController
  def show
    @bundle = bundle(params[:id])

    scope = Article.published
    scope = scope.tagged_with(@bundle[:any].split(" "), any: true) if @bundle[:any]
    scope = scope.tagged_with(@bundle[:not].split(" "), exclude: true) if @bundle[:not]

    @articles = scope
  end

protected
  def bundle(name)
    bundle = Project.settings.bundles.select { |k, v| k.downcase == name.downcase }
    bundle.inject({}) do |hash, pair|
      hash[:name] = pair.first
      hash.merge(pair.last[0])
    end.symbolize_keys
  end
end
