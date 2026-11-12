Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462380;
	b=qV7vYtK8vltv/p36MXTv2LzNqPKBWUJU4aL/FzPxifrVGBjXxH5ZPpX/Hlb1sE1lwl09
	 OGAm/NYaetBbxYMB7gcavG0Sy3azIU08fzpYmv3Yvit+icrz7kRxPr7BXhOZeYRSHTzIp
	 9YQzUmQlTiCGuP7hPI/MZkA3YkvXTkeI0BrLF1M/a174IpzTLsafXrFGs0y1kYs+Su3cH
	 if41CO4GoKFXVTYow2a2npJ3B3hpUikLN5et3VoBPDvGdu/4dlzzSxRfO1VsPrr/CqcRN
	 od6D07DgEZ3hPo10wVdRqIZJguokOCbQRvnc6C1wrqWzScWpxs49XGOKp5+HPhF6ttQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462380;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Dqna5NephWAt7pfvI+4+bId3EiQrTD9h68+Ydcq74v4=;
	b=DtjPRL9FspD4jEFL/pSOEPLVsr2R3DkV3sKRN4rNSuqS9ALN34jdXUmBGgE+t8nmsnLz
	 iUVHaAd5ZNTLHQqxFefiLTQ1NlUunNsaZ0sbqE4YPXuQ9KgAGJZt3yowyNa3DzLgUnVJ6
	 9zgfjazoyXKWOR4+sYO+caW7racydwLXSqeNanIQGJbjqG6q5kIEx9U7jMEwUiwmK4iFX
	 Hn1q2Pa0NCzXKPrpXb2zm5l4LRboDnuqXMs9iHAvqXeBvr9NDfi+DkEGBitXYYHvt2ShH
	 vf99GP0c76zCSgBXwh8GjroXhg4pik7y63QY91wU4m6gSgsvAU0xahZxcCFuVW4GPZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PopqD46A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E34606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PopqD46A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4771F00A05;
	Thu, 12 Nov 2026 05:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462379;
	bh=Dqna5NephWAt7pfvI+4+bId3EiQrTD9h68+Ydcq74v4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PopqD46AieuKn+LtPsaCASmjXSBRmJdQN1leanjlPnjVaVRxV5CSavY7kJElCd163
	 rgmvicQp630L3agWwu2KYZzjfcqrU/DYqRWcCiRgyXot8n8aES8ehmeGh7DDeIreJb
	 2TzY8ESHg8NXGTLjeEtun9XH0mymchAyslN9LnVC0MdTzZHP7zkDLHtuNYKMVUU94r
	 6gDl2jDF8aj31mGNB5uUaeRfLQiACXO88y6IUdAhCB7GGqJassI4uayDUzb1NcqEjZ
	 +c75iqNS8xCVBPnFvxV5bm7ON0bI3SLd/rmDKWIY8bI4DGc1V9Nwi+3nAkSa+l33HU
	 s6dY77Wqpq7Qw==
Message-ID: <sashiko-outbox-210477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 02/17] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-3-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:46:19 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Allow a driver to publish subperiod progress under the PCM stream lock
> without generating a period timer notification. Use the ordinary pointer
> update, XRUN and wakeup path. Capture DRAINING can publish its final
> tail while playback and other inactive states retain their existing
> behavior.
>=20
> Handle capture DRAINING separately in the state update: a full buffer is
> still readable capture data, while progress beyond the buffer capacity
> is an overrun. Playback continues to finish draining when its buffer is
> empty.
>=20
> Refresh capture availability after the unlocked copy and application
> pointer commit while DRAINING. A final tail can arrive during the copy;
> subtracting only the copied frames from the earlier snapshot can
> otherwise finish draining with unread samples left in the ring.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D2

