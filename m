Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665822066
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752511; cv=fail; b=bGBghxIY9vZnex/JqMOcaJsCJPJvYiH3bdr1bKvjwNvINDPjBJb1EB6x2lVirxiKp5Fgq5whwRCxFpWPukGmiUDrZhMcmJu/1lXmqMhojPYEjIRTaZyxkEAOEHo2E3EC0eBNdMjyDieQSDHwHlrA8NRMwiFEEtgfBk0pO5XkqdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752511; c=relaxed/simple;
	bh=EG/vhu5D6XYUrm02R+yyFVRhD9WasLJ0xG5lk6w4Mto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MG9kInu8nQSv4FyUPDzmAQHmp4Ta6HQSAHjZdoK/fk49B9FHyddrIgL9eiHWd1chVE/maJmYx6CwoB5xhqxxVsdS+Y8WzGRO1ISGuwTwTgSbaCm0yVFjMMb9dK2OEQGwS2+fxlFq4iscCHKFdqRkXD+tuTm9RuVwl7QlrG1Pg7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=AVOVkwjj; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="AVOVkwjj"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A9gjso014095;
	Wed, 10 Apr 2024 05:34:58 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xdrc6htpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 05:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BykVzCmE+RpUnwmOOnLQ2tcqO63gH1tvvHAVMZYfx8GPqIPrWdQ8jjciYXTX2ig80+MH4PT7Z9Pigt9X7tA6cE1wWLa6OFl9L6Zf3Ub+lTGt90wWQUAQ707VaOIDeM8HZXlhVPt5G+vrcpcVMZkMIR8pXNOILHmR5xrcdmLVpn8MH+z5TxSsxAp6zttb51F8+7TYCIA9rkVqKmqAbDAizUaDH4j4siL1cCYM75JE9C0nibTPxmwolKnzUixkX+rnDGJ5kZa7wdiE4xFA94hX/TB2dcK0d8W22oh6ZTOlScnmksIvr1VzE2TQJB5ncmVvyFl3ss+iJdjG+xpR50symQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt6OIEUxogunjOBwCK0498hTJFggW/8eNTIJnEffxKg=;
 b=UIXSrw5VK6THz1AgbU5umb4iXJtEbRTEafOozZuGvnf4X7Z9g62wFVbUd9IG/+h4WjecKjxONORmfkzzWMP/+YErbOdR1k5sLrTKuCFXOMG8GTiEJHZpzH5JKmWdxVHtDUN+Lla0kY/izOKAuurkpOEmYMbVqmI81ZXmppAfgI4U53GXGsw/9K9dp1xGc2NCfw2ROAf2G1TK+2xsIB1VYqJf2hiT6AW0gclTN3Ch/Lgb3K64oqLdHLkp2A9F5pamtm5dQXjf71wGhyF9y3W3fibuCbzoyp8cFAr6KsxeDDNi1ugB5vLa0MPwaRGDnScKX6/nTNbfJJ9Lr8OGcZCCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt6OIEUxogunjOBwCK0498hTJFggW/8eNTIJnEffxKg=;
 b=AVOVkwjj1ceuGycFG4gMIL++XqL8T/f8f6wz6HjUJc71dYbE878DqL9dexazDPygKHQCM40srnn3Rox6koLi2IA2SRunO/dHgrra2pkJLmso9eelUPlFb5kxVPk63voKeTZKRP9OFZ7I4dEB2ZJhLGnti8JqaDc056B0RQXt1IM=
