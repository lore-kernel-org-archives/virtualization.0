From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 04/17] BUGFIX: check in correct positions
Date: Fri, 23 Jul 2010 12:34:20 +0200
Message-ID: <1279881273-10261-5-git-send-email-jens@linux.vnet.ibm.com>
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

There was a bug in the print function for EVB TLVs that would
cause the wrong values to be printed.
This patch corrects it and adds some debug statement to evb_print_cfg_tlv.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 lldp_evb_clif.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lldp_evb_clif.c b/lldp_evb_clif.c
index d1773fe..d450f4b 100644
--- a/lldp_evb_clif.c
+++ b/lldp_evb_clif.c
@@ -108,7 +108,7 @@ void evb_print_cfg_tlv(u16 len, char *info)
 	}
 
 	if (!hexstr2bin(info, &smode, sizeof(smode))) {
-		printf("supported forwarding mode:");
+		printf("supported forwarding mode: (0x%02hhx)", smode);
 
 		if (smode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)
 			printf(" reflective relay");
@@ -122,7 +122,7 @@ void evb_print_cfg_tlv(u16 len, char *info)
 	}
 
 	if (!hexstr2bin(info+2, &scap, sizeof(scap))) {
-		printf("\tsupported capabilities:");
+		printf("\tsupported capabilities: (0x%02hhx)", scap);
 
 		if ( scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE)
 		     printf(" RTE");
@@ -141,8 +141,8 @@ void evb_print_cfg_tlv(u16 len, char *info)
 		printf("Unable to decode scap !\n");
 	}
 
-	if (!hexstr2bin(info, &cmode, sizeof(cmode))) {
-		printf("\tconfigured forwarding mode:");
+	if (!hexstr2bin(info+4, &cmode, sizeof(cmode))) {
+		printf("\tconfigured forwarding mode: (0x%02hhx)", cmode);
 
 		if (cmode & LLDP_EVB_CAPABILITY_FORWARD_RELAXEDRELAY)
 			printf(" reflective relay");
@@ -155,8 +155,8 @@ void evb_print_cfg_tlv(u16 len, char *info)
 		printf("Unable to decode cmode !\n");
 	}
 
-	if (!hexstr2bin(info+4, &ccap, sizeof(ccap))) {
-		printf("\tconfigured capabilities:");
+	if (!hexstr2bin(info+6, &ccap, sizeof(ccap))) {
+		printf("\tconfigured capabilities: (0x%02hhx)", ccap);
 
 		if ( ccap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE)
 		     printf(" RTE");
-- 
1.7.1
