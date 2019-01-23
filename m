From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Wed, 23 Jan 2019 09:08:39 -0500
Message-ID: <20190123085821-mutt-send-email-mst__36339.2356013478$1548252704$gmane$org@kernel.org>
References: <20190123095557.30168-1-jasowang@redhat.com>
	<20190123095557.30168-6-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190123095557.30168-6-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 23, 2019 at 05:55:57PM +0800, Jason Wang wrote:
> It was noticed that the copy_user() friends that was used to access
> virtqueue metdata tends to be very expensive for dataplane
> implementation like vhost since it involves lots of software checks,
> speculation barrier, hardware feature toggling (e.g SMAP). The
> extra cost will be more obvious when transferring small packets since
> the time spent on metadata accessing become more significant.
> 
> This patch tries to eliminate those overheads by accessing them
> through kernel virtual address by vmap(). To make the pages can be
> migrated, instead of pinning them through GUP, we use MMU notifiers to
> invalidate vmaps and re-establish vmaps during each round of metadata
> prefetching if necessary. For devices that doesn't use metadata
> prefetching, the memory accessors fallback to normal copy_user()
> implementation gracefully. The invalidation was synchronized with
> datapath through vq mutex, and in order to avoid hold vq mutex during
> range checking, MMU notifier was teared down when trying to modify vq
> metadata.
> 
> Another thing is kernel lacks efficient solution for tracking dirty
> pages by vmap(), this will lead issues if vhost is using file backed
> memory which needs care of writeback. This patch solves this issue by
> just skipping the vma that is file backed and fallback to normal
> copy_user() friends. This might introduce some overheads for file
> backed users but consider this use case is rare we could do
> optimizations on top.
> 
> Note that this was only done when device IOTLB is not enabled. We
> could use similar method to optimize it in the future.
> 
> Tests shows at most about 22% improvement on TX PPS when using
> virtio-user + vhost_net + xdp1 + TAP on 2.6GHz Broadwell:
> 
>         SMAP on | SMAP off
> Before: 5.0Mpps | 6.6Mpps
> After:  6.1Mpps | 7.4Mpps
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


So this is the bulk of the change.
Threee things that I need to look into
- Are there any security issues with bypassing the speculation barrier
  that is normally present after access_ok?
- How hard does the special handling for
  file backed storage make testing?
  On the one hand we could add a module parameter to
  force copy to/from user. on the other that's
  another configuration we need to support.
  But iotlb is not using vmap, so maybe that's enough
  for testing.
- How hard is it to figure out which mode uses which code.



Meanwhile, could you pls post data comparing this last patch with the
below?  This removes the speculation barrier replacing it with a
(useless but at least more lightweight) data dependency.

Thanks!


diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index bac939af8dbb..352ee7e14476 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -739,7 +739,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
 	int ret;
 
 	if (!vq->iotlb)
-		return __copy_to_user(to, from, size);
+		return copy_to_user(to, from, size);
 	else {
 		/* This function should be called after iotlb
 		 * prefetch, which means we're sure that all vq
@@ -752,7 +752,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
 				     VHOST_ADDR_USED);
 
 		if (uaddr)
-			return __copy_to_user(uaddr, from, size);
+			return copy_to_user(uaddr, from, size);
 
 		ret = translate_desc(vq, (u64)(uintptr_t)to, size, vq->iotlb_iov,
 				     ARRAY_SIZE(vq->iotlb_iov),
@@ -774,7 +774,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
 	int ret;
 
 	if (!vq->iotlb)
-		return __copy_from_user(to, from, size);
+		return copy_from_user(to, from, size);
 	else {
 		/* This function should be called after iotlb
 		 * prefetch, which means we're sure that vq
@@ -787,7 +787,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
 		struct iov_iter f;
 
 		if (uaddr)
-			return __copy_from_user(to, uaddr, size);
+			return copy_from_user(to, uaddr, size);
 
 		ret = translate_desc(vq, (u64)(uintptr_t)from, size, vq->iotlb_iov,
 				     ARRAY_SIZE(vq->iotlb_iov),
@@ -855,13 +855,13 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 ({ \
 	int ret = -EFAULT; \
 	if (!vq->iotlb) { \
-		ret = __put_user(x, ptr); \
+		ret = put_user(x, ptr); \
 	} else { \
 		__typeof__(ptr) to = \
 			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
 					  sizeof(*ptr), VHOST_ADDR_USED); \
 		if (to != NULL) \
-			ret = __put_user(x, to); \
+			ret = put_user(x, to); \
 		else \
 			ret = -EFAULT;	\
 	} \
@@ -872,14 +872,14 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 ({ \
 	int ret; \
 	if (!vq->iotlb) { \
-		ret = __get_user(x, ptr); \
+		ret = get_user(x, ptr); \
 	} else { \
 		__typeof__(ptr) from = \
 			(__typeof__(ptr)) __vhost_get_user(vq, ptr, \
 							   sizeof(*ptr), \
 							   type); \
 		if (from != NULL) \
-			ret = __get_user(x, from); \
+			ret = get_user(x, from); \
 		else \
 			ret = -EFAULT; \
 	} \
