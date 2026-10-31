Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412930;
	b=M+R3dnYg1KaJuQ4WqrJrzSNWFnq4mPpWAdjdhHU+xneTsCKm68/JgtHB57kK/0eGIQ2O
	 m1tXd7/NS/i73eqimWICLg8EpxVTyPobPlVkHkiHqPM3QZDmQOrmbjPwsSx+SrBskCvnh
	 xDHt4kToXpsJiRe0Jklv2hfZY3YGmdPxCyDT+WB7rXr8ad843AZirzw81OcDAzihlGb3s
	 76d1axQwhHYcZenVrY/BUxDjnxNgAhkjIlDPvzM99G1wE+6n9zG1gydjj5tEa+e2bA9sU
	 8d7gkpMJXUHVkvOLRtJjEKMucNty6EYkwFSFku3dBz/OA+PkpNUxmqbRuDBJzhBbd7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412930;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3SPoXBPRF6vmk+JAyfxHozxILfWaD+y+g4kbi1nELQg=;
	b=lSDmBXNQUbdC3m7dNhsZyNcqPqzFgPmrNnHlXLYmvcvgn11//cHcDoEFwBp84DsAUJsM
	 NPD/agNXB0Auz1HdneOMVPeg/LaRQ6mCxcK1cgaDdnKtmQTiJjoHjJNLoQnJZUMIb4Jrn
	 WDbmdsxsKk9BqLufJm+hncpJaoDBkU6rIJHEuQ7NglSJM2qubjw9TmhtbmNujB3OKNITg
	 5ZIaYaH1LvVDhZnViop9msh1p2A5EqKQrhdKN1Kjf9Gt/4oAWnLMy8XM/BDT7givKbbtH
	 XEX8pgdG6y/6lmG4cpNRsHaQfvusWbPOuDqeSRoch5RiNjzEKj03OoV/PLBeAdYtlhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYciHZOu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709E606A31D
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYciHZOu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360661F000C1;
	Sat, 31 Oct 2026 02:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793412930;
	bh=3SPoXBPRF6vmk+JAyfxHozxILfWaD+y+g4kbi1nELQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYciHZOufgUNqppTeTyjiKhpmov0UxkzcfjM0pkNdV7oScjW/JWL8hvicE0lGP1VG
	 acuGW3Q+ZysB254rJeIdSQ81zjW4yQ/4aeHNo7jeceJwiiFJxSOoMNWAK6XeS0T+Pm
	 gNa1tRinq+nEbeiMzWlO47nItQbzntT1v1T997DR+WrkQOu7HOO2aMJ2bAVGWryw7t
	 8r+k1oBSVD/FGFimCfD2McB4/UB/4o3d4/h7RWv3chmHxd/yJLMGZED6wfx/WVj45l
	 4ouDD0jM8+RhPrUA7HNKKHOL3Y9fDLabWIWyuaA1pwMD/IHhpMotinWBlVv/h0xJZ0
	 LgKQ0HwikRMqA==
Message-ID: <sashiko-outbox-191701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/14] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-11-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:15:29 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D10

