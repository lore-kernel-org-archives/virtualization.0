Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012010.outbound.protection.outlook.com [40.107.75.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170925A651
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573228; cv=fail; b=UcWNiQIFS3u0OMiYHzQx4sMxhDduh56R48/CgslEnS4qRTIDy6C1nnZ8kJxaweWkqS0++x2DmvSgC55vBuE4QeM68BTfptcaj4NhV49GpLha6Hg8fk9jJFt86P666XmPiDfr8bcbE0pEAvMwB9Qd+NaEc60V+CrJpTSusng8ZBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573228; c=relaxed/simple;
	bh=W6pQe7BbDu060LqbWOtxuaVd8QaxMXGJIabaUI4Y4fE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nwe2H1/caW2P3wYO9xtFTHw2fpvqP7Og+qlD3dgmkCvAOdRDMK9diWvp7B/Cj1hUnxPheN4aUtnhmry+bCZXQWXR2rN3pw1NsvoOU6kA2sht+UPH7X5sVyPru6hhog8+ZiVEWoateT5DwVGGH2gYuoOspqrkAAP5bJJpc3Obm94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ma8PWo3b; arc=fail smtp.client-ip=40.107.75.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ma8PWo3b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh3BdIsCYK1u8Mpmh1D4MlIS0uar1tSpPOpBJHdLd1jKa7AdSQ8nWZqNOOVwgC0SJfSOnp5JFO0aFp2YeK6SXjSflvaE2AC6rYLfb/cl+whOJk1wj5ousUnssDDEWxTD8bM7p7406OmzBeiFZuKFS+9BASSCC7as8BrPy7L0wHuKvPrd22i9xcPRpL6717eoTaBcii7O9MXaXn00dMeKm59W9XGS+whbUvLTVG1AzqUia6UFGYAWdjR2F3H2i3ChvE/6aQeEmTVXy/Eld8A4ZrhB45PY/qtnduOZ+dllCD1Li1bZRm0iVRar4X750jznTSNcqnOvdAFagvnoRaR5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ1MsuARKMRjU3yo7tHDn+tzNptFT8sP4Qr9axEFxo4=;
 b=YIBqWc+/kcAg9/uOIJBgedwWNyw7of7c3zI14ZaFdB1FCgaDuVMN15OOsmqfio5J7TZYcnratSHePNS88Pgd5GWmvboJlWQopWsOaZU3EwWFNRGeDwNJkr6kvqD28ZK4xPcGuIVsBoIfx0oUfoIyvY3O3+XrcKNzTUKRVISF2+aM7ZrzYaXHY7q1iF8kwAUFsoIy7hBkOcmsOFsPAg0f0xZAZ8qQwwbPlMgkZTxUQd8FxtDjSZTO1UHNn+IdyzbRh9l9yXHojC6oUyRiGU0Qo8S2/uDXBC3R3D50/4QclhxPH4RVSm5Z1NIpMiOhnluYp50SqEQjrmulsjR+IkVY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ1MsuARKMRjU3yo7tHDn+tzNptFT8sP4Qr9axEFxo4=;
 b=ma8PWo3bS0yEHso8IpYpFqBo9k9yik87KMm/3sZR1fSJktrzFB8DX0/JKdZlwxk/+LT18aCMqPamG9uuGxzUNfJr2cAslnWU2YrcnoIA2VeflhYrz6eqtOlTZVythdXG4JlbzVjA8xiJVQRkoWvNPO4PPd4+DiBCKzPZQez/i7c3qEWxpUcJm9bVEW7lCKdqYFvVazqDH8lYONaOk0UU2MRKiRxLsXgL75+j/fE3F9JtKw7t+KJdGQq1bCf4VYSRDu6o1tF6pUUHAvuSsxCz2Es493j58n4B2O9B5L2oFnmzaPrDRegO4oRrQAa0hAO05dVA0PJaynmfL+10IsqO2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KU2PPF40E30BD52.apcprd06.prod.outlook.com (2603:1096:d18::490) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.16; Thu, 7 Aug 2025 13:27:02 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 13:27:02 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] virtio_balloon: Remove redundant __GFP_NOWARN
