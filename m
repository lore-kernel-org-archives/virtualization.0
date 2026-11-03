Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701229;
	b=DUP010Ywy9QrhVVL9Y0DdfAnn7218B5ztQ0TTMW+GfWUhc9DE5Sb1wyGpbJ49F6flai9
	 57U7UwWVG3SfBP4IESYyZvEVigOOSBj5XX76EeuU9euX8sAym71TlYkcCqcVIf8lD6bba
	 qpFkQHjicJ7sx3J3tA7mxQRGCMwGoGtfoa81JmabOQxfmG7Uc101sqRY3DO/A33JJ2Znr
	 40MHTHm0O8+YJZlk9wlkfDJZQyy5OrGYxowZ/7hPbnSm+t0K1HjPV8AM55t1M5LnZttRz
	 Auf6fInMaAlgJgdb3jjsbCAxf0TmvZfjxZYPRAbWmSB/8caZSRL+WiJtpr7K4x5j20A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701229;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sa1LzZBFNpBkI+J7Q09YpjJaQ23SK7JyFmU0tWKiPuw=;
	b=TLjqMoFadMf2xOb3wt/ZZPqRMWqKHTrbYljBa9ZWjW0uaVsufV0MWZ3iLYamiYr4jupR
	 NhDnjC0jKpC0Qc7pUVICq0ICWlwiGveLwHn8XFzSGpIO6hJwTW7NKNNuQX5rSog8gSMgK
	 Sw/uGpOApVDhBBLQkm58czK1RQMNFQzKyNjDIBeZ1revVZZ32SnNoAE12LG45jRHB2Wad
	 ef+9J7PhSmm8/VKClcVfVCF4GstAbR51ywtCVW3TKc8xTxgjFPzsJI9UkdUGtcko1jIDq
	 14eRYKHsGUbLuSlqWcmWiEgzJWNnqxMAeUUv8g5FPiGQrs4aCHqcJUSHv1fwqLhjHpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2mEZvad;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE8606BFB7
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2mEZvad
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4031F00A18;
	Tue,  3 Nov 2026 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701228;
	bh=sa1LzZBFNpBkI+J7Q09YpjJaQ23SK7JyFmU0tWKiPuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2mEZvadpK++NN1+lnmd4Xd9HHSYK6KMEUFEhqlDJOYa3LCb3PvVAQFdLPGFuZ0iY
	 fxPe9jTYJfnsoAiIXQUqyOW7grNt0lY7XQgPb6iHESyrJYcdD27kyCoGSOrI8+FCC8
	 K5WgUxL0SGmKlRd/CxjsluJmC/ijowOLDZ6bVYq00c+fZljaV2c0RadK2rbrAG2Kzb
	 lgWl7svnF9ybTxElRdp5VGBKXqOIyVCB2hRJuAhqbGi7EhpupE4fixYZ1XYMir4lJV
	 yLlpkuo8WuXU2Awv9nJBuo9hXijdOx+WaAiryTZofL/T3EzmX+XcfmdC05WHcxtNGN
	 l94HCjf3f5icw==
Message-ID: <sashiko-outbox-195031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-9-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:20:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Staged capture can make readable data available before a complete period
> has elapsed. Skipping notification leaves a blocked reader asleep, while
> using the period-interrupt path for this event can infer a false ring wrap
> when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM time=
r.
> The driver must release its pointer and trigger locks before calling it.
> Existing period notification callers keep their current behavior.
>=20
> Atomic and nonatomic synthetic PCM tests reproduced the missing wakeup
> and false-wrap alternatives. The new helper delivered 64 final frames and
> reported four available frames after delayed partial progress without XRU=
N.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D8

