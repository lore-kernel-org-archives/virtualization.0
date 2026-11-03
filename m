Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724882;
	b=fO8zM8tfFT2I1jC31kxczUVFQWg6lihsgGxai+1lr62Y/OEKAXEHrDeSFl/ADwxFR1bU
	 7MbWpIVaBpLcWeWC22GLG+JMzu8LA0CRgX/aZFS0fnntZdVDLjrYNoKOW/+0yNimKHXQP
	 qjd+QQQLuthYqTjyerDezmbQZUTLFzFzbdZUKjOLf3vF3MkKcXURrC4sXpHH9qdGj1Uho
	 lmXr9b80rVMda9Tucm8hGlmABaxPga3u+VBJ+7TukLJLXUWz17MsQhksOmpY+PTknGX5U
	 egZ+DyfMEnwtm9rhPSHzgScp4E0/LR2fMolHWaxq161sU6SdnTxTqCCItPQcoyJWzjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7iwWMb3ynZ4vW41Y43N4DF/G8PiTwiwru1u0mSb/mks=;
	b=eLwShjonlKtZIEWNWPnyB2wj7CVday/jRH+J2uD8gd6FomCK5gKR+qADnjatcWdBJ0JF
	 CKrBQLCA4v5naubpAGLSE8CBOPncneVlGSeDstC86q9+qK4vIo6ElldLS+0/rjytYo0PF
	 h8IBCX+eQCEHtZX3Jue8JcplcweZlbCk5qLRAqy/hkJqym0KG8914NEnt+minhqkzDW20
	 iQ8LuqbiyK50TpJCwaBjl9FY+Ek1gdKfruOKyHLUSYqD5iQGebeu6bHhBGaEye7/K14Cx
	 FbJNPu5J7253jmbER1AulYdTCZn/GDKlNJwnIZ/NCCGn/7EDnp4SLq3N460U+2AiMEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM53uM15;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF7606A327
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM53uM15
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31ED1F00A15;
	Tue,  3 Nov 2026 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724882;
	bh=7iwWMb3ynZ4vW41Y43N4DF/G8PiTwiwru1u0mSb/mks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PM53uM15vrVCy4iLlvfPi6JZQJqt4hryW0SV1nEmVrnoJnpKyfz6EQJqB1icFk4sw
	 Y10akFKyY1TfGPbwUU3MlSH1NXo72A7S2HMrHssbJ3zY39JCkZvLXqcgR0rn+CEa/k
	 nxgazZAmP9GJAxajUGlG0plpmyAaK8Eo6pTmOkwrVtudNdpXiaGpaUqRcoN9T43wgH
	 clndEb/0ju4WtnMR+wTap9OxHOZh3oDLQYq6ThCfzEJzDKgNn6oGQXDULstOtC/UVQ
	 279qtXe9VP8YhDaPPfKJfxC9TH7M3e0zyGwqvSGsWD9YTptYEUZjA6ymbE8SBbHh5d
	 /pxPEnwsZjdhQ==
Message-ID: <sashiko-outbox-195754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] hwrng: virtio - simplify probe_common()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103165026.454333-3-blum@kernel.org>
References: <20261103165026.454333-3-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:54:41 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Drop the redundant NULL initialization since vi is immediately
> reassigned. Drop the redundant index variable and use vi->index
> directly. Also call ida_free() directly and consolidate the error
> cleanup paths.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103165026.4543=
33-3-blum@kernel.org?part=3D1

