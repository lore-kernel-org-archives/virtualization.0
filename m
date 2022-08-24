Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B960C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 14:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 072B24024B;
	Wed, 24 Aug 2022 14:11:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 072B24024B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qh3ShTDq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z_m0NUZ2LXXY; Wed, 24 Aug 2022 14:11:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C50240B87;
	Wed, 24 Aug 2022 14:11:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C50240B87
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57016C007E;
	Wed, 24 Aug 2022 14:11:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4B1CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF3D3827D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF3D3827D2
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Qh3ShTDq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LfBfrrp0lxZX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:11:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 070FB827A5
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 070FB827A5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 14:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nnu9eRxdokgHHfl+/+uOoH79qxNcD0SVs9cWBq5ZoF9j0UFCd7XseYc3AhPw0jPm5ije3Kb6wQMUBTHEKZJmSaYp5RYFbgoAnJokP/VVhMmXhpXevr7VDpX+b6lvqhfYrb2M33K6mb9uTqZMNxoURPJ/edrWyIhWvQkTKp8RA2Omz2Id/NOzDW9Mojlqq/FWsNBeA8JBs46rl/9bgYq59XXJgdfietMh2Dh3LxhxDI8tovBdESun4HH6yTY84u7eFpJqSTBs3iTVmNdeygetn7jWArP0HnTsaYJ8mLRL7cRR8U+PaIEl1QlfJOePwEJcMDAhZm6EgRc3/rwuEeUbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqPUQCej5vuqxvtj8Chlk3T/0EwQ6MX8daIfGCr7o8M=;
 b=c/XYxqdneDEH/DkMoLFAsRp6iqvullaPOshGTd9IJExYzhHSUDR/lvxqVU8bJzAi+bG4bVC2GDFT/AnfpIM18YW45lz7zeybn1yJkTdHE7hbwZb8HQitbHjRZTPQPAJCtILuFDjiq6MJnMDr0rs6JHqgaZXccGMOQ/VfNaRGyHZhlVOPOFWV3yL9WKyaG/ol2pyw5Yhhktf1m+JEDiYO1maA0JSV6+adQNTgnaMt3LTNNXoWfng3OHb8k6jn/t9ivn02jtvgB9ELg5st2eo3ocrTnLV3fTfmCImt5aCCfCHbK//xhu/L84jCLav54YuhJIXO1RRAPH3QKLJKdTuHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqPUQCej5vuqxvtj8Chlk3T/0EwQ6MX8daIfGCr7o8M=;
 b=Qh3ShTDqYljGuzDiMNRcnLnEVaa1TnymlG57SvJVZ37XrCkhCzlZlcOdBD0onKcBMrrCqvRssSW7RmGJCKoAHPW84c+dPgar3Stm+B3OKYTy5D4B7HrG14exTta7wWOM7t7TfMu6ixQrqLYLY5bzTUWcfh5BsSrXlomsiN0ejSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB2921.namprd12.prod.outlook.com (2603:10b6:5:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 14:11:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 14:11:16 +0000
Message-ID: <ce79b696-339b-3505-5884-14a20489de57@amd.com>
Date: Wed, 24 Aug 2022 16:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 9/9] dma-buf: Remove internal lock
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
 <20220824102248.91964-10-dmitry.osipenko@collabora.com>
