Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7FEC48BE4
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 14:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A08F1827D9;
	Wed, 24 Aug 2022 14:11:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A08F1827D9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Y//LBNId
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7MpOBKAhyTsg; Wed, 24 Aug 2022 14:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CD9E827D2;
	Wed, 24 Aug 2022 14:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CD9E827D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24752C0032;
	Wed, 24 Aug 2022 14:11:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81D12C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B6FF60F9D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B6FF60F9D
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Y//LBNId
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ih9A5bGkYQ9N
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:11:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E5AA60F9C
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E5AA60F9C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUI5psnn9YU88ESkQsnWyG7rcl64OJ0HFnQy+NKXu/3hgGBbyryJqkMXNM50xs7AcnKggsGtidGGtKncR4lMjc/zmjhv7JObR12jzchpaTlURCy9zOipDk66ih+tHS3u9TAr/mChASsUXdvrRsyxfRy4KC6adfhpmws1i1gfjMYnjiWC1PLNLrnfCRPQ+Eji2ERhdbFe/pcanj4PhOPAykZ8flSCoZhMjnoor8pJ+8UVuOhYIVBGLGAOCBl5aTWMvmIf+iwmBA9thEJ4cXW0iF2P8vPH4VIP9A3qWxT0EbBR/KuO3hfcuAaEwivMENQn+uWNWnfbKSMfWZcBjI+4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqPUQCej5vuqxvtj8Chlk3T/0EwQ6MX8daIfGCr7o8M=;
 b=Q/zpjzsd8PKzPRAiGtKOrNm8p3Q2b3e9k4ieBxDDyjh3EzefJ9Me1ZYtYK068+Rf4ZvEUam/56iYSNLWZlrr6RmaxFmC9GcKvAPuMehh989ef8FXBMu6lNNBYOjCeUeoTuhIKAbI9rw+w3/wZBHGX7BbKnvBxNuXfL4Eky+pL6EsN21RXyb8jzxiUMWLRlcT0e9ugLTt8n2ZKj8C+9s6Sg/0rX1BBNWrlomGiS9Q5FeUcg390XHLcsy2OGNafpV1JWwjg0uMTd4Ix7iudzEiWJHkENSurCy0kQKKLZwln0gR0ozM+PY1NphkAL5wFdM61fzZRWJlk2EOKClnFMdjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqPUQCej5vuqxvtj8Chlk3T/0EwQ6MX8daIfGCr7o8M=;
 b=Y//LBNIdSuEbi5KCGlt4AFPCl3nZqXVMxwAGSM0Xo5DjjgK3mybzaJy3nO/JGgUaCnA0OnmX91jzkmUpZqAa2s7ZIZidepaK0UpO6DCUtdG+3c1KxaIH0m+AIRiU17Sr+vqOtpsh3tZCYF5XPGSW/+O6p7nJ+8XLC5jSnKUTPfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BYAPR12MB2648.namprd12.prod.outlook.com (2603:10b6:a03:69::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 14:11:15 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 14:11:15 +0000
Message-ID: <d21197ef-79ba-3506-85aa-559e485cfc5a@amd.com>
Date: Wed, 24 Aug 2022 16:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 9/9] dma-buf: Remove internal lock
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
 <20220824102248.91964-10-dmitry.osipenko@collabora.com>
