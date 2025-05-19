Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E62676DC
	for <virtualization@lists.linux.dev>; Mon, 19 May 2025 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638441; cv=none; b=Tk+5iW0RqtX4n2Tnb6zwpj7LJicG0mhegYBQeItoCKJyC6GOB7VWxE6bb+Mdtlf/nFwHJijodDWVCtw8jKwrxmmSht/Iu+4eoQyroWx/x0oXCjr+FMRxWu9X9y7/Rar6vge11itX3SVqCPhHctHHhHoi5zyxvPu5rS3NZ2fh0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638441; c=relaxed/simple;
	bh=lR0efES/TyHPp4CcTBk6Ai5txdkjK+8TK75tfxkp6xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRVrgYROxJ36ZjJjAXz5cejejB/D6+PedTivFGTn6HlfxZq4w32NLT2i4lzw/WliKZGznktGfAjMi4nlsuGx17FjV+g2mfaw5QJ2VrAsCEFE1AoxXiBHjSOdzDzAPvxZSOu2LNfnA6d9+szmgs0NlqQmUO/cmEfrNy1ipef9nls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krFGFbHG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krFGFbHG"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30ec226b7d6so1139383a91.2
        for <virtualization@lists.linux.dev>; Mon, 19 May 2025 00:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747638438; x=1748243238; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAhF0WSXalG9ecvsiVvvYCkMdMtzERZ5TCfWvYr6e80=;
        b=krFGFbHGdoTnaUWsb/D//uMZDKxE43zeq6VbXmRs6rbU/k7J0VrSmz6jHacT2BZnMZ
         eUF8CdajTI/TTGVTLXYpccCI5DofeqOjxh1MczuuSBb6duA4U7OXGrgW+Ts8rYSRUX4f
         0KZ3yYYBWRUR86ebiSrszlHcWbq437Ea44ioA7MwgypkEnX4QE95h/kCgcmsV2y6K2MZ
         7IcQT4BL5oBHBX5fQ6/ENQf8PaznFDURIqot/X8GjLqyl/hoFSDrNFmFq8dbB0oSSOZG
         P8WUELnMA61o9LIWMELnzySLo5pyDmtwELE4KuQulL8oEhTMu47YZAZVl2v8vOPgfLdu
         kUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638438; x=1748243238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAhF0WSXalG9ecvsiVvvYCkMdMtzERZ5TCfWvYr6e80=;
        b=JBona6HP/SyGeCO4+kAFUPnv2t4OgcFCJKHfOT8wMdigRr0ZbTDgmGvc4SJdLzKJ1T
         8yqJk2csGDSJNB9eA+Rnh6T5iFMJQkp87G9QkmVs+KPRoE0WZrnf3ZD6Tsk1jgxyNN4E
         thryCXMwvjpX8P0C30CHBkTK0Lx5pwYv/swIzUajX6ZEN9/rXdEjRFSYllr/t8tjkh3F
         pvyL6LFuV0Nn1TxqAdhSwoEQLr37Ky3S7uBi7Z331yBNKRCVL5jKbcrUFiGZ0bjUbHAo
         8L07ado+8ktSEberkNMXkqLn9cHnHaRS7rDdYN95DzOewTE0FcXy55NfD83WAJ9xpvtm
         Yb8w==
X-Gm-Message-State: AOJu0YxTeT7+bszouqikfyVZ54RyclcdZ49cgfsek4P6o+7uCwOqhTag
	ccfQpf3+bL7cZIK5BMNo02YlU8t3QW3qB6X7JdxDqefTy0xGP5QZzN7p
X-Gm-Gg: ASbGncv4jaTfPhwiX/VsX2y0HaVxhYuNg9Y52DiaN5s3NTkBuXCoZXenJjqob6ZHRrG
	wa1ms604X6vTGzxF/pnkj5ZuV79cjFhn+AeUN8pQwftFbwhwhZyI/gPRgGIwW3UgvU9Cb3+ydfN
	rUDE+MaD+vlvb4HACAS9/6y79+tWoJ1M1Y9I5Tl6DLM/viOcsseiG9kSGq5vwQ16y0RdpumnOXz
	cKpwD96mc+1tU0hpWPyByUlfJv0yEd5Q/ysGd4QZeBvV/FRv1OgFGMCsV2QBt1PLIzH8ilkkpa3
	q/hBVWpuVdBtQ716jqzRY0FHlt5jWb9Wt6zCYn4viehMF3WdkfMpoZP15cJnUd3/uhwkO+e1tA=
	=
X-Google-Smtp-Source: AGHT+IFjhVjo/YrTw1poiwjhhCJqVvrXmUL2/CBsKqcYhLdcps3ekIFTWSzHoLUkzwFSdsZU0sLlMw==
X-Received: by 2002:a17:90b:5251:b0:308:5273:4dee with SMTP id 98e67ed59e1d1-30e7d542b40mr17676836a91.15.1747638437921;
        Mon, 19 May 2025 00:07:17 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a0120sm5574336a12.63.2025.05.19.00.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:07:17 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	fupan.lfp@antgroup.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	stefanha@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH 3/3] test/vsock: Add ioctl SIOCINQ tests
Date: Mon, 19 May 2025 15:06:49 +0800
Message-Id: <20250519070649.3063874-4-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
References: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds two tests for ioctl SIOCINQ for SOCK_STREAM and
SOCK_SEQPACKET. The client waits for the server to send data, and checks if
the return value of the SIOCINQ is the size of the data. Then, consumes the
data and checks if the value is 0.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 tools/testing/vsock/vsock_test.c | 102 +++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72..8b3fb88e2877 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1282,6 +1282,78 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
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
+	// The data have come in but is not read, the expected value is
+	// MSG_BUF_IOCTL_LEN.
+	ret = ioctl(fd, SIOCINQ, &sock_bytes_unread);
+	if (ret < 0) {
+		if (errno == EOPNOTSUPP) {
+			fprintf(stderr,
+				"Test skipped, SIOCINQ not supported.\n");
+			goto out;
+		} else {
+			perror("ioctl");
+			exit(EXIT_FAILURE);
+		}
+	} else if (ret == 0 && sock_bytes_unread != MSG_BUF_IOCTL_LEN) {
+		fprintf(stderr,
+			"Unexpected 'SIOCOUTQ' value, expected %d, got %i\n",
+			MSG_BUF_IOCTL_LEN, sock_bytes_unread);
+		exit(EXIT_FAILURE);
+	}
+
+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	// The data is consumed, so the expected is 0.
+	ret = ioctl(fd, SIOCINQ, &sock_bytes_unread);
+	if (ret < 0) {
+		// Don't ignore EOPNOTSUPP since we have already checked it!
+		perror("ioctl");
+		exit(EXIT_FAILURE);
+	} else if (ret == 0 && sock_bytes_unread != 0) {
+		fprintf(stderr,
+			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
+			sock_bytes_unread);
+		exit(EXIT_FAILURE);
+	}
+	control_writeln("RECEIVED");
+
+out:
+	close(fd);
+}
+
 static void test_stream_unsent_bytes_client(const struct test_opts *opts)
 {
 	test_unsent_bytes_client(opts, SOCK_STREAM);
@@ -1302,6 +1374,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
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
@@ -1954,6 +2046,16 @@ static struct test_case test_cases[] = {
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

