Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62BFC61DA4
	for <virtualization@archiver.kernel.org>; Sat, 11 Mar 2023 22:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C9BE813CC;
	Sat, 11 Mar 2023 22:25:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C9BE813CC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SjU2VbC5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r5dhUbR3HKNc; Sat, 11 Mar 2023 22:25:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A8EF581395;
	Sat, 11 Mar 2023 22:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8EF581395
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F78AC0035;
	Sat, 11 Mar 2023 22:25:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 313C4C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE25D60BD6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE25D60BD6
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=SjU2VbC5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hw-lTgDo8i6e
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:25:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2674607C9
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2674607C9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krwu1Gj94c9yzZteSbXj6kBKGbi8dQqECnla19S5y03zu7Qs1C+SQBxiAOf+x+FXBU6a6pjQ3d1SlwLmql9BUHOeBGt+F7HiUEtqpo3Dca9lNA9XoeT4CfRaOGrL0TvBQiTB9MuTq2L3q8QwszD+qOfpA3iP8tt2A/qCrUv9x03pkDkn1lw/Fh6iMyCd/5ufCUHURxRR9IgOZDxVqp8ywRM8lZhjCG8d5qeQXtjc00YfizdQPwCEECWxbGr17f3SIGpWRDwKajWC/pxG0dXqfIyKMtaE3AcIjUJ3CTxqDsaszIJamYAvCPbYM8cY7+l41f4o48c4wC1HXVMXI4AkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro72EnG10TKrRZ6KDGqrW0uCgs8ifkpUVDLsoNGd6Pk=;
 b=L0o7rbO898PDTWgNQ+UC7a5Vds5kdMKe4+ycIDNcbJOsuz3v4N0jThwfKaysdrSE1wDza/F4g7Mfaw/1EgmgdP+YV/Ufpr2itDA2mfi3w7FggXI/laua+0N+U9RNXxVYwWZedhDZiUmxvO6g8T8gF3RPhLVdC70RuC78PnYY8YBJdVqeag7Mc+JdHlgZwf/f9xsSqbl/fTRopCzJeHbxZzKt45Dap+YOcL05E264u3agcIz1LwXmotCPPdgAoZfC72NHMC3jEissc4iWImZYiMJ+OT2gRYFaaMadLUzDPXVxsCyYgCkIksyNMX84dP6iG7PxEN5HUUpWh8JbhrZi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro72EnG10TKrRZ6KDGqrW0uCgs8ifkpUVDLsoNGd6Pk=;
 b=SjU2VbC5ioBklLLZEmSpCjOlSy+b4BswSo2V7wJYBBTzAmOe7Xpt3PGP/etQKV4sN6tHOPcAx3mKjiv0JBI9GtL5QYoDGmgeVgKLZqlc1ZRNWiqTPnrscKojQVhxXJLOM0UfC4W0MmqqR4A/j42iCYmoHd6MKt2GTmZ/9QCvUJvZtTHviUaJQKhAZHX2lPH6N23MqBgzD5jM3fhDX1tlJTdyvnpD3PAynLPuZrf7VECIqPrvrbmeeeHqyIrcsU93Twun2IcSwhnGWe1XzERgG1Dz2Ur9ikjeyYnAfJECP7xpX41EqdhgcN1qXoOgFyCxvxvCcPykl3JX4P9WWYiW8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Sat, 11 Mar
 2023 22:25:10 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%5]) with mapi id 15.20.6178.022; Sat, 11 Mar 2023
 22:25:10 +0000
