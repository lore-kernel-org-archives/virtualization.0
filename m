Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461317;
	b=McicyiqI/VrwUqPoCWfIlfHR/tgCT91CHqxeVnjQves3T0OqQApMM8vhCJgf/ZtdnDwD
	 k16fTlTuYWrwKZSrmopB28BRMLBwKQERwujAk5QzFCFnxwQkmjGdqcbfCWfaaZydtDQlx
	 /OdhwjU5ZN3GdVTXlcp3Xb8JBd/YsrJ6AdWw1dShCamajz1jzGs16av7C8tYjcecAHZPF
	 jh/yTbV1UN2NXvMy0uDFX+P01P8i/dWvQ+9TDF7x7bYG5Oy9EsBKZ1/leVHn/fYTg8xzl
	 6/Jezx4alQXc0s7P6pVlgM8YOms51hXJYuF1QC267lLBOiy13Cch0nCEKm+YH6B5RdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8loT6Dg5Kmd2x+2l0wVPfW93SLWJsFkk1JQbKJMxTJ0=;
	b=cVrjH6E/xbJtyF91EXfR0Ome/eak7LYDl/aAcITMMYapuklqPDNzwVbrNznZp6OP8sPD
	 mRma6Uyxt6+NHDEDHcA9ogFX4Of76kF+hfcr4/t74+dfqKlbBl7Rs9Em2O2b8p3j/WbYw
	 wbldy/p12AhzQpYEi/nc4oyyXbxTJx37JqhanVQfyyg7DBnOozB6sbKPZ2iW0OStYg5dv
	 QIM0jS8MKZmeiW8asz22Ti/0Gbn2CY66RklnHBVXjHFQsF25+rfW0nNtBbMAGcL+JXOBD
	 mju0zN9jQS3DNqSMC0b1Yfof8nhEChV/3dSOe3C4h+vWx+umh9ABIL5sLDJih2VRLbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToCmbgHQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70601606A8B0
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToCmbgHQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19941F00A05;
	Thu, 12 Nov 2026 05:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461317;
	bh=8loT6Dg5Kmd2x+2l0wVPfW93SLWJsFkk1JQbKJMxTJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToCmbgHQZMC3SEfFDwywkiYy3tYJOGWw1DbhNc+ddB9DE5vTI4Pq4phG0UnvKs33b
	 L+iaKPO0OZmDV8Bw72FJLc0sXOLn5AfIiGYO2Q7JliBRAyLG90f56uUbj6F9k2Ne9v
	 uuKJ/UR6ciVxA1NWqAoFgUEFH3NQAa1gs8yiAiuWUiKyMZnBM4E5o8ZiriBQHg2Mos
	 MsQ2RgOpgE6XPSKQ/8k2Sz80GC87nTRjUyxiSHWAFCiiBi3Dl2Q8TjDCtV/CH1q8IU
	 C5xQpn6Krt3Ew71G3kV2ZmOJaWcK5guHVWZjRAli5wQNb+6dGuUHvmFnxCCraqJhdl
	 UPmnwJC/8Kmkw==
Message-ID: <sashiko-outbox-210448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] fuse: Don't use request timeouts on virtiofs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112052208.1248312-2-oss.patchbox@gmail.com>
References: <20261112052208.1248312-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:28:36 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtiofs cannot abort a request once it has been added to a virtqueue,
> because the device owns its buffers until it returns them on the used
> ring. This is why virtiofs sets no_control and no_force_umount; see
> commit 15c8e72e88e0 ("fuse: allow skipping control interface and
> forced unmount"), which says that "virtio-fs does not support aborting
> requests which are being processed".
>=20
> The request timeout added by commit 0f6439f61a6e ("fuse: add
> kernel-enforced timeout option for requests") aborts them anyway. When
> a request takes longer than the timeout, fuse_check_timeout() calls
> fuse_chan_abort(), which moves the requests on each virtqueue's
> fpq->processing list to its end list and ends them, so they are freed.
> The device can then still write the reply into the freed request and
> its pages, and virtio_fs_requests_done_work() later gets the freed
> request back from virtqueue_get_buf().
>=20
> The timeout is armed when the server sets FUSE_REQUEST_TIMEOUT in its
> INIT reply, or when the fs.fuse.default_request_timeout or
> fs.fuse.max_request_timeout sysctl is set, for example for other FUSE
> mounts on the same system. A slow host is then enough to hit it.
>=20
> Don't arm the request timeout, and don't offer FUSE_REQUEST_TIMEOUT, on
> connections that set no_force_umount.
>=20
> Fixes: 0f6439f61a6e ("fuse: add kernel-enforced timeout option for reques=
ts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112052208.1248=
312-2-oss.patchbox@gmail.com?part=3D1

