Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D62FE07F
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155230; cv=fail; b=nJU+HedLUDQ03S+8AzaZeaDMUVuOahWuab4ktVCNl26UmltR5m1CU0xno7dvvkMHnsib/vH8z2Q5lIu9IujQeGX/BgWFo/s74FHxhy3nxWcGnUP4scKaI7VYP+CSctbPsiBULP039LyI85RgGfyT9/bvEHugdGf2Ic46bh0o3/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155230; c=relaxed/simple;
	bh=AWDd2uAcIi+C0iDhsnv5VGyNkG6Z9HRiC4I21D5Vj9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2EvkAHalwYiP1h3owJyDoKnJSX7Iq8eW/TEwSXUwoAi5Dam2vxhZj+mqgtHA9dozavpwjR7PT/RGqbOAiEszH5H9HA5Bk3mQlqxfpdE9k1JIgt/BI0RKhdTT44suT/I9ib2VE2GojcDe9rC0s+HpwEYh0OExNgwhtg6Q6OChyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rqpTimbC; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rqpTimbC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZQx+sGcf+7d/YfzhKKrpd403r8EKAA98X1z9+P2udeSw8Ar4/3Bner0nNEHXvtFO086RaxVB2x+sTfsW/3vIePCawschfUxcVaJjioFWqT7HU6s5ssZdOtdd1tezB4UC3GIMcwVYmMjyxHxLFl8Ql3FSs++fX57BJsn+WLVlEVQbARUJ/E/Z7EJ0pg57JyjXjKxVVWgupsc+goTPzbCT2QtFeMNkpdTmHIikZHNKHK8vaO5JneHh34ft3Vo7aMAv1TugdAH5vaXASiDN9S4rzuw0EhofhMfM4Y45BhRmyctSay1IMNkju/6Thk4yTgjlifuArS5M5jEedjqMRUJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Z7rA4Yv38sS+LYnK2EGScDRUyY3eO7smtZeEXRL48=;
 b=ijvPg0miSo4hkyxuDW1aEk1YQAmjw/QjFqYD3bA+D/IlD7+aeJ9iDtZAkSgRPZC6ucj8I5QY8IjGVgFYr9nq1vWKA3N6HwhD/N0gjuIUuRCNPbVGP7GFPcmXn5NBbjWf0abIZZ0KBwYdkoew06lF/4q1suJn60wfL8o6+RYoriCLVRPl5W3q0VzAnQk8+HUpK4CcLkkSVaa6XksTM+PYPiAtl0m5la0rKygpcvFNtNSaRe0LTqn79MkYe7j13zyWr5sJMYvrM6cI5cO2VcmI3UuUUuFiqz9pdZ8qU7GSPK2eEY54fIVpePkQQNchHHw37CwlcyI+HxjfkUVWcrpqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Z7rA4Yv38sS+LYnK2EGScDRUyY3eO7smtZeEXRL48=;
 b=rqpTimbC6H74z5Ehozcsf7ugrjwxfMDXbSvsk7T1JgTpKNtavqJSWXQ8pxGcuV4Z6mrgQEH8aJsYxn3U/lQluVG7pcvdfLepfO6YuOgFhPEYiQJPQrTZsQ7CPLoWSHZCV7RSU9cZz3ZQ2ZjbYZE9bpnWE3ynie1y4cZK36Lo/3TI+b/ve771mIRTXn4UDWJNKPcI6ny3F/7+8YHEDZIiqzx+VZN+7YJUKetjvrB7UBynh0d3W8knvtAoDHraCaPS/8Q/6T9x7S//ZuZVUiDx+yhJvKiCLjxnY+LYPx/xCTu1fcQRD3SWnjt/hzMSVrkvcy4X7IT861DhAmQh3/V3/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 14:13:47 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 14:13:46 +0000
Date: Mon, 29 Sep 2025 14:13:36 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	tariqt@nvidia.com, moshe@nvidia.com, kshk@linux.ibm.com, 
	virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Fix incorrect error code reporting in
 query_virtqueues
