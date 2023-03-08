Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA3EC64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 16:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 132694186F;
	Wed,  8 Mar 2023 16:00:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 132694186F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eFmF59zf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hUZRo9J-IFoY; Wed,  8 Mar 2023 16:00:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ABF204186C;
	Wed,  8 Mar 2023 16:00:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABF204186C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E1A2C0035;
	Wed,  8 Mar 2023 16:00:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B6CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3538A4184A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:00:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3538A4184A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f55Gb8e4Gb3f
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:00:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 656E241817
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::621])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 656E241817
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 16:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asWsM8p0RLUfPzVPKmpMQ1o28vphjA4mRVyUYY4HgyuV8JS82F45XptmpwUPDnmvTVBqAqOudtrj01lOg31i8G65r0eG7b6TKgFddNwa4clMZ9S34vxeROOKiXaYT5ZF4W6Nl/GHh5aWjol7xYudMhk9C8FCc4j7Cj6NZ05LpjuhSNAnyvAIV+9pOZbHn96vozVxS8lgq1hIWV2GuSpVPX7tJy2TVE70WboOLAXmUKlrzs4NmJKOrr2wlj5zzt6XBvgc9Vyz2o6tO9DGho4f8BBZZt+840QbTuOU7PJgpcQ2SQkXmY38MKJrBzY1GLv1ue2pkpSJj6Zh/E8QYsUYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYnCZsOz2xUs25kcpe+v/U5aKtViW8NtJZ4ni8taivs=;
 b=obh9vK1nmRsmvjk5ByWI+xvlOw7r8hImzpMQHAcxOTNPOJEuHNmQ7VXExfpBO7eawHJGyra0QDcQ6EcA9LvKrufxoXuxWEA4n46B/Ifyce5S4tRS8L/aJmSiko63Gb/GRLPFEVyjDMvL9AWv1ADX2NHts+N2KkeHaSNuoLUVU0RDAQa1hZZeqRW/VDzwxncmxH7i3TpZ/ZKDiFPG0C6XNgSGDNWuvK+TQezWYebPo8/YZIUu9m2WeWh3AHzpakKsNHoxh/SB+gelLAS5ly7TRLUPmQ6nzQ7eXPMy+RhVX2TIoMLgKwfs6Y2bXPH17kZvpICJLv/Lywcso09vQzJVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYnCZsOz2xUs25kcpe+v/U5aKtViW8NtJZ4ni8taivs=;
 b=eFmF59zffmVFXjAKE/qXPilYHoe8eW2V+Sh1pbErrYBDRWotCxxA5491ivhcWDTQGDXPZMhg4gfFjSjqCBC5XYRYHbhvfBNvJ8L1ixBV93wSUiqVCfEaDp5WDStaROzfLr+xaIXJWVAa4R21m5L7I4YnufENiY1kowrEJ7ZIh337JR1vQ4qroLt5WYtf7/u/Ag/AF9VfNByVG7frhDlCauMgrfrFcSvrZETeDv1HtvTF+SxJ6k6tUXamp03jjp2nDthLPYI/lMyChpBSXyoVA3G7bDaJuFuJxpnDizUEcusdLX8vVv6NvDELsY3FEsuoKEaHub02KOZCj/EcWrdKyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Wed, 8 Mar
 2023 16:00:01 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 16:00:00 +0000
