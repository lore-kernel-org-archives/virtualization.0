Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46D1F94A
	for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758948321; cv=fail; b=QhdH2WvY42X5nmmI8mEcg7IPsJ1WebZS3ItUo7sW9tx6tsQgKYW+O2z8UdCM+ePtNcRbyUHEUXV9USsKWCUr9789/FO0CyJkyS65P4oUfMx4tj19X5CwRu6cegFdyRf1NxdMy2a3oHReyqZgORYrsUr3AO7qiBv72VD3gszG8TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758948321; c=relaxed/simple;
	bh=Y1Yuq1yX48xfaqa1yUyJkfUXkY2cB64GQSqE00Jrjak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i6pvbSg4QzP6g+oQxI21M7R2e0DFDJckq3yr9wCjXOOTGGvA3K0luiuxZ0Nf7NBFqJw+3PCYxL1n+togTMShSDFWol92sZiqZpurdUso857q12oh98J0ATsVbDQbs2/3ku7iR4fZi7DiNl/2dCQydhdXocvN/rDc7T+UUtK98Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EVtnmzA7; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EVtnmzA7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+0J+SOhO7s1DcwJi/JJbs6j163OQsCDd7dw+Ak0CMkKsFCsXzX+TLGlDarXtuO0YiObKkFCuc030yP7SjbCY5L7E3VO4ZdrBvp+4ih5zv7D80WXzQoJwmdLxXYJeKVJVOQhx9P/eFmHTtg+qsiatzZH19RSU70lNupWEqgDHYLtkzzewbO+vVouiinerENoohC/ZXWJ32jdDpPJrjmIHK4/t/PlQO6r0yIEEFZfFkTC6MnCueRIlyW4h4P7Hv7KftZW+mL7YQN+3+qE3uEQKa8NT2T9bpM7fzBWpMW7Qqc7szgOrIeRZ+1ULZFSQzh5aaaFVrw6v3Avvo05zvxK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/c+k7UsjiZx3tS7RtfUOoyaL4pluSS9jOZamajC8U0=;
 b=k5q35bcgACt1PtN7FaXGEirNXyYwyZjD2qx+G6DrIRE5qXow1XsmobhDFVB3M4Fyn2bqOgTSxhOK9vkD6ALUT1QbG9mn/54CNrkHIqYHQL0GPqmA30C1ZYVJ0oBAnBSfi7Gzc60z+4cRAWSg7E0/sAuyjM8CHLGXWvM2cX3dPG0M9LMHSzb2Dy63Hg3Lxo4s959f78tAWfmnZicCRKnsJ7qk3n2BSOvYa5SIFbAfuHkVP6SGqXV/ZerifGzFQdMGYIu/Cs3C0Djtv/awDtTxtPr4zJ6gJhMemQnbkNI8BilzCfw1xTcTUhexPoMtBuKkAyDpAP5xX0lfmL1cA7x3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/c+k7UsjiZx3tS7RtfUOoyaL4pluSS9jOZamajC8U0=;
 b=EVtnmzA7/verH1LXR9GYCbxz3XN1QlM80gQW6iHqhEJaLp6E2R2leLQT+GBCS+4ObvKzHyhVTx4Pmrz1zRzPFyxSP+NH0Zc4Q3GvnhkESojGwRstrUn8am6ua/OEgvQvtZ3nFtJisRwdQ9b38HSA3mGv1r8Qt7fvqE5OXnld0AT8U02FekX5quR5FLfwBAi7oqb8ocsiLlSW/JnjeI5SF0BZ0B3jxHucZZJaH5MWrtrqDU02WBqNMWW5PgJBxmMpMV6+b4zwCtQ0lrQxiRLcRE3Edq75nfh26x1LGGzROo8uMEV3L267Vt62hI99xjVRBu188wVF+UfLBlshPh/+TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Sat, 27 Sep
 2025 04:45:16 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.013; Sat, 27 Sep 2025
 04:45:16 +0000
