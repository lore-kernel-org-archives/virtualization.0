Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D043CC433ED
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 13:47:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF76613C8
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 13:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF76613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 349AA606C1;
	Thu, 13 May 2021 13:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YKTt0nR6uGTt; Thu, 13 May 2021 13:47:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F79760694;
	Thu, 13 May 2021 13:47:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79593C000E;
	Thu, 13 May 2021 13:47:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EC48C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D2C740408
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMAvlYxWDu0t
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:47:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 574D2403EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620913650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0dkUXbD61yHxsoYQsJu5ao3/IUZG53e3Y4MDccE/hg=;
 b=dR/EPBRuSjW4N/CYZEMIyy73JeRb47RXJX2QZuD2KV5PoB8TTi6lAOnj+oswUD50l1PddJ
 Ng0U9z+hWxQKutzhngNrx1kkrYLzl6h/wJnMQTHI4sWRunbCUcaHt6KxKNnZ2Xy/BVDr4w
 J1/FB60L3Gnr2KG0NHLBoVwlhRXCv4s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-R2nf5W2KPWOzty3UlVm7Ng-1; Thu, 13 May 2021 09:47:27 -0400
X-MC-Unique: R2nf5W2KPWOzty3UlVm7Ng-1
Received: by mail-ej1-f71.google.com with SMTP id
 k9-20020a17090646c9b029039d323bd239so8350287ejs.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 06:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A0dkUXbD61yHxsoYQsJu5ao3/IUZG53e3Y4MDccE/hg=;
 b=DnA31HrEEfJvmeeTaYDJGC14mgcK3URxo/1Zv8pkr/CDN+8cI52Bo7NB4QYqcpX3Qz
 eWjDWkQeD+HWldppN4Dn3nr4yH2rlK1CBBSU8LzjOWDXiizXhtt9mEzMClv6y1wuIK95
 eP8RLu0r+D+YZQ151d7X57lO9ouQaKetDwfM9p1gWVIW/Krm5k4SZlgnSQuuUBjz4jom
 EFtjpHnpDYG1lsUqPtJ1JDDBapxf7brtoUudr8zt3PGqJzqrvFqfz7Qfup7iZL+/E1XI
 QsibQg4ATA+gb8ratpYhoSe9qXbE4iUejB+jdaLco1U+0Z94OGDBj5R6Nw15jq49/Te3
 06Jw==
X-Gm-Message-State: AOAM5320hJjsWRlRt36GDL2DM/0usBucl1/JmA+cce2b/HQZ+F5Mezzd
 UR4870rwgfqVtYblib4ZhYnydAeHAkmn43uIdh9+50L+4N3DBE1FAee1VZN6KFhGp5X51sTReF4
 9zhIkZ9nfSnX1D65jdmJlbD+3VnuQoYjxvRNCgy/GOw==
X-Received: by 2002:a05:6402:1a:: with SMTP id
 d26mr50917873edu.99.1620913646402; 
 Thu, 13 May 2021 06:47:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxguXOshUlXIdgN5o0x789QBKRhPy8p6rcPd+Tw/RguN6tZBLRGwCFOYqpyXK4ryGcq9iJdZw==
X-Received: by 2002:a05:6402:1a:: with SMTP id
 d26mr50917841edu.99.1620913646200; 
 Thu, 13 May 2021 06:47:26 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id x18sm1882118eju.45.2021.05.13.06.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 06:47:25 -0700 (PDT)
Date: Thu, 13 May 2021 15:47:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 17/19] vsock_test: add SOCK_SEQPACKET tests
Message-ID: <20210513134722.i2mn54fsi5pyq4vq@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163704.3432731-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210508163704.3432731-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Sat, May 08, 2021 at 07:37:00PM +0300, Arseny Krasnov wrote:
>This adds two tests of SOCK_SEQPACKET socket: both transfer data and
>then test MSG_EOR and MSG_TRUNC flags. Cases for connect(), bind(),
            ^
We removed the MSG_EOR tests, right?

