Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665590;
	b=SrvpIeQNAe4sp+GYYvt5M4hW/F1+uqO5MwaiP0i1FBGdySyI+3DyNZGdlmp46jIPWCu3
	 goSS75jxS/UP54Qu9s/E9CfzO2RZ3tzKsOCG4vxF9kyWN7XyKdaWBQUEHKXuK4ArrY+jq
	 up/GZ/qmyBJSIEj72K4s9dO2dTJdjk4ATV4s9c1ZWnWZaIUQ3S8yqwVKTBJfMYtNlxt8H
	 sx2NJpknmseaBrvYaIDl1/LKIxMwnLBFc1HJa0L8SUfR3/emoLn+IECZRvd/Q4txYbnwS
	 MNYeWyNomGqTNJBgJPFdpWVluC2EflCGQke/FMM8kWmrsy86rq39Znz0LU1sXwcIA5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5qrmJgenvBeBg3SPeB+TUufVcANuFUREveqrQm0IBVQ=;
	b=Er2mXKQ+FE42vhrB1t7/bLoC/xJIM9X3T7sj6OQKMraeonOUu+InhNTJ3EjyfcOeysLy
	 SMg/0ht6aTDRKe+6gcILr3aP9tgwL5j1hnQ9+J0r2w7zjyKiKDGEydqgI4ckdkP+vTogo
	 KWp36OXwTtHhdiW4tHSOHPCJZ5Bj8ITqwXhqJ78VkRTOV8YGWDcCDz1ImQPBMCeOR6inm
	 mQtmN3DqoVwHURbuhsIyS6XlKRsrQ4Yx2IbY3ZA+qsbcmvClJaADBgPUgSUkSuhU/MsPv
	 9pu492Zt2rZftHj53VVH17OWbK/SgPZulTvKUWAvLMHPHRY6/wYzM0+TZCoVuW+rQ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEDbvMmO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EE606A331
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEDbvMmO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF081F0093A;
	Tue,  3 Nov 2026 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793665589;
	bh=5qrmJgenvBeBg3SPeB+TUufVcANuFUREveqrQm0IBVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEDbvMmOLLBskPeTlcCmKsH+zLKke/UdNEflGCvUagEwX5agKIEbCa0agKCZasydD
	 CnDx3Wq1Ywhxz99+xcDCCFJBqYTPKgyc6BCz1vxUKluTXr8lSUuvB5VqdvQEjBX8zK
	 wGnnyN+4YcgVlxaDr0UIx30s03tuXOVtjCBQYdqUbVbLbEZ8nJnaeBB6mqPRCRVgdp
	 3pDmfGDOFJ2TuZnPdlA4FtqgFPa9O/uAinlSeSs03IDZzFFo+7V8sMHFkO6WF1Riy1
	 p5RfuJg3jxM1YeD3Bw/NfO+6ZjI/CBRAxg0u5hifU1LMzbuIOEz29x1mludqMqOv+g
	 2yHXyLERRVRoA==
Message-ID: <sashiko-outbox-194377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/12] ALSA: virtio: Recover PCM state after a
 failed start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-3-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:26:28 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D2

