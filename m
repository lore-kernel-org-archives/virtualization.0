Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3120BC4332F
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 13:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC160832DB;
	Mon, 30 May 2022 13:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V4EarekWiG7K; Mon, 30 May 2022 13:41:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1ECF183415;
	Mon, 30 May 2022 13:41:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAD70C0039;
	Mon, 30 May 2022 13:41:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CBAFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86BC641A2A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uaiFm_QozM5g
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:41:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::604])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB9A541A26
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWhkfLs65iVQv0+mt9DfStWvXbcYjJJ5myovjcMm7Ta3TEc8sSAcaV4LMo2zqgR+vBqlLNSmRFohsrgyUsInoYd5+DGRszdinu+j5JN+Xf2DodW8bD1gWPlFV+09sBT7KNW5tj5QK2Sh4oW6W7OvKobFwceAn2zhioyqZvp6ITO7GoCZru13szVhTy/SqLqdOzvnjDJEZPrsIEvj9MRDMvKZdmgVMSDX7TapjTXFLfMCDFS9t41YHC2Rt7uqLOXdqQX0y/hDmGh1BLsIY1BOr9PBEJm+YzyhdStVZuqHnFtbsI9ytqL41Qk48Xt7IXUHFv9zqx86VgkV+m6QsooteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ln1IYHCrBrCaQS84rnoFBpWZLwjNyjzT+nTzcBkppU=;
 b=TbDgXJLIzJ1kD4HWYPsJhR7NFIxy3EhpXBGRzWXRJdA4R8akIE0mNkcsrvmfJAz4lulPj/sMPPQCa/9zrqiPCA+lhI0aTBQeVYGWHd0De7sUI2icHwV3YNIvWbvf7F6eexVOC6VIOcrzEFUQ4jUwj6+OZblwN/sO+6hsT8BfeLQMu2cBA7RslLAZK/5iloKeLLBiuNayQMhCPPCyoz4eHYyB6nJfv6m/A8/7UTuzzIieWcZh8zFnJvg1HxT0pvKs+4DKhFdae82/DR+biXmDn5S2wzlmCAtrhxEcYdanTas5gH0ADqC6dlTi+0rj+6RGs2XUqijMEibtP/AabWFOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ln1IYHCrBrCaQS84rnoFBpWZLwjNyjzT+nTzcBkppU=;
 b=13ehhYFfxSWwAGsLkIAQffpe4EG92IwRz4RVTkutxhpU6BCWdggdvfHywDUQDBskAdXfedmF+60Eub0upNf3famO8vYXRRxBpWsIgBxw8OR00s4Jvx8/Uaap5BBkXQrjccQMwNUdkxi+myiNcPi9scswbsI3ZxJspipPqOUWjAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 13:41:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 13:41:25 +0000
Message-ID: <02e7946b-34ca-b48e-1ba6-e7b63740a2d9@amd.com>
Date: Mon, 30 May 2022 15:41:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 14/22] dma-buf: Introduce new locking convention
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
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Clark <robdclark@gmail.com>, Emil Velikov <emil.l.velikov@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Qiang Yu <yuq825@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-15-dmitry.osipenko@collabora.com>
 <0a02a31d-a256-4ca4-0e35-e2ea1868a8ae@amd.com>
 <e6e17c52-43c2-064b-500e-325bb3ba3b2c@collabora.com>
