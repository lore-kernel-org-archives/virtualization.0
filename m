Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D3268FD9
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784341; cv=none; b=VAHpBBmfSE86TDvQQVlNs7TQ8HZL2IyHsGPvdpt+RYPTMdEFxIwlC/AwFYd4g7nVdPw/nmj1GteksLr6hcbhMwRFAojVOO3jJrUIy04HNyZB0XpTNtHOlSGbF/LT0fYIReBNDWrQirAhtTPyGLKQAI0IeZadAkYE4A0I5b9Us70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784341; c=relaxed/simple;
	bh=su6tHM+gBupVdKThuHji8wFuKEgAR/ATOFmWdUd/Zb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DfioYjpCYN6jeLsBO+9yjEE0KUuRkEoO+oiKWYp6ST3sfat71cDzFbqn2+EmDDq1/8esD0Li7EBEVZO1pQFOjmNYXqhIN+N0SOy/2+QegdNamzRm497hMycS0jg5v9d104ZfrC+0LFLsQYPCjSPcA+eLxi2ZJ1yJFZpIYBuVAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwpTI42j; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwpTI42j"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so1041243a12.1
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 20:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749784338; x=1750389138; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFjmyN0nuW0ybI1fW+EqrHnDVCIapf1qjyihsbGmNzw=;
        b=fwpTI42jxwbD7oY2Eh/E3fzykPyMiB8AZKv32UpoOz8LP3UCdw2aLnZMamXzfoc+du
         qswoOsSe7vRVX3ujsxL84kWwJZsWVtAxLfYPSlLiSFll04IZgwhgb64HOEqRPyQFntql
         d1zw45CbNMPS/5kE/8INmzB1/NYOBd28GWHbJpREt/pyVSmVnYTVfKU3O9n8DMO4Duxq
         edXurU/EVdlxok7jZMw0zrYdTEUSNFJOzrpKqNmTFzgvp98tLY6PVGU9Xh/XNAYOeYgL
         aE2Y2WRoply552mQOpMvbYzrovKtWpaJOVBmOc7+E3V2jutDx8ircBwyEd4mVfDAXZDK
         MuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749784338; x=1750389138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFjmyN0nuW0ybI1fW+EqrHnDVCIapf1qjyihsbGmNzw=;
        b=oWdUneGbcRiLaeMtd+zmxMFBZHtzjJ9zG1trdV4uyKbT0wYNoORZgxVME/ZG3Ou2PP
         GTmKCHSOHNnA5cB/EMqmpVWlA3hkFW2gi6s5p0CzHq3ul1CpKTnI4lhQvdvMyG+d9Y8k
         nrTSHeNUiXF3a98XXD8nOKvGrTcRgjbB4kclojxg+CMpAQJCOORUwTj2TqwS98DjndXK
         CBnTiWTevL/ScXpWCtaEr3e+ElS+PKTIC85BBOq+STlDeJbdtjZKt5At29i/UTgqCpwH
         KW3uS4pAosxg8r+C/CzGsZdWcxzoWmECNJ1XCK32cdlpgx7w5cq9zKuZ+Ig3MR+qP46l
         fQvQ==
X-Gm-Message-State: AOJu0YwYtxkVRJfEOqyazS0DFMoYDoY4V6qT9bzELgW6ZkdheF2+3ZEp
	ITjhTmvImi3Xd3uLYrNXSHc/qapKH8RzrZbQYYE9Xyv0HQJcDSJwlhrX
X-Gm-Gg: ASbGncuBBL2LMvEv3RZNbbR19UelU1YpUhY92pOiuteXsJ7NnovGGagvtmGyPqAttwG
	m/VINpoArw0SG3uLzzL+pMKb4hFp6FjoTLNQxP2Qyup5DhsyA+KUrPSYDZeuvSOwDFbKw1QxCF5
	Akc85hdpF0yHGvQ0Y90HpoGrfBMkoNiX+LaIg6/Gx7xi/cRTeW0hkEjx5mOqdXECgI/p7k91LeJ
	whaEiC3Cl03LUFbS9M09dfdb10G0id50i9qje8sRGmaKj5D17rC8puTT319F/frViv1AZPH3pfj
	fQxtVwwLvGwrQUJXDCs0lXDIKebiLw3NDvZDedHr37mek6DYmKWnsEPXGRH1QEVzXHTXm77rlud
	BGNbv4MAr
X-Google-Smtp-Source: AGHT+IEtZMzdxeZQg4GE8Orm9l745D/m8tiDw0531kmrlxupMhY5YUGLIK8RXAuqIQTNrU42XiYbPQ==
X-Received: by 2002:a17:90a:d2ce:b0:312:959:dc42 with SMTP id 98e67ed59e1d1-313d9c6719dmr2428070a91.11.1749784337613;
        Thu, 12 Jun 2025 20:12:17 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bcbb39sm2291801a91.8.2025.06.12.20.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:12:17 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stefanha@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v2 3/3] test/vsock: Add ioctl SIOCINQ tests
Date: Fri, 13 Jun 2025 11:11:52 +0800
Message-Id: <20250613031152.1076725-4-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
References: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds SIOCINQ ioctl tests for both SOCK_STREAM and
SOCK_SEQPACKET.

