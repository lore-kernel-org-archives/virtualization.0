From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 31/49] Staging: hv: vmbus: Get rid of some dated comments in
	channel.c
Date: Mon,  6 Jun 2011 15:49:55 -0700
Message-ID: <1307400613-13234-31-git-send-email-kys@microsoft.com>
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

Get rid of some dated comments in channel.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/channel.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 3e4422b..95b410f 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -633,7 +633,6 @@ int vmbus_sendpacket(struct vmbus_channel *channel, const void *buffer,
 
 	ret = hv_ringbuffer_write(&channel->outbound, bufferlist, 3);
 
-	/* TODO: We should determine if this is optional */
 	if (ret == 0 && !hv_get_ringbuffer_interrupt_mask(&channel->outbound))
 		vmbus_setevent(channel);
 
@@ -695,7 +694,6 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 
 	ret = hv_ringbuffer_write(&channel->outbound, bufferlist, 3);
 
-	/* TODO: We should determine if this is optional */
 	if (ret == 0 && !hv_get_ringbuffer_interrupt_mask(&channel->outbound))
 		vmbus_setevent(channel);
 
@@ -758,7 +756,6 @@ int vmbus_sendpacket_multipagebuffer(struct vmbus_channel *channel,
 
 	ret = hv_ringbuffer_write(&channel->outbound, bufferlist, 3);
 
-	/* TODO: We should determine if this is optional */
 	if (ret == 0 && !hv_get_ringbuffer_interrupt_mask(&channel->outbound))
 		vmbus_setevent(channel);
 
-- 
1.7.4.1
