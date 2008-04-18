From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [1/6] [TUN]: Add GSO support
Date: Fri, 18 Apr 2008 11:14:44 +0800
Message-ID: <20080418031444.GA18041@gondor.apana.org.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080418031257.GA17993@gondor.apana.org.au>
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

This is Rusty's GSO patch for the tun device driver.  Please
see his posting for the changelog.

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7b816a0..34a03ec 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -62,6 +62,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_tun.h>
 #include <linux/crc32.h>
+#include <linux/virtio_net.h>
 #include <net/net_namespace.h>
 
 #include <asm/system.h>
@@ -238,35 +239,188 @@ static unsigned int tun_chr_poll(struct file *file, poll_table * wait)
 	return mask;
 }
 
+static struct sk_buff *copy_user_skb(size_t align, struct iovec *iv, size_t len)
+{
+	struct sk_buff *skb;
+
+	if (!(skb = alloc_skb(len + align, GFP_KERNEL)))
+		return ERR_PTR(-ENOMEM);
+
+	if (align)
+		skb_reserve(skb, align);
+
+	if (memcpy_fromiovec(skb_put(skb, len), iv, len)) {
+		kfree_skb(skb);
+		return ERR_PTR(-EFAULT);
+	}
+	return skb;
+}
+
+/* This will fail if they give us a crazy iovec, but that's their own fault. */
+static int get_user_skb_frags(const struct iovec *iv, size_t count,
+			      struct skb_frag_struct *f)
+{
+	unsigned int i, j, num_pg = 0;
+	int err;
+	struct page *pages[MAX_SKB_FRAGS];
+
+	down_read(&current->mm->mmap_sem);
+	for (i = 0; i < count; i++) {
+		int n, npages;
+		unsigned long base, len;
+		base = (unsigned long)iv[i].iov_base;
+		len = (unsigned long)iv[i].iov_len;
+
+		if (len == 0)
+			continue;
+
+		/* How many pages will this take? */
+		npages = 1 + (base + len - 1)/PAGE_SIZE - base/PAGE_SIZE;
+		if (unlikely(num_pg + npages > MAX_SKB_FRAGS)) {
+			err = -ENOSPC;
+			goto fail;
+		}
+		n = get_user_pages(current, current->mm, base, npages,
+				   0, 0, pages, NULL);
+		if (unlikely(n < 0)) {
+			err = n;
+			goto fail;
+		}
+
+		/* Transfer pages to the frag array */
+		for (j = 0; j < n; j++) {
+			f[num_pg].page = pages[j];
+			if (j == 0) {
+				f[num_pg].page_offset = offset_in_page(base);
+				f[num_pg].size = min(len, PAGE_SIZE -
+						     f[num_pg].page_offset);
+			} else {
+				f[num_pg].page_offset = 0;
+				f[num_pg].size = min(len, PAGE_SIZE);
+			}
+			len -= f[num_pg].size;
+			base += f[num_pg].size;
+			num_pg++;
+		}
+
+		if (unlikely(n != npages)) {
+			err = -EFAULT;
+			goto fail;
+		}
+	}
+	up_read(&current->mm->mmap_sem);
+	return num_pg;
+
+fail:
+	for (i = 0; i < num_pg; i++)
+		put_page(f[i].page);
+	up_read(&current->mm->mmap_sem);
+	return err;
+}
+
+
+static struct sk_buff *map_user_skb(const struct virtio_net_hdr *gso,
+				    size_t align, struct iovec *iv,
+				    size_t count, size_t len)
+{
+	struct sk_buff *skb;
+	struct skb_shared_info *sinfo;
+	int err;
+
+	if (!(skb = alloc_skb(gso->hdr_len + align, GFP_KERNEL)))
+		return ERR_PTR(-ENOMEM);
+
+	if (align)
+		skb_reserve(skb, align);
+
+	sinfo = skb_shinfo(skb);
+	sinfo->gso_size = gso->gso_size;
+	sinfo->gso_type = SKB_GSO_DODGY;
+	switch (gso->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	case VIRTIO_NET_HDR_GSO_TCPV4:
+		sinfo->gso_type |= SKB_GSO_TCPV4;
+		break;
+	case VIRTIO_NET_HDR_GSO_TCPV6:
+		sinfo->gso_type |= SKB_GSO_TCPV6;
+		break;
+	case VIRTIO_NET_HDR_GSO_UDP:
+		sinfo->gso_type |= SKB_GSO_UDP;
+		break;
+	default:
+		err = -EINVAL;
+		goto fail;
+	}
+
+	if (gso->gso_type & VIRTIO_NET_HDR_GSO_ECN)
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+
+	/* Copy in the header. */
+	if (memcpy_fromiovec(skb_put(skb, gso->hdr_len), iv, gso->hdr_len)) {
+		err = -EFAULT;
+		goto fail;
+	}
+
+	err = get_user_skb_frags(iv, count, sinfo->frags);
+	if (err < 0)
+		goto fail;
+
+	sinfo->nr_frags = err;
+	skb->len += len;
+	skb->data_len += len;
+	
+	return skb;
+
+fail:
+	kfree_skb(skb);
+	return ERR_PTR(err);
+}
+
+static inline size_t iov_total(const struct iovec *iv, unsigned long count)
+{
+	unsigned long i;
+	size_t len;
+
+	for (i = 0, len = 0; i < count; i++)
+		len += iv[i].iov_len;
+
+	return len;
+}
+
 /* Get packet from user space buffer */
