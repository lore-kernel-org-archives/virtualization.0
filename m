Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793281459;
	b=d4StdG1NhiVTGgVTyshtA8967ujj5ff0cfOvcVENS18+lYMlt9zjjlmAWx54Zj3F3V2p
	 vhqDkkpNZ1RcatHd+84vUR2iewZJwRRADspvj5rK06WwlzMlACuHG5KXhuE5B/ipOqk0E
	 bQq/64uZMgjQkReL7DkgifurX14naEUdhwwU4OcNfdL/ZLwjriZx6ZVhBwOl+8JEM2SFh
	 5GY5pmesJ7nsSUIa2wKSdjgAF7zx+VQAhxAkz5kMJqhqyDVRA2ydJMUqPwJ3KBGmOkFJV
	 dMdvq36cLotG2JRa+5o7b6NXUzDkYo8sJnHDRrrXluZ4Mch9TtnHjyBaqMqSCBcWg+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281459;
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
	bh=1u4PYj+cvLRBRXYmD3Z/wuQ5LDXlcQvlgFzTpcHPDiw=;
	b=KkVqcZPNGFeyPZ/f2zzo/aS/tAjHjGT6WdnKgRmylXaTQKWZP0olOsGIewSdSz2pU1G3
	 IXk3KR2pW+Q5Ytqsr5TdbyHcjLCmMY7r/uy4Lmm3PWeg4ACgnXsuVdeJBcpWnzM2VrXtc
	 G0zzdxnMxLY//rB4j1IX534yN1EtDOXKkAa1/gtVNYJBzU69AjP/0tzFE9QQT4vtePYre
	 88uIYp3JwHsl5pyTWwvItw1GyB7HQBR+1vY7iR19oakNFAs6l9RXFjxbjQW1hxCLjJYd/
	 rrENCdidCmfz6zDIYkQBlzZMCOEgXBfuy36tfEB1q+QVePWAv4kbT+SdvMhLpzZma/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kNKHDjEz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.34
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B2E606A326
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 13:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B2E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kNKHDjEz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdIiAqXAI+zWHrO16CJ5P0zhNYulxwjQYjPPM4Ui//BJ1bKvTnb72hqvnX+M2jOb+roky/Mc03bYLaohOOnKw0jo2BKS1mvPcILKupkX6qF6X9LbeFPfJZZ0mQ8PZuva7YvKhKkfUn9GTI3gAbXlkZsoPn6GJ2anQrbqiDJjK76xdfh1pGGPJztsqEmP58/MLvBJPd9NG4uV4xfnj1EMrzojTz83byf2bRMpWeUcXC4IcoVl05OP34uR3I7PhcL4lB1G3cvuV34h9YuzjGJYPArbepTzS3ADUKo/CeSiybHtEz/lOF3zRE+cT2Ztgs4tXJ0/gjaDcJd8IdC2w2bOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u4PYj+cvLRBRXYmD3Z/wuQ5LDXlcQvlgFzTpcHPDiw=;
 b=wuS9l1D4AnMuSuUcy7Albr01USOAb+dWlWdFnLvG5S3HrEJHdWh7CVOTegEyVRX2Cgu0vMPaRCHrPaVNpU8qmYa62oSZNZcFHACOh8idSjJNySBG9f4Ou8rzOXTWUx2oiO2zw6euXoc6sc4W2sRg1AAt4YijE1QWqR7OHympdSkFtujfFDRSqzGqCshkAclmIGFwFseeuY8tojvTxuUy0WeksFXqa2IhU3SMJkktc+1ua7QaiNkBoaQc3csa/XlAoPlfxWGmZ7BVsTK74rhZPQPXnwWs5wgbBLHGfM/sy7tPckhEndA9kZIty2CJP4FPPj43D+s8BDeCJso+5lcRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u4PYj+cvLRBRXYmD3Z/wuQ5LDXlcQvlgFzTpcHPDiw=;
 b=kNKHDjEzP3f325erIp5at/HZX5EzmIqaS3e8gWwC6h8mSUTFwtnxLMOft7AwC5ddFAC/MFnC47pvDYnfCpj4Lq9Bq6Qu1yJgozAe2UHtQMNC2xDSWWq5oXVw0ykLFlIWFgDHBWGZ78k/oX/qcqRc42fhrT6ju1IhKyBzzMicb4o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 13:44:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 13:44:11 +0000
