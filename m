Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4280BC43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 12:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2C838184F;
	Mon,  4 Jul 2022 12:33:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2C838184F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zQR+G2iC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKl9r_kotmrg; Mon,  4 Jul 2022 12:33:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21267817A6;
	Mon,  4 Jul 2022 12:33:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21267817A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED1A6C0032;
	Mon,  4 Jul 2022 12:33:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B16DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 12:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26B89817BD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 12:33:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26B89817BD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yHn0nHjssNRH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 12:33:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD72B817A6
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD72B817A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 12:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFraxbJhleDVBejT3KW/IEdYzm6Tor2Mu9dbpd1oi3lgHnrsWZYrbYVrTT59Ein22/EqW/2u8APv4oDg5UqqJkmObjR+34PyzXZwfIR+/SIjBctQacttQSVxngKt3NPyEqjyhgp7HNwNU/DR4qGpowtmPZqo7Bv5fEVnOtSDVzzklXhZt9KHRafrHlmfX3cRVZ8QI0C7z6G7kTzbO/g5rlV9U+dtjR95l+nJ+KNzOR+6RTPUNKgb4wMR3NtsUMK0KQK2lFU4GMBnKlt24UqalTumj+ONq8GD1buEyjgx6xeEwKsEUCLC5KtG3I7dZaQxyB8JGVP92CMVgyUu3H/BDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbgHmTXn3+v9HYnad/3V1STrJHMw0NYfwlfzJZmXFrY=;
 b=hz1D0s3084dXOZl3GF6yqlkEd++akO9m4foqbnh+UwjCjl9rIU4STbqD2xBXHUe4W22SVzO7BJwdjijOMICb0AY5it4s4fHnf3sdsQjesyhui02kUYl7oChUMNM5J9EF0oXyKmNB3fLwuKZmiZkzH230U8jaOLfDQHSrEkP3FMZBuZs+VweaJywK/gcbZv0dDIl/hPuFHnAO/89xi249tomhHWOlTNw4Z3TAGPb/PSkS59YAmZe7Q1WQzj7w9Ro8Ug2B74eGhoQ4HpAJ9cHSHd+4e6alrvhuRSEpq9k07Mqv5Biv3XUMrhDdOVnGEatCRcYJ9ezqbbPK/CwBpkUSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbgHmTXn3+v9HYnad/3V1STrJHMw0NYfwlfzJZmXFrY=;
 b=zQR+G2iCvEhg78uVhMePel3JXalIkLupTtTyvt2Elr1FirATQP948T5/VeLpFzI37vqHmcRTc5UFeuyn2qBxlYmJhqOcNiELWSP2JZCUZyM/RTHNn/3XNETvyCaycBJDuchpxh8koCRO8SzKqAmcPpcjLKurCq5cACLiJ36iXGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4570.namprd12.prod.outlook.com (2603:10b6:303:5f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 12:33:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 12:33:29 +0000
Message-ID: <0335814b-dc11-4a54-9f24-bb4e9dbef35c@amd.com>
Date: Mon, 4 Jul 2022 14:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Linaro-mm-sig] Re: [PATCH v6 02/22] drm/gem: Move mapping of
 imported dma-bufs to drm_gem_mmap_obj()
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-3-dmitry.osipenko@collabora.com>
 <b8271f0c-d6a3-4194-1959-e112859756a3@shipmail.org>
 <c0273ac2-c87c-2612-03d4-dc52510b22f7@collabora.com>
 <b4086751-9bff-ea5e-93fc-ce2c513b129b@shipmail.org>
 <467a1cee-ba8c-98f3-0398-2a7a5a90b5c3@collabora.com>
