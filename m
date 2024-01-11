Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BB154A7
	for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="crKyeNom"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edWyFvWe0Wwnz1jLg2K8g7u4aTw39KHDGzROiwYTJ/Def1X3Dk3z8UExt1GRr/4JroYOks1grN2F0hHo+8dI1G8GxfMhsdj0W1uY2Gl3QiRZfGJzFIKM6wSs0x4CW/fgl9lhsahJRThLQFVC8Wtb4F0x5F8bzZ8GjF32sowUaES4yNI5bOKDe0pBOr/O4s0QxdaX0Aa6nFkmdi1bG1w/oMYeWiZM6KdZnThMipWLxxyoCqk45vh2Xty1LOE9GjaHIX0ks5CdWqVzCYplgf80GKe7GShniuPWyQdcWiuiBt+yAXg10rgaFTdg9eGlBqNc3w4Zn7unWnMvtr39NoPGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfnhf7AuxjZWdMPf5ynVPKu2OfVu2Mw2Ui9PENj8WYk=;
 b=DTWBqtPZjCCPUMvYnZzkdrvcoxvgXY5nEplykxUrT825OArUS4s6mBO8N7dr73ADVoE7zuri4Mnelf7Eh2AUwIc71jrSFspW5zJqz/GFjv4+tsKFr+IEdvQqxgGRjxD1M0rsaKxdafuwmpOCq/KTFUh686POXgcHrA/LBMovQVMq++3O0y7U8PuXTHYWnAvMp9YTWhtdIbEVHplKwupQuauLKYWFUKylibRm2tGqYRKKX+1GRDcDIrSl7w89OLxjwlv0+Cr6yx9OFn9loXbfEcTDAtQsRTPzwBgtvzfvsEnEB85gD4R6vkffwgdQjYdheqTSQpeprm/V8Jl+wMazug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfnhf7AuxjZWdMPf5ynVPKu2OfVu2Mw2Ui9PENj8WYk=;
 b=crKyeNomoG6iB8gCZwHKJw03QIPAzc/Yo0qKPX0jEdaX7CIqlMB+/i9QNtH4QL/De+qAUxIgVGxtQd31tX9C+t5UAcpX1ls691R7F7nQVKQu8341ss8hrWoMHXeebME4ieUt4hoGpgJCViM1Cmmd+EhfSd9HwRjj58RiGYWbzDtZq0+GrrLPjBsAd8NLQ6HbCIsEQT5KXFCHTcf+kLmsIH7gE1UcyksMdJgN4q/PGb1cy/IdZGl2ikcYAOrlUhYr1DhCRUVQDIK9jAsWw/lpm8kgZLFZ7YJCwutb1AYS84nO1aH+Xnu9zB8epggw+FvaRhlcUJFMqut6HsMDr7Js0A==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 11:54:36 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 11:54:36 +0000
From: Parav Pandit <parav@nvidia.com>
To: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: songyang23 <songyang23@baidu.com>, liubokai <liubokai@baidu.com>,
	"Song,Zhan" <songzhan@baidu.com>
Subject: RE: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Topic: [RFC] Revert "virtio_pci: Support surprise removal of virtio pci
Thread-Index: AdpEbQ0W9HGTHF1qSr6UzsNmXQK48wACc8LwAALG6zAAAJr3EA==
Date: Thu, 11 Jan 2024 11:54:36 +0000
Message-ID:
 <PH0PR12MB54818702AF205B65C676E68DDC682@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
 <PH0PR12MB54813F1133C29AC8FF0097E6DC682@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a26b34bcb1fb4b5d9f64f0f277b8e85d@baidu.com>
