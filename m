Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880023;
	b=EerX+/YHy/W18pLDvzwQyJooRG/ia/8d0iAjjNJQWzTr2pVOmlcD9mr0kXb1RRyxS1f/
	 6sznTHavlpQd9g3FZTaz9/fRLy9C7TOmjX0qGwlh8zsyOwLw6eAyurMUB8pXNrmpPf2Es
	 X/bCRNXB2jlcLqQhn1E2W0afSrbhVCowsiV6gO8/4mJgBaDv7Kg1vEMmkftsbbYmuDu4O
	 l4O2/IIxXYv+E1xmhQFjAt1O2LHSf3iKqVqNUe2CEFGCH6tMwLO1VKx7n2YwVLyoImMYW
	 984dPg5w9fO0TwrJbfgZlFMJsTJPI/iuJDDc5wEpqjcG6xn9jNEJ5ik5iatjkMTdolg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880023;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bL6CdsfI46r1dYMzF3kv7l5YexZqC4lQ1nhUpfpWnVI=;
	b=m9dvWQu/GRiTY+oDsau0HFGHSYXsSFo9KbkZPWOqm4rSkoUgGDEhedzqV50UeZid1hNR
	 gMl2O4kWRARR7AVDKHdXqj/X2EUc5obWmv8fDV0lQ5xAuPdChXMCkU9wTN6ofm9NGN2BT
	 P+L7YLXZ/CkPLY3HX+YWblm9liYHK3L6T07uAQ5pbXHEprm5/kT07IMHgyJx12KwWRzNK
	 a4ULqAFTqIcG6qbOBLXl7KuMMUbPUCzuQG+0rDTvtiWMVZY4i98UFEJd5azthne5SX/31
	 j0bOTLv6dIwEZeSyBdlu4mO/ifgkSQVBXs+JGlLJ96bOdr+gtto2bSicfhNs2ZMD+jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReMA2YGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D8606A330
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReMA2YGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939881F00919;
	Thu,  5 Nov 2026 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880022;
	bh=bL6CdsfI46r1dYMzF3kv7l5YexZqC4lQ1nhUpfpWnVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ReMA2YGDocDo3APxCbLIV6fb4uoB+9BNi/xoR4J80ltyMxd5PJ6XguSLBXLp5PEn0
	 Roa7h9gnE1LiALnoEnMHGMrxbElarl4+9JqFCScipNGMh6eTjbojJing4Yumr1Z1DL
	 waopC90hSppL7K07QCLA4A2u3i9Lep9yO7xqeL0KTZ5dQKrRY12pkREJQEdLlx/2lb
	 MgOgtGw0AI9uvfKVux8TCMqwKI5Q1JZTQN/swjaXl/RtyTe5RVFjjtz3Fb0JKEVrFu
	 nNw31qdbT6AL9tOJcPcyvqcqQxaxsMqSAAr0YJUxOWFvv+O61BCFS55PaZeqL9NVax
	 P0627/5ULTPPw==
Message-ID: <sashiko-outbox-198979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio_console: defer HVC polling out of the
 virtqueue callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105114450.971521-1-shunsheng1218@gmail.com>
References: <20261105114450.971521-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 12:00:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The input virtqueue callback calls hvc_poll() on port->cons.hvc
> without any synchronization against HVC adapter removal.  A port
> removed via a VIRTIO_CONSOLE_PORT_REMOVE control message runs
> unplug_port() -> hvc_remove(), which drops the adapter's last
> tty_port reference and frees it, while the callback may still be
> about to dereference the freed adapter:
>=20
>     BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave
>     BUG: KASAN: slab-use-after-free in __hvc_poll
>=20
> Both sides hold only the port kref; nothing protects
> struct hvc_struct between the callback's pointer read and its use.
>=20
> Do not touch the adapter from hard IRQ context at all.  Only wake
> the HVC worker with hvc_kick(): khvcd polls registered adapters
> [ ... ]
> This issue was investigated and the fix was developed with AI
> assistance (ZCode/GLM-4).
>=20
> Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off da=
ta from host to readers")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105114450.9715=
21-1-shunsheng1218@gmail.com?part=3D1

