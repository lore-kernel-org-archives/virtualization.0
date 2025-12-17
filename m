Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CC2D6E71
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995164; cv=none; b=TyY9yqOqt/vkAkRIaQOuhhnHhxetXfBSllBDbb+yoYMF0DKJ+ABNtNCe9gikqpjDwLrH4x7ARjTL94NoF6iEcZR0vx++/nUEG3Sbnr6AXWZhrVXWu3kVy9cziNICUHZw1lh2knRu27FBJCuYe57H5VojF3zi3xYRl+d91mtvRJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995164; c=relaxed/simple;
	bh=Btn/e79eN7ovQAPmHnhb0d8yhq10fIOSyLkws8LR2uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gifw/DZp2tVEdqc/Da4RbT1nauRF8V2oke3Mp+hNk7+FG3FcqNJ+nr3OheNoskmCLPv8Scps8pzZpoxV3ZfE1nA/MuYinnJDOqHb9LAkNBAN3oDHSuHgg10UQPfSgVyNSQf3950kG43Du8WxiV96uEPMYSMVvyuBTfVLbueLuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2nvHK9X; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2nvHK9X"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5942b58ac81so4749783e87.2
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 10:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995155; x=1766599955; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWDVTcbeN5bBA7b/fB7A8gJyMmAFiIZBGr/pLyGnvWw=;
        b=U2nvHK9Xh8Flrczkv4151SPXAUG/V4Yc4O80R3nYMXjrV2/mdyQhbWuYY1wjF0FRp2
         TuetsToi0Y0z949DdgHmXkBBbMd0vLJaxUIllzUKWiRaTjnT+DW5bs5p0r3nZuQL3N1i
         4OGwAN4MJ5YjG2LMwj8IqAAycbTxrbp4PmuQI68WiNAdsoIYtSZkz3ZJDgA+SeZPHUxK
         8XuXbPLxrm3mvaqTnjYHu6bd0TES8LNWP61vVczgPKVTO/zujQ5VvPO+0kQC/gbaD8lY
         5wIWminOieK3YCzGsSyHuEfA+fY49CFBb6acjwUnQMUgWuxgbuEeq4+ZXyGAzRk91Cvg
         0l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995155; x=1766599955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWDVTcbeN5bBA7b/fB7A8gJyMmAFiIZBGr/pLyGnvWw=;
        b=j5Yu7gPBDukqO/2d07p0In2csfGWSQAgimfSkM0s1i0Ylf2Lk4OthgfyQ6rcKpEbuO
         ghRw3XGKfWlgTWuZoUix2sx72iU7ygZ3AktpW4xiPihzIxwGcKYAHoAUKmI5nyDYbohU
         kY/9AGZLKHE3eRarztFJxxdTlwixJ5Pk+WylyvGrksw4XeVpERTP2e63qL41YeHhnwMT
         EOQtgTnf25eM6PZWyLFxxVX5ALC+RBI5FRyFt7s1GpWUdhJzLtyr7tUVWVbdF4LExEb7
         FHBxTunpjisJbpXH/oUGmvhtU74TZjxoTbWXwvuaMkkuSV6pdzscFEaSmYy7mvZ+ifGE
         wg8w==
X-Forwarded-Encrypted: i=1; AJvYcCWptZNSn958iGVm005FFNqIwXWyGDCZtq2vqehALTG/z4QXDyezJTPQCe6jqRi9w6P6dYSgsxzEnJKJ5n/XVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YylLHEdIZN/gP8b1wU1D+n/ln80xkXjxgFXBgBE/GY8hXvI3GJb
	jq1g5l0I2dE9XjRF4BoyAO4X6OjiyKSstzkM+fXYLuQmvnNuQCWI+p9y
