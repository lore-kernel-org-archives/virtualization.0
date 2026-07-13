Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B6384CD6
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941569; cv=none; b=ihiz771BHXXS7P3H19Kg0f8+HuAryHBHiW/G9fWf4xiN0pq127QQgUc5soSTyEm4RzHiydiKNdsc4/J6kZLejv5bjB0HApcVX93OSj94MpFXaDMDGiNAVg19dgKTJ7+TseW07FkhoQMyCAX1IwBLBIINZ8Jtszy4jruJuhlblGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941569; c=relaxed/simple;
	bh=ELrUc+qIZAHX5TohPOy6RNcckYyiJKDrR2q1xBOaXZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijTpoVC1IT+Ss1Uu4dokzWluJP/CVB06KkevZqMaIofmK060TcvaZyrWuVMjW7lPDWP14w50WUZr621bVbT7L9/7o2Q0Nmq9+UK6GihcNtFyLKTeADdWYzzO2ajHPILFvRORPw2w+j+oV31TTYAmKqvbLnBJCXzlked4/b+3nWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=RWP92p1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qWXdBcI+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="RWP92p1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qWXdBcI+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86E10140012F;
	Mon, 13 Jul 2026 07:19:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 07:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783941565; x=1784027965; bh=yT9VqomZcO
	G4Li63LujiZvIPJTvQIbrR8WYQQGQ3dLo=; b=RWP92p1HPNRwXIAJTA6wxYiR5s
	dDVZ+vxkWdiuMHCSLNF1yCSYL9DVbKSMpwUds6Qy5bQWgQ6nxdLf+Z2JROrp8ZJo
	sYCB9gdPEaGHScxdhiXs0Ual8GuGschwpvTNSPJyY9GFVBMRiNsK63syvsLXKYpo
	uNKijbuX+akrLEsJBEGzCuIhI19NC68podVTa0mV6MTA9Q8XapDT0FBqbRp9kYGu
	qr66hyr2rPlQuOQkeH8kbCKjBy78+BSMPVkf6LvyyKZ13OpYJoyQ5QDjtvzjAyjB
	1bXMLokh9+QdUTJEkPCoC8yr8XlK4hs2JsUYjamc967yRYdzmoUaCfNjHcvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783941565; x=1784027965; bh=yT9VqomZcOG4Li63LujiZvIPJTvQIbrR8WY
	QQGQ3dLo=; b=qWXdBcI+9mMUyOV736pzhMKnIosxPDD03Pdg27SRAGr+XMzTPcg
	piJkRc1b3qAMmtRlm6zvAa+lJsSas9bHiOHiXX2APl1MxritVjJ95+9+R2jTCuTy
	uyjQa5SGLPLtJbqjrw1ZjOxl/sbKlNoqiUAl5Zw4Q3rQVKeaFReE3rvbmRp4936i
	CYPkF9X1jIaJs2SFTMYEHhtZORtPTqtZHefkkD8k2XCYig5CXQ1q4mGdydEcXTLV
	upgSkw5Rsv5AxmN2Vx2CKklFC9h/WQnQJuY4NfKBtIoBXC2aVr5uRFGg+1Rp1YF8
	q33ZHAuzYizLNAOwl9Zv3SznpWYmPUWnr6Q==
X-ME-Sender: <xms:vMlUamNdeIIBqEmyROVTindp-ddbQb1HTXYfPj-ckTY79qhXozxIxg>
    <xme:vMlUajWf3fXvjU0xT0_go4n7v9qMmeZov4i9RIbq6WU89N9iLG-WhHBBh4HX230UM
    sNkPIK0Pd54B1m4_VJjqtf8T9RkbHJ1-VjIxDwMGsJv4bKRGnIToQ>
