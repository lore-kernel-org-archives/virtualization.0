Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB011352002
	for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694004; cv=none; b=hLtOGNLeXljqk3jkDRY3NlzxnDm/uX0FPqYFZgTLwWhYg3EQUnYoyQYnpPnQQM7SHOkHBO2BCth8NN2dSnfmQgl57cw1z22qJ3tLc+MNaQNGfhUiFqbpYHZL+S3VD5BNCtmyrEZJ4F2/ZeXvTkot167uw2HqSt4rBL54UQJRW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694004; c=relaxed/simple;
	bh=W10EYd5yNHtHtCsaAJYNg1f2TbY6i6o+1V5k4q/6Gy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TisBPJUrJdZ5FUoVDy5dXpXDQru9uJ00RlzF5JohjY19boPyy+nA+jlyyNQjJjIWMUqyFx2nFfc2DokqOtYcCNw3G0Skmn9JBitVkQOwhoN3O1EFCXtl5CYtEw7Kiq2CHlStSl1GU9uof4jakyqBN742GE27uyMonB2DE8GedIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZyYA++Vz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZyYA++Vz"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so4363911f8f.0
        for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781694000; x=1782298800; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxKh8I0UMSkrnZV+aGOFbOS2uZGvOfyS/QrDhlucjm8=;
        b=ZyYA++VztjwpvZsiN16mdyY+7C5DPBTt81aQS5y26cxyEWVN0VBl5HPyX7rCyrAI0u
         IR94URwmcxtHe2NBIej0QhNU9PqJb+8XsDmT5yxDD20qkXz1XLHFouzxxpkBLZjtzFJ7
         DDJHOo9hB1BMvZlt+L05oLvtL6k1T9Q7nzZbnlL0AdFpcp1b3W133fimMVDa+COE7W7K
         vqvUKwYNtRFafdBxDUmh+U09NWw8qWg8pPg/OYDKJg1znGuqqmE1tKqTYQ7Y0a2AUE/u
         DGayQJtTawwv9qNPnGaAk9XAVg3CY7kMLNRZI3R9euR1t9YNuJxMAM2/AGezbhmjfTjq
         UqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781694000; x=1782298800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxKh8I0UMSkrnZV+aGOFbOS2uZGvOfyS/QrDhlucjm8=;
        b=j66ugbMkvNIk4//sYH/9e96yMLXFL7t3/Rlq3crpVaOBR0KqLcePKkj6O/z8/5NW3y
         uIAWY4QYxsje4YpNAA2EJtCCxb8zf+ky1y6ho28SBYLB9TY9nrxvLwlOm5JqK8j35/Di
         BYphA+FJoBnb6Y+W1mgV9ctHOavK+wCKmUB0pfBEoTzYpJh+oq5kOzLRFUd6cKOUhtvy
         gInu/y4Z+aSxUarDEjlpQzILQyyW41OBC9PgNLMP+srHd9/9GltWR8j2DymVnw9xN6XH
         OMftnTX7Zo3XXsqqSHgS27TYPXzY00FdEV8w98sKdnHYMDcbt6EaOH0OwwSJm4nyczX4
         wW/g==
X-Forwarded-Encrypted: i=1; AFNElJ/5bYIDvXORdX0CSNpgwv7TzKoZqpPSYvef+nFWDh6D8skNfjnhDFjc3cEN2/WQsOEv9pn79FtnysEu2MTviw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWztngsfaRzBedPE7Mbspl/De6yEkvxd4mu9aEZYW/jrlMaP0+
	9dBqzYWFqM6NLRZcSnfVf7+sIoRsM/nQYL1d55G8QJ+DWjuvRs/Kgeehen1i4DpyOhQ=
