Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021082.outbound.protection.outlook.com [52.101.70.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904397080D
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818203; cv=fail; b=A/y46R6qoqQru2KnM4CmKHawS77vYeZYreG3TR99pYmp+XLdDTFXn5y2ez+CFB0ecbLnyuYty3UziIqfdnMHlFNv+hX187736P/JvvObNVN4aMHJbMdDnkmUvnUSEJpYl+SWhzEVsp1IoYcSPiZ3tzN/Z8ACkzc1wWW3ApKpgzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818203; c=relaxed/simple;
	bh=ZTDHEbW4gHj+C4Tdfp4dbQxhOCrF9LJ5/amxqvDmq3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M3v9+FzgL4P0MKpjrZNVkJlvhCXwIavAelcPi2ABtWpHe9iUWthSPEwA2ixJ3BXQWaERha20PR3caADfkBG3pfFYEAjlcJY/1+J9lrcFNfnrSjKD2qQpHFpL2EKJS7xS6h4mfTcbiBUl0edm+iG4rcEXhjHe2140HTdtnXVtwCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=k+Xqk6t1; arc=fail smtp.client-ip=52.101.70.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="k+Xqk6t1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJTGcF6wdjffcZLFEnBxWHRUcFXxXmYrtfpbXcPSIV6SdrchaJE+2t6sgJN+dANeL0o+fdbaI6nfOSJZu4mhNyrHYavIlnnvbx9dpmvKTLOZT0xrCRrT4jAKwWUOca+UqPlLl1R4m5nmypLQwa4drKeWJS6QmkwTN8JbxfLUIDLKmc+4kOBZy6ItzzsYNG2byNOl8uPp4Xj6A/4bCCXkoCVUtzZqcZGzQSD1MsMCSkDqhwzull5ErXQyEpUE6EEiCSM3eeJbYUtLRqWeqSG/o9Fh9Lrec2ReczYqUK7FqzgAgLXtuvL8NbvPPjzIz4wUfFX08fvGd3BXZ5kpNzWQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MnyGQHvEHMWdO0SqhZ49gJI90vHAob457AtvejnptI=;
 b=q2H/uH6XzEkyiAXCNLKouBAkfWiv3qgT0Hg0nUiCgfdq0j11KSBCp+HW/ByUBWaLOlF048SNsuZFdK8p0BsA2O1Co+UE6Xi4SsACkG9XC8t13VSEU6uAncvZNsNq161JaSrUOXgbryXoaGRUksGWirexsmUfBvvZplXvhYf1+wD9Q37jZxLKpd229h8htmPxoMcmR0DB65a75Dbe/GHZJRqIhb+hPCIsqii/FF5fblWwZy46gb2hWbb0n3OwyM8aubaE0q6FppdsvHvONeXJ0E5zaXT5wJeAnn/jZarSXxMNEiulkm56YivtwP9t1PTpDz+wwuv3RvqbCXnIaJ5cDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MnyGQHvEHMWdO0SqhZ49gJI90vHAob457AtvejnptI=;
 b=k+Xqk6t1kV0qaXTy+igFAiGoKH6/mEYvGEMs/ZVnI0IW10yuyND/q2yhKmUUHi2VqMLfVvFJk9SNhLbn1lSdkMmmg6TGCqEC1waICVAyGs6xk5fO67y8XNraddR1zFJw+BAuiAlLVvbk3cbdjMIsCvebh0tOUU/sarQKQ3FO2GI3ewZvo8AmvJV8o5oz3PM2diVUScwNVUltAfbGcctkAPvRdPZXX5sbC6kdd4MdzYKpDeMvmMSN7qyTDZkgu4OlAC2YTSdRkNbsp71g7J9yCsKt7vOat7bKqWS+DteKJY5+/AV/mhKsTS5KTHBCo6qwgzlKno23lPRIQMX0+TfXwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB5825.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 14:49:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 14:49:55 +0000
Message-ID: <c631dabe-ebde-4b4d-b930-d78db4cbabc4@virtuozzo.com>
Date: Thu, 23 Jul 2026 17:49:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, ptikhomirov@virtuozzo.com,
 den@openvz.org
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <amCPLOrnpYmr5n0p@sgarzare-redhat>
 <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com>
 <amIe79X3j7GxDBdO@sgarzare-redhat>
 <f21667c3-64f1-40c6-9941-9453af173eda@virtuozzo.com>
 <amInL2hPEG9ejUd0@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <amInL2hPEG9ejUd0@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd95441-1394-416b-7b08-08dee8c9a8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|10067099003|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4cuYbM//dEbDYR5ENJdSXu68yPetIs9OFKJ73uqDEhrAc0iNKAKMSj8bF4gd7L5GYtPPqvNI7ipd0ytkZYAjCRpBr9qbpSH6TMNqBCw7RV08zGwEB1UAHJAiwrJpmTgEDjkXXSauTGfm9w2TGC7n8r2afask1I7mKkyMsW46dw5fQBeEw7EJxpU2Ro8hfNoVBDE3+JV6F80gb9++GJ5MRxvQmNQVh7PtPeqDJ9qAp5IFAre5CHOs6OTevUgL3ZDkaX9TBfjHwsFJQI4dwG3T9HbcVHDFVmZc/NrapUOSUTaQggqEfiZ2juJByVlft29jqjdtmguAakCiE8A59nXI0R6mKUjssRmXyE2QwX2HXmYGo1WHXaFES5+MfpGAEFsc8aaCkU+lXtO6Q+KCgI467JN+JS2KsEqlL/XOYKeZeAuVnscCjHppjMJ68hsI/d1mAZCUVQ4zDSB+YjynX/koIqT5cRKkGfkXe9tQPLuCofzGwYqkzIZR/R2EltKYYt7Y/o2k6Dionp2JiOdb+/l7F6YpPIW/im0phdD7aoEsFZ3u9xcgvqZEiX88tvLiXsHnXxPPOf97vvqA0HHlPJdiQ6pTpocIuMgvGNVZBSNLZIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlBVZzhsZVd3d0J1SEJCcWFkTStRdml1cHV2WUc4M2x0N3c3Vkd2K0swdTVT?=
 =?utf-8?B?SkxIQWplZldBQzF3ZW1Xc2lUMVg3S24yOGhHK3E4MVhBc1FYSER3b1diam1C?=
 =?utf-8?B?cDFBN0k0RzhoMFdBK0dVckhCUTNGREszaWYwdCttSjZQR3FDZ2RwbXpvWUFU?=
 =?utf-8?B?ZFVTdlE4T05lOU0xTEh2aWUyMEZqOFE0ZW9jTnFNd1cwME1GNGV0SURtWEtX?=
 =?utf-8?B?cDdsY094SmtxT2xMbWdZeGNmUERTRVJJOXNIUmU0YWpNaGhIQXo4aktxNzFP?=
 =?utf-8?B?WktLQUtpLzBZbGhlb25jWCtTb1E5ZzZBRzdvWWhNZmNlTGg4c3hGSFQvekJL?=
 =?utf-8?B?ZFN3R1c5STlGbFN1Q2s1QmJ4by9VOE4wSXVZVm12bmZEWVFkWFlLRTdWRkhw?=
 =?utf-8?B?aEo0VWxycnZPMGNYempaekxDbzlSOGF4ZXhycnFPeFgvUllhMkVVeTlETXhP?=
 =?utf-8?B?V0NFNmJtNEYrcGtIS0pHek03WTNPc1dEOEMyQ0hWb1BMRXJXQmxQMzcwUUlN?=
 =?utf-8?B?UUh5SHM0UnU1dWY4TU5RK21BTXcxajVFL2NlWnNHY2swL2lmZzM0clExWWZS?=
 =?utf-8?B?WUp5VGVYL0ExWFlaY2NrbktMZ20rZVl0V1JwWEhkdlhUVGxEUDVIZ05XL2Nw?=
 =?utf-8?B?d1c0ZnVvbWhpN3c3aTNxWGkxQ1ZQdHVDQ0tQUVc3dVREYktMTHhXMCtaK0pm?=
 =?utf-8?B?UlZabkFZUTEzcXRvWFRGZExKNnZlYWZEUmh6dWlvcTUxTjVxNVhRSkIxL1VB?=
 =?utf-8?B?bW1qZ083b2k0c3d5SjBTZldjMitoRVVzalBjWk5EdkI0SnM2eVpjOHpVODVD?=
 =?utf-8?B?NXk1elBqcjQ3Y3VvTkNEZjF5cTBVZVhUVzg2d0pDS3MzU3dZWWgzcUdENnlX?=
 =?utf-8?B?OWpBME9hU0s4MFFmNUR3MXRHWTN6bjZPNk1NOVQ1Njc4c013L3pmNm9xR0tw?=
 =?utf-8?B?cUVHWUI2V3VDclM5SnRLVWN1eXRJZFhpT0VJTDNyVnlhbThFb2NoQmR5M3J0?=
 =?utf-8?B?MDUwK21JV3VLUG4rWTBpYmtRNGFINXcvZEtVblRsNTNESmNHTlV5ZnliVXhZ?=
 =?utf-8?B?YXJsdE45aFlrcUNiKzVwNFZ1R3VFeHlOeVhRRGp6OVI4NUV5TUcvU0Z5U0Jr?=
 =?utf-8?B?eHMrb2NlWlk0Z0Zyd2x1bk9zWGhiVUlyaXhzNzBPenRVRmQ3M1JoeGRpb3Zl?=
 =?utf-8?B?RGcwVXVOMjc0NVdjRmNjcVpVQ1NkdU1rTVUvZldkNnZtMGUvRTB4L3N0b0wv?=
 =?utf-8?B?cUNWdllRSmhWU2Z5VTM0YlBHU0pXNW8xM2lYSVRQVkcwVXVTMmhnK3BPTWU3?=
 =?utf-8?B?UzdSMDUya2duYTVDaU1CRzlWcHJqL3MwdVFpc0hDNGxpQ0hTYkhDdG1udjNR?=
 =?utf-8?B?TTQzdlhlQURGNnRLdmpFQXdmdlZzZmd0WkhxaVUwUGJSSGRMK1NvMVB1NllJ?=
 =?utf-8?B?ZlJ6eXdEWDZLcE9PK2pFZXJtMWRLMzRhTFEzK0hCY21CS0ptU29KakpnTDRT?=
 =?utf-8?B?VFRYMm9sZmQ0cmFodUY2R0xrVmNsa0F4SWFmNmFrZjFFdDhidzNUSEt1cXZn?=
 =?utf-8?B?UnUzMnVRdVRsVDZxWmtGV3QwVGQzNE5SWUpSUGcxK1EzNlRKVU9XSS8wYTMr?=
 =?utf-8?B?TVQ2YlI2MVVPOGpxZ2xvYjZpZ1dnOWNaYVJCWXpsMmhqaUlWUFlUby9MZnZi?=
 =?utf-8?B?L0tpdXRSMTJQUUJFNTlHMjFwcW52cGU1WUtXSmdZUHdmQUNqZjdZdFp0Mm9R?=
 =?utf-8?B?QjNkSHZHUlpLeEZ4UXVuaUpoUFFiU0FsWitIc2cyUnYybG42QjQxbnNwdjR5?=
 =?utf-8?B?ZlZ4V2pLTkg5bE01UkpSWXdYK2MxQlJpSG1GcU9DVnlmZXR4cUJpc3hZTnFL?=
 =?utf-8?B?OU13SlRrdWxhNkpHVzNHcTNFZ1pJNGV3YVk5NWdZenRsMWtkbkFIdmFNRmI0?=
 =?utf-8?B?T1c1SjEvMldHQXF2T0dMYVJGWHV0Ui9LUGwyZ1JKY1hXMDZJRzVxRjJ4eWF5?=
 =?utf-8?B?eEtTM2c2dGVJTnVmNlVYYklpN2plWVVmZTFObUNNZGVGSytldzF6eGFYNC9o?=
 =?utf-8?B?eEY0YUhvVHlYek5WMDNzT04wYjZWZ1hhTmVaTUFHU0NzQllsL0kvRzRDM05G?=
 =?utf-8?B?QVJNZzEvV0VRbXlNWitiQ0czVFFBRWF0S1ZwUmtkWXVZSW5JcUNIK0pXK2Q1?=
 =?utf-8?B?K2dvckszb1VwUG4xd1BNeDlKSWpBU1p1WmYrQ3RFN25jNkcwN1g5ZVlyTHJ3?=
 =?utf-8?B?dmxBbVd3bUJOVWFBSUhxdTRwbzJHWVFCY05MZ0lpSmtselVSekxlSGZDU2k3?=
 =?utf-8?B?eFd3QTZQVDdPUE16b0lvaVd6Vk9zYmN2TDQ4S05YRWlwODJBS2dIanhySCtQ?=
 =?utf-8?Q?ozBPHxlPgbrkV3lg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd95441-1394-416b-7b08-08dee8c9a8e9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:49:55.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VsaLlWYKvW4zJbqYkD4O3LChKyJfTfc8n0EwusHJUz4X3Og6zLR1AM3SsXGcXnAHY9EjCxHpcMc2CcRkq1bx3UBMbp4LDt/s3dnoRrhWBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5825

On 7/23/26 5:39 PM, Stefano Garzarella wrote:
> On Thu, Jul 23, 2026 at 05:29:12PM +0300, Andrey Drobyshev wrote:
>> On 7/23/26 5:03 PM, Stefano Garzarella wrote:
>>> On Thu, Jul 23, 2026 at 04:57:47PM +0300, Andrey Drobyshev wrote:
>>>> On 7/22/26 12:43 PM, Stefano Garzarella wrote:
>>>>> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>>>>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>>>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>>>>> the vq->worker pointers and immediately frees the workers, without
>>>>>> waiting for a grace period.  A caller that fetched the worker right
>>>>>> before the pointer was cleared can therefore still be queueing work on
>>>>>> it while it is freed.  And even when the queueing itself wins the race,
>>>>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>>>>> future attempts to queue it are silently skipped.
>>>>>>
>>>>>> None of the current callers can actually hit this: net and scsi stop
>>>>>> their virtqueues before the workers are freed, and vsock unhashes the
>>>>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>>>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>>>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>>>>> the lockless send/cancel paths become able to race with the teardown.
>>>>>>
>>>>>> Fix this by clearing the vq->worker pointers, waiting for a grace
>>>>>> period, and then flushing the workers so any work the last readers
>>>>>> queued runs before the workers are freed.
>>>>>>
>>>>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>>> ---
>>>>>> drivers/vhost/vhost.c | 11 +++++++++++
>>>>>> 1 file changed, 11 insertions(+)
>>>>>
>>>>> Sashiko reported some potential issues here:
>>>>> https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4
>>>>>
>>>>> IMO the first one is pre-existing, but not really sure it is a real
>>>>> issue since happening when the worker/vmm is going to be killed.
>>>>>
>>>>
>>>> Sashiko claims:
>>>>
>>>>> Will this leave the queued work unexecuted and permanently break the
>>>> virtqueue by leaving VHOST_WORK_QUEUED set?
>>>>
>>>> I agree this issue is pre-existing and doesn't have much to do with our
>>>> series here.  It looks real, but in reality should be harmless since we
>>>> may only hit it while the device already dying.  Means there's no VQ
>>>> state to be saved.  The only potentially observable artifact I guess is
>>>> a warning here:
>>>>
>>>> vhost_workers_free()
>>>>  vhost_worker_destroy()
>>>>    WARN_ON(!llist_empty())
>>>>
>>>> So more of a cosmetic noise on a dying device.  Again, not relevant to
>>>> this series.  But one optional way to make it go away would be to clear
>>>> vq->worker under vq->mutex in vhost_workers_free() (mirroring
>>>> vhost_worker_killed()).
>>>>> The second one also not sure if it's an issue since the sender is not
>>>>> lockless IIUC.
>>>>>
>>>>
>>>> The term 'sender' is confusing here:
>>>>
>>>> * vhost_transport_send_pkt() is the .send_pkt() method of struct
>>>> virtio_transport.  It only stores skbs into the queue, doesn't process
>>>> them. It indeed is lockless as it doesn't take vq->mutex.
>>>>
>>>> * vhost_transport_send_pkt_work() is the .fn() method of send_pkt_work.
>>>> It's called by the worker thread to process skbs in the queue, calls
>>>> vhost_transport_do_send_pkt() which does in turn take vq->mutex.
>>>>
>>>> I think sashiko points out to the former.  Still, I don't think it's an
>>>> actual bug.  Look:
>>>>
>>>> 1) By invoking flush, we wake the worker thread:
>>>> vhost_dev_flush()
>>>>  __vhost_worker_flush()
>>>>    vhost_worker_queue(flush.work)
>>>>      worker->ops->wakeup()
>>>>
>>>> 2) Then woken worker does:
>>>> vhost_run_work_list()
>>>>  llist_for_each_entry_safe(work) {
>>>>    clear_bit(VHOST_WORK_QUEUED, &work->flags)
>>>>    work->fn(work) // for send_pkt_work = vhost_transport_send_pkt_work
>>>>  }
>>>>
>>>> 3) And then in work->fn() (vhost_transport_send_pkt_work):
>>>> vhost_transport_send_pkt_work()
>>>>  vhost_transport_do_send_pkt()
>>>>    if (!vhost_vq_get_backend(vq))
>>>>      goto out;
>>>>
>>>> As you can see, we return early in case backend was unset.
>>>>
>>>> So after doing this flush, we have: 1) QUEUED bit is unset; that makes
>>>> send_pkt_work re-queueable. 2) But the queue doesn't actually get
>>>> processed, and VQ state isn't actually touched here - so I guess
>>>> Sashiko's conclusion is incorrect and there's no actual bug.
>>>>
>>>>> But, please can you double check them?
>>>>>
>>>>
>>>> In general I'd leave this patch as-is as Sashiko's complaints aren't
>>>> very convincing so far.  If you want I can add another patch which wraps
>>>> NULLifying workers in vhost_workers_free() in vq->mutex.
>>>>
>>>> WDYT?
>>>
>>> Yeah, I agree, about the other patch, up to you, but I'll eventually
>>> send it separately.
>>>
>>> Thanks,
>>> Stefano
>>>
>>
>> Alright, then let me resend it once more along with this 6th patch, so
>> that we don't have it uncovered.
> 
> But why it should be part of this series?
> 
> If there is no strong reason, I'd send it as a separate patch.
> 
> E.g. even this patch in theory may be a separate one, but this is 
> related to this series, so makes sense to have this included.
> 

No particular reason, just while we're at it.  Alright, no respin, will
send it separately.  Then I'll consider this series reviewed - unless,
maybe, Michael will want to take a look as well?

Thanks,
Andrey
