Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795756762;
	b=3HEiiN0pPsjiWMk5sETth9KO8mTMKltQGzIPfzp6kcC+LoIO0WTDlUSpojj+C9E3fC8i
	 STHwJTSzK7bucVtE8t0nAQ749aJy0te+8aLLIe8OEONtzbxzLMpnGJYgsjvj6C60diJJK
	 Ct0fNA2vrxdC3QgFiEzF3TFjYJ6SfAWhFxEQ81B3v7Q9TYo3Dwr2PTzAqfBxtjFfd2/cV
	 Ls6tpPZFz1NW3UMxWhneILL1J6ShLgsqi/9mJDEhN9Tzv68ECtWImyiU+3S8NH6zGxwAl
	 Q8YocwleSlBWVoPY9F8c7DnSUfAZDd9A5uQNbIAzq+RYjnieFGntaZ8bQXsxdV5Gr2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795756762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=s7zN/holnfSRWzR9Ve4qoAtn/yLgIqCtYRzUZEN6Hog=;
	b=oE2MHBjaC2S8EZ2WULijdjJZ+JASPuf9lqPfrb+AHwmIH1swlYhpQNo7QQgVDFWjOjkO
	 H3aD5/VicBf+RymVRZ7v3pr4k9Lq+r4xaXRzUrmr8cV1kdWhJiXS/yzSXSfxdS5pV+CB9
	 gWU91Hp1a/F4cvnwvZS9H+oqLH31W0AmyKAYEHCkZTsksA0Rm05a/FJndIC+Z/26kdFCR
	 iZUnj7JuGoDalf13v8vFY3NPgl54/FjKsBzGnDQa07rJdiTDmcHXQzwclIsHjuJjFlwvv
	 ECHo45lLOQin0eE7Ps+yGMGoDPKpNPWDrQXiba7gvDl2vb6rYK3nDStKKBtUkY6DCEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="coBJFg/m";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7F606A31E
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 05:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83A7F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=coBJFg/m
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-385c497bf94so7102564eec.1
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 21:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1795756762; x=1796361562; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7zN/holnfSRWzR9Ve4qoAtn/yLgIqCtYRzUZEN6Hog=;
        b=coBJFg/mNDE0P7pZCr/Z7lJLf0VKJRbuTOt6biAZNGGfHLtBaxhut1PO/Wi5LP/0xF
         CB/DbeB/ni9omwmY5AfiFeGHA1h6U16toUca79z9SBG+3aNkRUaoKz4fvVWj6qEwq2vX
         XnlTY3iGZ5Kpz3NgtFfl37LqWEKWBi6a4g4oCji+BrxZFo0VUy6jx13mAvb32CNbdR/z
         zVqHxprdLU221IJ9LELV/YJpFGJqNK7JiDdI5T8RWmBmZ6YlCGo9QrKGqSo3TShevYto
         Kio++WpbiWK8H7PrsxRPdf1rB2/+5Poi8Gj7uEjP/+fc8u6Art/HJqBIuRwDHyl2jrQv
         72Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795756762; x=1796361562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7zN/holnfSRWzR9Ve4qoAtn/yLgIqCtYRzUZEN6Hog=;
        b=1QH0bHZjjTq6uqguPyyzJeYWmnLfS6Akb5aEzLmF9EsF0Zn8eCGeO1ZbEnpF+STcn4
         hZYtaeH8eOswUwlEvGZU9yJxRt1W4522pPFQM6wZ1d0PeYzfkNgICdIVveJD1mixcMPn
         WEYa8sgGlId+e3nI2HIBlsl8YwCOPCZdyAlVhROCqqx6h86nSVA3L4WOEz1hgZPS0Het
         E4lZRsDpQdAHxNP8G6C3BZmGFB7hsCU5LXsR1kv0dHk+nccmd5XPx5Dcd0NA6aPOi+ei
         YtbMAi0Y/aVpHkc3Z+oPu+6d6+sxCozRGE8fSsdDiTQbt32YyzxE0GxnDEtGSUmDltlh
         9UNA==
X-Gm-Message-State: APuU4Z+7BEUg0B3f/3ikd5OfktuMEtXsS0dukICemDdJFi1xBVmTzMQQ
	hCP9G4ICS2Yow/Qm9RpizUa3Ere3UUSixjz7SdzUs1m0j1IU3I/EivmVoYzu2744CPu+5mQF2g4
	jVBXZNw==
