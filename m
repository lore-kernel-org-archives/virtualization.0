Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444B4C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 10:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C63FA60BCA;
	Mon, 15 Aug 2022 10:14:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C63FA60BCA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BO6sYth7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lQ8Sp-zTaF09; Mon, 15 Aug 2022 10:14:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 24302606C6;
	Mon, 15 Aug 2022 10:14:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24302606C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC470C0032;
	Mon, 15 Aug 2022 10:14:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03F57C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 10:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8B9D81BC2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 10:14:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8B9D81BC2
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=BO6sYth7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ng16mGSixPjg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 10:14:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F403C81BA8
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F403C81BA8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 10:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsjBvl848kme8gj8jduA+PFxtnlEJwf2Hd9CsUvooR/LCAMIf3kpG0ithAl55JUVUnofEUdkdlhPQ2fcq/g3TmIjqJdVGaJ1jV8uPIt03lLpvIQnyPzyC1d37rpDkJepaIemCqSzzV7lI8MLIjlqBSSoSaVq0BnRC+L2sbBfS1uUMynn1qCgsfTFkjATnZE2vMt6J0O+WDsFVcXqDAvjhaP/oqc6teN6wjyWr3nwi4oTbb6h/l1gEO8S7nhBwrXk0pxQiWrgviST8hcJrUanXwnhtlCr9utd+xE/rEvdfJsDj9uQ9u82xvGzuqm7abxWbA10B64mdbgCIM5sN0egsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg19G/aAdqHb1FlMKsip2ZDky1akZ7nl+m2qPdzVSm8=;
 b=OYCrIxc5piyXzM4c3oNCNo5d65lb1yYpRLfv3CbldarpE2lXhq2w6qbLnZO1AYxj+K22SwA90RRCPpHR3A/Bh1RrQy9dhYze8ljailYDb0gMgBi4TuogFRNZ2xju4SJOoblf+OhBIEW0HUHFYwLymq0RFNX7bYJRJCJwfVM9Xg0Ihoa6XP9Xpf97p+fBxDMdzDSDgpWuaeXp7wm5LLRBBnStQOAIRtgU2eBdZ0c9pOZB4L9q1zK37e9Iu6K9ucwEoQlsSbuhJXnjPV5sA+0ERryE1zzGblGOtpUloqSMyL2ou2Hx7IFfXO56dM7nJ1KDZxguuPANGnglcKL6F8fcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg19G/aAdqHb1FlMKsip2ZDky1akZ7nl+m2qPdzVSm8=;
 b=BO6sYth7Swn6HyS8otGBuIsqN1TM823Cnf782QgyoI8NFTnN61kDsubMeO7wyAeOndaihZfExKu3SflXBHLalFc2xBSh5rMiRDoMTZ+X317zJL4vfl+CWiU2n+RsbTUVeHWLAxjLfa7MfzO1GQBKp5FrXqmzlnP0h6Q+uqX8WNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 10:14:06 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Mon, 15 Aug 2022
 10:14:06 +0000
