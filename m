Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328547DFA7
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988217; cv=none; b=QI0AXgaQ44jUiwm4Qh5ldsCnhTAt5BOWvTXAN5l58JhEpNBq5ww6i8YXPx2Qs17FLJlIshtZe4FTUEh+ibbQS1cPrDSIKhazeb76RA+leYZxZWCdh3veDsuq6ig1mx4dG+XZqTsdHzw61tDOoOefMpEvYelaNtczdam6tkUONis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988217; c=relaxed/simple;
	bh=iqmFsw95eeMyB4kgugRjX3QYRWWCtwCFA+YNnFmxnAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JsAXCAcv7vwdKDqJSKTaM6sOBHkAbhsfPVlxrp3FHy6kauX0UX7rWgTTusFRw9FzGOeyxMyNpwkmicTi0/NZwLQQrrCDusIoilemQyIWsuW/mPIloHwf1m92Audryz7XhvpejK6yhfUDfkByeJfUw31Zq2xSAACU0OgHRPP0vDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCuB2sRN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCuB2sRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oY0QgHfuK6okHlFI9jmjaQHqyNLbsKWPmz3mcrgnNlQ=;
	b=QCuB2sRNj3a6k6PyejV7mrBoBoy1o86jD2PgBBnjO1UPcumAmDDLR8QdMALJh8uA4a7dVt
	rj+sXPlbWhKBOapRJHQSolGXZpzwe5f5qsaziouvv/C7NCmb/nxJhOhcd8iwUf3gAZHUp6
	mI4lG80ad7Hjdxu7WcLWGThWW9fLq7k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-uUHMlXthMO-RbJWoHaFjrQ-1; Wed, 21 Jan 2026 04:36:53 -0500
X-MC-Unique: uUHMlXthMO-RbJWoHaFjrQ-1
X-Mimecast-MFC-AGG-ID: uUHMlXthMO-RbJWoHaFjrQ_1768988212
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4801c1056c7so29610295e9.2
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 01:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988212; x=1769593012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oY0QgHfuK6okHlFI9jmjaQHqyNLbsKWPmz3mcrgnNlQ=;
        b=i+I7dKhL4Xy1Vxsv61rHLIX8q752kKRgRbownKDKH6ZFiN13NdPZ3PoawQ9+LYeSlC
         lUB7huSdnnN2etnL9zhKcJHFpT3r59/Am2MUjsMKQZHADo4EbTz1dpe85OdxDoOQGLSK
         o1XFzEpdA7n38fkW64MiiNBSvMBMz7mokiNM2btkmWXytn1gjxc//homeo0VxrLRququ
         q4w32tnl5fgxjdYJKqXRn+/D6TEhrL7AyErpekqAvfd5GKjqFC26Lm+LkwduL42fqSPU
         8XdMFnIawiGz8PGFNwW0SXZOZ9Na1YzPbSHLoDb9K/4yevRWQ4MExWsp+X77JOP5RiUa
         SnNw==
X-Forwarded-Encrypted: i=1; AJvYcCXcBe2CT+dFLx488wywRtPpZua4iiUuK0ZupIW+HpZc4BAX4/xKA25cKBpY42Q2vKV1lxnb4PtryZlCs88mRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs8FnqhkRnGAtNVeSXUDehOwe8sJHXtdeadADQUd5wANgDcBeD
	Px21AeFznEyZu5X54wexD6bUt3cZAVaDW887MOe+/Nu/MrfU2mvgpBd4kcpmWUhy35vpggRVCaa
	1Z6TbC2mO6GxiyFjdAWd4RhA92KOk3bcf/HPCgnndsWbGseyWXcZnEbX3sjZkBgvjZnco
