Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910663;
	b=CYHlXIbDRXayXxRXg70broTBmp/s+bCnbc/hA1fTwJwcs8pW+zCwZCZZVpxMH9XlseKz
	 ifOvSXnKMarrrqXapLNlRl9ZNCaTHiu0UEP65cVlIdhRLaEJIK2RH71GLJV+EHr2FIVos
	 iRXbU03AruWepYuMZ4VXBcuYsyFGN+Akz5xl9UPkuqufyQ1yvnUJq/byLFGO2d2Rpz1dl
	 dnbXGz8skeEO4n5Yl8CORROzZm7UHe8Lkc0+gJnkyz6BdFo6fC9uQM+3JovJiMZ0aKfeL
	 Wfh3eo5e+zt3Cw8YrGM4ALR9DgAxioLPS7mZ10cCTzmlE8D/5TJnDotUS1N93O2WH/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910663;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T2j/NgkoqkaZKEFOz0PIx3FCt+rjSMzDomp4/p4DJuw=;
	b=R1qVchYLhIlG1ELsEddaR+bwfOs9bFrUftoRfsEkyOH+tluGcZiAlQa8KkvQLCbAML+B
	 QulydLomyfpJpCS4qu3SibLgMENuXTR4OJG/RxgrsijKQEjBSAqsjkF2phsoVyyW6pbiY
	 GmbirV6EYrGK0dyUYVGnAlu7HyUoxla12P19pGTKVLbcMPOpwZM/vlQa6R2CMMeJva+/j
	 mSzNGKrDUfWaiF9Cu6T6XEw9gpxmIjupuRKcsnJVJKlCWZ3I6VsRGLMaq3yYRFUZO2wl0
	 gaKx/yT2sw9vP4+nVEFUoAkKuDr+ZrmiUDBb71WfPVTtWODacqQKlmaQFLRvl47sP3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pk5R7DEU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4B606A31A
	for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pk5R7DEU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4031F01825;
	Sun, 25 Oct 2026 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792910662;
	bh=T2j/NgkoqkaZKEFOz0PIx3FCt+rjSMzDomp4/p4DJuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pk5R7DEUvQ7aQPklgQhB0qwd0CAdsQSk5XzGuUOMo26HsKrDC7n78m8ygVq1M1YeM
	 vy4uTHoYCGXhgV5kElCDreEvvVAG8PJnVa6cDWMQvaCRGD88FxCwyuTc9qSofPwkVu
	 MLo7931mu7K9Gg0piIqUo9/I15f2aUm3rvNss/+mEBoy7sI4QikoEcgNXhfXpnyB86
	 qmfYR03cUewyGCS1F7ed7sslHU3IBuIQgXSWf+LPcUtkN4ZPE5GfFqPNQHZNNj/On3
	 oWJvYRsuGg8aOSY2yhtiHHt3rcxIgtLIFZqg/zqSKWqA5pifKs4/+nruSEK/IuXUPY
	 fkroKjnlV+l+g==
Message-ID: <sashiko-outbox-184098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261025064038.81674-2-mynameisjune111@gmail.com>
References: <20261025064038.81674-1-mynameisjune111@gmail.com>
 <20261025064038.81674-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:44:21 +0000
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
> READ_ONCE policy sampling in the following patch.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025064038.8167=
4-1-mynameisjune111@gmail.com?part=3D1

