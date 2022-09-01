Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C812EECAAD1
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 07:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76B6A82B1E;
	Thu,  1 Sep 2022 07:07:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76B6A82B1E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aauMJWVG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lo-dEeXeOwG7; Thu,  1 Sep 2022 07:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF27A80C58;
	Thu,  1 Sep 2022 07:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF27A80C58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0287C0032;
	Thu,  1 Sep 2022 07:07:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41CD4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E72E60B31
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E72E60B31
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=aauMJWVG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JJep6G8NymGC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:07:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9105860AE5
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2068.outbound.protection.outlook.com [40.107.212.68])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9105860AE5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5g0ZS9cdUzwdawSvHTk45POPngoABamcvme7l2d6A4/bCLFyavQ3bEj/OCV0QzUfhqfTV+RfKXYpoKYcDqnpwcH2eEVaKQiCkZYgTwSr5YlWzzqlYCHGJ9k5pZ3D6Xv1+UGO7nDTFgNpRWvkh48lMKupPu0VGQGnbjPoqpVklp9ug3zown95x8ZE21tZQ0NzK6hIjT/6Wa0dOoO2dSUHTvNB/n8T7NMT0vzPkNG0m4t7DscW5SeOH/0GFPj9p7NiBPkIQ1mj0Z0zgWXr673vIkaqFxSAvZP+XAswliFsVH3D8cjmPXgj0h/VIS3/A5dzWiyv55u7/Na9ySekyrVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wS6hoZqqxTAYIbFTrNeuiGnw4mq9SD4ZnSLOxh3OOo=;
 b=ReTFtTsEGBynKm0mtbQReJ3WzMDdtp/ZT+IvPmDZRlEScpWvKp042J6CFeAqlZ1nm2wGCouT7qQM2VQvaQXhWuwdClMtmGa2FibOxZ95vmct2qoHr/GkNP88tEXz4XgGOcAKL1mx64FiPuK4wuhTXUzAo9qkhHip0SJvo18gWHPzFqRa0UZj04++Y+EpNKdp5qwGoFGnG3SjbAL2xPY2pyoSN08s2GjR2se7B/DAT9Su6XTRA1TkDCHFHaoasl26eVg4UXvhXv2KQP5u4TO5WPejSvjExUBpgc3rwID6d2QiDfyi4uuT1Jm6bHxdn4rcmF8iomRCvJ4tenheyPbpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wS6hoZqqxTAYIbFTrNeuiGnw4mq9SD4ZnSLOxh3OOo=;
 b=aauMJWVGvAJCh0vXZSzbJOmK7QJxZMzEaBqIIPibKb1PQy0KYeMVmMSnDFhM+nHr0E7y7k+TTUvRwSLoI8vNph0g36SbJAjS76pej4quWHR2+OlosC/a3M7cev/glKjaiRh2AQkroTRjzQNyISAr7bXgHGBvAofoUIYCBAtA+BI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 07:07:15 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 07:07:15 +0000
