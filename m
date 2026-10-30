Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338235;
	b=ZyEFXtj7I9fv8QmVutpn5uayxaL48X9zuqf/rkE7TpDCOs9S+LXT4E5kQpJz5dvgSxPv
	 B3PuxYmQumuIyMo/YLI8sLsbTEv1teMHsHGM1mLKhVS7ptYGW1FtQ6lzt7LsnlV5eiq9p
	 ScVQ0G7atJKBnW9ly9B3OtF+sKLQBtrxAxxMxf6gRl059ottmxBek/UV1jkNiTfBXsyYq
	 DkjV62ifxS78mBvewyhpkaGHU7nTvGDzo99fkvN8MZr6nBnYQ5Eax9gyIK03UtuCPJHeb
	 qxO1ygLIny7VePiovUguh8yFMY3LcUe0yB2N6UvCCVPg+WJ8Mi8Jp5Y9ZbWR5hDQr6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y6Mc5hlktLmXXTZ422ieaWlF4OFV9rNwEE0AMovgmAs=;
	b=ufopaK+3anS9TRW6GglTsPUviB9xC6hM3MYG/441LuDncUkiNKuwu4iPOfvmzfu7ojvV
	 /cJhQehEUKCOnuQPY+uw3BoLTEHVPihXhAkktRk8o9Mayc5Q4GNRxqBqZnvwoPQVFuMnT
	 MIrlMATF81LkdeSm32zxD5U114Z7hntHDuZL/mAOfsS1eV3VfaC1glfrwUozHvEZDjdmq
	 ECeezDPEOOUlKSUKHNv7BKoXcw/+OK5Ze5B2bps9j8rUCr1Yeji/d9SJQnPaFT+/fuTfI
	 +EcLQFqD7tPAN6s3dBCS2YIqcP+DuOhYXbVDMxex/t//HSAaSCJ5AYlBzonVCCu8RFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ewd/OFIt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F40606A31F
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewd/OFIt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22BA1F0093A;
	Fri, 30 Oct 2026 05:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793338234;
	bh=y6Mc5hlktLmXXTZ422ieaWlF4OFV9rNwEE0AMovgmAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewd/OFItgKLnXcfyNtpTtjYYXt+9hQb0Naf4s36DEwRRzjaX6/vf2882s1lVuZf2F
	 ysj1EeBRvfEHAt0O100XwMGxaA0IQhbkctwhr/tOYjgZHJZ+W/g/aFNumqUB+8ZFg4
	 QDHCQ1NtJ2NILQMrIXcyk0p1q3MNbQme/wYhDucHNUGTjfKlgPSwe6Xvm8H4/hiyxI
	 zWfJ/NR3BrxtmOHiO6SobZgXMtfKTCYl8IdG1CcphHqNMLd4ty8xPNhX3/+TE/rI5R
	 Nj6t2ZvWYE+Vtc9AAXf5k3rYpHOBsYVG1H4kx3dX1+GlJeNDYnMxEAKqzETfUtRQox
	 K2YyI40niUZJw==
Message-ID: <sashiko-outbox-190561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/14] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-9-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:30:34 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D8