In-Reply-To: <20220824102248.91964-10-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AS9PR06CA0201.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76c69caa-e6d6-4c43-2812-08da85da6d0c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2648:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VSKBO3XVc60D6700YOxH3qjcLUmE2UHEi2mI+MhmJ/MabENgXv175BTq9gicdOwsbLl6DboRwf3C0R4iUsSUlzUB+FErIFQujRWLaidiKxMNQpLmrftNqJiZtlUiRPPSmACZw8ngw/BmNnOR0cwbi5crKHiRsEYZwVO7kUUOkumfcWSsa014UC5Qif5PGZB+i65ibarH3vPad91UpSDM/7CDwtU6D35gvKLk9d7iuIpALo4ma+JTP9hTu3+hhfXDk32XQmPEkNMi1HGJ4a5y+ahZiuxzUJ4n1VWIQDTlIjySXqAAhI0ov69HTKzb/el3qeYKRXbxAhDY9RnxABZUiPWmpn/xAyALiEFv56f03dptW4bVGHeUaS8wOM/q0FnjnS8WF9FdTRVuhMWvcVmqD29hXtoVU61iESxVTeccAHajR50eum37uvIo9eKEvA3AuO4IRTI3Zz6MpUlBtvg2LR97P76fBFZLZUhrF34r3eI3EYO10cQhD8bnEPaIYvsHsRD9waTEIKjmX2FoZcE+cBGnXbZKzZYoVfurESKtTUvDuiwIuQ7ekARRFLnEHrFjbMczY+oaBrmBBf/5Uy99FCaLMl9joHpNQ25ZdI6ePwg2m5eEul94KmFbcn4vATqoT2+1pZo4jjX/GQ1ltpkNkHBJngnvOnGnu+1mY1hkbbjY7iQZ8HTFI6fTtIjd+ggyVzELS14e0/7y4vK30BcGroHHHIGBXDjt7OvdjSbVNkaR9O/oxyULbWkEauoZPlmwBBRHg79EZfpjxeXkwgTm38lhqcWN/6m5N9RP1/Era0rJl3yuBe7y/cWaej4H757
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(8676002)(4326008)(316002)(66476007)(66946007)(110136005)(66556008)(8936002)(7416002)(7406005)(5660300002)(2906002)(38100700002)(36756003)(86362001)(31696002)(921005)(6506007)(41300700001)(6512007)(6666004)(6486002)(478600001)(66574015)(83380400001)(186003)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDRhU3QzVEpIbHdENXZYMmJVYi95UjdFWVQ1c2Rxem1hQnd2YnpyZW1wSE1q?=
 =?utf-8?B?U2JJT0NzK1NEZ3Q2Q2w0YVlpOWdrUmI4UWdZeWYzNm9ZQnpWV0EvU0pGR3RV?=
 =?utf-8?B?eXlJTEVnTmJIdHpxbXVjMm1FZnJOdVE5dkxqM2NuTXFHdkl5dnRCOHhSTkwv?=
 =?utf-8?B?OUNuNXgwY0FESjhadlZxTUxZZ09mWFFDc2tWa1FMQzQ2K0NVU2JZSnZVakJ1?=
 =?utf-8?B?RXNzdHZkN0hNOGpveTJxZUV2T0haYUVZQW5wZGNrUWRCMGJZN05FUk8xVmZ4?=
 =?utf-8?B?VzJXV1JDalpWVWVuZWRHQ1kzZWlSVi93YlhiRVRNcERHR3JFaDR2S3hqRHV4?=
 =?utf-8?B?SkxJRThRb0Z3OVYxRUs2eVhlcVpuUHRHT1NGWGlXTTNtUnZwbnhWS01WRjdw?=
 =?utf-8?B?c1N4WDhsdUxsQjFkamNYM2VzMWhOeXZPT1Y4a1ZzKy9iS0lPUEp3UjJEVi9z?=
 =?utf-8?B?R1p2d2NtUVpuaVBlTWszZU80M3lTRjdXZkJya01RV0gyR3lkMnVUZmJvKy9X?=
 =?utf-8?B?ekxYaEJlbjcwU0paYVFmcld3bFBwUGZWSFRJVXNHMURORmN6UDdodlV1Q2xG?=
 =?utf-8?B?bW4wZWVPOTJWdnd2c2NaQ3dLcm02V2hsUENmUDNOeVNsNU5zWUNqc1VZUkJm?=
 =?utf-8?B?N04zVTZHcVRNVEp1cC8rMHg0WENGYWp0c0VGWTVHRjRNdVUzMDk1L25KVkFT?=
 =?utf-8?B?MjJPeWxneWx6K3NjY0VIdFhkOVE5dW94WThNSjcyRmVEK29EaXlLbGFVbXIw?=
 =?utf-8?B?eklrQzRsN3JTay9sOXJwVnp5VnppL1NHaGxyc0pmRU4xVnJWUlVjK2ZBcUtT?=
 =?utf-8?B?ZkNIS0lOUU0zVysrcU8wc25CeTRBeUJ1dlFBMVVZOXFKOHVJNU9qV0lzcjk5?=
 =?utf-8?B?NUVPb0JhekpLaDVEQUxNQVFmeXAvOVhZZ0ZHNWhFaGJYV1p1TFRCaGdvYTBN?=
 =?utf-8?B?U1BqdlBML3cwaXVOUksrUTducXduV2xYbkJMNHI0aWFoczNUOTl6ZEo5VG9K?=
 =?utf-8?B?QUxhdmFZNWFjbHhQWlI1eUsremV3blNFUUlPL1NDM3llcy80ZlV3eXlYeWQ3?=
 =?utf-8?B?RTRjYkI2Z2t4NUxidE5TV3NpNDFLeHB4YUt6MzNNcmJid25mdVZuZ3hqaVFQ?=
 =?utf-8?B?MExudlV0VFZCQmUyNVY4R2hSdkZEc0tnRENKZDNoK1lNVnEzVklDa1RmZGQy?=
 =?utf-8?B?dDMyaFp6eEdadVRyVCtYL1puN3RQS3VxT01ndENZMTNFblBvSnArOUJ0OFIx?=
 =?utf-8?B?ejVnUGIycnd1YU4vZ1lzem12R3NJQUhjQUMvQmRSdTJ1VVVCalMrTHlsWlJC?=
 =?utf-8?B?TlcwS0hDSnY3SCtqdTVmMnowQ25PUHQ4cTY0VWZEU2poeWo3SU9yWjNXbDlT?=
 =?utf-8?B?K3pkTlgwWDYzbmE4RzdjNU55bzVtSUlJWHNqMi9ZUGFtL1JtREpRTnAwZlNQ?=
 =?utf-8?B?QXJ0ZW5oTzJOS2tJc0E4ckF0bUY0bFpzUjFQUEZqb1kzazdJWXdIQ21LZFhS?=
 =?utf-8?B?ZXd2NnNNc3lkSTJvaGdzNHhCK01oSWpTYllLUzZ1cXRGWkYrUmNGcXRaQlNF?=
 =?utf-8?B?SXFpcllTa3EzWjN6WkRscGVGdURjS1MzdlFWcVlkcmQ1WW5pdDhhL3RJMjg4?=
 =?utf-8?B?NEh3Uk1RaFVZMFJKMW40bG9PQkgwQjlMSUd4ZzRMbExVcDJmOXVHYUQyZ2Zz?=
 =?utf-8?B?RGFDaTBBdi9LdjMzejEyRFh2cFU0dUo0cTkzMm8rVmlqVDZON1JEUFhObVlo?=
 =?utf-8?B?YUVWblVmaVZhVS9XMWVWYy8vaVdhZnhNdkNOWmVlbXZjbEE4OVgzay9Wa3VZ?=
 =?utf-8?B?cXFWZVBmQll6Q2ZiWVoyRllwRlRIQzFqYUJkVHNtVUthZjdYc1RHRE9mYjFq?=
 =?utf-8?B?dmpDUXhLZW1QeTRxZDRueklqUGpzSyt5bDhpUkxHVHRGVWJnUU1pQ2k2LzJv?=
 =?utf-8?B?UWtldHhvOU1ORzRXYTJUaGU4QVVLaDY4MHFXbFNPeldZTk1zUU5GTkUvQ1FS?=
 =?utf-8?B?WjlXRDlzRW16MXNpbUYrTEJSaVhtRFJZdmY0dzkxRHRBZUF0UUY3bGVVQmJJ?=
 =?utf-8?B?aWFwb21NK29nYTlvRkpVZHVjcTJ4bllycGJpcmlnY0lDaVJnM0lIbFYyUTl3?=
 =?utf-8?B?WHBMNDNqTklPTzV3VzQzK0dzekduNnRPWHVYTFpFWUxQSmZRU2x5MVhpbUpG?=
 =?utf-8?Q?ILnLIrs5Ygm+v/XQ6cJZqkDh2bCP9E1S12oQDCawdwHH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c69caa-e6d6-4c43-2812-08da85da6d0c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:11:15.3482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jp+ksizDe2sYMUnT835OV/S/9lhwOXHwCsiMjF3DqrQWyU7iN8QBhkiekMxXDHKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2648
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

