Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C34DEE645A
	for <virtualization@archiver.kernel.org>; Fri, 15 Sep 2023 12:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9F794214A;
	Fri, 15 Sep 2023 12:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9F794214A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XpUMaol7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xq-ZNny2MNym; Fri, 15 Sep 2023 12:15:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B579D420F8;
	Fri, 15 Sep 2023 12:15:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B579D420F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9121EC0039;
	Fri, 15 Sep 2023 12:15:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11296C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E027F41939
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E027F41939
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XpUMaol7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UJP6bymPxVVj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D81E41924
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 12:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D81E41924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694780123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDBE00lKHk1z88MDFMXNFeObsJMvojUkDq7liDEdWcM=;
 b=XpUMaol7PqvIdmfVVU+5s103u5k9X1rIMhEvwJCQstCsIeiv/nfSxWnDtvAzSslrkxWSfM
 4mjJSt85tdkyKb8GMMXmV3txpm4tmfKIuIEaCsbrC1lcOjM/SIrMUtRfrtibQwndx5OnB6
 mRzqax9a7uX6nFYpvDve97kkUFrHaBo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-Ys_8TjGuMV2Nbf_uTEw15Q-1; Fri, 15 Sep 2023 08:15:20 -0400
X-MC-Unique: Ys_8TjGuMV2Nbf_uTEw15Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31aef28315eso1405994f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Sep 2023 05:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694780119; x=1695384919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDBE00lKHk1z88MDFMXNFeObsJMvojUkDq7liDEdWcM=;
 b=jL9Spg6+I22Lw7CJqvRTYmZ9MkUxq5edMIErjesqwQ5z5ZNM/U/2VnKte+KV7jRSTR
 L3K5KgkmSiqKG53hI80IPufkdqGTJ3ybPImnmm1WUz+pZvwzUlS6QBJWu7UqS8M/uxjB
 q7tU2xe0GHQJWgZ65KRAblke+9tJEZ8mwK3mVVLHGi5wQhTP0jYadqUPaNNyHJo3ebGQ
 cLYa1/vqEhwZA+NxQta3JDiCp2U1Rx6WuabE8JZ5vyjd2hZ0QlZXEFOe5+prRZjuXSAC
 OmfpMrRSBh9yMTJsxWRJn5H4nj87pLopvQWVa/RKMUPXAktJORNJ6SUsXZoV1Af8vyd3
 CZSw==
X-Gm-Message-State: AOJu0Yy7brG6Fu2JI4xFJ6bVlbsnT4Ixs+ZY83QzCvCrNcU7oO4f6s9P
 uvWSCTI7njIHS4Q7t6QjIAQrq7QFYspRyjuN0aFKj9H/Yr7OeaaaM+Msh8jQXUR/abTgDN3nMzv
 HRoZwYMqFW0bxHxblttXp7tNI9GXgXIbZhlT2hDEd+Q==
X-Received: by 2002:adf:fb50:0:b0:31f:d7bb:481e with SMTP id
 c16-20020adffb50000000b0031fd7bb481emr1184330wrs.63.1694780119411; 
 Fri, 15 Sep 2023 05:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeyzHuoaEGMp/jTcaIbZGY1B+QuzLExkcenZEXxgsQDgcXpE6ANREgAfuYkNjFwkxggDkAvQ==
X-Received: by 2002:adf:fb50:0:b0:31f:d7bb:481e with SMTP id
 c16-20020adffb50000000b0031fd7bb481emr1184319wrs.63.1694780119150; 
 Fri, 15 Sep 2023 05:15:19 -0700 (PDT)
Received: from step1.lan ([46.222.72.72]) by smtp.gmail.com with ESMTPSA id
 m2-20020a056000174200b0031fe9a47a87sm3054745wrf.112.2023.09.15.05.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 05:15:18 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 4/5] vsock/test: use send_buf() in vsock_test.c
Date: Fri, 15 Sep 2023 14:14:51 +0200
Message-ID: <20230915121452.87192-5-sgarzare@redhat.com>
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
now replace with the new send_buf().