In-Reply-To: <a26b34bcb1fb4b5d9f64f0f277b8e85d@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4130:EE_
x-ms-office365-filtering-correlation-id: 0e66d802-e532-4a57-09ae-08dc129c1567
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gl0Eev/76QjtiY92Qaivzb5yjLD/TdqPFJSXzOf6e+rpP41ciB0oyj48L7uO85G1dQeoBGVcN2M7prePEScneSgtzLPIjgeioi4gn5a/McGWA9lFec5bMy/lgQXvhQtaTjfuU1//yAfubHXT8V1TkOBbIX2c9y6zT0Uz2/38PCvu6kkhTpdERwdmGfsU7soXaEQRTVPFXaEQI8oElWIuDz5US/+gpRLpd1YJ3VVG9pgEoEP4HkalEVmWjHg2juT9IjUsJBpbok3SHozZlL4Mtdw6yIn4itwI5YhOxJs4159BGvQDcR9SHIrFlzLz16Suxs3WxhNcgujASAlfEL9N3GWA3K5s6DXK81AxTHINhCyAJkIROKrW6WBCPgVjzalaqWoG8/hgxbyTF3QJJXUutRtU7f9YwvZFsCq+r5WO37Cs6GLHE5aQqcXwci1Ba69d3XMdkmEzjU1aI2MNudu8rG3y/o27p1xt93UzZMSXB3DKBYmxkXDvL6g1vOEnI01li+f4elfgS3JftbA1FMwP8nSYkxILMjZnlY5BFoEVjlgQ3sWf1U8oLFRrzpT5criAEVSiKUsas35zibjmxhmdCqEaed+QTwfRbbm+Dzrpa8AgPVII4aCSmYkxFAZKwrxv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(86362001)(41300700001)(53546011)(83380400001)(71200400001)(26005)(38070700009)(33656002)(7696005)(9686003)(6506007)(122000001)(478600001)(8676002)(8936002)(4326008)(5660300002)(52536014)(76116006)(66946007)(110136005)(55016003)(2906002)(66446008)(54906003)(66476007)(66556008)(64756008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ba7rwISRCteBM4H+0SOxkwMrpIm4y6BprcgItSmcNmNyIAXlaHle1O9BU916?=
 =?us-ascii?Q?+20MFU8/x2M8kaj+F/UGe05DLFalui7b1SYcp3MmZiEq76aMEkTM64xgpRk+?=
 =?us-ascii?Q?muJUgBt/4hCQeyxwSYghLZ0Z09O00mdm1alBjr1k+KE6BzntMtbUc6jR0y/P?=
 =?us-ascii?Q?10+axCOCVLLJlAprwISoQpprjxfiLGZwU8tcNLD9rmyD5uY3LVqbBEvp8ggj?=
 =?us-ascii?Q?v5gk3/eo3TcD2ad3sLbRT0+ACL0ANbH1bNuF592APWtnx7aJdIADupzcaeEZ?=
 =?us-ascii?Q?WGmr0UP3YGSD3lAkfsYC8XHHwGE8dbRA9eRRuEeaG5CdbA4eOczaUfMp0p92?=
 =?us-ascii?Q?rrXWWiRGJvoUCY5cpQ73gV9F0n18qlPUpk42WwL99KEDha/YZSlsq5TJXK+g?=
 =?us-ascii?Q?itEggHJg7Okjd0j8GtMVWotRaFL+zqRzkK8fS2oFcWsMboRLrvSyq8Jtk338?=
 =?us-ascii?Q?U85tESS/6xZmuB2itizP+LkZbFELnfthdS3iKnNZSP0Nl25rPVPXla4AcKIW?=
 =?us-ascii?Q?ES9FOwEk45LPNcs8hcGvYDY33bAXkZ7KHxaSjGU6ImeaPHsMCslunBKQ8wdv?=
 =?us-ascii?Q?dk1qWSsV8lShVdjqnwe0EbTcUYgW1vtDASyBJHZpyJVmlj7ITmiI2A83WTUn?=
 =?us-ascii?Q?rBCD481QMZXJwUGr1aZaaSFipXBuDQGAt3byVKY+VM2ccpfB/v+SUuCu5qXr?=
 =?us-ascii?Q?TJ5SIPZVMRrvpXoGrNHGZTa9AxylSL1bEOIPCSKqtRBjEum/9SUpMYuZMeSS?=
 =?us-ascii?Q?fFdLN3v2PoDyDaSaJ5oFG4hSxysXsZwoH8h9WlkFUIYkaEuoP6H1KSF3Wk32?=
 =?us-ascii?Q?Usti2sBiUrNBFw09dtteN60MTGAUk0wg05nxmy6FJuKH0gjN0FbWQFeKesc7?=
 =?us-ascii?Q?2Bwdk89GzmQCp7N7Iz1iQjjbXpFlK9d+s9DZL0fR81fSZT4fvhrblLu4lr4h?=
 =?us-ascii?Q?8FgUDLVz+xwBiYn8K0ZvINHbNbvaMLzfzUQ/hR6kfdXtaJ/WB/tFBoMc3to8?=
 =?us-ascii?Q?iOylM/c6tT898hKbFn0TdOqjEmyV7yhrP2zx+7UUDMwRBTAhsLDFnR91alMv?=
 =?us-ascii?Q?qNTBR3peKv0bJV3dtSB3a3w6+sPWOKnFi2FlCrNA6aCE6SFvJrP5ERTHkF4b?=
 =?us-ascii?Q?Qo3/94pK7ZQPljuvBAylj1NjtdnyUexhQpu+X/wfob2H16BrhVsarNEqQd8L?=
 =?us-ascii?Q?ADuuf29gJ+st8KU1dB0fkBktlXZjPMzqmgiMMmgPARYZzj214X23vp1+KoXv?=
 =?us-ascii?Q?4GecBsTk2LmeoHV2K12I0LIGLOshrGQHAeZ9EzUqF+3DA6cFp8Ya2rUKR885?=
 =?us-ascii?Q?Sr6xHEwS3AOsSx1P7OMul2QjtnVGAj2vu5FTYfUcArrl8EmlTwqr5xvW9cLh?=
 =?us-ascii?Q?IoffGXRBvarLOVlRCulGQMCmS4xKPoVmApe3+YaZpwhjEncaxRNmfNHrEaMN?=
 =?us-ascii?Q?GMD4mKrb0DvacHILtNq+UyeNaUgwXXsVwhPFckZbkBhKqieizlhuwzJtuMAL?=
 =?us-ascii?Q?kxY18Xo8sQOGspmVy/2hY4ZcX4imZn0EwvioOaeSDD4arUC5fzZBRme7c2W/?=
 =?us-ascii?Q?ynFwWA7SB7Dw+jZfluE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e66d802-e532-4a57-09ae-08dc129c1567
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 11:54:36.3018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08zDJ1t7O0m35iReNERHJ7iiw71+T5ue71Ub/L+2vTSCm+miBfVMYkZECL+Ic8KY3kOkkZSomKBGg3LBd4mCMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130


