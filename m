Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75A55C1A6
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084377; cv=none; b=MPOD00+FGvq7/m6ZuM21mLT+LTXkNhnB0KLvFbNgbuwUbN7g+cF+BtC9bOisSPxF7Z2sbtWSM9ewnTULfjSGda3bdNOyrNv0pDVOPi2Kev2suhXNc5BJII/eC3H6LesLfDlHQvgVAXSVDFg5EN5TNtecTaCA3dLfn6j/wfvp9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084377; c=relaxed/simple;
	bh=osgLb83yFsRE+4WKH4oMUa4bpaw0Rf0txzh5HDUYb9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3DG2v0FT8IqaX3vCTSREgJvuj1pf6/wcVK1DLXeY6XUZlHB9dtE/xo2xWm8qFb1vLYy9d398xzngGEC/zbvyJk1e4VW3HJAN3NGypNGa6sqkim80QXg6pvKZBAa3t/9E4ZbEdnK+1XZcpdgmN6ckJKvpSq91eps8PomXtOQoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx7AZu4e; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx7AZu4e"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4f59e61f295so3998733b6e.3
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084360; x=1792689160; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v1Nya3lc2pT1QnY6/Kp/W2D1uTwpLgP3HDFkOjoMsgg=;
        b=Rx7AZu4e7Ayt0zkR5y8+zYwE4/W+4Rmo1uP0UOqDMzWAf9p5tDMEY27PFEfqCFxU8E
         DgK4FtxOYwHdRU39HoDHsKtAKOSXXDDRQvk5fzgep2KbIy1CDsPpFaGlt549t+RxW3SW
         PBkTsOOkQaZY5PjlH68gO91UwUnKvx5R25AAdg5mAkozj4UyMaYQMEE6etU4oWi1Se9X
         93p/FnwE61mJR9sHYFYUMl7KaEZfAPs6ura4JVgu4K8CzlBtl/6PmEEKp8+usZFtKbPf
         xKx1/V6pL46vjR7Gl2rSfpd+9Gb2128MyXcq6OD3W8O/TmjiRcJ9+Ijpoyi4F4l4sxEG
         WBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084360; x=1792689160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1Nya3lc2pT1QnY6/Kp/W2D1uTwpLgP3HDFkOjoMsgg=;
        b=BrcvPAJGbulJndgpkhlUTi9ejIf191Y7/S1gb42ib/4jlwCWJgndPJmG7HmtgiCRuz
         G2fABOqXyleLj/kaSyqkC5cyPdKyMyUGGS8TlrnZkvVJIQjDLsQFDuh0EopTTvuOSae6
         DZAfrrj1QNs/b23nj95C+mkaTXCUjZiGiS8boskBJQCniRLfKNLUwav1/Dgrk9CPdqlR
         ReE1vnflRcT3WLgUxQZ8qnwa5me30VVeO2Dcf7+C1PbxYOvNCjVHzUg5jncK7utEw+dJ
         FUra8on4qXkutHGCcxWGwjIjNGGTyxaStSm2PEVmmt+MmBX9khZnErB+6LmyuTgaRSXU
         7hKQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5yI/pS9OOhHGu5YX7wDJLwCroZM+hoi1nAUB9tECZdCM9R4HprCWoMcYeaRSCdnEJ/M1xIpGcg8Mxae74Jw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKsQ+JXVLT9oBoTmaz3Z4oqFBhPsEcPVXL2J3e/FZgbhz6FxhyI
	q3V+HOlunrUa8VORwyZ3EDb3ERpP2RmlrwkiZvE2xhv/RLkQ6GhQRo8+
X-Gm-Gg: AYBFou29kPssJooFx9XMAbJZFIZnklUSsX62u9tTr9yErCf/7Z4x80HzA9juAZRq3sR
	VsResdaup7Z3DDqC8mrSaObY9XX4+atSt4PBGcQDjfU1AxR7en9rsQ3pF5PpL/VdxmbfOg/2BA3
	Yru5J56B4IRPh8gZ8WMyZLoKrXYuhECFkiwNLrGPPVK6GJ6LTzQyOE7CtsXGEbawx5q7D/R6dCN
	2ZaVAcgKl/rVO5I4jrWBa1lrfvqRM71S0p2EFKvp4i49RrEeyjhbs3NopbrUf87slbf7c281rFe
	1xVadDxCabjZsMq2xeSzK79u9FOPSBD3ZJ1ZVBvDl2nVt9wEk+R0R1XhrTIxlAL5QEDpyRzVaqN
	+kl74axjjAjTJ3brCIP80xHSu3SDmGuofzZA9K9pUluDGEzqv92JiEqwT4rUDcDs+kRLt7DJTns
	i+R9FmjOKl9YFDWtLbRs/lKyxzc1DaOf8utPYz6ExwF6MzJNXr0KUA437z2dY3x4jfdY8=
