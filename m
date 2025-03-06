Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6A26E639;
	Thu,  6 Mar 2025 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289201; cv=none; b=G8yUilEHPJNX3NgB8ftBGxrDMRWCvU0etupPK+6Lf1Rs+h8E9b5KsLD26BSQzceVuKTurxXJWfZqo/INle5lpET1AWxeIsWPpH1Qatac4axfb+snBvb6Gu7UOaM7WxpbQ7g+5fbszb+ljEi3QetCxCsSuWjV6jIvpAGMGDsph24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289201; c=relaxed/simple;
	bh=TYNF5uSYA4qLy4+0N6piNIXODyphiWdbD9W6y3Or87U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVrgnweYfy5WDzrVT/GpRZfh8KaaIk6XsMHnHQhwC/4qixo1kWurzftzWlVmp3xt6vpv1JcMKSofJKHCs7xDIkY1rYgF3yuZIzUOZ1mUPS1AdB97rlSqiOIE7HpIzt7IRJSXi9AFF4iZtyIjYyQbilCSrSKqZjUXB9Jxr3JO6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctJ1zHO3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctJ1zHO3"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2f391864so647945f8f.3;
        Thu, 06 Mar 2025 11:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289198; x=1741893998; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNcfgkruRbdQ2LTcDlb82l2rtv263h9UvbuoZgmPSdM=;
        b=ctJ1zHO3fQ/fA/HO1UswN5wc69n2qhcTDDxQeWaQFrq4Qk58wxh/akN23Oe6mwRqZZ
         HwiSeCBrsXh9cdX9jw4gAzW5ETTVhs59j5EB+FcP/z34kp7THIUmX/gYVKbnP/2qU1UF
         lfMpF3/U5bZBPuOnGM2N8wLGdYkJ3xcDD8soJbvKXSxTJSDUlgjfmW9cLynEZJi+uX9u
         MtP1yR0loHvEcnzLLGcJHMvukpQZ2NUatF6W6HQ+PggkjZCeJr0MTQL67rUS1YQ26NcS
         IhJULhKmTUt75+frJwhDIHfHi8lQdUXLYMhSYbfKkVRCqR+yQKW4KRabC87UfwDz2w/m
         kuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289198; x=1741893998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNcfgkruRbdQ2LTcDlb82l2rtv263h9UvbuoZgmPSdM=;
        b=cMrDNqN6/ZkeyTpHmKs1Dt5Iy+3XUUr25pGEiZFrFlOy5Fuachf1HmSBc2jTEZAVSr
         A+aW5CDrUWd1PNN5FPwGb8wOlu7M//3AztnZBgheMXpw6DNBxWONgsACGwpHSr81785f
         SVsDYbf0ACcUqHcTtak5etUCSSPfRdaRMSOKM/nb4DruU352J4tH63lEdtb3lhSwnd5/
         LJGA14oacxMpVqAGnkkVFMWuLAE4K2hIThTWeBa2GNSfR7VzyB1e0PxWuHS6Lm2u72Ib
         oWTk1KdfJU6x4LI1K548WaGakOrtJz76zNCI30n2YOKmmGMjfCL4klwtKk6XsrszAXKf
         M/2g==
X-Forwarded-Encrypted: i=1; AJvYcCWKHJExyPoGGiRqjwOpbeoHeKpmpwDXCqJ/e8z0eWjfmKP3LPurpyVCRd1Na5WEDWkdsQs=@lists.linux.dev, AJvYcCXFwhZOan5AkY+DiCJPsoaPsGCIvsGdpSe/0BsPPNe67Cq5VbnnymA3yyjs8IXGO7pYJLYRl7qtQcYMihLUtDM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxw5aiwy1zA8lnV5SYyeZXsDDhQ8o2c32Oy//MQOzMFCEw7mk32
	CJ/k/tlo4diVJ4F0be98/KCD2DHcJzg1nblgofSTvF16EXH10+7+
