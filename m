Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAA8136982
	for <virtualization@lists.linux.dev>; Sun, 14 Jul 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720967315; cv=fail; b=iWrdM4BhIO4LyS51NmHywnDxwCMIKP4a+DkZGQN3UhA0dXJ+9aJte1XoQpYnosV7uos8DGvVKLVEcviNZ4r+3EeUYiHhJ1MvPF4Z/iXczZXSib9ZnFWlATVs5vktQo1Dim9HqnkmhOPixHktpIVMt4u/HNCp81MUfBZsSSDNR3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720967315; c=relaxed/simple;
	bh=rYotPfiMpjAVYklinAbYli+cMtgrGC1rxrQZ/DLkhUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nuW4/nXvzU62wpoVx/U6CtmYg3HTAp3/Fk0x1Wop8j1NDTi+9Kn+7JTOd4ydxsHwfA3GsKJtL0Nf7B/RrI/dfx2dHZRuHbwgiLW6jMx/w6RLOCFgW7DW0CK+RKKTxAwmQK+dejdKMhpNIlQ2ToxJDsw087qxla6iGX2d74co2fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gFhj9k6S; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gFhj9k6S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSm+q6E8bumtRUBJfrxPhG/qYbG4D+gkITByl/h+TiqHhEAw9X+EUGj3HOimkUs4Fli3WAshY5G+4XPMxpTLV5wvApvqyio76Z/wAGD2PSd7UDaxVWjbifbtv5/xbABOfW52A1pj0JJcJlAQb5GJOQm7a29bTguwYXvmMhXAJq7Z30ILe/6F2sW2y1t8PdydfiJ61E0ed+GkaoJMgRWj/UZyhqcWT4oS6BCljFsBJngcmOEF0qz/xNzkMEuUrw0GGuFSqgliDkvbzLaYWYjL8UP3yJ/b9IXMlugEyvCup/JB78B5S43V3Z+844baOfi373PS8Ng0Dv9hqaWLQO6arQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLycPgMlHP1tcJOOaIZzAhH8JlM/QVMOQUKqMyNPXTI=;
 b=AOQJ4i+384Z7FfQTBw1wMyOZ4PEOdW66qdZKWvRevsjSZDDrJ90VDpLyKh7TNVwBg8AXIk53w5qclnzF/l7wW3LflJtlqRZpOWzg09rQq/wATZrkNFwwhUgobnB/NWZGihahNtk02J/5t4iqf6M0hU3WVME1oLMm556B6N5AIlJVjv0WdAoYjWi9wkyRBDPMlMN/LRFjPwAAL8xEphapzMj/zp/bhMXsuRedxkMlWxhrjMVeOlq+hT4k/4z0HO9Puzltluvzg4ocy1TNVfIG4IqArXpbPURZ/7Z+VfFq6EUhPBTOkehuKFgLLKXt0pSz8HCZqe/7wlcoqq9Mr3v0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLycPgMlHP1tcJOOaIZzAhH8JlM/QVMOQUKqMyNPXTI=;
 b=gFhj9k6ShEd8SeRAHXe92SuXCVxrCVpV4AQ2tSNpX3u70SOR3vPUUcDWxo0j1WM/iiqNRga8dWFT9DuCrKlBtUVMLlK21RSQXORSAxodGpOw5N6mWuHXywxbtLJkf86gGhdxe/q7Twk0s0rgy7TnkX9nP0GxcLrJABkhnYvLvPU070UBUZen6NzWEyF8s9ixY42g/uxcX6stjXbmfLcgsYBPgCvHUp0NruyzjgzbLxtyz6EMJoZFcuM6fu9CAGZkuXAloT3GyKrOquO7mKAKCKoFyxMIf2BkUtgA4A8E1dYJ9aqfqn2kQfmxtKd+dCDBSsHY+NvYPMCReETsfk9Q3g==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ2PR12MB8980.namprd12.prod.outlook.com (2603:10b6:a03:542::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Sun, 14 Jul
 2024 14:28:29 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%4]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 14:28:29 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@resnulli.us>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>, "hengqi@linux.alibaba.com"
	<hengqi@linux.alibaba.com>
