Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F053A383
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188828; cv=none; b=a5RZxRZPMqQtsLmNy+F5+5oJ7akIiZPNOyL9QBsMHcGB+KcEPzgeu7eY6RYBtPIK5H6wNdGtS95oLAsyWd0m3C2H4csa5aErUV/RZBv4sQRH5NPTUTpePE5Z9oP3hM0DcNIJ4G8Xjo2v+UioK70VjvQghNHG/lBcLkwg0+wsteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188828; c=relaxed/simple;
	bh=Sq+z3t/1z1Igec9KM0/mPKnoW3zwgdtF59SRgFR4y4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkln06gO4/g2d67UDtgKhXIn7eIqwKmHTDz+j8RAYka+7qc/5zOLIDTKfeKm7i0OtZ296Mx9JqQJdqlgDqM0TunUFkUVVx9Zh+gFJ+Wk8l5vGboPRff68hmfV+SP95BY4Jjj0UvaEM/0ad2evAMnPJX99yA8jZfVDUf6LoLXDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePmgqD7d; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePmgqD7d"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b20so199536766b.3
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188814; x=1790793614; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2R5khTlQ02M5fyLgYzXlFKQ5MLnD7NKcAMSs5jaNT8=;
        b=ePmgqD7dcjQeVaMXu3ixm6lIFtNzqBJEBYM8sn31Cjl6RH9sJCDWXjbyu1TiHlQezt
         PYIgsuzZzbMGwJCRuaMvP/BWWlkyCjVbUAfsUXVY+BltkmLwdbklkw6yYGHed96CJTD0
         G6W9hGgxzU/y1jTeYCS/v2SoLOzp8jgVM4JlMV1cv7JJq7cP9FfIdYRvV5Vf87bVpwsg
         wi5iqYhS+NAg1deenhUEVW9+3bW7HY8r9Sydu9w9RsMqy/CT0M5/EDLiIrU013wSY5TC
         Ti1Zo8gRo8BT8jaQoT1ivfKK0kGzwnzo4Ep9aAdPp2HJ3husO2va/f3dia6B77X/kHFZ
         zMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188814; x=1790793614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b2R5khTlQ02M5fyLgYzXlFKQ5MLnD7NKcAMSs5jaNT8=;
        b=UuXf6iTtTLlpOjM2bt+ZiWk0s48YnxCMkVihn6hUucdLz//7YZf7+FFFR19qvPTXu+
         SGDNMuUn26IMUbTTW95weEs+378o40AJT90zYoO+35twEd3pLPaulAME4mIc5qRTiiyQ
         EPFxLSr2dbIfL8Vc4NUrZXUZbK/1tjbsQuMhrOcM5xMjQ7kVdcCowFFaup71chYuqXFn
         +LSq3RPMZY7r6vozKQ0UIQn16F3m2n/Ygc10T2flDYJXRw/igkvaTCfy12poKIRTuNI3
         dAtbee5+9SEgPJicRCdcm+6FoupHrWvYH7wj565xCShPjFywAA5xk6YOn2tCtueLd070
         Z0oQ==
X-Forwarded-Encrypted: i=1; AKwUvBwS3A0Afkx2JCIptEC4Y6EWo8Wc5u9UhMfXp6l9401zwlcD0awu8ok2+QgfxrQWCWBdF/YVBdOkLj7JjKDbQA==@lists.linux.dev
X-Gm-Message-State: AFuF++lC4CFYGpDsJnofKEmPbS38zrTVYoihVMsJMuwAalftBYAahS1T
	JcwNyPqw/ekpQT3UcvabKtkOuk14Ez8l4qLziibM6taWKDFyKzawFbks
