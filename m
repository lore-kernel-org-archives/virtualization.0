Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B61C77B75
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 18:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24F6383EDF;
	Tue, 16 May 2023 18:26:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24F6383EDF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vHzBZSQ1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 91XVvMnNSAxT; Tue, 16 May 2023 18:26:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8584882000;
	Tue, 16 May 2023 18:26:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8584882000
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28D8CC0036;
	Tue, 16 May 2023 18:26:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 207D0C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 18:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 899A960736
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 18:26:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 899A960736
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=vHzBZSQ1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-6fJmTBySmX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 18:26:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E1A060591
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E1A060591
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 18:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkX9/KDe8zaSf6f7tUjVESNP2SszlJjxefhlxzfm6MbofVgEgZ421lFO1xCOg9nfAfG2WqqUQAO8wF4r48PUOqEcUNHgQAx5dUV+m3G89qEQ4j2k3laWFGraXtnlbV9IF1mN/Ru57EBCgOE0ApAmk+bMsLVsgp7fiHFB/Zy6OsXnz7RgBCzfjuE+1K8hQGtohn0xi/ne+krCGqXeMZ8zYC6vxDhUkuioPBlmOoHopoo1Lcvp7eltnvpN5BzoFbto5AnulrVMWRMiaZ6qLSe5I6cZFJqAzWWcLvuQ7X6WNNZ1C9p/O03NkVJD7raTLWEN0Ls5waEkcVyGECHEDbMRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00V/4NckuKcqzYohHyf1/mDokxilporavbMOfGxKzSY=;
 b=AV4/zBCLpGwVapVByn7SgK9k1N0ipZTqUb9Og8ZZGx9yN6BZdUlChJ1nCk4dX5vq86VKthC+MYwufqgitGMkOXEHNtC6GSh+BUI6W2LZPRhYoqcn0SW+c24iR8nRPwQysNr2tMPzN6lKgz4smq5NzdzQVUvjwwpcWwCQ2EBIHuLirFAbi2puB//OcELNmWUMy99Iy5oK9Ae4QIAC1KymzdfIQML4m9FoLIQ9u+dKoaC0XRu4ZC8l6zAxDjwiLpDfkVJ5aiN5V9CGvX0jdIu0doG/asduRGOZah04DRsh0YR6NqhglnGc7T7epFC3vkdwoVKqDIWZ/8F+xdH1GeLqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00V/4NckuKcqzYohHyf1/mDokxilporavbMOfGxKzSY=;
 b=vHzBZSQ1VkMF+uPuAuW1vkYTLUmk9QRdmDi92OQKiI7A2QjwIK92drcHYSLHGq0ApiwsDJaUCADhjqzK2Ca1RzE1OQVytgzRUwrwAaOUJ6vpdnbXAlBQ5+tMwN/W8E/FYZIah/4Io+tLOItDVCdMpHohgwVPzUen/Trnn+TtjWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 18:26:36 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::fc3e:a5b4:7568:82bc%5]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 18:26:35 +0000
