Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F569449B1A
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460192; cv=fail; b=Iipn9jk+rSeCBWDt7SdJy3EsjfJo5k47M2Np1yw48XG/iyp++NUYIPKHKZ/+mB46EAgnYEk650EZopz/PK/6tI2tIe5d2k1qasCKEIzYRXTW8iJ4ueBKpJvKvHhq/WHJ5DUpDF8BwaroupBSD1YDCAP4tPNXStguEf7T4OCpEGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460192; c=relaxed/simple;
	bh=J5SZ8xaUwHPKLof2AfYObAV/wpWXOfNB1S/TAyyiPeM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qcm8bnkYmuAwY+XmBr8vq8qAp0UqUJ2eVNj2thxVPiTJ01zypMnin/9NGF3pwLP6v/t97AWGZ8hCER2c0HTjFHFURBSOR33rHHoyYzcctP54XFnnOEH5xgXWDZSksaUasXkkFMmEAhjIWJ4PKo5Zb4jg6b9gqclcL7sVW4itJhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mqh3gmjC; arc=fail smtp.client-ip=52.101.57.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mqh3gmjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Amspj14dHeI/d2sOhruUeCwKJOXx19gqC9wcynfJoGg13eg8ejlgip8RQ7C1R8N6uF3/dIU+WttOKsUEeuPWtXI601xqnEBbvcKdtxAvbc5Px/1tUzzaeqY1oobW8rvpJjDB0Ux2Nzo0/B0vgVQ2x7YBmdMUfRcfY5uVlhu6maE5mnwUbsLMNJkNV7ziek0CssDtVi8AioJ2gifIhiwoF9t/Om6rwLRHcQUZ9Sr6VPBvFH841kzCcEkGdW5ulR2Lysz8vMPW0n9yo9501GA3pYxBRrXNZ3NmzUX7VzdDB6G0de7Uy5nLfkLld42pgEMnexjaySuO2IwqU3S3I2PGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBQZStdeIuflqCkqQ62N2yaQN69ly2lVEnb0HXUzWnU=;
 b=MTcjy71BRFvBdnJlPB7xBx34Daqj3gNC5KSyEZ3PgyNdQHUvJQZ7zilAy/oAtx1GlqKxLWtusKi9wrDz0LfPeBOt5I3crXTmq7NuzTjvDe3+HlKJkfX43H9dR9FXP7kP8+BrnnaG9rrFEspA8QMd/93oGBffDPwpRirS6nsA+4Dsgi0h3LC/4MzjqhWbOg1fjMXf8iVu/Eklv5nisRips6urSB8e/8qGP8+H+0XOOOmxd14pwrPT8XMRefHawqGxYUOmELHwaVuqc/Mno21oB8fo8kcfeTGBD+4uI5o6moZZWyhynOh32IqNR01kFDyqlhO4P60wjJuD/6hICh4yyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBQZStdeIuflqCkqQ62N2yaQN69ly2lVEnb0HXUzWnU=;
 b=Mqh3gmjCdqYGe6KUScO+g73I/QOeA6KtSaMmbAHuWoRNYfJ52YCHF6vKOhEpe9wMVj3hqcbelmDNm+slSpW2CgJRTIgw3uuqoBrDxxbBWidIrneZvMxM2pvmlhwyerv0/v5BGz/NcFSfK/UxMkq3SaSHt7pEYVz2XJ6MNqW+IuK8hDW4foR/9T/eX0HixaZRgR/I/PoZZ6bN3UcSfJCENnfoM514h9EtBLRE2lfXrKnpM2YaL1DXQ57ekL2fC1Qg7FZmU4bbeUND+7gRNx6f8cJEr9lWXImpVe6rPXTmyORVx7OExDOvmWlm4RbYufRm8zzf9dj+qJ946RBlJymB+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Tue, 11 Aug
 2026 14:56:20 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 14:56:19 +0000
