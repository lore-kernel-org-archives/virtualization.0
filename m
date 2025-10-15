Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8D1326D4B
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529873; cv=none; b=NgKwyL6q+O6i+mk9XARFDq5AgaeE8HzHBCr076TVbVjeiX2vNvKJgfavCZxG0iElWYyqAVzSL4Q1/1nWpp9WLTcSbxTjBnr3gJd7p7u0UqKug3xo0apdtsC3BPGI0IrYDc2OnL7TpntrNW9zQlxCVYathUCpjVYyLSF4u3LogqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529873; c=relaxed/simple;
	bh=yIkDzOp9lOkC64phyHj+bKX1qlxxtXvg/X9w367rNpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzaWZLPZ5QoQm4nE/PF8tQkCdtjvxpa691+WF0krrMXAQj/JeQhC1aywCMJdKa1y7LR+04DCHiBEMa0O4dEigDoLavY7qcuOf6zOdRmmj/ZyG9FlJlnsIe5c83WkbwsdGUm7Bs3QqQFsMTrkz4+Eu4PKzPsAurXyOmpr4d/txhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=gb/8Gc4L; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="gb/8Gc4L"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-87808473c3bso1176155785a.1
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1760529871; x=1761134671; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIkDzOp9lOkC64phyHj+bKX1qlxxtXvg/X9w367rNpc=;
        b=gb/8Gc4LgxTo1ejjPFvBXi/f46Fvoja6LzDik8YtOp1mUBqvJ3twj/uM21NWw1M9da
         BRZyueTIMznGjyrcvEpXARC8neHkMdzaqyw6bZE2NbWoFNBWz3QCiO6MPx1pnsVbOR6h
         bKhZEzGCSomqK3V/RgjLS2NWiJuQeG4I9UKRWa6JEJzhEGU0pg8I71HKpd+JRWf99nMI
         ojtYmWJ9aLGqZq3IRNflvP0PS85MMHflmSMX9jIXcxOpLKelHu3i71wsxjta6ffWSZLb
         ZEox8ZYukGXM/10jVTtp+ffyJBfHKjrX+5gRqIoWQyMSm6s5E7UhswMsPG8zTNLphdwv
         +/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529871; x=1761134671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIkDzOp9lOkC64phyHj+bKX1qlxxtXvg/X9w367rNpc=;
        b=OLuk7+4NsNOn3ih/WL8DojiWiAnckhaa6MHzxgT/siF2YSpOp31LImLXJ6lsrFMGH2
         Hj182QMxvm5T4fRH5lGK3niOultD5zN4dGHtLg2TBMjuYoeSxVyp9RXdKz5udw/sA2+W
         YyrCgbHzTuC4QKSxyxw9TdXIuFrlVvq/J2XYKgeTOy/knv+ghiKXLJuAps0eP1idyc2D
         Vebqc6v+UYvxh02IwyWgmAoc1My5eM72b9x1NOKZYnp6adYArj2mdxg1WIAuxM1GNlnh
         iwQTpbhUbv5nU7j0sLyi9yrjFjjXQvapR4Dfm0rLqAYtiZ+7Zet0xQXWlU4jO2aSyWp3
         LbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV671fqW2eYmb4sefHjPPdDKoOCDDJKs4x4Hmq8wk9ZLAun36McuRh+brMnjebBQzcZYRbPMcLb3vCFbt96Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBas4cgsOmXEwuRCUr4x84p0ZzN0cEq2KA2kTKlYKTn1DIEsAU
	f+TKkcICmiEpw+hPVrjOB8GDrLjM18Ue8CfKlhzW1y+mUtw0NZKkO63EyHTKbct2bU2onge3vH1
	OPPVrxomo/aFDRsPa4H+umcDeSwdxiyDqCVprXfHHNQ==
X-Gm-Gg: ASbGnctPK5KRykzjw7H/TFLAyKdgTwNnGPe4OfInJOxLxNYtPUPrcGWUK2iE9VsCmxZ
	PE9uJlBWKVGAKycjCPjCYCLSnsSUPlqDqLovqUP4wI/K6KkdGVaWhUe6seDNArUzhRYHPf6JezR
	Jv0VR0kwuZy7gVzp8S+FRjUoxirG+NuUTjrVFZ1zkQdAAnv0f0N2A+P7PN+CAXH4CaV5xicuUeU
	eDH8M95SSPT8zUkl676+sUgK/oDseXQqg==
X-Google-Smtp-Source: AGHT+IGsy4ghNUujV8ICs5xCd3l4JFRIFi1WBGAyKhaZaEA9CMFYjjgZCN0vS1WL/9stf48sqTR9sa0kj6mJ0PU2Rkg=
X-Received: by 2002:a05:620a:800b:b0:85b:5fdf:69ef with SMTP id
 af79cd13be357-883524cb7c1mr3776426285a.30.1760529870781; Wed, 15 Oct 2025
 05:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251013060212.14583-1-vignesh.raman@collabora.com>
In-Reply-To: <20251013060212.14583-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 15 Oct 2025 13:04:18 +0100
X-Gm-Features: AS18NWBrg_BqO2tS4RN_x8d2btqMDE8us2R2sNEBkP2IYKjicDOGCIjh3Jp7IkM
Message-ID: <CAPj87rPDppYBRuQ99mh=VqrsSErGKcw-ZRY+zPuGrDj77G5k6Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: disable broken MR check in sanity job
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	lumag@kernel.org, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vignesh,

On Mon, 13 Oct 2025 at 07:02, Vignesh Raman <vignesh.raman@collabora.com> w=
rote:
> GitLab recently changed the required permissions for the
> are-developers-allowed-to-push-to-my-MR check:
> https://gitlab.freedesktop.org/freedesktop/ci-templates/-/issues/81
>
> Until that=E2=80=99s resolved, disable the check - it=E2=80=99s mostly ob=
solete anyway.
>
> Based on https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37782

Thanks for fixing this.

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
