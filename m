From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/2] Drivers: hv: Get rid of an unnecessary check in
 vmbus_prep_negotiate_resp()
Date: Sat, 12 May 2012 13:44:57 -0700
Message-ID: <1336855498-3981-1-git-send-email-kys@microsoft.com>
References: <1336855466-3942-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1336855466-3942-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
List-Id: virtualization@lists.linuxfoundation.org

The vmbus_prep_negotiate_resp() is only invoked when we are negotiating
the version; so the current check in vmbus_prep_negotiate_resp()
is unnecessary. Get rid of it.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/hv/channel_mgmt.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 9ffbfc5..6c8c4d3 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -56,30 +56,29 @@ struct vmbus_channel_message_table_entry {
 void vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
 			       struct icmsg_negotiate *negop, u8 *buf)
 {
-	if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-		icmsghdrp->icmsgsize = 0x10;
-
-		negop = (struct icmsg_negotiate *)&buf[
-			sizeof(struct vmbuspipe_hdr) +
-			sizeof(struct icmsg_hdr)];
-
-		if (negop->icframe_vercnt == 2 &&
-		   negop->icversion_data[1].major == 3) {
-			negop->icversion_data[0].major = 3;
-			negop->icversion_data[0].minor = 0;
-			negop->icversion_data[1].major = 3;
-			negop->icversion_data[1].minor = 0;
-		} else {
-			negop->icversion_data[0].major = 1;
-			negop->icversion_data[0].minor = 0;
-			negop->icversion_data[1].major = 1;
-			negop->icversion_data[1].minor = 0;
-		}
-
-		negop->icframe_vercnt = 1;
-		negop->icmsg_vercnt = 1;
+	icmsghdrp->icmsgsize = 0x10;
+
+	negop = (struct icmsg_negotiate *)&buf[
+		sizeof(struct vmbuspipe_hdr) +
+		sizeof(struct icmsg_hdr)];
+
+	if (negop->icframe_vercnt == 2 &&
+	   negop->icversion_data[1].major == 3) {
+		negop->icversion_data[0].major = 3;
+		negop->icversion_data[0].minor = 0;
+		negop->icversion_data[1].major = 3;
+		negop->icversion_data[1].minor = 0;
+	} else {
+		negop->icversion_data[0].major = 1;
+		negop->icversion_data[0].minor = 0;
+		negop->icversion_data[1].major = 1;
+		negop->icversion_data[1].minor = 0;
 	}
+
+	negop->icframe_vercnt = 1;
+	negop->icmsg_vercnt = 1;
 }
+
 EXPORT_SYMBOL_GPL(vmbus_prep_negotiate_resp);
 
 /*
-- 
1.7.4.1
