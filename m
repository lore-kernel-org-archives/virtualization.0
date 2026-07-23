Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020080.outbound.protection.outlook.com [52.101.84.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EE33C18B
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817121; cv=fail; b=TVOsmWzB1eQ1inadKCynbssvqVJ188atCsgr25LozELPsRDCIbA7HMRPpzLAXcPQjQ0rF7jdSYrqdeVeAredLDUdSagua/d9xE9SDU8MuRu5Qp3fEsHDWtjYuX/RHHHic5mwytY3JGUQyCZfxtoIJPh3yZPLMGMxSK2lwEG07jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817121; c=relaxed/simple;
	bh=lZaZAT51fUulEip9c6avPeTXoTTHTOnfrRQezmyTSP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1kSdgdiIwMbi6Vj7A4STGCO1ewrVqqQ8CsS0xMjEvsuzHTzERNG8S3X+Byj9xJzGoanDkW3Woc3OfIQsANhbmKAdgHpfh9OHDabXB0q2QCKYnxfkZnLqbj8Kc6muNMjGhktZRXR1qul22EnFsMSHADbSf/X7sXJQLSp13CD8Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=ggq1bOrR; arc=fail smtp.client-ip=52.101.84.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ggq1bOrR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRdNrpuJASM5QXulXumi/VWgpYMQE3uZE66qQCtUwp3zaWGSSOq7auuCQ1TJMpjvp8WM/oQwvygLUfEcpbfvJunnIdX3VEvUa5wFsu20q9sHlhknR9LVK+D0HmVgW0KGsJgYNXWiobZ7nRgYuUkKMIJmlfcw7n9GQRVjvVwvvDEWPduf89nJajlheE2gtix3B+ZzLaumpZ4HmHpoYBwlYJ5PdL8JUQIbOnJn+0bA//N/O4n7/wjzEeWsBqBdovj6Acom5pAo8BcCz190xSlmhsgC8c8OXzQR35putpSaM1NU//buTssSf+6evULlQjfWbPB1QpAkRwVzwC2CdDf4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58lIAJPR4sFsluweVkKOZohILeV7j1NU+JKmoKkNw4c=;
 b=c+EzzA9IR2hPSImixePn6IlbD4cq6GCoYu/gehBaDJxc5PjknBBbfAs8eXLck3xe7yNFAWV1dqsrha/AMrg8Edzs8k9RVY3OnnWB3o0yemkb8B7tJF1xJAPoLr4fEc2cmVKFTsqlfY9K4vhd2BNXKUkMH0d6a/N7ypAIdUz+jnxm25K7GeS3zyri9UdWbF/BnVQbCNfiyipeLp8DIaTKzfRui9r+lRM7oU7Pxquvxic4P/1vhOV1iVI5iDfoyf5H88DszxzXYY0aSc/WwYX2ZppofMcQYnR3fQRgU9O9T5V5Uy4LBsk4rRuDrG/u40aeuVOhJfafKy2pFdiNTkd4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58lIAJPR4sFsluweVkKOZohILeV7j1NU+JKmoKkNw4c=;
 b=ggq1bOrRX639yGTqVxtemyxjLKr8dQBaOTZ/8/bhg21bNyBD7mnl4GuDBgskGqw0g6gTp3y+o1PlER8FeiJ5b/Bjmf6SgpwPEwGqoUk+YhGDPrqtuf1Vy4XW07lFCNcWIgdI3ch7b2+et2xQQuDwHVS86/tbpJfTbT0i+pKv3pjAfJCOuPpj+7BncFh5i+BtdFeTlXPiWW/8fsjD8VzaFq0NRmkprYihkc6RvY+29ay0DiyobqbF9W/fZ0qZllHN/XYB12mvs8QudHhhl0yF4ND6x7N07rera4OptWh7e3t6ThLWBQVTej6ltkeaSlxm2JO8qEoD6V8jWea6MocLAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU0PR08MB8809.eurprd08.prod.outlook.com (2603:10a6:10:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 14:31:55 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 14:31:55 +0000
Message-ID: <68c497d0-0c6d-4a4b-b99e-1d38601a0809@virtuozzo.com>
Date: Thu, 23 Jul 2026 16:31:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <f21667c3-64f1-40c6-9941-9453af173eda@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0011.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::10) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU0PR08MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e73d65-ee14-45d7-0265-08dee8c7252e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10070799003|6133799003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rq2xJOOVv9Ac8i7v46d6Fz7KjUO/gmPfVmYEgQNsG08aWlhjvA+sbFX2EeCDxIjjaQAN7FpkE+9Th7hDu2BkA7baBTIgP6U754VxPzzGbY9vmMEZaGcYD/v39m4WfIagzO03LBPl+uvUJe/nW8bc2QRIL/cnf+PjUXcH2szc1ixNUD6yGJFiqdOxUo6t9pwUpB8i8N5+6HGtYBamf7AZbGQ5AA02mXpNG6lFv4j6AAGZfWiWL9/rdDW7aiiL6OQA2Mso+l04FvFvjADGvzO32Ghauu8d7E5/oEtXN79CD2bLKbmikiPCUrj4hFt6/I6PhAq4GhW+LcBiFX8ah57kE7iSFnf/Y8t9JGf1jMlAYdyC+x1rLwUfUILB+oLqbGNEr74jGKsy4PYcUUVzTUxGa1V7w9YV6tztdYrCxhIavyzat56mVKzenQPKIG7uxa4+6TNJi1yiLLe5v8yQ1xmS5oWfNn/qi8J13KUG131gXHcM4myTOPbPFguDmepuFUqqqFvGQwy/+GONUESaVeTi9zA5VMowh7F8v1QyU68ubYAN9eqyrOhv1B3d26f3eRRpM6/YcNtzIUREwdtEYEn+SXhxtQ3TZFXItXZo0E/4cVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5892.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10070799003)(6133799003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnJ6cjFTM3kweUZuMHVnYWsvTzBwWFFRTGkyVkF6MXAvV2Q0Q1dWRWZ1Y3Qx?=
 =?utf-8?B?YVJBRkhFTnpHeHl3VHYvV1ltZFdSaEt5d0Eydk9TWmRvUi81Z0djeTB5QmVX?=
 =?utf-8?B?UzA1QjBlL2JpcWU3VDViWGJQbVlFbzNmb25DR25ZS0lvUVRkSTFZbDRmQkw4?=
 =?utf-8?B?QThObW9CczNjdHhCYmwrSyttamZuVFh6YkZXTmFKNDRWbU5rQTUzcjFVWUQz?=
 =?utf-8?B?TmkvOENwZ1ZnYUg4dEpWem5rOU5BR3lzVHE2WnIybVVUUkt5eFlFdzQya3V3?=
 =?utf-8?B?aHkzUkY5T0JsWVpjNVFETGoxUGUrMTRpZjc2M2MvMGhTT0c1Z0JmUi9hdmVV?=
 =?utf-8?B?S2N6S3dvU0pCUXhFYm1MdHIxWDNkc2tQMHJyVmJnampBVkhadUwwcjBhNGVC?=
 =?utf-8?B?VEpWclhuLzZMbmo3TkFzeUtwTHpuZVA0bGhKV0dIdFd0Y1ZUSUV1YXdHU0o4?=
 =?utf-8?B?MlNOWllQOWxGVlNhZE13V3BnanFpN3JUVW9YMjlxdzE0OC9oQXdSNDVqMkhR?=
 =?utf-8?B?L0d2L0duQVoyWGwydkdCVXpMVW5iWWZ3ay9XbVdGd3hsRzNQdXUvemkrZHB6?=
 =?utf-8?B?dnBqOFg5Zi9ZdGRBdXpjK2xZck5nWm9xbERhbGhxdjJqci8yeTBQNXkvcFRF?=
 =?utf-8?B?ZE5MTUxxOHpPOHRNUmZiQjQ5WVV2T3VyNStxL25UdnF1M1dxMnM0V2sraC91?=
 =?utf-8?B?aHduV2liVEFIc09BWTEzalUvSjBSQnpMdzJXM2grbTRFcFc4RUoweGJENFFT?=
 =?utf-8?B?ZWJEc3lSZ3U4aHpMY2I3aUJZS05nYmJMYTVHUjJ2WmtkaVlMVFB0c0k5V2dq?=
 =?utf-8?B?MzNTZWNRS2kwdVZRWDhWZXNPYUJwZ0RNcGZkY3I3Rmc1RU14cHpPcy9ZRFJZ?=
 =?utf-8?B?M0lvbmpyWGJyM09xMmY5SzlNaGlUbEN6d0dCbEwxYk9TakxZRjdvU0Vla2ll?=
 =?utf-8?B?TVZQeVIvSjZEMFpyS3hjbit2MmNnKy92aG5zSU00b2dsNzBNRSthM1MvNkIz?=
 =?utf-8?B?RXI1K1NSOHlCTEcxdTFQV0lMaTJ4Wi9CcHRaZnZVdEM4blhOYThkeFBsOXBO?=
 =?utf-8?B?UXNJU2MwU3FRVWdpU1pvSHZ1RE80Q2hGV2tJOHQwc0d5akl2Y0tTRE9EbjJv?=
 =?utf-8?B?U0w1UkdhU3FqSVZ1T0ZGcFNrdnFVMnhDNjE2UHBXSGdDTUhlRWUwMGNEeWUx?=
 =?utf-8?B?R2JSVFB2N3lpeXV6aWwrZGwzWFVpUXBwYkNNYVRIeVQxMVZ1ajhYbGpJdWN1?=
 =?utf-8?B?SkZyeWtIc3hzZy9lZ05HUDFLZlZMNnVqd1BRTFpqZXFxb1VkSmdDNFE5S1Bu?=
 =?utf-8?B?bVpaU3oxVlhsY0pMZGNIL2lVZUFKRW5FM1JtZ0dVb0xTM1B1MEJPcWk1N0Fx?=
 =?utf-8?B?QlZKeDFnaUdFVGtHOWFremVVeFdFOUtLVTNSNXFoUHFCVk91dXBEUWVDMXR5?=
 =?utf-8?B?ck9wQ3lrUUg0RE9xTlEySWRJVC8zZ1RidWtCdzY3eWlrQlNLRFE2Z3c3dFFJ?=
 =?utf-8?B?Mzh3bk94QTRQYzIvWFo1bk5TSG1xY3N0WEcyd1hLV3ROVHRPSGdQOUlTZm0z?=
 =?utf-8?B?R3drb0ExWmdUM2ozOUs4Q2xRWUtJVDhCZ1N3Wms3ZHAxZmRDMm9hYWlMeDBM?=
 =?utf-8?B?S3VpSWFkN1ZXNU1wZGxVUEUraEh0OXBSaWJkTFdkejhSZ200ak5PMVpCa0Iw?=
 =?utf-8?B?UFBmV2xoUEFzWHIwQTVYdk5mYko5S2w3Q1BIeXU4ZmcyQlRYbXVaUklocXZi?=
 =?utf-8?B?ZmxuZlpnNGRySHJ0K01ac1NaSjNrNHhwZVpXcXd4NjFaZnRYRGpqSm1NRVdF?=
 =?utf-8?B?cW5DbjBvTEFndCtNMEgvOE11cXA0cVJWZHRSTnVCWjdHNHg5MUZnZ0lDWHBr?=
 =?utf-8?B?UTNIN2UralYwZ0dpZFY3V1dEOUFHdWFVeVplVFdtWTRBMnhldnlEQUxWNWZK?=
 =?utf-8?B?T0dPMGpOTjBDOXVkaWE4Ym9nYyt4K3hKRUowc2hhSzZUUnRiYURYRkV6eFpw?=
 =?utf-8?B?Z2pQYmFXNDcwbGF3VTVRMERkcCtJdU5RS0xQd2c4eGNaMkFwaUtRblNNUUhs?=
 =?utf-8?B?MVIrMEpCc3BEUi9BaU91OVZWdDhNNWFRY1hkR0lTMlNlbjFNam5KVHlJL1ZY?=
 =?utf-8?B?b1pFc0J1eU96QW9xZWcxeHkxLzVic0tXc3I3MjFFN1FqLzNsSmQ1RnNTSHBk?=
 =?utf-8?B?cE1tUS9WMzZxOFZ2V2gzS2w2eDNVQ1orSHBnbWUrMXZNaGJ5dWZoeW9KaTRX?=
 =?utf-8?B?VktKZzYwcXZERW1mT0MvQWlVSmgwc1RKbEh1N3R3VjNpNWdTYXpvaVVNMzh1?=
 =?utf-8?B?V1lCQTNTR01OMWlaWUxkeGtMZ1Z6QXFFY0RKb0hEclBjc2hQemNpRnFDWkxO?=
 =?utf-8?Q?GMsngmHyJV1yYH32sjeEc7g6taKIHCKjXG+RXO8FEFBEN?=
X-MS-Exchange-AntiSpam-MessageData-1: 6xJ1naCUtDIx3w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e73d65-ee14-45d7-0265-08dee8c7252e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 14:31:55.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYBhJorB8VZKzfmjjAHkTtsR+f516UKlCgZLvh1bWwflI4kt5jtSP10dPKokLPvtBcdtx1aOjdcN9AIL6n/qjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8809

On 7/23/26 16:29, Andrey Drobyshev wrote:
> On 7/23/26 5:03 PM, Stefano Garzarella wrote:
>> On Thu, Jul 23, 2026 at 04:57:47PM +0300, Andrey Drobyshev wrote:
>>> On 7/22/26 12:43 PM, Stefano Garzarella wrote:
>>>> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>>>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>>>> the vq->worker pointers and immediately frees the workers, without
>>>>> waiting for a grace period.  A caller that fetched the worker right
>>>>> before the pointer was cleared can therefore still be queueing work on
>>>>> it while it is freed.  And even when the queueing itself wins the race,
>>>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>>>> future attempts to queue it are silently skipped.
>>>>>
>>>>> None of the current callers can actually hit this: net and scsi stop
>>>>> their virtqueues before the workers are freed, and vsock unhashes the
>>>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>>>> the lockless send/cancel paths become able to race with the teardown.
>>>>>
>>>>> Fix this by clearing the vq->worker pointers, waiting for a grace
>>>>> period, and then flushing the workers so any work the last readers
>>>>> queued runs before the workers are freed.
>>>>>
>>>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>> ---
>>>>> drivers/vhost/vhost.c | 11 +++++++++++
>>>>> 1 file changed, 11 insertions(+)
>>>> Sashiko reported some potential issues here:
>>>> https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4
>>>>
>>>> IMO the first one is pre-existing, but not really sure it is a real
>>>> issue since happening when the worker/vmm is going to be killed.
>>>>
>>> Sashiko claims:
>>>
>>>> Will this leave the queued work unexecuted and permanently break the
>>> virtqueue by leaving VHOST_WORK_QUEUED set?
>>>
>>> I agree this issue is pre-existing and doesn't have much to do with our
>>> series here.  It looks real, but in reality should be harmless since we
>>> may only hit it while the device already dying.  Means there's no VQ
>>> state to be saved.  The only potentially observable artifact I guess is
>>> a warning here:
>>>
>>> vhost_workers_free()
>>>  vhost_worker_destroy()
>>>    WARN_ON(!llist_empty())
>>>
>>> So more of a cosmetic noise on a dying device.  Again, not relevant to
>>> this series.  But one optional way to make it go away would be to clear
>>> vq->worker under vq->mutex in vhost_workers_free() (mirroring
>>> vhost_worker_killed()).
>>>> The second one also not sure if it's an issue since the sender is not
>>>> lockless IIUC.
>>>>
>>> The term 'sender' is confusing here:
>>>
>>> * vhost_transport_send_pkt() is the .send_pkt() method of struct
>>> virtio_transport.  It only stores skbs into the queue, doesn't process
>>> them. It indeed is lockless as it doesn't take vq->mutex.
>>>
>>> * vhost_transport_send_pkt_work() is the .fn() method of send_pkt_work.
>>> It's called by the worker thread to process skbs in the queue, calls
>>> vhost_transport_do_send_pkt() which does in turn take vq->mutex.
>>>
>>> I think sashiko points out to the former.  Still, I don't think it's an
>>> actual bug.  Look:
>>>
>>> 1) By invoking flush, we wake the worker thread:
>>> vhost_dev_flush()
>>>  __vhost_worker_flush()
>>>    vhost_worker_queue(flush.work)
>>>      worker->ops->wakeup()
>>>
>>> 2) Then woken worker does:
>>> vhost_run_work_list()
>>>  llist_for_each_entry_safe(work) {
>>>    clear_bit(VHOST_WORK_QUEUED, &work->flags)
>>>    work->fn(work) // for send_pkt_work = vhost_transport_send_pkt_work
>>>  }
>>>
>>> 3) And then in work->fn() (vhost_transport_send_pkt_work):
>>> vhost_transport_send_pkt_work()
>>>  vhost_transport_do_send_pkt()
>>>    if (!vhost_vq_get_backend(vq))
>>>      goto out;
>>>
>>> As you can see, we return early in case backend was unset.
>>>
>>> So after doing this flush, we have: 1) QUEUED bit is unset; that makes
>>> send_pkt_work re-queueable. 2) But the queue doesn't actually get
>>> processed, and VQ state isn't actually touched here - so I guess
>>> Sashiko's conclusion is incorrect and there's no actual bug.
>>>
>>>> But, please can you double check them?
>>>>
>>> In general I'd leave this patch as-is as Sashiko's complaints aren't
>>> very convincing so far.  If you want I can add another patch which wraps
>>> NULLifying workers in vhost_workers_free() in vq->mutex.
>>>
>>> WDYT?
>> Yeah, I agree, about the other patch, up to you, but I'll eventually 
>> send it separately.
>>
>> Thanks,
>> Stefano
>>
> Alright, then let me resend it once more along with this 6th patch, so
> that we don't have it uncovered.
>
> Andrey
I am sending 6/5 patch as followup in such a case :-) and respin
only if rejected.

Den
