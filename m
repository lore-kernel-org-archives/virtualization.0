Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7041E130D
	for <virtualization@lists.linux.dev>; Fri,  8 Nov 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058329; cv=fail; b=t9IeAYgrC5s5XmDssQ1EZGtmJ3rdCe+2IFpaPfybHgREa/JGC4M+p1QtQvYXrHmykeUyoFohCXCAfdF5woI7TGpPtTzG6C3Q0WW7FL5rCHmkzwVJCSFqO55jh0bpWHb24/H5EOgw4SU0ieCgN5L3RWZsJ4YTWnCrr5ht4vArwFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058329; c=relaxed/simple;
	bh=2oXUQbxELWm0msG9BNjuj/jfoQpvKlbLBxU4s/TDyRw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bqy8ENYHh9zsIKmu20vglHgy/pfXpfP6LszCxPEuGXyUf3yQSZF5GpkdOq9cCCq/JMUAJbSdSA62cKKw9xUTe88QMs1cNix2gJ8r69hYxRq6+Hqw13NhhO347tat/WvFllu20pqENNUDXswm6HQ9N7ZLLBx304ewz8I/y74nJ8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cdM5JzJf; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cdM5JzJf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRJy8eHaCnbcu3NB93+R821g2VcTLnlDXDcAvPcR/j2gQMMm0Ot2GJqTUDqv40jabz5lj742OqLEFyJ4nQjzhu2JD1Q3lSQphWrcKA0FbP/BJHAdFqE8Eq+U6RbjkVwJz0dcwtqxwyDglnGERLU3u3aX9V7KUudpnzcN1MNDtpTtQiZQGHyZAUqW1WPbKNQ+i7ESAfcO5UFEwPsmtcPJpjt96/8RoNc4MSAAXHmoPTKkLgeuXG91cunvgex5CX5R87id+RCT6HImP8UpLnu+FMl8ettSec/cdJt/Sm8Q/zVKu5OuzD9KZAW7sLG/f+rixmRXRMkrEaxJ0Z19fLJ80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/KdOs3v99xUVWPpTci+PVLv4O788CGYyyZ+szSX1V4=;
 b=jHgqKbneCDw+Rjd/B55drYQ7BFkeKPh15JGQDi7Hd+USf1DOjoKcsC7JAaL5KdqCF254+bRoNPz1mRyJWMmy4BMEdqy0rs2QFqg4gFVwZrdVe9d+b0e9tU1qnFP20Ha5YjRB2kEl/QxRpaWDRI+yHOZ2jauHESX8nKiGQewiW/vSE+HH15eX0kz0fZnYcoNexFANHIt1IWu7AbZ6o4tckXaN3i/aN/3etMpwrzjQ8aRnrlfQ0wCnfGKKtEVErtodESc4zDDsDAXbyZYEDbxsjR7Ki0hGYMTbVdA3QzKvRqAGjnIwNiMClLWvG3p6Nqmbp0odItCB9UHlmmIjfBEX8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/KdOs3v99xUVWPpTci+PVLv4O788CGYyyZ+szSX1V4=;
 b=cdM5JzJfzEDsgpZ3GZcEub6VMcZ7pyC2ZdPVReaKV7T5xs+PLH721MHqvllRXDU12Tw9EssCj8lFMLyvz+T6n0RwF9S8zR7oivxNNA+bB/3dPWKi8sohq+tn+dkMW/8JfqXTq+cHPprDQxFTUHXLNTpJk9usuTdS9l9oEQMQhSno1978zLT3JK5GgLEKu/BcyUWKOCyz07wlM+aDpfeYCNVDYs+PeYSscgzSHjc+5sbevI3ukXG+rHNekoZDuB01g0HpvN6GFqbvKDDf9aV6Uc0OdhT041r8ZvpkOOwahOOVVSVTYBKJvVnKlnaVKtYHEmzjNG8v7vKKT6Bo/mQafA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 09:32:02 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 09:32:02 +0000
