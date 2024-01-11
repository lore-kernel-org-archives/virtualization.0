Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231A2837C
	for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dihB6lNC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbRiPu3lU220+dc87XzhIYj0d8jf+q72EMWhBPnbjIYN6j0y5F/mwKAElWQFo0PWa31cAhdKMcnOQ0HuLk3s52GGzBG+VGEFA8UbdeAGlfR9h8GxoawBkQqwRxhtlfI7+dgaSuG8Pl3GuM4M1z5BXUKTHJZRMAskPu4LmgEsQrW9EWVQ46FcrM11Y1sBpsT3PP/SGCAs62vRWFc69yVxccv2NbvGUmbjhjoegf0RH/CjOgS4rL4zu+5UYIC7c3RAQZ8Qw4Amh/nGNGKly9mrgcVUBsXsjNFkFR+1WIuNiAOx1HeOpZX8s7ZaRgYIXMPXFDzh3nIciBhMLQSthfUQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/e245CeAFjerMRtlIICbTJaJ3IMiWmGr2M5GP/Q6xE=;
 b=GnY3Jqzfad9/92ihS0z07px6VxSUSIL9XLB9t/bMFb8kOIdgXF2D+asmzIevzCEN5XPK1Wm+WmuH6IYQeGu2K39QPNmmcLlzlmoLbPPfOKK7PXdJaoVIacWq75+V3CXdxutkwkd8o3yoBQiKh0gCcpP3FUZbPemfV4p6skcmx4s5aL6uprZ6ysTZ3yPyIPiX+CQFKZ3BwUHsdtRqU8IIMpH3+MDdWoxcDTX6ATYam7QzEOI2Ih02E5vkWOsnrr8+kd0BJVpHt2I9kDhrYY0JX3ypYi7G4ZSDPlCYHTMcy9EmRfaWMRxucJBYKqTTvpCymceMDShnb2a1XCFT7jjEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/e245CeAFjerMRtlIICbTJaJ3IMiWmGr2M5GP/Q6xE=;
 b=dihB6lNCNRlbLkKorT8FfkI4MeVx7GI2PJ4Pey6rw4dD4r4YnjhOB1/sxzBYFycJf/zrgw8Gri5B1Jfl9JYE3H6TJC4PgOQKCsYkzlcRpjl0OkELPsP6uscNl/NfwUmzrmj+vfESKDB5soFL5+7wjofmdVuYgWivLgtDtNiYd0nO6ug2lnRaFhfob0vnt0Cu1sPcSEA/BzrLKh5CdhNfEi7yvLQad4NQwwxY8iktvGIPOg67oULs3oljOOj7VQ5sbR6AFB6WQrZlW/In3Vc8T7YYTa0u0hB7BZmijI5/+P1YSYTc9qOVdBq68xLlYvfR6N8IBCjDkDbhPY5HnPNBVA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 11 Jan
 2024 12:01:37 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 12:01:37 +0000
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
Thread-Index: AdpEbQ0W9HGTHF1qSr6UzsNmXQK48wACc8LwAALG6zAAAJr3EAAAKxJAAAAm3AA=
Date: Thu, 11 Jan 2024 12:01:37 +0000
Message-ID:
 <PH0PR12MB5481453CE7A8EA8FFA981AAEDC682@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
 <PH0PR12MB54813F1133C29AC8FF0097E6DC682@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a26b34bcb1fb4b5d9f64f0f277b8e85d@baidu.com>
 <PH0PR12MB54818702AF205B65C676E68DDC682@PH0PR12MB5481.namprd12.prod.outlook.com>
 <97deda0df378468bae852859cb1c5317@baidu.com>
