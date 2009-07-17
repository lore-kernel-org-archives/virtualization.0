From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 34/54] Staging: hv: remove STRUCT_PACKED and STRUCT_ALIGNED
	defines
Date: Fri, 17 Jul 2009 11:09:24 -0700
Message-ID: <20090717180921.448023599@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-remove-struct_packed-and-struct_aligned-defines.patch
In-Reply-To: <20090720160025.GA20249@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Use the correct __attribute__((packed)) one if it's really needed.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/RingBuffer.h  |    2 +-
 drivers/staging/hv/include/osd.h |    3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -30,9 +30,6 @@
 //
 
 
-#define STRUCT_PACKED		__attribute__((__packed__))
-#define STRUCT_ALIGNED(x)	__attribute__((__aligned__(x)))
-
 #define UNUSED_VAR(v)		v  __attribute__((__unused__))
 
 #define ALIGN_UP(value, align)			( ((value) & (align-1))? ( ((value) + (align-1)) & ~(align-1) ): (value) )
--- a/drivers/staging/hv/RingBuffer.h
+++ b/drivers/staging/hv/RingBuffer.h
@@ -43,7 +43,7 @@ typedef struct _RING_BUFFER {
 	// volatile u32 InterruptMask;
 	// Ring data starts here + RingDataStartOffset !!! DO NOT place any fields below this !!!
     u8		Buffer[0];
-} STRUCT_PACKED RING_BUFFER;
+} __attribute__((packed)) RING_BUFFER;
 
 typedef struct _RING_BUFFER_INFO {
     RING_BUFFER*	RingBuffer;
