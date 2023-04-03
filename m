Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D821DC76188
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 16:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52649408AC;
	Mon,  3 Apr 2023 16:59:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52649408AC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PMnlYU2k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WdLbSTW4n8VF; Mon,  3 Apr 2023 16:59:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 42544408F0;
	Mon,  3 Apr 2023 16:58:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42544408F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10434C0036;
	Mon,  3 Apr 2023 16:58:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DCAFC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 16:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5821C409B1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 16:58:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5821C409B1
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=PMnlYU2k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0YukHXs64jf
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 16:58:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B83E4017B
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::616])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B83E4017B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 16:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAGVUpLfKdKNqaZKr9/G9GE8CdOOHrgXpsImE5xg6iA3P2o04D4JBPWVsAnVtGMX3OeObhRh4SZoUMQWqYQhB1iqfYKK0IbfpVMJMZjdOQbD1Rq6YhZtjlcAdhX2RBW2ZJA1eo3YKoINhqVSuB9OxCWAoZPE1tI3b+hjd+bFbh6/4swlXDkVozhj3uUcAorDfYanPyDp4UyYgycia9MYFnCmcG1/iaQhQsyzcd00oJob2kGyRqd5ii7rK5Um7T0BTF2D1r6s950m9mVCeUubI5DViD3pakuXmjuqMj5/SiGR9+nFuB86L1OwGRpS/atjKHcKd9RK2mpZcdidwXodOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU+PWvPPb+2INwirUZPwmLetkuFR0AQu8zormDzQHtw=;
 b=ansOLjEDa10HLVBvHgfcaFONLINmS+cm4ILF7HYoqdgP5TMxmqqsQ4Q/nEj4Pn65JWPXTNd8Z51P062WB+nEKpNpSPfngWK6SzAfrDXjCUwz/F7gh/JjujzN5cgIzpTxAzwuhr/F4tqqz+05OE9PhfTOHv8laacJxYt2G1+fkAr/n6Y9LOZpam1XMISQfUSl8Hz6iEwvElAF6c2Lx3mv48jRRuzUR2G/f9qb1XYPd8wuIwJol1Or0cR3QxiFK2HUdtbDI2zkqcGgknho6bdwAwhJ4X1x31RPgThkNx26iYAxiovwiits1yod/fQepo+Bw7su0m/fuTdG9zfzLXucWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU+PWvPPb+2INwirUZPwmLetkuFR0AQu8zormDzQHtw=;
 b=PMnlYU2kmeGyQWWsygI2Zq1+z/u9zu/OEcZ9BEg560faXaTmnFuLG8m2qEN7/EUUENZN0yUmpRQ4pfyw2NN502/6khMqTzZ4iqKJKvYtDSjimmJiXDc/P6ZWcBX61ffyJIbtUMVw0M50jeuo9rbSKZAseUP9ha8IwTV4ViK7IkiDEdGhUIH5ebFz7LJeLmcwV/Wo22Hj/HU4DPYM1FBKuvC1K6ilRP824fewJhW3fyhLtCJbcJWnJWjCJ2Hx6jA7J33dscXR+9OkfVQ2v4SwXus/GE1smeNuVT19qypfhiGe6rIsYpRTaNS0zev0VdFy726kvByqmW/qLhZL8USfYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 16:58:53 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ee61:8dc4:14c8:7cbb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ee61:8dc4:14c8:7cbb%7]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 16:58:53 +0000
Message-ID: <dc8595cd-f641-9ae3-4841-736175a4484f@nvidia.com>
Date: Mon, 3 Apr 2023 12:58:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/1] vdpa/mlx5: Support interrupt bypassing
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20230403162039.18932-1-elic@nvidia.com>
 <20230403162039.18932-2-elic@nvidia.com>
