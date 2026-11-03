Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724943;
	b=Jr7kfxSCUsT/deiDDZI8CsKBoqmmmZsUF29SCuz582vjq2nUKH5RBfdrb9N7dcm/D/LT
	 bZqnCTkyYQ+CuC3zrMm6ebVg401VGTLBfvgHA7Ik6AlHmx7Y3aqpVsmvJfnwhZ1JQiKaJ
	 kG7hNuYxgzxdcSbhb9BIiDNm+uRKoiGKUqG6XGRwrgRZPyEumWwotBVvZQAges5oKOyiU
	 a7pqXNjftMWqBf3t3ET/620XHvYWBRbESKSYd9BuSujUAgA7QfRCEfRyT8SWarlTRQb+1
	 SnRAICsSsHMMUwAWqEjo4t8YOZtsPPuETgqVauL9f4fvuD+4zEEFsBBTVwyEmWupC4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724943;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AnPxafexipeXo/ZWTcKQBmfKEndxDbpHCQlpYxWQ9Bo=;
	b=qxa5nFR0XHulKdby9lK+IEqkMW5kIeQoct9a4aLzowyxXwkygDOQVse6cdWyXIiGdgmU
	 OlTBRGO73mZGL51Ex+xn+8xeMLyYn5EgVlMIAZbTBb4A8ywQJMOExqR7s7ZqnODuShJqS
	 +AVUUZP9bbun9oRoFeQgipZ4Hj2NmUmgLfHPNAs6uYJB7WX+ajT89Ds0da+SXOPq4Q935
	 l1kGf42tr14iDEKZwF9PMRnWjR1s7IJe68M0ksmAADSQIgKchRiNbYOcvZu12GrwJSNk4
	 xONBOfZwrjJUITdpl9NsNw4iIzPc3hV5LKmiNMsHhojJzt3ajIBOZWs/R1TorYmy3ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Om9m1PKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC4606A333
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Om9m1PKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937921F00A02;
	Tue,  3 Nov 2026 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724942;
	bh=AnPxafexipeXo/ZWTcKQBmfKEndxDbpHCQlpYxWQ9Bo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Om9m1PKIqimj07OW+Kd+OtNBFL2cTfmbqJ8YjAvqoeGsYU5gFF5+nxXhN4imswn+h
	 fIEeC1aeltL8os1Tg6/4e11+yVNA9aEW5MQgZIWiqnaxiBjeY0J/d0JjTnxgGIjWIj
	 HEh6pv6X+4HvZLT+r7lhNokS1z6GSCGQ4G958Zo/CupD1RMtZg/KCvpUIBtzuHLxIZ
	 b0/ai/vWmWk4eeTD+ZBsYAZ1Tfo9sGyb0ZhpsvbWGFAFvRevOafse6OcnVFzN/RLOZ
	 wopngSX/b3Sawl4kzpr/8SEtGlXuktM96zdzy82FgXMJ/zEAVgSIbv/par2gAv718f
	 6KeRevKIzF6bA==
Message-ID: <sashiko-outbox-195755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] hwrng: virtio - simplify virtrng_restore()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103165026.454333-4-blum@kernel.org>
References: <20261103165026.454333-3-blum@kernel.org>
 <20261103165026.454333-4-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:55:42 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Return errors directly to simplify the control flow.
>=20
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103165026.4543=
33-3-blum@kernel.org?part=3D2

