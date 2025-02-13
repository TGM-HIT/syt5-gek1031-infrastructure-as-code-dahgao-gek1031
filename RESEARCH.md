
## Fragestellungen

**1. Was versteht man unter Infrastructure as Code (IaC) und welche Vorteile bietet es?**  
Infrastructure as Code (IaC) bedeutet, dass Infrastruktur (Server, Netzwerke, Cloud-Ressourcen) mithilfe von Code definiert und automatisiert bereitgestellt wird. Anstatt manuell Konfigurationen durchzuführen, werden sie in Skripten oder Konfigurationsdateien festgelegt.  
**Vorteile von IaC gegenüber manueller Konfiguration:**  
- **Automatisierung**: Infrastruktur kann schnell und konsistent bereitgestellt werden.  
- **Reproduzierbarkeit**: Gleichbleibende Umgebungen können wiederholt erzeugt werden.  
- **Versionierung**: Änderungen an der Infrastruktur können versioniert und nachverfolgt werden.  
- **Skalierbarkeit**: Automatische Skalierung und Verwaltung von Ressourcen.  
- **Konsistenz**: Reduzierung menschlicher Fehler durch standardisierte Konfigurationen.  

**2. Beispiele für IaC-Tools & warum Ansible für Configuration Management geeignet ist**  
Beispiele für IaC-Tools:  
- **Ansible** (agentenlos, deklarativ)  
- **Terraform** (für Infrastruktur-Bereitstellung, deklarativ)  
- **Puppet** (agentenbasiert, deklarativ)  
- **Chef** (agentenbasiert, eher imperativ)  
- **SaltStack** (agentenlos oder agentenbasiert, deklarativ)  

**Warum Ansible für Configuration Management geeignet ist:**  
- **Agentenlos**: Es benötigt keine extra Software auf den Zielsystemen, nur SSH oder WinRM.  
- **Deklarativ & idempotent**: Stellt sicher, dass das System in den gewünschten Zustand überführt wird, ohne unnötige Änderungen.  
- **Einfache YAML-Syntax**: Verständlich und leicht zu schreiben.  
- **Große Modulauswahl**: Zahlreiche vorgefertigte Module für verschiedene Systeme und Anwendungen.  

**3. Bedeutung von Idempotenz & Deklarativität in IaC & Ansible**  
- **Idempotenz**: Eine Operation kann mehrfach ausgeführt werden, ohne den Endzustand zu verändern. Ansible erreicht dies, indem es prüft, ob eine Änderung notwendig ist, bevor sie angewendet wird.  
- **Deklarativität**: Anstatt Anweisungen zu schreiben, wie etwas erreicht wird, beschreibt man nur den gewünschten Zustand. Ansible-Playbooks definieren z. B. „Ein Paket soll installiert sein“ anstatt „Führe apt install aus“.  

**4. Aufbau eines Ansible Playbooks & Schlüsselkomponenten**  
Ein einfaches **Ansible Playbook** könnte so aussehen:  
```yaml
- name: Beispiel-Playbook
  hosts: webserver
  become: true
  tasks:
    - name: Installiere Nginx
      apt:
        name: nginx
        state: present

    - name: Starte Nginx
      service:
        name: nginx
        state: started
      notify: Restart nginx

  handlers:
    - name: Restart nginx
      service:
        name: nginx
        state: restarted
```
**Schlüsselkomponenten:**  
- **Tasks**: Definieren einzelne Aktionen (z. B. Installationen, Konfigurationen).  
- **Modules**: Vorgefertigte Ansible-Bausteine (z. B. `apt`, `service`).  
- **Handlers**: Spezielle Tasks, die erst bei Änderungen durch `notify` ausgeführt werden.  

**5. Inventarisierung in Ansible: Statisches vs. Dynamisches Inventar**  
- **Statisches Inventar**: Eine einfache `inventory.ini`-Datei:  
  ```ini
  [webserver]
  server1 ansible_host=192.168.1.10
  ```  
- **Dynamisches Inventar**: Wird durch Skripte oder Plugins aus Cloud-Plattformen wie AWS, Azure oder Kubernetes generiert.  

**6. Ansible Roles & Wiederverwendbarkeit**  
**Roles** ermöglichen eine modulare Struktur und Wiederverwendbarkeit. Eine Role organisiert Tasks, Variablen und Templates in einem definierten Verzeichnis:  
```
roles/
  webserver/
    tasks/main.yml
    handlers/main.yml
    templates/nginx.conf.j2
    vars/main.yml
```
Dadurch können sie leicht in verschiedenen Playbooks wiederverwendet werden.  

**7. Vergleich Ansible vs. Terraform**  
- **Ansible**: Konfigurationsmanagement (Software-Installation, Dienste verwalten).  
- **Terraform**: Infrastruktur-Provisioning (Erstellen von VMs, Netzwerken, Load Balancern).  
- **Vergleichbar?** Bedingt. Terraform ist für die initiale Bereitstellung, Ansible für die Konfiguration geeignet. Beide können kombiniert werden.  

**8. Ansible in CI/CD-Pipelines (GitLab CI, Jenkins)**  
- In **GitLab CI** kann Ansible als Job genutzt werden:  
  ```yaml
  deploy:
    script:
      - ansible-playbook -i inventory.ini site.yml
  ```  
- In **Jenkins** kann Ansible über ein Plugin oder direkt als Shell-Befehl (`ansible-playbook`) ausgeführt werden.  
- Ziel: Automatisierte Bereitstellung und Konfiguration in DevOps-Pipelines.

src: chatgpt

**Ansible Concepts**: https://docs.ansible.com/ansible/latest/getting_started/basic_concepts.html
**Roles**: https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html
**Modules**: https://docs.ansible.com/ansible/2.9/user_guide/modules_intro.html

