Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B7743E497
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110445; cv=none; b=R7dLC76Lsno45D/ccsImdoAigvecwyIUTJDQTm3dqdLmwdYYL+P5GIowmj4MH835WgdYHznhatWw6Obfexn7ZV98ATUcg03Y+ETgdFadNWKZ1jD0NbuhWLM7gNzKQs+cx5WjBGS8JOR09voksseHT7Rt4pTxOu1fc0AICEh5G5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110445; c=relaxed/simple;
	bh=vcHpXZWbYk2ay6D9Hi5DiFsrsvAyFpVQV7XV2sBhgLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UixwhdK2KHqMkbSVx0QKtmIoziskM5bDT0o4qviBUQnJ/aZzq5m/pBYCzDplfjLZUivbuoZWlAs7mpSG5SeqipIInSVgfZm2ChypHblAjdPwkBvbx7H6rfwjYwp/s9QvOaE4j0TlldamRFmpR6IUhCr4oNnGSI/16E/+FmQLGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=LzrXnvng; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DhiKl2h+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="LzrXnvng";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DhiKl2h+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 108921400088;
	Wed, 15 Jul 2026 06:14:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 06:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784110442; x=1784196842; bh=49aI14s90h
	B7x4wh35JZ4l2pUhHMlrif5urm+QT7X7o=; b=LzrXnvngE2TSpcTLWF/uDGXsqa
	f50kqKHw5H4EALcZQDfUcVDrjbvJGpf24g2T2tDL5hg9jSe0I6Sg3zO4lwAtici2
	8S3cpohzwtcTTA19cvWissO3Uwantq7BJUlAeCTtlsHe4e7KRlAMpRS4xvrMFFdv
	jJqkNDmFDb+Q0I/p+qOsi9r8vp2WsDdVLnOe/yl7bf0EKr4WAYy/Pm42v1ndfSaO
	+eUPGLspQVFRITW9BdJNUnHxhyFh1xWUPtsr6WQLKRPfYbcT6HHsk4LX7Yk8H/+r
	08p2jHFVDYVESAweil2hThicmsCHfcrOVtiWLvSKNWA8AXPpwqY9aWNr1glA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784110442; x=1784196842; bh=49aI14s90hB7x4wh35JZ4l2pUhHMlrif5ur
	m+QT7X7o=; b=DhiKl2h+fb3t6jUeCompbKuSVRfoLZAugZHtchef58gMus6CLtp
	NTaEGHEyMPyqtz3DshTqEVPVhnYjp9hOLPc1nPwv0pPA+NYiDkXlJb36jAoWE3KA
	uCLN7VSJJ2ZwNkQPz1TR/W5f5oYstYA2eklDVT5Y7el+4cNJfT5CRjiqbHIwVMTv
	BoI+GQI/QOdz0uXvIUePmxib56CK7LxtAg85oMJ1R803dXIKyT+ZoHYntyyA0flh
	2xDEhpoK0pD9Ixx2RvC0PB52GJBT1KTTNIODpQN/Tfb24PIDpBaLGdsvG1F4oWlM
	etKEUJHO2MMV2fX3XrdTt3gGPvC+zx4tqAQ==
X-ME-Sender: <xms:aF1XapUe7kavbl7yOBCFYM-giYrJMEnY62m5qdxvDDRrfNK-x3QLcQ>
    <xme:aF1Xan_Nq91OgWXosRYiBGJn4P-hQ3xYDRuF_ELGxDXJsWCGq2dGG1b81h1dF8b2F
    klyE4rjkRlwQZiWsYhQrN-UxKgliFG5Ya56cdL5zc1eGC8fwFvICg>
X-ME-Received: <xmr:aF1XahZSRst61nr1I-2QfNBaRHSZ5PnFdIRctrtg1PzPDd_qV-2bVf5krEkv_db_T0G5>
X-ME-Proxy-Cause: dmFkZTEoZOCIo4U6eq8f47vDa/o8pjYC8gX3I8aBhns7yWEI2JBeaRsdm2VQ7mvZdD9VXV
    nRIXJ7wOh9ZYtMJ6UgKwt4ebVYd5IaSpwFcscVV/YTVady2bCueuKlR8+9hXQSzJFQuI2z
    p2CrOfl+djXZectdT5ovTMgrEQ2zW9b37Nn3iB7Zb2fpX2omM2OpkNZ07a8pO0UUsWQ6ua
    2XP4Y5fcbwzwJhazpvPQV353NItlZHPj0wNLmFhQ0Dvo7jK6jlSECWTKJm/5GnAQWiApO/
    gDgsRf1tZ6OQUPOowcYNa1XWEEkCBvOp2WriQicy8BJAp0tLlf+My2WbC+SnsXARoWECQg
    YCcha2v/vzeVMkZp74a36knLzKscHFwQFAbeecwrYI2sN6nrdaf1TWTOk2vLAjnZPxPtZP
    RRM0KjJGAwfpmELPEyigSKe2kA1vm3uAPqfHhhfvvIQJY81JaI0pz2OBqnkqaByrQ0hpHg
    VS/PginqA2x36Y6P0cqDr4feyeKgsIJ0Ac1a5+uTGvMGVFkhdjpUz8lu8zjD1daktnj+B5
    Rl+gZXXv6K4618mtVsu9T87QTgKZljbknCRbEHTeIiRLIYGrzj+KsCGlHUXYgg6YKbGn1V
    cN2oi0ciVQFjW+fx6VP7WC0/HEmPQlV+0bfKq3oyiPBrfehc8h+5wGT6LwPg
