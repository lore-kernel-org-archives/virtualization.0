Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB712E4C
	for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1ojq4ws"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alSknA7pLbtDqjhau2bhkd+IZXKSXXI8VajgYaZ+weNsgPqtRB4IJZeuOv69NI1RXNBS3blgw8w7PSU3LWo/B6kLs0LB4L0ZAakr8G8l3DYwiayP+qk5loz44FPgywz72Q5TKKpUH+OAjKyoXFDmh3kEICO3Vd8SfGZN8aNdGIX+KRLqU1aSz6z0wmRs+XpmjYOIdVCeW6zAodXFWEJIqLcSqksYUEZt0MqROcyXTuY8dORAYRXQ2ftqc610xugmFeNXuixzB3/upBDxekNhA2sIJENGLU5863ap8vGN7kijWtG75bIXLV2ilk4mifgz92iJGYGVghdlrWhfMPBiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfqOt+Xm4QXVk2IMWk/l6ImnEQStumYBFv97HdQYSJk=;
 b=QGgZKfjHpsMz6xyNfMYM3KeNmZoYXRrj/8RKNiydJNxZzcUeG/D2mh3xjfmJlU7Q1nXpOBai05O9FHEISjKzRJ7uqnU1yGbPayxGhc6GbYpIE1/wq49hHkXivXgvavQEBsoDykWf8RUenHlHDfVCwyneThxOMItNVn211g6w1ECydZtyAg1NQjOUL2R/TXy4DLrxFx4z5fx8OPJvF/BVlpCUzz4InCJ/X9hsE1zO94FlJUw2/jepmcl1lVOwXmd8mda4uVMH7tQQaqW/tk6t8DhvfQRoIaXjUDds6vJVHipiiz14B+YjulCprpS9HIRu/PH9ymzNFBOrQOnA1inWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfqOt+Xm4QXVk2IMWk/l6ImnEQStumYBFv97HdQYSJk=;
 b=m1ojq4wsDZErFPGUBtSMdsCbgb/b5Iri+567aoqd5SGIw5gg2G46UQU++Dof1aTeMa4anmHUCWsN7HVFSost4MI8oYsjuZY9vaceQ2QXkapXmGYXr5ct4SOd/Wgw/LCm1IuQJSmXFjgppSC7eO8bR5uOP0Ron0m0bSJFEFPnPll/A8S+6pBGlce4qFCB5mIvjaJidogSvUzSzeMSN/n/a5TPBp0przr5uyLQvZ7qIzHgVWRtheBO5zTYgDM4z96ekUX9UJKbgX3g3wXTYg9TqPUbPjFRW7bCdd/hsb60TWd+O5yCfti9l/cSAXcfkdVKAGd/uiyR6xhXDYUBAE3mWA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 10:18:17 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5615:d69b:3ff7:1f7b%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 10:18:16 +0000
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
Thread-Index: AdpEbQ0W9HGTHF1qSr6UzsNmXQK48wACc8Lw
Date: Thu, 11 Jan 2024 10:18:16 +0000
Message-ID:
 <PH0PR12MB54813F1133C29AC8FF0097E6DC682@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