QW0gMjQuMDguMjIgdW0gMTI6MjIgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gVGhlIGludGVy
bmFsIGRtYS1idWYgbG9jayBpc24ndCBuZWVkZWQgYW55bW9yZSBiZWNhdXNlIHRoZSB1cGRhdGVk
Cj4gbG9ja2luZyBzcGVjaWZpY2F0aW9uIGNsYWltcyB0aGF0IGRtYS1idWYgcmVzZXJ2YXRpb24g
bXVzdCBiZSBsb2NrZWQKPiBieSBpbXBvcnRlcnMsIGFuZCB0aHVzLCB0aGUgaW50ZXJuYWwgZGF0
YSBpcyBhbHJlYWR5IHByb3RlY3RlZCBieSB0aGUKPiByZXNlcnZhdGlvbiBsb2NrLiBSZW1vdmUg
dGhlIG9ic29sZXRlZCBpbnRlcm5hbCBsb2NrLgo+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9z
aXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9kbWEtYnVmL2RtYS1idWYuYyB8IDE0ICsrKystLS0tLS0tLS0tCj4gICBpbmNsdWRlL2xpbnV4
L2RtYS1idWYuaCAgIHwgIDkgLS0tLS0tLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVm
L2RtYS1idWYuYyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMKPiBpbmRleCA2OTZkMTMyYjAy
ZjQuLmEwNDA2MjU0ZjBhZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5j
Cj4gKysrIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYwo+IEBAIC02NTYsNyArNjU2LDYgQEAg
c3RydWN0IGRtYV9idWYgKmRtYV9idWZfZXhwb3J0KGNvbnN0IHN0cnVjdCBkbWFfYnVmX2V4cG9y
dF9pbmZvICpleHBfaW5mbykKPiAgIAo+ICAgCWRtYWJ1Zi0+ZmlsZSA9IGZpbGU7Cj4gICAKPiAt
CW11dGV4X2luaXQoJmRtYWJ1Zi0+bG9jayk7Cj4gICAJSU5JVF9MSVNUX0hFQUQoJmRtYWJ1Zi0+
YXR0YWNobWVudHMpOwo+ICAgCj4gICAJbXV0ZXhfbG9jaygmZGJfbGlzdC5sb2NrKTsKPiBAQCAt
MTUwMyw3ICsxNTAyLDcgQEAgRVhQT1JUX1NZTUJPTF9OU19HUEwoZG1hX2J1Zl9tbWFwX3VubG9j
a2VkLCBETUFfQlVGKTsKPiAgIGludCBkbWFfYnVmX3ZtYXAoc3RydWN0IGRtYV9idWYgKmRtYWJ1
Ziwgc3RydWN0IGlvc3lzX21hcCAqbWFwKQo+ICAgewo+ICAgCXN0cnVjdCBpb3N5c19tYXAgcHRy
Owo+IC0JaW50IHJldCA9IDA7Cj4gKwlpbnQgcmV0Owo+ICAgCj4gICAJaW9zeXNfbWFwX2NsZWFy
KG1hcCk7Cj4gICAKPiBAQCAtMTUxNSwyOCArMTUxNCwyNSBAQCBpbnQgZG1hX2J1Zl92bWFwKHN0
cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBpb3N5c19tYXAgKm1hcCkKPiAgIAlpZiAoIWRt
YWJ1Zi0+b3BzLT52bWFwKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+IC0JbXV0ZXhfbG9j
aygmZG1hYnVmLT5sb2NrKTsKPiAgIAlpZiAoZG1hYnVmLT52bWFwcGluZ19jb3VudGVyKSB7Cj4g
ICAJCWRtYWJ1Zi0+dm1hcHBpbmdfY291bnRlcisrOwo+ICAgCQlCVUdfT04oaW9zeXNfbWFwX2lz
X251bGwoJmRtYWJ1Zi0+dm1hcF9wdHIpKTsKPiAgIAkJKm1hcCA9IGRtYWJ1Zi0+dm1hcF9wdHI7
Cj4gLQkJZ290byBvdXRfdW5sb2NrOwo+ICsJCXJldHVybiAwOwo+ICAgCX0KPiAgIAo+ICAgCUJV
R19PTihpb3N5c19tYXBfaXNfc2V0KCZkbWFidWYtPnZtYXBfcHRyKSk7Cj4gICAKPiAgIAlyZXQg
PSBkbWFidWYtPm9wcy0+dm1hcChkbWFidWYsICZwdHIpOwo+ICAgCWlmIChXQVJOX09OX09OQ0Uo
cmV0KSkKPiAtCQlnb3RvIG91dF91bmxvY2s7Cj4gKwkJcmV0dXJuIHJldDsKPiAgIAo+ICAgCWRt
YWJ1Zi0+dm1hcF9wdHIgPSBwdHI7Cj4gICAJZG1hYnVmLT52bWFwcGluZ19jb3VudGVyID0gMTsK
PiAgIAo+ICAgCSptYXAgPSBkbWFidWYtPnZtYXBfcHRyOwo+ICAgCj4gLW91dF91bmxvY2s6Cj4g
LQltdXRleF91bmxvY2soJmRtYWJ1Zi0+bG9jayk7Cj4gLQlyZXR1cm4gcmV0Owo+ICsJcmV0dXJu
IDA7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX05TX0dQTChkbWFfYnVmX3ZtYXAsIERNQV9CVUYp
Owo+ICAgCj4gQEAgLTE1NzgsMTMgKzE1NzQsMTEgQEAgdm9pZCBkbWFfYnVmX3Z1bm1hcChzdHJ1
Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgaW9zeXNfbWFwICptYXApCj4gICAJQlVHX09OKGRt
YWJ1Zi0+dm1hcHBpbmdfY291bnRlciA9PSAwKTsKPiAgIAlCVUdfT04oIWlvc3lzX21hcF9pc19l
cXVhbCgmZG1hYnVmLT52bWFwX3B0ciwgbWFwKSk7Cj4gICAKPiAtCW11dGV4X2xvY2soJmRtYWJ1
Zi0+bG9jayk7Cj4gICAJaWYgKC0tZG1hYnVmLT52bWFwcGluZ19jb3VudGVyID09IDApIHsKPiAg
IAkJaWYgKGRtYWJ1Zi0+b3BzLT52dW5tYXApCj4gICAJCQlkbWFidWYtPm9wcy0+dnVubWFwKGRt
YWJ1ZiwgbWFwKTsKPiAgIAkJaW9zeXNfbWFwX2NsZWFyKCZkbWFidWYtPnZtYXBfcHRyKTsKPiAg
IAl9Cj4gLQltdXRleF91bmxvY2soJmRtYWJ1Zi0+bG9jayk7Cj4gICB9Cj4gICBFWFBPUlRfU1lN
Qk9MX05TX0dQTChkbWFfYnVmX3Z1bm1hcCwgRE1BX0JVRik7Cj4gICAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9kbWEtYnVmLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaAo+IGluZGV4
IGQ0OGQ1MzRkYzU1Yy4uYWVkNjY5NWJiYjUwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgv
ZG1hLWJ1Zi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9kbWEtYnVmLmgKPiBAQCAtMzI2LDE1ICsz
MjYsNiBAQCBzdHJ1Y3QgZG1hX2J1ZiB7Cj4gICAJLyoqIEBvcHM6IGRtYV9idWZfb3BzIGFzc29j
aWF0ZWQgd2l0aCB0aGlzIGJ1ZmZlciBvYmplY3QuICovCj4gICAJY29uc3Qgc3RydWN0IGRtYV9i
dWZfb3BzICpvcHM7Cj4gICAKPiAtCS8qKgo+IC0JICogQGxvY2s6Cj4gLQkgKgo+IC0JICogVXNl
ZCBpbnRlcm5hbGx5IHRvIHNlcmlhbGl6ZSBsaXN0IG1hbmlwdWxhdGlvbiwgYXR0YWNoL2RldGFj
aCBhbmQKPiAtCSAqIHZtYXAvdW5tYXAuIE5vdGUgdGhhdCBpbiBtYW55IGNhc2VzIHRoaXMgaXMg
c3VwZXJzZWVkZWQgYnkKPiAtCSAqIGRtYV9yZXN2X2xvY2soKSBvbiBAcmVzdi4KPiAtCSAqLwo+
IC0Jc3RydWN0IG11dGV4IGxvY2s7Cj4gLQo+ICAgCS8qKgo+ICAgCSAqIEB2bWFwcGluZ19jb3Vu
dGVyOgo+ICAgCSAqCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