Message-ID: <4e82d32f-6e5f-edaf-17f4-4381f762ac21@amd.com>
Date: Thu, 1 Sep 2022 09:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 16/21] dma-buf: Move dma_buf_attach() to dynamic
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
 <20220831153757.97381-17-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-17-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AM5PR0301CA0007.eurprd03.prod.outlook.com
 (2603:10a6:206:14::20) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da19bc91-840c-4876-7f25-08da8be8994b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4299:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jga8O1+qmXnK5URUTFGLeQXsXW8cBLVK00eGD0wz7a+W6Hvvr/9PBvfOyhSeYVJ0JXKo0lAiG3a5cmMPDbjH45hVHYovIOYGXOhOvb1YHqvGbO9x61ZYy7M362ViA7bnJyVXuYi5HFTdDdbpRkUQ2D/NPQzNEGCyOI6xC47nYPU1shjclVTMCgqYcGLdXGhtcQPvELeFwZrQv3eFEx0+Aczb0/cgRjbSGwgfk/pxD0ui1OmGIAbL1bv3k42pKPxx4iHyEAWZewCwJSgczFMeKlRrGR8dXCXGJpcdx1eLpVahBGktTbSN3d+w9LiHpR6DwGTMfmdgk3V6z4FgGWUZmPadVs8rJi1im5MRBrvWDS4e8BRlETfqLE2MW9GcXKHgpNeDMeUq+UVEhMiVt5E5CuVjkBA4+2S/GCwP0DKKmMqbG0l6I8TvuV8mbMcu1+t49CuHgI5VCrB8kt1FUwLL1HKF1OzJiRM/gIKEBGvDYbsbak6nnhRDWKxfMw+y5iFs9S2y0QZWGiVRjLeENT/IWq1l3v2v3fNZWUegWknLyxLCNPoFKUrMYkb6OjbaiphArEFlXOock2iJlfrkFykuXiAlm4bDoiVyFP2la6GykNACwIpn/3F7A2qZzbVb/e9JF18YcE+2ocQekJ+DvEe88BRFEVjrLzCmt9RUZ5h5Or2bC0s79Of6+6le5lyfqwtT7NJ9AgN5eKqDvORFNSBkGaOKpIZeNd9tpCTbmoGy/M8QAgXUFvPm3IMgB2JyxxOy26XeUttRtSlIdQjLbSm07TaluKfCb5jnKQ5PjWYszHlz2622aPwK1YravZLQscm3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(41300700001)(6486002)(26005)(6506007)(316002)(6512007)(6666004)(2906002)(86362001)(66476007)(36756003)(31686004)(31696002)(478600001)(110136005)(66574015)(2616005)(921005)(186003)(8676002)(66556008)(7416002)(7406005)(66946007)(38100700002)(4326008)(5660300002)(83380400001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1dMK0xpRUFSTHNBaTE5U0VOMlJPczJhZ1BBTUhqYWtkOUxzM2pIWlRGOXlw?=
 =?utf-8?B?Y1JGOUk1REVmQ3ZPUVhYeTZSZ21tYTg4bnBrVWNTOTR4ZGNyOGNZeVg4d2lo?=
 =?utf-8?B?UmdKVzIxNWN6ak8yak92anU1eUZydmRTallmVEJrekNJbk9BTVZFQU9qQ29H?=
 =?utf-8?B?cUg4SE5mSDlyVFRlazJxOTVOM05IUkRYT0d2RzRjSlhSUDZlVkZwK0ticlAv?=
 =?utf-8?B?Vk1Gb1hvSTZBRzhDZ3dvTzlydkhMdlhtRTlyQzRucDBYWDlGN2hFcjk3UWow?=
 =?utf-8?B?UnVEazRMKzZVc2tmRDVIZjFubHdYUmtZaXNyeFRKUzBYQkovVmd4bElIeTMr?=
 =?utf-8?B?SkRmRlhSTjVuRFdRVmtKUlE5NXZIc3RIeWI1aHFHU25XTDd3ZlNtZGhWTkpn?=
 =?utf-8?B?Zy9US3ZiMDYzc0RmMUhlLzV5ZXd0NXVYV3BqdHVZWTlwU0treE9MSkpSYW1C?=
 =?utf-8?B?OXJncUk0SzBqbENYaVZnRmsydEZtNzBTK3Y0OHpjSlRGVFJ0cGFUMXVHU2hw?=
 =?utf-8?B?UXIxOUROaXNmMjRWWjVmY2ZKN2dNOExONGI5SDRWRE1FTEJOdnNPcHB3VE9s?=
 =?utf-8?B?Y2hYNjBOZTUrdFU5T3NxYnZzVzN1aTZ5S2c2ZzZlVUh1bGJuOXNiZFU4aS9u?=
 =?utf-8?B?TDJOb1I4ZXRLRmFZVmh2ZVBIK1lMYVBNbDZnUG44emU2bjFJcDdHcVVSSVhD?=
 =?utf-8?B?YmpmdkdDdmYzc0t4citaMWg3ZkVGV1l0ei9KaHFMQitSTlRXRFlSdzFQcFM0?=
 =?utf-8?B?T2JjcW1pMFB5TER0dFpYRUVVTXdhVUpTWDc4Y1NUZkFtZjhBU2JLUEVZamFz?=
 =?utf-8?B?Qk4wRXRqcENSY1lPYU1RUGdTcUw3cVloSWphNGRjM3o3QWFNSFF3NDJjd3pv?=
 =?utf-8?B?TGlmdEVnd1IzandVOTRVY3c4dnNtQ1lQVmltemlxSzltTnhNQ3pqNWh5UVFh?=
 =?utf-8?B?N2cxbHdiQ0NmVG5mZ3lMTDJybGdOdUYxTTNZREE4ZXMxSDZNT2IyNm5qTng2?=
 =?utf-8?B?UjM5OU8wS0JvOHRLcHpkcnlqQklZMEJTY25qQkNVSXE0ZUhIbU53TTRsQk5W?=
 =?utf-8?B?L04zMG9oeDdvc2lrME92UXdZb3BjMHY0eHhxaHA1QVdQUU04WmJQNksxQVZE?=
 =?utf-8?B?YmdJUGVucU5kaGRSTVNKaytLV1pUdGdTR2JNYkJJeWpkUFVGdU5BSkEwb2dR?=
 =?utf-8?B?cGZadXdwcGNaWHNiU1k4OUpSWVlvTGZXREtybzRnanpjS1EwNjRFZVIrU0M3?=
 =?utf-8?B?dHZjYklhRHFhSWRtZy9Edm1ab0hmZjNGSEFWNVZnM2ZmZWlldzJEQ2gyS1dC?=
 =?utf-8?B?aFNHUUFkUjI2ZWpZUzFUVE56MXhnUmVoUkRLRVhWZEhqbXZpUUswNWRDYkNO?=
 =?utf-8?B?eHZqWkg4bHVjRE5GcjltS0REaTRVVTdRWjlHOWt0MEVpRUNhSXIyYlZZa2xL?=
 =?utf-8?B?OHk5S0FiUXMyeDMxZ0NYVVRock5rdFEzWWt5V0JiNDk2MGlUeCs0N1lxbkZy?=
 =?utf-8?B?VnFNYzB0cDZrK2tDemVlTzA2RVpxUmQ2Ym1kSEd0V04rQ3dKOHQ1RXljUElB?=
 =?utf-8?B?d1BLZzZ6NFJ2WVBnSmFCQUtQb0Fnb1JUbVlNRHJaSWMzRWtXWnJkMTZMT1dl?=
 =?utf-8?B?VW4zTHlkb2QrY2U1azF1cS83Q2VXQVh0QU9QVHlrbUMwcmdTc0JoR1BSYlho?=
 =?utf-8?B?bVNkbnFQM2pkbFA4byt3em8rMFRIQWhvNW96WTNWa0VNYzEvOUIza1F6UWFY?=
 =?utf-8?B?alRITkZYMXdUWC9UZ1BzTERRWThtRUhnSEs4bkpWaTlSaFo5Qkx4TGpXdkZP?=
 =?utf-8?B?U09tMXRuSmQ5dmkyeHhzdGFFNW1BeWFMbitIWTBsTFBKcDMxK2Z5MXFTSzlj?=
 =?utf-8?B?WUd4SHNGWUxDMHo0Ty8wQTFFelZ5UjJYMzdxajl3YjlNeE5iV2FvUjlsWHJG?=
 =?utf-8?B?OGlkeDNwQnN6THhGbkpYRG5MVHo4UmFEQ2tiN2MrN2FiRXFRNDZkMDZzRzY1?=
 =?utf-8?B?WllQWWxQU3hNRktqWklRaHp2YmFDd0svU01WNk9nMDYra1BKRTJyTmNoSy9o?=
 =?utf-8?B?WG44RkV1QS9rZDE5dHcrSVN3VDRsSFEwdHRYYlY2QkxJL0RGRXd1cit3VVJ6?=
 =?utf-8?Q?pnLQBUsL5Virsb6FREZFrWrO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da19bc91-840c-4876-7f25-08da8be8994b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:07:15.1569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvzbArcMq3mDU8GvFplzH0g4T8J/PaOoEbUFEI2mfageRT7wPRLZ2Sx4eOa6MqWr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gTW92ZSBkbWEt
YnVmIGF0dGFjaG1lbnQgQVBJIGZ1bmN0aW9ucyB0byB0aGUgZHluYW1pYyBsb2NraW5nIHNwZWNp
ZmljYXRpb24KPiBieSB0YWtpbmcgdGhlIHJlc2VydmF0aW9uIGxvY2sgYXJvdW5kIHRoZSBtYXBw
aW5nIG9wZXJhdGlvbnMuIFRoZSBzdHJpY3QKPiBsb2NraW5nIGNvbnZlbnRpb24gcHJldmVudHMg
ZGVhZGxvY2sgc2l0dWF0aW9ucyBmb3IgZG1hLWJ1ZiBpbXBvcnRlcnMgYW5kCj4gZXhwb3J0ZXJz
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29s
bGFib3JhLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYyB8IDIwICsr
KysrKysrLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5j
IGIvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYwo+IGluZGV4IGNlZWE0ODM5YzY0MS4uMDczOTQy
YmY1YWU5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMKPiArKysgYi9k
cml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jCj4gQEAgLTg1OCw4ICs4NTgsOCBAQCBkbWFfYnVmX2R5
bmFtaWNfYXR0YWNoKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBkZXZpY2UgKmRldiwK
PiAgIAkgICAgZG1hX2J1Zl9pc19keW5hbWljKGRtYWJ1ZikpIHsKPiAgIAkJc3RydWN0IHNnX3Rh
YmxlICpzZ3Q7Cj4gICAKPiArCQlkbWFfcmVzdl9sb2NrKGF0dGFjaC0+ZG1hYnVmLT5yZXN2LCBO
VUxMKTsKPiAgIAkJaWYgKGRtYV9idWZfaXNfZHluYW1pYyhhdHRhY2gtPmRtYWJ1ZikpIHsKPiAt
CQkJZG1hX3Jlc3ZfbG9jayhhdHRhY2gtPmRtYWJ1Zi0+cmVzdiwgTlVMTCk7Cj4gICAJCQlyZXQg
PSBkbWFidWYtPm9wcy0+cGluKGF0dGFjaCk7Cj4gICAJCQlpZiAocmV0KQo+ICAgCQkJCWdvdG8g
ZXJyX3VubG9jazsKPiBAQCAtODcyLDggKzg3Miw3IEBAIGRtYV9idWZfZHluYW1pY19hdHRhY2go
c3RydWN0IGRtYV9idWYgKmRtYWJ1Ziwgc3RydWN0IGRldmljZSAqZGV2LAo+ICAgCQkJcmV0ID0g
UFRSX0VSUihzZ3QpOwo+ICAgCQkJZ290byBlcnJfdW5waW47Cj4gICAJCX0KPiAtCQlpZiAoZG1h
X2J1Zl9pc19keW5hbWljKGF0dGFjaC0+ZG1hYnVmKSkKPiAtCQkJZG1hX3Jlc3ZfdW5sb2NrKGF0
dGFjaC0+ZG1hYnVmLT5yZXN2KTsKPiArCQlkbWFfcmVzdl91bmxvY2soYXR0YWNoLT5kbWFidWYt
PnJlc3YpOwo+ICAgCQlhdHRhY2gtPnNndCA9IHNndDsKPiAgIAkJYXR0YWNoLT5kaXIgPSBETUFf
QklESVJFQ1RJT05BTDsKPiAgIAl9Cj4gQEAgLTg4OSw4ICs4ODgsNyBAQCBkbWFfYnVmX2R5bmFt
aWNfYXR0YWNoKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBkZXZpY2UgKmRldiwKPiAg
IAkJZG1hYnVmLT5vcHMtPnVucGluKGF0dGFjaCk7Cj4gICAKPiAgIGVycl91bmxvY2s6Cj4gLQlp
ZiAoZG1hX2J1Zl9pc19keW5hbWljKGF0dGFjaC0+ZG1hYnVmKSkKPiAtCQlkbWFfcmVzdl91bmxv
Y2soYXR0YWNoLT5kbWFidWYtPnJlc3YpOwo+ICsJZG1hX3Jlc3ZfdW5sb2NrKGF0dGFjaC0+ZG1h
YnVmLT5yZXN2KTsKPiAgIAo+ICAgCWRtYV9idWZfZGV0YWNoKGRtYWJ1ZiwgYXR0YWNoKTsKPiAg
IAlyZXR1cm4gRVJSX1BUUihyZXQpOwo+IEBAIC05MzYsMjEgKzkzNCwxOSBAQCB2b2lkIGRtYV9i
dWZfZGV0YWNoKHN0cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBkbWFfYnVmX2F0dGFjaG1l
bnQgKmF0dGFjaCkKPiAgIAlpZiAoV0FSTl9PTighZG1hYnVmIHx8ICFhdHRhY2gpKQo+ICAgCQly
ZXR1cm47Cj4gICAKPiArCWRtYV9yZXN2X2xvY2soYXR0YWNoLT5kbWFidWYtPnJlc3YsIE5VTEwp
Owo+ICsKPiAgIAlpZiAoYXR0YWNoLT5zZ3QpIHsKPiAtCQlpZiAoZG1hX2J1Zl9pc19keW5hbWlj
KGF0dGFjaC0+ZG1hYnVmKSkKPiAtCQkJZG1hX3Jlc3ZfbG9jayhhdHRhY2gtPmRtYWJ1Zi0+cmVz
diwgTlVMTCk7Cj4gICAKPiAgIAkJX191bm1hcF9kbWFfYnVmKGF0dGFjaCwgYXR0YWNoLT5zZ3Qs
IGF0dGFjaC0+ZGlyKTsKPiAgIAo+IC0JCWlmIChkbWFfYnVmX2lzX2R5bmFtaWMoYXR0YWNoLT5k
bWFidWYpKSB7Cj4gKwkJaWYgKGRtYV9idWZfaXNfZHluYW1pYyhhdHRhY2gtPmRtYWJ1ZikpCj4g
ICAJCQlkbWFidWYtPm9wcy0+dW5waW4oYXR0YWNoKTsKPiAtCQkJZG1hX3Jlc3ZfdW5sb2NrKGF0
dGFjaC0+ZG1hYnVmLT5yZXN2KTsKPiAtCQl9Cj4gICAJfQo+IC0KPiAtCWRtYV9yZXN2X2xvY2so
ZG1hYnVmLT5yZXN2LCBOVUxMKTsKPiAgIAlsaXN0X2RlbCgmYXR0YWNoLT5ub2RlKTsKPiArCj4g
ICAJZG1hX3Jlc3ZfdW5sb2NrKGRtYWJ1Zi0+cmVzdik7Cj4gKwo+ICAgCWlmIChkbWFidWYtPm9w
cy0+ZGV0YWNoKQo+ICAgCQlkbWFidWYtPm9wcy0+ZGV0YWNoKGRtYWJ1ZiwgYXR0YWNoKTsKPiAg
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
