From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 34/49] Staging: hv: vmbus: Embed the state needed to close the
	channel
Date: Mon,  6 Jun 2011 15:49:58 -0700
Message-ID: <1307400613-13234-34-git-send-email-kys@microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
	<1307400613-13234-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1307400613-13234-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, embed the state needed to close the channel - so we would not have to
allocate memory in the channel close path.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/hyperv.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 93bbeab..1747a24 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -569,6 +569,11 @@ struct vmbus_channel_msginfo {
 	unsigned char msg[0];
 };
 
+struct vmbus_close_msg {
+	struct vmbus_channel_msginfo info;
+	struct vmbus_channel_close_channel msg;
+};
+
 struct vmbus_channel {
 	struct list_head listentry;
 
@@ -601,6 +606,8 @@ struct vmbus_channel {
 	spinlock_t inbound_lock;
 	struct workqueue_struct *controlwq;
 
+	struct vmbus_close_msg close_msg;
+
 	/* Channel callback are invoked in this workqueue context */
 	/* HANDLE dataWorkQueue; */
 
-- 
1.7.4.1
