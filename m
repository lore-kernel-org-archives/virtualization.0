Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A1AC43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 22:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B50F3846B8;
	Fri,  1 Jul 2022 22:18:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B50F3846B8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fE1yDlQg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ETiLr-34cAnJ; Fri,  1 Jul 2022 22:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 35DFD8468D;
	Fri,  1 Jul 2022 22:18:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35DFD8468D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16277C0032;
	Fri,  1 Jul 2022 22:18:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2F0EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 22:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E3BD60D4D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 22:18:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E3BD60D4D
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=fE1yDlQg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q_RnSSW5UrNd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 22:18:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8950560C03
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8950560C03
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 22:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnRB4Z6Y050rsFqf8s9ucOeg7uVFbSJf2MKqs8cmjwF+clN6R161656u3LNm0XTO/q1oSoAHDL09QtWgz9SM7luCpsswynScHSTFMvyLZxBTGzU7pKX0vyhqh5OjpBHpjQnjhzaZnL+TFZ1UGNt1eeVq14BKimjjWL59TTTriwchse6dVIHJFw0bcvhjbl+Mheij5MU2TNy8ITKpRviIMqkQwxmiTgTP2/CxNd2j0KUFpxBApO8m1NZLM1jS9hky5c14DvYYxhhyyhCQ/h+lZFBgpZZRvuDnj/CSS6TL7eNCWSLmkHzzks0NUwhZXAspex4Zit8i4k0BlBRIWuiU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8qmRWfF+XOZPwdOSKliJE2/DfmEHk0NNz+tCQ3PRXw=;
 b=eZ5dxNQR89R1k3bGFEbZoXqiyyyLFz7O08XNqklVE8zdwTQu9l7FE6s+i75cLnOYWayLEBVSH5vqFgdmCuoDfgGjMqgsrMqbVnatAU4aHGp4ISXs59USPNE3kQl8WFixkwA4kQsFp6GcBF8DLv88aB7mSKHEV7Zyh9oNCJ9RaGq/FVTMmVumagBQQokOi1QzDxiPHcn7nnnvdZcYOSIVM449IkVH2oVgLWhUWi1VQc4XjmqZUmSg3c/qD00kU+PSbrfg65V/GCCAI/zJknj8fQmCv2BJoj7anaxlI2O2rRD0Zr22Bxv98W6if2T7WqHoqvhCOrHU0sPUzYXUirTz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8qmRWfF+XOZPwdOSKliJE2/DfmEHk0NNz+tCQ3PRXw=;
 b=fE1yDlQgZdar1CedQHuO7cyMR4nTHgzmu6wL6DN3JrfcT1jbzS7g39bMlBlPn7lJ7QKxuOwvVaiGS/tEX/o7NnO85f1iEvyFCSqi9TPm9wPsXgNWXSA7btwGolUSWunr0r6+hhHTOPzxNxFiMw+QviCnL3FvdfSqGebOgPcR3dN7X/VLMlSOUH1oeQ7sIeVmuuqu3XxvscqOjj/ll3aZJn1ql8pWJNYVpg9snflKFWFsf1nOyHcNU5hotPfJ1L0agRfpYdDiSQyGXQcawautv/WGyn1DGf1K1UXryysF9kCyrxoT93eNmrcNad5icLtuWLM0x7bUz46dExRG9idduw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 1 Jul
 2022 22:18:24 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 22:18:24 +0000
To: Zhu Lingshan <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V3 6/6] vDPA: fix 'cast to restricted le16' warnings in
 vdpa.c
Thread-Topic: [PATCH V3 6/6] vDPA: fix 'cast to restricted le16' warnings in
 vdpa.c
