Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F64ECAAD1
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 07:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E217404A5;
	Thu,  1 Sep 2022 07:08:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E217404A5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=m9ukBm8V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N_iPE2phw6P5; Thu,  1 Sep 2022 07:08:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F819402D7;
	Thu,  1 Sep 2022 07:08:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F819402D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C99EC0032;
	Thu,  1 Sep 2022 07:08:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 467A0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:08:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06483404D5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:08:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06483404D5
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=m9ukBm8V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iDWiOvoLc-ZO
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:08:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C92B3401C2
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C92B3401C2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql/KZU/ARogmc3djY7zEHYdjTsEqbz8aJy++asQ6RR17I1KklOYnATOIM5RRI229ggZke5AmEOmzxnOmrUvDPvrlEWSXY6V2M1OcCv7HznMvPQClrPJtQk2wX9H5kqdw03gU+sIZ/aYosmwQBxdBrBXn2Gx84y0/jyu3bWFbCcJpq05tUElppOScz8xUMrivpGNlUcioumEGS8DVLp42g5M28TIoBBMtFjuvhtfzMAmm/+u4PXzwl1Ifyu7OlmVAYCWXbL8Bxfks/JEW0FjxF7vacozpYgzosWAxeLsnYcgHvrI8vaDeyc77IwE41Qg4lpXJ3BoJRdMi1VS8ie4MJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYrS77+HQPJHoGzaw8g5OgzEBMpUsCYp7gFxAxTLWuk=;
 b=hWeM6gBbr/S1fwMI1sIomm/5U8ws/75v5ILUZeDLK661R2cf1PELBZDbaqU07vxJNEXnTV6f0G+uYbmEaWj8NBgKimQ2dGFmzuNV7UrzhKR52WenktWrcFQlugPWOBon5eq/+fcXefXvbZccrmRB61Mzlt+Wqny7TE4omew6LRyPLmmglASr1Xuj3A7d9idS9T+zLUX70NR2LY1HAljhG7StjGeLwJXWsalLGg3PuaKph7580888K9DX6Lwo352IM9Rhw+0S/uuHq+ZKlkmt8aTzGLnGWwL1MNG+SGeyyIIARdJIS/V9J3zFpqwLTPVwC/SEFY2orCNgsWmMhIXpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYrS77+HQPJHoGzaw8g5OgzEBMpUsCYp7gFxAxTLWuk=;
 b=m9ukBm8VR0C+D8Ryqo4p+ZlcAg9mBaDAczVNLu54bCUZCPRMEt8A05MsXLVr5uC4nW/adh+pR6ODmFCL4Iy/A3aUhjyO44q7rkM3Kk9a6HEjTr5rp/K2Gdh+/LaZ+AbR2tr3eRSzXNPINcz8jOadJ+s7O8Umgqc8r78bwHIzlFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 07:08:50 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 07:08:50 +0000
