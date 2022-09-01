Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82189ECAAD2
	for <virtualization@archiver.kernel.org>; Thu,  1 Sep 2022 07:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13D6441793;
	Thu,  1 Sep 2022 07:05:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13D6441793
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uuDN0X3R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JwbjcU5utP1; Thu,  1 Sep 2022 07:05:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8568D41703;
	Thu,  1 Sep 2022 07:05:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8568D41703
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51276C0032;
	Thu,  1 Sep 2022 07:05:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8F6AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDEF94176E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:05:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDEF94176E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D5KMy8hAjCS6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:05:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB31641703
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB31641703
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Sep 2022 07:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LySZSym/1ofn10k2OZAx7MzvHo6Z4rv2wJxL0s/aZTg48+Zg395YN0yfT4RWB9Vfh8xo5yMLg3EQ4KoUmnRZfTo4maosw/rwfAe8lJODNU1mZk9/LLuLjyDGdoUhz4YCwGAtF5L0p17PAPDrx0iZk6woNXpTHMbZaG+ixfCHFkIMu4lwATZWVzGrNmwxZCsWzZpKEsTBMbS3OdRJ3GxyCC/NfRZuIa1DDnNWHnW6aAtEReIH/iE+efNvOHRl0KuQBqdo+uMsppIc6ecaSe3UOLh5CWwqrdE/5o5c0JfdgiUy4f6yGK9GzzSN0XS+T1wMr3IOsXkuyqqG/boFCYZDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVoZAvAykywtX4NrDLqL6ABhPOsFJxEw5nAvPK4+FRY=;
 b=NaOP3Mn41tcO5cc5lzGau2sz512QGLxVV4QLo5PKfgX52tXBwbL0ZlWNwi1Mj7eRPJzsC25tvzGxeey9YmRJzqVx/8L+6C0WP1addW+c7A2niz+x7xqLYX6drb8sl9lQ14TnXRAR1ZFCGp9CIsYfIshHv8ftCpGylLvr163xmrzAycikr4NHsHb0BySTKwEzubmz1zqUh34Qkd+Hdjl8HTJTbiJbFsh+tSYdRe0oiyffkDIPqeSaY72cgcSpVcQxl69gnlur8V+w3Od9331kQy7l08ux1xEsym/tm9gLDG2pNG9m0+Aljbvo4W+rwBaw04JqX6sqjE1bzUJcUmy3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVoZAvAykywtX4NrDLqL6ABhPOsFJxEw5nAvPK4+FRY=;
 b=uuDN0X3R6Wk0l/PE2HzfGGvz15Yz/WN+2HciqkalvDOEhSuQjNv+hK1erh2x2gmOd4Ks8xTzUuSzmAKRLF15/HvzdtOWkSJ5DtAtGXMFJe9EufMt39ccaO3Ve/7qQc2k2cishyNwltmWI1Y5kfVetlwCRuktlqI/KHhXR1nzKUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 07:05:43 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 07:05:43 +0000
Message-ID: <624cdfa4-2953-00b8-5890-e40bc1434f2d@amd.com>
Date: Thu, 1 Sep 2022 09:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 14/21] media: tegra-vde: Prepare to dynamic dma-buf
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
 <20220831153757.97381-15-dmitry.osipenko@collabora.com>
