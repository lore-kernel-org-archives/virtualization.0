From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/6] tools/virtio: add vring_test.
Date: Thu, 17 Jan 2013 20:59:41 +1030
Message-ID: <1358418584-26345-4-git-send-email-rusty@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This is mainly to test the drivers/vhost/vringh.c code, but it also
uses the drivers/virtio/virtio_ring.c code for the guest side.

Usage for testing the basic implementation:

	./vringh_test
	# Test with indirect descriptors
	./vringh_test --indirect
	# Test with indirect descriptors and event indexex
	./vringh_test --indirect --eventidx

You can run a parallel stress test by adding --parallel to any of the
above options.

eg ./vringh_test --parallel:
	Using CPUS 0 and 3
	Guest: notified 10107974, pinged 107970
	Host: notified 108158, pinged 3172148
	Time: R=17.659 U=6.640 S=6.640

./vringh_test --eventidx --parallel:
	Using CPUS 0 and 3
	Guest: notified 156357, pinged 156251
	Host: notified 156251, pinged 78179
	Time: R=4.518 U=3.536 S=3.536

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 tools/virtio/Makefile      |    4 +-
 tools/virtio/vringh_test.c |  591 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 593 insertions(+), 2 deletions(-)
 create mode 100644 tools/virtio/vringh_test.c

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index d1d442e..b928c3e 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -1,5 +1,5 @@
 all: test mod
-test: virtio_test
+test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 CFLAGS += -g -O2 -Wall -I. -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow  -MMD
 vpath %.c ../../drivers/virtio
@@ -7,6 +7,6 @@ mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test
 .PHONY: all test mod clean
 clean:
