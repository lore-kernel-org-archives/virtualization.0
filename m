From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 06/17] BUGFIX: agree to max of rte
Date: Fri, 23 Jul 2010 12:34:22 +0200
Message-ID: <1279881273-10261-7-git-send-email-jens@linux.vnet.ibm.com>
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

according to draft, both sides should agree on the maximum value of rte.

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 lldp_evb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lldp_evb.c b/lldp_evb.c
index c9a99bc..bce01b6 100644
--- a/lldp_evb.c
+++ b/lldp_evb.c
@@ -281,7 +281,7 @@ int evb_check_and_fill(struct evb_data *ed, struct tlv_info_evb *tie)
 	if ((tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE) &&
 	    (ed->tie->scap & LLDP_EVB_CAPABILITY_PROTOCOL_RTE) &&
 		(tie->rte > 0))
-		ed->tie->rte = MIN(ed->tie->svsi,tie->rte);
+		ed->tie->rte = MAX(ed->tie->svsi,tie->rte);
 
 	if (set_config_tlvinfo_bin(ed->ifname, TLVID_8021Qbg(LLDP_EVB_SUBTYPE),
 			       (void *)ed->tie, sizeof(struct tlv_info_evb))) {
-- 
1.7.1
