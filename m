From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Tue, 22 Jan 2013 17:43:12 +1030
Message-ID: <874ni9herb.fsf@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<20130117112314.GA15504@redhat.com>
	<877gn7w9fc.fsf@rustcorp.com.au> <87r4levjmk.fsf@rustcorp.com.au>
	<20130121122431.GB3969@redhat.com> <87k3r6uotw.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k3r6uotw.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> writes:
> I'll create some patches and see if it's too ugly to live...

Hmm, with rough userspace testing I managed to get the speed penalty
pretty low.

Here are the two patches, inline:

vringh: handle case where data goes across multiple ranges.

QEMU seems to only use separate memory ranges for ROM vs RAM, but in theory
a single scatterlist element referred to by a vring could cross two ranges,
and thus need to be split into two separate iovec entries.

This causes no measurable slowdown:

Before: (average of 20 runs)
	./vringh_test --indirect --eventidx --parallel
	real	0m3.236s

After: (average of 20 runs)
	./vringh_test --indirect --eventidx --parallel
	real	0m3.223s

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 2ba087d..50d37a7 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -91,33 +91,37 @@ static inline ssize_t vringh_iov_xfer(struct vringh_kiov *iov,
 	return done;
 }
 
-static inline bool check_range(u64 addr, u32 len,
+/* May reduce *len if range is shorter. */
+static inline bool check_range(u64 addr, u32 *len,
 			       struct vringh_range *range,
 			       bool (*getrange)(u64, struct vringh_range *))
 {
 	if (addr < range->start || addr > range->end_incl) {
 		if (!getrange(addr, range))
-			goto bad;
+			return false;
 	}
 	BUG_ON(addr < range->start || addr > range->end_incl);
 
 	/* To end of memory? */
-	if (unlikely(addr + len == 0)) {
+	if (unlikely(addr + *len == 0)) {
 		if (range->end_incl == -1ULL)
 			return true;
-		goto bad;
+		goto truncate;
 	}
 
 	/* Otherwise, don't wrap. */
-	if (unlikely(addr + len < addr))
-		goto bad;
-	if (unlikely(addr + len - 1 > range->end_incl))
-		goto bad;
+	if (addr + *len < addr) {
+		vringh_bad("Wrapping descriptor %u@0x%llx", *len, addr);
+		return false;
+	}
+
+	if (unlikely(addr + *len - 1 > range->end_incl))
+		goto truncate;
 	return true;
 
-bad:
-	vringh_bad("Malformed descriptor address %u@0x%llx", len, addr);
-	return false;
+truncate:
+	*len = range->end_incl + 1 - addr;
+	return true;
 }
 
 /* No reason for this code to be inline. */
@@ -205,19 +209,30 @@ __vringh_iov(struct vringh *vrh, u16 i,
 	for (;;) {
 		void *addr;
 		struct vringh_kiov *iov;
+		u32 len;
 
 		err = getdesc(&desc, &descs[i]);
 		if (unlikely(err))
 			goto fail;
 
-		/* Make sure it's OK, and get offset. */
-		if (!check_range(desc.addr, desc.len, &range, getrange)) {
-			err = -EINVAL;
-			goto fail;
-		}
-		addr = (void *)(long)desc.addr + range.offset;
-
 		if (unlikely(desc.flags & VRING_DESC_F_INDIRECT)) {
+			/* Make sure it's OK, and get offset. */
+			len = desc.len;
+			if (!check_range(desc.addr, &len, &range, getrange)) {
+				err = -EINVAL;
+				goto fail;
+			}
+
+			if (len != desc.len) {
+				vringh_bad("Indirect descriptor table across"
+					   " ranges: %u@%#llx vs %#llx-%#llx",
+					   desc.len, desc.addr, range.start,
+					   range.end_incl);
+				err = -EINVAL;
+				goto fail;
+			}
+			addr = (void *)(long)(desc.addr + range.offset);
+
 			err = move_to_indirect(&up_next, &i, addr, &desc,
 					       &descs, &desc_max);
 			if (err)
@@ -243,6 +258,15 @@ __vringh_iov(struct vringh *vrh, u16 i,
 			}
 		}
 
+	again:
+		/* Make sure it's OK, and get offset. */
+		len = desc.len;
+		if (!check_range(desc.addr, &len, &range, getrange)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		addr = (void *)(unsigned long)(desc.addr + range.offset);
+
 		if (unlikely(iov->i == iov->max)) {
 			err = resize_iovec(iov, gfp);
 			if (err)
@@ -250,9 +274,15 @@ __vringh_iov(struct vringh *vrh, u16 i,
 		}
 
 		iov->iov[iov->i].iov_base = addr;
-		iov->iov[iov->i].iov_len = desc.len;
+		iov->iov[iov->i].iov_len = len;
 		iov->i++;
 
+		if (unlikely(len != desc.len)) {
+			desc.len -= len;
+			desc.addr += len;
+			goto again;
+		}
+
 		if (desc.flags & VRING_DESC_F_NEXT) {
 			i = desc.next;
 		} else {

vringh: handle case where indirect descriptors go across multiple ranges.

If a data segment can go across multiple ranges, so can an indirect
descriptor table.  This is nastier, so we explicitly slowpath this.

This slows things down a little though.

Before: (average of 20 runs)
	./vringh_test --indirect --eventidx --parallel
	real	0m3.217s

After: (average of 20 runs)
	./vringh_test --indirect --eventidx --parallel
	real	0m3.364s

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 50d37a7..5dbf4b1 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -188,17 +188,46 @@ static u16 __cold return_from_indirect(const struct vringh *vrh, int *up_next,
 	return i;
 }
 
+static int slow_copy(void *dst, const void *src,
+		     bool (*getrange)(u64 addr, struct vringh_range *r),
+		     struct vringh_range *range,
+		     int (*copy)(void *dst, const void *src, size_t len))
+{
+	size_t part, len = sizeof(struct vring_desc);
+
+	do {
+		u64 addr;
+		int err;
+
+		part = len;
+		addr = (u64)(unsigned long)src - range->offset;
+
+		if (!check_range(addr, &part, range, getrange))
+			return -EINVAL;
+
+		err = copy(dst, src, part);
+		if (err)
+			return err;
+
+		dst += part;
+		src += part;
+		len -= part;
+	} while (len);
+	return 0;
+}
+
 static inline int
 __vringh_iov(struct vringh *vrh, u16 i,
 	     struct vringh_kiov *riov,
 	     struct vringh_kiov *wiov,
 	     bool (*getrange)(u64 addr, struct vringh_range *r),
 	     gfp_t gfp,
-	     int (*getdesc)(struct vring_desc *dst, const struct vring_desc *s))
+	     int (*copy)(void *dst, const void *src, size_t len))
 {
 	int err, count = 0, up_next, desc_max;
 	struct vring_desc desc, *descs;
-	struct vringh_range range = { -1ULL, 0 };
+	struct vringh_range range = { -1ULL, 0 }, slowrange;
+	bool slow = false;
 
 	/* We start traversing vring's descriptor table. */
 	descs = vrh->vring.desc;
@@ -211,7 +240,11 @@ __vringh_iov(struct vringh *vrh, u16 i,
 		struct vringh_kiov *iov;
 		u32 len;
 
-		err = getdesc(&desc, &descs[i]);
+		if (unlikely(slow))
+			err = slow_copy(&desc, &descs[i], getrange, &slowrange,
+					copy);
+		else
+			err = copy(&desc, &descs[i], sizeof(desc));
 		if (unlikely(err))
 			goto fail;
 
@@ -223,16 +256,13 @@ __vringh_iov(struct vringh *vrh, u16 i,
 				goto fail;
 			}
 
-			if (len != desc.len) {
-				vringh_bad("Indirect descriptor table across"
-					   " ranges: %u@%#llx vs %#llx-%#llx",
-					   desc.len, desc.addr, range.start,
-					   range.end_incl);
-				err = -EINVAL;
-				goto fail;
+			if (unlikely(len != desc.len)) {
+				slow = true;
+				/* We need to save this range to use offset */
+				slowrange = range;
 			}
-			addr = (void *)(long)(desc.addr + range.offset);
 
+			addr = (void *)(long)(desc.addr + range.offset);
 			err = move_to_indirect(&up_next, &i, addr, &desc,
 					       &descs, &desc_max);
 			if (err)
@@ -287,10 +317,11 @@ __vringh_iov(struct vringh *vrh, u16 i,
 			i = desc.next;
 		} else {
 			/* Just in case we need to finish traversing above. */
-			if (unlikely(up_next > 0))
+			if (unlikely(up_next > 0)) {
 				i = return_from_indirect(vrh, &up_next,
 							 &descs, &desc_max);
-			else
+				slow = false;
+			} else
 				break;
 		}
 
@@ -479,10 +510,9 @@ static inline int putu16_user(u16 *p, u16 val)
 	return put_user(val, (__force u16 __user *)p);
 }
 
-static inline int getdesc_user(struct vring_desc *dst,
-			       const struct vring_desc *src)
+static inline int copydesc_user(void *dst, const void *src, size_t len)
 {
-	return copy_from_user(dst, (__force void __user *)src, sizeof(*dst)) ?
+	return copy_from_user(dst, (__force void __user *)src, len) ?
 		-EFAULT : 0;
 }
 
@@ -597,7 +627,7 @@ int vringh_getdesc_user(struct vringh *vrh,
 	*head = err;
 	err = __vringh_iov(vrh, *head, (struct vringh_kiov *)riov,
 			   (struct vringh_kiov *)wiov,
-			   getrange, gfp, getdesc_user);
+			   getrange, gfp, copydesc_user);
 	if (err)
 		return err;
 
@@ -711,10 +741,9 @@ static inline int putu16_kern(u16 *p, u16 val)
 	return 0;
 }
 
-static inline int getdesc_kern(struct vring_desc *dst,
-			       const struct vring_desc *src)
+static inline int copydesc_kern(void *dst, const void *src, size_t len)
 {
-	*dst = *src;
+	memcpy(dst, src, len);
 	return 0;
 }
 
@@ -806,7 +835,7 @@ int vringh_getdesc_kern(struct vringh *vrh,
 
 	*head = err;
 	err = __vringh_iov(vrh, *head, riov, wiov, noop_getrange,
-			   gfp, getdesc_kern);
+			   gfp, copydesc_kern);
 	if (err)
 		return err;
 
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 01ccaed..bc74c41 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -30,14 +30,33 @@ static void never_callback_guest(struct virtqueue *vq)
 	abort();
 }
 
-static inline bool getrange_iov(u64 addr, struct vringh_range *r)
+static bool getrange_iov(u64 addr, struct vringh_range *r)
 {
+	if (addr < (u64)(unsigned long)__user_addr_min - user_addr_offset)
+		return false;
+	if (addr >= (u64)(unsigned long)__user_addr_max - user_addr_offset)
+		return false;
+
 	r->start = (u64)(unsigned long)__user_addr_min - user_addr_offset;
 	r->end_incl = (u64)(unsigned long)__user_addr_max - 1 - user_addr_offset;
 	r->offset = user_addr_offset;
 	return true;
 }
 
+/* We return single byte ranges. */
+static bool getrange_slow(u64 addr, struct vringh_range *r)
+{
+	if (addr < (u64)(unsigned long)__user_addr_min - user_addr_offset)
+		return false;
+	if (addr >= (u64)(unsigned long)__user_addr_max - user_addr_offset)
+		return false;
+
+	r->start = addr;
+	r->end_incl = r->start;
+	r->offset = user_addr_offset;
+	return true;
+}
+
 struct guest_virtio_device {
 	struct virtio_device vdev;
 	int to_host_fd;
@@ -75,7 +94,8 @@ static void find_cpus(unsigned int *first, unsigned int *last)
 	}
 }
 
-static int parallel_test(unsigned long features)
+static int parallel_test(unsigned long features,
+			 bool (*getrange)(u64 addr, struct vringh_range *r))
 {
 	void *host_map, *guest_map;
 	int fd, mapsize, to_guest[2], to_host[2];
@@ -144,7 +164,7 @@ static int parallel_test(unsigned long features)
 			wiov.max = ARRAY_SIZE(host_wiov);
 			wiov.allocated = false;
 
-			err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+			err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange,
 						  &head, GFP_KERNEL);
 			if (err == 0) {
 				char buf[128];
@@ -349,6 +369,7 @@ int main(int argc, char *argv[])
 	int err;
 	unsigned i;
 	void *ret;
+	bool (*getrange)(u64 addr, struct vringh_range *r) = getrange_iov;
 
 	vdev.features[0] = 0;
 
@@ -362,8 +383,13 @@ int main(int argc, char *argv[])
 		argv++;
 	}
 
+	if (argv[1] && strcmp(argv[1], "--slow") == 0) {
+		getrange = getrange_slow;
+		argv++;
+	}
+
 	if (argv[1] && strcmp(argv[1], "--parallel") == 0)
-		return parallel_test(vdev.features[0]);
+		return parallel_test(vdev.features[0], getrange);
 
 	if (posix_memalign(&__user_addr_min, PAGE_SIZE, USER_MEM) != 0)
 		abort();
@@ -382,7 +408,7 @@ int main(int argc, char *argv[])
 			 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
 
 	/* No descriptor to get yet... */
-	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange,
 				  &head, GFP_KERNEL);
 	if (err != 0)
 		errx(1, "vringh_getdesc_user: %i", err);
@@ -410,7 +436,7 @@ int main(int argc, char *argv[])
 	wiov.max = ARRAY_SIZE(host_wiov);
 	wiov.allocated = false;
 
-	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange,
 				  &head, GFP_KERNEL);
 	if (err != 1)
 		errx(1, "vringh_getdesc_user: %i", err);
@@ -418,9 +444,17 @@ int main(int argc, char *argv[])
 	assert(riov.max == 1);
 	assert(riov.iov[0].iov_base == __user_addr_max - 1);
 	assert(riov.iov[0].iov_len == 1);
-	assert(wiov.max == 1);
-	assert(wiov.iov[0].iov_base == __user_addr_max - 3);
-	assert(wiov.iov[0].iov_len == 2);
+	if (getrange != getrange_slow) {
+		assert(wiov.max == 1);
+		assert(wiov.iov[0].iov_base == __user_addr_max - 3);
+		assert(wiov.iov[0].iov_len == 2);
+	} else {
+		assert(wiov.max == 2);
+		assert(wiov.iov[0].iov_base == __user_addr_max - 3);
+		assert(wiov.iov[0].iov_len == 1);
+		assert(wiov.iov[1].iov_base == __user_addr_max - 2);
+		assert(wiov.iov[1].iov_len == 1);
+	}
 
 	err = vringh_iov_pull_user(&riov, buf, 5);
 	if (err != 1)
@@ -434,7 +468,7 @@ int main(int argc, char *argv[])
 	if (err != 2)
 		errx(1, "vringh_iov_push_user: %i", err);
 	assert(memcmp(__user_addr_max - 3, "bc", 2) == 0);
-	assert(wiov.i == 1);
+	assert(wiov.i == wiov.max);
 	assert(vringh_iov_push_user(&wiov, buf, 5) == 0);
 
 	/* Host is done. */
@@ -477,14 +511,17 @@ int main(int argc, char *argv[])
 	wiov.max = ARRAY_SIZE(host_wiov);
 	wiov.allocated = false;
 
-	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange,
 				  &head, GFP_KERNEL);
 	if (err != 1)
 		errx(1, "vringh_getdesc_user: %i", err);
 
 	assert(riov.allocated);
 	assert(riov.iov != host_riov);
-	assert(riov.max == RINGSIZE);
+	if (getrange != getrange_slow)
+		assert(riov.max == RINGSIZE);
+	else
+		assert(riov.max == RINGSIZE * USER_MEM/4);
 
 	assert(!wiov.allocated);
 	assert(wiov.max == 0);
@@ -567,7 +604,7 @@ int main(int argc, char *argv[])
 		wiov.max = ARRAY_SIZE(host_wiov);
 		wiov.allocated = false;
 
-		err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+		err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange,
 					  &head, GFP_KERNEL);
 		if (err != 1)
 			errx(1, "vringh_getdesc_user: %i", err);
@@ -575,7 +612,10 @@ int main(int argc, char *argv[])
 		if (head != n)
 			errx(1, "vringh_getdesc_user: head %i not %i", head, n);
 
-		assert(riov.max == 7);
+		if (getrange != getrange_slow)
+			assert(riov.max == 7);
+		else
+			assert(riov.max == 28);
 		assert(riov.allocated);
 		err = vringh_iov_pull_user(&riov, buf, 29);
 		assert(err == 28);
