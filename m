Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793368041;
	b=5UCsk1HCm7vHnXwHi4oBn4u5k+I2RnUhbRtv20snRYEcl0mk3T6jVlRMVFQ/mk5Ny1Cq
	 /O5yNdM8tPin3JzBauYpIPyCG9or+sMxLiC9dkIpcX839IL1hYGdiFCrZLhzhJBGQ7um9
	 uLwSUGU/UapU+bYmf+fAEUd7RZ7yxZ5I6ZAs9qoWse1ee2DB0XRViyC5I9qcdk45WB4rQ
	 YAkbndrszsaFubCUksHq8NGZ59j92+MiPC9p0hPG0ol5fN6gOQWnHegOIqxHRHNFc3JN/
	 hEtaDE9Lg9WOVjc5Ih6lKYV+nrnEphNTTjqqmfOSym1Z+FRrbbiHAxR4XD1YP16/xnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368041;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LEn+I8cpDdqCpkiBikzBM4sx+l/b9bshmqPha+xN624=;
	b=vSZJolFrtig8y/sn/x6ogpVH5r0aVeSb75ambs29BBlOltemx5TQj5slJogejzNe0VYJ
	 3fLeKKzPKua9OufIZpYYnG2LX2Pq5XbmAMCws9g+i9HtM/nDfX9SQxu96HjkOVjCimTus
	 2/heQ9IwCbUC4grLZcUHx3JajCbgsLwLRyT3ZP0g1ItIk8PaYjVV9yXupAOBLyFROqah+
	 dDDUw8msZS/x5oXDkSnrTB0ZV7fcQXGq41rrlxdDuvnWS77BnLKlIWohLV75F2ONT4FrK
	 byDa/vBV7nKPlgX7b65T4gOoJlLpZRsCLMebzgV1yTasCQeMMeqm6ZmTNTAcNUrcIJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jKi4DaRn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.30
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF8606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 13:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DF8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jKi4DaRn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqSGejm67vSu/Ggu1TMv5X34BsVjfqOBWicwlnIStKqjx3IKUFhzZEydkkriqo8t2smyn4e21rbpyGA67MweRzr5kT4TrmJSIgOloubarz71+J7oQbefFTKR3aFJxdXwMUwQx31Jngq2BmGyaDRR88d+KYVYTdJ8MNE38Wky1WRtqbnZPco7mrVrwbbd/kiZ4xYtWcOwtexkaV9D2jwPsezM/ChqgMpzxPHjJvBvzDWcTddiuH9GrYN3M7vt769uPTOR37qSSHOHbKvG4PULBCBVsrOBY2t1iEe00lxruWmX3/mchiUlmhsGO1iyXi54ZtwYP1PmST1H/P10FPLmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEn+I8cpDdqCpkiBikzBM4sx+l/b9bshmqPha+xN624=;
 b=q4n+ZhwPiYG6AXDozuoVz+ce7+wLAtaIYo3kVZNFaXUR0gIteQD63QIj9yuYhsJb2iry3lAwoFqNxEVGfCA4pC+iAIWr2Lt5edHTT16ETY71gu2DHJGOv9wERPANRazaokxMjAI8jByb7hbespGfJMKLPkMdIMzu0RGu8hJJfyEYnBQBdQ4WNvIc0bfHphwoQBoiyB+sP2NrPNX0kSMDfcWhQI2AoDm5bmKU+UVKGR+5aHepBBiJD3lsMOFzDW9SGgMuv/HkHky0f0zg4hjbnox4BxJY6odbFNQUxhOPgPEQj7bAdElT659/Kk0fLaU/y+D+fBKLNt0fyVvEm4Uc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEn+I8cpDdqCpkiBikzBM4sx+l/b9bshmqPha+xN624=;
 b=jKi4DaRnpiBVd/VOLYNfyv/RKVf5/OeI/JlnqrFeg7t/pDiFzW2CpJPvn9Kldd4VzBRd7YSGSvooeIDIGJSh+20WY2GiGu328BIRwZaIOVvCG1gNdAnxIrgcu/hYNKC8M67WlcuGoAKJOQGUXlvy5wu2OqtorTEerP+lzZZEsiZTMPQhY1ggoPYa+MbPGtmDptew8mTGkmCgtNawnJlbNtA/rzE2TFDDZMr5aGCbaLc29dln8dyjYXlwMwHMELxjdUKneqvlLLZRtNkMjXZtg2FQ3Wu2oAgRjqg+I9HAglh3vnvMl78TwyDdX89KXYjoQkdYn305tD8w0YGaQFURxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by IA4PR12MB749807.namprd12.prod.outlook.com
 (2603:10b6:207:128::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 13:47:17 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 13:47:17 +0000
Message-ID: <ffef2498-eaba-4349-bdf5-7b035052ae80@nvidia.com>
Date: Fri, 30 Oct 2026 14:47:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] vhost_iotlb: bound map allocation in add_range
 breaks vhost-vdpa on hosts with fragmented memory
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 Linfeng Sun <linfeng.sun.dev@gmail.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 Jason Wang <jasowangio@gmail.com>
References: <0f51918f-88c9-4930-ae5a-616bbe73e7cb@nvidia.com>
 <20261028085839-mutt-send-email-mst@kernel.org>
 <808a6e4e-085d-4723-9489-f17f023949c0@nvidia.com>
 <20261028110041-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261028110041-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|IA4PR12MB749807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c63b03a-6425-4ba1-3707-08df368c4feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|5023799004|4143699003|261026121527099003|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	cNillCjhs6ib2rvvX1Efl6kIzrkBJkCy2cPLpWSjyoQdFnPvdi/jl+SMOFDuTZ8WdPt/80aPYnSXjEaLPPEK3F9KQ0vwJ67QWbJ0cv9SYetyg6BkbMz7UbPy17c+JgmRuWBZBVxD666/VEAok4n2YiyRtP5M3GKpw5LHp2uwcdRHG3GFFODXsfc/BkwmspI8F7uP+617YpG3HrprElopMd4fQTx50aRVvc+f4+CkydrAsIeyEPUq74FAKmWelHtFIUblr9ISmS5gBUUbAmUMowx5VRYTvmAaCm4yzKOl9TAhGqRiCLUbnu3DpH7u+8RUeYXR3+45/4BlgOZ07BdLDkbOo4aUq9ZvAQFs15YrrGIxHcNOkmnPrF6/TB7vw4BlRhcCH6U/qwxfuf7/IkPaJPEde9sQiF73kuFo/QCIQeAA5Jqj20ROQaX2BBVfyGAX3tcFOMSIxUR06cARWrYJofMX0YuB49SVhekHOmt5tN0n5Pkb6kUOCaXr7u4E4vY8K8BevAxZ6ZW40PuqH6H04Doj2nOTajRqP+bnbJZnaa/uVZQTbKop4YIIWJIuwMn+tC8LlgAGkjEbTpwcx/qKDdjEb9Y8jb3MwJ/8wQ5/ZEB8lkTHCai4l2uqqG1jsmkhXXMWf79EmTBo0hiyMEtGTS18zfffvrQiIMe0Zq0vHCE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmJJT21LZXBoWVdtU2RERVdHRndDOVdwRlJCZldqcmVTZVFDZmNzdUpPbmdD?=
 =?utf-8?B?dm53Q01EZTlFOW1jc1hvcHRLVDJpbUdTVWZSUWlEdkg4VDJVeGZLcVltNWZL?=
 =?utf-8?B?S1NEaWtTa0pPSTFCUWN6QWdpMU5qTTlGRSthS0tObUUyTWMxekVmcXAvbkFQ?=
 =?utf-8?B?NWk3OEhteEtnZGg0U2p1Qks1c1IwQmFISk5MQmwybmJEbHZUWE5qbFlGc1Nk?=
 =?utf-8?B?UEErdjNjbnlpWW9yYlJ1dFdKVTF4L21CZW1BakNERWJhaU9zcmN6ZjE3RFl1?=
 =?utf-8?B?Sm8rc0UzMVh1NEtNN2kvV1dxN3lQa2l1ekcrTERBMFY5eTVsTWRYRDJ2S25x?=
 =?utf-8?B?VU9GbC9MRnZjdFRCZTA4UUZTZE5MZmdhU1F5d01kaGV1MkMyKzRZL2h1N3N1?=
 =?utf-8?B?NWpYU3VPVmJJUWtZd1FoSHJKWmhheE83bm1KaXgxRXkxRU1EZWVNd1VEMVNT?=
 =?utf-8?B?R25OUlQwMTRIbHBjVGN4WlVOTkpyN0xmREVnSjVXZFliVFErUkljYnY0RjBu?=
 =?utf-8?B?MzNrRE9NQXZiTmlWdnRXejl0cXJwWXIrREx3aXJldGd2VlVQQjkwZEw2aVVT?=
 =?utf-8?B?U042ZjBvVkFBWUdFSE1EejRFVFIwSmF5RXBrRSswNS9Vcyt4Tk4wT0pFeGx6?=
 =?utf-8?B?Q1BJMDdoeXhiOGEycFppYnQ0SDNmaHFuR1I5a2ZDeng3V0tpQXBHRG9iSmhQ?=
 =?utf-8?B?QzBuS0hPTjNwOUlLOTBFaklQRDB2YjVEYnhnQlY4SmFvM1FwdDhMY0JVTGNr?=
 =?utf-8?B?NUtrbTkvQ0U0cEJIOC9SMmJRN01zYU8za3Uzaldxdm90VGZZSWcyMUYxMDFw?=
 =?utf-8?B?T25SNDdhSkVKbDRzOUlGcmVmRnU5bXdrcjREMWtWdlBMcTNrYSt4NkFnTDBH?=
 =?utf-8?B?TWN1aVRSRGJFTzI1NThwRTFLMGFaWTFnekN5dFZqV0ptOGdxTkdydnJ1MU1y?=
 =?utf-8?B?SElTRUplcVhicTlwWWZVYjczMEJGQWxWaG5aalhqQ2M3aUZjSlhWU1c2MEdi?=
 =?utf-8?B?VnMvSVg2UlBZVE5kenY1OFVqZkFZMG1IOG55ZVZkaGZoUlJFSmduYlE5eWNq?=
 =?utf-8?B?TERaZ28xcWJudXowczJ6eWg5ZmdJa1VOME9qYmY2MkNCWGU2Ky9sYlBXbVZy?=
 =?utf-8?B?WEMxaUlOK3J5YnVYQklpZ0tZS29jMmszSmttOFdHdjhSakp4bWE1LzYrNDlG?=
 =?utf-8?B?RGUveTZ1ZVk2UGdrejZrQ2ljVFJsRnUwam9uTzJaUGxJSlhtWXowVWxWV1lm?=
 =?utf-8?B?V29UUElQL1c1UTNlY2FmN3FvU2JIS1VFbWhzZEZtcktKZmRLb0hTQm9jVVRE?=
 =?utf-8?B?ckRUcHJkZ2tNUThTb2djQmN0SGRZQkxyOGM0ZkVrZkJhREQvb3lLaGZDc1hr?=
 =?utf-8?B?eEpyMWpxc1RxT09MdXVBRFRNZEdCRXkzSVcwbnVzYnAzU01RcjlkVUJoZjlO?=
 =?utf-8?B?Q1dmb05BMVVpRlBKRmxWcURoL2l2ZVZ2ZUg4M2c0KzdZc0ZVSGdTYW0rMXlq?=
 =?utf-8?B?K2xya0JlNzN2ckdDcGtPaWxSSXJsTTMzQ01iV01qWkdpcW5ackhOM0pLVXpj?=
 =?utf-8?B?MTFBOVMyQkRVRTJEZjZYa3dNbTZjaXNsSFd3ZjdvWC9NU0RpbVNtMzNHQzll?=
 =?utf-8?B?bWJrV3RyUFNPQTJUdnRmMW1Ub1E0N3BFV0FpenRKZnQ3b0JOUTJMVXFzOXRr?=
 =?utf-8?B?OGhEZGptWnhYd0dFZ2JNNzlKYklycjFOS0hLcWFPbjNxR2dyekY2SkRkeGVv?=
 =?utf-8?B?aDRaZTUxNWJRUm5OZHpBQ2ZPYVVIYVQrbzdaNVp0WFVSQ3ROb0NaeEZPUVhv?=
 =?utf-8?B?STBMcm9XOFF2UEVHRjBuY2JTUjJpYW5HanRQaFVCcC9JTU1XKzNoVnFFSHNY?=
 =?utf-8?B?Mm00YnI1eEpZWE1TbE1kcElQa2N0dzN2RTREc2Fydm9GZXp0MmI0M002NWJo?=
 =?utf-8?B?VmNaY3VDSXFUMGorMWZrVkQzRkE2RU9ITkU4Rk9BZ1h3NVZUbHN4NDNKNUV5?=
 =?utf-8?B?ZGRQOHFJMWdueXFCWjNONGZaSThXUFJLZ1NVTHRTQUhtckFsZ0ZHZHlGNW9i?=
 =?utf-8?B?cHYzRnJiKzFieG9nWm9scWdLMDBMRHlxazBVVWtPNzVOZGdWWGxsRFg4MXY3?=
 =?utf-8?B?KytpWDMwUVlqU3hZVDZWSFM1ZndiRU9LVyswRmpCMzY5aDlPTjEzc3Y2d04r?=
 =?utf-8?B?SThNeTBscDZxcUhKQ1RHMjZ5ZjRtaHlUL2ZNY0EzOHNmbzk5aHl5RllJVHNo?=
 =?utf-8?B?RTQyYkE0WDBJdzdzRGNBOUdHcytNYmdoOVpNNk85NktMR0RMbmNXT3lNaDVX?=
 =?utf-8?B?MkkraDlPQ3NuVEFyb21rcGl1Nm90Q1hCTjIvRkxkdHFqMnFKRUtydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c63b03a-6425-4ba1-3707-08df368c4feb
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 13:47:17.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsZoJEAD0HK3KBCUDjUIBB31bhFttWgpmWo1foPkSuqQQSUYV6Z0L7/XgxS9qfSlMMdVKnastPhj3OYM37nY1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB749807

