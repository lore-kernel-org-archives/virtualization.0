Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914017;
	b=BeGIOwG07+4AzjdSrIValtoPjiTICwz68ZLin40jD1FfRRWPPceLJk84skUBWVSe6zmP
	 aDrZZT+6WKtpg9GwgNMWhXTBeMZTKCMVxcw/YqBjAFl6xFLPyue3K5J/grTks6RAqEwau
	 rduPskxl8BHQVU4mz2PKPBp/5qH1GoL/0PekdKE/ETzSo39C1tXVzpfB6eq1eOnkkopWc
	 RyNGJUHxFA3iyL8x0ODQad0y0j0XUBpMnYfJwNXs7drl6vr+Rb6A6ylkMbwUPu8xxiBwK
	 Iq/yxYlc2etuVq11nvs9BU28M0ybbKxKB/K8+QbFno3U5ew2y20cODvBVT+FM/XHxFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914017;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zF1WwzQG6j/x8GqNJnPHlKh/icMKUoaZFzHBysqm9pc=;
	b=JQRUPkfnixxZxjfo2Qc4PLieCYl494UecpIc/VJ1MFZ15SdL5/L4jF045aQ1VTeqsuLG
	 eHFRg8Fn2k5PBkz0b2kLrd92uZcmnBg6xHScvYOjJM7O6W27A8R4cLFGk4+Ckhif7cX+c
	 UDV6Om5780eD3TWcPiYDmCksPqcf23Bxz2RWsqPBbZuqiMlAPZo9i3Jm9FEGIN2Vj8iX9
	 rjzpwGEQ0jzUyyyHa1Ngtb56JV2jgw8qef7PIoRg76LDbAWAoSw6jiG2gvVTcZLs2LWyh
	 C1QDOzkyQ8XHphVA7laNfPZ8AtEFOdj3sG60pqogkCsgFKvy502usMYJTpMPCUiixXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrrEZIze;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2D606A334
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nrrEZIze
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2981F0089F;
	Thu,  5 Nov 2026 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914016;
	bh=zF1WwzQG6j/x8GqNJnPHlKh/icMKUoaZFzHBysqm9pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrrEZIzev+1H/YepTUEjJiWPEu1InJoYmJIAgkt1gR+ovHj/7h3Osmo3e7lrzAHR+
	 A7PmJwxMzw5DON0Ngw6IGL2enaCZI+uz8Ltvbfagx7rROpz9hedOYrleWKwqp3LsaP
	 QX4HuCjNMY5bs32RA97D3KCj44z69eH4rRmUW1zZPgjZg2gfiFU19FmbJQrntYHhza
	 j6SOrlZh4cDhVmRhuZL4ElVoV3Q0fSP8GhX4RA40P1aIpp3Z5bsU6zgfq5WTi4VZLc
	 jZUfNeDSJof1OqRPbpJ0QQFf2W8T/5+PJFCrcMzA1hCxnSQnzUCURII6SgIL0iqQXT
	 rkvzfDgVLa2bQ==
Message-ID: <sashiko-outbox-200225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 62/83] drm/cirrus-qemu: Switch to
 drm_mode_config_create_initial_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-62-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-62-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:26:56 +0000
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
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D62

