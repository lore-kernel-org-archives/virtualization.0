Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360E1ECAAD2
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 07:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B76768267F;
	Thu,  1 Sep 2022 07:05:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B76768267F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Kxwb2nY1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z2LQ3Maur_sm; Thu,  1 Sep 2022 07:05:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C2E681BE3;
	Thu,  1 Sep 2022 07:05:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C2E681BE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA63AC0032;
	Thu,  1 Sep 2022 07:05:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94E32C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D5A3823CF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:05:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D5A3823CF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YSf7O6Mxn3-9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:05:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0717381BE3
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0717381BE3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPzSCi8k3/7ttIhxg5dXw4/AAqegzMiOEUcFEOd0BKieVYx+9VsAfpU9a2w2ZAJTtqHhrM550K4FUJIcduPgeEfMgVKOIcwiCV9IoB/kXmTnK3qi58k6UKMgm9X7IB+qGbM43hM6TJ+8ZnMbDeo5kfqcwwG/o86PRinSsIOKWj6Qwv2XwvqiJK3K5bIYlHeRflgMwE7S+727bmqpINNOFO/c8Jzfh8+XK9a5DUxQUl2pvdASZ0HdaYFGoIFTCZgP39j9wShjZ/mXkXBywG2LOhQOw5wgnXsfTDnWKDGiNop4Z8fzQHR149vWrsX+oZeTJ9XfkoJkZ3vSfGajAtTqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC5z9Pw4VGhrPJSUH+dcWrH3COwcVlAwYmt0ib+q3LU=;
 b=VFmXvf9fjfqQ6nC6lexsvelhSaIMbkCxH8HfImq3FpjhxsYmRm3XHGlWk504Q6AXSh4CCJwJbhEV9EElMOutq2+b2q7QIP7Lms9YXl0rKH//rn/NUHKyJMmX1sF9Zjef+NwD5fhIJFw1XZPuytePERM0d7pr2yw/Eo3/UBd+V9ANA16870UDQwzyLeLxOArPbWRM0PqpR99HIJenIpMU4U+aGqhoIqi6Wfsd1PJhXsz8lHp4HDoHy2P346rtt18s/T15dyOoVzGWyiG6fx4cYNUYNOOknVO1qm0QnWT/XoZUAGIAsXQQutCVbixec17DrimPwqHn/j+oUUEys7LFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC5z9Pw4VGhrPJSUH+dcWrH3COwcVlAwYmt0ib+q3LU=;
 b=Kxwb2nY1uF3p7NWp2c1+Z0+JCxwcm817j1W2lNk+GUraCj3H6qpMyX8+vPVgRkN1/pHJwJ/eVZ1aNDgq25/ZUZX2mOFX85rui4FWsIlrvlTzfhrdPkaL/pe/E41+4SFyxaRECuSlSGUuy6a6gU37moGMXfz23nhqexZ2rFqLrgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 07:05:05 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 07:05:05 +0000