X-ME-Proxy: <xmx:aF1XavdNVDuR9t-DnUqHx3VTuzFvNZceWW8tOBXtMQs46L3BtipzYg>
    <xmx:aF1Xaro9bxys4jXKn8A_bDnAp6qart2O2he8J5inkfmgJ8_ZixJPzg>
    <xmx:aF1XamAYWQo-K31X8QPtYm3UzLREbUagmdY3LY28U_bwEJE9leuGuw>
    <xmx:aF1XapWuD6tSdte7JetpU8ZYj26tKMpdfo8tnlgWYijsYArXAcVWEQ>
    <xmx:al1XagrRcM8koWdN0wZHEPEXNHgnTn8GS_Wf4naQmdvWrppngiQKCvLE>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 06:14:00 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 088FF894299A; Wed, 15 Jul 2026 12:13:54 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Sergio Lopez
 <slp@redhat.com>, Yiwei Zhang <zzyiwei@chromium.org>, Sergi Blanch Torne
 <sergi@collabora.com>, Valentine Burley <valentine.burley@collabora.com>
Cc: Chia-I Wu <olvaffe@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Gerd Hoffmann
 <kraxel@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
In-Reply-To: <17764937-21dc-4b4a-8def-e738b361bcd1@collabora.com>
References: <20260428194450.518296-1-slp@redhat.com>
 <20260428194450.518296-3-slp@redhat.com> <akT1XEW766c7Imst@mbp.qyliss.net>
 <c8bf0c19-316a-442e-a63e-1b52e7bb67c2@collabora.com>
 <87v7ajyw5j.fsf@alyssa.is>
 <17764937-21dc-4b4a-8def-e738b361bcd1@collabora.com>
Date: Wed, 15 Jul 2026 12:13:52 +0200
Message-ID: <87ldbc4l27.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 7/13/26 14:19, Alyssa Ross wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>>> On 7/1/26 14:10, Alyssa Ross wrote:
>>>> On Tue, Apr 28, 2026 at 09:44:49PM +0200, Sergio Lopez wrote:
>>>>> If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
>>>>> aligned to blob_alignment. Validate this in verify_blob() so that
>>>>> invalid requests are rejected early.
>>>>>
>>>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>>>
>>>> FYI: this change breaks crosvm, which is squatting the 5 and 6 values
>>>> of VIRTIO_GPU_F_* with different meanings.  I've reported it as a
>>>> crosvm bug, so hopefully it can be taken care of there.
>>>>
>>>> https://issuetracker.google.com/issues/529852979
>>>>
>>>>> ---
>>>>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm=
/virtio/virtgpu_ioctl.c
>>>>> index c33c057365f8..d0c4edf1eaf4 100644
>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>>> @@ -489,6 +489,11 @@ static int verify_blob(struct virtio_gpu_device =
*vgdev,
>>>>>  	params->size =3D rc_blob->size;
>>>>>  	params->blob =3D true;
>>>>>  	params->blob_flags =3D rc_blob->blob_flags;
>>>>> +
>>>>> +	if (vgdev->has_blob_alignment &&
>>>>> +	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>>>>> +		return -EINVAL;
>>>>> +
>>>>>  	return 0;
>>>>>  }
>>>>>
>>>>> --
>>>>> 2.53.0
>>>>>
>>>
>>> Thanks for the report. Indeed, crosvm will need to fix its experimental
>>> caps. CI will likely run into this problem first once it will update
>>> guest to 7.2+ kernel.
>>=20
>> I sent
>> https://chromium-review.googlesource.com/c/crosvm/crosvm/+/8064741 last
>> week but still waiting to hear anything.  Do you have any insight into
>> whether it's still used / being pursued?
>
> The GUEST_HANDLE should be used by Android [1]. The FENCE_PASSING
> shouldn't be used in production, though don't know for sure.
>
> Crosvm should bump its experimental defines by +10 to prevent clash with
> upstream in future.
>
> [1]
> https://github.com/google/gfxstream/blob/main/host/vulkan/vk_decoder_glob=
al_state.cpp#L107

Thanks for the extra info. :) They've agreed to go ahead and remove both
of them, so the problem is solved.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCalddYAAKCRBbRZGEIw/w
orGgAQC/YXYu4X+sdCLEkVpxdPV5ypPiF82l9tUZ4Wd+kuwJqQEA3aMqqCYrmTX3
e4gNsI1wlXn3W9wPHQe7CSogvsTvPQM=
=xZq0
-----END PGP SIGNATURE-----
--=-=-=--
