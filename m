Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022120.outbound.protection.outlook.com [52.101.66.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081EE3D667F
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486727; cv=fail; b=QMBoROfQZbwnf9CMvnh/r+jZ6cuKTL+L5Oib7aygEAQaNe0WazgGiYMVCu1Q5Ng2GQGzyUsrxGfo9/2/aRPAk/7x8S2Il4gnJBdKb5fvWvOXwMBsqOvC6VMvxbptPLdV+xYanrDg7w094kpnkv+qmjDXK2wGQQCpz7onbku0W04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486727; c=relaxed/simple;
	bh=KBiwj0L1b+Q0zchSLZeNPDWcMqJPvihPs5Ce9KhxTeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BQewUKUzc7odTqV0AjYjVBjvVdrJ2ZE7+SQIKdH7IRFcovvrb4HJjU3T3sXyEI0C0Mo12L72COKkSgjdzlZ/emfz1mKOXLglQV+BkqO5xfzVYRyjfM+M2YwiP77Rb3CMLKYu54KoxndM/Yd3bBna9ur11P7D/k6bfyUvT4qHR+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=dmOtKfH4; arc=fail smtp.client-ip=52.101.66.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dmOtKfH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+exaK9VMzLN6W7Mk3OaNYVr5ml15oRzxHuf3NiGEq3r4iIDgc/28caMm8w28tfCWLa3+T0DaEqa9NAkces54y68cDukmH+K5WE7nEicaC+SlBdkS8GfNPjZnAIO28W4wvjIV70UGTuWb9rlLqbrsajrQA1p0i4M3P3jojorpAi/esPz6h7IIZTlMoYuSyXnLeRY/tBRtU1o/WqtmUeNTG8PlLA3iDhR+c9gLZiaMB2CoFVLyGDmSL/mZOaZvCqHMgXNWJVRIyH3wmWUbIzp4aleswC45zuNxR91P5d+yGrfgHkYC+yha5GnwD44WtTKWNCVxv0VtgsLyAqfx3jkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBwc0TODubuO6KOmnilWFYSaUf+kBMnslsduX6m7hp4=;
 b=gd5o+q9ZlX04vrqCIB9YKn98iwvG3f3mgly2voW6u6tIE7oJKGwV6d9QpjCF1XQ04J5dmbr+IAO4/0eGv0i/QHvpLoGd+/FHfgIUWwD7jK9bBCzcOdjzsQcYdkRGJ8PaFTcTicinqns7qFrcyghsWMbxzI4JicPunJIpPNUsw2lhOO8qZj4P7ZCzvINvVRrTYrMNdS2DIdOdR5Sp7vw73Za8qfy+VJAeP/kotw50y8n8R8QvUkCk2xangSHx7/2lHyh1XXZUiDc3WmqIb6glvzGDOjI1ZViPyIogIKmMNeGxWE/XrDY6tgqQI7hXJp747RxEVaaImsuxHz6BrOWm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBwc0TODubuO6KOmnilWFYSaUf+kBMnslsduX6m7hp4=;
 b=dmOtKfH4eNq9hI5Fg2b4fQsM3bX52nQoKLg4UIk5Q+Qhl7s/pzhdwMq6iROnH6D3UZLlioOyAK+DAvqgIxq6L1McMlB9E5c+hnTzKjSCozKu+V0EGlWiQcn8CjtedatfQIv83r+mTfpQeNsHfhqDPOSFvWyAGQo8vVfp+TqsMk8WV0VhuvL3bkFCzkNbDW7AUN6PK6zDjZmFa0zDWRqcPsWH1F8tzSa8NaaEzV7N7jKuG13TQFQkDjq0FslmpJF5P1eTYQKXb9QYdYJsBN4oJCoTQlN+evKdrrT5Tp7RkkKJ/yX9JvaSO2z/Bo75JCTJVQDDEA4R7qyZBCULfg9dMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB10373.eurprd08.prod.outlook.com
 (2603:10a6:20b:546::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 08:31:59 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 08:31:58 +0000
Message-ID: <f8646e25-7e81-4f19-aecc-a040caac1103@virtuozzo.com>
Date: Fri, 31 Jul 2026 11:31:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, sgarzare@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, ptikhomirov@virtuozzo.com,
 den@openvz.org
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260730194858-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260730194858-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB10373:EE_
X-MS-Office365-Filtering-Correlation-Id: eeeea520-2f73-4405-a9f7-08deeede2fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fj0uRw85C9m1hvU5mB3Cj5S9K9bGgid52nVCOHy4GhWuacASG25tdii8qTxQlGLEaUHzFpH+Azjv2Hdft9a+hZ80ZevFtNKBEV6J54U5okQf4QEClg0st6vp1/InzBKYjTctJ/6ndHUSZTgSRmY6ggqw/ZJl1RZIQiTK20b3YOcybjcbj8isu1ygL+RcY2RI9E3ssLbdSTr4d6ElWcCXWUqmSkojcTR1Lb8tekQPCFQG1s2UiISoIIyjkEQf0B0St+iRgagjOqb3kenVaISaL0pfKyibX/sWU5y+fsoFSAG1rJvdzxUL3FjLI3bA9rbfFbc5RMTzsciBNQI6qLIBFYK8b8fAQKW+CcglTjlunanSFFdKQiCGMZHLLEsCoEhy0fiWFLzzD5edecRRU6WZWDzLh6AYdutQc/PKlVeDq+zUuznT4ttXi0IZbJpMX3XZQfvOBzp+Qk+OaZ96OGtszz4IXYRec1YIhffcLsBs8jRYo8QZgj3R7eue9mywtRbPr798Vh+yoEJqm/NkvoBsKQHqylnd2a+KeRwFj5PmwxSUcnWhaM7yCy+Uyi6zZZWPoH/JqUDuA9sAb4VQgQMxMK5mIe00ocs0FXUTHHDL1ASO/P5cIrP5ONjd+Mz22rDx1Z9HpQ1iKz6DK8EgydkDDBGQkZcZI2L2sKfgIk4QWIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHF2c05wZk5kMzM5aUtwb09yZ1J3UXEvQUF3aTJ3bTdYeWRCbFZxdnNMci85?=
 =?utf-8?B?MGhrNEdUKzdzdzJtbS9lNDVNTC93NFE3cUp1amdMWW00ZE9sSVNhQlJBQ29B?=
 =?utf-8?B?dTRicFF2SUxZcm9LQlVSRXpENWJlQXExUGpCdEo0ZHMvNUpOVng3MWI0ZjZn?=
 =?utf-8?B?NFF0UmQ0TmVhNjN2NERvcVUvZHk2NUJ2SkZKcjdIby9WN2VQaENFbEpJaE1a?=
 =?utf-8?B?elZkZFVqaS9aZG9IOUpZS0FFc2xoWXVZdTdZTHlZbUgxZXQ5SERmRWVMQ1d6?=
 =?utf-8?B?Sm56dXJ3WU02eStoOEQvdnErUXpPUE1TYjRiV2N4dkk1WjlBWklLWEs2QUZD?=
 =?utf-8?B?QkpSMVE0UFNkeVBESEN4N3daS1plYXNUL0MrUnlaOWVyN0lTMm41eUNtYW5P?=
 =?utf-8?B?ajRsT1RlNUJya3NuM1dDQ1VDNGZDOU9CRkFFcTZSL2pFT20wamoramxpZG12?=
 =?utf-8?B?QTZKZEFsUjUwczNtdTlXWFFuajk1REdEajFOZ0NreXF4NE40MTg1Zmt4Zmpm?=
 =?utf-8?B?S0dxRW5NUllZYS9nNnpPOVUySm02bDZiNHRUd052VXpsYmY3WVdCM2N0cXZi?=
 =?utf-8?B?ZmM5dURLNzJnRXpkOHpsUzRhR2tWQUFvSmVLY242dkUrM3BJMmxPa2NkWGlS?=
 =?utf-8?B?OEJxeHdWNDB4UzhZUDQ0clBmSEd5V0dpODdWVWM4R1NlcW83eUpEdjZNOFFw?=
 =?utf-8?B?ZnRiNnNOdFg2WkdYeW1ONjVWWGhTSTcwZE1zZm1mN2M3OUlvN21zbHhpbkUz?=
 =?utf-8?B?QUFWQUhhRnp5emh1NE11cXRpUk1HU3IyZ2FUdGkxTFJ0YUNnL1AzSDhYUlVD?=
 =?utf-8?B?cnFFUTRlMW41U3pEN0d5TWRIZ21GZ0Y2WmdqSVk1OHRHYmI2VS9FbnhSdkJX?=
 =?utf-8?B?S1U5UDRUYzl3amVHdll4TlN6eGJGS2NBVjZCZzVPaGtZVWJ0ZElCUGNjVkVH?=
 =?utf-8?B?eXVPTThNVVh5M1N1SkdsSGhuL21yaHArd0FGRmJsQzc4VFk3Q24yMlZSOWNu?=
 =?utf-8?B?bHM3QTdvY2h5QkVYcXJOb0FBVTIyZnFXNFNSa3RWWTNudUlLaWpDdVp5V0dD?=
 =?utf-8?B?T1RMeS9oL0RtcXEzc3BOR3RvbWxlTENsRm5rK05LNWx6ZHRQa1hvSUlpVnZV?=
 =?utf-8?B?bEwwdXpTbTZPSnF4cnJqa1BQa2EwaC8wVnRvRWRnSFNKTnkzWXlEUlFhQXFV?=
 =?utf-8?B?U1VsMjJaL3FwSU1pa053aWxCZEJLVWxXa0Iyc2xuSUZyWXRYQzZxNUZVOEM0?=
 =?utf-8?B?UTZNZHUwNStPQnZWUGFPakVMOXRKM0Z0TkpUMkpCanYwelczbDQ4MkZadEJS?=
 =?utf-8?B?WXdLQVBtOFdQL2ZBRjdoeVJ5WmFqRXI0QTdPVytVa29hMU52b05MTEE3ZHdT?=
 =?utf-8?B?TXVGRG4yVUxFLzJSV3FrcnZoNGV5dHFVdHJTRHNlTXkrK25lcThpTEdVNjgv?=
 =?utf-8?B?bXJ0TTMwaElBaCtrK0N3SE1ITnkya1Vvc2VqRDY1alZuZXpOOUZqaWVFWFhD?=
 =?utf-8?B?bGwrV3ZDU28wMXZVbjVuUG9Wbk5ZS2haUWtHRGo3N1FrcFJCU05NcjNOL0JJ?=
 =?utf-8?B?OU9ONzUxUGhXVGo5Zk9rU3BJL20vcGgrdHE0NXluNTZ6VjFabkt1d3NYb1NT?=
 =?utf-8?B?andzT1FuWlh0UkdveEl0RjNGUjZXT3RmR050VHZLQk4ycnNWTFI5UHhXWkVJ?=
 =?utf-8?B?dDB1M3RnWmtoS0tJUHJ4UFJJdkIxQllzbnNWLys2cmMxaHVob3Y0cUdLb3pq?=
 =?utf-8?B?UHE3UktoWTNhZU0wcnFvN084WmFPc1JjZG1KZGRzUjRSYjR2V0NDbTQ5Tks5?=
 =?utf-8?B?Vk8wbFJyUTJiejdxL3RiTXFOZ09KQSthYTB3QU9nd092M1pNOFcwd0FUMmM0?=
 =?utf-8?B?RUxnQkFpYWEzVm9tSHZjR0dLNkdrUDlQOUV2ZTBITEhFd3NjZi9xQUljdU9i?=
 =?utf-8?B?akR6UGtQZUZIRThGS2FZaHVUK2hhQXY5Nk5SMFordDlNSnlmOVgwUGtFS29s?=
 =?utf-8?B?cG1mU20rSUdyYStPeHN0NUJCZGNSUmUweGZxalduRUdsSHFVZFNzOTJnRU05?=
 =?utf-8?B?aHlnTDdQUlYrRlFneWN5NVRVZTZSeEpSUUtqRHBqaElReFdQanBVcUZsaUYy?=
 =?utf-8?B?Ri9uSWlwN3MvdVU0c0FQQVhncmExMTVGN3Ywd3JCL0RJZTZIamgxMkI4WmdL?=
 =?utf-8?B?MmQ3RWhBaldZaEdtcmVBQUpHM2ZONVozaXFBVnJHQ0ZTK0xGSE53VVpPRXpQ?=
 =?utf-8?B?a3BsNVZMOHE4WFRtMGtmcHZLYjhqNDA4OU0yanU0UTBMSHpTTlJGYTd1RDdC?=
 =?utf-8?B?MmQ2TWJLRGFGLy9VazdUMS9VNXd5VVc4N2pHM0ZDWklZaENOT0Q2ZmpnK0Jw?=
 =?utf-8?Q?h7k22ekq2JeONxGc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeeea520-2f73-4405-a9f7-08deeede2fdd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 08:31:58.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CG80HtWVRZXZl7r8Dj7eI62CkYZsAL14R+43LtclJDrOAZ498OKHt2AAoS7JWBp4hmU0A4GbIL6zDb7t6VXf/2IuwA8Y5HTVN+/TZLyt+EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10373

On 7/31/26 2:49 AM, Michael S. Tsirkin wrote:
> On Fri, Jul 24, 2026 at 02:45:37PM +0300, Andrey Drobyshev wrote:
>> v5 -> v6:
>>
>>   * Patch 4:
>>     - make sync+flush conditional by adding a bool 'sync' param to the
>>       chain, as suggested by Michael:
>>         vhost_dev_reset_owner()
>>           vhost_dev_cleanup()
>>             vhost_workers_free()
>>
>>     - reword commit message and comment;
>>     - drop Fixes;
>>
>>   * Patch 5:
>>     - add 'sync' param to vhost_dev_reset_owner() call.
>>
>> v5: https://lore.kernel.org/virtualization/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com
> 
> does not apply for me is this for net next?
> in that case
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>

The series is based on tag v7.2-rc1.  However I think the reason it
doesn't apply is you already have v5 of this series queued in
mst/linux-next, commits ddb0918e36c4^..ad5b642c84d0, with your S-o-b.

So you might roll it back and take v6 instead (only commits 4 and 5
differ), or leave v5 in the tree, or I can send you v5->v6 difference
separately.  Whichever you prefer.

Thanks,
Andrey

>> Andrey Drobyshev (3):
>>   vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>>   vhost/vsock: re-scan TX virtqueue on device start
>>   vhost: synchronize with RCU readers when freeing workers
>>
>> Pavel Tikhomirov (2):
>>   vhost/vsock: split out vhost_vsock_drop_backends helper
>>   vhost/vsock: add VHOST_RESET_OWNER ioctl
>>
>>  drivers/vhost/net.c   |  4 +-
>>  drivers/vhost/scsi.c  |  2 +-
>>  drivers/vhost/test.c  |  4 +-
>>  drivers/vhost/vdpa.c  |  4 +-
>>  drivers/vhost/vhost.c | 26 ++++++++++---
>>  drivers/vhost/vhost.h |  5 ++-
>>  drivers/vhost/vsock.c | 89 +++++++++++++++++++++++++++++++++----------
>>  7 files changed, 100 insertions(+), 34 deletions(-)
>>
>> -- 
>> 2.47.1
> 

