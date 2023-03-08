Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AA7C678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA778611BD;
	Wed,  8 Mar 2023 14:35:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA778611BD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iYbhTvnF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ALtT1FhZyuLP; Wed,  8 Mar 2023 14:34:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2AD17611C0;
	Wed,  8 Mar 2023 14:34:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AD17611C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 124C4C007E;
	Wed,  8 Mar 2023 14:34:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A3C3C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BFD041877
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BFD041877
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=iYbhTvnF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cmMg0YJspeOl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:33:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF2224182F
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::606])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF2224182F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HD4rfxPsr9gzmUyMdN8unPk2/XD6RE2mKQjwsF6spBgYS+PS7PIr2OMkIGO4ucc3Tc2SwAZtzlZmuXmM6NdlT1Gkr2n+iZ3IvrGE3jAhmfJbYJn8tSaqizctLwv5GAG51Pp6Edrd2j+5BVmH7HLAN74eBMtAh9FITgTJFZJJaALZMntZW3EbbN6VqJGL6VswEvv5hlSCx9XWwqXsMCSKAvkQmiUDlUl9LJnC+yh7qywZF3xRxFD9DkT4VWlVGBYoaIaEoWWIaEZ1b6yi3jkIXg4nv2DFwKg2yUjz9XoLKvINwr8NavNIqS4DvAWbYvY43MiQ3pQfxoBU91qp9m+O4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsNWQMl0SS88bVuYYlmYhhz4kIrM+M1PP0VVXb6SeKg=;
 b=A30fJu9Ov/IudtzchdqVtl83BrUxb2N71rjn9utgQNguDdU7LR/5/rt9VQrHKuCRy73CFSnRwnCkidLkW36G1HZlIb1qbOMOlULuzRIxHFB1Zt0UDjs3t9RnT8ppAmoBUj3H2Qg+GwtgcbOp9oIg5FM4rgJVwq/5DLaU6R/GvWH1/urUOD4/PSdMQ9b7PF8xds3YVdLP8ua2psj4t1wEyjwOgY0nmYYxsbGizgJzlydXTFNQjrMoSzBpGmDSjpWPffLOtw3GlEm5+vJ1T6HmKDOI22oU9MUfxKWFGDSAWn9aGYTjrO3cTql4oxSXLvhd+fTzD93QOa7M7QwDpbTpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsNWQMl0SS88bVuYYlmYhhz4kIrM+M1PP0VVXb6SeKg=;
 b=iYbhTvnFt7Wd1hy0I5u08iRNc5QUwv38DNtzK1LfUR6mAgpsRwnRAnSHdtam3XZP6Gs0rKbmjLhlZnP3jhs3X954Yla6mP6VDu/uqzwLeAx32RmBI3xNB4UCiDMti2CjukMURWizthKZyqz/eGK3kDbk2FSrzjYP5j92o+meoL0NJjhLt4ycpUDQcfrkwvA6Nx1UpOjEbqj4FOJ6L2ZKN9M5qn/U2OMeSEgOJDJkmDkkwftXS8uTwDAyiFMabVNUksMo3HtrPmA3i9jrIQ7TPGtNnOhY9H8dyFB4GcJHB/q+iv2G0R7jUq9ukbGkyW++CVfhhYQEec/lLhrkzYHj0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 14:33:26 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 14:33:26 +0000
