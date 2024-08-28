Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9E157481
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831618; cv=fail; b=JUlOH8WaPMNW8PvmXkLJHBxgRWOeIE2WWL0COZr7VdZQ0ECEtEC8FY4jAtmpcl45gQQ9cfikBqxfTF1kh7YyvqdptZb+WGN94MkSi/z0vzRuQLI/p5BXFZgHeiowML7kXPNsTugDDEivW/Zwi/tgmEeH6JxQSi2nJMaaUKOstso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831618; c=relaxed/simple;
	bh=0NJzjVClq1FrOROHenITyRSBrfmHqnYahfZOX2LfdTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T3sfVS9USKmmJUrNnO1CQDyi8F6n7hekCz1RcaFx0r6YcVnTkHSimfyfKNWsrHAHeJYCF+qAMk/nZR3d3AfbaFy/VHH0oZ2/JYmuVZbjZA304g0Y6V0lHwPKkVakfCrVPk0mG27GDZ6NNT2II4BoMx5s8TbTq+6NZm6p5MDky/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H4cGLdcW; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H4cGLdcW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVZRFMzEYtF9gqsfYCrbaHb6Ad+uXjJ/zd6E/2U93/vNwI3S/BD2rJSfCFreyZhvPyLa2SX6R2ssKLJKgBwxQmV9msKADWi7GNkeGJJAiUwMKI8neumJKdhjjWvux3CM9rYWk4b7JPirQJjsbWXopTJBzJ5oBZIQZX2aGvCUH2hxr094OcIERLJHSk+B/wbLubne5EOd9RBvDhyGjNGrU+lTXfMQ5u9wr0nEudRWziVfGNuUr1CuK8Kv8QvVxuA4J1pAcz7wL5sI7FJd9mUhinKXllL0sHe+ifMRfIGhQcpv4wpeU6mM5w8Ukf1cRXaCvMdhL9NR2uSHpk9MDvGkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WcsrfS0NeebK8sp/gMeI7MC6TuzBZVFFtJ1FxuUmZI=;
 b=NsekyGJRbfZ4/AaSiYQUBT1N7ILb6+WNx0DS/8LYWY+W+HaHparNGqzFtIKW33RXG641m96Q09+5EnXJBJXuKf6/pcKAGnAkukwB0CpHIDxZh/bieqatgbYQDJrGlvo0VzIlMlLlARdph4nSklWpec2BeGeIEqnfCBcxGQ2pi9v6XQhZZgGLTZDLHxhinTZ2vMhfTPABqlcz+KbgU5MAedbic3HiZ5uTl+3IqsZyTV2IKlsR2jOPqWGp48c5tTmV0bWwf4IzBh4ZASqI/7opCLuJJjX3GY8d1Uxdg3QD2eeYVS4k+FQvVLyV8IHsKGCeUkRvHaGt8hkw5V3sFG0RjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WcsrfS0NeebK8sp/gMeI7MC6TuzBZVFFtJ1FxuUmZI=;
 b=H4cGLdcWwJd6p6ZnTfyTjQezVUrUUHAVtmgBr73C2q5FPM4nH8gqDd8hfokw+tHYvj+YC8NdT0iife+NDPGco1PuXAUciiVpmlvCLyJW9o+dtigRI49yW08J4s9BgSfHdH7SJd4T9TG0boUAvnX1EoEhYp1wkyURsvE2bYaDRk4Yvx6KiJMq+hHue7UPHpZ43p8CCibEOF4VybxTjlYEeZo0FzEzZtt93E6reYbyS80vW7bzi12/TDwcuZBiwuBjAmDMRr4KeEYZDXKCOMYe4FxHw34sGzaq3pMjoh4Ke3poeYzb5CcNnA6BJfZDbBqfXo1IOKgRvOxMcPwgRDZhVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 07:53:33 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 07:53:33 +0000
