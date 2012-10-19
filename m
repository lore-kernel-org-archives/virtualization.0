From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/3] virtio: 9p: correctly pass physical address to
	userspace for high pages
Date: Fri, 19 Oct 2012 14:03:32 +0100
Message-ID: <1350651813-8694-2-git-send-email-will.deacon@arm.com>
References: <1350651813-8694-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350651813-8694-1-git-send-email-will.deacon@arm.com>
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
Cc: Marc.Zyngier@arm.com, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, ericvh@gmail.com, levinsasha928@gmail.com, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When using a virtio transport, the 9p net device may pass the physical
address of a kernel buffer to userspace via a scatterlist inside a
virtqueue. If the kernel buffer is mapped outside of the linear mapping
(e.g. highmem), then virt_to_page will return a bogus value and we will
populate the scatterlist with junk.

This patch uses kmap_to_page when populating the page array for a kernel
buffer.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Sasha Levin <levinsasha928@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 net/9p/trans_virtio.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 35b8911..fd05c81 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -39,6 +39,7 @@
 #include <linux/inet.h>
 #include <linux/idr.h>
 #include <linux/file.h>
+#include <linux/highmem.h>
 #include <linux/slab.h>
 #include <net/9p/9p.h>
 #include <linux/parser.h>
@@ -325,7 +326,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 		int count = nr_pages;
 		while (nr_pages) {
 			s = rest_of_page(data);
-			pages[index++] = virt_to_page(data);
+			pages[index++] = kmap_to_page(data);
 			data += s;
 			nr_pages--;
 		}
-- 
1.7.4.1
