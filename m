Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6F0C00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 06:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B173410D0;
	Wed, 10 Aug 2022 06:52:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B173410D0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=paw+dIGV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxNZoILlodYf; Wed, 10 Aug 2022 06:52:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5ECD1400E7;
	Wed, 10 Aug 2022 06:52:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5ECD1400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D828C0032;
	Wed, 10 Aug 2022 06:52:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75307C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AD9840211
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:52:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AD9840211
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qcPoy5Mveh9F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:52:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDC28400E7
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDC28400E7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 06:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTu2qoMmwriVbMAsfgGNz3ggkV3BsENgQkbSK5cGKkgupP3VHWkOMr3IR3e2B5NT9BEnWmWYB4WPQJBMU02i0iygCRuB2Db2KXurdERHvJuQfAhriARKTaYL5cvZnKEgrcXNaAV+CJm8GWm8ulELPXsPep3lThwKvG01YloTT8Njr7fKpxCJrSZc9hD5BImoEzDbbhukn3iGbl12NYZJRjAGGK3odCGiJ8vcTEKAjxPLpyjEeHG/nsljh/eRCVXpDxiwYg//UcYNIxuVzmKyp2eHmXmVCiGZsHzN9s/eVjuK43YYfBab6FX/hS2Q+RHRGw6VL74R/ZX+E/PCzJIUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW8QHHhJdXKYyugvMMC0c9zhofnvetw52eixGeuJQGo=;
 b=fb8rozsaWMLmRVwhfCj5WcQBdSoIAgJSaEbSzfKB4+gJjWS4vKjgLiFRY1ho1qZz4u1sDY/MHQqOdL1+HR0/f+uSTY9QyakXI/IJpKUOAPzN6qYY7NzhZGnVQN4Jajmd5bFwtMwTYo4wqT+fCY6pYznMYrQThFCTbFfPp2XYWsHzZuzmLSlZ0OI/HZvIDlEtBcr+7cTirlrmXJ48zHRlWaM/6F1PtTYDfl2oPTwt0j6vJo/ZU/Rim/6CshCprhvNzl33hOKwMgHXRjGhQxjO95xkazBBotgVua9Y20I++V7/joD6U2Q3r7korP32DPu2neZjaICzQmb9yl2XHoEwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW8QHHhJdXKYyugvMMC0c9zhofnvetw52eixGeuJQGo=;
 b=paw+dIGVBNfpT7fsfnxO1nQxI3lOM3VKqbDgsZfqepKamey6S5Hy3gyTZCGtay9YBSS4PacuOSWK+7unscxCl7RVJi5btxNFSbqabSX0RDVgYPgsSBhhkelHclrgxs9QCAi7bITtDPeap89txnkOluHZ4gHizijJVWMBL5NsZq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 06:52:25 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 06:52:24 +0000
Message-ID: <e760f555-7f2d-dea9-70b2-c0881adc3afc@amd.com>
Date: Wed, 10 Aug 2022 08:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/2] drm/gem: Properly annotate WW context on
 drm_gem_lock_reservations() error
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-2-dmitry.osipenko@collabora.com>
 <a42237c9-6304-4b06-cede-2175c7e7b87d@amd.com>
 <YvKO5r5Sr56e9vBf@phenom.ffwll.local>
