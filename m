Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB41AC76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 10:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4D27141C42;
	Mon, 10 Apr 2023 10:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D27141C42
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=JlxNovRN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id spuOdOIO1FA8; Mon, 10 Apr 2023 10:02:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D724140A08;
	Mon, 10 Apr 2023 10:02:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D724140A08
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B86FBC0036;
	Mon, 10 Apr 2023 10:02:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 563DEC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15A0160FC7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15A0160FC7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=JlxNovRN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P-Pz3ZhNdkL2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EBD960B2A
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EBD960B2A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtPM+6E0elluih5msmTdgkLGB9MQ5ZXRv1RM6knmQN9CXvvvgmWFqBcz+uGxr8PB/imMb5qaS84vHQC2WNEWea4cbgM6Lvx5RZ3tr7tW3Sv8kIYIeIFbH9U8fhQQukWoDODpfvszlO9wnmqjE6cYcJBB6r2rkVm3i5r4JcVtzisvcjuEBJXr+Hqm3JMxKG3j/rRC9P5bsKZ4GRcnRrgq422HehUy7lpKz/24rm5wgHfLX3+fR54kjdSnRyuBJR/R/7LlG3Ij3/GQGM2+Z1OJ2/6+xnQdl8JAKjmauZFW6dVr2DXDwrZsLfz2uhVaiB/clnuK+N3ihGV9EcV8s2cNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ/MaM2roaIeYnorrjMV3MwSAlGZsSm9QSNAZcsL0YU=;
 b=lpa3H4Nf+a6MZg4GDuezZHMMjPit4J0qJBx3UplqmJdvNepX/0QIIZnIhvJ9kuf0DoUSRq4qgQsOUNOFadcBbkQi1mvJ/X4/v62HKTa3cs4ILkSKieNp3GAnBPYmJDmRnQI1vYpJFJn7+POCcySuz2fytfxzZH+zy6juszAW2A43PvNfdl0DbLqV9Nav6zsGGpJXS4Ay+Rxxdb8QeG3vdyDtPvAhWJaT6ATWQhwG1o0rQZUq5i8V5pXJqkilKpt6U+8EN+amDO3nHoZQmedlDSaGbVmGM89wKbcBtOc8iR83bkavJaB+1bbvUNXvH9BZh3teWpvO8dWbfD9gXN+PyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ/MaM2roaIeYnorrjMV3MwSAlGZsSm9QSNAZcsL0YU=;
 b=JlxNovRNppT7JJCIwtc8ooU5pXPTBwvV+9rVHx4xTB3/jNBzmO1iFfN3yL7pzBrK+Zd2n8cRqtL3V5JQJ4RvGB0QIkSpWMVBbDnIV1FO6LH2fNjdJWd46mOo7rPLdGjQpt4tnNeSkDPKS0h2AnI4iVqyBcRydArwUH8ou28R6M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PA4PR04MB7999.eurprd04.prod.outlook.com (2603:10a6:102:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 10:02:46 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 10:02:46 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Date: Mon, 10 Apr 2023 13:02:35 +0300
Message-Id: <20230410100237.3499578-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PA4PR04MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 3543b18f-a800-4d3e-5248-08db39aabb93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hc9CATLTz5bLV5Y9fHeZ4lH2sWmH4237PRi9e61Wk+Ss4BCMccibfWTMShb1pv2G4UuVXajLk/BEskiq05bSgcbNLVEnDp2KpD+yNQGBQO3kYCVIDi1Dd3jiXS1coBouRjdeT0YBrSVFUIlM+pC0Ss4MgTRBCN2PqWozDWpcR8vj3sWhd10IgulW+I/IyOlnmpduevWPQj3v8ZdOBOzwEcvotpp58mtUbk00hUdeb6hLTjP3q5sYADamHom1OuI5sZ3QbK0CqeWBZ4UFaery03jWBjvU25m1dTj7E6IjwgBSTu8MTjPkvgsFyT8IsBMXQZa7ySg2j/4SvjSvcfd3lABd3SnOU1kXPoKWMCbd/YIHlT7OfFcAafEwXdHhy4KZGx9SEnuF0EWb6Z5UYk7n078TlLczjBsRdsbQumv0sc24eHUsaTP0L8YDSqKN/P6fde2N6JExsX9RRnE7Iyht0J04rnpygDJtbvfcHkCOTKWKbQ7QpuxP+UFXjyWc2bmeKJBBP2rTvRfS86yOcgUAh1jM0+FIckzPiSLPrIo2DDA91lsXGxvOr1LDZMTNIpk2TW/+SGEndRSnhL4P1fo5Ia0Cp0T0KsheTPo6c3HoWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39840400004)(366004)(346002)(396003)(376002)(136003)(451199021)(52116002)(478600001)(86362001)(83380400001)(36756003)(38350700002)(38100700002)(2616005)(6666004)(966005)(107886003)(6486002)(4744005)(44832011)(2906002)(316002)(186003)(6512007)(6506007)(1076003)(26005)(8676002)(41300700001)(8936002)(66476007)(15650500001)(66556008)(5660300002)(4326008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6QRaIJ1U7Rw+tWSUF5oYcvZXsqnoRDksh+r0YgKrfje5xbl31glmAc6lgH+d?=
 =?us-ascii?Q?yQaPejz4IjZWBNzvOG9n+T5V7fJTYtI2qByewvB7g9OMFmBE/thncnGjLRof?=
 =?us-ascii?Q?6gqmjdRJd+l2RZutBVWqi5GFyRZ01b075vhEpyQB4sWcl9nOt8d/PdrZu4SB?=
 =?us-ascii?Q?6+p0XguPGEWGO+C1WT4iLH1GkBjxwlyrELjvauHLkwlvfyzchQc7Jzv3lz6g?=
 =?us-ascii?Q?5h3gJLutAD55bQ+LGtw0qh1E+wX8Z8QaPdcVMlu8ySUATCkOQDI22qNnWyVs?=
 =?us-ascii?Q?Ss2G3Ji/6wYe9N6EdO5d1R010PV3BbrSmMIeC2mJW3lmTyvfSaa/6DbvwEvl?=
 =?us-ascii?Q?ZfVy9VOREbjtUyfJY6GvY3Kr3JhScrvwbgPRra1W/FMiPeNfyFC7RjdtFMY0?=
 =?us-ascii?Q?feTUtbv1mbqZT+yQh0KAgwnfc3eqpQCn9DWKDqV21E5hnymLorsxdQ2R2cgD?=
 =?us-ascii?Q?jcsi1VXRw7HkpDcWG3FqGkbAGrmvuUs+xWyo3kGZZYwBxM9gqqak0BrMP8PF?=
 =?us-ascii?Q?Z4tDtX/niwkm3WqLmri37cYekZhi3Bebjjy65He+ERvDLm1U1wutscmcktUt?=
 =?us-ascii?Q?9IKofxQawoRwp2nyLYD3LWIjmxCF4kfT5D966Yc4BUZODFDRbZRWmn75df6M?=
 =?us-ascii?Q?lxIDLo2Ue9u34THxxA9ESBFuDku9eZ+sunC3H2QHgqPWUpozhb4LoxVOfsC+?=
 =?us-ascii?Q?FqN+9vlcYf6l1qWrB9achmeFX/j3OOuakXN1ZrXKYq9QDUFGsf/tbder+P3p?=
 =?us-ascii?Q?uI81aOE4rxTJ5OJphEwrFjgnm8zXb7wlvRkCssT9epnebmOsvpBc8Bf8qn8T?=
 =?us-ascii?Q?s3Nw8Jv1dUgZVdYfw2m4rUVh95UMsegxcScMFxMtr+hVUyHU4rqCU+fO8hS7?=
 =?us-ascii?Q?rlKIK+FcPPKaePms0KPjH3DRVpgATmGBrTSgkOT+s50giDAQJXgkZwpYsj2w?=
 =?us-ascii?Q?M0UTdSI0B/DDb6lOrVYWwEZitPVY9Um/3IkrIuvPw/NYjP4ys5spz331rFQd?=
 =?us-ascii?Q?5eGFv7WEOTzUn86j0CcxbUWnXxyI1IJzDhswZxs6r/8q/ndyxJe7uwsHhJCO?=
 =?us-ascii?Q?Gsm/peyr1FOwmDkqJsynksXW0pib8w0SGArbGbl8p1HQjyIDLDQ4IejdMqnQ?=
 =?us-ascii?Q?IPyvN3FNuwzvDypmy2D4FcZalgrh5J6xUK5k1QBpYSzvzNn6RQmUIrAR9odB?=
 =?us-ascii?Q?N3zDFINDQ8PAa7ij4QxjjefvHLNrZYGghwI8FSgZp/kmawB8iiUhXFOs3Rt+?=
 =?us-ascii?Q?gasihSKNUBuCisComczoSkMDOgDT3UdzgeiiKFs9q/i5ZCKc5YU/ULV+ub9V?=
 =?us-ascii?Q?fQEntdoTaRnQLsMQI5jLYKO2f34b4vT9vKe8swaEwRCfVpLwHHDMbZw5BAYj?=
 =?us-ascii?Q?cd9LnhFToHqrqdh74I6iXjCavteVWxkqG3jipeupGWMei9AhMUErYk4YrUUD?=
 =?us-ascii?Q?jq6PGxegRlBQt3WzP+kruqbsxcbHPgbvT/+LY9IycY5Z1MUNr4lV/+mCQQSC?=
 =?us-ascii?Q?avegeQFmoQsN52FmWDY7avmV0HVrIpV8vl8ga+XtBjefkNaFA4n9M31xBbcT?=
 =?us-ascii?Q?zBnQc9LPqnc2ivMEMb0ZFt2jxh4xb90iItVeVbyrxtWZZFT++B5QJ1IkJAt8?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3543b18f-a800-4d3e-5248-08db39aabb93
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 10:02:45.9502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGXiCw+KnUN6p1gke+pbS12f9udpeBo+xZWubjMDXFInFFdCRj0kYaYD4+ep9OrWQKb7J76YXyD5xLMN6K92ECVvFgJItcqaZ3nCljfG1t0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7999
Cc: virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Add more vDPA callbacks.

[s/g]et_vq_state is added in patch 1, including a new control mechanism
to read data from the DPU.

suspend is added in patch 2.

Link to v1:
https://lore.kernel.org/virtualization/20230402125219.1084754-1-alvaro.karsz@solid-run.com/
Link to v2:
https://lore.kernel.org/virtualization/20230409091024.3437405-1-alvaro.karsz@solid-run.com/

Changelog:

v2:
        - Remove wmb() from snet_ctrl_read_from_dpu - Patch 1.
v3:
	- Usage of spinlocks to serialize access to control registers -
	  Patch 1.

Alvaro Karsz (2):
  vdpa/snet: support getting and setting VQ state
  vdpa/snet: support the suspend vDPA callback

 drivers/vdpa/solidrun/Makefile     |   1 +
 drivers/vdpa/solidrun/snet_ctrl.c  | 329 +++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_hwmon.c |   2 +-
 drivers/vdpa/solidrun/snet_main.c  | 127 ++++++-----
 drivers/vdpa/solidrun/snet_vdpa.h  |  20 +-
 5 files changed, 408 insertions(+), 71 deletions(-)
 create mode 100644 drivers/vdpa/solidrun/snet_ctrl.c

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
