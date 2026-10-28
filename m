Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156601;
	b=L9+SLo31mQ52cgH8PpIOF1sfdF1xLmnne0GMN/RBS87DxBdHHyNYjBNjzsbEjHuZg6+6
	 3abkgwPE9huz3eMroLTVKwCSshpBr90SUf9CbulH7pHUKl5NrQOLCV5y0z514yzkg1BBH
	 BdkwsStjrxZYhHhPYPp9AFMdmdtJ6VZeU3JMEXlv8mCVciAFX/QjG8lS8XGQe4l2tuj74
	 iosnpY7BJ9VgXliiYb1OMoyA4Zb/SxpWgtPLr3qdqKkZ+QlvxdMxmQlG7neIt/yhH/UJw
	 1a3RQPlBjZ55/bAU09Dufsd7FYaKcsXjcsNfJ+/GPVo8vsh8yHvBIXOPthZsiFJlP/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156601;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uSxfUbAQADblU9x0PP3DRsH7tdAFQxxdrs1gfmlvYCg=;
	b=qyImrkmp2zgNsjGvpzjZYybdm6nwUBVGP73RgOS1h1xkdbrxDcRa5RzAbhS/Px7yRfNP
	 dzt2ws8qE2TufhQjaiY4SPju/W5qqfnrFfe3Kvz6kh1mFM0d+Ltvzpp7H3qMvWnCUDwAs
	 HlC9fyl5iu89du67O7OQMMluobnnTbILD7zzxsiBacL6c1fXVK6upVLkMSrV39k5sgABY
	 H2cXY73oSVw4kAW/nolHJ2T+2uSi6+Dv5u6v0ggQP1m6BYR4N4fbIdVhzUdx+LkkGEjAx
	 P3wdkO2VPcquiu9+m7WnX7zPxTQEsplXig/2qDgSSLhY7GBKKOQ+QGuDga9oBogrcxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4piHmOL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E4606A31D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4piHmOL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA341F01825;
	Wed, 28 Oct 2026 03:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793156601;
	bh=uSxfUbAQADblU9x0PP3DRsH7tdAFQxxdrs1gfmlvYCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4piHmOLCHqJ+qrQRvayV2ZdcjacxtHXArAXPEXarqk1eImkoKy7rvU9kU74emJKM
	 e4b3pGCz7I8F6hU5MeHGkz2wnLy0fDgTCpaKeKRzT90/V9Nxmd0VB7r9QelFtc6xWz
	 CZexx+KKrQcJPKO2MdpFe718Ck9GWPcAH3evAck+MvfSb2spYTbBB6CQvq/ABZo+Zr
	 Zc+kVQrsGur0Lr0tSBxTZUqWRq8prTHiawhWYzJR7fmuq6Nq/TOCugbhhtu8gXJ1SV
	 Y2xmFdyen0zwA4hUYC3hdq3uWiSgzfQdHuYjS3QQegeDqaCOUpGxjNrSugW3mPG8CY
	 50+fw4Uik5WYw==
Message-ID: <sashiko-outbox-187371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/14] ALSA: virtio: account staged capture reads
 before RX refill
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-9-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:03:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The RX callback holds the queue lock across a batch of completions. A
> reader that has copied samples can wait for that lock in ACK before its
> consumed bytes are removed from capture_ready. A later completion in the
> same batch can then reject data using stale ring occupancy.
>=20
> Account the staged read under the substream lock before acquiring the RX
> queue lock. Release that lock before taking the queue and substream locks
> in their established order to refill requests.
>=20
> Once accounting is committed, latch refill errors as XRUN and return
> success from ACK. A negative return would make ALSA restore appl_ptr while
> the driver retained the consumed-byte accounting. Keep pre-commit errors,
> ring-capacity checks, and normal period-work scheduling unchanged.
>=20
> Source-extracted host and kernel fixtures reproduce the stale-capacity
> race and post-commit ALSA pointer rollback. The candidate preserves wrapp=
ed
> data and pointer accounting. KASAN/lockdep QEMU lifecycle checks passed.
> The fixtures substitute selected backend helpers and do not independently
> establish physical-device acceptance.
>=20
> This follows pending staged capture support, whose introducing patch has
> no upstream commit ID for a Fixes tag yet.
>=20
> Link: https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc=
4691@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D8

