From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 120/206] Staging: hv: Get rid of some dead code from hv.c
Date: Mon,  9 May 2011 14:56:42 -0700
Message-ID: <1304978288-22999-120-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of some commented code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv.c |   31 -------------------------------
 1 files changed, 0 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
index e6312bd..e0c2861 100644
--- a/drivers/staging/hv/hv.c
+++ b/drivers/staging/hv/hv.c
@@ -82,34 +82,7 @@ static int query_hypervisor_info(void)
 	op = HVCPUID_VENDOR_MAXFUNCTION;
 	cpuid(op, &eax, &ebx, &ecx, &edx);
 
-/*	DPRINT_INFO(VMBUS, "Vendor ID: %c%c%c%c%c%c%c%c%c%c%c%c",
-		    (ebx & 0xFF),
-		    ((ebx >> 8) & 0xFF),
-		    ((ebx >> 16) & 0xFF),
-		    ((ebx >> 24) & 0xFF),
-		    (ecx & 0xFF),
-		    ((ecx >> 8) & 0xFF),
-		    ((ecx >> 16) & 0xFF),
-		    ((ecx >> 24) & 0xFF),
-		    (edx & 0xFF),
-		    ((edx >> 8) & 0xFF),
-		    ((edx >> 16) & 0xFF),
-		    ((edx >> 24) & 0xFF));
-*/
 	max_leaf = eax;
-/*	eax = 0;
-	ebx = 0;
-	ecx = 0;
-	edx = 0;
-	op = HVCPUID_INTERFACE;
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-
-	DPRINT_INFO(VMBUS, "Interface ID: %c%c%c%c",
-		    (eax & 0xFF),
-		    ((eax >> 8) & 0xFF),
-		    ((eax >> 16) & 0xFF),
-		    ((eax >> 24) & 0xFF));
-*/
 
 	if (max_leaf >= HVCPUID_VERSION) {
 		eax = 0;
@@ -399,10 +372,6 @@ void hv_synic_init(void *irqarg)
 
 	wrmsrl(HV_X64_MSR_SIEFP, siefp.as_uint64);
 
-	/* Setup the interception SINT. */
-	/* wrmsrl((HV_X64_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX), */
-	/*	  interceptionSint.as_uint64); */
-
 	/* Setup the shared SINT. */
 	rdmsrl(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
-- 
1.7.4.1
