Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6602C4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 14:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 576DB81A2B;
	Mon,  5 Dec 2022 14:00:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 576DB81A2B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ECBxrFKM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k7C5yf9EGyik; Mon,  5 Dec 2022 14:00:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6838C81B48;
	Mon,  5 Dec 2022 14:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6838C81B48
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39141C0033;
	Mon,  5 Dec 2022 14:00:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8226DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 14:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69D2081C2F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 14:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69D2081C2F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BjznkF0kML0V
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 14:00:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB33B81A2B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB33B81A2B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670248817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8OCKUcvVUiiQ7IfzEODOSINfUx7armQoVZuIx3qsy5I=;
 b=ECBxrFKMZvdkf+FF6h7wXaAhPO8ChPa6PCQnS9MnACoSvxRYB/UrgDw1+THUhVGjg6oY+W
 OOPQzx9Bvtdk9XCW04cctoIM7iVw2y/PCBo1rp4jmG0shGxDneM9SMCc7PWivqBubyj4NM
 /qeBlBIVeIyDyIipbwrMh23I7jHPm9M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-452-03sdq10WPAmKZCea2gxPpA-1; Mon, 05 Dec 2022 09:00:16 -0500
X-MC-Unique: 03sdq10WPAmKZCea2gxPpA-1
Received: by mail-wm1-f71.google.com with SMTP id
 j2-20020a05600c1c0200b003cf7397fc9bso6911669wms.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 06:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OCKUcvVUiiQ7IfzEODOSINfUx7armQoVZuIx3qsy5I=;
 b=TXJwSHoFHMf3YQSZX4f9WzeFGhn8xHsbxB7aUIXqWJQjG+MStEcYmNoVQGeGxIE34d
 +gDHUOB9y0DpwfV5ePIHmmgEASwr1rH/FgU9DLzvUR9fmcEd6EyXPdnjczGpDsXYwa56
 cbU/8CpkSStjcLTRKf6s1J6lM8IzFVhkSzsDh87PSKqQ9PbTLUvph0Ukfc2a+Y0oJCuF
 8pg0XraBClnPTGEI9CJ5wPEdp7XWs4APnCTFTKyiNIgj3tVZw5N4zkGjKtxOGrCzNORR
 TWrU4I3jR9EYKxiB/1sptuoMg5IrDFMC0lEzTYNM12YbMRrL3NjNv4MwxhDNT7H+sBZu
 fdDA==
X-Gm-Message-State: ANoB5pmda1VDxGju16SoAGABtljeASISQuWzGQGCdPNrPujPYuWaGwAu
 KMOppPu4Ojb872yQEhB3qdhO7Q1ed8wjXljKXvYylAxEg/nMYs0n1xcNxNzh4UDTBSHPMnsVYCE
 rZB+TCXJQvcpObUdDLKbtAsy7ogXKdz1zPpZ6Lzl2Nw==
X-Received: by 2002:a5d:48c3:0:b0:241:784b:1b7f with SMTP id
 p3-20020a5d48c3000000b00241784b1b7fmr52016015wrs.38.1670248814959; 
 Mon, 05 Dec 2022 06:00:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4PptkJ602kvEF0ImAHsmpZ3A+evn3kXI2mb1oedVpx07OIOZE15VzNBFrSlPJxLpHVvVjmHQ==
X-Received: by 2002:a5d:48c3:0:b0:241:784b:1b7f with SMTP id
 p3-20020a5d48c3000000b00241784b1b7fmr52015991wrs.38.1670248814636; 
 Mon, 05 Dec 2022 06:00:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 y15-20020a5d4acf000000b00241e5b917d0sm17246682wrs.36.2022.12.05.06.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 06:00:14 -0800 (PST)
Date: Mon, 5 Dec 2022 15:00:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 4/4] test/vsock: vsock_perf utility
Message-ID: <20221205140003.lhtnwoozwaudjfd6@sgarzare-redhat>
References: <6bd77692-8388-8693-f15f-833df1fa6afd@sberdevices.ru>
 <9cc7610f-bcf5-6f77-96fe-4239efb67ca7@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <9cc7610f-bcf5-6f77-96fe-4239efb67ca7@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Sun, Dec 04, 2022 at 07:24:33PM +0000, Arseniy Krasnov wrote:
>This adds utility to check vsock rx/tx performance.
>
>Usage as sender:
>./vsock_perf --port <port> --mb <bytes to send)
>Usage as receiver:
>./vsock_perf --cid <cid> --port <port> --so_rcvlowat <SO_RCVLOWAT>
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/Makefile     |   1 +
> tools/testing/vsock/README       |  34 +++
> tools/testing/vsock/vsock_perf.c | 449 +++++++++++++++++++++++++++++++
> 3 files changed, 484 insertions(+)
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

