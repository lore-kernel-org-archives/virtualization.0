Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3A4DD3C9
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079037; cv=none; b=NUU1fRUIEkTiM1WegqErAeT20c/EcZ0qdY+9zU5U4Ynsf1Qgp91u+7AHtxvrQc+9maJV7rXh502X63U6g60xPBY7bE+3I2N615iXwkIA/H3/+MwHaAfkuXkGMVWjitopQM+7FuuEiE2pvYjHleUEgXpjvqGT69ukwG1OK0nA8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079037; c=relaxed/simple;
	bh=cjliimpdVuKniQW64DNaS43E2VHJ8S1ZygL4W+E5f/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2z9ep4ueo/8H4kOxCW7Peap6PJZ2c+4Ft+lc/dlwxcN35kKieni4igo1zQCnziuBdNPX4u3JRZN9Lmjos7BGoYeate4BgfXW76iKkyOSSCHo/jbNxW/7E9XE4AuKGWR8hltgbw9zWcQNbAXL1N3h6THFmILMS1xhI20XZhdZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVG9i3jv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVG9i3jv"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so34021715e9.2
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792079023; x=1792683823; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5J5a55Pg+YpfFRUGFYyLBsKQw7Ye+GLO4/t3xMgXcbc=;
        b=AVG9i3jvb+hn+BypiA6/guT+nrfLZ+oNTDAYZCmSYmS5ZgxCxL7KfBjbUpFvFf+5jQ
         O6Q1s2rfLpyjt2oN6NejsePSTxOlE86RLBNg2CMugHvlKxbyjJwWgdc+kD21yxbUSjfs
         /WjZswTLfK8ZJluYny3oC6YlGZwURQfQzI4Qnu6f2xgwRnwNXLztN7yCn4Q+KNHfpOX6
         sQq4RnuGn5iUe+QdPzwGh+jeYrTWuSLFASuh6kaHl+XkFWBoSYd8qbCfqlNL8vnvW2bt
         YUpWFNVLQMbsmxp+5HIYgVXrCaV6h0hgGKt6hbGrNxemXMo6dV5AlzsnhNJOiLrhAfRu
         Orqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792079023; x=1792683823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5J5a55Pg+YpfFRUGFYyLBsKQw7Ye+GLO4/t3xMgXcbc=;
        b=dxvO+9ucw5n6wkR1N7/lBMJYgD+tfVlwINYzkhvh5+piF96o6Hz/bYeGqbUiJ7HZ2B
         SGXPYa3W0d4CH19cVyZMoWB0PSMUPEGcXq8odG5sNwidoEu7n+1uTWm41aioqyb67XUY
         1ar1Vz7kzlqdHGuLQaheaPnN/RrXzTejH+WQ4BohT9/iIF7ke5655W2gOthAY3cc/xx6
         5JRmeIp0JVkft/JJRxroup57VSJc5ep5tB2K2KlPMl1fLu02zKTyTgpffaMZzjwzVucU
         sZ57bG2Bug3XV/SW+j6xHFNKSuj9TzURSdO42IV9Lc9iPjOgrDgpF4KORh8Qm81QKxdI
         5KqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAzIThVPhjdu89TcRgLNr48RC6u9msx+UjbICfjB3AKN0ohOdNPzYu2fZCoHC979roMzrYSHZkAo8l+ZHFLg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJhYtgTcPa2EosYKi4ETh3IQ7wy1lFZtZb9KtR3Jhf89vIzjnKe
	7+9GY5OkmwTtMGJBHy/yOkzq2ssQTKWUOLoqbRMK5lUQ7fAQW9f2DGVz
