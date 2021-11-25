Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE1BC433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 18:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B62760771;
	Thu, 25 Nov 2021 18:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XfYNkBgD9U34; Thu, 25 Nov 2021 18:27:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C3DE860757;
	Thu, 25 Nov 2021 18:27:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C4A9C001C;
	Thu, 25 Nov 2021 18:27:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 469D3C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 217186075F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HNq0wFOaFcDm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:27:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::623])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BC4060757
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3kkP3mLOdZ5hY0+XLMLXNrlHxwyFUV+OKb1rC7Dc8BEng5ZQA5Reo4ExKPZVEwkdUJc7CpaWcSN5AI6ObBLW9mmWp+f49E/qiMtjsB2V9XV9No1+bLLh98Q03o0eCMpvEHIs2Nt0wWqlE9hC1VMRsmdOacD8dRBIM2Ac4GR0RhW5TTH/6pQ+fsQ9+Wu3orpxgSf4MXnARl3VdVhoGGBPXI53B4Kf70PhjkK9pySZbQsdzUdX0NgfkNdHyCeS3ZEf28Az/ZuEahd7oJH57ecFAqD0OvK31CvmzH7k+S4tjHz57xLYYA8d6102/t0ZJJwtsVUJ6ly2wgJjrdFrEtNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL+hApog8jOHmXevYcYv/2JBMVSYk/rHjsWzOj2DQr8=;
 b=POd9FjVwiP8t7dQpqmJ7/MVWFHauWUqBU+/ytxlabZ8+1esx82rVM3g37TKgtwj5gTxKDaCTO1jLbYhakxpPsSxPuiP4/2CUXpz22HkJ4KZv+6Sl388ajfGpOwQnrDCFLdHDWkcM/7KPzRch3wNYT3rpdLZBy1dU+giPPT8Ig9x4M/jSCZ3yjXopJP1SmQz9b69U59Vopg4ItxfxTTKs/xiW0AlNS/6AZbIATtiTbQ6htHPJfG7QF+zNd3vBcV0eHjhgMs0AcuhcSSRA01qZZ1QwPnEFCgURZ/TFOFLM2LS8c9GbPZMaev0IhT1bAsEt8s6rJfnD06SF43b4NqYOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL+hApog8jOHmXevYcYv/2JBMVSYk/rHjsWzOj2DQr8=;
 b=di6l3tll7rcB5jo2vlbi7pnApuzQAMZcqANETEDjRVTuUftjEasJPmc+QnADaVxeayrRTxmKxxNhSs3xYz2JAB1pP58ysBzf1AWl5hJF9aeHoQIkDjuhlDVSdfbySwhXJAbPbynpYU33anOP4NgvEtPqNB6UV81SC9Y7O0t8rM+RJiAeXbcf3uVJT+pbtQQnK9QgCGVOPT22Kvd3AGYHj7RWhgHvhcK5015lnF2h0Lm1efaaJSLcxjhQsC74KCQsZCXvMdKr1UuFUye2zl74+AzquiUgEsuiWzy46Sa/vgpb+JMxU51VKZ8GluDj5Tx8M+DtbfHDEAGuxrtXE5azwA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 18:27:15 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 18:27:15 +0000
To: Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH] net/mlx5_vdpa: Offer VIRTIO_NET_F_MTU when setting MTU
Thread-Topic: [PATCH] net/mlx5_vdpa: Offer VIRTIO_NET_F_MTU when setting MTU
Thread-Index: AQHX4VYkiZKl8sfu3Eqo3IWvXH+WXqwTtRfQgAAtz4CAAKtGoA==
Date: Thu, 25 Nov 2021 18:27:15 +0000
Message-ID: <PH0PR12MB548163DC0306DB2EF50B76F3DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211124170949.51725-1-elic@nvidia.com>
 <PH0PR12MB5481CD17327097D7E7865B8DDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211125080227.GE214101@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211125080227.GE214101@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf77dc7e-716a-4ef7-bba8-08d9b041350d
