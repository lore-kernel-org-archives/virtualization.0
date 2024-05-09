Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA013BC3B
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715223779; cv=fail; b=iSKe935OdE/TwoelQzAdjhCq8n5F65eBTmSEja482MbUjtKhluBnOPLIGs5MRa7e4XC8mRTgoCAb5ssqRcs5hOvaiRX3RJct5fWD8g+Fd4CjIIh3GIzR/Vbt8FX+4amQqwnm3Hu1lLizYnWcciwZot2Tl4PpYBs+RL96bwNmnSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715223779; c=relaxed/simple;
	bh=Thzte9NrIIRa0qtLnEiwYDDMKBl6zbSrdAZdgbF/0Oc=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=EQykc7d7HhWUoQSkIz7CJgQKyQr4iEqZ3cRgGppOq56T5H2BPyfNgUx/5KeyTq5Y+qSA8dYBGVH/X12Z3dLckRFF/W3KxzL9/06xJHTraTU7sa9+TOOROuBBaYWCFKPTprIrkAVQdLpe4x6HaTXrPb74F2w0+rBJElAqUGBeqbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lPgULtjt; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lPgULtjt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhlvQotciwC8KMTmPWKJnIAEFjhh1hNuiZVkSvstD8mvJzLd7I+CDOSgBVdyScWq0cPBln1dcwnPijDdCmzopbtc6pjq/l9WvceJaWxIarw0+GCZW7U3kVhohLtJ5DOw7ubWKipA2i3N38IvanyuneU/HgNjolFLAShi+UAARsCtm+RJ9cnMvKCFt03X8x7/N0wvfBV6UlzM0CyInMtw2Jb28JgFfq5l4hF+GpN7huaxCZQfKhNZoGU8cuwpmj0bWueWOYAz8RRZNBshMrRrlM0wK1SE726KbhXOzQdAC3C/9LcEyatbSGM5uxJs503JdTH5GG2pH0pehGxNwtTnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jijyws5qW5VFGLU2wFVkB4bA+F4pa0lxDeBa1ekE0LQ=;
 b=MBwphmnkw5tg72nc36vOUthUHA/TeIni3tFBe3LuLe43uQzNTBDc/BsKoE9YQ9LMZvEaOm5zA3bBTZQjcsNI6KxRWA7U1/6XSseUjalhwZlMwlocVtxT7EhXnhhTdm9TJimj//WhC3Cm+qmHSIsaPkCEg7ONPajRqt82hiJsRtrTqYRiREHFdDvkNGnoGuPeNyX+KJ+XNWUkmWcgXqKeBRxdMj6vyctLoAy6MpxQcJYKQO8JVj68efzr53qSBM4krgm4i/TqtcjeV8RFMzMi5ZqzgKwJNrMF4JqnZj6gPiieXnTy+S7p/yflizunUdSajfYU1O1P21LxaVf9kioVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jijyws5qW5VFGLU2wFVkB4bA+F4pa0lxDeBa1ekE0LQ=;
 b=lPgULtjtn3CphKEBE6T/iioQysDDBX4N5a6nenBhv1gHL9eiqtvqIf/BJCs0/IS0VDoXT/RDR2iYam4di/TLT5dtt9KzRiPBaR9+qm00XI86tCTX3YvIyraUQm3eGgsBK5Lw2nwNNbLBI6Es8zmWLtun2IMA/UTyPhae7J+x+/FRmg7Kir0+JfNm25rBhG1NS+ZUpq9AbA/61gNUxNoJMHmjiwJaeld0xJxF79kY0KV7fND835MGNxUVlBdHs0aqHdLla4uVOqhg2VXxOMBxK9/TRSLC8iQUuIOwk5Kb2VshwwKjmBWYD+d1rOoe83jsnOime70DM+Jo0LBBQVoyZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 03:02:53 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::fcbe:3ee4:b993:a553]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::fcbe:3ee4:b993:a553%5]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 03:02:53 +0000
Content-Type: multipart/mixed; boundary="------------3QNAbrje8VcHyN7JCPv0ymrC"
Message-ID: <8f771516-86f3-6724-7b2c-22cc23933075@nvidia.com>
Date: Wed, 8 May 2024 23:02:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [REGRESSION][v6.8-rc1] virtio-pci: Introduce admin virtqueue
To: Catherine Redfield <catherine.redfield@canonical.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>, parav@nvidia.com,
 jiri@nvidia.com, mst@redhat.com, yishaih@nvidia.com,
 alex.williamson@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Francis Ginther <francis.ginther@canonical.com>,
 John Cabaj <john.cabaj@canonical.com>,
 Ankush Pathak <ankush.pathak@canonical.com>,
 Chlo Smith <chloe.smith@canonical.com>
References: <13a313c7-c214-4d49-9029-c79b503c17dd@canonical.com>
 <CACGkMEtZEeObDxcVBnvczLFGm1=13=tz_4mJGeXMw+4JgGWRpA@mail.gmail.com>
 <CAFRRCvN7YYF2wT2OaXQdL8q4yvC2_kFuf3D6+jXHOZwbQ0bF9g@mail.gmail.com>
