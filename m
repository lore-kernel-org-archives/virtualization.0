From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 42/49] Staging: hv: vmbus: Properly handle memory allocation
	failure in channel.c
Date: Mon,  6 Jun 2011 15:50:06 -0700
Message-ID: <1307400613-13234-42-git-send-email-kys@microsoft.com>
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

Properly handle memory allocation failure in channel.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/channel.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 69b5641..1833f27 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -355,9 +355,24 @@ static int create_gpadl_header(void *kbuffer, u32 size,
 				  sizeof(struct vmbus_channel_gpadl_body) +
 				  pfncurr * sizeof(u64);
 			msgbody = kzalloc(msgsize, GFP_KERNEL);
-			/* FIXME: we probably need to more if this fails */
-			if (!msgbody)
+
+			if (!msgbody) {
+				struct vmbus_channel_msginfo *pos = NULL;
+				struct vmbus_channel_msginfo *tmp = NULL;
+				/*
+				 * Free up all the allocated messages.
+				 */
+				list_for_each_entry_safe(pos, tmp,
+					&msgheader->submsglist,
+					msglistentry) {
+
+					list_del(&pos->msglistentry);
+					kfree(pos);
+				}
+
 				goto nomem;
+			}
+
 			msgbody->msgsize = msgsize;
 			(*messagecount)++;
 			gpadl_body =
-- 
1.7.4.1
