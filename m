Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67A3769FB
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982449; cv=none; b=L/sWTksLjkmpB0+37Bjzc6JS0L4UQhjAw1WeP64cTXLW0xYPGtuU7+htNhKajrTf2zfJxamL0gWu8Nr89vo9LhGfhCElCGrroEK5bQMVPETCvm7XsMxA/YDhYEZddsetORrfUJK2BSryK08EJNvLhq1m811s/jMvSobIWC0rFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982449; c=relaxed/simple;
	bh=Y9lcZWr/L5cFQrXhlrX4BdtCTIyS/yXsc4v3+FnF8cQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EM1e4jHucqHeJeKLDI7ZDr0OvQLhniNRVKv68zE2IZi7gUpPGzmdp9pBNfwRZVGfKXgHeXqazKyURvNLyXMnctqh5CxVKNixi1rI1jH2xmXr+eWiOKWWaa+QDDF8m7CdkseaycuvZI/MwoJkEkDxFSGH8rtVFOYjmuW98xoflWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=pT4c3POm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PuTN4PSe; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="pT4c3POm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PuTN4PSe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C14CC14000EE;
	Thu,  2 Jul 2026 04:54:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jul 2026 04:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782982446; x=1783068846; bh=j55qvLlvef
	mz0mgcVLcPw9qKtGv4J9U0lwmNoDlYuKI=; b=pT4c3POmmIeP6to0Zj66Bt9Qau
	m06MzJXF2gGfXPKY1sBTgZZ7Y+9rUKJ8UncBTZsSutmIL0/WlXTYzRNhlArESOMW
	TUSGY8+V/TvJtL2X/dDYdaXHC4PUWDlhOZ9XUUHp2uKz03N05fAsKkNF0PZB6zk2
	qixcx6SDuvEYKCFNrcQd+ghQHIhFJrMDfPcQXEwFzssXa5FQBvLeigQ8L5rz6dgc
	lqU4oCyEvExFRXicv20awbWcFvXEhTNmb3jkRMvJQ4/MuIUljG5oxSVe+D/dWpD6
	2WDGp19TrA3tVlzXSdmk4TJAg8DmmuiuhV9zV2wIJwEYQ3jYguTQyA8yHllQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1782982446; x=1783068846; bh=j55qvLlvefmz0mgcVLcPw9qKtGv4J9U0lwm
	NoDlYuKI=; b=PuTN4PSeOMGZAJ6mhiCwSWXiB4rWkFe1voJVGa926kPuKEACVkn
	5X6FFt5Vwb4Jlej0N3av57CFaMnH0UKjK8K3K4CMvOWlC33gLm5d1Xpoqng+geFG
	8jsjgz3vbA4LOh0QaL6OqyKyx/jCV9wKJN5Fn+klXiPEZn1ARhiQHtfSiaXVGXb5
	ynq4jEMiYYnNh8uh0O1weAAUOquAuriq60fy8ONct4aWu8D7KL4lycppi/wNOlFt
	j8NjkD0hUYfHxhprzQGd3sRrMoldO7iuVhHgRLlik7xHKmG9x3plZPtBHfDSN4f9
	EfMLwE225XCjD+Vh1B8FQbhpGOuHBKwBDMw==
X-ME-Sender: <xms:LSdGaqJ6s_sDa6DdZOdaKTb6HybJ6md_I7t2CqjyIt9r5xxIbXpfkQ>
    <xme:LSdGauGBNT6kL5i0i5X2BlIv7P7dsGsiq_Vttd5OISaK3UKVYOh79P8f3_Ba2U-FS
    GSDhWvSEM6VaPaTlquaYH3Ly6fgk9TWlPWs4k2mxFegPYPmZCV0kw>
