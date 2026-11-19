Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102806;
	b=1UGha44q+0Xi8oYjzj8TBDRPp9I66/BHEXc3l5nfsvYbXU0LxqHFR2ukApBZTxb+NAQk
	 PjurtxUR+2sfachjSAH6FX2KIG7QWcQ+h/C7F0HBAITTe5v4dI2cdxUGMuA9CL7t9vVLf
	 GUm1pfzXllhevvwYP/fGpx7X9EVsYGCtf9zPN4PNAJi1qRo/UJawaDRxJZoAJxAnOjiFf
	 ZsKR0JdGHGCpo+9HyCOfBZr8Un+dkUZ+ROUcobWX30TyhGGCgNYTMFPrmpXocQxtbdNvM
	 0qI56hQM4XcdC0C3kZAoo8zyXxP9Lq5AhO9VMV6p4n3+LzAv42cm4jB8FrHXSGcIEQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102806;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fO7fMyh1dOxCTkYE5uZ4LIF4CL/6xAPcfVZ+TlVmgY0=;
	b=4gwVDOljiCGV47STXrHsew30DMiC3bucBacUvUxPgFi/nN334OgMOuUU1UzrDfmZtRRz
	 ZfRccKIQdiQ8DwRJJnaI1xOkAyOIkRtznR3LVjChTVmeAOlvxRGGCuDGm2FXeZHe7sKq3
	 kXUhq8Rj8sbrFC4ZJYQt6vuCJS9h3Krpmx0Km+mNbJ62kPkO2fQ1q6btvHBvfZqequN7S
	 JKM8ABs5d0E+VaqM9WQyxY306SvVuI3FNwVx4ImrlSe6AqMzyxg8dVELTQiy3gFb95Ryg
	 utLJXjk97Zbd1DbTWXA7TLR9AUA0hl9EdkHWuljuj8MVRcQjp1QSCbZVkARnXTN/66A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+HkUFR2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F6606A664
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+HkUFR2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CF71F000C5;
	Thu, 19 Nov 2026 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102806;
	bh=fO7fMyh1dOxCTkYE5uZ4LIF4CL/6xAPcfVZ+TlVmgY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+HkUFR2bFdtd06BeKQ1zKalKqNqnhh92ILLpX8segalElWaC2ujhsf4V79y6M95f
	 W/M43oj5SUBlJQcz7jAvuOouchgkzbEL7yImlDYj6+7UAFK7LzsjKpj1mEtpI51+Mj
	 ixmOqR/njEJvB5Rek3O0F03d5CXGARxFhMVHjF7Tk9FX3j5UEUFjfhph6oqMNRIRoD
	 VtsfuAAkRNj55w4OJpk9Y6F8qcMbWGJvG76OV+rOWNFtXuzz75duUkf7w1EQvsVayd
	 apaeHReHmmMZ1ChSdebdrzqlH8oIDrPd5Ha8081yMOqnjlNSVdQiscOTSuh5ZhMqzi
	 bja5GHs4seZBw==
Message-ID: <sashiko-outbox-223399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7] tun: bound the NAPI receive queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Quartulli" <antonio@mandelbit.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261119153056.353156-1-antonio@mandelbit.com>
References: <20261119153056.353156-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 15:40:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
> an unbounded list. When the poll runs asynchronously (threaded NAPI or
> ksoftirqd) and is slower than the writer, the queue grows until the
> system runs out of memory. An unprivileged user can do this from its own
> user and network namespaces, and the queued skbs are not charged to its
> memcg: in a test VM, a uid 1000 process limited to 128 MB caused a
> global OOM in ~6 seconds. The socket send buffer does not help: tun sets
> it to INT_MAX by default, the build_skb() path is only used while it is
> INT_MAX, and the XDP batch path never checks it.
>=20
> Drop packets once more than netdev_max_backlog of them are queued, like
> enqueue_to_backlog() does, and count them as rx_dropped; the write still
> reports success, as for a full backlog. The check sits where packets are
> queued for NAPI, in tun_get_user() and in tun_xdp_one() for the batches
> vhost-net passes, so packets consumed by XDP or delivered through
> [ ... ]
> multiply it. This bounds the queue as enqueue_to_backlog() bounds the
> per-CPU backlog; charging the skbs to the writer is left to a follow-up.
>=20
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119153056.3531=
56-1-antonio@mandelbit.com?part=3D1