Message-ID: <5b99338f-56f7-492c-8a85-520badc28518@nvidia.com>
Date: Wed, 28 Aug 2024 09:53:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
To: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
 <3d9509c2-f052-be94-db9b-ef501c880415@oracle.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <3d9509c2-f052-be94-db9b-ef501c880415@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: af7d33de-a74c-4811-488a-08dcc736839b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG93akRTN21lUVVOQ3RjQktDRFBlSG5VUy9xbHNPOWliQTYxMkl2M0hjbGpo?=
 =?utf-8?B?SFBQSGt0cTJHbmxXTjRyRHJ2dDlVTHlKanJ4MWxXVVRIZEhHQ0NuT0ZiWUJq?=
 =?utf-8?B?Qk4zTWdaRHVBRWR3L0VFeVc3RjFnY0tVbloxakFPRzYyRVk4QUNWcjN4bDRz?=
 =?utf-8?B?NUtqMFpsOEorcklMQzVYdnZ4MHoyUWlRS3JobWE3YWxlait4QmhhUXJkQW9q?=
 =?utf-8?B?Tm1KTGVYSDB3ZGNWTnl5V3BoTXpvQUZLamxkMllnRGZMMHhtK2VHc3lseW9l?=
 =?utf-8?B?K3M5UUY4TzBLYWJVM2N1ejlMelF2Sk92TmVnMENRYWhMV2RhN0ovNjV3ck5Y?=
 =?utf-8?B?MW15NTRSMDg1NzBCSFBhYitheVJHYjZTT3lCdzREVmpqR3dCbjJ4NkNzK3Jx?=
 =?utf-8?B?SWN2TFhMODBjaUI4dmlka3FxeHAvcFdsYTZxZ0lqc0dYTmREWEN2UW9FL1pT?=
 =?utf-8?B?Ny9mOGxwbStRcDFHZS9QRXEvSkE4Nks3dGpsbjBZaGZhWGI5ZFUwWndud3ZL?=
 =?utf-8?B?SElKVWUrVWxraW0vQnk4amthK3Y1cDBRVURXSFRSQThkdXhEOWowUDJYdndQ?=
 =?utf-8?B?UFpTNnRMcW8wUTJJTU96S0xEYWJVd29lKzUybHZReWQzWTdCRmhpMzhQb1pN?=
 =?utf-8?B?N2l0MDloa1E4bmxXeUtYWm5UWFp2YUJabW04c2wvVWZDdGpLOVpNeU1yOE1m?=
 =?utf-8?B?L3V1NnBwTWYrS1lPYXJFMnJMZlp0Y0NoaEtwOTUvMDJYV1JDWXU2UDRyR3J0?=
 =?utf-8?B?VHNOK1FGcXFEWEJpbXo3QXNaMTBlejRmcmlRSmdzbU5aL3I5MkVWMnExRXd6?=
 =?utf-8?B?cW1pZHhrdHdKU2ZENHMzajYrcWNhSlR5anBNVHFLYkU0Y2UycStLSHpPN0NV?=
 =?utf-8?B?KzlGQkhocVdZdCtVeUE0ek5GSUxiK3Btbm5pTTdaeUJyZTRWb21LNlNPY3dy?=
 =?utf-8?B?bHRhdUkwZjdVb0dqY2RGSzJtWlNURFl6R3ZUNG9NUGE0ZTQvRVFCRWpmcjV4?=
 =?utf-8?B?T0FxVW5TNEwxWkVRbnpzUDVpSjlLdWM3WklBaUZNZ1hDUVFRNmpsUlBqVHJJ?=
 =?utf-8?B?UWxmRkVOWGRZZytZQjBJY3FyQW80RjdxQ2t5dGZsMmk5b3paWExGY3JiZU40?=
 =?utf-8?B?ZVpmeFRYTUtZU0JpRURjeEphU1ZCYjB5MGdtRlVKRXlubVpNaXhVZC81Y0dC?=
 =?utf-8?B?bXRVcE1DRDZnUm83OWhvNnNLY1RLSGg5eDRNYjlhZjMvVkljcHRuS1hmV1lp?=
 =?utf-8?B?cEh4eFNqOUk0a0Y3U2tWWXVPTHJvT3A5V0dRU3lsaHpnb0FWVXFQNXZQK2gx?=
 =?utf-8?B?dTlyalZBR2J4VnB0QzFMUGRxanEvcFA3a0IrRnZNMFl3VkpLc1liTEJ3QU1Y?=
 =?utf-8?B?TFNWaW93azN3aDAzYTNNSzAxSi91TEFGZHI0dEZMcExZRktVeFJORTBabWIy?=
 =?utf-8?B?T1ZuSXQwSWRnSG8xRmdubGZJbENaTFFQNXQraVlDS2x3dXM4SlF5Mk92OVRK?=
 =?utf-8?B?Y3Q5OXcrb0dUM3J1bXpDMVpycTJEWkpTczZGaW9JdkwzcGt0LzNuc3ozMGlG?=
 =?utf-8?B?VzVKZFY2dkxIUVFyRkZUbzJWN1ZMcVNxUE9CTEhxYlF0TXhoUlBrMHNlcHRw?=
 =?utf-8?B?RWlwUlhJb0lvMjJlVGFRYTV5L1hOMC9TNDFiRDdLOHpHMlMvUmg3OW15bE9t?=
 =?utf-8?B?N3pTTE13K0lRQVo3Tnd5OXJuM3J6MkZNeXhlZzFERG1mMzJEaHVkUzZMOU0y?=
 =?utf-8?B?VjBoVzJha2RyNEdhQ1ZEZTRKYlA3dE5MaDJrMXcrOWExUzl5aXdhdEdrQVUw?=
 =?utf-8?B?QzByTVlXSGh2OWZXUkpzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk9QV0NwdnUyTmtEd29VUFFkMTVQTGFGNGtEZk4zZnJiVkxiaWNoZFM2blVh?=
 =?utf-8?B?UVVrUFpFSU9XZjVyaUVHZnc2RVJmU3ppc2JWQTVLYjZnaThTZng0VWE5VGl6?=
 =?utf-8?B?M1p4TFRYS0hyZUhXTEhJM0pUcmZkZy92ZkducHB1RmNQMnh3bnFsWGRlMWhY?=
 =?utf-8?B?aUw1akExaTBMbkkxYy9wSkd4TCtpK0pqNXprM2RzRmxhWHZrdFo2ZUV2aHZl?=
 =?utf-8?B?NTFXSi9zVzc3NFNkcGJSdnFGNVlqRHBRUno4a1hpQ1JqaXBSbXA0bVFsODRi?=
 =?utf-8?B?aXJmSUVwVEJBSVVhQ09nRmhDUVU3SG9CaWh3djJuVEhQQjQxTFBseG9KMHN1?=
 =?utf-8?B?eWZUK2h0UEpMd0JmQjNCa2xYL2JkY0dja0FXekdGUkwyc2hSRkNTWmVOci83?=
 =?utf-8?B?c2lrSmQxdFlHSGlJTlMyTXNzdCs1ekJWWmx0YU9PTUQ5ZFdvQ1h2SCtkYklx?=
 =?utf-8?B?elA5MmZ2Y2t0bm1QY21JZjJtS3VlMC9vQ293bDdZRFNibDlNTVdCajF0WW5X?=
 =?utf-8?B?YlhFRm9OT2d3bVVmR3U2SHZyOWJwaXVQbjBKR0RvcGkyOU1meW1KYlVDYXJu?=
 =?utf-8?B?TVZYRiswa0lRdWJuSDZpYzdGYlVGOExsYmt0LzhHR085L1IvM0xPaWlwZTEx?=
 =?utf-8?B?RE1rM00rb3NkK0RZLzRseGp1aERkYndOTkhVTTFjeGFKb2V5OWhpWUw3dmdv?=
 =?utf-8?B?UlhRaWM3ZUpWNUR2eklyMnBNWkRpRE9kZUMrYVFNNS9CWVFzUm84TERFbmNh?=
 =?utf-8?B?dnhRMFlmWDJrbDZyc2dRZldlOHBXUStGbDZ1aXBMQXRuU1NwR2hPaWMvOEtG?=
 =?utf-8?B?akxwVmZKdHphZ01WUlM2MDZac0Z5bG95L0oyL1pkUXBic0pPb3lVWStySEZQ?=
 =?utf-8?B?QnVJYjRFblF1SEdERXE0blUzdDMxT2wwckpnRVg4T1pvWXFSQlRNb2dwR1BR?=
 =?utf-8?B?OGVpejBpQTY3Wm1PdWEvblorb2gzOUtiWDFaazlXdUZ3eXkzQUNxUWxRVjg1?=
 =?utf-8?B?b0IzTC9CZUpBNFZJYnNRRjB2U3lOSnVydXFQS3JhS050SmhaSHNmUDM3V2xI?=
 =?utf-8?B?OFJ0bVlSckdyaG5uMFRnM3NxRWpINVg4Z2RKdkhSVUNEeENtb2RTOGpLRjc1?=
 =?utf-8?B?RnNSeTErZmFlK0JCd3duRmFsSVhiUkNBVUNMdTROVk94Vk9DVFd3QlF1MWhr?=
 =?utf-8?B?d3l2VTBsZ2RoQ2sxcG1NSHd3clY5UkhFdE5TVGZ6dzRVNUw0NjNrYUhtT1M2?=
 =?utf-8?B?VWxMdkVjQnVkT2lSTXc1OE11dDRxamhldmt0MkpsZFdFRE9NM0NEQjErenVy?=
 =?utf-8?B?QW5Dc2VOR3J4Mlo0WnN1cGs5MGdZTHdQajVwYkl6WW5FcXFwbW5SWTEwN2M1?=
 =?utf-8?B?NmNJQ3lFeGM3NHFEeUpza1JQUElRV3o2MktFUWFxeG05UVUwU3VFMUhWdnps?=
 =?utf-8?B?akpTMTh2bEhQbk9BT3NiSEFUY1REcmZSQjR5THl6MWNkTkJOYnlFcjlBNXdk?=
 =?utf-8?B?YnNxQWpQekFoa3ZiWXVLbWdERXN5eG9ucjRIcDFBY0hYMVhVbnJ6aXVMb2xV?=
 =?utf-8?B?OG9OMDM1YktLY1J6cFVTSGdvbkJTdVd2d2JvRVJJdEg3Q3BDQkw3S3EwallR?=
 =?utf-8?B?dWw2Y2c0RnFEN1VVdWNyYW9oVmJ6aVBFRUhEZ2pvVkp6aEVQOTN0R2dtMFd1?=
 =?utf-8?B?T3hxNHd3VWEvMGM4S3l4UVlzSkJXa09Tb3VlNG1JV0NtNXRWUDdYVW1EUWZO?=
 =?utf-8?B?ZUhCZmR4WTdMenNsTTJ3MGMveVlUU1BVYS9UK0FIN2xaTVdvU3R5dndvZ2JT?=
 =?utf-8?B?eGNjZzdEYTZvTmNodzBjVlU1NlJkZFJsMWtLeUR0NzQzM0RuczM4N1pFa0ZT?=
 =?utf-8?B?cm9OYmNQSUJyUUt0NkpCV1VMbXZ4NnZJamx2a0IvTXlubTJhYVBtcGdMUVp2?=
 =?utf-8?B?NTl3dkhvblNIZ1VCQ01jWnlYYVFJajlJOSs0Nlp6dS9OaCsza29xcWRzZDB1?=
 =?utf-8?B?aEQvb0hLbGZWZWRzc1h3TUoxMVF6M2JsQW8rK2VOSHRmN1dsSWhtQW5IY3Mv?=
 =?utf-8?B?cDJoa3NETEJVUUZIeHA2T2NjWnFablg2YThsb3MvTnN4YTJLTTlpWWhLMjY1?=
 =?utf-8?Q?enGGWsOUClkgpWRQ+VggGZLPK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7d33de-a74c-4811-488a-08dcc736839b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 07:53:33.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLMqWIlJSxE4ao1RXYUoOqD5EbKpdFEyW5x/8xWoNwlMzU7zZQGpm+hXZZSWTtJfAxTjuFcN3jupPh09MyluQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629