X-ME-Received: <xmr:vMlUapQgrgIAjV9-nJn_YfiikwEBRbVl4G5Xg_J9BNWZiVCk4KhKCW0PpmCut9Z2_o_FQPJod49Qo66fjy2IffKgOlmd>
X-ME-Proxy-Cause: dmFkZTEmqZ7TAdgkhsVLF10QcecpSioUfFnynZGAJevuRYSinOHZT6954DLFDLV2f197AC
    xIkjtIsnFeEOiRWxHQ92KhHJ5FbE2CIVXtVQp35m5vgB1TdteP1uF+zxwXpsEU2IowTr6a
    p/nQIxJ/OD0BssMZbEYK6obpZNWtBrrYekvopJ9YQQ/zxWnLjYpJsy1JDV/HuS8tuHCYGW
    iEobftEBqrjqwIeuPDCgNo8+hnb3iXO1gXd6bsCkXdSfHxUs1UxAk1BMLFKlWJOa8ehTK1
    /QjhZvRqsjH5E45ff666SyjY9AwjnzOly2LFKu7IQNJvsxFqfbWc8lCfFZ8kbDQ0p5A9S5
    Mn4xvw1cIfoW306LXPcAp9Z+4cMAui/AHBudqGkybOysHVJqNnomvR3MO5Ex0l8N7U8ZgX
    scfkjRtzlwImm4vmsKYXzgEe4qL9CjdGTVwHtJ0GdLkGK2OTZMtAyHhPmIo5xQPIbtN8Ir
    cdZotW86mZJw9XNd9V+gCUbz1unWGQvj+eGZWj1aAv5odjLHiJbhylFBnpwHp15IbSqZ0f
    FOCROf2zc+gF8d6gqcAPEGQhEAOb1xjUJb2sASw27YLFLGvFi3DpriLJs6dyn+DrWZCrEL
    0RUZomherRYtTDtIfEprWLE7HJraZSduIcSdjdvqtDEAkXEX3iCjq6RDVRfw
X-ME-Proxy: <xmx:vMlUap1tNLbI5SugvJogY_LLDP7haIQlrJsMbjffSWwIIJU3XXk9jg>
    <xmx:vMlUamjbU-tGiTq3DMwFyGW9ynaTZGYbJ0Ybj7eoOIJJt16KJAKs1g>
    <xmx:vMlUanaPwsc1riTEhM_Qp-Q90cgDM44AorzDJJmFq7bOGptfNiDZxQ>
    <xmx:vMlUavMmPe6ZrnxAtTGKoxljiieRFiQN0i04_IPKFtk4I2rvUkW-RA>
    <xmx:vclUasgGEu-j-JiFb4k_0JnM1LH1EgVIUD9WD8Pbo-w7snFB3q7JdVnZ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 07:19:24 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 180CE8917846; Mon, 13 Jul 2026 13:19:22 +0200 (CEST)
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
In-Reply-To: <c8bf0c19-316a-442e-a63e-1b52e7bb67c2@collabora.com>
References: <20260428194450.518296-1-slp@redhat.com>
 <20260428194450.518296-3-slp@redhat.com> <akT1XEW766c7Imst@mbp.qyliss.net>
 <c8bf0c19-316a-442e-a63e-1b52e7bb67c2@collabora.com>
Date: Mon, 13 Jul 2026 13:19:20 +0200
Message-ID: <87v7ajyw5j.fsf@alyssa.is>
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

> On 7/1/26 14:10, Alyssa Ross wrote:
>> On Tue, Apr 28, 2026 at 09:44:49PM +0200, Sergio Lopez wrote:
>>> If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
>>> aligned to blob_alignment. Validate this in verify_blob() so that
>>> invalid requests are rejected early.
>>>
>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>=20
>> FYI: this change breaks crosvm, which is squatting the 5 and 6 values
>> of VIRTIO_GPU_F_* with different meanings.  I've reported it as a
>> crosvm bug, so hopefully it can be taken care of there.
>>=20
>> https://issuetracker.google.com/issues/529852979
>>=20
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/v=
irtio/virtgpu_ioctl.c
>>> index c33c057365f8..d0c4edf1eaf4 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>> @@ -489,6 +489,11 @@ static int verify_blob(struct virtio_gpu_device *v=
gdev,
>>>  	params->size =3D rc_blob->size;
>>>  	params->blob =3D true;
>>>  	params->blob_flags =3D rc_blob->blob_flags;
>>> +
>>> +	if (vgdev->has_blob_alignment &&
>>> +	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>>> +		return -EINVAL;
>>> +
>>>  	return 0;
>>>  }
>>>
>>> --
>>> 2.53.0
>>>
>
> Thanks for the report. Indeed, crosvm will need to fix its experimental
> caps. CI will likely run into this problem first once it will update
> guest to 7.2+ kernel.

I sent
https://chromium-review.googlesource.com/c/crosvm/crosvm/+/8064741 last
week but still waiting to hear anything.  Do you have any insight into
whether it's still used / being pursued?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCalTJuAAKCRBbRZGEIw/w
olSQAP9qzYChgBOtNgtwj23gpSHyaReaZOMLJq5xNMgU5uryywEA88prn6UVr8ZA
o6rYMiGcL4mLSwcdy71KOyCnjbegdw0=
=IPYo
-----END PGP SIGNATURE-----
--=-=-=--
