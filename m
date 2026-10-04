Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671164048A3
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115592; cv=none; b=dBaEhh4zCM7yMXtwLQp/IDTZ4ks34Ecp4Ry1KDcq0Ap8sF4khSDdatNg7pO6YFkjMhiXVKAy7dCGGr97JVB1mBuRtlpbu2QPO0CWx7AC/NTr83QeQNLa4nNrDI92m/lF/4QxmvQIAlUWVFGOh7QlMxN1xiTprEyzxOmO9Dsx1jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115592; c=relaxed/simple;
	bh=Vih1Y9m4vzjoc3cKjliS7Rv9d4KEkJ0j2EQ5a4daSyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nsBF3SkrQmF4pQtPqplKGTNL/7ET7boKA/5LCAAVumuAyZK98qZ3CB7k71CFglt4GMTUD78oVq0FepYcBpcyFLAOV2qg5E9QvqfByd3UudgVzpYq3BKfBBGv4ihTG0Z8t4nPyilmNSh58s0pkLegwdo3orqym0k00QTeJPSAVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQuIBgg3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQuIBgg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192CB1F000FF;
	Sun,  4 Oct 2026 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791115586;
	bh=Vih1Y9m4vzjoc3cKjliS7Rv9d4KEkJ0j2EQ5a4daSyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQuIBgg30KJhfgsx+9EqtN0OVQ1z8yCPrx5sFIj+GWoIc/K35vAREdKKtpulxSPlR
	 jnD1uIEW1dAAvyNYoBW8G4dqYBhGnMzU9ceoi/JMKAQx9riFNl/xsaILtUXBdUlwAs
	 EdxMveED6lvPfG61dehCnJVjkQDGbJ5cz4c3hQX/NgXV506AJ1sVt4WfIJqgOXJcF6
	 AEa4kyTOGEC8mhbWqJ0Pu/jyipdQWZeQXreMYSJbwAA+yDgwujk6dxn1ReggQvA2QF
	 zOp7hzUrKGCS7tmCK/9ZEswKksVjyRutSctmgyR1LdogPrtcZG4KE9PzcIuxs7mtgs
	 QJvLTdgsD+s2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] iommu/virtio: allocate the UNMAP request with the
 mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_9CB84937FB8F833E78AD4675C36B512A5309@qq.com>
References: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
 <tencent_9CB84937FB8F833E78AD4675C36B512A5309@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:06:25 +0000
Message-Id: <20261004120626.192CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The iommu core states the contract plainly (iommufd pages.c): a driver
> may not fail unmap for reasons beyond bad arguments, and in particular
> may not allocate on the unmap path, because the caller may free the
> memory as soon as unmap returns. viommu_del_mappings() still allocated
> the UNMAP request there, so a forced allocation failure left the device
> mapping a page the driver had already released, while the caller was told
> nothing.
>=20
> Allocate that request object with the mapping instead - on the map path,
> which is allowed to fail and reports the failure to the caller that is
> mapping - and free it with the mapping when no UNMAP is sent: the unmap
> path then only fills in and queues a request. Measured with a fault
> injected into that allocation (failslab, on the fault-injection harness
> this work used): the unpatched driver returns success for a re-map of the
> same IOVA while the device still translates it to the freed page, proven
> with a real DMA through the QEMU iommu-testdev; with this patch the same
> scenario reports no such case in any round and the DMA lands on the new
> page. The unmap path allocates nothing afterwards, and the device sees
> the same request stream.
>=20
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Signed-off-by: Anlai Lu <agicy@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_85AC6E749F6=
A912B7BB9FF360F8ECB3F5C09@qq.com?part=3D3