X-Gm-Gg: AZFdTZdip86ap53+7YUZDCvrze6GXvtpIs/cRCZE2UOjZOn2bL4lJGXygs1IEPxksI8
	UYmd/9f29ZpEny92wv/bTTlmwbs2hcasik8ZdxvMhhRZ+Gg6BjuhtcVxkpsC2/D2m9R8uN09NNN
	Rm43t3sxhO6e3t2XksqjDP082e5un8H7+T1euRpR6neiLJbMal+Vo3fNYuFjE49HxXC7tp6UjEo
	N6Z/q1dLkx8NWWBr+SwhrARxNF45nggeXHu+8fXsemDSo3O5soC6NJK1irTECx+3h6dFIhKEWuv
	4/9NfQ4N5+aFIGt2Ft1bSsqEotYfl9QvTPepR/ewqmmbk9SkdP4G9Js3KpHgHJQXP5xeoAJlh0P
	Fv3hT5EK1yIEqDmdpT7YVGW7UHAPH2Cf1Gx5mM/zkVGXn6ns042QmJCIhySOM10JsWb+eMLQ4H9
	eb0AABVqvANEp2wVDN3a/detc4+ahK8Y2ThWC7FfjL3XSnCEOjcAuw6faQ7M3a2IKFj58r8RYDl
	uvxdXeBDYI32jRI3ftKUQV3vPzgiIZQ6wRuvIMPGe1zVkO+IJV1rJLwPHb9PNOQQ8ahXP+MAYa9
	dgbjeDpgu4cXb43n6OerRitGdUGKE+gsvAJTsO4=
