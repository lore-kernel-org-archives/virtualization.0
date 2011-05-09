From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 108/206] Staging: hv: Cleanup ring_buffer.h
Date: Mon,  9 May 2011 14:56:30 -0700
Message-ID: <1304978288-22999-108-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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

Access to these variables is already serialized via a spin lock. Get
rid of the unnecessary volatile qualifier.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/ring_buffer.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/ring_buffer.h b/drivers/staging/hv/ring_buffer.h
index 1bc0b8a..089c536 100644
--- a/drivers/staging/hv/ring_buffer.h
+++ b/drivers/staging/hv/ring_buffer.h
@@ -30,12 +30,12 @@
 
 struct hv_ring_buffer {
 	/* Offset in bytes from the start of ring data below */
-	volatile u32 write_index;
+	u32 write_index;
 
 	/* Offset in bytes from the start of ring data below */
-	volatile u32 read_index;
+	u32 read_index;
 
-	volatile u32 interrupt_mask;
+	u32 interrupt_mask;
 
 	/* Pad it to PAGE_SIZE so that data starts on page boundary */
 	u8	reserved[4084];
@@ -45,7 +45,6 @@ struct hv_ring_buffer {
 	 * vmbus connection also uses this data structure and its data starts
 	 * here, we commented out this field.
 	 */
-	/* volatile u32 InterruptMask; */
 
 	/*
 	 * Ring data starts here + RingDataStartOffset
-- 
1.7.4.1
