Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A068FEE645D
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 12:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A17F83C18;
	Fri, 15 Sep 2023 12:15:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A17F83C18
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CSqrGf3W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePsSeoenu1rv; Fri, 15 Sep 2023 12:15:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DBB083BD6;
	Fri, 15 Sep 2023 12:15:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DBB083BD6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30101C0039;
	Fri, 15 Sep 2023 12:15:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62EC6C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D86783BEB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D86783BEB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhRypP26zhQw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4864083BD6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4864083BD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694780111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FP0IT9D2do1i/qXeFKAhCEFBnRZ2j14dkv/qsnZwWc=;
 b=CSqrGf3WBmVVU+zExhHPCtrNwcPygnWsyTQZcR+p3wZy39B/zuOlLwwYntP3bFbq7AN2lw
 obt4a0nJTXdzerWMhjqoa4u2PgNytvIPgUXVsSijafylaZGbHLi2IyFHrd3wzycoQCzS56
 7eKs8B5WaNrY4nUVQ6CvJv7MEjm9Amk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-uYz5BNVnOw66qYsiQuUpHg-1; Fri, 15 Sep 2023 08:15:09 -0400
X-MC-Unique: uYz5BNVnOw66qYsiQuUpHg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f79595669so1295922f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694780108; x=1695384908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FP0IT9D2do1i/qXeFKAhCEFBnRZ2j14dkv/qsnZwWc=;
 b=FqZLBqZKUGCWYhpIfKc/6EYXwDtq3NAltfhtfPawQX8n3yhzUUJvIDYAfURs6/ygxA
 YiVi1lOqCBrWzrQOwx51QhqYsJ7RSCVI0Fo9NCm6pxt2cBXCcyAMkrzcEpc1Hy+MD8kB
 phuyt0GqYgbBNpAADhXqP1zh0Mwut7AO1DhCZ/GqEmyFAQ7w3dADvGTQwBL70TNLNQzc
 xuBaNqURDxAcbRt8oZb4AXBNYWwXUzPgR9r9ES5+7ayhR4Pxnay6qWDakfsA2DLoKO4r
 4VUnjdan84+ZRGJRlzmkxzhMBZWfL1kc6SKMNVic3mWS2liUcXVG5FeTmkbTceOX1hZ3
 Rghg==
X-Gm-Message-State: AOJu0YzlkB/iJTZTqN61/Qxd0RG6ryyMeLM10h8TDnPl2N8P4B3PtbU+
 rFi2UXd03jg9MgC8TnlYJDC4eXLjr5KXk5hF2RqHbQFIm1s6vQ/D9Zvqg3vxTHnom04NyD5y0Re
 AE8mi7RyUt+KfC+P3/FAvMR0TKFjV1cbTwtfQKFQZsQ==
X-Received: by 2002:adf:d202:0:b0:31f:f8a7:a26c with SMTP id
 j2-20020adfd202000000b0031ff8a7a26cmr619573wrh.25.1694780108275; 
 Fri, 15 Sep 2023 05:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJF6T446VPfAO2MFW1Z0pgHTw0vTmbNmzAcUKmbss0UAE9W23X6m2itdgZ2I4QNcEqteZP5Q==
X-Received: by 2002:adf:d202:0:b0:31f:f8a7:a26c with SMTP id
 j2-20020adfd202000000b0031ff8a7a26cmr619554wrh.25.1694780107830; 
 Fri, 15 Sep 2023 05:15:07 -0700 (PDT)
Received: from step1.lan ([46.222.72.72]) by smtp.gmail.com with ESMTPSA id
 d6-20020adfef86000000b0031f82743e25sm4300429wro.67.2023.09.15.05.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 05:15:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 2/5] vsock/test: use recv_buf() in vsock_test.c
Date: Fri, 15 Sep 2023 14:14:49 +0200
Message-ID: <20230915121452.87192-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

We have a very common pattern used in vsock_test that we can
now replace with the new recv_buf().

This allows us to reuse the code we already had to check the
actual return value and wait for all bytes to be received with
an appropriate timeout.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 104 +++++--------------------------
 1 file changed, 17 insertions(+), 87 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 90718c2fd4ea..d1dcbaeb477a 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -301,7 +301,6 @@ static void test_msg_peek_server(const struct test_opts *opts,
 	unsigned char buf_half[MSG_PEEK_BUF_LEN / 2];
 	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
 	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
-	ssize_t res;
 	int fd;
 
 	if (seqpacket)
@@ -315,34 +314,16 @@ static void test_msg_peek_server(const struct test_opts *opts,
 	}
 
 	/* Peek from empty socket. */
-	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT);
-	if (res != -1) {
-		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
-
-	if (errno != EAGAIN) {
-		perror("EAGAIN expected");
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT,
+		 -EAGAIN);
 
 	control_writeln("SRVREADY");
 
 	/* Peek part of data. */
-	res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK);
-	if (res != sizeof(buf_half)) {
-		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
-			sizeof(buf_half), res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_half, sizeof(buf_half), MSG_PEEK, sizeof(buf_half));
 
 	/* Peek whole data. */
