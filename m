Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8DAC00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 10:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C07C660F1B;
	Mon, 15 Aug 2022 10:51:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C07C660F1B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mKcXCJjf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8jJnaDtfx_e9; Mon, 15 Aug 2022 10:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 18AD460D62;
	Mon, 15 Aug 2022 10:51:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18AD460D62
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2EB4C0032;
	Mon, 15 Aug 2022 10:51:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97EDAC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 10:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B874400CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 10:51:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B874400CB
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mKcXCJjf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lAvbjaOfvli
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 10:51:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F58B400C8
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F58B400C8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 10:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGAviiRDqThd7GSmGpSQz2VVlLp34WkAgBdq+TV5vLmnX3KsknOMrXjz4h1KkUrMV99BxR0LNo+40B86mFmztdxXkTudPeRtdtmqI+z7qCbEpbxfZbBDGc1qv6+WFgvmm2pDcK3Nfm7ELJLWJE12kWarz62q57dP+2TnfslV9bb4C+rOwy9fRJukjxnuXFJPQhqiKgoiqTgztJSvNz34EdB7NUxjwXdOkLKvGCBKtQ48YWwz/JraHou+HNs7eU0WVaYeOb9QLDacxXJ38uVqEo8q0Cy17X/BUYulHCMyLwn0Iv0wBwlUm7wgcYoPrcjS3moZnxelCMPoSFKlp9D4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Tgiv53NsWYoN74iEuZueQIdYjz4ya+eJ2Dde/RobPM=;
 b=icCIXRa5su7kxZ1mdtZim3RQmlIqbywtkuys8stmRyalXFOKDwszNKOn3mOphB9gQLe0iayM05gW+O2VNS6MzUaf75RZU0jKky+oZ/BxfPSqXNV0WoQVpnrRZnvkCAVEwgAnxUWb2fopUcY9AVdS33h0uEQB/rTPK0lSMB9X49FBk8m0OGL3GYfGG5l4QTe1LhSi9COuOUolGDsjf1/9dcoTBTBuK9k8PVJQG9LuRSH/TfZ9TjYUIAe0bt4KaaRPHaa2z3MJpS8aHsA1aZ7jUCP0W9rtWVIPAilcbgueKugLJir0o2e3t/V99wNKbxVbtnu4cySN+vrrypgqzqEIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Tgiv53NsWYoN74iEuZueQIdYjz4ya+eJ2Dde/RobPM=;
 b=mKcXCJjf75RC3fPtCrMgANqclsFf9ReaKg5/qsA/b0DBMB6NHVDFTidj17t3KLyz3z4P4r4zIky71arDVFfge/2FHz9jjLyuelj1a7/pJkWFAXBn5Ho/4SpKjQqr99fuNUVG6bhab0fIrlBPVbSSSYASZusnCfYxp12HypPkask=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1297.namprd12.prod.outlook.com (2603:10b6:404:14::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 10:51:09 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Mon, 15 Aug 2022
 10:51:09 +0000
Message-ID: <57562db8-bacf-e82d-8417-ab6343c1d2fa@amd.com>
Date: Mon, 15 Aug 2022 12:51:02 +0200
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
In-Reply-To: <2df57a30-2afb-23dc-c7f5-f61c113dd5b4@collabora.com>
X-ClientProxiedBy: AS8P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b573563c-8429-41a2-a060-08da7eac0f8b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1297:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVFozuItucHq5XWkNNyOSbfWxMkUmJZCoZYZFvdHS9zXiutpqc9uAkDsetuaRB9jOJr8aovvZQWSWzTcmITf3KvszrhM4QgO7d0uceFrns15+0i8TIEVn26g3BH/1AYSkTFDmvxZujGWSn0ohBn595zowXvLpjHSVK9gZt7Je7fswquvSBHaxFlOXkbhLeNqUsD6j3HmVrJpp2TDkqDTwIJcRVMar2N2MturLwZSWtmva+qjjqso+UvG0jGrEkPPg+Dr8H/2ReCcd37xmHK0X8bHXE31f8Mk/tS998zmjG+maVqOUjuE7evOruqotp9F1IK1y84BMgTvmCRqc1xP/wF/1TpqfHofuLymqusKx+hlC/Rvp7dqjKIHe2Ae5clPq/rgh+EuC2fWG2FEtdYu6A8i394Ag6pT9IWaHAGZNzxPgmoqCNPVG/927oZhI09CTJ8uaTu00YouT0RQ6tLxPzoEKn6AVbxL1GF6PQQ8Ptnkm1H9yE0wNHfEaUco3aB+xAN60qBEZcOfY1u+H+KxlVqR9tzG9iscd03qIjJyS4sjBYd9QzNrUiAnJLJYxgjMVkwJZt95vZY4OOK0pNxueJ9pRgLXVdMSJF2rcRbg5UlR2F1SaY1VWoeVhya3zRRNASchFQFtuMSFvLdpBNrKeennLQ8uUX0AjnIk+L4gz/LABixJrJxrX93Jy1pn9U6+rk4EpRwnPz1OSMqamfMAFW9iWyeB1MF96CYnV7jbBQ5C6K2iAauRcUUD9BldzoQACwPc4CHAdpwV01nvp/ZYh5h38MbZYu2E98cAUrK7vXUgdVbuaJnDu6GKuh4qlt9cQSVRIHNNJmWDdntoWk5Llg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(316002)(6486002)(6512007)(31696002)(6666004)(38100700002)(53546011)(8676002)(66476007)(4326008)(66556008)(66946007)(6506007)(478600001)(83380400001)(41300700001)(110136005)(36756003)(186003)(2906002)(2616005)(66574015)(5660300002)(7416002)(31686004)(8936002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5lUDFzK2xqa3o4djJRcUR4N3ZZMU1lOFI3UHZpVGtHOUNmb3EwSDlWc1FC?=
 =?utf-8?B?N2Q4ZHBIS3FwOVVCcUFEaXVrNU80TWp5WkdqRTRJcTJuWEZ0UXhVNG5zcXZu?=
 =?utf-8?B?RnVTZnQ2djhJY1JuTTZISkVqTTJLOUVWZVNuZFZxY2VzZE1KY2hKMUEvWjJI?=
 =?utf-8?B?eFVSNXRscy9yS1ZBVTRmQXVqWjU0bVR4UEtmRTdmM0QzS3dkR1ptUmhEa2gv?=
 =?utf-8?B?MDYyL2F1VTFmQ3ZibnZDK1F1QjlnUjhRVVZKTlZNVTJ6dzVUTXF3R2xxbWla?=
 =?utf-8?B?TTQxbW9FYVBGajgwclFsWm5MdmwxWUsvRUkycWNNYld2T3ExN3Fma0d4WFJm?=
 =?utf-8?B?VVBQQ2FBRkhuV2tDNFRqN1l2NDRYbDFHNjFVdHRrMS9RS0U1ZlB5UmlqaTBC?=
 =?utf-8?B?L2kwQjNrSnhWSEZlZkc4SXp4ZU9zczdxK3lIR083WUh3RkRuYzZ5WXp0MXJp?=
 =?utf-8?B?V25TUW5uMnVpQ0xMVVV4dEtsRTNIdCt3SU5oSFBoL1pIRGgwUVE2YVY4Unk3?=
 =?utf-8?B?VGovZm8vV0RGSTQ3M0E0eDNVSjlIbjZYSWQ4SXI1VmE2QW5kcjdvQkxIUzIx?=
 =?utf-8?B?RHpjRlZkWkMxbTZWa0FVSVhaaUlqVzkweTJZWk1RRGlUR3UyZG5lN3QxUFYr?=
 =?utf-8?B?dUdCRStYbmphWFc3U1VyZE91ZmNwbWdyejBkYmpCaXdzK28yYVNZcXZneUxF?=
 =?utf-8?B?U05pem1OblpjaTRTVklHQ1dPZ3hIZXJ0UU1Xa1kxcitlbHY5YUtBS29JMEpj?=
 =?utf-8?B?aDFwbWlKSVhhUEp0QnVocGVXWkdteE5ZOERiRVFkSTRJclA2eFY1R2puclVN?=
 =?utf-8?B?emJXR1ArM0FuN0ZOb1dGcW9WZXZTRC9QUFFvQTY1RjVFT0I5clJMNXBXcTNP?=
 =?utf-8?B?Skd2a3pwaEhNbXludXlGWjNCUWZwUGFUOTY2ZWpBeC9QMUh3bStiVSt5MW83?=
 =?utf-8?B?K0xOeklodWxtQ2l5bFhkNTRGRGZhaG52b0RIenR1VU9UcTZXTmxtWnFXbEpT?=
 =?utf-8?B?ZjVjMzFkZXBZYjVQTHI5YmhOZjgwWTExQXpYV2sycUdZYnQrNkIvOVZJM1pv?=
 =?utf-8?B?T2FqKzBZa0tqN1RhSHF4V1ZtRXk1NDZlakNSOWhXWnJZMWZNM2hUM2pKWWNs?=
 =?utf-8?B?RzMvU2gyYWszcHhJLzZVRUd2RW1TblVFSDA0N3pxajI0U2NEbEozSGhqalNq?=
 =?utf-8?B?LzNoWllnZksrU2tsVmpkbXRMU1ZLNUhwbXh3anRCK25QVG16dEVWQzhSY2Jw?=
 =?utf-8?B?K3hVazZkQ1pERkk2Qk5tZjlYdm4rVXpyN1ZONjRUdVovT1pkQVA0MTFVZVNh?=
 =?utf-8?B?MTh0NDBQWmp2a0VUUGJSUS95d05CQ3lGQ3VIUGFXWXpSVUxlWWdTdXhYcnMz?=
 =?utf-8?B?Z0htR2d2RVM5REtHY2drdzNZYlp1em1YQjJzNWpCcU81cUo3N2w0c2lrRkh6?=
 =?utf-8?B?VTEvSDBmK0hYZlB1S1lTWTJMR1dQdlRFLzZvc1RDQ2Q4ZlN4VDYvcUFzMkJu?=
 =?utf-8?B?STZkMDdHaWl3eHZWcXZ1RGQ0WkFtZTFUSVNkNmJndlBXYUxJWFd5T3VsNkhP?=
 =?utf-8?B?cUVmT1NRajdqSXQvWHpkQjJuVGhja0I0ajhxZTc1aDhSRmw2ckE0MW8rNU5y?=
 =?utf-8?B?cTNVRE9PUGlLRFlTWGNRK0d6NjYydkdIekF6Njh4ZlZQUEQreU0rbkg4ZGhj?=
 =?utf-8?B?clc5OGxXYm9mLzRzNVU2N3h4cDBKcGR1UzRYRDlLbjNHQStsNys4akJMWUVx?=
 =?utf-8?B?RVNkeEs1Y25BYnVjcEQvQXhwR3M5aFBjZzg0NGNtZExmWkVrUDd6WEZhTzdw?=
 =?utf-8?B?QUpUTFE0bGI3YUxrbUczazZEdUl3Z0RWS3J5UHRVOFdQZmYvM3I5R0tmZGwz?=
 =?utf-8?B?blVNWFpvYWIwcVZCSUpTVTg4SE14YVQ0WDlsNHdrNmVZQWtoZmVNTWQ2dmtn?=
 =?utf-8?B?YkxVMElLTjg2VXBvYVBmL1hQZ1FSc2Y3c2NWMkdYZXpZYkVyM1hsa2N4cTZQ?=
 =?utf-8?B?aGhQZmlEeGRidjBwaXljR0hIRjhTZzRrMHY3Y3U1eU1UWVZPUUphMHRYR3Jy?=
 =?utf-8?B?aFphVlQ1VVRrRzVhV0VDdCsyL3daQW43cTNQTzhqc3hscks1Y1J5bjBrN0Rt?=
 =?utf-8?B?TXNiem1TVkdvWHFJNDdLL1JnSEsvdDRGVjlMUkoybE1HWTZ6RUg2clprdFpY?=
 =?utf-8?Q?DeKC7oDJvAZA7/dR97/7A/kmXDnOnVPIwRmwvHXugRdi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b573563c-8429-41a2-a060-08da7eac0f8b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 10:51:08.8973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JcvsjCGdy0ZWL5dwb25N4w0AIDvw5kD2cbqLcN6zhIDKX6e8Irf5d/0TPf3owXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1297
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

QW0gMTUuMDguMjIgdW0gMTI6NDcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gT24gOC8xNS8y
MiAxMzoxOCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBPbiA4LzE1LzIyIDEzOjE0LCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTUuMDguMjIgdW0gMTI6MTEgc2NocmllYiBDaHJp
c3RpYW4gS8O2bmlnOgo+Pj4+IEFtIDE1LjA4LjIyIHVtIDEyOjA5IHNjaHJpZWIgRG1pdHJ5IE9z
aXBlbmtvOgo+Pj4+PiBPbiA4LzE1LzIyIDEzOjA1LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+
Pj4+Pj4gQW0gMTUuMDguMjIgdW0gMTE6NTQgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4+Pj4+
Pj4gSGlnaGVyIG9yZGVyIHBhZ2VzIGFsbG9jYXRlZCB1c2luZyBhbGxvY19wYWdlcygpIGFyZW4n
dCByZWZjb3VudGVkIGFuZAo+Pj4+Pj4+IHRoZXkKPj4+Pj4+PiBuZWVkIHRvIGJlIHJlZmNvdW50
ZWQsIG90aGVyd2lzZSBpdCdzIGltcG9zc2libGUgdG8gbWFwIHRoZW0gYnkKPj4+Pj4+PiBLVk0u
IFRoaXMKPj4+Pj4+PiBwYXRjaCBzZXRzIHRoZSByZWZjb3VudCBvZiB0aGUgdGFpbCBwYWdlcyBh
bmQgZml4ZXMgdGhlIEtWTSBtZW1vcnkKPj4+Pj4+PiBtYXBwaW5nCj4+Pj4+Pj4gZmF1bHRzLgo+
Pj4+Pj4+Cj4+Pj4+Pj4gV2l0aG91dCB0aGlzIGNoYW5nZSBndWVzdCB2aXJnbCBkcml2ZXIgY2Fu
J3QgbWFwIGhvc3QgYnVmZmVycyBpbnRvCj4+Pj4+Pj4gZ3Vlc3QKPj4+Pj4+PiBhbmQgY2FuJ3Qg
cHJvdmlkZSBPcGVuR0wgNC41IHByb2ZpbGUgc3VwcG9ydCB0byB0aGUgZ3Vlc3QuIFRoZSBob3N0
Cj4+Pj4+Pj4gbWFwcGluZ3MgYXJlIGFsc28gbmVlZGVkIGZvciBlbmFibGluZyB0aGUgVmVudXMg
ZHJpdmVyIHVzaW5nIGhvc3QgR1BVCj4+Pj4+Pj4gZHJpdmVycyB0aGF0IGFyZSB1dGlsaXppbmcg
VFRNLgo+Pj4+Pj4+Cj4+Pj4+Pj4gQmFzZWQgb24gYSBwYXRjaCBwcm9wb3NlZCBieSBUcmlnZ2Vy
IEh1YW5nLgo+Pj4+Pj4gV2VsbCBJIGNhbid0IGNvdW50IGhvdyBvZnRlbiBJIGhhdmUgcmVwZWF0
ZWQgdGhpczogVGhpcyBpcyBhbgo+Pj4+Pj4gYWJzb2x1dGVseQo+Pj4+Pj4gY2xlYXIgTkFLIQo+
Pj4+Pj4KPj4+Pj4+IFRUTSBwYWdlcyBhcmUgbm90IHJlZmVyZW5jZSBjb3VudGVkIGluIHRoZSBm
aXJzdCBwbGFjZSBhbmQgYmVjYXVzZSBvZgo+Pj4+Pj4gdGhpcyBnaXZpbmcgdGhlbSB0byB2aXJn
bCBpcyBpbGxlZ2FsLgo+Pj4+PiBBPyBUaGUgZmlyc3QgcGFnZSBpcyByZWZjb3VudGVkIHdoZW4g
YWxsb2NhdGVkLCB0aGUgdGFpbCBwYWdlcyBhcmUgbm90Lgo+Pj4+IE5vIHRoZXkgYXJlbid0LiBU
aGUgZmlyc3QgcGFnZSBpcyBqdXN0IGJ5IGNvaW5jaWRlbnQgaW5pdGlhbGl6ZWQgd2l0aAo+Pj4+
IGEgcmVmY291bnQgb2YgMS4gVGhpcyByZWZjb3VudCBpcyBjb21wbGV0ZWx5IGlnbm9yZWQgYW5k
IG5vdCB1c2VkIGF0IGFsbC4KPj4+Pgo+Pj4+IEluY3JlbWVudGluZyB0aGUgcmVmZXJlbmNlIGNv
dW50IGFuZCBieSB0aGlzIG1hcHBpbmcgdGhlIHBhZ2UgaW50bwo+Pj4+IHNvbWUgb3RoZXIgYWRk
cmVzcyBzcGFjZSBpcyBpbGxlZ2FsIGFuZCBjb3JydXB0cyB0aGUgaW50ZXJuYWwgc3RhdGUKPj4+
PiB0cmFja2luZyBvZiBUVE0uCj4+PiBTZWUgdGhpcyBjb21tZW50IGluIHRoZSBzb3VyY2UgY29k
ZSBhcyB3ZWxsOgo+Pj4KPj4+ICDCoMKgwqDCoMKgwqDCoCAvKiBEb24ndCBzZXQgdGhlIF9fR0ZQ
X0NPTVAgZmxhZyBmb3IgaGlnaGVyIG9yZGVyIGFsbG9jYXRpb25zLgo+Pj4gIMKgwqDCoMKgwqDC
oMKgwqAgKiBNYXBwaW5nIHBhZ2VzIGRpcmVjdGx5IGludG8gYW4gdXNlcnNwYWNlIHByb2Nlc3Mg
YW5kIGNhbGxpbmcKPj4+ICDCoMKgwqDCoMKgwqDCoMKgICogcHV0X3BhZ2UoKSBvbiBhIFRUTSBh
bGxvY2F0ZWQgcGFnZSBpcyBpbGxlZ2FsLgo+Pj4gIMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4+Cj4+
PiBJIGhhdmUgYWJzb2x1dGVseSBubyBpZGVhIGhvdyBzb21lYm9keSBoYWQgdGhlIGlkZWEgaGUg
Y291bGQgZG8gdGhpcy4KPj4gSSBzYXcgdGhpcyBjb21tZW50LCBidXQgaXQgZG9lc24ndCBtYWtl
IHNlbnNlIGJlY2F1c2UgaXQgZG9lc24ndCBleHBsYWluCj4+IHdoeSBpdCdzIGlsbGVnYWwuIEhl
bmNlIGl0IGxvb2tzIGxpa2UgYSBib2d1cyBjb21tZW50IHNpbmNlIHRoZQo+PiByZWZjb3V0aW5n
IGNlcnRhaW5seSB3b3JrcywgYXQgbGVhc3QgdG8gYSBzb21lIGRlZ3JlZSBiZWNhdXNlIEkgaGF2
ZW4ndAo+PiBub3RpY2VkIGFueSBwcm9ibGVtcyBpbiBwcmFjdGljZSwgbWF5YmUgYnkgbHVjayA6
KQo+Pgo+PiBJJ2xsIHRyeSB0byBkaWcgb3V0IHRoZSBvbGRlciBkaXNjdXNzaW9ucywgdGhhbmsg
eW91IGZvciB0aGUgcXVpY2sgcmVwbHkhCj4gQXJlIHlvdSBzdXJlIGl0IHdhcyByZWFsbHkgZGlz
Y3Vzc2VkIGluIHB1YmxpYyBwcmV2aW91c2x5PyBBbGwgSSBjYW4KPiBmaW5kIGlzIHlvdXJzIHR3
byBhbnN3ZXJzIHRvIGEgc2ltaWxhciBwYXRjaGVzIHdoZXJlIHlvdSdyZSBzYXlpbmcgdGhhdAo+
IHRoaXMgaXQncyBhIHdyb25nIHNvbHV0aW9uIHdpdGhvdXQgaW4tZGVwdGggZXhwbGFuYXRpb24g
YW5kIGZ1cnRoZXIKPiBkaXNjdXNzaW9ucy4KClllYWgsIHRoYXQncyBteSBwcm9ibGVtIGFzIHdl
bGwgSSBjYW4ndCBmaW5kIHRoYXQgb2YgaGFuZC4KCkJ1dCB5ZXMgaXQgY2VydGFpbmx5IHdhcyBk
aXNjdXNzZWQgaW4gcHVibGljLgoKPgo+IE1heWJlIGl0IHdhcyBkaXNjdXNzZWQgcHJpdmF0ZWx5
PyBJbiB0aGlzIGNhc2UgSSB3aWxsIGJlIGhhcHB5IHRvIGdldAo+IG1vcmUgaW5mbyBmcm9tIHlv
dSBhYm91dCB0aGUgcm9vdCBvZiB0aGUgcHJvYmxlbSBzbyBJIGNvdWxkIHN0YXJ0IHRvCj4gbG9v
ayBhdCBob3cgdG8gZml4IGl0IHByb3Blcmx5LiBJdCdzIG5vdCBhcHBhcmVudCB3aGVyZSB0aGUg
cHJvYmxlbSBpcwo+IHRvIGEgVFRNIG5ld2JpZSBsaWtlIG1lLgo+CgpXZWxsIHRoaXMgaXMgY29t
cGxldGVseSB1bmZpeGFibGUuIFNlZSB0aGUgd2hvbGUgcHVycG9zZSBvZiBUVE0gaXMgdG8gCmFs
bG93IHRyYWNpbmcgd2hlcmUgd2hhdCBpcyBtYXBwZWQgb2YgYSBidWZmZXIgb2JqZWN0LgoKSWYg
eW91IGNpcmN1bXZlbnQgdGhhdCBhbmQgaW5jcmVhc2UgdGhlIHBhZ2UgcmVmZXJlbmNlIHlvdXJz
ZWxmIHRoYW4gCnRoYXQgd2hvbGUgZnVuY3Rpb25hbGl0eSBjYW4ndCB3b3JrIGNvcnJlY3RseSBh
bnkgbW9yZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
