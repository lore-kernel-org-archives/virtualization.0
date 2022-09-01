Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFEAECAAD2
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 07:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4715582EA4;
	Thu,  1 Sep 2022 07:16:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4715582EA4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WoSPa4NK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hA9w5DT-U5Bo; Thu,  1 Sep 2022 07:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A25682D49;
	Thu,  1 Sep 2022 07:16:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A25682D49
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 616E3C0032;
	Thu,  1 Sep 2022 07:16:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85550C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C057401C2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:16:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C057401C2
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=WoSPa4NK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cku1HQOmPKgo
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:16:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB262400BB
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB262400BB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7FWfhsNIwuOy3OT430mYaGey6sF8Vu5uEaDtfN1ZjawwylmzfN73TkMV4zrqYXYmL0q96pwqkHSUuYqU+IMKhBSOn3IQ3E4eluFz3k+kJP3mvQvjPGthlcHwjfvF4SvuPsw7QV/Mxn3BuoRVx9j5L3A4y3F4lOhAHKHKRIoapJi4cDhule0jB8nMGTtrKzYgH7onq0pYi1DeoQz75UeP+cHAheeZjtFdxXLMfpYylAgWnlAgLKaVzwY9MRAXgbdGSFUPFSvioX5PD/A5a4dbrdJ8b/EThSK+kktS19t4QkgoDP2nKnmsx7AFyVCMbLgcA2e9Eb6bp1AQbR72xYamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHLVt8A/betNG8SaQLcMk/gr0EGqztrxEPR0r60twJk=;
 b=K98IkF/UVErQl1bxJO17OG1G3BL2n4TR46E8bahAnqMJ2XhqYVCQNsWU7j+kEV3BVw7Be+NK9U0JCBG8azwKxQnpaIkaOyNh1WAwK21t6yWcDmStM2/Ub9yh7at4js2hatO+k58NGRPwQHefQzX9RGC0al4gPq7SSA0DeI1Kzyk/tDgsoa/6FDp2vS0/bmhMfzRzZM+3cuGwtfZaEUGAnhvE+lJliiGCmxQUc5WEdar5VCLJSnl8mez9KjxQ+2Hi0V2H00UcJGGyYZ0Na3r1eqRfEKGWEhg4AdXqxgn9Tj001YOjZTF3nRDK2rGYtmXFP3clr0uMSgM+POEeP0TnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHLVt8A/betNG8SaQLcMk/gr0EGqztrxEPR0r60twJk=;
 b=WoSPa4NKSM+sNNoVSdwEiaNK3CYxWcJM8VyLXLT/1fUeGc8nLV6z6hqveZ/Z6jzaTIFgXD1G85X61HeMqMolDmQjS2jBFPljYyTbStfB1dKRAxY3nex415jYHMIdge6xGHzxdaLd1f5jcFsr7voeme/zkSCkzsz2CUmEqxZLOoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 07:16:44 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 07:16:43 +0000
Message-ID: <192b9a30-6f15-3702-c679-c3f26b76c9ef@amd.com>
Date: Thu, 1 Sep 2022 09:16:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 19/21] dma-buf: Document dynamic locking convention
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
 <20220831153757.97381-20-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-20-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AM6PR05CA0009.eurprd05.prod.outlook.com
 (2603:10a6:20b:2e::22) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5e18351-2cd4-41b9-f3c2-08da8be9ec5b
