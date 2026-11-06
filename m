Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989781;
	b=sSF37RGTqzbRhI+hYlmpTjZuD45wdC+LPEAArAzL7g7NHSGcKNiPAbQJ3UF++3LZHf90
	 GvaBFOVTF48zyxzRm79xQOhLYT3Gl5GU9FQQp+dvvNZpvT0Ba/HAe25gsAy1gw1ZY7Izi
	 z8+7/wXYqpauOgu6iKM3Tborl2eJdjE3nfafu2yBFbThHDDwxgte+yfYNI67mV9/p/mo5
	 /mXgA1Ukzi4FHEI99JhL1zd+i528F1uyPQoveEqdPlYGfDElXgKbRxWSnU6YTkuZQEEyC
	 0gx7deWFHeDyS8tQ6RSzHmswavPuw6Iwj5LtJd7DEMC5+VT1nPyGzujqOtTyIewWLfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C1GOQe2MO5aR8EQKD0yxhnKG5KI/WvfC9alSZy/SxIg=;
	b=uFBEXAY5qKiyJ3SPdkPkLcfzc0IPx/UfciTaVwFHTyz1KF3BMftXuo4GQSzrsYxaYzBY
	 BUdyHpsdMBcpB28U1ipHpvMeE2IYvj9mWzhjJviv2xgoew5lSlozsKNagjlf6x1cL02rx
	 muRrDYjVg4kxY8ZDUEPIFXYaqnutFHnAXfHvWQVk+SxJVDOW6tG8MkzLyioJ4xNHMYC9x
	 7EaHtbKxzsKXpNQx3oS/nKIzZUly9RlxCEK4rd5eTHcC+IXlGXvrE2OwaThw618L38uqV
	 ZFhxErhUOlaHqGqPmop/N1g4fCLiPu/6yJdCneXdg5rfIRLKUJFHiRlcQfSLUrvwVYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejlCvW8M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B99606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejlCvW8M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CF01F0089F;
	Fri,  6 Nov 2026 18:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989781;
	bh=C1GOQe2MO5aR8EQKD0yxhnKG5KI/WvfC9alSZy/SxIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ejlCvW8MbUJuMOWFUe18suW8aGhxHK0Juar/A0pOhNE8WEaGG+4Wbd3+xwX5NVDAk
	 9maHxGylD1oDrl+914kS0JIn1aaDzX3HviYTJjJyBVCUVjKdqRppZwC3ukBQBsH2br
	 V73aKw9lkfBYcnbeAe77VE0En3WXWNCaDS6SlY06G7mXuzUlxHuiJ1VhWborxoD274
	 EpzgubisMoCb6ezUvBA+rWHUmxn060UWLSvdLl1BhNDKP7mQZq8nAIPu/OqZDH2dP7
	 fnIQR55JxnOKFXjQP9LOalG6yijHK/Zdswgmu7apQYJyuXjIRCzo7kMLZeX0Lf1KuG
	 JvwLzj/aHLPkQ==
Message-ID: <sashiko-outbox-202038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 08/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-9-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:29:40 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and
> payloads in the reference-counted message so caller cleanup cannot
> invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure.
> DMA cacheline alignment alone does not guarantee the structure's CPU
> alignment. Align regions to the greater of the DMA cacheline and
> control-value type alignment, and reserve prefix slack from the buffer
> base so typed accesses remain aligned while scatterlist regions stay on
> cacheline boundaries.
>=20
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D8

