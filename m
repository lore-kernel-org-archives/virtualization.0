Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239C161339
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724109869; cv=fail; b=j1fIvK4Rfg43ijvR4OZbwXtagN3tdzvrQ+0LhKXUEwYe8pGmHMbkW+hZ00Lg473oXx1eOIWjk0t8qCt/PMxthi1LTV9zYZus6r8lpKT3lqhwpxtLMginJi3d12YkYwWO73WDbAyUsMX7mROyAnpxlFiEVYDtS9wAMvwc0ZYfNa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724109869; c=relaxed/simple;
	bh=xy4gESU/hvZxuEdvsDPUU0N6gaXTwJQV0Ik52b5H5Vo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E51rmiCypMGoWmXSRtnBLr36yrpYCmA8XHhw43TJhOCGFHXT8t05AC2T/+lE6c7zgBQ7LJoMP3OW0HAfPgewAn8oPbYhEczenA0Cvbm+o901IEAmkvQuXjjamWkbKalvQbAgODChiL+81wR7mc+aAq0OLgxovHcnec/ZZ68Hv4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mhX38QHG; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mhX38QHG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhVIC1/rFB0GqjwP6CHb1mOSbTFxwGYwzj+5AqmfltwJTI4UNr6yYAFW41f424O7gLTE8pDdX2a01uZCQopLsxTahR6rpIOzsbUrFDOuBq+ntJoBVYK3wlVWcpp6HZeaq1HguNHhd24pw1lKRwLNOD/dPrWZf1nvB2eqdv734k+znvAc4ILF0nkK5+/WJUbA6LcKP0cPvXtnuta5ukf4HnmfHpctFrBT7eYkzlE1JJijCiikC68GiPHbwRpPNe6S9OrWo0k3Qwe61VP32bL58bLAmEjZjK3RgIInhMZpjHfIugfTRmCDAIfUCgJnQ4mtiCpjl1+ylp+5OSTyj9OPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5E8hczwkJKphysY+ijzc8W24tjpY7MXzbW//Y40uqw=;
 b=LIGKytKJPMtve4sbD2RE9qbBrbgrfaYgCK6YTiQozx+Yxe3PIoBPCA7QGVLt3Tr4RB3CEh7PEC0r1AYBvL9an/R6BCnmCceo19SYaJIAgX/L5xQc4qfCBNYpoZvYMWEGJyw3ZxDrzJFpXGZbf26qyEZaLSakkyJInvBzlg9lEO1x4Fo0eShIPWvD7/FqQS+mO4dS/QDGOm5EFQVo2mqZIAV5+vdJShbLEMjkQQtrALHiM6Px2K4vrSB/tmO6U9EUjFNqO6zEjnMXnDhu8poVayuZikzegQYc/zIeynAswWar9tC2mQjHFeDU2r5hRgphhUPPQ1YrQiPajuFn3M7wyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5E8hczwkJKphysY+ijzc8W24tjpY7MXzbW//Y40uqw=;
 b=mhX38QHGR0PcY/a/9454p+coadYIjUrhoHWEqvXx+6uP7e2/FO5JjAS+Vnj7J10iRLTcdzHf1wNxJwnOY/0lUXHWWwqiIiOnO4UGbVBrsbUZvLJ6QuZHCuVAVj2+E1yOpRadx4yjRskxbe17OvNCJRiJrYwc2BEoJJs98nDsYJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 23:24:23 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 23:24:23 +0000
Message-ID: <f9fd8da2-b429-41a7-aabf-2eec3b3b9d42@amd.com>
Date: Mon, 19 Aug 2024 16:24:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] vdpa: Remove unused declarations
To: Yue Haibing <yuehaibing@huawei.com>, lingshan.zhu@kernel.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240819140930.122019-1-yuehaibing@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240819140930.122019-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::11) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 161e1284-a922-461e-e6d5-08dcc0a60f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3VhNGU5Y3Fjcm9CaUxPbHc5K2RxOE0wa3ZRc3dMZ3dTbEVBcnVQMHlkeDV3?=
 =?utf-8?B?bFA2K2xiUXRjYU1nMmZqZDJlY1k0MTBCcXZPa2hvTEFsMUVBUmU5cVBMWHdu?=
 =?utf-8?B?cE9GVVlLV29TYzR5Z055NDJKdWRoVW5OQTJpdXlRN1Zmd1JVZXJpMHRZMnJJ?=
 =?utf-8?B?d2ZGU0lpQUtkdDVmZ0kzMmd3VVFXS1FQUUl5T01WNXE3R0RqenFxMTU4aVJG?=
 =?utf-8?B?TXpwZ3VCTjFncEVkcUN3SWE5a0pNaWV0bmVJa2x1UXNzclh2azJUczVkRXBt?=
 =?utf-8?B?Vm10S0ljRTlaRDdKNThMc2dkQmFLR0p4aFlOa1JKNWZienJoMnNTa1pzODYv?=
 =?utf-8?B?ek5XbTkyQVcybmhucHp4biswWmhac0Y0RHNadnJxaGlkS3FVNzYvVG9NazZq?=
 =?utf-8?B?eWMxMXFBcFJ6VGc4MjYxUXlqMUw1bnlDWXNOMktGaVhNM3RZQ0t4L0JnSkpL?=
 =?utf-8?B?Sjc1UnpIUStIaDhvY1IrRzZ6azJGWElScTcwQ2dkOTVxZ0lobWk3b05uNXZ5?=
 =?utf-8?B?L2NTbUQ2ejZPb2xBVHRtSHdPdXdGU3IzUlRRelVEdE9ZNDB4QmdNU24vbk1Q?=
 =?utf-8?B?NXVqTjUxVEJEaytsNVd5eC9sTFh0cVpPMmdXckdXTTFJVW5rSjREeFRmUW9v?=
 =?utf-8?B?NWo4eVQ5TnZjYkZLazdDbE5YY0MzQ2NzMW5KNjBhZVE2WTdNYjlVZDlIZVZp?=
 =?utf-8?B?aDhIa3o4YVJiNjYyVnRCUzZJYkZEaTdpNVVUcmpJeXhKV1lNWWtzbEk5dm02?=
 =?utf-8?B?L3Q2Qy9ud2ZpRlNPcytuK1FZdy84bW1HTDV4QWNoekJta2JYZnkxK2xSVkRM?=
 =?utf-8?B?dG14VlNoREVGYS9oR0ZGRmpFZDhsN2V5YmtLNXlyeFI1eTdPNmY0MlBLdjVT?=
 =?utf-8?B?cDRwZElqdENOTnVjZjdYNkZ4QVNHMDNIcDBPWDU0TFJKYzZiYUlXd3d2S3BO?=
 =?utf-8?B?TDkvMmI0bFNBN0VEQmpGWWR1M3pTMUNybGJvT2dmN3JtcXY3dUxYMVJwYUZN?=
 =?utf-8?B?SGtkbzROem9idmhITVk2c0N2SVJlcjlVY3hTaG1BK0pUTjd1NDVNZWFGMVVD?=
 =?utf-8?B?NEo0QmVYamNrTDRIQS81MnZubmduV3locmp0c25kR2NSdUFjVWM3WUxHdFBz?=
 =?utf-8?B?dHBwZ0twYWZHQ2Jpd3VUYSt4YmJPc1QyVmdKU0QyS1MyQUFQS3R0dTZBMlVq?=
 =?utf-8?B?dnhpMXA0SlFRaFBHdktjUDMzazBjdFlEeGFYb1ViSEttVkI5R3BueDV6Y1Fs?=
 =?utf-8?B?NFNoRXZZK2FyczVveVB0V1h6VXNsVFZ6alBKcmtmaXNTUHVZSVNGVjBFVm5o?=
 =?utf-8?B?dWxuRXFwMXcvayt5QUE3aG15RnBiZDkvb2oyelRrRmZGLzQ2RHpnRUNudUxI?=
 =?utf-8?B?c0V1aXZZRjNNeU9KK21id1JaQmhFMzVTR3VVOFN6L2hZM1oyVUhpcW9NSVdM?=
 =?utf-8?B?YXNsQ29PcHQ2TEZWd011Y21BS3dNNWt5a3RaNDJvUkFRZFdWdml4ZnF0TzZh?=
 =?utf-8?B?bld6Wi8zdG5jWFNDUzl4OEtqOGNKSjRGQnZmWllrVUNtS2hXOGdLa1ZWM1pw?=
 =?utf-8?B?cSs1SHNSRklJVURWa3VzTVpEVVhmdWw1VVpub1NxZFdOVGNxck1yRTJkdFpv?=
 =?utf-8?B?QkZEZTY5b2MwOXpBYkNMbXhWbkptNmduWWo2N1BLM0c4cnkvak1YWDVlOE9j?=
 =?utf-8?B?TlIxSEp5Y0d2c0s0UEJoOFFSZXVCUjZHQ29RcnVpNmRTeC9ERGltNTVXODFt?=
 =?utf-8?B?NDRNT2RlNjVickdTeHRwbzJrL1R5eHhrUzNaNGkxTzcrVHZmcVcvWGowTGJS?=
 =?utf-8?B?VEZYOHlqWkNQUmp3SkVuQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckQzU21PSFFYdlpnalJYMzBZWjYxVUVFTmNLN095eHdyVEVTYkVPZ2I2b2ZF?=
 =?utf-8?B?U0o1YzhPWVZ0cnB4MlpiaHdYV3owSmlGUnZyME5YWExmRm1MTmJpdjV2NXFr?=
 =?utf-8?B?OU44bm1YL2hxRmFHVGNoVjFTYnBEQjdDTzdxZVlka3YxeXVFVFpwZ2dTNkhh?=
 =?utf-8?B?RlZ3NlJGTllIQTVsTGxPL3JtS2hzVWtUTXRhOU03SzBuRnBWV08yUGlSMWdP?=
 =?utf-8?B?YU5aT0h3RGc0NmZTYXR6cXphaHJ6WUpFUHdIZHFFZWV2cnlQendDNTlNMU84?=
 =?utf-8?B?bjlGc3lWem9SWHlmK3dmK3RWNlNmbDFKSlFwTlVKaE1pMEc2c2dSODZCeU55?=
 =?utf-8?B?VVg0aitmQzZLaFloUEgyL2ZwS204Sk84T1pxLzBDdnIrMGVFV05FR2szT2g4?=
 =?utf-8?B?aTYwRjg0aC9aaERNaURVWllGSzlqSjNkN1hxQWxVSFdyTCtUN3YwaitvWXY2?=
 =?utf-8?B?RGYwQTJNWnlOYXJBZElwc0lGeGlnN1FmMFdHcDVINHdleVlJOFp4a0RlNXp5?=
 =?utf-8?B?bmowbjNCbjh1S0cwaHRaQUdLczNKdXZpSzE4ZHdJaVZzbEsxTlduTUFqZVFO?=
 =?utf-8?B?eXZVSWFGMkVYak5jWjZ5RHIyOG9MNWNSNnh3ZG04cjBuL29vc1NuM1VuRDlq?=
 =?utf-8?B?N0RmN1dBcU5WMElqalhNSFdIbk0yRXNHTm9zWFlUZ3pCbSszV3A5WG1hZVAw?=
 =?utf-8?B?UUpMTGlFR3cxU2ZXOTIzSDRXUzc4Ky9ORnZpZGp0bG9mL25hN2ZjOGlTa1Bn?=
 =?utf-8?B?ckoxT3c0Sm5aMk1raHdCZWdtcmVWQzlJNlZsdGxRMnN4WURyTS93amhQNzVV?=
 =?utf-8?B?a0phOG4xTCtXSlVwZ3RZdWFPdmF5bzdpTGVMVWlqN014dVRzMVJDMmMwUnVX?=
 =?utf-8?B?MFF1S0YvdTZ1TEpKNHJVWVJJNVZXZ0NXY292RmxSR3ZNUTR6aUhYcnJSWitK?=
 =?utf-8?B?NERiOGszUm9jWDZhTDVFNzcrWHExdjFtYklrOU4rdFUxSzUvR2QxRyt6QThE?=
 =?utf-8?B?eGFFV0hJYnVzcXVKcFgvMVcwdVRiVEVtWGlicVg5QkVyV3JJUW13N0I4MDNO?=
 =?utf-8?B?Y3pzOWE3NjRhYzZTM3ZWa0p1anI1b1JRa0ZuRHpaeG9BR2FpUm5wSk1xYTk3?=
 =?utf-8?B?YnBQNjVBWW1nenhpK3VIRTVKYVgzSkN6K2pZdjFoK1c5bndFdjMvb3FiUTIx?=
 =?utf-8?B?YjdTcE1uejFYdFJVT2hSZjQvM241eDkvZHJvUkFacEoyazJMNDBXck5wTzF2?=
 =?utf-8?B?QkRpSGkrMXVCRytBR3p6ZTRhWUllNDZVcHZyYm5jZGxUYzk0cGxiSDJIczM5?=
 =?utf-8?B?WjY5OW41RUZmSjBEMnkzdW9IWFFsTjZmZVlFc2h5RlVuT1o4M2toakZPRklV?=
 =?utf-8?B?aDl3bVJFNzZnVmd0MjNIbEZvZzBHTGxMbitpUXZyUG9IK2Z1WWFyRDFCL1FR?=
 =?utf-8?B?QW0xNTB3OWpTd2E4dC9rN01TRUNSYmI0MkNzTzdlMW5Lak9OQ0kvZXRTWnlD?=
 =?utf-8?B?WjRRUjU0ZVFvalZUYkFub1VYS3N0ckJleU40ZVpWcHRwV1hyWVRMM215REta?=
 =?utf-8?B?dytjT2hyL09uWjRYU29jcG9RVXNGbC9OdmJnbTZKN3lFeU1BdVQxN0NRMWxv?=
 =?utf-8?B?Tnc5MzV2R3plTmNLeFhadHEycm9NQ0doSVJUOXdpRk5jSzZXNWY1WHg4Zmtn?=
 =?utf-8?B?eTBuc0pDRHJlMzJzYmtkZWM4Y3d4V200V29scWpsSHlyOVhUY01yYUwvaWlB?=
 =?utf-8?B?N1ZZYTFkTmZSMmRQVHdPbzV5RVlxaVdlNzFPNEZlUnBib2x4c0h3a3VVSHlL?=
 =?utf-8?B?bXVEOER3NkFCQ1V1V1NxSDQ1UE5RM2pIZW9jVDBXYnphblQzMlNuRnFVYlMx?=
 =?utf-8?B?YmtjTUkzcXVhMG8vUytWL1BJU2g2SjRZWHp3ZDVDeHJkTU93OTE3N2xqZDYx?=
 =?utf-8?B?SFZpNWNLQmZ5eW13Um94dkVHSHNJbFVHSGNhSFRSSGt6VFFycFlLUlNpY3Jh?=
 =?utf-8?B?MFFWVEtGc1E2eDhEUHNOUDJaR0RvREdVN2p0eHptaVE1YzNKZHdDei9YcGhn?=
 =?utf-8?B?UTFqaCtDVzhEMFk2TXN2RXRTaXRWMHVjeXhqZitqK1FvRVRkNWl0TkdXR1kv?=
 =?utf-8?Q?VJyi9gP6d99M2g98rthbVTr1q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e1284-a922-461e-e6d5-08dcc0a60f1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 23:24:23.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ou9TAvucZRsxp5D3m97PD1WQ/ZiuHrqEI4MgZVE3rSI/D/EaUJEwsXfq3XOCdvyq3klvCkiWFPjGQrc2Pu6jag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

