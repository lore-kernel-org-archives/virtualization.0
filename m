Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8577FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Dec 2021 14:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23BCE41514;
	Thu, 30 Dec 2021 14:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JIGRtDunSxIe; Thu, 30 Dec 2021 14:49:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A99974025A;
	Thu, 30 Dec 2021 14:49:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F9F5C002F;
	Thu, 30 Dec 2021 14:49:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11A7DC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Dec 2021 14:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0027F60899
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Dec 2021 14:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3apnCSLR7u5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Dec 2021 14:49:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37FB560590
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Dec 2021 14:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAqopIbqUD9PM0hVm4MhR4BGVrQsuVS/VzyeS/bSJLdtSRYZMKTHcY5DdFJcqJb5sw72nzLpQ38J7g5AHqR4eUAftIcNbzVhrSWEWolJYOGWX7B7Apks0Nn2FsmdZSHKxXU8BhXu0ezTo+AIDL8YEBCBK7xABnBo2VDS5kIZx+fefpzDpdAUTfL94zcDmKRz4EcxBNsEiQ8+zUziYtSC4mG6tUaQmbe99nq8RsRy5Qw2Nh+0+nnIRx90+lJuOPNW8sDp7ZpsVh5oR/lO2ZJf13MqlJrgg0I5Ib6YV6VSAFZnZiQHGPUmr6317lYM1jb9Y/p3xzF5uQNE2dmurQsLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5A6NXTJNS1hG19vx4iQvXezTmI1i3GfG1/ApU34isk=;
 b=l36frY3XNWttDE6OEpy16OtJDgr866J6grQYc3rUslpqMuEUHrJOsEqGSAXvK1P5BIMQQNJ25nIdkE/+mND4elmt/ds8blQubb99pgEVE+JgwLN3VO3wFTPXp/10VGhBeeIkXZHLOtBbrwxlKXoRTaiMVHXQMauxoPRbYKzZ55W6Kjab7xFg37GCgBsMzYh4WGl6rtww6312R3Mtn7dTcw2eEuvmL5Xu572WLsVaXZ/Bc4LWJ72nk80ZAqgudJHtED87u55mPBfP0cWQeokDksS/pyS4F7esBpyEFAhcJia+Cierh9lCXkWK5IE2dVWVE9p5X6ntu7qRFOmi5LQvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5A6NXTJNS1hG19vx4iQvXezTmI1i3GfG1/ApU34isk=;
 b=ITTfceHFtJt6VobHGTQi9HeW4qiMUYrGcKfSa8btRTXnecZaaw6Ax2uw6AncyJccrtKMHey0p2wCFuM/fgIdawWkaPgr0wzKyMODkG5zPVKMApfgw6yPUDqiGDDB9YNcCIpihCr3cicz9zQa1AEMyGqqnIht5jJSqVZF2bqzUNXhkJn12xtfDCPU4i8EPgTruSU04Y2jd+c++RCYyCpsMUczkyHZChVm86PjnZRJaMJy1BdhLDekDR/8Wy5QeU0VIA/WUr/05WZfjbEElSWTRSbowCWhbYmKeK712rxMombTLGm1rn/MHNJSIIqB/8Aqcsd350iOQcuOGUV2Q03N2w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 30 Dec
 2021 14:49:35 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1864:e95:83e:588c]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::1864:e95:83e:588c%9]) with mapi id 15.20.4823.021; Thu, 30 Dec 2021
 14:49:35 +0000
