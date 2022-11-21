Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECB5C43217
	for <virtualization@archiver.kernel.org>; Mon, 21 Nov 2022 15:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20A5D40448;
	Mon, 21 Nov 2022 15:29:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20A5D40448
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hsguyOAD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jkubq6bkBbQe; Mon, 21 Nov 2022 15:29:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B02A8416F9;
	Mon, 21 Nov 2022 15:29:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B02A8416F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77F42C0032;
	Mon, 21 Nov 2022 15:29:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE1CAC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 15:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2C4E41748
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 15:29:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2C4E41748
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qN5Spl_UttCo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 15:29:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 098C84179F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 098C84179F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669044551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2AQIYR1dMl7tcFPXuSWHrYCKICqQrp32sBDGQ+vqYc=;
 b=hsguyOADCjPYtXYhz8VXKp4d071km4QwfLB+QDgiqr+xs0NHT0aCAR8J61gbbMGn2ctKam
 kHCCAgDSnLqdGgxyrCj3R/lnmTfSRkjgfu4UGcXya6N/woF16RMYGXmQRv98Rb5O97bjxK
 J/oeZZgmJ4oqALLCWOeApzV7JRYvgjg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629--rf2_jw3MgiuYYstvlD2TQ-1; Mon, 21 Nov 2022 10:29:10 -0500
X-MC-Unique: -rf2_jw3MgiuYYstvlD2TQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 fz10-20020a05622a5a8a00b003a4f466998cso12238538qtb.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 07:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2AQIYR1dMl7tcFPXuSWHrYCKICqQrp32sBDGQ+vqYc=;
 b=urrtOeCW4M6+6Kzp73EiPBjoeytVGMKaoMcYqWqdSsW+pKNoOwMJ+rEG+xTxWAibIa
 1QmwqXWy+2GN0hQpTNNmHl8/+vHEkmI/dtUc+0jdT6EEUXVpZX6Z/Pte9vIXTuItC4rH
 Z5rl8x86zQC4iQaCLJBLM1eVzsJBamEb4jDs8KwxzgZKh6u41v+b9jHDaEJxDTPail9G
 HA50dJEhNvoDYk7YDzkXK3pvRPZsE7GwVIflvIvLbh+Xm32EQ6X94kCMKcqPw7tM6gQq
 1NY5gvsjA485A1Jd24Kw84hKScqe4ynOC4sh5czXU35s4ZtqZQdSWqMp4RFKWuyOiQCT
 dinw==
X-Gm-Message-State: ANoB5pn0lvORaADXN/P3RJaUGqJNmM7viV0DEU9/wztLwp8qAww53RlP
 ERv2Ijf0JXCM/4HHAXRshcoAhRJhZ7oxgYHW/FjWE4WDilACT9beoau73E4IBNEIUTtNBQxwHLR
 4rCtJScD9cneWB8KV3iXNAt+A64rTlNf4Y8oVw/xZQg==
X-Received: by 2002:ac8:74c1:0:b0:3a5:5a43:b2da with SMTP id
 j1-20020ac874c1000000b003a55a43b2damr17864095qtr.592.1669044549879; 
 Mon, 21 Nov 2022 07:29:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jS44Xpnqx2ow2UFBq+ebl9Scja/3o91DZRLhbBnMCxshuhx8vN0fQ4b75UhGyxXYwHlgCLw==
X-Received: by 2002:ac8:74c1:0:b0:3a5:5a43:b2da with SMTP id
 j1-20020ac874c1000000b003a55a43b2damr17864064qtr.592.1669044549576; 
 Mon, 21 Nov 2022 07:29:09 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 fd3-20020a05622a4d0300b003a586888a20sm6844287qtb.79.2022.11.21.07.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Nov 2022 07:29:09 -0800 (PST)
Date: Mon, 21 Nov 2022 16:28:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 3/3] test/vsock: vsock_perf utility
Message-ID: <20221121152857.u7xf24vly44ov7di@sgarzare-redhat>
References: <ba294dff-812a-bfc2-a43c-286f99aee0b8@sberdevices.ru>
 <ca655dc0-a827-c4b2-3250-8817c527bfcd@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <ca655dc0-a827-c4b2-3250-8817c527bfcd@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Bobby Eshleman <bobby.eshleman@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 15, 2022 at 08:54:05PM +0000, Arseniy Krasnov wrote:
