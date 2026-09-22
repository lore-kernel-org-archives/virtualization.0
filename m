Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9414C10FB
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109468; cv=pass; b=jnbqZoXyo9nQUfpcCmdOCypyN9f11RMW1Lf6SqCTo4L1Byrt28MAU2dDvfLbAHP7HAxB7sf1/ZRWsTYIH5P7FulKN84DfxjYTaBCs/1b/wfiQZc84X2wpW5EXd+yOA9D0iYBRXv+XOunMm/QTsF51n/DuTjZFU1kkDVo76IPwZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109468; c=relaxed/simple;
	bh=1xMGOARwEIu2DR8benDMyCtm2caKFbpPVYwP0MkMm9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDRIgZFnikrcIHbghJH4vbVwUwdedFRe9cvaCN3IWSr+QOduzd5PJqjuwFhi3ghWZfjKo6gETyN/Go8lrQxdNEJ6TOJyT/Y/2UzGO9Q10fcDLQxBBKUyF2sjgVjE6sRttwdMyEEkIWT4/oxf4LquDXR5x8M9qh9wRQPGBulB9VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ1Kib3D; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ1Kib3D"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c2c08ff3f8so245833b6e.1
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 13:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109450; cv=none;
        d=google.com; s=arc-20260327;
        b=LXXegDUaJGVRJBkoEgMzfeH0K0k5UXiSiE+VevlY1IZkBRymEPw67qLTPLvFlpM2eB
         8X/appQO2POJLtdV3E1d4u7Vd2SkyNqg/wWMC7TdWmorFsrV4FQFaH3xZb/NVIDy+8Fo
         fny/LctqQX6QrGilk3D/FkxJ1sBqQbG3gxv7ndvLcWqkHdE7vRF8l1XCRoOT4/dFdURk
         maaNKIV+bPBi6ZSL5d+wb8iJMurKf96szSV80aLe24yaUR999H/IMDJp0iPE50JynkpJ
         JwgtV43pZtrg0Ev87RQPcBlyAApI/JRNYVzEYRNQLLsb6Jo/hQgIYCvMIw2nQuu1mFg6
         AmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YajuveCYvFAe8RQ5HhGjiKFAe4wxkAmcf+W9ebvlvgM=;
        fh=nlWaTur9wawbqOOxY4JqPuTiIpPZm80KCSIu9dyeOVw=;
        b=fGETyYAhZi15r45ChMbVAdGukM3tlym3+CaIpxRd5Xi/UNnIdPZl6+Q6XErdDVK4ea
         MrOZ8uLc86x7GxihKy2vv4/mZ2fIHNnYyL2eHhXjGThUC7D3b1/gbtQG244NRnGMaakd
         ZgOmLrd3tbakcTNrb07dRNoLtuwthW4Lx3C5dcBm0D9Gl4iGRT1fxobYUYYTi0OV4fxx
         5QcS4ictRDdgqmXhkn1dmjG/hnzfkpKrNLp1LLf+foGGwrz8NRVVmFZByazjAEnwTk8A
         nEEC2B9HgdZGwru3XAtPx/AiypDJZ4m17E0XpowHNDFhM0gX3BmeUmECtgkjvKQ87ffl
         4IWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109450; x=1790714250; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YajuveCYvFAe8RQ5HhGjiKFAe4wxkAmcf+W9ebvlvgM=;
        b=CQ1Kib3DfKmgzDWkDbcdLV57CTH/43pifBT2oxw+Z6WuQexNA6cd0DAin3FAXlehHW
         PqZi2+5cAqlhXfvz6l8sDE+3IUdprNi6+pZlZmg8Bl9aceKhx26Ufa1N0rFVgHyJk2PT
         jBOTbj17WpHzKu1WZdTSsRhmKpw/kzo2+MMUWOOdoqim8NBH8QNvKMA3GRilGYilApN8
         z29EVXjnLQ97ZlhCstqh8+A4PjON3bO2cLKjcwyMkOt/gJDKys8hlVqerfVCUk2dsIrM
         x+LLkvwE/PEyxHtajlKmVbQ1Kb/g0kG3vCXM9DCGb0EEe90VG5XK7vuOosL5g1O7c0ha
         78OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109450; x=1790714250;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YajuveCYvFAe8RQ5HhGjiKFAe4wxkAmcf+W9ebvlvgM=;
        b=VbpO7NXxWLr+RSUfcG1Qx+js+XSoWvF7ihCZcF6jlkXeCtFIvQN2jEzd9k9TGmpphM
         aMWXHEmtG9a5YuH2ulcIgn6I7kysNUbxTxyM/pfFVOIFXanCzYh+w5KkY/tbGZ7Zg8o8
         lt3Syb2eYW0gapWXpFOqFG90EMH9DcQvD56/Vskleso+G2BNCltSSBnHskGlXQuwRi7e
         VON8BT3M+IexLV24XyMuMQNVlCUahKOHvzcw/e+5jYnr4l+oZGDMV0Wba9hO1ESGcswb
         NRao3C1QcGks2O+Nvuu+An3s/AbtFxVGvyButbGK2T+wPupakJwWAOaI3eP4VLViaR/W
         YN8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzSPJX5wKsIYUkS3W1pi3rQcybNZFy3uGMJsRv+ovyoNwcmztzUko4edr4cliFLH5cVHybFQm+cILzmJnpEjg==@lists.linux.dev
