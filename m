Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884B1D4152
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791597; cv=fail; b=kpxhFdQGBKaq8sAmMXrrfsCgIR4hadPAfmSpKdOVWqRMkWlBnaRx0fO64QL8AXlmCkBL2Lw8i18aD49K2iGaO4sKunBCZSn8RZAHPk7Hf3q9A6HK7NKskOMil3OcKb5+0aM1yThAkv3Iu9C9oktSB0MMSPsgzIbmu2IBMILjsNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791597; c=relaxed/simple;
	bh=oatknqzdaSxPNwsdN0oPLxYismb22rCfLgivwND4Gas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uB8ZYmGiMgdbW+OnVyRzZdtQvEBEfgBwwp+aq4+FlfBOQM+m+HQMHJkfuOBWZUMPvq7xSRgfyS+i61fpjsgZNQSVmqZm9amHZazvlAzdJ0PBWbZbELAguxREbFpnkN0g3aQAKY0JQjM6cbr62gdDTIov/8wIgCQ+bCN6IlM+NE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pScrfUCc; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pScrfUCc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhJplMi0tWF21ipbMXn6Iw8zxX3oZDOa1QH0wnpzv9f45gWwU6SIUhoLpy5lxqGgXJcFoJSaTrTid4AmPQuSw3q0E0fMqHpJaRWTczJxElDEmkSl1tn9WhIAZM3pZgSMgVwW4vooPVBcP0uLehuC7WSPrbWbav3gFSkpwnpi8TrEpbgdWMAnD5NT+BgUqMoYTJh869ZLkfSt8w+GnLvqPhPlwUez8f1Gmpg6x/2LL6AFQg52jzhZfuxZ7pYHEzBftkWputupE2itSsXZsKWVpLp1gXGwrmurh7ReEpZrx9SfdrbgxynWe19lQckVmR4d3WyiY9q1c2j/1ogXIcLVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqjJ7oR2IP7jnhLQPXcAs40fUjk39Ln73sAiRLKLW/w=;
 b=K0VCjCvdRtrzMp00l+VUbGJ4hPIiDACGNYIPAAYxCLJ4c09gjBiwurC4kYp3aCi+/poHUj0CwkquKPNvE4XiNdircoB/+/SV8IplMuUJ+n+QDquZiLUJX09NuzCPyRANsSAjCsphAkqTwi1kGB3iSmf4E/oI1XEzZQwrsxfQSsmB85BZXentecmNVlHOCTM0zppehFnRbgSRMj8j64VSdvdtzo70HHeZzJ9v+avED/1dO9EIJqkKvA2MjSz6TkJ6j+4W5QHhuIIQUQskd33BsqkyAg9aOGKMimOLyFKBiuD5JzUxk5zQbaAy2aB6y7YhOVtLy5Fzf7cnqgASINuuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqjJ7oR2IP7jnhLQPXcAs40fUjk39Ln73sAiRLKLW/w=;
 b=pScrfUCcUjKUZqwG3xaCnbk1qzrqFCT1Fg0znj9BkYtQKJHzyGUz8lh1ScuQEgML8hR3ZQJ+nItalosBHQtdsSvlyVHPokygUa+dsvMo9nIEJt9AxQxMyNW+aDXnjSY1gya53jYOJeKViFthirwIsbo7aaUmtQfFtlyLEw8p9PU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Tue, 27 Aug
 2024 20:46:31 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 20:46:31 +0000
