Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB340ECAAD8
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 07:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B35E8177C;
	Thu,  1 Sep 2022 07:49:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B35E8177C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JpvwNnlY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fuJ4j4wNwbZd; Thu,  1 Sep 2022 07:49:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9CACC8176B;
	Thu,  1 Sep 2022 07:49:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CACC8176B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 666BFC0032;
	Thu,  1 Sep 2022 07:49:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDE72C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 987BE60BBF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:49:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 987BE60BBF
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=JpvwNnlY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jh_MxKAW0wTa
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:49:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B22A60A87
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B22A60A87
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6JcXWnbGcUV2tzOh02yaq+PpastHX6FWdcvbwfoYBG+teR6Avq6Z1a5k+Vl2kguWEcEwN+kefUVrtNNkLKpGfhazyY5wwCv3cnZtoyAL6hIvEiKVuG7gqfKX5n/8nvTMj/hnI5pEVlP54z/tnpXP3xUuVEhS9XkaSNgLR5ul4iMoEgODRZ5fMV7wZKmo51Aymqx8c31uzg38/ueOflCbvK/b/MqamrYB2aqDb8L8ssGugecxAjuuGLOOjdkS+nRc80prYmXRxk1L2jtYvvU+WS2tSm1eMVP1qRAmETLVEeqiIuWm9I2U20F4ljIL7xVoBj1W74gAvP2mk3MFfbluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtnNjOm3mfbaiA9g0xWDk6iOkoPpekf7mz/0krVpSHQ=;
 b=jG2DrXRoYfNarpFU0rSnFXcF49dEgMU0W54ayM1EjF9HIJ0ZAd1wfPWDFW7H9+MNWkc81NB8q7mg6fiXGwGb7k4hFE+kyx9XbQ9lSZz6x4syXYAPFAJVF2S5t4rAsjbcflccw+x9YmotTTA9FzNZKW1BHORU57MNRFVICrMFthp6mpd6yfqO1EGl5IVkCvWb+9X7mBQsU4FkK4vZOJlLu+xOWr7LhoS1iQx8LRXuORJ+h9mSKI8SwJQtV25odWlB0sw+xaMHkGS/dDXO27mtDFhPFbXiHglp/PmnzgyB7g5xjOWavKuAPkqJInO3fgAKjI3FiuBIbGz3ty7gkNIJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtnNjOm3mfbaiA9g0xWDk6iOkoPpekf7mz/0krVpSHQ=;
 b=JpvwNnlYSclwm1qz74VZOGVpWJj0A6yEoWOVbr2bjn/KfYd+G5xdDXdyJsygWmNgnUQG7nvnKPdctmFNUnQZndAL4uovfGXeYclVaIgREfgpIVR/NoiQ4I35M1XShi+mNwfdrMNi/0A0FXeAqDJTs3qsSTHBxJwTydavEqWti/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 07:49:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4524:eda6:873a:8f94%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 07:49:12 +0000
