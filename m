Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412804;
	b=pkFiEuU1vkVfQe/lygK3YD/l+3MuyFOVgcuJV2Dj0opi3n5oPyIrjOGt4blb3AXa64U+
	 TKujd8KBDcTTfHHp5sEuLDuiDB91guV/euK00lpewDm3kDwUqoZSOtDNbtYfK526uhA5I
	 5PWrt4pLwP1e9HoWJdeM7YAvJ/kD5+IENAOrpNR/YXiFs3NHwms0I7xcOamzCBEbgdZly
	 oerBsWGk/4cv8k3AeSXjzTx2wnEY5d78PYhpbwY/sd4yw1aMHBzPeW9ItBtWG4HBuBTsX
	 1/WLJl758Q66iusiKH1zd0nAghnuObrrTD4D4YarzMB2XRlwFQa/D8nP8S0ExOWKJ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q8HsK7xKlrYgYL2vhTmZUE6uZz/L918cgra8J4k2LI4=;
	b=IuCoT/GToBMDZ/VXvhnnbZud0innXzOCZSYxh6kEKNxCEGprSypVPZ3o6JtLvnC+JL4O
	 UL+Hp5mn3fbvOYxhle3HEZz3IifeIg9huqTjZ3Z8krZ4OrocI0szpeb7HGJQAXcn/pmzl
	 2Xijp9la8NrVp732CMOwk/e9oNps7E28zJlCZSj3YRQBQVtOl0lxyiWjeZrIC/RRfmQqq
	 IyURLHkyCPMZpOZOR05m5I5WMLBKjb9qfrPsB9LaVqaAobx65ULTvtXbDc8p6rexZhkPk
	 5/EzGTF7VCuMZQhU1oYVpQ3RIT52soUdTR4WjvSQfBzNFzCXJXAqQApgUucaGs4lF3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGAL8JDH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063E606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGAL8JDH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891721F000C1;
	Sat, 31 Oct 2026 02:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793412803;
	bh=q8HsK7xKlrYgYL2vhTmZUE6uZz/L918cgra8J4k2LI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGAL8JDHgAaoQVlU19G9oRxWm3mEKVpDxf2mRLmZnqaCYJlxCqBapfyLCcqO30+lX
	 RJ25OHS6aCmOCDn9Fftt72Gl0rokEsXRlBG2m8qIF85Ohchy8SxEmEmHHD4tXjTvC+
	 cwL9Ygw+ANzU85pgDaawiNjIL6+U91SH3KJCzVNKbXZil5kDpHOsqw2hspgn6xe4Q4
	 HNZZoGI9GAK3N1aEEqLhaulLaa53zcwy2IFel496ThSxOj/FcAzFwIuK/RhU9UKIP8
	 /LPZcUJBj/Ibw5E8phRNCHR6RMb5/mj5LTvg9Oxq436mryIN2p6zOA85XfzSAo5eTT
	 5/1vGzlH+HEzQ==
Message-ID: <sashiko-outbox-191699@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/14] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-9-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:13:23 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D8

