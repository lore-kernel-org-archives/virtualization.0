Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6101DC77B7A
	for <virtualization@archiver.kernel.org>; Tue, 30 May 2023 21:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB81B4141D;
	Tue, 30 May 2023 21:24:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB81B4141D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LCUW/Dog
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 54ApSHFbEjnR; Tue, 30 May 2023 21:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F0D5E410AC;
	Tue, 30 May 2023 21:24:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0D5E410AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA0C9C0035;
	Tue, 30 May 2023 21:24:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31F4DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 21:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BF5D40352
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 21:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BF5D40352
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=LCUW/Dog
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1uL-sikxZzH3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 21:24:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 278A3401A4
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::618])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 278A3401A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 21:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlWbrUhh/cyFUdprdrVTVYP5o8FWJzv5rIYB33AmF7xKGXl9mm9WHX/Jrkz2J/9UTEDLcyb+y5J2ETugGLjZJ+nrjDkhMIgSLh0+3dSo9vf8/Ljpsl7Gtb5qnlMfpoNaOv663fO8Pn1x0rbRdMjmklx5c/f6t/PHFJYOPHfFJoD4NeM4E9QVRouW+BgSQ2XUia0tAQ6dAuz0NK7Lf1Ff4VAPcB2YZpft/S/0ZIOG1SvkZql5zoBI+OqOw5N4GyqSysp0KoRCvLGRYph1LdvVwNBH6INRsCpLWM0iKxPlvMw/55ldHSt4NzgSJgKJKi3/V3HRgl5XTZsZNKtzA/SJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u19wXAFhmme6nLUfmxBx41QmZnDx3ZY3dXFqFDC59Hc=;
 b=U42YfcXqExusqJ7A9nW2GHHaXu2zPHijfQ/JoT0id8bFx86lKCl6vmLbrclIUgW4bWhHRl21aNmgTtCCMvmzTULPc26TB4yhuoZCCzrQPrdBy/7h5GO5i3QJHlDJ6rfiCHmic7uoGKUVl+cq6HEdc0fLzD+gYQQrTcKDWLw73tukchMYQTRx7WVZpBTm5NucGmfNzzD34VC9AyPWnZLLfjKc7KM2E4bEION0sfOE6yprS13bmAlF+AVHNIT0HXGq2rtxFHXa9KNV7C7FtWXB2NBb2y8NklcAaD4hMV6y1EEP9QN0yIlaVHuGk+ejRRMrk+SL+43K/XTgvDLaqTu6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u19wXAFhmme6nLUfmxBx41QmZnDx3ZY3dXFqFDC59Hc=;
 b=LCUW/Dogfe3sqLeZ17wAFNEM2qUBmJz5d/aATofptG3N2HjZ8Pekoyka0gjLz6YY/b5UybdYeDgNu8GlybH4oidKdpNfhKT3cMldTM8v3en7EE2BxsgglHJboyfk063vGI8s3RKmFHKwrVLI95lOWZz0ZCr6qSrdTIy4r4TGXjo48Gu6IRh5d53w2W4h5/1LHtt13+R9uI2V3ukgUeTsdWZ3I9e8hLgXDYjED7Ymd+wzccB8xiQP7r0v28IkcETaRRf6S+RcRcM9ua+iQnG/zdkv/5ZhTB+fHMTEcrXWc3FgAzMNOLYNJxiWxtENx7j+FMd9XAfoCVwm8zrCH3xrHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 21:24:43 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 21:24:43 +0000
