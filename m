Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269437;
	b=GcAcp8Jgm7XxM1LZGeyHKy9EatxiN04nCJPzQlEcCwur/LCW/o5Zm5rCKgaCDO6jxKNO
	 q4G25qh01PDyUyCHOiSfYceh/lEVKfli7678p8bVGF1BEwgkPhKHZz6eCw58SPLRohP6T
	 UhzaAMb5tAesUSiYRH6QAQz5jA4LMhla8RMQwgOfp3rAyN4Do1Fztk/LQnBe8c4z1HmaY
	 FhHY/YJruYlXdcGB+Us6nKRH3F9EtJfkZ9Lp9q+KDqj9CXYjSUtD4WseeESSzxy2Cgy/P
	 lU1jIyQrANl3TEIhzpN0CGMplDHUhyTd35GoPZUNmSesLHuROKMcmcwugAhgJUIw1OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269437;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dzCOZTh3/OVCMrzz3EBQu9tpq3bCsis7APX3xkaqFhY=;
	b=bNVslYLUyZmES3Ko5tvCyWxheRHrdWeANA0mhH/YinB9ZH+V3mFmOkFHm2dD6zEqSzmc
	 BCaK56MJ4x9KaC9Do37VUOcZOGe38NDRhzAzEovhobwY1rPqHFtBI6Zaegu/QXE0RDISs
	 81qrO3Xad/l1Ptx5mzgDJ+0qHxb43z11z6FZxv+HEOJ8oT4ebhHBBmiAclP8tlkPJk0Ko
	 IClXYjYrryGUKvxGl2GyJAGU4ZU/ZHhVro8g8cm0GnIQTAkg7izce4OYeBA/m3VTNe64G
	 u3HbkfnyEKLa8oFqI3MNVY6KzjYkJM8A7u/0wt/hLp9nU3DfFdkXKmKFtfDtKXsnS2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vkjwua6E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C873606A338
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vkjwua6E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1B01F0089F;
	Tue, 10 Nov 2026 00:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269437;
	bh=dzCOZTh3/OVCMrzz3EBQu9tpq3bCsis7APX3xkaqFhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vkjwua6EbmH7oD0eELM3wQvkIhmVokUh3zhR9yAJXWnv35NZeMyMTJw72Bi3QYZLG
	 oZLInHqRXJedcKRPP5b3/M/EWYA+9Uu6Qo01VTDlPHXKwuY/nIwBBR9dB+Lig1kKPl
	 cUtAbXAZ75KsW2LN3JpMA1E1KHTLoWOa96RFSCHFIBJcsLcnzhEaczbXwoQ1Xz0Q1b
	 r3bx4BzTYBh/iPwYkKQU5RbhHUul7RUZ7sF6J+qzrzoa3NZTqkFY9eWXfVPOTQ30/R
	 Xc9Pj3xpSSvcp6s6QEY0wqarHI1ilmtEq9IExll0v6Zvvr9tbNH//zjJSO/gbozbMY
	 5XLKMe1f2K9eA==
Message-ID: <sashiko-outbox-205821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 07/14] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-8-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:10:36 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D7

