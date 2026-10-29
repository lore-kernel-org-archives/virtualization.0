Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253244;
	b=aaflH2ZVap8g8UqVQTuRCrqGa0wawetd7ywyxHScP5gR+AdkhDLOzpOwQ7FRc1Y98vP1
	 N5+aEaL3KGDrl02Hx6Zg6q0bZhXY+d/8ljsffXr20dVrfo60Gk/VhDFCo388mgJODNkIa
	 Sqr05jpSMKbH2tz7DrGDf35RnHgnqVociyAvNP2vTbwyo3NU29a8uU4xlRQ2DQThg3Ju/
	 yQodP0EZZ6HLPE9jYI+ECWmm3UltoCQWJKFd6KgWLNGcXpFGHvWWq3stFsIJLFP4ce61p
	 ptBqPedMfEWd86CikLCmYcMAaJHdSiOUx0B/ffr3FIriv72zH2V9PlzLJWjLqhu/SOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253244;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AieQM9WsY35MM95xjhY5gx7C3eRSNN4WOm//bIBgLtA=;
	b=kWJKnRBTpznBBi6sgHswPMP0fzCMEG8daMKD7mANl7Ykawea1TT1JYPukeyTLP79xclh
	 sbgBlNrwEbKwOZ5YCgrNY63VWXKFVBMPyH9keadMDNlj0hE9M3y8kX7yGBmTY7GmjuiYA
	 NAyamXc3/tH0KbmUHaMDq+/BrS3N8DEKSyrJ4Iqus1uAtGYVM3kmF5x+F57ISi7n11t3N
	 o2XRef0WcoMVCyP0Z7lYsMKaxvg1XY1WFDgr9+cBSF2aPg6vBGh4lioW4szv0xJ1CAy/U
	 zwXRRAzzVvTqZGrqMD2ZB+LoJTWBk5AF9ttiiQxze+0QGT7P100G6Ga85V7zSCZB61w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TydZXWL7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFFE606A31C;
	Thu, 29 Oct 2026 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TydZXWL7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CFD1F01825;
	Thu, 29 Oct 2026 05:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793253243;
	bh=AieQM9WsY35MM95xjhY5gx7C3eRSNN4WOm//bIBgLtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TydZXWL7EuFMJuoNmcUQNFkw7DKo5cWsiw/z0T5ZSFTqvcnAtwGH2hIDIxme6KErZ
	 QdH3MbmDtuGzY8a6g+XCmDi1lbGtFtSRL369XkRVxcZzb5RGkIPACYN1bo0W6EDmqy
	 +uEElT2gtMVQjZEzr9PxyFFhs7nE/QOewsLU+zjmIP7SNGt9lb3NgtCAbr2TDARwOk
	 Tm1Fy/r+JT6yd6/e8QzTvPOaQFYDi39v4iLorD4hmPTaCQbGmSyd56lfQbPNMrP1EG
	 DfWVE8OJ75tY9/USV2GS1toZxlTTtSENbXKulxWEPk34z9pcOY6LjtdhrCDLMTyWfY
	 zovkOudynrzQg==
Message-ID: <sashiko-outbox-188779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/14] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-6-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:54:03 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ALSA: virtio: misaligned virtio_snd_ctl_value access in virtsnd_=
kctl_get()
--

commit b0116a304a65fa5afc94f948da091c12c54f919b
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Keep control payloads alive through DMA completion

This commit moves control message headers and data payloads into a
reference-counted DMA buffer owned by struct virtio_snd_msg so that caller
cleanup on timeout or interruption does not invalidate in-flight DMA. It al=
so
aligns scatterlist regions to the greater of the DMA cacheline and
struct virtio_snd_ctl_value alignment.

> diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
> index 7114bea4033a5..2e0ff15e729da 100644
> --- a/sound/virtio/virtio_ctl_msg.c
> +++ b/sound/virtio/virtio_ctl_msg.c
[ ... ]
> @@ -85,20 +161,85 @@ void *virtsnd_ctl_msg_response(struct virtio_snd_msg=
 *msg)
>   * Return: Allocated message on success, NULL on failure.
>   */
>  struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t request_size,
> -					     size_t response_size, gfp_t gfp)
> +					     size_t response_size,
> +					     size_t request_data_size,
> +					     size_t response_data_size,
> +					     gfp_t gfp)
>  {
[ ... ]
> +	cache_alignment =3D dma_get_cache_alignment();
> +	if (cache_alignment <=3D 0)
> +		return NULL;
> +	/* DMA coherence does not remove the CPU's type alignment requirement. =
*/
> +	alignment =3D max_t(size_t, cache_alignment,
> +			  __alignof__(struct virtio_snd_ctl_value));
[ ... ]
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 45f7b6a5b3080..4cf75dedbe9a3 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -161,10 +163,12 @@ static int virtsnd_kctl_get(struct snd_kcontrol *kc=
ontrol,
>  	unsigned int i;
>  	int rc;
> =20
> -	msg =3D virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
> +	msg =3D virtsnd_ctl_msg_alloc(request_size, response_size, 0, 0,
> +				    GFP_KERNEL);

[Severity: Medium]
Does packing both struct virtio_snd_hdr and struct virtio_snd_ctl_value into
response_size here leave kvalue misaligned in virtsnd_kctl_get()?

In sound/virtio/virtio_ctl_msg.c, virtsnd_ctl_msg_alloc() aligns the start =
of
each scatterlist region (including msg->sg_response) to a multiple of
__alignof__(struct virtio_snd_ctl_value) (8 bytes) via
virtsnd_ctl_msg_sg_init().

However, in sound/virtio/virtio_kctl.c, virtsnd_kctl_get() passes
response_size =3D sizeof(struct virtio_snd_hdr) + sizeof(*kvalue) and
response_data_size =3D 0, and then computes kvalue by adding the 4-byte
sizeof(struct virtio_snd_hdr) to the 8-byte-aligned response buffer:

sound/virtio/virtio_kctl.c:virtsnd_kctl_get() {
    ...
	kvalue =3D (void *)((u8 *)virtsnd_ctl_msg_response(msg) +
			  sizeof(struct virtio_snd_hdr));

	switch (type) {
    ...
	case VIRTIO_SND_CTL_TYPE_INTEGER64:
		for (i =3D 0; i < count; ++i)
			uvalue->value.integer64.value[i] =3D
				le64_to_cpu(kvalue->value.integer64[i]);
		break;
    ...
}

Because virtsnd_ctl_msg_response(msg) is 8-byte aligned and
sizeof(struct virtio_snd_hdr) is 4 bytes, kvalue is guaranteed to be at an
address congruent to 4 mod 8. When userspace reads a control element with
type VIRTIO_SND_CTL_TYPE_INTEGER64 via SNDRV_CTL_IOCTL_ELEM_READ,
le64_to_cpu(kvalue->value.integer64[i]) performs an unaligned 64-bit typed
load through kvalue.

Note that a later commit in the series, 775188574a68 ("ALSA: virtio: add
staged capture accounting and lifecycle recovery"), addresses this by passi=
ng
sizeof(*kvalue) as response_data_size and retrieving kvalue via
virtsnd_ctl_msg_response_data(msg). Should that change be folded into this
commit so that kvalue is aligned here as intended?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D5