X-Gm-Gg: AZuq6aLlPi6ZSFs99cdjxNPCMzOTwF6mFlp3zjTPYbVY6QiTcKsE1P/00o4hVI8xlwi
	F95l0rZLKulLuE4b+JnKVfITPys7Hp79Iob3xjdAlbmSzjNfQv4UxMmaJfGqnoae8hIQzoWEMWc
	k2r56ug5tH+x2zriNRqT9aB7PGZFIbDsHw8ah3BQIlOJEMWP0Cq4b5X15UIsEIdA02dnFUxL+M0
	DBDoeHl7KC07jfAsKqoVWyINdVmkt1DZ+3y4iNzlVardM31xb1FCwZLcv4NmxBiYdk9xsr3eAOq
	H1pvPv1eIeLAKDQd4c4qFAAYNHW2g/gu2rlDiAJiyA4Upu2tMNMWYIEWXtAeI0zraGMTkGpl0Vi
	w0QkPlVkMlQ5J2V/a2AM5ymaMThxX2wRdFfP2bnqdZ9XUALmMN3RfdD38jNwc
X-Received: by 2002:a05:600c:4e05:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-480416867d8mr47221995e9.21.1768988212134;
        Wed, 21 Jan 2026 01:36:52 -0800 (PST)
X-Received: by 2002:a05:600c:4e05:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-480416867d8mr47221465e9.21.1768988211696;
        Wed, 21 Jan 2026 01:36:51 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f12ee69sm11893828f8f.11.2026.01.21.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:50 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v6 4/4] vsock/test: add stream TX credit bounds test
Date: Wed, 21 Jan 2026 10:36:28 +0100
Message-ID: <20260121093628.9941-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121093628.9941-1-sgarzare@redhat.com>
References: <20260121093628.9941-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z44d-7fvA-XNdpm1-0KL5fB57eGkfzq8vbUKNHszsEg_1768988212
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Melbin K Mathew <mlbnkm1@gmail.com>

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
[Stefano: use sock_buf_size to check the bytes sent + small fixes]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 101 +++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 668fbe9eb3cc..5bd20ccd9335 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -347,6 +347,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 }
 
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
+#define SOCK_BUF_SIZE_SMALL (64 * 1024)
 #define MAX_MSG_PAGES 4
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
@@ -2230,6 +2231,101 @@ static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_tx_credit_bounds_client(const struct test_opts *opts)
+{
+	unsigned long long sock_buf_size;
+	size_t total = 0;
+	char buf[4096];
+	int fd;
+
+	memset(buf, 'A', sizeof(buf));
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	sock_buf_size = SOCK_BUF_SIZE_SMALL;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
+	if (fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) | O_NONBLOCK) < 0) {
+		perror("fcntl(F_SETFL)");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SRVREADY");
+
+	for (;;) {
+		ssize_t sent = send(fd, buf, sizeof(buf), 0);
+
+		if (sent == 0) {
+			fprintf(stderr, "unexpected EOF while sending bytes\n");
+			exit(EXIT_FAILURE);
+		}
+
+		if (sent < 0) {
+			if (errno == EINTR)
+				continue;
+
+			if (errno == EAGAIN || errno == EWOULDBLOCK)
+				break;
+
+			perror("send");
+			exit(EXIT_FAILURE);
+		}
+
+		total += sent;
+	}
+
+	control_writeln("CLIDONE");
+	close(fd);
+
+	/* We should not be able to send more bytes than the value set as
+	 * local buffer size.
+	 */
+	if (total > sock_buf_size) {
+		fprintf(stderr,
+			"TX credit too large: queued %zu bytes (expected <= %llu)\n",
+			total, sock_buf_size);
+		exit(EXIT_FAILURE);
+	}
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
@@ -2419,6 +2515,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_msgzcopy_mangle_client,
 		.run_server = test_stream_msgzcopy_mangle_server,
 	},
+	{
+		.name = "SOCK_STREAM TX credit bounds",
+		.run_client = test_stream_tx_credit_bounds_client,
+		.run_server = test_stream_tx_credit_bounds_server,
+	},
 	{},
 };
 
-- 
2.52.0

