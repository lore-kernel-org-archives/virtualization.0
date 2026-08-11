Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B932824B
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460615; cv=fail; b=ecx11dIJ+2rGr5V6jEdry1B7UhJ7RZ7Sh7aJ7cbXEhL70YiUWRoVnKmlsmzOZ0teZIUTMhLYNA5bwggsRBn5lUkQ1Ujeck8WOdvWxk42u19dJlZnaFmVJz9o1o+B3xM0QzUgsLzgD0VNxZvCmqDsxN4fmXdZq+zywqX/lblLOP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460615; c=relaxed/simple;
	bh=fIEv7iFMUO+swIhap62Qqk8sETQkAIBkIlZYOdTdzsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYmwn2U79hNk2H8X2aifwPv+J1Q9jl4awIdNsv3rVW6AYvxovYXFV+PtdEAP4GVpalWjJvERWt+ilNngKbYrzocvWyNGP0cE0aDyX8P0++c+XlHFrsQM0mn09EfnaAyqtqcLVaggEgSz+1y+TupJoJ393I6znyQ7HKERBATsZFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NDkzImpN; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NDkzImpN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liOjFEqP4eQhH1lg9lhtUg+T2KIy9YrkGv3JUOJN9gwc4evYRVoiMv9Lb4Xe59owUOvO2+4IUvTxiLnz0G+++InxrM0v8xPLniM14NJ20MiEtJ4aRWIuIyqzyyQrwMMOdHfAKUDgDFKzF2vrpZ+R0uDUHaXfFmt1HBItqHPm17D6G2WVuZWNwafuGgxgXeF1VelKjuzwCDKTZeYfqxa4lgYvWib91hOHtHQydL239jMcliscWkI1+T5EtlY06wLZNMOCN4dmF96OURGq9QBTkCL2QCvua56qp7+JzQmkXNSlVVZAtdbohLCD7VkELDeZ0ILgnl53ipS7LRjur7FJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTMGdDIH//8gd97MQvIXB842CwDTGRgf3Yr02L7oGfQ=;
 b=Ur+mOj1Wy4aDz0nsM2KcqHhlZ8cZT2BQhP69bcx2ciesiX9lXav+VwHd6QrNOzixcdr1UQ8uPYLqcQJ7WBQRMKSmRoKdhJ13fYpzvcckgC8f9nY1SsnqSarTj8zUBRHqxBs2RECiZ8AML5SidUzTb5vj1D984h19LI3x6gd6dpp4CIcbTnU/lN/KvWM1IBgMdGi282ZLcnoIgIdx/8bFvaVf1TXQoPmutzPmkyOGp2S50baImBpk047NfmC7fFvH+UkBTud1Usd+6wUpL/G9zlC7SmmoMV9tLMvCcfEbtu5Sj1WFcMWKLskpa5+/7KYt9PSuHUqnsrkISCIAgq7rog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTMGdDIH//8gd97MQvIXB842CwDTGRgf3Yr02L7oGfQ=;
 b=NDkzImpNDqPioOJjKprMeSxTQRYSC07Fotoe2pP+YSt+4JcgZX9J6Cv0Jv0+vwZ+9vxT+8V4Ck4vlKMOIx4mNH0D1n4yC5ohT4i82SYGcFPT0WdZJxMbMFz4j3em/KPx2287pXqffTYeud3TW+amSTb8K8dhMxzpbflg2vVWwKT5dWJMvvDAfsXvcCarnj9jHskLIglfrppcT7hz+YdCwDcrB3Ke2Tri61cxa1niBFcGB7PKgnpnBKyU5iEbG6gg825xCzdqzGUJUx9EGcpYFZyjDM8XJSon1Je+Lc3RtOehFwajniJQgyhWOIkxrCwb1VpXvBrzoVMkrDoneNWgxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:03:25 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 15:03:23 +0000
