From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 32/54] Staging: hv: remove MIN and MAX usages
Date: Fri, 17 Jul 2009 11:09:22 -0700
Message-ID: <20090717180921.133330752@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-remove-min-and-max-usages.patch
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

The kernel has the "correct" min() and max() functions, so use those.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/include/osd.h |    3 ---
 drivers/staging/hv/storvsc_drv.c |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -67,9 +67,6 @@
 #define ALIGN_DOWN(value, align)		( (value) & ~(align-1) )
 #define NUM_PAGES_SPANNED(addr, len)	( (ALIGN_UP(addr+len, PAGE_SIZE) - ALIGN_DOWN(addr, PAGE_SIZE)) >> PAGE_SHIFT )
 
-#define MIN(a, b)       ((a) < (b)? (a): (b))
-#define MAX(a, b)       ((a) > (b)? (a): (b))
-
 #define LOWORD(dw)		((unsigned short) (dw))
 #define HIWORD(dw)		((unsigned short) (((unsigned int) (dw) >> 16) & 0xFFFF))
 
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -623,7 +623,7 @@ static unsigned int copy_to_bounce_buffe
 			dest = bounce_addr + bounce_sgl[j].length;
 			destlen = PAGE_SIZE - bounce_sgl[j].length;
 
-			copylen = MIN(srclen, destlen);
+			copylen = min(srclen, destlen);
 			memcpy((void*)dest, (void*)src, copylen);
 
 			total_copied += copylen;
@@ -698,7 +698,7 @@ static unsigned int copy_from_bounce_buf
 			src = bounce_addr + bounce_sgl[j].offset;
 			srclen = bounce_sgl[j].length - bounce_sgl[j].offset;
 
-			copylen = MIN(srclen, destlen);
+			copylen = min(srclen, destlen);
 			memcpy((void*)dest, (void*)src, copylen);
 
 			total_copied += copylen;
