Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010048.outbound.protection.outlook.com [52.101.228.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FC1DD88F
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 04:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593933; cv=fail; b=NBw3AQbu7NEgtsTOW/9nc80xKWcsh+OZJ9o6ugKu25eAO/4YODK5ls6Dm1P9XTqO2kWxtHtZhO0v8MxaVWBPeas8BpigOLsNxfPOIR7po5e3V3+CCIbFLxa/GG5AAhpnYoqYgNLHLXwfki0OZRKryGO+WLrgsSFdbyibi7ATTjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593933; c=relaxed/simple;
	bh=ZbQC1TLv1jrcP2FCYgqvvKZswOqvAeuTE4WDT62B5hs=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=FX1h13lNFQ5JqG8YH/7DYs8yfHDtvysbkkUer2eqtPcaQ6MyUK/dpt7jlrtUpEA1zislT/oDTs8y0SVFifQVaVV2sRx4wQtBV4/726O5ueMewCPy+PZzHxop57K+PlDzNipAgfs3TK8nHVl3FkiAzATFCuUpteZMaR1ImqqDxcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=gYGiav2c; arc=fail smtp.client-ip=52.101.228.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="gYGiav2c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfeFiXtnAbz10Rlf56g1yumRHfic2Gw/arALrJNNjCPUmHsQoQ9yhFDr+8OB6P9Bq6aunewUTBkOT8TqgnTOCdPZHz0NlbW/FT7HBzWldYPHf9S4GOzSD7GWhM7FoFMG62C7vn6/amNDbEHGfbHkyFz6Ggw3H1VK2tHGp+j3kHsUzq/HEqZY1WtDlqril2ATOvlbBFR9WWcOoZVzzZ514Mcfx3QHK6NX18GEx1UDkh53rIoWBBO7zb7jptXFzDwgwNoGU3R75Ongv6r2q2uj1FXIfsVUJwwPtkzeUaYwhuX9m7zvSXHdL1XoewKQ5IdN6TzY3ulNwEsiSd5x4NehEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyKT5qbt8Mq9jLJsshpgzyl8G4HCckucZtwmN+c43og=;
 b=qIhuoSMD0aMaN2s5FHQO9H/v+U2Fs4nUlkqFP3/FHyRUejcHoKg2Cw4kgEiXMMBiocHeLMVbOISMrY76vlqgJ3xPzVWwwEod4tJxtQqq4mfkFCqKwu7LErltdwcvxGxYog7bsHG4pyeRsHOxg3dPY5LGk2UN4zzTZ8AK4e0UMGYQmx23ZSkJfCTpVKX9yfrhPPgFG6WgCTcxP9sXNrxsb4/QcGmzlEYUaFOeHmTmbKxwHRD3PBTYGiymvli3kf5zcP9UWKESMc6yuqKXoN73JssUU/e6kK8IVSmIQXhJ0UmukE/yUu2/FHCs+72prF9SZvEFh0C9LwZysEHE37ATtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyKT5qbt8Mq9jLJsshpgzyl8G4HCckucZtwmN+c43og=;
 b=gYGiav2cSLPoPQV3DgdVAX0zmjytkny1pEOemsZ6gdhTfN6b5bs278xK+QmfnfUFXLA747MOcxELl2bPvkJIGZIwZO0HZGPg5ioVIlfe8W5jWo5hsbSe1TnJB6tbVpfweok5JRzP+yfKW6RP5fG5Yq0l7wvs8LaXkIG8DRaD54Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB12517.jpnprd01.prod.outlook.com
 (2603:1096:604:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 04:58:47 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:58:47 +0000
Message-ID: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 00/12] ALSA: use snd_kcontrol_chip()
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 04:58:47 +0000
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB12517:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b028c3-1367-4a79-52d6-08dd8d23d9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Hcv/DctAgsbtxp4VLEYv3IZZk5ZUAktc7mc46TN5abMGPQa6oUtvzeXlAxl?=
 =?us-ascii?Q?Y1CG/3CdBc6isnEc0WH4M+3MxFJu0qhvwEhZofX4rnNukRyjQRyPNQz6yhEe?=
 =?us-ascii?Q?hfeKiNmgn/7rsO7nlPzXPtxhIXT6tyg7wB3JCIOlhXeZbyhmlftBKqaK44Ip?=
 =?us-ascii?Q?zxFg2XO4Hz696AOxSe3T5NjnNGeQ4ev03RzFMVZs60YDrlWa+obKOnnye0gJ?=
 =?us-ascii?Q?gJF0tj9zSa69D42jBYCj8K4nfT54b1MCbKeVf4n/6wSjn3Ne0RBWariQBHHu?=
 =?us-ascii?Q?Tftm+DqwBYfcSrsgkMNH7IZo3cR2MliJ6dMlyXdDj0RNuzLForh7BstnNDWA?=
 =?us-ascii?Q?w5zg/A5Hm4o/Zo5zeWXhPioszsIF6syBXlpp7Oh1BB1Dpn89q/gA1qAiHG3k?=
 =?us-ascii?Q?Yhh5dyNw3k2qTxO7XmKMyFpb8E9ybfOdQv7ipKcBuhhuGZ4ktD/mwO2pREb1?=
 =?us-ascii?Q?as2y7LUOGqTTzYtEDNxVqo8Vl+J08Y8plnT9D2J51dSlYVM9p3QugGMkOela?=
 =?us-ascii?Q?zGjlBRcVxrxMjhJ/DPXMwgV2qru2hfHhwlShwXzdU+r9a+qiENM/3xORBh2i?=
 =?us-ascii?Q?oZftWxTR25uaMzwgfPECIe9F5QIBEnw13FkmhPdx9Mi91GXh0STlnroY4En7?=
 =?us-ascii?Q?gJ8EZa5baQKpuEWC6eCybxyJ+COSVSUBe29v/pw08EARfGvdDYMM/9cBGshT?=
 =?us-ascii?Q?msr2L4kAuZ8WJdk6R9Fc2spC6cSsK2iI0+Sr7BUDA3EpOAZ1v0B32ngJTDyg?=
 =?us-ascii?Q?+1ucn54Ssg606gGphjaW8M7yPFHsjYN76IO/OHjku1IXDmFiGsKGzDIV3Qvl?=
 =?us-ascii?Q?nCrrrRZdjzIs0UxpsQEoqANOc8v+g5XCur6lRu7/Gr497UnlQpCg4RJYhglO?=
 =?us-ascii?Q?YcoFBG6pOotjEVwVb6q+6mU04NFxVWDIfpWRu5cCnPs+5M8cHl3+IYYZHgp8?=
 =?us-ascii?Q?te9R4jomlhwJynSXtNemPT/lDca+JjGSa3vEn1MJ0CENZvyF+ikxClIM570L?=
 =?us-ascii?Q?nJNEKPmpbbSeB8+vU/DFAsfyWZjgOFn/KpL/9HyTxn+YuF0gfW3kNd8dwqXI?=
 =?us-ascii?Q?zvjGDzlhYQLTW+nfXIl59jgvjViCPCtqR2NP47okBNKrQX7MAtz5GTm5wYv5?=
 =?us-ascii?Q?cbe0o3LNixVSqLHhs9BFbWyQxGVOED3CUGDekjF2/1RTZ2mYCdo/MJA3p73w?=
 =?us-ascii?Q?bW0pnP2hpVzI68GQlynn0TPQ7U1g/v9xTpvAymwXo+19R1fDyYOdQWZnwB+z?=
 =?us-ascii?Q?labO8Vtqu8s2SaWRNHYWQvTcHRPCJ2OSFrfH6p1bTVOmYIuuq+f7klqkGznW?=
 =?us-ascii?Q?ta2S5ZpGhRUiznPjdHZS8xISWxW38DrVo6iUmUxt8hq3lGA+tKPq5Ux8N+8m?=
 =?us-ascii?Q?9/yIMScGwjAFyN6IxOhPyRAdMaTT7vKqD33fQ5zZYzuG2DEmx3wV7xU5Y6El?=
 =?us-ascii?Q?3pOrkfAHHxByI+PXVYJMGoQ5Rzyhpfy4bWBTBfvGx7S5vxSf6/xjag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iIR7FaS23g1Z6Jcqf+1/z6Eqm4h9tQJAYd7gXcDNLcZ+mWKE+7fX5eRXHLlg?=
 =?us-ascii?Q?whCS9l7L2bnpSqLDZvd8FTnOhl6Okg2crq9SvmksHTrdMWgYJD2ncUJjUqn3?=
 =?us-ascii?Q?6iMY9vv2Rw8XW5ECV3dW03hO3VTPhCtX8y5oRuchbtw5if50w7P5OxNP3Jxn?=
 =?us-ascii?Q?F9gfbHazXYzIPphVqiJYMQF/IiP8xp/K4kYc+1vzibiG6eQFPVNhf4fpZ4+w?=
 =?us-ascii?Q?tQQvbg4Jon7SQoWhFlqwLXAL2HeX3o36UIyONSf01l4OkS5hJ/JM/3ymdx8B?=
 =?us-ascii?Q?JpA4M/siU3TBoXynnW1MobPWB/0O4bFvJIOk2OVBDc5xYbStg/DMquhgYBvK?=
 =?us-ascii?Q?XRBLx1R3x2g2wyYmmETVGd+OHzdgFXn/wy5PzBCCkEk1kMhg7mlz2Lq/JpBw?=
 =?us-ascii?Q?lcbP+E5mGxWJNvjYs0PIgrTc7usZ6+OnCzd2FsQA9kCbUTTXBQANUrjGTOBC?=
 =?us-ascii?Q?5Nc+adVJ/UeVju2NVxyHUVTUQVA3lYH+jv5Mb5I2wpE8HfjTo4DPsA42HQ9i?=
 =?us-ascii?Q?mTD8KvmGcObPyBpexFxH7dJvkLSPgVNcUdFuq/9flXhL/Yugz07M42odWShA?=
 =?us-ascii?Q?qjWTnyG01MbmnVPAXnKj76HYPgYOIWXniE3tMmLiene3SyBdQSugzgC7d3G2?=
 =?us-ascii?Q?StCW637o/KCs5Mjdan4BRK2O3YN8qmXPFjyNL/nqZgJRm9Zgru7c0kN6Wd77?=
 =?us-ascii?Q?NIiHyJr8vTnoc5BwjaHE+Yk8+IZTW109yMuov2EQLYQl1jmLvXQTYFWZRTnZ?=
 =?us-ascii?Q?lJ3h6rHIjB1PrMji3vyhFq8vUq5ZjFUpQRGK+rantXon1eLyWSXa4ZQYKaL7?=
 =?us-ascii?Q?YrtepoPhRvDnQKo548JT3N6Fif6sR8PzJIfPFACyJnjwx4FbmzH25+91cyCx?=
 =?us-ascii?Q?od0puUhuoyRw+YbWckNz657+is2bvBw9cA5xAQq4BKK8HQ7XvP2UVUSSIZLv?=
 =?us-ascii?Q?pa3/ksBzIiYUCKohLW/43qplWoB4L0x7gOzyDin9jTgTX23+v4uUp1IaNo3y?=
 =?us-ascii?Q?+hqIqvKitmV+TCu+xqY8D8S3OOj/NNIPOfjQpDC8w/jghGFK8utll1PRvSf5?=
 =?us-ascii?Q?OiKnpKT5dIzEUWcuL48iK9NLZLv2L3RtQHfoMVKiCqezKQ4yG4dzsA4SYDYF?=
 =?us-ascii?Q?SfWo1KMZyEehO7KiW3mVimNeWlzTHZsDe3JqJ312Q1jkcPhcSyKT2qxu9ZSf?=
 =?us-ascii?Q?DpAzMcJ1VIz2d8vdhnjO/TEEaQQhsGDZByVuZ79Pv0iAQd+w7ffOHuOqDEp2?=
 =?us-ascii?Q?SNu6he13HtjVTBODIU+XVqYVdYGX0ep0JqERpeQtFwVwNnOKLb1Dh0k69Vgx?=
 =?us-ascii?Q?j/mrjOh7VFGRvRSijtUlBeGO/2arhQy8rne8JncM838sA4C4yXlG9qW3Rcty?=
 =?us-ascii?Q?PTi+Vt5daBO+GgmGTPpM9nfp2vCi8B0BkqpMaNbhcFtwzIaCpIgbO3bGsgqh?=
 =?us-ascii?Q?HTq+KchVaI8Po3DAWoeefYPpo3tVcGBEjYIUbNpS5O9FWeTmW72CfslkG7Kp?=
 =?us-ascii?Q?Oz+GCN5pw6U5cc48nzoc4cgQrLc02Zj/xY66Bar+hkEmk7g05sC6UzoPh8VU?=
 =?us-ascii?Q?uXw52QZyQxzdIoR0GI/qYa3OArpWXIZX2ICgUmUyBKgDJ2wtESqy3lB1OqYy?=
 =?us-ascii?Q?eWaKDTffxQFJAbYTfoaYhkE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b028c3-1367-4a79-52d6-08dd8d23d9c1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:58:47.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFJ8sHh8LhquuA6ld20TcRoC1cIBRIp4q2bTRpo8wNo1aPsy6PSLil9MFox1FK7K6dppYqZyowqfF+SwOdWQdKPplHXKWUVOFk5Z8pEszZFdCEOfse2EXF6t9pUkMYXi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12517


Takashi-san

Many drivers are getting its private data via kcontrol->private_data,
but we already have common snd_kcontrol_chip(). We should use it.

Kuninori Morimoto (12):
  ALSA: sh: use snd_kcontrol_chip()
  ALSA: i2c: use snd_kcontrol_chip()
  ALSA: core: use snd_kcontrol_chip()
  ALSA: virtio: use snd_kcontrol_chip()
  ALSA: pci: hda: use snd_kcontrol_chip()
  ALSA: usb: midi: use snd_kcontrol_chip()
  ALSA: usb: mixer: use snd_kcontrol_chip()
  ALSA: pci: au88x0: use snd_kcontrol_chip()
  ALSA: pci: asihpi: use snd_kcontrol_chip()
  ALSA: pci: ali5451: use snd_kcontrol_chip()
  ALSA: usb: mixer_quirks: use snd_kcontrol_chip()
  ALSA: usb: mixer_us16x08: use snd_kcontrol_chip()

 sound/core/control.c          | 14 +++++++-------
 sound/i2c/other/pt2258.c      |  8 ++++----
 sound/pci/ali5451/ali5451.c   |  4 ++--
 sound/pci/asihpi/asihpi.c     |  9 +++------
 sound/pci/au88x0/au88x0_a3d.c | 10 +++++-----
 sound/pci/hda/cs35l56_hda.c   | 12 ++++++------
 sound/sh/aica.c               |  8 ++++----
 sound/usb/midi.c              |  2 +-
 sound/usb/mixer.c             | 22 +++++++++++-----------
 sound/usb/mixer_quirks.c      |  2 +-
 sound/usb/mixer_us16x08.c     | 32 ++++++++++++++++----------------
 sound/virtio/virtio_kctl.c    |  8 ++++----
 12 files changed, 64 insertions(+), 67 deletions(-)

-- 
2.43.0