In-Reply-To: <20220824102248.91964-10-dmitry.osipenko@collabora.com>
X-ClientProxiedBy: AS9PR06CA0185.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67b7ec6f-b4af-4832-23c0-08da85da577d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2921:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9NG0WZgeddmHQwKb4RZcp7HqbpXvkRxGZjf8wyn//i6nkI+GbEM6NxR1/40CDNMCQElwy/eStwFCrwZgaEyUVVlX2goeVG1d+IQ85CzYj/TM3kHYZit/pEWPukn8aSbCIFi0anF8TVxbP7sASoCyTZIE1JRZp6lyp2s2j509su11JpbWVYzWD+GMVOPNEDtRR4OYz915Thgdk7xVJ2aIMeM14Vmk18P/VO9HQzDaCXdRPXNIDnA2uaRBbor/PXHXcmWK7OLyL42WYgMYcuIIjzFf080beadL4TqaSejUCXWRcONHkmHJaPkVYXLMgTHxELmO9hsbZzEd4PZ1jaiUM+2mBFpuPFo4PMJKcxmPsaYLpu6Zih7foI2FwwEO1cOPZSVC9fWr5Ix4DZEdJLzvLi0rj1QRdV5YjptGrnc8bCCP0dfsWSRiuTLu2IdHfPdG/64xaxIBYO6px9rdwIwYtSXQgYQyD9vsloEdRthTFDTGjJZcc/P4R+DFz6WnrnNfnlxrpu0VlgKsIrKlAkHIcZBSZcdwwF2p8gBxzQVwUXi0WflZ2ElQ6/jr9rU9LnPlP8GomqxPPBiPxpJn1uP/FsU5Noi3rdri6PH3W7+3Rtui36W6VHY52RsEBfBbfX6yBqsXVMPXyEYvLM+vvK//37+PYV9Rb+oSE1O+RFDYGoBf4xoUnIJWkzCXxRDymyHOteQJ2EM/q4FwGctUsrXrjHNy+N0TN4Bg8cYeKOX+g3DGsGHY3AU2O7KPNi+UD3mdGgCm1LFf9tN8wWOLxEa5TyLAtup+3YFphHEvgVhuw4zMkKIsINbnr8+q3pGTt6f6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(66946007)(66556008)(8676002)(86362001)(31696002)(110136005)(316002)(83380400001)(6666004)(8936002)(186003)(38100700002)(2616005)(7416002)(921005)(41300700001)(478600001)(6486002)(66574015)(2906002)(36756003)(7406005)(31686004)(6512007)(6506007)(5660300002)(66476007)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZvZkdGS242YVZNUWVVU0x0d1dTYi90OXFsUW5vN3U2aERzQ3ArMFdpUy9q?=
 =?utf-8?B?aXdKaHVOTGhRTUgrMnNiWFNNRWxWai9hbWdEL1ZFV1FTWUZzYkltUkVtZTNE?=
 =?utf-8?B?UWV3Q2t5R1BYMGE3WFJZN2NtQ1BXaTU4RkJMbUF2Z1Nxc2tMNy9NRHFLN2hJ?=
 =?utf-8?B?K3BJWnVqaU5JS1lsOVl0UlIwd0w5bjFNNkpWZWNDZ3hCbkcyc04wR0VLSjdo?=
 =?utf-8?B?TXBiRFVMcWI4S2swSk1YVks1K0ZPSkZwVkJZbUhUSzR3anpWdTV1Z21ZRlJC?=
 =?utf-8?B?OS9xeXFZT1VYWnh5dWxaMERpaXdEd1NvUThpUG4xQ1R1SjJFRXIzQVBNRjFn?=
 =?utf-8?B?Mm5GaVg1ZjBXVk1BSm1yMlV2ZGNCekEram9LRXJScGsxeDZqVGZaUFRSTG5m?=
 =?utf-8?B?dU9PU01YU0FkTVhsZDZ5RzNEOGtCQ2t5VzhzQUFUK0prNmFSTGtyVjRCK0Y3?=
 =?utf-8?B?emNIakUxTXM2dWlBT2FFNGJHc3NCSXM3L3NybndiYmRmdmpZb0ZtNVlLVTFZ?=
 =?utf-8?B?YmorQmZRU1NLU1g3ZXJiaXRqTjVDZjNrcVB3USswdFRMVndJVHJpcFdZckRv?=
 =?utf-8?B?UEVVRFg1YlFQbEM2Nm4rVmNsaFl4a3grVXJsVGprQU9PR20xTmRyOU8rSkgw?=
 =?utf-8?B?MWxFbFlvSVI2T3dQWGRCWVZvSHRLb1FzWHdwL2lPUVV0VExmUVpjY3hJSGtQ?=
 =?utf-8?B?cCtKVHZ6REM5ZEdSdTNEdnhtcmxQWjNrMThhYzVQNTdqc0tuUEs0d2hsL2ky?=
 =?utf-8?B?cGxuSTd5SlIwYysrR1A0V1RKK2dYRnpvQ0RMMFl5M0NaalhqZmlPd2FYLzAw?=
 =?utf-8?B?dGxyZWtPUHhrSlBUOFZtQk5UOThNMkg2MzF6Z2dpd1NUODlIUzA4ZUJRd3Zy?=
 =?utf-8?B?d0JHNVR0cWNSYW1qSFdscWNYZ3ZIWVRhcm82Ymc1VzZ2Znh0VEVPQkJDTWVy?=
 =?utf-8?B?TUhNclNkcEdjN3ErT3g4NTBuNnVSQ0tQb3NTQUJqQnFaN3NNSUVXVjJSYkRQ?=
 =?utf-8?B?b0JiS3BHSUw3WHNRajlVbHUrUWRuczFnRm9hRkdBdFJyT1BVcGR5UG1lbkxy?=
 =?utf-8?B?dktzaHV6MksyTmQydzRCb1FHTnUyUnlmZys4Z01XR3VTeW1JNHQ1RWFtM29Z?=
 =?utf-8?B?cm5heWFuWUxsUHdtaFo5MHFQTXlUcjhwMHpwL0p1SlRoSFRCM2t0dG1vanRs?=
 =?utf-8?B?Q0pmZjVtdS8zVHBCamxVOUhzdGlnNXR3Q3ZpYWFpYkZJaCsvaWVlbWdWYkQy?=
 =?utf-8?B?UUdpa3ErSWlwdjAwY2ZabUQxS2p1Q0ZjcGxGTDRCcE5GOW4yY1pQS3NYNnNW?=
 =?utf-8?B?UXRSSDlIVksyUnhqTlIxVDc0aEp4YXUxcURnV0psRkYzMnNsMmszMG9HV1hV?=
 =?utf-8?B?RExuMU9xQmdLQ1paZUQ3Tyt3Y0pXVEdoVnRuemFCYmFCVXBrUHhyOE9GdTJt?=
 =?utf-8?B?WnRta1JEcWxlMEFpelJTYnNLMlVJUElOaEZ5MnNqK3NQTzhORjRadlhiOXhl?=
 =?utf-8?B?VmhFMHZYMTZuYnFqZGNVRDBySkI2bERRbGV3cnNHZ29HTm5MVCtXdFBZQmFu?=
 =?utf-8?B?d05QVnFVd2F3TDh4SEsyK2lSWVI5bHJYd0dvREtnV0dmelh1RFNhcVZWWFZC?=
 =?utf-8?B?cnBwdHEwcEl6bTFCOVY4RW95cWc1M1VDdFIwdmplbnA0ZDljc2d6bTZQSE5L?=
 =?utf-8?B?Q0lKOVhxeWNwbGVORGFrZ3RGNlBMVWxOeVJXM29sakplZlFkVTcvYy9oQWNN?=
 =?utf-8?B?ZzhFYitOWkRIZVo4aWptUWNWY0F5dEtqWTI5SkVoRzRyRmNZZjFFZjk2VG9G?=
 =?utf-8?B?UEtVcmJSNGJSc2VXQlNBUWFYWFRXRVBFakpJVUNHQk0rU3graGx6bFIwYnBr?=
 =?utf-8?B?TGVSYmk3NldxWFQ2NGkyZysxd01QUUpJUVB3MzdlalljMlluYjhlQlhGN1R0?=
 =?utf-8?B?dXdvczhUOWlMb1JmL0NGK1NSUEhiWGFia0NPTHlZVVNkdFRiL0NJbGwrV3Y5?=
 =?utf-8?B?M2h1SWhpa1pZZGtOcGU3QWV5QWxSamlRR0lpcEZzMU4vYUZzcWRtRytoMGhV?=
 =?utf-8?B?bjNMTXBVVnI5S1RmaHgzcSs3QW9GaDliWFBoeUQ3U0dVTE9BMGxNY2hFOFdQ?=
 =?utf-8?B?RGJwclNBQVhSSlg0Vi81TUZ1NEwxSThHU1pValk2RnVMbUsxZEw2bFQvVTRk?=
 =?utf-8?Q?u1j+2hwCp46rKu/IcbQa2dXCfG+/oPZl9unLUmkSzpyK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b7ec6f-b4af-4832-23c0-08da85da577d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:11:15.3638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTY5k8ED+mNcVUDjvJ5HsDVekfcgtBKL3p44ies0fA2tsJvqTNu1kTc77Ran8cDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2921
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

