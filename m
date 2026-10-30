Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349504;
	b=ex5peYxobGSVdXSjP8S6EKmfoBzHxxQExhCpV/spcE2FubtQBhsE8FhNCC3jxRTcuzeo
	 l4RBuXOSoydmqXeXduNFwuayerSArpPw9IZv9JT3InwNZYemfB5+lB3p8rKisad0JucQ8
	 yASEHUhiwaZHcdHJ86hLEG6CqhxpfchUlxI8qJ6xJ9CbMJwT0Ks2F5TbHyvywFNL1pMY7
	 BuyD9TwZWbMXyORIWULPKC0fPLkfD9a+DHKkJuL1JQqEOGxDIIqR1hSvkspU0erBmfj2v
	 0iUSy6UAPDVZ35vwZrBl346cHOtP8WcOE0Ow1mrIcd1aWeyk/RZrqAdhwWZvy3esYQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349504;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QcEQx7HtP4ZMZBAaZpmgFmMJm03CjadZlY/OZKEpfp8=;
	b=lB6Y+/FxuKzY6zFs3IZgkzhc1Lg/mvq3DRhGYmqwlFcvYRJhHaI+e66rWlneTclFJBv4
	 ZTT4UYkJBr5QUTWTq2uZEQodq/GPNz7x6dsD0O5XuidYYFonF4zcUJlfzYmvz9GEdfDJ3
	 pGuvShL+xz2QgwPMKRBVdZGPc0iKhjrnKJTPQHqiqKHbunKhkFT9XFqqboC2uBI53vxsO
	 3BD6oAODIz97VGDeov3sLd61E0KRY0ryNr++5KRGBinWpe6arGo1HCGSMTfz0SuVEITjH
	 C88WSd0IbeLUuMdZD64/BYXMcXSy1i9P5HQlrYthlIgyaV9ZeRlk/gKptMHiGR8WzTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iD5cT/GC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58968606A31F
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iD5cT/GC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCEA1F00A16;
	Fri, 30 Oct 2026 08:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793349504;
	bh=QcEQx7HtP4ZMZBAaZpmgFmMJm03CjadZlY/OZKEpfp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iD5cT/GCvhQPssWa0z43SteZ5jwr1Hn5t1O+mTwIhmcCAGDlTTy0aYiBAobhq0slU
	 XRAEu578HfEe8vOXYFl/xCVfRWxHnI+XkyhTAYF8B8buCxOlC5oNDZciqE6BBEc/Ef
	 xl2n4TYXIEHScvvrIWcNVrjLhUj8oR+3lN/4seXg+mu0aqUCebt6xlPIDQg0XRMnDp
	 y7r8BMSZwnOag+N4nh6dvMKazE60CCmYxxv3ITX62z8Uw1kSZ3mPxMuMfMF3Pb2jVA
	 nbokbMHBBTQDxfZqLRpwb3+PwUvQy3R9qdiYf9OaF8D0VxYnqc3K6TTp80FlDDkc9C
	 1wARJl0f+3mjQ==
Message-ID: <sashiko-outbox-190703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] virtio_balloon: add tracepoints for inflate and
 deflate operations
Reply-To: sashiko-reviews@lists.linux.dev
To: liuqiangneo@163.com
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030083400.66005-2-liuqiangneo@163.com>
References: <20261030083400.66005-1-liuqiangneo@163.com>
 <20261030083400.66005-2-liuqiangneo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 08:38:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Qiang Liu <liuqiang@kylinos.cn>
>=20
> When the guest responds unexpectedly to balloon resize requests,
> the actual applied delta cannot be observed from the guest side.
>=20
> Add a "virtio_balloon" trace system with three tracepoints:
> config_change (target / resulting size / delta), and
> inflate and deflate (requested / applied page units / resulting size).
>=20
> Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030083400.6600=
5-1-liuqiangneo@163.com?part=3D1

