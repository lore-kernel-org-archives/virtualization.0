Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253123;
	b=T8QLvfTO+0em/LUagI3Yj44POhu/vMloynoeT/+o7n3LuVFfyLaO+zCUakfBXTZVME+f
	 Mp2aIHMjLKaN5A2xXU/K8JbXIjFl0Fd22/xPOs8aLjTP/EVIfuH2LRIf/ebFcj7ffFfnL
	 4HFTF42Qf8Fiv/YyUTWmW7XCAyw5jcCu8j7Dvj4q6i6rs0q7+C2GMiMIwQMmkKaSJeEPY
	 vakkE8ncSTDXxHAaFthgNCFVhyd/329c6hCCQqe1pp07MALqjnhmdokNf094xvPXGUBkw
	 ENp8J+X9IFiZ66NReAksqkCA96hUWXRYDfWvNElr8jhDVQMB9YtqTXjbsNhVF8DgBUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UpDaCC68JeFTfQRtIVsWigzo75YpXpCD9SYWhs7dsJk=;
	b=VJJ/HKMOm+wWKknhx0U/oZ9ylOcz0Hw3iDPcRG0SW9hfefDRowmBOoTw2Uan+idnyY5q
	 v30QURQqlsoXFxo5bJwHMI2g8hzFaGCQ4wCdsvuwX8b95bZdPolZ7zPlIdCqILEeCUZmH
	 uBMMltioR3J08b47d5YFoO5UwRXaeWWceA/1bsO4CoY+TcRAxGCRD+yDZ9hkL83GpYBQC
	 WyTPOVCpPg2rS1XudI3slCDkS/2nEYiDqwTp2aQ1rt/5+7eW7vgQnvqRROCYWvO7myra3
	 6BSYPSMFlocf96CJ0NXAWZz+K3bMWiwHavcpGk8D9SOyyjFVqCGGqG/UgusWyAD6s4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emH1izkv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBA606A320
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emH1izkv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0E51F01825;
	Thu, 29 Oct 2026 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253122;
	bh=UpDaCC68JeFTfQRtIVsWigzo75YpXpCD9SYWhs7dsJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=emH1izkvN/DokNcuNGlFtLACJklPxZ4MM369szoXzfgNK6ozOseICvF4PSLjTCeTw
	 HTec0DxkctJRzsJbpf0Aq/ddnJFNXyMhQKUcz1BET53gOrKV88i22pL8pToHeVh5Kv
	 3kKsMgC1R2LuaXSDdYV0gj0torj3LGlyjXlS4B2Xq7lOmXztc03qHfcU10M/6gKXSv
	 JyMol7YS36vLFHLRXN1ifrKEM3rXfwrbIzoP4QcgfCor1lB08VhtO3qi+rU0IfDxdX
	 9Iq0czDpiIyAEj7BEzFvXvncFSFclUnwit+l38zFFKLIw2pMfDHkxmu/z0JeWB/a7X
	 0psIc/7pBm/4Q==
Message-ID: <sashiko-outbox-188777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/14] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-13-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:52:01 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver which keeps private capture counters needs to reset those
> counters together with the PCM application's position. The ioctl RESET
> path releases the stream lock before core completes the position rebase,
> and appl_ptr is updated in a separate post_action. Period processing can
> observe the intermediate state.
>=20
> Add an optional reset operation whose stream lock remains held through
> the core position and appl_ptr updates. Export the common pointer reset
> as snd_pcm_lib_reset(), so drivers can reuse pointer validation, time
> accounting and XRUN handling without reacquiring the stream lock.
> Drivers without the new operation keep their existing ioctl path.
>=20
> A successful callback member completes its reset immediately. If a later
> linked member fails, the first error is returned and completed members
> are not rolled back. Legacy members retain the existing post_action
> [ ... ]
> a user-visible failure. The new-candidate tests validate the
> synchronization contract and recovery paths.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D12

