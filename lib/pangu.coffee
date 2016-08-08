{CompositeDisposable} = require 'atom'
pangu = require 'pangu'

RangeFinder = require './range-finder'

module.exports =
  config:
    autoPanguEnabled:
      title: 'Auto spacing on save'
      type: 'boolean'
      default: false
    ignoredFilenames:
      title: 'Auto spacing ignored filenames'
      type: 'array'
      default: []
      items:
        type: 'string'
    skipNoCJKLine:
      title: 'Skip on lines without Chinese, Japanese and Korean'
      type: 'boolean'
      default: false
    ignoredPattern:
      title: 'Ignoring text with the matched pattern, e.g. \\*\\*[^\\*\\*]+\\*\\*, <pre>(.*?)</pre>'
      type: 'string'
      default: ''

  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'pangu:spacing': => @spacing()

    @subscriptions.add atom.workspace.observeTextEditors (editor) =>
      @subscriptions.add editor.onDidSave =>
        autoPanguEnabled = atom.config.get('pangu.autoPanguEnabled')
        # return immediately if automatic spacing is disabled
        return unless autoPanguEnabled

        editor = atom.workspace.getActiveTextEditor()
        currentFilePath = editor.getPath()

        minimatch = require('minimatch')

        ignoredFilenames = atom.config.get('pangu.ignoredFilenames') ? []
        ignoredFilenames = [ignoredFilenames] if typeof ignoredFilenames is 'string'
        isIgnored = false
        for ignoreFilename in ignoredFilenames when ignoreFilename
          try
            isIgnored = true if minimatch(currentFilePath, ignoreFilename, matchBase: true, dot: true)
          catch error
            atom.notifications.addWarning("Error parsing ignore pattern (#{ignoreFilename})", detail: error.message)

        @spacing() if not isIgnored

  deactivate: ->
    @subscriptions.dispose()

  spacingText: (text) ->
    skipNoCJKLine = atom.config.get('pangu.skipNoCJKLine')
    if skipNoCJKLine and not /[\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]/.test text
      return text
    else
      return pangu.spacing(text)

  mergeTwoArrays: (firstTexts, secondTexts) ->
    mergedArray = []
    for text, index in firstTexts
      mergedArray.push(text)
      mergedArray.push(secondTexts[index])
    mergedArray

  spacing: ->
    console.log 'Pangu: spacing'
    editor = atom.workspace.getActiveTextEditor()
    # return immediately if file is empty
    return unless editor.getText()

    sortableRanges = RangeFinder.rangesFor(editor)
    ignoredPattern = atom.config.get('pangu.ignoredPattern')
    for range in sortableRanges
      textLines = editor.getTextInBufferRange(range).split('\n')
      insertedTextLines = []
      for textLine in textLines
        if ignoredPattern
          re = new RegExp(ignoredPattern, 'g')
          ignoredTexts = textLine.match(re)
          if ignoredTexts
            notIgnoredTexts = textLine.split(re)
            newArray = []
            for text in notIgnoredTexts
              text = @spacingText(textLine)
              newArray.push(text)

            newArray = @mergeTwoArrays(newArray, ignoredTexts)
            textLine = newArray.join('')
          else
            textLine = @spacingText(textLine)
        else
          textLine = @spacingText(textLine)

        insertedTextLines.push(textLine)
      editor.setTextInBufferRange(range, insertedTextLines.join('\n')) if insertedTextLines != textLines