Message-ID: <2cc944a3-7f81-4fc8-bc3a-cdf42292d4df@nvidia.com>
Date: Tue, 11 Aug 2026 17:56:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 05/13] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-6-shshitrit@nvidia.com>
 <20260803114115-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20260803114115-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0403.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::9) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdd3e28-0555-4289-ee44-08def7b8b3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|56012099006|6133799003|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Uj1C6O2lOOyejNH39Cgoq8YOai3TdyowqTzIdK5NTpnu4eGXePct7ZXS67KgRAbPATS3kbNgssKzErexNlVz/hZv+UKLo5vzHFTjOu8IQQnuG40DWITRtv2KSKrotnkqhYoibXJqUPhQT6+khp0w8SRtcffO+BjH9HxPObeM/ErNTIssZLsnx8kCPJQOP+G3/QcCtGX6GW3AURNBAuTruSh0L6+G+NQDNScdsb7y1cSsEiQPPZOn+gqBL1CRElg4D9efMp3QpUxy5pt2cd1q2eyLYCKa8r4fwyhnY3pa/A2BYpmF2evDBf/m06b+3UBxu9p2vYhECCRVYo5GQO9aKA6A4Ws4Zhy6SeS+5BnQLZd0kQChOgiwNMNSfXuiGzaBOHO7vgq2RHfgecavd4vZHMNT3uKvXoOhcRqnW7RdoNm68g16FlWnpS7VKLF2/lfiuPcxoRWpoBW/v3fvarGQme3aXl/9eivWR30r9gjFMP2xDVGosWJOj8CMlNCDmniAYL7/3E2qr4ygxwtHUrjYmfkiAmWnyE1kcpCvKFCcwSb2TIhc8CbkJLuMI3FJEjL2wBhtCiVq8iKTkB3lnrd/rb/WFQ/WxcOXdRz/Hibds49Ku0o7kU3xyo9AX9UryWOu3pvi2x8hiweFWvsBM4nsp50VU+vf8bTFWxpIPNv+w2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkhKaVBYNjYzbUVhdFNqZ0FmQVZFVGEzbnJkTjNjYjR0RzZKRDJyUHdLSmxy?=
 =?utf-8?B?bUkvMis4RmpIbFk2Mms4K1hvc3doWGZRbzNmL3hXVXZMN2t1S1BrY2trSGJn?=
 =?utf-8?B?L0JlK2srczhMeXFvemc1NGpYZnRnVGEvUk9qeHZlNm4xMFZINkJtbkxwSEha?=
 =?utf-8?B?ZUprRDh4YTBWZTl0WHlyL2hab0R6b2E2eisrTnVnazR0Uzg2bXB6TFdNNmxw?=
 =?utf-8?B?dGNoTGxWUHlvME9SQUFVVk9jWTh6a1dUcENTSlJZRXJjZmhUdXNIMy9uVmQ0?=
 =?utf-8?B?UXg1dVlOMEU5L1dYUEVibVhaTXhNNmNZRTRBZHpSNXBWd2x1eTNGS1FaZUpT?=
 =?utf-8?B?WWw5d2hUckM0NE9nYmFJOGlCVms0eUZlU1c1MkFnT3hZeWxnL2J2bGR5Qzlo?=
 =?utf-8?B?Q0E0MjBwcVRYNE8zcWttM1lINjBtS3ZBSE03ai95dnVFdzRxdHFjbW1vYmN6?=
 =?utf-8?B?ZmpVTUlRZnlNZTNJMktUN2gzcktpaWRUaGFqUEZuK2xlZXVTV0JnWFJMcisr?=
 =?utf-8?B?UThneVZmVDlxd1l0WlFIUjg5amgzNCtJQTcyd2J3YjZrWkRxaTZFa2srRVZ2?=
 =?utf-8?B?ZEFFK1NqSURZeUZKOXM3b3lMcXRkK09PTEE4VjhyeUlMQnhGNE1wbFdxaGxH?=
 =?utf-8?B?RWZlb0xGSmZqelp2WWsvajRDK2c4dXRJd3JIb2I0Q0Q2bWJ1WTNxdS9aR1Ew?=
 =?utf-8?B?ZHd2QURacEkzcnRpb1lscU5NazlRd0hVblFOYkVkdmY1d1RBeCs1YWxpOE53?=
 =?utf-8?B?MVZBaEcwNXZWcG01SnVxSTViSXRjd2xIRE05OGZjQ0RjdU9WYzBraWZLaFlO?=
 =?utf-8?B?a2I3ekdVbmk1ZUR4RkViT1dGSTBpUzkxdnpldTNHNmQybXArb3Z0NW1hR3Fx?=
 =?utf-8?B?UTlMaG9tdWtmbk9LY2ZXUFpndlZ0VWppOFFmdGtacGtBUjdzL3NiUkd2RGhz?=
 =?utf-8?B?VzVLc1JRQk9vZ0N2SEYzNmhlUWo4ZW9vVDdVWUJzamxpRHpma2s2L2FwNUJY?=
 =?utf-8?B?ZUhjQWF1T3Uwbm1yZUpzNzE5OVU2V0pTMjJJeGFFeDZRZFB3YjRrVERqNXZz?=
 =?utf-8?B?dmJYVHJRTm9hVXhWWUZrUmhCODN3ckpUd214cGxsdUwwZGlaM3YydlU0NWN5?=
 =?utf-8?B?d0VtNHpjS1VCT0ovOGxIdGdRQ3FCYW16dXNTcDlGOVNwTzlhNzVwOXcxQml6?=
 =?utf-8?B?Vmd5dFJCUHhJRUNla3BwNUc0WXhhVlFEYUhmWkVzdExvS3Q3bVRySU9mRHdo?=
 =?utf-8?B?VlRtd2pjdThtb0Uyc2g4dGNpQjdNdlFpYWEvYkNJWkp6dUtzZkJjSzh6Wmkw?=
 =?utf-8?B?ZG5CTy9DQ3NKTTQzTnBDMS9mUGc0dTN5RWMvWTdORVBkUDJpK0hiZVZBLzRT?=
 =?utf-8?B?TGU0M3gxcG1PaHRUakwrNmM0NGdDeHRTcXlQQzJIdWI2VDJkRGYxM05qT1NO?=
 =?utf-8?B?RktCOWtVRXlwcGhWVVUrdzA3eWlQTFdScy9idzBqckhYcFE0cUcxKytGUFZ1?=
 =?utf-8?B?RjVJNmtZSGlPQmpJdEQrZ2V2WDEwKzlpNUs4dkg4NXlwZFZqN3dOcnFQWEZC?=
 =?utf-8?B?a1ZFcDZlSWZTbUxrY25TQVpFaFlweGNEYnNDYXg3Z1psSDRpVm5aN1JFS0Vk?=
 =?utf-8?B?eFdqUlB4WmxDWkVVbGppT09KeHFxNkRhTE9jM1BCSDQ2WUpIQ3ZYZERmZXVF?=
 =?utf-8?B?S2lySFkvOHJkRXJWc0pmQkFHTU9xUEs2TzFlMmJpRUlVZDhmV1ErTEN0akVT?=
 =?utf-8?B?UzZWWUJoQ0xtTm4reVI4N1J3SzdwdjlTb0VJRzkvK21VNW1RU2tXb3RPTnlj?=
 =?utf-8?B?eklhRXFMN1RMSE9OeGNJNVYwS3ZCVmE0dUp2YUVkd0dsMkt5UE9CQnJFbVFM?=
 =?utf-8?B?Tks4SEhmNmJQak5sZHBKcE10bm9PZDNYdkUvNnREYlN2SnZLUHl0Y3lUNW0v?=
 =?utf-8?B?N3E3V3IxSkFEQk5IK0RvSFhNYVJZdm8yZW9zcjBtaHhDZHRFUmNMaVBvM1Qr?=
 =?utf-8?B?UHpKNFUvRU1Za21TekpxOWNjUlAvSkJDWDVHSFFvYlk3N1hrc3o3Z0xHNUhj?=
 =?utf-8?B?WE9wV2pCK3hSb1FEcnNucDVFS0ZpK2ZBdSsrZForK1lwcVdDWHo4cUFZakl4?=
 =?utf-8?B?SUdEV1d2dHAvekVZSEdHRXBoTjlPRCtyMU1OY0VGZGUrUFd1ZWtEWlJQTHpn?=
 =?utf-8?B?ZEdhdEhqL2lDTHFmenhvK01Xb09ETmlGalFFajNJdGU3MlByd2xxRnkwTUU2?=
 =?utf-8?B?M3ZWODFFZkJ6cFEyRlVaN1ExQllKQkRBQkY3K0xYT0VnYWVCYmt1Y1RnRkdS?=
 =?utf-8?B?dGJYMjZhZ3FuZWdtd1lqS1pGNDEzc0xzRzRxaGN2dFB6NFpoeUtkUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdd3e28-0555-4289-ee44-08def7b8b3ce
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:56:19.8741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWIVBa7MkW3o7EBst4HPWRVX5LbsZNSdv9raHjZhIE1legQ1p66/7cTb0Y7FisJJuPuAG30x3Dw0nHqAqsMJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375



