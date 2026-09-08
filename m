Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05885231C91
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845835; cv=fail; b=D6U4EgPXGwuH0/lwxctjSwJO3gNXW1Dij0y6y9xB3Sus9y7xsHPFxlDKZLK3yJZAAKG8/6TI4svnSKTILg5Ty0ixjS+AaU8HufGOdYAUB67rp2CqLJZ3ljAjCP5hIEwxhDLx+8izyudDGKEs4X5MzekxiQAepliCQPANscV4bqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845835; c=relaxed/simple;
	bh=k76Ei1kh/1/nUrgCV+XQpXvr06R/RFCsJfT0F3yKFco=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KXx1yjEQMY+cdt5fblnaPEHIrAalxo8H+FGyUhmTV+w0HzVhtRK3b3n9VUNNaAv7MSvXGLBtBA9fP7Yvnn/05YuhGpcum5K7oV2ONKBcHF9L4XeAtmWbGLTjbBe323DfbodrhcuvLmV7anBQEYypXFg0AfRB8nrmyHXfyxzFNaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2AJPZaXs; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2AJPZaXs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1lCrtB+NWRh9HNC/HCz/3toOeeq74lKmGK++BGY9acmhjQq3zZMp3ICkO++gp5fNmG+BiyRHqlyRpZxXdOyp5QNHhNhhe9vpxDE0n4CcBZ0YrNS8eZ4VGU8XqdO4drbwwB2Y1Qd47Az8EMM0+vwGrKWzdvZhGqrbWTByvYTzUtJOexYI/8dd0zrSxxG2koUhS5UFM5FTNooax7czwlPvUPHXwH37inZyja+5Xbpc0vgiH0joRr4a3RVPhidOJz3yf4VkYMY9qltPUDtRmP3tYUPlqzUsWpYh4Pe1rMYvLgaB/Oo3funMCsm4Zry4kKXjJFc4yaYfHpvBPCUROQE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wCUrSEmJgES5apDFrs2Rg7tjnq7lVKgBfeNFdmFCkk=;
 b=mz0Z+8BSNltzQ9RXOfSBRPMqMUFdX9KSYZ6Fl7OrW3jfFCsWXZoUTOlf7ayTlIni/4ANkBJuKSQRsjxLYvbwnzzBvtSWMi9E5dYATuf6N6i1yF3XzNzHprfXRMXd7T/hDLvCLVG/XOlhjUx4kZFf/6zowoy2Q/eO3ZMS1WYTS0sTdmuZOaEXZN2cCB7aorXxyZkEH3bB+Rq7SoXrGWs0o28q1s3kAY+Eghi39xuxowfRyKlY7iRp38Nbokcyb0WM7P4uJaNPfVoRp5zkYkdHCOZcVtqgrxXe6uPrm/bftpcn5QY0J2cKLmpinVE4S4hCqTt6jVyLhdcXKi/XrvGgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wCUrSEmJgES5apDFrs2Rg7tjnq7lVKgBfeNFdmFCkk=;
 b=2AJPZaXssynHGJScKQ1QKUEybprE/vWn2XdWpkcwIM+Xg1z1Dh1IdQa5TiUfeeSZJ1HtoKZiUCsFpxSYY1fmo+17/sVzgFtg8ukZTFevLfmGMtsVX93Jx8rl2fpmSWPZCLg5Yi01ABI2JqdOSvNXkjuVTzFr03ia44xdobQEwyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 05:37:09 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 05:37:09 +0000