-static __inline__ ssize_t tun_get_user(struct tun_struct *tun, struct iovec *iv, size_t count)
+static __inline__ ssize_t tun_get_user(struct tun_struct *tun, struct iovec *iv, size_t num)
 {
 	struct tun_pi pi = { 0, __constant_htons(ETH_P_IP) };
+	struct virtio_net_hdr gso = { 0, VIRTIO_NET_HDR_GSO_NONE };
 	struct sk_buff *skb;
-	size_t len = count, align = 0;
+	size_t tot_len = iov_total(iv, num);
+	size_t len = tot_len, align = 0;
 
 	if (!(tun->flags & TUN_NO_PI)) {
-		if ((len -= sizeof(pi)) > count)
+		if ((len -= sizeof(pi)) > tot_len)
 			return -EINVAL;
 
 		if(memcpy_fromiovec((void *)&pi, iv, sizeof(pi)))
 			return -EFAULT;
 	}
+	if (tun->flags & TUN_VIRTIO_HDR) {
+		if ((len -= sizeof(gso)) > tot_len)
+			return -EINVAL;
+
+		if (memcpy_fromiovec((void *)&gso, iv, sizeof(gso)))
+			return -EFAULT;
+	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == TUN_TAP_DEV)
 		align = NET_IP_ALIGN;
 
-	if (!(skb = alloc_skb(len + align, GFP_KERNEL))) {
-		tun->dev->stats.rx_dropped++;
-		return -ENOMEM;
-	}
+	if (gso.gso_type != VIRTIO_NET_HDR_GSO_NONE)
+		skb = map_user_skb(&gso, align, iv, num, len);
+	else
+		skb = copy_user_skb(align, iv, len);
 
-	if (align)
-		skb_reserve(skb, align);
-	if (memcpy_fromiovec(skb_put(skb, len), iv, len)) {
+	if (IS_ERR(skb)) {
 		tun->dev->stats.rx_dropped++;
-		kfree_skb(skb);
-		return -EFAULT;
+		return PTR_ERR(skb);
 	}
 
 	switch (tun->flags & TUN_TYPE_MASK) {
@@ -280,7 +434,13 @@ static __inline__ ssize_t tun_get_user(struct tun_struct *tun, struct iovec *iv,
 		break;
 	};
 
-	if (tun->flags & TUN_NOCHECKSUM)
+	if (gso.flags & (1 << VIRTIO_NET_F_CSUM)) {
+		if (!skb_partial_csum_set(skb,gso.csum_start,gso.csum_offset)) {
+			tun->dev->stats.rx_dropped++;
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+	} else if (tun->flags & TUN_NOCHECKSUM)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 	netif_rx_ni(skb);
@@ -289,7 +449,7 @@ static __inline__ ssize_t tun_get_user(struct tun_struct *tun, struct iovec *iv,
 	tun->dev->stats.rx_packets++;
 	tun->dev->stats.rx_bytes += len;
 
-	return count;
+	return tot_len;
 }
 
 static ssize_t tun_chr_aio_write(struct kiocb *iocb, const struct iovec *iv,
@@ -302,7 +462,7 @@ static ssize_t tun_chr_aio_write(struct kiocb *iocb, const struct iovec *iv,
 
 	DBG(KERN_INFO "%s: tun_chr_write %ld\n", tun->dev->name, count);
 
-	return tun_get_user(tun, (struct iovec *) iv, iov_length(iv, count));
+	return tun_get_user(tun, (struct iovec *) iv, count);
 }
 
 /* Put packet to the user space buffer */
@@ -326,6 +486,42 @@ static __inline__ ssize_t tun_put_user(struct tun_struct *tun,
 			return -EFAULT;
 		total += sizeof(pi);
 	}
+	if (tun->flags & TUN_VIRTIO_HDR) {
+		struct virtio_net_hdr gso;
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		if (skb_is_gso(skb)) {
+			gso.hdr_len = skb_transport_header(skb) - skb->data;
+			gso.gso_size = sinfo->gso_size;
+			if (sinfo->gso_type & SKB_GSO_TCPV4)
+				gso.gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
+			else if (sinfo->gso_type & SKB_GSO_TCPV6)
+				gso.gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
+			else if (sinfo->gso_type & SKB_GSO_UDP)
+				gso.gso_type = VIRTIO_NET_HDR_GSO_UDP;
+			else
+				BUG();
+			if (sinfo->gso_type & SKB_GSO_TCP_ECN)
+				gso.gso_type |= VIRTIO_NET_HDR_GSO_ECN;
+		} else
+			gso.gso_type = VIRTIO_NET_HDR_GSO_NONE;
+		
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			gso.flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
+			gso.csum_start = skb->csum_start - skb_headroom(skb);
+			gso.csum_offset = skb->csum_offset;
+		} else {
+			gso.flags = 0;
+			gso.csum_offset = gso.csum_start = 0;
+		}
+
+		if ((len -= sizeof(gso)) < 0)
+			return -EINVAL;
+
+		if (memcpy_toiovec(iv, (void *)&gso, sizeof(gso)))
+			return -EFAULT;
+		total += sizeof(gso);
+	}
 
 	len = min_t(int, skb->len, len);
 
@@ -512,6 +708,17 @@ static int tun_set_iff(struct file *file, struct ifreq *ifr)
 
 		tun_net_init(dev);
 
+		/* Virtio header means we can handle csum & gso. */
+		if ((ifr->ifr_flags & (IFF_VIRTIO_HDR|IFF_RECV_CSUM)) ==
+		    (IFF_VIRTIO_HDR|IFF_RECV_CSUM)) {
+			dev->features = NETIF_F_SG | NETIF_F_HW_CSUM |
+					NETIF_F_HIGHDMA | NETIF_F_FRAGLIST;
+
+			if (ifr->ifr_flags & IFF_RECV_GSO)
+				dev->features |= NETIF_F_TSO | NETIF_F_UFO |
+						 NETIF_F_TSO_ECN | NETIF_F_TSO6;
+		}
+
 		if (strchr(dev->name, '%')) {
 			err = dev_alloc_name(dev, dev->name);
 			if (err < 0)
@@ -537,6 +744,21 @@ static int tun_set_iff(struct file *file, struct ifreq *ifr)
 	else
 		tun->flags &= ~TUN_ONE_QUEUE;
 
+	if (ifr->ifr_flags & IFF_VIRTIO_HDR)
+		tun->flags |= TUN_VIRTIO_HDR;
+	else
+		tun->flags &= ~TUN_VIRTIO_HDR;
+
+	if (ifr->ifr_flags & IFF_RECV_CSUM)
+		tun->flags |= TUN_RECV_CSUM;
+	else
+		tun->flags &= ~TUN_RECV_CSUM;
+
+	if (ifr->ifr_flags & IFF_RECV_GSO)
+		tun->flags |= TUN_RECV_GSO;
+	else
+		tun->flags &= ~TUN_RECV_GSO;
+
 	file->private_data = tun;
 	tun->attached = 1;
 
diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 72f1c5f..3dbef10 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -72,6 +72,9 @@ struct tun_struct {
 #define TUN_NO_PI	0x0040
 #define TUN_ONE_QUEUE	0x0080
 #define TUN_PERSIST 	0x0100	
+#define TUN_VIRTIO_HDR	0x0200
+#define TUN_RECV_CSUM	0x0400
+#define TUN_RECV_GSO	0x0400
 
 /* Ioctl defines */
 #define TUNSETNOCSUM  _IOW('T', 200, int) 
@@ -87,6 +90,9 @@ struct tun_struct {
 #define IFF_TAP		0x0002
 #define IFF_NO_PI	0x1000
 #define IFF_ONE_QUEUE	0x2000
+#define IFF_VIRTIO_HDR	0x4000
+#define IFF_RECV_CSUM	0x8000
+#define IFF_RECV_GSO	0x0800
 
 struct tun_pi {
 	unsigned short flags;

-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
