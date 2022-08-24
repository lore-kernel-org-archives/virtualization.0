Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBC6C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 15:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A396040B9A;
	Wed, 24 Aug 2022 15:14:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A396040B9A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Vvgg9Zcz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pdl4KR2_bhfm; Wed, 24 Aug 2022 15:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0715140B99;
	Wed, 24 Aug 2022 15:14:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0715140B99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EB89C0032;
	Wed, 24 Aug 2022 15:14:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDFD7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 15:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 236FB60FA1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 15:14:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 236FB60FA1
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Vvgg9Zcz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mckcnFmsNvec
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 15:14:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8408260F84
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8408260F84
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 15:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0+UXBSn5GmZNTTk2zxY71PiGgQ9yZosLbctGVou41h/c/M0WJb5ZHeIsgi2MXft2xW9lCMWsAj5AUzA+m3EFTOjuFo6jtqqpqJj05yGI+tJV2nruvJ172b4bMwYD/gzOo/OnSYBSiabpS/pO/1X0x8tecj8BkTg9vj7C1G8piQEeYRN+RjHPzaC7c1MN+ujICVr+e2ltHAGP/FXdnPDAVEYkaVMo1S3r9VPdHvsHQnq/h7uie0XwNBc1MYwsA4DLM4Ht/EI0YoWTXE8JLUwQX2lu43PZps4oVeUZXRosFHB+LhR7+rx5EMc382bk6UIY29FIJbBW6N0BS9DNrYmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5SY9ujaA7usTkk7gToKXOqDilPtvt3VKfLudeAnnG8=;
 b=lXYwQcuYTYIMyfN+1GQX059tqv8hDQaH7BgNgINDHugU9Rkd0U/PkWX5iiV3YVMPBXcxdfz+VLCKDw0ZM6qLI1dRNx2/XO34bQ5KuB5e4AtR9nNPFfL1WSwzLJZNnZkfWyhKnoGD5hnoFK/jI0CHfpC9Iolj4E/ULQTj7i54HrVkC7Xd2JhDBgTW3Xmd/d9qx75g3jUD5czHjvHmDMNEXREp/EhOPaCLRO90aNl5zumX0Jc1Qct+M954DBE21+yj1g5HCGiC9F6JWB2CctGE2x68fQXO6Ho687EKuN5fVnmBailNk2I10HMna5UDrQfAAz7J7V/z0sfp+6lh8efhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5SY9ujaA7usTkk7gToKXOqDilPtvt3VKfLudeAnnG8=;
 b=Vvgg9ZczJlIn53Vz66AKTxxuklOiFzTdv88D3sNP6QfM0HpQ8YjcbytxHfEJK+iGhiJLIykNFm6dk6DZzMksYdQwyoYN7+rkp+Lr9BxOBXEveDrKHj1wpwS5VhuNC5hz/iii/6uCeDNMLQzvllBBdPFKlbdrm4XGcFbtmCzDP0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 15:14:19 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 15:14:19 +0000
Message-ID: <b24017e9-e8e7-148e-951b-0f2a1dffdca7@amd.com>
Date: Wed, 24 Aug 2022 17:14:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 6/9] dma-buf: Move dma-buf attachment to dynamic
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
 Qiang Yu <yuq825@gmail.com>
References: <20220824102248.91964-1-dmitry.osipenko@collabora.com>
 <20220824102248.91964-7-dmitry.osipenko@collabora.com>
 <17181951-1b40-cd39-48df-58b43cad117d@amd.com>
 <4af793fd-eccc-ad70-65c3-de78dced71f0@collabora.com>
In-Reply-To: <4af793fd-eccc-ad70-65c3-de78dced71f0@collabora.com>
X-ClientProxiedBy: AS9PR06CA0779.eurprd06.prod.outlook.com
 (2603:10a6:20b:484::34) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c93b672-f75f-441d-4ef5-08da85e35134