Message-ID: <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
Date: Tue, 16 May 2023 11:26:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
In-Reply-To: <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
X-ClientProxiedBy: BYAPR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:a03:100::15) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e71c57-021c-46b9-a091-08db563b14cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIL9SvsK6qjlrsNLIRdhAeNFlo49qiyV1YS2zEBF0btIgmYl7/O2hU1TVw/s0LpShKKb/PobMAjgw8TYgbmW/VTjJP/ZiIRsWXggpCUEWD8cpM5TH++jqV06Wt1CqvBKtZO4mZAOJa1mU3SVkIACepfNWhS1NZ0XQNVB1kmQPZNyMmBXlmwJ0kVj9+l7sWrFBe3v0NYUA0fzdKXqAYBsIZmDUTZGSQ89j+mKX/j8/+t14szBzZqeK1XMJ1sqGtIDI2AzuPI9JBPwIVQ9TmgRvXmX8i1E4EUeJi3gIdgj8STRjXHOOH+BoX4I0MoVSf/HEE+uDlz3UCh2lHd2SRT78HnYISunDmsYJuDHVKuXZ+FO5orsB6+xY/fXMCYnm4GaK/W+LUakMSxlyNHmK+XWTE8u+0iLp8Lh3qgkU6knCWDJssVjLI5ukF8KvJkB6GbdxOXTShyrzVSfSlWkhFoVjg3sjJfV3JaAMeV5eNCcYKXevLlI8jGwK7NqEnsjj+o80XTlhOD9tUDCCRJAUWZw39LxXFkDM5qH611QPlVwJkTX31J25w1z0avkoT07b8juvvFq3Tm2QiwRcYGX1In5yoc/DJkr09V9ZI8eUAOsqoPqurnqQQvxkTlhI1Hmzicz67LqsccZ/2qmN57yy1Ph9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(2906002)(38100700002)(36756003)(8936002)(66899021)(478600001)(8676002)(316002)(66556008)(4326008)(44832011)(66946007)(6916009)(66476007)(41300700001)(5660300002)(26005)(6506007)(31696002)(53546011)(6512007)(86362001)(186003)(31686004)(83380400001)(2616005)(6486002)(6666004)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2Y5eG1PVTZ4NmNqYXRpeWxScmtHMDBLRHhmY0RBYkJ1QkJIRDgzRzJnSjND?=
 =?utf-8?B?OFcwWVlWN1RXdjRKYUNIc1BsT0tGMDhYOEZMb2ZuVkM4WFZGNXpscWZrcHk1?=
 =?utf-8?B?eURiaHpGdS9SeFVwT0hSTHR5MVFZR1N4RWxBQmcyMmVLUVQzelgzQkFRZ0Ew?=
 =?utf-8?B?M0ZBNk9FdDVRKzB0U25PTFBMTm82QnNiWG4wT0ZoMzJPaHNnZGp2dnhDNzgz?=
 =?utf-8?B?SXhFcG1vK1BTdzd5dGdMK0VVdVc3a3lRQU92WHJab2I1NWVPbnRwQ21ZRW04?=
 =?utf-8?B?MVkrSzIrTFJIdTlTL1BoSHpwRDlnaHUrTGZTRlc1cHJ3MFl1VzFkRHUreW1k?=
 =?utf-8?B?ZkpybmZSQWMvRCtQR2lDSjdtWkVuSmp3dHNaS3lBMitTMCtnaUZpcVcrMDdv?=
 =?utf-8?B?LzFYVDhtMVdLa21uT3FsN3JlS0pYMzdGeHRscHhnRzdnTGRUUXpSajh1aFFx?=
 =?utf-8?B?Z2xHbldrQ0wzYlZTdzZrS0c4Zmt1NzRBeVE4OEJPMVJZNWs0dmxSdC9sMHBE?=
 =?utf-8?B?aXVkMzlVN1A0Z2VJa0hlSXJIRlVTSTZlaHNtRnEzbE1iNmxTWm8yRDZZbTJv?=
 =?utf-8?B?VTN0L1doOFFSZEF4WnUyVHRIMGFTd09yVnpEb3VhTVF2Y3dsLzB4anVDMG9X?=
 =?utf-8?B?amh0dTg3ZE1TeUhwSUt4WXRPVEcySHUySWdYMURBTnd4MmNicEVPai84c0tm?=
 =?utf-8?B?NVBod3podUNYVTlhTng0SVcxRkN3SHQ1NjY2Y0hGa1ZKbE1wcDIwWExrcnZx?=
 =?utf-8?B?bHNOalhrb29JZzZ6WlF6VlNSbEJvUXNpeGRRdU1RK3MxR1I3bEpBT2RLb3pE?=
 =?utf-8?B?RDZCRlNoZDRnbVN0ZjVBbkhSWTFhY1Y3WUxiV2drWVBuaEZEbFFRVExFVks4?=
 =?utf-8?B?alg3aVFmYlM5blJ6K1ViZWNkZWR5a3ZOb1VXMGlwYnpKRVZoWEd4MDdaSTlx?=
 =?utf-8?B?SzV3VzBaTjU4M2FGTEN5Tmt1YnVHY0Z1dGN0aytVenF4K2xHRC9vKzFvNTVQ?=
 =?utf-8?B?WGlVb3hJKzFCY3JVY3A5Q3pEd08rQWNjYlZSS05IOUwveUpSY0hDWGdKOVpK?=
 =?utf-8?B?Y2doRGtHUlY3YWNKZlpVR0xtaFZwSHhqNmh0TURBNGNRNnhmMXhWNzJqMVB2?=
 =?utf-8?B?bDlVZ1pSQjVGMzRMZlBCbS9zdkhpekxFTzQzS2cza1cyR1VTQ2FVbm1CbjJ3?=
 =?utf-8?B?ZTloSDBrOThyK3l6Q0xTR0FYVWVXckVWdFZwTTltOTNnZHM3enlBWWgwRncr?=
 =?utf-8?B?encwMk0vMFZlemtTb05zRTJNVXlyRll2ZzJVbHNlZGdYK1J1dkNtZjFWMDNv?=
 =?utf-8?B?MTdQNDVXYkpnWjUrQWk1RWNENW5iV1JBOEtPWlNoSXUvczBLNkZmeHZzZ1Nw?=
 =?utf-8?B?SmhWMHNnZCttNWpxZHMvYzJha1NXVXZWejd5eVFHNlVJQ25WQ2xWNjI2WUVl?=
 =?utf-8?B?ZnFpMVA0N09aOFZjNG15Tm84Q0llZmN3NnpIMlJkUzIzNVpIRGdtNGx0TkZk?=
 =?utf-8?B?NVV3a00zU0lXaDVoRHRWQmk0Nis4Ri96SlFCdStnMmFqalRISlZGWFgvYVpj?=
 =?utf-8?B?WDltZ2N2TVdVSkVMTkNHd1I4OG8wejI1cW5Wc0FGUXpCcFludXhONnBtZUZw?=
 =?utf-8?B?WDJ5QU85U3JuTUJ2d1VGb2xaVzBaUFlBWW5UQjR5NGpFWHovNGVEUENWUzR1?=
 =?utf-8?B?MzhWWU05SzlEcHNQcnBzMFBZY0J0cVpIVGtkNlVwck1NbW03clB1ZnZReFVU?=
 =?utf-8?B?RTFaMU1pVkJWM2RvTHE1U0tqOTJ4S3lMbldEcGtCWmhTaVNKR3hCL25QYVBL?=
 =?utf-8?B?eUYyNzVib2UrN244R2hJVFJ6NXlOeFZPN3FxR3dHanBFbzRvcUFNb1BESCtl?=
 =?utf-8?B?K0IrVlh4dG5Dcys1TVNLQU10a1V6LzBvMFhkblV1cTN1T3lNUndGTnZFQ0FW?=
 =?utf-8?B?Rk1aT3dYYlk1b0xWaURvM2tiZlZmR3pZQXAyd2lTdWRzdHgvSkRxbjFlSjFP?=
 =?utf-8?B?WmY4a1lqUkNlanpmdldwRWd2dmdpVEVDTE5OZUFWbDNyaVlDanlkTjg1SlIr?=
 =?utf-8?B?MVRIWk9aSFJnY2lhZEpEVzgyWEJGVVNLZlRQTDlCNVIyNjBwVTRQekpFL0pF?=
 =?utf-8?Q?EmdLn9OuU53gf76Y6dRmZVhgN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e71c57-021c-46b9-a091-08db563b14cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 18:26:35.7391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gjBC7KbHfchD6BIAHLlhJ0FhKrdd+XHqFZuIj8pWKDo4l5ayCGxEAZX7SqrQStSl9UvOU8RazVBgtkt/By4TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
