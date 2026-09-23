Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348E5650E0
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191810; cv=none; b=QJSkMho+OPMCklhjrj5JuHoOknKEziVWYluv3UqyYQbi1htgMsPRpwY8EO4DxSxqzr05wFqYzQghXKJctsCWEnJezIj5JbZzH55VsHqnQ8kyyWL3pvZ2YvJoYTl8bV1Io4g/tK0jTzIFg7JD42GiI0NZJChQ93S0r67gA4VBICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191810; c=relaxed/simple;
	bh=WCghleGXty4eEeYwlnoVMG4hmT4btZI3IUN9y3hpF68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+pKD7XGcTxWsWOEF5aO0Ilb/p/Jrit3LP3t9OhLZ/bgV4D/LEDPejlpprEvPRsWJ5hjbL/WlYHwj/392opi/JOSoEQL3RPhqO4OGumMPRLTOFr2dbAkdLCWdRTHIjx8P0OHFzRaWf5ocyyp0duh866nL12j9ooCwp7dPfCNUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR87k6ai; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR87k6ai"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c0776592e3so770323b6e.1
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191806; x=1790796606; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/rt2uB6/AsMMcgokcDKFyREBgoi73mMVHQmkM9v16NY=;
        b=IR87k6aiL2s05vvMnxMuDvm/q3MLUWsfY0DwA0HNeC0omv8hUmHP1eASBWLwE9dI+3
         CRFjrQhdwEOq6wfaOdzRLKmsg7ikNxBSYzMM6TuSU7R8gdo3FyMbjHs/m9Fk8irISfJU
         gHajj8wgwXZ7XfNnuY3oiHOIrB944HgFRT7rTaSLXBzBvoyslAR/NzLsCVaz9X6I/ql2
         U3eIuRAHR3S7BPIA8h4BXrTB1W70O0f+cLuY+J7bwupc+VQHFSppEiYC5L/K4aYA6Tln
         Zs8dKKwRLXFlMJ5GrUkKkYDeNES/hSj5Hg5UaTufAvKaIW6vlGMgcI5by5aY6DyeoCAG
         Wpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191806; x=1790796606;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rt2uB6/AsMMcgokcDKFyREBgoi73mMVHQmkM9v16NY=;
        b=NPA6QbxThCkqsNDmBAjb5MONQN/C0BVelfIp55TxNMlP2SyYcl5RBov83I1NJDeLQ/
         YjDE0QDEVoCU21nKrO9gvTvnLppnJ0S1rrHD27s3IrSc4i3is328THcBCzqdqjjJAbB0
         qjiZzZ1NlUaVdvAs3TfhfUpL8Zh7AuTKoaKAMdbyQKQADYbhywqfaDR5iEN+0fGcTB8m
         zUFOM1u41lXqsVcNjl5lZilMVfHRBH19wAs6DUSrZ9aq+JiZCD+VSfCkU7EGNtOGl8Cg
         S+eLXhHhYjFgUydCwIf5Dx6zBqFwCP+SMLtoVm7uhrWQuYmxPgNg2DxsjAgIv2/cNwhv
         SwNQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/nFC5YJFHtZNLLmEnSHmBvMshS3wRZJslAJhkQFt9nCKI+aDrUcXokQ/btVflmHBVnnczNZSWyvnXec0brg==@lists.linux.dev
X-Gm-Message-State: AFuF++k4Puz1qSe0KepBIFTSPhS+HRpa0wBGDeLWZ2UwrYeup+EiTBCV
	If/Tn15jy20s7L+K/jq5I7GGG0fks3njIY0cCuvZnSUOKX/2FEQJcbj8
X-Gm-Gg: AYBFou3L/xM9to6V+7CwWdtgySoAbTI+n4ucTiqqpHVC6Hkbm3nXANheQYH6weG0Kjs
	k1GXrf/2cEe/bG8NbE8Ruh5xJ2H5qyVMqr4zacPiA4McPEf4KnGkcysYTIk5bETJ99ZZvl4jjAl
	u/eqAhHBa3NGJUbDsgYvCVYkxBZ4DAViLv4uO78AZS3Uyg0WnFUn3MoSswAK8sdwNdxPwLrPuBU
	E0MODswjehM+P1GcxN1W0loS0Flu4AhZZeSbWcg+pjvCTPeGR031WfGlRkRUxRf84jLWMn9nHnv
	d8c45fr9uWyYU4rZFzzrP34ta50GbNUgJdfAZf5yFaU6GDxyqmGhmrfit/M3HQ62NHt0wc9ykwM
	E7w536gH/xZL5xG8GApVLJglMErLEIqFuVfE+m3njBzR6t5VfQPiE/M56eZbraL2haXhsgVt8P7
	5R2Y28XQYGPZzDLd7spsD/xIFDFTCx7SybFWrMofSDUPTBdc+TIENjgvqCCm6z928IGZmkLDVtz
	ZqoprX1uY5itcVl041Y
