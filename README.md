# protecao_propriedade_intelectual

1 - sudo docker build -t builder__nome_da_imagem -f ./builder/dockerfile .

2 - sudo docker run -d builder__nome_da_imagem  

3 - sudo docker cp $(sudo docker ps --format '{{.ID}}' --filter "ancestor=builder__nome_da_imagem"):/app ./dist

4 - sudo docker rmi builder__nome_da_imagem

5 - sudo docker build -t nome_da_imagem -f ./runner/dockerfile .

6 - sudo docker run -d -p 5000:5000 nome_da_imagem 
    sudo docker run -p 5000:5000 nome_da_imagem 