On 8/19/2024 7:09 AM, Yue Haibing wrote:
> 
> There is no caller and implementation in tree.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>   drivers/vdpa/ifcvf/ifcvf_base.h | 3 ---
>   drivers/vdpa/pds/cmds.h         | 1 -
>   2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index 0f347717021a..aa36de361c10 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -112,15 +112,12 @@ void ifcvf_write_dev_config(struct ifcvf_hw *hw, u64 offset,
>                              const void *src, int length);
>   u8 ifcvf_get_status(struct ifcvf_hw *hw);
>   void ifcvf_set_status(struct ifcvf_hw *hw, u8 status);
> -void io_write64_twopart(u64 val, u32 *lo, u32 *hi);
>   void ifcvf_reset(struct ifcvf_hw *hw);
>   u64 ifcvf_get_dev_features(struct ifcvf_hw *hw);
>   u64 ifcvf_get_hw_features(struct ifcvf_hw *hw);
>   int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features);
>   u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
>   int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num);
> -struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw);
> -int ifcvf_probed_virtio_net(struct ifcvf_hw *hw);
>   u32 ifcvf_get_config_size(struct ifcvf_hw *hw);
>   u16 ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector);
>   u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector);
> diff --git a/drivers/vdpa/pds/cmds.h b/drivers/vdpa/pds/cmds.h
> index e24d85cb8f1c..6b1bc33356b0 100644
> --- a/drivers/vdpa/pds/cmds.h
> +++ b/drivers/vdpa/pds/cmds.h
> @@ -14,5 +14,4 @@ int pds_vdpa_cmd_init_vq(struct pds_vdpa_device *pdsv, u16 qid, u16 invert_idx,
>                           struct pds_vdpa_vq_info *vq_info);
>   int pds_vdpa_cmd_reset_vq(struct pds_vdpa_device *pdsv, u16 qid, u16 invert_idx,
>                            struct pds_vdpa_vq_info *vq_info);
> -int pds_vdpa_cmd_set_features(struct pds_vdpa_device *pdsv, u64 features);
>   #endif /* _VDPA_CMDS_H_ */
> --
> 2.34.1
> 

Thanks!

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