X-Gm-Message-State: AFuF++mbIHugVL+uRjihT0AvnBZ54X8Q1+3z4Kxy6ceA/1NfxojAI/Xt
	6DJQwcRn1dUXfSR99Acf5+kEztuOZGZs2XVOaioJ2Tj9YVMQ9sNsOQwQxFVIU8JdQZY/8DvDraG
	F6g8Rvkzmmu39ynzYbB5EGT8i9gyQwR8=
X-Gm-Gg: AYBFou1iUwd4cjNcihzIf491gRb3aA2Iw+Wxwsy+Sr2gMP20DhSDDMvIoPVQ0iIJ2VP
	KYe7bA/vd6Tn+AcpY2fZM30f0sDe4scIXO4HgRichRRWTCfGQTK8G9zRyKXLmBRVepsEX/lB7re
	1qREBX8U/Cw+ffTuHyjx6ZRh+szls5kSp51Yavwv1rqGFrwALRZhycakL22Qwsk+hC/68twH1Ty
	vXn15x86CNkzWw+Qk0jR3JBdUQPfi7ie33AjXBDpdIqOBTbSqWt48B3kyatdBa/uRW2e0bPaN1j
	ufaCDFtvLFG0gyffN3kaIphgLSHen0Y99GY5UvPGWVgTeJq6eit5SLuDvBhrwUsgA+hmHpKjdcw
	Rr8PJ9uQLZw==
X-Received: by 2002:a05:6808:4f5f:b0:4b9:a829:f012 with SMTP id
 5614622812f47-4d5b940eafdmr643857b6e.30.1790109450424; Tue, 22 Sep 2026
 13:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260920194710.1114748-1-devnexen@gmail.com> <20260920194710.1114748-3-devnexen@gmail.com>
 <arK8L3S5F+9XREpe@devvm29614.prn0.facebook.com>
In-Reply-To: <arK8L3S5F+9XREpe@devvm29614.prn0.facebook.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 22 Sep 2026 21:37:19 +0100
X-Gm-Features: AcwNN1WKoxG4IBZqxkv2vlA5ApCCJffe59_-wPbMkNo4-oryaAuwKGBxd1LTreU
Message-ID: <CA+XhMqyEPSZEFY7j3eYXfrtbNMd7w3B0AYFEv1f_FEax4rKtng@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] vsock/test: cover receive queue hints
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bobby.

Indeed, io_uring presets msg_inq to -1, so that check passes either
way. Sending two chunks makes sense: SOCK_NONEMPTY on the first
completion, not on the second.

The empty queue case passing without patch 1 is expected. It is there
to catch a stale positive hint on the error path rather than to show
the new behaviour.
Cheers.