Thread-Index: AQHYjU+QmOZttA2ivUmN8uBJ6/N6Yq1qFNVg
Date: Fri, 1 Jul 2022 22:18:24 +0000
Message-ID: <PH0PR12MB5481D4D77EAC336BA68E85AADCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-7-lingshan.zhu@intel.com>
In-Reply-To: <20220701132826.8132-7-lingshan.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a918dc2e-d8c7-4f78-f3b3-08da5baf9d59
x-ms-traffictypediagnostic: IA1PR12MB6044:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEuB8cRyuyTsbIgwiD2DdTim4VAYKZ2euOkRWxNZCxfojR2Xi4Y9e5nPOvmrBm9i/xNjgPDsBVJZtp/yUznhsGPPqT9qpT9SNxnvmdqRued5LIbu70rwpFd6OB3/Y+daGMWLlJFhnRH8L0H5D37Nj70AypHemH2pbdO1KsE/V4it7GAosEKx1WkkNpHCYGYoVjV4bJTVhkBNf7teh7aBP5cgZTRhqpLz4KOWjBaVoIBnkmcd7KMaRC+3vuO45KP4t9EdWG/7RPqQKk3pXTze/XPKduKnc+9kjy0jSsvsPJrUMSUyuat7bE+gSbd5Du3VVwYXn6Gq/wIEkoaepwD5MUeikSnZrrXuDakkQp+auBXxlrZw1upru7Hi7778cq5K/AlGyNjPus7G/eRjakMVb6h/GLQ2Rt2F4iXQtHEumEA3Mr5vsaUTtJXZeaMTl307TqutSzPrOq2gj7SJMv+3iKX+KF0Y0OIeHLlvzqpMvMGYUFIMIT4PdpwUGfEaE3QN7ed1TwDtLhdWyV/4qDJv5QuPTfXodbEN4EyCG3c+bmMsWcMrdnxZVqFUleqnQLdBp7dtdSQp+7dqpslmBViGRqlXO7eyE+T+d20UP+OBjurLyxOFRFfVtMisXvsR8i5yh6obTATSRDPJMUp6M+FTqfKeQ7MZ5F2ozde8ErhJ6mFrmBgH/dJJt2b3PS4WpefATzV+BnnaJok3W+ywYGKoVVGsqXIk9t0gbDApiApkIjuz6L1H57yiHbJe+ADvDCn1LRbuj6W94IHYG31dmcuL+e3RzG9Elxbnd3YAWFYu/9jyJEuNp2e4nG1WswVkxlTm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(8936002)(5660300002)(52536014)(86362001)(478600001)(122000001)(38070700005)(110136005)(54906003)(316002)(71200400001)(33656002)(66476007)(4326008)(8676002)(64756008)(66556008)(66946007)(76116006)(66446008)(83380400001)(186003)(26005)(9686003)(41300700001)(38100700002)(55016003)(6506007)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1z9krt/EZyKyacmqnjfUBMshfYr5e3RnxERVwlRjxf/DY1h82Xc4ylEeefwN?=
 =?us-ascii?Q?xtdUObFPjdpAPJYldfnx6g2iF+c8APIxH9gVm15sy2y6quiRD8glpsY4ToUW?=
 =?us-ascii?Q?JkhMB7DibcbvJTpqSOklvT71VFwqEZzpao/TqhOzzPV8yPxXCPHsghEiqKP9?=
 =?us-ascii?Q?IVbdnDBzfvYyEYrcqpInXZoRFmbWqUKDyHr72UlalyZtaJcVNiBOuC7bkj66?=
 =?us-ascii?Q?jrT54hGD9MhBwFts3Mi/dj5LjEpJfPdvxPu9dm0jNVuPWK85NiQmU9nKrS2T?=
 =?us-ascii?Q?E2M+o312tJ3Y7G1WwggFl2MMKyrVT5v3Q9j9ou/qAmHB5bGtPT1nutuo0CkN?=
 =?us-ascii?Q?XbcBEaBcMYHgtt9Cduo1Pso6XhNAxtjoZ4S0LmsVnF8EMpLWstK6RwsXM4/1?=
 =?us-ascii?Q?W2XBVEInsOqdQHh+NiG4G4zrR+fISe2aFyy9UMxwYXv0mEjSnzQHZlw1iUDj?=
 =?us-ascii?Q?ZYEYseWhBQdcZlj1OtVHuRhYcUhYMEjYbZX63LndcrHDo/CSL3Px7ePu5Ojb?=
 =?us-ascii?Q?FNHFz0evWVXiKPioy8IB3dyY2y1WrKKyKYtzw9GzLPMxUWOQk/D9uyLk8ahe?=
 =?us-ascii?Q?groXZStK0kf9umarr0Ol3MgLNImC3puagcfFVQnv6F1VZDUB9h3MMgyCK51Q?=
 =?us-ascii?Q?9xC9bv9jBHsmQ0kulkqD/CVgRG/0IQ714t9ST0o73QQJTDaypH9xHHTlXpi9?=
 =?us-ascii?Q?jj8sfZGkkB+QOQd7RVfvQtliiAkrF2u0qMvYEl2R48ZUAiajZRMV3JCcUGbH?=
 =?us-ascii?Q?yN7b314bKOGnBIuGtOBax0DA0QheXrVAycQdiboNmuBXDwA9kKIJl3f8RmdO?=
 =?us-ascii?Q?HWxDAG0jVddEBuIhvfegjbipokwRhu5gc5EsyADW82Lwrc7eGaaRLDZITGM/?=
 =?us-ascii?Q?sCwk+OZSjp9l/e2LIVUBF8WFhPZr310Iz8N6/fyCI26MDZYqbTUBnCaBri2h?=
 =?us-ascii?Q?NDAwFOlABVYTxCcjnl/6p+l1kMZ8/sNv3kOQOVucf/t24U7yJ4bccJAgGOiv?=
 =?us-ascii?Q?PXv/33ec52rRkw6Gf2cX4IwDsIXeqWnWOBgdWtxbn3SfxwSWE8gm4o9gzBQ/?=
 =?us-ascii?Q?VfmdyUMlHR0eFwib/ZDaA+t6c5DvaZ4D+YDUzMgbqXXiEsHrwe7R2tTl7+72?=
 =?us-ascii?Q?VhEAgtjlOfYVTrMQiun9UNdPx/MhBDi+8qPZzve5tyXfyI31lUzaDTvE19hf?=
 =?us-ascii?Q?9BVThauGEpteSO4FNZL5LH9xse933PzQEVWxDrGpIMAmgpm87vs0bG2AdgWu?=
 =?us-ascii?Q?RRWSMAX4XPRZHh9YZVe5TDN/4gWqfr2hAklvF2kHdbAoceERK4zz5YLXvCuh?=
 =?us-ascii?Q?kGcXH3Lk29BBxp9vQwaqZza8ZJLhuQCqvfFAWvvtZ3gLsxYerpLj5P91Kds9?=
 =?us-ascii?Q?y1V0WnJITAcfLIF3j8vs/Rb487kG7rZUsQfEXzFF0iwhCC6e12D6BlLcfhRH?=
 =?us-ascii?Q?4fRi1KBJFKLx+mCbFobjDVvHKju/LvyXu+U76hZtiqGxG+wMZA2EazOLEL6p?=
 =?us-ascii?Q?VNMvum18HRTAEzsEqJQtTlDlM/D1yHIsvdKnE+NCCGA+RiMJEhNqCTyR1H50?=
 =?us-ascii?Q?vOVPnFNPvOcXi3hrmO8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a918dc2e-d8c7-4f78-f3b3-08da5baf9d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 22:18:24.3356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/yNdgSqWoY4WfsI2F7F3G2zIUIRxIK4+RUPvGB38qDlithj2bwR52+kbq4UXzmQkJHo5LLL8SonQp8eT8B4nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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