-	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK);
-	if (res != sizeof(buf_peek)) {
-		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
-			sizeof(buf_peek), res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek));
 
 	/* Compare partial and full peek. */
 	if (memcmp(buf_half, buf_peek, sizeof(buf_half))) {
@@ -355,22 +336,11 @@ static void test_msg_peek_server(const struct test_opts *opts,
 		 * so check it with MSG_PEEK. We must get length
 		 * of the message.
 		 */
-		res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK |
-			   MSG_TRUNC);
-		if (res != sizeof(buf_peek)) {
-			fprintf(stderr,
-				"recv(2) + MSG_PEEK | MSG_TRUNC, exp %zu, got %zi\n",
-				sizeof(buf_half), res);
-			exit(EXIT_FAILURE);
-		}
+		recv_buf(fd, buf_half, sizeof(buf_half), MSG_PEEK | MSG_TRUNC,
+			 sizeof(buf_peek));
 	}
 
-	res = recv(fd, buf_normal, sizeof(buf_normal), 0);
-	if (res != sizeof(buf_normal)) {
-		fprintf(stderr, "recv(2), expected %zu, got %zi\n",
-			sizeof(buf_normal), res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_normal, sizeof(buf_normal), 0, sizeof(buf_normal));
 
 	/* Compare full peek and normal read. */
 	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek))) {
@@ -900,7 +870,6 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
 	char buf[RCVLOWAT_BUF_SIZE];
 	struct pollfd fds;
-	ssize_t read_res;
 	short poll_flags;
 	int fd;
 
@@ -955,12 +924,7 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 	/* Use MSG_DONTWAIT, if call is going to wait, EAGAIN
 	 * will be returned.
 	 */
-	read_res = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
-	if (read_res != RCVLOWAT_BUF_SIZE) {
-		fprintf(stderr, "Unexpected recv result %zi\n",
-			read_res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf, sizeof(buf), MSG_DONTWAIT, RCVLOWAT_BUF_SIZE);
 
 	control_writeln("POLLDONE");
 
@@ -972,7 +936,7 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 static void test_inv_buf_client(const struct test_opts *opts, bool stream)
 {
 	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
-	ssize_t ret;
+	ssize_t expected_ret;
 	int fd;
 
 	if (stream)
@@ -988,39 +952,18 @@ static void test_inv_buf_client(const struct test_opts *opts, bool stream)
 	control_expectln("SENDDONE");
 
 	/* Use invalid buffer here. */
-	ret = recv(fd, NULL, sizeof(data), 0);
-	if (ret != -1) {
-		fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
-		exit(EXIT_FAILURE);
-	}
-
-	if (errno != EFAULT) {
-		fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
-		exit(EXIT_FAILURE);
-	}
-
-	ret = recv(fd, data, sizeof(data), MSG_DONTWAIT);
+	recv_buf(fd, NULL, sizeof(data), 0, -EFAULT);
 
 	if (stream) {
 		/* For SOCK_STREAM we must continue reading. */
-		if (ret != sizeof(data)) {
-			fprintf(stderr, "expected recv(2) success, got %zi\n", ret);
-			exit(EXIT_FAILURE);
-		}
-		/* Don't check errno in case of success. */
+		expected_ret = sizeof(data);
 	} else {
 		/* For SOCK_SEQPACKET socket's queue must be empty. */
-		if (ret != -1) {
-			fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
-			exit(EXIT_FAILURE);
-		}
-
-		if (errno != EAGAIN) {
-			fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
-			exit(EXIT_FAILURE);
-		}
+		expected_ret = -EAGAIN;
 	}
 
+	recv_buf(fd, data, sizeof(data), MSG_DONTWAIT, expected_ret);
+
 	control_writeln("DONE");
 
 	close(fd);
@@ -1117,7 +1060,6 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 {
 	unsigned char buf[64];
-	ssize_t res;
 	int fd;
 
 	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
@@ -1129,26 +1071,14 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 	control_expectln("SEND0");
 
 	/* Read skbuff partially. */
-	res = recv(fd, buf, 2, 0);
-	if (res != 2) {
-		fprintf(stderr, "expected recv(2) returns 2 bytes, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf, 2, 0, 2);
 
 	control_writeln("REPLY0");
 	control_expectln("SEND1");
 
-	res = recv(fd, buf + 2, sizeof(buf) - 2, 0);
-	if (res != 8) {
-		fprintf(stderr, "expected recv(2) returns 8 bytes, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf + 2, 8, 0, 8);
 
-	res = recv(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT);
-	if (res != -1) {
-		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT, -EAGAIN);
 
 	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
 		fprintf(stderr, "pattern mismatch\n");
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