> From: Li,Rongqing <lirongqing@baidu.com>
> Sent: Thursday, January 11, 2024 5:18 PM
>=20
>=20
> > -----Original Message-----
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Thursday, January 11, 2024 6:18 PM
> > To: Li,Rongqing <lirongqing@baidu.com>; mst@redhat.com;
> > jasowang@redhat.com; xuanzhuo@linux.alibaba.com;
> > virtualization@lists.linux.dev
> > Cc: songyang23 <songyang23@baidu.com>; liubokai
> <liubokai@baidu.com>;
> > Song,Zhan <songzhan@baidu.com>
> > Subject: RE: [RFC] Revert "virtio_pci: Support surprise removal of
> > virtio pci
> >
> >
> > > From: Li,Rongqing <lirongqing@baidu.com>
> > > Sent: Thursday, January 11, 2024 2:45 PM
> > >
> > > Revert "virtio_pci: Support surprise removal of virtio pci device"
> > >
> > > This reverts commit 43bb40c5b92659966bdf4bfe584fde0a3575a049.
> > >
> > > Marking the device as broken will cause the uncompleted IO request
> > > on virtio-blk since virtblk_done will not continue when it find the
> > > broken virtqueu at last it will cause the failure of removal of
> > > virtio-blk device because of uncompleted IO request
> > >
> > > The correct fix for the issue that commit 43bb40c5b9 ("virtio_pci:
> > > Support surprise removal of virtio pci device") tried to fix is that
> > > virtio backend always complete the IO request as soon as possible
> > >
> > This can never be guaranteed by a device and by pci spec given it is
> > surprise removal by definition.
> >
> > For Linux virtio blk is not the only block device which has surprised r=
emoval.
> > Nvme blk driver has supported surprise removal for several years now.
> > I am sure nbd and others would have too given its network.
> >
> > I am not familiar with the blk driver stack.
> > So please explore with blk community of how to complete an
> > aborted/never completed io which never completed by the device.
> > Since the blk driver knows exactly that the device is removed, it can
> > 100% complete the io to upper layer with the error in deterministic way=
.
> >
>=20
>=20
> Without the commit 43bb40c5b92("virtio_pci: Support surprise removal of
> virtio pci device"), My virtio-blk device can be removed successfully, wi=
th this
> commit, and if we use fio to send io requests the virtio-blk, The removal
> always failed.
>=20
How can it complete when the device is not going complete the io ever?

>=20
> Once virt queue is marked as broken, io request can not be finished since=
 lots
> of virtio functions
> will check If the vq is broken, if broken, exit directly, like
> virtqueue_get_buf_ctx_packed
>=20
> static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>                       unsigned int *len,
>                       void **ctx)
> {
>     struct vring_virtqueue *vq =3D to_vvq(_vq);
>     u16 last_used, id, last_used_idx;
>     bool used_wrap_counter;
>     void *ret;
>=20
>     START_USE(vq);
>=20
>     if (unlikely(vq->broken)) {
>         END_USE(vq);
>         return NULL;
>     }
>=20
> Nvme is different from virtio, it can ensure that all requests are flushe=
d to
> completion, like below patch:
>=20
Who is "it" in your above comment? Is it Driver or device?

In below commit who (driver/device) flushes the completions?
If it is device, then it is not surprise removal, right?

> commit 1d39e6928cbd0eb737c51545210b5186d5551ba1
> Author: Keith Busch <keith.busch@intel.com>
> Date:   Wed Jun 6 08:13:08 2018 -0600
>=20
>     nvme-pci: unquiesce dead controller queues
>=20
>     This patch ensures the nvme namsepace request queues are not quiesced
>     on a surprise removal. It's possible the queues were previously kille=
d
>     in a failed reset, so the queues need to be unquiesced to ensure all
>     requests are flushed to completion.
>=20
>     Signed-off-by: Keith Busch <keith.busch@intel.com>
>     Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>     Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20
>=20
> -Li

