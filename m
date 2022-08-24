Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C6C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 14:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E437416DE;
	Wed, 24 Aug 2022 14:01:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E437416DE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Hej0/obO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HfmWi-G6wVjG; Wed, 24 Aug 2022 14:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C74C4168E;
	Wed, 24 Aug 2022 14:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1C74C4168E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0BBCC0032;
	Wed, 24 Aug 2022 14:01:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF11C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15627416E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:01:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15627416E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RsNtJJjy2HHL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:01:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 508AF4168E
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 508AF4168E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQMAWHZtg+IA+pEEQFFgW59ZdIR0TfhjmM1khYXe9ENGoDPUTRk0ic5JG633kfrHAUJTMZCt794Hfcy0+NusifMN1U/jC71vmmZaWPxW9CoD0giexkNLLwW2KYoUMNUNEXjjjFHsgpdJlNxOqwU4Z/II1Hu6KIPeera3kf9FvjOaXciEXaBRVsFcrJGqIKQ8k2yfapOGxQ8q/ycgRYoIWRQBTxKCZkYMXCTcmFSxP4bY8Njc9OqcvVULwo4e/PpQuUeWN1s+5Es/cUmu9F5KriyX6yMg+gEYtDzsQgjo5wjNEdvJxc7BDPkV7KToJ1BU/gt7W75PbsfREVbG0bVoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6tnmG1zTM4ApDA7S49avmJ7v1U8WXzdIdLD1/Us1WM=;
 b=Z+mX29rP4QWE87xXy6mbqlLiO9MnFkvU45YZnwheLpZxxhTuA8MnZkQEAEorZCG6rX6EjYfGQcSy5fRcNrHIiKfuZs4Fya+I9IhPL3AHV95jXDg71ys0iri7q/sd3xoz6d5bpB8zhFA3SNqTwYZgf6Fiq3omz6ntBXHkxbuB1ZOu8TrIm0Xe9Qv9nsGY11Jpk5tSen8+pEVqPFT/miPEMfsg7s/T89e7zv5QfF4fJZ8FPijj0L+4QFW3sBFGHbm0bBwDlZIF6ltARuWUSGZLZrBBYHvxitdPRJow74gJY7CHkzLP5QHMQRg7S+i38X4PO15nUFdxqeOKP3EQOdRAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6tnmG1zTM4ApDA7S49avmJ7v1U8WXzdIdLD1/Us1WM=;
 b=Hej0/obOVZj5Zx9l59hKRiN5loPORbM4VObM1YK/8TxN3iaV7Ok1cX+oATnXfK0H+BIStPLbpESFEtIhA11POXQt8+yFtLZq+qMnKbb+rQmKQOCMLy2p6rSuB8SemVsnHiTT8MFKQnRmYlxRxTw/2EM1WcQCLHkDWm3IdtDJ5Ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB1305.namprd12.prod.outlook.com (2603:10b6:3:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 14:01:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 14:01:16 +0000
Message-ID: <45dee40a-e1a9-2554-2af8-ea6b9dbbb161@amd.com>
Date: Wed, 24 Aug 2022 16:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/9] dma-buf: Move dma_buf_mmap_unlocked() to dynamic
 locking specification
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robdclark@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Thierry Reding
 <thierry.reding@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 Qiang Yu <yuq825@gmail.com>
References: <20220824102248.91964-1-dmitry.osipenko@collabora.com>
 <20220824102248.91964-6-dmitry.osipenko@collabora.com>
