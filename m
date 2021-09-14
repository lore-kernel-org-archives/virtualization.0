Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C1C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 05:55:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D88E61151
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 05:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D88E61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7139380EB0;
	Tue, 14 Sep 2021 05:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vbBqTJbZsusP; Tue, 14 Sep 2021 05:55:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C416480EAF;
	Tue, 14 Sep 2021 05:55:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92714C0011;
	Tue, 14 Sep 2021 05:55:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA537C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97BB7403A5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QaNgYj0k2V4U
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8CE740266
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:35 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id k24so11707484pgh.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9dtlc83WJJfgtmMSHIvMpzoua+7URr8iSrEvkvLa/UU=;
 b=qXFrEqdpfVsYVNLjGUDh2JzG2/Z35tdTyQK/cNbcCN1Xa7kkLejIOJOd62bIbhx9EM
 lhv6QT3CIG9SgTx28BA6892pgMVoyHZPYeUnCXCgy8FxCL8T7n2vwvPs6t5FLaXtCsuW
 Dq2eots6J0sloWI93+Fd5u7xIUN0nHGJkR2KAtfjFaoYqmbq8KIi11jA974/SRQnuSGk
 vuvduckViZm0sVZBSMs4N58qBYeFJcqJGJMJzIUx5Fc/TldrR/+7GSCrB8DebVfiytV0
 HN0wTh22aEHNKGAemUFf4nP0ssE5dUXPWRN3ChQwuOeeUWSQBNqNpWC1opbj/7dTHvuF
 fIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9dtlc83WJJfgtmMSHIvMpzoua+7URr8iSrEvkvLa/UU=;
 b=MwEUJ2BS7kgsSaouuPMYr0eNGDdvQgNcJlzAAMZu8etStKZ8/qnOd/AgznrxxxHJHQ
 zXH86W1dX5nQhEvJ8ffodRU2v0b+TfZ1lS+FzpUIWuJzT4WkPofaRPRrLD8gcC7azPuB
 ROjX/OENDcVVoN8mnTpyIlMZYnoFUBBqBQk4m2YEtG8jzST94stoORu2xklNTGhKBZ8D
 Ep6hXbi8WUw7/oOya/z7S53BJKrIFQl4SDmKVWSGGbKuohxtF8DUYRbsQIrohZp/RdfW
 MoXBDE0kAsO3//umCnWl6EplGXa+iwR1nBwAZUidSIVynwBHPracxCAmaN8/q5oFlwa9
 1mWw==
X-Gm-Message-State: AOAM532On1QNGSvNS1hm6xy9KuzP95OqAjL26QPdJm1zy18yRBMfFvYh
 rrFM/7BR6qCgQE8jhRLcjRFqCA==
X-Google-Smtp-Source: ABdhPJyomRf3lQ9X6uMtwQCiyz/87puPmc5Np7n6wEOp9dNKkbmJTv29lwvFWWhn/9keDW5RLBVf/g==
X-Received: by 2002:aa7:9f8a:0:b0:43c:39be:23fb with SMTP id
 z10-20020aa79f8a000000b0043c39be23fbmr2995869pfr.57.1631598935206; 
 Mon, 13 Sep 2021 22:55:35 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id v14sm719432pfi.111.2021.09.13.22.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 22:55:34 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: jiangleetcode@gmail.com
Subject: [RFC v2 4/5] vsock_test: add tests for vsock dgram
Date: Tue, 14 Sep 2021 05:54:37 +0000
Message-Id: <20210914055440.3121004-5-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210914055440.3121004-1-jiang.wang@bytedance.com>
References: <20210914055440.3121004-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, stefanha@redhat.com,
 Jakub Kicinski <kuba@kernel.org>, arseny.krasnov@kaspersky.com,
 Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 jhansen@vmware.com
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

