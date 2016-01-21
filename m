From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] tools/virtio: add ringtest utilities
Date: Thu, 21 Jan 2016 14:52:32 +0200
Message-ID: <1453380639-10459-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This adds micro-benchmarks useful for tuning virtio ring layouts.
Three layouts are currently implemented:

- virtio 0.9 compatible one
- an experimental extension bypassing the ring index, polling ring
  itself instead
- an experimental extension bypassing avail and used ring completely

Typical use:

sh run-on-all.sh perf stat -r 10 --log-fd 1 -- ./ring

It doesn't depend on the kernel directly, but it's handy
to have as much virtio stuff as possible in one tree.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I have this in my tree at the moment.  As this is completely standalone,
I think it's reasonable to merge this in 4.5.

 tools/virtio/ringtest/main.h             | 119 ++++++++++
 tools/virtio/ringtest/main.c             | 366 +++++++++++++++++++++++++++++++
 tools/virtio/ringtest/ring.c             | 272 +++++++++++++++++++++++
 tools/virtio/ringtest/virtio_ring_0_9.c  | 316 ++++++++++++++++++++++++++
 tools/virtio/ringtest/virtio_ring_poll.c |   2 +
 tools/virtio/ringtest/Makefile           |  22 ++
 tools/virtio/ringtest/README             |   2 +
 tools/virtio/ringtest/run-on-all.sh      |  24 ++
 8 files changed, 1123 insertions(+)
 create mode 100644 tools/virtio/ringtest/main.h
 create mode 100644 tools/virtio/ringtest/main.c
 create mode 100644 tools/virtio/ringtest/ring.c
 create mode 100644 tools/virtio/ringtest/virtio_ring_0_9.c
 create mode 100644 tools/virtio/ringtest/virtio_ring_poll.c
 create mode 100644 tools/virtio/ringtest/Makefile
 create mode 100644 tools/virtio/ringtest/README
 create mode 100755 tools/virtio/ringtest/run-on-all.sh

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
new file mode 100644
index 0000000..16917ac
--- /dev/null
+++ b/tools/virtio/ringtest/main.h
@@ -0,0 +1,119 @@
+/*
+ * Copyright (C) 2016 Red Hat, Inc.
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * Common macros and functions for ring benchmarking.
+ */
+#ifndef MAIN_H
+#define MAIN_H
+
+#include <stdbool.h>
+
+extern bool do_exit;
+
+#if defined(__x86_64__) || defined(__i386__)
+#include "x86intrin.h"
+
+static inline void wait_cycles(unsigned long long cycles)
+{
+	unsigned long long t;
+
+	t = __rdtsc();
+	while (__rdtsc() - t < cycles) {}
+}
+
+#define VMEXIT_CYCLES 500
+#define VMENTRY_CYCLES 500
+
+#else
+static inline void wait_cycles(unsigned long long cycles)
+{
+	_Exit(5);
+}
+#define VMEXIT_CYCLES 0
+#define VMENTRY_CYCLES 0
+#endif
+
+static inline void vmexit(void)
+{
+	if (!do_exit)
+		return;
+	
+	wait_cycles(VMEXIT_CYCLES);
+}
+static inline void vmentry(void)
+{
+	if (!do_exit)
+		return;
+	
+	wait_cycles(VMENTRY_CYCLES);
+}
+
+/* implemented by ring */
+void alloc_ring(void);
+/* guest side */
+int add_inbuf(unsigned, void *, void *);
+void *get_buf(unsigned *, void **);
+void disable_call();
+bool enable_call();
+void kick_available();
+void poll_used();
+/* host side */
+void disable_kick();
+bool enable_kick();
+bool use_buf(unsigned *, void **);
+void call_used();
+void poll_avail();
+
+/* implemented by main */
+extern bool do_sleep;
+void kick(void);
+void wait_for_kick(void);
+void call(void);
+void wait_for_call(void);
+
+extern unsigned ring_size;
+
+/* Compiler barrier - similar to what Linux uses */
+#define barrier() asm volatile("" ::: "memory")
+
+/* Is there a portable way to do this? */
+#if defined(__x86_64__) || defined(__i386__)
+#define cpu_relax() asm ("rep; nop" ::: "memory")
+#else
+#define cpu_relax() assert(0)
+#endif
+
+extern bool do_relax;
+
+static inline void busy_wait(void)
+{
+	if (do_relax)
+		cpu_relax();
+	else
+		/* prevent compiler from removing busy loops */
+		barrier();
+} 
+
+/*
+ * Not using __ATOMIC_SEQ_CST since gcc docs say they are only synchronized
+ * with other __ATOMIC_SEQ_CST calls.
+ */
+#define smp_mb() __sync_synchronize()
+
+/*
+ * This abuses the atomic builtins for thread fences, and
+ * adds a compiler barrier.
+ */
+#define smp_release() do { \
+    barrier(); \
+    __atomic_thread_fence(__ATOMIC_RELEASE); \
+} while (0)
+
+#define smp_acquire() do { \
+    __atomic_thread_fence(__ATOMIC_ACQUIRE); \
+    barrier(); \
+} while (0)
+
+#endif
diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
new file mode 100644
index 0000000..3a5ff43
--- /dev/null
+++ b/tools/virtio/ringtest/main.c
@@ -0,0 +1,366 @@
+/*
+ * Copyright (C) 2016 Red Hat, Inc.
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * Command line processing and common functions for ring benchmarking.
+ */
+#define _GNU_SOURCE
+#include <getopt.h>
+#include <pthread.h>
+#include <assert.h>
+#include <sched.h>
+#include "main.h"
+#include <sys/eventfd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <limits.h>
+
+int runcycles = 10000000;
+int max_outstanding = INT_MAX;
+int batch = 1;
+
+bool do_sleep = false;
+bool do_relax = false;
+bool do_exit = true;
+
+unsigned ring_size = 256;
+
+static int kickfd = -1;
+static int callfd = -1;
+
+void notify(int fd)
+{
+	unsigned long long v = 1;
+	int r;
+
+	vmexit();
+	r = write(fd, &v, sizeof v);
+	assert(r == sizeof v);
+	vmentry();
+}
+
+void wait_for_notify(int fd)
+{
+	unsigned long long v = 1;
+	int r;
+
+	vmexit();
+	r = read(fd, &v, sizeof v);
+	assert(r == sizeof v);
+	vmentry();
+}
+
+void kick(void)
+{
+	notify(kickfd);
+}
+
+void wait_for_kick(void)
+{
+	wait_for_notify(kickfd);
+}
+
+void call(void)
+{
+	notify(callfd);
+}
+
+void wait_for_call(void)
+{
+	wait_for_notify(callfd);
+}
+
+void set_affinity(const char *arg)
+{
+	cpu_set_t cpuset;
+	int ret;
+	pthread_t self;
+	long int cpu;
+	char *endptr;
+
+	if (!arg)
+		return;
+
+	cpu = strtol(arg, &endptr, 0);
+	assert(!*endptr);
+
+	assert(cpu >= 0 || cpu < CPU_SETSIZE);
+
+	self = pthread_self();
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+
+	ret = pthread_setaffinity_np(self, sizeof(cpu_set_t), &cpuset);
+	assert(!ret);
+}
+
+static void run_guest(void)
+{
+	int completed_before;
+	int completed = 0;
+	int started = 0;
+	int bufs = runcycles;
+	int spurious = 0;
+	int r;
+	unsigned len;
+	void *buf;
+	int tokick = batch;
+
+	for (;;) {
+		if (do_sleep)
+			disable_call();
+		completed_before = completed;
+		do {
+			if (started < bufs &&
+			    started - completed < max_outstanding) {
+				r = add_inbuf(0, NULL, "Hello, world!");
+				if (__builtin_expect(r == 0, true)) {
+					++started;
+					if (!--tokick) {
+						tokick = batch;
+						if (do_sleep)
+							kick_available();
+					}
+
+				}
+			} else
+				r = -1;
+
+			/* Flush out completed bufs if any */
+			if (get_buf(&len, &buf)) {
+				++completed;
+				if (__builtin_expect(completed == bufs, false))
+					return;
+				r = 0;
+			}
+		} while (r == 0);
+		if (completed == completed_before)
+			++spurious;
+		assert(completed <= bufs);
+		assert(started <= bufs);
+		if (do_sleep) {
+			if (enable_call())
+				wait_for_call();
+		} else {
+			poll_used();
+		}
+	}
+}
+
+static void run_host(void)
+{
+	int completed_before;
+	int completed = 0;
+	int spurious = 0;
+	int bufs = runcycles;
+	unsigned len;
+	void *buf;
+
+	for (;;) {
+		if (do_sleep) {
+			if (enable_kick())
+				wait_for_kick();
+		} else {
+			poll_avail();
+		}
+		if (do_sleep)
+			disable_kick();
+		completed_before = completed;
+		while (__builtin_expect(use_buf(&len, &buf), true)) {
+			if (do_sleep)
+				call_used();
+			++completed;
+			if (__builtin_expect(completed == bufs, false))
+				return;
+		}
+		if (completed == completed_before)
+			++spurious;
+		assert(completed <= bufs);
+		if (completed == bufs)
+			break;
+	}
+}
+
+void *start_guest(void *arg)
+{
+	set_affinity(arg);
+	run_guest();
+	pthread_exit(NULL);
+}
+
+void *start_host(void *arg)
+{
+	set_affinity(arg);
+	run_host();
+	pthread_exit(NULL);
+}
+
+static const char optstring[] = "";
+static const struct option longopts[] = {
+	{
+		.name = "help",
+		.has_arg = no_argument,
+		.val = 'h',
+	},
+	{
+		.name = "host-affinity",
+		.has_arg = required_argument,
+		.val = 'H',
+	},
+	{
+		.name = "guest-affinity",
+		.has_arg = required_argument,
+		.val = 'G',
+	},
+	{
+		.name = "ring-size",
+		.has_arg = required_argument,
+		.val = 'R',
+	},
+	{
+		.name = "run-cycles",
+		.has_arg = required_argument,
+		.val = 'C',
+	},
+	{
+		.name = "outstanding",
+		.has_arg = required_argument,
+		.val = 'o',
+	},
+	{
+		.name = "batch",
+		.has_arg = required_argument,
+		.val = 'b',
+	},
+	{
+		.name = "sleep",
+		.has_arg = no_argument,
+		.val = 's',
+	},
+	{
+		.name = "relax",
+		.has_arg = no_argument,
+		.val = 'x',
+	},
+	{
+		.name = "exit",
+		.has_arg = no_argument,
+		.val = 'e',
+	},
+	{
+	}
+};
+
+static void help(void)
+{
+	fprintf(stderr, "Usage: <test> [--help]"
+		" [--host-affinity H]"
+		" [--guest-affinity G]"
+		" [--ring-size R (default: %d)]"
+		" [--run-cycles C (default: %d)]"
+		" [--batch b]"
+		" [--outstanding o]"
+		" [--sleep]"
+		" [--relax]"
+		" [--exit]"
+		"\n",
+		ring_size,
+		runcycles);
+}
+
+int main(int argc, char **argv)
+{
+	int ret;
+	pthread_t host, guest;
+	void *tret;
+	char *host_arg = NULL;
+	char *guest_arg = NULL;
+	char *endptr;
+	long int c;
+
+	kickfd = eventfd(0, 0);
+	assert(kickfd >= 0);
+	callfd = eventfd(0, 0);
+	assert(callfd >= 0);
+
+	for (;;) {
+		int o = getopt_long(argc, argv, optstring, longopts, NULL);
+		switch (o) {
+		case -1:
+			goto done;
+		case '?':
+			help();
+			exit(2);
+		case 'H':
+			host_arg = optarg;
+			break;
+		case 'G':
+			guest_arg = optarg;
+			break;
+		case 'R':
+			ring_size = strtol(optarg, &endptr, 0);
+			assert(ring_size && !(ring_size & (ring_size - 1)));
+			assert(!*endptr);
+			break;
+		case 'C':
+			c = strtol(optarg, &endptr, 0);
+			assert(!*endptr);
+			assert(c > 0 && c < INT_MAX);
+			runcycles = c;
+			break;
+		case 'o':
+			c = strtol(optarg, &endptr, 0);
+			assert(!*endptr);
+			assert(c > 0 && c < INT_MAX);
+			max_outstanding = c;
+			break;
+		case 'b':
+			c = strtol(optarg, &endptr, 0);
+			assert(!*endptr);
+			assert(c > 0 && c < INT_MAX);
+			batch = c;
+			break;
+		case 's':
+			do_sleep = true;
+			break;
+		case 'x':
+			do_relax = true;
+			break;
+		case 'e':
+			do_exit = true;
+			break;
+		default:
+			help();
+			exit(4);
+			break;
+		}
+	}
+
+	/* does nothing here, used to make sure all smp APIs compile */
+	smp_acquire();
+	smp_release();
+	smp_mb();
+done:
+
+	if (batch > max_outstanding)
+		batch = max_outstanding;
+
+	if (optind < argc) {
+		help();
+		exit(4);
+	}
+	alloc_ring();
+
+	ret = pthread_create(&host, NULL, start_host, host_arg);
+	assert(!ret);
+	ret = pthread_create(&guest, NULL, start_guest, guest_arg);
+	assert(!ret);
+
+	ret = pthread_join(guest, &tret);
+	assert(!ret);
+	ret = pthread_join(host, &tret);
+	assert(!ret);
+	return 0;
+}
diff --git a/tools/virtio/ringtest/ring.c b/tools/virtio/ringtest/ring.c
new file mode 100644
index 0000000..c25c8d2
--- /dev/null
+++ b/tools/virtio/ringtest/ring.c
@@ -0,0 +1,272 @@
+/*
+ * Copyright (C) 2016 Red Hat, Inc.
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * Simple descriptor-based ring. virtio 0.9 compatible event index is used for
+ * signalling, unconditionally.
+ */
+#define _GNU_SOURCE
+#include "main.h"
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+
+/* Next - Where next entry will be written.
+ * Prev - "Next" value when event triggered previously.
+ * Event - Peer requested event after writing this entry.
+ */
+static inline bool need_event(unsigned short event,
+			      unsigned short next,
+			      unsigned short prev)
+{
+	return (unsigned short)(next - event - 1) < (unsigned short)(next - prev);
+}
+
+/* Design:
+ * Guest adds descriptors with unique index values and DESC_HW in flags.
+ * Host overwrites used descriptors with correct len, index, and DESC_HW clear.
+ * Flags are always set last.
+ */
+#define DESC_HW 0x1
+
+struct desc {
+	unsigned short flags;
+	unsigned short index;
+	unsigned len;
+	unsigned long long addr;
+};
+
+/* how much padding is needed to avoid false cache sharing */
+#define HOST_GUEST_PADDING 0x80
+
+/* Mostly read */
+struct event {
+	unsigned short kick_index;
+	unsigned char reserved0[HOST_GUEST_PADDING - 2];
+	unsigned short call_index;
+	unsigned char reserved1[HOST_GUEST_PADDING - 2];
+};
+
+struct data {
+	void *buf; /* descriptor is writeable, we can't get buf from there */
+	void *data;
+} *data;
+
+struct desc *ring;
+struct event *event;
+
+struct guest {
+	unsigned avail_idx;
+	unsigned last_used_idx;
+	unsigned num_free;
+	unsigned kicked_avail_idx;
+	unsigned char reserved[HOST_GUEST_PADDING - 12];
+} guest;
+
+struct host {
+	/* we do not need to track last avail index
+	 * unless we have more than one in flight.
+	 */
+	unsigned used_idx;
+	unsigned called_used_idx;
+	unsigned char reserved[HOST_GUEST_PADDING - 4];
+} host;
+
+/* implemented by ring */
+void alloc_ring(void)
+{
+	int ret;
+	int i;
+
+	ret = posix_memalign((void **)&ring, 0x1000, ring_size * sizeof *ring);
+	if (ret) {
+		perror("Unable to allocate ring buffer.\n");
+		exit(3);
+	}
+	event = malloc(sizeof *event);
+	if (!event) {
+		perror("Unable to allocate event buffer.\n");
+		exit(3);
+	}
+	memset(event, 0, sizeof *event);
+	guest.avail_idx = 0;
+	guest.kicked_avail_idx = -1;
+	guest.last_used_idx = 0;
+	host.used_idx = 0;
+	host.called_used_idx = -1;
+	for (i = 0; i < ring_size; ++i) {
+		struct desc desc = {
+			.index = i,
+		};
+		ring[i] = desc;
+	}
+	guest.num_free = ring_size;
+	data = malloc(ring_size * sizeof *data);
+	if (!data) {
+		perror("Unable to allocate data buffer.\n");
+		exit(3);
+	}
+	memset(data, 0, ring_size * sizeof *data);
+}
+
+/* guest side */
+int add_inbuf(unsigned len, void *buf, void *datap)
+{
+	unsigned head, index;
+
+	if (!guest.num_free)
+		return -1;
+
+	guest.num_free--;
+	head = (ring_size - 1) & (guest.avail_idx++);
+
+	/* Start with a write. On MESI architectures this helps
+	 * avoid a shared state with consumer that is polling this descriptor.
+	 */
+	ring[head].addr = (unsigned long)(void*)buf;
+	ring[head].len = len;
+	/* read below might bypass write above. That is OK because it's just an
+	 * optimization. If this happens, we will get the cache line in a
+	 * shared state which is unfortunate, but probably not worth it to
+	 * add an explicit full barrier to avoid this.
+	 */
+	barrier();
+	index = ring[head].index;
+	data[index].buf = buf;
+	data[index].data = datap;
+	/* Barrier A (for pairing) */
+	smp_release();
+	ring[head].flags = DESC_HW;
+
+	return 0;
+}
+
+void *get_buf(unsigned *lenp, void **bufp)
+{
+	unsigned head = (ring_size - 1) & guest.last_used_idx;
+	unsigned index;
+	void *datap;
+
+	if (ring[head].flags & DESC_HW)
+		return NULL;
+	/* Barrier B (for pairing) */
+	smp_acquire();
+	*lenp = ring[head].len;
+	index = ring[head].index & (ring_size - 1);
+	datap = data[index].data;
+	*bufp = data[index].buf;
+	data[index].buf = NULL;
+	data[index].data = NULL;
+	guest.num_free++;
+	guest.last_used_idx++;
+	return datap;
+}
+
+void poll_used(void)
+{
+	unsigned head = (ring_size - 1) & guest.last_used_idx;
+
+	while (ring[head].flags & DESC_HW)
+		busy_wait();
+}
+
+void disable_call()
+{
+	/* Doing nothing to disable calls might cause
+	 * extra interrupts, but reduces the number of cache misses.
+	 */
+}
+
+bool enable_call()
+{
+	unsigned head = (ring_size - 1) & guest.last_used_idx;
+
+	event->call_index = guest.last_used_idx;
+	/* Flush call index write */
+	/* Barrier D (for pairing) */
+	smp_mb();
+	return ring[head].flags & DESC_HW;
+}
+
+void kick_available(void)
+{
+	/* Flush in previous flags write */
+	/* Barrier C (for pairing) */
+	smp_mb();
+	if (!need_event(event->kick_index,
+			guest.avail_idx,
+			guest.kicked_avail_idx))
+		return;
+
+	guest.kicked_avail_idx = guest.avail_idx;
+	kick();
+}
+
+/* host side */
+void disable_kick()
+{
+	/* Doing nothing to disable kicks might cause
+	 * extra interrupts, but reduces the number of cache misses.
+	 */
+}
+
+bool enable_kick()
+{
+	unsigned head = (ring_size - 1) & host.used_idx;
+
+	event->kick_index = host.used_idx;
+	/* Barrier C (for pairing) */
+	smp_mb();
+	return !(ring[head].flags & DESC_HW);
+}
+
+void poll_avail(void)
+{
+	unsigned head = (ring_size - 1) & host.used_idx;
+
+	while (!(ring[head].flags & DESC_HW))
+		busy_wait();
+}
+
+bool use_buf(unsigned *lenp, void **bufp)
+{
+	unsigned head = (ring_size - 1) & host.used_idx;
+
+	if (!(ring[head].flags & DESC_HW))
+		return false;
+
+	/* make sure length read below is not speculated */
+	/* Barrier A (for pairing) */
+	smp_acquire();
+
+	/* simple in-order completion: we don't need
+	 * to touch index at all. This also means we
+	 * can just modify the descriptor in-place.
+	 */
+	ring[head].len--;
+	/* Make sure len is valid before flags.
+	 * Note: alternative is to write len and flags in one access -
+	 * possible on 64 bit architectures but wmb is free on Intel anyway
+	 * so I have no way to test whether it's a gain.
+	 */
+	/* Barrier B (for pairing) */
+	smp_release();
+	ring[head].flags = 0;
+	host.used_idx++;
+	return true;
+}
+
+void call_used(void)
+{
+	/* Flush in previous flags write */
+	/* Barrier D (for pairing) */
+	smp_mb();
+	if (!need_event(event->call_index,
+			host.used_idx,
+			host.called_used_idx))
+		return;
+
+	host.called_used_idx = host.used_idx;
+	call();
+}
diff --git a/tools/virtio/ringtest/virtio_ring_0_9.c b/tools/virtio/ringtest/virtio_ring_0_9.c
new file mode 100644
index 0000000..47c9a1a
--- /dev/null
+++ b/tools/virtio/ringtest/virtio_ring_0_9.c
@@ -0,0 +1,316 @@
+/*
+ * Copyright (C) 2016 Red Hat, Inc.
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * Partial implementation of virtio 0.9. event index is used for signalling,
+ * unconditionally. Design roughly follows linux kernel implementation in order
+ * to be able to judge its performance.
+ */
+#define _GNU_SOURCE
+#include "main.h"
+#include <stdlib.h>
+#include <stdio.h>
+#include <assert.h>
+#include <string.h>
+#include <linux/virtio_ring.h>
+
+struct data {
+	void *data;
+} *data;
+
+struct vring ring;
+
+/* enabling the below activates experimental ring polling code
+ * (which skips index reads on consumer in favor of looking at
+ * high bits of ring id ^ 0x8000).
+ */
+/* #ifdef RING_POLL */
+
+/* how much padding is needed to avoid false cache sharing */
+#define HOST_GUEST_PADDING 0x80
+
+struct guest {
+	unsigned short avail_idx;
+	unsigned short last_used_idx;
+	unsigned short num_free;
+	unsigned short kicked_avail_idx;
+	unsigned short free_head;
+	unsigned char reserved[HOST_GUEST_PADDING - 10];
+} guest;
+
+struct host {
+	/* we do not need to track last avail index
+	 * unless we have more than one in flight.
+	 */
+	unsigned short used_idx;
+	unsigned short called_used_idx;
+	unsigned char reserved[HOST_GUEST_PADDING - 4];
+} host;
+
+/* implemented by ring */
+void alloc_ring(void)
+{
+	int ret;
+	int i;
+	void *p;
+
+	ret = posix_memalign(&p, 0x1000, vring_size(ring_size, 0x1000));
+	if (ret) {
+		perror("Unable to allocate ring buffer.\n");
+		exit(3);
+	}
+	memset(p, 0, vring_size(ring_size, 0x1000));
+	vring_init(&ring, ring_size, p, 0x1000);
+
+	guest.avail_idx = 0;
+	guest.kicked_avail_idx = -1;
+	guest.last_used_idx = 0;
+	/* Put everything in free lists. */
+	guest.free_head = 0;
+	for (i = 0; i < ring_size - 1; i++)
+		ring.desc[i].next = i + 1;
+	host.used_idx = 0;
+	host.called_used_idx = -1;
+	guest.num_free = ring_size;
+	data = malloc(ring_size * sizeof *data);
+	if (!data) {
+		perror("Unable to allocate data buffer.\n");
+		exit(3);
+	}
+	memset(data, 0, ring_size * sizeof *data);
+}
+
+/* guest side */
+int add_inbuf(unsigned len, void *buf, void *datap)
+{
+	unsigned head, avail;
+	struct vring_desc *desc;
+
+	if (!guest.num_free)
+		return -1;
+
+	head = guest.free_head;
+	guest.num_free--;
+
+	desc = ring.desc;
+	desc[head].flags = VRING_DESC_F_NEXT;
+	desc[head].addr = (unsigned long)(void *)buf;
+	desc[head].len = len;
+	/* We do it like this to simulate the way
+	 * we'd have to flip it if we had multiple
+	 * descriptors.
+	 */
+	desc[head].flags &= ~VRING_DESC_F_NEXT;
+	guest.free_head = desc[head].next;
+
+	data[head].data = datap;
+
+#ifdef RING_POLL
+	/* Barrier A (for pairing) */
+	smp_release();
+	avail = guest.avail_idx++;
+	ring.avail->ring[avail & (ring_size - 1)] =
+		(head | (avail & ~(ring_size - 1))) ^ 0x8000;
+#else
+	avail = (ring_size - 1) & (guest.avail_idx++);
+	ring.avail->ring[avail] = head;
+	/* Barrier A (for pairing) */
+	smp_release();
+#endif
+	ring.avail->idx = guest.avail_idx;
+	return 0;
+}
+
+void *get_buf(unsigned *lenp, void **bufp)
+{
+	unsigned head;
+	unsigned index;
+	void *datap;
+
+#ifdef RING_POLL
+	head = (ring_size - 1) & guest.last_used_idx;
+	index = ring.used->ring[head].id;
+	if ((index ^ guest.last_used_idx ^ 0x8000) & ~(ring_size - 1))
+		return NULL;
+	/* Barrier B (for pairing) */
+	smp_acquire();
+	index &= ring_size - 1;
+#else
+	if (ring.used->idx == guest.last_used_idx)
+		return NULL;
+	/* Barrier B (for pairing) */
+	smp_acquire();
+	head = (ring_size - 1) & guest.last_used_idx;
+	index = ring.used->ring[head].id;
+#endif
+	*lenp = ring.used->ring[head].len;
+	datap = data[index].data;
+	*bufp = (void*)(unsigned long)ring.desc[index].addr;
+	data[index].data = NULL;
+	ring.desc[index].next = guest.free_head;
+	guest.free_head = index;
+	guest.num_free++;
+	guest.last_used_idx++;
+	return datap;
+}
+
+void poll_used(void)
+{
+#ifdef RING_POLL
+	unsigned head = (ring_size - 1) & guest.last_used_idx;
+
+	for (;;) {
+		unsigned index = ring.used->ring[head].id;
+
+		if ((index ^ guest.last_used_idx ^ 0x8000) & ~(ring_size - 1))
+			busy_wait();
+		else
+			break;
+	}
+#else
+	unsigned head = guest.last_used_idx;
+
+	while (ring.used->idx == head)
+		busy_wait();
+#endif
+}
+
+void disable_call()
+{
+	/* Doing nothing to disable calls might cause
+	 * extra interrupts, but reduces the number of cache misses.
+	 */
+}
+
+bool enable_call()
+{
+	unsigned short last_used_idx;
+
+	vring_used_event(&ring) = (last_used_idx = guest.last_used_idx);
+	/* Flush call index write */
+	/* Barrier D (for pairing) */
+	smp_mb();
+#ifdef RING_POLL
+	{
+		unsigned short head = last_used_idx & (ring_size - 1);
+		unsigned index = ring.used->ring[head].id;
+
+		return (index ^ last_used_idx ^ 0x8000) & ~(ring_size - 1);
+	}
+#else
+	return ring.used->idx == last_used_idx;
+#endif
+}
+
+void kick_available(void)
+{
+	/* Flush in previous flags write */
+	/* Barrier C (for pairing) */
+	smp_mb();
+	if (!vring_need_event(vring_avail_event(&ring),
+			      guest.avail_idx,
+			      guest.kicked_avail_idx))
+		return;
+
+	guest.kicked_avail_idx = guest.avail_idx;
+	kick();
+}
+
+/* host side */
+void disable_kick()
+{
+	/* Doing nothing to disable kicks might cause
+	 * extra interrupts, but reduces the number of cache misses.
+	 */
+}
+
+bool enable_kick()
+{
+	unsigned head = host.used_idx;
+
+	vring_avail_event(&ring) = head;
+	/* Barrier C (for pairing) */
+	smp_mb();
+#ifdef RING_POLL
+	{
+		unsigned index = ring.avail->ring[head & (ring_size - 1)];
+
+		return (index ^ head ^ 0x8000) & ~(ring_size - 1);
+	}
+#else
+	return head == ring.avail->idx;
+#endif
+}
+
+void poll_avail(void)
+{
+	unsigned head = host.used_idx;
+#ifdef RING_POLL
+	for (;;) {
+		unsigned index = ring.avail->ring[head & (ring_size - 1)];
+		if ((index ^ head ^ 0x8000) & ~(ring_size - 1))
+			busy_wait();
+		else
+			break;
+	}
+#else
+	while (ring.avail->idx == head)
+		busy_wait();
+#endif
+}
+
+bool use_buf(unsigned *lenp, void **bufp)
+{
+	unsigned used_idx = host.used_idx;
+	struct vring_desc *desc;
+	unsigned head;
+
+#ifdef RING_POLL
+	head = ring.avail->ring[used_idx & (ring_size - 1)];
+	if ((used_idx ^ head ^ 0x8000) & ~(ring_size - 1))
+		return false;
+	/* Barrier A (for pairing) */
+	smp_acquire();
+
+	used_idx &= ring_size - 1;
+	desc = &ring.desc[head & (ring_size - 1)];
+#else
+	if (used_idx == ring.avail->idx)
+		return false;
+
+	/* Barrier A (for pairing) */
+	smp_acquire();
+
+	used_idx &= ring_size - 1;
+	head = ring.avail->ring[used_idx];
+	desc = &ring.desc[head];
+#endif
+
+	*lenp = desc->len;
+	*bufp = (void *)(unsigned long)desc->addr;
+
+	/* now update used ring */
+	ring.used->ring[used_idx].id = head;
+	ring.used->ring[used_idx].len = desc->len - 1;
+	/* Barrier B (for pairing) */
+	smp_release();
+	host.used_idx++;
+	ring.used->idx = host.used_idx;
+	
+	return true;
+}
+
+void call_used(void)
+{
+	/* Flush in previous flags write */
+	/* Barrier D (for pairing) */
+	smp_mb();
+	if (!vring_need_event(vring_used_event(&ring),
+			      host.used_idx,
+			      host.called_used_idx))
+		return;
+
+	host.called_used_idx = host.used_idx;
+	call();
+}
diff --git a/tools/virtio/ringtest/virtio_ring_poll.c b/tools/virtio/ringtest/virtio_ring_poll.c
new file mode 100644
index 0000000..84fc2c5
--- /dev/null
+++ b/tools/virtio/ringtest/virtio_ring_poll.c
@@ -0,0 +1,2 @@
+#define RING_POLL 1
+#include "virtio_ring_0_9.c"
diff --git a/tools/virtio/ringtest/Makefile b/tools/virtio/ringtest/Makefile
new file mode 100644
index 0000000..feaa64a
--- /dev/null
+++ b/tools/virtio/ringtest/Makefile
@@ -0,0 +1,22 @@
+all:
+
+all: ring virtio_ring_0_9 virtio_ring_poll
+
+CFLAGS += -Wall
+CFLAGS += -pthread -O2 -ggdb
+LDFLAGS += -pthread -O2 -ggdb
+
+main.o: main.c main.h
+ring.o: ring.c main.h
+virtio_ring_0_9.o: virtio_ring_0_9.c main.h
+virtio_ring_poll.o: virtio_ring_poll.c virtio_ring_0_9.c main.h
+ring: ring.o main.o
+virtio_ring_0_9: virtio_ring_0_9.o main.o
+virtio_ring_poll: virtio_ring_poll.o main.o
+clean:
+	-rm main.o
+	-rm ring.o ring
+	-rm virtio_ring_0_9.o virtio_ring_0_9
+	-rm virtio_ring_poll.o virtio_ring_poll
+
+.PHONY: all clean
diff --git a/tools/virtio/ringtest/README b/tools/virtio/ringtest/README
new file mode 100644
index 0000000..34e94c4
--- /dev/null
+++ b/tools/virtio/ringtest/README
@@ -0,0 +1,2 @@
+Partial implementation of various ring layouts, useful to tune virtio design.
+Uses shared memory heavily.
diff --git a/tools/virtio/ringtest/run-on-all.sh b/tools/virtio/ringtest/run-on-all.sh
new file mode 100755
index 0000000..52b0f71
--- /dev/null
+++ b/tools/virtio/ringtest/run-on-all.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+#use last CPU for host. Why not the first?
+#many devices tend to use cpu0 by default so
+#it tends to be busier
+HOST_AFFINITY=$(cd /dev/cpu; ls|grep -v '[a-z]'|sort -n|tail -1)
+
+#run command on all cpus
+for cpu in $(cd /dev/cpu; ls|grep -v '[a-z]'|sort -n);
+do
+	#Don't run guest and host on same CPU
+	#It actually works ok if using signalling
+	if
+		(echo "$@" | grep -e "--sleep" > /dev/null) || \
+			test $HOST_AFFINITY '!=' $cpu
+	then
+		echo "GUEST AFFINITY $cpu"
+		"$@" --host-affinity $HOST_AFFINITY --guest-affinity $cpu
+	fi
+done
+echo "NO GUEST AFFINITY"
+"$@" --host-affinity $HOST_AFFINITY
+echo "NO AFFINITY"
+"$@"
-- 
MST
