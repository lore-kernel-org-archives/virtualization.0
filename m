Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63047252B
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933640; cv=none; b=pcpwvMeheml0eALyad0XSJG35kb9q/L7kvIG50FiZEXnemiS62vY1W9QO5hnQts+v8ltKzX8qcoPqrDrYIGrqktfffVcAUKyBeCmc+PlHtSgo6WTVlHzhBXDDUatP8OTUMf35IVHY9pUPXrbgdsKR5rv9cJNOOxpQ7GveYY/4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933640; c=relaxed/simple;
	bh=cWgRQUQWzEo+lu6rd7U55/RBFfNxGxycH8Uu34wtpFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iI1Jt+2xMl2QhcuIcMcDdX2DVe/Cx39/bE3ASVEF23Xnv5pnEwS25TiEr57hcwkGL43xQxrYzMA7dHPQ05fyX+treosC05SEJaGKiFVXDDN/pkHgXNTK64SocyKK6YTUync6j6SC01E/dj9EvZgoOwPnjp7o92wDb+dbhm6cnnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfSxlZVU; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfSxlZVU"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so343999266b.3
        for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933637; x=1790538437; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ixxXkDc5Dv3IY8Mw5lb3/4t7C9pprFjhbghcAb0ryCY=;
        b=YfSxlZVUTvqsI6Um8Q5E44zBLMlSqpy/QaIRGilwJE7Bn88iMHjCR1DXPiLMV8QwQw
         lVKqsjdFTIF/OBteruF99votBybGrlwCO1YFiEK2Veqyhlj3ZyCCwRxL3gIMIUgh6D0k
         gabxKyDciY3tGWFpueiQ55b5I/JGlFdXEDNbCfDwlmtv4Af1FgOkRgFxLKlSOiN9ocZm
         7t1J+JPtyMkJbi3PyEhqB6FI4QJGN131gyhU0QnLTz+NcZAgy+ubkakfjLbLeiQtXjaP
         nvwufLjuVSF9FtUxK/BlJp2uC9k5FkXv93/I7ZcvTG1GFh2Q51EBW7GOAx1mfcU9+e5J
         XCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933637; x=1790538437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ixxXkDc5Dv3IY8Mw5lb3/4t7C9pprFjhbghcAb0ryCY=;
        b=lGK1pWtOfx09ePn6Z2vLZ0+BxhB+DVgkblRDpo1/lE0y19U7FXbVgXWhrF6pdkUojF
         TO8q/uqh2QBJe7Bm14HKdiGfK7iMcmQOAJ5sE872PDPjcPjZGPV1yoZXDH0kctkzeH7D
         7hQu1b4XSe8L4U37Iubs9Gr6fAWF06OVO+a/n5Ev/46ucatM/kzn7ACUruEy7HFabxSf
         ShYbhdlZI8JwQ0YZYM4inV9L5XFclqBgdQ2FuSflTU1PYOlEEZQlFBj7c9YjGoj3WUoX
         2jQFRHcom5+1FbwMzTnF1dBcHdyW/m+PzM2n4rMlknZmIQhq3+SfdKMvNCGK4rCw5CeG
         FV5A==
X-Forwarded-Encrypted: i=1; AKwUvBxZTKX6YTWOB6zq9xcDmHwKpkSJbcVnSFECXeqS1sW6ljvWLajhqkbx2Hbc2QsurrxkutC9bwewGxd10Xnj0w==@lists.linux.dev
X-Gm-Message-State: AFuF++lrO00okHKVmMJyxSMS6bBr7DckfJwEuqOrpn9V0Os0M9/7RHKe
	AaGQrBUNAAfjHGLBz2D7cBmLyAAap0A3n0dWFyiiNqZVnv6HEBcktGlC
X-Gm-Gg: AYBFou3LQZ766GHfBQN1ETL+MOOAbSsJ9u5kqtPkq4IfN3g1En9/AtuNjFKR0HL6TMV
	7Aft2j/3aMToW75XddxE6vxSvcVv8ViPDGtDg0iCGqHx+ZkkIfIpQ73nEP7N/zhNPOqVuq/TDcr
	DViR6s1NQ0dq7w38owI+Ieiwy20VsZ40PFD063Pxu8/vBX6PaZIwiq6rNH3ALbNWhx0e3XzeElK
	AxlUBmtN8/kIG3sLwukeNYcs0kIsgYeATUZA9WrixGwIko2EgEadMZLvl0TwMgLIJ6oKoG+w3uA
	GK/M6t7r0JNOxYZbjYHAwdPXnlnOMr6RaydRRYBauPwOmWgj60qZukeyyySGE13V+/UxYoBhyFW
	JXAHHi4diNjPJPj6Lub0YHrKW9TuzzQ1H000spMfAXlRZBE6WMCKguuep+H/piV5lnaWaMlSQb7
	ZQlFRlJM8ymyFSfEIVLZnBZaEwj7BvjLV4ybdjMCl69imOzOtuVNRX4bcW7M0cywkCDgA5UvEzi
	zNv9lo0XANJ2U6pqiH140lYkGgxhqOq3UokREFlrRvz+ZIV08oaRnbmW/E=
