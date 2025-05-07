Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010048.outbound.protection.outlook.com [52.101.228.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F01DE2D8
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 04:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593999; cv=fail; b=O0PhrpUml6tNzzcwq15lQG6lGsQ2wmiuG6GEC2w2nd1/085wlYIDuivfVYT1IetoSdPxHlbRzXmOiNPM/fMZMHVXuPVdkAQYqSe2gHJ+PPNlJgzEerUnNvF7AHGeu76FWqMqKu/5PuCP4yEQjAcqHcQZySS70DB95sQ3PVHMacA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593999; c=relaxed/simple;
	bh=TAaZkIdrr2ELEd7cSCfGM/62kahAoPY0nkll+RL33NI=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=FCn0RG+STYb7ONrJlai0cGsyAWl0jDIYTezthFnUcv0Rft84iDtNOLjYwY5erzIHerS2Dw6eMaJnuA6QyuJVSlhGiAoONjvonsAPK/MjqfawZtoNQd82XqyVTOPnyIxe/INYA0woIjBCrlPOg7Xw20AnLXAV5T9FQzVAIUDryZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dHtNzqKB; arc=fail smtp.client-ip=52.101.228.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dHtNzqKB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRng+w1Jg2LJc9o4SDkHj2H4PFCxdG/1a0sTx75LXqjCGpM2SMMDtAM1A/mrMnB0YoBxnlLarp+Dit43git/+0C0JTPcBnVqBh7l2X/CG4w2ISivKWPoUEYvMVBWTNbAYFIObMyqg33MsaXTOljVXGQdI7ibyaK7FcZ1QXCWuv1rYGlULiaAyOpdCxeuGMXCwrVtshhqARtn+92lu+spgy8q6A8aysB54YswrXnjaL/wUyjEpLM4QqYYEwcLWTlqYRDNfWIT9Vej1n4FxdGpBM4oRKsXkpbnJW/GMftuGqNcubAHzoT8M7T+ad0Vf36K4prp1u2M+F7nGW7kfNkS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRzBsEUBz1J93ev/ldZr0hPtx1MskjbnVCBtWnCrX0s=;
 b=W1iuNQqyp9nMCl69dF8mzd6zwy3lUviEK+GObhIZJG4LzWOPDbVqbCGC7xnDZ88CUHgrewa59zBSEH+fK9EojuolWAkUbb1IVXJZnUVkXjhidUDoh8xojW9LlwphxKOCA8/7ikm0+GoabDedAibW+TAdA05V2/iw/5cmY1E/IYWYtjG19hiZ19cKeTcC4ZsEAzTazmcoh/W5ufq49VF/g18Sx9qSYDDR3O4CsLWaENiioT4te2G5hKSOPZlwVyJWI4o6KpvN9hUZWdKpsH5hSwcp4zIVYJtlN6jtfW9UnOwv/uQLzx+J7PhkGB85MA4PR937BxLSiKsmQVwRjE1Ong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRzBsEUBz1J93ev/ldZr0hPtx1MskjbnVCBtWnCrX0s=;
 b=dHtNzqKBboWycqoViMvQVfdgXglt0iZAg4efMsJ+lVubj1QsQNfp/FZ4v34KYSvBr59ZTtk/bnsj6dFIozwMqAVpAX60umooqzDsefgDlx2m61wGS04KySJgw7sbdCcDbwwFKhtwQeEVYK1aApyOkX3LCyabv2tT/Q5xnFe25dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 04:59:55 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:59:55 +0000
Message-ID: <87msbpaud1.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 07/12] ALSA: usb: mixer: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 04:59:54 +0000
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9cdc82-e517-46c2-7e07-08dd8d240224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?59PEfOJ65O7ipwwejyGg9mUEGCgEcftlgyQvAxAlicV6vFrlbnK/GZpnz3fm?=
 =?us-ascii?Q?OIflIZ4/G9mxlapZ3fXsxrRx90LwNdMW2wnTjBr1rTU/55wZnYkcUDN0ZQys?=
 =?us-ascii?Q?TuwEyeEQgjImX4DUTHrMCFN9wbTJ8dkQWFUs5NhdMewllh2KIekzCN9TBqTu?=
 =?us-ascii?Q?5b4jm/GBfaxn+oG7ynT3iTNJ2G4M+OxVVNEYHfNmrtHKsYeGK/uiJ3FxDvBY?=
 =?us-ascii?Q?F1AL9AjoQepohve8aGXmnX5ph9wjC8DEidJTUsvfKHrantTfwJ4BeXOWASlp?=
 =?us-ascii?Q?BXQHLve39VBbTB0fcxu/VPn2XOxRlSZ90VoTWQOIc0h+NOz5d+vdnM6Ooi4T?=
 =?us-ascii?Q?Wneg7XUUwTlw+gCJtaQPwBPU2HXjndfipeWy0NGz5WKaSCu7C9tt5w67wDEj?=
 =?us-ascii?Q?9uYtvB3e74jLTgyUow1jQTs/Fbsqd8YTVq6cbDqmmHRNgegRpJtg7MD5K4K9?=
 =?us-ascii?Q?sQr3WWf2KeliExl7eRGw7iIK5DJhrEsYRVeBHW9mdPYTxfK7ClH3w90MQM0q?=
 =?us-ascii?Q?8mLt34ni12sZgapNvcubzLxNq9KVBAkBUlPTHi9sgkiomRyv/0SlXtC0V/ij?=
 =?us-ascii?Q?lrU3ZAEg0mBwiVMMO5wA6B1LaaUrCodZXF2HhttOr612NIxyXIcO50dOhqm1?=
 =?us-ascii?Q?0uq9ENKjPOHtT5lvejpdjl3hnD6rNi8xWbfUrPg0tUBE4hxmuscx36sa3ePH?=
 =?us-ascii?Q?uJxqw43xeNvklIupylFWuGVtas54ol6Hr7BgF69x7Xm+Oq/uOuMrlQBiqwyE?=
 =?us-ascii?Q?rEi16TdCmxmqBo0YP/0Kdtqr8A3ZPWs3xMZD+9sTpZR3yLdpDd5VWHiRM6IM?=
 =?us-ascii?Q?XFWvEVjx59J5Tgadg75mbEM3M5s5vAq90mMc/4QTVyAZFNY+PRx37pXESZam?=
 =?us-ascii?Q?W4tqqmPrAKnLHvXyzKTOI8LL3SBRP2NgdOv9aLzQr3OBTsniI9G0TdX3jrHQ?=
 =?us-ascii?Q?a8jA2R7TB5Spr/nv0WuqvwkSEYDX1XkSnRirmnH5m9uxc5dQkBNXa7OOgLeX?=
 =?us-ascii?Q?nAjtzopV2sB+rBzCrvJxXTkAd1xP35Y97DFM8NZnnxhMpeNIqX6Cnqj1JC3O?=
 =?us-ascii?Q?MJ5oG8qoYIKGwwzQw52W1H48Zq0mdfEumLruIY6Pu6QRZyFtGbft50Zs4RDC?=
 =?us-ascii?Q?7SiGV6RvygP8gIWQpxPSp5lVG8Up+vTMwsVAJ4PZUE0fX490AfYHxJ3HYFym?=
 =?us-ascii?Q?p3wG/alH+TVfnVxeuaCwB+Tw2xYbjhIkc9dRL1dV7nufliS0L+MsdyOdzAZk?=
 =?us-ascii?Q?MqxiSYKYRDBzmXSP0NNU5ruBO/KzdEjtdDPVfirYiLwhfMGkqhrandRZZvah?=
 =?us-ascii?Q?zVpwAI1pXMAUA5TiiISfEiSKmX7XpbOOku1RAPna0Mvi+K8lnCbbBc8DCynq?=
 =?us-ascii?Q?80jaINfF8F9uE5Dbg6UEwj/L3JhupTJYH2DXiYHdYeSUsPp4UUKt0w75HGip?=
 =?us-ascii?Q?jXBnkxkXnjqvfmDf1HYGouQnnolMBohsziurLRjhC+Jx6JKA6J1bxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yPnMFAG6lEtiyoiIvwBQVwRDfvMhD9oVun81dZHym+45YZQURbrZPk4gnwA8?=
 =?us-ascii?Q?S1NXnDgYgkR39gBqwx6ZoO+AQWi8kuaoNyJUB5ancCcHmCHN9kXIxZb28fA2?=
 =?us-ascii?Q?8loK0NwvsNKis90gl5Aq4lLUU/9xxAUn1nyBddVw0OBGKSfRVxXeT/VY+I2v?=
 =?us-ascii?Q?m2cZoG6THxQkhs81ZsAWiGjdYM909ZG3fM7wswt2fTx84Zvv1mTP4rxPUpGT?=
 =?us-ascii?Q?JSLLiNoZkCvFpIdb8SuzEJUrFMRn81vLMED2F32PepOsFTul9X/FMzbHyqFk?=
 =?us-ascii?Q?UP0B6hiEqsEsmNZhG0vFdwX/md82RmKMq0eygdmZvNK8n5j01dCOcPn8zW25?=
 =?us-ascii?Q?yMZNxFxdPp1ygFL6OjeazCPuRnCs+JHyRFuNtjoY0661DraNnnBwIw4RTof9?=
 =?us-ascii?Q?qX43giLwaoaWgjCZ607ac3n2w7dYwWjRLWN2T/YOC3IMidP65hmpEe3/iiO8?=
 =?us-ascii?Q?MPVN4zA00BaP0cOAddv/1+/DVu6JHfeeEoQza6Jq2fZIm/3EPjGdgyTPB1F4?=
 =?us-ascii?Q?EzYOYa5UJ+ZTmoKM5AB5n5lNXspOXNCZyQt+QQovZjVD9byg6X1In5ZmfMOq?=
 =?us-ascii?Q?pcaH6+OcF/cdhIcy+xifpl3c5c6TSQU8fTSaJPPgRVGoDLCd07NSo8keb4Lj?=
 =?us-ascii?Q?QA5XBp+eH9nEJ+IZI78Phc1iGD3j0tzBqadwQF//NqsgeKxjyfqVqFFQXvOr?=
 =?us-ascii?Q?ie19YZgtQG7xC0RiwRolb5Ku3159nRWfa/g0vsoVxaNula6POSXafmHoOMtI?=
 =?us-ascii?Q?Fkg1pcCID188SCfiXbAst2gF7K11F1Z3FJEt+mMwjSvV0t85uSclSI5a3q4z?=
 =?us-ascii?Q?LfAl4CyClNc+t8la316ryH4IZGMmAVeOgFm4gAJcNjJkBRACszxtTZ7O2mfB?=
 =?us-ascii?Q?f7j0vLyLqOj+aE4pFwTx3U1pAjYqD2MzOb6ID5QNT7Bl8NXAZGMRVGLgBR3u?=
 =?us-ascii?Q?b+K4sqHtVsuGFq/d4t7hviIxOY9gISgbImX9E3cchObQFg9O65CuvIAtqCH4?=
 =?us-ascii?Q?hn0IaDr7q7UoVtsOrqdavQFLYU9L1BMAhXQxEFCKcUQ9pTY98R95b6/ivS00?=
 =?us-ascii?Q?gNfBwp2ymMr+I5CrTfAGEpUJ9Z8fbV8Ptl1A3jkDfdKS6Qbn5CFA5CoikTXS?=
 =?us-ascii?Q?wFe/ViQ87vn8pzczt2WqUeKRvskpyeF7iWGnhfJi4V/yjvP7OirNupogZFpR?=
 =?us-ascii?Q?b7eN5RwPtu7g+1kRJ3+s/lF/n27HVgYcrIS2bguy6C+2EesFDj3Eg1YLN8Nf?=
 =?us-ascii?Q?RKfCwxYXcAlC2iQSF7oitRwbzXLqK064Lr9gEgWV7N1IOrcFbPQN0/QBmQyV?=
 =?us-ascii?Q?Vg+UAlKVrBbTEE+gej5GzWksQWzw9aE6jepRiZM3GMjy3A4AgwalueskTGzD?=
 =?us-ascii?Q?lVhD5+LqQSqekxlp3BZHEyDI6VOvZVEYGhq55fTy5DTEgD+4QWwVuVwHVeqt?=
 =?us-ascii?Q?jVaSF9aVfO2kHXOi6xMP4NaiDsWMj5Y/mMQS8oNnvNT6klU2DUFSQ0+QACt+?=
 =?us-ascii?Q?Xc6tjXdu4/nutDcArPSZV5GQ3YfmJPOd3ytJnczTeFcU2Zuz5SdqcB2azZWc?=
 =?us-ascii?Q?fT+D5wxccZlwjc58ya+ahXlOsySI/BYoAYnDIK1g/bwyelfgEGqG6/AUxLRC?=
 =?us-ascii?Q?Okh+rfdp/qu28I8PG9w7IFc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9cdc82-e517-46c2-7e07-08dd8d240224
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:59:55.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7thS49Lf5SnJzqWiLA+2vi6GbT8I0BC8YiSG99zx1uyzKTdPfSxZZfwgrKunYHmaHD4L5E8cQqTq4tOoLHmARMr0bvhmhDTXen9dDPY0a4HJyXrJzO+cfimFSOGJe2O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/usb/mixer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 66976be06bc08..11be79af26db6 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -547,7 +547,7 @@ int snd_usb_set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
 int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			 unsigned int size, unsigned int __user *_tlv)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	DECLARE_TLV_DB_MINMAX(scale, 0, 0);
 
 	if (size < sizeof(scale))