X-MS-TrafficTypeDiagnostic: BL3PR12MB6547:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AArAxg4nVDu1rhkdi0sNgfrkQsWv+kLvK2ItSwhgIFNzvFeRMASaBVoRGVxBONS745plw8B7i0cnajmxceI/9/O+b3BSSb6ERlL02JLrCNEl++PdQyqxWBFXfREO1y5N5qqtoWKs4s1NlJdOjE/breaBH2RfCQjZnJhUoEka7PcJ+xcMkdoT3D6l/jRRmMcrJd5Sz1Zzme0poH7NokTYcuvgaDitYpkM8rGBLykUW3iBzwrdmYvEvEbMbqw+hBDupzxPuzkjNwcdhwbXPQj0SFslYtIAxcQZQNjDw7Qv7BeSovaOAx6E2eu3LAY4BkA9/NxU9MGtduw45bRVfUmXMHl5ZXPfNfmQxQ0uODW+N6CGT63KjhZnw0Au3nvBTKZnFZwBagO3wuJXt6QIgrm/sgVk543QU/gVjE2pBzFJ3G7Dlf/RaekCRWq6OQMUSJm24Z/CQMTxNqgme5ohCe3CfgeeJbkfkoWibkS6R2GioAn8P3XcqMTxy4gGm8249WNTp7V+2JliOZ2TlVBiByK+uyD+tq0JexBmta9HGbaWutqDBTIyTGcapvwwroLY9gklWM7i7Q+2kX0t2xgEYzHgt9mOn8Bsxf/8zQHew8wkh3TK18AoAix1okNy1wFik0V1WNpkVW7bYPUm3vyPJMwcLWxchRwNp7gG2LS99ycTp2CHZ1kiaGd35lRO7jUd37o0B9MWmXi5UJXdbNpUrNYHH5qhZv2yraTgWK7yGHw6MuCxwXLzahX8vKE4aHxh1rHb4qWLKoOJCW/BVCQqjEnRNSNiGPuDl6uPzuPvk8sT3QpA4kFoXWlp+mQhXRgXbrY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(7416002)(66556008)(66946007)(8676002)(4326008)(31686004)(921005)(66574015)(66476007)(36756003)(186003)(5660300002)(2906002)(8936002)(7406005)(316002)(110136005)(6486002)(478600001)(6666004)(41300700001)(6512007)(2616005)(6506007)(31696002)(26005)(38100700002)(83380400001)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNkL1Y0YnBRM2FRSEFSUEFKSXFBdys5ZmxROHNtYXo5ZFgyZ0hXVEI2a1RC?=
 =?utf-8?B?eDdJbWhReVdmUHo1VWVVY2QzY3pFYU1WRnF5S0t3MnpEak1jT1BLZlgxSEVs?=
 =?utf-8?B?a1hBcmJwbS9FTlZRMktsVkhnQXA3Ulk5VEVuanFlZDdVaWxDZXNPZkZaSVpa?=
 =?utf-8?B?ZDRJZngrTTArLzUyOVc5K25vc1NUVmZKUWZLdXhkMnNHU1lvLzNWcnN5OWhx?=
 =?utf-8?B?TEJ6a2JYYlIxUkdwM1ZyTHVmeVJYWjhTejdWdFFBcndDUFg0ZmVzVEh6elc0?=
 =?utf-8?B?WVlxV3lGWjJqLzlsd1ZCdkxwUUZkcnJpYTJqd29SRXpKQUthVWJRNmJVZVlC?=
 =?utf-8?B?WHAvVkw5cEVvbUR6ejM5U1l1SDBvQzFHeFFOUjdMajFXb1VQZUtNM3NDRU9F?=
 =?utf-8?B?ekdNSk1qemZoK05kQytYamsyTitrZEFvakxFcGc0YlpRR1RlY296ZzNDaURi?=
 =?utf-8?B?bC9TbDBqTG00WXAwUzRqNmxodjhTWVowd0crTzZjV0l6bmh0UWZ6N0FSSUtq?=
 =?utf-8?B?UUs3eXM5YjFOU2FwQWM1NldYdlNhc0FPTFRuQ3lMQzR6VjJjdzJmZmxUV3Nu?=
 =?utf-8?B?ajRvYWlhY3VIZ1hQRThIaEhYNGVBc3JIT0twZjdFUnIvTTViSmE3VlVDOENS?=
 =?utf-8?B?UFQ5TmRrVXZ2a2tiaXkrUkJ5R2diZUF0YlZkMGRFL3dpaktnMnBOaVBUUS9s?=
 =?utf-8?B?TER5RVlFOHMyU25JT0RHVjJzZWloTm1ISHpSNGVFQXN6eUhxWFY2OFBucUhL?=
 =?utf-8?B?SllJV3V6QnFHOHVaZWhaSmJLblNlNkpKNDlmcTdNWnpieldDQkJHQ3RrUkdK?=
 =?utf-8?B?dDFFU0tEbzlScnFGZlNMYjRrT1ZsMEczNVh2UjAzNVdrclJaRzJ3UmdySUsz?=
 =?utf-8?B?bTBEQWd1UGNXakJxSWY5WTRIVjBpcDljWStFMzZMcDZPajBxYWR1VGtRblhh?=
 =?utf-8?B?Wlo0ZE9XWVUveDlzN3pESmN1eFpCYlZiS09lK0UzRGg4UWRPSkxkUnZJWFFR?=
 =?utf-8?B?YXpsYXhKQ1VkM2I4dlhhamJyME92VnlmRVZpWFJiZlRHLzc5UlpHNVRFVmNm?=
 =?utf-8?B?WTRGemZQNGcvZk4yVGZ2azZuYVVrWDJQSmFqVWZJdEx5RWpxcVFpMGIxZmly?=
 =?utf-8?B?eTNZSURqbzFZeFlldGM2UVpQT3lEanZvVFEvQUZZZTFvcVJhbXl6bTVFUERM?=
 =?utf-8?B?aEpBb3BjdVN4UUs5dGEyUUxTYWVQMFduQ1BYSE5MdXltU1c1cmhGM1JrcW1v?=
 =?utf-8?B?TXlPcjdUZENLdEk0WksrRTgzY0F6WXRTa29NWmN2WlJwU1YxMTFERlE5a0s0?=
 =?utf-8?B?YXVMY1BoaVF0c01GaEFRenVKWlhMYkEyUHZzZnNOMlZjY2Fvd0xhWXA1Uk5O?=
 =?utf-8?B?U0RYR2pmWHgvSm5GUWJnZ2NFTzBqWmRGTmZ5eWZLdHdyeWVhTS9HeDN5NzRU?=
 =?utf-8?B?ZzVUcVZrSnZjTDh1UmN5bHF5OVJ1cVhld2wxRDZjNmtuQUlBYnFxY0hyVnJh?=
 =?utf-8?B?cHRzOTNrVGp5REZzenY2VFk2bloyVmNYRUV6K3huaUw2a0dWWFU4YkVPNGFP?=
 =?utf-8?B?VFFwQnpxNlFuZVhtWGZzbjU1SXYyTkFwR2N3UHJmMjIweSt1Uk4xRVd4cjZW?=
 =?utf-8?B?dklmMGppVlJSVGZsYk51ZVRpNE5SV2RaSHdBaEpoenNpamI5NjVBZk0xejhx?=
 =?utf-8?B?TmIySUY1MXB2Szg2T1J1OEcxSFg1RjhrVnBpWTFVa24xU0drOERaNEhVOGcr?=
 =?utf-8?B?VkIvallrV3BUVDB4MFJFOFk0WmptbUJLUU1zcnNETldGc05jWDJ3RE03M1RS?=
 =?utf-8?B?ZWNOc2ZRd3Zwaks2YmorbUROeTdSYVNxcUhrekw2MXhIQ09SdTVMZXREVUto?=
 =?utf-8?B?VTlIR1pHc0xMeW91NkpYMTY3cmJVTE9EWXV0MHZIVGsrMFVuVndGVGlaWE9R?=
 =?utf-8?B?TUJyTW5aelNNNlFlNFlvV0xvY3FRbncyRW1YRnlUZHZDRVhxK2E5NGtKak04?=
 =?utf-8?B?MHNOQnlSbVMreWhJdmxwQWlRZlVmbjdEWUxjZC81eHJic1doVEpZNzFFWXhk?=
 =?utf-8?B?WnlWTmFUTGlRRU0xeXJTcHpPVkVwUkJwVkRsUzkxcHlKZnRvKzAxTjBCMGN0?=
 =?utf-8?Q?BMMjt9L5JlYolxgAYc2AgQyJI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e18351-2cd4-41b9-f3c2-08da8be9ec5b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:16:43.8561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2uzCUa36if5xNJgp6hjWo3+LnOorUhKbWbiHjxBFPC6dUgghPP+e4hbLY4ArK3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gQWRkIGRvY3Vt
