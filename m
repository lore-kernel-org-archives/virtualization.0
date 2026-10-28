Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793198782;
	b=MmYJzicxFeMuMRmPeyX8cLukRyEYaRy5MrgGp7tfcTkeNCBL5WSh+FeoKAxHaw7kRThr
	 nGg3PR3Hd1gxp0qLdEkHXNY30qOw/UiHdiDZZoqZHs0CS58LTPVhFpexxkw7g4jpfbGuW
	 gqoRtJuItcPt4U2CWDiogHSogQ6Y9F40eV4WBTPoWgegsKvLZ3TzdzCzcJujB8HI4Ndyi
	 apqWE8G7TnwGbWN8envOTH4H2q39k83C9H3783iqIeljqZ4VT/xKXWAuLG1xfarfJEqSB
	 +LjZDiGJYVkEncDPrHavaAuz3BvGm4pUUp9lydICiIAOUuYAbiKesuM0i+64urydo+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198782;
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
	bh=VwN62wslJZ0tQD6IP8YCE1vFK2AQgrYoKLcasS9kMiE=;
	b=hwNqtpOWytC2o3V9nWMA512KpxVt9KAMWs0eDz3CRczcl/9FzK+WQaLK3WuCPozF4XM4
	 fj+16Co58mTDORsEXRh+45B5yDDzNP3TfIuuO7W5WGSfe11bcqa1+QBdx+2yDiBynrseY
	 lFgE8++rNTIm63hllGxconAsgKIxamrNLlG5oqmrSMY/6ngrTsNFlAIzWUGZqNoHgqM6D
	 wtedn+YqNGorAM09tqlUZrbqEsAMKS6D/bPu97Q46HCzdt4fg/Wy+MCYRaUihOc4P3eFd
	 hkWcp573NLl22Zmx90LnNBa9jtDsvFPwbfMvCMIISx1tZvIMU4JgL3FQoxVoIUZYlVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jL29rkSH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.37
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804B8606A31C
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 14:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 804B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jL29rkSH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7LOvvzgVnrWMrJ/eMbu5ryHEkT+MmS1wjVlbTrTm0t1AScm3pNe3TgAPSB0wjM9nKMvNAnuGQizv6uOpYLmP0APQGv/sD57Tk6JqrfVgR/LHrFTrgj7bNhgNhD1KDeZ25s1I3XJj8r1Dzk2ZeSQ+DQqWQH24VGPyRnPkwMBun3kll/NFqQF4UafvzjmTYJaDNCM9UhKsGIjLIC7GCRClZYbgikWpoQjlNwUiQ4dhikJbHeDr02ZIyqTowRj3WyU2Tr8WbkcdRb8URhxXFzeaU3wb/vT6ehHfil81q4jA5kpRoqi4zq2T72r9SFdEKYYC6cXVLfQt5fugiL8WMIcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwN62wslJZ0tQD6IP8YCE1vFK2AQgrYoKLcasS9kMiE=;
 b=c1gt1rme+RfMdswPgjRwEXeRkOfKT6pb/B41fnsBcX2sVS7Sr8YtqcEJJVCjuZEDMqEQ8YUPAuTPVOOWAcJQP2/hNXfvRLKdSzAmc7u8ipserPJSStJMSeqzO9aAlfH1efvN9HjsV5x/r8BhYADJSD2pwHUsd1F7D2dhwsHs1Q1v97cLwZq+yNkyKh8fPnRlcGNqOpfs7Re6NieoUgl6yJODuJcLEAa3adecsxsZpnTOyZQaBhi6sSy3vaoS2pbVSJZuAt8AULhWn0uRI+RSd40Vlb/OD/O/W1cDNVckntxU65z4IiHTDgOSPehLeKMmQWFjppabBLTj2tgS6qiDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwN62wslJZ0tQD6IP8YCE1vFK2AQgrYoKLcasS9kMiE=;
 b=jL29rkSHnlj1TH/ZQWEXLPYlEpRT/njYlAAiB0HDSxYtKPxBOVMZOB6x/cCtA9EQYvX76k8lVmOavBgoOmbhJt/HCQuA2QRil27ef+dcn/D9PTPOxQx0/TiozrM9auG9ppukmvKyojX4GQfXCWlfpi8Rq5K2xBO7h7gomf/Hn9+qSAZNnzMy8l5dx3t/i0p0CqSK9qzk4+3u3E/XEo8PjneJKt1v6kZN/yhjvl4y3jUnLahDnwkjTLkgMb0GulmHReTmxxhhQWlct3ztK/YHD4bw5l6IXaI+VnBr9kz6jKTVEZzfZjOB9eozbH/aaH3IaFhyUIhsnBcOGlHM0EcyBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by IA4PR12MB176353.namprd12.prod.outlook.com
 (2603:10b6:207:10c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:46:18 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 14:46:18 +0000
Message-ID: <808a6e4e-085d-4723-9489-f17f023949c0@nvidia.com>
Date: Wed, 28 Oct 2026 15:46:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] vhost_iotlb: bound map allocation in add_range
 breaks vhost-vdpa on hosts with fragmented memory
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 Linfeng Sun <linfeng.sun.dev@gmail.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 Jason Wang <jasowangio@gmail.com>
References: <0f51918f-88c9-4930-ae5a-616bbe73e7cb@nvidia.com>
 <20261028085839-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261028085839-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|IA4PR12MB176353:EE_
