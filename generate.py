tags = [
    'latest',
    '20.10',
    '20.04',
    '18.04',
]
source = open('./Dockerfile').read()
for tag in tags:
    with open(f'./Dockerfiles/{tag}','w') as f:
        f.write(source.replace('{tag}',tag))