In-Reply-To: <e6e17c52-43c2-064b-500e-325bb3ba3b2c@collabora.com>
X-ClientProxiedBy: AM6P193CA0085.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1ffce7a-8d23-4703-3cdb-08da42421776
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2441DBAE277206CC9B13C10D83DD9@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSW1wIoCn3nNFjZJBQ1vVHTV4DmbG7Pguh9zjakZuKfexezjAX9RzSr2q+jzbmy/pmZffq8/LpakTy5pBFcDAworhdC/7/i1vg8M76wK2hEcPOwrV+FPaB0gaA3b6ou5npDbyKmelZ9o+gLFGHSLYIU3WyrL1hcJOBI0x7269ze2XOmr65aRKKBRAOAKFE4eIofz0U1UsWLiaEW0mrxY+Ee15EUJ9ZYZ7ne4rzcGPgLsjOZfmF1QS+iCcpOmzeAI1mF0VzgjkT2h/p2o378+qIb0XPuGI0LsIwQne/y/bTWmX/uTsfwGfCD/X/eeNHuhGHUiawshG6purNZ3P/Gl01dBkomujtNqIs4WPJ4hS8GG22IvqjY7uC6dSKRf0cAq+4oyD/bzGNx4Q4Bov2KbPdu5eIkBJW6xmWZ06K5fQTS7KXP8+OlfnC761AirGjBvz7OEMdYQLCUVfPFRK07BX1r/misEdHCvyzWxfVu4F3iPlUe9On/qIFBrlz96lVC7reTmjbqZYQ1NIzFyNZhTvLrNDWr41V/dYj1meGasC4tGClUxRG/YlcJavEGJkX8mQDrlI/5fKT2RfGg6CU/wyQL9Tm6vuZ7hvtx8BOGDpoCXe1C3NpyFm0l0PU9dOkkHLMLsjlMILagVF1RYcItVWeef0wAN6sD52qXCXlEyWYwn5QL67/wSMGPmDIw7dy+c2nimlRzNxOJ1lrB1RZvmzLHGeK9QjXGqgL1dNa/xWsf/zWxEnElUKJib5NRQGmJm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(83380400001)(110136005)(66574015)(6666004)(6506007)(8936002)(7406005)(5660300002)(38100700002)(66476007)(66946007)(86362001)(26005)(66556008)(53546011)(186003)(7416002)(6486002)(36756003)(2616005)(8676002)(6512007)(31686004)(4326008)(31696002)(2906002)(921005)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0pPUFVQVUgyMjFNaVg2cE5QdUJjWG5Xb3FTOUlsNUhlRjVkMSsyRGM0NTNr?=
 =?utf-8?B?TU8xbURXdlZSRXh2TnhlanJramY2R0V2VDIvR2VzVnVqTlRLbWdkMTlFVnhp?=
 =?utf-8?B?OG44WGpBd0pRaHd5eXhTZmFHL0M4UUM0ZWtJVzFuSEUwQVZnT0d6QWFQYlc0?=
 =?utf-8?B?U1BsbkxtUytQV2hyaGtXVUdDY1FlQ1AwZTRvTDRkdENETGZtZ1Vwd0JvZFBU?=
 =?utf-8?B?emw4MUhDZmNhTWE3R3BwUVg1RzJ6bnQzejdhMG15MTNvcU9FWTAxdEJ1bkVl?=
 =?utf-8?B?TVlsb1pYTnlvYmtqTE5kK3lDU2Fld2lZSm15UkgzdmFEMmFkeEJLTUdoN255?=
 =?utf-8?B?TFR4TWRwSkw4cysyOXFTUUxsWTFrMndXTWxiajVJdmdwN3ZpNWVEZ0pubzkx?=
 =?utf-8?B?dHMxR0hidHZUKzlZbm1UZC9LOFFNQUJrdW80dnY3Q2dQK1F6NS82NHN5bVZs?=
 =?utf-8?B?RTFYWm5HOXN5SzB1Vjkyb2NHQVkxMWRkNU5jM2l5eU1NMVhUSWRFTkhHZ3Ra?=
 =?utf-8?B?dVBtRFJNbGt2RitTV1laQnBtdnkreGdRd0JocFFaVDlHSTFnMEpiMFVBUWoz?=
 =?utf-8?B?Mk14TkVXZDNoQlY1OXNYMGtQR09ZM29uTVdyVUJMeHp0MW0zMXlCdVphZ3do?=
 =?utf-8?B?dnBraTliZTZUMitDR0ZsUnF4ZE9VRy9vUzgwL1R3UVhMdi9OeXNhallkbTNK?=
 =?utf-8?B?eWl1b1pIREJrandSd21WeVd6VmhQTE9MaWJqZFA2eUlKNkltWi8vV1ZMRlpj?=
 =?utf-8?B?NmxvbXVEL0EvRW5NWlMzYWNyM2t4YTh0MmEwZE5MS0xsNVVVU0tqUGNIV2Zy?=
 =?utf-8?B?SlhNZldFaWN5eE01Vit3c2pMYlpxV09ZcExOcXpPYjltdDZwVGozT2FKSkpu?=
 =?utf-8?B?d3dnYTIrZVlmRXZPeklEYUg1Y21TUFE1ZTJEUGJabWE4NnpmMFNXeE9zTlhI?=
 =?utf-8?B?ZVY0cjBaeTMzalRYR2MyZisrRkNmL05BMEIrWXJxTlB0SzEwVEZPdi9TQW53?=
 =?utf-8?B?NkNnU1h2elNBcHBrRExlRzBSTVZPOW85Y2pEWE02NE9wTEg1bFhOL1ZvZ2Mv?=
 =?utf-8?B?Z0JIdnQ5Sld1OW53U0R5YTY2R294Y0ZrQTVERWl2QWJ5MVFMVHYzcXcrUk96?=
 =?utf-8?B?eEtTM3NPRzBmRGxNTk5ub2NrYUF1azRhS09LM0hEaSs0ZENZbVozWXBmR0t1?=
 =?utf-8?B?NE9RbDJzRDQxRkxHWDRSWHBDOFdyVkZXejJqZ2RHeHAySTFRL1pSTHlnWGhY?=
 =?utf-8?B?WExMYjBsRlpXTWNMTFZGUXdRMCswNjVHQU4zT2Rta2Y0YklUN0YvYVlVb0ti?=
 =?utf-8?B?VGVLY3YrNCtCVEFVbEJNb1h3YXJRMGZESERmS0w5ZFNWRTJXTTJKdy9WZi9x?=
 =?utf-8?B?VVU2VG1hbllJeW9CcFZGSTJNQlV1akJyenBQMThncW4zaTR4dit4KzRVQ3Er?=
 =?utf-8?B?WUlnUy90clRXS2MrNVV3WFBFWis1YWZRTFNUMnlNNWJWNElWaGdGU2hJUUZR?=
 =?utf-8?B?V0RFSCtNRTFnQTVHMEFqSDJMenBzYTluVkZwWlRmR1VLVWpXRkQxWmFUVEdk?=
 =?utf-8?B?ZmpnakorY0puZ2lKQ0JjVE4wSzMySVNTL0dBK0pFN0ZTWmM2YmVnNVZyLzNy?=
 =?utf-8?B?Q09zbUR5cjZtMXI4M1JmMlV0eWdFZTBrd1VZR0ZRbnZObkxjRHM3Q1pqWml1?=
 =?utf-8?B?d2E4czZZbjFwWFBaZ3VjWW1vWmYrOWFCNDdraEVqV3pFOTVqeThSbTdrcHpo?=
 =?utf-8?B?emVDNmd1MXJIZHd1MkplZGVJY001cSs4ZHFSaTg4ZHl4OS9zOVJMa0Q4dVNt?=
 =?utf-8?B?dnRFUUVnbkJCNkRaUFFKdGFuMTd2c0ZpSHdMLzN1MTUrUTJkdlVxY0V3SFFv?=
 =?utf-8?B?UHhaWlZUN1ZWQ3pmanYyVWc2eUo2by9qbDBnYm42YTRFQVM1TjdhMVM0M05P?=
 =?utf-8?B?M1RIQ1k1VE5MbUdhSHIyanBSdENHYTUwMWtTMjN0VndqVUl4REZBanV2V1hN?=
 =?utf-8?B?MzlueVd0dGZzM3M1MERRWlMyUStwTHpGbDczZ2JWMHhsd3NsaE93OTAyd2lW?=
 =?utf-8?B?WVFRdkJSdHpMSmxMWHZSYkw0ajZOWm5tRURiRnF4SWU3SUdNZ05VRDhCcWlF?=
 =?utf-8?B?Y0xycnVtejF1MXZWZ0p4Yzljem9KTzhJOXdMR3pLc1VMUEpwYjFYK0M0ZnA3?=
 =?utf-8?B?b2QycFAxTmJQUHRtRFcwcVM3dUFmUjgvamVsenVjM0pXb2lvSHJBMFA2RXBu?=
 =?utf-8?B?dS81TFRDK3ltdW1WSDF4b0x3K1lvNHZ5Zk40cEdRNCtSeGVFN2Z5cjBWQjZZ?=
 =?utf-8?B?eUVSU1c4eUErVUZwdVJlVXV4R1hxdElUOXJ1UEZyTHR4VEg2djdiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ffce7a-8d23-4703-3cdb-08da42421776
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 13:41:25.6964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKlBf/nVEJ1X9nxM5Oz0JjeCcNh0J4+oP26sfpG5+KmhP4Sme4vWuenl2MB9dIje
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
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

