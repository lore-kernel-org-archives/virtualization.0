Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBDCECAAD8
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 06:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F09A960B22;
	Thu,  1 Sep 2022 06:45:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F09A960B22
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4nypQjFJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PfJ_UvdR-eqg; Thu,  1 Sep 2022 06:45:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F76560B31;
	Thu,  1 Sep 2022 06:45:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F76560B31
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24ED5C0033;
	Thu,  1 Sep 2022 06:45:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EDBBC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45337400C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45337400C8
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4nypQjFJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ax50sI2sXvZ9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:45:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D207400BB
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D207400BB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 06:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahTYEC9QIsWQA3pCRmrDzL7V1OOzCuaXptvg2vcr1uBoWIAFAAgtX+QbbkVI2NFPfZUYBJWK+KJO9zV3UVZaaD4Ro/Eqc7g9+OdsaYBYlgpyAgwkyxhWUSxmo8YskqSNV64ZnPSAeGNWPq1KYlYBEEJocnN6w9l8djP+rWX8kscNuLbeBplro3YlWUYGlumtbpxPD1swatRLkJDKaJ3+VzVxFg/k8U611W4xpKzGTfdGbPI6taigcai9fIFnAFfj5hxUJV23p4Ub+cPqzcfjEfJrpIlDsrqBD+c+iVPfsD2T9o8H1tFoZSaDidRDhfzVwagYiuHaGiVs95DEuZaACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO9nrEklpYX7tnEq4edqxYFL4EsrLF2kpEA6u4/TGdM=;
 b=ZZIonSv9iByR9iS9HB5OlHzmBf6GTTCivAvlxcjDXBq4pgJ+4NWapX9gySWRjBR2MNQtiWxBRpzVEihEz9/cWmqGyR6n11OOuNhVqyo2+jdi2W4cfqBGNaJwiAvCOdMcj6c2YYws2Y1GvhDfw/ets5zvwdzbEdvR7+prG594Sg3eQRql1RI8+YtQxqb1o1x56+dqRlt+47I4qmAC64iREOxmCWxq7ldb1mSKCd1ay1/Yb6N/7T5Ckf0XGe+JRJab7hxK/YHYM0OkMiGzccXQ+d+HBuqNAEDizw2LhqKxML8JogQgU4y61SkU33Bct1HtN8QcB4mEoXQ65VfmbmN4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO9nrEklpYX7tnEq4edqxYFL4EsrLF2kpEA6u4/TGdM=;
 b=4nypQjFJBVh+sM+sOEWfC427n+XX8zUjZTaoB5cGzpcUUP1dRjktgLRW+4aowALo+SWkiNDqxwWw6Cc3ctr0Lhf0evKSvGKfTV2SB/ZOi/ydYMJ9u4aFrFopI4iQ+zsxFQ02s3DhCn8CzVo26sYpNKkY4hi1EO9fnaNxvMLompw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 06:45:15 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 06:45:15 +0000
Message-ID: <2463ccb0-6620-8760-fc06-532847835207@amd.com>
Date: Thu, 1 Sep 2022 08:45:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 06/21] drm/i915: Prepare to dynamic dma-buf locking
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
 <20220831153757.97381-7-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-7-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AM6P194CA0008.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a74a4ab-696e-4f28-3427-08da8be58665
