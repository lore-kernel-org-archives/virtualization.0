Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020130.outbound.protection.outlook.com [52.101.84.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15886353EE0
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542991; cv=fail; b=p02DhpyBdqIA/Cxf9xdKwMDS1VjWQj3b7iP9SYCY4Oy+a7bHbp8FMMhmQYNUGk9oIirna3oF2Yt49t1OiuCYJR6pEZEDKvPQPJMeIegsKl4XLRg9lfPCYhjqXDxfEXhL9i50w49GH9EPvt/y5lqn4HjaNKVvuvCHRrboQlHN86M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542991; c=relaxed/simple;
	bh=hkiMNfPnK9WWfxvO+1M7Dd3QVu6TR+4RNZioiCK4ZQE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pgCzEBfF4ZLF3uDft22BiXWXP8NPe+h8Ojxg7SE4kriMebYZprHDGItpf829RMyd5FGTWRt4lJ0jT2z81c5TOd4k38HDqpqMcRwZpmNcxE7X6RF4OBLucARlW5yIIQnGam7k/chHpqUJn+N65yghgCsCwOTr5j+ZHldgp1kmmsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=l3rsmExn; arc=fail smtp.client-ip=52.101.84.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l3rsmExn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1jLc73MaM+qlE14TQSZMOl56g2RnxZG3UBe3MZNDTsI/9usipF2d4EDG+guS9080AyvMkmKXmuTDAsB+vugoekLrlsGl8mlKGAgVG2PQNOVWtvAcDde97EDAi5L0SRgKsGOIVwUBL3zPuUuxkI7z960GLJW7i8/crnGo9iIn+pU5KbI+au9LgutNs3V3MfxXlxoenOL0+erARh76sy169P4hMUixLj57TvRewKgzG6HyWZS/T8VueNjCqma3X7rweUqMDGzVcxL4NgeFsljqHefY+/Lz/VYATz67PX0WdgywNWCJX7/7gNX3Mpv/6v98YHR8Sfp9zPnx0X5MkqPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlSyfz81yuQAi3pQXErgYrrsc5db6JwxPN5gb7P4PVs=;
 b=XVFkzglc83b8VaP+1m+kG6txkToZ5Y6TMKOfsQePk7d6uL8gzvhjlc32NxZUCKJSjUvwypnD2oO6eAUXTuf9NTp9GgUlZ8xnch0wuFkc4LWg27afMc+6eN0ZYCOx3ax3lP8c8QYypkpgK4a9/tJxeFu4DM0x8DQBC+UVRMNc/SGzFaU092WnY8xlSdLGVL2jsW/fX4h12GbsoN4VB70SgaqKmmPZ4U/FUKH4mQXqgq6A90T6SeyZRatWFR/BYaSyrkTgbIbIkuiSpvWUoyNFQ/C2UU1esQ/BSrwommveheOUDSu6lz7BeVdQUQpRrxXnNfyiFHtd0oHYN4zFtdVHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlSyfz81yuQAi3pQXErgYrrsc5db6JwxPN5gb7P4PVs=;
 b=l3rsmExnIt6V4JkfAXwDd0XgySiY+35rtBPz9Q8z98C1rLxreQjQg3bus4R97ZNA3QOBwHhrxTnHGE8UzDUSuiizKYe+Nlmc6ojWkf/RQ4BhFH6kX+2zzpfP+1jT3ELHb8VdGfp4fBNq9/JOKpfrTjjczrhjx1JCEL1hxImn7HZmJlu7RtehgSwYDbTvDyAYDcYZKAB0qNiVA0Zzqv+/zfYce28Jtxmq6h9g/8grGEJyD+VaHb4umQ4VLIYSGb+worf2GlRk97BV+dycXm19VY0tkl3KnCilDSnfkiDGsEpSXUXm2eXUWJubBCWk6OpnAN5v/+U/25jlYxf+mk8MQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB6264.eurprd08.prod.outlook.com
 (2603:10a6:20b:29a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 10:23:06 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 10:23:06 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	sgarzare@redhat.com,
	mst@redhat.com,
	stefanha@redhat.com,
	dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com,
	bchaney@akamai.com,
	mark.kanda@oracle.com,
	ptikhomirov@virtuozzo.com,
	den@openvz.org,
	andrey.drobyshev@virtuozzo.com
Subject: [PATCH v5 0/5] vhost/vsock: add support for VHOST_RESET_OWNER and CPR migration
Date: Mon, 20 Jul 2026 13:22:36 +0300
Message-ID: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0055.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e36cc4-de97-4172-0c59-08dee648e36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|56012099006|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	Uh7boKbp4PLdFCrwHyRad/YO/ZpZ04JSTHlAnOgdal8Hi+llUMSQe1TjTmkd+ALTcrMKfzt/QkSP9m+ZZTTFmiXbmsjW/LysyIynYBAwT11gbpQuXTRGM3SBmucXc42FnWNm6/jKeSSyub884T2cetyJCNDEjEVCNRW+FyUZhplHiOGi2yRsYkakwxsudxkHOq+pFThvE2PrZHzOPZifuXIuBiAf5yg1FeKo4iNut+nMWeR+ZXgYVJ4asIguM56lJ4uSQSd9+kr2vQBmE93nu37F86FrjqcHmm1hCOe/dVYpiN22U+eWmNFxPwLSircsFzU8tF9s01GQdBUO4EW4jndLChY2k5bEoVE8NlGyelih/wgNLrkLEEc6RuWT8m4s8MO1HWan1ynfZVrR2+AYKojSudTAKr7iMDuGA2EI4kS/P1OvZQX4nm1aiN0ZTE4o7kHrxvogn9Ts5FO2pPNvD0HIvayBydYc1P9MwLFhempI+/s6gB0QOcb5SGBddFy0qy65/Yn4NREoLABkQ1HYHl+Lt3SYDG4O+i1/VQJZ8Qeh3JRiXwM+EfAv/d1gmuYjWQQCpKKbdQD1DuFEBjx1pYQ6/aKAmjhyoJUOiFm1zD46OQKF7xcvCfN36gSlyUOpLlFbk3D4zZQzD9WD+79GDDb0zs8Gd/mmKTmz6Ds418M6Qv5q7sCvBDwbjwCRJNT7YTG1rggDyxgGsHxBhROdJDdZLmNA/nQaTm41PfxQ30k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(56012099006)(38350700014)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2m9HbgjY+ATEiQBpsBzMsn93RNh7PZagBTKG+Tim0dFQxHO91pcnaC53bnlO?=
 =?us-ascii?Q?seSa81b0ZAKKmCZ8U4r+XMGNw3kMkoQOOC2WbVaCRdBMFlgJfOxo1I9o6vtn?=
 =?us-ascii?Q?HO3Fj/1DeswLjMedpmKc/oZcryPXJWa+/j1yp3yRYg7wSE3b3SNh48wcnsx2?=
 =?us-ascii?Q?6wZ2QRvuggj98p6dpnZNokkOVU/7+lpSYVGhihby2+Yyi36wILj3DQIDs3j4?=
 =?us-ascii?Q?ZauqaCVIQKS3t7PYm+6timf/ZBbOmAzZLjHtTgBuz0A1BUaAyqLGrZjrdppE?=
 =?us-ascii?Q?aJA1ZaWRl6vWKQivYUoKD8NPfDxnVTGYej/s7kU3srZgNkHCVRr48s3Km5pe?=
 =?us-ascii?Q?n+XprWbAGxyPc9PwfLeb/hy8zL/csmcn6cYMh8KF6vnHrtI1wv7zelA8O6Wj?=
 =?us-ascii?Q?R5eGMgsBLSj9x012yugEVcbItgp2NPsh9pJfjEHNU0VoCFFavbB6/BEfv8mf?=
 =?us-ascii?Q?7sTQL3Gbg8BexsXV+o1juMpu1eVc8ZjLSOO/ib1YEKiFl+Jh+pN+yVjXLBTo?=
 =?us-ascii?Q?/ilWqLAguvXpfDp9PwQ4dXhcf+VjpBHwtjgehCUiIUbFIlv2gxJKhfDoNcHs?=
 =?us-ascii?Q?d8zSH0OLcjD6TDH40MwpRC4VmmGeKwpRnnyRWf5OnZDWhBOlYxQjJb/Xij1L?=
 =?us-ascii?Q?3TSClvASxQL4SP2rtkX9+1OyOjWGBuZJwTIt2XzWvhthhZEo/9k0uWENZ2F7?=
 =?us-ascii?Q?Gnw0oHSAD+5ullVfTG+4krhlz8+u/OPYB7Xal6yaZQCMiOwlBgkTR7+/TTZ2?=
 =?us-ascii?Q?Samr+Syw4xVUWuKrdO1HjFcYva4yC66l6VU/hqVeS5lt/sTqVLHIHlP2TNci?=
 =?us-ascii?Q?Sj60sFT/qI95mwMccEnOkiC32TE5izPKPCcm0EwVzEjw9CXsbT2pTblDJ2N9?=
 =?us-ascii?Q?v7cgnoQrP/oIp48PxZlv+OolXxYL/HQNVYsbDZ0v6xiFRzs5hkuSUB6SeG8y?=
 =?us-ascii?Q?8Hre5mQDxL0LPyYVWM/kSyCHbAn5761tUB3Ul8O9tlWPugz/LkFHMWkEw9ym?=
 =?us-ascii?Q?vc/y2BIV89i8nLPpcd1QGb2hWndkXwZwPxLiQhLk3/QRBowf9VIw5TT7CTsI?=
 =?us-ascii?Q?OKjKd70yuUITpEP0RloFrm/MIKoEV8EL7gV0HTjvmBFP4qD2SEXP3PeOnLr+?=
 =?us-ascii?Q?B8y3txfD4emyCO/ihnlDdCCVR5rxwy9wEVzBqo44It5YvlsgLTp33dpMZyJl?=
 =?us-ascii?Q?XTf41cjB+RFLf9XuTj8Ocy26eRtAXKXp177eYpjzDiUaMjBr2VhvUcyWz1lI?=
 =?us-ascii?Q?Xrqwv/cUdrq2uwzyyKcQTjJjReUre1Db0eMGfFFpXFyU+xb49hAOWrP2vZTp?=
 =?us-ascii?Q?m6+a3mRSLxvg38QwZysVO1CkHWD91VfjitNz97NbIHe6YdQ3abP5qfCYDjmd?=
 =?us-ascii?Q?Ox9gWpjDZA9u43C+AC1hPiL7gPeHjz650G9bcqr/zTPvGwpxZHmRVrzhI/im?=
 =?us-ascii?Q?E1v3dPwfaLHCp66yklmquId7mzPmkhc3/5aq2Vri9UZrqHhmoB9aM07ORl4o?=
 =?us-ascii?Q?krG/pbSqf5fDBb5SlyOKTy6tD62OfwrGp15jty33yy3Q29L0xhP6Nseg84Yl?=
 =?us-ascii?Q?z9B0xvsQhRQ4NNdrD5BD7hLpBCcNF6d0+z9N8Rk3Vguf5Z08CzcM2tq2iE2z?=
 =?us-ascii?Q?vCY6LuqSzaQKeq40O4TVFgOM8DDomh2BiyAVyHjCMJ1puIF0p6F67N6Raiww?=
 =?us-ascii?Q?5d9IgkFf88rpHIBnlZ0e1BIv3bGG5ffSl/wF28hQTfWF3JjgNFlYY3HhwJcc?=
 =?us-ascii?Q?pHtodcaYJm+6+rsa+5kyX1VeGjQvvxI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e36cc4-de97-4172-0c59-08dee648e36b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:23:06.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ug89YyfsPm2a+R8eGXEJ6Z0rxLAWpSC4PtPWgjjfwgHcbGhGFxCL768B7SMcVUeq1EBQf/djtsG+Z30Gr7f1WkXVv+ZviBIMP30rjLonwFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6264

v4 -> v5:

  * Patch 4:
    - call synchronize_rcu() unconditionally;
    - call vhost_dev_flush(dev) instead of vhost_run_work_list(worker)
      to drain remaining work;
    - reword comment and commit message.

v4: https://lore.kernel.org/virtualization/20260714151638.143019-1-andrey.drobyshev@virtuozzo.com

Andrey Drobyshev (3):
  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
  vhost/vsock: re-scan TX virtqueue on device start
  vhost: synchronize with RCU readers when freeing workers

Pavel Tikhomirov (2):
  vhost/vsock: split out vhost_vsock_drop_backends helper
  vhost/vsock: add VHOST_RESET_OWNER ioctl

 drivers/vhost/vhost.c | 11 ++++++
 drivers/vhost/vsock.c | 80 +++++++++++++++++++++++++++++++++----------
 2 files changed, 72 insertions(+), 19 deletions(-)

-- 
2.47.1

