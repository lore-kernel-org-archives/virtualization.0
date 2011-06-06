From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 41/49] Staging: hv: vmbus: Increase the timeout for some
	critical calls
Date: Mon,  6 Jun 2011 15:50:05 -0700
Message-ID: <1307400613-13234-41-git-send-email-kys@microsoft.com>
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

Increase the timeout for some critical calls. In testing we discovered that the
current timeout of 1 second was insufficient under some conditions.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/channel.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 5a2a947..69b5641 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -480,7 +480,7 @@ int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
 
 		}
 	}
-	t = wait_for_completion_timeout(&msginfo->waitevent, HZ);
+	t = wait_for_completion_timeout(&msginfo->waitevent, 5*HZ);
 	BUG_ON(t == 0);
 
 
@@ -530,7 +530,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 			       sizeof(struct vmbus_channel_gpadl_teardown));
 
 	BUG_ON(ret != 0);
-	t = wait_for_completion_timeout(&info->waitevent, HZ);
+	t = wait_for_completion_timeout(&info->waitevent, 5*HZ);
 	BUG_ON(t == 0);
 
 	/* Received a torndown response */
-- 
1.7.4.1
