Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008354;
	b=vX6f6s3Oot1qfH+D+pLepNtL6oK1g5tuIXi4crUKD3lRQ0IgGXCofGUafIZz+3DSz1tt
	 ROjr+zjK0uRCXuIox9JTzqHPQo2YE7JWeberQzQ7LybqswsiUZ7yyMFYCYEHMrdygO1sb
	 jZqA3VGXdyMMCwootaG304IJ0TutyDAMrq32VrFJVdUM6kjMVmHbnGWVP+8IEAlJMnXqE
	 dbyJsHOT6ExjzF4/1KWBhykXohiV8RBtzIeZzi889Q3Nc9aonSUcc9yCGEK0cImMEdD+Z
	 WcBdE4+3bVhzZbkjowsivdpi8j7pr0GkQGUkHc6hOYlF2HkD47MXW7RUF8sZ3ELl9mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008354;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CzdqD59u22WqzKS12O905ZSnmUXPWnn+F0IvP0hZCLU=;
	b=lO8dvNQ5m+nbqOhQYyjgLN1dXwNb332gjBT2Hnu+mR+WsFxp7WCnN+2xGvWkyHZZJHl7
	 +R7fIHA/C/ivterOO7aHfnKFZXqOUUhAYgnaeL02vXBItEJkqhWxJ+JNRBQ6Xk53IUPRC
	 KnrN81ZBhR5n8bONCbcm1DKWjzXh+a2ucrIy6Qns705Ohv5DygsuEdy6xBZD97NCQyCT2
	 b+kl5fwZJ7yryoiEw0cQUFSckZZR9GMDxibi7YB/p/DjbqcqoV4cR0h4jxSHvnTpgcq5f
	 oJpv/WfshV2TFQnUt4V8IixCw+v5rxexG3Voyi9feViV130y2AWj6H1iLA2U0KA+V4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCe77vbL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07A606A329
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCe77vbL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FD01F031E0;
	Mon, 26 Oct 2026 09:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008354;
	bh=CzdqD59u22WqzKS12O905ZSnmUXPWnn+F0IvP0hZCLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oCe77vbLabzBc/tSUkbWcowGXf0YYjEA/Rv7J3EobHi/UbLR2LCE5uq8L5tqzlaMe
	 ayd8hmldFu3meuzNRhuVoFTprVL0UIVZGbSrU33Hd9H16+nm2YIZW8m2Nc1QLrUsvL
	 2udcsweaci4/DtaHnLnNz7Jg7Crry/J7081HZX7Yr8EdmvqrYf1re0arNyYSI5vgTf
	 0/Pm5BAkavTO8p+j2DemdOdR4205Xve2ZSoMqwVS4QCiqHf3BkDdrz0VPzVSqTN6w5
	 75DXX4OSFB4vPNVKUdh0LSpaZx0lcyMvwFhxyWzgV7DjlYOwVGf2kIlXfVv2NIEYHP
	 orIUHYrIl0lHQ==
Message-ID: <sashiko-outbox-184844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/23] drm/msm/dcp: Add HFI display definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-4-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-4-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:52:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Define the HFI display protocol used to configure the firmware-owned
> display pipeline. DCP does not expose host-visible display registers,
> so DRM state must be represented by display commands and properties.
>=20
> Describe display commands, events, data structures, color-management
> data, and property identifiers consumed by the DCP KMS and command
> layers.
>=20
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D4

