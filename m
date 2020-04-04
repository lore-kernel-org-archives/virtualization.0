From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/6] i915/gvt: remove unused xen bits
Date: Sat,  4 Apr 2020 11:40:58 +0200
Message-ID: <20200404094101.672954-4-hch@lst.de>
References: <20200404094101.672954-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200404094101.672954-1-hch@lst.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, amd-gfx@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, linux-usb@vger.kernel.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, intel-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, intel-gvt-dev@lists.freedesktop.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

No Xen support anywhere here.  Remove a dead declaration and an unused
include.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gvt.c       | 1 -
 drivers/gpu/drm/i915/gvt/hypercall.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index 9e1787867894..c7c561237883 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -31,7 +31,6 @@
  */
 
 #include <linux/types.h>
-#include <xen/xen.h>
 #include <linux/kthread.h>
 
 #include "i915_drv.h"
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index b17c4a1599cd..b79da5124f83 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -79,6 +79,4 @@ struct intel_gvt_mpt {
 	bool (*is_valid_gfn)(unsigned long handle, unsigned long gfn);
 };
 
-extern struct intel_gvt_mpt xengt_mpt;
-
 #endif /* _GVT_HYPERCALL_H_ */
-- 
2.25.1
