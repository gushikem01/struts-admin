<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Struts Admin</title>
    <!-- Ant Design CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/antd@5.12.8/dist/reset.css">
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/antd@5.12.8/dist/antd.min.js"></script>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: #f0f2f5;
        }
        .layout {
            min-height: 100vh;
            display: flex;
        }
        .sidebar {
            width: 250px;
            background: #001529;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            transition: all 0.3s;
            z-index: 1000;
        }
        .sidebar.collapsed {
            width: 80px;
        }
        .sidebar-header {
            height: 64px;
            display: flex;
            align-items: center;
            padding: 0 24px;
            border-bottom: 1px solid #1f1f1f;
        }
        .logo {
            color: #fff;
            font-size: 20px;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
        }
        .sidebar.collapsed .logo {
            font-size: 16px;
        }
        .menu {
            padding: 16px 0;
        }
        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 24px;
            color: rgba(255, 255, 255, 0.65);
            text-decoration: none;
            transition: all 0.3s;
            cursor: pointer;
        }
        .menu-item:hover {
            background: #1890ff;
            color: #fff;
        }
        .menu-item.active {
            background: #1890ff;
            color: #fff;
        }
        .menu-icon {
            width: 20px;
            height: 20px;
            margin-right: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }
        .menu-icon i {
            color: inherit;
        }
        .sidebar.collapsed .menu-icon {
            margin-right: 0;
        }
        .menu-text {
            white-space: nowrap;
            overflow: hidden;
            transition: opacity 0.3s;
        }
        .sidebar.collapsed .menu-text {
            opacity: 0;
            width: 0;
        }
        .main-layout {
            flex: 1;
            margin-left: 250px;
            transition: margin-left 0.3s;
            display: flex;
            flex-direction: column;
        }
        .layout.sidebar-collapsed .main-layout {
            margin-left: 80px;
        }
        .header {
            background: #fff;
            padding: 0 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
            box-shadow: 0 1px 4px rgba(0,21,41,.08);
            position: relative;
            z-index: 10;
        }
        .header-left {
            display: flex;
            align-items: center;
        }
        .hamburger {
            background: none;
            border: none;
            cursor: pointer;
            padding: 8px;
            margin-right: 16px;
            font-size: 18px;
            color: #262626;
            transition: color 0.3s;
        }
        .hamburger:hover {
            color: #1890ff;
        }
        .page-title-header {
            font-size: 20px;
            font-weight: 600;
            color: #262626;
        }
        .user-info {
            color: #262626;
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #1890ff;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 600;
        }
        .logout-btn {
            background: transparent;
            border: 1px solid #1890ff;
            color: #1890ff;
            padding: 6px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .logout-btn:hover {
            background: #1890ff;
            color: #fff;
        }
        .main-content {
            flex: 1;
            padding: 24px;
        }
        .page-header {
            background: #fff;
            padding: 24px;
            margin-bottom: 24px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        .page-title {
            font-size: 24px;
            font-weight: 600;
            color: #262626;
            margin-bottom: 8px;
        }
        .page-subtitle {
            color: #8c8c8c;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: #fff;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s;
        }
        .stat-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .stat-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 16px;
        }
        .stat-title {
            color: #8c8c8c;
            font-size: 14px;
            font-weight: 500;
        }
        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        .stat-icon.users {
            background: #e6f7ff;
            color: #1890ff;
        }
        .stat-icon.orders {
            background: #f6ffed;
            color: #52c41a;
        }
        .stat-icon.revenue {
            background: #fff2e8;
            color: #fa8c16;
        }
        .stat-icon.system {
            background: #f9f0ff;
            color: #722ed1;
        }
        .stat-value {
            font-size: 30px;
            font-weight: 600;
            color: #262626;
            margin-bottom: 4px;
        }
        .stat-change {
            font-size: 12px;
            color: #52c41a;
        }
        .dashboard-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }
        .chart-card {
            background: #fff;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #262626;
            margin-bottom: 16px;
        }
        .card-title i {
            margin-right: 8px;
            color: #1890ff;
        }
        .info-label i {
            margin-right: 8px;
            color: #8c8c8c;
            width: 16px;
        }
        .stat-change i {
            margin-right: 4px;
        }
        .system-info {
            background: #fff;
            padding: 24px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .info-item:last-child {
            border-bottom: none;
        }
        .info-label {
            color: #8c8c8c;
            font-size: 14px;
        }
        .info-value {
            color: #262626;
            font-weight: 500;
        }
        .status-online {
            color: #52c41a;
        }
        .progress-bar {
            width: 100%;
            height: 8px;
            background: #f0f0f0;
            border-radius: 4px;
            overflow: hidden;
            margin-top: 8px;
        }
        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #1890ff, #69c0ff);
            transition: width 0.3s;
        }
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-250px);
            }
            .sidebar.mobile-open {
                transform: translateX(0);
            }
            .sidebar.collapsed {
                transform: translateX(-80px);
            }
            .sidebar.collapsed.mobile-open {
                transform: translateX(0);
                width: 250px;
            }
            .main-layout {
                margin-left: 0;
            }
            .sidebar.collapsed + .main-layout {
                margin-left: 0;
            }
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .main-content {
                padding: 16px;
            }
            .sidebar-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.45);
                z-index: 999;
                display: none;
            }
            .sidebar-overlay.active {
                display: block;
            }
        }
    </style>