Message-ID: <db9942ea-8ff0-417a-a386-f6f992b3ff2a@nvidia.com>
Date: Tue, 11 Aug 2026 18:03:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 06/13] virtio_net: Create a FF group for
 ethtool steering
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-7-shshitrit@nvidia.com>
 <20260803122249-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20260803122249-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::7) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 99074ca3-f04e-4b0c-3f3b-08def7b9b044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	wyPfIMJVzvYDSZD5+nJ+ZSZQR1jTXHgX6gbKd3o7njI56YpUx+rXtkpwLdEjmeckobdr9mRWZQeXg2IREZr9yLdFnNjEv5M8c9d8icfbqW61pnB5NNJdQaoh6XcV9908gOh+l2FcEuQxpHwkX2hoQE8hEgFUyOzNNSpx1z5ehXad8Ynf/VpWK2RvpNdJhWhmgvuSAV12Krnr0wPb8EkudmPSeWYun4/paTmV342HEefYmDKv4xFFq6uiWE0Z2GaBUcJ019hqciNbf72Zg8MG24zO8L571dcbizhozJRDNAM+faF7tk/kv+PtbdKUt83uULvBxDwNkWdGCyJvQJ/qajOs2nCgQogOvo37XgpR/Sntp2/XM+V3eHcdWbZG99cHJuRi70ad3pUw6I7hU0ONVKauo/NvxJtN2LfqP4nIKgd0e5Gt2LG9tI4zNoruOLUz6zLt+rYnbfEvpaQnRWn7Gut055ELqPf/lHnZ82RskjDte2mmre53CTTEOlB8asMgDKQAYVCEz2z/whru8T6uu1UWEqdkp8S+xXpGK0mrrPVHgP1VT4NKqKwu04qZcSb+DkTCmK2e9RvGRMkJOrmxE5xsviQ6WpzQLLSrMZibeNGcVEdIw8TRRW3kUhKMdNluudxvArcIt9oHrRAKtx/RwOiBPERpVOmwnOIi2L/Dobc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGozS0Q1T2o4d3doQVB5YWRmY2Z2MUg4R0VVazh4M0crUlFlVzRhTExMQW5i?=
 =?utf-8?B?WUhodCs4VllOWU80NzFPSC9wQ1kwdVZDcm9idzNqRnd1VmJmY1pKd0ZuV3JL?=
 =?utf-8?B?WHozUi96eDRZWUR0bllHVmdOM2JWZ01mVXplMXdUYjVJc1BEL29wT29Sd3pK?=
 =?utf-8?B?Y2dvS0xNdVdJRUhVRHZnalQyc0JVQkFVN2tMdlhDeVFzNnpqQk1IcjZTNFJY?=
 =?utf-8?B?a1FiNTE1eEtPUW91VHVzMHdCZ2xZUzRlai9Nc2lVZGd5NUVWVVV1MkVzK1JH?=
 =?utf-8?B?UVRYd28vazBWNmNOVlMzNjJLUHRuSTZHT1hXMDBMUXRvNGV0U05XRlhQUXpX?=
 =?utf-8?B?djVBWVMrL1BudlU1U0U4M1BRMzBPNHlTeUdNLzRxd0NVNzhsTEJpR05xVXhK?=
 =?utf-8?B?NHpNZkk2bisrWHJtSWRSUHZGNm56L2dWSFdIWjNmcGVvSDBkdTNWY3VHZlhr?=
 =?utf-8?B?U29rSytnV2V3RW5pRDNmMlRRQUpKbU0xQkM0NmhtZXJiZXVRWUk1UkVpOE9t?=
 =?utf-8?B?eTFWenJtbHdHb2M5ZEIxSlVvcUcyVkxYSVQ1NjZWaXBMR1JRUmVGQ1psenBj?=
 =?utf-8?B?S2VZbFY0b0dHWm8rUUtHNUpaTXVVNG1PYVRBcVovWWVjeUdPajQxR3dmYi9O?=
 =?utf-8?B?QXBydHk5SERtV3MzZGphbldPTmVjWVZ3QVFsTFpsaXdOcnlzOHFyUzRScStM?=
 =?utf-8?B?M0xYVmhZOXJWbnh4TG1rWXhDOVZIc3FyM1ZTbzFaTkRVY01GRy9PRnUrTVlx?=
 =?utf-8?B?Y2kxazVteVhvZ2R5ZUVQUTEwSEJCMVZZNXdHTW9NOEJCYUNPN0piVDFJbmdv?=
 =?utf-8?B?cmJRdUR6VFR3a0dWSWF3cDZsV01uUFRPa213M2wxSFpBMkcvN21ZMDl1VzJI?=
 =?utf-8?B?SUlHMWhiWC83MlFab2ZDQy9iSDQwT1NWQ2VZbWtZekNZakZpQXNaYS9vbk16?=
 =?utf-8?B?aXMrZ2h5cGsrdFN5bWFGRG5Ha2FqcEpSc0VtQlljZzVFcDJIYTV3VjEwZ01S?=
 =?utf-8?B?OEpTald6azh5V2lKNXVDdU1yc2VpckoxSEpkTnRnTmZsWk1ta1Z4Ujk3TlY1?=
 =?utf-8?B?S2RCcStJenhmS1c3Qjd4bXNMMFVYV0RLTTZlUUNTc0FiNlcySStaS0VLQjkr?=
 =?utf-8?B?SUlLNEU0alRYdXdSTUJDbXNTZTJmZWxVZWNlSnl0M1EvQjdaL1UzSXVPcVpD?=
 =?utf-8?B?OENrK1pNZ0k5RGRUUjNSMEdrUjVhWnVxa2l1NzQ2clhZMzZIQ05BNzNwWlJ2?=
 =?utf-8?B?S1ZiNUM1YWRmdjcyRmttQ282eFlsS003UFY0c0NpSURpV2s0NmxoNi9oeFRZ?=
 =?utf-8?B?N2VUVEFVK0Z0dTZlbi9yTFhrN1FrWFJZWUZONmxhS3MwTGJPWEk3VUtGQVkx?=
 =?utf-8?B?dmZyZmJlZ2U3TE1uVCt2Z0k1c3MxdHhjQXQ3OEVrYWh3cUxOWVQzMERKTFFR?=
 =?utf-8?B?QUtnZVloNnA3K3kzeUZ5UjlWR1lGT0JiUkdnME9ISWxuTnhSMVlsMjJNdHBK?=
 =?utf-8?B?WFJ3SWtNV1VuR3pVTHQrUEI2RVFiY0dKMFZseGFlcWxWWDV6Z3FqU3R4QXdy?=
 =?utf-8?B?S0d5di9xTi9wOU9CL05DK24xVzlaaGl5eXFReTNhK1g3b3o3VllkRFd5N3hZ?=
 =?utf-8?B?UGJDeEp0WFc4d3hqeU56VnYzU1RMcUp3Si9FVE9Fc0NMWHQwTzlKT0V0bkln?=
 =?utf-8?B?eWs2RDZDbnZwVE1WMVMyMXJ0WDRoeGxUNlNQL1ZuOXN3dlFpdlg2aXI3RTlX?=
 =?utf-8?B?WTVWa3oxK1JQTCtEaWtiRDYrNjlKRlVKVzM0ZkMxWUIxeHZPdXpzVXpWQmlE?=
 =?utf-8?B?QjlqQVZuT3VNYSt1cmd6emJrNHpPUFV1S1UyaTJ2WWZkNGlBakVGMHI0am81?=
 =?utf-8?B?aGFtVE5TaXJHVDdMbDBNa1B4bUhldlhiMUh5MGhVM1hVckhwOGNhbFNMUFQy?=
 =?utf-8?B?bWFiOUJ4TGpZekdFYWtTZUxRWjVwNjZnVTBNeHIzNFRvTjJ2UURuK2N2alhE?=
 =?utf-8?B?UjlBQ0QvbjhFVlZ2VU53NUI4U0hJVWpuSEVjanI5RXFrbDNBdXJVS3hoWXlB?=
 =?utf-8?B?aDJQaThkbGcwSjhudUFFZkhoSWphcEozVmxmMHJzRkJpcUIzazFvZktjUWFO?=
 =?utf-8?B?ZVZqOCtQcmpYMStSRHpNcjRPTGNmUGRlQ1lmY2NmNVhoU3ltMjkveDhFc1Fh?=
 =?utf-8?B?VXBXQ3I5ZkliZjFvcEJDb3J5UjZVRTJZVDBNK3oyR0s1OEpZSnRHTm1jaDdL?=
 =?utf-8?B?WGROVUE4cS81YVlEaWJPT0lDeGZiUXVtYWY3WnVLZUs5QVhMenEvQk1lYmxN?=
 =?utf-8?B?bmIwVEtlemNZS1h2bENZU1RudURnNVpYQlZVRnk0NmY3MGltZzZvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99074ca3-f04e-4b0c-3f3b-08def7b9b044
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:03:23.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LC3aAJE0JKMHKKEcTTWNESPgLFzermX8GPBqF853huEonArA+z8oXsht+Vl4gBoL8ldpGNmF1hllVZEY4xXNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919



On 03/08/2026 19:27, Michael S. Tsirkin wrote:
> On Mon, Aug 03, 2026 at 05:07:14PM +0300, Shahar Shitrit wrote:
>> From: Daniel Jurgens <danielj@nvidia.com>
>>
>> All ethtool steering rules will go in one group, create it during
>> initialization.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
>> ---
>>  drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
>>  include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
>>  2 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 0d1f5a6cfd12..e11e42583243 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -287,6 +287,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>>  };
>>  
>> +#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
> 
> why 1 and not 0?
We left 0 open for ARFS. We want ethtool rules to have higher priority.
But since VIRTNET_FF_ETHTOOL_GROUP_PRIORITY is not part of the UAPI
header file, I will change it to 0 now and later when ARFS is
implemented, it could be changed to 1.
> 
>> +#define VIRTNET_FF_MAX_GROUPS 1
>> +
>>  struct virtnet_ff {
>>  	struct virtio_device *vdev;
>>  	bool ff_supported;
>> @@ -5749,6 +5752,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>>  			      sizeof(struct virtio_net_ff_selector) *
>>  			      VIRTIO_NET_FF_MASK_TYPE_MAX;
>> +	struct virtio_net_resource_obj_ff_group ethtool_group = {};
>>  	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
>>  	struct virtio_net_ff_selector *sel;
>>  	unsigned long sel_types = 0;
>> @@ -5839,6 +5843,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>>  	ff->ff_actions->count = min_t(u8, ff->ff_actions->count,
>>  				      VIRTIO_NET_FF_ACTION_MAX);
>>  
>> +	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
>> +		err = -ENOSPC;
>> +		goto err_ff_action;
>> +	}
>> +	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
>> +
>>  	err = virtio_admin_cap_set(vdev,
>>  				   VIRTIO_NET_FF_RESOURCE_CAP,
>>  				   ff->ff_caps,
>> @@ -5886,6 +5896,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>>  	if (err)
>>  		goto err_ff_action;
>>  
>> +	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
>> +
>> +	/* Use priority for the object ID. */
> 
> and how is this ok?
> spec says:
>  Each resource object has a unique resource object ID - a driver-assigned number
>   in the range of 0 to \field{limit - 1}, where the \field{limit} is the maximum
>   number set by the driver for this resource object type.
> 
> and limit here is 1, right?
right. it is fixed by changing VIRTNET_FF_ETHTOOL_GROUP_PRIORITY to 0.
> 
>> +	err = virtio_admin_obj_create(vdev,
>> +				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
>> +				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
>> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +				      0,
>> +				      &ethtool_group,
>> +				      sizeof(ethtool_group));
>> +	if (err)
>> +		goto err_ff_action;
>> +
>>  	ff->vdev = vdev;
>>  	ff->ff_supported = true;
>>  
>> @@ -5913,6 +5936,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>>  	if (!ff->ff_supported)
>>  		return;
>>  
>> +	virtio_admin_obj_destroy(ff->vdev,
>> +				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
>> +				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
>> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +				 0);
>> +
>>  	kfree(ff->ff_actions);
>>  	kfree(ff->ff_mask);
>>  	kfree(ff->ff_caps);
>> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
>> index f9e771a0baff..b0780e49df9f 100644
>> --- a/include/uapi/linux/virtio_net_ff.h
>> +++ b/include/uapi/linux/virtio_net_ff.h
>> @@ -12,6 +12,8 @@
>>  #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
>>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>>  
>> +#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
>> +
>>  /**
>>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>>   * @groups_limit: maximum number of flow filter groups supported by the device
>> @@ -88,4 +90,17 @@ struct virtio_net_ff_actions {
>>  	__u8 reserved[7];
>>  	__u8 actions[] __counted_by(count);
>>  };
>> +
>> +/**
>> + * struct virtio_net_resource_obj_ff_group - Flow filter group object
>> + * @group_priority: priority of the group used to order evaluation
>> + *
>> + * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
>> + * administrative object. Devices use @group_priority to order flow filter
>> + * groups. Multi-byte fields are little-endian.
>> + */
>> +struct virtio_net_resource_obj_ff_group {
>> +	__le16 group_priority;
>> +};
>> +
>>  #endif
>> -- 
>> 2.49.0
> 

