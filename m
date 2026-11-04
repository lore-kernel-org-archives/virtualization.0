Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802177;
	b=LaNXJcBeSyMRfU4UxhGhDDLTFbmC3e1m2VgsanL5bBNtOdn3znaQi/uZpj6kkwflFkf+
	 bKOKrzS04/s0RyJadCEIwT4phOE510zJBlD7/cw6bBm0LOXWNaOFPGtRWxB2BevknvTvX
	 gi1JZ6SCKbCbI62m7lE4rG9k+YperoC3j7H3RKCj/hU+hiTMIZ5Qts8Ky0H3U7Gkgb6/n
	 gWWymSsEf/0EnLq/BWiQmJ/lHA+I4hOaaQKKd4wMfAYLLrzR4uShxwNbAI2yw0y+AGy0M
	 p612CXH+w8a8R9GU7zneL6fBVCVwW+MWTjhxfODo9L4CmQBk3rs5gxfJOwGaPPP1mxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802177;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0B/o3vZ/Yt00g28iZ7Ekq6FrVnrJyW0JGpIa2XHtv+0=;
	b=0oFaxOzhL3l9en5zkq8AIdEWMJn66nZJOWJb0tDkM0ZkdwztWSBxfPvA5jxqGZciae7d
	 z083riypilfsccFISFM8Ad0EwYKbrpEXhzQuTDZqAMjW4aiaEc3k9boBDttPibSWFlJAw
	 zWnvtvcBhbBKK9bpMAKVYoYfJLRiIYJDkT5F59B8JHEdGYC1cVrB++8Ckl9Gg976EsDm7
	 LKje+FLlTxZbl+HsCqJz9nqjfL2P5c7lb23Kmpkx/2XAGmvQE43JvMktQIeP/HLchtGAp
	 dZPEEcdr3Puz3UBT0h5wetczNormy7Jhf84K2raZ+wbQLEYN0Ocex/hEZa18M8tJJ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7pyodIX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA1606A31B
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7pyodIX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C065D1F000C1;
	Wed,  4 Nov 2026 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802177;
	bh=0B/o3vZ/Yt00g28iZ7Ekq6FrVnrJyW0JGpIa2XHtv+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V7pyodIX4Qsb2U9eehiZdS+/YWuuMnrcW/l6MREoDt5BRZTwbLXLuVXnfT3FaIQq7
	 nyV2JsArxZDRGp6NanSnNKd/tMh5Wc5JH7BlsxrAWcWF78njz5j/sUeqJEA8igJ3WU
	 iS61n7HqZG++rEwoYFVQ9O9EuP07++N2SiS48VEhWNrq6OOKk8JBBzEVAUE2XmHXGy
	 OuHJh6njciFdUq+3t93wdjWPyfPXMaLNtubcPXzag6jVW7q30GzYV6KXIhwQCRlK0b
	 +FvZuxS3E+Urayhw0uyfaOPZ8EVkgwRgrMoNYX/JGTk0yzRCd2DGhZ0QRbzerExLRP
	 k1PfD7GIwKWkA==
Message-ID: <sashiko-outbox-197425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/2] tun: bound the NAPI receive queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Quartulli" <antonio@mandelbit.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103142232.1869185-2-antonio@mandelbit.com>
References: <20261103142232.1869185-1-antonio@mandelbit.com>
 <20261103142232.1869185-2-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:22:56 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
> an unbounded list. When the poll runs asynchronously (threaded NAPI)
> and is slower than the writer, the queue grows until the system runs
> out of memory. An unprivileged user can do this from its own user and
> network namespaces, and the queued skbs are not charged to its memcg:
> in a test VM, a uid 1000 process limited to 128 MB caused a global OOM
> in ~6 seconds. The socket send buffer cannot bound this: tun sets it to
> INT_MAX, and the build_skb() and XDP batch paths do not check it.
>=20
> Drop packets once more than netdev_max_backlog of them are queued, like
> enqueue_to_backlog() does, and count them as rx_dropped: before
> allocating and copying them where possible, and again under the queue
> lock before queueing. This covers write(), sendmsg() and the batches of
> XDP buffers vhost-net passes to tun_sendmsg(), which share the queue.
> Zerocopy buffers of packets dropped early are completed.
> [ ... ]
> by the poll), and the queued skbs are still not charged to the writer's
> memcg.
>=20
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103142232.1869=
185-1-antonio@mandelbit.com?part=3D1