The client waits for the server to send data, and checks if the SIOCINQ
ioctl value matches the data size. After consuming the data, the client
checks if the SIOCINQ value is 0.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 tools/testing/vsock/util.c       | 36 ++++++++++----
 tools/testing/vsock/util.h       |  2 +
 tools/testing/vsock/vsock_test.c | 83 +++++++++++++++++++++++++++++++-
 3 files changed, 111 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 0c7e9cbcbc85..472246198966 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -97,28 +97,46 @@ void vsock_wait_remote_close(int fd)
 	close(epollfd);
 }
 
-/* Wait until transport reports no data left to be sent.
- * Return false if transport does not implement the unsent_bytes() callback.
+/* Wait until ioctl gives an expected int value.
+ * Return a negative value if the op is not supported.
  */
-bool vsock_wait_sent(int fd)
+int ioctl_int(int fd, unsigned long op, int *actual, int expected)
 {
-	int ret, sock_bytes_unsent;
+	int ret;
+	char name[32];
+
+	if (!actual) {
+		fprintf(stderr, "%s requires a non-null pointer\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
 
 	timeout_begin(TIMEOUT);
 	do {
-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
+		ret = ioctl(fd, op, actual);
 		if (ret < 0) {
 			if (errno == EOPNOTSUPP)
 				break;
 
-			perror("ioctl(SIOCOUTQ)");
+			perror(name);
 			exit(EXIT_FAILURE);
 		}
-		timeout_check("SIOCOUTQ");
-	} while (sock_bytes_unsent != 0);
+		timeout_check(name);
+	} while (*actual != expected);
 	timeout_end();
 
-	return !ret;
+	return ret;
+}
+
+/* Wait until transport reports no data left to be sent.
+ * Return false if transport does not implement the unsent_bytes() callback.
+ */
+bool vsock_wait_sent(int fd)
+{
+	int sock_bytes_unsent;
+
+	return !(ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0));
 }
 
 /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 5e2db67072d5..945c85ff8d22 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -3,6 +3,7 @@
 #define UTIL_H
 
 #include <sys/socket.h>
+#include <sys/ioctl.h>
 #include <linux/vm_sockets.h>
 
 /* Tests can either run as the client or the server */
@@ -54,6 +55,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+int ioctl_int(int fd, unsigned long op, int *actual, int expected);
 bool vsock_wait_sent(int fd);
 void send_buf(int fd, const void *buf, size_t len, int flags,
 	      ssize_t expected_ret);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index f669baaa0dca..43996447f9a2 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -20,7 +20,6 @@
 #include <sys/mman.h>
 #include <poll.h>
 #include <signal.h>
-#include <sys/ioctl.h>
 #include <linux/time64.h>
 
 #include "vsock_test_zerocopy.h"
@@ -1305,6 +1304,58 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
 	close(fd);
 }
 
+static void test_unread_bytes_server(const struct test_opts *opts, int type)
+{
+	unsigned char buf[MSG_BUF_IOCTL_LEN];
+	int client_fd;
+
+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
+	if (client_fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	for (int i = 0; i < sizeof(buf); i++)
+		buf[i] = rand() & 0xFF;
+
+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
+	control_writeln("SENT");
+	control_expectln("RECEIVED");
+
+	close(client_fd);
+}
+
+static void test_unread_bytes_client(const struct test_opts *opts, int type)
+{
+	unsigned char buf[MSG_BUF_IOCTL_LEN];
+	int ret, fd;
+	int sock_bytes_unread;
+
+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SENT");
+	/* The data has arrived but has not been read. The expected is
+	 * MSG_BUF_IOCTL_LEN.
+	 */
+	ret = ioctl_int(fd, TIOCINQ, &sock_bytes_unread, MSG_BUF_IOCTL_LEN);
+	if (ret) {
+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
+		goto out;
+	}
+
+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	// All date has been consumed, so the expected is 0.
+	ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
+	control_writeln("RECEIVED");
+
+out:
+	close(fd);
+}
+
 static void test_stream_unsent_bytes_client(const struct test_opts *opts)
 {
 	test_unsent_bytes_client(opts, SOCK_STREAM);
@@ -1325,6 +1376,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
 }
 
+static void test_stream_unread_bytes_client(const struct test_opts *opts)
+{
+	test_unread_bytes_client(opts, SOCK_STREAM);
+}
+
+static void test_stream_unread_bytes_server(const struct test_opts *opts)
+{
+	test_unread_bytes_server(opts, SOCK_STREAM);
+}
+
+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
+{
+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
+}
+
+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
+{
+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
+}
+
 #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
 /* This define is the same as in 'include/linux/virtio_vsock.h':
  * it is used to decide when to send credit update message during
@@ -2016,6 +2087,16 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_unsent_bytes_client,
 		.run_server = test_seqpacket_unsent_bytes_server,
 	},
+	{
+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
+		.run_client = test_stream_unread_bytes_client,
+		.run_server = test_stream_unread_bytes_server,
+	},
+	{
+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
+		.run_client = test_seqpacket_unread_bytes_client,
+		.run_server = test_seqpacket_unread_bytes_server,
+	},
 	{
 		.name = "SOCK_STREAM leak accept queue",
 		.run_client = test_stream_leak_acceptq_client,
-- 
2.34.1