In-Reply-To: <YvKO5r5Sr56e9vBf@phenom.ffwll.local>
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6119e70-e45d-4947-d7b7-08da7a9ce1bb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3949:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Czcmn5v65qZzh5q/yxbpDVoEtfWFxr+u+Wz3KFd4Ik3agM1iPhYSobWnJGj6nZ6CXG1uVlzn2fongMRw4aL2fjYwc6EoSZuRz1GmAKms7BA390z2kGkbWHSZa8cfeWK+FgBE8RQv9TBsf/vNygp0gf/funrBPdnOBX0jMOulwCsnXKrwRMdy6rOtwsK0AF2zMhVx+IBvH4fPEm/zPU4ph7ODKGcHk37nkTlmlwf4iXRjbS65AbtqjIl0AUvwP1D4yYnmf7bXeqvwRwXMvRGwwHiDzx8nqVzIkDKKsV8Bdn68b20mK4LliFFOoo/ezhQ0ACv3sy0oRzQ61UDGh23UR1Ha8A28OHE9oqFlHThUZ0U+6qxN2SeJcFk1517DbPk90jQRsKG2udTgO+4bkZT6qlb5+oWJgVt89njqwwYSqFVuGf+/XLNeyu4qX8nOyx562V9RPtBpkSYBg51KtQUH0nkcxJR1L5cAmIWcxjIUtpJ2AG5ECkIGh5gLkz97rTkg9kU0FzOoKIr6S6XcQ+J7UWmCvMI052RRE3nbzuIuIhMRspFUt/jYoKYkCFdoqe8Ko5kcRBuBFoqE3mEKSl4Yx2fyzdG1wMRSwof3eNREf+DUI9ruo1tXTnu1yMWEbtAj7a9z/uYiDXvuX2ZYYlLo0CcO5MXpt9Lq3D2MKJC+XR2r+QygCddHIwihzK7eqmjP+5NLK/EcftEfBiR/FDRysmv6xmaus1vOf488u0sbuGYx1W+zXVq/eIQKBqdydRSZRaSTCyijfj9u/90Au6EuX8gUDx7279EZ9ro+Nw0S0DGPHyTSjYRjI4l/RvGHq9QVStC5Snv3Ad7fZUQBYtG3oCjy6fDIHAKS68kMAg5xEPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(6486002)(478600001)(2906002)(6666004)(41300700001)(31686004)(86362001)(36756003)(110136005)(316002)(186003)(2616005)(921005)(38100700002)(31696002)(6506007)(6512007)(83380400001)(66574015)(66946007)(8936002)(66476007)(66556008)(8676002)(7416002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3NMNmFsbkZFdlQyTHhZNXpncGlCZFRtRFUyWlJaaW8reUgxZ1hYZERBS1Y0?=
 =?utf-8?B?QkF2d09kVTZZbk9HdVlleVhtNzZ4VEc3cmlZRmpPSWpibUR4bzZlL3hRdzFy?=
 =?utf-8?B?R2RKNTdUS0ZtZWZZVDNTYTNaUkxmK1dRV1UyY2RwQmNvVnF5WjZDcXVLdDJX?=
 =?utf-8?B?dGhSdGpIUjJGTmRmdStrRFBLaTdzYnBzYTNLNG1RV2RTeUpSNWF4TGJOSHpE?=
 =?utf-8?B?OHZSZjdUQ3FrZzlka0I5eGZqT0JRWEJXbXFqbTMzWm1aYjlHWnUzR0E0TWNj?=
 =?utf-8?B?K3haZ25OUnJOeVJuNlpWT3A4dW4vakVZdVdiZlZQRlBiUUVZZlB1amcwWlZu?=
 =?utf-8?B?Q3lQenNGNHFBcDJiS1dVS2ZGNURwOFlmK2s2K2wxcDd3NDRrN1haTEt1clZj?=
 =?utf-8?B?ZWMyNHI4bVVIa2hYMGJjOEFBK0VmR2I4ait3WDlzQVRSclhLWkFrTWUxRHVY?=
 =?utf-8?B?cDg0YzRTU0dwdXJXaStwYVMvVmRHNDN0Y3NuNFpQMllnRklld2hCL0tKUkpm?=
 =?utf-8?B?akdxQnZpK0t1azhzSmI1SUFTbDQySWV0UzdDUmJvRkZsQ0RaVlR6bk1IaHdE?=
 =?utf-8?B?amZmemFnMDJZa000KzhqWmNEdlF2Wm9yc2svaHR6TUk2ODlHalJ0d1hReVBx?=
 =?utf-8?B?SjlWWE1sUFYveDY0SmxPN2pSN3NuQUlzdkZIUERsa1VOV2RlMVRWQXVJWDlG?=
 =?utf-8?B?V2lkajZjN3gvVnR2bk4vSitPMHRDdHV4eG1SMkxsT2U1RE91ZThNYUJVelVT?=
 =?utf-8?B?ei9FamdYTGR5YVVpeGRFOEZOSEVrMnJjekdRdk9mS2FpSG5wU0Yxb29UdWYy?=
 =?utf-8?B?RDA2bjhncWxZakJvRi9FTkc4WmVFWTlQQmFSa1p0aXJxV3JFZHlhUXpSUElL?=
 =?utf-8?B?ZS9QQ044dWJCNkttZXFsaUszelFhQ1E4MmdjSSt4bFN1YzhtUG5nK3NFaWQy?=
 =?utf-8?B?bU5KYkc3dmV4Y2V5dmV4V2gvQnJ4aXNTNm12cmh0dW5qOWk4TlQ0dk9TbjlY?=
 =?utf-8?B?UGxzbW9KOWFSVnVvL29sK2pmWVY4cWZLQkZMQjl2MHJ3TDNxZFhrQVhWVCt6?=
 =?utf-8?B?dXByaFNnRzQrbUMyd3BTTVZpeXR6MDErc2VnNkRUcTZRRGEvZDQ5NU9sVDNW?=
 =?utf-8?B?eGZNVGE0THc4UFpKRStkVk9UcFBrVlFKT09JNUV5d1JaQTlYOXhNd1hyaGVR?=
 =?utf-8?B?cldTNUFlckFZRVhoN1FHRXk1ZzA4RHB6cGYzRy9MQ3BXajIvdHo4M0lNU2VK?=
 =?utf-8?B?WkVSUmRWRGR4ck4yVFJzVGxuUVVaTTVhK3NJeWtBQVhWdk5NL1pLUDkyTWpm?=
 =?utf-8?B?RTNZMnBGc21QVVBzVHgyQWZQRTFvazljU2FzY0JNUXR5Z0tUVGJ1U2ZhMVd4?=
 =?utf-8?B?Mk1SQ1RRZldJRzIrRFdOYTNCTWNuQ3hScHhFNjlsODVNWnRSQUhtQ3N6ZTg5?=
 =?utf-8?B?YW0yZmZ0NGJxMDRtc0JLVi9UTWFPZFh4VmVneUg3b3p5Q2huN0JXZUoyemE5?=
 =?utf-8?B?USsrSUlIcTQ4bTE1NW1FZktZUTNBeUdkTGlHN2VqK3FYa1NBSXR2M1gwakRS?=
 =?utf-8?B?VER2THBBUm9mTXg2UGhlN0dod2RTb3VhVjRRMDlKd0I1UW5FTkpUbWJtN21G?=
 =?utf-8?B?dWNxa1dtZFpRS2pVMXlkVS9KYTIxaDlTbVpFZFFkQXZtVktHWEhIL2VONDZY?=
 =?utf-8?B?bWpNMWZNTUxaRERjcTJsc1hoeDZpcGNqNmo4cTl2aUdyWlRiWElJalE3MDYx?=
 =?utf-8?B?U2hnSGZpM3ZlQnFiQVIvSmZDQlg3Mms1eExKN0g4ZitEN2QyQzdwMlBsajhQ?=
 =?utf-8?B?WnJJNHYwTEtSekFScjZlYXhSNXFnOTdXT1lLVnBqMFdkZWx6anhZQlRlOFYz?=
 =?utf-8?B?Z2k4ZnB1NVQ4NFZ6Zk5rdXA1d1VZM3hSa2Erc1QwamhMdUdVZ2t4bWQ3N01T?=
 =?utf-8?B?aHJaMkoyUS9lVXBhNGl2Z01lRUhkbHFCcStrR1RIQWNWeVF2eVFkVDVrc1JX?=
 =?utf-8?B?c2M0c202cWVLVlo4clB6UXhIdHIwVTRNam05VzNzcVFmenp6MEh5ZHBsOEFB?=
 =?utf-8?B?SjRwTmw1aWZBcWIxSjF0RFA5REtBWkc2T3ozSFZxeGptS0xCYm5rYmJWYnNE?=
 =?utf-8?B?eVdaZlNRZlJ1RlhXZlp3SmhRZGlTVXZScDJRaG1sRzhuVlZMWWphQi9ub1Jj?=
 =?utf-8?Q?9tJDP2bJPRl9DIJj4HHi9eJS6lupkcMETVHOl/yg8QhY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6119e70-e45d-4947-d7b7-08da7a9ce1bb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 06:52:24.8736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPQfi2SrtaNnq8J4QOt8liYR2AEh789K8KUUK+Ml7Kt9S80rSSXQIu+Wd0LfVgPO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
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

QW0gMDkuMDguMjIgdW0gMTg6NDQgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIFR1ZSwgSnVs
IDA1LCAyMDIyIGF0IDAxOjMzOjUxUE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+
IEFtIDAxLjA3LjIyIHVtIDExOjAyIHNjaHJpZWIgRG1pdHJ5IE9zaXBlbmtvOgo+Pj4gVXNlIHd3
X2FjcXVpcmVfZmluaSgpIGluIHRoZSBlcnJvciBjb2RlIHBhdGhzLiBPdGhlcndpc2UgbG9ja2Rl
cAo+Pj4gdGhpbmtzIHRoYXQgbG9jayBpcyBoZWxkIHdoZW4gbG9jaydzIG1lbW9yeSBpcyBmcmVl
ZCBhZnRlciB0aGUKPj4+IGRybV9nZW1fbG9ja19yZXNlcnZhdGlvbnMoKSBlcnJvci4gVGhlIHd3
X2FjcXVpcmVfY29udGV4dCBuZWVkcyB0byBiZQo+Pj4gYW5ub3RhdGVkIGFzICJyZWxlYXNlZCIs
IHdoaWNoIGZpeGVzIHRoZSBub2lzeSAiV0FSTklORzogaGVsZCBsb2NrIGZyZWVkISIKPj4+IHNw
bGF0IG9mIFZpcnRJTy1HUFUgZHJpdmVyIHdpdGggQ09ORklHX0RFQlVHX01VVEVYRVM9eSBhbmQg
ZW5hYmxlZCBsb2NrZGVwLgo+Pj4KPj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+PiBG
aXhlczogN2VkYzNlM2I5NzViNSAoImRybTogQWRkIGhlbHBlcnMgZm9yIGxvY2tpbmcgYW4gYXJy
YXkgb2YgQk8gcmVzZXJ2YXRpb25zLiIpCj4+PiBSZXZpZXdlZC1ieTogVGhvbWFzIEhlbGxzdHLD
tm0gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPgo+Pj4gU2lnbmVkLW9mZi1ieTog
RG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KPj4gUmV2aWV3
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBBbHNv
IGFkZGVkIHRoaXMgci1iIHRhZyB3aGVuIG1lcmdpbmcgdG8gZHJtLW1pc2MtbmV4dC1maXhlcy4K
CklJUkMgSSd2ZSBhbHJlYWR5IHB1c2hlZCB0aGlzIHRvIGRybS1taXNjLWZpeGVzIHdpdGggYSBD
QyBzdGFibGUgdGFnIAphYm91dCAyIHdlZWtzIGFnby4KClBsZWFzZSBkb3VibGUgY2hlY2ssIGl0
IHByb2JhYmx5IGp1c3QgaGFzbid0IGNvbWUgZG93biB0aGUgc3RyZWFtIGFnYWluIHlldC4KCkNo
cmlzdGlhbi4KCj4gLURhbmllbAo+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9kcm1f
Z2VtLmMgfCA0ICsrLS0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2Vt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbS5jCj4+PiBpbmRleCBlYjBjMmQwNDFmMTMuLjg2
ZDY3MGM3MTI4NiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPj4+IEBAIC0xMjI2LDcgKzEyMjYsNyBA
QCBkcm1fZ2VtX2xvY2tfcmVzZXJ2YXRpb25zKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqKm9ianMs
IGludCBjb3VudCwKPj4+ICAgIAkJcmV0ID0gZG1hX3Jlc3ZfbG9ja19zbG93X2ludGVycnVwdGli
bGUob2JqLT5yZXN2LAo+Pj4gICAgCQkJCQkJCQkgYWNxdWlyZV9jdHgpOwo+Pj4gICAgCQlpZiAo
cmV0KSB7Cj4+PiAtCQkJd3dfYWNxdWlyZV9kb25lKGFjcXVpcmVfY3R4KTsKPj4+ICsJCQl3d19h
Y3F1aXJlX2ZpbmkoYWNxdWlyZV9jdHgpOwo+Pj4gICAgCQkJcmV0dXJuIHJldDsKPj4+ICAgIAkJ
fQo+Pj4gICAgCX0KPj4+IEBAIC0xMjUxLDcgKzEyNTEsNyBAQCBkcm1fZ2VtX2xvY2tfcmVzZXJ2
YXRpb25zKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqKm9ianMsIGludCBjb3VudCwKPj4+ICAgIAkJ
CQlnb3RvIHJldHJ5Owo+Pj4gICAgCQkJfQo+Pj4gLQkJCXd3X2FjcXVpcmVfZG9uZShhY3F1aXJl
X2N0eCk7Cj4+PiArCQkJd3dfYWNxdWlyZV9maW5pKGFjcXVpcmVfY3R4KTsKPj4+ICAgIAkJCXJl
dHVybiByZXQ7Cj4+PiAgICAJCX0KPj4+ICAgIAl9CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
