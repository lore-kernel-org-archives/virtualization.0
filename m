Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010074.outbound.protection.outlook.com [52.103.2.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2F1DF723
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765947186; cv=fail; b=a9Ked5Fqb4zEURXabYj5TYHP0dbXoDI7OHoDazBlurGO/Au4/zeYu9+QF8lqO79Yo5UAPb0GpIIHRV9funiyu8MqYKr0TjwV/uEYrWzg81NkvekwbgpYn3lIRbH+In5nAS7KbIsx0PxxT5ImP0c8DSMNvtRXYnjpIB9Lj+HDkL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765947186; c=relaxed/simple;
	bh=cBUUFI8VV/gEQBkDJ0hnu44GAv2zjM+rjM3UCriDasQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lXqBvgFvBpl3H5RKbikWYGmUz7r/8ThJq4UDUVp8M2JJ0rl6Wqbq148VEiwgKUCiMB2dHoZicukK1cOQKo+tTnktpre8nAUXN0SF1fo9rlg+PsGqSuXXoMK9tOXt3Fb88dB2mI/YD1XR7UoX36vJX66q+X1RtH1NhAgk+Ps5S0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P7a+N3sj; arc=fail smtp.client-ip=52.103.2.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P7a+N3sj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNAsXrgE48s1AQpkAaG4JzqmGxyMvQdU3XMCo1MlvPpj3MgxF99j/OhTXcHUztcDZKCT0iu4lYtfp8M0VnKmgP9GJeDMitiBi6RzX1TnnqGzlQdctHvBqqzf3TT4Vjl+Poz4fXUY2omNMqRSt2jKI3nndnVLPTs9oZx/iUsOf4/7ttJeSwCxxvO7F4BtX/MCAAcIbDtP6l1xzqd7GT9+5D4sIFx2y8dNUCYzEIGC3jEdvjAk5bBt+crtlFRu9u4BG0wQaHl6p/8IUN7ggOW86qn+TiAHS5BAc8aR1vKYSrO/h17ByHxD2Uk4lFM9iCiL/SrDIonQe1nxqrZox/S2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBUUFI8VV/gEQBkDJ0hnu44GAv2zjM+rjM3UCriDasQ=;
 b=h6Vz2wMwbe3nGpz5kDd55qTqIOm2HVbrVzOxzaBmo11As/OzXKwKGZ0CnUtixObPTIr2AcU8Jy+QyEBampoq0bzEu2kB4oUA7Uo3wzPMyr8u4F7UJOXDJUeH2uxs/f88QLb5t5WFL/+mbhcl/FbPz8piRFF/QJQeeKbZtcV5HqHUyASogpXYz6EIsTAbx3oDDJznHFmXEUczrXdoXPv3iz5SXAJQKCNJ9VHJ/2ye9JHHKToZXV8NcNIU0pFbrSTA8kNKBSoVSAIhB6106KidaQXJXHrOn/9wmpiISb9gtn0+waPlVTaMmrfC1D2xVBSiassG1mZ1phv2lN1NCMu3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBUUFI8VV/gEQBkDJ0hnu44GAv2zjM+rjM3UCriDasQ=;
 b=P7a+N3sjfGCXncJjUkFa2dmzZEPCJLjT/SXEF1Fo6pqQOGR42kEP2YgfaQS/kAclZaF8RHmrnHd6rZJ3SPpxCXc/WZhoAn2+OiS0wRtDew/M1pgCBozvSNhSyXy6sMyUGr5pwWJ7yfDwAjCh5cZl86ujW5AgX9c//RKAiq/jzLP+hCrfyeaav98PoBzMjXqYqL8MvKI3/bwRDmZvJVMp6xRFv371TJJFV0mOQC48FFz+o9kK2QbJRvISm0j+x2a/UgBqg1iLdwm/+6U+vg+bCNe7rCI9A65YluyTJVdN8vlaskQxFB7DIqW/vvkSqAWCvVzEXcuR6quQjFR7PYrxVQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SJ2PR02MB9293.namprd02.prod.outlook.com (2603:10b6:a03:4c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 04:52:58 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%3]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 04:52:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dongli Zhang <dongli.zhang@oracle.com>, "David Hildenbrand (Red Hat)"
	<david@kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] virtio_balloon: do not set pr_dev_info.report
 unconditionally