In-Reply-To: <c45dd68698cd47238c55fb73ca9b4741@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7180:EE_
x-ms-office365-filtering-correlation-id: 3a31c74b-a552-4fb4-f873-08dc128ea06b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cZ0xE4nk+uvJUlccY88pgYqTZhwhVwzi0WGhOdkjWo2zHvlBtEo348H1sGaaK+o7tyEqlhgmYbHwoEb+Pjui89CwUHXVAGudZ0hiqC1LBSKSzjAN3wN7qodyxjh1V5q/dTHpbDUHOo8zheDocaBPakCGnIKYc7moc6daKUhN7OKpbCJtf+/HG1vt48zR/YuRdbA/9eOIa4Me5vaqkZeNfkMm57VabM4LJbo/EBgKhC5sbUw4EmjDA2xFB0G6ze07xTiS+2PmqAEMANMy9dIoFWfCW8/PYnOFqS82qMMS1ufSxJcu/edG9/SaEJlFIUEipQYlAPodPMRtg3bWGrdqfvQmUd278gikl4evChBk3l+nKZkjTf4MeN9Pg/t4tgzf+7mWU6JoJjO+fWMCJr686EE2Ewi7BVpM7YI8zGRmBLpj0SkA7GAyk8u71nC2kgRDDro+Ld7Ro3/7HltYVwfypOnTiDu2rmPNCpWnXpCpxU20SknHND27N+J77wTQmBn+rbh+P8km4FtD56MRj18MHrSuw3xE+451X8YpM40irO3tz3rxNlMzLqQLoXabXsDGRhIVep4s+L3tjDoj+85auGJ20xX8dlcS80HNeo1BcpJsjpvRgGL8Vmd2P/NW80FI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(41300700001)(33656002)(86362001)(110136005)(38070700009)(2906002)(38100700002)(122000001)(71200400001)(83380400001)(478600001)(66446008)(26005)(7696005)(6506007)(9686003)(52536014)(316002)(66946007)(54906003)(66476007)(76116006)(66556008)(5660300002)(64756008)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IDV1inRjXNG5y7A8Jt+Oq4a1Rr+8NRCyBNZIgafDZTVcH4EZwMLpUYlMJpit?=
 =?us-ascii?Q?TIBIcaE4RBbWzpExGZ+h+gFdOkaXG/+RNlg1gHlKnp6X/lnQOlDh+slWpSXs?=
 =?us-ascii?Q?D0/scDjlMfE4LS6lv/f/uynDOe5+8gBqBKRj7EaoW0aVeJX2ssPdI/lCEFp7?=
 =?us-ascii?Q?M9pw+FY1RVcqZUEwqUkz6/N0gGvgvLhWphb/NF3ozg7V08QwnB9ZDr7hUaGT?=
 =?us-ascii?Q?qsAPSeKQ2oOM751YZxF8uce9FxbhHUJhSyVgWgdlHyLPkPRKAoFqJl626LK2?=
 =?us-ascii?Q?H+D1wGuMQux0k16MPB4RyEF72b3Rr5M+oTnRYhDUJzbMOIYBMTY4envP/gz0?=
 =?us-ascii?Q?3ecWYbumtxKis2P4F6NrVJrW5uAs6wYiP3DTdW56JDqOBZhvcpoluH+kCsLC?=
 =?us-ascii?Q?aJjI/dRIV9HyLMKJf1TN76E4NzeVwsu94RjlCdR2Eo86JWDXwWs45SuI4BGv?=
 =?us-ascii?Q?HEqY3vjF/7GZA8HnmK4cDcr8jfMymvtK6WFs7IBj8ihFh8Cuu+oBK3EdQ9ZG?=
 =?us-ascii?Q?niwNAEtoMzGkm22Qexapv/M7ZaoIpz5bGGeJmqFUkzrcra+u+7rrJcI4vtIJ?=
 =?us-ascii?Q?FUNy/Nwmd+BuoT2KOkNgrUCyPRJPDg8GN5JrR1Gq6ZH+u84R+N4M1VymOdud?=
 =?us-ascii?Q?ZdV9Hbj4CovUkuMOfaA8xenekeIph+mBOswjHOTYrCG01YekUPZLRFN/W/bY?=
 =?us-ascii?Q?CCQnrJBAM+LoOzmh5pQZLhWIxu462/hPX9sL3b6aA+K9n8ZyqTbTFpmjST/x?=
 =?us-ascii?Q?ffdOi7VwwDsneWzZNcX3Why2Jtd+8qmRCnMVZ+GbnnbNHaU8IPhhff+gTP1F?=
 =?us-ascii?Q?njtuSGi3rUtO7KemIMfYktc4cCcgb+KDn9xjWHMVlNqlURhMQJR1BZYC80vQ?=
 =?us-ascii?Q?zJ+petsUSXyg6oWv5GsOb11SWsY5TeNO2wAOe0Hbo540faGG/Q/Enr81p2kD?=
 =?us-ascii?Q?1SnBjc6Z0fRHgYyzHkft+khETGEQAu7h8bQpIli8Ucm89biyqLHN0Jo4tme3?=
 =?us-ascii?Q?jXrTdmT/KcWTpEqvTRyLN6JIu8uvn8Xb3YLgS7k2v7h2dQzptnpBin8mj0SB?=
 =?us-ascii?Q?cUBs/IfZVZ/joyPujwHKhBfPK3zLJvmJM+Us9yq4LoR+3deogA0HmtoKre7K?=
 =?us-ascii?Q?IvzlusX4o+EWnpVWD+kxvMvORU/ppYw8LjxLeL7AB+D08Jmg+gz+VMH2IVqF?=
 =?us-ascii?Q?tTMpJSQPvqrX3RUE5LR81p/ZJJ31Agsg9o3+FqITisLh2bE9Y8a+UMXyg3jW?=
 =?us-ascii?Q?Oow66ELkfFUkvPg8snxOZaAPZKxstVXxZJQbNm2SJyYbskkkCTy/Qk+a8fRU?=
 =?us-ascii?Q?pIGc4GRL7LAxIOv6QUSXAvkhI7oaaIMoMhuUJ5BX8fwA/3SG3WXkmbB5ypi/?=
 =?us-ascii?Q?4pd4Y72cf/+vrRNEW12WbpB7adGpyaa2ZzhuzlRHhGcdZe5VHZ1HIlo72oqj?=
 =?us-ascii?Q?P6zvit5462mkwQ7Cj2mp5Pg8W2RlR/vBwdIFnirrku4poi9/jwU5H2O4nWIf?=
 =?us-ascii?Q?RT6Sx0PJ0V4TUkl7dj4OS2mrkm2slq4v6VhCn7mbYDR8mZCq7DjE8yTvJ0+z?=
 =?us-ascii?Q?Y6ohGZbLa5orQnnKH1M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a31c74b-a552-4fb4-f873-08dc128ea06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 10:18:16.5831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XkkB/jDlVgALx4RKy9lSPTwq/pg9ANHeK6+TGlwgjxwGbLNH/YJrkO6RYSCZKBnhuKjt1BK1QDHFz7d7nQv8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180


