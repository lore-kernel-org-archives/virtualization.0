Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B226C433F5
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 10:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29AB6400D1;
	Wed,  1 Dec 2021 10:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cqX4HyYVtwBO; Wed,  1 Dec 2021 10:09:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 73BE14028C;
	Wed,  1 Dec 2021 10:09:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21EC0C0012;
	Wed,  1 Dec 2021 10:09:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB601C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 10:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEBC940574
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 10:09:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oFE-gpx-WdLn
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 10:09:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A0B040229
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 10:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4PX16/Kiu4LC8WMqUxQJIlfaBXqRPrIuXAM9h0qTTop6FaxlyyAraxBkuPC+1g/DG7/72P2YZ1p/x2QWGVHOslpDRz3kno5aRncGbJsnbzMuak4jWklp5NwkggnBJUovZB/t0lNbSsFkOIc2pyFEySX9znvkaT/xyAeGIZyesT77UaE3CosaA6JmQyWzeVPCrfca5sjFs9jrOkqrV191cQG9HTu8CQ25qQ+Kkd0wFev+Fywr9FW7FPDL8dZGJqbvXXjPu8u45khSN07dGTePnxDBpEGCcWJ/C5m45PSskrjckIX6MVTqkZ9E2UruMxmVxf2RepDab4M0s2vx249fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuolDJvIHMi42j6pMLUsAF3YxJdfB0k03toDuUX0hXQ=;
 b=Tp0SArd2jXq6g/Lb4W+FEtXERxf+LUiAzuaAnQMNYhgIW7vvLDQi4D3uFadC+GPFKJbepc1bLdeyvRUVcnEdDne9qEP5NqNLzy8fUYqgcpvALJKN2iHQMvf8Xfoxt9f8ZrWvb4DlXa04PBs6q13jsTEKVXxiPYnhCVg0bnSNUE5G7aEFbkJt7gcH8UYOXiZvsu2LmPVTgzP4JT1xMzDyeUj1LiNbHp1ZIpT8Iqle9hg05uhleeMvRrg9PqRFLpvVbfHNyB2dU+FBpV1gh/Fc3zsPU2xUyScvXNxZcPZuQ+HKyFcLx9aJ64JvWWmF93fXfvM2SZIdFEF83ZRrPNbEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuolDJvIHMi42j6pMLUsAF3YxJdfB0k03toDuUX0hXQ=;
 b=kh1ag801X5IcygN1/diNIVugYbEC8swoBcAkPwotPEJmsm8tVazn9bDCaQXE13SfwLVWROtX3Ewg0p51rhTq2J3MQ+e2O2Ef72pSnMoOa1+DfBcAAMn7K8gxyRkobKwwraTgjSXd78UoPLp39m/+AquJ6WswOhq0r8WZeSLyqflyfFreHTArzBTkEQg5U4JQOtOgyRqxzpSjuNjCudHg+fcJwgMzeQM8/0ntFsNfsWbhWD0BRkwgGGASC3iJghlCxiTxsniyZ/rTmcTVa9syHatyz/LaABJhBBZjKhsENTtYER83aZIMuRkyfak6m2bNxNjSvkPvUb90TtxdRogsrg==
Received: from DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) by
 DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20; Wed, 1 Dec 2021 10:09:17 +0000
Received: from DM8PR12MB5480.namprd12.prod.outlook.com
 ([fe80::fdc5:44d:885a:6c61]) by DM8PR12MB5480.namprd12.prod.outlook.com
 ([fe80::fdc5:44d:885a:6c61%9]) with mapi id 15.20.4734.023; Wed, 1 Dec 2021
 10:09:17 +0000
To: Eli Cohen <elic@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>
Subject: RE: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
Thread-Topic: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
Thread-Index: AQHX5c+B2VmddtY5YU+cieG7gRIwFawc2KGAgACRBoCAAADu8A==
Date: Wed, 1 Dec 2021 10:09:17 +0000
Message-ID: <DM8PR12MB54808D3B8AE095A6EF145E36DC689@DM8PR12MB5480.namprd12.prod.outlook.com>
References: <20211130094838.15489-1-elic@nvidia.com>
 <20211130094838.15489-2-elic@nvidia.com>
 <ab454062-da69-a72e-1953-716257bb464c@oracle.com>
 <20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1176c5f-d6d0-478b-ddd2-08d9b4b2a2a5
