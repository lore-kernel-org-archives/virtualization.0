Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F72E62B
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791394; cv=fail; b=kJss53TzH9juvFR80YlGXkG181yt0Q+K8j3q1mQKJxpBrWLcPJG0Ly6u/jX7tKXvGJqmTUxJRVK1fIGq8YYG2lmT7fidsN70xezkHSzzUyew5w9jHTjBSR85W9CEgqx3qn4cPIdUgojkPG4OwKK8qfmJzkcndkpnYGu3tapRpqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791394; c=relaxed/simple;
	bh=CbqQp54DGQpK0rmMeaoPXb48gLjGeTP+7BudpIt5GV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iPJR1yIifNLJK7bFerxMevq2oysknt2svBaVJ4nWQQrvGa5RvwD7GqFRiflK58IqrNJNDPzOxUMBmRWjT7QFN5Irxzzehc4tT5GtQxOxpGaj1bgSVbl9GvwoJGAvYINcsmsuz5tvcuL1GfRi6oGTL03H3wUluQlecSh4rBId7nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o8507Tfg; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o8507Tfg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHYaDJIFfu9en8uyJ+fHk7TmeTD5S5eajpmpvKXPwMl1P/uJ3lhpCaLg9T140I4xbSdDmRUriz+1JWGOMHav4Iw00Ypyk1960AvgkPemKKIXRmeAquJUzD0mpDjM1YqiuyY9RYSDK5lXEDLt6eaIvy1kHm9S5p916eGYyVy/i+EOpDTpY9Vp5MVwiiHHeAEC5VQwXUUqI8w+677W7y9/Qs35SxxZvP7PSVt7Oy3lLlbv8ihaN5rU0xceFLSlbsbK9MYA5MjfG1xIJ8989mlxlzE96kOfXQkFmTjTmFzLFwX/940PXLu+ngwsDJd1qxf1+pnYcuiE3UZcyHYMbehthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpdKquuQEAwva099KPO+MwR24ePIWwL4ljikO/Kd6y4=;
 b=ntC9yupRtJZk8mZpru/RxH0hwO3MTCcRi4WZGzweUxwq7oWTkFQRIRUkvXuCV+XDpd5jmbYGnmDvNiWwDBqrj3nyhzZCZH7i4H/QA6XgD3WMp6xL6zue4LZaIxNQmDa833GOV29Be7u4TZrb1QtS1iiZrST7AboDOJB1GS4YByvB8sYe9xeRenkBrD/mZrWUpzdcFe28KHav7Kqo+m3gNXXb5XoX2mV91rG8Ni29FhGvT8Qi8k8c4G2tXMwNS9sD1qe4WycBP3X5P8hRQC3kc8R7ckEaybkyzKCCM2LGIBIYaB13sMB4tSHFuTHBXVFs+lVPCbjuSG7iMb6MmVyOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpdKquuQEAwva099KPO+MwR24ePIWwL4ljikO/Kd6y4=;
 b=o8507Tfg1n+s4X2MWF17Wb4VRy+2N/3oBiRl+qm9EQYCjziz+BIGAILYRhHDdRO4y/lEW81DOod2ysBtTl33GUxeJYEbvqzp/AkooQnurLnJQ1XTQ0DbztNmz3KIfY9okbX9qk6YCAiXMp/AHEcxssds7Co6BRUmHboqHiuSjWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 20:43:10 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 20:43:10 +0000