Thread-Topic: [PATCH 1/1] virtio_balloon: do not set pr_dev_info.report
 unconditionally
Thread-Index: AQHcaVOB7J9hfpaNV0yLnHGalLBBfLUahekAgAC4mwCACg5p4A==
Date: Wed, 17 Dec 2025 04:52:57 +0000
Message-ID:
 <BN7PR02MB4148C75ACA806BAEEEC4351BD4ABA@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20251209212311.64885-1-dongli.zhang@oracle.com>
 <0d9f302a-301c-4335-9c78-bcccab824a9f@kernel.org>
 <38ef7c75-195a-4145-bf35-3955aea8dd0d@oracle.com>
In-Reply-To: <38ef7c75-195a-4145-bf35-3955aea8dd0d@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SJ2PR02MB9293:EE_
x-ms-office365-filtering-correlation-id: 039ea3b9-a6e4-4381-9f8c-08de3d2825d0
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmqhcEBlXno9HJGOoZcx42eNoJaTLyh7IjRTGK1nydefwxtVNHTzf2XjH4UcAvvShm2tCCt8lcUKyMmjkUEQemAkKmcTwzTTGVjD4bqwGXEpXGMShhHQGCLQe0GUZYme52mDVrbvpPWe/mfAGDv9g17n93KaxGXGjf7HqGU8rsXESo9jhio3r2KZKXwmplxhJZ9QCqZHtAjkn+GCkxwtRhmR08Huj6JqacLCM92mGzOOcbvg4auqnNfYYhMxiBqE32GFTUYGzbW6+u+xUavZpMW0MvTrXAT7sVUPhOKFbkqWU5mnU7md2B6uB5/3Laxh1glqKhez1t9x5Qf0UWec/pPmAuxPkaNQLbMJ/M/2YG6K8EtiNjveqGRQmlVNEDJSeDodlIQd01M/2lZ2aXGLTUjih6P6iIgurRr4Bjwy1xaHDZdVZCYBUoctOUNXxZ6LofSOv53fyT8xOec2zqb1MX3x+1B4qPCF+FszvKDNjE1rybme6RU+yUPGJVm2/K2gig5eqesEQd2RSkNr4gfShygt5mS+21yKxrm/qxckFhKrs551cbnfi8e9fhZ7YlVrNUg4HRRihDj4pqNKs15nLyhpgzGpkRKwBQBhyTYi7XSkyCnQdlAhNO8zY40OYdw5JaPRGcv+ISSSKLoMLjqZBAso2zV3Eqabm7/PO1Ellqm2McMGj3CrjSLtQr818rXxtOqDVZBi4WuXGnkC/ef1JKy/2ocC1RWgxWpy5PouHWR9qPdnuDB5PXJXzqW2hXsQENc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|8060799015|461199028|19110799012|13091999003|12121999013|41001999006|15080799012|8062599012|440099028|3412199025|53005399003|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3FIL1RCeEwyVGZVMUdiZGJsUmdaMEx3RC9Jck9XTlFhZWxwd0pKNkZSWFBl?=
 =?utf-8?B?SVBiK2hXZk13RGJGZXdsWkRVb0pYUkpiV253T3hvQUJiK08xSjNyNGZYK3Ji?=
 =?utf-8?B?T3lLdmx0ZUdXeXFITnFubWZybzJFL3REZWFIKzVTeGlKQzJjeld0SVVqcjlT?=
 =?utf-8?B?SThGQmUwcTZReVVWSWkzeUMyenN1WUFHRDNZYm9paTVCSG5ORUNIV2p6WmhZ?=
 =?utf-8?B?azlzUU1OejFJRHgyM1Z1TTlxYTBCek9BL3JhQ2NYMFZIdnRiZnBnd0ZiOGUx?=
 =?utf-8?B?MmRYWlp1R3I5MEZFdWNyNzdFVGJXdlhEMXdtSjRvbHhtaWNiQ1hxL2x3SnZY?=
 =?utf-8?B?YUxJYmJXbVY4K0I2UnhFYW4zREd0djhvSkhmdUVIVkFaa3NJRnppNExvVzV2?=
 =?utf-8?B?MjdSdXEvcWpuN0dWd25vcjdPenlhVXJEdE51dDVXWXBnOUtaNmtRNWYrL0o4?=
 =?utf-8?B?cU1UMkhHRStMVk5iT2xweXFVNkhpaFNGcTVEMWlnMUhqN2dzUjR1T2h1eUNE?=
 =?utf-8?B?VjZUbTU0SUhDVVBwU2U2elJSYUZQa1FSblJPOXlYWHFSWDVMVTNkVzMzTVp4?=
 =?utf-8?B?cDN0czBuTC96NUR4TW14NDN2dmFNRjAvOEljcW5YNFMxTy9CM1RWakFQRU85?=
 =?utf-8?B?NERQeWx5dE1nelhXSmw4aFFnVEpOd0FYTHl5eE1VaDl3V2dxY2hOZFVwTGhI?=
 =?utf-8?B?NXNBTU00aUtCM29IQWdvRHZSVXRPMXJQSUJtNXNWVG5hTEJ1Y045T0x6N0FK?=
 =?utf-8?B?T2N1Q0xham9JcGtLUTB6T0NyVElSb0VBWlllTzV6SjFXSnYxZVhoNWhkV2xC?=
 =?utf-8?B?WlMzaGx3SFg4TUwyOExYWUI1TjIzaGFSZis5c2E4UTJxMFptbFpBTDNJOXpi?=
 =?utf-8?B?a0srRFJrSzVSVm9UaW4weDdDZDRXSElNR2pOQmtGbk1LdDdneDNVNnF6eHBw?=
 =?utf-8?B?SGlRd1BXSGVMV2VZbkd2aGlHZVQvUDZvb2lRalZDckp1a0FXa3g5Ly8vTEI3?=
 =?utf-8?B?MkJST3ZHaWVPNVBkZ1QrSy9EdjdXdkQxYjJZc3p4dEdaQ05yNEV2ZVU3R0VJ?=
 =?utf-8?B?aEZRbE9QbVRGZ0w0eHZvOGpjNTNuclQxekMyOFIrdDE4RHAwZVRlKzZaRUdL?=
 =?utf-8?B?N1YvOWdSUXJRUG55VW1lQTRLS21pWXJMWkwzUm1qczZVS1hXK2pCNFh1N0VX?=
 =?utf-8?B?T2hUZnJsTnhtMmw0T0JLZ0M1OTVsTy8rQ0JIdVVRWDNSYjhQamxnQWNlV2dn?=
 =?utf-8?B?QlZIVTEvWEtiRW02WkxlSXBzb3hTNHBTV1R0ajFqVnREM25pSXcrNHMyNVpp?=
 =?utf-8?B?dFR4L1ZXRFM4bFZyTkRMMythczQ4aHBueWJQd01NVHR1cldEUXgrcUx2VXhu?=
 =?utf-8?B?d3NkdHFhMWl0Zjl6Zmx0bmNLeklLeXR0Ymd2NUx2VStJQkt0REhBc2ZTdnZj?=
 =?utf-8?B?UkRFMitGd0dTMEI2aFRCZEtLeFdGeUkzZjVMcUhvQ2pwSmFZbkRhcnZGY2ZF?=
 =?utf-8?B?TGUrUm9QU0Q5ckQ4TGJ0RzVLOTJRcm12emV0VFFYRStBV3NBaW5zMFdxalAz?=
 =?utf-8?B?Y2FPUjNOazVrclRWbHkvVm9KNTBKTCttWXpXNzZFV0czUTNLTVd2RGs0TEtm?=
 =?utf-8?B?THluSGdocHNvUDJaRG5rcUx5eHNvYnkyUWFVbDdHVzhmWjN2SzVIczhkd1M5?=
 =?utf-8?B?a1NwYi9vemd6dGVsbHVVZ2ErREtyeEF0VkRSL3ZFYzVEc0FJdEpNLzdhWjBo?=
 =?utf-8?Q?O0kK2Pl2AxRXtWHwFKx31AdIWvkTgx/0a6hlxKc?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFZNYjNpeExaaFVxVE9ENmZsd1IyaFVQclNWV1hBb2ZUcExQd3dwd1NWS3B0?=
 =?utf-8?B?Wk04WXRIWEN4K3lwdVluei9kdWVzOWE0VGVscEVEQ3Ztb2lmUDg2OHdmTlZt?=
 =?utf-8?B?bWYyYThLYWZTdWJ5SSttOVlodlRrTHNocXU3Zks5QzJWMnh1SXJ4QUpxT2xL?=
 =?utf-8?B?cDNybU5IQ3lHWkhlN25LOHBBUHhicVV2UWFxTHo2elFlTkxPZ29SMmI3VzAx?=
 =?utf-8?B?VXF3QUhja3phMlBpZGY3UjMxNUszZFNQaUljVjB3emhaRzVZYk9XQjU4SU00?=
 =?utf-8?B?SlhGby8yeVUyU3pDNWcyL3hPQ1VwV3lJMFJzUllVRHdyOXVGcmsrbXlQZllv?=
 =?utf-8?B?TkFzMVR2N2lEOE9sTlpWbHBtdHlNNHNEUTV6Z2NuY1pqTE9MbDcyQUpYMTFU?=
 =?utf-8?B?Tk4rVHNyK1pvakhYa0xiTGYwdjB4ZWtDVzdkYlVReld3WTVvbDl2WDk5MGtG?=
 =?utf-8?B?RDJ5ZXdjdm9SQlh5Tm43QlZGQ01iLzBmcmx4UlBJTjczd3ZZdVVMTkVVZUdD?=
 =?utf-8?B?SWw3Y1ZMQmhSR3VUNDJtOHVkM2lwMFBtWnFvU0puOXVRcTBORGh4UE9FWkxT?=
 =?utf-8?B?c05sMks5eEhRSVZBaWZlUVdLZ1dqTk9xQkRlQjJ6S3JreTJ4U01lTHhpbEJJ?=
 =?utf-8?B?UVdnbytSR1g2T1V1aW5BOVlrUVMzckYxTzE4djFnc0ZwaTJ0RXUyWi8vc0RJ?=
 =?utf-8?B?bUV2ZlRGejNzQy9pU2RNQXhpRGR2TnorVlF0SU9VaE9kQnZtQ1I2UnFhSTl6?=
 =?utf-8?B?RDJjTDlBdXpFOTE3QXZTRVNTQTRCUkhaTitidCt6TlNybXVJNEFzUnYwVmQv?=
 =?utf-8?B?dUF4ZUwzWTk0cGlSNm5nY2gvSEF0cVVDUCtkM3RKblFUTGpVaFRTY25HNWhY?=
 =?utf-8?B?YUFQYzAwRDlMUTRoLzVVZFJyWHQ5TzlxcXExcHpSa3J0cTVRelcxMlRCS2FV?=
 =?utf-8?B?bUdpb2l4NEZQYUZOVis5QllHKzllNzJZbnRlSGh3enVJQVBGL0NCeHl2ZUJw?=
 =?utf-8?B?L3hoNVB0bXZSSVF0WldwMmpiQ3YvcitOVUdCa1RGUml4M0JnbEZ2ZFJrSlR4?=
 =?utf-8?B?b0NQOWZFdHp3R0F5SjVTdW1zYjhINSs0QldpMTFjYk4wbGNTTUk0ZzZuT0tW?=
 =?utf-8?B?OEJ3a2cvKzJmSEZtU2RCQ0Niamt6L0MzV3NkS1NKZGhaZFlmWHM1VFJ3clZB?=
 =?utf-8?B?UndOUlZ2WlZVMkRxY2s4cU42R0pzN1VCTkNOaUFmTjNjQnRVR0QzMS9xV1pW?=
 =?utf-8?B?Q0d4dEZOc2t5YkpWT1NBVDg1UzBCTms0cW5rdlpyK0lMeGQwdVo5dGhrTG9n?=
 =?utf-8?B?SWloeWlULzNZQUFzdG1vVVRKYyt1dGRkYi9ydjh0SjY2d2VRWGJVbnUzcU5z?=
 =?utf-8?B?N1hEQjdCOUtEYm41ZEtBZys4VzJHWHZFQVFkL04wdWpWNnBBMzhIKzN1QWtq?=
 =?utf-8?B?blNvbkF0bzFXNXBBaThKbmNibUwrZkFueURaVjFLN0pSR0p3U3IyREZBT0hO?=
 =?utf-8?B?YTErSyt5K1lSZVZvSkRZWG8zVTdobGRYRy9mSG5HdzV6ZUZlMkZxV1JpK0RO?=
 =?utf-8?B?WmJmVFlmalZiWC9QR2V6ZXU4OXJhajRMMkxlVHR6VzQxYVl0UUdJSzZpbklP?=
 =?utf-8?Q?YJ4OjKyXPEQGDpqhjf1rZ4aLWsruP1bS2+U+z5/yUpvI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 039ea3b9-a6e4-4381-9f8c-08de3d2825d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 04:52:57.5243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9293

