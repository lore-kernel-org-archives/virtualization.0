Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6700CC00140
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 09:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B612641BD8;
	Thu, 18 Aug 2022 09:41:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B612641BD8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bOjGFHbo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J8cVppUFt3ox; Thu, 18 Aug 2022 09:41:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A2F5941B9A;
	Thu, 18 Aug 2022 09:41:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2F5941B9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 472E1C0070;
	Thu, 18 Aug 2022 09:41:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ECF8C0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 09:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7B3884046
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 09:41:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7B3884046
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=bOjGFHbo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X7Vv_w9SlA9p
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 09:41:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33F9A84044
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33F9A84044
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 09:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAHjXFMQEpsUyhhF1w1z/mJSZF8yzvRznPnFa8BoertMhkPEkz6eLND7yA6Jga3tk+NQSQ/wvN2fp9DLKAFFjaJtMgGTqk4UY9CAAsyN58G0ZfkAHBf8m/ZhltOqqCF3uIEEKaO61sSD49rTryNwMw+g/CqPqw2UYliPjBNMzR4YZn0Gtpycqkh1yJkobvy+AmY4e6EXsSrMK0/PbHT8MtEMP3MZ8hUWsYo7EVKD8T9fCJlIo+1hlUXhjHYJJqi4Gsys4RovREMNZuO9aVPi2yLcTR1rmdckIiL6iPb+cK0hcfEJCYw8cSDygxJwuRU0/TnUFNhrKy94gJ5alxzRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdBPYrSTj3WrTTpE0XCge+jc7BgLjh6h6rMVcET5qiM=;
 b=L9qEpTjl1G7xd9DzaLEOahUtohrnnR9+892M45XRM+31tGGYiu2+Uuq69cyPBqzrzVUhgE8cw7G17l4A+2eFkMHcHhaMRG9znKwhZkzYZQYG61H/wUgrVc7/yY30XYQUdvyedsJxEft8iD2mtT/WsKujmpZa1kPjaAwfT6o5ahUkynM4x/oeK4BQ+XTxsxeBPh2jReezGDLVIK89VktBeoITSz4R85fFzaDgNqlTmiW7lwSVyYS8rNdhxKYawzCEc2JypwdRpX22PcG4uRGlT4+UoaB9uGO7vN4e2wbnJE1Sr5wDILWFvSfhSJZrqXsg0vV/Ky/hs3dUHnDvoxZ83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdBPYrSTj3WrTTpE0XCge+jc7BgLjh6h6rMVcET5qiM=;
 b=bOjGFHbo+kWlZjDKMyH5nJRosD5tlhA6qepQ6h4ElAjdocRauIpHFO0/YcAY2jYEDfnNKvKzCVc6ivEEhUfXn56y38ZCO4yz84l9rDO7ZJMiSs7hWeK0OEZVuSy01R5zfZUUmabnVkcI//BsVGNE4Gwpx8RrXJ4fjlg9ANtChrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3230.namprd12.prod.outlook.com (2603:10b6:208:108::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 09:41:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Thu, 18 Aug 2022
 09:41:22 +0000
Message-ID: <b1963713-4df6-956f-c16f-81a0cf1a978b@amd.com>
Date: Thu, 18 Aug 2022 11:41:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] drm/ttm: Refcount allocated tail pages
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Trigger Huang <Trigger.Huang@gmail.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
 <73e5ed8d-0d25-7d44-8fa2-e1d61b1f5a04@amd.com>
 <c9d89644-409e-0363-69f0-a3b8f2ef0ae4@collabora.com>
 <6effcd33-8cc3-a4e0-3608-b9cef7a76da7@collabora.com>
 <ff28e1b4-cda2-14b8-b9bf-10706ae52cac@collabora.com>
 <48b5dd12-b0df-3cc6-a72d-f35156679844@collabora.com>