On 28.10.26 16:17, Michael S. Tsirkin wrote:
> On Wed, Oct 28, 2026 at 03:46:05PM +0100, Dragos Tatulea wrote:
>> On 28.10.26 14:05, Michael S. Tsirkin wrote:
>>> On Wed, Oct 28, 2026 at 01:44:30PM +0100, Dragos Tatulea wrote:
>>>> Hi,
>>>>
>>>> We've started seeing regressions for a while in our verification CI for
>>>> vDPA Live Migration tests. Occasionally the FW returns a syndrome
>>>> related to invalid mappings during device reset.
>>>>
>>>> We've narrowed this down to commit 1ed35ac7f3fe "vhost_iotlb: bound map
>>>> allocation in add_range" which limits the iotlbs to 2K by default. On a
>>>> host with fragmented memory you can get easily more than 2K entries.
>>>> This results in truncated/incomplete iotlbs mapped to the device and when
>>>> the rings happen to be outside of the first 2K mappings the FW will complain
>>>> because it got addresses that are not mapped.
>>>>
>>>> I'm not sure how to fix this though:
>>>>
>>>> - LLM suggests setting the 2K limit only in VA mode and using 0 as
>>>>   before in PA mode because PA mode is limited anyway. Does this
>>>>   work?
>>>
>>> Well no, we do need the limit in PA mode I think.
>>>
>>> But we should maybe  bound from what's actually being mapped rather than
>>> a fixed count. e.g. X entries per pinned page?
>> You could have many 1 PAGE_SIZE mappings though. It wouldn't help
>> then.
> 
> it still mostly is 1 entry=1 pinned page
> 
> sharing is possible but uncommon
> 
>>> Bounding by bytes instead of entry count is another option.How to get this limit from userspace though? Would RLIMIT_MEMLOCK
>> be an option? Although `ulimit -l unlimited` would need to be
>> capped to some value...
> 
> guest ram no?
> 
>>
>> Also, if the entry limit is still there some kind of precedence between
>> memory and entry limit needs to be decided.
> 
> I'd steal a page from rlimit then use that for the entries, when out of
> that - steal another page.
> 
Do you mean something like this [1]?

