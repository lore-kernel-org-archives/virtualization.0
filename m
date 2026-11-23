Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.84.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795428397;
	b=cHltqYH9gT8vNZ8418hRURG4fgD5+jJPi7XPMmz/nWjPJiI41+ABdRM2OmI1Mmu1uNaZ
	 YzL+zuDsf546fNd77t7tZhNMjEbX6URYT7SUAV/aJNqavBxDdCLE5G9BA8vWIKByWpvyq
	 /7PHgnFUdtdag/W5Rmi6VLkUL1EEwiGZikCXp7r/scOj6XJylQ+hFTpnKwNLSJohDq4Dj
	 5BqLmb0PzYqFhWCffGMqOk+fcfBZTpPBPaRMyFN5F4RwqnmfQ8goRnoMSpwNRr/Rl93C8
	 fRkXuo58+B0Fach4Thmcga9cAb3ghs1D6lVc/49QDtizQ8827KG80DKaFnrQZz6y7ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428397;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=ngbCwrPlSU5yHBrNi6O8zqRnT+UWvb2j37Hfz0CdZRU=;
	b=BiMx9krdB+akUYL6LWRMHg/kY5huzcHRq36m9XbFzucqHvc8I246d5q7vm88Hw72l4lE
	 qx/vJoxThid3NGUrn8jRkPVNWDatHKyzG6GheYV6g9cTGoSLcrApABY74VwyIYQ/yLJ7E
	 +xTN65CMvNN0nnL5RGDNgYRQEbGKyssrNwkODTcNGIwtPQiFqkbNHWmF3TsKoaXZmu8p4
	 TCp9h5YBM/dKYWSpt1KzyGpMgpkQhNnBMahmRQCuN7z30lD1so/r2lihsXn/obfU1A+kK
	 yAqRNI7cq1bTb7+MDR8emSIzGfp8wbW1RqPDyPewDAaKzSAv3TyO/F0kRRFaXDo4SxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=fail reason="signature verification failed" header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=efb843yh;
	arc=fail smtp.remote-ip=52.101.84.59
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA6606A31E
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 10:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EBA6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=efb843yh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ3ldnoIS9H+ek+AnM2g/JIVAYhCfjVjYswQi7gECM5RwQmGf5NiFO3e5oxsEd+HFCQXIdXZBNo6/Axwj9RGJxvbrWDF8+k3s3M6IQ6ED+cG2hGmEcS3eSztOMAgObzXXgtjGv26T5/BNa8Oam4jr3X2x9NEvh7hEPaz+Ef+jq4zX9ZicWuk3dJLrXdl34ag0VFQnmWJumYeLR4nljpWpGtXFkK7xF5ilFBmuzgKGrf6zHEe/J0xBQ0WK+nyVHHDq4GK6ZR+UF1mvx8JodnBWor55XUT3Ht6NQtuWv8IS7vreXnKNZtoNWYa655nw8t0Dm3hhVqNYuE5L6BfjB9VTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZxyAdPymmiT7lXa6V/TDNtHVMHpoH9QRpReAXv0gs8=;
 b=wDQ84zOLlab4b5PNVcs2WIatB9j4YhS4wUmJA2JvQTtCGcxONU0zB99PyNXSs92Ucl+37O17osqdB5sde5Hy4qsXc7oy+y2YZgISV5Igi9BTWU2A3OYPOT5azjL7j0cXCS3wiZnMfW3NDmblZ8Y6EukUhZ55DN6fZozP/r+NfjAdJBrvitY1d96yjF710ArLG62JJndja1nl7JxEbu9QXtFEmsjh/uIRx414jRdeK8M+/NBjWqlpAg57BXbfsDNRttzSthoE7M6z0N4vnH8XjvV+apaeG1QxKBKg9Q1zNGCYQfPp02IvFqFES+r/8PdGJpfQfUHapyAEy3qsMRORSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZxyAdPymmiT7lXa6V/TDNtHVMHpoH9QRpReAXv0gs8=;
 b=efb843yhX/R7X1CcxGphD2Ik8NSjt+WvcvnHjBl8J7c20v0MpcN2s0Z4rrjTYHD0US/xto8viBxg2Q6C6ym9FakPs+6t35OrLzY8OqboHGQ9RZEE/3nxj+qr4gozDNdND9YgLuChraaMm22JiV/8HeCG7le5i+SPmQnK07XdcJLvFOi9YuVMANFs4whMrIoUnXCxsnWpiSvJlmD2xvrCJCTGcdoiU0owLghvC4rdz3N2TLVmM+s1rw/DEaR5agawgZvLzVXicyMjMgNZPnT+J1kk8MsN3U3SW3MMRvs2rJKjEXsvt1mXg/sLn43G2waN7owECSE7USkGc1KAqQB6Qw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by BR0PR04MB476426.eurprd04.prod.outlook.com
 (2603:10a6:2c8:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 10:06:34 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:06:34 +0000
Date: Mon, 23 Nov 2026 12:06:29 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	Longfang Liu <liulongfang@huawei.com>, Julian Ruess <julianr@linux.ibm.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Brett Creeley <brett.creeley@amd.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Mostafa Saleh <smostafa@google.com>, kvm@vger.kernel.org, qat-linux@intel.com, 
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v2 03/10] vfio: Allow untainted use of driver_override
Message-ID: <iytvxymdedz4vsgdswfo5zd72anc6twtbhs7ynz7iidgrbmjk2@yle7e32l444c>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com>
X-ClientProxiedBy: AS4P190CA0068.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::28) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
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
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|BR0PR04MB476426:EE_
X-MS-Office365-Filtering-Correlation-Id: 9889fbb4-8f40-41f2-002c-08df4949743f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|3023799007|11063799006|56012099006|4143699003|261028144727099003|261022075727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BBQDu/8coYpr1+arXFTIaefkO3lDhreFwavH0e8ValelqiPtxz3Hz8moKLgMxoZo/BnMXXidol1t3sWPSGIIz0CN1hoWcl+S5TOFB2d3pDrjHFR1EwjfcNRmVz+qVisyIOfdGT2ilPsYNVLWKEtELGpUI6VnRqZqg8GdnbV9G292rtj4Sb8FXmbHwOhLZ+1lnn3mmeTkShh3mTtk6Xyn/BCuBixspsZtwFTihK+SJQG+bOLMEbJzpQLrexVnNWKQxl5/rOT6UqpI3IAF+ly4ayQfMoTREBoE+Usjw8ADBBW2Xs9dQ+BcbXIkK9mPS2dbqXhnQRH2tf+YMoLDwdWatRc2qyjNdwmzWVawpN4/8a2xkOlUKNiEDchffpl3sAVLbFqw/G28sSok5cO0gfkzpgjLQD02fpw/XA1J17LsxOu7beZeOriuSvMpqS8XJNCTcP4Hf48/R8MsCRPVUl3hE8bwpFhIg3aM67HrcMz6NCrmQSaWCyNSyQE9VhWXHgogLkG2z24Anc+DdEKQL8EaZfOfKLWJrDHaHmCavFwqBiXxIdv/pwd5gorVqFVAaJEoDB2332RfwRiw1hIqGTsmlwevJa8f6PMi653RMfVF4PSE72ZqS+x6LHUKMoZJ0XdZq9LPRWiFOFfGEk4CMazSJ6PfLutw5CAxZZ/Y4NaHQyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(4143699003)(261028144727099003)(261022075727099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?e9Gyr+k8hrnZ15gRoI+fIFM2qg2sDtPzypu1mqgf6J61TXVfJCSiv4YrjZ?=
 =?iso-8859-1?Q?+7xg6hTXXgRMPM92SOpdMwpPjcqsjlMshWp0jR0jVUIPajsn8c2Xl8D8/l?=
 =?iso-8859-1?Q?Ny70SRCo3tCrFyLlVbGmff4TFN7R5pBaxtdxmkgRr70LwUKBNQ7H170YiF?=
 =?iso-8859-1?Q?CYWzbOJtipwbs+dX0OKEjP01fVvWJ6y74bBYrMWL+GyxzVKTfrS/79Htt8?=
 =?iso-8859-1?Q?0H/f2PR2GVR03Q+Rn4QuRwG/Zjkd0NV5WMSjduwqS7HFcqyRRKBFtOcPjW?=
 =?iso-8859-1?Q?OaKrUpe4tHM/J5EBJLyx/d27eSQwX0lVtxhRbSH08xVxrRRbFbQVde1367?=
 =?iso-8859-1?Q?Dnjc7kOt+fX177XupKzLHCs81e39GKhA0ovjdjyZSd8eUqAIBX4sLoQEYG?=
 =?iso-8859-1?Q?Fc8KGSMtLnIQiA5g7LsE0SG7Rdy4ATEqwfLaovY+Y9E8oSvDkknslqmU4K?=
 =?iso-8859-1?Q?DopYzYEjQpfMCIp5fH0z1c+8I2pGnTJRgo16t21XKW+8yEeC1pfKzsclGt?=
 =?iso-8859-1?Q?VAQ6Ye3yxPQF02qVfIvJSzUafPrFeK3n7ms7HvtpRi0d3e3UyN1bHUW2/k?=
 =?iso-8859-1?Q?S/YL8OXWWvjv9RpLCYZe9kuN/N3RIZcVAkR358Rj/J3CJ3cVcCFzaWmODV?=
 =?iso-8859-1?Q?iZ7Vk0I6ztWYDg2fGaQDHmfP1FO9qPGA2HA+rTvjkH7gteUbzQlR7bsgUW?=
 =?iso-8859-1?Q?ypiVwU6Hm883E3nNOCMCUTdQ/DjsyIvI8CqLLtGQ4X+KJ0m/ExKilgn7EQ?=
 =?iso-8859-1?Q?jMg0MBcN+zSIF58aoqnZLmy3I0sNn6JfvYvkOXnJ3UZYGyGGHjzSIPkKXK?=
 =?iso-8859-1?Q?Q1fT8EV33vUtIqQs+V4WAH0Gsnc4buSaRhwvwZD8xMq+27+lZlsh3yiDp9?=
 =?iso-8859-1?Q?jbz5brwCxceRzrtK9gicER6QSuzWhh2niWMC+pVWo/TtvGN0lmJHM/7PMX?=
 =?iso-8859-1?Q?Y0XH8ZEgF8bbekG+dqE4ZcOOr7OQEscuEiTjwzkMDZmCNzwFCKEqCkvkX1?=
 =?iso-8859-1?Q?wbwLF2dSmHWljf0JJV5iRHIONjdnyrUVs82JRRvfoKp6aEKCYP0HitH5ee?=
 =?iso-8859-1?Q?IiTATI4SCThmHU0qA0HL9HDv3WRoYraEyuKZ3+ZQ+ONP7k5tpVw9w5Zj/5?=
 =?iso-8859-1?Q?SDQZ5C/bD3WP2N6/CUv5zwZW2jcdCNpPqTUkGpWoJb4qzgXiEP5PuiytXr?=
 =?iso-8859-1?Q?H2g8AB4tnsr4QkJK8tQ8zEaxBwxo8wFUlxRfYoDtub1Fhlmb3HifS4oXe4?=
 =?iso-8859-1?Q?TFNSoVv5oBeHlaSe+0MUBfphjy0ExZTv6FvsDbqcN1c/no0oNw4a0a38Sw?=
 =?iso-8859-1?Q?1IMptYmfyp5Qky0hHCUi/VfH2FamyeQgMHQUqG7wECuqAWSXPV1yQoWoUd?=
 =?iso-8859-1?Q?kcCLmS44lCTkPjTaokLzSLLOxg8Nn2XCyMBodOJsLlwIYmflAO+OH1eBA/?=
 =?iso-8859-1?Q?z+vy/Ya6iUZMTyh3i6HYyFy2QL1V0bQAexDAT7/wsGR58UxX7KUDkQLJgH?=
 =?iso-8859-1?Q?oE5dMhkHkksVPFSZVXxllASeVzY/d7gndJEN4sBcS3o/0R9narteCUyzV7?=
 =?iso-8859-1?Q?u7iNeb6G5XZl9lcfSXvaIg0EFfFbfNZQy/3yUN7YCbFkd5LjM+Odc6WHQ/?=
 =?iso-8859-1?Q?i0hVkoEd4y8Md2gRyHW6gm4uTwT/o59S3kXRz2+gcxqkE9vCs51u3v3XHb?=
 =?iso-8859-1?Q?j19mO0x8O4Hg9xWxqSQbPTDy2Q9skU0UcO/IGoyHw/rtAtdYvytY55EAdk?=
 =?iso-8859-1?Q?vr6c6ukhED+dWC8e34HW1VqBLrXItUiaUXY8DOaWAlH9lZXeHZWngvJCJW?=
 =?iso-8859-1?Q?SwLUFk1jFg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9889fbb4-8f40-41f2-002c-08df4949743f
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:06:34.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvXr1sv0c4zgA8rxOcYk8ULiWPA8fUAK/x+d8DqMXF9posPOXPmcH37qOVka1UYGEIfq1FxYHkwmgJAp7bo+Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB476426

On Fri, Nov 20, 2026 at 12:11:04PM +0100, Uwe Kleine-König wrote:
> From: Alex Williamson <alex@shazbot.org>
> 
> Driver overrides are the standard mechanism for binding vfio drivers
> to devices.  With the introduction of the support_driver_override flag
> in the core driver struct, it's now required for drivers to declare
> themselves as driver_override compatible, otherwise driver_override
> bindings will be denied or generate a kernel taint.
> 
> Set the support_driver_override flag on the driver struct across all
> vfio drivers.
> 
> Signed-off-by: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com> # for vfio-fsl-mc

