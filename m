Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265938;
	b=nnojMwMqh1aVLPj3CfcUEWzg3/JubvBhk6f4s6Oe4YpM4limsmXzo5wU8n4cyCJ5w39a
	 ojifUopz5h88Lxqfr2UP/Z1ANapBtqvzysHpNqSqXb53+4eNmKAnCsro+uw575HyzMl64
	 S6S8tyFUZFQKUkW8aFq+hjF5rMAkSvDgvIq8VclHahiOeStPELXa7fuIDc4kFfp+FQeD7
	 7x7No/MWhpluYb1ulTZ1bmFqP7Ql0Q8eBb0/6awkYmGIQ6yRlfc+dzFaRur7s1sN7SnOR
	 LN7FQK9WiAwAhFN6eFoHqjVD+TThFA0x9lYMwdQ2f3FSUR4SUY+WM3UFr4dROUWQJKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265938;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LEk9+rOjSnsw+aioEl4w1/g9VHm+1+2hEYy6jkAElpg=;
	b=HE+6OsfHqCJ1CyryVJQm9SrNZW4ZnGhpsCz7qkmPf/X/rzKT3so9gJhETciEzDCc/tQk
	 UHFIwVXPXtOcAPJGEjd6U4S9avfFGFXgLMVP+N7TcJJxShcwbyyAY/oceIkZLlNmGHBsh
	 hiERRxcYL+LfxFtEx+AfiygB3eYVMf93QtFXqQntlw/vHVnmuMBfjTmEitWT/Uxul54pu
	 S2QvzHlCdw7mPGNpSbzdQN/OZM/OUwnRTYhKxmGLnQui9Psonv6Hxg3nGc57/V2pfkc/Z
	 kWc5rH+SdofD2khw5wlXKJZnvwyh3sdGlbajeCz4LLkzoocVr0r0MMNrG2l/lC0E4XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByJc2zxA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98559606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByJc2zxA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38381F01825;
	Thu, 29 Oct 2026 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265938;
	bh=LEk9+rOjSnsw+aioEl4w1/g9VHm+1+2hEYy6jkAElpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ByJc2zxApBsMEG3tPrSgleMNyiJXKbjQ6Qf2oQHmRFmGhNkZcVq/YNt8SXTOmO+o2
	 ou5rRIOKUXyf4LAqB/sKzyqzhp5pE5PqtRDkxh9LgcJNxAPh5d8NavsK0ZR/eOP+/C
	 q25yMo/t46lHnQGVgqpLbEkdGvm5AouS+SFxCYaMOtNxdtxEEKQ+JbwdADNwk+BL07
	 H11txun5W3QNAS0U5BKl0V6xem/sqEg89vazrGbl0C8FyHii6NptIlgvzhn1ePWe6R
	 EGocpKuEqtOovwBdgoTJ0JNiPCMjmvjYvH0hCzdIE2yYaQiCj04O42yUcJw+5Z8zq3
	 uWSYURIDrvuJw==
Message-ID: <sashiko-outbox-189035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/14] ALSA: virtio: Recover PCM state after a failed
 start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-3-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:25:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D2

