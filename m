Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846215;
	b=gFsCwwqQnO1Q3AZDmNhiCR9veWODbl/jE8LidJd6n/maBpP5Kpn72UXnl7yT0TFMvHS4
	 QfchdBIhI+4umyjEQMb+Ek99fvF9GmooI/DqSewqgoYprr+bR11JfrXuft9RgeQwJc8k2
	 uqJB9oTMfxCLEySPOg7j26w6z79eNNvGdd+rkkgoFKD1gVOCCM2ONSgk1UGqaQEqm/boJ
	 ZuuOIqwTgh30shWu1Td2yAoXheq7CGpo68swV3EuMvGp4JnCeiWPKENcjXV85BqLO4602
	 Sq2xvtUPzAYWnCee+m+QnbvHN4k3XIlMyyUQUbSr1YWIVXW3XxGXrztCBKdDXTD/ZGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9xy80LJxvN9GOTcvTMaDavvE0mt/RLsTs+3f/OWv968=;
	b=t2MYrCyT8EyhgNjJ9SgfRe0NUIRhlm/2h3ahg/Bn336aWw/QVabIPUlh5e30pRV6ocOy
	 OUWPMMkk7/nwcW+PpvgqJ1zvOf7nkNN2aowhc8kaAHqeYa64O2TD+L6Dzw5j6MTQvW1Lv
	 KaX+7J0NTpy6KHRtKN8sDSlbeBRfYRwymSk1ljlHaroJRVqUiXPD+cvtRZhBoZkj4ptB3
	 yyAEs9ICxB+gCpf3oqsFm3wWqTL0ebxZHZANw9afY7b7pkDEoDQpRMplirW3Ie4YWtAgB
	 9Pqsj7gssAimhj+PhqEG5BomeiN18yjsr5A4bPU8bW5j6J/wJhX/sYQ3SSxx0fiZp3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQVAjCix;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A6606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQVAjCix
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6D31F00919;
	Thu,  5 Nov 2026 02:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793846214;
	bh=9xy80LJxvN9GOTcvTMaDavvE0mt/RLsTs+3f/OWv968=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TQVAjCixkSR4z4V1O5V67hQkEsT04d2sDjAQXsPCdRagQq2ivOUzGUvnrURiE0OsU
	 O3OSGJwTfOp/ptMqzFOCWuBgUSE6E8nRiAsFhiEHEgatvec0dbW/OrKejhGFk7wrHz
	 nwPf0w700WY2mvmjkRup340Q1heiPdMYEZhyQXfWm2DbuhIr17RYmzHm7sdb2kbr5S
	 15bjOyVZekaPq1MMZN8HNq95jDVSjIY4jdnubKYryNEXvWT5fvrAFV1ng1ywbzEQwM
	 8G4/z+YzUm9cPbSqQMV6/YZd78CKIG8C/5jdyHgUI2SnpByOvLEcZVs76w5X2pzL4X
	 I7OiS7ONj2aUw==
Message-ID: <sashiko-outbox-198469@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 02/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-3-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:36:54 +0000
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
>=20
> Atomic and nonatomic synthetic PCM tests reproduced the missing wakeup
> and false-wrap alternatives. The new helper delivered 64 final frames
> and reported four available frames after delayed partial progress
> without XRUN.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D2