Message-ID: <0984623a-6acb-4569-bc6a-7a32bf2c006c@amd.com>
Date: Tue, 27 Aug 2024 13:46:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Fix invalid mr resource destroy
Content-Language: en-US
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240827160808.2448017-2-dtatulea@nvidia.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240827160808.2448017-2-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::16) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: a8225ea4-0885-42b5-ddc3-08dcc6d95506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djBud1VYWC9ZNGo5cm5WZVRDdmFhVExhMzdUZ1BjTVNtc2VDTkNRbGovZDRj?=
 =?utf-8?B?cGhJNW5peWlQeE55VlVUV3JzUURNb2swODJtU2FERjZ1WWJ1SXJ0R21aZW5W?=
 =?utf-8?B?THRCMVZBU25DOEZncW9QNDZDZDVUQUFreTRGaHVRcW1hejVJVHI5Y0Y0OHhG?=
 =?utf-8?B?Y05EUmNXdmxtL0JZNllGN3I3dWROdFo0ZzNPbjBpVVh6ZFdaRHlYZFFKK1FF?=
 =?utf-8?B?MVpXMm50a0tvTkt0ZmFCUk9xSnBGUkRwWlVRNGpTOERWZGhLemxndzI3UEU2?=
 =?utf-8?B?YXNLZ2JpcHpmVDJReFAxaFFYVEV5UitKWFA1OVh1YWRndlByVldONndaTWw2?=
 =?utf-8?B?QlhtTjFEK2FlNXg3VDc2QTBtTDZXcSsybGx0MWtmbVVJUmNmdkh2UmY0NVdx?=
 =?utf-8?B?MkcySi8wUC8xaisyaDZ3ZCtYcEJVSW1uRG85cjFrZEJBSXRZU3BSMzRnSU9O?=
 =?utf-8?B?UEdhRkpqQzJ0VXpKby9LRXJrWnNkZGlIUVlTOStwbVpLUjhvZlRGR040TEhX?=
 =?utf-8?B?N0J5TXZDRUdGZXIzMmpRUGtVU1V0OFJRaUZxWWFUMmdzdUc2OEJUcVd5UCt4?=
 =?utf-8?B?MHZvcXdUWjVVYnRxWnhJd25KRWd6ZitTWG1SeWRid1RIeDlKWlFzczJiSGRx?=
 =?utf-8?B?aWVIbkpCVkR5VktKNmFUTkZzTUc3Sk5xM09TanVlWmlGSHdrVmxXOHd1aG9l?=
 =?utf-8?B?UWtMZXVtL2FMc3RkOXBidGlrQjB0VDlTTC9DcWMraXBCK0prajAzNWx6ZUpJ?=
 =?utf-8?B?NHpjZVdvZkVsNENPRC8yamxDSHZieWNxazdIdmx0KzB6bThQeVZKWHdXMURl?=
 =?utf-8?B?WDU0UUl3WHAxcUxmc3RkeEtmbVhDdmFjeXI5S0xCbVVMVmcxSVllN3c0MExQ?=
 =?utf-8?B?b0pWU2JjVG5LZkFmakJEcWJtdlVHTDE4Yll4TFpQSktTdWU3NHBJUzlZVmFU?=
 =?utf-8?B?NnB0VlpqbXd2ejhBeWgyM2R3b0ZVR2g3S2ExNzM2Wm1aOEhSVVVlNWJYOE1T?=
 =?utf-8?B?TGVtYkRiQ3JPSXZSYnRVTkJHUnpkRzE5MEs5cys1YmlsWjFkMStCSWhOL2lk?=
 =?utf-8?B?K3g5UjR5WXVVY21tZUJZdGF4MHRHeVUyME8xbERUY25GNVFITTJWemNnSXFx?=
 =?utf-8?B?RmphRmZWVy93S2tJTjBBQWRJMDh2M2RialFacWlEa1NoMDUzVXhLaUdtK3dz?=
 =?utf-8?B?azk4dHRwdVRGWkxHQ0JVMWFoSmpQblJrOXpWRHkydGpQRHJ2TmtyT1VrNHhj?=
 =?utf-8?B?Q0htampWWTF2WDl3U2ZqZDc0L1MvSU5FS3J1b3NiaUtxT2Y3K0s3aGRrejdX?=
 =?utf-8?B?SHJiSXIzditRL2Zvck8vc2EzKzk5UStaU2pKN3hVUnhEdjNLQ2taVkdEYTNn?=
 =?utf-8?B?NnFUNVRQM0xmcGpJVEsydkVxb1ZHYWFTZFNORFZLNnhwMEhIWkZiZEhIbWxR?=
 =?utf-8?B?R01leUFoZHc3Q25BOW55Ny84amZqdWlEclFHMUFYNDZVc045N2ROdUpUR1pI?=
 =?utf-8?B?ZTFMeVNDRWJUcmpZZk5xRjJwMmdsNEJhZmxCTEZyRkZtNmhZbWFHMG5kSUZt?=
 =?utf-8?B?MDRKSERkVEZ4bGVwNnV0MGxwcTBqRnRZeW9wd1NOclVBVVArSjZsQ0dHYU9K?=
 =?utf-8?B?SUgreFNyOEl5YmxjMm02azNGYWxTUSthQURVK0dMcU5zRXN4TjJ0RWxpd0ZS?=
 =?utf-8?B?eUI5a1BTVE5ScENlOEx5VkI0VTYveWpKUTYvbmRPZldHeHdpM3NUWHNUK1dq?=
 =?utf-8?B?WHE1YzdMRStlbUFSNHFGbmtNOWJrcDJ6N2drT2JneGdyamlpKzhncUQzSHBI?=
 =?utf-8?B?bW1HbEZ3VjlYZ1JwL2dyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlRtdkFYSWpBK1BXUUZaTTRvSWJhSHA4TEtjYWtRbmxMWVluOWZ4U0lDZzg0?=
 =?utf-8?B?eG5Ra1ZRdmtGdjZudDN1aExNa0xZLzk1azh0WGJaSUhrR3pNUVFYNFdUQm91?=
 =?utf-8?B?TVdOcFZmSVFjSkNyRTdBODFHOFhLa2tBam1oK0VGanV1ckZHbmt6WDYwYlhP?=
 =?utf-8?B?cSthbFVpODF5T0QweGdwUUlUZHdHMDlXL2JZYVdKcEV0aEtsenpjRmFzSDAz?=
 =?utf-8?B?dHMrQmJURzlQQlV2cGZ5d0d4N2M0REhBYUVaelRxRnNpdE5kK2pZUHFkY1A4?=
 =?utf-8?B?U3JpM2cwWnNJT3hPK1cyMnduZHB3RXU0bDM1dmNxa041YlBxaGpPNUk2NkRs?=
 =?utf-8?B?dFRrdXl0RW1OenpENmdpZW54bkVHbldLcFFjK056UjIzbkphRTR1Nm9TclRG?=
 =?utf-8?B?SnlvY3R2bHF2NUNMUVdBYis5WUJYWVd2RDA0bGxtY09OcXhuc0pOYTNMcW5N?=
 =?utf-8?B?VFVSZUpXRmRRN253eHExc29VL1dra2UwU01neUZ2RGpJaFhDWG1LRHdQcmds?=
 =?utf-8?B?QVRHamNxMG55RnZGcUVscXMzTnMvRlpJRTVCNkdKbTBSUGJkWE9nSTQ3R3dy?=
 =?utf-8?B?Y0VNZnc0Q3dwQ3REYU0rTmVzTU1jZUR5c3grM1N3S3VJVHErbHJ6bnM3Tkcr?=
 =?utf-8?B?ZEo1N2Rhb1ZLMkRCOERqcExUcGNoZUZVU1Rtbi9sa3FpZEtTNGNSNHp0aDZI?=
 =?utf-8?B?c3ZsREpYcHQxUTk1S2dlWCtIQmErUXVTWUdYb1R5WkkzcVQ0Z2ZPT29MckVl?=
 =?utf-8?B?RkduNDFOaWdhQ1lVeFZ1cEZad0hCK05RdXpVQW5JTk9DaUhUN0txODNtSkhC?=
 =?utf-8?B?WmdlL1BjbzhHMmZleGNqN2tmM0dkL1pPUktyMUFiczJMamR1TVdxcTFhWkdN?=
 =?utf-8?B?RFRlTUhkWU02VVNaUzdqUEY5V1VDWVM4cWR5WDQ2SXpaUytBdVNvbTBDWDU5?=
 =?utf-8?B?Z1dNZDBmYWNKQ2t6R0RMNHRIc1J4cHVwcFNoNnI5azBPUENDbjJFajkrY0lz?=
 =?utf-8?B?aWlnUDJnYk0wODBEMDJGR0VhV2tNWXlMdlR1Sk9USFVJYnZzTmhTdGFSWTBm?=
 =?utf-8?B?aVpLcEc5YVVOblR3Z3d1T28zb3Fzd2VKTkRPbFdVeGV0ZXduNDJteGFnM3lJ?=
 =?utf-8?B?TVNTcmx1S09qSy9JSW9UWG9aQ1RTQ2llNmFscDd0U011b2R0NUlEMHVjYWJ1?=
 =?utf-8?B?UzVqK2hqMUFBNVMraHhLY1hjVHhBWHJ1eXdzbVVMTFE3N1BCUG1VVTVwSkk3?=
 =?utf-8?B?ZU5lcmZ0Q1B3L2NBUDlQb3ZUNmxNMzBhYzUzMldDUkZsMElsaDd2TEtVNGhK?=
 =?utf-8?B?NStKanJseWVhYStSVlkxdGg0ZmhFSDJIMU5XcDlJR2w1dVNhWUZ6bGtWbzVQ?=
 =?utf-8?B?K3ZvMGFpd000UXcwaDRTSndib01JK2hwWTVDdFZpNTRhQ3BSekFyMzBsNEZz?=
 =?utf-8?B?S0VCTER4eDN4bGRob2JSS1ZVOURnWjRtb0RuQ1psR1Mvd3ozcWdnY09senRC?=
 =?utf-8?B?OExhMWp4V1VYTm1RNXZHOFYrK3RTc25WdTM1TWxhWml1eUtIQjEweExiOStl?=
 =?utf-8?B?N0N1QnFHUGZSVFFZY3lENitmZVNtK0tJeXZIZHdxOVlOMXZSSjl3akZjWTFu?=
 =?utf-8?B?OUF0T3cvamptdk9pNTQ1d3U2VjRwT3NhK0VES3EzTTFMUUtCd3JEbzJuUVc5?=
 =?utf-8?B?THkwU1RTQmFUVjhodEdPOEJwNk9xZ2RlaUJ0WFYwcEFnOW1pWklzOWs1TTlK?=
 =?utf-8?B?UDdFNDVwdmNKK2xKK0EwVERJK3Z5aTg5YlJGK0UrNll5QlRKNmJQQjlLMkFS?=
 =?utf-8?B?VFlvL3BwQ0ErOUtIdFhDUEdwVklZTnM1M3N4MlE4MndWaG9GTVhVeGZVUU9M?=
 =?utf-8?B?YlBXdDF6aCszQkNUcnRYNUM2U0pVazZRN2NaSFE4ZXlRMVJibmUzSWtZeFp4?=
 =?utf-8?B?bmIwbmZkQmZYMldhNFdnWjFKTVNEOE5SZWl6TEV5YXJiZ1BidklrU2xnYzNw?=
 =?utf-8?B?VSt6ck1JS3J4MUR5R0wxQkFKWG9nK3pEOTU1Y3Y0cWVoUHFyOU9JY0VTU0NO?=
 =?utf-8?B?TEJpbXZsR2ZoR2V6cmpjMHBZbVZKcWdsb2hnVVpzbHFsbkp3cFN0UWdtYklI?=
 =?utf-8?Q?xpZIE/r/5PyWuk9my6zvEDIoP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8225ea4-0885-42b5-ddc3-08dcc6d95506
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 20:46:31.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTKyJvSHeaO1tMDjRLlWncfjC9yIo3lyUAS4fFFkXfQJ9+f5raoy7oST1QCUNYCdq8SryD37bU/GVHY59OS55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035

