Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA71175D27
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011010; cv=fail; b=f5nEKAWSOjgZdHynD7RLy3urnJ/Dt0FUv3y2OKyf14ajTamreNioFlpNSL2uGpUP+BPyC4tLFiGBQsW3OUVweaqGQo+xwvEp+vwkYn4YOxyFVRXA/kT0y+cI9f7HUznt98cZ/cV1469uL6ZDZVhsd8d91w5NkP2zMa2sZFu4f4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011010; c=relaxed/simple;
	bh=XrerR1AtFK1EkctE9VYfmqiYxsz8t+LH+Tbq6bSCDUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQFLyJgYnKR/RQhsJ7pYCpqCMGcnVyIwi3ZQuoDIIWI6WdiNpp7zbies9ixN8L5chx242t4MA9/ZjbCt5PVTbxwrKA22JTcZqsscPYm2i/THQlrK/EkG6vH0gP0+mmBOpbldfKw3q7ssu+t6asrlxdfjjeHZwNYhK9dsFvvkQ3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cEudITP1; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cEudITP1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww3I4kH1XD/SXjHyK2g/aP5BdvwwexU0hBlL/QXiygE+vLyXgcAQKWqTEg5qySB73duRP/2/qAhrUFU1Da5tGh3SXTmtJoSwBL3hrxkD9NYglQw+O1yjhGKglCH6WZ2/r3GK6nS6O5M/surR+sZy4b0VK4LR5McsnoWlxj0XnthGu8gfLq1lZPwSFN8cTfqMxWI2WM/HwOe6D5BOVkPGoCW3TmbJCg5dODd0aGrtWtRMeMYxPAsi6UXv8afhl98dMpkx0sRDQaVr0itEZ7kheusfsiW8EWnyQtun5WObU/fjjkKTXyuLeXKYbOK9zd8sQyJIlZ9U0ZYl6/n2/5PsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afvcGc+qFNYrbkDDmHLFNvjdgclOCpt7j0jYF22Sjpc=;
 b=ZpRxAds74Qyw9nf4Es64bVzagrvyZ9T7b1kv7DKVpVvQ1KcYdmpJEAU7bbYmXV3DdlhLFycZfNLyKVm66kO0t82KHpnaJM0CdlZO58ba30Fdrae1s4UrzfTNBNhtsu9Zg/DQnb/t1TTtPFdSQyL9GGRDwaGA5qClywG9FsonxEDmzdnTnzQyyXQVZNjTFSdDFGDbvsrm2ccNCnodALnGDu8tltvm3EdS3MJ/zru7r+znavJC7JugB/kRXg93Rgh7u/enV3b0wxvWmUnNkau7B3mO5GWNlJKrNDFOTMHDpSLwHtei0UUQ6DQmaXHJnaq2wJjM2Fopiqd7n3ibC6hzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afvcGc+qFNYrbkDDmHLFNvjdgclOCpt7j0jYF22Sjpc=;
 b=cEudITP14ZMN1r87MSl9Cl9VufaeqKWJrSWxLVQMKlOndq0K3eJbC76e5j06Q7LK4zDIT/rNzElW0natHtTeYqAevjscjsvhUHFjM92hf5XBVFZyMauZhgcZsEpSQHdRyNx7ktY/Bl/GTSjcIOreOdVCDsGf0BPLk+LeMMp+m1fl+LbMksW2LQHA16zwDfA/8ID60TBJ4Wyt89JaiCCkUIo3ZR+vjlVbxYOi6bDsCOc/KxInwO7FvUHQrp+iwmjJKjgYJ6HMhfn/uXoEBwjpfNAgLfIpDL7zG/lAemQ5FKW5lae6oo9XxUa1i3NfD9xYgWR1QPiKKlDhq0UCT2zh6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 09:43:25 +0000
