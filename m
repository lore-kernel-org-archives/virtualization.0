Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364753;
	b=V3OohFcEWvCQjCOaQ3MrVTr2zGcqg9+NkTjWkSNsQTdGVnZYYkx1+LANZ1bKYX4cJIgG
	 jeJkl54hbQejJy+iAY5veMfXK9gTmZe1cea7PHuAj+5YGUq51x31BZojS7YdkG5pZQ0dq
	 O3jSmSqgVPaOHe6gqm9EIaDJaRcjQ2IfYx7TMUaznZsL2iC+9ANpN+46ntIgN2jnLhTo6
	 TbEW0eT/v9aL1MFtuN/Q6YDzjnIjBBvlbBz8EvY1MriIRF5WizFmUJcy3tdBm49LNEELC
	 2OkQCYhfayqwJK2lyzPZm4WUiecaZ6y/aAPY9jgOrN+6dwCfvXs9QqhbmP54bevKQtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364753;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NFFKYT7Qum6FSJnheh7D4LJTFJd0CV/D2+e6ydwEqxk=;
	b=O9l1fwoVDAlNMtczPNh2vhg2okivGPmrTjoKv5YhKXNmtFfSO32LjQoV39QmTWvM+NF6
	 1eTTMW45AHmZn/gjHuAag+S92OKlmBz9PZoKE4Wrhjv/or8v5sCedbIlbo1RDDaqwOZHU
	 WwZT/YsXQmDQJue4hCtBeiXD0j2vcscWjd9G7gpfN77EWgX4PEcIrZ2p+EgXKQH1agy2W
	 Rk6Hl1egPRSD/EDb0VoL1aIrjKcoBTSkD9PRqQM+72Qr8yVWPJBmTmv/f+GSSVsIwoA49
	 KrZ4foLfVrPUtbtMSlxlDF6TMjZcCnRhsFaFIrtAy4DllWqFNU7BFJC8omIqL4WTf/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzaejTG1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C07606A324
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzaejTG1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4081F0089F;
	Wed, 11 Nov 2026 02:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364753;
	bh=NFFKYT7Qum6FSJnheh7D4LJTFJd0CV/D2+e6ydwEqxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XzaejTG1x14f8GsRrn0RKf+P4xH6Zxzfw+P9bFxcrCxKxfE7cjd4E5aBsV+dErTSW
	 0vEyTvv9LeYD3UIG1ybFYp6zVu5PR86EXuX6Kuq1GRawGvAOfq7Gxf5zAMzagL2yDq
	 VrO0r1Rnm7K8zAHTEuS9+PPTVT4G/Z+Wp6ceSQ+cZSqzvBbtopsrpdwldfgPBVy4qN
	 Kc1lS+V74Z36U80+2LPcOAuRBlX+IzCIcG7tfZhk1mf1mKaq0Tz9XE+Q2vpaozeJcT
	 qonRng2mhMgxa1aTemKKC9uiqoXpCbV+QnAKetLn0+GZNAzmFYOIP9kTlFu5+xi9A0
	 qt0ghGmYdiUQg==
Message-ID: <sashiko-outbox-208103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] splice: remove pipe buffer stealing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S2lyeWwgU2h1dHNlbWF1IChNZXRhKQ==?= <kas@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261110145241.536019-4-kas@kernel.org>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-4-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:39:12 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Nothing calls pipe_buf_try_steal() any more.  Remove ->try_steal() from
> struct pipe_buf_operations, its implementations and the exported
> generic_pipe_buf_try_steal().
>=20
> PIPE_BUF_FLAG_LRU and PIPE_BUF_FLAG_GIFT were set only for stealing, and
> go too.  page_cache_pipe_buf_release() did nothing but drop the page and
> the LRU flag, so page cache and user page buffers use
> generic_pipe_buf_release().
>=20
> vmsplice() still accepts SPLICE_F_GIFT, and splice() SPLICE_F_MOVE.
> Both were hints, and nothing acts on them now.
>=20
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110145241.5360=
19-1-kas@kernel.org?part=3D3

