Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696107;
	b=RJl9cLUpClVYCj1KfWx5NheriB6mZvuuw8iD2F7sTftxSEz611mz0lHBKIYLsHdruTXq
	 IPYs2KiPjWlUSt50/Yhh6xR/jr3hpg4UfWQ7r24mXpYIqJW8YJsMBMeL73QNsvz3PjK1T
	 1tM2/JDDyOOXoEd7AVZHq7MFTkAuXoKeFkLL4gHVZ9LyK9LJCJZpbkLc5saiJ4v9ZrM1p
	 9xeluirs3ZyvPPaPD56zMFBPocKxD30SLQQab5laT0iMRQx70PsAIKexP0nAsSYpBCS40
	 Kkqbx5Uy5fHrO00Gr1wUw3z5M0tt2c8q5uMfMrSNgrM898TM7y6pNGsRMYUJu8t0kqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yUppIR/Adz8mV0CNgJF5cVRk2FxJQuOpUVbEZb7Ij3U=;
	b=xqe31N3soEsFSz2yphRro/sWTPBBXjvf74pkLml8wXd3h0V1zc2MGO+/44/ndBOoNeCs
	 /HTwe+N6TOqZDT4lgVpgmpQkjPGyJjI+qc1TcReB87/L23pnQbmfr7fbdEMvlGZJseLzU
	 q3IwTTsfB3PqKvmiE/+MKPXOA6lzh16ebfqdx+RO9c/oIJmiRK87pBE3neZnebc8mm74j
	 +Vf7FlA9BOpTicFkrgCj1wcIYSaFiJdrgF9m2fXAvQr/RdiMECVAX69ClZLmUBB29bNPE
	 yNLNa0cYZGtceDt5K7GusbGXcvxsQnm5By8IKfkTi3mSigQaHMVceLkocveg/slSmlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMyMEreZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D46606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMyMEreZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF921F000C1;
	Tue,  3 Nov 2026 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696106;
	bh=yUppIR/Adz8mV0CNgJF5cVRk2FxJQuOpUVbEZb7Ij3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mMyMEreZTWaWWqpCBXm2LH/O2dez6Bs+TvLcfJSGpCmsbg3fOnwEcyobyzv2WPvYL
	 TIZDNaML+SiXo0/KxNTOhYgI0alY9ugq1HXc36Y2Ir+KvE5XfcYGtL4R/xembpxvoc
	 187xse5PoaSkk/b79zbpRDqAIfSomG8dwHUvlBhsWaitkBVQoMbI/T/bRMrvLAEnpk
	 mqGHbRXxtYG2GQzibLKJjbUZ9GICBJG3sJPZbqafevI1gI3zeP2s8dFhthjE5VZ5M5
	 aXs+Va2VfPWPsDsBKXQyWU3bYShis1pLTSeCobVCoB8zXN+kWs77NqWTeKxqeqRl7D
	 2JMThl9NGq2HQ==
Message-ID: <sashiko-outbox-194897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-3-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:55:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Capture trigger queues I/O messages before PCM_START. If the START
> message cannot be allocated or sent, transfers may remain queued, and
> ALSA does not invoke the action undo callback for the failed trigger.
>=20
> Mark the stream stopped and disable transfers for every failed START
> path. Arm runtime->stop_operating so sync_stop releases pending I/O and
> prevents prepare, hw_params, or START retries until release succeeds.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE
> is needed.
>=20
> Record the RELEASE obligation after successful PREPARE and clear it as
> soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
> wait without submitting RELEASE again.
>=20
> Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D2