X-Received: by 2002:a17:907:9447:b0:c29:1b6f:dd4 with SMTP id a640c23a62f3a-c2a157c2af6mr722685866b.32.1789933637074;
        Sun, 20 Sep 2026 12:47:17 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358ff8edsm211768466b.61.2026.09.20.12.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:47:16 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 2/2] vsock/test: cover receive queue hints
Date: Sun, 20 Sep 2026 20:47:10 +0100
Message-ID: <20260920194710.1114748-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920194710.1114748-1-devnexen@gmail.com>
References: <20260920194710.1114748-1-devnexen@gmail.com>
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
 tools/testing/vsock/vsock_uring_test.c | 367 +++++++++++++++++++++++++
 1 file changed, 367 insertions(+)

diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
index 5c3078969659..318e17bd28bc 100644
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
@@ -211,6 +218,341 @@ void test_stream_uring_msg_zc_client(const struct test_opts *opts)
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
+static void expect_res(int res, int expected, const char *what)
+{
+	if (res != expected) {
+		fprintf(stderr, "%s: expected %d, got %d\n", what, expected,
+			res);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void expect_nonempty(unsigned int cflags, bool expected,
+			    const char *what)
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
+/* Wait until the whole payload is queued, so the hint is deterministic. */
+static void inq_wait_queued(int fd, int len)
+{
+	if (!vsock_ioctl_int(fd, SIOCINQ, len)) {
+		fprintf(stderr, "SIOCINQ not supported\n");
+		exit(EXIT_FAILURE);
+	}
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
+	inq_wait_queued(ctx.fd, 2 * HINT_CHUNK_SIZE);
+
+	/* Data remains after this receive, so the flag must be set. */
+	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
+	expect_res(res, HINT_CHUNK_SIZE, "partial receive");
+	expect_nonempty(cflags, true, "partial receive");
+
+	/* This receive drains the queue while the peer stays connected. */
+	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
+	expect_res(res, HINT_CHUNK_SIZE, "draining receive");
+	expect_nonempty(cflags, false, "draining receive");
+
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
+
+	control_expectln("DONE");
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
+	inq_wait_queued(ctx.fd, HINT_CHUNK_SIZE);
+
+	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
+	expect_res(res, HINT_CHUNK_SIZE, "drain before EOF");
+	expect_nonempty(cflags, false, "drain before EOF");
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
+	expect_nonempty(cflags, true, "receive at EOF");
+
+	control_writeln("DONE");
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
+	expect_nonempty(cflags, false, "empty nonblocking receive");
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
+	inq_wait_queued(ctx.fd, HINT_CHUNK_SIZE);
+
+	/* A zero-length request is not an error and still describes the
+	 * queue behind it.
+	 */
+	res = inq_recv(&ctx, buf, 0, 0, &cflags);
+	expect_res(res, 0, "zero-length receive");
+	expect_nonempty(cflags, true, "zero-length receive");
+
+	control_writeln("DONE");
+	inq_server_exit(&ctx);
+}
+
+static void test_stream_uring_inq_mshot_client(const struct test_opts *opts)
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
+	memset(buf, 0x3c, sizeof(buf));
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
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
+	sqe = io_uring_get_sqe(&ctx.ring);
+	io_uring_prep_recv_multishot(sqe, ctx.fd, NULL, 0, 0);
+	sqe->flags |= IOSQE_BUFFER_SELECT;
+	sqe->buf_group = HINT_BUF_GROUP;
+
+	if (io_uring_submit(&ctx.ring) != 1)
+		error(1, errno, "io_uring_submit");
+
+	control_expectln("SENT");
+
+	/* The payload completion drains the queue and keeps the request
+	 * armed, so the hint must report the queue as empty.
+	 */
+	if (io_uring_wait_cqe(&ctx.ring, &cqe))
+		error(1, errno, "io_uring_wait_cqe");
+
+	expect_res(cqe->res, HINT_CHUNK_SIZE, "multishot payload");
+	expect_nonempty(cqe->flags, false, "multishot payload");
+	if (!(cqe->flags & IORING_CQE_F_MORE)) {
+		fprintf(stderr, "multishot payload: request not rearmed\n");
+		exit(EXIT_FAILURE);
+	}
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
+	if (cqe->flags & IORING_CQE_F_MORE) {
+		fprintf(stderr, "multishot EOF: request still armed\n");
+		exit(EXIT_FAILURE);
+	}
+	io_uring_cqe_seen(&ctx.ring, cqe);
+
+	control_writeln("DONE");
+	io_uring_free_buf_ring(&ctx.ring, br, HINT_BUF_ENTRIES,
+			       HINT_BUF_GROUP);
+	inq_server_exit(&ctx);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM io_uring test",
@@ -222,6 +564,31 @@ static struct test_case test_cases[] = {
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

