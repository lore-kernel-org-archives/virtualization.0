Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A94EC636D7
	for <virtualization@archiver.kernel.org>; Thu, 23 Feb 2023 09:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 033A5613F0;
	Thu, 23 Feb 2023 09:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 033A5613F0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jGd3P9uc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TzB5Hnvb6Fm1; Thu, 23 Feb 2023 09:18:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 38D93612DC;
	Thu, 23 Feb 2023 09:18:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38D93612DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B91CC0032;
	Thu, 23 Feb 2023 09:18:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87BBAC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 09:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AFA38124D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 09:18:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AFA38124D
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jGd3P9uc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tR-JLECSvdbR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 09:18:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EC4881240
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::619])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EC4881240
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 09:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPOAYz1NMbfnj/cwnB6cfLkOlp9e3c6rSEErZiFHQHUEuRjd4HbV0hAK8mwPpTpTvpoM/0DYnE0S8XPTro5MAdHg8IQ6sWNiljDxt5+Hen3yY2f62Wgsc+uRxp4CbUC+6oUYRrMkSoDvGaRuvW1x2fePWDB7StNoqKCnEWbK1tzKHGAy+i8ZvsZhcsIQ29i2TrgcqZTHUG+yF8Law+M33PNXWD2gLdpJW/sCpBW6evt4DAtbaaNYfaoaiHLTw+s6uHWPAvesUwpU8wTzwhlxiq0OsqLMqSILnyuOJbnha7jdPIdXSvzs2Ka7FdomZkeFDtng/US53zknnmn19ifZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZeiRy//KVgDgdQyhytdibbGkBTqwbKL9fdyy4glC30=;
 b=ChkmMhS3T6gstMeJ+MjPCiWJjzsFxtME/mXCm8IdXZEaIcpfet8F+T7bduQu7u9IntpIn3Wvcc0g6luiKz4bbTK+pqycV4e15FzLK3hY+TlaQGamFtT1ZVapUkfTaC1pJWL0MRJ3KDoTpP8fbiwTLEnMJot++E02kVkcJAHGJmXcE/1VNGuJP6qjg392JZ7PlG0mef4b3kKNheRw6SGjOZuaUWUroz2USYOofkvupJQ3ozwleJf34ze1IXO3vC7JnofuMA2UiPf6ThnZn4/bBrt7T6HS8JQXg93pxgvW3yRS8ku/znC8fN+efAw38CnIXdq5z002rh9NnQxfjvMqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZeiRy//KVgDgdQyhytdibbGkBTqwbKL9fdyy4glC30=;
 b=jGd3P9uc1LKjm54q279YNn6j/n/GsA6KTh6lVE0q6gnVVhqFjwMlu8pZL+dWQBH7jZWvOr+Ykf+ZtB0BJ34/gKspkr72eD2zBKJgfw4ii5HfrF1ycbPP/jVcIDZPgyiW1W5QPWB1EdfoFMSSJyqJLf5hhKgGpQds47BiD3oZoJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 09:18:03 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 09:18:03 +0000
Message-ID: <684016b7-4380-8e8c-0823-da1ef60052e6@amd.com>
Date: Thu, 23 Feb 2023 10:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/gem: Expose the buffer object handle to userspace last
Content-Language: en-US
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 dri-devel@lists.freedesktop.org
References: <20230214125050.1205394-1-tvrtko.ursulin@linux.intel.com>
 <f1256a51-5c4d-ab44-3867-931f7d2c0695@amd.com>
 <767620c4-385f-c0e8-dcb1-513ef4402ad0@linux.intel.com>
 <b7bb9888-b1d3-0d89-1e4f-bc25475b0071@gmail.com>
 <6e05c985-327f-7d6a-af4f-82b97378d0b5@linux.intel.com>
