Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011011.outbound.protection.outlook.com [52.101.125.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBD41DC997
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593976; cv=fail; b=Y5Ve4HUpeN/37RusFTrcPMF9iueKd+RwDywnzlVtsaNDeDHH3J6EkaMFwWKtyjBy/W2KbDoerohibBp4aP4Wjh9NrhaoF+LpRWKXP3vhStfXwVn8XhHyflO1grgTRVebyYsuw6fuXd9yQRt0MwI2DG289Z+ASK1bZS0lHF4R6mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593976; c=relaxed/simple;
	bh=0MHxezaRVFAWQ69tH3oMSR+/H1Nna/1npYItIWeRIIM=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=cnBEgoIQz4ssx5Zwy69UbD32g7796q/t3OON3GVx3Mm1rVTFf0yA3fIJ2Qw4oyT7EWQQ1xfO/L1WN1MUG6n89O9lIsB1tVo2KriO7eowVnMFkpMt96j0Ba2Zzd2Z8to/fUu4EXb6ePzjCE80Q28EBrTnl25NRiizzi9zhuvMGR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Xdvc3tYk; arc=fail smtp.client-ip=52.101.125.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Xdvc3tYk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndPi2uS6D0tuJE0stJmdIB/HogZ+a4Helka+Ar0a/T2mkDsHKZxTfChWK/b7l6od8ZD5qFoLLjcDL5hj6bDES7nYXNYa30MGl5AvFJlU8BhTetIPPUVfpjTu4BfmOVtTm7bsHFMJrhqSRmebVSbaUxYQM9HzaLpHz/5BNGW6zAFwsK7RBbt/eRUd9dHOjXFOhL8vF0oZOoF2D1kaGYCWN3eQPKF4LRvTqpXGZZw8wqljVbZBwPRNcheAMUdLYtzaGSxDCYCtkH3FbO6Bdm/K7kezgEnq5eex0sejenPOw6vIuDoHrWiHgqKQZgKTCRnFRXOcoH20IW/Uq4l5orDe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06aqCudzFZ4ffRcMK9dkUf8gCW6q5ar7Mwr1/Ruy/zs=;
 b=UWYoFVpYgC947Ut+3hpy/lqtihOvZPVSjL3JfqoRTe7O0CHrDihbQoSN+ykFIhUhylpFwrxR8gPE0svd6Ccns2/6KGBZLfc/VKfk1bfs3zzMeQCJoaMSp9ZIvbHddtHsQKxaC3CesfWmWKlMzlUmTIgGJa+CM8awiUjBc6bV5L0Yt6vSk+rYLBBW20QjS4KJsFtzsfZBlJMrau5AuxybliPEajiwU/4DItyGtvqi0Wv55qoNlp8oCX3mp/X1fAoIGUdxw58HypmW17AgBDSxYr4cnaPlo0Dxnn6aIKo4cENyCAQC07HmVfKHGqaa7GmeeNPbUiCkQmoXDUPW/2gCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06aqCudzFZ4ffRcMK9dkUf8gCW6q5ar7Mwr1/Ruy/zs=;
 b=Xdvc3tYkRhVKhSlcZM8j8bAkSot0wBu9R9IJNe+BZRuXcmqXvDf3lgUZUaQuqnSYKPk5AhIB8+NC3sBm6yEXpsQzcEThABr0CLK7B2U8uI0EQnNxDHBFqSBo/nDvIZYZxM8413EqYVTcezO0uO2ARt4r5WYQhyKzbr4hHue1KZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 04:59:31 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:59:31 +0000
Message-ID: <87selhaudp.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 03/12] ALSA: core: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 04:59:31 +0000
X-ClientProxiedBy: TYCPR01CA0197.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::10) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: ef113410-9c1e-4819-ea1e-08dd8d23f3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+PRS0S5SVCC9n55hLLf97GfXJQn5j2JlE2TtsXR72uGiS7ctlZfYOQgQ5Yu?=
 =?us-ascii?Q?nwVrvkJOab8GHNECdeWQuDYyjmzF7gCLadN6PC0+Onu+Gx3JWJQDc0En7qgJ?=
 =?us-ascii?Q?zAw69mkrSeJSG06zMZmj3nEQC6dNC6xWx3Cp+i5he+gnOhiS2GlfYNeiy5z3?=
 =?us-ascii?Q?+JS1sPY+iXZ5Jo97cMgRfkQk/89ZtwM8d83/e5Y02VfY6oogXmMGmcI7HVWa?=
 =?us-ascii?Q?FWNbrtpvhDFpxyDmo1A7IE7pAiCyYxRnoNkfR6XPZBXyTQdhT99edX5y3WE3?=
 =?us-ascii?Q?BzGiN7VfpeyYMtBg8HqxmboejrBH6sV+QGYbWERtVAin0gaG6Tkbf7Euj17s?=
 =?us-ascii?Q?hujZyeIeTzZudYfi3g5bhZmb7VxAepaDKuJOExBaz1j/iO0iXugQDxukv8S0?=
 =?us-ascii?Q?W+gmQv5qwKVKHdEaQhp4nY36iyuL/cNnX48C/AgczPsqpidMCswlVaI59Jq6?=
 =?us-ascii?Q?UyoUe1PA+NctyOk27nWVl6CAwpCrDSyUx72ilIXi2dKzhxfdluJCu5N+YhLp?=
 =?us-ascii?Q?mG9z+/yOscQtDM2fsljNZCd/X2SUMnMhwPaC9KkgY3y8qiBc52Jg6IurTqZX?=
 =?us-ascii?Q?WWrrqoIpOQ5czIaci45Jmd+6N2ugOq0MBAm9oiNXABYDA714tuJWFbp4nIiY?=
 =?us-ascii?Q?Yh1M3JraqAJ3neRHxTdI4b28deTIaodTOtcn0DRVItYTGV094lqsmvTJKMLi?=
 =?us-ascii?Q?wLGgcmNyNIX0aZ5GWIK+8t3uzHT92ak4htMFOORV5At4wTbn0JxZr/otNT7S?=
 =?us-ascii?Q?hjEbsFp+igU/05ZQYn7+zghYOVG6EMr3kNdq4/Fh14zzoGP8byydmbDO+XM4?=
 =?us-ascii?Q?bTnqXi69tHo4NOagctOJJOvjG9y65jBFkrVr1glBzjkLMMStNfwuPVyd7Svi?=
 =?us-ascii?Q?22c1/ZW6Epyi4yEEhOXxMCJrqTeq9RR4pJtAOFYKBeKv6nFDqkYRyWrKm9Df?=
 =?us-ascii?Q?nTKOIp26HWmDmVoRvG/qjhKiw8VsECq6Yq9bOpVF66g8qgobPjH5YDEEbOOt?=
 =?us-ascii?Q?AuXNTx5mFy/yDK9IqNLVCm6CRwY3lxsww+AnT+E/LNuZUFNaGNn0co9uuKNK?=
 =?us-ascii?Q?ZyQXacl3IKjQb+q0kw7ZH9CaAuMTVIWvNGCzkWQlBX9YcwHHH3kctRlPtq7x?=
 =?us-ascii?Q?CLXHqaYR1ukJFOnIRH4c9tthslSpo8O+uD07Dvp5AGw6E0zJnSxqpXlhDn1M?=
 =?us-ascii?Q?5n5y//vcqcTyqujtKjFkyqw8+/dd8pRDEmUfG7NGpgs9UlGZo6Y2br+/s41/?=
 =?us-ascii?Q?tVSCWsjkTArMhAXfEVaICa8nW7AmG4QDTtIdB+/KDA3xzgtBOQ/SIPupquf+?=
 =?us-ascii?Q?VhhBH1H5VRvl9cXwuGY08W0hwdYgtowWXWuFVPOygTddOADJsesvQV8NKK9a?=
 =?us-ascii?Q?ezcE0vS6WpCChbDBAGZ4grx5/3f4jFtuGXzCgxjOSbt2Rv6R/jqpGEPfXqC1?=
 =?us-ascii?Q?ws/H/R69nr0uyd+7LkFW9ItG2rgujkcZXFZXAGMEhli97/o+wBq/hQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3k77976RbedI8BFEYVpYtDHTI/pgAQ2P2l8fj1qCVA5tr6SW0jTkO38ofnjx?=
 =?us-ascii?Q?tasf9g0QUP0pz5XDxwWUdeDg+1/S30F5Owok+IpigMHjk2W8F2AqwaGAnd8i?=
 =?us-ascii?Q?4KhXIEcuc4J/nFEE/W5pFWJ8+NrYN9VJET4yZHnZnQj5cP/YeJq7gGCbSLqJ?=
 =?us-ascii?Q?xxqgZa7/yrzkzZ/aNobv+xr0+DC1HjnC1GR+lRefCKbAsFxhigy1rzVxTm6N?=
 =?us-ascii?Q?Ko5d9TesfQpbJL9RTh8Bk4GTlht+U5ci6a5LLh+ZOAKjN/8QXmE8LU02kks/?=
 =?us-ascii?Q?jRobsD5U9gbg8/rE+kUSSnw1WgcxBTrm/BZT79kSAh1MS9stW48Sx4nGWTp5?=
 =?us-ascii?Q?Wth8khpN9tFbdDFHJUrpmYteTA3UTyLybU7J/G3kzxYHkLyM5BhzbsjF3d0r?=
 =?us-ascii?Q?0OtqesCWDsVl9sv/WlKXyYLX4sNPFl4FKiuDI9RPDjPeArzJot7ohsZautke?=
 =?us-ascii?Q?rxaxROsnCLC6lCneML/w3DRts+5mBXWZugoGrGndOt/KoI/Ni5nppChD1q07?=
 =?us-ascii?Q?an7HNWHG2+159eOyndncoE6+aZGyuk32Cm39gIoQkaePlcxf7KJ92xa1MbjJ?=
 =?us-ascii?Q?suPuEloqwa9WWg6x4QH+Muq6A0aT0lajDUq/LTJdBDUdqMGs3Dv8AzIepMpD?=
 =?us-ascii?Q?B1sXGXEfQMoZfOFa0y7vlQHmHuOW0pk21nJI/k0Cm9gYGyVnO1YQlm2zwTWX?=
 =?us-ascii?Q?RwtBVc5TB+fdLu9e2u6DmKi0uEdVye0Gs8oS0Omvmx3FfkMUDrsNTEUfZ1eu?=
 =?us-ascii?Q?s7AUQdroUOuytDpjhU9UuszVqNRc0fIShxRunxY6ETCysPAULpf6/ZkerSMX?=
 =?us-ascii?Q?Ds/ZMESeDzCXIDJHkGnBki6iY5JkDTgNPvZSGKdd7p9VHBgoel175lkPUUqI?=
 =?us-ascii?Q?72HhOo7VsizyZVtp+zUPyzo1ugVlJvJJ9TCQcx/eNT15DxsHz6HwVvBNt3Oa?=
 =?us-ascii?Q?l7pNZTGcEByWIa5t9IR6TjuXhaUXbrF8Ewj9Mc52Fr+D9HEddWTjRY0QkzKU?=
 =?us-ascii?Q?SRaeu8NgSV3U2NLkmciTjnmjDGMsUDUpD0dXFwZYLqltf2otUGSBTPBtQocR?=
 =?us-ascii?Q?7zC/4nGatXcuV5+lSzdbNp0Q680idm2U7eWNlhkPrbv5/AVWCV4S9BlEVzaO?=
 =?us-ascii?Q?UXt79vEpg/z8lyIxlcyKm2gGE0h60fwOOa1RTrKGsRDZb4HRpV88ULL2MkSY?=
 =?us-ascii?Q?qiKbEzSJtWOpAFsPGHjcqJS8MbHjGmhAUHspjQ4KmUOXHLjAW3Uegf9GP8WW?=
 =?us-ascii?Q?O/la8lrt68Oz0vIKmFXMkuv5hwHtihJLcdv8rRQRc8yvurVxb/zOz4EhzX+w?=
 =?us-ascii?Q?3FWQzu+AWdsInGMDr62P8a8k84dHqFrUR+xRrbfKkQ4pRvjRhFFlSift6GOx?=
 =?us-ascii?Q?1CnW738p6aWQVHLOSdVCVKA65XQjeq293pZEky4q3V+GpjJvrGAZwu0arjeS?=
 =?us-ascii?Q?UiU725lkyxHCawUCRGOFnDplwNnHchbekR95fkZZysFLnoaqYml3lhyYSptQ?=
 =?us-ascii?Q?eFCu/pzkSWbvLJbAvkyB9hK4h+4+a1dqHBNxoxXODclBDoIrnfDp+CVhc6p/?=
 =?us-ascii?Q?snCI6P4t4alJGcfONYQa4BCtd1t28N+yLz2lLMxZdDFxxLpfUfP8HUZlV1g2?=
 =?us-ascii?Q?mvd96tOaMFB00KxYbkI1osY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef113410-9c1e-4819-ea1e-08dd8d23f3ea
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:59:31.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgddHjZrg0UFvON3nID1jWReDPdMRntTjtf41Pu9BsRCpbTJ/z0FT/uiQw3C0Mx5xfFzfMBsJeexHqaqwkyeipF0CtmySpkFsatbbGI83ofS2sP91Yg8NSjlRT1PnuiN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/core/control.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 0ddade871b524..11f660fc6f2b5 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1405,7 +1405,7 @@ static bool check_user_elem_overflow(struct snd_card *card, ssize_t add)
 static int snd_ctl_elem_user_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
