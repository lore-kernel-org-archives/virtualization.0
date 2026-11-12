Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451918;
	b=KEJB/D7xfI7VKUmFQN7spuU/MQ1oH1Leh/golAFRbK+DmWxNzjaIbpwwlAop0evsTvFJ
	 4HCpdk4ZGppEPZuDza+FaZOBYdv4O0V4XEcKn6e/l7/nT+AgThMVeGT/W5qADzv15JV5+
	 LJ9mGcIXKh8Zx/IOSNReAO0bTuInwweX45Ey/nagY2KzKauXM7z5FC4cL6Glxraj32heH
	 T3gAQUsy2mQBKqn1AD2i5+EW3x+T91+/YNmY/zbGuvAiqvxa1lFJbQWFbFh4WOOUsZSla
	 eRuedOhPCAlzboVVW2kaRMnv9VKAJDEwMeKCSSDnJCbD0Ts+MzR/XWp83MLtkBAUAfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451918;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TRP+LOqjwN5yRZSlIPbSkxyuBxT3WGdlMYV5HQ1URrE=;
	b=VqtTKwkTIOxtcTLeEiLvhwuVyDA4x6tp+r3sie33ONGeMeochwO1yO+Z/I0jJlSGmflY
	 Gh3zaXO1y4sivuwqjge2PtI+atZtC1XuVPO2WI94xKboRbhDNDoh07hyvmtr+Nml/NM/d
	 o98R7x9QTUs7zAOwFn5P5vInYrF3RJgt90qTIZXJZ0AIhZvSZByz0IiuqHSdjfFOiI2v0
	 c7OCwzeg7xF9/M7Ky/7dRnHZpiS52YEAQcxc2GgGqvKXKQs9Z6sa3mMW+fb0QAjAtYiy5
	 /FHS1vtnkK+cuBf7QFws6FAunH6vIj6CiJC/jdGgMzBHIxM14Zj5neufxkyYFJFn7WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4OaXr3F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1362606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4OaXr3F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A391F00A05;
	Thu, 12 Nov 2026 02:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451917;
	bh=TRP+LOqjwN5yRZSlIPbSkxyuBxT3WGdlMYV5HQ1URrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H4OaXr3F5LZTGSXw9em5InCi2MFrT8prw0SihDVdz7fWTk+c+afSfiyTifSIR6tmd
	 ADymfyheRY4H7CgUcHByN+MOqd/9Qtz5e+jTuPe7kKNr/rCo39Y1ta8SA6JOadA2gL
	 WHgVIivCRhL3GPUhiL9Yr8dZGhnMTpWD2OfklNAIoPzFYNqyTdnBLRIn3Ivxw/DGgA
	 lPJZh0gQ8UmAwmE02/zRZwS9gdAqrLNDjOWi3IQni7QPisJKqzEj1EZ18xnopK9EvO
	 Srxmtg3F2T14ACfj41Bzz2xpVi3pG13K160Z4U3u7HE3KuKd1bVd6P3Vgbsw7vl9Wt
	 6OT8reaYEoC8A==
Message-ID: <sashiko-outbox-210227@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 14/17] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-15-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-15-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:51:56 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document request-owned capture in the ALSA configuration guide. Describe
> `capture_packed_status` as default-off, reading a packed trailer after
> returned data while the fixed status scatterlist remains the default.
> Describe default-off `capture_pause_restart`: pause uses STOP and
> RELEASE, then resume uses PREPARE and START; disabled mode uses STOP and
> START while retaining the prepared stream.
>=20
> Note that on MMU systems request buffers are vmalloc-backed and
> page-rounded individually. They remain allocated from hw_params through
> hw_free, and capture data is copied into the ALSA ring.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D14

