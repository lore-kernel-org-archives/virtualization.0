Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023079.outbound.protection.outlook.com [40.107.159.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF33D905F
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313245; cv=fail; b=kXxeqUNEFCPVi6bcwOeHqUqU5bdEnrUaj/W7aBT0iATOI2gZQCxt9jC2263fiMS0bcZgpyjT0k1ZyWeZaZLavPn4DyAQHevD3ri4hq5Fe8SUl14BKAjhH0BHHLI7EaAJuvzO8A5XBn4aNYQ0sDleh0czS7jm124AxAo0NCkesog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313245; c=relaxed/simple;
	bh=qaqkxy4LAyPBUY3S867o0yJe+xEwfp2YTNi6z1vWr0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sXafPu3UqoIZnkjcLllWGtCjwGGN6+2z4fgcxo5YS4bQacve0rcO9tbEwwklsneKU5T0LjiQKf0lbGoHu5YJ7YljFVg9m1r0Pjkl2eC6mEtvlq7cRLATDtAzSuFMnDBJ9/R8I9H4AS4rP+nI5xwPNrpjJigdyr6Z7UEJsqEhijw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=EHXjnWpL; arc=fail smtp.client-ip=40.107.159.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EHXjnWpL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqteESS8onD5sO6Dz8/rCPt+daCSsxsxGerIyULTz3eTJ6KBy/rkCkCCYXOU8aL0endZifshd7ZboBc0V+Auyznl/ciFRsiZmn16L0uZR6O6F4TLgefyL4TZyj5jtT7D/VMD4cGcYa97klqj/aXJw8x9GQTQmGh7nj0p73o9UhIAQJloLNDIfwZi9GBc+BFKu+tJB5giaCw4B5T3Kev3sjywPOroHK/rCOptfDUH/NBEyuYa6jl6sHkRwO6pap9cSgGETBMYQSMPuz16rEDZJ88Jv0N+2e3DxSH5tHhD8wojvZgLhZ3MzGbxwiNB30wZFAHGfXX89YyHqR8mMJ/gBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovvbfawuv9efts4UCsznIorS9JjTWBf6dMgD8nuseSQ=;
 b=mVHBwqCCd+k7+JoeP7OUDxvfHd6H6flY29QpwHcpGcC3MxbRnjB3zbbCPb4ddyDcwgREMu+YaMx0MknreU5iE713DyqSLWoPOuyqjL8O2hjQFGu3JmUTqlegsCZCajhI8iSr3ubrzGKOXxXlAbe6jzyqjkbqAXc2+5yAIjctIf1HGbAFS9BiWDatnZsGMFH+Hhprg+ffTgMmxj8Sly12meJ9rYWeaLpULaVLsPwlWr0FWusb1sg26DssfjkuQjNdgCkbYjbOEJtTU3j4u4CsDfUSpMytH403UhAV2a/aNK7yItOeY/zG80U7qyIzsKSZ3HEus9ryN+EejcyjAks2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovvbfawuv9efts4UCsznIorS9JjTWBf6dMgD8nuseSQ=;
 b=EHXjnWpLfnpLEWtJSWQiWeDt/5xd/7E0EGYnGC/f8rlglcGty71ot/pdMgTOPxksrhb0G41WKYSAc3m/+wbl2izzhR7xTRm/1XZwNDHoFPwulIoAezTM33OJ2BNYU6ZCZZCPdTR2b74XBeKhl5eNTGZSSqC2x8jIHwGkjAvzlqY0kEzfp1WawMlN/ia4hA+ERxoMKH7jYuXn5VkV7dg62uqKGvCWzAdz39Cm6iK9RoTfwFBYqJhEYWE4WgJldw4zGQo5oZ/Z6gY+RR6/eOlcclHe7GV0hsT3LdM10GSiCtp8xq1Go1K8ESQTso2lODM42WH1yBOXwvNA3N8uoeDS4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB10003.eurprd08.prod.outlook.com (2603:10a6:20b:63a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 15:00:36 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0139.009; Wed, 24 Jun 2026
 15:00:35 +0000
Message-ID: <17b01bf9-13d2-4e61-a11a-0b91db2f2731@virtuozzo.com>
Date: Wed, 24 Jun 2026 17:00:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] virtio_balloon: quiesce balloon work before device
 shutdown
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Denis V. Lunev" <den@openvz.org>, mst@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260624140846.2616797-1-den@openvz.org>
 <20260624140846.2616797-4-den@openvz.org>
 <a1d78845-22e5-42ba-9a9e-ae22529969fc@kernel.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <a1d78845-22e5-42ba-9a9e-ae22529969fc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:803:50::15) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB10003:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b54a42e-a20d-415c-bfdc-08ded2015873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|1800799024|376014|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ycBeVKnhUAzZ5lRj3e+ILQZ1LOG/RbD2/sPzuCE0l7id6Pb1Nq05yPTWSb214Vuv9AEx2S3d1JEoNOUwF0OeNG/rkn4SN/YFMWlhEYP2x9L6RN8+0im5ZXtwCRDVacbF9lcjLlqIoozj9FKwNCXiZxvn1H0gIYzLXWvWF94ZeYDjLBrpI1pPMrQ2kRQms6iJ6/biJ+o37Yp4bP6QfXsChhZCLqCDwQLUL/i4Jajwa8YmVG2GYMWCX6HUJf49cy8UKK5E2uXJ9Y/y/8UaKX/Xa4m5+ok45eU59SEeNds384NoWPbu+se8Mw4czPxfh5rMrseZwClSuX0k8dpvw2H1vzWDoU/M32py5pzgi1syFt+eqhOg8gqTS39GRApBhjIAGlO4oOj2WMtcZetx3cGTKlutTuq21qqsuGMY30H7yBrGac/2rzSDCYLKFY8RfptYfw2ZRG5tlOXfPlU5rZZvI2xESm15MhBcgnozIPGd4BdvH7Lrn0vNJjQdD57r9B7vSSYN6wU8eGlEPjqj+n0dsTZGFRRhWmx7N6rNRy9TqusvKtARB4c8Y6ZSBWUMM/CnczEzlIvLhA5/Bct6lLCCpzBykmwpue4+3ARwQQNYA/R4tSzXEl3KeRRefD8gn0z4YEn2d4kDNdw8WdZrhSRG94+erTGzT3jTcIS5jxyt7+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5892.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXczNm14ZS9ob2NpY1RNSXFMV2h5bk1GcEdLOE5pSjlaeHFqMUpKZ3c5VndQ?=
 =?utf-8?B?YS9MUkxKU2NRbjJYUFpCa05sdnViR3A0c20rUW1rMWVOTE5mV291UlpXdzBH?=
 =?utf-8?B?K2xGVWtMckF4Qm1INGxTWFFLM28wYmh5UFlaK3I5RmlIL1pNODJDd3BjSEFl?=
 =?utf-8?B?VnJHMlEvdDZ0d3pVTUkxTFB1NU9BeWcxVUMreGFqc3BMRFd1RmJsZDJEcGYv?=
 =?utf-8?B?MXVmMlFvUUhxVVJyN3gzOFY2eHE3Z09ZdytqSEVmQnN6a0FWL3Zqell3c0ly?=
 =?utf-8?B?Qkgrb0FVQ0tBV3hpZFVqSWc0R3JudXUwTWNrdnY2Vnk1T1pMM09iWm9JRzhR?=
 =?utf-8?B?Zlh2cDNVVkgxZ0oxcjVvSTExQ2l2eXQ2ZXV1MVlxTkhaWGU1N0ExZlo3VzBC?=
 =?utf-8?B?eWx0Tk15K3pQZVd5eHZkREJnWDM4bTBKYmxocTJTMExueW9LQjZ6Y3Bnc0x1?=
 =?utf-8?B?Ym9rNXFzYnNhQ0hNM0Vlaksxa3hIMkIxbUFTM2p2VFBrYkIvZ1JCbXk4c2lJ?=
 =?utf-8?B?ZUlRSzcya1pWRkVOQVYrbkdsbHEvT3ZTRDlJeGU0YldESWJjY09weC9vblV3?=
 =?utf-8?B?VU5aalBWb0UxOTJkRWNNZHowSXVBdEV6bnE1R1FDc2kwSExVSStadGRFMzZH?=
 =?utf-8?B?SHNSNnhIZnNxZTd2QkJzRkk5U25TQWpkc0FSRFZid3hMQmlpbnlUS0ZhVEp3?=
 =?utf-8?B?L3ZrTlp2OHlTaG5oWWo2OGYySHJGL2Q1cE83TlpqNkZCUVYzZ3JuZFZodys3?=
 =?utf-8?B?b1FDWG9OSm9EREVweFNnTlhTNDR6K1lOZ1V5WlNVcHJ2OUFvMmJTUldLbDNm?=
 =?utf-8?B?SGVSREZIZU1nNmhFM0VpRlZlNXNVUlp0bWNpZTByVGFNQXhXODlEeU1hKzN5?=
 =?utf-8?B?WCt5RGpHL1MyYUVNWFQ1cFhkM3Mvais5YjJJUE54eGN0NlpYT2V1bG5qaGVj?=
 =?utf-8?B?YzNlR25xaEE0UkhJNFNlRnM4V0pqeUZEZHo5QlNtZDI4UjQzOU9NdFpPaFpD?=
 =?utf-8?B?cnh1MnUrbXFOZXB1bDlLMDlLZkVTeWRJUVhQd0ltM0loclhBVng3cFFqSEdJ?=
 =?utf-8?B?eHlqOGJURlFGeVZDeENONHZHN2FTUiszSmxJRjVLdHMwQ3J4OFJGVzg3L0hx?=
 =?utf-8?B?QkxRSnkxaEJ1Q3RSY3pGK3RQRXV0U3dTSEhNUmdIQ0pDNG1oNFM3bGlncy9N?=
 =?utf-8?B?M3NSYlV0VEN1RzRYOHNFc1RqWmg1UXpmWTIraGFxd0VXVU5FZExnendEMFR4?=
 =?utf-8?B?blBzTlNxbEh5eENPanhkZEEyTGNHMXZONS9Ma3RnOUdJYWRuOWNpUDRRVE9i?=
 =?utf-8?B?UkV1YWdoeldXSUlaZllyWTdPNkxWVTdSc3dScE01cTZ0Y2dSak84QzBGNWZq?=
 =?utf-8?B?aGNnYXc4YzBUL1hqM3FFYlROak5pRURuc1RuNEVRaHdSVExQa3dURy94WXUw?=
 =?utf-8?B?Q3hQL0ZhMkJFMFlTenBuaGtPVjFyZ0U4b0lwY2d4ZW5CUldVR3pjRTJLL2du?=
 =?utf-8?B?eGluQjJvS3EreFZoaDZCWEIrOWUxMzJuNDU5MlBvQ2lZeE1zenJHYXdhaG1J?=
 =?utf-8?B?UEl3NnFPVkVJTExreWM5V1ExT05HSmtBYy9HVDFkNm13aDZwNW1QM2VjV2FC?=
 =?utf-8?B?MGoyWWJuZE9EcVh5aFV3MDhDYk5vbFVJdjFlQzNiU1E3bDRYRjhEV201a20v?=
 =?utf-8?B?MmJRZVRNeWhJcjRPY0x6RlVsZk9VcVNMRC81c1Jnd08wSmtiK043NGtZMXBs?=
 =?utf-8?B?dmcyU1FXNEdIWWsxQ2twR2JjeFFHS0Q4MElsNzNOQ1A4KzlRSVo2aEJDK216?=
 =?utf-8?B?MUxnQUlGMGl1R3E3anJ3VTFwQzlEZTZuZml3MkVHbDZPMWcyM3d2VG5wMTE1?=
 =?utf-8?B?ZkViNHFIbUxDbEZCUjZRUVFYK0dIME5SUkp3Q0hINEZld1IvcnAxMk9MeTNw?=
 =?utf-8?B?T0UyaGlFemdDNjF5R1FrOVpLVDRBV3hxRnZSWnZrYjZzMVFyVFFMZUhYcDF3?=
 =?utf-8?B?RUdYZmtSMVE0azZKQllLMnd5RWF1MTZRQWt3SzVVem04bHBqMjNjbHZZT0tZ?=
 =?utf-8?B?aUh5K3JNK2F3U3RuRUtVUzBPUDRJLzh0Sk4rdW9FQnBFNTFueEpCOE4yVXk4?=
 =?utf-8?B?Tmo2QTkrR3RETHdPU1AxbjNqekt6dE9uV3R3dXUzdUV2TjVYQ3FvbVg3Q0Zj?=
 =?utf-8?B?cTl2L2FiUmZxWmVPVWwyWWwyY2pyNitXcDc4TURsUnAydjNERE0zSW5sY0Jx?=
 =?utf-8?B?d2lycldaL0dEanJyUWFvSTJ1NmZzWlBnNlZsbGNTUHVCcWJjRDdpS2pJVUg4?=
 =?utf-8?B?YjFwVWFMU21ncnJ1NHlxbTNKTlZISDVaQXd4UmxmRktIOThDcEwxRDBtUXdK?=
 =?utf-8?Q?93i+spONZW7YLCp7zpKulEj5p1N+Y6XH66AgfXeaDHZqi?=