X-Gm-Gg: AYBFou2vPcvM5xdcqaakKuHlQEuRzPSN5ivrHszIuRj7TtE837VIqZBbbCBQD/FAriR
	GNYmQ8FJN1BOb0uTzxhnJYoIZbqNuHaLEWKi1qh3SzSAaNv2mquSkJG2w5pW8qKJafbNN25GyXk
	qWim/8LslXI0LZogxqhaDB/QLrgHz09mVHPhLuPau/fl2nc0Y3ewlRcd3Tl4roOqAfoE0OGdQ8l
	JuXrUrrWFeRDO2SoNLWinmarnyID35Jkf1tz/FI6mLppBDzIOB3TPU+mLmHdt+VDxrJoBKTqJJk
	nqaQ+PD87SWu83ng01jfr3I1/k8yt0iPu6BN006ZVnCkRpban2pkZCCfcvgM6UBr9CeMeK93hPM
	+NkFNTiTQ3wxEKR3R0/Wyjq6wjpxJytZ/8dAJZLkMgt3q/rISG4Cuoddc4nMWBGoM2WAV03r7LD
	igQw1625uBMo+MeadAFICardP61tYjzBQEe+3dRIbb2ECeI6jAQqkeGdJEY/IaVG0qTTYGrEBfI
	bKCn5lkMtlkqDVr40+DsejfidTcwo0WCww/m7W4eKUePk1PNDgOB0WA4PE=
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id 5b1f17b1804b1-4a18e4b8966mr365881315e9.26.1792079023060;
        Thu, 15 Oct 2026 08:43:43 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd640be0sm61940825e9.1.2026.10.15.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:43:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v2 2/2] vsock/test: cover SO_INQ
Date: Thu, 15 Oct 2026 16:43:34 +0100
Message-ID: <20261015154334.3217358-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015154334.3217358-1-devnexen@gmail.com>
References: <20261015154334.3217358-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the SCM_INQ value after a partial receive, after draining the
queue and at EOF, that no cmsg is sent while the option is off, that
accepted sockets inherit it from the listener, and that out of range
values and SOCK_SEQPACKET are rejected.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 tools/testing/vsock/vsock_test.c | 279 +++++++++++++++++++++++++++++++
 1 file changed, 279 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index b4ff9f946565..10b9074fb87f 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2429,6 +2429,271 @@ static void test_stream_collapse_server(const struct test_opts *opts)
 	close(fd);
 }
 