Message-ID: <12ad2b83-212b-8a7d-e10f-32543024974b@amd.com>
Date: Thu, 1 Sep 2022 09:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 17/21] dma-buf: Move dma_buf_map_attachment() to
 dynamic locking specification
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
 <20220831153757.97381-18-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-18-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AM6P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::27) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa757217-b21b-42f1-4e0f-08da8be8d1e3
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQPZTLmke1dWgktwLEcxUjzQPs+7LTz66Nq2Vdt7Q+AS35p1lIzXr+s7DI5jd9ctfAul+KTseKPYw8t4DyhAlCbxopHZxjtfKCAgW9cfH/E6kZLoSIyWteJAT1ol2lrRKL3bRRxIzING/d9vqSffRIdexxPi/XAZ4BJgYnv1RvXiUBkSJ6jtJdTBRUfVX9Oj6ced5kBMbL4oOS5n3JYMw3LJgIa3t0VAEL7yVnWid+7Cioru2GBPXPhYvTjVuebdZ2xsUaDcRdLwIIrnzwPweEn3Q08uNNW31mX6QskY62BWmPGwAuSztm5HOGHrBzZk8TWqZnDk7geNgLH4TfYZ/6rYOIWdkAFcKINYtNxlH0srUvkvwVA6C8T9c2jRHX66QrCI1iyYA2sDZgzpp2GhXvIpuZ3TeVF67a/vpZlihGvIBHdBtwFQJvkugeBXvYopYMsfcQp9kvN3D0TEVruit+MezAIpWoq1Zg1OD7ql+34xcd+ZpuJ12/faExGzUB/2jDT1k+TFxD9zyb0vUtLaJURfptm+/9W3jJFMNJI0Ev6W3zxhIU3l/htI36breAsch7k8nYErFTk/ql+C+w7k9UoiHhHvMGygGA2uE5wHWOwPbpRD5S+PIoeETdjg9IvwVdYAMnPNoh4QLEEbYDK1kUnEsMf4ZXrXoffsZV5zfu0akFxIyixI9oEnMGj0GMLi4htG6e8WF5vkLXkc+gQMz8Ez6dxyQHaJ7K/v20oauOodSJs3MoDDuzTKnRnE1MZnCP3Eixq0RAno1z4Xb5sd8ia9Ndk2+bvjlNUMp328bxvAZaQ4F79WuFA3s9zQho5/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(83380400001)(38100700002)(66556008)(110136005)(316002)(66476007)(4326008)(8676002)(66946007)(478600001)(36756003)(6486002)(31686004)(6666004)(5660300002)(8936002)(41300700001)(921005)(31696002)(86362001)(2616005)(66574015)(186003)(7416002)(7406005)(26005)(6506007)(2906002)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkFhcTc0Q05IN0lFTjRFZDFPcHZyZTdBR0l2OWoxTEJWMHgxdHZEMTZYdzFh?=
 =?utf-8?B?N1d6SGRTeHZiV1pqd3l1dlJsK2pCM3FqcGNEM1NOOExPSVlJbENmMVVkOEZ3?=
 =?utf-8?B?Zm1DUitDMVVQNXVkUWIxU2NWajNwNjArUXlscFlWT2FIVFdTK1p6R0RwSkh0?=
 =?utf-8?B?OWo1cFY2Z3ovWXdBZ2NTSHd0TkFYaGNZTVl6dCtYcEx6LzArWGtBQmlPQlJh?=
 =?utf-8?B?dVN1QjJOb2w0WDNGN2ZUSzRrUjR3YjYzbTY5SDNzWHhaRFlsa2Fqd3MyMmZU?=
 =?utf-8?B?K21qWG5iMDBEQ2pUVkFNcnhod0c0QWtXMytFRUVab0h2ZURMcTIvNElDYkRi?=
 =?utf-8?B?NXpGclB2M2hmZlVGajY2Z2lKdW5xajVKQ2p0K2VZdFFXVVc0UjNYUm1ZNldq?=
 =?utf-8?B?eEhoNG0yMnlZK0E5dys1cENjS0l2S0xVdGtONnBEL09VKzNLM2p5WEtWRVpX?=
 =?utf-8?B?Qi9aL1V6aVh2ODVpYkNQS2ZJSXR5L1F5NU1LMDBhbzVNMFRsM2E1Y1N0MjVV?=
 =?utf-8?B?WTF2clE1TU9KaVFJcGJxZVJsMTM0NU1Fb0N5KytaeUxQN2ZWSmw0RTZacmZw?=
 =?utf-8?B?bklCZm1xWVdQbEpVSW1rYnYveW9DUDl2VTdrdHVKMXlQR3FmSjVjYnBYdkh3?=
 =?utf-8?B?ZU9helMzQldPQnpVTnJUSEU5aWpMZjBDaThZdjI0K3htb2RacVY1eitTS24w?=
 =?utf-8?B?NjdIMzNZZGJOUTJRZ2pIUkl4MVRLM1RSdWtUTkwxL04rUFgzbEowNW1zVEtT?=
 =?utf-8?B?ajJhTS80dkhuUDdoQ0tFWGF6RFd3V0VaWGJSUzBQMVA2QXI1MlIvZlJMVkgw?=
 =?utf-8?B?S1huSk1Xcit0Y01XRmZmOHc0bTVwQXJ4RmZkZFgzSFc2Zk9WTU44QVM2Z1k5?=
 =?utf-8?B?U2xHWU1lVTc4T2tPN3pGaGdBeWlyLyt1SjFEckdZVGlTMmsxd08yam0wV1pB?=
 =?utf-8?B?THE3UzRKYmEzWmw1OG1JWjA3NnUvSGgvSWIwNGlIZ2F5ZGVjUVZrK1ZkdzhG?=
 =?utf-8?B?OEFYL0ZSL05sYjF0NVRiNFhYVjR3c3Frcm9SYmdhOGV4a05oUEVQdVdiQVFF?=
 =?utf-8?B?RXhGQXd1OUdTTWd3Y2hrTHlxRVVkY0h5dG5tcUdLUFlINkNWZ3Zpd1pqWWFt?=
 =?utf-8?B?dnk2QWx3dG9naVVIK2k1K3VxdHc1UjhMTUxsY0RJTElhVUhuekE4dGxzaE5h?=
 =?utf-8?B?RjZ4VHFQeHBoVDRTS1MwbXJnZGVLZTlhb0p4L3JqanJlQ2tSUmttSmo0MGNU?=
 =?utf-8?B?cFJDdGpHSHRHcFRFQmRpYlRxdmFBajNBZHo0aVRYeEtwYkpQWmlsblNsTkJG?=
 =?utf-8?B?bTh3djlwWUZWS3pHTzBlUkJLdjV3cENvK21yZmtQZmQ1OG50K0M2TXBzMWNh?=
 =?utf-8?B?NmtBY001S0NYNG0yM2t3SlYwNTJTWHhDQ0lVVm5sRnlIVDBEMEJEZkJuZElN?=
 =?utf-8?B?SmpJSG9uZi81Z25oeEJVSWZNeWh5d3RtWFBXdWUwUnNZY0JxNTc1WmNwdG5w?=
 =?utf-8?B?YmdQRkkxbWR2TXZueXlhQWt0QWNlZGpEQ1BpU21wMThnSzB0ckhiTUhUaHhM?=
 =?utf-8?B?REtnZjFBRmhXRVBheFlNUlMwem9qTXk4RlpWbER6aVdZSnNEVmp4cUlrc0dt?=
 =?utf-8?B?QzlQQjVpUmFONThLQ3ZYaEIyUHMyQnkzcWQ5RW9oL0IzNHhXOW4xU2hZcW1E?=
 =?utf-8?B?V1BERXlWZ2NwbmlUWDQ1MmhaRDZWeVRNTkRPdXJvWlJ1SUc2QTcwakEzNFhu?=
 =?utf-8?B?OTYwaWw2ZGRNdTNUOGlTaXVmR2xiaVA3QjU1allidzMzUG91WjdEREFZYzlx?=
 =?utf-8?B?WjhVNWVyN2lSaE1LWnlYbFp0OEZBWmY4VjJacUs0QU9EckdHSkRIcnA0TXdv?=
 =?utf-8?B?THpTME5SMFpXb1hnR3ZQRXdCOERlYUVnenh5ZU9rMk5WYjNPaWN2YS8rM201?=
 =?utf-8?B?bisvK2dFclArcHpqd3BvbW9obkwrcEpRL2J2TEVqb2FmNDlrRGZuZDhjbVgv?=
 =?utf-8?B?Yk93bzFyZTllc3NPMmhNQVVkTUhaaTFWTnVEOEhOUVlocDhFd3owMmlFUkJV?=
 =?utf-8?B?YThqd0RIV1lQVStPZjVGMElZWStIdUxFREpDd21kb2ZEekdWSEpwS1JiMU9L?=
 =?utf-8?Q?bFgm42R3SB4hj52xAJ+fG8iDp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa757217-b21b-42f1-4e0f-08da8be8d1e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:08:50.1823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNv2bKLzz9y15OH+m10oUa0Ivt+7taTfssAvY+DRz11UqI0BCHqudTOPjtNZOHPx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5388
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
YnVmIGF0dGFjaG1lbnQgbWFwcGluZyBmdW5jdGlvbnMgdG8gdGhlIGR5bmFtaWMgbG9ja2luZwo+
IHNwZWNpZmljYXRpb24gYnkgYXNzZXJ0aW5nIHRoYXQgdGhlIHJlc2VydmF0aW9uIGxvY2sgaXMg
aGVsZC4KPgo+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtv
QGNvbGxhYm9yYS5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgfCAx
MCArKy0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgYi9kcml2
ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jCj4gaW5kZXggMDczOTQyYmY1YWU5Li44ZTkyOGZlNmU4ZGYg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYwo+ICsrKyBiL2RyaXZlcnMv
ZG1hLWJ1Zi9kbWEtYnVmLmMKPiBAQCAtMTAzNyw4ICsxMDM3LDcgQEAgc3RydWN0IHNnX3RhYmxl
ICpkbWFfYnVmX21hcF9hdHRhY2htZW50KHN0cnVjdCBkbWFfYnVmX2F0dGFjaG1lbnQgKmF0dGFj
aCwKPiAgIAlpZiAoV0FSTl9PTighYXR0YWNoIHx8ICFhdHRhY2gtPmRtYWJ1ZikpCj4gICAJCXJl
dHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+ICAgCj4gLQlpZiAoZG1hX2J1Zl9hdHRhY2htZW50X2lz
X2R5bmFtaWMoYXR0YWNoKSkKPiAtCQlkbWFfcmVzdl9hc3NlcnRfaGVsZChhdHRhY2gtPmRtYWJ1
Zi0+cmVzdik7Cj4gKwlkbWFfcmVzdl9hc3NlcnRfaGVsZChhdHRhY2gtPmRtYWJ1Zi0+cmVzdik7
Cj4gICAKPiAgIAlpZiAoYXR0YWNoLT5zZ3QpIHsKPiAgIAkJLyoKPiBAQCAtMTA1Myw3ICsxMDUy
LDYgQEAgc3RydWN0IHNnX3RhYmxlICpkbWFfYnVmX21hcF9hdHRhY2htZW50KHN0cnVjdCBkbWFf
YnVmX2F0dGFjaG1lbnQgKmF0dGFjaCwKPiAgIAl9Cj4gICAKPiAgIAlpZiAoZG1hX2J1Zl9pc19k
eW5hbWljKGF0dGFjaC0+ZG1hYnVmKSkgewo+IC0JCWRtYV9yZXN2X2Fzc2VydF9oZWxkKGF0dGFj
aC0+ZG1hYnVmLT5yZXN2KTsKPiAgIAkJaWYgKCFJU19FTkFCTEVEKENPTkZJR19ETUFCVUZfTU9W
RV9OT1RJRlkpKSB7Cj4gICAJCQlyID0gYXR0YWNoLT5kbWFidWYtPm9wcy0+cGluKGF0dGFjaCk7
Cj4gICAJCQlpZiAocikKPiBAQCAtMTE0MiwxNSArMTE0MCwxMSBAQCB2b2lkIGRtYV9idWZfdW5t
YXBfYXR0YWNobWVudChzdHJ1Y3QgZG1hX2J1Zl9hdHRhY2htZW50ICphdHRhY2gsCj4gICAJaWYg
KFdBUk5fT04oIWF0dGFjaCB8fCAhYXR0YWNoLT5kbWFidWYgfHwgIXNnX3RhYmxlKSkKPiAgIAkJ
cmV0dXJuOwo+ICAgCj4gLQlpZiAoZG1hX2J1Zl9hdHRhY2htZW50X2lzX2R5bmFtaWMoYXR0YWNo
KSkKPiAtCQlkbWFfcmVzdl9hc3NlcnRfaGVsZChhdHRhY2gtPmRtYWJ1Zi0+cmVzdik7Cj4gKwlk
bWFfcmVzdl9hc3NlcnRfaGVsZChhdHRhY2gtPmRtYWJ1Zi0+cmVzdik7Cj4gICAKPiAgIAlpZiAo
YXR0YWNoLT5zZ3QgPT0gc2dfdGFibGUpCj4gICAJCXJldHVybjsKPiAgIAo+IC0JaWYgKGRtYV9i
dWZfaXNfZHluYW1pYyhhdHRhY2gtPmRtYWJ1ZikpCj4gLQkJZG1hX3Jlc3ZfYXNzZXJ0X2hlbGQo
YXR0YWNoLT5kbWFidWYtPnJlc3YpOwo+IC0KPiAgIAlfX3VubWFwX2RtYV9idWYoYXR0YWNoLCBz
Z190YWJsZSwgZGlyZWN0aW9uKTsKPiAgIAo+ICAgCWlmIChkbWFfYnVmX2lzX2R5bmFtaWMoYXR0
YWNoLT5kbWFidWYpICYmCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
