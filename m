Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366160;
	b=yf0Pt3w6+4Jcm71JoBy/GDrPlssATFPcf9epD9syhR9vte1ZDmw/0BCG2P7+yMm8wOF8
	 U81J9EM5E+7xoPkoGxJzAlZFljS0vBEH3vI1Xbk8WgxWGIa1xWMmGqDUBYxJVrYLzJQqf
	 PZQucFBo6fbFoqKn6/QzzE6/iyQAQOTOIsjfxT+MfX9GLW+R7dAQlLXosdefu2y4Kp7dF
	 0+bwVBC5TlU41CBAEMibHfJUQFlwYhO28rQQB91rCZqbl/5s2/RB/GgK3GM8qGVNsSqeh
	 4WYJL9UcIFr7R2vH0x5nQJFqE5hAewx7gJ/6QzMRRwIZUlq47HJwH3l4SO0UY8q/vpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366160;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wMx4sMn6m3PCwHfGRohYv062/FT2nabhU2TBS77P0wU=;
	b=11o83EZDCy5/KXmDwzItYdugMSnvdbIe8ofR4Fw3SVsgm6AZHSGYPdTk3O42Z01z8mLv
	 JrbsgYeIH6L9efen+WaX4RQ2/btSx/EWMzdkyvGM+Zqrz4z8UlRpHPMuE3ejt9mJWPtNd
	 8XLNrU7xKq2TRyAScpnLlZwncMIfFLKfuZ5kVmeOXN3N01+cz05EwlgYbT6rRn6lZLVYV
	 3fiOKedziYIYxCURRB7zRa0tefyRQM8ewpZ8HsOQCezad8vLy/WvEkDy2aqw8UhFTKexk
	 xb/3Ys/v+t+U3BZ+vYna8SomXVaAbBXGsi05YaEegm1n+VL+eU3GpGx0k0qfgTt+1tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cb69ZHjF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22159606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 03:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cb69ZHjF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842DD1F0093C;
	Wed, 11 Nov 2026 03:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366159;
	bh=wMx4sMn6m3PCwHfGRohYv062/FT2nabhU2TBS77P0wU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cb69ZHjFGVJ/OQgcWS5hw6lXkVU+ualYh97x9+aXmsnYdEdh3P/jhwewyD/tRRsC6
	 5uHgleD29+UXPqCvC6B9rmhWwQifxs93yC3iOu3WME1ijIuIkE22a+xi9obmAZ8Vi8
	 7EKWG6Ji2dExmrZHZPCk3mZgUe6FlzvR+M0blKi5OZ3i+gsCIz59IvyJO3QTGxdc/p
	 HuW/lDXkgouUQtyYzINcbxAvZgssuM1s/Fs2nJDf/bZTtGQRJpfupbBfXqveewpfvd
	 VFID9XvaYVa/lqt6CCv8K97PsuFu0jM/Ks9ysyeduvWwc2+Jo0E/qahKl9ql9YZtLH
	 9bx//SSg2qd1A==
Message-ID: <sashiko-outbox-208151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 01/16] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-2-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:02:39 +0000
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
> staged-capture policy sampling.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D1