Message-ID: <03e9a8e9-fdb4-d7b5-59b2-da8b8ce4e0b8@nvidia.com>
Date: Wed, 8 Mar 2023 09:33:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] virtio_pci_modern: Remove unnecessary num zero check
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-2-feliu@nvidia.com>
 <20230308091704-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230308091704-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN6PR01CA0028.prod.exchangelabs.com (2603:10b6:805:b6::41)
 To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|DM4PR12MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bb6662-1258-48b2-703c-08db1fe21415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sP86javFbFD3mwTFsXr0m2qPuOElZ1rbJDEKpmnUyg1zbWNQsFkArxd6h6tN5IO4vi2R5oMY2+iStJjwNdW8QX98z3MTPUN6XEx51r2PFMOhVrxDwu8h/7u8E7ovDTFAynoKkNBkciNm7fvKEHyyd9Pyzu1z0EFUBHL4awfRUvCBLTUohX0PSmInSCRFpTTFv2LWeLrsTR9S7wC0tRrGICeukrBaTMNg7RFLUJHGgNYKiM4z7K8lArtK43sH0ROqmORkh1JNo9EasjCTQQ4wzeiF4R+bJjj/xFbvTHBks7pjP0wz3RFhxvd1BNKYuMGyQ/rMDGRL2vjtbnAiQYb1fYJ9dEyckNH43iPVONFUw7BrnzwrG/dlWNXZUdd4Lwzg1N9SXINl7qKCxy73vmQNJVUh3yaXdkxoVgyxyaJB4z14eLkEvsdJ68py0xnAiMpH1xLieevoUUQ0Vh5y3JL9cenDw3FP8ji7BK/G9lK716AxavfVUdy+lXT8EED3rOvB1rsQC1eBuPysxcym1YHTBWUhPmWDuLgAXONVGzQRh9Ii6cQI+BBCAn0nEj39n69N92hZ51nD4Hgaa366juUT6T02WAmAP25TkN/A3cvlpFnGk1kRqt97qlx0pHqjEv7Klar4di6y8zZxB4HM+PAUyNB24/REGhlvYO/hfIxiHaR8EtLeCbORRbvVMEftLr1prTFRqDBvRKrLDler3kNEbPpqDTWOewevUZvd+B7756w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199018)(36756003)(316002)(54906003)(478600001)(6486002)(8936002)(5660300002)(2906002)(6916009)(66556008)(66946007)(8676002)(66476007)(4326008)(6666004)(41300700001)(107886003)(86362001)(38100700002)(6506007)(31696002)(2616005)(26005)(186003)(6512007)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVREUFIzek1MT1JUYmFnWEh2bkQ1ejJ2a0hNZzlsNG54VE1vNjBVV2VEUEZu?=
 =?utf-8?B?ZjdIaFJ6Z2VpbTNBNTFCODJXK2RpZ0JZRXhpWlIxRm8rdXBoZ0Zqc1lUS29Y?=
 =?utf-8?B?MXBTMGFrT2laTlM1TldINFQ0ZHZ0L3o0OWdqVURWV0tKeWpQZkJ6TDBLYVd2?=
 =?utf-8?B?VmZBYjM4K2I0QXRQZXVJb0hCbElBWEgxTlQ2VTJBNnpFUWhPRGNFbWU1QlZB?=
 =?utf-8?B?SzdmNzlTcC9HM00yTTFVV1VEbzVFWGtvN1FoQUZUTVBEZWJkUWxEZHUvSHZu?=
 =?utf-8?B?eStGNlR5N2laZmN1cnZJMmlCc3R4WWhMejBpVUtMWjlid2taR3NCd2pSUGRt?=
 =?utf-8?B?RHN0TGg3TGtQNlc4eGtsc2dPT1E3Vy8rWUxHSXNMUHg3NmMzTWJMVEo4YjFX?=
 =?utf-8?B?ekxaVkg5aXI4YVJzVXJ4d3B5S20yS2IySnZtQzVZd2lXd3c3Q2dzRnIwbTJY?=
 =?utf-8?B?c0F3bHdLaGsxYkdBcHZwcHk1RVRwUVRHSk5STTQ2Umt0U3J4d2x0Y2tXcWV3?=
 =?utf-8?B?RlZNR2twRGJuUEtQdVdNZVNFWXVPMllsa21yY2NRelpMN1MyRkkxNkt2VGdC?=
 =?utf-8?B?MUFQS3FranpEODloU1UzempOTGRGbUFRVHhPTFI1ZUlHeFBnQ3pZeVE1TDZZ?=
 =?utf-8?B?L3lLNjQzeThBaVY2ZkFlNTlKZE8xbENSS0QyL0d1S3V3dENzR3RWUDRBZTdI?=
 =?utf-8?B?S2I2S2ovUXNoTk5lVzdYRWl6MkhoL2dXRTRsUVdNU0VxQnhNdm8vSmd3STk0?=
 =?utf-8?B?QnlOblVxQWFNcVZ2aGR4TWtIbzZ6WkhlT1F4NnpyVklzN05lbTdiM1Boc29Q?=
 =?utf-8?B?NStXYm83RkozNTNIbEEwOWs3U296ejYyaDNpT2FUeEU1dHY3MEVsTmZsdEdj?=
 =?utf-8?B?TlQxZTBGWExyWkpvcEhJZC90QWloN2FwY1hSaWtUQ3lzTU5nd05DQndtUzZa?=
 =?utf-8?B?U1cxNnhnLy9DUVU5MU04d0VhVmt2NGlqMERRNnJNdXc4RkVpVGRNV2ljRVIr?=
 =?utf-8?B?Y3U1VEcvUUR1TXplTGNuQWtyb1RuOHphelJtR3RWR0JSQm5QZ3Y5VHJISStS?=
 =?utf-8?B?ZHk1L2ZBVjdvbno1aTlRNmNSK0dVSEQ3d2kxdEtWbDhqcUsrTEN2Z1prVEQy?=
 =?utf-8?B?VThMQ1U0U2dabHZvZFcvMlJDbGNYN2lDdFJrRE5FTmUyRFBkVnBQaUtSWlBR?=
 =?utf-8?B?UExDZG1abWViUVpXd2RMMFd6a2JhM0J3OWVjTXl1K0ROWGJIWE81QnlqMmpT?=
 =?utf-8?B?ZzFDMWUzMnFEVVErbUpNUTkvR0RkM3ptS01QSGZuOFQ4L3ZvdUxnK1ViekRK?=
 =?utf-8?B?YXlIdWNGSytlZXRCRnRUM2lqN3dBTmpDeUE0UWN6OUpMSjdlQUtpaFVoVitt?=
 =?utf-8?B?dCs0NFRYaWtoQmhYbThOVkpVUGhhOEp6T3pTVjM2cmpFUkcxcnVnNmliMWU5?=
 =?utf-8?B?cXlLVE9Yb3p1dGpRMEwyUUFPVWxzNVlXaHprMU41Vkt2ajZHN2Y0ZHQvVXFi?=
 =?utf-8?B?VFNyMTlic2hJbzkraVNjVHNoWVRqalBPMWxTK24yOENJTE5tS2FlL1dRT0dC?=
 =?utf-8?B?UmFTS0JRU0hCZ3E2Vmd4cHUwNHRHUHBudUg1dUI0ajNOOVIvTGtuNUltQVhM?=
 =?utf-8?B?dlVDc0NRb2N3WnZXNDdLYVBwS2VBSGJyTkFaZVU4eGM4TnQwdWVFdkZjc3ZZ?=
 =?utf-8?B?NFloWHZMVGlMa0Q5Uks2ampyRFM1MFRyZldnSGVjVVBzbUFBaXFNREh5Mzdw?=
 =?utf-8?B?RkR3K3BQQWdiSW44QVZEcEt6am80UEhUOUg1YVpPMSt0ZWlCY3FyTUl1eXc1?=
 =?utf-8?B?SElSQ2RVR1pZMWxHa05STjd0V2J4eXJrdnlZNlhyOHV0T1hkODBDTng4aEYv?=
 =?utf-8?B?aDZhc1VWTTlLcDhBMi8yemRZWHUyZ2x0SzFDZjBSQWVLQ2RIRG5TVVNxVXpl?=
 =?utf-8?B?WWJ0RFZaSUdadG1xREUyKzczNzNpQlg1ZGg5ZnRXVnViT09oTnB3QXBDdmgv?=
 =?utf-8?B?dHorYzhEekVUYlB1ZndqdGV0S1JBSDN5VnpHcjFFSmNtUEpoa1YrUXJ3YlVj?=
 =?utf-8?B?aU1XWWVGNUl0Mm12dTBhQnM3bFZBa0dsRFpEb2k5WGRtUkp5cVZyUmJFSDE5?=
 =?utf-8?Q?S8VdprBe7dsmEGEeYuezmiXHw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bb6662-1258-48b2-703c-08db1fe21415
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:33:26.4482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQd+DqmyoFLC0fgNYSFSDXx7t6zr/07Y2xBgIbt3Nua+wkh9Udjl04p58wADZAn82tKegSvCOtWPyC46E4o7Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
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