Message-ID: <2db0f1b4-6628-465e-928e-d779b89f59dc@amd.com>
Date: Thu, 29 Oct 2026 14:43:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] dma-buf: Phase out is_signaled() race
To: phasta@kernel.org, Lucas Stach <l.stach@pengutronix.de>,
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>, Qiang Yu <yuq825@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Matthew Brost <matthew.brost@intel.com>,
 Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Melissa Wen <mwen@igalia.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sunil Khatri <sunil.khatri@amd.com>, Kees Cook <kees@kernel.org>,
 Jesse Zhang <jesse.zhang@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, Prike Liang <Prike.Liang@amd.com>,
 David Rosca <david.rosca@amd.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Shixiong Ou <oushixiong@kylinos.cn>,
 =?UTF-8?Q?Jouni_H=C3=B6gander?= <jouni.hogander@intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Neill Kapron <nkapron@google.com>,
 Michael Bommarito <michael.bommarito@gmail.com>, Sam Day <me@samcday.com>,
 Gabriel Prostitis <prostitisgabriel@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20261029095542.1526750-3-phasta@kernel.org>
 <abca3f0039b07999e29558690c27fef23292bea3.camel@pengutronix.de>
 <3565783722927fa48a30f48b063ef99bcd703eab.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3565783722927fa48a30f48b063ef99bcd703eab.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::30) To PH7PR12MB5685.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f175a8-d876-4067-d914-08df35c2b66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|921020|11063799006|4143699003|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lk286bQ5Rub5REwqftKLPts5rFVF0LYGEPbYRc0zyAUGxDspTrurJAog+OPthqT5Vht+kHe3ebOvp6Z643HNp4Dt37Z0Y1lHrfdGD0yH/ZYByx+UiURNiEeeuE8LSP6Erz4wrUfmP0SRL42fI/kKCWvgBHKy/7ml75lWCXUaDIA6zdv/2yVcwKA1kar0ikrLmH45bY+hNSCFh+d+xrk2LnCXG5kNh+eenz9uflwWXGfxF25I0GxBvxMvGQS2r8SLJSkwV6A2R3Vx2mTuVGL+PSPkHHuFHjlFt07t8gqeDy2AZslHHlTv9aRogsBhkep06jRL9NnElBrcIzD41LtOPL+t3PclZVVBSKe3X5WZQw0yagOX14G23m+IOuR5J7yk/Bu132jPhzColiDqRJ7dEpRfkioGKWAV45bR8T4v4kBPbXus63hLRkCkpzmI7rEkZWdokPxDBTmInl8bbp5+04KzU8Xae+5i2iAUOvJzNxgQhSPjFiFo4qIQ6I6yZxJouiJQZTuQNy7InhPg9bvJ0NxRuhWZ1DU4E2ES3osW7WkqHOXlSFrN6cS3JobXeOGJeqpVOHXYZQDyD7wYWrIhCz4kLEFDgz50w36REz/Expo3lZbq2Bf22NuOjk0DaLb/AeIAQOSCXem7zD4241MMacnIzoHk/k8HXuwC35YPT4cAbYNSQmJqxPTXsq/XDAl4DHmHWkL0j5CAqO3LayEuZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(921020)(11063799006)(4143699003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE5rYmJWYkxBcGFYd2oxZWxRai9VNHI2dldqOUN0UnppZ1JuTGs5aFVNVkFH?=
 =?utf-8?B?Y0NuOFhhQU90NGh0M1BLc3U0eWlpa3hLT3RLK0pGU1pYMloxSDl2MUZuV3c2?=
 =?utf-8?B?cVp1eVUwbXZ1SjVoNlNpSGloZW4yOVNaSUpnaUxraEg0d3lsOFVRTEFJRVdD?=
 =?utf-8?B?YlZ6bU1FUGthZEZkclVGOWNyeThoWGkrM1M3S2FDRmxFc3FlSUNlbnBsSzF1?=
 =?utf-8?B?aUxXYXZxL0dTUVJZV0RIaHBaTEMrSWtKWEZoMXpRUTllVExzUFFSTUtVU1p1?=
 =?utf-8?B?U3pwM3dCWWtxZDVYRkJzenRRZlZiRFNFRWtrY1BpTHFtUDc1Q1B6UDIrb0tB?=
 =?utf-8?B?UlNmQ3ppcTMxZXFidFcyNzE4Q1ZGNHZwWFhXWWwyREFQU0JpK2NJU3I2TFVO?=
 =?utf-8?B?Ulp6NGFYeHNsNmUyOXJNSUxMeENRTHZHaVpZQ3Y0ZWdTanM3N0tOVjgxdHVw?=
 =?utf-8?B?VWZ5MnptK0ZpN3NLbGUrZmxtWVlmeXpISzV1OURxeTNvWGhZb2l1ckFnZU5J?=
 =?utf-8?B?R2o1Nk1wcklrNXBlNEdEdFdYRmx3U0hOU3dMRVlsMmh1RC95enQ4QytmYm85?=
 =?utf-8?B?alJCWlNoQ1NIbDU4TGZRbGs1Sy9MYlNJV2s0WGRvSGUvMlB3RjdMWm5YZkNH?=
 =?utf-8?B?bWRMZk1tcTRZWHg1eVNTWnl2OWhYcTVsRTN5Tkw0dHR5SG5nT0xRTmdsMzk3?=
 =?utf-8?B?UFAzVmhvREdzb21sK0ZsVU9JUCtEZ21UVm1NelE3QmZqMlpkcUZVR3ZzV2p0?=
 =?utf-8?B?eFR5K3gwT1ZialVZaVJjS3IvUjhjWGtXTm12aksxR1VhMkE4MG1XRng5d2FH?=
 =?utf-8?B?ckFZSFNTbktvNU9VRVlMV3E0M09GTG4rdFZWMFpTWDdITklmNzQwVDErLzlu?=
 =?utf-8?B?Um1GVWwrQklURy9UbnMwV0czQXNtTjZ3ZytiVnA2YmlsU1dqb3lXdk9QbWRq?=
 =?utf-8?B?YkJZVHZrR2NmMDlhUy8ybFZ6dDZSQkRud0pwM1p1RDNWUzZuak44ZTNmbEFD?=
 =?utf-8?B?WitwWXNCQzdxUW1tSm9FVnBJMm15Y1MyRTBkOEl3ejk5QmFyOHV5cTIzK3dV?=
 =?utf-8?B?RW1qcnVjNDBZWklCcDh0eDl6R3daMkZZWW0wWldMMDlxU1ljajlmU0RQRzZO?=
 =?utf-8?B?aHFuSWZKcHJCcmhKUXk2RWhDdDhkd0FPZTVtdWFhZ2F0d2tUYzhvWlZJZDBR?=
 =?utf-8?B?dG5UcUMrd25Fek1Da0pHMEt0eFJkb0RMOGxWSE02SXJmWjVyTFEvdUhacFkz?=
 =?utf-8?B?clI3eXJrUXU3eENrVHl2djRXRWtLOVhpUVVjVXNGbHVCTHVTeG0yOE1EM3dT?=
 =?utf-8?B?K2UzM1FVSkxkaVdvODFhQTQzUld2Z0dKYTZvSEJHZE5KclNmZ1pyK2hobE93?=
 =?utf-8?B?di9xRjRkT2pDS2lsaU5LN2NJTlhqdXh4a2xEaXdyMnJtQmNZMzB1MjBNdTNm?=
 =?utf-8?B?c21qWDl3S05mckdBWjRFejdmVkpmeW1pbWZ5ZENWa01xQUlQNDE3VmRtbVRE?=
 =?utf-8?B?Zm1oS2FTUmFrWDdHN3ozc25JWkVHMnZXZGZWNTVBYmxaTzhYcDFIRkdkeWNa?=
 =?utf-8?B?MThiQi9QK1h0aW02UW05MnZpOWhkV2U3Y211djNsN01WNkVrVmpQZXA3eUVu?=
 =?utf-8?B?NkQ1elN1NUJHVUxQUzJWS0had2YzR3NOeXNvRXdHa1lxNnFCOFJNcDk0ZWs5?=
 =?utf-8?B?NHJCK0xPY09HTmQ0VXVOemJVaENMeFhtS1RtYmVjQXB5NUgyQjgzS0c0K2Z3?=
 =?utf-8?B?eWNmaEJpMFYwOHB5bW11Y09TdFB3YjR2R0R4cEpqMlROak1nVkdUdXJRNnlQ?=
 =?utf-8?B?RHAzMWVib3hUM25nYWs1MHp5YXpGTUIzTEZqV2pVZmNGbWt3WW5UcTBVU3hk?=
 =?utf-8?B?WWpQNGx3aFN4S0lZaUphazc5M2NYdE9tVWhSZjdMMlB1TmUzcTlkNFByK2NW?=
 =?utf-8?B?cUdCcm9acUxVOUZhcjRWNnRUS1JDeTB3Z085OGxHelEyMEk2NGM4QTRvTU9q?=
 =?utf-8?B?WmhQUWovQzJ3R2UwNVBWamx2aVNxbWtxTGFoRHRlaWgyeEJna1A4SmUyazBr?=
 =?utf-8?B?aVNCTFF3WTR2UDdYdUkyZlprcytYL3NteXVkQ29LVDczMUtpRmtzb2Rhdkdt?=
 =?utf-8?B?cGpoZ1I0azYvSXBPcUpjZXY1cTAxNVo0My9hVll4d1ZsZGJNd3A2TlRlMnV6?=
 =?utf-8?B?STNlUGd4Zi82YnIxRHE3YU0xRVZIVUgydG1ZOURBYllzMVlmSkhwQ1F4VVFB?=
 =?utf-8?B?MHVWTjlCNC9VRzZxa2JXZnEvZk96eVdOQzRWZ21pOGhwZnB1clAxbDNjTWZF?=
 =?utf-8?Q?Wy8Zx8IkX+2cI+Z0ek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f175a8-d876-4067-d914-08df35c2b66d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:44:11.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LipB9l1rBDBHZrY4fr2AuoSMtG65tQoTqpUAuJYZCa5LAdiRjkpqEsPhln5Da+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716

Hi guys,

On 10/29/26 11:28, Philipp Stanner wrote:
> On Thu, 2026-10-29 at 11:23 +0100, Lucas Stach wrote:
>> Hi Philipp, hi Christian,
> 
> Jo Lucas
> 
>>
>> Am Donnerstag, dem 29.10.2026 um 10:55 +0100 schrieb Philipp Stanner:
> 
> […]
> 
>> I think we would all be interested in the actual use-case that's
>> sensitive to this kind of latency.

Well everything which wants things to start as early as possible when the fence is signaled and not wait for the callbacks to run is affected.

If I'm not completely mistaken when we start to wait for the callbacks to finish in is_signaled we break more things than we fix because some people relied on timing here.

> Me too.
> 
> Let me use this opportunity to stress that in the future, in DRM,
> whenever we have [to accept] a racy "optimization", both commit
> messages and code comments must document why it exists and who
> requested it with what proof.

That is a really good idea I think.

> 
> Would save us lots of time when those things are discussed >5 years
> later.
> 
>>
>> However, I wonder if this is even an issue anymore with the lock
>> inlined into the fence structure.
> 
> Almost no one uses inline-lock so far. So unfortunately, we might
> regress old drivers, maybe.

Considering that I still get bug reports even for the performance of radeon when we change things I fear that this is true.

Regards,
Christian.

> 
> But sounds as if you're in favor of phasing the locklessness out :)
> 
> 
> P.

