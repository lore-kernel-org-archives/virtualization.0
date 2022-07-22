Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E33C43334
	for <virtualization@archiver.kernel.org>; Fri, 22 Jul 2022 13:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 131774238E;
	Fri, 22 Jul 2022 13:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 131774238E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DNWsaWal
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RjICpGdCKGQs; Fri, 22 Jul 2022 13:14:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2CC9242380;
	Fri, 22 Jul 2022 13:14:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CC9242380
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C68F2C0035;
	Fri, 22 Jul 2022 13:14:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35516C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 13:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EFB45403FF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 13:14:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFB45403FF
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=DNWsaWal
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Xo4dL5AI0o3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 13:14:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2956E40352
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2956E40352
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 13:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0UrRMyyWYobgDpLphc2OWrl/nb5WQVfeen0v1dZvjNENzueNr+HGPICaeLopbnDeHOySZvvUXV9UCJ58ktBVJ7HFDYQ1YPPuHGQx7w2mBLbLIYxkYA++AD1iYKmS0gtkUb2lc3L/z0yuCMxrM+lzHSXk0i1VsPw8kk1bngp4AGdO54dv0ZntGp3lm730FLzWKaM/uiAeRT3tYBW9CcTVace3pe4tqdyuimcsJyYEPj+NBUuEB8QrBESdQmv4Z+EPDvRJgjdEkz/zHjYrHH/E4rSgjaMbmSq43qm5eQq59lpd2CwJVFIkDd68aXW9Ds0WOTpyWfOvcFTZLo2x9F8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJEY2bNKbXWA7gfKty+yMF1ht4IZcR/F8ecPb3Q43rs=;
 b=EDqZD3cR3v0/6sBBy45kom6RalxZ9p3l9JZ+wtMYfeHrt8JtMJzsgS2Rk65Hlvw7vcudhqAgiJjLRPfltdPGPpuIwHZuMNAKd3SAfwo2CMcGk50CXWFZyUzO0MPYqSQjfuLEIJtUxuRY/NAWkxTDsUl1xlCOJ74rhkcx3tUh0ATSZh/h66B6MfpZt7HosklexaOiZDRF+KDqiFbvLEhdDh8C/AyVGT0lr5f1ALo88PI8H0hgmUcRlpFdXm7zYSaRzXQYApat60kinnRn8WxT2kb4FRwGveYob7kRgut3Au9P+OHQhSLeY05JwxAXQlKR1LiASzBKlQV2vS+nieB4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJEY2bNKbXWA7gfKty+yMF1ht4IZcR/F8ecPb3Q43rs=;
 b=DNWsaWalAmlJrJ0T/O9so50FYCHZtkX6yR2hQUtiE2gUrwwuAeXuIwsBUvGe5vII8VP/aicf3iDmfe4uUUspndyvIQ2e2g5msl+gCMLA+GrftMHc/uMKIqUqyEgBXFj3ATV+orBFpWe9d5UPDLOTp6QhVYga0BSl5/h2WTsZH1UfrmBy1wNLUMFVRLwrbyo0NpPeudgi1WYNiHVZiQ7mnoEA87blry6bfcjUX3FoIBemasmyyQjvUMklohfM8/L9KvrIUNqhSqYfd/b45K4sCT2OBtZZGEO0xr0azDeStN2xD8PHr4ssYLkNgnGdHOm4jFrXhmQ35bieTW5aVC3LUQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.19; Fri, 22 Jul 2022 13:14:42 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 13:14:42 +0000
