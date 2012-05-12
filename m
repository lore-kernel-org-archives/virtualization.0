From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/2] Drivers: hv: util: Properly handle version negotiations.
Date: Sat, 12 May 2012 13:44:58 -0700
Message-ID: <1336855498-3981-2-git-send-email-kys@microsoft.com>
References: <1336855466-3942-1-git-send-email-kys@microsoft.com>
 <1336855498-3981-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1336855498-3981-1-git-send-email-kys@microsoft.com>
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

The current version negotiation code is not "future proof". Fix this
by allowing each service the flexibility to either specify the highest
version it can support or it can support the highest version number
the host is offering.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/hv/channel_mgmt.c |   54 +++++++++++++++++++++++++++++++-------------
 drivers/hv/hv_kvp.c       |    3 +-
 drivers/hv/hv_util.c      |    9 +++++--
 include/linux/hyperv.h    |    4 ++-
 4 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 6c8c4d3..2b8b8d4 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -46,37 +46,59 @@ struct vmbus_channel_message_table_entry {
  *
  * @icmsghdrp is of type &struct icmsg_hdr.
  * @negop is of type &struct icmsg_negotiate.
- * Set up and fill in default negotiate response message. This response can
- * come from both the vmbus driver and the hv_utils driver. The current api
- * will respond properly to both Windows 2008 and Windows 2008-R2 operating
- * systems.
+ * Set up and fill in default negotiate response message.
+ *
+ * The max_fw_version specifies the maximum framework version that
+ * we can support and max _srv_version specifies the maximum service
+ * version we can support. A special value MAX_SRV_VER can be
+ * specified to indicate that we can handle the maximum version
+ * exposed by the host.
  *
  * Mainly used by Hyper-V drivers.
  */
 void vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
-			       struct icmsg_negotiate *negop, u8 *buf)
+				struct icmsg_negotiate *negop, u8 *buf,
+				int max_fw_version, int max_srv_version)
 {
+	int icframe_vercnt;
+	int icmsg_vercnt;
+	int i;
+
 	icmsghdrp->icmsgsize = 0x10;
 
 	negop = (struct icmsg_negotiate *)&buf[
 		sizeof(struct vmbuspipe_hdr) +
 		sizeof(struct icmsg_hdr)];
 
-	if (negop->icframe_vercnt == 2 &&
-	   negop->icversion_data[1].major == 3) {
-		negop->icversion_data[0].major = 3;
-		negop->icversion_data[0].minor = 0;
-		negop->icversion_data[1].major = 3;
-		negop->icversion_data[1].minor = 0;
-	} else {
-		negop->icversion_data[0].major = 1;
-		negop->icversion_data[0].minor = 0;
-		negop->icversion_data[1].major = 1;
-		negop->icversion_data[1].minor = 0;
+	icframe_vercnt = negop->icframe_vercnt;
+	icmsg_vercnt = negop->icmsg_vercnt;
+
+	/*
+	 * Select the framework version number we will
+	 * support.
+	 */
+
+	for (i = 0; i < negop->icframe_vercnt; i++) {
+		if (negop->icversion_data[i].major <= max_fw_version)
+			icframe_vercnt = negop->icversion_data[i].major;
+	}
+
+	for (i = negop->icframe_vercnt;
+		 (i < negop->icframe_vercnt + negop->icmsg_vercnt); i++) {
+		if (negop->icversion_data[i].major <= max_srv_version)
+			icmsg_vercnt = negop->icversion_data[i].major;
 	}
 
+	/*
+	 * Respond with the maximum framework and service
+	 * version numbers we can support.
+	 */
 	negop->icframe_vercnt = 1;
 	negop->icmsg_vercnt = 1;
+	negop->icversion_data[0].major = icframe_vercnt;
+	negop->icversion_data[0].minor = 0;
+	negop->icversion_data[1].major = icmsg_vercnt;
+	negop->icversion_data[1].minor = 0;
 }
 
 EXPORT_SYMBOL_GPL(vmbus_prep_negotiate_resp);
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 6186025..0012eed 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -394,7 +394,8 @@ void hv_kvp_onchannelcallback(void *context)
 			sizeof(struct vmbuspipe_hdr)];
 
 		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-			vmbus_prep_negotiate_resp(icmsghdrp, negop, recv_buffer);
+			vmbus_prep_negotiate_resp(icmsghdrp, negop,
+				 recv_buffer, MAX_SRV_VER, MAX_SRV_VER);
 		} else {
 			kvp_msg = (struct hv_kvp_msg *)&recv_buffer[
 				sizeof(struct vmbuspipe_hdr) +
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index dbb8b8e..d3ac6a4 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -70,7 +70,8 @@ static void shutdown_onchannelcallback(void *context)
 			sizeof(struct vmbuspipe_hdr)];
 
 		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-			vmbus_prep_negotiate_resp(icmsghdrp, negop, shut_txf_buf);
+			vmbus_prep_negotiate_resp(icmsghdrp, negop,
+					shut_txf_buf, MAX_SRV_VER, MAX_SRV_VER);
 		} else {
 			shutdown_msg =
 				(struct shutdown_msg_data *)&shut_txf_buf[
@@ -195,7 +196,8 @@ static void timesync_onchannelcallback(void *context)
 				sizeof(struct vmbuspipe_hdr)];
 
 		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-			vmbus_prep_negotiate_resp(icmsghdrp, NULL, time_txf_buf);
+			vmbus_prep_negotiate_resp(icmsghdrp, NULL, time_txf_buf,
+						MAX_SRV_VER, MAX_SRV_VER);
 		} else {
 			timedatap = (struct ictimesync_data *)&time_txf_buf[
 				sizeof(struct vmbuspipe_hdr) +
@@ -234,7 +236,8 @@ static void heartbeat_onchannelcallback(void *context)
 				sizeof(struct vmbuspipe_hdr)];
 
 		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-			vmbus_prep_negotiate_resp(icmsghdrp, NULL, hbeat_txf_buf);
+			vmbus_prep_negotiate_resp(icmsghdrp, NULL,
+				hbeat_txf_buf, MAX_SRV_VER, MAX_SRV_VER);
 		} else {
 			heartbeat_msg =
 				(struct heartbeat_msg_data *)&hbeat_txf_buf[
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 6af8738..68ed7f7 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1062,8 +1062,10 @@ struct hyperv_service_callback {
 	void (*callback) (void *context);
 };
 
+#define MAX_SRV_VER	0x7ffffff
 extern void vmbus_prep_negotiate_resp(struct icmsg_hdr *,
-				      struct icmsg_negotiate *, u8 *);
+					struct icmsg_negotiate *, u8 *, int,
+					int);
 
 int hv_kvp_init(struct hv_util_service *);
 void hv_kvp_deinit(void);
-- 
1.7.4.1
