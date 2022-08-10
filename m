Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B653C00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 09:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 014E560BF5;
	Wed, 10 Aug 2022 09:04:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 014E560BF5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=j4VgwtCM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjMqwgxBfLce; Wed, 10 Aug 2022 09:04:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 597B561029;
	Wed, 10 Aug 2022 09:04:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 597B561029
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C1F6C0033;
	Wed, 10 Aug 2022 09:04:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06C53C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DEB74012E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:04:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DEB74012E
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=j4VgwtCM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3PTd5UJCpiLj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:04:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB285400C8
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB285400C8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny5E2VM/NqFH0HIXDWovY1vm9Q+0h4thmBnxm7mcOtttabiQsE/uF6AMCHohMVQkR5lU2pTnZb2RvNKq347XimGPZo9BTMgnbalD7/aBe6CV3nLxlEFzN3URX1inCaf6xyLV6GaEmK/t/Tp3bzElkx8rS7vpNbPWp3XuQQ3jmG9Eba780pqOjX840HmmZaaxmJU8wxD5QswAZxKtakJMR7dxBxlF4ljrddWp0wooZbIxTgJh/8RP2vrWbvyCI/3A1W0I0R60aVUNJI7QbY2XpxCrSAPaE57DulbeubqPw/KjA1pgzjtnHmOn0VULlXi3VIREZW7iezgg122Xj9i+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8/iYvYOYkCxkQGDLr5fzE9/DS340HmO+yaXPvED898=;
 b=S335RdcI4Zd8efsXWf3cbUnfpT0OOk+x1hHcTbVRvpAVIJo/4gjos8FHDIAeDQ0Yj5FcTjFS2vcKUqLnTRwp1Nr/sxt+rRnGUdR1Uu9Njvc8NQnNqf3dW9LGzvxZ634PAA23aj5s66w1YKFSFg++eOcmY0wfm9abxKXkrBV5nK2GXUJGTGY1DKaRkFEjaimvyUwuBNC2eZ8nwTiCn5XDT6tcZEA0e4D0SMG2MjkcLr+JjgrHWxaL5ugKk7CgRzQu+kjkQyRmm+uZQeB/N5pHAltKEMRUI61yAV1BHIauVQjNbrrll3t9zd4754cXXfx+gBrjYMpEe9bNMP2i978gGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8/iYvYOYkCxkQGDLr5fzE9/DS340HmO+yaXPvED898=;
 b=j4VgwtCMa0qsBdjuYB9dM9MGV222xs++d5W4bLBjWG6iVgcBqABM73t2T6oGZ51SkvjmWYWJyoroEbdup2wE1I1tten9bNHRn4dpLPqZ+mLCu63FMMZrwU6avIt2M2tAP2q2cLlTqqTu0BMKD24vd8AOpHQHHv/6x5sC75PFUpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Wed, 10 Aug
 2022 09:04:20 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 09:04:20 +0000
Message-ID: <1bb3ff1c-d89f-8b2b-b898-bb60f77462c4@amd.com>
Date: Wed, 10 Aug 2022 11:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/2] drm/gem: Properly annotate WW context on
 drm_gem_lock_reservations() error
Content-Language: en-US
To: Daniel Vetter <daniel@ffwll.ch>
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-2-dmitry.osipenko@collabora.com>
 <a42237c9-6304-4b06-cede-2175c7e7b87d@amd.com>
 <YvKO5r5Sr56e9vBf@phenom.ffwll.local>
 <e760f555-7f2d-dea9-70b2-c0881adc3afc@amd.com>
 <CAKMK7uEd1xX6P4YRgYOfjvqpwVmQ0YZPkHdK=4auwrkBE9CEzQ@mail.gmail.com>
In-Reply-To: <CAKMK7uEd1xX6P4YRgYOfjvqpwVmQ0YZPkHdK=4auwrkBE9CEzQ@mail.gmail.com>
X-ClientProxiedBy: AS9PR06CA0567.eurprd06.prod.outlook.com
 (2603:10a6:20b:485::35) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1516170-210c-432b-76c9-08da7aaf4f92