QW0gMjQuMDguMjIgdW0gMTI6MjIgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gVGhlIGludGVy
bmFsIGRtYS1idWYgbG9jayBpc24ndCBuZWVkZWQgYW55bW9yZSBiZWNhdXNlIHRoZSB1cGRhdGVk
Cj4gbG9ja2luZyBzcGVjaWZpY2F0aW9uIGNsYWltcyB0aGF0IGRtYS1idWYgcmVzZXJ2YXRpb24g
bXVzdCBiZSBsb2NrZWQKPiBieSBpbXBvcnRlcnMsIGFuZCB0aHVzLCB0aGUgaW50ZXJuYWwgZGF0
YSBpcyBhbHJlYWR5IHByb3RlY3RlZCBieSB0aGUKPiByZXNlcnZhdGlvbiBsb2NrLiBSZW1vdmUg
dGhlIG9ic29sZXRlZCBpbnRlcm5hbCBsb2NrLgo+Cj4gU2lnbmVkLW9mZi1ieTogRG1pdHJ5IE9z
aXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9kbWEtYnVmL2RtYS1idWYuYyB8IDE0ICsrKystLS0tLS0tLS0tCj4gICBpbmNsdWRlL2xpbnV4
L2RtYS1idWYuaCAgIHwgIDkgLS0tLS0tLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVm
L2RtYS1idWYuYyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMKPiBpbmRleCA2OTZkMTMyYjAy
ZjQuLmEwNDA2MjU0ZjBhZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5j
Cj4gKysrIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYwo+IEBAIC02NTYsNyArNjU2LDYgQEAg
c3RydWN0IGRtYV9idWYgKmRtYV9idWZfZXhwb3J0KGNvbnN0IHN0cnVjdCBkbWFfYnVmX2V4cG9y
dF9pbmZvICpleHBfaW5mbykKPiAgIAo+ICAgCWRtYWJ1Zi0+ZmlsZSA9IGZpbGU7Cj4gICAKPiAt
CW11dGV4X2luaXQoJmRtYWJ1Zi0+bG9jayk7Cj4gICAJSU5JVF9MSVNUX0hFQUQoJmRtYWJ1Zi0+
YXR0YWNobWVudHMpOwo+ICAgCj4gICAJbXV0ZXhfbG9jaygmZGJfbGlzdC5sb2NrKTsKPiBAQCAt
MTUwMyw3ICsxNTAyLDcgQEAgRVhQT1JUX1NZTUJPTF9OU19HUEwoZG1hX2J1Zl9tbWFwX3VubG9j
a2VkLCBETUFfQlVGKTsKPiAgIGludCBkbWFfYnVmX3ZtYXAoc3RydWN0IGRtYV9idWYgKmRtYWJ1
Ziwgc3RydWN0IGlvc3lzX21hcCAqbWFwKQo+ICAgewo+ICAgCXN0cnVjdCBpb3N5c19tYXAgcHRy
Owo+IC0JaW50IHJldCA9IDA7Cj4gKwlpbnQgcmV0Owo+ICAgCj4gICAJaW9zeXNfbWFwX2NsZWFy
KG1hcCk7Cj4gICAKPiBAQCAtMTUxNSwyOCArMTUxNCwyNSBAQCBpbnQgZG1hX2J1Zl92bWFwKHN0
cnVjdCBkbWFfYnVmICpkbWFidWYsIHN0cnVjdCBpb3N5c19tYXAgKm1hcCkKPiAgIAlpZiAoIWRt
YWJ1Zi0+b3BzLT52bWFwKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+IC0JbXV0ZXhfbG9j
aygmZG1hYnVmLT5sb2NrKTsKPiAgIAlpZiAoZG1hYnVmLT52bWFwcGluZ19jb3VudGVyKSB7Cj4g
ICAJCWRtYWJ1Zi0+dm1hcHBpbmdfY291bnRlcisrOwo+ICAgCQlCVUdfT04oaW9zeXNfbWFwX2lz
X251bGwoJmRtYWJ1Zi0+dm1hcF9wdHIpKTsKPiAgIAkJKm1hcCA9IGRtYWJ1Zi0+dm1hcF9wdHI7
Cj4gLQkJZ290byBvdXRfdW5sb2NrOwo+ICsJCXJldHVybiAwOwo+ICAgCX0KPiAgIAo+ICAgCUJV
R19PTihpb3N5c19tYXBfaXNfc2V0KCZkbWFidWYtPnZtYXBfcHRyKSk7Cj4gICAKPiAgIAlyZXQg
PSBkbWFidWYtPm9wcy0+dm1hcChkbWFidWYsICZwdHIpOwo+ICAgCWlmIChXQVJOX09OX09OQ0Uo
cmV0KSkKPiAtCQlnb3RvIG91dF91bmxvY2s7Cj4gKwkJcmV0dXJuIHJldDsKPiAgIAo+ICAgCWRt
YWJ1Zi0+dm1hcF9wdHIgPSBwdHI7Cj4gICAJZG1hYnVmLT52bWFwcGluZ19jb3VudGVyID0gMTsK
PiAgIAo+ICAgCSptYXAgPSBkbWFidWYtPnZtYXBfcHRyOwo+ICAgCj4gLW91dF91bmxvY2s6Cj4g
LQltdXRleF91bmxvY2soJmRtYWJ1Zi0+bG9jayk7Cj4gLQlyZXR1cm4gcmV0Owo+ICsJcmV0dXJu
IDA7Cj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX05TX0dQTChkbWFfYnVmX3ZtYXAsIERNQV9CVUYp
Owo+ICAgCj4gQEAgLTE1NzgsMTMgKzE1NzQsMTEgQEAgdm9pZCBkbWFfYnVmX3Z1bm1hcChzdHJ1
Y3QgZG1hX2J1ZiAqZG1hYnVmLCBzdHJ1Y3QgaW9zeXNfbWFwICptYXApCj4gICAJQlVHX09OKGRt
YWJ1Zi0+dm1hcHBpbmdfY291bnRlciA9PSAwKTsKPiAgIAlCVUdfT04oIWlvc3lzX21hcF9pc19l
cXVhbCgmZG1hYnVmLT52bWFwX3B0ciwgbWFwKSk7Cj4gICAKPiAtCW11dGV4X2xvY2soJmRtYWJ1
Zi0+bG9jayk7Cj4gICAJaWYgKC0tZG1hYnVmLT52bWFwcGluZ19jb3VudGVyID09IDApIHsKPiAg
IAkJaWYgKGRtYWJ1Zi0+b3BzLT52dW5tYXApCj4gICAJCQlkbWFidWYtPm9wcy0+dnVubWFwKGRt
YWJ1ZiwgbWFwKTsKPiAgIAkJaW9zeXNfbWFwX2NsZWFyKCZkbWFidWYtPnZtYXBfcHRyKTsKPiAg
IAl9Cj4gLQltdXRleF91bmxvY2soJmRtYWJ1Zi0+bG9jayk7Cj4gICB9Cj4gICBFWFBPUlRfU1lN
Qk9MX05TX0dQTChkbWFfYnVmX3Z1bm1hcCwgRE1BX0JVRik7Cj4gICAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9kbWEtYnVmLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1idWYuaAo+IGluZGV4
IGQ0OGQ1MzRkYzU1Yy4uYWVkNjY5NWJiYjUwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgv
ZG1hLWJ1Zi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9kbWEtYnVmLmgKPiBAQCAtMzI2LDE1ICsz
MjYsNiBAQCBzdHJ1Y3QgZG1hX2J1ZiB7Cj4gICAJLyoqIEBvcHM6IGRtYV9idWZfb3BzIGFzc29j
aWF0ZWQgd2l0aCB0aGlzIGJ1ZmZlciBvYmplY3QuICovCj4gICAJY29uc3Qgc3RydWN0IGRtYV9i
dWZfb3BzICpvcHM7Cj4gICAKPiAtCS8qKgo+IC0JICogQGxvY2s6Cj4gLQkgKgo+IC0JICogVXNl
ZCBpbnRlcm5hbGx5IHRvIHNlcmlhbGl6ZSBsaXN0IG1hbmlwdWxhdGlvbiwgYXR0YWNoL2RldGFj
aCBhbmQKPiAtCSAqIHZtYXAvdW5tYXAuIE5vdGUgdGhhdCBpbiBtYW55IGNhc2VzIHRoaXMgaXMg
c3VwZXJzZWVkZWQgYnkKPiAtCSAqIGRtYV9yZXN2X2xvY2soKSBvbiBAcmVzdi4KPiAtCSAqLwo+
IC0Jc3RydWN0IG11dGV4IGxvY2s7Cj4gLQo+ICAgCS8qKgo+ICAgCSAqIEB2bWFwcGluZ19jb3Vu
dGVyOgo+ICAgCSAqCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
