Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDE5C678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0798402E0;
	Wed,  8 Mar 2023 14:19:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0798402E0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KW9M+P2B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N0KKMdFxGDZV; Wed,  8 Mar 2023 14:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D5D240242;
	Wed,  8 Mar 2023 14:19:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D5D240242
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63B03C0071;
	Wed,  8 Mar 2023 14:19:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7E0CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0D7D4180D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:19:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0D7D4180D
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=KW9M+P2B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pkKX9mGWhOyX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:19:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDEFB41802
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDEFB41802
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMbLAJ358LRXl73mzKDrxDfNEnWaop2yFRvgFysr5Bo/xkKt2I7R2rziAIwLSLhZMW42PQd3qeD12C10uVkBxfIphW/dVNk+Oe3zrmPCbenRgCj/5GoCw5ixbmNYI26Xl00V9eDo59VoRSqObeVFDuOORVXNV6rvtux5b5acNo7FqGRO7NNDucWEg2E3pm0rhG8rx/6p6oT5Q8J4JkcWA1PQZdaqdRD+v000sgsSQuRC0/leHq5Rr4QfIFGeLfla6OIzstyH10rKykyNcpzTbNo3R/XajQWR24VX/GOCRbM5F6uOdCtLd0Iaq94G73k4xJ7kC64ySVA77uc8cKsFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofPngSFOvAgccNW35D5QQ+XiuE9KoXkdQLPc233IRZA=;
 b=L7a5nrKgKMYcbh+mf5rcuQwBBH+EOSNmDoJGu1HfuU19qKy0cg8MwOHDSLD9hs4TeOh5g2Yf16+/G6ja98ENR9bkm1d0fDHZiGfYd1mPqu2ZSHgbGtcXXWf9FgVi07m5dw9qVtk9RHYg+Wcr2sj7a8S1suqPVtVnMEL8C+rzGRpCk6dB2Rr3vDzPaXso6SwdES9syxM4rgvRQWvGwUH/ypKgeJ0GY/sIJEqVTElOtDnRoM9KkCJ2G6FDtXnudf4zjh8Wl+wFHT6LW47XJkcLc64975KAbg4P5W58OkZ/iBkDr0al2LR/tJSZ/uk+Yt4QfW3C30ejXLDSi8XZbzgz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofPngSFOvAgccNW35D5QQ+XiuE9KoXkdQLPc233IRZA=;
 b=KW9M+P2BF2clgStqVHQWTRYI/t99cVF3+VSjcbLrQMw7XYEov7j67Dz3uNtz0ASFCjE8Yj7NhhpR9SvkV2XXQv1+3kD2izZ/6cJtoX4nxahgQ8dIP8XG2Om9uG5nEpLtfPNmN4TiqCUaL6EaUJewLEApfy6oU6IltCl3vPW2AO/v7SDQlsIpMMnHQdItICWspsRnjTWl6c5ih7vINZaA1XD0Ay5bh1e/femo7PRfkOUnMksKTKV06E3UNsp4+iVCyDmQnEE9HDomL2gBzq2wIdFUB/ihHzDgQqACvRPduwFE8qiVjuY/5kTaDJMboTP/mEeTxhXx4cSElsv6JkmEzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 14:19:41 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::dfb7:e322:9a22:8eda%4]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 14:19:41 +0000
