Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C839DBC5
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138687; cv=none; b=VKUEHb9nrFeI6MTFXX/7UVUw7oKZ7jC7yqFFU0RnuMic1/6mQc3os//oG2IdNgwkGoZNYTFvU38j54iHix/VUm5IfJCy5QV/6K35pprdH0T5+ljqeVEBfa3rIkTPADsDWEW/wqSZ9QkLP9oasjxBoWJgzyfeXvhGZF9LaH+P24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138687; c=relaxed/simple;
	bh=4pmHW2VryPKYVM2TCMKvG4odu9dzulm1jultSs11HPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eHVQjkFyY3SmR8o495AFz/wfraMNeA/ow5f/ljXhGpE82QqKsWWNIfNXqs/Vk85GXrQCkPMDoBSzA8v4DNjdOVIUX0aKa7Dv/dR39YPrRvVVbt4077tb/BJ7IVulhtqUBoR8bKsx5t78iPhplfcV+B99vcywF6zGMEuXF9yhk50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfdcTiVW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfdcTiVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4FB1F00893;
	Sun,  4 Oct 2026 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791138685;
	bh=bxmIH64VXvWIVCKog44Oxs++DLw2IJqSe3cnRxsKQ3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CfdcTiVWJ0Wbm2wgQoe3wi89p00aQkcX6F+uDvdPQgqUaEX9RtJ2DnFPS46ltGv1+
	 Prl7NDQN7iMfaW2VgydeQhsBHaTPty9YsUYX9BslvBtSKoktLiy1wDM+8qk1EEu1Qn
	 1hrTcqxv2WcT1K3RZIIerEAQsNjgq0MMwvN8owH2M3qjiM2vuS6JrgFQRC0kIGQH7j
	 bv6n4jVXAAXXVZlh45gR+5c28I4T8SLP9gvo3LmXt/A4QR4M9F9FHEAQ2TuRBpOX8K
	 CZdRUwId6iGRp5CnneGCeYoTD0AX/ZM0isKm/dxBRlJS4cYwjnf8QiNd071sDUOJBN
	 Vl8q/7ivhM8NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] iommu/virtio: Reset device before deleting
 virtqueues on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261004182218.177343-1-oss.patchbox@gmail.com>
References: <20261004182218.177343-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 18:31:24 +0000
Message-Id: <20261004183125.6A4FB1F00893@smtp.kernel.org>
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004182218.1773=
43-1-oss.patchbox@gmail.com?part=3D1

