Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DA3E121F
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253230; cv=fail; b=MVFhjcnNshrSm47b93eu0BXCnEOidJlK8gTWu4JLrsbpSLMLgz3KRQNYeJUGhRNAvrDgPqiylCn6OmpT5BQVXhm4ytFSru7PWUmIqw0gPlIYbwLUj18GJHdm5Qff2hcmNsge950dFh5dwv4m7xIG4EzB5fkeSvMlIahnZuC41J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253230; c=relaxed/simple;
	bh=SDKtpYeo81Ef09w/pf4cynx2AJSr/eod/7SdWaXXfhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y40mLUEPjnFChK4MkLtSFNNTHC0Ch7BfA0gofFohUvNzcr/9Old27ImG/yW4efVscH49wvv1aQlUndEjoicTW4DlQ5Lrvy6SuB31XDX7BU5vosxehs3oIGLqOI+70c+m6+m4y57uzuoUKDG0i0NNh/TftwP1T0yIwhTVFUosaCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=THeMahar; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="THeMahar"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqoJFcwcSy48xVRhVu55gbIBXgIhMAm60dP1iIxCffL07q239wpcvPwHCGTTxL9qLrnJIMLgoQYPwY6R9cH7YBIIwGYvkd7vNqaMHAltj/gh/fvi+SwTmjDRTRPDBTnng1yv64RlptyTQ0lbpImK2LfgPFmRpjDwTzRdXQoNWmMjr0Zhuf+WVchEc9nvdGrdLaq1x7VitpWG73QPauPn+CSl6g96WCRcdvuz+2qBd4bOEI3NB35DuLqsWKMbsvALPSTrJsG5D2NT3YkTxQI5MawK8RWfBLohtpH5ABewFJxE0PU7Tw/DundjUTBJOUijX66IQY7oy9S9mQdrV4l1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UN4IpSFXcN1LOBFD5RVFRwpikj27vVbFHx1Wiv3iVQ=;
 b=QEjHBk1Uk7PBZIP9LL2Uo55WRcra584tUJ7G0qX0W945qbOEmmazND4/88ohzOtHQ4HzB6fC6Uq3pDTGz2j4TCbEzejVywz84GICeRDXdAOyNKfP1dqxVaSFlT2JzMaKvMXutCfQmYLIMwSrOe+Nn0YBIFdLpnoE4lDhW4vusaFsJ44KjBep2kQwq46BW+ZgYUu7P1/Zpdbcg+76xS1dVdoU037k2poG4QoYsOIjlVWf7gEFMOHuj1HSPaPYGvjfCrpDPp8x/1jtuNNirP1EPjRe8Uzr+iLlFXq8W53dYZ7hcYMaoy7NCqwKBvi6hq/y83T/CXMMQCo0jDAMgN8ITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UN4IpSFXcN1LOBFD5RVFRwpikj27vVbFHx1Wiv3iVQ=;
 b=THeMaharcu0VgIla3d35eG9qnhUEGscshRcmwG2FxOV6EZ9mEyLaj2Ia+meR1jaDyO8v6n/ISjmTEu1zR6LXxStUWaVv3ZubynPhTSA41crO+LIhUC5F9a3icOr6kmLHwTSM2lAmQZAZ0r0hhnr14mluaV0bL8WYaaVJmXSZrMRAnov5Ae4KIlAAniSeFjfSwg3F6e9+xaUA9qTrrCR5/eL42XRLB63o2kWISmsaoYMTALjWDEYhJmIR335mwZ/yAjWaS/LAYUKyDhpg/J+QUpofqq7ptVPoSFJtWjdfh6p8uzSVRVtPE99NIzIpC7SVFP8q9gMDuBHt+6oAmFt7ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 15:13:34 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 15:13:34 +0000