From: Feng Liu <feliu@nvidia.com>
In-Reply-To: <CAFRRCvN7YYF2wT2OaXQdL8q4yvC2_kFuf3D6+jXHOZwbQ0bF9g@mail.gmail.com>
X-ClientProxiedBy: SA9PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:806:24::10) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f719fb0-57dc-4efd-30e8-08dc6fd4850d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjRTY0dEVXVPYWZaR2dWVnEzREo5NVNlWDVqQmFIR1dJaTZWYU9IQzZJYVB5?=
 =?utf-8?B?WUlKOERxSVhSZno0NUQxNmpQM3B3ME9CM3U5azNzMkZiSTlRQ0ZocXRJSWlU?=
 =?utf-8?B?L1RzbWgxZm5nZjBkWnBYV3Z6VXBLMzlDY0FQSFVuaUlWbUQ4NmZpTW5BTUJG?=
 =?utf-8?B?Um1weDlVUSsxZU05bmR0Ri95KytmZU8vdElLQnBNU3ZwNjZUUWQrMmV2d1Vl?=
 =?utf-8?B?bXhVQ2tvdWZEcXd3ZEdTZzdDa1NJODk4R2huViswR015UC9BOWRGeHhoV0R4?=
 =?utf-8?B?RzFRdHRLcWNqdTN4MkRkaFlmcElVR0pLcXJ3QzB0Q3ZVMFA1dk40YXloTjJi?=
 =?utf-8?B?VVVtaXhJbEN0SUdTUHdZTVdDQzlHb3BGa1dMNXN1MnRZczVJMjFvNjI4dWVq?=
 =?utf-8?B?K1ZjVHp1aEMxU1dPSitpTjlGeTh0OFo4c1RWdWU2RTUwRVhkTW1mZElQdzdE?=
 =?utf-8?B?MlhxR3JOQnpvUXdrWkJPVExBN3Yyd3FEanFtUXFFQngyVXZDNzE2ODc4eHZa?=
 =?utf-8?B?eU5BSUU1cFllTHNsdksvejhxUW9BME9DRVNwenNuYWlwUU0wU2ROUUNkNUFI?=
 =?utf-8?B?Q1g2TFA4VEQvcUM5OW9vMml6MGIzZFRUWmR0UDJBZTFFMEZxeXJqV05BUCtQ?=
 =?utf-8?B?azJTWVlpaEZJZmVOb3cxam9MQ1RUdXhIVnNkQWEzenlya3J6WExGcFdnOFEr?=
 =?utf-8?B?NmhHY212T3M1a01hUit2MEhFclc4YWRUYXZzNStVb3EyRkJURGJCYk83a1Jx?=
 =?utf-8?B?NlpoYmNua1QybFZvRzRad3RsbGcrbnU4eTArc1pMMWt0WG8vN0k5VzljaFA5?=
 =?utf-8?B?VTJFUFVUODcwbW9DaUhsUjdWamtuUFhMWHlKVENTcFc0aEc2VDJTQnYyaDRn?=
 =?utf-8?B?K0VjeHF0VlNkWFdKSFIvMUZERGZJTzVsTFREWFhRZUFxcUFMdDV4Ylg0SkVw?=
 =?utf-8?B?UmhYZlFFN3Nqa0s4N0llRGZjelI5Yld3L3g4UzhlOTB2RHZmeE1JZ1ZZczBV?=
 =?utf-8?B?Ny9LWmxFRUtyemhmRWxuVTRkamVrQWlGYmVYVUdicVBPMmJMN1c0MDljR0ZZ?=
 =?utf-8?B?ZlpzNVUwRVB1bGxjQUFBV2UyYVUxUVlybTg1RFJieTlnVlk3ODBFZXZDZ050?=
 =?utf-8?B?S3BBeGtrcUZZMWxPWnlwYWEzekVxb1BSNzBHZUlPcHdxRW5aYzF3Yy9FT3Rz?=
 =?utf-8?B?dkhaaUdiRTJ5UGVIcnN4VUVXcGFsWnVEQUFjcXlGaGlRQjZaVDNpS2ZsK0tW?=
 =?utf-8?B?ZmxiQ0c1ODQwWkpGYmVvWUNjMm5FTlV1VUVDR2doK1MrWk9PZHpDc2l2dWlH?=
 =?utf-8?B?NjdHSjRPb3ZRUTJtWEM1REFYK25TZjlGV29yZlo5ZUJHMkQvSVhCd3VuWFNJ?=
 =?utf-8?B?TFlyVVdtZ29Sc2ZvK3BsNEFlTUNOZFU5MlhJZEJ5S0dDMHJxajhubmJqWWpx?=
 =?utf-8?B?VlZCMFVQTzJhblBwa2F2Um5kNHFYekxFNGIrZEFxS0NSc2tWZnhUSDE2SUxQ?=
 =?utf-8?B?NjlTN3N6QTlYN0xrd05zR0trbjlnUlJjTnhJbkpETndRRnVrMGJIaUk4Rkli?=
 =?utf-8?B?QXdTTElncTN3OEFoV1RlTVNONHh2TXNVenhJYjcrcTh6SGRwZ0lTOXFFWlY0?=
 =?utf-8?B?dGFvelF6TWp5Uk90elBmM1lLbU04Nk01TU1FQ2lrM1QxQ1ZQUnhxa3RuN2Vz?=
 =?utf-8?B?VFdLVFJ1cFlWMy9nazV0UEREWkdqSFFOcFVhekJNc2lyM0gwUnlRY3hnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TCtXcEs2TXg1ZFB1eTVXZ0JBbmFBT3YzZHBKUUh1djhjNFZMa2lsU2t4dFpu?=
 =?utf-8?B?S2VWY1ljTzVROTJzUFNnaDlVQWFwWWwvVGRDYVFTQTVpMzVXZExqZTZMOWMx?=
 =?utf-8?B?UElPakE0Q2JBbjR0SXpjYmpqb3Z2VmtlWGdHY3VEWUtaK3RhNmtQUldHSFBL?=
 =?utf-8?B?ZGdsRHVOYWpNbnVkdUhUNVA5cDZQbGxqL0xaQ0dFdUhzT0w0bGJuRG5NUGJv?=
 =?utf-8?B?bndvK01Wd203TmlQUXcxc3VMakI1eWMvK0hvS2Jqb1hzMzE5RlE5QTRZM2U5?=
 =?utf-8?B?bHJtNjJzb2Fyc0FRSlpMR1JDUkQ3Zm16YzNFSUZaQTlLT2psUXRmdTdGY0ly?=
 =?utf-8?B?bFkxQTd6UFhzYjFCZTJkY0pEaXVpWmlMTUlIa1dBNFdZRTlUNnZOYUp1YjRs?=
 =?utf-8?B?bC91RXgzTks0cTdXQ1U5dnlESVFTL1UvREZOZUU0VDRHUEVpbHVlZWpUN3Zs?=
 =?utf-8?B?MUxHbUVRdEdsaTNTV1JxZExRTFF3eThrYlh2aDRGR0pwR01qODFSNTlkVjVE?=
 =?utf-8?B?ck1QeWI3b3BjMk10czB5RWlDWkNwZjhZVHRFdURoWXpIZUdGTTRHRmN5NkEy?=
 =?utf-8?B?TzBOaXBuaTlNdVlJOUF2SnlydjlQRjkweDZZaC90bWxYN0o2YUVmSXY4QWNK?=
 =?utf-8?B?K3ErdjNscTVTZ1ExRS9ZNTRjTEZHbnhLd1lmVlhVTDNuVmdya3ZUUkVQbnl2?=
 =?utf-8?B?SEJVcTZWbHcvc2NhRjVwRlZtV09QWU4rbEUwOGhVM1lQWXpmaGhia1ZCZ0VQ?=
 =?utf-8?B?SHpBOStQbzRndXZQWi9WdG9iV1pOTE5PSWY5T2NCRnlyaGpDd3RFTWR0K0pl?=
 =?utf-8?B?d0dnY1lIV2JtcVNpRXV0WmdXcHZvako4S2lka1N1aHNlTkhMMGZ5ZzRvQytj?=
 =?utf-8?B?Vmh3VURKc1NrclpKcXdIbFNGeDFTTmlhUXI2MzlNRFFjcEhrQVJ6NE1yS0Zy?=
 =?utf-8?B?OWRYWTNaL2s1d0x5SUhNL0NHaWhoSmVIL0RIVkcwajI4VEMvb1VkOWpTakNi?=
 =?utf-8?B?a2ZkVDZXSHdQTW50dHMwSC9LVVpURUdScHh1YWc5eTdhdWJkU3lSa0dkNHdB?=
 =?utf-8?B?Vy96U0V2b290dkQ1UUhtTE95OUw1dzd5SlljVzFKQlFCNmE2QmgwUVZJbjJG?=
 =?utf-8?B?dEYxVUtNNHNtNkVLNmZKdDQwd3IyUStaWG9rSUI1cC81NFQxUXZsMkJkeWl1?=
 =?utf-8?B?NitzUk9JZCtETUdIWm5KSUdWY3BKZ2hZczhaUEdkUUtXYXd4K1pIVUYxWXFs?=
 =?utf-8?B?RTlhMGE1bmhoSHlORkRIeFhMYXV4NnBCMERVaVJvdFZ2aFIyZ0tDTHBOYVFW?=
 =?utf-8?B?b29PblN2TkdLRlJJV1gxaW9DeVQ0VXJNWEhnTzVDK05mOGYxWlBwZkJpYnRk?=
 =?utf-8?B?RFR2VmM4QmF4VENYL3FuVjBnKzZ0V1ZPWDkySkNhMUpYUEJoSHpzQmJWNC83?=
 =?utf-8?B?QWMvRGxQdG1BVThQOUdWZEN3YkRXVytYNUt3RDVkcHhNOUJhdkNCdjJvTjQ3?=
 =?utf-8?B?MjV1alJCSnpLcEl0QS9uMVJqNFFTbTkxL1RlNE1LNVIvY3NHdGh3TGxsN0JN?=
 =?utf-8?B?VHJvTzM4K3ZIblVZazZUSGs5QjZUTFhTa2JqSVN0ZGFGQ1NOTlAwNVN6bnd4?=
 =?utf-8?B?TnJSVHB5MnorenJEZ3NZS2VHdDZKVmJaMUpoZ0NDRDQ3NG9jdXZUcVdONy8w?=
 =?utf-8?B?TXZiem9aYW9UaWNsdlZmSm9XakV5R2ZINDZzenlXaVBYaUh2YWl1VHRxdG9C?=
 =?utf-8?B?cVMrTzdLREpjMWVLUjBWSWtzOVllT2Vvd2grSWNXVmYzZjAxRE5iMkdFRU1W?=
 =?utf-8?B?dDNoYlYzdnVHVU5QYWpOOXZpdDB1eXJ3R3FBcTVHWFlZU3NxbGJabHJzN3ha?=
 =?utf-8?B?MW1tRnZ5dVdaZ1c2RUFJU1hVQkFaWHg0Wmc0cHloK0szZjVmRm9KUzk2VXdQ?=
 =?utf-8?B?T2hxLzcwc3V1NjZVU2JzdEZob2xRYTd3UG1uLzNybGdjUnVsa3Q1eVRIV3Y4?=
 =?utf-8?B?TkNlMUZTR0tXYzdEU1cwOTJNQXlNUUN2cHl4Rm05WHVlVW5MRHorTTNaMEZQ?=
 =?utf-8?B?c0JRV2lqZXVWTHhMZ2JZc2NqR0Q2Z3JWODBhVTVJUm15aEV6UXkwVlJEM2ZC?=
 =?utf-8?Q?fSrnZzUfRqqvjw9Iswi+FQWOE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f719fb0-57dc-4efd-30e8-08dc6fd4850d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 03:02:53.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLK50sTn8Jv4CxxUVECG/cWb+cNGnJ0XjRp2q9InuWVWnciofPOWw2xVZfqLZiHzb3w1uqBHaAEnzALPtsACVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236