Message-ID: <f1d671ff-0429-4cb5-a6e8-309a8567924c@nvidia.com>
Date: Fri, 8 Nov 2024 10:31:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to
 UNKNOWN
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: jasowang@redhat.com, shannon.nelson@amd.com, sashal@kernel.org,
 alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr,
 steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com,
 johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Carlos Bilbao <cbilbao@digitalocean.com>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
 <20241107164932-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20241107164932-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: f167c711-ac16-4e71-eb74-08dcffd8339f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L2NDYkYyeEdXZExlMmpwc3Q2SHRtS1plRWN6RnZsUWRNaTdqKzlLZCt2VGl0?=
 =?utf-8?B?amcrYzYyUUYxQjJmWEF0eUxDTzhMN05JZVNvUlpzdUJ1MDR0SEM3T1lQbUJL?=
 =?utf-8?B?QVdDWG1Fd2dqbzQ3MEF0T1VnTkhhcnQ1NUlFZ3VidUZTNDE1L291Z0FtNlgr?=
 =?utf-8?B?VDE3RDBrRUtsQTVwRzdoN0F2TEJFSUcxTk0vVzl4b2E3RG1aajdhZlJDb2pK?=
 =?utf-8?B?cGxnT1BnbEY1bEFmb21tWE9YVXcxY08zRXVCNkJrN0FCVmU0RktHZFZPTURa?=
 =?utf-8?B?bEExaUJTSHNoTWgzRTlxYU1zNFZwTkN5M0NYM3BNTk5ucHp4OEFQZkZrdi9T?=
 =?utf-8?B?NEVSZWQ3U3puNnhCdDM0Q1BVcmpMT01SRERaZHVxdzJUVGVyME1VN29VUkJR?=
 =?utf-8?B?K1RtajJ1ZTVaSExJRWtWSkxkeStLYlp3ZWFGejdEcUc5M09WdVVlQTllaUd3?=
 =?utf-8?B?UzBEUjBCWEQ4VGQ0NXN0K0xxb3BLdllsd2k5UDR6T0VSdm9qajlZMVNwR0Y5?=
 =?utf-8?B?RWhENkh5MWhHVjY2ME41TEc3WW9Jd0cxN3k1bHB3RVpYRGgrdmU0KzNHK1Fu?=
 =?utf-8?B?T0svdlpWZW16V2xlWlNDN0tMNlJKVzdzelJtc1NVU1E1Wmt5REdidk1OcXRG?=
 =?utf-8?B?NDdUOUNNTE1QUnpoWXNEY1NJQSs3YVZrRGkrKzFHTjlBMzR5YS9oakFzbGFk?=
 =?utf-8?B?NlpLcFVtejJWcGE4ZUtFbmxkRFFiNlhhRDF0d2JFdHZFb0orWjREeWF0Z0pU?=
 =?utf-8?B?dUZMVFhwNU54REdTU3JCakhKQm42RTZ1V1VyVlh4dXRPM1FuT3pCRkNJWWYr?=
 =?utf-8?B?UmR4bUxvUnlMY3ovZE4vTnRlelhpZTQ4M2ZHa1RLR25KdjV3TUdjTWRUZldT?=
 =?utf-8?B?cW1sNzM4MGwwcUJTWDZ2NVRpRUhPb29JN0dUVHYrVENZeGh1STM4em9FQkxE?=
 =?utf-8?B?cmZ6OWZ3Q1ZXQnJWLzFPM2hJQ3dLcFd4YXpCMUg0TUFsNFJpZ2J0alRDL1Zw?=
 =?utf-8?B?ZVVpdEVTdGFjeEEzbGpCUmxqLzF0ZUZQaE9hYVJWRC91Ui9NYlhvQ0lvUGtl?=
 =?utf-8?B?SWFRbkt5RkNVbHo3VUZKeDdrQ1RSWElLMWJ6Wm12RE5KK0VoVExmYklTRDdY?=
 =?utf-8?B?dGVBWndvZ1hYMmJMOGtLa25JWXBqeXJlVUdpU2xzdmJsZm10Ym1ESmw2cFJF?=
 =?utf-8?B?NGxKOWJCa2dwYUtoRnl4NUlucnFoZHdGaENSU1grK2hoV2oxZ0tsbWNjTXZG?=
 =?utf-8?B?NDJNeWhxY3RLckxvY2J0UWhWSmJETk16MExhU29ycWlkby83emczcVVmSEY1?=
 =?utf-8?B?b3JzYU5KNGRPN3FMUTlLS01oaVozaHc4OUlybWZGWkp1VVFRb0xJVU0vcFU1?=
 =?utf-8?B?YTNidW1HMG01Z3Z3NUNEK2gvQW5DTVhTOTU3SzA1QVFDTGpCcEFCYVk4ZFpP?=
 =?utf-8?B?OGQxSG5WWU1hZ2U2dUNsUmI4S2pDbHczN2h4ajlHRHZld25wVUlLbzRLVi95?=
 =?utf-8?B?OFdHcUJzWGdiRHExaVhzaS9WSnJRZkJ4d1YzOHVZL0pJUVJNblVaeW53dGRX?=
 =?utf-8?B?M0phbXpmcm8xOE5MNFd1RE1QWXlmOXlWYTRIYnZsTW1wZmtMMTJIaENjczRk?=
 =?utf-8?B?blNEczBqczZKQkxrNlg3R0lFVVJUSm5Ldm5kZ1dlOE4zOXVrZVFXcXlWL3Fq?=
 =?utf-8?B?S3VLaVhBblVsN0VLczBaTmpzNEtQeEZxZk51Zk13L0NyaXIvL2JYRWZiUUZI?=
 =?utf-8?Q?oHHA0a0pzaigNk7SfBepOA/8ukk60o2powvL2I6?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ajZrL2krTHNDNmhWTlNOUThiYndaUEp6TjgyODZwdnpVQ3Z5MFNlZ1MwMFpL?=
 =?utf-8?B?V0NBWEpWTE54c3VuQkhFSldLSDFoVGRxbVUrWSs3VUtJbTB5YW5kRlhDWFhD?=
 =?utf-8?B?UDA0SnBCZU9hUmpvUzEvUGpwK3UxY0ozZzBqNXU4MDQ0RDNOaVFKV2V2bUJL?=
 =?utf-8?B?WkpyVzhHMm9kczhmWHg3TDZGc1ZBSkEyOWU1RlBNbnRiVG5QbGRYL1pxNjFt?=
 =?utf-8?B?RVpqOHJnWjNuaEtudWx4QVFXWHF6bEtJb0xlTUpidDZpTWlRTnJJSGVIMnp4?=
 =?utf-8?B?Rzh2Z0EwcGFtUVFxaE5sS1VaT3M2SzQ1Y3BFT05JcjczWjBmTEdLcm9VNGZs?=
 =?utf-8?B?bURhK0xoNURSUW5zSE82cUNRVmpyTXMyWkpxOXN0NlFzeVlsNTVLYTk2Z0JH?=
 =?utf-8?B?SGtWcTVZaTVaY3duUHp2amY0M3k1M0hNRkNESmNtcW8wMFp0d1NBY1RIYkNB?=
 =?utf-8?B?Wit5SFhtWXBUUWZIRThNSWpBeDZVYlIvYmlFUTNQVkpHN1gxcU5BVmRUQms0?=
 =?utf-8?B?RGNyclRHeEV0NzQzRWNTbjhBaWI1b2Z0c0ZWdG5zZ2pBaXpDWkJYTmZJeHFp?=
 =?utf-8?B?Vmd4cUZnOHVSVGlabHJLU1FvSVRQOG90bWE2Z04vV3NqcDNJUGlkbVVYV3h0?=
 =?utf-8?B?c09iS3NYVjV6NmJmMkVJYVhMZGFDakY5QXVVL1BRa0IxZ0d3dktCYzB3ZTdM?=
 =?utf-8?B?dEw0SWIwT0diMEZKS0R4ODJvRS9KQ1RQM3h5NE84bXJBeis4eXVycGhlSUow?=
 =?utf-8?B?V1hncU5adWpxMVhVSmFDVVFONGxzS1cvSTlLSWZxWDNSbU1ZMDFKYUtsRmVo?=
 =?utf-8?B?dDZYZHBLd0NSRk1QMDVyUnhpcEVGZnpIZERFMG8rVUpCQ1gxb0RISjkrM1BS?=
 =?utf-8?B?c01FazBlZSthRkdxalBYQWRBVWpiTGZLbFBDVzFFdmk1cnBteWIwS21YbU56?=
 =?utf-8?B?NFhlb2ZLRGdkVy9YeUtLaXNCU1dhTlRvazUxbDM4UENlemtWVWpaVDd6T3hx?=
 =?utf-8?B?RjhiWlE1QTc4TmV1eDFKY0laM2pEa2lhRHR0UEVlV0V0OWRJajFpU2E4Zm1y?=
 =?utf-8?B?ZEtYRFBoeU80TVgxQW1SSHVMTWI1SjFzMUY2cS94Q3ZWeTVPS0VZTnljY0tE?=
 =?utf-8?B?U2tyYlc5T0hoSFY4YzVjeW9wSmFLQ0VLMWpHUkduMDd1R2p5b2tKL3RuYnI5?=
 =?utf-8?B?enA4U0RpZW1IbkM4OGVxUzJJamx6dkxKMVpadFhBWHA4TGM2SlFXVGdsOTRE?=
 =?utf-8?B?SGR0aUZ5WlczSWFRbVJNc091MkdZUjI3RDUvT3doUkZsRDFZSEorL0Nxcndw?=
 =?utf-8?B?dW5PRS9sSWwvQnlaazlYU1ozV0dFMFBZZmExTnJBTzZ0ajhNSzJRV3dRT2Rp?=
 =?utf-8?B?S0dkeWtoS0xGUllvbUY4dnY3ajlFUnE2UkM1cGJDWnptSVpJQjQxRXJvMGVG?=
 =?utf-8?B?NVVXYzZxZE5NZmJuajlINVlvUEtFRUFIV3NHZEw3My8rcnBzUUxZVnU1T1lT?=
 =?utf-8?B?cG11aFBYSThkenhkUFAwam93cXVmKzNOTjl1NkNES1kxNE1OWDVNdlhJaFNT?=
 =?utf-8?B?R0ZxTkJWNllDcm1mN0c0T0t4aXNKN3hsTVJ2SndzOE1EbDhadWxvTmQ5RkVq?=
 =?utf-8?B?dVpIVjNpVERvNWlzVElPQzIwU1NXRm9VK2hTUzJMWVRxSTJEd283T2NnNHBa?=
 =?utf-8?B?QTNQcU8ycjZZcDA1N3FzMFVlQjBiYkZuT3hORVVBVy9tNlRHbU82bXFPSHI4?=
 =?utf-8?B?U3ZPeGhUMWdDMWN4ZnRNcjEzMnBzTjh4MWUrdjRFWEhub0dpTm1WZDl5MWRq?=
 =?utf-8?B?MmhaVFVlUE5TZDFWa0pxcG5qQnJKblFnYkNmekxTNWpaNWw4ZXlOUFVoUU4r?=
 =?utf-8?B?WnNpdFV1OGNmeDdhMTJWa1U1M3haRkhUZnErMXVMRmFVVW52dldtZVlKRTg2?=
 =?utf-8?B?Qmpvc0FSd0xSVVNmdTgvYTRBUDdUNWovVzVhM2JPdVZ5TmJZSVRPZVhSUmEw?=
 =?utf-8?B?cXdhSGx2eXRQUGxKOHh2UVNqZkRleDdrTlJyazluS1RpRDdRMW9RYWJtT2hz?=
 =?utf-8?B?T0NHYXBXdnZKbFhsekdmUE91N1MyWDdsbk5NNldPcFN5MTNpZVBTR0R1YWF3?=
 =?utf-8?Q?nhMBDkD8gsOTNztdzs0dO6x6z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f167c711-ac16-4e71-eb74-08dcffd8339f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:32:02.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnsuZUHKpY6uJOh9/lg+JKdCV9N+LR+ClMlfR6I9f2eBqymUb80eU75M6U+CWkHPjI9x+cXWrADLBs8kmKl8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026



