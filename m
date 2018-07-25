From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] tools/virtio: add dma barrier stubs
Date: Wed, 25 Jul 2018 16:45:22 +0300
Message-ID: <20180725134057.113423-1-mst__34672.1629416153$1532526206$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, khandual@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Fixes: 55e49dc43a8 ("virtio_ring: switch to dma_XX barriers for rpmsg")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/asm/barrier.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
index 0ac3caf90877..d0351f83aebe 100644
--- a/tools/virtio/asm/barrier.h
+++ b/tools/virtio/asm/barrier.h
@@ -13,8 +13,8 @@
 } while (0);
 /* Weak barriers should be used. If not - it's a bug */
 # define mb() abort()
-# define rmb() abort()
-# define wmb() abort()
+# define dma_rmb() abort()
+# define dma_wmb() abort()
 #else
 #error Please fill in barrier macros
 #endif
-- 
MST
