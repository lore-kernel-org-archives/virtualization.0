Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A3140E5F
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599416; cv=none; b=rEG1G7g0VOolgCji3MkRZ1NnUhk9golcaf1doYZWU/Dkm9yRemiM0MZoSWdL4iSG3xQOCzNSVMkNzDvBWNw3x/peP3YIh+afI0D2nSmgA5K67fA31KF+WcLmDIASc497JeMuLvZtwTbQLAeyWh5Yn0BjDJynaj4tVgjuCT1CE04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599416; c=relaxed/simple;
	bh=PCYGCY2LA6zBW1UVRVnTi65/C8YYm9deOkW4uodOSzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UAjuuZgBJm3uZu5vd1bqYP/OvYX7S1sZ73ioi8iUtUAZQZIbjEJTdxUgHNsbgg00G4ssb/Yk8syzBLsPqURiNT7CIB2tEG/GCu1vk4SZq8IOMQOg1uB8q4VuIpzUrf+BhCbiigstKe1hIJJV8u3fauhnCrAoAp82wqbwHE9tEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9zXY3lO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9zXY3lO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DE51F000FF;
	Mon, 28 Sep 2026 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790599414;
	bh=xaStOuJRTiJMcn/GadgnX3OpS4ytkLe669Qi3I9fyTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9zXY3lOEAEY2poo+jzY8sUj+qRcRugSR1razMwnVgQpcMzU1lNW9nWxyekG7Jg3V
	 UW6+CnhknxT10EiWBAPLajxGPAFAhnjncDCYIcXvaYUABudnm5ulraXPqWiqGOEiIh
	 0zklRwadpM5RSsVMWzAKxXYMIQn/6jWONfwmc8k+3+L+Jwu4bBVBaGb5F6rxG99Z7q
	 tOEf3yZ5dmfMTNW8z1eaDtnOdAmHqYxC1mLcQTFlWv7qjYFhot6TQrfhfh+M3a+N95
	 o4bGS8Bp2iW2v2AgGUwp/eUqJTFnAqkfZMGo5zlEKHgysz83vH7G7MMCvWWSWj5DBK
	 fOm5grSI2v6YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] virtio_pci_modern: skip unused driver feature
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peng Hao" <flyingpenghao@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260928123455.49982-1-flyingpeng@tencent.com>
References: <20260928123455.49982-1-flyingpeng@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 12:43:33 +0000
Message-Id: <20260928124334.67DE51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> vp_modern_set_extended_features() currently writes all four 32-bit
> driver feature registers.  Selecting and writing each register requires
> two MMIO accesses, and each access may cause a VM exit when Linux runs as
> a guest.
>=20
> The virtio core resets a device before feature negotiation.  Resetting
> clears all driver feature registers, so the initial finalization only
> needs to write through the highest nonzero register.  A typical modern
> device uses bits 0..63 and therefore saves four MMIO accesses, or up to
> four VM exits, during each feature negotiation.  Devices using a feature
> in bits 64..95 save two.
>=20
> A driver's validate callback may remove features and cause a second
> finalization without another reset.  Track how many registers the
> previous finalization wrote and cover at least that range on the next
> call, writing zero where needed to clear a removed feature.
>=20
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928123455.4998=
2-1-flyingpeng@tencent.com?part=3D1

