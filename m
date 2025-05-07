Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011028.outbound.protection.outlook.com [40.107.74.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F71DE2B5
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594003; cv=fail; b=n6/Ae4/CXbKBebDdDbRSWJPezsBsf3WmJbW8c8xUspfnQanaAsNPLuipDtnMp9qZ0ALT5DofGKyXGBKjqOutISNJ55oNBYuk9WbdVz/A3oFV3AtciSPca9S+thAzZCjdn8dG7fOZ4mqmIOyX0AU80Nk4tGKYputzi7v9sbYfJHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594003; c=relaxed/simple;
	bh=R6JURpNch/kbcUzEDikwJQ/KwM4QnBUtHw8x1Dj3quU=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=pWRLB2VktclxBndzraJ/3PNcgi/Yx7CDpHRfu7GF9zUB6VwZ38LIBYyILrDjduUWnGYvPs069pcK8Kf5yWsAZvY2ls4016MxWFldIMWT9ro08/1hD7fj8+XWbPwTTvjz6X7RSv4TxN8JuSX+RxE0PFiN/g0X2y6+fndXdRGR8Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Vux73d7T; arc=fail smtp.client-ip=40.107.74.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Vux73d7T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmRXRd5PqKvKNNuB3f16h+5e9U8JMpxTv8J3N+etCSbuEiv6WxCvctS8HT3+Mfy7VPgFNotvBOmeEMIy+xWiDiqu4v0e863axyuTnY9twAck92bDY+XCac7F+G6ztDrSpsX2qxOeyj8tS/wIRhSWZwru6M9C1Epn+dXXvnq/+E6OBVNkfHbaFVB8VuFb5Kq8mTmQEQB5SdKOCUKi2w8DwGu94mlDWmc0BYwSBwT/k+s6tTjv912XXwI2kSO9UFTPH/A47ZyJQqsPlJ03BR04tSetZuHSIdJgh521897ozrQCqwZirNnfAw3m5emOq7wYZEt4IGsCXnXkt+H33KM/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKx1xYRNTMKcSygMMKitdR2wlwyvnSrHSgYPRGN/k50=;
 b=dg3H9EK6ty4RDtUXCVEQJioh6ei5rb2pesE4jqg3GIZvHGfz3IP5KyAWTOaWimeVtUGF6cNUZYSAPHkuQOBm2u8q29UtvCvCUkx33q58LlUMoWTAHe8WsvDFLri+/fJXJeJVJUnyby5AdCcYwFAoclQSWHTzzi0CZr42ToPhnA9/duHJsn2Bqrdt8taz6INeZM8nhx0HWYsCSz4wEXhYUZSxdx1jtNuVdPg7oNKtCgjeOHorOl9SVPd3/Fq2o4nYnXM7M3LUvfnanEradNJ7VnRuSkw8AVjZEoWeCRnV0/7qEwNvFFB/Pef9WQ0s/Buookjx1kDBAxTpoptPAW06MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKx1xYRNTMKcSygMMKitdR2wlwyvnSrHSgYPRGN/k50=;
 b=Vux73d7TIIwAYcSZqm5d+W67oomY9gYsX9dsoOx6QeTsrh+nnjlj+guJdxPCLubpZj3eDV6Rd0RyGWvnQU+xMb+SyWbPgllJmfh477FKdTXK7Q1YvDPJoqq6zIHqxKLxX51w/T9ko5cMrvUx31ykB3RhlYzDtnCyr4VDqJEeCJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 04:59:59 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:59:59 +0000
Message-ID: <87ldr9aucw.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 08/12] ALSA: pci: au88x0: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 04:59:59 +0000
X-ClientProxiedBy: TYCPR01CA0173.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::11) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f540a4f-533c-4c6c-031e-08dd8d2404e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GZXOZ9dj7tUrYjJf8Wk/DB8O7zHKu8rZ3rYBI7fj2rwODXEZqD045iIY2DIo?=
 =?us-ascii?Q?DgS+N0U0mCHDGShr9WXMeM37YoffNwGXrrHJaRwloEVs1Tq8B8r56CKaQyut?=
 =?us-ascii?Q?lA5FdpFLNXd6hgRrjvf3Pj9cnSWXth93l1zTtZ/oGx5TTbo7mc0V2l51534Z?=
 =?us-ascii?Q?mkec1dbe2tEhnjMW0O/Xlu5cuCYoPVsN9ctXm9KtbRmBAxu+dTT5Up4yLj7q?=
 =?us-ascii?Q?/yWUjtezJyEHu1L0hDOoxDiRsfj1xbByzp7nZj0NBHBuOs4prx1O3g1rqohL?=
 =?us-ascii?Q?RTBm1AXJivy9Zm4c+ExS5uwgGR2slxqWzyhjlgw0OM3PkXkOCKWr1xVRmqCe?=
 =?us-ascii?Q?LahIsDVxREXA0DL1slQozdzLSv1ZkiOeqhgfEm/sn1NTPdpwIqGluoLOG0Mh?=
 =?us-ascii?Q?L2RGR0V2qGSWhw5J4rnFm/lIkkQVqJ+7zj8S6Ijm0+Vh4dp7QtPLRLJlAja5?=
 =?us-ascii?Q?tfPMEKA0a+KY8fISXcfAIUaRaemfGBVAwQC34ayqFFCtPRvYu7WZ2fODgfR+?=
 =?us-ascii?Q?NNiaOD4hSw1dwr428JdJOVSjvcrYlL+4Xypz+Cml6cT+frjF/kwQOv7ICwCN?=
 =?us-ascii?Q?8WerBOtwwbOTK8CHBkjTWvacDh7C6C2llt1WGVQGsZAV8Q7meqYeR4BJ7Cpd?=
 =?us-ascii?Q?kouwNR5E3gswhTnsnNfaoHgJYCxRa4rOz+7XjmLSXvITKRHc4AEsOdCitBIl?=
 =?us-ascii?Q?kSA+fJAcgO/2UlVTfn0bUh6Qu34ILGIndYanV4JnYGPzw0pKDgOlZn2MOfAm?=
 =?us-ascii?Q?fTFnmMvOmv6S9JDN3p5lhx1VG+M/4ouq21MI52SWCvcAiqVl0gbE976SkwjZ?=
 =?us-ascii?Q?4vQuPzzWcdCSmzdxP0aXfkNdWlrhFd8cusprn251ZWfFd9SrlK5qgD3K1VKv?=
 =?us-ascii?Q?TlPPgqVXjEJSPpZyBcSBDx5TgVp1qJ3u77ynhmW2/AbjoEcBDnfBsBPBi8vr?=
 =?us-ascii?Q?lFnnYJQ4UrJRDdXG+odfTOyCQl6sjcTtuxJlDUNdOkZ2AxkrBuaVudaAEdLL?=
 =?us-ascii?Q?FT3z5Tc/5J5vwF3Kh/oIP+VeLeD+ib8PosMQxEg8C0m3KUOiCgZZ58H3bBMc?=
 =?us-ascii?Q?P+zF9GZAo3O5YD0OlPL/y4TkHFOidrfCGcMiUCuv+k/1AKsIEYNu7bGDaca8?=
 =?us-ascii?Q?aRRpUPOH+35rZwY+ELy+Dp1gligiV+Gg+2UAvUJdoAjGBQIkBbeP6HW6UMlS?=
 =?us-ascii?Q?2/JyhavqOIyC7+Bdu51xhXIRX2KN8Aqpm8LoOn+4czJ5asvHB4LPp+VkDChd?=
 =?us-ascii?Q?c21lztZwOe1wVkbrvRKqNQD4VOvw5CPXieog1zJVj0cOiW3dLiMugYVAARy8?=
 =?us-ascii?Q?bbZOQ73fm0Rkv8CnjvBJ6Ua2mxMZ28Kn4stH6J+RMSQxEli85hwV7Fv6FhLp?=
 =?us-ascii?Q?ArYdswmLDrjuSetArp/qPWZI1Y8Nbu/q39q/O+OF0xvBuxxxFw6uEaLAG0XD?=
 =?us-ascii?Q?k5snaxKjTZSQUThEk40qvSwO77lGEeCl/9m6sc11u9zi7dws/g3ynA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?97K+ZgKpv1XqijMGJ3WAEbYTUGZ1nYIne4PDBXBiMpEt/KCJVCMbZTJJgKuk?=
 =?us-ascii?Q?dIcKmDCKRQNwu4W4g2ylcso/MajiPNSgcluplmK8bpcJe82wGdxn9shjU4HN?=
 =?us-ascii?Q?VC3r7ttm6T+vvWwAEV17+iIZzEL2yyvYhZpzKsLkTOPOT2cGpkma9g+ZKIAs?=
 =?us-ascii?Q?P8qHDBP41Lapk7/GPLcU2WT32YK60zd8zdbL8brOoej8Rec9iveGBUPH4HED?=
 =?us-ascii?Q?bpuWtjUSOLf1QUUM6l+Wm7lgA59S6yZ0Gx+47FmtkvNOo1RVGk1S7fAeXV55?=
 =?us-ascii?Q?1zOrMPmTNGiq5pXILJKMUHcwUIIN5HBf1uYu0E+em8Xz2mZ9EaT1adsb9CX7?=
 =?us-ascii?Q?8by9ng0nIQpgR2STeFELs2kbmLIXeTRiRLqKW8IM0+dvXhLJ+RFKeaRPL0ts?=
 =?us-ascii?Q?bni0ye3LPPg0jph5DmfeNIlusDVwCtHC4cUw6JlYDttPw/IfXK2hH410W309?=
 =?us-ascii?Q?/X8IJV74KOVU2+Hl+xbYZuvkiVuRJfx8sD3uR45j9iSrsk6ktDSdMaOEhrp/?=
 =?us-ascii?Q?SCUSstbuUZuuKYYAurpMzO0VDa9FCzWzEQXnl53OPW4eDhiQzF15u71B2gF0?=
 =?us-ascii?Q?9a1wAI0+u3dg7WWYg9KxsbhYs0WenUGUhrihJ6tAZCTw4kmnGvYiB6Mw5HGH?=
 =?us-ascii?Q?S9bqSxzBBbqHPv0qkh3ijyE6C4jGhrUnPlRNNL7Qm97LYO1m4a2du9vR3bFm?=
 =?us-ascii?Q?miyHh+5d1OudfaolaatnO52N8V1bFdONbi+SQG4M3xVdlVBPGUIsrXYPbfmB?=
 =?us-ascii?Q?8/H3vz/i22IC5YkFIf6engRBKgaDi6hyCAtmOV2gdEh61EYWtluI0yrhYNyh?=
 =?us-ascii?Q?k4BuvjXd80Ea4WXW+ghMEBzzqhBCw36ZWra5HuVfgX2LuyglallJUX29vsV0?=
 =?us-ascii?Q?QYrn3G4ZBv8xqhOWqlC8mj5ysC7Sv9dUSMGkujhF9ZuAFqRn1wZHZznReqQY?=
 =?us-ascii?Q?oh60077usVohlG1cfz7Kkjvur8jH/8832Zom2gi67wfKYjVDO+g+i851gdME?=
 =?us-ascii?Q?rtAdPkq75hMWc//L+qTa1pggSG/YZgqjljFy2phnzz0CPCNzOaehWphCaBmj?=
 =?us-ascii?Q?wAKLDd0NhwlcfUrth8039FD+Xn+Lbpv5AOmoc2xdV8k3oW0ckQK5gi9s7hpr?=
 =?us-ascii?Q?rSZqDEZLBfKhtdytGP1IszNx27M8a6iYnqpnyffTZjQCBjEjpSGA+OFCmRr5?=
 =?us-ascii?Q?BtgbSCz1eOWwhKge87wcF4jFm+SG0l8XzDeuFcorar36Vd7c7F9k7yfi22iI?=
 =?us-ascii?Q?icdLrZ2dqH1zuhOO9I12H0ExQUN1CZtt1JQXMmT97L9rFWNc8/EN9PAlqgMS?=
 =?us-ascii?Q?b89DDmrOf0nNliWJEVTlGOfERpHAFVWgbgbj+oRNvgBL8d2ou8BpkI1vNkBj?=
 =?us-ascii?Q?R7ddro/iyX2nXt86DKeKN0ke9XpgcEzFd3DUwfTlPIrfIemfIWeiBFiGfQuv?=
 =?us-ascii?Q?3UaXjsuV5bd1kn9qydjKspk3ZAWF93bYdX4ocwLnVtSKt5ugvZcVI/2a28Op?=
 =?us-ascii?Q?orGO1ZSYCfdq2tVIdOkD/tnfHeIclPzQ8H8KmjRKAvNrcyraA1FxYEb3Scrp?=
 =?us-ascii?Q?ohiRRswWIH1UQbeITvZ24J8BEkwQZQ/UI0X+YvC4TsIey3yuvQybDomhJeP2?=
 =?us-ascii?Q?ARK0ii+cAlvLVND09vEkFlA=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f540a4f-533c-4c6c-031e-08dd8d2404e3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:59:59.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5amrWpAD4zSj7BxVnme1A6gHdb/G14XhxeTgkNe/Q1lSMP3vPTVHkI4n71Lm5CMv1S17Iozx2kt7Luu0nL6+nxYrBGR7ogWhsp5RaYNsEvU5EMuGpFxstHZbR1EaHhCT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/pci/au88x0/au88x0_a3d.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_a3d.c b/sound/pci/au88x0/au88x0_a3d.c
