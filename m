Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023091.outbound.protection.outlook.com [52.101.72.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAD35E1C3
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974766; cv=fail; b=cHWfoT9Qpjo+eb7kvyRElFpog5XeTem/zOql0DHPJn+dYmQ8olO1yN+d3VIsBXAFZOE4phl57Slt4b7+cnfnIy5WIxXgz4q2mSNmr7e9sF0OB8DuUPx65reNtvkcMYKCFs5H9YpC42xAhRtq7t7sHfC6VrY9PDYg2BzRDXEJ96Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974766; c=relaxed/simple;
	bh=LvQB1HoN7JD8oDdgbAWvqzEIgkcUkJ0BQRK9nlXCfWM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OtK+pi90UK77p/6OHwPDO3pZYwiltpJcYlPj+IsXU66Pk6f3xPiQ29V3krNkNQeg/KMWXQcT5cKMHbB2QKcWUGapXjSnLCTSH7qWyJ5LYdLWnhHG6Bd16MqZKpgJllVGDNCk33k0Gzdxexhyl8ujf1drRUCAoBLHsxxOZ6njf84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=RQAwQOUC; arc=fail smtp.client-ip=52.101.72.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RQAwQOUC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmBibHbfOgbpNAFLs+InrAUSMjGz7PpEZsZDVVQ2LVAHdz97aEnSo8tDbFFmNK7CNNfLlVg1B8mlYW8cxWkGiH8YlcCgMqMerqN7vAq3uLgREcBevUCwqccc2bdpWjXZOsAXaNOWjvrB0FCoiYkvth/7s8HJ5lkbW/VEAKT1Vf8QKNOj+8VNPCZbDCVRcF9uSlK65LMxgIsXjNuCteGJS0LIghj1b5hdcp/xLyMReq0AjYK0DtYNGEQj90rTqkZnHo11Z2c+6jMltulUEQcbHAoVTLrPYSmaNa6Y0zy05hilewi+fAf5jE2d0DZ/ifiTpb3xTk8ZQoDVaTJglumWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZqdee58mXhwhVIBPn0kGW7OLBejiaR7f9rnH16oo54=;
 b=Yv0dJTaGeTs11Ncew6zV93s4mH4PTg0kC+oxCxgo3PYukozRfv2ujRJMRKz0qEd/WZ8G0OrjBTw/CHbotYb5Wyb0PYN9pA1KJW40OFBy1yJyagcjXalwbC3khShL2O4BQCoqG8emK+PDchIOfSZI7Us43oKeuoGbKpWoGPoPmk/mwbR2cceRfIpPw1gbwY5vO7hT7txLkUd9UNYVMwO6yztQXnNNZGM9Lb3BZKRYHOzwIgR+RhHxqseA98eI7duOhaRMo41t0s20dQYJbgQaMrbDLLznBjEmnHz4O5D7tVNgpifCwdxm7mLn7KUyondhKDzDpeYp3ALxnKdwCrElpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZqdee58mXhwhVIBPn0kGW7OLBejiaR7f9rnH16oo54=;
 b=RQAwQOUC3fqabQs6Y/QJdx6PQxrmUU2pjbikAtRkZVU/FPR6OlTjnLwpobXHIcANvFYlWR7xN6my7DN2cbJY+Mdw10YpA1ZeMOTeihaQklmbEtWfh7PLJa0wuvzAnMjqXYlhsGj/T+WLFVuwXIwrD3bh9ZSGxMPzd92ambVTqaVnkQxOWhK7RyoUUPcVAeNHUphMuCWXM7+p+D2na7QgZvNjOGWlfaA0u5LW2T/ntB5p9lXa9EIVVgrQqgYKEPdcAkMT5nGSoOcKKLEAUCCDMxL7KFP6dsI49Er/hYHswuz7hm0mCfQvDumX3b0oiWGRtWtN7ZHE5wEnL5ixHrfrFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA4PR08MB6128.eurprd08.prod.outlook.com (2603:10a6:102:f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 20:32:30 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 20:32:30 +0000
Message-ID: <6697d41e-a2fd-4207-982d-999cafd3cd56@virtuozzo.com>
Date: Mon, 13 Jul 2026 22:32:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] virtio_balloon: quiesce balloon work on device
 shutdown
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Denis V. Lunev" <den@openvz.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260624140846.2616797-1-den@openvz.org>
 <c18ed056-72f3-4eab-a370-c02b735e536e@virtuozzo.com>
 <00ebb86d-f7b8-4ddc-a17c-c4700cab73a9@kernel.org>
 <20260702183236-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260702183236-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0075.eurprd04.prod.outlook.com
 (2603:10a6:802:2::46) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA4PR08MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 62029e45-958d-4165-08b1-08dee11ddcc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|376014|22082099003|18002099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	d3mNyGOiEVHGYkoFlnqYOuGb/kAPnYI5s4G1P0SZ39S71axH+DdLg/NvxeTo27MyWRhWNLA/QlCjaU7upx8D36fAaPZe+fWxT13AG/NMZhe54OxGf3NbMrBK4c52NL7VmxNF8/IHjJImFF9CGBN04DsPtcfmx0XvE9eGl3HhlHDEkX/K0aDMCCvtPBWY9vBQkc4RHgq8udX4rotk6y/CchjC+N59wnssfuhFBLXx8NAVksUptgt9ApV5STRpgk7beeQjh3hjjwYXJrFnWnr+ndubsxjEF4jxLDmRcairXKFBGMghmFPbxDZnmIAvArwiZKTl3xlEMusMkonkoQ8O0DunFHhIWyix0T92RulPC5oDGks8eo+KgORxV4pqzy7QQcgvZHcxE87B9oZGy8BjRO/7YNPB6ywkIo00TFB+ECBkdlRL8WDTemRvBk9XL60mLu6s03aIqwLLNxRE6VUhnL5sOHJlOsNKeoPr/cISiW15IuRxpPm6Xgp1R7eM7iGZzaNYdQJhubij7twFpo0VaxLe+ZhKdxCMWmGAgFgPeI5/weI33iZf1eCGDfD0fEQ4wg6tHp5ghVnLZhGI8Yewx+vH4Zv4XysuUWClAq2pl8uI6/H3oJT5rvd/7bgoNvBjCwpNz4/VGVdD2gLbs3Pfrx157VmHOdWyWyfkimedLPs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5892.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWlMU3hUZkxnRzUvVm9yQlBRL2srVzVqNk1DZDROZ2g0a0xnV1JLbWJlaWtQ?=
 =?utf-8?B?a0NzU1M1aE14ckNaN1JDN0hFRjZzSndjWHpiTEVpTTZxNTZoTmFXOXgxS2lV?=
 =?utf-8?B?WTU2ckpsazg4aEJSaDk2STlRZXZlWnY1NDJpZzIyT1hhMkxOcmZJQ0VTOHNo?=
 =?utf-8?B?U3lYYTU2cWZqeDF0aElKamduR2U5eFpaK2xvMEttTWNyTU12MHVtUmZlV2l2?=
 =?utf-8?B?TmNGU0VjQ080K2lTeVB1VnhPYkNlcGhRaXZSMHpxV1VUZGs2eHEyR1d0N2Iz?=
 =?utf-8?B?K2s4N0FoM0tHQnl3U3dUa1VieDZLSkpCRGFWeERWMlplcU1BUGxtUEdqaS9w?=
 =?utf-8?B?RUJJSW9NK1NYOXBMUG82WUMvUzc5c3krNXlrcnN3N2hnSUI4VVJQdkxJVGN0?=
 =?utf-8?B?OVJBSjRoNVZFZHJDSzNpV05YVkgydTNvVGFRQVhWejAvOUo4cVpJM2VHNmJH?=
 =?utf-8?B?TzMxdm5haDJlWWlKNlk0bWxyOUpaVWRNSllIZ1AvTEJaYmNWTU1QSmw3TTB4?=
 =?utf-8?B?UDBESjg2MW02OEM2Y1JqNWlJaHVibGZwYWloZWpCVFlPOUdYdWhJamVISlJi?=
 =?utf-8?B?UCtVV3NPcnl2V3dDaDhaSHZZUzgzZWhSRXFVcytrcXFaUFpxS2oycTZWajZN?=
 =?utf-8?B?Y0tNUXc1VTVndUY0bjZKcFlxdjMxTEg0SFNLTGJUQnkvWFdHT1NvVzhQd1dT?=
 =?utf-8?B?QXRHZUFCR1UxTU00b0ZYS2NaSGduWmdiaGZoT2EvVmlVWUVrcHZ3ci9uZ3dE?=
 =?utf-8?B?RjZ3OUtpUGRHVkhYeW50VFF3UjZKWXBqaW8rSVhxTk5DZWM3QnIrWmNaQjdj?=
 =?utf-8?B?dWgzOXh6TzdrVnlqTkFoaFpoZDVzbDF3aUZhOWk4U1NTVTN4RjJEb3RDRHRt?=
 =?utf-8?B?cy9VZGo1K2JFNXZ2MGlSZUtWdGJ2ZmEvU0tmZG8vNmw0SnNsdndVTVArdXBD?=
 =?utf-8?B?WGJtVStUYWRJbzU1eFgrSzdEMVQ3WldiRlNQYkRSb0MyYnZzSFg3WGlsY2Z3?=
 =?utf-8?B?VkdhWmZNYk9tNzVUVXpJZjlUZ3ZWUVVpZDhqbjYvenk1SUFmMDRNMCs0RVZ4?=
 =?utf-8?B?RkErZVVPdEVNK2x0V0ZPSlFmVHNHQ2F3dysveHJ4RHB4OGJhWjZVTDVPbWVJ?=
 =?utf-8?B?OU5wcFNCemg3eWxYTnBaQjM0d2ROUEs1UVltN2hlYXBNd0huQWlLYVgzVVph?=
 =?utf-8?B?ZndDYUNUbjlybzVtdkY2RExEWm5icDZUM05lQXZXRHFKUXl5UjB3RFRzenFE?=
 =?utf-8?B?QWRHbFdic1BvY1ZLSlg3OTdLdjhVbjZYR1BMN2xNdlF2b0paa0t4WWVQSUU5?=
 =?utf-8?B?TDYvK0szVHRweGsyYU1oaFllRGhzTDJaOEQ0VGUySFlsa2I4ck5CRFVCeTll?=
 =?utf-8?B?S0U4RWZVNllZY1pDUUxHTGpQcjA0UStrY01SdGp0cll1RklkS1hLY29Id2Vj?=
 =?utf-8?B?R0hySTgxaFJxbjh0QnJMU0gzaUpGVkdDbkQ2S1A4cDNHVFhIWFRCdUExekhy?=
 =?utf-8?B?M2Rsemo3UXZxSWl0TUtFdStJcHdJMitpSXJXblJzNmoxbEFVbjJucHh2TnI1?=
 =?utf-8?B?SjdYM3ZHOTk0T3g0VnRmK1hOeXJnbFVMYXRzWjVHMGlVVmJvbnc2SW1jMFpH?=
 =?utf-8?B?b1B2R2VHdUw2QmRsV1N1MmRveGZ4eGZXNDI1QUNRNSs5ZS85YUFyeFFnM2Ir?=
 =?utf-8?B?T3NTcWVtK2htWTRmOXFCMmY5bzJ3K29lRDJCRndkQkN3S0VKb0dvbll1ckNJ?=
 =?utf-8?B?Vm43ajZRNngwTTBVTDJjdnZOR1Y4TVdDeXdIbTE5WE9vdGFRWnIxcEtwWVhM?=
 =?utf-8?B?QlMwMHRHbkdqTlZkNHlJZ2xxWjhHNTIyL0cvUjVxVjh0ZHlQV0tqem5PRzdR?=
 =?utf-8?B?b2dveFZVZ2tnL2RnclhScmRKemthY3RjdUJXaUhZSkNlVWxCakl4cnhzRzJ3?=
 =?utf-8?B?NnQxdlZkZjA3RkRTdnFWQkk4TXlhRHpCZGo2d1IyWER0cGNWWm5lS0taLzhO?=
 =?utf-8?B?MDJqUTE5eHc4d0d6azI2WjFzWXVLOERNbE03dUE4eDFzeDZvNnI4b3ZDYkNV?=
 =?utf-8?B?MWdWckFHL1N3WHBVazhjaW4wbk5tUWxqclNyeU9hUk1CZm8vRDhrSlVHcVJO?=
 =?utf-8?B?K3lka09HTHNKNlRwS3pzbDc2Mk1DWHFCbnUvOWQzcDdNdkJOa0xyNjRMNHAx?=
 =?utf-8?B?Y0I0b3RFcDBlMGtsVkpxQjlLNys4S1Fud2szbnlpeUYrOTR5Z1ZBTWoxY2JK?=
 =?utf-8?B?QTdXVVF1dDdkYjQzMytDNTZqZU5JQmVyMEl0NHNGcjAyaHVkWHpkNjQrVEZh?=
 =?utf-8?B?REphWnJVSGJjR2Y4QVd2MTA3b2FjdjA0dXczdVNsV05xbTdxUU5zSlBUOU42?=
 =?utf-8?Q?dyb4OIFUP7+3447wD0CGRuiYCVUTI3PcQzXtDQNO3bUK9?=
X-MS-Exchange-AntiSpam-MessageData-1: /B8K528Pow7gcw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62029e45-958d-4165-08b1-08dee11ddcc3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 20:32:30.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/CVgJXJiTs4jWBzZctH5aeGjYcUtF1K0naTyH0ARiit1C+EusmF9CUYoMntGF3xFZvxXIujxWo10W7PwHfCqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6128

On 7/3/26 00:33, Michael S. Tsirkin wrote:
> On Thu, Jul 02, 2026 at 09:30:26PM +0200, David Hildenbrand (Arm) wrote:
>> On 7/2/26 19:50, Denis V. Lunev wrote:
>>> On 6/24/26 16:08, Denis V. Lunev wrote:
>>>> This email originated from an IP that might not be authorized by the domain it was sent from.
>>>> Do not click links or open attachments unless it is an email you expected to receive.
>>>> Since commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
>>>> device_shutdown()") the virtio bus breaks and resets every virtio device
>>>> during device_shutdown(), i.e. on reboot and kexec. virtio_balloon has no
>>>> .shutdown of its own, so that generic path runs while the balloon's
>>>> asynchronous work is still armed: the free page reporting worker, the
>>>> inflate/deflate and stats workers, the OOM notifier and the free page
>>>> shrinker.
>>>>
>>>> Once the device has been broken, virtqueue_add_inbuf() in
>>>> virtballoon_free_page_report() returns -EIO and trips its WARN_ON_ONCE().
>>>> On a kernel booted with panic_on_warn that turns an ordinary reboot into a
>>>> fatal panic in the middle of device_shutdown(), so the machine never
>>>> reaches the new kernel. The inflate/deflate and OOM paths do not warn but
>>>> are no better off: they call wait_event(vb->acked, ...) and would block
>>>> forever on a queue that can no longer complete.
>>>>
>>>> This was hit in the field as an intermittent failure of a virtualization
>>>> cluster upgrade: guest storage nodes were rebooted via kexec into the new
>>>> kernel, and the ones whose free page reporting happened to run during
>>>> device_shutdown() panicked (the guests run with panic_on_warn) and never
>>>> came back, stalling the rolling upgrade. The crash dump showed the WARN at
>>>> virtio_balloon.c:216 in a page_reporting kworker, with all the balloon
>>>> virtqueues already broken.
>>>>
>>>> Validated by churning balloon inflate/deflate from the host while
>>>> kexec-rebooting the guest in a loop under panic_on_warn: the unpatched
>>>> kernel reproduces the WARN within a couple of cycles, while the patched
>>>> kernel survives many consecutive kexec cycles cleanly (12/12 in the final
>>>> run, 0 WARNs). checkpatch is clean across the series.
>>>>
>>>> Changes in v2:
>>>> - Add a virtio_device_shutdown() core helper and call it from the balloon
>>>>   .shutdown handler instead of open-coding break + synchronize_cbs + reset
>>>>   (David Hildenbrand).
>>>> - New patch: make tell_host() warn and bail instead of hanging if a buffer
>>>>   add ever fails (David Hildenbrand); kept as a separate patch
>>>>   (Michael S. Tsirkin).
>>>>
>>>> v1: https://lore.kernel.org/all/20260622133715.3707707-1-den@openvz.org
>>>>
>>>> Denis V. Lunev (4):
>>>>   virtio: add virtio_device_shutdown() helper
>>>>   virtio_balloon: factor out virtballoon_quiesce()
>>>>   virtio_balloon: quiesce balloon work before device shutdown
>>>>   virtio_balloon: warn on failed buffer add in tell_host()
>>>>
>>>>  drivers/virtio/virtio.c         | 41 ++++++++++++++++++++++-----------
>>>>  drivers/virtio/virtio_balloon.c | 40 ++++++++++++++++++++++++--------
>>>>  include/linux/virtio.h          |  1 +
>>>>  3 files changed, 59 insertions(+), 23 deletions(-)
>>>>
>>> Hi, David!
>> Hi! :)
>>
>>> Is this good to go in? I have not seen the confirmation that the
>>> series is taken into your tree.
>> I don't have a tree (yet), and once I have one it will likely be more mm focused :)
>>
>> @MST, I think this is good to go!
>>
>> -- 
>> Cheers,
>>
>> David
> Indeed, it's just a bugfix and I'm trying to get features into qemu
> now before their freeze. I'll work on linux end of next week.
>
Hi, Michael!

Have you had a chance to take series into your tree, i.e.
should I continue to track this submission?

Thank you in advance,
    Den
