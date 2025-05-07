Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010022.outbound.protection.outlook.com [52.101.229.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697B1CCB4B
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593995; cv=fail; b=dtwXKvgfJ5BvyEaOOpjzGpMZ71o0VAxLsGsecx/j+vNjaiqQDqNcp3DsLlyJ2J4JK8/Kad1j2/gfrwuTzEX8bctAABnODX2V5YiOeNM3ItyhueKK6UTtlcXp3zFcKurRRsNZPE5cLzftGqTcAjAYzdu3qAdVgLVPQP0phJWmE7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593995; c=relaxed/simple;
	bh=tjysF8Xl26bd0mStmNi3edh0VHaIWNEKj+gYYM76p8U=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XQhCRcrVZEpM7bCfXhDNWPVYct9RKoIOqKcZYJ8+hQy8hDuQxNZE4NEqayftTQkKikACMUhZq7DSR3P0EGMCcVa5QAqfK+AmKRfd5AeHTa3kjTx5+aE2w4OXRBA4IMe7wqXSRG/iuivFSF+D7scYlQYFLem1PZJ3CuSFVgBo9Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=J5GEVvAF; arc=fail smtp.client-ip=52.101.229.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="J5GEVvAF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnKYwZlX4WVih+Lsg2FYMbyO+jNmd0tJ8wPP5t+a/d7Z+BzLys37rXw05QIQrl1jzAZzU17SS00tGtuc64nkgVt6wR1CuDB5jthTCtRdgSK5HIakbxCy3/JdQYo/0O06Vk1BeUsX54a5umloIhc2LgppUCyDqOLOUXO69EMTj4bc8Kq1yTRsGJDuTlQSwunRgUHswZYUIpK5TC8Ao+HDuQEAfU8dWjmzBcyXeUbbA6/BuRCM8VR7B2Y+QLjF4dtdqsTC1WiGe91sB7uZv/wM8IrFPx6Yto5870kM8y6Zpu9PQOEoZWyEUuHYJDCxwnTMaR7Bbrm+OVrE2C3FVRUAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i8QvqoQfb9792beEF7csxgBoHt056+2d+Q5ullV0/Q=;
 b=dAjcOHPZ8nJpTUHo+CrWyNmJL/cY8teHGHEmn61J1ztEZgf+GZK2A/U/4IPeBbbDX0G2cq7aWZOfLJqN6mw8EPdI3T7tf/p9nK1Y8AHd0tgLDza+Whu6roY46sA3b5Oo1rk4tW+M4XEN6RmmCgY3PhNzCZsWX1LZJZUBhHKAg6j6asNSbUuAxZdCMhMA5u8xtdFELNmhTm1JgsGFWO3TLz1ivs0LzMZvutqH72sVGC1xk+/7dVduNVOnNe9uZzmD6ir2E8MrS47k6CeEhZyJQXrCMW873MsShKrrhyEHSG9lJtNDLSdXzIyrQ72HNfk9q2QyZTNNxMMgAT/Rq/uMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i8QvqoQfb9792beEF7csxgBoHt056+2d+Q5ullV0/Q=;
 b=J5GEVvAFdnwsTmU6Fk2S1OIwhE/vrJO2lB8//ee6oATONqGZQ5vjoodlY5CPb9BFxGpLrMa8r0Jd+RkALlbnqPfW19aI6zX8syn41WL5UV9jLlXX/iCBlbm+lfbyhQ2GEfeXWuqJoJeihGBg5fdhHKUgc9GG5mAXsLhEjR2GPPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSZPR01MB6890.jpnprd01.prod.outlook.com
 (2603:1096:604:133::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 04:59:50 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:59:50 +0000
Message-ID: <87o6w5aud5.wl-kuninori.morimoto.gx@renesas.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, Clemens Ladisch <clemens@ladisch.de>, David Rhodes <david.rhodes@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Richard Fitzgerald <rf@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, virtualization@lists.linux.dev
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 06/12] ALSA: usb: midi: use snd_kcontrol_chip()
In-Reply-To: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
References: <87wmatauex.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 7 May 2025 04:59:50 +0000
X-ClientProxiedBy: TYCP286CA0271.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSZPR01MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c0e7ef-a713-4c42-c473-08dd8d23ff82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nu1eEjvdYzFvh0Mln0VeQaIb5KnIrkMuqSwMwbWf5Yhrv7gmYL9b4bdLCmgw?=
 =?us-ascii?Q?Yw3gQI0YAw+PKGOp0CBNcbE6Y3GTR2L+NeRVSsMST6yGMWrZS/cqjwIasprR?=
 =?us-ascii?Q?P46SZ1zRuhaX9CBo88EGyOl6EHlRkZzc6BJ27T0WSse92UWU1vyfRKT+bRik?=
 =?us-ascii?Q?Owr4ugyIxPEroJP5ZOAej+1QeZARP1LJaMmJAv4sHUpek3TVF+Hs1gRLp0q1?=
 =?us-ascii?Q?ltE0e/rra/zuexqQDuJ144BTvc3RED4IzmodzdOy9kQB0fLl1PUybrU8QMLB?=
 =?us-ascii?Q?n4ZFD9Qi6hYCAf4/HipSL2QiPi/GMFkcLQH18oTShGYmlUX70Zkd/eppptcN?=
 =?us-ascii?Q?jzpdPTa8Yzb1obMFSYpq7/wH2LEiQhLZEOZI81Dm0x51pDDqaTAkPMGPzn0V?=
 =?us-ascii?Q?sO3cqO6Gl2TJFDGOBSkZl6nljIaG/cMHdW14M7+la0RHffvtCiY5RYdDCQDN?=
 =?us-ascii?Q?OLBep19hA5HJMSXVyYfyAySZqZ3TYJ+QHtGLvlna08ZijNHXJAmWB9RvLJWT?=
 =?us-ascii?Q?koLXLqcdHsHOm8DIYeSt99nG0scGbR8hkI6cQIjLewBxgbo09LEY/XAqT1GP?=
 =?us-ascii?Q?l8ktSFnTpHykeDgw7t37AVe4EW+KCwyT5MN552CU3H0uSL1pCRVW/KSwDzIz?=
 =?us-ascii?Q?qlJfJTY55bWim28a09bQOiuCOh0nMfWY/K+BGjDh59zZpFUlu2ZfUYppfeyU?=
 =?us-ascii?Q?bihdSBEtQpm4vAnALCUfdo3Dnx4rY6d2uMDFBJe/ZA6ko88kDGyX5qqFW7e1?=
 =?us-ascii?Q?sTd0YTM3vJydNfPvfurOTjspiDrpVF3y8dwvmNZR0dIhIfwtpytBR2dr7D4Z?=
 =?us-ascii?Q?K4/7L34E15XDixfAit94Lix7v06SyVVYfDou4FmS/Zb3J6Bzud9eI5VlS+DY?=
 =?us-ascii?Q?rlIkQwtXRxEuuv5mJRNuqMNEoRKvHgvwUTb88HYO2gRpldXf+hCmmk6mvyto?=
 =?us-ascii?Q?bMyAFWD1kXsWXkoRwy7m2qZGE1FZJF2kxt3NOrb6t4NO7DTFGDX4oeVsIH1u?=
 =?us-ascii?Q?1agd0lJQ9fIXoGAxQPXNDtX3MTajIyYs6lU9DDozBshUE0scZGSYB4omObBf?=
 =?us-ascii?Q?QtBEBSPWhYFqcxumW7PvsigrT5xY4AgEzqdT8n76LOHQxxKK51zkAEWTOFBV?=
 =?us-ascii?Q?Ru/xvDahL/ZaHn4tr1arOjrjiXTX8Z8BPbi86ZjCL0YHVB+5NqMZw0TTe2Xe?=
 =?us-ascii?Q?Ev4ONO+Km25Wz42k9e1YOnfNUp5T6YvlwKHpjhe8fCx6/KSh+ziZnqUK4ZzL?=
 =?us-ascii?Q?5T6tyag6mFUDu4RBIOxzDCMT2suZKRZqBhu00hhDzk7Pc9DhqLzxWdOhUnY+?=
 =?us-ascii?Q?VdVMWyNHdfLF+vj6fpEZrKQgf6ErhdhHLVKOYl8waL3EXCATJIMRrrQTZEzG?=
 =?us-ascii?Q?T8ynyOYcj7hTgWAx6BX/MQYxvTb03TW+NyFCA/8XzCqX13dqppH6+WqvJBeC?=
 =?us-ascii?Q?0qeNaPDSPxQjKt1pv+2/q6cptsEHleDw631KaM9b4/IMbC+ZKFUdpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yh7BvbB+KjolTifceNewrrUi8dkZacD30m8XX79Y57khetsierKSoDLqG/Jk?=
 =?us-ascii?Q?vZ4o2QetFVdWIaW3zfj4ZlSAT6uXsUXxYNJPxd+4Mdacjx2DbOWTVUNXwhR+?=
 =?us-ascii?Q?C0/yLM9wckmCj8L7zKmvUi9PxUP/6lKa/ALam+NSCN4lRKm4jvQIOyDtqoSB?=
 =?us-ascii?Q?qFvm3dkECcdalVGbk3nGUvchl/jAYWBA8WwkOM5a5oxYh8SqHitE9TskR/VL?=
 =?us-ascii?Q?1x14aex8LCa7xdGPIuIJjvkgPx1X/ulCzZFNA4o4XCVPr0V5XT89H4HaV7/r?=
 =?us-ascii?Q?KZ9xBA2t/hRqQVsL5IBtbh5O2CKNu3o/xHNxICdD9yET/Md3BPZGhKMDBC1/?=
 =?us-ascii?Q?Vvj3PIwSuCYrEArNA4MoJGGY+lOd7YJmtqcO0SbeBBe0aPQv4UsjyFXhnBvI?=
 =?us-ascii?Q?yFsH/MKcgiAR5ro796GG5pHuzBMyaygfPO69yE547zO5ISoIteprWI9aCEAx?=
 =?us-ascii?Q?8Q7uSKq3+4iB1bzrFQvLBjXlCmEMVJG7DEFhvg21DJsI5oqmAd0FxfFnYTfP?=
 =?us-ascii?Q?bHLQFweY1eBaI+GUP6RX8jEQBVqvYttSzh1tiNduNSWnpf6278+SCxbRuG5U?=
 =?us-ascii?Q?QWsymTxso6/7WYUaC25kRy8nb5/snzS3YormUYfURLyNFMjWbmlUADbD3PBb?=
 =?us-ascii?Q?/lqa/Tget0JprKQ9eTfN20PUUOggXnmQm6usG9xowGqIYvNDpTkqnZo8GPQw?=
 =?us-ascii?Q?34bQlWVZw6O0+sDt7EqAVt0ceFit9ZM3Ox7p7jfWcA7P4RRrJTP27vHVmw59?=
 =?us-ascii?Q?FT1r/Zekppa7rhObu51RThREQrCsjSIuz024G3RK9XXtwnspOQbOtTnxHKV3?=
 =?us-ascii?Q?3F8KHG+yQ46dxReSVRkdaeijnYte9ywwkk00oo7TvE5MuLJZw2+x+JIZnmHT?=
 =?us-ascii?Q?V7MS1AoRNWpwV/diOUvSQDcs3X5LawdSa5t/VXzSX3K3DvEyicvvWvyk7as9?=
 =?us-ascii?Q?ZRUkLYttUpHSyxk9YiH0pHrAxOLzsvRuDHLjMDrPAV6+s7LUAlhJ84chj/1/?=
 =?us-ascii?Q?gfQklJGcYQIMJBe1pLQd+xs1QOCZ2M7fUrdJNJQaNWECISiqMTj9h/U3v3s+?=
 =?us-ascii?Q?s+vNiA0oWgz6MJxLs63baIljOY0dWvyqRnCPr9KOG6J1tEQHd+54H6TwejcL?=
 =?us-ascii?Q?P1NyeUos4vAS4JHAUU+h9PA0l9IhGkDyRhK1a+iW/a6ASk/AyqFcgQsOYHOc?=
 =?us-ascii?Q?ZZv0IiceF7mppcDt12fMzeUmMsSLj6C6qAJpvpb6/eAW5MI5wyMiX2v2iF2B?=
 =?us-ascii?Q?WPB6yq2wJBXW6h0wlLc1z9TqEaOxWdsPSZsaGqPp/tBJhvKvztYlb7uhZ3WW?=
 =?us-ascii?Q?Azw1iZTIo3niYx1ig8whG764/jUqonxC1uR9czSt6j516IhYuQZQdHT8iy/h?=
 =?us-ascii?Q?1W0BG84peEQmzBPX55GwdZF3qslRXSKRlQoN6Q/3QyUzxwft1QDwITA0065y?=
 =?us-ascii?Q?dtTo1WqeHb3PhHC1UmLHhesO4FErJdalftrukTCQRghXWkuhEbGCAY1RCj/t?=
 =?us-ascii?Q?KCAIm/F8Qq2ImNt2FQ0loSsp8ksz37Sd5ImnRgQPU8YLf/dlWaxoW1lvlazn?=
 =?us-ascii?Q?T+oNRdQGElA1yf8z4nIMHQLSn1IL6Lau6njU0S7BeqRWi0rjI9w6dRZsrhh1?=
 =?us-ascii?Q?SMdoRMM82VxuyLoWH93Sf+w=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c0e7ef-a713-4c42-c473-08dd8d23ff82
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:59:50.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPMzd0lU/YVSJ6bjSt0d7LKqIuOoK9NLhIYNCIKRUeTDaAroI3uw8aHUF9iTtY0qJZ8Xy2YygdPcVMIZdOKSxLvX2R0+YgXnFvAuZRfoiyGcXBbxn6YKlT3hbtPkiGtX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6890

We can use snd_kcontrol_chip(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/usb/midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index cfed000f243ab..9ab746ba367d5 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2088,7 +2088,7 @@ static int roland_load_get(struct snd_kcontrol *kcontrol,
 static int roland_load_put(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *value)
 {
-	struct snd_usb_midi *umidi = kcontrol->private_data;
+	struct snd_usb_midi *umidi = snd_kcontrol_chip(kcontrol);
 	int changed;
 
 	if (value->value.enumerated.item[0] > 1)
-- 
2.43.0