In-Reply-To: <48b5dd12-b0df-3cc6-a72d-f35156679844@collabora.com>
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae2365c8-0189-4d47-509e-08da80fdcf2e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3230:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COcJmbnyKVW66i3ZLRmFFNfkWy6jrYJ14uCsdH2TAfHukAdXyzwxsTKoN3wDMR1ZtUhxITlniJkFrHYuTaVjKUFOSVpSaMGDZiLEqOYB4+FS5gxGD2X6ZU9rwk03XYNOFl38slWwMtuiNQPAHSJSJNqOA4UFtm+vGeiTRoXq2Md/w1Gxi+zT9obMXi5Ewqh/AvsiQI5tTNF1Ww1HY6SODevJVsBahOwrSP6ktLM2Hx6NiEtyIJHZLG1cgocpjReGKbXeiu0VVjur7XMUxmCp3WW4NCsRRhhCjosXpJcI3p0Cka+7MDc+vxjzMCU1zC+p8cAkEJJAoARY1hljbe9aulcgwk4Gg5+TABfiQHtwfLqHm4QbrfSTS1QnGL/5ESwk/sos0g9azbQH+UObdRL01BZsifuu58Ij6m33xaEMjg8E69vF9McxXJoRUkC+LTQv2ZyL93gQd/Najjrh2AS0QPLrwF08EBcY04mkVi1NgyOYL6IngKUAB9W5GJ2ZmUfL9XqTX2AkrJ4HN0/UvyYcSFjAM+3EUkkFki+kvffXbVt4d5WNxbNudev3ArOEz/1v2u7mxpEZy0fOdZ/5nal0497D37U57HOy9cRlUz7BngyCeuxaLWGMXQ3xCGrfO5/vOVD7mKVW8MYxBIg7TvYv9fxPtZSPyGX3RNGo7IcMjLStFljr0PSLFniozpeytN2LYX566kx60Wy98J3u/jBN1YrL+WT/AYcChLtWntyljMlBkQsyzBRXtZy7j/lnBrTXsJTToFNsh099neVJCuvAfAJ5H8+Ch2JBMckBlLjsUs9z5xY1UKE//wI5+QCA192WxUwmEjBLAQgbVcXVIpXjeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(86362001)(2616005)(38100700002)(186003)(66574015)(83380400001)(8936002)(5660300002)(8676002)(4326008)(66946007)(7416002)(66476007)(66556008)(6666004)(41300700001)(2906002)(478600001)(110136005)(6512007)(26005)(6506007)(53546011)(45080400002)(966005)(316002)(6486002)(31696002)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJCVmVGaml3dTFQUG9qbk1IYmhrWDFPc3JNQmxVQU1LVXBEelJXbHZwNUVK?=
 =?utf-8?B?SVkydU9hdlg5OTJNb0VpU0xsV2dWeHVvNjlIQmg0VnZkVHQ1N1RHOXBUU2ds?=
 =?utf-8?B?Ymw0d0M0WC9GaGs2RTVyVGxzTmZsZStzUSs0bUhRMDhCSXFycy94ZkFkMUVp?=
 =?utf-8?B?MnlLT1YwM09nV1pxMUhycFViUXRsZjNkdThTcnRDQTdqczZPUWdUQk1BUStC?=
 =?utf-8?B?ejBneFpxMC80Mk5XRFdzY0ZFQ004d1ZPVzd0WEhMREhIcWZDQy9xSTIrU1RK?=
 =?utf-8?B?ZXBnd1RTSFhyZU90a0RaeUZjZkZGc2E4WS9RbTZmaDI5Wmc2dktxeHFFa1pV?=
 =?utf-8?B?VFhKTXdSOGVoQ2tpWW9jRkQwN0tqY0pHcnh3akVVR1NDNFcwU1Q0ZTFlVEpl?=
 =?utf-8?B?MzdUZmEycjJzYndONCtxd2pOK0RrS0VBYUJDODdaaW9aMmZHemlCNkx3aExi?=
 =?utf-8?B?YU41N3pIY0E0aWhXdFo3MVlnK2JuQ2NURlc2b2h4MSsyQ1dlWkExTktpblBr?=
 =?utf-8?B?NFhQZjVkTXY0U0J1UVFGNjYveFZxQ1hLQytMZmE3eVQwVTZ3dHRHZWlwK1F4?=
 =?utf-8?B?eXJHMW12KzI0VnJjWHFQL0RZbC9oT2gveXlDZWhXUDUxaExRTGNQQmtwTjd3?=
 =?utf-8?B?ejVEYTBBT0JjOC9OTU5oQWFqTmsrb0Z4TjdOQTZCMDF0b01YVDJxUTJiZC9q?=
 =?utf-8?B?NnRsclB2eUVkcEdsTUYyWnAxMFZKemc4WlF4Z29CMkFDbEFqYVFjeVFmVjhy?=
 =?utf-8?B?YitYOHMyeTZnQUFNKzZMekE4ZE5uRHJhSHZNSmFiTGlsVGRlR3JGMXVGd3lz?=
 =?utf-8?B?a0lWNGZxVUI1VFIzSDR4NmIrWUZiSFcrenc4ZjlTZ3Z5bzRIOWM5ZkFqZ1Rx?=
 =?utf-8?B?a3haZUJEZC9ncFlhc3NidExyUnhKSjRKVW9odDQ2VXYveDN2UnVabk9CK2xF?=
 =?utf-8?B?Nk91QmczcVBZVGpoMnBjK1hzMlJySkRabmE5WWYzOGlYckRaVmtmSlRaQjNt?=
 =?utf-8?B?SCtMakE1cU0zdWhwaXpCa0tQS3dQK29DTmRMaGdzWEtyVlI1MjhHNXZpeE9Z?=
 =?utf-8?B?aUJnRnhlRGVVdzU5cXhuWmxwVWtMdkd5cFJGaXNGbnNLY3dURnlwK2ZocFNF?=
 =?utf-8?B?c0xRK1lDTU9IQlVrVmtiRkVNcE9BTDFiSEIvTzZoY09tbzZtZWpaMFNBQ2wy?=
 =?utf-8?B?ZVJwaXl6TDJudEtiZDNMWVRITlFQeUViU0x3Mzd0Y0czOHBKUDk3WVRZOUVp?=
 =?utf-8?B?cmtVVG5FeGRqTjlSdUxmZVRyNkY0eTNJUDFhd1dpZTJXY3dDYldlNmNyZHF4?=
 =?utf-8?B?M1EwL09EeWZqdHEzOVExS1FwamZWQUdiN1J2OUhvNkhxYmVkT2NPakowMURM?=
 =?utf-8?B?ZWVnYmwrc2oyQmJYdjRXWUgwZTdXa1dOc013TVF2bEY4YVorU05oczZIOXdP?=
 =?utf-8?B?TTNTMW5rUCtYd2t6VjhWNnRLSmZIT2pQRzIzK3piSlk1WW1RN0NNRGRvRkdB?=
 =?utf-8?B?YXcyaXVqQ3lsUjhHZkNESEdnSjl5NmVlVHJ4TjJlVVl6c3ZIVUVqbTVFeCts?=
 =?utf-8?B?RE50Ym5nV3I3N0JRZkNSbWlpMXNHbVJzNnEvRnJ0OEg1MFVMazRDRXIwT2V3?=
 =?utf-8?B?d1ovYmNzSkFWYWZpZUNVMjN1cWE3ekFaYTJNa2NlY01Bc053SzQ0dXoxSEcw?=
 =?utf-8?B?RFBaR0hidUM1YUptYlVHS1E3Q1NtdXQySU1iMkFVeG9TVm50b3pkTGpRN21m?=
 =?utf-8?B?dWRnQXBabEVhU1Z0c0orUzZkQ3RRSHIrQjdpR3pmRUhOSGwxTGp4VW9HWW5O?=
 =?utf-8?B?S1pUKzRQSWJzc0tCNWtDcHV3ellFWjBNdEhmRVYva1kwVE50UytRS242RnRC?=
 =?utf-8?B?RFppcnBEdU9LcEZwTjBicFpLYkxzY2hBWDQ1a3Fwa0JMQUNJSkd3UWM3b2ZW?=
 =?utf-8?B?TExyVHdmR0FCeWcwTkRDdEdZT3c4UFZsMHNKUTZlUnNYUXd0TFpWc1d2SzVa?=
 =?utf-8?B?Z0pmaFkrdTRKNU54OHo3TkZQS3Z3RUZJeWNEdndxN3ZaOWptb0lUb2tWbk1Q?=
 =?utf-8?B?UkRlN1VEWEY5d3VTUUluNGIwdkdHdVFmeHRObHQzOVVKV29iWTR3dncrbXJs?=
 =?utf-8?Q?eFY9ulELUArMdj1Q9+2hW15lz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2365c8-0189-4d47-509e-08da80fdcf2e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 09:41:21.9690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lk3gcADAafiKTmeTI/2Mdcv6l5OlHtCnTqf41jlFdxECds9YwOTXyceSPSG+lTE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3230
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

