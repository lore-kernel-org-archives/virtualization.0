Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357192;
	b=AodKwvBqan8Kr3YnuqIDIb07zgwoQ4QzgYe+KCyp5g7ArI8x6e5N9fEfEM7L993hX8mZ
	 C6q5HEJ2qVqtnUssRE5onm1vHfxqEPR0doDRTAoQrsGiZr+RbiSVs7PvX7EmdRqJ+/nRy
	 qTlCmWCDykk+aP034gDvUmSA/ZIbSB4KU4Bm3grELmN+y1355cpQqcqr0WhTwvKhdH+RF
	 /xc4QQLE0H47O7jAv1RhuCQ3semQkSwu2BkeBX77eHDWIjhf2ORbzpTLRbKJO7MD4RwU0
	 V2UAoumXZAPLn0KPVt9zLOZ/lihyFS0NAUpX5THFPxZKartuWPlwjf8uwDHK9ivLlVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357192;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BJlwXOWmsRbEmNKj51GFdWaAMW6WYkwVyZkzJpGLNSQ=;
	b=IsHx4Ygrs6hVhK+t1OR3MS1wiwBCuQoKvxEm2ZQiT0Sk7C/ftc75pMgHA9UlgIeoThjv
	 fRHhq9LEJ3KmNLoPXjXhdTbi46lqS4SXiP4ZOlnI+1RueKkck1Rt+LHeo8EkRGKjbSCEh
	 VvOv1yexxmSeyA+gqQP0F/HeGEIBCVEX41PeAc8pt3ZJGDPL2mtDIGopZStBRYpqT06i5
	 Cm7HScy+MNaIyHIPaFzE7MqFMzRlRtrvuPD4/A12TBbhbuRi2WGec0z0BSlXJp4HFyGut
	 x61+gaaVzeOGrX7qsbwYfQrZxIDRks3/9iKcC6/z8xwZGmX/7pnr4Qxi63uk85Hmczw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6IIH6wN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84510606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6IIH6wN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34501F0089F;
	Wed, 11 Nov 2026 00:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357192;
	bh=BJlwXOWmsRbEmNKj51GFdWaAMW6WYkwVyZkzJpGLNSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k6IIH6wNos38SW+VP3malIxSlnufTbt87XMnkkp7HKnox5nDrpDLIc5gCx/ZbFTj4
	 Itz5TY9xlcVg1Y52WUXjDpZn8QHx70d7jgGJG21me+0N9MxPiD7MI6M90gBqsaZ9Hb
	 xllDaPvD3sc0GZ9DsA5KVm25nvEv43ks6ochqfOb2I/Q0DbRkqRQstERPolvWkxd2e
	 nLR+pm1W2kI5kBe1Y28d+VoRDpIiZoFbbvmZapqTDBqv7ITtUERNbJuwU8IXraRS5H
	 VjiYjTst8AULYeOvhxhY6opDlxfFFAjrIiBF0d7NDQ+DsuxXeq+/+AW7VDtJY96wMH
	 RKP1+qKqin63g==
Message-ID: <sashiko-outbox-208024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 07/16] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-8-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:33:11 +0000
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
> Latch a transfer XRUN in both playback and capture, and schedule the
> existing period worker so a running or draining core stream sees the
> pointer error. This also retires a failed playback START during drain,
> where drain-init can already have advanced the core state to DRAINING.
>=20
> The stopped flag is shared with ACK callbacks that can run without the
> ALSA stream lock. Protect every stopped access with vss->lock. Read the
> pending message count under the same lock in open and hw_params. In
> sync_stop, decide whether RELEASE is needed and mark the stream stopped
> in one locked transition; leave it stopped when release or draining
> fails.
>=20
> Always cancel elapsed-period work in sync_stop, even when no RELEASE is
> needed.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D7