X-Received: by 2002:a05:6809:2007:10b0:52b:7641:33a6 with SMTP id 5614622812f47-52b7650779fmr4809945b6e.14.1792084360337;
        Thu, 15 Oct 2026 10:12:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-537aa863df0sm54271b6e.1.2026.10.15.10.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:12:39 -0700 (PDT)
Date: Thu, 15 Oct 2026 10:12:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] vsock/test: cover SO_INQ
Message-ID: <atEJhetXtwmGngqT@devvm29614.prn0.facebook.com>
References: <20261015154334.3217358-1-devnexen@gmail.com>
 <20261015154334.3217358-3-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015154334.3217358-3-devnexen@gmail.com>

On Thu, Oct 15, 2026 at 04:43:34PM +0100, David Carlier wrote:
> Check the SCM_INQ value after a partial receive, after draining the
> queue and at EOF, that no cmsg is sent while the option is off, that
> accepted sockets inherit it from the listener, and that out of range
> values and SOCK_SEQPACKET are rejected.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  tools/testing/vsock/vsock_test.c | 279 +++++++++++++++++++++++++++++++
>  1 file changed, 279 insertions(+)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index b4ff9f946565..10b9074fb87f 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -2429,6 +2429,271 @@ static void test_stream_collapse_server(const struct test_opts *opts)
>  	close(fd);
>  }
>  
> +#define SO_INQ_BUF_LEN 64
> +#define SO_INQ_CHUNK_LEN 16
> +
> +static int so_inq_set(int fd, int val)
> +{
> +	return setsockopt(fd, SOL_SOCKET, SO_INQ, &val, sizeof(val));
> +}
> +
> +/* Receive @len bytes and return the SCM_INQ value, or -1 if the kernel did
> + * not attach one.
> + */
> +static int so_inq_recv(int fd, size_t len, int expected_ret)
> +{
> +	char control[CMSG_SPACE(sizeof(int))] = { 0 };
> +	unsigned char buf[SO_INQ_BUF_LEN];
> +	struct iovec iov = {
> +		.iov_base = buf,
> +		.iov_len = len,
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +		.msg_control = control,
> +		.msg_controllen = sizeof(control),
> +	};
> +	struct cmsghdr *cmsg;
> +	ssize_t ret;
> +	int inq;
> +
> +	ret = recvmsg(fd, &msg, 0);
> +	if (ret < 0) {
> +		perror("recvmsg");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	expect_res(ret, expected_ret, "recvmsg");
> +
> +	if (msg.msg_flags & MSG_CTRUNC) {
> +		fprintf(stderr, "SCM_INQ control message truncated\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
> +		if (cmsg->cmsg_level != SOL_SOCKET ||
> +		    cmsg->cmsg_type != SCM_INQ)
> +			continue;
> +
> +		if (cmsg->cmsg_len != CMSG_LEN(sizeof(inq))) {
> +			fprintf(stderr, "unexpected SCM_INQ length %zu\n",
> +				(size_t)cmsg->cmsg_len);
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		memcpy(&inq, CMSG_DATA(cmsg), sizeof(inq));
> +		return inq;
> +	}
> +
> +	return -1;
> +}
> +
> +static void test_stream_so_inq_client(const struct test_opts *opts)
> +{
> +	int fd;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	control_expectln("SENT");
> +
> +	/* Wait for the whole payload to be queued, so the values below do not
> +	 * depend on how the transport delivers it.
> +	 */
> +	if (!vsock_ioctl_int(fd, SIOCINQ, SO_INQ_BUF_LEN)) {
> +		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
> +		goto out;
> +	}
> +
> +	/* No ancillary data unless the option is enabled. */
> +	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN), -1,
> +		   "SCM_INQ with SO_INQ disabled");
> +
> +	if (so_inq_set(fd, 1)) {
> +		if (errno != ENOPROTOOPT) {
> +			perror("setsockopt(SO_INQ)");
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
> +		goto out;
> +	}
> +
> +	/* Partial read: the rest of the payload is still queued. */
> +	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN),
> +		   SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN,
> +		   "SCM_INQ after partial receive");
> +
> +	/* Draining read while the peer stays connected. */
> +	expect_res(so_inq_recv(fd, SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN,
> +			       SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN), 0,
> +		   "SCM_INQ after draining receive");
> +
> +	control_writeln("DRAINED");
> +	vsock_wait_remote_close(fd);
> +
> +	/* Nothing is queued once the peer is gone, but 1 is reported so the
> +	 * caller keeps reading until it observes EOF, as TCP_INQ does.
> +	 */
> +	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, 0), 1, "SCM_INQ at EOF");
> +
> +	if (so_inq_set(fd, 0)) {
> +		perror("setsockopt(SO_INQ)");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, 0), -1,
> +		   "SCM_INQ after disabling SO_INQ");
> +
> +	close(fd);
> +	return;
> +
> +out:
> +	control_writeln("DRAINED");
> +	close(fd);
> +}
> +
> +static void test_stream_so_inq_server(const struct test_opts *opts)
> +{
> +	unsigned char buf[SO_INQ_BUF_LEN];
> +	int fd;
> +
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
> +	if (fd < 0) {
> +		perror("accept");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	memset(buf, 'A', sizeof(buf));
> +	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> +	control_writeln("SENT");
> +
> +	/* Keep the connection open until the peer has drained the queue: an
> +	 * early close would turn its last SCM_INQ value into the EOF one.
> +	 */
> +	control_expectln("DRAINED");
> +	close(fd);
> +}
> +
> +static void test_stream_so_inq_inherit_client(const struct test_opts *opts)
> +{
> +	unsigned char buf[SO_INQ_BUF_LEN];
> +	int fd;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	memset(buf, 'A', sizeof(buf));
> +	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> +	control_writeln("SENT");
> +
> +	control_expectln("DONE");
> +	close(fd);
> +}
> +
> +static void test_stream_so_inq_inherit_server(const struct test_opts *opts)
> +{
> +	bool supported = true;
> +	int listen_fd, fd;
> +
> +	listen_fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
> +
> +	/* Enable the option on the listener only. */
> +	if (so_inq_set(listen_fd, 1)) {
> +		if (errno != ENOPROTOOPT) {
> +			perror("setsockopt(SO_INQ)");
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
> +		supported = false;
> +	}
> +
> +	control_writeln("LISTENING");
> +
> +	timeout_begin(TIMEOUT);
> +	do {
> +		fd = accept(listen_fd, NULL, NULL);
> +		timeout_check("accept");
> +	} while (fd < 0 && errno == EINTR);
> +	timeout_end();
> +
> +	if (fd < 0) {
> +		perror("accept");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	close(listen_fd);
> +	control_expectln("SENT");
> +
> +	if (!supported)
> +		goto out;
> +
> +	if (!vsock_ioctl_int(fd, SIOCINQ, SO_INQ_BUF_LEN)) {
> +		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
> +		goto out;
> +	}
> +
> +	/* The accepted socket reports SCM_INQ without its own setsockopt(). */
> +	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN),
> +		   SO_INQ_BUF_LEN - SO_INQ_CHUNK_LEN,
> +		   "SCM_INQ inherited from the listener");
> +
> +out:
> +	control_writeln("DONE");
> +	close(fd);
> +}
> +
> +static void test_so_inq_validation_client(const struct test_opts *opts)
> +{
> +	int fd;
> +
> +	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
> +	if (fd < 0) {
> +		perror("socket");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (so_inq_set(fd, 1)) {
> +		if (errno != ENOPROTOOPT) {
> +			perror("setsockopt(SO_INQ)");
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
> +		close(fd);
> +		return;
> +	}
> +
> +	if (!so_inq_set(fd, 2) || errno != EINVAL) {
> +		fprintf(stderr, "SO_INQ accepted an out of range value\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	close(fd);
> +
> +	/* SCM_INQ counts bytes, which a message based socket cannot report. */
> +	fd = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
> +	if (fd < 0) {
> +		perror("socket");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (!so_inq_set(fd, 1) || errno != ENOPROTOOPT) {
> +		fprintf(stderr, "SO_INQ not rejected on SOCK_SEQPACKET\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	close(fd);
> +}
> +
>  static struct test_case test_cases[] = {
>  	{
>  		.name = "SOCK_STREAM connection reset",
> @@ -2633,6 +2898,20 @@ static struct test_case test_cases[] = {
>  		.run_client = test_stream_collapse_client,
>  		.run_server = test_stream_collapse_server,
>  	},
> +	{
> +		.name = "SOCK_STREAM SO_INQ functionality",
> +		.run_client = test_stream_so_inq_client,
> +		.run_server = test_stream_so_inq_server,
> +	},
> +	{
> +		.name = "SOCK_STREAM SO_INQ inherited by accepted socket",
> +		.run_client = test_stream_so_inq_inherit_client,
> +		.run_server = test_stream_so_inq_inherit_server,
> +	},
> +	{
> +		.name = "SO_INQ option validation",
> +		.run_client = test_so_inq_validation_client,
> +	},
>  	{},
>  };
>  
> -- 
> 2.55.0
> 

Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
