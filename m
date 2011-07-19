From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/8] Staging: hv: vmbus: Fix checkpatch warnings
Date: Tue, 19 Jul 2011 11:44:21 -0700
Message-ID: <1311101065-23417-4-git-send-email-kys@microsoft.com>
References: <1311101018-23370-1-git-send-email-kys@microsoft.com>
 <1311101065-23417-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311101065-23417-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix  checkpatch warnings in hv.c

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
index e733173..14e6315 100644
--- a/drivers/staging/hv/hv.c
+++ b/drivers/staging/hv/hv.c
@@ -111,7 +111,7 @@ static u64 do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status = 0;
 	u64 input_address = (input) ? virt_to_phys(input) : 0;
 	u64 output_address = (output) ? virt_to_phys(output) : 0;
-	volatile void *hypercall_page = hv_context.hypercall_page;
+	void *hypercall_page = hv_context.hypercall_page;
 
 	__asm__ __volatile__("mov %0, %%r8" : : "r" (output_address) : "r8");
 	__asm__ __volatile__("call *%3" : "=a" (hv_status) :
@@ -132,7 +132,7 @@ static u64 do_hypercall(u64 control, void *input, void *output)
 	u64 output_address = (output) ? virt_to_phys(output) : 0;
 	u32 output_address_hi = output_address >> 32;
 	u32 output_address_lo = output_address & 0xFFFFFFFF;
-	volatile void *hypercall_page = hv_context.hypercall_page;
+	void *hypercall_page = hv_context.hypercall_page;
 
 	__asm__ __volatile__ ("call *%8" : "=d"(hv_status_hi),
 			      "=a"(hv_status_lo) : "d" (control_hi),
-- 
1.7.4.1