X-Received: by 2002:a05:6808:50a3:b0:4c5:cd9d:c6de with SMTP id 5614622812f47-4d72c635ff8mr198770b6e.7.1790191806332;
        Wed, 23 Sep 2026 12:30:06 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c3d75355sm3060141b6e.3.2026.09.23.12.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:30:04 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:29:57 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] vsock/test: cover receive queue hints
Message-ID: <arQotQ75qCVXkbH8@devvm29614.prn0.facebook.com>
References: <20260923184008.153541-1-devnexen@gmail.com>
 <20260923184008.153541-3-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923184008.153541-3-devnexen@gmail.com>

On Wed, Sep 23, 2026 at 07:40:08PM +0100, David Carlier wrote:
> Add io_uring receive tests checking IORING_CQE_F_SOCK_NONEMPTY across a
> partial receive, draining while the peer stays connected, EOF, a
> nonblocking receive on an empty queue, a zero-length request, and a
> multishot receive with provided buffers.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  tools/testing/vsock/util.c             |   9 +
>  tools/testing/vsock/util.h             |   1 +
>  tools/testing/vsock/vsock_uring_test.c | 391 +++++++++++++++++++++++++
>  3 files changed, 401 insertions(+)
> 
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index fe316b02a590..299a4e8ecb63 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -483,6 +483,15 @@ void recv_byte(int fd, int expected_ret, int flags)
>  	}
>  }
>  
> +void expect_res(int res, int expected, const char *what)
> +{
> +	if (res != expected) {
> +		fprintf(stderr, "%s: expected %d, got %d\n", what, expected,
> +			res);
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
>  /* Run test cases.  The program terminates if a failure occurs. */
>  void run_tests(const struct test_case *test_cases,
>  	       const struct test_opts *opts)
> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> index bf633cde82b0..9dabb547021e 100644
> --- a/tools/testing/vsock/util.h
> +++ b/tools/testing/vsock/util.h
> @@ -94,6 +94,7 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
>  void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
>  void send_byte(int fd, int expected_ret, int flags);
>  void recv_byte(int fd, int expected_ret, int flags);
> +void expect_res(int res, int expected, const char *what);
>  void run_tests(const struct test_case *test_cases,
>  	       const struct test_opts *opts);
>  void list_tests(const struct test_case *test_cases);
> diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
> index 5c3078969659..c6cc51db7adc 100644
> --- a/tools/testing/vsock/vsock_uring_test.c
> +++ b/tools/testing/vsock/vsock_uring_test.c
> @@ -13,7 +13,10 @@
>  #include <liburing.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
> +#include <sys/ioctl.h>
>  #include <linux/kernel.h>
> +#include <linux/sockios.h>
> +#include <errno.h>
>  #include <error.h>
>  
>  #include "util.h"
> @@ -28,6 +31,10 @@
>  
>  #define VSOCK_TEST_DATA_MAX_IOV 3
>  
> +#define HINT_CHUNK_SIZE		4096
> +#define HINT_BUF_GROUP		1
> +#define HINT_BUF_ENTRIES	4
> +
>  struct vsock_io_uring_test {
>  	/* Number of valid elements in 'vecs'. */
>  	int vecs_cnt;
> @@ -211,6 +218,365 @@ void test_stream_uring_msg_zc_client(const struct test_opts *opts)
>  		vsock_io_uring_client(opts, &test_data_array[i], true);
>  }
>  
> +struct uring_inq_ctx {
> +	struct io_uring ring;
> +	int fd;
> +};
> +
> +static void inq_server_init(struct uring_inq_ctx *ctx,
> +			    const struct test_opts *opts)
> +{
> +	ctx->fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
> +	if (ctx->fd < 0) {
> +		perror("accept");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (io_uring_queue_init(RING_ENTRIES_NUM, &ctx->ring, 0))
> +		error(1, errno, "io_uring_queue_init");
> +}
> +
> +static void inq_server_exit(struct uring_inq_ctx *ctx)
> +{
> +	io_uring_queue_exit(&ctx->ring);
> +	close(ctx->fd);
> +}
> +
> +/* Submit a single receive and report both its result and its CQE flags. */
> +static int inq_recv(struct uring_inq_ctx *ctx, void *buf, size_t len,
> +		    int flags, unsigned int *cflags)
> +{
> +	struct io_uring_sqe *sqe;
> +	struct io_uring_cqe *cqe;
> +	int res;
> +
> +	sqe = io_uring_get_sqe(&ctx->ring);
> +	io_uring_prep_recv(sqe, ctx->fd, buf, len, flags);
> +
> +	if (io_uring_submit(&ctx->ring) != 1)
> +		error(1, errno, "io_uring_submit");
> +
> +	if (io_uring_wait_cqe(&ctx->ring, &cqe))
> +		error(1, errno, "io_uring_wait_cqe");
> +
> +	res = cqe->res;
> +	*cflags = cqe->flags;
> +	io_uring_cqe_seen(&ctx->ring, cqe);
> +
> +	return res;
> +}
> +
> +static void expect_uring_nonempty(unsigned int cflags, bool expected,
> +				  const char *what)
> +{
> +	bool nonempty = !!(cflags & IORING_CQE_F_SOCK_NONEMPTY);
> +
> +	if (nonempty != expected) {
> +		fprintf(stderr, "%s: expected SOCK_NONEMPTY %d, got %d\n",
> +			what, expected, nonempty);
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +static void expect_uring_more(unsigned int cflags, bool expected,
> +			      const char *what)
> +{
> +	bool more = !!(cflags & IORING_CQE_F_MORE);
> +
> +	if (more != expected) {
> +		fprintf(stderr, "%s: expected F_MORE %d, got %d\n",
> +			what, expected, more);
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +/* Wait until the whole payload is queued, so the hint is deterministic.
> + * Return false if the test has to be skipped.
> + */
> +static bool inq_wait_queued(int fd, int len)
> +{
> +	if (!vsock_ioctl_int(fd, SIOCINQ, len)) {
> +		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void inq_send_chunks(const struct test_opts *opts, int chunks)
> +{
> +	char buf[HINT_CHUNK_SIZE];
> +	int fd, i;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	memset(buf, 0xa5, sizeof(buf));
> +	for (i = 0; i < chunks; i++)
> +		send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> +
> +	control_writeln("SENT");
> +	control_expectln("DONE");
> +	close(fd);
> +}
> +
> +static void test_stream_uring_inq_client(const struct test_opts *opts)
> +{
> +	inq_send_chunks(opts, 2);
> +}
> +
> +static void test_stream_uring_inq_server(const struct test_opts *opts)
> +{
> +	char buf[HINT_CHUNK_SIZE];
> +	struct uring_inq_ctx ctx;
> +	unsigned int cflags;
> +	int res;
> +
> +	inq_server_init(&ctx, opts);
> +
> +	control_expectln("SENT");
> +	if (!inq_wait_queued(ctx.fd, 2 * HINT_CHUNK_SIZE))
> +		goto out;
> +
> +	/* Data remains after this receive, so the flag must be set. */
> +	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
> +	expect_res(res, HINT_CHUNK_SIZE, "partial receive");
> +	expect_uring_nonempty(cflags, true, "partial receive");
> +
> +	/* This receive drains the queue while the peer stays connected. */
> +	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
> +	expect_res(res, HINT_CHUNK_SIZE, "draining receive");
> +	expect_uring_nonempty(cflags, false, "draining receive");
> +
> +out:
> +	control_writeln("DONE");
> +	inq_server_exit(&ctx);
> +}
> +
> +static void test_stream_uring_inq_eof_client(const struct test_opts *opts)
> +{
> +	char buf[HINT_CHUNK_SIZE];
> +	int fd;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	memset(buf, 0x5a, sizeof(buf));
> +	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> +	control_writeln("SENT");
> +
> +	control_expectln("DRAINED");
> +	close(fd);
> +	control_writeln("CLOSED");
> +}
> +
> +static void test_stream_uring_inq_eof_server(const struct test_opts *opts)
> +{
> +	char buf[HINT_CHUNK_SIZE];
> +	struct uring_inq_ctx ctx;
> +	unsigned int cflags;
> +	int res;
> +
> +	inq_server_init(&ctx, opts);
> +
> +	control_expectln("SENT");
> +	if (!inq_wait_queued(ctx.fd, HINT_CHUNK_SIZE)) {
> +		control_writeln("DRAINED");
> +		control_expectln("CLOSED");
> +		goto out;
> +	}
> +
> +	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
> +	expect_res(res, HINT_CHUNK_SIZE, "drain before EOF");
> +	expect_uring_nonempty(cflags, false, "drain before EOF");
> +
> +	control_writeln("DRAINED");
> +	control_expectln("CLOSED");
> +
> +	/* The queue is empty and the peer is gone.  The hint stays non-zero
> +	 * so that this receive happens and reports EOF, as TCP does after a
> +	 * FIN.
> +	 */
> +	res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
> +	expect_res(res, 0, "receive at EOF");
> +	expect_uring_nonempty(cflags, true, "receive at EOF");
> +
> +out:
> +	inq_server_exit(&ctx);
> +}
> +
> +static void test_stream_uring_inq_empty_client(const struct test_opts *opts)
> +{
> +	int fd;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	control_writeln("READY");
> +	control_expectln("DONE");
> +	close(fd);
> +}
> +
> +static void test_stream_uring_inq_empty_server(const struct test_opts *opts)
> +{
> +	char buf[HINT_CHUNK_SIZE];
> +	struct uring_inq_ctx ctx;
> +	unsigned int cflags;
> +	int res;
> +
> +	inq_server_init(&ctx, opts);
> +
> +	control_expectln("READY");
> +
> +	/* A failed receive must not leave a stale positive hint. */
> +	res = inq_recv(&ctx, buf, sizeof(buf), MSG_DONTWAIT, &cflags);
> +	expect_res(res, -EAGAIN, "empty nonblocking receive");
> +	expect_uring_nonempty(cflags, false, "empty nonblocking receive");
> +
> +	control_writeln("DONE");
> +	inq_server_exit(&ctx);
> +}
> +
> +static void test_stream_uring_inq_zerolen_client(const struct test_opts *opts)
> +{
> +	inq_send_chunks(opts, 1);
> +}
> +
> +static void test_stream_uring_inq_zerolen_server(const struct test_opts *opts)
> +{
> +	char buf[HINT_CHUNK_SIZE];
> +	struct uring_inq_ctx ctx;
> +	unsigned int cflags;
> +	int res;
> +
> +	inq_server_init(&ctx, opts);
> +
> +	control_expectln("SENT");
> +	if (!inq_wait_queued(ctx.fd, HINT_CHUNK_SIZE))
> +		goto out;
> +
> +	/* A zero-length request is not an error and still describes the
> +	 * queue behind it.
> +	 */
> +	res = inq_recv(&ctx, buf, 0, 0, &cflags);
> +	expect_res(res, 0, "zero-length receive");
> +	expect_uring_nonempty(cflags, true, "zero-length receive");
> +
> +out:
> +	control_writeln("DONE");
> +	inq_server_exit(&ctx);
> +}
> +
> +static void test_stream_uring_inq_mshot_client(const struct test_opts *opts)
> +{
> +	char buf[HINT_CHUNK_SIZE];
> +	int fd, i;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	memset(buf, 0x3c, sizeof(buf));
> +	for (i = 0; i < 2; i++)
> +		send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> +	control_writeln("SENT");
> +
> +	control_expectln("DRAINED");
> +	close(fd);
> +	control_writeln("CLOSED");
> +
> +	control_expectln("DONE");
> +}
> +
> +static void test_stream_uring_inq_mshot_server(const struct test_opts *opts)
> +{
> +	static char bufs[HINT_BUF_ENTRIES][HINT_CHUNK_SIZE];
> +	struct io_uring_buf_ring *br;
> +	struct uring_inq_ctx ctx;
> +	struct io_uring_sqe *sqe;
> +	struct io_uring_cqe *cqe;
> +	int i, ret;
> +
> +	inq_server_init(&ctx, opts);
> +
> +	br = io_uring_setup_buf_ring(&ctx.ring, HINT_BUF_ENTRIES,
> +				     HINT_BUF_GROUP, 0, &ret);
> +	if (!br) {
> +		fprintf(stderr, "io_uring_setup_buf_ring: %d\n", ret);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	for (i = 0; i < HINT_BUF_ENTRIES; i++)
> +		io_uring_buf_ring_add(br, bufs[i], HINT_CHUNK_SIZE, i,
> +				      io_uring_buf_ring_mask(HINT_BUF_ENTRIES),
> +				      i);
> +	io_uring_buf_ring_advance(br, HINT_BUF_ENTRIES);
> +
> +	control_expectln("SENT");
> +	if (!inq_wait_queued(ctx.fd, 2 * HINT_CHUNK_SIZE)) {
> +		control_writeln("DRAINED");
> +		control_expectln("CLOSED");
> +		goto out;
> +	}
> +
> +	/* Arm only once both chunks are queued, so every completion knows
> +	 * what is left behind it.
> +	 */
> +	sqe = io_uring_get_sqe(&ctx.ring);
> +	io_uring_prep_recv_multishot(sqe, ctx.fd, NULL, 0, 0);
> +	sqe->flags |= IOSQE_BUFFER_SELECT;
> +	sqe->buf_group = HINT_BUF_GROUP;
> +
> +	if (io_uring_submit(&ctx.ring) != 1)
> +		error(1, errno, "io_uring_submit");
> +
> +	/* A buffer holds one chunk, so the other one is still queued. */
> +	if (io_uring_wait_cqe(&ctx.ring, &cqe))
> +		error(1, errno, "io_uring_wait_cqe");
> +
> +	expect_res(cqe->res, HINT_CHUNK_SIZE, "multishot first chunk");
> +	expect_uring_nonempty(cqe->flags, true, "multishot first chunk");
> +	expect_uring_more(cqe->flags, true, "multishot first chunk");
> +	io_uring_cqe_seen(&ctx.ring, cqe);
> +
> +	/* This completion drains the queue and keeps the request armed. */
> +	if (io_uring_wait_cqe(&ctx.ring, &cqe))
> +		error(1, errno, "io_uring_wait_cqe");
> +
> +	expect_res(cqe->res, HINT_CHUNK_SIZE, "multishot second chunk");
> +	expect_uring_nonempty(cqe->flags, false, "multishot second chunk");
> +	expect_uring_more(cqe->flags, true, "multishot second chunk");
> +	io_uring_cqe_seen(&ctx.ring, cqe);
> +
> +	control_writeln("DRAINED");
> +	control_expectln("CLOSED");
> +
> +	/* EOF ends multishot regardless of the hint. */
> +	if (io_uring_wait_cqe(&ctx.ring, &cqe))
> +		error(1, errno, "io_uring_wait_cqe");
> +
> +	expect_res(cqe->res, 0, "multishot EOF");
> +	expect_uring_more(cqe->flags, false, "multishot EOF");
> +	io_uring_cqe_seen(&ctx.ring, cqe);
> +
> +out:
> +	control_writeln("DONE");
> +	io_uring_free_buf_ring(&ctx.ring, br, HINT_BUF_ENTRIES,
> +			       HINT_BUF_GROUP);
> +	inq_server_exit(&ctx);
> +}
> +
>  static struct test_case test_cases[] = {
>  	{
>  		.name = "SOCK_STREAM io_uring test",
> @@ -222,6 +588,31 @@ static struct test_case test_cases[] = {
>  		.run_server = test_stream_uring_msg_zc_server,
>  		.run_client = test_stream_uring_msg_zc_client,
>  	},
> +	{
> +		.name = "SOCK_STREAM io_uring receive queue hint",
> +		.run_server = test_stream_uring_inq_server,
> +		.run_client = test_stream_uring_inq_client,
> +	},
> +	{
> +		.name = "SOCK_STREAM io_uring receive hint at EOF",
> +		.run_server = test_stream_uring_inq_eof_server,
> +		.run_client = test_stream_uring_inq_eof_client,
> +	},
> +	{
> +		.name = "SOCK_STREAM io_uring receive hint on empty queue",
> +		.run_server = test_stream_uring_inq_empty_server,
> +		.run_client = test_stream_uring_inq_empty_client,
> +	},
> +	{
> +		.name = "SOCK_STREAM io_uring receive hint zero-length",
> +		.run_server = test_stream_uring_inq_zerolen_server,
> +		.run_client = test_stream_uring_inq_zerolen_client,
> +	},
> +	{
> +		.name = "SOCK_STREAM io_uring multishot receive hint",
> +		.run_server = test_stream_uring_inq_mshot_server,
> +		.run_client = test_stream_uring_inq_mshot_client,
> +	},
>  	{},
>  };
>  
> -- 
> 2.55.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