+#define SO_INQ_BUF_LEN 64
+#define SO_INQ_CHUNK_LEN 16
+
+static int so_inq_set(int fd, int val)
+{
+	return setsockopt(fd, SOL_SOCKET, SO_INQ, &val, sizeof(val));
+}
+
+/* Receive @len bytes and return the SCM_INQ value, or -1 if the kernel did
+ * not attach one.
+ */
+static int so_inq_recv(int fd, size_t len, int expected_ret)
+{
+	char control[CMSG_SPACE(sizeof(int))] = { 0 };
+	unsigned char buf[SO_INQ_BUF_LEN];
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = len,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = control,
+		.msg_controllen = sizeof(control),
+	};
+	struct cmsghdr *cmsg;
+	ssize_t ret;
+	int inq;
+
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0) {
+		perror("recvmsg");
+		exit(EXIT_FAILURE);
+	}
+
+	expect_res(ret, expected_ret, "recvmsg");
+
+	if (msg.msg_flags & MSG_CTRUNC) {
+		fprintf(stderr, "SCM_INQ control message truncated\n");
+		exit(EXIT_FAILURE);
+	}
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level != SOL_SOCKET ||
+		    cmsg->cmsg_type != SCM_INQ)
+			continue;
+
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(inq))) {
+			fprintf(stderr, "unexpected SCM_INQ length %zu\n",
+				(size_t)cmsg->cmsg_len);
+			exit(EXIT_FAILURE);
+		}
+
+		memcpy(&inq, CMSG_DATA(cmsg), sizeof(inq));
+		return inq;
+	}
+
+	return -1;
+}
+
+static void test_stream_so_inq_client(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SENT");
+
+	/* Wait for the whole payload to be queued, so the values below do not
+	 * depend on how the transport delivers it.
+	 */
+	if (!vsock_ioctl_int(fd, SIOCINQ, SO_INQ_BUF_LEN)) {
+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
+		goto out;
+	}
+
+	/* No ancillary data unless the option is enabled. */
+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN), -1,
+		   "SCM_INQ with SO_INQ disabled");
+
+	if (so_inq_set(fd, 1)) {
+		if (errno != ENOPROTOOPT) {
+			perror("setsockopt(SO_INQ)");
+			exit(EXIT_FAILURE);
+		}
+
+		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
+		goto out;
+	}
+
+	/* Partial read: the rest of the payload is still queued. */
+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN),
+		   SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN,
+		   "SCM_INQ after partial receive");
+
+	/* Draining read while the peer stays connected. */
+	expect_res(so_inq_recv(fd, SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN,
+			       SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN), 0,
+		   "SCM_INQ after draining receive");
+
+	control_writeln("DRAINED");
+	vsock_wait_remote_close(fd);
+
+	/* Nothing is queued once the peer is gone, but 1 is reported so the
+	 * caller keeps reading until it observes EOF, as TCP_INQ does.
+	 */
+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, 0), 1, "SCM_INQ at EOF");
+
+	if (so_inq_set(fd, 0)) {
+		perror("setsockopt(SO_INQ)");
+		exit(EXIT_FAILURE);
+	}
+
+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, 0), -1,
+		   "SCM_INQ after disabling SO_INQ");
+
+	close(fd);
+	return;
+
+out:
+	control_writeln("DRAINED");
+	close(fd);
+}
+
+static void test_stream_so_inq_server(const struct test_opts *opts)
+{
+	unsigned char buf[SO_INQ_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(buf, 'A', sizeof(buf));
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	control_writeln("SENT");
+
+	/* Keep the connection open until the peer has drained the queue: an
+	 * early close would turn its last SCM_INQ value into the EOF one.
+	 */
+	control_expectln("DRAINED");
+	close(fd);
+}
+
+static void test_stream_so_inq_inherit_client(const struct test_opts *opts)
+{
+	unsigned char buf[SO_INQ_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(buf, 'A', sizeof(buf));
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	control_writeln("SENT");
+
+	control_expectln("DONE");
+	close(fd);
+}
+
+static void test_stream_so_inq_inherit_server(const struct test_opts *opts)
+{
+	bool supported = true;
+	int listen_fd, fd;
+
+	listen_fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
+
+	/* Enable the option on the listener only. */
+	if (so_inq_set(listen_fd, 1)) {
+		if (errno != ENOPROTOOPT) {
+			perror("setsockopt(SO_INQ)");
+			exit(EXIT_FAILURE);
+		}
+
+		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
+		supported = false;
+	}
+
+	control_writeln("LISTENING");
+
+	timeout_begin(TIMEOUT);
+	do {
+		fd = accept(listen_fd, NULL, NULL);
+		timeout_check("accept");
+	} while (fd < 0 && errno == EINTR);
+	timeout_end();
+
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	close(listen_fd);
+	control_expectln("SENT");
+
+	if (!supported)
+		goto out;
+
+	if (!vsock_ioctl_int(fd, SIOCINQ, SO_INQ_BUF_LEN)) {
+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
+		goto out;
+	}
+
+	/* The accepted socket reports SCM_INQ without its own setsockopt(). */
+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN),
+		   SO_INQ_BUF_LEN - SO_INQ_CHUNK_LEN,
+		   "SCM_INQ inherited from the listener");
+
+out:
+	control_writeln("DONE");
+	close(fd);
+}
+
+static void test_so_inq_validation_client(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (so_inq_set(fd, 1)) {
+		if (errno != ENOPROTOOPT) {
+			perror("setsockopt(SO_INQ)");
+			exit(EXIT_FAILURE);
+		}
+
+		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
+		close(fd);
+		return;
+	}
+
+	if (!so_inq_set(fd, 2) || errno != EINVAL) {
+		fprintf(stderr, "SO_INQ accepted an out of range value\n");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+
+	/* SCM_INQ counts bytes, which a message based socket cannot report. */
+	fd = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (!so_inq_set(fd, 1) || errno != ENOPROTOOPT) {
+		fprintf(stderr, "SO_INQ not rejected on SOCK_SEQPACKET\n");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2633,6 +2898,20 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_collapse_client,
 		.run_server = test_stream_collapse_server,
 	},
+	{
+		.name = "SOCK_STREAM SO_INQ functionality",
+		.run_client = test_stream_so_inq_client,
+		.run_server = test_stream_so_inq_server,
+	},
+	{
+		.name = "SOCK_STREAM SO_INQ inherited by accepted socket",
+		.run_client = test_stream_so_inq_inherit_client,
+		.run_server = test_stream_so_inq_inherit_server,
+	},
+	{
+		.name = "SO_INQ option validation",
+		.run_client = test_so_inq_validation_client,
+	},
 	{},
 };
 
-- 
2.55.0