x-ms-traffictypediagnostic: PH0PR12MB5481:
x-microsoft-antispam-prvs: <PH0PR12MB54815334CA200577746F5C3FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKNLcd97y2GiFYBL7F7mqL+eR/dgvJvRC/t36ZNiLZgLsLeeSxBvTRcqk/TM9OMNAQm0WyEo3goCWvmkvVog7eV8FFRdLieIAo9eDY0DFuhl1QnI3vNCDN8yg9gdobjMK+QizS9xDuup5jpv4C5QQXNWA2llGhs/wQJByOl+U0m99kpMlMzBrz1J5VdbOUgmiLr3Ukgrzld813paQOUW/404cLqOHnIzQ2gu8HQ67WHOvfQ1CBIj4eWg+arlvnmGuRDin726uMURio9cGzQzIqcy5AEWiT7Wd9ci3rT/13hq3PI9QhQmy0Je4YXFzqYJQ2/nikFfzLnYflYrv6kcfl4UjRPEy2d44eyK6UyG/5iGqOTzKVR4xASjuY1THLUIjwLrNOCt0lN0te8DpEnN1jFlxx8XlLnQ6IdjkqU+Txqb7I97XxdtXrpkd5dxzqi0KNCiX7Ucbti+lDlKkfwBSzKS75TQFp7xBSVZkcEMVyVkLTclxF26TB9XmNNkoxb0NZ6aadhKGeygaXQrlzsnIbTfswEpafOtCGRVSVxHDjWlhagTAakr+ndNMgp0qH1CN18259iACNpTKoRtNyWYOcUmq+6UTKI1fzPNI23v9urSBJPrRROKWVpbuT7yoRNHjE96Wi+Fd2Gw25rMziGgc71i4dyF80VvDZQhspq2zHPRldLmaN1WqFRJVDq29yQigRNsLp1yVS4+wG0BeM1/Kw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(64756008)(66476007)(6506007)(8676002)(55016003)(66556008)(508600001)(66946007)(8936002)(54906003)(122000001)(9686003)(66446008)(76116006)(4326008)(6636002)(186003)(7696005)(86362001)(6862004)(83380400001)(5660300002)(2906002)(52536014)(26005)(38100700002)(316002)(33656002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rJyLwFAfBlU4dRSYAFuqi/qeBfEbzGOhmBv2BVE5XJcuu8RtVis9X9jnC6xt?=
 =?us-ascii?Q?6o90sC6QlI1m7kj8RCPJchaq06Wc6L6P6JtzJI7iugXMtRtHbokhLPAFFTdZ?=
 =?us-ascii?Q?V5uw1AAWJbhZyVEjUF8RfvM7Au+GTtVUaq7PnIUuT4jhLEO6tl7fg/Tq5dOQ?=
 =?us-ascii?Q?esbixMfRc5DxA0qqGesMTYrjiNIEIYHaeXfigURfHeWJhYpDpQRJpPaE3J0V?=
 =?us-ascii?Q?FZv8z37eobKMSsw3s+Qy9TG3hAwXHtKQIZJ+4MreaBChBX2VbJiioC8LTCmz?=
 =?us-ascii?Q?4+qoC185fK3T3C0r65ldXEVTh/JeoeU6yKuBfMcBqzQqS7zgO0h29AKKCOut?=
 =?us-ascii?Q?bLuM6HBwSNkKckpQAP20qhYvzenZELNeh+2dKdAuA4fGzHBxJUCoZM4Na4Yo?=
 =?us-ascii?Q?hvYLk6CMHkJTSl0YPXFnv8Ob6SXGAqandRS/ox4cMTjxmNuYT9IvmW2o2gB3?=
 =?us-ascii?Q?Txarff81Q1kquP179DWCbaPJkGkzb47hQ/RoUcgyKm5CMjfhRcJGwJS912My?=
 =?us-ascii?Q?VFELMqEiRQlMUjxZFuVhTpyLnn9GNVguM2vk6DVzWmfAlRASj6wKImSKp1Ym?=
 =?us-ascii?Q?Krfdf5LMShp9JSlL9OQ8JRFjSax/5pZX4elVdmIhARzSs0CbBaZe+MnBbPgB?=
 =?us-ascii?Q?IM0Ob2+KR6NPi+7YG+dK7zANHwDvWkhacLrvLtZNE/r1W1K0dAX4j8+KoYtz?=
 =?us-ascii?Q?VYcEIiGqIzhmTVTkJOpjGNYUZLnu5ShEYj6J+CjQXSro0HsIc6EpD/gcrba0?=
 =?us-ascii?Q?KI2TVZO/smzINrUZrhQ0uIaKY+c1BRX8LW09jY7LsjckzLV/ulWnLK1lUeU2?=
 =?us-ascii?Q?MmtCxtJ4P/kFhEdEA9z/VuhHNklYlJ1Yg+AzgD3FIOpvUoRhh5aX0xttL6Bn?=
 =?us-ascii?Q?iY9hTRGxjiq0EIsuDkfC7huAy4kqh4MkP3jrW7X1LHOwB8Dtrn54RQzJ26aW?=
 =?us-ascii?Q?CKGEvRQy67kgkDbiXTQ3FSXq3/Za/s01sbLD1vVzmoLPYGZqMhRd9aEqjp+G?=
 =?us-ascii?Q?HZlJVQd8Y9rmdK9ZQNy3vktRpJnuDuDPTQxMdAQv4jDXrO3THmQS+knUXld4?=
 =?us-ascii?Q?R+gK563bPGWKcOrobncSAMSYbRmMnP0iinpYXkgbwYsgMNJHlBjsOgCtej88?=
 =?us-ascii?Q?uK+JmcOEDZmjNaVe2NSnZk1Sj2e+bMEn40imP+iqf3oImFGs0khis8S8VVFv?=
 =?us-ascii?Q?r1EutSMNq99800kuXd29b00mIWAinjo/WEKwNlrTw/O/bzMZDm68K332gVaa?=
 =?us-ascii?Q?X2s2dGK5m5fzaY1Ar8flIbhBseXGekTwnMjx38dyx03n5r7GH2P4oC2dfE7E?=
 =?us-ascii?Q?JTChim0B13w6tQ70C6l0QcqkeE+GQyExF/41iyxQ6xdjOA3HEz+6B1DxKQqh?=
 =?us-ascii?Q?847I079izfaRop4rhoBTER8Waoo3bHxTuupgZOADtBMI95/c0jraSKMJXbGA?=
 =?us-ascii?Q?tNGe5dPTHLGwWuzv60SmyEOzAA7GQsLIKvxfyTz0piItq8dfGVUWksPIHZyJ?=
 =?us-ascii?Q?lVSLZeQIc2vaa9OUQKnSDJDJBHGwlSa2UjZKdnQGm4wVoLwA7W3315Enq15+?=
 =?us-ascii?Q?1KXMSumiexix5GKDFXzQ8MO8IhNzwaowlIrbcI5/j6ZNzEStf1t25Uf4oIDO?=
 =?us-ascii?Q?KQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf77dc7e-716a-4ef7-bba8-08d9b041350d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 18:27:15.7776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bo+9piT5FAc4p3lLpH3IfPEsFO05rvCBRBFHRdmHPgZiwpkAuEbgO0eDjyPjve6N5NI45sLYSW0LWt60u582nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
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
> Sent: Thursday, November 25, 2021 1:32 PM
> 
> On Thu, Nov 25, 2021 at 07:29:18AM +0200, Parav Pandit wrote:
> >
> >
> > > From: Eli Cohen <elic@nvidia.com>
> > > Sent: Wednesday, November 24, 2021 10:40 PM
> > >
> > > Make sure to offer VIRTIO_NET_F_MTU since we configure the MTU based
> > > on what was queried from the device.
> > >
> > > This allows the virtio driver to allocate large enough buffers based
> > > on the reported MTU.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 465e832f2ad1..ed7a63e48335 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1956,6 +1956,7 @@ static u64 mlx5_vdpa_get_features(struct
> > > vdpa_device *vdev)
> > >  	ndev->mvdev.mlx_features |=
> > > BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
> > >  	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
> > >  	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> > > +	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MTU);
> > It is better to set this feature bit along with the writing the RO config.mtu
> area, adjacent to query_mtu() call.
> 
> Why is that so important? We always query the mtu and if the query fails, we
> fail the initialization so it does not look critical.
It is not so important. But it is more appropriate to set read only field and its associated feature bit at one place, which never changes.
There is no need to perform OR operation for those many feature bits on every get_features() callback when they are immutable.

