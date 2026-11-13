Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605703;
	b=2tWO2AR6I1hgtDAGnW1+FoXOkjzoWTGwBJPZR4riMhdA0x8Ayqo/qbgxH+srnb02BEjT
	 p17sazzjbjkWz6Y6Idu4YSi4KNRjQhstEHI9dxEDH5oWoVVukj/yOvBWUXmq4hs6iwpnc
	 A87lE82PmiOMzLRZAUc4EyqzTgXh1XdJy/yMV9wv+kPBcz3vDgA+Ls3s4xt9S30CkiAUY
	 ygs4jv0P3c2LIZc39GOdDf5px9aeiAUh00UQyL1xqf+we89MVngGoUlTV8OZ6ePw5adp5
	 Z5poUB8hTdcgzP/9ofvGqCf4isQZliF2CA9mfWf52yigyB77Pp7sJFMQiXRLhuXt8Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605703;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=slyYU/z7Ot/GZPTqUZ8BvsJC8+//i+FaROZ+DC6PrfE=;
	b=3MYgiwwFo/Pe1pwnKbET5HdBg2hFUoHJgtTkEyLcyW5ZqnbOveNMb836xRUE4cVdPo3R
	 lQzrWAbpmu8w0UJtJa9ekYNMKzwrjqcP4KIfYxrCFETxhlT/Vwe09BNVOnq97fbYoDumb
	 E0P5b0dyjF+zQAWkOaDsXGEi69rvb9PeSzwsLHevnP79e+rwRhBUqutZaR9nXx1TfUDRM
	 EepwYZwJcuyIsctdT03gltA2++dVZWAM+uPGf5+Wz39Q23SaW2BeJDhUA56feLQCBHPAR
	 X9GoUweKhWuhiHAx31Hxzm6Ews/owqLhnpcjqlxnqJs68kU5cFcNtgIZlcm9rHMSj5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZmawMz0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87289606A32E
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZmawMz0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EA21F000C4;
	Fri, 13 Nov 2026 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605703;
	bh=slyYU/z7Ot/GZPTqUZ8BvsJC8+//i+FaROZ+DC6PrfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iZmawMz0hz/OwZGTV24Rmxjl4gXpodn0OQ3Gwa2kOo1SayasR6m/SGqoAYS/bD1ZF
	 zGosPWoRgu1pKQbxV3u+RXevEmf6aH5ub2qqB2TRGv4vAV7xshg5z7OF2DsGEiT16w
	 5EXNqUHYa9sIpX00GC+xYbVte9/nimixL3YZzxStnPmn+oRmfPZO9N50I5EbJP04pg
	 dCg4OtO+Y6IOMJfObn75vX34T5E/cYhlmFwyBTQ9AyfNXc/ZQn4k0mTG1FNTMzM4zm
	 K1JMOQlUpfgOzv7qD8ggLZVfnqr/uVQrdHk0eOxyarjlhQU6NZg+9fDOYVI9Kv2oc1
	 4evD73iBnXAoA==
Message-ID: <sashiko-outbox-213720@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 1/2] tun: bound the NAPI receive queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Quartulli" <antonio@mandelbit.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113212237.1742984-2-antonio@mandelbit.com>
References: <20261113212237.1742984-1-antonio@mandelbit.com>
 <20261113212237.1742984-2-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:35:02 +0000
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
> enqueue_to_backlog() does, and count them as rx_dropped, before
> allocating and copying them. This covers write(), sendmsg() and the
> batches of XDP buffers vhost-net passes to tun_sendmsg(), which share
> the queue. Zerocopy buffers of dropped packets are completed. The check
> is lockless, so concurrent writers can each still add one packet.
> [ ... ]
> poll, so the queue does not fill. With 64 KB writes the reproducer never
> reached the limit and memory use stayed flat.
>=20
> Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113212237.1742=
984-1-antonio@mandelbit.com?part=3D1

