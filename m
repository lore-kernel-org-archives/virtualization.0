Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010806;
	b=i33V9SZUb5KJATyPyoZESs7Z/MGb0R6MfuLNUTrg54knnYp4BN+p3hMGBoIVdxdN/NSL
	 zb0psqi8yeUG0maogu454wp6ertrs9mTVfomWV22ZSXsL9Vxhzel4NNPdhDaEU0YgUmQ4
	 7efWtHdH2cYiuTYoeL7MZ4jrhh0amFfqM2cv5WKLWzSF5glkX4JdZlwodShTQssHbONKq
	 y/ZlwXdkD6EFVAIDun5b+UG3hLhYnzyGP17Fsbq4ab95s7xuOyYUFB8YZcrn8MmajV1eU
	 uXe+mEPsBgZdXZhc3CHO69N3BFbLYMbj6TvebMGf7M+WVyOpd1n+WnjmLsasKo9ZB6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=O8kUxWwNMGGKdJF+2JBGIvhWCx8VFS9Gq0fs2XPEP3c=;
	b=BTL5Uc2wnASZUcVDxNPnO2AehkqCfSrjlgRSVmM++tA4LmhRgDtPA/3qUf3KKV8N9g8s
	 9FJnMQDwyDF4d72ZM/OeisMa+AuQlqn+t21ljdgPJ7j1x0frD9mLGBSI8s/XR9WourRLh
	 GkxDqeXRrIrMLzjGjJgcOFNnbTgt6XH/WHiNLSRsN/yTawSN0gN9wZ2F5C+Gu+Y7P7YMs
	 OOW+G/qRn5yq5+Gbb8VycTDwB+gL1YLyzcx0HVTxhUOLK2WWIZyrJnIahq79UGyCHWCAY
	 3oKyIEip9xUyQdURIfabvTnDi18KajrXrij1uZ53cuzCkwZhBlS7XtGs9ShtAdVN7+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=m+xbdE2k;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A06606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 14:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A06606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=m+xbdE2k
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so14096895e9.1
        for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795010804; x=1795615604; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O8kUxWwNMGGKdJF+2JBGIvhWCx8VFS9Gq0fs2XPEP3c=;
        b=m+xbdE2k5CCVtpBP577o2tkxcRdCBv8X0ubrc4Nn7qvC4s7OT1ONYtLDkxTy81wS5s
         XLRxhavPkNIyPjaAfZ6kanIOp/tyFL/uG4Faezv5bA6NYiFOnyy1oPi3XQBSvAMea7aK
         ltrHwWADMWOV1HqENeFcmmHZOUlHBXT0MtECSc41tppkRmtQbVOd1Iw+W/9bRFPg0xwZ
         AfOa6Xj4i9j5ebEXys5PkCUIFA6nAUcOmu3Sxzy3pFSURiCUsqKkBSDMD0t53bG7ur2+
         ydjYlSXuGjuc7BAbkG3yeDi9kwk4d92sCO9wZLm1CgzZa+DWoaEd/Oy3RS6bWfeG8hdq
         GTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010804; x=1795615604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O8kUxWwNMGGKdJF+2JBGIvhWCx8VFS9Gq0fs2XPEP3c=;
        b=gmDMhSJgzBqVBPkUGYdUmVBXRaKo0d6VMYsj7PVLfZKpZcN1O8LRurkchTf0mQWUSo
         YduDSi2X7192D6I6jyFh9I6aS5bcGeE3F9pf3l31Br1dgPzgKThhZkHgcLQOh2aRohx0
         gvyW1aHDTS/6RGbKR5ZRiEAQbhmibMrfKs/tzMGv+FC2xUg64W05F7ktsrkIAJIX6BB1
         9u95HFRE6TpjqUTQd1BWXlfalgSOJ4jj/vk7RIio0E/jt1KeX0CaouxgY4A0BA3lup4w
         VYL6B/NpWJz+OXuZUDU9Eq0uJCpWcqeckiuNAxKGFXzD1VT6TMQH6x6oMu5tskG/O/lQ
         aIwg==
X-Forwarded-Encrypted: i=1; AL+hErGKGqCaQhsTCoRQRhr5gaKfodJ7Dnpze79TOaQ3X9BfZ3RbPQwW11lkiIXqTFLdgvdIWnkIgkOncsJcnQ5TUQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9axdKAtP17xu49pGS209SqcdKiegzetY/fPbvwm1dm4cI06YK/
	JrgG8jP/af0WZNDOEnzzMPkG/QN3fNa8bcWRcFtkilAoGC2V3tEWq0zPlvcgkcc57gs=
X-Gm-Gg: AYBFou1xf8+xnTFOEeLgT0sU8eroBt+bRtZAGFM/YOCEpotbwZHquCIHxC2r5aiO79E
	lSWyOwS2iKQ8aJ3DcwrGi9UWSCwgACqBiICwUS7FhDyaKAkWAcpMkSuen/u+BHZFmTilVCD1YKU
	NdFMU3P6N4vLHyyccLN1gptTL1LuCFgp70IR2iSoXmqT0d5sea1f5VamW/akJBm/extPgdidFqd
	AbQO/P2iNF3TptXY56h2LdDQZPve6iZRaRep+zBrArNFEsTpU1tIyGpfC6o/zVtmjCu38Xy2gct
	TEIHqmeesncjzs1MifOfntQfJne+y7XmPPKNhdSmql0L1ON2n01RUsCZhzgj2wuYI4+e2LP4bJG
	cRQfi+oUVRXquy5Km2VYVJR+4WNKTPEmOqv2dKsxcQDdCDsG7YiYUTTc86GBA2O8/7mG/4dd+d8
	hCLl4f3/56PPG4lyWcc0r2SEgDZ8qTNofO+FxoYSL7nJ0deM74RKBYvSXO2esz+adTiuuBn0E0c
	6DKogO0xiQGZXeLhT2HslOb8DXBLBCpyDEqPBjkcpfapmpXTO3kTITVyU4D74YNKrRUCsLREy8a
	o1Re8DiTkADr5qdw+bvnhUj38SAF+O65rgA=
