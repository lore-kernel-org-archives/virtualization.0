From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/8] Staging: hv: vmbus: Do not enable auto eoi
Date: Mon, 15 Aug 2011 15:12:03 -0700
Message-ID: <1313446327-10650-4-git-send-email-kys@microsoft.com>
References: <1313446210-10611-1-git-send-email-kys@microsoft.com>
 <1313446327-10650-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313446327-10650-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The standard interrupt handling in Linux issues an eoi when the
interrupt handling is done. So, setup the vmbus interrupt without
enabling auto eoi.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
index 14e6315..3b0f9f4 100644
--- a/drivers/staging/hv/hv.c
+++ b/drivers/staging/hv/hv.c
@@ -370,7 +370,7 @@ void hv_synic_init(void *irqarg)
 	shared_sint.as_uint64 = 0;
 	shared_sint.vector = irq_vector; /* HV_SHARED_SINT_IDT_VECTOR + 0x20; */
 	shared_sint.masked = false;
-	shared_sint.auto_eoi = true;
+	shared_sint.auto_eoi = false;
 
 	wrmsrl(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
-- 
1.7.4.1
