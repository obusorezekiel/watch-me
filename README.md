Here’s an updated README file that instructs users to run the `watch-me.sh` script instead of using Docker Compose:

---

# Watch Me

## Project Overview

**Watch Me** is a comprehensive monitoring and alerting system designed to help teams monitor the health and performance of their infrastructure and applications. The project leverages Prometheus for metric collection, Grafana for data visualization, cAdvisor for container resource monitoring, and Node Exporter for exposing machine metrics. The ultimate goal is to provide clear insights and timely alerts, ensuring that potential issues are identified and addressed promptly.

## Objectives

### 1. Install and Configure Prometheus, Grafana, cAdvisor, and Node Exporter

- **Prometheus:** Set up as the core metric collection tool to gather and store data from various sources.
- **Grafana:** Configured for powerful data visualization, allowing you to create and share dashboards.
- **cAdvisor:** Deployed to monitor resource usage and performance metrics of containers.
- **Node Exporter:** Installed to expose hardware and OS metrics to Prometheus.

### 2. Create and Configure Grafana Dashboards

- Develop and customize Grafana dashboards to visualize collected metrics effectively.
- Dashboards will be designed to provide insights into various aspects of system health, application performance, and resource utilization.

### 3. Set Up Alerts Based on Collected Metrics

- Configure Prometheus alerting rules to monitor critical metrics.
- Set up alerts in Grafana to notify the team of potential issues via preferred channels (e.g., email, Slack).
- Ensure that alerts are actionable and help in quick identification and resolution of problems.

### 4. Ensure Proper Data Retention and Access Control

- Implement data retention policies in Prometheus to manage storage efficiently.
- Configure access control in Grafana to ensure that only authorized users can view or modify dashboards.
- Set up backups and disaster recovery procedures to safeguard collected data.

## Getting Started

### Prerequisites

- Basic knowledge of monitoring tools and containerized environments.
- Ensure that the `watch-me.sh` script has execution permissions:
  ```bash
  chmod +x watch-me.sh
  ```

### Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/obusorezekiel/watch-me.git
   cd watch-me
   ```

2. **Run the Script:**
   ```bash
   ./watch-me.sh
   ```

3. **Access Grafana:**
   - Open your browser and navigate to `http://localhost:3000`.
   - Login with the default credentials (username: `admin`, password: `admin`), and change the password upon first login.

4. **Access Prometheus:**
   - Prometheus is accessible at `http://localhost:9090`.

### Configuration

- **Prometheus Configuration:** Customize the `prometheus.yml` file to add or modify scrape targets.
- **Grafana Dashboards:** Import pre-built dashboards or create new ones based on your monitoring needs.
- **Alerting Rules:** Define alerting rules in Prometheus or Grafana based on key metrics.

### Contributing

Contributions are welcome! Please fork this repository, make your changes, and submit a pull request. Ensure that your code adheres to the project's coding standards and is well-documented.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Contact

For any questions or support, please reach out to Ezekiel at ezekiel.umesi@gmail.com.
