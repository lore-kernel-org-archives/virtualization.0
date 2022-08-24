Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303D3C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 17:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9C9282848;
	Wed, 24 Aug 2022 17:45:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9C9282848
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YerBgSf/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id chxN1OKV8jKJ; Wed, 24 Aug 2022 17:45:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 237518294A;
	Wed, 24 Aug 2022 17:45:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 237518294A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D580AC0032;
	Wed, 24 Aug 2022 17:45:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 322B8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 17:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9AC1404EB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 17:45:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9AC1404EB
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YerBgSf/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orSYj74N91au
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 17:45:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD4CD400EC
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD4CD400EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 17:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk0FeJXZspU2IsynjBlAMVcZmEFlX6N5cGB3Ir7YVTKUB6/TsHHqrNDxo5ZYT2FDhtGCLqJm2+TjswPytN9DXbA0UPPQ8TqZxZrtGd5df0SiI4QBk9QbL7fGiNbqQMbnM2lFwh2KUwnUoBPYHbk7ZBZSdO3+MDc2j4YTybvQRcxq8DDap9FP+2reouTjMrwhTb6sMv34t9Sy+p51qjFz7jUubY0W/Exu1mXmewfWsTEe/JY1HYSkLaWS+X2Rn/cW88JP+fHp/qO/SZ1TyBBcVAJFit0EldxSDkJce7wSdLzC5ObtMK/DawRx4Zc/ppTNJSpvr8Aqx9yyh+I0CMdHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GEB4Gmf8gYzYzw0SauFbEYt7He09/ibyOEjSkXO9CY=;
 b=DDt3k5QJvEbQ7XmTsFzzTJIV4feVrOlVExqDFZ8CahUfZouK4EpTh6K8IH2br4tQf+lhLW/jD6cx+suhj0AuGIPQIO7JhWsHodpd2DXuEb9eDcdLBdqJNZApWQidCWDHefGcWzDxaF5BDU9Tay2rKVCf4NZz3d87T7HqYHd7HtY5M9rFt97FMwy9tDcnFuaGaGdCDByZi/YKYUlsKOI/GB9Q25Ht8QIDhtt3hqmzfEggWVu/rjvO2daC3+C9nOcXYarQdwxgEFnWNvUgOi6pxfF2SDhQ7qpa7oTN2fZ+cPAc7k73PTcdDpSCPhj5J2BMHaogrDNUX0SZFmu5So8ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GEB4Gmf8gYzYzw0SauFbEYt7He09/ibyOEjSkXO9CY=;
 b=YerBgSf/XFpE4iZnDoi4PdcU89++Ab5YebBHtep9vpBfkO9NM95ZkO1zvEUZJww/ZyfP8KYERR9PlBKxYEYes3oej/siq7tlxUslb8sSAOM8c9d7sUTm9n9ug90Hur0jH+cvmne2MSfenSiPCyESZmlr5K6BftLWA8CRo3gqGM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB3426.namprd12.prod.outlook.com (2603:10b6:408:4a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 24 Aug
 2022 17:45:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 17:45:19 +0000
Message-ID: <e7576ab7-ff1e-e6da-b0fd-0315f1b37ed1@amd.com>
Date: Wed, 24 Aug 2022 19:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Linaro-mm-sig] [PATCH v3 6/9] dma-buf: Move dma-buf attachment
 to dynamic locking specification
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
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
 <20220824102248.91964-7-dmitry.osipenko@collabora.com>
 <055c3c05-ac4c-430e-f2b9-08f000acf435@gmail.com>
 <25d6b7e7-bbcc-7613-42d1-13c2b9ab2937@collabora.com>
