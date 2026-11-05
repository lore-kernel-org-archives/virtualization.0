Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891635;
	b=N3BZPajT8cTE0wqCpLXDnxBJK9NGRtys44V2cPYB7tNIquwlARpMN5ODaMcwih0M3jw4
	 ES/zZtfXeHumTE4XXDNfXj1hCgFbwDuLMxlNjs354nycJYWpT4vcgy/qZoyeDI9cH6hsh
	 1SmG/nvbKrZCJ1IzGwzMOyUMo05JURlluzCa47b32SgWO9g7i8+RRhODyEMetlbVi71Jk
	 xF4lyn37LynGMOCUXRPpHGhM2h6QBAdNb6ZS+EoczezQMQqTej+NFLtJz7ry61NfDft5S
	 xRiDdDngWlU46/JD8zUoAMYu1iia3dWLWjh9J54BA52kUJVxZm9evl5x7TMR1JZj2oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891635;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FAiLThNA0tfCrnNn34hqjBMdB1k5+a4NQbfFUQrgWQ8=;
	b=ShtXwl5l9c/Nk0Di4ewyykCHXG7Zs3g56j6u3hUPIQkKPdjX+z9bmoVCmAZ7nuaL8o9k
	 wIilDqw1chH9CXrrRApdRhoouDsyJ4vox0BM7EPp18EKg34wK1I06ZWUd9d3jDB7CpHAJ
	 rZnEvCBUry0tCWIJNtvQfLIr2baa/njqEjN2jC+yldqLAZ4QS4QXbTCS/ikcHSmIivycx
	 H5K0Fx28ur9hglwFfWrXEkt+nyTsY0cVw/6HIpViO1aW/4Um/BjHJMI5HcZQcGJgDaTiB
	 BHHWggggznkNKHZBEHWEb7w6qk+srKl3QezoOi7o/KZMwZEGZlb5RctU/sB8Xzd9vRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvpU8Kux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D21606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvpU8Kux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6A11F00A17;
	Thu,  5 Nov 2026 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793891635;
	bh=FAiLThNA0tfCrnNn34hqjBMdB1k5+a4NQbfFUQrgWQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SvpU8KuxLppAin2YLnH5gbH4BLS++BpEfxh4AOcWrjaWI0JAMmfGaMAoWkSKMGSZ+
	 oPv9PVNHDlOComKqWS3MddqCTiPLoS2XkWQYOrBrFbuiYtngUhtIj8f98XVkS4i75X
	 kzAfPUzeHCrobcBy5nw36iOMY7Bmkf+s72YLqWSnme3G8t61nbcqU7IgUJ5fToKk46
	 a5y6/f6i6wtb03icv99xwECWsEVNCqfxZzLx4owj1g0II6C9hfYjuuFdjHBe+frj0r
	 S9lLufiOTdeyXg+NYXgVpXjIGRWtOWgoMU9Z6Sn7/6FUi7TLEBsFw0N2HpvKg3t82S
	 v2nl1VY9l7sAA==
Message-ID: <sashiko-outbox-199303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] virtiofs: disable request timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miklos Szeredi" <mszeredi@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105150943.86650-3-mszeredi@redhat.com>
References: <20261105150943.86650-1-mszeredi@redhat.com>
 <20261105150943.86650-3-mszeredi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:13:54 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The request timeout is implemented by aborting the connection:
> fuse_check_timeout() calls fuse_chan_abort(), which splices
> fpq->processing onto a local list and ends those requests.  Ending a
> request wakes the waiting caller, which then drops the last reference and
> frees it.
>=20
> That is safe for /dev/fuse, where the request has already been copied out
> to userspace and nothing outside the kernel retains a pointer to it.  It
> is not safe for virtiofs.  virtio_fs_enqueue_req() passes the bare req as
> the virtqueue token, and the scatterlists point at req->in.h, req->out.h,
> req->argbuf and the request's folios; the device still owns all of that
> after the abort.  When the device eventually completes the request,
> virtio_fs_requests_done_work() gets the freed req back from
> virtqueue_get_buf() and passes it to virtio_fs_verify_response() and
> virtio_fs_request_complete(), which dereference req->args - the caller's
> [ ... ]
>=20
> Fixes: 0f6439f61a6e ("fuse: add kernel-enforced timeout option for reques=
ts")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-8171ebf0-ef01-4ccd-943e-8633a8d54=
239
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105150943.8665=
0-1-mszeredi@redhat.com?part=3D2

