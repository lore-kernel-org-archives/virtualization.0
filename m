Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564BD3EE1EA
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849336; cv=none; b=mBguVvwzliNWjbH0mnFbVHnpZ4jm8m5WhV02zqYFuDXTq3pbIVRwmpA4kECLxgDe9XLFS1rwxBQiOc1ExJxuv9ZcPsO+t6d0uo3ol3i9CdZPikQsNc78Xpeh+vthi6yROcW6HuDdV0TrjScV+vRW/4F7O8Wro+FJV8tTjOk5wRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849336; c=relaxed/simple;
	bh=VqE44AehCssWJGWUs9PIZgPZFXsZKmwiXJFANrHmelk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQGDuLHiuS6eYxqbSu9QSEznHrzN6rWnaptoDvVVh8HDzuFrhQxsBez3RCRAlKpjve4CJfSva+pqzLkdZfrlSgn2/1RUI57rwe2c58+gZEA4nYzTVIcIg9Nv/SXrvYrjYPU8vaikwRcvnyshD/79jHo/PTHG6PBiSS30m9Y3HUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVaJ8UJk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVaJ8UJk"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so19188925e9.2
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 16:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791849333; x=1792454133; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECNai7xooL0OUYNeTiNMYW7R9qWrmdzEAeiMs3Y4J3w=;
        b=DVaJ8UJk0OEqLQTUCD6GhB7oRMrYKzjPlxYzObDOBSdY+T19HY2irmbRKY1adciMHH
         89234gYUZ7r291zXDkfRXRcptv34MqP90OGGxOi7Hu7rHWe/uSDqyhc6ehi19VwB+AT1
         /TpvZvg038EQ7oTCn5yp3XLYI2iTjYD0jPbCDZoMk8q65Uh4kbz++LhS3BgQN1JL7POE
         nGpHpB9XiNaxc4TLY2hwz5N/f+3OhyofV3dah6Lr9F21JNR/DUPvEunMzdN4+dKz9BVd
         FUBLLlzXWuw82tXIH6GPqoce6wSTnawbxCZp6JydUnI0NS3AHY6b4P2jbOFTlnrT30gU
         VBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791849333; x=1792454133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECNai7xooL0OUYNeTiNMYW7R9qWrmdzEAeiMs3Y4J3w=;
        b=fBbaoOm4P3mOeDwD0wVzb/7RU+RmzXS5RgjpnQ/KFPm2YCiaRGFfEDVuBmMrhnUCpb
         5Mo0wkPaxZvjhRvknJUwbeoNaStdwZfZkHMaXEi4Cdzg9LgOTM5xYQwrQgXMOiDC909u
         MU2y2t5+JlNObnHock591tCi+ocyNFs8OArAnLFiXnZYG9jhXDYy12mpOmcn2pbrVzyP
         3Je+0OGQejP5CFOVu5XOOPfMb+WefcBBM6kcSqqSbist5hCRECTvQOMlodq1cOwQbSXy
         D1RJlZulEFrwBQRIJ6YFb2gUxblCJXbxmFWcHkGmyTePeyWBVCDAaiNEmqx/R1EvwT36
         DuNg==
X-Forwarded-Encrypted: i=1; AKwUvByFUBfSjVem/tGSb/Wct9ju+4CPwNIr2nLUYZJN3nRYm/Qz26XQMzEMKAc0wbw2BUyKQoO4V+IXp3DyJ8dv9w==@lists.linux.dev
X-Gm-Message-State: AFq9FYL+yEZgmGhAMw3IRr/M31kOctKYiOS2bgApqldoLozM5K2lYbX0
	ELW75/wtPfZivYLox+h/+N0b1xoO7/AxxnDvqH02IdguTjAGT81fUsyh
X-Gm-Gg: AYBFou3B1Qvr32dYgMzcfPPVVUat3y3rA6qS8kdI8EzPnVf1FQRix2oFvePclHV/RV8
	//ZhffgEMmRMUlCCESO9Z13iRvoxVBDX/PF0svpvvWNGsDintMM4zG9ruiEFsAwOqh9qyBeAqc1
	6hYAA/Yg1POdNAmv+wZzD9e6zmXt65WKD6+xCrlDMEoj5BWIWznhmsZ4kjCXCh+mgUv1xBkXY+7
	ILtxHDbJldpMY9wuTSIoIE0CfKxuxG9pG8YQBnSVglxqZ4ftaV/Iq4unc44RUAB+cRldv8GHeIh
	QRFl32W7tZjYVki1Z1rGr3N+r0ZxsdyoaZsQqpnGjvMQO9RAY1Nu9FSUsDGx3LtNZILP7Iy1URM
	zsWh0s85aNloP6+vS3arT4F31CcPdrFXtxssYspK/dNNuW22Gz6Wlu2bbuhZ+nlK5bDTnwCWP+/
	4x9psoL8nxEs88nm3/ivxbf4FB4BW0qK9jOF2pcFKkzRSfP0RPf+797T4dZzCwlYGhGsnFhPArB
	QIxGsG913dpLj2JcngXwXExMsS9H6s+NcS6BXBiz1xJH8qftV6hoK4I+l8=
X-Received: by 2002:a05:600c:5391:b0:49e:7a10:1b71 with SMTP id 5b1f17b1804b1-4a18e4a003cmr208047905e9.11.1791849333467;
        Mon, 12 Oct 2026 16:55:33 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967a0dsm1933762f8f.3.2026.10.12.16.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 16:55:32 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] vsock/test: cover SO_INQ
Date: Tue, 13 Oct 2026 00:55:24 +0100
Message-ID: <20261012235524.41468-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012235524.41468-1-devnexen@gmail.com>
References: <20261012235524.41468-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the SCM_INQ value after a partial receive, after draining the
queue and at EOF, that no cmsg is sent while the option is off, and
that out of range values and SOCK_SEQPACKET are rejected.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 tools/testing/vsock/vsock_test.c | 191 +++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index b4ff9f946565..00bb68c00c07 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2429,6 +2429,188 @@ static void test_stream_collapse_server(const struct test_opts *opts)
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
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level != SOL_SOCKET ||
+		    cmsg->cmsg_type != SCM_INQ)
+			continue;
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
@@ -2633,6 +2815,15 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_collapse_client,
 		.run_server = test_stream_collapse_server,
 	},
+	{
+		.name = "SOCK_STREAM SO_INQ functionality",
+		.run_client = test_stream_so_inq_client,
+		.run_server = test_stream_so_inq_server,
+	},
+	{
+		.name = "SO_INQ option validation",
+		.run_client = test_so_inq_validation_client,
+	},
 	{},
 };
 
-- 
2.55.0

