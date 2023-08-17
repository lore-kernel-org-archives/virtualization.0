Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D156C64EDA
	for <virtualization@archiver.kernel.org>; Thu, 17 Aug 2023 22:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B82888382F;
	Thu, 17 Aug 2023 22:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B82888382F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=J2oD2Lbu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h1XqXUkIL7Qx; Thu, 17 Aug 2023 22:32:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1137083D17;
	Thu, 17 Aug 2023 22:32:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1137083D17
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D31CCC0039;
	Thu, 17 Aug 2023 22:32:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06C42C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Aug 2023 22:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D892B4004B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Aug 2023 22:32:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D892B4004B
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=J2oD2Lbu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tDztOuS0bVkL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Aug 2023 22:32:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::622])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 231CE4002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Aug 2023 22:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 231CE4002D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMgBd5CANvZbkWKWZ3wIjFlb0i7D14F9M58OCu1XDAKxjuga6K/9KEWrdTwAwxqvPh//tioSIYGd8UGvTY3iJ+KaVBKizoPvB839mp+xdj2TVmMccHHSgO2Mi5Bke6aBdnWQdAJOX74z5Yp0gB514Y0zPBvb4vBGBRZiHFz1cqtUTZ4rY1PqqLyyfxwQcG9mNx4JABD5Jv1vqWOcl4gt5irF+nfLQD67NK/mOaOUH8R4WeIBL56RU0ezaYZ9bYr4dfbhE/OBy2gkvQO4jEIxPK4GfhUfjc1Fe5rN5Qy0GaA+f2ihZmcHPgqABjy3mPD1Ah2KjTs+nE5u8PbvjS/GSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AlY+u8pRgaFSMWlxy8NYuGYYo13nDpDHOdQcLXc9NI=;
 b=HGSqnF6QMLMC860HRZSGcnBsPk/7XDJlxxbKBRibonCgGvqYw+bt69D2qe/R0mHk7/+DGoSfN2vQoHEnTB/nwCjMzCQSQxahR+NHr/FwsIWuv5OM4dG9tVyGw/XGUEVZXMfdywWlUkr3bXU1bxcLrmfFrcX4mksEWoScjAU3qEOYRjXnJomZwzVOH4YgBQ666iLgNwDtyZvp4GC+KrUonz0NB/yzrqfE39QjfG8ayqhdJckTvqskje6+n3Lr19v8eDVTnGlGN/L4wF2wQ20sdrXD7bIT8H77J4g8omD9UOLgXdqQz4OqSs7A6lmph8PkQpyuvZQOkKkvOd3L+IzmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AlY+u8pRgaFSMWlxy8NYuGYYo13nDpDHOdQcLXc9NI=;
 b=J2oD2LbukBquTar2iSSO8PL7ejYlESsMrGwotAzTckEzpPinWbOhsGpZcDcnpS39kIR+xv96JbHRhluRRmUxvnynW3rARJe8uvqdYEEYUK65/xrL7fs91/+GRlp5NWsa4CEKL2li4EVx+xsuZEeq21Moz7834fCEY1vQf9hm6CQnWy/du8Pi0BcWJ88w/RrSCbRSfeJYAEfNw3TuCGR+WlLKkRsyZUAN5JrX0h5vesQx3Tol+SeYQxf5nJz/ohO6+Yf0Ez+WSmtLpOFb7PMvVohyA93G1q8jfRVEldAcH4AGkkJwG4imsbdwghCKG7TnUCVYQtnJ6dHvL0xx6dvp1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) by
 PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 22:32:03 +0000
Received: from DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::8adc:80ce:6d72:f512]) by DM4PR12MB6207.namprd12.prod.outlook.com
 ([fe80::8adc:80ce:6d72:f512%5]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 22:32:03 +0000
Message-ID: <e71712c2-3f13-e21c-b8f0-c16f61979e5b@nvidia.com>
Date: Thu, 17 Aug 2023 18:31:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net-next v2] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20230817151941.18692-1-feliu@nvidia.com>
 <CAF=yD-KN=-2fhc2nxxzr-bJ5kwQVFken_iTo4sBbuAkjmbn3fQ@mail.gmail.com>
 <b2edfbbf-1018-745e-2ce4-946ffe27e5e5@nvidia.com>
 <CAF=yD-LBHYk=+ty1zTNnN_cU4NoJe0=VZwHy2zVkQiPVx_9gqw@mail.gmail.com>