> From: Li,Rongqing <lirongqing@baidu.com>
> Sent: Thursday, January 11, 2024 2:45 PM
>=20
> Revert "virtio_pci: Support surprise removal of virtio pci device"
>=20
> This reverts commit 43bb40c5b92659966bdf4bfe584fde0a3575a049.
>=20
> Marking the device as broken will cause the uncompleted IO request on
> virtio-blk since virtblk_done will not continue when it find the broken
> virtqueu at last it will cause the failure of removal of virtio-blk devic=
e because
> of uncompleted IO request
>=20
> The correct fix for the issue that commit 43bb40c5b9 ("virtio_pci:
> Support surprise removal of virtio pci device") tried to fix is that virt=
io
> backend always complete the IO request as soon as possible
>
This can never be guaranteed by a device and by pci spec given it is surpri=
se removal by definition.

For Linux virtio blk is not the only block device which has surprised remov=
al.
Nvme blk driver has supported surprise removal for several years now.
I am sure nbd and others would have too given its network.

I am not familiar with the blk driver stack.
So please explore with blk community of how to complete an aborted/never co=
mpleted io which never completed by the device.
Since the blk driver knows exactly that the device is removed, it can 100% =
complete the io to upper layer with the error in deterministic way.
=20
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_pci_common.c
> b/drivers/virtio/virtio_pci_common.c
> index 7a55939..d60fe99 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -584,13 +584,6 @@ static void virtio_pci_remove(struct pci_dev
> *pci_dev)
>         struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
>         struct device *dev =3D get_device(&vp_dev->vdev.dev);
>=20
> -       /*
> -        * Device is marked broken on surprise removal so that virtio upp=
er
> -        * layers can abort any ongoing operation.
> -        */
> -       if (!pci_device_is_present(pci_dev))
> -               virtio_break_device(&vp_dev->vdev);
> -
>         pci_disable_sriov(pci_dev);
>=20
>         unregister_virtio_device(&vp_dev->vdev);
> --
> 2.9.4