X-MS-TrafficTypeDiagnostic: BL3PR12MB6522:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5952XXswQsal3yy/8+uNHa8DqdXW4QJaU/70c9mke1Oc+UC4xPgEFrPtZpV3oRLq4y0fDz48SL6PBB/VwM28/nzPEneLnC7Hih0x6crC4Qmzo0iHh7W4XgoKeN3zTNfrSygn3ch0n7EOAqhJWx+aO7zqIyoSyG/02mklL2PztN+bF+6wv1BB7bkTEH9a2xUJhyQa2kNQ9XlgVYSuX8TcMzgHYY89kFk7nGBArsHRZw+M/PTbHGLlk9xl7s5MF7VOLQVFLbTf5c+kuLyIl4SqGjBuLMr55SyZ9NaujBEo6pmMKWiAEUUdXGenX7p92CVMd0s1GTCl3GU705p+yyBxKAgknrda6cXTPdsEIqN7Wc7d1vnOW5fI2NoCjBVQyh1j4Jo6vBMgXVIv4fRWKtRxs98u0VDT3la0/RaK1jR6ZeBgY+tUNzpJElvtxDGfBnUDF1vDSOvjj/G5OWI36gatkn0MWcXJ8+QzxID6A4217RdBXqNMY3lfLVqLVrWmVHeK1askVKsHCEMGyVcj2VS8+VXfuD/LLiwgCVTEGQ20u7Qb7yI0JlE0GimSMH9bHUWZIBAOzUaRU0xEyYgurBzW0B6XStjKdbeuVWjqefoihye2vcIetYSteLXEOlWcaIALlRTRo2AO7RoEdNs6ixzGp0e87wpyxZVF4e3e+TWr5U/kMX0VwqSFlRxyCobgBa+3YDLrl1NMsqrSriwLcTM1ghyptlsPUzpeV6xRkQf1XVqhuDzTtelXqc8DnRp/SWHr98VDb0mGuivb/RZ5dFu+BbJXhYJMfqkk6aHdmuM5lP3gyT/C07rllnqVSifzMI5v+ok7EWI0/Br+Fe1n5VP++IcsK6JSvsjVGRUzKhT21g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(53546011)(478600001)(31686004)(966005)(6486002)(6666004)(6512007)(38100700002)(186003)(2616005)(7416002)(8936002)(5660300002)(4326008)(7406005)(921005)(36756003)(66556008)(66476007)(2906002)(66574015)(6506007)(86362001)(31696002)(66946007)(45080400002)(110136005)(8676002)(83380400001)(316002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjBhZkdJWStxSmFhaXhUUG9nakdhbnVZS05RcTI3aE1uNVFoK2g4amcvelNK?=
 =?utf-8?B?dHJxQjBqYk9PcWdGYkVScy9hc3hmeTdMdW9wS3p5aEZIdnBaU0dPUURIZTFh?=
 =?utf-8?B?KzdWbE1mWmxLaHMxT1llYlJiTzBUZDBLdDhEWXRvaGNiSzJQM1VkcWx1ZEh2?=
 =?utf-8?B?aGVVeVJZSFF0eno1VlJ4cVo4ZG1Dem9CNkl1Rm95clprQnhJaEFVM3EzSFlS?=
 =?utf-8?B?OHh6SkNCUmRjK2w4MlRVbm45ZkdZdG01czF0R3g2aTgrNHdzV2RCTGlEdUs2?=
 =?utf-8?B?RDVvbTNQZ2R1RW5iUWhOUzk0dXBPM1NUM0JuZWp2TnFObVV1SVFUWTBMTy9C?=
 =?utf-8?B?MWxFaGdCYzZmZVlTdlY2TUs3Z1BxT3psRUpOK1o4UUxwZ0ZIQTNISWJYK3JY?=
 =?utf-8?B?NDVnMFhkRVNGZjdPWkR0OVovWURScVpjOEg2cHpiZUM3YnVyMktrdkhYOWVY?=
 =?utf-8?B?MlJEbjRvU0ZuV0h6UXRnZTRDRDZrQTROWjlJOFJ4Ty8zOW9iK05xcHJ6Z2Nv?=
 =?utf-8?B?YnFOS05HVWNwODlaby9jZ25rZit2Vjhqc1JZVzRBRFdRUWhFbXV2TWRMMjZx?=
 =?utf-8?B?bTB0NVNVWHJ5blpBcVZ1S3REY2ZkM29ObGZHdTQ4Ym1TODAzSWIvM0dzYXVV?=
 =?utf-8?B?L3ZTMXJjc3JBczhuckRCRWlkbk95bXltR3hpaVpGZXpIK21vSWZMQzJDZWNE?=
 =?utf-8?B?Y3Z3K1BhWGszanRmZ0ZmdDZWbEVrSlNnK0FiTnFmcXoxNFZOQlBMeDN6WnZu?=
 =?utf-8?B?MnNwSnBwSHZoc2ZXNHAyMUpuR1VDczFxc1kvRXBqeStCc2R3ay9WRlU3c1Yz?=
 =?utf-8?B?bS95L3RsU054WEFUYkg4ZFJEbFhka1YxZXdOcG9ySWR1eE1SZXZJWVBlVnlo?=
 =?utf-8?B?dWZaMTZUamNNaVdvcUVUUUlMd0ZIVGZTTUd5QjJvdDlSVU9qKzNuUUtQM3ZU?=
 =?utf-8?B?QXdGVTFsTFBOWXAzeTA1Ri85dm5TNVBYVFZRZSsrdW1iSEhiVFoxaWowMU9l?=
 =?utf-8?B?c3YvekRFVjhSYmFhdkZjYnJwOGZ2aXUvV1pFS2pmU2FvaUNndDJOeFJhT0Iv?=
 =?utf-8?B?Nk5kaXdnVmlsRFJaV3phWE0xNGV2Y2RXYWZzT0IydjBsb202NEpLL0RITVdv?=
 =?utf-8?B?cmZMaWFUbUFjUlBkRnNwVEdHUkN4Um9YRC9PTElycTlYdUp3OWRzWURKMXRZ?=
 =?utf-8?B?bXpxb2lDcmViSmMwV05DRjg3cVRJcHVpOWU0Z0s0dGRxeUtjQUc2L0pMU3A2?=
 =?utf-8?B?MkZTVUQ1Zmt5Q3Z5QklWME03cWI3TnlxM0ZxamtndmJUUGZNUENxOVFmaE5z?=
 =?utf-8?B?MitTOU9BODR4UC9Ya3RsUS9CaitUQUJncEZBRTR4SWl2NGZyTVNTRk5POHJh?=
 =?utf-8?B?VHdHNHN2alhIaDJUV1l6MTViTU9zT0lGdWQzcUlWcmEzNCtEa1RwY24rQWNz?=
 =?utf-8?B?OXB6U2ljWm8rMHJXeXdBbTZsVzZkTG5uNUp1NTlwQ0x5c0FTaDNYM28veGNp?=
 =?utf-8?B?Si81NCs2MGlxSGlaOHFnOGx6dVR4U0ZGOUFFRmJUNDdxRWpvVmFvSU1VME1X?=
 =?utf-8?B?cUN3T2JPT1pNd2FZVWhWSkFkNGVMRGNXT2VNSmdsUEJRTEV6aytRZnhqRDkz?=
 =?utf-8?B?ZHlPWXFFZkVuOGlCcEFzVEFSb3VEcUcvNEpkT09mSFFMeHRrRmQ3WVJCWkpL?=
 =?utf-8?B?bzg5RjlHUG4xbjZYYzBIME9ROXBKUm54TUFOak56em9LYTQ1cDM3Q05RdktF?=
 =?utf-8?B?ZEZKK3FIamdkQmFsWFRoUGxxN0RUSGNpaWt0eGVJQVhUTkoxN1FwbTVHbEVF?=
 =?utf-8?B?ZXlnSlVUWmhOb2JSUktxQUdLZFdhRzYzczZ0RDlKNjV5RFhWOEpHNjhmcGdT?=
 =?utf-8?B?NjNqVDEraEF5NW5SODVDa3grbS8yUnRXQ2Q5d1lXSUJxMTNsa1RKd093bGxq?=
 =?utf-8?B?amFIRFFZMWs2NUgva0ZKd0lOWFZENEdpR1VOdjI3dWlqcG5tQUMrLzRpNjZR?=
 =?utf-8?B?RGs2RTBhYmRCS0tzVHJUb2pLaVphVmduRjJyMkFaM0VaUEI0R1IrSkNoYkFz?=
 =?utf-8?B?MG1hMFFvelBDeXhXMzE4a0lOcXFXV21ac254aHNlaEUvclNVc2lhd3ZJQ3U5?=
 =?utf-8?B?eGJwN0xvZVVLa1VvSE9uVVM4R3pWdUt5eFhDeExhUmFUTTZ3aFpZUnNxdlZK?=
 =?utf-8?Q?vIA6hCC7e4rr87rt/6IMrv2fDizU2Enk4ZL90Kyj3HtY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c93b672-f75f-441d-4ef5-08da85e35134
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 15:14:19.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rELvdTfsR8Nagcz1LvQsbfvq3akTKCvOC/9qmV8ayW/5Q9ebkATkm+Hbkf75G6zh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

QW0gMjQuMDguMjIgdW0gMTc6MDMgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gT24gOC8yNC8y
MiAxNzowOCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMjQuMDguMjIgdW0gMTI6MjIg
c2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4+PiBNb3ZlIGRtYS1idWYgYXR0YWNobWVudCBBUEkg
ZnVuY3Rpb25zIHRvIHRoZSBkeW5hbWljIGxvY2tpbmcKPj4+IHNwZWNpZmljYXRpb24uCj4+PiBU
aGUgc3RyaWN0IGxvY2tpbmcgY29udmVudGlvbiBwcmV2ZW50cyBkZWFkbG9jayBzaXR1YXRpb25z
IGZvciBkbWEtYnVmCj4+PiBpbXBvcnRlcnMgYW5kIGV4cG9ydGVycy4KPj4+Cj4+PiBQcmV2aW91
c2x5LCB0aGUgInVubG9ja2VkIiB2ZXJzaW9ucyBvZiB0aGUgYXR0YWNobWVudCBBUEkgZnVuY3Rp
b25zCj4+PiB3ZXJlbid0IHRha2luZyB0aGUgcmVzZXJ2YXRpb24gbG9jayBhbmQgdGhpcyBwYXRj
aCBtYWtlcyB0aGVtIHRvIHRha2UKPj4+IHRoZSBsb2NrLgo+PiBEaWRuJ3Qgd2UgY29uY2x1ZGVk
IHRoYXQgd2UgbmVlZCB0byBrZWVwIHRoZSBhdHRhY2ggYW5kIGRldGFjaCBjYWxsYmFja3MKPj4g
d2l0aG91dCB0aGUgbG9jayBhbmQgb25seSBtb3ZlIHRoZSBtYXAvdW5tYXAgY2FsbGJhY2tzIG92
ZXI/Cj4+Cj4+IE90aGVyd2lzZSBpdCB3b24ndCBiZSBwb3NzaWJsZSBmb3IgZHJpdmVycyB0byBs
b2NrIG11bHRpcGxlIGJ1ZmZlcnMgaWYKPj4gdGhleSBoYXZlIHRvIHNodWZmbGUgdGhpbmdzIGFy
b3VuZCBmb3IgYSBzcGVjaWZpYyBhdHRhY2htZW50Lgo+IFdlIGRpZCBjb25jbHVkZSB0aGF0LiBU
aGUgYXR0YWNoL2RldGFjaCBkbWEtYnVmIG9wcyBhcmUgdW5sb2NrZWQsIGJ1dAo+IHRoZSBtYXBf
ZG1hX2J1Zi91bm1hcF9kbWFfYnVmIG11c3QgYmUgaW52b2tlZCB1bmRlciBsb2NrIGFuZAo+IGRt
YV9idWZfZHluYW1pY19hdHRhY2hfdW5sb2NrZWQoKSBtYXBzIGRtYS1idWYgaWYgZWl0aGVyIGlt
cG9ydGVyIG9yCj4gZXhwb3J0ZXIgY2FuJ3QgaGFuZGxlIHRoZSBkeW5hbWljIG1hcHBpbmcgWzFd
LgoKQWghIFlvdSBhcmUgY29uZnVzaW5nIG1lIG92ZXIgYW5kIG92ZXIgYWdhaW4gd2l0aCB0aGF0
IDopCgpPayBpbiB0aGlzIGNhc2UgdGhhdCBoZXJlIGlzIGZpbmUsIEkganVzdCBuZWVkIHRvIHJl
LXJlYWQgdGhlIHBhdGNoLgoKVGhhbmtzLApDaHJpc3RpYW4uCgo+Cj4gWzFdCj4gaHR0cHM6Ly9u
YW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
ZWxpeGlyLmJvb3RsaW4uY29tJTJGbGludXglMkZ2Ni4wLXJjMiUyRnNvdXJjZSUyRmRyaXZlcnMl
MkZkbWEtYnVmJTJGZG1hLWJ1Zi5jJTIzTDg2OSZhbXA7ZGF0YT0wNSU3QzAxJTdDY2hyaXN0aWFu
LmtvZW5pZyU0MGFtZC5jb20lN0NkZjIzZDg5ZGI4Yjg0YmY2ZDRjMDA4ZGE4NWUxZGM2YyU3QzNk
ZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc5Njk1MDI0NDEwMjY5
OTElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYy
bHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7
c2RhdGE9ZDhrV0tqRENGbiUyQjNLbUsxMzVHY3Y2JTJGTUxmZkVZY2lwb3VxV3hmYyUyQktYTSUz
RCZhbXA7cmVzZXJ2ZWQ9MAo+Cj4gSGVuY2UgSSByZS1hcnJhbmdlZCB0aGUgZG1hX3Jlc3ZfbG9j
aygpIGluCj4gZG1hX2J1Zl9keW5hbWljX2F0dGFjaF91bmxvY2tlZCgpIHRvIG1vdmUgYm90aCBw
aW5uaW5nIGFuZCBtYXBwaW5nIHVuZGVyCj4gdGhlIGhlbGQgbG9jay4KPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
