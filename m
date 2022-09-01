Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386A7ECAAD1
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 06:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D03A8404B3;
	Thu,  1 Sep 2022 06:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D03A8404B3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EDEVblmh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eOLqrbaWP3Iv; Thu,  1 Sep 2022 06:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 408D5400BB;
	Thu,  1 Sep 2022 06:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 408D5400BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20C44C0033;
	Thu,  1 Sep 2022 06:49:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20395C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06E30819B8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06E30819B8
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=EDEVblmh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JSVs1jA53b6n
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:49:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2905F819B4
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2905F819B4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK82JKVXMMEfjra4ba+Bbnyw4cyJHljQyH3Dupfx5ODHOu+mNpiLSKJRBocoP7hJoGiuBab3ngkHRVk454Py8fdfSHs8RkyAj3yBdx+6fAFhoWI2AASdv/d2s0jMeJDIuHeoduPavY3nOi92VfU/l63LhkBDNNuDNNrtVPZ2++MEOtSY0cBrQWXpXZ+rUHOg5KkgfrvSzAj4P8YVsu3vepaZBdwakvWX8u0Euloz1pypTfSIFXZK1gqNPA2DUK4RmKly/zOcLe4cEAZ2sQaupVmwMQEeGisUkbJpIou41gMihLlCcEgAG7iltFB16fjmAcUkW/swt8x8rzmtfm/fKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPV+fN/IgPonO2d/3mQjufZK877q8riVBr0uiCKDOKs=;
 b=MxBzX0ycYn7NuOzR+d0reLv08HGaVCZUjdk6L8HW85q9rU/N35LAdYPmE7kl+dHu9sLpPJFXWnDEm1xdAkeUxgtE3/K+UhYkDr/0BkoQLeKDm3Yo5Tz2rjIDWAikGihAWEIUsGCuu3GJ2uvcAFPGHaqLVLJV5r87fMYr4RuPyosS1JaPW/MBAmlZVLr5df0nO7CIFYRzzhmOyeerWDDxmWBQzYFlsrwE15/Z8xcK9+7ZA/T9PBSSBOcCMIX52Wq5UOWeOxPLh6xAjcPsdq8TEjs9wmClrXYOHsRO6bwj/72CRcwNie2oGtZ92Jg9HlQJm1UjSNGo5F4FRa5b6GXctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPV+fN/IgPonO2d/3mQjufZK877q8riVBr0uiCKDOKs=;
 b=EDEVblmhCaWwc0JcDYL8iCHEA+Q/XIDPzMYYzjJYCiod4e+Bo2QQMufj3WWEB22FjQ1bTwz0Hjo9hSQKe19+r1t1Wy9quBs/Cb0RIrVqakS1cWubGEW/abT/gMDGt81dAYzy0xjJXQHdzLNw1y+4WIp367b7RU9aB4iClVl+s8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 06:49:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 06:49:16 +0000
