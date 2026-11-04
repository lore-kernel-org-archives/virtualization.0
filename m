Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759344;
	b=na2+QnkUcWcL71wRBpeUnl7sFzRgvVSmGsIjyZf7ymCSX0VdvypUy8G37qFJqZOetbte
	 2ZqhWtMPWz2rMl0jTwPulXpOT/VWbCT62WykaZWqkvhljV4ZOU0up7zRjanb9DzskaWoY
	 KIvP1uIhG7YkGRKA9ou0mat60IipaFv1kq6w8GXB/hNQM7Li/COpQvtXowLWfwgLfie3L
	 jSMhZh7UCafbODfAN2wNRuWVSNMkZ6nsgAnKugw+p4FVCU6x1OHuPZbabcMZRl7R01AoL
	 w1DPDKVBUUqcgxGFm7O38h8qWKK4JHoE9oa1W8ARbDbtPrHlb4uDshd034+PwirRvLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759344;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5h3jCIIYQL5OycsoT4yhypG2WOKJxFmBswUxdkW6sa0=;
	b=vyAuZzfZerilIYsRYzOtCNl3KZN6/j5cvat6xugMbn3z/FDfgd5HkZ514dft/6Gd8OCm
	 q5uu5pU1Dx+xZYyW6KZJ4cV583pQx+atA5RmbbEXiYPSt1xdbNwqsH/vqafoKLO76PqSD
	 Soo6TADG7CUbKryZJ4ve8+iGJOC0ZJYAqhYc9D92hkGrRiHyxIDlXIuKs8ozSFmDQ5FO6
	 UyWX6mvTJvYcghrEvzLKtRMVZ1rj/0WU4cTJkaTiR1bsI0cr3p0yPlCTO8HCO1px88K2f
	 n5reN6NlPRcVFmHJWwH34CyrIfPcIV1eSBS2LwbjZF8/bR+aXU9FYs2sbm5PSoPVCnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd6nep3y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C24A606A326
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd6nep3y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720DC1F000C1;
	Wed,  4 Nov 2026 02:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759343;
	bh=5h3jCIIYQL5OycsoT4yhypG2WOKJxFmBswUxdkW6sa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xd6nep3yV1iICQQR6JrYS+ipB3yDCYvedf8CPd3Z3TSD6utmE0mwdDOcnOM7phYrd
	 i4jXHh6QiU2P0XAMqVdKNVdiz/hoy6Lnc7qlgzJ4gBzga6fuqKhs/4m0BPklB1+F4n
	 dX/SAxEQuN18eGO28wFNmNv+T5qmx7MyQ1y53BhUQoug0WSAu8ijt/+wBAhLUDyYMD
	 1z8xRKFCXy/sruE+IPyMONm5MC+pjLhOu/IqGIiqi9BizF1oucjV3Br2ASne3g6tD9
	 0xhe8avzdZhaqvoGOWjny+V0d+p83i8+MADhC5f3I/LWmFKai1EKyQgnakL/MHr9f/
	 SGwz7yJpxmxyA==
Message-ID: <sashiko-outbox-196471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-3-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:29:03 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D2