Message-ID: <sdv7e77s7v2hqjkedvhxy4zbwriqu7z6kstfqfnitst4c7yrdv@xcskbqzsf6dl>
References: <20250929134258.80956-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929134258.80956-1-alok.a.tiwari@oracle.com>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: f8197002-5463-4114-2686-08ddff626797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqVgrY+hRFQ6gpRuqjNbTn2WS7DvNfeqE2h6WHnTrbzqnmcR9M6XGNbJs1Ut?=
 =?us-ascii?Q?dcCW/bWT6UqjkjVH1nugjPx5RUAIEvHL7dxcMmdl7Xq9jdcOHp/7KQqXo7fp?=
 =?us-ascii?Q?mxW1MNC3BNuftTtZNGrQQq3itbXKPqiK4jYgzJ+U4P/n/Hy8yOsaC+EEtiGQ?=
 =?us-ascii?Q?Xqlty4xE/eTGeGCNBRUAUY3Tn1asy7Jru/Q+nG25rSFoLvK1GwsakpraUiD3?=
 =?us-ascii?Q?eam8/+CA3NeHy5Io/9C9MGeLBcLsb1TYR/ovxyswdZdUzehlMfsXQPkGhpPX?=
 =?us-ascii?Q?ZOFO9fJcJOIS2sHd6FOs7Y21B8swyyXAVc2GFaRZ07yPSgaYOM6ZCSuAgspx?=
 =?us-ascii?Q?BkBQBFKp93hwux0rYAfdSAIsC8Iw+e3J7Iu1wj2M1isPi7lCOOo5PHUAE63a?=
 =?us-ascii?Q?QctOp/MBXMlsHk2FEzbfSM4Nx6M+wd9C3owuCnh48dl2w3FS4KWyBtZDF4Pp?=
 =?us-ascii?Q?6lhgxv+PB7tubDTWshG3DkuatTGjy6Bjt0+OIHfS7jJGQJnE0fuaHgIEL2js?=
 =?us-ascii?Q?2QQ/JCsXt7icUTC7z03V9ssqh/HMEZizWrzPUOFtMLtjpKZbC0bW+J5/ga1n?=
 =?us-ascii?Q?KVPB4gBYROsWe5EGMd8Z9UGTEXZb9Rdxgml8/ZspLK4HppUuBqYyAGJ5ujDg?=
 =?us-ascii?Q?VSNiEgZ2YKAQCqRPczYEIMgRGfXpPpxHXB40OlIGhcI2s9xKDKCYLSAPkePQ?=
 =?us-ascii?Q?bYz5xKbb6FW6ZJ62Jk5PzbSDZFK4htbp+40lx23KMhcQD/zOBi/joHKaTtQr?=
 =?us-ascii?Q?/CNIKwm/W13/gwaZBVVKgEB2ZJm6nUwNq5yFfN8FJDkSI5NtC42DQna5kcPK?=
 =?us-ascii?Q?mCL72Wga1XEHMuP931WItK9Hmy5jP5XPsp38rZuZyFeltG3vuGLjpVrDvWRd?=
 =?us-ascii?Q?4CwLrT0p5oG6JPoNgVNBJMP6F0/FdYeXV6gHqtyL6TTcbA25/s+B5xsL4xKi?=
 =?us-ascii?Q?G/WcqJr6fzGIMMJ877o5HViymSVyXQ7gbK1YKa99xQCTlSiSmSshAUamBI3T?=
 =?us-ascii?Q?Ekqo6awxuD1f33W8KzpzoUG8FQB+SoXxj8+wSzbrAem+feK5uGW9VbCcneCq?=
 =?us-ascii?Q?vP9eII/AAlzOKSDhNw6cDlBVa9RmlZVW9igD8g+zFN/tB63xaAGNcK8rvlcn?=
 =?us-ascii?Q?+s8tC6+HPcmSLczE5tiJJjnLcY/OLrYtWWsimib2HMnouSi+KclH/f1J29bA?=
 =?us-ascii?Q?9+Vpm4nJ9W1lmFXuiQvo2PRyDN/Ld2LdfkwAIyyh8YUekZYf6NMzOO+/Y6AW?=
 =?us-ascii?Q?KDaZKP//4naJNK48sAEbLPDZw92z7YvpS8am/j9XtD+Lte6MKMcU1BBj3ieL?=
 =?us-ascii?Q?t5joiyylh8euzPHzVuokzgAa2v9RnO58pDJrD/a4lH2afuD5hbDtTaByHaNI?=
 =?us-ascii?Q?0P1Z37OFbPzEU8x35xlwWdGzmUKAYMUawMUZfMXUfbw8/9bjhr30QwJ/8Yf3?=
 =?us-ascii?Q?hz+01ip+gUDOgiYKF8g/JzvYYLlw3ENL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gR4z5mFLJbP/6kSVFXbxa2ytN2S6BJUp6L9HN6XvkdPX067aV9GUpkfYwn6Y?=
 =?us-ascii?Q?1TA4TvERDrzWwdhdrxx+lYxyTclVhM77tFlGD1qlA5WDM2i9SpyliVa639bC?=
 =?us-ascii?Q?cXQbf/jHgJEUk0I1D14oGQM3r4iNcVuCWaU7AYB27elNQCgIzK77b953+kih?=
 =?us-ascii?Q?5VMQQQQtijcs9TPpR1TO44RzXS2je5pQdFnHD4j7M4La8Y0A2r9iS6TFxaT2?=
 =?us-ascii?Q?xseU47wWpOCfdMr9xJgszYH3AAhZIPHlIAbPxlkReV4cIdSIW1bHjd9dJjI0?=
 =?us-ascii?Q?XsGn2KPDwBvliZ7r6q3K+2Ht+L3FYgordpLyRtybRJrdQ4HimeocD0BLHk/s?=
 =?us-ascii?Q?uuaafQPb15CxynbVU7I4WVMno2ZNmjS55EwM8VXlWoTPy50xODvYFaCsf9Zy?=
 =?us-ascii?Q?+FZEq0S3DPGuLrY3zC3bBGlDbZmC89wi/YHgr+FRF3ICw3uwwgVLV03qjZBL?=
 =?us-ascii?Q?hp658zhdYTQGyXvF7l7wBUsUqRF1+YZqoqXnMx3ReJ7/Kyfjc1MKJT8+fxKG?=
 =?us-ascii?Q?uhOd3TZ19gjBx7U35WcYm3nNIGgkJN/7q8WukFuSPblmIrkbgrMwzr3q8jQF?=
 =?us-ascii?Q?alQ3i8CveYi02GaQWSAMgsP/KsbqnJ14ZUbYGjP5pXPjNDT/4ja51jooxoJT?=
 =?us-ascii?Q?3yLB8LUXNwoUJQsCLOXEGZ40kyRaytD+q7r0H9WJIuByCvXhWHWnmm8W+ONA?=
 =?us-ascii?Q?v4dvagthbPWdUSl5cGgPp0FTIAsZ7tNmMK86HsyBlm1gN/cxRd4/xEzvZH8N?=
 =?us-ascii?Q?wlNHdIfenQJMsYy1PJFIP3ZYY1imABNUQ1p+KkMgCgZvrdvIkB9kwkZW3D8Z?=
 =?us-ascii?Q?VMzq0xpgcpNWE0MwlJjU839Sr8UgNB+PezFpqrt1P/RyVdrD5G/+LYJzwh8m?=
 =?us-ascii?Q?BtUxP/U5P/XU3NG6QlTzTJRLLk8NojUvwXoyO/sFvUomgx9AKe4KYDU98h3x?=
 =?us-ascii?Q?QAEcUo09XjyPf9xQNSg1ZWLrafa9B2MRInEBI7OtRCB2b2GqMMju1rYFw5E6?=
 =?us-ascii?Q?cyEtdeN/P5hlBB30B0Mq1IUzq8h2KIbZy1UwfT+AIWqrhKaw/awpGAJpY1z9?=
 =?us-ascii?Q?8gKcxdOdu4FQhXpLvJAHu+HcQMT4nZ/51l2O2Az6BueGwgeVBzqXBwLOTR/D?=
 =?us-ascii?Q?vi8KcHffMWTqThvs34JM/DBtpL98eKOFDTm6Mk8XWFWIxd29kXbc/RdLTr9z?=
 =?us-ascii?Q?AuKdmC7YvKddWVBX7VYHiYvswEh2GyjyY/6Z2Bg4jbdsT2wxWfhAgVdlgwXF?=
 =?us-ascii?Q?RlVZwYFS0vFlv77eLSQjNSuZV/Y7REZG5G+1eNKpBIZWLCMe3xu03Kk/jAeN?=
 =?us-ascii?Q?oU4MvQSZ76+GxvGLoarlYWghKliVIxEkqo2z8Fo+K3K6GziTfa/Tq/lqXm0s?=
 =?us-ascii?Q?0qSKNnq3MAkHve96upMKSMtYZjD59a6USDZ1UbqCvlVa3mAIa0CE10/fnDIz?=
 =?us-ascii?Q?1b75/ZgzqiiXKTcWc+cJHbXz847+fsy1jUvozgOdYwS47ylKjPXJGrVrI4C0?=
 =?us-ascii?Q?EVJ1X+eE5hJcITFGIIwmoSfPyyqutpSJ9E8kOSu0huGkrMjN6gkrjynDUc1k?=
 =?us-ascii?Q?8Ny5j4JpqUC3g4xHuPnbn3l2bjCcjVHQxkz66GzV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8197002-5463-4114-2686-08ddff626797
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 14:13:46.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FKzXQdq7YLR+5pTebUTHDyHGSMmfPBltMCcO4ORbml1MQTjCSaVPpPEh8Tucx9JO8Unss4T99giDH3YgBDESw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

On Mon, Sep 29, 2025 at 06:42:53AM -0700, Alok Tiwari wrote:
> When query_virtqueues() fails, the error log prints the variable err
> instead of cmd->err. Since err may still be zero at this point, the
> log message can misleadingly report a success value 0 even though the
> command actually failed.
> 
> Even worse, once err is set to the first failure, subsequent logs
> print that same stale value. This makes the error reporting appear
> one step behind the actual failing queue index, which is confusing
> and misleading.
> 
> Fix the log to report cmd->err, which reflects the real failure code
> returned by the firmware.
>
> Fixes: 1fcdf43ea69e ("vdpa/mlx5: Use async API for vq query command")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Thanks for catching and fixing this Alok. The patch is straightforward
and it looks good to me:

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos
