Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158741;
	b=DISBDutGKmkuACWKlsepHxoYbZfZgoLMxOMCDNNOU4SX3nK0aKGH3VtmvnIOoyIM8ZZZ
	 RaVvlnzRn5gnpTRU28K0VWtPr55LtUS8fiMB2Jqhn5dzJrE0aowRN64P5W21EYzxPbr2c
	 QR2sXeEuX/FXGMobK9xq9yWYbsenUY4rcJvEcubyl00GgPQNrRB+o+u0Nhy8uLweDUfWz
	 3gAnXPohxgvfaD2edMg8qYxckx6PbnyHlypxU5NJdq2GgEo4JqlSQ4xCJHDBNC2noaTYR
	 8OmCzvasTVeGlAEHl7PKc3fETcTKLDytwLo5FyiuVJRbna5TegJki/zK7tIE/2WXO1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158741;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p9gseYjW+nBLxluzpWcfiA3XKca79aCQREbkGRvW+HQ=;
	b=23b46r6evpqjpbdgWT81Egmac4V7H1mJBunWvz/JIngwa4/Z3+nXWICsDLZu6/eb8XQG
	 GO9vKr1fvxv2Sd6EaUzqFdL7qBamAq/vfgt0bA6urVlOgbsDbty1Dc6UOcEKDAInorSna
	 jQ+AAXaByfKJ0pulBdNWVIVDCGYHbC1lA1iG227gJiADfRaznjfsZBJqLZtO4+huR3cId
	 kUk2G9GONoir+ucBykHGjybQCKtr9Rnccrgba4C4s9GBv/nDc5ShLQGwbk6Awyy1I24eG
	 eviOqICVsQiavgLvlrdv3VQ9TgxXZNScY5sKOBS6ehfnSJTIpRox+ltM1Ue/XFqGUrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkYu1vjQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A911606A330
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkYu1vjQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C291F000C4;
	Fri, 20 Nov 2026 07:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795158741;
	bh=p9gseYjW+nBLxluzpWcfiA3XKca79aCQREbkGRvW+HQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NkYu1vjQwHccc/MHkc2+56TOsS4j61eeKGKH37jX0x+8a9OMhUNE0iFyDUN5eibPk
	 BENLCR2vR1ENpOtTuZCrD8gS5ykfVsAJlNr1ybTgqkz2VvVvjbocc6MXL7nHQet0UA
	 u2Hrpz1bEYmQQe6TW2c64gZaaNW1odaS8izOzrmlgEpfwy8x8Rdp4ZJ07J/nj7ZZzY
	 lInQz0T7SDC5vhHRGaql8gq6L+JLZzqQfElJ0WHKP4lIL7oIwElV7KJcLDimkTUVGa
	 Y+0bRph3QbuOHdaX6MXm4YTcCQMK1A29+jL3ET3YfumsJio3JDwYa2RiUJV9dNRTN3
	 jLNPbUt3x8tTw==
Message-ID: <sashiko-outbox-224601@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] can: virtio: fix RX/TX stall on interrupt before
 NAPI is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Seonghyeon Lim" <forfortuna@naver.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120-virtio-can-ready-v2-1-0defda2af8cb@naver.com>
References: <20261120-virtio-can-ready-v2-0-0defda2af8cb@naver.com>
 <20261120-virtio-can-ready-v2-1-0defda2af8cb@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:12:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Seonghyeon Lim <forfortuna@naver.com>
>=20
> virtio_can_open() sends the START command before it enables NAPI. Once
> the device has started, an RX or TX interrupt can arrive in between.
> The interrupt handler then disables the virtqueue callback and calls
> napi_schedule(), which does nothing because NAPI is still disabled.
> napi_enable() does not schedule a poll either, and only the poll
> function re-enables the callback, so the queue can stall until the
> device happens to send another interrupt.
>=20
> Schedule NAPI once after napi_enable(), as virtio-net does in
> virtnet_napi_do_enable(). This processes buffers that are already used
> and re-enables the callback.
>=20
> Fixes: 083082a4e6d8 ("can: virtio: Add virtio CAN driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seonghyeon Lim <forfortuna@naver.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-virtio-can=
-ready-v2-0-0defda2af8cb@naver.com?part=3D1

