Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268524;
	b=pcr4MQpDBLOHDawW6MEYFvNnAkPnkOoh6ufiQwMjTos1ad9J7QpTqMtboK3W1Jd0NF93
	 GAmOEPhP9S42r7E8Iu5hqKEKXWG80UGkapLw4Qgqx6BDZc78m+IsbeKOxHysW+1/FVuHZ
	 G6Pw4kK23ZBp/O7fCfTFxfA6sbrfma5TgMLFwLXJjvtHrGmyu+W5q5J/fhwiTm+WzK5Cf
	 U6ahL3IKkre5qbk6sgqZSDShE0MS8xOW/KjxMrDeJ7odF3hY2oD3p8YuUiJwMmimcVl0a
	 PyxwHvjBsxKjaqLEI1gYPfExyTc0XPGoD56xYpvkdj7jGAA8+Tw9G2RWwPX9YKlsAvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l69tgcglbrisWWVdHKbb5PCayJg3N7AlZeLkJQol018=;
	b=nx4gEgEmZVdte5luSN5Ch8ZHufANU81SW5Tf4P5qBClrbKMeYz8CEEWR1a1IatdnjMNk
	 ZWRG3m9eNxIFFVvgmUg3nQYGImECHpIKdt2284zzBL/U4mvTAEgZ37GhNTX4rBMefzHYv
	 uTtsbbIvNAbBCXD3ustzQ7V2hA0FZJ/ADamPvJuxz4bPHehnXc+re6nCV7FyIeJkeOCRm
	 L3pAolL/t359Ogtz1W36rLQtd4CH8VTPkVqzatgrtpERq5C5DraOCX3PvypY6t2JBDKHR
	 dDH4JTrEBlEumvWieat+rax9krZcWMsY2Wna8JhlkTnVlvGOqUkyhwzu8rucVCbrQGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQLZh2zT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212D606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQLZh2zT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13BD1F0089F;
	Mon,  9 Nov 2026 23:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268524;
	bh=l69tgcglbrisWWVdHKbb5PCayJg3N7AlZeLkJQol018=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OQLZh2zT+JJt/3wTG5iFUp6pa56gDq620sqC0G/LhOEnocExcOcLFeHz1wDcj8jCa
	 OPFTpZeRrjupUu5GK49J8YvzA8pJJVtw40T7jtEK7MX+vOltIMxlwF2OoMOj7N+gil
	 wbbiNhMCZFqdPDeqIAAu6R/XSmNPwI9UnJy2u/1nSmW9O/QaewkOy1w+EmN0q1+1bG
	 PgDZCShcDb67rm0WkvtcK4AnNh0vais9Qi2Pp7BCwsOzpkK+7GhVkHBP+Fpq0WGEBc
	 3Y2+plXmQ1yZ4xPIzsvDQPYZzuvIHJ0IU8/Lj+w0NL2kxnOfK6mm0o4Xmw0nOh9zsS
	 9DyiN9OmG0fTA==
Message-ID: <sashiko-outbox-205801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 13/14] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-14-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 23:55:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Queue staged capture period notifications on system_highpri_wq through
> the common scheduling helper. This allows capture notifications to make
> progress when ordinary workqueue workers are delayed by CPU contention.
> Playback and ordinary capture keep schedule_work().
>=20
> This preserves the existing priority proposal without mixing RESET or
> lifecycle changes into it. It provides no hard real-time deadline and
> cannot prevent a userspace reader from overrunning its buffer.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D13

