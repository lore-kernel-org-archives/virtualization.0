Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021107.outbound.protection.outlook.com [40.107.130.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD33451C8
	for <virtualization@lists.linux.dev>; Tue, 23 Jun 2026 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242725; cv=fail; b=Hxc1tzhAFvqZP5zoNx21cAWCiZV78deMO2X0hFf+zAkhQ3bt/MYnPz7e1xl7Btif4Vtkniu4UXcPxkVmTf5N5FTppJ48KnkFB7zseqYMUPUel/GmjMAq74beYGZ9LcKDfIU/v1BT6ApG6SN1ZU8xCDwJCQCGC3NIDcuzsMSGtm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242725; c=relaxed/simple;
	bh=hj8kKtwqi0Fv2VRwXKQFL/+nR0xiUYb3w8Lsw3RUTxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFKKsWTHKKiqsCbI6dTiuPjLu9/3qU6XLm7DZRqY9KMxxmCDzgWVGwhrZllanEPvSHd8losB0VlYg/vOwJC9tIjYN8qxsy5h7+E3MKKWyzbHzWbjKEiQoo5y4ib8LyKVgC3eqwrv3EH100Kr5yVyEUcnvTm0rn5plifu7Zolfkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=EIcys79u; arc=fail smtp.client-ip=40.107.130.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EIcys79u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/Vr9X7ETXVsI7i197gMKPx96KJ5FzMtszIuf7MVN/rNhaax00afdA77nrwYIkXoOQfKo0QZso4KJxI/fjrAs6LSoLbf6cu8rr8MNjfcwu0RbakqHVhTV1FzOUASMdV+gonp9dxDkmtipS30wiv0TV+i2K9KTsGWfvLpE+B2Bfg81rFiS8sSulK/YVwmt2P6e/J53Hux9bUqlhy82nKcG9RE8EWXH/c1e27yoY68m7f4H7q9rl/ENp6tzUtp0SI8ZLFjLcX2YTjCwZY9Ubhs8DD4qkvQcYuh0yv6cw4/vz7FoUFiNquXS/kzlJxmDLOry8VgQK+TSeyKLp8o+7T65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a45TV2jAqfGQuwMcgHLXRJv2svbyEtQFxm/Pdvyxxco=;
 b=UYkwOLo+Ow3jjkcMyKs3tQEFr75j/Q8xv2syinPoIsePC3Wbwbkf+8Lilj8a+jpHc51ZvCHO3CEBNss++aEtZH8Goy7SWYP9fabbDt9rZrm4XKjggmoLKcthFlzwCGmfvsjtq9/PfLm8nVmBVbpRDKYev4ihfXMV5PLe1stePVqLVux7Bco+frzzyan80tM3zsbZH4ZH/AjiuHB6v/TC99WgUkEa2m5Jt3qBY79HPJXhX6xIeQ0zAUowFEEgTkd3se9gEJF9F572gW+XMQXh5V8jN+pcFX5zxwocQFEqiIFKaPdHmK8slYEGOxBMJhQslFrw4xGaJHfWfhqOt5Y9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a45TV2jAqfGQuwMcgHLXRJv2svbyEtQFxm/Pdvyxxco=;
 b=EIcys79uqs94Q4KdFoB92/iZfLfa2lAJyFLfUUN6WCfKHpR25iCmAVpXlPR0Y3AOUOjvtviXoplNfvSssKaOGomOD0Daopfq9Ws9mKCtVsoid1O/SNKlsFhUFolg1D6T0aESeROYLqckMYdnhADZF2DmJfLBbjXYaecJ+aK5Cvdjn7/1T+awgnz9kbTiUVWORwbAu8cmiw1TJuVFYqjq3GuZAKtDziGAs8h70ruwdyeGpv6f2yl7O+0IPHLZ7ce7GUvNqzru6KBQBO85LednMKTX6JWOJ4L89TTxaI/+5235kUraMoCls085QuURSb6oqVkkrJSyGtZx66GWB/+PRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DUYPR08MB11992.eurprd08.prod.outlook.com (2603:10a6:10:660::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 19:25:20 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 19:25:20 +0000
Message-ID: <33fba3a4-cebc-4f13-923a-31cb5753222b@virtuozzo.com>
Date: Tue, 23 Jun 2026 21:25:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio_balloon: quiesce balloon work before device
 shutdown
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Denis V. Lunev" <den@openvz.org>, mst@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260622133715.3707707-1-den@openvz.org>
 <20260622133715.3707707-3-den@openvz.org>
 <8b83f251-3a3e-4fc9-8ea9-8d101fb92919@kernel.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <8b83f251-3a3e-4fc9-8ea9-8d101fb92919@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0205.eurprd08.prod.outlook.com
 (2603:10a6:802:15::14) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DUYPR08MB11992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a380289-7e63-4a8c-b2bb-08ded15d29bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10070799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	IoIvphClQZdnXvllwSnvO34JnFrycWb78qC1Cy3hc4Yr5/iX3vIFihFJyNfCVIayXUpqT/OalMF6Syc152W1o5uxz3mxwXfFb9aBxhn8xLBlp+qFaX6fiDdDpfubgV1vxLjb7pQN1egmQG6YrB5IOnyczaImHUElGh0r/9L2oZQLKyQVplAPUxqi5AoMf6ji+yChE7s9Pkoku35c61OKLiFzXEhT+yOhyNZAUQ2BwZ69GARlXnr7lBPsJrGw84JPpAFQPstcCwKJDvV52As46YBWBECPs98gVQK1ZMon4PQIsIS6eLeUiF2XRM9BmP4q6NP0/EQQhu+APYjLxhdboH82lmuG066A5zPnebblmhr6JaosOEn1UhgwkTWW7Qq8FaVSR59WIw1vfJn2fsJtj3XCy3MoH47sHpmqsS+2mIfyPseNslTGXZ3j4e+p5o6PnRy89Hn/eSVyfVfRQLsiDh5VbP3XXpf0hBY2Y0E53QhHLKUmMpHmaKdznYYySzuvOyM6quDSh3VsEtyG5peNirnNKu4F2LrJz3fal9EnsIa2e43R5M4NUvQQ0HJ2oTlvJH6hYqFeSv43CC9uMuGrBLDXKQ5sBC3eLxT2Yoof8SJ5JZKlJPUid8z92v2xfYw6kGDPnQCrWq5XhA/uRWwnnycSQi6thJnv/1dOxDZYKno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5892.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZqVCs0SlBvM3JiWGMyUGxIRk40TFFLajQzVjZiaHpRTWdWK0xNazducnJV?=
 =?utf-8?B?NWI1VUZRTENWbXlFZ3cxV0J0RE9nM01tQ0dnbnBZSDB6OW5OU1BOSkw3cjhF?=
 =?utf-8?B?eXhDc3lNV1A0TnppVWloZFVVY1BKYUR6dFhELzh2UUZQY3VaaGVkbDZubUs0?=
 =?utf-8?B?a3ZyTTV4Y3dhbVdlNFJwOHF5eHVDWGc5MzRBRlNNN0pHZDI3UHZOUUsyMlFB?=
 =?utf-8?B?MjZ1WmJwUE9VcFB6S01sN2JsaHVET1cyeUdwVkZjeStXenVKdklUVVFHeTht?=
 =?utf-8?B?VWVNU2EvRzN4U0hDajNlYk5ScjBJVTZXNkFUSFo4enFDR1RnRXQ2WENMWmo2?=
 =?utf-8?B?RVBvRmtTN2IwWldTL0swUnZhV2ZqYVB3V3JlVkx0ejUyY0t0cks2Y29oWGhu?=
 =?utf-8?B?TjdpTVpvMkJGWTVMc2tIQUZldjFrOFp4QlprNFBYa0Z1OEVLOTlBRGpoQ3lV?=
 =?utf-8?B?cVhsSk1uTENiWWR6MnBXM0lVazVCSWtPVTlOWGdOaHRrbHBHSUVnRkFGclZa?=
 =?utf-8?B?UkhjUzNXTXpJRjNhOEJNYUJ0TWtIUGRoQWxacFg1ZUhvaE9uYzhmaEFLdGhJ?=
 =?utf-8?B?TVdYOHJQTTJmalE1eVcxK3FGYWhoRHFzWktqaEVDdS9UUXRNOUY3aU5DRkJ5?=
 =?utf-8?B?RWtNQk5ISU5PRTFjUVl2Z0lseSs2ME5GaitwSUxGYzRiMDUrOHdpUktPYnkr?=
 =?utf-8?B?WS9lNVBmekVFSkRIcTFMSE40cGtNT0t3Qkt3MXhER2V6T0RkYk1maWVPeVI2?=
 =?utf-8?B?WmZaWEVwUm82L0FQanZCZnl4Zm5Eam5iVlF1SHFZT20yWXBBRUR1L3g0bUhx?=
 =?utf-8?B?WGgySnJuMUxLN1VqcGhyTkxuaTZJM0ttZ1dKNzdlbDV6SWZZUHI4UTRuL1Uv?=
 =?utf-8?B?dWp2MmFTd3BRUk16V3NnTjRSalhTK205MlZ0RlBNNlIvV1pSWTg4WmQxdUsx?=
 =?utf-8?B?UTQwMXVrSlYrOUdSSHpLL1V2aG9SL1BwWFF0eHVOekNHeWVwSWVSRW9MNWlW?=
 =?utf-8?B?Q2NJdkgzZ1NtNVB4V1lRdW9lazJtYjdQR2Q2anlSNGJyWWVwNk9ZTFQza0Y1?=
 =?utf-8?B?cEJQU1U3T3Rmc0ZxWEovM1V2ZDl6dE5SVzlyY1c0eUlPcXZFMmMxK29DVENB?=
 =?utf-8?B?a3hlL1krOTNWQXJjSjdDZnI2RzIyN01zVkdwY1U5a3loeVVqc1pKNk5pSURW?=
 =?utf-8?B?azhJamQ2bCtEWmh4eXVtNzNwYkJHbThjVmFTaXhmdWtSQlRxV2c0bzJCTCtp?=
 =?utf-8?B?aEFQOHl1aWxEZkZsWGh5aHZwMm9vSFlVVThRY1RiVm9seEtNc0pvT1RPSG1U?=
 =?utf-8?B?WkNVSWZBMnlSS0xsMzFRSHZ1R1pyampWQVdjc25TRVl4MkZNRmZFcnIrMDJE?=
 =?utf-8?B?NWV6TDl0U0hKVnRKZFpCOWkvSkx0R1YrQlBqYktmdWdCZS9SMUlZaCs4U21Y?=
 =?utf-8?B?YkF2cVhRR0Z2UUhGVDJ2a2dncnBPcDkrQlJLYXJwYVl3K21vT21GTitEQnNS?=
 =?utf-8?B?dG5pYmdsdDN5UHBjVHc2UEVoM1hiMWt5OVRmb1I5bERVcXFSR0RhbEZuWEg1?=
 =?utf-8?B?VHRtWXp6cTk0Q0xWQ3VmZnRrWSthWUtlTE9CdHhGcUdXL0JhY3FOcjNkVWJm?=
 =?utf-8?B?NVVSWTBLRDd0ckV2c1hkL20wSXFlWFZLTUloTmhDWmJkMFFITzFZelZyeVVS?=
 =?utf-8?B?YlU1VkxvTEsxb0FkNXIxcmxNcVFha1FJS2hXdEVNMEI5ZUtUU2FyTmltZzF1?=
 =?utf-8?B?cktRRFNvYkFnOHZpYnREVHpqUndYTVpQMndLRmRjYzRvUHlMT2NLN3RnR2VK?=
 =?utf-8?B?WGdjVko4bXhsVlI3ajlPQU11UU5KeE9xUTlUeWdDVm5veVZKN1BuMDFNZ1ht?=
 =?utf-8?B?MzI1UC9rWTJhZTJpQ3lkQ3BqMGZiQTljd09PMUtIUHlWV1pHL012TUtJaDl2?=
 =?utf-8?B?RVQrcUtjMk0rSm1HR09lUnhVRVdTb1kwU3lJdEFHWlM1TTJiSUdjQmF6NHB2?=
 =?utf-8?B?cVdDWE9SSWt4bFA0b2EreFcvbm9oZzRZaHhkcGE3bzY3SU51UUtYZWVoVjY0?=
 =?utf-8?B?TGlDVzV6akprV0hVRlFtM0grazNKLytuUXZsZkloR3hNOGJwU0Q5bklvcG9z?=
 =?utf-8?B?ZytCdDVyNUJCVmIzSDJrUjRpZnp6QmJRWWk0ejJzVkl5cFBRdWY3aTM0YUpT?=
 =?utf-8?B?RjJJUHYySW53cExlc3pGWml6RVI1MDI0ZVg4QnNWa3hKZFVLR2gwNVl5OWpT?=
 =?utf-8?B?YTArSy9sSjExdWZWZGZJVHNvS1ljenBIT2J2TjIxODE3d2hZWjF3eXNEbXp0?=
 =?utf-8?B?bVhETnNxbUE1WWRhT0t4MXpBVENKWmxXRHJCcTR6akNMZG12Sng0K0pWZFZG?=
 =?utf-8?Q?0O4AJQcs/dn9Jhk1aDMnjcb1JzWQ3Qw1ByIZYE84UvJiK?=
X-MS-Exchange-AntiSpam-MessageData-1: +HKtGDd+bVw6KA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a380289-7e63-4a8c-b2bb-08ded15d29bd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 19:25:20.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yz6YKH8D9mceRQ0r9OnznKYL43adW4Vin0gACRhKW8KrAHAwDoP6FrC1Umn2e9ABk3ucNLmTu3CboA4X+Ha/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR08MB11992

On 6/22/26 16:38, David Hildenbrand (Arm) wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> On 6/22/26 15:37, Denis V. Lunev wrote:
>> Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
>> device_shutdown()") added a generic virtio bus .shutdown handler that
>> breaks and resets every virtio device during device_shutdown(), i.e. on
>> reboot and kexec.
>>
>> virtio_balloon provides no .shutdown of its own, so that generic path
>> runs while the balloon's asynchronous work is still armed. Once the
>> device has been broken, virtqueue_add_inbuf() in
>> virtballoon_free_page_report() returns -EIO and trips its
>> WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
>> ordinary reboot, for example a kexec based upgrade, into a fatal panic
>> in the middle of device_shutdown(), so the machine never reaches the
>> new kernel.
>>
>> Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
>> inflate/deflate and OOM paths do not warn, they call
>> wait_event(vb->acked, ...) and would instead block forever on a broken
>> queue that can no longer complete. The device has to be quiesced, not
>> just kept quiet.
> Ah, so
>
> 	/* We should always be able to add one buffer to an empty queue. */
> 	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
>
> is not actually correct.
>
> Yeah, quiescing sounds cleaner, although I am thinking whether we should also
> warn if virtqueue_add_outbuf() fails, similar to what we do in
> virtballoon_free_page_report().
Good catch, will do.,

>> Add a .shutdown handler that quiesces the balloon via the shared
>> virtballoon_quiesce() helper while the device is still alive, and only
>> then breaks and resets it. The break and reset are repeated here rather
>> than reused from virtio_dev_shutdown(): drv->shutdown replaces the
>> generic handler rather than augmenting it, so that drivers such as
>> virtio-gpu can opt out of the reset. Unlike virtballoon_remove() the
>> balloon workqueue is not destroyed, as shutdown does not free the
>> device and cancel_work_sync() together with stop_update already prevent
>> any further work from being queued.
>>
>> Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>  drivers/virtio/virtio_balloon.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 5b02d9191ac6..e35ada767b4b 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -1137,6 +1137,15 @@ static void virtballoon_remove(struct virtio_device *vdev)
>>  	kfree(vb);
>>  }
>>  
>> +static void virtballoon_shutdown(struct virtio_device *vdev)
>> +{
>> +	virtballoon_quiesce(vdev->priv);
>> +
>> +	virtio_break_device(vdev);
>> +	virtio_synchronize_cbs(vdev);
>> +	vdev->config->reset(vdev);
> I guess it would be good if we wouldn't have to copy what the default handler
> does, but could instead just have it in a reusable core function?
Ok. Sounds great. Will do.

Thanks for review,
    Den
