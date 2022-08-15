Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6B0C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 13:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E3704042B;
	Mon, 15 Aug 2022 13:53:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E3704042B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bviOS4ni
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2GX__oNBdiSZ; Mon, 15 Aug 2022 13:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B7F6440AE2;
	Mon, 15 Aug 2022 13:53:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7F6440AE2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64316C0033;
	Mon, 15 Aug 2022 13:53:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17DCBC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BCEE840AE2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BCEE840AE2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jfu5dUv_wkur
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:53:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E9074042B
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E9074042B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4DXpOZJyZEVV+Sy4dcjJWakbhyyEpCP/xhDU8KkQXWk6qc/bWEQ7s8zTk/tGAKRXEe5FU6oUweMU9grrS8/ZhfPas19gYO188DH61AhiOL+lxEzhdO5i1i4J2IAkeHdoxg2IlRhwdCQ6kC9ARsQnRCsbhmXWoLuYOZ0ul8DzGedVaCOeGZz8scjXLtwUEFof42oTYixeo1dIUenE437xekLQ9qapgwW3J4Jg4jeWyZAEQ4Dx12aX9jxSdM9BXz0CE2MVLunFaaUoWTeCmtT8swEHjokgm/h47qJiJyQbTZBJK5f2tpLgzLZyLHeYvoCU/XKaVs43DctyXN9t2HQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzQIBALnW6s2lDAfI0j23heQGt76yt1ZxYeMUwho1Oo=;
 b=l6L0TjiEpyZ639mfU64CLyWMYbexzkLG35tO7JJQH+H/mqJdyXWVJkhaLU1Rw6KvXflKGGW2ruC5+eCXODNRcLV+PCuOBLeID3dL9myO9TVE55ITjj1RXx1KfdGZG49yVSCgBOhnFBuionRBFZkdynQ9UrZUkWjCzbLONrx7nJGBmiifjFpj/vLy1901p+ZsadWJP4EqSA1K2vmU2WeCeJC3aNi6/2ZGg7JM8r9ygT3+tCv2Gi/yWahhHhuCuGizyuFlqCyCL2vLESrR+Ypd3qU/YBacrqYepCjemLmjBZy6wLFDoPRnlecb0DfJokP8HB+/bII724VkqFtgQtLvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzQIBALnW6s2lDAfI0j23heQGt76yt1ZxYeMUwho1Oo=;
 b=bviOS4nimzv/ls3bDsshSS4a33Bdowem0pmLD2jUnCXiq1DiLoev7n4Tq0a+gz34lrfcJuN7q3ObuvI59bVJ+yGk9UibvtDhfAQxdAA8zQRsrPo+oCkp6kBaknF9PCq7I+4CMLRp8CAQeobKcFer4QkEuZerUBDq5QWgirsAoas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 13:53:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Mon, 15 Aug 2022
 13:53:47 +0000
Message-ID: <73e5ed8d-0d25-7d44-8fa2-e1d61b1f5a04@amd.com>
Date: Mon, 15 Aug 2022 15:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] drm/ttm: Refcount allocated tail pages
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Trigger Huang <Trigger.Huang@gmail.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20220815095423.11131-1-dmitry.osipenko@collabora.com>
 <8230a356-be38-f228-4a8e-95124e8e8db6@amd.com>
 <134bce02-58d6-8553-bb73-42dfda18a595@collabora.com>
 <8caf3008-dcf3-985a-631e-e019b277c6f0@amd.com>
 <4fcc4739-2da9-1b89-209c-876129604d7d@amd.com>
 <14be3b22-1d60-732b-c695-ddacc6b21055@collabora.com>
 <2df57a30-2afb-23dc-c7f5-f61c113dd5b4@collabora.com>
 <57562db8-bacf-e82d-8417-ab6343c1d2fa@amd.com>
 <86a87de8-24a9-3c53-3ac7-612ca97e41df@collabora.com>
 <8f749cd0-9a04-7c72-6a4f-a42d501e1489@amd.com>
 <5340d876-62b8-8a64-aa6d-7736c2c8710f@collabora.com>
 <594f1013-b925-3c75-be61-2d649f5ca54e@amd.com>
 <6893d5e9-4b60-0efb-2a87-698b1bcda63e@collabora.com>
