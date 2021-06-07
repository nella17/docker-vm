tags = [
    'latest',
    '20.10',
    '20.04',
    '18.04',
]
source = open('./Dockerfile').read()
for tag in tags:
    fn = f'./Dockerfiles/{tag}'
    with open(fn,'w') as f:
        f.write(source.replace('{tag}',tag))
        print(fn, 'done')