-	${RM} *.o vhost_test/*.o vhost_test/.*.cmd \
+	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
               vhost_test/Module.symvers vhost_test/modules.order *.d
 -include *.d
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
new file mode 100644
index 0000000..f3868f4
--- /dev/null
+++ b/tools/virtio/vringh_test.c
@@ -0,0 +1,591 @@
+/* Simple test of virtio code, entirely in userpsace. */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <err.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <../../drivers/vhost/vringh.c>
+#include <../../drivers/virtio/virtio_ring.c>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+
+#define USER_MEM (1024*1024)
+void *__user_addr_min, *__user_addr_max;
+void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
+static u64 user_addr_offset;
+
+#define RINGSIZE 256
+#define ALIGN 4096
+
+static void never_notify_host(struct virtqueue *vq)
+{
+	abort();
+}
+
+static void never_callback_guest(struct virtqueue *vq)
+{
+	abort();
+}
+
+static inline bool getrange_iov(u64 addr, struct vringh_range *r)
+{
+	r->start = (u64)(unsigned long)__user_addr_min - user_addr_offset;
+	r->end_incl = (u64)(unsigned long)__user_addr_max - 1 - user_addr_offset;
+	r->offset = user_addr_offset;
+	return true;
+}
+
+struct guest_virtio_device {
+	struct virtio_device vdev;
+	int to_host_fd;
+	unsigned long notifies;
+};
+
+static void parallel_notify_host(struct virtqueue *vq)
+{
+	struct guest_virtio_device *gvdev;
+
+	gvdev = container_of(vq->vdev, struct guest_virtio_device, vdev);
+	write(gvdev->to_host_fd, "", 1);
+	gvdev->notifies++;
+}
+
+#define NUM_XFERS (10000000)
+
+/* We aim for two "distant" cpus. */
+static void find_cpus(unsigned int *first, unsigned int *last)
+{
+	unsigned int i;
+
+	*first = -1U;
+	*last = 0;
+	for (i = 0; i < 4096; i++) {
+		cpu_set_t set;
+		CPU_ZERO(&set);
+		CPU_SET(i, &set);
+		if (sched_setaffinity(getpid(), sizeof(set), &set) == 0) {
+			if (i < *first)
+				*first = i;
+			if (i > *last)
+				*last = i;
+		}
+	}
+}
+
+static int parallel_test(unsigned long features)
+{
+	void *host_map, *guest_map;
+	int fd, mapsize, to_guest[2], to_host[2];
+	unsigned long xfers = 0, notifies = 0, receives = 0;
+	unsigned int first_cpu, last_cpu;
+	cpu_set_t cpu_set;
+
+	/* Create real file to mmap. */
+	fd = open("/tmp/vringh_test-file", O_RDWR|O_CREAT|O_TRUNC, 0600);
+	if (fd < 0)
+		err(1, "Opening /tmp/vringh_test-file");
+
+	/* Extra room at the end for some data, and indirects */
+	mapsize = vring_size(RINGSIZE, ALIGN)
+		+ RINGSIZE * 2 * sizeof(int)
+		+ RINGSIZE * 6 * sizeof(struct vring_desc);
+	mapsize = (mapsize + getpagesize() - 1) & ~(getpagesize() - 1);
+	ftruncate(fd, mapsize);
+
+	/* Parent and child use separate addresses, to check our mapping logic! */
+	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+
+	pipe(to_guest);
+	pipe(to_host);
+
+	CPU_ZERO(&cpu_set);
+	find_cpus(&first_cpu, &last_cpu);
+	printf("Using CPUS %u and %u\n", first_cpu, last_cpu);
+	fflush(stdout);
+
+	if (fork() != 0) {
+		struct vringh vrh;
+		bool notify = false;
+		int status;
+
+		/* We are the host: never access guest addresses! */
+		munmap(guest_map, mapsize);
+
+		__user_addr_min = host_map;
+		__user_addr_max = __user_addr_min + mapsize;
+		user_addr_offset = host_map - guest_map;
+		assert(user_addr_offset);
+
+		close(to_guest[0]);
+		close(to_host[1]);
+
+		vring_init(&vrh.vring, RINGSIZE, host_map, ALIGN);
+		vringh_init_user(&vrh, features, RINGSIZE, true,
+				 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
+		CPU_SET(first_cpu, &cpu_set);
+		if (sched_setaffinity(getpid(), sizeof(cpu_set), &cpu_set))
+			err(1, "Could not set affinity to cpu %u", first_cpu);
+
+		while (xfers < NUM_XFERS) {
+			struct iovec host_riov[2], host_wiov[2];
+			struct vringh_iov riov, wiov;
+			char buf[5];
+			u16 head;
+			int rlen, err;
+
+			riov.iov = host_riov;
+			riov.max = ARRAY_SIZE(host_riov);
+			riov.allocated = false;
+
+			wiov.iov = host_wiov;
+			wiov.max = ARRAY_SIZE(host_wiov);
+			wiov.allocated = false;
+
+			err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+						  &head, GFP_KERNEL);
+			if (err == 0) {
+				char buf[128];
+
+				if (notify) {
+					write(to_guest[1], "", 1);
+					notifies++;
+					notify = false;
+				}
+
+				if (vringh_notify_enable_user(&vrh))
+					continue;
+
+				/* Swallow all notifies at once. */
+				if (read(to_host[0], buf, sizeof(buf)) < 1)
+					break;
+
+				vringh_notify_disable_user(&vrh);
+				receives++;
+				continue;
+			}
+			if (err != 1)
+				errx(1, "vringh_getdesc_user: %i", err);
+
+			/* We simply copy bytes. */
+			rlen = vringh_iov_pull_user(&riov, buf, sizeof(buf));
+			if (rlen < 0)
+				errx(1, "vringh_iov_pull_user: %i", rlen);
+			err = vringh_iov_push_user(&wiov, buf, rlen);
+			if (err != rlen)
+				errx(1, "vringh_iov_push_user: %i", err);
+			xfers++;
+			assert(wiov.i == wiov.max);
+
+			err = vringh_complete_user(&vrh, head, rlen, &notify);
+			if (err != 0)
+				errx(1, "vringh_complete_user: %i", err);
+		}
+
+		if (notify) {
+			write(to_guest[1], "", 1);
+			notifies++;
+			notify = false;
+		}
+		wait(&status);
+		if (!WIFEXITED(status))
+			errx(1, "Child died with signal %i?", WTERMSIG(status));
+		if (WEXITSTATUS(status) != 0)
+			errx(1, "Child exited %i?", WEXITSTATUS(status));
+		printf("Host: notified %lu, pinged %lu\n", notifies, receives);
+		return 0;
+	} else {
+		struct guest_virtio_device gvdev;
+		struct virtqueue *vq;
+		unsigned int *data;
+		struct vring_desc *indirects;
+		unsigned int finished = 0;
+
+		/* We pass sg[]s pointing into here, but we need RINGSIZE+1 */
+		data = guest_map + vring_size(RINGSIZE, ALIGN);
+		indirects = (void *)data + (RINGSIZE + 1) * 2 * sizeof(int);
+
+		/* We are the guest. */
+		munmap(host_map, mapsize);
+
+		close(to_guest[1]);
+		close(to_host[0]);
+
+		gvdev.vdev.features[0] = features;
+		gvdev.to_host_fd = to_host[1];
+
+		CPU_SET(first_cpu, &cpu_set);
+		if (sched_setaffinity(getpid(), sizeof(cpu_set), &cpu_set))
+			err(1, "Could not set affinity to cpu %u", first_cpu);
+
+		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &gvdev.vdev, true,
+					 guest_map, parallel_notify_host,
+					 never_callback_guest, "guest vq");
+
+		/* Don't kfree indirects. */
+		__kfree_ignore_start = indirects;
+		__kfree_ignore_end = indirects + RINGSIZE * 6;
+
+		while (xfers < NUM_XFERS) {
+			struct scatterlist sg[6];
+			unsigned int num_sg, len;
+			int *din, *dout, err;
+
+			/* Consume bufs. */
+			while ((din = virtqueue_get_buf(vq, &len)) != NULL) {
+				dout = din + 1;
+				assert(*dout == *din);
+				assert(len == 4);
+				finished++;
+			}
+
+			/* Produce a buffer. */
+			din = data + (xfers % (RINGSIZE + 1)) * 2;
+			dout = din + 1;
+
+			*din = xfers;
+			switch ((xfers / sizeof(*din)) % 3) {
+			case 0:
+				/* Nasty three-element sg list. */
+				sg_init_table(sg, num_sg = 3);
+				sg_set_buf(&sg[0], (void *)din, 1);
+				sg_set_buf(&sg[1], (void *)din + 1, 2);
+				sg_set_buf(&sg[2], (void *)din + 3, 1);
+				sg_init_table(sg + num_sg, num_sg);
+				sg_set_buf(&sg[num_sg+0], (void *)dout, 1);
+				sg_set_buf(&sg[num_sg+1], (void *)dout + 1, 2);
+				sg_set_buf(&sg[num_sg+2], (void *)dout + 3, 1);
+				break;
+			case 1:
+				sg_init_table(sg, num_sg = 2);
+				sg_set_buf(&sg[0], (void *)din, 1);
+				sg_set_buf(&sg[1], (void *)din + 1, 3);
+				sg_init_table(sg + num_sg, num_sg);
+				sg_set_buf(&sg[num_sg+0], (void *)dout, 1);
+				sg_set_buf(&sg[num_sg+1], (void *)dout + 1, 3);
+				break;
+			case 2:
+				sg_init_table(sg, num_sg = 1);
+				sg_set_buf(&sg[0], (void *)din, 4);
+				sg_init_table(sg + num_sg, num_sg);
+				sg_set_buf(&sg[num_sg+0], (void *)dout, 4);
+				break;
+			}
+
+			/* May allocate an indirect, so force it to allocate
+			 * user addr */
+			__kmalloc_fake = indirects + (xfers % RINGSIZE) * 6;
+			err = virtqueue_add_buf(vq, sg, num_sg, num_sg, din,
+						GFP_KERNEL);
+			if (err == -ENOSPC) {
+				char buf[128];
+
+				if (!virtqueue_enable_cb_delayed(vq))
+					continue;
+				/* Swallow all notifies at once. */
+				if (read(to_guest[0], buf, sizeof(buf)) < 1)
+					break;
+				
+				receives++;
+				virtqueue_disable_cb(vq);
+				continue;
+			}
+
+			if (err)
+				errx(1, "virtqueue_add_buf: %i", err);
+
+			xfers++;
+			virtqueue_kick(vq);
+		}
+
+		/* Any extra? */
+		while (finished != xfers) {
+			char buf[128];
+			int *din, *dout;
+			unsigned int len;
+
+			/* Consume bufs. */
+			din = virtqueue_get_buf(vq, &len);
+			if (din) {
+				dout = din + 1;
+				assert(*dout == *din);
+				assert(len == 4);
+				finished++;
+				continue;
+			}
+
+			if (!virtqueue_enable_cb_delayed(vq))
+				continue;
+			if (read(to_guest[0], buf, sizeof(buf)) < 1)
+				break;
+				
+			receives++;
+			virtqueue_disable_cb(vq);
+		}
+
+		printf("Guest: notified %lu, pinged %lu\n",
+		       gvdev.notifies, receives);
+		return 0;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct virtio_device vdev;
+	struct virtqueue *vq;
+	struct vringh vrh;
+	struct scatterlist guest_sg[RINGSIZE];
+	struct iovec host_riov[2], host_wiov[2];
+	struct vringh_iov riov, wiov;
+	char buf[28];
+	u16 head;
+	int err;
+	unsigned i;
+	bool notify = false;
+	void *ret;
+
+	vdev.features[0] = 0;
+
+	if (argv[1] && strcmp(argv[1], "--indirect") == 0) {
+		vdev.features[0] |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
+		argv++;
+	}
+
+	if (argv[1] && strcmp(argv[1], "--eventidx") == 0) {
+		vdev.features[0] |= (1 << VIRTIO_RING_F_EVENT_IDX);
+		argv++;
+	}
+
+	if (argv[1] && strcmp(argv[1], "--parallel") == 0)
+		return parallel_test(vdev.features[0]);
+
+	if (posix_memalign(&__user_addr_min, PAGE_SIZE, USER_MEM) != 0)
+		abort();
+	__user_addr_max = __user_addr_min + USER_MEM;
+	memset(__user_addr_min, 0, vring_size(RINGSIZE, ALIGN));
+
+	/* Set up guest side. */
+	vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true,
+				 __user_addr_min,
+				 never_notify_host, never_callback_guest,
+				 "guest vq");
+
+	/* Set up host side. */
+	vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
+	vringh_init_user(&vrh, vdev.features[0], RINGSIZE, true,
+			 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
+
+	/* No descriptor to get yet... */
+	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+				  &head, GFP_KERNEL);
+	if (err != 0)
+		errx(1, "vringh_getdesc_user: %i", err);
+
+	/* Guest puts in a descriptor. */
+	memcpy(__user_addr_max - 1, "a", 1);
+	sg_init_table(guest_sg, 1);
+	sg_set_buf(&guest_sg[0], __user_addr_max - 1, 1);
+	sg_init_table(guest_sg+1, 1);
+	sg_set_buf(&guest_sg[1], __user_addr_max - 3, 2);
+
+	/* May allocate an indirect, so force it to allocate user addr */
+	__kmalloc_fake = __user_addr_min + vring_size(RINGSIZE, ALIGN);
+	err = virtqueue_add_buf(vq, guest_sg, 1, 1, &err, GFP_KERNEL);
+	if (err)
+		errx(1, "virtqueue_add_buf: %i", err);
+	__kmalloc_fake = NULL;
+
+	/* Host retreives it. */
+	riov.iov = host_riov;
+	riov.max = ARRAY_SIZE(host_riov);
+	riov.allocated = false;
+
+	wiov.iov = host_wiov;
+	wiov.max = ARRAY_SIZE(host_wiov);
+	wiov.allocated = false;
+
+	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+				  &head, GFP_KERNEL);
+	if (err != 1)
+		errx(1, "vringh_getdesc_user: %i", err);
+
+	assert(riov.max == 1);
+	assert(riov.iov[0].iov_base == __user_addr_max - 1);
+	assert(riov.iov[0].iov_len == 1);
+	assert(wiov.max == 1);
+	assert(wiov.iov[0].iov_base == __user_addr_max - 3);
+	assert(wiov.iov[0].iov_len == 2);
+
+	err = vringh_iov_pull_user(&riov, buf, 5);
+	if (err != 1)
+		errx(1, "vringh_iov_pull_kern: %i", err);
+	assert(buf[0] == 'a');
+	assert(riov.i == 1);
+	assert(vringh_iov_pull_kern(&riov, buf, 5) == 0);
+
+	memcpy(buf, "bcdef", 5);
+	err = vringh_iov_push_user(&wiov, buf, 5);
+	if (err != 2)
+		errx(1, "vringh_iov_push_user: %i", err);
+	assert(memcmp(__user_addr_max - 3, "bc", 2) == 0);
+	assert(wiov.i == 1);
+	assert(vringh_iov_push_kern(&wiov, buf, 5) == 0);
+
+	/* Host is done. */
+	err = vringh_complete_user(&vrh, head, err, &notify);
+	if (err != 0)
+		errx(1, "vringh_complete_user: %i", err);
+
+	/* Guest should see used token now. */
+	__kfree_ignore_start = __user_addr_min + vring_size(RINGSIZE, ALIGN);
+	__kfree_ignore_end = __kfree_ignore_start + 1;
+	ret = virtqueue_get_buf(vq, &i);
+	if (ret != &err)
+		errx(1, "virtqueue_get_buf: %p", ret);
+	assert(i == 2);
+
+	/* Guest puts in a huge descriptor. */
+	sg_init_table(guest_sg, RINGSIZE);
+	for (i = 0; i < RINGSIZE; i++) {
+		sg_set_buf(&guest_sg[i],
+			   __user_addr_max - USER_MEM/4, USER_MEM/4);
+	}
+
+	/* Fill contents with recognisable garbage. */
+	for (i = 0; i < USER_MEM/4; i++)
+		((char *)__user_addr_max - USER_MEM/4)[i] = i;
+
+	/* This will allocate an indirect, so force it to allocate user addr */
+	__kmalloc_fake = __user_addr_min + vring_size(RINGSIZE, ALIGN);
+	err = virtqueue_add_buf(vq, guest_sg, RINGSIZE, 0, &err, GFP_KERNEL);
+	if (err)
+		errx(1, "virtqueue_add_buf (large): %i", err);
+	__kmalloc_fake = NULL;
+
+	/* Host picks it up (allocates new iov). */
+	riov.iov = host_riov;
+	riov.max = ARRAY_SIZE(host_riov);
+	riov.allocated = false;
+
+	wiov.iov = host_wiov;
+	wiov.max = ARRAY_SIZE(host_wiov);
+	wiov.allocated = false;
+
+	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+				  &head, GFP_KERNEL);
+	if (err != 1)
+		errx(1, "vringh_getdesc_user: %i", err);
+
+	assert(riov.allocated);
+	assert(riov.iov != host_riov);
+	assert(riov.max == RINGSIZE);
+
+	assert(!wiov.allocated);
+	assert(wiov.max == 0);
+
+	/* Pull data back out (in odd chunks), should be as expected. */
+	for (i = 0; i < RINGSIZE * USER_MEM/4; i += 3) {
+		err = vringh_iov_pull_user(&riov, buf, 3);
+		if (err != 3 && i + err != RINGSIZE * USER_MEM/4)
+			errx(1, "vringh_iov_pull_user large: %i", err);
+		assert(buf[0] == (char)i);
+		assert(err < 2 || buf[1] == (char)(i + 1));
+		assert(err < 3 || buf[2] == (char)(i + 2));
+	}
+	assert(wiov.i == wiov.max);
+
+	kfree(riov.iov);
+
+	/* Test weird (but legal!) indirect. */
+	if (vdev.features[0] & (1 << VIRTIO_RING_F_INDIRECT_DESC)) {
+		struct vring_virtqueue *vvq = to_vvq(vq);
+		char *data = __user_addr_max - USER_MEM/4;
+		struct vring_desc *d = __user_addr_max - USER_MEM/2;
+		unsigned int n = vvq->free_head;
+
+		/* Force creation of direct, which we modify. */
+		vvq->indirect = false;
+		
+		sg_init_table(guest_sg, 4);
+		sg_set_buf(&guest_sg[0], d, sizeof(*d)*2);
+		sg_set_buf(&guest_sg[1], d + 2, sizeof(*d)*1);
+		sg_set_buf(&guest_sg[2], data + 6, 4);
+		sg_set_buf(&guest_sg[3], d + 3, sizeof(*d)*3);
+
+		err = virtqueue_add_buf(vq, guest_sg, 4, 0, &err, GFP_KERNEL);
+		if (err)
+			errx(1, "virtqueue_add_buf (indirect): %i", err);
+
+		/* They're used in order, but double-check... */
+		assert(vvq->vring.desc[n].addr == (unsigned long)d);
+		assert(vvq->vring.desc[n+1].addr == (unsigned long)(d+2));
+		assert(vvq->vring.desc[n+2].addr == (unsigned long)data + 6);
+		assert(vvq->vring.desc[n+3].addr == (unsigned long)(d+3));
+		vvq->vring.desc[n].flags |= VRING_DESC_F_INDIRECT;
+		vvq->vring.desc[n+1].flags |= VRING_DESC_F_INDIRECT;
+		vvq->vring.desc[n+3].flags |= VRING_DESC_F_INDIRECT;
+
+		/* First indirect */
+		d[0].addr = (unsigned long)data;
+		d[0].len = 1;
+		d[0].flags = VRING_DESC_F_NEXT;
+		d[0].next = 1;
+		d[1].addr = (unsigned long)data + 1;
+		d[1].len = 2;
+		d[1].flags = 0;
+
+		/* Second indirect */
+		d[2].addr = (unsigned long)data + 3;
+		d[2].len = 3;
+		d[2].flags = 0;
+
+		/* Third indirect */
+		d[3].addr = (unsigned long)data + 10;
+		d[3].len = 5;
+		d[3].flags = VRING_DESC_F_NEXT;
+		d[3].next = 1;
+		d[4].addr = (unsigned long)data + 15;
+		d[4].len = 6;
+		d[4].flags = VRING_DESC_F_NEXT;
+		d[4].next = 2;
+		d[5].addr = (unsigned long)data + 21;
+		d[5].len = 7;
+		d[5].flags = 0;
+
+		/* Host picks it up (allocates new iov). */
+		riov.iov = host_riov;
+		riov.max = ARRAY_SIZE(host_riov);
+		riov.allocated = false;
+
+		wiov.iov = host_wiov;
+		wiov.max = ARRAY_SIZE(host_wiov);
+		wiov.allocated = false;
+
+		err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange_iov,
+					  &head, GFP_KERNEL);
+		if (err != 1)
+			errx(1, "vringh_getdesc_user: %i", err);
+
+		if (head != n)
+			errx(1, "vringh_getdesc_user: head %i not %i", head, n);
+
+		assert(riov.max == 7);
+		assert(riov.allocated);
+		err = vringh_iov_pull_user(&riov, buf, 29);
+		assert(err == 28);
+
+		/* Data should be linear. */
+		for (i = 0; i < err; i++)
+			assert(buf[i] == i);
+		kfree(riov.iov);
+	}
+
+	/* Don't leak memory... */
+	vring_del_virtqueue(vq);
+	free(__user_addr_min);
+
+	return 0;
+}
-- 
1.7.10.4
