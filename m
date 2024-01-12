Received: from baidu.com (mx20.baidu.com [111.202.115.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D14A21
	for <virtualization@lists.linux.dev>; Fri, 12 Jan 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "parav@nvidia.com" <parav@nvidia.com>,
	songyang23 <songyang23@baidu.com>, liubokai <liubokai@baidu.com>, "Song,Zhan"
	<songzhan@baidu.com>
Subject: RE: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Topic: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Index: AdpEbQ0W9HGTHF1qSr6UzsNmXQK48///9DwA//7TC7A=
Date: Fri, 12 Jan 2024 02:28:46 +0000
Message-ID: <bb7ded91cfae43439bea555d87fa96a0@baidu.com>
References: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
 <20240111111921-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240111111921-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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
X-FEAS-Client-IP: 172.31.51.55
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM


> > diff --git a/drivers/virtio/virtio_pci_common.c
> > b/drivers/virtio/virtio_pci_common.c
> > index 7a55939..d60fe99 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -584,13 +584,6 @@ static void virtio_pci_remove(struct pci_dev
> *pci_dev)
> >         struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
> >         struct device *dev =3D get_device(&vp_dev->vdev.dev);
> >
> > -       /*
> > -        * Device is marked broken on surprise removal so that virtio u=
pper
> > -        * layers can abort any ongoing operation.
> > -        */
> > -       if (!pci_device_is_present(pci_dev))
> > -               virtio_break_device(&vp_dev->vdev);
> > -
> >         pci_disable_sriov(pci_dev);
>=20
>=20
> Maybe break device is not the right thing to do. Indeed, request buffers =
which
> have been already used are not completed by driver.

True, break device makes virtio-blk no longer work for surprise removal

And seems no simple method can work for all devices.

-Li

