Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D290C25B0E
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 13:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9E6A82433;
	Mon, 15 Aug 2022 13:06:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9E6A82433
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wru8UaKh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Ylfj_Be3PpE; Mon, 15 Aug 2022 13:06:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C58682468;
	Mon, 15 Aug 2022 13:06:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C58682468
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBA06C0033;
	Mon, 15 Aug 2022 13:06:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96E37C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2817B408E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:06:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2817B408E5
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Wru8UaKh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oSNnCsUHsGOd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:06:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50D0F405AC
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50D0F405AC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRyFump/HJwcrTT0wAnC1PHSKhLUYhuPrpDYZBIcDUta3GY0zI+jKpjyUQPOD+Qi9+KSzwKM47xRgUasqnIpGG3e9fANb5D/dn33czxFzNVmFVLvr/8jS2cnaq/us4cTqhtZ+eeBd0NMd1hNo+CpW0gmzGn7yFhgBV4ndLDVS+fZX2N3C7oI0ZToR/KyDojHEcVqZvGGFzc7eOrqxfaRRbiHRMpn7LQkOOlX4pX6G1DqN3LNKvlj/7GblrREwATM+kxGPo7tMkhFNr3USSZgMD24+yWJJywdTIL2eiMzYFQP+GoF3qH5pcfUellkU86VznHfAm9topycJpcecLxq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AISMtFVGSFYyr/edr+ThSU7JSWxx2PIyvZRi9+Yu270=;
 b=D+m+XTEhVgL7xbkOA3PqdVX0+ZWNOaUwjswxsUurewfMhyiHX4exfHBCJmDbgtbnD+VOphtY6wJqrhliJKAF6wACKmVc4KSx7a2xinzUpeDVHZxL/S9XJtPxqRgRUxE8L0qkyHOgxhQZU2A8kTsAEgtEgKo83sHKibAHUkckgW/DeQR6CRfjGept4FWJ4tkAFsrSqDnIuyzu9TYr2/+c4aHNOu5aXmDiA6K2uFNB3+tlhCPd6/aNEsVZDLAUQqt3ODC3CTJRKX6m1OuZBzDAQQTZH1p3/+HMWgikiviiGQ77LPMBdosEGvbMstCrYvgvEuun+ZfqjL2HWkad+iIOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AISMtFVGSFYyr/edr+ThSU7JSWxx2PIyvZRi9+Yu270=;
 b=Wru8UaKhD6XxVqXdYzz4H9i/q/f7O/dbhIRJKqLzHQ/PTZ2I9AzUrA5lHuXdLUTaboPJ1Ym/+IUiZuUMBtaa0n0rj3kER1ldQGYWgvq0Yrq7ZLL1rIlMZsO6uB8vE+7qkvJ/tG6d+cQ1k0tRjsjp+qRT12u4jAmIwPAJ2o3xrrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 13:06:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Mon, 15 Aug 2022
 13:06:28 +0000
Message-ID: <594f1013-b925-3c75-be61-2d649f5ca54e@amd.com>
Date: Mon, 15 Aug 2022 15:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] drm/ttm: Refcount allocated tail pages
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Trigger Huang <Trigger.Huang@gmail.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20220815095423.11131-1-dmitry.osipenko@collabora.com>
 <8230a356-be38-f228-4a8e-95124e8e8db6@amd.com>
 <134bce02-58d6-8553-bb73-42dfda18a595@collabora.com>
 <8caf3008-dcf3-985a-631e-e019b277c6f0@amd.com>
 <4fcc4739-2da9-1b89-209c-876129604d7d@amd.com>
 <14be3b22-1d60-732b-c695-ddacc6b21055@collabora.com>
 <2df57a30-2afb-23dc-c7f5-f61c113dd5b4@collabora.com>
 <57562db8-bacf-e82d-8417-ab6343c1d2fa@amd.com>
 <86a87de8-24a9-3c53-3ac7-612ca97e41df@collabora.com>
 <8f749cd0-9a04-7c72-6a4f-a42d501e1489@amd.com>
 <5340d876-62b8-8a64-aa6d-7736c2c8710f@collabora.com>