x-ms-traffictypediagnostic: DM8PR12MB5416:
x-microsoft-antispam-prvs: <DM8PR12MB5416678745D5B0E2213CAF12DC689@DM8PR12MB5416.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IN9TmIdUFG4Rmyr34dIL7ZTMsp4tzH7Riuml1QEcN8ovSGnzO1Ye/dIAB5uDk/B/DssBmV/Kjak/Y80TbFB/zmcEU5c+qMXk2zQSG3ve9Jpgs6RouiZc+Hfxz7BwGwKQyJQPXn9sbPJXlJDraDL6sXGy74o9iauAnX+HDHsYSpF3ZtBS8efYB6OdmaiUTPxp2DLECdWi+Idm/FgCS6lM0E+W7XIzoL3PYocIXpnzIGptvX2b2I9Sx6mIy2bO9t8NeYdBthr+qH4VN6UJRxv3kiEQYJrFYtg86eWyEV4LKndC7fk7iBKgFj4TfVV8sGp8Zrkx2oJwpFCJ9Cv2+oG3eBxj0nEu7Tnv0htLAsuze7/N2SU974/me7I5Go6q39db4W21LWNREMtlKD9TYlUclBxMhkP2CjuGAOic3RjxsJTlp/RnO+JntpclUVVGzH3zccLlzHsjhux+Zj0viWs8Js7XCY685oFAQFVfLU5dnA6xKrtMKXoteyNPDIf2sRzO6oxHQvosxxZw/iInDj9M+qTzGuhQ93IXCG6AZ0kkjZ+0rk8VbM27KEQa1pgoo8v4tBE2un3iD929nWZMyJfeJeUlE2l0MpeTX2JKGLNC4ogsvS6u55Dof6hke5JY7pR/GXrE2yAvHQKoTa2CiCB6RN9NAZBDdBBTMtwW2+OdOugmjo0HgopmieG9XUOuvgYcyfxyKW8DlB7AVQossORm9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5480.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(6506007)(122000001)(8676002)(186003)(52536014)(54906003)(53546011)(316002)(508600001)(64756008)(66446008)(8936002)(66476007)(9686003)(2906002)(5660300002)(33656002)(38070700005)(83380400001)(55016003)(66946007)(38100700002)(4326008)(7696005)(26005)(86362001)(66556008)(110136005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Q9IpZuS7FmPggRt63bjIHpPB6bD9t2WCIcFg3TnymgePUBz6CaWI/n1dtAf?=
 =?us-ascii?Q?hMzaCSpLuzY8mY19IYeGe3FXfOGhNhEVIT2NYE+3URgza8bfQInxwdXkbbgp?=
 =?us-ascii?Q?oEcNcbcYMW9QTGiLLRSuFSfv8mEwQAJtNcezRVqsWBQkBgGcdT14zh46j+4K?=
 =?us-ascii?Q?iDhu1ugk++h5VJyCuJSNVwGaA02ju179Fb1cJcfEnI4zhTkvx+8NCpmBLxWL?=
 =?us-ascii?Q?A+KlAD3N27ypuHgz5b7FFG8Trgm684VKM9Q9ZG/wHQmxucRy+ST63q8UdqgP?=
 =?us-ascii?Q?KxQt+jh/gBmO8OBfhwGjAfANym3jVOvwkwUxnjV9uOvQKoSwzyopdwNg13Dt?=
 =?us-ascii?Q?Gu0WxdL1oRh6t0a4sqldqWStHg2pp478yZmNYoaTFnkDX0lfE7gAYN2mhUKu?=
 =?us-ascii?Q?z2s/yhNH9anboxriU3g+eEEzZOJ22CEHOTc53cWfsEb1VA4jgWZ9Ueo/D2HU?=
 =?us-ascii?Q?EQwFfRb9xkAVLLgQUD6A8m0kQGOQdJ/yyqQVTgXyrQ/qT/ZTIxZwRfwSdOST?=
 =?us-ascii?Q?UopcG2Qp3VTPEeVyI0OFq/re/yXuxT0nJfq89kUTuqMGfEgQ8Q/BWWZEBx5s?=
 =?us-ascii?Q?gO/6EC/EzvZUUdDGeBah8jMpruX8WemiewW7X5xP5f2FpFrJoKGyrWH8HTPE?=
 =?us-ascii?Q?WwSYV9b9ORaBjnzabT6rBFbf4mXsVxho2tDZVBPXReMMjPGys2qUo3/0xlRa?=
 =?us-ascii?Q?JeEw+KzrdvcY6HCedQglytQp/3CEH7XJwXfyDNyBTg7FMCcpiuE5wtMQllYx?=
 =?us-ascii?Q?iQ+0VDaXtf4/5hmfSdVO8kIq23/MjpjylELfQ02SKpACKc2H9/t7bYtGR17k?=
 =?us-ascii?Q?4v0RAvSPvmnIfjPjvMtBs0/dQgeENDxrql34+rwfcHSPQhx5z3IZ8J9CYNp0?=
 =?us-ascii?Q?EkTrE/c//nPf3CsQoSI4Eysr2jvWYS8+l4A1LfQYANbW5AHR015yNjG6ZkFV?=
 =?us-ascii?Q?qWltWh6NEG7/icYpSO2Oq3MjZcP9m+X0bxsPgUq82bUvKMShiv06j/Qoopxu?=
 =?us-ascii?Q?HKzxbqAzFumQ0Ayjj/NbnpbmUgKbCB88MmMR8IAeyiilv9IhD9oBvuv/PXQs?=
 =?us-ascii?Q?ZRKPuFoYyPfu7LA9F/M5QvhakNxDt0cZKHVhSvQvR2hmxYYkoeHuhBOP9Jf+?=
 =?us-ascii?Q?MLe/SiIXhtJ4uqpNh/1i3O5HqqshQIF+4hCA71LvI4kysc82I//vjVARwuXP?=
 =?us-ascii?Q?Y9z3AUYjEYxRTofm65sC2n9BqvES0GHaThdgqq8Ex7vnrPPwXbEupCHpLvNJ?=
 =?us-ascii?Q?ijwsJ7H+rp0Om34vJBSUhRFUk+2/RbI2faSzis8BHMNd3KZkfVVt63bLNhLF?=
 =?us-ascii?Q?JTuZkr4SUFiLmLvKA2bVVkBftdW4cRhYN8dgCqqoki+bnqlnl8Mif0oz+d9H?=
 =?us-ascii?Q?vNMyg0P7SqMe9Uj3c74DSKRSp5hT/BkQ2uWC+2XXLKALFQaBt5Uu9pAM8+LL?=
 =?us-ascii?Q?lHCFfSviD7zw5NNneSUDxJDiHhL0SESq7EXIWj9haJWgHd/F8f+7JxTIvFlj?=
 =?us-ascii?Q?moqTkcpCuYsQdhIpNEtriwmcgObtnyJpcghPHaqt27lCMEOS9r3+WbZc+fSf?=
 =?us-ascii?Q?DHBaccxWSqfF3I1jo0nwQF3lah7cxUOKD9pk6HWSWZEONnl2kxni2FJ/NGza?=
 =?us-ascii?Q?8VrOqaHizOJsci10GZpccww=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1176c5f-d6d0-478b-ddd2-08d9b4b2a2a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 10:09:17.4030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/XUm/E3kb7n3i5CGDxUN4TAZIiW214n81YnipvQ/JT+8+pjHjQArFIQRvpHj1X/a9C4auZEM5SJROOtXciIqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Eli Cohen <elic@nvidia.com>
> Sent: Wednesday, December 1, 2021 3:33 PM
> 
> On Tue, Nov 30, 2021 at 05:24:03PM -0800, Si-Wei Liu wrote:
> >
> >
> > On 11/30/2021 1:48 AM, Eli Cohen wrote:
> > > Allow to configure the max virtqueues for a device.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >   drivers/vdpa/vdpa.c  | 16 +++++++++++++++-
> > >   include/linux/vdpa.h |  1 +
> > >   2 files changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > > 7332a74a4b00..e185ec2ee851 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -480,7 +480,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff
> *msg, struct netlink_callback *cb)
> > >   }
> > >   #define VDPA_DEV_NET_ATTRS_MASK ((1 <<
> VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> > > -				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> > > +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> > > +				 (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> > It seems VDPA_ATTR_DEV_MAX_VQS (u32) is what you want (# of data
> > virtqueues instead of # of data virtqueue pairs)? Not sure what's
> > possible use of VDPA_ATTR_DEV_NET_CFG_MAX_VQP, was it to
> dump/display
> > the config space max_virtqueue_pairs value (u16, 1-32768) for
> > virtio-net? Why there's such quasi-duplicate attribute introduced in the first
> place?
> >
> 
> VDPA_ATTR_DEV_MAX_VQS currently returns vdev->nvqs which equals
> whatever passed to _vdpa_register_device(). The latter depends on the value
> provided by (struct vdpa_dev_set_config).max_virtqueues. 
> 
Max VQs configuration should reuse VDPA_ATTR_DEV_MAX_VQS.
it indicates what is the max vqs a given vdpa device is using. Until now it was driver's choice, now its users choice if provided.
So no need for additional attribute.

> Maybe we should add attributes to add aditional virtqueues like control
> virtqueue and their index. They could be returned by
> vdpa_dev_net_config_fill().
Yes. 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