So I wanted to move setting other 5 feature bits assignment at one place in device initialization time similar to how you have done VALID_FEATURES_MASK.
Something like below.
But again, its minor.
If you happen to revise the series (I think you should for the supporting dumpit in future), please consider one time assignment like below.

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 63813fbb5f62..21802b25b0f5 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1890,11 +1890,6 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
        ndev->mvdev.mlx_features |= mlx_to_vritio_features(dev_features);
        if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
                ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
-       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
-       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VQ);
-       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
-       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
-       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);

        print_features(mvdev, ndev->mvdev.mlx_features, false);
        return ndev->mvdev.mlx_features;
@@ -2522,6 +2517,14 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
        return ret;
 }

+#define DEFAULT_FEATURES \
+       BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) | \
+       BIT_ULL(VIRTIO_NET_F_CTRL_VQ) | \
+       BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) \
+       BIT_ULL(VIRTIO_NET_F_MQ) \
+       BIT_ULL(VIRTIO_NET_F_STATUS) \
+       BIT_ULL(VIRTIO_NET_F_MTU)
+
 static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
                             const struct vdpa_dev_set_config *add_config)
 {
@@ -2565,6 +2568,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
                goto err_mtu;

        ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
+       ndev->mvdev.mlx_features = DEFAULT_FEATURES;

        if (get_link_state(mvdev))
                ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
