From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 105/206] Staging: hv: Get rid of the forward declaration of hv_copyfrom_ringbuffer
Date: Mon,  9 May 2011 14:56:27 -0700
Message-ID: <1304978288-22999-105-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the forward declaration by moving code around.


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/ring_buffer.c |   83 +++++++++++++++++---------------------
 1 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index 8544516..56521fd 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -199,6 +199,43 @@ void hv_dump_ring_info(struct hv_ring_buffer_info *ring_info, char *prefix)
 }
 
 
+/*
+ *
+ * hv_copyfrom_ringbuffer()
+ *
+ * Helper routine to copy to source from ring buffer.
+ * Assume there is enough room. Handles wrap-around in src case only!!
+ *
+ */
+static u32 hv_copyfrom_ringbuffer(
+	struct hv_ring_buffer_info	*ring_info,
+	void				*dest,
+	u32				destlen,
+	u32				start_read_offset)
+{
+	void *ring_buffer = hv_get_ring_buffer(ring_info);
+	u32 ring_buffer_size = hv_get_ring_buffersize(ring_info);
+
+	u32 frag_len;
+
+	/* wrap-around detected at the src */
+	if (destlen > ring_buffer_size - start_read_offset) {
+		frag_len = ring_buffer_size - start_read_offset;
+
+		memcpy(dest, ring_buffer + start_read_offset, frag_len);
+		memcpy(dest + frag_len, ring_buffer, destlen - frag_len);
+	} else
+
+		memcpy(dest, ring_buffer + start_read_offset, destlen);
+
+
+	start_read_offset += destlen;
+	start_read_offset %= ring_buffer_size;
+
+	return start_read_offset;
+}
+
+
 
 static u32
 hv_copyto_ringbuffer(
@@ -207,14 +244,6 @@ hv_copyto_ringbuffer(
 	void				*src,
 	u32				srclen);
 
-static u32
-hv_copyfrom_ringbuffer(
-	struct hv_ring_buffer_info	*ring_info,
-	void				*dest,
-	u32				destlen,
-	u32				start_read_offset);
-
-
 
 /*
  *
@@ -504,41 +533,3 @@ hv_copyto_ringbuffer(
 	return start_write_offset;
 }
 
-
-/*
- *
- * hv_copyfrom_ringbuffer()
- *
- * Helper routine to copy to source from ring buffer.
- * Assume there is enough room. Handles wrap-around in src case only!!
- *
- */
-static u32
-hv_copyfrom_ringbuffer(
-	struct hv_ring_buffer_info	*ring_info,
-	void				*dest,
-	u32				destlen,
-	u32				start_read_offset)
-{
-	void *ring_buffer = hv_get_ring_buffer(ring_info);
-	u32 ring_buffer_size = hv_get_ring_buffersize(ring_info);
-
-	u32 frag_len;
-
-	/* wrap-around detected at the src */
-	if (destlen > ring_buffer_size - start_read_offset) {
-		frag_len = ring_buffer_size - start_read_offset;
-
-		memcpy(dest, ring_buffer + start_read_offset, frag_len);
-		memcpy(dest + frag_len, ring_buffer, destlen - frag_len);
-	} else
-
-		memcpy(dest, ring_buffer + start_read_offset, destlen);
-
-
-	start_read_offset += destlen;
-	start_read_offset %= ring_buffer_size;
-
-	return start_read_offset;
-}
-
-- 
1.7.4.1