Message-ID: <1bdcad80-eca7-9a6b-1375-1ddab3e6bae8@nvidia.com>
Date: Sat, 11 Mar 2023 17:25:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] virtio_pci_modern: Allow non power of 2 sizes for
 virtqueues
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310053428.3376-2-feliu@nvidia.com>
 <PH0PR12MB5481188C606714C32353ED88DCBA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bd763bf7-0b8e-ba9e-cbd2-a0302e820cc6@nvidia.com>
 <20230311140355-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230311140355-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA9PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:806:22::26) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 345f2bc5-1d38-4e28-176d-08db227f797e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPIf9XuU+19giOZeb4bUT22/DHJ+2p3y0hsdwgX64hUoo0ui5VSk2f6/ezff/PxabPc56/CB+3sRBiOZMxV3uekBlRpMOvFSQzzBKKWFoMxACFdKRp3PHqSOF7qkkrfQxSam8pE46/glExV3v09QMSScdrNP21pFjoEBXFBbQ3dgpStWAlGLPUv9dqzLRUivQgRgc3DjPzIhfaNYTRTlcVMekZqnGR5cw0bpc95turv9LPIXdoSlMvcFiMzyueWxQUeXKyNuVE95jqJ1UjUqWagIAqpvyyeKt6i8CvMyiy3VlJqe0+xlRirdhNLsnGjQalARTdxcu5IK9mramaJfygCX5vzcW9DJpDyHu157vBh4l58eqUaq3YTdENZtEJ0snEl03iL0YB4qId4XZN64RJ7fBS0j+mGRVAJj2v9SfOnp7nASpoF7PkI+8gkwX9mT280vTsPi90fF0vzr/dULQKoFjMXgR5DvMgGJ4rmixvk8u0NYpLpZTEZhzakbxvhnanCl9i2Vc9FWPuJ5GT+OIulko5Spj6rVEpETiEUuS3wX+JK6yiCdJEJS/OhRx2OjX3D/jwZ8NqQ8ovrpsu5hHAQCcwuXBX6jHBCPjMtZN6qcdYmYeIp1sN9kq6x8gDlzivkUA1hDOH5b1wVQWN0G+wx2GotrVBM4A/Bslm4gGCrb2sOH+kKc+XBJq4iKfQzB4ws+MUY8/ZAJG/ZtqJmZgnVJC88uY3yMIDbMLw2/bvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199018)(31686004)(5660300002)(8936002)(2906002)(41300700001)(86362001)(31696002)(38100700002)(36756003)(478600001)(66946007)(66556008)(8676002)(66476007)(6666004)(6486002)(54906003)(4326008)(6916009)(2616005)(316002)(186003)(6506007)(26005)(83380400001)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRYVHppem1FK28xdnM3eXoxczFJdEVQOFB6aEw5WG96cEErV2ZCUW5BYUNR?=
 =?utf-8?B?bkR6b1ErbHJ2M0tHc0haYnJEWmhiYW1sMDhqUnIzbEZ1NGYxT1k1dzFBUWxK?=
 =?utf-8?B?NGxSTGo3cmxkTHFqbmF4TGRoUGt0VzJzdkZHdGxsK1h6UEhLUWlaYzVvTjAw?=
 =?utf-8?B?Q0NSaFVKa3RuemdULzhXN3RUSGVUZ0hHeWNDLzhSd2RWeTVKNlAzRTU0L01B?=
 =?utf-8?B?K2FxNkZWQU45eGorbnd2d1JzNm11dkZEQ2N1c1A3c0FQQnFnMEpyeUx3Unh1?=
 =?utf-8?B?YWNUclJSZ3NBODl2U0E5VGIxSmhmbmNhLytYOUFXL01vdTlUdFhBVEtCcmw0?=
 =?utf-8?B?Mmk1ZzFOVlY0QTdKMHl5Z2RQZ3c2YS93a2VqaHQrSEFKS1RGRUpuY1lWWGdx?=
 =?utf-8?B?Q0pzYlF2b3JTdnFEelp5VlVxRy9LSFl2ODdYV1VlaG40L25tY24xS2NqVHRJ?=
 =?utf-8?B?Z0hPT09jL2tsalhFYVFQdXRCOWJEWmk5RmhFN1JPdWFkV3craW1lUTQyYjBm?=
 =?utf-8?B?azlzU0lBNUxqZ3R1RHpwRmVJVEVSZGJMYTc0ZzZucDVQTyt1cFIwZDlJc2Y3?=
 =?utf-8?B?R2dtM1lkVTF1Y20rQVdleU5FMk55T1paWkRxL3kyTjhXNHJHcDlEWXlvWGln?=
 =?utf-8?B?M2wrUXAyS0F1VTF4SXFEY2lHZU00ZDlRd3ZpVFRlaWhaVHBvdmVQcSt1Sm4x?=
 =?utf-8?B?dDJkblAwM0VPOTZuZCtJRkFqM0VkRmphR000REtXU3l6VHZtODNmb1p6S3Y3?=
 =?utf-8?B?NnVUZlFrRzFVS3BzVW5PdEhUY1NacUcyM0Q0SXRKU21KVUJuRm54Y2pFdnFX?=
 =?utf-8?B?ZDZRMTJDWWtIeVNydGUxWGtKcXNvMXpCMXVkNnJGK2JsMERDVGFpelVaRzND?=
 =?utf-8?B?cERmYmttVEt4ZFUySGtRYnFBeDFEaEtSU3V0ck5hUVhxdXJmRjNuT1lYWCtt?=
 =?utf-8?B?VlFxSEtJUGFvT2lGdkJTdGRQRDRoMG5CUktNR3hEYUk5LzN0R2tmeWgwWU53?=
 =?utf-8?B?emZjVWF2cHk4UE1haktWbFlQeUhweUxPZ3g5eVdkY1Z2WndhT0J1UU04bzd2?=
 =?utf-8?B?YiszbFlwV3dRdllYd25qMlVvQko1Skg4V0tGdGZ5U3VBNDkzdkh1UW5yRHNt?=
 =?utf-8?B?U2JoVVNDZ0hZZUhRTVNOT0RlU200TWVUVWROa2hLV2ZMNnRVT1EvNE1KbktN?=
 =?utf-8?B?cWtGQmVabExOUlZVeTFrNlpJblNBK3RKOVc3TGJMUVBPbGw3SyszS3p4T010?=
 =?utf-8?B?K2RHS2szLy9yZTROaFkxMnBhNE4zT0hYQUF5L0xGSEpKZnVBNFpqdEpJYXZX?=
 =?utf-8?B?Wlh4cWp2TW5ockRnaG9KM0Y0QTU2bDJBVEpTYjNEU25iYTNYZWh3Z0tZajRL?=
 =?utf-8?B?R0R1b1lPUmZpVGNGRjhWM2lHOTJwQmhGUEovNjlBaWpmT1lnWE15OGFQby84?=
 =?utf-8?B?Ty8xSXBVaDY4QnRMTko0YjVyWTEySFRwVEN0ZWlvU05PZHFQMU5IdExwV0xZ?=
 =?utf-8?B?QndDNTY5NDl2UUhLMXVxc2JpU3RpRU0wN3pXMUhsY3BFRVdVS3A0NDNXem03?=
 =?utf-8?B?K3ZUNzVqbVlHZ09QWFlCSWxsbzIvRjhsd3A5VXlJV0ZmWnBNaUN1M2o2K2d3?=
 =?utf-8?B?eUdGeFpQMVdrRUpPbWh5M3FYVVNOaFR3WWdTZTErY3JHcitlcFVRMzlST3RS?=
 =?utf-8?B?OWtUY1N1Vk1hS29MemZjbmltRFVveGhVV0NmMHRvY3FlWjhYSS9xSEY4dHNq?=
 =?utf-8?B?TUNMWkJzVlRoaEh4M3JDcTZZTFMyV0RhZXJNOU9EQWZuZmllWFEvR2ovcGxJ?=
 =?utf-8?B?M1RVVjJYdzlNTnh5eUloTWZtMUNJMk83YjdrR2xuR0RMR1QxeXVzdy9yUld4?=
 =?utf-8?B?QUV1eTFJd1N2MFcyOGFzZ1lwWEpDWjFKd2NUMzR3VFcvN05OaVlLSWJidWZK?=
 =?utf-8?B?ejNVZkc1OWhNcmkrazQxK3pucUc0bFdrWlpiZk01TTZyM3FYV2JEN1pUdHM0?=
 =?utf-8?B?ZlZTY1JVYTkyQmpCVG9HTUFDY1BZTDR5TWkvN2Y0bHZoMTFmRjYxM09EL0ti?=
 =?utf-8?B?UWNWQmNZRWFBOGVvQ09qNm54NFNKaFlBTWZZRjlnSmNadG5JQVliYzBCV25q?=
 =?utf-8?Q?W8IOoTboiRCuY9edqsSUbWZ6U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345f2bc5-1d38-4e28-176d-08db227f797e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 22:25:09.8960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pN7Vyb9Y8ARQySHX9V0kDmS8kDD//g/zSfTyza/J7L/MhWf2sgWmnhsD27gAEHd0XeFE60+T2jzqfvCzYsduBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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



