From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 039/117] Staging: hv: vmbus: Cleanup unnecessary comments in
	hv.c
Date: Fri, 15 Jul 2011 10:46:27 -0700
Message-ID: <1310752065-27895-39-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup unnecessary comments in hv.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
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