To: Zhu Lingshan <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V4 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Topic: [PATCH V4 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Index: AQHYncLEMRm26lhNu0yNCaNFKnyXX62KXhiQ
Date: Fri, 22 Jul 2022 13:14:42 +0000
Message-ID: <PH0PR12MB5481AC83A7C7B0320D6FB44CDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220722115309.82746-1-lingshan.zhu@intel.com>
 <20220722115309.82746-6-lingshan.zhu@intel.com>
In-Reply-To: <20220722115309.82746-6-lingshan.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f34c6b98-7a56-468b-4739-08da6be423c8
x-ms-traffictypediagnostic: DM5PR12MB1548:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0jvxLJr7jAMXNNCxHgXksIWoxn3yDIcbAlTupMz2do4xeWlTENUMy2jDjv8lqHJrgNWuMLvu+W/FbiB/r314w6n6/eR9SiZnyx87IBBSAy9TUePvOaOHKKFcqI7CCEiKrWRFypQW1sg5Mt8PjeTpIEEzp1HMFLWjM00VqZKmTznQLJJdYKPLAS/8cKoroL4oIgt0C+HCXMuDtJesg0h+x8yotm2TBsr8XmT9/q4/WTIYbcezPUZ9Kv8IxVF/B1PiBxTe1oyyvl7gu0kUt4tLhLlvphroSgwQ2kzc/aFLn0ZuVjgb/ZjSfCHiyIOjBt6LGgpcWF8RuS9GIS/wIkhPKoEdaVvpiSSRcYMGzsVWfv6JVI23IRNuKL35D44RdvsNFivHeaG4gEznLI5FHG3Z2Dn4veDCF8CAFJEl9gSpHNYdGniaW6Yv4VMubm794FeFiSYLxuOgU9zwu4EFuNKeeqCKk6HPJLX7uAf2xfgKLRmvEfwLWu+qaYTvZlhsebykvFxv40OrXWIyJbxe5fYNsj+HfFsSuOwo1E77MDjyEsnyuePo3GM3My7JUjiHJgiF/5vqpuKLJgiTA+MFq/x/mAv2fl/xCI2/I6Ts+WpTrpVJNr01MPr91xMTasWMSQ+rIqHoYRLYnKtcsOdQ4imqwBIFh2VsDAoJuSJhrRvHpcA3Bk5mBGL50J4hGS4JaXiAQ2DOFPZp5h2612tc3Wx8IkUIVYPf4jnJr8dO93Dext0NozRVdshapDb6I7Pu7O+EDg+9ZqwiEAGCESVlRzY4ua4PHtt2X9roEhjOYNk5aDcJgx2LKCKV2mCSVOn0zbX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(33656002)(86362001)(41300700001)(55016003)(71200400001)(8936002)(122000001)(5660300002)(52536014)(2906002)(38070700005)(66476007)(66556008)(66946007)(76116006)(38100700002)(66446008)(4326008)(8676002)(478600001)(54906003)(83380400001)(110136005)(7696005)(26005)(316002)(6506007)(9686003)(186003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FhgLxyyj3SS/nca44X95dceULcPNugKFxttOZtnfNbnyECGvt/EFoFtt6aST?=
 =?us-ascii?Q?5WoU4DHo2gBgJk8/2HW69Ix36hiAx/U1xATx+jHCd6vNcNN3dst/o7MTYbC7?=
 =?us-ascii?Q?64KhVQYuPg0Mzwde5tJ74Ab6SgqiZhng95kDeq0gR0/jQpgDqfqFVYO/Vz44?=
 =?us-ascii?Q?wlCG7EvAUOEPT3Td9rob4Xvk2McT43/L0kIFLiDeo2SpPx2kgw3Y++bqpfhD?=
 =?us-ascii?Q?TimhG6pzadQMaKc0o75jWWbwoC3L+8IPYaGI9zaL6vKbSc0uwB2l7xgDT12C?=
 =?us-ascii?Q?K9R/yn1Rs0n9txiQqXIc++bca9L78KmvtOYfSsVQrahCOnWoH6Pw0ku5yjx5?=
 =?us-ascii?Q?xCPKhqlUnTH7FsLVXFrbjfNjcpoRQ5UvrLZVyAA2PoQsakfa4jw/b8aZTV0h?=
 =?us-ascii?Q?BRC//GiHn8iGXkMHRRvcvOHjvfRLq3eBUBNWXSqT4UwjUrqGWYOIUyKS2ESV?=
 =?us-ascii?Q?7jU9BEEkN0IJ4E4eDgC5lZ2aP8yiGqd0sh7KtFwzF364/7fIdgsU9M48C91q?=
 =?us-ascii?Q?2Had3lwx1rSZo+0yp7c7PiF6Ezchfpfy7yQfNMs3RUZeTPeozcJ3pqhzZmqp?=
 =?us-ascii?Q?kgjG41So2KiylT34f0UPsduoo2MCYCeNKCTvkQbsHDEbNC24M6mqWBqZEIMY?=
 =?us-ascii?Q?PVwqpE7isJfYu819gNsUh2st1ky7gmYgqZ24BYCjVcwOo0HqFVPw4Yls6WF8?=
 =?us-ascii?Q?hqpDs2IgyKyV0uurcav5MEJlVlN438pZ+7ss0rUM4VSOJzxqQ4lJy4LEVa2L?=
 =?us-ascii?Q?T0AdX0Wubp8KDXVPvyT9J8/6liuRTeJqXzzqdvnnCUvBa5OxlvaOBHpDACjM?=
 =?us-ascii?Q?nae7kf997XWFgjhABtua4AWU3gcnTvK4b8onOx0iyLpYyDH4IUlTDXF3yAMc?=
 =?us-ascii?Q?FgrS3SS0HMmfGaEKfuR+p+jUvMbw9Fg0BNxwg3lIFJT2HlS+wY2lIsv9iGfu?=
 =?us-ascii?Q?szye7diMrb22DpeR1IyOstpZvkmqoZGkR1yeScU0hkeAVGJ3M4Kk2fSOSVtD?=
 =?us-ascii?Q?eJJqyCquhWzZ8j0rbyhDofY6gwdh2twvnSpvF6IHc16Fp/A480NC6/l6BCFm?=
 =?us-ascii?Q?RH51LOVlY35TS2idAbgJmPxQGP7tuEgBlCgf4O91vACK0jmkLLF8jME38kwo?=
 =?us-ascii?Q?Qpm8y3C6F63GO8+PHnpdTAqxGGOGmS3oTqrEBP8+YavMz3AsPq5wdbxrJxxG?=
 =?us-ascii?Q?RiOS3eZ7Aq/lEO9P8Eg7aVgZjeYObLTA1hNC18IQ7kh6KgXgqbjopcO8Gffp?=
 =?us-ascii?Q?3rxSkyd741pxFrIEcmtre8VeZ6XpuFPIm+SdHZ0yy3zs7Z+ggHpQJmBHrNSH?=
 =?us-ascii?Q?JWveaDDfnz4sDfBgjkv+Ml2DFJbM0y9yTmCcZp/BIDGGSyqNqmVfFUrXkuGN?=
 =?us-ascii?Q?WbyRFYb3u+sbx8AiFvbC4lCsVdLp2tlLn59Zf8AHPhRikyx9m6skQulJo7wp?=
 =?us-ascii?Q?ScPM6UB0b4ZcLxmqY88ELcbfEqnzEgH5f541q3LmXV5jYB1wwzxmecw4z03Q?=
 =?us-ascii?Q?7CBI9616U2qsY+LhxJDVE5YaAIBJHtU6xzhDRjnCCe/ZVYs34Q7xo2c2nKBR?=
 =?us-ascii?Q?VLeKPSjKs8rn3gQCAnU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34c6b98-7a56-468b-4739-08da6be423c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 13:14:42.3078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTT5BYe6MBUwTEre2iQsqcCkxqFdtZkdCaWg843QypUKpHiT9vgkhh8Qc7WUvsmDzB+p19HcpbYx0PrBxAgc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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
> Sent: Friday, July 22, 2022 7:53 AM
> 
> If VIRTIO_NET_F_MQ == 0, the virtio device should have one queue pair, so
> when userspace querying queue pair numbers, it should return mq=1 than
> zero.
> 
> Function vdpa_dev_net_config_fill() fills the attributions of the vDPA
> devices, so that it should call vdpa_dev_net_mq_config_fill() so the
> parameter in vdpa_dev_net_mq_config_fill() should be feature_device than
> feature_driver for the vDPA devices themselves
> 
> Before this change, when MQ = 0, iproute2 output:
> $vdpa dev config show vdpa0
> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 0
> mtu 1500
> 
> After applying this commit, when MQ = 0, iproute2 output:
> $vdpa dev config show vdpa0
> vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 1
> mtu 1500
> 
No. We do not want to diverge returning values of config space for fields which are not present as discussed in previous versions.
Please drop this patch.
Nack on this patch.

> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> d76b22b2f7ae..846dd37f3549 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -806,9 +806,10 @@ static int vdpa_dev_net_mq_config_fill(struct
> vdpa_device *vdev,
>  	u16 val_u16;
> 
>  	if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
> -		return 0;
> +		val_u16 = 1;
> +	else
> +		val_u16 = __virtio16_to_cpu(true, config-
> >max_virtqueue_pairs);
> 
> -	val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
>  	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> val_u16);  }
> 
> @@ -842,7 +843,7 @@ static int vdpa_dev_net_config_fill(struct
> vdpa_device *vdev, struct sk_buff *ms
>  			      VDPA_ATTR_PAD))
>  		return -EMSGSIZE;
> 
> -	return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver,
> &config);
> +	return vdpa_dev_net_mq_config_fill(vdev, msg, features_device,
> +&config);
>  }
> 
>  static int
> --
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
