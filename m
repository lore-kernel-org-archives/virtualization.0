Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793882136;
	b=a9Vvo3z770vweniXbe0Tun000AhkMn4PDhEr1WLKWepeN5A9PyrhF4c4pCo8lADDW+z/
	 JZf8nUdCyUB6gYKdq23tf/wKXYwCAzZnOPectfM1R7n0YSxHKtXkBMnVoYmHCMCaSuS2l
	 7ATgFdDjwFC0FD4JxZ+52axBcwVAvTNEOPF9vF0t2ZAuN6wfO3WbRkuFv2B5SgmeAqi+y
	 vFyq4CB5eTnlJLzS+m3IzDbq7gMqLpzhTW7TF2xsk2PI9cIFi4LqgNuLfqkZwzanPJ021
	 B+bU+LjBn5R4yWs3pEE+0uXArGjWSjaVtXzQHG5HG+aY7EKsbhXwtgLiugUadq1Sn/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882136;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=E8BjdhayNG7EdIhnLuVlT5Ov6C44z4Uz2CQw5TNCAb8=;
	b=s8ZQezVx1P/5bFJQb4GM0fkfdBHiTM5+YjSHCh5rNbgkmZ7OsRrWeHMV4KQl2KzqL/U7
	 ggNAgB54TviMH/9apkIsY/jIVE7raU1UvtiMvV8mjh1r2NMumtWWWBYcamj9V5VN32Xqq
	 3M50zDMJnc+/ElPloEZQqlF390QR2YXxXU+I4Z/3HRCgodixj4YN/L0IDoZhUB72BmknM
	 IN9xogWbpSwCLG0ojaksCZ6DSlIMPSHUMeo+Thie/6eUW1ddm/NuhVosyWCwGd7AyYwWp
	 QQhOPGzoyk7YzcH6WNLYXdIKhzijz8IjSRzT2DG/N+t9g5K6yAGubpBbhb3j+pDiGgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3LPfNoAq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.17
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0397606A328
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 12:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0397606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3LPfNoAq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiiLWaxf+JvLBrreR02AMWnsBIwZXoBQDqRzL5og5C5l9BSw/lvuen1E4aqsKL2CvlgLfcZDRIMcljOcoMdcJwp2kHq7HIA286gxh28guxPrgqa5ZsueCI8KuT216J2ZGepMr41riwL94v7c+kYa5zXp5oi8qMXqCeQh97FzkANYI5M/BY40LK6Q4JqSr0XPUZyl2ssafvzMy2RvrZsIh2FaY8y06b3pbAaRphSJZS8/HdrouUVAft5Uk/eB8I34xgvUWXuFLEKvUJqSv8uVyKnVUwZS19m9cuOthwPBRWt4wCVxvTMS5ioJcwbvAZgTNnw/AfViZjiLybZMq7yIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8BjdhayNG7EdIhnLuVlT5Ov6C44z4Uz2CQw5TNCAb8=;
 b=RSNKtUYJ9/CnwJdL+X+KrAeC1sDduHA8FPKJjMNUaa+SBV5O5no7PSeXZ/NCltNoFL76fZeRx3xvipK7ochvnSvWEe9GW8DbC17HdfVTu9EEIDVZE0oZZW3oO7v9zO1hvG5IAIZOkl1QaaaOaFsvpZHQZiiPexaChA6m2gDV4KazVNsns3Qfcyv5uDoEgUKsVHGeh7xe0ocuc1wxXykRtdpqcwTXyYVQn3UxzrcSLfBAl6Jybu8deQCmtt4Gc6xd8Eip16IMTfvFTjV1SUqaP7uckq5348ZNqHPNb4LIU7jEIJyIHsJ05xEzt85NRGu6eMfXsD11lmxTyLIM5Oz/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8BjdhayNG7EdIhnLuVlT5Ov6C44z4Uz2CQw5TNCAb8=;
 b=3LPfNoAqbTrE2pkqfOXkIx1qXoVMr89TO8C11h3mQB6fOuJ6xtewP6FnmQvZkdgfxljef4uPa4jg3khd9oXll2LSK1u2JZI71BCZwswZVfTSD2Qipb2qlFCSadTQOX1BJb6t0RDoSOki+gNpe9KjnC5vTWDuOrx+mejF2rqfCjI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 12:35:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 12:35:31 +0000
