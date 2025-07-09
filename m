Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0B2580F7
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057483; cv=fail; b=p4l9AjaH5LYOw+7MReWiMzIpcqG+FxHH7jody5NNLBrVAaswyWJMBXXCYEW8y9H/08UluuqHcvTfWvojH3QOPzpbhLKRVqLDwvdJ6YXJbW5BrKgjoO/HEQk/V3SdZ8mPRGR9n8U9DR1YCrmx6oborNHeDAXF9LkMp2dAe8oBHsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057483; c=relaxed/simple;
	bh=ig6YVaY4nBQwGr2P/EDNBDAgOWrJ7ZjJfDNkrjzT7lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KSfkRE1VGDO7Dyh5KqAe9quw1HwTxN+ONTeU3mwHl1wA/T5x/XiFLHXSwladimk3b5ZAwH/kXdYcXWQaGJz9Vb4xJ7V8jBE/NAtG3zp7xZGDVMWP/t9wi4Sz9b1oppXEgQNbUUCvCQpEsYt8KTLJAD35qO/UxL/Q4J9ba1Grb+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YwAadFT8; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YwAadFT8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hr69s3pEbveX90Sku7BZtoLwi5iP/8YO4v4J6MOLFx++v5mz6wT0f5I1bwxWHQ56pFlnG4UZ/qa37Mn1ipp+t754dyLIS0X+i/hKfukO0MBD7ElAXT95PvrALMKcb/dYc+yXlfiwLY2IFnS5yQtvKB5kdtr2bQWNNhDcL0Rtg7dYPjLnVkIYBT+Om6jnDrwsrU8DH8L1eSDwJt4e9628AnVm4VejVkLvmMY0HhAXn+BOtJnWwCYNNFO1xqEMijJ2tVqF2YMz4VdO4I9rkWn9kGcpGf/K+qbZat6mtaJUjvMhZzFSz+i7ez3e6L2tTF04G+hhuL0B3J9DlcwYqWibOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b3HehPBB2CqIYx/pbR4PZfUZ+J995SKC7+Wsmo1sw4=;
 b=o/veX04x8HIkLdD3C6FNQNnFgPG/e2LJ+0CPNkZr1FrT+wNX+LLoB0qXp6oimj2HXJpqcx+9l2orhIJ94Eo/MI6TRBkvdHWUOujUelJ+ShPtGN/jr5v7Cy7z0JwFGFI8jqmuqV0FwqIbV3K0kgKJ851LUU0KuDDFNqXqRGeNhXFQNm9vk44m2H5dkoDnAObuCsUnvZ2dYtx2Cf3NTmRDR6Jomhy6+mN8nfMjRtFq475PKFk1gDIswLm2PEERWnfV4Cr8CvVwrUNPI5qAiG06AAjoUUQIGWM9m2dD59qp3vTwzFq7Ra8XFNKrmKM6snD24lBW8V+CYm6BbgmzSS/3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b3HehPBB2CqIYx/pbR4PZfUZ+J995SKC7+Wsmo1sw4=;
 b=YwAadFT8stvBpXbIg31x70dJglo5V0aBqeuMrFI6XjJWVTYFpgwvJZvEA5G3F530nZ22ZRaL/ZcYEiJgfTthR4MV9ho9MnH7ISUS6QUhfHhSrkcJWOX71LZLJR3n+9HHgstys6xR6EgjsuQcOd6B4r4ouAboqDkgt1jELCtlhhjVtJpyy56pnYs6F9+gKOCdySA4WgMxZ4MXYiuaKgEhMYXYXbuKO+fGF/cNU8KnFk3DLbPS8omc7oR2RkGvNjRT1+3CMDwJacWGIKY5qN/nzUytKHe+JRQMbwaant38Uevk+WMn0ccVThkMz+E+Oinh5g6cItj0L2NX1o6zbk1ygA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 10:37:57 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:37:57 +0000
Date: Wed, 9 Jul 2025 10:37:26 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Wenli Quan <wquan@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev
Subject: Re: Host Crash when re-running vDPA device creation script after
 interruption