X-MS-TrafficTypeDiagnostic: DM5PR12MB4679:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37dSMN1f720lnC7S/1s2W/dW9ejxW2uKRgD1WR3+DlTLo1+UKDOz12A8vb+MBK/H0xu1ZvQgjiYCjfMpknU+kbXOwzdgQlTh4ksMtPzy7EZ7FYmDKv074RHwAgPYxYEjB0chezlWlIqe7u9U1148QzTF9kg+KuNg3DQFxwHr7Tg3AzdmZchMaia2shmEVntBTrMrz7uB5qCr10eKLsz2BUneGBvpd2WX5R3UkIz/jvOXYQBlE9HhutOVWCH6FYulC2ltt24Wi5xZ1FIFIFR+Ua+jaj6N1qtUSoMVBb3cl9SoauSarQkGvLPK+iIPMFIVOY7vKUU4pymZHUyBARFTF0WocqLsGRjdKNNodXRbEpUsWnUDORsAsnS8rQzxb26KMk73zRQUYGq43QLWiEIZV343CXb566MkX88hBYxfKg5ltSMib0Snbu5RQkJdzS45yWjjE4kbHZ6AvgiRo+yRtkLKOgRoFsSatCTvf1yPxqgVFGl17KOMrBSWgfo9wIZ0KtMX08rRXA6o3EYBBPWD3w8+rjpmqop7Op2ElXJ2awpMyb96CZub5BGeuNQDfu117wpOpJqVg4DNMHeV9SmpuwqPYrpFkpHTRuOXogJO4Hl6eUxzZlURJYxQ6n5dl9iWwbmegLschWjXcBeRMCMJkR60UbpLKvhG9MQCeNTpB+cdts71d4tLIlO2Bu5qSn+YG66RRWDZIC8Jpwqzbx79Bj2oAe4yXkdLeapAQMNUvKIC6tfxiF6kjjjI3JqF2MN+2NGESRS9SWt2ua1dmS/VoB3mUAyuBs4gFFUGrxl/v+7aivq1q50QnocZkwfy3TSkXQWKB1DwQ/eTBaMdBV76uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(38100700002)(31686004)(6506007)(186003)(6666004)(2616005)(66574015)(41300700001)(6512007)(86362001)(66556008)(31696002)(6486002)(8676002)(316002)(478600001)(5660300002)(66476007)(66946007)(6916009)(54906003)(4326008)(2906002)(83380400001)(8936002)(7416002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJZN01VSWRIS1diTnJ6aDY5Q2t5TjlwRnJDVUVtOUhORnNUbmorc1NQbXJQ?=
 =?utf-8?B?Nk9kU0hsWmY0TDJrTSt0RGRWUC9qU3NjU1VXaGpsSW1hVGR3T0k1VXdWSzFE?=
 =?utf-8?B?a0wyTDcvdWxTS2xXN0czRmxaeW9WZE0zNVZROWRkUDJ2WDNvM1ZHY09vM3Fh?=
 =?utf-8?B?ZGZWK05wTCtQdkdMcEovT2pFL0wvRDNHd2Y2RlpaRFZ4TGxIZFhsSUtOanFW?=
 =?utf-8?B?UTY5VUttaGZnUGlud0hhUlk2QUwwZ0YxRnJUYjJsWVoyMG1aRWtTZXJzYXNy?=
 =?utf-8?B?RUN5VnlLVlExNktHbEVSbVE0ZG9Ibk0zUEwxRk5WWElzTGNSL0xxZmY0bDZY?=
 =?utf-8?B?dzBoQ3BWU3RzVGU2Ryt0eE8vZ3M2blJhSG5QcHpMYlg4T3FnWFpvZC9TQ05Q?=
 =?utf-8?B?V1V4Vm5ydEpSRU0zRkRkbzlod3NRNHJHTFhUMlpTcXV4RWw2SjYrUExWOTUw?=
 =?utf-8?B?ZHljaDlmZFVtM0IzME5yQXdVSjdDVFl5azU4NlFyS1pKWk1GaUNaNVh6dmVn?=
 =?utf-8?B?ZDdXTURQZC95S3RBSG1WVlVoMHFIaDN2SFhXSDQrZnRtM2xoQ290TjE5TktE?=
 =?utf-8?B?TEIwdHRLcGp5VGI2QTdtOXRhSnRLaDZncng4UUw0WnJaVzZydHFidGw3U2lS?=
 =?utf-8?B?R1d2OG5OVWQ2MHdUd3ZJRDVRK2M1V1dvS2FPTC9XSUNITHcxWlNuV2xuRFgr?=
 =?utf-8?B?b0g5MnFGNzBFc1Vsa1JoZnptUkcxSTVwVnNxb2hubjJ1d1Y4NmJJTVdEM0xq?=
 =?utf-8?B?ZEdhcm40enM5ejc3TFJJd2l2aFZXTUFDZDBCT0d4QWovbFFJL3liM3ByQkxV?=
 =?utf-8?B?QnZDcTVleG1xYlBRM0hwcmVoOFZ1QXF3b3g5djlBT29lb0ZuMC96Ylg5RmUz?=
 =?utf-8?B?eW9WWk5GSUpKQmFOUjB0UlBjUXgxeGxJcWdJY1ZUMVp3Z1RGSFcwU1J4MFd3?=
 =?utf-8?B?SERrbCtnMTdLNlIyc1NrdDV3T3Mxdzk0a2hJTDlWMTZ2Yjk4dkg4bDd5eHB3?=
 =?utf-8?B?R0VEaGZBQTlRc0Z2ZVVsQ1FJL2JjVWVTSEhYR3BIU2syZTlucE9ubEpVbVhZ?=
 =?utf-8?B?TlJVWitVSTQzbTNyaStMYzVkM3g3bU9rY1dMRFQ4eWVIT0JzbGRhb2tVeC81?=
 =?utf-8?B?REtvNFMzL3ZrbGZXNWtMSG9OQ2pNVCsvRFVaeGQvYi90MFZJQUh0K0Nyc3ZE?=
 =?utf-8?B?c3Fka2NmclF3RXY5L2YwUDRaOU9vZ3Y0NERFeWRjb2VMSDc2UUpTM1lyYjd6?=
 =?utf-8?B?dlZ1czZFcFRSSVFBY1JJSkdybUsxK2lmUVZvODEyUUk0S2dZOUV5cm4wWkNS?=
 =?utf-8?B?Um5WTEpZT3ZoOVRuMzdSck5NUHRFeFVYaVZrRXdOV1lvM0l4RnpVSDFISFJ2?=
 =?utf-8?B?SHlRRDBTd2pJNjhuUldlRHhaU2hKQXB3SXh1dUEyWi84Y282a3AvWWx1M01a?=
 =?utf-8?B?QnpyTkhINWNRZ1JhM0t4RFdhekxpMXN3Z3A5U05jWmhMWlBrb1owZ2wzVWlI?=
 =?utf-8?B?a3U1OG51TnJDTWRHZzFEalQ1dEhCQ2hNUTZrS1c4RHdaU2tLZEhCM0NPKzNF?=
 =?utf-8?B?RVNpSzJWaXVWM0RubVIydmE2c2tXV2lSUjZSMExkOGVxK3I2LzF1S2U0N09H?=
 =?utf-8?B?VTR4V2d5QWZsYnh5RE9DNURNTmowZSs3b1A1RlArUWtwT0dlb2t5b05kaXJh?=
 =?utf-8?B?S1ZZSGMzcERHT2tGK2J2bmtKeEZFaHB0a3RjYk1iOG9SQzA2ci9IT0VzUnFh?=
 =?utf-8?B?Z0xPZjVwQ0FXUWp4M2tuSDNmdkoxdGM3RWdTZTZEdER5WFNQK00vUEExUExm?=
 =?utf-8?B?VlVGbHBWNGZkN0lkeTJwZUMwNE85N3M4MWlQcnJOa1Y2ZnpYc3c0Z2hGM2Mz?=
 =?utf-8?B?bXFQdGdnSzRabmhsNlRZbFdrOXl2NzErcXBPQXBoRmRoZk5HaFAxckU3ZDdk?=
 =?utf-8?B?SEszd0JJdWhzVkpwR1JSMUxFOGpzSTlsWXdTaXNMdElMV3FJK3BUQzZhOUZv?=
 =?utf-8?B?L1NRbTBaTVJZM0tGRlBQMjRjRXl4ek1JSitaTHhlYlJ0Nmp6ZXJ4d2NobFlD?=
 =?utf-8?B?dTdVdkpnNm03MDZiTm1hWTBJczFUUitXUG5LNTgzaXlaL2MrdU5rbk50di92?=
 =?utf-8?B?ZktNVnRraWJsUCtVQjVKZGJoRFk3d1JUZFFEdHhvbjdkMEp0M1BXc2xPa2Vx?=
 =?utf-8?Q?0K7bwX36sxQejnZFPSchWyWxFYWsKJcUlgpUETFvrbIS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1516170-210c-432b-76c9-08da7aaf4f92
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 09:04:20.1085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1/y6TSq8Xf1m/6v/s73NbrkL8w8evN6i/0HT5jDSO/br50QjTDluJuUxeAUbTV4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4679
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>
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

QW0gMTAuMDguMjIgdW0gMTA6MzMgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIFdlZCwgMTAg
QXVnIDIwMjIgYXQgMDg6NTIsIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4gd3JvdGU6Cj4+IEFtIDA5LjA4LjIyIHVtIDE4OjQ0IHNjaHJpZWIgRGFuaWVsIFZldHRl
cjoKPj4+IE9uIFR1ZSwgSnVsIDA1LCAyMDIyIGF0IDAxOjMzOjUxUE0gKzAyMDAsIENocmlzdGlh
biBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMDEuMDcuMjIgdW0gMTE6MDIgc2NocmllYiBEbWl0cnkg
T3NpcGVua286Cj4+Pj4+IFVzZSB3d19hY3F1aXJlX2ZpbmkoKSBpbiB0aGUgZXJyb3IgY29kZSBw
YXRocy4gT3RoZXJ3aXNlIGxvY2tkZXAKPj4+Pj4gdGhpbmtzIHRoYXQgbG9jayBpcyBoZWxkIHdo
ZW4gbG9jaydzIG1lbW9yeSBpcyBmcmVlZCBhZnRlciB0aGUKPj4+Pj4gZHJtX2dlbV9sb2NrX3Jl
c2VydmF0aW9ucygpIGVycm9yLiBUaGUgd3dfYWNxdWlyZV9jb250ZXh0IG5lZWRzIHRvIGJlCj4+
Pj4+IGFubm90YXRlZCBhcyAicmVsZWFzZWQiLCB3aGljaCBmaXhlcyB0aGUgbm9pc3kgIldBUk5J
Tkc6IGhlbGQgbG9jayBmcmVlZCEiCj4+Pj4+IHNwbGF0IG9mIFZpcnRJTy1HUFUgZHJpdmVyIHdp
dGggQ09ORklHX0RFQlVHX01VVEVYRVM9eSBhbmQgZW5hYmxlZCBsb2NrZGVwLgo+Pj4+Pgo+Pj4+
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+Pj4+PiBGaXhlczogN2VkYzNlM2I5NzViNSAo
ImRybTogQWRkIGhlbHBlcnMgZm9yIGxvY2tpbmcgYW4gYXJyYXkgb2YgQk8gcmVzZXJ2YXRpb25z
LiIpCj4+Pj4+IFJldmlld2VkLWJ5OiBUaG9tYXMgSGVsbHN0csO2bSA8dGhvbWFzLmhlbGxzdHJv
bUBsaW51eC5pbnRlbC5jb20+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8
ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+Cj4+Pj4gUmV2aWV3ZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+IEFsc28gYWRkZWQgdGhpcyBy
LWIgdGFnIHdoZW4gbWVyZ2luZyB0byBkcm0tbWlzYy1uZXh0LWZpeGVzLgo+PiBJSVJDIEkndmUg
YWxyZWFkeSBwdXNoZWQgdGhpcyB0byBkcm0tbWlzYy1maXhlcyB3aXRoIGEgQ0Mgc3RhYmxlIHRh
Zwo+PiBhYm91dCAyIHdlZWtzIGFnby4KPj4KPj4gUGxlYXNlIGRvdWJsZSBjaGVjaywgaXQgcHJv
YmFibHkganVzdCBoYXNuJ3QgY29tZSBkb3duIHRoZSBzdHJlYW0gYWdhaW4geWV0Lgo+IEhtIHF1
aWNrbHkgY2hlY2sgYW5kIEkgZGlkbid0IHNwb3QgaXQ/IFRoZXJlJ3MgYSBmZXcgcGF0Y2hlcyBm
cm9tCj4gRG1pdHJ5IGluIHRoZSBsYXN0IGZldyBwdWxscywgYW5kIHNvbWUgbW9yZSBzdHVmZiBw
ZW5kaW5nLCBidXQgbm90Cj4gdGhlc2UgdHdvIGFmYWljcz8KCk1obSwgdGhlcmUgaXMgc29tZSBw
b3RlbnRpYWwgdGhhdCBJIHdhbnRlZCB0byBwdXNoIGl0IGJ1dCBnb3QgZGlzdHJhY3RlZCAKYnkg
dGhlIHJlLW9jY3VycmluZyBkcm0tdGlwIGJ1aWxkIGJyZWFrYWdlcy4KCkFueXdheSB3aGF0IEkg
d2FudGVkIHRvIHNheSBpcyB0aGF0IHRoaXMgc3R1ZmYgc2hvdWxkIHByb2JhYmx5IGdvIHRvIApk
cm0tbWlzYy1maXhlcyB3aXRoIGEgQ0M6IHN0YWJsZSB0YWcgOikKCkNocmlzdGlhbi4KCj4gLURh
bmllbAo+Cj4+IENocmlzdGlhbi4KPj4KPj4+IC1EYW5pZWwKPj4+Cj4+Pj4+IC0tLQo+Pj4+PiAg
ICAgZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyB8IDQgKystLQo+Pj4+PiAgICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dl
bS5jCj4+Pj4+IGluZGV4IGViMGMyZDA0MWYxMy4uODZkNjcwYzcxMjg2IDEwMDY0NAo+Pj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fZ2VtLmMKPj4+Pj4gQEAgLTEyMjYsNyArMTIyNiw3IEBAIGRybV9nZW1fbG9ja19yZXNl
cnZhdGlvbnMoc3RydWN0IGRybV9nZW1fb2JqZWN0ICoqb2JqcywgaW50IGNvdW50LAo+Pj4+PiAg
ICAgICAgICAgICAgcmV0ID0gZG1hX3Jlc3ZfbG9ja19zbG93X2ludGVycnVwdGlibGUob2JqLT5y
ZXN2LAo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFjcXVpcmVfY3R4KTsKPj4+Pj4gICAgICAgICAgICAgIGlmIChyZXQp
IHsKPj4+Pj4gLSAgICAgICAgICAgICAgICAgICB3d19hY3F1aXJlX2RvbmUoYWNxdWlyZV9jdHgp
Owo+Pj4+PiArICAgICAgICAgICAgICAgICAgIHd3X2FjcXVpcmVfZmluaShhY3F1aXJlX2N0eCk7
Cj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4+Pj4+ICAgICAgICAgICAg
ICB9Cj4+Pj4+ICAgICAgfQo+Pj4+PiBAQCAtMTI1MSw3ICsxMjUxLDcgQEAgZHJtX2dlbV9sb2Nr
X3Jlc2VydmF0aW9ucyhzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKipvYmpzLCBpbnQgY291bnQsCj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byByZXRyeTsKPj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgfQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgIHd3X2FjcXVpcmVfZG9u
ZShhY3F1aXJlX2N0eCk7Cj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgd3dfYWNxdWlyZV9maW5p
KGFjcXVpcmVfY3R4KTsKPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsKPj4+
Pj4gICAgICAgICAgICAgIH0KPj4+Pj4gICAgICB9Cj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
