From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [3/6] [TUN]: Fix GSO mapping
Date: Fri, 18 Apr 2008 11:17:22 +0800
Message-ID: <20080418031722.GB18071@gondor.apana.org.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<20080418031444.GA18041@gondor.apana.org.au>
	<20080418031554.GA18071@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080418031554.GA18071@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This patch avoids the correctness issue on the user-space mapping
by just copying the memory.

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 4c15dc4..d75cfd2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -62,6 +62,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_tun.h>
 #include <linux/crc32.h>
+#include <linux/highmem.h>
 #include <linux/virtio_net.h>
 #include <net/net_namespace.h>
 
@@ -257,65 +258,55 @@ static struct sk_buff *copy_user_skb(size_t align, struct iovec *iv, size_t len)
 }
 
 /* This will fail if they give us a crazy iovec, but that's their own fault. */
-static int get_user_skb_frags(const struct iovec *iv, size_t count,
-			      struct skb_frag_struct *f)
+static int get_user_skb_frags(struct iovec *iv, size_t count,
+			      struct skb_shared_info *sinfo)
 {
-	unsigned int i, j, num_pg = 0;
+	struct skb_frag_struct *f = sinfo->frags;
+	unsigned int i;
 	int err;
-	struct page *pages[MAX_SKB_FRAGS];
 
-	down_read(&current->mm->mmap_sem);
+	f->page = NULL;
+
 	for (i = 0; i < count; i++) {
-		int n, npages;
-		unsigned long base, len;
-		base = (unsigned long)iv[i].iov_base;
-		len = (unsigned long)iv[i].iov_len;
+		unsigned int len = iv[i].iov_len;
 
-		if (len == 0)
-			continue;
+		while (len) {
+			void *virt;
+			unsigned int copy;
 
-		/* How many pages will this take? */
-		npages = 1 + (base + len - 1)/PAGE_SIZE - base/PAGE_SIZE;
-		if (unlikely(num_pg + npages > MAX_SKB_FRAGS)) {
-			err = -ENOSPC;
-			goto fail;
-		}
-		n = get_user_pages(current, current->mm, base, npages,
-				   0, 0, pages, NULL);
-		if (unlikely(n < 0)) {
-			err = n;
-			goto fail;
-		}
+			if (!f->page) {
+				f->page = alloc_page(GFP_KERNEL |
+						     __GFP_HIGHMEM);
+				if (!f->page)
+					return -ENOMEM;
 
-		/* Transfer pages to the frag array */
-		for (j = 0; j < n; j++) {
-			f[num_pg].page = pages[j];
-			if (j == 0) {
-				f[num_pg].page_offset = offset_in_page(base);
-				f[num_pg].size = min(len, PAGE_SIZE -
-						     f[num_pg].page_offset);
-			} else {
-				f[num_pg].page_offset = 0;
-				f[num_pg].size = min(len, PAGE_SIZE);
+				f->page_offset = 0;
+				f->size = 0;
+				sinfo->nr_frags++;
 			}
-			len -= f[num_pg].size;
-			base += f[num_pg].size;
-			num_pg++;
-		}
 
-		if (unlikely(n != npages)) {
-			err = -EFAULT;
-			goto fail;
+			copy = PAGE_SIZE - f->size;
+			if (copy > len)
+				copy = len;
+
+			virt = kmap_atomic(f->page, KM_USER0);
+			err = memcpy_fromiovec(virt + f->size, iv, copy);
+			kunmap_atomic(virt, KM_USER0);
+
+			if (err)
+				return err;
+
+			f->size += copy;
+			if (f->size == PAGE_SIZE) {
+				if (sinfo->nr_frags >= MAX_SKB_FRAGS)
+					return -EMSGSIZE;
+				(++f)->page = NULL;
+			}
+			len -= copy;
 		}
 	}
-	up_read(&current->mm->mmap_sem);
-	return num_pg;
 
-fail:
-	for (i = 0; i < num_pg; i++)
-		put_page(f[i].page);
-	up_read(&current->mm->mmap_sem);
-	return err;
+	return 0;
 }
 
 
@@ -360,13 +351,13 @@ static struct sk_buff *map_user_skb(const struct virtio_net_hdr *gso,
 		goto fail;
 	}
 
-	err = get_user_skb_frags(iv, count, sinfo->frags);
+	err = get_user_skb_frags(iv, count, sinfo);
 	if (err < 0)
 		goto fail;
 
-	sinfo->nr_frags = err;
 	skb->len += len;
 	skb->data_len += len;
+	skb->truesize += len;
 	
 	return skb;
 
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
