Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462396;
	b=SfkWEP0yRggaF7H2yaBgLMUSYZ1OiNBBWXbZk4lKDtqoTAwT+FqkHSq524DVqTWttKb9
	 rRjZ7/AHudBLuD5bYb8UmAL3XK3vZlTlB/nV0hXvsWQPS5FBA1dYBsHO3KUYiPl/74kkC
	 406jM9bwNk4zZ6v+Hko4nMhi0z6Cb+7mZ7hKlsE5I5NsrhmN/+Q8Y1bTfiC2tu3Ahm4LC
	 v1nr83K4uBsx08v4bp338pxi/1wAny2RGDlAB0y0nZYANqjkR/z+c55zTmJhwaUJF5Crx
	 tlhUpWI/D7VlqnpNufVqdv5DXt4pEv/Pa9vrN9giRDfXAY0OOb4XLyxSumyg0pdp0hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462396;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PpK9M1oL+CLdC/eiUreNM7r0/LVu7WUTbrm0ybw68zk=;
	b=Vm/8m3sYKxz8+Q39QQzI1v81tyq8xqbF62nf40C9Hskmyod3YkQwIRlj7bZFbYEX1oQa
	 QomeES2pqlKh8yEJCjszUvD30ftJ7Gepu9qT68kZwIRhukIGgcwMi6aPrDG+qKlowDrqM
	 BLhKAB0UsxKhpG6jXs58Cg9aMDrBVUuq4rk1DlO7SP0Yab5/RRLBDGSjqgnpi7A2f5QUX
	 MNfX/zbKsNsomv+pd8ps8MgFsxs3qZrbk3gcqgVp3aaBtZybfa2J2bam0gC2+VWpQCmVm
	 TmtwIG214d/dYOzhkLUPDcWLWyxD4g63s5LvO4v4Yx/0GJuRA9/TWbxJwbleRivqa6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S1/ShLwy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA9606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1/ShLwy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D051F00A05;
	Thu, 12 Nov 2026 05:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462395;
	bh=PpK9M1oL+CLdC/eiUreNM7r0/LVu7WUTbrm0ybw68zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1/ShLwyoV0Ee0WfwwKrUASP2kMufqqO05m4EApcF12fyue0Xur7966Oi+/2aT0Iv
	 Nrax5H46ghBV/X1O1WiuoA2DwYwIBVGyUUIwu0T7kPvvybC0y9oj5DmUr5yCmw6UsL
	 mWTcpRe5dc5AErg5g1Hx02pvle3X7JZdFhp6AKhP9IYus1ygXQ0j/1Krf9Ie34EFZC
	 Pso1zstElnjJ9hxsb8sgTspJcSeF9njCFnlop1FsAsXNnczmIE9uDqC46OpXdYh0qT
	 JGHeVxqEwGIPXBVgueuXP8Lu70ihE7mZ4eeP+QeJHrFDCJcGEFQcXaG/6RgEmWcXQJ
	 pYfruYAL/KsLg==
Message-ID: <sashiko-outbox-210478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 13/17] ALSA: virtio: prioritize capture period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-14-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:46:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use system_highpri_wq for capture progress notifications. Capture now
> always uses request-owned storage. Playback keeps the ordinary
> workqueue. This preserves the priority proposal separately from recovery
> and accounting. It provides no hard real-time guarantee and cannot
> prevent reader overruns.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D13

