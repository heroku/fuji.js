casper.start "http://localhost:8000/test", ->

  @waitUntilVisible "#fuji", ->
    @test.assertExists "#fuji > .fuji-container"
    @test.assertExists "#fuji > .fuji-container > h1.fuji-brand"
    @test.assertExists "#fuji > .fuji-container > ul.fuji-links"

  # Test with logged-in user

  # Test without user

casper.run ->
  @test.done()
  @test.renderResults(true)
