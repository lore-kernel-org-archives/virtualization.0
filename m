From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC] vhost: don't use kmap() to log dirty pages
Date: Mon,  6 May 2019 22:23:29 -0400
Message-ID: <1557195809-12373-1-git-send-email-jasowang__32091.88190974$1557195828$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Andrea Arcangeli <aarcange@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Vhost log dirty pages directly to a userspace bitmap through GUP and
kmap_atomic() since kernel doesn't have a set_bit_to_user()
helper. This will cause issues for the arch that has virtually tagged
caches. The way to fix is to keep using userspace virtual address.

Fortunately, futex has a cmpxchg to userspace memory helper
futex_atomic_cmpxchg_inatomic(). So switch to use it to exchange the
userspace bitmap with zero, set the bit and then write it back through
put_user().

Note: there're archs (few non popular ones) that don't implement
futex helper, we can't log dirty pages. We can fix them on top or
simply disable LOG_ALL features of vhost.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 351af88..9c94c41 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -31,6 +31,7 @@
 #include <linux/sched/signal.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/nospec.h>
+#include <asm/futex.h>
 
 #include "vhost.h"
 
@@ -1692,25 +1693,27 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
 
-/* TODO: This is really inefficient.  We need something like get_user()
- * (instruction directly accesses the data, with an exception table entry
- * returning -EFAULT). See Documentation/x86/exception-tables.txt.
- */
-static int set_bit_to_user(int nr, void __user *addr)
+static int set_bit_to_user(int nr, u32 __user *addr)
 {
 	unsigned long log = (unsigned long)addr;
 	struct page *page;
-	void *base;
-	int bit = nr + (log % PAGE_SIZE) * 8;
+	u32 old_log;
 	int r;
 
 	r = get_user_pages_fast(log, 1, 1, &page);
 	if (r < 0)
 		return r;
 	BUG_ON(r != 1);
-	base = kmap_atomic(page);
-	set_bit(bit, base);
-	kunmap_atomic(base);
+
+	r = futex_atomic_cmpxchg_inatomic(&old_log, addr, 0, 0);
+	if (r < 0)
+		return r;
+
+	old_log |= 1 << nr;
+	r = put_user(old_log, addr);
+	if (r < 0)
+		return r;
+
 	set_page_dirty_lock(page);
 	put_page(page);
 	return 0;
@@ -1727,8 +1730,8 @@ static int log_write(void __user *log_base,
 	write_length += write_address % VHOST_PAGE_SIZE;
 	for (;;) {
 		u64 base = (u64)(unsigned long)log_base;
-		u64 log = base + write_page / 8;
-		int bit = write_page % 8;
+		u64 log = base + write_page / 32;
+		int bit = write_page % 32;
 		if ((u64)(unsigned long)log != log)
 			return -EFAULT;
 		r = set_bit_to_user(bit, (void __user *)(unsigned long)log);
-- 
1.8.3.1
