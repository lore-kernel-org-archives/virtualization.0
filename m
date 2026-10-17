Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEF9358367
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792237715; cv=none; b=BjKzp4FdR+o/Ro/yqckJ44tfs6GXRV25eeH8eMDuvNh626NZqBgFo40Pg1EoUwe/frNErkcngznwOexAMmmRuPpWePpLXIudUNgFwKCM9Fjq/dzzs5uoIdryN93b4ntfefnDbxpb1Ix7IUlHEtjnrCVQB9xAkDggHqRAszS23oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792237715; c=relaxed/simple;
	bh=mQWFKk6XjSg4wHFstCF1Dzqaap4wj4OKCwc+m3dyBbo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rWHwl4XuPqTbMIQhFd6JwdA7Xrwq7XU5ahuUaG+IJCikPHlTu2JG8AkL3DUShpArMkqG2y7zuhFHiZ/hSBeq/gIzz5p+p4Ub1iy1oa5KrIPGJa9N+M16cBS8o9xKUAZbceOIp3ZzugFudxSsZG55d/yTIr0hjMFwTMzAWAoQseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGGEDAA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGGEDAA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BD21F000C4;
	Sat, 17 Oct 2026 11:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792237714;
	bh=QjY3VzsS2EWmE5zKTZ4BzLf2vz7x/xXzXqzf+c+cPEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGGEDAA29A1Ksr24iGVNOFNMJRjxdw7N8JCk5G1cV3BcsStUmCODhd4RHy7ho8lP2
	 DYV7iQBiX4ecjLz3gL43h2uJlF+UqxVHIwUFWJo+QfP9iCUdA85VcYES3trTjui+27
	 HsaUkEAqgQmKUdFbwAYOsCAmbLVrxuAl0xWUbN21ElRKABDEf2ZdbdKgW8a2TioS4K
	 PW9PgmQ95ngeVlpmDXoW2jKLbRRblKN/tamGonDWGQjmEG7i9zpKJ5cyQr3LDXRyPt
	 SYtQTSAaT7L+e+joipyeW9bh4xKJg9MHeCkzQTR6AJbFGfMs6+CUdgzd85WXWkY2CA
	 w5nm6iD9FMhrQ==
Message-ID: <sashiko-outbox-175498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] virtio_net: atomically disable rx mode work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261017114237.2786302-2-bestswngs@gmail.com>
References: <20261017114237.2786302-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 11:48:33 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtio-net uses a boolean to gate rx_mode_work during device teardown.
> The flag is changed under RTNL, but ndo_set_rx_mode checks it under the
> address-list lock. A callback can therefore pass the check and enqueue wo=
rk
> after teardown has flushed it. The work is also enabled before late
> probe operations that can fail, allowing probe unwind to free the netdev
> with work still queued.
>=20
> KASAN reports the worker using a virtqueue that probe unwind already free=
d:
>=20
>   BUG: KASAN: slab-use-after-free in virtqueue_add_split
>   Workqueue: events virtnet_rx_mode_work
>   Call Trace:
>    virtqueue_add_split (drivers/virtio/virtio_ring.c:706)
>    virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2839)
>    virtnet_send_command_reply (drivers/net/virtio_net.c:3565)
> [ ... ]
> Fixes: b9f7425239a0 ("virtio-net: convert rx mode setting to use workqueu=
e")
> Cc: stable@vger.kernel.org
> Reported-by: <co+d17c2bc750a9cbbb@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017114237.2786=
302-2-bestswngs@gmail.com?part=3D1

