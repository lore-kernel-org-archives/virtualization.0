Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D928EECAAD1
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 07:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6744A83E13;
	Thu,  1 Sep 2022 07:46:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6744A83E13
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oVczly8s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MSpQTwWVRkWn; Thu,  1 Sep 2022 07:46:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9E95C83E14;
	Thu,  1 Sep 2022 07:46:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E95C83E14
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A4C3C0032;
	Thu,  1 Sep 2022 07:46:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 260DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E836083E14
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:46:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E836083E14
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3AVcnLBE5OP9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:46:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C46983E2B
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C46983E2B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYF6CATeI+6DMfZ2tRRlKduD8WPzHMv6bSYyirIfsQu2hQSZuuCBYXLnNhIbQjuOSb1Zw04E5IKL1SFnAggA30jBLh8KBwl8wlGVdoszP5rOxkubv8msRT1fjJ6ZVON65L0rfqCqKsdf20VkOqEubVB4VEB8Z3jlknyg4JUAmgyMuwM2squqFyVPLFAp6OI3hn1P/z+cLnlMzVsTOW8Vf5L5K0cPnt8RXTKN9ukn6R06PhJ8jYbbVgFCZSKUiXokJibF6LIZGnUS9/vCpfgkyvTwj2XuMG8pIWd9MZwitYFAS8FjLjT2FO55Y0gG9bEm1DGcD8SmyLQSzCyR2Qegjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB6rZhHYcnVAQMefbqlbTnswcKBiw5jcMh1AY9IE3Tk=;
 b=Od6Xl8ZThS84xk0Rk/lR52x3IgyukWM0sjhepRr10A5G3USqphH/eDF90x76pNUhNOV4Uwg2xty7SG+mTTLy/IPgKvQyBurw7Fa9G4XsCHtgtW37yaAicnyx4MKXXOKJVfOUhlVC4fjdPqzCf5UopwROC1cNsyq+gpt9HJHMgVzmgF/8hGI+SeJVyAh4tV973rXbd9SCXBslKxzCab1jqDIQmIrwBuhIrZ9E32wKG6FwOq/1/dT7SaQlMaORZS9UL7ZpiwxfBvBHV4aNpbbjpiRLjQydR/kIf3bXlh2wSWvZRN919MvtCU41m4DWM1xT2n4TMuog+4dbmxcNXJ3wSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OB6rZhHYcnVAQMefbqlbTnswcKBiw5jcMh1AY9IE3Tk=;
 b=oVczly8sePR3s3duE7P+4uNT72RxjAKYAKkF4EuQ6O/6i3gHPxpD8jkTRGoftXQCTtdREXCrQaJYEhVDUwyWuIPzEIItN4fjN61NFaZgMXKvb1CxEZsCO2rpwbW8Yo1VoLJKLr+aUdl0RdAfWar2vXo4/naHdzquJirUQ5n7UE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 1 Sep
 2022 07:46:21 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 07:46:18 +0000
Message-ID: <23cc241c-5710-895e-eb33-3f12ce8e865a@amd.com>
Date: Thu, 1 Sep 2022 09:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 20/21] media: videobuf2: Stop using internal dma-buf
 lock
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
 <20220831153757.97381-21-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-21-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: FR0P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd114ec9-afa8-42d0-86bf-08da8bee0e0c
