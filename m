From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 106/206] Staging: hv: Get rid of the forward declaration of
	hv_copyto_ringbuffer()
Date: Mon,  9 May 2011 14:56:28 -0700
Message-ID: <1304978288-22999-106-git-send-email-kys@microsoft.com>
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

Get rid of the forward declaration by moving the code around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/ring_buffer.c |   66 +++++++++++++++----------------------
 1 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index 56521fd..2a461ddee 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -236,14 +236,37 @@ static u32 hv_copyfrom_ringbuffer(
 }
 
 
-
-static u32
-hv_copyto_ringbuffer(
+/*
+ *
+ * hv_copyto_ringbuffer()
+ *
+ * Helper routine to copy from source to ring buffer.
+ * Assume there is enough room. Handles wrap-around in dest case only!!
+ *
+ */
+static u32 hv_copyto_ringbuffer(
 	struct hv_ring_buffer_info	*ring_info,
 	u32				start_write_offset,
 	void				*src,
-	u32				srclen);
+	u32				srclen)
+{
+	void *ring_buffer = hv_get_ring_buffer(ring_info);
+	u32 ring_buffer_size = hv_get_ring_buffersize(ring_info);
+	u32 frag_len;
+
+	/* wrap-around detected! */
+	if (srclen > ring_buffer_size - start_write_offset) {
+		frag_len = ring_buffer_size - start_write_offset;
+		memcpy(ring_buffer + start_write_offset, src, frag_len);
+		memcpy(ring_buffer, src + frag_len, srclen - frag_len);
+	} else
+		memcpy(ring_buffer + start_write_offset, src, srclen);
 
+	start_write_offset += srclen;
+	start_write_offset %= ring_buffer_size;
+
+	return start_write_offset;
+}
 
 /*
  *
@@ -498,38 +521,3 @@ int hv_ringbuffer_read(struct hv_ring_buffer_info *inring_info, void *buffer,
 
 	return 0;
 }
-
-
-/*
- *
- * hv_copyto_ringbuffer()
- *
- * Helper routine to copy from source to ring buffer.
- * Assume there is enough room. Handles wrap-around in dest case only!!
- *
- */
-static u32
-hv_copyto_ringbuffer(
-	struct hv_ring_buffer_info	*ring_info,
-	u32				start_write_offset,
-	void				*src,
-	u32				srclen)
-{
-	void *ring_buffer = hv_get_ring_buffer(ring_info);
-	u32 ring_buffer_size = hv_get_ring_buffersize(ring_info);
-	u32 frag_len;
-
-	/* wrap-around detected! */
-	if (srclen > ring_buffer_size - start_write_offset) {
-		frag_len = ring_buffer_size - start_write_offset;
-		memcpy(ring_buffer + start_write_offset, src, frag_len);
-		memcpy(ring_buffer, src + frag_len, srclen - frag_len);
-	} else
-		memcpy(ring_buffer + start_write_offset, src, srclen);
-
-	start_write_offset += srclen;
-	start_write_offset %= ring_buffer_size;
-
-	return start_write_offset;
-}
-
-- 
1.7.4.1