X-Gm-Gg: AYBFou30N/Z06oiHYdwm2ETVny8oTWh57v0YHSeY3cbNpP6mUHp69bQUdUUBYMZvQoM
	D+SPBEmu+vV8xzDXU6t+SrgezFRsk/Zk8Gc6mI7PRFoa4co1EzQromDszX+qPCWqeYskkpWOekg
	ZqaV0KJXt2DlwD2hp03COhIbdHeYuubiyguF8Pf64ux8qf0wdd8z1TIhKad8bw83tKnQ/A26N/n
	iz0JArJQC63IUdxEGhnoaOg30BU50eMQXEsrH02Iu+7Wto1YcSK1FmWErSqPBSXwZszEdi9J8VV
	eQiclbhjA4XspOhorxyv+E2hrxLJlEgM+XADLfHj90b3HF77I3mI9wfKgfyahRI3UaieyoDWG5K
	f0fL4fxm9qBHCMX/NRb91yP/z3qUb5GWeAPo+9aUwT46KoyDvPMheQCh4Ee8d78KDkGi6W6WK+V
	Fc6Gq/z/jd0KGaHFhkOUNq+IlRdxeNNoDNq7actd+RYRvAgyQ2KMngC3tF2rJ8iUfdrrn4YK+P7
	if5jjhf/iOkDEo5fjhKjbOCbxslL520waXvo1y3v5d4dutkN2lVyS4bvHOTi/qXsaLxlw==
X-Received: by 2002:a17:907:3e1e:b0:c29:f5d8:9c6e with SMTP id a640c23a62f3a-c2ac2235d42mr4902366b.29.1790188813415;
        Wed, 23 Sep 2026 11:40:13 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33faf4sm173417566b.3.2026.09.23.11.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:40:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v2 2/2] vsock/test: cover receive queue hints
Date: Wed, 23 Sep 2026 19:40:08 +0100
Message-ID: <20260923184008.153541-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923184008.153541-1-devnexen@gmail.com>
References: <20260923184008.153541-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add io_uring receive tests checking IORING_CQE_F_SOCK_NONEMPTY across a
partial receive, draining while the peer stays connected, EOF, a
nonblocking receive on an empty queue, a zero-length request, and a
multishot receive with provided buffers.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 tools/testing/vsock/util.c             |   9 +
 tools/testing/vsock/util.h             |   1 +
 tools/testing/vsock/vsock_uring_test.c | 391 +++++++++++++++++++++++++
 3 files changed, 401 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index fe316b02a590..299a4e8ecb63 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -483,6 +483,15 @@ void recv_byte(int fd, int expected_ret, int flags)
 	}
 }
 
