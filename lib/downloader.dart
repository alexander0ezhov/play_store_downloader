String downloaderScript =
    'var href = document.location.href;'
    'if (~href.indexOf("id=")) {'
    'alert("Загружаем")'
    'return href'
    '} else {'
    '   alert("Выберите приложение")'
    '}'
    'return 0';