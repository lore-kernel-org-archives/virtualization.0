Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862774;
	b=Ti3xzyBAD0+NFAm1YCwP6DULUXZRA55Dd/wYoxUEEfjncklfqyt0TgSgCijggn2yj7qn
	 loKyTMMpASMck0Gc62TC/R+kQsoPW+qn+B9fzPEJCyNyU9laC63dRXpQMh/3ougMQAjLJ
	 FfS0xpW0/cAPUkw0ikly4wljVO46hC5wM4V6DYXxhT3qzf8IfVyatKlgvtasvJyzrMlMF
	 +grqeGtHMHTskiWnv1kYXk4unAzfectWGrI7/gsWsjfky3kc+c0lNqgfsE6dtgdm2iuXB
	 S5fa/Mz0qcmhl+FUGrSMxE8vxIS5bxElsnOOS8rhx/ssObwefxWtN5wnwzuzHunAzTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862774;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g1E52IxMoCpYMDvDkieINesBU+M2FyulhJlRKE7lO5A=;
	b=136ezTX5CpJMABcr+A0gldeXKqzXdHNwdPV507HXKtK+Y8jJjcsuJ4xKaxW8Whh3v6Vt
	 bVNn3RvwgcjxNuaQAyN7HfcW0Dg3Ssz3m2nGjefG46jQVL7PzggeyqTlXC5OFgkdzmsoG
	 7DFi19idEo05drLPm2v5IObw93A3Secvp1kyM3uXbmRoW+REKZ48QmGV+NRriaWK1XYL1
	 tXHK30SpWyxklUNHSUe6W8rnXvD2qZ+yv3sBAteokuGKxVY7r39EqrzlENAQCNXHMW2bD
	 Vmd32R8Q6SJtvPZEXBY+8JekzQyB6LJC5uyBq5gfx7WfQzslnP0HsdLsoVPVol4PFNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEd70is+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB2606A331
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEd70is+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6D41F000C1;
	Thu,  5 Nov 2026 07:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793862773;
	bh=g1E52IxMoCpYMDvDkieINesBU+M2FyulhJlRKE7lO5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEd70is+W8Yv9L56b84kxJ6P+BD/4pcxjobane8oPS5twr6WA6enn7AsbzSPOGgg5
	 9a8bQm2KiH5wOXHpF5TZ4oIt1a+MFo6IG+PJ56Yv3L/13erPlk3KwEUjLEzzb7RlLU
	 k+bzJAhhKLCqNVEK0ye5gPo8XfdbCHEmZBkr6ts2330ZdK9vWsKsHzpqN7OP7wtaLS
	 71vah2cGVHWzFjK41prgsYM36kaVIHIIigASZqyUDU4H4ETKNNLYBeTWiZ0wxNrY51
	 nsjj9soKZDtcuIPofDh9nlNMufZ34OyELtQUncqD9/Hyhr67jgWmBshBsoYuWAhzdQ
	 RjgWgStnCqmVA==
Message-ID: <sashiko-outbox-198645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 01/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-2-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:12:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in patch 9.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D1