On 28.08.24 07:54, Si-Wei Liu wrote:
> 
> 
> On 8/27/2024 9:02 AM, Dragos Tatulea wrote:
>> When the vdpa device is configured without a specific MAC
>> address, the vport MAC address is used. However, this
>> address can be 0 which prevents the driver from properly
>> configuring the MPFS and breaks steering.
>>
>> The solution is to simply generate a random MAC address
>> when no MAC is set on the nic vport.
>>
>> Now it's possible to create a vdpa device without a
>> MAC address and run qemu with this device without needing
>> to configure an explicit MAC address.
>>
>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index fa78e8288ebb..1c26139d02fe 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>           err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
>>           if (err)
>>               goto err_alloc;
>> +
>> +        if (is_zero_ether_addr(config->mac))
>> +            eth_random_addr(config->mac);
> I wonder with this change we no longer honor the historical behaviour to retain the zero mac address and clear the _F_MAC bit, should we head to remove the below logic? It looks to me below would become dead code effectively.
> 
It is still possible to create a vdpa device with a zero mac address
explicitly, right? 

>         } else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) == 0) {
>                 /*
>                  * We used to clear _F_MAC feature bit if seeing
>                  * zero mac address when device features are not
>                  * specifically provisioned. Keep the behaviour
>                  * so old scripts do not break.
>                  */
>                 device_features &= ~BIT_ULL(VIRTIO_NET_F_MAC);
> 
> If we are not going to honor old behaviour any more, looks to me we should also block users from creating vdpa device with zero mac address, if the mac attribute is specified. There's more sorrow than help the zero mac address could buy for users.
That makes sense. There is a small risk of breaking user's scripts that
do this by accident...

Thanks,
Dragos
