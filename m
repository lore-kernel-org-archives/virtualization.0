Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473809;
	b=RFFQJjQYS07LvFs+DJTsBGW+gZuHLGpK+svry734y2nScRg6qqvB3TILnwyNf+QMJ8XZ
	 FuXGlvdLNb9RbNCE4bT3dczt2dK7C3r5843APLbwXZSV0jHvqKlzJh71KJnG6Z3dqeyvB
	 XTcMal02XQdnRVPxp3gJ1aRhDVRkMVVp0XWz2Awg181RKAKUWOlMH04kRCTppX0D7DOwK
	 kaBQ2+AeL0Of8jfgwPOg/JUXu0tReGaeqI9SW3sarI61Zc2nJ00Dqj451gejar5BY/4M6
	 iLmrfi/L+8ycS4cEE7NW105b4Kfl6Lag8E8yzpClw15X75s4t4vhFg7pC5DyzLdDqAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473809;
	h=DMARC-Filter:X-UUID:X-CID-CACHE:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LLxGScaXX5G8dV943PMhCr2QGRrEbX3LWpwoAeEQMvU=;
	b=zaIQimRA3TvsgL0uJKA5CESnQjdeQpZ0OOafEcOZJPlxgnLcipIuoGi/2uPBTqgUB7U6
	 5BMZmQk0RPjjcVbtfNSsfjl7LXfjfpqz89qJ2sKbTRx7SdwkRBvtLQoznmDn2oEXKYB+L
	 EGv4aiMfWg1q5G6AjUwOnZuVk5uu3lX5R6jFkcP6dJ3UdNyb3TPkVYWYQeuTrpSS4QWaf
	 4hTJZ4mYN1XXBfAE/oV+ATDB6YM2Kloef3jzIfhTFkLgIk0xlA/ACkR13aYsHy28DMxK/
	 aw15BtKdS62WwJ65v3RU1kIcmcJBSfWg/wXGRtZbkQak34uVwRV/wu9y13CA7yo02Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D04606A8A1
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 08:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2D04606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fc5c893ede7611f19a56ed5b684f684d-20261112
X-CID-CACHE: Type:Local,Time:202611121605+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8af04e9d-b8b9-4f38-ac4a-51ce7b705172,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:0712648f332f4711195f93be5917beef,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|123|865|898,TC:nil,Content:0|15|50|99,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fc5c893ede7611f19a56ed5b684f684d-20261112
X-User: zhaoguohan@kylinos.cn
Received: from ubuntu.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1952387580; Thu, 12 Nov 2026 16:56:44 +0800
From: zhaoguohan@kylinos.cn
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/virtio: add a vhost dirty log test
Date: Thu, 12 Nov 2026 16:56:31 +0800
Message-ID: <20261112085631.128819-3-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
References: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khan Zhao <zhaoguohan@kylinos.cn>

Add vhost_log_test, which exercises used-ring dirty logging through the
existing vhost_test module. It sets a log base with VHOST_SET_LOG_BASE,
enables VHOST_VRING_F_LOG on the ring, submits descriptors and checks
the resulting bitmap from userspace. No new kernel interface is needed.

The test covers:

 - every bit in a byte, repeated sets, and neighbouring bytes being left
   untouched, including the last byte of a page followed by a PROT_NONE
   guard page
 - a log page that has not been faulted in yet, read-only, PROT_NONE
   and unmapped log pages, and logging after access is restored
 - private (COW) and shared file mappings, checking that the bit reaches
   the file after msync/fsync
 - eight vrings setting different bits of the same byte concurrently,
   with and without a userspace thread atomically fetching and clearing
   that byte
 - two shared mappings of one file page, one of them zapped with
   MADV_DONTNEED each round, so both resident and faulting pages are
   hit

log_used() ignores errors from log_write(), so the fault cases can only
check that nothing crashes, that nothing is written to an inaccessible
log, and that logging works again afterwards.

A --bench mode reports ns per descriptor with logging disabled and
enabled. vhost_log_test.rst describes how to build and run the test.

