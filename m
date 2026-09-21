Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C53AB262
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020048; cv=none; b=Aet6/g/PY9LHdo96v16c4p26ctt0aL2VlaPFw5rXRla4teFHXKZnz6Ap/ywBTaXMM9gpt759MuG1K5fr0GZed+KThkkwxMT+UIiqBCz2GTkOg6KfSEXJU0Dq3hiAOxuhCR8UMKecMAWzyWufPSGdt61JnI0CDgC1ed1B4g2W+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020048; c=relaxed/simple;
	bh=FNr3hydMrh54VWtx5G/2qJWsvjAMD+X8qjPHR9ffJdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lgw9FBOAgkMeJdvj0iYL8kS9n4SDXy1IPJuhKDCzwYaX+f8dvidXmGE9x4TH3SrZ2M6raQMTvMJEO8OJO0mq8mvtNgODmJB6JSE8Nnn8tpxKm8lglpXrqvd3W1r1pkKS5bwsEcunXywzoiXWdRNtmJqx4TZqQpBxnI0fzBTfZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+5mWpB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+5mWpB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA141F00893;
	Mon, 21 Sep 2026 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020046;
	bh=1zo69J6PyEV5VMVekZVBEtZFQrRUeos70hbgTEM+B2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+5mWpB43wkffaKCWtcBInYxOfqw8APRW3QWMxlZ5HXupLYdEYxWK9H08KXHKrXF+
	 K8ObRbixzXjr+iV3409NRNVxfHs8rj6LTEK+eZiRl6TuP0Ii9GuMuXOiSWksVoHIs9
	 zTTV7cSwLoW8YdsLz2q1yf2we79uEq0rcWeNkpr/0qks56/vRT9DTBSdr49dlAxpcp
	 1PDOP1B8GJB5yk1ylrUSxvvixRM1F0M/zoIRZnvNM63MYBdQb7Q5ZtFglLNheup7Me
	 2X1qDmC5F7eC7Aw2c11xUqsEX7Oah1zgbF6VNtq2Ajs506ZmZakyzcPtocOwUalHE4
	 tpBfJRqvT9Qqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] vsock/test: cover receive queue hints
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260920194710.1114748-3-devnexen@gmail.com>
References: <20260920194710.1114748-1-devnexen@gmail.com>
 <20260920194710.1114748-3-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:47:25 +0000
Message-Id: <20260921194726.2BA141F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vsock/test: flaky multishot receive test due to partial reads
--

commit 9ec49ee8a33c71acaaeb9095c84d90cff4a9c2d9
Author: David Carlier <devnexen@gmail.com>

vsock/test: cover receive queue hints

This commit adds io_uring receive tests to verify the behavior of the
IORING_CQE_F_SOCK_NONEMPTY flag across several receive scenarios, including
partial receives, EOF, nonblocking empty receives, and multishot receives.

> diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock=
/vsock_uring_test.c
> index 5c3078969659f..318e17bd28bc6 100644
> --- a/tools/testing/vsock/vsock_uring_test.c
> +++ b/tools/testing/vsock/vsock_uring_test.c
[ ... ]
> +static void test_stream_uring_inq_mshot_server(const struct test_opts *o=
pts)
> +{
[ ... ]
> +	sqe =3D io_uring_get_sqe(&ctx.ring);
> +	io_uring_prep_recv_multishot(sqe, ctx.fd, NULL, 0, 0);
> +	sqe->flags |=3D IOSQE_BUFFER_SELECT;
> +	sqe->buf_group =3D HINT_BUF_GROUP;
> +
> +	if (io_uring_submit(&ctx.ring) !=3D 1)
> +		error(1, errno, "io_uring_submit");
> +
> +	control_expectln("SENT");
> +
> +	/* The payload completion drains the queue and keeps the request
> +	 * armed, so the hint must report the queue as empty.
> +	 */
> +	if (io_uring_wait_cqe(&ctx.ring, &cqe))
> +		error(1, errno, "io_uring_wait_cqe");
> +
> +	expect_res(cqe->res, HINT_CHUNK_SIZE, "multishot payload");

[Severity: Medium]
Does submitting the multishot receive request before the data is fully
queued introduce a race condition that could cause flaky test failures?=20

Since test_stream_uring_inq_mshot_server() operates on a SOCK_STREAM
socket, the transport does not preserve message boundaries and data can
arrive in fragments. If a fragment arrives before the entire payload is
queued, io_uring may post a CQE with a partial data length. This would
subsequently cause the strict assertion expecting exactly HINT_CHUNK_SIZE
to fail.

Could inq_wait_queued() be used here prior to submitting the request,
similar to the deterministic approach taken in the other tests in this
file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920194710.1114=
748-1-devnexen@gmail.com?part=3D2
