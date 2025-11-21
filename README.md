<h1>"The Complete Cloud Platform" (Capstone Project)</h1>

<h2>Combines everything: IaC, Containers, and CI/CD.</h2>

<h2>The Goal: </h2>

<h3>Deploy a highly available 2-tier web application (e.g., a Python Flask API + PostgreSQL database) to AWS or Azure completely via code.</h3>

<h2> What to do:</h2>

<ul>
<li>Infrastructure: Use Terraform to provision the VPC, Subnets, Security Groups, and EC2 instances (or EKS cluster).</li>
<li>Configuration: Use Ansible to install Docker and necessary dependencies on the servers.</li>
<li>Deployment: Use Docker Compose or Kubernetes manifests to run the app and database.</li>
<li>Automation: Create a GitHub Actions or Jenkins pipeline that builds the Docker image and deploys it whenever you push code to Git.</li>
</ul>

<h2> Resume Keywords: </h2>
<h3>Terraform, Ansible, AWS/Azure, Docker, CI/CD, Python.</h3>

<hr>

<h2> 🛠 Tech Stack </h2>

<table border="1">
<thead>
<tr>
<th>Component</th>
<th>Technology</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>App Logic</strong></td>
<td>Python (Flask)</td>
<td>Lightweight REST API.</td>
</tr>
<tr>
<td><strong>Database</strong></td>
<td>PostgreSQL</td>
<td>Relational database (Tier 2).</td>
</tr>
<tr>
<td><strong>Containerization</strong></td>
<td>Docker & Compose</td>
<td>Ensures consistency across Dev, Test, and Prod.</td>
</tr>
<tr>
<td><strong>IaC</strong></td>
<td>Terraform</td>
<td>Provisions AWS EC2, Key Pairs, and Security Groups.</td>
</tr>
<tr>
<td><strong>Config Mgmt</strong></td>
<td>Ansible</td>
<td>Installs dependencies on the raw Ubuntu server.</td>
</tr>
<tr>
<td><strong>CI/CD</strong></td>
<td>GitHub Actions</td>
<td>Automates the build and deploy process on git push.</td>
</tr>
</tbody>
</table>

<hr>

<h2> 🚀 How to Run This Project </h2>

<h3> Prerequisites </h3>

<ul>
<li>AWS CLI configured with Admin credentials.</li>
<li>Terraform installed.</li>
<li>Ansible installed.</li>
<li>Docker Hub account.</li>
</ul>

<h3> Phase 1: Local Development </h3>

<p>Run the application locally to verify logic.</p>

<pre>
cd app
docker-compose up --build

Access at http://localhost:5000

</pre>

<h3> Phase 2: Infrastructure Provisioning </h3>

<p>Provision the cloud resources using Terraform.</p>

<pre>
cd terraform
terraform init
terraform apply

Copy the 'instance_public_ip' output

</pre>

<h3> Phase 3: Configuration </h3>

<p>Configure the remote server using Ansible.</p>

<ul>
<li>Update <code>ansible/inventory</code> with the IP from Phase 2.</li>
<li>Run the playbook:</li>
</ul>

<pre>
cd ansible
ansible-playbook -i inventory playbook.yml
</pre>

<h3> Phase 4: Deployment (CI/CD) </h3>

<p>The project includes a GitHub Actions workflow (<code>.github/workflows/deploy.yml</code>).</p>

<ol>
<li>Push code to the <code>main</code> branch.</li>
<li>The pipeline will:
<ul>
<li>Build the Docker image.</li>
<li>Push to Docker Hub.</li>
<li>SSH into the EC2 instance.</li>
<li>Pull and run the new container.</li>
</ul>
</li>
</ol>

<hr>

<h2> 🔐 Secrets Management </h2>

<p>The following secrets must be set in the GitHub Repository (Settings > Secrets and variables > Actions):</p>

<ul>
<li><code>DOCKER_USERNAME</code>: Docker Hub username.</li>
<li><code>DOCKER_PASSWORD</code>: Docker Hub Access Token.</li>
<li><code>EC2_HOST</code>: Public IP of the AWS EC2 instance.</li>
<li><code>EC2_SSH_KEY</code>: Private SSH key (PEM format) generated during setup.</li>
</ul>

<hr>

<h2> 📈 Future Improvements </h2>

<ul>
<li><strong>Database Migration:</strong> Move PostgreSQL from a container to AWS RDS for managed persistence.</li>
<li><strong>Load Balancing:</strong> Introduce an Application Load Balancer (ALB) and Auto Scaling Group (ASG) for high availability.</li>
<li><strong>Monitoring:</strong> Integrate Prometheus and Grafana for metrics.</li>
</ul>

<hr>

<h2> 👤 Author </h2>

<p><strong>Alina Shvyryd</strong></p>
