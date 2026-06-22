Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023099.outbound.protection.outlook.com [40.107.162.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C553769F7
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138814; cv=fail; b=YYtwoAN6UAqHCI7O4ujXFdhjbvFH85bVh9gTh7olyHQmkepH+sA2k+uzgoBDOCkuvib+MPgX9F2NyjLC1hennvstqbGrF9q84rgFxlvC88tSDbW1fLmUvG77JkzgsjpVp9kh1uxwTlEcw0WCA/vMsk18hJgZy1WIP2HWHIaD8qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138814; c=relaxed/simple;
	bh=CUY2kOGk3FEraSR0OUbv1MToiME05DEk2Bdqk1OZYSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FDzCw68g0E+2XO87w34fLcZEKsg35znX9p1udJE8uJCaTOOzC6uificp+WO5zClxfeAGXhAAGOtpch4bvCYoZBu5FLCyuHp0Sl6RYkjE0RjLwjVlCf/QJ3gGzREFxfD87xdRl7zCP6myidv4evY2SVwI/LBKKoxapDwNRBmwdfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=KWXEO+oy; arc=fail smtp.client-ip=40.107.162.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KWXEO+oy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLcXwJC8pDiwzTNg+HD9UB1BulQCPQjdVQFHWSEc3aOxgTjbOB8pgYddghAWBAUstq6MdYbJkhDlmXk89Qf4cLQzi0qaKQeKDvTOXjmQ+KjfzCm5OT0kqEcKxDL3vfvWDRquNhe+7xgHVnag4V5CHmeldXTgXLjaFp+cUhcfB3bX6nxqU+SKy2W+ZGr7ndy/9oTGhV5otmEou4Q61mgf5AXWeuQLQZZZvoxo8QqIhmi94tCvzVCutQ3kHLdsvx7Z5yymCE8iK7eqSXWLMIAqzfqtQyOcsmkbz5sDA/4r8peE10M4tS4A/Zfojrv6IQ9iiNfWq2H8QUW+9OFw4Q5Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUY2kOGk3FEraSR0OUbv1MToiME05DEk2Bdqk1OZYSE=;
 b=WM4zs+FLrhE/qHifv7UbmYIJAeqAMCnSctRjF1ifQmmLRFRoh54fNj4kiq/yVDaCnCfoPnKVy1yuLtSpTUVXyRXiRcDXV4P+QN8uUFzDgWZwAMnJP/h5Fff+J5p5cIhoYaWAPigNNHkqbWrT2dWAJxgxTb//t8NygmJKqGwNu3eC4rV4egZwNWApS0XySH/pFdmC+W+KI+o5Wub1Dly8b95suDWHoGe4F+ocsigN3b655P/fMgWIkEf+vmDUH/OSOOKEl66LmbwAwUXuLGfSjG/JDJ+yMW07SGTno/Hwd5v5ARRdsA4gxN9PgIaMTUVAc3KnyxTzHG40m9PBtfkmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUY2kOGk3FEraSR0OUbv1MToiME05DEk2Bdqk1OZYSE=;
 b=KWXEO+oyxgap8GLtISP+Br07uT6bK2acfkxvfZWkLo4zJry5PUx3/3UzxYuAlKQQ3M7kMRPZ13VaAzF6QIw4GHshBJQqcA7M6enM9uByQ7iAfY2I0NCmd3plVViMKmd/AYReE1ijqDbjsN8NbQMbmfSBzsXz1eESeZOenDA1XRyw1s3hGSRvG73di7iwV4VNDG7dvw4J1ka5ezjO/dqmOwXJrW0Vznt/42scAJOkF6Oebjzll13mIyW7AE4fkBiKR4wzg9WcX78S6dCPGLURya9qrEYprKi83NWZHtX6RjjMLhlFBWzpQWZzWQmskydpOZBI5jx/d/aFA4gj8Repxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAXPR08MB7351.eurprd08.prod.outlook.com (2603:10a6:102:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 14:33:22 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 14:33:22 +0000
Message-ID: <c462cde1-7d6e-43b8-9c61-f4b82f81389d@virtuozzo.com>
Date: Mon, 22 Jun 2026 16:33:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio_balloon: quiesce balloon work on device
 shutdown
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Denis V. Lunev" <den@openvz.org>, mst@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260622133715.3707707-1-den@openvz.org>
 <de197e27-e56e-48e1-ac2d-e76ba0c3e6b2@kernel.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <de197e27-e56e-48e1-ac2d-e76ba0c3e6b2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0274.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::41) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAXPR08MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d523d7a-12f2-4380-dbb2-08ded06b3625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|376014|18002099003|22082099003|6133799003|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	4aG3uYxXAUhno9ysaBhLe2GXMwruywWUpoj1B2moQ654hGiBFikKmZvJ6vZkDnrta0fb1Eri/oylvByaWncUA+Td0H63wj4DbcLB8IB4U83y+KGnqSwXdZQ6o7q04GWuuGVPbi2rCsRqzSEQzYX2zRxEcaXo16voHNC8RfmPIwomaopdXFAwuwHnSLzSeGbfgT9w/KCQmuWirMYQdoiL6PEHhGaQj1Hb+9RwMo60B/6ep2XzN1uN04KeUzH9IdeUOIFOROgF39EgUD+nK7y8gWQdw2PhqtGAY1sUpcawO6AA1RJyfk7fCVEC1bHmWlxMqTkZpcC78+kuOx8ipreQ70ClhX3FE+OtBQUOCK0I1hhI1TKe6+sGeMmvczE+s3KYElak3vihn61puJM8683JE+scJuS1pAuQUEEnueYuYCbcYJ3jOPhAMZ75OXOwFcficy1TUeO5vHmaSsvsKeNhuaonxLDkrS2mBR1G3M6jtCRPtw3WUucYeMMYqStmfioggEgYvSpKdLnNUNMZdr4K+jNtZg8fIajYXyMKuTdgYJ2ydYAbmkpAUZCxkq/c6HW//OqDuOCnMJafxUSMxpCqwdRw3Sdntg560144gkYyWXm2OkYeDuF0uthWE5T03mdyD310oNUeURcnuE7FRVLMjah1Ek43QXQHDymxOps5Dg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5892.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(18002099003)(22082099003)(6133799003)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGwwWFhCSjU2ZUI4NlRaN2tGS1BZMlRqUTFQcURMbGI5S2h4dXlDK2s2RDla?=
 =?utf-8?B?VlB4V1pubysyWlQ5Vkx0cGR0S2RIUEFMT1hqOUFSTXJsWVkxdHRjOWdDNHoy?=
 =?utf-8?B?bnUzcXhMSi9GMERzZ09DSmVzTEEwMzlkUWV1Y3BKNVV5NUhKb3J5T0JCUVR3?=
 =?utf-8?B?K09wK240YSs4MTZuaEVnVkhoay81NFJhWHZCWmNobzJGRWdRcVF6N3pFTEtF?=
 =?utf-8?B?MDBFR3JSSUdodUhwY01nbUswWVczSDRIMUMzNHVmYUpETFM4bDJ6OVIxYWoz?=
 =?utf-8?B?TWc4RDNCcy9CdXFaei92TVhkWmlDUExxQWU4SGcxSUN4cVBxTE9UMGM3SzVp?=
 =?utf-8?B?eUtVQUNDOXJDS2s5V3dycmhSb2lEcjVjNGtWd1NNZDRaTjdrR0JTVEpIMmwz?=
 =?utf-8?B?bGpTWDBZbDg1N3lNU1NSaGpSYVZyd1lLWGdDTGlCaXQ2U2prUHZ6OVNUdkhJ?=
 =?utf-8?B?dEdBNWRVcGtVZTdFSUpOcEx1a3U1WW4wZ0p5NXNXMW9yRVYyMGs2MmR5cXRj?=
 =?utf-8?B?VHhYL0hTYUhHbktlT0xBNitDVVFtbDlPOXNsQ1FsZ3ZKS2c5NFNuUkdtTWdG?=
 =?utf-8?B?MGZLNnNZNDNxaGtRaU9adndaSjRFMis1TkQ4T2RTbzJLaDdvZVVIdGEzS1R5?=
 =?utf-8?B?b2srMnV2OGlpQ1M4NkRxWmZ2ZGlDajJMSzI5OVVwV0pzdnNiSHVRRDBYWDZT?=
 =?utf-8?B?RnZYQnZHV3RlRjJYV1gvdU1XM3dvaE1RdkFnUkpxTnFHRXMyOTh2QmJrakdr?=
 =?utf-8?B?THpndExucUxjeGhOVkg3TEhaQ3VvaHBkWFFBNWs4T1NKWmtvMWdRNFc2dU1q?=
 =?utf-8?B?OUVkMDhuYzBYeW1DVStYQXVRS1JybmdleWpZZFN2alRNSXlxckJ2Vm9OVmhT?=
 =?utf-8?B?QjJ2TzhFVFRKSW45KzRFN2QwWjFVQnllc0dTRytWbENsRWgwYmljcU1kNlFH?=
 =?utf-8?B?b2o0bVJUcVpWNVRrZE5sLzRYcHhuR1pBZ24rQ2FGb1BIT2lGK3lXZ1Q4NUVt?=
 =?utf-8?B?cWVIT2tVekRNN2l4NFEwMEZxRDJJTDc1cDk3SXQrTnQrZWZWcHhMNEI3dkYw?=
 =?utf-8?B?UTNyNEhXVlJJRm1WaGJ0V25lK0Z4VlJ5UlE4R1B3L0FGNmhLOWlpNG55ZUph?=
 =?utf-8?B?NXFmL2RBZFRvZnhrTWk2cXUvOVZ6dTQ3bnBGOXM1clpjRTYxZ09kUnF3SUE2?=
 =?utf-8?B?SmZHRVQ0eHNaeUN1eE5zMDhHRkpOZldKRW5iQ0ZTU3d4T2wra2NtK0VXdE14?=
 =?utf-8?B?ZlRLUEoyZ0ViUFkxd1htQ25lSlVISjY3VlhKV2hrT1NsUVRpcjJUV3JuVmdj?=
 =?utf-8?B?V1NRY080aktKbkUvaERSMnkvaytsa2tpNUpKZ3BGMkFnVlRnV2hYQk1MVXRU?=
 =?utf-8?B?dXdVSkI1eW8xeUNqUzRsS09CUjIvQ1A3cS80MmcySmlyd2xxdlFKTDlDczEz?=
 =?utf-8?B?dDFaRzU4UlpKZjI1c0FMenpHOUo4Q0hwcGVkdExhN01MTDU5dmZpYzkzZEJs?=
 =?utf-8?B?N1c5Z2o1MWtPaXNXdlliMUNUMUxUWjQwQ3UyV0ZYb1VxT2RydzVPNnRyLzFT?=
 =?utf-8?B?UGxTcm9Ud1Vod2gxYVJCdEltNXNUdkRuKzJvNDJCVEpEOWVMYXhoWGJ4aXph?=
 =?utf-8?B?dHlOSnY4SmxUWEZHR2RrNkI3RmszbzZzTlJUNGluYWdMWkNoZnY0cGxWVWpp?=
 =?utf-8?B?WEhFUTBYSUpvVi9rME4xMHMzL0RWVVdEdkJoVUZxNjVnakdLTWhnOGJ5MWlr?=
 =?utf-8?B?aHNkK1BzRXR0Q253cmJMOENMdnBvQ1lNM3hNM2NVYnBhQmJGdnlwL1d6THNK?=
 =?utf-8?B?L3dqM2ppcnV0S0x0cm5ld0dNY3hEdTJlM1Y5VzZPeDFuMndhQm1RWkduaW5P?=
 =?utf-8?B?aUdhenk5cnd3UWI3OFQ2dkZrWnREb2Q2eWp0bHl0TzdINVpJbEYrYXdyWXhl?=
 =?utf-8?B?ditFVEkxcHI2ZjVGWUI2eThIZnhWbVJqOHRlT0VrNnRzZWxJNEs0UngxUDdh?=
 =?utf-8?B?WHJVNDhFUEx2eXNuK2JzVFozWThhcU5VYVorUzFJcjZLeFF2Q1VGRSsxbEw5?=
 =?utf-8?B?MW15OTFKSzYreVZKOWVXMVgrS0dwdzFSWGhCclM5bjZtNTVqNGtnS0FJRnBO?=
 =?utf-8?B?dS9hZEpFOGs1Tkw1L2dHMXphMW01SU9iOHhiMktWYmlaeDNOOEY0d2NCY0Fh?=
 =?utf-8?B?dkovaVFualhLSXVPNlFEa2pIbDkwNUV1YVNKa3h5cjJCVHA0UnJ0UElqZGxB?=
 =?utf-8?B?TEJQbGxPVjkwNEI3aVp3VURtWTBteFZlUEpBRncwaUQ5cXlvb0o2YXdsT05I?=
 =?utf-8?B?Mk1pcmkyd1ZJMXNOK0pDR0dCNXBtVEJnTXFBc0dHQUVGWWh3T25hYmMxS1Bz?=
 =?utf-8?Q?qD+tZWVeiPrAJkrqPoAXzwSQa41kpYdeyI7CtDCnlozRq?=
X-MS-Exchange-AntiSpam-MessageData-1: TuDrPlJprCQMeA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d523d7a-12f2-4380-dbb2-08ded06b3625
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 14:33:22.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk0KnRXMjI4lojozN0KcLZZUrOvQPYnOYbkKcf6AMCyT767MnB/dk4UsB21ZvZi2rTAWr/hf1l3rWi1WC5pYBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7351

On 6/22/26 16:29, David Hildenbrand (Arm) wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> On 6/22/26 15:37, Denis V. Lunev wrote:
>> Since commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
>> device_shutdown()") the virtio bus breaks and resets every virtio device
>> during device_shutdown(), i.e. on reboot and kexec. virtio_balloon has no
>> .shutdown of its own, so that generic path runs while the balloon's
>> asynchronous work is still armed: the free page reporting worker, the
>> inflate/deflate and stats workers, the OOM notifier and the free page
>> shrinker.
>>
>> Once the device has been broken, virtqueue_add_inbuf() in
>> virtballoon_free_page_report() returns -EIO and trips its WARN_ON_ONCE().
>> On a kernel booted with panic_on_warn that turns an ordinary reboot into a
>> fatal panic in the middle of device_shutdown(), so the machine never
>> reaches the new kernel. The inflate/deflate and OOM paths do not warn but
>> are no better off: they call wait_event(vb->acked, ...) and would block
>> forever on a queue that can no longer complete.
>>
>> This was hit in the field as an intermittent failure of a virtualization
>> cluster upgrade: guest storage nodes were rebooted via kexec into the new
>> kernel, and the ones whose free page reporting happened to run during
>> device_shutdown() panicked (the guests run with panic_on_warn) and never
>> came back, stalling the rolling upgrade. The crash dump showed the WARN at
>> virtio_balloon.c:216 in a page_reporting kworker, with all the balloon
>> virtqueues already broken.
>>
>> Patch 1 factors the teardown out of virtballoon_remove() into a
>> virtballoon_quiesce() helper (no functional change). Patch 2 adds a
>> virtio_balloon .shutdown handler that quiesces via that helper while the
>> device is still alive, then breaks and resets it the way the generic
>> virtio_dev_shutdown() would.
>>
>> Relaxing the single WARN_ON_ONCE() instead was considered and rejected: it
>> would silence the panic but leave the inflate/deflate and OOM paths
>> hanging on the broken device. The device has to be quiesced, not just kept
>> quiet.
> Do you have a link to that discussion you could add?
>
>
that was internal discussion for that fix. We have faced this
during tests, made the fix and validated it before sending.

Thus - sorry, this is my mistake.

Den