Remaining questions:
1) Is it ok to delete max_iotlb_entries? Or keep it initialized to max?
2) Is it ok to delete the module specific max_iotlb_entries param? For
  example mlx5_vdpa_max_iotlb_entries. I don't see much use for it ...
3) Shouldn't the core or the driver track holes encounter due to
  incomplete mappings? It would be good to not give bad addresses
  to the hw/fw...

Thanks,
Dragos

[1]:
---
 drivers/vhost/vdpa.c | 72 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a4d0ce3dac04..224f950a22bd 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -34,19 +34,18 @@ enum {
 
 #define VHOST_VDPA_DEV_MAX (1U << MINORBITS)
 
-static int max_iotlb_entries = 2048;
-module_param(max_iotlb_entries, int, 0444);
-MODULE_PARM_DESC(max_iotlb_entries,
-		 "Maximum number of iotlb entries. (default: 2048)");
-
 #define VHOST_VDPA_IOTLB_BUCKETS 16
 
 struct vhost_vdpa_as {
 	struct hlist_node hash_link;
 	struct vhost_iotlb iotlb;
+	/* pages charged to RLIMIT_MEMLOCK for the IOTLB entries */
+	unsigned long charged_pages;
 	u32 id;
 };

 struct vhost_vdpa {
 	struct vhost_dev vdev;
 	struct iommu_domain *domain;
@@ -75,11 +74,41 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
 				   struct vhost_iotlb *iotlb, u64 start,
 				   u64 last, u32 asid);
 
+static inline struct vhost_vdpa_as *iotlb_to_as(struct vhost_iotlb *iotlb)
+{
+	return container_of(iotlb, struct vhost_vdpa_as, iotlb);
+}
+
 static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
 {
-	struct vhost_vdpa_as *as = container_of(iotlb, struct
-						vhost_vdpa_as, iotlb);
-	return as->id;
+	return iotlb_to_as(iotlb)->id;
+}
+
+static int vhost_vdpa_charge_maps(struct vhost_vdpa *v,
+				  struct vhost_vdpa_as *as,
+				  unsigned int nmaps)
+{
+	unsigned long pages = DIV_ROUND_UP(nmaps, (PAGE_SIZE / sizeof(struct vhost_iotlb_map)));
+	struct mm_struct *mm = v->vdev.mm;
+	unsigned long lock_limit;
+
+	if (pages > as->charged_pages) {
+		lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
+		if (pages - as->charged_pages +
+		    atomic64_read(&mm->pinned_vm) > lock_limit)
+			return -ENOMEM;
+		atomic64_add(pages - as->charged_pages, &mm->pinned_vm);
+	} else {
+		atomic64_sub(as->charged_pages - pages, &mm->pinned_vm);
+	}
+	as->charged_pages = pages;
+
+	return 0;
 }
 
 static struct vhost_vdpa_as *asid_to_as(struct vhost_vdpa *v, u32 asid)
@@ -114,14 +143,11 @@ static struct vhost_vdpa_as *vhost_vdpa_alloc_as(struct vhost_vdpa *v, u32 asid)
 
 	if (asid >= v->vdpa->nas)
 		return NULL;
-	if (max_iotlb_entries <= 0)
-		return NULL;
-
 	as = kmalloc_obj(*as);
 	if (!as)
 		return NULL;
 
-	vhost_iotlb_init(&as->iotlb, max_iotlb_entries, 0);
+	vhost_iotlb_init(&as->iotlb, UINT_MAX, 0);
 	as->id = asid;
 	hlist_add_head(&as->hash_link, head);
 
@@ -978,9 +1004,11 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
 	struct vdpa_device *vdpa = v->vdpa;
 
 	if (vdpa->use_va)
-		return vhost_vdpa_va_unmap(v, iotlb, start, last, asid);
+		vhost_vdpa_va_unmap(v, iotlb, start, last, asid);
+	else
+		vhost_vdpa_pa_unmap(v, iotlb, start, last, asid);
 
-	return vhost_vdpa_pa_unmap(v, iotlb, start, last, asid);
+	vhost_vdpa_charge_maps(v, iotlb_to_as(iotlb), iotlb->nmaps);
 }
 
 static int perm_to_iommu_flags(u32 perm)
@@ -1011,13 +1039,18 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 	struct vhost_dev *dev = &v->vdev;
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
-	u32 asid = iotlb_to_asid(iotlb);
+	struct vhost_vdpa_as *as = iotlb_to_as(iotlb);
+	u32 asid = as->id;
 	int r = 0;
 
+	r = vhost_vdpa_charge_maps(v, as, iotlb->nmaps + 1);
+	if (r)
+		return r;
+
 	r = vhost_iotlb_add_range_ctx(iotlb, iova, iova + size - 1,
 				      pa, perm, opaque);
 	if (r)
-		return r;
+		goto uncharge;
 
 	if (ops->dma_map) {
 		r = ops->dma_map(vdpa, asid, iova, size, pa, perm, opaque);
@@ -1031,13 +1064,16 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
-		return r;
+		goto uncharge;
 	}
 
 	if (!vdpa->use_va)
 		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
 
-	return 0;
+uncharge:
+	vhost_vdpa_charge_maps(v, as, iotlb->nmaps);
+	return r;
 }
 
 static void vhost_vdpa_unmap(struct vhost_vdpa *v,
-- 
2.55.0

