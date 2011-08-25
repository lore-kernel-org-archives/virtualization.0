From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 25/59] Staging: hv: vmbus: Cleanup error handling in hv_init()
Date: Thu, 25 Aug 2011 09:48:51 -0700
Message-ID: <1314290965-2698-25-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use standard Linux error codes.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
index d2b921b..736794e 100644
--- a/drivers/staging/hv/hv.c
+++ b/drivers/staging/hv/hv.c
@@ -151,7 +151,6 @@ static u64 do_hypercall(u64 control, void *input, void *output)
  */
 int hv_init(void)
 {
-	int ret = 0;
 	int max_leaf;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	void *virtaddr = NULL;
@@ -214,7 +213,7 @@ int hv_init(void)
 	hv_context.signal_event_param->flag_number = 0;
 	hv_context.signal_event_param->rsvdz = 0;
 
-	return ret;
+	return 0;
 
 cleanup:
 	if (virtaddr) {
@@ -225,8 +224,8 @@ cleanup:
 
 		vfree(virtaddr);
 	}
-	ret = -1;
-	return ret;
+
+	return -ENOTSUPP;
 }
 
 /*
-- 
1.7.4.1