On 8/27/2024 9:08 AM, Dragos Tatulea wrote:
> 
> Certain error paths from mlx5_vdpa_dev_add() can end up releasing mr
> resources which never got initialized in the first place.
> 
> This patch adds the missing check in mlx5_vdpa_destroy_mr_resources()
> to block releasing non-initialized mr resources.
> 
> Reference trace:
> 
>    mlx5_core 0000:08:00.2: mlx5_vdpa_dev_add:3274:(pid 2700) warning: No mac address provisioned?
>    BUG: kernel NULL pointer dereference, address: 0000000000000000
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 140216067 P4D 0
>    Oops: 0000 [#1] PREEMPT SMP NOPTI
>    CPU: 8 PID: 2700 Comm: vdpa Kdump: loaded Not tainted 5.14.0-496.el9.x86_64 #1
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>    RIP: 0010:vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
>    Code: [...]
>    RSP: 0018:ff1c823ac23077f0 EFLAGS: 00010246
>    RAX: ffffffffc1a21a60 RBX: ffffffff899567a0 RCX: 0000000000000000
>    RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 0000000000000000
>    RBP: ff1bda1f7c21e800 R08: 0000000000000000 R09: ff1c823ac2307670
>    R10: ff1c823ac2307668 R11: ffffffff8a9e7b68 R12: 0000000000000000
>    R13: 0000000000000000 R14: ff1bda1f43e341a0 R15: 00000000ffffffea
>    FS:  00007f56eba7c740(0000) GS:ff1bda269f800000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000000000000 CR3: 0000000104d90001 CR4: 0000000000771ef0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    PKRU: 55555554
>    Call Trace:
> 
>     ? show_trace_log_lvl+0x1c4/0x2df
>     ? show_trace_log_lvl+0x1c4/0x2df
>     ? mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
>     ? __die_body.cold+0x8/0xd
>     ? page_fault_oops+0x134/0x170
>     ? __irq_work_queue_local+0x2b/0xc0
>     ? irq_work_queue+0x2c/0x50
>     ? exc_page_fault+0x62/0x150
>     ? asm_exc_page_fault+0x22/0x30
>     ? __pfx_mlx5_vdpa_free+0x10/0x10 [mlx5_vdpa]
>     ? vhost_iotlb_del_range+0xf/0xe0 [vhost_iotlb]
>     mlx5_vdpa_free+0x3d/0x150 [mlx5_vdpa]
>     vdpa_release_dev+0x1e/0x50 [vdpa]
>     device_release+0x31/0x90
>     kobject_cleanup+0x37/0x130
>     mlx5_vdpa_dev_add+0x2d2/0x7a0 [mlx5_vdpa]
>     vdpa_nl_cmd_dev_add_set_doit+0x277/0x4c0 [vdpa]
>     genl_family_rcv_msg_doit+0xd9/0x130
>     genl_family_rcv_msg+0x14d/0x220
>     ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10 [vdpa]
>     ? _copy_to_user+0x1a/0x30
>     ? move_addr_to_user+0x4b/0xe0
>     genl_rcv_msg+0x47/0xa0
>     ? __import_iovec+0x46/0x150
>     ? __pfx_genl_rcv_msg+0x10/0x10
>     netlink_rcv_skb+0x54/0x100
>     genl_rcv+0x24/0x40
>     netlink_unicast+0x245/0x370
>     netlink_sendmsg+0x206/0x440
>     __sys_sendto+0x1dc/0x1f0
>     ? do_read_fault+0x10c/0x1d0
>     ? do_pte_missing+0x10d/0x190
>     __x64_sys_sendto+0x20/0x30
>     do_syscall_64+0x5c/0xf0
>     ? __count_memcg_events+0x4f/0xb0
>     ? mm_account_fault+0x6c/0x100
>     ? handle_mm_fault+0x116/0x270
>     ? do_user_addr_fault+0x1d6/0x6a0
>     ? do_syscall_64+0x6b/0xf0
>     ? clear_bhb_loop+0x25/0x80
>     ? clear_bhb_loop+0x25/0x80
>     ? clear_bhb_loop+0x25/0x80
>     ? clear_bhb_loop+0x25/0x80
>     ? clear_bhb_loop+0x25/0x80
>     entry_SYSCALL_64_after_hwframe+0x78/0x80
> 
> Fixes: 512c0cdd80c1 ("vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>   drivers/vdpa/mlx5/core/mr.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 4758914ccf86..bf56f3d69625 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -581,6 +581,9 @@ static void mlx5_vdpa_show_mr_leaks(struct mlx5_vdpa_dev *mvdev)
> 
>   void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
>   {
> +       if (!mvdev->res.valid)
> +               return;
> +
>          for (int i = 0; i < MLX5_VDPA_NUM_AS; i++)
>                  mlx5_vdpa_update_mr(mvdev, NULL, i);
> 
> --
> 2.45.1
> 
> 

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
