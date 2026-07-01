Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147435E1BF
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918146; cv=fail; b=ADQJsejURlVj8+EAWouZF3Heab6xM4qHWwyjhQGxuXbgNnEAKTo94wAazmsl3elXs/5SVyl9ig9KcPT0HoptvmzdRujyNpT3ZO7FbEnSIrscd0D47jAZg7wdrhH+DQTuLLanzwV3aOJYsVF10Kq9ONoCb0NKVR6goq7YCuyaT7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918146; c=relaxed/simple;
	bh=cviEHZEYWKFEtSjtoe3LaVwDXP9Sqj3PwAPAXZOMvI0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ux5yOuEjhL09i87RUpT3QEUqimYSQWM+fJ6DwExAT6im3pEWv5B1R0rIlDFu3rhINWpEBAgZnJu8D3g7MFh38gXYm/BIcsUiKujDTi9zAluTNcgGVMa0IvglscYRC7YPuwqDJJgdwQUPOqwKp5XFR+h9qaJrCiJ41ueszEOnfPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rzyzglPw; arc=fail smtp.client-ip=40.93.196.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rzyzglPw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQK/LJKiWAbyoZJTECkJrd17uGX8rFdI6FsHGdioebMJh1YZZi4+tDFJEadQgLVCnuPBtzELEhrjM1G3o1y9S8I7xhsMxxpqIh7vUN+parHX1exmOkQHiullAxCCIlVZVTEXQBaGrQmGQz8fR+bc+MpmYAcyhd4UVB4sj9OzxRsJ6BNFEAVTjytIqOKKyIFSBiPigs2H1hpvGn6DPScYb6KcCtfV33uZXj/hMP1UhOZ9u5wLPGjNdYgCi9oZTuzc2LoRSDYWZX9ZIhRjaulSHSqE/03ZsMmOOm0+CzgB4uEEZBnFktwxnlV4em/2lmGbnT1a72q+PUVoxkcFfb5ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIc0ZaHWrNeGf4EOPTScurJxhvfTx5s0zXyOsQq0n0U=;
 b=oYbNbgFTzZT80OLXLrsopSgN9YxrI3TthpHLFvMODrxS3WiyvBMEXW4Ww7FEIBse4qsPfRXLb1dvKUJspXuAMVTlyvH0eenfgP77mdSrExSbdebK98BY+G06p0lktwIBQD9J21Sz85H7/DKl1kTCSgfXLvdp4tFvTUUb/0VMNySwUBOc3a6eN8qTFWzCZLIb4EoYI4iLvccbufyUDQ6DDRIeGyiitp6hC2EZflZrFMcuE4R3OV5EHYRbEio+tNu+6zcQ8jj56lfu3mBV82AAkP7nLBS07MHHMpKluM7dRzxl/K4NrwGigdXoI3cFOx/HXTgG2Ee/c4uLuefh5IJBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIc0ZaHWrNeGf4EOPTScurJxhvfTx5s0zXyOsQq0n0U=;
 b=rzyzglPwz5g7Sb9QmC0+t6ffGrJQjQna81geBFqyX15qbTILGnEGp3lomAjGOevBOU0XE7OXJyiQqsbsmO8RsKI+FLeT03zfb/axJ1RDvCZXdtA/qGGLQlqdhZan++NDWkvMHaq17FwJUQHaUevLVvAH4c/M2UzLwuAAoEtZHljNS1xNyIui6DABoCoYm+mhEJlEAzeDRmKsyKy0Sm8VfRSSc1NqnQntYsTJODWu8Yrk8ZNI8jsOGlag5jJkwNkF9qVV8pSOBxtfrEgTD+6wZEWcfmzZgD1H806+wV8cAl360EnZCjUc90+jxDTaw3VAO/2Oy2/o/wLKVIJcgCeXXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 15:02:15 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 15:02:13 +0000
Message-ID: <e7af1b74-774f-483c-a920-2c1f22e76112@nvidia.com>
Date: Wed, 1 Jul 2026 17:02:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: fix wrong list iterated in add_direct_chain
 error path
