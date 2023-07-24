Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B62C001DE
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 13:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C41640003;
	Mon, 24 Jul 2023 13:14:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C41640003
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B3FDKSk4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id egopeBi0rWin; Mon, 24 Jul 2023 13:14:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AB42A40CCF;
	Mon, 24 Jul 2023 13:14:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB42A40CCF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 737C6C0072;
	Mon, 24 Jul 2023 13:14:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27926C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 13:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDE2440985
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 13:14:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDE2440985
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=B3FDKSk4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UIEWiBF7u7Ct
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 13:14:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C92BB4159D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 13:14:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C92BB4159D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYHwfwGxNnPXuqfVmmqJmVLn3EBlFeTf4mlkM3i79T01P6iM7tMTDZO4FqTOwxWKMSSFq1DMhQCgRmtouM7/MQqEUGZpzhqlHIdo9+zfVCt+6O90tebw0ye01FOHq2RANyZo3jsS4n/duotBv6xaqiCwVI0VoE++IXjKbHwSkypjivea8VezOoFgyk3MJGWsnQ6uAJbOtQk37tWG/wDYzbO+FotRXk424cqHCou2jNI5H5lMzVPAYpRW2dRjL1IDUuH8FuE0UbvBgDMWQen9VJsOdJLVTQXHlEasmfsi6+xv8U+raNGEA0tXJpAUpkzOFo23+j2YoFgKh8svEc74Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xkb6FTw2EvmbfzjF9UZXK8QcBZzSlB4/HmIaOI6Jj5Q=;
 b=Wsm4lYUvc5YjuMjb+NRWNsE0tIz23LI15PCj5zzKBGUp0evvlE4U5jLM5xnQGOynLSTfhjZVM1jjPuNbfpiUNljOLJXw7Cz48yG1Ne+4cH0sKl37puhfT8ETCOdFZx8SbWPouLCg6aoYJwUvAq0ccCT+a/J5EjuFlP5j2mKYgKx7zgk7sEIshrPWwUH80hAu+oYHFTvJ1AcjZOB5smsrfSCwmjbDrChaBcyCRALPLym7kaYNKPthJkakzikjBA033YcobTpn3Wp8FdGgl3389yfyxG9lgTgg98xo7veccavVHSLPwpQx+iU3SKykYAW/+3zqwTbFk+ihh2o97Wia1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xkb6FTw2EvmbfzjF9UZXK8QcBZzSlB4/HmIaOI6Jj5Q=;
 b=B3FDKSk46F+OL/NCvI/BfUtew7uLEYzyrYzLX8IKxRTP/kPJzn0ueCFAZiAIhlqai3iymvr9EYkRreyioYRkB+fchjzCKL3jpfWh2oaaVouijLLiLEgBCQSGftgb99oq9Jyc6TMv3AfVbyT+VASG+3x+wcFeLOFWa2TNhsdbm66WqPDYwvtDYCdPNgMBQLmp20HXAKC4iqVIhgB0kvAxBL1fryZTfTinojDqIwG+s+ZkrSNv/AqzFb1MvaD7cbadytx1EWgXGFYNrJDa0cbNBipnZJUt+kConPbFXZ88R7/xPboVUagzJyTtnleJD6wbUakawicqnhGb/m0i+pfVmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 13:14:36 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:14:36 +0000