>This adds utility to check vsock receive performance.

A small example on how to use it here in the commit message would be 
nice.

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/Makefile     |   1 +

Please, can you also update tools/testing/vsock/README ?

> tools/testing/vsock/vsock_perf.c | 386 +++++++++++++++++++++++++++++++
> 2 files changed, 387 insertions(+)
> create mode 100644 tools/testing/vsock/vsock_perf.c
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index f8293c6910c9..d36fdd59fe2e 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -3,6 +3,7 @@ all: test
> test: vsock_test vsock_diag_test
> vsock_test: vsock_test.o timeout.o control.o util.o
> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>+vsock_perf: vsock_perf.o
>
> CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
> .PHONY: all test clean
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>new file mode 100644
>index 000000000000..ca7af08dca46
>--- /dev/null
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -0,0 +1,386 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * vsock_perf - benchmark utility for vsock.
>+ *
>+ * Copyright (C) 2022 SberDevices.
>+ *
>+ * Author: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>+ */
>+#include <getopt.h>
>+#include <stdio.h>
>+#include <stdlib.h>
>+#include <stdbool.h>
>+#include <string.h>
>+#include <errno.h>
>+#include <unistd.h>
>+#include <time.h>
>+#include <sys/mman.h>
>+#include <stdint.h>
>+#include <poll.h>
>+#include <sys/socket.h>
>+#include <linux/vm_sockets.h>
>+
>+#define DEFAULT_BUF_SIZE_BYTES	(128*1024)
>+#define DEFAULT_TO_SEND_BYTES	(64*1024)
>+#define DEFAULT_VSOCK_BUF_BYTES (256*1024)

checkpatch suggests to put spaces around '*' (e.g. 128 * 1024)