In-Reply-To: <467a1cee-ba8c-98f3-0398-2a7a5a90b5c3@collabora.com>
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02f79fa1-b173-4a91-0a85-08da5db96648
X-MS-TrafficTypeDiagnostic: MW3PR12MB4570:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqM9tTqsq1qNBqPrPBfeqULoxXfM7jDY/dFSkJliTiMLOdISylOSsJMz0OGMbWpJK45+sQRXb00W7H23YnobVm+W8COMnUyXE9A2334GWNbcCS8fadxdOhtwxBVyis4oZOn2TnCjCs1QWhWmr4hgNj4VKVBUyCgHmgwylTkyYV1ruFHYHNBXtl1LtOLQFjzwmOq7hWWU96Vf42og6zaXhcU39XvRYB32z/mYE7X2535rcYQnmlEUid63ZH/ivQQBQOtChJr/Sz3/10wLuYbTQwj43+bFEpnHw25bcFOeLGYYSTh+JxrjCkDp03MOw4BXkT3XRxiRHwfP6/0R5f6mT9pPQynB7Zp6Eh1vy1lYnvmhkh8nvHl2r1J2Rl9xP8JtnbcgpmybQRiQZOw+mklZh4u1YUCI/s7PcQzY4RDRdzHzTgLU9FOWJD68N5O/XTQ6Y5BajB8D6iN6Wdo5axSOdiI19nRv+fCwh1d6jAt06jsRhQKQkSQXfUEkuTBNObyLUPRwl1jbYa3Y3X5bc4ZI20TjVWzSrFHiP50nBgrlPkHi0r3C0GZk6ColTaCdr8A9RczsGYl93NRazQtNt2E6krwIXem/0AxaLEgquHal7jkU8C/nmeAR7mlvdUJlMRMm2bGETb9gqDx9GiXEeMw9VFk/zklUQeSwelTA1a/7+5bLivaiFB4KmSyhtI90Tqu5PXfcoAbfnB2gg9+r04l1U9YJ/YqDUbrCP7Jb00z7rmESLf/OPJBk/gq0u3yeWGU+DlzFugU4XBk9dSZojY/1gOf/OpavThcBp0n5X+0U7fWoxM1XakpZh2XYiISdUO2RwtBdXge8d6Of71uHODXOq+iGCCTlBB/wIsiR281noDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(6512007)(6486002)(478600001)(66946007)(66476007)(66556008)(316002)(54906003)(110136005)(8676002)(7406005)(5660300002)(36756003)(31686004)(7416002)(8936002)(6506007)(53546011)(2906002)(2616005)(4326008)(86362001)(31696002)(66574015)(186003)(83380400001)(38100700002)(41300700001)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Ftb2x2QXlWQ1pWZFlSWklBandRWEhHVDVXbXljTjVNc2FZZmVnM01qUVJ4?=
 =?utf-8?B?bXpTNUN0dWRNZE9yOGN2d0NSb0RqaUhVTEovaTJNT1VVVEZWWnB0TlhWdnZo?=
 =?utf-8?B?THJhL2VGZkJVMTF0LzJvZG5kTEMxdjd5cWtwWi9wdlpuakhWYVRycmxHb0o1?=
 =?utf-8?B?d3p3bU5ITDQxb0FJV2tGTkVhTlhVU0U4dFdScmR0UmZheURMdkRSOSs1cFJm?=
 =?utf-8?B?VFFwVm1VcFZFU1AzS1RXc0FWUjVlODUyS1hBa1VWWCtYVStIcm5VTDdHWE9n?=
 =?utf-8?B?eDN4UmhWc1Z2YTAvaWthL3g4dDJmRlRFVlNSMVV3Y0ZTYk5rRjg1VFE5WGNF?=
 =?utf-8?B?bks3TjNBZzZrK0tPQWsxSWs5OEhrZUVibEhNbklIR0RWV3JvU2JpQmhFcURJ?=
 =?utf-8?B?bFZhMS8wRDYzWmJ4MWt5Y2xGVTJ1OGJMYU5GcGhGQVhDTnE2dTIvZDc4dmFP?=
 =?utf-8?B?K3BrL21xNFY3dlhza3ZhWDhiWGRjYkdRQmU2YU53UHFGVStueWtTYlVwZnVC?=
 =?utf-8?B?MlFkb1pjTXlYcHhITVg1U0czUlpTdWNtaW5PdG9jb05rTXJOS1pSS1BNRFlW?=
 =?utf-8?B?c3Mxd0dobDlrbzB6N1VYSklzQy9KaWN4N1NlbHljUUk3TnB4TTAwU2tjdG9Y?=
 =?utf-8?B?d1Uxdk5EaHNlOWdDaW9uQXVhZW0xWU0yUGlPSUJXanBrVVVLVW9yeFN6VDFp?=
 =?utf-8?B?am0wKzhmSk5KS2FHTWRCeklqWlB2V2c4aEYvWHQyUXFWTGhCc2hiMHRicmxB?=
 =?utf-8?B?L0E5ejFNb3ZEV0srcWZyT1ZiditlL2ZQYmJHMWtOTGplN3ZtcExuc0xyNGZM?=
 =?utf-8?B?R3AxUjMrV1hVSkcrYlBBVFdzQkJwRk41ZzZmV3pmQjg1YkhtUnl6Z2RhMzBr?=
 =?utf-8?B?Y0RESUhFdXluUlZ5eUU0SUdHMmViWUVtMzQxOUMrTUtQV2tZRThaanRnVS94?=
 =?utf-8?B?Tis1SlkvdFN6WE9ST2ROeVFFR25raWlyNUtwbGt1SWl6Qk1FVHFES0hiUVpD?=
 =?utf-8?B?TlU4ak9kTWd0V1I2SEhDL1c5S0VSWkorZHREMVoxV1VrY2dlRFdzQm5lNmhz?=
 =?utf-8?B?UnkzT1hENXRWbXBNRDdURWgwd00yaVZBRy9oNGhoQU45ZVhaQnFnMzJNVXg1?=
 =?utf-8?B?ZEo1R2oxLzhhYjlDN3VRSWtkNms5djNINmIzMThPZXRCSWpkSlg2c2FqY3dr?=
 =?utf-8?B?d3Jra2tONUZ4aVlEZytJMU9zaUhHcWg1cXllS3owM1hrbEF3QUQ3TVFkVVVr?=
 =?utf-8?B?WThObVRwcHBZOFdNUDBySm9tTG1hZE9UZnk4OXhOYjhQVjhwSmZvaDE1MEU3?=
 =?utf-8?B?SGhMeWJuNTV5Wkl4ZW51RDVhQUlqeWtpZ0lvOW8yK0dVVjdNbW01MVNTRy84?=
 =?utf-8?B?NFQzK2cxK3JQYlFBOThicXFQczhndHQwZDlFNnBOT0FLQXJaT2FuZTVIUzRW?=
 =?utf-8?B?WnhJa3Rrbm0wdlJIWkF5SmZzRjhYQ1BTdjlzV3gyNUllZG9aQmU5RFU2aGty?=
 =?utf-8?B?T1VUczdUdkwvWUpKTjh0ZU1RVytJMW5oQWpYVkNpaWVEc09jeEt5d25ZMDYv?=
 =?utf-8?B?YkdGblp1dXJxN0N3NjJGUDA1RnZNTmNGWXpCZUV4SXQ1TWdaaWozeGppTG9z?=
 =?utf-8?B?ZzVhVGZFWnE0MEN5aEd3UytkWE5kUERMREVlazhRb2pOd1crN2swTkJPR0Fp?=
 =?utf-8?B?UlZSVWVWNXZCWFc2aTJlVFlXbWpxYk5BMkhsWjREV2Vrd0RiSjJycUg1Zk9D?=
 =?utf-8?B?SFgxUHB3dUplOG4vWlZ0UkRYRkhDWWVuazg3TFphREswSCtvQjVlOHg4QWxB?=
 =?utf-8?B?TmNjRzh1S1JLMHo0MTRuUTVCTG5BTFB3S29TQVkrbVhoeU5MQ25heXorY0Ry?=
 =?utf-8?B?em9HQklwaGJaQTU2cWE0dFJJNzdPWi9VRVF4b2doWjRLdUwxVzhIbTc2L24y?=
 =?utf-8?B?OTJSa2Yrd2x3TXpPcHNsS3lLelN6OVgvcE5ISUZPcUxITlQ4Tmw0TWNVZDVI?=
 =?utf-8?B?RmRKWTc4d1JSbFN1K3ZGL3dCRzJvVTNybVFEa09ON25pSUNKVFZ1YlhnL09s?=
 =?utf-8?B?T28rL3FQSlZxUVFzOXdGZWp0UmhvTmRvWUlGdXJKT1E5Q2FSckxhcDFYYXBZ?=
 =?utf-8?B?K3QvWHhUU0JjUm9MeWU2MnEzZ2ZZdUY3YzRWbE5pQzQ5N3ZyWGtoVWdnTkJ3?=
 =?utf-8?Q?5mVXfs7A2BtRTpaDL9AHgWfHfHL3fAqBbEUXDLGOg4eJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f79fa1-b173-4a91-0a85-08da5db96648
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 12:33:29.5801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBFwRfZ7S+Sw+Y8ldEK4wFdvCCjNTtRSBt0dRwaOuHWKymgM6p6Una73A6CCTvGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4570
Cc: David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, Sumit Semwal <sumit.semwal@linaro.org>,
 Rob Herring <robh@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 linux-media@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger.kernel.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Rob Clark <robdclark@gmail.com>, Qiang Yu <yuq825@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Emil Velikov <"emil.l.veli kov"@gmail.com>
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

