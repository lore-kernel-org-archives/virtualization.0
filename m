Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011071.outbound.protection.outlook.com [52.101.125.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A6D1DC997
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 04:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593970; cv=fail; b=j36G1dhB9jLWIlyPK8BF8+ECabsPX8towYv5M/ES2ijTf6abSuTs0Je5L2+YMycUdVtv0kVml7Ueo7SPaq/KTMwhe/jalg88k5+iWWYuRQ3qZ3Edl4stCfz6EmYm42/VQxA0gMLDrOux6jzIM3ewXuxEAc2FaDAc5txknDthvfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593970; c=relaxed/simple;
	bh=1zjj94+FtnvjoVAc8d3+cObtjpxX2UfMZe/GJNBstgw=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=DEhpiMX9wv/iOGKowqqdyv0dsCcVEhlEU345goK1rMT9da50mbM9Uldi2DMMeFz+idrcQvDPqgLbccGeX1LQ9Ua1105mDJ9TLTO6Nbq7A1bxWtszSJBQNTxz8m4uRgXvXYjcEq0f+KxtqUOCXd3qpbVrKyDe9IQi4894kySEk+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=MW74l5b7; arc=fail smtp.client-ip=52.101.125.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="MW74l5b7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrAAMlQfcfFHKFS+JThiRmqAnMXvZ61z2hewhHtmDnUkbaR585pB+xJjP+pM6TwLkc2JAblv0qd4MUeDtJmxLrLuXZjfxDH3drLwUWMmiosm7t8HlfSZKrtQT3gznXXa1yiL331KEjqFRS+9EBKq4A+Vv9m4GN46vcrE/Igumu5NhG4a2Qad3L+xW9FQFFHW3vTUYmGlBx4Qw2iuO3IWxPBUjUaFXUZbgg/1E+H/fZugunxemqHqsm0SDmgYNuphHYSpluyH9VNcNaF1qdMvycgMUySbCpOEGlsmlpYtDxgLqzDSbQMzU4de632b41d2xFQIioatUqBH+whlB8fZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xn6E5FWObCJKhsaw7kpqiaTkkLiTJggv8rcbcmhX5g=;
 b=gOGaKq4h9tfM1McjkYpUWTnSjjqzej/XMn6GWXXXrecgklWy8MBx/ljCO1a8KiC7Z+gmvM9+CQ/6g0nrmdRmlHIgl3PHGBkRfJ8cITANe9mxPFdMQIEBlaU/TUEpVwHwRR8QMqA3KfWAUSjX5V51gScl47tUjTFp83UIyXnI/VCiIvPT2XvDuAxrUeaPee/NepkZ2mf6mOkpKF1gjREKnb1DXE6XVJYkad8ZMVcHez2Np7pbFFZmkLfeQoywcTzMZnuqvuir+bw9MEqTaf2pB4GdZk8OSbourKDQ+x0laXANrzenXMwxIRdEUGFBUMRMRuGogPcZWz8El7lq3cg1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xn6E5FWObCJKhsaw7kpqiaTkkLiTJggv8rcbcmhX5g=;
 b=MW74l5b7FH++GAiMgXwldFi94oYJxvB+MaKywrrhz3kc2az49iBEa/ftyHMFCh0ICtuB2NYB3sfd0Lmo/0G8fnrWIpJhJzMHMso8G+vSBW6H0JMPPmpmY7q5/hVQ5GQrjt4Gv3hKH1n/OtRkp7/FavBXDRk3hkf+V4gz7omzulI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 04:59:26 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:59:26 +0000
Message-ID: <87tt5xaudu.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 02/12] ALSA: i2c: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 04:59:26 +0000
X-ClientProxiedBy: TYCP286CA0206.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::14) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc42b0e-ce65-476e-e0c9-08dd8d23f0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?byCvmkDmxih0tdQL4ULYpvMkloycNWzK8euK8BIJjeQ3eOKX+wAO06eh7n1t?=
 =?us-ascii?Q?Daex6FyYIpRhTCtmNZ6xt/yQ4zSCoKj9nshjYZlPvxlx6e61Y9aT4m+3NFoD?=
 =?us-ascii?Q?Xsqw2SdceBBM+a0yHTUwTh2zEqBr/FnSRXYIcw77Xn2yrl9p4FizFb6brnIc?=
 =?us-ascii?Q?t5lvx5jRtFfHUev7j9psCAa4IV9nxFJ09xcTZtcjL+bPdzI/ew5MMyRCkhLD?=
 =?us-ascii?Q?RzSozrn7beMsBV0oxiq58ICD3xN8glpr3SQlDr1jm1/sPGYWdWBHGB11MY/o?=
 =?us-ascii?Q?81DwOTkvhw4HeavVov7OJBQjWP7aTeasBIgDWoy+W0Fw8yflQJSWNLNUGDZX?=
 =?us-ascii?Q?vHtePJ6IJlQbiGe6AH0+eEVQUG4AgtXrzzBCamUkUqrpeJZzomX2HpR1tA3R?=
 =?us-ascii?Q?Xwos1hQ3MhznkJaSuoGUl9UAf252bShcxQTculwOHvdGHGK2XTvzYi9gBw7O?=
 =?us-ascii?Q?cXt8OQ+Zu96VUUenSxXy+QeE4Gbk8o3prPP4wlrAcaE8OWQ8GwJuYmja0S2z?=
 =?us-ascii?Q?V1lEimiaJqz3UQWdxbvdD0wPSS9rKYpw6zisFWVyPwyZRcG45/Y1aqipum3I?=
 =?us-ascii?Q?F1GkHTb0wmSsdVVsrfI5eCW+6gxOGiUQMSnh4JASeneH2yPQAW/3tc5qVPzY?=
 =?us-ascii?Q?/fLDW1RXdBbEnuE3+7UHY9ONSie5tnJ0GYVAAc7hXdQWR7PSDYJG6q9mvpL8?=
 =?us-ascii?Q?8634hPyjYxnPYteDuPvycSi/J8hFz07Qpm3VfaxkF2txcEtkjUHUT4sE0pKV?=
 =?us-ascii?Q?+imIPiLhCxz3GMyL9gSwPl3l9PupmsLV/6TGxWvV6+eL/e5FVh68MGEkRoz2?=
 =?us-ascii?Q?g9gAJwFH0Jf2T5OZsLDDi0/TeW0M9z+8q2jzBAOBVJuObz7JA0Ur6ZM4EZa2?=
 =?us-ascii?Q?utcRdlJ5diKPaSCAljxztdkxYrco4/L8DCflbzbs95+fIll5Zy8snf74nxDb?=
 =?us-ascii?Q?56er9u1LfyZVwNlVlS0W+r6e5Y9ILW8RB6wr4M961nDe73xnjsOm14RaTFtQ?=
 =?us-ascii?Q?B5v3yi2N0QRLfjHhh7PoDqE/EOj2k7jAGvOZm4iJhlbCmahn5Tjo63azZSWD?=
 =?us-ascii?Q?8gC0uxuJ9soiwlRul4D5WV3PbTSY6zit3aPkwpLH2TQTKRRjJlljiPiipBN7?=
 =?us-ascii?Q?UUA6l62Fo4HAVRwK5Ad7Woqn+6A9VUZzZQ/4szaTLD4u5+a+RVGJOotqZ/K3?=
 =?us-ascii?Q?vFI4ap1UYmy/Bx2Uu823ZNSp1idOxPsRafmz+B3vtdCRs7eRDCQ5K/QgK4Xt?=
 =?us-ascii?Q?503uQnRc4pwVqRA1G69viptjOwqFuewdENB2Sm18zDTqqF9g+SlfvNGhjLty?=
 =?us-ascii?Q?dYa696F1p3G5+fbxvYrYakzVckSNIUAXof2Y/DbtUsJVdHRMDBz+ueXfRG5X?=
 =?us-ascii?Q?FaPumAtgcHykLblnabU60eIottE0exB5gZ/4pzWFkDvXLuARXIieGluvNVJF?=
 =?us-ascii?Q?XzI5amdyLX0OjwbN5iZ6YZvvmUDV/ZFLgYMPX8XadAImBSxDYk4mbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ZCmbrc610qkkCY4Mzk69Vc1eN/SQ8oMbd+6q8ihoQFZBwUhsIkU94a1Pfc3?=
 =?us-ascii?Q?Bs+FaS/hRf8v1Vd20lQWflm0nuLR9ldRsk330zM1Z/HO7c+3b7QY4RoW2N6d?=
 =?us-ascii?Q?z9CZUWhZIc8Dy5pTOWmXHll3dp7uyRp/Fc2HJrdsXOrLzHy+W9UMEOna3ev/?=
 =?us-ascii?Q?HgARik1PZ/7D8U6cb63EKPAeV8M7WBWXy3P/wB//HS7q2ihoblMXpTWknMBV?=
 =?us-ascii?Q?dt57Lah9P+WMixsFMww3GocJ54k3FEK5Drhr27qsIDkHTZVqkVKUklpVcPBi?=
 =?us-ascii?Q?LZzeuwkjHPiZBe6i+YwNkKsurOxUy67+FW8SAmdv6qZlsZBA592BzT6qn021?=
 =?us-ascii?Q?4hKljwjLsD1R0vEgo316FI1T16WJYFIKOHeE5l2Vqri9QPGzS+5aj6iiSQxe?=
 =?us-ascii?Q?S08BRquVlosgt3CUp4xPkxIhWKmnB3UFZgZAOnYxXhCh6TRimXKmfTxcRonD?=
 =?us-ascii?Q?9B1O36YxjIDvMHDJNB5SfvvHW4FlJxwVxK+s3YaFrgD7DMfxWjTZfHN29s0z?=
 =?us-ascii?Q?I3awlz4fr3vKlnB7KAEy+nEXbTncGM8A7CpjYVRT4XhOwvRt4SO7enl0rEtt?=
 =?us-ascii?Q?PTHH7qdYXbMwYLTxnH37DaloBiB+5rilU6+RQmHI0Oc5fZ/1zWEacfvRXDvG?=
 =?us-ascii?Q?MykBGVVB2q8inJBEX5PLDUGBF3l7nya/cFvE4gyMA5CVB96Dy2hR/HvAorcC?=
 =?us-ascii?Q?9hcRsGBguScc5iLcTsF9xR6TRFHYFNiadJffybZ3PHcBLxdrMY6MSb86UVlS?=
 =?us-ascii?Q?wpOEIW6H5MP/j2B9+VdljV/8Cql5pnD5CrOhJy345t4iXUShs24TLTQpe8PY?=
 =?us-ascii?Q?jtHWIozE6bPSNOp0tI0RS9ZMUU/DEdA22Bvq2uSAWxkaUCKbBzKM/v7kCvkD?=
 =?us-ascii?Q?rn8JtkhI+EnuwQWMa4YMgQaoi1uFm+M3/F42byTIQK0eVjzg01eFOCqqdGZw?=
 =?us-ascii?Q?oaUuZo85jJUdjAGJ0zMscXrcqWGoQCVw7sgeV+hgsc7G7SuGw6q19Bp6YMzM?=
 =?us-ascii?Q?q777L1VKDZcoa3UaDCvKzUW5i2d61dcEmdB2svOOpRIcDYkWNK48HVRfEDDn?=
 =?us-ascii?Q?FJHj7itZJMN7VH7nQoeNSG3t/ZCmhqAJI//rLxP0cWVVv1uji4VOHhjM8vPm?=
 =?us-ascii?Q?6QHK4PBdPVAc269OstIVjDC0/pJSvdXQGb8AxQcyz2HgfQHrLyv2sOQOMG0V?=
 =?us-ascii?Q?ghCu/pGTiIzgyVMuS8YvQM8oRm42HO9DzHbCEc/BvgqcEG5MEHIG4jqVYa/X?=
 =?us-ascii?Q?p8K02TDNUyoP6LfqftbsyNxmUi1feAzGMQ0SS5/rS0tCaH7xBJri4+TutRo1?=
 =?us-ascii?Q?+/fP3qr24Neuwiuc0LGMFQaWhRJVS1o/Oa7/4DnD4enLJlrkuMuOK6SJlAba?=
 =?us-ascii?Q?/LLjQDX/aL3oyKWFa2MXpY3fgoXN3M4jwSu/wcBlKrz+JATsnejbV0K/WSLC?=
 =?us-ascii?Q?9SHguxzMoSzVwRKiLUrZCXRLEQIXksrpZuwHY8+tbba4/ZScTDA30J48iLMQ?=
 =?us-ascii?Q?UJpmcAVVwqXEMGkZie31GKK5HIc3UGFML6snO1dPpzcbs4OMjqG6BZ79EcVx?=
 =?us-ascii?Q?yAjDyrEszHejRHItLFK+q74KttAKiL7Gkzr8ts3GCKzVA+sc5pA+lVYRyzB+?=
 =?us-ascii?Q?1MDgdvXA7KpDVY/1G0R0qVI=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc42b0e-ce65-476e-e0c9-08dd8d23f0e1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:59:26.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdoCd/XIbk+b+zqbb4/0xwx2dJsU+NosNHgk8kHwWvtPriWF7qeE95ULoDYdG2YEpIe5poKeCI3eMgMlRJnWEvW6iTdpS3IOn4OQivEe8Z2UFf6a1mPRBnZUlIF+7zdT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/i2c/other/pt2258.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/i2c/other/pt2258.c b/sound/i2c/other/pt2258.c
