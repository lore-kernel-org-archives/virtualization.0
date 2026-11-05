Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913936;
	b=01bKNMYg5RZoCL4rwRgFLUdHYinV5fD7IIeHWZVju9rlw1tR1HbE+bjcJgdihBwQ8/tO
	 b92R/Dlbj+JTFMIOgFbweHpSaWID/QdJ3i1CU1zaOIO7oxWER7UTtwKaUqNXQSDvPePZb
	 fF760r8h2z3VYAQNf8bonSRjQdojVGQl5XJaTypo1NATIva/Sp/PVdRVa6xVH02EXZYwE
	 9wXZ/t9Kev4WZNcZduTYIagTRx0LY3X16s0wPK28bysLFwmbTcFmPC4KiCPE+G/C6zjkO
	 U/TiBcK7l+QmhDyqfbaFCVEVvoJZkPNqLpr2Q+3eH5ADXxytMpIaqOHrKwtjVHgadqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913936;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r+q7dKY3xO2HFUtlSY8lStxJBToJ2l1YsihqprMXeKI=;
	b=i71aNVfUAMbMO74/1dG1k/pQ4y5PFqGSuYEdFPRQV/qPRQO6cVV7jNcVlVeTjh2WvbSs
	 z6vYV4l/OmPXD6bgycvG+Ikv9FcyFja2NnHjl/JTu1nvhSD4MYQDPRcWOm8CYamY8BCro
	 HGfNgJKs2RFClPnqXK49HGHfGl41NOs+Y72RFJ88ckSf7JpzXs0EIw9cw2JNSc7sXgP6v
	 p9FmUuikIRNC/TPAwSBVMO4pFGeW8S7WpXVm/jaqZdulSzHWmZwfRlyT4m3TMqkdUfaoR
	 71w1B334Av7u5NYamKmDYt9wiaaQHuJb404SknzdSymL6HMYjxy2gbYQk+/VvWrEFnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2pD3fgB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B28606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2pD3fgB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACA31F0089F;
	Thu,  5 Nov 2026 21:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913935;
	bh=r+q7dKY3xO2HFUtlSY8lStxJBToJ2l1YsihqprMXeKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2pD3fgBzyh0n02BvGAwgDNfNHWnl7QU8Hf/53ulF1RkK4aVogLV8pERmNCG5vLkz
	 t3A9LWJiIx1llA3wQe+5TyBLEpGxDJEMy8BToa/8v79x7IrOilXTTIrE5kBwOhOx/n
	 jUqqJYbOs+He2pVLHx6bHT/2rmhZkdwQU7UL7S/IYkf5RPzNAeQzrX0HufK9NMi1kg
	 4zx9KCXrSxTP6eNHd1O5+O3sktr0BnXIhwi0X+g7gqT5uH502ub7CK16X/dGstSHPb
	 1CWQXUQ4z+LRgTfBWMEK9uV6MezWEhgDPrq9tkd9DpDnW1l+34GwiJ86nNk1rrPEvl
	 e5RSlne/rABNQ==
Message-ID: <sashiko-outbox-200223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 61/83] drm/bochs: Switch to
 drm_mode_config_create_initial_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-61-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-61-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:25:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>=20
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>=20
> Switch to drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D61

