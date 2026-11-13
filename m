Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552688;
	b=Zk51PCuKL590ZFZNXEEjT2owWYJ1UdqyG9Fp+3IQ9pmzOgN0uKZy25ATu9MbxFs0TGhw
	 l1SwSBQk+bTre7e2BFEv4knqgp3JM6z0eqRw/jRKR4rcJ/DZQsssiZuJ0sqg3uqJsl/fG
	 m0juOPATWdXZG5cU9pY7KKoMxUfo9q9YLtFfVCRkgIs6K2nbAUssTzlp8t+gq+c0j/4B6
	 dsZoS+Cykl/NFLmis5BPOGxo9feKM0/f8ugDZEz0gFhsDJMWC02ts/JMfWdXKY5KePX00
	 Kck4KHD54QEyzGdtdCEZCfvtMgI2sU4SSXJoYwQeMWMxf5PMP+KwILGqpqQBCfE1PLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552688;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Txq/yEIfw4p4I5S0HJ1G3cfwCWM4Vn4V4JPy8Cl2rzg=;
	b=s+G62L94ALSsMSeEKPEdgqIVAmTHjznDRna+WYMwbYdyYguWNYsMS8xVon9bA7dlWooN
	 TFiPADYLgAxqOvlBjtceSm3Choh3XIeYmgBN4srmkEWr7MtMXK6YwAh0Z6LsQa3ruBKLZ
	 7xAkt2WHQsZ0k0IqAsMH6s6IxZdswZ9+ydgYRzUgJOPA6DujinmlDZtUDCsGGtqK23TG/
	 e0iadC1kxBKPCBuDJTP5cgNXeKSmueKWoYQ10fNwppo6rqkisS2SpCkFQomkJdakSrCJw
	 knHKyAb0O5uzT97X90lrVmujoIHuHSzpRTXfpB7gbDh4HByIC76tW27bft8ieD/9hkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LI8GkJ9y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42135606A323
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LI8GkJ9y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95561F000C4;
	Fri, 13 Nov 2026 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552688;
	bh=Txq/yEIfw4p4I5S0HJ1G3cfwCWM4Vn4V4JPy8Cl2rzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LI8GkJ9yKQwStzA4cekfOIsgYx+tXEUcioVe4TXyplV/Qgjh2MtRp562wTFyVFFm4
	 IfBdFC5t47XjtGaZ5T7SCcF2DX/2ooFib3A2Ev+JoAcTbShl7ozxd3OuAEJLq98Bf5
	 avEPNtYqdlylK3d65jecnnTyCPkJYvd1cXOl5+WDPzJli5p3WS+Qh8GkkhkeBl02H8
	 0oHGTr1XTuurZxJ9pAFDScD4/wtmgLEIQ3JmXQ7eGxy/xOxLUS/jvnMLnPRsnLOSzC
	 TZYPLUbeanTKzL/JR31VsyBCWGhzeKBzqVPyeKgNoj1NE6jvghz+it5wD8qJIwI+3Z
	 5v+WN2Bx2Br1A==
Message-ID: <sashiko-outbox-212292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 03/20] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-3-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-3-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:51:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery. A
> negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> [ ... ]
> leave prepare-time filling to the normal START path, preserving samples
> written and rewound after prepare.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D3