In-Reply-To: <97deda0df378468bae852859cb1c5317@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB8765:EE_
x-ms-office365-filtering-correlation-id: 05abb2c9-408a-43ab-23c4-08dc129d1047
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3zXgV35VHiLef1Czv3kouyfueV5S60k/Jt8aGODabd1ZSYm9+vCAhs0FnEm8F+oImKpJUDABGPttlRyIJQnW5FXfjpHTfw3MfaQgSa+gdm7uyNQhhgWlIgCUZhKM/0n+0vSlfNY+XgPDwgoB4RuxsK8RT+0kOZfVD3OR+1duec1zi9ww5y47jGiQ90beFcfPnRAkqO6Ia1WurYlFhDgjqFMrvg3bZbMuIACfQW8AYsRXLerguXD8Qs2WmifofkjlxOreUOXFZC35Xs8CKQB/+RzjsiGwxKA2gXlAXT5iR3v+VIvpg/TJyvWaEjRp6H50FPNFXel0D+3CCekmp69NuNkBaNb33b7MFe6xp95o3UMcZCMAPjYo+hN7AwaADefwTgIiGwb6VH5JKLJPjZ9a3NxVQtWRSnIIs6OSGKS7Kytk6z9r6PNLv87Js4VUiF3VfYlQdvgeUymc7FaaNNjQPEfNYyVSzXs0AJk5GwhK3G6U7D6g4HtqhoPb7rfBailQwTCAaYz2aXXq9If/rjIBnMLikhJnGcBZAVOfILVTO+oiZtaiPJrR+1WvRdqMJfi7+88GKMwtPESndaNTSRPsLK7RkPLvVc+I5FAGGR3TlH9bG6JvdjuTAWYu3qSvf+fp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6506007)(53546011)(55016003)(38100700002)(9686003)(26005)(71200400001)(478600001)(7696005)(122000001)(33656002)(86362001)(2906002)(41300700001)(66476007)(52536014)(66946007)(76116006)(66556008)(83380400001)(38070700009)(316002)(8676002)(5660300002)(64756008)(66446008)(8936002)(110136005)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yb8ew3YMQgartuuvMa8NSyhJ0/EIoShDoT387B6wDuod02qextJif2//sOlC?=
 =?us-ascii?Q?CWD7LfbaGXY55lcxf5W7vSCCmfn6APwxp3uFECxMh9TTwofs+2x6UrEP82di?=
 =?us-ascii?Q?SWO75N+b/aQOwko1EscSiqhgefeSGR4KsUWjKoN4jGEUQ5RS0IM9IoJGTGpD?=
 =?us-ascii?Q?gPS5bn0dY4vjwDNfsGtJQWm0U7JqbKCNfnFA+lSjmrjiI5vqdmE4TpcJJPiY?=
 =?us-ascii?Q?/fQpa9qu6Ve+/n7R41aV4RDZid+LZhKv5E8MzPnfWKcpugLMIZcKq3Z5c1vC?=
 =?us-ascii?Q?op7bewZyVcKhere+5VCOPnJCvSDXz7pRGz9hlg/8SB+9eGlL/o8wnJTdlPh1?=
 =?us-ascii?Q?R9JwkRVCbss/vuxk5jjanPqCtg35h8ylIQOuY35V7KDwe5vnbcu8hcQzOH59?=
 =?us-ascii?Q?LYa4wkAgK1uIwb5y8jUZ9mUBZWyCHNClcY8bRPWbONRu3vGgStKLxLHj9OfE?=
 =?us-ascii?Q?0SOkTRodip8rmMs9ZdoOKdrRiNNNM4NCYH8QLy+P5Msx51DEZaTZehsOA6tn?=
 =?us-ascii?Q?7/ZzuVV2OjK78V/evMCEWCbeq4YLcoZmqXzOPfoD60/cCMdaI/V9ypnRBYH6?=
 =?us-ascii?Q?+UGZ2ZlMCqXp2DxoQBXfAqi/l9KtzLNQClLfPfewCHu4FFIkh7ycez7bBJLe?=
 =?us-ascii?Q?uGIs4znDWJc5xrJN0LLMXlFc0l/RC9cmzgDqOphrQNzUAnuRQvvteAbrdimz?=
 =?us-ascii?Q?r7WFqBO9Ic0adJvgsr5gCDtLqaa97rCIUs0D168I4HCIem+pkzH0wFpIDrVV?=
 =?us-ascii?Q?sm/uiZd5yZEf5uMNrOH3psNQpkA1vt3fgwz2LVilc/NYaEpCogGgI0W8ne+T?=
 =?us-ascii?Q?pSTqlB12xh593mMyhdserLI7ihqDlSgOu0yzoFqI9JNAvhJyQZrxZcNoGSAB?=
 =?us-ascii?Q?8RDhdAkOvXXTTUXwYlMmXNv8lD2mExrMcvq3yMQvR01TeNwMuLTOJnPNYV9q?=
 =?us-ascii?Q?mGs2y2eIr1p0AnD6RFgilXMRAUEKMvorqDqsFmrktucFOwYloih+6ncqPgiw?=
 =?us-ascii?Q?6dX9U4Z9CvFlThzkJVs2RM3WrXL958KWdd79zmPKTxpWomb13ADq1sonTpRm?=
 =?us-ascii?Q?0wZ/m+b2sPAlqxOUbZQ+2JsyJWtuU4VxyIjpaI6v6jkSmzwqgd7qaN0kFb7N?=
 =?us-ascii?Q?0a971BPPq9hCaIx8+hNMbf0FaiggBOurInNIpBPjPwdzg9Gdb1Lr0TMfVQvl?=
 =?us-ascii?Q?oQIjRs3mxWa0t/kpHmw+mphL7g7C6Dzi8yto4WFzJAGiKXYs2uw1l1YMpG8+?=
 =?us-ascii?Q?JnpT9jgNLGspcsP2EbWKbnSj+/Bn943N09W+Xjx52p9X9lJKLs7yPo/H4/yJ?=
 =?us-ascii?Q?bmkYaJXV5Djwy16HdAOuRafDQaabmZLiWO4EuXNKrR9EhvCB2dYiIVxBfXLh?=
 =?us-ascii?Q?rCrFT9gOjyz6uwYCHR3LsC5Q/CJCuKDVOoKp6cW76D0LJlZLn2zqc+kvE0RN?=
 =?us-ascii?Q?3d8irjqg15bZ78um9OrBcaS5gV6ZVMoZXl6z6DOP7Xjsx/KSp7F/FoDszvUU?=
 =?us-ascii?Q?dle1MPg93SjO44pmjtamovqWtEhYWuexpF3638C7SPRUWHbmMg5QuWj0ndCG?=
 =?us-ascii?Q?5zOCd3nczaaq7QKOndg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05abb2c9-408a-43ab-23c4-08dc129d1047
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 12:01:37.1901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dI5k4LYx7zc0ReiSpcISWu1j52fpyG9eCO2M3JXLTS7Mi1gU0reSO8CQrGaFp6moSd4b4EHW1AQ6YHYal1TNoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765


