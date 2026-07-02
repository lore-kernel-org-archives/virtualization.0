Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023087.outbound.protection.outlook.com [40.107.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1F381E99
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014617; cv=fail; b=riszgEd4cPhQrRNS0kel7UHHAwy+PQPpLjtBL9nzOpFq/3vmKjiqO+ZdqKBfjyuM4JCa5M4veB5C4ANEVlhdPKF9g5q4RiEjNlP0VEX2yIWRbGRVJzxmZcYBkOICXC9vV7K2ErAns6vl91Czo6qiUDxB0PGeg4NgLixeZ2r5m94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014617; c=relaxed/simple;
	bh=S2DGmyD8HaYEnj5QRtT9VI+R0J2Ri5xmI+OhcdzhNvs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KrejsyenfeASPo6Pq7kkN52mj+Xi6w6iILj/ErZJWO3lE+j1iQeqUQ0wKvW6ExzBM2Di1SkjJvD/ULtCpJU44KbLlL+dfkYiDENWSb2Pfu/GYAyySuvpw8xJMwAeWxmvSD9leFyLpHMrDP56opMW7s8x+rQRd4P5u+OhRyHeHOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=pN3IOWE7; arc=fail smtp.client-ip=40.107.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pN3IOWE7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM9AcExIa68y6IAMSw3OG3p/cpXTnJZpShwEkJtdqMSKPS590pLKox6tF5VMOrX8aFyK1niUaWGrh1uW7QDRlmleAWMQ0Ry7KbE2J2vZD2ceLvu6/OcXf05rGWrDhUIeITHDluAVq/K+8kvPz5uv1fNrV/5dv0jg9Nv+Q9v45qu+QNgJlOKcQ4Rey/1STJs4CjMjn8T6b3Wxlbc0oCJFG6cZ+qPpZGKcgKLMzNocPMagdsXY+Zwb2qro7VxNKRE5XvUdTm5p58gKGI6cm2pQqFAkXejRBefuUE1Kxz7IJi8Ebid7lnDw4XPZarjdGxEjezuKIsKacjYtbgngFoe1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v/0K4iz8GuiSRyPKdwFoC+fn2PHdEKvrH1DXXOMjO4=;
 b=v642NlX0mZrrB9Q9KdWFDAO0QVkNp7f/4msUauFtfan/kdXZHc+rnR9l9OOSkndQ6VHIELOF6IfLjkHdQop7TcOZxkELvHWAoBkapnasa6hIk0NDBo4hNJkRiHRWWTd7o/OGGdcW0+/5/4p0ZZejgjfWGOHAxax1KiFmhTRAJo4URmb+N85YYDp2OojsZ2BT2RXPjB/ld5g6y7aO4LBkvdTvfx6KdDX8KK/2XZjRMnmy929VemzZg7Vf5oma18n/qksW9mzWHT7scTC1fP71qbwF3/p8xtarKy4WndRK5YIvd2EqmF2xgZ4RmKEfjM5/nAKmgx1gukMRNXsD8AINsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v/0K4iz8GuiSRyPKdwFoC+fn2PHdEKvrH1DXXOMjO4=;
 b=pN3IOWE7and48PqN0Osnun4P4b9P2NThnOJIj4L0r9vlQMD3bXbEOWAcJ/FBIF2yihJKGHTAZimrfLEgNvJ9ob+sDYO1U3JcXUVnAM9ItfDVpaDQXl/0cNGghnCM4TiFzo+LcX4Az9+1mYnRkSPoMpzfwrawRSd3ByoghEBDd4/R1eDEduE+2tEJVHgoaieZj0KMtOCz5kbsFIXL/vIp8TCTbm++OVuuAAq6JEytuMH7SArukpUa1r0jVmU2UK6bYZvhhSJJFt13+eyDWhkzkWZcs52wb1uxyWzf04mvRUNS0NHNXvtWcTuXr+9npa9QVHJ3jdTLhZJdu1rqq/O+eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GVXPR08MB10431.eurprd08.prod.outlook.com (2603:10a6:150:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 17:50:13 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0181.010; Thu, 2 Jul 2026
 17:50:13 +0000
Message-ID: <c18ed056-72f3-4eab-a370-c02b735e536e@virtuozzo.com>
Date: Thu, 2 Jul 2026 19:50:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] virtio_balloon: quiesce balloon work on device
 shutdown
To: "Denis V. Lunev" <den@openvz.org>, mst@redhat.com, david@kernel.org
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260624140846.2616797-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260624140846.2616797-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIZP296CA0014.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::13) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GVXPR08MB10431:EE_
X-MS-Office365-Filtering-Correlation-Id: da162720-0ee0-4e42-0163-08ded8625e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|376014|1800799024|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3kx64FiKM7fqNJAI85U21tSVQ7DHhBTsV498i0ehLcOZoL8qTxJTeTu85/q54ogEp5IiAOjdcza1vBmFLLyE9wlk352AQaduIbNvp2/Sf1O70XuQrTGfyrPCPHFtiAOlvBPoTBZI/FxcSrd90Ta+UT4/WBSsC8lc7muYNp6f0rj13eq6QMb9P0+xkl7orBZMyxfqx9VbLEKDNqBNAcOz5NCm1BjUQxqShogU0y5mxgePxdtBg21kiF63yZJqhZez0NVz5S4tH6kjJONXDX5cklUeGwribSB+8pKbgYiJ5EOxm9QZWLAaHKUZ0spaxa+lOpmoKnXVa+pvBSlgbkgS+/IOFYH7FIgxV30RKKzMIgWIjbo6b2MgGosa6U+NH37tap8lPRsanIOqvhjh4DMYX5e9L0HrMGRmMkjDa3ZZN/suWNdil1OYSyFv2/7jyZMn0iaz/x5Lq7Tm+NZxzpQ0zCOmUh7junWJQTN2+5iixuhu0Ly6LO6zqFiNmJ055o0/dlc+kXWye2XYV8yZbi8TNzgnDFUGToYbKrU4Ja2j2i7aGdeNlKUYlEobnVebD18acuk5U63ziNVD/T8sL0aViey2se52Gyj4m9HGxApSztZ0647LQ4nZ8g7wnR3tM1LvwcUIJ6hW3cwjS9Ke/1Ycn5s6VfSjJrJOCm2CuZyRu6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5892.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(56012099006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUlxT0N1a3BVbnNUbHJqMy90Vmx3TFJNNXFyOGYvYjdwdTRBR0h2MnN5THJY?=
 =?utf-8?B?Y2hOMkVNQWYxTzJ4UTJHU0NlazRtYXQ5SkdNUEhkc3V3WG01NGN2RmRwcFkx?=
 =?utf-8?B?ejcwZ0V4VmFKakR5blluZ1pCZ3FkZEk5eHlGRHNpSFk1amNSRVZBNTBrWHcz?=
 =?utf-8?B?TGxlVTJQKzBTOVplYzk3cS9mMXhSakFhNXNVTmhGN0FqZXFFSjFYeVFweHAx?=
 =?utf-8?B?V0RaYXM4SjZ6OWY3WG5aZVI1RGhURUphUU5iQ0tZWjMrbzJqUEpvUzBWcFRG?=
 =?utf-8?B?Tm1RemFmbHdiVFFLUWpJSDdVWUgwZ1hsaC8vb2ZBUGRSWWExemZqaDlzSHNF?=
 =?utf-8?B?SGd2cTZOV2tFQ3hYelNIL1ZZNzVPaGJNbEEvTjRGOHhHaWtIQnErS3k0U1pW?=
 =?utf-8?B?b2lyOERXeVpYUFlyRVlaVVNrNnhEL0RSUFJWSUljbGR5aExudjhPMSswVjhv?=
 =?utf-8?B?RjNMMHpGZ09sVFBuYU5jV0pPeHV6SXZxUXg4NDYwRkxSSFA5ZTR5MUhGdmJu?=
 =?utf-8?B?cWNUMG5CVm5ESGtoSFdOOVErWjRnQjJjcWpwaVJtK2ViaXZieWx1S1V0dWtV?=
 =?utf-8?B?OHdXQ1c5S2hIVExxSzdCR3Y1U1VlNDFpbGc2ZktxeDhERUVTa0xxMzFOZXNL?=
 =?utf-8?B?NFpJcUF6ZzVlSmROVldwUk9PdHVVOWFFQXNjUWNpazhxNk80azJkbnJtanQr?=
 =?utf-8?B?SjNIamtuTVI0QjVvTTVmNGVrdnhmRk1NajBTRjFkYU1GYVE0dm5Zd1cxdmI2?=
 =?utf-8?B?YWRVcmRRTVNaeEtDQlkwaFRuZkJMOWE1S0ZJMW5pWjBNazBjengxT0hmU3dh?=
 =?utf-8?B?TndWbFhwWlFKdXUvekxoTFJMVFlacitEU1kwczBvN0xVRng3Y3I1R1JSWFQ5?=
 =?utf-8?B?ZU00WUFrc0swa1hUSTA1YzFCR09kNWNDM0xkRzMrOGxRV3VURTRVd2R2S2FJ?=
 =?utf-8?B?V2lkUEd2c0dTSWR5Y3JianZGdVF4RndtQW9nRDF2Y1lNbUtKRVFvMlhaSUpo?=
 =?utf-8?B?NTlXWVlwOUpMTy9pbW5vakFkNEljR3pGWmtDVkZmRC9SWDVVdzN5aiswbUho?=
 =?utf-8?B?Q2MrejhIaEdITmN5Y3RaVittTDBFanplaS81SzNETlJEckZobnUzVnFERXlw?=
 =?utf-8?B?QTgzUWRaRWcrWklWNUkvQ0t6RjJxSnhkdy9COHQ5clUybnVuRHJXUkg5dEdJ?=
 =?utf-8?B?cGxxR2tianc1Y0NLVnFRZEliZjhNLzRQNkhMYVYvd1dLaWFJRDlIdUFRY2dv?=
 =?utf-8?B?OEtlcGpJTmFDc1psZ3VkOHM0UEh1UUhnUFZFVlMvY2JESWJxc1FzNStGWDQ2?=
 =?utf-8?B?RW1VRUc3SHQva1lyR0NHZVora1o3cHZST1ZIdVliTXArOTZJazUvbmNWbVhE?=
 =?utf-8?B?RGcvMXlmVnNVOCtKR1pQakNVZVIramRUSFZaWmdCYjRUZTAxWHJjMXBiQW5I?=
 =?utf-8?B?REt0a1hSTmc5azB1dityTDRWbWZtb21rckI1QWtndXJPeGkzY1NPZHBLanRz?=
 =?utf-8?B?L1BhNzJ1a0VrSEtIS3I0TU1qK2ordEtVa2k2am5GWUlnSi9vRUtzMDA2Wk4z?=
 =?utf-8?B?RThPV3U1WjNINldDOGxMbEF6ZlRTSTRaYVlZeTRJS0VjajhYd2ZqM2RHTnl0?=
 =?utf-8?B?VWZxSlhwVGxFZDlaaWU1QUVoL010T3QzUEVTcmVvazRleW5HV2l0cmpVOWV4?=
 =?utf-8?B?ZWFpTnJrV2ZJSDBUeUVMYzljNGtVNlpZdHo0MG8yQnNSWUlmdDV4cGc0c050?=
 =?utf-8?B?WlUrV0NybVNic080aGw2Wis5RzFlOVB2N0FjVzB2UktacGt5dHlWQjZzZ0o2?=
 =?utf-8?B?Wk54dFVHY2RzMU9aNjU0US96U1dFTmxFblk1SDVxRkdFM2dTOFdvayt2eVl2?=
 =?utf-8?B?cWU0cFRYQkJYZlVKYkNZaWI4bGozTzVSRWw0TTAxT2dxaVpDWU4zV3lhK2wx?=
 =?utf-8?B?SVh5NkNGQUZCVFdoc2lSU0R2WTlJeEZ1THRWUkVwNDArVEt0U0FnOTdIVWc5?=
 =?utf-8?B?UnVYKzJpNE5zNmFZUVhpUk9LRXFBbGRCQ04yQm9CeHZFSHJUeGNpQmViNmN4?=
 =?utf-8?B?cUZqSGNCT3NCZ1BYK01wTHFZWWtpN01oYWtLRDRqTTB5dmVpSUZobjErTWE4?=
 =?utf-8?B?eG43eDQrUm1MWUJTS0J2OFJHQi9MRC9HTTZ1aWxmTW41cUt5NFdRUW96UjM3?=
 =?utf-8?B?dEEza3ZEcUN3QjNrMlJtSDJQWXNPQnRwU3k4Z2lkRkNEOWs3eW9wVUErZ29s?=
 =?utf-8?B?SkttMDgwSTdod055VkduZmNMVml2M3ZhemV5OWowZnZlRjNTZ3JnZ3Q3T2N4?=
 =?utf-8?B?VXkzZGx2bzNPMGY5MERlMzdhRkhXNW9qOEtMSkZPTzVZVEovQXJPdEFqcXl3?=
 =?utf-8?Q?qmyR+5q43dTZkph6f/joAs4bYcgVq+Gf9OO88EtbljFWW?=
X-MS-Exchange-AntiSpam-MessageData-1: LOm5lVx/wLemZQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da162720-0ee0-4e42-0163-08ded8625e29
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:50:13.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BI3apd+6EaOUy20ifUm2UHxJVeTQ9j1eLhZbEfzPRw6z47ye1nDojxTKspJBlQ9y8d+tgmb/aFYNAzwKQHMgyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10431

On 6/24/26 16:08, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> Since commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
> device_shutdown()") the virtio bus breaks and resets every virtio device
> during device_shutdown(), i.e. on reboot and kexec. virtio_balloon has no
> .shutdown of its own, so that generic path runs while the balloon's
> asynchronous work is still armed: the free page reporting worker, the
> inflate/deflate and stats workers, the OOM notifier and the free page
> shrinker.
>
> Once the device has been broken, virtqueue_add_inbuf() in
> virtballoon_free_page_report() returns -EIO and trips its WARN_ON_ONCE().
> On a kernel booted with panic_on_warn that turns an ordinary reboot into a
> fatal panic in the middle of device_shutdown(), so the machine never
> reaches the new kernel. The inflate/deflate and OOM paths do not warn but
> are no better off: they call wait_event(vb->acked, ...) and would block
> forever on a queue that can no longer complete.
>
> This was hit in the field as an intermittent failure of a virtualization
> cluster upgrade: guest storage nodes were rebooted via kexec into the new
> kernel, and the ones whose free page reporting happened to run during
> device_shutdown() panicked (the guests run with panic_on_warn) and never
> came back, stalling the rolling upgrade. The crash dump showed the WARN at
> virtio_balloon.c:216 in a page_reporting kworker, with all the balloon
> virtqueues already broken.
>
> Validated by churning balloon inflate/deflate from the host while
> kexec-rebooting the guest in a loop under panic_on_warn: the unpatched
> kernel reproduces the WARN within a couple of cycles, while the patched
> kernel survives many consecutive kexec cycles cleanly (12/12 in the final
> run, 0 WARNs). checkpatch is clean across the series.
>
> Changes in v2:
> - Add a virtio_device_shutdown() core helper and call it from the balloon
>   .shutdown handler instead of open-coding break + synchronize_cbs + reset
>   (David Hildenbrand).
> - New patch: make tell_host() warn and bail instead of hanging if a buffer
>   add ever fails (David Hildenbrand); kept as a separate patch
>   (Michael S. Tsirkin).
>
> v1: https://lore.kernel.org/all/20260622133715.3707707-1-den@openvz.org
>
> Denis V. Lunev (4):
>   virtio: add virtio_device_shutdown() helper
>   virtio_balloon: factor out virtballoon_quiesce()
>   virtio_balloon: quiesce balloon work before device shutdown
>   virtio_balloon: warn on failed buffer add in tell_host()
>
>  drivers/virtio/virtio.c         | 41 ++++++++++++++++++++++-----------
>  drivers/virtio/virtio_balloon.c | 40 ++++++++++++++++++++++++--------
>  include/linux/virtio.h          |  1 +
>  3 files changed, 59 insertions(+), 23 deletions(-)
>
Hi, David!

Is this good to go in? I have not seen the confirmation that the
series is taken into your tree.

Thank you in advance,
    Den