In-Reply-To: <5340d876-62b8-8a64-aa6d-7736c2c8710f@collabora.com>
X-ClientProxiedBy: AS9PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:20b:531::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7984a87b-a0af-4998-ee1a-08da7ebef6ea
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0ryZpHj+3nlO13CTkDb86kWXLFNdZN3dd3MEC4RW7SZ3At31Ox84XsCFIbaSp20/vr2p5encYmP/jEAauJY5jQxw6EtJ9ImhEbnhDUmRAkzSSO/sHsKTB+NnOPpok+PT5BcQCNxJHCkYlT7lyYrNb9mnXxh9IhB3it9nkbY+GveMriVKR8zAxrDAMXCGvOv1NF0i9hqWXpdBgPE82gyx2Ic+XjK7GRdmNprc2XANlh9H1oX1GpxSuDf/JOQ8ScZgsUjdrzEv7jMZrK3AWt+u+sQMNQppCFcjt+08Umq1h8cH7gUmm5Emd9pYupeXMVP8AkwfbSD7VdokHHuqXgyvpIICkeSEU4UlkRbIhEyqqjx6RUaPSe6roirgAFkHFwKhh64LpeOxV3FOMkmsy1trxdTt/PHbun266QrHJvGZvJvv1VPEMYdCXShPeYQg3OPZbVvDTfTorl4JjF9IRwtblO+d9ArD5w6iIYyLgZFFZ4YpGIXG+jRTlcPMKUGzaN9r/SdBDZL67HzIerxgjFZ1RW1kkCFPnOnssU8B+FuoVdW+oexGueNPgzGIdadkp5Q8MepZViFXXQSL6yf3efIp7LzEQF8sp2srozVIC1w//pDgwuLNxFht7E8yAAFOm1zZB3NNwx/Td8fmOwvy6QiUJ1MfJqdr8ncaqCZ5zcCCkFLOi1QeQWYAmP01pxOIrDcrDAgGD51byENZpMsEOTqKsUcv9G6hPHNAs+nXAoV+43YJkymtuhvbGASO6GwW9dcjlxODrD9C1vqPl2geFvBggodqJnp6rhJ0OyyzR08Yr2YuhEf7bqDpMUjII1HoOQBCI/+z9ewEIqbLxgtD2gwfKoSVG1qMkpORhldpZyqd7xPgIWBtQ40ZALKxKlE/aja
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(86362001)(31696002)(38100700002)(4326008)(66556008)(66946007)(316002)(8676002)(66476007)(83380400001)(110136005)(2906002)(8936002)(2616005)(7416002)(5660300002)(6666004)(6506007)(66574015)(53546011)(6512007)(41300700001)(186003)(45080400002)(478600001)(36756003)(31686004)(966005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2swYTNIQXJSblNETnJSMlFIdGlUYUV5MFZXMEllR28xNENxdG9KU2tHOTFG?=
 =?utf-8?B?K3E5MXgvS2xFYkE2RHVsYTVZVE02V3pNMkJDMVhmYTR2SHJTd3hZZmpFYWg0?=
 =?utf-8?B?UmhpVXN0TVVFWXp2N1BjbjQ1RmRLNDYrUmJNelYzVk90UWhnNlpLcldoa0lS?=
 =?utf-8?B?eFBwMDZyRU81VzhWNXJ3WEkzRFZLL25VTTEyQVhuODhDdWdsUWloS1paSHd6?=
 =?utf-8?B?OXNRYyszZXV5VkdLMjMxcWFpRUlEVGJvU0hwTXUwKzBkN3BQWnByWlBsKzZj?=
 =?utf-8?B?YVRPV3UxY0VXcU1ad0owRjR2VWg5UFJUMzc2MjhQVTZlNzJGd21GL1kwMkVm?=
 =?utf-8?B?eFcveDN6bURZSE5nT1RPNUdiQXBIV2dXL0VHSmNYMjM2OG5GSzNUUEkyWTQv?=
 =?utf-8?B?LzNRUC82akdLRllMVlNab3RFMXpLdXFDT0d6RWI1aDAveHdLYm5uMHRYRDIz?=
 =?utf-8?B?YnhOSG9LK256UlNCdGhrVDdCZk1hWVFUN2tNNEptOW1oYy80ZlB1V2tvL1do?=
 =?utf-8?B?SFB6WXZ1M1hlR3E2RXFtekcwS0ljWjIvb2ZIQ0pxb0w0N1hqOTcvSnRSOFA4?=
 =?utf-8?B?WW5VZG5LaVAxTEdrK0orMTB2Y1J1ZE5CcG1EWFZjclJIWUdyMkZRdmxKRXAv?=
 =?utf-8?B?SFJlMms0bVJld0ZFQ0hUa2Nkd0JsY0N2VFFmVDFTclQ0N2Q4eTR0RjN3M0ZB?=
 =?utf-8?B?emxJNEJFR0R5T2t2V3FNZkE0RnhzTlB4dVhmcHRad2x0TTNyTUFTbFh6d2hk?=
 =?utf-8?B?c1BRWE9XOEFlenVCVk52YTRUdkM5Z1oyeEoyVUdZYWt1QWpZQ281dHFMeCs2?=
 =?utf-8?B?ckdzS0JpZnlUbkNvYXN4NU12SHFDQzZkU3RWcDlvc2t1YnFNODJjMllMNUNH?=
 =?utf-8?B?cFBCZGRQamJZSVdaTjBlNEl3RzlZNUFobnZ5ekNWckhka1VqTTFQTWoyT01C?=
 =?utf-8?B?YmRidS8yQldtUThNTGNzSkJkNEpOUU1jOUVyd2NVTlpsQlRuNWRXYmdUTkZU?=
 =?utf-8?B?YTdCQVMzZHVZMEVRblpDNUV3L0pqZDNmVUxORkRnLzVHYkRQZHBiSk53YTNW?=
 =?utf-8?B?R3VzazI0TXkxZmZjRXRkM212UUtkNWpzVnJGajhJWGNOdVZ1amdCZ0ozUmdP?=
 =?utf-8?B?ZVRmL0d6MWhXQTdCS2RzSmFVaDZYT1ZWaHd5QWxVeE1oSm16RmhnVzFaYm5E?=
 =?utf-8?B?V3U4ZmZGVjZnUTk3aDVHV0FIeEF4eDlraXdXSy9Ya1JCZGkwQVVBR1ZmemJP?=
 =?utf-8?B?NkovOUNFelgyQ1V2bmxvWW5LUitXOFdrdm02UU1JU1k0eXVKamUyNlZvTVRk?=
 =?utf-8?B?SUtRTzJDOVlOOTdKRzkyTTB5YlpTSHA5ZzNrdVpyYmg1Z2pBUExtVGxKZXFs?=
 =?utf-8?B?YUhYR3loMDc3NE5yOGQ5TVpGWWQ4SFFJOE9ncE1OdldaN0lQSVBoOER5ampl?=
 =?utf-8?B?SUZQSDk0NE0zWFRLNWNMN0o1SS9mdHNBSDhwNWNGZGpRVEN1Vk5QYXhlaEZn?=
 =?utf-8?B?UDB6UFlwMVVvVEN3cFNlbi9PTnBXQXZwcEs0QThiZHBCcGVnUlkxdU1FWkds?=
 =?utf-8?B?VktrVDNidW9PZEdva0R3OVJjaW0zUDVkQ09jSEErNnZ2YkFTN1hidUZ3dFBi?=
 =?utf-8?B?SzVuRlA1a3FQcWU0N2YvaUY4SWxRbExnQWlUN0VsbVhJdW1weXlUWmdUZG1w?=
 =?utf-8?B?WnMvVE5BZS9PbzVVU0Y1emFDdXJFY0hRUkltbkExdVF2SlJ2NDdBaEtLdkt0?=
 =?utf-8?B?citBdi9janc1Z1FkcDBnMjRuOUVnRFZFdzY4QnhhM3Q0Z1BLdG5iRlRMZUF2?=
 =?utf-8?B?RGh2aWZOVVNRZitrb2R4cG1veEQzM2phdEgwelR5di85MWVRMUNpU055TTBu?=
 =?utf-8?B?SDlvaDlTV2Uzd1M5L2xaWWh3eFF4ZC9NMDZLOEl5ZTVoMi9nN24xTTE0ajVO?=
 =?utf-8?B?SWZyQU93bGRaenRBVi9QVC8rV3k1V2IrcmJGVjd2YktBZlFyd0M2T0hsRmZG?=
 =?utf-8?B?MkxwQ0g3YkhzYXY2YzBLeitpelFRalVGQmFMSDNRSnFua3E2SmQzUlo5bmdR?=
 =?utf-8?B?WUtDcUptdWtETk9tTWc3V1h0OWJYSnNWd1BlQnFmS1d6KzE2Y2FnU3JmRmlV?=
 =?utf-8?B?YS9TNVdQYkxQNlkya3UrZ2k4RTRoN0k0VFFmSitNek9LZ0pMMGwxVTAyOTND?=
 =?utf-8?Q?kCPbFAflYwMI76lhRUtn8mGZb43iGnUYe5kx/hu9DSkc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7984a87b-a0af-4998-ee1a-08da7ebef6ea
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 13:06:28.0323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mswQRxQ96Rs0EA6QHO2IYBmvTxJX3cT0/rBDyNzoQXqOhgG6CYPCuuw56b67QAw1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
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

QW0gMTUuMDguMjIgdW0gMTM6NTAgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gT24gOC8xNS8y
MiAxNDoyOCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4gTWF5YmUgaXQgd2FzIGRpc2N1
c3NlZCBwcml2YXRlbHk/IEluIHRoaXMgY2FzZSBJIHdpbGwgYmUgaGFwcHkgdG8gZ2V0Cj4+Pj4+
IG1vcmUgaW5mbyBmcm9tIHlvdSBhYm91dCB0aGUgcm9vdCBvZiB0aGUgcHJvYmxlbSBzbyBJIGNv
dWxkIHN0YXJ0IHRvCj4+Pj4+IGxvb2sgYXQgaG93IHRvIGZpeCBpdCBwcm9wZXJseS4gSXQncyBu
b3QgYXBwYXJlbnQgd2hlcmUgdGhlIHByb2JsZW0gaXMKPj4+Pj4gdG8gYSBUVE0gbmV3YmllIGxp
a2UgbWUuCj4+Pj4+Cj4+Pj4gV2VsbCB0aGlzIGlzIGNvbXBsZXRlbHkgdW5maXhhYmxlLiBTZWUg
dGhlIHdob2xlIHB1cnBvc2Ugb2YgVFRNIGlzIHRvCj4+Pj4gYWxsb3cgdHJhY2luZyB3aGVyZSB3
aGF0IGlzIG1hcHBlZCBvZiBhIGJ1ZmZlciBvYmplY3QuCj4+Pj4KPj4+PiBJZiB5b3UgY2lyY3Vt
dmVudCB0aGF0IGFuZCBpbmNyZWFzZSB0aGUgcGFnZSByZWZlcmVuY2UgeW91cnNlbGYgdGhhbgo+
Pj4+IHRoYXQgd2hvbGUgZnVuY3Rpb25hbGl0eSBjYW4ndCB3b3JrIGNvcnJlY3RseSBhbnkgbW9y
ZS4KPj4+IEFyZSB5b3Ugc3VnZ2VzdGluZyB0aGF0IHRoZSBwcm9ibGVtIGlzIHRoYXQgVFRNIGRv
ZXNuJ3Qgc2VlIHRoZSBLVk0gcGFnZQo+Pj4gZmF1bHRzL21hcHBpbmdzPwo+PiBZZXMsIGFuZCBu
by4gSXQncyBvbmUgb2YgdGhlIGlzc3VlcywgYnV0IHRoZXJlIGlzIG1vcmUgYmVoaW5kIHRoYXQg
KGUuZy4KPj4gd2hhdCBoYXBwZW5zIHdoZW4gVFRNIHN3aXRjaGVzIGZyb20gcGFnZXMgdG8gbG9j
YWwgbWVtb3J5IGZvciBiYWNraW5nIGEKPj4gQk8pLgo+IElmIEtWTSBwYWdlIGZhdWx0IGNvdWxk
IHJlYWNoIFRUTSwgdGhlbiBpdCBzaG91bGQgYmUgYWJsZSB0byByZWxvY2F0ZQo+IEJPLiBJIHNl
ZSBub3cgd2hlcmUgaXMgdGhlIHByb2JsZW0sIHRoYW5rcy4gQWx0aG91Z2gsIEknbSB3b25kZXJp
bmcKPiB3aGV0aGVyIGl0IGFscmVhZHkgd29ya3Mgc29tZWhvdy4uIEknbGwgdHJ5IHRvIHBsYXkg
d2l0aCB0aGUgdGhlIEFNREdQVQo+IHNocmlua2VyIGFuZCBzZWUgd2hhdCB3aWxsIGhhcHBlbiBv
biBndWVzdCBtYXBwaW5nIG9mIGEgcmVsb2NhdGVkIEJPLgoKV2VsbCB0aGUgcGFnZSBmYXVsdCBh
bHJlYWR5IHNvbWVob3cgcmVhY2hlcyBUVE0sIG90aGVyd2lzZSB0aGUgcGZuIApjb3VsZG4ndCBi
ZSBmaWxsZWQgaW4gaW4gdGhlIGZpcnN0IHBsYWNlLgoKVGhlIGlzc3VlcyBpcyBtb3JlIHRoYXQg
S1ZNIHNob3VsZCBuZXZlciBldmVyIGdyYWIgYSBwYWdlIHJlZmVyZW5jZSB0byAKcGFnZXMgbWFw
cGVkIHdpdGggVk1fSU8gb3IgVk1fUEZOTUFQLgoKRXNzZW50aWFsbHkgd2UgbmVlZCB0byBhcHBs
eSB0aGUgc2FtZSByZXN0cmljdGlvbiBhcyB3aXRoIApnZXRfdXNlcl9wYWdlcygpIGhlcmUuCgo+
PiBBbm90aGVyIHF1ZXN0aW9uIGlzIHdoeSBpcyBLVk0gYWNjZXNzaW5nIHRoZSBwYWdlIHN0cnVj
dHVyZSBpbiB0aGUgZmlyc3QKPj4gcGxhY2U/IFRoZSBWTUEgaXMgbWFwcGVkIHdpdGggVk1fUEZO
TUFQIGFuZCBWTV9JTywgS1ZNIHNob3VsZCBuZXZlciBldmVyCj4+IHRvdWNoIGFueSBvZiB0aG9z
ZSBwYWdlcy4KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZlbGl4aXIuYm9vdGxpbi5jb20lMkZsaW51eCUyRnY1LjE5JTJG
c291cmNlJTJGdmlydCUyRmt2bSUyRmt2bV9tYWluLmMlMjNMMjU0OSZhbXA7ZGF0YT0wNSU3QzAx
JTdDY2hyaXN0aWFuLmtvZW5pZyU0MGFtZC5jb20lN0MyZjM4YzI3ZjIwZjg0MmZjNTgyYTA4ZGE3
ZWI0NTgwZCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc5
NjE2MTAzMTQwNDkxNjclN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01E
QWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3
QyU3QyU3QyZhbXA7c2RhdGE9UHU1RjFFRjlVdkRQZE9RN3NqSjFXRFJ0NVhwRlptQU1YZGtleG5E
cEVtVSUzRCZhbXA7cmVzZXJ2ZWQ9MAoKV2VsbCB0aGF0IGNvbW1lbnQgc291bmRzIGxpa2UgS1ZN
IGlzIGRvaW5nIHRoZSByaWdodCB0aGluZywgc28gSSdtIAp3b25kZXJpbmcgd2hhdCBleGFjdGx5
IGlzIGdvaW5nIG9uIGhlcmUuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
