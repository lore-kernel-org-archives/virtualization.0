From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/2] Staging: hv: Zero out the request structure on allocation
Date: Wed,  6 Apr 2011 11:25:39 -0700
Message-ID: <1302114339-2198-2-git-send-email-kys@microsoft.com>
References: <1302114286-2127-1-git-send-email-kys@microsoft.com>
 <1302114339-2198-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1302114339-2198-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

As part of the cleanup of the I/O request structure, allocate them zeroed
out. This fixes a bug that was introduced in the patch-set titled:
Staging: hv: Cleanup-storage-drivers-phase-II.
A corrected version of this patch-set was sent out earlier, however
the earlier (buggy) version of this patch-set was already applied.
This patch fixes the problem.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 6128ffd..ae61735 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -738,7 +738,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 
 	request_size = sizeof(struct storvsc_cmd_request);
 
-	cmd_request = kmem_cache_alloc(host_device_ctx->request_pool,
+	cmd_request = kmem_cache_zalloc(host_device_ctx->request_pool,
 				       GFP_ATOMIC);
 	if (!cmd_request) {
 		DPRINT_ERR(STORVSC_DRV, "scmnd (%p) - unable to allocate "
-- 
1.7.4.1