</head>
<body>
    <div class="layout">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="logo">Struts Admin</div>
            </div>
            <nav class="menu">
                <a href="#" class="menu-item active" onclick="setActiveMenu(this)">
                    <span class="menu-icon"><i class="fas fa-home"></i></span>
                    <span class="menu-text">ホーム</span>
                </a>
                <a href="#" class="menu-item" onclick="setActiveMenu(this)">
                    <span class="menu-icon"><i class="fas fa-search"></i></span>
                    <span class="menu-text">検索</span>
                </a>
                <a href="logout" class="menu-item">
                    <span class="menu-icon"><i class="fas fa-sign-out-alt"></i></span>
                    <span class="menu-text">ログアウト</span>
                </a>
            </nav>
        </aside>
        
        <!-- Mobile Overlay -->
        <div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>
        
        <!-- Main Layout -->
        <div class="main-layout">
            <header class="header">
                <div class="header-left">
                    <button class="hamburger" onclick="toggleSidebar()">
                        <i class="fas fa-bars"></i>
                    </button>
                    <h1 class="page-title-header">Dashboard</h1>
                </div>
                <div class="user-info">
                    <div class="user-avatar">
                        <s:property value="dashboardData.currentUser.firstName.substring(0,1).toUpperCase()"/>
                    </div>
                    <span>Welcome, <s:property value="dashboardData.currentUser.firstName"/> <s:property value="dashboardData.currentUser.lastName"/></span>
                    <button class="logout-btn" onclick="location.href='logout'">Logout</button>
                </div>
            </header>
            
            <main class="main-content">
                <div class="page-header">
                    <h1 class="page-title">Dashboard</h1>
                    <p class="page-subtitle">Welcome to your admin dashboard. Here's what's happening with your business today.</p>
                </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-title">Total Users</div>
                        <div class="stat-icon users"><i class="fas fa-users"></i></div>
                    </div>
                    <div class="stat-value"><s:property value="dashboardData.totalUsers"/></div>
                    <div class="stat-change"><i class="fas fa-arrow-up"></i> +12% from last month</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-title">Active Users</div>
                        <div class="stat-icon users"><i class="fas fa-user-check"></i></div>
                    </div>
                    <div class="stat-value"><s:property value="dashboardData.activeUsers"/></div>
                    <div class="stat-change"><i class="fas fa-arrow-up"></i> +8% from last month</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-title">Total Orders</div>
                        <div class="stat-icon orders"><i class="fas fa-shopping-cart"></i></div>
                    </div>
                    <div class="stat-value"><s:property value="dashboardData.totalOrders"/></div>
                    <div class="stat-change"><i class="fas fa-arrow-up"></i> +23% from last month</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-title">Revenue</div>
                        <div class="stat-icon revenue"><i class="fas fa-dollar-sign"></i></div>
                    </div>
                    <div class="stat-value">$<s:text name="format.number"><s:param value="dashboardData.revenue"/></s:text></div>
                    <div class="stat-change"><i class="fas fa-arrow-up"></i> +15% from last month</div>
                </div>
            </div>
            
            <div class="dashboard-grid">
                <div class="chart-card">
                    <h2 class="card-title"><i class="fas fa-chart-bar"></i> Analytics Overview</h2>
                    <div style="height: 300px; display: flex; flex-direction: column; align-items: center; justify-content: center; color: #8c8c8c; background: #fafafa; border-radius: 4px;">
                        <i class="fas fa-chart-line" style="font-size: 48px; margin-bottom: 16px;"></i>
                        <div>Chart visualization would go here</div>
                        <small>Integration with Chart.js or similar library</small>
                    </div>
                </div>
                
                <div class="system-info">
                    <h2 class="card-title"><i class="fas fa-server"></i> System Information</h2>
                    
                    <div class="info-item">
                        <span class="info-label"><i class="fas fa-power-off"></i> Server Status</span>
                        <span class="info-value status-online"><s:property value="dashboardData.serverStatus"/></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label"><i class="fas fa-tachometer-alt"></i> System Load</span>
                        <div>
                            <span class="info-value"><s:property value="dashboardData.systemLoad"/>%</span>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: <s:property value="dashboardData.systemLoad"/>%"></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label"><i class="fas fa-clock"></i> Last Login</span>
                        <span class="info-value"><s:property value="dashboardData.lastLoginTime"/></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label"><i class="fas fa-user-tag"></i> User Role</span>
                        <span class="info-value"><s:property value="dashboardData.currentUser.role"/></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label"><i class="fas fa-fingerprint"></i> Session ID</span>
                        <span class="info-value" style="font-family: monospace; font-size: 12px;"><%=session.getId().substring(0, 8)%>...</span>
                    </div>
                </div>
            </div>
            </main>
        </div>
    </div>
    
    <script>
        // Sidebar toggle functionality
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            const layout = document.querySelector('.layout');
            const isMobile = window.innerWidth <= 768;
            
            if (isMobile) {
                sidebar.classList.toggle('mobile-open');
                overlay.classList.toggle('active');
            } else {
                sidebar.classList.toggle('collapsed');
                layout.classList.toggle('sidebar-collapsed');
            }
        }
        
        // Set active menu item
        function setActiveMenu(element) {
            document.querySelectorAll('.menu-item').forEach(item => {
                item.classList.remove('active');
            });
            element.classList.add('active');
        }
        
        // Handle window resize
        window.addEventListener('resize', function() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('sidebarOverlay');
            
            if (window.innerWidth > 768) {
                sidebar.classList.remove('mobile-open');
                overlay.classList.remove('active');
            }
        });
        
        // Auto-refresh dashboard data every 30 seconds
        setInterval(function() {
            // In a real application, you would use AJAX to refresh data
            // location.reload();
        }, 30000);
        
        // Add some interactivity
        document.querySelectorAll('.stat-card').forEach(card => {
            card.addEventListener('click', function() {
                // Handle stat card click
                console.log('Stat card clicked:', this.querySelector('.stat-title').textContent);
            });
        });
        
        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            const sidebar = document.getElementById('sidebar');
            const hamburger = document.querySelector('.hamburger');
            const isMobile = window.innerWidth <= 768;
            
            if (isMobile && !sidebar.contains(event.target) && !hamburger.contains(event.target)) {
                sidebar.classList.remove('mobile-open');
                document.getElementById('sidebarOverlay').classList.remove('active');
            }
        });
    </script>
</body>
</html>