Date: Fri, 8 May 2026 15:13:30 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Rosen Penev <rosenp@gmail.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Use kvzalloc_flex() for MTT command memory
Message-ID: <nwnfka23bthiptuzscsd6iteec4ht3knaxjgjyl4xmwuhypgab@uofxficme7ni>
References: <20260508051837.1744409-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508051837.1744409-1-rosenp@gmail.com>
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dc221e-95ad-4fc7-418b-08dead145f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sZLrzCUIYuW4M0Ih1JiSBc9jftAGZkhU3wSSXQKdfwPWSiujXmai4XTwSYtYldmjm9haJqhtwLUrD9xEFLXJZfm8McKHKE3yYtqQJ2++hAVijtxoHnrB72j/xSFST2sCbd5qb03xeSMB+94z3qQWBYnfTKKYTG6tVUAAOag8wNC4C/4mXkLQO4B5N8OTldGhLWIkvjvl81qORCGS+kyrJPbpsOCYpx/X9QJ2tkQScWvucI09lwKDaZihT35mNoGQxJE5skE1yU2dKNk33N4kSN62joTbhNnIQmg/8w4+qRAPVlm4vlgjoTvUKZC7bvakmzc6UoMETxuNCF0av6offmHATV1IbK6uTyIUkQbdfQDmikC2Q+0jypjo8mVYMDlij9VsGhe2mELKPH7usGYQ6H7qMwit2kqbwQmDY6I6o9StQCs9n9bx0wouhv5+TqUppSpQ21dkrRKf8XKNIiHojhUE49TYSB0niIcX3IwLB/GOYyhjn7pGBCCTsB3Btyh4/MMw2mkF8oNz8Grc47Ohc5nAV3NFIGsl29fHQGasIU3VJmTP5SIA2aqQnAtzq31feZVFTrmYfpAd6kX7U0SCxp4tnCu+FyJP6+No9r5OZ0stBHbmmu1B22zTdDPBgBsvUVCu37SeIHZwvNLKsj+3RTih//YuL2x/sHXUcS1wXqzsY0uVpwUWUmRtzpKjkDgP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qPBSfjHj9iaZaVOZr+VMFtqCR6ZS6+xu1vBesn93DMq6DU9ZwzCbkc2quUjq?=
 =?us-ascii?Q?Hcwu+VXqBWKaKLSlxjdinN7XBbHBCKRZCLv491xw94HPRE1zIGhtRISYi5SZ?=
 =?us-ascii?Q?xWBPmKrxxWDOrOlDYiOjfoTFezfPkpzzqu8HJIkTPptBN/1T1YaxO/rnFN7e?=
 =?us-ascii?Q?V+i4T6XBCqo1GmgcNZ3tYovBJ0r9TWSdDjjvIhWwN46KfIv9AecosenbYt+s?=
 =?us-ascii?Q?3aqCFD3Lm6+l1gs+Wp8nn2ycvJ6DBWrpZHnz5BTlwCKLMMSMpa489Wsa1G32?=
 =?us-ascii?Q?7t1jMxCJoI2Wv4jmxPdjww/Des9S2q81e/p7AvzJ/tKGy7JCip51zH19QLsz?=
 =?us-ascii?Q?O6shxUchCpbf9QiWFjJEMUi449e8GCWPMUMyUVYR5ouMtC2fcaW0fLwYr2o4?=
 =?us-ascii?Q?hK/nMHuWRcQSseW0cQT/4xQkLJQnQjtbHBiB9aAbCj/eOWP/G4eKC9ZHMz8S?=
 =?us-ascii?Q?xqfjTX5Ldo31DMYSrRQOar/5gSywqIGG+JR3Wx9NfUFaxJG9omJ46XtluSE+?=
 =?us-ascii?Q?JqgXX2v5n6dHAEKNxq34xrxs4VDTEItxs2ETr8wsp7/iANgXoDHS1cHyijj1?=
 =?us-ascii?Q?W4sEjbVg73Ee7z++bVgbC5b1I5dt9FNyivlXZyipxFujH0Q5DP+GlyGQ6tbA?=
 =?us-ascii?Q?d34xiNDAuxYK39+4j59qAlcu6L/5WdvdVBwjgaPv1KhGkIJBswiEFRux7nxP?=
 =?us-ascii?Q?3L7ERM25TbzMsYYLOF54i7kagzkc+dqs6pv44ID7ThYiBWd5Cp1/2te6IAoY?=
 =?us-ascii?Q?1GVBa7NzqVN3GWN4BkW27a6UpHcX0m10LjFILA8FrMz2cWf69CQxXeiLXWpZ?=
 =?us-ascii?Q?TVWzfbC3NSwcn1YdZ44YYtL49A53H1ZJG58S+KxMz4gKX8NyLtGn8TOHijE1?=
 =?us-ascii?Q?e0ynzu3mrpYMNkRKDB3wAb6wKgC++mSz0Sy1f3lRpZ6chB06Zar7gwdjbi9A?=
 =?us-ascii?Q?9lzmwp0ScTzVH+v6pxQLHBFF1H+VqeffbVbNro6H84e4IDsWwlePgmUefr+U?=
 =?us-ascii?Q?BzdWqpVA2sF5MTupUS993jMhFYfEF+tj5sthXPfzgWtQRYwI2m1YHtatFWCQ?=
 =?us-ascii?Q?AlXqRo1ncyv3WUXOndZPfFODwZZVWKHj1w6+83djFoad/RhvYEOJEi9UMZX0?=
 =?us-ascii?Q?XS32Mukjuy+JaP+8Tj2+hpsEFZO4eKBdgmg47tni/zp57Qk7oalpC60Fadvb?=
 =?us-ascii?Q?jZtrLKMB4xThnnEPogrhj4f4BGcHNu3y/dSQH0GgqA1N61pRUTWWKBiKha3E?=
 =?us-ascii?Q?h0oxUMMWAcpwSpq+zp2j07y/esKi6GTvAOYrFpFuBA+46CzcrrPQo3Eouewr?=
 =?us-ascii?Q?hX7B079iGEUC17j2jWekBxiQdmT4WvEFpmvuP1ETJnX1SMuxhtzTCvsTfKNc?=
 =?us-ascii?Q?PYfSQWnut3m4+6nVX57g8xTGNJuPaAQ/h3jnFJ2dyPlAvrq+SSvccvL2UMzc?=
 =?us-ascii?Q?DRLoTDwhozz26NTvftXonAzMTJdxPiF0E+V/d4hSJm8LS/KxcFVYF6BS2+em?=
 =?us-ascii?Q?Dpw8gWH+i9oxSGY2m6SmxOnoka1IB0zkfwXT05Epcd5frIxPzrwE8TPaQDFa?=
 =?us-ascii?Q?nHXmJKw4lUhHJeUQnyM/tb0TaGslpkn+LxZUZVY9UEAygrSGWviAg3H/dLB4?=
 =?us-ascii?Q?JScyBJU+r4GeldEVuAntccYrKxdh/aX6plLWaVT1dSoOdGJDaiJwH+ZPuP5X?=
 =?us-ascii?Q?93qGfoZso2mRNpc7P5Ii6n9zHxilBR6MCZQw8LX1iobR6iPV8vnow1Yp0ihv?=
 =?us-ascii?Q?TI8gmHMueg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc221e-95ad-4fc7-418b-08dead145f39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 15:13:34.4148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjcDcwpWACJpu9xGtqKKk1wqvY5j4IumMUdfyvk9ku+Au8iTfTUcckqLgF2aVeIwtrUqmInkPDEBKw/av1/8VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979