Assisted-by: Codex:gpt-6.1-sol
Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>
---
 tools/virtio/.gitignore         |   1 +
 tools/virtio/Makefile           |   7 +-
 tools/virtio/vhost_log_test.c   | 393 ++++++++++++++++++++++++++++++++
 tools/virtio/vhost_log_test.rst |  53 +++++
 4 files changed, 452 insertions(+), 2 deletions(-)
 create mode 100644 tools/virtio/vhost_log_test.c
 create mode 100644 tools/virtio/vhost_log_test.rst

diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
index 7e47b281c442..9f3ebfa2c3b6 100644
--- a/tools/virtio/.gitignore
+++ b/tools/virtio/.gitignore
@@ -2,5 +2,6 @@
 *.d
 virtio_test
 vhost_net_test
+vhost_log_test
 vringh_test
 virtio-trace/trace-agent
diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 2cac5fd4b979..a4af5140a1cd 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -1,9 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 all: test mod
-test: virtio_test vringh_test vhost_net_test
+test: virtio_test vringh_test vhost_net_test vhost_log_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 vhost_net_test: virtio_ring.o vhost_net_test.o
+vhost_log_test: vhost_log_test.o
+# This test uses only the userspace API, without the virtio kernel shims.
+vhost_log_test vhost_log_test.o: CFLAGS = -g -O2 -Wall -Wextra -Werror -pthread -I../../usr/include
 
 try-run = $(shell set -e;		\
 	if ($(1)) >/dev/null 2>&1;	\
@@ -52,7 +55,7 @@ oot-clean: OOT_BUILD+=clean
 
 .PHONY: all test mod clean vhost oot oot-clean oot-build
 clean:
-	${RM} *.o vringh_test virtio_test vhost_net_test vhost_test/*.o \
+	${RM} *.o vringh_test virtio_test vhost_net_test vhost_log_test vhost_test/*.o \
               vhost_test/.*.cmd vhost_test/Module.symvers \
               vhost_test/modules.order *.d
 -include *.d
diff --git a/tools/virtio/vhost_log_test.c b/tools/virtio/vhost_log_test.c
new file mode 100644
index 000000000000..96e58bbcdfdc
--- /dev/null
+++ b/tools/virtio/vhost_log_test.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Exercise vhost used-ring dirty logging through /dev/vhost-test. */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <linux/vhost.h>
+#include <linux/virtio_ring.h>
+#include <poll.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <time.h>
+#include <unistd.h>
+#include "../../drivers/vhost/test.h"
+
+#define PAGE_BYTES 4096
+#define RING_NUM 128
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+#define CHECK(c) do { \
+	if (!(c)) { \
+		fprintf(stderr, "FAIL line %d: %s (errno=%d: %s)\n", \
+			__LINE__, #c, errno, strerror(errno)); \
+		exit(EXIT_FAILURE); \
+	} \
+} while (0)
+
+struct queue {
+	int fd;
+	int kick;
+	int call;
+	void *ring;
+	void *data;
+	struct vring_desc *desc;
+	struct vring_avail *avail;
+	struct vring_used *used;
+	uint16_t index;
+};
+
+static void *map_pages(size_t size)
+{
+	void *p = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	CHECK(p != MAP_FAILED);
+	return p;
+}
+
+static void log_base(struct queue *q, void *base)
+{
+	uint64_t addr = (uintptr_t)base;
+
+	CHECK(!ioctl(q->fd, VHOST_SET_LOG_BASE, &addr));
+}
+
+static void queue_init(struct queue *q, void *bitmap, unsigned int bit,
+		       bool logging)
+{
+	struct vhost_vring_state state = { .index = 0, .num = RING_NUM };
+	struct vhost_vring_file file = { .index = 0 };
+	struct vhost_vring_addr addr = { .index = 0 };
+	struct vhost_memory *mem;
+	uint64_t features = 0;
+	unsigned char *scratch;
+	int i, run = 1;
+
+	memset(q, 0, sizeof(*q));
+	q->fd = open("/dev/vhost-test", O_RDWR);
+	CHECK(q->fd >= 0);
+	CHECK(!ioctl(q->fd, VHOST_SET_OWNER, NULL));
+	CHECK(!ioctl(q->fd, VHOST_SET_FEATURES, &features));
+	q->kick = eventfd(0, EFD_NONBLOCK);
+	q->call = eventfd(0, EFD_NONBLOCK);
+	CHECK(q->kick >= 0 && q->call >= 0);
+	q->ring = map_pages(3 * PAGE_BYTES);
+	q->data = map_pages(PAGE_BYTES);
+	q->desc = q->ring;
+	q->avail = q->ring + PAGE_BYTES;
+	q->used = q->ring + 2 * PAGE_BYTES;
+	mem = calloc(1, sizeof(*mem) + sizeof(mem->regions[0]));
+	CHECK(mem);
+	mem->nregions = 1;
+	mem->regions[0].guest_phys_addr = 0;
+	mem->regions[0].userspace_addr = (uintptr_t)q->data;
+	mem->regions[0].memory_size = PAGE_BYTES;
+	CHECK(!ioctl(q->fd, VHOST_SET_MEM_TABLE, mem));
+	free(mem);
+	for (i = 0; i < RING_NUM; i++) {
+		q->desc[i].addr = 0;
+		q->desc[i].len = 1;
+	}
+	CHECK(!ioctl(q->fd, VHOST_SET_VRING_NUM, &state));
+	state.num = 0;
+	CHECK(!ioctl(q->fd, VHOST_SET_VRING_BASE, &state));
+	addr.desc_user_addr = (uintptr_t)q->desc;
+	addr.avail_user_addr = (uintptr_t)q->avail;
+	addr.used_user_addr = (uintptr_t)q->used;
+	addr.flags = logging ? 1U << VHOST_VRING_F_LOG : 0;
+	addr.log_guest_addr = (uint64_t)bit * PAGE_BYTES;
+	CHECK(!ioctl(q->fd, VHOST_SET_VRING_ADDR, &addr));
+	file.fd = q->kick;
+	CHECK(!ioctl(q->fd, VHOST_SET_VRING_KICK, &file));
+	file.fd = q->call;
+	CHECK(!ioctl(q->fd, VHOST_SET_VRING_CALL, &file));
+	/* Starting a queue logs its flags; keep the tested mapping untouched. */
+	scratch = map_pages(PAGE_BYTES);
+	log_base(q, scratch);
+	CHECK(!ioctl(q->fd, VHOST_TEST_RUN, &run));
+	log_base(q, bitmap);
+	CHECK(!munmap(scratch, PAGE_BYTES));
+}
+
+static void queue_submit(struct queue *q, unsigned int count)
+{
+	uint64_t kick = 1;
+	unsigned int i;
+
+	CHECK(count <= RING_NUM);
+	for (i = 0; i < count; i++)
+		q->avail->ring[(q->index + i) % RING_NUM] = i;
+	q->index += count;
+	__atomic_store_n(&q->avail->idx, q->index, __ATOMIC_RELEASE);
+	CHECK(write(q->kick, &kick, sizeof(kick)) == sizeof(kick));
+}
+
+static void queue_wait(struct queue *q)
+{
+	struct pollfd pfd = { .fd = q->call, .events = POLLIN };
+	uint64_t events;
+
+	/* Completion notification follows the dirty-log stores. */
+	do {
+		CHECK(poll(&pfd, 1, 5000) == 1);
+		CHECK(read(q->call, &events, sizeof(events)) == sizeof(events));
+	} while (__atomic_load_n(&q->used->idx, __ATOMIC_ACQUIRE) != q->index);
+}
+
+static void queue_destroy(struct queue *q)
+{
+	/* Release flushes the worker before freeing any userspace mappings. */
+	CHECK(!close(q->fd));
+	CHECK(!close(q->kick));
+	CHECK(!close(q->call));
+	CHECK(!munmap(q->ring, 3 * PAGE_BYTES));
+	CHECK(!munmap(q->data, PAGE_BYTES));
+}
+
+static void exercise(void *bitmap, unsigned int bit, unsigned int count)
+{
+	struct queue q;
+
+	queue_init(&q, bitmap, bit, true);
+	queue_submit(&q, count);
+	queue_wait(&q);
+	queue_destroy(&q);
+}
+
+static void basic_test(void)
+{
+	unsigned char *p = map_pages(2 * PAGE_BYTES);
+	unsigned int offsets[] = { 0, 1, 7, 63, PAGE_BYTES - 1 };
+	unsigned int i, bit;
+
+	CHECK(!mprotect(p + PAGE_BYTES, PAGE_BYTES, PROT_NONE));
+	for (i = 0; i < ARRAY_SIZE(offsets); i++) {
+		for (bit = 0; bit < 8; bit++) {
+			memset(p, 0, PAGE_BYTES);
+			exercise(p + offsets[i], bit, RING_NUM);
+			CHECK(p[offsets[i]] == (1U << bit));
+			if (offsets[i])
+				CHECK(!p[offsets[i] - 1]);
+			if (offsets[i] + 1 < PAGE_BYTES)
+				CHECK(!p[offsets[i] + 1]);
+			p[offsets[i]] = 0xa5;
+			exercise(p + offsets[i], bit, 1);
+			CHECK(p[offsets[i]] == (0xa5 | (1U << bit)));
+		}
+	}
+	CHECK(!munmap(p, 2 * PAGE_BYTES));
+	puts("PASS bits 0..7, repeated sets, unaligned and guarded page end");
+}
+
+static void fault_test(void)
+{
+	unsigned char *p = map_pages(PAGE_BYTES);
+	unsigned char resident;
+	struct queue q;
+
+	queue_init(&q, p, 3, true);
+	CHECK(!mincore(p, PAGE_BYTES, &resident));
+	CHECK(!(resident & 1));
+	queue_submit(&q, 1);
+	queue_wait(&q);
+	queue_destroy(&q);
+	CHECK(*p == 8);
+	*p = 0;
+	CHECK(!mprotect(p, PAGE_BYTES, PROT_READ));
+	exercise(p, 2, 1);
+	CHECK(!*p);
+	CHECK(!mprotect(p, PAGE_BYTES, PROT_NONE));
+	exercise(p, 2, 1);
+	CHECK(!mprotect(p, PAGE_BYTES, PROT_READ | PROT_WRITE));
+	exercise(p, 4, 1);
+	CHECK(*p == 16);
+	queue_init(&q, p, 2, true);
+	CHECK(!munmap(p, PAGE_BYTES));
+	queue_submit(&q, 1);
+	queue_wait(&q);
+	queue_destroy(&q);
+	/* Used-ring logging ignores errors; check survival and no bad write. */
+	puts("PASS first touch, readonly, PROT_NONE, unmapped, recovery");
+}
+
+static void file_test(const char *path)
+{
+	unsigned char *p;
+	unsigned char byte;
+	int fd = open(path, O_CREAT | O_TRUNC | O_RDWR, 0600);
+
+	CHECK(fd >= 0);
+	CHECK(!ftruncate(fd, PAGE_BYTES));
+	p = mmap(NULL, PAGE_BYTES, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	CHECK(p != MAP_FAILED);
+	CHECK(!*p);
+	exercise(p, 5, 1);
+	CHECK(*p == 32);
+	CHECK(pread(fd, &byte, 1, 0) == 1);
+	CHECK(!byte);
+	CHECK(!munmap(p, PAGE_BYTES));
+	p = mmap(NULL, PAGE_BYTES, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	CHECK(p != MAP_FAILED);
+	*p = 0;
+	CHECK(!msync(p, PAGE_BYTES, MS_SYNC));
+	exercise(p, 6, 1);
+	CHECK(*p == 64);
+	CHECK(!msync(p, PAGE_BYTES, MS_SYNC));
+	CHECK(!munmap(p, PAGE_BYTES));
+	CHECK(!fsync(fd));
+	CHECK(!posix_fadvise(fd, 0, PAGE_BYTES, POSIX_FADV_DONTNEED));
+	CHECK(pread(fd, &byte, 1, 0) == 1);
+	CHECK(byte == 64);
+	CHECK(!close(fd));
+	CHECK(!unlink(path));
+	puts("PASS private file COW and shared file sync/re-read");
+}
+
+struct collector {
+	unsigned char *bitmap;
+	bool stop;
+	unsigned char seen;
+};
+
+static void *collect(void *arg)
+{
+	struct collector *c = arg;
+
+	while (!__atomic_load_n(&c->stop, __ATOMIC_ACQUIRE))
+		c->seen |= __atomic_exchange_n(c->bitmap, 0, __ATOMIC_SEQ_CST);
+	return NULL;
+}
+
+static void concurrent_test(void)
+{
+	unsigned char *p = map_pages(PAGE_BYTES);
+	struct queue q[8];
+	struct collector c = { .bitmap = p };
+	pthread_t thread;
+	unsigned int bit, round;
+
+	for (bit = 0; bit < 8; bit++)
+		queue_init(&q[bit], p, bit, true);
+	for (round = 0; round < 1000; round++) {
+		__atomic_store_n(p, 0, __ATOMIC_SEQ_CST);
+		for (bit = 0; bit < 8; bit++)
+			queue_submit(&q[bit], 1);
+		for (bit = 0; bit < 8; bit++)
+			queue_wait(&q[bit]);
+		CHECK(__atomic_load_n(p, __ATOMIC_SEQ_CST) == 255);
+	}
+	for (round = 0; round < 1000; round++) {
+		__atomic_store_n(p, 0, __ATOMIC_SEQ_CST);
+		c.stop = false;
+		c.seen = 0;
+		CHECK(!pthread_create(&thread, NULL, collect, &c));
+		for (bit = 0; bit < 8; bit++)
+			queue_submit(&q[bit], RING_NUM);
+		for (bit = 0; bit < 8; bit++)
+			queue_wait(&q[bit]);
+		__atomic_store_n(&c.stop, true, __ATOMIC_RELEASE);
+		CHECK(!pthread_join(thread, NULL));
+		c.seen |= __atomic_exchange_n(p, 0, __ATOMIC_SEQ_CST);
+		CHECK(c.seen == 255);
+	}
+	for (bit = 0; bit < 8; bit++)
+		queue_destroy(&q[bit]);
+	CHECK(!munmap(p, PAGE_BYTES));
+	puts("PASS eight workers sharing a byte, concurrent atomic collection");
+}
+
+static void alias_test(const char *path)
+{
+	unsigned char *p, *alias;
+	struct queue q[8];
+	unsigned int bit, round;
+	int fd = open(path, O_CREAT | O_TRUNC | O_RDWR, 0600);
+
+	CHECK(fd >= 0);
+	CHECK(!ftruncate(fd, PAGE_BYTES));
+	p = mmap(NULL, PAGE_BYTES, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	alias = mmap(NULL, PAGE_BYTES, PROT_READ | PROT_WRITE, MAP_SHARED,
+		     fd, 0);
+	CHECK(p != MAP_FAILED && alias != MAP_FAILED);
+	for (bit = 0; bit < 8; bit++)
+		queue_init(&q[bit], bit & 1 ? alias : p, bit, true);
+	for (round = 0; round < 1000; round++) {
+		__atomic_store_n(p, 0, __ATOMIC_SEQ_CST);
+		/* Keep one alias writable, and force faults through the other. */
+		CHECK(!madvise(alias, PAGE_BYTES, MADV_DONTNEED));
+		for (bit = 0; bit < 8; bit++)
+			queue_submit(&q[bit], 1);
+		for (bit = 0; bit < 8; bit++)
+			queue_wait(&q[bit]);
+		CHECK(__atomic_load_n(p, __ATOMIC_SEQ_CST) == 255);
+	}
+	for (bit = 0; bit < 8; bit++)
+		queue_destroy(&q[bit]);
+	CHECK(!munmap(p, PAGE_BYTES));
+	CHECK(!munmap(alias, PAGE_BYTES));
+	CHECK(!close(fd));
+	CHECK(!unlink(path));
+	puts("PASS shared-file aliases with repeated PTE faults");
+}
+
+static uint64_t now_ns(void)
+{
+	struct timespec ts;
+
+	CHECK(!clock_gettime(CLOCK_MONOTONIC, &ts));
+	return (uint64_t)ts.tv_sec * 1000000000 + ts.tv_nsec;
+}
+
+static void benchmark(bool logging, unsigned int batches)
+{
+	unsigned char *p = map_pages(PAGE_BYTES);
+	struct queue q;
+	uint64_t start, elapsed;
+	unsigned int i;
+
+	*p = 0;
+	queue_init(&q, p, 0, logging);
+	for (i = 0; i < 100; i++) {
+		queue_submit(&q, RING_NUM);
+		queue_wait(&q);
+	}
+	start = now_ns();
+	for (i = 0; i < batches; i++) {
+		queue_submit(&q, RING_NUM);
+		queue_wait(&q);
+	}
+	elapsed = now_ns() - start;
+	queue_destroy(&q);
+	CHECK(*p == (logging ? 1 : 0));
+	printf("BENCH logging=%u descriptors=%u elapsed_ns=%" PRIu64
+	       " ns_per_desc=%.2f\n", logging, batches * RING_NUM,
+	       elapsed, (double)elapsed / (batches * RING_NUM));
+	CHECK(!munmap(p, PAGE_BYTES));
+}
+
+int main(int argc, char **argv)
+{
+	const char *path = argc > 1 ? argv[1] : "/tmp/vhost-log-test";
+
+	CHECK(sysconf(_SC_PAGESIZE) == PAGE_BYTES);
+	if (argc == 2 && !strcmp(argv[1], "--bench")) {
+		benchmark(false, 10000);
+		benchmark(true, 10000);
+		return 0;
+	}
+	basic_test();
+	fault_test();
+	file_test(path);
+	concurrent_test();
+	alias_test(path);
+	puts("PASS vhost dirty-log regression suite");
+	return 0;
+}
diff --git a/tools/virtio/vhost_log_test.rst b/tools/virtio/vhost_log_test.rst
new file mode 100644
index 000000000000..7652506e7400
--- /dev/null
+++ b/tools/virtio/vhost_log_test.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Vhost dirty-log regression test
+==============================
+
+``vhost_log_test`` exercises used-ring logging through the existing
+``/dev/vhost-test`` interface. It requires a test kernel with vhost support
+and the ``vhost_test`` module built from ``tools/virtio/vhost_test`` for that
+same kernel. Run it in a disposable VM, with permission to open the device.
+
+Build the userspace executable from the kernel source root::
+
+  make -C tools/virtio vhost_log_test
+
+For a static initramfs executable, use ``LDFLAGS="-static -pthread"`` on a
+clean build. Load ``vhost``, its dependencies, and ``vhost_test`` in the
+guest, then run::
+
+  ./vhost_log_test /mnt/vhost-log-scratch
+
+The path is a disposable scratch file: the test truncates and removes it.
+Use a disk-backed filesystem such as ext4 to exercise file writeback.
+Omitting the path uses ``/tmp/vhost-log-test``. The test currently requires
+4 KiB pages and the native little-endian legacy vring layout; runtime
+coverage is intended for x86.
+
+The suite covers every bit within a byte, repeated sets, neighboring-byte
+preservation, unaligned byte addresses, a guarded page end, first touch,
+inaccessible mappings and recovery, private COW, shared-file sync/reread,
+eight workers sharing a byte, and concurrent userspace atomic collection.
+The collector checks each of 1000 independent rounds. Another 1000 rounds
+use two aliases of a shared file page and discard one alias's PTEs before
+each round, exercising resident and faulting accesses to the same bitmap.
+
+Used-ring logging currently discards ``log_used()`` errors. Consequently,
+the inaccessible-mapping cases check survival, absence of a successful
+write and recovery; they do not verify userspace-visible ``-EFAULT``.
+The collector verifies that all eight bits were observed in each round,
+not that every repeated dirty event was counted. Alias tests exercise
+fault fallback but do not establish a deterministic instruction ordering.
+These tests do not replace MM race analysis or live migration testing.
+
+Run the benchmark separately::
+
+  taskset -c 0 ./vhost_log_test --bench
+
+Each logging-disabled/enabled measurement warms up with 100 batches,
+then times 10000 batches of 128 descriptors. The result includes queue
+submission, worker execution and completion notification. It measures
+nanoseconds per descriptor, not isolated ``set_bit_to_user()`` latency,
+network throughput or migration time. Keep the kernel configuration and
+VM setup identical, alternate baseline/optimized runs, and report multiple
+samples. Affinity applies to the guest CPU; host CPU placement is separate.
-- 
2.43.0