In-Reply-To: <6e05c985-327f-7d6a-af4f-82b97378d0b5@linux.intel.com>
X-ClientProxiedBy: FR3P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf27106-6e09-4f8f-96be-08db157edd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cx8XPTVH4owG5d67uO7NK5CXQQxXWnvJC5exAqamK2U6jIpOMg23lM6yNqWn8k5rFYayULqFzDEFcR5AcATuBlG7Igo7oS4upd9CirdkXOnKQPeutSAUdXZLXR4Sgk+YtbSjwLA6jKI5slw3tGQ0Y15KkBrai5pXDr+UsurIMb7vKt1WMWIUwQHBaOCsgEA3WRO2QU6K53Qll/qSc1y6j3nJGFlVOvNuOKsvWL1sbiPUxAXsMuWviy3Esr2Jc4wE9uv1dwtL039KGuMMGSKf+RuM0JvZg55CjyNy+wITa1sFEAAwOG6mQkqQCfN/jaMT1W0MeySG3hAz2pEnolNP4MM5K0Zf3oR0gfBhI9T+Zcl/tFzcCQeRtuuJJrODHevETIYeLcETUgrjzUcCMVrmkfOQqLX7XisCibzXiOOPZJ7EXVYmqkEzMREutUWgIZsvPrKA/9+KDn281cMZWnif8mqFAfVt7esdMjbtrMFEMEa4qJKZD6VYVS+I0OF7QB4UlfTjrGouPM+ihqUufOjL+R40/1HXpbmDb0kS0w6l6RDdd0fzJjbT2qveolr9tnlumKAYxPwqMnhLaljM/5I3CIyrTMxqWrcJIORyaIu8Wdqi6vQEXOoy7sC2cPK8U3p/FDQ4l6n1TzX8GUevi8qN42O/NQCXaSe0jIKUqscRazeI5UL+TlrTdHDFUaKkmvgif1ovm65VykF/dGhRemhELHAhHAUCv6pI6gY6HP+ATSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199018)(66946007)(4326008)(66476007)(66556008)(8676002)(83380400001)(86362001)(31696002)(66574015)(2616005)(38100700002)(6512007)(54906003)(110136005)(36756003)(316002)(6666004)(53546011)(186003)(26005)(6506007)(478600001)(6486002)(8936002)(7416002)(5660300002)(2906002)(31686004)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkI1WXQ0dVhMRWphSWZpbHloQmdNbFU4bFp4a0xxZWlLbnBLaTFhaVlPbmNS?=
 =?utf-8?B?Y296eVJZTWMydlAxQXdhRzZWUU02TUZYcmVqT0JHdGtEV2RkMTlXK1hJTU9o?=
 =?utf-8?B?c3BvWm9ORXoxeW5zNjZ6ZG9mQ2lUNVIzRlNST0hSSFBoSWVHSXVqL25yUjIr?=
 =?utf-8?B?Q2lCMFV5L0E1K1YvbHNoQ21RYXFJd2FyZ2RJOWZaQjhDTEtjVitJZHlhaUZi?=
 =?utf-8?B?Q1BGbzRIZzJNU1FoYWl0L3hSZ01EKytpQmxvZG1FTEd3RVplTmZKbUdTMHBK?=
 =?utf-8?B?VVRxclV0c0VSVTJJc0wwNDdDSGZiam56YUYzOTFjL2x6L2Q0VXVxNFRkb0RP?=
 =?utf-8?B?dnlMcit4bHhuamgwNFlraURVQXg0SmZadzRFVUxrVmFrQVpiMG1POXNEZGJm?=
 =?utf-8?B?WUlNRlI2UGZhdzNOR0VQdURVWFRLVG1QWWNLSytOTWh3OGw3blJYdEU0RlZp?=
 =?utf-8?B?cnRNWjBBQUhVc21PNDNQbGE0aGxncmtHeDdJM1A2UXo5Si80VTNFenhxWlFr?=
 =?utf-8?B?azBpV1hLdXJPYWIzTjhOeXp0V0hEQzh3RUhrMlowVGJsaWFReXEvSkE3ZDJN?=
 =?utf-8?B?MjJEL3ZCd29XdDFrTGJ6a1FiZGZ1dlVLRjM5N0FBWkxZWnRpRDVEUDNTVDBU?=
 =?utf-8?B?WGhkMHUxcU91RG91UlNDTUFLMk1RZE1FRzZaNndhcG1ockp6d1JDTzFCb2pP?=
 =?utf-8?B?RUlzaktaTW9vK1pSemtjdGUyT1k3N0hYdFRjNGlKbm9iWHJ4cmlUbVNyWmpr?=
 =?utf-8?B?bUdzUVU3dmRSMXROZFhnTkgwRzlnY2lIZFkwN08yNDNXYkJtZlNBQ0RUcGJB?=
 =?utf-8?B?enhSdHJtaGhqK3U3M2tmUFVmRnFMNGNmbWF6Wit6anByL3ZybDl1blBJdDVR?=
 =?utf-8?B?VHpLR3EwVUN3SjRwZWF0YUNLVGc2MFE0dHFtS1ZUVU5sa0w0bkVlSmFuNlV6?=
 =?utf-8?B?aWROeFQ1aTBHV3ZSTUF2SmZtZmNzZm9RaXBRWTVLZjN3ZjRDN0Y5RkhSZDNK?=
 =?utf-8?B?WHpLbGptQ1VScHRKK1JIT21oUVY4ZHRaeENlZnh6cW1OUkZSTW9QS3JiSWZS?=
 =?utf-8?B?MHJKVFlXaXZiL3BHYzd2bXRva1dtQWtJNHBZZndBeFVLZFErdUZtVnYra1pO?=
 =?utf-8?B?dnBGNFlralZ3VVhyb1IzNjVydnl1d2FZSHVjbHhrQUMyN055cXRaM282Ulh0?=
 =?utf-8?B?MnJ2bWFqZFplRXJzTHZoMFAwK2ZsQzczb1VBSlR5clZURUpZRm41ejdrLy94?=
 =?utf-8?B?WXFnbERZTlV6YkZKSGJPUElNbGY3MmFmT3BVOTA4SktIK3RCb3JCZ1o4RGNR?=
 =?utf-8?B?cDNma3BLVHRuOWdZUy8zNlV6WEF0aWxuQ29qR1Qyc2w5NWsrUWdrTjlERytl?=
 =?utf-8?B?d3lDVlkrZEtGUWVRUjNRSHZtUW8za1J6cEdzTlBpWGF6QlI3dDhCREFjbHEx?=
 =?utf-8?B?N205K1JjTHFMZ2J0QlozczRNeVFnZEg2RVVRand0VFMzQkp5UWt2TXZ6RWVV?=
 =?utf-8?B?UFo3QU9zSnIwY0dyRlA0M0VUQ0pOYUs2Q21yMW5SME1ndjRXV3VUc0Rwandq?=
 =?utf-8?B?TXJKak8yWjV3UXQwcVRVUnVjbnFONXdiZ3ozekVuWExlVFU0Yy9wUXplQldS?=
 =?utf-8?B?bGZ1NGN2ZENLN3lYUjFsUGxQd0NYUk5wUHhhUkhITkpuVElDaVl5ZXhHRWNo?=
 =?utf-8?B?cndtK25NdTh2cVRIZ1RrekhKZWRCRTRQYWIyOGFVdkVvMWhzblNuUVp3Qy9j?=
 =?utf-8?B?cThrc2RtQk9Rbks1SUxGd3JDRk5KUkgrUkVGNEpJV2hpWStqWTJQdUNjT0pZ?=
 =?utf-8?B?VnY2clczeVFUbW1KUEJNMm4vdkFYeG43RU1WTk9idFdLaHVQbWRUT0xhMDBh?=
 =?utf-8?B?WHlHVk10K0N6cjVIWjB2cFViaExISmRIc0ZnQ1lrNkI3NTRNMHdyUmovU0N4?=
 =?utf-8?B?aldsbUdqQXBIZDEwcmVjc3JrcHY4cmUrTjUvNkxTM3A2NFVlUDM5RkFZaDRN?=
 =?utf-8?B?N1dvcnZBVmx0MmZacUo4aVN6VTIrcmttVDFnWHdyOWc4K2toK2ZTSktET2dk?=
 =?utf-8?B?SFFyYUV3NUt1aEZ6Sm45ZVM2YWJjdDBQVXhGQm9HZVZOaGxvYkc1MXdWYTMz?=
 =?utf-8?Q?g7q59xcQttjXiYwCGleDr2Q9S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf27106-6e09-4f8f-96be-08db157edd84
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 09:18:03.0511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exvlhhGantyzncCjLwk38StyDV96Tduy9W6tTHZifEykFmJ/cJ9syietjWgOaXFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
Cc: Rob Clark <robdclark@chromium.org>, lima@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>, nouveau@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
 Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Herrmann <dh.herrmann@gmail.com>, spice-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, David Airlie <airlied@gmail.com>,
 Zack Rusin <zackr@vmware.com>
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

