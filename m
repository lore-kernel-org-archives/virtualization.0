Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023084.outbound.protection.outlook.com [52.101.72.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCF486B8E
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827051; cv=fail; b=YVWJBlIPJn2CBvNqaW+S4xgXazDbbjzvpOkyhf++q89YFxTtuNC0zZC2s75CNhVf0T2ZGUsp4AtP1gvAJ6IOWQrWP0zuj6QFm5cL2kQRgJ4SijvHO5qkZ8ACNi2v849xq5Kiz5Z/AVp4j+5tsA2ye2ZPgPi6idQ4tvyZN/2hRCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827051; c=relaxed/simple;
	bh=R52vt49SM0lAR2+iE2+RguLJvcVojGNTU5cbK7MjDb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Upem/h/xE2hqbCEIqujpwU5wIISavOFuxX9PO/v59CgYBFW/Bp7l6tWjtbuHvXGn8Ji5lTpFM9+zxOCVX8HLeAq7fQPtOvxt3Gvq1yP34g8uy6eueTut4XT7Ojxu+DwvhPg3+aYgTDZqmXo7BY7E6LlqHa/EvoyiNK0LIQESOw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=X0+NaVxW; arc=fail smtp.client-ip=52.101.72.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X0+NaVxW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rt1VOuqmp8E/TY/uFobqPwDx+7xQkhRQ+15+SLr5NksHHtUzlSMmhXTKu2d49/EnOZ9fMa+dzb9wNP4rWL43teoFRPtRpMIe4esjbJlEguEe7nI/Ol+PiIh93MN68tSJ5hFK8Mtkutw/RHCU7JzfIX+VAjR/3kL/5ofDGll2rhDzcwji1zk7gsJN/dTivNowyWMOr6HwmmMbWjLLfPx6LgKq6zvQIdhOQ539OE8X3/xP9WXOOUxD8+8ZQVRrJO08nZ28hsvyp3rqEjG9RX62CABPNZYp1kVObZy5uDiy9tuPFEfmVBMeuab8enAYsUGxKcahklCMyxDY8oVxE6GpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jfA84R4ekF6sH9S3Dqm6RnMeaeqT4vB3sTbDbTdQyI=;
 b=FvkqkHg2GyWyZe3DqlYPWKxKfn4qN6DOQPdevZWmnhnn3QyQdN1uEpRhR+cpiOC5+DhoTjhTaU3fuAuQkgC/8hngyZZg0CtyIl3ut16IySRxQEMgXsE+34G+Xied5naXGZ/dl8KTmkM+l4b7oUQKY5T5e4mZVgpmQZ6C4awrDmL4jUlF2yijeKDxsz5k9XpN7hudzIeOnAU7dor0aDsUmOgR5WGLs3sQqGcLsDHmy5QOo4TjOqcMGr//anOAjlWHSVxJP7MuT6qst9Z/SF6oKoiRm50CCmm7govJBYcrcWKgBzhiy6MWfMRhlh5lna5ZmcAfelGRU0euniPLE99LtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jfA84R4ekF6sH9S3Dqm6RnMeaeqT4vB3sTbDbTdQyI=;
 b=X0+NaVxWFKmmEaF6vXsOkTRdPDmCnsMQK7H6GqmZknDHM1XuFAqZUpIAR/yY69MpX8KNDJmrpIyRvqELXLMJIATFXdZ8kcctULOaCrXHbQN0BYtB6xfP4gJkLWwtxi8z9VaNc5bYHn9KqUk/bjDfO3w1J5yyZ74UZiEeAtkKlO9E9mH5oRZpcAv9+pfAA9BaucJKHefC2tuqA7d7uQlz1LE0cPzQMr6EB9on1zmKSVR7monw0ykOmQGg0c04w6T1UfPUp8sGcgHdwnD2rMlJ2r9dl6O/oJQi90iveKLQU9vXkc91tUFoNimli4li3Yo/zHbWo53+yZi7+d52J4GifQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAVPR08MB8942.eurprd08.prod.outlook.com
 (2603:10a6:102:320::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 17:17:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 17:17:23 +0000
Message-ID: <b324f558-e46a-47e5-b75c-b66938379c2f@virtuozzo.com>
Date: Thu, 23 Jul 2026 20:17:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, sgarzare@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, ptikhomirov@virtuozzo.com,
 den@openvz.org
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <20260723111557-mutt-send-email-mst@kernel.org>
 <0c7172c4-0dc4-4d7e-9310-4f045e27efb9@virtuozzo.com>
 <20260723124908-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260723124908-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAVPR08MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 4052b760-50b7-4420-8fb6-08dee8de4285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gYgNlL+fhZNbS8qtfhvmvf2zamIFqE+O4tRE62ajQlDKZ1iIdx9YnxLKeak2Cqmu4FSyC4h1rq6IA07ILa2ehaOlpNu8+RVdOiWGb1yyFI0T27YElSFq31dY47QgID7Gnw3gwDXT7m93CcTi8L5I6tobG/R3cfhSRVtz3iSjmebQM55GGAy+J9anDbx29OEnrfV6F5NKxxh3nOl2ZSZtLp28LB56pv224vYXYI0WzRrIUKZZKmpZJJON2Y6nBwB+X0qo62TZjH0WnngUHpqOV6yP2zMHjhg6I08XivnIln0BTtd9wqwT+mPIsomIFY6KB2kcVhpa698JVmCZTpliGvaeU2UQcFBvhgL+/WZvkst+REUIH77HMB2dUcz/EfFjkXOPMwbr0Jxr46+wS0nxrx7WA6BkpLkdL5JSzgDQi9+Ujn72at/gG9Yd5cKWm5GgK9krA1LqcKmNK+fyppaqYpWlyW2YOkqql/oq53VLVw/QoB4WRRIjSeV0mOhOy+dZciH+3JDmiKGKksOcrdWBZIy3yv30TCMNJ5QVQz7Og8xN+3TBYW4s58U9HteyG244x4HkYNWH0eOMfAU+6j7RmviqVIDgiCfIVoLxLzGIOcD33+RxhN8tCXAUuOpiFAJF5vDcLMPOspI3xzvZBcVLIvEkkkB9jLAPpjeN5EJlHMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzMzcUNyUlBUMzZWdzI2WDVubFEvb0U0UTdFd2JVUmVscndSMlhSN2RwTjVJ?=
 =?utf-8?B?c0duZVpnS2tjS2M2ZkdqNExzdloySDVIQzN2UXZQeTVOVk9meU5xckV4bnp3?=
 =?utf-8?B?T0hsVG9UcFlOa25RQnJldVJOVDl6Sk84cC9VTVVDU3VqNCtlOVBweDlSak1y?=
 =?utf-8?B?ajYzSVBmbmpic1QvZ3B5WTN4azdlQ3c4ZmNvKytPVW5LcXdySnkvdGR2RXYx?=
 =?utf-8?B?M0F4N2ZqbjJDTUVJZXRuMjdGVkpMemlYalRveGdQYWt4RDZEazNmWUhHcGx0?=
 =?utf-8?B?c0tpeE5vYlJKejVMeDdRWG9tcWV6aFloRkdaaHQ1RHBYZXRZcTgwa2dySWVw?=
 =?utf-8?B?Uk12SnRNUndjVDJJUERVdnBRSXhjMnVtOThoREJTeVRXT2tJYUlhQ25sb203?=
 =?utf-8?B?Qmp3enhTUUtFdENDanhHaWlULzNHM1l5QnRBbEtiZGF4a2dmdURPd0xBV3BJ?=
 =?utf-8?B?c0JTTTNTVHhiU3ZlaW1hamRuSGdyaW0zOVZmNjNrQUlyZjFIR2F1MXo5cW5o?=
 =?utf-8?B?TjlxOUpWMGxaWkVGNGVDamNRR2RRcXhDOFJWV3JDeHorT0VUeDc1ZG1NVTBD?=
 =?utf-8?B?cnZlZ2FBMFFhaXFKSTVTaU83Q1ZrT0dMSlF0eW9LbUd6eGhuaThFVlU0Nndm?=
 =?utf-8?B?SGNRSENNU2lmNnFoc0N6b2Z6dVgrd2JrTjF5dTdQMG1JTjlzTEw2Q21kSWhn?=
 =?utf-8?B?U2Y3eERab0syWXNscm5FOEhvOHQzajhnTlpxb1ZEQUhmTUdiZVN0TkhjMFNy?=
 =?utf-8?B?OGtwRHIzcEs3YVBVekZ4UG9aUTY5YUZxS1ZpMjVUMEVTNTlObWdVQ1J0MDFn?=
 =?utf-8?B?cjlZS3AwN3VDK0JadjE2ZWtadFJ5b3Bhc1FmUHlySGhSdG5EazZaZkRaWlNK?=
 =?utf-8?B?TWJKeEpJMWlVWm44SjgzNkR2MldaUFZNdnBjTVhOMU5kZGZ4WnpVK1h2bGJQ?=
 =?utf-8?B?WGJOOEt0UXp6RURUcjl2YURrNzFtVkRFTDRoeUcyVFZGZklDMVFjVThOTVV1?=
 =?utf-8?B?TlZuc05zbGpiazZhTUhSVUJjd2ZDdkFGd1d6Ukc1d2cvU2dONi9BYmdEc2Jn?=
 =?utf-8?B?b09HTkNaazBFOWFTR1d1eEllTzJ0NEZIKzBnK05nTVFVd0NtRi9JbCs5Nkd6?=
 =?utf-8?B?SElFbHllbjRzNG9SMGlmMlIrSHFHbko5Mi9yOUdTTFhQMTlOak5OV0ZOK011?=
 =?utf-8?B?aDRZTERrTC9aR3VzSGlIa0loOVZCN2puT1pEOG4vcTRzWXM5NHYwOGxjUE05?=
 =?utf-8?B?dlJnR2lrZjJFU2pMbXFqUFUrVUJia1hqQ01sRlgxQm1RK0VDSUVVV0ZFM1ZD?=
 =?utf-8?B?RG4xOWlqK1dLbmFFOTM2WDM1WkxadzB5OG5KZHRsaGxMQk0vMTFaYUZyZ0Qx?=
 =?utf-8?B?RHhDbHlJeU5zRHIwNWxUN21lRVJBTWtuWWxRcUEzQ2VhUnAyc2FXeGlkSWJq?=
 =?utf-8?B?WEl1MHdwckNLMTlSUVhpSVZ0NlJkMnNrNUVyOVozdFE0ZXVHVzN0WWI2SWF2?=
 =?utf-8?B?SmhiZHNYcmxQUjlVL0tpQ3FCWFNjeU9GN3VHbWlJdjZjelFnWFJ6d1BBSDBZ?=
 =?utf-8?B?NnBxczVndDlYelVWVjcxeHZ6b1g5d2JOYjRoQU1kMDc2Z0ltWFNVakNzZHlx?=
 =?utf-8?B?MkkxcWtuclRLaVhnSmh1VDNtNXFZZTA1ZUN1UkFFZHFWSitvQU1nYUlocDMy?=
 =?utf-8?B?aWMyNEdBWkovQlFaSGgvUDE0U2tKT28vRnNHaEpJMitqNHZVNy95RVFuNTZk?=
 =?utf-8?B?di9xcGFSSHNXZE1NWDhaOWtxVURGMUl4TzNvNFd3L1p1VHQzZ3BRNks0dkZk?=
 =?utf-8?B?NTVDTE9sODR1ZTVMRCt3T2NWZnpBNklxWmsyNmxWKytaRHNOUWVEZTBGMVdH?=
 =?utf-8?B?T253Y0d3N1NBS1dQeVgwUHNRSFR6KzNPVHloNCtnd0l0MmtJUWdNNjNxeWhZ?=
 =?utf-8?B?eXF0cFppcllDZGdSTk1LenQ3MEhwWTFqd1B4bzVEc01oMWpZZ3NWdC9QVXFS?=
 =?utf-8?B?ZlZYZmJEdjF6bWhET2FXbzNaTVdIdE1Hbk9ZKy9TczVpejFaTExpTFpRZGp6?=
 =?utf-8?B?eGozYkVEMCtkM1VGYVNLV2Y2UEp1cExKRVF3TVJIVmY0eDMyUlUxZlNHaTli?=
 =?utf-8?B?dFFjTEh3RkVUenZvZ2xkaU9zekhOVisyWnBIT1Jac3Rud1dHWDNjNFZSMHhB?=
 =?utf-8?B?S3FyK0tCbWpoenhQSmpXOXh3Zm5HdmRBQUE3Wk5telo5M2xIcU9sM2hCcVdo?=
 =?utf-8?B?NFUwd2J3WmNJLzkydTBCMk1RamZTZEl0ZllqdFVucjlPQTd0QnFoQSt4d0ZZ?=
 =?utf-8?B?YW9mOGFRakExWFdUQWdZMks5aDlUdmNtOG8vTnBHK0tYb0E5cWpBK1dGWFcz?=
 =?utf-8?Q?GzJJADSHQRAenLpo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4052b760-50b7-4420-8fb6-08dee8de4285
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 17:17:23.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuXCrao0DEauVUlWpSRSFDTcV9twjahSY9kc96Xi1yc1HsBuJM/mSq2xUmM5G9XeIKISWH+QNohBPDzY4IxdO1696yzNqN90m2QSIDODUrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8942

On 7/23/26 7:50 PM, Michael S. Tsirkin wrote:
> On Thu, Jul 23, 2026 at 07:46:58PM +0300, Andrey Drobyshev wrote:
>> On 7/23/26 6:18 PM, Michael S. Tsirkin wrote:
>>> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>>> the vq->worker pointers and immediately frees the workers, without
>>>> waiting for a grace period.  A caller that fetched the worker right
>>>> before the pointer was cleared can therefore still be queueing work on
>>>> it while it is freed.  And even when the queueing itself wins the race,
>>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>>> future attempts to queue it are silently skipped.
>>>>
>>>> None of the current callers can actually hit this: net and scsi stop
>>>> their virtqueues before the workers are freed, and vsock unhashes the
>>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>>> the lockless send/cancel paths become able to race with the teardown.
>>>>
>>>> Fix this by clearing the vq->worker pointers, waiting for a grace
>>>> period, and then flushing the workers so any work the last readers
>>>> queued runs before the workers are freed.
>>>
>>>
>>>
>>>
>>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>>  drivers/vhost/vhost.c | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>> index 4c525b3e16ea..d6e235c25254 100644
>>>> --- a/drivers/vhost/vhost.c
>>>> +++ b/drivers/vhost/vhost.c
>>>> @@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
>>>>  
>>>>  	for (i = 0; i < dev->nvqs; i++)
>>>>  		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>>>> +
>>>> +	/*
>>>> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>>>> +	 * reader that fetched a worker before we cleared the pointers above
>>>> +	 * may still be queueing work on it.  Wait for those readers to
>>>> +	 * finish, then flush so any work they queued runs (clearing
>>>> +	 * VHOST_WORK_QUEUED) before the workers are freed.
>>>> +	 */
>>>> +	synchronize_rcu();
>>>
>>>
>>>
>>> Any way not to add this for all devices that don't need it?
>>> Or preferably, even for vsock in absense of the new ioctl?
>>>
>>
>> This code was initially local to vsock, and was moved here in v3->v4
>> after we discussed with Stefano that the issue looks more generic and
>> should probably be fixed in vhost.c (see
>> https://lore.kernel.org/virtualization/akO6tps94iFxCAWv@sgarzare-redhat).
>>
>> As a compromise, we can keep this code here, but only call it
>> conditionally.  Namely, create a bool flag on 'struct vhost_dev' which
>> is always false, only set it to true on RESET_OWNER, and only call this
>> code once it's set.  Clumsy, but this way no other code path would have
>> to wait the full grace period.
>>
>> What are your thoughts on that?
>>
>> Thanks,
>> Andrey
> 
> Or just thread a bool parameter to it?
>

Yep, that should work as well.  So we'll have to do:

vhost_dev_cleanup(struct vhost_dev *dev, bool sync)
  vhost_workers_free(struct vhost_dev *dev, bool sync)
    if (sync) {
      synchronize_rcu();
      vhost_dev_flush(dev);
    }

And then vhost_dev_reset_owner() will call vhost_dev_cleanup() with
sync=true, while everybody else (net_release, scsi_release, even
vhost_vsock_dev_release) will call it with sync=false.

I'll squash it all into the same 4th commit and resend, unless you have
any objections.

Thanks,
Andrey


>>>
>>>> +	vhost_dev_flush(dev);
>>>> +
>>>>  	/*
>>>>  	 * Free the default worker we created and cleanup workers userspace
>>>>  	 * created but couldn't clean up (it forgot or crashed).
>>>> -- 
>>>> 2.47.1
>>>
> 

