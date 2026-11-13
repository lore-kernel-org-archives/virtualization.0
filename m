Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553685;
	b=KBFKnu1YbTGYZl1D7R0rWCj30QtypbLQr+4sgLosWl0kRInwRpIqT/GZ4l2dbVxsdvEO
	 DUpfTLB98iuYdTyV4N/9T1aN7GYPEtDnl7XLFOU68XmTbj6+dQxArr8rJ5XFFMikTUhy7
	 JQil+OvoOK0GSs7u6sy7xBcpaPheVb49Z4vD+nIzr8CDANm6C7mkh0xUZenyzJqEL9944
	 HWn/ZgMq9eEpHsI6m86nSfwJ0R7LSgpTjCysM9ls9G2R4ypRJSBWglk3R4pBiR0RB2W0l
	 LJeq7mhBFalHLYGqEo+KDwRLn3p5LOD9DFjiHWHwklOMp9YbWEwDNiKQlF5sQJ+4UlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aHPHIrChHSzAkjv2dW6BaZXGtNbEYRGzYCB8ZqufULY=;
	b=i0iMKql8jv0AqOIKmARjR4iM2yVL/TESx3ug29yqmmOztqAB2dfRTV2Z6JnY8pKev018
	 N19g9KdH3gDq6Uw4DFSBsU5pgY2x0Bi9znCihKEJNDf04KWJVUpWVngC6X35/QPcu73TA
	 NssMflfolUenxRmbJ+I5ZtxlklXr6v3ukXChTSQiH3md3JxXAToRhAYLpcqstqprD0aY2
	 0x2mDORKAX4TK+X8I7JU2lzWzuB2H5qBio9ecqA7O8yuYuFploNYwnY1jFByB5h/AOAfK
	 7MrJwyKeESkaPJ1tgWfMx8hZp8MPddrnlHnSVq4Cu7vEDOUtGGrvvfZCp1On/Z7Dp9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvxwlXht;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D7606A321
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvxwlXht
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC10C1F000C7;
	Fri, 13 Nov 2026 07:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553685;
	bh=aHPHIrChHSzAkjv2dW6BaZXGtNbEYRGzYCB8ZqufULY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvxwlXhtZiUedDXsNmClqLcNeOstYPhW3ljTpElyF0JeE9Wt2xKWfjbifcD/SgFg2
	 raNJuzBPbf/ma8EISz3Eo65GscMt/RHbgCHdfMoi5XLdFYxtJKuiacw/c5k9lRD/zD
	 rrnJYKRBhQ7jAQUnT7oSLHs95G8RxO7ynPKhyxOtEUqsBejCMEVS8FDCvMPnUg/KD0
	 pYXs1M7+FC3dUXdCfbsUWHfYnc99HT/Ia+f5LgdpbJdMU+EgJaAVxuxbsV08ADj2IJ
	 3nxqpLQTg4quFfFveFm2YUSf8nKWeCXwo2/sjZ2JZlTlgc7JhJPyN+1Euvec7I0hjB
	 AH6p/nazdvNVw==
Message-ID: <sashiko-outbox-212319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 17/20] ALSA: virtio: preserve playback progress
 across pause and buffer access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-17-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-17-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:08:04 +0000
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
> TX completions can arrive after PAUSE closes transfer admission.
> Preserve that progress and schedule catch-up when the stream resumes or
> a rejected pause restores RUNNING. Cache device latency in stream-owned
> state so a late completion does not need to dereference the ALSA
> runtime. Clear both the cache and runtime delay on prepare and before
> RESET observes the hardware pointer.
>=20
> A playback pointer callback can also invoke ACK while the core has
> closed buffer-access admission, after the pointer helper has already
> accounted for completed hardware bytes. Track that callback context and
> refill only previously committed data using pcm_indirect.appl_ptr. Keep
> rejecting other ACKs while the gate is closed, and use the
> snd_pcm_indirect_playback_transfer_appl_ptr() for the refill. If
> [ ... ]
> mutation used a test-only kernel hook because ARM64 control-page mmap is
> unsupported. KASAN and lockdep reported no diagnostics.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D17