Subject: RE: [PATCH virtio v2 10/13] virtio_pci_modern: create admin queue of
 queried size
Thread-Topic: [PATCH virtio v2 10/13] virtio_pci_modern: create admin queue of
 queried size
Thread-Index: AQHa0pN8sbWJwSVNv0ykWqW2mp3fEbH14SgAgABtneA=
Date: Sun, 14 Jul 2024 14:28:29 +0000
Message-ID:
 <PH0PR12MB5481152D9CF63DD6AA6611E8DCA02@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240710063601.2000149-1-jiri@resnulli.us>
 <20240710063601.2000149-11-jiri@resnulli.us>
 <20240714035231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240714035231-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB8980:EE_
x-ms-office365-filtering-correlation-id: 1535437b-60d8-464d-da8f-08dca4113b1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DReZ1SHUlxHGiIr9aDDCBhyuT+67/vw8iwR2JR5TWveBb5+ei19lROnKMKIl?=
 =?us-ascii?Q?/qdHTLWU5lQe3A2Ppk7fif7K9EjwvLxUco+Q6bcSm74IUbLtkBJlFhU+j7Am?=
 =?us-ascii?Q?oy4cDivzrN3hrDGjGNuA7n5E9GL/LGPdS1ogKVOHK2jn7fF/OMPNh3JFP8bS?=
 =?us-ascii?Q?UgoCANeq2N7w24K0Wx3tY9g+chVHiMMGJshH74IeX7zdgx0JPfM6YsifAjbZ?=
 =?us-ascii?Q?reqSvlPCxKGoJ8A89PnDP4D0jqkg4yu9BrB8+UX/udSS6y6z8H5C8eG2BV1U?=
 =?us-ascii?Q?74IU5ZWEdsw0JzIKTrbA+T7dSv1o5zVRQc36LrpoywacicNnWrDXcxSPJ19J?=
 =?us-ascii?Q?06jqKyRzvx8mn/EzDRMqW4nx/sHB3xQjf/8Qb2waXw8Q25vnNi71q4V82b7E?=
 =?us-ascii?Q?gTynSTeoY9dDFljJjtW7J5w0mAqusByN/9tUn0XqeJXhpDVTbK5VZTiF//3Z?=
 =?us-ascii?Q?46C8Y7v6RH1wnVkEETGCytLLBl+WelBQF/0P64u3Tyo2ajBD6M1pBWeeEv1N?=
 =?us-ascii?Q?9gEGxW+ukxaN0DKmksia/kjsNPY9v6I/dO10RVvBDneipBWNthL806Wlmz+G?=
 =?us-ascii?Q?IrFNjT7TDpFljBRxE3M5eBdYHjZsE3p1B2lLg660ceM30ohfH7rY2OibPSWU?=
 =?us-ascii?Q?CDOW74BLQsRp3yyer+xtR/QMKG6VfzDMphpbhOsZSBdpdCU/3eYtXFzckRbC?=
 =?us-ascii?Q?KOkXO80SUmqM4j9gEKkl7arp/DGG2r5j4OXhqmIaEWGGGqCTt7/13Z3SAOzt?=
 =?us-ascii?Q?eKTB1fCdPYueGlkOZqH76Yz9wlEDVajRSwSthFSO36VtjIeXdQIz0s6jAoVN?=
 =?us-ascii?Q?c46kmJxzuYGZ+ubAYouEA0KP1KJjQkqu+peYi9TrHT6+OGe+Q8mH9qPV+IJ/?=
 =?us-ascii?Q?4ItYKkHQYM56NQx5kug2vk/sjnGPxej/mUAGO9xkxdz7YTFaRGut6nMToP+z?=
 =?us-ascii?Q?DfokwrM/rJVCCVkMXOEcJS2OZDWxc1a0CpxLEZ/X+3YLOBncKstIp6/+Lmmy?=
 =?us-ascii?Q?9RHwws5cB2ICAV+tbPxs+Yhon56GVeVJe5DcEsYJIks5r4ZgCdPyo8DuPZGN?=
 =?us-ascii?Q?908G+QVoshOddjFKqd8N9vEMe9KJnFoomppUss4zZFEI0udex19HqTL69OiW?=
 =?us-ascii?Q?yOPF0DDYUJzd5U1iuSnRQNvhz3x6Yv/FTE34Ny+NMkH/e90KVPseH6OgkjEe?=
 =?us-ascii?Q?aEUvUPc7P6VEzQmWdxFLKZWeB9mg3AN33cDup3FS2MfHXx04nDvjajhKfCUn?=
 =?us-ascii?Q?SDK6X/YWlJwpa10ebmtp10DJ6/PlyB7IMtfRJketWqp4zKPyU6IR7Y1E043T?=
 =?us-ascii?Q?HsfLQ8XTCMteVdEJqeVkJhc7XNJnQpataRQmP1+OhGA2Aj8JzhEfpPRu80lr?=
 =?us-ascii?Q?xsFqldsxwVo49ExGp6laMUSiFw2qDKuBIcu/Y+SLO+V0YQUROQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XnO3pnah9bcigS4SCG/hdI+h+dbgxb1wydv7V3oT+Wdmro+/W/6egTAwhXXY?=
 =?us-ascii?Q?CGvh5jspODsBYuTQIMYIwvOWR3ufhCuSPXgqtoyRxCRreAtxbxPWVZ3noFr6?=
 =?us-ascii?Q?4MD5olijfXOiUfUr7duT5PN8HYNIWNF1G71aqZO9NdaH2UCXcP6y5IDXGAHx?=
 =?us-ascii?Q?BRQ2IIhoPybeXfwRUMqYjmxN46ssTimTiL/Ej6x7RtiXKSCmN37SIQNXcDxJ?=
 =?us-ascii?Q?tCX+IxXEBqx0eMX0ksAP9PyRn9wlXAxh0exMTofSASPbe/JnsjxCO7fXG6OZ?=
 =?us-ascii?Q?8ne2qViFoEXnalLPhBTCao80R7EHA87bXLYleA8RMHGJxPjOIzcEA5ekTORB?=
 =?us-ascii?Q?DIIGPKixHdZwl6OkMeBHQobEvS9/RxgHtg1fqG72nUjCgckRNzvWE1sgsKWt?=
 =?us-ascii?Q?UC5jLM1qAjS3RNzBiQHkgP+w6qhS1Lq3rACnFCOrAWIXiEAIQvvb+fi2Zx+U?=
 =?us-ascii?Q?5QuGUV+/qQhYK/B4NvzkG9FqrHczHqvxq7/FjUI21eA3X1C8ZFcLgrbJ8lcY?=
 =?us-ascii?Q?YaTuDHw+VBDlzaw8F+aKbyKa401GAj+B26Eovp7sbb7uSiZEboYUYDrsaTxp?=
 =?us-ascii?Q?pnebMmGC4awFs6aRAWYW+yUgDKDfNJp/q5wPOg/XTnTynxfbV0U2MwvYcCmw?=
 =?us-ascii?Q?NkbkuifowNbxq9pjH3GTMDWhojHJnEJaL/HGQSGWEiRJlhZxpqayq8xzU3gp?=
 =?us-ascii?Q?66+w9Uoo8tOeTvkTVWqu2UdGep2YRcqxLaf9XRqOt/a664EkpWMvAg/Rtwz3?=
 =?us-ascii?Q?LTesYf8kThJqZz3epfcVZOR0Kogl74vorKmWeBDsfzfdzN9fE1KXL64PNzP4?=
 =?us-ascii?Q?J4onCcZXnZkkAOr6HKtd3qm8GPqTBdfgj3WQNhYsDRIHHub/HexklUS8E8GD?=
 =?us-ascii?Q?E0KuMoF/psv+oQ9iku0W8fbHjO0wJBFibsqtqmj+Ejt/lOE4c0tNtW4eRKmq?=
 =?us-ascii?Q?YpPr0EYmEWrbrSqGePMqSVYtFMc9UGCZ519JVehfMnsbiNcTHp6McOIr1wFW?=
 =?us-ascii?Q?nw00KBw/NuM49vWrtq88OqYR9GB1uLwaQfdSHZIjJ5QxdpcnIwo/2ihzp/80?=
 =?us-ascii?Q?fR+zGshNXs0wnfNzXP8wre0B7ao8yi4pkV6v+WHVKraQKREndg50cIKUuOTB?=
 =?us-ascii?Q?ZxgFdU2ADiIy95Z0jmztoCo7qtSn59bmh4GXVHdNX10LKefoVgp1ChEeLALX?=
 =?us-ascii?Q?cgW8Z5KuyeKAPDBPsCmqnM9QIfBUQ0pwu3Edxizw1Nab23DoAkpp1YD8HskU?=
 =?us-ascii?Q?h2Z1qoi2FSeQOOf891fWe+lLlI8ZXD0jZ0T4wqfPY4s0OQfjhB78aBLf87Eq?=
 =?us-ascii?Q?Z+xCoRhRUuAxxeRTTP3Ilo4PicyeyBqQdpwIYJYrtKgUtAiF1pBkpT1T9h9y?=
 =?us-ascii?Q?WoY3Px1kJDKNjjDpqsl/ZyBcJYrB0oepaQqI/U+eKqwt3z5xaiewHiBndIj2?=
 =?us-ascii?Q?b5awJjxXkNLxOca2jyGApwVINo0l5x08yf4YCSvGCZqdJ0/SGHhDaY4iNukP?=
 =?us-ascii?Q?fqd9+udWgwfiZ5I7QtKmxxitoxkhOPoxZZDmstjStEUTRtwTe5Y3DiAxKiHL?=
 =?us-ascii?Q?kC36Ah+WXDad2oQWQNA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1535437b-60d8-464d-da8f-08dca4113b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2024 14:28:29.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fnlpj+yz5/SIx/2dFOrxuaNWORPPZctr249Krf+jk3FnJvQEEVGwbkGuQT3+bJXzKsHPy1ArFBwO2nFVj2lzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8980



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, July 14, 2024 1:25 PM
>=20
> On Wed, Jul 10, 2024 at 08:35:58AM +0200, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> >
> > Don't limit the admin queue size to VIRTIO_AVQ_SGS_MAX and rather rely
> > on the queried queue size.
> >
> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>=20
> I have some doubts about this one. Can't we limit the size to something
> sensible? E.g. max number of CPUs? Number of VFs? I don't see why we
> should just follow what device did blindly, the device has no idea about =
use
> so would tend to over-provision.
>
+1.
I agree with Michael, we can possibly do min(max_cpus, device_supplied_limi=
t).
When more use cases of it arise, this can be improved in future to use larg=
er limit.
=20
> > ---
> >  drivers/virtio/virtio_pci_modern.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern.c
> > b/drivers/virtio/virtio_pci_modern.c
> > index 5ceb4b2c18df..a649c9dc436d 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -550,8 +550,7 @@ static struct virtqueue *setup_vq(struct
> virtio_pci_device *vp_dev,
> >  	if (index >=3D vp_modern_get_num_queues(mdev) && !is_avq)
> >  		return ERR_PTR(-EINVAL);
> >
> > -	num =3D is_avq ?
> > -		VIRTIO_AVQ_SGS_MAX : vp_modern_get_queue_size(mdev,
> index);
> > +	num =3D vp_modern_get_queue_size(mdev, index);
> >  	/* Check if queue is either not available or already active. */
> >  	if (!num || vp_modern_get_queue_enable(mdev, index))
> >  		return ERR_PTR(-ENOENT);
> > --
> > 2.45.2