On Tue, 22 Sept 2026 at 18:34, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>
> On Sun, Sep 20, 2026 at 08:47:10PM +0100, David Carlier wrote:
> > Add io_uring receive tests checking IORING_CQE_F_SOCK_NONEMPTY across a
> > partial receive, draining while the peer stays connected, EOF, a
> > nonblocking receive on an empty queue, a zero-length request, and a
> > multishot receive with provided buffers.
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  tools/testing/vsock/vsock_uring_test.c | 367 +++++++++++++++++++++++++
> >  1 file changed, 367 insertions(+)
> >
> > diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
> > index 5c3078969659..318e17bd28bc 100644
> > --- a/tools/testing/vsock/vsock_uring_test.c
> > +++ b/tools/testing/vsock/vsock_uring_test.c
> > @@ -13,7 +13,10 @@
> >  #include <liburing.h>
> >  #include <unistd.h>
> >  #include <sys/mman.h>
> > +#include <sys/ioctl.h>
> >  #include <linux/kernel.h>
> > +#include <linux/sockios.h>
> > +#include <errno.h>
> >  #include <error.h>
> >
> >  #include "util.h"
> > @@ -28,6 +31,10 @@
> >
> >  #define VSOCK_TEST_DATA_MAX_IOV 3
> >
> > +#define HINT_CHUNK_SIZE              4096
> > +#define HINT_BUF_GROUP               1
> > +#define HINT_BUF_ENTRIES     4
> > +
> >  struct vsock_io_uring_test {
> >       /* Number of valid elements in 'vecs'. */
> >       int vecs_cnt;
> > @@ -211,6 +218,341 @@ void test_stream_uring_msg_zc_client(const struct test_opts *opts)
> >               vsock_io_uring_client(opts, &test_data_array[i], true);
> >  }
> >
> > +struct uring_inq_ctx {
> > +     struct io_uring ring;
> > +     int fd;
> > +};
> > +
> > +static void inq_server_init(struct uring_inq_ctx *ctx,
> > +                         const struct test_opts *opts)
> > +{
> > +     ctx->fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
> > +     if (ctx->fd < 0) {
> > +             perror("accept");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     if (io_uring_queue_init(RING_ENTRIES_NUM, &ctx->ring, 0))
> > +             error(1, errno, "io_uring_queue_init");
> > +}
> > +
> > +static void inq_server_exit(struct uring_inq_ctx *ctx)
> > +{
> > +     io_uring_queue_exit(&ctx->ring);
> > +     close(ctx->fd);
> > +}
> > +
> > +/* Submit a single receive and report both its result and its CQE flags. */
> > +static int inq_recv(struct uring_inq_ctx *ctx, void *buf, size_t len,
> > +                 int flags, unsigned int *cflags)
> > +{
> > +     struct io_uring_sqe *sqe;
> > +     struct io_uring_cqe *cqe;
> > +     int res;
> > +
> > +     sqe = io_uring_get_sqe(&ctx->ring);
> > +     io_uring_prep_recv(sqe, ctx->fd, buf, len, flags);
> > +
> > +     if (io_uring_submit(&ctx->ring) != 1)
> > +             error(1, errno, "io_uring_submit");
> > +
> > +     if (io_uring_wait_cqe(&ctx->ring, &cqe))
> > +             error(1, errno, "io_uring_wait_cqe");
> > +
> > +     res = cqe->res;
> > +     *cflags = cqe->flags;
> > +     io_uring_cqe_seen(&ctx->ring, cqe);
> > +
> > +     return res;
> > +}
> > +
> > +static void expect_res(int res, int expected, const char *what)
> > +{
> > +     if (res != expected) {
> > +             fprintf(stderr, "%s: expected %d, got %d\n", what, expected,
> > +                     res);
> > +             exit(EXIT_FAILURE);
> > +     }
> > +}
> > +
> > +static void expect_nonempty(unsigned int cflags, bool expected,
> > +                         const char *what)
> > +{
> > +     bool nonempty = !!(cflags & IORING_CQE_F_SOCK_NONEMPTY);
> > +
> > +     if (nonempty != expected) {
> > +             fprintf(stderr, "%s: expected SOCK_NONEMPTY %d, got %d\n",
> > +                     what, expected, nonempty);
> > +             exit(EXIT_FAILURE);
> > +     }
> > +}
> > +
> > +/* Wait until the whole payload is queued, so the hint is deterministic. */
> > +static void inq_wait_queued(int fd, int len)
> > +{
> > +     if (!vsock_ioctl_int(fd, SIOCINQ, len)) {
> > +             fprintf(stderr, "SIOCINQ not supported\n");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +}
> > +
> > +static void inq_send_chunks(const struct test_opts *opts, int chunks)
> > +{
> > +     char buf[HINT_CHUNK_SIZE];
> > +     int fd, i;
> > +
> > +     fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> > +     if (fd < 0) {
> > +             perror("connect");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     memset(buf, 0xa5, sizeof(buf));
> > +     for (i = 0; i < chunks; i++)
> > +             send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> > +
> > +     control_writeln("SENT");
> > +     control_expectln("DONE");
> > +     close(fd);
> > +}
> > +
> > +static void test_stream_uring_inq_client(const struct test_opts *opts)
> > +{
> > +     inq_send_chunks(opts, 2);
> > +}
> > +
> > +static void test_stream_uring_inq_server(const struct test_opts *opts)
> > +{
> > +     char buf[HINT_CHUNK_SIZE];
> > +     struct uring_inq_ctx ctx;
> > +     unsigned int cflags;
> > +     int res;
> > +
> > +     inq_server_init(&ctx, opts);
> > +
> > +     control_expectln("SENT");
> > +     inq_wait_queued(ctx.fd, 2 * HINT_CHUNK_SIZE);
> > +
> > +     /* Data remains after this receive, so the flag must be set. */
> > +     res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
> > +     expect_res(res, HINT_CHUNK_SIZE, "partial receive");
> > +     expect_nonempty(cflags, true, "partial receive");
> > +
> > +     /* This receive drains the queue while the peer stays connected. */
> > +     res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
> > +     expect_res(res, HINT_CHUNK_SIZE, "draining receive");
> > +     expect_nonempty(cflags, false, "draining receive");
> > +
> > +     control_writeln("DONE");
> > +     inq_server_exit(&ctx);
> > +}
> > +
> > +static void test_stream_uring_inq_eof_client(const struct test_opts *opts)
> > +{
> > +     char buf[HINT_CHUNK_SIZE];
> > +     int fd;
> > +
> > +     fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> > +     if (fd < 0) {
> > +             perror("connect");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     memset(buf, 0x5a, sizeof(buf));
> > +     send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> > +     control_writeln("SENT");
> > +
> > +     control_expectln("DRAINED");
> > +     close(fd);
> > +     control_writeln("CLOSED");
> > +
> > +     control_expectln("DONE");
> > +}
> > +
> > +static void test_stream_uring_inq_eof_server(const struct test_opts *opts)
> > +{
> > +     char buf[HINT_CHUNK_SIZE];
> > +     struct uring_inq_ctx ctx;
> > +     unsigned int cflags;
> > +     int res;
> > +
> > +     inq_server_init(&ctx, opts);
> > +
> > +     control_expectln("SENT");
> > +     inq_wait_queued(ctx.fd, HINT_CHUNK_SIZE);
> > +
> > +     res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
> > +     expect_res(res, HINT_CHUNK_SIZE, "drain before EOF");
> > +     expect_nonempty(cflags, false, "drain before EOF");
> > +
> > +     control_writeln("DRAINED");
> > +     control_expectln("CLOSED");
> > +
> > +     /* The queue is empty and the peer is gone.  The hint stays non-zero
> > +      * so that this receive happens and reports EOF, as TCP does after a
> > +      * FIN.
> > +      */
> > +     res = inq_recv(&ctx, buf, sizeof(buf), 0, &cflags);
> > +     expect_res(res, 0, "receive at EOF");
> > +     expect_nonempty(cflags, true, "receive at EOF");
> > +
> > +     control_writeln("DONE");
> > +     inq_server_exit(&ctx);
> > +}
> > +
> > +static void test_stream_uring_inq_empty_client(const struct test_opts *opts)
> > +{
> > +     int fd;
> > +
> > +     fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> > +     if (fd < 0) {
> > +             perror("connect");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     control_writeln("READY");
> > +     control_expectln("DONE");
> > +     close(fd);
> > +}
> > +
> > +static void test_stream_uring_inq_empty_server(const struct test_opts *opts)
> > +{
> > +     char buf[HINT_CHUNK_SIZE];
> > +     struct uring_inq_ctx ctx;
> > +     unsigned int cflags;
> > +     int res;
> > +
> > +     inq_server_init(&ctx, opts);
> > +
> > +     control_expectln("READY");
> > +
> > +     /* A failed receive must not leave a stale positive hint. */
> > +     res = inq_recv(&ctx, buf, sizeof(buf), MSG_DONTWAIT, &cflags);
> > +     expect_res(res, -EAGAIN, "empty nonblocking receive");
> > +     expect_nonempty(cflags, false, "empty nonblocking receive");
>
>
>
> > +
> > +     control_writeln("DONE");
> > +     inq_server_exit(&ctx);
> > +}
> > +
> > +static void test_stream_uring_inq_zerolen_client(const struct test_opts *opts)
> > +{
> > +     inq_send_chunks(opts, 1);
> > +}
> > +
> > +static void test_stream_uring_inq_zerolen_server(const struct test_opts *opts)
> > +{
> > +     char buf[HINT_CHUNK_SIZE];
> > +     struct uring_inq_ctx ctx;
> > +     unsigned int cflags;
> > +     int res;
> > +
> > +     inq_server_init(&ctx, opts);
> > +
> > +     control_expectln("SENT");
> > +     inq_wait_queued(ctx.fd, HINT_CHUNK_SIZE);
> > +
> > +     /* A zero-length request is not an error and still describes the
> > +      * queue behind it.
> > +      */
> > +     res = inq_recv(&ctx, buf, 0, 0, &cflags);
> > +     expect_res(res, 0, "zero-length receive");
> > +     expect_nonempty(cflags, true, "zero-length receive");
> > +
> > +     control_writeln("DONE");
> > +     inq_server_exit(&ctx);
> > +}
> > +
> > +static void test_stream_uring_inq_mshot_client(const struct test_opts *opts)
> > +{
> > +     char buf[HINT_CHUNK_SIZE];
> > +     int fd;
> > +
> > +     fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> > +     if (fd < 0) {
> > +             perror("connect");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     memset(buf, 0x3c, sizeof(buf));
> > +     send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> > +     control_writeln("SENT");
> > +
> > +     control_expectln("DRAINED");
> > +     close(fd);
> > +     control_writeln("CLOSED");
> > +
> > +     control_expectln("DONE");
> > +}
> > +
> > +static void test_stream_uring_inq_mshot_server(const struct test_opts *opts)
> > +{
> > +     static char bufs[HINT_BUF_ENTRIES][HINT_CHUNK_SIZE];
> > +     struct io_uring_buf_ring *br;
> > +     struct uring_inq_ctx ctx;
> > +     struct io_uring_sqe *sqe;
> > +     struct io_uring_cqe *cqe;
> > +     int i, ret;
> > +
> > +     inq_server_init(&ctx, opts);
> > +
> > +     br = io_uring_setup_buf_ring(&ctx.ring, HINT_BUF_ENTRIES,
> > +                                  HINT_BUF_GROUP, 0, &ret);
> > +     if (!br) {
> > +             fprintf(stderr, "io_uring_setup_buf_ring: %d\n", ret);
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     for (i = 0; i < HINT_BUF_ENTRIES; i++)
> > +             io_uring_buf_ring_add(br, bufs[i], HINT_CHUNK_SIZE, i,
> > +                                   io_uring_buf_ring_mask(HINT_BUF_ENTRIES),
> > +                                   i);
> > +     io_uring_buf_ring_advance(br, HINT_BUF_ENTRIES);
> > +
> > +     sqe = io_uring_get_sqe(&ctx.ring);
> > +     io_uring_prep_recv_multishot(sqe, ctx.fd, NULL, 0, 0);
> > +     sqe->flags |= IOSQE_BUFFER_SELECT;
> > +     sqe->buf_group = HINT_BUF_GROUP;
> > +
> > +     if (io_uring_submit(&ctx.ring) != 1)
> > +             error(1, errno, "io_uring_submit");
> > +
> > +     control_expectln("SENT");
> > +
> > +     /* The payload completion drains the queue and keeps the request
> > +      * armed, so the hint must report the queue as empty.
> > +      */
> > +     if (io_uring_wait_cqe(&ctx.ring, &cqe))
> > +             error(1, errno, "io_uring_wait_cqe");
> > +
> > +     expect_res(cqe->res, HINT_CHUNK_SIZE, "multishot payload");
> > +     expect_nonempty(cqe->flags, false, "multishot payload");
>
> It looks like this assertion holds true even without the first patch,
> since msg_inq is initalized to -1 and nonempty is only set if msg_inq >
> 0.
>
> As of right now, this test actually passes without the first patch.
> After cherry-picking only the tests to net-next and yanking out the
> other test cases, I see:
>
>         client exit=0
>         server exit=0
>         Control socket listening on 0.0.0.0:5200
>         Control socket connection accepted...
>         0 - SOCK_STREAM io_uring receive hint on empty queue...ok
>         1 - SOCK_STREAM io_uring multishot receive hint...ok
>         All tests have been executed. Waiting other peer...ok
>
>
> I wonder if it might be better to have the sender send two chunks so we
> can first assert that NONEMPTY is flipped on, and then again that it has
> flipped back off?
>
> Best,
> Bobby
>
> > +     if (!(cqe->flags & IORING_CQE_F_MORE)) {
> > +             fprintf(stderr, "multishot payload: request not rearmed\n");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +     io_uring_cqe_seen(&ctx.ring, cqe);
> > +
> > +     control_writeln("DRAINED");
> > +     control_expectln("CLOSED");
> > +
> > +     /* EOF ends multishot regardless of the hint. */
> > +     if (io_uring_wait_cqe(&ctx.ring, &cqe))
> > +             error(1, errno, "io_uring_wait_cqe");
> > +
> > +     expect_res(cqe->res, 0, "multishot EOF");
> > +     if (cqe->flags & IORING_CQE_F_MORE) {
> > +             fprintf(stderr, "multishot EOF: request still armed\n");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +     io_uring_cqe_seen(&ctx.ring, cqe);
> > +
> > +     control_writeln("DONE");
> > +     io_uring_free_buf_ring(&ctx.ring, br, HINT_BUF_ENTRIES,
> > +                            HINT_BUF_GROUP);
> > +     inq_server_exit(&ctx);
> > +}
> > +
> >  static struct test_case test_cases[] = {
> >       {
> >               .name = "SOCK_STREAM io_uring test",
> > @@ -222,6 +564,31 @@ static struct test_case test_cases[] = {
> >               .run_server = test_stream_uring_msg_zc_server,
> >               .run_client = test_stream_uring_msg_zc_client,
> >       },
> > +     {
> > +             .name = "SOCK_STREAM io_uring receive queue hint",
> > +             .run_server = test_stream_uring_inq_server,
> > +             .run_client = test_stream_uring_inq_client,
> > +     },
> > +     {
> > +             .name = "SOCK_STREAM io_uring receive hint at EOF",
> > +             .run_server = test_stream_uring_inq_eof_server,
> > +             .run_client = test_stream_uring_inq_eof_client,
> > +     },
> > +     {
> > +             .name = "SOCK_STREAM io_uring receive hint on empty queue",
> > +             .run_server = test_stream_uring_inq_empty_server,
> > +             .run_client = test_stream_uring_inq_empty_client,
> > +     },
> > +     {
> > +             .name = "SOCK_STREAM io_uring receive hint zero-length",
> > +             .run_server = test_stream_uring_inq_zerolen_server,
> > +             .run_client = test_stream_uring_inq_zerolen_client,
> > +     },
> > +     {
> > +             .name = "SOCK_STREAM io_uring multishot receive hint",
> > +             .run_server = test_stream_uring_inq_mshot_server,
> > +             .run_client = test_stream_uring_inq_mshot_client,
> > +     },
> >       {},
> >  };
> >
> > --
> > 2.55.0
> >
