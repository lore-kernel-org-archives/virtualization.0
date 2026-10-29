Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278049;
	b=YLktL28o/j/lo+PguY4z/VkBg5LvSlv1gDqPSp4yGJl9ukCkri9M3eVgiJfxnpAlcSWu
	 6ogjcoyAuzaF/6gYIFmDsfffkc/R6am3tnd6KNRb0DMJOfx2altZlAKrvPozhhN9fTBkl
	 K8v+Qa+wP1jq88t821iGTLwFXHhUNV+9lHAjnD/fvXvSAYgzbac5pTED5J1yrNwyRaeBj
	 mNo807gmkQUgaohkj+zJmIV3qOSa4IcPe9T3iA7c0AQ2WDa+jdR3NC4hIxOVhJ+bBHtpi
	 GmG5vAXqS/zmzNmLMQsPR6EoE69GP3cpJwE2MPhBvENPOAnwsOeckRjq9OBiqofQQgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uiPn/etcPJVIjRT7WJWwzr8rDubti7VmYD73Q8MsDz0=;
	b=GAlEo8lcOppb+InktLushCSR3OnGioucqkEgjF6cRilGVFj3O0waKhz9tpm5lrqHnUwv
	 PTpbIMPrK18/U/PkRgHPfwv5YNjn3B5mHwtRLTXeedGeXx6UwA6GAaKC5uOE0zI6brKqA
	 3rBwsJUM0UHVbt0dBGtaEy2A4cAvpMUUkXl5UIYB5dNKas912cematXIYlOiS0ztn5MKH
	 HAhz4+WgkcbLrnr6rMgXKPKOTPIq5f9xiVMdXnEOsTqNFd3/DnLgtoxZjfNsaeF8pSuFa
	 EcpoNsI6Kwc7F9tfQ2fw20kHBG1aCDSmOUW2PiF6VFe3dwtDgoplBF2CI4aFtTQbcIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fa85I2J6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97D606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fa85I2J6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384DA1F01825;
	Thu, 29 Oct 2026 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793278049;
	bh=uiPn/etcPJVIjRT7WJWwzr8rDubti7VmYD73Q8MsDz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fa85I2J6SALs+Q9D9YDLYQIoQKXStf3euz4XRDtaXO1sgLheAfmd4vN357b699XRL
	 Cw4bBbdfWzHoiT7YGUndJmbBMtj5agX/C5BOouL6VYKDytr00HG+7r9SYjvFW0zxgm
	 Sst82YZwqHAGGV/7eOlFEGjMREL/N3hhjuOs8Jnxuyiq2LyrXwrnriKrmddItYhr0B
	 kNSjt8q8qRXjN0AXhk0yT9YQyeK9qJC5MWljK2jCckq4OaIWbIzm9w3NWkKRZo+BJS
	 FyY+toI1ZSlUJodYyVukqlhL+2MJ60xpfFhQvyJhu7sFljuft1+u2kvTXbANBZarb8
	 dlKDLYEsQn7rA==
Message-ID: <sashiko-outbox-189308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] rpmb: stop the routing after unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haruka Kuze" <harukak@zohomail.eu>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029124132.2354314-2-harukak@zohomail.eu>
References: <20261029124132.2354314-1-harukak@zohomail.eu>
 <20261029124132.2354314-2-harukak@zohomail.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:47:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Haruka Kuze <harukak@zohomail.eu>
>=20
> OP-TEE has a reference of RPMB device it used. So, it can route
> frames through the device after rpmb_dev_unregister() is called.
> Therefore, the parent device passed to route_frames() can be
> already freed, for example, mmc_blk_remove_rpmb_part() drops the
> last reference after rpmb unregister.
>=20
> This patch clears the route_frames when the device is going to
> be removed by getting new rwsem and makes rpmb_route_frames()
> return -ENODEV if the device is gone.
>=20
> Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) subs=
ystem")
> Assisted-by: LLM
> Signed-off-by: Haruka Kuze <harukak@zohomail.eu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029124132.2354=
314-1-harukak@zohomail.eu?part=3D1

