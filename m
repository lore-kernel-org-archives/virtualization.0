Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4E288CC
	for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745152298; cv=fail; b=LHnnoSDIz+FsRtS4A7ugePpta3pB0W0X9pD8ZZSN/x4sYgNv5XMnqiKHGmlyd813qKA4hCKYXUM5lFozWRvyH7mPn+/JKk59SRq59xDoEjLDi/4BSZBXCjuGiWxFlZg7i+MYDLOl3sa5Adnx3/NgdxCfgtwhct/BwzI2iLQk6V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745152298; c=relaxed/simple;
	bh=G7f3Wc1PPayxF/q8TxTY7GXByoP3NsvequTVSJ8U9+U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGNgn6YYDXo/JxuQmzFqNDYCdgKWHq9LGglKe6lseHe7hM5dAOYRHDNfnte788hNQ1kGfWt7IJyvy6AJdG2AjXtQs1FrM/U5DoAsyV9PVzEMDqxAQXeb/5JgnMNEQODKTyfmhDjv0J7R6wRymAyVdTNiw2kkqv8GFq1GTcFdF2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qTXV5Yrd; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qTXV5Yrd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNGLvREAUz+t2IjEgB1W3EwCIa48Przwm7aoGhNbYutd6ZcsPA8wdE46Ahu9pGS9TdovUwiiilBiIISZXLgSbD32IMVr0LRUnQzweL1AoEktIEAiEGaC6DP23aXiHqp/WHh5AdzZHK9OicXtrjdSj9pZ/MfpDBWV3YXQ7BTgEWh7I0TeTNku2vMyAaUJPGSnQ0I/CoX8olgaQOF3t/in61mU/u8b6WFFAYdVJk7gjpGroHg+q2gK7pWqIDIoHAuYNpvXQ7oW62C8+z0uLPlrFEX4iUhizPDLnRZ81vBeEW+m2LKlKwE76HZRhtNNyrKymIKc+PUpj9bXyi6LkIOKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugaRabC0zQU3zp2g7Y0/ihnBu8umq45KAZYLsiInAa4=;
 b=thTi9zJMMfE2ZxukldOeWBRCINbQhn/bIL+zJQ9r2Ceg3UIUAwLV9+7GjNclz0QvMTU3WvkQgTMmjiWo5IBNPceUQmNBAj1JXjJdWCLUEOXDcDKCt2RHaCcMlDcTudOqomAu0PhJatzYNycXD7kfWkPsxZFxKertqy1Unb6PXLMtqqHJClnyBgB3UInODm0Ww7pgXPLLzgB75tQHkQEC8zWBh00VbRD4Wh1wPUr3Dm3rY98A4hYtEEczHTUydug/llv5BrV+81ZnXKVnQT/83sEz8xQXybNtug+yBUAQtcEtAYAsRhlXlprEI6As40fZHu8xlOgQzozPz5If9qBnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugaRabC0zQU3zp2g7Y0/ihnBu8umq45KAZYLsiInAa4=;
 b=qTXV5YrdRKRCwEBrIgUyXOVuYUd6caAVyX+U299eo7nwE5bdMipUZitZN7Ta3XzZojIEQMTqEINKtJKxesqsKGyRTCZSV7L5CKijOVgmVIjpPmJN3W4v6nN76sqA0bP2B3DuceqAbis3JCXbghTLJw2qWmQltcFouuz2N2ZXL6eDFN3H1GYwk/iE6IDoNi/YuYfqq3igQIaIByk+Nxaribeo5XSKI906ABALwMkF+YvfZMycSyUiMSY6G5+RmDZGKBq/fFnjZSaQhyGFbEJReZAYYXUa4ATJzPA8894KtccpSTDnFO9U8waZ8emVbXxui2JqF6icNp6c4MewDf6lbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Sun, 20 Apr
 2025 12:31:33 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%5]) with mapi id 15.20.8655.031; Sun, 20 Apr 2025
 12:31:32 +0000
Message-ID: <b9e80050-9d09-4ed7-ab05-6a23a8e6e6a9@nvidia.com>
Date: Sun, 20 Apr 2025 15:31:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-pci: Add admin command length check for device
 writable portions
