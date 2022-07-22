Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C768C43334
	for <virtualization@archiver.kernel.org>; Fri, 22 Jul 2022 13:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 05F804013E;
	Fri, 22 Jul 2022 13:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05F804013E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uD0XGIqH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BblICt54M8uu; Fri, 22 Jul 2022 13:12:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5CA9940352;
	Fri, 22 Jul 2022 13:12:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CA9940352
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C6BAC0035;
	Fri, 22 Jul 2022 13:12:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9488C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 13:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BC9E40352
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 13:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BC9E40352
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zOhCGTJQFFJk
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 13:12:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9F874013E
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9F874013E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 13:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK37BdjjaaXRFw+WgKdIdOYSXtI5xmFYmiq43mjnJCjT8wYHZ1YER2rl8HXn528Mj6uo5fpkjnXHpuF+JJ+IdbE784pRKHqx06Vs4LTagIkhgoXmfe+CVvuXmGHc/uEMDPa4RCL6jqA9uJsFuDIEOahJt4dURqL9IFxB+6SIr2lxhDSTouY7lanN6CDRgmbvYX3rRTxQqTb17dKnPSpVjgWchTt/2CXDenL/Kqp6oegDSwLgh9dsrckHNmzC1Amv/WMo+7eNSANJQEp2iu6cSHopt5T7ntVJNAKr4H5VnGXqZwCixvS31W+dce+73QsC0CUISfcBMym3rmaUPFG5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a/X655N88yBa7mmTChUsDHTl06PUBRU8r3olzpFZdM=;
 b=km6sKnev3ddwZBcrmtvxTpmHpoHLHy6b6927qIARXiCFRIxsIse7WztJhqf+3B0GyOQ2EZ3y8kUkW8cHeptt5PLrw6H31u06ztIWKxksU0UsE06+5k6bb53orJ5Atapm6/CHL+jlnYgYiLnTFaA6LMb6CTVY5hR9bu9iNhmsduHGCdwlFSPi82L2LBlNc6XCLssgOElZH+61P9kjuekr0hhuUFunVvDuQYRNNLkh5HIZTeOkKUUM9otWLVYUoe5QGtC7AvSt7eIj02Qj1+gE7baemQfCoXaS/os0faLCEZXXEuHV1PydFAXit05bCT6b9nkuPeA+I7htRsNeQxu1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a/X655N88yBa7mmTChUsDHTl06PUBRU8r3olzpFZdM=;
 b=uD0XGIqHKNiILf/Zn0/BXn7sJIfRQl8LUG27f3Tcj5z7eMI9sj2lOlCvZJsscOMeqAh6GoZCAgFk2bizFplF3eL4nxyFBCEl7xuP4+jZ8HfsR4asWxOHb1Z81x57alFV5lTND//8BEZfokBJRu6q0fy6qtml5Ug/V5Z/GFM1+z9crF7iRoMZ7qZFAFnVwUiYggwmayI4n7mgmpGi3xh7Ygv7GCNDpQM1AwGWZHjZ0VbY3unheOx9vIt1I225KaOk+VNCZhZStfcmOKMqWMMlbswZ8L8Bd2EGg+FrX5ZJ0j3FVZc4lAaQ8FzV4NfBgCBrceO+vXCM9hvw0608aGJO5A==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 13:12:50 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 13:12:50 +0000