I think we can add "vsock_perf" to "all" target.

>
> CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
> .PHONY: all test clean
>diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
>index 4d5045e7d2c3..64c5757b7ecc 100644
>--- a/tools/testing/vsock/README
>+++ b/tools/testing/vsock/README
>@@ -35,3 +35,37 @@ Invoke test binaries in both directions as follows:
>                        --control-port=$GUEST_IP \
>                        --control-port=1234 \
>                        --peer-cid=3
>+
>+vsock_perf utility
>+-------------------
>+'vsock_perf' is a simple tool to measure vsock performance. It works in
>+sender/receiver modes: sender waits for connection at specified port,
>+and after accepting it, starts data transmission to the receiver. After data
>+processing is done, it prints several metrics(see below).
>+
>+Usage:
>+# run as sender
>+# listen port 1234, tx buffer size is 1MB, send of 1G data
>+./vsock_perf --sender --port 1234 --buf-size 1MB --mb 1G
>+
>+Output:
>+tx performance: A Gb/s
>+
>+Output explanation:
>+A is calculated as "number of bytes to send" / "time in tx loop"
>+
>+# run as receiver
>+# connect to CID 2, port 1234, rx buffer size is 1MB, peer buf is 1G, SO_RCVLOWAT is 65536
>+./vsock_perf --cid 2 --port 1234 --buf-size 1MB --vsk-size 1G -so_rcvlowat 65536
>+
>+Output:
>+rx performance: A Gb/s
>+total in 'read()': B sec
>+POLLIN wakeups: C
>+average in 'read()': D ns
>+
>+Output explanation:
>+A is calculated as "number of received bytes" / "time in rx loop".
>+B is time, spent in 'read()' system call(excluding 'poll()')
>+C is number of 'poll()' wake ups with POLLIN bit set.
>+D is B / C, e.g. average amount of time, spent in single 'read()'.
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>new file mode 100644
>index 000000000000..69e3b24868d7
>--- /dev/null
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -0,0 +1,449 @@
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
>+#define DEFAULT_BUF_SIZE_BYTES	(128 * 1024)
>+#define DEFAULT_TO_SEND_BYTES	(64 * 1024)
>+#define DEFAULT_VSOCK_BUF_BYTES (256 * 1024)
>+#define DEFAULT_RCVLOWAT_BYTES	1
>+#define DEFAULT_PORT		1234
>+#define DEFAULT_CID		2
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

As for the previous patch, I would add the opt that is failing to make 
it easier to analyze in case of failure.