X-MS-TrafficTypeDiagnostic: BN9PR12MB5228:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2T40/60DPhA+Jlw3HehoxUCX9U9KfdkJaTxhATgiaohs/vuipqQ4DlcD4ySaEFw7ZvmwOiOXxs1g76NONWvWt88M8trdKGRuRW1dzMTOE70HLSH3CutJ4N+UMdOMr1SWxRyLcVKzohJt9TP8TQdJFowdBLXtkRxe4IHx/EuCtQ6sX8C1D0dkvxS5yTf68hnBp1uC6FUIIZ9+SRsXeQDO1tKFF5gWlIms12mKNdGgRsZ/szyH3D6aWfZEEQtEEdxwJFfMKnuFfowHImYKwIDV9wdmT5uP2n9xwusvM7ucDpwoK83C5c1vcd8E7+vcRhlUCAJIZCsly5JBUybFFvLIbBjmu3qCMX6E2/vSpKRKSLnMmQIF3mQP2IA/TsBA5fZ//5v0ZHCNvZLiRSMhdhrdb3zL3W4AWBaSPOofEYv8vbcBh91seC14bLszZKadyWJSlh9x3Gw601jZwZ5fnJfrz8kCWke/Pst6dj3n677iOQOpkvM4IHFB+HkpxlTloWSxAQsXavg6eq28MUARpjB72idYgvmtijtJVrGbPtJlSqkid4zGJh45w23+hkZfIdoSo8G3qyUARh+Rw1OM19dGnClo718I2iOpmFEev8Skxk8UTFok6pAaZ70uTL7Fj7Bff6mZLnOpWLxOBKAhZdZRm3Y6GTIn2ij0JfJy6AFVOQ1roD+VnP/foaGWCHHdtME6C3Vsi0rxjDSDTSPcE1m7a17NWXQCgePLkwCv3hUe9Sw4uOza5DtqFKsP/0b0VZynOf+0j2kCMQAsWKG3KxOe7JD/IE5ZiioM6XFB0OGqC44v2um5rj77JktTbwxQYUZk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8936002)(7406005)(6486002)(38100700002)(478600001)(7416002)(110136005)(31686004)(6506007)(316002)(41300700001)(6666004)(5660300002)(6512007)(26005)(86362001)(2616005)(83380400001)(2906002)(66946007)(66476007)(36756003)(31696002)(186003)(8676002)(66556008)(4326008)(66574015)(921005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdVWTBFbFJJUDZMMEdjZnlmcElNWXJrZkhKSThKWmlHUnB0cTc1R0VMc2xl?=
 =?utf-8?B?dXBGQUZ5YXJKeno1YXAwTFRoQldpVExYc2R2Y0RDWUI2cU4vMUhsdUZIOUI1?=
 =?utf-8?B?RFB1b3lZZE1EWVlzcDhJY0FWNXRIaXpmbk9xSDMrbm5VbEx4ajZaOGlHb1pX?=
 =?utf-8?B?bWVFOHg5SitlMkJKTmxQdXR0QVV1NW5GMW5XS2QzVzR5b2RqZ1BYUmw3WXN3?=
 =?utf-8?B?VnhHcjN3OUxGUTRpSTZvcW9oSVAzRDFUaDU5ZUZLY0NMNFpvZFE1VmJCSzBq?=
 =?utf-8?B?cHVYR2tKYVZNeFoyQzlYYm8veTNXaTFiUG8vVisxTGhtTzM1ZGd1NGE1ZDJY?=
 =?utf-8?B?eHdJV2NRbE1jUjNhT3NyNUdTdnM0dHVaK2trQldOdWlFYU9kUlBGa29kSzVL?=
 =?utf-8?B?amhtNXRwWjM1aGxJb0UrZktyaFBRMGhmbnl6NHJ3Nm0yYVVCM3pORCtIZVpV?=
 =?utf-8?B?MEJobVU2TWg3WEE4RGZxRzJlaFh2VHVNT2pWN0FWNDBOWGVEQ3FuVGQrVS82?=
 =?utf-8?B?N1hGNGYwdXRVeVY0MkRBUmJZamh3TGs4NUgwcmJqWEdTTFFTMmpBcm40Z28v?=
 =?utf-8?B?SnBWVG9ybkoyakIyaUFFbWp5ZC9mOXZaRDIvR1VxVVZkRXlwc004RndMWXda?=
 =?utf-8?B?bUNTb2o2SmVjNzNmODNiMDdjRVN2dTQvRnhRd1QyOGVkY0FCaytSTHdGSG5a?=
 =?utf-8?B?eEJoR3MzcXVYb2NIdU80Nmd2aXg4ZFkvVmNGcVVOOElTNDlvbkpaYkZIcmR0?=
 =?utf-8?B?aEpqVkNKR092ZGpPcmo2ckxuaFMrQzRqYlZ1bDV4Q0NqRGpnNmlYMVZRS2g3?=
 =?utf-8?B?ekt0MHZueTA0RGpSak1TYU1Oa0dYZFZBQ0h4WThwYjRlQ3BuMlRSVjBhSGI3?=
 =?utf-8?B?QjNhb09jRE94VUFHczUxYUtQRC9pRVkwNytueWhhUlJLdDZiOGNwU1hmQ3Fx?=
 =?utf-8?B?clVCWi9wNjJHYm5KV0VtdFBtaXJaVTR2dWdoS2o5ZWRHZUdBMzFUV0htQ280?=
 =?utf-8?B?N3VlSzJHQi8zUFo2VTdpM1pPdHNVeEUyRmtLRXByT2k0akVuTXUzTWwrN0JJ?=
 =?utf-8?B?VVNCQWdIVW5wcVhaMTVNbVFqVWZpZytZcmt4VXJmbWhGSWs2eGdVYWVMOEc4?=
 =?utf-8?B?UDVzeVZxdXVOaldCZU9xSDZoRW9IcGZiVmRrcDdoeUQ0andqeTY3N3E2WE1t?=
 =?utf-8?B?Z1J0WWx4anFrS0xUWG53UURRQVhkZEFXUzIxYzA0T0FFTXY5UlNKYXhQVlFK?=
 =?utf-8?B?akJMWEpEbGUzeXhlODR6RTZjb2N5UWxhSWNVS1NmK3BBTjdzd2pJWm8ya1VG?=
 =?utf-8?B?bW5vWEJuQ1Y3a2FUTitFLzNjdW1mS1RsQkQzOGdmRHR4WU1VeWt3RUNiVzcv?=
 =?utf-8?B?Ylc4bVZzNTdZVDY1aDNYNWJBb1czMWxwS2JhSGlENXpUS1dMSGhqRVloZlpE?=
 =?utf-8?B?ZjhFem1nd3MrY1ZnNUx4SVM5eFk4SE93UnpRRmRzU2VlbVNSd3JKbGNLZE0x?=
 =?utf-8?B?T3hzZkdVYXRwVWkwTDlWSWdidHYwdXlMSnVqNnl3QWcybWcyMjVEYVRkdVNQ?=
 =?utf-8?B?NDhSQ3A2bm5TRm1YTEMxYTRkZzJsLzEvSTJua1lkMnJnRVN5MUpVejRpaUtR?=
 =?utf-8?B?dU5UVFU1L3VyMW5TdjFTMk84NEE4aVo5V0U5UXUyRlR4NWVWdkFCZTJyc3NZ?=
 =?utf-8?B?Ym5nbmlrQ1grY2dIVmdXdHd4RGxVMGVodUc5T2JHUFdKUHRVaTNpeDZsZGJC?=
 =?utf-8?B?eEM0bkNDRUtjalZVdTROSklOZkUxRVFQTDdpeWZ1a1pNbHBhTmtBaGF1OG1Q?=
 =?utf-8?B?K09RaGdUL1hTSTB4SU5MMnRIeGw5VWM1WHRUSzR3NFdMVkdpNVhwNTVqSXMz?=
 =?utf-8?B?TUpybUY1aTZKWFRHU0p6UWZZak9MRzBXSDRZZm5KM1FaRlVkZmFYVUhlL3RB?=
 =?utf-8?B?RUExUnFDcUdib2JaQ1ZmYjV1NncycEFDWVlKRVRhL0Q0dDdDdW1XdktuL0Fa?=
 =?utf-8?B?SnZFSmlqWjZTZGkya2IrWDVGM0gzcWJjck9RMy8ybUdTbjNQV3FIRWNvZC9n?=
 =?utf-8?B?YnZkUGRKdkVFaktmR2hLZEZzVDg0dTdPanlKbGk4YURLaHllMjNJZ3lESlFz?=
 =?utf-8?Q?uR5oex08w5wYUxOtfuFIiXDAF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a74a4ab-696e-4f28-3427-08da8be58665
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:45:14.9272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/9qNzgInkJX/XdKXehavtVkTevzayvvOgGwZJJ8NCfq3V7yS6nfj34Jq2ZmNdLj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
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

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gUHJlcGFyZSBp
OTE1IGRyaXZlciB0byB0aGUgY29tbW9uIGR5bmFtaWMgZG1hLWJ1ZiBsb2NraW5nIGNvbnZlbnRp
b24KPiBieSBzdGFydGluZyB0byB1c2UgdGhlIHVubG9ja2VkIHZlcnNpb25zIG9mIGRtYS1idWYg
QVBJIGZ1bmN0aW9ucwo+IGFuZCBoYW5kbGluZyBjYXNlcyB3aGVyZSBpbXBvcnRlciBub3cgaG9s
ZHMgdGhlIHJlc2VydmF0aW9uIGxvY2suCj4KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVu
a28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4sIGJ1dCBpdCdzIHByb2JhYmx5IApiZXN0
IGlmIHNvbWVib2R5IGZyb20gdGhlIEludGVsIGd1eXMgdGFrZSBhIGxvb2sgYXMgd2VsbC4KCj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fZG1hYnVmLmMgICAgICAg
fCAgMiArLQo+ICAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX29iamVjdC5jICAg
ICAgIHwgMTIgKysrKysrKysrKysrCj4gICAuLi4vZ3B1L2RybS9pOTE1L2dlbS9zZWxmdGVzdHMv
aTkxNV9nZW1fZG1hYnVmLmMgfCAxNiArKysrKysrKy0tLS0tLS0tCj4gICAzIGZpbGVzIGNoYW5n
ZWQsIDIxIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2RtYWJ1Zi5jIGIvZHJpdmVycy9ncHUvZHJt
L2k5MTUvZ2VtL2k5MTVfZ2VtX2RtYWJ1Zi5jCj4gaW5kZXggZjUwNjJkMGM2MzMzLi4wN2VlZTFj
MDlhYWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2Rt
YWJ1Zi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2RtYWJ1Zi5j
Cj4gQEAgLTcyLDcgKzcyLDcgQEAgc3RhdGljIGludCBpOTE1X2dlbV9kbWFidWZfdm1hcChzdHJ1
Y3QgZG1hX2J1ZiAqZG1hX2J1ZiwKPiAgIAlzdHJ1Y3QgZHJtX2k5MTVfZ2VtX29iamVjdCAqb2Jq
ID0gZG1hX2J1Zl90b19vYmooZG1hX2J1Zik7Cj4gICAJdm9pZCAqdmFkZHI7Cj4gICAKPiAtCXZh
ZGRyID0gaTkxNV9nZW1fb2JqZWN0X3Bpbl9tYXBfdW5sb2NrZWQob2JqLCBJOTE1X01BUF9XQik7
Cj4gKwl2YWRkciA9IGk5MTVfZ2VtX29iamVjdF9waW5fbWFwKG9iaiwgSTkxNV9NQVBfV0IpOwo+
ICAgCWlmIChJU19FUlIodmFkZHIpKQo+ICAgCQlyZXR1cm4gUFRSX0VSUih2YWRkcik7Cj4gICAK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX29iamVjdC5j
IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX29iamVjdC5jCj4gaW5kZXggMzg5
ZTlmMTU3Y2E1Li43ZTJhOWIwMjUyNmMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5
MTUvZ2VtL2k5MTVfZ2VtX29iamVjdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2Vt
L2k5MTVfZ2VtX29iamVjdC5jCj4gQEAgLTMzMSw3ICszMzEsMTkgQEAgc3RhdGljIHZvaWQgX19p
OTE1X2dlbV9mcmVlX29iamVjdHMoc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmk5MTUsCj4gICAJ
CQljb250aW51ZTsKPiAgIAkJfQo+ICAgCj4gKwkJLyoKPiArCQkgKiBkbWFfYnVmX3VubWFwX2F0
dGFjaG1lbnQoKSByZXF1aXJlcyByZXNlcnZhdGlvbiB0byBiZQo+ICsJCSAqIGxvY2tlZC4gVGhl
IGltcG9ydGVkIEdFTSBzaG91bGRuJ3Qgc2hhcmUgcmVzZXJ2YXRpb24gbG9jaywKPiArCQkgKiBz
byBpdCdzIHNhZmUgdG8gdGFrZSB0aGUgbG9jay4KPiArCQkgKi8KPiArCQlpZiAob2JqLT5iYXNl
LmltcG9ydF9hdHRhY2gpCj4gKwkJCWk5MTVfZ2VtX29iamVjdF9sb2NrKG9iaiwgTlVMTCk7Cj4g
Kwo+ICAgCQlfX2k5MTVfZ2VtX29iamVjdF9wYWdlc19maW5pKG9iaik7Cj4gKwo+ICsJCWlmIChv
YmotPmJhc2UuaW1wb3J0X2F0dGFjaCkKPiArCQkJaTkxNV9nZW1fb2JqZWN0X3VubG9jayhvYmop
Owo+ICsKPiAgIAkJX19pOTE1X2dlbV9mcmVlX29iamVjdChvYmopOwo+ICAgCj4gICAJCS8qIEJ1
dCBrZWVwIHRoZSBwb2ludGVyIGFsaXZlIGZvciBSQ1UtcHJvdGVjdGVkIGxvb2t1cHMgKi8KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL3NlbGZ0ZXN0cy9pOTE1X2dlbV9k
bWFidWYuYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9zZWxmdGVzdHMvaTkxNV9nZW1fZG1h
YnVmLmMKPiBpbmRleCA2MmM2MWFmNzdhNDIuLjllM2VkNjM0YWEwZSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vc2VsZnRlc3RzL2k5MTVfZ2VtX2RtYWJ1Zi5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL3NlbGZ0ZXN0cy9pOTE1X2dlbV9kbWFidWYuYwo+
IEBAIC0yMTMsNyArMjEzLDcgQEAgc3RhdGljIGludCBpZ3RfZG1hYnVmX2ltcG9ydF9zYW1lX2Ry
aXZlcihzdHJ1Y3QgZHJtX2k5MTVfcHJpdmF0ZSAqaTkxNSwKPiAgIAkJZ290byBvdXRfaW1wb3J0
Owo+ICAgCX0KPiAgIAo+IC0Jc3QgPSBkbWFfYnVmX21hcF9hdHRhY2htZW50KGltcG9ydF9hdHRh
Y2gsIERNQV9CSURJUkVDVElPTkFMKTsKPiArCXN0ID0gZG1hX2J1Zl9tYXBfYXR0YWNobWVudF91
bmxvY2tlZChpbXBvcnRfYXR0YWNoLCBETUFfQklESVJFQ1RJT05BTCk7Cj4gICAJaWYgKElTX0VS
UihzdCkpIHsKPiAgIAkJZXJyID0gUFRSX0VSUihzdCk7Cj4gICAJCWdvdG8gb3V0X2RldGFjaDsK
PiBAQCAtMjI2LDcgKzIyNiw3IEBAIHN0YXRpYyBpbnQgaWd0X2RtYWJ1Zl9pbXBvcnRfc2FtZV9k
cml2ZXIoc3RydWN0IGRybV9pOTE1X3ByaXZhdGUgKmk5MTUsCj4gICAJCXRpbWVvdXQgPSAtRVRJ
TUU7Cj4gICAJfQo+ICAgCWVyciA9IHRpbWVvdXQgPiAwID8gMCA6IHRpbWVvdXQ7Cj4gLQlkbWFf
YnVmX3VubWFwX2F0dGFjaG1lbnQoaW1wb3J0X2F0dGFjaCwgc3QsIERNQV9CSURJUkVDVElPTkFM
KTsKPiArCWRtYV9idWZfdW5tYXBfYXR0YWNobWVudF91bmxvY2tlZChpbXBvcnRfYXR0YWNoLCBz
dCwgRE1BX0JJRElSRUNUSU9OQUwpOwo+ICAgb3V0X2RldGFjaDoKPiAgIAlkbWFfYnVmX2RldGFj
aChkbWFidWYsIGltcG9ydF9hdHRhY2gpOwo+ICAgb3V0X2ltcG9ydDoKPiBAQCAtMjk2LDcgKzI5
Niw3IEBAIHN0YXRpYyBpbnQgaWd0X2RtYWJ1Zl9pbXBvcnQodm9pZCAqYXJnKQo+ICAgCQlnb3Rv
IG91dF9vYmo7Cj4gICAJfQo+ICAgCj4gLQllcnIgPSBkbWFfYnVmX3ZtYXAoZG1hYnVmLCAmbWFw
KTsKPiArCWVyciA9IGRtYV9idWZfdm1hcF91bmxvY2tlZChkbWFidWYsICZtYXApOwo+ICAgCWRt
YV9tYXAgPSBlcnIgPyBOVUxMIDogbWFwLnZhZGRyOwo+ICAgCWlmICghZG1hX21hcCkgewo+ICAg
CQlwcl9lcnIoImRtYV9idWZfdm1hcCBmYWlsZWRcbiIpOwo+IEBAIC0zMzcsNyArMzM3LDcgQEAg
c3RhdGljIGludCBpZ3RfZG1hYnVmX2ltcG9ydCh2b2lkICphcmcpCj4gICAKPiAgIAllcnIgPSAw
Owo+ICAgb3V0X2RtYV9tYXA6Cj4gLQlkbWFfYnVmX3Z1bm1hcChkbWFidWYsICZtYXApOwo+ICsJ
ZG1hX2J1Zl92dW5tYXBfdW5sb2NrZWQoZG1hYnVmLCAmbWFwKTsKPiAgIG91dF9vYmo6Cj4gICAJ
aTkxNV9nZW1fb2JqZWN0X3B1dChvYmopOwo+ICAgb3V0X2RtYWJ1ZjoKPiBAQCAtMzU4LDcgKzM1
OCw3IEBAIHN0YXRpYyBpbnQgaWd0X2RtYWJ1Zl9pbXBvcnRfb3duZXJzaGlwKHZvaWQgKmFyZykK
PiAgIAlpZiAoSVNfRVJSKGRtYWJ1ZikpCj4gICAJCXJldHVybiBQVFJfRVJSKGRtYWJ1Zik7Cj4g
ICAKPiAtCWVyciA9IGRtYV9idWZfdm1hcChkbWFidWYsICZtYXApOwo+ICsJZXJyID0gZG1hX2J1
Zl92bWFwX3VubG9ja2VkKGRtYWJ1ZiwgJm1hcCk7Cj4gICAJcHRyID0gZXJyID8gTlVMTCA6IG1h
cC52YWRkcjsKPiAgIAlpZiAoIXB0cikgewo+ICAgCQlwcl9lcnIoImRtYV9idWZfdm1hcCBmYWls
ZWRcbiIpOwo+IEBAIC0zNjcsNyArMzY3LDcgQEAgc3RhdGljIGludCBpZ3RfZG1hYnVmX2ltcG9y
dF9vd25lcnNoaXAodm9pZCAqYXJnKQo+ICAgCX0KPiAgIAo+ICAgCW1lbXNldChwdHIsIDB4YzUs
IFBBR0VfU0laRSk7Cj4gLQlkbWFfYnVmX3Z1bm1hcChkbWFidWYsICZtYXApOwo+ICsJZG1hX2J1
Zl92dW5tYXBfdW5sb2NrZWQoZG1hYnVmLCAmbWFwKTsKPiAgIAo+ICAgCW9iaiA9IHRvX2ludGVs
X2JvKGk5MTVfZ2VtX3ByaW1lX2ltcG9ydCgmaTkxNS0+ZHJtLCBkbWFidWYpKTsKPiAgIAlpZiAo
SVNfRVJSKG9iaikpIHsKPiBAQCAtNDE4LDcgKzQxOCw3IEBAIHN0YXRpYyBpbnQgaWd0X2RtYWJ1
Zl9leHBvcnRfdm1hcCh2b2lkICphcmcpCj4gICAJfQo+ICAgCWk5MTVfZ2VtX29iamVjdF9wdXQo
b2JqKTsKPiAgIAo+IC0JZXJyID0gZG1hX2J1Zl92bWFwKGRtYWJ1ZiwgJm1hcCk7Cj4gKwllcnIg
PSBkbWFfYnVmX3ZtYXBfdW5sb2NrZWQoZG1hYnVmLCAmbWFwKTsKPiAgIAlwdHIgPSBlcnIgPyBO
VUxMIDogbWFwLnZhZGRyOwo+ICAgCWlmICghcHRyKSB7Cj4gICAJCXByX2VycigiZG1hX2J1Zl92
bWFwIGZhaWxlZFxuIik7Cj4gQEAgLTQzNSw3ICs0MzUsNyBAQCBzdGF0aWMgaW50IGlndF9kbWFi
dWZfZXhwb3J0X3ZtYXAodm9pZCAqYXJnKQo+ICAgCW1lbXNldChwdHIsIDB4YzUsIGRtYWJ1Zi0+
c2l6ZSk7Cj4gICAKPiAgIAllcnIgPSAwOwo+IC0JZG1hX2J1Zl92dW5tYXAoZG1hYnVmLCAmbWFw
KTsKPiArCWRtYV9idWZfdnVubWFwX3VubG9ja2VkKGRtYWJ1ZiwgJm1hcCk7Cj4gICBvdXQ6Cj4g
ICAJZG1hX2J1Zl9wdXQoZG1hYnVmKTsKPiAgIAlyZXR1cm4gZXJyOwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
