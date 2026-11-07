Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062388;
	b=z3guim13SccOuXTBMjwHh8BJaKot6u2rXPphju+NSTs+yP2dGGaAJhf31jOxpdothSBC
	 XTqGV22e4fkxx02fqCJAGGp46zo7V7eWkkN+uhibFkEFguOtGzlVlQWj8gwDv4//EnjXd
	 UlKePgv+Q7NuFZ7JsuvYLDfH4H6dHrY+aOcyRv3P2b/Yy9T2rJjbuWHy4y0J3tEvgTFFP
	 lVR9eWNUOtFgQrlnhiizcVd8r8NmKSZDA2iUdt5PwaeZcedcsHP7AX6LhhjH0lAOSde40
	 yi2hpQxEg9FhokDR+R05SHRTcZChroXHYu9PQdKGoZc0b1FsaFa6WEHu5tDm/JAzTjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ua7ZpRJLnbwYHoL3I3xhBqYNKVwcHCgx1TEEbk/MDKk=;
	b=wTEAxlt7Jw18/z1ofFPgtW6YlKc5TCjbaGGdq6n/j0x9j2m8WtmJ2QeAjs5K0JCbhwnA
	 w45CLKBjhgaJCVphBKac4ohc8P8hHJIHNFDFKQPuptPInNHo/n+ywnOoPKCnOGt6gzmSI
	 mtZrNol3MVgnYyaLyOg0itZu9qmxkg+sOwTykmdleZkRjIwY5RCgcvtn7cKYMaYChnXpj
	 s7sIu1PQpqARYQNF9s6oATijvKJlpyhEGHQe39lLOUCvM78FOIv47ItyYym1YHN8mdLtV
	 aZHVt9sZdoy5MI5GB4MYzHi8XCFVO67HZuoaL13I6gvesVeV+S8ZjBtrPNKPVQwuclA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+G0afrC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F46606EE87
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K+G0afrC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71FF1F008A3;
	Sat,  7 Nov 2026 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062388;
	bh=Ua7ZpRJLnbwYHoL3I3xhBqYNKVwcHCgx1TEEbk/MDKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K+G0afrC1evIladVFXnm4zVIdSEyAijTPySXaeH1JhpWwXWxHucog97uHZpLpmrZ/
	 l7F0+dFSA0YLN/u8UmkgOy1lmcxHAiyisutmRigqIVxZIOAxLG+4H9TfGKM/5Yudeg
	 0YPeTFTGkZT/Rp59rQdATLAV4b6OOa3R40xvlzd/WVmwj2GzQk98hSKY7j4SmrRcJH
	 hd+vZU/61b4FCdfwNcKWOpJ4hLcfaTdOVhW4lH5l21D2ZA9u2oKD9xf+V2di5gFzbA
	 eBhMGwX955dmGp4YRarFWrMqmi4FqsLg9OoRu8iJ+MV/50jnTKQUEdtV7Jz9DpopUe
	 dXIE+Ft8QZ73A==
Message-ID: <sashiko-outbox-202963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 02/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-3-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:39:47 +0000
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
> using the period-interrupt path for this event can infer a false ring
> wrap when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM
> timer. The driver must release its pointer and trigger locks before
> calling it. Existing period notification callers keep their current
> behavior.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D2