QW0gMzAuMDYuMjIgdW0gMDE6MDYgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gT24gNi8yOS8y
MiAxMTo0MywgVGhvbWFzIEhlbGxzdHLDtm0gKEludGVsKSB3cm90ZToKPj4gT24gNi8yOS8yMiAx
MDoyMiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4gT24gNi8yOS8yMiAwOTo0MCwgVGhvbWFz
IEhlbGxzdHLDtm0gKEludGVsKSB3cm90ZToKPj4+PiBPbiA1LzI3LzIyIDAxOjUwLCBEbWl0cnkg
T3NpcGVua28gd3JvdGU6Cj4+Pj4+IERyaXZlcnMgdGhhdCB1c2UgZHJtX2dlbV9tbWFwKCkgYW5k
IGRybV9nZW1fbW1hcF9vYmooKSBoZWxwZXJzIGRvbid0Cj4+Pj4+IGhhbmRsZSBpbXBvcnRlZCBk
bWEtYnVmcyBwcm9wZXJseSwgd2hpY2ggcmVzdWx0cyBpbiBtYXBwaW5nIG9mCj4+Pj4+IHNvbWV0
aGluZwo+Pj4+PiBlbHNlIHRoYW4gdGhlIGltcG9ydGVkIGRtYS1idWYuIEZvciBleGFtcGxlLCBv
biBOVklESUEgVGVncmEgd2UgZ2V0IGEKPj4+Pj4gaGFyZAo+Pj4+PiBsb2NrdXAgd2hlbiB1c2Vy
c3BhY2Ugd3JpdGVzIHRvIHRoZSBtZW1vcnkgbWFwcGluZyBvZiBhIGRtYS1idWYgdGhhdAo+Pj4+
PiB3YXMKPj4+Pj4gaW1wb3J0ZWQgaW50byBUZWdyYSdzIERSTSBHRU0uCj4+Pj4+Cj4+Pj4+IFRv
IGZpeCB0aGlzIGJ1ZywgbW92ZSBtYXBwaW5nIG9mIGltcG9ydGVkIGRtYS1idWZzIHRvCj4+Pj4+
IGRybV9nZW1fbW1hcF9vYmooKS4KPj4+Pj4gTm93IG1tYXBpbmcgb2YgaW1wb3J0ZWQgZG1hLWJ1
ZnMgd29ya3MgcHJvcGVybHkgZm9yIGFsbCBEUk0gZHJpdmVycy4KPj4+PiBTYW1lIGNvbW1lbnQg
YWJvdXQgRml4ZXM6IGFzIGluIHBhdGNoIDEsCj4+Pj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtv
QGNvbGxhYm9yYS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgwqDCoCBkcml2ZXJzL2dwdS9kcm0vZHJt
X2dlbS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzICsrKwo+Pj4+PiAgwqDCoCBkcml2
ZXJzL2dwdS9kcm0vZHJtX2dlbV9zaG1lbV9oZWxwZXIuYyB8IDkgLS0tLS0tLS0tCj4+Pj4+ICDC
oMKgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS9nZW0uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0
ICsrKysKPj4+Pj4gIMKgwqAgMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dl
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+Pj4+PiBpbmRleCA4NmQ2NzBjNzEyODYu
LjdjMGIwMjU1MDhlNCAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0u
Ywo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jCj4+Pj4+IEBAIC0xMDM4LDYg
KzEwMzgsOSBAQCBpbnQgZHJtX2dlbV9tbWFwX29iaihzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9i
aiwKPj4+Pj4gdW5zaWduZWQgbG9uZyBvYmpfc2l6ZSwKPj4+Pj4gIMKgwqDCoMKgwqDCoCBpZiAo
b2JqX3NpemUgPCB2bWEtPnZtX2VuZCAtIHZtYS0+dm1fc3RhcnQpCj4+Pj4+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+Pj4gIMKgwqAgK8KgwqDCoCBpZiAob2JqLT5p
bXBvcnRfYXR0YWNoKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGRtYV9idWZfbW1hcChv
YmotPmRtYV9idWYsIHZtYSwgMCk7Cj4+Pj4gSWYgd2Ugc3RhcnQgZW5hYmxpbmcgbW1hcGluZyBv
ZiBpbXBvcnRlZCBkbWEtYnVmcyBvbiBhIG1ham9yaXR5IG9mCj4+Pj4gZHJpdmVycyBpbiB0aGlz
IHdheSwgaG93IGRvIHdlIGVuc3VyZSB0aGF0IHVzZXItc3BhY2UgaXMgbm90IGJsaW5kbHkKPj4+
PiB1c2luZyB0aGUgb2JqZWN0IG1tYXAgd2l0aG91dCBjYWxsaW5nIHRoZSBuZWVkZWQgRE1BX0JV
Rl9JT0NUTF9TWU5DCj4+Pj4gd2hpY2ggaXMgbmVlZGVkIGJlZm9yZSBhbmQgYWZ0ZXIgY3B1IGFj
Y2VzcyBvZiBtbWFwJ2VkIGRtYS1idWZzPwo+Pj4+Cj4+Pj4gSSB3YXMgdW5kZXIgdGhlIGltcHJl
c3Npb24gKGFkbWl0dGVkbHkgd2l0aG91dCBsb29raW5nKSB0aGF0IHRoZSBmZXcKPj4+PiBkcml2
ZXJzIHRoYXQgYWN0dWFsbHkgY2FsbGVkIGludG8gZG1hX2J1Zl9tbWFwKCkgaGFkIHNvbWUgcHJp
dmF0ZQo+Pj4+IHVzZXItbW9kZSBkcml2ZXIgY29kZSBpbiBwbGFjZSB0aGF0IGVuc3VyZWQgdGhp
cyBoYXBwZW5lZC4KPj4+IFNpbmNlIGl0J3MgYSB1c2Vyc3BhY2Ugd2hvIGRvZXMgdGhlIG1hcHBp
bmcsIHRoZW4gaXQgc2hvdWxkIGJlIGEKPj4+IHJlc3BvbnNpYmlsaXR5IG9mIHVzZXJzcGFjZSB0
byBkbyBhbGwgdGhlIG5lY2Vzc2FyeSBzeW5jaW5nLgo+PiBTdXJlLCBidXQgbm90aGluZyBwcm9o
aWJpdHMgdXNlci1zcGFjZSB0byBpZ25vcmUgdGhlIHN5bmNpbmcgdGhpbmtpbmcKPj4gIkl0IHdv
cmtzIGFueXdheSIsIHRlc3RpbmcgdGhvc2UgZHJpdmVycyB3aGVyZSB0aGUgc3luY2luZyBpcyBh
IE5PUC4gQW5kCj4+IHdoZW4gYSBkcml2ZXIgdGhhdCBmaW5hbGx5IG5lZWRzIHN5bmNpbmcgaXMg
dGVzdGVkIGl0J3MgdG9vIGxhdGUgdG8gZml4Cj4+IGFsbCBicm9rZW4gdXNlci1zcGFjZS4KPj4K
Pj4+ICDCoCBJJ20gbm90Cj4+PiBzdXJlIHdoZXRoZXIgYW55b25lIGluIHVzZXJzcGFjZSByZWFs
bHkgbmVlZHMgdG8gbWFwIGltcG9ydGVkIGRtYS1idWZzCj4+PiBpbiBwcmFjdGljZS4gTmV2ZXJ0
aGVsZXNzLCB0aGlzIHVzZS1jYXNlIGlzIGJyb2tlbiBhbmQgc2hvdWxkIGJlIGZpeGVkCj4+PiBi
eSBlaXRoZXIgYWxsb3dpbmcgdG8gZG8gdGhlIG1hcHBpbmcgb3IgcHJvaGliaXRpbmcgaXQuCj4+
Pgo+PiBUaGVuIEknZCB2b3RlIGZvciBwcm9oaWJpdGluZyBpdCwgYXQgbGVhc3QgZm9yIG5vdy4g
QW5kIGZvciB0aGUgZnV0dXJlCj4+IG1vdmluZyBmb3J3YXJkIHdlIGNvdWxkIHBlcmhhcHMgcmV2
aXNpdCB0aGUgZG1hLWJ1ZiBuZWVkIGZvciBzeW5jaW5nLAo+PiByZXF1aXJpbmcgdGhvc2UgZHJp
dmVycyB0aGF0IGFjdHVhbGx5IG5lZWQgaXQgdG8gaW1wbGVtZW50IGVtdWxhdGVkCj4+IGNvaGVy
ZW50IG1lbW9yeSB3aGljaCBjYW4gYmUgZG9uZSBub3QgdG9vIGluZWZmaWNpZW50bHkgKHZtd2dm
eCBiZWluZwo+PiBvbmUgZXhhbXBsZSkuCj4gQWxyaWdodCwgSSdsbCBjaGFuZ2UgaXQgdG8gcHJv
aGliaXQgdGhlIG1hcHBpbmcuIFRoaXMgaW5kZWVkIHNob3VsZCBiZSBhCj4gYmV0dGVyIG9wdGlv
bi4KCk9oLCB5ZXMgcGxlYXNlLiBCdXQgSSB3b3VsZCBleHBlY3QgdGhhdCBzb21lIHBlb3BsZSBz
dGFydCBzY3JlYW1pbmcuCgpPdmVyIHRpbWUgSSd2ZSBnb3QgdG9ucyBvZiBUVE0gcGF0Y2hlcyBi
ZWNhdXNlIHBlb3BsZSBpbGxlZ2FsbHkgdHJpZWQgdG8gCm1tYXAoKSBpbXBvcnRlZCBETUEtYnVm
cyBpbiB0aGVpciBkcml2ZXIuCgpBbnl3YXkgdGhpcyBpcyBwcm9iYWJseSB0aGUgcmlnaHQgdGhp
bmcgdG8gZG8gYW5kIHdlIGNhbiB3b3JrIG9uIGZpeGluZyAKdGhlIGZhbGxvdXQgbGF0ZXIgb24u
CgpSZWdhcmRzLApDaHJpc3RpYW4uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