Message-ID: <c1bfdfd3-e7b5-56dd-39a6-b93c43da42eb@nvidia.com>
Date: Mon, 24 Jul 2023 09:14:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
 <20230720131423-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230720131423-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SN7PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:f2::6) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: a1554f7d-f2b8-4b1b-5d7d-08db8c47edc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWtOLxo2vmh+Phf7CwJGuX1hWmYEJK321K0oEGZp9i+sjHEsyWm6SbMuTjTbZBVtn11XPvgnroy8/EOSSvAkt0r2tV5XKLfe743rMBJV0hMU2+/6EaIPIP6rvvEtAn/mFHHBD6lqoQ97QfxQpWuaFRy7+BUBX6Nz4MFKBmEeK5dGe4zm62Tf0uiFbcXTR2383NGrAdB6xkQ6R3WkSdmiqorXVbslrrNKSJ4oyPplek9TLoicYgOoUkJfIPctbhinXei1aCb1WaH7DNhu8LUxPQdk0rf4jZx9klW5x00jls33bk5cT2vR+bgPz+FSDnI9qN1X8poGMnZviIzf92sWaYp6WmKOyBI5zuK/D9h9PLdtDzGiJoLLW3mENcSZU8MXkFoQqtYN5YaW2EZVWNrGgSeYH4/PgDQV63PsFKd+LYA4dxY1/6zBnrHiSkjqBtxGSjXFlFjAc9WpTn0LT/PR1JulWaSYU9uSYg0agEV1rDhADLLo3gp7GieqrEybdIvvnC6ByXksy0Ywya6kv3b62/Uaw7Ce7qWfaBx15aXONSoZQzKO8LGe6n+EOO9RjxjsS8pjXSo0euxmr7CxRGi/E8hAyawV7MOH2xs7qGUODs12fnA8v+mHtGvFdjw4alkdjQ7v+ZG14NPHRqP/LiiE3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(38100700002)(53546011)(2616005)(107886003)(36756003)(83380400001)(8676002)(110136005)(8936002)(5660300002)(478600001)(54906003)(66556008)(66476007)(316002)(4326008)(66946007)(41300700001)(186003)(26005)(6506007)(2906002)(6512007)(6486002)(6666004)(31696002)(31686004)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1AxcnhaNEswTlhBNnhUczNySnlHTVZnNFFKbmNSSUUwV3hmUmh6OVlYcitW?=
 =?utf-8?B?a1lDdUJsSkxiVTkweXdwRWZtUGFyaVRFaUNHMXcwVkhMalIrd3VBQ1ZtZ0Vo?=
 =?utf-8?B?dEtNY212ckphQmVGMXNCVThPTEpML0JuQnNzNExjWFU0WEh4K3NSTndDUC9n?=
 =?utf-8?B?RTBwd1ZyU1NjSmdWQk9vcjllKzFISTZjY1UrSXNuK3Q2SVNkSktrN0IralJP?=
 =?utf-8?B?U1dqbXdzcVB2Zk1CTitIQWxndnd2RnRjK1FCVGxrOTJRYldJQ1NhSDJjdmdW?=
 =?utf-8?B?UzcxRzZ3S1VKNklOMjFUUnBOR2Yxb01ORTBYWmY3R2FSZ1BJSTJCUXZQdWV2?=
 =?utf-8?B?MkFPSzQ2V0ZZcENNZGVvenlWWVNySU1jam40aER5cEZtOUdEM2pUR1N2aUJi?=
 =?utf-8?B?ZUg5YmpwVlJadHBwdUt4NnlvSGUyR3poWG1GK2kwNHpnTFNSOUVuemNpUENy?=
 =?utf-8?B?MTdaeTRoaGtCR0laWDFSVWpManRrbUlaUThmRHFwWlVMck1EemN1c25rRmVF?=
 =?utf-8?B?b2hmcDV1TEJ6Rk9vUkZjUGxncnNkWk4xWllyT3NIY3FZQ1dqVVp2akN1WDRP?=
 =?utf-8?B?RHpUbWdGbE1SSTVkb3RIYUwrK09SUy9LV0J3dTBMS2pTRTR1ZnMyeVFZdmZK?=
 =?utf-8?B?YkdRVmhiMHpRdzdFbU9tKzFhWVoxaXZGVXhhaGMxdDhrUzlpTEdFcW04WWZC?=
 =?utf-8?B?ME1wUitVZDhaSWZpZFVvdmdDSzZhKys4THdYOTk3V21yaGtqOEk0SVIxN2NS?=
 =?utf-8?B?OW5NL1I3a2RpS3I5dVlYSnZUUXNpR044QVFwWFluWnVJYnY3eEkrRWZwaVpN?=
 =?utf-8?B?Q3A0ZkFGOU40bFkxVVoyVXRmQ0dwbXFkajFJNEZjbTJJVjZJQ2hsR1FQUlZ3?=
 =?utf-8?B?Zy9wbjZyb1BKNzNsTmx0TFNUY2pvUmNCZGF3Q0dTbGR3bFlhcXRudjF1Y1gv?=
 =?utf-8?B?QXJHL29IN2ZPTnJwMXNUYUxodGZ2ZkUwQ1pkN2NEd09WTEg0cm1ISC9YMlVZ?=
 =?utf-8?B?YXBBeDJjYm93M2dqeHV3bGhnd0pmTTZOSklxYjYxb1R3ZXNhbjRJaHBxaVZW?=
 =?utf-8?B?QTU1T2ZkcUZROC9jb1p2Y2JlVnZ6VERJdENFT1k0NXM5bXZBRGNwemRsMncy?=
 =?utf-8?B?YVBxUk5CWUlObjhQYkE3SDFqUDd4R0N0a0pJazlXakgyYmtoWG1mQ0RZSC9m?=
 =?utf-8?B?aVQwMG84NVdBTTJycUlIRTR1bzBNcjBIaVJNczF5TXhUaUFncnI1aExmckFu?=
 =?utf-8?B?bVhpbVZBYzQrTElwWWkvTUkra3duNFJrdGJuZklUQlJwMTQxQTVYazl0TXBE?=
 =?utf-8?B?NVVDUXJIRVl3a3J6V21MZHM1aFQ5Wk81Y1VvL1RBRmRqQ1o5dHBSaHNuRm1y?=
 =?utf-8?B?OGZjL3pJZjRHZlBBSlhBYU5PMCtRZ0ttTkVXVWwyRS82SFNhUktyWmxpaW1l?=
 =?utf-8?B?SFRyNjRzWUUzbStlNmsvVlZkdmxDWTZIcVdpWkJ1NWJkVUhxVFl3RWs4dTk3?=
 =?utf-8?B?a1pFenlsRUVTUTAxRHFBYVRLZExxcVJFazRxWXRJNEhCS3doNDdoVUhVdDRl?=
 =?utf-8?B?NFBBbUJ4UHFBL1ZBZGM2c0dteXhBQ3hEdmlORDEvdjZWeTBCTkJrZzMvdzBL?=
 =?utf-8?B?cncvbjYxS0paUkNOQjRmZ21IOSt1MERla2J2ODZQdEpiSUJQQkRkR1o4U0I2?=
 =?utf-8?B?WFdGUU4wUjVLQk9FMWd6UUNVYllIMXptazlqREUxem5QK0dvK284aVhNSGNR?=
 =?utf-8?B?Rm8wb1VVQmtKSkllYjVwNEpDVnN6RGhUOHBoWTJDMEllUFpQTlBoeFlCVlNv?=
 =?utf-8?B?QWl3dFF5TEFDS0ZvNmJtcGFaYUREeTNXYm1BM1h1N0Z5UEQ4NEE3QWlJQ1Vl?=
 =?utf-8?B?U0hXZ3F0OWlkWFYxSUtRUzZhaHBRWityRU83N0dkcUJ1dURINCtUT1pIak1C?=
 =?utf-8?B?NXNzU2RLM1JjZFZQWmlnNzkyU1hLKzdCYkxmZnNzYnBjQVJ0OHI2eCtiNHFB?=
 =?utf-8?B?RFg0NStjNkNwWGpYVmhTcmtveXl2QWhoaWJNM3B3ZFg0Q1FFYnVadXVnY3ZG?=
 =?utf-8?B?a1JhaWRiYjlkNVNCNlZ1T1ZyVTVsazN6U3hvc2ZQaW00ekRUMUI0empWS0VW?=
 =?utf-8?Q?x1e5hGiAFR3HDxMoZnrn2GP2d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1554f7d-f2b8-4b1b-5d7d-08db8c47edc4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:14:36.4859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUrcr3/9imyy0za8mmy30nhi3TK3em+Mlv7oVgA5tXh/X6uN9LfLCaEGFelmeQYVOzKqwnW3Je/NmDDy12dgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>
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

