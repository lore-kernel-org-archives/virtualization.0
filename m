Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010002.outbound.protection.outlook.com [52.101.229.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B01F1DD0D4
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 05:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594021; cv=fail; b=t1WXUp/WALE/ZwBKu4O77Kg/QZ50aHrZvLesg/YzR3FrZgcjNpu9734NEo7qaWCloJBN/v558woaYFJEEN7NAmUS6coSp+AcmN8irkx4iDmaaEgSIttmlYV0JmdWOdUEO1978ajXm4nFodJUY0VEBCG6yfU3QQenBy/WY2sKDmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594021; c=relaxed/simple;
	bh=IhmHM1P8M+p1G5RlFHfATnOg3P53LEKrxmyJ5iyKg+U=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Ft8GKcUq9Ex6r+CoDdZ+KBUMEziMVqFdyQuM9C7mynl0wdMfMpK3ILDI26e42I2WltnKXmcVC6SZiONiI+OUTqaU6h47N9ff4XXNKa/nQVKElbHuPxyOGSoiOtm7dRQuiSvVuupqP85dckvs/i2u9d04mcjBDyARpniib6kvsEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Q7YCcOl0; arc=fail smtp.client-ip=52.101.229.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Q7YCcOl0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKQt7N901bLR6cOLehEuJ3VZ4hHaT7nvgF479x2KUciP/4YEsXzxl2pX84J2RzJ5qP5LG3UAB2oH547VpdXHBukQJ9lr9rFNsy0I7bhD6s3kwjrN1Yvk+SjkFRq1EyKjwWMfrTPgIF/Htyyl1Sb3MHuj9au3sMpkm4yHZecvpVP2Oaa/+WDkRYdwaJT9MtWa0O6FDfsZFk4r63AWyjhztJbRWQTu9LR+tsNyky710GI+1RVG/Y/PCJtMB/905HNT65xxWGNMim3iOhXuvSE1SFnCqtqCNLnrHqxoH6+UIxeD9bKqwfcouzXI9mrkur+xE+fGzWsSbno3HwNxt9/ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heyQL8PzHEJ+tveTMHSj30IL/ZG+11Ljg5jeqeZEzQ4=;
 b=kmrlUUlUxZ1gsKzo+YX6RPihQnE1L4dC0EZGP2/ftwCgjvYSAM21xWJSn0CP/rQU/kcXNdhj2vfSKSyu5+942OgUvI28Pb2TO/8F8enlRhGFr8wJ8ijIWzlvIgU4eMmBdOkMLqaGprZCVb540TJlfE6dFEz/KJMU21tFJs9Hcc3QqPCcUL2zs6bf/Z/JorcB+EWb5NQ+SnlkbaYCQGco1MvcYTwBqugwCHRJ/UWmiuq0dcU0Mp2UqDnyefLMJs9IxoE1l8U2siC1JO7k6srSyEiSPoEirvmLrCIioezElzLiF0jvXh+cN8knFmvH5iCMCP6aGVWBJiH79P0GtKl8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heyQL8PzHEJ+tveTMHSj30IL/ZG+11Ljg5jeqeZEzQ4=;
 b=Q7YCcOl04HQJV9v7rF7dy9IFwUv2n7jeGcDKqKghQKCZeuufwrmaqxXEsxU4XNh9t8w9HmLCF6L/EyyOHrDE3BAWUiCp9O/Mq9AMtpga0+wfSvJnqxPH/Rv0bOUpXJ/0oM72qUi9TfWxLZIdb1WKY/H11r/ucaE7WI/RwXlZAww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSZPR01MB6890.jpnprd01.prod.outlook.com
 (2603:1096:604:133::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 05:00:17 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 05:00:17 +0000
Message-ID: <87frhhaucf.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 12/12] ALSA: usb: mixer_us16x08: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 05:00:16 +0000
X-ClientProxiedBy: TYCPR01CA0002.jpnprd01.prod.outlook.com (2603:1096:405::14)
 To TYCPR01MB10914.jpnprd01.prod.outlook.com (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSZPR01MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 31819a50-82db-420b-67b5-08dd8d240f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X/IeaQIJu/hkZuYXRCpUkrwr5Wg92XADXnqXGTktVXuk/C9Yp1dp5rqJRfJo?=
 =?us-ascii?Q?afzt68Ha5dRXA0goGY0QtlK/L1z6rp1omFai6GjifCx2T1nNBRNcl3c8D83S?=
 =?us-ascii?Q?9waLQnGMp1KR+kvurq4lWo4vCN1TIWogo1LSXdUZciiKINS8qbLPNpnmX/jn?=
 =?us-ascii?Q?m5Xbwf6rbjiQtpR2HOqvlpcjXCJaWx1cqNiDEM3Ain9UnL6rAMHVfSj5vVCr?=
 =?us-ascii?Q?q1xtf67E4C2QMSHFQQ/Atn8SZR6uGTKhZ8qfg+aLa2NPk+rufMO9RXQ2HN2I?=
 =?us-ascii?Q?8uQK8iOGW3ktuMuZxneiV84K5NdtQ6p5NbQWK+SMg32J9Oa/trkicwNO+yQa?=
 =?us-ascii?Q?0KRijNPGjTY3cpdzAlUm8nRxYgnlBot1NSOI93QliZZzDTqizQCaNuvBpaVx?=
 =?us-ascii?Q?/HY459wFPNnQ6SmItKnWgjL/+mPP2Xm22ovcj0gvpGqDM5L2AIsYDtYzf/hb?=
 =?us-ascii?Q?aYF/ASVGV/HbpctWDRDZq0VTCgwqcynl2Y/h5UIl7Ntxa5T9MYLboE9kOXKx?=
 =?us-ascii?Q?SszypuH2tChF9hFoiejU+KJ4f2xs/wEhtLDKhW5SBWKXUdKG2uwbli3JrpMb?=
 =?us-ascii?Q?NF0pkmTvfo/Hijn17c/hMxiZAuLEzV8+aXj/Wp0T3HZYF3oKDnIgV0BQd8vB?=
 =?us-ascii?Q?RMs9++wyIS70ut8hQJIUgT+NDcGhZTO/mf8BPP2ItvMNjQ94iCTVn1sSMHD/?=
 =?us-ascii?Q?/ssalfWjc6R5FymQdWBRFj6O0SOzIsEh7kq1pprHorRFY9Z+iXex5U19hePn?=
 =?us-ascii?Q?E4eZBzKit3QE2FbOvnb49hNevsMORZfpRTpYwSYhAGZNxu9fq0ra/81Kdqat?=
 =?us-ascii?Q?8PxnTmqtGdRgqoEMoHpnPGpNga0CsecLgoncVJ4G5r45jboPkX9j2e2dpU5g?=
 =?us-ascii?Q?S10xJrXv8WOsXBFrKKUYQBvSJg+/nflf4PxJFKSUkWZaZvOMbKSD7uiZf2ZB?=
 =?us-ascii?Q?DDjtF3A+FCC3he28KqGyMqDBKQgpIbHxr46NuoQY40I1MI68OS/TtG0YLbv9?=
 =?us-ascii?Q?cT6YRYshXiG5ZjRFYN3Kwl0eGdtjRKfnweJno2m+SNKYe5cYjMqnn009nMjE?=
 =?us-ascii?Q?6SbZ0xddJ9J6Qs4Cosf+i3auQNsr00gAPHBSCozIp2rgCmg+/MdF74RlIkMa?=
 =?us-ascii?Q?YZQv7IwDq+uyTRBsb0C28GZxblncpKNOCayec5467CxsuwykAoi8inbqpTFq?=
 =?us-ascii?Q?ckFokDb1EidTWKaZO5i/bbn7tZMdBt5irv5i3BCr1T0uGk8ix/pHqrIj8jJZ?=
 =?us-ascii?Q?QaMetb20ZtPrER43WixR8928bS3nSOcBq026tycuQHcdQp5lzzVrTVIXcXDj?=
 =?us-ascii?Q?zAYJONfQOYG95Ua71nevBaJrPPW0gUfZ9//r1ZE0gWTU9FnfeHo+lcytmhxg?=
 =?us-ascii?Q?6hqPkZeJwiwzYsICBAKzQMPvLjpxuTM1pfTFFPGjYZHl5S/Ndx8EEdK/iiZc?=
 =?us-ascii?Q?REGh/Z7TAqih9irRyJzJc5pXG/L1ViDAcTtMQxexjYpmWZ6BUIo4VQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/SFVxeR13KA/KHBub1KbxCPL63TtnwPpIvTjhRwmA8HsE9lWwn43j/Z3mLJA?=
 =?us-ascii?Q?CKDB75XZ+a0jTPiWbzNjCiL7Ow1eQSGQpo1bD6Rnda6PmzX6xLYA6PVMCk6e?=
 =?us-ascii?Q?fR0YYc8QoIk6VIpW7heEpcKaMrJPcDmFEJrB02dc92PxKY776T+FfU2K1FLF?=
 =?us-ascii?Q?8Zf9ZJ4Zld6sQdetGPVIc2jwIkJbv8NeZACx2HgOMlNIgUTeemI4XGyIPjU5?=
 =?us-ascii?Q?clvl33zfDx247Tl2lxIb2FJdUbQMHlV5PmBCybxnqK6nVyMQrs11txzLxf5o?=
 =?us-ascii?Q?tlZijhD5CdkmrW/PI/offhNMD+vOOrqhKc1XYgo0J7gCPuhaIxRcYa8C8aL9?=
 =?us-ascii?Q?wn06Wnxkb89MJgTI1hbJwou3vbomTW1rWjPz67JHiGl+3DoogJ3NkxEndOcV?=
 =?us-ascii?Q?xzduLZSDoY+kzM+lAS/x91709cs+MTWlSfs9EVV1F/VS0thB7cTNeJtSpUsy?=
 =?us-ascii?Q?iUuYYQlBzeZAX/IqJlGu6ucNwWqQQhTa2VVayUSHuQMgzkqXBxcVQV5TflDc?=
 =?us-ascii?Q?bVUA982XAswzgobGL3IE7Cn72Uuu7ViSABrf7IIV/DqEj2ogd8uDMCtGYxnZ?=
 =?us-ascii?Q?as1oPH01ue0HH3Qqg7p3aMXCDMVT5OMujFGNaxCDFFU4KPlKsQuocop6wuzs?=
 =?us-ascii?Q?TfPozbb1nAOurXBCj5oo4AkcCdyW+3M3h2ywvuKB1UxIqzmuLF+Xj48Lx49e?=
 =?us-ascii?Q?MlbXwwHSMHP282Fob5AupOXAeWzs+qg7wKSLEicUuKDC/wRcVF4NYdPkWu/f?=
 =?us-ascii?Q?bl7vLvIQDup+YVN0+qUIzwEoPWn8rjPZSfpLcifYMC7F7mCPaOIKiou+K9QX?=
 =?us-ascii?Q?g1jV9KWKUqnSjk9GHglTaoZEnYgnq0SGjkJP05pNdL6KwhaEy+BNGraNuZOv?=
 =?us-ascii?Q?Tz8RJXZeqlG1r3v01IbC61Bu38Mc2HgOXrkTJdJ+4K4jlo5/qG8sUsRtO0Zr?=
 =?us-ascii?Q?wMdQd5OPA+22xoEVpWXBM0fGNNn2jK70SPevBVhcFFAciWKoyC63jX43p/xD?=
 =?us-ascii?Q?7zDs2sAoTfVihWJZgCOUYkPHvkUiYHeoyUmQGuCZgzALFqa1py4lGYWwZsrk?=
 =?us-ascii?Q?69Kii77g9SZUTfJcok3BeEvr0q/yX4flUwJn4gQhAUEooS2WLyZB660w5gYC?=
 =?us-ascii?Q?prFJ9x3jd2YZlIWuST/L7ZJXUOidhwrOcr7uEjH5ZZnqvs5W5MGuerj1/P2I?=
 =?us-ascii?Q?/Ifq3AbLZAM0HJ9R8vJWDP2TWnoGmxbd2fYjTUuadf0GW4F8eHD4b6vTCDMH?=
 =?us-ascii?Q?EwvzwslGWAE464T5KlqCQxkjuH3yvWPQs4+HEas3p1lIQZFhssfp5ztoAqvz?=
 =?us-ascii?Q?pzjwfXCqyH53X3QU51x5T+fjYYdhxjg9AaIilNmSLqJxhKcOSDmbldmokrzM?=
 =?us-ascii?Q?E6pIupa0Lz4g1E1EBJxMgVwLStDE2UaeFcHZSbj43jUzUHgx7EsirWDWginN?=
 =?us-ascii?Q?8VqL1PaYqdvb+fuc036raCzfkzl5bNe+QeCtqLFrhtJ8Y+sefevXjtDkzYtI?=
 =?us-ascii?Q?oQOW0c7eJVAqiCXkwnFRSkefJFH3hPNV53EwEuEhKjgtKL5kUNo+mDw1wjn7?=
 =?us-ascii?Q?lc4WUp1/960l7kCe4OWAtVSALOIN7/0lWP3XGVm9SIjkv79Y+YoZKRdmx+Ex?=
 =?us-ascii?Q?UeBorkPNFicLglXUCKKTdvI=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31819a50-82db-420b-67b5-08dd8d240f38
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 05:00:17.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdDlWGrYOqXXmJRRXLBKKSyIyegV7qkW20xPH3Iweg6qWAwE5XWzwGfBlH65+1dC0LkOnjo27DPu+WQ7K7cszSebUtZFg7eMPbq4YuvNXCXuWWoIOLkAYtCKe5if22It
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6890

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/usb/mixer_us16x08.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 20ac32635f1f5..236b69054867b 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -180,7 +180,7 @@ static int snd_us16x08_route_info(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_route_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	int index = ucontrol->id.index;
 
 	/* route has no bias */
@@ -192,7 +192,7 @@ static int snd_us16x08_route_get(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_route_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	int index = ucontrol->id.index;
 	char buf[sizeof(route_msg)];
@@ -249,7 +249,7 @@ static int snd_us16x08_master_info(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_master_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	int index = ucontrol->id.index;
 
 	ucontrol->value.integer.value[0] = elem->cache_val[index];
@@ -260,7 +260,7 @@ static int snd_us16x08_master_get(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_master_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	char buf[sizeof(mix_msg_out)];
 	int val, err;
@@ -297,7 +297,7 @@ static int snd_us16x08_master_put(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_bus_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	char buf[sizeof(mix_msg_out)];
 	int val, err = 0;
@@ -338,7 +338,7 @@ static int snd_us16x08_bus_put(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_bus_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 
 	switch (elem->head.id) {
 	case SND_US16X08_ID_BUSS_OUT:
@@ -359,7 +359,7 @@ static int snd_us16x08_bus_get(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_channel_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	int index = ucontrol->id.index;
 
 	ucontrol->value.integer.value[0] = elem->cache_val[index];
@@ -370,7 +370,7 @@ static int snd_us16x08_channel_get(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_channel_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	char buf[sizeof(mix_msg_in)];
 	int val, err;
@@ -417,7 +417,7 @@ static int snd_us16x08_mix_info(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_comp_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_us16x08_comp_store *store = elem->private_data;
 	int index = ucontrol->id.index;
 	int val_idx = COMP_STORE_IDX(elem->head.id);
@@ -430,7 +430,7 @@ static int snd_us16x08_comp_get(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_comp_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_comp_store *store = elem->private_data;
 	int index = ucontrol->id.index;
@@ -485,7 +485,7 @@ static int snd_us16x08_eqswitch_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	int val;
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_us16x08_eq_store *store = elem->private_data;
 	int index = ucontrol->id.index;
 
@@ -500,7 +500,7 @@ static int snd_us16x08_eqswitch_get(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_eqswitch_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_eq_store *store = elem->private_data;
 	int index = ucontrol->id.index;
@@ -544,7 +544,7 @@ static int snd_us16x08_eq_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	int val;
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_us16x08_eq_store *store = elem->private_data;
 	int index = ucontrol->id.index;
 	int b_idx = EQ_STORE_BAND_IDX(elem->head.id) - 1;
@@ -560,7 +560,7 @@ static int snd_us16x08_eq_get(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_eq_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_eq_store *store = elem->private_data;
 	int index = ucontrol->id.index;
@@ -684,7 +684,7 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	int i, set;
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_meter_store *store = elem->private_data;
 	u8 meter_urb[64] = {0};
@@ -744,7 +744,7 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 static int snd_us16x08_meter_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_elem_info *elem = kcontrol->private_data;
+	struct usb_mixer_elem_info *elem = snd_kcontrol_chip(kcontrol);
 	struct snd_us16x08_meter_store *store = elem->private_data;
 	int val;
 
-- 
2.43.0

