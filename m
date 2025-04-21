Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640014AD20
	for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745248451; cv=fail; b=DwJxiFNxzO7laf88VKvbJvWg9qbJeIGh/OWuCyvgYOnuCEnLF7G6Mp8YqHNK/+KW824DsahOSrnF2xKAO/UbOnLyrEa51cZschQALPPS8/UCw66B1WTtfXhC2pewXz0XHLVy+4IO7S1gdAYt5TD/tUzo9sYVbmxxFChFwjU6+bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745248451; c=relaxed/simple;
	bh=X7RmEkzqDCHY/kHyXU8QtV2049jSf5AVKTWkeu2y5Pc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZ/NRltg1BpL8bb0n23Vz7FcNvO5MrZd0FnDrJdjSJ+NMdfpVOzKmor48I3ksnxugC4JegPdRhyJ9vBOuyC/4A71WEx46+XvktFYm5qk0csQC7sZlROnQouiNJr7hYQY5DmMUzpUNIMMeoDbQw42R3AXS219FNpVevKdXgdV6Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0DfUbxo; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0DfUbxo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiX5Zmwxla4HQ7G9zt/0spVBSMVHgIiUMaaYF1yXQazZuKB2n40xr30UXQhwC3REkT9h/PPXOMczcijF/X0Ve2RIQRc9ljrsv/SrHXwdwck/B4X0U5DLwR4Mewebp/HG8t4B9GZsg7ozgdhslSOOXO9lx2VG1C823JKuurPY+UjSZGIPcwozu5ia9axKYIZgBv1rDLW8oi1bwfyY4niHWGQXam7zB9Vo7RzEradbI4gtMtlLNJZzbzoKDkYi3MRJTnR/CPlYtt/akUeCfjR4hor5nOOOof/S4LPgs9WiNf+x5N6NL/hvqoOnLXTIRjsLfbJxTA8Z61eJbzMHe325vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/5qNHpoQayc5ySJZqsUK3iYbpw2s3pIj7sVA2+Rb+0=;
 b=TPDKei4l4QNY6cU40sRAmTl3bw4MiFHUk2O1X0SthLGglRfUAVbFvr3mnx8kVIkTNI1C6x6pXuOmEjb1erD/NwgdrvIiUVjJABHOgSGR8ZVgPVhBF0591f34o7k2roZM+ieUsTDoHDgaPSjWNnGCnZi4mfYCXtavO/PeiWI16n1vlY7FN+sD+iu7GIppkpH98nbY61zH+9mdlHW6iikHo73IEdy7LdDDGRKhJ45ShLQrfXRcQqhYcX9EVdqgp79m7tjm6PfMMWzhSPygMMMVwO02cveuZXeZmN+fOMLT/TfDzXpzJYImwWTs9Wsgrg1DSrQq0GXOPTjLdsqMWMWIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/5qNHpoQayc5ySJZqsUK3iYbpw2s3pIj7sVA2+Rb+0=;
 b=c0DfUbxoyzHGoLm6KDsIevdzw1FRbrAeLnRU9gKRkBEtuseSmE4lbhjztcKJH3pgStw9qaYKJh3HTUOUAPPOD+YlLAJn5jygmFa59YtXGS4mXlo9WrsPhR8zVLPtaFWEJ0YJy3KvkT35XnzGMt7COgaPA34PujLGCWMOwMja6ksphCrMm5EdTzHrOKET7Qo5ZjDwKw/Ar63NiHXcCSsSWz75vi2xd82FSM12ZNwAeFg3Zct1NPjt8wMj9Zj68TxhbEOVJ1oWo/x4Tm8Ozydirzp1DSnpi1arHCWKCpgRJ591mrzPkkkXIBP06kW1RSBwg5AjDPJeLOzLaI3RN8DMRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 15:14:03 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%5]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 15:14:02 +0000
Message-ID: <33cd1567-87db-4757-8b5d-d0e684aa0322@nvidia.com>
Date: Mon, 21 Apr 2025 18:13:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-pci: Add admin command length check for device
 writable portions