Added test cases for vsock dgram types.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 tools/testing/vsock/util.c       | 105 +++++++++++++++++
 tools/testing/vsock/util.h       |   4 +
 tools/testing/vsock/vsock_test.c | 195 +++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 2acbb7703c6a..d2f5b223bf85 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -260,6 +260,57 @@ void send_byte(int fd, int expected_ret, int flags)
 	}
 }
 
+/* Transmit one byte and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *   1 Success
+ */
+void sendto_byte(int fd, const struct sockaddr *dest_addr, int len, int expected_ret,
+				int flags)
+{
+	const uint8_t byte = 'A';
+	ssize_t nwritten;
+
+	timeout_begin(TIMEOUT);
+	do {
+		nwritten = sendto(fd, &byte, sizeof(byte), flags, dest_addr,
+						len);
+		timeout_check("write");
+	} while (nwritten < 0 && errno == EINTR);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (nwritten != -1) {
+			fprintf(stderr, "bogus sendto(2) return value %zd\n",
+				nwritten);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("write");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (nwritten < 0) {
+		perror("write");
+		exit(EXIT_FAILURE);
+	}
+	if (nwritten == 0) {
+		if (expected_ret == 0)
+			return;
+
+		fprintf(stderr, "unexpected EOF while sending byte\n");
+		exit(EXIT_FAILURE);
+	}
+	if (nwritten != sizeof(byte)) {
+		fprintf(stderr, "bogus sendto(2) return value %zd\n", nwritten);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Receive one byte and check the return value.
  *
  * expected_ret:
@@ -313,6 +364,60 @@ void recv_byte(int fd, int expected_ret, int flags)
 	}
 }
 
+/* Receive one byte and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *   1 Success
+ */
+void recvfrom_byte(int fd, struct sockaddr *src_addr, socklen_t *addrlen,
+				int expected_ret, int flags)
+{
+	uint8_t byte;
+	ssize_t nread;
+
+	timeout_begin(TIMEOUT);
+	do {
+		nread = recvfrom(fd, &byte, sizeof(byte), flags, src_addr, addrlen);
+		timeout_check("read");
+	} while (nread < 0 && errno == EINTR);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (nread != -1) {
+			fprintf(stderr, "bogus recvfrom(2) return value %zd\n",
+				nread);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("read");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (nread < 0) {
+		perror("read");
+		exit(EXIT_FAILURE);
+	}
+	if (nread == 0) {
+		if (expected_ret == 0)
+			return;
+
+		fprintf(stderr, "unexpected EOF while receiving byte\n");
+		exit(EXIT_FAILURE);
+	}
+	if (nread != sizeof(byte)) {
+		fprintf(stderr, "bogus recvfrom(2) return value %zd\n", nread);
+		exit(EXIT_FAILURE);
+	}
+	if (byte != 'A') {
+		fprintf(stderr, "unexpected byte read %c\n", byte);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Run test cases.  The program terminates if a failure occurs. */
 void run_tests(const struct test_case *test_cases,
 	       const struct test_opts *opts)
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index a3375ad2fb7f..7213f2a51c1e 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -43,7 +43,11 @@ int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
 void send_byte(int fd, int expected_ret, int flags);
+void sendto_byte(int fd, const struct sockaddr *dest_addr, int len, int expected_ret,
+				int flags);
 void recv_byte(int fd, int expected_ret, int flags);
+void recvfrom_byte(int fd, struct sockaddr *src_addr, socklen_t *addrlen,
+				int expected_ret, int flags);
 void run_tests(const struct test_case *test_cases,
 	       const struct test_opts *opts);
 void list_tests(const struct test_case *test_cases);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 67766bfe176f..fa2605c9d58c 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -199,6 +199,115 @@ static void test_stream_server_close_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_dgram_sendto_client(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = opts->peer_cid,
+		},
+	};
+	int fd;
+
+	/* Wait for the server to be ready */
+	control_expectln("BIND");
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	sendto_byte(fd, &addr.sa, sizeof(addr.svm), 1, 0);
+
+	/* Notify the server that the client has finished */
+	control_writeln("DONE");
+
+	close(fd);
+}
+
+static void test_dgram_sendto_server(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = VMADDR_CID_ANY,
+		},
+	};
+	int fd;
+	int len = sizeof(addr.sa);
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+
+	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Notify the client that the server is ready */
+	control_writeln("BIND");
+
+	recvfrom_byte(fd, &addr.sa, &len, 1, 0);
+	printf("got message from cid:%d, port %u ", addr.svm.svm_cid,
+			addr.svm.svm_port);
+
+	/* Wait for the client to finish */
+	control_expectln("DONE");
+
+	close(fd);
+}
+
+static void test_dgram_connect_client(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = opts->peer_cid,
+		},
+	};
+	int fd;
+	int ret;
+
+	/* Wait for the server to be ready */
+	control_expectln("BIND");
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = connect(fd, &addr.sa, sizeof(addr.svm));
+	if (ret < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	send_byte(fd, 1, 0);
+
+	/* Notify the server that the client has finished */
+	control_writeln("DONE");
+
+	close(fd);
+}
+
+static void test_dgram_connect_server(const struct test_opts *opts)
+{
+	test_dgram_sendto_server(opts);
+}
+
 /* With the standard socket sizes, VMCI is able to support about 100
  * concurrent stream connections.
  */