index eabaee0463feb..d5cafaa229f10 100644
--- a/sound/pci/au88x0/au88x0_a3d.c
+++ b/sound/pci/au88x0/au88x0_a3d.c
@@ -754,7 +754,7 @@ snd_vortex_a3d_filter_info(struct snd_kcontrol *kcontrol,
 static int
 snd_vortex_a3d_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
-	//a3dsrc_t *a = kcontrol->private_data;
+	//a3dsrc_t *a = snd_kcontrol_chip(kcontrol);
 	/* No read yet. Would this be really useable/needed ? */
 
 	return 0;
@@ -764,7 +764,7 @@ static int
 snd_vortex_a3d_hrtf_put(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	a3dsrc_t *a = kcontrol->private_data;
+	a3dsrc_t *a = snd_kcontrol_chip(kcontrol);
 	int i;
 	int coord[6];
 	for (i = 0; i < 6; i++)
@@ -781,7 +781,7 @@ static int
 snd_vortex_a3d_itd_put(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_value *ucontrol)
 {
-	a3dsrc_t *a = kcontrol->private_data;
+	a3dsrc_t *a = snd_kcontrol_chip(kcontrol);
 	int coord[6];
 	int i;
 	for (i = 0; i < 6; i++)
@@ -800,7 +800,7 @@ static int
 snd_vortex_a3d_ild_put(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_value *ucontrol)
 {
-	a3dsrc_t *a = kcontrol->private_data;
+	a3dsrc_t *a = snd_kcontrol_chip(kcontrol);
 	int l, r;
 	/* There may be some scale tranlation needed here. */
 	l = ucontrol->value.integer.value[0];
@@ -816,7 +816,7 @@ static int
 snd_vortex_a3d_filter_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	a3dsrc_t *a = kcontrol->private_data;
+	a3dsrc_t *a = snd_kcontrol_chip(kcontrol);
 	int i;
 	int params[6];
 	for (i = 0; i < 6; i++)
-- 
2.43.0