--------------3QNAbrje8VcHyN7JCPv0ymrC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-05-08 a.m.7:18, Catherine Redfield wrote:
> *External email: Use caution opening links or attachments*
> 
> 
> On a VM with the GCP kernel (where we first identified the problem), I see:
> 
> 1. The full kernel log from `journalctl --system > kernlog` attached.  
> The specific suspend section is here:
> 
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> systemd[1]: Reached target sleep.target - Sleep.
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> systemd[1]: Starting systemd-suspend.service - System Suspend...
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> systemd-sleep[1413]: Performing sleep operation 'suspend'...
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: PM: suspend entry (deep)
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: Filesystems sync: 0.008 seconds
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: Freezing user space processes
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: Freezing user space processes completed (elapsed 0.001 seconds)
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: OOM killer disabled.
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: Freezing remaining freezable tasks
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: printk: Suspending console(s) (use no_console_suspend to debug)
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: port 00:03:0.0: PM: dpm_run_callback(): 
> pm_runtime_force_suspend+0x0/0x130 returns -16
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: port 00:03:0.0: PM: failed to suspend: error -16

Thanks Joesph and Catherine's help.

Hi,

I have alreay synced up with Cananical guys offline about this issue.

I can run "suspend/resume" sucessfully on my local server and VM.
And "PM: failed to suspend: error -16" looks like not cause by my 
previous virtio patch ( fd27ef6b44be  ("virtio-pci: Introduce admin 
virtqueue")) which only modified "virtio_device_freeze" about "suspend" 
action.

So I have provide the my steps and debug patch to Joesph and Catherine. 
I will also sync up the information here, as follow:

I have read the qemu code and find a way to trigger "suspend/resume" on 
my setup, and add some debug message in the latest kerenel

My setps are:
1. QEMU cmdline add following
....
-global PIIX4_PM.disable_s3=0 \
-global PIIX4_PM.disable_s4=1 \
....
-netdev type=tap,ifname=tap0,id=hostnet0,script=no,downscript=no \
-device 
virtio-net-pci,netdev=hostnet0,id=net0,mac=$SSH_MAC,bus=pci.0,addr=0x3 \
......

2. In the VM, run "systemctl suspend" to PM suspend the VM into memory
3. In qemu hmp shell, run "system_wakeup" to resume the VM again

My VM configuration:
NIC:     1 virtio nic emulated by QEMU
OS:      Ubuntu 22.04.4 LTS
kernel:  latest kernel, 6.9-rc7: ee5b455b0ada (kernel2/net-next-virito, 
kernel2/master, master) Merge tag 'slab-for-6.9-rc7-fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab)


I add some debug message on the latest kernel, and do above steps to 
trigger "suspen/resume". Everything of VM is OK, VM could suspend/resume 
successfully.
Follwing is the kernel log:
----------------------------------------------------------------------------
........
May  6 15:59:52 feliu-vm kernel: [   43.446737] PM: suspend entry (deep)
May  6 16:00:04 feliu-vm kernel: [   43.467640] Filesystems sync: 0.020 
seconds
May  6 16:00:04 feliu-vm kernel: [   43.467923] Freezing user space 
processes
May  6 16:00:04 feliu-vm kernel: [   43.470294] Freezing user space 
processes completed (elapsed 0.002 seconds)
May  6 16:00:04 feliu-vm kernel: [   43.470299] OOM killer disabled.
May  6 16:00:04 feliu-vm kernel: [   43.470301] Freezing remaining 
freezable tasks
May  6 16:00:04 feliu-vm kernel: [   43.471482] Freezing remaining 
freezable tasks completed (elapsed 0.001 seconds)
May  6 16:00:04 feliu-vm kernel: [   43.471495] printk: Suspending 
console(s) (use no_console_suspend to debug)
May  6 16:00:04 feliu-vm kernel: [   43.474034] virtio_net virtio0: 
godeng virtio device freeze
May  6 16:00:04 feliu-vm kernel: [   43.475714] virtio_net virtio0 ens3: 
godfeng virtnet_freeze done
May  6 16:00:04 feliu-vm kernel: [   43.475717] virtio_net virtio0: 
godfeng VIRTIO_F_ADMIN_VQ not enabled
May  6 16:00:04 feliu-vm kernel: [   43.475719] virtio_net virtio0: 
godeng virtio device freeze done
........
May  6 16:00:04 feliu-vm kernel: [   43.535382] smpboot: CPU 1 is now 
offline
May  6 16:00:04 feliu-vm kernel: [   43.537283] IRQ fixup: irq 1 move in 
progress, old vector 32
May  6 16:00:04 feliu-vm kernel: [   43.538504] smpboot: CPU 2 is now 
offline
May  6 16:00:04 feliu-vm kernel: [   43.541392] smpboot: CPU 3 is now 
offline

......

May  6 16:00:04 feliu-vm kernel: [   54.973285] smpboot: Booting Node 0 
Processor 15 APIC 0xf
May  6 16:00:04 feliu-vm kernel: [   54.975190] CPU15 is up
May  6 16:00:04 feliu-vm kernel: [   54.976011] ACPI: PM: Waking up from 
system sleep state S3
May  6 16:00:04 feliu-vm kernel: [   54.986071] virtio_net virtio0: 
godeng virtio device restore
May  6 16:00:04 feliu-vm kernel: [   54.987563] virtio_net virtio0 ens3: 
godfeng virtnet_restore done
May  6 16:00:04 feliu-vm kernel: [   54.987635] virtio_net virtio0: 
godfeng: virtio device restore done
......
May  6 16:00:04 feliu-vm kernel: [   55.307221] ata8: SATA link down 
(SStatus 0 SControl 300)
May  6 16:00:04 feliu-vm kernel: [   55.442048] OOM killer enabled.
May  6 16:00:04 feliu-vm kernel: [   55.442051] Restarting tasks ... done.
May  6 16:00:04 feliu-vm kernel: [   55.443576] random: crng reseeded on 
system resumption
May  6 16:00:04 feliu-vm kernel: [   55.443582] PM: suspend exit

----------------------------------------------------------------------------

Attachment is the full kernel log. I think maybe it is some configration 
error.


Thanks
Feng


> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: sd 0:0:1:0: [sda] Synchronizing SCSI cache
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: PM: Some devices failed to suspend, or early wake event detected
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: OOM killer enabled.
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: Restarting tasks ... done.
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: random: crng reseeded on system resumption
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: PM: suspend exit
> May 08 11:08:42 kernel-test-202405080702.c.ubuntu-catred.internal 
> kernel: PM: suspend entry (s2idle)
> -- Boot 61828bc938b44fc68a8aeedc16a23a9d --
> May 08 11:09:03 localhost kernel: Linux version 6.8.0-1007-gcp 
> (buildd@lcy02-amd64-079) (x86_64-linux-gnu-gcc-13 (Ubuntu 
> 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) 
> #7-Ubuntu SMP Sat Apr 20 00:58:31 UTC 2024 (Ubuntu 6.8.0-1007.7-gcp 6.8.1)
> May 08 11:09:03 localhost kernel: Command line: 
> BOOT_IMAGE=/vmlinuz-6.8.0-1007-gcp 
> root=PARTUUID=7a949935-6bf2-4cae-b404-803c95163572 ro 
> console=ttyS0,115200 panic=-1
> 
> 2. The features the devices has:
> 
> catred@kernel-test-202405080702:~$ cat 
> /sys/bus/virtio/devices/virtio0/features
> 0110000000000000000000000000010000000000000000000000000000000000
> catred@kernel-test-202405080702:~$ cat 
> /sys/bus/virtio/devices/virtio1/features
> 1110010110011001110000100000010000000000000000000000000000000000
> catred@kernel-test-202405080702:~$ cat 
> /sys/bus/virtio/devices/virtio2/features
> 1110000000000000000000000000000000000000000000000000000000000000
> catred@kernel-test-202405080702:~$ cat 
> /sys/bus/virtio/devices/virtio3/features
> 0000000000000000000000000000000000000000000000000000000000000000
> 
> Catherine
> 
> On Tue, May 7, 2024 at 11:34 PM Jason Wang <jasowang@redhat.com 
> <mailto:jasowang@redhat.com>> wrote:
> 
>     On Sat, May 4, 2024 at 2:10 AM Joseph Salisbury
>     <joseph.salisbury@canonical.com
>     <mailto:joseph.salisbury@canonical.com>> wrote:
>      >
>      > Hi Feng,
>      >
>      > During testing, a kernel bug was identified with the suspend/resume
>      > functionality on instances running in a public cloud [0].  This
>     bug is a
>      > regression introduced in v6.8-rc1.  After a kernel bisect, the
>     following
>      > commit was identified as the cause of the regression:
>      >
>      >         fd27ef6b44be  ("virtio-pci: Introduce admin virtqueue")
> 
>     Have a quick glance at the patch it seems it should not damage the
>     freeze/restore as it should behave as in the past.
> 
>     But I found something interesting:
> 
>     1) assumes 1 admin vq which is not what spec said
>     2) special function for admin virtqueue during freeze/restore, but it
>     doesn't do anything special than del_vq()
>     3) lack real users but I guess e.g the destroy_avq() needs to be
>     synchronized with the one that is using admin virtqueue
> 
>      >
>      > I was hoping to get your feedback, since you are the patch author. Do
>      > you think gathering any additional data will help diagnose this
>     issue?
> 
>     Yes, please show us
> 
>     1) the kernel log here.
>     2) the features that the device has like
>     /sys/bus/virtio/devices/virtio0/features
> 
>      > This commit is depended upon by other virtio commits, so a revert
>     test
>      > is not really straight forward without reverting all the
>     dependencies.
>      > Any ideas you have would be greatly appreciated.
> 
>     Thanks
> 
>      >
>      >
>      > Thanks,
>      >
>      > Joe
>      >
>      > http://pad.lv/2063315 <http://pad.lv/2063315>
>      >
> 
--------------3QNAbrje8VcHyN7JCPv0ymrC
Content-Type: text/plain; charset=UTF-8; name="kern.log"
Content-Disposition: attachment; filename="kern.log"
Content-Transfer-Encoding: base64

