From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH]: Staging: hv: Cleanup vmalloc calls
Date: Fri, 11 Feb 2011 14:48:45 -0800
Message-ID: <1297464525-23254-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject says it all. There is no need to
specify different page protection bits based
on the architecture.


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
index 31b9073..2d492ad 100644
--- a/drivers/staging/hv/hv.c
+++ b/drivers/staging/hv/hv.c
@@ -230,12 +230,7 @@ int hv_init(void)
 	* Allocate the hypercall page memory
 	* virtaddr = osd_page_alloc(1);
 	*/
-#ifdef __x86_64__
 	virtaddr = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_EXEC);
-#else
-	virtaddr =  __vmalloc(PAGE_SIZE, GFP_KERNEL,
-			__pgprot(__PAGE_KERNEL & (~_PAGE_NX)));
-#endif
 
 	if (!virtaddr) {
 		DPRINT_ERR(VMBUS,
-- 
1.5.5.6