X-Received: by 2002:a05:7300:ce11:b0:385:774:fb23 with SMTP id 5a478bee46e88-3856e63b5cdmr24851388eec.6.1795756761365;
        Thu, 26 Nov 2026 21:19:21 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([174.136.206.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm82950093eec.10.2026.11.26.21.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:19:20 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	horms@kernel.org,
	arseny.krasnov@kaspersky.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/2] vsock: preserve receive timeout across partial reads
Date: Fri, 27 Nov 2026 13:19:12 +0800
Message-ID: <cover.1795587333.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Ruide Cao <caoruide123@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in net/vmw_vsock/af_vsock.c. The bug
is reachable by an unprivileged local user who can connect to an
AF_VSOCK SOCK_STREAM service (the reproducer used VMADDR_CID_LOCAL).
We've tested it, and it should not affect any other functionality.

This bug is tracked at: https://bugtracker.nebusec.ai/f/13843

We will provide detailed information about the bug in this email.

---- details below ----

Bug details:

__vsock_stream_recvmsg() takes the SO_RCVTIMEO value once and passes
it by value to vsock_connectible_wait_data(). The helper updates only
its local copy from schedule_timeout() and does not return the
remaining time. After a partial dequeue below the MSG_WAITALL or
SO_RCVLOWAT target, the stream receive loop calls the helper again
with the original full timeout.

A peer that drip-feeds data just inside each interval can therefore
keep the receive blocked far beyond the configured timeout. This is a
receive-timeout contract violation, not a memory-safety bug.

The first patch changes vsock_connectible_wait_data() to take the
timeout by pointer so the remaining budget is preserved across
partial reads. The seqpacket call site is updated the same way; it
only waits once. The second patch adds a tools/testing/vsock
regression for SOCK_STREAM recv(MSG_WAITALL) against a drip-feeding
peer. The selftest keeps the data socket open until both sides
confirm.

Reproducer:

As an unprivileged local user, create a connected AF_VSOCK SOCK_STREAM
pair on VMADDR_CID_LOCAL. On the receiving end, set SO_RCVTIMEO to 1
second and issue recv(MSG_WAITALL) for 6 bytes. Have the peer send one
byte every 0.8 seconds. On an unfixed kernel the recv returns 6 bytes
after about 4.8 seconds instead of failing or returning partial data
near the 1 second timeout.

We ran the PoC in a 2 GB RAM x86 QEMU environment.

------BEGIN PoC------

#define _GNU_SOURCE
#include <errno.h>
#include <linux/vm_sockets.h>
#include <pthread.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

#define TOTAL_BYTES 6
#define SEND_INTERVAL_USEC 800000
#define RCV_TIMEOUT_SEC 1

struct test_ctx {
	int listener_fd;
	unsigned int port;
};

static void fatal(const char *what)
{
	perror(what);
	exit(1);
}

static double elapsed_seconds(const struct timespec *start,
			      const struct timespec *end)
{
	time_t sec = end->tv_sec - start->tv_sec;
	long nsec = end->tv_nsec - start->tv_nsec;

	if (nsec < 0) {
		sec--;
		nsec += 1000000000L;
	}

	return (double)sec + (double)nsec / 1000000000.0;
}

static void *sender_thread(void *arg)
{
	struct test_ctx *ctx = arg;
	struct sockaddr_vm peer = {
		.svm_family = AF_VSOCK,
	};
	socklen_t peer_len = sizeof(peer);
	int conn_fd;
	char ch = 'A';
	int i;

	conn_fd = accept(ctx->listener_fd, (struct sockaddr *)&peer, &peer_len);
	if (conn_fd < 0)
		fatal("accept");

	fprintf(stdout,
		"sender: accepted peer cid=%u port=%u, sending %d bytes every %.3f s\n",
		peer.svm_cid, peer.svm_port, TOTAL_BYTES,
		(double)SEND_INTERVAL_USEC / 1000000.0);
	fflush(stdout);

	for (i = 0; i < TOTAL_BYTES; i++) {
		ssize_t n;

		usleep(SEND_INTERVAL_USEC);
		n = send(conn_fd, &ch, 1, 0);
		if (n != 1)
			fatal("send");
		fprintf(stdout, "sender: sent byte %d at +%.3f s\n", i + 1,
			(double)(i + 1) * (double)SEND_INTERVAL_USEC / 1000000.0);
		fflush(stdout);
		ch++;
	}

	close(conn_fd);
	return NULL;
}

int main(void)
{
	struct test_ctx ctx = {
		.listener_fd = -1,
	};
	struct sockaddr_vm addr = {
		.svm_family = AF_VSOCK,
		.svm_cid = VMADDR_CID_LOCAL,
		.svm_port = VMADDR_PORT_ANY,
	};
	struct sockaddr_vm bound = {
		.svm_family = AF_VSOCK,
	};
	struct timeval timeout = {
		.tv_sec = RCV_TIMEOUT_SEC,
		.tv_usec = 0,
	};
	struct timespec start;
	struct timespec end;
	socklen_t bound_len = sizeof(bound);
	pthread_t tid;
	char buf[TOTAL_BYTES];
	int client_fd;
	ssize_t n;
	double secs;
	int i;

	ctx.listener_fd = socket(AF_VSOCK, SOCK_STREAM, 0);
	if (ctx.listener_fd < 0)
		fatal("socket(listener)");

	if (bind(ctx.listener_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		fatal("bind(listener)");

	if (getsockname(ctx.listener_fd, (struct sockaddr *)&bound, &bound_len) < 0)
		fatal("getsockname(listener)");

	ctx.port = bound.svm_port;

	if (listen(ctx.listener_fd, 1) < 0)
		fatal("listen");

	fprintf(stdout, "listener: cid=%u port=%u\n", VMADDR_CID_LOCAL, ctx.port);
	fflush(stdout);

	if (pthread_create(&tid, NULL, sender_thread, &ctx) != 0)
		fatal("pthread_create");

	client_fd = socket(AF_VSOCK, SOCK_STREAM, 0);
	if (client_fd < 0)
		fatal("socket(client)");

	if (setsockopt(client_fd, SOL_SOCKET, SO_RCVTIMEO, &timeout,
		       sizeof(timeout)) < 0)
		fatal("setsockopt(SO_RCVTIMEO)");

	addr.svm_port = ctx.port;
	if (connect(client_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		fatal("connect");

	memset(buf, 0, sizeof(buf));
	if (clock_gettime(CLOCK_MONOTONIC, &start) != 0)
		fatal("clock_gettime(start)");

	n = recv(client_fd, buf, sizeof(buf), MSG_WAITALL);

	if (clock_gettime(CLOCK_MONOTONIC, &end) != 0)
		fatal("clock_gettime(end)");

	secs = elapsed_seconds(&start, &end);

	fprintf(stdout,
		"client: recv(MSG_WAITALL, %d) returned %zd after %.3f s (timeout=%d s)\n",
		TOTAL_BYTES, n, secs, RCV_TIMEOUT_SEC);
	if (n >= 0) {
		fprintf(stdout, "client: bytes received:");
		for (i = 0; i < n; i++)
			fprintf(stdout, " %c", buf[i]);
		fprintf(stdout, "\n");
	} else {
		fprintf(stdout, "client: errno=%d (%s)\n", errno, strerror(errno));
	}

	if (n == TOTAL_BYTES && secs > 4.0) {
		fprintf(stdout,
			"RESULT: bug observed. Finite SO_RCVTIMEO did not cap total wait time.\n");
	} else if (n > 0 && secs < 2.0) {
		fprintf(stdout,
			"RESULT: behavior looks fixed. Partial data returned near the original timeout.\n");
	} else {
		fprintf(stdout,
			"RESULT: inconclusive. Re-check timing, transport availability, or system load.\n");
	}

	fflush(stdout);

	close(client_fd);
	pthread_join(tid, NULL);
	close(ctx.listener_fd);
	return 0;
}

------END PoC--------

----BEGIN crash log----

Unprivileged user (test_user, CapEff=0), VMADDR_CID_LOCAL:

listener: cid=1 port=3381025544
sender: accepted peer cid=1 port=3381025545, sending 6 bytes every 0.800 s
sender: sent byte 1 at +0.800 s
sender: sent byte 2 at +1.600 s
sender: sent byte 3 at +2.400 s
sender: sent byte 4 at +3.200 s
sender: sent byte 5 at +4.000 s
sender: sent byte 6 at +4.800 s
client: recv(MSG_WAITALL, 6) returned 6 after 4.816 s (timeout=1 s)
client: bytes received: A B C D E F
RESULT: bug observed. Finite SO_RCVTIMEO did not cap total wait time.

-----END crash log-----

Best regards,
Ruide Cao

Ruide Cao (2):
  vsock: preserve receive timeout across partial reads
  vsock/test: add stream MSG_WAITALL receive timeout test

 net/vmw_vsock/af_vsock.c         |  14 ++--
 tools/testing/vsock/vsock_test.c | 112 +++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 7 deletions(-)


base-commit: cc7fe6e741730fef549e484379281736d32746f0
-- 
2.47.3