On 07.11.24 22:50, Michael S. Tsirkin wrote:
> On Wed, Sep 04, 2024 at 10:11:14AM -0500, Carlos Bilbao wrote:
>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>
>> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
>> This is needed because mlx5_vdpa vDPA devices currently do not support the
>> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex.
> 
> I see no logic here. Without this feature bit, guests will not read
> this field, why do we suddenly need to initialize it?
> 
IIRC, Carlos was reading data via ioctl VHOST_VDPA_GET_CONFIG which calls
.get_config() directly, always exposing the speed and duplex config fields [0].
Carlos, was this the case?

[0] https://lore.kernel.org/lkml/afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com/T/

Thanks,
Dragos

>> Add
>> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
>>
>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index b56aae3f7be3..41ca268d43ff 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>>  }
>>  
>> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
>> +{
>> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
>> +}
>> +
>>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>>  {
>>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>  	init_rwsem(&ndev->reslock);
>>  	config = &ndev->config;
>>  
>> +	/*
>> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
>> +	 * setting the speed or duplex.
>> +	 */
>> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
>> +	config->duplex = DUPLEX_UNKNOWN;
>> +
>>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>>  		err = config_func_mtu(mdev, add_config->net.mtu);
>>  		if (err)
>> -- 
>> 2.34.1
> 