@@ -1367,7 +1367,7 @@ static int get_max_exposed(struct usb_mixer_elem_info *cval)
 static int mixer_ctl_feature_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 
 	if (cval->val_type == USB_MIXER_BOOLEAN ||
 	    cval->val_type == USB_MIXER_INV_BOOLEAN)
@@ -1399,7 +1399,7 @@ static int mixer_ctl_feature_info(struct snd_kcontrol *kcontrol,
 static int mixer_ctl_feature_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	int c, cnt, val, err;
 
 	ucontrol->value.integer.value[0] = cval->min;
@@ -1431,7 +1431,7 @@ static int mixer_ctl_feature_get(struct snd_kcontrol *kcontrol,
 static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	int max_val = get_max_exposed(cval);
 	int c, cnt, val, oval, err;
 	int changed = 0;
@@ -1475,7 +1475,7 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 static int mixer_ctl_master_bool_get(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	int val, err;
 
 	err = snd_usb_get_cur_mix_value(cval, 0, 0, &val);
@@ -1543,7 +1543,7 @@ static int get_connector_value(struct usb_mixer_elem_info *cval,
 static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	int ret, val;
 
 	ret = get_connector_value(cval, kcontrol->id.name, &val);
@@ -2302,7 +2302,7 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 static int mixer_ctl_procunit_get(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	int err, val;
 
 	err = get_cur_ctl_value(cval, cval->control << 8, &val);
@@ -2319,7 +2319,7 @@ static int mixer_ctl_procunit_get(struct snd_kcontrol *kcontrol,
 static int mixer_ctl_procunit_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	int val, oval, err;
 
 	err = get_cur_ctl_value(cval, cval->control << 8, &oval);
@@ -2654,7 +2654,7 @@ static int parse_audio_extension_unit(struct mixer_build *state, int unitid,
 static int mixer_ctl_selector_info(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	const char **itemlist = (const char **)kcontrol->private_value;
 
 	if (snd_BUG_ON(!itemlist))
@@ -2666,7 +2666,7 @@ static int mixer_ctl_selector_info(struct snd_kcontrol *kcontrol,
 static int mixer_ctl_selector_get(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	int val, err;
 
 	err = get_cur_ctl_value(cval, cval->control << 8, &val);
@@ -2683,7 +2683,7 @@ static int mixer_ctl_selector_get(struct snd_kcontrol *kcontrol,
 static int mixer_ctl_selector_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	int val, oval, err;
 
 	err = get_cur_ctl_value(cval, cval->control << 8, &oval);
-- 
2.43.0

