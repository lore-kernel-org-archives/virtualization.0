From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 18/19] vhost: use batched version by default
Date: Mon, 6 Apr 2020 21:17:05 -0400
Message-ID: <20200407011612.478226-19-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

As testing shows no performance change, switch to that now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Link: https://lore.kernel.org/r/20200401183118.8334-3-eperezma@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 251 +-----------------------------------------
 drivers/vhost/vhost.h |   4 -
 2 files changed, 2 insertions(+), 253 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 56593ba6decc..6ca658c21e15 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2038,253 +2038,6 @@ static unsigned next_desc(struct vhost_virtqueue *vq, struct vring_desc *desc)
 	return next;
 }
 
-static int get_indirect(struct vhost_virtqueue *vq,
-			struct iovec iov[], unsigned int iov_size,
-			unsigned int *out_num, unsigned int *in_num,
-			struct vhost_log *log, unsigned int *log_num,
-			struct vring_desc *indirect)
-{
-	struct vring_desc desc;
-	unsigned int i = 0, count, found = 0;
-	u32 len = vhost32_to_cpu(vq, indirect->len);
-	struct iov_iter from;
-	int ret, access;
-
-	/* Sanity check */
-	if (unlikely(len % sizeof desc)) {
-		vq_err(vq, "Invalid length in indirect descriptor: "
-		       "len 0x%llx not multiple of 0x%zx\n",
-		       (unsigned long long)len,
-		       sizeof desc);
-		return -EINVAL;
-	}
-
-	ret = translate_desc(vq, vhost64_to_cpu(vq, indirect->addr), len, vq->indirect,
-			     UIO_MAXIOV, VHOST_ACCESS_RO);
-	if (unlikely(ret < 0)) {
-		if (ret != -EAGAIN)
-			vq_err(vq, "Translation failure %d in indirect.\n", ret);
-		return ret;
-	}
-	iov_iter_init(&from, READ, vq->indirect, ret, len);
-
-	/* We will use the result as an address to read from, so most
-	 * architectures only need a compiler barrier here. */
-	read_barrier_depends();
-
-	count = len / sizeof desc;
-	/* Buffers are chained via a 16 bit next field, so
-	 * we can have at most 2^16 of these. */
-	if (unlikely(count > USHRT_MAX + 1)) {
-		vq_err(vq, "Indirect buffer length too big: %d\n",
-		       indirect->len);
-		return -E2BIG;
-	}
-
-	do {
-		unsigned iov_count = *in_num + *out_num;
-		if (unlikely(++found > count)) {
-			vq_err(vq, "Loop detected: last one at %u "
-			       "indirect size %u\n",
-			       i, count);
-			return -EINVAL;
-		}
-		if (unlikely(!copy_from_iter_full(&desc, sizeof(desc), &from))) {
-			vq_err(vq, "Failed indirect descriptor: idx %d, %zx\n",
-			       i, (size_t)vhost64_to_cpu(vq, indirect->addr) + i * sizeof desc);
-			return -EINVAL;
-		}
-		if (unlikely(desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_INDIRECT))) {
-			vq_err(vq, "Nested indirect descriptor: idx %d, %zx\n",
-			       i, (size_t)vhost64_to_cpu(vq, indirect->addr) + i * sizeof desc);
-			return -EINVAL;
-		}
-
-		if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_WRITE))
-			access = VHOST_ACCESS_WO;
-		else
-			access = VHOST_ACCESS_RO;
-
-		ret = translate_desc(vq, vhost64_to_cpu(vq, desc.addr),
-				     vhost32_to_cpu(vq, desc.len), iov + iov_count,
-				     iov_size - iov_count, access);
-		if (unlikely(ret < 0)) {
-			if (ret != -EAGAIN)
-				vq_err(vq, "Translation failure %d indirect idx %d\n",
-					ret, i);
-			return ret;
-		}
-		/* If this is an input descriptor, increment that count. */
-		if (access == VHOST_ACCESS_WO) {
-			*in_num += ret;
-			if (unlikely(log && ret)) {
-				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
-				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
-				++*log_num;
-			}
-		} else {
-			/* If it's an output descriptor, they're all supposed
-			 * to come before any input descriptors. */
-			if (unlikely(*in_num)) {
-				vq_err(vq, "Indirect descriptor "
-				       "has out after in: idx %d\n", i);
-				return -EINVAL;
-			}
-			*out_num += ret;
-		}
-	} while ((i = next_desc(vq, &desc)) != -1);
-	return 0;
-}
-
-/* This looks in the virtqueue and for the first available buffer, and converts
- * it to an iovec for convenient access.  Since descriptors consist of some
- * number of output then some number of input descriptors, it's actually two
- * iovecs, but we pack them into one and note how many of each there were.
- *
- * This function returns the descriptor number found, or vq->num (which is
- * never a valid descriptor number) if none was found.  A negative code is
- * returned on error. */
-int vhost_get_vq_desc(struct vhost_virtqueue *vq,
-		      struct iovec iov[], unsigned int iov_size,
-		      unsigned int *out_num, unsigned int *in_num,
-		      struct vhost_log *log, unsigned int *log_num)
-{
-	struct vring_desc desc;
-	unsigned int i, head, found = 0;
-	u16 last_avail_idx;
-	__virtio16 avail_idx;
-	__virtio16 ring_head;
-	int ret, access;
-
-	/* Check it isn't doing very strange things with descriptor numbers. */
-	last_avail_idx = vq->last_avail_idx;
-
-	if (vq->avail_idx == vq->last_avail_idx) {
-		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
-			vq_err(vq, "Failed to access avail idx at %p\n",
-				&vq->avail->idx);
-			return -EFAULT;
-		}
-		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
-
-		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
-			vq_err(vq, "Guest moved used index from %u to %u",
-				last_avail_idx, vq->avail_idx);
-			return -EFAULT;
-		}
-
-		/* If there's nothing new since last we looked, return
-		 * invalid.
-		 */
-		if (vq->avail_idx == last_avail_idx)
-			return vq->num;
-
-		/* Only get avail ring entries after they have been
-		 * exposed by guest.
-		 */
-		smp_rmb();
-	}
-
-	/* Grab the next descriptor number they're advertising, and increment
-	 * the index we've seen. */
-	if (unlikely(vhost_get_avail_head(vq, &ring_head, last_avail_idx))) {
-		vq_err(vq, "Failed to read head: idx %d address %p\n",
-		       last_avail_idx,
-		       &vq->avail->ring[last_avail_idx % vq->num]);
-		return -EFAULT;
-	}
-
-	head = vhost16_to_cpu(vq, ring_head);
-
-	/* If their number is silly, that's an error. */
-	if (unlikely(head >= vq->num)) {
-		vq_err(vq, "Guest says index %u > %u is available",
-		       head, vq->num);
-		return -EINVAL;
-	}
-
-	/* When we start there are none of either input nor output. */
-	*out_num = *in_num = 0;
-	if (unlikely(log))
-		*log_num = 0;
-
-	i = head;
-	do {
-		unsigned iov_count = *in_num + *out_num;
-		if (unlikely(i >= vq->num)) {
-			vq_err(vq, "Desc index is %u > %u, head = %u",
-			       i, vq->num, head);
-			return -EINVAL;
-		}
-		if (unlikely(++found > vq->num)) {
-			vq_err(vq, "Loop detected: last one at %u "
-			       "vq size %u head %u\n",
-			       i, vq->num, head);
-			return -EINVAL;
-		}
-		ret = vhost_get_desc(vq, &desc, i);
-		if (unlikely(ret)) {
-			vq_err(vq, "Failed to get descriptor: idx %d addr %p\n",
-			       i, vq->desc + i);
-			return -EFAULT;
-		}
-		if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_INDIRECT)) {
-			ret = get_indirect(vq, iov, iov_size,
-					   out_num, in_num,
-					   log, log_num, &desc);
-			if (unlikely(ret < 0)) {
-				if (ret != -EAGAIN)
-					vq_err(vq, "Failure detected "
-						"in indirect descriptor at idx %d\n", i);
-				return ret;
-			}
-			continue;
-		}
-
-		if (desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_WRITE))
-			access = VHOST_ACCESS_WO;
-		else
-			access = VHOST_ACCESS_RO;
-		ret = translate_desc(vq, vhost64_to_cpu(vq, desc.addr),
-				     vhost32_to_cpu(vq, desc.len), iov + iov_count,
-				     iov_size - iov_count, access);
-		if (unlikely(ret < 0)) {
-			if (ret != -EAGAIN)
-				vq_err(vq, "Translation failure %d descriptor idx %d\n",
-					ret, i);
-			return ret;
-		}
-		if (access == VHOST_ACCESS_WO) {
-			/* If this is an input descriptor,
-			 * increment that count. */
-			*in_num += ret;
-			if (unlikely(log && ret)) {
-				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
-				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
-				++*log_num;
-			}
-		} else {
-			/* If it's an output descriptor, they're all supposed
-			 * to come before any input descriptors. */
-			if (unlikely(*in_num)) {
-				vq_err(vq, "Descriptor has out after in: "
-				       "idx %d\n", i);
-				return -EINVAL;
-			}
-			*out_num += ret;
-		}
-	} while ((i = next_desc(vq, &desc)) != -1);
-
-	/* On success, increment avail index. */
-	vq->last_avail_idx++;
-
-	/* Assume notifications from guest are disabled at this point,
-	 * if they aren't we would need to update avail_event index. */
-	BUG_ON(!(vq->used_flags & VRING_USED_F_NO_NOTIFY));
-	return head;
-}
-EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
-
 static struct vhost_desc *peek_split_desc(struct vhost_virtqueue *vq)
 {
 	BUG_ON(!vq->ndescs);
@@ -2495,7 +2248,7 @@ static int fetch_descs(struct vhost_virtqueue *vq)
  * This function returns the descriptor number found, or vq->num (which is
  * never a valid descriptor number) if none was found.  A negative code is
  * returned on error. */
-int vhost_get_vq_desc_batch(struct vhost_virtqueue *vq,
+int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 		      struct iovec iov[], unsigned int iov_size,
 		      unsigned int *out_num, unsigned int *in_num,
 		      struct vhost_log *log, unsigned int *log_num)
@@ -2570,7 +2323,7 @@ int vhost_get_vq_desc_batch(struct vhost_virtqueue *vq,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(vhost_get_vq_desc_batch);
+EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
 /* Reverse the effect of vhost_get_vq_desc. Useful for error handling. */
 void vhost_discard_vq_desc(struct vhost_virtqueue *vq, int n)
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0976a2853935..76356edee8e5 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -187,10 +187,6 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 bool vhost_vq_access_ok(struct vhost_virtqueue *vq);
 bool vhost_log_access_ok(struct vhost_dev *);
 
-int vhost_get_vq_desc_batch(struct vhost_virtqueue *,
-		      struct iovec iov[], unsigned int iov_count,
-		      unsigned int *out_num, unsigned int *in_num,
-		      struct vhost_log *log, unsigned int *log_num);
 int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct iovec iov[], unsigned int iov_count,
 		      unsigned int *out_num, unsigned int *in_num,
-- 
MST
