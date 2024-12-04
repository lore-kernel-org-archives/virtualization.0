Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7F1F7589
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321408; cv=none; b=T+sOBSXhJIb8m5nBLrVf7ccx09uiEoVsqQTEa0CESmBrYzj4XwFCXJzBv9YHP3A5epU3YRWfhZeG3tu7ReEAxRtvzq3osaTGEBXzkWlADelfMDZIYlSbullja03zD+yTWk33/0AV/nW2QxAax92cqe9Wb+/7cnk6o7uNv1b5U3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321408; c=relaxed/simple;
	bh=uxvU4fSRyWue5vxc3QNX7F/+NrrOhVfNfqhWAGT2lK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/JcVs9gVAklyrtNiyA76Rz7L40cfgRnsdoC+Q0UcX9TAmts1fH9/c2lCOeAMYK3hsx724OEXrBz/5qi/lmBjBx2zayiq6aDrwWCo+08hcpc5DtksnxiwM6IRr9Czjmt27LSMTVPrGI5UzEgGcBXfJY3BmIBYNQVzOlR7MH3lWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDYOZqrC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDYOZqrC"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385deda28b3so3443245f8f.0
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733321405; x=1733926205; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrFMLc/jdh5p8JybRnIahA1b8Q2rxGK6wJh2KFAKrwU=;
        b=KDYOZqrCHdw3Fe+QgLvLmpbhkMke6FiTZ6Ldi2LvNsdgecaVGC3Qc4Grwby0Geetlb
         d07+RRNouTr7ZyHT0qYpl2QKasZCIUEDO0Lizqpf90ADOgKJOTaOtCDtf6OiBQpIgENb
         UFkiKQ0CeR2lp4AlZG3h3TpjGcY4aWYSCAaP8kgUST+zL7mPE48lZ2mA69JBw2Y5e3Tr
         rtIzV3ddGz2Pj9u26uRSWAHKbMA7aZ+8k+ItkM8mf3yt4QRJKtfCNn4yo+T4aq1JCO1R
         O+o5rqEh/AtbaKMZ3PBLV0FqvnneJDB4TVqSUlYZqVEdAjxfW1eVNnb9q+5voWXsLAEu
         9hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321405; x=1733926205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrFMLc/jdh5p8JybRnIahA1b8Q2rxGK6wJh2KFAKrwU=;
        b=niDgvw4iolzKgPxLn1qjKVgdSuGTwxRy7/f+y4lVlUy78fTw3damiXkx4cfXRPFYiI
         CRME544Z2X1S+IFcjRXyBhHHj8G0T77dUz8T2J9RphKPqUN2L9tl2KsM9zckT0ZcaIiM
         6wWvLhFcr/acxHgK2xo9T9L4RquJmBhrj6ug6gygVYLBelZhvpmULm11FrYyY08DRH9V
         eaWrvOsaDfWQA4KbITL0d9IfkBSMWx1t+4JGmohltCT5Vg8TExWxudCZw6qu2n1QZ3Ga
         UCIsW6T9qDt82Q8erPWcFJC0+c/731AUO9Eoc5sOKdhUSuy7sCZgCDnFHin2mSuhkOF7
         fvgw==
X-Forwarded-Encrypted: i=1; AJvYcCWChCp+Ast9FnByIdb0GXcigAqZ4IJYAu67TSnGJMokLW6WXFcyTAzvCW2EvkjM3AzvMZsO8Ypw86srPb0Q2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPSHgc8Ga3IyqA82yMtfY+MHz9TiH2g4ydb3asIMEFHOEqXsN+
	kDzTQnG7HZNEFqBON8Fx9FRGgASb1KNqRZ59iR76ojJC/UY0ScYJ
X-Gm-Gg: ASbGncu4QTdeqcS7DLKFg6JNApdASfewfPayRnqUb3+DTAb8gi2So4SCKgoS1FKfV1h
	FXe8s1gSDsq53sUxFlqw2lw8vmuQySkgge9ans53fP6U+yOJ2dPS7ydIDBP3PiNA3ptQScfHpom
	3MvPf3vuC37nobJb3HJCeu65ZoWKmZc/T2Is7JL7HvOJqjtb2IQc1gGbIgJGjSx41PBrN90LQEM
	4a4DwJnLYh5FxLdK5tJKCpYtU/dwigyuI3YFSmr7N8Z/nsDOmS3Jz9S3KTx/kV8ROWbFsiKJ+F0
	OouBE4iJsvJSoWr1zmydZJ0/yrJbdxeaTSQR
X-Google-Smtp-Source: AGHT+IG17qKjHP7hajsb1NqDKGf26pPgtY+u2y2Irx0Mpfq+Bk5d1g+9CG/Zi2mBLwUCzK6vQKtkSA==
X-Received: by 2002:a5d:598c:0:b0:385:ea2b:12cc with SMTP id ffacd0b85a97d-385fd3e779bmr6188036f8f.13.1733321404995;
        Wed, 04 Dec 2024 06:10:04 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527257dsm26885385e9.1.2024.12.04.06.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:10:04 -0800 (PST)
Date: Wed, 4 Dec 2024 15:10:02 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Gax-c <zichenxie0106@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, mperttunen@nvidia.com, 
	jonathanh@nvidia.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	mst@redhat.com, airlied@redhat.com, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm: cast calculation to __u64 to fix potential integer
 overflow
Message-ID: <xlmfl2rhjgczu6oycgogchqi2gc65w7s3qy33yxzsrf6mbri3q@7onulkroaa7z>
References: <20241203160159.8129-1-zichenxie0106@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="magv3qwbnz55o6h7"
Content-Disposition: inline
In-Reply-To: <20241203160159.8129-1-zichenxie0106@gmail.com>


--magv3qwbnz55o6h7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm: cast calculation to __u64 to fix potential integer
 overflow
MIME-Version: 1.0

On Tue, Dec 03, 2024 at 10:02:00AM -0600, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
>=20
> Like commit b0b0d811eac6 ("drm/mediatek: Fix coverity issue with
> unintentional integer overflow"), directly multiply pitch and
> height may lead to integer overflow. Add a cast to avoid it.
>=20
> Fixes: 6d1782919dc9 ("drm/cma: Introduce drm_gem_cma_dumb_create_internal=
()")
> Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
> Fixes: dc6057ecb39e ("drm/tegra: gem: dumb: pitch and size are outputs")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/drm_gem_dma_helper.c | 6 +++---
>  drivers/gpu/drm/tegra/gem.c          | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

I don't think this can ever happen. All of these functions should only
ever be called via drm_mode_create_dumb(), which already ensures that
these won't overflow.

Thierry

--magv3qwbnz55o6h7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdQYrcACgkQ3SOs138+
s6HXsxAAtQJlAEOMdgNNQBcnlKziuLGEV6eDn2I2ZMbyfdflAwfxU1IZem8HHolu
Uf8rl4/XAETFBzeMup8SZ+DvspOCUSQY6kf8Dh+25/5NDTEf50vjBA/TXcws/ced
6pRImbXzulFvz7kEm/fOaTXdk9w7mKnNDpFj86FUBcuz5kIQm1Qo4uhEYZRR9BSs
C5c6m77m/4N3Iw7mkJoKW1U0jDJpfgw/iCdUpZrNh2buoKaRhe3WasizYdpXcbIn
ImHPVPKV7MUgLrlYjdqOlxninIKhRMB9n5hcbvHD2YQcv9Y3pj1XA9YzXu3+4pir
Sq6HLJFoHy+vmeLdTJZsMEljM25tBtkXkIUVEiWUb4BTbjJHLikCT4IYvfm9wByx
OKCLKtdAiKyC1mh3aswnmeHb9tHBTt2Zj++nl2u/oUJyUncmBeboX7Wh+C9aCWF3
cjT8OzvzTFX0bTLWyO9n0hwM9n84di0kuVmN8Bm7erXZcFAQyJfQpVB8lqiXokYA
iw+IZX7DQQ8oKnxYpXy+V+gxSD19e4fed6jzgGpn7s+JYRuH1SiBSA4iaIQ8OCze
7FPuGM5WT1d92OgNUU+jC3gjM58QHwLiEFhJgV2Oj6/sOi5fs1JY9uGKlMbxynlF
PQm2NJU7k9lZXI2hxYRY6AmtikgF4NSYiz5zgglZvHpLoeLItpo=
=dkp1
-----END PGP SIGNATURE-----

--magv3qwbnz55o6h7--
