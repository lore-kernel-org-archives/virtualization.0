Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224374;
	b=CJ6xlE9+XAzgdhVMnTgiBT2Ve27U45LlkeVGutCnFvBjCKbUCtnvZ5yNA276dcUVZ92O
	 rV/OVgVIWO1ivr+20mMt6Bpn1SD9JK02pxnKECGiL0Nagq+maBPhx+oeFXPIJrFCNhTZ9
	 qU3UgproliVkbL115qg4Eg2XH/3GJEFKmICXqECKMyHP992S+n0GVAjcMfEqqsTi3uwXg
	 fGDOpFM57Z9Izat/o20i/HeohyQG+w0gWRHfRt41oAtQGafP7UOuH+aCQZMfoiAkC4YBl
	 b2Hykj98S89KvgVk2ixmeCAomzb7twMI8ALLnuUVaxhgT6pWDa+4GV6+Tie1CKd0UsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DVBNKwHdM/Rx8lRDNQALykjD36cwvKTMgfUAjOu2VYk=;
	b=il6P2Yw+TZYB6Hb4kbJYgL8Mbvh2aFzXdGeYsnKO/OS4YRQ7PUib6r0cvuKzjvW2mpdn
	 tAbVZzPiqbeiB+PW1BdfaRHV/uKqHUc2U91ViCaaneMibVmn/vYxR2kwTBTCyx0paEh7J
	 NAy2bPOFh4Pb4OJzDrc+qI6coXVC+N4LXjid/yTyv0viVxuqSHT+0VMUlGeNHxFqsLI+9
	 atwYlbx2YFftX8GOoR6vKhspkDrGAHIpwmKMh6mXO4hV4hnBnaAQ42Q1AWM6/NbskNAOt
	 SX8WdLyUxBnza91ZgLs1ijib5A6vr1t0WSQonzRlZY142alXY8U5lJGbMBib7Rfb+iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b25T+qax;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F52606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b25T+qax
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C481F008A1;
	Mon,  9 Nov 2026 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224373;
	bh=DVBNKwHdM/Rx8lRDNQALykjD36cwvKTMgfUAjOu2VYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b25T+qaxy9hMryEntoWnFHSI/Ks4oknLYj5ROVrfbwpHPoI0broHDiIJjblf81l3C
	 66R3q2xwL0nrYMd+fHKqumy1B3FIO74QnlCqEmJ4WYNfn7Xdanmk0XrUCoVJQcV1Jb
	 pPh3djtPM/Q+/xUmlUuzU5nxv+k6xTDRrhTnpqbVcDIeRHNs/JV7i8U/ljsIhvtayh
	 m+HT570VtfNEGa5LN98Hj2wUx8MTcpkdwK5L6hacVj0zLikEaZdcK3RRDVRscZ52DZ
	 YTIU4quqBNMQEpoi/4+HNHHyDdL+Um6UvNzlVjaIVv6pNAhGASNU1IoIi/d66EYUH1
	 iCO0FQkP6uLew==
Message-ID: <sashiko-outbox-204884@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/3] virtio_net: Disable AF_XDP pools on queues
 above curr_queue_pairs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haishuang Yan" <yanhaishuang@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108193845.73621-3-yanhaishuang@cmss.chinamobile.com>
References: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com>
 <20261108193845.73621-3-yanhaishuang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:39:32 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> With an XDP program attached, virtnet_xdp_set() adds nr_cpu_ids queue
> pairs for XDP_TX and raises curr_queue_pairs and real_num_rx_queues to
> match. virtnet_xsk_pool_enable() accepts any queue below
> curr_queue_pairs, so an AF_XDP zero-copy socket can be bound to one of
> them.
>=20
> When the program is removed, the queue count goes down again while the
> pool stays bound to the driver. When the socket is closed afterwards,
> virtnet_xsk_pool_disable() rejects the queue with -EINVAL, and the core
> frees the pool anyway:
>=20
>   WARNING: net/xdp/xsk_buff_pool.c:160 at xp_disable_drv_zc+0x1ee/0x260
>   BUG: KASAN: slab-use-after-free in xp_alloc_batch+0x930/0xb40
>   Read of size 8 at addr ffff8880028eb400 by task ksoftirqd/0/14
>    xp_alloc_batch+0x930/0xb40
>    try_fill_recv+0xb27/0x26e0
>=20
> as rq->xsk_pool still points to it and the queue is refilled from it.
>=20
> Removing XDP must not fail, so let virtnet_xsk_pool_disable() accept
> any queue the driver has, below max_queue_pairs. The receive and send
> queues above curr_queue_pairs still exist, so they are unbound as usual.
>=20
> This was pointed out by the Sashiko review of v1 of this series, and
> reproduced in QEMU by binding a socket to an XDP queue, removing XDP
> and closing the socket.
>=20
> Fixes: 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108193845.7362=
1-1-yanhaishuang@cmss.chinamobile.com?part=3D2

