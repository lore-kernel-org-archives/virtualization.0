Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011022.outbound.protection.outlook.com [40.107.74.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2D1DE2B5
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 04:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593989; cv=fail; b=osr9SxiVcX5Ekl7dncn2b877YJl+EAcE32PRd5CKaVszI9gHL2FBumyLi6Zm+/9hXdbETiBNvdUh6J4pT4I98YyRCLyJo5QaY7RI91FeDF82odMUNmH6+ZVvtL/Z3V+h509+GDFo6wnoTrChd8NMMXPE5D6ZZBT/0DICV9lzb6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593989; c=relaxed/simple;
	bh=tNHF5qWTj7FHkI/kZk6dacodtwR0Mmq+mNDZWobW4jU=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=cV318YrOSbTRyqhxFptjxz6/T11bazjQUXnx4IezmST5/cdptvvYFQI6CiMQaPC58s9gcE4hYZ7+vRrp+8lljrRfex6mMu+mVdqjKdL7DQCZi/EvWqJH6lXmE9SAY63UMpgIzZCk/z0tjlIFEGr4ee6F2FOr7soyaoRbI3p/iHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LF7bvIKJ; arc=fail smtp.client-ip=40.107.74.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LF7bvIKJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk5wx/cBWo4RSKQCmg2NgcNNKDCmC3V/Wm1T9tefADQyYRcHyVLWlQwddQSei19BP/y4VYVn0DuC72u63A/1SE8nlj79dtqqa6RytaFVMUcD+ACL2Je5SCH8TY6RbrwGEQ/hxYl5ZuLCdXkp4rOmZfW1IBwzjk0b/reP0JM8iMBYluRIgLQ/9JS1EzCdTLkBhNnOPuUuP1w+F1uDwl3wXCHhZX/JLBvqw+mkH0fYpdPl9XpE/YI+wUSzzJ+tcfAcK2wMJdutgm3JZoCVZNICSYWRUTFBRTe3wI7BZSagQZaYieCDpcz0wWOxLCh4wQgxJ80HX7y1yxlF+2Q95nnJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RzqMPOi3HeMVzUZvO6PNuX09KCGQrjWhUzFfu3Q2a4=;
 b=PUnlsX43du0rmjOL6hbut1lwWlopP5Ph+CJyTxMBoSj0MuRgbP/7044dBcUhSDIR2hI9Bjl0gs6c0fEPNjfyQ+hgs9gleaZxOVh7DjuWGXZrANkDmVzD3NblDIQUotknm1fOVWkZwwpXaOMvItlQf+i7DaSIeYh6fepz3SG0v9uB90yZ7vTO0f7f7GyR58ALHk1CvoS/GP6DvU2v2oZajYT1tsPInwptDwQRCQH1HUdbfojZljtyWsusv0p0wV2VgLcH/PVdqjI3d+uJ4oCTZFrbUZlOZDqBlpbVkpDE4avIKCw7G6iNKKb+M50ue6xAuuux05EMG/cqZlN+WglRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RzqMPOi3HeMVzUZvO6PNuX09KCGQrjWhUzFfu3Q2a4=;
 b=LF7bvIKJ75R7uVBUQBTs08CHt6EZNSjoiM1m7mjqUPcMv9rDJ5Ugx9cw5gegcJwDYAPVj/0JMB4D5Sm6xZOm47OOVqrx5oAfywf85RhFDQfXu/rmBtUAChqtJ9dOAPNWFJlf7A3lb+fX8FEEhOYQqwJFpExK/d9jP+bozY5xAxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 04:59:46 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:59:46 +0000
Message-ID: <87plglauda.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 05/12] ALSA: pci: hda: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 04:59:45 +0000
X-ClientProxiedBy: TYCP286CA0209.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::12) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6d356c-f655-4407-691a-08dd8d23fcab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q8P0Efja6QUnUEkZvDpxoewqjBmWF7HlPGmSygd3xjTiGgoqu5GKVSMkHK05?=
 =?us-ascii?Q?M0X3hc1iKI/SIIXN49DjzlmPX44OarIIylYkGqD5cDFwFsn6DwEsAIe+ekpE?=
 =?us-ascii?Q?QuqDuoIq9jpLkmsBeeptq6bry22baqJTbTbTcvlqjULiotRqP9iQoaKYw3Ud?=
 =?us-ascii?Q?I6YdiQ7CQX7+9FHaTPdvyk4m9uDezy4D7SM4tWarjz/y8ULOxJ3EpaybFLNk?=
 =?us-ascii?Q?pr40bqMcM5ThLXlbqNOeiFf9gsurVgvFsVjoQQ3BzpptLNKmZs2fmcHHZ9bh?=
 =?us-ascii?Q?XxSi+Cdez3z/kjwB/fqMImUx8IUO4NO7Uyfvwnd7ZnSpcOre5OwX6upD52Nd?=
 =?us-ascii?Q?xYuWCbaIKUg/80wYqhdwEZJB9XO+74JeGnQqfc+mGEcndI0lyYyMmCvdDh3/?=
 =?us-ascii?Q?cIAtsDNWGAnkxcdyKPxoTtRRh9+RZEGm98D64Lude1sWZQ4JZr6HXf//rcTb?=
 =?us-ascii?Q?boCf8PSd8KRSut50y6vKcxRM+16TDztLO94OJ/llv+NKtPo62IF9iYb1LCiz?=
 =?us-ascii?Q?cB7vxGK8HqXE/0rK8qQFPn+LsN/gWer1Z6MsML4WqDXqDNe+XGAgPId82wn0?=
 =?us-ascii?Q?6cuZAzIwyk+RWRQJzIVPc9aMsaTpchS4vtdHrxRhs2M0ioXo0lIUBkNy2y2b?=
 =?us-ascii?Q?BjrQ9SNNFS4QAqTFjjV675myYxrklrSnGJXIyKhr0YyDbl6+g0q12nt/5hqJ?=
 =?us-ascii?Q?BgQTBIlAGapWfMguA3blZ03YmcN3u+kGCs5zm3tpaRU1JXOLD/viDuT3mJzb?=
 =?us-ascii?Q?ocnawxUXtvdPJN1xB/blS4IgtQwhK1meHAm9tVHtitjd8MSuSBNOvGLrE6CZ?=
 =?us-ascii?Q?4+zX3/UBbgaPYvk7w9OTIUHnq91ywj+Zd3WWwjJS553tb2ZQLSp/0gK+G3SE?=
 =?us-ascii?Q?advUtqIGQf+Vhc1Xt4WAHfv54dvPGYy+JheZYBP1FybulYte+58UQpb52Zoo?=
 =?us-ascii?Q?59oGtL0q2TQlceBRSZOQUvnXKRPPPWvMNeTgk6Hw7PaNZxIbIpUDPnL02TLT?=
 =?us-ascii?Q?imHIh+acgtXxXZl5Ka4GCibN4I/+lzUgQ84obRmsFQpksbxTlEB174/bfIQa?=
 =?us-ascii?Q?QYGrGV4L1FzMk01ejCThBtUSkqpjxi/MN4Z7i9Cv5Zy00jz7XCFPgD5qw1/v?=
 =?us-ascii?Q?ux/FaBqXGpsSYJRsbeM02bnz3Z8JjSBOHngxu3J7EvH/rIU+e0dapiErOzkO?=
 =?us-ascii?Q?MrXDHQLRbsRig/4p6UCYeuYWWoxBSypLbOF+GZUBDA8HJwedWzMxWDQaUTtU?=
 =?us-ascii?Q?YaxsLZpzx0888Ly6oP2NZTMxVw70oQLlxUNKiF3i1nEhJhnrf+U24kdA2EOL?=
 =?us-ascii?Q?wSblBN6fhhYGzAyTpLakLsLXVj+RGslhbiPjk6SdCCwXGkU2zKJxtN3s90tb?=
 =?us-ascii?Q?KD1EHCh/8h/6E0QdDC6hoOndMQf/G1AgbQbJceHCLN6OrZV2mZlfhWprBN08?=
 =?us-ascii?Q?5SLL/pN44ZT5pWGboITveOnXvMxIkbHuYt4Z/XiQsL1Zy2elRD0wRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dxgi1idl9NpHEj80qzcExGZgNvcrSOwFHtKKR9/qO80nEUh+3Q6EsWU1GblV?=
 =?us-ascii?Q?SjCvxcqrlf2Iv1dPMK1z8PB6N+h0lTAEb0FaQJ6bThgvkuqIkU7qWn8SrptT?=
 =?us-ascii?Q?JOIyzxZXG0rRgT8Mz3ceXZjewOMYbGHH5imxcbnQMj2UxQh1szbo4hV8oYwj?=
 =?us-ascii?Q?j6Nwyen8oOFFTNVwoBGgMChN/g2A1JiwJCc6Bqvfha6y2bWa/BQBuwai1ZPl?=
 =?us-ascii?Q?pit5rVFfJ7C8sH5EQp3mNngSCW2JbI4gqoMK84D/m2gDhtQQVgtskDDe9d3T?=
 =?us-ascii?Q?0pgI4Jlcj2+QhxhFDY+bAfTM14lLsnGzpxSuJcyauaqWjdHqjaWG7PE0A82N?=
 =?us-ascii?Q?twXPP8h+qVmbe8slFcVq01qlzuxSOOZ8hgjK6rcf9/38EuPyjxSWLnHMKeKe?=
 =?us-ascii?Q?SoQl1oHgFgU4SJzkKRsWaUnL7KYlm+63DVokx6CEwG4xpUWc0j24bkfJJese?=
 =?us-ascii?Q?nhcNTxM6WlUUPOhqKYI6LxaKeTZ2ch/8eyBsSukC/8DeVCKKSA5DigOuSBxx?=
 =?us-ascii?Q?JC7IFamMLzOCDFyZTSCUOQdvXufJ74oMX0zZ+ZohyZXrFwrUC+XWefwzAXcn?=
 =?us-ascii?Q?CdgKFJ6fw5O05hjMzJyVU8iMTe/+UAJo23m53UBphKjS9DE+vUigTOMJupWI?=
 =?us-ascii?Q?F1DzuxVhwdBac/hywMtJeoy8jBg8qpUOuTP/2hapoTZhIN+SNQP2hAs3aK9F?=
 =?us-ascii?Q?UWHF+Bp1+m/Qoph5tYnMfJdZGMxTxVRK/1OoWb2Omr9SfHpXEUAPBw8o5Lhr?=
 =?us-ascii?Q?QcZB6o0X+p8Pee8MdnDtj738W3uu6hUlVExQ/RmMizEptGzkz49/PNSgEsRf?=
 =?us-ascii?Q?kDJVu4bju6Jv91t4aVBrXLGERk0bzD1+/LWYHF6+ZGL8ZYOcMiU47LFHfLBP?=
 =?us-ascii?Q?HmT8hbjGK/6gtDsZTqn3pcybrywTWvgcv37Qeqqs4I6IUTm7IHRWFL7GOj3y?=
 =?us-ascii?Q?zZKkyV1zK66Hkgqcm/2AwTFQsUBFLH14iUxJQTr2JY+qVQNd4w5E64txlPkD?=
 =?us-ascii?Q?uPR1K2KCGSo767BBdVfv4a0kQj7+wBW4SSRl9gJK1C5+wEucaee8CY6q2fkp?=
 =?us-ascii?Q?NJLw9vts4i5ZcOjEshbnRxao7tTYNSfiNhYxpvdDqfM3oYiFpx5myjPAAtIA?=
 =?us-ascii?Q?VIgSge+QLyrEsYJTeL2RRv/ichqww9esgZ0qnWMtQZV/uCHevUrCs/yoXzJi?=
 =?us-ascii?Q?du2jlG3wh1cJ/3bmYIb9HavpIEtCVmM6nY2g/tp4Hlt2kG5ez42id7uWmJJL?=
 =?us-ascii?Q?JHtVTL0UfC9g9VbLlmawqeNftqHviH5WT2cyDa8gvwp25joUIlJkjVHL3cfq?=
 =?us-ascii?Q?5nJ8outPwwVbdp8dA4uCyIAbKxUwaCY/VdI9SeKrtQ4sk2WLsF4FlVW2r7UE?=
 =?us-ascii?Q?UDNbS6C1vaQLblbpQxmYxFuDdBCNL1lnue3aLjvd43d15WxRgIf9NchbQfLK?=
 =?us-ascii?Q?4ebGZ6fPRmTPHUOIU9pVeElIznnTyav8lnawli34vy4dcTQE8/pt2KX45bDq?=
 =?us-ascii?Q?EhC6u3Kjykks/wVbOkMF/O2tn4DN6eIqqMxy3LSsvhj4ZNfHAt/GwnDUFHrR?=
 =?us-ascii?Q?4Etx3BJbllXwwoD4gEEQfYRcIcJNdckR+FA1uIUqFsz71W5M7DHU5sXYf9z0?=
 =?us-ascii?Q?+f/1g5Yiao+aV8T+WpFXagU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6d356c-f655-4407-691a-08dd8d23fcab
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:59:46.0635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfP/oAa75qgf9cWw5GQpi3ggUaiurDDYjl1leXGFhIMwmbtZheMmOI8/vrukw3Z3BgBWnLU8MEpY17ieChyKACMCkJ/j4bM9si9uPFmifDqvc1A4cKEJzmEIWZXYgbSm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/pci/hda/cs35l56_hda.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 6f8feac8c012c..145579ebd99a1 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -179,7 +179,7 @@ static int cs35l56_hda_mixer_info(struct snd_kcontrol *kcontrol,
 static int cs35l56_hda_mixer_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct cs35l56_hda *cs35l56 = (struct cs35l56_hda *)kcontrol->private_data;
+	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int reg_val;
 	int i;
 
@@ -201,7 +201,7 @@ static int cs35l56_hda_mixer_get(struct snd_kcontrol *kcontrol,
 static int cs35l56_hda_mixer_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct cs35l56_hda *cs35l56 = (struct cs35l56_hda *)kcontrol->private_data;
+	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int item = ucontrol->value.enumerated.item[0];
 	bool changed;
 
@@ -230,7 +230,7 @@ static int cs35l56_hda_posture_info(struct snd_kcontrol *kcontrol,
 static int cs35l56_hda_posture_get(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct cs35l56_hda *cs35l56 = (struct cs35l56_hda *)kcontrol->private_data;
+	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int pos;
 	int ret;
 
@@ -248,7 +248,7 @@ static int cs35l56_hda_posture_get(struct snd_kcontrol *kcontrol,
 static int cs35l56_hda_posture_put(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct cs35l56_hda *cs35l56 = (struct cs35l56_hda *)kcontrol->private_data;
+	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned long pos = ucontrol->value.integer.value[0];
 	bool changed;
 	int ret;
@@ -297,7 +297,7 @@ static int cs35l56_hda_vol_info(struct snd_kcontrol *kcontrol,
 static int cs35l56_hda_vol_get(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct cs35l56_hda *cs35l56 = (struct cs35l56_hda *)kcontrol->private_data;
+	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	unsigned int raw_vol;
 	int vol;
 	int ret;
@@ -323,7 +323,7 @@ static int cs35l56_hda_vol_get(struct snd_kcontrol *kcontrol,
 static int cs35l56_hda_vol_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct cs35l56_hda *cs35l56 = (struct cs35l56_hda *)kcontrol->private_data;
+	struct cs35l56_hda *cs35l56 = snd_kcontrol_chip(kcontrol);
 	long vol = ucontrol->value.integer.value[0];
 	unsigned int raw_vol;
 	bool changed;
-- 
2.43.0