To: "Michael S. Tsirkin" <mst@redhat.com>, Israel Rukshin <israelr@nvidia.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Nitzan Carmi <nitzanc@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
 <1745147945-194225-3-git-send-email-israelr@nvidia.com>
 <20250420073230-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20250420073230-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 098cdf3f-b797-4e5a-e64c-08dd8007486b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVcxNzUxWVNFZlg2OUVIS05zNHQ0THBLd3hDajdRSlMrcFJrYS9xMHVmcStx?=
 =?utf-8?B?T0Y0S3IyNk5OOFhSaVVRNHVlaXczaW9ZRkpjbGxjM1ovSnJhMlhlOVEwelps?=
 =?utf-8?B?d3N1RnBrTnFBbnltMVkvTmVVS3JlLzJwbWpvR043Z2c4alhDZzJPWnRZU2xI?=
 =?utf-8?B?RXZEM1R0NlA1cmRvYmw1Y1lYVDhzRHU5VzVyRWxtM2NMR3hnU0pDUEwvUy9C?=
 =?utf-8?B?eWRHQWRvV0hQVVJ3QlB6ejVCNDZSN1Q4TzV2VG9yRytvQ2hzOHBlSnpoQzZB?=
 =?utf-8?B?ekhGdEZYNE9hZ0hoRDFhRElFaUc3Vi9McnFCU0lpQldVYzhnclBnYzBqT2Zu?=
 =?utf-8?B?TWZrQS9QWXRmeC96VFZFM3MzMzUwNmxmQkJkTnZsbUpSbHhsV29Od1pUWUJr?=
 =?utf-8?B?akdBOVd1Uks4ZjF6NitieGhwSFJWSFlNNGpTL2tMWGowSC93WENMQ3YxU0pF?=
 =?utf-8?B?UEdLK3Mxa0pKdm1JU2JHaDgyMkkrNVFKN2ZDc3ZTODBZSmxvNkQwTTlwMWhK?=
 =?utf-8?B?ZUtqVFk0dld2NnZUZGs0YUNHWm9jZXdiWDYvK3d6VVVBeWYyNGx6d0gvN1Ez?=
 =?utf-8?B?d2F5Szk3SDJZVC9ya0g3bkpOWHpKNGxuSkU4a0oyaGlqbWRNN282RlBTQ3Zy?=
 =?utf-8?B?N3J4NjRiSUpvbVBOdUNiTGlKQzh2bTYzRGFHanlhci9LdGZjZFNXUWFhZEdw?=
 =?utf-8?B?WmdQNDYwd1ZaR0h4QkVubFpubXhtdzY3TlZra3dSdEc4RFd0TDdiL3JSZ2lM?=
 =?utf-8?B?ZW92eWw1bEhrUEJLRzBia0JwZnBqUFE0M1BqTXlNZ3BxdXZoRHZORWhrZ3Ur?=
 =?utf-8?B?d3Rta3p4ZEVIRThkeUpodlRuVk5yM1F1M0RPY21NMmM2eFdWWkVKRG1NbW4v?=
 =?utf-8?B?WWhpbktxTVFpQ1JQREY3dkdhN1k1T1hEbUoyOWtqOFVrQVJhLzlOOUNvZExP?=
 =?utf-8?B?RStGSWNNc2ZhTTlDNWQ3d0pNWHhKSXA4T0E5aGtJbFV1Z1RIcUtKUnhobkxF?=
 =?utf-8?B?WkNqS2g5dk9XRERreHFUUkRhZldMcHhtNlpaL2RkaGRtaTN2eUwyZXI2UVRD?=
 =?utf-8?B?RmYwb2dQM3ltUlNHNndxVlpKa2g2TkNNSUxNaTlUNmdKVjZOZWdxZFA3dXJw?=
 =?utf-8?B?K0EzYzljdjFoWVZwMFg2c2ZObTBCZzJQdkJGQ09wYkM5aUQ4ZVRLRDIyc3R0?=
 =?utf-8?B?WTA4QWMrVk9RWUt2VlR6TGNQMDB5c292RGxYTWYzSTJaTHl5YkRPczVFSElv?=
 =?utf-8?B?OTluZTExOVhpc3d0b0NqbUVvak5QVURQQ3FucDRGemZ6RVBnVjFLZSt5dHBx?=
 =?utf-8?B?dVpVVklMTWNSOWNMdFI3SVZrSnNaV0hNTCs2RHFTU05JZEFHQkxWbFlwcFFO?=
 =?utf-8?B?TWZqS3ZEQ1JScFFXeDI3Ym1QOFNlb1ZHbzdMeFQ4a1pZUldZWm5PY3pqN3V2?=
 =?utf-8?B?NFJYOWEyNlJMb0I2aTV1b1gwUlpTeCs0cmcvU0xQdzlzQmd4VlZudm55clor?=
 =?utf-8?B?WWJySm1YcVNnVVJEbnQxYi9qYkRXT0ZrNzRBM1p6d2lVL1dGR3UwcVJwaEZR?=
 =?utf-8?B?U0ZFbEdYMUhIWk1SdzdSQXROZHovUUtiQloxR0JJOWhqL0lTWjh4eEhROThu?=
 =?utf-8?B?SW13UE1keUNMelp5NVpWY2oxMmNHaWZoN1BNZmJweS8zdms3dXErK3NDMnVK?=
 =?utf-8?B?cmRGbjI2UmpGVGFSbjIxRVdybllob3dDRGhjdmFBVVFFbWdpWVI0YkdKWkpm?=
 =?utf-8?B?cGpHMnhzV3NBN0U3N0kyVThzdEwxSEE0VjNuN2hOcU5OOVFBdE9PV2IwYlg5?=
 =?utf-8?B?QmtmeFdOUHlQQUtPTDhzMnFKbEloNGNqSlhWQ1FaeHk0SHRWdm1HdFJWZXVx?=
 =?utf-8?B?QjFFckZ4WHZMcWdNUDNkYnRnVVNjcUtEMFgxNU4xWmNycitodG4zVDYzdXFr?=
 =?utf-8?Q?m05tzCZuGG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2RKYS8xK09yM1YveDdNcW8ySXdkWERQWVd3UUNyNERpSm9TMExKaTdFR2c5?=
 =?utf-8?B?ZFJodVZZdmhkYnhkYlRPOTlFK1dsMy9UekN1b3ZTU0g0TXIyVS8wRnRIOWRP?=
 =?utf-8?B?WFpOUXV2MlVraXo5UWVRSnFwUGMwTzZlZkZjK29kZjZRWHhJbFVvdWJWeWtp?=
 =?utf-8?B?TTI3T3FqTmhnTkdLRmxCbEJhQ3ZGdUFFaC9YSVJUcGJYVE5HVjZNTFZ0aGlD?=
 =?utf-8?B?TUhoNkh4YVlVaVpvVHRkUkRiaFVBSEpKVmRrU0FHejNoQTV4NitUOVRleUZx?=
 =?utf-8?B?ZkZHSjRHMkl4aGp6Wm1NWVAyUEowZFpDOXNYUVVWbG9kT0pOYTNadFhxbGZa?=
 =?utf-8?B?MVJXSDE2N2JEUWI1VG9pQTFiOGtOVGdJSWNWSUlxRWs4cFpnWXRuby9ES25n?=
 =?utf-8?B?NzdmZWplN3p2V01jOUNXVjJ6V2tqTGZXNlloTEl4bWJveC9IVkpTYmlPSzdX?=
 =?utf-8?B?QjgvY0tOSnRLMmQ0SWJWQW0yZGxiOVIxSElWdUtRMlRCRGNtbWVTdklBOWtM?=
 =?utf-8?B?ZjQvUGdhQkFWbWNBeExjM3lnajlLTkRmOTdFMjdHRFErTTFBOFY4TGgvQXUv?=
 =?utf-8?B?Wmg0SmEwTjVVeTZ5N09BOEFQSmM0aWlIS0VyeDBRSENzK3BPTWhRRTJidmxO?=
 =?utf-8?B?UDQvTEF1cUU3YXRLbGdYUmM2NGpYdDk4bm9oUUlMZElmMHBsZllyNEFpc05t?=
 =?utf-8?B?V1R2TmJnTjkyd0cvaFkwTHJhOUQ5MUFuVjNrcmlRTnRCTFNSTW9BdTBCcy9S?=
 =?utf-8?B?Y28wbi8vZTV2ZE8vQmhmbVNSOW5FdlBCckhlK050bUo3Q090b09TVStmdkVh?=
 =?utf-8?B?Zi90QS9pV1B5WGJvS2RxeS9SbVdHdlp1SkEzb1VvdkducmJTbG1wVE5MUDQy?=
 =?utf-8?B?ekVhRlRWM1c3WStTVmhGNzlWa2tHaDNaMis0NHNlSXZMTzJCSE9oN1QxMnpx?=
 =?utf-8?B?Y1Btc1BWb21EK3QzNkhia0pLTDBMdkpsY3V2bDdKMVdYSVY4eHVqRTlWaHRE?=
 =?utf-8?B?MmxQVHdrZWVIZ20xWHNUbGVaTWVRMnB3Ukk0ZGRTNndIdUppRjdYcGZ6TVFT?=
 =?utf-8?B?aFk4ZmsxVE9RbVZOVks4bTZXSm1DM2JNUFlHRUxGOXZYUHNYcDJBTlpFbUxy?=
 =?utf-8?B?aldkWkJDMHNodEE1czlTNldCT25HWkM3M2ExalR4SW9UdTR2eW44d05RM0sz?=
 =?utf-8?B?dWl5Ulo3dzZlRkRSMW9PYk0yQkZ5eXVJaTJoWUFLNTRuUTVVeUEyVjJoRzlj?=
 =?utf-8?B?R2VkZTJQQVp6cE1nYWd2TFZsd0RMMkRVNWdORCtxTDZVa3BQV3I4MTBzYnJS?=
 =?utf-8?B?REZ3RWVFVWF4dGdUZTZyZFFFbWFUcHZxdEhJbmNudFFkeFk2WG9Zck9ZVEcv?=
 =?utf-8?B?WmwrNEkyb3NkMzgrZ0JWUVJGMHd2QkEwUFA4N081RlJVMHlhRmNrYWhZQjRP?=
 =?utf-8?B?aURRK3FCTENkdHlGM04rTUtUaXFYQnRVNGFJYVJrcmFLWWRWYkpTZDcxS2RJ?=
 =?utf-8?B?b2VVUUtCV2dFb1J5TVdXRUU5ZnYxa0d0U29UVWhzMzZGNW1JbE1DN05mQmdJ?=
 =?utf-8?B?Zkp0Nm1TWnVWUlJrVzVkYktkWjQrejRqMEZuK2J6SFBaK2I1U04yczc0OUxX?=
 =?utf-8?B?bjNwN2F5Y29jcGp4RmVwa0hMdWNYYVE2OWxEMVhZTlBKMkYwQVFMZ2NMU2w2?=
 =?utf-8?B?b0MxRHR6L3NXMzc1U1FVQWxIZTRnVnVjakNwc1FHdkhwUE0vaTRRR0l0VlBx?=
 =?utf-8?B?RFJ0ajBOTzRrK3dFemYxTDNWbFU0di8rTEh1NFNBaU9QOXFvUjEzcDVEa3k2?=
 =?utf-8?B?dzdWRVUzdk1TLzB4enhlWWlTL2t6ZXZXSW1RSEd5QjhIbXB2VjJKamtIYzAz?=
 =?utf-8?B?a3hnbTlaaE5Lbnk5M0VKWkVRM3Z4aDlUdGpyZ2dpVVFZdXNpaXhnYitRRVIx?=
 =?utf-8?B?RGRNRXpHeU5RL25ZRlUxb2tzcHRmNCtGYVJ0NjBuaWpaL1pZVGthNjgwK1ht?=
 =?utf-8?B?bGxMNUZiOXVTVzBGNFc5c2gzVjkwNXNuUDRWa2U0UXlyV3N6N2VOb3lvWG42?=
 =?utf-8?B?YWRqVDdUSTQ4bnNIZFBwTlZYZEVzRmFIQkxGM0ZiMDZpZzhqSVZzRjhYS1lT?=
 =?utf-8?Q?A6qVjO1PXhPJiql/RqlLp76s9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098cdf3f-b797-4e5a-e64c-08dd8007486b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 12:31:32.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXWQVeGPfzW9a7nPFqixei3Zixzm9YGGxM1/LevIccyzJeSJoyzUI5CDX1WZDY51IJKw016JwkjcjJhtluKJJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443


