Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA652242D67
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 04:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003271; cv=fail; b=mGaZ2/rPxMrggwHYM0UCrQy9czFkIvAqfePDYBd5WxrScBY8R/FF4/uP/PXy+ZQlyC7MDfUyTn18P6eGYEwDcESkuQjZwpbmHMg4KlqTuAOKlbc415YrN4iPS9dPTwulmYy2tej1BXc7PiLl3ppReM09gPo34dJ257zatuL4Qek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003271; c=relaxed/simple;
	bh=fqb8VFEk1rUlwGZaz88tG72gaEWAH89HxcmB84Xo2x8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGlOHPa99I6BF8/ssHFTiKEDF2UDz/Snd1BT2tpah3lCKNF/sBwoNDf5bKQ2IBkLk5WXOXYfysBOJFO3UM6J5xcyll+UcF2DvPUNY8HxhWfHWFTzd1Fi8s/g8lwWfNPG14m3/cLwxz8jGr877CXAVgBcUBQdDCNqmPFlfy1N77Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hCe0C/L1; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hCe0C/L1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSFBODT6wKnICzCR6B4Ylmx8mVnRf1j9wL2l9nV1x1LHZA5uGgbj8elICyF5OACQbig9eHD047rDaSYE7OSRVQ10u2dXxlog2+lABbifAVsW/33xHTARurKBQH7/rWEv+GVuiuvZvlirSQAokpU7BkPpU6ChXM+C+okKThWfSQdRqRCQ13i2hS8Ns906fs0xinXgouz4nZ5QB12txN4ZfZt0x8FtUCDeQv5FOnul4h8lCqxHzeowzoyuNAs1ZIKWL2FXSfCPiUroPAnVPOZMtLIG2c6Z906qNmThQIDMPmwcYYy3+TvA+yD2fD1wU2L80/5Xfn2j3Jimza9M//8WVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUTb/1YISNoISVmhzVEmrBICGQHISyG3Urt6nALcB28=;
 b=QYTOWru5Kc9JoCbtIBF/vYtJByeAsDc4NKAs9lnYAeU1fdQqHdptOH5e/9IMqqMgo/ILfX3vLYzyWDgwm33lwloK1ZEpBrV+L1JTBevt/aIe0xTDbLmX+33flvO3d46mtSiyedBRDU+v2/16PHV4dWx1cVhBzeCprPuDM/6x2SHucYX4rH6LczC1u6GovQNgZjEB/HjSh9/xevAmr6KV6o5w9NUXTaEAR/oc69O5/s5cPHTrnh7y3hWokUEhckSwMaaeZ9OqmgOcRvSK3IRW5yZ2o19F6K2xHq8wf/MlyrHijpB8d+w6FpOCzBiIM3pPiTRoh2vONC2znHgWPbJqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUTb/1YISNoISVmhzVEmrBICGQHISyG3Urt6nALcB28=;
 b=hCe0C/L1g1WaiiebAoH5tBtiaqEReevElfpUDD3F5veSPrrvBvxP57tFNR8uffy+R0PUiby8xHXGBwpZi7KtOAfFdc0EDb8anWP4tAuMNj33QfZX6wy9SaWHG9O0/mXPKEEs18fcQJUI7nugYseatHGmGIxnvEaK9AuA98adzXgZrNRNPANSEjfsvt49xlZICtySazD6k/sZ9MMitf6wyKhFLkb0wQ1CF0+roifszGF7Q7ZVNCQIpiUJbTYJ7vlOSc0KZ/AjpOMgrAvc2EpTqv2/zYZ4O1kTzNx4zbypYfqlFHvcUKwsl2xFn3cSzPez3fGsUYUaRouEQwKtwtTggQ==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 04:27:46 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6%2]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 04:27:45 +0000
From: Parav Pandit <parav@nvidia.com>
To: weimin xiong <xiongwm2026@163.com>, "mst@redhat.com" <mst@redhat.com>
CC: "jasowangio@gmail.com" <jasowangio@gmail.com>, "david@redhat.com"
	<david@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, xiongweimin <xiongweimin@kylinos.cn>
Subject: RE: [PATCH] virtio_mem: fix typo in comment
Thread-Topic: [PATCH] virtio_mem: fix typo in comment
Thread-Index: AQHdE0BMu1KGNVw3D0C6Oxd9UkzXXLZsa48A
Date: Tue, 14 Jul 2026 04:27:45 +0000
Message-ID:
 <SJ0PR12MB6806262FB6F99ADA13EC127CDCF92@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <20260714032417.201353-1-xiongwm2026@163.com>
