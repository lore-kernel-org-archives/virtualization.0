From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 08/17] BUGFIX: fix formatting in include/lldp_evb_clif.h
Date: Fri, 23 Jul 2010 12:34:24 +0200
Message-ID: <1279881273-10261-9-git-send-email-jens@linux.vnet.ibm.com>
References: <1279881273-10261-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1279881273-10261-1-git-send-email-jens@linux.vnet.ibm.com>
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

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 include/lldp_evb_clif.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/lldp_evb_clif.h b/include/lldp_evb_clif.h
index 6f3ac99..3b4b21e 100644
--- a/include/lldp_evb_clif.h
+++ b/include/lldp_evb_clif.h
@@ -30,20 +30,20 @@ struct lldp_module *evb_cli_register(void);
 void evb_cli_unregister(struct lldp_module *);
 int evb_print_tlv(u32, u16, char *);
 
-#define EVB_BUF_SIZE		256
+#define EVB_BUF_SIZE			256
 
-#define ARG_EVB_FORWARDING_MODE	"fmode"
+#define ARG_EVB_FORWARDING_MODE		"fmode"
 
 #define VAL_EVB_FMODE_BRIDGE		"bridge"
 #define VAL_EVB_FMODE_REFLECTIVE_RELAY	"reflectiverelay"
 
-#define ARG_EVB_CAPABILITIES	"capabilities"
+#define ARG_EVB_CAPABILITIES		"capabilities"
 
 #define VAL_EVB_CAPA_RTE		"rte"
 #define VAL_EVB_CAPA_ECP		"ecp"
 #define VAL_EVB_CAPA_VDP		"vdp"
 
-#define ARG_EVB_VSIS		"vsis"
+#define ARG_EVB_VSIS			"vsis"
 
 #define ARG_EVB_RTE			"rte"
 
-- 
1.7.1