On 20/04/2025 14:33, Michael S. Tsirkin wrote:
> On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
>> Add a safety check to ensure that the length of data written by the
>> device is at least as large as the status length. If this condition is
>> not met, it indicates a potential error in the device's response.
>>
>> This change aligns with the virtio specification, which states:
>> "The driver MUST NOT make assumptions about data in device-writable
>> buffers beyond the first len bytes, and SHOULD ignore this data."
>>
>> By failing the admin command when len is insufficient, we ensure
>> that the driver does not process potentially invalid or incomplete
>> status from the device.
>>
>> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/virtio/virtio_pci_modern.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>> index 7209390a5cbf..0374e86aece3 100644
>> --- a/drivers/virtio/virtio_pci_modern.c
>> +++ b/drivers/virtio/virtio_pci_modern.c
>> @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>   {
>>   	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>>   	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
>> +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
>>   	struct virtio_admin_cmd *cmd;
>>   	unsigned long flags;
>>   	unsigned int len;
>> @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>   	do {
>>   		virtqueue_disable_cb(vq);
>>   		while ((cmd = virtqueue_get_buf(vq, &len))) {
>> -			cmd->result_sg_size =
>> -				len - sizeof(struct virtio_admin_cmd_status);
>> +			if (len < status_size)
>> +				cmd->ret = -EIO;
>> +			else
>> +				cmd->result_sg_size = len - status_size;
>>   			complete(&cmd->completion);
>>   		}
>
>
> No this is out of spec:
> 	Similarly, the driver compares the used buffer length
> 	of the buffer to what it expects and then silently
> 	truncates the structure to the used buffer length.
> 	The driver silently ignores any data falling outside
> 	the used buffer length reported by the device.  Any missing
> 	fields are interpreted as set to zero.
>
> so if status is 0, device can just write a shorter buffer and
> driver must assume 0, which is success, not failure.

maybe we can make a sanity check that the len is at least 4B (status and 
status_qualifier) which is basic size to make sure device is acting as 
expected ?



>
>
>
>>   	} while (!virtqueue_enable_cb(vq));
>> -- 
>> 2.34.1