X-Received: by 2002:a05:600c:3509:b0:4bb:68b9:f610 with SMTP id 5b1f17b1804b1-4bb7da03954mr52120315e9.9.1795010803953;
        Wed, 18 Nov 2026 06:06:43 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb7d256f64sm61534715e9.1.2026.11.18.06.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:06:43 -0800 (PST)
Date: Wed, 18 Nov 2026 15:06:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sasha Finkelstein <k@chaosmail.tech>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-riscv@lists.infradead.org, etnaviv@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, linux-mips@vger.kernel.org, lima@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 9/9] drm: Unify coding style for *_device_id arrays
Message-ID: <av2rKJQ0AKU9CFZI@monoceros>
References: <cover.1795002467.git.ukleinek@kernel.org>
 <a2d5ce256b8ec150de4a6494c177b19693a33222.1795002467.git.ukleinek@kernel.org>
 <7692c160e418e7ad0528739fcc879b11fbac8ab0@intel.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5c6ped4sw6nigwko"
Content-Disposition: inline
In-Reply-To: <7692c160e418e7ad0528739fcc879b11fbac8ab0@intel.com>


--5c6ped4sw6nigwko
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 9/9] drm: Unify coding style for *_device_id arrays
MIME-Version: 1.0

Hello Jani,

On Wed, Nov 18, 2026 at 03:27:40PM +0200, Jani Nikula wrote:
> > [...]
> >  drivers/gpu/ipu-v3/ipu-common.c               |   8 +-
> >  drivers/gpu/ipu-v3/ipu-pre.c                  |   4 +-
> >  drivers/gpu/ipu-v3/ipu-prg.c                  |   4 +-
> >  254 files changed, 1155 insertions(+), 940 deletions(-)
>=20
> How do you expect a patch of this size be merged?

Using b4 am :-) Honestly, in the cover letter I wrote about an immutable
branch and offered to rebase to 7.4-rc1. When trying to apply this
series on top ov 7.4-rc1 there are only 6 conflicts (1x modify/delete
and 5x content); these are all not so hard to resolve (and even dropping
the respective hunks (i.e. resolving using `git checkout HEAD`) is fine
for me.)

> > diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i91=
5_pci.c
> > index 84a7dc6ab5db..faceb3de4fa3 100644
> > --- a/drivers/gpu/drm/i915/i915_pci.c
> > +++ b/drivers/gpu/drm/i915/i915_pci.c
> > @@ -870,7 +870,7 @@ static const struct pci_device_id pciidlist[] =3D {
> >  	INTEL_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_info),
> >  	INTEL_ARL_IDS(INTEL_VGA_DEVICE, &mtl_info),
> >  	INTEL_MTL_IDS(INTEL_VGA_DEVICE, &mtl_info),
> > -	{}
> > +	{ }
>=20
> Personally, I would *always* use {} instead of { }, and would rather not
> change.
>=20
> Across the tree, {} is slightly more common than { }. IMO changing them
> is pointless churn.

It depends on how you count. My statistic looks as follows (on top of
next-20261117):

	$ git grep -l device_id | xargs -n 1 perl -g -n -e 'print "$1\n" if m/devi=
ce_id\s*[a-zA-Z_0-9]*\[\]\s*=3D\s*{(?:\s*{[^}]*},\s*({\s*}))/' | sort | uni=
q -c
	      2 	}
	      2 {
	      6 {  }
	   2598 { }
	   1262 {}

So over all *_device_id { } is more common by a factor of > 2. This
series fixes one {  } and reduces the number of {} by 37. For only
pci_device_id it's:

	$ git grep -l pci_device_id | xargs -n 1 perl -g -n -e 'print "$1\n" if m/=
pci_device_id\s*[a-zA-Z_0-9]*\[\]\s*=3D\s*{(?:\s*{[^}]*},\s*({\s*}))/' | so=
rt | uniq -c
	    159 { }
	     32 {}

Without the context of an array initializer there are many empty
code blocks (function bodys or `do {} while (0)`), empty dt nodes, and
{} in Rust code, which IMHO have to be considered off-topic for this
statistic.

Best regards
Uwe

--5c6ped4sw6nigwko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr9sOcACgkQj4D7WH0S
/k4vggf+PQfM4MkbLgaQRCdXRWWsc4/Fa0tTMBQAl4gjx2p5NE/N7TDUO571o3+N
oWcelzY5O1uRcc2qHZVnu3vAxFqzk4YHfGjsbGHsxQAibxnIFW7ttYTzt0w5a9NH
v65V6+sebCdwLrPVE5ilcqzFFSgmnv1wTNm2vCEUxdKGacifySaGRmg4+ax+fLb1
CL+RS7fM2EkQxG1k4iDEPv1Onrm9S4DtwTts0wxkK780rWYD9FoSLjHyX/x21Y8x
SZKaXeNZlxtHJpQLq8ub8AL/t6k82nC020wYZOUbUmvPyqxhNoUuuS0/RVlz9xT6
kXiliIwWzcMtAKt4ik8nbTRO5JERhQ==
=0alU
-----END PGP SIGNATURE-----

--5c6ped4sw6nigwko--
