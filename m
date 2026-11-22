Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349809;
	b=Jd5ky68SIXps8WHAdJdt2SlqykGhsf0lLdz77GnA9HcIDIStbSPt/8/N0uRmoTK8N7aN
	 4CeTKmd/diX1xdPqKv57LKtx9gXVAXTkSTYQjGu4lxBdE921V+0EJ2tEJdJuasHo4DbaZ
	 TY/TQXLtIE2KJewh+TxlK81jlLFtq5ayQTcSfaZxo0jxbWJAwRInZkJIYe9hKgvQaBamh
	 jdXh3HWjRf0ErsAfVcyowpfwmtkrGGnH7wl/quw3QDZa7keuyrKZYFAlDsgaOCaiM2nTl
	 2j+G4VvwV5H5R1F7PqPB/rz0rR71uzCAdVGkf0CTv0byLTqf+L++mXaEIl68Y7bSmjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DGxTEWYYhD2gg12YNXXJ9wjB5NKJOibK98lbiciFlxM=;
	b=C+h/IyQS6mXAzd+pP1nNQ2o9GiW8QkGt48X8vfQaZ2MHh5kLJMkRDq7jdpMHfFeB22uv
	 2oiGwHAzRrLBjBmH43G0M00fhay5/H3stZVt9Ow07MTz0A4BemrX5mdfQ6QkueLUo9yO7
	 OgVqgNLH4jZ5g+bcreFtUBKPUWl2vcc8xnCkZm/qi6EkzRlfO6XvkHrOsAcMbvckW61wD
	 kNG8XOCRT2k0NsPM0JZBHVJMTebAW7AB5WaVM/XbMDA11HGykhL5uCynPqN2iSX4J5U6L
	 yW74HnntF977AOKS3o1olBUcRICSCk3n7d7A8gHzDFqxelLCLJO12eIh5Hu478w2+9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSt01Ni0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48440606A320
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSt01Ni0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2D61F000C4;
	Sun, 22 Nov 2026 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795349808;
	bh=DGxTEWYYhD2gg12YNXXJ9wjB5NKJOibK98lbiciFlxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSt01Ni063SHCsVYwHxEKuYlToIOH/zH5Nfd0oMJQTDAsuSiH5wPMaFOkgYWs5dME
	 IlpVTSG/zvgb9Dzo5QoCJeO2IP1stFnNXYtCZ5mTQDUlfMNhf4qHWr6B/ef49aFuJA
	 IliGbImYuDh3c2grHDKXXaZRyjNCly5mZTQhgNEfHFQNd2L1ftwcPRIz+UMzxjsTPp
	 NRxcu/s4uoJsbyoFmVmkE/rzEiNNp1DNMLIEW0yKu2tBKB0TkuBf48bjD8QI2DTNZo
	 V3dbhwrNnHoepQZqmUaZMbzc2vX8Yqt1sdtDOtxCKTPfB24kBwdycNsJ2kQEFpIpUd
	 9EhLkiFIqIjYg==
Message-ID: <sashiko-outbox-227921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hengyu Liang" <hengyul@cs.unc.edu>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261122120919.1718445-1-hengyul@cs.unc.edu>
References: <20261122120919.1718445-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 12:16:48 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Commit 333c515d1896 ("vhost-net: allow configuring extended features")
> added VHOST_SET_FEATURES_ARRAY. The ioctl reads the number of feature
> words from user space and checks that every word above the supported
> ones is zero, one word at a time in a loop.
>=20
> However, the loop has no upper bound and no scheduling point. As of now,
> a caller can pass a count of U64_MAX and a pointer into a large
> zero-filled mapping. The ioctl then stays in the kernel for as long as
> the mapping is readable, and a fatal signal is not handled until it
> ends. On a v6.18 debug kernel booted with preempt=3Dnone, two such calls
> from a non-root user, each on a 4 GiB mapping, froze a 2-CPU VM for
> 56 s with soft lockup reports.
>=20
> Interfaces that take an extensible structure from user space limit it
> to one page (openat2, clone3, sched_setattr).
>=20
> On a KASAN kernel with a 1 GiB mapping: before commit 333c515d1896
> ("vhost-net: allow configuring extended features"), the ioctl does not
> exist and the call fails with EPERM at once. After that commit, it
> fails with EFAULT after 26.0 s. With this patch, it fails with E2BIG at
> once. A reproducer is available on request.
>=20
> This patch will reject counts above one page of words (512 on a 4 KiB
> page, or 32768 feature bits; 128 are defined today) before the walk
> starts.
>=20
> Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> Cc: stable@vger.kernel.org # v6.17+
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122120919.1718=
445-1-hengyul@cs.unc.edu?part=3D1