To: Zhu Lingshan <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V4 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Topic: [PATCH V4 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Index: AQHYncLBTkGC7Q3QJk+hIdvX3SqZ2q2KXRuQ
Date: Fri, 22 Jul 2022 13:12:50 +0000
Message-ID: <PH0PR12MB548193156AFCA04F58B01A3CDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220722115309.82746-1-lingshan.zhu@intel.com>
 <20220722115309.82746-4-lingshan.zhu@intel.com>
In-Reply-To: <20220722115309.82746-4-lingshan.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a71ffb8e-88ae-42c3-10e9-08da6be3e0f7
x-ms-traffictypediagnostic: SJ0PR12MB5485:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZ4qAXV7SIavixiWVlOkqf12PlDTO3t263RmWeTyPkc+ryMRFXOXGJB45K1ncCkdcJJ2VZI9GX4OQzxjSyvoBrmZyn2NzYuEIxBwtnnsMEhUKkYsVGW7874k80w31UU5BWzSNkWKM36I+95XSKy795JEVR1ptmLnrUUQdgPOlf+R0jhNffih8hrWMKOvwTlTM9MeRkHnNmJ9C61OCqYQraDnRe7j7YFBLXbUwRYGfRz6b77fchl+eBLr/qC99Oasd1YBhmKAc8cm1wHeEPuSVSFsBmovhqZIcQJGCtF/if5yyVSa4XB7DGtPO5yHOY/ARTf6SC/jPm1PLGLKz4ZWS9u6pIUEhL+bxMCFNnCpnK4AAP0Gq85GH33xJMDDHc9uh1n8ahM/qtppyfF/G/9YFrRI3W9+CUlPNvR/YBg8M15dCIf/rNQ2U+mtPGLMYkUCYYybRJS4H4NzNEz5tJ16QeceQDp3F6s+Jm/NVZt/C/33Ec27i5pk4eL1oYMv4DBjPMKPg2H2fYR9HT8XIHX7PAAqE260Xe5gBcNten3ywQjPyMoulJ8urxI1ZzeU9DXUeTd7ApL1hLbXVAK30CDUhJzANsZxnmYKjSHmmNu1hCb8jx/XZqZI94w1cXv2RpoUal1rJXudOyy39ViR5K9KTEqlgxH/yN9K+Z+IH9cErPzjxvuZVbrDzHXMt3V2tiJOfEtEZKV1BtS6e10t21d8BUqnnav5z44ie2ycNeqGgLZQOXPokroP0ezv1glzL76dNOZ/aBRDgiSdNg+/fqJCoCV1abhZrUXtK0KVx+vY28zadXPgxHybeXBQUUDGe++P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(186003)(41300700001)(5660300002)(122000001)(8676002)(66476007)(66446008)(64756008)(66556008)(66946007)(76116006)(4326008)(9686003)(6506007)(7696005)(33656002)(52536014)(8936002)(478600001)(26005)(83380400001)(2906002)(71200400001)(55016003)(86362001)(38100700002)(54906003)(316002)(38070700005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1vQ+D/rKlyivX4Xdx6YOmOhllaKMRi5TegfksBuaqPy/iG1PWGMnHta4XTaD?=
 =?us-ascii?Q?Dke3NIHil1KhhnLFFVaKeDHwtm0GQYQIPMve/Epni0oJdjhAgXesiBaps+Hv?=
 =?us-ascii?Q?nNj8NB6C3T2ma60r/ujGHOluPtzmUXB8NzIHDZ3N7VaCtKSfZpxoR5dV8eGc?=
 =?us-ascii?Q?G8OZZ/m1Dva05rd+1lree5hMB5JRZcl6LWdQOcurEh4YBoTqGEKB/UB1Aza3?=
 =?us-ascii?Q?5uQ+0o5azcyz1Wsnu5jR6wTao7Qyj+dfLMw5lSXdfBw68zzgvbbhfRy9cdz6?=
 =?us-ascii?Q?NY3LJYZ8anHMWj+CZw8S6nQ4CS+5KkO/cdWxkZTBjVOVZjKZkA+KZfIwbvWA?=
 =?us-ascii?Q?7KMbFYwMxF03vYiVzQ8v5+gAq4mqUoMFo6kjG0C4Q78V+o9NTrJlBdZHM5Lc?=
 =?us-ascii?Q?JYkvQgCeyH2r/mlQ83eiPkmnXBh1aGHfdBArO/aCqtoAX+Fqbx83Gy8ePLX1?=
 =?us-ascii?Q?n/miRzpATsEau6aGjvysIzHfOBk1PcoSV9IPSz/bqDOgwMbm2zzwBTk5riF9?=
 =?us-ascii?Q?1FBFuSh8U2djqKmXVZgA/C2qNviF4X6vPDQogNtGJRFhmnVFGJIFH2ZU4BTh?=
 =?us-ascii?Q?gpmuSLtrn1yeo5Wo4Y4K/5DJxzidi21PPTm5zChcGfhxRJ0u4Ahpk3hDeH5j?=
 =?us-ascii?Q?QmbESzkR0LOyXBRs1YOhi2sLGLOWxC4Ne8sHZiRKTWiQ6RjCmMQvI98nlZtz?=
 =?us-ascii?Q?l9qnSiB1JlEmfau+KefXRC92dPPmYa0NwOenqF3fp8TZYCXPjja8c/aGE21r?=
 =?us-ascii?Q?aOWpau2r27FnKVV4SXM85xIfUT222i2IBvfhpt1/CpdEblzbDZDUN3eZCFGJ?=
 =?us-ascii?Q?4Lj3DfAV5y3+RIyyMKXgZumObGTvoIY1W5GcqHMz/q8ZYUXilkAW5l6VkVWy?=
 =?us-ascii?Q?E4to8gpg94bt02K9hEqrBmJfbt6Tj3ptHOIj72L/PPyHNnQYPYSnMVYpWc06?=
 =?us-ascii?Q?WdXUqJX19qfOsbOBs6OG5atUscIIcQAvawA/6K3zuI6WuKDAt2wOjAtvQ9EH?=
 =?us-ascii?Q?YWi7LX5R167HP/1kS1E7ywFnp0cNRgGcgfizYXDtNX2UwmYmaiuGur1nRcfm?=
 =?us-ascii?Q?G0kHmkzCaj8YR6/LoBX+sSQ0FQDN5jUoZ+wMKB+RDKJR8u/cLK9SX5kQvfVy?=
 =?us-ascii?Q?QU77Xxhv0VKzQHVV6IyOwWj7q3EZNYGrhkAnWg9ZuZ0sYZ5OD955MzKlHbFI?=
 =?us-ascii?Q?CxNfsdvL4xF0UlZtqtn5CX1eWbQ7HeHmxOdulfjda4xXSznIZZW2rC8QEfMH?=
 =?us-ascii?Q?azFerVZQqEJaiV2v5Q5l2/aZlMm57vAhEO4b6A2GlQkUIkvmdTrOEwJxLaM3?=
 =?us-ascii?Q?NO/9AeiaFUyQWo/krHLmzULEvduGE2NUH5qelFwioDJWC8Gj1GYfGKvDS8qd?=
 =?us-ascii?Q?YSDsiLD28VNSeFATrqKkQKc3v/dgINk6N5UTsVuQLMooyewmIsik02fcjB/2?=
 =?us-ascii?Q?7jjFodqf/dRzEm9TWfvmoVMpaGxcZXyuipxVbXrIJxDE0EQNNplw8xJwCeOl?=
 =?us-ascii?Q?OhuhupDwkaH8MFQ42cy2hyfQNxXHmfxJJ48tbqMy4jcsE8qvcOP15MKWzS9C?=
 =?us-ascii?Q?f6fU6/cphuHdNdd72Sc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71ffb8e-88ae-42c3-10e9-08da6be3e0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 13:12:50.2070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/G+LhufemYa5/T7ZHBisSLs2LFXczxaRKroOY8CBjirC/A5FWEzk2SwiIf0xhstlXnQAc1915bHMevLdxS5YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
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
> This commit adds a new vDPA netlink attribution
> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> features of vDPA devices through this new attr.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c       | 13 +++++++++----
>  include/uapi/linux/vdpa.h |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> ebf2f363fbe7..9b0e39b2f022 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -815,7 +815,7 @@ static int vdpa_dev_net_mq_config_fill(struct
> vdpa_device *vdev,  static int vdpa_dev_net_config_fill(struct vdpa_device
> *vdev, struct sk_buff *msg)  {
>  	struct virtio_net_config config = {};
> -	u64 features;
> +	u64 features_device, features_driver;
>  	u16 val_u16;
> 
>  	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config)); @@ -
> 832,12 +832,17 @@ static int vdpa_dev_net_config_fill(struct vdpa_device
> *vdev, struct sk_buff *ms
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>  		return -EMSGSIZE;
> 
> -	features = vdev->config->get_driver_features(vdev);
> -	if (nla_put_u64_64bit(msg,
> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> +	features_driver = vdev->config->get_driver_features(vdev);
> +	if (nla_put_u64_64bit(msg,
> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> +			      VDPA_ATTR_PAD))
> +		return -EMSGSIZE;
> +
> +	features_device = vdev->config->get_device_features(vdev);
> +	if (nla_put_u64_64bit(msg,
> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,
> +features_device,
>  			      VDPA_ATTR_PAD))
>  		return -EMSGSIZE;
> 
> -	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> +	return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver,
> +&config);
>  }
> 
>  static int
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h index
> 25c55cab3d7c..39f1c3d7c112 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -47,6 +47,7 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>  	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>  	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
> +	VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,	/* u64 */
> 
I have answered in previous emails.
I disagree with the change.
Please reuse VDPA_ATTR_DEV_SUPPORTED_FEATURES.

MST,
I nack this patch.
As mentioned in the previous versions, also it is missing the example output in the commit log.
Please include example output.

>  	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>  	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
> --
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
