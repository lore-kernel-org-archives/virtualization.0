Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022105.outbound.protection.outlook.com [52.101.43.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8B18EAB
	for <virtualization@lists.linux.dev>; Mon, 30 Sep 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717631; cv=fail; b=ljHrCmqiABGTIHDNFsXc16UtseG8966HzXAVk9ojNF4oznePfef8VQS7U8Yd5m1HM07sEelW0J9EYNCoQd6iRjUKICxJvVQopOYo0EhlF5p4js7DMi5+zss1Fen7Q/69q6fHvf0UXo/NTZ/GyoTPVRp2CTrEVbz84qfpGCnTfmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717631; c=relaxed/simple;
	bh=ecrZxVhB1ItkhbMc/ZVwWcfEtFYtzylxKtRdY3HSnsc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RxnnX5Qt+4aJ/iflMQc76NSqoxn/zLpTJPKVXBQiEAg8H5kyWxRR96nswA499foY+tBg+DIx6RYoSOFh14Wke3yNNMb3r5u7pNelW490irqtLZqnTm51vM2H8Bq5l7BhgrG4VRYtXYzH8DihZUNpnC2OHU8nOt/iyQRiJdBZDjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=NqTx612f; arc=fail smtp.client-ip=52.101.43.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="NqTx612f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDvjimtYZcG0HQa/MHvaRRguIy0gcegLN7d8dG0I8AWauv7h8EXcJZajjcKtWIzdsiZZP2rqDO95HkkPX/ME3+hCVx9MHKEYnFXC3GIx++G2FNopomLLsAvzCwT/cOhQly/O/z5cmab2Jy0jZs7FXerB+HY1jG8teUommsu4NALKN7//tqnOrdYAah5ABicgoue+YhYKIXF1AimLeMsg1snClhdQWYGEM3YTf3Qmw3Sh3fgiFFxuc9uZwQS8H/dEB1BAb3oYmZVTbIES/ECH8jrR0H94Owks75a8X6kqMTD0XDAQc6oDV9qP2y6vA1ObD5aOc7IohMbotapR5nK7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecrZxVhB1ItkhbMc/ZVwWcfEtFYtzylxKtRdY3HSnsc=;
 b=sSU0e1O+SnW9y9ehKP0XSUlrNdhjcAN+vAsbrVe8GPoetjxDgpLL1QX70Y7WM/Xb/G1o11/mhRadNe0dcIRrfr9Z/VnTnQqyBK+57ipFFXka4yqY+DggWp6g46ZmmHZ8lKlww4wu1r6euAraZpH7R3SQQ/s+LFZjcZotyyAKv4BEt9h/6ks3hB/e8N5Y/XIKtVypTDHT/qWvC4OIARRxbMHwYtAblB6DLh074eRyDt6bY++AhyHjNgbbSWdVTZVXKO849kUscxZnScuxOcYwLnzW6/6ZRgyspvcQ75gBkCTw8zTak1MRsWbbCLQMusP14hAKgPSdA1Xl4RH5sMTxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecrZxVhB1ItkhbMc/ZVwWcfEtFYtzylxKtRdY3HSnsc=;
 b=NqTx612fMrXOz8blVXGyb9Uk+pwPN18EGYyF62fhCVA/HNaQd8WH428thC4OHQWUAvc9eGGeptcL40zSAb27inBcKp57rt7nUjhOwXreHmRVUVl0HkFLBlWrnCoGYy7GXzw7gGKlpyx3tc0UYVZZS7vX0G+Y0b8Kje4JGzC1QcL8NKrjV3UUV6eBXuwXGAKWKd5EQjj/WyF7J6wLmGU1cKpQFLGe5lzJTY/dpBkl8WuaZ8HupiTHlxNHiLhruvgQUSJysvjuLVlEXUvNOFII4N64eXXmUmRqxsyjeH1QWoX3mlOjlBlt6lR+N+VXYBG35wpC+A/XF3MBoDBL3f69Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH7PR01MB7584.prod.exchangelabs.com (2603:10b6:510:1d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Mon, 30 Sep 2024 17:33:45 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7982.031; Mon, 30 Sep 2024
 17:33:44 +0000
Message-ID: <245f4ea2-3434-43ab-a265-d050c168e464@cornelisnetworks.com>
Date: Mon, 30 Sep 2024 12:33:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Looking for help and advice on using RPMSG-over-VIRTIO
From: Doug Miller <doug.miller@cornelisnetworks.com>
To: qemu-devel@nongnu.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <8da76a79-444b-46f4-96db-309d03689220@cornelisnetworks.com>
Content-Language: en-US
In-Reply-To: <8da76a79-444b-46f4-96db-309d03689220@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH3P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::28) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH7PR01MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f17f4f-b97a-4e25-1680-08dce1760883
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkhzZHUxN21hMUhnK0luQVIzeHZ1cTVhSEFXWklMTXBFWFpaczhwR2VNRXQz?=
 =?utf-8?B?dk5yVkdLSjV1dlk0UW9EclI5M002dGVNYnRzc3B0SlE2N1doc3lhNytSckJO?=
 =?utf-8?B?Q25uVDRabVVrdkRSTXROdzJxVm02UFFLeFkxR1BPREZwOXdVdjhLclJ3SWsy?=
 =?utf-8?B?L1RDaGlBK0FWeGlTT3htQlBBMW9wZzJGQUw5M01vbExUeVlQaGJtUVJDaEdR?=
 =?utf-8?B?RGV1amo2M3NvMi9XT3ZkZjVkcWZCUXlDclYycEdNRng5VXRZMnAwaDVrYm1U?=
 =?utf-8?B?V1pDbUVYSVpRS2d3MUhpeVhYY0l0d29uY0hGZUJhV1YxVEZwbVlMVVdtRzlB?=
 =?utf-8?B?cURJYldjenRJVlI2TU5NS2RrQ2ozVGlEQXd6TC9vL21SdlVTRGtKT05KV0gz?=
 =?utf-8?B?QlNUdmdKSkxxV3N6bmN5SWRha0xTY0p0OHloYkcyZGxpUWZVemJwc0srdFhL?=
 =?utf-8?B?endINi9YazEzOFNub1FQaEx4dTE1Y3pMS0NRUUJiSGRKanRpdzNmR0RIeStW?=
 =?utf-8?B?SERTb2FNRC9FK0xvM0swNTErSEJxWS9uV3dOaVpFT3RvZmlZSGkyL2FxU3c4?=
 =?utf-8?B?NWhGQTB5YWlzc0VPUkhHcE1WalVUSFpxYzlqZ2haVmpWM1BpSit5bVJLM1Z6?=
 =?utf-8?B?ZmowcHpta3JUWHUrbnRzaUtYQytZVFVKR1ZvRXcxVEpoSkF1TFI2VHpxZit2?=
 =?utf-8?B?RjkyZDh0a0VrVmtBdU1reEtVNE5Kd3M0M2pqV0ZwblB3KytZOHhLbTVVeHhP?=
 =?utf-8?B?QWRxckpEWUEwSUVCV1J2Y25QUTVnQmNQZ3J6VXk5L0FHZ1VaVk9XK1FOV1Fv?=
 =?utf-8?B?L0RGVmwvbzRDZG5iWGtKNkoySHdSWWR6U1VYNGZYRlVuTlNWaUp1WHE5VTBN?=
 =?utf-8?B?NHYzbHVKVldjQk5SeVJZWmQ4ZDJLNjJpN0U5MS9FSlNsdGE3Zm9LM0o1SEFw?=
 =?utf-8?B?eUIrK0trQWNXcjZVYnFhazNLVHdzS3V2MG13dTVIanE5UkM5TCtYMEsxTXdD?=
 =?utf-8?B?ODhqTDVVZzR5dEF0eWtzay9KM0hEMnVFUnpteFNBVlBQNk1tYzVXSjRkMERH?=
 =?utf-8?B?YkI0VXFmdUg2Y1BBRlAxcmIyRmdsdlYzbG8rZWJzRWlXRXlqWmhpL1V5VVlp?=
 =?utf-8?B?V2RabHEyTGdCZVNmais5eDRmOEtubkhSYWRYSXZQTmJ4T2RzSnFXbFJPSFRB?=
 =?utf-8?B?NHVOVU93bXR2MjdiSlIyVXZGWkFtUjl5QzVycnl5dW14L3dWcUF1a240RDIz?=
 =?utf-8?B?NlpuSGxJSWM0OTZrZVhZdUh2WFBuLzZIS0VVL1Y1dFpQbE5NMGU4R0YwM1U1?=
 =?utf-8?B?VWh0NXdCVFlsUDdHTko0VHNTcTY5R2dodkl6ODNWU1Y5Z2dUVysrSTZCUUtx?=
 =?utf-8?B?UUdtOU9LeEF5RzcxUTlCL051VkhjakI4b2JpZ3dsd1lVK2hZeW1mWkQ3THRJ?=
 =?utf-8?B?YjZoYTV2dkdGekNuVTRnWXF6ZG5hUVUrNDIxSjZoYk83Q0grbFNSM1pZOWNE?=
 =?utf-8?B?bm1Qa1lGS0lxMUJyZEZSWHRVQ1p6M2tHMS80NDYralJuL0REVStaZEJGOFhi?=
 =?utf-8?B?NmJiQUJpVlRtSm5WV2lyajk1dGVmVndtV2ZMNEdpcWF3V0ZTaWwwRmM4SlYy?=
 =?utf-8?B?N2xtd3JRbkhjWld3TGlMRm4vdUJJTTlXZWJmRk1pRXRkMXY2YlV5ckNKQ0lw?=
 =?utf-8?B?N3FJZWdZN0I3SWZ5dFJvdDMrb2VaYlVMMmgrSExEQzJLWVYvYnVRNnl4VzN2?=
 =?utf-8?B?OFdmNlJBVTIrd0M2VERZUG9BK2JXdVBnRGRDeUZHQkhyZ1JwU3R1UG51Nm40?=
 =?utf-8?B?Y1RvVHFmd1hLeW1KeDF5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtEaTV1Si9MUnVYaFE3TkZTN3V4bHpDWWxmZkFJU25reDE0UGpUTTIzWXU3?=
 =?utf-8?B?Nmx4V0Zwcy9CY3VCQUZoUUgxb3h2UlRVS1ZBT1dlVG1hVVRETjY1dXVudklS?=
 =?utf-8?B?cmdGMFpIL2VsRzZtNzdLVDNxTDJOZnJMTElzaitxVXNMMC9kTHBjK0FrOXFI?=
 =?utf-8?B?TVZHMDcrT0lmbXZEQkRLTW4yZDZiZ2dWYzBQZVVmNlFud3ZWM0x1QzJXT3JJ?=
 =?utf-8?B?dzJkWVprZXQwVTc2RExHTDZ1OG9qYlZYK01Ua1MvQUlhM0ZGN1FoNEV6TFhs?=
 =?utf-8?B?SFdPZTFIcmI5Ri9yek1UTkRwS3hCYys3emJDdlF3d0pqeFpaVWZnVDN6clJF?=
 =?utf-8?B?MjM2Z0dHV0tlcXZ0aU84ZjhJOUNIZ1E5SUo5ZnJvVHBzWlhaMkFJdTJiV25q?=
 =?utf-8?B?NmZtU2wrUm1oakk5ZXJwYzhlcjloVG4wRW9mVm50K3pZSFp0ZmtVcjZkMmto?=
 =?utf-8?B?QWZjUWhMWXV2S21mY2tOMEdaSDNwQTdlMjVScGRadmhjN3ZCb2wwdmQ1QWxz?=
 =?utf-8?B?ZEVpRHkrcHlNUVRQc1JPdmFHd1JNRmtPY0VuMEF0cklFQ1ROQ1p2NHF4QUU2?=
 =?utf-8?B?Nmx6aEswME90enE2TFoxbFA1amRKMnlITGpkMXJTUGVEVEJ2ZVVGdFR6NmM0?=
 =?utf-8?B?ajJMemtORkRxenJuZ3JuNlB5NUZVMW9rV3FXYkYzRWpkRk5TNFROSmhLeEFi?=
 =?utf-8?B?QUwwaWNtTDRqSEZrVkpMSHFtak1YcWl4WWdXMDhjVDNjNU9BRDBXcE5mblU5?=
 =?utf-8?B?cUN0WXo1OThLTDNMK2EvYitRTkVEWkRQWnNKRjRDcXFiWFVtcmZlWE9nUGV3?=
 =?utf-8?B?SituMFJmTUJvQWxHVVZvYTFveSs5NXVNbjUreHF4eW95S0JEVVBqWEQwUzZE?=
 =?utf-8?B?SGhLUGsyYTlVWjZqYitYSW05YWhPL3FWNmZwN0ticWVaMWxnQk83My9GbE1I?=
 =?utf-8?B?WE9KVkZSMGw0alc0eFBvaVVwYmdla3VCTXJpY2tYbFcySmo0dHJIMFZ6RDZV?=
 =?utf-8?B?MW4zZ0tMRlVBZDhOZzkvTTQ2eXl5UnQ3bnFqV08vSnhLWXZnZ0xac3pXZkxS?=
 =?utf-8?B?dFdxRTlwaGI3TVNUSWk1UlJVTDJUcUxPcU1vYjFEYm9rcDhLaTdIcGdsbjVk?=
 =?utf-8?B?RXFEdU1mUytNblE4NW82MzI0dnpsaVVWd1VYa0piaVk1SEZneUNkTFN5ZFdH?=
 =?utf-8?B?c1Z0L1N5ZWZNMGlEV0dBTXhaMyt1YkM3Q2QzWXpQSkZvY1pXZXh3ZXVoNi9s?=
 =?utf-8?B?NER1MzhBV09sYWlHa1hhSFptWitHeWVHWWJmQTZwSzRrQSt3QldYTG5hcVBq?=
 =?utf-8?B?c21XUXo2TEZFZlh0NE9hekM2M2FDM1pkbmMyaTZzNEtDY0I1NloxMTZqdDE1?=
 =?utf-8?B?aThyejNMRDRvT0FxcWZGdzd4MG9kbnRxS2xTREpvdjA5bGNEMnJxSi9vZzVF?=
 =?utf-8?B?SmZVR09EQXUxZElkVlVVVWxkck1NSHdmMHZpZkdPWTllUEEraXNCQklQcjlr?=
 =?utf-8?B?dG9hbFdQNkZEZzY5SU5RNi94cFlUTlNDdHVPNGIrODV2RHVGcjFFejdEMnNC?=
 =?utf-8?B?Yms4T05ZQWtXc05xNmNyMzBpVEVHWExBV3VnWGpwSUlxUElpQUh1c2NibWhm?=
 =?utf-8?B?YjVMUDBsMkx2dTE5QTVPRC9ndmI5RFpUU2k2WSszN1Iyb2lBd05Dclowc2V5?=
 =?utf-8?B?TzJMdXZiUlJvSXBsTVF0OGZIcGV5RUw3UVFNMUlxdGhsL3B3ejJtUEtrMnVR?=
 =?utf-8?B?MkhPbzZEcTJ0RklyTUd6MG9CZ05jcW1GYXI0SFNKMm5IZWpYYXRNeFc5UVUw?=
 =?utf-8?B?TzNQQ1NpRzgySlloMzhsWU1waGJEbzBrNHJTRVIxSCs3Z0JCWnpkZDcyemVK?=
 =?utf-8?B?cEsxQUl4NkpLTGNFS0ZGQktQUXMrT3ZNdkQ3MDZoYWlYRlpkN3dJUzdHNEE4?=
 =?utf-8?B?aDNUaDlQSU56dFJ2d3VNd29oTWdOdFQ2L2I5aVFUam5qOXExVUxXdFV5ZXkv?=
 =?utf-8?B?MSt5UUtwUXVyN3hwbk9EL21uVklHK1ZnR1hqU3dkQW0vQWc1dERNMzhVRGJJ?=
 =?utf-8?B?RWtySnBwWGl1cy9pdmc2a0lGWGlCVk9CWERueExvOG9PeWVUV3diaFRGOWpp?=
 =?utf-8?B?cURWS2xTdjlsY3EyeHRJT0Z3WVlGdE5PR0VSdDNwTm5ZV3pmQ3BxbElZZjk1?=
 =?utf-8?Q?pG2sh1n5zrTcS9aRjSqDSxs=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f17f4f-b97a-4e25-1680-08dce1760883
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 17:33:44.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8YxfaxS7e3Xs3Fbwr1UNI5scPn0GJP1VBAQjjm1x5OPch0LhlB3wudiFsfG1jscTTMk2LKkLbSQlt/cZzx7p92jnKpaMzjx4K92/5ptsn9lOBNJEJ/JfFme5CNHT3EX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7584

On 9/19/2024 7:26 AM, Doug Miller wrote:
> I am working on adding SR-IOV for a new adapter and need to find a way
> to communicate between guest and host drivers without using the
> adapter hardware. I have been looking at RPMSG-over-VIRTIO as a way to
> this, but have not been able to figure out how the host would setup
> the RPMSG device needed for this.
>
> I have seen at least one bug in virtio_rpmsg_bus that was discovered
> and fixed by qemu developers, and so am hoping there may be some
> experience with rpmsg here that can help.
>
> I see an example in the Linux kernel for using rpmsg from the guest
> (client) side, in samples/rpmsg/rpmsg_client_sample.c. What I'm having
> difficulty with is finding examples or documentation on how to do the
> host side. I have heard that the VMMs may also play a role in setting
> this up, or are doing something similar, but so far I am not able to
> find code examples in qemu or libvert.
>
> Any help would be appreciated,
> Doug
>
I see a comment in drivers/pci/controller/pci-hyperv.c that describes
what I'm looking, but what I need must work for any (independently of)
hypervisor/VMM.

"Hyper-V SR-IOV provides a backchannel mechanism in software for
communication between a VF driver and a PF driver..."

It certainly seems like rpmsg-over-virtio would accomplish this, but
even some other facility that is VMM-independent would be fine. I'm
looking for any sort of solution that does not require (major)
modification of the kernel. Can anyone state authoritatively that
rpmsg-over-virtio is not capable of this? Is there something like this
backchannel offered in the linux kernel? Is there something else that
can be used to accomplish this PF-VF communication using existing kernel
facilities?

External recipient
