Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822126;
	b=WsMMvWrE/lP7EXQiTUgOZRcKTMRXvNJTp7OEfiRp3DJyl/ByQpGzrQ9gU+yWIsIu9Eyf
	 gtKGfnR+bb1SsOPXrmNeteqhDQrUaI+v61fXBRoN0LYVMwE6hjPb+5ugVbC4lPBziPjZv
	 Y4gIFPGRwUmH4wUm2adSv6WWpmdddWy9/pl8jQwyD8hAS1Id71os2//GFoGvek7YjZ1+K
	 aM7xK+QKGDusISukrMrOvmiS2IL+tQwofclE96dFMZF7qqF0IEUF4ZONWaFjq0VIUFvBz
	 jwloPHPivdFovQC1lDQDCj0YzgA+VJMMLWkuq90C1mgATV3p74t0OZmjp/BzhRT+a9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gaPGQdx6+lKEgEfnae9vJxdxobJJtoQIV+PfsJY1GNE=;
	b=dXVE2k7cOA3YbnZmABAL0xDq85Y/3Zw7QQX+OtEemAJwvNOcSkLbMsXRfNY+zaJ3UGtG
	 EijRSSg3XpaaGKjKLSMhS+EjeK3+k3UWIM+hUM9N/ijh8dgEkH4xso+FoRfM26srfQQke
	 B0CphpNWGnGkGRBPObXN2pmcMs8wCH3W/jGWR6JX1W24gUUkUL+SCNIFz1BjoWyGXhqur
	 2/g4mszi2pg2OucLNjOvBMBVrbphpvnk8sfhH6m/dZOWW/ZzJSxZAf4Iexc48lq5HtP2U
	 7O3xPcs6fqGONWvHKlg53989ioJvtPIsJhmEBs8lFalzlePiU1lvWc1ljWzwQEJFXwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1qDy5DP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DE606A323
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1qDy5DP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D681F000C7;
	Mon, 16 Nov 2026 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822125;
	bh=gaPGQdx6+lKEgEfnae9vJxdxobJJtoQIV+PfsJY1GNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g1qDy5DP4xlmfgbwO+S8HLLcD/Vayso5bltE++yv9Dgg/h2mPRLOsLIf5nFQC8lz6
	 0mZTqWetTJNByIFo03FpnAm/ibrH2VVKC5iEqHt4APrVP9gTU0mFTYRAzoD2bfr1Et
	 jvw7PkvkhKsakP1yRP15gahBoLPtGaa/Q6q8Z7nt0r1nKjmhvL3OhUHYWOwkHDHuIN
	 WDwLzmB4oA/0bNNUoaSKUua69QMsPACn6/F1Qh5MR1Dx1t/qO+Vj0gZT4JIZLPdSAN
	 vfUs2sJcK85FGCARIKOKTXfWkvWur7eqWYbRiVpALU2OjhHGSB5E/F4WsVhHve4Dqe
	 iY7imN6JykvYQ==
Message-ID: <sashiko-outbox-216626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/4] virtio_net: reject stats replies for queues
 outside the request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116092445.3391334-2-lian@is.s.u-tokyo.ac.jp>
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
 <20261116092445.3391334-2-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:42:04 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> __virtnet_get_hw_stats() passes the vq_index of each record in the
> device's statistics reply to virtnet_fill_stats() without checking it.
>=20
> For ethtool -S, virtnet_fill_stats() uses vq_index as an offset into the
> output array, which the ethtool core sized for curr_queue_pairs. A
> record with the vq_index of a higher queue can make the driver write
> past the end of the array.
>=20
> For the per-queue netlink stats, the queue type also comes from
> vq_index. A receive record in reply to a request for a transmit queue
> makes the driver fill the struct netdev_queue_stats_tx on the stack as
> if it were a struct netdev_queue_stats_rx. If the device offers
> VIRTIO_NET_STATS_TYPE_RX_SPEED, this writes one counter to the eight
> bytes after the tx struct.
>=20
> [ ... ]
>=20
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Fixes: d888f04c09bb ("virtio-net: support queue stat")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116092445.3391=
334-1-lian@is.s.u-tokyo.ac.jp?part=3D1

