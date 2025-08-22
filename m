Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF712E9ED2
	for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858452; cv=none; b=GN2OARjriQ731/TJIGoIQzdF8510qPRC61rba4IK5T5T3sCHcV+920aKLAxIylaODkKGUmNivXLUqm4ExUp/hwXFbmYgtP1M36h3Ifxog1p26aeJmy2sOi4Hoh7CnsirYiN037XaI2uvMpptaw1HDoweUhqj3LmvJjyGwLA3aEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858452; c=relaxed/simple;
	bh=FLkr2aV9b33AsjdR8Nls+ZaAbgNNJekC5ss4M1Vxurg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NS590Dp7WU4uP4XUgELqY6KoqUY4+WAH15wUNHlEDGBClBHJyKGL0wMyYO/858rF/FaT/lzVK5W51hJ/cwS2agmRwypVHjFXPWhc0dxAJkL/rW19+vwIEINlcY4cUfh+E13/Rrr+VG+ySMA/Fy2tPNfGGCVJWgVFRpztOSjhRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>
CC: "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>
Subject: RE:  [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Topic: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Index: AdwTTxd+YdVEFNqzQBWcarw+isQ7dg==
Date: Fri, 22 Aug 2025 10:27:23 +0000
Message-ID: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.3.14
X-FE-Policy-ID: 52:10:53:SYSTEM

> This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal o=
f
> virtio pci device").
>=20
> Virtio drivers and PCI devices have never fully supported true surprise (=
aka hot
> unplug) removal. Drivers historically continued processing and waiting fo=
r
> pending I/O and even continued synchronous device reset during surprise
> removal. Devices have also continued completing I/Os, doing DMA and allow=
ing
> device reset after surprise removal to support such drivers.
>=20
> Supporting it correctly would require a new device capability and driver
> negotiation in the virtio specification to safely stop I/O and free queue=
 memory.
> Failure to do so either breaks all the existing drivers with call trace l=
isted in the
> commit or crashes the host on continuing the DMA. Hence, until such
> specification and devices are invented, restore the previous behavior of =
treating
> surprise removal as graceful removal to avoid regressions and maintain sy=
stem
> stability same as before the commit 43bb40c5b926 ("virtio_pci: Support su=
rprise
> removal of virtio pci device").
>=20
> As explained above, previous analysis of solving this only in driver was
> incomplete and non-reliable at [1] and at [2]; Hence reverting commit
> 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device"=
) is still
> the best stand to restore failures of virtio net and block devices.
>=20
> [1]
> https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6C638
> DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> [2]
> https://lore.kernel.org/virtualization/20250602024358.57114-1-parav@nvidi=
a.c
> om/
>=20
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci =
device")
> Cc: stable@vger.kernel.org
> Reported-by: lirongqing@baidu.com
> Closes:
> https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@b
> aidu.com/
> Signed-off-by: Parav Pandit <parav@nvidia.com>



Tested-by: Li RongQing <lirongqing@baidu.com>

Thanks

-Li


> ---
>  drivers/virtio/virtio_pci_common.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_pci_common.c
> b/drivers/virtio/virtio_pci_common.c
> index d6d79af44569..dba5eb2eaff9 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev *pci_de=
v)
>  	struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
>  	struct device *dev =3D get_device(&vp_dev->vdev.dev);
>=20
> -	/*
> -	 * Device is marked broken on surprise removal so that virtio upper
> -	 * layers can abort any ongoing operation.
> -	 */
> -	if (!pci_device_is_present(pci_dev))
> -		virtio_break_device(&vp_dev->vdev);
> -
>  	pci_disable_sriov(pci_dev);
>=20
>  	unregister_virtio_device(&vp_dev->vdev);
> --
> 2.26.2