On 2023-03-11 p.m.2:05, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Mar 10, 2023 at 10:23:16AM -0500, Feng Liu wrote:
>>
>>
>> On 2023-03-10 a.m.8:36, Parav Pandit wrote:
>>>
>>>
>>>> From: Feng Liu <feliu@nvidia.com>
>>>> Sent: Friday, March 10, 2023 12:34 AM
>>>
>>>>
>>>> - if (!is_power_of_2(num)) {
>>>> -         dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u",
>>>> num);
>>>> -         return ERR_PTR(-EINVAL);
>>>> - }
>>>> -
>>>
>>> The check is still valid for split q.
>>> Maybe the right place for such a check is not the pci transport driver.
>>> But layer below where split vs packed q knowledge resides and hence, power of 2 check can be omitted for packed vq.
>>
>> Hi, Parav
>>      I think you are right, I checked the virtio spec, only packed virtqueue
>> can use queue size which is not power_of_2; so, I think the check can be
>> reserved only for split queue here, something like
>>
>> struct virtio_device *vdev = &vp_dev->vdev;
>> if (!virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)
>>   && !is_power_of_2(num)){
>>      dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
>>      return ERR_PTR(-EINVAL);
>> }
>>
>> I will fix it in next version
>>
>> Hi, Michael and Jason
>> Do you have any comments on this?
>>
> 
> Hmm good point. Which raises the question: so how did you test it then?
> 
Hi Michael

I will construct a non power of 2 size packed virtqueue device to test 
whether the driver is loaded successfully and whether the traffic is 
normal; at the same time, I will also construct a non power of 2 size 
split virtqueue device for testing to see if an warning is given and the 
driver is loaded fail

The method of constructing the device, such as the reply steps in the 
previous email

> 
> --
> MST
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