Message-ID: <7a9bcf6e-45e8-0be5-b716-5b71c9cc0623@amd.com>
Date: Thu, 1 Sep 2022 09:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 13/21] media: videobuf2: Prepare to dynamic dma-buf
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
 <20220831153757.97381-14-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-14-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AM5PR0701CA0051.eurprd07.prod.outlook.com
 (2603:10a6:203:2::13) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21dc0712-a379-467f-ce98-08da8be84bf8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4299:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMgUfPhbcrWv6bIrPmIkxakhJRXzfbNRoOCVc19g9GOlKxkBmzUb8DO3gq3Il6fMhRkrFDnP3kFEZ/AbgJHoiYjIHv0RiBiwgNSrSmCE6oGn+bmJmg/QPHBctAZmItZFlAYGt/Q7Wr3xWG5auv+x4cP03Oz+32x89OkaoxCHPzWhrHerVsOUIsOx5v0cPZxVN/0GUG8DOLostVAXK2N4PQkXHQD+O7ic+QdxT7vVF42wS2hiSBZY8THRkw/vRc0ew6TrtlLWGUXvHAfWqpgI1uzB1NYqS4+S5jDKS37JQaaIklgAU3kFlwmHKAdcrJaqRDIAAu9k1aB6XAom9oNV91Zc2b3BmVwECT3u34qb8H3+UqgHPIq6q7iUqAPUfjEKIbiQYWRLzr+qLF2gxqHzbRdioNIuM/KthQ5tlcN+qoWEl64UUK4QpUmavM3tbusNfpy00LZDCNVg222VNJvutkIVVL8cwP7vVR/tk6/xsMhv0ig2pc7pcMtInaq3tmaWf+WOpjlaLbymAapRe4k9VQkkPXhhxCXvL7XmU3d0496EyAYFDo1PhaQuh83wBFn9Q0SM2Mw95ZdzWPgsdmVLVqM2H+U8KXBdpei/brIykmO7vHI7Li0z6ccWVGVt11uW4iogbPoJsoP0KkONL9sB83Emlx7fqxaBAH7sR58GMcjlom8Pphq/hahll0YdMdayWboHLyo/s2VCoQr4ZLGjn5pdJREX9SUUH/QCkeJybrDB7gveXF5iC9iwJZ+W1jiylYtpZ4Z1JfI2uF/FF/bW70Ho9Boxi/Yb2HXrDEqnURL/IMI7pUXvxN8hJawf+0mw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(41300700001)(6486002)(26005)(6506007)(316002)(6512007)(6666004)(2906002)(86362001)(66476007)(36756003)(31686004)(31696002)(478600001)(110136005)(66574015)(2616005)(921005)(186003)(8676002)(66556008)(7416002)(7406005)(66946007)(38100700002)(4326008)(5660300002)(83380400001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUlXNTl5Vmd3THJ5NjJyZHZOTTZDQlJoMnRtNTg2Q1dLMHBWc2RMeWFhMjdk?=
 =?utf-8?B?dUF5Zk5waW1nS25kYUhkTjhZV0RadVFBN2ppTW53YmtKVFFOUVJzeHhTTWtx?=
 =?utf-8?B?NlJWUjlnUGpXRVkzTWh6Nzg0ZVo2RGgvdnhZR0t2dFdhZ05jT2dsNFhHSEpj?=
 =?utf-8?B?M3VYeVZGRDVja1U2SEJYbDVrRWFyL2NBSis0OHdVVXpKeGFCL1lGOU5YaGFp?=
 =?utf-8?B?UEgxbVRmQkttVzV6TU1YWVRwN2c5dzRxM1R0UVZNcWU3VTZsOHpXQW00NThS?=
 =?utf-8?B?aWpkVS9hVTl4VnFDOExGVWdKaGZDRGJTNk9YWkFGWVpsdUxQYzhWQVI1WWtO?=
 =?utf-8?B?M3d2Rlk3akIvdi80UW9lVGkyRjNZT1F1TnNGQmVRT0ExZk14SVJ0R2prcGlh?=
 =?utf-8?B?blNmRHY3dGNSaThsWmt3Zm5JaDJjV2VxY2VXbEJzTjlxaDJleUpiejdqRml1?=
 =?utf-8?B?VnpabUl3ZnV6d0xnWmR0ZFN3ck5UNE5nTm1yNmlVYXZSUTVTQ09xZi9QTGY0?=
 =?utf-8?B?UktDZ01xYjFsOUxFang0WmhQT1BqODhocVJVYTFlaGNvT05uZ2pBTWR6RTZW?=
 =?utf-8?B?dnFOVVJITVg0aFhQVHFkM2hVTUJtL1lkM1hsVDRoZTBjS1o2YXZTSzJWMHBQ?=
 =?utf-8?B?a3A1SGt3Z0UrRnpnckFkUVVLQzNQR2V3RGpqUk5ONWZ2Wk5LN3l3dFAvbEJG?=
 =?utf-8?B?a3dLR3pOVE00QnZUaVQ5VUZFSTR6d2ZlbzA4REdjR01XWVorZEE2TkR0ZThp?=
 =?utf-8?B?c3lSaFBMeUFDcWhtOTBleCtGSnFkaW52bmhYV3ZjekpWTDQxNE9ZbUxLbzd5?=
 =?utf-8?B?NFRxZm1odytBVXBFUGhDSGZvTmJ4bERZUVYyS0NLdUpVY1BEb0cwYmt6Z0Fu?=
 =?utf-8?B?dTh0U1pHOC9NY0xOamVrQXJ1a1I1WEdXdnphbDRrd0o4SldHT1pNTUM0Ykxh?=
 =?utf-8?B?UFpXS2NWT3VGcE0wUjhMTURPSlQzZDlBRFdWNWd0QWh0TUtTa1hPZ2pMeUtz?=
 =?utf-8?B?QUl4cmRJaHZOUE82T045S1lGUDlrS001SXlwTWhmVTBoVUUzYWY2UUxBUlhl?=
 =?utf-8?B?bXhEbUx4NWtDTUJadThGSVBrcm1ZcHl5c05iQjh1dms5VTZ3SCtUZU9RUFg5?=
 =?utf-8?B?ZklHenpnWDVrWnFDU2FOdEVlYm1tK2syaERQdkN1YkhvOW1hQ3FkNjVwTFVG?=
 =?utf-8?B?dzhRLzVzb2lUdllZUktUemw5eTZpY1pueGo5Z3d1MHhSNmlLSE1kS2tGcWk4?=
 =?utf-8?B?TUpEMFJjNmhlUmFwZ3Nib2xlWGRVaWNCdy9tVGJjdWtFRUdBUGxKS1B3cGd5?=
 =?utf-8?B?T0tHbUtqdXV6cTJISnhDeUEveWt1bE52K1NSLzBCTEZ6YmZ0T2QwVzQ1WW9h?=
 =?utf-8?B?MlhZSTN0WFFGSGpSOE9sU05LeUg2aGFhd0doL0pjcjgwajdHUHFKM1dKR2VI?=
 =?utf-8?B?Q1JJT3c4RVdWWlA2dndDRkJ2NmRDbWlQblJ1QUh5OC92aWttSm9sZko4SFc2?=
 =?utf-8?B?Z21kOUswUjYzNHhpYWN0Ym0yYTViaGlta21weDBHZCs0V3FscVA4QlZUZlpy?=
 =?utf-8?B?V1FabXNyZlJXb0JIR2tST3NnTHV4MDlLZmx5ZVNmZklzNFBLR3NOM2tUbFpy?=
 =?utf-8?B?SWluamtKZWx4QUJmT2NiVzhDUExmTnB2dlpiRy9nVjdMN3BQeHV5U3cvTVNz?=
 =?utf-8?B?N00xWG8rbmpLWGJRbHl6a2tDOXY3Z2Rya1VHdGVRMEh4ajg1d2oxMkRuSEdl?=
 =?utf-8?B?dkc3SVVBRTJXalltU0orSlhBTkFvZ1M3S3drT0dGY3c5WGh5RkFGMksrU2pS?=
 =?utf-8?B?TUgxbks0Y3JHdUlycTR3ZXZ0TDhJRUpDdFZJM1dJa0llR3NSelZpVXMrYmdK?=
 =?utf-8?B?TXViRXpRMks3MzJmMlhCbmM0QVl0SDZSVjdOZUNpL0wvM0FNMjgyMlJPUE1r?=
 =?utf-8?B?cjBSOWk1Qk1yNmk0WHdNc1VKRlVUampadHhVMzdQNVpGWUNhVmx0bmxsZTVm?=
 =?utf-8?B?Yy9Yckl2N2hWTG5hMkNjVDlyeUJXNFVOT1pJcUF4YmJuYWF2RkdGdDIySXYz?=
 =?utf-8?B?VWpqZmo0VWtla01Qd2hhTi8wRWthc3Vlb2M1dFRJWUdCYWFDM3NGZW1kcnl1?=
 =?utf-8?Q?dz+gZ1ELI5g2AOAefsqYj/iTB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21dc0712-a379-467f-ce98-08da8be84bf8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:05:05.3991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RpEALNQu+tzLmymzDbw+VcGjdnYbhaEyG+s6xrIjfGNOotqBl6TIwZsS+TqblSv
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

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gUHJlcGFyZSBW
NEwyIG1lbW9yeSBhbGxvY2F0b3JzIHRvIHRoZSBjb21tb24gZHluYW1pYyBkbWEtYnVmIGxvY2tp
bmcKPiBjb252ZW50aW9uIGJ5IHN0YXJ0aW5nIHRvIHVzZSB0aGUgdW5sb2NrZWQgdmVyc2lvbnMg
b2YgZG1hLWJ1ZiBBUEkKPiBmdW5jdGlvbnMuCj4KPiBBY2tlZC1ieTogVG9tYXN6IEZpZ2EgPHRm
aWdhQGNocm9taXVtLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRtaXRy
eS5vc2lwZW5rb0Bjb2xsYWJvcmEuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL21lZGlhL2NvbW1vbi92
aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1jb250aWcuYyB8IDExICsrKysrKy0tLS0tCj4gICBkcml2
ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1zZy5jICAgICB8ICA4ICsr
KystLS0tCj4gICBkcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLXZtYWxs
b2MuYyAgICB8ICA2ICsrKy0tLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL2NvbW1vbi92
aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1jb250aWcuYyBiL2RyaXZlcnMvbWVkaWEvY29tbW9uL3Zp
ZGVvYnVmMi92aWRlb2J1ZjItZG1hLWNvbnRpZy5jCj4gaW5kZXggNjc4YjM1OTcxN2M0Li43OWY0
ZDgzMDFmYmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL3Zp
ZGVvYnVmMi1kbWEtY29udGlnLmMKPiArKysgYi9kcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1
ZjIvdmlkZW9idWYyLWRtYS1jb250aWcuYwo+IEBAIC0xMDEsNyArMTAxLDcgQEAgc3RhdGljIHZv
aWQgKnZiMl9kY192YWRkcihzdHJ1Y3QgdmIyX2J1ZmZlciAqdmIsIHZvaWQgKmJ1Zl9wcml2KQo+
ICAgCWlmIChidWYtPmRiX2F0dGFjaCkgewo+ICAgCQlzdHJ1Y3QgaW9zeXNfbWFwIG1hcDsKPiAg
IAo+IC0JCWlmICghZG1hX2J1Zl92bWFwKGJ1Zi0+ZGJfYXR0YWNoLT5kbWFidWYsICZtYXApKQo+
ICsJCWlmICghZG1hX2J1Zl92bWFwX3VubG9ja2VkKGJ1Zi0+ZGJfYXR0YWNoLT5kbWFidWYsICZt
YXApKQo+ICAgCQkJYnVmLT52YWRkciA9IG1hcC52YWRkcjsKPiAgIAo+ICAgCQlyZXR1cm4gYnVm
LT52YWRkcjsKPiBAQCAtNzExLDcgKzcxMSw3IEBAIHN0YXRpYyBpbnQgdmIyX2RjX21hcF9kbWFi
dWYodm9pZCAqbWVtX3ByaXYpCj4gICAJfQo+ICAgCj4gICAJLyogZ2V0IHRoZSBhc3NvY2lhdGVk
IHNjYXR0ZXJsaXN0IGZvciB0aGlzIGJ1ZmZlciAqLwo+IC0Jc2d0ID0gZG1hX2J1Zl9tYXBfYXR0
YWNobWVudChidWYtPmRiX2F0dGFjaCwgYnVmLT5kbWFfZGlyKTsKPiArCXNndCA9IGRtYV9idWZf
bWFwX2F0dGFjaG1lbnRfdW5sb2NrZWQoYnVmLT5kYl9hdHRhY2gsIGJ1Zi0+ZG1hX2Rpcik7Cj4g
ICAJaWYgKElTX0VSUihzZ3QpKSB7Cj4gICAJCXByX2VycigiRXJyb3IgZ2V0dGluZyBkbWFidWYg
c2NhdHRlcmxpc3RcbiIpOwo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiBAQCAtNzIyLDcgKzcyMiw4
IEBAIHN0YXRpYyBpbnQgdmIyX2RjX21hcF9kbWFidWYodm9pZCAqbWVtX3ByaXYpCj4gICAJaWYg
KGNvbnRpZ19zaXplIDwgYnVmLT5zaXplKSB7Cj4gICAJCXByX2VycigiY29udGlndW91cyBjaHVu
ayBpcyB0b28gc21hbGwgJWx1LyVsdVxuIiwKPiAgIAkJICAgICAgIGNvbnRpZ19zaXplLCBidWYt
PnNpemUpOwo+IC0JCWRtYV9idWZfdW5tYXBfYXR0YWNobWVudChidWYtPmRiX2F0dGFjaCwgc2d0
LCBidWYtPmRtYV9kaXIpOwo+ICsJCWRtYV9idWZfdW5tYXBfYXR0YWNobWVudF91bmxvY2tlZChi
dWYtPmRiX2F0dGFjaCwgc2d0LAo+ICsJCQkJCQkgIGJ1Zi0+ZG1hX2Rpcik7Cj4gICAJCXJldHVy
biAtRUZBVUxUOwo+ICAgCX0KPiAgIAo+IEBAIC03NTAsMTAgKzc1MSwxMCBAQCBzdGF0aWMgdm9p
ZCB2YjJfZGNfdW5tYXBfZG1hYnVmKHZvaWQgKm1lbV9wcml2KQo+ICAgCX0KPiAgIAo+ICAgCWlm
IChidWYtPnZhZGRyKSB7Cj4gLQkJZG1hX2J1Zl92dW5tYXAoYnVmLT5kYl9hdHRhY2gtPmRtYWJ1
ZiwgJm1hcCk7Cj4gKwkJZG1hX2J1Zl92dW5tYXBfdW5sb2NrZWQoYnVmLT5kYl9hdHRhY2gtPmRt
YWJ1ZiwgJm1hcCk7Cj4gICAJCWJ1Zi0+dmFkZHIgPSBOVUxMOwo+ICAgCX0KPiAtCWRtYV9idWZf
dW5tYXBfYXR0YWNobWVudChidWYtPmRiX2F0dGFjaCwgc2d0LCBidWYtPmRtYV9kaXIpOwo+ICsJ
ZG1hX2J1Zl91bm1hcF9hdHRhY2htZW50X3VubG9ja2VkKGJ1Zi0+ZGJfYXR0YWNoLCBzZ3QsIGJ1
Zi0+ZG1hX2Rpcik7Cj4gICAKPiAgIAlidWYtPmRtYV9hZGRyID0gMDsKPiAgIAlidWYtPmRtYV9z
Z3QgPSBOVUxMOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIv
dmlkZW9idWYyLWRtYS1zZy5jIGIvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVv
YnVmMi1kbWEtc2cuYwo+IGluZGV4IGZhNjkxNThhNjViMS4uMzZlY2RlYThkNzA3IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi92aWRlb2J1ZjItZG1hLXNnLmMK
PiArKysgYi9kcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLWRtYS1zZy5j
Cj4gQEAgLTMwOSw3ICszMDksNyBAQCBzdGF0aWMgdm9pZCAqdmIyX2RtYV9zZ192YWRkcihzdHJ1
Y3QgdmIyX2J1ZmZlciAqdmIsIHZvaWQgKmJ1Zl9wcml2KQo+ICAgCj4gICAJaWYgKCFidWYtPnZh
ZGRyKSB7Cj4gICAJCWlmIChidWYtPmRiX2F0dGFjaCkgewo+IC0JCQlyZXQgPSBkbWFfYnVmX3Zt
YXAoYnVmLT5kYl9hdHRhY2gtPmRtYWJ1ZiwgJm1hcCk7Cj4gKwkJCXJldCA9IGRtYV9idWZfdm1h
cF91bmxvY2tlZChidWYtPmRiX2F0dGFjaC0+ZG1hYnVmLCAmbWFwKTsKPiAgIAkJCWJ1Zi0+dmFk
ZHIgPSByZXQgPyBOVUxMIDogbWFwLnZhZGRyOwo+ICAgCQl9IGVsc2Ugewo+ICAgCQkJYnVmLT52
YWRkciA9IHZtX21hcF9yYW0oYnVmLT5wYWdlcywgYnVmLT5udW1fcGFnZXMsIC0xKTsKPiBAQCAt
NTY1LDcgKzU2NSw3IEBAIHN0YXRpYyBpbnQgdmIyX2RtYV9zZ19tYXBfZG1hYnVmKHZvaWQgKm1l
bV9wcml2KQo+ICAgCX0KPiAgIAo+ICAgCS8qIGdldCB0aGUgYXNzb2NpYXRlZCBzY2F0dGVybGlz
dCBmb3IgdGhpcyBidWZmZXIgKi8KPiAtCXNndCA9IGRtYV9idWZfbWFwX2F0dGFjaG1lbnQoYnVm
LT5kYl9hdHRhY2gsIGJ1Zi0+ZG1hX2Rpcik7Cj4gKwlzZ3QgPSBkbWFfYnVmX21hcF9hdHRhY2ht
ZW50X3VubG9ja2VkKGJ1Zi0+ZGJfYXR0YWNoLCBidWYtPmRtYV9kaXIpOwo+ICAgCWlmIChJU19F
UlIoc2d0KSkgewo+ICAgCQlwcl9lcnIoIkVycm9yIGdldHRpbmcgZG1hYnVmIHNjYXR0ZXJsaXN0
XG4iKTsKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gQEAgLTU5NCwxMCArNTk0LDEwIEBAIHN0YXRp
YyB2b2lkIHZiMl9kbWFfc2dfdW5tYXBfZG1hYnVmKHZvaWQgKm1lbV9wcml2KQo+ICAgCX0KPiAg
IAo+ICAgCWlmIChidWYtPnZhZGRyKSB7Cj4gLQkJZG1hX2J1Zl92dW5tYXAoYnVmLT5kYl9hdHRh
Y2gtPmRtYWJ1ZiwgJm1hcCk7Cj4gKwkJZG1hX2J1Zl92dW5tYXBfdW5sb2NrZWQoYnVmLT5kYl9h
dHRhY2gtPmRtYWJ1ZiwgJm1hcCk7Cj4gICAJCWJ1Zi0+dmFkZHIgPSBOVUxMOwo+ICAgCX0KPiAt
CWRtYV9idWZfdW5tYXBfYXR0YWNobWVudChidWYtPmRiX2F0dGFjaCwgc2d0LCBidWYtPmRtYV9k
aXIpOwo+ICsJZG1hX2J1Zl91bm1hcF9hdHRhY2htZW50X3VubG9ja2VkKGJ1Zi0+ZGJfYXR0YWNo
LCBzZ3QsIGJ1Zi0+ZG1hX2Rpcik7Cj4gICAKPiAgIAlidWYtPmRtYV9zZ3QgPSBOVUxMOwo+ICAg
fQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYy
LXZtYWxsb2MuYyBiL2RyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi92aWRlb2J1ZjItdm1h
bGxvYy5jCj4gaW5kZXggOTQ4MTUyZjE1OTZiLi43ODMxYmY1NDU4NzQgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVvYnVmMi12bWFsbG9jLmMKPiArKysg
Yi9kcml2ZXJzL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLXZtYWxsb2MuYwo+IEBA
IC0zNzYsNyArMzc2LDcgQEAgc3RhdGljIGludCB2YjJfdm1hbGxvY19tYXBfZG1hYnVmKHZvaWQg
Km1lbV9wcml2KQo+ICAgCXN0cnVjdCBpb3N5c19tYXAgbWFwOwo+ICAgCWludCByZXQ7Cj4gICAK
PiAtCXJldCA9IGRtYV9idWZfdm1hcChidWYtPmRidWYsICZtYXApOwo+ICsJcmV0ID0gZG1hX2J1
Zl92bWFwX3VubG9ja2VkKGJ1Zi0+ZGJ1ZiwgJm1hcCk7Cj4gICAJaWYgKHJldCkKPiAgIAkJcmV0
dXJuIC1FRkFVTFQ7Cj4gICAJYnVmLT52YWRkciA9IG1hcC52YWRkcjsKPiBAQCAtMzg5LDcgKzM4
OSw3IEBAIHN0YXRpYyB2b2lkIHZiMl92bWFsbG9jX3VubWFwX2RtYWJ1Zih2b2lkICptZW1fcHJp
dikKPiAgIAlzdHJ1Y3QgdmIyX3ZtYWxsb2NfYnVmICpidWYgPSBtZW1fcHJpdjsKPiAgIAlzdHJ1
Y3QgaW9zeXNfbWFwIG1hcCA9IElPU1lTX01BUF9JTklUX1ZBRERSKGJ1Zi0+dmFkZHIpOwo+ICAg
Cj4gLQlkbWFfYnVmX3Z1bm1hcChidWYtPmRidWYsICZtYXApOwo+ICsJZG1hX2J1Zl92dW5tYXBf
dW5sb2NrZWQoYnVmLT5kYnVmLCAmbWFwKTsKPiAgIAlidWYtPnZhZGRyID0gTlVMTDsKPiAgIH0K
PiAgIAo+IEBAIC0zOTksNyArMzk5LDcgQEAgc3RhdGljIHZvaWQgdmIyX3ZtYWxsb2NfZGV0YWNo
X2RtYWJ1Zih2b2lkICptZW1fcHJpdikKPiAgIAlzdHJ1Y3QgaW9zeXNfbWFwIG1hcCA9IElPU1lT
X01BUF9JTklUX1ZBRERSKGJ1Zi0+dmFkZHIpOwo+ICAgCj4gICAJaWYgKGJ1Zi0+dmFkZHIpCj4g
LQkJZG1hX2J1Zl92dW5tYXAoYnVmLT5kYnVmLCAmbWFwKTsKPiArCQlkbWFfYnVmX3Z1bm1hcF91
bmxvY2tlZChidWYtPmRidWYsICZtYXApOwo+ICAgCj4gICAJa2ZyZWUoYnVmKTsKPiAgIH0KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