Message-ID: <7108c7c3-865e-c74b-b993-1227f31a0ef4@amd.com>
Date: Thu, 1 Sep 2022 08:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 08/21] drm/tegra: Prepare to dynamic dma-buf locking
 specification
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
 Qiang Yu <yuq825@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Tomi Valkeinen <tomba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Lucas Stach <l.stach@pengutronix.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
 <20220831153757.97381-9-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-9-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AS8P189CA0045.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:458::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2e243b5-b0a1-453e-2ddf-08da8be6169c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViNPMCT6YUsrjN4C0212f9sdI8meg/rmTjuFjKvSUparj4FH3lWoT0Vy6WqkMavrm2vEYfpK+Llp+eCMWJ0PSQqNVDUCJFkvmCgnwmsiucgk9b9HeOe0F3DmMoTHGY1DZY/jBtN4F5yJQ5CcqxBMS/lDSXNjtDsskI6yzHjX3a35f+XOmhwoUfckYh9gkfw+UBDpiPxkPbZomH7dPCHzzBlC3jCeIKvi9C/oe2vniy6lrufsdoPDOjAf/d0tF1aEJ4f5xO0jVsLc5q6F764ytQtrUKNrIiHYONdZIGXT8LPY6RbIJncht7tC1Q/seLop8vtwQP4SWWaiw6PB41sFm7Se9ot+TE5NR1R0ITQ8ga0aDhMxBO9j6eEDZ8Um3IjEL2tt+rOI687PhyZ8endNT7YywBL//CKZRH/rAPUGl66dVNLTOYp+xGGIexTLyCP3A4G488WHR+COkt9OKvF71Di8COhb11BKMLcVVJklDhYHuJyE3ZzEhraHPVLVtdmqVBwvT/lkqIBRikS2KyTDrF3ltvM5yfGosBQsLnNxXxvMA4FK/xGrpRAwYwzKgLBCZXs57VyQVvX9wANGjfjjB1seTx5+BQHWguL0yUd93SzukAlsR+8EE5ryEiWUQxmqpKWZ9mvMvEJ2S9npUqpt3Z73Qt2V36ACRjlRM7YrJ4WeNNs2mh/KAZy4viJ5RGol3gRxdGtO7E9vQ2pJCQmVqf6f+tCjzChpOTUukc7zpiYq0aDhRS3BGb59bQ7ntRW9UaNl17JmIWXsBBlJ5BJ39Ia96F7DCFjOoqJ4XFzRpoywJZlOEwEMd//BsqQrZZU9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(83380400001)(38100700002)(66556008)(110136005)(316002)(66476007)(4326008)(8676002)(66946007)(478600001)(36756003)(6486002)(31686004)(6666004)(5660300002)(41300700001)(8936002)(921005)(31696002)(86362001)(2616005)(66574015)(186003)(7416002)(7406005)(26005)(6506007)(2906002)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjVVbmxuOUxGVUdNbVFGYXp4WXZ3cDdPMkVIdEdOUnFIVUd4UW53b2ROTUc4?=
 =?utf-8?B?REREK2tMQTdrRDVxWTFXWWRpM1AwQU9hdzV3OEd5amZBb3FWL1kvNkxPbmZm?=
 =?utf-8?B?K0M2cDFYL1ZreHpCYlJsSGtZczFZWW1PbVY2bmRqVXgvTWlhK0Z4Z1RiSWFD?=
 =?utf-8?B?TUdXKzQrNURNQlpEbE5IL1B5RC93eXIxaG52bGVxUkJqdWMvVTVXTTBxdkdo?=
 =?utf-8?B?blcrVEk1V0JYbDN5ZGRIZEVlZ1VLdm41ZHFJSm9KM2pZaFk3Z2NJUTU5YU45?=
 =?utf-8?B?YzQ0blpjaGR2K1lKYW5udktqS0VnQmtqcFR0ejFZVE1ITjNKcWZoRVpwdGFn?=
 =?utf-8?B?TVFVK0ErRS9Sc2tiOElZSkkxcmt3Z0xFU3EwRVNENTMxakJDNUNzOFc2endH?=
 =?utf-8?B?bG1LWTJpeVdqZHlmUFR5MnozK0xLaFJxSXUyL2lLdUZUWHpBelNxdmh0Rmwx?=
 =?utf-8?B?TWZza0dKWUNhRk9NeTZhYlFPUjVkT05QTmNNRENtUnpzOTkvNFlCRnJUV1Qv?=
 =?utf-8?B?bjBQZzFDS2ExRXRhSWJRayswQ091cGZ1RlBjL2FNcG9ZaXltdXFoN3hlMjg0?=
 =?utf-8?B?dkIydzl0MU9kRTlaUHZ6Y3FvV0lXOUdPLzYwcDFUYUNHRFhrdzljUTliam9P?=
 =?utf-8?B?c1E4WGVQMStNMnhGNEszbzlTVkM0U2pucE8rZk5vL3J6OXdaWCtBdEh6bmpY?=
 =?utf-8?B?ajl1T1FmM2hvNWVBc1FUdzRSb2lXMno4YjhzYlNFWTE5N2ZBMU1PQlAreEhz?=
 =?utf-8?B?ZmU4c0JUYjA1NThlczlNSDNhWUJVMXIxcy9yY2pseERwMjB3T1R3NEdhL0l1?=
 =?utf-8?B?bHZzY2gvaHpWbTUxUCtLcUNwdWhvVGxUZitnZHZMMk1wV0lrSHBDSk5FS3U1?=
 =?utf-8?B?QXZ1amcrSXU3azltS3hIeVdXTjhtVmp3NU1NNFdBcHNCRVdEOEsyMk1mR21w?=
 =?utf-8?B?dk1TcWd2emozczBCUGlEUXFmTis1WUNqVlRMaFJsQlNiNzFsRThVL2lNV2ZV?=
 =?utf-8?B?NEFaWDlnSUVtWUl4NVByNFhMUXVpWE5mMVY2NmRxV3BnWWtmMGUydjlPWnRE?=
 =?utf-8?B?Rjl6VENJOTcyWXB3WmNGc0JLTkI2T1AxMGp0UnRZaldhNmNtVk1VaStPRUo3?=
 =?utf-8?B?RW9XRzNYN3V2cVZOZi9UWXRESTRFS0JOelhYdDFUbzdpSW41ZVYzc01vWFZP?=
 =?utf-8?B?YnNPU2FublRFL3YzMWt3OTVIZ3FUVzBFMTZ3NTlxcXRxSjU2TjNrQ2hXSnJs?=
 =?utf-8?B?MWdycDZwcXpUSGdsTlg0WUJvbTVjOWcvTnF0TzVLNVJLekRmakhsNzE2WjNH?=
 =?utf-8?B?VVZLZVNicGFBUTNCaHg0OTM4ZlVxQmVXSXlNNlZIeVFyRDhjUVFWVW83NE1X?=
 =?utf-8?B?aWJCU2FlZlZvaDB1T2FVUFk1cTdhUmYzTzdMakw5R0E4VUdlNFFacWZlOEJl?=
 =?utf-8?B?TzNzYyt2azJXNkQ5cllTQm9xd3hBSmpqSlIrcG1LSHNRSXVpaE9XU28wdFor?=
 =?utf-8?B?bjFmWWdxMHlZTUo4RFc3dDF6U1o5dU8xbGlhOStHRit4NThZeWhOd1VwTW1m?=
 =?utf-8?B?NVFmV0lVL3lTSUVzM1h2K1ZkNjI2U29OSUhXMXN3TFRUQ2VwZnZmd2M1Wk9X?=
 =?utf-8?B?cHAvYmFmNGhSc3FTamhGSzRCVUZoTTdxSFJZTFhreE1GU3BPSHg4bDF0TUVs?=
 =?utf-8?B?cUVIZEQ5endJMzZCSk51K1FpT2cxNXJqelVqcjdQR3JrRVJORlpvSmVGS3NR?=
 =?utf-8?B?dGVMekd0cy9LVWI2ZmFnc2lYQUo0SVZGWld0VkdhTWNyU1MxOGQvdVZ6NW00?=
 =?utf-8?B?b0ZFbjFGelVRWks5WEl3UjdoNjRlUk5UN3NlN0RWSVhQWHZvY1duZUl1a24w?=
 =?utf-8?B?VDFBWlQ0RldmKzU0RzIwOS83QUtVMjJYblo4aGQ1WWgrMGwxNTliSVJJckdD?=
 =?utf-8?B?ay9ya2NIczBpV3dUQWtoZUlvYXg1WFdrUU1qV2xDQzFvWi9mS0lEdjZRR1ZP?=
 =?utf-8?B?NDhqaStleENNUFlGU0hYNVkyNXprTkNqWXhNa0pWb1krU0l5WTdPT2pSclV4?=
 =?utf-8?B?YmVydEcvRTdHSW9UQXhPMnh6cVN1MlJFcngvYis0L0JiVlBLS2lRVHc5bjJk?=
 =?utf-8?Q?RNBNDJiJ3tT74c54wYf2wtBGY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e243b5-b0a1-453e-2ddf-08da8be6169c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:49:16.6294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQm26iAz+Ydnnf2Sc1GurjvLZy0uzFmUkttuA2nmkIazZdgnldYVSgQ8pmGf0q9V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
