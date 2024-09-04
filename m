Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1984A3F
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429549; cv=fail; b=pmkayNXGUoWFIWBJr0hGHnojhkXsrDfoUStO+pIHs/GI2NBgNXDYQsIGQq2ejgHbqsvvD/fhOA4LmsUMMg4/29ujlxUMg34qCzmu0u7Nd/AZ/yons0XUAyzfAVMHVjzT2ZT2JsudngWf2MVr7RTzyy2yt/ijBC3hU+/ePcao6m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429549; c=relaxed/simple;
	bh=mMDLdw747mvTnCHhoedbuUBx7Oterb/on6/dWf8mV8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/pDZ6jBBgp6JBqK/09lc90xPGn8fOlSul2QIBS1NvAtLH6IRYdlzgaEulh7hZftyJTJh81pzpltVea7dn0pP67hCSy39UaB9ddskRCXQmbdhFjpgLVvg2RCgUDwhPK7Nnq8OcsBOkWNU4bhz5Yp/HAK7ltyOQqHrzP7ULYwbbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dt4ESk9K; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dt4ESk9K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oz2SwX6BjmJhNz3C6j7hT1xzv53n+14IgIG2+y/82PCNsZCkSNMUxe3NGNpF9XxOem8BqF32xNZ/IJF+v2VFGTCKD5PjWXF4Fb2cNkxqilx5VaZ+7HgcZSWZ8EI3W7DLFwNjzkPlM/Q/RwgS+ZN9xB1LaxWH/nThpyB8ZILTprHW8Nflvl9pRFjbdVAUgeUSPbnYw/BhSVvpQ6BJnHeHAXbKsaNrLZK8y2S9AV83ADoI2dLiNVslEeh8EFs2iB24rwzSl5bw+8NQXa345vUuQZWk+vb81tJWUXctJeC5yBCg0OE5zzBR+ebQLqLtHRiwuGEQ4aZldqhDzwOxSzr88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVo+62Zdk6mQUUY6Y3DyqFegGTflie7kCOZEeqnMzJU=;
 b=DDzo8sn8a1SZ5g0YcVNb3AxmQIf4iNoe6x4fFdKePsKeA9c9s0EGuL/Oss444pVjdRzo3Jl62ax8kHqhy+4WTWVyT8x3zxJEjGXrYByc/GDpq4P6LnhURvkjssYrL1YWW8UgWmp1LBc7inj0PEj2T0UhCBzUjxdjlG2zN8koUyxFHbwHG9CgvrOsDdlTMIVTcX2+SauedlBFbtJ1dDjXssfvMq28qZ0/HY29YM23r8BisGYDRzUTWGFH8QALwjZfsXgW4WBHGwDKqEeJwzBQf0r2wnB8c77Q5lkBKm/bZ2P/ev9Q1/bPP9IDg420mcXqPBdK89ucJaPDmWdMOebRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVo+62Zdk6mQUUY6Y3DyqFegGTflie7kCOZEeqnMzJU=;
 b=Dt4ESk9KfBAhUuAyb+eKwb8qPV4xBvqj0FRL3t7WfD9/3AfNkVfiWRVJle13JonaEYcWBjycqN4XIR+0qqNjIE3AC23sPb4/KDGeQwGcYce3T7EnZa7bAV5iqsiGKuiUiS74zjtaKxU0VFpxKRwUs/53iVIqywju03NuOMkhuuFV1fhj+CXFQYRYOdism4s5E96ylWGYgS5/n5ckRIMpBMIbiDL/3I3BpWHi3OeRf3okP7kaxpAfxCrNj1VLqeVdR8LWVG7fFZxvTzobjPwnxj2LiyNX41qtozNiLLnelvWiHKBKIfywVNip8fxPtz67u0AsVoG14C+4gqe5XDVUbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 05:59:02 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 05:59:02 +0000
Message-ID: <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
Date: Wed, 4 Sep 2024 07:58:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec
 compliance
