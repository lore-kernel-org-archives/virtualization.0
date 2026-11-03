Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690823;
	b=BwQPsqQxW5BsxYRrjWxJ7uUnmI+ad9YUEodVT3YU4n920IqZwb/HQvEAJAjrWy1kxocJ
	 K7+dHbDQrRoQEvcBRR0Bd4ugbEtl3fyA9yDho7+O4MWjoC8lyktQt9uFui095QvYKX+//
	 aPaRj2qtS3ZreLKMuuEVw1aYx+ucqGQOXFHntb7vfHXfxSmwn9Wv9FrET85t8GlrnJYuZ
	 JBGOARotSiGR+dNhOarQq4u0GTeGbuWCSw1q5rX9ZwmT1NK3ObiGYHM3T7EPE78GBo+mo
	 9IzB8Vr5Ht7FtToYPpY/ECmCikXuQYHbGrfXkKMRCNJMgEnZ+23p+2gEBdFNCXsEYew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690823;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4o22mHhcctzJTVQyut80krUT4gSGQENsCqnY6rDcYns=;
	b=Z4RtI129uglGm2uD9ccl3qgrxXNUSpS3y4ToJp2U8Hy+se3noOS5nonTAscYRmkcwwuR
	 D/t8tvarQiCicCv5xRgebEuTr+hIoDM3etOetIOWMswvMiSjHsW7mYPTLSPNR+KGb6RmA
	 AawooG56zhp+xSuYDfmo1v1oZ93N89R+HuHnLaZgxSMQELpYbgQO+Bsze3xX9bkEJkCyG
	 L9LUnUJYiGOxjGcmGGTUkY5h357OemZE+zYupxwmjQNqgBq42jVMoslukU6V7tmuRlvc7
	 CvVoCKm+nItfEgQGIw8xhEdu7tilhaxf8wv3JzICmGBq2Yhb4aqv8prMnfpg/HP4TnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzs+Lu8d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5E606A32F
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzs+Lu8d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3AA1F00A16;
	Tue,  3 Nov 2026 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690822;
	bh=4o22mHhcctzJTVQyut80krUT4gSGQENsCqnY6rDcYns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzs+Lu8dXRmleLBgXL1p6wGlBPGIL/eMdrpdiTFADFVzHAPDbxaIiSB+92Wbwz3Wb
	 /egwm5M2mshyUjQSwgvUL7Wfssi3uWDnlzfGcG0/TL1Bc5HERkqHKbsGK9UD0cUvjv
	 /pcT5XUrVVwNPCJsURBYyax/ekCKJA/N6DgfFgcaWrFtpYZgSwsv4Fhp0UEdsKmx4y
	 MzLikr3DeFd4CtmB5ACnAgfBOPH6OrQgbsIsD2bSxWv/He5h0mJG8hcZ8tweyCOd3X
	 qdkLqIRVvsb0urzPbeZUMqOkx/cTPVSaNrH5MK2NuHiExMcyAu/hjGnl8ZU6XvW1x4
	 hNgn0UzB8r0YQ==
Message-ID: <sashiko-outbox-194711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] x86/cpufeatures: Remove unused VMware hypercall
 feature bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <c8e57b19d95fd8ffbfd13e7ab1c1ade551b1bd7b.1793685318.git.zack.rusin@broadcom.com>
References: <cover.1793685318.git.zack.rusin@broadcom.com>
 <c8e57b19d95fd8ffbfd13e7ab1c1ade551b1bd7b.1793685318.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:27:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The static-call conversion removed the alternative instruction templates
> that used X86_FEATURE_VMCALL and X86_FEATURE_VMW_VMMCALL. Their remaining
> users only force the bits during VMware setup; no code tests either bit.
>=20
> Remove the forced capabilities and mark both positions free in the kernel
> header. Neither feature has a cpuinfo name, so this changes no
> userspace-visible flag.
>=20
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793685318.gi=
t.zack.rusin@broadcom.com?part=3D3

