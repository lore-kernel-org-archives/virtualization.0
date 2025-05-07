Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011046.outbound.protection.outlook.com [52.101.125.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626A11DD0D4
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594012; cv=fail; b=PJvpKqg0QbQAd5BFE5yr/+nEExhn/rVHTVpstHcmMqv83lmq4bgol4QKzhK6VTjgjSQxigvhqIsrT9AdeVSoItK5CU3Edz826PqHTbWhTXBJLAzfuraN6LWHRkWLGsBhItWUv9J2O/mW8axmg40aw/WHN+TCrUH4OpjPDgOGl2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594012; c=relaxed/simple;
	bh=UrXW7Yl3DxvxepEeAB8XJPV0/AeckXW5rvabAAW6R1Q=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YrTu7VKH0muXI4+zpcNqi6WG3EcvfTsBKCe1IUIq4jdKrCTG9eLagYxZWby8retLfLLe1qO6qZR3ailp/mzvh0ydWOjwuWR6ZJpO5z+Yo+n7Qj9VdZfUW71lR5/J7Zw+xphTCttUEOzNeZtZyL54/6blQrYawInOTPn7VwkqrJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nzUpGA2b; arc=fail smtp.client-ip=52.101.125.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nzUpGA2b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXdI2tvTT5C230So/IlxjdzDWRQLL3v+U1vWIOmvQL1+KMMnqLuYlw6ku2cOWrZ69ihIb+3VvKqZAaKCjvy9RimFbe6jWfwpdxsgqAXNCIgascsTyyHPtm/UIRY04tyA9v+SjQhoCfmtZrDspKVbqWWeUT9mB3cAThV3W2Z5d5wel5AXBuBC1o3seIav8l2K8A1iF5nxKBlnNYZ5khe+pE/tgXB0dZOXUgNsII6cjd4qt55PcWa0DUjG/k1gt9ipdnsJGpnBr+OcHzqh4+s6tfq0DmgJ/HQUZD8hm2npWdwN+YvqRXH9+p4b/1ztPYc7JTvAspTyP7br3oipJY2Emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk/2YafB2VNuQ+8JhKPGIcwRaINBjyNxaAnPsBUYtdg=;
 b=P+hMF+z+P/o7UE7rl/C9RrMLxWMB0DgY0PCBDnBspeN+3DlPE9PP7OfHjQN6bGLJnIBuh9xMHUJuZnmyEN82imsVwI22BoV3929GnBOO8MWK4vd2Y+WutgjwXXzlbnE7FYOSQZOCs8UXInE1dT6t9AWo4aCWgs6PlFrXoS2QPeRf6xhXTDir+FYQFwFwr328imfP7dVAXel9q20D5bqtqitUbDFoyunO9WxKMpEyoAt2RKbWvmcaRE29FoQHtUOMTRK96c4mpYKjBJP4vG2KSeXSfFVafbYbGPzRLsF4EbcfIRgNFfgeT7j8a8HaYy3V40KcCiGkZVV4mXxnOPnfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk/2YafB2VNuQ+8JhKPGIcwRaINBjyNxaAnPsBUYtdg=;
 b=nzUpGA2b9o7MH0H4lD4kbwIotxWBIvPmOkgkfKiLVe6wrTThMu2cqrI4eBgv34JFULeWpBMWe2udAl6VDd9PfRYNRJOaHKL4/5fo4/Isxynj7hw4m0LJDgRjg7Un9GkFEGI06DXRtxdzWiBD4Tmr8uZZ01I+ePNgR0tlAnZtwvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 05:00:08 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 05:00:08 +0000
Message-ID: <87ikmdauco.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 10/12] ALSA: pci: ali5451: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 05:00:08 +0000
X-ClientProxiedBy: TYCP286CA0323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ed6c78-aa1f-4a65-3522-08dd8d240a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j6MePxeRSOvvImQBrL6dEfwzH462nuzP+bedJX3qUoO6bmY653XxXNq7yazc?=
 =?us-ascii?Q?TxliMyWnYFyXGTS6tNjY2pnQuiTKBlCAaFjlOOjIsT7fgV1E/y4qATOzD1og?=
 =?us-ascii?Q?imgRuhen8mfthaXdKd8pwU0VbEoRCo99qedvworYGpVcDYgrQK5KYsg7oISJ?=
 =?us-ascii?Q?zh7YBUHbnNz9dbqIBvVgwnt03gYO/Q79jxswnu+mKKcTniL9leae9hlwpLOM?=
 =?us-ascii?Q?lMiEZ140k5Bd/1GoXw/vE93h7DfMhxYjGLqPwwh/UaA8Jr13qbV3BB+CmTeA?=
 =?us-ascii?Q?zQWlW/Yl+ycyosdLXWPCtb5Sp2G9jROOC6NCt2wFo88F0pVAjkJs2EufTX1q?=
 =?us-ascii?Q?P6M3+YxNQ+DZdyNyF7RHURKoXnIV/lvjjmCeM780JzpHuT8OF60CtMElgp73?=
 =?us-ascii?Q?4PqqdcnNyqJOt3PFyLZjzrv/naNa6uYp7GjyL1uihtVMNJLhCBML2Ad1GaNR?=
 =?us-ascii?Q?2f5UP0r47vZTJMBbf6ZnOkib0OrrsnmJIvbuT+HxYmaTguqE4L56ytIPbtQ2?=
 =?us-ascii?Q?Ctjr9ogs4qxXgUINiE3ysWdFAztu4al8okIXAiwrtRryFgZT4/30zCr/5DM9?=
 =?us-ascii?Q?1deP7MzQxGlsJ4yEltCYlNjqQrhYT7mPRSehAJua1m/+Gg50pSAO/yalqeKG?=
 =?us-ascii?Q?NxJUgedZGs0Ia1mU05B6mdR/Gu6VnTKaLuCEX0hXz5bhnH6UttjZB///oFO/?=
 =?us-ascii?Q?OULlQ/eBBADMjFKqj58i05TU0prc8GviMvUOitVI+U8LOjKxyGCjyca0JuUS?=
 =?us-ascii?Q?KfdKo4k0BaztMinKOfO2KJdjp1WWfUSjc1nYKltLS1tgLpIB/mThi20XDU4Z?=
 =?us-ascii?Q?vWvw/uVMZ6q6//SrdwYjS2vQVlbYEmXxLBDPJ7ALgMAn7myv9KjEbeZ/RcMm?=
 =?us-ascii?Q?i6EiHwfHyQUvn5ffhl4ftByjdin4datcykz97Kr/EYAYrnmjbyRzzrv0/EIs?=
 =?us-ascii?Q?CadKd18MQISommckBX8dc6xBc8Gx2+tYSZO9/12Nkh1C9UsZD0JzlWvuTly+?=
 =?us-ascii?Q?fi5VYt2qm5reUnlUIIKJkNVDLi1Xs54FBozQVkXSbW9a8IppBctmwGkdwr+4?=
 =?us-ascii?Q?jIuQAn9HIYWA04EqqLW+Fvms/ax+IjhzZyvP2GTfC3ThItrCC+mucqqk0Mf5?=
 =?us-ascii?Q?HvO50AMO7W7ttxiRBij9L6PnkM1BE5jeCgnc+rMpT5V8wZCd50jgH+d2kA88?=
 =?us-ascii?Q?I2VN0wrQTLl0vLknKklaecnHYBb1njahPgTQO4tJPhJbrRnAJeXCBPvPdi3+?=
 =?us-ascii?Q?FxWLbqbRNcMtbVSoq58OReiYWHaSx9rPtbnrxCsChOFSe0jfP54ETTkKyMAc?=
 =?us-ascii?Q?N4PB++gCbXCGnzuC3Di4wayuJAbzb4wgsxqMQrdN5DzA444Mwc64kVk28gH5?=
 =?us-ascii?Q?PDjC2U8vk0AP+7FdI1epFSMC/krX+MvTwxCuPKqNEJBi6u+F7H1cEa2fgVeq?=
 =?us-ascii?Q?3S4Y+D/m1d5G0jgqyN2g8kQXgGZ1iK5YpLwFnLT5hBFNPpfCtzDukA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bCKXYxUTtjVXlhFFDZkqdspgXMzBXmeVXfbjFptXZESh2ifuGnXzrqgQIEka?=
 =?us-ascii?Q?j859t+zw3s4asTs6hDvryVa7hr2dZSSO911kFpjvi30hOe+g4DVLp+bkrGTD?=
 =?us-ascii?Q?t7cbWiIPQATKYY6h5xJE9jtrmXSD24WW8o7b4x8KoXYCCThpfPFIiL6AwArr?=
 =?us-ascii?Q?9y1QDGH6p3MdbldyoZqkIHlbF0maVEA1q02VShT8vnhwwBxKdEDEZn7dVXzX?=
 =?us-ascii?Q?fWQeqp732Vb6dYi6Uo2ajr5ZwP3iwXpuyT3Qxmgo1Jx68NKGDNnAYR9fUSpu?=
 =?us-ascii?Q?6B/vWP8vMGtorvWOtP7mGI/ZrxX0V312aOQ+8d55OB1lZT3sZ+Auq6TDcYnp?=
 =?us-ascii?Q?PdStUBRCzA0Hr/DLASlK6/MozLGOhK8wknyG3tTebie+HM+8/uVEpaFL6wBo?=
 =?us-ascii?Q?LVsqsNvIeAOz+nIvW0tTuvJm3Yq6v9d7gatU5m/geL4nyEdU7Xh2a3c4oYGq?=
 =?us-ascii?Q?6FoqbAcHT+gWS3nbTHRpH13juikhd9rCUZOEOqAn0uEH1l0T7SKP8jReQhsh?=
 =?us-ascii?Q?NXvimeNk/pWgnpFZjRNuVRxVXfVs6Xl7UwmkXGz8RbxkuAj8ZdGcFyVKoW9H?=
 =?us-ascii?Q?ZF0NTE3VPB8C10yJH7H0Y9L6glQv28S2EbWDIobH34m9scqhR444jJ2bp9Yp?=
 =?us-ascii?Q?Vhwi8nQ2BIcGqrkxUtszNWbYkWry8WdgrD3eZ0qHEDT7Vl/LXmNbwkAbq0Ie?=
 =?us-ascii?Q?/0vzJuJwE7Fs5hGboLikvLIDB1vhSl0W63oJEiWBcBTTlm3h2CqZG/KIQNQL?=
 =?us-ascii?Q?WM3l9A/Iv/T85lUszB6L27pkAWtPiOhDCHVa0hnz1Uux71E7dEaPunIEnWqJ?=
 =?us-ascii?Q?/TMhxkcgl9o18rUNTQfETNT9qW6nomyep50K9gFMFWaSg0MAAzyz9unSZaF7?=
 =?us-ascii?Q?rZlSEvztFKYaCOUGqwJMvXFC6vOridFFG5/yTomynXJGEGkAClw3vBXzXygy?=
 =?us-ascii?Q?pMKPfhSjPdq0DWgGLqn6VKvmWZMgtHv7FLkZ2OKNRUVF7LaMJYcdKZF9nAXF?=
 =?us-ascii?Q?EHC3P3Mcb93roKhTHubZZF1wBkfEpq9LzM3AIyZa9lUf91h3N7W1tLdHDVsq?=
 =?us-ascii?Q?HsnFNKepFEutHG0+nZjKTGWvfl4w+M9YMvbR4mTjsR0F8XYXKnEoZiLYfnRY?=
 =?us-ascii?Q?W0m7KrP+epdQ/ztgm86jpEYR+Kpba3eO21vUgnfsZRLKKcDU/x32KV4N25l2?=
 =?us-ascii?Q?JQ23dARgihIli+mclQg+LP3svKKR/iG2uPt1mgMN41FdKrTVVen7rfGdHZwM?=
 =?us-ascii?Q?rEokF45CM1Yy0mg7Vcq89KWksu0Wg3+VMp2Zf+KfESdrX56TD1Y/xfvX2g2F?=
 =?us-ascii?Q?WWzO6a10Uf98pmmmhgtNB4Yd4CtLpbF452EnEoxJCtIeClYUJnbbaZfZRNmv?=
 =?us-ascii?Q?XTM8jlEfBRIJoebBwgAbcM+PwPEAq14CLVY8pHFhE8ZvJig7E12Ql0Fm5PK/?=
 =?us-ascii?Q?qg8fJLWPs6g2K5skU7LjFxracTEwKsxfGxE3eFdZsTnfaG4isrgJVIVfnyVM?=
 =?us-ascii?Q?QMH0bj2Ic0SO0o2u+MIL/+Z+szCj9HhRW326UAG5tdpOyHA97iGoghnYH8tG?=
 =?us-ascii?Q?iBKuUXNYqs5RWe6l8rAmmNtErh/c2e3a2LxmKsk3vXxCEnPlS43lUXPP7gdn?=
 =?us-ascii?Q?e34Q/JInP5CtyOAwOQeJ89Q=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ed6c78-aa1f-4a65-3522-08dd8d240a03
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 05:00:08.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INDAlGY4ty7GnD207MSwNgayVjHdrVzyLqYL3qGw0YxhAwWaPzD1KUX12tgv3W+EfMgBlzVcJQG9cA5CRd1mDroMMKTKu98AEcNSJG+rDEw5VpywOTwfSEob51yQkSHk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/pci/ali5451/ali5451.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 5f38a60467c1b..69c02bdd38ce1 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -1688,7 +1688,7 @@ static int snd_ali_build_pcms(struct snd_ali *codec)
 static int snd_ali5451_spdif_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_ali *codec = kcontrol->private_data;
+	struct snd_ali *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int spdif_enable;
 
 	spdif_enable = ucontrol->value.integer.value[0] ? 1 : 0;
@@ -1716,7 +1716,7 @@ static int snd_ali5451_spdif_get(struct snd_kcontrol *kcontrol,
 static int snd_ali5451_spdif_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_ali *codec = kcontrol->private_data;
+	struct snd_ali *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int change = 0, spdif_enable = 0;
 
 	spdif_enable = ucontrol->value.integer.value[0] ? 1 : 0;
-- 
2.43.0