Cc: linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 linux-media@vger.kernel.org
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

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gUHJlcGFyZSBU
ZWdyYSBEUk0gZHJpdmVyIHRvIHRoZSBjb21tb24gZHluYW1pYyBkbWEtYnVmIGxvY2tpbmcgY29u
dmVudGlvbgo+IGJ5IHN0YXJ0aW5nIHRvIHVzZSB0aGUgdW5sb2NrZWQgdmVyc2lvbnMgb2YgZG1h
LWJ1ZiBBUEkgZnVuY3Rpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9zaXBlbmtvIDxk
bWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3Rl
Z3JhL2dlbS5jIHwgMTcgKysrKysrKysrLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3RlZ3JhL2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2dlbS5jCj4gaW5kZXggODE5
OTEwOTBhZGNjLi5iMDliOGFiNDBhZTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Rl
Z3JhL2dlbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2dlbS5jCj4gQEAgLTg0LDcg
Kzg0LDcgQEAgc3RhdGljIHN0cnVjdCBob3N0MXhfYm9fbWFwcGluZyAqdGVncmFfYm9fcGluKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGhvc3QxeF8KPiAgIAkJCWdvdG8gZnJlZTsKPiAgIAkJ
fQo+ICAgCj4gLQkJbWFwLT5zZ3QgPSBkbWFfYnVmX21hcF9hdHRhY2htZW50KG1hcC0+YXR0YWNo
LCBkaXJlY3Rpb24pOwo+ICsJCW1hcC0+c2d0ID0gZG1hX2J1Zl9tYXBfYXR0YWNobWVudF91bmxv
Y2tlZChtYXAtPmF0dGFjaCwgZGlyZWN0aW9uKTsKPiAgIAkJaWYgKElTX0VSUihtYXAtPnNndCkp
IHsKPiAgIAkJCWRtYV9idWZfZGV0YWNoKGJ1ZiwgbWFwLT5hdHRhY2gpOwo+ICAgCQkJZXJyID0g
UFRSX0VSUihtYXAtPnNndCk7Cj4gQEAgLTE2MCw3ICsxNjAsOCBAQCBzdGF0aWMgc3RydWN0IGhv
c3QxeF9ib19tYXBwaW5nICp0ZWdyYV9ib19waW4oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
aG9zdDF4Xwo+ICAgc3RhdGljIHZvaWQgdGVncmFfYm9fdW5waW4oc3RydWN0IGhvc3QxeF9ib19t
YXBwaW5nICptYXApCj4gICB7Cj4gICAJaWYgKG1hcC0+YXR0YWNoKSB7Cj4gLQkJZG1hX2J1Zl91
bm1hcF9hdHRhY2htZW50KG1hcC0+YXR0YWNoLCBtYXAtPnNndCwgbWFwLT5kaXJlY3Rpb24pOwo+
ICsJCWRtYV9idWZfdW5tYXBfYXR0YWNobWVudF91bmxvY2tlZChtYXAtPmF0dGFjaCwgbWFwLT5z
Z3QsCj4gKwkJCQkJCSAgbWFwLT5kaXJlY3Rpb24pOwo+ICAgCQlkbWFfYnVmX2RldGFjaChtYXAt
PmF0dGFjaC0+ZG1hYnVmLCBtYXAtPmF0dGFjaCk7Cj4gICAJfSBlbHNlIHsKPiAgIAkJZG1hX3Vu
bWFwX3NndGFibGUobWFwLT5kZXYsIG1hcC0+c2d0LCBtYXAtPmRpcmVjdGlvbiwgMCk7Cj4gQEAg
LTE4MSw3ICsxODIsNyBAQCBzdGF0aWMgdm9pZCAqdGVncmFfYm9fbW1hcChzdHJ1Y3QgaG9zdDF4
X2JvICpibykKPiAgIAlpZiAob2JqLT52YWRkcikgewo+ICAgCQlyZXR1cm4gb2JqLT52YWRkcjsK
PiAgIAl9IGVsc2UgaWYgKG9iai0+Z2VtLmltcG9ydF9hdHRhY2gpIHsKPiAtCQlyZXQgPSBkbWFf
YnVmX3ZtYXAob2JqLT5nZW0uaW1wb3J0X2F0dGFjaC0+ZG1hYnVmLCAmbWFwKTsKPiArCQlyZXQg
PSBkbWFfYnVmX3ZtYXBfdW5sb2NrZWQob2JqLT5nZW0uaW1wb3J0X2F0dGFjaC0+ZG1hYnVmLCAm
bWFwKTsKPiAgIAkJcmV0dXJuIHJldCA/IE5VTEwgOiBtYXAudmFkZHI7Cj4gICAJfSBlbHNlIHsK
PiAgIAkJcmV0dXJuIHZtYXAob2JqLT5wYWdlcywgb2JqLT5udW1fcGFnZXMsIFZNX01BUCwKPiBA
QCAtMTk3LDcgKzE5OCw3IEBAIHN0YXRpYyB2b2lkIHRlZ3JhX2JvX211bm1hcChzdHJ1Y3QgaG9z
dDF4X2JvICpibywgdm9pZCAqYWRkcikKPiAgIAlpZiAob2JqLT52YWRkcikKPiAgIAkJcmV0dXJu
Owo+ICAgCWVsc2UgaWYgKG9iai0+Z2VtLmltcG9ydF9hdHRhY2gpCj4gLQkJZG1hX2J1Zl92dW5t
YXAob2JqLT5nZW0uaW1wb3J0X2F0dGFjaC0+ZG1hYnVmLCAmbWFwKTsKPiArCQlkbWFfYnVmX3Z1
bm1hcF91bmxvY2tlZChvYmotPmdlbS5pbXBvcnRfYXR0YWNoLT5kbWFidWYsICZtYXApOwo+ICAg
CWVsc2UKPiAgIAkJdnVubWFwKGFkZHIpOwo+ICAgfQo+IEBAIC00NjEsNyArNDYyLDcgQEAgc3Rh
dGljIHN0cnVjdCB0ZWdyYV9ibyAqdGVncmFfYm9faW1wb3J0KHN0cnVjdCBkcm1fZGV2aWNlICpk
cm0sCj4gICAKPiAgIAlnZXRfZG1hX2J1ZihidWYpOwo+ICAgCj4gLQliby0+c2d0ID0gZG1hX2J1
Zl9tYXBfYXR0YWNobWVudChhdHRhY2gsIERNQV9UT19ERVZJQ0UpOwo+ICsJYm8tPnNndCA9IGRt
YV9idWZfbWFwX2F0dGFjaG1lbnRfdW5sb2NrZWQoYXR0YWNoLCBETUFfVE9fREVWSUNFKTsKPiAg
IAlpZiAoSVNfRVJSKGJvLT5zZ3QpKSB7Cj4gICAJCWVyciA9IFBUUl9FUlIoYm8tPnNndCk7Cj4g
ICAJCWdvdG8gZGV0YWNoOwo+IEBAIC00NzksNyArNDgwLDcgQEAgc3RhdGljIHN0cnVjdCB0ZWdy
YV9ibyAqdGVncmFfYm9faW1wb3J0KHN0cnVjdCBkcm1fZGV2aWNlICpkcm0sCj4gICAKPiAgIGRl
dGFjaDoKPiAgIAlpZiAoIUlTX0VSUl9PUl9OVUxMKGJvLT5zZ3QpKQo+IC0JCWRtYV9idWZfdW5t
YXBfYXR0YWNobWVudChhdHRhY2gsIGJvLT5zZ3QsIERNQV9UT19ERVZJQ0UpOwo+ICsJCWRtYV9i
dWZfdW5tYXBfYXR0YWNobWVudF91bmxvY2tlZChhdHRhY2gsIGJvLT5zZ3QsIERNQV9UT19ERVZJ
Q0UpOwo+ICAgCj4gICAJZG1hX2J1Zl9kZXRhY2goYnVmLCBhdHRhY2gpOwo+ICAgCWRtYV9idWZf
cHV0KGJ1Zik7Cj4gQEAgLTUwOCw4ICs1MDksOCBAQCB2b2lkIHRlZ3JhX2JvX2ZyZWVfb2JqZWN0
KHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ2VtKQo+ICAgCQl0ZWdyYV9ib19pb21tdV91bm1hcCh0
ZWdyYSwgYm8pOwo+ICAgCj4gICAJaWYgKGdlbS0+aW1wb3J0X2F0dGFjaCkgewo+IC0JCWRtYV9i
dWZfdW5tYXBfYXR0YWNobWVudChnZW0tPmltcG9ydF9hdHRhY2gsIGJvLT5zZ3QsCj4gLQkJCQkJ
IERNQV9UT19ERVZJQ0UpOwo+ICsJCWRtYV9idWZfdW5tYXBfYXR0YWNobWVudF91bmxvY2tlZChn
ZW0tPmltcG9ydF9hdHRhY2gsIGJvLT5zZ3QsCj4gKwkJCQkJCSAgRE1BX1RPX0RFVklDRSk7Cj4g
ICAJCWRybV9wcmltZV9nZW1fZGVzdHJveShnZW0sIE5VTEwpOwo+ICAgCX0gZWxzZSB7Cj4gICAJ
CXRlZ3JhX2JvX2ZyZWUoZ2VtLT5kZXYsIGJvKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
