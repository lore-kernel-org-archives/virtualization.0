Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700913;
	b=xnSEacmS6H8/mtcCGJr5BKhpuRn6FTYXmu5bmpoW4O5LnHsekzpfbeRtf1PBbDhqthYo
	 INROAQAQjuhIC1QhJ1MnQ9jjm8C1WXRe1CcKtNCLooPkonZDEER3vgfzBcvdTjEx1BOe0
	 QyUm3GcPSeF+gqEHspcBL6xgboNd1UFJbjVpd7D2X3rpG1J9347KW6hGh/bASRD2XhLgB
	 e09PFcY9Opi8q1QnBA3IRMQu8lzM7WV5PdWCBLFtPQTLzf5+0UQRVCVFT0ZaKoJBj3t4h
	 9eGUTjeNHzV4VRKpDMCOR/rE/CNnOMCbR1dVRN1n1oIJlOS9jYFhgzOvebcRp5U7Z2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fI0yaMsI1qz5STKu9i5w9psYxY1xeRBzroBBP3f1qfE=;
	b=UOdj/iQIOq5GKded4+iCD6r3bIRW9hDHVChIDDK+E5eVt+TmupJd5TuSakOTOJ9mlXIj
	 qESdHdgVqsg0YeDyIyEe55oXHZLe/nOk7Z1KlNnA6fND5V/M8mvjfs3zfP83ExIR4qB0p
	 PcqdNyScRP9y1o99COaqQd1CvKxGLzsExDnw5pHdkCJSBEOXsl3PLmoqvEhjsMWlI9dsc
	 4CZJFofBx70UHFguA4cEyCaOF2X7zRSjpyo1YN8IlMb8wWPc5RdYr6AMOiydoK7XoPAhQ
	 L/Lce+T3RX3WbK3ve2ZsGBcnuJCB3bhJ5rCpvVAZA04kYtbDPj1dvmcBAyOPp2icTJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zbv46yBf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C725606C563
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zbv46yBf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C6D1F00A15;
	Tue,  3 Nov 2026 10:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700913;
	bh=fI0yaMsI1qz5STKu9i5w9psYxY1xeRBzroBBP3f1qfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zbv46yBfOk+Y2FselE+WZEbT2UolfEn/D8I/9B9Av4Q9SVAZHiK/esZ7TPZDEx7sh
	 ObUKWM2StwGFY+thxp5ilyoYZcf77pXQJeUz5lZp0LeD2ShnheVT53Wa1kikbPgrtp
	 La/GoFI3TDUAeL0O6Gx6iipXMd+AUAzbaPOdi66Gz4GQJVNXrqmVvDIlQnR+WOmexc
	 e1mcxN2vU3vLpAlKV0aAzr5+e3nmgk++LY7ysVhFNb9jJAVQUVTSeI/ze/DVU3js8P
	 an+gM38EYq2aL2GILmDhum64dI4H/HRuML4LmN8VNg4zOnyMFj4kyx84UoRX7epl5S
	 LhkvJoTo51Ubg==
Message-ID: <sashiko-outbox-195020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-7-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:15:12 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request is
> still pending. A later teardown may then submit another RELEASE before the
> first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels t=
he
> pending request and wakes the waiter.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D6

