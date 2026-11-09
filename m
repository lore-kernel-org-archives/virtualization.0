Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202134;
	b=FOb4+HPOmsm0//ir4BXbUoVma/RDuulptTFZWdp3bIJrVXDERfMMnmHUR0VCh1y4VlCq
	 6sRvPdejAzqx8fjB504DJsBNKbDIoKNWZRnwgLqpyROIe7ASg6aHRS2evr9NtHEmLCwc0
	 1286wiMfjAKqHiSEEt1+an4mdk280HALLGT1wiuna3XECpV3KjJ0aryj/qOPQCxbXgMuU
	 9wCQlVD9BoxXoJ6owdJyZGcxx5kYB/QG3IXqjHv+JUMGVZ52asmlKEcBDjeOQGfGCkWvK
	 g/ShPn244rgUxGFSf1DV9KmZ0zIa0mNVJ3ridQzzKRx3tkK8YdmBG0L5nUf9Qs4xsQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202134;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lxrf6ljHI0dOgb014gCuPVxG7qweYSDYO0VFcrOqyWE=;
	b=0u4Dr1DcsA/8djW3nwuB0DV8MsHxhH6b2TMqD+kIdhY1rcM8Gg7iDxFsPoWIZ1ZK2955
	 KvebINMITaHnPVPbiwLl3bpST0kUWI4B99EJrWQdcE6/ekK2M9vFUnJX3j2FRzTpdCdPF
	 SQPo2Yy4EY66R4SDZVLJNj3rau155jDKUG92roSEW7UCwJ/tPr1yUWrT+6CW1r+jH0gBW
	 PGq5DI3fWLwZwAPTffAeGgCtmJei3ghEZ4I/yBMunWw2lEtzApw415k3aQO27FVQCNQAz
	 SIFSeYpdymgUncgLtDVTirCc/4lEsIbv/cW0c19BeozShefK00aNw0vjiOmDygBWn+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVhWQYZn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E1606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVhWQYZn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80091F0089F;
	Mon,  9 Nov 2026 05:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794202133;
	bh=Lxrf6ljHI0dOgb014gCuPVxG7qweYSDYO0VFcrOqyWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVhWQYZnQFHsmN87cPWvF1tBMMvGut8zmgPhj4dP88ESjJWNsGsFvYSlFRdaKlX5U
	 hB6dEVqRA0W06Ht5maMw0B185kJbqpe6gBxKpYBnnIkT4v6xf/U0aQbpD6vjtOyf6A
	 QClD+3v8Hjtl2sWkM+RlKkas1+QTEN6LFZPBdflmO83c3AGuuyNbWNskxPVI+a+QNH
	 2ug6VQ86VKkoVZGPstkJ7FK8oGtri5vLMNYklhPZyLe6ycjPx8ID0mn+KzEdt9kV2C
	 bmUYV9urptZIvgDZAqIe1WAwnsrVRZ2aXNqUEWmRnTPYNfOUeG0SHQY1YrosHBLMka
	 /U/kz6XrMSBTA==
Message-ID: <sashiko-outbox-204438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 12/13] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-13-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:28:53 +0000
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
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D12

