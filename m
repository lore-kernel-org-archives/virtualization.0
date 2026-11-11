Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794405327;
	b=uiL3iPxdj2lbMKDLvu+Iakd2MMtDcekF9/nNkH3bTpt4TTjHnlQLyjAbT9h+Z3i3ORrA
	 0+e367LkB+U2PurxY1/j721Y70PzRmwE+E4WQm9ceBVtnYbTv7F2uM5TKr1lEwXAvC2kU
	 NNl2Db2uLazOX4/t9/wBy+J3OSCHzBBeKA9IFjBbESxSQ4SDbXWusKrYaiwnS4ljc1c/A
	 g7GWGUFGngKEgTdZr2URKEz63h26jks5j5kaNWk7DqwjiL6uW40kRg017aZUX9304zgrX
	 VPcbWRWLeYPX54e7a4cxzdpyP+d9jUD658HsVF8YnOXKV/kP3r+Sm13bTVWMwLScISQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405327;
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
	bh=OADNlzxOLEmHJL3G/edAJ3fJuoIxIe3Gd9gp9UaQebM=;
	b=0ZDLtJpw8MNSEA9QLCmSMTM/fNZ2q7mtChWtrmvE0NEkbdGgdVrQMoObGkM/H0qIS/YK
	 GuSOh2lwviuODJSk217/UER2pFtoShWORhFJAhAlYo8D/5B6LW8BbCGDUQTuMoFwsQJ8S
	 xBEiNAJLofMhsDE75fLgHOe20ZjQzomexFj1MKX4h0CLbOMnPXGgBAIno4J1YqXkqN50Q
	 24WnmCneDAGeGy3fulzqer0Ue/8FrVCDM8YcSVC5PFJNZorXRHnc9Z+CT5O1+X1wtvEUP
	 Lg5RXC+VVSSjdf4d19319IyPkTNieWfOmdfU1XVLJzl5ZM882fMsYY8JzWjY/JAMwDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AppZz8UZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.60
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11F606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 13:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB11F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AppZz8UZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH9bD1jZEsNFmQ8f171HPd/NhgLXi6F/ETHraiWMXSqUIDrUNgS5KksOdgUTjGBZEPRSzHzoNCiAiObJxuxKcI7knDl6waCi9VOC+wBJN7Clys2ZeAjt4WEivqvngd6N2m4IUkM9UrzGR4TsPADicBZYKqj/zxEs62oi5WI3FraxVRpnu/JPhcKV3r5CuZwuU0tA64/HPRkvlouyJtQU/07c0Sc4zvc4u8B17vnObePfQPf14zIBLKR2u2Hh5TnzGvV614wDsTjIhMiKwNxBvOW6v/xSlIMZUNDTeQnszsdQFOUTV8blGV/4iy5lY5ZtlQ33vweJFoyn6l+DW0g3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OADNlzxOLEmHJL3G/edAJ3fJuoIxIe3Gd9gp9UaQebM=;
 b=ZcinIY6EciHI11CYI/cHs6Q1g53S7fDeZ0/kWIhRstSIU1I/d4KMsytZPNqK/A7EZR0bz3D/VDpCh+zYc7PSIr4SC5v/u7W+UlIP4fd01sxjhRuSFPl/NArzsRVBMCceOcyhFwoVrYcm66GNFOtKu3CJFS8VXMeyeuUWv1z7UxUkavJHXfIAdWDuAadoPhtjfkHGOYkVD1fTRkh0GyOnjhG1xU3CcuEl/M/uxwcJs21YPtxCn3xI1/nhPSwyvZou9B3UpRHlhAuYNWLGr4Ce1CwpkmtFIt0PTa7wqG5rFoG7wjrQ1BkC0Nj0tRRbeMx6BsWNbaeH72Z9NaU2MXvobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OADNlzxOLEmHJL3G/edAJ3fJuoIxIe3Gd9gp9UaQebM=;
 b=AppZz8UZID4Bb/zta/2/u052uX71p9sxbucBOxy7mwOw+AQWm+5987Orm6T9K4fSTUTwQFphEVFKb6bEtyMqn1TyZp//7UHaap9NvmB1X/q8oXGqek6sUOJitIVQbWY4PBxbA7mkhtzCHW4moq44d4nw941UTWmaWbqlCJnPJWs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 13:55:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:55:21 +0000