QW0gMjAuMDIuMjMgdW0gMTE6MjMgc2NocmllYiBUdnJ0a28gVXJzdWxpbjoKPgo+IE9uIDIwLzAy
LzIwMjMgMTA6MDEsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDIwLjAyLjIzIHVtIDEw
OjU1IHNjaHJpZWIgVHZydGtvIFVyc3VsaW46Cj4+Pgo+Pj4gSGksCj4+Pgo+Pj4gT24gMTQvMDIv
MjAyMyAxMzo1OSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBBbSAxNC4wMi4yMyB1bSAx
Mzo1MCBzY2hyaWViIFR2cnRrbyBVcnN1bGluOgo+Pj4+PiBGcm9tOiBUdnJ0a28gVXJzdWxpbiA8
dHZydGtvLnVyc3VsaW5AaW50ZWwuY29tPgo+Pj4+Pgo+Pj4+PiBDdXJyZW50bHkgZHJtX2dlbV9o
YW5kbGVfY3JlYXRlX3RhaWwgZXhwb3NlcyB0aGUgaGFuZGxlIHRvIHVzZXJzcGFjZQo+Pj4+PiBi
ZWZvcmUgdGhlIGJ1ZmZlciBvYmplY3QgY29uc3RydWN0aW9ucyBpcyBjb21wbGV0ZS4gVGhpcyBh
bGxvd2luZwo+Pj4+PiBvZiB3b3JraW5nIGFnYWluc3QgYSBwYXJ0aWFsbHkgY29uc3RydWN0ZWQg
b2JqZWN0LCB3aGljaCBtYXkgYWxzbyAKPj4+Pj4gYmUgaW4KPj4+Pj4gdGhlIHByb2Nlc3Mgb2Yg
aGF2aW5nIGl0cyBjcmVhdGlvbiBmYWlsLCBjYW4gaGF2ZSBhIHJhbmdlIG9mIG5lZ2F0aXZlCj4+
Pj4+IG91dGNvbWVzLgo+Pj4+Pgo+Pj4+PiBBIGxvdCBvZiB0aG9zZSB3aWxsIGRlcGVuZCBvbiB3
aGF0IHRoZSBpbmRpdmlkdWFsIGRyaXZlcnMgYXJlIAo+Pj4+PiBkb2luZyBpbgo+Pj4+PiB0aGVp
ciBvYmotPmZ1bmNzLT5vcGVuKCkgY2FsbGJhY2tzLCBhbmQgYWxzbyB3aXRoIGEgY29tbW9uIGZh
aWx1cmUgCj4+Pj4+IG1vZGUKPj4+Pj4gYmVpbmcgLUVOT01FTSBmcm9tIGRybV92bWFfbm9kZV9h
bGxvdy4KPj4+Pj4KPj4+Pj4gV2UgY2FuIG1ha2Ugc3VyZSBub25lIG9mIHRoaXMgY2FuIGhhcHBl
biBieSBhbGxvY2F0aW5nIGEgaGFuZGxlIGxhc3QsCj4+Pj4+IGFsdGhvdWdoIHdpdGggYSBkb3du
c2lkZSB0aGF0IG1vcmUgb2YgdGhlIGZ1bmN0aW9uIG5vdyBydW5zIHVuZGVyIHRoZQo+Pj4+PiBk
ZXYtPm9iamVjdF9uYW1lX2xvY2suCj4+Pj4+Cj4+Pj4+IExvb2tpbmcgaW50byB0aGUgaW5kaXZp
ZHVhbCBkcml2ZXJzIG9wZW4oKSBob29rcywgd2UgaGF2ZQo+Pj4+PiBhbWRncHVfZ2VtX29iamVj
dF9vcGVuIHdoaWNoIHNlZW1zIGxpa2UgaXQgY291bGQgaGF2ZSBhIHBvdGVudGlhbCAKPj4+Pj4g
c2VjdXJpdHkKPj4+Pj4gaXNzdWUgd2l0aG91dCB0aGlzIGNoYW5nZS4KPj4+Pj4KPj4+Pj4gQSBj
b3VwbGUgZHJpdmVycyBsaWtlIHF4bF9nZW1fb2JqZWN0X29wZW4gYW5kIHZtd19nZW1fb2JqZWN0
X29wZW4KPj4+Pj4gaW1wbGVtZW50IG5vLW9wIGhvb2tzIHNvIG5vIGltcGFjdCBmb3IgdGhlbS4K
Pj4+Pj4KPj4+Pj4gQSBidW5jaCBvZiBvdGhlciByZXF1aXJlIGEgZGVlcGVyIGxvb2sgYnkgaW5k
aXZpZHVhbCBvd25lcnMgdG8gCj4+Pj4+IGFzc2VzIGZvcgo+Pj4+PiBpbXBhY3QuIFRob3NlIGFy
ZSBsaW1hX2dlbV9vYmplY3Rfb3Blbiwgbm91dmVhdV9nZW1fb2JqZWN0X29wZW4sCj4+Pj4+IHBh
bmZyb3N0X2dlbV9vcGVuLCByYWRlb25fZ2VtX29iamVjdF9vcGVuIGFuZCAKPj4+Pj4gdmlydGlv
X2dwdV9nZW1fb2JqZWN0X29wZW4uCj4+Pj4+Cj4+Pj4+IFB1dHRpbmcgYXNpZGUgdGhlIHJpc2sg
YXNzZXNtZW50IG9mIHRoZSBhYm92ZSwgc29tZSBjb21tb24gCj4+Pj4+IHNjZW5hcmlvcyB0bwo+
Pj4+PiB0aGluayBhYm91dCBhcmUgYWxvbmcgdGhlc2UgbGluZXM6Cj4+Pj4+Cj4+Pj4+IDEpCj4+
Pj4+IFVzZXJzcGFjZSBjbG9zZXMgYSBoYW5kbGUgYnkgc3BlY3VsYXRpdmVseSAiZ3Vlc3Npbmci
IGl0IGZyb20gYSAKPj4+Pj4gc2Vjb25kCj4+Pj4+IHRocmVhZC4KPj4+Pj4KPj4+Pj4gVGhpcyBy
ZXN1bHRzIGluIGFuIHVucmVhY2hhYmxlIGJ1ZmZlciBvYmplY3Qgc28sIGEgbWVtb3J5IGxlYWsu
Cj4+Pj4+Cj4+Pj4+IDIpCj4+Pj4+IFNhbWUgYXMgMSksIGJ1dCBvYmplY3QgaXMgaW4gdGhlIHBy
b2Nlc3Mgb2YgZ2V0dGluZyBjbG9zZWQgKGZhaWxlZAo+Pj4+PiBjcmVhdGlvbikuCj4+Pj4+Cj4+
Pj4+IFRoZSBzZWNvbmQgdGhyZWFkIGlzIHRoZW4gYWJsZSB0byByZS1jeWNsZSB0aGUgaGFuZGxl
IGFuZCAKPj4+Pj4gaWRyX3JlbW92ZSB3b3VsZAo+Pj4+PiBpbiB0aGUgZmlyc3QgdGhyZWFkIHdv
dWxkIHRoZW4gcmVtb3ZlIHRoZSBoYW5kbGUgaXQgZG9lcyBub3Qgb3duIAo+Pj4+PiBmcm9tIHRo
ZQo+Pj4+PiBpZHIuCj4+Pj4+Cj4+Pj4+IDMpCj4+Pj4+IEdvaW5nIGJhY2sgdG8gdGhlIGVhcmxp
ZXIgcGVyIGRyaXZlciBwcm9ibGVtIHNwYWNlIC0gaW5kaXZpZHVhbCAKPj4+Pj4gaW1wYWN0Cj4+
Pj4+IGFzc2VzbWVudCBvZiBhbGxvd2luZyBhIHNlY29uZCB0aHJlYWQgdG8gYWNjZXNzIGFuZCBv
cGVyYXRlIG9uIGEgCj4+Pj4+IHBhcnRpYWxseQo+Pj4+PiBjb25zdHJ1Y3RlZCBoYW5kbGUgLyBv
YmplY3QuIChDYW4gc29tZXRoaW5nIGNyYXNoPyBMZWFrIGluZm9ybWF0aW9uPykKPj4+Pj4KPj4+
Pj4gSW4gdGVybXMgb2YgaWRlbnRpZnlpbmcgd2hlbiB0aGUgcHJvYmxlbSBzdGFydGVkIEkgd2ls
bCB0YWcgc29tZSAKPj4+Pj4gcGF0Y2hlcwo+Pj4+PiBhcyByZWZlcmVuY2VzLCBidXQgbm90IGFs
bCwgaWYgZXZlbiBhbnksIG9mIHRoZW0gYWN0dWFsbHkgcG9pbnQgdG8gYQo+Pj4+PiBicm9rZW4g
c3RhdGUuIEkgYW0ganVzdCBpZGVudGlmeWluZyBwb2ludHMgYXQgd2hpY2ggbW9yZSAKPj4+Pj4g
b3Bwb3J0dW5pdHkgZm9yCj4+Pj4+IGlzc3VlcyB0byBhcmlzZSB3YXMgYWRkZWQuCj4+Pj4KPj4+
PiBZZXMgSSd2ZSBsb29rZWQgaW50byB0aGlzIG9uY2UgYXMgd2VsbCwgYnV0IGNvdWxkbid0IGNv
bXBsZXRlbHkgCj4+Pj4gc29sdmUgaXQgZm9yIHNvbWUgcmVhc29uLgo+Pj4+Cj4+Pj4gR2l2ZSBt
ZSBhIGRheSBvciB0d28gdG8gZ2V0IHRoaXMgdGVzdGVkIGFuZCBhbGwgdGhlIGxvZ2ljIHN3YXBw
ZWQgCj4+Pj4gYmFjayBpbnRvIG15IGhlYWQgYWdhaW4uCj4+Pgo+Pj4gTWFuYWdlZCB0byByZWNv
bGxlY3Qgd2hhdCB0aGUgcHJvYmxlbSB3aXRoIGVhcmxpZXIgYXR0ZW1wdHMgd2FzPwo+Pgo+PiBO
b3BlLCB0aGF0J3Mgd2F5IHRvIGxvbmcgYWdvLiBJIGNhbiBvbmx5IGFzc3VtZSB0aGF0IEkgcmFu
IGludG8gCj4+IHByb2JsZW1zIHdpdGggdGhlIG9iamVjdF9uYW1lX2xvY2suCj4+Cj4+IFByb2Jh
Ymx5IGJlc3QgdG8gZG91YmxlIGNoZWNrIGlmIHRoYXQgZG9lc24ndCByZXN1bHQgaW4gYSBsb2Nr
IAo+PiBpbnZlcnNpb24gd2hlbiBzb21lYm9keSBncmFicyB0aGUgcmVzZXJ2YXRpb24gbG9jayBp
biB0aGVpciAtPmxvYWQoKSAKPj4gY2FsbGJhY2suCj4KPiBIbW0gSSBkb24ndCBpbW1lZGlhdGVs
eSBmb2xsb3cgdGhlIGNvbm5lY3Rpb24uIEJ1dCBJIGhhdmUgb25seSBmb3VuZCAKPiByYWRlb25f
ZHJpdmVyX2xvYWRfa21zIGFzIHVzaW5nIHRoZSBsb2FkIGNhbGxiYWNrLiBJcyB0aGVyZSBhbnkg
Cj4gbG9ja2RlcCBlbmFibGVkIENJIGZvciB0aGF0IGRyaXZlciB3aGljaCBjb3VsZCB0ZWxsIHVz
IGlmIHRoZXJlIGlzIGEgCj4gcHJvYmxlbSB0aGVyZT8KCldlIGRvbid0IGhhdmUgQ0kgZm9yIHJh
ZGVvbiBhbmQgbW9zdCBsaWtlbHkgbmV2ZXIgd2lsbCwgdGhhdCBodyBpcyBqdXN0IAp0byBvbGQu
IEJ1dCB3ZSBhbHNvIGhhdmUgYW1kZ3B1X2dlbV9vYmplY3Rfb3BlbigpIGFuZCB0aGF0IGxvb2tz
IApzdXNwaWNpb3VzbHkgbGlrZSB0cm91YmxlLgoKVGhlIGZ1bmN0aW9uIG1ha2VzIHN1cmUgdGhh
dCBldmVyeSBCTyBpcyByZWdpc3RlcmVkIGluIHRoZSBWTSBob3VzZSAKa2VlcGluZyBmdW5jdGlv
bnMgb2YgdGhlIGRybV9maWxlIGFuZCB3aGlsZSBkb2luZyBzbyBncmFicyBhIGZldyBsb2Nrcy4g
CkknbSBub3Qgc3VyZSB3aGF0IHRoZSBsb2NraW5nIG9yZGVyIG9mIHRob3NlIGFyZS4KCkNvdWxk
IGJlIHRoYXQgdGhpcyB3aWxsIHdvcmssIGNvdWxkIGJlIHRoYXQgaXQgYnJlYWtzLiBJIHdpbGwg
cGluZyAKaW50ZXJuYWxseSB0b2RheSBpZiBzb21lYm9keSBmcm9tIG15IHRlYW0gY2FuIHRha2Ug
YSBsb29rIGF0IHRoaXMgcGF0Y2guCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywK
Pgo+IFR2cnRrbwo+Cj4+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+Cj4+PiBSZWdh
cmRzLAo+Pj4KPj4+IFR2cnRrbwo+Pj4KPj4+PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4KPj4+Pj4g
UmVmZXJlbmNlczogMzA0ZWRhMzI5MjBiICgiZHJtL2dlbTogYWRkIGhvb2tzIHRvIG5vdGlmeSBk
cml2ZXIgCj4+Pj4+IHdoZW4gb2JqZWN0IGhhbmRsZSBpcyBjcmVhdGVkL2Rlc3Ryb3llZCIpCj4+
Pj4+IFJlZmVyZW5jZXM6IGNhNDgxYzliMmEzYSAoImRybS9nZW06IGltcGxlbWVudCB2bWEgYWNj
ZXNzIG1hbmFnZW1lbnQiKQo+Pj4+PiBSZWZlcmVuY2VzOiBiMzliNTM5NGZhYmMgKCJkcm0vZ2Vt
OiBBZGQgZHJtX2dlbV9vYmplY3RfZnVuY3MiKQo+Pj4+PiBDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+Pj4+PiBDYzogUm9iIENsYXJrIDxyb2JkY2xhcmtAY2hyb21pdW0ub3Jn
Pgo+Pj4+PiBDYzogQmVuIFNrZWdncyA8YnNrZWdnc0ByZWRoYXQuY29tPgo+Pj4+PiBDYzogRGF2
aWQgSGVycm1hbm4gPGRoLmhlcnJtYW5uQGdtYWlsLmNvbT4KPj4+Pj4gQ2M6IE5vcmFsZiBUcsO4
bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgo+Pj4+PiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVk
QGdtYWlsLmNvbT4KPj4+Pj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPj4+
Pj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4+IENjOiBsaW1hQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+Pj4+PiBDYzogbm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Pj4+Pj4gQ2M6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5jb20+Cj4+Pj4+IENjOiB2
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+Pj4+PiBDYzogc3BpY2Ut
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4+IENjOiBaYWNrIFJ1c2luIDx6YWNrckB2
bXdhcmUuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyB8
IDQ4IAo+Pj4+PiArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+Pj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQo+Pj4+
Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9kcm1fZ2VtLmMKPj4+Pj4gaW5kZXggYWExNWM1MmFlMTgyLi5lM2Q4OTdiY2EwZjIg
MTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPj4+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+Pj4+PiBAQCAtMzU2LDUyICszNTYsNTIgQEAgZHJt
X2dlbV9oYW5kbGVfY3JlYXRlX3RhaWwoc3RydWN0IGRybV9maWxlIAo+Pj4+PiAqZmlsZV9wcml2
LAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgKmhhbmRsZXApCj4+
Pj4+IMKgIHsKPj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gb2JqLT5k
ZXY7Cj4+Pj4+IC3CoMKgwqAgdTMyIGhhbmRsZTsKPj4+Pj4gwqDCoMKgwqDCoCBpbnQgcmV0Owo+
Pj4+PiBXQVJOX09OKCFtdXRleF9pc19sb2NrZWQoJmRldi0+b2JqZWN0X25hbWVfbG9jaykpOwo+
Pj4+PiDCoMKgwqDCoMKgIGlmIChvYmotPmhhbmRsZV9jb3VudCsrID09IDApCj4+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBkcm1fZ2VtX29iamVjdF9nZXQob2JqKTsKPj4+Pj4gK8KgwqDCoCByZXQg
PSBkcm1fdm1hX25vZGVfYWxsb3coJm9iai0+dm1hX25vZGUsIGZpbGVfcHJpdik7Cj4+Pj4+ICvC
oMKgwqAgaWYgKHJldCkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3B1dDsKPj4+Pj4g
Kwo+Pj4+PiArwqDCoMKgIGlmIChvYmotPmZ1bmNzLT5vcGVuKSB7Cj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCByZXQgPSBvYmotPmZ1bmNzLT5vcGVuKG9iaiwgZmlsZV9wcml2KTsKPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGlmIChyZXQpCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJy
X3Jldm9rZTsKPj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+ICsKPj4+Pj4gwqDCoMKgwqDCoCAvKgo+Pj4+
PiAtwqDCoMKgwqAgKiBHZXQgdGhlIHVzZXItdmlzaWJsZSBoYW5kbGUgdXNpbmcgaWRyLsKgIFBy
ZWxvYWQgYW5kIHBlcmZvcm0KPj4+Pj4gLcKgwqDCoMKgICogYWxsb2NhdGlvbiB1bmRlciBvdXIg
c3BpbmxvY2suCj4+Pj4+ICvCoMKgwqDCoCAqIEdldCB0aGUgdXNlci12aXNpYmxlIGhhbmRsZSB1
c2luZyBpZHIgYXMgdGhlIF9sYXN0XyBzdGVwLgo+Pj4+PiArwqDCoMKgwqAgKiBQcmVsb2FkIGFu
ZCBwZXJmb3JtIGFsbG9jYXRpb24gdW5kZXIgb3VyIHNwaW5sb2NrLgo+Pj4+PiDCoMKgwqDCoMKg
wqAgKi8KPj4+Pj4gwqDCoMKgwqDCoCBpZHJfcHJlbG9hZChHRlBfS0VSTkVMKTsKPj4+Pj4gwqDC
oMKgwqDCoCBzcGluX2xvY2soJmZpbGVfcHJpdi0+dGFibGVfbG9jayk7Cj4+Pj4+IC0KPj4+Pj4g
wqDCoMKgwqDCoCByZXQgPSBpZHJfYWxsb2MoJmZpbGVfcHJpdi0+b2JqZWN0X2lkciwgb2JqLCAx
LCAwLCBHRlBfTk9XQUlUKTsKPj4+Pj4gLQo+Pj4+PiDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZm
aWxlX3ByaXYtPnRhYmxlX2xvY2spOwo+Pj4+PiDCoMKgwqDCoMKgIGlkcl9wcmVsb2FkX2VuZCgp
Owo+Pj4+PiAtwqDCoMKgIG11dGV4X3VubG9jaygmZGV2LT5vYmplY3RfbmFtZV9sb2NrKTsKPj4+
Pj4gwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGdvdG8gZXJy
X3VucmVmOwo+Pj4+PiAtCj4+Pj4+IC3CoMKgwqAgaGFuZGxlID0gcmV0Owo+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgZ290byBlcnJfY2xvc2U7Cj4+Pj4+IC3CoMKgwqAgcmV0ID0gZHJtX3ZtYV9ub2Rl
X2FsbG93KCZvYmotPnZtYV9ub2RlLCBmaWxlX3ByaXYpOwo+Pj4+PiAtwqDCoMKgIGlmIChyZXQp
Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9yZW1vdmU7Cj4+Pj4+ICvCoMKgwqAgbXV0
ZXhfdW5sb2NrKCZkZXYtPm9iamVjdF9uYW1lX2xvY2spOwo+Pj4+PiAtwqDCoMKgIGlmIChvYmot
PmZ1bmNzLT5vcGVuKSB7Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXQgPSBvYmotPmZ1bmNzLT5v
cGVuKG9iaiwgZmlsZV9wcml2KTsKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+Pj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3Jldm9rZTsKPj4+Pj4gLcKgwqDCoCB9
Cj4+Pj4+ICvCoMKgwqAgKmhhbmRsZXAgPSByZXQ7Cj4+Pj4+IC3CoMKgwqAgKmhhbmRsZXAgPSBo
YW5kbGU7Cj4+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+ICtlcnJfY2xvc2U6Cj4+Pj4+
ICvCoMKgwqAgaWYgKG9iai0+ZnVuY3MtPmNsb3NlKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgb2Jq
LT5mdW5jcy0+Y2xvc2Uob2JqLCBmaWxlX3ByaXYpOwo+Pj4+PiDCoCBlcnJfcmV2b2tlOgo+Pj4+
PiDCoMKgwqDCoMKgIGRybV92bWFfbm9kZV9yZXZva2UoJm9iai0+dm1hX25vZGUsIGZpbGVfcHJp
dik7Cj4+Pj4+IC1lcnJfcmVtb3ZlOgo+Pj4+PiAtwqDCoMKgIHNwaW5fbG9jaygmZmlsZV9wcml2
LT50YWJsZV9sb2NrKTsKPj4+Pj4gLcKgwqDCoCBpZHJfcmVtb3ZlKCZmaWxlX3ByaXYtPm9iamVj
dF9pZHIsIGhhbmRsZSk7Cj4+Pj4+IC3CoMKgwqAgc3Bpbl91bmxvY2soJmZpbGVfcHJpdi0+dGFi
bGVfbG9jayk7Cj4+Pj4+IC1lcnJfdW5yZWY6Cj4+Pj4+IC3CoMKgwqAgZHJtX2dlbV9vYmplY3Rf
aGFuZGxlX3B1dF91bmxvY2tlZChvYmopOwo+Pj4+PiArZXJyX3B1dDoKPj4+Pj4gK8KgwqDCoCBp
ZiAoLS1vYmotPmhhbmRsZV9jb3VudCA9PSAwKQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZHJtX2dl
bV9vYmplY3RfcHV0KG9iaik7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCBtdXRleF91bmxvY2soJmRl
di0+b2JqZWN0X25hbWVfbG9jayk7Cj4+Pj4+ICsKPj4+Pj4gwqDCoMKgwqDCoCByZXR1cm4gcmV0
Owo+Pj4+PiDCoCB9Cj4+Pj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