@@ -252,6 +361,77 @@ static void test_stream_multiconn_server(const struct test_opts *opts)
 		close(fds[i]);
 }
 
+static void test_dgram_multiconn_client(const struct test_opts *opts)
+{
+	int fds[MULTICONN_NFDS];
+	int i;
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = opts->peer_cid,
+		},
+	};
+
+	/* Wait for the server to be ready */
+	control_expectln("BIND");
+
+	for (i = 0; i < MULTICONN_NFDS; i++) {
+		fds[i] = socket(AF_VSOCK, SOCK_DGRAM, 0);
+		if (fds[i] < 0) {
+			perror("socket");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	for (i = 0; i < MULTICONN_NFDS; i++)
+		sendto_byte(fds[i], &addr.sa, sizeof(addr.svm), 1, 0);
+
+	/* Notify the server that the client has finished */
+	control_writeln("DONE");
+
+	for (i = 0; i < MULTICONN_NFDS; i++)
+		close(fds[i]);
+}
+
+static void test_dgram_multiconn_server(const struct test_opts *opts)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} addr = {
+		.svm = {
+			.svm_family = AF_VSOCK,
+			.svm_port = 1234,
+			.svm_cid = VMADDR_CID_ANY,
+		},
+	};
+	int fd;
+	int len = sizeof(addr.sa);
+	int i;
+
+	fd = socket(AF_VSOCK, SOCK_DGRAM, 0);
+
+	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
+		perror("bind");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Notify the client that the server is ready */
+	control_writeln("BIND");
+
+	for (i = 0; i < MULTICONN_NFDS; i++)
+		recvfrom_byte(fd, &addr.sa, &len, 1, 0);
+
+	/* Wait for the client to finish */
+	control_expectln("DONE");
+
+	close(fd);
+}
+
 static void test_stream_msg_peek_client(const struct test_opts *opts)
 {
 	int fd;
@@ -425,6 +605,21 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_msg_trunc_client,
 		.run_server = test_seqpacket_msg_trunc_server,
 	},
+	{
+		.name = "SOCK_DGRAM client close",
+		.run_client = test_dgram_sendto_client,
+		.run_server = test_dgram_sendto_server,
+	},
+	{
+		.name = "SOCK_DGRAM client connect",
+		.run_client = test_dgram_connect_client,
+		.run_server = test_dgram_connect_server,
+	},
+	{
+		.name = "SOCK_DGRAM multiple connections",
+		.run_client = test_dgram_multiconn_client,
+		.run_server = test_dgram_multiconn_server,
+	},
 	{},
 };
 
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
