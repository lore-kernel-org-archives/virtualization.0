Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211274;
	b=lSzf/rhDwfgsEdHNUm6Mqz8y2Vx/86CaIN6rN4UG3mjNx1/wx1hOEhN8nDJvpbzeOxrH
	 /XHIKTwhyi09RInl9wl7XlGglZUeL9E5iVcf9VSjjlD3unqa96JxFkXCqeEREofGLXOkr
	 kcYYbD9ruFiZJ/rv6hjpTKjdwbJrCl2pnmB5fsPSPRjvf1qKoZPvCue4oYHrHWtvH2r5m
	 pU3f10xpAOHETqzhWwX003qHIyElch5lCiBpm6J+vwu4rzeO16cftGAnzUJhHIu9POBcG
	 OL6cLAxjGMHVLFd2a9Ipu+rpwdVcjmVVlmBeIEBqwz6Oes27BqS13w3NNPrfkriNl2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oklvuDuY5XSjv7J+sMtdEEJfSTWSTJrcBMjBWQ0Ukcw=;
	b=zUudLxEFP33qZEJOic3OEXUTA9n1JH1dBYGtxzSGju45Drj4vFOTtD6giC4eXeWOz43W
	 4rT5/Wvyb4UsWecv3Z8JQAYz3cXk/oJDlI3HwWzJHjSObYWXsbApZG3N7F99cBV7gIo4L
	 IiW4w3zdMQ98jH5xSFABb23JdfU+KzWkXU7ce0RCldebiy6dmkulFckp09maoci9ui1GU
	 CiRIiRpk3HoHKExjSeZvH0j0Hll2X2FSdcdC8zqjFnx7LmtvlSOGOMqNYCZUAvymSvHFP
	 9gizkHyod+iqaZ+kqaGQkxw5QmZwrLWRUZl09xuX/xGS09qg5azzHJ7kRNrYDQTD1ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELWYtdn1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A69606BF7E
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ELWYtdn1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2B01F01828;
	Wed, 28 Oct 2026 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211274;
	bh=oklvuDuY5XSjv7J+sMtdEEJfSTWSTJrcBMjBWQ0Ukcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ELWYtdn1cJRPU0Eruqs4osOsZXHGGQ1ONW1y3wdr8e1xIWg7WbeV16WEj4L5aBVh2
	 rgH2fd4fn29kYoiYV2dD17n5toAiGr7NLYvRDY60BfC7AAepAkYtpJOp1Fxh8MkThX
	 ExwPt7RwZF4Y/Z9hzX7nzel3YceCVsdjvkC+ETTmOZbUl8tK7WRCf0PJlEzrDPTTDM
	 d2TRhJtmqkBLkrn0s6tuDkEP92jnokgOJpBd6Sis9qt+0Lc2bDdavilYWwvHh0d3ss
	 y0Q/ag8caVCvRFlTFmqX8wDdOFSfatNSEJRVWBsEV8AkrQxa2BvYl7YlxIrV3mp77h
	 nNn2hQXOoe2RA==
Message-ID: <sashiko-outbox-188270@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/2] vsock/bpf: release sock lock while waiting
 for data in recvmsg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Mohm" <jrmmhm.kernel@eldare.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-1-bc0752b2d3db@eldare.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:14:32 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>=20
> vsock_bpf_recvmsg() takes lock_sock(sk) and holds it across the receive
> loop, including vsock_msg_wait_data(), which sleeps in wait_woken()
> without dropping the lock. When data arrives, the transport's delivery
> context (the vsock-loopback worker, or the virtio/vhost rx path) calls
> virtio_transport_recv_pkt() -> lock_sock() on the same socket and blocks.
> That context is the only one that would queue the skb and wake the
> reader, so neither side makes progress: a blocking recv() hangs until a
> signal arrives or SO_RCVTIMEO expires, and meanwhile the shared delivery
> worker is stalled, so all vsock rx on that transport stops. The
> hung-task watchdog reports the worker:
>=20
>   INFO: task kworker/1:3:107 blocked for more than 5 seconds.
>   task:kworker/1:3 state:D Workqueue: vsock-loopback vsock_loopback_work
> [ ... ]
> cases of sockmap_redir).
>=20
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-kbh3-1-022=
-fix-v2-v3-0-bc0752b2d3db@eldare.de?part=3D1

