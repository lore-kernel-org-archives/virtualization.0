Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202962;
	b=1xuk7TzMu6R3m+eVaqZWYVrz9cm6jaZJ7MNpy5u1Ct/GNf9EmH4DTtYhQozsuJTIGWza
	 AEFPD2lmimvazSOmF/MI20hylv1V18JsgjPH288+tewGENdfZ8QkRdmdjxhuFbRwx9TWb
	 k2TR6A+rzqksdZxE2jYAGWR0Mfb5Vx2OB/x7CmoeB3WK+mLEriqyrPjI6KOI2FufFqALq
	 JwtCNz/b+4VqeiaAMNu95RSC/v1RwNGBvEZQeJF+GLayXlYNO8IxzPkFmYHVPYbHScEbK
	 qvRSElRSy9M6vHTwUxFWLNkjo01hdvzeFtaskp3laJlEc5lJV8tPhE73cSZla4kNcfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202962;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xb89Fso9JWnkoG+Wcr9ePVh7fxcDRzh5JVuG9OmYnRs=;
	b=b14GPtJY9WmxSV/iSrq3L+m56bFNuQ05vr0Tta8nyx4dlxOCx9gSGTrKA3BBd9i9f6ak
	 LvCHSdzhCuracRsx/CPzP/RNiokD10x31ixmN/OI23djwCEptpVLhdtz2Lfdn2nsgUMzH
	 W2zPuI58aC4o5C7pDzf8wZY6NeZFMCFo9hhjKjIlROhpus9kR71BWYzQg3s+MyJVmT218
	 Uz/mHf86Gg48+92qFh6WtJpTqyKuQbHaIck0ZpxfvuAMnIG1/Mml9h9O/7GAtK2KB3yL/
	 iE5NUSQrZaje86+aKR3AVSZBT4MSEfZhZevZ76LW/N5+9X4tZQgZbGoRtZP10q9u3Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+0IYHFh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC37606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E+0IYHFh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933F91F0089F;
	Mon,  9 Nov 2026 05:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794202961;
	bh=Xb89Fso9JWnkoG+Wcr9ePVh7fxcDRzh5JVuG9OmYnRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+0IYHFht+Ny1F/fgQH8PxVThVA/bvxB8+s5TgfhHhUFSqWB5St7DFQjjGutEbcvx
	 2td5xDjZ7BVqmYHhtoewODP+6bA063FHbkewwkNaQB0v9ez8Yx1wHx6GlI4cdKGvwF
	 9wAUCv4NPIWFD/cAJ7xlq6JK6tyI+Qg96WQaPOmQRvj6hYv/nnmWfPyJPMWU578QL/
	 7o7w35CfH8KWx7doqgnlYuiODkFnT8g6lV34MVCeG/ZC1x8RZtq2s/gGU2UQemhUJi
	 4JchbNgI2xN1MFREWy1wGqU3HmFaHvdOT5qBnrpFIjhm7BJpfPz6VlZhBG1+ZkJpSA
	 oWhUxIGJBFErA==
Message-ID: <sashiko-outbox-204453@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 06/13] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-7-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:42:41 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D6