CgpPbiAyMDIzLTA3LTIwIHAubS4xOjE0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPiAK
PiAKPiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAxMDoyNzowNEFNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+PiBPbiBXZWQsIEp1bCAxOSwgMjAyMyBhdCAxMTo0NuKAr1BNIEZlbmcgTGl1IDxm
ZWxpdUBudmlkaWEuY29tPiB3cm90ZToKPj4+Cj4+PiBUaGUgJ2lzX2xlZ2FjeScgZmxhZyBpcyB1
c2VkIHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiBsZWdhY3kgdnMgbW9kZXJuCj4+PiBkZXZpY2Uu
IEN1cnJlbnRseSwgaXQgaXMgYmFzZWQgb24gdGhlIHZhbHVlIG9mIHZwX2Rldi0+bGRldi5pb2Fk
ZHIuCj4+PiBIb3dldmVyLCBkdWUgdG8gdGhlIHNoYXJlZCBtZW1vcnkgb2YgdGhlIHVuaW9uIGJl
dHdlZW4gc3RydWN0Cj4+PiB2aXJ0aW9fcGNpX2xlZ2FjeV9kZXZpY2UgYW5kIHN0cnVjdCB2aXJ0
aW9fcGNpX21vZGVybl9kZXZpY2UsIHdoZW4KPj4+IHZpcnRpb19wY2lfbW9kZXJuX3Byb2JlIG1v
ZGlmaWVzIHRoZSBjb250ZW50IG9mIHN0cnVjdAo+Pj4gdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNl
LCBpdCBhZmZlY3RzIHRoZSBjb250ZW50IG9mIHN0cnVjdAo+Pj4gdmlydGlvX3BjaV9sZWdhY3lf
ZGV2aWNlLCBhbmQgbGRldi5pb2FkZHIgaXMgbm8gbG9uZ2VyIHplcm8sIGNhdXNpbmcKPj4+IHRo
ZSAnaXNfbGVnYWN5JyBmbGFnIHRvIGJlIHNldCBhcyB0cnVlLiBUbyByZXNvbHZlIGlzc3VlLCB3
aGVuIGxlZ2FjeQo+Pj4gZGV2aWNlIGlzIHByb2JlZCwgbWFyayAnaXNfbGVnYWN5JyBhcyB0cnVl
LCB3aGVuIG1vZGVybiBkZXZpY2UgaXMKPj4+IHByb2JlZCwga2VlcCAnaXNfbGVnYWN5JyBhcyBm
YWxzZS4KPj4+Cj4+PiBGaXhlczogNGYwZmMyMjUzNGUzICgidmlydGlvX3BjaTogT3B0aW1pemUg
dmlydGlvX3BjaV9kZXZpY2Ugc3RydWN0dXJlIHNpemUiKQo+Pj4gU2lnbmVkLW9mZi1ieTogRmVu
ZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+Cj4+PiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxw
YXJhdkBudmlkaWEuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IEppcmkgUGlya28gPGppcmlAbnZpZGlh
LmNvbT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwg
MiAtLQo+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgMSArCj4+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+PiBpbmRleCBhNmM4NmY5MTZkYmQuLmMyNTI0
YTcyMDdjZiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9u
LmMKPj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPj4+IEBAIC01
NTcsOCArNTU3LDYgQEAgc3RhdGljIGludCB2aXJ0aW9fcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2
ICpwY2lfZGV2LAo+Pj4KPj4+ICAgICAgICAgIHBjaV9zZXRfbWFzdGVyKHBjaV9kZXYpOwo+Pj4K
Pj4+IC0gICAgICAgdnBfZGV2LT5pc19sZWdhY3kgPSB2cF9kZXYtPmxkZXYuaW9hZGRyID8gdHJ1
ZSA6IGZhbHNlOwo+Pj4gLQo+Pj4gICAgICAgICAgcmMgPSByZWdpc3Rlcl92aXJ0aW9fZGV2aWNl
KCZ2cF9kZXYtPnZkZXYpOwo+Pj4gICAgICAgICAgcmVnX2RldiA9IHZwX2RldjsKPj4+ICAgICAg
ICAgIGlmIChyYykKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xl
Z2FjeS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+Pj4gaW5kZXggMjI1
N2YxYjNkOGFlLi5kOWNiYjAyYjM1YTEgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2xlZ2FjeS5jCj4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xl
Z2FjeS5jCj4+PiBAQCAtMjIzLDYgKzIyMyw3IEBAIGludCB2aXJ0aW9fcGNpX2xlZ2FjeV9wcm9i
ZShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldikKPj4+ICAgICAgICAgIHZwX2Rldi0+
Y29uZmlnX3ZlY3RvciA9IHZwX2NvbmZpZ192ZWN0b3I7Cj4+PiAgICAgICAgICB2cF9kZXYtPnNl
dHVwX3ZxID0gc2V0dXBfdnE7Cj4+PiAgICAgICAgICB2cF9kZXYtPmRlbF92cSA9IGRlbF92cTsK
Pj4+ICsgICAgICAgdnBfZGV2LT5pc19sZWdhY3kgPSB0cnVlOwo+Pgo+PiBUaGlzIHNlZW1zIGJy
ZWFrIGZvcmNlX2xlZ2FjeSBmb3IgbW9kZXJuIGRldmljZToKPj4KPj4gICAgICAgICAgaWYgKGZv
cmNlX2xlZ2FjeSkgewo+PiAgICAgICAgICAgICAgICAgIHJjID0gdmlydGlvX3BjaV9sZWdhY3lf
cHJvYmUodnBfZGV2KTsKPj4gICAgICAgICAgICAgICAgICAvKiBBbHNvIHRyeSBtb2Rlcm4gbW9k
ZSBpZiB3ZSBjYW4ndCBtYXAgQkFSMCAobm8gSU8gc3BhY2UpLiAqLwo+PiAgICAgICAgICAgICAg
ICAgIGlmIChyYyA9PSAtRU5PREVWIHx8IHJjID09IC1FTk9NRU0pCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICByYyA9IHZpcnRpb19wY2lfbW9kZXJuX3Byb2JlKHZwX2Rldik7Cj4+Cj4+IFRo
YW5rcwo+IAo+IGRvbid0IHNlZSB0aGUgYnJlYWthZ2UgaGVyZSAtIGNhbiB5b3UgZXhwbGFpbiBh
IGJpdCBtb3JlPwo+IApIaSwgSmFzb24KCkkgYWxzbyB0aGluayB0aGVyZSBpcyBubyBicmVha2Fn
ZSBoZXJlYSBhbmQgZ2F2ZSBhbiBleHBsYW5hdGlvbiBpbiAKYW5vdGhlciBlbWFpbCwgcGxlYXNl
IGhhdmUgYSBzZWUuCgpTbyBhcmUgdGhlcmUgYW55IGNvbW1lbnRzIGFib3V0IHRoaXMgYnVnIGZp
eCBwYXRjaD8gQ2FuIHRoaXMgcGF0Y2ggcGFzcyAKdGhlIHJldmlldz8KClRoYW5rcwpGZW5nCgo+
Pj4KPj4+ICAgICAgICAgIHJldHVybiAwOwo+Pj4gICB9Cj4+PiAtLQo+Pj4gMi4zNy4xIChBcHBs
ZSBHaXQtMTM3LjEpCj4+Pgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