> From: Li,Rongqing <lirongqing@baidu.com>
> Sent: Thursday, January 11, 2024 5:28 PM
>=20
>=20
> > -----Original Message-----
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Thursday, January 11, 2024 7:55 PM
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
> > > Sent: Thursday, January 11, 2024 5:18 PM
> > >
> > >
> > > > -----Original Message-----
> > > > From: Parav Pandit <parav@nvidia.com>
> > > > Sent: Thursday, January 11, 2024 6:18 PM
> > > > To: Li,Rongqing <lirongqing@baidu.com>; mst@redhat.com;
> > > > jasowang@redhat.com; xuanzhuo@linux.alibaba.com;
> > > > virtualization@lists.linux.dev
> > > > Cc: songyang23 <songyang23@baidu.com>; liubokai
> > > <liubokai@baidu.com>;
> > > > Song,Zhan <songzhan@baidu.com>
> > > > Subject: RE: [RFC] Revert "virtio_pci: Support surprise removal of
> > > > virtio pci
> > > >
> > > >
> > > > > From: Li,Rongqing <lirongqing@baidu.com>
> > > > > Sent: Thursday, January 11, 2024 2:45 PM
> > > > >
> > > > > Revert "virtio_pci: Support surprise removal of virtio pci device=
"
> > > > >
> > > > > This reverts commit 43bb40c5b92659966bdf4bfe584fde0a3575a049.
> > > > >
> > > > > Marking the device as broken will cause the uncompleted IO
> > > > > request on virtio-blk since virtblk_done will not continue when
> > > > > it find the broken virtqueu at last it will cause the failure of
> > > > > removal of virtio-blk device because of uncompleted IO request
> > > > >
> > > > > The correct fix for the issue that commit 43bb40c5b9 ("virtio_pci=
:
> > > > > Support surprise removal of virtio pci device") tried to fix is
> > > > > that virtio backend always complete the IO request as soon as
> > > > > possible
> > > > >
> > > > This can never be guaranteed by a device and by pci spec given it
> > > > is surprise removal by definition.
> > > >
> > > > For Linux virtio blk is not the only block device which has surpris=
ed
> removal.
> > > > Nvme blk driver has supported surprise removal for several years no=
w.
> > > > I am sure nbd and others would have too given its network.
> > > >
> > > > I am not familiar with the blk driver stack.
> > > > So please explore with blk community of how to complete an
> > > > aborted/never completed io which never completed by the device.
> > > > Since the blk driver knows exactly that the device is removed, it
> > > > can 100% complete the io to upper layer with the error in determini=
stic
> way.
> > > >
> > >
> > >
> > > Without the commit 43bb40c5b92("virtio_pci: Support surprise removal
> > > of virtio pci device"), My virtio-blk device can be removed
> > > successfully, with this commit, and if we use fio to send io
> > > requests the virtio-blk, The removal always failed.
> > >
> > How can it complete when the device is not going complete the io ever?
> >
>=20
> Now this issue is that the virtio backend (device) has completed the io r=
equest,
> but virtio-blk Can not get the completed io request, since the virtqueue =
is
> marked as broken.
Your test was just a timing luck when the io was completed, it is not alway=
s the case.
Hence, vblk driver should flush all the pending requests with error to uppe=
r layers for which the ios have not yet processed after it was broken becau=
se when surprise removal request was received from that point onwards there=
 is no communication with device.

>=20
> -Li
>=20
> > >
> > > Once virt queue is marked as broken, io request can not be finished
> > > since lots of virtio functions will check If the vq is broken, if
> > > broken, exit directly, like virtqueue_get_buf_ctx_packed
> > >
> > > static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > >                       unsigned int *len,
> > >                       void **ctx)
> > > {
> > >     struct vring_virtqueue *vq =3D to_vvq(_vq);
> > >     u16 last_used, id, last_used_idx;
> > >     bool used_wrap_counter;
> > >     void *ret;
> > >
> > >     START_USE(vq);
> > >
> > >     if (unlikely(vq->broken)) {
> > >         END_USE(vq);
> > >         return NULL;
> > >     }
> > >
> > > Nvme is different from virtio, it can ensure that all requests are
> > > flushed to completion, like below patch:
> > >
> > Who is "it" in your above comment? Is it Driver or device?
> >
> > In below commit who (driver/device) flushes the completions?
> > If it is device, then it is not surprise removal, right?
> >
> > > commit 1d39e6928cbd0eb737c51545210b5186d5551ba1
> > > Author: Keith Busch <keith.busch@intel.com>
> > > Date:   Wed Jun 6 08:13:08 2018 -0600
> > >
> > >     nvme-pci: unquiesce dead controller queues
> > >
> > >     This patch ensures the nvme namsepace request queues are not
> > quiesced
> > >     on a surprise removal. It's possible the queues were previously k=
illed
> > >     in a failed reset, so the queues need to be unquiesced to ensure =
all
> > >     requests are flushed to completion.
> > >
> > >     Signed-off-by: Keith Busch <keith.busch@intel.com>
> > >     Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > >     Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> > >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >
> > >
> > > -Li

