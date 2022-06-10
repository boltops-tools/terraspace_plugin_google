module TerraspacePluginGoogle::Interfaces
  class Ci
    def vars
      {
        GOOGLE_APPLICATION_CREDENTIALS: '${{ secrets.GOOGLE_APPLICATION_CREDENTIALS }}',
        GOOGLE_PROJECT: '${{ secrets.GOOGLE_PROJECT }}',
        GOOGLE_REGION: '${{ secrets.GOOGLE_REGION }}',
        GOOGLE_ZONE: '${{ secrets.GOOGLE_ZONE }}',
      }
    end
  end
end
