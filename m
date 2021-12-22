Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6149C433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 07:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5880A82C8F;
	Wed, 22 Dec 2021 07:03:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x501J-0od6KH; Wed, 22 Dec 2021 07:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0FFA682443;
	Wed, 22 Dec 2021 07:03:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED53FC001E;
	Wed, 22 Dec 2021 07:03:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADD5DC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB6634156C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iICP6yTgatWm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:03:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B432241578
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFgOLYyBsL8K8Ax2PBV8o+Wav0SssS03NICfUSygzEJ9wTxpuySfrLlZFpRS+bkrcNGOX5tbig5z/n4F5Y1P5ZhSuE7k7We77JTGH87wm2oIY6L1CncIh5Dxz5r9yRkYTMp7JgIan0MPP0J+Y5Jkjy8uR+Q0fAEW3MWYDuCVBNu2MODh08mCxkZq75fB98gPjc41Pu8KrOa/scPUC2Hvq+6jLSjGPhoBB8YWb434X7LxwU5XQ2MTfQqqTG9ZqC/jaz/Ue8Ttn6u8iiPlEcr338kdfqIwqqsWOvAw7LpYRZjybPjXfC8Ni8iQTL/yzsxs35NUSVqefayC3+IpdYVRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKb90aYQyZ/gfXr/f7AjWaYF0KGcUOe+9vIWnSVBKEI=;
 b=BUs6MzKOlqjhkpDt0PhRniDh6TfFCRruRIPC/6vE11sy6f1ZFnqxSceZLt2QUfqM34FURdmCsx89Bh8RKyF/iZzzhqALvCnZnMiNiYLn8c/te3d1zfplMokKBjMZh4vmebHt2Jkbqz8d3bZrCfp9nOGIMLbFxpeUOMyw+fR6Vn3aiRAPIMghYRu+XJX8sJ1ze+HMtiAP2AYRmCOabOGDWTs+0Q51YRKS7GkCpgC4gtuVObJJRN22JRmNhD9gFY46z18Uw/cJM3tvdacwB24kwYIruz+Q3bqHNFxFUt3kVRSctVGKDcuFu/An8NNqt8wfA/zYX6w2o3ZwI2uESSxgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKb90aYQyZ/gfXr/f7AjWaYF0KGcUOe+9vIWnSVBKEI=;
 b=h1bDsJUpg8oWAiTgU1kqnDE7ybL8YS4sw9GLaeXDtl9cjNizVlIWO5g8tmlNB76aPAEMyL5EgX6VgrF1ur4ngrsI+a/YNF79wk3hqDwt8lf8/qnVrVwkaN9/q+X7SL5aw5TuLHx6lA3TL8t97UqTnNDcALg5gGleFLNQtyYUojaHSsEjO2FH/nZl3z4NcxI0lBmPRSJfE64zi/Ggve2lffHZ1JMy4kbLzRJPJp6RpVxc/FOy4GFTpNWY5KXkQA9pj/MpyekiWDxcZ6SRKi38OwVeIpCXMFJzJ0lu4YqOyfDictkMBS7QC+o7lB15KSD0ora54CtzLZFqPeVMkvhvHQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Wed, 22 Dec
 2021 07:03:37 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1864:e95:83e:588c]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1864:e95:83e:588c%7]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 07:03:37 +0000
To: Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Thread-Topic: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Thread-Index: AQHX9o8VseAxGPicCkaXTRx3P5owuKw9wk8AgAAygKCAAB2kAIAAA23A
Date: Wed, 22 Dec 2021 07:03:37 +0000
Message-ID: <PH0PR12MB5481C33A91EAE3AADABA73E8DC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-11-elic@nvidia.com>
 <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
 <PH0PR12MB54816A7E1D045997B797961BDC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222064728.GE210450@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211222064728.GE210450@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b68d974a-103f-49d9-7aca-08d9c5192d44