Message-ID: <4c031230-c0ac-7809-a85e-09f07c3f7e06@nvidia.com>
Date: Wed, 8 Mar 2023 10:59:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com> <m2ttywzzxd.fsf@oracle.com>
 <4e8d1e89-9b32-8dcd-acd1-6957f13fcbb9@nvidia.com>
 <20230308091321-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230308091321-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 7774db74-0e9e-4d05-af2c-08db1fee2c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kd1GgNqBdaOUxBK1u0K8+3uOc1odDI/puD49BRgVawTgOKl4oPYRxwxQMAoP4EaDW6+TPfcdTkvW6bAlIjm6my6zAUCAq6FdrUkk+8RIClTDEUvRa/vlgSwClakHXdojjgWWLflBWdd2AcVpx0patPlhlNdBvgxETf3fuUHiCPHktYtbC+aluno0KiOENnYAjMi9+x7wk9u2jScGDK8ngpKDCDarxV2G/wwLE+6i9vnncyTpSsNjR9Os1pIUxqYFosNjY5OSddDKjOiNQUWWWGdODf/JCQDjmvPaXrsiMiULPHfR/+nUlk1vnVt8Wdq0KKFD4IF9DtiyoZLnC+b16rZ6G8RQipX/JYKJ4GB3LIX7pxIKSi3B6oAHdE+Q43arAxdGTxp1wQOwMojBDvEozItU5AQHG/Vitrt/s2NQrBNt4iGpFdYpHHVEZKCFeq1zZJ3A0FQnPRY+W29LAfhJUuMwYhBDbvVU4X0g6FGsj0wV5TCBaHEYr2z3/UmJX5jXkk+P5deRXIfYm7OAHmtUYArHcyVCJ9EnJsVX1RD2HNKxJBPm8CUJ1LRipxSjmyiXF5cno3hAri50MmWvRGFg+IThGaJweg84tx3lJzTHzzATBP/aq6goqRX/6tPc01IhoU3vCR7YI9APCNSZ9o6Per1lR9CG8mSFSbk8UaQJb8JGuRpPqyyxu3/Mn8ftWi7sXtq1MXbNMRP7nI99O4sC6SJJLW5Xr1QVXnaEdU6CSW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(84040400005)(451199018)(478600001)(316002)(6486002)(36756003)(26005)(53546011)(6512007)(6506007)(186003)(6916009)(83380400001)(41300700001)(8676002)(66946007)(66476007)(4326008)(2906002)(5660300002)(8936002)(66556008)(54906003)(45080400002)(6666004)(38100700002)(86362001)(31696002)(966005)(31686004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmp6bzRCZDhwUU5NYXJnZzNIMktHUUtUREtEaC9WQktOa3NEZ0s0b3BNdVlN?=
 =?utf-8?B?RDBZOFM1dUdZeFdjaFhrUHkycDQ5SDlJbVNsK0pVV21kR04xU05mRkpWbnox?=
 =?utf-8?B?ZGk3UG92Z2ZDdXFINWZvUzIyZUoyR3MyUnpUdEREK1dGVXNpMitKNE9OVXVS?=
 =?utf-8?B?UzZwYmlFclJVOXpMcjlJVDUvWU5PZ250OXBTNU4vRnc1bURVajFDdmZPUGxI?=
 =?utf-8?B?UDdmVzhJYnJFMW91a09ub0txekUrSlFISFR3djFIOFVaY2tLTmpSZ0VIUEZJ?=
 =?utf-8?B?UUxDRWRQYUhKZjVZM001MGM0dmJkb0JibGk1cnJLdXRQT01ldStWZmdKbERV?=
 =?utf-8?B?bjk1eUw1OUtZdmxmblNOTENZa21BUEZsTGE5VDVnSFYxbENlVVV2Ukp2UGhY?=
 =?utf-8?B?Z2MwL3I0eVJiV2xuVTUyQjZRUHR2MEJNSGpBRFhpUjdSUWFRNnBQU0Q0QlhI?=
 =?utf-8?B?TTUzbk94ZXVnQXFKUFpmOTAwOWx6YXF2QXRoOEtUR2FpVyt1QUhRT21xa2Qz?=
 =?utf-8?B?L2tvZTB5OHduNWZ3anpzUWQ2RG04Q1RQa3JSM25OQjFvMEdlZkhCSGZjUDli?=
 =?utf-8?B?bWl3U0NMZ2FkNGlZWXVNU0hIbzBsT0phdXQvcUtkSjI2a0Z3YjdtZ3ZpQm11?=
 =?utf-8?B?cWFpZm1CaUI4aXgvTWFOdFVMbU1EdmVmYjkxZ2UwZlhBTnZNVnVGcnhSbUxQ?=
 =?utf-8?B?SEUreEMwUnpHNUQ4Z2ZXRXBTMDFuenVVb0p6ejdmVzMxYkwwYlJLZkVuMmMv?=
 =?utf-8?B?ZG1MakFmOUdUbWdYbjZnQ1RFUFZtb0FGb2xBS3FiNGdhV2VqQnVBU1A5bXNH?=
 =?utf-8?B?bmtuUFowWGNETUNPMThmb2RMeUhFWmtkOUJteVRjSXlMQ0dta3p1MEQyRkx6?=
 =?utf-8?B?WXkzN1NCREtNUjUwaTlubWp3K1paRDZzMG1EaEc4N1pkb0JaKzNJTUsyM240?=
 =?utf-8?B?TS9qZHRkSVV3SEI2OWdpR09MQ25JdXhxQTBlYkFlN2NNOXBJZTBLcGJDay9E?=
 =?utf-8?B?Sm1Lc2NUSThXM1RhWm5NWFFXVlJid094WTBXdGo1VlJKUWRrTk9TTVEvV2Zv?=
 =?utf-8?B?anhkRmN2WE56S2dOUm4zcmJ0UEhEdkp2czFvVnBHSEUyYXBKUzE5RXVUVG9Q?=
 =?utf-8?B?SEtOeGJSRnJINEFlbHlzT204dDdyZEpZdlIwUElXa2ozM3ZhZVV6VWtjZm5p?=
 =?utf-8?B?K1JNM0l3MUZzVFNmKzRCand2L295VjVWbXpNTkF0YllkbkNIeEtycmEwZFg5?=
 =?utf-8?B?Z2tqK2s3QXMrdWJpUDZKV1NYcXVlZmFuVjdvWk1pMzBHZkVlN29sZlRIMVI4?=
 =?utf-8?B?QjgyNUZFWmtvZk1Lalg5eWxaU1pSQmlNUWt5VTlWVWREWk5WM3pUUngvZVkz?=
 =?utf-8?B?ZjBrQkZMMDMweE5rbTZYdmxHMjRScHFTWkw1TWdiQ0pNWnIvNHZsKzg0NVNu?=
 =?utf-8?B?MUZqd1l1ekliUHE1MDlFZW1jV1pQSUIrNDd0UnhlWit0UW94MmtLZmRsL1p4?=
 =?utf-8?B?am16TlBBSGMyT0trWmRZVUJoQThLZ3RwZ3QxM3JwYml5RWthV2loWEZLSFhr?=
 =?utf-8?B?Y0ZiZ2xEU3UwNVVrOWp1dE4zbDJHTjZaMCsrSW9qeURBNWhxQUd2aXBqeERU?=
 =?utf-8?B?NW0vakJlNklpYUtuU2RpMWREbjhra2F6VUhhRDJuamx3ajcwNmJGNkEwVVdG?=
 =?utf-8?B?cE9vT3VhdHZIUGJITlR4VitMNlVUQm5rakRnM0VMbnc3MWZKVSttTFVUQm0y?=
 =?utf-8?B?YU00VXYzMUNvajBkRUhzV0hlMVFxUk5sVVNOclZ2S0lPUGw5N0k4ZHRBdDk4?=
 =?utf-8?B?Z1p0aXR6Z2pNdy94T29nMXQvbDJjbFVhKzhlUGI1QkVYSzc0ZVZRNkJnYlla?=
 =?utf-8?B?MU91UjRTZlB3VGh6QXNIUkhJUUNVZGRHNFUvblVvTDJtSW9KOGFNM2l1SmdG?=
 =?utf-8?B?S0tFdEZjMmRyeUVQbWs1UDB0Qjd6aWVJUGJxMXBxb21YLzFIZ0ZqUE9UWndV?=
 =?utf-8?B?dlNrNmhndk5lNFh4QmFqTWpQOHhMOFNtazJ4Y3BBcnZuWDFZT1djc1p2VE9O?=
 =?utf-8?B?V1pwTTNrcmVoN1k4RnJjRXhGUDRIM2FZSHg5Q1hKWGV2SXJQQTljMmJieDJx?=
 =?utf-8?Q?8p10zW0+OkrpZLru5DYat79Vn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7774db74-0e9e-4d05-af2c-08db1fee2c29
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 16:00:00.8069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk4NJxGa5UDzinfT9K5BL4iPtV6tDvDh7uI9KDeunWNI8qnYSOllaZjrDwPPQG9U98rVdDPP0ak99PQHAlIS7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "feng.liu.kernel@gmail.com" <feng.liu.kernel@gmail.com>,
 Jiri Pirko <jiri@nvidia.com>, Bodong Wang <bodong@nvidia.com>,
 Gavin Li <gavinl@nvidia.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 2023-03-08 a.m.9:13, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Mar 07, 2023 at 09:17:55PM +0000, Feng Liu wrote:
>> On 2023-03-07 04:14, David Edmondson wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
>>> writes:
>>>
>>>> Add const to make the read-only pointer parameters clear, similar to
>>>> many existing functions.
>>>
>>> In many of the modified functions the local variable that is a cast of
>>> the argument could also be const. Is there a reason not to do both at
>>> the same time?
>>>
>>
>> Hi,David
>>
>> In order to prevent the content of a pointer parameter from being
>> modified and increase the readability of the function, it is recommended
>> to add the 'const' keyword to the parameter. This is not necessary for
>> local variables and non-pointer parameters, as they are only stored on
>> the stack and do not affect the original value or structure member
>> passed into the function. Therefore, in this case, the 'const' keyword
>> is only added to pointer parameters.
> 
> This makes no sense to me. If ytou cast away the const then it is
> pointless.
> 

Hi, Michael

I really don't quite understand your point of view. Is a local variable 
that needs to be add const? Can you help to point out the specific 
problem/point ?

>>
>>>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>> Reviewed-by: Gavin Li <gavinl@nvidia.com>
>>>> Reviewed-by: Bodong Wang <bodong@nvidia.com>
>>>> ---
>>>>    drivers/virtio/virtio_ring.c | 25 ++++++++++++-------------
>>>>    include/linux/virtio.h       | 12 ++++++------
>>>>    2 files changed, 18 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>> index 806cc44eae64..8010fd1d2047 100644
>>>> --- a/drivers/virtio/virtio_ring.c
>>>> +++ b/drivers/virtio/virtio_ring.c
>>>> @@ -233,7 +233,7 @@ static void vring_free(struct virtqueue *_vq);
>>>>
>>>>    #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>>>>
>>>> -static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>>>> +static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
>>>>                                           unsigned int total_sg)
>>>>    {
>>>>         /*
>>>> @@ -269,7 +269,7 @@ static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>>>>     * unconditionally on data path.
>>>>     */
>>>>
>>>> -static bool vring_use_dma_api(struct virtio_device *vdev)
>>>> +static bool vring_use_dma_api(const struct virtio_device *vdev)
>>>>    {
>>>>         if (!virtio_has_dma_quirk(vdev))
>>>>                 return true;
>>>> @@ -289,7 +289,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>>>>         return false;
>>>>    }
>>>>
>>>> -size_t virtio_max_dma_size(struct virtio_device *vdev)
>>>> +size_t virtio_max_dma_size(const struct virtio_device *vdev)
>>>>    {
>>>>         size_t max_segment_size = SIZE_MAX;
>>>>
>>>> @@ -423,7 +423,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>>>>     */
>>>>
>>>>    static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
>>>> -                                        struct vring_desc *desc)
>>>> +                                        const struct vring_desc *desc)
>>>>    {
>>>>         u16 flags;
>>>>
>>>> @@ -1183,7 +1183,7 @@ static u16 packed_last_used(u16 last_used_idx)
>>>>    }
>>>>
>>>>    static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>>>> -                                  struct vring_desc_extra *extra)
>>>> +                                  const struct vring_desc_extra *extra)
>>>>    {
>>>>         u16 flags;
>>>>
>>>> @@ -1206,7 +1206,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>>>>    }
>>>>
>>>>    static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>>>> -                                struct vring_packed_desc *desc)
>>>> +                                 const struct vring_packed_desc *desc)
>>>>    {
>>>>         u16 flags;
>>>>
>>>> @@ -2786,7 +2786,7 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
>>>>     * Returns the size of the vring.  This is mainly used for boasting to
>>>>     * userspace.  Unlike other operations, this need not be serialized.
>>>>     */
>>>> -unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
>>>> +unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
>>>>    {
>>>>
>>>>         struct vring_virtqueue *vq = to_vvq(_vq);
>>>> @@ -2819,7 +2819,7 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
>>>>
>>>> -bool virtqueue_is_broken(struct virtqueue *_vq)
>>>> +bool virtqueue_is_broken(const struct virtqueue *_vq)
>>>>    {
>>>>         struct vring_virtqueue *vq = to_vvq(_vq);
>>>>
>>>> @@ -2827,8 +2827,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(virtqueue_is_broken);
>>>>
>>>> -/*
>>>> - * This should prevent the device from being used, allowing drivers to
>>>> +/ This should prevent the device from being used, allowing drivers to
>>>>     * recover.  You may need to grab appropriate locks to flush.
>>>>     */
>>>>    void virtio_break_device(struct virtio_device *dev)
>>>> @@ -2881,7 +2880,7 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
>>>>
>>>> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>>>> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
>>>>    {
>>>>         struct vring_virtqueue *vq = to_vvq(_vq);
>>>>
>>>> @@ -2895,7 +2894,7 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
>>>>
>>>> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>>>> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
>>>>    {
>>>>         struct vring_virtqueue *vq = to_vvq(_vq);
>>>>
>>>> @@ -2910,7 +2909,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>>>>    EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
>>>>
>>>>    /* Only available for split ring */
>>>> -const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>>>> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
>>>>    {
>>>>         return &to_vvq(vq)->split.vring;
>>>>    }
>>>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>>>> index 2b472514c49b..36a79374e735 100644
>>>> --- a/include/linux/virtio.h
>>>> +++ b/include/linux/virtio.h
>>>> @@ -84,14 +84,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>>>>
>>>>    void *virtqueue_detach_unused_buf(struct virtqueue *vq);
>>>>
>>>> -unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
>>>> +unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
>>>>
>>>> -bool virtqueue_is_broken(struct virtqueue *vq);
>>>> +bool virtqueue_is_broken(const struct virtqueue *vq);
>>>>
>>>> -const struct vring *virtqueue_get_vring(struct virtqueue *vq);
>>>> -dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
>>>> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
>>>> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>>>> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq);
>>>> +dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *vq);
>>>> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
>>>> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
>>>>
>>>>    int virtqueue_resize(struct virtqueue *vq, u32 num,
>>>>                      void (*recycle)(struct virtqueue *vq, void *buf));
>>>> --
>>>> 2.34.1
>>>>
>>>> _______________________________________________
>>>> Virtualization mailing list
>>>> Virtualization@lists.linux-foundation.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.linuxfoundation.org%2Fmailman%2Flistinfo%2Fvirtualization&data=05%7C01%7Cfeliu%40nvidia.com%7C0f6803f1797f448823ac08db1fdf67e5%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638138816610707030%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=FxggnD7U8o%2B%2BqcYnHN6nc%2BemGVRU1ia5sA4k%2FRTDD7U%3D&reserved=0
>>> --
>>> Woke up in my clothes again this morning, don't know exactly where I am.
>>
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