Message-ID: <514fa8ba-6f4f-4c6f-8c59-8acd26b5db15@amd.com>
Date: Wed, 11 Nov 2026 14:55:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
To: Philipp Stanner <phasta@kernel.org>
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261105113529.1989375-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0399.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::14) To PH7PR12MB5685.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 879b20d8-849b-408b-84ca-08df3ffb6d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|22082099003|18002099003|6133799003|261009221227099003|11063799006|56012099006|261102123227099003|261102130727099003|261026135527099003|261009223027099003|261026121527099003|261026130827099003|261021121427099003|261022113327099003|261021135927099003|261021123027099003|261022075727099003|261022105027099003|261021130227099003|261021133027099003|10067099003|261028144727099003|261022115727099003|4143699003|260925021311599003|261026140227099003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	CXE6/JjleXDNwONx+sgUmn1KYUI5AuZc+b3sM1BhFrlLApJIM/f7pdo1MB0s0EREaHKGDwE0i/r0OHJ0XEi7cz6YBhHLmZUIZEMsqGW+rgA16acSTX7dIYr2Leqh9573gDNYuoP1PkKL1uqXt6ERGVjOCpXsKkSucSxerIcne/PwDNLM6U1Svqsa33G1R3MMHRDBnEijRyfoU5FDPF0OGcCQkBeTFO/OWcE6m+ZdiXrYGGeOSY4mg26a+D4PcC5TA7UZHz5BukMVZfNSw7FvooqvIcjt9Ox8eQ76HXyTxdZ+B5kjM36tMVPC3g53NGeKTYhSLR9Z17cMztxRsBRlfRctiIiO3sXXG3Ea+acrDgD3WHZY7bCc8MMkHQ47GQW5BpTqyzpwIZUJ185ZcUw+2m1XV8fTYvmouUcX2QhTbcknQ2U6EZn/ixu4bj+P7X8ILw0HjOB+o0ulnEAatwEOC+GhNY4DnU1oMnKobQCiLULdeFs1D/cVrVvbdD2ZuFnGRORsNBiEBbKF2ZxMpN6jfs9BqYO5A+VFpoxhiLguyuDAf4Nzwvs3g0uzcjU+ULjA1AzJv3yZt56LO7sBZFtzH3Y/Fkc61cb2M9uDPASbOegub/rqVjSc2V1FYUhu6rtwvB9/RyFlRMCg6IlhhJrEM7oYI2uD1YukyjmH2BW9qYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(22082099003)(18002099003)(6133799003)(261009221227099003)(11063799006)(56012099006)(261102123227099003)(261102130727099003)(261026135527099003)(261009223027099003)(261026121527099003)(261026130827099003)(261021121427099003)(261022113327099003)(261021135927099003)(261021123027099003)(261022075727099003)(261022105027099003)(261021130227099003)(261021133027099003)(10067099003)(261028144727099003)(261022115727099003)(4143699003)(260925021311599003)(261026140227099003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zmp5TnpqeTFzeFc3aTB3eU94VysyOXpYNDFXSlJBT3VRTzBsZmtxNWZSZ2s0?=
 =?utf-8?B?ZmViS0tEWVVIbHh6aWdKa1F3eTh6ZGVUVi84Y2dacm4vdG5LdElIZTFBSUp0?=
 =?utf-8?B?K3Y5TVFNaFNWRmxjd2xiN1NtMEhaU2lJOUw5OWt5b21oaG16VEJOQXZxQ2tm?=
 =?utf-8?B?dVJScmpWQkFmdEhvaGNDZzZKQzRBK1pzU093eGV0Y1dWVzV6LzFUM1ZiYWNl?=
 =?utf-8?B?aU9zcWZnK3FhQzVzbjZpTk5IRmlTWnZnS3h0MlN3cUQ3eXZtcDFpK0p6WGxy?=
 =?utf-8?B?R29ReG8zYTN4ZzhKMFYxaEhuWUVGUWcyekU2YUhpbDdndkkrSU55cWZtQ0wz?=
 =?utf-8?B?SWRnZzh1VVRYejJQWUFwd2NoOGxYTnMzVkRsS0o5c2ljWkw2WUJVeDFORmFw?=
 =?utf-8?B?aldoTG9qODRDcXJWRlFVbkdzMURSNmZyR1daU01POE5DUlV0VUJzQU5PTHY4?=
 =?utf-8?B?VHNEVGZQS1RZenQxK3E3cU1YUDAxWFlyTktRTG9CL2twem10NGJra25KVndq?=
 =?utf-8?B?VDNPZVhMcnYvazVwak9GU0hQaVNleWt5WHdjL2VyY2IzVGFpTVltMktrV25u?=
 =?utf-8?B?M1VHaWpsT3F5bU1HQURPOUdldFZYWHQ0TGNpYXZFYlBnb0VaaXczZXEvRnEz?=
 =?utf-8?B?emRTTDBTZEx0YUQ2MDRpdDZlNnZsc1pTckM4SVVaV0xaeHFmSHNkMXFKTmg4?=
 =?utf-8?B?NEN3OEhId2VCNHA1aVNzM3pyZHRYVzFDWUs0eCtVQS9hQnJ2TFNoMXpXRXhp?=
 =?utf-8?B?YUFaQ2RYR0R4NVFFZGJKbU52dkhXWk5IbVBGMERTM0d5S1k2Nm9scmV0WndD?=
 =?utf-8?B?NVlPYTFPNVkwQjdGY0ZvTElNcno1R2JMWS85LzY5T1pFQ1VOQzViNTRRWTdi?=
 =?utf-8?B?RURzTXBnYzhtWlB5R2hOa0FoRlRWcTRNUGV6RndHdk5oWUtzZkN4ZVZialMy?=
 =?utf-8?B?Q1c1a3FVZHBFV25YUlZXWUh0WCtUUnRVT203SDBRMzNDZXZ0ZURzdmdFODNB?=
 =?utf-8?B?RXRwaG1vSWRMQllzWDJWeFk1LzgvbjhJUVNaTDdEQjhJWXJJeDFCVTczRkEz?=
 =?utf-8?B?ZFhDRzJTZS95am4xL2dBdFhGVHFXd2JsTWtqcitjZE5SK3E5RFEvRDFLS1hx?=
 =?utf-8?B?K1pwdGVkZ1JVMmhZcjdWL0dNai9DTGhzK2xlZC9OVHIxYjlCbEtDREZkWWZM?=
 =?utf-8?B?VFlQY0ZHRTU0Nm1WYURPMjJrM2FqTkVQbitiZWI0WjN4ekRZT3hqTWdDaVFS?=
 =?utf-8?B?SCtyYlZEVW1qVmxOTzJxS0xad2dyUXJkOGZJbitYZktBaHdUeDBZeUF1RnFa?=
 =?utf-8?B?Snh2SXJkbExuQ1FLaVIwNWRRS09UQjVQZitpTTZxMVJQRktScUxvbXlhbzkr?=
 =?utf-8?B?djFicnM2ZVQ2R1VBN1hwZXoxckRMSU5uV0hrMm1JcmZUam1ici9uQlNGZjF4?=
 =?utf-8?B?V1NiTEg5MjAyT1dIc040K0JEaHBCcHZCbm9BRWZSUTBwcnlka3B0ajladDNZ?=
 =?utf-8?B?dGJIelFXNnA1RG95V1kyNnAxbDVybzduOFdZOWYvWllrNHM2RUk1Z3dLYUNv?=
 =?utf-8?B?anBvdWRSdkVieVFPa0dGSVFQYTA1SERVSkJqUlJIU0dKbEFjaGg1OWc4TTBL?=
 =?utf-8?B?RVc1c0pKTWtpeHUyQldaRVhEVVdFc3BxNjVpdVVHOVAvVVI2VUw3MzZsdlE0?=
 =?utf-8?B?UFBQOTJxbUZ2OTE4QStZei9vQm5CNWhvTEtVU3AvL0RycnlZV0Jlc1JsYXJI?=
 =?utf-8?B?NHJlSUtSc2dsbHpsTDlPUVJyNGdtVEtEMGUyY1UzTGhhcm91cm9jTzJKMC9H?=
 =?utf-8?B?UEM4bmw5YzF6NVpLQ1V6VTdnNUJ4ZHRvcHVOcnFibmRHbmZKcStldUcvVFJu?=
 =?utf-8?B?YmZmRVRvSFZvdjBLVHhLVUJnbVkrSnZBY3hsZXdVVUdwMVlOTUMxVWRTb3Vz?=
 =?utf-8?B?VlVvN3ZnYTUyV3h0LzViNWwrK3ZVSWMrTnNpK1liQWNEOSs4eHBWRzIrSC9D?=
 =?utf-8?B?ZTFXTnZpK3ZUUXF3ZTQxbzdFbk1naXFJQm1tZFlqTS9EM01HcjUxVFRjUWRp?=
 =?utf-8?B?Y2U0TEZCUGVOVmtOWHVEd21jT2s1RFR2Qk1oK2IwVVZHbTRVWEtBWmlSSHd0?=
 =?utf-8?B?dkFVSTZ0R1lVSlRGUVFkODAwVHVQazZhUGRvL1B5R3dtK215ampDbUNhUnlq?=
 =?utf-8?B?bmY1S09lMldKanY3YTBMNDR5bkdsNlZjdVlCWFF2ZEV0Z3VFWWlmOERMbkZQ?=
 =?utf-8?B?Y1kxR1kwU2VQMUpwMGxXVy9Fb2dnVzNHUGJKcGpRYjJaaTBoTXgzNVM1Mzg0?=
 =?utf-8?Q?OBrAkpeOBB/arb0LAl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879b20d8-849b-408b-84ca-08df3ffb6d39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:55:21.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2XyrREllgIuogzF6QD1I0Y3pj4Gb/kreulRCQ5KA4R7FbofDNsq2qMMU/By2TEH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

On 11/5/26 12:35, Philipp Stanner wrote:
...>  
> +static bool dma_fence_flags_invalid(unsigned long flags)

I think dma_fence_are_flags_valid() would match the kernel naming style better.

But that is only a nit pick. With or without the name changed Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.

Feel free to push to drm-misc-next or ping me when I should.

Thanks,
Christian.

> +{
> +	const unsigned long valid_fence_bits =
> +		BIT(DMA_FENCE_FLAG_SEQNO64_BIT);
> +	const unsigned long valid_user_bits =
> +		GENMASK(
> +			BITS_PER_TYPE(unsigned long) - 1,
> +			DMA_FENCE_FLAG_USER_BITS
> +		       );
> +	const unsigned long invalid_bits =
> +		~(valid_fence_bits | valid_user_bits);
> +
> +	return flags & invalid_bits;
> +}
> +
>  /**
>   * dma_fence_init - Initialize a custom fence.
>   * @fence: the fence to initialize
> @@ -1094,6 +1108,7 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>   * @lock: optional irqsafe spinlock to use for locking this fence
>   * @context: the execution context this fence is run on
>   * @seqno: a linear increasing sequence number for this context
> + * @flags: flags modifying a fence's behavior
>   *
>   * Initializes an allocated fence, the caller doesn't have to keep its
>   * refcount after committing with this fence, but it will need to hold a
> @@ -1108,12 +1123,18 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>   * introduction of the callback, but the external lock is still around. New
>   * users MUST NOT use external locks, as they force the issuer to outlive all
>   * fences that reference the lock.
> + *
> + * The @flags you can specify here are either DMA_FENCE_FLAG_SEQNO64_BIT or
> + * user-specified bits >= DMA_FENCE_FLAG_USER_BITS.
>   */
>  void
>  dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
> -	       spinlock_t *lock, u64 context, u64 seqno)
> +	       spinlock_t *lock, u64 context, u64 seqno,
> +	       unsigned long flags)
>  {
> -	__dma_fence_init(fence, ops, lock, context, seqno, 0UL);
> +	WARN_ON(dma_fence_flags_invalid(flags));
> +
> +	__dma_fence_init(fence, ops, lock, context, seqno, flags);
>  }
>  EXPORT_SYMBOL(dma_fence_init);
>  
> diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
> index e0d9b69bfa76..b9610df3ff19 100644
> --- a/drivers/dma-buf/st-dma-fence-chain.c
> +++ b/drivers/dma-buf/st-dma-fence-chain.c
> @@ -52,7 +52,7 @@ static struct dma_fence *mock_fence(void)
>  		return NULL;
>  
>  	spin_lock_init(&f->lock);
> -	dma_fence_init(&f->base, &mock_ops, &f->lock, 0, 0);
> +	dma_fence_init(&f->base, &mock_ops, &f->lock, 0, 0, 0);
>  
>  	return &f->base;
>  }
> diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
> index c5353b36f0e4..dbebc3046d42 100644
> --- a/drivers/dma-buf/st-dma-fence-unwrap.c
> +++ b/drivers/dma-buf/st-dma-fence-unwrap.c
> @@ -36,7 +36,7 @@ static struct dma_fence *__mock_fence(u64 context, u64 seqno)
>  		return NULL;
>  
>  	spin_lock_init(&f->lock);
> -	dma_fence_init(&f->base, &mock_ops, &f->lock, context, seqno);
> +	dma_fence_init(&f->base, &mock_ops, &f->lock, context, seqno, 0);
>  
>  	return &f->base;
>  }
> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
> index cb62e606d0a2..b3f88e89cc44 100644
> --- a/drivers/dma-buf/st-dma-fence.c
> +++ b/drivers/dma-buf/st-dma-fence.c
> @@ -31,7 +31,7 @@ static struct dma_fence *mock_fence(void)
>  	if (!f)
>  		return NULL;
>  
> -	dma_fence_init(f, &mock_ops, NULL, 0, 0);
> +	dma_fence_init(f, &mock_ops, NULL, 0, 0, 0);
>  	return f;
>  }
>  
> diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
> index 0b96136bbd54..c3a920ab3fcf 100644
> --- a/drivers/dma-buf/st-dma-resv.c
> +++ b/drivers/dma-buf/st-dma-resv.c
> @@ -35,7 +35,7 @@ static struct dma_fence *alloc_fence(void)
>  	if (!f)
>  		return NULL;
>  
> -	dma_fence_init(f, &fence_ops, &fence_lock, 0, 0);
> +	dma_fence_init(f, &fence_ops, &fence_lock, 0, 0, 0);
>  	return f;
>  }
>  
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9..ce43af7e735e 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -258,7 +258,7 @@ static struct sync_pt *sync_pt_create(struct sync_timeline *obj,
>  
>  	sync_timeline_get(obj);
>  	dma_fence_init(&pt->base, &timeline_fence_ops, &obj->lock,
> -		       obj->context, value);
> +		       obj->context, value, 0);
>  	INIT_LIST_HEAD(&pt->link);
>  
>  	spin_lock_irq(&obj->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 9b10d015671c..30ccdb3e0b47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -77,7 +77,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
>  	spin_lock_init(&fence->lock);
>  	fence->context_id = context_id;
>  	dma_fence_init(&fence->base, &amdkfd_fence_ops, &fence->lock,
> -		   context, atomic_inc_return(&fence_seq));
> +		   context, atomic_inc_return(&fence_seq), 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index bff2d38f3571..03e1974f8dda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -112,7 +112,7 @@ void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>  	seq = ++ring->fence_drv.sync_seq;
>  	dma_fence_init(fence, &amdgpu_fence_ops,
>  		       &ring->fence_drv.lock,
> -		       adev->fence_context + ring->idx, seq);
> +		       adev->fence_context + ring->idx, seq, 0);
>  
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>  			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba6756..92641bc0a378 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -190,7 +190,7 @@ struct dma_fence *drm_crtc_create_fence(struct drm_crtc *crtc)
>  		return NULL;
>  
>  	dma_fence_init(fence, &drm_crtc_fence_ops, &crtc->fence_lock,
> -		       crtc->fence_context, ++crtc->fence_seqno);
> +		       crtc->fence_context, ++crtc->fence_seqno, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index b4a002e6d043..64b06b890f19 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -592,7 +592,7 @@ drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector)
>  
>  	dma_fence_init(fence, &drm_writeback_fence_ops,
>  		       &wb_connector->fence_lock, wb_connector->fence_context,
> -		       ++wb_connector->fence_seqno);
> +		       ++wb_connector->fence_seqno, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index e75dab5e407d..a10e4e4cf372 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1199,7 +1199,7 @@ static struct dma_fence *etnaviv_gpu_fence_alloc(struct etnaviv_gpu *gpu)
>  	f->gpu = gpu;
>  
>  	dma_fence_init(&f->base, &etnaviv_fence_ops, &gpu->fence_spinlock,
> -		       gpu->fence_context, ++gpu->next_fence);
> +		       gpu->fence_context, ++gpu->next_fence, 0);
>  
>  	return &f->base;
>  }
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> index 56489cc127d6..ffaa70191f27 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> @@ -437,7 +437,7 @@ i915_ttm_memcpy_work_arm(struct i915_ttm_memcpy_work *work,
>  	int ret;
>  
>  	spin_lock_init(&work->lock);
> -	dma_fence_init(&work->fence, &dma_fence_memcpy_ops, &work->lock, 0, 0);
> +	dma_fence_init(&work->fence, &dma_fence_memcpy_ops, &work->lock, 0, 0, 0);
>  	dma_fence_get(&work->fence);
>  	ret = dma_fence_add_callback(dep, &work->cb, __memcpy_cb);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> index f66f8efc7062..0f4fc9cc0033 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -953,7 +953,7 @@ __i915_request_create(struct intel_context *ce, gfp_t gfp)
>  		goto err_free;
>  
>  	dma_fence_init(&rq->fence, &i915_fence_ops, &rq->lock,
> -		       tl->fence_context, seqno);
> +		       tl->fence_context, seqno, 0);
>  
>  	RCU_INIT_POINTER(rq->timeline, tl);
>  	rq->hwsp_seqno = tl->hwsp_seqno;
> diff --git a/drivers/gpu/drm/i915/i915_sw_fence_work.c b/drivers/gpu/drm/i915/i915_sw_fence_work.c
> index 366418108f78..4cd44dd26e35 100644
> --- a/drivers/gpu/drm/i915/i915_sw_fence_work.c
> +++ b/drivers/gpu/drm/i915/i915_sw_fence_work.c
> @@ -85,7 +85,7 @@ void dma_fence_work_init(struct dma_fence_work *f,
>  {
>  	f->ops = ops;
>  	spin_lock_init(&f->lock);
> -	dma_fence_init(&f->dma, &fence_ops, &f->lock, 0, 0);
> +	dma_fence_init(&f->dma, &fence_ops, &f->lock, 0, 0, 0);
>  	i915_sw_fence_init(&f->chain, fence_notify);
>  	INIT_WORK(&f->work, fence_work);
>  }
> diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
> index a8f2112ce81f..19596410e32f 100644
> --- a/drivers/gpu/drm/i915/i915_vma_resource.c
> +++ b/drivers/gpu/drm/i915/i915_vma_resource.c
> @@ -263,7 +263,7 @@ void __i915_vma_resource_init(struct i915_vma_resource *vma_res)
>  {
>  	spin_lock_init(&vma_res->lock);
>  	dma_fence_init(&vma_res->unbind_fence, &unbind_fence_ops,
> -		       &vma_res->lock, 0, 0);
> +		       &vma_res->lock, 0, 0, 0);
>  	refcount_set(&vma_res->hold_count, 1);
>  	i915_sw_fence_init(&vma_res->chain, i915_vma_resource_fence_notify);
>  }
> diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> index ecb2d718f6a6..d8d4f7057031 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> @@ -641,7 +641,7 @@ static struct dma_fence *alloc_dma_fence(void)
>  
>  	dma = kmalloc_obj(*dma);
>  	if (dma)
> -		dma_fence_init(dma, &mock_fence_ops, &mock_fence_lock, 0, 0);
> +		dma_fence_init(dma, &mock_fence_ops, &mock_fence_lock, 0, 0, 0);
>  
>  	return dma;
>  }
> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
> index e408df74853d..7043b491fe54 100644
> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
> @@ -645,7 +645,7 @@ pvr_kccb_reserve_slot(struct pvr_device *pvr_dev, struct dma_fence *f)
>  		dma_fence_init(&fence->base, &pvr_kccb_fence_ops,
>  			       &pvr_dev->kccb.fence_ctx.lock,
>  			       pvr_dev->kccb.fence_ctx.id,
> -			       atomic_inc_return(&pvr_dev->kccb.fence_ctx.seqno));
> +			       atomic_inc_return(&pvr_dev->kccb.fence_ctx.seqno), 0);
>  		out_fence = dma_fence_get(&fence->base);
>  		list_add_tail(&fence->node, &pvr_dev->kccb.waiters);
>  	} else {
> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
> index 24a8645aa913..34b826381aa2 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -305,7 +305,7 @@ pvr_queue_fence_init(struct dma_fence *f,
>  	INIT_WORK(&fence->release_work, pvr_queue_fence_release_work);
>  	dma_fence_init(&fence->base, fence_ops,
>  		       &fence_ctx->lock, fence_ctx->id,
> -		       atomic_inc_return(&fence_ctx->seqno));
> +		       atomic_inc_return(&fence_ctx->seqno), 0);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> index 9a1e6b9ecbe5..fee595b9629a 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -97,7 +97,7 @@ static struct lima_fence *lima_fence_create(struct lima_sched_pipe *pipe)
>  
>  	fence->pipe = pipe;
>  	dma_fence_init(&fence->base, &lima_fence_ops, &pipe->fence_lock,
> -		       pipe->fence_context, ++pipe->fence_seqno);
> +		       pipe->fence_context, ++pipe->fence_seqno, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
> index 3dca8e09c192..1ec59919c32e 100644
> --- a/drivers/gpu/drm/msm/msm_fence.c
> +++ b/drivers/gpu/drm/msm/msm_fence.c
> @@ -197,5 +197,5 @@ msm_fence_init(struct dma_fence *fence, struct msm_fence_context *fctx)
>  	WARN_ON(kref_read(&fence->refcount));
>  
>  	dma_fence_init(&f->base, &msm_fence_ops, &fctx->spinlock,
> -		       fctx->context, ++fctx->last_fence);
> +		       fctx->context, ++fctx->last_fence, 0);
>  }
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
> index 11e95c37ce50..97e20954c71b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
> @@ -216,10 +216,10 @@ nouveau_fence_emit(struct nouveau_fence *fence)
>  
>  	if (priv->uevent)
>  		dma_fence_init(&fence->base, &nouveau_fence_ops_uevent,
> -			       &fctx->lock, fctx->context, ++fctx->sequence);
> +			       &fctx->lock, fctx->context, ++fctx->sequence, 0);
>  	else
>  		dma_fence_init(&fence->base, &nouveau_fence_ops_legacy,
> -			       &fctx->lock, fctx->context, ++fctx->sequence);
> +			       &fctx->lock, fctx->context, ++fctx->sequence, 0);
>  	kref_get(&fctx->fence_ref);
>  
>  	ret = fctx->emit(fence);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 4ddf4b722ddf..de242d275978 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -105,7 +105,7 @@ static struct dma_fence *panfrost_fence_create(struct panfrost_device *pfdev, in
>  	fence->queue = js_num;
>  	fence->seqno = ++js->queue[js_num].emit_seqno;
>  	dma_fence_init(&fence->base, &panfrost_fence_ops, &js->job_lock,
> -		       js->queue[js_num].fence_context, fence->seqno);
> +		       js->queue[js_num].fence_context, fence->seqno, 0);
>  
>  	return &fence->base;
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index a343c5180e01..c46f69ade7a0 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3322,7 +3322,7 @@ queue_run_job(struct drm_sched_job *sched_job)
>  		       &panthor_queue_fence_ops,
>  		       &queue->fence_ctx.lock,
>  		       queue->fence_ctx.id,
> -		       atomic64_inc_return(&queue->fence_ctx.seqno));
> +		       atomic64_inc_return(&queue->fence_ctx.seqno), 0);
>  
>  	job->profiling.slot = queue->profiling.seqno++;
>  	if (queue->profiling.seqno == queue->profiling.slot_count)
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
> index 06979d0e8a9f..2608d82f7370 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -430,7 +430,7 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
>  	 * set the highest bits. This will break if we really allow exporting of dma-bufs.
>  	 */
>  	dma_fence_init(&release->base, &qxl_fence_ops, &qdev->release_lock,
> -		       release->id | 0xf0000000, release->base.seqno);
> +		       release->id | 0xf0000000, release->base.seqno, 0);
>  	trace_dma_fence_emit(&release->base);
>  
>  	list_for_each_entry(entry, &release->bos, list) {
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
> index 8e9402b8811b..1360b5215f5e 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -148,7 +148,7 @@ int radeon_fence_emit(struct radeon_device *rdev,
>  	dma_fence_init(&(*fence)->base, &radeon_fence_ops,
>  		       &rdev->fence_queue.lock,
>  		       rdev->fence_context + ring,
> -		       seq);
> +		       seq, 0);
>  	radeon_fence_ring_emit(rdev, ring, *fence);
>  	trace_radeon_fence_emit(rdev_to_drm(rdev), ring, (*fence)->seq);
>  	radeon_fence_schedule_check(rdev, ring);
> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
> index b7a4cb921234..94ba0cf4fe02 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> @@ -229,9 +229,9 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
>  	fence->sched = entity->rq->sched;
>  	seq = atomic_inc_return(&entity->fence_seq);
>  	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
> -		       &fence->lock, entity->fence_context, seq);
> +		       &fence->lock, entity->fence_context, seq, 0);
>  	dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
> -		       &fence->lock, entity->fence_context + 1, seq);
> +		       &fence->lock, entity->fence_context + 1, seq, 0);
>  }
>  
>  module_init(drm_sched_fence_slab_init);
> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> index 2dfa3efef210..169792a4b329 100644
> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> @@ -173,7 +173,7 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
>  		       &drm_mock_sched_hw_fence_ops,
>  		       &sched->lock,
>  		       sched->hw_timeline.context,
> -		       atomic_inc_return(&sched->hw_timeline.next_seqno));
> +		       atomic_inc_return(&sched->hw_timeline.next_seqno), 0);
>  
>  	dma_fence_get(&job->hw_fence); /* Reference for the job_list */
>  
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> index f3103307b5df..633cc7458505 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> @@ -450,7 +450,7 @@ static void ttm_bo_fini_shared_resv(struct kunit *test)
>  	KUNIT_ASSERT_NOT_NULL(test, fence);
>  
>  	spin_lock_init(&fence_lock);
> -	dma_fence_init(fence, &mock_fence_ops, &fence_lock, 0, 0);
> +	dma_fence_init(fence, &mock_fence_ops, &fence_lock, 0, 0, 0);
>  
>  	dma_resv_lock(external_resv, NULL);
>  	dma_resv_reserve_fences(external_resv, 1);
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> index 56ad8ef32584..e22a1335f166 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> @@ -57,7 +57,7 @@ static struct dma_fence *alloc_mock_fence(struct kunit *test)
>  	fence = kunit_kzalloc(test, sizeof(*fence), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, fence);
>  
> -	dma_fence_init(fence, &fence_ops, &fence_lock, 0, 0);
> +	dma_fence_init(fence, &fence_ops, &fence_lock, 0, 0, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
> index c500136d0455..1fdba5a21580 100644
> --- a/drivers/gpu/drm/v3d/v3d_fence.c
> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
> @@ -16,7 +16,7 @@ struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q)
>  	fence->queue = q;
>  	fence->seqno = ++queue->emit_seqno;
>  	dma_fence_init(&fence->base, &v3d_fence_ops, &queue->queue_lock,
> -		       queue->fence_context, fence->seqno);
> +		       queue->fence_context, fence->seqno, 0);
>  
>  	return &fence->base;
>  }
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index ff611c618d6b..420988d516c1 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -648,7 +648,7 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
>  	exec->seqno = seqno;
>  
>  	dma_fence_init(&fence->base, &vc4_fence_ops, &vc4->job_lock,
> -		       vc4->dma_fence_context, exec->seqno);
> +		       vc4->dma_fence_context, exec->seqno, 0);
>  	fence->seqno = exec->seqno;
>  	exec->fence = &fence->base;
>  
> diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
> index 0e53ba7db629..18700e5f9167 100644
> --- a/drivers/gpu/drm/vgem/vgem_fence.c
> +++ b/drivers/gpu/drm/vgem/vgem_fence.c
> @@ -77,7 +77,7 @@ static struct dma_fence *vgem_fence_create(struct vgem_file *vfile,
>  
>  	spin_lock_init(&fence->lock);
>  	dma_fence_init(&fence->base, &vgem_fence_ops, &fence->lock,
> -		       dma_fence_context_alloc(1), 1);
> +		       dma_fence_context_alloc(1), 1, 0);
>  
>  	timer_setup(&fence->timer, vgem_fence_timeout, TIMER_IRQSAFE);
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
> index c3e66ef2133a..8e469391d2e4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fence.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
> @@ -76,7 +76,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev,
>  	 */
>  
>  	dma_fence_init(&fence->f, &virtio_gpu_fence_ops, &drv->lock,
> -		       fence_context, 0);
> +		       fence_context, 0, 0);
>  
>  	return fence;
>  }
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> index 384c6736cf6b..15f355dc6881 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -163,7 +163,7 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
>  	int ret = 0;
>  
>  	dma_fence_init(&fence->base, &vmw_fence_ops, &fman->lock,
> -		       fman->ctx, seqno);
> +		       fman->ctx, seqno, 0);
>  	fence->destroy = destroy;
>  
>  	spin_lock(&fman->lock);
> diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
> index 14720623ad00..30bfc42972e0 100644
> --- a/drivers/gpu/drm/xe/xe_hw_fence.c
> +++ b/drivers/gpu/drm/xe/xe_hw_fence.c
> @@ -243,7 +243,7 @@ void xe_hw_fence_init(struct dma_fence *fence, struct xe_hw_fence_ctx *ctx,
>  	INIT_LIST_HEAD(&hw_fence->irq_link);
>  
>  	dma_fence_init(fence, &xe_hw_fence_ops, &ctx->irq->lock,
> -		       ctx->dma_fence_ctx, ctx->next_seqno++);
> +		       ctx->dma_fence_ctx, ctx->next_seqno++, 0);
>  
>  	trace_xe_hw_fence_create(hw_fence);
>  }
> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index c9320feeafba..912840eeec50 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
> @@ -1053,7 +1053,7 @@ static int xe_oa_emit_oa_config(struct xe_oa_stream *stream, struct xe_oa_config
>  
>  	/* Point of no return: initialize and set fence to signal */
>  	spin_lock_init(&ofence->lock);
> -	dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0);
> +	dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0, 0);
>  
>  	for (i = 0; i < stream->num_syncs; i++) {
>  		if (stream->syncs[i].flags & DRM_XE_SYNC_FLAG_SIGNAL)
> diff --git a/drivers/gpu/drm/xe/xe_preempt_fence.c b/drivers/gpu/drm/xe/xe_preempt_fence.c
> index 4aa570fe745d..343f1ba1e1cd 100644
> --- a/drivers/gpu/drm/xe/xe_preempt_fence.c
> +++ b/drivers/gpu/drm/xe/xe_preempt_fence.c
> @@ -154,7 +154,7 @@ xe_preempt_fence_arm(struct xe_preempt_fence *pfence, struct xe_exec_queue *q,
>  	pfence->q = xe_exec_queue_get(q);
>  	spin_lock_init(&pfence->lock);
>  	dma_fence_init(&pfence->base, &preempt_fence_ops,
> -		      &pfence->lock, context, seqno);
> +		      &pfence->lock, context, seqno, 0);
>  
>  	return &pfence->base;
>  }
> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
> index c9cc5842d65b..1fd39434dc0e 100644
> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> @@ -544,7 +544,7 @@ void xe_tlb_inval_fence_init(struct xe_tlb_inval *tlb_inval,
>  
>  	spin_lock_irq(&tlb_inval->lock);
>  	dma_fence_init(&fence->base, &inval_fence_ops, &tlb_inval->lock,
> -		       dma_fence_context_alloc(1), 1);
> +		       dma_fence_context_alloc(1), 1, 0);
>  	spin_unlock_irq(&tlb_inval->lock);
>  	INIT_LIST_HEAD(&fence->link);
>  	if (stack)
> diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
> index 1acf579c562b..7e074e72a055 100644
> --- a/drivers/gpu/host1x/fence.c
> +++ b/drivers/gpu/host1x/fence.c
> @@ -136,7 +136,7 @@ struct dma_fence *host1x_fence_create(struct host1x_syncpt *sp, u32 threshold,
>  	fence->timeout = timeout;
>  
>  	dma_fence_init(&fence->base, &host1x_syncpt_fence_ops, &sp->fences.lock,
> -		       dma_fence_context_alloc(1), 0);
> +		       dma_fence_context_alloc(1), 0, 0);
>  
>  	INIT_DELAYED_WORK(&fence->timeout_work, do_fence_timeout);
>  
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4294101810fd..f7d6b294b63c 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1904,7 +1904,7 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
>  	 * the dma_fence.
>  	 */
>  	dma_fence_init(&fence->base, &iio_buffer_dma_fence_ops,
> -		       &fence->lock, priv->context, seqno);
> +		       &fence->lock, priv->context, seqno, 0);
>  
>  	ret = iio_dma_resv_lock(dmabuf, nonblock);
>  	if (ret)
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index c64a268e98a4..eb367a1666c2 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1733,7 +1733,7 @@ static int ffs_dmabuf_transfer(struct file *file,
>  	seqno = atomic_add_return(1, &epfile->seqno);
>  
>  	dma_fence_init(&fence->base, &ffs_dmabuf_fence_ops,
> -		       &priv->lock, priv->context, seqno);
> +		       &priv->lock, priv->context, seqno, 0);
>  
>  	resv_dir = epfile->in ? DMA_RESV_USAGE_READ : DMA_RESV_USAGE_WRITE;
>  
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..6f5c245d89ec 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -103,6 +103,12 @@ struct dma_fence {
>  	int error;
>  };
>  
> +/** enum dma_fence_flag_bits - internal dma_fence flags
> + *
> + * These flags are all only for internal usage, except for
> + * @DMA_FENCE_FLAG_SEQNO64_BIT and the user bits beginning at
> + * @DMA_FENCE_FLAG_USER_BITS.
> + */
>  enum dma_fence_flag_bits {
>  	DMA_FENCE_FLAG_INITIALIZED_BIT,
>  	DMA_FENCE_FLAG_INLINE_LOCK_BIT,
> @@ -110,6 +116,7 @@ enum dma_fence_flag_bits {
>  	DMA_FENCE_FLAG_SIGNALED_BIT,
>  	DMA_FENCE_FLAG_TIMESTAMP_BIT,
>  	DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> +
>  	DMA_FENCE_FLAG_USER_BITS, /* must always be last member */
>  };
>  
> @@ -279,11 +286,10 @@ struct dma_fence_ops {
>  };
>  
>  void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
> -		    spinlock_t *lock, u64 context, u64 seqno);
> -
> +		    spinlock_t *lock, u64 context, u64 seqno,
> +		    unsigned long flags);
>  void dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
>  		      spinlock_t *lock, u64 context, u64 seqno);
> -
>  void dma_fence_release(struct kref *kref);
>  void dma_fence_free(struct dma_fence *fence);
>  void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq);
> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
> index 18a43e1bb442..ee8fa4ecd6c1 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -736,7 +736,7 @@ pub fn new_fence(self) -> DriverFence<'a, T> {
>          // SAFETY: `fence_ptr` has been created directly above. It will live
>          // at least as long as `Self`. The same applies to `&Self::OPS`.
>          unsafe {
> -            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno)
> +            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno, 0)
>          };
>  
>          self.data.fctx.nr_of_unsignaled_fences.fetch_add(1, Relaxed);