Message-ID: <005b77fd-5bd2-4ae5-a0c0-cff3f1f6c680@amd.com>
Date: Thu, 5 Nov 2026 13:35:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
To: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.or
References: <20261105113529.1989375-2-phasta@kernel.org>
 <20261105113529.1989375-3-phasta@kernel.org>
 <2f377d0f-2760-4465-ac68-b62210b33bd6@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2f377d0f-2760-4465-ac68-b62210b33bd6@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0435.namprd03.prod.outlook.com
 (2603:10b6:408:113::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbc68af-6569-411f-562d-08df3b3947a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|10067099003|22082099003|18002099003|4143699003|261102123227099003|260925021311599003|261026121527099003|261021121427099003|261026135527099003|11063799006|261009221727099003|56012099006|261021133027099003|261022075727099003|261009220027099003|261022113327099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261022115727099003|261026130827099003|261009221227099003|261009223327099003|261021135927099003|261102130727099003|261021130227099003|260925022911599003|261021123027099003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	H8LhfNh+YPt+H2rlm2DtQFvZ6LnriJSaZUGRV/thZJUi2kAlV9kt1vfh1AZBPiDNwVqVDcZoeVQEZexmVfK4VZ6Qu/1fkW/LsnrBTUYhKH2FdhycetT0zOObru0bp5/jhQHQDhpQd7KLI6SdwyeWDDBq71QJi17fU3EohO/9gWbfZvUvmblz1gok1iObIpUt/0svQE+Bh8ZselVtIhmFNBO7z7XwaWYxD3jWt+Epm3tsgR+7ALO6acBnXA2pZOiIfaNu+ushVG4MGHbNBUpkjBpmlpeLQFm8GKUwXtQA0YR07jTViS9jU5Z3gVJs6GsH5wsXi+Y+nd0Kjs+z3lucdd4ilg+0XtfHELd4Ry1U5rvEAUsSbAmGdjSnDyGOXt2QOMgnH7C4pxJXZeCnOcw7ddIzs9EajOyIqmk9jiEBkPpZLsuXg2sgm0jBASgHW2xgGCyAClF656lghZwk5b8ZqOowyq87jk+8KxmzH2td13kK1Aic5nIJvLMdSAIb6JfF9PFEemLpVflccdxirrx5ixEk7EMbcSxnHsQOxSUBYvjuIRA4MnAuJc6J8lid7l+9HxsqDJP7G8lFsd6b1ZpaIxexNGub7FjEmbsCFuPh5aMKOrs0usQKp52TO4rPuahZrQSIedpLoDemc/7OhlAj0nSIac7ZrFeZlAmBnLOPiYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(261102123227099003)(260925021311599003)(261026121527099003)(261021121427099003)(261026135527099003)(11063799006)(261009221727099003)(56012099006)(261021133027099003)(261022075727099003)(261009220027099003)(261022113327099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261022115727099003)(261026130827099003)(261009221227099003)(261009223327099003)(261021135927099003)(261102130727099003)(261021130227099003)(260925022911599003)(261021123027099003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eitJbDJwMUQ4a1pCd0dwY0Z6b0tFNW9QZ3EyVjl2Yk0wMUt6VVQ2TkJNbVdF?=
 =?utf-8?B?anlGaHlKUmQ0eThpc01MOXkwZEo1dkZPM2lrNHMrZ3Z0SEpEUXcvMSsxNjMy?=
 =?utf-8?B?akc1M0o2ZWhKZmlXTHcrMlQ5c2kwd2VxMk8yR3pMbEYzTkF2Vzh3SDBYejR1?=
 =?utf-8?B?Ym9SRzh3U0hLU0NLVXdrcEFVMWt2bVd1RGFUUHRibEJDOXJIb0w3M3AvWFM4?=
 =?utf-8?B?QVYrTEdocmZSTmpjQkxBRWFUSUM5bHMySVg2WTYvbiszYUs1amRHelUrTm53?=
 =?utf-8?B?Wk9PWWxxdXVxWVBodnpubGgvdDd1c0JKaktaeXFwY2RLSVN5T1NBTGFHY25N?=
 =?utf-8?B?V3dEcW9pK2pvQXd4QWs3TTlaQ1VCT1FUVnlwaWJWQnAxL3BQNGY1OEZqYVVK?=
 =?utf-8?B?QnVSdmFWS0hiQXNMV3dPZlpUaDg5QUVrSHlyRzl5ZTY5Y0o2d252ZFJUYWph?=
 =?utf-8?B?NmNRT1Axbkk5cDNVc2ZYMkxGUkY4R3hsODNRVHNUMThDMjNBTDYvU0Zwa2Ns?=
 =?utf-8?B?ZU45bDVDSG9sbHJWdlljSEtyaUVCQTRjNVZoSEtNMFRxaCtiZmcyaHNFTkk2?=
 =?utf-8?B?OUl0dHFKbTZDTTZYQmZuaCs5S2VvSDRyOWNOazhSc080Rk03NWNsZWR2M1Q5?=
 =?utf-8?B?MjYrUHJrZzB5TDVvdFdnR2lJOGw1OXFIVGNGNlRHZk5OanNFREx4SlBSdmlV?=
 =?utf-8?B?U2pKUFFwV3NKR2ovVWp1dzZSeXJGWjh0ZjNsSFJaWjdTNVp2Z3VPTzdFQUdw?=
 =?utf-8?B?eTgvaXNDZ2k1dmNyL0VlSXNoamxVaHFHWXRub2JXcmV1bzluVUdZd0laUzJJ?=
 =?utf-8?B?QW84anc2TWx6Qk5meG5jOEVWajlibk1TUHVCa0t3WFExaDhIeHJGRHRFOWs0?=
 =?utf-8?B?UmFEaEJKcWh5SXRiMkVBenA0ZEJRMjB1SlZRMFM1RnorTnUrTS9YMGlUQXpx?=
 =?utf-8?B?MmY5UTE0dmI4THpxeHptcGEzV1hGT2k4Vm0zNTlYNC96aC9zc3JjU2FIN0hN?=
 =?utf-8?B?eTNsV1UxSzB2ZG54dlBzczFDOUloNG9mOGFGN0NRWmlZVEl5MHhCWGlzQ3dr?=
 =?utf-8?B?M1Z6c0FQUlE4bG1xcHNVL05RMUFwb00vRE03cUd3VVdpeHB1VnVBSGh4SDFx?=
 =?utf-8?B?KzV1RWg3S0VwVHR5eHlwdFcvblEyUlhSYUMrbWd6K2N0Mkc3UENobWU2U1dC?=
 =?utf-8?B?WWJKbEx6RWFSdnZVZmlxdS9jRXBTelhvSTRoQTMzSUk0YzUzTG40NU1seUh1?=
 =?utf-8?B?QjgxWnN4ODJVQVRFZmhPTmFPR25pV29FV0x0NGZ3aklBazUwak9Cd21ObVB6?=
 =?utf-8?B?aDVTN0N6dW4zZHM3cTlXMU1oSHJyWlZEdzJqVU12MDlHWEExOGRQc0Q5U1BT?=
 =?utf-8?B?bHZuQUZpZ0dTT0g5bE9vQXMwZlRFZ3o3K1Fack15SXVYZ0t3K2NUenNZNnFh?=
 =?utf-8?B?OVJ0WGdKOUhsM2tYcW9salgvVjhEcUZRSnBJOTl4OWRyWmtkUEVIMlV0cGht?=
 =?utf-8?B?RTFlS1hzTGRpdU1ibHpQMEg2SGQ0QjJmeFhPZmsrdG5rN1pGVStWYkVIM0ZR?=
 =?utf-8?B?d3FJSkpXTGN4Vnl5YlpKOGNYd0dEU3dMMmU3WDVhZ1pldm9kbkgveUVkREhZ?=
 =?utf-8?B?ZWhQbkFlYkdwL0hFcG9yeUlJYzJhZFAzUWtUbWMzTlZ6NkVhbUx5Rmp3Wk50?=
 =?utf-8?B?OWMyU2hqM3ZUNnV0ZHloU2lNYTV0ZXhaZGxKSEtWd2svL0xHVmtoanZwcnlq?=
 =?utf-8?B?bkFWalIzMjB1dThPOHFsTXF0SHF2ZVBjemlRSEk5emE4NlkrWTBwbWppOS9Q?=
 =?utf-8?B?eVZHSnRwQVZxTlhDQ2lReVlwMm1yNXBrWGlYQlhQN0kyTzRoV041bmVuVHl4?=
 =?utf-8?B?NkN1WVRobjB1MnZVZTE3UUd2VklYWW9KQVNUR2hCS0hzR0FYY3d6ZDdyQThW?=
 =?utf-8?B?OHNLa2tESjlqSlpYMkRQdS9mdFFJYmxTT1ZmUzRkd0JKZjJwa0hkYkJrU0lk?=
 =?utf-8?B?MEprN2ZabW1wVTNTT08vWit2S3JPT2RtVGtWUzA2TzlLNXF3eFlLK3Z4UldV?=
 =?utf-8?B?WnI4MjNBT2c4QzduN2U0MTZzVXVOdTRERmd6Vmw1dFFEd2ZuN2lLNWtBdzJ5?=
 =?utf-8?B?NXFTUXBKWEM3dERTam9HVFRxM2VQMFo5NVpQeE9uQ2E1ZENyNkV5aUJTNW9H?=
 =?utf-8?B?SW84WlJnV2FGRVd4MmhYUFpJSW90SU1vTEFmc3NSUVRSRE1UUENleHF3eXlY?=
 =?utf-8?B?Z2paUk0xZjN0K21IN1M5S2hrcTVBaWRTOFQyQytFdkV4Y3ExL09yMlpkdXEz?=
 =?utf-8?Q?xBnLy3XL13N1JaDB66?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbc68af-6569-411f-562d-08df3b3947a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 12:35:31.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGkkdZPlLcHgOsDaCoGuEXC/1gcCMQKbxze60tDNOzkYOj1qXS2b6wnG6BHkQnFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004

On 11/5/26 13:06, Tvrtko Ursulin wrote:
> 
> [I aggresively rewrote the To: list because my SMTP won't let me send this as it was.]
> 
> On 05/11/2026 11:35, Philipp Stanner wrote:
>> Currently, there are two init functions for dma_fence, dma_fence_init()
>> and dma_fence_init64().
>>
>> Since more future user options for dma_fence initialization would
>> require distinct init functions, too, it is better to do this in a
>> unified way.
> 
> Why not add something like dma_fence_init_flags() and leave the 99% of the callers out of the (huge) diff? Ie. just port dma_fence_init64() to dma_fence_init_flags().

Well one advantage of the Linux kernel is to avoid such wrappers. I think having more than one function for the same thing basically just adds more confusion.

That's also why I would really like to just have one dma_fence_signal() and not like five (or was it four?) variants.
 
> Also best to move the addition of dma_fence_flags_invalid() to the patch which adds dma_fence_init_flags() and not have it in this one which is supposed to be functionality neutral.

Well this is the first time you can actually specify flags so that kind of makes sense to now add the check as well.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>> Add a flags field to dma_fence_init(). Adjust all affected drivers,
>> preserving the old behavior.
>>
>> Support the SEQNO64 flag, and add a check-function so that the user only
>> sets valid bits.
>>
>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>> ---
>>   drivers/accel/amdxdna/amdxdna_ctx.c           |  2 +-
>>   drivers/accel/ethosu/ethosu_job.c             |  2 +-
>>   drivers/accel/ivpu/ivpu_job.c                 |  2 +-
>>   drivers/accel/rocket/rocket_job.c             |  2 +-
>>   drivers/dma-buf/dma-fence-array.c             |  2 +-
>>   drivers/dma-buf/dma-fence.c                   | 31 ++++++++++++++++---
>>   drivers/dma-buf/st-dma-fence-chain.c          |  2 +-
>>   drivers/dma-buf/st-dma-fence-unwrap.c         |  2 +-
>>   drivers/dma-buf/st-dma-fence.c                |  2 +-
>>   drivers/dma-buf/st-dma-resv.c                 |  2 +-
>>   drivers/dma-buf/sw_sync.c                     |  2 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  2 +-
>>   drivers/gpu/drm/drm_crtc.c                    |  2 +-
>>   drivers/gpu/drm/drm_writeback.c               |  2 +-
>>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  2 +-
>>   drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c  |  2 +-
>>   drivers/gpu/drm/i915/i915_request.c           |  2 +-
>>   drivers/gpu/drm/i915/i915_sw_fence_work.c     |  2 +-
>>   drivers/gpu/drm/i915/i915_vma_resource.c      |  2 +-
>>   .../gpu/drm/i915/selftests/i915_sw_fence.c    |  2 +-
>>   drivers/gpu/drm/imagination/pvr_ccb.c         |  2 +-
>>   drivers/gpu/drm/imagination/pvr_queue.c       |  2 +-
>>   drivers/gpu/drm/lima/lima_sched.c             |  2 +-
>>   drivers/gpu/drm/msm/msm_fence.c               |  2 +-
>>   drivers/gpu/drm/nouveau/nouveau_fence.c       |  4 +--
>>   drivers/gpu/drm/panfrost/panfrost_job.c       |  2 +-
>>   drivers/gpu/drm/panthor/panthor_sched.c       |  2 +-
>>   drivers/gpu/drm/qxl/qxl_release.c             |  2 +-
>>   drivers/gpu/drm/radeon/radeon_fence.c         |  2 +-
>>   drivers/gpu/drm/scheduler/sched_fence.c       |  4 +--
>>   .../gpu/drm/scheduler/tests/mock_scheduler.c  |  2 +-
>>   drivers/gpu/drm/ttm/tests/ttm_bo_test.c       |  2 +-
>>   .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  2 +-
>>   drivers/gpu/drm/v3d/v3d_fence.c               |  2 +-
>>   drivers/gpu/drm/vc4/vc4_gem.c                 |  2 +-
>>   drivers/gpu/drm/vgem/vgem_fence.c             |  2 +-
>>   drivers/gpu/drm/virtio/virtgpu_fence.c        |  2 +-
>>   drivers/gpu/drm/vmwgfx/vmwgfx_fence.c         |  2 +-
>>   drivers/gpu/drm/xe/xe_hw_fence.c              |  2 +-
>>   drivers/gpu/drm/xe/xe_oa.c                    |  2 +-
>>   drivers/gpu/drm/xe/xe_preempt_fence.c         |  2 +-
>>   drivers/gpu/drm/xe/xe_tlb_inval.c             |  2 +-
>>   drivers/gpu/host1x/fence.c                    |  2 +-
>>   drivers/iio/industrialio-buffer.c             |  2 +-
>>   drivers/usb/gadget/function/f_fs.c            |  2 +-
>>   include/linux/dma-fence.h                     | 12 +++++--
>>   rust/kernel/dma_buf/dma_fence.rs              |  2 +-
>>   48 files changed, 83 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index f4004630dc1b..f2245541f1ee 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -53,7 +53,7 @@ static struct dma_fence *amdxdna_fence_create(struct amdxdna_hwctx *hwctx)
>>         spin_lock_init(&fence->lock);
>>       /* Unique timeline context prevents eviction from shared BO reservation. */
>> -    dma_fence_init(&fence->base, &fence_ops, &fence->lock, dma_fence_context_alloc(1), 0);
>> +    dma_fence_init(&fence->base, &fence_ops, &fence->lock, dma_fence_context_alloc(1), 0, 0);
>>       return &fence->base;
>>   }
>>   diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
>> index d656b3ec670e..d4fc71436cae 100644
>> --- a/drivers/accel/ethosu/ethosu_job.c
>> +++ b/drivers/accel/ethosu/ethosu_job.c
>> @@ -219,7 +219,7 @@ static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
>>           return NULL;
>>         dma_fence_init(fence, &ethosu_fence_ops, &dev->fence_lock,
>> -               dev->fence_context, ++dev->emit_seqno);
>> +               dev->fence_context, ++dev->emit_seqno, 0);
>>       dma_fence_get(fence);
>>         ethosu_switch_perfmon(dev, job);
>> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
>> index 76bacabe496b..6b4f059fb209 100644
>> --- a/drivers/accel/ivpu/ivpu_job.c
>> +++ b/drivers/accel/ivpu/ivpu_job.c
>> @@ -519,7 +519,7 @@ static struct dma_fence *ivpu_fence_create(struct ivpu_device *vdev)
>>         fence->vdev = vdev;
>>       spin_lock_init(&fence->lock);
>> -    dma_fence_init(&fence->base, &ivpu_fence_ops, &fence->lock, dma_fence_context_alloc(1), 1);
>> +    dma_fence_init(&fence->base, &ivpu_fence_ops, &fence->lock, dma_fence_context_alloc(1), 1, 0);
>>         return &fence->base;
>>   }
>> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
>> index b2a00992c889..574c9ea802c9 100644
>> --- a/drivers/accel/rocket/rocket_job.c
>> +++ b/drivers/accel/rocket/rocket_job.c
>> @@ -61,7 +61,7 @@ static struct dma_fence *rocket_fence_create(struct rocket_core *core)
>>           return ERR_PTR(-ENOMEM);
>>         dma_fence_init(fence, &rocket_fence_ops, &core->fence_lock,
>> -               core->fence_context, ++core->emit_seqno);
>> +               core->fence_context, ++core->emit_seqno, 0);
>>         return fence;
>>   }
>> diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
>> index 5e10e8df372f..e2dddbfddea2 100644
>> --- a/drivers/dma-buf/dma-fence-array.c
>> +++ b/drivers/dma-buf/dma-fence-array.c
>> @@ -205,7 +205,7 @@ void dma_fence_array_init(struct dma_fence_array *array,
>>       array->num_fences = num_fences;
>>         dma_fence_init(&array->base, &dma_fence_array_ops, NULL, context,
>> -               seqno);
>> +               seqno, 0);
>>       init_irq_work(&array->work, irq_dma_fence_array_work);
>>         /*
>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>> index bd58688b81a7..a511cf755ee8 100644
>> --- a/drivers/dma-buf/dma-fence.c
>> +++ b/drivers/dma-buf/dma-fence.c
>> @@ -122,7 +122,7 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
>>     static int __init dma_fence_init_stub(void)
>>   {
>> -    dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops, NULL, 0, 0);
>> +    dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops, NULL, 0, 0, 0);
>>       set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
>>           &dma_fence_stub.flags);
>>       dma_fence_signal(&dma_fence_stub);
>> @@ -156,7 +156,7 @@ struct dma_fence *dma_fence_allocate_private_stub(ktime_t timestamp)
>>       if (fence == NULL)
>>           return NULL;
>>   -    dma_fence_init(fence, &dma_fence_stub_ops, NULL, 0, 0);
>> +    dma_fence_init(fence, &dma_fence_stub_ops, NULL, 0, 0, 0);
>>       set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
>>           &fence->flags);
>>   @@ -1063,7 +1063,6 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>                spinlock_t *lock, u64 context, u64 seqno, unsigned long flags)
>>   {
>>       BUG_ON(!ops || !ops->get_driver_name || !ops->get_timeline_name);
>> -
>>       kref_init(&fence->refcount);
>>       /*
>>        * While it is counter intuitive to protect a constant function pointer
>> @@ -1087,6 +1086,21 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>       trace_dma_fence_init(fence);
>>   }
>>   +static bool dma_fence_flags_invalid(unsigned long flags)
>> +{
>> +    const unsigned long valid_fence_bits =
>> +        BIT(DMA_FENCE_FLAG_SEQNO64_BIT);
>> +    const unsigned long valid_user_bits =
>> +        GENMASK(
>> +            BITS_PER_TYPE(unsigned long) - 1,
>> +            DMA_FENCE_FLAG_USER_BITS
>> +               );
>> +    const unsigned long invalid_bits =
>> +        ~(valid_fence_bits | valid_user_bits);
>> +
>> +    return flags & invalid_bits;
>> +}
>> +
>>   /**
>>    * dma_fence_init - Initialize a custom fence.
>>    * @fence: the fence to initialize
>> @@ -1094,6 +1108,7 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>    * @lock: optional irqsafe spinlock to use for locking this fence
>>    * @context: the execution context this fence is run on
>>    * @seqno: a linear increasing sequence number for this context
>> + * @flags: flags modifying a fence's behavior
>>    *
>>    * Initializes an allocated fence, the caller doesn't have to keep its
>>    * refcount after committing with this fence, but it will need to hold a
>> @@ -1108,12 +1123,18 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>    * introduction of the callback, but the external lock is still around. New
>>    * users MUST NOT use external locks, as they force the issuer to outlive all
>>    * fences that reference the lock.
>> + *
>> + * The @flags you can specify here are either DMA_FENCE_FLAG_SEQNO64_BIT or
>> + * user-specified bits >= DMA_FENCE_FLAG_USER_BITS.
>>    */
>>   void
>>   dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>> -           spinlock_t *lock, u64 context, u64 seqno)
>> +           spinlock_t *lock, u64 context, u64 seqno,
>> +           unsigned long flags)
>>   {
>> -    __dma_fence_init(fence, ops, lock, context, seqno, 0UL);
>> +    WARN_ON(dma_fence_flags_invalid(flags));
>> +
>> +    __dma_fence_init(fence, ops, lock, context, seqno, flags);
>>   }
>>   EXPORT_SYMBOL(dma_fence_init);
>>   diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
>> index e0d9b69bfa76..b9610df3ff19 100644
>> --- a/drivers/dma-buf/st-dma-fence-chain.c
>> +++ b/drivers/dma-buf/st-dma-fence-chain.c
>> @@ -52,7 +52,7 @@ static struct dma_fence *mock_fence(void)
>>           return NULL;
>>         spin_lock_init(&f->lock);
>> -    dma_fence_init(&f->base, &mock_ops, &f->lock, 0, 0);
>> +    dma_fence_init(&f->base, &mock_ops, &f->lock, 0, 0, 0);
>>         return &f->base;
>>   }
>> diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
>> index c5353b36f0e4..dbebc3046d42 100644
>> --- a/drivers/dma-buf/st-dma-fence-unwrap.c
>> +++ b/drivers/dma-buf/st-dma-fence-unwrap.c
>> @@ -36,7 +36,7 @@ static struct dma_fence *__mock_fence(u64 context, u64 seqno)
>>           return NULL;
>>         spin_lock_init(&f->lock);
>> -    dma_fence_init(&f->base, &mock_ops, &f->lock, context, seqno);
>> +    dma_fence_init(&f->base, &mock_ops, &f->lock, context, seqno, 0);
>>         return &f->base;
>>   }
>> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
>> index cb62e606d0a2..b3f88e89cc44 100644
>> --- a/drivers/dma-buf/st-dma-fence.c
>> +++ b/drivers/dma-buf/st-dma-fence.c
>> @@ -31,7 +31,7 @@ static struct dma_fence *mock_fence(void)
>>       if (!f)
>>           return NULL;
>>   -    dma_fence_init(f, &mock_ops, NULL, 0, 0);
>> +    dma_fence_init(f, &mock_ops, NULL, 0, 0, 0);
>>       return f;
>>   }
>>   diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
>> index 0b96136bbd54..c3a920ab3fcf 100644
>> --- a/drivers/dma-buf/st-dma-resv.c
>> +++ b/drivers/dma-buf/st-dma-resv.c
>> @@ -35,7 +35,7 @@ static struct dma_fence *alloc_fence(void)
>>       if (!f)
>>           return NULL;
>>   -    dma_fence_init(f, &fence_ops, &fence_lock, 0, 0);
>> +    dma_fence_init(f, &fence_ops, &fence_lock, 0, 0, 0);
>>       return f;
>>   }
>>   diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
>> index 8df20b0218a9..ce43af7e735e 100644
>> --- a/drivers/dma-buf/sw_sync.c
>> +++ b/drivers/dma-buf/sw_sync.c
>> @@ -258,7 +258,7 @@ static struct sync_pt *sync_pt_create(struct sync_timeline *obj,
>>         sync_timeline_get(obj);
>>       dma_fence_init(&pt->base, &timeline_fence_ops, &obj->lock,
>> -               obj->context, value);
>> +               obj->context, value, 0);
>>       INIT_LIST_HEAD(&pt->link);
>>         spin_lock_irq(&obj->lock);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> index 9b10d015671c..30ccdb3e0b47 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>> @@ -77,7 +77,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
>>       spin_lock_init(&fence->lock);
>>       fence->context_id = context_id;
>>       dma_fence_init(&fence->base, &amdkfd_fence_ops, &fence->lock,
>> -           context, atomic_inc_return(&fence_seq));
>> +           context, atomic_inc_return(&fence_seq), 0);
>>         return fence;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index bff2d38f3571..03e1974f8dda 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -112,7 +112,7 @@ void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>>       seq = ++ring->fence_drv.sync_seq;
>>       dma_fence_init(fence, &amdgpu_fence_ops,
>>                  &ring->fence_drv.lock,
>> -               adev->fence_context + ring->idx, seq);
>> +               adev->fence_context + ring->idx, seq, 0);
>>         amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>>                      seq, flags | AMDGPU_FENCE_FLAG_INT);
>> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
>> index 63ead8ba6756..92641bc0a378 100644
>> --- a/drivers/gpu/drm/drm_crtc.c
>> +++ b/drivers/gpu/drm/drm_crtc.c
>> @@ -190,7 +190,7 @@ struct dma_fence *drm_crtc_create_fence(struct drm_crtc *crtc)
>>           return NULL;
>>         dma_fence_init(fence, &drm_crtc_fence_ops, &crtc->fence_lock,
>> -               crtc->fence_context, ++crtc->fence_seqno);
>> +               crtc->fence_context, ++crtc->fence_seqno, 0);
>>         return fence;
>>   }
>> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
>> index b4a002e6d043..64b06b890f19 100644
>> --- a/drivers/gpu/drm/drm_writeback.c
>> +++ b/drivers/gpu/drm/drm_writeback.c
>> @@ -592,7 +592,7 @@ drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector)
>>         dma_fence_init(fence, &drm_writeback_fence_ops,
>>                  &wb_connector->fence_lock, wb_connector->fence_context,
>> -               ++wb_connector->fence_seqno);
>> +               ++wb_connector->fence_seqno, 0);
>>         return fence;
>>   }
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> index e75dab5e407d..a10e4e4cf372 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> @@ -1199,7 +1199,7 @@ static struct dma_fence *etnaviv_gpu_fence_alloc(struct etnaviv_gpu *gpu)
>>       f->gpu = gpu;
>>         dma_fence_init(&f->base, &etnaviv_fence_ops, &gpu->fence_spinlock,
>> -               gpu->fence_context, ++gpu->next_fence);
>> +               gpu->fence_context, ++gpu->next_fence, 0);
>>         return &f->base;
>>   }
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
>> index 56489cc127d6..ffaa70191f27 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
>> @@ -437,7 +437,7 @@ i915_ttm_memcpy_work_arm(struct i915_ttm_memcpy_work *work,
>>       int ret;
>>         spin_lock_init(&work->lock);
>> -    dma_fence_init(&work->fence, &dma_fence_memcpy_ops, &work->lock, 0, 0);
>> +    dma_fence_init(&work->fence, &dma_fence_memcpy_ops, &work->lock, 0, 0, 0);
>>       dma_fence_get(&work->fence);
>>       ret = dma_fence_add_callback(dep, &work->cb, __memcpy_cb);
>>       if (ret) {
>> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
>> index f66f8efc7062..0f4fc9cc0033 100644
>> --- a/drivers/gpu/drm/i915/i915_request.c
>> +++ b/drivers/gpu/drm/i915/i915_request.c
>> @@ -953,7 +953,7 @@ __i915_request_create(struct intel_context *ce, gfp_t gfp)
>>           goto err_free;
>>         dma_fence_init(&rq->fence, &i915_fence_ops, &rq->lock,
>> -               tl->fence_context, seqno);
>> +               tl->fence_context, seqno, 0);
>>         RCU_INIT_POINTER(rq->timeline, tl);
>>       rq->hwsp_seqno = tl->hwsp_seqno;
>> diff --git a/drivers/gpu/drm/i915/i915_sw_fence_work.c b/drivers/gpu/drm/i915/i915_sw_fence_work.c
>> index 366418108f78..4cd44dd26e35 100644
>> --- a/drivers/gpu/drm/i915/i915_sw_fence_work.c
>> +++ b/drivers/gpu/drm/i915/i915_sw_fence_work.c
>> @@ -85,7 +85,7 @@ void dma_fence_work_init(struct dma_fence_work *f,
>>   {
>>       f->ops = ops;
>>       spin_lock_init(&f->lock);
>> -    dma_fence_init(&f->dma, &fence_ops, &f->lock, 0, 0);
>> +    dma_fence_init(&f->dma, &fence_ops, &f->lock, 0, 0, 0);
>>       i915_sw_fence_init(&f->chain, fence_notify);
>>       INIT_WORK(&f->work, fence_work);
>>   }
>> diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
>> index a8f2112ce81f..19596410e32f 100644
>> --- a/drivers/gpu/drm/i915/i915_vma_resource.c
>> +++ b/drivers/gpu/drm/i915/i915_vma_resource.c
>> @@ -263,7 +263,7 @@ void __i915_vma_resource_init(struct i915_vma_resource *vma_res)
>>   {
>>       spin_lock_init(&vma_res->lock);
>>       dma_fence_init(&vma_res->unbind_fence, &unbind_fence_ops,
>> -               &vma_res->lock, 0, 0);
>> +               &vma_res->lock, 0, 0, 0);
>>       refcount_set(&vma_res->hold_count, 1);
>>       i915_sw_fence_init(&vma_res->chain, i915_vma_resource_fence_notify);
>>   }
>> diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
>> index ecb2d718f6a6..d8d4f7057031 100644
>> --- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
>> +++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
>> @@ -641,7 +641,7 @@ static struct dma_fence *alloc_dma_fence(void)
>>         dma = kmalloc_obj(*dma);
>>       if (dma)
>> -        dma_fence_init(dma, &mock_fence_ops, &mock_fence_lock, 0, 0);
>> +        dma_fence_init(dma, &mock_fence_ops, &mock_fence_lock, 0, 0, 0);
>>         return dma;
>>   }
>> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
>> index e408df74853d..7043b491fe54 100644
>> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
>> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
>> @@ -645,7 +645,7 @@ pvr_kccb_reserve_slot(struct pvr_device *pvr_dev, struct dma_fence *f)
>>           dma_fence_init(&fence->base, &pvr_kccb_fence_ops,
>>                      &pvr_dev->kccb.fence_ctx.lock,
>>                      pvr_dev->kccb.fence_ctx.id,
>> -                   atomic_inc_return(&pvr_dev->kccb.fence_ctx.seqno));
>> +                   atomic_inc_return(&pvr_dev->kccb.fence_ctx.seqno), 0);
>>           out_fence = dma_fence_get(&fence->base);
>>           list_add_tail(&fence->node, &pvr_dev->kccb.waiters);
>>       } else {
>> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
>> index 24a8645aa913..34b826381aa2 100644
>> --- a/drivers/gpu/drm/imagination/pvr_queue.c
>> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
>> @@ -305,7 +305,7 @@ pvr_queue_fence_init(struct dma_fence *f,
>>       INIT_WORK(&fence->release_work, pvr_queue_fence_release_work);
>>       dma_fence_init(&fence->base, fence_ops,
>>                  &fence_ctx->lock, fence_ctx->id,
>> -               atomic_inc_return(&fence_ctx->seqno));
>> +               atomic_inc_return(&fence_ctx->seqno), 0);
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
>> index 9a1e6b9ecbe5..fee595b9629a 100644
>> --- a/drivers/gpu/drm/lima/lima_sched.c
>> +++ b/drivers/gpu/drm/lima/lima_sched.c
>> @@ -97,7 +97,7 @@ static struct lima_fence *lima_fence_create(struct lima_sched_pipe *pipe)
>>         fence->pipe = pipe;
>>       dma_fence_init(&fence->base, &lima_fence_ops, &pipe->fence_lock,
>> -               pipe->fence_context, ++pipe->fence_seqno);
>> +               pipe->fence_context, ++pipe->fence_seqno, 0);
>>         return fence;
>>   }
>> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
>> index 3dca8e09c192..1ec59919c32e 100644
>> --- a/drivers/gpu/drm/msm/msm_fence.c
>> +++ b/drivers/gpu/drm/msm/msm_fence.c
>> @@ -197,5 +197,5 @@ msm_fence_init(struct dma_fence *fence, struct msm_fence_context *fctx)
>>       WARN_ON(kref_read(&fence->refcount));
>>         dma_fence_init(&f->base, &msm_fence_ops, &fctx->spinlock,
>> -               fctx->context, ++fctx->last_fence);
>> +               fctx->context, ++fctx->last_fence, 0);
>>   }
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
>> index 11e95c37ce50..97e20954c71b 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
>> @@ -216,10 +216,10 @@ nouveau_fence_emit(struct nouveau_fence *fence)
>>         if (priv->uevent)
>>           dma_fence_init(&fence->base, &nouveau_fence_ops_uevent,
>> -                   &fctx->lock, fctx->context, ++fctx->sequence);
>> +                   &fctx->lock, fctx->context, ++fctx->sequence, 0);
>>       else
>>           dma_fence_init(&fence->base, &nouveau_fence_ops_legacy,
>> -                   &fctx->lock, fctx->context, ++fctx->sequence);
>> +                   &fctx->lock, fctx->context, ++fctx->sequence, 0);
>>       kref_get(&fctx->fence_ref);
>>         ret = fctx->emit(fence);
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
>> index 4ddf4b722ddf..de242d275978 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>> @@ -105,7 +105,7 @@ static struct dma_fence *panfrost_fence_create(struct panfrost_device *pfdev, in
>>       fence->queue = js_num;
>>       fence->seqno = ++js->queue[js_num].emit_seqno;
>>       dma_fence_init(&fence->base, &panfrost_fence_ops, &js->job_lock,
>> -               js->queue[js_num].fence_context, fence->seqno);
>> +               js->queue[js_num].fence_context, fence->seqno, 0);
>>         return &fence->base;
>>   }
>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
>> index a343c5180e01..c46f69ade7a0 100644
>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
>> @@ -3322,7 +3322,7 @@ queue_run_job(struct drm_sched_job *sched_job)
>>                  &panthor_queue_fence_ops,
>>                  &queue->fence_ctx.lock,
>>                  queue->fence_ctx.id,
>> -               atomic64_inc_return(&queue->fence_ctx.seqno));
>> +               atomic64_inc_return(&queue->fence_ctx.seqno), 0);
>>         job->profiling.slot = queue->profiling.seqno++;
>>       if (queue->profiling.seqno == queue->profiling.slot_count)
>> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
>> index 06979d0e8a9f..2608d82f7370 100644
>> --- a/drivers/gpu/drm/qxl/qxl_release.c
>> +++ b/drivers/gpu/drm/qxl/qxl_release.c
>> @@ -430,7 +430,7 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
>>        * set the highest bits. This will break if we really allow exporting of dma-bufs.
>>        */
>>       dma_fence_init(&release->base, &qxl_fence_ops, &qdev->release_lock,
>> -               release->id | 0xf0000000, release->base.seqno);
>> +               release->id | 0xf0000000, release->base.seqno, 0);
>>       trace_dma_fence_emit(&release->base);
>>         list_for_each_entry(entry, &release->bos, list) {
>> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
>> index 8e9402b8811b..1360b5215f5e 100644
>> --- a/drivers/gpu/drm/radeon/radeon_fence.c
>> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
>> @@ -148,7 +148,7 @@ int radeon_fence_emit(struct radeon_device *rdev,
>>       dma_fence_init(&(*fence)->base, &radeon_fence_ops,
>>                  &rdev->fence_queue.lock,
>>                  rdev->fence_context + ring,
>> -               seq);
>> +               seq, 0);
>>       radeon_fence_ring_emit(rdev, ring, *fence);
>>       trace_radeon_fence_emit(rdev_to_drm(rdev), ring, (*fence)->seq);
>>       radeon_fence_schedule_check(rdev, ring);
>> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
>> index b7a4cb921234..94ba0cf4fe02 100644
>> --- a/drivers/gpu/drm/scheduler/sched_fence.c
>> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
>> @@ -229,9 +229,9 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
>>       fence->sched = entity->rq->sched;
>>       seq = atomic_inc_return(&entity->fence_seq);
>>       dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
>> -               &fence->lock, entity->fence_context, seq);
>> +               &fence->lock, entity->fence_context, seq, 0);
>>       dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
>> -               &fence->lock, entity->fence_context + 1, seq);
>> +               &fence->lock, entity->fence_context + 1, seq, 0);
>>   }
>>     module_init(drm_sched_fence_slab_init);
>> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
>> index 2dfa3efef210..169792a4b329 100644
>> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
>> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
>> @@ -173,7 +173,7 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
>>                  &drm_mock_sched_hw_fence_ops,
>>                  &sched->lock,
>>                  sched->hw_timeline.context,
>> -               atomic_inc_return(&sched->hw_timeline.next_seqno));
>> +               atomic_inc_return(&sched->hw_timeline.next_seqno), 0);
>>         dma_fence_get(&job->hw_fence); /* Reference for the job_list */
>>   diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
>> index f3103307b5df..633cc7458505 100644
>> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
>> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
>> @@ -450,7 +450,7 @@ static void ttm_bo_fini_shared_resv(struct kunit *test)
>>       KUNIT_ASSERT_NOT_NULL(test, fence);
>>         spin_lock_init(&fence_lock);
>> -    dma_fence_init(fence, &mock_fence_ops, &fence_lock, 0, 0);
>> +    dma_fence_init(fence, &mock_fence_ops, &fence_lock, 0, 0, 0);
>>         dma_resv_lock(external_resv, NULL);
>>       dma_resv_reserve_fences(external_resv, 1);
>> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
>> index 56ad8ef32584..e22a1335f166 100644
>> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
>> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
>> @@ -57,7 +57,7 @@ static struct dma_fence *alloc_mock_fence(struct kunit *test)
>>       fence = kunit_kzalloc(test, sizeof(*fence), GFP_KERNEL);
>>       KUNIT_ASSERT_NOT_NULL(test, fence);
>>   -    dma_fence_init(fence, &fence_ops, &fence_lock, 0, 0);
>> +    dma_fence_init(fence, &fence_ops, &fence_lock, 0, 0, 0);
>>         return fence;
>>   }
>> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
>> index c500136d0455..1fdba5a21580 100644
>> --- a/drivers/gpu/drm/v3d/v3d_fence.c
>> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
>> @@ -16,7 +16,7 @@ struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q)
>>       fence->queue = q;
>>       fence->seqno = ++queue->emit_seqno;
>>       dma_fence_init(&fence->base, &v3d_fence_ops, &queue->queue_lock,
>> -               queue->fence_context, fence->seqno);
>> +               queue->fence_context, fence->seqno, 0);
>>         return &fence->base;
>>   }
>> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
>> index ff611c618d6b..420988d516c1 100644
>> --- a/drivers/gpu/drm/vc4/vc4_gem.c
>> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
>> @@ -648,7 +648,7 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
>>       exec->seqno = seqno;
>>         dma_fence_init(&fence->base, &vc4_fence_ops, &vc4->job_lock,
>> -               vc4->dma_fence_context, exec->seqno);
>> +               vc4->dma_fence_context, exec->seqno, 0);
>>       fence->seqno = exec->seqno;
>>       exec->fence = &fence->base;
>>   diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
>> index 0e53ba7db629..18700e5f9167 100644
>> --- a/drivers/gpu/drm/vgem/vgem_fence.c
>> +++ b/drivers/gpu/drm/vgem/vgem_fence.c
>> @@ -77,7 +77,7 @@ static struct dma_fence *vgem_fence_create(struct vgem_file *vfile,
>>         spin_lock_init(&fence->lock);
>>       dma_fence_init(&fence->base, &vgem_fence_ops, &fence->lock,
>> -               dma_fence_context_alloc(1), 1);
>> +               dma_fence_context_alloc(1), 1, 0);
>>         timer_setup(&fence->timer, vgem_fence_timeout, TIMER_IRQSAFE);
>>   diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
>> index c3e66ef2133a..8e469391d2e4 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_fence.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
>> @@ -76,7 +76,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev,
>>        */
>>         dma_fence_init(&fence->f, &virtio_gpu_fence_ops, &drv->lock,
>> -               fence_context, 0);
>> +               fence_context, 0, 0);
>>         return fence;
>>   }
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
>> index 384c6736cf6b..15f355dc6881 100644
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
>> @@ -163,7 +163,7 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
>>       int ret = 0;
>>         dma_fence_init(&fence->base, &vmw_fence_ops, &fman->lock,
>> -               fman->ctx, seqno);
>> +               fman->ctx, seqno, 0);
>>       fence->destroy = destroy;
>>         spin_lock(&fman->lock);
>> diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
>> index 14720623ad00..30bfc42972e0 100644
>> --- a/drivers/gpu/drm/xe/xe_hw_fence.c
>> +++ b/drivers/gpu/drm/xe/xe_hw_fence.c
>> @@ -243,7 +243,7 @@ void xe_hw_fence_init(struct dma_fence *fence, struct xe_hw_fence_ctx *ctx,
>>       INIT_LIST_HEAD(&hw_fence->irq_link);
>>         dma_fence_init(fence, &xe_hw_fence_ops, &ctx->irq->lock,
>> -               ctx->dma_fence_ctx, ctx->next_seqno++);
>> +               ctx->dma_fence_ctx, ctx->next_seqno++, 0);
>>         trace_xe_hw_fence_create(hw_fence);
>>   }
>> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
>> index c9320feeafba..912840eeec50 100644
>> --- a/drivers/gpu/drm/xe/xe_oa.c
>> +++ b/drivers/gpu/drm/xe/xe_oa.c
>> @@ -1053,7 +1053,7 @@ static int xe_oa_emit_oa_config(struct xe_oa_stream *stream, struct xe_oa_config
>>         /* Point of no return: initialize and set fence to signal */
>>       spin_lock_init(&ofence->lock);
>> -    dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0);
>> +    dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0, 0);
>>         for (i = 0; i < stream->num_syncs; i++) {
>>           if (stream->syncs[i].flags & DRM_XE_SYNC_FLAG_SIGNAL)
>> diff --git a/drivers/gpu/drm/xe/xe_preempt_fence.c b/drivers/gpu/drm/xe/xe_preempt_fence.c
>> index 4aa570fe745d..343f1ba1e1cd 100644
>> --- a/drivers/gpu/drm/xe/xe_preempt_fence.c
>> +++ b/drivers/gpu/drm/xe/xe_preempt_fence.c
>> @@ -154,7 +154,7 @@ xe_preempt_fence_arm(struct xe_preempt_fence *pfence, struct xe_exec_queue *q,
>>       pfence->q = xe_exec_queue_get(q);
>>       spin_lock_init(&pfence->lock);
>>       dma_fence_init(&pfence->base, &preempt_fence_ops,
>> -              &pfence->lock, context, seqno);
>> +              &pfence->lock, context, seqno, 0);
>>         return &pfence->base;
>>   }
>> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
>> index c9cc5842d65b..1fd39434dc0e 100644
>> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
>> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
>> @@ -544,7 +544,7 @@ void xe_tlb_inval_fence_init(struct xe_tlb_inval *tlb_inval,
>>         spin_lock_irq(&tlb_inval->lock);
>>       dma_fence_init(&fence->base, &inval_fence_ops, &tlb_inval->lock,
>> -               dma_fence_context_alloc(1), 1);
>> +               dma_fence_context_alloc(1), 1, 0);
>>       spin_unlock_irq(&tlb_inval->lock);
>>       INIT_LIST_HEAD(&fence->link);
>>       if (stack)
>> diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
>> index 1acf579c562b..7e074e72a055 100644
>> --- a/drivers/gpu/host1x/fence.c
>> +++ b/drivers/gpu/host1x/fence.c
>> @@ -136,7 +136,7 @@ struct dma_fence *host1x_fence_create(struct host1x_syncpt *sp, u32 threshold,
>>       fence->timeout = timeout;
>>         dma_fence_init(&fence->base, &host1x_syncpt_fence_ops, &sp->fences.lock,
>> -               dma_fence_context_alloc(1), 0);
>> +               dma_fence_context_alloc(1), 0, 0);
>>         INIT_DELAYED_WORK(&fence->timeout_work, do_fence_timeout);
>>   diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index 4294101810fd..f7d6b294b63c 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -1904,7 +1904,7 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
>>        * the dma_fence.
>>        */
>>       dma_fence_init(&fence->base, &iio_buffer_dma_fence_ops,
>> -               &fence->lock, priv->context, seqno);
>> +               &fence->lock, priv->context, seqno, 0);
>>         ret = iio_dma_resv_lock(dmabuf, nonblock);
>>       if (ret)
>> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
>> index c64a268e98a4..eb367a1666c2 100644
>> --- a/drivers/usb/gadget/function/f_fs.c
>> +++ b/drivers/usb/gadget/function/f_fs.c
>> @@ -1733,7 +1733,7 @@ static int ffs_dmabuf_transfer(struct file *file,
>>       seqno = atomic_add_return(1, &epfile->seqno);
>>         dma_fence_init(&fence->base, &ffs_dmabuf_fence_ops,
>> -               &priv->lock, priv->context, seqno);
>> +               &priv->lock, priv->context, seqno, 0);
>>         resv_dir = epfile->in ? DMA_RESV_USAGE_READ : DMA_RESV_USAGE_WRITE;
>>   diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
>> index dd07d128adc3..6f5c245d89ec 100644
>> --- a/include/linux/dma-fence.h
>> +++ b/include/linux/dma-fence.h
>> @@ -103,6 +103,12 @@ struct dma_fence {
>>       int error;
>>   };
>>   +/** enum dma_fence_flag_bits - internal dma_fence flags
>> + *
>> + * These flags are all only for internal usage, except for
>> + * @DMA_FENCE_FLAG_SEQNO64_BIT and the user bits beginning at
>> + * @DMA_FENCE_FLAG_USER_BITS.
>> + */
>>   enum dma_fence_flag_bits {
>>       DMA_FENCE_FLAG_INITIALIZED_BIT,
>>       DMA_FENCE_FLAG_INLINE_LOCK_BIT,
>> @@ -110,6 +116,7 @@ enum dma_fence_flag_bits {
>>       DMA_FENCE_FLAG_SIGNALED_BIT,
>>       DMA_FENCE_FLAG_TIMESTAMP_BIT,
>>       DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
>> +
>>       DMA_FENCE_FLAG_USER_BITS, /* must always be last member */
>>   };
>>   @@ -279,11 +286,10 @@ struct dma_fence_ops {
>>   };
>>     void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>> -            spinlock_t *lock, u64 context, u64 seqno);
>> -
>> +            spinlock_t *lock, u64 context, u64 seqno,
>> +            unsigned long flags);
>>   void dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>                 spinlock_t *lock, u64 context, u64 seqno);
>> -
>>   void dma_fence_release(struct kref *kref);
>>   void dma_fence_free(struct dma_fence *fence);
>>   void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq);
>> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
>> index 18a43e1bb442..ee8fa4ecd6c1 100644
>> --- a/rust/kernel/dma_buf/dma_fence.rs
>> +++ b/rust/kernel/dma_buf/dma_fence.rs
>> @@ -736,7 +736,7 @@ pub fn new_fence(self) -> DriverFence<'a, T> {
>>           // SAFETY: `fence_ptr` has been created directly above. It will live
>>           // at least as long as `Self`. The same applies to `&Self::OPS`.
>>           unsafe {
>> -            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno)
>> +            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno, 0)
>>           };
>>             self.data.fctx.nr_of_unsignaled_fences.fetch_add(1, Relaxed);
> 

