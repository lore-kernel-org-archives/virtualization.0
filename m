Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DCC44B69C
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460345; cv=fail; b=HmluGD4FUnpz3Hr0p/bZG6Y7HHpA5cJcnlu3esWtHbmvybIs/iswUqjOLtOChq1GyGlNLEaZ2VbEF2V3AeE1GujlK9dAdwdOC4oLlafkJTDT5AJJcpzEiBQl6ZciefPHMCzEfQKLqX6iDxrp/6jws96jr8PffJeD89K3o+FtY9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460345; c=relaxed/simple;
	bh=zqOQx8a1wxtAN9We9VZ45sht4NJ2lI7f++9AsHoBdIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2mu2LnIBusLob4gouT9XIDXjevE/UKnbRBq5h1of1UsIZn+38wcaPFRpaA78zlR0LRKGRQ6vb2KEaj08RAX66btgdOb+bvirpqGy8l4EIT3RyqalVraymqzhSyggI+vjFmaIlBEg7vF6+iAq14bM1P+bAtUiNnDfje4t61ILO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CcqCNzOa; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CcqCNzOa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhFbOeA2YJlxz0ifix8CoCfSEAr5Y3ulTz47Wzvmg+CJ7GCOCLr3lQ8TytzOdhVMRdytyTq+HwtzAevFsv1KSvzgMXac37iYIdk7zL+TuOSZ+GWt7Su9jN53F22e4onNlNQ4aiSb/9OjmcnvsDWOS+BpmwXyY7E7lKEPWLr6d70mURu1S4lfI/7CoLIbPWk/KapmbuNx78TwxZUTUbxMKZSBTU3Ja745L/SuVlA1zTuxL76y/mN61GIXiLQQdcWytBzOOW8LYxwJYc9yCDFY7Ym9MQZdwUK51zTavV59846fzw80AuAfDpG9U+7q8i6NdZrVs4iWPe81LH1+Daq5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeBqQKyImQuwuqyhuc5FxAGjG9LFyDM3rVmvpbJu1Ec=;
 b=MzsUdL4V+NotYxP+S/RmUNkcQasYBfAEnqVhi8DKun+FdKJQ4QDwikhI4nYSigqsTR09NWohnzZHLTyu7mKMQ111dHIj1BrsE9sxh2fZV4bgZ47YHJODZv6xhX+0xCB5vNoTlUmO4xHhD4glUNMdrxPgri2BLLx5vTLQgJgsAHTJcwHzY379ELp+mt1RBlB5vb4Bg3crTtKF2Zy2PinmiDzqUrEva4J/6eQGFfdMB4H/Njy0Tj0v1u7efEJ0LhZkpVfx84ZwaV9dTkunKNZHJuT+cQlhg1PzWx9oLeANeERF1egGb5TzIXmoP0VTxNYlqwW3yN18WRpja0sv98fj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeBqQKyImQuwuqyhuc5FxAGjG9LFyDM3rVmvpbJu1Ec=;
 b=CcqCNzOa8kMcSWxyVkLyoKTNl1hLL+pPuKXBSydDvnSosiV5/0O3Dvt0DXxNM5kTgxetgRMPEotuxWPDLwSsDkK5ZZD7f2j5eOwsjUQASqLCcVTvoJip179rVNSd10AxstDRKrr5mUHgCFfYZja7e1Hfwa/Ddktmoi0JnyV/9afTHUk9jHwUUWvCxfuR87BnpSpddQoNJ1TvOzFWaVOIvfDuYJgwIrgrHiFNnk3l0x0NOFTbZG79oD83yebg8t8lGVbCIcm3FpO14h7Fzlvb5q9v5w53s/iDIJHMGUI336NyoWo/wbrVOXnoGqEW/EpSALOOV/ojKbrBfAcjut+3yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 14:58:52 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 14:58:52 +0000
Message-ID: <5515d0cf-f64c-48a7-ac10-a83fcbbc9ac3@nvidia.com>
Date: Tue, 11 Aug 2026 17:58:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 08/13] virtio_net: Implement layer 2 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
 <20260803140721.1871678-9-shshitrit@nvidia.com>
 <20260803122746-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <20260803122746-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::15) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: af3d101e-9d98-44be-afc7-08def7b90ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V9LZMOzeoWyMT1Flfe9LgI1dQGV1763CiOU5a89i7f0hx8Vnke8iySvr/Sxo3+G5T/S/pPoN7EsljSw4HEkfMVSTdnNFTd2C24WtXXsqjZbcpWn3cuU+MRu4iedwx2VEiK1+TwlrMG0uP2ujtwht6y/pTGJTKfNN9558EB/3dV9H/s1+kbhrficthydH5eWPv0xCQ93C4uvAocmPZ4YadMwGaxmWwqJzHfjGRLILovc5LBApcrrAxYMgoIBWU5exzxCO1Kxwv4Qe5KKxOKPUMIPaOWyG3+3BZ2XeOUUg8g7E8pwIFglbnyA2OQUlDaTURV9utgqpFt6DicKzNu8s9Wxnf0Z0w8LWgCtFnqmG9uTqgBYiVOIqH6rKBEnq5XB8JicOr/aPVnuwMdlj5w10M1oHBKM5QVAFNhd3iddw3kMQXuTP2ZjYAgdyESpN9FufCbFbYSjAsOL9FwDF7FENVkbj6fnRAdXIiDOY2U9R6GIF9/mky4xn0k+pTQGBeB6bgMEjDIlLSg9FIhCIs3hqKDa55YSJKpUb9oMTbRwfngIjYmmVOZio4qDLVzrxtLN6plicSaep9NUO7GFafTb+qmDNreTSaWSFAuTyA//aaAJ5gtBYNmIytYPNG3lDW3DwxniX4kWhG4s/6Z0699KxsU6ekUwL9a/FpUEanAJswv0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0xBWXY5ZCtvUU5wSXFWZ0NpNE1jL1VEWTE5K1RGOTRiT1NTMHZmc2hzTEw2?=
 =?utf-8?B?dVZwZXJTQk9ZSGk3cjYxL1lEbWE1RU5ENlJSL0FacEpQSTV0bE5OYjFPMVZJ?=
 =?utf-8?B?ZmtMYXh2ZzI5dzVCaFNNTWZ6VnJKKzZEcklTcUh3QUl0U3JXZzdPejl2Z2Y3?=
 =?utf-8?B?OFRRSFV3dzNYS0RLNFROY1JBYnhGblpYdXZ3cmRkRURUYzZrczZ0QkN5M2dV?=
 =?utf-8?B?REtMRTY0TlZJR051WENWdkFTekVuYTR0NEpSaUppSGhVTE5QWGc1QmtnK01a?=
 =?utf-8?B?eUg1WUhkSlh2VU1NeUxtY05UZUNxYzNUc05Dam9LS0VjOWcyWEtQRVZrY1Zp?=
 =?utf-8?B?M1U5V2JYKzkvL2dETkdneWFKbjBzMU9HV21WUDFTci9DSFphRWhKTGpIUDVV?=
 =?utf-8?B?UEZhQ0FTcXZENzY0czRjZG04NHdqRDZJTWptdDZ4U3VJeUtJaDhqZUVKb2Ev?=
 =?utf-8?B?bUpET0JqcXRMRlg4cmdwT1MrR1o2UlRRUlk2QjExMHhsTlQrZnBXdUpKTXJa?=
 =?utf-8?B?TDdVcW1Icnc1elNwTUhhOVJBaFdMOVl4ODE5eWNLRTBtbmE2bDN6b0hwNmFP?=
 =?utf-8?B?RFJnLzJoSzc4RjZGZ1pmMTFJZnh2RVhIbnhFZGY3QjBTZ2FlKzI1TFVQSHF3?=
 =?utf-8?B?Q0R1TEdwUG1jbWUwd2xrcVpIUEtiMEZpL0hIRkZlV3hXRUpqS0d2YTNUM3RR?=
 =?utf-8?B?cStLTWh0UFdaaFM1alVEN3BmL2wxU2F6RkUrR2dHcnpFVlFlQzc2Yytqakwy?=
 =?utf-8?B?Skw5OFV4aUJ4WFc1QzA0UlNjejF0RnNtWTBNcFN2Nm9pcmdkS3l5bUdZcDF5?=
 =?utf-8?B?SGl2dUYxK05iemdlL2dtWUpJMmhNTFBjM0JlMVpvR240RjFqK0N2bmtyQ2Nk?=
 =?utf-8?B?STA0MVlJUWFYWWpkU2NKWTZoUVI0UnNGNElXRDBwRTZ5dTV0VWhMZ1EwUlZQ?=
 =?utf-8?B?V08yZDV0NjNtSXZ6S3Q3K1A1ZWl6bndoK3ZYTmlHQnFENFN0K0dYMzhMNnYv?=
 =?utf-8?B?bDJLeWdnY215WHl5cCtLZkFtYzA0TUE0cUdlMXpwTmxldkNOVDFDanZ0cytx?=
 =?utf-8?B?Z2tqbTQ1R0ZSN1diWDdhd085ZFdJbXR6UHdiSCsxSUl4MEc0SDZjbkh5SlJT?=
 =?utf-8?B?aS9xUERSMUh3Vk41MmprVVkrSmxnd0NDeUtYc2x4WHpqcTE5UWlKTkN6U2tk?=
 =?utf-8?B?UFRYd01OMjlibHQrUUxTQ1RVUnVNZ1lzQXF2ZTkvUWRLSlpmZjNBYkdvSDdh?=
 =?utf-8?B?bjd1RW5TTGVOWHliRjNjR2tXRE1zSmd5TlowWEpIN2ZPMHdRWSszekFPb0hT?=
 =?utf-8?B?OW53YlZVbEpIOVp6ajJTMWcxSkJLcWZMUnpwVW5XUGRDa3dBRCtockw1UzlV?=
 =?utf-8?B?WlhKNFgzd1VjVmtyMEJEeEVaUVJxUCt0UElxd2tPdFowMkZ6S1B4RDl1MnEz?=
 =?utf-8?B?YlFTc0wveWUrM3pqRDJSOFB3NWdXYTV6Sksvdnk0bmJZNFBCSTFvTXJHSGdz?=
 =?utf-8?B?NUJ4OHZLZ21QKzgvOW5ERlN1dlVpL2dzazZ1VStlZW9wN3Mwak1nb2VydUxa?=
 =?utf-8?B?YWlkOTV2dkZQZEh3ckpuM3hzMWtZTHh5WWptNzkzbXhZa1c0TngvOGo2NDlZ?=
 =?utf-8?B?SFdzcFpxeGYxSWZGd3FtdmdMWnM4ZVVsY0N0d3ZkaUNqcDdHb21SM0ZRWjNE?=
 =?utf-8?B?SGpralVTQ25DMm92TWhiNnJaZUpUUmVGNlpEZTBIdWNwZWtLM0pDT2o4cXZh?=
 =?utf-8?B?OWRwTEwyZDQvbFl4SG5vbTJKRWJKMHNGMkhSYzI4MnNDVzlCQUlKNUtySU1o?=
 =?utf-8?B?WTZEeE8xQmliNm01RFJ1ZnpPZ2hDMktIa25VY0thTmFiWnFkRWFBSGJYYnh4?=
 =?utf-8?B?STRjZi9sL2VGT250N2xWdXZPaC92TFd0NFpuR3ZPV0xhRG4yYXJMbEVPcllC?=
 =?utf-8?B?R0VPZEdUZkJRSEFLTDQ5N0R2VGZzaG9qNDdNZ2FTRm01T0xvTjE2NS93Tmlm?=
 =?utf-8?B?QS8yem5JWEJkVXVhNkt0MGlOeEJ4SUZZaHdmOEhBNHI0WjhJcTJkdDMzRDNt?=
 =?utf-8?B?bU5jUXVTNzczUmVwNVVqZ2Rxakt0MDJJRlkvNXJnUjZKazZreWV4SHQ3RFNw?=
 =?utf-8?B?TUVWZkFsKzlPTVFvSWtobjFhMkVPa2VCczRVd3A0R2FxYzlZL0RnUW9pS1JL?=
 =?utf-8?B?OW82R3JQVWdCY2NVbnpGdERNdXdPTEt0QnFDQjNiQkNIRmpZc1NrcG5PN0Zq?=
 =?utf-8?B?K3hKcmtmYTJDNUxyMUJhYVIweHdFckJIQ2RoMnEzcG9PQWlzOXB0VDVmeEwr?=
 =?utf-8?B?NVBieXFPOGd5cFlTVHZ2YmJuVGFSRzZ4WXhkZnRoV25WNWcxUmN0Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3d101e-9d98-44be-afc7-08def7b90ea1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:58:52.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyw7+9t2DgVieQaPbkOPPpGOUcXjKnAOw3sEdd1CZMjwmdcwB1aChWJ3UFU2G3ub76Zw/URTsqKpR3jovp9IEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534



On 03/08/2026 19:30, Michael S. Tsirkin wrote:
> On Mon, Aug 03, 2026 at 05:07:16PM +0300, Shahar Shitrit wrote:
>> From: Daniel Jurgens <danielj@nvidia.com>
>>
>> Filtering a flow requires a classifier to match the packets, and a rule
>> to filter on the matches.
>>
>> A classifier consists of one or more selectors. There is one selector
>> per header type. A selector must only use fields set in the selector
>> capability. If partial matching is supported, the classifier mask for a
>> particular field can be a subset of the mask for that field in the
>> capability.
>>
>> The rule consists of a priority, an action and a key. The key is a byte
>> array containing headers corresponding to the selectors in the
>> classifier.
>>
>> This patch implements ethtool rules for ethernet headers.
>>
>> Example:
>> $ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
>> Added rule with ID 1
>>
>> The rule in the example directs received packets with the specified
>> destination MAC address to rq 30.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
>> ---
>>  drivers/net/virtio_net.c           | 521 +++++++++++++++++++++++++++--
>>  include/uapi/linux/virtio_net_ff.h |  50 +++
>>  2 files changed, 543 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e11e42583243..2540b9a23e5b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -32,6 +32,7 @@
>>  #include <net/ip.h>
>>  #include <uapi/linux/virtio_pci.h>
>>  #include <uapi/linux/virtio_net_ff.h>
>> +#include <linux/xarray.h>
>>  
>>  static int napi_weight = NAPI_POLL_WEIGHT;
>>  module_param(napi_weight, int, 0444);
>> @@ -287,6 +288,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
>>  	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
>>  };
>>  
>> +struct virtnet_ethtool_ff {
>> +	struct xarray rules;
>> +	int    num_rules;
> 
> 
> this is calculated but never used. was the idea to compare it to
> e.g. rules per group limit?
it is used in next patch.
> 
>> +};
>> +
>>  #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
>>  #define VIRTNET_FF_MAX_GROUPS 1
>>  
>> @@ -296,6 +302,9 @@ struct virtnet_ff {
>>  	struct virtio_net_ff_cap_data *ff_caps;
>>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>>  	struct virtio_net_ff_actions *ff_actions;
>> +	struct xarray classifiers;
>> +	int num_classifiers;
> 
> seems to be unused?
yes we removed it and it mistakenly got back here in this patch. will
remove it.
> 
>> +	struct virtnet_ethtool_ff ethtool;
>>  };
>>  
>>  #define VIRTNET_Q_TYPE_RX 0
>> @@ -5606,34 +5615,6 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
>>  	return vi->curr_queue_pairs;
>>  }
>>  
>> -static const struct ethtool_ops virtnet_ethtool_ops = {
>> -	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
>> -		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
>> -	.get_drvinfo = virtnet_get_drvinfo,
>> -	.get_link = ethtool_op_get_link,
>> -	.get_ringparam = virtnet_get_ringparam,
>> -	.set_ringparam = virtnet_set_ringparam,
>> -	.get_strings = virtnet_get_strings,
>> -	.get_sset_count = virtnet_get_sset_count,
>> -	.get_ethtool_stats = virtnet_get_ethtool_stats,
>> -	.set_channels = virtnet_set_channels,
>> -	.get_channels = virtnet_get_channels,
>> -	.get_ts_info = ethtool_op_get_ts_info,
>> -	.get_link_ksettings = virtnet_get_link_ksettings,
>> -	.set_link_ksettings = virtnet_set_link_ksettings,
>> -	.set_coalesce = virtnet_set_coalesce,
>> -	.get_coalesce = virtnet_get_coalesce,
>> -	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
>> -	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
>> -	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
>> -	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
>> -	.get_rxfh = virtnet_get_rxfh,
>> -	.set_rxfh = virtnet_set_rxfh,
>> -	.get_rxfh_fields = virtnet_get_hashflow,
>> -	.set_rxfh_fields = virtnet_set_hashflow,
>> -	.get_rx_ring_count = virtnet_get_rx_ring_count,
>> -};
>> -
>>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
>>  				       struct netdev_queue_stats_rx *stats)
>>  {
>> @@ -5729,6 +5710,435 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
>>  	.get_base_stats		= virtnet_get_base_stats,
>>  };
>>  
>> +struct virtnet_ethtool_rule {
>> +	struct ethtool_rx_flow_spec flow_spec;
>> +	u32 classifier_id;
>> +};
>> +
>> +/* The classifier struct must be the last field in this struct */
>> +struct virtnet_classifier {
>> +	size_t size;
>> +	u32 id;
>> +	struct virtio_net_resource_obj_ff_classifier classifier;
>> +};
>> +
>> +static_assert(sizeof(struct virtnet_classifier) ==
>> +	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
>> +		    __alignof__(struct virtnet_classifier)),
>> +	      "virtnet_classifier: classifier must be the last member");
>> +
>> +static bool check_mask_vs_cap(const void *m, const void *c,
>> +			      u16 len, bool partial)
>> +{
>> +	const u8 *mask = m;
>> +	const u8 *cap = c;
>> +	int i;
>> +
>> +	for (i = 0; i < len; i++) {
>> +		if (partial && ((mask[i] & cap[i]) != mask[i]))
>> +			return false;
>> +		if (!partial && mask[i] != cap[i])
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static
>> +struct virtio_net_ff_selector *get_selector_cap(const struct virtnet_ff *ff,
>> +						u8 selector_type)
>> +{
>> +	struct virtio_net_ff_selector *sel;
>> +	void *buf;
>> +	int i;
>> +
>> +	buf = &ff->ff_mask->selectors;
>> +	sel = buf;
>> +
>> +	for (i = 0; i < ff->ff_mask->count; i++) {
>> +		if (sel->type == selector_type)
>> +			return sel;
>> +
>> +		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
>> +		sel = buf;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static bool validate_eth_mask(const struct virtnet_ff *ff,
>> +			      const struct virtio_net_ff_selector *sel,
>> +			      const struct virtio_net_ff_selector *sel_cap)
>> +{
>> +	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
>> +	struct ethhdr *cap, *mask;
>> +	struct ethhdr zeros = {};
>> +
>> +	cap = (struct ethhdr *)&sel_cap->mask;
>> +	mask = (struct ethhdr *)&sel->mask;
>> +
>> +	if (memcmp(&zeros.h_dest, mask->h_dest, sizeof(zeros.h_dest)) &&
>> +	    !check_mask_vs_cap(mask->h_dest, cap->h_dest,
>> +			       sizeof(mask->h_dest), partial_mask))
>> +		return false;
>> +
>> +	if (memcmp(&zeros.h_source, mask->h_source, sizeof(zeros.h_source)) &&
>> +	    !check_mask_vs_cap(mask->h_source, cap->h_source,
>> +			       sizeof(mask->h_source), partial_mask))
>> +		return false;
>> +
>> +	if (mask->h_proto &&
>> +	    !check_mask_vs_cap(&mask->h_proto, &cap->h_proto,
>> +			       sizeof(__be16), partial_mask))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +static bool validate_mask(const struct virtnet_ff *ff,
>> +			  const struct virtio_net_ff_selector *sel)
>> +{
>> +	struct virtio_net_ff_selector *sel_cap = get_selector_cap(ff, sel->type);
>> +
>> +	if (!sel_cap)
>> +		return false;
>> +
>> +	switch (sel->type) {
>> +	case VIRTIO_NET_FF_MASK_TYPE_ETH:
>> +		return validate_eth_mask(ff, sel, sel_cap);
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>> +{
>> +	int err;
>> +
>> +	err = xa_alloc(&ff->classifiers, &c->id, c,
>> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
>> +		       GFP_KERNEL);
>> +	if (err)
>> +		return err;
>> +
>> +	err = virtio_admin_obj_create(ff->vdev,
>> +				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>> +				      c->id,
>> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +				      0,
>> +				      &c->classifier,
>> +				      c->size);
>> +	if (err)
>> +		goto err_xarray;
>> +
>> +	return 0;
>> +
>> +err_xarray:
>> +	xa_erase(&ff->classifiers, c->id);
>> +
>> +	return err;
>> +}
>> +
>> +static void destroy_classifier(struct virtnet_ff *ff,
>> +			       u32 classifier_id)
>> +{
>> +	struct virtnet_classifier *c;
>> +
>> +	c = xa_load(&ff->classifiers, classifier_id);
>> +	if (c) {
>> +		virtio_admin_obj_destroy(ff->vdev,
>> +					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
>> +					 c->id,
>> +					 VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +					 0);
>> +
>> +		xa_erase(&ff->classifiers, c->id);
>> +		kfree(c);
>> +	}
>> +}
>> +
>> +static void destroy_ethtool_rule(struct virtnet_ff *ff,
>> +				 struct virtnet_ethtool_rule *eth_rule)
>> +{
>> +	ff->ethtool.num_rules--;
>> +
>> +	virtio_admin_obj_destroy(ff->vdev,
>> +				 VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
>> +				 eth_rule->flow_spec.location,
>> +				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +				 0);
>> +
>> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
>> +	destroy_classifier(ff, eth_rule->classifier_id);
>> +	kfree(eth_rule);
>> +}
>> +
>> +static int insert_rule(struct virtnet_ff *ff,
>> +		       struct virtnet_ethtool_rule *eth_rule,
>> +		       u32 classifier_id,
>> +		       const u8 *key,
>> +		       u8 key_size)
>> +{
>> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
>> +	struct virtio_net_resource_obj_ff_rule *ff_rule;
>> +	int err;
>> +
>> +	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
>> +	if (!ff_rule)
>> +		return -ENOMEM;
>> +
>> +	/* Intentionally leave the priority as 0. All rules have the same
>> +	 * priority.
>> +	 */
>> +	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
>> +	ff_rule->classifier_id = cpu_to_le32(classifier_id);
>> +	ff_rule->key_length = key_size;
>> +	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
>> +					     VIRTIO_NET_FF_ACTION_DROP :
>> +					     VIRTIO_NET_FF_ACTION_RX_VQ;
>> +	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
>> +					       cpu_to_le16(rxq2vq(fs->ring_cookie)) : 0;
>> +	memcpy(&ff_rule->keys, key, key_size);
>> +
>> +	err = virtio_admin_obj_create(ff->vdev,
>> +				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
>> +				      fs->location,
>> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +				      0,
>> +				      ff_rule,
>> +				      sizeof(*ff_rule) + key_size);
>> +	if (err)
>> +		goto err_ff_rule;
>> +
>> +	eth_rule->classifier_id = classifier_id;
>> +	ff->ethtool.num_rules++;
>> +	kfree(ff_rule);
>> +	kfree(key);
>> +
>> +	return 0;
>> +
>> +err_ff_rule:
>> +	kfree(ff_rule);
>> +
>> +	return err;
>> +}
>> +
>> +static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>> +{
>> +	switch (fs->flow_type) {
>> +	case ETHER_FLOW:
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int validate_flow_input(struct virtnet_ff *ff,
>> +			       const struct ethtool_rx_flow_spec *fs,
>> +			       u16 curr_queue_pairs)
>> +{
>> +	u8 required_action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
>> +			     VIRTIO_NET_FF_ACTION_DROP :
>> +			     VIRTIO_NET_FF_ACTION_RX_VQ;
>> +	int i;
>> +
>> +	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
>> +	if (fs->location != RX_CLS_LOC_ANY)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
>> +	    fs->ring_cookie >= curr_queue_pairs)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < ff->ff_actions->count; i++)
>> +		if (ff->ff_actions->actions[i] == required_action)
>> +			goto action_ok;
>> +	return -EOPNOTSUPP;
>> +
>> +action_ok:
>> +	if (fs->flow_type != ethtool_flow_type_mask(fs->flow_type))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!supported_flow_type(fs))
>> +		return -EOPNOTSUPP;
>> +
>> +	return 0;
>> +}
>> +
>> +static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
>> +				 u8 *key_size, size_t *classifier_size,
>> +				 int *num_hdrs)
>> +{
>> +	*num_hdrs = 1;
>> +	*key_size = sizeof(struct ethhdr);
>> +	/*
>> +	 * The classifier size is the size of the classifier header, a selector
>> +	 * header for each type of header in the match criteria, and each header
>> +	 * providing the mask for matching against.
>> +	 */
>> +	*classifier_size = *key_size +
>> +			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
>> +			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
>> +}
>> +
>> +static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
>> +				   u8 *key,
>> +				   const struct ethtool_rx_flow_spec *fs)
>> +{
>> +	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
>> +	struct ethhdr *eth_k = (struct ethhdr *)key;
>> +
>> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
>> +	selector->length = sizeof(struct ethhdr);
>> +
>> +	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
>> +	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
>> +}
>> +
>> +static int
>> +validate_classifier_selectors(struct virtnet_ff *ff,
>> +			      struct virtio_net_resource_obj_ff_classifier *classifier,
>> +			      int num_hdrs)
>> +{
>> +	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
>> +	int i;
>> +
>> +	for (i = 0; i < num_hdrs; i++) {
>> +		if (!validate_mask(ff, selector))
>> +			return -EINVAL;
>> +
>> +		selector = (((void *)selector) + sizeof(*selector) +
>> +					selector->length);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int build_and_insert(struct virtnet_ff *ff,
>> +			    struct virtnet_ethtool_rule *eth_rule)
>> +{
>> +	struct virtio_net_resource_obj_ff_classifier *classifier;
>> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
>> +	struct virtio_net_ff_selector *selector;
>> +	struct virtnet_classifier *c;
>> +	size_t classifier_size;
>> +	int num_hdrs;
>> +	u8 key_size;
>> +	u8 *key;
>> +	int err;
>> +
>> +	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
>> +
>> +	key = kzalloc(key_size, GFP_KERNEL);
>> +	if (!key)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * virtio_net_ff_obj_ff_classifier is already included in the
>> +	 * classifier_size.
>> +	 */
>> +	c = kzalloc(classifier_size +
>> +		    sizeof(struct virtnet_classifier) -
>> +		    sizeof(struct virtio_net_resource_obj_ff_classifier),
>> +		    GFP_KERNEL);
>> +	if (!c) {
>> +		kfree(key);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	c->size = classifier_size;
>> +	classifier = &c->classifier;
>> +	classifier->count = num_hdrs;
>> +	selector = (void *)&classifier->selectors[0];
>> +
>> +	setup_eth_hdr_key_mask(selector, key, fs);
>> +
>> +	err = validate_classifier_selectors(ff, classifier, num_hdrs);
>> +	if (err)
>> +		goto err_classifier;
>> +
>> +	err = setup_classifier(ff, c);
>> +	if (err)
>> +		goto err_classifier;
>> +
>> +	err = insert_rule(ff, eth_rule, c->id, key, key_size);
>> +	if (err) {
>> +		/* destroy_classifier will free the classifier */
>> +		destroy_classifier(ff, c->id);
>> +		goto err_key;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_classifier:
>> +	kfree(c);
>> +err_key:
>> +	kfree(key);
>> +
>> +	return err;
>> +}
>> +
>> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
>> +				       struct ethtool_rx_flow_spec *fs,
>> +				       u16 curr_queue_pairs)
>> +{
>> +	struct virtnet_ethtool_rule *eth_rule;
>> +	int err;
>> +
>> +	if (!ff->ff_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	err = validate_flow_input(ff, fs, curr_queue_pairs);
>> +	if (err)
>> +		return err;
>> +
>> +	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
>> +	if (!eth_rule)
>> +		return -ENOMEM;
>> +
>> +	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
>> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
>> +		       GFP_KERNEL);
>> +	if (err)
>> +		goto err_rule;
>> +
>> +	eth_rule->flow_spec = *fs;
>> +
>> +	err = build_and_insert(ff, eth_rule);
>> +	if (err)
>> +		goto err_xa;
>> +
>> +	return err;
>> +
>> +err_xa:
>> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
>> +
>> +err_rule:
>> +	fs->location = RX_CLS_LOC_ANY;
>> +	kfree(eth_rule);
>> +
>> +	return err;
>> +}
>> +
>> +static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
>> +{
>> +	struct virtnet_ethtool_rule *eth_rule;
>> +	int err = 0;
>> +
>> +	if (!ff->ff_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	eth_rule = xa_load(&ff->ethtool.rules, location);
>> +	if (!eth_rule) {
>> +		err = -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	destroy_ethtool_rule(ff, eth_rule);
>> +out:
>> +	return err;
>> +}
>> +
>>  static size_t get_mask_size(u16 type)
>>  {
>>  	switch (type) {
>> @@ -5747,6 +6157,50 @@ static size_t get_mask_size(u16 type)
>>  	return 0;
>>  }
>>  
>> +static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
>> +{
>> +	struct virtnet_info *vi = netdev_priv(dev);
>> +
>> +	switch (info->cmd) {
>> +	case ETHTOOL_SRXCLSRLINS:
>> +		return virtnet_ethtool_flow_insert(&vi->ff, &info->fs,
>> +						   vi->curr_queue_pairs);
>> +	case ETHTOOL_SRXCLSRLDEL:
>> +		return virtnet_ethtool_flow_remove(&vi->ff, info->fs.location);
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static const struct ethtool_ops virtnet_ethtool_ops = {
>> +	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
>> +		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
>> +	.get_drvinfo = virtnet_get_drvinfo,
>> +	.get_link = ethtool_op_get_link,
>> +	.get_ringparam = virtnet_get_ringparam,
>> +	.set_ringparam = virtnet_set_ringparam,
>> +	.get_strings = virtnet_get_strings,
>> +	.get_sset_count = virtnet_get_sset_count,
>> +	.get_ethtool_stats = virtnet_get_ethtool_stats,
>> +	.set_channels = virtnet_set_channels,
>> +	.get_channels = virtnet_get_channels,
>> +	.get_ts_info = ethtool_op_get_ts_info,
>> +	.get_link_ksettings = virtnet_get_link_ksettings,
>> +	.set_link_ksettings = virtnet_set_link_ksettings,
>> +	.set_coalesce = virtnet_set_coalesce,
>> +	.get_coalesce = virtnet_get_coalesce,
>> +	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
>> +	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
>> +	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
>> +	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
>> +	.get_rxfh = virtnet_get_rxfh,
>> +	.set_rxfh = virtnet_set_rxfh,
>> +	.get_rxfh_fields = virtnet_get_hashflow,
>> +	.set_rxfh_fields = virtnet_set_hashflow,
>> +	.get_rx_ring_count = virtnet_get_rx_ring_count,
>> +	.set_rxnfc = virtnet_set_rxnfc,
>> +};
>> +
>>  static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>>  {
>>  	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
>> @@ -5909,6 +6363,8 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>>  	if (err)
>>  		goto err_ff_action;
>>  
>> +	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
>> +	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
>>  	ff->vdev = vdev;
>>  	ff->ff_supported = true;
>>  
>> @@ -5933,9 +6389,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
>>  
>>  static void virtnet_ff_cleanup(struct virtnet_ff *ff)
>>  {
>> +	struct virtnet_ethtool_rule *eth_rule;
>> +	unsigned long i;
>> +
>>  	if (!ff->ff_supported)
>>  		return;
>>  
>> +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
>> +		destroy_ethtool_rule(ff, eth_rule);
>> +
>> +	xa_destroy(&ff->ethtool.rules);
>> +	xa_destroy(&ff->classifiers);
>> +
>>  	virtio_admin_obj_destroy(ff->vdev,
>>  				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
>>  				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
>> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
>> index b0780e49df9f..9152021c99ba 100644
>> --- a/include/uapi/linux/virtio_net_ff.h
>> +++ b/include/uapi/linux/virtio_net_ff.h
>> @@ -13,6 +13,8 @@
>>  #define VIRTIO_NET_FF_ACTION_CAP 0x802
>>  
>>  #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
>> +#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
>> +#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
>>  
>>  /**
>>   * struct virtio_net_ff_cap_data - Flow filter resource capability limits
>> @@ -103,4 +105,52 @@ struct virtio_net_resource_obj_ff_group {
>>  	__le16 group_priority;
>>  };
>>  
>> +/**
>> + * struct virtio_net_resource_obj_ff_classifier - Flow filter classifier object
>> + * @count: number of selector entries in @selectors
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @selectors: array of selector descriptors that define match masks
>> + *
>> + * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER administrative object.
>> + * Each selector describes a header mask used to match packets
>> + * (see struct virtio_net_ff_selector). Selectors appear in the order they are
>> + * to be applied.
>> + */
>> +struct virtio_net_resource_obj_ff_classifier {
>> +	__u8 count;
>> +	__u8 reserved[7];
>> +	__u8 selectors[];
>> +};
>> +
>> +/**
>> + * struct virtio_net_resource_obj_ff_rule - Flow filter rule object
>> + * @group_id: identifier of the target flow filter group
>> + * @classifier_id: identifier of the classifier referenced by this rule
>> + * @rule_priority: relative priority of this rule within the group
>> + * @key_length: number of bytes in @keys
>> + * @action: action to perform, one of VIRTIO_NET_FF_ACTION_*
>> + * @reserved: must be set to 0 by the driver and ignored by the device
>> + * @vq_index: RX virtqueue index for VIRTIO_NET_FF_ACTION_RX_VQ, 0 otherwise
>> + * @reserved1: must be set to 0 by the driver and ignored by the device
>> + * @keys: concatenated key bytes matching the classifier's selectors order
>> + *
>> + * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_RULE administrative object.
>> + * @group_id and @classifier_id refer to previously created objects of types
>> + * VIRTIO_NET_RESOURCE_OBJ_FF_GROUP and VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER
>> + * respectively. The key bytes are compared against packet headers using the
>> + * masks provided by the classifier's selectors. Multi-byte fields are
>> + * little-endian.
>> + */
>> +struct virtio_net_resource_obj_ff_rule {
>> +	__le32 group_id;
>> +	__le32 classifier_id;
>> +	__u8 rule_priority;
>> +	__u8 key_length; /* length of key in bytes */
>> +	__u8 action;
>> +	__u8 reserved;
>> +	__le16 vq_index;
>> +	__u8 reserved1[2];
>> +	__u8 keys[];
>> +};
>> +
>>  #endif
>> -- 
>> 2.49.0
> 

