Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023142.outbound.protection.outlook.com [52.101.72.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154E44C656
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136450; cv=fail; b=bX37coBrlpqRejPmSufCZby5oCKFYwIh8HVewEsd46FboRwGcJPy69uwyR08/SGdztRgiylz7OC1orQfOgMHakuHtyJXjuSrn/G3LEaB0DT31qJOyZcjgluhj25ZSuyfOWVBOY8M4wYpsJ9SvruCoqZNZhZdlf8/sNaBVimQyq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136450; c=relaxed/simple;
	bh=UNmIimH+XIT4c83LbKJ5WCnWQXzRFtEQW/YO+e4yYRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o1UlajvuSoWQacNbfAG5GiZv3OKgqRlZqxgWS5gMhCt9wIbmB0IWfoXxX1GouDaaTbUNryH/74xedO4e438HOJCdYUL7i2N2dZ4mDtZzKe+55bS9NKadv7RCEleChPxJDz5ly/2U/NMAgDNpapPWeCmPZYpJbtDu9VSVpEVP8oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=tCyLcjf/; arc=fail smtp.client-ip=52.101.72.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tCyLcjf/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6YrwUDdeldoH+9EXrtRYrcR999GUo7uQY6StJD7x++Bg3mHS0G0sVo7aSGQZmn5Y7ZaN5bKh8MlwrLUtFtK56RPowm+NwrYP51RXHLQYhENBXDdfNHf2OGYJ70RBNuYXlYtN9spFSTWEUc0MjlIyoWP3Mk/ZYQXWrCCfTIFHPtgp+CwA7+4jovm0No4M8A5fPT+lUDP2qa/rRtytNomMvKLlZn/JJHveC7XkmMHS6tqiT9W9yKQqoEytc/gxX+89zbvpl4uepfjAK3CzaVI8nc0F+WtTbPMFVr2mYlNC+g8NANZWrifxaB0zRmJIfC/dDLPbo525S7raUHn8fP0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=espZVcROnoHlq4WzXXqlOdpYL/fHnK+kt59SMgO52DQ=;
 b=BQjl2WboioFOPkdeXVfGQ/bS8zQVGQg25ZuPL/Zs9tP2upUulQqVXlq61qO/KL33Q8PXqcoBxAZ/2fjO9cTK5SwjF5ojgWhidi/uhIJUUpInfAXGkME7LrYRPSRwkvlPKJSAPNOv2eDvEiarJaCeSrqRf6j4d1iZYThRwKiOj1uSh8Wc1f93HcOzuOfHfR+N/NpzFio3Arc6pVVEEmQ1Pr0djHu9Jzb+yM6fWHXbOv3oHvyDfXodwx6Cql1FkgWpp/nXNhuJVXuhhn81gcyoLbaf9pE8YjIq9FtwWzXv6SgTbA7UisyesCr66qpivERPUqltn72PnhNBU3McTpo6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=espZVcROnoHlq4WzXXqlOdpYL/fHnK+kt59SMgO52DQ=;
 b=tCyLcjf/uk3COBPMinu5CXepFF1TgYajtq+WcF9jJdHjmXFl4n6QqA0jbOrB9mnZDyMmb5UGUOF0VUMU0x5FOyZ66zDCTuzqdd7D+BY0gcLjdYM1zjYDzev9hHKzxcxSojvuSWC0aat/1I069nbaSi98xGtdoHV+G+X+uDeUPdYvQYtD+FGoik5j1YkKZnjr5mYePJT2++1h8otkQZsuLaQ/xOpQsfdGb6gHo2c58EJWC5EHtyj35FYcRTMlWJf/b7xEg9rkYh9BY8/LYtmF8M8tznOi+iecWBLh9L12MPjrBs+SdkGcRCisMvdFLqtLdAaPjnkfizhksWzGcv8I6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by MI9PR08MB999879.eurprd08.prod.outlook.com (2603:10a6:290:ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:47:25 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 10:47:25 +0000
Message-ID: <4266010b-9581-4e0d-abb5-97084c31e546@virtuozzo.com>
Date: Wed, 19 Aug 2026 13:47:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing
 workers
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, jasowangio@gmail.com, eperezma@redhat.com
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
 <anSMBpQJ8x-vXYy2@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <anSMBpQJ8x-vXYy2@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|MI9PR08MB999879:EE_
X-MS-Office365-Filtering-Correlation-Id: 49806322-614b-4b58-66f1-08defddf4169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ua4JlU9Zb3aOZGWl/skUOpQP/7pW2+X3WB16TlKyXkm6SmcC3ZSbEha3ODL7YFAC+Rb6fBGBQgA07gM8otyr4z81H2Mc5cg04WG6zggRiqjchaTzDsgDsEApAcTkGE/iR6fWjP1R0xZb7hedSYzLVNAkVRto/FWc11Wtu+y3EBxsjEQF5W2WGBF1//3VQYrXZGXA0UUewaBtJyBWARj0BLuMipAw6cZRUhav1yrI5un8B5GqsRecKeYbdkkx5ggfb6O83Q79HedGWpY/BLubZ0qZDIrz2x90NsSdw4p569x32TCKRsnHJzq2Dmuvi9yKKRFo77WWaoNBuqCcGEh0qphQqNWPu1xkg8D4RRmMxjrGhRjwXwYeBimw2uEUceJQWha8KOhciXmFHQfGUD5BTHBtjQQIBbtf8l2NV6ecuJqO7Y8gJgCKalZOkc6Blr3Lb9JTPlQURexQRIUsFQXIj2nvateF6+sCWKP6qAsRiareHUIdjB+5g9GIy5FOcOxSuBEb5IhZmWInjsiWZj/4be0giclAbnRouLBhCb6aA/kDvHmkUYL2IAr0P5sJ1kXa7SqcaSgYSmAUzE8OBeODHRbrv8mLB91cA4/H9dSSYkGCTDvcmvA26QgCvoHAdh1w7n3c/uGi9GkZB5XTVFLu1D5kk7YC99KsVAoNzknALNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB10650.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUNyeWlkeW8xNVI3VjlaVEhHKy9rQzBkRmowUExoL1JyMHVsbnBMcEVCN0NL?=
 =?utf-8?B?NW1kQ1ZHam55cTA3OHVSNjVpK1JCMDg3U1p3OXpMeEdUZlVyT1hKRHNIVm5M?=
 =?utf-8?B?dEI1bXFpakhSQTlpdHFabTBtbWtqbHUrYVFmQS9jR1hNbFVwd1AvRFlkVk9S?=
 =?utf-8?B?Rmp2RWViOWFYb3Q3aDl5Uk5TWk5GOVZrM1ViekJPMlU3a3pvQWpJV2l4b3Ni?=
 =?utf-8?B?cGFCSlo4Q1N4UUVJN1BuSWxiM3Vnb2htQkoxZkNhT0Vyd013R1pYZXA1YUdL?=
 =?utf-8?B?QnVna0NwRDgwWG1jVy9yWVZnOWtzUDVkTTJOeXd2WXBjVHlFVFpxSElheC9O?=
 =?utf-8?B?RjJjeDFISkdDZkJPbjZqRy9qSzY3ZnJRMEMzS1lLcHVBN2ROaitNcjViU0VN?=
 =?utf-8?B?ekVZUkZUL0VTZ2pZM0RFVHZvZFZ0YWx0RzR0MEtxaVRlRTZBbW8xZWVCVENW?=
 =?utf-8?B?TGVtWk4vUlA3NmxIU2VOTWZVUTF4UHVyTXNwZ2dmZFVEcmtGMzhHL3d5QmhO?=
 =?utf-8?B?MWlIVUNhQWhiVHlrZjdjdUNkakcvMzdLMVd3QVhkdHBzTVA0M3hHa3dYbzFH?=
 =?utf-8?B?ejVWd2lHQnpFTkYyTlg5aXJxWVhxVXk3dTdwanhTeUZXK25UU2FlRlk2UFFP?=
 =?utf-8?B?azhlZklzWTJzRlBBM3AxTEdqT01HdVF2d09kOWxWWThBRzA5cHNTZXFJeEY5?=
 =?utf-8?B?Vlhaa2d1TFlZYy8ySE1RUWpBMFVySjVSVGQ3TGFoekRSRkx4ZklKWGRRdm9Z?=
 =?utf-8?B?MVhmbWxJa1RNb1NpY0UvOWVlRXlpMGVrYjZTaHh4djdXWUc2aUpXVjF2Ym5x?=
 =?utf-8?B?MTZvNDdrSVZTSmRqVkV2YUs4cGUvMGVUdURzYm15c3d6Z3RrYXVNNEEwcTRO?=
 =?utf-8?B?QS80YmpYK2FLTnE2Si93d3lwZjVrZXg1YUF3YThmTTQ3QWNrdFNkODlvUzRt?=
 =?utf-8?B?MW54ZzNIVktFYnNOYWZvdTcvR2FteU5MK3p3czEyQk1OTnRyNlpWeVAxdm1t?=
 =?utf-8?B?YmhEMkVkV29ucFNWSWlkMk1mZFJ6ek1SVDlTUnFRbndvWG0vM1VhRSsyaHRt?=
 =?utf-8?B?L2xVOTM1SkV5YysxM2NWUUxqSjhncEpxME5USnhWbkFkWjNtNmFGUnJncjZ4?=
 =?utf-8?B?Qlo5Uk1jeTdmOXc4aHp1Q2k3NE1UekZSd25VVG9UT0Q1OEUzanhwSC8ybk43?=
 =?utf-8?B?Nkdtb1U0aEJHcE1mazQwdG9VVENBS0M1bVpWc1AvZlMwTEVDYzBaOWxseDZ0?=
 =?utf-8?B?Z0NrS1dZd1ZoN3lyWWQvWmh0cW5Hbzh3YW12UlJsN3piMnZqUmJJOUpKdzgx?=
 =?utf-8?B?Zm02YkdQZy9mWEZYcnlOcm9TOFRZUTBSV01YN1hvMWVEd1V5NEZTbVg0M2Yr?=
 =?utf-8?B?VENuNEw4aGZrc3l6a0wrWm4zcVVROU5rRUp5dkhKam9EUE9lK3ZDSmYyYkZk?=
 =?utf-8?B?UXRxaU5pZEVuSXRGYTVJR3htcUhmR0wyOTc0dXZuTC9yYWhGWHhhK3paMGxH?=
 =?utf-8?B?eFZVTHpXdlhvdzhENzZHZDhuTzBiVzlXZXJLWnNmTjY4RFlQUzBjVFdGKy9n?=
 =?utf-8?B?VUR2MWdZZmp4Y25yTlVrSEwyeityWGRmU09QSXo1MHg5bUJUS3NoUGRFRjB6?=
 =?utf-8?B?VTA4bVZsTVBwQmZVbVFkdWt1V0IwQWhNR2RFRitVSXdDRGJMRldEdkVwWGUy?=
 =?utf-8?B?NXg4R0tPUm9qR2NlWTVDdkFmOU9qQzRUcGZsLzVMYmdPVGJMemtPTEdwTGls?=
 =?utf-8?B?QnNPdDFFcTZBMjBSWGZIMmxHQUI5bXF5Y3NKbFRwYzdFeGdTUmZHaERmc2lH?=
 =?utf-8?B?N1FsanlNa0lPcHgrUThiZE1QSHhuL0lEVnJBQ3JBL1hrcTRkSmFWV1ZlWGk2?=
 =?utf-8?B?LzlqbkpUVUpHQ25HZmFjVUZ0c3VLaXdCS3VYamMvdDBFNmgwU1pEYWNKNkt6?=
 =?utf-8?B?eEVpNnlaenBTWW54Ylc4U01IKzRyemx4L2VKeGY1UkNISCsrNC9HUjl0bUE2?=
 =?utf-8?B?MndWZG5PV2dXdWRVT0NYQkZ5NkhKZnJ3VEtzdFlaTTJuR29xUUFiaVlheVRW?=
 =?utf-8?B?Q2dwU3NGZUJDZlVSYTQ4WjFWanJTQ2J1aytJL2tOcG5LaTZqR1NtdkNnZU8v?=
 =?utf-8?B?WWVNRVZRY0N3OHFKbU1YVk4wK1doTytBVmpoNkUvc1BkSEVmQkhGY2UxN3dB?=
 =?utf-8?B?TnJCcHllcWZhR1JleGFaSUtBRFFvcFVEbEVNWHFsc1Y1UmJrZ1lhaXdFYnNs?=
 =?utf-8?B?VFVtNTVNelhKSU45SkFicnNzczRlR3VaQVRPVlI2VjV2NzdJN0gybkxlbmRh?=
 =?utf-8?B?NUpURnhNWnk5cmV5eDB0alVrekRlejM3Y0J4NG1yZHg0c2h0cTlSNFFTTXg4?=
 =?utf-8?Q?ZGjwp1Tw+cq1p0kM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49806322-614b-4b58-66f1-08defddf4169
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:47:25.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrN956n3mglPTHa/8Nao0HtidJAYWfNGfog7ZaiF0OrDFnCHm5k01gkYFDU8JVDaZagp4bqW0OHbQpnqD7UNcJ5+OaJKh1MbEHaqEqZqkkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB999879

Hello Stefano!

Sorry for the delay on this one.

On 8/6/26 4:35 PM, Stefano Garzarella wrote:
> On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
>> Every other update of vq->worker is done under vq->mutex - the worker
>> attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
>> the sole exception: it clears vq->worker without holding the lock.
> 
> mmm, vhost_dev_cleanup() updates vq->worker without the mutex too IIUC.
> 
>>
>> The effect is harmless in practice, as this only happens while the
>> owning process (and thus the whole device) is dying, but the lockless
>> write is inconsistent with the rest of the code.  Clear vq->worker under
>> vq->mutex, like everyone else, so that all writers of vq->worker follow
>> the same locking rule.
>>
>> This issue was found by Sashiko AI review.
> 
> Can you share a link to the review?
> 
> I don't know if it's common or not, but having the link in the commit or 
> after --- will help the reviewers.
>

Sure, will add the link.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> drivers/vhost/vhost.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 4c525b3e16ea..dbb6cb5eccea 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
>> static void vhost_workers_free(struct vhost_dev *dev)
>> {
>> 	struct vhost_worker *worker;
>> +	struct vhost_virtqueue *vq;
>> 	unsigned long i;
>>
>> 	if (!dev->use_worker)
>> 		return;
>>
>> -	for (i = 0; i < dev->nvqs; i++)
>> -		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>> +	for (i = 0; i < dev->nvqs; i++) {
>> +		vq = dev->vqs[i];
>> +
>> +		mutex_lock(&vq->mutex);
>> +		rcu_assign_pointer(vq->worker, NULL);
>> +		mutex_unlock(&vq->mutex);
>> +	}
> 
> Pre-existing, but IIUC vhost_workers_free() is called only by 
> vhost_dev_cleanup() at the bottom, after a loop calls vhost_vq_reset() 
> on each virtqueue (without the mutex) where we already set `vq->worker` 
> to NULL, so IMO at this point it's already NULL, no?
>

You and Sashiko are right, thanks for pointing out.  Previous workers'
update in vhost_vq_reset() makes both our update and our locking
redundant.  I think we should just leave only one of those functions
updating workers.

I suggest we leave vhost_workers_free() as-is (this patch), while
dropping rcu_assign_pointer() from vhost_vq_reset().  Two issues with that:

1. vhost_vq_reset() is also called from vhost_dev_init(), as an
initializer.  But we can simply add workers' initialization to
vhost_dev_init().
2. In vhost_dev_cleanup(), we'd have had workers already nullified
between vhost_vq_reset() and vhost_workers_free() calls.  After
suggested fix - not anymore.  So that's a behaviour change.  But I don't
see anybody else touching workers before vhost_workers_free() on cleanup
path, so AFAICT it looks safe.

Another note: I initially based this patch on master branch, which is
wrong as it doesn't cleanly apply on top of our previously merged vsock
patches.  I'll on Michael's mst/linux-next tree and send v2.

Thanks,
Andrey
> Thanks,
> Stefano
> 
>> 	/*
>> 	 * Free the default worker we created and cleanup workers userspace
>> 	 * created but couldn't clean up (it forgot or crashed).
>> -- 
>> 2.47.1
>>
> 