X-Gm-Gg: AY/fxX6jAClKbRAAHxp48w/ZhZciGBWtgtKr16jN0QW8/tJKtTkHptYfgtkohsKU8he
	R0y/ry+tqVmbeSKWWLrztpDzL/2b98zVq/hYPMoynhYyqh0rvr4U6/ihyworWxCRPyEHM8tnKvk
	NWq9doBdpxSaBynpMOj6kJiIXAwzybtl1bnhVgnhoWZ8dL2lcMd9UJtMnZ4tOl7sJCb2tlxtl3o
	MAStBPWeR6Vgr7lYs367YBsfbSWULIsA9aw18zEd2o8pEH1Lj8meBXSzc0GSHMIDoxxajdP5YwQ
	V8RmmUHbZzNubnLt8y9cqVu3DwHqIo8JFwTi3F0GPT5pi2HpIuOtrJjy08+tGnJumYAJvfBGSnX
	OIH75fOp/j37Swdam8RhJa8J2j6aDSlonYzpJt1uh6MKd3GaehK6dHdml7PG2Y5U5Kjumg8DIqF
	n5Xq2B9nyN02I=
X-Google-Smtp-Source: AGHT+IGKE6+oXrVS7pwbxHPAdksD1QodGnRBGOe+h7uD8J+gXsamVw7BpLRSwSnFwpf8bb0Jng+hIA==
X-Received: by 2002:a05:6512:3d07:b0:59a:107a:45a5 with SMTP id 2adb3069b0e04-59a107a46cdmr754855e87.23.1765995154644;
        Wed, 17 Dec 2025 10:12:34 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:34 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v4 4/4] vsock/test: add stream TX credit bounds test
Date: Wed, 17 Dec 2025 19:12:06 +0100
Message-Id: <20251217181206.3681159-5-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217181206.3681159-1-mlbnkm1@gmail.com>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for the TX credit bounds fix. The test verifies
that a sender with a small local buffer size cannot queue excessive
data even when the peer advertises a large receive buffer.

The client:
  - Sets a small buffer size (64 KiB)
  - Connects to server (which advertises 2 MiB buffer)
  - Sends in non-blocking mode until EAGAIN
  - Verifies total queued data is bounded

This guards against the original vulnerability where a remote peer
could cause unbounded kernel memory allocation by advertising a large
buffer and reading slowly.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 tools/testing/vsock/vsock_test.c | 103 +++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 0e8e173dfbdc..9f4598ee45f9 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -347,6 +347,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 }
 
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
+#define SMALL_SOCK_BUF_SIZE (64 * 1024ULL)
 #define MAX_MSG_PAGES 4
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
@@ -2203,6 +2204,103 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_tx_credit_bounds_client(const struct test_opts *opts)
+{
+	unsigned long long sock_buf_size;
+	char buf[4096];
+	size_t total = 0;
+	ssize_t sent;
+	int fd;
+	int flags;
+
+	memset(buf, 'A', sizeof(buf));
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	sock_buf_size = SMALL_SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
+	flags = fcntl(fd, F_GETFL);
+	if (flags < 0) {
+		perror("fcntl(F_GETFL)");
+		exit(EXIT_FAILURE);
+	}
+
+	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0) {
+		perror("fcntl(F_SETFL)");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SRVREADY");
+
+	for (;;) {
+		sent = send(fd, buf, sizeof(buf), 0);
+		if (sent > 0) {
+			total += sent;
+			continue;
+		}
+		if (sent < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
+			break;
+
+		perror("send");
+		exit(EXIT_FAILURE);
+	}
+
+	/*
+	 * With TX credit bounded by local buffer size, sending should
+	 * stall quickly. Allow some overhead but fail if we queued an
+	 * unreasonable amount.
+	 */
+	if (total > (size_t)(SMALL_SOCK_BUF_SIZE * 4)) {
+		fprintf(stderr,
+			"TX credit too large: queued %zu bytes (expected <= %llu)\n",
+			total, (unsigned long long)(SMALL_SOCK_BUF_SIZE * 4));
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("CLIDONE");
+	close(fd);
+}
+
+static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
+{
+	unsigned long long sock_buf_size;
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Server advertises large buffer; client should still be bounded */
+	sock_buf_size = SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
+	control_writeln("SRVREADY");
+	control_expectln("CLIDONE");
+
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2382,6 +2480,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_unread_bytes_client,
 		.run_server = test_seqpacket_unread_bytes_server,
 	},
+	{
+		.name = "SOCK_STREAM TX credit bounds",
+		.run_client = test_stream_tx_credit_bounds_client,
+		.run_server = test_stream_tx_credit_bounds_server,
+	},
 	{},
 };
 
-- 
2.34.1