> From: Zhu Lingshan <lingshan.zhu@intel.com>
> Sent: Friday, July 1, 2022 9:28 AM
> 
> This commit fixes spars warnings: cast to restricted __le16 in function
> vdpa_dev_net_config_fill() and
> vdpa_fill_stats_rec()
>
Missing fixes tag.
 
But I fail to understand the warning.
config.status is le16, and API used is to convert le16 to cpu.
What is the warning about, can you please explain?

> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> 846dd37f3549..ed49fe46a79e 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -825,11 +825,11 @@ static int vdpa_dev_net_config_fill(struct
> vdpa_device *vdev, struct sk_buff *ms
>  		    config.mac))
>  		return -EMSGSIZE;
> 
> -	val_u16 = le16_to_cpu(config.status);
> +	val_u16 = __virtio16_to_cpu(true, config.status);
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
>  		return -EMSGSIZE;
> 
> -	val_u16 = le16_to_cpu(config.mtu);
> +	val_u16 = __virtio16_to_cpu(true, config.mtu);
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>  		return -EMSGSIZE;
> 
> @@ -911,7 +911,7 @@ static int vdpa_fill_stats_rec(struct vdpa_device
> *vdev, struct sk_buff *msg,
>  	}
>  	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> 
> -	max_vqp = le16_to_cpu(config.max_virtqueue_pairs);
> +	max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> max_vqp))
>  		return -EMSGSIZE;
> 
> --
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