In-Reply-To: <25d6b7e7-bbcc-7613-42d1-13c2b9ab2937@collabora.com>
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f7c82e3-68ba-4b44-e526-08da85f86966
X-MS-TrafficTypeDiagnostic: BN8PR12MB3426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkEyVwKuUGqaWjF1MugYM3eqay2SkldryTEYCa8fcn8T+/ffBrdLrmie2jlarrGb3vL3WTSkS80Slp//Lk6V243xs1mHY6JS/zL2HG4LIwbxU22EXbp8NPRkXQW8qysi/1rmwapGb8BjDbsIFxSPc0h1HwTXaTMQWSRj0zAXHqp1wQXuquisDWUTp1WMN4ahcZBfsD1HSOzmVUjOfSjPKXqMOkscLRODHntcSmvsgYiKZJAI37cnKT1KuiJMzVaCSFn0VUtKNbZKeD5Zi7x4Hei6LcDUDRoYnPv4Kzhm6eExFFwds3MApBRXe4MYUaE3/OgBygkQ4xXaysIfyg/9umsRz79tbWhoInrPG3O5M91HdUbHHeBvV8h8uEXrci9x+3COgA8ZAgxDi3hH3rzfXRBaQFNSKTRP3QZVHXCUJG+r0ceHhsmw6EP+fIrdjzn3gmkwh8VuQj9WVFUQoILkq7Jt1ei24BxcIJYyuAFXpto2tM8kyGl/Hz0tvLgO9dNUZoTuBb0JVq9mZ13cXmG5j5nHSqppmUqY1ENIjKIyrMR6sKyEMTJtLIC4ztLjQosmUUTI1Z0T64AaV+EOh+GuXwmWcDvb/lPbAjczo2Vs6nhfNgC4h2d7V18ZEmSPouJ5g2ejXDZBcf4I12GbE8Ej44ga0Kb+NmGJhttT4qYvHV9lgDFHtZDOnZcfX41e/R1NlIE02aNFBjc7reqg3EyJsg3hq6vYx3ySE9LAKALdeXOiMx1nI23q7Si2pSynsdup+A+Lv5DyAAY048pYM1TTEZxp1ZsXn2JeH/Lo/fXQEJpaGZZFzz9QiLF9gtUG6JLh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(66556008)(66476007)(8676002)(110136005)(66946007)(316002)(7406005)(5660300002)(7416002)(4326008)(2906002)(38100700002)(8936002)(6666004)(31696002)(86362001)(921005)(478600001)(36756003)(6506007)(53546011)(6486002)(41300700001)(186003)(66574015)(2616005)(6512007)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QitJVWFodnhyVEVnVHM5VUErc3UvdnpzRWpWbTFOQmNBZE1zU0c4VytTRXhY?=
 =?utf-8?B?cXdaeXVaRWZZNklnNkdjdjJSUjRsQlYyM0xDTjNFNHB0Y2hnSE5xU2docGtJ?=
 =?utf-8?B?S0d3ZTh2UG54Znk2S1RJQW9DMXpsWDZRcytwN3JMZzdXdHpQOFVFNkhKRlVX?=
 =?utf-8?B?anNMelBVQ1RtZGVuUmxyMHRKWnVnYlJrbHNuMUhFamhBelhJRkJxaDN6Nk4r?=
 =?utf-8?B?OGp3QU0wVlIxWlZyL1o5UFQxNDdVNEpBK1NPQkplOEZ4RFFldVRkejJWOTFn?=
 =?utf-8?B?UURLMVdzK3JJTGlQZzZiaHFVaHpsOXdrNE56MktTakxlUG5maDFEQ3FKZzR0?=
 =?utf-8?B?TVZ2NHprdXZYV3IweExFZzR0dDZuckJtVllIcWFhM3B0QWwxWU10S0lzR0pB?=
 =?utf-8?B?UStTYUFMdENrYzN5b0Y2anNDOTBmbXZFanNLbnM3dXFna1dIbHNoQWZaeGJu?=
 =?utf-8?B?Njg2UnFIZHdpNWZsY21jQmVpSDV6ZG5iRU1jMjFkMlZxRGRJQld0RDY0dzBO?=
 =?utf-8?B?YlpaZ3UxbGVNa29rdVJMbDJVYUxYZWZpSUEzaEp6bzd3VSt1azVnT2JTb3Ux?=
 =?utf-8?B?VXNuMHN0L1BvS1FuUjdHS1lMeVNUM3FscFlYNXZjN09XbmsrdzN2OWtBT0hu?=
 =?utf-8?B?TGN2Tkt6MnRCemMzSU90T3krYytyQzJDbVpDc2FuQmhyZ2VlVFJRQjBQcXBo?=
 =?utf-8?B?d1dTc3FKWWVPMFpxK0JzVUpJQk00T2FxOTNyWHkwYUdOajBPZDFjeFlZejRr?=
 =?utf-8?B?MWQ5ZzNSdktOMkNONGVuR01sRUIzc1JNUFFOKzEvVWl6QmFZSlpYNXJqU3k2?=
 =?utf-8?B?b2hPRHpsTEhPTjhXbUpZajc2M3FPMUNpbk5Kd3cxQndsRmhCeEY3QkNaL0xm?=
 =?utf-8?B?U1JNRzhIYkR4SWZIbUZUb01NTWtMY2JyZEsrNlM1SnlXb2dZYk9SRGVnZitZ?=
 =?utf-8?B?TnczWDJrSDNUK3I2Q3FSUXIwN0dweHJ4dTA1aStVOWNiWDV2NWdIUGtzTWFV?=
 =?utf-8?B?UnJGMDB1S2NrNWxYRW1SZ1hNbXhFTVY3UkVoQU1xM0Y2RGlRYnlnRE9GbXFq?=
 =?utf-8?B?c2NhcW1lVm41eXFBVXlRT25Jc2krenA0Qi9TVkhDOXJadUJGRVlPZmIrbkVJ?=
 =?utf-8?B?c3pXaXFyc3QranE4TUZDcElEdS9abHZZQW43U0tmcnlJd1R6Z2twUDB3NStR?=
 =?utf-8?B?NEJaNDU5cTJ1bU5MYmVKS20yTGVYaklNZC9GRnBUd1hQcm9XdkJRR3o1MGFk?=
 =?utf-8?B?Z21zdzg2L2NOY3JYQ0ZVcXg0NS9mMTNWWmJ4YTVzVE1SVnY3ZjM5QndYRERu?=
 =?utf-8?B?bE9lSkMrV2FIQnd4NEdRNEN3TGVLdU15aVAxQVRwekJ6M25oZmpNY2VVQlBV?=
 =?utf-8?B?ZUtZQ3B1NDdGazRIVFI3eEZnZW0yNFRMTHhyb2d5TTZGQlNXbllzZlJ0bmFx?=
 =?utf-8?B?bERkaDNGRldTWWkxUXY4Zi9ScktsZE1NY1RwdGptRU9zNDRRalRYY2RWSVdW?=
 =?utf-8?B?TjB2cmczZnB3WVpzWlRpcktVTVBKYWZYdDB1eDZiTEhtcnJNOW1BNWcrVzBu?=
 =?utf-8?B?azkzdnVUcExOd0EzemJaRjZwUzgxVkVnUzZwcnpoSVUvNWpPenJ4K3E1OWd3?=
 =?utf-8?B?TWtMNGsyN1VCRGQ4dUZ2cXhrenh4Qk1yQjdEZFp3U0N0clJaNk11U1RscitW?=
 =?utf-8?B?MFc3N3B1a0FXMXJzdnI3L280UU1NREE3Sk5GeUkwOXFUYWl1TURPOStlQmZu?=
 =?utf-8?B?SDhDR3c3N0FzTWtSdkhYSUxyVmo1Uk1vUXRwR1VMZEp2cE1iMUxSRUNzN1dG?=
 =?utf-8?B?M2lJMS9odjUwbUliMnBpUnMzaDFSRzd4RXNhd01hdVhhTFRKVzFqZzNxLzVR?=
 =?utf-8?B?MjZzbjJTcmhES1p1dWV6ek8zYm5TOVlaTGlRdSs5U0xMQlQybWNKYTl0dlcz?=
 =?utf-8?B?bG0rdXlnamM3UEFBS25LbGJyM2d6cG5EaXZMdW5kWVFaN3FoczAyY2d0dG1p?=
 =?utf-8?B?S2Mzb21hREdWTXZOV0tKUkIvd1JlZG0vQlNxUHpkMFVDQlZmTGw2cEtpa1Rk?=
 =?utf-8?B?cDR3RE1LV1Fjc1hDdHZPZTVaWnE3Y1FqOGJPSFpHMHdLa0tNY2dtTlJRTHps?=
 =?utf-8?B?Q2ViSWtjcXRlRFJUSlpIeTZjRXR4cFlvcVV6WWZ3S3kyNVNia0VkeFh1QjQx?=
 =?utf-8?Q?+q0X1NCwY9F7xJQvnm9ob74uSjJfdZphK3Sy/3p4i8L7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7c82e3-68ba-4b44-e526-08da85f86966
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 17:45:19.5580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPrGMwPHue4l/e7DGFyu0HCfpuG9Q1fJZsvvjg1IoIJ2DIdvG62xn+wC2RVbMS9P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3426
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

