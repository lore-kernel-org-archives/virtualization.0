Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431040F731
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057081; cv=none; b=Zg51e3G1e+oD1duf7nYyKdPp44ACm3CChyA4wyaJ0clcd1ONI3Iyvnh1kIxRGwJmMB6khV666i4SADhbm82fZ0iS2KIryhJv2emT6+m0MNMnaI2R7RqjNVmOHJ3rnnRMLWe8FCqtTuGwE8pG/o0hnE76ygMLRQbi5BcmRpssFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057081; c=relaxed/simple;
	bh=8R+FKaXx7PMv9sTVAKquQkEbakDnu1OzhnfjDXax4+M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TC121mEGmH6ZHRsp3ToJLpchqWlLLJ/hXwhD8ewl/aZYUUEmakAIUlv4metsNYzyDDckiIKos71AWsxzvBNOpoIiKzg1KAb5MoaXWsWLdVi24XD83LoYBqGUvx77aGS8tnlhArK3dR5JuT1TQbpLte6tLPYJid1RroVh0PmDAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJO72oKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJO72oKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE8D1F000C4;
	Thu, 15 Oct 2026 09:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057078;
	bh=sXMKt3/69GAJlODqaeRnZ9I5hGLFI5bsd+QtX0Xr4Vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BJO72oKbxPlUSAmbSbe9KRblPTjy4CB+dS/K4HmvdqShL52hXrNiAG2FfUr6WwtS8
	 mDha4fRUEP7/yVf+Wm8uZsvtz786oTCd454/JW/FLEVWAAFe+aZpUqUH1+Ja+7L+PN
	 U4pv5AA2lSwgprDBs2DonXNCspVF+DuLU2+hmNfNEydR93VIxTkg8Utvjx/CROlu49
	 C5pXw7s22JlENWxxyTTtdTIMJVnDBERgqEuJPgTNNG6qaEQQbNda1Hc+poE4MsnjRN
	 11u6x5xm2erAg+Ce5JtAP8sJic4+CVoHjlFOXv80F14KgXQ3WGGlOZkNeyBJZczjik
	 4sw1qxe4dAtPg==
Message-ID: <sashiko-outbox-172581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vringh: validate user address in the IOTLB use_va read
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoran Wang" <haoranwangsec@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <6ad09d48.81b1ab59.3da7fb.9fc9@mx.google.com>
References: <6ad09d48.81b1ab59.3da7fb.9fc9@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:37:57 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From c165d81ad210155e0ac8eff7a571d9e525c00113 Mon Sep 17 00:00:00 2001
> From: Haoran Wang <haoranwangsec@gmail.com>
> Date: Thu, 15 Oct 2026 16:59:32 +0800
> Subject: [PATCH] vringh: validate user address in the IOTLB use_va read h=
elper
>=20
> getu16_iotlb() reads a 2-byte value from the address returned by
> iotlb_translate() using __get_user(), which skips access_ok().
> iotlb_translate() only performs an IOTLB interval lookup and does not
> validate the address as a user pointer.  In the vhost-vdpa + vdpa_sim
> use_va path, vdpa_sim's default passthrough IOTLB identity-maps the
> whole address space and vdpasim_set_vq_address() stores the
> controller-supplied vring address verbatim, so a controller with
> CAP_NET_ADMIN can point the vring avail_user_addr at a kernel address.
> On a vq kick the worker then dereferences that kernel address via
> __get_user(), leaking 2 bytes of kernel memory per read; the value is
> disclosed to dmesg by vringh_bad().
>=20
> get_user() is access_ok() + __get_user(), use it instead so a kernel
> address is rejected with -EFAULT rather than dereferenced.
>=20
>=20
> Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6ad09d48.81b1ab59.3=
da7fb.9fc9@mx.google.com?part=3D1