index ba38c285241c0..0fbac827124b8 100644
--- a/sound/i2c/other/pt2258.c
+++ b/sound/i2c/other/pt2258.c
@@ -80,7 +80,7 @@ static int pt2258_stereo_volume_info(struct snd_kcontrol *kcontrol,
 static int pt2258_stereo_volume_get(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_pt2258 *pt = kcontrol->private_data;
+	struct snd_pt2258 *pt = snd_kcontrol_chip(kcontrol);
 	int base = kcontrol->private_value;
 
 	/* chip does not support register reads */
@@ -92,7 +92,7 @@ static int pt2258_stereo_volume_get(struct snd_kcontrol *kcontrol,
 static int pt2258_stereo_volume_put(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_pt2258 *pt = kcontrol->private_data;
+	struct snd_pt2258 *pt = snd_kcontrol_chip(kcontrol);
 	int base = kcontrol->private_value;
 	unsigned char bytes[2];
 	int val0, val1;
@@ -133,7 +133,7 @@ static int pt2258_stereo_volume_put(struct snd_kcontrol *kcontrol,
 static int pt2258_switch_get(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_pt2258 *pt = kcontrol->private_data;
+	struct snd_pt2258 *pt = snd_kcontrol_chip(kcontrol);
 
 	ucontrol->value.integer.value[0] = !pt->mute;
 	return 0;
@@ -142,7 +142,7 @@ static int pt2258_switch_get(struct snd_kcontrol *kcontrol,
 static int pt2258_switch_put(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_pt2258 *pt = kcontrol->private_data;
+	struct snd_pt2258 *pt = snd_kcontrol_chip(kcontrol);
 	unsigned char bytes[2];
 	int val;
 
-- 
2.43.0

