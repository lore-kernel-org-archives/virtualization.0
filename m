Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010002.outbound.protection.outlook.com [52.101.229.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAAB155C82
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 05:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594019; cv=fail; b=dC1tM2ISHcOXIBEi4RLLb13GHKj7TdvNaHn+EXDaXG9XfDSpwRBAQqlMdy7dMnnTPpOaHX/LGuQ5CxlxugQl+x1IHIzKGWWlWzqhB3pVQCSDivaKSp4ZjK+QQpQrdWUWW2hDngpWJFXAJkQsQCW5vTUnbrojHl9iqFy5apaSWOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594019; c=relaxed/simple;
	bh=b65WEt/ri+DBVMhNagLrK7Xox3w0XtdPkqc9BdzeGCQ=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=kPzZY6q9EXR2Hpg7X0eJFUXfBE8Mt5MsjGa3zhyf1hZ3ENkuiZmPVOyShrj6NRfuGEIn8o/3sCVOtfmOb8UTudBPfuRXUG+Qs+hsp49BP+bS80ZXKfDFiYrP+cypDs9t61iYr2JNJ5F1DzoLEarIar/ZBCkysOA+qnwCfOKFnfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=H1JH1t7N; arc=fail smtp.client-ip=52.101.229.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="H1JH1t7N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWyHnRXTd+rWg49SiCT9Z5z21dE03CCUgdm5yqp/va8pk0lWkMqpbfOADrzYRV4IiPPWDiziifMuz2CEKsV1/6EipR/jCMaoo2m8d10Mr1N+c6BjD8iqXszdpbSNYEHAwT9NX9RU56Noc6mPPdTOPqmZbMrethU32hLJETmW/dMo/WhoFfqt1acLh24mMfZvIIdO5m9tdzQgR8goihND3vLxe6Mv0EWolcfmBKMv/lk5CXXwofmZFXX23uHXhzfyIEVkLi+vdzQ2EU2DDwTsz+2g0Xe8WkYCZZ2ehewtlab3wIABsdBuw0M6U5zYFuyDgydvP7rYrxLCWxM7oW5rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HluBBZ3XLBlgzm8IKR846XmDgxHSjBkXXF8lpgehrEo=;
 b=pvPuOqkbV1IqHm3hJic0ktSOkxyV2785Xor2ueOYjfQwWYa9N2neaUzTdVMJBycPmDAd/Zxhn+PaFve5YorG4Jdn0VG0xEJiEsMVGRM7s4HMwKhu99sWyNcf6HKviDh4q+dPV9buP9osnDwaGNquecSFBw/+k89vNz463WqtL+NsG8R9jfyX1GMjALU5GJ4AER2BoP7P8uoGGmCXEHbCz/DXufwXrf7PFYF2BYNxUwCfpeMXG+0D9W8pqRNidsKAzDhmSqzshl7c/wTsoeSoi+qsx1ZO158o5SMmvpT/C/AsopEbrMrpjSivAReJHZRzLbwxAswsPFHPkEAX8qAXiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HluBBZ3XLBlgzm8IKR846XmDgxHSjBkXXF8lpgehrEo=;
 b=H1JH1t7NQr35nfoDO3w2TeggYuBir5+trUtmqLRLPHnQ4e5W9Hwd12Zz6VSE9OxlG+o6IZZbogod7a/rTDOH+4ZSc3u/YSg60cnR3sAw4D8J2k5fZuOi7o20pTHubFDcXu5GZPVMFGTI+XB04GQwW4SYirWH1PIT6DjXgdbgNJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSZPR01MB6890.jpnprd01.prod.outlook.com
 (2603:1096:604:133::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 05:00:13 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 05:00:13 +0000
Message-ID: <87h61xaucj.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 11/12] ALSA: usb: mixer_quirks: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 05:00:12 +0000
X-ClientProxiedBy: TYWPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::20) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSZPR01MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: aa715e8b-70c5-4c7e-11e4-08dd8d240ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LvYcOsksD2PGXy7DEGlOjOVv3ymRsj7W8SIfEQWYSdKsGLCLXFEGjgp/yrXi?=
 =?us-ascii?Q?pJN33vcaiDTdzLsWbktrt6XwIAKiJBLiPGI3+/XZkf7MYnxRmGV+S5FWjbkn?=
 =?us-ascii?Q?FHNj+GZN4dB8ivp2jQ8uYWWIzlyLRthm+9KaYyyFR2b7JlBDlMOgzp1qOeiB?=
 =?us-ascii?Q?sF6a95rFc/iP7zKQTi6/6nw2QXZjIo6XTPAH3Gg9CPQ7o2yw//5h+m/JYmrG?=
 =?us-ascii?Q?jmlpt2TAh8ds/hOxbWbykvSxyAYt8k1UqSk5KCzWDveSpAmMrrhK644vq67Q?=
 =?us-ascii?Q?tOhR+6zpMVihp5ouon9zKbwPHsj+mQGjeS2T0Ddza2MLcoKKLsWIkuiY4A6u?=
 =?us-ascii?Q?JjCXXkDwQRpmbEcseIGB0Eb6JBpjrwuPpf2vX4GOP9M9w6I+uJ3nLLjL5l1d?=
 =?us-ascii?Q?IDltPe1Svinmnsd5iR8WhCLErFbzDv/pFNHN7Lao0s0Z02GfypbzKtaZUaoH?=
 =?us-ascii?Q?JpBDHKiUmX5KcK0v8nYJBrpCcSs9kEqkAe0MMEepu3osUnD/TSAMvz9DxEtW?=
 =?us-ascii?Q?VarV5BFnd1Fr+TWkNoVtU07CAn6xFSPBTp7mb+B85xI0ADP0cYsSf/Uz8xsL?=
 =?us-ascii?Q?/kO48YgmoxlyfzJOdNEwc3pC77cANQMgtZ4DLywm/7uwQw81RILJAqa1rdE8?=
 =?us-ascii?Q?QTpP90k61NO1ISSlkrMsvIP5lhohcxETpzuZOorFLnb7U3yIZUVsxLatwBJV?=
 =?us-ascii?Q?nd0jrKqRsxto0O5HrKhPN7tMiM8Gu/FdF1ry9pBlHkbSUlR9UB5T6giY5eit?=
 =?us-ascii?Q?Q12QRVzKhldImUhIGeQsBen1liLeCOjvcvIoRBM9Jj5OTK3UF/hHf1NtgwW0?=
 =?us-ascii?Q?fK+onq32vTbzCigHOw2D3cnRvg7YT8+aZlnx2SOPNrEfVyXIS+PHWhDkARNk?=
 =?us-ascii?Q?zSGmdXQsmrFWF37r+Y3erSzYeEeLH/DMlMJEMVQznjGrvzTlHGe1VKDM8ES9?=
 =?us-ascii?Q?Hz3hF15cPk9D5vJfGz99uIoU6wdG/fdGO3P0KKyFNujcPPUrJzgJGTIKNvPG?=
 =?us-ascii?Q?yNF63yTBT0Q4dYhkyJnZ0kX4bxQwVIIfNdKmzMcPH3uGd7o+8m6axLu2I682?=
 =?us-ascii?Q?FmzJHXk7O8Ocvg8TaDqti2TW+ckmxG2gjWYQCxGKlF4WyJ22Gmp6Orq4IbTB?=
 =?us-ascii?Q?zX6CJxxYXZTVHYk/6ScHJwP+TmzVfRvP53+BORDUb6zj9wfWQzWmaw8Pt3V2?=
 =?us-ascii?Q?hxsF6MKcT+IiDl79MwnGRu/Fxj8i1+pG4SFSqecodzifap0D7Tq8xDmmKshf?=
 =?us-ascii?Q?fkExLhYtK/IYjh5SalasR38nLoTdbefD0bOZEnIyEm6bIrWDDm5lFNARy7ie?=
 =?us-ascii?Q?IpJf0fi2WM6fXCEhzjKdPVZh9CpNxEo4R+ddfN7Y6CcYmBwkZLmPT2rSyt1P?=
 =?us-ascii?Q?w3/iDJE/PdSq3J3zL5+XXOfIpZwKHwAEAXpj0ailfoEboU0e31T7aYLu0E4J?=
 =?us-ascii?Q?+i2uY4o2y6JMPubF5UGSPJey0DU3ikG57XtMV2Ej8iaBd+vqZORang=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QHpaGdIMUpzpofS1XN08SA/2ILO/5Lnd3ucWleW4EkXNycGkbAPmmqFqLDdi?=
 =?us-ascii?Q?TFop+oydleXRj0zhn+tYVTUWVCEuMtuNGb7CIQ5hycYEEzSxwMdGnSjzRUPB?=
 =?us-ascii?Q?N9lTfeJkXD7vh8fiMb30qei4/zDyRohg60MswEuNVdUiKt2spg72qXHpsc3K?=
 =?us-ascii?Q?zjOsmBKadU+9KHX3aaz+9SEHaGltYfxxERUoTF7WmLhBbss+lZ9djl6ptjZR?=
 =?us-ascii?Q?C34dZeJ+l85gjtbfVg11z9u44v2LJRb2GSai5oot0tcLoE1jtPYtLk7FixVc?=
 =?us-ascii?Q?v5eQV2yumxNH4D1Zr7Yj2Q6vHe0LnWV21xFrLglbCt/fiV9bVLhwwljoSl+X?=
 =?us-ascii?Q?AJ9S5V+6V8aMD8MyEDPXWnBmyc9djdwPsHSa107tEj+c7MDmOET3sq44YDsm?=
 =?us-ascii?Q?N/+G91H39AxuP6xnuEu1AMxQbtdVJFjvYY5kN5L8vVw7CrARcJ1wTfAxE780?=
 =?us-ascii?Q?ywmDVEkI9UTdDEein7grc4A+aGehcM7XJFJIcC3M8bUkiT8CsoGnUgjg9VrQ?=
 =?us-ascii?Q?qRiUoS0DPZxo6I9kXmt77+hhh3o5kP9wUiBmQhQuI4HdaukjeUpe8V6LklAB?=
 =?us-ascii?Q?GVdCQbF5tN9A2sDPv66kV4CiooobCwPX6fvL5nFuCWdx3rpCG5D1q2BMgRuw?=
 =?us-ascii?Q?/xXtZEZLsABokjWNGFWasiNqOCQcMG0OCJIoQaIROCC5KEFQBXAaKqFrodxr?=
 =?us-ascii?Q?dBNDVxnNkuTk+xrk18auf/5v2y5DC4OH4XSNAfJoRok9i3WJoe8NCYSC8l/4?=
 =?us-ascii?Q?SuTRkJ4kMb+pdt4osp/JUO3lRjpdiJXQxX41zSGDqNJ/su8fzVhDTZNPth73?=
 =?us-ascii?Q?G3it0yiyzIorgk3v8Q1h+7blNGmTU08jGehl97oqtbTYEq3sXyFERcJr1O4Q?=
 =?us-ascii?Q?GmVwbf4ao38b9QlDBDXBTIEAcGC5KxON7lWxEMALympXlWdH/FlrOREbrEoi?=
 =?us-ascii?Q?YzQ0r0y5wVcV4iC2ZzH3LC6m4n6OWEVuPfdp+qVUMmDol9TLbEsBtLTSeaUH?=
 =?us-ascii?Q?2hBCOqsU+8Z/TLLZrbR1YllY3cGQOCA3sJsWyMissgVmHkIDXWE0m2870cIj?=
 =?us-ascii?Q?H/USSF9LtkpGxqBklKV7JJrtDyJ7KYrKXfJN4EiM1qutisVySGD9oUqAbTCO?=
 =?us-ascii?Q?AyodLk8PMCSCL8navGMuyudzDoGPlMhWRTepOHBp10gBY2zcukSyE8bRq4ox?=
 =?us-ascii?Q?7Zr6/oj70NFhZoAiUGkay2SuRvWgnBw1oDowUJajjYoyxfUL0bCEIYMYt0Qt?=
 =?us-ascii?Q?k/ZnudNVcQd1bu/+h/eMf55LG1w2kr4VkG8mVN0JnOuAuMhDK954zI0fFp2n?=
 =?us-ascii?Q?NaNo01sh1Whwq4lQVSDmYvfQqUynCYz4ZAnAHGHdIcItXaYXlI0Dl05THn9w?=
 =?us-ascii?Q?r2OSgH7pn8oZ30+OvmhndkKePmtn6m6PiJu1T+FlMA6dbvwmpavJvpNBBc9f?=
 =?us-ascii?Q?SmnUnOKIBlmNZ0C/73D4dyh9tuCkKLFQhU6Vw5f2GdJNzqLvVEardMuCYO2t?=
 =?us-ascii?Q?5iKbr8u/YCKjFpfZuiSsPYoLmEM/k+8B8NSgR8H0myKMk7cnz2EsN2IKqJ+N?=
 =?us-ascii?Q?TbkrGHIS7l0VoXZ7n0PMX+TzkY4/bnVx/FLJ4NowN1ZAI9QFgSFXjZdykXjL?=
 =?us-ascii?Q?DE9bkFyUxtyRUBYdOIUwJSE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa715e8b-70c5-4c7e-11e4-08dd8d240ca9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 05:00:12.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTyKG8mVCirM9GUQolnlfr/WzIHQ0enKb93TXALjTN6lIpyp6DUm5D2Crx3MWsp5SrUqmwMt2F6X6VweCENrr2FyofZ6tsW6DAENTi1tXmLvKZ+/XoIQHdgD7IMRG/mK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6890

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/usb/mixer_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 01091c3a83fcb..2cabf3bf63d79 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2000,7 +2000,7 @@ static int realtek_hda_get(struct snd_usb_audio *chip, u32 cmd, u32 *value)
 static int realtek_ctl_connector_get(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	struct usb_mixer_elem_info *cval = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = cval->head.mixer->chip;
 	u32 pv = kcontrol->private_value;
 	u32 node_id = pv & 0xff;
-- 
2.43.0

