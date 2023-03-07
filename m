Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A94C6FA99
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 21:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BB6581250;
	Tue,  7 Mar 2023 21:18:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BB6581250
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=A9nzz4Da
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n8Aukl-6qcgs; Tue,  7 Mar 2023 21:18:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A2E3680EAD;
	Tue,  7 Mar 2023 21:18:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2E3680EAD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75D21C0071;
	Tue,  7 Mar 2023 21:18:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48FC1C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 21:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB399402B3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 21:18:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB399402B3
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=A9nzz4Da
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qINrY6sgpsOh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 21:18:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9A7640201
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9A7640201
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 21:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu/vWjATuo73UTP8ah9+aJAzVML6yI1gJQQVaaMcSeKT+ONDe9PAEwgth2wOgxAs5c9W3lu/Z01ioOSX+gOwjLyQr07P3qUz6lePcypc5LmRV9LW5eDSURRb62Br2gWPTvrt+0Fl/ra4hJZcxkEWhumq4oyiVLrgCkitV97qc7GiWa8gCCp4OwgXr/M0jUDQkWX1P4ZUiWfPY6+fMrA35QiiFKCMFq7QIwtQ0WqeeKcEE6TLm3yjzdo2hLfPfPce+PWxN9OUew+YAuFsYA/kVcijjScE++crVJfkX87NkKzeY9QMycK+U7kT+pBS8BQzAmFRzxcwkiV673QgLVmHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pCX0ysYyeFvsvrXx7igXfXYBwff80+09YKWWPsTO+I=;
 b=SgE2bDpI92MqyR2IPt3grmiSxUz8NEvqtjPzDysXcOPaiHW9b68Yv/TTnvTwus0GYWIhA0GXJrRJoJGjQ65SrkGx/mKz/ASZBnMslQuJ2sHaA+E3Lbcyw3uYbdPMnwKkgM0evAKR51ulJ99XIqnrnGagG7Q+3DJztOmq2IRnWB/XhjqHhJAjssa3i02sKJFVKVZL1GBZCX3Mbvp74ECAlASe9wE1x/lj+IPxYzclDByKky2LS6ROLs1KlKAoh///hp9jZY1L0TViEGu4vpCN4Fqi5bTHobLldA+UUEalaTj9TqkcPN+1G1Lg+hMNqiq906fol4g0nN/pi3D1isknNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pCX0ysYyeFvsvrXx7igXfXYBwff80+09YKWWPsTO+I=;
 b=A9nzz4Da94eELt52WFmwjFP+lI3f4MnC246s/pgpMByrRZJS4v7w8TksH33Cyw1G45utf300gv+2ZXLrbe48Uf6260/uDLLMggddjlzBcYpkQBc4dHErYPVLsX0SLV7R+S/4RIDimohh2cT+9xJCwMe80/n7Hg9ZeSxQfSjKJGPo4nKyjBDpShLctdrvVCIDsNQGSuGqdaIJ6WPPsLjlR1rxO33kEVlyu6bGuJPEJOpRk1Z9wLOq3UA6skg4bY4FNN4icDK78KrRyKONyCQCBAodGXOj5Fgu/SXhJdQUa4OrGVXYLc+dBj0kH5UYpREYBo/Cwp5Pq7FRzqJPW8vheQ==
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 21:17:55 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 21:17:55 +0000
To: David Edmondson <david.edmondson@oracle.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Thread-Topic: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Thread-Index: AQHZUKjxjgj4Y4Op00KmXx35KvS70a7vCQMAgADKOgA=
Date: Tue, 7 Mar 2023 21:17:55 +0000
Message-ID: <4e8d1e89-9b32-8dcd-acd1-6957f13fcbb9@nvidia.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com> <m2ttywzzxd.fsf@oracle.com>
In-Reply-To: <m2ttywzzxd.fsf@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6201:EE_|LV2PR12MB5821:EE_
x-ms-office365-filtering-correlation-id: 0b1bc2f7-0465-495d-8bf6-08db1f516b17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +LmLxlMDAqLU5EGPzvpqzxc+tkotHewXC1Z4zc1Jv8NX9EgPHOUEiMP2SyZO+mPyulKEEsKQlDUJtrCPUncGU7Pm4M1hKhDLSI+QWYb0xLXhcCqkTrdISswp5FtR9x/fo+HPIvs7z5+bokp0TtTV3auZ9/2ZcYarYx7785PAGAfuJLxozzqC8Hc2Eal7dEPc0+9nzuXqoU5IqukFSZpOfkdkhfwo2gJFSoJqGwSDKFBKwtYyoKaT48agFdUZO0L6uXJ9xYYSwuhSMUDQfSFt8R3Toe/EuSK3eP3SyAJql1hCKyN9gnW5AcYcs4BRNBumWQe5xj0YunG17XfIRn2RYUHPPFrywgjKiL2dq6WmjvECR425WEnsYKwLtRJDHndb8Ln+GmyTOiRIUBhBBQIKEQUZdDUfJIlyQ39L3jLWSbj60Uvnhs8tRonZKt8SLZQ4k3uTrlEMy2PAH4XYu+0Ii2HletWW+TvXxhr/KGFEppYNIOMTuT0cy3O/cMnyrdeIDjb+bd8GLgeUWUwHKYCaUNOcnPbYjgGhz98bBWq/0RhquvOdXVBgCPr6ji3owRWY3ZAfecQTsz+kcvUhahxdfvFhQCvMFIM24fmUWk7sbLvA2L4YPpOjr7ZRJQvc6J5lOjDz9EhKBbOO2zM0Npp/XFTlK0wQzQ51Zp6ZOo9bMqUbfkGVW70ACybkun+8dQ7dbQ5EjCTeFWX1LFZM5R+UzDWMuo9wg74NXkbUBXStF04=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199018)(31686004)(110136005)(54906003)(316002)(36756003)(83380400001)(86362001)(31696002)(6506007)(966005)(6486002)(186003)(76116006)(2906002)(66476007)(45080400002)(66446008)(71200400001)(66946007)(41300700001)(8676002)(91956017)(26005)(66556008)(6512007)(55236004)(64756008)(53546011)(478600001)(2616005)(8936002)(122000001)(4326008)(5660300002)(38100700002)(38070700005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWtoWU84WndGbCsyc2FDK1EvN3M3aDV4bnRSVkdUa09pVk8zQmRqbnFtZmxO?=
 =?utf-8?B?dFc2NjB4M2ZXZm43L2UvcHI5aURnNVpxQnE2OXN2Vk4vRW5oRWQ2RnFPWlVl?=
 =?utf-8?B?K3kyVUFna3M4dWlYSTc0RkFGTHMwcklpcDg4ekVucEJMdytSbGlTb2FZUFdV?=
 =?utf-8?B?a2JUei9yUjVOSkEzcmthMFErRUpzOWxTTy9maSt0OTJMMmFiZUFhdGl0OHJB?=
 =?utf-8?B?NEhYTm9nMDJSSHFYMGdVVDQxSUl6a0Ixd1phLzRQTnhrNjRLeEpmS0dwcEFF?=
 =?utf-8?B?ZFlHNm5pRlIxNXZTUUFtTDNDb1NGQkMzMnZYa1pxbXJscXhEVUIyRDgzYnZ0?=
 =?utf-8?B?VVQvT28xYXhKZEoxNFhkaXRqWUhVcnIvVzBUS1ViSlpROHcrOURFekQ1T2FH?=
 =?utf-8?B?OFJWNHl2Z3BqakwvOWowRlRwT2Q2aUFIVER3V09sV0lJOGU5VVdRTlJvOEVU?=
 =?utf-8?B?OFFJTE5hR2lFcm9CamRsTGtrOW9MRjUrMFVmK3FHd3RaNUlkdlJ1UDZrWVVB?=
 =?utf-8?B?bU1sczZWVEhCSjIzSStxNWl3QlJueWczNGk4ZWg4SDJrb0N3VzhtN250ZFE5?=
 =?utf-8?B?TEZuNTFaVC9UeWh4aXJwblpuMWVCU1d4M3VoakJVek4yd1htT0hzTTI0NWxH?=
 =?utf-8?B?L0F5K3BKeTI4TlNzcElMbnF1ZG9XcG5rYmVSbUU5K1NVSHRzd1V6QXo5ZkNq?=
 =?utf-8?B?UktadlFqUmpEV1c4R1BaY1ZnRDIyd01qbFVpeE91OHROa0UySER2MEtGbjlv?=
 =?utf-8?B?aGYyT3VmMnhDYnpSczVNM3I1Zm5WSHRjbFFCdHM2TzhuRjFpZ2dSUnBzWkl2?=
 =?utf-8?B?elY0WDdFczIwcmRkWXJiekZoR29iRWdRNDMzYmYvWjFXWlhvbWpmME5ZS2Z5?=
 =?utf-8?B?bVA4eDk5MUR4RzNZWVRMRnArUTdSNHdqN2o3UDNraVhHb01KbUlEM2E4UFdj?=
 =?utf-8?B?Y2RMYzBnYlhpUTAxNXF1Z01yK3pqTGVPMElqVkMxaDZCL292TmFJWHl3OU00?=
 =?utf-8?B?VjEycHBkRFZuVHBVWmw5S0FMWjZ5b3k5dUVjNFZiWU5MZ2tpd2dXbnlzZ1JI?=
 =?utf-8?B?U0cyUkltdUNud0t5VVF0WFJNQWwycXdrUUxrMWpIdkhYSlR1VEE5Um5lekRH?=
 =?utf-8?B?VXc0SnloeDRaRDY2QkRyNGwvNnhHd3pDWFZrdEZxMXd3UmRqMHJEbGJSd0ZO?=
 =?utf-8?B?YkhCcGNxUDVrU1Fvdlgxc2Vvd2NlbTFZem5reDZQUUlTbXRhZVRuclUrUThT?=
 =?utf-8?B?bjJkOWtiZEZlWTBpcXZHRHRnRE41a2RPVGRXUS9jcDZVVTlUYmdJNms3SW9Q?=
 =?utf-8?B?YWhHQTFTNHhGYkFncDFxMkVxR1k3NlEvVGdoT0VsODB4UllERjNnSTlBWkZI?=
 =?utf-8?B?ODVFMkxYM25EZnFZME1oNDdIM1VZRm5DcDNFWFB1cTBOR1BQQmZXNEt2VEIx?=
 =?utf-8?B?T1RWVWZZZFBSWTBxdGtxWWRJQkhKa0FIK2x1UGtiVmd0QkFhaUw2MFdqMXpo?=
 =?utf-8?B?Tmo4NmhJSGVqREdsTllUTVhranB1cm1EYkhxNUVNVEhlbzQ4VjRuL0NkTlVj?=
 =?utf-8?B?V1c2cTFZbmZGeXVTWlJ0YkI4SFlndE9Db3dQb1p6TFoxUkxkQWFaNHQvaGRl?=
 =?utf-8?B?YUNaakVJbWFYUldVUnFWOGNtYjZ2TDc2Ni9RR1lIcGpTK2lGUGZneXlQRDBI?=
 =?utf-8?B?azg2NSs4cXM0WXNSV1QrOXZpZ3NtemY2dVZtRzNOanRkWHZXRS9DTitqMlVM?=
 =?utf-8?B?Ri8zZjg3TmFTNGg0RkRlSkZHM01EN0d1dmV3RGp3bSsycUhrUjRzOXhZNlJI?=
 =?utf-8?B?UjVNdTFHUEhCR01nY1BFT0wycGZXZSswTktrdjlneGNmTno0aHZ2WHJWTWNG?=
 =?utf-8?B?aHhqYlVGekNncEVwVUc3OXRHaEVIaWRYUFdQU003NTFnOHBEejdpbllpY0FO?=
 =?utf-8?B?R1RndEpXak5xdDB2dnZDZ21KRk5kSC9KMittUmhVZzU0WE1uNVVzK1lxM2VF?=
 =?utf-8?B?eUxhOTdVRnFIOW05STBYdm1VSUg4Yjgyem9QbGl5WXVwQ3RydFBkSVF0eklP?=
 =?utf-8?B?ZTd1ejN5ckFibkxqNW5iSDNVV3AzdzAxSm8rcVNrL1VlNG8yM0h4clR4dTE5?=
 =?utf-8?Q?7mmU=3D?=
Content-ID: <577C353A76643C4EA264D4A039924D8E@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1bc2f7-0465-495d-8bf6-08db1f516b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 21:17:55.2261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmZvhjjsxZ2W12di5FI6Tl8xQh7sZqVMX3dGLTS8jM4l82HvWgHJnVe+/d0PSBX8995rWOeWDiRlWuyO2Nc8NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
Cc: Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 "feng.liu.kernel@gmail.com" <feng.liu.kernel@gmail.com>,
 Gavin Li <gavinl@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2023-03-07 04:14, David Edmondson wrote:
> External email: Use caution opening links or attachments
> 
> 
> Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
> writes:
> 
>> Add const to make the read-only pointer parameters clear, similar to
>> many existing functions.
> 
> In many of the modified functions the local variable that is a cast of
> the argument could also be const. Is there a reason not to do both at
> the same time?
> 

Hi,David

In order to prevent the content of a pointer parameter from being 
modified and increase the readability of the function, it is recommended 
to add the 'const' keyword to the parameter. This is not necessary for 
local variables and non-pointer parameters, as they are only stored on 
the stack and do not affect the original value or structure member 
passed into the function. Therefore, in this case, the 'const' keyword 
is only added to pointer parameters.


>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Gavin Li <gavinl@nvidia.com>
>> Reviewed-by: Bodong Wang <bodong@nvidia.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 25 ++++++++++++-------------
>>   include/linux/virtio.h       | 12 ++++++------
>>   2 files changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 806cc44eae64..8010fd1d2047 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -233,7 +233,7 @@ static void vring_free(struct virtqueue *_vq);
>>
>>   #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>>
>> -static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>> +static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
>>                                          unsigned int total_sg)
>>   {
>>        /*
>> @@ -269,7 +269,7 @@ static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>>    * unconditionally on data path.
>>    */
>>
>> -static bool vring_use_dma_api(struct virtio_device *vdev)
>> +static bool vring_use_dma_api(const struct virtio_device *vdev)
>>   {
>>        if (!virtio_has_dma_quirk(vdev))
>>                return true;
>> @@ -289,7 +289,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>>        return false;
>>   }
>>
>> -size_t virtio_max_dma_size(struct virtio_device *vdev)
>> +size_t virtio_max_dma_size(const struct virtio_device *vdev)
>>   {
>>        size_t max_segment_size = SIZE_MAX;
>>
>> @@ -423,7 +423,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>>    */
>>
>>   static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
>> -                                        struct vring_desc *desc)
>> +                                        const struct vring_desc *desc)
>>   {
>>        u16 flags;
>>
>> @@ -1183,7 +1183,7 @@ static u16 packed_last_used(u16 last_used_idx)
>>   }
>>
>>   static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>> -                                  struct vring_desc_extra *extra)
>> +                                  const struct vring_desc_extra *extra)
>>   {
>>        u16 flags;
>>
>> @@ -1206,7 +1206,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>>   }
>>
>>   static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>> -                                struct vring_packed_desc *desc)
>> +                                 const struct vring_packed_desc *desc)
>>   {
>>        u16 flags;
>>
>> @@ -2786,7 +2786,7 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
>>    * Returns the size of the vring.  This is mainly used for boasting to
>>    * userspace.  Unlike other operations, this need not be serialized.
>>    */
>> -unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
>> +unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
>>   {
>>
>>        struct vring_virtqueue *vq = to_vvq(_vq);
>> @@ -2819,7 +2819,7 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
>>   }
>>   EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
>>
>> -bool virtqueue_is_broken(struct virtqueue *_vq)
>> +bool virtqueue_is_broken(const struct virtqueue *_vq)
>>   {
>>        struct vring_virtqueue *vq = to_vvq(_vq);
>>
>> @@ -2827,8 +2827,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
>>   }
>>   EXPORT_SYMBOL_GPL(virtqueue_is_broken);
>>
>> -/*
>> - * This should prevent the device from being used, allowing drivers to
>> +/ This should prevent the device from being used, allowing drivers to
>>    * recover.  You may need to grab appropriate locks to flush.
>>    */
>>   void virtio_break_device(struct virtio_device *dev)
>> @@ -2881,7 +2880,7 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>>   }
>>   EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
>>
>> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
>>   {
>>        struct vring_virtqueue *vq = to_vvq(_vq);
>>
>> @@ -2895,7 +2894,7 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>>   }
>>   EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
>>
>> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
>>   {
>>        struct vring_virtqueue *vq = to_vvq(_vq);
>>
>> @@ -2910,7 +2909,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>>   EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
>>
>>   /* Only available for split ring */
>> -const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
>>   {
>>        return &to_vvq(vq)->split.vring;
>>   }
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 2b472514c49b..36a79374e735 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -84,14 +84,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>>
>>   void *virtqueue_detach_unused_buf(struct virtqueue *vq);
>>
>> -unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
>> +unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
>>
>> -bool virtqueue_is_broken(struct virtqueue *vq);
>> +bool virtqueue_is_broken(const struct virtqueue *vq);
>>
>> -const struct vring *virtqueue_get_vring(struct virtqueue *vq);
>> -dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
>> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
>> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq);
>> +dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *vq);
>> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
>> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
>>
>>   int virtqueue_resize(struct virtqueue *vq, u32 num,
>>                     void (*recycle)(struct virtqueue *vq, void *buf));
>> --
>> 2.34.1
>>
>> _______________________________________________
>> Virtualization mailing list
>> Virtualization@lists.linux-foundation.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.linuxfoundation.org%2Fmailman%2Flistinfo%2Fvirtualization&data=05%7C01%7Cfeliu%40nvidia.com%7C6265cc6ac03e484167ba08db1eec5428%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638137772595544505%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=74eHEHUMF89nTG6hrrdMpkl43DJWvC9xCjwqNOny%2FQE%3D&reserved=0
> --
> Woke up in my clothes again this morning, don't know exactly where I am.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
