From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 1/3] mm: highmem: export kmap_to_page for modules
Date: Fri, 19 Oct 2012 14:03:31 +0100
Message-ID: <1350651813-8694-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

Some virtio device drivers (9p) need to translate high virtual addresses
to physical addresses, which are inserted into the virtqueue for
processing by userspace.

This patch exports the kmap_to_page symbol, so that the affected drivers
can be compiled as modules.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 mm/highmem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index d517cd1..2a07f97 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -105,6 +105,7 @@ struct page *kmap_to_page(void *vaddr)
 
 	return virt_to_page(addr);
 }
+EXPORT_SYMBOL(kmap_to_page);
 
 static void flush_all_zero_pkmaps(void)
 {
-- 
1.7.4.1
