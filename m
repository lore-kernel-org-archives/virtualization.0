Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010047.outbound.protection.outlook.com [52.101.228.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42B1DE2BA
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593961; cv=fail; b=PO2zYiPXYXuU3u7RidkrB37L8DVIQ8XFno9TeTGqdWRTYELMlvUG9WGFZzpJ7qXf7vO/Um6Sg6wiXhNs92z7blGFovJ5eKyZdIoKaRgWn787Cv43SSqbnWbHKtsuZ4IUhhI0sO6ibC9/mL+jvceiZheMFGzs32MbWVTdho5A+7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593961; c=relaxed/simple;
	bh=Nqc6EG0ktQB9ORVhRxIXmGJsCEQ9SqS0R8Mgl93Mvp4=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ObmS59OqwMvcgusDxfY7yu/Ny2mh67OVOqdJ4bJqwN5xL+DkJkqn5v679Pi7HA+742EzNX9Vxj1mr1B05EQygfz0ub4Bcq/3eqykR98hanBUy48OWmqcMGDVgk9zZwC5YjhfR13yfd17OOxsY082WqU2d1wAdevXLGBqueNpo2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Oh2ZLfsR; arc=fail smtp.client-ip=52.101.228.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Oh2ZLfsR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF+MeJA1vvo6UkCHlihiXavaam0oNAi1Hu3aW4hlWF9Aoy+kyszQ8OtrsC8BLZG57bI0e+3vRN2n1IhgFbMwe1Z2uQPp8L1c+MWY5ezuV3rHICTZWxexi/4l1U+RxJJflUf2FRXLbGyYMsxQGc1VuhJWJI9BYEFloJiX1O3CERhhvjzuMUTx+LLMj3aS/ttrHpgjw9kR8AEz2LDpkZDfCH73UT3SReZz2bGUnv/zjLLrhhAHaTf7sLQ3DD0Fb+aghTW2KntNBMrxfmGRYjnSAIIZa6bbzMC8Zrlib17F7KxWOrDPzRwe0bk1zCdHHKVy8YmZKTMrsxRDOA6/BvlR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvatSJvynbru8rW2GyVXE2SHdlv6MevDnSo93u1BYc4=;
 b=aAWvgGYYcshfI4sROgNG16Wz5BZ4fYIx5zV3B8BMDFZt4uMzBGLpxua6Fd/2b7KLo2blMjERjVfdVVwdWRxFkxvwXx9sQbfHpaaxk16SZon3LCe09mcehzI+nCdhm6KDaP/qIZaR5k6GdUfCsvCxjvGmb05frhwXI3sux5HBHepOfk3z1U6EbnvszD3BOTdcqrPbm6hTjChE/iH/GbV/QJ+aJ9jCu/bgNQJEKT79e876HFcXojfUQeXHk2wS3XyE4rRKi9d9qQFm6YdLmPjysNcFzyqh8ZzizlLCf1t2Rwsu5I8IkAULFLJoRkxcVgXQ1jGgiuf/ccEplzmHDuLzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvatSJvynbru8rW2GyVXE2SHdlv6MevDnSo93u1BYc4=;
 b=Oh2ZLfsRmExc9XykOG+2J4bZXui89ZiUO3+ThyV7BNOKYXZ9Pf+60QsxeKFNIHY8Ju9xx5wMMxvZmEbgFUKivAWaeQFra6Kap32oWmLmTd36RmJvEusk1F9dmFl+iW3E4fT7txn0rcH0YRJWlqVHLycLJ0TetUHTrHeyWgmXEWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 04:59:15 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:59:15 +0000
Message-ID: <87v7qdaue4.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 01/12] ALSA: sh: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 04:59:15 +0000
X-ClientProxiedBy: TY4PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: 0598fc91-8279-4881-7abe-08dd8d23ea84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxljtCv5xu3imZJfII7z4mc8wfRT5iu3rzxlwQaD+tAHgtdSEyEru5Fs9TyC?=
 =?us-ascii?Q?fBVld/9qJI7qf0p4xjuEjkNmeX/+7fEL76me83+MJG+WurArMCGrqPGe+bw9?=
 =?us-ascii?Q?FrPXL1UPO2fnGyjqqknskNQgNO6m18/eUMLZWXJwmEpq+P4zIZvw99E//s1P?=
 =?us-ascii?Q?yAOyiXB+AXTHbCRr/rR8eZ0SHRb4lUtl+2WGqelCuOyf3BmPkUcp74Ds98HA?=
 =?us-ascii?Q?KyisFgB1oIYKS0mv5B1zmo+ZwUD+eCiaxd9fs/VifTg4gOfEJDCeuAABk9B3?=
 =?us-ascii?Q?YcRgw/s142Oqw+ICVM1wdbNeIrvxS5NsxW1TpPsO5+LogUgESzdBbhav8bNG?=
 =?us-ascii?Q?ibKcWMUJc+uMTd1ZBxOK7z+61wDaYtIzHNJ7oB0+ANWV4WFO/CklWNt0q/h1?=
 =?us-ascii?Q?WZ9DzTmZIjf8gBH0705tuEDMjjfOFodri85gq0CnBRy00Jmb91q01Y3Ik55J?=
 =?us-ascii?Q?mNHTgJNnPXVPpOA8vPUec+iQ1k9y7zQZumRXo0tOPvDVmo1/bVsMHIR5KsRF?=
 =?us-ascii?Q?BF3yW61rhtBqQnbTTJacwPpcDqidTyBC6dg2Zwe2Q18Sb7iNcZS1LiYkN1+L?=
 =?us-ascii?Q?/r0n2wJmUWbjxr+zq8HkPdZWW4rvUw56xJozSub8q56kVRJ0bjX/dHBVX9/t?=
 =?us-ascii?Q?vhAfqCgFtpW93pnUy5FhXcdKn+8l5M7ve5KaqbqNVBR29vgEGypgLeUmPTAQ?=
 =?us-ascii?Q?ppHI7MgKgZrr8PFUVwYTbNE9ODWsKFN9JYyOH6wjzhG9f0cjhpbNLonkAFk6?=
 =?us-ascii?Q?KtJ1AqiOvATXDUyQctlYy7flgCzkTcKbJX3gmrFYW+1/IxjdiHHVcBbAwFmv?=
 =?us-ascii?Q?wKoVQC5WGw9zVz8hYxmr9HGR9vdaAuTRNFySh4bOyORWzNmyR9289/gpu/VM?=
 =?us-ascii?Q?JWcEWeAvxCre+MZQ7ooDJ4uX6costA2RNx2BaX3IdCuguFl0DGleY2vXzq1m?=
 =?us-ascii?Q?MCTNfTDrk4C9Wo/JQvfTc4kp09csQC6T5p2q96OoSYFfHnOnvO+E48XheWSz?=
 =?us-ascii?Q?aLmFJ0QDNPp1V8CNnjR4M62axyMPBEdOypM6K9jpUXodt/GvaG/Kbqg22AOU?=
 =?us-ascii?Q?eVCR/L72JRUUfr9BkvQa6xTQ38PYEjnTp6pGlzV5zQnooG0Qt8O8dy42p6F3?=
 =?us-ascii?Q?5HcTd0viDEvf6Gs3F5nTv55cMFkQQr1Shs6x2ioGv6L1lYUR23aLIeFbuW2V?=
 =?us-ascii?Q?NexZ5IwqgZBFnS9haI5mQy7EfomNYeuWQQsnHfTVEJHfn2GD2xeJ+DftWPxo?=
 =?us-ascii?Q?8K9Eon+N+g3xq3gNuFqQFF+VMExGftvQ/bP5bw9FjvGc3Mkkc+rFDCyumbHi?=
 =?us-ascii?Q?vnD7QiPARDc6y/YIV9E0/u99jyOgVBdbmnjxLulkPTgt+kne9OY+hyQAuvn8?=
 =?us-ascii?Q?UdRT1TNgzllnOfmOEuQAEtr4RtRheiWWO/llfje2D6j60olQs6eg8nE1Piad?=
 =?us-ascii?Q?+G6kPIUvWpzqrcwZBdP3ILI5GZBmcjehV0fT9FD268zLIySjmdb8cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M9UE5IQnlkDyv0TN9drCibrJKaUrYuPSJdWr9X3jNwhmBzrQblScKjTT2QFA?=
 =?us-ascii?Q?27rGgJINQQ1CPzizj5lJRHZEHSngbMNqH1JAiaZ6AgfHHuPP0S7WMgTv0N1g?=
 =?us-ascii?Q?Q0+ygsVguoCgEesbM+ENt9PUvkmPpraKucynQDr7ksrz/3hkCc929GBYNqwE?=
 =?us-ascii?Q?VDAzaAjlMVbGA/EZ+zhgpImRddcPFc6nipJWXPtPu2wazWPzvgUnH8Dhdevp?=
 =?us-ascii?Q?1KN4APBiGbui4lghryAnVQ2XwXPF4jOQei6a9Z9448GAky/ry8kn/1D1BxZd?=
 =?us-ascii?Q?LvhX2rzwFzDjIEIlRTbMc8/BStSegfiO/jCAN41R2xJs7L5V6Nr2oukHJg+j?=
 =?us-ascii?Q?8/bRRuGGthQb98fn28JTiBl/afvOxLXhoZQ4H6T3xqGjzIXqAGCcrBkAbGPw?=
 =?us-ascii?Q?SpbtqDPLHdzZRQyAQMGbvpsFqTMx1eUOpnInJy1RwkYtJq97AxfPafWDpuz+?=
 =?us-ascii?Q?RDyayeMNPmFXnx4UfK0T1Eg8WDH2A3sg7sbXzU4VhFkUN0BA1QfedO36vPKS?=
 =?us-ascii?Q?TlShiannMLAZ/uyVHB1iy/WxJijzxHdN1UZS2P/7IubfmXKrrergDH0vUrv9?=
 =?us-ascii?Q?U7pkKec6Ppdb2B0+cFKLXiOvNSNw10hMYWqqLmgfKRp/mL6/p1/76aJBbFd6?=
 =?us-ascii?Q?co9pG86ZoKrEo7QNH/LFZpjXXCP13yW/GyhoUnmrdA3gAPHF6m12GkkTM3DO?=
 =?us-ascii?Q?LRvo4XApVGGF6jK36kep8WYWXsUbWPh/wi1C7JI863NmatzVo8UPwSqX9Pqn?=
 =?us-ascii?Q?OC6EGufD2j20bkLzzX8Hu9Hhye+fev2VTKZYR81uY2p9JHFJBgmZpprmLIju?=
 =?us-ascii?Q?j4qWJYCClM/tKUy3ztmzX3fJaJ6HYg8kOQ6TQN7iDfMLh9kkG6Nns/ehWv9X?=
 =?us-ascii?Q?GEz7qhiiaZWAU5FwXr0bJaqDcOb11h7IKW6Bt9osYLPXx3x4ed4CPdOuOyj3?=
 =?us-ascii?Q?7+lMe09OBoGJSXTx2YByVC2rqnCwHF/345UAutAWysRAalwTkjxSEWYmBYQX?=
 =?us-ascii?Q?1QrWenuFyaY7P1gyFUN/YMtiMuMNFNxxlac5beMFgghENJfBChRfOPVm4kWM?=
 =?us-ascii?Q?fqas14LMRpyI5uz8XZlAzBeUpX2HeMj2OtyXSisVx4x0vYH0NI/LWC3WQ0Qw?=
 =?us-ascii?Q?nxLdzaO2ZOVDGijlzYTy01BsfOsssRaENXRrXU998W9rTYMYS/oSpACE0LXH?=
 =?us-ascii?Q?OlDO5ZYaHAX1wjOkoXab/3Crre0O1ARZndOHJzLGTZav5hgRgYNCdFnqBCo4?=
 =?us-ascii?Q?ekR/DN6qwfpHeXuAi/FqDW8JsdUdCFYLwqBofMlElivm7qt27xgKXNeJ70Kz?=
 =?us-ascii?Q?SdmhAFnq+VL2TYMd2Vy6hNBa03NsIvMEq6ykmbVN38SFpTwMjTDjh3SyF054?=
 =?us-ascii?Q?81mcQ2nvYIzKyc3jSipTkzZZWxBLi/6aZnnrPCKSkXme8TjiM4OJW3fRMIrU?=
 =?us-ascii?Q?xdBQiUEzmAL6g1e5OagRVaL5UqQEYceCOHuH2MPl4ngCDLP12Ar2nvo0KIn3?=
 =?us-ascii?Q?7o7zd9/UrGf8lNPqhaUm/TLVvLf6CnNbBqMgLVL3t15qmy683iPHTkeQgQZB?=
 =?us-ascii?Q?ndNcRsSdphqzdGuyZmhI/OUL8rtduKQybot2H1fbNMWbep8IEy8HaeoVO3lt?=
 =?us-ascii?Q?tYdYZVwbro+Kt8uyhHhx9RQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0598fc91-8279-4881-7abe-08dd8d23ea84
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:59:15.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5oVcWak21nmAy0NyLyVgUmCASjC0tY+5Ca+hym/n6901T8aBx7CtmPRnc0yESe0MUIT8YyzMPQzzHrWdpOg/+LxWXxjvopqAJ0rQJ9GekVLxAcYtNnuCSm/bnhNOOhe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/sh/aica.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 5a93f45873563..f88331a486381 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -469,8 +469,8 @@ static int aica_pcmvolume_info(struct snd_kcontrol *kcontrol,
 static int aica_pcmvolume_get(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_card_aica *dreamcastcard;
-	dreamcastcard = kcontrol->private_data;
+	struct snd_card_aica *dreamcastcard = snd_kcontrol_chip(kcontrol);
+
 	if (unlikely(!dreamcastcard->channel))
 		return -ETXTBSY;	/* we've not yet been set up */
 	ucontrol->value.integer.value[0] = dreamcastcard->channel->vol;
@@ -480,9 +480,9 @@ static int aica_pcmvolume_get(struct snd_kcontrol *kcontrol,
 static int aica_pcmvolume_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_card_aica *dreamcastcard;
+	struct snd_card_aica *dreamcastcard = snd_kcontrol_chip(kcontrol);
 	unsigned int vol;
-	dreamcastcard = kcontrol->private_data;
+
 	if (unlikely(!dreamcastcard->channel))
 		return -ETXTBSY;
 	vol = ucontrol->value.integer.value[0];
-- 
2.43.0

