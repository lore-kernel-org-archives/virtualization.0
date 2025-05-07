Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011060.outbound.protection.outlook.com [40.107.74.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7D1DE8BB
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594007; cv=fail; b=nzHEKwxIKK/UVgPcb6yc7Oe/R42yUCx9ZEUq4sVAknk0+HK/+SyNhZGKN/CyWWrVblDeIHd8MvwSmMmtQkgLpd8F0unNv91SwTuvHdGbGSmH6uqWtIz/Rm2t/so4NDMJN+25xsFLzyIYAQf+LGpDM8xpn78tr0q1ZlxJPMynfL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594007; c=relaxed/simple;
	bh=eIRqap80g0cbK4BGuETFfCd38ojsslhVUM9MbhDZRVI=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=eGWZ8jgzG/sl+afTYhR3Txl9M7ysjh4jSPAwzmHf62yBeXY3pRYyg7tL0Tvy7r330ORsufiBpLnRx3SjMU/yIS/LCIUS6DsTNHTRXOfMj8LAcEucJNHqChM+IQRyiMThoIJe0+dA7+PxLbtc0dS/ogmXN4tDT/gOuHSeyi2jw0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=C7n6qhdL; arc=fail smtp.client-ip=40.107.74.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="C7n6qhdL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUSxmB/QQi2rCX0nMzzemTKBLtAWBDTn7H7fKh1ZJo7WS5QWwi3VaiEx8zcsnxX80q95riOPXPOZAGm72sdfqW0iVNShFsJZcGs8vccLotJeXEJwY36IREK/k6wi5l95wU5sLuwnIUKhmC+MU2OtENPa8BKFQS9eSI/FKpHi/vSk/sPo+ei18lmg+ZgXTIyXQ7VtA9R8KWIchIAmEcU3uWiahKPfJQOjEIk5a+w4JeYJy+1l0nxUsgZkTcK7z2cUGkzJkv4ZsuPI9PfR1jEgTfF5pEZp2dO+TjHg3+htddRk4207TU96IGWyV6+A45tAeXqa3DSxl0krmaJZpcUbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5AAUkrT1+5xAUyxWvolKsXSLw9Jt6LH/umOtIf+RU0=;
 b=wnn7toq3p/ODBVIzwBx5zXKDZcfx7IyclX2DrfJ60yKW/wdNDIBytaEwD25Vc7Onr/CX6JjZfSsMKL2sBA3J9Z49iZq428bpncyrxaopwlWu9hLX7V6xSqL7rEfJn8qYU6zmjtE9QlZg20tnf0ouRl4eYc8/fzcLVIU1WxXMc9YIigBHwLJojpxYczWxVzIqHatmpeTT96HQqcYaxeGOLefhyAhMN+k8cph0TOUSQcShp4koF7sZJDr/DpJagtDySYk8PQFIVC74ozEai0Kx4N3LoCzyZAYL1oThIrOsG+CzXGeVxYekt3Dpuj0XVfFQVe2JB0E8Wz27GwpT/1KDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5AAUkrT1+5xAUyxWvolKsXSLw9Jt6LH/umOtIf+RU0=;
 b=C7n6qhdL10Bv87QY/K8l5YwHRM0Rpu9z2sob0o2Wr9p2sXbWC8WkvNTJlnN7ixPV8Y6plq+lcGqkddRrkVSMyXkWSJhR+LnHzjEnuOXlhfQ2Uq3mt8zufVMh4LwZg6mPPSZKRq4L617o7AfSzZpg++xd7tFX/AapXVTO5adgMyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 05:00:04 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 05:00:04 +0000
Message-ID: <87jz6taucs.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 09/12] ALSA: pci: asihpi: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 05:00:03 +0000
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: f29e563c-cc12-4fc8-06d8-08dd8d240774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?romGYd/2k/Jxmu6HD9h9iq55TqqbQiaI6Lw59Szn2B0RuFmfp2j+uxOjoLiX?=
 =?us-ascii?Q?bmIwm+HXewPuR9sTMKKAe2mES1Ld5LjoVOWvTbWkojEY6d51k4h1fVgwLJZT?=
 =?us-ascii?Q?HRPHOBT2xs5QZiL6WWN0G+RuYXZBeVEiQ14AwU9Lz6HilY5WcivfvUoMrehy?=
 =?us-ascii?Q?bWvf1ElIbcB6jlJtp1DlEo4P5zzL6Ta0ODcdk8GV7rmzKvfumVMAo3zL/kTb?=
 =?us-ascii?Q?3wu0/z/6aVYpgIhI2wTQyRY9wi2oQFKMoPDlA5hR08fD2UH5H2ztEqpIXegx?=
 =?us-ascii?Q?V69nKk7eXzWMwAC1J9m1B8uR/uWUxoh2A1qugtpJOYczjG8G659gQH5os51P?=
 =?us-ascii?Q?jF/m01vyKQdqYoi5aMt91mUYXX3ObsmCkkpZJfNUQjJjU8T89trw7Vmqxbwq?=
 =?us-ascii?Q?XAPhme5kiXup2YhrQRNgXgTe40mebRBesE6GWV2E0XlcMjSL39w2XJg6clxa?=
 =?us-ascii?Q?fec5Irlipd2EoR1C8/pAcaHPmt4QfsoTdVW1Q8uJ1iblGKgsqr1GblCjJLMj?=
 =?us-ascii?Q?wXdEgZoRFo8R5ANZbKAgA88P3GrZ8m61g/cAPiS79C49E5xCPL3ZmlMa0wvm?=
 =?us-ascii?Q?7EonvwqMAybN42PEqQBc8iEt8Le/v4XEN1C1shu8FD555ZK+FQB2x1B92Ztr?=
 =?us-ascii?Q?tyl3OTedimeq9lLxoJWokAt3gsA7XOeqKIPifg8OazVoqO3W4AN8Fn/NzfQH?=
 =?us-ascii?Q?2ZIZTsui/DDL04XXru4yucZ8929aIyrRTjsrWA4aX/CvPVy1FHmPAtIHdb7U?=
 =?us-ascii?Q?5MGhtufsDIoRyvz9yXdQIs8Yi87QtjkT+tFe/RI4YVpBQHC1ytvsKE/oXgp2?=
 =?us-ascii?Q?qpYzvqK3JC8HE/J2IiBqWVNa1M90zxAPjjyqwUfD9Y+qbeLCzBtEF4Z2IRXU?=
 =?us-ascii?Q?Ay7+7p4/jfBq6+M4bSDe2KWv8moiMlKJnvBmkprNkTWAtUXqlq06ltCtAQuI?=
 =?us-ascii?Q?dLKhI+D7XF+XJJTWH0AC6gtTI7NUfjrWgH5IR5cHchWr12xhWKFVWkYZW2xI?=
 =?us-ascii?Q?/x79AcnlgWOfqQm+yqupZ4yLOvmD2JlSofMlzOPLNfK9HPIdA05HqRrMCEjU?=
 =?us-ascii?Q?9rSjw1r5AwVSRHqLM0xAw9xEMr0kPxj5dmYjYD8hNr4usL/2U1gAcGeH+2L0?=
 =?us-ascii?Q?GUWoTtzqzjvfvIaRsgBDKOJIJv0EPXXBcNAmH2OrBVA1uVq18jATrDrCY4uN?=
 =?us-ascii?Q?FirH0hrCzV8ULsCpo29lSLjLy2biN9LdHrkhSH6HV2rNsyieppuduXSIL2nY?=
 =?us-ascii?Q?gcGonrF2v6Zo2FCGJRMMk0szAwE4JRKzv27reqzluzeV3p0YJ+BbA2/BP1sc?=
 =?us-ascii?Q?5jw9RWuZmGWnyZ7BLrlyq5x8R8GyvYLm3yDxwRluW3jzdqYnN33gsXbT0v0N?=
 =?us-ascii?Q?Gl/RnA4sBa2P83ulay8nA9V7TKeA7EWeUR7lQ6qip0NXBA1ba1MRrEmLLn1T?=
 =?us-ascii?Q?e4lpqmUYmvqupSVwl+RRmA4PpHv+TmXd8Jw2bhvCkI9GfpZaVKmEgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ytXeg35sicQWqyjYQDn9AE+pa+TsxJpnio0TEPue9n8Wpv5alpaAVJmDpIy?=
 =?us-ascii?Q?lCNCSGTLX1FbOXdrC9Rdgri+ZriQLjMb8UIdA3AmwL2xUasoRy4kvXJlrEhi?=
 =?us-ascii?Q?/IxZwbvAS5juTNkQ2K8Ilv5XsL3u4vZXogTh8RIVzGpIaVpueSw3ZNMoybLm?=
 =?us-ascii?Q?GBRT8nLPnxiEH3fvWiLTyoTwhuq4i80MY0qtya84/iExNShQqR770JmOJAlL?=
 =?us-ascii?Q?hFc0MY1TaQ7cnesFflrGuMN8SyBXlVwcKQh7LpIKrCnrw65hqanwjZvPDpY6?=
 =?us-ascii?Q?8TW15k5jT4FDaF9Rm1s6/wwvr5b5zWtf9BZ3TK29GEPe13HWrfXbARJd0x6J?=
 =?us-ascii?Q?rORgktpSJoHhIjvsbpb0Zn14CLhPD/8AdNdsN38Rbv0Mu38O6tqKIQ/hXseV?=
 =?us-ascii?Q?xt0e67YTl34duqTPz9PrzPg14+g63dfrd7KzVTmc4S2qQp2ICrc2UAq7Gzd7?=
 =?us-ascii?Q?nkxyZYVmJLI5KzOtUQgDs+jqmFX9xqSUtZ2r7CDW15eiQ+Y/A+1GAe4pzDqY?=
 =?us-ascii?Q?Zti+9/ZfZv0xNFiKmbHF4638K8GG4hGT+H/+dH0RKtRzUF4F8newWdO3AGOb?=
 =?us-ascii?Q?rp54fOLD0nCHOmsYtht3r3DoIcKz0PcWzRBB3psPST9UuX53NCc1OVvJ4Qhm?=
 =?us-ascii?Q?3LnYTQkr2S64ilSlPidts6NkY+h+XLFlPm6g+WF67M6Qqo1cGW77y5jiHxJM?=
 =?us-ascii?Q?YdLLXJXBUNaOb8PoQLGXYmZ4+YkTKwJZpVzQKsVkH2Ib0A3ZAh4ZNNenTxxl?=
 =?us-ascii?Q?mqD2FhQsMMRG8UGw96gNgA9XXmVOGS7sbsItySp5FQYbpW3wlGRZgtOdQcYX?=
 =?us-ascii?Q?AlSOBZ1jwlIGMWulgwMKNsIekx5RvZw0nYF0OJ3Wr0cLp/6X8goB33eEDPQQ?=
 =?us-ascii?Q?PaVEVsFsm/G5r45ZOllIphB9Ig2/2S9G2qgnbRhHVswp6UzRvHbnr3Rv05Fk?=
 =?us-ascii?Q?U+L1dAbjFYgLsseQT/KDeAHBJCz2rlPn/ENFzT49J4eW/uWcRI39H1nuujJS?=
 =?us-ascii?Q?hvGs5FDLKqE+S484s+WDt34Gtqd9jZfhoBvhzWe/U96Zr5F5k+vGg4ov872X?=
 =?us-ascii?Q?9VpwtwAdfjkiHZ2TZHPojWBP03wlO5qOlhH7MJCE3qToW4PmHA8rEuf1+pfE?=
 =?us-ascii?Q?pnFtEzjnclo6E3i0+rRf6fStN1mbrQOkklF6l3gjMd6vLi1kmZ34fToNN9fC?=
 =?us-ascii?Q?Bi9mIBv9uiEnCU6sB++T/306UcJn45p+v9OXvWWsTdl/xJSy9XAyNULrKdTq?=
 =?us-ascii?Q?HHL0P1gnH9PVzOKbxcuImFrZNIseii/Cjp0hy3D5QzvKWC+a8dSdCm74HUp+?=
 =?us-ascii?Q?HXPe6rcBFYYPaePG1LVNzei5f5QZA9YyP5v2AqVHhuKHHaWx+G4svpMJThSd?=
 =?us-ascii?Q?Pkj+YbFNugpL+4KR1WluqQz4Me940it6kWLaj+ulyFDpKFADnlECm4gQGy72?=
 =?us-ascii?Q?ksPjtVpl0yR6xY2Hn8nAOvFTDQtusiubkb/7DGrT4jWWCgG6fdnb6z+Rtj32?=
 =?us-ascii?Q?IaRQ0d0PEJAmnYoN9eE/WGwgR1KFQWUzf0Fk5nyG98s5t9z81euoObSo1rtM?=
 =?us-ascii?Q?guUoaZW6jrC87ATs9Tlch/Q1g/Xg1aJDEDvCvyrWgUFGRjPqBXMUY4mSLRZv?=
 =?us-ascii?Q?sGrwDpQz9C+DZqpCuSLBxc4=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29e563c-cc12-4fc8-06d8-08dd8d240774
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 05:00:04.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhnkBjx7Ee55qyCwAS0KUmTP0DyYQGeKrUaqK9NE1/YjqOaOyTD3aUfE7OUsYFvI41m1VyLNlbNdYD3EPTyLWi8vvs8htJy6fW+W0HCWQTbZGG2XVmXCBGrMKx5CYhiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/pci/asihpi/asihpi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 65100f925b72f..7e5ce96954b9e 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -2300,8 +2300,7 @@ static const char * const sampleclock_sources[] = {
 static int snd_asihpi_clksrc_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
-	struct snd_card_asihpi *asihpi =
-			(struct snd_card_asihpi *)(kcontrol->private_data);
+	struct snd_card_asihpi *asihpi = snd_kcontrol_chip(kcontrol);
 	struct clk_cache *clkcache = &asihpi->cc;
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
@@ -2319,8 +2318,7 @@ static int snd_asihpi_clksrc_info(struct snd_kcontrol *kcontrol,
 static int snd_asihpi_clksrc_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_card_asihpi *asihpi =
-			(struct snd_card_asihpi *)(kcontrol->private_data);
+	struct snd_card_asihpi *asihpi = snd_kcontrol_chip(kcontrol);
 	struct clk_cache *clkcache = &asihpi->cc;
 	u32 h_control = kcontrol->private_value;
 	u16 source, srcindex = 0;
@@ -2347,8 +2345,7 @@ static int snd_asihpi_clksrc_get(struct snd_kcontrol *kcontrol,
 static int snd_asihpi_clksrc_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_card_asihpi *asihpi =
-			(struct snd_card_asihpi *)(kcontrol->private_data);
+	struct snd_card_asihpi *asihpi = snd_kcontrol_chip(kcontrol);
 	struct clk_cache *clkcache = &asihpi->cc;
 	unsigned int item;
 	int change;
-- 
2.43.0