In-Reply-To: <20220824102248.91964-6-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AS8PR04CA0152.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d244fd-891b-4415-1a87-08da85d91c9a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJaTX2fASYOjxVRoumKCysKPaCQ2jZtQEUNDWdjOd4mrDA+e6s/KEvNAP9D0IUojJex53LZ8aEJtokpzRaZw/RbDSCzyObI1NS/dtWMCpYC08fT798pKoWjAVQtLd1ZRNzKqHjhUygyGcsxijYeRbp2oapDtg5CBauxOwM+kHHAtCNxzE5P/9jAG2O3fb7nX1zgDFOgnMc1xrdZLnpEmq2Xan1xbY2g0Mqra6rBerU+v9InQ7I73ileczcG3YwdfAP844ktPdGojPYiwN+wSsLfmqkvWkPXTvBLQPtX0txDjka5YJlFtkkBoUG7PfdjaApj+e+F02y1morwp3VizTcAquRFswvk3PfqaiXzOPDlvWr/fPJ0+tz+XOiEVacXsY9ggwSdWMrKoptp7AptG9qMA8Hed3bTEwhnKJj6a1+rulBVOIux8u9LExplude3us20K7CKTXFpTJvixcJVmx87ydS2bb61YgV6ImQgq75JUcmxDRkaX3dJYR28CHXHC7EkFyYAtE7K86kSghuvFUAmeFZU0jveGIncfKEY/SCBMj3agJqoTK4+TfXM4veEAbYY8AYIvkmMH5oVHb7Es3xmU68tz+e/wbDlHxCE67CCO3q0F8T22pKkaAv0DT9P0lmX1vZf9EMmR+RrBdjjxeKiiObjnIoONsVF0fmrYzW2u5mTsr06z00m9uWi380slFnqEjOHWXuNd9tG+rWpDt/mgs7nRgakhaxcgfxnYEuc4imd0c4CEXmMJyExbmIVSqHLaHEThmpylV8Y882e9viggRQsOKvbS9dGXOdeXluZx1sWfkVO0tjRsBRe43fin
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(110136005)(66556008)(66476007)(8676002)(4326008)(316002)(66946007)(8936002)(5660300002)(7416002)(7406005)(2906002)(38100700002)(36756003)(86362001)(31696002)(921005)(41300700001)(6666004)(6512007)(6506007)(6486002)(66574015)(478600001)(83380400001)(2616005)(186003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2YxM0JqT2p1azdnZEo5U1JJd0piSGtEYWZBU2NKb3I4TUgxSjgxY292bXpl?=
 =?utf-8?B?MWpBZGFTWlJqZ3BuazUxY2RIc0g0VUQxZlNaQU9VZkNTeFQ0QUkreVBvcWRy?=
 =?utf-8?B?dWhIRFpXN2ppRnhxWFBYQ3d3cDQ4VGxrY1BISXhUN21JWVVTdkxoaXFJSnk1?=
 =?utf-8?B?ZHoxQ2NOMmpJaFh0clZiRHJIQnpmNEorYm5ZcGNmNGhTcEsvZzdRSXRqaHJH?=
 =?utf-8?B?dlZQdGJpUm42dWIyZFA2WTArbTBSQ0pYUEhzeCs5MVdJcVFLYXBNWTN5Vm53?=
 =?utf-8?B?djBBcGQ4RzZ6SkxkQXB1aWZ5OXpaa05QdkN2anFSWXBrQjBrcmdad3ZKN25O?=
 =?utf-8?B?RUpBMWtURHZxdW1oZGhJeGlac2U3My9TZVM4eFFjSWxSUVJlQXZWSzY1R2Mr?=
 =?utf-8?B?RDkvNHcxeWVrUElYWC9mWGhWMU5CejY4dmNBVFJiRHpHemNoQUI3aUtjLzBP?=
 =?utf-8?B?K3RZb1FieUl6dmt4Nnp2RzQxdDUrRlp0Qk9IWENqU1NVa0pYRXVYOWpIVnBC?=
 =?utf-8?B?bEZVeWVqVE1kb3dIcVBCRGtnSWJ4ZUt3R1JnSWJjL09kUWJHQlB0TjA1SVpI?=
 =?utf-8?B?K3VucGJ6QncxK0hVS0FOMEsxeVlSYXBOYnFYSXdzOGVIcUo3MHlKcEpDTlB3?=
 =?utf-8?B?dklLMzk0WjNqV0FZMGxla0g5cUZlb1FveS9oRWU4bk9jd0hoSWEzU1NMT1Jy?=
 =?utf-8?B?TDk4TUJPVVA3TWxKUGV3dHkydzkvbk41a2RHN0NwN0h2RUFSWUxTak9halh5?=
 =?utf-8?B?UTRqdk01bm1TSTNDeXE1enFmK2luS2xob1QySFNaZmRWZDA5NjJwTHUzalRR?=
 =?utf-8?B?NE9udlBDcmFieFIreUhwQ1NkV280WWJFQVVBUkQ0emF5cHlUNVNzNUo2OStI?=
 =?utf-8?B?YmF6K25GYS84aGxLMmhQVFVkRDBBS3lLdjhJc3dmVGc2OGFVdXF3MVczeisw?=
 =?utf-8?B?bzVXaEljSUxTOXF5ZkRvSC9pZnRrTjlsSFZqVEFoWjRKeVBscDJXNUNzWXZk?=
 =?utf-8?B?RzJuSFlKTHhjdy9UUVAwNEx6RzBndXdVa0pLTDEvQlVUTFJzdmUwRGxaelAz?=
 =?utf-8?B?NVpvNS9BOWZIWGNzdWo4RDZRWU1nYkt5Zi9zS3owRHlWcU9VTFk2N3R1R05t?=
 =?utf-8?B?TlVTRitabzYzUDJhTUtiTmpWeTRXUlFvcjg1QUdLenVLMUhsWXBCNXdtWmY1?=
 =?utf-8?B?VHpmOU42dDEyVnA4eG5TRFMrcUdWeTVaaTRZRks0dzlSK0hQeTdtU1kvcG9T?=
 =?utf-8?B?cjBybGdvL3VOZTlnUFF5YUY1NzZaZnZSZ0dSTjFwdDR2T3NvTkVmMXg0amNz?=
 =?utf-8?B?RTJZK3hwaWxNekRhc05OcUQvd1Yzdjg0VXF6blZ2cFdwUDl4dVREVnZBbWNq?=
 =?utf-8?B?MENENG1ISHJPa0hrYlV2SFU4L01KdHhFZDlHYmo2MjBYaVA0TndPOTkzdGx4?=
 =?utf-8?B?bmFDRnhRNU9VbTJXdzJOaTBLSjZJZzBOUjB4TkJKNnpPR2dwTXRrR3JQTm81?=
 =?utf-8?B?ZHR3bnVBb2k3RHdyMTRCckJWVWFacFB4V0VSZkc3UlJjVVZFcG1IdjJZZ3NP?=
 =?utf-8?B?UnlNNU1Rc1ByRXhMQWJMdFMrMHVORlB4eTNKcmRRcmd2VWdyRFNSL09oVzI3?=
 =?utf-8?B?TmsyVllTdlZUb3N0dUlPUkJRMVFaZEJVSUs0RU1MUnJITTh2U0pjc2tERG9n?=
 =?utf-8?B?ck03VXFzMlVFYUdMNHUwTWJJdjZyUVlFTlNjMEMxSjV1S2NraXV0VC8vdnJr?=
 =?utf-8?B?QlVJMHMvN1Z1NHk4MUNXa3NvU2pIMEsvVVdsN0t4bnRnZVk2RSsyM2hzVUZC?=
 =?utf-8?B?dUZrTFJtdWdsTUtqNHRDdk55NEpkaW1OVm5EdFBzSldXWlNiRi9LVWRTSmRw?=
 =?utf-8?B?SGZlM1Q0T2g1N0pWbUFWQkdvV0xIS1BQODYwNVhQbGdWOHdYeFJiVE1MbERD?=
 =?utf-8?B?OHhma3EyaFVPMW1TTnQxenRwMkhpeFBtVis5SWo1a1dKSXFLWHJ5Zk1rOGlV?=
 =?utf-8?B?UlN5VCszOXpCaEFqQWxoRTNrVkd0VE5qbkkxMjJLQStvbXgvd001NTA3dUwx?=
 =?utf-8?B?Y2ZuTXlncVBCdVBUdGJyWVZGZk9RYzFaKzVVaVR1Nmpjb2ZpRVdoSklJak0z?=
 =?utf-8?B?dFRvc3BBV3pEbU91U1NKNytLR1ZjMU9JZEZPRmlvRk53Um5oL2xYRTdUQUl1?=
 =?utf-8?Q?OkHNpLdnTExpDKrMoqdy67Q3ZiZx7uLLUJzCPB6JirLX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d244fd-891b-4415-1a87-08da85d91c9a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:01:16.3261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIgqr06rV9pGCDGmg1lDmtmR9+TYmrXu7b/z/1OIahmSG9RUbWlHBv8OYypGN5S4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1305
Cc: lima@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, linux-media@vger.kernel.org
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

VGhpcyBzaG91bGQgd29yaywgYnV0IEknbSByZWFsbHkgd29uZGVyaW5nIGlmIHRoaXMgbWFrZXMg
YSBkaWZmZXJlbmNlIApmb3Igc29tZWJvZHkuCgpBbnl3YXkgdGhlIGFwcHJvYWNoIGlzIGZpbmUg
d2l0aCBtZTogQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAyNC4wOC4yMiB1bSAxMjoyMiBzY2hyaWVi
IERtaXRyeSBPc2lwZW5rbzoKPiBNb3ZlIGRtYV9idWZfbW1hcF91bmxvY2tlZCgpIGZ1bmN0aW9u
IHRvIHRoZSBkeW5hbWljIGxvY2tpbmcgc3BlY2lmaWNhdGlvbgo+IGJ5IHRha2luZyB0aGUgcmVz
ZXJ2YXRpb24gbG9jay4gTmVpdGhlciBvZiB0aGUgdG9kYXkncyBkcml2ZXJzIHRha2UgdGhlCj4g
cmVzZXJ2YXRpb24gbG9jayB3aXRoaW4gdGhlIG1tYXAoKSBjYWxsYmFjaywgaGVuY2UgaXQncyBz
YWZlIHRvIGVuZm9yY2UKPiB0aGUgbG9ja2luZy4KPgo+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBP
c2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJz
L2RtYS1idWYvZG1hLWJ1Zi5jIHwgOCArKysrKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1
Zi9kbWEtYnVmLmMgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jCj4gaW5kZXggZjM1OGFmNDAx
MzYwLi40NTU2YTEyYmQ3NDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYu
Ywo+ICsrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMKPiBAQCAtMTM0OCw2ICsxMzQ4LDgg
QEAgRVhQT1JUX1NZTUJPTF9OU19HUEwoZG1hX2J1Zl9lbmRfY3B1X2FjY2VzcywgRE1BX0JVRik7
Cj4gICBpbnQgZG1hX2J1Zl9tbWFwX3VubG9ja2VkKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAo+ICAgCQkJICB1bnNpZ25lZCBsb25nIHBnb2ZmKQo+
ICAgewo+ICsJaW50IHJldDsKPiArCj4gICAJaWYgKFdBUk5fT04oIWRtYWJ1ZiB8fCAhdm1hKSkK
PiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiBAQCAtMTM2OCw3ICsxMzcwLDExIEBAIGludCBk
bWFfYnVmX21tYXBfdW5sb2NrZWQoc3RydWN0IGRtYV9idWYgKmRtYWJ1Ziwgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEsCj4gICAJdm1hX3NldF9maWxlKHZtYSwgZG1hYnVmLT5maWxlKTsKPiAg
IAl2bWEtPnZtX3Bnb2ZmID0gcGdvZmY7Cj4gICAKPiAtCXJldHVybiBkbWFidWYtPm9wcy0+bW1h
cChkbWFidWYsIHZtYSk7Cj4gKwlkbWFfcmVzdl9sb2NrKGRtYWJ1Zi0+cmVzdiwgTlVMTCk7Cj4g
KwlyZXQgPSBkbWFidWYtPm9wcy0+bW1hcChkbWFidWYsIHZtYSk7Cj4gKwlkbWFfcmVzdl91bmxv
Y2soZG1hYnVmLT5yZXN2KTsKPiArCj4gKwlyZXR1cm4gcmV0Owo+ICAgfQo+ICAgRVhQT1JUX1NZ
TUJPTF9OU19HUEwoZG1hX2J1Zl9tbWFwX3VubG9ja2VkLCBETUFfQlVGKTsKPiAgIAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
