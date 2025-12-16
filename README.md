# HRMS-Babylon

A comprehensive Human Resource Management System (HRMS) designed to streamline HR operations and employee management.

## Project Description

HRMS-Babylon is an enterprise-grade Human Resource Management System that provides a centralized platform for managing employee information, attendance, payroll, leave management, performance reviews, and other HR-related functions. The system is built with modern technologies and follows best practices for scalability, security, and user experience.

### Key Features

- **Employee Management**: Centralized employee database with complete profile management
- **Attendance Tracking**: Automated attendance and time tracking system
- **Leave Management**: Comprehensive leave request and approval workflow
- **Payroll Processing**: Automated salary calculation and payroll management
- **Performance Management**: Performance reviews and appraisal system
- **Document Management**: Secure storage and management of HR documents
- **Reporting & Analytics**: Comprehensive HR analytics and reporting dashboard
- **User Access Control**: Role-based access control (RBAC) for security

## Prerequisites

Before getting started, ensure you have the following installed:

- **Node.js** (v14.0.0 or higher)
- **npm** or **yarn** (v6.0.0 or higher)
- **Git**
- **Database**: MongoDB or PostgreSQL (depending on your configuration)

## Installation

Follow these steps to set up the HRMS-Babylon project locally:

### 1. Clone the Repository

```bash
git clone https://github.com/husseinalnidawi/hrms-babylon.git
cd hrms-babylon
```

### 2. Install Dependencies

Using npm:
```bash
npm install
```

Or using yarn:
```bash
yarn install
```

### 3. Configure Environment Variables

Create a `.env` file in the root directory and add the following environment variables:

```env
# Application
NODE_ENV=development
PORT=3000
APP_NAME=HRMS-Babylon

# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=hrms_babylon
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DATABASE_URL=postgresql://user:password@localhost:5432/hrms_babylon

# JWT Authentication
JWT_SECRET=your_secret_key_here
JWT_EXPIRATION=24h

# Email Configuration
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your_email@gmail.com
SMTP_PASSWORD=your_email_password

# Application URL
APP_URL=http://localhost:3000
```

### 4. Setup Database

Run database migrations:

```bash
npm run migrate
```

Or seed initial data:

```bash
npm run seed
```

### 5. Start the Application

For development environment:
```bash
npm run dev
```

For production environment:
```bash
npm run build
npm start
```

The application will be available at `http://localhost:3000`

## Project Structure

```
hrms-babylon/
├── src/
│   ├── controllers/       # Request handlers
│   ├── models/           # Database models
│   ├── routes/           # API routes
│   ├── middleware/       # Custom middleware
│   ├── services/         # Business logic
│   ├── utils/            # Utility functions
│   └── app.js           # Express app configuration
├── tests/                # Test files
├── config/               # Configuration files
├── migrations/           # Database migrations
├── seeds/                # Database seeds
├── public/               # Static files
├── .env.example          # Environment variables template
├── package.json          # Project dependencies
└── README.md            # This file
```

## API Documentation

For detailed API documentation, please refer to the [API Documentation](./docs/API.md) file.

## Testing

Run the test suite:

```bash
npm test
```

Run tests with coverage:

```bash
npm run test:coverage
```

## Development Guidelines

- Follow the existing code style and conventions
- Write unit tests for new features
- Ensure all tests pass before submitting pull requests
- Document your code with clear comments
- Keep commits atomic and descriptive

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Make your changes and commit: `git commit -m 'Add your feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Submit a pull request

Please ensure your code follows our style guide and includes appropriate tests.

## Troubleshooting

### Port Already in Use
If port 3000 is already in use, change the `PORT` variable in your `.env` file.

### Database Connection Error
Ensure your database server is running and the connection credentials in `.env` are correct.

### Module Not Found Errors
Run `npm install` again to ensure all dependencies are properly installed.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

## Support

For issues, questions, or suggestions, please:

- Open an issue on [GitHub Issues](https://github.com/husseinalnidawi/hrms-babylon/issues)
- Contact the development team

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for a list of changes in each version.

## Authors

- Hussein Al-Nidawi ([@husseinalnidawi](https://github.com/husseinalnidawi))

---

**Last Updated**: December 16, 2025

For more information and updates, visit our [GitHub Repository](https://github.com/husseinalnidawi/hrms-babylon)