>etc. are not tested, because it is same as for stream socket.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> tools/testing/vsock/util.c       | 32 +++++++++++++---
> tools/testing/vsock/util.h       |  3 ++
> tools/testing/vsock/vsock_test.c | 63 ++++++++++++++++++++++++++++++++
> 3 files changed, 93 insertions(+), 5 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 93cbd6f603f9..2acbb7703c6a 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -84,7 +84,7 @@ void vsock_wait_remote_close(int fd)
> }
>
> /* Connect to <cid, port> and return the file descriptor. */
>-int vsock_stream_connect(unsigned int cid, unsigned int port)
>+static int vsock_connect(unsigned int cid, unsigned int port, int type)
> {
> 	union {
> 		struct sockaddr sa;
>@@ -101,7 +101,7 @@ int vsock_stream_connect(unsigned int cid, unsigned int port)
>
> 	control_expectln("LISTENING");
>
>-	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+	fd = socket(AF_VSOCK, type, 0);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>@@ -120,11 +120,21 @@ int vsock_stream_connect(unsigned int cid, unsigned int port)
> 	return fd;
> }
>
>+int vsock_stream_connect(unsigned int cid, unsigned int port)
>+{
>+	return vsock_connect(cid, port, SOCK_STREAM);
>+}
>+
>+int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
>+{
>+	return vsock_connect(cid, port, SOCK_SEQPACKET);
>+}
>+
> /* Listen on <cid, port> and return the first incoming connection.  The remote
>  * address is stored to clientaddrp.  clientaddrp may be NULL.
>  */
>-int vsock_stream_accept(unsigned int cid, unsigned int port,
>-			struct sockaddr_vm *clientaddrp)
>+static int vsock_accept(unsigned int cid, unsigned int port,
>+			struct sockaddr_vm *clientaddrp, int type)
> {
> 	union {
> 		struct sockaddr sa;
>@@ -145,7 +155,7 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
> 	int client_fd;
> 	int old_errno;
>
>-	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+	fd = socket(AF_VSOCK, type, 0);
>
> 	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
> 		perror("bind");
>@@ -189,6 +199,18 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
> 	return client_fd;
> }
>
>+int vsock_stream_accept(unsigned int cid, unsigned int port,
>+			struct sockaddr_vm *clientaddrp)
>+{
>+	return vsock_accept(cid, port, clientaddrp, SOCK_STREAM);
>+}
>+
>+int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
>+			   struct sockaddr_vm *clientaddrp)
>+{
>+	return vsock_accept(cid, port, clientaddrp, SOCK_SEQPACKET);
>+}
>+
> /* Transmit one byte and check the return value.
>  *
>  * expected_ret:
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index e53dd09d26d9..a3375ad2fb7f 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -36,8 +36,11 @@ struct test_case {
> void init_signals(void);
> unsigned int parse_cid(const char *str);
> int vsock_stream_connect(unsigned int cid, unsigned int port);
>+int vsock_seqpacket_connect(unsigned int cid, unsigned int port);
> int vsock_stream_accept(unsigned int cid, unsigned int port,
> 			struct sockaddr_vm *clientaddrp);
>+int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
>+			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
> void send_byte(int fd, int expected_ret, int flags);
> void recv_byte(int fd, int expected_ret, int flags);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 5a4fb80fa832..ffec985fd36f 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -14,6 +14,8 @@
> #include <errno.h>
> #include <unistd.h>
> #include <linux/kernel.h>
>+#include <sys/types.h>
>+#include <sys/socket.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -279,6 +281,62 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define MESSAGE_TRUNC_SZ 32
>+static void test_seqpacket_msg_trunc_client(const struct test_opts *opts)
>+{
>+	int fd;
>+	char buf[MESSAGE_TRUNC_SZ];
>+
>+	fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (send(fd, buf, sizeof(buf), 0) != sizeof(buf)) {
>+		perror("send failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SENDDONE");
>+	close(fd);
>+}
>+
>+static void test_seqpacket_msg_trunc_server(const struct test_opts *opts)
>+{
>+	int fd;
>+	char buf[MESSAGE_TRUNC_SZ / 2];
>+	struct msghdr msg = {0};
>+	struct iovec iov = {0};
>+
>+	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SENDDONE");
>+	iov.iov_base = buf;
>+	iov.iov_len = sizeof(buf);
>+	msg.msg_iov = &iov;
>+	msg.msg_iovlen = 1;
>+
>+	ssize_t ret = recvmsg(fd, &msg, MSG_TRUNC);
>+
>+	if (ret != MESSAGE_TRUNC_SZ) {
>+		printf("%zi\n", ret);
>+		perror("MSG_TRUNC doesn't work");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (!(msg.msg_flags & MSG_TRUNC)) {
>+		fprintf(stderr, "MSG_TRUNC expected\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -309,6 +367,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_msg_peek_client,
> 		.run_server = test_stream_msg_peek_server,
> 	},
>+	{
>+		.name = "SOCK_SEQPACKET send data MSG_TRUNC",
>+		.run_client = test_seqpacket_msg_trunc_client,
>+		.run_server = test_seqpacket_msg_trunc_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
