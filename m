Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025615;
	b=FerRFpf19lNomiweuIWNciF+evgNo2GaKgC25egvyGHj1vBXOP/DPY5NsExa3JnrD1K1
	 0bylJKQMRdbuiK4Pi6RWKK6PlQpSz5MqgB6r/9fo8KELCp1xeOApIgJywG8rGPRIcZG06
	 FhE9CCBDcpZgBjPOMMVZaN8iYTFTGY4qOf2eLet0nE0EfLJhia5qBsAliFFNrxYAzPM5N
	 NqF9ATUjujAZxa2jV34PpUgGNldz5taW5T3XKHQ7rO7DoHkTqfr7ISC74pukBNVM3vCq4
	 3lbG2ha9JeeqikthBy1ZBIoC8rmexxAJnTYit+hIAtbKQjVYUmFVsYPlsGJdsUuPYpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025615;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IDPiSEghbBnGOtdqC+MYU1ta6GghQviPXHf3wgi9Hp4=;
	b=kN78dCus08pMH9yiELSUkQ955kYbvu0TcwhV4dUlYKp0qTwJZH8BCamJLDLSro77AUO/
	 VEuBcAnWEuTRASfvkpx6didIw5dbLuaMTdEvM7PVh5xVlJR+RNS+ESQVHimiNcVKsdn8b
	 Y6oG3ht2vnEhaSoQP4VEXUmy18u4Bbo34DSfyjt43P+anT62zit2QKYee/xNXeDrBfm4P
	 zr5wQXmTek9C/ilsZUZuoBNHF+MUEYJzd1+lYYtT9ClX0XzJKpKrQsOjO1IIZzi/HXCUv
	 78Hs+gRdG4xmnerZfjg1bkESQvsiyAeMaJSNXnuzHlDTy7bDQv4wPE6ANZoxwQYk6lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PZ/b8K1H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D1606A325
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZ/b8K1H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE6B1F031E0;
	Mon, 26 Oct 2026 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025614;
	bh=IDPiSEghbBnGOtdqC+MYU1ta6GghQviPXHf3wgi9Hp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PZ/b8K1Ha1FlMInrvPekKlH2y6VCL7Ey+4qxKTKfPWs3ObJ1PTLhBDey9w4ejE+Sn
	 Cz41AheEkYIJ2b35lAk0KWZi1pJtxFqdeIsjvUoUPjAgxaQdOqe3xfBZkgivz0lez/
	 cDBlz9VKNYn7QC8pa01NJBaH1hf9gViOJezm67jaC1CQXe1iLRRSeBXgb4cMN0c8pp
	 dsK94DbijwvgfPOArS4h8uPXiHLdC3ZtHBukQ3NxKQUOG2lJTyM26+8tr8G9OU2Vh0
	 bd40aU08rQBE00//a52LgrIL3WJPFX2Irh0puSqmBIYUAHUbYo18VpgY4sNhb//0M4
	 ZDvLy5CRq37/g==
Message-ID: <sashiko-outbox-185408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/23] drm/msm: Support KMS backends without a
 display IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 14:40:14 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Some MSM KMS backends receive display events through firmware or
> another transport and therefore have no host-visible display interrupt.
> Rejecting such a backend during common KMS initialization prevents
> it from using the MSM DRM framework.
>=20
> Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
> frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
> interrupt is reserved for power-notify acknowledgments. Existing
> IRQ-backed KMS implementations retain their current request and
> teardown flow.
>=20
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D21