Message-ID: <f4b5cd64-2550-4707-9291-8ab14f72544d@nvidia.com>
Date: Fri, 26 Sep 2025 23:45:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/11] virtio_net: Implement layer 2 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-7-danielj@nvidia.com>
 <20250925165406-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250925165406-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 544f1d4e-9ac9-4d49-7aac-08ddfd80a731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHhhdWVUZTJ6S2tzNlFheTVVRXhTb2hOV3JEVm04WGdieURoV05MQktSVmk5?=
 =?utf-8?B?UjBsYlE0ZGR4MlZpQ2pDNDNrdG10RUhJQXJYOWJFY04wSkVDT2JGTXRWYTdP?=
 =?utf-8?B?SFUyVFlvUm0wRDk2d2dBUnQzS2ZFYzVzcXJOQ1poRis4T0JHSXpYOU9PbHVa?=
 =?utf-8?B?YjBGZnIyNHBWQXBMY2JtZWJjdDR4dU1RcXozY0IxMEh2ck11QXNTbndySHBU?=
 =?utf-8?B?R3pnZ1ZJSmo1eHE5SlhTcDVKRTZySlUxRUwwQlpjUDZPWVZYN3hiRFp1eERp?=
 =?utf-8?B?WHlSTE5CS0lPeUI4V3RZZ3gzbzFhZkc1RncyWjFNbTVhV0dKaDFoZThaTmts?=
 =?utf-8?B?MXVqaDNKQW1hcmFvbzVPbTJobURGZFgrdFovbU1lV29peWkvWWE2NE84OUlR?=
 =?utf-8?B?SEZiVWxsbHZyUG4zelQ2U1l4RmFGM1FVNGF5K21pVjBwbU9BSDg2VERDcURh?=
 =?utf-8?B?T2FMdVV3dVNvSkNDYUFORzFmN1ROMmQ5UEp0R25QOGdrWWo1dDRYOXdZeEhk?=
 =?utf-8?B?ZlArenhSbVBSOUMyRTRkU1M4QW4xaElqMzhqWlZLRVp6WGJiVGtOK0wwVCs4?=
 =?utf-8?B?c0FuTnU5eVd5WFNWMUJpQ0tNeGZwRm9rRkFUNU9DMzY1LzhzYzM5S2llZ2dz?=
 =?utf-8?B?dkxGcE5RSG5abDE2V05VWnJ5WVczSzkxS2hFVll0ZVowdXhXWm5KMEFMbXdz?=
 =?utf-8?B?aXdKV3RCUlMzMFRSemR2bjJsT3hKRW42NEk3QVdOQzNSL0tKT0FZbzc4R0tE?=
 =?utf-8?B?cTRscEM0K3NiNm1GbDVOWDlyb3psaGErOGtuNCtZTUdxNXNsSCt4WmpDRmR6?=
 =?utf-8?B?N0NxSnk1cm5qOE10bkRkaEh0MHdKZmdqMzJEZm5Qd2tmTUo1QWRkOUl3ZXFj?=
 =?utf-8?B?cFdNeTBRdzV1RmltbzlEUEtSRS9oWmdzZWlDbW42VVNIb281U0h4eHlWU0Fz?=
 =?utf-8?B?NzlzUnZiQVRKVm5Tdk8wcnhBWUU1Nmd4UDdzRjJNWVZSUTVuS2lXVXN1S3pU?=
 =?utf-8?B?WUR1ZWZiaEd0T3Nhd0R0aitkLzhFQ3RBU05aek1pZVJzT0hwWlZqY0NjTmVv?=
 =?utf-8?B?b2l6M0JUTVd3VDVuejgySFlpYVhlRUwzOGZEMlVQWERkZFppTFYyL2RSWitl?=
 =?utf-8?B?NHU2TkNYd1RDVCtGZ3V6WVlHNm9zMjcwREozWjNBMjg5TEJyaVVNU3plSWNH?=
 =?utf-8?B?dDBDTmJyeGdIOFdRVStVRWlsUncrQlVqeElMcFQzYUtJZzBDb0R5R3FPcnpn?=
 =?utf-8?B?ZG1DcEJDQStiZ3doYzRzaDhqZU42amlWa01YNUxSd2NzRndMM3JCdzlYOTY3?=
 =?utf-8?B?cGpYRmQxWWxXTytxdHhTYWNpalVCZVo5RThXSlk3b2QrQ2dNYzdWM2dpL3h2?=
 =?utf-8?B?UnVEVnRTaFJsODZIQVpCVkI0enROWUtvcnlpdEQ2SkdaSnJBMTZXOVVIWTNV?=
 =?utf-8?B?VFV2TmVDTGpGTVZJOWt3UjBtQTVZNkphSU9ab1hFenN1NCtjY0hWeHJwVjkz?=
 =?utf-8?B?Y2FMUldqcExiYSs3TW85VEFCZEt3eEMrR0lMVndndnUwT0NiRVVpdm1ia0JQ?=
 =?utf-8?B?UmhJOEJxM0NIMFhBM29tT3FxbThWRTNCM2FrRkdjVEhJLzJ2M2FCenJ0L3ph?=
 =?utf-8?B?VVRVYXF0bFhqNGtiaGhvd2tKWGN0eTIyVlhxbUUzMVlXR0RPZGFteUdxU0Mw?=
 =?utf-8?B?QXJXWStJcUNBQ2o5eWZpNGo0Q2xNaGhDakRKNXd5d0FKUmRoanQ1YzhlWVZ6?=
 =?utf-8?B?OXhES21NNW41T3Q3a0JGS3FRQjVYUWpXM3d6U1lxVWVVUlhiR0xFeTdSVzBC?=
 =?utf-8?B?ZFRTWWtTYlF0TzZLdTRFbXZDTGxYeWZSNGxzMWtyRjhkOHA5bUNibndpS2xw?=
 =?utf-8?B?cDc4cXNpM2lOWFN6bUZBWk53UEVZeXhVTlVvWG5JSjAyWDhuMFZNTEtweE40?=
 =?utf-8?Q?cz3hru+4q+/r3UYCi5HyhQxgsFJqNech?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmpJYklZUFpEVXpWdFYrK0dmb2FYYS9zNmMrNFVkS2dCZVNaeUsvRHJHV1pF?=
 =?utf-8?B?RGttWk83Y1JUemoxMlNRVWNvdVljZjM4bHZjeFZONWFEMVJ1WjRvQ1gxMWQ1?=
 =?utf-8?B?eTdKTGVDdkxjbTFtd1hna3h1eHR4R0hlazUrZmVTV1dIb3ZTekdFY2pTRGw3?=
 =?utf-8?B?YWQySThjSFBBNWdaWnQxRG02V1NMMURWTFlhbWxPM3c2NDJOK1A0WjhTSm5F?=
 =?utf-8?B?Q1c5K1lpc3ZsU3NaK2RwR3FFbkVHVWl5MUk0YU9najRWYjFieTJoWmpWMVhr?=
 =?utf-8?B?eWZvNzFBTWhNMG5GZzFCbGptSmFKMXNPTzFZM2hDcHUyV1RQVmZhaTd4d3NO?=
 =?utf-8?B?b25TOTNrSHhFamtnYTFMcmg4MGV2UWY0Y2drek4rUDZkZFlXZkpMTW9FMjlG?=
 =?utf-8?B?dU9QcG50S2ZNM28xQWhUbElUb08vSFFNQkJmazhUZE90VnZnUnhyT1o0bS9C?=
 =?utf-8?B?R0FKeS9RSXFmTzRaQ3JxQzVvalA5QnFnK1dLd2JtOXNLTkZBUXlnSHYrT1ly?=
 =?utf-8?B?c0hlRGw3VUhXVUVyUGZKZFVJdUVXVWdDR3FNYllBcGFHMS9sdHFPdTJsQVJa?=
 =?utf-8?B?QjBkN3paaDZHSHhhWGNHWGV6aXY3ZnE1TDVSbk81OHVLaHV5N3oyTmh3dEkw?=
 =?utf-8?B?bmZjWkVGNkJFOW9BL0NLc3UxK0Rzek9tRWtXQ05ZOVV1Z1ZFakZ5VDc0SzFy?=
 =?utf-8?B?cEc4dVkwdG1NcjJkMEN5bTdBanBxV3NhcURldTZnQ2RvQUludEF6bWFMRlFQ?=
 =?utf-8?B?UWtOTnZoTUJtbFd5RWVURjdjNzF3amZ0bDZYNDBXOFdMc21TN0lHcDcyRXli?=
 =?utf-8?B?d3ppSm91NlR3YkRmVHBadmEzb2hJNDM0NXpxbllCZ0VFbE9QY3pKYjhWbi81?=
 =?utf-8?B?VDdML2JGdGhCV041QngvS0FWVnNrTFFQSGVqM0Z1bjQyUlJkYnIxSExFenMr?=
 =?utf-8?B?TzVOczdndDhtMUN3MG0wME9oWE5wK0l5SjFMZGFnMDJOTzFLU1pTMEFsY2dT?=
 =?utf-8?B?MDVtS0hQWVl4TDhySWxORTNCWExqZ29BTHNDTU5Qbzl3MFBhajZSZmpjZWpC?=
 =?utf-8?B?YTdvdThDcTVYbnV2NnZRTEdCTmpMMUJDQlFFejJ5L0VrbmN3SFE0aGNkZ3M0?=
 =?utf-8?B?K3lQalR2RU04SkpKZFB0R3VBSURQU1h6ejNMQklwb3Z6VXY1WENmaGxBS09B?=
 =?utf-8?B?YVRjYVF0VW1PZDhNODRmMGRxWjYxcHhWZFI3eUVYbExlY0ZtVWJac3RsWTRX?=
 =?utf-8?B?WklGT1NlZFJndGFzOVBZZ0lPMUNtYTdjMmRhazJzVWRJNDAwRm04QVdMSC8v?=
 =?utf-8?B?M1d4K3VmWHZBZmp6d0xWTTM3bWhEdnkvODVXcktGTUtBdEswdmR1L1BIdm5q?=
 =?utf-8?B?cTVSYmdRdGI4Z2c3aUI4bHNmNkprMDMrcXdmTmRTc2FpZEE0OGRFL3FoT0Jt?=
 =?utf-8?B?MExQOWNYSmpveVgvYTZKQTl4UC9NWThCa3pDMXB5Y0xjUzRJRGluZE02M2JX?=
 =?utf-8?B?TC9FQWpabnRXcmVSUlVmaXg1OHZ3clhiZGdMVm51QjQ4MnBielJIS3NvcThH?=
 =?utf-8?B?ZHZpT0htc1diamlERSsrb0REeXIvclU1Nmh2NURpUm8yV1kvOGlnTGVnS2tC?=
 =?utf-8?B?OEFtWjFLekJjdFFUdlpORzZrRWR2b2ZpMzVsOER4emJWS2h1WU1WYXJEazda?=
 =?utf-8?B?TnlCK3BzWFNLQUVQTXBUS2IrbitFNEZjZ2dTbkFKalNKYWkzeWFvbW5hV3VT?=
 =?utf-8?B?M1NxcG5VcHAwTk4yeFZBUzVTQkJBcmg0RTV0QlM3blh5VzhpbVdsKzBmNnox?=
 =?utf-8?B?VFo0b0RpRGtIQ0hMTWQ4T0N2bVZUMVVMZ0xzNmk5aUZLUE16REljRVM3bWNW?=
 =?utf-8?B?QVNrWGZxMUVyVHZkTGkvNHFUekttU1hZVUdBZldqR2pNYW0wMDYxaHVNRDNu?=
 =?utf-8?B?VVZadDJNUzZiblNsbEFKa1Z6ZVhiQjV3WEtTSkFrQTNzcnBycW9HN1c5dWFK?=
 =?utf-8?B?a1JaYlVlTXZJTCtyeU9MS1ZWZUtkWlg2S1VlNE0zeWdSUUc3YXBEbVdXVGZv?=
 =?utf-8?B?V1pwVlQ5YzROcnhZT29CMkpKMHhFWkx1VVZiWTVCTFVRMmVSQUpNV1VHR28v?=
 =?utf-8?Q?REIP1zHf4+cpz6n9tNJKRKRTH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544f1d4e-9ac9-4d49-7aac-08ddfd80a731
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 04:45:16.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGBJNZx5d3psl3SnLQlBkhqt6yvkMSFxTPtISVW6mpx3LedxfObMPnXi1MrrSGuRII6C5Rremv1nWGATg6gHCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793

On 9/25/25 3:58 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 23, 2025 at 09:19:15AM -0500, Daniel Jurgens wrote:
>> Filtering a flow requires a classifier to match the packets, and a rule
>> to filter on the matches.
>>
>> +
>> +	cap = (struct ethhdr *)&sel_cap->mask;
>> +	mask = (struct ethhdr *)&sel->mask;
> 
> do we know they are big enough?
> 

We know they are big enough, we allocate the memory for each based on
the size of the headers for the type. We don't use sel_cap->len, which
is the length provided by the controller.
