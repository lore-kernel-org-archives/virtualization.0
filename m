Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023075.outbound.protection.outlook.com [40.107.159.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5521FF23
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320601; cv=fail; b=GeBQxJQzKdIoHrh3MtFnx0DC8brrotvV3IV/BIktepZznGu+xXDVCbO6IIPvLWZp0krvWAqWd1ilVubwviO0isoK1iAXGVemfvZ5HPG4PPj9fiwvpjDnY3Lut/iYag6oq9+oK3Sz5nvsXS0PWlJgotaqUB4Pph4PIDrgW80ZjZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320601; c=relaxed/simple;
	bh=gphVNwZc/IApHDsyIx8OWqdxuGX3u6tRmLzpuT0+PTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G7luW5D3A7Iit4aLS0zZW6slRDujhlHamqGH0Tf6MR2lcBR+KsL8W2G8N/b+PWhuNfMpBnVHmRYPuc+gT3nWTskn/9R5KSIFdk3B9eIRdm+puGCnZwFhLoWVd7dTlOtkiMuhikF7J8gYrPq4XLStwYWMHoXMTfXntWrGpPTnpEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=LyNSb7ke; arc=fail smtp.client-ip=40.107.159.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LyNSb7ke"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpVqCmCbTNMO21YCaE3PomAaNcv38EnvwcHTXE9DLWjFlPYKtBNEXBBXFFBCcEcmBfG8TI5oDsrsrM5niNNSFtbjJHLN6knJhpdhwn0LWuwAtAfZ47rGPv+02dze9tDrsoFFNF3gzvYvvTTmEpZIQrj1UWvJKIuBHho3oZFNpFBPtMfIodV7dyPx3LI57iTFAfKmjbld9TlbhNbXw5Inh689ZBhEbs+HoIReQGRLjtyCRjwsuINxY6m41vzLuzdRIIf/qktxst9RbCNIClgnp+d4rUNnPDjeQiiczObO3+bi2TUOWvw/QwYmYZG5B05vjQ4BtwrY1v95hZZkPT51Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woddVGyRdGVG6T0HUABRXQwTsEwDZ4fBOQddV1wFXw8=;
 b=AOszkEFfr5+n9g8vCvd1Z+em8cwz7PCrtX5/PuKUaaLHpbMVSiXRJAlMICdu/Zvv7Vw4hZwhuhQ8uVpD8WH7t/eq4++QVPkITpnC2txzSmvElDbbyalJIOx4z0MWwQcNzu/V+3XW4H2V9bd2xxcYQIgd58fDie0a/eLoAFLpAtReWAIiornHxd+9tUT6zXVV8kWD1TMNjUYmKOaZ86yDLR9oYa8PEuBhrZY7G79DaOZ2OOS5sOwq9VeNyPb8Y7X0TOYcXoAL6r/Hzj4Um51MnLJActPP2C371Z1Kl/G2EbZNzG1JpS5mmmw93/A5N7cJoh1VuBUtsPGftl7yY+VPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woddVGyRdGVG6T0HUABRXQwTsEwDZ4fBOQddV1wFXw8=;
 b=LyNSb7ke837cXHghIVGJFJZc9GAB3tuS7x3DFoIq57Ra2LcC8itULszvGv+BY3B8dv86M36bQy4/BKn4qrUC/juKZIXm9zp/3W/jotB8+5tPJS/K8NqRF3wQVMV55eOpBT9glySxw2y1th2M6ZxgRBgf4v/MT+VUs+mmXhVRlr4kVIbS88XIjO0GDmpWDfjxVNlOdbWpV3QUkNYcXmd+U9MpBk5FudS8rejGoTM8uzAKsfKpE7Co8m7sMeFSEirUU76jt/mBSQvFa6aTTDvVGUeB5H5n7rM5t2E7mPdD7SLTwQgsKJ7JBFgF50L2LM4lih6RKUyUngCt3jujp/mH0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU0PR08MB8207.eurprd08.prod.outlook.com (2603:10a6:10:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 17:03:14 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0139.009; Wed, 24 Jun 2026
 17:03:14 +0000
Message-ID: <98ef15c5-3c1b-4982-ab1f-4110e2c2c808@virtuozzo.com>
Date: Wed, 24 Jun 2026 19:03:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/4] virtio_balloon: warn on failed buffer add in
 stats_handle_request()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Denis V. Lunev" <den@openvz.org>, mst@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <549e5456-2b6c-48a5-abe5-ef5425c3f63c@kernel.org>
 <20260624154001.2733242-1-den@openvz.org>
 <1dc2c6c3-ebce-4646-afc1-d83755537278@kernel.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <1dc2c6c3-ebce-4646-afc1-d83755537278@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0066.eurprd02.prod.outlook.com
 (2603:10a6:802:14::37) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU0PR08MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: d45d5778-65b8-4990-8c7a-08ded2127aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gYWyIvkoGPpjCcCcAzk3nC2f9lpX4pkVl8q3wJUYs6aOvJApt6PvZHwkaEZHtnVV671yGugQeTjML1k/bgTCF6Ba20n7XOf1aD8DZx0nEFFqPNPFhxvAP5amUCcYnuJdEIplc1ScyeaBlgUWwrf7Gz7H3nz1Nc5bfJ057LcJWi0s9fJccuHwGZ8U4G2lXyWUQKeGjuZRDYjX0Hyg4Kug+wkht5KxVT+Kuf0MgH8j7O+68PE561hO9Mw+h1qXpnVyGJ9IU7HkGdvImDvHmTUQ5u1q0HKyFL8JLiSbTj5wUAMgjVUVhE3m4ATw+fbcmo//l0cUXfbs9Fb70o7ghMF7p9qcTKsh4fkeCEjt3P4xCdHzbpGaAGgRsa8+ZISiJix5XVr7gonXQnYZlLsB97Ps6LN/p52BR189/hwq7K4Txc3drNE3MdXOKDATvmHSOHWTBMMDr8jBcdCJdCiFTJ4NoEAuIzRPoxQuygWYfhNcK0/Nieyp9Vb1f6LhauaMiCTSKGpeaM0934crHnW7J3bfJx2AQz7hqlml2LTV+f0jzeNjuPAvKemfql1bJAbm4NR3FUALDpEUj0ghS6RjnVv8BGzKP5v59VpYXs0HDtiIe9t6o5T6w/qWu6udsvNsYNbCLMKXBfr4Boj6DjYCFZYRLQ1h3pE+BEAqVj88OsvV8Ug=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5892.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2pPR3gzSW5XMnJmK09LdFNTMkY3eDVDb2xJU05xbmR5WFVRMHR6Qlh1ZDIz?=
 =?utf-8?B?emlpZVJCYjMwTllMeGJHWHJCeHdZSE9WTlFRczFlelNySmJwenRGUExvSlZD?=
 =?utf-8?B?VUhpL1RoQU1lZGZpc0ZocHdmT3JkdkdnQWhEWXZ1RERHY0F4cWhDMjMrTTlz?=
 =?utf-8?B?WmR3ZHEydlh5aDRWTUUvdUNKbjVvNkdhTHhhZ3E0MUFqMyt4THBEUzA0Y2tT?=
 =?utf-8?B?Sno0VDBxdzZsUGhyVDFyZ0R3ZTR1V1E3S0NGWFhoWTNjcVpxYXJIWFJtM3Iy?=
 =?utf-8?B?bGdkdEdOMXRoaVMwUkR3bFhyeVRmNVNKeTNmaFRTRU5uVURaSzhYWEZidTVT?=
 =?utf-8?B?SjlzYVlBeU9neHdRSG9lMEg1YzFnMDlnYXNEaUs1eTJ0Wkh6M1YvQkwyUmVD?=
 =?utf-8?B?WnpXTUxWRUhlWVpGOWxsb1VURDVvK3lIMlZUanI2U24zdElCcklGS0l4ZFNT?=
 =?utf-8?B?eDlYVjd2N1ZUUkE2U3l6VUR0TWVkek43akZHekpHd2k1TXF6ZkZmZDU3N2Fq?=
 =?utf-8?B?K0RPZFZvM2oxT0poOGdyZXpibFJjSHVKZFhHRU1TWVljbks4bURUWWk5WERL?=
 =?utf-8?B?c1FIclF1NXhuQ2wybTl5Y0c3UVFCZ3hKc3B0SThmWitKc05JQ3pUU0JCUmg4?=
 =?utf-8?B?VU5LeGlkTW9sdldYU1VXTkVYdzU3YitkZmJNTlF4R1h1M0Y5RDlEM0RFZkZR?=
 =?utf-8?B?bGgxaXgyNi8vUkp5YjZJT0dWUkNwNkZQbWVXUXVHU3lJVGxSUHNKREVUM0Y4?=
 =?utf-8?B?elZOUVk2cTBKa1lWMnBEQ0lzSlNzQm5ROFFOZ0NzelVGSFpIMHc0eVZZK3Iz?=
 =?utf-8?B?MXd0b2FGemQxS0hHOHFNQU5yb0RaL1JlWXM5ZTlWdjBiTkVJT2s2MUo1ZkF2?=
 =?utf-8?B?WjhmdkhuUENkQU13T2Nha3dqUVB0dnVIYjlHak0xRkJvckhCNVg3K2hOKzBO?=
 =?utf-8?B?eXdiOWRiQlROeEdrTHM4c1R0dXcxQU9uYytzeDNMY0N1QU9zcTVrOFd3SE9X?=
 =?utf-8?B?bDB0ZmU0dFRiYktwL2MvdlRodVNQWFdzRUJLU2VOWk1LYnc2Q0U1N25kMGFD?=
 =?utf-8?B?RDVwVVdCcFFyWFgrOEU1T3lKUkRIZkdnd1Fza3FyL1VraGFOZE5NYVNxR05T?=
 =?utf-8?B?ZzFXaWFTbXRjdFdnSFkxM2EvUzRrWkJLeDltSzJYM3dPdndqcU50cHA1WHBG?=
 =?utf-8?B?RlBabUhuTjZIRlc3OGJTWkZab0sxd2NKM1pTWXVFSkgzWXZnTUt2blFad01P?=
 =?utf-8?B?R2dQTmtCWHhLZi9ZcFZvc25lLzdJYjNCTkpqdkVRNTkwMy9EaUc0cm54eHN0?=
 =?utf-8?B?SGo5L2sxaWtuTmFIZ3RlYXZBVnNoS3VEeGRrbzhjb04zcUJmZFNLUERITDV2?=
 =?utf-8?B?RnE1Y21BeDlnWkoxaFFQaGU4Tk5NYmVYVjIxdC8zZ0Qvbk5CdW1qOXUvOUtZ?=
 =?utf-8?B?L0p2NEwzSFRYYnEzcml6akN2RjFGTzQxY3JMbW01Y3F3c1JaSE82Mlo2c2dF?=
 =?utf-8?B?T2dRTXhoZjMwaW1rTkJtTFYvQnFMZHcxNkFrRjRDdUxaMkNDQUpXUGFWMkZu?=
 =?utf-8?B?dW1wSkN0UXpIYlRTbkN3cEFMQ3JjR0xMREJKd0pwRmEraElCRHBtMGlHMkFC?=
 =?utf-8?B?YTdkVXVaNUxtUEF3TGw1QmErUGZNeHVkdjdqblRxR2txV0grM1BvNThqQTI0?=
 =?utf-8?B?dlovVW5qN2VoMHFNb3NpdHpDR1RsRjAvOUJHK3NWN2lHL2hDSzgwZ2RXVytD?=
 =?utf-8?B?NTI2Mnd0OGlsb2tlT29GbFpnTHVDRExENkZCUmY4MnY1VHRmVkVxZlhERVBI?=
 =?utf-8?B?bEJKaS80ak5BNGNOZWtnbENmT1lhMU0xL250U0RJRlBHVUJNSm0zdm5KT3RI?=
 =?utf-8?B?Y3ZWb0hUYmtROEJ1akdoRVNXa3h2T2ppeDczTFc4NFdnVGhhT1ltQmFvQW0x?=
 =?utf-8?B?eitITk9iRXRJMFpQTVZMOUxraXhPek9oRitJMERkRDZSYkpzNzNaOWJsLzJ4?=
 =?utf-8?B?eFgzamZRSjVoZEUrbVl1cThQNVJSYWlzck80cnYzRHhBRkpwT1paV0FPaG1h?=
 =?utf-8?B?VXNuUGdRUHRBbHdRVkFQV04xV1huK2llUnZEMWFBKzlrTktMN2liR2hVREF1?=
 =?utf-8?B?VExHdUgyUGVncW9UNEhkVVFkTC9zRlNhSWhkeWg1aUxCd0gyV1FMWFhvWVE1?=
 =?utf-8?B?alJOd0FtNXRoc0N2c3FrNTFNRzAwWTUxSm9RZXVNZ3hpM1BLdzM3U2pVYThJ?=
 =?utf-8?B?S254bDJWTHFuYkdRMEZURFY3WnkrdHh3WHl6ZEh0cEdYc3lDUlRoZTZGTjFa?=
 =?utf-8?B?SkVOMkF5L1ZKUVhWVTNJL3lyb29xeEt3SVIrSHZ4TEd4NlpVUG9CdDQ5T2w4?=
 =?utf-8?Q?ZJER5ZvikwmQ/XVLnAFWLi55OBs4BoLKZnl6SrTUAp60D?=
X-MS-Exchange-AntiSpam-MessageData-1: M0JZRflztRhsxA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45d5778-65b8-4990-8c7a-08ded2127aa5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:03:14.3371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yojsCQq6kWGdLPhExAYxy+V3AaaAF50Ylo+E/+GK9HyA77myKnxaL0kj9D4NmzfL3EEY8x2sp/uchsyON7WeqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8207

On 6/24/26 18:56, David Hildenbrand (Arm) wrote:
> On 6/24/26 17:40, Denis V. Lunev wrote:
>> Like tell_host(), stats_handle_request() ignores the return value of
>> virtqueue_add_outbuf() and kicks the queue regardless. The same "we
>> should always be able to add one buffer to an empty queue" assumption
>> does not hold once the virtqueue has been broken (e.g. on device
>> shutdown), where the add fails with -EIO. Unlike tell_host() it does
>> not wait_event() afterwards so it cannot hang, but it still kicks a
>> queue with nothing queued.
>>
>> Warn and bail out on failure, mirroring tell_host() and
>> virtballoon_free_page_report().
>>
>> Suggested-by: David Hildenbrand <david@kernel.org>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>  drivers/virtio/virtio_balloon.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 0866a8781f0b..454bbb77331d 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -445,6 +445,7 @@ static void stats_handle_request(struct virtio_balloon *vb)
>>  	struct virtqueue *vq;
>>  	struct scatterlist sg;
>>  	unsigned int len, num_stats;
>> +	int err;
>>  
>>  	num_stats = update_balloon_stats(vb);
>>  
>> @@ -452,7 +453,9 @@ static void stats_handle_request(struct virtio_balloon *vb)
>>  	if (!virtqueue_get_buf(vq, &len))
>>  		return;
>>  	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
>> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
>> +	err = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
>> +	if (WARN_ON_ONCE(err))
>> +		return;
>>  	virtqueue_kick(vq);
>>  }
>>  
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Although I would just squash #4 and #5.
>
Sure thing. Does this way to avoid re-submit if that is possible.

Den
