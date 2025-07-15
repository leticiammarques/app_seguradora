# insurance_seguradora

Um novo projeto Flutter.

## Primeiros passos

Este projeto utiliza **Firebase** como backend.  
Por questões de segurança, o arquivo de configuração (`firebase_options.dart`) **não está incluído** no repositório.

Siga os passos abaixo para configurar corretamente o seu próprio projeto Firebase.

---

Baixe o app e faça os passos seguintes na raiz do projeto

## 🔥 Configuração do Firebase (Obrigatória)

### 1. Crie um projeto no Firebase
- Acesse o [Firebase Console](https://console.firebase.google.com)
- Clique em **Adicionar projeto**
- Siga as instruções até a finalização

### 2. Adicione um app do tipo Flutter
- Clique em **Adicionar app** e selecione **Flutter**
- Informe o nome do pacote do seu app (ex: `com.seuprojeto.app`)
- Siga as instruções da plataforma

---

### 3. Instale o FlutterFire CLI
Se ainda não tiver instalado, execute no terminal:

```
dart pub global activate flutterfire_cli
```
PS: as informações de passo a passo também estarão na configurações do Firebase

---

### 4. Gere o arquivo de configuração do Firebase

No terminal, dentro da pasta do seu projeto, execute:

```
flutterfire configure
```

- Selecione o projeto Firebase criado
- Marque as plataformas que deseja configurar (Android, iOS, Web)
- O comando vai gerar automaticamente o arquivo `firebase_options.dart` dentro da pasta `lib`

> ⚠️ Certifique-se de que o arquivo esteja na **mesma hierarquia que o `main.dart`**:  
> `lib/firebase_options.dart`

---

## ✅ Inicialização do Firebase

No seu projeto firebase, vá na engrenagem no menu direito superior, na opção 'Configurações do projeto', ache seu projeto web e copie o 'ID do aplicativo'.
No projeto flutter, na pasta web, no arquivo `index.html`, substitua o id do Firebase:

```html
  <meta name="google-signin-client_id"
content="seu_id_do_firebase.apps.googleusercontent.com" />
```

---

## Recursos úteis do Flutter

- [Documentação do FlutterFire](https://firebase.flutter.dev/docs/overview/)