X-Gm-Gg: Acq92OE2OH64CfkUvo/kYRRwqrRaCiM67YwkIrt7uJll94MEvSdnlkqN6gSarjBgOHt
	J8jB1P5hvE3p/Bzp1qTFwWHhHQjpri0XXiRxoJNUPAqNWW/1o1p8rAB4JzoGGECFdx19XPeStVC
	V8TSmpzjf2yBJt3XgPZ0OLdGEP3Rl/5Etxa9YRM+0Blh5ojy54jazoijeyO2jxrXCFBARj1B+5i
	zPElErMLmPQbHwQKf6HhBb3WHvas4QL8PAsaWWRGvZ4velQNz/BPTE8PHWpZ9sedL51DTq9Ny2d
	DlnaNI5aZaEWqCWlnvMs6A7WBZVnG/m1XP08ZOvKWMUlacOJlUyghdbXHhdc6pSqrPP5FA/hp/R
	VJicUhlXjkIDLBofedAqjCa90Oe58pHELC0om1dQD1Z71m1HcU6N2J4dd28ZSn1dhK7zOUIxpQE
	k9RcvGE0ewLUehxjEf0S/s4Ta7evHN1aEQSThGPHkJ2oiX3VDdOLPpbkpDRPmIqOx0mVl1q8YNd
	8RAHTvwJkG2htU=
X-Received: by 2002:a05:600c:1f86:b0:490:33b3:4be0 with SMTP id 5b1f17b1804b1-49234127a4dmr40056925e9.20.1781693999653;
        Wed, 17 Jun 2026 03:59:59 -0700 (PDT)
Received: from localhost (p200300f65f47db04bc2080ea3c93ea6d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:bc20:80ea:3c93:ea6d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4922f9cd140sm143803295e9.0.2026.06.17.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:59:58 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:59:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
	Icenowy Zheng <zhengxingda@iscas.ac.cn>, Dave Airlie <airlied@redhat.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
Message-ID: <ajJ93BcJ8wT7NcnG@monoceros>
References: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
 <b13678d8-1159-457a-bcab-ade06bea0cf8@suse.de>
 <bc89deb2-2a2e-41c5-8cd9-28b794020972@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wb7rzchjydq75p5e"
Content-Disposition: inline
In-Reply-To: <bc89deb2-2a2e-41c5-8cd9-28b794020972@suse.de>


--wb7rzchjydq75p5e
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

Hallo Thomas,

On Wed, Jun 17, 2026 at 11:11:32AM +0200, Thomas Zimmermann wrote:
> Am 12.06.26 um 14:10 schrieb Thomas Zimmermann:
> > Hi
> >=20
> > Am 04.05.26 um 17:05 schrieb Uwe Kleine-K=F6nig (The Capable Hub):
> > > The .driver_data member of the various struct pci_device_id arrays we=
re
> > > initialized by list expressions. This isn't easily readable if you're
> > > not into PCI. Using the PCI_DEVICE macro and named initializers is mo=
re
> > > explicit and thus easier to parse. Also skip explicit assignments of 0
> > > (which the compiler then takes care of).
> > >=20
> > > This change doesn't introduce changes to the compiled pci_device_id
> > > arrays. Tested on x86 and arm64.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub)
> > > <u.kleine-koenig@baylibre.com>
> >=20
> > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> >=20
> > I'll merge the patch into drm-misc-next.
>=20
> Merged with a minor change to coding style in gma500.

Ah, you removed spaces from expressions like:

	(long) &cdv_chip_ops

That's fine, thank you.

Best regards
Uwe

--wb7rzchjydq75p5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyfisACgkQj4D7WH0S
/k4IaAf/WKwHqoBZKlZOBFkwYpxmnJKXcyGTkSX1s1Vl6noDw9E+DLSsNl23lLrm
l/HM6dvtSt99bkmVsETfPltX+t1/i7+muGo4o0cTI6DQIME/+XzGrhbc6KH4QRSI
Z/Q17qqeXJ8detwkJ6mt9pO/+IsiD9luh6GuB6cemPxU6DG0mzL8uum5OA7oeU/B
8E8aCTxY15HfmzY7y8+h+WN/kh1KTUiZ/em8fSX/fKNFfJXeIyBQXV0Ht2AtAEsR
dYqDqOsbZhkwK0MCJ2DjDI5uDa0UyKDSpwLTswdzrokmYDYgOzJ19bS8Ywr3kkDA
yv6uzfaQwaQwDUNFmmCHFpSLYDtdKw==
=sh50
-----END PGP SIGNATURE-----

--wb7rzchjydq75p5e--