Date: Thu,  7 Aug 2025 21:26:42 +0800
Message-Id: <20250807132643.546237-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0007.jpnprd01.prod.outlook.com (2603:1096:405::19)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KU2PPF40E30BD52:EE_
X-MS-Office365-Filtering-Correlation-Id: de2c0044-79f7-4883-8840-08ddd5b61848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPrAjEehnO99QfLDBTWJUVzCUae79Ncw0x0TXEksKZO75Oaxl27NioWQHKZY?=
 =?us-ascii?Q?0N2qkhKjFUJiP47a9FGMQxgCzcVtzJU1BKLhHl3bZIOHH8kmpyn4MGKBbvAl?=
 =?us-ascii?Q?YHr0kOEvgO3iR4j/+ZUsylPJsr0GTZiQ89/wGra3ST3zQd0iq4cdzkrTnAYM?=
 =?us-ascii?Q?Dr77RBI18lPGbFEDQ4inngB4DbD9TK6POIMhIyWpfo5uxsuTjEWie8l/9Jdf?=
 =?us-ascii?Q?BB2pqL34VajJQael0wWqD/XsuwSlWSz/Vr2qYJAOVxwiK8QKv27Dnah2ZLxx?=
 =?us-ascii?Q?NoGsP2wZNKpZ17nkTaGdbjc70nPDUDlu04fUMyIp1biOgaZxTEVF+HfbktfB?=
 =?us-ascii?Q?dOs/q2STJxNU2dcbIPuF4MJFSezIYeuAexiiYXQThVU4wTw56RV18zclhbKg?=
 =?us-ascii?Q?h1afSawQAAE9tr6o3nu0heRrKuq5w7ey9pEoACauJh1ZENOUBfJT5NnnwnPQ?=
 =?us-ascii?Q?7iEjjuJv+BfokJn1z0ZaDJa1ynsmLbl2IxKE8NnW0cOkUFd9RVzpu1MhE3SB?=
 =?us-ascii?Q?+yrEFYjeVd8I9CgZ5mW8waiHA0P+CrTtece1ciHO1unCXrY9yfIv1BYCCPch?=
 =?us-ascii?Q?LXe/JtnR3qI9lEgAcKAG7mx2IMLeT1ZbFl5i4CA6WQXPqwG/q1MowJCYrj8Q?=
 =?us-ascii?Q?2x3akNJoG7qBQWI0ZpR5Jq7MVvSWk6yZGZqqwSk8BlvG/mfjM4L6ctetaPC2?=
 =?us-ascii?Q?3OnYzXjwZ89XpzWVcw8AB8EKG+BsdeaxZo7ScNZSo1REQe2Pghnoq4I8AEc3?=
 =?us-ascii?Q?ipayREHs1V+sP0af+vsQhs+cNNHV7Tg/qXuX0VGL5Oy4zoMrN8ifb9PoM5tH?=
 =?us-ascii?Q?CmnG4atjNqyzFChNgtlvEPDjxMxRd2aUkVut1BNCx3o6msw1GHFx6EOIlY+u?=
 =?us-ascii?Q?AqW2xbmBKx96Kno6zZ3KKsp4+lqkatkaz9nIn0nRpGYumXfcdo0yNTgTv661?=
 =?us-ascii?Q?C8NHQ5g5i6U5kqD9Azl4uRHY0hOgBqT/1LGmbQtfTaBBXEpRlwbJJ7HvEF8C?=
 =?us-ascii?Q?/Dgdk4xjRTdtbnYU40XmIj6bFLf4D6HKbeMmrKqceaCwJCNdeeIuczRDDoBw?=
 =?us-ascii?Q?0KqQM1l0CMVmdoI0kqojEiaakFpOGCaJKWG5+7wiHD+Dx9UPqxSEBIDi1K+l?=
 =?us-ascii?Q?g1UD8YSzpWWvla1RbJWGptvg6KPy0KYyLNgfG6yVmS0Hzevk8QZArZO08dOU?=
 =?us-ascii?Q?kHz52ikK4EecaksdOcTo5e7n2N17BvzYoAT9yiLeBFGpFa1QwJWWXSrSRsZh?=
 =?us-ascii?Q?QkqyOl5hFXxGykPRVnUGZChuIlil2erg9PvOb74lYv3TLkIp1vHCZV9/HxD4?=
 =?us-ascii?Q?TuIHs/5DAJfQuBD6Gt5NGDnB14Jt5KuKFJE+o/AAyYdy7wcx7l2yGHZwWnZ/?=
 =?us-ascii?Q?1jq9XXaWnJBduryevq561hzyPSb5sy/fqs7QnoTF9keQyHEgYFwBtUqLkdoT?=
 =?us-ascii?Q?ZSh+AUYOsRoDY6946G5D1QnRTUaa18NyOZHj/LeReK4BlQPq7S0XOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xemXpL62oymnQWHU5EkWDMs9DA6OWy9KV2U7lTDD+vcxnbLnCdCH3NX4s6jp?=
 =?us-ascii?Q?kvXEH1imqa75f07jZ0LLZoR2zuIHOmq+Kvp6A6BqB9whvsXWGFaIjt1TX4Jx?=
 =?us-ascii?Q?eR5DRP/fntiN9VBvnVkBU9flb0uRyPadRh7uKxPYvrY+WWpk+UZCEpAkultd?=
 =?us-ascii?Q?aW10fqhQazl/ucj0FRjui4m3CU6F5katlKyxLSkKnhpNElZiUloRpO6S8o6C?=
 =?us-ascii?Q?u+POOnAuRxLdvBL6GcIh7qngTcjNRfOrL8U1ItdaeRRzQSQvNb63KelLbEp2?=
 =?us-ascii?Q?Iw2bDpzt1unPOEcBqJpuYQHD7VMYqFUphwF9dWkEZaJ+oPpW0oyfTZW40l2H?=
 =?us-ascii?Q?vjcQIJE1Rp41IKmbGdDjAKN3dgxAEG+BA/osQ538jlrJ+HJsUZIs5Ouo5Ybg?=
 =?us-ascii?Q?jTXlGEf5tLMEDH8HoLx27+lh6INH6H5y+vS5Otbgyr3q5zGc/tEoVD9nwNKi?=
 =?us-ascii?Q?nK12v5a/AlLVM2GHjH7J9sjGLUYITNujPY0v4Dxuo1YC+133W6Lzwgg3a5aB?=
 =?us-ascii?Q?+t6EjzaiagNdZYB32SmWCxqjs6iqT8sydEc60zdx17xGSiUEc6akhOlG0day?=
 =?us-ascii?Q?UXAK4TfHCEMTMDWJTtXaeqrLLTcmGOHsbH0e5uzh0Nm/dz0F6R9Bp9QUxy3o?=
 =?us-ascii?Q?h3umTMdA5Kah379sJVorj9SwOQHXq8ubSl01ahCeDqeSdy+qGeDfaQoy5mv0?=
 =?us-ascii?Q?Z0RyR071WlReFcES8XPGyg92XGOg/JzponLYQsZ2Jznd280LCwNksWly/SbM?=
 =?us-ascii?Q?dam2sh5CC+jdmsfl4J52nrE4eP9RE8G8kb4T6SmzjL56DLc+t0OJ/jEGk4uO?=
 =?us-ascii?Q?EeH+gb4B0qfdz0dV5N1teaiAA80/qO+WK0pS78oqagDcX2GwspMbpWyerj5d?=
 =?us-ascii?Q?niUP5oNnWLWuIWUDN8xdAMCJC/bDDw45Id4eU0hTJM+yQApLrr9vf5TdLbSq?=
 =?us-ascii?Q?BmT68iCyB6PoRlvmLqxaFmVDwP+4gnUj/K1DnR2gSlSookv69aJamHr5gDf0?=
 =?us-ascii?Q?DJV7t1kf8pF0PoMr8ostcRR574NkN2jX0UlJE+OH+Dbcr8xW7VcWwwA/MzlX?=
 =?us-ascii?Q?a9R445B5QgE2J6oI5yixKrfu5Akwe+m/8oHSQp/Ejy13jivBgde9ZO0QjbIQ?=
 =?us-ascii?Q?T0jX+TN/bIG09YyUYUDdg7y+ApCyoopUENdyqnO+rfrJ/9cru1dssTzdiGlx?=
 =?us-ascii?Q?eVMGeF6TKAWm0aXC20aWc2qlpOIF5agTA1984//yLdsakK7fU1VF60cy5uRP?=
 =?us-ascii?Q?4k2+s8S4waPTj7mSS1f2mIN+trG/HTTqzkz1lg2jFZaivu490wNojb5ge63g?=
 =?us-ascii?Q?lnrfnuoIvpK6nY0DZYFFiIyjIs2dtaDHcj+bszDfM+Ia6Fqm1lJNfkSOYn46?=
 =?us-ascii?Q?m0D7zWdhaLHuXHTCv7nc4ggDpPsVNmrSC+rDQ4m2g3qTqFaxWDrL/D/bF8tE?=
 =?us-ascii?Q?GWkvFDLvk0DJfdC4ospW4DirRWP9pIA0edXePblr5c9g6Y3Vo68dKfJPcAHL?=
 =?us-ascii?Q?w4cU1sk2OmPmleywVXGfoOAi9kikudDE5f95ZReOaq9kCuHhLX1KzZAwEg5l?=
 =?us-ascii?Q?eaLqcF5hMMq+lsAqtPzTBKm2u7n5df9J+Kh9dehg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2c0044-79f7-4883-8840-08ddd5b61848
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:27:02.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFnkIJUdqrj1+P5I+nx9L6q8wdk7au6X7tvO6p24SHiPVSn/zFyN8+TEznMijKrZt6JjR4MpGIqe4bo6Ve+EsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF40E30BD52

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e299e18346a3..5734e24cb21a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -205,7 +205,7 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	unsigned int unused, err;
 
 	/* We should always be able to add these buffers to an empty queue. */
-	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT | __GFP_NOWARN);
+	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
 
 	/*
 	 * In the extremely unlikely case that something has occurred and we
-- 
2.34.1