To: "Michael S. Tsirkin" <mst@redhat.com>, Israel Rukshin <israelr@nvidia.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 Nitzan Carmi <nitzanc@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
 <1745147945-194225-3-git-send-email-israelr@nvidia.com>
 <20250420073230-mutt-send-email-mst@kernel.org>
 <b9e80050-9d09-4ed7-ab05-6a23a8e6e6a9@nvidia.com>
 <20250420090604-mutt-send-email-mst@kernel.org>
 <f8ee410c-bfbb-4364-8e1e-c73ee7147fc6@nvidia.com>
 <20250421071734-mutt-send-email-mst@kernel.org>
 <af1e660c-3252-4f13-b0a1-4718e5ce4420@nvidia.com>
 <20250421101137-mutt-send-email-mst@kernel.org>
 <28749eee-7dcb-4f25-923a-0a858a661610@nvidia.com>
 <20250421110458-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20250421110458-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f6d476-8d2e-453f-e6d4-08dd80e72644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q05rYW5ILzZmdTJXTjZYdk9pbUlLMzY0cnZaQ0MwTmRRTUh3MkxramdQb3hU?=
 =?utf-8?B?QnZ5UkRia3NZT200UWtsODBZV0pVWmZpL09VVjVvYjNTTHVtQTNteXpJWWo5?=
 =?utf-8?B?cjZzM0ZVYThrdVpXczY5VUwycHFrRE1EdXlPdFYxNjQycjYyUlJ2N2hVRlBT?=
 =?utf-8?B?dkVIZyt3cnVlSHROQXRSUC9CSVc1OUJKZTZWMGx4M2Fha1NZanZjaFFzSEZL?=
 =?utf-8?B?OWJ1YUFKVnBLSFlQM0M3SURKaU1UaTRlMTFvVzlNRTQ2WlJDTVR3UjFhWHNi?=
 =?utf-8?B?WWQxdzNPWG5SeVltOXM0NzB3VHlIaEE5YkovK0hVbXpVMS9VNVlRbVk1dUFl?=
 =?utf-8?B?eHpOQzdnMHl5RUQ5UU04UlVTL1pXUG93dW9hNklIWkVNWHBheWQ5d2lueDZQ?=
 =?utf-8?B?YnQ0TzhOVGVLbnZPWk1lREtaN2JsWnZVLzNqRVo3Qk0wNjdTZFU0NzRCWUF1?=
 =?utf-8?B?cGZTTUNDWmQzcDVicVlvQTYzZStDT3hBVUlOT01YSHc2ODZ4dVpQeXBVbjVG?=
 =?utf-8?B?QTd1SEVvTEw2S215WlJPVmt4eHM1cHpOb1lzcGNSUi9iU2UzeUZuN01wbmZI?=
 =?utf-8?B?VVNySUUrUE1mT1VqdlliT29nbkl0RGVRejBHMUYwcWZpbDVwbCtxaXpaMGJQ?=
 =?utf-8?B?aUo5UHFrNlJnWWorbUFxTzNxdGxLT0lsem5OS0R2bWNUVVdrUzVNOVFucGM5?=
 =?utf-8?B?MXJzYmtKSGdaNk9BRE51RUdVbEN2bXlOT0dPdmFxMml6aUo2dzZOekl1TDdt?=
 =?utf-8?B?WDRYM1g1VE1KR2UxV3pYN2tPZ1FEMnRvOEdIRUora21sVmUxUUlvaSttNncy?=
 =?utf-8?B?UVQ1Y0ZkQUJycHdjY1FMdm9pc3Z6eWlwaUV4cDIxdUN3WlpNZzNlWG92Q0Qw?=
 =?utf-8?B?ak1pY2JkMjkzRnNoMUxHZEo2ak50SmJhN29ZWWZVeWJPSlFuemI0VVpwOGhG?=
 =?utf-8?B?eGRqZ0dWWGhzZXQyVDRRTCtjUFVLa040MVh3ODNMNkFKbEdibmZoWmU2dUdV?=
 =?utf-8?B?amNEbXBLUER4dkJHRzQrcngwOVFUMWh6Nmg3Y1BYWlZyU2lWVkpjWTdvUTBw?=
 =?utf-8?B?ZERmVm5qY1RpUUJaQ2l3YW9PcXYxZ3d2V0wrdk1lZ2V3emtNd0Jlcm9jQWJN?=
 =?utf-8?B?bDZ0OGIwQ3NoMUdSZyt1MmNML3FmT1JRMXVmNndQZXNJdUhObW1xT1pLdUxs?=
 =?utf-8?B?YW5JeVFXbkdUbnBvN3hNcTI4NTRpUTU4WWlFQ0piSmdHOFdLMk9VYmE4SDhK?=
 =?utf-8?B?QmFkR21yVFlhQjloT0FjTjJIcmQvNk5hZkVYdytreFZuZmdOcVhaeGFhT2Ew?=
 =?utf-8?B?Q2JvbTNZaXc3bG96VWR0L0h0dGhGQXZsbjBvemVLaUQ4MGt5bG1VWlpTUDZI?=
 =?utf-8?B?VlJZdWxaWlRQMjczM2lyZ0N5T2Y2TjkzTUJvOXZ2WVZRVHRyeVNmK3JpbGRp?=
 =?utf-8?B?OEwyWWdCcW9uWUU1SnNhekRRWDVwOTJaVVVRUk1YSUduL0dCOS8yYmNjREJG?=
 =?utf-8?B?SEdBMEhLaU9SQlA2WU5hbGFLL09YNE04RVZwdlJlWVJxS1ZSMHRZdjdjZ0F4?=
 =?utf-8?B?YVI0WEhEUWFHTjNaT2hhN0lvT3U0TE9NSmtVcXQ1TElQNGNaQ0tGc3Zscm8y?=
 =?utf-8?B?QlNuR0VoNFM3NTRXOG1ETTVpN2dNQm9sbWJDOUV5cmZvUmZPTG85NjBvT0V0?=
 =?utf-8?B?RSt2SjllRExmNExmekxqcmpaUjJrNVJKWEp6MTk2L0dGVDVRRGtxd3ZGWlll?=
 =?utf-8?B?VTNIKzJSajFuWmwxQUlZS1ZET2NlVUdWUHM1disrc1IvamZJd0pzcDc3a3dR?=
 =?utf-8?B?VUlLS3hQZHJaTTdWY0c4V0FGa3prTzcyb3dsUU9yVlYxS2NNVUJuQnpSamtK?=
 =?utf-8?B?eGpGYUg4SFZpdUdRQmpuUTV2UVhoYkZuQUtDZGFVUFY5WUprN3JkNlp0YU5w?=
 =?utf-8?Q?5mcynvMIPDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDUva1FRQlhOOWlucmlpSVcyd0pUa2hCalpQakQ5alZKOW1WdGxwY0NVYm1s?=
 =?utf-8?B?ZjlxSGpjZ255aHA0L0pxVWlXbVc5K0dBeG51N3RiUXNrR1RZSForUHZpVmFq?=
 =?utf-8?B?TGVRM3EwOGZOemVRV05WNGdra2lXU24rSjhoTXlPTkhRQzBnNmx5cHRNc2Nt?=
 =?utf-8?B?dEpuU0VhcVJZVFNvQXJaeXFVUVdkNTFjSStPOGo1ZVdTNFgzbVhndXQxcVhI?=
 =?utf-8?B?SzZkQk9INHBWWmg5bitZa3QwczRYVjBwbjloYlVvNVpSR3hWb1VTUGRSQVVq?=
 =?utf-8?B?ZW1ZeHU2UXN0UlIvU3UrRXExQ1dDaFFsMGthUHowcFFEQW14ODE4RUVZQ1Ax?=
 =?utf-8?B?OWsxLzdQYkx6eHpib0hhTVVxZFNLd1JGcm9VLzkwMTF0QVM4eFFIaHovZkVk?=
 =?utf-8?B?QmE4SWdnbkwwMW4yeEhDaW9jcUM5ZFV4cVM5d1pvL21NNG14ZFowelZZb0RM?=
 =?utf-8?B?dUdkZ1VoNTZLZ3kxUDg1NWFUSDRhbzR2NXhoZzVrQ2REQWZoZHhxZEg5eFlw?=
 =?utf-8?B?NzVRK2hiVmozd1kxVzlveDZmam9RbERQUDQ1THdsclB5TGxkTVNFdFN5VXY1?=
 =?utf-8?B?bFVZeVZHemZsNkptVUVQejd0YmZnOVMzZHhvdld4bFUrd3RERUVRQVNjK3Zj?=
 =?utf-8?B?bi9HVVZEcXVaRitGamd3R3R2SXNONmpSbEZqSTIyQXI3OFQwNUVBL2dWdXVG?=
 =?utf-8?B?ZjdlTU1hNWE3c3NhRThSRjNsY0t4bXA1WkY3OTFGYVlFdlVlSDJ0eGg4bWsx?=
 =?utf-8?B?aDFHVEdCZHMrd0xtUjlueDVxdjZYclFwRkRpbUtpTHNLRkZ4TWllK3pxRnVh?=
 =?utf-8?B?QnEzVzRiamVyTWhIS3RhOHJOT1IzNVBsTWJvbmd1YVZsVmppZm5RS21Kb042?=
 =?utf-8?B?ZWoxRHYvdk1vQ2REOE1DK3NZd2JGaFNFVnVGU2xTcS9PN2pIWFJBSHhaeDQ0?=
 =?utf-8?B?dnBvYWNnM2xiSXRrY3VuMzRhVXZ5cDlyYUdjWVJtWnRnVVI0bHB6SGppWkxx?=
 =?utf-8?B?QlpLNkRObVRuNUlWOUo2OGZCalRpMjlXZ2s2ZnNYTitHUzZqQmMwZW91NEJi?=
 =?utf-8?B?ZTQvSFRvekd5Tk9EQXJNa2UrZkJJdng1WHBaYjVveVU5dytpUGNoVkEvNGZj?=
 =?utf-8?B?N1Z5T29TQzlFbUZrbSsyL2ZtU09rcTBOeDQ1ZWhzT2oxSGN5aitONW9jUnlV?=
 =?utf-8?B?Y1M5SGpQR1p3TllSenZBcVR4VG13eXZFSTZiUFhDQjRCWDJwUERpeUl5RHY2?=
 =?utf-8?B?MjdZaDNLS201NkFKZkw3bDJQL2RzQkVhU1JIWVhnZDQ5K0p1S3dyY0dEQjBD?=
 =?utf-8?B?MndsNE5ndkllcUdFR05MMWF1d3NJUWRtbDh1azl3ekZRT3NZT0orZ1VzQnBL?=
 =?utf-8?B?bDY5dlVHNTlvYzB6N0lzbitndHdDM2cxTWVjQnl1SS9UeDVaUkpScFZFcWdx?=
 =?utf-8?B?YmNIb1ZSdm5IQmJsRjJsNm9ldWk2QVVBL1NYT2dvRmFzVjJZVk91dkpmVlB5?=
 =?utf-8?B?OXkzWFhvMW9IYnIrVUUvcCtzWUhSVzdrNGVhNEhaeHJMYWlWczJKK24zZTlP?=
 =?utf-8?B?aVJnZEs5dHphalVhdVNyV3cxS1BUQ0M4WURkN0duSSs0ZlZ6d1ZtQ0tMdFpk?=
 =?utf-8?B?SFpmYUdqUGtlOE9wZ3NraC9BK1Y5aFV3MklkdGlFNXRFZWdqRjhTM3dUdHpI?=
 =?utf-8?B?Q1pyNUk4aC9KTWFqUkgrYU8zZnlNMjQ0SWpqUUhJbmJsVy9nTldoZzYyaktY?=
 =?utf-8?B?aWZEcjdlYk1PV2ZocXFwNjJ3MnR6ME0xUTUrQ3BBbWlUc0hJQzJITkJIRXNx?=
 =?utf-8?B?bUEwSVl6U1Z1ZHcydmRVZTR3Q0ZSSmIwWmFIMkVFcThCb1ZJTjZEbFRjRGcy?=
 =?utf-8?B?eENxZ292emhSMWFnaW1neEZaZ3lmSlh1Ym81WmFtMHpNeDQwaU5pNDgyUDlq?=
 =?utf-8?B?dDRLUEFxV3E3Qk5IUVpRMG5jdksvSlV1T3R5T3dRNUZ6NkxwQzhxRHU3ZVJi?=
 =?utf-8?B?ZEczSW03a0Q2UzFmVkZwdmhmbUNUMmEyMXk2cHdUalBXUlNTQ3E3YXd0V09q?=
 =?utf-8?B?ZkViZzhONHd2T2NQcmwyLytwRTBxZW1QNjlXeEpNem4vM0MxVHNBdldhU3dY?=
 =?utf-8?B?UGtuaDROK2VJeDNyejJXTUJVaFVWVVppZVNwcCtKbkl0azJNakRSeHZkdUdM?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f6d476-8d2e-453f-e6d4-08dd80e72644
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 15:14:02.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4AneACJ4i9c9vZAkrnS4jnvyQsj/6VcICrwc1cGgUIFj+y+ga4rznfoNw4EXl3FGApGFdG7FbVYAMvPwshdlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308