Message-ID: <zfddiyxykxaoev4wbaxh6ml6czew44k5mt4jsxylpbybnqbs6y@rcfi5dpy5qv4>
References: <CADZSLS0zp9rqP2=vCh8eHVH_U+g+k_8pitV939u9Ls8ZPEMfJQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADZSLS0zp9rqP2=vCh8eHVH_U+g+k_8pitV939u9Ls8ZPEMfJQ@mail.gmail.com>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 33484045-261d-4710-81f4-08ddbed4ab02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1W/PWTMsy672GRyhWfRo1hkQkOMbSDE7XQ71yH0e9neq70nWSPRzA5N8vDIj?=
 =?us-ascii?Q?ABdF+i90Riww3/RRGte61eOoE8CkMzfZXPN5x0++bEZPms1/JFc8iKh6c5+r?=
 =?us-ascii?Q?jAfX6qk0usJr21MN+QdDxPN5AV/sXXrFnDxiuuMH+usFYdGDJrbvug34+vgX?=
 =?us-ascii?Q?pSzftO9uthSQeXD8UtwSv3UEcn3EUBwaQ9OAf53ju+j6E0U9Q7GqzRZY6bfM?=
 =?us-ascii?Q?LDyrv9sZ8vW4WPieOTiVUNbK93g6g75En6s8K4fiQyybILFuDNhNz8u6Qsla?=
 =?us-ascii?Q?U6g6n+bTVKa6BbfI/Y157g1MdCvwmeSCAuXJ1heqAI32fHCy/yurNua9VKrT?=
 =?us-ascii?Q?37TXVXo6YpUB/BrfA84oyZQKttUSi62Od1W3R/rshygZojQPulOkh1fuLJYc?=
 =?us-ascii?Q?/siQoFYHg5VZH4pLdtq7iX0Vaz3BbLgDu0iP9WOkx6SD49lFGq0Y/AZ/U4LG?=
 =?us-ascii?Q?MjfVxiMLgkoqBiW7wSeAZASGMFox+jncfuJizP6LFCmHmO+Pm4IfB7Fx4CXO?=
 =?us-ascii?Q?dVMheUgIvXnHTHOk1tBExoRKQ4sbO9ARxwkH2doWahyVSdaL9P5sRpUlAf8l?=
 =?us-ascii?Q?2+Asit7lvsEoGYu+bqcaVdzjZ0d3KXRaH6KdHOZrxEER0NCm0k/saEL40TFU?=
 =?us-ascii?Q?Mre/R3YTQlEkhqjEHf8dkq+cfXYqaZHMLnOJY0sxNOXMeZcZo7xAih8Od7Tl?=
 =?us-ascii?Q?SPkdJPrRUGeN6Tn0afE7Z1k2626utsG/kS68RN4rhcl6mud7/6yZBvPZzIMk?=
 =?us-ascii?Q?QRo/GprqKjyPNJX56nZWpw2WJMovG6dw9jdsomEWxuHj6gpnG08oxh/YAXj3?=
 =?us-ascii?Q?z6p9QYnKvHl7bjCOCJYsrxYTGwxAe1FN1VfqDZFYxsvsRykDdjB+TxkzcmjC?=
 =?us-ascii?Q?qYkGAmvsigDQoTBbqbG28V06tTspFsABEzkesssK3Slajk1hqgFrqIlWuP1o?=
 =?us-ascii?Q?Uf/5N+9ULlvv4Ri52MxVdw53gQdGCOO+/mfZuMyX8IfmXxs2qAw9Y+BPJKBq?=
 =?us-ascii?Q?3YSjp4suReMtQENSK07z51Bf80c8Xb9gj9FbVgrtZN3DoGtxVNGodHp+dglO?=
 =?us-ascii?Q?WkY1QLFSZLeCPcgyWdlxezJZlWWjDbHqnOnTz2/KhF7ztomdACL9zj8BzuOQ?=
 =?us-ascii?Q?D0oK5iVproGxhdd9bWrUkANPHCZpgn7PWwtEpedEBVpPRiF5axmZcLIfCw6b?=
 =?us-ascii?Q?hUV0KAJ1Ji/FzHPxE9HH1HLfh6MAbH+ebW37ix2lF1lQhwoL6W2pQODXKQ9b?=
 =?us-ascii?Q?T7hqHy95/xE5Bl9UhnMBday2epLepp3p1um1GUKZvYluc6cuawIZETByzBAC?=
 =?us-ascii?Q?2GtBnZq9v91X7+BnR82mIVllHNc9HQRkmKte92doItoCcbk2/sT/xuNJutTJ?=
 =?us-ascii?Q?e6XDokeX7aKDS2CE9+B+jXG0RKK7Ics99lLYSeAS6qhHWghHdX52xy87auDp?=
 =?us-ascii?Q?8BrTJuCDqFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VjmMcloG9ixzaco9Wh3Xna6VfHKOtxzRTYyDD2wLp+8kAyKFgL31x8AJWcQ3?=
 =?us-ascii?Q?abho0poWmxHW/Lt/3mmNKE2+bTgnni/e2thfteDT4AqX3TJ1/miA/bvLZKr2?=
 =?us-ascii?Q?e6lFz6DKS5Wxf/f7CW3VZGCdxoGT6hWJCXnxIDm/PuBFoeycCOGl+JWEWPAH?=
 =?us-ascii?Q?NVXCwlVUCQ7rNvdc430ylBDaWNNeUTCIbMn3lC1zcRGoW0lZfbyyREOMsGVf?=
 =?us-ascii?Q?xt9p6HQ+EgwaRKt9uG/iIrwLfYEpA/sRbo+YPjA5G673IJHkaNnYl1u4HlF3?=
 =?us-ascii?Q?P0e/T0aXAO08jtDXmD+nVrE7CbaNYuPH104X9NSO9+he1JtCAwybl/dpCFKv?=
 =?us-ascii?Q?uCMXP45dQW+/MjVZOBfcRaKSsqU5KknrIQhtaxlEkIPcRSE2gVHt6qhFxE4r?=
 =?us-ascii?Q?pm5vqYd0yiCz1wvlF5fg8ydVFsbE6oUAbLID/bCC9jOlz76Nrd89RpJ676c5?=
 =?us-ascii?Q?P5tvjts50cq1JHEP9B4Z+EV2htvVv/St+v7Sf7jjRHGA9UgC+ryYJqsJ4bGq?=
 =?us-ascii?Q?tIFKx+edW7Z9tsbkN1W/afYTKxJBbdXQMroeGsw3u2Jf08CxUZy9cBJ42/jR?=
 =?us-ascii?Q?OK/pFM9xPYk4ZQynCvHwQfLFaKpslM52SSamYPp2X8DmTANmHinQXa2ERrRo?=
 =?us-ascii?Q?/sIeckw12MMpgo2mpo8hujUbYT+wRulQQbVd+uRw6Kv7GrPRs0Udk+q+aRqK?=
 =?us-ascii?Q?g25PJCLq4ZVyx6gUQEK+zDJFmfLlTJY8b8CTrwPBJGp04Kckz/Q0xizSCZ4T?=
 =?us-ascii?Q?k7wj+S2FINArayVkAzVPS/HyVWu2Yj5Mw9Z1nIuMVPft+JmmHchjtqONYXlX?=
 =?us-ascii?Q?oh5F/jIIzrOGjurOXM9d6mlzuYlSQK6NnH5AzqaafehdZsGOSQ25FowWGKvH?=
 =?us-ascii?Q?5PkqtyuL5sDeymB7pkg8n8UXpRQ8e1sW2y1LuOTuojLuNVGqGSsJWzc69Rmi?=
 =?us-ascii?Q?QJODMxN+A94UfZ726zCkzzE0T/FJyRtIG3oYr+VlS4LsDBw6yVwNJWpPRZNT?=
 =?us-ascii?Q?Wt4yFYIXMLYCWpKlo7fQsNKZysV5JbKekALByZ5O4dj0m+R8kfzr8exkGBAO?=
 =?us-ascii?Q?ZADClTlNJ1mY3XBlbLX+mtsvXVVFjHQV56G50prMw/So9z5F/effiBCevR8o?=
 =?us-ascii?Q?sNsvHE3cu2opG9+S6yNrOPB9rWYIJUod4RWez0zqcuMd1BiSBKep5cp3V1Rw?=
 =?us-ascii?Q?cUNpHy++4PmGJpxRc4WNEQRf/C8jvTVj4Zu1UaA5lxwt2J5uo6TkPQBkXPJl?=
 =?us-ascii?Q?NppVFqHFF/22hdNtDYU8AujragOyvFIB5uF1F2OmR2bCYgeL43BU8gqvFEww?=
 =?us-ascii?Q?GLz3/nthYBTopiBKHWaDQicjEe8VvvG++pOgg72a81jQnLi4L8CKZ8ixheR2?=
 =?us-ascii?Q?VY7ZiDE123o38ky3cUebAqbUMvrnBk51JAs/z6cOKdeX2RW4ITyW0TfrBzFB?=
 =?us-ascii?Q?ezOfjyJBrGh/aMmlR4uN/Q9Aw6Av6uUr8LbExop9WRX93bA3Mga8RykXEfww?=
 =?us-ascii?Q?Wx9h/d1sBYmzK5JhJgcLvWEYLCNMXu/mPZ9MZSVjLwKw6zcqdyhfSaGpE01R?=
 =?us-ascii?Q?NVNCzbZwv0IcyYOaZZ/ImBx0C9DPn/Ukbxj1FsuV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33484045-261d-4710-81f4-08ddbed4ab02
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:37:56.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMeH0hZij7f3iuNB3ZWNnjo83IVzpftB3+HniRpdJXbgFMfJ3vr0YiBt9W7AMucWNAIQYKWbjk3oqekcG83P1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314

On Wed, Jul 09, 2025 at 05:36:04PM +0800, Wenli Quan wrote:
> I am reporting an issue where the host system crashes when re-running
> a script that creates a vDPA device after interrupting its previous
> execution. I am attaching the script for your analysis, as I am unsure
> of the exact step causing the crash.
>
Thanks for catching this Wenli. We'll look into it.

> # uname -r
> 6.16.0-rc2
> # sh vdpa-setup.sh  0000:b5:00.1 1
> interrupted by pressing Ctrl+C
Could you specify during which stage of the script do you interrupt it?

> # sh vdpa-setup.sh  0000:b5:00.1 1
> Then the host creatshed, please check the crash dump in attachment.
> 

Thanks,
Dragos