RnJvbTogRG9uZ2xpIFpoYW5nIDxkb25nbGkuemhhbmdAb3JhY2xlLmNvbT4gU2VudDogV2VkbmVz
ZGF5LCBEZWNlbWJlciAxMCwgMjAyNSAxMToxMCBBTQ0KPiANCj4gSGkgRGF2aWQsDQo+IA0KPiBP
biAxMi8xMC8yNSAxMjowOSBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgKFJlZCBIYXQpIHdyb3RlOg0K
PiA+IE9uIDEyLzkvMjUgMjI6MjMsIERvbmdsaSBaaGFuZyB3cm90ZToNCj4gPj4gRG8gbm90IHNl
dCB2Yi0+cHJfZGV2X2luZm8ucmVwb3J0IHVuY29uZGl0aW9uYWxseSBpZg0KPiA+PiBWSVJUSU9f
QkFMTE9PTl9GX1JFUE9SVElORyBpcyBub3QgYXZhaWxhYmxlLg0KPiA+DQo+ID4gQ2FuIHlvdSBz
aGFyZSB3aXRoIHVzIHdoeSB5b3UgdGhpbmsgdGhhdCBzaG91bGQgYmUgZG9uZT8gUGxlYXNlIGRv
Y3VtZW50IHRoZQ0KPiA+ICJ3aHkiIGFuZCBub3Qgb25seSB0aGUgIndoYXQiLg0KPiA+DQo+ID4g
V2l0aG91dCBWSVJUSU9fQkFMTE9PTl9GX1JFUE9SVElORywgd2UnbGwgbmV2ZXIgY2FsbCBwYWdl
X3JlcG9ydGluZ19yZWdpc3RlcigpLA0KPiA+IHNvIGl0IHdpbGwgbmV2ZXIgYmUgdXNlZC4NCj4g
Pg0KPiA+IEJ1dCB0aGUgY29tcGlsZXIgY2Fubm90IG9wdGltaXplIGl0IG91dC4gSXQgb25seSBo
YXBwZW5zIGR1cmluZyBkcml2ZXIgbG9hZGluZywNCj4gPiBzbyBJIGFtIG5vdCBzdXJlIGl0IGlz
IHdvcnRoIHRoZSBjaHVybj8NCj4gDQo+IFdoZW4gSSB3YXMgcmVhZGluZyBhYm91dCB0aGUgZnJl
ZS1wYWdlIHJlcG9ydGluZyBmZWF0dXJlIGluIHZpcnRpby1iYWxsb29uLCBJDQo+IHdhcyBjb25m
dXNlZCBhcyB0byB3aHkgcHJfZGV2X2luZm8ucmVwb3J0IHdhcyBhbHdheXMgY29uZmlndXJlZCB1
bmNvbmRpdGlvbmFsbHkuDQo+IA0KPiBMYXRlciwgSSBsb29rZWQgYXQgdGhlIGltcGxlbWVudGF0
aW9uIGluIHRoZSBIeXBlci1WIGJhbGxvb24gZHJpdmVyIGFuZCBub3RpY2VkDQo+IHRoYXQgaXQg
ZXZlbiByZXNldHMgcHJfZGV2X2luZm8ucmVwb3J0IGJhY2sgdG8gTlVMTCBpZiBwYWdlX3JlcG9y
dGluZ19yZWdpc3RlcigpDQo+IGZhaWxzIChzZWUgbGluZSAxNjY5KS4NCg0KVGhlIEh5cGVyLVYg
YmFsbG9vbiBkcml2ZXIgZG9lcyB0aGlzIGJlY2F1c2UgaXQgdXNlcyB0aGUgTlVMTCBpbiBwcl9k
ZXZfaW5mby5yZXBvcnQNCnRvIGluZGljYXRlIGlmIHBhZ2VfcmVwb3J0aW5nX3VucmVnaXN0ZXIo
KSBzaG91bGQgYmUgY2FsbGVkIHdoZW4gdGhlIGRyaXZlciBleGl0cy4NClNlZSBkaXNhYmxlX3Bh
Z2VfcmVwb3J0aW5nKCkuIFVubGlrZSB0aGUgdmlydGlvIGJhbGxvb24gZHJpdmVyLCB0aGUgSHlw
ZXItVg0KYmFsbG9vbl9wcm9iZSgpIGZ1bmN0aW9uIHN1Y2NlZWRzIGV2ZW4gaWYgcGFnZV9yZXBv
cnRpbmdfcmVnaXN0ZXIoKSBmYWlscywgc28NCnNvbWUgaW5kaWNhdG9yIGlzIG5lZWRlZCBvbiBl
eGl0LiAgSSBkaWRuJ3QgbG9vayBzdXBlciBjYXJlZnVsbHksIGJ1dCBpdCBhcHBlYXJzIHRoZQ0K
dmlydGlvIGJhbGxvb24gZHJpdmVyIGRvZXNuJ3QgbmVlZCBzdWNoIGFuIGluZGljYXRvci4NCg0K
VGhhdCBzYWlkLCBJIGRvbid0IGhhdmUgb3BpbmlvbiBvbiB0aGUgdHJhZGVvZmZzIG9mIHRoaXMg
cHJvcG9zZWQgY2hhbmdlLg0KDQpNaWNoYWVsDQoNCj4gDQo+IDE2NTEgc3RhdGljIHZvaWQgZW5h
YmxlX3BhZ2VfcmVwb3J0aW5nKHZvaWQpDQo+IDE2NTIgew0KPiAxNjUzICAgICAgICAgaW50IHJl
dDsNCj4gMTY1NA0KPiAxNjU1ICAgICAgICAgaWYNCj4gKCFodl9xdWVyeV9leHRfY2FwKEhWX0VY
VF9DQVBBQklMSVRZX01FTU9SWV9DT0xEX0RJU0NBUkRfSElOVCkpIHsNCj4gMTY1NiAgICAgICAg
ICAgICAgICAgcHJfZGVidWcoIkNvbGQgbWVtb3J5IGRpc2NhcmQgaGludCBub3Qgc3VwcG9ydGVk
IGJ5DQo+IEh5cGVyLVZcbiIpOw0KPiAxNjU3ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IDE2
NTggICAgICAgICB9DQo+IDE2NTkNCj4gMTY2MCAgICAgICAgIEJVSUxEX0JVR19PTihQQUdFX1JF
UE9SVElOR19DQVBBQ0lUWSA+DQo+IEhWX01FTU9SWV9ISU5UX01BWF9HUEFfUEFHRV9SQU5HRVMp
Ow0KPiAxNjYxICAgICAgICAgZG1fZGV2aWNlLnByX2Rldl9pbmZvLnJlcG9ydCA9IGh2X2ZyZWVf
cGFnZV9yZXBvcnQ7DQo+IDE2NjIgICAgICAgICAvKg0KPiAxNjYzICAgICAgICAgICogV2UgbGV0
IHRoZSBwYWdlX3JlcG9ydGluZ19vcmRlciBwYXJhbWV0ZXIgZGVjaWRlIHRoZSBvcmRlcg0KPiAx
NjY0ICAgICAgICAgICogaW4gdGhlIHBhZ2VfcmVwb3J0aW5nIGNvZGUNCj4gMTY2NSAgICAgICAg
ICAqLw0KPiAxNjY2ICAgICAgICAgZG1fZGV2aWNlLnByX2Rldl9pbmZvLm9yZGVyID0gMDsNCj4g
MTY2NyAgICAgICAgIHJldCA9IHBhZ2VfcmVwb3J0aW5nX3JlZ2lzdGVyKCZkbV9kZXZpY2UucHJf
ZGV2X2luZm8pOw0KPiAxNjY4ICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gMTY2OSAgICAgICAg
ICAgICAgICAgZG1fZGV2aWNlLnByX2Rldl9pbmZvLnJlcG9ydCA9IE5VTEw7DQo+IDE2NzAgICAg
ICAgICAgICAgICAgIHByX2VycigiRmFpbGVkIHRvIGVuYWJsZSBjb2xkIG1lbW9yeSBkaXNjYXJk
OiAlZFxuIiwgcmV0KTsNCj4gMTY3MSAgICAgICAgIH0gZWxzZSB7DQo+IDE2NzIgICAgICAgICAg
ICAgICAgIHByX2luZm8oIkNvbGQgbWVtb3J5IGRpc2NhcmQgaGludCBlbmFibGVkIHdpdGggb3Jk
ZXIgJWRcbiIsDQo+IDE2NzMgICAgICAgICAgICAgICAgICAgICAgICAgcGFnZV9yZXBvcnRpbmdf
b3JkZXIpOw0KPiAxNjc0ICAgICAgICAgfQ0KPiAxNjc1IH0NCj4gDQo+IFRoYXQncyB3aHkgSSdk
IGxpa2UgdG8gbW92ZSB0aGUgY29uZmlndXJhdGlvbiBvZiBwcl9kZXZfaW5mby5yZXBvcnQgaW5z
aWRlIHRoZQ0KPiBpZiBzdGF0ZW1lbnQuDQo+IA0KPiBJdCdzIGEgcHVyZWx5IG5vbi1mdW5jdGlv
bmFsIGNoYW5nZSwgaW50ZW5kZWQgb25seSB0byBtYWtlIHRoZSBpbml0aWFsaXphdGlvbg0KPiBs
b29rIGNsZWFuZXIuDQo+IA0KPiBBcG9sb2dpZXMgLSBJIHNob3VsZCBoYXZlIG1lbnRpb25lZCB0
aGF0IHRoaXMgaXMgYSBub24tZnVuY3Rpb25hbCBjaGFuZ2UgaW4gdGhlDQo+IGNvbW1pdCBtZXNz
YWdlLg0KPiANCj4gVGhhbmsgeW91IHZlcnkgbXVjaCENCj4gDQo+IERvbmdsaSBaaGFuZw0KPiAN
Cj4gDQo+IA0KPiA+DQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IERvbmdsaSBaaGFuZyA8ZG9u
Z2xpLnpoYW5nQG9yYWNsZS5jb20+DQo+ID4+IC0tLQ0KPiA+PiDCoCBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fYmFsbG9vbi5jIHwgMyArKy0NCj4gPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX2JhbGxvb24uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19iYWxsb29uLmMN
Cj4gPj4gaW5kZXggNzRmZTU5ZjVhNzhjLi4wYzM5ZjI0MTUzMjQgMTAwNjQ0DQo+ID4+IC0tLSBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19iYWxsb29uLmMNCj4gPj4gKysrIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX2JhbGxvb24uYw0KPiA+PiBAQCAtMTAzNCw3ICsxMDM0LDYgQEAgc3RhdGljIGlu
dCB2aXJ0YmFsbG9vbl9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikNCj4gPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBvaXNvbl92YWwsICZwb2lzb25fdmFs
KTsNCj4gPj4gwqDCoMKgwqDCoCB9DQo+ID4+IMKgIC3CoMKgwqAgdmItPnByX2Rldl9pbmZvLnJl
cG9ydCA9IHZpcnRiYWxsb29uX2ZyZWVfcGFnZV9yZXBvcnQ7DQo+ID4+IMKgwqDCoMKgwqAgaWYg
KHZpcnRpb19oYXNfZmVhdHVyZSh2Yi0+dmRldiwgVklSVElPX0JBTExPT05fRl9SRVBPUlRJTkcp
KSB7DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgY2FwYWNpdHk7DQo+ID4+
IMKgIEBAIC0xMDQ0LDYgKzEwNDMsOCBAQCBzdGF0aWMgaW50IHZpcnRiYWxsb29uX3Byb2JlKHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQ0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBnb3RvIG91dF91bnJlZ2lzdGVyX29vbTsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4g
Pj4gwqAgK8KgwqDCoMKgwqDCoMKgIHZiLT5wcl9kZXZfaW5mby5yZXBvcnQgPSB2aXJ0YmFsbG9v
bl9mcmVlX3BhZ2VfcmVwb3J0Ow0KPiA+PiArDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0K
PiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSBkZWZhdWx0IHBhZ2UgcmVwb3J0aW5nIG9y
ZGVyIGlzIEBwYWdlYmxvY2tfb3JkZXIsIHdoaWNoDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogY29ycmVzcG9uZHMgdG8gNTEyTUIgaW4gc2l6ZSBvbiBBUk02NCB3aGVuIDY0S0IgYmFzZSBw
YWdlDQo+ID4NCj4gPg0KPiANCg0K