On 2023-03-08 a.m.9:23, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Mar 07, 2023 at 05:57:03AM +0200, Feng Liu wrote:
>> is_power_of_2() already performs the zero check. Hence avoid duplicate
>> check. While at it, move the query of size check also adjacent to where
>> its used for the disabled vq.
>>
>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Gavin Li <gavinl@nvidia.com>
>> Reviewed-by: Bodong Wang <bodong@nvidia.com>
>> ---
>>   drivers/virtio/virtio_pci_modern.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>> index 9e496e288cfa..3d7144f8f959 100644
>> --- a/drivers/virtio/virtio_pci_modern.c
>> +++ b/drivers/virtio/virtio_pci_modern.c
>> @@ -306,10 +306,10 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>>                return ERR_PTR(-EINVAL);
>>
>>        /* Check if queue is either not available or already active. */
>> -     num = vp_modern_get_queue_size(mdev, index);
>> -     if (!num || vp_modern_get_queue_enable(mdev, index))
>> +     if (vp_modern_get_queue_enable(mdev, index))
>>                return ERR_PTR(-ENOENT);
>>
>> +     num = vp_modern_get_queue_size(mdev, index);
>>        if (!is_power_of_2(num)) {
>>                dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
>>                return ERR_PTR(-EINVAL);
> 
> 
> As Jason said the right thing to do is to remove the power of 2
> limitation. However please don't just hack it up and post,
> test it with a variety of queue sizes and with at least
> PAGE_POISONING and as many debugging options as you can
> to make sure this is not triggering bugs anywhere.
> 

Hi Michael and Jason

Thanks a lot for your tips. I'll be working on these things and fixing 
this in the next version of this patch series and add testing info

>> --
>> 2.34.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
