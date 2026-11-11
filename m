Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378399;
	b=GURmx78cGKTnF8alXr1QuTe9+TXCUyYQU0lAZ4h2YPvM2sVtJN4cwoGz9uXLuqhHYY1B
	 Uos6pI0MMLbLhHO5cwBiYstwXMOfs3WKfUnWx6x+7gK31v7SgO89x9QCpa+6MNslSKVlO
	 VUIapOBjl72AS0WHIH+LV1oPa3SK2SGCayY3TBKK4FPKaHQDjquUv0ZHtSWnuvqcVgk8i
	 V6SG7/gJNVJNDzO8NV5H5WXseuBTeECJWgsk9943kKo3rEaSXeq36qmGdUlL5O/eiNyr9
	 3szdljQdOhx4QUaYKVdhaWbsWZWzALk5nljhZkNKqCBTAAqmVinCaFv/exlEWymqGbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378399;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jhEhYG6lShC/Pq6z37LdgWTX2cDvdALdxe5h/3euZMk=;
	b=KssyjoPNXaVUq8d2ggTGFPwedPqg4jpOZK9lIn2gM2anrP2UXwa/GZ8RTGGCEEKBFviC
	 RkO1RMTHF+cgz/HfSc7uSZsZR2W8dRH6nvZl9Amy3cZprGQfErXW21l3xk3wbFWXG0sAC
	 HwGl5HN8MtnSJqmrHHx/XkCjEdhIltF1aJQN++3jOAvnSwij3E5Zs/JR4wjCnStpJfu3I
	 BV/RlkEUPd8iAHHsQMIQyRg2A+jueFUZ3KAY+MyEKsemqblqOcni4nqAsUwjo9R+AWGHP
	 SzDJdWdc95xgUy5hvMCiAEQ2iQJvP7pokLgeGIIiUo08iTQyiKttsezoPQbya5k8glA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALbikmyP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF8606A326;
	Wed, 11 Nov 2026 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALbikmyP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E75B1F00A06;
	Wed, 11 Nov 2026 06:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794378399;
	bh=jhEhYG6lShC/Pq6z37LdgWTX2cDvdALdxe5h/3euZMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ALbikmyPJg/vcTQVCE5/Pg3udroW0At9A52rjTHuhn48eIRoNmwB5BxLPV1g6ZbhJ
	 i61XkUi8oVaacaCrz5mKE8+BLfXpscBcYH8E8+1Jt/Q/fWMVLuLmUQ3dmaH2qWWCXC
	 Uz53dLQcT2pkneHkvUyVUY7cs9esWm0P6HRMJ4KHr1DH4s3qPptmW8LHt9ZlgDpC1S
	 vSDF1AyJAFzsNZB/q3mDiv96Ca3aQb0NzItSnZAmkGfrjElO0jOXYIkyT/BkzUeli9
	 Jp7nA6ipJ7UpDIC2TaTnbmGsMSGGpyQ/9ECb13piXs/96sVT6Ue5XM9DzEBvZ7wUN8
	 pA5CjYZldo11w==
Message-ID: <sashiko-outbox-208439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 14/16] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-15-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-15-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:26:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] docs: sound: virtio-snd module parameters omitted in
  alsa-configuration.rst
--

commit fc63ed4859aff78c0a8bfa3a6ac071eee34558c9
Author: Joonho Lee <mynameisjune111@gmail.com>

docs: describe virtio-sound capture options

This commit documents virtio-snd capture buffer handling in
Documentation/sound/alsa-configuration.rst and adds entries for the
virtio_snd.capture_packed_status and virtio_snd.capture_pause_restart
parameters in Documentation/admin-guide/kernel-parameters.txt.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index e75344f4e0cde..ca3fd768b4395 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -8344,6 +8344,20 @@ Kernel parameters
> =20
>  			Can be used multiple times for multiple devices.
> =20
> +	virtio_snd.capture_packed_status=3D [HW,ALSA]
> +			Read an explicitly enabled packed status trailer after
> +			the returned capture data. The fixed status scatterlist is
> +			used by default.
> +			Format: <bool>
> +			Default: false.
> +
> +	virtio_snd.capture_pause_restart=3D [HW,ALSA]
> +			Stop and release the stream when pausing capture. On
> +			resume, send PREPARE and START. If disabled, pause uses
> +			STOP and START while retaining the prepared stream.
> +			Format: <bool>
> +			Default: false.
> +
>  	vga=3D		[BOOT,X86-32] Select a particular video mode
>  			See Documentation/arch/x86/boot.rst and
>  			Documentation/admin-guide/svga.rst.
> diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/s=
ound/alsa-configuration.rst
> index 689eccf6a5921..d40c683abc63e 100644
> --- a/Documentation/sound/alsa-configuration.rst
> +++ b/Documentation/sound/alsa-configuration.rst
> @@ -2537,6 +2537,21 @@ midi_devs
> =20
>  This module supports multiple cards.
> =20
> +Module virtio-snd
> +-----------------
> +
> +Virtio-sound capture receives data into a separate request buffer for ea=
ch
> +PCM period. The driver validates the responses and appends frame-aligned=
 audio
> +to the ALSA ring in request order. Valid short responses are retained. E=
mpty
> +responses are accepted only during bounded startup or for requests alrea=
dy in
> +flight at STOP or PAUSE.
> +
> +On MMU systems, the request buffers are vmalloc-backed and page-rounded
> +individually. Allocator rounding can make total additional memory exceed=
 the
> +ALSA ring size, especially with small periods. The request buffers remain
> +allocated from hw_params until hw_free.
> +Captured audio is copied from each request buffer into the ALSA ring.

[Severity: Low]
Should capture_packed_status and capture_pause_restart also be documented
here under the "Module virtio-snd" section?

CONFIG_SND_VIRTIO is tristate and defines these options with
module_param_named() in sound/virtio/virtio_pcm_ops.c, while
Documentation/admin-guide/kernel-parameters.txt directs [HW,ALSA] users
to Documentation/sound/alsa-configuration.rst for per-driver ALSA module
parameters.  This new "Module virtio-snd" subsection sits inside the
"Module parameters" section of alsa-configuration.rst, so readers looking
there for the module's parameters will not find capture_packed_status or
capture_pause_restart listed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D14
