Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795578084;
	b=nQJieJESPzIwXmrJ+t9WD4CnO7+SWM73cSSAAo8N+oo6fsQXhvR9D/V9xmM5dj6qkZ62
	 CgRps7c2nyJBTMEh21VWuVn0CGeJQPVp4tmG2CnRViwgEgKyCBYn3QII2rqPSuP7nTuDT
	 SVSCZ3XeolQ6aGcZp2equwtfzPBIUHq/nyo4R0AZbygaFE8Lvvna3cvq9lmUu4mSlfiXB
	 bzGA7gKLsjvnLTLeSRvbh2K8zG5yO+z4Y4Le/MCRtffczJh2cLkbQGGtX/Kvkfduf0SSg
	 ppSR3zLaobFK1ZMmcev5NFAEMZOkPqw1c7lZFVl//N8YBAEGMuElCsFO6fj4ZvjmYNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578084;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:
	 Message-ID:To:Cc:In-Reply-To:References:Date:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=uLwJmtMNRVbFSciTZpwkTI2KrkLEaxtyws44pWjXcnQ=;
	b=1kwKnfVg4SpZ0q+ewad4UqTYP2Hj125NJ2WZcxcQg5foxydPtkFW992nqsy8IDZR2yD3
	 oDJEReDUMscnAE8h1Ggr0k2onpu+GRJgncIIld3Pwz1OVoVW+tGEOolwCGaTd54vapC7y
	 pQ9+R3SHtJxSGiTW4ACjOJfmo9+TnzM/C4SanfuwlTYgOcy9RiSWF/Td9XHo26F3db92Q
	 xEolFFZctSIPfhfES1C192FG2Cx77YA55wVODMQYDboCM+v2XmSLOzAnf/RS5HxWDN/A9
	 HTznax23ysu9lFrDDreLevmsJfWxQ1Sf6eqjPD8ygkezX6HeJ8zqSLbLOwDkSZE+AyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="H/5fJ/UZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.22
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010022.outbound.protection.outlook.com [52.103.66.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9C606A32C
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 03:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEB9C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=H/5fJ/UZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBKugKPp40r/l9I4k2NnJkcuQ9E0X2W81VpgKO8XYOwJYQF2EhELUdCloataDh3G5H/SkwvsUYH5aMZ5puV5KKHHcEJi7O8MTUpGCzkLwcvj1uzqvE7VqZlByK5KJX44CW1oGQ6EcHuplI9StXm6hEcAi0jT6/maLVws8mqyixYXidtiaU6tlAOhN3JDkQNEtt3+MtkmpmhsseXNBjpCNOt99Z0qCcnX9XcvI60knwOg8AfxGteAmlFNgIlwKeBZs704Qht7ABVCSQFBrz3Kh6UMJDxLEcG9tURuprhhh4SdCGwh+CJhFPmm00tDNBM1wSRrtK+Ru9/3NFZKUYxisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLwJmtMNRVbFSciTZpwkTI2KrkLEaxtyws44pWjXcnQ=;
 b=FhBIiVhaO/OTiOXavz6qFNeHDKg8rX16SIpr26+HbaUuzjEpZJKI7QL6/EJk1OG3nAAVzd+9xUF4eXaBsjFoDrF1ESak7+/LavjIgN2onJFiK60zGRzbC2/7XzDKXJW+a5vAyeZAPIGyZ4ocVW6PBix6x6qQAw5orND/r0lqglKIJ07pxUztXqTonv+s+qnymuoJtdfLx0LVQNUOgXTH/JZ5bGiNF1uqCQ50EV2tAb9R90MtUQqjqLGmf/EX6gpWbd9rt/Vw5pSL9Kt8qC02xJcfx/EG27rLhgKfDygqYrCoaiFYYBuFbXR48Es+uiE4FrlRn6pJr4OXuCDC/c6yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLwJmtMNRVbFSciTZpwkTI2KrkLEaxtyws44pWjXcnQ=;
 b=H/5fJ/UZyiEoEi8WckWTHunedKHf2mF4W1K9GkyM6QeUKgz7kyk/ukC/qNdxgJ8u1YIYTihhh3lE1J568uol7/O3cWO51E5tFI8IwtHguXCm3bjbv7q6YbmLnb+hf4yK8XDlJldy7YSc7rvq1ow/bgXZe+2l29+ryKyyYH85sFGuRE/5y0Dw24OfcAUivbkv89u0gksnXlkXoTdaJMpui36xPaKPekGu4V9z4LxhJXIw8ijfsruH8XfZRVQlTZvRJcIlmuxHaPLENaIYC18DcAZ7JX2e7uGHxcC8VRjWnwZmkJpERthH1zzV02ipqZTATqGGc+ho8vblkPNiuVZwew==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by OS9PR01MB16853.jpnprd01.prod.outlook.com (2603:1096:604:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 03:41:18 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 03:41:18 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: =?us-ascii?Q?Re:Re:_[PATCH_v2_0/3]_virtio=5Fnet:_introduce_an_R?=
	=?us-ascii?Q?X_queue_watchdog_for_stuck_detection?=
Message-ID:
 <OS3PR01MB10251FF1A3BCDD5A03090CD19E7432@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "Lange Tang" <lange_tang@163.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"Jakub Kicinski" <kuba@kernel.org>, "Eugenio Perez" <eperezma@redhat.com>, 
	"jasowangio@gmail.com" <jasowangio@gmail.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"Tang Longjun" <tanglongjun@kylinos.cn>
In-Reply-To: <413a69a4.746a.1a20cb9e72c.Coremail.lange_tang@163.com>
References: <413a69a4.746a.1a20cb9e72c.Coremail.lange_tang@163.com>
Date: Wed, 25 Nov 2026 03:41:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TPYP295CA0007.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::12) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <9655d6a0-7dd1-4560-9391-51824e172897@milk.local>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|OS9PR01MB16853:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7fc3dc-486c-49bc-4724-08df4aa5f670
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|6090799003|5072599009|24121999003|12121999013|15080799012|23021999003|24021099003|55001999006|25031999004|22091999003|8022599003|25010399006|19110799012|8060799015|3412199025|440099028|3071699003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlFwQUMrNDlSelRTdWpyUmxPdEgyUDlIWmNyYU85bVlDaW9CS2ZyUGpOTXN3?=
 =?utf-8?B?dDJ6MDEvTktyR3lNZEdkbWxFL3hEWWpPbTEzZ0ZrRzZBdG9OcERDZ1d6NzIr?=
 =?utf-8?B?d0Yyd2FmRnA1RmdtN1hNNnhmUkZTcFhyS200VFY2K1B0ZkVLQ3NkbGM4cHA4?=
 =?utf-8?B?YUtXV05QQUFTamxhZDNKZ1Z2a29GcktNMHJPTzZNdncycnpHbHRXWG5raDBW?=
 =?utf-8?B?NmIyYm1tSjNhNmJ2TDl4WmcrdGJzWE5OS0lSelR4YVpLTGNZTlZEN3dMeThu?=
 =?utf-8?B?eGlQSU5Cank1eHlYN2VLZWdlTU1aZ052ZEpIL1E5bVRnR3BCZCtVMHJoV0Z5?=
 =?utf-8?B?SXhpODZRRFpQcTltTzJPZktGeFU2eU53VkNHdU44bUlwTFA2VG45b2h1WU9k?=
 =?utf-8?B?RXRMZW5qN0xEM2ZpdmJHRTVidnkxaVFZWExrVE9YRzBYcEFOTTBPWFkyaXNT?=
 =?utf-8?B?c0NPSFpqeHFEOXlra1BKaktZV1NIN1Jab293aUlDbG1XdjlzU29hOTRod3JI?=
 =?utf-8?B?dktTcjlLK293UkZXYjBjSlhmUDVWcHhjT1Q2NldWbkJiWTkvbEdPb2VsRGNL?=
 =?utf-8?B?MjFpNFErVHhGMjZLZ045dXRLOVBlOW0vUGxVUVVuTm1pZG52RmRJcFFCdVN5?=
 =?utf-8?B?b01aL3pBeEU3OWtkeHF6ZHRNNFo2TSs4OXkzNUFDdm5lS0dwUUdFeVBlbFda?=
 =?utf-8?B?VWtzQ1NWeUVjMy9Oa3VvR1Nack1Zano1d0FtVEhZUHN0WmZ3NEhYS0txNnV4?=
 =?utf-8?B?V2xGMitnN1ZRdGxaTnBpVXBtS3AyWVorZ0o3N2Vmb2w0WHJYbWhPNENuNjRW?=
 =?utf-8?B?dnBGOS9yQnQ0Y1RvUVdVTTNlRUV1UUV3RFhicDRBOHpJSDFySVgraFRvWnhW?=
 =?utf-8?B?bVo1TWJLMURQT1BrdU8zbVBMVzhEaWdvLzN1MFcvTkFRblhmbFlrM3RraHU0?=
 =?utf-8?B?SEV3OUVmVDNPc2F4SVJ1TDg0eXhaODdQMGNaOGpQSVNvTHo2Y1B0RDloMUtm?=
 =?utf-8?B?WW5paEFLRmZIQjRDU0ZuYUZOSjZ0VU1vMzdMWjdNYWxFbGl2YnhuTXZUQ2Vv?=
 =?utf-8?B?cloxdVZ2NDNCTU1uWmk4aUJ1cktSUzlHOUhrZEFQVnp2U2JoNmNwNkQ1c0lU?=
 =?utf-8?B?TUd0MEFSQ1hYZmJ5aUVXWEdIRTdCbkdvQlpDRHZSSG5kZ2hZWGdwMjM3Y0Zr?=
 =?utf-8?B?UFlFTHFrcXJPb3JUQzdCZVg0WU5DMjh3aGxjTTZyMy93WTVXYzQ2VjVMOGMr?=
 =?utf-8?B?QnFrdURwQkIwQTFmYkdlb2IxYlJvQVhHcUJjSHRHRGc3V3YvTDRxdTl2OG01?=
 =?utf-8?B?QjV2R2NsT08rMWN6d3RUVTB2bGVnN2Qza21UUnFhQXNveDVMaldrZTNaa1pF?=
 =?utf-8?B?eDJGckJaUnpuUy9RVTQ2TVdEWVBkT2lRVk8xZE1ZVER2cmlUa0FxUEo2YmQ1?=
 =?utf-8?B?RXVueG5YNExKMVErWGZIbjJrUjh0NUg2TXNTeFA4YTd1N21oamtESVNJRnl4?=
 =?utf-8?B?V3lHSnRHdFJ2MlNaUUQ2SEJ4c3dMWGtnR3RVaHlXdVh2WnpsOHF3VGRxUTgx?=
 =?utf-8?B?VlY3Zz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0hDaytzYUdoZUxHN29OZEVBemtmYkNGSDR1YzhWNk1qbFBCTytSY2VBZk1Y?=
 =?utf-8?B?UnBaUldiOUhXdVE5bldKdkw0Q09lOXJ0WjNsVStFRjJJbU9qR3hnYkh0M1dZ?=
 =?utf-8?B?TnlsVEQ2T1pJNU4vU3Y3aDJzTXFhdkF6TXViYjRRaDNYY1VwTWJFZHRBTEt5?=
 =?utf-8?B?NGtmMlBybFd5OFVpZGtXQVVwQkVJN0hIZmhsMS9pVDYwdmhMT2NsTDRDSENN?=
 =?utf-8?B?TWlqbWdDc2dZOHBOR1NaN0JLdUF2TFhVdW5RcTAvRERJWkFDZ1krLy93b2dL?=
 =?utf-8?B?cHIzOEJLOUx4WEh4SURUN0hWdmpqTjBYUGE2KzQ0L0ZaNXhBZFhiQ1JUVHQy?=
 =?utf-8?B?eVB4Y2tFbVZXMk5HdzNZRFd5aXhwbEVOQnJCVTZFZEVTUGtlZTJ5Z1owM1g1?=
 =?utf-8?B?bXBwakVNWlAwS2d4VG1lSm1VR2gycngycVV2N0U3UzRuajJiVEp4Q2I4VDEy?=
 =?utf-8?B?b3hiV0hveDlZYVNMOTZXNkNNNms0ZER1cE92NUF5UWhSNERGMTBDNHV0S051?=
 =?utf-8?B?QnMrQkxYcEhwazR4aktoTStHVG5XV2IxYVRIMVFDNVZ0R1hVTlZKblhraDFu?=
 =?utf-8?B?dEZwRWpxdWdsbzZUcEZCMi9Yd0N0NklqaDF1dmgyL21uWU9KdjZYUWhaWVFB?=
 =?utf-8?B?ZjZha0dRVkJBV2J0aEdNUU5VNkdXTW55aHJkZ0N1SVZvTisrY1dEMzZ2VE1h?=
 =?utf-8?B?dUpzVTVneE9uZHM0NXBDcnpVTXJqVG5RbE91UXk2ck54djJoczRyc2c5dHR5?=
 =?utf-8?B?RXJYSEZBditmS1U0STZKNDNVOStuUk04UFVJTVlYMTl6UFIvaDJiYzdTaDcy?=
 =?utf-8?B?VlNwNUZTbUtHVS9uNHJ6Nm5pSkhMdUtqdSs2ODNkUUxwZ29tdFVJWVJ1TnEy?=
 =?utf-8?B?SWV1T3FsNzRZcWdSY1NmcXptMzhzWWNibnBORG5MOEd4UGdXdDhPeTBpSVZj?=
 =?utf-8?B?RlVsRk5mZklwdkpWKzdONUswa0dwWmd5VmI3eGMrajBqTVZPcE9HS2JjNDJP?=
 =?utf-8?B?d0RsVTR6cEVLQWcxeGM2VFlXQmpSdFZRZTBtRHphUU9YUW9PNm5OMW4zMyts?=
 =?utf-8?B?THpqSjcxTDhpNHR2MzkwSjRNb3Z0bWlrWVlDOFhVQXpVOVY4RE1sL0h0R0x4?=
 =?utf-8?B?azZ5dFdHd2hYY0tlQW5sVlFUeTBkNmJEc0hCUy9xbDAwYy91d2RTMDA5UVps?=
 =?utf-8?B?WEttM1RQb2U3T205ZlFSeE4zK1VNZE5jZWFQMTNMZVN5MVNXZ2FFNFVUdExU?=
 =?utf-8?B?VUI2c3I3YnV2TWZsZlJTVHVLdkJ5QlJSQ2VldGsrcnNMRTJ6N0hTaVJJQk53?=
 =?utf-8?B?VS83a3ErQWxqazR6aG1ydUZkTDRESncvTVN2ZGluQzVFNlYxbldNLzAwd2Qz?=
 =?utf-8?B?dGlLUUJwM0M4T1RGRmJRQUNxUUtqVThXNFFRdU1KTEFDWENlRzNRU1pEcStW?=
 =?utf-8?B?VU9qckdBWklUZWx1SEZWcS8vSTc4cWphY0xXcDZicUphVkJ1QjdETWt6WTIv?=
 =?utf-8?B?Q3lnYnh4U2VWekxDZnZ0SU1nUzlkdkVrOFNlSmxqWVUybEVuVzlSa2JvSXAw?=
 =?utf-8?B?MnNkRmZuUUNZZjMra3I0WTRhUWY5alJEQ0FOK2t1d0FrcHhya0V0NVBSUXZh?=
 =?utf-8?B?UzZYOTJhcU5PYXBFWFM2MEgwamt6RVFmUFhWRk15QW5idjhBRUNGRWtpS2s1?=
 =?utf-8?B?cUFrZEJ1NjFxTUt6RkxVSitNU24vKy85aHpVTk5tZUdWT3dzbkNud0cyc0U1?=
 =?utf-8?B?YWIxZlhJNVNwSlNVakRUVFVUVnFQQzdScDJDcURJcnNmWi9mcm9FU1JWTmpV?=
 =?utf-8?B?NzJBQWN2Zkk3WWRxdmUvaC9sR0NHblRvZU9KNndlUUwycmwrbTdWMk11Wk1t?=
 =?utf-8?Q?WVYAQi2wD0zR8?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7fc3dc-486c-49bc-4724-08df4aa5f670
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:41:18.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16853

> If that notification is lost, the used ring is not drained,
> buffers are never returned, the device runs out of descriptors and stops
> publishing, so no further notification comes. The queue stays stuck.

I agree that a lost interrupt can stall the RX queue. The point is a basic =
one of logic: A -> B does not mean B -> A.
Observing a stall does not establish that an interrupt was lost.
At least in the earlier messages, I didn't see evidence that an interrupt w=
as actually lost in production.
You explained what would happen *if* the notification was lost, not how you=
 determined that it was.

> I looked at Michael's patch and my case does not match it: at the time
> of the stall the callbacks were enabled, and IRQ deferral was not enabled
> (napi_defer_hard_irqs =3D 0, gro_flush_timeout =3D 0).

I appreciate the clarification. That addresses the IRQ deferral scenario I =
suggested.

Adding a watchdog may only take a few lines of code, but once it's in, we h=
ave to account for it whenever the queue changes state, including when it i=
s stopped, reset, or resized.
That's a long-term maintenance cost.