To: lirongqing <lirongqing@baidu.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Kees Cook <kees@kernel.org>,
 Rosen Penev <rosenp@gmail.com>, Parav Pandit <parav@mellanox.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260701113608.1972-1-lirongqing@baidu.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260701113608.1972-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd7a27a-0af8-4af1-fc4e-08ded781bbc6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|921020|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QGaun8JSGG856Z3q810GGkkFxHccsXqbwhuR+s/CQVph2TS3AHnIYPto0iDkWpIwA8hKr0E2+gR8PAdOOIag8PGevS41D1Rn+ymlZJorFuxiEWSggOTk0uiji/N4zx+X+q5kM2QOZ3PyVO2fiuS4k1dnMOdOgKjHUBcWXIxvN4XmAhdCgeOm+FkV+JDnbZo2E+bWK5IQHUPGEphXeW4q8jCXduDs3lAFbHAMy2o8HFN7xjZorWHlx8OY8zcSnrI5ImIx5lL/zhwrvvu3WdxTA2oA7XXJse65OBsvvTLyLLKHKkHPvSfOR8Pdg1tAuC9q6JVNznzA8UewKTAz1PRUY/Wa05VJ1HwmGeLDZSnNBZYmGFgAkcaZgiBNkeZJKnhkhUjY/6m48SDwz6taVnHb3vr9yfTUxoHEk4jSew3OSM6Jz9Rx0eoM2qQuye1c+k2/5Vm1bc7k8bH4TgMMLWYoSFrvaiUwZ1FuilMsfbQeA677+xAaSwpcTdZVuYw1DzN+tDjry3EaMOWQdPifJ0Pj1T+O/ClmT3KIeguB5vNDyYjWpoQYp5FiEh4uOmIcJ0cB9vVLqBJdumR1lm0I7Z/RYUQcJB4Tnp1td9L6aL+H7X6R/AxGQkiSyxufNlG9rFR/xZxSQkqlflKX6Luckbgp+1llF/1Stnjv8kwStwnxosJtt8jLi/QHF5PqTpvMiCU5w0Cx/zKq2g+2eGKJ8ZAAcg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(921020)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW9sTWJEZC90Vm1SNE9ma1R0ZWNMdnZBZUFGbFBZWHk5a2pzS05XVE1rbnBS?=
 =?utf-8?B?ZUtLU2VzNnlCYzhXSWYxUURnY0RUOHNFejdpMXVVNEhRTTZramdhQmEzZXhZ?=
 =?utf-8?B?dU5Va2V4bldCSHBvSitTcVBITHVWbTd3TkZ1WXRLb0Q3dTdXdklJTXZtTVZF?=
 =?utf-8?B?VzdrdTJGclpsZEszR0Vyc003TW1SYUYvTjJCbXUzcEFCQ3Fxcnc0Ti9SL1pU?=
 =?utf-8?B?ZkxuM1dnOGx4bXBsM1NnM2VNVEhZbm05OUltZFhIbnpXaHQ4QmVXdUlhdHJB?=
 =?utf-8?B?Y0RDbEtWUk9lWnd2SVNIRndJYWtyVkpHdW9EeTkrN3B2Q0tvSExERVZzN21j?=
 =?utf-8?B?Q0dPOVJaSVNaYVkyWmhvRU1CQ1Y5TENNc2JxdW9adkdWUFovV2pjdGY0cUpm?=
 =?utf-8?B?ZzdGTW1hQ1lPZzVHRjB5YlZLOFR5WS85b2ZKMCt0dnVtaUVBWURheXE5TldX?=
 =?utf-8?B?U1VoWFgvS3JPVzdFelpTb3ZQcDVpd3Mvc1RVSTNGaGpLZFN4cFNld3lpZ1Nk?=
 =?utf-8?B?Y3lhV0J2Y0lsdXJ1WEhZOTY0dHFPZlV5VytpMFV0S1RGbkMrcHorUHU4ZHNS?=
 =?utf-8?B?L3ZZbk12eFY1SDJYQWFCS3RtTFZ3MzVhT2Y5aWlMSnBKN2E4ajI4S3dvdUxR?=
 =?utf-8?B?dW5IaGxSTlNiNkJyWGliZ2w0aXZZT0ljOW56Mm4yQkFNUkhVZUdtbW8waENZ?=
 =?utf-8?B?WEkyUTRoOWpQbHR6ZzBHbG9SWFZYYlJ0WHpNUUN0UDZUQjNFdlFxS0ZVcTZS?=
 =?utf-8?B?d3JpdW5zRkw2c3VyYmxURUlmN1lKMWVNNTZJSG1JTTFjMlR1T3g4QjJMOGtN?=
 =?utf-8?B?OGt0ZkRjQzJxNkRvVVFROVpFeFQzQ1JmZEZ3b21QVVc5STlTeFhMVytYZG44?=
 =?utf-8?B?ZzkrYWpZTCtZUno4Tmo4WFErVVRnZkRTV3BFSGJDakoyRkU1aFlya3FGVWpk?=
 =?utf-8?B?Si8xNjRtdXpVZUg2ZWhkNitESE95UEVUb1ZEd0tQKzNTRlF4d0M5cDNoM0pl?=
 =?utf-8?B?WDlHU3I2TXlNdm1KaWdmWkMxUmtkSnNWa1hSOVp3MUM2QXEwNUgzKzZBdHQ4?=
 =?utf-8?B?cXRYR2dVUWprMmw5MnE2UUp3SXV4YVRrZjZYUHNucU02eXA0ODZJMG1rK05w?=
 =?utf-8?B?TTVXbnpOV3ZEc29XbnFIcEZiVEY1MWNCUi9yYUNLcUVMRldHWEh3R0JTS2N5?=
 =?utf-8?B?d2lPNkw0K2d3eE0xbEd5YjZEYkRERklBblgwY0FhUDRXL1QzcGZVQnd3cytZ?=
 =?utf-8?B?Y1k4R3Z6cWJ6WEpQeENRVjNoUno2czFveEN1WEhnY3cxS0NGbVVuOUh3YTdy?=
 =?utf-8?B?L2xlS3RpZnZReXB3ZHV2elc5OGJNS29PamJrK0tFdk1mYXRHenJCd1JoOFdP?=
 =?utf-8?B?VE9IdzIxRXYxVEs2eUNHbHYvbFNrNjBGYVFZN1FtUXRXM0txcmU1eGlPTHV2?=
 =?utf-8?B?WnFJREFYYXRwdy9vejNSZU9zMGF1VWlRTi9KS0s1cjZMVGZjUEpIQW0ycnJ1?=
 =?utf-8?B?WFJhWTBiWjFacEVNNkhkMC9TTU9RZ09wK0lBWVFqVUJlV3BzdkFCOTk1L2JP?=
 =?utf-8?B?UlJRdDRITjNta05DbnF0VGdnMnNkWitxZEZiMExCVW1yOVhrUW1nVWs2MHFJ?=
 =?utf-8?B?MzB3NkFrR1BWQXpQbXcxY0phZURFSXRrZDZIY3oxRTJEcWxOd1hHS2h2eGx2?=
 =?utf-8?B?S283SnoySXRwdGFCNm4vRHNIaUh4aDlHdDVBUTRWWkdKbTVlejlEcUxETkRa?=
 =?utf-8?B?VURJdlFGdU5PbkNBNm1LSUtlSmFvUG9LZ2ErS3prYWZ1NEhtaUpiTzNiQWVJ?=
 =?utf-8?B?R3VPQVc4RmdScG1ZTTBBR3VLNmUxQVRRZ1FDUkErQWFwdEExMGV4Zmp4OUpk?=
 =?utf-8?B?blZtc1grakFjS1MydGJzdlA5WGwyMWd3VUdBVFF2QXlaYXBTM2ptL2czM1FV?=
 =?utf-8?B?cUhIM2dwbEtDNU5NRWFQcUFLNzhUWHpkQ1NUYllRUzMvVjUwemF3WWRWSTdI?=
 =?utf-8?B?aFVrK3dpQ0x4YXRPSDArbWtqQjhpSGNSZjEvMzN3K2lrQ3ZaR1NvZ2QzQWFk?=
 =?utf-8?B?WmJxWFFndjVtV1B0OG13eU1WcjRCYUl1Si9hd2xWVmUxNm8xN3phUVZRd1Mz?=
 =?utf-8?B?ZS84aFNwaS9TczBpU1pqYXdtcmZNZi9JS0s4OEZnNGhmczJrNzlLeEdCVVNR?=
 =?utf-8?B?TGJVbG1IVUdScTJPWXM4Y1JyQVg0UytESnpNcGVrSXRNRnJLSTRtTElnelov?=
 =?utf-8?B?dDFGNVhKd01ad0c0cVAxUytqQmU3amJGM1VaY3l5WGRGM0h6T3paNUU1NE1O?=
 =?utf-8?B?dGNqOUdvRm1XRTZ2UUtuVERKODRSZ25obTlNL016RXN3QU5nazNIQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd7a27a-0af8-4af1-fc4e-08ded781bbc6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 15:02:13.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxlnhKDKXkaEsXgACJGqpD3eby4ePC2zdYNTxTR6vRlQoYSWUZ0oo5jUL2qKmQaW+sYrLOSSDgtKPKzilLG9TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237



On 01.07.26 13:36, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In add_direct_chain(), newly allocated direct MR entries are added to
> the local list 'tmp', which is spliced into mr->head only on success.
> On the error path, the cleanup loop was incorrectly iterating over
> mr->head instead of tmp.
> 
> Fix by iterating over 'tmp' in the err_alloc cleanup path.
> 
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 6d02ccf..1a224f0 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -480,7 +480,7 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev,
>  	return 0;
>  
>  err_alloc:
> -	list_for_each_entry_safe(dmr, n, &mr->head, list) {
> +	list_for_each_entry_safe(dmr, n, &tmp, list) {
>  		list_del_init(&dmr->list);
>  		unmap_direct_mr(mvdev, dmr);
>  		kfree(dmr);

Thanks for your patch!
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos
