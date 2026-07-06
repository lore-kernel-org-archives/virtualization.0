Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291763CAA2E
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321809; cv=fail; b=m6OvvNnkA7P4r6LenstpI1KEm8YE8NEzTrvMsEcZw1LDUYlwZrZ3Af+T3YKxmzJ7onXkd1PRXMzxUkrL9GFTtsVG9ukoFjlIoEC/vQckI3S4kcB2Zv4rmnHyBCpW0u2DrnIUp2eH+56TUIt99oOuJYgD4x6n9Kz0iOkRowL96mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321809; c=relaxed/simple;
	bh=byaIg2GdZFg6I9agx6Gs/3ZKGkrAiyXpwzewV1rZp2U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ikNT/9DUScR/h48yHwX1yKEBTIsi3TqRIASgYtJY4lKx05VNuprhFtH4jblTgCl5HPHVZmzda48QdQi8dvBiceC0iAxjTeCwxICC50cQzFwfO9cfD6EEjntABeM99wjAksQXhgTtFKVPcL6clfR1Vfwck6XHVMyPAbwbLVfdFAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r/m2xo8m; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r/m2xo8m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEcOc2fIjxsgbDZETeAZOivRIBQFA4UJ8P7pBVJ3/92PLYK/dPkP4I1gPJEQVWCff1JjJi9oflBqMBjLc1NHJLEjxi1j5Qi/Ve+o1z2JG4oktwDRlS7vccKWw50iegT4kIJWLB50mRJUlyddCEntC974OLVwHX5vdgMqPEyGA9TpuqrMPAtQVeilredxadwW+uXs0vCZ195OFg69Y4uLyIDvig8Yxjq9WssDj9GLXVk8gAWMFPPGfNeeKuaH/yrLvPSRrpqcdcevmYKu5ms8ZB+frEjsJ4MHYbjQqjY3umSuwHUaBVJpKA+qg5r3rkOy1uPNmXjAnr5o3w89ho8tBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKnWs42t1SeCcrbwj9kRYixEWCRD47liHNDmEex7Zc4=;
 b=KGDMiv3TKRxdWqZdiESUqcoFPFutM9YjffYDHPAMRzBxRjPUBjAYbD3dX4NOU9ARS/EDeGE7eZoXSn4/LcnkVuf+p2xmWRArCDG/tg9HnkYGvNQcxPuJZQZQbfFNIMNk51vS9bFja4Jkel/pg7K3m1dS8pNSd4oO2vSJHUrI1xfZ6n7qL1i7gBaOdoNZ7nLWw5Wa9H9GRofXIkt3j5th+4PaQQWchftaGgAyaHq1QY+ftUR1bOPjvM8W9SpyxzDneumzWQRXR6C19E12C4zeu5g2vU1+B+s2Qi1Wo6KBYvO6/AK13y0bQm2fIuczAvW1mlDTT1IJv6m7ZEj8mzFHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKnWs42t1SeCcrbwj9kRYixEWCRD47liHNDmEex7Zc4=;
 b=r/m2xo8mzBqMCyK0+/WsdzAKS4S3RAU+ACeGue2hzcxY4BCn2CGvLrrAlfJyeInl9OOUlixMKgYgk7u723wqL8QxbuGHJ0hmjC/aPb2XTINHYHgsyXmlqwlgM8YRIzfcakt/wvzbSWsGiTXfN30rB3wnbEol3AJXrKwduen3OJzTq/wnUBzSxkAPIaiXx7PEy6Vs2mmuqqd/JhtLRxzu1bKkM96LJ7LYgVLBQBqyG6aOtuiAlnBFItNZRvMPUejc6oVGuumzfPGOYYDNoDCwG3pB5dWzfCsjIbs6c+UIBej+aR2rZFSKl7P84sJyP5rkPasKhQTNdjrVIJrmhOvnog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:09:52 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 07:09:52 +0000
Message-ID: <0ae3c300-01b4-49e5-a094-1b4cccc4f114@nvidia.com>
Date: Mon, 6 Jul 2026 09:09:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: fix wrong MLX5_ADDR_OF struct type in
 alloc_inout()
To: lirongqing <lirongqing@baidu.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
 Kees Cook <kees@kernel.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260706060902.2341-1-lirongqing@baidu.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260706060902.2341-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa7526d-ef3a-42f8-b4bd-08dedb2d934d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oJ2PQSht9Ovk80mNhdZB59VLwD+nLjKbqRquDeJ8ELN0bryoLcjTHPhsdTnX8uSWfZKYbIpMbqWuE6zhbbP4m76quJsizFXQaVBNIFTEv2OB9lLrofMOn+znO549IBQAIvhHJBbNoeu1MVDnwyDu3KPcbQDPELk7a2UUtfDxPjcG9bKkp2JBPEkbTfMLlCLCjFiCLvVo0T5EX4q3g5dFW0Y6E+vsZS3yRbwF/9qGOJOYt4gHzYtHbpsGw0rE8gryC8iG0i1ziNcyqgqG5xrRZGrWbTodVNx6Bh7Aw3gkveILx7zV/cCbPJLTojL+03P1shNi1UIiy2CjhylFT8Hzl1jRtn2Ypa3m/YPkcHzaYUMIZe6/PwijkEoUMnUeT41NUhr+qLrwB1xdvjojuJoMM1Mt9vhLh7lw1lioeBLsZw+IF7FhAV8ZKuSnjgPrXA04LCaFehmEQS3nOJ767GhC7nVh5uwyeKYrB4M6KDYcQWTC9iSogghmvs6L545s+jVWh0/vF6jJiMO7uyE3m1W1//lGbnO9sFipdEXPLqfUTGRQkQErCYJLRkR9rdEiPJdl4RsXhrqMWq7BR/r8QN8dVifuRLKgZVSW1EPL0LTyTuRFzyEPKD/t/oEPBomBCOzm4RiOLZ5Odym2Kuz6o2SoRStH/fVyNxfttlYhG7J+Kmo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjVJcWd3SnZycUVmQW0xZnd0V2ttbGJZQ3dhQ0dJU2xEOHJ6V3JsRkVUSnli?=
 =?utf-8?B?RWxrSEpHcWZHN3UzZmF4MXF2b0pFYkRjNURGdWpPeURKNUFoVmE3S2FJd0Zu?=
 =?utf-8?B?eTRNSlVZQzB1ZDdaZ1RkVFU3RjlEUmQ3d2xJbSt3MDNrcmtwN0h6Qlo0enUx?=
 =?utf-8?B?a2FXQ1FYYUZHV0dLT1hUc3VyOGJnSWw2eVlqdC9MZXN5VUxhZmVIRXl1RkVG?=
 =?utf-8?B?Y0pEREVzVTFuQ1YwRGQ0NFZZUnRPT3g1OGYzUndpSTFxNytiN0wvRWtNMEEx?=
 =?utf-8?B?R0pSWEF0cGZqNkFzNlR1dW4vTjZOcTg3ZnMzNVVvcmJxeCtkbEdYT3RrT0Yx?=
 =?utf-8?B?b0dDejhKWUJPcHcyWWh2dmx2ZnNpV2dXdklzdnpzbmUva2FabkZnblNMKzcy?=
 =?utf-8?B?SmZpT3cybXhDd25nblA5d3RJVVBGZmRxRTZPdG1GNUF6WXdjUEs3Q0hweTF2?=
 =?utf-8?B?OS9GaDBrdm0rbThiM3BXdW1XZ0RTUDRhcTBadERhVWxjOVlURzMycmptNGp0?=
 =?utf-8?B?L2ViZzVSOWhEdG05d3JacWE5UW5DdFdwbWpoUU5NOSszYmlSelBra2RlQWxZ?=
 =?utf-8?B?c1NzWEU4WXlJc0xuLzFvbkpHTjFTR1RsQU1wamxCNTNvYlFnUTRhU0tPTkow?=
 =?utf-8?B?SFMyVWE1Y2NsVnJqc0hablN3RDlxdURnMm9qNmpDMWVSL1RTcWJGNlZSN0N3?=
 =?utf-8?B?YmpoK2dZWURpR0JxNHoxNFZ5b3RNUFJoc2JONVNnV05QN1BIUUQ4R0hKOThL?=
 =?utf-8?B?OEMvanB1dGNzVTF1S21CdTEwNDBYak8wOGVYblJtbUZhcndnSkp6OWhiNXJG?=
 =?utf-8?B?aHdmclhmNGQvVnlDNlorZGZKMmhDZW9DbEQvbUdubnExTTZWdGZhVlFFbS8r?=
 =?utf-8?B?YjVZZC9ZTFdtcjFkUCtOcGFvWUV2RnBGNDU1U0toNVlLb3dGZG03NHRvYjRJ?=
 =?utf-8?B?cERmVGVpVE5SQWp0SUpzRkZwN0FJUnJoNGZsS2hqTE80MkltakppTUdiSEEw?=
 =?utf-8?B?N1lCeGxCT3BFZTk1VnhvMFpCT0E1WUtjczBpN0k2MmRCM3RPdjhIVExxeTRH?=
 =?utf-8?B?VG4weHNQVGZQWGZyU3VMdngrWmtQemU5aTRDMk9qV0VwVW1YU1h1TjNaT0xN?=
 =?utf-8?B?TldXc2p6UnZOblBlb3BKSE52N1MxZk5nNEliZkF6b3R6Yk1HZ3pVa1Nkbzc3?=
 =?utf-8?B?cm54ZnAvd0x6SVArbUd0MDNwSTJuWURZeW1kMi9JRXdBcUY3dC8wQWR3YzNz?=
 =?utf-8?B?UHFFaUhrc3hYT01Ga0JHNWlxWS8xVUtxKzMySzdQeW9HcklWTlExMXFzNm5p?=
 =?utf-8?B?bHZ1ZXNxdmVXYTFBUVE2eFVVK3NqVjM5dCs2L2Y4R3VaL1VYVXkyS0k5L3A4?=
 =?utf-8?B?WXRkUG5xYVNEK3JHN01YM3g5S0ZqV2NPdWduVnIrREpjUk1qU3JQWHBRWTht?=
 =?utf-8?B?RmRpRFdoY3VQN0tCSGVVdUd3OEtaTGM3d3VDOWdkM0prVm5CbFFzSDV5cGJG?=
 =?utf-8?B?cWNTZGFkVmdUOUtjd3Nwd292Nkx5U1NXdW1nVy9ZandYUnRjbWY5TDA2aU5W?=
 =?utf-8?B?ejZraGdiOXpYNDBlTW5VMTNhdVhiNUM2R2RPY1NvajZ6eG5nbklTMTdoWlJl?=
 =?utf-8?B?U1J4bXpPSzNIT3gvbU14alZnOTJHV0tMbHZyK1M2QUxvR0FpM2JjVW9Va1lG?=
 =?utf-8?B?dS90K29nT3ZuZG1GcEpJMEVGSkl4WDBnZE1xRGdjekxabHlaSXU5UjdUWjlI?=
 =?utf-8?B?QXM0YWlhc3d2UlpYT1V1enVCbDIwWUtYL3krdzdIMXJjMWVMWkVUYi9pWC80?=
 =?utf-8?B?ZktET1VFV3JPOHRaM0tVRk4yajY0NklKQXI0TjlwQ2RPZm1jWGp0c1JCdmxa?=
 =?utf-8?B?eUp1c1JEWDNTSFp3RmpXeHE5NURoVk1uclVib3NNTmpSNFlIL1IyTE04TTZJ?=
 =?utf-8?B?YVpKbk8zMWphNEczdlo4U3BHTnBRYXVZVUtNZml2V0hjTng5MElyUkk0VXJ5?=
 =?utf-8?B?U3QzcFJNMWsrZUlxSzRaeWRZc2JScDBwdWRMbTJZaFlBYXJxckh1YmY4WUlz?=
 =?utf-8?B?OSsySEQyeSthL0dOa1RicGZYdWFzVG9xSzdyNmMyOHRCK3d4SFNYTDlxZ2RO?=
 =?utf-8?B?WlREcVVZZnpVY20wdHhCUFU2bldxbEc0R3A3U2J1U0JZYW01aENVeGJwVmcr?=
 =?utf-8?B?a1NySEhGNEhhbDYwUDAvUzBUTDZNZmJjWE5GS1dGaTMweCtsSHhzTHZvaTNI?=
 =?utf-8?B?S1ZLY1IwMTVnMTdhTy9jcFB4OWx2TUh3RVd4YXF0cnJUNXcxN1BVaWJSODA2?=
 =?utf-8?B?WEIxeFVtYU9vTHNwaE1Pckp2ZnlpSEt3WTB1UWczY1F4OEEzVS9SZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa7526d-ef3a-42f8-b4bd-08dedb2d934d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:09:52.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEIYpoDOza3K+awRTERjyL+tRtzJ1uxHMgwN2kY+ox36hZNBPx3h7YbBkSSY9ymEHgr7PwWvkn4dZ6LfmJ+dgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435



On 06.07.26 08:09, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In alloc_inout(), the qpc field offset was computed using
> MLX5_ADDR_OF(rst2init_qp_in, ...) in both the INIT2RTR_QP and
> RTR2RTS_QP cases. This is a copy-paste error: each case should use
> its own input structure type to get the correct qpc offset.
> 
> Fix the INIT2RTR_QP case to use MLX5_ADDR_OF(init2rtr_qp_in, ...)
> and the RTR2RTS_QP case to use MLX5_ADDR_OF(rtr2rts_qp_in, ...).
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ad0d5fbb..eb431a1 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1080,7 +1080,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>  		MLX5_SET(init2rtr_qp_in, *in, opcode, cmd);
>  		MLX5_SET(init2rtr_qp_in, *in, uid, ndev->mvdev.res.uid);
>  		MLX5_SET(init2rtr_qp_in, *in, qpn, qpn);
> -		qpc = MLX5_ADDR_OF(rst2init_qp_in, *in, qpc);
> +		qpc = MLX5_ADDR_OF(init2rtr_qp_in, *in, qpc);
>  		MLX5_SET(qpc, qpc, mtu, MLX5_QPC_MTU_256_BYTES);
>  		MLX5_SET(qpc, qpc, log_msg_max, 30);
>  		MLX5_SET(qpc, qpc, remote_qpn, rqpn);
> @@ -1098,7 +1098,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>  		MLX5_SET(rtr2rts_qp_in, *in, opcode, cmd);
>  		MLX5_SET(rtr2rts_qp_in, *in, uid, ndev->mvdev.res.uid);
>  		MLX5_SET(rtr2rts_qp_in, *in, qpn, qpn);
> -		qpc = MLX5_ADDR_OF(rst2init_qp_in, *in, qpc);
> +		qpc = MLX5_ADDR_OF(rtr2rts_qp_in, *in, qpc);
>  		pp = MLX5_ADDR_OF(qpc, qpc, primary_address_path);
>  		MLX5_SET(ads, pp, ack_timeout, 14);
>  		MLX5_SET(qpc, qpc, retry_count, 7);

Thanks for the catch. Luckily those structs have the same layout.

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos
