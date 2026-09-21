Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2A3B0AF5
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020047; cv=none; b=K5ENoqLNqWl+vuTfiVZZ/bcvUS+sDI2bOzHFEyoxxpSQ+7RhoPaiRnN3sOS+coZJdv7Ua/Y5m7sqDXD1MP4rfjHWqCqlOPUwjPtLmiIp6vbVEnS6CA+PIgRR30PCbm98EY6ORIydd7gk5ws+EICoaSK974NEg+Cf5tesOdfcu2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020047; c=relaxed/simple;
	bh=g7EXBYu4qaWhu+6Zmx1y2vDCQqcaU9Ei9SMTCT8FLa0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i3K0iPGL4xdYchVZa/x+2ncNbgRaMp7bn8L6oVq2aGhWGsIGRwqHeRBy23CsjdC4xbaYE9ySl65l90LjT3++BmXhWzrghbFh8w4bXhRj9xe/4iL8G70SacWWECVFrXC9A0YOTU1w+67YAnzMUVVJtmb/W/hxqa/cUlITfaFrx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5YmHFyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5YmHFyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D741F000FF;
	Mon, 21 Sep 2026 19:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020045;
	bh=g7EXBYu4qaWhu+6Zmx1y2vDCQqcaU9Ei9SMTCT8FLa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5YmHFyCxfpuntEekvRmcPxHSmcdBRHy1N16F/xKf7Ok1/kbGeSSE31VaJA5gTJB7
	 WqW5r2AK0fNobmhCBfrCMlKhme2zlwU/bxAnnb8vtQk4JppfTxlHbh02xMlAGcs9/p
	 0QiSeB+VOtVH5qHeN3lBOGPasFRfrs8ZKFU5Nfp5K+fOkAAXk9yvRD819ZqjJSDWtc
	 rb0Dm3CVXJJAt+qzzBH03ATIHjxwQCOHJvQLfnqnUO1L+nFDVMSoQPkD9RkkNLcHPx
	 Vks9pAlL4bdgPIZB6RUwQdhknU/DX04yGuAQtLoR2jdm7uYj/nXcrm8hKPrytKRRZ9
	 8RlTQrBF3eJMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] vsock: report pending receive data to
 io_uring
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260920194710.1114748-2-devnexen@gmail.com>
References: <20260920194710.1114748-1-devnexen@gmail.com>
 <20260920194710.1114748-2-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:47:24 +0000
Message-Id: <20260921194725.53D741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> AF_VSOCK stream receives never fill msghdr.msg_inq, so io_uring cannot set
> IORING_CQE_F_SOCK_NONEMPTY and retries a multishot receive even after the
> queue has been drained.
>=20
> Fill the hint at the common receive exit using the transport callback that
> SIOCINQ already uses, and report 1 once the connection is finished so the
> caller performs the receive which observes EOF, as TCP does after a FIN.
>=20
> A vsock loopback ping-pong with io_uring multishot receive drops entries
> into __vsock_connectible_recvmsg from 1.97 to 1.00 per delivered message,
> and receiver CPU time by about 3% (25 runs of 50000 messages, p=3D0.006).
>=20
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920194710.1114=
748-1-devnexen@gmail.com?part=3D1

