Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863477;
	b=wUvddhWlRgbrhCuXjnB4mPHcFI2RJf/bRplwM1WTnv75/7FFFp/SDFHiNdZ1FGKywW20
	 9q95hlkpGsRnirRPXuvAQSb9P9Od8PHcWTYvwDi99K/DCAcoyK1tzDnzbOnPs7iN16UI9
	 oB7qDO3Lj2DMTJT43q+Xv2NDYiwptODIH3iZR7GKoFlmHbeDvK38bw0EkDF7eicLhaCYQ
	 r0HALSL0MMTDHiY6JrpDqxn5mqmf/zzqhGJVcREFWkEn3sIrHCW1gI+LaNoZOLy6BeA7Q
	 /B1nAYdr8bqvRb1jl7juV9pxcnr/uAXI9FXUxK4S0QNYJikhsdABtLPkgh5jFR61aBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863477;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EjgHaz6wl+0SScmS3YlFrY+v5JPs4v4bJXpJiu3bRyY=;
	b=ToWoCJYGmqLavXb5gLpGVpf+SKIZD5akk9s8QyyF0sm0ioZEq4G2QNmf4qYnvpSnR4hY
	 AOl2j/BSnTK4VCscP2eWUZTjpEKDVps3wCbD3uQx0408WmucVzNc9/A+wGwDKST72Oggj
	 OfmQrgyGHx18L9MoV+usN35kP3NLZ8/Ju/bpLm2x8gshHkU5gPbLpUn7zXDHCVLrnAyNC
	 Xk/rEKw1Nd7iQYbMvgVWZ4lNful3oygQsUCwiIH/Lb2Lk+d6SB2M4SVDG/iGQPT4yhQOv
	 TVYcyh2izCZ1peyegisbXfo86OLdruAuOuIl/ZfI3m1sgE3c+kxvKPn21q633GKCZKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWhoBWlg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F82606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWhoBWlg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A31B1F000C1;
	Thu,  5 Nov 2026 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863476;
	bh=EjgHaz6wl+0SScmS3YlFrY+v5JPs4v4bJXpJiu3bRyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWhoBWlgFpogQEvG0xVUrbGGkkdjCW3FOpDHFOy/C0NMayrK4WiMp3t4nYT9bEWkW
	 p4ro1NBBp0ZkufcNXR8X3LA6uSSnMI5kJFpYY1UrJ8zQlD02R0bqeOTLBVuobo+uKP
	 VA487O91ZiuInsiKPRRyHTzB39R4cFOmd8bDMcKTLrabTUBKPKtLYu7Q2oii7QwP5f
	 rPGdSMhbYfB8P/SFYqaaIKOfEIJz9BC39u1gOiUyYLgcvhPjbp+g1487MkBrPO2Mg0
	 2Ew1oWcnf/etADyzuxleOi2P2ebM29z0nQoLNjItGylCkfelHmtAvWLMsnrqI+NWq/
	 yJuRRV0SDdmMw==
Message-ID: <sashiko-outbox-198664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-12-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:24:35 +0000
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
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D11