In-Reply-To: <20230403162039.18932-2-elic@nvidia.com>
X-ClientProxiedBy: SN7PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:806:f3::17) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: a39587de-3a28-4e02-02af-08db3464b450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyXW8orZMfF+yq0BnraTivs5pNIHgrK+JphRzBrYSgJWSQ6iB2uzPtZFCPo7T4KR0uq2q7hh/6ayiIRXJ4NlDhC3gASEDdDsDsF9ngYvGAqMKvoRwagWaQQwlHe3X5nzwMA3lRA+TYpR6pxfQeMhRElPFYnAmEr40kKtzhO6QobGMVs8qimd8nUFESoWi5iOJn0Du8PaOAv1bB3lXsLF+fmWEUvE7ua/LMGAqJNhu0NlrJeZ8e+/OGKVK1bkl49Fd8avgsbQ1zBDDoYIhzTWsAzwwtjLJIDVaV/XGYUUHUdyf9uq5gslpEHc2vg7epCylkSjfFhoVtLdLzX3JnP4+wrWDhakbxbYhihK5pqU/nAun8LZYqJ4XDHkoonA8Viau7C46J+TIapefx72vKN0MmzCwmisNVv5Cq9zh/hoh/Ov9agGZ3HyS392ptbnN7hDhF5m4U+B+7b/WmZYIY6Ly/MsI6Rfp0CIeyv92N9rgNFbleJ/zae3hIeEMgCQjV3zBsXxCufLEq+91laDIt3KLkL0rUmcWia3r6uidoVF+ihZHJsA7GApfw169ZSWhEnhUUPjwU0MsUAZGEGmxyORAnHeFDWToUZTMf4SegqYhmwDM2ukO5KTC/PlJTxL2Yfg8JKXszhVtpYGw0KZE37cNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(38100700002)(66899021)(31696002)(86362001)(36756003)(2906002)(53546011)(107886003)(6666004)(6486002)(186003)(6506007)(6512007)(41300700001)(26005)(66946007)(66556008)(66476007)(316002)(31686004)(4326008)(478600001)(8936002)(8676002)(5660300002)(2616005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk52WTY1OFZ6TXNWQnRGTEhhVkFRZmE2Zis0QnRna3BaN0lsQ2hFTUxuZ2JF?=
 =?utf-8?B?K3NTdGxGTFpKK0JvN3hHUUJhYmZtV2ZPN2JKeDVRV1U4Y2ttcDMwTmlER1BU?=
 =?utf-8?B?MDdYa21IWnk4RkhxRkRzSlNrSks0eDlMN1FyZllmREtYVHplNlFHKzNqMW02?=
 =?utf-8?B?YnNIeTIyZW1tMVNxL1U2cmtaMTVSdXowc05BOFhSbDR4NDJhdnkxaXpBTHdJ?=
 =?utf-8?B?OXc5ZVZLRnhJcDFuVzlKeVZVVDkxVXVpT0x0cnVOVEdBRUpBTkpxZDZuL1Ra?=
 =?utf-8?B?OVBVTW0vR3E1aVpsM3NFS09VSEdvVWpNOTd1NmpjdGNkTG5mdmo4T1JrZm42?=
 =?utf-8?B?UjU5Qll4SFMxS1FHTmhCNUk4N1h4Mit3RVE5c2lHUVZ0ZmhCbFpobUU5NkJ5?=
 =?utf-8?B?bjcvZGZDcnQrTXF1bTNESnVMSUlTQzRUcUY3WmJUcTY2RUNES1N6SEx3TVQ5?=
 =?utf-8?B?ZmdGSm1UOEZnYjJxWVhqaDJFU1pTSTRzUTJTZW5obzNBSkxLaDAxYkZ6UE9m?=
 =?utf-8?B?UkJzUkpxYVVIU0swbW5xS2trdFhzL2RJNkdsWm5MR1hJMHFvQW4xY29lRzBH?=
 =?utf-8?B?dWV1bUFVR2xENlR2bklnRTJrdVl6Z3NoOHBWU25NR24vdE9zQnJ6SlBla0F3?=
 =?utf-8?B?NDRYSGlIRDErOUZQNnd6ZlVRRGV2N281N051REdGSDRDeW5PZ1lxR2RLdnhM?=
 =?utf-8?B?Z3ZvQXlWU3BtbEUxUC9XWVRKenp4OWJMOTYzbFhWeEhGdUNINUZKMGFtS2Jw?=
 =?utf-8?B?c0I2bmFCZGt1aElPZHZGODMrcUg4UnNGM0lHSDkveGczN0duRVlIc05IcUFO?=
 =?utf-8?B?OVk5UUlqekk3QUIxcFBIdXhGMy8yU0g5Q25JZi9Wa2hMaVVzVHNaSHhFR0xn?=
 =?utf-8?B?MjVjVVpNdWlKa2dlbFlBVzRWNlZwU1Y4N1J0Uk0vUm0yWjhmdUtVRlRFTVov?=
 =?utf-8?B?a3hFYjBIWWZRK1gyU1VSZ3ZIS3N0dFZDS2ZRWmh6NEVvQWl2bW4zd1hyZGtN?=
 =?utf-8?B?NWwrYy82V0tMUHRtMGh0WDVneDFCcjBDUE9XOXMwRVpJSVc4Z3FWSVdHU2xu?=
 =?utf-8?B?ZkpCU1NOMGYzNkEzMDhWUmxpMDVudm10UThYSzMrRHN3QnRhNDBldjBLd1hV?=
 =?utf-8?B?ZENzTVBQb0JHK1BUbnpRMkJPL090SGJka2hlK3VIVUw0RHVLVUI3elFHV0ph?=
 =?utf-8?B?NzZiWGFqdDFrT0F0ZGI4TjVhalhlYytUL3c0SjVkUXMySS9EUE9Mb0o0eThV?=
 =?utf-8?B?cmFBYktodTExY0syVlpTYTNRbWZQcmxRdHVkS2JEQUVTdEMybkd3dnM4Vk9o?=
 =?utf-8?B?TXBqcUk2eEwzY05RaVcrbEdrV2VuRlBadG81cjQ4Rnh6clBSUkZ6YWJ1T2NX?=
 =?utf-8?B?dmtXUW03d2N4amJMa2Z4V1kvRitTY25idkpzSlgyMVAwWkhxODNxTm5tQXBJ?=
 =?utf-8?B?WldycDVSRmFCSERqcG5yN0N3VHVpRDBuTm9JczRpT3AvcyszVVlEL21BZzJ2?=
 =?utf-8?B?RFptSVp2M1pZdDZ1RnVNVFkzL1ZaMWN4Y2RQNUV4SGwxbFgybHBZUjBEQWVz?=
 =?utf-8?B?OVdrQ2FBMW5DQmVRTzREbHJSZmFWM0dNWXR6eHZWckpyT05ZY2pqcnRzejhs?=
 =?utf-8?B?QzFOMjVxTG9lTEwwalU1K3BkSER3RTNINlhJQzM5U01RSlM2clBKRi9BeStK?=
 =?utf-8?B?VUVjQXNmSTNLWEhEMTR6eGJ3K0NxK3lkSjVsRktFTWdhYVZYUE9oUEVDVlFT?=
 =?utf-8?B?MUVvNDRBQ0VYUk8vWDhMRHpRbDEwSk5HQ2hKeXdFVi9zOHcrZUt2ZXlGZUtK?=
 =?utf-8?B?Q3REYk5RN0RzYVVRRWFoMFdtZ1Y2TDJVai94VEtHd3I4ZlBIeHI3VUxMZ2xn?=
 =?utf-8?B?RnQ1MDFMUENJSzRWQTN1R3ZGb212Kyt0a1pXY1JzOUV0R3BkeDE5RXZTRENL?=
 =?utf-8?B?Qk9pWGs1TWRYc0VMb2M2MlJPeks5TVgxN1F6MkxRU3lHSTFFenhaT2VjYkJr?=
 =?utf-8?B?N2dJdHNmckFNS2RRekhoWmxveW4xYzdKVXZlSDBkT0o5ekh6MlE2dVVVM1dB?=
 =?utf-8?B?NW1raWVVZFZ6Zm8zaDRxN1lnUmVXZHBwYk5BWk1CblJPOCtzM21ETDNLbHFZ?=
 =?utf-8?Q?vrx1c9VKjXZDXDiCsYreLKAlq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39587de-3a28-4e02-02af-08db3464b450
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 16:58:53.1381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb4JKKdGrNz80RwIjPFFt5bCgpVeKyivL8vt6pWqUhvegGbDfaR2OtMdVKxOWRHPBbg7/DmCdz5wyWdkj0g+3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
Cc: Saeed Mahameed <saeedm@nvidia.com>, parav@mellanox.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 4/3/2023 12:20 PM, Eli Cohen wrote:
> Add support for generation of interrupts from the device directly to the
> VM to the VCPU thus avoiding the overhead on the host CPU.
> 
> When supported, the driver will attempt to allocate vectors for each
> data virtqueue. If a vector for a virtqueue cannot be provided it will
> use the QP mode where notifications go through the driver.
> 
> In addition, we add a shutdown callback to make sure allocated
> interrupts are released in case of shutdown to allow clean shutdown.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 139 ++++++++++++++++++++++++++++--
>   drivers/vdpa/mlx5/net/mlx5_vnet.h |  14 +++
>   2 files changed, 144 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 520646ae7fa0..215a46cf8a98 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -83,6 +83,7 @@ struct mlx5_vq_restore_info {
>   	u64 driver_addr;
>   	u16 avail_index;
>   	u16 used_index;
> +	struct msi_map map;
>   	bool ready;
>   	bool restore;
>   };
> @@ -118,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
>   	u16 avail_idx;
>   	u16 used_idx;
>   	int fw_state;
> +	struct msi_map map;
>   
>   	/* keep last in the struct */
>   	struct mlx5_vq_restore_info ri;
> @@ -792,6 +794,13 @@ static bool counters_supported(const struct mlx5_vdpa_dev *mvdev)
>   	       BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
>   }
>   
> +static bool msix_mode_supported(struct mlx5_vdpa_dev *mvdev)
> +{
Better to have const struct. It makes it clear that it is read only API 
and there is no accidental modification of hca cap or other fields.

> +	return (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, event_mode) &
> +		(1 << MLX5_VIRTIO_Q_EVENT_MODE_MSIX_MODE) &&
> +		pci_msix_can_alloc_dyn(mvdev->mdev->pdev));
> +}
> +
>   static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   {
>   	int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
> @@ -829,9 +838,15 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>   	if (vq_is_tx(mvq->index))
>   		MLX5_SET(virtio_net_q_object, obj_context, tisn_or_qpn, ndev->res.tisn);
>   
> -	MLX5_SET(virtio_q, vq_ctx, event_mode, MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE);
> +	if (mvq->map.virq) {
> +		MLX5_SET(virtio_q, vq_ctx, event_mode, MLX5_VIRTIO_Q_EVENT_MODE_MSIX_MODE);
> +		MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->map.index);
> +	} else {
> +		MLX5_SET(virtio_q, vq_ctx, event_mode, MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE);
> +		MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->fwqp.mqp.qpn);
> +	}
> +
>   	MLX5_SET(virtio_q, vq_ctx, queue_index, mvq->index);
> -	MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->fwqp.mqp.qpn);
>   	MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
>   	MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
>   		 !!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSION_1)));
> @@ -1174,6 +1189,32 @@ static void counter_set_dealloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_vir
>   		mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n", mvq->counter_set_id);
>   }
>   
> +static void alloc_vector(struct mlx5_vdpa_net *ndev,
> +			 struct mlx5_vdpa_virtqueue *mvq)
> +{
> +	struct mlx5_vdpa_irq_pool *irqp = &ndev->irqp;
> +	int i;
> +
> +	for (i = 0; i < irqp->num_ent; i++) {
> +		if (!irqp->entries[i].usecount) {
The usage appears to be boolean.
So better to rename it from usecount to -> used.
used = true/false;

In future, if you plan to reuse the same vector, may be at that point 
usecount makes more sense.

> +			irqp->entries[i].usecount++;
> +			mvq->map = irqp->entries[i].map;
> +			return;
> +		}
> +	}
> +}
> +
> +static void dealloc_vector(struct mlx5_vdpa_net *ndev,
> +			   struct mlx5_vdpa_virtqueue *mvq)
> +{
> +	struct mlx5_vdpa_irq_pool *irqp = &ndev->irqp;
> +	int i;
> +
> +	for (i = 0; i < irqp->num_ent; i++)
> +		if (mvq->map.virq == irqp->entries[i].map.virq)
> +			irqp->entries[i].usecount--;
You should add return here too like alloc to not go over rest of the 
entries once a specific vq is taken care.

> +}
> +
>   static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   {
>   	u16 idx = mvq->index;
> @@ -1203,27 +1244,31 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   
>   	err = counter_set_alloc(ndev, mvq);
>   	if (err)
> -		goto err_counter;
> +		goto err_connect;
>   
> +	alloc_vector(ndev, mvq);
>   	err = create_virtqueue(ndev, mvq);
>   	if (err)
> -		goto err_connect;
> +		goto err_vq;
>   
>   	if (mvq->ready) {
>   		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
>   		if (err) {
>   			mlx5_vdpa_warn(&ndev->mvdev, "failed to modify to ready vq idx %d(%d)\n",
>   				       idx, err);
> -			goto err_connect;
> +			goto err_modify;
>   		}
>   	}
>   
>   	mvq->initialized = true;
>   	return 0;
>   
> -err_connect:
> +err_modify:
> +	destroy_virtqueue(ndev, mvq);
> +err_vq:
> +	dealloc_vector(ndev, mvq);
>   	counter_set_dealloc(ndev, mvq);
> -err_counter:
> +err_connect:
>   	qp_destroy(ndev, &mvq->vqqp);
>   err_vqqp:
>   	qp_destroy(ndev, &mvq->fwqp);
> @@ -1267,6 +1312,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>   		return;
>   
>   	suspend_vq(ndev, mvq);
> +	dealloc_vector(ndev, mvq);
Should be destroyed after destroying the vq to keep the cleanup as 
mirror of the create flow.

>   	destroy_virtqueue(ndev, mvq);
>   	counter_set_dealloc(ndev, mvq);
>   	qp_destroy(ndev, &mvq->vqqp);
> @@ -2374,6 +2420,7 @@ static int save_channel_info(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqu
>   	ri->desc_addr = mvq->desc_addr;
>   	ri->device_addr = mvq->device_addr;
>   	ri->driver_addr = mvq->driver_addr;
> +	ri->map = mvq->map;
>   	ri->restore = true;
>   	return 0;
>   }
> @@ -2418,6 +2465,7 @@ static void restore_channels_info(struct mlx5_vdpa_net *ndev)
>   		mvq->desc_addr = ri->desc_addr;
>   		mvq->device_addr = ri->device_addr;
>   		mvq->driver_addr = ri->driver_addr;
> +		mvq->map = ri->map;
>   	}
>   }
>   
> @@ -2693,6 +2741,22 @@ static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
>   	return mvdev->vdev.dma_dev;
>   }
>   
> +static void free_irqs(struct mlx5_vdpa_net *ndev)
> +{
> +	struct mlx5_vdpa_irq_pool_entry *ent;
> +	int i;
> +
> +	if (!msix_mode_supported(&ndev->mvdev))
> +		return;
> +
> +	for (i = ndev->irqp.num_ent - 1; i >= 0; i--) {
> +		ent = ndev->irqp.entries + i;
> +		mlx5_msix_free(ndev->mvdev.mdev, ent->map);
> +		ndev->irqp.num_ent--;
No need to reduce num_ent here.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
