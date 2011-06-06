From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 45/49] Staging: hv: vmbus: Cleanup error codes in hv.c
Date: Mon,  6 Jun 2011 15:50:09 -0700
Message-ID: <1307400613-13234-45-git-send-email-kys@microsoft.com>
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

Cleanup error codes in hv.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/hv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
index a2cc091..824f816 100644
--- a/drivers/staging/hv/hv.c
+++ b/drivers/staging/hv/hv.c
@@ -277,11 +277,11 @@ u16 hv_post_message(union hv_connection_id connection_id,
 	unsigned long addr;
 
 	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT)
-		return -1;
+		return -EMSGSIZE;
 
 	addr = (unsigned long)kmalloc(sizeof(struct aligned_input), GFP_ATOMIC);
 	if (!addr)
-		return -1;
+		return -ENOMEM;
 
 	aligned_msg = (struct hv_input_post_message *)
 			(ALIGN(addr, HV_HYPERCALL_PARAM_ALIGN));
-- 
1.7.4.1