TWF5ICA2IDE1OjU5OjUyIGZlbGl1LXZtIGtlcm5lbDogWyAgIDQzLjQ0NjczN10gUE06IHN1c3Bl
bmQgZW50cnkgKGRlZXApCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0My40
Njc2NDBdIEZpbGVzeXN0ZW1zIHN5bmM6IDAuMDIwIHNlY29uZHMKTWF5ICA2IDE2OjAwOjA0IGZl
bGl1LXZtIGtlcm5lbDogWyAgIDQzLjQ2NzkyM10gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNz
ZXMKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDQzLjQ3MDI5NF0gRnJlZXpp
bmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgY29tcGxldGVkIChlbGFwc2VkIDAuMDAyIHNlY29uZHMp
Ck1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0My40NzAyOTldIE9PTSBraWxs
ZXIgZGlzYWJsZWQuCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0My40NzAz
MDFdIEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MKTWF5ICA2IDE2OjAwOjA0IGZl
bGl1LXZtIGtlcm5lbDogWyAgIDQzLjQ3MTQ4Ml0gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJs
ZSB0YXNrcyBjb21wbGV0ZWQgKGVsYXBzZWQgMC4wMDEgc2Vjb25kcykKTWF5ICA2IDE2OjAwOjA0
IGZlbGl1LXZtIGtlcm5lbDogWyAgIDQzLjQ3MTQ5NV0gcHJpbnRrOiBTdXNwZW5kaW5nIGNvbnNv
bGUocykgKHVzZSBub19jb25zb2xlX3N1c3BlbmQgdG8gZGVidWcpCk1heSAgNiAxNjowMDowNCBm
ZWxpdS12bSBrZXJuZWw6IFsgICA0My40NzQwMzRdIHZpcnRpb19uZXQgdmlydGlvMDogZ29kZW5n
IHZpcnRpbyBkZXZpY2UgZnJlZXplCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsg
ICA0My40NzU3MTRdIHZpcnRpb19uZXQgdmlydGlvMCBlbnMzOiBnb2RmZW5nIHZpcnRuZXRfZnJl
ZXplIGRvbmUKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDQzLjQ3NTcxN10g
dmlydGlvX25ldCB2aXJ0aW8wOiBnb2RmZW5nIFZJUlRJT19GX0FETUlOX1ZRIG5vdCBlbmFibGVk
Ck1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0My40NzU3MTldIHZpcnRpb19u
ZXQgdmlydGlvMDogZ29kZW5nIHZpcnRpbyBkZXZpY2UgZnJlZXplIGRvbmUKTWF5ICA2IDE2OjAw
OjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDQzLjUyODUzOF0gc2QgMzowOjA6MDogW3NkYl0gU3lu
Y2hyb25pemluZyBTQ1NJIGNhY2hlCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsg
ICA0My41Mjg1OTldIHNkIDI6MDowOjA6IFtzZGFdIFN5bmNocm9uaXppbmcgU0NTSSBjYWNoZQpN
YXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNDMuNTI5Mjg4XSBhdGE0LjAwOiBF
bnRlcmluZyBzdGFuZGJ5IHBvd2VyIG1vZGUKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5l
bDogWyAgIDQzLjUyOTM2NF0gYXRhMy4wMDogRW50ZXJpbmcgc3RhbmRieSBwb3dlciBtb2RlCk1h
eSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0My41MzI0MzJdIEFDUEk6IFBNOiBQ
cmVwYXJpbmcgdG8gZW50ZXIgc3lzdGVtIHNsZWVwIHN0YXRlIFMzCk1heSAgNiAxNjowMDowNCBm
ZWxpdS12bSBrZXJuZWw6IFsgICA0My41MzI1MzRdIEFDUEk6IFBNOiBTYXZpbmcgcGxhdGZvcm0g
TlZTIG1lbW9yeQpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNDMuNTMyNTcw
XSBEaXNhYmxpbmcgbm9uLWJvb3QgQ1BVcyAuLi4KTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtl
cm5lbDogWyAgIDQzLjUzNTM4Ml0gc21wYm9vdDogQ1BVIDEgaXMgbm93IG9mZmxpbmUKTWF5ICA2
IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDQzLjUzNzI4M10gSVJRIGZpeHVwOiBpcnEg
MSBtb3ZlIGluIHByb2dyZXNzLCBvbGQgdmVjdG9yIDMyCk1heSAgNiAxNjowMDowNCBmZWxpdS12
bSBrZXJuZWw6IFsgICA0My41Mzg1MDRdIHNtcGJvb3Q6IENQVSAyIGlzIG5vdyBvZmZsaW5lCk1h
eSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0My41NDEzOTJdIHNtcGJvb3Q6IENQ
VSAzIGlzIG5vdyBvZmZsaW5lCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0
My41NDQ0NjRdIHNtcGJvb3Q6IENQVSA0IGlzIG5vdyBvZmZsaW5lCk1heSAgNiAxNjowMDowNCBm
ZWxpdS12bSBrZXJuZWw6IFsgICA0My41NDcyOTZdIHNtcGJvb3Q6IENQVSA1IGlzIG5vdyBvZmZs
aW5lCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0My41NTAwNzZdIHNtcGJv
b3Q6IENQVSA2IGlzIG5vdyBvZmZsaW5lCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6
IFsgICA0My41NTI2NjBdIHNtcGJvb3Q6IENQVSA3IGlzIG5vdyBvZmZsaW5lCk1heSAgNiAxNjow
MDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0My41NTUyNzhdIHNtcGJvb3Q6IENQVSA4IGlzIG5v
dyBvZmZsaW5lCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA0My41NTc2OTNd
IHNtcGJvb3Q6IENQVSA5IGlzIG5vdyBvZmZsaW5lCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBr
ZXJuZWw6IFsgICA0My41NjAyOTJdIHNtcGJvb3Q6IENQVSAxMCBpcyBub3cgb2ZmbGluZQpNYXkg
IDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNDMuNTYyNjI0XSBzbXBib290OiBDUFUg
MTEgaXMgbm93IG9mZmxpbmUKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDQz
LjU2NTE4NV0gc21wYm9vdDogQ1BVIDEyIGlzIG5vdyBvZmZsaW5lCk1heSAgNiAxNjowMDowNCBm
ZWxpdS12bSBrZXJuZWw6IFsgICA0My41Njc0OTZdIHNtcGJvb3Q6IENQVSAxMyBpcyBub3cgb2Zm
bGluZQpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNDMuNTcwMTUzXSBzbXBi
b290OiBDUFUgMTQgaXMgbm93IG9mZmxpbmUKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5l
bDogWyAgIDQzLjU3Mjk2NV0gc21wYm9vdDogQ1BVIDE1IGlzIG5vdyBvZmZsaW5lCk1heSAgNiAx
NjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDczMTJdIHVuY2hlY2tlZCBNU1IgYWNj
ZXNzIGVycm9yOiBXUk1TUiB0byAweGMwMDExMDI5ICh0cmllZCB0byB3cml0ZSAweDAwMDAwMDAw
MDAwMDAwMDApIGF0IHJJUDogMHhmZmZmZmZmZmFjMmI0YzQ4IChuYXRpdmVfd3JpdGVfbXNyKzB4
OC8weDMwKQpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3MzMzXSBD
YWxsIFRyYWNlOgpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3MzM3
XSAgPFRBU0s+Ck1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDczNDld
ICA/IHNob3dfc3RhY2tfcmVncysweDI2LzB4MzAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtl
cm5lbDogWyAgIDU0Ljk0NzM1NV0gID8gZXhfaGFuZGxlcl9tc3IrMHgxMGYvMHgxODAKTWF5ICA2
IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzM1OV0gID8gc2VhcmNoX2V4dGFi
bGUrMHgyYi8weDQwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDcz
NjVdICA/IGZpeHVwX2V4Y2VwdGlvbisweDMxNS8weDM4MApNYXkgIDYgMTY6MDA6MDQgZmVsaXUt
dm0ga2VybmVsOiBbICAgNTQuOTQ3MzY5XSAgPyBleGNfZ2VuZXJhbF9wcm90ZWN0aW9uKzB4MTUy
LzB4NDgwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDczNzNdICA/
IGFjcGlfaHdfcmVhZF9wb3J0KzB4ZWMvMHgxMDAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtl
cm5lbDogWyAgIDU0Ljk0NzM4Ml0gID8gYXNtX2V4Y19nZW5lcmFsX3Byb3RlY3Rpb24rMHgyYi8w
eDMwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDczOTddICA/IG5h
dGl2ZV93cml0ZV9tc3IrMHg4LzB4MzAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDog
WyAgIDU0Ljk0NzQwMV0gID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYKTWF5ICA2IDE2OjAw
OjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzQwNV0gID8gcmVzdG9yZV9wcm9jZXNzb3Jf
c3RhdGUrMHgyYmYvMHgzNTAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0
Ljk0NzQxMV0gIHg4Nl9hY3BpX3N1c3BlbmRfbG93bGV2ZWwrMHhmNy8weDE2MApNYXkgIDYgMTY6
MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NDE2XSAgYWNwaV9zdXNwZW5kX2VudGVy
KzB4NWEvMHgxZjAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzQy
MV0gID8gX3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKzB4MTIvMHg0MApNYXkgIDYgMTY6MDA6
MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NDI1XSAgc3VzcGVuZF9kZXZpY2VzX2FuZF9l
bnRlcisweDc1OS8weDhlMApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQu
OTQ3NDMyXSAgcG1fc3VzcGVuZCsweDIzZS8weDVlMApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0g
a2VybmVsOiBbICAgNTQuOTQ3NDM1XSAgc3RhdGVfc3RvcmUrMHg4NS8weGYwCk1heSAgNiAxNjow
MDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc0NDBdICBrb2JqX2F0dHJfc3RvcmUrMHgx
Ni8weDMwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc0NDRdICBz
eXNmc19rZl93cml0ZSsweDQyLzB4NTAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDog
WyAgIDU0Ljk0NzQ0OF0gIGtlcm5mc19mb3Bfd3JpdGVfaXRlcisweDE0My8weDFkMApNYXkgIDYg
MTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NDUzXSAgdmZzX3dyaXRlKzB4MzEx
LzB4NDMwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc0NjFdICBr
c3lzX3dyaXRlKzB4NmIvMHhmMApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAg
NTQuOTQ3NDY2XSAgX194NjRfc3lzX3dyaXRlKzB4MWQvMHgzMApNYXkgIDYgMTY6MDA6MDQgZmVs
aXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NDY5XSAgeDY0X3N5c19jYWxsKzB4MTY4MS8weDIwYzAK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzQ3NF0gIGRvX3N5c2Nh
bGxfNjQrMHg3MS8weDExMApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQu
OTQ3NDc4XSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1ZgpNYXkgIDYgMTY6MDA6MDQgZmVs
aXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NDgyXSAgPyBrbWVtX2NhY2hlX2ZyZWUrMHgzYmIvMHgz
ZjAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzQ4Nl0gID8gX19m
cHV0KzB4MTZkLzB4MmYwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45
NDc0OTFdICA/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmCk1heSAgNiAxNjowMDowNCBmZWxp
dS12bSBrZXJuZWw6IFsgICA1NC45NDc0OTRdICA/IF9fZnB1dCsweDE2ZC8weDJmMApNYXkgIDYg
MTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NDk4XSAgPyBzcnNvX3JldHVybl90
aHVuaysweDUvMHg1ZgpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3
NTAyXSAgPyBfX2ZwdXRfc3luYysweDFlLzB4MzAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtl
cm5lbDogWyAgIDU0Ljk0NzUwNV0gID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYKTWF5ICA2
IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzUwOF0gID8gc3Jzb19yZXR1cm5f
dGh1bmsrMHg1LzB4NWYKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0
NzUxMV0gID8gc3lzY2FsbF9leGl0X3RvX3VzZXJfbW9kZSsweDkyLzB4MWMwCk1heSAgNiAxNjow
MDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc1MTVdICA/IHNyc29fcmV0dXJuX3RodW5r
KzB4NS8weDVmCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc1MThd
ICA/IGRvX3N5c2NhbGxfNjQrMHg3ZC8weDExMApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2Vy
bmVsOiBbICAgNTQuOTQ3NTIxXSAgPyBzZXRfcHRlcy5jb25zdHByb3AuMCsweDJiLzB4OTAKTWF5
ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzUyNl0gID8gc3Jzb19yZXR1
cm5fdGh1bmsrMHg1LzB4NWYKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0
Ljk0NzUyOV0gID8gbmV4dF91cHRvZGF0ZV9mb2xpbysweDlmLzB4MzEwCk1heSAgNiAxNjowMDow
NCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc1MzRdICA/IHNyc29fcmV0dXJuX3RodW5rKzB4
NS8weDVmCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc1MzddICA/
IF9yYXdfc3Bpbl91bmxvY2srMHgxMi8weDMwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJu
ZWw6IFsgICA1NC45NDc1NDBdICA/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmCk1heSAgNiAx
NjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc1NDNdICA/IGZpbGVtYXBfbWFwX3Bh
Z2VzKzB4NGMzLzB4NWMwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45
NDc1NDddICA/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmCk1heSAgNiAxNjowMDowNCBmZWxp
dS12bSBrZXJuZWw6IFsgICA1NC45NDc1NTBdICA/IF9fcHRlX29mZnNldF9tYXArMHgyMC8weDE5
MApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NTU3XSAgPyBzcnNv
X3JldHVybl90aHVuaysweDUvMHg1ZgpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBb
ICAgNTQuOTQ3NTYwXSAgPyBkb19mYXVsdCsweDI1Mi8weDRhMApNYXkgIDYgMTY6MDA6MDQgZmVs
aXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NTY0XSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1
ZgpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NTY3XSAgPyBfX2hh
bmRsZV9tbV9mYXVsdCsweDhiMC8weGViMApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVs
OiBbICAgNTQuOTQ3NTcwXSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1ZgpNYXkgIDYgMTY6
MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NTc2XSAgPyBzcnNvX3JldHVybl90aHVu
aysweDUvMHg1ZgpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NTc5
XSAgPyBfX3Rhc2tfcGlkX25yX25zKzB4NzAvMHhjMApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0g
a2VybmVsOiBbICAgNTQuOTQ3NTgzXSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1ZgpNYXkg
IDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NTg2XSAgPyBzeXNjYWxsX2V4
aXRfdG9fdXNlcl9tb2RlKzB4OTIvMHgxYzAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5l
bDogWyAgIDU0Ljk0NzU5MF0gID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYKTWF5ICA2IDE2
OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzU5M10gID8gZG9fc3lzY2FsbF82NCsw
eDdkLzB4MTEwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc1OTZd
ICA/IGhhbmRsZV9tbV9mYXVsdCsweDE5MC8weDJmMApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0g
a2VybmVsOiBbICAgNTQuOTQ3NjAwXSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1ZgpNYXkg
IDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NjAzXSAgPyBkb191c2VyX2Fk
ZHJfZmF1bHQrMHgzNTcvMHg2YjAKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAg
IDU0Ljk0NzYwNl0gID8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYKTWF5ICA2IDE2OjAwOjA0
IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzYwOV0gID8gaXJxZW50cnlfZXhpdF90b191c2Vy
X21vZGUrMHg2My8weDE4MApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQu
OTQ3NjEzXSAgPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1ZgpNYXkgIDYgMTY6MDA6MDQgZmVs
aXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NjE2XSAgPyBpcnFlbnRyeV9leGl0KzB4M2YvMHg1MApN
YXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTQ3NjIwXSAgPyBzcnNvX3Jl
dHVybl90aHVuaysweDUvMHg1ZgpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAg
NTQuOTQ3NjIzXSAgPyBleGNfcGFnZV9mYXVsdCsweDhkLzB4MTkwCk1heSAgNiAxNjowMDowNCBm
ZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc2MjddICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3
ZnJhbWUrMHg3Ni8weDdlCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45
NDc2MzFdIFJJUDogMDAzMzoweDdmMGViY2QxNDg4NwpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0g
a2VybmVsOiBbICAgNTQuOTQ3NjQxXSBDb2RlOiAxMCAwMCBmNyBkOCA2NCA4OSAwMiA0OCBjNyBj
MCBmZiBmZiBmZiBmZiBlYiBiNyAwZiAxZiAwMCBmMyAwZiAxZSBmYSA2NCA4YiAwNCAyNSAxOCAw
MCAwMCAwMCA4NSBjMCA3NSAxMCBiOCAwMSAwMCAwMCAwMCAwZiAwNSA8NDg+IDNkIDAwIGYwIGZm
IGZmIDc3IDUxIGMzIDQ4IDgzIGVjIDI4IDQ4IDg5IDU0IDI0IDE4IDQ4IDg5IDc0IDI0Ck1heSAg
NiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDc2NDRdIFJTUDogMDAyYjowMDAw
N2ZmZWUzNmE3MWQ4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMDEK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzY0N10gUkFYOiBmZmZm
ZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwNCBSQ1g6IDAwMDA3ZjBlYmNkMTQ4ODcK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzY0OV0gUkRYOiAwMDAw
MDAwMDAwMDAwMDA0IFJTSTogMDAwMDdmZmVlMzZhNzI5MCBSREk6IDAwMDAwMDAwMDAwMDAwMDQK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzY1MV0gUkJQOiAwMDAw
N2ZmZWUzNmE3MjkwIFIwODogMDAwMDAwMDAwMDAwMDAwNCBSMDk6IDAwMDAwMDAwN2ZmZmZmZmYK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzY1M10gUjEwOiAwMDAw
MDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDQK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzY1NF0gUjEzOiAwMDAw
NTVmMGZkZGRjMmQwIFIxNDogMDAwMDdmMGViY2UxNmEwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDQK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzY2MV0gIDwvVEFTSz4K
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk0NzY2NV0gQUNQSTogUE06
IExvdy1sZXZlbCByZXN1bWUgY29tcGxldGUKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5l
bDogWyAgIDU0Ljk0NzcxNV0gQUNQSTogUE06IFJlc3RvcmluZyBwbGF0Zm9ybSBOVlMgbWVtb3J5
Ck1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NDk1NTddIEVuYWJsaW5n
IG5vbi1ib290IENQVXMgLi4uCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1
NC45NDk2NDldIHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciAxIEFQSUMgMHgxCk1h
eSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NTEwMDNdIENQVTEgaXMgdXAK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk1MTA1MF0gc21wYm9vdDog
Qm9vdGluZyBOb2RlIDAgUHJvY2Vzc29yIDIgQVBJQyAweDIKTWF5ICA2IDE2OjAwOjA0IGZlbGl1
LXZtIGtlcm5lbDogWyAgIDU0Ljk1MzQyNV0gQ1BVMiBpcyB1cApNYXkgIDYgMTY6MDA6MDQgZmVs
aXUtdm0ga2VybmVsOiBbICAgNTQuOTUzNDc4XSBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9j
ZXNzb3IgMyBBUElDIDB4MwpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQu
OTU0NjAyXSBDUFUzIGlzIHVwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1
NC45NTQ2NTRdIHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciA0IEFQSUMgMHg0Ck1h
eSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NTYyNTRdIENQVTQgaXMgdXAK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk1NjMwOV0gc21wYm9vdDog
Qm9vdGluZyBOb2RlIDAgUHJvY2Vzc29yIDUgQVBJQyAweDUKTWF5ICA2IDE2OjAwOjA0IGZlbGl1
LXZtIGtlcm5lbDogWyAgIDU0Ljk1Nzc4MF0gQ1BVNSBpcyB1cApNYXkgIDYgMTY6MDA6MDQgZmVs
aXUtdm0ga2VybmVsOiBbICAgNTQuOTU3ODM1XSBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9j
ZXNzb3IgNiBBUElDIDB4NgpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQu
OTU5MjYzXSBDUFU2IGlzIHVwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1
NC45NTkzMTJdIHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciA3IEFQSUMgMHg3Ck1h
eSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45NjA3MzRdIENQVTcgaXMgdXAK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk2MDc4OF0gc21wYm9vdDog
Qm9vdGluZyBOb2RlIDAgUHJvY2Vzc29yIDggQVBJQyAweDgKTWF5ICA2IDE2OjAwOjA0IGZlbGl1
LXZtIGtlcm5lbDogWyAgIDU0Ljk2MjI3M10gQ1BVOCBpcyB1cApNYXkgIDYgMTY6MDA6MDQgZmVs
aXUtdm0ga2VybmVsOiBbICAgNTQuOTYyMzI4XSBzbXBib290OiBCb290aW5nIE5vZGUgMCBQcm9j
ZXNzb3IgOSBBUElDIDB4OQpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQu
OTYzNjkyXSBDUFU5IGlzIHVwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1
NC45NjM3MzldIHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciAxMCBBUElDIDB4YQpN
YXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTY1NzA4XSBDUFUxMCBpcyB1
cApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTY1NzY5XSBzbXBib290
OiBCb290aW5nIE5vZGUgMCBQcm9jZXNzb3IgMTEgQVBJQyAweGIKTWF5ICA2IDE2OjAwOjA0IGZl
bGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk2NzMxN10gQ1BVMTEgaXMgdXAKTWF5ICA2IDE2OjAwOjA0
IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk2NzM1Ml0gc21wYm9vdDogQm9vdGluZyBOb2RlIDAg
UHJvY2Vzc29yIDEyIEFQSUMgMHhjCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsg
ICA1NC45Njg5NDNdIENQVTEyIGlzIHVwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6
IFsgICA1NC45Njg5OTFdIHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciAxMyBBUElD
IDB4ZApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTcwNTUxXSBDUFUx
MyBpcyB1cApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTcwNjAyXSBz
bXBib290OiBCb290aW5nIE5vZGUgMCBQcm9jZXNzb3IgMTQgQVBJQyAweGUKTWF5ICA2IDE2OjAw
OjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk3MzIyNV0gQ1BVMTQgaXMgdXAKTWF5ICA2IDE2
OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk3MzI4NV0gc21wYm9vdDogQm9vdGluZyBO
b2RlIDAgUHJvY2Vzc29yIDE1IEFQSUMgMHhmCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJu
ZWw6IFsgICA1NC45NzUxOTBdIENQVTE1IGlzIHVwCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBr
ZXJuZWw6IFsgICA1NC45NzYwMTFdIEFDUEk6IFBNOiBXYWtpbmcgdXAgZnJvbSBzeXN0ZW0gc2xl
ZXAgc3RhdGUgUzMKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk4NjA3
MV0gdmlydGlvX25ldCB2aXJ0aW8wOiBnb2RlbmcgdmlydGlvIGRldmljZSByZXN0b3JlCk1heSAg
NiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45ODc1NjNdIHZpcnRpb19uZXQgdmly
dGlvMCBlbnMzOiBnb2RmZW5nIHZpcnRuZXRfcmVzdG9yZSBkb25lCk1heSAgNiAxNjowMDowNCBm
ZWxpdS12bSBrZXJuZWw6IFsgICA1NC45ODc2MzVdIHZpcnRpb19uZXQgdmlydGlvMDogZ29kZmVu
ZzogdmlydGlvIGRldmljZSByZXN0b3JlIGRvbmUKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtl
cm5lbDogWyAgIDU0Ljk4ODEzN10gdXNiIHVzYjE6IHJvb3QgaHViIGxvc3QgcG93ZXIgb3Igd2Fz
IHJlc2V0Ck1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NC45ODg2NDBdIHBj
aSAwMDAwOjAwOjAxLjA6IFBJSVgzOiBFbmFibGluZyBQYXNzaXZlIFJlbGVhc2UKTWF5ICA2IDE2
OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU0Ljk4OTg0Nl0gdXNiIHVzYjM6IHJvb3QgaHVi
IGxvc3QgcG93ZXIgb3Igd2FzIHJlc2V0Ck1heSAgNiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6
IFsgICA1NC45ODk5MDhdIHVzYiB1c2I0OiByb290IGh1YiBsb3N0IHBvd2VyIG9yIHdhcyByZXNl
dApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTQuOTg5OTYxXSB1c2IgdXNi
Mjogcm9vdCBodWIgbG9zdCBwb3dlciBvciB3YXMgcmVzZXQKTWF5ICA2IDE2OjAwOjA0IGZlbGl1
LXZtIGtlcm5lbDogWyAgIDU1LjI3MjIyMl0gdXNiIDItMTogcmVzZXQgaGlnaC1zcGVlZCBVU0Ig
ZGV2aWNlIG51bWJlciAyIHVzaW5nIGVoY2ktcGNpCk1heSAgNiAxNjowMDowNCBmZWxpdS12bSBr
ZXJuZWw6IFsgICA1NS4zMDI5NDhdIGF0YTQ6IFNBVEEgbGluayB1cCAxLjUgR2JwcyAoU1N0YXR1
cyAxMTMgU0NvbnRyb2wgMzAwKQpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAg
NTUuMzAzMDkzXSBhdGE1OiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250cm9sIDMwMCkK
TWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU1LjMwMzI2Nl0gYXRhMzogU0FU
QSBsaW5rIHVwIDEuNSBHYnBzIChTU3RhdHVzIDExMyBTQ29udHJvbCAzMDApCk1heSAgNiAxNjow
MDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NS4zMDMzNjddIHNkIDM6MDowOjA6IFtzZGJdIFN0
YXJ0aW5nIGRpc2sKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU1LjMwMzQz
NF0gc2QgMjowOjA6MDogW3NkYV0gU3RhcnRpbmcgZGlzawpNYXkgIDYgMTY6MDA6MDQgZmVsaXUt
dm0ga2VybmVsOiBbICAgNTUuMzAzNTE2XSBhdGE0LjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEw
MApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBbICAgNTUuMzAzNTYzXSBhdGEzLjAw
OiBjb25maWd1cmVkIGZvciBVRE1BLzEwMApNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVs
OiBbICAgNTUuMzA2OTEyXSBhdGE2OiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250cm9s
IDMwMCkKTWF5ICA2IDE2OjAwOjA0IGZlbGl1LXZtIGtlcm5lbDogWyAgIDU1LjMwNzA3MV0gYXRh
NzogU0FUQSBsaW5rIGRvd24gKFNTdGF0dXMgMCBTQ29udHJvbCAzMDApCk1heSAgNiAxNjowMDow
NCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NS4zMDcyMjFdIGF0YTg6IFNBVEEgbGluayBkb3duIChT
U3RhdHVzIDAgU0NvbnRyb2wgMzAwKQpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2VybmVsOiBb
ICAgNTUuNDQyMDQ4XSBPT00ga2lsbGVyIGVuYWJsZWQuCk1heSAgNiAxNjowMDowNCBmZWxpdS12
bSBrZXJuZWw6IFsgICA1NS40NDIwNTFdIFJlc3RhcnRpbmcgdGFza3MgLi4uIGRvbmUuCk1heSAg
NiAxNjowMDowNCBmZWxpdS12bSBrZXJuZWw6IFsgICA1NS40NDM1NzZdIHJhbmRvbTogY3JuZyBy
ZXNlZWRlZCBvbiBzeXN0ZW0gcmVzdW1wdGlvbgpNYXkgIDYgMTY6MDA6MDQgZmVsaXUtdm0ga2Vy
bmVsOiBbICAgNTUuNDQzNTgyXSBQTTogc3VzcGVuZCBleGl0Cg==

--------------3QNAbrje8VcHyN7JCPv0ymrC--