In-Reply-To: <20260714032417.201353-1-xiongwm2026@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|IA1PR12MB7520:EE_
x-ms-office365-filtering-correlation-id: e5ad4f02-6e7f-4c06-d601-08dee160411d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 CBffvCr5vrIWe7npqeYH9a2ZWt6VA4IjMk+6DZgn7IMa1U0V8RzLPHgsMOSNmLInG7nAim8M1QCMGbUPyntEtCZvPWshh5Tb9KrRKdXX4UQwIk+leankzXXy3My6g8BZ8SpxezAyxbcAo3nJz8wCgC8u1DK38lTyJflzsrm3c4FyeCoMSkBPH7oFaujBY7QWdrky+77ZaAcViajdDHeDbwfigHWAcc3fvoJzN2WBJZRvI6eUAXMi6hVrzkqb9Ni2vZXbBpPs6VfqEsW7DwlQ8PO62jjoWSu4y3HpYmCneZPNAFPxmeGheSP69FeSR8wISXH9+/p8AKM/0YjKNdK8FcM0W8taKYnWxbL2UnqIRkliZZ5ArKzDVxYOqtn3vx8wG/3AEXHBtK7+GyV9EMcKY3KDLVCchJlQuTfT/hQB5r4r28AnTahrAYBVnNqHJ4Ce1S7tKneaEqmegt83A/XN4riAZp+v+uTUWLFDIK7xH2MnWezjyvtN9apeIOVOMFEtDVmaZBpvZDBpi9T6kjXHh9H5aniW3lg3OvxqWXmg+Zbgi4EQMgGbOUxtvFhMN54s+lnekg0F2YyJerzK+j7Au2DVDtffdtIpYwxQ7pXdIwarEJAawIN7ykFB9jXN5dorPtVOLzwNk/p6zwOT8k6WpmVugDPWcwTBIgUTKtqvAVzP/mpPTl6eRbRd9cN+JnH0mN7jOuqO52etYwVwwk0ihl3xIiCvZvY664Q4KFuD+z0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WOMt0iqSFHVseDE5gu5TzDYCUuUJ/ZmjM/OFBwKTVmRq2ZJAOM6vL8aSe2Pd?=
 =?us-ascii?Q?HEYdKf3Z1ato4Dp5b1ouEeRDazlySRzyabLcPRFygvz/t7mRfihPrX7TZV75?=
 =?us-ascii?Q?jFfHnxnnLMc0luG0MROEFUXZQpC4qW0L8XbFe26TtUeooqm63iU2Vbnf2CsM?=
 =?us-ascii?Q?r4Wwurr1hqJ85wBqyYerpV6kOlObxv3aoYD0C6om8owBxx6qNGB2vyHXzCwi?=
 =?us-ascii?Q?hFuGnTI+ANXrm7GuzPTOw3ONqVIbOH/ul6MO0SuQvRmw08zrQqGwwvS5noUa?=
 =?us-ascii?Q?6zc1VdSnMEixGN+Qpf1Vf2YP00oSnAOi6IXl5lUvKjH125rMBssWqYl14431?=
 =?us-ascii?Q?I1I/ScRFzHI10C7kE6Od9GNbwJsuFIVxhBk/0tJR+yzG5grI2H7kluriUFjb?=
 =?us-ascii?Q?ZjN5f8JDlfTGRYYRuQxWQa758yBHH7zPJxRVTkRu+Z8TnT1NS032CCQTUERE?=
 =?us-ascii?Q?2Jq6uHD4qpKfQY9uFtF5cqTk9o5T7lDaVX/dvnu+agIDQ3pKvS7L3YoMHLjV?=
 =?us-ascii?Q?zYXFMEA++QNhBcSt3BLcMOLN+sqh0xV2aJeGC/E6v88cOebz2sgMJPX9y/92?=
 =?us-ascii?Q?1PR+nRAkRbsQq084A7hZwo5fL5iLldpTvrc/SqoWEwvZU5R1CmRZ1tq02Qfk?=
 =?us-ascii?Q?vci479qpNk/nkpA0kX4tqZUXPiufF0uNyc0YD0hAiLzy0t/SsGI+/w3JetJf?=
 =?us-ascii?Q?IkS2MyavyaBTVM/SHV6Ir+shJXKKU7r0W28zzF3cEbjDKQg6dz6/3GxnpdlD?=
 =?us-ascii?Q?+O+JKZIzluiJWORDiE20OJHna6+pxNjHBQARPHXmlzu2KCG3XooTrk8Az795?=
 =?us-ascii?Q?GteKTNlJvYXs5WjL3XCuZ6lJ9/J7SD7hESiJfDRJlQdFj3zDvi+YJy1GkWR3?=
 =?us-ascii?Q?MnIFQJYe1kXBm2uLvSd8PM/Z4qv3xS5D85URGzkZTIUgmxJGuKqFGH02/Rs9?=
 =?us-ascii?Q?T0Br803T9DElrXorpw3LTJWfuSyGDTey9jQDEp06bFMa5ZPkePmeyZ2LIoD6?=
 =?us-ascii?Q?Jf/n1KnivV3C2KRrvWHpdcPDL0+qU5bLb4nfDK2/bYBMUbabciEaCfIw53zT?=
 =?us-ascii?Q?yLdVY/jAm0J/AV8frFhmOlnnoZlRIiYhhRClU1cJNJBicKdO48ge3mAYlvqQ?=
 =?us-ascii?Q?TA9Q9okToW8XPFVXqtGowzDsbF3iUWsMWJJpyQ80/DfmmifXWowoWkRMVd3d?=
 =?us-ascii?Q?ahdgfmIikBabds1hvbh6f1IVswjsLstrNjcRX0KMWpstAAlE4T5Ibd8Jl516?=
 =?us-ascii?Q?v/fRJczDahzJhs4Phr3wjn2dg2/1+TJCTarM5+OtxGL7rZaHTetjOCpVyq2+?=
 =?us-ascii?Q?86RzLE0hIMJ/6/t7hlIgBMBg+WFaDHMzeE32wlDQPKuDbCXazdxGcjv/Q7lG?=
 =?us-ascii?Q?Sqi6JpvjfzLPMG2wRIqtPtQniq95vPPab921CgAOHefZ6pHTtPfqueqLfBkJ?=
 =?us-ascii?Q?OwBIjEQSmhmUEEDySiYVQ00Wk4+VOxnk9VjWHigkt8IsRMwPrrJbgXBgsWyE?=
 =?us-ascii?Q?72GO3btcdu2cO0ByFGJ9Y/34It/7wFlRQZODIO8TwyxAC+6v0YtHPvR3vxPs?=
 =?us-ascii?Q?IFKeLhco2jUzmU7DHlu92GACe+wS5yLOKV47shMN2TvRCn7bzNmeqL0a7Gen?=
 =?us-ascii?Q?M/90PiERbBHbCJANdMSF93FMgVfsfQSauJZzUMAiyjrEasmrlTiBgPDWrV66?=
 =?us-ascii?Q?NSmZWWHyao9YNr0HDDm2h/kIAlu8o6tnSCvQwlI25TFNAbsE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ad4f02-6e7f-4c06-d601-08dee160411d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 04:27:45.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAlliw3nrHPzTms1cSQltyzQmefNfu8N1mcFhDSw/xEzA1g6uy0A1hCPcselabun6zLv2vwmCQ+wevpldW+KVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520



> From: weimin xiong <xiongwm2026@163.com>
> Sent: 14 July 2026 08:54 AM
>=20
> [You don't often get email from xiongwm2026@163.com. Learn why this is im=
portant at
> https://aka.ms/LearnAboutSenderIdentification ]

>=20
> From: xiongweimin <xiongweimin@kylinos.cn>
>=20
> Correct "actipn" to "action".
>=20
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 11c441501..90d8ef0b9 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1080,7 +1080,7 @@ static int virtio_mem_memory_notifier_cb(struct not=
ifier_block *nb,
>                 atomic64_sub(size, &vm->offline_size);
>                 /*
>                  * Start adding more memory once we onlined half of our
> -                * threshold. Don't trigger if it's possibly due to our a=
ctipn
> +                * threshold. Don't trigger if it's possibly due to our a=
ction
>                  * (e.g., us adding memory which gets onlined immediately=
 from
>                  * the core).
>                  */
> --
> 2.43.0
>=20
>=20
> No virus found
>                 Checked by Hillstone Network AntiVirus
>=20

Reviewed-by: Parav Pandit <parav@nvidia.com>
