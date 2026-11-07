Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062368;
	b=MPPWMOEmrXKyfznOi04fCTMqJ1q+ml6AaCWJfPA2na0xN+PeskYFQ8CGLQRyGWDnwZ0M
	 0UpgGfinxBP8dXxKcTgV1W04lADZvWVuhXtQt7zdpKAO43ZTfsmzqIdX6foxmxrKEPtNJ
	 QQgwRQfUMK8kQuXweYf+GUh2D8Ic63zyFL1DmVoDmAJ9EiPBgW1NqrG87Q9E1AYS4cICA
	 5nuOZd6Xc7PQfh/ox8eIw0rOP0G7KeReJnIh37l+LZ398tOY04Ln3wgrAZGi8h99pkNMC
	 zqREeAoxrA5/5/KXEPu5rfXbPGsFR2dZbn8cZ3z1mKhyAweCmkAITHFXJIDcTZC56Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062368;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jcRmuQI/6D9IdiqAgGfunxiaOefRVoFEO0yEidQ3lrA=;
	b=DgNuWHLWxa5uwlVcDNln37fIVfbcIdB6IlQcrv9/YynU2R7Wa4OrIZ1X65ZerfINjZTW
	 ELRc/0Mb0tl9/OTDwXnDKDvm67pKFEx6zpA0Sst3ARuTgOVMCKMUWlGKuQiDzWVvcam57
	 zzfwBNbGU4lpw7Vvb9VL7i+3B90H4CvUnBjBVsVW21LoYcgfNsCTH0QZjkqdQzma3viKI
	 PSULVgX3K6WinmmGtu8gMT/7gXAdwCHgCxPTVBQGmIMgFpGHtxEgblXxfGSGKW3o9ynuq
	 S4dpxi17axkUDet8G0QGTKjpH/u8mdcWnSxjOclA0yotH83bM6SGm4WOY6rAoUNeUNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFTb4urG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC186082BF2
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFTb4urG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F111F008A1;
	Sat,  7 Nov 2026 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062367;
	bh=jcRmuQI/6D9IdiqAgGfunxiaOefRVoFEO0yEidQ3lrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GFTb4urGQBpxP7jPuq28gH0Dh55RYQSFHszYqkKz/tYZoqNXzcCaqxEYUbgfbK9ft
	 nJSS+1Tabi7jfJVxo0kPYpzqyiyrEVf6esQ148H6+VTUZ/bVKD7Ty+IehsZiatSP70
	 SYlI8iOeFqEhHC++tCkP4Dc6IAMyhhQID8hTI0xp6jAzY/R7PRotSoNhp0J8lPYyq+
	 U0DHEx6lMYRfpUsadLn7Cu06tdAqzL6PyIg267T3yMzG6m0oPSRI/L2nfGxxaPljum
	 jLSI+6hhqVRm/E2sPvuLIAk01ebtCqpDyhXSX1X2yaoW8xpewyH1qQdZskAoVEhIF+
	 6EiX3E8ZwIW3w==
Message-ID: <sashiko-outbox-202961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 01/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-2-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:39:24 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in patch 9.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D1