To: Jason Wang <jasowang@redhat.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: mst@redhat.com, shannon.nelson@amd.com, sashal@kernel.org,
 alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr,
 steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com,
 johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Carlos Bilbao <cbilbao@digitalocean.com>
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com>
 <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d44c122-87fc-40ea-a9d2-08dccca6ad0e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bWY2bEtNMWJiKzhlUnVDbGttZnFBUC9hMzYxcm9rSzAzNS9BdEJSSmI0UURN?=
 =?utf-8?B?SVRqdUxhOUVFUVNubTJkOGljT0pveGlJSk1KZkRYYTNyV3NZYW5kamRENGk2?=
 =?utf-8?B?UHZQWTB2dGFnRnJnaVhiK1NRd2hQZFV0elZSOUtWL1dzckg5RVhGWE1CUmlH?=
 =?utf-8?B?dFFOSWFsYTVKQ25xQ3R4VTdSVkRwcUdkazdaZkFkQ1ZEdU5DeUx6THRXV2lH?=
 =?utf-8?B?YkRkUGUreXpkN0sxUXpid25INHhYSmJmb2xvN3lsRnNJTTFzN2oyR05PdHJJ?=
 =?utf-8?B?aTkxTy8rTnVUUThwbGtSVUxKa09sWTZoVTRMVUFYRS8xRE1sVmp0Nld6Ync0?=
 =?utf-8?B?eUpTc2FNN3BIaEFBWGxDcEZSTkJiK0REN0dzWC9TcVUxeHdEUjFpL1BObVJj?=
 =?utf-8?B?RVV4UFRtaTNERVBDMU91Q2twVFNSaW9WZUUvOEh5ZmNVOE1XTHZmaThKT3NF?=
 =?utf-8?B?STBrWnpYMnFNcEJWaHZ1QW40aVNRR0hBTUNpTFRNZHlJanZueVYrbTRibDFw?=
 =?utf-8?B?RlhvWmQwYVZjaG9JcDVueU9MLzJHNmR6bzE1UnBJUnhDNmwzTWxqT0pITzdj?=
 =?utf-8?B?cko0U0t2M0hwU0hnTDI1MGczTTBTdnB0U0FYTGF3d3huMENPTFloem1tQnZi?=
 =?utf-8?B?c0tzOG5la1Q0TEJpN3RVVThIU1MvTzBTdmRTMDhFeXFFZTRFZ0psM2ZqODV4?=
 =?utf-8?B?ZTRLZVlZdldXUnhWYnR4ZVpkMTIyemZZUGVaZ1JyeWJERkhsdjJ3eDNnemNN?=
 =?utf-8?B?dHFxekpZZklxd0l1NFY1R0pkZUU3MFcxa2Npek9lZ052SnZzQXcxV2FwWFNj?=
 =?utf-8?B?RHh2VFdtdVhqeVlyR2pxYTZ0KzJzVXpnRjlaZlQ2b2MrL2RsVjhBMG1DSmU2?=
 =?utf-8?B?dFhYdnB0WGpkbHN6MnU2VmlZOTAwUTlyMS9nVVBvSCs1dS9jUkNMajQyMTl3?=
 =?utf-8?B?UWxSZnpVKy9QUDhXdzJwZ0FvemZ2Wm9Udk1HQndJRDB3Z09pVDU2ZENDTXdw?=
 =?utf-8?B?U0U4bXBudVdhVDhpZ21QNXdoVmdSb1llNVp0NXZySW5tUjRFWHBCSGpVUEZ3?=
 =?utf-8?B?eWVwUmo5T0lRYVE3cWo3WHU4Z0hzWU0yZ2owRGw4VjBIYnNOazlJYjl4UEpw?=
 =?utf-8?B?QVRJZGgvUzRGR2JvTU9KdXhid3ZrVGdYVE9sL3FHaGFoY05CUUF3VFppRHZS?=
 =?utf-8?B?OURyQjdVcERJdndBU3VJT1prbVZmNUk2L2xNemR1UnJqY0c0U3JERWtValJJ?=
 =?utf-8?B?OGFFOTh0WXNSVVVWSlVndWx6QllGV0xuVDhmLzBPNnYyZjN2ME9KTGU4UkFo?=
 =?utf-8?B?TERGT00wa1FlT282MUtjcXlNZmM2WkIwRnRXa2FNRW9xT1VHaTBUaVBlVGxC?=
 =?utf-8?B?QWVHZmFWeU1rRitYdkRxSDBSQ0IweDZQNnUvanVYWDN3emx3T3J1UnFVbUY1?=
 =?utf-8?B?MG1hQWxVK3lqVURINE9WL1dmZWxzUmR4bU1Ga1pQV3NwMTA0NS92aEdWY3pt?=
 =?utf-8?B?cFplOVVXdFYzMGUzTWl4dnI5VmYxeW4wZFRSczI0MUJRMHBTOERjdGl2WGJD?=
 =?utf-8?B?VWY1RVpLaGJ3L2YzaEhiczJPSTFBamgwTVQ3ejVkUGFJWFJ4bVFKR3FLN1Vs?=
 =?utf-8?B?eURlVlIwRitzanNmb1FhZlNDQTZMOEorT2lEcDFDZzlwN3JVOE1wb25iY2lo?=
 =?utf-8?B?b010Q2FIM3RoOGdNbVZMUHhmOWMxc1lrZDR1SFFzTUxSK1huYmJjdllRTUlQ?=
 =?utf-8?B?MUdvcFhOZlpRbWk3TjBwalJXazQ3bi9ZNm81V0NZQ2o5bzdDOUo1elpRaERl?=
 =?utf-8?B?VlRBVXk5Z0Q4eHh5Znp2Zz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dCtRZFA4QWlvMDFOS3RvMEwyRmZrMnhCL1M2a3EzaXVDZVNxKzRTeHQ0SVNr?=
 =?utf-8?B?UjVhQnJrQWpsNysrYTlqQ1Fnb2k4K21meVY0ZnphMEJRWnYzYVJYOWExRnI1?=
 =?utf-8?B?ODJuZlYyT25RQ0FueFRZT1BPaWRLU0gyaHBYSEc0bUNNaUZtbTcrNituNDlS?=
 =?utf-8?B?Nm5rZlBmZWV1dnRJdE1yS0FNU0dPQWlsdXdkZ0RqS0JsejNFZkJ3L05kenN4?=
 =?utf-8?B?SHVTN1BEeUNUN0o2SWNWTWRrYThkL2d5NFF1U3pjbWs3eDQ0WEUzckxVT2hU?=
 =?utf-8?B?ejFSVzcxcWs0YnN0dW1vKzkzcC81TjFKdHc3ajY2emhtSnhsR2VrTVJDTWNw?=
 =?utf-8?B?WG1ySHp6ZUQxbFJSSCs4dDQxc2dwK3psaGIxeE9tcHl2VmVLN2dpS2x2cXNY?=
 =?utf-8?B?UWJMSkJhcW5UdE5FQTczUFhmNDBoMjltaCtnbVRZeTgrd2VtV0RKYk5oY3JJ?=
 =?utf-8?B?aGc0TmxxOW5XaWRueHd3TmVwUDhHQkl3QUwxR3JXRm80VEd0ZFY5N0xNQngy?=
 =?utf-8?B?bnJJZEk3UzdIdFV5eUpxbWZnQ0V3NEJ5NHpLRERqQTFnaVhzUjhmVmpxaUdV?=
 =?utf-8?B?RTllVlNtRUdjQWp2K2FLRXFyUzlJZGlxS2JzbzEzQ2dBRGFma0lTTEcybm1Y?=
 =?utf-8?B?ZS8yZlhKQjZpZGNFTVV5RXptSjVSSHlhcm5OVisvTTRETFc0VnFlVFZiT3lT?=
 =?utf-8?B?alp0N0JIazFLQUx5ZWdRZVN6RDJuWDNkRnVVaExaM0ZQTEJGUklISzZXekgw?=
 =?utf-8?B?N3ZkSVJnUkxnQXUybURxUkhoQ3lMOUZzQzZ2MFF3QW5IbWJsTVNFSFdFSktw?=
 =?utf-8?B?dmU3TTBKbjJmWGRtbldJL0cxWmd5YkdXUXJpVitHaklhM2k1UFZvQnU2YzRB?=
 =?utf-8?B?N0FrdFpzQjgzZ0h6emJkNGpibS9tclV2YTJWYm9VbVE5aThCSlJWZWRGTnd5?=
 =?utf-8?B?T1UyMnNPRWp1YnVwTTRUdHN0dU9wNzVDOC9CYytJME5VYXlZQjdhTXBiUCs4?=
 =?utf-8?B?bTYvaFhqQVBqb0UrclVlaU9COHp3VWJKQk42OXZQYlpUWVI4NkpURDNmM2FY?=
 =?utf-8?B?QjNhOWZxNXhtWkUrNktHbzhDVlpyYVVMMXloMERDZkUrSW1xdTVFenF6MndR?=
 =?utf-8?B?QThwZFlPWXVBeXRob3FaMUhva0NnZ1doSVJLL1ZTZmd1WXFtc1c0aldFdmRh?=
 =?utf-8?B?U0ppNTRQcFdVb0MxN3pLYjZ3dnRPT2V0Z0VpMk55KzBiT0hQQXpuTm9DdmFG?=
 =?utf-8?B?WXhrTHF5alZlOGExVnpBYUZZcmpZeTA2RDBIYlJhQlZaWDR0ME1rc3NOL056?=
 =?utf-8?B?RWFhTXRnNmQvL25xVjYxSVBiYm5sR2hjaE5tejEybzhOS1puQUhoblhyTUZP?=
 =?utf-8?B?ZXgyRzBiakdUT1ZjRS9LSnhBM2xxVVlNaWhRSk93djc5VGNmWEJ4dEthRDRw?=
 =?utf-8?B?NVVNZHZYNHV5c1J0N0h3Tng4ck9CL25NSmVsQkZLVG9KMGEzN1VrNWpSbDFS?=
 =?utf-8?B?ek91WHJPcjMzUWZydXF1a2xFNjFwOE05V3A2TXhvZDhHVmxZb2J4M1ZWbVo4?=
 =?utf-8?B?RXhvSGNWcEhtNzJodDBDY044TnJiYjFTbEdabmN1YnM0bGhKSko1a1VEb05y?=
 =?utf-8?B?dENZcEpLR01LbjRRcUFOeVRUMmFVZFRLeGxuS3BmRWY0UVUyaFVvU3IxenVB?=
 =?utf-8?B?enZqazZKZUd1QmhZOEhUaHhIdVVQUGF2SjgrYm1qd2F0UVUzdHdqRmtObTZE?=
 =?utf-8?B?ekR4dUw1b29jY2FiVUpWelV2eEN5VlNsWmRDSVJWS01HRVUvUzc5S3pac3hw?=
 =?utf-8?B?MlhVT1Z6RFhOZURvUnJlcklxWDc2YldZNDJvM3dlKyttcU1WTVZiRHBCTUlS?=
 =?utf-8?B?YVFoNXRUbW5nK2dRSDNKTUJyanpPWjlGSFR0aXpJYm5JSk5yNXM4bDlOeEY0?=
 =?utf-8?B?cEpCdlNsWFNkU2dURHlyUUVIZklraXJFWDAveDcvZ0xlZnJCNzJHc0xTRURw?=
 =?utf-8?B?WlM3djF5eEhOTGxTRC9UQ0RmNjIrS2hzNForUnd1UUs5S1h1TERRTWxXeXU5?=
 =?utf-8?B?R1pmdElqMy9oZklXcVBKVzY4dEhnK0NOcmZodmgvRFFCYmdwSXJwdDZnZGZw?=
 =?utf-8?Q?VLymvzuoyAvyyGSfmmLPEEUfZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d44c122-87fc-40ea-a9d2-08dccca6ad0e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 05:59:02.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBbuvoMryaBsLx3eKxla3RwVsoSjJvNzy4VK4l9iuO3xxRgdyTBfS/yCbYFToWKEssgIE/Y390EG+iC2PR3ONw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180



On 04.09.24 05:38, Jason Wang wrote:
> On Wed, Sep 4, 2024 at 1:15 AM Carlos Bilbao
> <carlos.bilbao.osdev@gmail.com> wrote:
>>
>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>
>> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations
>> with vdpa_config_ops->set_config(). This is needed per virtio spec
>> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the device
>> configuration fields are read-only for the driver."
>>
>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> Note that only the config space of the modern device is read only. So
> it should be fine to remove vp_vdpa which only works for modern
> devices.
Just out of curiosity: how will this work for devices that are not
v1.3 compliant but are v1.2 compliant? Or is this true of all devices
except eni?

Thanks,
Dragos
> 
> And for eni, it is a legacy only device, so we should not move the
> set_config there.
> 
> For the rest, we need the acks for those maintainers.
> 
> Thanks
> 