In-Reply-To: <CAF=yD-LBHYk=+ty1zTNnN_cU4NoJe0=VZwHy2zVkQiPVx_9gqw@mail.gmail.com>
X-ClientProxiedBy: SA1PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::25) To DM4PR12MB6207.namprd12.prod.outlook.com
 (2603:10b6:8:a6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6207:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3d8680-2cde-4c00-430c-08db9f71c7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGWeqRVgIRZXhfZbnAw0P3zKIdpmV6gnqmbTmCcON5/9PGpobmjdDGjf1WMDNoLkcYwYYteuQNw1fOuBiX9jkMjqHxF3kIbAwU550sRmDAFNC6H65snHPQrMYMdYJXG0RUr16+i81lTFZgiQ1kZNFypMXrVqQ3Hy5EXB5JqEZRd4VfisPmiPUooW9sHFS1DD66ethYp/MR8p5db07LgUFsjzqR9Mu3Uxmc5xEcmbW93ixNgdFPJ3on/RoxEoFzSUw8lUZ5hyexQuQ6zz5ltx7TdR7EdGojSEEJHeoYO+bWt2I3a+/bDcWDHI6AKv/kqoUAFyWH4By7hH0PcMJsXXzeOiZZKJ1Zqjjr4lRfY/PDqnSrWWatumWnR+5XOjnO0LGITwS5dqSbwng0cFenyvN+Mz15ubQukVaLXv2Z++jWR4EXE6NbwAf/fKeXMBjZdAuBFhZfoGewjAp3TwIxdFfPwxHaoXa9AHktRcvM5rT+zLBtgJysmBYrsE30NArjpGtrOwEmEhuP7/fxX2pYQQA/Xax/PySy03rMrDqzmRJmOiCar8Aw2fjjwCXgqT99Xuvp0YcqXWyVMLCMsZKcZI020veXmJrl83lsu6ya4mZer7Ped6WSAvFohy/9lU24Dx4YEaHgTfw6o4Cr70PhWXWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6207.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(107886003)(6666004)(6486002)(2616005)(36756003)(6512007)(5660300002)(41300700001)(54906003)(316002)(66946007)(66476007)(66556008)(6916009)(31686004)(8676002)(4326008)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhFQkh5MnBEMmpwV3ZFd0VvaTdQVUVGTUk3ZkQ2Qmswc0NkTTYxWmpIdXdq?=
 =?utf-8?B?R1B6S2FLM1QyMFBZV0lpcXp3a2s2QTVLbE1WVDk3b1RtUDQ4SG1DSCtHSlBq?=
 =?utf-8?B?MmxNWit5RUtrMXpKV3lrTk9WbUtmcUNkdFN4RkExeGU4MUsxMFZGSzN2ODRT?=
 =?utf-8?B?V255N2VXbUM5RHI2MXUvTUkyNGZGV1pWY0lNOGt2dnlFWVZpcE9WNVlJZmRU?=
 =?utf-8?B?dlZGZHk0K1pnODhvYTNNMWJiNmpCOXFmR0M0Tm4rUm5VcDErMThmQW5SZnEv?=
 =?utf-8?B?THJyMTVFWXRtdWJqY013bkk1cUJwK05nN1VCd1luWTBkS3NSQzlRdVJRUkZN?=
 =?utf-8?B?cnl2MnUvdTcyL0hBNmFQRCtvdmhjd3J5Z253STM5MkxPd05XMXZ1czdZa0k5?=
 =?utf-8?B?NXJ4ZnAyN2ZoYUI2WWw2WnQ1NzRGc3RDL2t3bnVDQWwxQ2hZemxkQlVsdlF2?=
 =?utf-8?B?c3FZMERDTkhESkRSdS82eHlKSHc1d1c5Yit1Z1BpVHNwQ2RxQ1BCazJIdXJ2?=
 =?utf-8?B?M3NtQnJYWGxzdXFnbGFCRC8yQTJQV2R4Snh2aDRrSy9KS1NxMzBiVDhzQTgv?=
 =?utf-8?B?aUc4NGl4N0xuSEZwN3dBVytXY3Q4KzJ6NkpibFU4UjdBVS9oeW1qK1lzUmFN?=
 =?utf-8?B?Q0IyMjRoVW5zMTRTaUVpcUFmYzd2bytJNEJwNlBZWjEweHE2SlJCWlVURlIr?=
 =?utf-8?B?SjY5cnhUb1JHQnBOSU91VWJmc3N2NFhVMXYzSlZXa2tNZlVROGRMdCtObkUz?=
 =?utf-8?B?RU41Nk9Oc25LemRrTnB6WnZkVFVLYTNyN2xaUllvUHQ0VitGYi9qdVNmNm11?=
 =?utf-8?B?WURHeGxSbHAxaXIvUzhXVC9Ga1d3WWpFRWtCWk9weFVIMjBYK2VlTHVBeUtx?=
 =?utf-8?B?b2hLN1ZCM0FNcVVzUjA0OCtxdFRja3RFV3J0SDNHTDQzOFFkQjh6L3dvck1y?=
 =?utf-8?B?WUFBc2xacTByejgxM3lVbWFOaG42dXh2d3pHYkpENmRhSnVsckZzNSsvTzla?=
 =?utf-8?B?Z1c2anNEa1E4b1pCZXMvZFdyVnVYYmVONy9MU2Zad1VUYWo2ZEF2SzJWYzJG?=
 =?utf-8?B?VlR4Nm9ENU5hOUpjcEozOXVDV2RNL0IrcE5xRzE0NUNqYUQxaW12TUlyNnlU?=
 =?utf-8?B?WU9DWWtkd01tcWJ1MCtBRVJaeURyZkRjdHAvcS9PU3BQUmI5NE1QWkRIOW9x?=
 =?utf-8?B?SGx3L3FjTkkxcVpNOTkzMTdMdStLUHdkcjZxWndtcU8xb1orbU1DaWJ0NFpS?=
 =?utf-8?B?bVNzMEVVTVZ0aU1od1N0QXd6U1Vlbm93WUNWSlY3L3FXckdiR0VWL0ZjcE9m?=
 =?utf-8?B?NUlOTnZrWHM3VFNVR1h2aVcydmJ4MkN4MW0remlzZk5CeVRHRnNPNmxBeTBO?=
 =?utf-8?B?U1F3OVYxSnZBZWdSWkVHMzBHbEZuMnBxcE12V0VNT3gwZllJblFaRjBJMzlw?=
 =?utf-8?B?NGhJWHQxWlAzNjNUYTFQYUFWbXlDcS9TT3BuM3ZJcFNpTTFnTTVQaDR1Vlll?=
 =?utf-8?B?dXJYRFhKckpNK2w3T3ZRaUJOWk1hNkJscStMRU1kTFF6eU9jZ1hWU0tNbi9l?=
 =?utf-8?B?T0dHc2JBR1owOVN1Ti82b3NTUG50OFo5c3MxOE03ZDVxd2hIa2NGNzVwa3Zz?=
 =?utf-8?B?MU5HWStjWFNEaERWaUJyblA5cUxuaDJoeUkycytzcDRWZzNnbGpINUJaL054?=
 =?utf-8?B?RThKVWZPMUJsT1NBYnFBaDFWeEhYL0tJczZ3MkR3VmRZTWtkM2QwN1NTeDJz?=
 =?utf-8?B?bDRrRlV5OGV1MFZsVDhGcmRKUHRJQlZFdzNxTWpNaDRZd2E3a1kwdVZwZXNY?=
 =?utf-8?B?N2h5eVpuNU1qTUdueVFmMmpGYmxpNUE4Um5yL3ZNQW5BMUN5ekFlNmdORzRJ?=
 =?utf-8?B?Q1A5ZVBjKytwOVJoMmRXZ3BQWW1EckhZU0hzUk00bS94bkplR3NzUWZDY3V3?=
 =?utf-8?B?TmdnL0dvMW81TS9FMGIxQzNNK3BQQTVWS3dvdDVKQWRVeHZCcXg0YW1jQWRM?=
 =?utf-8?B?UXozN3BGOGdsdmNLREdMM2F3VzR6M2ErL3Q0RWtQTUpTWUlGMnNXQ0hxUnM1?=
 =?utf-8?B?cU0raE5nYnQvTVBTS3NIQUd4NWd3clJ2YWVreUxud0k3MjJnTk9Nd0l3c0xM?=
 =?utf-8?Q?Aci4lqKmlxvGgl/OVcVmohFpL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3d8680-2cde-4c00-430c-08db9f71c7d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 22:32:03.7327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr9pGE0HTMmgxRracOphNeTnMDmQBQnn7QBX8gBDAldGDmb52rxoTMvqo32leYCKIIE4XyN8wkRKHDVluJLNkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Bodong Wang <bodong@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
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

CgpPbiAyMDIzLTA4LTE3IHAubS42OjExLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgoKPj4+IFlv
dSBtZWFuIHZpcnRpb19uZXRfY29tbW9uX2hkcj8KPj4+Cj4+IEl0IGlzIGEgdHlwbywgd2lsbCBj
b3JyZWN0IGl0Lgo+Pgp3aWxsIGRvCgo+Pj4gSSdtIG5vdCBzdXJlIEkgZm9sbG93IHRoZSByZWFz
b25pbmcuIEJlY2F1c2UgdGhlbiBoZHJfbGVuIG1pZ2h0IGJlCj4+PiBzaXplb2YodmlydGlvX25l
dF9oZHJfbXJnX3J4YnVmKSwgYnV0IHNpemVvZih2aXJ0aW9fbmV0X2NvbW1vbl9oZHIpIGlzCj4+
PiBsYXJnZXIuIFNvIHRoZSBzYW1lIGlzc3VlIHJlbWFpbnM/Cj4+Pgo+PiBzdGF0aWMgaW50IHZp
cnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+IHsKPj4gWy4uLl0KPj4g
ICAgICAgICAgaWYgKHZpLT5oYXNfcnNzX2hhc2hfcmVwb3J0KSB7Cj4+ICAgICAgICAgICAgICAg
ICAgdmktPmhkcl9sZW4gPSBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxX2hhc2gpOyAv
KiBoZHJfbGVuIHdpbGwKPj4gYmUgMjAgYnl0ZXMgKi8KPj4gICAgICAgICAgfQo+PiAgICAgICAg
ICBlbHNlIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX01SR19SWEJV
RikgfHwKPj4gICAgICAgICAgICAgICAgICAgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJ
T19GX1ZFUlNJT05fMSkpCj4+ICAgICAgICAgICAgICAgICAgdmktPmhkcl9sZW4gPSBzaXplb2Yo
c3RydWN0IHZpcnRpb19uZXRfaGRyX21yZ19yeGJ1Zik7Cj4+ICAgICAgICAgIGVsc2UKPj4gICAg
ICAgICAgICAgICAgICB2aS0+aGRyX2xlbiA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9oZHIp
Owo+PiBbLi4uXQo+PiB9Cj4+Cj4+IFdoZW4gVklSVElPX05FVF9GX0hBU0hfUkVQT1JUIGlzIGVu
YWJsZWQsIGhkcl9sZW4gPSAyMCAoYXMgYWJvdmUpOyBhbmQKPj4gdGhlIHNpemUgb2YgdmlydGlv
X25ldF9oZHJfbXJnX3J4YnVmIGlzIDEyLCBzbyB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYKPj4g
aXMgd3JvbmcsIHNob3VsZCB1c2Ugc3RydWN0IHZpcnRpb19uZXRfY29tbW9uX2hkciBoZXJlLgo+
IAo+IEkgdW5kZXJzdGFuZCBpbiB0aGlzIHNwZWNpZmljIGluc3RhbmNlLiBJJ20ganVzdCBzYXlp
bmcgdGhhdCB1c2luZyBzaXplb2YgY2FuCj4gYmUgd3JvbmcgYm90aCBpbiB0aGUgbmV3IGFuZCBv
bGQgY2FzZS4KPiAKPiBUaGlzIGRvZXMgbm90IGZpeCBhIHJlYWwgYnVnLCBhcyBtZW1jcHkganVz
dCB1c2VzIGhkcl9sZW4sIHdoaWNoIGlzIGNvcnJlY3QuCj4gCkFscmVhZHkgaGF2ZSB1c2VkIGhk
cl9sZW4gaW4gdGhlIHBhdGNoIGluc3RlYWQgb2Ygc2l6ZW9mKCpoZHIpCgo+Pj4gSW5kZWVkLCBl
dmVyeXdoZXJlIHRoaXMgcGF0Y2hlcyByZXBsYWNlcyB0aGUgb25lIHdpdGggdGhlIG90aGVyLCB5
b3UKPj4+IGhhdmUgdG8gdmVyaWZ5IHRoYXQgbm90aGluZyB3YXMgdXNpbmcgc2l6ZW9mKCpoZHIp
LiBXaGljaCB3b3VsZCBub3QgYmUKPj4+IHZpc2libGUgZnJvbSB0aGUgdHJ1bmNhdGVkIHBhdGNo
IGNvbnRlbnRzIGl0c2VsZi4KPj4+Cj4+IEhhdmUgY2hlY2tlZC4gTm90aGluZyBpcyB1c2luZyBz
aXplb2YoKmhkcikuCj4gCj4gVGhhbmtzLgo6LUQKCj4+Cj4+Pj4KPj4+PiBDaGFuZ2UgbG9nCj4+
Pj4gdjEtPnYyCj4+Pj4gZmVlZGJhY2sgZnJvbSBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxsZW1kZWJy
dWlqbi5rZXJuZWxAZ21haWwuY29tPgo+Pj4+IGZlZWRiYWNrIGZyb20gU2ltb24gSG9ybWFuIDxo
b3Jtc0BrZXJuZWwub3JnPgo+Pj4+IDEuIGNoYW5nZSB0byB1c2UgbmV0LW5leHQgdHJlZS4KPj4+
PiAyLiBtb3ZlIHNrYl92bmV0X2NvbW1vbl9oZHIgaW5zaWRlIGtlcm5lbCBmaWxlIGluc3RlYWQg
b2YgdGhlIFVBUEkgaGVhZGVyLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogRmVuZyBMaXUgPGZl
bGl1QG52aWRpYS5jb20+Cj4+Pj4gUmV2aWV3ZWQtYnk6IEppcmkgUGlya28gPGppcmlAbnZpZGlh
LmNvbT4KPj4+PiAtLS0KPj4+PiAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAzNiArKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwg
MjMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4g
aW5kZXggMTI3MGM4ZDIzNDYzLi4wM2NmNzQ0ZGU1MTIgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+
Pj4gQEAgLTMwMyw2ICszMDMsMTMgQEAgc3RydWN0IHBhZGRlZF92bmV0X2hkciB7Cj4+Pj4gICAg
ICAgICAgIGNoYXIgcGFkZGluZ1sxMl07Cj4+Pj4gICAgfTsKPj4+Pgo+Pj4+ICtzdHJ1Y3Qgdmly
dGlvX25ldF9jb21tb25faGRyIHsKPj4+PiArICAgICAgIHVuaW9uIHsKPj4+PiArICAgICAgICAg
ICAgICAgc3RydWN0IHZpcnRpb19uZXRfaGRyX21yZ19yeGJ1ZiBtcmdfaGRyOwo+Pj4+ICsgICAg
ICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9oZHJfdjFfaGFzaCBoYXNoX3YxX2hkcjsKPj4+
PiArICAgICAgIH07Cj4+Pj4gK307Cj4+Pgo+Pj4gUGVyaGFwcyBldmVuIGFkZCBpbiBzdHJ1Y3Qg
dmlydGlvX25ldF9oZHIuIEFzIHRoYXQgaXMgdGhlIG9yaWdpbmFsIG9mCj4+PiB0aGUgdGhyZWUg
c3RydWN0cywgYW5kIGFsbCB0aGUgaW5pdGlhbCBmaWVsZHMgb3ZlcmxhcC4KPj4+Cj4+Cj4+IEJ1
dCBJIGRpZG4ndCB1c2UgdmlydGlvX25ldF9oZHIgaW4gdGhpcyBwYXRjaCwgaXMgaXQgcmVkdW5k
YW50IHRvIHB1dCBpdAo+PiBoZXJl77yfIHdoYXQgZG8geW91IHRoaW5rPwo+IAo+IFRoYXQncyB0
cnVlLiBCdXQgaWYgd2UncmUgZ29pbmcgdG8gYWRkIGEgaGVscGVyIHRvIGJpbmQgdG9nZXRoZXIg
YWxsbCB0aGUKPiB2aXJ0aW8gdmFyaWFudHMsIHRoZW4gSSB0aGluayBpdCBzaG91bGQgYmUgdGhl
cmU/Cj4gCj4gTm8gc3Ryb25nIG9waW5pb24uIExlYXZlIG91dCBpZiB5b3UgcHJlZmVyIGFuZCBu
byBvbmUgZWxzZSBzcGVha3MgdXAuCj4gCndpbGwgZG8KCj4+Pj4gQEAgLTE1NzcsNyArMTU4NSw4
IEBAIHN0YXRpYyB2b2lkIHJlY2VpdmVfYnVmKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1
Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4+Pj4gICAgewo+Pj4+ICAgICAgICAgICBzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2ID0gdmktPmRldjsKPj4+PiAgICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNr
YjsKPj4+PiAtICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKmhkcjsKPj4+
PiArICAgICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2NvbW1vbl9oZHIgKmNvbW1vbl9oZHI7Cj4+Pj4g
KyAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVmICptcmdfaGRyOwo+Pj4KPj4+
IE5vIG1vcmUgbmVlZCBmb3IgdGhpcyBzZWNvbmQgc3RydWN0IG5vdyB0aGF0IHdlIGhhdmUgdGhl
IHVuaW9uLiBUaGF0J3MKPj4+IGl0cyB3aG9sZSBwdXJwb3NlPwo+Pgo+PiBZZXMsIHN0cnVjdCB2
aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKm1yZ19oZHIgaXMgbm90IG5lZWRlZC4gV3JpdGluZwo+
PiBtcmdfaGRyIGhlcmUgaXMganVzdCB0byBtYWtlIHRoZSBjb2RlIGxvb2sgbW9yZSBjb25jaXNl
LCBzdWNoIGFzCj4+IG1yZ19oZHItPmhkci5mbGFncywgaWYgbXJnX2hkciBpcyBub3QgdXNlZCwg
aXQgc2hvdWxkIGJlIHdyaXR0ZW4gYXMKPj4gY29tbW9uX2hkci0+bXJnX2hkci5oZHIuZmxhZ3Ms
IEkgdGhpbmsgaXQgbG9va3MgdG9vIGxvbmcuIHdoYXQgeW91IHRoaW5rPwo+IAo+IElmIHdlJ3Jl
IGdvaW5nIHRvIGNvbnRpbnVlIHRvIGFzc2lnbiB0byBkaWZmZXJlbnQgc3RydWN0cywgdGhlbiBJ
J20gaG9uZXN0bHkKPiBub3Qgc3VyZSBob3cgbXVjaCB0aGlzIHBhdGNoIGJ1eXMgdXMuCj4gCj4g
QWRkaW5nIHZpcnRpb19uZXRfaGRyIHRvIHRoZSB1bmlvbiBhbHNvIHNob3J0ZW5zIHRoZSBjb2Rl
IGJ0dy4gVGhlbiBpdAo+IGNhbiBiZSBjb21tb25faGRyLT5oZHIuZmxhZ3MKPiAKPiBBbHNvLCBq
dXN0IGEgc2hvcnRlciB2YXJpYWJsZSBuYW1lIHRoYW4gY29tbW9uX2hkci4gRmluZSB0byBjYWxs
IGl0IGhkci4KPiAKd2lsbCBkbwoKPj4KPj4+Pgo+Pj4+ICAgICAgICAgICBpZiAodW5saWtlbHko
bGVuIDwgdmktPmhkcl9sZW4gKyBFVEhfSExFTikpIHsKPj4+PiAgICAgICAgICAgICAgICAgICBw
cl9kZWJ1ZygiJXM6IHNob3J0IHBhY2tldCAlaVxuIiwgZGV2LT5uYW1lLCBsZW4pOwo+Pj4+IEBA
IC0xNTk3LDE4ICsxNjA2LDE5IEBAIHN0YXRpYyB2b2lkIHJlY2VpdmVfYnVmKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpLCBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4+Pj4gICAgICAgICAgIGlm
ICh1bmxpa2VseSghc2tiKSkKPj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm47Cj4+Pj4KPj4+
PiAtICAgICAgIGhkciA9IHNrYl92bmV0X2hkcihza2IpOwo+Pj4+ICsgICAgICAgY29tbW9uX2hk
ciA9IHNrYl92bmV0X2NvbW1vbl9oZHIoc2tiKTsKPj4+PiAgICAgICAgICAgaWYgKGRldi0+ZmVh
dHVyZXMgJiBORVRJRl9GX1JYSEFTSCAmJiB2aS0+aGFzX3Jzc19oYXNoX3JlcG9ydCkKPj4+PiAt
ICAgICAgICAgICAgICAgdmlydGlvX3NrYl9zZXRfaGFzaCgoY29uc3Qgc3RydWN0IHZpcnRpb19u
ZXRfaGRyX3YxX2hhc2ggKiloZHIsIHNrYik7Cj4+Pj4gKyAgICAgICAgICAgICAgIHZpcnRpb19z
a2Jfc2V0X2hhc2goJmNvbW1vbl9oZHItPmhhc2hfdjFfaGRyLCBza2IpOwo+Pj4+Cj4+Pj4gLSAg
ICAgICBpZiAoaGRyLT5oZHIuZmxhZ3MgJiBWSVJUSU9fTkVUX0hEUl9GX0RBVEFfVkFMSUQpCj4+
Pj4gKyAgICAgICBtcmdfaGRyID0gJmNvbW1vbl9oZHItPm1yZ19oZHI7Cj4+Pj4gKyAgICAgICBp
ZiAobXJnX2hkci0+aGRyLmZsYWdzICYgVklSVElPX05FVF9IRFJfRl9EQVRBX1ZBTElEKQo+Pj4+
ICAgICAgICAgICAgICAgICAgIHNrYi0+aXBfc3VtbWVkID0gQ0hFQ0tTVU1fVU5ORUNFU1NBUlk7
Cj4+Pj4KPj4+PiAtICAgICAgIGlmICh2aXJ0aW9fbmV0X2hkcl90b19za2Ioc2tiLCAmaGRyLT5o
ZHIsCj4+Pj4gKyAgICAgICBpZiAodmlydGlvX25ldF9oZHJfdG9fc2tiKHNrYiwgJm1yZ19oZHIt
PmhkciwKPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0aW9faXNf
bGl0dGxlX2VuZGlhbih2aS0+dmRldikpKSB7Cj4+Pj4gICAgICAgICAgICAgICAgICAgbmV0X3dh
cm5fcmF0ZWxpbWl0ZWQoIiVzOiBiYWQgZ3NvOiB0eXBlOiAldSwgc2l6ZTogJXVcbiIsCj4+Pj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+bmFtZSwgaGRyLT5oZHIu
Z3NvX3R5cGUsCj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhkci0+
aGRyLmdzb19zaXplKTsKPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZGV2LT5uYW1lLCBtcmdfaGRyLT5oZHIuZ3NvX3R5cGUsCj4+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1yZ19oZHItPmhkci5nc29fc2l6ZSk7Cj4+Pj4gICAgICAgICAg
ICAgICAgICAgZ290byBmcmFtZV9lcnI7Cj4+Pj4gICAgICAgICAgIH0KPj4+Pgo+Pj4+IEBAIC0y
MTA1LDcgKzIxMTUsNyBAQCBzdGF0aWMgaW50IHhtaXRfc2tiKHN0cnVjdCBzZW5kX3F1ZXVlICpz
cSwgc3RydWN0IHNrX2J1ZmYgKnNrYikKPj4+PiAgICAgICAgICAgaWYgKGNhbl9wdXNoKQo+Pj4+
ICAgICAgICAgICAgICAgICAgIGhkciA9IChzdHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVm
ICopKHNrYi0+ZGF0YSAtIGhkcl9sZW4pOwo+Pj4+ICAgICAgICAgICBlbHNlCj4+Pj4gLSAgICAg
ICAgICAgICAgIGhkciA9IHNrYl92bmV0X2hkcihza2IpOwo+Pj4+ICsgICAgICAgICAgICAgICBo
ZHIgPSAmc2tiX3ZuZXRfY29tbW9uX2hkcihza2IpLT5tcmdfaGRyOwo+Pj4+Cj4+Pj4gICAgICAg
ICAgIGlmICh2aXJ0aW9fbmV0X2hkcl9mcm9tX3NrYihza2IsICZoZHItPmhkciwKPj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRpb19pc19saXR0bGVfZW5kaWFu
KHZpLT52ZGV2KSwgZmFsc2UsCj4+Pj4gLS0KPj4+PiAyLjM3LjEgKEFwcGxlIEdpdC0xMzcuMSkK
Pj4+PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
