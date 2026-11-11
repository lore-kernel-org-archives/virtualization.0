Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383731;
	b=IE7c/Z9KI3upxMTsyXcY2b4Y7rp3FWvo5Jq7rdfQUlflcGOwLR7ixvBwWzTIf9mvdyP2
	 cBr2yk2OdpvMLikv3/+s/P44HSfrEaw0OCQHw3EtKmZBCqYyGEvCHD/ppDaR2cd0ugSWA
	 bo24S0BQXGg1hkfuhGr7xHiExNmESqE8acc4BOc+POX8nLztMrAq42SPpRI45Ty4RlZTJ
	 rTOC1KWLCoEJD2Fg4NPLrXwV4on4LVZcMyoy+4iKXmfi2l2J8x3sZdXmAUT64LiptzuUy
	 Ksx8zlMrzfFBFYCgTG7cldPMiRHiC6i8+wI3Btc0ApsAfQ9xEgesnk5I+MlmJkp3yLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383731;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JoF8MXMiF7zFVCTRQA/gy5TpzuZtIMtVlvS+WTG+2yY=;
	b=2XDfBRZ1Md64aodx5O0vpirAUlLGLyU4il8l1qhHMn3/4F+fNd0b6QWyHwncdc34J38T
	 dVF/PZKl1a5/Nd7yZw4shmc5C/KNaz2C9FJoRppwMZymnaNoXMKVmhJrybbEUgEz2+EQc
	 y8radcWtV/3DI6FzdJBZXfaFdcVXm/9ep3eyZqs/kVm7MGtRocpIT1M17N+Q/lFJkQMAA
	 CHB7d+0bm6G4BoIyG5mpDDwLhZFc55ouOC8CDvGeE0ehFlv0LUAArPn3Xo0/rod/Tt9Yj
	 ZcYjsbic+tc2Mnc4kxT6sAW3+Juwi59kzdjweWFG2w6PiEv4I/Lyihh/pbCIbd2rzdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IV/bE6pN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A024B60A2603
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IV/bE6pN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0320B1F00A06;
	Wed, 11 Nov 2026 07:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794383731;
	bh=JoF8MXMiF7zFVCTRQA/gy5TpzuZtIMtVlvS+WTG+2yY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IV/bE6pN6yWDFOteKWyE+raUYb3yI/JL+VkbKIQYlQrs77LBRE0L9IHiXT8XOJttt
	 6MZUJlXJjOnswgWAWjmJ1aragGmeAz9hJlNMOrVGeaE4xWGSq+boq6q5c3PjRuSPvJ
	 PwGFUap0TY/Aj0CFPzun34t8frnmEKuE15EFmOKiSPsKHOj4FKQMwGo0V4+Sacxklt
	 aCMMP+8gEHQCyuxtUb8c0DDlRAXxl3FkGkkU8vdckLvEkal+HKEj4aKIjKtFY3A03Q
	 bHdZyoekk/qrQZxqJ8Z204pYNql/jM3iIAjAcNHdAHYf20V7Tu4FdOTOAG2yWTnJK6
	 zwnCcvQNWGl0Q==
Message-ID: <sashiko-outbox-208550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_pci_modern: don't sleep in atomic context in
 admin cmd submission
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hyunjung Ko" <hj351016@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111075154.3017978-1-hj351016@gmail.com>
References: <20261111075154.3017978-1-hj351016@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 07:55:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtqueue_exec_admin_cmd() calls virtqueue_add_sgs() with GFP_KERNEL while
> holding admin_vq->lock, which is taken with spin_lock_irqsave(). The admin
> virtqueue is created with ctx=3Dfalse, so when the device has negotiated
> VIRTIO_RING_F_INDIRECT_DESC it uses indirect descriptors and
> virtqueue_add() allocates the indirect descriptor table with the passed
> gfp. Admin commands always have more than one sg (header plus status), so
> the indirect path is taken and a GFP_KERNEL allocation may sleep while
> interrupts are disabled under the spinlock, triggering a "BUG: sleeping
> function called from invalid context" splat with CONFIG_DEBUG_ATOMIC_SLEE=
P.
>=20
> Use GFP_ATOMIC for the descriptor allocation that runs under the lock; the
> table is small and the -ENOMEM path is already handled.
>=20
> Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy l=
oop to wait on admin cmd result")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111075154.3017=
978-1-hj351016@gmail.com?part=3D1

