Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563382;
	b=qac0UyyE6xXKXQOXOLi4ACd64b6+aTYKLwxxu+dX9XCmwo+rC99VHRI07eslNaeHbdx0
	 8dQyCv/ibKWT7WQCx8TeW6vZi7rY0LIGuGo3WttrjfPaFhFJ4chBcxv2SXgCDVFwjmf57
	 bSRjbi+mCLvRvG43h+s5cG8WLK7JKRB+88Dj82ENE2mm37ijsIung3GQ4RjwHOaK3uphG
	 nrrxGib4Im47GngAJwxREzgg1gxspBF8LN3o6cYvgeQKG+ufxywwu3E+wODDALvtlF2qI
	 a6ekRttUjXWAu9qajjItDca/GqjyiQMxe5+JeuWnhn2Nt4CHSP7PBHwBVjK/kS/Dm/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7Nmgt7Y/ChH8wkXCUsIoC+f4N+mFeRZ9RdJZeROUCgI=;
	b=h4eJyk58OjoUoOVxV+dC42M4HFXnfYoQKLkzj2rZfM2WLNy/hX2R7VIt7glkoQk7be5M
	 ZH2Fx9dOFT9E83yWeW31nfoXSzOxFanq48uo8c7wtPzRI2bx/xvyBHyaS9dxb0tvkI/A9
	 KTJY6cpiSWW25YCEyhkC+Q7RQpvLJVBtCCwOLUmpDfwV8guH1zEsypiDB098OxqMIEPZj
	 JUMD2c4CK8kNJq1ndvkvspRM5EcHcU66WZ/io///3gb8jpYti4JSUE3/M0KGhJbvzbUoO
	 u0QNjt0RyIO1l1HmFB37CYiUjTpY8QL1qBpOKScfA8KkHdnZ+OxIg/IMp8rwAeqWg1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWitnAwM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B3606A888
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWitnAwM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53C81F000C5;
	Fri, 13 Nov 2026 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563382;
	bh=7Nmgt7Y/ChH8wkXCUsIoC+f4N+mFeRZ9RdJZeROUCgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bWitnAwMz9OSBdI04GCBOoJVh/F8U0GS75FZ2CBp4Qo/EZBmUkvKzNmoGU9GhVX4i
	 OLWUk+fB/SMxd2ogmxlH39/LNqVFjf3RdrDAqumjuDO7/4VEelscRWh1IJyLCvvm8y
	 KqoZ/t/cckYiwNu5BB028ys2k70jkJdzQEWekErnHaM7A1AgF7TGVn/3hp8kGdDDsD
	 ei67osNxp2TwpXEEGnwo9ZNauDsmzOjWfhXZdQvJK7VVx5ZR+N5TA1OmqDYAzW1DaZ
	 HNP4O4xhFEHvBeT8Z1y9EDwn13cBc2XymjO3q5J18hBe2rJ26fgerBYcNZ70ToprKg
	 xFav4X1ICExCQ==
Message-ID: <sashiko-outbox-212577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 18/18] ALSA: virtio: settle PCM control state from
 late replies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-18-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-18-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:49:41 +0000
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
> A native PCM control request that times out remains owned by the device.
> The driver therefore stops sending PCM control requests for the stream
> until the device state is known. Only a device reset cleared that state,
> and a reset happens only on remove or freeze. One reply arriving after
> msg_timeout_ms left open, hw_params, prepare and trigger returning -EIO
> until the driver was rebound or the guest resumed from suspend.
>=20
> Keep the ordering guarantee, but let the reply resolve it. After a
> synchronous wait times out, decide under the control queue lock whether
> the reply has already completed. If not, mark the request late and count
> it on the substream. When the device completes the request, apply its
> result to the native device state and clear the unknown state once no
> late request remains:
> [ ... ]
> queue and stream locks before restoring capture_stopping and
> capture_quiet_sequence.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D18