Message-ID: <364c3d09-610c-4e37-9bb7-3ca46c3d4c2c@amd.com>
Date: Tue, 27 Aug 2024 13:43:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
Cc: si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240827160256.2446626-2-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0320c8a8-9068-4a18-4c08-08dcc6d8dcbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEkrYXpaaUNpWlFhY29QT3RiR05sUEkrSDN5Y2F3V2lsUlcvbDBEYzVTbDdj?=
 =?utf-8?B?TTFOSEUvZ2h5c2ZmcDM0TVJzQXFkSUhBT0xnTWlFUEFLaXZMM3kxTU5sU2VW?=
 =?utf-8?B?dmwwd0hHWFNpR2F4L3lULzU0ZlVtR3N3NHRSTTNtNVRPUWdYOXBOQ3ZaeVJ6?=
 =?utf-8?B?Y1Q0V3lGRFZaa3puaHFJckl3ODZBSHZTb0JmR01QSk14OUpORW1RM0pLSFhh?=
 =?utf-8?B?NVQ4L2krS0VpL1hONE5POTB2MW53Sm9IR1VnRzFRUUk1SnY4MmROT3FZaDlu?=
 =?utf-8?B?NktjRU9na0F2L2VIWE5aQXpQV0w0Qm9CVEI1b3VsZ2FhNlI2TGtPQ3RZWjlk?=
 =?utf-8?B?dzBGVC9rS01CcjZQWXB3amNxZkhlSTNUUCtLQU9NZExJaGxSQS81VWhLRUY2?=
 =?utf-8?B?YVJZbk92aFNEK3hqWG9MZ0c1eXY5ZXFRQnhYTmRLRSt0bWZkWnYvUU9qRVJh?=
 =?utf-8?B?ZXl2ZSs5QVBnTFpHM2RkckMvcW5XdWI3MVlGWDlWYUg1MHBkcFZpcU9VK1Qv?=
 =?utf-8?B?YUpuc3Vra0ZDdnBPQXo3OXlBendsOHFMUExncEZiRGlEMTJBcEc3RHRFV2VW?=
 =?utf-8?B?NjI5UVM4RUp0U0dLNkZ3TjVRUnI1UGJma0VwMlZhWVdRcmlNcER0SHJYS0g1?=
 =?utf-8?B?SjFTbVR4cjVhQ0xDZVo3MUR0S0FiUXNHNjZHZy9HSUFJMkRGT2VNMUJMbUJ6?=
 =?utf-8?B?UXRzVXM1UzZDb2FUM1R2MzdCM01jTXNNWU5xaEw4NzNzb0J0ZmwvL0hxU05T?=
 =?utf-8?B?eGhIblZodGlKdG1GV1Y5SkJvU0hrbUozNFhIYlgwSElKYjJzYzNoOXE5WGw1?=
 =?utf-8?B?Qk8wd2JCQjBaN2JXM1A3ak9FaWlieGdYdmhQMUh4SXV2N0VrTHB2eVpoZnQ5?=
 =?utf-8?B?akVuV2x3d2NPVzJyaGt2bzhON2pVbXF3dlZYR2J2K2ZOcUJPd3RNektOL28z?=
 =?utf-8?B?REYzMmFmdDNBZWFWcHF1VldidkdOcmV1TFZxcGMvd3FDT09UbENoaTFiaUlq?=
 =?utf-8?B?ZGhYZ1p1eFZTVjBJRkJqeXZydFJ1akl0dFFiTG55Q3dod3lpa0NMek5JTVY2?=
 =?utf-8?B?WHBhT2dTQ1VnbzVFVEgzcURTMGJwcHZYMnlYY2JXbGFWVVhyMWUyR2xsckxL?=
 =?utf-8?B?ZDlDQnNITGUrK1VUQTU1Smg1Y0JRcWJOd2czNlRlMnhJM0NWWitSSnZDNnd6?=
 =?utf-8?B?cm9UQmNLS2dKSGhKWlQ3OUtUUnlKL2F1S244bnM1cUFyOUxxQmxheThYRGIv?=
 =?utf-8?B?dUpNUW02N3pEYUJXc3IrVGsxWTl5OFVmQ0FXSHE0bGgwKzNKS3ZEWnphUHEw?=
 =?utf-8?B?RnUzT2dFVGYvUzd0ZGlGb2hZWGNDSnFLUjRLUlJ4V2k2V2hrNjJSWmtBTmcz?=
 =?utf-8?B?UGFmMUlpT3NMc0gwdnh6RkFMaXl0N2l3S2EwVjROQ1FZcUV4SFRnbWNUYWtY?=
 =?utf-8?B?OXlYOWVwck0xdHE4QUFCNjEzdFFyUUF0VlUxdVl2bU5XMGxtQWN6bUo0cEZs?=
 =?utf-8?B?MXhTNDFHV2hZYmlBcWlka2RNbmZsY0dRUWI0TzRvbCtJL0ZpbFdTeVE2Sm4v?=
 =?utf-8?B?OFQ4SU5NR0VZenh1bmtvV0FJNDdNcHN5Sy9LWTlUcHBmSEZoOVZ0Z0ZZQTNX?=
 =?utf-8?B?MTJOeFZWOHE5Rlk3YTE5WlF1ZUR0czE2cE1RZi9yUE5CTEhvaXdQZFA3dzRF?=
 =?utf-8?B?L0hxUTF0eGZxTUV3YXc2SjVHdDN1aHJqNnJvZnhEQnZibEF5Vmdob0xPLzJM?=
 =?utf-8?B?UXhpN2NnNndJOFhCYUZnS2ZXQXRPUTluZEcvNTJmYWxab3VlaEhiMWtsS09J?=
 =?utf-8?B?dWh5MmdGdVp1NUUwSzFadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTluSFZXTlVmSXJJOTc4dVdGL1BMbGZZVVZlMEZJb2I5MDBQaFVyUGFGeWhX?=
 =?utf-8?B?dEZiL1hxMC8yTWhWSnAxYWVzMkNoZUlwQkhDdkdpSllpN0JScTNQT0t1M1Nw?=
 =?utf-8?B?SkNYb2k4NnhUa3k0d2NtN04ybGRWQ1JUMHRSK3BET3NFYSs4aWV0UFFGZnNP?=
 =?utf-8?B?UzBKS2hzY1prOUhjNysxRkcrd0FRU0FOaDUrYk9zdEZoTU9rWUZWdmRuQ3Bv?=
 =?utf-8?B?YnVXTVU1bld0NEhlQTdWbkwwS2FsMGg5YTU3aG1lY2xtZUs5bEUvSmtWYkho?=
 =?utf-8?B?WVlSVXFQM0lMbFZKTmZRaEl4YnhubmlDdTNIT3FnNklKNDh3SWlERVNubW5y?=
 =?utf-8?B?RGZDK1N1cWdqN09vREswSkVCMUlGY0NuSFhJem5JYnpsdHcrQjJSTUVWZTRa?=
 =?utf-8?B?U21mTEdqZlk5ampzUUg4bnk0ZndkOEx4NldyRm5aQ1g4VVAycWhIWkdKSGRE?=
 =?utf-8?B?b2VuQ3pzWmgveUd0cDlBeVg5bkFESVBvUzNjeWtnenF6d09aK05uNW1CRFgv?=
 =?utf-8?B?WEFWWVhxZVZkclJzdjg2LzEvUXV4Smk2ZUtSQ3B5L0FDQTFCUS9UU1JLQWkx?=
 =?utf-8?B?WTkvSURaWHZiRzQ2dFdKTkFWL0FhcGhHTmoxbTFRZVN4Q29LTlRMZXZKTWQ5?=
 =?utf-8?B?a2FacmFkYzhld2ZqVDlLb1g4OUhRYTBUbDJzcnVDNmkrTjJKZkFuVE5sWHBL?=
 =?utf-8?B?WFBYMURscDlyM1JxUnBFRFQvbmNGSGROV0R6UUdxUmpYaHd6OW9PaXdqNlp3?=
 =?utf-8?B?dnFCY0Q5VUZKOUZ5RTM5RDNNM050ZkxwanBreVJ6UlJyR2dBaWZmdTlmdC9I?=
 =?utf-8?B?Qm5xZkpxOW9PMHVja1RZcTlrVm9MQnBvNkRNcytUMU9JeGxHMHIxcUw0cjB0?=
 =?utf-8?B?V3N5M3d5aGxEM1B0Nk5aNi9GcjhGQnlORDloY2JzR2duZEUrcUF3WXR6WFMv?=
 =?utf-8?B?S0pLMWpEeUEvb3JRQUkxOGRlVTFWVjJyL2haQ2haczdXTm02K0E4MGIzRGIy?=
 =?utf-8?B?NnR1djUvakRHUWk5RThhWXM3OWZDUUxva253dFdyOEtMeXJiVHp6OTFCVGRn?=
 =?utf-8?B?OEtETXR0WnlWOXpSaVoxN3lIbFQ5ZmJVNVpZMlRUZVBXdE5GelhHUC9uN2s3?=
 =?utf-8?B?SGJMSUZSeHFDQU9GL2ZXOGRxS0o0TDBQeEpFUnMxV1V3a2l2dE9KcWlIYjZ0?=
 =?utf-8?B?aDZSNFNyT0hxdDZjQlJjWG5hWGpEdjhId2drNDlqYU1OMWRFMFRQQ2wyTWRy?=
 =?utf-8?B?WG9JbDB0a0JnaWRoU2FUL1NzVWZEWStQc2N5MHZMUDVQL3Nhb21Zc2doSTI5?=
 =?utf-8?B?andKSGYyUEEvZDYxcnJNTUZZV0pEa01TTTZFdCtEbVgzQnNsZjVIK0h1ZEE3?=
 =?utf-8?B?SzNzVFdlTWpYbVF3bjRNSWljamxhaE9WcnZ6L2p1OEsvM3N0OFozbkJQdkxR?=
 =?utf-8?B?NUNJU2hVN0FmUzNGbENGRnRJSytvT0kzYmhUWXkra2JsRVo3NDRvZHlhamMr?=
 =?utf-8?B?NlFXSHRYWHk3b09xc1lYSW1NQ0xJUUpPM0tBRzF1TDFtL0o3NlRvQWcvbi9K?=
 =?utf-8?B?bWw1NWtjemdrTUVJWmxObDc3aHZ1cVlzTjZlSU5CK0Z5c2YwdGZVNDlxS3o1?=
 =?utf-8?B?Ylo2WU93bkd3NHZCTVh6SkRweXordkZ5S2RGQ1hucTd5MW93aVdmUi84Wnh3?=
 =?utf-8?B?bkFqUlFCQU12cFZ4c2RWTUM0ZjJKTVl6Myt5bGF1dGpjb0J5akF3ZFphTTE3?=
 =?utf-8?B?OU9IeGtSNzNBbG9pT3pDd2VXekFHL3pvN04vRDRPM2d3UXJkMEIxN0psaFNR?=
 =?utf-8?B?Y0NPMUM5ZzZQcmY0YnBsQ0hYbVBOY2NIZTJFVTljV3dINk83TWtPS0pJY0ln?=
 =?utf-8?B?LzlmejdEdGkvRjQ2UUM3STIxeXRxWEJ2Zmdrd1BrakNmdUppOEZzU2ZvVG1u?=
 =?utf-8?B?SkJrUlNyNGxCZVdJelNvK0tqUXo5cFl4d2w0WlZqb2hkcysxdGxWUlFDUkFB?=
 =?utf-8?B?ZmlPVWNGbVNZMzg2ZGVCNXZWSXRqT3JPcnhIS2FhQi96WFFxWGhCQmNZSnRC?=
 =?utf-8?B?bnNNRHB3R2hNelBWSmkrNk5kM3VLa2g2enRKekZaNFNxUG01RGQvbnRLU0kr?=
 =?utf-8?Q?yLWblIq/oI0kigcpjVM8356Xl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0320c8a8-9068-4a18-4c08-08dcc6d8dcbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 20:43:09.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWYIspSoQpo0HSoL5YD41E5Wy4JiiWABLWpPDdQjYoeh93nrKtsdp/yn010inS4tWR2wQFgGCeoCql5jYXJ/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359

On 8/27/2024 9:02 AM, Dragos Tatulea wrote:
> 
> When the vdpa device is configured without a specific MAC
> address, the vport MAC address is used. However, this
> address can be 0 which prevents the driver from properly
> configuring the MPFS and breaks steering.
> 
> The solution is to simply generate a random MAC address
> when no MAC is set on the nic vport.
> 
> Now it's possible to create a vdpa device without a
> MAC address and run qemu with this device without needing
> to configure an explicit MAC address.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index fa78e8288ebb..1c26139d02fe 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>                  err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
>                  if (err)
>                          goto err_alloc;
> +
> +               if (is_zero_ether_addr(config->mac))
> +                       eth_random_addr(config->mac);
>          }
> 
>          if (!is_zero_ether_addr(config->mac)) {
> --
> 2.45.1
> 
> 

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
