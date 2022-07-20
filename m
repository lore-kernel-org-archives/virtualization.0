Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAF4C43334
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 08:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1977281970;
	Wed, 20 Jul 2022 08:30:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1977281970
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ADuMcQCg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I4mND3HcqiLv; Wed, 20 Jul 2022 08:30:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 58CAF8195D;
	Wed, 20 Jul 2022 08:29:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58CAF8195D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F69AC0033;
	Wed, 20 Jul 2022 08:29:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59989C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EB8140139
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:29:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EB8140139
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ADuMcQCg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vXS9YD5oda9o
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:29:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47BA6400AB
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47BA6400AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 08:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2Qfr7yrz4ZNI4Tv/Vm9Yoet+KTUlfiZ7vB/3n5izmvXi1PMw4tPohUlNr5rdIhqa7beNUBfr6rUv+9CYCuRVLfKMunZvVTIgVN0BMCw2ePP9klYiXREbU4xQeC9yn9Rg2XQeNURFQ+4yfQN8aYr5os1Z282ppLQSikcOg9eSh8mw7JKDjvtlOUtqvv4guF4iou4KPFrImNIDYS5BILp+Ir95wqfD1tnJc11uXLmzDiGAXtgbStl0Jg7MWHXa9Zcu63oOjiwffkI9myJGh1J2ADXizzA2TjO/nwcoUnZD2w8RFgdzTtUiVlDPg26Y3zw1D7GYZyHIYfdkieX7EupcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+ZOJLZtqxPg1pMKZukdF3e/qzybtcdNG02Xi0IndsA=;
 b=Rdp3sREUzHQhdbqiADy25PQ15CbljVab9atASFDilskxVKSv7J5dzqWmJraSFWpJaLxGeNu0c+WvUiV6mDoYqvGAZg5HuyXT3BYLiZ4l2ToZ/uJWjoP+w6Y93W3RLwZ65LgEsSAFuEKrJf8mu1hJ0mSp0711N2GijrXjcWkXStDKKveUdAldBzGG/UxsaFJaEBhEK5zys/Mz0BGvq6XBCBGCW+WAd/Ii3EnEp3OL02p+PgSM1o/ls2fIj5mGzVE6Nys2+5nScsMMPGjJmNaTZYtfOoLqoxOWXuBr9oxPHjRleMkO/P9PehlxZHfLgQGkmNBVV7O/loWZRVovsJu0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+ZOJLZtqxPg1pMKZukdF3e/qzybtcdNG02Xi0IndsA=;
 b=ADuMcQCg9r8K0Kayf42S4fpPCiMvBRE3UQSLwC6J7+6+pNCAd/8NyRw+ANofQYVmiFepVq2s2wKiPM4WJGgnIkIJhNtQHbZp5yuuMwFcfNJxENbI8UcVxBIPxymAFUoJX0xs9X+zhJQcD6BraMHxFCg/lfkaDzSAHuzVb29j2X0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3198.namprd12.prod.outlook.com (2603:10b6:208:101::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 20 Jul
 2022 08:29:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 08:29:52 +0000
Message-ID: <163d3271-e1e9-c325-185d-adb4391023e1@amd.com>
Date: Wed, 20 Jul 2022 10:29:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 4/6] dma-buf: Acquire wait-wound context on attachment
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
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>
References: <20220715005244.42198-1-dmitry.osipenko@collabora.com>
 <20220715005244.42198-5-dmitry.osipenko@collabora.com>
 <5ec9313e-8498-2838-0320-331c347ce905@amd.com>
 <1ce233a2-36c9-3698-59f0-c4ff902bec60@collabora.com>
 <43446124-b99a-32d8-f797-7ec0cdca9ee4@collabora.com>
In-Reply-To: <43446124-b99a-32d8-f797-7ec0cdca9ee4@collabora.com>
X-ClientProxiedBy: AS9PR06CA0476.eurprd06.prod.outlook.com
 (2603:10a6:20b:49a::35) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e2450bb-1041-4e85-d769-08da6a2a0467