To: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH] vdpa/mlx5: Fix wrong configuration of virtio_version_1_0
Thread-Topic: [PATCH] vdpa/mlx5: Fix wrong configuration of virtio_version_1_0
Thread-Index: AQHX/YhrKCe2E2JKHkCw9PrXBbe33KxLHa7g
Date: Thu, 30 Dec 2021 14:49:35 +0000
Message-ID: <PH0PR12MB54817F9FCB3549B1677C8012DC459@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211230142024.142979-1-elic@nvidia.com>
In-Reply-To: <20211230142024.142979-1-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ae62a71-3ba8-4aad-a834-08d9cba398d8
x-ms-traffictypediagnostic: PH0PR12MB5466:EE_
x-microsoft-antispam-prvs: <PH0PR12MB54661CB8A52E7A87DDE32BE1DC459@PH0PR12MB5466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0iRIRMILUlDztyX42ufpgOSAIO8YW4LW1INpv11xVMOb0DW+3iRpXofDTzaLWETj45i/KEJ0Y+PISANa7ffi/PlO7su2IFlWvGWQHjAlRaMMn6TLTv2tbQSqkF1aANoorE+Po3RdMlC8Ej6i17L5fgWxkSFxmoJtXHTNUwZFNx07u1PzqxXzP7lMRyycO0Q65rAufyrr+uN0BwnSeQ1rbBaCFem90bOi46KNx0R0kZhxVxQVtsdj9NacF3iSF1pO4h/j8ug9JTuHRJ5ESDU0Fz6RkxFV6D3QzSH40NUMV5aE7gk4iS7t6f2FpNvuQZ3Q7MJKyT9gEmRw5JBSO9AJnJiXxnzjRRT7G2vKVs4Cv5weBmuQtcEU8GLLntkbMYENT+wMTEU8vWyBQd21C2zkSpkiUfgCc5I7iTygNShQth/rRJSuo0/QelutPWVeStjKHYXC8kwNh2Nw0NPYtCeSFiuaLfU7wpX7/ehSUO9R3Sj8HCbTXUCNintFBLgkqTBREHNn6yMouOk1tdvOYEKkxGd4aXKOeA6nV6V8u8vZlSi/TY6y5iq4dPsg1IGO4Yh5yfWQTH0s6Pdd3fmJz1nNRD5yuSgkLax4YjwAT2S1K5BDlIUX1snSOkD5W/ncM86696s/VFXpBUZTfI4kniD6dujPM1eco6mi+SNfE+mg13i/m03RiSBpFWiyFbNO+GuJqlJ5DzfJYjDXNqr/zMnxuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66946007)(66556008)(122000001)(86362001)(64756008)(110136005)(186003)(316002)(9686003)(508600001)(7696005)(38100700002)(55016003)(5660300002)(66476007)(26005)(2906002)(33656002)(66446008)(52536014)(38070700005)(71200400001)(8936002)(6506007)(4326008)(83380400001)(8676002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HHKnzPVGb3g2qZWgvVjaw+AR0KEZ/yGliFyM3IUr81dYH7EYgDsXi3TFp8Eh?=
 =?us-ascii?Q?agfMY6XUfjDS4SIszwqe0SUgqMu1HPaSwrmy4ixBQlvwYSqSE0fCiaND+R+D?=
 =?us-ascii?Q?/4sUSvqASxBhPpNN2TXQT2u8lY8usuGgqczXXeKwLJIAtLOTJUSfkdaNnwFj?=
 =?us-ascii?Q?ExXoL8AOBSrM5eaSq0ACaB5IqcaXySZSGJtQAdZHCVhIEtw2zeX5qoL85fIv?=
 =?us-ascii?Q?klwGBSxJhX/4bh1kfV/6BpVnC/FQENVdy+dKE9snn0S+oRSkLxqhVG9fHdaw?=
 =?us-ascii?Q?pkNyhIdg0NwwiEVH3cVZ4RSURW+5UDB53VuLCX/dKfu5T1G3Bdvuqm/QE2Rx?=
 =?us-ascii?Q?JgA+lGQVCHUCzuMykGEfCbN9rCIphHgLHT/kmSJS6Ds0uVQAN1fgs45v2i3x?=
 =?us-ascii?Q?GW2w1vNGCNZSxSFuYaSwlXlx4SqK2lGFg962Y36PKrZk/4YTGySkPAj9oI9N?=
 =?us-ascii?Q?iKHmSp5TindIi/O9Qh/e5L8T2HiiiW+NYJrGdjJ9/efV7g6dyDKSmGP0zYRj?=
 =?us-ascii?Q?w/Ubi9z6fXnbtVj0TTieZUwXllhoSq08Fj19RSmoNIUGSrxrMSZCnndRQz7y?=
 =?us-ascii?Q?vF6/ii/jwn8wOIS9Sd5otp9rKgE8+3kGySu6y7J0fa9HpTjvGSxDAUGUoAYo?=
 =?us-ascii?Q?rCxiQCtQoPVyh022orgidNW2dsXbVbqJneBcocESXuDBMjQviljOOQu1UcLL?=
 =?us-ascii?Q?laEJ4cgieahhqSjkKybLtbUd6kCXIX4pcJ1E1OwNlJOPjMOfG6F2lalBnhzt?=
 =?us-ascii?Q?VGgZYiyvINvgl/jAuj9IE8eI2Bnu2CcUS4T1NHU01eE62HN3U5zrBIwQJ+Je?=
 =?us-ascii?Q?lOM3Ptt6K9eOJHy3WpOMg8COoKCWo1236Qct8OSSWuLuqChWJlTWfaEi+OvT?=
 =?us-ascii?Q?pZLPGzx0E3rFNDmdp3NM+dSczLdqEZ/f4C6l6Gv0Oo3LO+Iz0bE4PA3y/2fm?=
 =?us-ascii?Q?7X26UnIHjdWCLlH8TWflce5ZAtoQvyQmAOS6NEkLpeZZL9bcn7blyBPOoSh7?=
 =?us-ascii?Q?pLHheH4Pu2pm6Snhwpcq9GLIycBOQMdT9/1TG4qUVXb3B+nwgZFD4TGPiatr?=
 =?us-ascii?Q?+tJ1SYbq/Y5++mqqrwRfDQB4TZUfF5lyBUalPR2Ye9YSLOi3MbVUP0Q9/7Y5?=
 =?us-ascii?Q?2ChSMySMTONkstPCkmqNKkrI4jWoKXtIrVl8ZRfaDyDkeeUCVLlJKL1makeB?=
 =?us-ascii?Q?2nY/p9y6RQanlA/IGrF20aVK3E6Rx1nzf+0iJk/NCWwCfqcbgW//meio+9S2?=
 =?us-ascii?Q?VWXzEtwwiV3J43c9UTOkgJesCkzyKV5PlX0xZXhvGWZDY0sdQvKdehESisv1?=
 =?us-ascii?Q?9xBbPseCH3+WwFBiVAVuLaDRlOz62WJwW4qoEa12origI7jDx8Dxf07HkZn7?=
 =?us-ascii?Q?UYccMI5LYZH551xs7Vo2Bz1rKGq5fCKquT3CZ6rNXBelOBpcRM5ztI1DXsAW?=
 =?us-ascii?Q?eXmGJW0qDQFFMfB+8BJUXH5wOvU0sn+8nI+hKT8dWyBEQ4sLwnHnKE0ac3Ey?=
 =?us-ascii?Q?pZMG8ZJNsHgYG7mhtGn3C5TLvJ9cPR9yOGURR+4s9vW0p3hDSq6IboB1wsZs?=
 =?us-ascii?Q?qfmYP7Bxg/dxLBUmhAdRYug5Yv0HDAi3lQeGWQPJs21UHwCDJH7fBzMBdRWn?=
 =?us-ascii?Q?3w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae62a71-3ba8-4aad-a834-08d9cba398d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 14:49:35.3141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9w6rCcb9o3zB2l0C5wtwEDK8Ta47S5rcnxI3TJqKaM9dmZ7nr4jrsghckGKBTG9ZhXOnFeLqeb6VaCN95pHfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
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
> Sent: Thursday, December 30, 2021 7:50 PM
> 
> Remove overriding of virtio_version_1_0 which forced the virtqueue object to
> version 1.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5
> devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1eb473cb9d4d..e946a36bf7ee 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -871,8 +871,6 @@ static int create_virtqueue(struct mlx5_vdpa_net
> *ndev, struct mlx5_vdpa_virtque
>  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
>  	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
>  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> -	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev,
> eth_frame_offload_type))
> -		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> 
>  	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
>  	if (err)
> --
> 2.34.1

Reviewed-by: Parav Pandit <parav@nvidia.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
