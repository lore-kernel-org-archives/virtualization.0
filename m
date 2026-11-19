Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046963;
	b=pqZ1ZEmiXG5zNTL3w2RGTfdh72pB71qVaDUpz+0C7Q7FF8CXmOHpCamTzShuOaxaBfdh
	 3ZajSFbSd2g0TLs4zZI2bBmZoKbmHSYVDlnzfPbQ6c7YlFtG0y1p70/KtrmwfgVXQMDn6
	 cR4PUg0dby0WghQh8oH4akfk2mPQ/KjFyuNFLSkJfikHLpW8EuCsa4TtwESex8K83I8hZ
	 e/KYccqbMTMBeK6CmPDhayuGV2Pex2G9guGPjCwn3QKTebFVkp7mIInR9q+vv5yPHcEdy
	 4Ttr+iPDsd4xy/ZtWO+LPwpuGkmxHREOSVvxuD+IUeYlWNdM36jJEwyJsf0MioJMfEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dXWPAd34kgxbyGowuwR2K6K9x5gIy8WAMudygfgqw5I=;
	b=tRxw7+WkPvxu5yloSlbqgao8FN3fhAi9cJ7OdK0DwAre7PokFMCfyG2HIzxvdgR7MQlf
	 zRY73RI47NMUqNviQyZF9T8yqV8c3hoQahwyGVtjRoJwXRXbfULy60j4RAjxnGhNCBW14
	 fcqviGH1nm5a8j09YiAG+J8DtEqj1MndDpLyvUF3o8EKHfrUdo/yzX+yzgB/h6hzyuzCp
	 lhqLSlR7Phl3kGovSCXZQc75KZlNGsLB0ArF88exSIekbgv/1JCn5Fbv45N0Q4rHdWML6
	 LUsFLr9/c2zDBa2ATYAQCK7njX1Lqtj+WLQUr8Qzvl3CXU2zUzq7xJJE2AigCUCrzlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=On50cq4E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C532606A31C;
	Thu, 19 Nov 2026 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=On50cq4E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20F91F000C4;
	Thu, 19 Nov 2026 00:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046963;
	bh=dXWPAd34kgxbyGowuwR2K6K9x5gIy8WAMudygfgqw5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=On50cq4EQg2XuJ/k/TfG9lAUXvmXHBUBuSa4qvdIHxVQH+dXD5QYecZ4OrMs8+AFA
	 MLccB8B5Zd5Hwf/WlxxA+DGTgW98S3cx0KvCBR7r4p4956XtNj89Ae/e9i+HPPA0iG
	 ygs6ThB8PkNEF7pBSU8uAunpDTjAqnCWVxCE/WTy0TcPdeydG1jTy/Reh9iFqk3Uaq
	 tsALcxR0oCAGosPJ3NP3WD5OrPaCurq37BgI7/abVym8J742TN3JL9xVov4SRnz4b7
	 uAjlCvTMupkO2AsvqPvePBO8Q6hrweKuTTCTJhz6VwxdXWwAMC62ZZwYnvQ+bGivxQ
	 zMsPuc4+TBo1A==
Message-ID: <sashiko-outbox-222233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex@shazbot.org>
Cc: linux-trace-kernel@vger.kernel.org, virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org, kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261118235645.2907908-2-alex@shazbot.org>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 00:09:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] vfio: build failure due to missing support_driver_override in
  device_driver
- [Medium] vfio: missing support_driver_override on s390 vfio_ccw and
  vfio_ap drivers
--

commit e1a4bdaaf4e34e9a150096261c67507d2bd63625
Author: Alex Williamson <alex@shazbot.org>

vfio: Allow untainted use of driver_override

This commit sets the support_driver_override flag on the embedded device
driver structures across vfio drivers so that binding devices via
driver_override continues to work without tainting the kernel.

> Set the support_driver_override flag on the driver struct across all
> vfio drivers.

[Severity: Medium]
Should the s390 vfio drivers outside drivers/vfio/ also set
support_driver_override?

Both vfio_ccw_sch_driver in drivers/s390/cio/vfio_ccw_drv.c and
vfio_ap_drv in drivers/s390/crypto/vfio_ap_drv.c bind to devices via
device_match_driver_override() on css_bus_type and ap_bus_type, so
omitting them will deny or taint driver_override bindings for vfio_ccw
subchannels and vfio_ap queues.

> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index 28dc8c8256006..fb7679bf92fd3 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -358,6 +358,7 @@ static struct cdx_driver vfio_cdx_driver =3D {
>  	.match_id_table	=3D vfio_cdx_table,
>  	.driver	=3D {
>  		.name	=3D "vfio-cdx",
> +		.support_driver_override =3D true,
>  	},
>  	.driver_managed_dma =3D true,
>  };

[Severity: High]
Is this missing the prerequisite driver-core patch that adds
support_driver_override to struct device_driver?  In this tree, struct
device_driver in include/linux/device/driver.h has no
support_driver_override member, so building any of the 13 modified vfio
drivers fails with an unknown field in initializer error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118235645.2907=
908-2-alex@shazbot.org?part=3D1
