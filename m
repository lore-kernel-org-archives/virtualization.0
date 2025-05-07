Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011004.outbound.protection.outlook.com [40.107.74.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913701CCB4B
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593984; cv=fail; b=re3kon8xw+nJKeqPdcl1pGTi54cnyNciVPrq1SpAWhDfJQagjIX/yvJuqOWEIvkaUAl8vn/VqpaxlT1rZXFAvtMfXFZkHYFuMjgvOY9I3YPJpTp9pK9EgLwrzlPAEjW+ItKdCmtgcYO2KWv+6dkDIRhnDOd6nJZRaERAEPlbxfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593984; c=relaxed/simple;
	bh=ayoDRf6Z1Gt1BCtPCpVxfPALxsA4vXs4bkxFt5Hdhto=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=W7Gye2MHrpas+pbZEkYVho+yrAPyFvvB0m004ACFY5CYZWqp13EnjZQeVBTV5rZqAPzudzfaD4fAfQaUrQXvp262cqdi5fJghmoaRrEw1x8SHsHzLA/KWWN9UT79WzW+CJ+rd9206Eg4I3DOP2JsiQLp4bjs/yzP4e/JGYvdX6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=oquO2ja0; arc=fail smtp.client-ip=40.107.74.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="oquO2ja0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1DY85LM+8o7M+XAkPSw4p+z8rZai/86ruy4PYCSpUtzF6LbqmOEV3VPyORGrgkdLrErMGahR0DAUhvkT+DCc5A8BN2dSUUhjUMXniTAfJYqec/uj5mfEUx3GzoXCt9ZNST06OLJXEyPqsQBa8yKYuspndkNhGHeVELkm7KLQXaCERaOFhTJpqINCvd5XkAJTsuM2UftjgeRgDZRhUlrz0SWMGoAwkgm8NbLKjPpL8BF2CKVSqeKz4n0Fxb/YIyYbnNfABBIXJZLdnsjzgqbNuUauM6PSVwxl439lkgpzQA5LAhvbU4ZRRZnhV/xYyjiyeGKG4u6wJAFXlLWqwLOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzYE+ejJ6rwVF6hUnXYWpj2hQiELuyp1K5OeQaU7QJg=;
 b=wD6Pp39Xd4bcimwVahUEaXXAweZAX9hJMMEBCIKDx6fYZwfcTweK7LJ4O7NmeajhJeBVHuVYH7HYUkcS75wvT6c/wCkpV6W7l0b0QnmovIZo8c3BZ855HMGNZIGRdwQVWupHjXo9m7d871dtWgtHMlH1PZhPaKSyWhzM2KnwEQmctPteEp4U4Qn3QYNc3PzutJSHzGIiMsXm12OZULowPe8vE9MKhxjc8Xg0Q+ugw3cPBk9N9o6hOu5uIie+vDDdmFQpJUrvtHpR+7IGfBBRX1+1Ts4ueb8KMSvT7vG7q3kH4E6fH+VJamaEq4wn919lRJkirI4DKuOU5X6uY06kHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzYE+ejJ6rwVF6hUnXYWpj2hQiELuyp1K5OeQaU7QJg=;
 b=oquO2ja0JnLpsmD3U2fAbqNlnpUmMAnnzIXzx9mndQ5HFXAYU2sOOqm7I68+drcIOpA/PBearfJbUHtnU/IXXdOhogB5hDOyfb0dRJ2QOCYLeEJnLsJQMs74Nvxg/0h07+1wTi8EJHhE8Eh8ZzpCe8kzRbIDFMzFzFRgr7YXmGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 04:59:40 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:59:40 +0000
Message-ID: <87r011audg.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 04/12] ALSA: virtio: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 04:59:39 +0000
X-ClientProxiedBy: TYCP286CA0202.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::10) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c7fb26-f3d8-4c4c-48b6-08dd8d23f911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSZ6i/H8D6jfE/GLVjVatMDHusFBxPp6o2cDvvqO224wwNLGfFLTGFyEhUB3?=
 =?us-ascii?Q?6o1rejspEUWIAHHI+dmbFOl/UpG4LeHrQejEpW36rVFwheYC/+4YwbqTiioh?=
 =?us-ascii?Q?wdp5BMUplQGZGBCsieeptowQ7zI1dzh4NYrl7bnviAa2CVY7VCH+WW/l024q?=
 =?us-ascii?Q?ZA0FqA/PIm/p6lSVEaWnZzWXuAHRDm23a1MSz3Yqft8mIgdvnfy2eYoziRyS?=
 =?us-ascii?Q?u10mx9vOJPB0WO57Z/rtWE7sxJixosJlPIVEcmxVCnJpZ/Z1t/7CrbiMcQaN?=
 =?us-ascii?Q?l5R2mtVi5Fu9kjPN6ZifldZATygwSOr3gSw8hJd71rlIrYipVKUmXURCA7qd?=
 =?us-ascii?Q?I9nz86fzShfg28lZA4TYYwnoUFClAu7gnnEFEq7SxWuMuYb5VLhiMrI+9uOr?=
 =?us-ascii?Q?0EeLQmw3ETHqjbnmge0IBIGAGsxqIQwbx7Jz8l3gxHi9mRBS7MuuLtrMFJ9N?=
 =?us-ascii?Q?gknr2pXeLmixzSYt1PkqfI3PZquxZQMU6Lejzc9O2DmAHnlD2543dIVJBti0?=
 =?us-ascii?Q?26C65QuU8XEgQ8tEVJelcuiV84vr8J8AF3DEO3jy1MBzcsH5bTl322MIW75u?=
 =?us-ascii?Q?Ajyr8sEh7ka9Rg7AoWEBqSr50q82dEmLZb6sQYqg16qau4ABPH1VKcLceI+n?=
 =?us-ascii?Q?b8njkZMDnHPtr5oug8317ljBcz6iFDCCx59W6UZqlfl/nbRglxJWVttEQD4g?=
 =?us-ascii?Q?/iW/oHNzTvOx/hdcSNlaeHDe4x4yYKLId0BRNR4oHmWaVWDDl7PkxrqgYkSP?=
 =?us-ascii?Q?VkdbS3nqKphtfUrVh9X7agZKcXGhsbPG9voec3xraNPg6R7xkHNYOGco6H5J?=
 =?us-ascii?Q?tp96Us/SK8ZluxgDR/4CpR9lDv9WAFHOooHFmccAkCdX8UM8QKWegqJwIY4b?=
 =?us-ascii?Q?fIfz5SjrE+XJCqq1VyetWT14AkDFNo8HZC1yhxl30VYZDYBvBrzMW2l1Esb0?=
 =?us-ascii?Q?YhGBcceDX9cfpiwYHTeJ6e6lL756IOwfgihms6idMRmaujrbrvfGh29h+x4+?=
 =?us-ascii?Q?ofaewcwu1s38KcMVzOXsie6dDtitDdLHXoze8CZCfY5oH9VIvLiJgiQ+rdLN?=
 =?us-ascii?Q?1Ga/CrROz3uO0tPdLimovd1D8zxonRoPrf5RSKDHFxImsNWapipeXgFKDlAz?=
 =?us-ascii?Q?xa9m++HqXL61oFNrdr9/Cp19svZHXZ6FD9ctbwjfsNRNOMSWJqL/vFIuV2Re?=
 =?us-ascii?Q?tGBpqR7IvD++Crk245sKVAVAohVaD/pZKtWGAqQS9YQHiRHwNy46e9Wo5F6L?=
 =?us-ascii?Q?EsjZKa6D27WpVhnvug4ibfllhX8AVYCQt47qTQsW3AHD2YxOAnGRlHD9LJuo?=
 =?us-ascii?Q?CuiOrVvmLU8/X5SA+kJMAoyincxph7Oi6KGldmfC9is+0qt2y/R67ZM9tf5Y?=
 =?us-ascii?Q?azU4hfBvjcD6QP7XDhmxqKoJZCYegaMdBkoca7Jmi3Ks6mrhw2plsnYzS2bo?=
 =?us-ascii?Q?T1XULfnepPUeQAG5eRUYilh1E60Mz+VtBdtQoO1MsCYdIcj0MkSsig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R6OhSdBC18zQA73feMuh6Z/JuCEdBhuldCemszrRIiyU8aCzoRGQ3XXGsAXn?=
 =?us-ascii?Q?AcRosFTvEMrUKKGF0VRMLnUCSFuC+FqQvcaJ1bDUtIzma3/FmADfowUfjmjK?=
 =?us-ascii?Q?+suCi+yyMzzGGlQmnZstSu6P5R1Arr7hJiBSmoXn5xSnKp3WSc3kbIn7wxM8?=
 =?us-ascii?Q?VhmGNC9/6pVKij0NkbqqNhcx7isZbSCyH4lVHpSCDQSepDcAnNf+4I8H8FKO?=
 =?us-ascii?Q?MBo/eCWz9wZKKB/cGMi9Fb6HLR1PJdw6e6p7ABcLJkXBGrZZOPKgef2oyeNj?=
 =?us-ascii?Q?8CGLXZzndNdI7CSJBrP/Au5fqSOF0yuYKBo9OOFBEjLAOxHQ0FBhTOuIeA5Z?=
 =?us-ascii?Q?IQe5bbVT2z47/+Uzgf1da98KjfQES4YXpPfSfEk8sW0/jTW9IYzDhYq2Z6jb?=
 =?us-ascii?Q?tQ42pwhssmRTSrpN6gnW0uNZChWqkr27R2qbTGbzYcrNm9HejNS4sdQO0rrS?=
 =?us-ascii?Q?npbo+nbUeBWga+GS306+Vgoduk/pz/Zthu12/KPM9OHodI4xD031AjjOhF+B?=
 =?us-ascii?Q?um4jzBeklwWfrZ4mcRzXmNvlbgSXBUp2Ddi9lnHPkq7EdMpfFNYTDTVCmAkp?=
 =?us-ascii?Q?Hg8vAtH+aPsoaV+Bvd5CuHjJB7TOhaGaLPyDKvL1c0C9SUmp6G+Vaa0IEpkl?=
 =?us-ascii?Q?7GCJ0hbghymzId4i9GakuJxd30qizfYk6Dy0ew0nVWYKutw0n+ye9a+Bc9L8?=
 =?us-ascii?Q?QPLrtsl1cCBn+Oh3EJQ9+dX710/3k02qi1m5VQiarX/Ola0bSCPbsPpnP/Uq?=
 =?us-ascii?Q?GbsTFciqq+tCv9naw76QvgencHsBdLitKz9jN7n3aKE3tNwUSRRkjfUACn75?=
 =?us-ascii?Q?42v3EFUNtt0MFPYKqtaiWbK82yD1gpNWLuX8dctHKdwsQKiuVEctEXwqUTbD?=
 =?us-ascii?Q?XdqHM51ThQG5w2u3UCcVuzD9TSjoAO67vMbMBntLXQKxfPPUJ+XyZ9o16Tzd?=
 =?us-ascii?Q?wt0mlbf1KDmKTqKQhBrUCA9Un34Hc83TxHA4mNWpIlhA5/Zb+dwHpa8zOyxT?=
 =?us-ascii?Q?tOznycm36AFMU3vmzoSs4dI+EogDNLf07DGeFOalfmdlvBhXFblJcaI2lwcs?=
 =?us-ascii?Q?cLQzWcl1pzQXk855dAYDhQbHv3mkwlTojFrtqqEAHfhj3vcqc9u8ctCYB96O?=
 =?us-ascii?Q?Ca9G9Wg6Q3sjDa+Sfm7mjBF/RXyCSvLPwIBT/AR03Vn2mHvxoDhX+kpPVGsa?=
 =?us-ascii?Q?bTRicMOcn1mBx3VVXL5Zq6SYAzuWkjk5z/aJI0J4OUimpPPR3v8PrZlVPK3U?=
 =?us-ascii?Q?UVchmEe6AVk0ocX2z0HofkVjdAgGG7hEbEogGwR5B2V7EN48bQ3I2VHhhS69?=
 =?us-ascii?Q?B8QWfQ7J0E8/ocPf/4FrwXK6r3W7Bj5V+DZIpx1TUamOhLUMmdf8wCgPZ1OA?=
 =?us-ascii?Q?5ON6v+7xb/gk8JeJqK0eUOTdToZxMmXcIpEETtR5aOoBgHz6g/kxkr4xZxX9?=
 =?us-ascii?Q?ViWwJ5JhEKLYflQq7CdkaOeD2+ig4rTR/TKMO4nTwuoJJp6A2vp0pP1n+ajP?=
 =?us-ascii?Q?O2H7SQI7vWUkooBSiVjBSdcaWLUXfGJG1QBc31Tsw+C25G1DF9aOD5tFA3Ha?=
 =?us-ascii?Q?CijjSYx3jrlCCbqXDdDZh5axvM/Bu1LpuDZQm/ZzUjQAi0dru+Lm/IkX0kLp?=
 =?us-ascii?Q?bg0fAm/9sKxosbgZUp5EkWY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c7fb26-f3d8-4c4c-48b6-08dd8d23f911
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:59:40.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLUysAXPlMyZ48BrWnuhOQv/00o7ciDohsL1olDtT4KkPcQIcBDBXjlUYYKo5naxh/rHxID6Zpl32GotBYcLcY+y6UKXpmhrfokuqFdaV3BJg4zAKob8WPELbMhsxjr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/virtio/virtio_kctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
index 7aa79c05b4648..ffb903d56297a 100644
--- a/sound/virtio/virtio_kctl.c
+++ b/sound/virtio/virtio_kctl.c
@@ -47,7 +47,7 @@ static const unsigned int g_v2a_mask_map[] = {
 static int virtsnd_kctl_info(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_info *uinfo)
 {
-	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd *snd = snd_kcontrol_chip(kcontrol);
 	struct virtio_kctl *kctl = &snd->kctls[kcontrol->private_value];
 	struct virtio_snd_ctl_info *kinfo =
 		&snd->kctl_infos[kcontrol->private_value];
@@ -102,7 +102,7 @@ static int virtsnd_kctl_info(struct snd_kcontrol *kcontrol,
 static int virtsnd_kctl_get(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *uvalue)
 {
-	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd *snd = snd_kcontrol_chip(kcontrol);
 	struct virtio_snd_ctl_info *kinfo =
 		&snd->kctl_infos[kcontrol->private_value];
 	unsigned int type = le32_to_cpu(kinfo->type);
@@ -175,7 +175,7 @@ static int virtsnd_kctl_get(struct snd_kcontrol *kcontrol,
 static int virtsnd_kctl_put(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *uvalue)
 {
-	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd *snd = snd_kcontrol_chip(kcontrol);
 	struct virtio_snd_ctl_info *kinfo =
 		&snd->kctl_infos[kcontrol->private_value];
 	unsigned int type = le32_to_cpu(kinfo->type);
@@ -239,7 +239,7 @@ static int virtsnd_kctl_put(struct snd_kcontrol *kcontrol,
 static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
 			       unsigned int size, unsigned int __user *utlv)
 {
-	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd *snd = snd_kcontrol_chip(kcontrol);
 	struct virtio_snd_msg *msg;
 	struct virtio_snd_ctl_hdr *hdr;
 	unsigned int *tlv;
-- 
2.43.0