ZW50YXRpb24gZm9yIHRoZSBkeW5hbWljIGxvY2tpbmcgY29udmVudGlvbi4gVGhlIGRvY3VtZW50
YXRpb24KPiB0ZWxscyBkbWEtYnVmIEFQSSB1c2VycyB3aGVuIHRoZXkgc2hvdWxkIHRha2UgdGhl
IHJlc2VydmF0aW9uIGxvY2sgYW5kCj4gd2hlbiBub3QuCj4KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0
cnkgT3NpcGVua28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPgoKUmV2aWV3ZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBE
b2N1bWVudGF0aW9uL2RyaXZlci1hcGkvZG1hLWJ1Zi5yc3QgfCAgNiArKysKPiAgIGRyaXZlcnMv
ZG1hLWJ1Zi9kbWEtYnVmLmMgICAgICAgICAgICB8IDY0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9kbWEtYnVmLnJzdCBiL0RvY3VtZW50YXRpb24v
ZHJpdmVyLWFwaS9kbWEtYnVmLnJzdAo+IGluZGV4IDM2YTc2Y2JlOTA5NS4uNjIyYjgxNTZkMjEy
IDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9kbWEtYnVmLnJzdAo+ICsr
KyBiL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9kbWEtYnVmLnJzdAo+IEBAIC0xMTksNiArMTE5
LDEyIEBAIERNQSBCdWZmZXIgaW9jdGxzCj4gICAKPiAgIC4uIGtlcm5lbC1kb2M6OiBpbmNsdWRl
L3VhcGkvbGludXgvZG1hLWJ1Zi5oCj4gICAKPiArRE1BLUJVRiBsb2NraW5nIGNvbnZlbnRpb24K
PiArfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+ICsKPiArLi4ga2VybmVs
LWRvYzo6IGRyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMKPiArICAgOmRvYzogbG9ja2luZyBjb252
ZW50aW9uCj4gKwo+ICAgS2VybmVsIEZ1bmN0aW9ucyBhbmQgU3RydWN0dXJlcyBSZWZlcmVuY2UK
PiAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gICAKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEt
YnVmLmMKPiBpbmRleCBkOTEzMDQ4NmNiOGYuLjk3Y2U4ODRmYWQ3NiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jCj4gKysrIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYu
Ywo+IEBAIC03OTQsNiArNzk0LDcwIEBAIHN0YXRpYyBzdHJ1Y3Qgc2dfdGFibGUgKiBfX21hcF9k
bWFfYnVmKHN0cnVjdCBkbWFfYnVmX2F0dGFjaG1lbnQgKmF0dGFjaCwKPiAgIAlyZXR1cm4gc2df
dGFibGU7Cj4gICB9Cj4gICAKPiArLyoqCj4gKyAqIERPQzogbG9ja2luZyBjb252ZW50aW9uCj4g
KyAqCj4gKyAqIEluIG9yZGVyIHRvIGF2b2lkIGRlYWRsb2NrIHNpdHVhdGlvbnMgYmV0d2VlbiBk
bWEtYnVmIGV4cG9ydHMgYW5kIGltcG9ydGVycywKPiArICogYWxsIGRtYS1idWYgQVBJIHVzZXJz
IG11c3QgZm9sbG93IHRoZSBjb21tb24gZG1hLWJ1ZiBsb2NraW5nIGNvbnZlbnRpb24uCj4gKyAq
Cj4gKyAqIENvbnZlbnRpb24gZm9yIGltcG9ydGVycwo+ICsgKgo+ICsgKiAxLiBJbXBvcnRlcnMg
bXVzdCBob2xkIHRoZSBkbWEtYnVmIHJlc2VydmF0aW9uIGxvY2sgd2hlbiBjYWxsaW5nIHRoZXNl
Cj4gKyAqICAgIGZ1bmN0aW9uczoKPiArICoKPiArICogICAgIC0gZG1hX2J1Zl9waW4oKQo+ICsg
KiAgICAgLSBkbWFfYnVmX3VucGluKCkKPiArICogICAgIC0gZG1hX2J1Zl9tYXBfYXR0YWNobWVu
dCgpCj4gKyAqICAgICAtIGRtYV9idWZfdW5tYXBfYXR0YWNobWVudCgpCj4gKyAqICAgICAtIGRt
YV9idWZfdm1hcCgpCj4gKyAqICAgICAtIGRtYV9idWZfdnVubWFwKCkKPiArICoKPiArICogMi4g
SW1wb3J0ZXJzIG11c3Qgbm90IGhvbGQgdGhlIGRtYS1idWYgcmVzZXJ2YXRpb24gbG9jayB3aGVu
IGNhbGxpbmcgdGhlc2UKPiArICogICAgZnVuY3Rpb25zOgo+ICsgKgo+ICsgKiAgICAgLSBkbWFf
YnVmX2F0dGFjaCgpCj4gKyAqICAgICAtIGRtYV9idWZfZHluYW1pY19hdHRhY2goKQo+ICsgKiAg
ICAgLSBkbWFfYnVmX2RldGFjaCgpCj4gKyAqICAgICAtIGRtYV9idWZfZXhwb3J0KAo+ICsgKiAg
ICAgLSBkbWFfYnVmX2ZkKCkKPiArICogICAgIC0gZG1hX2J1Zl9nZXQoKQo+ICsgKiAgICAgLSBk
bWFfYnVmX3B1dCgpCj4gKyAqICAgICAtIGRtYV9idWZfbW1hcCgpCj4gKyAqICAgICAtIGRtYV9i
dWZfYmVnaW5fY3B1X2FjY2VzcygpCj4gKyAqICAgICAtIGRtYV9idWZfZW5kX2NwdV9hY2Nlc3Mo
KQo+ICsgKiAgICAgLSBkbWFfYnVmX21hcF9hdHRhY2htZW50X3VubG9ja2VkKCkKPiArICogICAg
IC0gZG1hX2J1Zl91bm1hcF9hdHRhY2htZW50X3VubG9ja2VkKCkKPiArICogICAgIC0gZG1hX2J1
Zl92bWFwX3VubG9ja2VkKCkKPiArICogICAgIC0gZG1hX2J1Zl92dW5tYXBfdW5sb2NrZWQoKQo+
ICsgKgo+ICsgKiBDb252ZW50aW9uIGZvciBleHBvcnRlcnMKPiArICoKPiArICogMS4gVGhlc2Ug
JmRtYV9idWZfb3BzIGNhbGxiYWNrcyBhcmUgaW52b2tlZCB3aXRoIHVubG9ja2VkIGRtYS1idWYK
PiArICogICAgcmVzZXJ2YXRpb24gYW5kIGV4cG9ydGVyIGNhbiB0YWtlIHRoZSBsb2NrOgo+ICsg
Kgo+ICsgKiAgICAgLSAmZG1hX2J1Zl9vcHMuYXR0YWNoKCkKPiArICogICAgIC0gJmRtYV9idWZf
b3BzLmRldGFjaCgpCj4gKyAqICAgICAtICZkbWFfYnVmX29wcy5yZWxlYXNlKCkKPiArICogICAg
IC0gJmRtYV9idWZfb3BzLmJlZ2luX2NwdV9hY2Nlc3MoKQo+ICsgKiAgICAgLSAmZG1hX2J1Zl9v
cHMuZW5kX2NwdV9hY2Nlc3MoKQo+ICsgKgo+ICsgKiAyLiBUaGVzZSAmZG1hX2J1Zl9vcHMgY2Fs
bGJhY2tzIGFyZSBpbnZva2VkIHdpdGggbG9ja2VkIGRtYS1idWYKPiArICogICAgcmVzZXJ2YXRp
b24gYW5kIGV4cG9ydGVyIGNhbid0IHRha2UgdGhlIGxvY2s6Cj4gKyAqCj4gKyAqICAgICAtICZk
bWFfYnVmX29wcy5waW4oKQo+ICsgKiAgICAgLSAmZG1hX2J1Zl9vcHMudW5waW4oKQo+ICsgKiAg
ICAgLSAmZG1hX2J1Zl9vcHMubWFwX2RtYV9idWYoKQo+ICsgKiAgICAgLSAmZG1hX2J1Zl9vcHMu
dW5tYXBfZG1hX2J1ZigpCj4gKyAqICAgICAtICZkbWFfYnVmX29wcy5tbWFwKCkKPiArICogICAg
IC0gJmRtYV9idWZfb3BzLnZtYXAoKQo+ICsgKiAgICAgLSAmZG1hX2J1Zl9vcHMudnVubWFwKCkK
PiArICoKPiArICogMy4gRXhwb3J0ZXJzIG11c3QgaG9sZCB0aGUgZG1hLWJ1ZiByZXNlcnZhdGlv
biBsb2NrIHdoZW4gY2FsbGluZyB0aGVzZQo+ICsgKiAgICBmdW5jdGlvbnM6Cj4gKyAqCj4gKyAq
ICAgICAtIGRtYV9idWZfbW92ZV9ub3RpZnkoKQo+ICsgKi8KPiArCj4gICAvKioKPiAgICAqIGRt
YV9idWZfZHluYW1pY19hdHRhY2ggLSBBZGQgdGhlIGRldmljZSB0byBkbWFfYnVmJ3MgYXR0YWNo
bWVudHMgbGlzdAo+ICAgICogQGRtYWJ1ZjoJCVtpbl0JYnVmZmVyIHRvIGF0dGFjaCBkZXZpY2Ug
dG8uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