On Thu, May 07, 2026 at 10:18:37PM -0700, Rosen Penev wrote:
> The create mkey command memory embeds the MTT array as a flexible array
> member. Use kvzalloc_flex() to allocate it directly instead of open-coding
> the struct_size() calculation with kvcalloc().
> 
> The MTT allocation still needs to be aligned to MLX5_VDPA_MTT_ALIGN bytes.
> Since each MTT entry is __be64, align the entry count directly and avoid
> carrying a separate byte length variable.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index 42c2705077a6..6d02ccf9eb91 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -221,11 +221,10 @@ static int create_direct_keys(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *
>  
>  	list_for_each_entry(dmr, &mr->head, list) {
>  		struct mlx5_create_mkey_mem *cmd_mem;
> -		int mttlen, mttcount;
> +		int mttcount;
>  
> -		mttlen = roundup(MLX5_ST_SZ_BYTES(mtt) * dmr->nsg, MLX5_VDPA_MTT_ALIGN);
> -		mttcount = mttlen / sizeof(cmd_mem->mtt[0]);
> -		cmd_mem = kvcalloc(1, struct_size(cmd_mem, mtt, mttcount), GFP_KERNEL);
> +		mttcount = ALIGN(dmr->nsg, MLX5_VDPA_MTT_ALIGN / sizeof(cmd_mem->mtt[0]));
> +		cmd_mem = kvzalloc_flex(*cmd_mem, mtt, mttcount);
>  		if (!cmd_mem) {
>  			err = -ENOMEM;
>  			goto done;
> -- 
> 2.54.0
> 
Thanks for the patch. Code and commit message looks good.
Not sure about the Assisted-by tag, but that is not my call.

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos
