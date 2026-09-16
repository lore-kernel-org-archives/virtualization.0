Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FB4FB9B0;
	Wed, 16 Sep 2026 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595912; cv=none; b=uyMgh+5/KvJLjIgUp1EbjpIPasYU45XOeZLB0/NZBzfdh12uZzb7NmcYrHz3gaQUrsOJb0phcgW/d++gbDKNVTlULsnZJ66jYP3Ngwjy9n9hwE2IKhLhuy2AInK9lVkc564w0ZcKFbEFxshuj3DatHSIwCfA7hCKN8THNF06znk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595912; c=relaxed/simple;
	bh=ayOLCxjqMjrmFUCL/wVeEesDrsqsBiBYfGE+pXUjX5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VOdX5A4OOd8N/rGXtCn/YPxwVJ4kywiVzEJfAKS2hqROsff49GgIWtSHpeSQoZmOZYAgB0LfPrnbvZZJgM0UN2Vfo0lT7FzqpJzwH2ydvAWE3ZO/zTmfh3it+hmN4G6MaAt6NErSxvBBdCn0si67T754kZMNhKZFC1VCWXIZSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P93qt1um; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P93qt1um"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BDC1F00893;
	Wed, 16 Sep 2026 21:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595901;
	bh=ozY3VNOtybzxf6QRjl+YZZaitMyBkqK8R5RB+sNuNU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P93qt1umB/z92XJe0O30xClLU/a+bG4KSRDNBlgjp4XabILOLnetFiqAecyYtfmmT
	 qYkhKEPtNhDZ2ekRSCNRgQVHWIUC7tb/CgOYsX+TuYdorcRCDsBa2U7gDvqoId9ei0
	 Qk+zd/R2yM3Mc6b5sYVIu4nHHtb6wi2UtTbto/xGoIPuDVpP/5cvSqNAUg4IB/BBOc
	 9voYhHNNH2Sw31KWozJjDnEex8/7VUlw4m/I4wA+q+AniDuc7D0ajluKs3vzkLqz6s
	 VP1BXdRCpNjvoW2xJWGSGuq1LZwY23ydfm8ndRXw4unZ8VGDoo536j6cBL/YBCOCdP
	 vqiu3t2/7n7yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/12] remoteproc: search for a fwnode during vdev
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, conor+dt@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, robh@kernel.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-9-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-9-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:58:20 +0000
Message-Id: <20260916215820.C2BDC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] remoteproc: fwnode handle leak in rproc_handle_vdev()
--

commit dd5d3ce5995561638c5b17c0bfbbfdf4c09d1e31
Author: Francesco Valla <francesco@valla.it>

remoteproc: search for a fwnode during vdev registration

The virtio subsystem already supports a fwnode describing a vdev; search
for a specific node during vdev registration and supply it to the
platform device that is being registered.

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/re=
moteproc_core.c
> index b7d9957534bf9..e3ecc61cc1def 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -440,6 +440,29 @@ void rproc_remove_rvdev(struct rproc_vdev *rvdev)
>  	if (rvdev)
>  		list_del(&rvdev->node);
>  }
> +
> +static struct fwnode_handle *rproc_get_vdev_fwnode(struct device *dev, i=
nt idx)
> +{
> +	struct fwnode_handle *group, *child;
> +	u32 reg;
> +	int ret;
> +
> +	group =3D device_get_named_child_node(dev, "virtio");
> +
> +	fwnode_for_each_child_node(group, child) {
> +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			continue;
> +
> +		if (idx =3D=3D reg)
> +			break;
> +	}
> +
> +	fwnode_handle_put(group);
> +
> +	return child;
> +}
> +

[ ... ]

> @@ -504,8 +528,16 @@ static int rproc_handle_vdev(struct rproc *rproc, vo=
id *ptr,
>  	 * as device id, then we get duplication in sysfs, so need to use
>  	 * PLATFORM_DEVID_AUTO to auto select device id.
>  	 */
> -	pdev =3D platform_device_register_data(dev, "rproc-virtio", PLATFORM_DE=
VID_AUTO, &rvdev_data,
> -					     sizeof(rvdev_data));
> +	memset(&pdev_info, 0, sizeof(pdev_info));
> +	pdev_info.parent =3D dev;
> +	pdev_info.fwnode =3D rproc_get_vdev_fwnode(dev->parent, rvdev_data.inde=
x);
> +	pdev_info.of_node_reused =3D true;
> +	pdev_info.name =3D "rproc-virtio";
> +	pdev_info.id =3D PLATFORM_DEVID_AUTO;
> +	pdev_info.data =3D &rvdev_data;
> +	pdev_info.size_data =3D sizeof(rvdev_data);
> +
> +	pdev =3D platform_device_register_full(&pdev_info);
>  	if (IS_ERR(pdev)) {
>  		dev_err(dev, "failed to create rproc-virtio device\n");
>  		return PTR_ERR(pdev);
>  	}
> =20
>  	return 0;
>  }

[Severity: Medium]
Does this code leak the fwnode handle?

rproc_get_vdev_fwnode() returns a fwnode handle with an incremented referen=
ce
count due to breaking out of the fwnode_for_each_child_node() loop.

When this handle is assigned to pdev_info.fwnode,
platform_device_register_full() takes its own independent reference to it.

Should rproc_handle_vdev() call fwnode_handle_put(pdev_info.fwnode) before
returning on both the success and error paths to drop the local reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D9