QW0gMjQuMDguMjIgdW0gMTc6NDkgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gT24gOC8yNC8y
MiAxODoyNCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMjQuMDguMjIgdW0gMTI6MjIg
c2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4+PiBNb3ZlIGRtYS1idWYgYXR0YWNobWVudCBBUEkg
ZnVuY3Rpb25zIHRvIHRoZSBkeW5hbWljIGxvY2tpbmcKPj4+IHNwZWNpZmljYXRpb24uCj4+PiBU
aGUgc3RyaWN0IGxvY2tpbmcgY29udmVudGlvbiBwcmV2ZW50cyBkZWFkbG9jayBzaXR1YXRpb25z
IGZvciBkbWEtYnVmCj4+PiBpbXBvcnRlcnMgYW5kIGV4cG9ydGVycy4KPj4+Cj4+PiBQcmV2aW91
c2x5LCB0aGUgInVubG9ja2VkIiB2ZXJzaW9ucyBvZiB0aGUgYXR0YWNobWVudCBBUEkgZnVuY3Rp
b25zCj4+PiB3ZXJlbid0IHRha2luZyB0aGUgcmVzZXJ2YXRpb24gbG9jayBhbmQgdGhpcyBwYXRj
aCBtYWtlcyB0aGVtIHRvIHRha2UKPj4+IHRoZSBsb2NrLgo+Pj4KPj4+IEludGVsIGFuZCBBTUQg
R1BVIGRyaXZlcnMgYWxyZWFkeSB3ZXJlIG1hcHBpbmcgdGhlIGF0dGFjaGVkIGRtYS1idWZzCj4+
PiB1bmRlcgo+Pj4gdGhlIGhlbGQgbG9jayBkdXJpbmcgYXR0YWNobWVudCwgaGVuY2UgdGhlc2Ug
ZHJpdmVycyBhcmUgdXBkYXRlZCB0byB1c2UKPj4+IHRoZSBsb2NrZWQgZnVuY3Rpb25zLgo+Pj4K
Pj4+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxh
Ym9yYS5jb20+Cj4+PiAtLS0KPj4+ICDCoCBkcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDExNSArKysrKysrKysrKysrKy0tLS0tLS0K
Pj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmPCoMKgwqAgfMKg
wqAgNCArLQo+Pj4gIMKgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9kbWFidWYu
YyB8wqDCoCA4ICstCj4+PiAgwqAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX29i
amVjdC5jIHzCoCAxMiArKysKPj4+ICDCoCBpbmNsdWRlL2xpbnV4L2RtYS1idWYuaMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyMCArKy0tCj4+PiAgwqAgNSBmaWxl
cyBjaGFuZ2VkLCAxMTAgaW5zZXJ0aW9ucygrKSwgNDkgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgYi9kcml2ZXJzL2RtYS1idWYvZG1h
LWJ1Zi5jCj4+PiBpbmRleCA0NTU2YTEyYmQ3NDEuLmYyYTVhMTIyZGE0YSAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMKPj4+ICsrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9k
bWEtYnVmLmMKPj4+IEBAIC01NTksNyArNTU5LDcgQEAgc3RhdGljIHN0cnVjdCBmaWxlICpkbWFf
YnVmX2dldGZpbGUoc3RydWN0IGRtYV9idWYKPj4+ICpkbWFidWYsIGludCBmbGFncykKPj4+ICDC
oMKgICogMi4gVXNlcnNwYWNlIHBhc3NlcyB0aGlzIGZpbGUtZGVzY3JpcHRvcnMgdG8gYWxsIGRy
aXZlcnMgaXQgd2FudHMKPj4+IHRoaXMgYnVmZmVyCj4+PiAgwqDCoCAqwqDCoMKgIHRvIHNoYXJl
IHdpdGg6IEZpcnN0IHRoZSBmaWxlIGRlc2NyaXB0b3IgaXMgY29udmVydGVkIHRvIGEKPj4+ICZk
bWFfYnVmIHVzaW5nCj4+PiAgwqDCoCAqwqDCoMKgIGRtYV9idWZfZ2V0KCkuIFRoZW4gdGhlIGJ1
ZmZlciBpcyBhdHRhY2hlZCB0byB0aGUgZGV2aWNlIHVzaW5nCj4+PiAtICrCoMKgwqAgZG1hX2J1
Zl9hdHRhY2goKS4KPj4+ICsgKsKgwqDCoCBkbWFfYnVmX2F0dGFjaF91bmxvY2tlZCgpLgo+PiBO
b3cgSSBnZXQgd2h5IHRoaXMgaXMgY29uZnVzaW5nIG1lIHNvIG11Y2guCj4+Cj4+IFRoZSBfdW5s
b2NrZWQgcG9zdGZpeCBpbXBsaWVzIHRoYXQgdGhlcmUgaXMgYW5vdGhlciBmdW5jdGlvbiB3aGlj
aAo+PiBzaG91bGQgYmUgY2FsbGVkIHdpdGggdGhlIGxvY2tzIGFscmVhZHkgaGVsZCwgYnV0IHRo
aXMgaXMgbm90IHRoZSBjYXNlCj4+IGZvciBhdHRhY2gvZGV0YWNoIChiZWNhdXNlIHRoZXkgYWx3
YXlzIG5lZWQgdG8gZ3JhYiB0aGUgbG9jayB0aGVtc2VsdmVzKS4KPiBUaGF0J3MgY29ycmVjdC4g
VGhlIGF0dGFjaC9kZXRhY2ggb3BzIG9mIGV4cG9ydGVyIGNhbiB0YWtlIHRoZSBsb2NrCj4gKGxp
a2UgaTkxNSBleHBvcnRlciBkb2VzIGl0KSwgaGVuY2UgaW1wb3J0ZXIgbXVzdCBub3QgZ3JhYiB0
aGUgbG9jawo+IGFyb3VuZCBkbWFfYnVmX2F0dGFjaCgpIGludm9jYXRpb24uCj4KPj4gU28gSSBz
dWdnZXN0IHRvIGRyb3AgdGhlIF91bmxvY2tlZCBwb3N0Zml4IGZvciB0aGUgYXR0YWNoL2RldGFj
aAo+PiBmdW5jdGlvbnMuIEFub3RoZXIgc3RlcCB3b3VsZCB0aGVuIGJlIHRvIHVuaWZ5IGF0dGFj
aC9kZXRhY2ggd2l0aAo+PiBkeW5hbWljX2F0dGFjaC9keW5hbWljX2RldGFjaCB3aGVuIGJvdGgg
aGF2ZSB0aGUgc2FtZSBsb2NraW5nIGNvbnZlbnRpb24KPj4gYW55d2F5Lgo+IEl0J3Mgbm90IGEg
cHJvYmxlbSB0byBjaGFuZ2UgdGhlIG5hbWUsIGJ1dCBpdCdzIHVuY2xlYXIgdG8gbWUgd2h5IHdl
Cj4gc2hvdWxkIGRvIGl0LiBUaGUgX3VubG9ja2VkIHBvc3RmaXggdGVsbHMgaW1wb3J0ZXIgdGhh
dCByZXNlcnZhdGlvbiBtdXN0Cj4gYmUgdW5sb2NrZWQgYW5kIGl0IG11c3QgYmUgdW5sb2NrZWQg
aW4gY2FzZSBvZiBkbWFfYnVmX2F0dGFjaCgpLgo+Cj4gRHJvcHBpbmcgdGhlIHBvc3RmaXggd2ls
bCBtYWtlIGRtYV9idWZfYXR0YWNoKCkgaW5jb25zaXN0ZW50IHdpdGggdGhlCj4gcmVzdCBvZiB0
aGUgX3VubG9ja2VkIGZ1bmN0aW9ucyg/KS4gQXJlIHlvdSBzdXJlIHdlIG5lZWQgdG8gcmVuYW1l
IGl0PwoKVGhlIGlkZWEgb2YgdGhlIHBvc3RmaXggd2FzIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4g
dHdvIGRpZmZlcmVudCAKdmVyc2lvbnMgb2YgdGhlIHNhbWUgZnVuY3Rpb24sIGUuZy4gZG1hX2J1
Zl92bWFwX3VubG9ja2VkKCkgdnMgbm9ybWFsIApkbWFfYnVmX3ZtYXAoKS4KCldoZW4gd2UgZG9u
J3QgaGF2ZSB0aG9zZSB0d28gdHlwZXMgb2YgdGhlIHNhbWUgZnVuY3Rpb24gSSBkb24ndCB0aGlu
ayBpdCAKbWFrZXMgdG8gbXVjaCBzZW5zZSB0byBrZWVwIHRoYXQuIFdlIHNob3VsZCBqdXN0IHBy
b3Blcmx5IGRvY3VtZW50IHdoaWNoIApmdW5jdGlvbnMgZXhwZWN0IHdoYXQgYW5kIHRoYXQncyB3
aGF0IHlvdXIgZG9jdW1lbnRhdGlvbiBwYXRjaCBkb2VzLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoK
Pgo+PiBTb3JyeSB0aGF0IHRoaXMgaXMgZ29pbmcgc28gbXVjaCBiYWNrIGFuZCBmb3J0aCwgaXQn
cyByZWFsbHkgY29tcGxpY2F0ZWQKPj4gdG8ga2VlcCBhbGwgdGhlIHN0dWZmIGluIG15IGhlYWQg
YXQgdGhlIG1vbWVudCA6KQo+IE5vdCBhIHByb2JsZW0gYXQgYWxsLCBJIGV4cGVjdGVkIHRoYXQg
aXQgd2lsbCB0YWtlIHNvbWUgdGltZSBmb3IgdGhpcwo+IHBhdGNoc2V0IHRvIHNldHRsZSBkb3du
Lgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