On 03/08/2026 18:51, Michael S. Tsirkin wrote:
> On Mon, Aug 03, 2026 at 05:07:13PM +0300, Shahar Shitrit wrote:
>> When probing a virtnet device, attempt to read the flow filter
>> capabilities. In order to use the feature the caps must also
>> be set. For now setting what was read is sufficient.
>>
>> This patch adds uapi definitions virtio_net flow filters define in
>> version 1.4 of the VirtIO spec.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
>> ---
>>  drivers/net/virtio_net.c           | 239 +++++++++++++++++++++++++++++
>>  include/uapi/linux/virtio_net_ff.h |  91 +++++++++++
>>  2 files changed, 330 insertions(+)
>>  create mode 100644 include/uapi/linux/virtio_net_ff.h
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 3e2a5876c6c8..0d1f5a6cfd12 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -27,6 +27,11 @@
>>  #include <net/netdev_queues.h>
>>  #include <net/xdp_sock_drv.h>
>>  #include <net/page_pool/helpers.h>
>> +#include <linux/virtio_admin.h>
>> +#include <net/ipv6.h>
>> +#include <net/ip.h>
>> +#include <uapi/linux/virtio_pci.h>
> 
> why would virtio net need pci macros?
it is not needed. will remove
> 
>> +#include <uapi/linux/virtio_net_ff.h>
>>  
>>  static int napi_weight = NAPI_POLL_WEIGHT;
>>  module_param(napi_weight, int, 0444);
>> @@ -282,6 +287,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>>  };
>>  
>> +struct virtnet_ff {
>> +	struct virtio_device *vdev;
>> +	bool ff_supported;
>> +	struct virtio_net_ff_cap_data *ff_caps;
>> +	struct virtio_net_ff_cap_mask_data *ff_mask;
>> +	struct virtio_net_ff_actions *ff_actions;
>> +};
>> +
>>  #define VIRTNET_Q_TYPE_RX 0
>>  #define VIRTNET_Q_TYPE_TX 1
>>  #define VIRTNET_Q_TYPE_CQ 2
>> @@ -474,6 +487,8 @@ struct virtnet_info {
>>  
>>  	struct virtio_net_rss_config_hdr *rss_hdr;
>>  
>> +	struct virtnet_ff ff;
>> +
>>  	/* Must be last as it ends in a flexible-array member. */
>>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
>>  		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
>> @@ -519,6 +534,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
>>  static void free_unused_bufs(struct virtnet_info *vi);
>>  static void virtnet_del_vqs(struct virtnet_info *vi);
>> +static void remove_vq_common(struct virtnet_info *vi);
>>  
>>  enum virtnet_xmit_type {
>>  	VIRTNET_XMIT_TYPE_SKB,
>> @@ -5710,6 +5726,199 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>>  	.get_base_stats		= virtnet_get_base_stats,
>>  };
>>  
>> +static size_t get_mask_size(u16 type)
>> +{
>> +	switch (type) {
>> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
>> +		return sizeof(struct ethhdr);
>> +	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
>> +		return sizeof(struct iphdr);
>> +	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
>> +		return sizeof(struct ipv6hdr);
>> +	case VIRTIO_NET_FF_MASK_TYPE_TCP:
>> +		return sizeof(struct tcphdr);
>> +	case VIRTIO_NET_FF_MASK_TYPE_UDP:
>> +		return sizeof(struct udphdr);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>> +{
>> +	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>> +			      sizeof(struct virtio_net_ff_selector) *
>> +			      VIRTIO_NET_FF_MASK_TYPE_MAX;
>> +	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>> +	struct virtio_net_ff_selector *sel;
>> +	unsigned long sel_types = 0;
>> +	size_t real_ff_mask_size;
>> +	int err;
>> +	int i;
>> +
>> +	if (!vdev->config->admin_cmd_exec)
>> +		return -EOPNOTSUPP;
>> +
>> +	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
>> +	if (!cap_id_list)
>> +		return -ENOMEM;
>> +
>> +	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
>> +	if (err)
>> +		goto err_cap_list;
>> +
>> +	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
>> +				 VIRTIO_NET_FF_RESOURCE_CAP) &&
>> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
>> +				 VIRTIO_NET_FF_SELECTOR_CAP) &&
>> +	      VIRTIO_CAP_IN_LIST(cap_id_list,
>> +				 VIRTIO_NET_FF_ACTION_CAP))) {
>> +		err = -EOPNOTSUPP;
>> +		goto err_cap_list;
>> +	}
>> +
>> +	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
>> +	if (!ff->ff_caps) {
>> +		err = -ENOMEM;
>> +		goto err_cap_list;
>> +	}
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_RESOURCE_CAP,
>> +				   ff->ff_caps,
>> +				   sizeof(*ff->ff_caps));
>> +
>> +	if (err)
>> +		goto err_ff;
>> +
>> +	if (!le32_to_cpu(ff->ff_caps->groups_limit) ||
>> +	    !le32_to_cpu(ff->ff_caps->classifiers_limit) ||
>> +	    !le32_to_cpu(ff->ff_caps->rules_limit) ||
>> +	    !le32_to_cpu(ff->ff_caps->rules_per_group_limit)) {
> 
> I am not sure why do we validate these specifically.
> 
> Should we then validate selectors_per_classifier_limit too?
there's no special reason. will add a validation for
selectors_per_classifier_limit too
> 
>> +		err = -EINVAL;
>> +		goto err_ff;
>> +	}
>> +
>> +	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
>> +	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
>> +		ff_mask_size += get_mask_size(i);
>> +
>> +	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
>> +	if (!ff->ff_mask) {
>> +		err = -ENOMEM;
>> +		goto err_ff;
>> +	}
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_SELECTOR_CAP,
>> +				   ff->ff_mask,
>> +				   ff_mask_size);
>> +
>> +	if (err)
>> +		goto err_ff_mask;
>> +
>> +	ff->ff_mask->count = min_t(u8, ff->ff_mask->count,
>> +				   VIRTIO_NET_FF_MASK_TYPE_MAX);
>> +
>> +	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
>> +					VIRTIO_NET_FF_ACTION_MAX,
>> +					GFP_KERNEL);
>> +	if (!ff->ff_actions) {
>> +		err = -ENOMEM;
>> +		goto err_ff_mask;
>> +	}
>> +
>> +	err = virtio_admin_cap_get(vdev,
>> +				   VIRTIO_NET_FF_ACTION_CAP,
>> +				   ff->ff_actions,
>> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
>> +
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	ff->ff_actions->count = min_t(u8, ff->ff_actions->count,
>> +				      VIRTIO_NET_FF_ACTION_MAX);
> 
> and here, do we validate count != 0?
will add.
> 
> 
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_RESOURCE_CAP,
>> +				   ff->ff_caps,
>> +				   sizeof(*ff->ff_caps));
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
>> +	sel = (void *)&ff->ff_mask->selectors;
>> +
>> +	for (i = 0; i < ff->ff_mask->count; i++) {
>> +		/* If the selector type is unknown it may indicate the spec
>> +		 * has been revised to include new types of selectors
>> +		 */
>> +		if (!sel->type || sel->type > VIRTIO_NET_FF_MASK_TYPE_MAX)
>> +			break;
>> +
>> +		if (sel->length != get_mask_size(sel->type) ||
>> +		    test_and_set_bit(sel->type, &sel_types)) {
>> +			WARN_ON_ONCE(true);
> 
> given we gracefully fail, I'm not sure WARN is justified,
> since we don't warn in other validation steps.
> However
> 
> 
>> +			err = -EINVAL;
> 
> 
> the error here is on the device side, not user side, right?
> maybe a distinct error to indicate this.
I remove the WARN_ON_ONCE and replace the -EINVAL with -EPROTO.
> 
>> +			goto err_ff_action;
>> +		}
>> +		real_ff_mask_size += sizeof(*sel) + sel->length;
>> +		if (real_ff_mask_size > ff_mask_size) {
>> +			WARN_ON_ONCE(true);
>> +			err = -EINVAL;
>> +			goto err_ff_action;
>> +		}
>> +		sel = (void *)sel + sizeof(*sel) + sel->length;
>> +	}
>> +	ff->ff_mask->count = i;
>> +
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_SELECTOR_CAP,
>> +				   ff->ff_mask,
>> +				   real_ff_mask_size);
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	err = virtio_admin_cap_set(vdev,
>> +				   VIRTIO_NET_FF_ACTION_CAP,
>> +				   ff->ff_actions,
>> +				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
> 
> 
> why not ff->ff_mask->count? this is all we initialized...
right
> 
>> +	if (err)
>> +		goto err_ff_action;
>> +
>> +	ff->vdev = vdev;
>> +	ff->ff_supported = true;
>> +
>> +	kfree(cap_id_list);
>> +
>> +	return 0;
>> +
>> +err_ff_action:
>> +	kfree(ff->ff_actions);
>> +	ff->ff_actions = NULL;
>> +err_ff_mask:
>> +	kfree(ff->ff_mask);
>> +	ff->ff_mask = NULL;
>> +err_ff:
>> +	kfree(ff->ff_caps);
>> +	ff->ff_caps = NULL;
>> +err_cap_list:
>> +	kfree(cap_id_list);
>> +
>> +	return err;
>> +}
>> +
>> +static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>> +{
>> +	if (!ff->ff_supported)
>> +		return;
>> +
>> +	kfree(ff->ff_actions);
>> +	kfree(ff->ff_mask);
>> +	kfree(ff->ff_caps);
>> +	ff->ff_supported = false;
>> +}
>> +
>>  static void virtnet_freeze_down(struct virtio_device *vdev)
>>  {
>>  	struct virtnet_info *vi = vdev->priv;
>> @@ -5728,6 +5937,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>>  	netif_tx_lock_bh(vi->dev);
>>  	netif_device_detach(vi->dev);
>>  	netif_tx_unlock_bh(vi->dev);
>> +
>> +	rtnl_lock();
>> +	virtnet_ff_cleanup(&vi->ff);
>> +	rtnl_unlock();
>>  }
>>  
>>  static int init_vqs(struct virtnet_info *vi);
>> @@ -5757,9 +5970,24 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>>  			goto err_destroy_pools;
>>  	}
>>  
>> +	/*
>> +	 * Initialize flow filters. Not supported is an acceptable and common
>> +	 * return code
>> +	 */
>> +	rtnl_lock();
>> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
>> +	if (err && err != -EOPNOTSUPP) {
>> +		rtnl_unlock();
>> +		virtnet_freeze_down(vi->vdev);
>> +		remove_vq_common(vi);
>> +		return err;
>> +	}
>> +	rtnl_unlock();
>> +
>>  	netif_tx_lock_bh(vi->dev);
>>  	netif_device_attach(vi->dev);
>>  	netif_tx_unlock_bh(vi->dev);
>> +
>>  	return 0;
>>  
>>  err_destroy_pools:
>> @@ -7043,6 +7271,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>  
>>  	virtio_device_ready(vdev);
>>  
>> +	/* Initialize flow filters. Not supported is an acceptable and common
>> +	 * return code
>> +	 */
>> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
>> +	if (err && err != -EOPNOTSUPP) {
>> +		rtnl_unlock();
>> +		goto free_unregister_netdev;
>> +	}
>> +
>>  	if (vi->has_rss || vi->has_rss_hash_report) {
>>  		if (!virtnet_commit_rss_command(vi)) {
>>  			dev_warn(&vdev->dev, "RSS disabled because committing failed.\n");
>> @@ -7125,6 +7362,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>  
>>  free_unregister_netdev:
>>  	unregister_netdev(dev);
>> +	virtnet_ff_cleanup(&vi->ff);
>>  free_failover:
>>  	net_failover_destroy(vi->failover);
>>  free_page_pools:
>> @@ -7175,6 +7413,7 @@ static void virtnet_remove(struct virtio_device *vdev)
>>  	virtnet_free_irq_moder(vi);
>>  
>>  	unregister_netdev(vi->dev);
>> +	virtnet_ff_cleanup(&vi->ff);
>>  
>>  	net_failover_destroy(vi->failover);
>>  
>> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
>> new file mode 100644
>> index 000000000000..f9e771a0baff
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_net_ff.h
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>> + *
>> + * Header file for virtio_net flow filters
>> + */
>> +#ifndef _LINUX_VIRTIO_NET_FF_H
>> +#define _LINUX_VIRTIO_NET_FF_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/stddef.h>
>> +
>> +#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
>> +#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>> +#define VIRTIO_NET_FF_ACTION_CAP 0x802
>> +
>> +/**
>> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>> + * @groups_limit: maximum number of flow filter groups supported by the device
>> + * @classifiers_limit: maximum number of classifiers supported by the device
>> + * @rules_limit: maximum number of rules supported device-wide across all groups
>> + * @rules_per_group_limit: maximum number of rules allowed in a single group
>> + * @last_rule_priority: priority value associated with the lowest-priority rule
>> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
>> + */
>> +struct virtio_net_ff_cap_data {
>> +	__le32 groups_limit;
>> +	__le32 classifiers_limit;
>> +	__le32 rules_limit;
>> +	__le32 rules_per_group_limit;
>> +	__u8 last_rule_priority;
>> +	__u8 selectors_per_classifier_limit;
>> +	/* private: */
>> +	__u8 reserved[2];
>> +};
>> +
>> +/**
>> + * struct virtio_net_ff_selector - Selector mask descriptor
>> + * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
>> + * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @length: size in bytes of @mask
>> + * @reserved1: must be set to 0 by the driver and ignored by the device
>> + * @mask: variable-length mask payload for @type, length given by @length
>> + *
>> + * A selector describes a header mask that a classifier can apply. The format
>> + * of @mask depends on @type.
>> + */
>> +struct virtio_net_ff_selector {
>> +	__u8 type;
>> +	__u8 flags;
>> +	__u8 reserved[2];
>> +	__u8 length;
>> +	__u8 reserved1[3];
>> +	__u8 mask[] __counted_by(length);
>> +};
>> +
>> +#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
>> +#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
>> +#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
>> +#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
>> +#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
>> +
>> +/**
>> + * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
>> + * @count: number of entries in @selectors
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @selectors: packed array of struct virtio_net_ff_selector.
>> + */
>> +struct virtio_net_ff_cap_mask_data {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 selectors[];
>> +};
>> +
>> +#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
>> +
>> +#define VIRTIO_NET_FF_ACTION_DROP 1
>> +#define VIRTIO_NET_FF_ACTION_RX_VQ 2
>> +#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
>> +/**
>> + * struct virtio_net_ff_actions - Supported flow actions
>> + * @count: number of supported actions in @actions
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
>> + */
>> +struct virtio_net_ff_actions {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 actions[] __counted_by(count);
>> +};
>> +#endif
>> -- 
>> 2.49.0
> 

