{HtmlBuilder, Tag} = require '../src/html-builder'

fdescribe "HtmlBuilder", ->
  htmlBuilder = null

  beforeEach ->
    htmlBuilder = new HtmlBuilder

  it "works with flat structures", ->
    tag1 = htmlBuilder.openTag(Tag("span"))
    htmlBuilder.put("h")
    htmlBuilder.put("i")
    htmlBuilder.closeTag(tag1)

    expect(htmlBuilder.toString()).toEqual("<span>hi</span>")

  it "works with nested structures", ->
    tag1 = htmlBuilder.openTag(Tag("div"))
    tag2 = htmlBuilder.openTag(Tag("span"))
    htmlBuilder.put("h")
    htmlBuilder.put("i")
    htmlBuilder.closeTag(tag2)
    htmlBuilder.closeTag(tag1)

    expect(htmlBuilder.toString()).toEqual("<div><span>hi</span></div>")

  it "remembers open tags when a tag with a lesser indent level gets closed", ->
    tag1 = htmlBuilder.openTag(Tag("div"))
    tag2 = htmlBuilder.openTag(Tag("span"))
    htmlBuilder.put("h")
    htmlBuilder.put("e")
    htmlBuilder.closeTag(tag1)
    htmlBuilder.reopenTags()
    htmlBuilder.put("y")
    htmlBuilder.closeTag(tag2)

    expect(htmlBuilder.toString()).toEqual("<div><span>he</span></div><span>y</span>")

  it "clears everything after reset", ->
    tag = htmlBuilder.openTag(Tag("div"))
    htmlBuilder.put("hello")
    htmlBuilder.closeTag(tag)

    htmlBuilder.reset()
    htmlBuilder.put("hello")

    expect(htmlBuilder.toString()).toEqual("hello")
