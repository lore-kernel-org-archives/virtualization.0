Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B785C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 09:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41282401D2;
	Wed, 23 Mar 2022 09:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yFBT4BY_o9om; Wed, 23 Mar 2022 09:47:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2738D40B58;
	Wed, 23 Mar 2022 09:47:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07D5DC001A;
	Wed, 23 Mar 2022 09:47:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 889B7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 636B26134B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d9wLiqeXRyPt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:47:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E2E160ACA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCv+JukBEQCnUhvbI+PrHkgEatPp6/F3pnHNfxiSzWAD6wbp9WIYRWTLgerZVOh6Ziy/gMTDJq8S6gx7LgTsXzoH0b3dS38WQokbivJvF86ZhiG7T4CJ11LaW6r4E6xyyQDfuaPKx4636uXuxFVIYK79vnuCFEUSp0DYodwAAa8Omw2WCGGDRqPf0Y3Q6xClmP/OlkpLnr0ShX9B3D8HTq4x6kFtsEIShFeW673kv6QVvpVum9SSzERlGXwxFKIgz3KmMz+SFUtVnVoCDhbKKoeoAVkxZoyjLSd2QwBxb++Q2wmGPPhvYN26AvPIypQtj/1ddVIUbIBzvZjAO6UcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q//8ZV1vmEIo2hXahr1TIOR5984uuIqsG3S4V66hgS4=;
 b=C/cc/9loFxYP8RwhRv69MPALLXMEPQ6WjrYak2qzkmyhH+8J39Sj5FHY//+AofEa/ogyIfMMUTED8bKETSZDlKysD+vx2JiaCVCgL45BlimGPNCh3B/13Jgpc4Ks2iXSgVTSa4N4gNpvd+VSDg3n2IW80ArxA1dUogQ0lPPopRkoV5NIp6FqGTUHS/9hKBNRu/wiomjhVMRYyXsdBHS+nRrw3w3Yck94wtWu94W3KLlFRalPk7PSdJkP5D2bN6KLPZhAM3HUpVKw0IkDyQdjEd7kIvph7LPZGGJLyqN/WnfXNyuADfCiFT7QIzjodiMXRa+dgjb3qlMCKLq9MPMBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q//8ZV1vmEIo2hXahr1TIOR5984uuIqsG3S4V66hgS4=;
 b=hUydpsX12GBu5twh71LPwqRUk668H5ucDn3eTdGTdOwpzK5Dd6dGpsuEyeGf7dpo+rW+1lrW+iu220Y5F3i/8ZUc1BfRyenMA5l+CS53bcizBBTJGess16FoeNT438MUWpBy9DSn1datxcbv4fP0ag8+vie5m+5l2PWnvunFHBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 09:47:00 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5081.024; Wed, 23 Mar 2022
 09:47:00 +0000
Message-ID: <549ca2a0-cc07-d3eb-685f-ab289f5d7690@amd.com>
Date: Wed, 23 Mar 2022 10:46:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/2] drm/qxl: replace ioremap by ioremap_cache on arm64
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Cong Liu <liucong2@kylinos.cn>,
 airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
 ray.huang@amd.com, virtualization@lists.linux-foundation.org,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20220322093444.1236582-1-liucong2@kylinos.cn>
 <e2bc20e4-41e1-7162-257c-f2ad3309f1cb@amd.com>
 <a6acb2ce-2465-6619-e3fd-ac34ddf07d35@arm.com>
