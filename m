From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 07/17] BUGFIX: avoid compile warnings
Date: Fri, 23 Jul 2010 12:34:23 +0200
Message-ID: <1279881273-10261-8-git-send-email-jens@linux.vnet.ibm.com>
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
 include/lldp_evb_clif.h |    2 +-
 lldp_evb_clif.c         |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/lldp_evb_clif.h b/include/lldp_evb_clif.h
index 43083f3..6f3ac99 100644
--- a/include/lldp_evb_clif.h
+++ b/include/lldp_evb_clif.h
@@ -28,7 +28,7 @@
 
 struct lldp_module *evb_cli_register(void);
 void evb_cli_unregister(struct lldp_module *);
-int evb_print_tlv(u32, u16, u8 *);
+int evb_print_tlv(u32, u16, char *);
 
 #define EVB_BUF_SIZE		256
 
diff --git a/lldp_evb_clif.c b/lldp_evb_clif.c
index 383b717..7479d74 100644
--- a/lldp_evb_clif.c
+++ b/lldp_evb_clif.c
@@ -169,13 +169,13 @@ void evb_print_cfg_tlv(u16 len, char *info)
 		printf("Unable to decode ccap !\n");
 	}
 
-	if (!hexstr2bin(info+8, (u16 *)&svsi, sizeof(svsi))) {
+	if (!hexstr2bin(info+8, (u8 *)&svsi, sizeof(svsi))) {
 		printf("\tno. of supported VSIs: %04i\n",svsi);
 	} else {
 		printf("Unable to decode svsi !\n");
 	}
 
-	if (!hexstr2bin(info+12, (u16 *)&cvsi, sizeof(cvsi))) {
+	if (!hexstr2bin(info+12, (u8 *)&cvsi, sizeof(cvsi))) {
 		printf("\tno. of configured VSIs: %04i\n",cvsi);
 	} else {
 		printf("Unable to decode cvsi !\n");
@@ -193,7 +193,7 @@ void evb_print_cfg_tlv(u16 len, char *info)
 /* return 1: if it printed the TLV
  *        0: if it did not
  */
-int evb_print_tlv(u32 tlvid, u16 len, u8 *info)
+int evb_print_tlv(u32 tlvid, u16 len, char *info)
 {
 	struct type_name_info *tn = &evb_tlv_names[0];
 
-- 
1.7.1