>+#define DEFAULT_RCVLOWAT_BYTES	1
>+#define DEFAULT_PORT		1234
>+
>+#define BYTES_PER_GB		(1024 * 1024 * 1024ULL)
>+#define NSEC_PER_SEC		(1000000000ULL)
>+
>+static unsigned int port = DEFAULT_PORT;
>+static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
>+static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
>+
>+static inline time_t current_nsec(void)
>+{
>+	struct timespec ts;
>+
>+	if (clock_gettime(CLOCK_REALTIME, &ts)) {
>+		perror("clock_gettime");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	return (ts.tv_sec * NSEC_PER_SEC) + ts.tv_nsec;
>+}
>+
>+/* From lib/cmdline.c. */
>+static unsigned long memparse(const char *ptr)
>+{
>+	char *endptr;
>+
>+	unsigned long long ret = strtoull(ptr, &endptr, 0);
>+
>+	switch (*endptr) {
>+	case 'E':
>+	case 'e':
>+		ret <<= 10;
>+	case 'P':
>+	case 'p':
>+		ret <<= 10;
>+	case 'T':
>+	case 't':
>+		ret <<= 10;
>+	case 'G':
>+	case 'g':
>+		ret <<= 10;
>+	case 'M':
>+	case 'm':
>+		ret <<= 10;
>+	case 'K':
>+	case 'k':
>+		ret <<= 10;
>+		endptr++;
>+	default:
>+		break;
>+	}
>+
>+	return ret;
>+}
>+
>+static void vsock_increase_buf_size(int fd)
>+{
>+	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+		       &vsock_buf_bytes, sizeof(vsock_buf_bytes))) {
>+		perror("setsockopt");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       &vsock_buf_bytes, sizeof(vsock_buf_bytes))) {
>+		perror("setsockopt");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
>+static int vsock_connect(unsigned int cid, unsigned int port)
>+{
>+	union {
>+		struct sockaddr sa;
>+		struct sockaddr_vm svm;
>+	} addr = {
>+		.svm = {
>+			.svm_family = AF_VSOCK,
>+			.svm_port = port,
>+			.svm_cid = cid,
>+		},
>+	};
>+	int fd;
>+
>+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+
>+	if (fd < 0)
>+		return -1;
>+
>+	vsock_increase_buf_size(fd);
>+
>+	if (connect(fd, &addr.sa, sizeof(addr.svm)) < 0) {
>+		close(fd);
>+		return -1;
>+	}
>+
>+	return fd;
>+}
>+
>+static float get_gbps(unsigned long bytes, time_t ns_delta)
>+{
>+	return ((float)bytes / BYTES_PER_GB) /
>+	       ((float)ns_delta / NSEC_PER_SEC);
>+}
>+
>+static void run_sender(unsigned long to_send_bytes)
>+{
>+	time_t tx_begin_ns;
>+	size_t total_send;
>+	int client_fd;
>+	char *data;
>+	int fd;
>+	union {
>+		struct sockaddr sa;
>+		struct sockaddr_vm svm;
>+	} addr = {
>+		.svm = {
>+			.svm_family = AF_VSOCK,
>+			.svm_port = port,
>+			.svm_cid = VMADDR_CID_ANY,
>+		},
>+	};
>+	union {
>+		struct sockaddr sa;
>+		struct sockaddr_vm svm;
>+	} clientaddr;
>+
>+	socklen_t clientaddr_len = sizeof(clientaddr.svm);
>+
>+	fprintf(stderr, "Run as sender\n");
>+	fprintf(stderr, "Listen port %u\n", port);
>+	fprintf(stderr, "Send %lu bytes\n", to_send_bytes);
>+	fprintf(stderr, "TX buffer %lu bytes\n", buf_size_bytes);
>+	fprintf(stderr, "Peer buffer %lu bytes\n", vsock_buf_bytes);

Why using stderr for this prints?

Also in other places, I think we can use stdout for this kind on prints.

>+
>+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
>+		perror("bind");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (listen(fd, 1) < 0) {
>+		perror("listen");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	client_fd = accept(fd, &clientaddr.sa, &clientaddr_len);
>+
>+	if (client_fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	vsock_increase_buf_size(client_fd);
>+
>+	data = malloc(buf_size_bytes);
>+
>+	if (!data) {
>+		fprintf(stderr, "malloc failed\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	memset(data, 0, buf_size_bytes);
>+	total_send = 0;
>+	tx_begin_ns = current_nsec();
>+
>+	while (total_send < to_send_bytes) {
>+		ssize_t sent;
>+
>+		sent = write(client_fd, data, buf_size_bytes);
>+
>+		if (sent <= 0) {
>+			perror("write");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		total_send += sent;
>+	}
>+
>+	fprintf(stderr, "tx performance: %f Gb/s\n",
>+			get_gbps(total_send, current_nsec() - tx_begin_ns));

checkpatch suggests to align get_gbps with the open parenthesis.

>+
>+	close(client_fd);
>+	close(fd);
>+
>+	free(data);
>+}
>+
>+static void run_receiver(int peer_cid, unsigned long rcvlowat_bytes)
>+{
>+	unsigned int read_cnt;
>+	time_t rx_begin_ns;
>+	time_t in_read_ns;
>+	size_t total_recv;
>+	void *data;
>+	int fd;
>+
>+	fprintf(stderr, "Run as receiver\n");
>+	fprintf(stderr, "Connect to %i:%u\n", peer_cid, port);
>+	fprintf(stderr, "RX buffer %lu bytes\n", buf_size_bytes);
>+	fprintf(stderr, "Peer buffer %lu bytes\n", vsock_buf_bytes);
>+	fprintf(stderr, "SO_RCVLOWAT %lu bytes\n", rcvlowat_bytes);
>+
>+	fd = vsock_connect(peer_cid, port);
>+
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>+		       &rcvlowat_bytes,
>+		       sizeof(rcvlowat_bytes))) {
>+		perror("setsockopt");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	data = mmap(NULL, buf_size_bytes, PROT_READ | PROT_WRITE,
>+		    MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
>+
>+	if (data == MAP_FAILED) {
>+		perror("mmap");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	read_cnt = 0;
>+	in_read_ns = 0;
>+	total_recv = 0;
>+	rx_begin_ns = current_nsec();
>+
>+	while (1) {
>+		struct pollfd fds = { 0 };
>+
>+		fds.fd = fd;
>+		fds.events = POLLIN | POLLERR | POLLHUP |
>+			     POLLRDHUP | POLLNVAL;
>+
>+		if (poll(&fds, 1, -1) < 0) {
>+			perror("poll");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		if (fds.revents & POLLERR) {
>+			fprintf(stderr, "'poll()' error\n");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		if (fds.revents & POLLIN) {
>+			ssize_t bytes_read;
>+			time_t t;
>+
>+			t = current_nsec();
>+			bytes_read = read(fd, data, buf_size_bytes);
>+			in_read_ns += (current_nsec() - t);
>+			read_cnt++;
>+
>+			if (!bytes_read)
>+				break;
>+
>+			if (bytes_read < 0) {
>+				perror("recv");
>+				exit(EXIT_FAILURE);
>+			}
>+
>+			total_recv += bytes_read;
>+		}
>+
>+		if (fds.revents & (POLLHUP | POLLRDHUP))
>+			break;
>+	}
>+
>+	fprintf(stderr, "rx performance %f Gb/s\n",
>+			get_gbps(total_recv, current_nsec() - rx_begin_ns));

checkpatch suggests to align get_gbps with the open parenthesis.

>+	fprintf(stderr, "total in 'read()' %f sec\n", (float)in_read_ns / NSEC_PER_SEC);
>+	fprintf(stderr, "POLLIN wakeups: %i\n", read_cnt);
>+	fprintf(stderr, "average in 'read()' %f ns\n", (float)in_read_ns / read_cnt);
>+
>+	munmap(data, buf_size_bytes);
>+	close(fd);
>+}
>+
>+static void usage(void)
>+{
>+	fprintf(stderr, "Help:\n"
>+			"\n"
>+			"This is benchmarking utility, to test vsock performance.\n"
>+			"It runs in two modes: sender or receiver. In sender mode, it waits\n"
>+			"connection from receiver, and when established, sender starts data\n"



>+			"transmission. Total size of data to send is set by '-m' option.\n"
>+			"\n"
>+			"Meaning of '-b' depends of sender or receiver mode. In sender\n"
>+			"mode, it is size of buffer, passed to 'write()'. In receiver mode,\n"
>+			"it is size of rx buffer passed to 'read()'.\n"

This part is better to put near -b description.

>+			"\n"
>+			"Options:\n"
>+			"  -h				This help message\n"
>+			"  -s				Sender mode(receiver default)\n"
>+			"  -p <port>			Port\n"
>+			"  -c <cid>			CID of the peer\n"
>+			"  -m <bytes to send>		Megabytes to send\n"
>+			"  -b <buffer size>		Depends on sender/receiver mode\n"
>+			"  -v <peer buffer size>	Peer buffer size\n"
>+			"  -r <SO_RCVLOWAT>		SO_RCVLOWAT\n"

Can you print also the default values?
(e.g. "-p <port>  Port (%d)\n" ..., DEFAULT_PORT)

>+			"\n");
>+	exit(EXIT_FAILURE);
>+}
>+
>+int main(int argc, char **argv)
>+{
>+	unsigned long to_send_bytes = DEFAULT_TO_SEND_BYTES;
>+	unsigned long rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
>+	bool receiver_mode = true;
>+	int peer_cid = -1;
>+	int c;
>+
>+	while ((c = getopt(argc, argv, "v:r:c:p:m:b:sh")) != -1) {
>+		switch (c) {
>+		case 'v': /* Peer buffer size. */
>+			vsock_buf_bytes = memparse(optarg);
>+			break;
>+		case 'r': /* SO_RCVLOWAT value. */
>+			rcvlowat_bytes = memparse(optarg);
>+			break;
>+		case 'c': /* CID to connect to. */
>+			peer_cid = atoi(optarg);

Maybe better to use strtol() to check errors.

>+			break;
>+		case 'p': /* Port to connect to. */
>+			port = atoi(optarg);
>+			break;
>+		case 'm': /* Bytes to send. */
>+			to_send_bytes = memparse(optarg);
>+			break;
>+		case 'b': /* Size of rx/tx buffer. */
>+			buf_size_bytes = memparse(optarg);
>+			break;
>+		case 's': /* Sender mode. */
>+			receiver_mode = false;
>+			break;
>+		case 'h': /* Help. */
>+			usage();
>+			break;
>+		default:
>+			usage();
>+

checkpatch: Blank lines aren't necessary before a close brace '}

>+		}
>+	}
>+
>+	if (receiver_mode)
>+		run_receiver(peer_cid, rcvlowat_bytes);
>+	else
>+		run_sender(to_send_bytes);
>+
>+	return 0;
>+}
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
