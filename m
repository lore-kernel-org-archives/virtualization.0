Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8B49F132
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056116; cv=none; b=qdkXQcjIpgnLsBqTuhF0GmMdott3mF+9qoK2MHHt0HRjQzRl7cg0g/ylTpCXANl29xcIvF11E6PXLr0pn1U+BhW5kmyAZMxYHcqeEqB4s0IiSEro/75M9llp1m9RvNBl0GJks7Vpf0T3baWhz9Iawfhcf23eiUpdSYoMfx3F6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056116; c=relaxed/simple;
	bh=8sb2TKy0EA5rHSHNU+kfw0Tvmor3jHUHasPxcvoekgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=opSaCvnSzXZdp/ObEc4tfaFxSCU8kAHARm4hqoCCle3VQrKqMTUKfoEqHrvEF2XJjAQsDz5MFKbeiqakMqyCPTa07iUADbuYRtJni5s+pa0ljrV0WlTFc1xNjG/r7NDnGn6/iXGQGXAhv3Gv7LjQKB2AagNQMFwDv6dXcZ6tM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2zLM3cn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2zLM3cn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1E91F000FF;
	Tue, 22 Sep 2026 05:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790056114;
	bh=3BXlgNqB1rGZDSVqUh8BL+x15RbkdbnTy9p3k06Z2BE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2zLM3cnZpn7dyuoykeQmqbjabu9COnfLMRXz5+Ro9azeGhuwbc8J7idreg/irBOa
	 GRHSQwMqEUcIrI9FjzlYWxAVTXtsNtFjvq7uBTbwgayziYBt/BFxMMLmW+7twO8afW
	 rv0JnZQGut2ezSaYaE2jPsD7EMvtbMQvfn3PYBN0HuWuEtBX+APB0w4ZQhqtmL87XD
	 Af082hKrLzzD8iaE9DOfsYa1fyrKqhz2yJoHQMUEkR9NlI6LTfb2DDfnLKtAMwNXm8
	 tmjw5WzHuXbTrwhr3hD3cZAigh7tOatbuBsR3toa0Bv553Myn1ETAzUaiZiycBaGDF
	 E9T8DpmJ8rzsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] iommu/virtio: Reset device before deleting
 virtqueues on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260922054116.416333-1-oss.patchbox@gmail.com>
References: <20260922054116.416333-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:48:33 +0000
Message-Id: <20260922054834.1E1E91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> viommu_probe() marks the device DRIVER_OK before populating the event
> virtqueue and registering the IOMMU device in sysfs.  viommu_fill_evtq()
> hands the device a set of device-writable buffers through
> virtqueue_add_inbuf(), so from that point on the device may write into
> them and into the rings.
>=20
> If either step fails, the error path deletes the virtqueues without
> resetting the device first.  The event buffers are allocated with
> devm_kmalloc_array() and are released as probe unwinds, so the device can
> go on writing to memory that has been freed.
>=20
> Reset the device before deleting the virtqueues, the way viommu_remove()
> already does.
>=20
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922054116.4163=
33-1-oss.patchbox@gmail.com?part=3D1

