Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702B262816
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551951; cv=none; b=bKbbs6hcobQYOoJUeu4TZd6Hn/LxxxbBtozsZv8RNhBy9gNPS+OIQ9DKSkFicIrJ48XucU1jYDeMzxtyxWNdY1HsJEz2ZT/pggKZhzEsS5x/cFMvYPPoXz1w9xl5rmcHM9BfS6PHO7kAL7vPKxj4Pv5fKKrQKjvHL5ivk22YCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551951; c=relaxed/simple;
	bh=VbDQ0g74dQz0V/XJPOvsPF6QUb1grANjG52ukItI0yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X64qf5svsUn7hlFnlI5CEUGDFwJSbhKGWj406fsGPTqSzFNmbjei4pCY45e0WTaiKUNZ1KgRcM00REElt7SZSbrfP/zURyCQm/epiTy3M+gINAKW4tFyyOEO55vEkTx/9LGdsb3Xu/MOvBE7xMl5XoxXEOdhJHnR4WrclXYb008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O41tLOx5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O41tLOx5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4396424d173so20703735e9.0
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 08:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739551947; x=1740156747; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DRPEzhgN5fblYnXVk5o/xaVvZgb7XEJP2riyaqwicb4=;
        b=O41tLOx5jfwky+LkMNluITs2RusjvjtQeHCBW6PWhJDjUkMIWNkZhcphhAsENZszJV
         J7eHZfQm9icEARSzxKqonz+oB8zDROKMTLhP+WpM5uy0sO31D+pWwnAG56bTAIi2p/9r
         aGED6jPRrCVkxVvfMKkdVRA/US7HMyWSWyvM+Sl8TEp7W1g6KGN3iS8Jn1Ldb++S96ir
         g2w0LY7OJAz+l2+tOecJzBuzftZMm02B7mT2hB/ak/QmGdOFDsCPiQAB5LeXqZeA81xi
         B3OX6X5tProm+bLnI0zkZ/qK1yNgs+BS6Pybb1kELzrH+3POHsqkqgbopyevoLTFFCVZ
         Zu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551947; x=1740156747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRPEzhgN5fblYnXVk5o/xaVvZgb7XEJP2riyaqwicb4=;
        b=SQVY3nadLtdYRpwtYuk1gZLPH8ZpIfz/7zMveaF3pYBWc/rttzYXLL+u93Jq5fEDXE
         oKprdt7ecgGplFIPpwqV6Mna2zuciZEjXpmkoYtWwG61VEtqYxeWTDCYreEdL7sXg1f1
         nT59DducXUDj8iSLiYwCsufGTzTRFSAyDZZIITHrEF5/4rEavYQhIXrh3mIc5vCdCrCf
         0r5ndPGiQGlue4+ZplxSu0GL6PZr2OkXh/0VWC2Zs89drfSvYCor+bfxCBpbiwC5fKGL
         MMrT1sCvQgCA3EHwf6QtGHq+QMNYtS0v7VShcfgDf8+sXzlMKaW/Hzd3c1+fNgfjFD2U
         Lg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpOzs6IGMxD2z48zUMM/iHrVX+pPEg3ekh7Geb3EIJyxByx/jVHugtLOLvkQZHc7J6oT1xKGGJy/Wl/CF7og==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+nWB/WGomq0onFpf6IO5g2G6F6V0nhWZZehbClJbziJidCJba
	i26ljo8A3lnuuWeYP9hUjACuZDyucS6tF7ssNOELUazFlwd5IK8nEp4UGHJZ8Eg=
X-Gm-Gg: ASbGncuxvj/Vc8J2yfV92YIaHFaSXw/3ZSaZ10HHKc07ud7uQfz5dCnRlPcNu+uN6MX
	8yRne9EHA2V9W8XZnCNwtXTbNiBOo+vg4X3dfj8Osqavd0NOl0WlYUYbFSAVnUrtDXSNRCa9R6T
	9oC1UOk5NVFq4N007ls0gX3NMOOxsarxtmkKpt/DOKvF6XTBncnKQ2LkdUCaa7Xm3ZLYqNwf0nJ
	VBRURnmhYIQ0vaTy7StGEhUhC4fjdMU/Q5xQhpzl6xi6Ud4oifHRVwpf9LRjYOP29fgKz87D56G
	Qlpu9rkA2VQcJOKW20EGSupoDiAeyy4EKcN69A/y+rIEtCtAbTQw+zCWeA==
X-Google-Smtp-Source: AGHT+IFlZ2HKkRaK0EiyTmZxzbqyF2rSBQprGvb5jO0yOIa4i2P7+/m344v7o5cegCF4JTNdYGdVXg==
X-Received: by 2002:a05:600c:4747:b0:439:55fc:81ad with SMTP id 5b1f17b1804b1-4396018a596mr128534855e9.7.1739551947491;
        Fri, 14 Feb 2025 08:52:27 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396180f231sm48709735e9.16.2025.02.14.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:52:26 -0800 (PST)
Date: Fri, 14 Feb 2025 17:52:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <dard24qyuwm6plnswtz4to36w3fynb553aohf5i7u4ln37nhbk@pgrvhqwvwuzp>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
 <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
 <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lhfwkzmwoz5vwon7"
Content-Disposition: inline
In-Reply-To: <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>


--lhfwkzmwoz5vwon7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

Hello Amit,

On Fri, Feb 14, 2025 at 05:37:52PM +0100, Amit Shah wrote:
> I'm thinking of the two combinations of interest: REMOTEPROC=m,
> VIRTIO_CONSOLE can be y or m.  Say virtcons_probe() happens when the
> remoteproc module isn't yet loaded.  Even after later loading
> remoteproc, virtio console won't do anything interesting with
> remoteproc.

Where does the interesting thing happen if remoteproc is already loaded
at that time? I'm not seeing anything interesting in that case either
...

Best regards
Uwe

--lhfwkzmwoz5vwon7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmevdMYACgkQj4D7WH0S
/k5yVAf+PF3RJJb1sSpvLml9FywSM8U8FkRyUD8w55iTwpy54G0CUm2SH0L/o42n
gqND5Dss7+vEz2Hm8SbqNXiK1bdTwX25d8eqQnprlROdLDJaho5pEMNd5EXLrmFb
grRpF2dYTmXA/gtsCnSsS8EknB/bQxfS9b9mZ1wH9daYlzoi1Ypdcke75+1q+GcG
XAt+n97SCjMXFd8xIvBmYPQwflHuLrWiClNu8lyR3CAv2G6E5iu/3ne0hhYZC6xj
BrW6pLSSCfNHqQacsa1yRaT03CGaI9oqT3Nw3oi9OFeaFoF4QPYGFfXta4jgPIUD
WVRZL/M56BGD7n17nBeu3IrSKqSzZQ==
=S2mE
-----END PGP SIGNATURE-----

--lhfwkzmwoz5vwon7--