X-ME-Received: <xmr:LSdGag0PxissU8RT60Rsiw9nggrnTt7HE90mfcA_Ibe6DaJuVH__lkl7aD3D5zSVxshysvepz8_VlmaOpR6TA-hxM-HKlw>
X-ME-Proxy-Cause: dmFkZTEHCignYgB5W3814u/dYlkAnitiAGoUnu08MpyCR+DPgCOX37U/aCvuiPMeDa7Z8C
    zdzohmwS/vVrc4QRDt9AJpK7O+PEwujd2Zvqh+Tc23Gt+iQK3tTVXQiUSd0tWwpTdeS4ID
    vMkgb9EuKZTRZDm6wE1doDsjbiDndFhKH9kzsqVTBzmE8H/XffdKNDUpFY46e75ugw1QoJ
    iY8knN0OAUdA2Erv9QW4w7DTd9d+5TU6wRGgdGxOtgm1DctIUWacqF3Dxq7DJfK5M6ulpf
    2AnmTUF+5b+8a6b7lmqo4nMFSg4ekjcYD0VqkdKkLqATsD9PUnxrqQcGPm+8SNGRhVn5Yw
    hkOxgE22qur5b6dmyWD0rpefZzcRrPPHITYqH94IRdA5T/0xR/KlnNYQ12siugELptFQrz
    GPsudgJ845YP9jNYkWI3uoYqcFl0LTNBAMpHbbmVvO1m9CXOhP3NcwQk94IjdE5XyLKVCW
    K4fGRHcI/P7UbI1Va1tDtI+cCnyw4HaOGDJEiPjeBbRwlHa95l3FA5nTarKRYIAcOSsTw9
    HPaODK0w1sO2cN+h0ySe0XesTv663rJiVyu8p2lF1L+4Pst3Jyt2rm55LAh7JkplF3lu30
    zJaIpHY8DFFk0Rfb980wHFi1EYUyyozxuUVDGa5BcTYC28WYwtoO2TCUp9Ag
X-ME-Proxy: <xmx:LSdGalzve92v4Y03J23F8M0wmvsps6Yp7qytQvoTDpQHnZy7Kq1krQ>
    <xmx:LSdGavhEYSSjr2IJfa-By6b_lHSMaTdLS8U49wxGcTB3cE4VS-aOgA>
    <xmx:LSdGakzJKSPGQ6e8g9vCBkVUKxjBCAjkjG9tb048TOqJNyzbd8hj0g>
    <xmx:LSdGatwcVEid3e0SItT_9LF0YJ6NVmacAXZb3m7RPeWIueo_l8b7zw>
    <xmx:LidGagIdHB9mNYAhpB2lE4rtRGRci_OlEuJSfMc5gjPOnoRdJjzFJ-lm>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 04:54:05 -0400 (EDT)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id E5154BE01643; Thu, 02 Jul 2026 10:54:02 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Chia-I Wu <olvaffe@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, Simona Vetter
 <simona@ffwll.ch>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
In-Reply-To: <20260702000144-mutt-send-email-mst@kernel.org>
References: <20260428194450.518296-1-slp@redhat.com>
 <20260428194450.518296-3-slp@redhat.com> <akT1XEW766c7Imst@mbp.qyliss.net>
 <20260702000144-mutt-send-email-mst@kernel.org>
Date: Thu, 02 Jul 2026 10:53:58 +0200
Message-ID: <87tsqhai1l.fsf@alyssa.is>
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Jul 01, 2026 at 01:10:30PM +0200, Alyssa Ross wrote:
>> On Tue, Apr 28, 2026 at 09:44:49PM +0200, Sergio Lopez wrote:
>> > If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
>> > aligned to blob_alignment. Validate this in verify_blob() so that
>> > invalid requests are rejected early.
>> >
>> > Signed-off-by: Sergio Lopez <slp@redhat.com>
>>=20
>> FYI: this change breaks crosvm, which is squatting the 5 and 6 values
>> of VIRTIO_GPU_F_* with different meanings.  I've reported it as a
>> crosvm bug, so hopefully it can be taken care of there.
>>=20
>> https://issuetracker.google.com/issues/529852979
>
> Move fast and beak things, then it takes a wile to fix them)
> Do you understand who uses it maybe? Maybe if there's a PR
> for both sides it will be handled faster.

I have no idea where the device side is.  Doesn't seem to be in the
Chromium kernel tree, nor are there any patches for it in Chromium
Gerrit.  Maybe Gurchetan can shed some light?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQGoGac7QfI+H5ZtFCZddwkt31pFQUCakYnJwAKCRCZddwkt31p
FRB4AP9r4exFXbswzWQ1hhpnbMXRJzsC7nKw2Y3TyAaPQkSSTgD/fMa+jGE0X1HF
N1j7OIDzSBwZrrxiZ2FuGUgYS4A5ygs=
=adGR
-----END PGP SIGNATURE-----
--=-=-=--