In-Reply-To: <a6acb2ce-2465-6619-e3fd-ac34ddf07d35@arm.com>
X-ClientProxiedBy: AS9PR06CA0135.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::22) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a04f4a-5e9b-46a4-ea4a-08da0cb2137f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3068:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB30689D02481E505FAA1B535A83189@DM6PR12MB3068.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ukGAd37i0XH1E471VdmanyOqSFWB9xxeXHpwVAV2r59wic/fJkDWatL3FoJfUNu/86l1ZcwP6zvI+1K7YzrQNhHEQCdFffbSh1XHS4vatNWHyi7D/7w9aaH7PlBWCTv/tSNWXUeWFZfJlaC5AuaUPgbOxYGZLCvFiH/YKUcMkohMKdmof/yVYa3I9LUEsclkkOTUmZ1Ihw6dBRn9O0O0EDsjDmLE2iixwY76rJxwJUplv/Ohn+YoEhseiw29c5x0KSZEG4ykMVPZxWKgEDe32GnIM4nK2B4J6ru+Lu0EmvONZlTQ3u8/pVnwIrj6sQczTgiFnXIv9tyFpTZ+x3v49Cxia4MS+afCLpzL/PTQw5iSIKaZ22jemqMWDeT2bqUNlOCn5pzqYcNXkoj8L7FiZBv459K04YMG2qmmxcIRQLGZbgffTiw6l3cAXRjGEKsFKXiPnVTyTSygjdbC/RUypiqCgeHMAAd+iMumQYvMQTZtIiWcRBXQIkfAulmYfHm41c0Pjw4tHC6+XBhkvGnvWNJaE/GbJkRsPZeuyTyS9sti/94yldkO5pIaQVSm/qCKiiRNh4mDMRlNYV+TfWiIgOV15pOQf0cV5Mofndp2e1gDsW7xYr4ZuLX93fNiwqaupb2o/oGj0OFYD3cL/vs8ls04uKNkyh+MEbcDtBvT+cWFvFbSk074bd4+fCmz1WiOTL0AvOHsxEaDgVtCE8fK6dUSTvtdzKxuorf/G2IS1lmVth45arDGdV6Re6ARJAJbNQ8AgMXossKBs/Cx84pdaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(66946007)(6506007)(31696002)(2906002)(86362001)(6512007)(53546011)(110136005)(38100700002)(6486002)(921005)(316002)(5660300002)(8936002)(508600001)(8676002)(66556008)(2616005)(66476007)(26005)(66574015)(31686004)(186003)(83380400001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW95NWlGVHJQYm9WdnBNQjlyTXcvTHBNTDROSFAwb3ZITzByTzdka2kxcVIw?=
 =?utf-8?B?OE90TWRzeXcvcXF3OUoraXJ1QStOYnBwZCtyNHdLZFd3NTk0WTVsSnZBcnBh?=
 =?utf-8?B?VnZOeGtueFRVVnZwS0N6TWd3R01CeGhBdDlTSDVwcDArZGFhUUp1Mm04TGxm?=
 =?utf-8?B?L0dEeW9hakdFUEIyTlJHRkkzNU1WRzIwUGlkWVpNZTFXelg3bWZkd1dZSDVu?=
 =?utf-8?B?Rk4wRzZwRm1xNFp1bHJnU0loZnJSaXE0am9iVkxUaFFHVW40OGo0T0tFZit6?=
 =?utf-8?B?ZzFJeHNuMDFlTlNCV0FWaUVPendtL2dzR0twZS9vZHRXRSs2LzdoNFFWcVpk?=
 =?utf-8?B?SGlsMVNaNG05WG40K1BwVHRhc0VRV0J2OEpXVmp4T3RrMnBIQ3lmcHpLTXhK?=
 =?utf-8?B?K2dEazZ4bHR4UHZLL01DTEdVM1dqMGJiU0txSGdBN1JQQWFpZTMyenhhdTZv?=
 =?utf-8?B?RmFMVXN0MlNuYjhIb2x5VnNPSnA0TDJVbjJ4QTJIN1dYUWpZQkFBQVBHWklv?=
 =?utf-8?B?R3BsN3RxcUkzV2pUMnRsN0ErdzNMMGhRU1phUWhFSUc2U09jQUFCRDF1T2Rr?=
 =?utf-8?B?am1hUGNFM095U1hCVHNvVTNwYmlhRW5DTm5xU3dkUXN3WGVKcVQ1Q2ZXVEZB?=
 =?utf-8?B?WHFSTVdYUUdtRXJXOTc2a2hsYzIvdDRpVmp0ZkxkekQxeVBGaU9PZUxwTEdO?=
 =?utf-8?B?YlZWczNaT3l6ZnJZWnRhTVpUQ2wxb1RKcWQ2SEJORjc0c1ZkRWZQQ3ovSTZQ?=
 =?utf-8?B?NFlkRDc1MFM3NXV2ZnBUd09DWGc1ekgyM0xkeFQyNFRUcHk3Ty9rOU1XMC9W?=
 =?utf-8?B?ZTkxdGkrNzRBWkNUU1AyZ3FZdi92SCtETFE1UnZLSDVwMVpFQm9WTHVZLy90?=
 =?utf-8?B?YWVIMG1jSG5qdXE0Ty9JbEFiZ013L0VuVyt3c3NYMGpTcGphUkdoYXJPZ0NQ?=
 =?utf-8?B?SjRHdnFxR2xacEgrcUQrOHU0VnlidUMyL3BDbkJzRXBtaG4xdEhOaDgzck9O?=
 =?utf-8?B?YU9ucXEwcnV0YXZ3MFpHeStGaDJ1NnE3bHQxS2drWFJONFp6Z1RTSGErMFRH?=
 =?utf-8?B?UEMwOUttVUwvTjNlZjlsanc0a1ZiNmN2YUZydVZya0RnM1hyVkRkN1gzL2s3?=
 =?utf-8?B?RTlMZUlWVndyYW0vUWo0RkJZRUxlc3JHYzhsU21JdGZmUi8xcTZpVzJSRlhi?=
 =?utf-8?B?M2JxYWhQem0vcVU1RWtsaWJ2SklUTTk0U3dHQ09hYy9RNS9yQ2xaSXFuSDZI?=
 =?utf-8?B?WWtKZklPTDFDcEVHU2JhWjE4cFdmalRsUEtuVFZ2bW9sRlBtbVBoUWp2cEdG?=
 =?utf-8?B?Qk9BNDR3M0paekd1SlFzZlFCQXhNQlArZFRVOEF6YlF5ZjJUQ2JwN1FhQnFL?=
 =?utf-8?B?a1BnNHAvN2xYUmQzdUZ3SUFwa3J5Z09qMXBIcU5EMlFvZDlzYXRGVkRzeXhC?=
 =?utf-8?B?bWgzWlZpaFRrMWdBNkRNYm5wWmNTT3BDZnBkSlY3MUQwRUIyQTk2Q014NnBh?=
 =?utf-8?B?NGZ6YktWb2xPOTBMUW9qa1o3N2lTRjZZUnZzeWd6bFJMVVZYaThoeTNTdFdQ?=
 =?utf-8?B?VDNYUGxteUZ0VDhTNExYMFdtYnE5UllTd3d1dk05SzdCMXZmVUp4U25vUWNZ?=
 =?utf-8?B?UGhWUG83dFVXc1prdCtIOHNYeHV3QVQzcVQ3NW5mdDQ5aDVyMWxGMXlnM3Bm?=
 =?utf-8?B?Zk1lV3hoSHdyRU41eVFIYyt6MUhiREw3eVNhTUVLK083OUthbGtpTnNuSmNi?=
 =?utf-8?B?cllOWUFYMjl2a2MxWll0OHplQlB2S2NQY1FNSkFxcDhUaVRuUVBsdzk1MUVN?=
 =?utf-8?B?LzRSQllLSDE0WlFhS1QzRitvQ1dPSEgyenhrdG5QMkswWDNWSW5LQStyTGNs?=
 =?utf-8?B?cGF1NktmVGJDRzJyNDV0VG5GdHB5OHRObGIyVGhDeERETWRhQlNyNWFRUysy?=
 =?utf-8?Q?yL+0lKC55grEPpEkd4l3GgiJNxGOs6jb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a04f4a-5e9b-46a4-ea4a-08da0cb2137f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:47:00.0020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEdjqxqlwJK6kymQmIB5AiwBWmy6F34QcWQDBlUZ/PxkKRDBQLmN5Z4SfwTXqucQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMjMuMDMuMjIgdW0gMTA6NDUgc2NocmllYiBSb2JpbiBNdXJwaHk6Cj4gT24gMjAyMi0wMy0y
MyAwNzoxNSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMjIuMDMuMjIgdW0gMTA6MzQg
c2NocmllYiBDb25nIExpdToKPj4+IHF4bCB1c2UgaW9yZW1hcCB0byBtYXAgcmFtX2hlYWRlciBh
bmQgcm9tLCBpbiB0aGUgYXJtNjQgaW1wbGVtZW50YXRpb24sCj4+PiB0aGUgZGV2aWNlIGlzIG1h
cHBlZCBhcyBERVZJQ0VfbkduUkUsIGl0IGNhbiBub3Qgc3VwcG9ydCB1bmFsaWduZWQKPj4+IGFj
Y2Vzcy4KPj4KPj4gV2VsbCB0aGF0IHNvbWUgQVJNIGJvYXJkcyBkb2Vzbid0IGFsbG93IHVuYWxp
Z25lZCBhY2Nlc3MgdG8gTU1JTyAKPj4gc3BhY2UgaXMgYSB3ZWxsIGtub3duIGJ1ZyBvZiB0aG9z
ZSBBUk0gYm9hcmRzLgo+Pgo+PiBTbyBhcyBmYXIgYXMgSSBrbm93IHRoaXMgaXMgYSBoYXJkd2Fy
ZSBidWcgeW91IGFyZSB0cnlpbmcgdG8gCj4+IHdvcmthcm91bmQgaGVyZSBhbmQgSSdtIG5vdCAx
MDAlIHN1cmUgdGhhdCB0aGlzIGlzIGNvcnJlY3QuCj4KPiBObywgdGhpcyBvbmUncyBub3QgYSBi
dWcuIFRoZSBEZXZpY2UgbWVtb3J5IHR5cGUgdXNlZCBmb3IgaW9tZW0gCj4gbWFwcGluZ3MgaXMg
KmFyY2hpdGVjdHVyYWxseSogZGVmaW5lZCB0byBlbmZvcmNlIHByb3BlcnRpZXMgbGlrZSAKPiBh
bGlnbmVkIGFjY2Vzc2VzLCBubyBzcGVjdWxhdGlvbiwgbm8gcmVvcmRlcmluZywgZXRjLiBJZiBz
b21ldGhpbmcgCj4gd2FudHMgdG8gYmUgdHJlYXRlZCBtb3JlIGxpa2UgUkFNIHRoYW4gYWN0dWFs
IE1NSU8gcmVnaXN0ZXJzLCB0aGVuIAo+IGlvcmVtYXBfd2MoKSBvciBpb3JlbWFwX2NhY2hlKCkg
aXMgdGhlIGFwcHJvcHJpYXRlIHRoaW5nIHRvIGRvIGluIAo+IGdlbmVyYWwgKHdpdGggdGhlIGZv
cm1lciBiZWluZyBhIGJpdCBtb3JlIHBvcnRhYmxlIGFjY29yZGluZyB0byAKPiBEb2N1bWVudGF0
aW9uL2RyaXZlci1hcGkvZGV2aWNlLWlvLnJzdCkuCj4KPiBPZiBjb3Vyc2UgKnRoZW4qIHlvdSBt
aWdodCBmaW5kIHRoYXQgb24gc29tZSBzeXN0ZW1zIHRoZSAKPiBpbnRlcmNvbm5lY3QvUENJZSBp
bXBsZW1lbnRhdGlvbi9lbmRwb2ludCBkb2Vzbid0IGFjdHVhbGx5IGxpa2UgCj4gdW5hbGlnbmVk
IGFjY2Vzc2VzIG9uY2UgdGhlIENQVSBNTVUgc3RhcnRzIGFsbG93aW5nIHRoZW0gdG8gYmUgc2Vu
dCAKPiBvdXQsIGJ1dCBoZXksIG9uZSBzdGVwIGF0IGEgdGltZSA7KQoKQWgsIGdvb2QgcG9pbnQh
IEkgd2FzIGFscmVhZHkgd29uZGVyaW5nIHdoeSB0aGF0IHNvbWV0aW1lcyB3b3JrIGFuZCAKc29t
ZXRpbWVzIGRvZXNuJ3QuCgpUaGFua3MsCkNocmlzdGlhbi4KCj4KPiBSb2Jpbi4KPgo+Pgo+PiBD
aHJpc3RpYW4uCj4+Cj4+Pgo+Pj4gwqDCoCA2LjYyMDUxNV0gcGMgOiBzZXR1cF9od19zbG90KzB4
MjQvMHg2MCBbcXhsXQo+Pj4gW8KgwqDCoCA2LjYyMDk2MV0gbHIgOiBzZXR1cF9zbG90KzB4MzQv
MHhmMCBbcXhsXQo+Pj4gW8KgwqDCoCA2LjYyMTM3Nl0gc3AgOiBmZmZmODAwMDEyYjczNzYwCj4+
PiBbwqDCoMKgIDYuNjIxNzAxXSB4Mjk6IGZmZmY4MDAwMTJiNzM3NjAgeDI4OiAwMDAwMDAwMDAw
MDAwMDAxIHgyNzogCj4+PiAwMDAwMDAwMDEwMDAwMDAwCj4+PiBbwqDCoMKgIDYuNjIyNDAwXSB4
MjY6IDAwMDAwMDAwMDAwMDAwMDEgeDI1OiAwMDAwMDAwMDA0MDAwMDAwIHgyNDogCj4+PiBmZmZm
Y2YzNzY4NDhjMDAwCj4+PiBbwqDCoMKgIDYuNjIzMDk5XSB4MjM6IGZmZmYwMDAwYzQwODc0MDAg
eDIyOiBmZmZmY2YzNzE4ZTE3MTQwIHgyMTogCj4+PiAwMDAwMDAwMDAwMDAwMDAwCj4+PiBbwqDC
oMKgIDYuNjIzODIzXSB4MjA6IGZmZmYwMDAwYzQwODYwMDAgeDE5OiBmZmZmMDAwMGM0MDg3MGIw
IHgxODogCj4+PiAwMDAwMDAwMDAwMDAwMDE0Cj4+PiBbwqDCoMKgIDYuNjI0NTE5XSB4MTc6IDAw
MDAwMDAwNGQzNjA1YWIgeDE2OiAwMDAwMDAwMGJiM2I2MTI5IHgxNTogCj4+PiAwMDAwMDAwMDZl
NzcxODA5Cj4+PiBbwqDCoMKgIDYuNjI1MjE0XSB4MTQ6IDAwMDAwMDAwMDAwMDAwMDEgeDEzOiAw
MDc0NzM2OTZjNWY3OTc0IHgxMjogCj4+PiA2OTZlNjk2NjY2NjE1ZjY1Cj4+PiBbwqDCoMKgIDYu
NjI1OTA5XSB4MTE6IDAwMDAwMDAwZDU0MzY1NmEgeDEwOiAwMDAwMDAwMDAwMDAwMDAwIHg5IDog
Cj4+PiBmZmZmY2YzNzE4ZTA4NWE0Cj4+PiBbwqDCoMKgIDYuNjI2NjE2XSB4OCA6IDAwMDAwMDAw
MDA2Yzc4NzEgeDcgOiAwMDAwMDAwMDAwMDAwMDBhIHg2IDogCj4+PiAwMDAwMDAwMDAwMDAwMDE3
Cj4+PiBbwqDCoMKgIDYuNjI3MzQzXSB4NSA6IDAwMDAwMDAwMDAwMDE0MDAgeDQgOiBmZmZmODAw
MDExZjYzNDAwIHgzIDogCj4+PiAwMDAwMDAwMDE0MDAwMDAwCj4+PiBbwqDCoMKgIDYuNjI4MDQ3
XSB4MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiBmZmZmMDAwMGM0MDg3MGIwIHgwIDogCj4+PiBm
ZmZmMDAwMGM0MDg2MDAwCj4+PiBbwqDCoMKgIDYuNjI4NzUxXSBDYWxsIHRyYWNlOgo+Pj4gW8Kg
wqDCoCA2LjYyODk5NF3CoCBzZXR1cF9od19zbG90KzB4MjQvMHg2MCBbcXhsXQo+Pj4gW8KgwqDC
oCA2LjYyOTQwNF3CoCBzZXR1cF9zbG90KzB4MzQvMHhmMCBbcXhsXQo+Pj4gW8KgwqDCoCA2LjYy
OTc5MF3CoCBxeGxfZGV2aWNlX2luaXQrMHg2ZjAvMHg3ZjAgW3F4bF0KPj4+IFvCoMKgwqAgNi42
MzAyMzVdwqAgcXhsX3BjaV9wcm9iZSsweGRjLzB4MWQwIFtxeGxdCj4+PiBbwqDCoMKgIDYuNjMw
NjU0XcKgIGxvY2FsX3BjaV9wcm9iZSsweDQ4LzB4YjgKPj4+IFvCoMKgwqAgNi42MzEwMjddwqAg
cGNpX2RldmljZV9wcm9iZSsweDE5NC8weDIwOAo+Pj4gW8KgwqDCoCA2LjYzMTQ2NF3CoCByZWFs
bHlfcHJvYmUrMHhkMC8weDQ1OAo+Pj4gW8KgwqDCoCA2LjYzMTgxOF3CoCBfX2RyaXZlcl9wcm9i
ZV9kZXZpY2UrMHgxMjQvMHgxYzAKPj4+IFvCoMKgwqAgNi42MzIyNTZdwqAgZHJpdmVyX3Byb2Jl
X2RldmljZSsweDQ4LzB4MTMwCj4+PiBbwqDCoMKgIDYuNjMyNjY5XcKgIF9fZHJpdmVyX2F0dGFj
aCsweGM0LzB4MWE4Cj4+PiBbwqDCoMKgIDYuNjMzMDQ5XcKgIGJ1c19mb3JfZWFjaF9kZXYrMHg3
OC8weGQwCj4+PiBbwqDCoMKgIDYuNjMzNDM3XcKgIGRyaXZlcl9hdHRhY2grMHgyYy8weDM4Cj4+
PiBbwqDCoMKgIDYuNjMzNzg5XcKgIGJ1c19hZGRfZHJpdmVyKzB4MTU0LzB4MjQ4Cj4+PiBbwqDC
oMKgIDYuNjM0MTY4XcKgIGRyaXZlcl9yZWdpc3RlcisweDZjLzB4MTI4Cj4+PiBbwqDCoMKgIDYu
NjM1MjA1XcKgIF9fcGNpX3JlZ2lzdGVyX2RyaXZlcisweDRjLzB4NTgKPj4+IFvCoMKgwqAgNi42
MzU2MjhdwqAgcXhsX2luaXQrMHg0OC8weDEwMDAgW3F4bF0KPj4+IFvCoMKgwqAgNi42MzYwMTNd
wqAgZG9fb25lX2luaXRjYWxsKzB4NTAvMHgyNDAKPj4+IFvCoMKgwqAgNi42MzYzOTBdwqAgZG9f
aW5pdF9tb2R1bGUrMHg2MC8weDIzOAo+Pj4gW8KgwqDCoCA2LjYzNjc2OF3CoCBsb2FkX21vZHVs
ZSsweDI0NTgvMHgyOTAwCj4+PiBbwqDCoMKgIDYuNjM3MTM2XcKgIF9fZG9fc3lzX2Zpbml0X21v
ZHVsZSsweGJjLzB4MTI4Cj4+PiBbwqDCoMKgIDYuNjM3NTYxXcKgIF9fYXJtNjRfc3lzX2Zpbml0
X21vZHVsZSsweDI4LzB4MzgKPj4+IFvCoMKgwqAgNi42MzgwMDRdwqAgaW52b2tlX3N5c2NhbGwr
MHg3NC8weGYwCj4+PiBbwqDCoMKgIDYuNjM4MzY2XcKgIGVsMF9zdmNfY29tbW9uLmNvbnN0cHJv
cC4wKzB4NTgvMHgxYTgKPj4+IFvCoMKgwqAgNi42Mzg4MzZdwqAgZG9fZWwwX3N2YysweDJjLzB4
OTAKPj4+IFvCoMKgwqAgNi42MzkyMTZdwqAgZWwwX3N2YysweDQwLzB4MTkwCj4+PiBbwqDCoMKg
IDYuNjM5NTI2XcKgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4YjAvMHhiOAo+Pj4gW8KgwqDCoCA2
LjYzOTkzNF3CoCBlbDB0XzY0X3N5bmMrMHgxYTQvMHgxYTgKPj4+IFvCoMKgwqAgNi42NDAyOTRd
IENvZGU6IDkxMDAwM2ZkIGY5NDg0ODA0IGY5NDAwYzIzIDhiMDUwMDg0IChmODA5YzA4MykKPj4+
IFvCoMKgwqAgNi42NDA4ODldIC0tLVsgZW5kIHRyYWNlIDk1NjE1ZDg5YjdjODdmOTUgXS0tLQo+
Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IENvbmcgTGl1IDxsaXVjb25nMkBreWxpbm9zLmNuPgo+Pj4g
LS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9rbXMuYyB8IDEwICsrKysrKysrKysK
Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2ttcy5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0v
cXhsL3F4bF9rbXMuYwo+Pj4gaW5kZXggNGRjNWFkMTNmMTJjLi4wZTYxYWMwNGQ4YWQgMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9rbXMuYwo+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3F4bC9xeGxfa21zLmMKPj4+IEBAIC0xNjUsNyArMTY1LDExIEBAIGludCBxeGxf
ZGV2aWNlX2luaXQoc3RydWN0IHF4bF9kZXZpY2UgKnFkZXYsCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAoaW50KXFkZXYtPnN1cmZhY2VyYW1fc2l6ZSAvIDEwMjQsCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAoc2IgPT0gNCkgPyAiNjRiaXQiIDogIjMyYml0Iik7Cj4+PiArI2lmZGVmIENPTkZJ
R19BUk02NAo+Pj4gK8KgwqDCoCBxZGV2LT5yb20gPSBpb3JlbWFwX2NhY2hlKHFkZXYtPnJvbV9i
YXNlLCBxZGV2LT5yb21fc2l6ZSk7Cj4+PiArI2Vsc2UKPj4+IMKgwqDCoMKgwqAgcWRldi0+cm9t
ID0gaW9yZW1hcChxZGV2LT5yb21fYmFzZSwgcWRldi0+cm9tX3NpemUpOwo+Pj4gKyNlbmRpZgo+
Pj4gwqDCoMKgwqDCoCBpZiAoIXFkZXYtPnJvbSkgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBy
X2VycigiVW5hYmxlIHRvIGlvcmVtYXAgUk9NXG4iKTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBy
ID0gLUVOT01FTTsKPj4+IEBAIC0xODMsOSArMTg3LDE1IEBAIGludCBxeGxfZGV2aWNlX2luaXQo
c3RydWN0IHF4bF9kZXZpY2UgKnFkZXYsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byByb21f
dW5tYXA7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+ICsjaWZkZWYgQ09ORklHX0FSTTY0Cj4+PiArwqDC
oMKgIHFkZXYtPnJhbV9oZWFkZXIgPSBpb3JlbWFwX2NhY2hlKHFkZXYtPnZyYW1fYmFzZSArCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFkZXYtPnJvbS0+cmFtX2hl
YWRlcl9vZmZzZXQsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNp
emVvZigqcWRldi0+cmFtX2hlYWRlcikpOwo+Pj4gKyNlbHNlCj4+PiDCoMKgwqDCoMKgIHFkZXYt
PnJhbV9oZWFkZXIgPSBpb3JlbWFwKHFkZXYtPnZyYW1fYmFzZSArCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFkZXYtPnJvbS0+cmFtX2hlYWRlcl9vZmZzZXQs
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZigqcWRl
di0+cmFtX2hlYWRlcikpOwo+Pj4gKyNlbmRpZgo+Pj4gwqDCoMKgwqDCoCBpZiAoIXFkZXYtPnJh
bV9oZWFkZXIpIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBEUk1fRVJST1IoIlVuYWJsZSB0byBp
b3JlbWFwIFJBTSBoZWFkZXJcbiIpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSAtRU5PTUVN
Owo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
