Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023122.outbound.protection.outlook.com [52.101.83.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8741CB5A
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376985; cv=fail; b=Lpv9MSMZxYbjqTh57kuwvT4cA5UJhuPnDWva1uV3T1LrPV8rOuW1FQZiTqJPLCMsK7gcWds78KyJ2SjGYVQs3IKd4NTHKiGRcYEaQqoJPrRlakUw3mXoAKxhjUHwROrUUtCdCviOtVwEFfCqz+2HEW51jIEiRMJXwCnwyrUyjbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376985; c=relaxed/simple;
	bh=7g91hpexYY8p3HOXvm0qQ7jCeIyztxC3EHHATB77uys=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMIyk5L675uhzvWZ/u56Hyjo0AbIO6qA85/ofnOmd5toYVH5302V06cAd9g4FMQfdEveWRT/UiSWLddWpezn5n6c5qjJ9Lr3H91mrdfpY0x/2wks32T/1pRnfNezmPAunEmppUNB5HVZ9cY0oGbdas40MfPNEp3CyQ8nbAFTCig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=v2Iio+bu; arc=fail smtp.client-ip=52.101.83.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v2Iio+bu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsY6c1M3Vj5HfuKwxAfZroO12VvTAl8/mk0W6kTLC1E5bM7nfnMnJyRJ8igswdPtvhW9Iot/mqhq1Yt0eIoIOdoLdMoJoAbk7Dn7E3SEDtpyzJX8NtTmiNSLrokv2PRfuZtzRWpACSkzqb5Xrpd4KDJu5sbmhBx3uBOx+Jq1SZkgf7H/h+Hu7EBmwred0A/TuVuCZ2DoPGMB/MVQ3ggWfCXopIVU9m2xr39YYLVqATJIOeMh7agzM4KO8dclclotqBK6AmgavqTmI1XEyxJ6t4ZRa9V3P4I2TmMWBWGGhX2MqSM9gMPt3Ti2nuC9a4CNuM+MUw6lLQ+Buto1Csd52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjBbYrREW9PrsATP8b1WZ3ZEp8OSqeUVYJXR5ChDgsQ=;
 b=Ij3XzaBComYEcj3YKicda5URWvpyoPFLW8A3HC+0CAowLOqoI320DqsIxZoe9vHVd8VqlixiW6Y+NF7UszBuCIMlA9QDVXZ+XmnpQr3RaiU5SI5SzMlnH5PQMUlV1+zqGc3fPUOQM+b/3U4zCB/0C9xwlWM1HTEiU2k/Ec10pHuT/VUFoYwYoQCYfZlQP98Az+CpFv1uwYqBx09HO5wFh/SnyI5oY44ooBd3g8EOGosdPuRvgYpoiJgO8xtV+RBcVEghA0ELvsqDV8bVuK550MkfhJLf3zlI/pQnGdJ99NaXhdJOKewi129ocq4PgS+tYBIzVcOJEw/+ISzuyjx9Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjBbYrREW9PrsATP8b1WZ3ZEp8OSqeUVYJXR5ChDgsQ=;
 b=v2Iio+buqwLgeEGuXbMdhAmyyK4wGRkX7wxP7Rtx8L5W1yDVUjDTUbYwraDLL1afJwi0B5kSgyr2i1rjzJVmzmzpjdYHgnYy9vrNfeSWsgKg4mGxNkC9Bc18nqfsifD4EzrxJfuSqFe3TrmRwi60z7Y5Q8t4Ifl7GvwmNeHhTNCvlpOXTgYpzmoI9j/SmSyub6AMOXvvytt1FC7R7NgCKS4qwr/pDnxONQZSAketF2tLWABRVdrqF52fpagAeSFCBC+wu/hRzjzmoo3H/DCA5KUwO2D4i4Dnoj4ysQgCyZU5/FINZa/fgIhMB65tIcwix3JIVkIXUI36dQHUCsotvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB11716.eurprd08.prod.outlook.com
 (2603:10a6:150:316::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 09:09:37 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 09:09:37 +0000
Message-ID: <ea805767-9e3f-455a-a4d6-828063aaf2f4@virtuozzo.com>
Date: Mon, 14 Sep 2026 12:09:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, sgarzare@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, ptikhomirov@virtuozzo.com,
 den@openvz.org
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260730194858-mutt-send-email-mst@kernel.org>
 <f8646e25-7e81-4f19-aecc-a040caac1103@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <f8646e25-7e81-4f19-aecc-a040caac1103@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB11716:EE_
X-MS-Office365-Filtering-Correlation-Id: 4285dd62-d162-43fe-b717-08df123fe67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5vZmZ+nxFc0/w4pkobR4eQKBsP6JTYx1bICloLA+njwD0iWla1GmWawiDZcvxgUqqLlLPKXZqBwdJiE4G5r2ud+mqhoj6obnEYZTyK9Ly3+8Kx3s1yvanItpdB1Zn8cFmcUYRhnCqJfIHgX8mWjaC9Peza+AAIliDVT55j4UILZxx7+UafjLHi05EpTavKOTlM1Vhci7bf0vLpilV6dlJoAtMotBWqGy2nWX1zLam9K+q0C0YeRZV1u/SVXc45amz+vIOapaSf786QF+KFcMQsWnsT3lc2Mbu7OqWE2CH/vpGpuLYKRDsfRo4WSRZHbGBGTipfUaegv/KFndICzYafemZEbo7dFyGu1+tO7CWRWjNn2hWO7GGMCLXE0c0DA/xX2RoxMHZDnb6e3Q13534hU9MUE95BL9QolkPfQl4esJBQRJrGcM4x706tLMNWMhJ32xSUCSGFHGj3FRX3c3rrmVWQcJ+341fa/DuzUMnjhkiU6N+EmA+TuP+UokpvpNylnxvVnyy3wlRW77ThJXHowvuFDY7tKCcL3xGGYHVkxrrLS23uPM7WyN2q9HFEKMEG6q3+irg/wkz61ikG/9QhbXU0B1DCZDWHLzyEXFpS+v0pXqr7XWE6EAXRxn3VeoOjMWVvscPYwhLaMx/yvdx/u3BZYwS2aS/7OJqGKr2WA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzRyQUlXZUkza2hXRFhZMGdvYVQvSlhXcFJOSTRHQnRUMjMrSC9BTGdXQUd5?=
 =?utf-8?B?N3dvaWphQmpTeHBVOE4xMVU4dU5GUjI1V05SNlZXK3dGRmRwYXI5Smt5U2dT?=
 =?utf-8?B?UzZFYys1M3ZpY2VIRDFqcWJOdzhlb3NuY1I5NjNqRlFRaEJhK3I1bnFZMi9v?=
 =?utf-8?B?U2Z3d3RkWGtKdXE2QkV3RFhMbEhLT3NCN3R3cGpYNlFaSUVCK1FTc0NRRGtt?=
 =?utf-8?B?VjZrelF5b3RhNjg2TnRGQitITjZQKzRUejFJWGV2ZnlQRFZtWTArRk95MXZK?=
 =?utf-8?B?dE55OTBjcE9zaXFMb1hXS0lQOElPSHRJd0pjaTlyS1BpRWFRYldGbEMwTlhL?=
 =?utf-8?B?VzVVTk1wWlRpTnk5QUp5d0RUNXQ2SmMrY0NFZDl3VFBkR2NRZmRIbVNZMGd2?=
 =?utf-8?B?enpzTDdtc3B3QWpPbEhnNmlyRFlNRTJPMk9tcU5Kb082Z0NqaGdKZFNjZE9V?=
 =?utf-8?B?OW1GTVBTVlQrQ3BMQW42SUM5d3Z3RmlPMDVMb3FJZyt4R2Z1VzJwcnVRd2Yz?=
 =?utf-8?B?b3RoWklKVjRsbENmbERIMFNoWkh6eHZYQzQ2NDJ4YXA2eHRra3pXak1LMDZU?=
 =?utf-8?B?NjUvL250Q05sWUJJWEltZEVkMVNvVVRWVTFWcXBZUVpRejIwQ1d6bHZ6V3Vu?=
 =?utf-8?B?KzBqTytLdklGaS9VSmZ4ZkdZL3VSaFlqZXRhZ3BuYVNJeW9PdXZrU1l2QlFl?=
 =?utf-8?B?UDVLOWhSSUZIT2tHOGlrUDVkNWYzZ3BYNVJSOU1NL0UxSm1oMEhhMDVXRWxP?=
 =?utf-8?B?ZTVXMnM4ckkySWozcmI0b1JBbXhleU5oa3libXZaSWh2dm43RGRjUHJUckUz?=
 =?utf-8?B?Yncrd01yZGw0TkR6WGdQRkZaUkswYjFaYmtpK2JremZ5WHFTRTZYYkorVVZT?=
 =?utf-8?B?bHlJeHVKMm9YSm5VQ3NhN1V4S1cvZGQzNE81anJuVW53dTA4Um0vdnVmQ1dN?=
 =?utf-8?B?LzBJT1VPUnNBRGVYZHIycW5XM0RQaXNDRU9wZFZEaGErOTZXY1Fwd3cxUmhP?=
 =?utf-8?B?MWYyUStTc2J5Q0IxWkVwL0o1MDJ3TkE3Q3pIVXBFbjg3dDhyRVZlaDZJSkFr?=
 =?utf-8?B?ak9iZVQ2VEFRQWFRak5tdnc2ZlIwcEZCMWFaaUtsWjVIcnFEV1VrMkNIR1M0?=
 =?utf-8?B?eWwvMXJaalRlY3grck5uU3VwR09YNUF0ck9yYVQzOEdaMzdUTDVkdGFnM0pn?=
 =?utf-8?B?Qkp3ckw4czcrNXBGOWY5RGVWZ1hleXdlV01PSFpycEFHbVlRWk5UM3hkbml4?=
 =?utf-8?B?WmY5bnV3c2J6cm83alR4QlFCa2hBT280STlPTGpmekI5cy9NK29qN21ONm5j?=
 =?utf-8?B?NWgyb3I5MFNRRVNTRklhdTNTQThIQVZaTnpBYnc0R0J0YlR5SWt1MUlUYmpK?=
 =?utf-8?B?dHVEUkpYTGVyQlU0Y1FZZTJoSFNaQlJJMGVCeXdFWGZvR3YxYmpmdEJLVzFt?=
 =?utf-8?B?UXVZVzdzRUhwOHptc0RTNjZnd1Rpc3VoRHlZRU9Dd3dhSEx1WVJFKytHT2Vt?=
 =?utf-8?B?OVlqeWNiVmhtY2s4TTRLdGNHbFd0M2Zmb2V2d0gyRHh6NlRGT2RvM05ySHNT?=
 =?utf-8?B?b3I4UGhTZ3JjZ0NCbElqRFN0NzhlMmhiSzZXWG4vY3hVaGpFa1VRRGVFalFU?=
 =?utf-8?B?eEZYWXQrWk5lV3JOODdDdHAyV1BYeEpTaFJLQ0xQU0s3Q0trenQ3QkdBR1NM?=
 =?utf-8?B?Rlp0WGlwUUVVWFZUbWhjd3JDeTJ5ZURiZnZIUnQ0bkFvZ3dJN0xCak9TWEtO?=
 =?utf-8?B?bmpPamZiNDczeVk0eU42WEcvRW5DTUFya3VNbnhmbVpCalh1YkxWa2ZHUjBE?=
 =?utf-8?B?SHVEWjMrQ2N0TVFjOHRwTldybmFSYy9VS1ptQ3dxZWdoUUp5aUEvN0JNaTha?=
 =?utf-8?B?WmRRTVJtMmFuOXVpNGYyM0VRMGNwb3N5a0VoY3FqNFhxTktuSEY0akN3YTd3?=
 =?utf-8?B?OS9sbE5hV0FXTFpyeUluZ2ZUNGViL0dCNUhGdVI5Q0tlUzlTeHIxbTN5SW0v?=
 =?utf-8?B?a3NYN0E5WUNwWmVHLzhwd05WbHc4Y3VFRUJsS3ZPaklvVTZUSmlXQlpZNWZZ?=
 =?utf-8?B?NVExeVp0QUtScktsaXJScndBY0IwNnFaajVmZW5tZTlaeTZkT3FaQUZFV1ZO?=
 =?utf-8?B?QVN1UUFpWmpEU1lQd2RrS3B1TEJNVGVhZVFSOHFDTTY3TnUvTHlQYkhxdGJE?=
 =?utf-8?B?dHNxZnpkdXNmeDRvS2pLUkNsSEtwOVN0bkxFMDZTQU84Vjl6KzUreEY3TEZv?=
 =?utf-8?B?UHl5NmZFRDFsQksvQzJvd1FtVkJLMUpNclRzM0VkYmwzV2htT3Ywc3J4Q0Fi?=
 =?utf-8?B?bjZVVUVYeUlOQVI0THpMblJGeG9mK2RWczVWUGlsK2VIb0p1OWo0dnovWHNv?=
 =?utf-8?Q?x4ob2+LHlFsb2ric=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4285dd62-d162-43fe-b717-08df123fe67b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:09:37.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJrLB2tBFxO6yCI2T8ZMKCVMgHQrcl4a+sEro2wZrKeC2V6SuyP8Vam5k5aCDYuohvYa/cocVqCVOMUYj4NMUQpyIKorrfMCPm0Mvfp2Glc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11716

On 7/31/26 11:31 AM, Andrey Drobyshev wrote:
> On 7/31/26 2:49 AM, Michael S. Tsirkin wrote:
>> On Fri, Jul 24, 2026 at 02:45:37PM +0300, Andrey Drobyshev wrote:
>>> v5 -> v6:
>>>
>>>   * Patch 4:
>>>     - make sync+flush conditional by adding a bool 'sync' param to the
>>>       chain, as suggested by Michael:
>>>         vhost_dev_reset_owner()
>>>           vhost_dev_cleanup()
>>>             vhost_workers_free()
>>>
>>>     - reword commit message and comment;
>>>     - drop Fixes;
>>>
>>>   * Patch 5:
>>>     - add 'sync' param to vhost_dev_reset_owner() call.
>>>
>>> v5: https://lore.kernel.org/virtualization/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com
>>
>> does not apply for me is this for net next?
>> in that case
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>
> 
> The series is based on tag v7.2-rc1.  However I think the reason it
> doesn't apply is you already have v5 of this series queued in
> mst/linux-next, commits ddb0918e36c4^..ad5b642c84d0, with your S-o-b.
> 
> So you might roll it back and take v6 instead (only commits 4 and 5
> differ), or leave v5 in the tree, or I can send you v5->v6 difference
> separately.  Whichever you prefer.

Friendly ping.

I noticed that these patches were queued in your linux-next tree, but
got dropped afterwards and never made it to your last PR (used to be
ddb0918e36c4^..ad5b642c84d0).  To be clear: the series targets your
vhost tree, not net-next tree.  Since it applies cleanly on your current
vhost branch - please let me know if it's ready or there's smth else
that should be fixed.

Thanks,
Andrey