X-MS-TrafficTypeDiagnostic: DS0PR12MB6461:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HY7yeMjY4Da+bR91y3J01f9hYzkvgzrI9W1QEAGtrdocWAen0H+9fJbMmYFOX/CHE8Aij+4F3AIr9PJ92gFdHhtNJkb7oWCS6Z7o6DAMIQYeYzyca9gQUJse6tlrrOCfwATRkiPj5TIghVOOLkM7AEO6g3bnyQ+UXJ/hyO8UCS/8ZWk86ZjfWzEeKjRqfjndTDtMf5PaT6La6TgJzta6tWnafgcQFnc9+wvfZtk7MfCJvEhz42oinqObPNWX5pkIOnJPliScpUFgxGrmiLn3lK0sQhwX4JqiTG4SkrqobQ45KECtUIdge9b1e2h4cfDSI5CKe9mSajZJAgC4F0cR1IzX+saRoUO69tTZABH6mRQV1emvM75Q4fsW3e/PzwhDh96sbleurY1w+ONP8DCoKacd4iur6/ajnA542hCYo7iuBJfpA8tc+QKdLf1O1qbWvIbE5nV0KW9g2bGBqhq3bFe++urPvEb6pTLNZ7VQ6p3xJpf+L51/6UBCPjGbMplMcVSWuTdN5H8bnmUdz70iKdjWM8TON1k2vXkxmVeTQ1Qr0sfao7Xl+omVgcsyNJnA9qlVXpGrqrSIGp7LUYT7JDj1eiOgM3UXfSnOHHV0CkbRjOWhdHusT8RNpF/5eLVczQJYoSvGYYYzVPfu0wWP0nvSB8m9Jvilpag2wvud8T7AOtjX1oo522Xe6zdN9LdoDpt440ffN+WvN5rPygsbgrbC2P5N/Qq9BpoP838d4IMmwQJmP37G5J1ReMDci2Pop9suNfB4C2a6ItyZ4HnvXBjtkYPpK8i1+936I5FS0AjTPDhy3PCQgfrr1PGC0Moe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(66476007)(38100700002)(186003)(2616005)(66574015)(4326008)(8936002)(66946007)(316002)(36756003)(83380400001)(7406005)(8676002)(110136005)(7416002)(31686004)(2906002)(66556008)(5660300002)(6512007)(6666004)(921005)(31696002)(86362001)(6506007)(41300700001)(478600001)(26005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZlczRPaGNOd3hRV2pOdVNnUnVoak1pV0FJWnpIanFSNThFWENtbWVmemxi?=
 =?utf-8?B?Tk9tWkErK2ZuckVMZGp5NDVVZUpZcmxjVHJPSjF4QnhIWTBjT0NLYVIyS0or?=
 =?utf-8?B?TEtLVWtxTDJjbDFUdFpsaHo1MUdiR1RzY05TR1NmNENJTGhVOHlFb0NaaVJZ?=
 =?utf-8?B?YjNCK0ZnRjNya3ZvS0xkSGc4a1FHZTRZOERDVHlqZ3BYdDgrZ1pHMXVYckc3?=
 =?utf-8?B?NmFITlVTcnR4bHRucDZVbVFxbFlEcytRTDRKWHpjZjVvY280a2dDS0VqbmdR?=
 =?utf-8?B?OEhLSXc4OUYwWmUyanhRbVNqY0RPbU9ueUZDSEw0WVVGeHJiMWVoU05QTzNF?=
 =?utf-8?B?eHZqSFBLU2RyaTJ4T09wT2FUdzlLRkpXbnBFYWZiYmk0ZFRqR3VLMjg5ZFkv?=
 =?utf-8?B?alF6MHBuamp4a3htaG8xZUlmQ1lVTXhIcHB1STJXUWhoaXZ3bHBVNnFacTdt?=
 =?utf-8?B?a0o0S2pYRVpqRUxtTExXU0Izbktya2xoZWdRaS9TZzdTNjhrTi8ram1lWEda?=
 =?utf-8?B?TE5qM1R3M3pkcmxuMWlVZkpaU1p4L290Rk1lMDIyYURzUFNoZ0RRQm81aXd0?=
 =?utf-8?B?WU5UV1lNNVNsYWRJQTd3MkVWSUxobE1RNnhYTHEwTExERzdUUndGQzlZRlJ6?=
 =?utf-8?B?YVFPT0NlZ3VpT0RldFVFMjRISks0SFhqK2tSZ0dRYU9pMG5OMURxVHg2cm82?=
 =?utf-8?B?WS84ZSt3cGpYYVA4ZGVNMVRoZXlYdnBTOEhvcEV0blVoQUF5dTZHalVIZlU4?=
 =?utf-8?B?NVNWcEVpL0FWUlhSMExiU2xCRjlIZ2QrZUtOYmFIYnY0ZTE4L08yNjN6cnd6?=
 =?utf-8?B?T0dLU0luMUg5NTd1NEF6WUlWQkFYNEs0dFpVR0xCVTAzTzNCZjFNYzBWeUVU?=
 =?utf-8?B?U0MwcnQrRzEwMVovNFdiSEtHNmJSUE82bWt3bmxLa2ErY2hVLzFGMjV6T1lh?=
 =?utf-8?B?cytLT3FjWU8zU2VHRE1qZ2NYdDJXaXhtOHhYN1VyRnVaZ01oNU1NS0t3MmJO?=
 =?utf-8?B?MW5tTzNnV05YK3dtd1V0NDdSUmdPVUsyaHBYSzNLSkljMUprcWZRcWhxTnZ1?=
 =?utf-8?B?TU9Ranh6TU1uR3dFR2wyVk8yTkVoTTZsQnBxTUtGV09GV25PbVdORi95cEww?=
 =?utf-8?B?cklNYUZWYVluY2ZROUNYSXNEd2g4c3ZSblFIMktXUW5NZzFpL2NxbzJPQmhO?=
 =?utf-8?B?NzltRHRGc1ZsRi9QU05IMWVsWld2cEphUUZabXFSY1F0MzUvSGx4UnlXc3Zt?=
 =?utf-8?B?RUNnU3JpVHcvd3FVNXRCVzBTVVovRUZOVFA3MUIyalp6d1pGRTlTdSt3Qkp5?=
 =?utf-8?B?MThuV2ZHSlJad2tzdVV4VDBZSTdmM0FLY3duVklRaEZHR0kzZXB1NjA4OTB6?=
 =?utf-8?B?L0xSWHFqVDNlVXd6K0p1N3owUXFOejVpZmUwb1RjTmswanpjazF0MHNpc3hJ?=
 =?utf-8?B?OXhwNCtvYzJ3RXlJcTNHZUdJZmVwNHhPblFibnBHekowem5rOGVtVmZ3Uld4?=
 =?utf-8?B?MmpSWFFxa0xQUkxkZTBJSGM1c0FpTjZYcnJaSXVtRUlkUG0wS1VucFJETGdE?=
 =?utf-8?B?UlVQangxQytoYlZpWVJsandpendCRW1ZY0pIdG1kTGM4ZzdjL1g1Ris1N0pj?=
 =?utf-8?B?cWUvQk01MXJQOVRKNWdqcHFYdHRlL3ZsbTZYQllINFJTU2JXakNyVHBpeDQr?=
 =?utf-8?B?bEpQSGNMNUJmRUNCaU9tdk5KYkp1UUJodFI1TURGN3Vqc2tMTTVOK1lqYysv?=
 =?utf-8?B?Rll3dEpJTDJscWtNYk9rZmp6aDM2NDFrM1k1N256K0liQ3VNZjFvN1VrTzF3?=
 =?utf-8?B?akY2d2doUVZKQU1mNVZmRmdzTEdESGQyN3F5QXlGVWlVMlpyUmFQUFc0SjJv?=
 =?utf-8?B?bTNKM1BCZWNMYzBnR2JQdVBpaWV3a2tNQXVPdGRRdzJ2MTY5Y3A4ZEVIOTRh?=
 =?utf-8?B?ZUkweHlwV1pPeDVNWk10Z0RTeEVsLzhuekt6MlZNSHF1UGV3bGEwSWRIYTRN?=
 =?utf-8?B?eTJJa1VTU21CaTBSQ2FFU2JvU3F3NW84YXYyNmMzMFdmTkZPdWY5aEdKVWZT?=
 =?utf-8?B?NkptSmxCTktvenVFMUN6RkdoRU1zRTJPUGg0c1JQMTQwdGUxM2M1ZkxocHZY?=
 =?utf-8?Q?H1eB4HsNweQWCW0HB70BzFWI8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd114ec9-afa8-42d0-86bf-08da8bee0e0c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:46:18.5369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLxtFJx0qx+lCPScLqVYvHbiuZEbwwFcWElc/PZZ8hTRYZ0m2hwf5oPEikT89ypv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
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

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gQWxsIGRyaXZl
cnMgdGhhdCB1c2UgZG1hLWJ1ZnMgaGF2ZSBiZWVuIG1vdmVkIHRvIHRoZSB1cGRhdGVkIGxvY2tp
bmcKPiBzcGVjaWZpY2F0aW9uIGFuZCBub3cgZG1hLWJ1ZiByZXNlcnZhdGlvbiBpcyBndWFyYW50
ZWVkIHRvIGJlIGxvY2tlZAo+IGJ5IGltcG9ydGVycyBkdXJpbmcgdGhlIG1hcHBpbmcgb3BlcmF0
aW9ucy4gVGhlcmUgaXMgbm8gbmVlZCB0byB0YWtlCj4gdGhlIGludGVybmFsIGRtYS1idWYgbG9j
ayBhbnltb3JlLiBSZW1vdmUgbG9ja2luZyBmcm9tIHRoZSB2aWRlb2J1ZjIKPiBtZW1vcnkgYWxs
b2NhdG9ycy4KPgo+IEFja2VkLWJ5OiBUb21hc3ogRmlnYSA8dGZpZ2FAY2hyb21pdW0ub3JnPgo+
IEFja2VkLWJ5OiBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD4KPiBTaWdu
ZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRtaXRyeS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29t
PgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
Cj4gLS0tCj4gICBkcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1j
b250aWcuYyB8IDExICstLS0tLS0tLS0tCj4gICBkcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1
ZjIvdmlkZW9idWYyLWRtYS1zZy5jICAgICB8IDExICstLS0tLS0tLS0tCj4gICBkcml2ZXJzL21l
ZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLXZtYWxsb2MuYyAgICB8IDExICstLS0tLS0t
LS0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVvYnVm
Mi1kbWEtY29udGlnLmMgYi9kcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYy
LWRtYS1jb250aWcuYwo+IGluZGV4IDc5ZjRkODMwMWZiYi4uNTU1YmQ0MGZhNDcyIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi92aWRlb2J1ZjItZG1hLWNvbnRp
Zy5jCj4gKysrIGIvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVvYnVmMi1kbWEt
Y29udGlnLmMKPiBAQCAtMzgyLDE4ICszODIsMTIgQEAgc3RhdGljIHN0cnVjdCBzZ190YWJsZSAq
dmIyX2RjX2RtYWJ1Zl9vcHNfbWFwKAo+ICAgCXN0cnVjdCBkbWFfYnVmX2F0dGFjaG1lbnQgKmRi
X2F0dGFjaCwgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZG1hX2RpcikKPiAgIHsKPiAgIAlzdHJ1
Y3QgdmIyX2RjX2F0dGFjaG1lbnQgKmF0dGFjaCA9IGRiX2F0dGFjaC0+cHJpdjsKPiAtCS8qIHN0
ZWFsaW5nIGRtYWJ1ZiBtdXRleCB0byBzZXJpYWxpemUgbWFwL3VubWFwIG9wZXJhdGlvbnMgKi8K
PiAtCXN0cnVjdCBtdXRleCAqbG9jayA9ICZkYl9hdHRhY2gtPmRtYWJ1Zi0+bG9jazsKPiAgIAlz
dHJ1Y3Qgc2dfdGFibGUgKnNndDsKPiAgIAo+IC0JbXV0ZXhfbG9jayhsb2NrKTsKPiAtCj4gICAJ
c2d0ID0gJmF0dGFjaC0+c2d0Owo+ICAgCS8qIHJldHVybiBwcmV2aW91c2x5IG1hcHBlZCBzZyB0
YWJsZSAqLwo+IC0JaWYgKGF0dGFjaC0+ZG1hX2RpciA9PSBkbWFfZGlyKSB7Cj4gLQkJbXV0ZXhf
dW5sb2NrKGxvY2spOwo+ICsJaWYgKGF0dGFjaC0+ZG1hX2RpciA9PSBkbWFfZGlyKQo+ICAgCQly
ZXR1cm4gc2d0Owo+IC0JfQo+ICAgCj4gICAJLyogcmVsZWFzZSBhbnkgcHJldmlvdXMgY2FjaGUg
Ki8KPiAgIAlpZiAoYXR0YWNoLT5kbWFfZGlyICE9IERNQV9OT05FKSB7Cj4gQEAgLTQwOSwxNCAr
NDAzLDExIEBAIHN0YXRpYyBzdHJ1Y3Qgc2dfdGFibGUgKnZiMl9kY19kbWFidWZfb3BzX21hcCgK
PiAgIAlpZiAoZG1hX21hcF9zZ3RhYmxlKGRiX2F0dGFjaC0+ZGV2LCBzZ3QsIGRtYV9kaXIsCj4g
ICAJCQkgICAgRE1BX0FUVFJfU0tJUF9DUFVfU1lOQykpIHsKPiAgIAkJcHJfZXJyKCJmYWlsZWQg
dG8gbWFwIHNjYXR0ZXJsaXN0XG4iKTsKPiAtCQltdXRleF91bmxvY2sobG9jayk7Cj4gICAJCXJl
dHVybiBFUlJfUFRSKC1FSU8pOwo+ICAgCX0KPiAgIAo+ICAgCWF0dGFjaC0+ZG1hX2RpciA9IGRt
YV9kaXI7Cj4gICAKPiAtCW11dGV4X3VubG9jayhsb2NrKTsKPiAtCj4gICAJcmV0dXJuIHNndDsK
PiAgIH0KPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIv
dmlkZW9idWYyLWRtYS1zZy5jIGIvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVv
YnVmMi1kbWEtc2cuYwo+IGluZGV4IDM2ZWNkZWE4ZDcwNy4uMzY5ODFhNWI1YzUzIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi92aWRlb2J1ZjItZG1hLXNnLmMK
PiArKysgYi9kcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1zZy5j
Cj4gQEAgLTQyNCwxOCArNDI0LDEyIEBAIHN0YXRpYyBzdHJ1Y3Qgc2dfdGFibGUgKnZiMl9kbWFf
c2dfZG1hYnVmX29wc19tYXAoCj4gICAJc3RydWN0IGRtYV9idWZfYXR0YWNobWVudCAqZGJfYXR0
YWNoLCBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkbWFfZGlyKQo+ICAgewo+ICAgCXN0cnVjdCB2
YjJfZG1hX3NnX2F0dGFjaG1lbnQgKmF0dGFjaCA9IGRiX2F0dGFjaC0+cHJpdjsKPiAtCS8qIHN0
ZWFsaW5nIGRtYWJ1ZiBtdXRleCB0byBzZXJpYWxpemUgbWFwL3VubWFwIG9wZXJhdGlvbnMgKi8K
PiAtCXN0cnVjdCBtdXRleCAqbG9jayA9ICZkYl9hdHRhY2gtPmRtYWJ1Zi0+bG9jazsKPiAgIAlz
dHJ1Y3Qgc2dfdGFibGUgKnNndDsKPiAgIAo+IC0JbXV0ZXhfbG9jayhsb2NrKTsKPiAtCj4gICAJ
c2d0ID0gJmF0dGFjaC0+c2d0Owo+ICAgCS8qIHJldHVybiBwcmV2aW91c2x5IG1hcHBlZCBzZyB0
YWJsZSAqLwo+IC0JaWYgKGF0dGFjaC0+ZG1hX2RpciA9PSBkbWFfZGlyKSB7Cj4gLQkJbXV0ZXhf
dW5sb2NrKGxvY2spOwo+ICsJaWYgKGF0dGFjaC0+ZG1hX2RpciA9PSBkbWFfZGlyKQo+ICAgCQly
ZXR1cm4gc2d0Owo+IC0JfQo+ICAgCj4gICAJLyogcmVsZWFzZSBhbnkgcHJldmlvdXMgY2FjaGUg
Ki8KPiAgIAlpZiAoYXR0YWNoLT5kbWFfZGlyICE9IERNQV9OT05FKSB7Cj4gQEAgLTQ0NiwxNCAr
NDQwLDExIEBAIHN0YXRpYyBzdHJ1Y3Qgc2dfdGFibGUgKnZiMl9kbWFfc2dfZG1hYnVmX29wc19t
YXAoCj4gICAJLyogbWFwcGluZyB0byB0aGUgY2xpZW50IHdpdGggbmV3IGRpcmVjdGlvbiAqLwo+
ICAgCWlmIChkbWFfbWFwX3NndGFibGUoZGJfYXR0YWNoLT5kZXYsIHNndCwgZG1hX2RpciwgMCkp
IHsKPiAgIAkJcHJfZXJyKCJmYWlsZWQgdG8gbWFwIHNjYXR0ZXJsaXN0XG4iKTsKPiAtCQltdXRl
eF91bmxvY2sobG9jayk7Cj4gICAJCXJldHVybiBFUlJfUFRSKC1FSU8pOwo+ICAgCX0KPiAgIAo+
ICAgCWF0dGFjaC0+ZG1hX2RpciA9IGRtYV9kaXI7Cj4gICAKPiAtCW11dGV4X3VubG9jayhsb2Nr
KTsKPiAtCj4gICAJcmV0dXJuIHNndDsKPiAgIH0KPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLXZtYWxsb2MuYyBiL2RyaXZlcnMvbWVk
aWEvY29tbW9uL3ZpZGVvYnVmMi92aWRlb2J1ZjItdm1hbGxvYy5jCj4gaW5kZXggNzgzMWJmNTQ1
ODc0Li40MWRiNzA3ZTQzYTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tZWRpYS9jb21tb24vdmlk
ZW9idWYyL3ZpZGVvYnVmMi12bWFsbG9jLmMKPiArKysgYi9kcml2ZXJzL21lZGlhL2NvbW1vbi92
aWRlb2J1ZjIvdmlkZW9idWYyLXZtYWxsb2MuYwo+IEBAIC0yNjcsMTggKzI2NywxMiBAQCBzdGF0
aWMgc3RydWN0IHNnX3RhYmxlICp2YjJfdm1hbGxvY19kbWFidWZfb3BzX21hcCgKPiAgIAlzdHJ1
Y3QgZG1hX2J1Zl9hdHRhY2htZW50ICpkYl9hdHRhY2gsIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9u
IGRtYV9kaXIpCj4gICB7Cj4gICAJc3RydWN0IHZiMl92bWFsbG9jX2F0dGFjaG1lbnQgKmF0dGFj
aCA9IGRiX2F0dGFjaC0+cHJpdjsKPiAtCS8qIHN0ZWFsaW5nIGRtYWJ1ZiBtdXRleCB0byBzZXJp
YWxpemUgbWFwL3VubWFwIG9wZXJhdGlvbnMgKi8KPiAtCXN0cnVjdCBtdXRleCAqbG9jayA9ICZk
Yl9hdHRhY2gtPmRtYWJ1Zi0+bG9jazsKPiAgIAlzdHJ1Y3Qgc2dfdGFibGUgKnNndDsKPiAgIAo+
IC0JbXV0ZXhfbG9jayhsb2NrKTsKPiAtCj4gICAJc2d0ID0gJmF0dGFjaC0+c2d0Owo+ICAgCS8q
IHJldHVybiBwcmV2aW91c2x5IG1hcHBlZCBzZyB0YWJsZSAqLwo+IC0JaWYgKGF0dGFjaC0+ZG1h
X2RpciA9PSBkbWFfZGlyKSB7Cj4gLQkJbXV0ZXhfdW5sb2NrKGxvY2spOwo+ICsJaWYgKGF0dGFj
aC0+ZG1hX2RpciA9PSBkbWFfZGlyKQo+ICAgCQlyZXR1cm4gc2d0Owo+IC0JfQo+ICAgCj4gICAJ
LyogcmVsZWFzZSBhbnkgcHJldmlvdXMgY2FjaGUgKi8KPiAgIAlpZiAoYXR0YWNoLT5kbWFfZGly
ICE9IERNQV9OT05FKSB7Cj4gQEAgLTI4OSwxNCArMjgzLDExIEBAIHN0YXRpYyBzdHJ1Y3Qgc2df
dGFibGUgKnZiMl92bWFsbG9jX2RtYWJ1Zl9vcHNfbWFwKAo+ICAgCS8qIG1hcHBpbmcgdG8gdGhl
IGNsaWVudCB3aXRoIG5ldyBkaXJlY3Rpb24gKi8KPiAgIAlpZiAoZG1hX21hcF9zZ3RhYmxlKGRi
X2F0dGFjaC0+ZGV2LCBzZ3QsIGRtYV9kaXIsIDApKSB7Cj4gICAJCXByX2VycigiZmFpbGVkIHRv
IG1hcCBzY2F0dGVybGlzdFxuIik7Cj4gLQkJbXV0ZXhfdW5sb2NrKGxvY2spOwo+ICAgCQlyZXR1
cm4gRVJSX1BUUigtRUlPKTsKPiAgIAl9Cj4gICAKPiAgIAlhdHRhY2gtPmRtYV9kaXIgPSBkbWFf
ZGlyOwo+ICAgCj4gLQltdXRleF91bmxvY2sobG9jayk7Cj4gLQo+ICAgCXJldHVybiBzZ3Q7Cj4g
ICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