-	struct user_element *ue = kcontrol->private_data;
+	struct user_element *ue = snd_kcontrol_chip(kcontrol);
 	unsigned int offset;
 
 	offset = snd_ctl_get_ioff(kcontrol, &uinfo->id);
@@ -1418,7 +1418,7 @@ static int snd_ctl_elem_user_info(struct snd_kcontrol *kcontrol,
 static int snd_ctl_elem_user_enum_info(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_info *uinfo)
 {
-	struct user_element *ue = kcontrol->private_data;
+	struct user_element *ue = snd_kcontrol_chip(kcontrol);
 	const char *names;
 	unsigned int item;
 	unsigned int offset;
@@ -1443,7 +1443,7 @@ static int snd_ctl_elem_user_enum_info(struct snd_kcontrol *kcontrol,
 static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct user_element *ue = kcontrol->private_data;
+	struct user_element *ue = snd_kcontrol_chip(kcontrol);
 	unsigned int size = ue->elem_data_size;
 	char *src = ue->elem_data +
 			snd_ctl_get_ioff(kcontrol, &ucontrol->id) * size;
@@ -1456,7 +1456,7 @@ static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	int err, change;
-	struct user_element *ue = kcontrol->private_data;
+	struct user_element *ue = snd_kcontrol_chip(kcontrol);
 	unsigned int size = ue->elem_data_size;
 	char *dst = ue->elem_data +
 			snd_ctl_get_ioff(kcontrol, &ucontrol->id) * size;
@@ -1475,7 +1475,7 @@ static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 			    unsigned int size)
 {
-	struct user_element *ue = kctl->private_data;
+	struct user_element *ue = snd_kcontrol_chip(kctl);
 	unsigned int *container;
 	unsigned int mask = 0;
 	int i;
@@ -1528,7 +1528,7 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 static int read_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 			 unsigned int size)
 {
-	struct user_element *ue = kctl->private_data;
+	struct user_element *ue = snd_kcontrol_chip(kctl);
 
 	if (ue->tlv_data_size == 0 || ue->tlv_data == NULL)
 		return -ENXIO;
@@ -1598,7 +1598,7 @@ static size_t compute_user_elem_size(size_t size, unsigned int count)
 
 static void snd_ctl_elem_user_free(struct snd_kcontrol *kcontrol)
 {
-	struct user_element *ue = kcontrol->private_data;
+	struct user_element *ue = snd_kcontrol_chip(kcontrol);
 
 	// decrement the allocation size.
 	ue->card->user_ctl_alloc_size -= compute_user_elem_size(ue->elem_data_size, kcontrol->count);
-- 
2.43.0

