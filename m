From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 41/77] Staging: hv: vmbus: Cleanup unnecessary comments in hv.c
Date: Thu, 16 Jun 2011 13:17:14 -0700
Message-ID: <1308255470-3826-41-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup unnecessary comments in hv.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
index 824f816..2f94880 100644
--- a/drivers/staging/hv/hv.c
+++ b/drivers/staging/hv/hv.c
@@ -164,11 +164,7 @@ int hv_init(void)
 		goto cleanup;
 
 	max_leaf = query_hypervisor_info();
-	/* HvQueryHypervisorFeatures(maxLeaf); */
 
-	/*
-	 * We only support running on top of Hyper-V
-	 */
 	rdmsrl(HV_X64_MSR_GUEST_OS_ID, hv_context.guestid);
 
 	if (hv_context.guestid != 0)
@@ -181,10 +177,6 @@ int hv_init(void)
 	/* See if the hypercall page is already set */
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
-	/*
-	* Allocate the hypercall page memory
-	* virtaddr = osd_page_alloc(1);
-	*/
 	virtaddr = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_EXEC);
 
 	if (!virtaddr)
-- 
1.7.4.1
