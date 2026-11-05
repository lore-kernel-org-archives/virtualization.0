Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837825;
	b=1Q1UlXSF95H837aLEZR/RjRXL0rZtqT8S9QY4ztsp0kuXaGKFZlyJUj/hLM3/Qe2wqwU
	 wDIeKdsaZ1R8UHvl8LVP+iox71ytbEAK+q2VtRUaH2X0OY6XN/WL0OJX0o6eJobX7wjw3
	 +lZU2L9d/NiwvN8DFda+WVPES9AFd4bk7zdiTGJp6LqgbADISvOgCsEJZUrgwYitDZ3Ch
	 VB5NkmzvKUS9wt9Qn71e10UD5Ng6ZTAFlp4yGCX440q6mV+uI+nWmcozO3Z+mNhfaGdiJ
	 9x3g8Y1GJO4ZWIy2UZG2c2ao2So4PCeO7fjh6o4kz1owiZQeqspeZNqM9PBI2U3diCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837825;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oakFp6XmzXbH4MMbY9tkopCAkofWEZzWL8ZajDn2/fs=;
	b=QG/09Ns0IqK5BNnL3Wv/zMnoho8swMGFw8RXz+ckMViBjAzWqzhClIXZxt09ujN4fTWV
	 CQb3meT7HxgnrfI81n0Gj7pXjJdkonYe8ReuJqTAT+vjCRoiqUJ+GccyGEt4cWPOk3AIN
	 myMzZxWD1LuZEJfwN0YtL5uwkp12gsekSQ/dZulWKaYdim+AyDB/YuOGNspegPP+Uph87
	 COlnfRM+woJj8Wf50LNCS1/Oza2kCZBOPZRnI119j68MK0IRsxYlvVx6S1s8J8gg4+M2z
	 1lWFFfb6fVK++NeXauoirWW/fJCCBCgQrpqltsnUIwHu61X7U9jSx63b7EXyHs5mVkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jB30MHV1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E81606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jB30MHV1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA9A1F000C1;
	Thu,  5 Nov 2026 00:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837825;
	bh=oakFp6XmzXbH4MMbY9tkopCAkofWEZzWL8ZajDn2/fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jB30MHV1QqqLgnQv2w98BavFNvtgzUgOJAQfFpYeSm3LQIFy1OHXbTrWnanG7gTWm
	 grVnp1xUa/047f9a99ow/I5+WfchsYHmLCnywMAfgVEeBf6HJYw+yBA/nhOhglO99w
	 MKD0tHHBzlXaUjytsMipA+umXVHMYLGTwpic1EUdkn+kzlRr8UTJJfd0bJ6QTPQWgH
	 FSVFI/X2UknYkDdKL7eS0R5TWkWdhAMjKdgxQ4M3jug8fMqEg9QCGyGBVVSwb00evN
	 ekCO7KaCulOqM3b8u6ovUT1NVtRILr17Uqk/ZFVq1YUiKmhlgfWEH9GlJ9oF8AStgh
	 3G6vOHdujM6DQ==
Message-ID: <sashiko-outbox-198340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 12/12] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-13-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:17:04 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State that
> capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D12