Message-ID: <23961926-f975-54fd-6537-42a53ef34503@nvidia.com>
Date: Wed, 8 Mar 2023 09:19:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
 <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
 <20230308091442-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230308091442-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 37359a09-d1ff-4183-1fe8-08db1fe0288b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HUVqMdBgsx+IdTUSFEdyrDa21LGHKVympGostkNnK+9Q+yMD7lfASHw/KCMyLZ7RGiuPeGzl7yYesw37+7xI6n0hEJ50mLgIxVdxB1/a6A7eiJHkubG5rxiiHkMDB57oWc0LiFhhUxF+xRtzh8/RvMT70P6XdHlBQld2V6WkD3+NOocf6tQJ4F4jnvBrhXLjjuQiZb2MWHu/03vP1BCQDtl+hYEYyKdCZ2L5oSJ66GBOMn5RmyDwA+Pntf2P0YUEFXi2FnIhWPvDBG6WSNX2yrWSmGtMaWzS2gz/zn6Tuc9+Xaa/5GGw+RYjHApPQk7NmEl7+4LVJ/rEv7spLPtg7JzeRcPC+CYk+NO7vY9i3+E6vUIiQJmXB1rHyU2rBpvaLWGFuztbqNj1764wOvcA9p6NEOVzHlC5Z8418sSCEG8IYQBENemmS2CpX+yfuDa5TUsJi246/UsDseN9mn6Co1XLxvwbid4PFsaEZuokVMC/X08M0t2e7ben0J0aSRSIaOvmzyDTBdKAYITU7wksdFW43GF199XHKeQFy5ZNM0l4cZFACd1Eg949ealdyLLzmUQnSKon23lo8LVcyR3YEzMloJPTrDvwc6u8tpDKRQxz1NtGnGmysWk1sKXwxU199xOyr5AS44oWJZcGZpFWV+jmfxltvFP1+OBg4ce7D5G2C1eiohgK3QmSNUf4pxPieB8qYmyFl/hiD2Pw6mnhRt9WTN7lDv+5ZkfiZodgyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199018)(26005)(31686004)(4326008)(66946007)(66556008)(6916009)(8936002)(36756003)(5660300002)(6506007)(2906002)(86362001)(38100700002)(31696002)(41300700001)(8676002)(66476007)(6666004)(478600001)(6486002)(316002)(6512007)(54906003)(83380400001)(2616005)(107886003)(53546011)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJUTGZIeDNTdUZVd3Eya3hYV25OZ045Z1YyZktaL3praENuMktFbDdwM3J2?=
 =?utf-8?B?RURjWUZyZmo4bCtpNnhLZmFyVXBzelcxL1Q4bXh0dzdtVFdrbHVtalV1ZHJy?=
 =?utf-8?B?cjQ3WGwyVzNCc3N1NTloZ0ZDWnBJSlhhcXlPalZvekRNQ1gyM0N5S0U3UWs2?=
 =?utf-8?B?NXhRZjA3ZGVsalc4U2FxeTE3K0RUNXpyQVFIcGoyNW5ubEZBcWRKd3N0SkJV?=
 =?utf-8?B?cHFLSDcvYzJldWIwMldGbWh4c0FuMC9qbDQzeG8zTTcxRmZoQmRrU2FJcjBD?=
 =?utf-8?B?MnE2VUFJNHRwd1RtOHFmVE1tcHBwTmUzSWFyMkdCZkF0N1ZZRzVvSW9KOTFS?=
 =?utf-8?B?Vy85R0tJNEM4VmJTN2tjQXZzSTh2bkxaSjkxNGF6c0pTVnpCVytBN1BwaGQ3?=
 =?utf-8?B?Skt0U1VRaXJCc2JqQlR0MjhxODk1ejJILzRTNms2Ym9kL3ZHVWpWcGhRM2Y1?=
 =?utf-8?B?T3IreEN2ai9jbEtsVTJBM1M5YXlISW9XUlJFc0dUKzVSNnRvbTIwdjhCc05D?=
 =?utf-8?B?M1RIRFU5S0JPMVY1ZTA2ckIreU40a1JoajlmUHh0YmQvTjloL3M0QTlGTlhI?=
 =?utf-8?B?TVB6WU8rbjQydCtaa2ZZMXNpekxHMEFHMzFYa2FmbG5WQ214U1ZVR252Sysx?=
 =?utf-8?B?Wlp5Q1dpWno4WUZMUDBzeU1ybUd0dEFvNlZwKzY0VGEzS05UMmFnNGxrcXIy?=
 =?utf-8?B?MXVZMStybW82NUhjeGpHL1RLMU0wZHY4a1UvYXZSUzk4N2pMTmMyR1JTVEtD?=
 =?utf-8?B?QjNJYnBkMzJVcWF6WTFwWmdiRTl0QTFHOHJEUVhCOWRCdWsvSjlnTzVpb1NV?=
 =?utf-8?B?ZEVVTVh1OFQ1YVBubExMNE1MNDR3VTBVbi9GcVRCQlFlQkViQTBCczRKOEJD?=
 =?utf-8?B?bSt1bjBtUmpnZU5pT05KRzZhSlRJakdVeEtWMjdPVEZjMVdXaVlTRzVIUDdM?=
 =?utf-8?B?V2dGVWJnVjVoc2JRNjNYb2tuN1laZjRhVDJSd3RnZjg0b3MxQ05uV282Zkc1?=
 =?utf-8?B?VldLZkpmdUkyWm1kQzd1Q2FvNXpoTnVoRFNHMEwyYWE0SHN2MnpIU2w1ZUEy?=
 =?utf-8?B?UFZMNUhFY1VQdmVodVBXOGN4b2tRSVltWkNPUE1LY1ZvM2lJVCs0eFZsalVQ?=
 =?utf-8?B?KzdUK0dEMGZLT2QrL012Yksxamg5bTVuK05Ra0tPaGMrdm44YlFvNXpxVE1B?=
 =?utf-8?B?Q0RWcnlGQUt3UlpleitjNjJDRWFzUmpVSTRBMVVlM2ZBZnMyYXhub1dCOFN0?=
 =?utf-8?B?RS9wRFNzb0h6Y2IybTdtSHRhMHhxWHFpbDhzWitscTF3OGQ4OVpYcHdDTjlJ?=
 =?utf-8?B?MzZMUE0wVnFucnFwYnRxUkxKcHRZYjRrQzJ6US9wMzZaaHVBaEJiWU9QS25F?=
 =?utf-8?B?WTdOVlJvNE5RWkY2a3VpWkVMVmRCU0pmUUplZjRTa3VMckVIL2dnMmZjSGxm?=
 =?utf-8?B?bm56OTdVbVBIWkxpdzJBaUx0bXZtVnRnNHlQR3VUYVhmMDVic0J1cTRXOWdR?=
 =?utf-8?B?dHQxOTcyZjVocE5VTVptU1pwZ25lNHUvS0pjR21BQXg1cXZTWlNpZ3JOMkFj?=
 =?utf-8?B?VGp1VkwyWWJTMUY1ZG1oM1ljZ1JQaTkyamhoc21SbndGeTdpSlRGOHZ0S3Ey?=
 =?utf-8?B?bGF3Zm54NFVSSDNaVWp5YThheHMrRXRTOVZLZ2t4RWk0MzRDc0tGMEdRQXVY?=
 =?utf-8?B?UWhjRllvZUtMYXRhREh5TktpMGJsQ3lRcE9tNno4a2U1MzZoajl4KzB5MTRl?=
 =?utf-8?B?U3hJSGU3V1hrOE9VWTI3cE5KM3B0WE1OYkpyR3pOVFJuM0JXUGhob2tMdUJh?=
 =?utf-8?B?WW9qSzhUSmJva01ra3JKR1hGQUM1ZXZCT295N2VNQzJoTzFLY0pGUGtJMjlP?=
 =?utf-8?B?ejd6TVBuclZmd25BbG15WGI5TXVXejVFMFc5dFVuUHpqM1RpYVJOQy9wR0FJ?=
 =?utf-8?B?WnRmaTNucVJaSm1GeWJMYW45ZGtvTnc1cEVSb0F1RHNvQzRoWEg0a1F4eHlk?=
 =?utf-8?B?bytBaFBDZ2tXRUVCazNJVVYxb1dnN1c4cHg2NWhkd094c2ZrNmpTWDNmT1pY?=
 =?utf-8?B?WHducElRbFQ1VDdhR2lYWWhUTmZhbklWRTZKOXdKTFNucDEzUGtuOXpwOXVx?=
 =?utf-8?Q?gpkktvdJEaf2/+HoHD1CiVlH5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37359a09-d1ff-4183-1fe8-08db1fe0288b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:19:41.7648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oZ7YY7EH93M1zt3vEltkoyyZEXQHCh+CExBeWg+Vsv5cQARUbNHVfFxlHagQ+Mj0U9//pT+oUXR3Vcw5oroOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyMDIzLTAzLTA4IGEubS45OjE2LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPiAK
PiAKPiBPbiBXZWQsIE1hciAwOCwgMjAyMyBhdCAwOTowNzo0OUFNIC0wNTAwLCBGZW5nIExpdSB3
cm90ZToKPj4KPj4KPj4gT24gMjAyMy0wMy0wOCBhLm0uMTI6NTgsIEphc29uIFdhbmcgd3JvdGU6
Cj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cwo+Pj4KPj4+Cj4+PiBPbiBUdWUsIE1hciA3LCAyMDIzIGF0IDExOjU34oCvQU0gRmVuZyBM
aXUgPGZlbGl1QG52aWRpYS5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4gQWRkIGNvbnN0IHRvIG1ha2Ug
dGhlIHJlYWQtb25seSBwb2ludGVyIHBhcmFtZXRlcnMgY2xlYXIsIHNpbWlsYXIgdG8KPj4+PiBt
YW55IGV4aXN0aW5nIGZ1bmN0aW9ucy4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEZlbmcgTGl1
IDxmZWxpdUBudmlkaWEuY29tPgo+Pj4+IFJldmlld2VkLWJ5OiBKaXJpIFBpcmtvIDxqaXJpQG52
aWRpYS5jb20+Cj4+Pj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNv
bT4KPj4+PiBSZXZpZXdlZC1ieTogR2F2aW4gTGkgPGdhdmlubEBudmlkaWEuY29tPgo+Pj4+IFJl
dmlld2VkLWJ5OiBCb2RvbmcgV2FuZyA8Ym9kb25nQG52aWRpYS5jb20+Cj4+Pj4gLS0tCj4+Pj4g
ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI1ICsrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0KPj4+PiAgICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgMTIgKysrKysrLS0t
LS0tCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlv
bnMoLSkKPj4+Pgo+Pj4KPj4+IFsuLi5dCj4+Pgo+Pj4+Cj4+Pj4gLS8qCj4+Pj4gLSAqIFRoaXMg
c2hvdWxkIHByZXZlbnQgdGhlIGRldmljZSBmcm9tIGJlaW5nIHVzZWQsIGFsbG93aW5nIGRyaXZl
cnMgdG8KPj4+PiArLyBUaGlzIHNob3VsZCBwcmV2ZW50IHRoZSBkZXZpY2UgZnJvbSBiZWluZyB1
c2VkLCBhbGxvd2luZyBkcml2ZXJzIHRvCj4+Pj4gICAgICogcmVjb3Zlci4gIFlvdSBtYXkgbmVl
ZCB0byBncmFiIGFwcHJvcHJpYXRlIGxvY2tzIHRvIGZsdXNoLgo+Pj4+ICAgICAqLwo+Pj4KPj4+
IEFueSByZWFzb24gZm9yIHRoaXMgY2hhbmdlPwo+Pj4KPj4gSGksIEphc29uCj4+IFRoZSBvcmln
aW5hbCBjb21tZW50IG9mIHRoZSBjb2RlIGhhZCBhIHN5bnRheCBwcm9ibGVtIGFuZCBjb3VsZG4n
dCBjb21waWxlLAo+PiBJIGZpeGVkIGl0IGhlcmUKPiAKPiBUaGlzIGlzIGhvdyBpdCBsb29rZWQg
YmVmb3JlIHlvdXIgcGF0Y2g6Cj4gCj4gLyoKPiAgICogVGhpcyBzaG91bGQgcHJldmVudCB0aGUg
ZGV2aWNlIGZyb20gYmVpbmcgdXNlZCwgYWxsb3dpbmcgZHJpdmVycyB0bwo+ICAgKiByZWNvdmVy
LiAgWW91IG1heSBuZWVkIHRvIGdyYWIgYXBwcm9wcmlhdGUgbG9ja3MgdG8gZmx1c2guCj4gICAq
Lwo+IAo+IEkgc2VlIG5vIHByb2JsZW0gaGVyZS4KPiAKWWVzLCB5b3UgYXJlIHJpZ2h0LiBJIG1h
ZGUgYSBtaXN0YWtlIGhlcmUsIEkgd2lsbCBmaXggaXQKPiAKPj4+IFRoYW5rcwo+Pj4KPiAKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