In-Reply-To: <6893d5e9-4b60-0efb-2a87-698b1bcda63e@collabora.com>
X-ClientProxiedBy: AS8PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d861bd50-a980-4e14-15f6-08da7ec59368
X-MS-TrafficTypeDiagnostic: MN2PR12MB3344:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4/4mkY+hz6Aw7d/9jLOw0JpLFczHjzbjWk5a4LSbfOfqX9LnO9iqRbVV96x2VhEG9MJNqLSLuAS7JQabUoNNCNPVUTnq7veg1uKgIOEbM4iaaPob8RxQb4la6Q9wkgsiOZKa87dmCu6K1WEOrFFiNbyckEt+Ss1f/cM0QWYaubx+eGFVA5tNw14irPhJ21XOnSfV8dJSVovVwJHwIjFAmwnYYFePG6qUUZL7F/eg2P5L81GkKBhB55gSdLPP4gbLkBUo4uUpaYEGFjTMxKFtMKPMU3dFkXejh3iUBtqjKhU4F+PWdD516qSns6MUreaabusZ7ZeY3SPXWFX0M38TyBL1ZT0xoLHJTWXOYB7S6umJI5OLdh4Clv1Ibx4M1vsCJPcm/zz7KKwpT9ptM3ni1Anfh+EQ7NoXUe4jKJBXCAJxJLQK5yp+NwXdHtP1Wwqq9NQ7BMSkEZG+dld3bmLyjfZHBYe6u0srUMTnx6+YzbSHoPpMmMmXew6AxdStnTo33vdolKOAXN58dnIibdQqUfG9dKXpS7k0+q8Q2xbkv6BpjkLt+joKuscDlBbEMpEavQzYh+8XW1YTr/9zH+ZkHC+gYWzkQSB89xOl04ukMsV2CbJsD0TWRYdKUKr+fUUBjSkqsKhajmzvj5KYA6uDCNjkQwnch8tX2oJiuzSmO1pmkbq9CoHKq7aWUlZx81ZWih7Rrkz/6AsE0A2tLnSNIhw9D7FJF4T5CcY6q4tXKX5PeVR9pI34GHs/LU1erJq7ySxBpqJp88X6RQv+DDeQpkKO0cCAfnewQAWe+5+GLBqYuHOwjiObZvZpAUNigT8QfAJAcTm2oUCqni4xWNVTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(8936002)(7416002)(2616005)(36756003)(83380400001)(4326008)(4744005)(66946007)(31686004)(5660300002)(66556008)(2906002)(66476007)(8676002)(110136005)(41300700001)(478600001)(316002)(186003)(6666004)(6512007)(6506007)(38100700002)(31696002)(86362001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFpsNE40YWhJZVBNdFkyLzdPaTdVd2s3aTlvZHk2NkUySStiWEVqTWdidktU?=
 =?utf-8?B?T2dYbTRDWDFJay9FaWN6aWQ4RW9BM0hiM3NWMXF3RE81WWxlT1RXRGdxM29Q?=
 =?utf-8?B?RTJncXM3Tnh0SGNZQUxzaUx6a0Nlc0t5dnNDUjdML2RJbGxVVzNaaUpBdG5w?=
 =?utf-8?B?aGxnLzZHZXdTNkNLY1ExdUdUd0d6cTdMTWl3SFp0b0lRYitQekZvY2l0bnU3?=
 =?utf-8?B?RlBOWFFONndnMnZLMmFTUnV3VTh5YkJZeVk2aTB6T1Vab3EvSm13YU90dEpB?=
 =?utf-8?B?RGZWeUx3VGN0SHZLeEV4dzhxa3FvUElGVE9naGJDMU9pQ09QNlJpdlp6Uy9u?=
 =?utf-8?B?MTRZQlVKZDg4U3h2SytkM0FHYU92SUszdG9Nd2Z5Zm00a2dDZHN6RXZQdnJx?=
 =?utf-8?B?Q2ZkeWFaa2JwOTFFQk02NGpZcnNETFVETzc5d1F3NHQwb2RoVTRhY1Y5NlNS?=
 =?utf-8?B?NkRjaHpSMUJyYUJkaVcrK0Uza0lYcTRjd1c1YUdtMDRCcTFXZ0xqSERVaDRM?=
 =?utf-8?B?dzkzRGtkVE5HVmU5MTVzcUR2VGZPd0o3QTFkZVZhTWZWS21zU0JYcUNrOUJn?=
 =?utf-8?B?MTN5eGZiK0N1U09WNk1oU281YzV5VFpwc0NpbmVzQUNyWjZoQ0NLaDdPVzRO?=
 =?utf-8?B?dW5kaEpNVUpGR1JKVFR0cjBBUy9mdlJYTmVtTGdSdjVNQ01iYTZFbi9nakNT?=
 =?utf-8?B?N0MxUDBoODNLdmplMitab204aUpSaGRRd2tsQ1RIL0FYUjFseVUxY0Yxall2?=
 =?utf-8?B?djBLY2NDSlRKNzBIR0x2eFU3SWZVSC85UERWemVGbzdZOG8ySmZvaVB3ODcz?=
 =?utf-8?B?R0FDV0NaSXlXcGlTbU4xNWhqYWk5RThzU2Q3dURNUE1vK3ZmYmdHR2l1UTg1?=
 =?utf-8?B?VWRiNFdLSnl5YzU3cTJFWlFnc3I3a1RMNHR5a2JGQnEvU1FvM0pPQzZsbVFs?=
 =?utf-8?B?ckpNTGlMejFPTjNBU1Zhbmx3UXI0QzhCSDJlSStXMm9XMy9sOGJhVGZFVFht?=
 =?utf-8?B?eHhocDlja1BtSnMvdUpFSnRISkdYWm5abDdGdlF0eFdDU2dDaXA3U1Z1dERk?=
 =?utf-8?B?djBSWGdSTFk5V0dnZ3pBMFNjOFExZU1wOVByV3p6cThUU3kyWWdpZkpUc0ZN?=
 =?utf-8?B?QVU1ZjlxL1JsVzl3UnZMb085UDNGVmVzQnFtY1o2M1poMzl2TWlRZmdnZW94?=
 =?utf-8?B?UzNlTXJlVUI1enpqRE5ob0VkdjNTbjYycWV5V0tWaVBWdHY5K21BRzh3SnBB?=
 =?utf-8?B?ZExpQnVpcUU0SUZJb1dxRDM3T2xGM05TRHFEb01JNW83bjBQWEJTanJ4SnpY?=
 =?utf-8?B?cEs2QmFQT3FySXUxZ1A4Q0lkbHVuYjUvUldGcjdPZXNVdFhrRWdhSkpJYUU3?=
 =?utf-8?B?YjRLdWdyM0g0K0E3bWJZdGdYQ2YraHZVeEk2VVY2MG5ZVktsUm92clh1QS85?=
 =?utf-8?B?eWZNeTZPaGMxUnByK1VRSlZYUC8wTWtqM0hnVmJWVDlYSlNHV3Y0NUkrM1RP?=
 =?utf-8?B?Rmh6NjdvRm9hb1F4ZVRQSEZqYmpDNjJIQzV1cDlvWFovWXlubUVSTzVnNTl3?=
 =?utf-8?B?NXJxRzVRSjhPRlZvU1poSWVxaFEzY0Zad2UvWVFFL2orRzZFYjhWbXE0YSt6?=
 =?utf-8?B?bHNnYjVzR1lmOHZpc0VjR1JiOVIzR2NCTG1nSUFDTUsrQnpPRjNLejlDSjJJ?=
 =?utf-8?B?ekNtZTNKeCs4clJpTDBXZFc3eXQyUFNhdnBTTGloRFJFbDZFRnVqNFJLY3lD?=
 =?utf-8?B?cFFGejY3UHd6Qnk3UkFMdktHOGV3OWl0TkR4KzlzUktoN1N3MHBhNUVsdlYv?=
 =?utf-8?B?b0xTdGp5aUFoZ25VTFAyc09hQXJ0UGlMOFlmTkp6RVN5eXY5Zm80RWJJY3Vo?=
 =?utf-8?B?NlRzdWVYSWE0OGhvOWNXcXZZWW1iYnBKVWV3aFFZbGEvZHZPTmZBRHJ2TTgy?=
 =?utf-8?B?dHloWU85YnkvOWQ0WlZwMys1NGd1MlBVTnVObUhZdWM1R0pQQkwyWlBOUG9W?=
 =?utf-8?B?ZVFMM3JKYkpFeW9JMk5iMWgyYUZocTlaNkdpUDRCbGlHdHljTEpEQmxVU3Yx?=
 =?utf-8?B?RU50UFliOVJqb3RIdUJrL0dSdUp4bC9zTDhoZnVxYmRtZ1pkb3VCNjJHK1d1?=
 =?utf-8?B?RzNJSVUzTXc2OUZabW80UzhlZFVNUFRPZldDSnlVN2syc2UzdGZCaU1VVjZI?=
 =?utf-8?Q?6t/nGmtbY4bkEn9T0kpFHINONfsE7k412wlIw8IYRTsy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d861bd50-a980-4e14-15f6-08da7ec59368
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 13:53:47.5731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XzAm64Dg9HjXAj/QeFhUqfEJowh4cxBrE3oAAxtr2naYN7pjStEQE9PASrgdt++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3344
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Am 15.08.22 um 15:45 schrieb Dmitry Osipenko:
> [SNIP]
>> Well that comment sounds like KVM is doing the right thing, so I'm
>> wondering what exactly is going on here.
> KVM actually doesn't hold the page reference, it takes the temporal
> reference during page fault and then drops the reference once page is
> mapped, IIUC. Is it still illegal for TTM? Or there is a possibility for
> a race condition here?
>

Well the question is why does KVM grab the page reference in the first 
place?

If that is to prevent the mapping from changing then yes that's illegal 
and won't work. It can always happen that you grab the address, solve 
the fault and then immediately fault again because the address you just 
grabbed is invalidated.

If it's for some other reason than we should probably investigate if we 
shouldn't stop doing this.

Regards,
Christian.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