+void expect_res(int res, int expected, const char *what)
+{
+	if (res != expected) {
+		fprintf(stderr, "%s: expected %d, got %d\n", what, expected,
+			res);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Run test cases.  The program terminates if a failure occurs. */
 void run_tests(const struct test_case *test_cases,
 	       const struct test_opts *opts)
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index bf633cde82b0..9dabb547021e 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -94,6 +94,7 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
 void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
 void send_byte(int fd, int expected_ret, int flags);
 void recv_byte(int fd, int expected_ret, int flags);
+void expect_res(int res, int expected, const char *what);
 void run_tests(const struct test_case *test_cases,
 	       const struct test_opts *opts);
 void list_tests(const struct test_case *test_cases);
diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
index 5c3078969659..c6cc51db7adc 100644
--- a/tools/testing/vsock/vsock_uring_test.c
+++ b/tools/testing/vsock/vsock_uring_test.c
@@ -13,7 +13,10 @@
 #include <liburing.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <sys/ioctl.h>
 #include <linux/kernel.h>
+#include <linux/sockios.h>
+#include <errno.h>
 #include <error.h>
 
 #include "util.h"
@@ -28,6 +31,10 @@
 
 #define VSOCK_TEST_DATA_MAX_IOV 3
 
+#define HINT_CHUNK_SIZE		4096
+#define HINT_BUF_GROUP		1
+#define HINT_BUF_ENTRIES	4
+
 struct vsock_io_uring_test {
 	/* Number of valid elements in 'vecs'. */
 	int vecs_cnt;
@@ -211,6 +218,365 @@ void test_stream_uring_msg_zc_client(const struct test_opts *opts)
 		vsock_io_uring_client(opts, &test_data_array[i], true);
 }
 
+struct uring_inq_ctx {
+	struct io_uring ring;
+	int fd;
+};
+
+static void inq_server_init(struct uring_inq_ctx *ctx,
+			    const struct test_opts *opts)
+{
+	ctx->fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (ctx->fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	if (io_uring_queue_init(RING_ENTRIES_NUM, &ctx->ring, 0))
+		error(1, errno, "io_uring_queue_init");
+}
+
+static void inq_server_exit(struct uring_inq_ctx *ctx)
+{
+	io_uring_queue_exit(&ctx->ring);
+	close(ctx->fd);
+}
+
+/* Submit a single receive and report both its result and its CQE flags. */
+static int inq_recv(struct uring_inq_ctx *ctx, void *buf, size_t len,
+		    int flags, unsigned int *cflags)
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	int res;
+
+	sqe = io_uring_get_sqe(&ctx->ring);
+	io_uring_prep_recv(sqe, ctx->fd, buf, len, flags);
+
+	if (io_uring_submit(&ctx->ring) != 1)
+		error(1, errno, "io_uring_submit");
+
+	if (io_uring_wait_cqe(&ctx->ring, &cqe))
+		error(1, errno, "io_uring_wait_cqe");
+
+	res = cqe->res;
+	*cflags = cqe->flags;
+	io_uring_cqe_seen(&ctx->ring, cqe);
+
+	return res;
+}
+
+static void expect_uring_nonempty(unsigned int cflags, bool expected,
+				  const char *what)
+{
+	bool nonempty = !!(cflags & IORING_CQE_F_SOCK_NONEMPTY);
+
+	if (nonempty != expected) {
+		fprintf(stderr, "%s: expected SOCK_NONEMPTY %d, got %d\n",
+			what, expected, nonempty);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void expect_uring_more(unsigned int cflags, bool expected,
+			      const char *what)
+{
+	bool more = !!(cflags & IORING_CQE_F_MORE);
+
+	if (more != expected) {
+		fprintf(stderr, "%s: expected F_MORE %d, got %d\n",
+			what, expected, more);
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Wait until the whole payload is queued, so the hint is deterministic.
+ * Return false if the test has to be skipped.
+ */
+static bool inq_wait_queued(int fd, int len)
+{
+	if (!vsock_ioctl_int(fd, SIOCINQ, len)) {
+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
+		return false;
+	}
+
+	return true;
+}
+
+static void inq_send_chunks(const struct test_opts *opts, int chunks)
+{
+	char buf[HINT_CHUNK_SIZE];
+	int fd, i;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(buf, 0xa5, sizeof(buf));
+	for (i = 0; i < chunks; i++)
+		send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+
+	control_writeln("SENT");
+	control_expectln("DONE");
+	close(fd);
+}
+
+static void test_stream_uring_inq_client(const struct test_opts *opts)
+{
+	inq_send_chunks(opts, 2);
+}
+
+static void test_stream_uring_inq_server(const struct test_opts *opts)
+{
+	char buf[HINT_CHUNK_SIZE];
+	struct uring_inq_ctx ctx;
+	unsigned int cflags;
+	int res;
+
+	inq_server_init(&ctx, opts);
+
+	control_expectln("SENT");
+	if (!inq_wait_queued(ctx.fd, 2 * HINT_CHUNK_SIZE))
+		goto out;
+
+	/* Data remains after this receive, so the flag must be set. */
+	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
+	expect_res(res, HINT_CHUNK_SIZE, "partial receive");
+	expect_uring_nonempty(cflags, true, "partial receive");
+
+	/* This receive drains the queue while the peer stays connected. */
+	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
+	expect_res(res, HINT_CHUNK_SIZE, "draining receive");
+	expect_uring_nonempty(cflags, false, "draining receive");
+
+out:
+	control_writeln("DONE");
+	inq_server_exit(&ctx);
+}
+
+static void test_stream_uring_inq_eof_client(const struct test_opts *opts)
+{
+	char buf[HINT_CHUNK_SIZE];
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(buf, 0x5a, sizeof(buf));
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	control_writeln("SENT");
+
+	control_expectln("DRAINED");
+	close(fd);
+	control_writeln("CLOSED");
+}
+
+static void test_stream_uring_inq_eof_server(const struct test_opts *opts)
+{
+	char buf[HINT_CHUNK_SIZE];
+	struct uring_inq_ctx ctx;
+	unsigned int cflags;
+	int res;
+
+	inq_server_init(&ctx, opts);
+
+	control_expectln("SENT");
+	if (!inq_wait_queued(ctx.fd, HINT_CHUNK_SIZE)) {
+		control_writeln("DRAINED");
+		control_expectln("CLOSED");
+		goto out;
+	}
+
+	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
+	expect_res(res, HINT_CHUNK_SIZE, "drain before EOF");
+	expect_uring_nonempty(cflags, false, "drain before EOF");
+
+	control_writeln("DRAINED");
+	control_expectln("CLOSED");
+
+	/* The queue is empty and the peer is gone.  The hint stays non-zero
+	 * so that this receive happens and reports EOF, as TCP does after a
+	 * FIN.
+	 */
+	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
+	expect_res(res, 0, "receive at EOF");
+	expect_uring_nonempty(cflags, true, "receive at EOF");
+
+out:
+	inq_server_exit(&ctx);
+}
+
+static void test_stream_uring_inq_empty_client(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("READY");
+	control_expectln("DONE");
+	close(fd);
+}
+
+static void test_stream_uring_inq_empty_server(const struct test_opts *opts)
+{
+	char buf[HINT_CHUNK_SIZE];
+	struct uring_inq_ctx ctx;
+	unsigned int cflags;
+	int res;
+
+	inq_server_init(&ctx, opts);
+
+	control_expectln("READY");
+
+	/* A failed receive must not leave a stale positive hint. */
+	res = inq_recv(&ctx, buf, sizeof(buf), MSG_DONTWAIT, &cflags);
+	expect_res(res, -EAGAIN, "empty nonblocking receive");
+	expect_uring_nonempty(cflags, false, "empty nonblocking receive");
+
+	control_writeln("DONE");
+	inq_server_exit(&ctx);
+}
+
+static void test_stream_uring_inq_zerolen_client(const struct test_opts *opts)
+{
+	inq_send_chunks(opts, 1);
+}
+
+static void test_stream_uring_inq_zerolen_server(const struct test_opts *opts)
+{
+	char buf[HINT_CHUNK_SIZE];
+	struct uring_inq_ctx ctx;
+	unsigned int cflags;
+	int res;
+
+	inq_server_init(&ctx, opts);
+
+	control_expectln("SENT");
+	if (!inq_wait_queued(ctx.fd, HINT_CHUNK_SIZE))
+		goto out;
+
+	/* A zero-length request is not an error and still describes the
+	 * queue behind it.
+	 */
+	res = inq_recv(&ctx, buf, 0, 0, &cflags);
+	expect_res(res, 0, "zero-length receive");
+	expect_uring_nonempty(cflags, true, "zero-length receive");
+
+out:
+	control_writeln("DONE");
+	inq_server_exit(&ctx);
+}
+
+static void test_stream_uring_inq_mshot_client(const struct test_opts *opts)
+{
+	char buf[HINT_CHUNK_SIZE];
+	int fd, i;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(buf, 0x3c, sizeof(buf));
+	for (i = 0; i < 2; i++)
+		send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	control_writeln("SENT");
+
+	control_expectln("DRAINED");
+	close(fd);
+	control_writeln("CLOSED");
+
+	control_expectln("DONE");
+}
+
+static void test_stream_uring_inq_mshot_server(const struct test_opts *opts)
+{
+	static char bufs[HINT_BUF_ENTRIES][HINT_CHUNK_SIZE];
+	struct io_uring_buf_ring *br;
+	struct uring_inq_ctx ctx;
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	int i, ret;
+
+	inq_server_init(&ctx, opts);
+
+	br = io_uring_setup_buf_ring(&ctx.ring, HINT_BUF_ENTRIES,
+				     HINT_BUF_GROUP, 0, &ret);
+	if (!br) {
+		fprintf(stderr, "io_uring_setup_buf_ring: %d\n", ret);
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < HINT_BUF_ENTRIES; i++)
+		io_uring_buf_ring_add(br, bufs[i], HINT_CHUNK_SIZE, i,
+				      io_uring_buf_ring_mask(HINT_BUF_ENTRIES),
+				      i);
+	io_uring_buf_ring_advance(br, HINT_BUF_ENTRIES);
+
+	control_expectln("SENT");
+	if (!inq_wait_queued(ctx.fd, 2 * HINT_CHUNK_SIZE)) {
+		control_writeln("DRAINED");
+		control_expectln("CLOSED");
+		goto out;
+	}
+
+	/* Arm only once both chunks are queued, so every completion knows
+	 * what is left behind it.
+	 */
+	sqe = io_uring_get_sqe(&ctx.ring);
+	io_uring_prep_recv_multishot(sqe, ctx.fd, NULL, 0, 0);
+	sqe->flags |= IOSQE_BUFFER_SELECT;
+	sqe->buf_group = HINT_BUF_GROUP;
+
+	if (io_uring_submit(&ctx.ring) != 1)
+		error(1, errno, "io_uring_submit");
+
+	/* A buffer holds one chunk, so the other one is still queued. */
+	if (io_uring_wait_cqe(&ctx.ring, &cqe))
+		error(1, errno, "io_uring_wait_cqe");
+
+	expect_res(cqe->res, HINT_CHUNK_SIZE, "multishot first chunk");
+	expect_uring_nonempty(cqe->flags, true, "multishot first chunk");
+	expect_uring_more(cqe->flags, true, "multishot first chunk");
+	io_uring_cqe_seen(&ctx.ring, cqe);
+
+	/* This completion drains the queue and keeps the request armed. */
+	if (io_uring_wait_cqe(&ctx.ring, &cqe))
+		error(1, errno, "io_uring_wait_cqe");
+
+	expect_res(cqe->res, HINT_CHUNK_SIZE, "multishot second chunk");
+	expect_uring_nonempty(cqe->flags, false, "multishot second chunk");
+	expect_uring_more(cqe->flags, true, "multishot second chunk");
+	io_uring_cqe_seen(&ctx.ring, cqe);
+
+	control_writeln("DRAINED");
+	control_expectln("CLOSED");
+
+	/* EOF ends multishot regardless of the hint. */
+	if (io_uring_wait_cqe(&ctx.ring, &cqe))
+		error(1, errno, "io_uring_wait_cqe");
+
+	expect_res(cqe->res, 0, "multishot EOF");
+	expect_uring_more(cqe->flags, false, "multishot EOF");
+	io_uring_cqe_seen(&ctx.ring, cqe);
+
+out:
+	control_writeln("DONE");
+	io_uring_free_buf_ring(&ctx.ring, br, HINT_BUF_ENTRIES,
+			       HINT_BUF_GROUP);
+	inq_server_exit(&ctx);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM io_uring test",
@@ -222,6 +588,31 @@ static struct test_case test_cases[] = {
 		.run_server = test_stream_uring_msg_zc_server,
 		.run_client = test_stream_uring_msg_zc_client,
 	},
+	{
+		.name = "SOCK_STREAM io_uring receive queue hint",
+		.run_server = test_stream_uring_inq_server,
+		.run_client = test_stream_uring_inq_client,
+	},
+	{
+		.name = "SOCK_STREAM io_uring receive hint at EOF",
+		.run_server = test_stream_uring_inq_eof_server,
+		.run_client = test_stream_uring_inq_eof_client,
+	},
+	{
+		.name = "SOCK_STREAM io_uring receive hint on empty queue",
+		.run_server = test_stream_uring_inq_empty_server,
+		.run_client = test_stream_uring_inq_empty_client,
+	},
+	{
+		.name = "SOCK_STREAM io_uring receive hint zero-length",
+		.run_server = test_stream_uring_inq_zerolen_server,
+		.run_client = test_stream_uring_inq_zerolen_client,
+	},
+	{
+		.name = "SOCK_STREAM io_uring multishot receive hint",
+		.run_server = test_stream_uring_inq_mshot_server,
+		.run_client = test_stream_uring_inq_mshot_client,
+	},
 	{},
 };
 
-- 
2.55.0