On 21/04/2025 18:06, Michael S. Tsirkin wrote:
> On Mon, Apr 21, 2025 at 06:00:27PM +0300, Israel Rukshin wrote:
>> On 4/21/2025 5:12 PM, Michael S. Tsirkin wrote:
>>> On Mon, Apr 21, 2025 at 03:36:21PM +0300, Israel Rukshin wrote:
>>>> On 4/21/2025 2:29 PM, Michael S. Tsirkin wrote:
>>>>> On Mon, Apr 21, 2025 at 02:05:27PM +0300, Israel Rukshin wrote:
>>>>>> On 4/20/2025 4:07 PM, Michael S. Tsirkin wrote:
>>>>>>> On Sun, Apr 20, 2025 at 03:31:25PM +0300, Max Gurtovoy wrote:
>>>>>>>> On 20/04/2025 14:33, Michael S. Tsirkin wrote:
>>>>>>>>> On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
>>>>>>>>>> Add a safety check to ensure that the length of data written by the
>>>>>>>>>> device is at least as large as the status length. If this condition is
>>>>>>>>>> not met, it indicates a potential error in the device's response.
>>>>>>>>>>
>>>>>>>>>> This change aligns with the virtio specification, which states:
>>>>>>>>>> "The driver MUST NOT make assumptions about data in device-writable
>>>>>>>>>> buffers beyond the first len bytes, and SHOULD ignore this data."
>>>>>>>>>>
>>>>>>>>>> By failing the admin command when len is insufficient, we ensure
>>>>>>>>>> that the driver does not process potentially invalid or incomplete
>>>>>>>>>> status from the device.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
>>>>>>>>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>>>>>>> ---
>>>>>>>>>>       drivers/virtio/virtio_pci_modern.c | 7 +++++--
>>>>>>>>>>       1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>>>>>>>>>> index 7209390a5cbf..0374e86aece3 100644
>>>>>>>>>> --- a/drivers/virtio/virtio_pci_modern.c
>>>>>>>>>> +++ b/drivers/virtio/virtio_pci_modern.c
>>>>>>>>>> @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>>>>>>>       {
>>>>>>>>>>       	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>>>>>>>>>>       	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
>>>>>>>>>> +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
>>>>>>>>>>       	struct virtio_admin_cmd *cmd;
>>>>>>>>>>       	unsigned long flags;
>>>>>>>>>>       	unsigned int len;
>>>>>>>>>> @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>>>>>>>       	do {
>>>>>>>>>>       		virtqueue_disable_cb(vq);
>>>>>>>>>>       		while ((cmd = virtqueue_get_buf(vq, &len))) {
>>>>>>>>>> -			cmd->result_sg_size =
>>>>>>>>>> -				len - sizeof(struct virtio_admin_cmd_status);
>>>>>>>>>> +			if (len < status_size)
>>>>>>>>>> +				cmd->ret = -EIO;
>>>>>>>>>> +			else
>>>>>>>>>> +				cmd->result_sg_size = len - status_size;
>>>>>>>>>>       			complete(&cmd->completion);
>>>>>>>>>>       		}
>>>>>>>>> No this is out of spec:
>>>>>>>>> 	Similarly, the driver compares the used buffer length
>>>>>>>>> 	of the buffer to what it expects and then silently
>>>>>>>>> 	truncates the structure to the used buffer length.
>>>>>>>>> 	The driver silently ignores any data falling outside
>>>>>>>>> 	the used buffer length reported by the device.  Any missing
>>>>>>>>> 	fields are interpreted as set to zero.
>>>>>>>>>
>>>>>>>>> so if status is 0, device can just write a shorter buffer and
>>>>>>>>> driver must assume 0, which is success, not failure.
>>>>>>>> maybe we can make a sanity check that the len is at least 4B (status and
>>>>>>>> status_qualifier) which is basic size to make sure device is acting as
>>>>>>>> expected ?
>>>>>>>>
>>>>>>> The spec says nothing about this. Just zero-initialize the buffer
>>>>>>> beyond len and be done with it.
>>>>>> What do you think on the bellow change for v2?
>>>>>>
>>>>>> @@ -56,7 +57,13 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>>>            do {
>>>>>>                    virtqueue_disable_cb(vq);
>>>>>>                    while ((cmd = virtqueue_get_buf(vq, &len))) {
>>>>>> -                       cmd->result_sg_size = len;
>>>>>> +                       /* If the length written is less than the status
>>>>>> size,
>>>>>> +                        * the remaining status bytes stay zero-initialized.
>>>>>> +                        */
>>>>>> +                       if (len < status_size)
>>>>>> +                               cmd->result_sg_size = 0;
>>>>>> +                       else
>>>>>> +                               cmd->result_sg_size = len - status_size;
>>>>>>                            complete(&cmd->completion);
>>>>>>                    }
>>>>>>            } while (!virtqueue_enable_cb(vq));
>>>>> Can you please explain what exactly is this change doing?
>>>>> The changelog claims all that is done is adding a check,
>>>>> but that's not true: previously we reported the whole length. Now you want to report
>>>>> length less status_size. This is a userspace-visible change, is it not?
>>>>>
>>>> Sorry for the confusion.
>>>>
>>>> This change is essentially PATCH 1/2 from this series with the addition of
>>>> handling the case when len is smaller than status_size to avoid getting a
>>>> negative value.
>>>> According to your comments, I will remove PATCH 2/2 and post only PATCH 1/2
>>>> with this change.
>>>> You are correct, this is a userspace-visible change, and the size currently
>>>> reported in virtio_pci_admin_dev_parts_get() is incorrect.
>>> Sounds good. My only question is, how bad is the current condition?
>> The migration fails if the state size is exactly 4KB, because the allocated
>> buffer (4KB) is smaller than the amount the user is trying to read (4KB + 8
>> bytes).
>> For other state sizes, there are an extra 8 bytes of data at the end of the
>> state.
>> According to the specification, the device at the destination must fail the
>> migration because this is not a valid state.
>>> is there a chance userspace will try to work around it?
>> I am not aware of.
> My concern is userspace might try to work around this bug..
> Do you want to add a module attribute to tell userspace it's fixed?

Since there is no WA, I think we can avoid module parameters at this point.

After we merge it, it will go into stable kernels..


>
>>>
>>>>>>>>>>       	} while (!virtqueue_enable_cb(vq));
>>>>>>>>>> -- 
>>>>>>>>>> 2.34.1