X-MS-Exchange-AntiSpam-MessageData-1: 45PMGg9NCM98aQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b54a42e-a20d-415c-bfdc-08ded2015873
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:00:35.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuQm8PuTM5DN+iF/krkKYgisNFJ301MdVR38g2nebvZe4I8ebfFqfvKiNKaxOHSN19P5Vm4n/hVH+cowpTqzkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10003

On 6/24/26 16:55, David Hildenbrand (Arm) wrote:
> On 6/24/26 16:08, Denis V. Lunev wrote:
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
>>
>> Add a .shutdown handler that quiesces the balloon via the shared
>> virtballoon_quiesce() helper while the device is still alive, and only
>> then breaks and resets it via virtio_device_shutdown(). Unlike
>> virtballoon_remove() the balloon workqueue is not destroyed, as shutdown
>> does not free the device and cancel_work_sync() together with stop_update
>> already prevent any further work from being queued.
>>
>> Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>  drivers/virtio/virtio_balloon.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 5b02d9191ac6..26fc3c40d5b2 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -1137,6 +1137,12 @@ static void virtballoon_remove(struct virtio_device *vdev)
>>  	kfree(vb);
>>  }
>>  
>> +static void virtballoon_shutdown(struct virtio_device *vdev)
>> +{
>> +	virtballoon_quiesce(vdev->priv);
>> +	virtio_device_shutdown(vdev);
>> +}
> I'm curious why virtio_gpu_shutdown() doesn't need that (did not look into the
> details).
>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
>
I would spend more time with other drivers once we will
done with this. I have strong candidate - virtio-mem.

Den