Message-ID: <06255bf9-b89c-4c01-87b3-f2956ba1367f@amd.com>
Date: Tue, 8 Sep 2026 13:37:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
 <fc5c5bc5-d3a5-47f4-8a86-bcd531f0803c@collabora.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <fc5c5bc5-d3a5-47f4-8a86-bcd531f0803c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0064.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:39::15) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 742fa4cd-7b43-4035-d8a1-08df0d6b3995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	THIyL94Vs4wB6QmOjEzSVA+uGA7S1tRFHChBhmZbv9jTWv0KO0qa2m3/e7zTf8uGyU2JEBJqsmhcOpiykPAD3hdFc3fqrdrwYxqIl/DfQJeWz+WEoHzZ0BUw0yyek1Z4kzEBAIvGHw0Z3NSM04MI2mVrGfo6zlUxOq71DiWIMTiA0k3c2I8BaXBxdkb2U9kQPnXIDFw+p2CSncz/MwwzjD5FNpOwqf8bj10llvGL4mHxSz/KoiNFwAmfEGzsPm3lxqI2r6G1iMtd+pu4o8sQjN6LyJ+zaospZTG8Dj+xpp4Iv/TYx33oJhv+lwz4zucugM+fSzcXBWluBTwvMHFjkJzrbTcnv3dq6dl/PKJSaBiJxzTK7aQjdnZDC3fczycBnxaU/J19LFLcGs4DTq9CJslX37BkYqcfhyBtwn6NH8NcabHy9U40W/SmD+EUD4y0PPRb/zD6CO+rm6rRcM1YJQBf2pxkJyKRFT1/zHspt4jftT71GTIT9l+h/NHqNL8sBOqpllgdcw6Vvn6lPljk656720z/rTaTRKoL8w27OsSkzHm6m3BR2u3/6KIvKK56sXbpS8GV9eh1sDEJkD19HrxapU0lceg7Kaclhy8HE52ZVCS0N4FFuJAUrRSZ6TWyFs+Ca2Ol0mSseN4b8VbGsobqxt5MoVag/mRSQOqxyyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7170.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1hMSnd1N0lnM0tmZHNrenB4OHBZNHFHYWNiSEFpV3R6ZVlTc0tqeGwrN2VV?=
 =?utf-8?B?N1pic2M2QmpEY3BlcGdjM0tvcElsY1hsRW82UWwwekFCbjQ5a0g1aTNnT0N5?=
 =?utf-8?B?bHpVUHBETUJYQ0FPQ3pMUW9wL1RJL2g2TUJmdVJ6bFIyYTdPSnVTMmhPZ25O?=
 =?utf-8?B?QUdJTFhJNEdHS3BERG5VcUZMSnU0eGlrWW4rYnUrYmZhR0RHUXlHRytXRGhF?=
 =?utf-8?B?SXE1dWIrOCtDV2h6aWNBcVJsS3YzZ21ob1h1NkJJM0lSZlhja2dJSE5PbUZW?=
 =?utf-8?B?VVdhL01PYzNiMmtzOVROOXAya2FWTW0wMmlrRWNQV08rSFdoRE5wUjh0SVhr?=
 =?utf-8?B?NWtWeUlrMVpvY0tDN0pCMFhyK1ZNSFh4OVQ2RU5yWFNGRnMvSjVJdkhoMXFw?=
 =?utf-8?B?OWJqRnJtTndsWEtxaHdjS1ZlbFJNbXNNeG1rVjQzSWZFblRtRE5EYVVzZTNm?=
 =?utf-8?B?eG1YQXdlbjFxZlErWm12K3VlTTJRdTZJSzZmNGd3eENoSEdYZFI0TlU0MlQ1?=
 =?utf-8?B?cHdNRUlvcHdibnpra3ErMHR4Q1pyT0dld3FhV1JGUzNQR1pha2h2eVNHb0Np?=
 =?utf-8?B?aEk5SjYzOHBJREZUd002TzFRT2ZIUDI5aVdaOC90UFk3a3JZanhGcTJMamNU?=
 =?utf-8?B?S2FNNHY5aVVSellYa0tVY0VPc09LNTRyM0lEZGUyUCtVN08zUlRZdW96MlpL?=
 =?utf-8?B?ekhvYkVIS1VLbEhBL3o4VlhGbm4wTjFOQjdIaGZvajQxZ1loTmxabGFiMXYr?=
 =?utf-8?B?L2hvNkVzNzJXdE1qaXBqa1I2dWdmWmNsQmM1emFkZDN4Tkg3ZzU5MzFjRWxp?=
 =?utf-8?B?VE56UlVHVnRmbkErcnZra3BlUElwRlZLTGt3MTFMZWc1eHpBd3NhNzlTQ2N4?=
 =?utf-8?B?a1VNZThxeHJ0SVNIQVdBa3c5L3BjSkp2VlBNRDF4RU1lMnFFYjRLTk1MV2Nx?=
 =?utf-8?B?N3hxK1VlTElZbXpyUHJSS2krOE1KZ3lGNU0vWTFuZHhsb3dheitPQ3YrdDVM?=
 =?utf-8?B?ZWx3dHpMYlhwSXBwU0piMngrditRb043bG5hS3lZMHNKWjArM2NYVkY0Z1JO?=
 =?utf-8?B?S3l1c2UrT3hMOVE2bDlqVmczb1VsNVdYSkJPWjNDaGYyeVBNbjd4cEw4c2hX?=
 =?utf-8?B?K1BEU2xFaVVuSnNuQms0RFpxNGNXSlZDSmZ4SnBGaWJpemkwNUNaUzRHSkVL?=
 =?utf-8?B?dlhZQ09kbXViU1hCRFhZSFR0a3gyRVEzb3BGMVI2aVZxUW1EcVQ3THhNc2pi?=
 =?utf-8?B?c3RXWkVBMFRmaTgyZEhZVExoNWN6V25IeUFmdTdQV1JtZVpVejBudFE0OUIv?=
 =?utf-8?B?N0J3RUMzWWEzWXZVTE0wWmtuQ2l3YVVucmU2ZS9Kd09jdjFPakdYbjM3di9G?=
 =?utf-8?B?QzAzNEIrWEZ5RTYwRUYwWFpheldPNm5WOVhZcU53MzlZM1JtcnNyWHlyN2tr?=
 =?utf-8?B?T0dFTjVYT2VsNkx6UzVyUElydTM4NHJIcEVacHQvVnB2OW5CRys3RkE1NDNy?=
 =?utf-8?B?SHJCRGZoVVFFUHcvR2FleE9ONFdFWVJqL0F4WGtIYkdYMHpaWm9hTUc4a1N0?=
 =?utf-8?B?OU55SlVvT2ZIUDFzNXFHbDJnM0xmNitOdEZ3aExHQWliY29KWUdHdDluSjZS?=
 =?utf-8?B?OWY2L29lMk81d3RhaHZ4bkQ0dVlpK0daRjFVNVpGdklpNWltTUo5cXNneU5N?=
 =?utf-8?B?UGk2VkJuVjhjRE42YkNKc3c0alMvdHZWdEdIb0orbHh6dUQ2bmZSZkEwVnN4?=
 =?utf-8?B?U2hqalFxTGx5bzFsaS9VckxHanFCYzI4OGFmdC9SczFSZWl0MkhEb3V3aGNr?=
 =?utf-8?B?QlhTeUVaZmVMRG1uSFpjQVk3YzdEQUIwYlVzNEFrMXFqaVlPcXJsanZMMzJB?=
 =?utf-8?B?cXFUblRTQTVDOVA3YmNjT0JJcW9kV2RoWmRYd1JHUXYyeUdyR2NGVkN2UDhj?=
 =?utf-8?B?WDFRT3VVSE1uRDd2My82cWExMHBYNTZTVllpd2VwR0syR0xldTVTdndKNnp4?=
 =?utf-8?B?NXYrTlJHS0xaT1BLeHd1STRGam55dFJGcmlJSzF3SWV3K2lqOTVUMmRNUzBw?=
 =?utf-8?B?SzV6SzVnOXljN0ZTcEF4Z2FYaksvbEF1Nk1sM0NnbDQ4LzM2ODFReGtJUjZ5?=
 =?utf-8?B?T0ErSzFBUHhzaFdYeFpsRDBZWVE4MzFiQW5NdkNHNzNXVlNFdHlpYnFub1Zt?=
 =?utf-8?B?SFVIaDdiUXB4YzV6enF3RVoxUXhkcHRWNkZoNGQ2bHRMWmFQeURxelFCNWFr?=
 =?utf-8?B?aXZJbEg5VlA3amdxMTRieGZ1MGhRMlpqbDZLUzU4c0xCVU93bWVkRGpoMkNq?=
 =?utf-8?Q?W+uHr0CrdOs5s6aMtQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742fa4cd-7b43-4035-d8a1-08df0d6b3995
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 05:37:09.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5b111mpqlr1z9KZHUsUBR2RB9+QQKXfrozat5TEsw0jcgVyYOH4hf825h8hhI0Snzwo5mpuzbSjcfe6fQGDVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857



On 9/7/2026 9:05 PM, Dmitry Osipenko wrote:
> On 8/17/26 06:19, Huang, Honglei wrote:
>> Hi Michael, Alex, Dmitry, Akihiko,
>>
>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm over
>> virtio
>> implementation to virglrenderer nine months ago (MR !1568 [1]). The ROCm
>> side has
>> been supportted by ROCm offical.
>>
>> Current implementation is a virtio gpu context type capset handled inside
>> virglrenderer, sharing the display path. That's an awkward fit, many
>> compute GPUs have no display engine at all.
> 
> The headless context type is totally fine with virtio-gpu. For example,
> ChoromeOS wirh crosvm disables display entirely even on guest side by
> building virtio-gpu kernel driver without KMS support. This is something
> to improve in QEMU to make it work without GL context.
> 

Thanks for the inforamtion.
It's great to know that headless contexts are fine and that ChromeOS 
already has a working model for this. The changes to the ROCM native
context from QEMU are not much, maybe we can leverage the changes made 
from ChromeOS to assist ROCm.

Regaeds,
Honglei