QW0gMTguMDguMjIgdW0gMDE6MTMgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gT24gOC8xOC8y
MiAwMTo1NywgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBPbiA4LzE1LzIyIDE4OjU0LCBEbWl0
cnkgT3NpcGVua28gd3JvdGU6Cj4+PiBPbiA4LzE1LzIyIDE3OjU3LCBEbWl0cnkgT3NpcGVua28g
d3JvdGU6Cj4+Pj4gT24gOC8xNS8yMiAxNjo1MywgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+
Pj4gQW0gMTUuMDguMjIgdW0gMTU6NDUgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4+Pj4+PiBb
U05JUF0KPj4+Pj4+PiBXZWxsIHRoYXQgY29tbWVudCBzb3VuZHMgbGlrZSBLVk0gaXMgZG9pbmcg
dGhlIHJpZ2h0IHRoaW5nLCBzbyBJJ20KPj4+Pj4+PiB3b25kZXJpbmcgd2hhdCBleGFjdGx5IGlz
IGdvaW5nIG9uIGhlcmUuCj4+Pj4+PiBLVk0gYWN0dWFsbHkgZG9lc24ndCBob2xkIHRoZSBwYWdl
IHJlZmVyZW5jZSwgaXQgdGFrZXMgdGhlIHRlbXBvcmFsCj4+Pj4+PiByZWZlcmVuY2UgZHVyaW5n
IHBhZ2UgZmF1bHQgYW5kIHRoZW4gZHJvcHMgdGhlIHJlZmVyZW5jZSBvbmNlIHBhZ2UgaXMKPj4+
Pj4+IG1hcHBlZCwgSUlVQy4gSXMgaXQgc3RpbGwgaWxsZWdhbCBmb3IgVFRNPyBPciB0aGVyZSBp
cyBhIHBvc3NpYmlsaXR5IGZvcgo+Pj4+Pj4gYSByYWNlIGNvbmRpdGlvbiBoZXJlPwo+Pj4+Pj4K
Pj4+Pj4gV2VsbCB0aGUgcXVlc3Rpb24gaXMgd2h5IGRvZXMgS1ZNIGdyYWIgdGhlIHBhZ2UgcmVm
ZXJlbmNlIGluIHRoZSBmaXJzdAo+Pj4+PiBwbGFjZT8KPj4+Pj4KPj4+Pj4gSWYgdGhhdCBpcyB0
byBwcmV2ZW50IHRoZSBtYXBwaW5nIGZyb20gY2hhbmdpbmcgdGhlbiB5ZXMgdGhhdCdzIGlsbGVn
YWwKPj4+Pj4gYW5kIHdvbid0IHdvcmsuIEl0IGNhbiBhbHdheXMgaGFwcGVuIHRoYXQgeW91IGdy
YWIgdGhlIGFkZHJlc3MsIHNvbHZlCj4+Pj4+IHRoZSBmYXVsdCBhbmQgdGhlbiBpbW1lZGlhdGVs
eSBmYXVsdCBhZ2FpbiBiZWNhdXNlIHRoZSBhZGRyZXNzIHlvdSBqdXN0Cj4+Pj4+IGdyYWJiZWQg
aXMgaW52YWxpZGF0ZWQuCj4+Pj4+Cj4+Pj4+IElmIGl0J3MgZm9yIHNvbWUgb3RoZXIgcmVhc29u
IHRoYW4gd2Ugc2hvdWxkIHByb2JhYmx5IGludmVzdGlnYXRlIGlmIHdlCj4+Pj4+IHNob3VsZG4n
dCBzdG9wIGRvaW5nIHRoaXMuCj4+Pj4gQ0M6ICtQYW9sbyBCb256aW5pIHdobyBpbnRyb2R1Y2Vk
IHRoaXMgY29kZQo+Pj4+Cj4+Pj4gY29tbWl0IGFkZDZhMGNkMWM1YmE1MWIyMDFlMTM2MWIwNWE1
ZGY4MTcwODM2MTgKPj4+PiBBdXRob3I6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5j
b20+Cj4+Pj4gRGF0ZTogICBUdWUgSnVuIDcgMTc6NTE6MTggMjAxNiArMDIwMAo+Pj4+Cj4+Pj4g
ICAgICBLVk06IE1NVTogdHJ5IHRvIGZpeCB1cCBwYWdlIGZhdWx0cyBiZWZvcmUgZ2l2aW5nIHVw
Cj4+Pj4KPj4+PiAgICAgIFRoZSB2R1BVIGZvbGtzIHdvdWxkIGxpa2UgdG8gdHJhcCB0aGUgZmly
c3QgYWNjZXNzIHRvIGEgQkFSIGJ5IHNldHRpbmcKPj4+PiAgICAgIHZtX29wcyBvbiB0aGUgVk1B
cyBwcm9kdWNlZCBieSBtbWFwLWluZyBhIFZGSU8gZGV2aWNlLiAgVGhlIGZhdWx0Cj4+Pj4gaGFu
ZGxlcgo+Pj4+ICAgICAgdGhlbiBjYW4gdXNlIHJlbWFwX3Bmbl9yYW5nZSB0byBwbGFjZSBzb21l
IG5vbi1yZXNlcnZlZCBwYWdlcyBpbiB0aGUKPj4+PiBWTUEuCj4+Pj4KPj4+PiAgICAgIFRoaXMg
a2luZCBvZiBWTV9QRk5NQVAgbWFwcGluZyBpcyBub3QgaGFuZGxlZCBieSBLVk0sIGJ1dCBmb2xs
b3dfcGZuCj4+Pj4gICAgICBhbmQgZml4dXBfdXNlcl9mYXVsdCB0b2dldGhlciBoZWxwIHN1cHBv
cnRpbmcgaXQuICBUaGUgcGF0Y2ggYWxzbwo+Pj4+IHN1cHBvcnRzCj4+Pj4gICAgICBWTV9NSVhF
RE1BUCB2bWFzIHdoZXJlIHRoZSBwZm5zIGFyZSBub3QgcmVzZXJ2ZWQgYW5kIHRodXMgc3ViamVj
dCB0bwo+Pj4+ICAgICAgcmVmZXJlbmNlIGNvdW50aW5nLgo+Pj4+Cj4+Pj4gQFBhb2xvLAo+Pj4+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxvcmUua2VybmVsLm9yZyUyRmRyaS1kZXZlbCUyRjczZTVlZDhkLTBkMjUtN2Q0
NC04ZmEyLWUxZDYxYjFmNWEwNCU0MGFtZC5jb20lMkZUJTJGJTIzbTc2NDdjZTVmOGM0NzQ5NTk5
ZDJjNmJjMTVhMmI0NWY4ZDhjZjgxNTQmYW1wO2RhdGE9MDUlN0MwMSU3Q2NocmlzdGlhbi5rb2Vu
aWclNDBhbWQuY29tJTdDZWNiMGYwZWI2YzJkNDNhZmExNWIwOGRhODBhNjI1ZmYlN0MzZGQ4OTYx
ZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3OTYzNzQ4MzYwOTUyMzI3JTdD
VW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRh
PTUyRHZpc2E3cCUyQmNrbUJ4TXZESkZTY0dTTnk5SlJQRGRuUEswNUMlMkY2bjdBJTNEJmFtcDty
ZXNlcnZlZD0wCj4+Pj4KPj4+IElmIHdlIG5lZWQgdG8gYnVtcCB0aGUgcmVmY291bnQgb25seSBm
b3IgVk1fTUlYRURNQVAgYW5kIG5vdCBmb3IKPj4+IFZNX1BGTk1BUCwgdGhlbiBwZXJoYXBzIHdl
IGNvdWxkIGFkZCBhIGZsYWcgZm9yIHRoYXQgdG8gdGhlIGt2bV9tYWluCj4+PiBjb2RlIHRoYXQg
d2lsbCBkZW5vdGUgdG8ga3ZtX3JlbGVhc2VfcGFnZV9jbGVhbiB3aGV0aGVyIGl0IG5lZWRzIHRv
IHB1dAo+Pj4gdGhlIHBhZ2U/Cj4+IFRoZSBvdGhlciB2YXJpYW50IHRoYXQga2luZCBvZiB3b3Jr
cyBpcyB0byBtYXJrIFRUTSBwYWdlcyByZXNlcnZlZCB1c2luZwo+PiBTZXRQYWdlUmVzZXJ2ZWQv
Q2xlYXJQYWdlUmVzZXJ2ZWQsIHRlbGxpbmcgS1ZNIG5vdCB0byBtZXNzIHdpdGggdGhlIHBhZ2UK
Pj4gc3RydWN0LiBCdXQgdGhlIHBvdGVudGlhbCBjb25zZXF1ZW5jZXMgb2YgZG9pbmcgdGhpcyBh
cmUgdW5jbGVhciB0byBtZS4KPj4KPj4gQ2hyaXN0aWFuLCBkbyB5b3UgdGhpbmsgd2UgY2FuIGRv
IGl0Pwo+IEFsdGhvdWdoLCBuby4gSXQgYWxzbyBkb2Vzbid0IHdvcmsgd2l0aCBLVk0gd2l0aG91
dCBhZGRpdGlvbmFsIGNoYW5nZXMKPiB0byBLVk0uCgpXZWxsIG15IGZ1bmRhbWVudGFsIHByb2Js
ZW0gaXMgdGhhdCBJIGNhbid0IGZpdCB0b2dldGhlciB3aHkgS1ZNIGlzIApncmFiaW5nIGEgcGFn
ZSByZWZlcmVuY2UgaW4gdGhlIGZpcnN0IHBsYWNlLgoKU2VlIHRoZSBpZGVhIG9mIHRoZSBwYWdl
IHJlZmVyZW5jZSBpcyB0aGF0IHlvdSBoYXZlIG9uZSByZWZlcmVuY2UgaXMgCnRoYXQgeW91IGNv
dW50IHRoZSByZWZlcmVuY2Ugc28gdGhhdCB0aGUgbWVtb3J5IGlzIG5vdCByZXVzZWQgd2hpbGUg
eW91IAphY2Nlc3MgaXQsIGUuZy4gZm9yIEkvTyBvciBtYXBwaW5nIGl0IGludG8gZGlmZmVyZW50
IGFkZHJlc3Mgc3BhY2VzIGV0Yy4uLgoKQnV0IG5vbmUgb2YgdGhvc2UgdXNlIGNhc2VzIHNlZW0g
dG8gYXBwbHkgdG8gS1ZNLiBJZiBJJ20gbm90IHRvdGFsbHkgCm1pc3Rha2VuIGluIEtWTSB5b3Ug
d2FudCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgYWRkcmVzcyBzcGFjZSBtYXBwaW5nLCAKZS5nLiB0
aGUgdHJhbnNsYXRpb24gYmV0d2VlbiB2aXJ0dWFsIGFuZCBwaHlzaWNhbCBhZGRyZXNzLCBkb24n
dCBjaGFuZ2UgCndoaWxlIHlvdSBoYW5kbGUgaXQsIGJ1dCBncmFiYmluZyBhIHBhZ2UgcmVmZXJl
bmNlIGlzIHRoZSBjb21wbGV0ZWx5IAp3cm9uZyBhcHByb2FjaCBmb3IgdGhhdC4KClJlZ2FyZHMs
CkNocmlzdGlhbi4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