In-Reply-To: <20220831153757.97381-15-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AM5PR0701CA0068.eurprd07.prod.outlook.com
 (2603:10a6:203:2::30) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c228fbff-d746-4c28-f09c-08da8be862c4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4299:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsLeTNEnDZxtDEHxBLmQvang/BuX/RxTFWjK6l4bd4ItyPuFcO84fWWPbFYjanitYxy2wGNfc17+2IdfWd8zPvsxVmUsOs8XnbQd2+vEK+ylvBfpkBRloyn9MsWFq9UjNeJlx4Ak3K2rvNjo4SO08NVpPV/lyJr10lTra5RiGHpEYG8uk1OT/JnDNL7/jfwmRFY1KO2H2IyABTTrt8+b6PiwdZMtWajWs31umGQHE8bKNvXWs6Weeaws3bOA0h65EvzcZVgP7NWLZ+XeDWd/O7zWEyR+7+PSCf/IxcIsTh6F0hZ0cEAWNqpNZ2bAedjkKL4Rg/eefuEvnn65FgPHCXswfCWwQqcNzC37vFFtzOMkX0rY6Bu5JQeLdIh72n+CuCrAykeqrfozjuuLBEO3CzFBVYJhNaxROwVVCgudBubdCtXc6K/fbyAOUQ61ZMwOz0qX1+MOMKpvhVvXmDA3mbCvs7H+XwNGvXCln8hF99Ox4hdfDmcgHZC2ChMy1gPefPOFglJNHvmO6mzZk5HuoWmFvDTOFtniXUOAozdUJpL9fAyn+yAwDJg9zJraEfvLkc6X8QUKRxOO7be/F5n8tSDVMq40bNwVBjW2BFjTVbnJGv8UzY1rfdfCM6SOPOImTNojBTCOW9C9PuHMFb/kKRsQo9Ox3amC4PEVVi8CvrxRovx1F87cr9DX/UNtqtcx3DIAVVbVbkRzpj94OnERXMS7t0LSVmbsGLSU9UKF1+P2S5hNJ8hS4MkAoADNv/jEHdjX7EfarWOQfa6guI+UFanW0MD/PEPjjkNt2jwOLFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(41300700001)(6486002)(26005)(6506007)(316002)(6512007)(6666004)(2906002)(86362001)(66476007)(36756003)(31686004)(31696002)(478600001)(110136005)(66574015)(2616005)(921005)(186003)(8676002)(66556008)(7416002)(7406005)(66946007)(38100700002)(4326008)(5660300002)(83380400001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBJMDFCUjhhQ3VXc1Y3cVQ3VWhjM0lwWEtIS3Zwb3p6eGIwL3kyaklNZmRT?=
 =?utf-8?B?dzhEL2VDWjZHeXJWeXcyUXlPaVM3ZXBLdkJqUEJ2SzR3enpHVzcrK1FkdjVS?=
 =?utf-8?B?RFVMLzVFRnVrUS9CWis5V1QvVWcybnRkQVRUU2xFQnpVKzVsT0FKRlZSWVFK?=
 =?utf-8?B?RVBIM1RVY213eW05TXNnNTVWQkFCTkdiWXZKbDZrWkpONjRuWXJkcDhGQmVR?=
 =?utf-8?B?U0VUZUQ0bDNXTVMvbkdjdXk2RTRpL2hMOEljVUJRTy91clB3MkFYODVOaHo1?=
 =?utf-8?B?T1EyMkpiZzMrOUcvUFB3OUZUTnc0RXhWN0pqNG1lVm5meUJOR2JuSHdBdy8z?=
 =?utf-8?B?Q2s0N0ZDTHR5Z2VzcVZqK2VxVVUzUURVdTY0SG1GWEFObm5vWUU0Um0xbXFy?=
 =?utf-8?B?R2ZqVWNIeDlldElJMlZ5L3VObFY3Q0VicnN6dC80OHl2TTk5NDZoL0dIajFs?=
 =?utf-8?B?ZksyUStCZXNDZ29zSVJac2dLcEhoVlJzSHVHdVoxeHN3dmJmUXNib2d3RHE3?=
 =?utf-8?B?eml6Y0E1SDN3VnRKV2RvNzB1ZTlIS1B6RDlPYXMvbFc4QkN5dGhpaHVkY0xn?=
 =?utf-8?B?T1pDbE16MTcyOEFGNjVGc2x6V00rSnRYbGxhYzF5ZXJQUXhzMmtnbm5vcHJk?=
 =?utf-8?B?SElRTFhGOENhaVRGVGY0TlprK1dyeWRNNEhJY21hWUd6ME1ISlRTLzJFVE5i?=
 =?utf-8?B?a2V1aVM4RFZEaE52U1lRYml0K0p1MjZPZmdlQWRVdkRyUkpLRFp5SFd1S3Vm?=
 =?utf-8?B?YlUwR2trcTVTZGNsVW1Wenp2TE5CUzdDTkducHN6VkhwT1EzbkIzTk8rZXpC?=
 =?utf-8?B?cC81SEN3YmNkNlQ0KzVnZEZaMGYxSGc0L3Y1UnlJYW1teTlYV0daaXU4NG5x?=
 =?utf-8?B?SUFJZWk4TEMxb2ordXYwMnRpeFNGVnhrTnhsYnZBYkdWS0QzTVFTK1JRcjZC?=
 =?utf-8?B?L0xKV3ZsbzlXVHYwUEkrbndHcHFNYVpLTmZPc3NZanEwclIxWWxkQlo1eXM5?=
 =?utf-8?B?UWppOERxYnl6NnFCYXRTWm5QZTB4bkNNZU5uK3R6dDhiUEhzenpFT04xSU5J?=
 =?utf-8?B?aVQ0SmIvcGphTVk0K3J4NUFvZmlmSHU4WHhkR0VYMXZGVHhxa2FLV0d5OG5Y?=
 =?utf-8?B?Qm9FUFZ3SFI0TnpzRGtSOEVoSC9sN281aWx1UmJ1YVFiYjBpSUNyYjJzMXBE?=
 =?utf-8?B?N2E0SzBUS3dJVG1waHNWditvcEVHQml6YVlmR3hQbzN5N1Fycnc1NGFZTG9v?=
 =?utf-8?B?QlFwZGhqVkxIaThJcEVQRk5mdGJlbDdqMi8xK2FiWlNEWDM4SHFLUVZGVFVk?=
 =?utf-8?B?M01aWkUzQWo3eXlub0tnbG15aXg1WGJmUktVRVVtOWcvRDlma1kvM05HTlpy?=
 =?utf-8?B?STRndmgyNDhoMGoyaUJPc3I2YlQxTUJ6Qkp1WHZPYXRlT2NFTnVvZURncGsw?=
 =?utf-8?B?QlpsM3VoUlptODRPSXVFSDl5ZE5JaXRpZVpWUjdHdVJxTHBjRm93bFZoSkwr?=
 =?utf-8?B?Ylh0Z3RkUW05YkpFSDlFT0xKNy8xZFVSMHYvdHpPbXkwS1N4QWtIelFpeDVX?=
 =?utf-8?B?Wk1QZHFjVStHKzRhcjN3VHFOdXpvMWRrYTBIVHFFcElQbmFNR2xxWTcxclpV?=
 =?utf-8?B?c0tYWWNhTTJud2xEUzB4L3BqNXo1SStPaUdWRkRvL2NiOTNqdzcrdnhXcWFo?=
 =?utf-8?B?N2Z6akRTKzRBaExOS1Vud1dGK01pZDlmS2NQTlRhazg2dlljL2JoZi93Nmpk?=
 =?utf-8?B?SDQrUFFuaVp5VmZpRUN1ZkJPbFJtdHU5OXR2bHdlSm5IT09LanloM0FNbkMy?=
 =?utf-8?B?QU1BdFlTelRJVnIrclNNMXFsYnVQUmE2V0x2alJKOEUraVNuKzJISVE3TXBB?=
 =?utf-8?B?T014KzJNa0JhVkxKeHA5Q2d6TVV2YXhab3JDby9ZOUdudXpDKzduODU5TXdM?=
 =?utf-8?B?TzZ3aUdXRDg4VUYwVWJWNVJPcFdFY0lib0tKbWVYSzhEVkV0VTBhcDlNTjdJ?=
 =?utf-8?B?WXJDaXdHMERUOExrVk9naDd1SWY0Q0ZTNUtVS1RuUHVieXdiK28zTjN1Q3RH?=
 =?utf-8?B?amJackdaajhMU20xQ3hiSERMeXVucXVzY2pVREUzdmNZMUk4cllYMGdGVnMw?=
 =?utf-8?Q?fuRoD8uVV68XVC04lWIvID+pM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c228fbff-d746-4c28-f09c-08da8be862c4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:05:43.7093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5xJLBjck23PA3lcjtOyiCBXc47FcTNjk7EmTrwrdphvYlgfGOZvzcVEt98AWE7G
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

QW0gMzEuMDguMjIgdW0gMTc6Mzcgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gUHJlcGFyZSBU
ZWdyYSB2aWRlbyBkZWNvZGVyIGRyaXZlciB0byB0aGUgY29tbW9uIGR5bmFtaWMgZG1hLWJ1Zgo+
IGxvY2tpbmcgY29udmVudGlvbiBieSBzdGFydGluZyB0byB1c2UgdGhlIHVubG9ja2VkIHZlcnNp
b25zIG9mIGRtYS1idWYKPiBBUEkgZnVuY3Rpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5
IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KCkFja2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9udmlkaWEvdGVncmEtdmRlL2RtYWJ1Zi1jYWNoZS5jIHwgNiArKyst
LS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9udmlkaWEvdGVncmEtdmRlL2Rt
YWJ1Zi1jYWNoZS5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9udmlkaWEvdGVncmEtdmRlL2Rt
YWJ1Zi1jYWNoZS5jCj4gaW5kZXggNjljMzQ2MTQ4MDcwLi4xYzViOTQ5ODlhZWMgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9udmlkaWEvdGVncmEtdmRlL2RtYWJ1Zi1jYWNo
ZS5jCj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9udmlkaWEvdGVncmEtdmRlL2RtYWJ1
Zi1jYWNoZS5jCj4gQEAgLTM4LDcgKzM4LDcgQEAgc3RhdGljIHZvaWQgdGVncmFfdmRlX3JlbGVh
c2VfZW50cnkoc3RydWN0IHRlZ3JhX3ZkZV9jYWNoZV9lbnRyeSAqZW50cnkpCj4gICAJaWYgKGVu
dHJ5LT52ZGUtPmRvbWFpbikKPiAgIAkJdGVncmFfdmRlX2lvbW11X3VubWFwKGVudHJ5LT52ZGUs
IGVudHJ5LT5pb3ZhKTsKPiAgIAo+IC0JZG1hX2J1Zl91bm1hcF9hdHRhY2htZW50KGVudHJ5LT5h
LCBlbnRyeS0+c2d0LCBlbnRyeS0+ZG1hX2Rpcik7Cj4gKwlkbWFfYnVmX3VubWFwX2F0dGFjaG1l
bnRfdW5sb2NrZWQoZW50cnktPmEsIGVudHJ5LT5zZ3QsIGVudHJ5LT5kbWFfZGlyKTsKPiAgIAlk
bWFfYnVmX2RldGFjaChkbWFidWYsIGVudHJ5LT5hKTsKPiAgIAlkbWFfYnVmX3B1dChkbWFidWYp
Owo+ICAgCj4gQEAgLTEwMiw3ICsxMDIsNyBAQCBpbnQgdGVncmFfdmRlX2RtYWJ1Zl9jYWNoZV9t
YXAoc3RydWN0IHRlZ3JhX3ZkZSAqdmRlLAo+ICAgCQlnb3RvIGVycl91bmxvY2s7Cj4gICAJfQo+
ICAgCj4gLQlzZ3QgPSBkbWFfYnVmX21hcF9hdHRhY2htZW50KGF0dGFjaG1lbnQsIGRtYV9kaXIp
Owo+ICsJc2d0ID0gZG1hX2J1Zl9tYXBfYXR0YWNobWVudF91bmxvY2tlZChhdHRhY2htZW50LCBk
bWFfZGlyKTsKPiAgIAlpZiAoSVNfRVJSKHNndCkpIHsKPiAgIAkJZGV2X2VycihkZXYsICJGYWls
ZWQgdG8gZ2V0IGRtYWJ1ZnMgc2dfdGFibGVcbiIpOwo+ICAgCQllcnIgPSBQVFJfRVJSKHNndCk7
Cj4gQEAgLTE1Miw3ICsxNTIsNyBAQCBpbnQgdGVncmFfdmRlX2RtYWJ1Zl9jYWNoZV9tYXAoc3Ry
dWN0IHRlZ3JhX3ZkZSAqdmRlLAo+ICAgZXJyX2ZyZWU6Cj4gICAJa2ZyZWUoZW50cnkpOwo+ICAg
ZXJyX3VubWFwOgo+IC0JZG1hX2J1Zl91bm1hcF9hdHRhY2htZW50KGF0dGFjaG1lbnQsIHNndCwg
ZG1hX2Rpcik7Cj4gKwlkbWFfYnVmX3VubWFwX2F0dGFjaG1lbnRfdW5sb2NrZWQoYXR0YWNobWVu
dCwgc2d0LCBkbWFfZGlyKTsKPiAgIGVycl9kZXRhY2g6Cj4gICAJZG1hX2J1Zl9kZXRhY2goZG1h
YnVmLCBhdHRhY2htZW50KTsKPiAgIGVycl91bmxvY2s6CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
