From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 107/206] Staging: hv: Get rid of the volatile qualifier for a variable in ring_buffer.c
Date: Mon,  9 May 2011 14:56:29 -0700
Message-ID: <1304978288-22999-107-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Access to this variable is already serialized via a spin lock. Get
rid of the unnecessary volatile qualifier.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/ring_buffer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index 2a461ddee..badf52a 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -364,7 +364,7 @@ int hv_ringbuffer_write(struct hv_ring_buffer_info *outring_info,
 	u32 totalbytes_towrite = 0;
 
 	struct scatterlist *sg;
-	volatile u32 next_write_location;
+	u32 next_write_location;
 	u64 prev_indices = 0;
 	unsigned long flags;
 
-- 
1.7.4.1