This allows us to reuse the code we already had to check the
actual return value and wait for all the bytes to be sent with
an appropriate timeout.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 75 ++++----------------------------
 1 file changed, 9 insertions(+), 66 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d1dcbaeb477a..b18acbaf92e2 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -261,7 +261,6 @@ static void test_msg_peek_client(const struct test_opts *opts,
 				 bool seqpacket)
 {
 	unsigned char buf[MSG_PEEK_BUF_LEN];
-	ssize_t send_size;
 	int fd;
 	int i;
 
@@ -280,17 +279,7 @@ static void test_msg_peek_client(const struct test_opts *opts,
 
 	control_expectln("SRVREADY");
 
-	send_size = send(fd, buf, sizeof(buf), 0);
-
-	if (send_size < 0) {
-		perror("send");
-		exit(EXIT_FAILURE);
-	}
-
-	if (send_size != sizeof(buf)) {
-		fprintf(stderr, "Invalid send size %zi\n", send_size);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
 
 	close(fd);
 }
@@ -385,7 +374,6 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 	msg_count = SOCK_BUF_SIZE / MAX_MSG_SIZE;
 
 	for (int i = 0; i < msg_count; i++) {
-		ssize_t send_size;
 		size_t buf_size;
 		int flags;
 		void *buf;
@@ -413,17 +401,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 			flags = 0;
 		}
 
-		send_size = send(fd, buf, buf_size, flags);
-
-		if (send_size < 0) {
-			perror("send");
-			exit(EXIT_FAILURE);
-		}
-
-		if (send_size != buf_size) {
-			fprintf(stderr, "Invalid send size\n");
-			exit(EXIT_FAILURE);
-		}
+		send_buf(fd, buf, buf_size, flags, buf_size);
 
 		/*
 		 * Hash sum is computed at both client and server in
@@ -524,10 +502,7 @@ static void test_seqpacket_msg_trunc_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	if (send(fd, buf, sizeof(buf), 0) != sizeof(buf)) {
-		perror("send failed");
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
 
 	control_writeln("SENDDONE");
 	close(fd);
@@ -649,7 +624,6 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
 static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 {
 	unsigned long sock_buf_size;
-	ssize_t send_size;
 	socklen_t len;
 	void *data;
 	int fd;
@@ -676,18 +650,7 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	send_size = send(fd, data, sock_buf_size, 0);
-	if (send_size != -1) {
-		fprintf(stderr, "expected 'send(2)' failure, got %zi\n",
-			send_size);
-		exit(EXIT_FAILURE);
-	}
-
-	if (errno != EMSGSIZE) {
-		fprintf(stderr, "expected EMSGSIZE in 'errno', got %i\n",
-			errno);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, data, sock_buf_size, 0, -EMSGSIZE);
 
 	control_writeln("CLISENT");
 
@@ -741,15 +704,9 @@ static void test_seqpacket_invalid_rec_buffer_client(const struct test_opts *opt
 	memset(buf1, BUF_PATTERN_1, buf_size);
 	memset(buf2, BUF_PATTERN_2, buf_size);
 
-	if (send(fd, buf1, buf_size, 0) != buf_size) {
-		perror("send failed");
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, buf1, buf_size, 0, buf_size);
 
-	if (send(fd, buf2, buf_size, 0) != buf_size) {
-		perror("send failed");
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, buf2, buf_size, 0, buf_size);
 
 	close(fd);
 }
@@ -972,7 +929,6 @@ static void test_inv_buf_client(const struct test_opts *opts, bool stream)
 static void test_inv_buf_server(const struct test_opts *opts, bool stream)
 {
 	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
-	ssize_t res;
 	int fd;
 
 	if (stream)
@@ -985,11 +941,7 @@ static void test_inv_buf_server(const struct test_opts *opts, bool stream)
 		exit(EXIT_FAILURE);
 	}
 
-	res = send(fd, data, sizeof(data), 0);
-	if (res != sizeof(data)) {
-		fprintf(stderr, "unexpected send(2) result %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, data, sizeof(data), 0, sizeof(data));
 
 	control_writeln("SENDDONE");
 
@@ -1023,7 +975,6 @@ static void test_seqpacket_inv_buf_server(const struct test_opts *opts)
 
 static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 {
-	ssize_t res;
 	int fd;
 
 	fd = vsock_stream_connect(opts->peer_cid, 1234);
@@ -1033,22 +984,14 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 	}
 
 	/* Send first skbuff. */
-	res = send(fd, HELLO_STR, strlen(HELLO_STR), 0);
-	if (res != strlen(HELLO_STR)) {
-		fprintf(stderr, "unexpected send(2) result %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, HELLO_STR, strlen(HELLO_STR), 0, strlen(HELLO_STR));
 
 	control_writeln("SEND0");
 	/* Peer reads part of first skbuff. */
 	control_expectln("REPLY0");
 
 	/* Send second skbuff, it will be appended to the first. */
-	res = send(fd, WORLD_STR, strlen(WORLD_STR), 0);
-	if (res != strlen(WORLD_STR)) {
-		fprintf(stderr, "unexpected send(2) result %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, WORLD_STR, strlen(WORLD_STR), 0, strlen(WORLD_STR));
 
 	control_writeln("SEND1");
 	/* Peer reads merged skbuff packet. */
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
