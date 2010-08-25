From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 10/10] do not use macv[tap/lan] interfaces as ports
Date: Wed, 25 Aug 2010 14:27:42 +0200
Message-ID: <1282739262-14968-11-git-send-email-jens@linux.vnet.ibm.com>
References: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: e1000-eedc@lists.sourceforge.net, virtualization@lists.linux-foundation.org, evb@yahoogroups.com
Cc: chrisw@redhat.com, Jens Osterkamp <jens@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

At startup lldpad walks through all network interfaces in the system and
creates internal data structures for them. Some interfaces as e.g. vlan
and wlan are skipped in the walkthrough, some have to be treated special
(e.g. bond devices).
This patch adds macvtap and macvlan interfaces to the list of devices that
are skipped as we do not want to send out EVB/ECP frames on them.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 config.c            |    2 +
 include/lldp_util.h |    1 +
 lldp_util.c         |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index 26afe3b..fdb63f7 100644
--- a/config.c
+++ b/config.c
@@ -365,6 +365,8 @@ void init_ports(void)
 					p->if_name);
 		} else if (is_vlan(p->if_name)) {
 			;
+		} else if (is_macvtap(p->if_name)) {
+			;
 		} else if (is_bridge(p->if_name)) {
 			; /* ignore bridge device */
 		} else if (check_link_status(p->if_name)) {
diff --git a/include/lldp_util.h b/include/lldp_util.h
index 3353067..ef2c562 100644
--- a/include/lldp_util.h
+++ b/include/lldp_util.h
@@ -40,6 +40,7 @@ int is_bridge(const char *ifname);
 int is_vlan(const char *ifname);
 int is_vlan_capable(const char *ifname);
 int is_wlan(const char *ifname);
+int is_macvtap(const char *ifname);
 int is_valid_mac(const u8 *mac);
 int is_san_mac(u8 *addr);
 int is_ether(const char *ifname);
diff --git a/lldp_util.c b/lldp_util.c
index f39fe6b..522c7ee 100644
--- a/lldp_util.c
+++ b/lldp_util.c
@@ -34,6 +34,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <net/if_arp.h>
+#include <netlink/msg.h>
 #include <arpa/inet.h>
 #include <linux/if.h>
 #include <linux/if_bonding.h>
@@ -42,6 +43,7 @@
 #include <linux/wireless.h>
 #include <linux/sockios.h>
 #include <linux/ethtool.h>
+#include <linux/rtnetlink.h>
 #include <dirent.h>
 #include "lldp.h"
 #include "lldp_util.h"
@@ -57,6 +59,8 @@ int is_valid_lldp_device(const char *device_name)
 		return 0;
 	if (is_bridge(device_name))
 		return 0;
+	if (is_macvtap(device_name))
+		return 0;
 	return 1;
 }
 
@@ -534,6 +538,88 @@ int is_wlan(const char *ifname)
 	return rc;
 }
 
+#define NLMSG_SIZE 1024
+
+static struct nla_policy ifla_info_policy[IFLA_INFO_MAX + 1] =
+{
+  [IFLA_INFO_KIND]       = { .type = NLA_STRING},
+  [IFLA_INFO_DATA]       = { .type = NLA_NESTED },
+};
+
+int is_macvtap(const char *ifname)
+{
+	int ret, s;
+	struct nlmsghdr *nlh;
+	struct ifinfomsg *ifinfo;
+	struct nlattr *tb[IFLA_MAX+1],
+		      *tb2[IFLA_INFO_MAX+1];
+
+	s = socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
+
+	if (s < 0) {
+		goto out;
+	}
+
+	nlh = malloc(NLMSG_SIZE);
+
+	if (!nlh) {
+		goto out;
+	}
+
+	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+        nlh->nlmsg_type = RTM_GETLINK;
+        nlh->nlmsg_flags = NLM_F_REQUEST;
+
+	ifinfo = NLMSG_DATA(nlh);
+	ifinfo->ifi_family = AF_UNSPEC;
+	ifinfo->ifi_index = get_ifidx(ifname);
+
+	ret = send(s, nlh, nlh->nlmsg_len, 0);
+
+	if (ret < 0) {
+		goto out;
+	}
+
+	memset(nlh, 0, NLMSG_SIZE);
+
+	do {
+		ret = recv(s, (void *) nlh, NLMSG_SIZE, MSG_DONTWAIT);
+	} while ((ret < 0) && errno == EINTR);
+
+	if (nlmsg_parse(nlh, sizeof(struct ifinfomsg),
+			(struct nlattr **)&tb, IFLA_MAX, NULL)) {
+		goto out;
+	}
+
+	if (tb[IFLA_IFNAME]) {
+		ifname = (char *)RTA_DATA(tb[IFLA_IFNAME]);
+	} else {
+		ifinfo = (struct ifinfomsg *)NLMSG_DATA(nlh);
+	}
+
+	if (tb[IFLA_LINKINFO]) {
+		if (nla_parse_nested(tb2, IFLA_INFO_MAX, tb[IFLA_LINKINFO],
+				     ifla_info_policy)) {
+			goto out;
+		}
+
+		if (tb2[IFLA_INFO_KIND]) {
+			char *kind = (char*)(RTA_DATA(tb2[IFLA_INFO_KIND]));
+			if (!(strcmp("macvtap", kind) && strcmp("macvlan", kind))) {
+				close(s);
+				return true;
+			}
+		}
+
+	} else {
+		goto out;
+	}
+
+out:
+	close(s);
+	return false;
+}
+
 int is_router(const char *ifname)
 {
 	int rc = 0;
-- 
1.7.1