Cc: virtualization@lists.linux-foundation.org, drivers@pensando.io,
 mst@redhat.com
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNS8xNi8yMyAxMjo0OSBBTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9uIE1vbiwg
TWF5IDE1LCAyMDIzIGF0IDAxOjQxOjEyUE0gLTA3MDAsIFNoYW5ub24gTmVsc29uIHdyb3RlOgo+
PiBPbiA1LzkvMjMgMTo0NiBBTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+Pj4gT24gTW9u
LCBBcHIgMjQsIDIwMjMgYXQgMDM6NTA6MzBQTSAtMDcwMCwgU2hhbm5vbiBOZWxzb24gdmlhCj4+
PiBWaXJ0dWFsaXphdGlvbiB3cm90ZToKPj4+PiBVc2UgdGhlIHJpZ2h0IHN0cnVjdHMgZm9yIFBB
Q0tFRCBvciBzcGxpdCB2cXMgd2hlbiBzZXR0aW5nIGFuZAo+Pj4+IGdldHRpbmcgdGhlIHZyaW5n
IGJhc2UuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5u
ZWxzb25AYW1kLmNvbT4KPj4+PiAtLS0KPj4+PiBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxOCAr
KysrKysrKysrKysrLS0tLS0KPj4+PiBkcml2ZXJzL3Zob3N0L3Zob3N0LmggfMKgIDggKysrKysr
LS0KPj4+PiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
Cj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5jIGIvZHJpdmVycy92
aG9zdC92aG9zdC5jCj4+Pj4gaW5kZXggZjExYmRiZTRjMmM1Li5mNjRlZmRhNDhmMjEgMTAwNjQ0
Cj4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4+Pj4gKysrIGIvZHJpdmVycy92aG9z
dC92aG9zdC5jCj4+Pj4gQEAgLTE2MzMsMTcgKzE2MzMsMjUgQEAgbG9uZyB2aG9zdF92cmluZ19p
b2N0bChzdHJ1Y3Qgdmhvc3RfZGV2Cj4+Pj4gKmQsIHVuc2lnbmVkIGludCBpb2N0bCwgdm9pZCBf
X3VzZXIgKmFyZwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByID0gLUVGQVVMVDsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYnJlYWs7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocy5udW0gPiAweGZmZmYpIHsKPj4+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSAtRUlOVkFMOwo+Pj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh2aG9zdF9oYXNfZmVhdHVyZSh2cSwgVklSVElP
X0ZfUklOR19QQUNLRUQpKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB2cS0+bGFzdF9hdmFpbF9pZHggPSBzLm51bSAmIDB4ZmZmZjsKPj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZxLT5sYXN0X3VzZWRfaWR4
ID0gKHMubnVtID4+IDE2KSAmIDB4ZmZmZjsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfSBlbHNlIHsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChzLm51bSA+IDB4ZmZmZikgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSAtRUlOVkFMOwo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJy
ZWFrOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdnEtPmxhc3Rf
YXZhaWxfaWR4ID0gcy5udW07Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2cS0+bGFzdF9hdmFpbF9pZHggPSBzLm51bTsK
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBGb3JnZXQgdGhlIGNhY2hlZCBpbmRl
eCB2YWx1ZS4gKi8KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2cS0+YXZhaWxfaWR4
ID0gdnEtPmxhc3RfYXZhaWxfaWR4Owo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJy
ZWFrOwo+Pj4+IMKgwqDCoMKgwqAgY2FzZSBWSE9TVF9HRVRfVlJJTkdfQkFTRToKPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLmluZGV4ID0gaWR4Owo+Pj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzLm51bSA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHZob3N0X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9SSU5H
X1BBQ0tFRCkpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzLm51bSA9ICh1MzIpdnEtPmxhc3RfYXZhaWxfaWR4IHwKPj4+PiAoKHUzMil2cS0+bGFzdF91
c2VkX2lkeCA8PCAxNik7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMubnVtID0gdnEt
Pmxhc3RfYXZhaWxfaWR4Owo+Pj4KPj4+IFRoZSBjaGFuZ2VzIExHVE0sIGJ1dCBzaW5jZSB3ZSBh
cmUgY2hhbmdpbmcgdGhlIFVBUEksIHNob3VsZCB3ZQo+Pj4gdXBkYXRlIHRoZSBkb2N1bWVudGF0
aW9uIG9mIFZIT1NUX1NFVF9WUklOR19CQVNFIGFuZAo+Pj4gVkhPU1RfR0VUX1ZSSU5HX0JBU0Ug
aW4gaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0Lmg/Cj4+Cj4+IENvcnJlY3QgbWUgaWYgSSdtIHdy
b25nLCBidXQgSSBkb24ndCB0aGluayB3ZSdyZSBjaGFuZ2luZyBhbnl0aGluZyBpbgo+PiB0aGUg
VUFQSSBoZXJlLCBqdXN0IGZpeGluZyBjb2RlIHRvIHdvcmsgY29ycmVjdGx5IHdpdGggd2hhdCBp
cyBhbHJlYWR5Cj4+IGhhcHBlbmluZy4KPiAKPiBJSVVDIGJlZm9yZSB0aGlzIHBhdGNoIFZIT1NU
X0dFVF9WUklOR19CQVNFIGFuZCBWSE9TVF9TRVRfVlJJTkdfQkFTRQo+IG5ldmVyIHdvcmtlZCB3
aXRoIHBhY2tlZCB2aXJ0cXVldWUsIHNpbmNlIHdlIHdlcmUgb25seSBoYW5kbGluZwo+IGxhc3Rf
YXZhaWxfaWR4LiBOb3cgd2UgYXJlIHN1cHBvcnRpbmcgcGFja2VkIHZpcnRxdWV1ZSwgaGFuZGxp
bmcKPiBpbiB2aG9zdF92cmluZ19zdGF0ZS5udW0gYm90aCBsYXN0X2F2YWlsX2lkeCBhbmQgbGFz
dF91c2VkX2lkeCAod2l0aAo+IHdyYXAgY291bnRlcnMpLgo+IAo+IEZvciBleGFtcGxlIGZvciBW
SE9TVF9HRVRfVlJJTkdfQkFTRSB3aGVyZSBpcyBkb2N1bWVudGVkIHRoYXQgdGhlIGZpcnN0Cj4g
MTUgYml0cyBhcmUgbGFzdF9hdmFpbF9pZHgsIHRoZSAxNnRoIHRoZSBhdmFpbF93cmFwX2NvdW50
ZXIsIGFuZCB0aGUKPiBvdGhlcnMgYXJlIGxhc3RfdXNlZF9pZHggYW5kIHVzZWRfd3JhcF9jb3Vu
dGVyPwo+IAo+IE1heWJlIEkgbWlzc2VkIHNvbWV0aGluZywgYnV0IHNpbmNlIHRoaXMgaXMgVUFQ
SSwgSU1ITyB3ZSBzaG91bGQKPiBkb2N1bWVudCB0aGUgcGFyYW1ldGVycyBvZiBpb2N0bHMgYXQg
bGVhc3QgaW4KPiBpbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaC4KClBlcmhhcHMgSmFzb24gYWxy
ZWFkeSBoYXMgc29tZXRoaW5nIHdyaXR0ZW4gdXAgdGhhdCBjb3VsZCBiZSBwdXQgaW4gaGVyZSAK
ZnJvbSB3aGVuIGhlIGZpcnN0IGFkZGVkIHRoZSB3cmFwX2NvdW50ZXIgYSBjb3VwbGUgb2YgeWVh
cnMgYWdvPwoKc2xuCgo+IAo+IFRoYW5rcywKPiBTdGVmYW5vCj4gCj4gLS0gCj4gWW91IHJlY2Vp
dmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xl
IAo+IEdyb3VwcyAiUGVuc2FuZG8gRHJpdmVycyIgZ3JvdXAuCj4gVG8gdW5zdWJzY3JpYmUgZnJv
bSB0aGlzIGdyb3VwIGFuZCBzdG9wIHJlY2VpdmluZyBlbWFpbHMgZnJvbSBpdCwgc2VuZCAKPiBh
biBlbWFpbCB0byBkcml2ZXJzK3Vuc3Vic2NyaWJlQHBlbnNhbmRvLmlvLgo+IFRvIHZpZXcgdGhp
cyBkaXNjdXNzaW9uIG9uIHRoZSB3ZWIgdmlzaXQgCj4gaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNv
bS9hL3BlbnNhbmRvLmlvL2QvbXNnaWQvZHJpdmVycy9xNmNtZmhhMzZzZGtnZmx3d2QzcHI0c3c3
cmdhamFnNGFoZ2picGZqcnI3Nnc0bzJiNiU0MDN5Yzd6czV1NjVzNC4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
