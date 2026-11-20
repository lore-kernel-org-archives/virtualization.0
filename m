Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146181;
	b=PdCX7fEVnxnv8lmwElNLanc9Ywa3aGcQSx4dnKNW5dD2zBEXYPOsmbbszyvY9/OX0dW3
	 bC5LS0dMKk0SYrBYS4KhqHoazbsQGJa8tpiMggwzmsH8ajCfhKW6Xt3hkOV4UmqX7whkL
	 yqhzXjAYOJvTYf0rOI6gkNhfxxuf2OH2d8my2Z4/cdtsS7/9QszFwpypfQoyct1zs73u8
	 nU0KyMlzeJfNPQQh3alsXdr4s+yGeyJqkCJC37JK+cRjEhPwk5yNPUrs4u8Bss4PUpli2
	 XgTG2CIf2B+B3G4IZSZD8fxd1iT27oWFjGfj2iGVCEdR1PL1Bt/rCRjvQVI3ADDJfjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146181;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LBESgjyvA3wV+AifO5PnY4bCkT4uaWEYp3X11ySYhbg=;
	b=sP6/sCOOSLvMBEbqkTNzBWmvoVtaElpFX7IarBM2Db18H+Y6YYgOGQgx4aPNOmNLXC8N
	 VSz39PD671YvKFneicaV/oKuHDStpOZqfKThqOZt18EjZJqjEdIYkybM8EQl//2CdEnZl
	 7/OwNMMEfe6GbITNqka/u5vmdfI1G6m5pAgn/4sHM/a81zSzkl2Mvy8sGVO508VxGPG1c
	 VRULbIpw0Wz1H6fPBGSOoRiYlCtmIeNhrAXA6l4jB1kXviCtQLxy8l581M6p5exOrbV06
	 HKdmJwTZlms34n/PlPS+yJYhZxjEnB1IPUjD9B4Hd05VzeWXIiVcJmBJI3cUpZL9v0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMLnv9js;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D2606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMLnv9js
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B521F000C4;
	Fri, 20 Nov 2026 03:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795146181;
	bh=LBESgjyvA3wV+AifO5PnY4bCkT4uaWEYp3X11ySYhbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DMLnv9jsLThXiKLEpC24wcrjSqukoDHK0EgbTSRnU1SNZ2xpi/+i2dH38hENU4rFX
	 lcruxPskF/h/Gc6VeyM1aLVrPxLetuAF22AHfizjXEWNGW2nrrDnk0ewkCR5JZ/yPt
	 wV6CN841zTTGcxrmnNahV86fpRKiey1Ff6/UpJ1RA3/GJZN2aS09Ya0fAgth+NG4sp
	 eciKstHyrag7AZTXrEYTxl/JaVxs8LFEDCslGQi75a9B8SsSJ50MX1gD6X324m+ejb
	 rE6eQbEkaTUNNu6ccgshCpQqb2rP/DocAtylMPAXemoTQM0MlDpOy1vgUxWHN54zwZ
	 UMwYArXWUTDpg==
Message-ID: <sashiko-outbox-224421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] vhost/net: Fix receive queue test in busy poll
Reply-To: sashiko-reviews@lists.linux.dev
To: raoxu <raoxu@uniontech.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
References: <1B3A1B72438119BC+20261120033824.681219-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 03:43:00 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Xu Rao <raoxu@uniontech.com>
>=20
> sock_has_rx_data() returns a positive value when receive data is
> available. For sockets without a peek_len() callback, however, its
> fallback returns skb_queue_empty(), which has the opposite meaning.
>=20
> An AF_PACKET SOCK_RAW socket is accepted by get_raw_socket() as a
> vhost-net backend, and its socket operations do not provide peek_len().
> With busy polling enabled for this backend, an empty receive queue is
> treated as ready and a nonempty queue as not ready. This can make
> vhost_net_busy_poll() stop polling prematurely or fail to stop for
> queued receive data, and invert its receive-side scheduling decision.
> TUN and TAP backends provide peek_len() and are unaffected.
>=20
> Negate skb_queue_empty() so the fallback matches the callback and the
> [ ... ]
> No end-to-end vhost tests or kernel selftests were run.
>=20
> Fixes: 1576d9860599 ("tun: switch to use skb array for tx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1B3A1B72438119BC+20=
261120033824.681219-1-raoxu@uniontech.com?part=3D1

