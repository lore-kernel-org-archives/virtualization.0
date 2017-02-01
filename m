From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 14/14] vmbus: replace modulus operation with subtraction
Date: Wed,  1 Feb 2017 08:29:01 -0800
Message-ID: <20170201162901.3894-15-sthemmin@microsoft.com>
References: <20170201162901.3894-1-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170201162901.3894-1-sthemmin@microsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kys@microsoft.com, gregkh@linuxfoundation.org
Cc: devel@linuxdriverproject.org, Stephen Hemminger <sthemmin@microsoft.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Takes less clock cycles to check for ring wrap and subtract than to
do a modulus instruction.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/hv/ring_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index ee3e488d9dee..8ab6298fd5ae 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -112,7 +112,8 @@ hv_get_next_readlocation_withoffset(const struct hv_ring_buffer_info *ring_info,
 	u32 next = ring_info->ring_buffer->read_index;
 
 	next += offset;
-	next %= ring_info->ring_datasize;
+	if (next >= ring_info->ring_datasize)
+		next -= ring_info->ring_datasize;
 
 	return next;
 }
@@ -156,7 +157,8 @@ static u32 hv_copyfrom_ringbuffer(
 	memcpy(dest, ring_buffer + start_read_offset, destlen);
 
 	start_read_offset += destlen;
-	start_read_offset %= ring_buffer_size;
+	if (start_read_offset >= ring_buffer_size)
+		start_read_offset -= ring_buffer_size;
 
 	return start_read_offset;
 }
@@ -178,7 +180,8 @@ static u32 hv_copyto_ringbuffer(
 	memcpy(ring_buffer + start_write_offset, src, srclen);
 
 	start_write_offset += srclen;
-	start_write_offset %= ring_buffer_size;
+	if (start_write_offset >= ring_buffer_size)
+		start_write_offset -= ring_buffer_size;
 
 	return start_write_offset;
 }
-- 
2.11.0