Received: from DS0PR18MB5368.namprd18.prod.outlook.com (2603:10b6:8:12f::17)
 by CH3PR18MB5440.namprd18.prod.outlook.com (2603:10b6:610:15e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 12:34:53 +0000
Received: from DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc]) by DS0PR18MB5368.namprd18.prod.outlook.com
 ([fe80::9728:b607:b464:a2dc%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 12:34:53 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Nithin Kumar Dabilpuram
	<ndabilpuram@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>, eperezma
	<eperezma@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Topic: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Thread-Index: 
 AQHagDj2SsvzR050EUWY0iVJi2EC1bFOIr+AgABzqcCADaIjAIAFJBEQgAAU+ACAAAv1kA==
Date: Wed, 10 Apr 2024 12:34:53 +0000
Message-ID: 
 <DS0PR18MB5368C21CDDE827AA2A496510A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com>
 <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240410071350-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240410071350-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5368:EE_|CH3PR18MB5440:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /yZk3Oe8zZtZ8NzC+M4trzh/zEketzeyz/yC6eJ8MaLk1L/HqmhuHpn3W/2CSMBrCR7Swf90kt/4LyfSKDn0TLTx+kimhzvhi3n69nUq2aLRxKqj8Eg86jsQYGeEWj1fGTFAfXXegjFah43By+NR2PTpJpNcQMVjsZf8VD8mvAtvbepNwEKLknwKRBsGUW7wwYNzjGVbOzC1yftsnAmpq8ZO7EsgodQO7Ak+mjDPvrpZ1IV1dKsZWulGwLIUgeI1M0As/Uk2/UgMcOqkqJHV2x9ciLXdTGIH+hRY3U4pcNbb+7bNyR9YKGg26U6I8eq4zY/W5Ul68KCrS0oqqklc4iz/kgYjYOGgi4cx/1H1/xk5DS1Gw+sajqHnWtsYUsbLMilydJOeFXeuZf26rS7Lc97I3payjZOuQSgbF916URLc54V3UpxKwVU+8pIO6AORLR06Pdl70a3TBoiT0RbfRCdYPbSmNTecUf9c0aRvD07YEds1zlLIjiiQJ6IddIm7DILEDyxEZU3mPKkYhAqDtQQLkINUknWiQUN615LsZKY9TPaqCjvE4ON6NYQzWhY3OFvQEiVXS29EApwMUj2nO0qifo+TWoQJB1CYJSC/EUzoPeMXpvg2X+brEsqVkt8bzMz8EKXG5QcHIOFhBPexW+G8jwJ1oyjpCd2QT7WScOM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5368.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UJoBN4WJsMhs34mXGR8JPdmQP35VPncICDDhaO3hEx5n+8yIa7vw+s/L8Fee?=
 =?us-ascii?Q?bOCe6zyJNO61bvsuuMFQN+ICytRPeJJSlk9HEdcLebMLWDep4fxSj48sh2vO?=
 =?us-ascii?Q?XJzUMFaOuAcRfMSdor126ldDaiIr7TqMyG5WtrNRqANex99Lq9NMaZCUnZXO?=
 =?us-ascii?Q?rKq+tLJDjKsuJHsuwvKFxXu9K6slWNfj6ZHsNx1z/LwuQmoZc3oNDqgvJ6yt?=
 =?us-ascii?Q?qdYvOV3slwbY+xK2PXL6OG/mj/Rzwp9bxqQ/3yfKPllQ/Ng8UOaC87WiHFh4?=
 =?us-ascii?Q?6uqM4EO2imnsLYMtYIdTyEm9MA+86HgArgjaqU7I4+3kr96kb5KN547Gg6SD?=
 =?us-ascii?Q?kZJw48JEDfzFcymIoCRAXcUUW/56ivKA4M7Nix9bzYj8krIt6ZvQb8nuG3B+?=
 =?us-ascii?Q?+VomqiqOGAT60MrBNlGTK4l73N5pbe2Vngy7LO370RzERv2Vfw1rlhw1i/9B?=
 =?us-ascii?Q?N0Mulmz+YKJEi/KI6GPmryuE8VHpyTjY9qF7KoZIJFo1YrHPC1gKYjnfKrKy?=
 =?us-ascii?Q?H8MEwgpdUu8PND2Bzy1xN9oDpzJRWqR1yDRrbptKPnrOOgSN7PFi09GXXF5F?=
 =?us-ascii?Q?+2bA4BivKQuaPU7HmpkyvpSjUiNJ5oBJEDNoHdgZDhI5ixCU7DI8q1Bu/yDR?=
 =?us-ascii?Q?KLdD3cbyi5LeYTAcp/DR83LuQm8xzhC3g2T6u2dekUPPcZ7UfsItERGgn7jZ?=
 =?us-ascii?Q?aXDrUDRJFmmjZQnRiA5KsWJIfZ0Ph0zjarzzMhXlIXKqxkJaJN/LnZ4G1Nxq?=
 =?us-ascii?Q?alJhYmhLkdzWjSanVN2oQQEUcJ6a85mpiSm8t3E8qh1K7OqZoytK/kdEry1Q?=
 =?us-ascii?Q?247BMRn9Scb3ZaCuWcUFgOXtNX5268inC9lkkQxTAL7dgggEaInSmuYc+Io3?=
 =?us-ascii?Q?uCYB7HmG+s4OFTD5mrdJ3mvHe+pKA7gFiR2d/WWBlxYowuvs2rkPqemY2BVt?=
 =?us-ascii?Q?ByQTNfwIYJ0pNuVjxsCHmxPZOWiGAk781zLy0WVg7P4RDlblO7Zaj+I2vUl1?=
 =?us-ascii?Q?DCSOZL32cWmKLkGNjpeFtWnGs8GnMrqZ47GQAxF82Mu3H2jVA7YI5iNuGhVC?=
 =?us-ascii?Q?ijY01obM+4IBW41Vz5FpXT7bh+xFZpujhQDyZ0NIk1VmkBMxBdaIOFU5m+/m?=
 =?us-ascii?Q?ffYWhwfI3UJ1zRhevJ9DbjLwfgyJ0STD9jXZQO1Qf55S4GO/Fd17qYWlz3f4?=
 =?us-ascii?Q?y6oWc67pezaBEA+E/I5m4ZXVMsQCjAwlshjyI0qK2RZnzlFgXdjsPyz+x66a?=
 =?us-ascii?Q?Oprk0xLix5DUQnynpTbgGK69yqPrrxwibZiCbhxY7Zd0dWRKReG3uED15bFu?=
 =?us-ascii?Q?HudHuSnXHVgwqe/nl6yTQqsQG54uzaT6RJJWnNxL+I+DCNWh/jghboq8CZsN?=
 =?us-ascii?Q?48t8ojcPG7oH8jhf+YMtbtp5H81bLJambesj5kEeeaYV7b1gt0C0PePvoHLR?=
 =?us-ascii?Q?7N6boBKm9HsuMKWoaV9NDymRdg1tKCLaxBE27pkfAhxpi74KXR2RasDHohLd?=
 =?us-ascii?Q?2CyKhaUw3GTWJ30y3XSMLYDxvHxfkcVcL8LS+OiqiRXPzOUlKKvZArS93phQ?=
 =?us-ascii?Q?QrJy8zPdbv+PXCLCw46ZrlkjKBqfKcCVHTF+uCQy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5368.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494611bf-40ba-47f6-3649-08dc595a9f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 12:34:53.3381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqEvNRtVQtnWJCH0TqZKXgaDzLivgUJb1p4oRqPzJYDEndipIjrLmhCb69oMiNFrPVm8WgScEIGDFXd5Q9FO1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5440
X-Proofpoint-GUID: oKbXQ7CJEFbxYAk2P7PL0XKiHLzz2v0Y
X-Proofpoint-ORIG-GUID: oKbXQ7CJEFbxYAk2P7PL0XKiHLzz2v0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02

> Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
> OCTEON DPU devices
>=20
> On Wed, Apr 10, 2024 at 10:15:37AM +0000, Srujana Challa wrote:
> > > > > > +
> > > > > > +       domain =3D iommu_get_domain_for_dev(dev);
> > > > > > +       if (!domain || domain->type =3D=3D IOMMU_DOMAIN_IDENTIT=
Y) {
> > > > > > +               dev_info(dev, "NO-IOMMU\n");
> > > > > > +               octep_vdpa_ops.set_map =3D octep_vdpa_set_map;
> > > > >
> > > > > Is this a shortcut to have get better performance? DMA API
> > > > > should have those greacefully I think.
> > > > When IOMMU is disabled on host and set_map/dma_map is not set,
> > > > vhost-vdpa is reporting an error "Failed to allocate domain,
> > > > device is not
> > > IOMMU cache coherent capable\n".
> > > > Hence we are doing this way to get better performance.
> > >
> > > The problem is, assuming the device does not have any internal IOMMU.
> > >
> > > 1) If we allow it running without IOMMU, it opens a window for guest
> > > to attack the host.
> > > 2) If you see perforamnce issue with IOMMU_DOMAIN_IDENTITY, let's
> > > report it to DMA/IOMMU maintiner to fix that
> > It will be helpful for host networking case when iommu is disabled.
> > Can we take the vfio pci driver approach as a reference where user
> > explicitly set "enable_unsafe_noiommu_mode" using module param?
>=20
> vfio is a userspace driver so it's userspace's responsibility.
> what exactly ensures correctness here? does the device have an on-chip
> iommu?
>
Our device features an on-chip IOMMU, although it is not utilized for host-=
side
targeted DMA operations. We included no-iommu mode in our driver to ensure
that host applications, such as DPDK Virtio user PMD, continue to function =
even
when operating in a no-IOMMU mode. We observed performance impacts on
certain low-end x86 machines when IOMMU mode was enabled.
I think, correctness is Host userspace application's responsibility, in thi=
s case
when vhost-vdpa is used with Host application such as DPDK Virtio user PMD.
=20
> > >
> > > Thanks
> >
> > Thanks.
> >