>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       &vsock_buf_bytes, sizeof(vsock_buf_bytes))) {
>+		perror("setsockopt");

Ditto.

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
>+	printf("Run as sender\n");
>+	printf("Listen port %u\n", port);
>+	printf("Send %lu bytes\n", to_send_bytes);
>+	printf("TX buffer %lu bytes\n", buf_size_bytes);
>+	printf("Peer buffer %lu bytes\n", vsock_buf_bytes);
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
>+		printf("malloc failed\n");
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
>+	printf("tx performance: %f Gb/s\n",
>+	       get_gbps(total_send, current_nsec() - tx_begin_ns));
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
>+	printf("Run as receiver\n");
>+	printf("Connect to %i:%u\n", peer_cid, port);
>+	printf("RX buffer %lu bytes\n", buf_size_bytes);
>+	printf("Peer buffer %lu bytes\n", vsock_buf_bytes);
>+	printf("SO_RCVLOWAT %lu bytes\n", rcvlowat_bytes);
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
>+			printf("'poll()' error\n");
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
>+	printf("rx performance: %f Gb/s\n",
>+	       get_gbps(total_recv, current_nsec() - rx_begin_ns));
>+	printf("total time in 'read()': %f sec\n", (float)in_read_ns / NSEC_PER_SEC);
>+	printf("POLLIN wakeups: %i\n", read_cnt);
>+	printf("average time in 'read()': %f ns\n", (float)in_read_ns / read_cnt);
>+
>+	munmap(data, buf_size_bytes);
>+	close(fd);
>+}
>+
>+static const char optstring[] = "";
>+static const struct option longopts[] = {
>+	{
>+		.name = "help",
>+		.has_arg = no_argument,
>+		.val = 'H',
>+	},
>+	{
>+		.name = "sender",
>+		.has_arg = no_argument,
>+		.val = 'S',
>+	},
>+	{
>+		.name = "port",
>+		.has_arg = required_argument,
>+		.val = 'P',
>+	},
>+	{
>+		.name = "cid",
>+		.has_arg = required_argument,
>+		.val = 'C',
>+	},
>+	{
>+		.name = "mb",
>+		.has_arg = required_argument,
>+		.val = 'M',
>+	},
>+	{
>+		.name = "buf-size",
>+		.has_arg = required_argument,
>+		.val = 'B',
>+	},
>+	{
>+		.name = "vsk-size",
>+		.has_arg = required_argument,
>+		.val = 'V',
>+	},
>+	{
>+		.name = "so_rcvlowat",
>+		.has_arg = required_argument,
>+		.val = 'R',
>+	},
>+	{},
>+};
>+
>+static void usage(void)
>+{
>+	printf("Help:\n"

Instead of "Help:" I would start with:
"Usage: vsock_perf [--help] [options]"


>+	       "\n"
>+	       "This is benchmarking utility, to test vsock performance.\n"
>+	       "It runs in two modes: sender or receiver. In sender mode, it waits\n"
>+	       "connection from receiver, and when established, sender starts data\n"
>+	       "transmission.\n"
>+	       "\n"
>+	       "Options:\n"
>+	       "  --help			This help message\n"
>+	       "  --sender			Sender mode(receiver default)\n"
                                                            ^ space here 
>+	       "  --port <port>			Port (%d)\n"
>+	       "  --cid <cid>			CID of the peer (%d)\n"

IIUC --cid can be used only by the receiver, so maybe better to use
"CID of the sender to connect to"

What about make the sender initiate the connection, while the receiver
listens?
So we could remove "--cid" and use only --sender:

         --sender <cid>       Sender mode (receiver default).
                              <cid> of the receiver to connect to.

And of course updating the description above.


>+	       "  --mb <bytes to send>		Bytes to send (%d)\n"

I would use --bytes and also add KMG as suffix (in all places where
supported).

E.g.              --bytes <bytes to send>KMG    Bytes to send ...

>+	       "  --buf-size <buffer size>	Rx/Tx buffer size (%d). In sender mode\n"
>+	       "                                it is size of buffer passed to 'write()'.\n"

"it is the buffer size"

>+	       "                                In receiver mode it is size of buffer passed\n"

Ditto.

>+	       "                                to 'read()'.\n"
>+	       "  --vsk-size <peer buffer size>	Socket buffer size (%d)\n"
>+	       "  --so_rcvlowat <SO_RCVLOWAT>	SO_RCVLOWAT (%d)\n"

"--rcvlowat <SO_RCVLOWAT>    SO_RCVLOWAT value in bytes"

>+	       "\n", DEFAULT_PORT, DEFAULT_CID, DEFAULT_TO_SEND_BYTES,
>+	       DEFAULT_BUF_SIZE_BYTES, DEFAULT_VSOCK_BUF_BYTES,
>+	       DEFAULT_RCVLOWAT_BYTES);

For the defaults values I would use (default: %d), otherwise is not
clear what that values are.

The rest LGTM!

Thanks,
Stefano

>+	exit(EXIT_FAILURE);
>+}
>+
>+static long strtolx(const char *arg)
>+{
>+	long value;
>+	char *end;
>+
>+	value = strtol(arg, &end, 10);
>+
>+	if (end != arg + strlen(arg))
>+		usage();
>+
>+	return value;
>+}
>+
>+int main(int argc, char **argv)
>+{
>+	unsigned long to_send_bytes = DEFAULT_TO_SEND_BYTES;
>+	unsigned long rcvlowat_bytes = DEFAULT_RCVLOWAT_BYTES;
>+	bool receiver_mode = true;
>+	int peer_cid = DEFAULT_CID;
>+
>+	while (1) {
>+		int opt = getopt_long(argc, argv, optstring, longopts, NULL);
>+
>+		if (opt == -1)
>+			break;
>+
>+		switch (opt) {
>+		case 'V': /* Peer buffer size. */
>+			vsock_buf_bytes = memparse(optarg);
>+			break;
>+		case 'R': /* SO_RCVLOWAT value. */
>+			rcvlowat_bytes = memparse(optarg);
>+			break;
>+		case 'C': /* CID to connect to. */
>+			peer_cid = strtolx(optarg);
>+			break;
>+		case 'P': /* Port to connect to. */
>+			port = strtolx(optarg);
>+			break;
>+		case 'M': /* Bytes to send. */
>+			to_send_bytes = memparse(optarg);
>+			break;
>+		case 'B': /* Size of rx/tx buffer. */
>+			buf_size_bytes = memparse(optarg);
>+			break;
>+		case 'S': /* Sender mode. */
>+			receiver_mode = false;
>+			break;
>+		case 'H': /* Help. */
>+			usage();
>+			break;
>+		default:
>+			usage();
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