x-ms-traffictypediagnostic: PH0PR12MB5483:EE_
x-microsoft-antispam-prvs: <PH0PR12MB54832343224F2C01C7E2B24CDC7D9@PH0PR12MB5483.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeHRZ2mJ+2iK2RH6pNqlVBvxl+aRUgLUKpr2Di3nOUPnMBQogFWRsVjYKOnEOAJ/AGzvRHI+19LOIR4HeUJheA2661lyIzYiJU/7JyZ3i/I7Dw+SVTaGQ4w5ArX7yH0bL/ZEfKO/dxeKv75w099ClKS/+evGD/Fk7sWQOaabfJ6ErKy5KweOWE0597jheHfvrj+6FAeWkh0FNMUeSk8X9qGEfMVJls71Ltm/unwZkMFVK6wYayIOJr6MOje3iA9gHdoQagNTP/rNqTiZSJNkQXupmh+d/57IeefLZDZu5nUecTB9HLNCO9w+xLrRPLL62vW8FxPyNvxj3AhStw3ddzAr1Wn3kbbDIX6npfeBnLVSpS+5LpxBIB5mDHoJDrzvZY2W2oiNT6MUUVY9FuQf+rqGncKA8OXyMnuNq25bo95BGP1HU+1Vy3SM8VJHJfUzxH69iOeGpRrJKTVp51PWDUc+oRljYUuvi0MHEI3d5Oi66eE63RuxqeFbCr7WhqHXUha8R6BZKgspD4tvSUfHdVuhsqx3nmJ/3FLuhyIZ+9LZBxkLluFIA2RUnM3CmdcoiKjBJNAYgRXyIMM0QEKYCsSv7UQ2GGI69Fi/B73lbn0Q2stuJohN/XPTw0cgmTY8xbvbj6WCipzgxfxwEBmgRDDzfwIXfldkUiEoxY0mPyVl9EpuhmjbhgTCGFrYFAR6m1pvbAaNMVM7dl3Hg0Q62Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(86362001)(7696005)(52536014)(6636002)(6862004)(8676002)(9686003)(54906003)(66476007)(4326008)(8936002)(38100700002)(55016003)(6506007)(122000001)(83380400001)(186003)(26005)(38070700005)(66446008)(5660300002)(33656002)(66946007)(64756008)(316002)(66556008)(508600001)(2906002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P3aWxQ+RtxRkDpW5aBt7S6THqcjdYA9BvRwok/36Z4536R/vYlqUiisO0xtH?=
 =?us-ascii?Q?uG+YWu8i461JzOnIgbHrcKMgzhsZNoLaSKl/io8HMupmxxqaWOxg8qKAsfzm?=
 =?us-ascii?Q?K6XcKsr5OfJYTy8jKgv7P1nioqIpx4fWHkG0YB3f+wuh+GCAXpyCfKfQGy9a?=
 =?us-ascii?Q?6/4vWaLjbnWZWkFyIO7+t1uW/p9FI/otR/b22+7iJcZatk3izyAZb9CoyZ1q?=
 =?us-ascii?Q?26LcHpdhtMuJnBVfbcocLUQGo5d675AUoDjxkLHUk0EFoe0kLur5+/t63Hww?=
 =?us-ascii?Q?JXBi40fsABbWTaF9A/w9rzgwkswVEmdByzlYzwaunFX+eXB0GANfYlxAcKvV?=
 =?us-ascii?Q?cmW5bHVUlEWrf+YifrCruYf83vjv1SqNqiScIrt+1EQWKW4NKZi9EYRxDegQ?=
 =?us-ascii?Q?zDo7ZI7VYBQ6JuDKvzSHTaNrwR0npSE458yqdKwy4AZdK2nJYvfiDoJBkoLo?=
 =?us-ascii?Q?01Rg3+4whdQRpdXq+hQEFanRjejJnM21rDeQ3GVjVXPzy0vQZrIUTN5yq7+P?=
 =?us-ascii?Q?L/rvasOSW6jCjTd+YYSZy4zbbzc4YccrVNq8YicoyScolRhCMLHt5f5Qvlvl?=
 =?us-ascii?Q?gZLFlHDufGUaM3tYJ+aejrf15eg/AWXQ9NeaCrkwT0y7SzlJLMQIOPHXk05y?=
 =?us-ascii?Q?Fp7asM1EkVy7E2/Lob1jjkvEQSZnepkvNhqsQIzIMGnoMIsz3DAUDTFs4dDn?=
 =?us-ascii?Q?t2u1m1/rvIBTf+cTLv5lpqODkb8AZfb4ZLZOtqrYN49cdnrbOeKJ5h5Ff7jT?=
 =?us-ascii?Q?vQoJFwsHyLE+nC5jINd3ZDameRwGH9uY0R1YpkEFT1j40LtYJBs/bX4LF97R?=
 =?us-ascii?Q?aaM17ST7MTiOQY470BPhy9Vkan7638Z/ZG8pYEKzAxarHcQNNWRX4+Pgx8z9?=
 =?us-ascii?Q?kxpxvc+BoFup1BYnDxOhdHV4OR+0Gaw2JNiEE0jNJrnIepjiqlN7E27rL1oB?=
 =?us-ascii?Q?3ZCqC7LApAkujOFp4KAVP8x+b2GnSzeVJfpSOf/0r0Kwnv4IVfaj9Kn7Ezcw?=
 =?us-ascii?Q?tHDggA+0JvJk/m/aeg1TDRY1dEgtWqAp7F8JTKBLhG5sbwgWHWmKh9WbdKyb?=
 =?us-ascii?Q?1L+QKkPuDRjnCfW8cTyxmm/rGbOW7vi00rT1QR95g1julWXIO8Jfgmwtkl5j?=
 =?us-ascii?Q?Gxj6CWBc1JM3eU0leTw47+9yg3xWn31y7cZRpNMaLr2+gbfglf/awp0zAgih?=
 =?us-ascii?Q?+hskkb0jABMWsbjRXhsl5jrBeKbJbv32oWs497Ftj+fdvIASYTr5G5bWN/gK?=
 =?us-ascii?Q?OQQeJRyKzb2zLL3XWHgl9XB4H44xchOMdDXcL2dYhjx8m7gD+Z/0irK5NCDS?=
 =?us-ascii?Q?jEuRJHIwUcIkk+W0F4Phj+0KMmd16HXWGaHQqHXHLrKGfyI1kQC3zAl6e4Ds?=
 =?us-ascii?Q?B/LbVZcZ1GP2I8RAeyKVw8EHq0GPiz5t7nUlbbeav6LUx5ryNWVJpMGYbWyp?=
 =?us-ascii?Q?2zak/T/WDXu0Zsabse50q71U+el18IWhC/bI6udFrGTtKO4hay97UcOEqGiI?=
 =?us-ascii?Q?kLsr9T0UnodDQqrCbD5HBIxVKY8oaG4YHnofMYCv9xMmKhxuUsBaW9kpvip1?=
 =?us-ascii?Q?evqD+3tg5dU+t2FIrwH/08uu/9Rcaxyh0YB1L8qUV3NIeuX91rsm5eLvahPz?=
 =?us-ascii?Q?mQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68d974a-103f-49d9-7aca-08d9c5192d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 07:03:37.3171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCjiykUCZowyJV+XndRyvSCfWUT3TfvCExHvzj7gi9RP6tJxS8YC/73QXz5sZr8DGHXS0UUQqJllPTpgQ2fRrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
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
> Sent: Wednesday, December 22, 2021 12:17 PM
> 
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -507,6 +507,9 @@ static int vdpa_mgmtdev_fill(const struct
> > > vdpa_mgmt_dev *mdev, struct sk_buff *m
> > > >   		err = -EMSGSIZE;
> > > >   		goto msg_err;
> > > >   	}
> > > > +	if (nla_put_u16(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
> > > > +			mdev->max_supported_vqs))
> > > It still needs a default value when the field is not explicitly
> > > filled in by the driver.
> > >
> > Unlikely. This can be optional field to help user decide device max limit.
> > When max_supported_vqs is set to zero. Vdpa should omit exposing it to user
> space.
> >
> 
> This is not about what you expose to userspace. It's about the number of VQs
> you want to create for a specific instance of vdpa.
This value on mgmtdev indicates that a given mgmt device supports creating a vdpa device who can have maximum VQs of N.
User will choose to create VQ with VQs <= N depending on its vcpu and other factors.

This is what is exposed to the user to decide the upper bound.
> > There has been some talk/patches of rdma virtio device.
> > I anticipate such device to support more than 64K queues by nature of rdma.
> > It is better to keep max_supported_vqs as u32.
> 
> Why not add it when we have it?
Sure, with that approach we will end up adding two fields (current u16 and later another u32) due to smaller bit width of current one.
Either way is fine. Michael was suggesting similar higher bit-width in other patches, so bringing up here for this field on how he sees it.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