SGkgRG1pdHJ5LAoKQW0gMzAuMDUuMjIgdW0gMTU6MjYgc2NocmllYiBEbWl0cnkgT3NpcGVua286
Cj4gSGVsbG8gQ2hyaXN0aWFuLAo+Cj4gT24gNS8zMC8yMiAwOTo1MCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPj4gSGkgRG1pdHJ5LAo+Pgo+PiBGaXJzdCBvZiBhbGwgcGxlYXNlIHNlcGFyYXRl
IG91dCB0aGlzIHBhdGNoIGZyb20gdGhlIHJlc3Qgb2YgdGhlIHNlcmllcywKPj4gc2luY2UgdGhp
cyBpcyBhIGNvbXBsZXggc2VwYXJhdGUgc3RydWN0dXJhbCBjaGFuZ2UuCj4gSSBhc3N1bWUgYWxs
IHRoZSBwYXRjaGVzIHdpbGwgZ28gdmlhIHRoZSBEUk0gdHJlZSBpbiB0aGUgZW5kIHNpbmNlIHRo
ZQo+IHJlc3Qgb2YgdGhlIERSTSBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIGRlcGVuZCBvbiB0aGlz
IGRtYS1idWYgY2hhbmdlLgo+IEJ1dCBJIHNlZSB0aGF0IHNlcGFyYXRpb24gbWF5IGVhc2UgcmV2
aWV3aW5nIG9mIHRoZSBkbWEtYnVmIGNoYW5nZXMsIHNvCj4gbGV0J3MgdHJ5IGl0LgoKVGhhdCBz
b3VuZHMgbGlrZSB5b3UgYXJlIHVuZGVyZXN0aW1hdGluZyBhIGJpdCBob3cgbXVjaCB0cm91Ymxl
IHRoaXMgCndpbGwgYmUuCgo+PiBJIGhhdmUgdHJpZWQgdGhpcyBiZWZvcmUgYW5kIGZhaWxlZCBi
ZWNhdXNlIGNhdGNoaW5nIGFsbCB0aGUgbG9ja3MgaW4KPj4gdGhlIHJpZ2h0IGNvZGUgcGF0aHMg
YXJlIHZlcnkgdHJpY2t5LiBTbyBleHBlY3Qgc29tZSBmYWxsb3V0IGZyb20gdGhpcwo+PiBhbmQg
bWFrZSBzdXJlIHRoZSBrZXJuZWwgdGVzdCByb2JvdCBhbmQgQ0kgc3lzdGVtcyBhcmUgY2xlYW4u
Cj4gU3VyZSwgSSdsbCBmaXggdXAgYWxsIHRoZSByZXBvcnRlZCB0aGluZ3MgaW4gdGhlIG5leHQg
aXRlcmF0aW9uLgo+Cj4gQlRXLCBoYXZlIHlvdSBldmVyIHBvc3RlZCB5b3VycyB2ZXJzaW9uIG9m
IHRoZSBwYXRjaD8gV2lsbCBiZSBncmVhdCBpZgo+IHdlIGNvdWxkIGNvbXBhcmUgdGhlIGNoYW5n
ZWQgY29kZSBwYXRocy4KCk5vLCBJIG5ldmVyIGV2ZW4gZmluaXNoZWQgY3JlYXRpbmcgaXQgYWZ0
ZXIgcmVhbGl6aW5nIGhvdyBtdWNoIHdvcmsgaXQgCndvdWxkIGJlLgoKPj4+IFRoaXMgcGF0Y2gg
aW50cm9kdWNlcyBuZXcgbG9ja2luZyBjb252ZW50aW9uIGZvciBkbWEtYnVmIHVzZXJzLiBGcm9t
IG5vdwo+Pj4gb24gYWxsIGRtYS1idWYgaW1wb3J0ZXJzIGFyZSByZXNwb25zaWJsZSBmb3IgaG9s
ZGluZyBkbWEtYnVmIHJlc2VydmF0aW9uCj4+PiBsb2NrIGFyb3VuZCBvcGVyYXRpb25zIHBlcmZv
cm1lZCBvdmVyIGRtYS1idWZzLgo+Pj4KPj4+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyB0aGUgbmV3
IGRtYS1idWYgbG9ja2luZyBjb252ZW50aW9uIGJ5Ogo+Pj4KPj4+ICDCoMKgIDEuIE1ha2luZyBk
bWEtYnVmIEFQSSBmdW5jdGlvbnMgdG8gdGFrZSB0aGUgcmVzZXJ2YXRpb24gbG9jay4KPj4+Cj4+
PiAgwqDCoCAyLiBBZGRpbmcgbmV3IGxvY2tlZCB2YXJpYW50cyBvZiB0aGUgZG1hLWJ1ZiBBUEkg
ZnVuY3Rpb25zIGZvciBkcml2ZXJzCj4+PiAgwqDCoMKgwqDCoCB0aGF0IG5lZWQgdG8gbWFuYWdl
IGltcG9ydGVkIGRtYS1idWZzIHVuZGVyIHRoZSBoZWxkIGxvY2suCj4+IEluc3RlYWQgb2YgYWRk
aW5nIG5ldyBsb2NrZWQgdmFyaWFudHMgcGxlYXNlIG1hcmsgYWxsIHZhcmlhbnRzIHdoaWNoCj4+
IGV4cGVjdCB0byBiZSBjYWxsZWQgd2l0aG91dCBhIGxvY2sgd2l0aCBhbiBfdW5sb2NrZWQgcG9z
dGZpeC4KPj4KPj4gVGhpcyBzaG91bGQgbWFrZSBpdCBlYXNpZXIgdG8gcmVtb3ZlIHRob3NlIGlu
IGEgZm9sbG93IHVwIHBhdGNoIHNldCBhbmQKPj4gdGhlbiBmdWxseSBtb3ZlIHRoZSBsb2NraW5n
IGludG8gdGhlIGltcG9ydGVyLgo+IERvIHdlIHJlYWxseSB3YW50IHRvIG1vdmUgYWxsIHRoZSBs
b2NrcyB0byB0aGUgaW1wb3J0ZXJzPyBTZWVtcyB0aGUKPiBtYWpvcml0eSBvZiBkcml2ZXJzIHNo
b3VsZCBiZSBoYXBweSB3aXRoIHRoZSBkbWEtYnVmIGhlbHBlcnMgaGFuZGxpbmcKPiB0aGUgbG9j
a2luZyBmb3IgdGhlbS4KClllcywgSSBjbGVhcmx5IHRoaW5rIHNvLgoKPgo+Pj4gIMKgwqAgMy4g
Q29udmVydGluZyBhbGwgZHJpdmVycyB0byB0aGUgbmV3IGxvY2tpbmcgc2NoZW1lLgo+PiBJIGhh
dmUgc3Ryb25nIGRvdWJ0cyB0aGF0IHlvdSBnb3QgYWxsIG9mIHRoZW0uIEF0IGxlYXN0IHJhZGVv
biBhbmQKPj4gbm91dmVhdSBzaG91bGQgZ3JhYiB0aGUgcmVzZXJ2YXRpb24gbG9jayBpbiB0aGVp
ciAtPmF0dGFjaCBjYWxsYmFja3MKPj4gc29tZWhvdy4KPiBSYWRlb24gYW5kIE5vdXZlYXUgdXNl
IGdlbV9wcmltZV9pbXBvcnRfc2dfdGFibGUoKSBhbmQgdGhleSB0YWtlIHJlc3YKPiBsb2NrIGFs
cmVhZHksIHNlZW1zIHRoZXkgc2hvdWxkIGJlIG9rYXkgKD8pCgpZb3UgYXJlIGxvb2tpbmcgYXQg
dGhlIHdyb25nIHNpZGUuIFlvdSBuZWVkIHRvIGZpeCB0aGUgZXhwb3J0IGNvZGUgcGF0aCwgCm5v
dCB0aGUgaW1wb3J0IG9uZXMuCgpTZWUgZm9yIGV4YW1wbGUgYXR0YWNoIG9uIHJhZGVvbiB3b3Jr
cyBsaWtlIHRoaXMgCmRybV9nZW1fbWFwX2F0dGFjaC0+ZHJtX2dlbV9waW4tPnJhZGVvbl9nZW1f
cHJpbWVfcGluLT5yYWRlb25fYm9fcmVzZXJ2ZS0+dHRtX2JvX3Jlc2VydmUtPmRtYV9yZXN2X2xv
Y2suCgpTYW1lIGZvciBub3V2ZWF1IGFuZCBwcm9iYWJseSBhIGZldyBvdGhlciBleHBvcnRlcnMg
YXMgd2VsbC4gVGhhdCB3aWxsIApjZXJ0YWlubHkgY2F1c2UgYSBkZWFkbG9jayBpZiB5b3UgZG9u
J3QgZml4IGl0LgoKSSBzdHJvbmdseSBzdWdnZXN0IHRvIGRvIHRoaXMgc3RlcCBieSBzdGVwLCBm
aXJzdCBhdHRhY2gvZGV0YWNoIGFuZCB0aGVuIAp0aGUgcmVzdC4KClJlZ2FyZHMsCkNocmlzdGlh
bi4KCj4KPiBJIGFzc3VtZSBhbGwgdGhlIGJhc2ljcyBzaG91bGQgY292ZXJlZCBpbiB0aGlzIHY2
LiBBdCBtaW5pbXVtIEludGVsLAo+IFRlZ3JhLCBQYW5mcm9zdCwgTGltYSBhbmQgUm9ja2NoaXAg
ZHJpdmVycyBzaG91bGQgYmUgZ29vZC4gSWYgSSBtaXNzZWQKPiBzb21ldGhpbmcsIHRoZW4gcGxl
YXNlIGxldCBtZSBrbm93IGFuZCBJJ2xsIGNvcnJlY3QgaXQuCj4KPj4+IFNpZ25lZC1vZmYtYnk6
IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+Cj4+PiAtLS0K
Pj4+ICDCoCBkcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IDI3MCArKysrKysrKysrKy0tLS0tLS0KPj4+ICDCoCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmPCoMKgwqDCoMKgwqAgfMKgwqAgNiArLQo+
Pj4gIMKgIGRyaXZlcnMvZ3B1L2RybS9kcm1fY2xpZW50LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDQgKy0KPj4+ICDCoCBkcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzMgKysrCj4+PiAg
wqAgZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fZnJhbWVidWZmZXJfaGVscGVyLmPCoCB8wqDCoCA2
ICstCj4+PiAgwqAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL2k5MTVfZ2VtX2RtYWJ1Zi5jwqDC
oMKgIHzCoCAxMCArLQo+Pj4gIMKgIGRyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX29iamVjdC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE3ICstCj4+PiAgwqAgZHJpdmVycy9ncHUvZHJt
L3F4bC9xeGxfcHJpbWUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArLQo+
Pj4gIMKgIC4uLi9jb21tb24vdmlkZW9idWYyL3ZpZGVvYnVmMi1kbWEtY29udGlnLmPCoMKgIHzC
oCAxMSArLQo+Pj4gIMKgIC4uLi9tZWRpYS9jb21tb24vdmlkZW9idWYyL3ZpZGVvYnVmMi1kbWEt
c2cuYyB8wqAgMTEgKy0KPj4+ICDCoCAuLi4vY29tbW9uL3ZpZGVvYnVmMi92aWRlb2J1ZjItdm1h
bGxvYy5jwqDCoMKgwqDCoCB8wqAgMTEgKy0KPj4+ICDCoCBpbmNsdWRlL2RybS9kcm1fZ2VtLmjC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyAr
Cj4+PiAgwqAgaW5jbHVkZS9saW51eC9kbWEtYnVmLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTQgKy0KPj4+ICDCoCAxMyBmaWxlcyBjaGFuZ2VkLCAy
NDEgaW5zZXJ0aW9ucygrKSwgMTU5IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYwo+Pj4g
aW5kZXggMzJmNTU2NDA4OTBjLi42NGE5OTA5Y2NmYTIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L2RtYS1idWYvZG1hLWJ1Zi5jCj4+PiArKysgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jCj4+
PiBAQCAtNTUyLDcgKzU1Miw2IEBAIHN0cnVjdCBkbWFfYnVmICpkbWFfYnVmX2V4cG9ydChjb25z
dCBzdHJ1Y3QKPj4+IGRtYV9idWZfZXhwb3J0X2luZm8gKmV4cF9pbmZvKQo+Pj4gIMKgwqDCoMKg
wqAgZmlsZS0+Zl9tb2RlIHw9IEZNT0RFX0xTRUVLOwo+Pj4gIMKgwqDCoMKgwqAgZG1hYnVmLT5m
aWxlID0gZmlsZTsKPj4+ICDCoCAtwqDCoMKgIG11dGV4X2luaXQoJmRtYWJ1Zi0+bG9jayk7Cj4+
IFBsZWFzZSBtYWtlIHJlbW92aW5nIGRtYWJ1Zi0+bG9jayBhIHNlcGFyYXRlIGNoYW5nZS4KPiBB
bHJpZ2h0Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
