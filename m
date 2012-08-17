From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 12/14] Tools: hv: Implement the KVP verb - KVP_OP_GET_IP_INFO
Date: Thu, 16 Aug 2012 17:45:23 -0700
Message-ID: <1345164325-5198-13-git-send-email-kys@microsoft.com>
References: <1345164300-5146-1-git-send-email-kys@microsoft.com>
 <1345164325-5198-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345164325-5198-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com, ben@decadent.org.uk
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

---
 tools/hv/hv_kvp_daemon.c |   93 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index bb2a6c4..e7db9ac 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -604,6 +604,69 @@ static char *kvp_if_name_to_mac(char *if_name)
 }
 
 
+/*
+ * Retrieve the interface name given tha MAC address.
+ */
+
+static char *kvp_mac_to_if_name(char *mac)
+{
+	DIR *dir;
+	struct dirent *entry;
+	FILE    *file;
+	char    *p, *q, *x;
+	char    *if_name = NULL;
+	char    buf[256];
+	char *kvp_net_dir = "/sys/class/net/";
+	char dev_id[256];
+	int i;
+
+	dir = opendir(kvp_net_dir);
+	if (dir == NULL)
+		return NULL;
+
+	snprintf(dev_id, sizeof(dev_id), kvp_net_dir);
+	q = dev_id + strlen(kvp_net_dir);
+
+	while ((entry = readdir(dir)) != NULL) {
+		/*
+		 * Set the state for the next pass.
+		 */
+		*q = '\0';
+
+		strcat(dev_id, entry->d_name);
+		strcat(dev_id, "/address");
+
+		file = fopen(dev_id, "r");
+		if (file == NULL)
+			continue;
+
+		p = fgets(buf, sizeof(buf), file);
+		if (p) {
+			x = strchr(p, '\n');
+			if (x)
+				*x = '\0';
+
+			for (i = 0; i < strlen(p); i++)
+				p[i] = toupper(p[i]);
+
+			if (!strcmp(p, mac)) {
+				/*
+				 * Found the MAC match; return the interface
+				 * name. The caller will free the memory.
+				 */
+				if_name = strdup(entry->d_name);
+				fclose(file);
+				break;
+			}
+		}
+		fclose(file);
+	}
+
+	closedir(dir);
+	return if_name;
+}
+
+
 static void kvp_process_ipconfig_file(char *cmd,
 					char *config_buf, int len,
 					int element_size, int offset)
@@ -750,10 +813,10 @@ static int kvp_process_ip_address(void *addrp,
 	}
 
 	if ((length - *offset) < addr_length + 1)
-		return 1;
+		return HV_E_FAIL;
 	if (str == NULL) {
 		strcpy(buffer, "inet_ntop failed\n");
-		return 1;
+		return HV_E_FAIL;
 	}
 	if (*offset == 0)
 		strcpy(buffer, tmp);
@@ -797,7 +860,7 @@ kvp_get_ip_info(int family, char *if_name, int op,
 
 	if (getifaddrs(&ifap)) {
 		strcpy(buffer, "getifaddrs failed\n");
-		return 1;
+		return HV_E_FAIL;
 	}
 
 	curp = ifap;
@@ -1387,6 +1450,30 @@ int main(void)
 		}
 
 		switch (op) {
+		case KVP_OP_GET_IP_INFO:
+			kvp_ip_val = &hv_msg->body.kvp_ip_val;
+			if_name =
+			kvp_mac_to_if_name((char *)kvp_ip_val->adapter_id);
+
+			if (if_name == NULL) {
+				/*
+				 * We could not map the mac address to an
+				 * interface name; return error.
+				 */
+				hv_msg->error = HV_E_FAIL;
+				break;
+			}
+			error = kvp_get_ip_info(
+						0, if_name, KVP_OP_GET_IP_INFO,
+						kvp_ip_val,
+						(MAX_IP_ADDR_SIZE * 2));
+
+			if (error)
+				hv_msg->error = error;
+
+			free(if_name);
+			break;
+
 		case KVP_OP_SET_IP_INFO:
 			kvp_ip_val = &hv_msg->body.kvp_ip_val;
 			if_name = kvp_get_if_name(
-- 
1.7.4.1