X-Gm-Gg: ASbGnctWPo/9N38fhyeVnVj9GaHr6Xt/OupnpeNDel8/drmlK2VoFaOXjmhefYnfv+p
	cQ54jEdizW5l7G9WMjhfGKamBzd8+MMBcsn6PrbcIyDHHMOs3/0H+J+3WDMiYEs85hNLnxAuuBf
	ox7eUMRtTnwecNQupHGwxS8zch3AeG9/yHJLNQNg7WHG1mHrtHCT23lGtJsGloo1gg+ULjjwtmR
	aIW2/DlkU5gg1Fmy/qdttkWXUFa6q56kVRO0Jb/AwQZJB92NvmNDYx/sdmjaXelIiOZozSXe+Qs
	xudjzuepSh3Pdlil1mUO/bAesy4DsNS59YQK61xJeWa9B2jCjlvQ11YFxFpeO77D9JVq4y+W1B/
	AbBvyKauqxLzFAvLVHycvbNSeInNNmb8=
X-Google-Smtp-Source: AGHT+IGse2HrwvQit3ez+Tb+IZmcWPgul6Oz1Of3MncB8IKv5GiNEYehZwUGHa/gmdRGfttFwUyGrw==
X-Received: by 2002:a5d:5f45:0:b0:390:eebc:6f32 with SMTP id ffacd0b85a97d-39132da8fecmr291664f8f.48.1741289198054;
        Thu, 06 Mar 2025 11:26:38 -0800 (PST)
Received: from orome (p200300e41f3a9f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3a:9f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e1d67sm2905872f8f.74.2025.03.06.11.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:26:36 -0800 (PST)
Date: Thu, 6 Mar 2025 20:26:33 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	imx@lists.linux.dev, linux-samsung-soc@vger.kernel.org, nouveau@lists.freedesktop.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, 
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 20/25] drm/tegra: Compute dumb-buffer sizes with
 drm_mode_size_dumb()
Message-ID: <mtsi7lohn4nq75y3mdzk7eomloxvswjn4blsmruutpejhppd5i@wexuiu7yfea3>
References: <20250218142542.438557-1-tzimmermann@suse.de>
 <20250218142542.438557-21-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y6cp6aqkj6w24xiu"
Content-Disposition: inline
In-Reply-To: <20250218142542.438557-21-tzimmermann@suse.de>


--y6cp6aqkj6w24xiu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 20/25] drm/tegra: Compute dumb-buffer sizes with
 drm_mode_size_dumb()
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 03:23:43PM +0100, Thomas Zimmermann wrote:
> Call drm_mode_size_dumb() to compute dumb-buffer scanline pitch and
> buffer size. Align the pitch according to hardware requirements.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/drm/tegra/gem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--y6cp6aqkj6w24xiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfJ9ukACgkQ3SOs138+
s6GThw/9F553EWmmWz8ONopI5pY7Fy+Pu8kzqsU5bhKSKO2aqJ8y4PFOQAzaacO8
2HuvhLXsP6l91B+R49oebJTWnbgcl9ThzcA4njgdKRFc7yZU/EZUEUGdwDkU6qsh
/rkDnM+a+MzIAd3Z31B0Kvb0tUsl4e0UBueDHmjfP554dbtnMr94eIHuqLVRb1/D
LB6ddm8DbZVoDKT9Ji2gLQpW84oFuIzRZPOV8JmPe+wE8Xf6A9sLloqJndErnvHg
B8X2K8PzxkNNJGaZtQMUpiJ+S1oDNZnnKtzt0Wb+b9itJqUgykve29vGBDBImsb5
8JLFlkdPFdKpFsbAvGyHv8b+F2rDVu4Oelg88WWDUSMc9Ut274u5/a2DTUOwF806
DtCADAFUOOcIyDZKfPpeQuWDPeScN3/ANW8iQMlyPaNO5fBKlisFjiF1Bh0gS+vQ
shkKb74wChg/4jgq1+M+I4DPdCQRe0kGIqbNZ4yK71owOjoSE6WIxxEt0UUKxPwh
XZyf8ZF2O9TCPMigN6Qw2AGUhaC3HsAG9KbhOTSeUAsOwohFtYY+3B6Hkb8SQHEM
i05OutqXEhtdSZgBK+HuweZtYWCBfy/BcMeD99Rkg01C+aMZcNPGVLpvGqpryNaB
Ga0hQwFdIjbnMbXxjzyfJfs7GqNyTAJtpiqBO3uDhWH2LxJHZ7M=
=2m1E
-----END PGP SIGNATURE-----

--y6cp6aqkj6w24xiu--