X-MS-TrafficTypeDiagnostic: MN2PR12MB3198:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLvv5dP8RX2F4lqe+h5iJ3G2SHZCHO6d7SRIuKh4MEqbRbRxkjSsj56o/ajbJm4mD/8EZrB140gYOBXfgxn98IuXinhvonVCLVNpreHygwKho9I78XHN4SS1qsM3/1Ynfcvlyqt3LrKJKoLlez9KJ1YsURf7wPA0oq1X/Kv1qH8QNdPlkyGq9mzcpEV1WEAj64xqyyeNkbOnQByl/AvR0dGt8Dd+uViv6gJCpip4I9zl39uJzmMWkhyzL3LEYFG16ecL1CQqAYSOoJVyb6aVThGIvSyvY2pH2Ki2V1X3BlfhX3mR5xRohhmOONsRRCtaeUVoonGqBRbivWdMLs7fbHNwRyOF2iiyMoS8PQcPxuLjRXjQXMRiHHVAzOHZvrCxGfG2vI/rRSlenip4lWuV26v1txCIsQP+9O9mrueomS92c9yfiJ5YJtf8bQOUKJJ4hQnXUVrN4UnTgc0myIT6qpS5YjWElsX9zOEluYUTB1fI0Bhhae0CUVzVzObunps21ixHkgJjSGDjbwhrNbALRo0fG4tsU2RGKidgezn3Ea6g1qtlVxgOqgq9YElF18IJrhu1bCKPYGpV3HHUkcY8yGJgqX5JdAfKdopdeFYID1Fan6YvOh3EcVLu6j5fr5dhFH1IuEq98/nW4yrizSOyGVN/xKfoAVrMhRkqQn+f4KxpK6w+M0dpZSpjOZQ5Gg+knFbzw7qW+xJROnZQS5/0ssQXVZg7w9ZQ7F+/PsJ8JL42nSvxSRROzuM2FM0Rk/NzVxhPy9/jX3hQ3ju/aAamqMZoW+1xj1E6msOSMEbyV2ONPITKagnZ4swDiFJrvJjNqXTlygzxq1sYXye6g5GUa+mC81kuS3MqwZ4n+4xiKOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(6506007)(53546011)(83380400001)(2906002)(41300700001)(8936002)(66574015)(5660300002)(7416002)(7406005)(6666004)(6486002)(478600001)(2616005)(316002)(6512007)(186003)(36756003)(38100700002)(31686004)(66476007)(66556008)(66946007)(4326008)(8676002)(110136005)(31696002)(86362001)(921005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZMNmhVd01WQU5sd1hKeVBJcFhMTzFPbS85dVVwR3BBZTBFaWtNeXhyUFNw?=
 =?utf-8?B?cEZnYTE2VTJPWExJaXJHZ0YzU1lzeFdOc1F5VTZWbnluV1c4VllEblNwVXlh?=
 =?utf-8?B?OW1taEs1a3BEWU5KTXgwSU9lSjVVdkNsVmx4OXdnQldERDVZZEsySmFqaTlx?=
 =?utf-8?B?dlFRbDg3RzlCMFNmYmJ1VHRheGFTYVo1T2NTL3hieHBteStVeE15cHUxaTBS?=
 =?utf-8?B?RnBrT1R4VWc4NzVZOHgvbGxLNkZRempwQjFIYmZ2Kzk5TnVsNTZLYXdQR0VD?=
 =?utf-8?B?cExpZ01LTHl3SDlkQ0FWcjZ5RUx4LzhlU282TkQxY2l1NDl3NVlLdkVlQmtK?=
 =?utf-8?B?dWFXMEJhRFJBVS8zdnkzZmhnb1RVRlhhOVhJeGJBZXBvNTdzM0RmZ3Y2WU5H?=
 =?utf-8?B?TDA5QWVTWFo0S0JsM09GeUdJNU11UGFNNnlDVjlaRTB1NmpXbTlBYWpGaHA3?=
 =?utf-8?B?MklQYVRZSXpaZnkzeFQwcmxOOXlSTk56WlFaaFhzN0Ezd0VkNzFpN1pHeDVN?=
 =?utf-8?B?SFdGQ2hhckJtNXFqbEVBRWMzSGlaWUJXMzZjZldLZnRob2k2OWZ5Yjd2K2hQ?=
 =?utf-8?B?OHhUTTlia1lrdllMSnNaVGlJUGVuMWtMK041MVRaaExYREttcE4xQzhSNnNK?=
 =?utf-8?B?UXVpTE9iTys5OWZRK1RmeHhTbDNBQVBrVnlVczdIZmEvY0dJUVJGaHR3Q2w1?=
 =?utf-8?B?Uk5lZC9wQzZwUGJLNW93bEt4Tm9nZS9zdkVhUEx3RXU5NFdOdnBOaklQQlpv?=
 =?utf-8?B?SHIvZy84Ylc4U2ZuVzlyVjhxeFo1MCtoUm9EbU1zd2Q2cmx0S3FmWlZXTzFr?=
 =?utf-8?B?MEFoS1RkcHcwZVBpVTVSeDdlTFdkaGNYVVdCd0NRS3ZiVHY4UVZ1dWpZSWlB?=
 =?utf-8?B?REQ2M3BvblRXK2xCa0xGc0xvM2Q0YnQzL0pkdmVHOUUwZHJDSEtxZUMzSnd2?=
 =?utf-8?B?dDdnb2I4Q0hJaXdPa2hzSHZ5b24zdmpCU2UwS1UvTlE3Nk96bXlKZFZsQytz?=
 =?utf-8?B?ZEhUWlgwdk1VVVNDY2JtUUxndDYrSXhWc0VmK3E3eUVnWnlNaENFV0VRSmZG?=
 =?utf-8?B?NU9qanNleGxrbmRxTFB5Y29NWklSZHBiQ01uQk1HNmQ3NUJud293S0NuOW02?=
 =?utf-8?B?R21nY2diWUZUNTFmVFZoYTNvMDVWVjN3TWVsQ0J4YVB3VWVacUtRV3kwWjk0?=
 =?utf-8?B?RUZTSGlLeE02ZUVoVnJPTFl1Y211aUY2ZG9JSS9qNTYxOFJudTNuZFpPcEwz?=
 =?utf-8?B?MnZjWG5MY2kwQzhwSnpIaExnL0RDcXhLRm5rUXpncGJsQ0NuQWUxK3dRbzYy?=
 =?utf-8?B?c1Yyc1NKT2w3VmxIWXVRS0xzYVk4cUYwN0s4c0ZJdnlkVm0yVGZFay9kL0dT?=
 =?utf-8?B?azV5MThJdnkwVmMyQ3NXNlpiNHlYZ2cxOTh4Y2pMdFlPMVN1Z2JDK3N5eHNK?=
 =?utf-8?B?ZVlubTNhSW5aMmdXTDFnVGphQ2JXNHE3VExHUXVpcEMzVGhKL1Z3bVB0QXpW?=
 =?utf-8?B?a0h2NlAycnJZN1pXWWtEWitBTlBFdlQ1Vzc3MEk3OWRTZWZ5Snd4b2dVR0Ft?=
 =?utf-8?B?UDY1RlhUa3Rmb3FmRmo3ZjdCbTBHVlJrUXpRcGhUZStaNzFibkhldjhoaXN5?=
 =?utf-8?B?Nis4RDJpbEVUbE9maUMrY3FLRFdkb21CV1Q5Uy94eUZwWjNoRURpS1EvRkwr?=
 =?utf-8?B?MSsrOG1uNmZqaHl5VUhCTXdFM2Z6YXk4NWsyZHY3QTFoRlRTaVdKT0UxOUU1?=
 =?utf-8?B?QURDUkVvS21RZmpZS0h4dG9HUXRFT1Z6UG1VV01VNlFhZi82L2VHS3htOExq?=
 =?utf-8?B?cVhGVTNlWUNyZUtXNFJ3T3IvaGowdFBkeHlOMzlKTFYycWQ3bTE2S0w4U2lU?=
 =?utf-8?B?Q0ZRbHM1VlB3cUNEZTNDNXZvZ0xXTU45a1N2Z1QyQW9Qdk5ieHhRRXRETFln?=
 =?utf-8?B?VEVNQzdMbit1Y2RZQnFIRnJrT3RBQmI4NGo3WlFhTzFRaGV2d2dGTkRtMGZY?=
 =?utf-8?B?QzhNUWV0NDJIelJpNHNmdDZKNEJhYVg4ZmlnNTlQaVZ5WGs5N2EzSngrSEVj?=
 =?utf-8?B?QkV6cGZ5ZGc1d0pHaGxxbk5QMmR5Rm1MdzIrSGpTQjU1d051TXpVeVFIaml3?=
 =?utf-8?B?RHRRRkgwZEVhdEJVMkpNNmoxMUJPUEtQc1ZaYXRrRTVHR25sQndkT1pIeEdv?=
 =?utf-8?Q?PuNHWYQ8aDFAsTw+mMIzPtFioocfS0aCF6/g2yMs33Nn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2450bb-1041-4e85-d769-08da6a2a0467
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 08:29:52.3462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wda2XqT0St5yc2qZ9a2h3AeB9JVXAmOHLXJDcCOg7+F1X68iVqAMI68HcQ0xlQBO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
Cc: linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 spice-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>,
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

QW0gMTkuMDcuMjIgdW0gMjI6MDUgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gT24gNy8xNS8y
MiAwOTo1OSwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBPbiA3LzE1LzIyIDA5OjUwLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTUuMDcuMjIgdW0gMDI6NTIgc2NocmllYiBEbWl0
cnkgT3NpcGVua286Cj4+Pj4gSW50ZWwgaTkxNSBHUFUgZHJpdmVyIHVzZXMgd2FpdC13b3VuZCBt
dXRleCB0byBsb2NrIG11bHRpcGxlIEdFTXMgb24gdGhlCj4+Pj4gYXR0YWNobWVudCB0byB0aGUg
aTkxNSBkbWEtYnVmLiBJbiBvcmRlciB0byBsZXQgYWxsIGRyaXZlcnMgdXRpbGl6ZQo+Pj4+IHNo
YXJlZAo+Pj4+IHdhaXQtd291bmQgY29udGV4dCBkdXJpbmcgYXR0YWNobWVudCBpbiBhIGdlbmVy
YWwgd2F5LCBtYWtlIGRtYS1idWYKPj4+PiBjb3JlIHRvCj4+Pj4gYWNxdWlyZSB0aGUgd3cgY29u
dGV4dCBpbnRlcm5hbGx5IGZvciB0aGUgYXR0YWNobWVudCBvcGVyYXRpb24gYW5kIHVwZGF0ZQo+
Pj4+IGk5MTUgZHJpdmVyIHRvIHVzZSB0aGUgaW1wb3J0ZXIncyB3dyBjb250ZXh0IGluc3RlYWQg
b2YgdGhlIGludGVybmFsIG9uZS4KPj4+Pgo+Pj4+ICDCoEZyb20gbm93IG9uIGFsbCBkbWEtYnVm
IGV4cG9ydGVycyBzaGFsbCB1c2UgdGhlIGltcG9ydGVyJ3Mgd3cgY29udGV4dAo+Pj4+IGZvcgo+
Pj4+IHRoZSBhdHRhY2htZW50IG9wZXJhdGlvbi4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IERt
aXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+Cj4+Pj4gLS0tCj4+
Pj4gIMKgIGRyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCA4ICsrKysrLQo+Pj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vaTkx
NS9nZW0vaTkxNV9nZW1fZG1hYnVmLmPCoMKgwqAgfMKgIDIgKy0KPj4+PiAgwqAgLi4uL2dwdS9k
cm0vaTkxNS9nZW0vaTkxNV9nZW1fZXhlY2J1ZmZlci5jwqDCoMKgIHzCoCAyICstCj4+Pj4gIMKg
IGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9vYmplY3QuaMKgwqDCoCB8wqAgNiAr
Ky0tLQo+Pj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X2dlbV9ldmljdC5jwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMiArLQo+Pj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X2dl
bV93dy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI2ICsrKysrKysrKysrKysrKy0tLS0KPj4+
PiAgwqAgZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9nZW1fd3cuaMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAxNSArKysrKysrKystLQo+Pj4+ICDCoCA3IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2Vy
dGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZG1hLWJ1Zi9kbWEtYnVmLmMgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jCj4+Pj4gaW5kZXgg
MGVlNTg4Mjc2NTM0Li4zNzU0NWVjYjg0NWEgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9kbWEt
YnVmL2RtYS1idWYuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMKPj4+PiBA
QCAtODA3LDYgKzgwNyw4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2dfdGFibGUgKiBfX21hcF9kbWFfYnVm
KHN0cnVjdAo+Pj4+IGRtYV9idWZfYXR0YWNobWVudCAqYXR0YWNoLAo+Pj4+ICDCoMKgICogT3B0
aW9uYWxseSB0aGlzIGNhbGxzICZkbWFfYnVmX29wcy5hdHRhY2ggdG8gYWxsb3cKPj4+PiBkZXZp
Y2Utc3BlY2lmaWMgYXR0YWNoCj4+Pj4gIMKgwqAgKiBmdW5jdGlvbmFsaXR5Lgo+Pj4+ICDCoMKg
ICoKPj4+PiArICogRXhwb3J0ZXJzIHNoYWxsIHVzZSB3d19jdHggYWNxdWlyZWQgYnkgdGhpcyBm
dW5jdGlvbi4KPj4+PiArICoKPj4+PiAgwqDCoCAqIFJldHVybnM6Cj4+Pj4gIMKgwqAgKgo+Pj4+
ICDCoMKgICogQSBwb2ludGVyIHRvIG5ld2x5IGNyZWF0ZWQgJmRtYV9idWZfYXR0YWNobWVudCBv
biBzdWNjZXNzLCBvciBhCj4+Pj4gbmVnYXRpdmUKPj4+PiBAQCAtODIyLDYgKzgyNCw3IEBAIGRt
YV9idWZfZHluYW1pY19hdHRhY2hfdW5sb2NrZWQoc3RydWN0IGRtYV9idWYKPj4+PiAqZG1hYnVm
LCBzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdm9pZCAqaW1wb3J0ZXJfcHJpdikKPj4+PiAgwqAgewo+Pj4+ICDCoMKgwqDCoMKgIHN0
cnVjdCBkbWFfYnVmX2F0dGFjaG1lbnQgKmF0dGFjaDsKPj4+PiArwqDCoMKgIHN0cnVjdCB3d19h
Y3F1aXJlX2N0eCB3d19jdHg7Cj4+Pj4gIMKgwqDCoMKgwqAgaW50IHJldDsKPj4+PiAgwqAgwqDC
oMKgwqDCoCBpZiAoV0FSTl9PTighZG1hYnVmIHx8ICFkZXYpKQo+Pj4+IEBAIC04NDEsNyArODQ0
LDggQEAgZG1hX2J1Zl9keW5hbWljX2F0dGFjaF91bmxvY2tlZChzdHJ1Y3QgZG1hX2J1Zgo+Pj4+
ICpkbWFidWYsIHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+PiAgwqDCoMKgwqDCoCBhdHRhY2gtPmlt
cG9ydGVyX29wcyA9IGltcG9ydGVyX29wczsKPj4+PiAgwqDCoMKgwqDCoCBhdHRhY2gtPmltcG9y
dGVyX3ByaXYgPSBpbXBvcnRlcl9wcml2Owo+Pj4+ICDCoCAtwqDCoMKgIGRtYV9yZXN2X2xvY2so
ZG1hYnVmLT5yZXN2LCBOVUxMKTsKPj4+PiArwqDCoMKgIHd3X2FjcXVpcmVfaW5pdCgmd3dfY3R4
LCAmcmVzZXJ2YXRpb25fd3dfY2xhc3MpOwo+Pj4+ICvCoMKgwqAgZG1hX3Jlc3ZfbG9jayhkbWFi
dWYtPnJlc3YsICZ3d19jdHgpOwo+Pj4gVGhhdCB3b24ndCB3b3JrIGxpa2UgdGhpcy4gVGhlIGNv
cmUgcHJvcGVydHkgb2YgYSBXVyBjb250ZXh0IGlzIHRoYXQgeW91Cj4+PiBuZWVkIHRvIHVud2lu
ZCBhbGwgdGhlIGxvY2tzIGFuZCByZS1xdWlyZSB0aGVtIHdpdGggdGhlIGNvbnRlbmRlZCBvbmUK
Pj4+IGZpcnN0Lgo+Pj4KPj4+IFdoZW4geW91IHN0YXRpY2FsbHkgbG9jayB0aGUgaW1wb3J0ZWQg
b25lIGhlcmUgeW91IGNhbid0IGRvIHRoYXQgYW55IG1vcmUuCj4+IFlvdSdyZSByaWdodC4gSSBm
ZWx0IHRoYXQgc29tZXRoaW5nIGlzIG1pc3NpbmcgaGVyZSwgYnV0IGNvdWxkbid0Cj4+IG5vdGlj
ZS4gSSdsbCB0aGluayBtb3JlIGFib3V0IHRoaXMgYW5kIGVuYWJsZQo+PiBDT05GSUdfREVCVUdf
V1dfTVVURVhfU0xPV1BBVEguIFRoYW5rIHlvdSEKPj4KPiBDaHJpc3RpYW4sIGRvIHlvdSB0aGlu
ayB3ZSBjb3VsZCBtYWtlIGFuIGV4Y3VzZSBmb3IgdGhlIGF0dGFjaCgpCj4gY2FsbGJhY2sgYW5k
IG1ha2UgdGhlIGV4cG9ydGVyIHJlc3BvbnNpYmxlIGZvciB0YWtpbmcgdGhlIHJlc3YgbG9jaz8g
SXQKPiB3aWxsIGJlIGluY29uc2lzdGVudCB3aXRoIHRoZSByZXN0IG9mIHRoZSBjYWxsYmFja3Ms
IHdoZXJlIGltcG9ydGVyCj4gdGFrZXMgdGhlIGxvY2ssIGJ1dCBpdCB3aWxsIGJlIHRoZSBzaW1w
bGVzdCBhbmQgbGVhc3QgaW52YXNpdmUgc29sdXRpb24uCj4gSXQncyB2ZXJ5IG1lc3N5IHRvIGRv
IGEgY3Jvc3MtZHJpdmVyIHd3IGxvY2tpbmcsIEkgZG9uJ3QgdGhpbmsgaXQncyB0aGUKPiByaWdo
dCBhcHByb2FjaC4KClNvIHRvIHN1bW1hcml6ZSB0aGUgZm9sbG93aW5nIGNhbGxzIHdpbGwgcmVx
dWlyZSB0aGF0IHRoZSBjYWxsZXIgaG9sZCAKdGhlIHJlc3YgbG9jazoKMS4gZG1hX2J1Zl9waW4o
KS9kbWFfYnVmX3VucGluKCkKMi4gZG1hX2J1Zl9tYXBfYXR0YWNobWVudCgpL2RtYV9idWZfdW5t
YXBfYXR0YWNobWVudCgpCjMuIGRtYV9idWZfdm1hcCgpL2RtYV9idWZfdnVubWFwKCkKNC4gZG1h
X2J1Zl9tb3ZlX25vdGlmeSgpCgpUaGUgZm9sbG93aW5nIGNhbGxzIHJlcXVpcmUgdGhhdCBjYWxs
ZXIgZG9lcyBub3QgaGVsZCB0aGUgcmVzdiBsb2NrOgoxLiBkbWFfYnVmX2F0dGFjaCgpL2RtYV9i
dWZfZHluYW1pY19hdHRhY2goKS9kbWFfYnVmX2RldGFjaCgpCjIuIGRtYV9idWZfZXhwb3J0KCkv
ZG1hX2J1Zl9mZCgpCjMuIGRtYV9idWZfZ2V0KCkvZG1hX2J1Zl9wdXQoKQo0LiBkbWFfYnVmX2Jl
Z2luX2NwdV9hY2Nlc3MoKS9kbWFfYnVmX2VuZF9jcHVfYWNjZXNzKCkKCklmIHRoYXQncyBjb3Jy
ZWN0IHRoYW4gdGhhdCB3b3VsZCB3b3JrIGZvciBtZSBhcyB3ZWxsLCBidXQgd2Ugc2hvdWxkIApw
cm9iYWJseSBkb2N1bWVudCB0aGlzLgoKT3IgbGV0IG1lIGFzayB0aGUgb3RoZXIgd2F5IGFyb3Vu
ZDogV2hhdCBjYWxscyBleGFjdGx5IGRvIHlvdSBuZWVkIHRvIApjaGFuZ2UgdG8gc29sdmUgeW91
ciBvcmlnaW5hbCBpc3N1ZT8gVGhhdCB3YXMgdm1hcC92dW5tYXAsIHdhc24ndCBpdD8gSWYgCnll
cyB0aGVuIGxldCdzIGNvbmNlbnRyYXRlIG9uIHRob3NlIGZvciB0aGUgbW9tZW50LgoKUmVnYXJk
cywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
