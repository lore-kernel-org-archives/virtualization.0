Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491538;
	b=iab68ygn34tab0RNXLZ5rqYFwcRSeGa1R9uBO204BEuyKdMjNwCV+XfHnCn1A8gUD8NP
	 HGOvxoOHpulRawQfkPHsXekQRFQIwibAtWhbxDWm18cfeLIrJP8w3zGwvaoLRNt6KE+1W
	 VVDXfJ9GU5Yu50nIoqVxA64xYQWuD5wvA+1rsRf4m/KfdzIIHYYYnQ4lVC3H8JcNDdz+T
	 jtPWKyiRULa4iwF+Pkvh2uWZ7Wt05IpdiG4tV8ldrEXwMDo41v/gioRuEjJIOJ9uo7z0o
	 156GAdVUJuYhoKWa3ejNNXD7lbYT4ZzW8gpZqbyeJ00Plf5Nv7GPVQpPOb3BfMti+Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491538;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PuYizdzX37ALxPQ188e7H+mln9cGJJYWL+Hlpy95HSg=;
	b=KfoZLIKPc/iS3lPUf6jLfIUJpplGp9mX/wmoYyDD8uqk9iRDLNc1QE3MAN8qdiuJq6sl
	 5j7Gxt5EAy2Xc9zf1peof0V3LUwELrMbrQeaofgMCoJn3XBSkvJbXmaA/06kdMYLlVh/I
	 eURXEkRRpOxOuMYfpOVNFJ8IKIdmb4spM/XWSYcjdTX/wsxeOCI7Gg0n9tk2olkK5PQJ3
	 NjINuiMX2doHqCDR958wQ9lOoKQoD5no8Lw/1G0uL7BhcsKg+XYnHEvpXP4REDDyE/yCV
	 FZSU7srhtqTcYsvhN4D4KydnCs7jnKHY1i1CnlG3evTOleCXYn+Y179T4xyC3KdtfiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9IIi8X6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC1606A327
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9IIi8X6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED9F1F00A06;
	Thu, 12 Nov 2026 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491537;
	bh=PuYizdzX37ALxPQ188e7H+mln9cGJJYWL+Hlpy95HSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9IIi8X6ZbOO0SKsbmEnIxitXgJPZg1CNlVwr8eVSB9MKfH1l2jlIxuIJWZ+4Gez8
	 9W4WbHxAT3OGWbcmvm7Tq47nN4+SWFQrwD4a4il2uFNqBWZRv0/clnZnjMxa2naogj
	 6hK+B0+NqLnv/vgYmlv/kuGbcHOIzCBzasM+GJ8C3ZBicngS/06dyCX3FlFVXLif0B
	 IuUT0TABBNlIGRL8onuLxLCHfx6gk5w422R6lD6hH47gCQN1ewpomLshFi3FhXev5I
	 c8ergSb+wbV1hIlOCd7vTH8StRd+YAUZoScHkh4cUYzZMyvX4xwQE4/t/piRwGUgKi
	 6t1QRKyH2iaeA==
Message-ID: <sashiko-outbox-211234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] virtio_net: mask callbacks before releasing
 NAPI ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Congjie Zhou" <zcjie0802@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_3206E4502773D7AC6F720CF4046674E5A809@qq.com>
References: <tencent_AA4F39DA7ADE330C721C03AAA832B92DD608@qq.com>
 <tencent_3206E4502773D7AC6F720CF4046674E5A809@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:52:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] virtio_net: missing Fixes trailer for virtqueue_napi_complete()
  race fix
--

commit c4014f837fc88f44df9c4728b3bea8a252b5c2fb
Author: Congjie Zhou <zcjie0802@qq.com>

> virtio_net: mask callbacks before releasing NAPI ownership
>
> virtqueue_napi_complete() prepares callbacks before calling
> napi_complete_done(), then disables them if completion returns false.
> On the hard IRQ deferral path, completion can release NAPI ownership
> and arm the watchdog before returning false.
>
> A successor poll can rearm callbacks and complete before the old caller
> executes virtqueue_disable_cb(). The stale mask then disables
> notifications again. If the one-shot watchdog has already run, no NAPI
> owner or timer remains to consume later used entries, causing a
> persistent RX stall.
>
> Use napi_complete_done_with_irq_mask() to disable callbacks before
> completion can hand NAPI to a successor, and remove the stale mask after
> a false return. Keep virtqueue_enable_cb_prepare() before completion:
> moving it after ownership release would reintroduce the RX virtqueue
> race fixed by commit cbdadbbf0c79 ("virtio_net: fix race in RX VQ
> processing").
>
> Signed-off-by: Congjie Zhou <zcjie0802@qq.com>

[Severity: Low]
This fixes a persistent RX stall race in virtqueue_napi_complete().
Should it include a Fixes tag for the post-completion virtqueue_disable_cb()
call?

  Fixes: fdaa767aefc1 ("virtio_net: Disable interrupts if napi_complete_don=
e rescheduled napi")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_74EA7A2E8BF=
5758E9C5EF18C9B1CED401D06@qq.com?part=3D2
