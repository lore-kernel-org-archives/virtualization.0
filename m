Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356699;
	b=CoVZbp0gplz47WRawqTDqrQrrbSgTnLGUcKsnf3tBc9AB72btrHSsw6PmI+SgBTiwUtW
	 8OJd2LSKiV2B451Xcb5dNfP11MfZ9BujDbaGbShD+s0k3/lkrh8jVULAwyX/8zqhN0cep
	 veRkifmZGfeT7UBTA58dGJHzn+D3Paf0mQdhxnHBHgbHPQJCCm/q8ZFPUcSDT5/YODVyv
	 PHZXWMQm1fOfyMKy0RHh40X75J1oQ0wMTmVAYfVGjM0uuyh9VXkNyKyV2C+5nw4AqhWHY
	 lIZ92+7s+vbgt43UgS/Dv/pvMWi9GuGsN4JhUwo7LYk+kxARMXVjuxvuca1GBSYaC7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WsBi777XavrjKewdKiTxBPDXinjpbSf1xwPoRjJRMP0=;
	b=28k0d48igEBJMbM2sIRAoAeEYrGQK2rxwPS/07bQhYGre8iXFXT8SpWCODqt/Uy6X+FH
	 6XM56p35mGA0GpvTWsR5moWCx8I8U9O+5w1/I24ePCyZjDk/AT7Ys0UA2CufWi89F63Hx
	 JwXZUtoAx13Q9VvsoD/2hMzm7fg/ef9Ljd3+zhOJ7AOIONUfCJT3IR7XGr68FxHZZGgzL
	 3zBjD15kSRGlKOv/bnPeBTGpTUI2/tGfYIatDBgjBJBSGBrcZwC/KpL90Ln9VoNRC9CRT
	 o2FPjI91tb6ZxIPNZ4zZ9V0o2YJlZo+KMAdObt9tKNcmn9oyt9Hwh+Wj04dCVpoOSWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMBgBqSX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E1606A325;
	Wed, 11 Nov 2026 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMBgBqSX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3B61F0093D;
	Wed, 11 Nov 2026 00:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356698;
	bh=WsBi777XavrjKewdKiTxBPDXinjpbSf1xwPoRjJRMP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMBgBqSXYViRzu8PCgzdreTc03M+VoV/sLlTO49bpevxGIlfMcODUBEiBTr3N1WSO
	 mX5qqR7e/OGo4VI5uMUHe8lRt796WUoiCItn+zLVxzQcLJ2O7xanctvU2H/lwK/Su3
	 Jdjjs0D0vVVP51+fd17l1OnBv2t1bZob9YgLqPWg/1gBuf/BWTgZvhtVWVoalqWUIm
	 Eu+PhMDB2qkKPEleP+yks/5oU6ZJObIULjnR/mNKeLTU689MpjUSjUPesDhjHd0Cay
	 UzAMShqkYwhlHq10qQ/91Wt5vowHVWVX5MAdD8nYtGQwmq4F0kXlIYMQmztfbBSFqY
	 CMSkmTzJ69Diw==
Message-ID: <sashiko-outbox-208014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 14/16] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-15-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-15-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:24:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] docs: kernel-parameters: wrong resume sequence for
  capture_pause_restart
- [Low] docs: kernel-parameters: changelog removal claim and misplaced
  capture notes
--

commit f206bce4fef897e65bfa607d98ee01bb4cbeb0fd
Author: Joonho Lee <mynameisjune111@gmail.com>

docs: describe virtio-sound capture options

This commit documents the virtio_snd.capture_packed_status and
virtio_snd.capture_pause_restart module parameters and the capture
buffer behavior in Documentation/admin-guide/kernel-parameters.txt.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index e75344f4e0cde..8a9e062ac33f6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -8344,6 +8344,29 @@ Kernel parameters
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
> +			resume, send SET_PARAMS, PREPARE, and START. With this
> +			option disabled, pause uses STOP and START while retaining
> +			the prepared stream.
> +			Format: <bool>
> +			Default: false.

[Severity: Low]
Does resume from pause actually send SET_PARAMS when
virtio_snd.capture_pause_restart is enabled?

On SNDRV_PCM_TRIGGER_PAUSE_RELEASE, virtsnd_pcm_pause_restart_start()
with resume =3D=3D true calls virtsnd_pcm_pause_prepare() to send
VIRTIO_SND_R_PCM_PREPARE and then sends VIRTIO_SND_R_PCM_START, without
calling virtsnd_pcm_dev_set_params().

> +
> +			Capture always receives into request-owned buffers, then
> +			appends validated, frame-aligned audio to the ALSA ring in
> +			request order. A valid short response is retained. Empty
> +			responses are tolerated only during bounded startup or for
> +			requests already in flight at STOP or PAUSE. This uses up
> +			to one PCM buffer of temporary memory and copies returned
> +			audio into the ALSA ring.

[Severity: Low]
This paragraph describes unconditional capture behavior rather than the
virtio_snd.capture_pause_restart=3D parameter, but it is indented inside
that parameter's entry after its Format and Default lines.  In addition,
the commit message says "Remove the earlier opt-in staging and
short/empty-response descriptions", which seems to describe a change
against an earlier revision of the series rather than the baseline tree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D14
