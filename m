From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/77] Staging: hv: vmbus: Increase the timeout value in the
	vmbus driver
Date: Thu, 16 Jun 2011 13:16:34 -0700
Message-ID: <1308255470-3826-1-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1308255393-3785-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On some loaded windows hosts, we have discovered that the host may not 
respond to guest requests within the specified time (one second)
as evidenced by the guest timing out. Fix this problem by increasing
the timeout to 5 seconds. 

It may be useful to apply this patch to the 3.0 kernel as well.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Cc: stable <stable@kernel.org>
---
 drivers/staging/hv/channel.c      |    2 +-
 drivers/staging/hv/channel_mgmt.c |    2 +-
 drivers/staging/hv/connection.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index cffca7c..455f47a 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -211,7 +211,7 @@ int vmbus_open(struct vmbus_channel *newchannel, u32 send_ringbuffer_size,
 	if (ret != 0)
 		goto cleanup;
 
-	t = wait_for_completion_timeout(&openInfo->waitevent, HZ);
+	t = wait_for_completion_timeout(&openInfo->waitevent, 5*HZ);
 	if (t == 0) {
 		err = -ETIMEDOUT;
 		goto errorout;
diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 2d270ce..bf011f3 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -767,7 +767,7 @@ int vmbus_request_offers(void)
 		goto cleanup;
 	}
 
-	t = wait_for_completion_timeout(&msginfo->waitevent, HZ);
+	t = wait_for_completion_timeout(&msginfo->waitevent, 5*HZ);
 	if (t == 0) {
 		ret = -ETIMEDOUT;
 		goto cleanup;
diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index 7e15392..e6b4039 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -135,7 +135,7 @@ int vmbus_connect(void)
 	}
 
 	/* Wait for the connection response */
-	t =  wait_for_completion_timeout(&msginfo->waitevent, HZ);
+	t =  wait_for_completion_timeout(&msginfo->waitevent, 5*HZ);
 	if (t == 0) {
 		spin_lock_irqsave(&vmbus_connection.channelmsg_lock,
 				flags);
-- 
1.7.4.1