Message-ID: <4fcc4739-2da9-1b89-209c-876129604d7d@amd.com>
Date: Mon, 15 Aug 2022 12:14:00 +0200
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
In-Reply-To: <8caf3008-dcf3-985a-631e-e019b277c6f0@amd.com>
X-ClientProxiedBy: AS8PR04CA0024.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::29) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dec1f74c-2fea-40cb-efdd-08da7ea6e322
X-MS-TrafficTypeDiagnostic: DM6PR12MB4251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntT5Nm+DVq21Iht7tUEmozUIUba3bhwDl2F/TGzuVGaaMIUf6xynoOGYvaa/W3XNm0JoNE+mTv/OrP8at2bGOVdngHNzoGk9gCVd7pVKT7c3ooOsSnhmDMhxW9GGqVrIXO6DXuSunwZf6bIklXjisg0/hcurFvhwvbq8hV0HemVIsTezEUUmpgkEDirGmTY8wyA3HdTH7P/S3INt0VjwBX5I5l3aFc0IywCgbNCI8M5uaZ14o23HqpGFwRhkFA9AhFVxGsXdRUoW2z3gU5QhZIwpsX1of+EOWpSi8Xua8QxTOvG75p+sLZuKRyLf4jIp08kmSTED0ORXQiRTHJRdWsYcZRb6xxQ9rPxwndIIqJp7uwcu42J6/WzV0S4t/oMHaQXQAarH+aq+nOzfIjJxxDwwhsoQe++Ya/JPia43IF8xFbnh2tFlmvWe9f7MDQBzlZ2IIoel8NrRCZI6cO0wqBLW1R+uTXd91G6rYHJt65HThp9mCC11yoAINmLqLauxQM0W1ffGHdHkIGlepNxviBaVwWeWmlis6XBeLL5zZ+i+KfLBXInnNLmdBR4KkAkhadyMNKPXyv0c5+yJ7aFEiCkX7EE8WJqnCjmQhUyMQs1GpB+0ISCPUnczRPO1QyhwWIp8r8Pt7WIHJXD1UFHlG4ctqf7/SUhU4wtvTTgbv9nFvKCaorfz/md0uwwgt1mHGZzkjlhOn4NuU/k0SacidqaVIl52e0QZ8RVxNmV9hYgR95bbOD9XO7g8Zs9Eil7SLXYFsXQ99l9/oNZtcx6xS2ebHmM+pOG8OzvNFDrqp4z3tf3lwT9ODlr/r66YA2YBYUO7pPq9ufw6XPfhXXyBdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(7416002)(8936002)(5660300002)(31696002)(2906002)(86362001)(41300700001)(66476007)(66574015)(186003)(6666004)(2616005)(6506007)(6512007)(83380400001)(478600001)(53546011)(38100700002)(66556008)(4326008)(8676002)(316002)(110136005)(6486002)(36756003)(66946007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFjMnRYVll1ZkRJWHBLYkNhSjE4LzYzYkZlT1hMYnR4eVpoQXB2SUcwUzR6?=
 =?utf-8?B?VEFDL1ExeVhsLyszZTRkaEUyMTB1YkFYZ2ZHWXhrbXZaWkFUKzNLSnhoa3F5?=
 =?utf-8?B?eFljcUxlSUtPclFTbmgwUTlwWWNTZGx1dFZRSlQ1NnhmMk9HOUM1VGtJU1Uz?=
 =?utf-8?B?endvUldLTWQ0SktpVG54anI0ZGtSb0ZUMkkvRXpZTmhjM1JraWdaRnNhZDlG?=
 =?utf-8?B?eHAvaWxTSUZqcGxlVGpkdXZhSFg1SzNtTzMyaVdYRVV2L0pvUm45VTVNUmQ0?=
 =?utf-8?B?aENlTjB3bnNSRWFKUGNjdlg5TnN6VENDMlNDOE1OMFEzVk1YZ0VLazRlL05y?=
 =?utf-8?B?MHBiOU1LRHViZWVid2t4Um1zSHpBdEtZOGYwRTZ5d0JBK0xFay9GZGFFbHpP?=
 =?utf-8?B?VGYxQi9DNm1aN3FjN1g4TE8wZ1NEeXpsOWNDMzZ6dGJNajZWTGhBNmJTMEUv?=
 =?utf-8?B?RzdOVWo4b2NTdFVqb1FqdFNjcVpZWmg3MEpvMWZRWk9qeU5neGNzcFFYcDd2?=
 =?utf-8?B?Zzh1SFRpMHB3a0NkcW5peStFR2F1UG1BMTgyM2lQZnh3ZWtDb3BvdkN2RlV1?=
 =?utf-8?B?ZlNybnlwRlI3cWEwSFVHdHlzWDZoTkRGVDBEbmExbWVJQ09OSEhVTVlMWG5Q?=
 =?utf-8?B?d3JaN21zcndyQXJGdWpRYWZScmEvSGhxSnRqaG1rVTc3NDlXM0lsdHRrblR5?=
 =?utf-8?B?ZUc3dVFBSDJDVXk4c3hNUVZVQlRBWEdZejYzNFY0blQvR0UvOWZPbHNoOHdl?=
 =?utf-8?B?eHREWVNLWGJBajRVeDE4ZnVuaG5COE5NOUFhaVBLVDl2RFRpMHJ4M1FYMVoz?=
 =?utf-8?B?ZERSbnJ6UGJab2VFNlRyZFg4eEhRZTFid29CeXRZZUE5N0U2cVBjRDdDQTEr?=
 =?utf-8?B?TDhBRWNBUUZzd3dWS0RGaDk5Wm5PbHdQNDhoc3RpamJVTkdXVEZWRVJyb3kz?=
 =?utf-8?B?d3VmV0pZZkNBdERsV0IvK3haNnp3amw1VUJuZVd5MVBleGs0OVhvSHRrc0pM?=
 =?utf-8?B?bG44RVFodHozcTNhZm15elZaMVIzMlNMcDVXRmVvN0s4MTRrZU9ieEphOG5P?=
 =?utf-8?B?aFpIZUsreXNMeW1UUkhTYzY3Y3pLc3BjTHFBVy9CRmtNQjZWanpiWEp5OE9i?=
 =?utf-8?B?MVlVd0oycWZnbUFsN1hWK2cyM1NpMkI5RGRMR2dvRFRVNVEwMm44TjRuNzZs?=
 =?utf-8?B?d08wcG1iZ3BBdCtTK3hCWk5BNWZHVEMyTGE2VXNCYjRJVFFxUmIrTWh5N1ll?=
 =?utf-8?B?a3c0WmxDeFp5R3ZhZ2UvR1laK2plZktZYlovOFBQY3RGd2twZS9RS2ZReWpo?=
 =?utf-8?B?ZUlMYWhjNFFMbmh3a1dxQ0krOEIrVDNPcHJyek1HZU42Ynk5RjV1bHcrbEhm?=
 =?utf-8?B?Ny9ZaVkySnpyTXZyWXZxVVIxNy9tL255NXpSN0FwK241STJBNDNwZ2Y2cHZF?=
 =?utf-8?B?WEg1QkdqaENTMHJsUkdZV3pzSjVldkdDUXYrRWdwbzI4MVlWaWp5emFyVTc4?=
 =?utf-8?B?eGhCeXAvOW12b3B5YVRXWWZNSjI0K0IrU2k5NGh2UmFLWXY0TDA5cXd6b1NC?=
 =?utf-8?B?cStRMzMzRGx1ZGpOWTdiekllOUpnOEdoYXZuV3dNN1hKaklSd2swcmJ1UnZM?=
 =?utf-8?B?TnNhYTFqTVlqWDlNWEtpcUU1Wk05THpNbnRFbEM0dEI2dWVVUkxxUE5aa2d6?=
 =?utf-8?B?WXpJQ1ZtNVhVQWxDRUtTNVVabTRMMjNnaUNreWZqUkFPcFVyMlgxaGFkaWdY?=
 =?utf-8?B?c2FpcmJwQ2hPcjlQdWdUYXJYZjlQR1hjWG81RkMzMWlPaC9KcVRpeHBiZUJr?=
 =?utf-8?B?ZEFmbk1HbTk5UGNLZlptaDE1M1c4VkZYRjBMVjQrRnIwYndpN2pETVVUS092?=
 =?utf-8?B?YW5pOTVLM2psS3hBQUZ1S216NlM5bVZ2SU1yTGI1TVQxcCsxeTI3cUFuNE0v?=
 =?utf-8?B?MUZQVzVZZnFkNTZXaUJZajRXbVZ3UDUyWFl1dE5Td1k4azFreVoyN2ZlaVA0?=
 =?utf-8?B?RDh1Mk1uMDFsMmt6cVRJVFd0RkNrbE42Rzd2cDI4R3dWWjM3M093NTRMVlN0?=
 =?utf-8?B?dy9TeGtrS1NNaTNNUWpDN1pWMWFNb1RiMnk1SVN0NmQvYnN0ZGNJOC9wZjJ6?=
 =?utf-8?B?VTFaZ0lvZXBxVHI5VU52empBTVZLWEhUbmpZRzZUR1ArYjBLMGszcitkSGJX?=
 =?utf-8?Q?kXSt3iVvHDCTf5x96uNRYJL8N57zmwhCe6rAN0Gjmp1a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec1f74c-2fea-40cb-efdd-08da7ea6e322
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 10:14:06.8297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoNbRTWAH1dqOCNGdTtNe36eb9I9jxOtK1VoX/9t7kCVBBEr2GbRqme58ln/tFGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

QW0gMTUuMDguMjIgdW0gMTI6MTEgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDE1LjA4
LjIyIHVtIDEyOjA5IHNjaHJpZWIgRG1pdHJ5IE9zaXBlbmtvOgo+PiBPbiA4LzE1LzIyIDEzOjA1
LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTUuMDguMjIgdW0gMTE6NTQgc2Nocmll
YiBEbWl0cnkgT3NpcGVua286Cj4+Pj4gSGlnaGVyIG9yZGVyIHBhZ2VzIGFsbG9jYXRlZCB1c2lu
ZyBhbGxvY19wYWdlcygpIGFyZW4ndCByZWZjb3VudGVkIGFuZAo+Pj4+IHRoZXkKPj4+PiBuZWVk
IHRvIGJlIHJlZmNvdW50ZWQsIG90aGVyd2lzZSBpdCdzIGltcG9zc2libGUgdG8gbWFwIHRoZW0g
YnkgCj4+Pj4gS1ZNLiBUaGlzCj4+Pj4gcGF0Y2ggc2V0cyB0aGUgcmVmY291bnQgb2YgdGhlIHRh
aWwgcGFnZXMgYW5kIGZpeGVzIHRoZSBLVk0gbWVtb3J5Cj4+Pj4gbWFwcGluZwo+Pj4+IGZhdWx0
cy4KPj4+Pgo+Pj4+IFdpdGhvdXQgdGhpcyBjaGFuZ2UgZ3Vlc3QgdmlyZ2wgZHJpdmVyIGNhbid0
IG1hcCBob3N0IGJ1ZmZlcnMgaW50byAKPj4+PiBndWVzdAo+Pj4+IGFuZCBjYW4ndCBwcm92aWRl
IE9wZW5HTCA0LjUgcHJvZmlsZSBzdXBwb3J0IHRvIHRoZSBndWVzdC4gVGhlIGhvc3QKPj4+PiBt
YXBwaW5ncyBhcmUgYWxzbyBuZWVkZWQgZm9yIGVuYWJsaW5nIHRoZSBWZW51cyBkcml2ZXIgdXNp
bmcgaG9zdCBHUFUKPj4+PiBkcml2ZXJzIHRoYXQgYXJlIHV0aWxpemluZyBUVE0uCj4+Pj4KPj4+
PiBCYXNlZCBvbiBhIHBhdGNoIHByb3Bvc2VkIGJ5IFRyaWdnZXIgSHVhbmcuCj4+PiBXZWxsIEkg
Y2FuJ3QgY291bnQgaG93IG9mdGVuIEkgaGF2ZSByZXBlYXRlZCB0aGlzOiBUaGlzIGlzIGFuIAo+
Pj4gYWJzb2x1dGVseQo+Pj4gY2xlYXIgTkFLIQo+Pj4KPj4+IFRUTSBwYWdlcyBhcmUgbm90IHJl
ZmVyZW5jZSBjb3VudGVkIGluIHRoZSBmaXJzdCBwbGFjZSBhbmQgYmVjYXVzZSBvZgo+Pj4gdGhp
cyBnaXZpbmcgdGhlbSB0byB2aXJnbCBpcyBpbGxlZ2FsLgo+PiBBPyBUaGUgZmlyc3QgcGFnZSBp
cyByZWZjb3VudGVkIHdoZW4gYWxsb2NhdGVkLCB0aGUgdGFpbCBwYWdlcyBhcmUgbm90Lgo+Cj4g
Tm8gdGhleSBhcmVuJ3QuIFRoZSBmaXJzdCBwYWdlIGlzIGp1c3QgYnkgY29pbmNpZGVudCBpbml0
aWFsaXplZCB3aXRoIAo+IGEgcmVmY291bnQgb2YgMS4gVGhpcyByZWZjb3VudCBpcyBjb21wbGV0
ZWx5IGlnbm9yZWQgYW5kIG5vdCB1c2VkIGF0IGFsbC4KPgo+IEluY3JlbWVudGluZyB0aGUgcmVm
ZXJlbmNlIGNvdW50IGFuZCBieSB0aGlzIG1hcHBpbmcgdGhlIHBhZ2UgaW50byAKPiBzb21lIG90
aGVyIGFkZHJlc3Mgc3BhY2UgaXMgaWxsZWdhbCBhbmQgY29ycnVwdHMgdGhlIGludGVybmFsIHN0
YXRlIAo+IHRyYWNraW5nIG9mIFRUTS4KClNlZSB0aGlzIGNvbW1lbnQgaW4gdGhlIHNvdXJjZSBj
b2RlIGFzIHdlbGw6CgogwqDCoMKgwqDCoMKgwqAgLyogRG9uJ3Qgc2V0IHRoZSBfX0dGUF9DT01Q
IGZsYWcgZm9yIGhpZ2hlciBvcmRlciBhbGxvY2F0aW9ucy4KIMKgwqDCoMKgwqDCoMKgwqAgKiBN
YXBwaW5nIHBhZ2VzIGRpcmVjdGx5IGludG8gYW4gdXNlcnNwYWNlIHByb2Nlc3MgYW5kIGNhbGxp
bmcKIMKgwqDCoMKgwqDCoMKgwqAgKiBwdXRfcGFnZSgpIG9uIGEgVFRNIGFsbG9jYXRlZCBwYWdl
IGlzIGlsbGVnYWwuCiDCoMKgwqDCoMKgwqDCoMKgICovCgpJIGhhdmUgYWJzb2x1dGVseSBubyBp
ZGVhIGhvdyBzb21lYm9keSBoYWQgdGhlIGlkZWEgaGUgY291bGQgZG8gdGhpcy4KClJlZ2FyZHMs
CkNocmlzdGlhbi4KCj4KPj4+IFBsZWFzZSBpbW1lZGlhdGVseSBzdG9wIHRoaXMgY29tcGxldGVs
eSBicm9rZW4gYXBwcm9hY2guIFdlIGhhdmUKPj4+IGRpc2N1c3NlZCB0aGlzIG11bHRpcGxlIHRp
bWVzIG5vdy4KPj4gQ291bGQgeW91IHBsZWFzZSBnaXZlIG1lIGEgbGluayB0byB0aGVzZSBkaXNj
dXNzaW9ucz8KPgo+IE5vdCBvZiBoYW5kLCBwbGVhc2Ugc2VhcmNoIHRoZSBkcmktZGV2ZWwgbGlz
dCBmb3Igc2ltaWxhciBwYXRjaGVzLiAKPiBUaGlzIHdhcyBicm91Z2h0IHVwIG11bHRpcGxlIHRp
bWVzIG5vdy4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