X-MS-Office365-Filtering-Correlation-Id: 76939c98-f91f-408b-4b9a-08df3502344c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|5023799004|11063799006|56012099006|261022105027099003|261022075727099003|261022113327099003|261026140227099003|261026121527099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CQpd/VQ3rmBGIL9FrIoPCGHoWcTxmUX997fR+AFrNhP1TNyifqtXkO8TtNtlENNNyc4+lM6K4wvoucQREKGnR5eiDWiqeToKTC5qzZAhmYprgB/sbcCcrOMZ+UNRZYZIJOA70i97vl0Ag6F4kzERJj5OSQIytzXXW+Xc4P/eZrnELiZJUHDxGwCiOv0V5So8hJzts+BmI7jKdoJciEf3Qz8lIU24onIAFzzY9/L3HJXOdA/Y3li3LB5FJLBOf3ECnRB8rXY7yAawujwlxO0tEpVTHPUlzzhXALtJr8Bl1EVl/Li3pH7MoZ/ub1bKY6cV2TxG/Zg5ulb1G9NaXh1fSTBm2dOyyEHD9iRI3BGHhEvSfrk3Px2ofy1YN/heX9uHHTrbxuhkLTEzscweqfS63p7O9wGvJqADS4barb3OWBJl/wGMukyPV1gzR628PDyV+P+N069+tAVZYFOVsSoOvDStIuDuSW+b+H66T44I9s4Mc2L+bhEg/EKpVmlcqPXBcHeDaXl/Gfo2zakZ85sPGVMwN1XH5TjyzLwoZOmBPGg6bASbzpDGJ8D0SEF4sHtNGFbOeE7yS4WKFpn8PPsaPOlUyWbV/5yW+EWWTam2RFSGfO/95BG8l0maqcz4AEwGjroeEaMBXbw5k5XgwOKSy9+Zn/mhqu7igf/yBbhcfrw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261022113327099003)(261026140227099003)(261026121527099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVI0RVZrUGxkZVFoQzdvMFcxVHRkTWkwT0VDUVJMVm9yTFJqM3BMQUkwc2xR?=
 =?utf-8?B?Y0FtK1FINEtOcmpSS2o3RnBGbFcxQjBoWFFSVFgvRUd6VW9XYnFQWStqMkJn?=
 =?utf-8?B?TWM2bzFPa28reXFMajhNUS9rZnlJYXhXaWtJUzY0cHh6VXp2M0owcHRQaXRK?=
 =?utf-8?B?Zm5QVm5xL2NuZHkrNVFSeit6dHVkbnlXNDlxSUdqY1MvRlZsTDlFU25yMmVU?=
 =?utf-8?B?eE94ckZzeXRvbkFuay9BR1pkSzVmV2g2U3l4ZFFHaWpNQitJV1J5Y0I0SzdW?=
 =?utf-8?B?amE5cGVvWTRWMDF0VG9aNnYyWkMreTJyS285QkxQQzRuNHJPaVZVdEg1cFd0?=
 =?utf-8?B?SkdDOGxKWEhNNlVOQ3dTUjRTZ3hJK00zSTJmdVREeFljc3pFTUJ0TWl1TlNy?=
 =?utf-8?B?VDg4WmNWaVcvRWs3ZXd0eVp0UnZtZlY4Uk9TaXR1YlM1cDlzNEJYSGx5MjFI?=
 =?utf-8?B?MjRkbWxZeVZQYnZLNGpsWEtRSkRIaHljcjQ3eURETzB6ajFUZzBVSHlFQ0pn?=
 =?utf-8?B?WGZXd0NTdERWcnNGMWRjckZNeE1NZTdqWUROclZYZ2pZYVlnVk5Wd1BxRzVk?=
 =?utf-8?B?Z1drWkhwN2N2U05YenA0QVBIMUlaR1F0VWFWU3Y5OEE5UFlCa2tjUVN2YTJq?=
 =?utf-8?B?bVNoVjFKKzdVcmp0S1FMZDd3UFhORHlQR0JJc3B4S21Ua3ArSGdGcWxyeTdY?=
 =?utf-8?B?RnRPdjhIa29hMHg0MWU4d1Z3QlRiZ2E0ZEFKQkV6R0RGNkVHOHVRZ2lTYUdU?=
 =?utf-8?B?L28ycHU1aXVYMXFlcVZzd05DMytCRUR3Q2ZVaWdpRHU4VWZhaUtyK3FtWGln?=
 =?utf-8?B?WW85VzRGNXh2TTNpbE9xeEExNXNTVURkN3JTYmF5UjA4YkNVd2E1QnhBZTJv?=
 =?utf-8?B?THJBNzg4M0IvRDZYeGcxbTNhSTdLT2F6Wm5Vb1JFcVplSmp5SjREeGRVd1ll?=
 =?utf-8?B?SVkrWEdobEkrRUFUN3d3K0J3amd2NG1jOVBIU1RIdnIwR3J5cU5IQVNtdEox?=
 =?utf-8?B?TjBCOU9TWlRLdHBmZ1Q4Nyt3T0tlbEU5TkZDbjM1bjFZNS9qSU1JVVcyYUl1?=
 =?utf-8?B?RWN6UEViZFpzeDhSUzEzRi9OU3c2NnlwbHByRGl6ZXBWcG9meG1iOGxhbEwv?=
 =?utf-8?B?SFZZekxFSnRaZUlFNnhQV3JwVkx5ckcrR09rMHAyQ2pQWGt5TXBqRmwvTlNX?=
 =?utf-8?B?N1FLSnN3S2hDY2tNK0xxaGV4cXY1SDZTWlBJS0RrNjFvVXhaQm9EeUI5c2oz?=
 =?utf-8?B?WHpuK2gwS3BjaGZRbWdIODRPa0pBRXZndkVjR3ZBSmJMZVljSnZjT3FyOTZN?=
 =?utf-8?B?VWVtbFlyNjBvNnFFREJPaFp3cDZ6d0xwcnB1WkxVZXhtbGdON2tobC9oZlhz?=
 =?utf-8?B?MS9SU0haNVViUjBrZ2NsOTVMbFh2WCtnVlhFL3FHYk1qZ1FjSURyR1c4UTFm?=
 =?utf-8?B?d3FGYmxHMVYwTWZ2WGt4ZVBLNWVzNGFoMTk2Uzd0eElyT2lHUGViRVZDUEVG?=
 =?utf-8?B?ekhZSkVDT0lXUkF4VHJQM0poaFhZNCtpYlJJOVhZUTJqcUZDYkhxK0xURDRF?=
 =?utf-8?B?NnYrMkVBVCs0b2ZHZHVOR3VWVStSeTZKeU1MMGEyN2c1elg5dDc5TGxNeWZw?=
 =?utf-8?B?TnlmYURJWkdMblB0Wm1NZlB2eERTbTFwVjM0NEFrOERqQ0hZNGxnSE05ZmIx?=
 =?utf-8?B?ZllSZTZGVmUzSm9qTXRVcisrMjBiMnZHZDhVVFZxa1Z5OGxkYVIvWFhLNWQx?=
 =?utf-8?B?ZGQ3SU1PMW9zMTVROVVrU0xNS01UN1FrSHVKYzkvUG5OS29DYU9lSGtkUUxM?=
 =?utf-8?B?V1dlamNLTThwQys1V3VqcWU4RnRwWkFESTBFeHRBaytxWWIzOGhaK0NuZUJ1?=
 =?utf-8?B?MmN2aFY4OEk4OW5YWkdDY1BSVktuTDhycjJxVjg5dGU1aFdYanNvM2l2dXgr?=
 =?utf-8?B?VFZIMnF0SGkxZFE4RzhwekFLM0tNQ2Q5clZHcGg4VFNPaXVlK0I3bVduTk80?=
 =?utf-8?B?NVBpajl6TnFKM1hUNTJSaEpKYmQ5RkhEUHZXaG94ckd3ZlZCRk9NK0JscWZz?=
 =?utf-8?B?WHh2SVV1cU9nR2w2b282R0lOSWVBM21Vc3p6NTdlNDg5R2lvWS9LQ1hkQVVC?=
 =?utf-8?B?dnlWSkFGYmdoeU5MVUdvYmNBQUNiV0tPK3o3cnF3T0JJQzhhOWUvZ3JtWmRv?=
 =?utf-8?B?MTk4TnJTaG9aOG94eDFVLzZhYXp1OGdtd0sxeGJYUzU0VjFGcU4zaTBtd1ZH?=
 =?utf-8?B?T0Q3bjlhNGhHVk5iRThXZUZVMk8zQkQ2c0FLZEV6Z3oxWlVNZjJIMXhmM0xn?=
 =?utf-8?B?djhLNEY4SUUwTHNVQ2dKNm1SNTUzdjVyRWxoSDBrNDI2dzhmTzZhZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76939c98-f91f-408b-4b9a-08df3502344c
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:46:18.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77gGTNl6GXhuiYH2WcD2g11OiZyP8XsaHmktspe/TSjqo43Ow77iJW++p0zNrOP+8IUm8cAc94Sv5o5WR7Q9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB176353

On 28.10.26 14:05, Michael S. Tsirkin wrote:
> On Wed, Oct 28, 2026 at 01:44:30PM +0100, Dragos Tatulea wrote:
>> Hi,
>>
>> We've started seeing regressions for a while in our verification CI for
>> vDPA Live Migration tests. Occasionally the FW returns a syndrome
>> related to invalid mappings during device reset.
>>
>> We've narrowed this down to commit 1ed35ac7f3fe "vhost_iotlb: bound map
>> allocation in add_range" which limits the iotlbs to 2K by default. On a
>> host with fragmented memory you can get easily more than 2K entries.
>> This results in truncated/incomplete iotlbs mapped to the device and when
>> the rings happen to be outside of the first 2K mappings the FW will complain
>> because it got addresses that are not mapped.
>>
>> I'm not sure how to fix this though:
>>
>> - LLM suggests setting the 2K limit only in VA mode and using 0 as
>>   before in PA mode because PA mode is limited anyway. Does this
>>   work?
> 
> Well no, we do need the limit in PA mode I think.
> 
> But we should maybe  bound from what's actually being mapped rather than
> a fixed count. e.g. X entries per pinned page?
You could have many 1 PAGE_SIZE mappings though. It wouldn't help
then.

> Bounding by bytes instead of entry count is another option.How to get this limit from userspace though? Would RLIMIT_MEMLOCK
be an option? Although `ulimit -l unlimited` would need to be
capped to some value...

Also, if the entry limit is still there some kind of precedence between
memory and entry limit needs to be decided.> 
> Also 0 is now rejected.
> 
> 
> 
>> - Can we detect this and reject the device / stop the device at boot time?
>>   Probably not as this doesn't cover Live Migration.
> 
> Exactly. Besides, failure is not at boot.
> 
>>
>> Any thoughts?
> 
> Does boosting max_iotlb_entries help?
> vhost_vdpa.max_iotlb_entries=65536? Or sized to guest RAM?
If set as module paramer? Yes, it works. But the user should see some
kind of error to know that something is off. Otherwise things will start
failing silently and randomly...

Thanks,
Dragos
