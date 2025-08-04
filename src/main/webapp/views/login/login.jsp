<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Struts Admin</title>
    <!-- Ant Design CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/antd@5.12.8/dist/reset.css">
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/antd@5.12.8/dist/antd.min.js"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            width: 400px;
            max-width: 90vw;
        }
        .login-header {
            text-align: center;
            margin-bottom: 32px;
        }
        .login-title {
            font-size: 24px;
            font-weight: 600;
            color: #262626;
            margin-bottom: 8px;
        }
        .login-subtitle {
            color: #8c8c8c;
            font-size: 14px;
        }
        .form-group {
            margin-bottom: 24px;
        }
        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #262626;
            font-weight: 500;
        }
        .form-input {
            width: 100%;
            height: 40px;
            padding: 8px 12px;
            border: 1px solid #d9d9d9;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s;
            box-sizing: border-box;
        }
        .form-input:focus {
            outline: none;
            border-color: #1890ff;
            box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.2);
        }
        .btn-primary {
            width: 100%;
            height: 40px;
            background: #1890ff;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background: #40a9ff;
        }
        .btn-primary:active {
            background: #096dd9;
        }
        .error-message {
            color: #ff4d4f;
            font-size: 14px;
            margin-top: 16px;
            padding: 8px 12px;
            background: #fff2f0;
            border: 1px solid #ffccc7;
            border-radius: 4px;
        }
        .demo-users {
            margin-top: 24px;
            padding: 16px;
            background: #f6ffed;
            border: 1px solid #b7eb8f;
            border-radius: 4px;
        }
        .demo-title {
            font-weight: 600;
            color: #52c41a;
            margin-bottom: 8px;
        }
        .demo-user {
            font-size: 12px;
            color: #595959;
            margin-bottom: 4px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1 class="login-title">Struts Admin</h1>
            <p class="login-subtitle">Sign in to your account</p>
        </div>
        
        <s:form action="login" method="post" theme="simple">
            <div class="form-group">
                <label class="form-label" for="username">Username</label>
                <s:textfield 
                    name="username" 
                    id="username"
                    cssClass="form-input"
                    placeholder="Enter your username"
                    required="true"/>
            </div>
            
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <s:password 
                    name="password" 
                    id="password"
                    cssClass="form-input"
                    placeholder="Enter your password"
                    required="true"/>
            </div>
            
            <s:submit value="Sign In" cssClass="btn-primary"/>
            
            <s:if test="hasActionErrors()">
                <div class="error-message">
                    <s:actionerror/>
                </div>
            </s:if>
        </s:form>
        
        <div class="demo-users">
            <div class="demo-title">Demo Users:</div>
            <div class="demo-user">• admin / admin123 (Admin)</div>
            <div class="demo-user">• user / user123 (User)</div>
            <div class="demo-user">• guest / guest123 (Guest)</div>
        </div>
    </div>
</body>
</html>