Received: from IA0PR12MB8304.namprd12.prod.outlook.com
 ([fe80::6a2e:bf21:da5d:e7ea]) by IA0PR12MB8304.namprd12.prod.outlook.com
 ([fe80::6a2e:bf21:da5d:e7ea%5]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 09:43:25 +0000
Message-ID: <9c797c93-f5a5-468b-9f35-4fc28b9c57f3@nvidia.com>
Date: Fri, 30 Aug 2024 11:43:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
To: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
 <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
 <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
 <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
 <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com>
 <0648a9d9-a056-4cdb-bfb8-a792bce1e771@nvidia.com>
 <CACLfguXM97JAdWcYO17+H6pu7MWLu2QqBgu_PypGxU_Ab+OUOQ@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CACLfguXM97JAdWcYO17+H6pu7MWLu2QqBgu_PypGxU_Ab+OUOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To DS0PR12MB8295.namprd12.prod.outlook.com
 (2603:10b6:8:f6::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8304:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e35b90-c355-4ce0-42cd-08dcc8d83102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzBzZ3d5SkhxNUhiYXVlaHgxMXJ6SkhjNlJON2NkbGlwLzgxZWIrcHJLVUQx?=
 =?utf-8?B?Szk5YTJVZURBbS9Obko2MGgva2FMWmo0djNOSFZlVkJXU0psRElvVUxXSFlF?=
 =?utf-8?B?b1R3ZWsyeXVOTXhZenpyTTEyeDJHWHpEZklKRHFOL2tZWTM3djE1RmdOQklj?=
 =?utf-8?B?RExIdEVRajQ4eXdiNnBzWEpqRnpnRTRGckRFTGJhNFhhbVNlL05GajBwZUh3?=
 =?utf-8?B?ZXEyWFUwQ215aW0zYUtMMENVMGw1WnJ2NG82a21SV2V2c1lya2YvSURSdXNa?=
 =?utf-8?B?TWVLZ0NmcXBGNEtZSTZJSU5DdUVmbDdqU29OLzdIakJUYVR2cmNmREV6S1NS?=
 =?utf-8?B?dnJoSmVBNGNZVHdFblJ6UW5EL2Q0aHZ4cGpjRUFWRDQ4M0tkcWtOTm9wSnl4?=
 =?utf-8?B?WlRJOUxPQlIvUFh0RFJBc0c2YjRFZ0prZXVKdEY0and5eFIrN0ZHRjJwWkI5?=
 =?utf-8?B?bWxMVlhwUkt3K0tjOGlEcURINWNhcmdwQXpudHBrbUVFNzlUTjdYcXEySi9w?=
 =?utf-8?B?UTFWTno1WmRwSDVDUlVHYnlyd3AzV1NYdU1odXUvbEdJSU01TWZFVWxKaDZk?=
 =?utf-8?B?Q1cxYytMMCtZNG1LcGwrd00xNTZWT2VKaWVPM2kxWVdaUG9nTnlYT2NFRDVt?=
 =?utf-8?B?WVZXSVAvSTF3empqUGY3bWt1QkhxbUJnVksvZFpHaDJLcWZqT3JZcFZ3T0x1?=
 =?utf-8?B?RTh3QnpWYW9qZkhjUGtkUFBsaEpPcHdGbFJ1Qkg5dkNmejBZWFA4QlQwcUtG?=
 =?utf-8?B?S2hkOFVud3JEak1RNkV0RmZZMHVlcHN6RHMyTVY2ZVA1emVEK2JuWVoxQlNt?=
 =?utf-8?B?Yi83RzRwcDIvRW03Ym5QelRoWExvTG9QMzREQVg0RkxTbDJmc25YdmNYNVBP?=
 =?utf-8?B?aGZXTS9YbVZwQm1rRWRiaHJ1N1hNQm4xeGcrRXp4SmxzMytwc25BYWpSS1VS?=
 =?utf-8?B?bm1Ub3FTWVdMK1dyNERwbU5oTTZsM3pucU9SanpHNVo3ZTJiK3h2djE3d3hE?=
 =?utf-8?B?eEhmY3ZkY1FvRzBCOURQa3hwU0dzK0pmdyt1UkMxaldxclU4ZkVXSkZIUDU5?=
 =?utf-8?B?akpZRWdoQWRBejlLMTR5cWJpMms2Sy9oZ1V4N3lnU0NrTmY4Y1IrbGVXL21x?=
 =?utf-8?B?SEdVYUdsaEd4UjIwcFMxeU9jSlYyUzMwdmJkYnhBWkdlZFBUdTdaMDBQMUMy?=
 =?utf-8?B?cU1McEVUV3VFeFNVYndydmRSTUNMczdGYnBFN0RybXMydnRqeGNtakFuV3B5?=
 =?utf-8?B?cnpPTnVnT1FnM1ZMMit0V1JXSS9acTdXUVd5TW1uQzlMYm9zaUx1eDVPdUg0?=
 =?utf-8?B?RkRwd0V0OHpKdFd3QzZpbTR5dkVtUTZRMU1pdmlqckp6Z3BvaG1iMVJwK2J5?=
 =?utf-8?B?RjNvdkM2aE5CdGxmYVVJb1JEL2FyUlduQ3NJVDdFa29lc2xUb3Z1eGo0S0Jq?=
 =?utf-8?B?RUlONUNyVlQyMXM0azIrTHhzQW9vRUxiRFpEck1HdUw5MEhjQnErWVpjWlY2?=
 =?utf-8?B?SFhHdElSZ2RrZ3BXNXREejF1SHBDaHRtc2puc0gvVjFaeEhXVWRCMjltK21Q?=
 =?utf-8?B?TDN4R1JMTHZoRFYrelB4Uk9pcy9ldjFQQ3JvcHllcklxcGRKbTg1Uml4bmNm?=
 =?utf-8?B?WDJTMFhtU2I2RTVnV1FJdjRVWGVSS3VrdDBqVmJFU1o4T0RLVDZGdTJPeklv?=
 =?utf-8?B?eEhxRzZOdU1OMXArUDMyUXdoVUx3R0xSM2ViVnRTRnNacUsrMndkbUV4ZTNl?=
 =?utf-8?B?dmF5YjNqSFVVd3RXWGxjN1RLcEFybEFyMDgzeXB4ay9JUFlYdFJpZ0ZNZ1Vp?=
 =?utf-8?B?azZKWVhKamROZEl3bWtRQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8304.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2VVczdRVzhHV3R4Um11VEV6V0c5MXZCNGJ5cmFBU1hObnVvdFd5dStnRFY4?=
 =?utf-8?B?ZkNZSmlnUE1ZZUZBbXQxbW5iS0d3RTBpQUZOb3R0aEVIakFxcmJCcEkydjY4?=
 =?utf-8?B?MkYwZHJEeGo2Z2NjMFdqSlNHVkR0QjVWYzFjOG5Tb2lXTjNCS2RJR0FiSzNh?=
 =?utf-8?B?cVRNdVhYZGt4R3EybGFXc3BSdHNEQVZwank5TlNvVkVxRzdNS1J6Rmt0VS9z?=
 =?utf-8?B?U2NDY0hXVlF2cTBkVGJhZ3AweWcyOW55c1pTRUR3T2V2c3RUOWJGa0xSak1M?=
 =?utf-8?B?cUo4VU9TclN3TnI1ZXIzNzZqWGRkSm9NM2I5Y2N6U1VNek5OL3JJS1kySG9N?=
 =?utf-8?B?SlFXZmUxSUhNd05DTG9PQjU0ZERhVjUyQms0SFNCRmpEMi9KUUcwZ3ZVeEhz?=
 =?utf-8?B?QUMvYVJ2L1VkWVlmSitweE1EcFdSdnNHZTh3Z3ppRXFJbHBsejJldE0xYzBF?=
 =?utf-8?B?emcwWGpCN3NPK1RDUlZhakFLNUROK0lNK1pCVU01TUdRQmxuc050aXhINk5l?=
 =?utf-8?B?UXRaV1ZORkZjekxRMjZPRmo0TUdJcEZoa0VTcGhnbkdLYUpheUJaRjl3R0l1?=
 =?utf-8?B?RHAyUm1NbmxBUzlFclM1ZEFCcGNJSzdZWWF0a3dLWExSYXhvSWJXTk9JN014?=
 =?utf-8?B?MUYxc2ZmS1dOSXpWV0JUUHFyTnpDNWphK1Q3WnVsZDE2NEJDVkJiNDFCNVJ4?=
 =?utf-8?B?SUVTN010Ris4Q1BtR1BUbHM5R1VZUWdtRzVKYThVYTVuRThRcTUySzJuR2RR?=
 =?utf-8?B?L1FTSU4vVGE3MWo2NE9oak1ZZ1NEdWlDUm12dU41YkZOMG1mbmxPblF3S3FP?=
 =?utf-8?B?UWE4NklrSmJCSHMzbXBKTjRwTlBVRW92SGV3eXZPTzdXQlJCdmI0VFpTdHk1?=
 =?utf-8?B?aTVlNVNVTTNiUW1KNG01NGh2YjRzeHFYRzcyR1FOcUd4RXg1eEIzMnoxMmtO?=
 =?utf-8?B?d3RIUVZRN3A5VWRBT3lITTdMSGhPVks0QmkzMGxVNnJRMDY3VnluZkxpWU56?=
 =?utf-8?B?K1pSTzlUWk5SUlhsVEdoVWNMSWVscmdmQmxDUzEzZ3lVV2FkMnNRcU9Xc3R4?=
 =?utf-8?B?U0lOUGd0dnhBWWliT0ExdWIxRGs5RXhQTnhLRWZkMnNZc3p6K2NMTzFwUXRN?=
 =?utf-8?B?cjl6RjlvS3ZRSnNqamNFekNVM0FLRHc4dUg5NTJ0UGJQN0FkV2pBSXN0cnlC?=
 =?utf-8?B?aWtibEtxb2ZDVVkwdlVMZWoreThlTzVZYit4QSt0b0JQRFhqNURKc0NpcU1U?=
 =?utf-8?B?c3YybnNXSTN3T3h6VkdtbUU3QlFMWjFXRG9aYU9yOFlLa3oxMHBoaWRuVDZG?=
 =?utf-8?B?K29waWw5Z24zK1J3VzR5WXdtcnJoZFR1dkVNQkhSVmNoVE9YaTljRjRYQkZM?=
 =?utf-8?B?ckxmaEdmbjVOYjU2T0VQbGlQeE5ORXZ1WWE0aTNnb3BrcU81MXNzYkNiWVho?=
 =?utf-8?B?SmN1ZWptZzlSTEV5U09SaDhwT1VqVXNucVRxVWVhbE5NcVdBWTM5eDdOb1dO?=
 =?utf-8?B?S01YRGRibDcvSWx2K1IxUjZXc3ZLVzNUcW5KVHhNTnJpdE5WUXh2ZHFmN1Q4?=
 =?utf-8?B?bFVlc3AvR1F4VmxpelkrS0JXMDJNMHBZSitlM2tGbWdCRHZJQmRLNHQ3RGJn?=
 =?utf-8?B?RTNOblA5SE5nRk9BbElBTmNHeitHUnVUNnZ5b1ZlYmhnSWh4ZDduZnNTOXA0?=
 =?utf-8?B?TkhOVytjT1ovNGxtcGlGczV5QzB1UGluQVJ3Z1p2NGRnSktlQzVTUEFZd2Fo?=
 =?utf-8?B?MC9jSGhKa1JhZmJZQXRHdjdLTC9sTHk3dlZFN1lUNWpqTlMrcXZselZhZ1pJ?=
 =?utf-8?B?VTNXTkV3NzVLWllUYVBaUEZYTmxpc0tXZFErbVdnM3M3RnJzS3JHa21FaVhY?=
 =?utf-8?B?d1ZiY25JZTg5M1IxUWc1NWtjY0hlbEIvS3h1bTZtb0xqcndWMitVQ3pYYXA5?=
 =?utf-8?B?MjVrNUYxS2UvVWVYbVdEZjg0bStnWmowT1ZMMG5FNDVQdnovWDY2cVh0dGxy?=
 =?utf-8?B?RE5JQ09OR1FEL3FWSDdVNXp5YkJLbm5ydGJZdk15ZTlPeC9qZndCVXNGMUVK?=
 =?utf-8?B?LzRKcjdWOGY5dURmRmlBMFYwRktlalhpV01zODFoajlQWDdnZ0IwLzFuOFZr?=
 =?utf-8?Q?w+6IIoi0XKpOJCXQClZrZ7H7R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e35b90-c355-4ce0-42cd-08dcc8d83102
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8295.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:43:25.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvYey72PCzlv8MDl0GmzwOYQUva5xTs17XUXw9pAElx/QwDg7jvh11qI0fZmfnty9e5Q/+cXr/Ef0p42bEkZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332


Hi Cindy,

On 30.08.24 11:29, Cindy Lu wrote:
> On Fri, 30 Aug 2024 at 03:03, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>>
>>
>> On 29.08.24 12:00, Dragos Tatulea wrote:
>>>
>>>
>>> On 29.08.24 11:05, Cindy Lu wrote:
>>>> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 28.08.24 11:00, Cindy Lu wrote:
>>>>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>> On Wed, Aug 28, 2024 at 12:03 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>>>
>>>>>>>> When the vdpa device is configured without a specific MAC
>>>>>>>> address, the vport MAC address is used. However, this
>>>>>>>> address can be 0 which prevents the driver from properly
>>>>>>>> configuring the MPFS and breaks steering.
>>>>>>>>
>>>>>>>> The solution is to simply generate a random MAC address
>>>>>>>> when no MAC is set on the nic vport.
>>>>>>>>
>>>>>>>> Now it's possible to create a vdpa device without a
>>>>>>>> MAC address and run qemu with this device without needing
>>>>>>>> to configure an explicit MAC address.
>>>>>>>>
>>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>>
>>>>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>>>>>
>>>>>>> (Adding Cindy for double checking if it has any side effect on Qemu side)
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>> But Now there is a bug in QEMU: if the hardware MAC address does not
>>>>>> match the one in the QEMU command line, it will cause traffic loss.
>>>>>>
>>>>> Why is this a new issue in qemu? qemu in it's current state won't work
>>>>> with a different mac address that the one that is set in HW anyway.
>>>>>
>>>> this is not a new bug. We are trying to fix it because it will cause
>>>> traffic lose without any warning.
>>>> in my fix , this setting (different mac in device and Qemu) will fail
>>>> to load the VM.
>>> Which is a good thing, right? Some feedback to the user that there is
>>> a misconfig. I got bitten by this so many times... Thank you for adding it.
>>>
>>>>
>>>>>> So, Just an FYI here: if your patch merged, it may cause traffic loss.
>>>>>> and now I'm working in the fix it in qemu, the link is
>>>>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
>>>>>> The idea of this fix is
>>>>>> There are will only two acceptable situations for qemu:
>>>>>> 1. The hardware MAC address is the same as the MAC address specified
>>>>>> in the QEMU command line, and both MAC addresses are not 0.
>>>>>> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
>>>>>> command line is 0. In this situation, the hardware MAC address will
>>>>>> overwrite the QEMU command line address.
>>>>>>
>>>>> Why would this not work with this patch? This patch simply sets a MAC
>>>>> if the vport doesn't have one set. Which allows for more scenarios to
>>>>> work.
>>>>>
>>>> I do not mean your patch will not work, I just want to make some
>>>> clarify here.Your patch + my fix may cause the VM to fail to load in
>>>> some situations, and this is as expected.
>>>> Your patch is good to merge.
>>> Ack. Thank you for the clarification.
>> (Side note)
>> While looking at another issue I discovered that it's possible to
>> configure a random MAC on the mlx5_vdpa device at VM boot time if
>> device MAC configuration is implemented during during .set_config(). So
>> I was able to boot up a VM with a random MAC address coming from qemu
>> and the traffic worked with this new MAC.
>>
>> So now I'm not sure if this is just by luck or if the .set_config()
>> op should be implemented for the MAC part in our device.
>>
>> Thanks,
>> Dragos
>>
> Hi Dragos，
> For qemu part, I think this is not set from set_config()?  it should
> be from the CVQ?
I see that .set_config() is called during boot time. CVQ commands are
happening only when the MAC is configured from within the VM.

> Usually, we don't recommend using the set_config() function because
> the configuration space should be read-only for modern devices.
> 
Ack

> Now there is a bug in this part of qemu, and we plan to remove the
> code to set_config() in virtio_net_device_realize(), here is the patch
> https://lore.kernel.org/all/CACGkMEvCSKfahpBQLAMmSzdFN-QPhg5Zx+UQVrFX0HsWybZZNA@mail.gmail.com/T/
> and this is still under review
> 
Thanks for the clarification. So if I understand correctly,
there will be no way for qemu to set a random MAC address for vdpa
devices going forward. Unless it is done through the CVQ from within
the VM.


Thanks,
Dragos