Message-ID: <9a1263c2-aa95-0f55-4820-d1b66de97e16@nvidia.com>
Date: Tue, 30 May 2023 17:24:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Improve code style for including header
 files
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230529181729.15745-1-feliu@nvidia.com>
 <20230530072642-mutt-send-email-mst@kernel.org>
 <9d183df9-7047-0eee-b6d4-b0f9b8d21036@nvidia.com>
 <20230530111818-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230530111818-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA9PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:806:20::24) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 83007748-b4cd-450a-a598-08db61544911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iz9bPEwrebr4/EeKNWL/IkAnQj4ShcWBiZKPEwC7ja19RmM2V/A+Nnr+cncgtwVqns3BwcIgqqEyb1+EywnNutVcFgbH5vsN6+ASYxtymlcuhRtzt7Krsza5Wqab6aNInq4Is+xAKNo7G18fBCbHdpm1gVUsnL3X+WRU/aBrpxnNAUaEJ5PLMCscmB1ghbdL1Xo5UNQ8TwwU3oVz9P1DKAA6dCp04Wmks9QF/Z/tD16zdJPSCmiDYRazdOBXlOnZhXD6ddlyjSpOR7CUYgYgmieJ+Cn1O9VDXjJELl1FvGHzJTctxoLylUAOxD/ZrHAEdfA7G9zhYcfIJGuImTH347Jxpr9g3LHCHCdVluC2/IZgM0zonfdM96dq9xJ0o/Nx4Onwys72d+2oy9LDSnJfO7D+qBUJdkFSRnPbzShg6CKWbTZ7CXR68IQxIL92tcb3o7L6ftU1/FnxOBBbDNer8c/Y9hzU/b+Ed5vm1lNOPvHuv9iU8DtWAxcfWa291tEY/HLZpdaGmoykDDwm0Pk5HcaWdNjd/gyG9olQGMwfORpAyDqYM+bDjkJDMV5lerUER5VjRsovG+H+bZHg4sSFuJwlOlCvOSU/k5wkTzvJddd1uajGTGhUEcehoVeXNFdrEEDe4gFJGTCopEqKAVhaSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(36756003)(54906003)(478600001)(5660300002)(2906002)(8936002)(8676002)(86362001)(31696002)(66476007)(66556008)(66946007)(4326008)(6916009)(316002)(38100700002)(41300700001)(26005)(6506007)(6512007)(186003)(6486002)(83380400001)(107886003)(31686004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1BVMWpCRTl3MWRjUVEvYUllblcrdTBaL0J4d1pmNFprMUFTbDFFSEpXR2U5?=
 =?utf-8?B?U3piWDVUbVJzOVZlR3ZScXpUZm9RUTFkazB1enF3L2V0VjRvc2tZOEdJWE9F?=
 =?utf-8?B?WVE3bWlra21seHBPWmNQVk1aOXQreWpPM2dQVmcxaUw3dEJtanBqc2F4dm1P?=
 =?utf-8?B?bW1oVENXL3E0VXEwc1lDb0ZFalkzaGZnK044WWpEM0lZUCtLK3BuazJ1aGR1?=
 =?utf-8?B?TFk0SlR5MWR4UlpzcUJPRWZieWc5a3VNNFY1QURqZ0VlNEo2OGRROWlDeGVz?=
 =?utf-8?B?ME82YWd0TUVhTWl4ZWtTMU1PTTJ2ZkE4UjR3aUlQVUh6dnpCTEZSM3ZjQ0Zl?=
 =?utf-8?B?TTNTU0h6aHM3cTJkNVcvd1ZPMmZWK3k4UlNIQjBPcklRZU9NNzZXcHhRWHMy?=
 =?utf-8?B?SFdneUNMWWxpaUhEMnErYXRvc243dlhIK0hwOXJTc3EwbG82Tmpzc3J0bExr?=
 =?utf-8?B?VWtCK1hSNXFYT1I1VTEvK2phTHFwOHlRRWlkYmV1NVkwblJKSjN2a1ZsSmJO?=
 =?utf-8?B?Tjh6NmN1UlV1WFc1VXlNc2dodkw3N2VrRmtZOHd2QTBmL3AxSjQyTWk5OXMw?=
 =?utf-8?B?VlA1empmUWRlSHNHcDdMSHdqVURxZnhaY3E0RWpSemdjTHNqSWhENlo2S1d6?=
 =?utf-8?B?cUNwVkhaK0xCWGRVbzhvUExjdldtb2NuL2hFZEtEbERWUTE1U3hNY1lIZFV3?=
 =?utf-8?B?emg0N29hdFRlb0RCaU9GT2V6MFVpZm1UNm9mVVhSTk5PK2lJYWRYdHFRNTZN?=
 =?utf-8?B?ZzNmS2tLZ0FSTTUzSXJqSGk0NVloTkJZQ0RqVlMwL1RsSGNpMTVQTUE0R09X?=
 =?utf-8?B?dlNZZW9EaUVVNWNTN01SZTZIQ0gvazg5RXVNRG5oRDF6NllnSzgrQytCajhZ?=
 =?utf-8?B?UUpOWjYwazY0ZGN5aXRaMjlmTEFGYjgwZ3pvSEdsS3FxVlhySWJySDhhMk9a?=
 =?utf-8?B?UkVrUmd3UXZDTlFwUVh6YWRjU3pSVGduREhxMTdZMGdSMklWb3NjdzFKN09C?=
 =?utf-8?B?TzBnb3NDVjY0dWtVRjIrZlVpTDZ2ekN6dmU1c3JNUm5NUHZJMnJaUFhrb2Nh?=
 =?utf-8?B?WFJrY0pFMEJNRm4zZUdxQURBNklwVEc3ODNQbkRaSnIveW83bDZIdWQwT3Nx?=
 =?utf-8?B?WWRyQ2g4U3F2akRUdTJ5QmlHa2sxOFJYak5pY0FyaE9BNURkRWNod0ptRnph?=
 =?utf-8?B?YTJQVVRlendFUFNFSFdUY2F4eFFaYlgxcEpxaHlOV1Y2OWwwZUQ1anR6RlFm?=
 =?utf-8?B?V0tyZDJEdysyZHpsTnFGUDBnOUJDRWtYNVc3NytrNjFsN3ZqNkNrUE1BU2Zm?=
 =?utf-8?B?Z0djbUpGbkZKVkgwMVR4aHY5V043M20zMnNoV2xTaXdRUkl6UHNmdnF6VkRP?=
 =?utf-8?B?UjZCWXB0YzRFbHB3T2pCR3Vvejh2eUVzS1hxblBqZ0lEalBnRmtEVlQvZFVl?=
 =?utf-8?B?Rzdoa3VQTlQwZUtJSytZdDVGT0UxMExqM2FaUk1uUVpVS2JoNjJjSVdveG1K?=
 =?utf-8?B?OTZnQnJHUGY2ZDNKcnNIQk51WWlmM1c1RHE4UXZvQ2lsaTNYSTFVYm5LemFU?=
 =?utf-8?B?VFlySmU1SnVPNUZFOEJGUHhBUURBOG1sU3VkZzlZeUtsSzhRTlJ6UXVCcFd6?=
 =?utf-8?B?SFdxQkVmUitNa3R3aHROZ3phQXVlUWpNZlNkVDl2QkRuUTNLOFQrVGNxTytr?=
 =?utf-8?B?aDdBUkwvVDZnZWhzOGt0aXo0QXZHaXFrbU5sZDdLTCt5UDZjVGluQjVEblVx?=
 =?utf-8?B?ZmNoVURwT2c4c2JENU0rZHpRVkZkeVZUTkJRbXlyV1VlSnF1MThpQmFBbDli?=
 =?utf-8?B?N0lrM0FablEwNjNpRFowYTNXeEVnYjYwNHVXbk5wVlkzd0JORGcxck9pUWsr?=
 =?utf-8?B?blNkMjhmNXI1OUxoc2R4Y0tPN1VsTXhsL3JkWllUbE9iNi8yUW1NSHA5UkhN?=
 =?utf-8?B?UitBZDg0NElmUGNVNjVnTHUyNTJvMmRReTNGcmVLSWhVMTlwQnQzaWIwZkN5?=
 =?utf-8?B?d0hwUVpQbWZCcHdDLzByQmN5b2k4bG0ydFZvemk4b2cxNGpQMVlXZGFvb0Ji?=
 =?utf-8?B?SFg4SEc5STc1Um5tQzNYOGEzUVhzRE8vTzJKNllBV3JMT1JCa3JjWjVMYUZ2?=
 =?utf-8?Q?vhb1GuoemkOCUCzlkqztTN33a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83007748-b4cd-450a-a598-08db61544911
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 21:24:43.5783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mod1ZobbdzLfN0C/KgGq71RqAR+s6CsWsx5/RUgAR6OWbzmFlRTiVkhY3ZTWh7QPlZUhtZ6X9d0hYRi25GkNdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jiri Pirko <jiri@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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



On 2023-05-30 a.m.11:18, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, May 30, 2023 at 10:07:23AM -0400, Feng Liu wrote:
>>
>>
>> On 2023-05-30 a.m.7:27, Michael S. Tsirkin wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, May 29, 2023 at 02:17:29PM -0400, Feng Liu wrote:
>>>> Fix code style related to including header file. Include header files
>>>> before declaring macro definitions to avoid conflicts.
>>>>
>>>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>
>>> Which conflicts? These macros are there precisely to change
>>> how the header behaves.
>>>
>>
>> Hi Michael
>>      I think including the header files should be placed before the macro
>> definition.
>>      If VIRTIO_PCI_NO_LEGACY and VIRTIO_RING_NO_LEGACY are needed for control
>> header file, we should put them at the beginning of virtio_pci_common.h.
>>
>> What do you think?
> 
> I think you should read the code in question not make guesses.
> 
Okey. I see, thx

>>>> ---
>>>>    drivers/virtio/virtio_pci_modern.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>>>> index d6bb68ba84e5..b21a489e0086 100644
>>>> --- a/drivers/virtio/virtio_pci_modern.c
>>>> +++ b/drivers/virtio/virtio_pci_modern.c
>>>> @@ -15,9 +15,10 @@
>>>>     */
>>>>
>>>>    #include <linux/delay.h>
>>>> +#include "virtio_pci_common.h"
>>>> +
>>>>    #define VIRTIO_PCI_NO_LEGACY
>>>>    #define VIRTIO_RING_NO_LEGACY
>>>> -#include "virtio_pci_common.h"
>>>>
>>>>    static u64 vp_get_features(struct virtio_device *vdev)
>>>>    {
>>>> --
>>>> 2.37.1 (Apple Git-137.1)
>>>
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