Message-ID: <8322099f-4ef3-6a5d-4a66-27c4b3329884@amd.com>
Date: Thu, 1 Sep 2022 09:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 00/21] Move all drivers to a common dma-buf locking
 convention
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
In-Reply-To: <20220831153757.97381-1-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec68044d-d5ac-46a5-b018-08da8bee75f0
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7068:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xra6RWrU/TtLGcRNSFqSDQBWFPWpp3n3wVOyxPvqdFNDD7V1/8H5/RqXg/iNjBv/N6HO9FjiGowqgcUMl/TWIKw/L2Js7ZlTELrNg0boaFEk2RRXS2r7isBn9tWaON7GpfYKV4bK7zV7itoJgLtymLiZuyRDd8ebvHKKz0trrWjYiqO0f3YBsYzZoQgRmia9XsoN6R1pQcr4OtNKHGiWQvs0fzhb1MEyArgAuDTdIjIHjacW0YHtqXo/FJt6x048oiW0E1PXV42v2a0e5rOy5+ua7QX+lnu8HWu3RwoUII70ew00rhXLeJ7DkewRo8KchMhDpuTtGnUYmRr+OfjbVv6XAlIVgSCb1pcMqD3XIZ+jnyz0W+i1emqEJjnNm8MhgcHwB61AAi98Sc/6h1pTPNHzzaltMWATP3fGNJ9e+c27epZIY5uc+K10TF3N0zbNcR2BCSSIcEj1Wcd0HJhK/yqPyi/no6otGFe3fLr+k48rwOn1m4PFKYzbquIwECa+uMiZHD3VD7pzNGe75WtD6FDxY0cxaMWHFhrD4pJ6GHpiyK3GeJMWi4khHQuytpkt3XSbKqfZ5upzHpK7KW7SngTLJpz1qLk1pVKTlsz2NJ0nJkrXm+HqHRvOf4MdLu/yHD1S9f+KyaoBIUil2dW7j1NzooSs/kA9dTI3H0or1+heYyeaP++yFxmA6L0PGrFhExmproWq+pvjeaZR3BDT5NgclUYR5WTyg1H3ae9APfksFx7Y4nQvR3MtTTg5y7/Z7Z6fxf28fghWoIvpJUbd5mCMk6Uk+zN+Xo0HBog8QnoB+igUT788SeQeQ1OMaPNn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(31686004)(316002)(19627235002)(110136005)(38100700002)(186003)(86362001)(921005)(31696002)(36756003)(2616005)(2906002)(83380400001)(6486002)(41300700001)(8676002)(66556008)(66476007)(66946007)(4326008)(478600001)(7416002)(6666004)(8936002)(7406005)(5660300002)(6506007)(66574015)(6512007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWFzMG5TeE1PaEJRYTBvL2lGclFMRlh2alhUYlpNNUF3VytWNVBuN1lzQ2N5?=
 =?utf-8?B?UVNZOFdjRUV4SVYxa2xZTU1IQTBhTGkveGRkT29mZU9Mb1ZGNXZHK2NESXJL?=
 =?utf-8?B?QjFqbjlUK0UrMlhQVWFGajVRTkt0UVRIZTdXZXY1dFdKekJKOWdxQUQyU1M2?=
 =?utf-8?B?QmNDYW5UazJpTXFVT1RZUmlYaTZZazFwTmNpSWtUajlvTlhtT0QxU1JKVjFF?=
 =?utf-8?B?eGFnempJU09EU3JHdUswdllWcGdzejFtTmJYbzk1YjFVNFdSYkVHT3dnWkoz?=
 =?utf-8?B?MkVhYnBaaGd1TkFOamlYaXNVNGlnbU9mRUhrU2drTk1yZkVrRGFiaGJSM1Qz?=
 =?utf-8?B?SjVxZytlZ1Vwa3FCUTdlWkFQSk5TeGdPU0RHWk9GNTJzOGRua1lhNXpvUnF0?=
 =?utf-8?B?Rm1lUXMwbUJXcHV0U3BySURkNFc5RlE0Q2c0MVZiK3BzS2dUcE1ONmVMRDlv?=
 =?utf-8?B?b0FocEEwZmJ3WnhpQlkxVHVDSVNIdUp5bCs3ditIamtweHM0dDFzUEZMK1k3?=
 =?utf-8?B?cHltWS94ODFhd3VVbm9hd0xudjR0ZUwxNG9OcmxtcWZ3cVlVcW5veW9mZDlP?=
 =?utf-8?B?eURwUnY1RTJMNDA2ZGJkakduU01OYWhNRytoMTg2WGF3R090VDdZUVd6c2Mz?=
 =?utf-8?B?ZEt3M1BTREdJWWlna20xK0NNQllJODF3ODFFSlhXS3FxRkVWSU95aVFqUG5W?=
 =?utf-8?B?OHYyYzRad0hXbmRKZFduNzJCUHNwYW9IV3djNVVPVHBsdzBrUERRZ3F2bTBB?=
 =?utf-8?B?VzdscVVKb0pmNmJRbkgyOGJNUWZrSldvdFJmY2VoYmFpeWswK09sQUpUSEJ3?=
 =?utf-8?B?TTBzWTRJcVdoa3lCR3lzN2U0V1MyZXNIV29weC9pZW9hQ3Zjc0lucTU2SU5B?=
 =?utf-8?B?Mi9hcEcyYUswN1dBSHIzdUtpSXZSMDB3a3Q4QXRqZEZzOGsrZ0tQekU2OWxv?=
 =?utf-8?B?d3ErbTloNVZnNkJ6TnNYZjh6UVRjME8waXlxMWN1RTVsb05yZWg2QXlHdTZF?=
 =?utf-8?B?R2dJSnNOVnlrRGEwc2N1Q1Z1RHl5K1FPcndpcUgvVCtlczU0eHlscUdOMTBO?=
 =?utf-8?B?M0l3VExOMG0rOERGVjhIR1N6cDIzYlFLMlN2ODBFemdldHZlNTM5V2pNOHBK?=
 =?utf-8?B?dXB0MkQyeXBLeGVYVjFKRUdSbjVOMjIwT2JvQnNydnA5bE83UnVFYTF3WmIz?=
 =?utf-8?B?aVlqcXdBV0E1M3lVbmJvbzBzbCtNYWR3ekwxVmJEaU43ek5uOWhxTjY0MWdk?=
 =?utf-8?B?WlRSL0tOR1VTMmt3UlFOZkdFbExFREFiK1hHdUZZTmJqQ2N6QWtaa0x5WjI0?=
 =?utf-8?B?L293YzRpZ0RnbXpsallFcmliakc1MjNCRmZKa0lxbTdScC9FU0RaZG8rSlhu?=
 =?utf-8?B?WUhQYWRtNjhIOUJjU09uY3VRUldHTy9JS3k2MVZBaEZnNEcrMHFpQlg2a0x3?=
 =?utf-8?B?VE1jKzZqNWJLSmcvQTR2aEtIenVmWXpqVFVrZ01RVVlkcXlZRVJXK2JSbmRN?=
 =?utf-8?B?Nnpyem9RenY1Z1BOc1pLQTJ4RWErZkJ5V2xCdno3V3ZHQ011SWJpU3UycWs4?=
 =?utf-8?B?ZDhST3g5Q1l4cUhEcnRGOWFBZUpGRkRjOXRUaGxQc0hUTmtjYlVubFlrTlZF?=
 =?utf-8?B?VmNQZ0Jva3RKSjhvUEl1ZVBwc0p1akpOUWxUUDFxcEc1RGxZWlJ2MXphcUI5?=
 =?utf-8?B?dTBheFFkR3l0M05qVFNGZ2h2R3hzTmtiNUMxck1RM3ZkTXZnUW5vWEFBcXMx?=
 =?utf-8?B?akVYSnJEcGlaS2ppSnc2QnNSNmRJWVhmckFXKzllNUQ5YndPSURkVEtxZXM1?=
 =?utf-8?B?WkV6Z3ZsSjdjOTVDVXNka0pvTFozcy93bVpGTE5lRkhwam9RaDFWQ3RiMHkv?=
 =?utf-8?B?a3JEb0ZOS1U3WXIwVWcvZnByZ1Y2bS9Udnh3KzBxb3ltQU1EMGdrZFc1NHVI?=
 =?utf-8?B?T3JQOTFsWm0vbE80Y2drUW1VUmNFUkkycVlmY2orRnBDUzJXcmR6WHRtajhH?=
 =?utf-8?B?cUxBWER0Rlk1NWlaeHlPMHkwU1VPNWFIdEROZ0Npc3hVYnQ3VWRlV0toRkpO?=
 =?utf-8?B?YVJvd2s4WG04ZDUvOEQzUldEWVg3dE40T01ESlN1cFRzOTBnV1ZRclNBOU5a?=
 =?utf-8?Q?P1Bd2NE+krw2THlgpDn2L75VF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec68044d-d5ac-46a5-b018-08da8bee75f0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:49:12.6969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7mIQ3DPsgp3GbxAECBPA+RECrU4HO+7G2JkVAVnnWnwED0IZ6eYSrrfTkk24JZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
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

SGkgRG1pdHJ5LAoKSSd2ZSBnb25lIG92ZXIgdGhpcyBtdWx0aXBsZSB0aW1lcyBub3cgYW5kIHdo
aWxlIGl0IGlzIHN0aWxsIHBvc3NpYmxlIAp0aGF0IHdlIG1pc3NlZCBzb21ldGhpbmcgSSB0aGlu
ayB0aGF0IHRoaXMgc2hvdWxkIGxhbmQgbm93LgoKVGhlIHdob2xlIHRvcGljIGlzIGp1c3QgdG8g
Y29tcGxpY2F0ZWQgdGhhdCB3ZSBjYW4gMTAwJSBzdXJlIGd1YXJhbnRlZSAKdGhhdCB0aGVyZSBp
c24ndCBhbnl0aGluZyB3cm9uZyB3aXRoIHRoZSBsb2NraW5nLCBidXQgbG9ja2RlcCBhbmQgZHJp
dmVyIAp0ZXN0aW5nIHNob3VsZCBhbGxvdyB1cyB0byBxdWlja2x5IGZpbmQgcmVtYWluaW5nIGlz
c3Vlcy4KCkRvIHlvdSBoYXZlIGNvbW1pdCByaWdodHMgdG8gZHJtLW1pc2MtbmV4dCBvciBzaG91
bGQgSSBwdXNoIGl0PwoKVGhhbmtzLApDaHJpc3RpYW4uCgpBbSAzMS4wOC4yMiB1bSAxNzozNyBz
Y2hyaWViIERtaXRyeSBPc2lwZW5rbzoKPiBIZWxsbywKPgo+IFRoaXMgc2VyaWVzIG1vdmVzIGFs
bCBkcml2ZXJzIHRvIGEgZHluYW1pYyBkbWEtYnVmIGxvY2tpbmcgc3BlY2lmaWNhdGlvbi4KPiAg
RnJvbSBub3cgb24gYWxsIGRtYS1idWYgaW1wb3J0ZXJzIGFyZSBtYWRlIHJlc3BvbnNpYmxlIGZv
ciBob2xkaW5nCj4gZG1hLWJ1ZidzIHJlc2VydmF0aW9uIGxvY2sgYXJvdW5kIGFsbCBvcGVyYXRp
b25zIHBlcmZvcm1lZCBvdmVyIGRtYS1idWZzCj4gaW4gYWNjb3JkYW5jZSB0byB0aGUgbG9ja2lu
ZyBzcGVjaWZpY2F0aW9uLiBUaGlzIGFsbG93cyB1cyB0byB1dGlsaXplCj4gcmVzZXJ2YXRpb24g
bG9jayBtb3JlIGJyb2FkbHkgYXJvdW5kIGtlcm5lbCB3aXRob3V0IGZlYXJpbmcgb2YgYSBwb3Rl
bnRpYWwKPiBkZWFkbG9ja3MuCj4KPiBUaGlzIHBhdGNoc2V0IHBhc3NlcyBhbGwgaTkxNSBzZWxm
dGVzdHMuIEl0IHdhcyBhbHNvIHRlc3RlZCB1c2luZyBWaXJ0SU8sCj4gUGFuZnJvc3QsIExpbWEs
IFRlZ3JhLCB1ZG1hYnVmLCBBTURHUFUgYW5kIE5vdXZlYXUgZHJpdmVycy4gSSB0ZXN0ZWQgY2Fz
ZXMKPiBvZiBkaXNwbGF5K0dQVSwgZGlzcGxheStWNEwgYW5kIEdQVStWNEwgZG1hLWJ1ZiBzaGFy
aW5nICh3aGVyZSBhcHByb3ByaWF0ZSksCj4gd2hpY2ggY292ZXJzIG1ham9yaXR5IG9mIGtlcm5l
bCBkcml2ZXJzIHNpbmNlIHJlc3Qgb2YgdGhlIGRyaXZlcnMgc2hhcmUKPiBzYW1lIG9yIHNpbWls
YXIgY29kZSBwYXRocy4KPgo+IENoYW5nZWxvZzoKPgo+IHY0OiAtIEFkZGVkIGRtYV9idWZfbW1h
cCgpIHRvIHRoZSAibG9ja2luZyBjb252ZW50aW9uIiBkb2N1bWVudGF0aW9uLAo+ICAgICAgICB3
aGljaCB3YXMgbWlzc2VkIGJ5IGFjY2lkZW50IGluIHYzLgo+Cj4gICAgICAtIEFkZGVkIGFja3Mg
ZnJvbSBDaHJpc3RpYW4gS8O2bmlnLCBUb21hc3ogRmlnYSBhbmQgSGFucyBWZXJrdWlsIHRoYXQK
PiAgICAgICAgdGhleSBnYXZlIHRvIGNvdXBsZSB2MyBwYXRjaGVzLgo+Cj4gICAgICAtIERyb3Bw
ZWQgdGhlICJfdW5sb2NrZWQiIHBvc3RmaXggZnJvbSBmdW5jdGlvbiBuYW1lcyB0aGF0IGRvbid0
IGhhdmUKPiAgICAgICAgdGhlIGxvY2tlZCB2YXJpYW50LCBhcyB3YXMgcmVxdWVzdGVkIGJ5IENo
cmlzdGlhbiBLw7ZuaWcuCj4KPiAgICAgIC0gRmFjdG9yZWQgb3V0IHRoZSBwZXItZHJpdmVyIHBy
ZXBhcmF0aW9ucyBpbnRvIHNlcGFyYXRlIHBhdGNoZXMKPiAgICAgICAgdG8gZWFzZSByZXZpZXdp
bmcgb2YgdGhlIGNoYW5nZXMsIHdoaWNoIGlzIG5vdyBkb2FibGUgd2l0aG91dCB0aGUKPiAgICAg
ICAgZ2xvYmFsIGRtYS1idWYgZnVuY3Rpb25zIHJlbmFtaW5nLgo+Cj4gICAgICAtIEZhY3RvcmVk
IG91dCB0aGUgZHluYW1pYyBsb2NraW5nIGNvbnZlbnRpb24gZW5mb3JjZW1lbnRzIGludG8gc2Vw
YXJhdGUKPiAgICAgICAgcGF0Y2hlcyB3aGljaCBhZGQgdGhlIGZpbmFsIGRtYV9yZXN2X2Fzc2Vy
dF9oZWxkKGRtYWJ1Zi0+cmVzdikgdG8gdGhlCj4gICAgICAgIGRtYS1idWYgQVBJIGZ1bmN0aW9u
cy4KPgo+IHYzOiAtIEZhY3RvcmVkIG91dCBkbWFfYnVmX21tYXBfdW5sb2NrZWQoKSBhbmQgYXR0
YWNobWVudCBmdW5jdGlvbnMKPiAgICAgICAgaW50byBhc2VwYXJhdGUgcGF0Y2hlcywgbGlrZSB3
YXMgc3VnZ2VzdGVkIGJ5IENocmlzdGlhbiBLw7ZuaWcuCj4KPiAgICAgIC0gQ29ycmVjdGVkIGFu
ZCBmYWN0b3JlZCBvdXQgZG1hLWJ1ZiBsb2NraW5nIGRvY3VtZW50YXRpb24gaW50bwo+ICAgICAg
ICBhIHNlcGFyYXRlIHBhdGNoLCBsaWtlIHdhcyBzdWdnZXN0ZWQgYnkgQ2hyaXN0aWFuIEvDtm5p
Zy4KPgo+ICAgICAgLSBJbnRlbCBkcml2ZXIgZHJvcHBlZCB0aGUgcmVzZXJ2YXRpb24gbG9ja2lu
ZyBmZXdzIGRheXMgYWdvIGZyb20KPiAgICAgICAgaXRzIEJPLXJlbGVhc2UgY29kZSBwYXRoLCBi
dXQgd2UgbmVlZCB0aGF0IGxvY2tpbmcgZm9yIHRoZSBpbXBvcnRlZAo+ICAgICAgICBHRU1zIGJl
Y2F1c2UgaW4gdGhlIGVuZCB0aGF0IGNvZGUgcGF0aCB1bm1hcHMgdGhlIGltcG9ydGVkIEdFTS4K
PiAgICAgICAgU28gSSBhZGRlZCBiYWNrIHRoZSBsb2NraW5nIG5lZWRlZCBieSB0aGUgaW1wb3J0
ZWQgR0VNcywgdXBkYXRpbmcKPiAgICAgICAgdGhlICJkbWEtYnVmIGF0dGFjaG1lbnQgbG9ja2lu
ZyBzcGVjaWZpY2F0aW9uIiBwYXRjaCBhcHByb3ByaWF0ZWx5Lgo+Cj4gICAgICAtIFRlc3RlZCBO
b3V2ZWF1K0ludGVsIGRtYS1idWYgaW1wb3J0L2V4cG9ydCBjb21iby4KPgo+ICAgICAgLSBUZXN0
ZWQgdWRtYWJ1ZiBpbXBvcnQgdG8gaTkxNS9Ob3V2ZWF1L0FNREdQVS4KPgo+ICAgICAgLSBGaXhl
ZCBmZXcgcGxhY2VzIGluIEV0bmF2aXYsIFBhbmZyb3N0IGFuZCBMaW1hIGRyaXZlcnMgdGhhdCBJ
IG1pc3NlZAo+ICAgICAgICB0byBzd2l0Y2ggdG8gbG9ja2VkIGRtYS1idWYgdm1hcHBpbmcgaW4g
dGhlIGRybS9nZW06IFRha2UgcmVzZXJ2YXRpb24KPiAgICAgICAgbG9jayBmb3Igdm1hcC92dW5t
YXAgb3BlcmF0aW9ucyIgcGF0Y2guIEluIGEgcmVzdWx0IGludmFsaWRhdGVkIHRoZQo+ICAgICAg
ICBDaHJpc3RpYW4ncyByLWIgdGhhdCBoZSBnYXZlIHRvIHYyLgo+Cj4gICAgICAtIEFkZGVkIGxv
Y2tlZCBkbWEtYnVmIHZtYXAvdnVubWFwIGZ1bmN0aW9ucyB0aGF0IGFyZSBuZWVkZWQgZm9yIGZp
eGluZwo+ICAgICAgICB2bWFwcHBpbmcgb2YgRXRuYXZpdiwgUGFuZnJvc3QgYW5kIExpbWEgZHJp
dmVycyBtZW50aW9uZWQgYWJvdmUuCj4gICAgICAgIEkgYWN0dWFsbHkgaGFkIHRoaXMgY2hhbmdl
IHN0YXNoZWQgZm9yIHRoZSBkcm0tc2htZW0gc2hyaW5rZXIgcGF0Y2hzZXQsCj4gICAgICAgIGJ1
dCB0aGVuIHJlYWxpemVkIHRoYXQgaXQncyBhbHJlYWR5IG5lZWRlZCBieSB0aGUgZG1hLWJ1ZiBw
YXRjaGVzLgo+ICAgICAgICBBbHNvIGltcHJvdmVkIG15IHRlc3RzIHRvIGJldHRlciBjb3ZlciB0
aGVzZSBjb2RlIHBhdGhzLgo+Cj4gdjI6IC0gQ2hhbmdlZCBsb2NraW5nIHNwZWNpZmljYXRpb24g
dG8gYXZvaWQgcHJvYmxlbXMgd2l0aCBhIGNyb3NzLWRyaXZlcgo+ICAgICAgICB3dyBsb2NraW5n
LCBsaWtlIHdhcyBzdWdnZXN0ZWQgYnkgQ2hyaXN0aWFuIEvDtm5pZy4gTm93IHRoZSBhdHRhY2gv
ZGV0YWNoCj4gICAgICAgIGNhbGxiYWNrcyBhcmUgaW52b2tlZCB3aXRob3V0IHRoZSBoZWxkIGxv
Y2sgYW5kIGV4cG9ydGVyIHNob3VsZCB0YWtlIHRoZQo+ICAgICAgICBsb2NrLgo+Cj4gICAgICAt
IEFkZGVkICJsb2NraW5nIGNvbnZlbnRpb24iIGRvY3VtZW50YXRpb24gdGhhdCBleHBsYWlucyB3
aGljaCBkbWEtYnVmCj4gICAgICAgIGZ1bmN0aW9ucyBhbmQgY2FsbGJhY2tzIGFyZSBsb2NrZWQv
dW5sb2NrZWQgZm9yIGltcG9ydGVycyBhbmQgZXhwb3J0ZXJzLAo+ICAgICAgICB3aGljaCB3YXMg
cmVxdWVzdGVkIGJ5IENocmlzdGlhbiBLw7ZuaWcuCj4KPiAgICAgIC0gQWRkZWQgYWNrIGZyb20g
VG9tYXN6IEZpZ2EgdG8gdGhlIFY0TCBwYXRjaGVzIHRoYXQgaGUgZ2F2ZSB0byB2MS4KPgo+IERt
aXRyeSBPc2lwZW5rbyAoMjEpOgo+ICAgIGRtYS1idWY6IEFkZCB1bmxvY2tlZCB2YXJpYW50IG9m
IHZtYXBwaW5nIGZ1bmN0aW9ucwo+ICAgIGRtYS1idWY6IEFkZCB1bmxvY2tlZCB2YXJpYW50IG9m
IGF0dGFjaG1lbnQtbWFwcGluZyBmdW5jdGlvbnMKPiAgICBkcm0vZ2VtOiBUYWtlIHJlc2VydmF0
aW9uIGxvY2sgZm9yIHZtYXAvdnVubWFwIG9wZXJhdGlvbnMKPiAgICBkcm0vcHJpbWU6IFByZXBh
cmUgdG8gZHluYW1pYyBkbWEtYnVmIGxvY2tpbmcgc3BlY2lmaWNhdGlvbgo+ICAgIGRybS9hcm1h
ZGE6IFByZXBhcmUgdG8gZHluYW1pYyBkbWEtYnVmIGxvY2tpbmcgc3BlY2lmaWNhdGlvbgo+ICAg
IGRybS9pOTE1OiBQcmVwYXJlIHRvIGR5bmFtaWMgZG1hLWJ1ZiBsb2NraW5nIHNwZWNpZmljYXRp
b24KPiAgICBkcm0vb21hcGRybTogUHJlcGFyZSB0byBkeW5hbWljIGRtYS1idWYgbG9ja2luZyBz
cGVjaWZpY2F0aW9uCj4gICAgZHJtL3RlZ3JhOiBQcmVwYXJlIHRvIGR5bmFtaWMgZG1hLWJ1ZiBs
b2NraW5nIHNwZWNpZmljYXRpb24KPiAgICBkcm0vZXRuYXZpdjogUHJlcGFyZSB0byBkeW5hbWlj
IGRtYS1idWYgbG9ja2luZyBzcGVjaWZpY2F0aW9uCj4gICAgUkRNQS91bWVtOiBQcmVwYXJlIHRv
IGR5bmFtaWMgZG1hLWJ1ZiBsb2NraW5nIHNwZWNpZmljYXRpb24KPiAgICBtaXNjOiBmYXN0cnBj
OiBQcmVwYXJlIHRvIGR5bmFtaWMgZG1hLWJ1ZiBsb2NraW5nIHNwZWNpZmljYXRpb24KPiAgICB4
ZW4vZ250ZGV2OiBQcmVwYXJlIHRvIGR5bmFtaWMgZG1hLWJ1ZiBsb2NraW5nIHNwZWNpZmljYXRp
b24KPiAgICBtZWRpYTogdmlkZW9idWYyOiBQcmVwYXJlIHRvIGR5bmFtaWMgZG1hLWJ1ZiBsb2Nr
aW5nIHNwZWNpZmljYXRpb24KPiAgICBtZWRpYTogdGVncmEtdmRlOiBQcmVwYXJlIHRvIGR5bmFt
aWMgZG1hLWJ1ZiBsb2NraW5nIHNwZWNpZmljYXRpb24KPiAgICBkbWEtYnVmOiBNb3ZlIGRtYV9i
dWZfdm1hcCgpIHRvIGR5bmFtaWMgbG9ja2luZyBzcGVjaWZpY2F0aW9uCj4gICAgZG1hLWJ1Zjog
TW92ZSBkbWFfYnVmX2F0dGFjaCgpIHRvIGR5bmFtaWMgbG9ja2luZyBzcGVjaWZpY2F0aW9uCj4g
ICAgZG1hLWJ1ZjogTW92ZSBkbWFfYnVmX21hcF9hdHRhY2htZW50KCkgdG8gZHluYW1pYyBsb2Nr
aW5nCj4gICAgICBzcGVjaWZpY2F0aW9uCj4gICAgZG1hLWJ1ZjogTW92ZSBkbWFfYnVmX21tYXAo
KSB0byBkeW5hbWljIGxvY2tpbmcgc3BlY2lmaWNhdGlvbgo+ICAgIGRtYS1idWY6IERvY3VtZW50
IGR5bmFtaWMgbG9ja2luZyBjb252ZW50aW9uCj4gICAgbWVkaWE6IHZpZGVvYnVmMjogU3RvcCB1
c2luZyBpbnRlcm5hbCBkbWEtYnVmIGxvY2sKPiAgICBkbWEtYnVmOiBSZW1vdmUgb2Jzb2xldGVk
IGludGVybmFsIGxvY2sKPgo+ICAgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2RtYS1idWYucnN0
ICAgICAgICAgIHwgICA2ICsKPiAgIGRyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgICAgICAgICAg
ICAgICAgICAgICB8IDIxMSArKysrKysrKysrKysrKystLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
cm1hZGEvYXJtYWRhX2dlbS5jICAgICAgICAgICB8ICAgOCArLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2RybV9jbGllbnQuYyAgICAgICAgICAgICAgICAgIHwgICA0ICstCj4gICBkcml2ZXJzL2dwdS9k
cm0vZHJtX2dlbS5jICAgICAgICAgICAgICAgICAgICAgfCAgMjQgKysKPiAgIGRyaXZlcnMvZ3B1
L2RybS9kcm1fZ2VtX2RtYV9oZWxwZXIuYyAgICAgICAgICB8ICAgNiArLQo+ICAgZHJpdmVycy9n
cHUvZHJtL2RybV9nZW1fZnJhbWVidWZmZXJfaGVscGVyLmMgIHwgICA2ICstCj4gICBkcml2ZXJz
L2dwdS9kcm0vZHJtX2dlbV90dG1faGVscGVyLmMgICAgICAgICAgfCAgIDkgKy0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9kcm1fcHJpbWUuYyAgICAgICAgICAgICAgICAgICB8ICAgNiArLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9nZW1fcHJpbWUuYyAgIHwgICAyICstCj4gICBk
cml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fZG1hYnVmLmMgICAgfCAgIDIgKy0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9pOTE1L2dlbS9pOTE1X2dlbV9vYmplY3QuYyAgICB8ICAxMiArCj4g
ICAuLi4vZHJtL2k5MTUvZ2VtL3NlbGZ0ZXN0cy9pOTE1X2dlbV9kbWFidWYuYyAgfCAgMTYgKy0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9saW1hL2xpbWFfc2NoZWQuYyAgICAgICAgICAgICB8ICAgNCAr
LQo+ICAgZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vb21hcF9nZW1fZG1hYnVmLmMgICAgIHwgICA0
ICstCj4gICBkcml2ZXJzL2dwdS9kcm0vcGFuZnJvc3QvcGFuZnJvc3RfZHVtcC5jICAgICAgfCAg
IDQgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9wYW5mcm9zdC9wYW5mcm9zdF9wZXJmY250LmMgICB8
ICAgNiArLQo+ICAgZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfb2JqZWN0LmMgICAgICAgICAgICAg
IHwgIDE3ICstCj4gICBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9wcmltZS5jICAgICAgICAgICAg
ICAgfCAgIDQgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS9nZW0uYyAgICAgICAgICAgICAg
ICAgICB8ICAxNyArLQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdW1lbV9kbWFidWYuYyAg
ICAgICAgIHwgICA3ICstCj4gICAuLi4vY29tbW9uL3ZpZGVvYnVmMi92aWRlb2J1ZjItZG1hLWNv
bnRpZy5jICAgfCAgMjIgKy0KPiAgIC4uLi9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVvYnVm
Mi1kbWEtc2cuYyB8ICAxOSArLQo+ICAgLi4uL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLXZt
YWxsb2MuYyAgICAgIHwgIDE3ICstCj4gICAuLi4vcGxhdGZvcm0vbnZpZGlhL3RlZ3JhLXZkZS9k
bWFidWYtY2FjaGUuYyAgfCAgIDYgKy0KPiAgIGRyaXZlcnMvbWlzYy9mYXN0cnBjLmMgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNiArLQo+ICAgZHJpdmVycy94ZW4vZ250ZGV2LWRtYWJ1Zi5j
ICAgICAgICAgICAgICAgICAgIHwgICA4ICstCj4gICBpbmNsdWRlL2RybS9kcm1fZ2VtLmggICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKwo+ICAgaW5jbHVkZS9saW51eC9kbWEtYnVmLmgg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDE3ICstCj4gICAyOSBmaWxlcyBjaGFuZ2VkLCAzMTgg
aW5zZXJ0aW9ucygrKSwgMTU1IGRlbGV0aW9ucygtKQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
