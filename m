Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92C3C77B6C
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 07:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C91F83D0F;
	Thu, 13 Apr 2023 07:33:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C91F83D0F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=dAP0wH05
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZJO4chkS4O8; Thu, 13 Apr 2023 07:33:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECBC583CA0;
	Thu, 13 Apr 2023 07:33:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECBC583CA0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94758C0036;
	Thu, 13 Apr 2023 07:33:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC91AC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 765B940CAA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 765B940CAA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=dAP0wH05
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rxGh-ME-VyzN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5A0340FBF
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::60d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5A0340FBF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUrG6V4j2sSXEQ7TynxfyQ8DmamV0xkw+Ih37YBwbjfWy2F9MEwFlvS3+wZvUlJn4/LLrfS3rHes7sz6QwAekFer0tqXN3RIYVHONyDcXj7sW16F0vxHNXsJDyhtFZAKlAXdwFCJKYTDvP5BjOJyhx/+1558y5JPjXfYW/iQiVUNh6gmxLFiA0w02eGhUSfgu4rw5Q3huA5OKFMGBChbqKAfBLibeWQZIXFMa+owO2WTB1WirIYVpxPdzEqqO7vbZDPTkiM7/TtBA3iWI2/oMd09dcajCLxIspu9hzeduyC65F0yV6EqC2J6BXkC4dXoHb4X8Sz2myopCEWy0Bz4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6nVVIx3AaCYJoTbVp/3hdmdkrTk6Oey/KqDySQdOv8=;
 b=GKljwRJDeP2KFNC7Tc+/lODiLMGYBa8ogaQ9c4R1vFGQimT8rTvAl+TG6po+bvmCnjy0TM7lbF9QyrzENIy2J5YcW0yy+qQBZESg5/8NRE9tRWBQGSR/nizEEN+lS/V0NJz3rG2PpIxK1laNGeOabpUnQ0mAJ0pUPJpFgOSFRMBmfrmStX56TtnNQ2NGIRMiJ4JSaIlJoKQbLRF2UDUrTDKesresZjvwPFecBvgNpdQL5VAnPIUdur9hO1sXDXKUTV69i7FoOnC+oz2t3QxoF58H6jpWxow0yB3VnqvebQ/IK0p96+8DdBlXIynGTHa1vkosopzZBbjnBToUxH/3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6nVVIx3AaCYJoTbVp/3hdmdkrTk6Oey/KqDySQdOv8=;
 b=dAP0wH05Df0Rzdb5HjDxtie61DBDSkNPfn+26ff1hm8gOalgXol68GYZVAangdMMupHhWc1sfIt9vEpjzohZvxj1pcPDTC9n7Eyr8k3jPVZ6NmLpPxLbXK3P8KCm8SbK/XBTb+3CrwhhleO89yXYdUyQhjBNWAJ1DqaVaP+8DTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 07:33:47 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 07:33:47 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v4 1/2] vdpa/snet: support getting and setting VQ state
Date: Thu, 13 Apr 2023 10:33:36 +0300
Message-Id: <20230413073337.31367-2-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413073337.31367-1-alvaro.karsz@solid-run.com>
References: <20230413073337.31367-1-alvaro.karsz@solid-run.com>
X-ClientProxiedBy: ZR0P278CA0122.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::19) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cba093-fade-449e-e10a-08db3bf16b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJoQ27Mh6yDLAys5d3OspJw/q1fFiKdqcYAJtPf3JEDP/7tVvhR6/19nqGphwdOkYIRQRXt1wKf3vMXtQ4BrmGfmZ4zzQWRjRJ+bjm7ggq2yFSDQ4W+6C34M/tLiFIFMUe8g8hUvLgHR/ndFcAfIMLdaLjutik9CiJbBi4dFvDR4+msYLRPQJsUPyXKP8s235wCZ+b/tZa9MqcIuUlG/t9RJoX99dQppanZtISGFx7QgFUq5LIWHvp640bqH/r84d7l8kx0xDtWwlBAdf3d0P+luqGsIdWe3BmegZW4lwJgnehgj8L5a1UObN0m5FnT+S7bbw8wl6O6t0vz81tbOz+CZ1QZTvOkvX09PEzr2S7bHgDKRc1nDtWUrBYt0ZRWrM0BoZBRGQJRDDBdBCIdw8PdoZ58VqN9C9qJDGSJbflTO1mIg1ZVnVF98ZpdxR9hYs2hGSKrkoh2YmvCaiGGvJtwlNk9hc2Et3xSrxAcLk0ETy2RlWQ5ojxOD347+eHbkAgMJrvMI1BWa9I7VEKfmHgm0Ib9keyYsqcy7Gjsd72WREFsQEtgvNhGdg/G+z0Q2OyMFOfG1CSrDXr9l51di5+Au22cDWOS9OO+InrtegfMVFlnh7ffsSADJoWdE3/gK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39840400004)(451199021)(6666004)(478600001)(52116002)(83380400001)(36756003)(38100700002)(38350700002)(2616005)(86362001)(2906002)(6486002)(30864003)(44832011)(316002)(26005)(5660300002)(1076003)(6506007)(186003)(6512007)(8676002)(66476007)(41300700001)(4326008)(107886003)(8936002)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oT3glRlCv9LGgCu+lzFppzTO7H//7T2p9IYA1UbmsC8AswgFKZ+X94v3QA+t?=
 =?us-ascii?Q?IgADLreJuDqOAA7mkE3p/kX9SS5Ph1N0Jkp2CcNz1BRaFB20XKjiWmoq4T7s?=
 =?us-ascii?Q?PFxPnTl0oMgSaYzcp7P06Xtx7SQHWusNCwFBqxXFybcP7D9aCZ24CY6c0uWE?=
 =?us-ascii?Q?oeNOFez7ULbWuwQ3hHRI2TeteRkvMO9lThK+87yGzLHCr2Q6eU6ykSbh+LKw?=
 =?us-ascii?Q?crP0+2uQMrg50YOV7j9eG0P4QrCwQW/QclQwSNv+YA5iJk8Pq+fHugqIZJjM?=
 =?us-ascii?Q?RMUxXur8OiSXHX4LL5QUJwsw44+d3G0t1COhRL/hG++1YJHxzSlpHaIuurAc?=
 =?us-ascii?Q?HRcMmRMQi52vUEDzIF9CHmsMhlhlyWfq4nwIKS3Ciwi/HrHrH4cP/ZLy2uf5?=
 =?us-ascii?Q?AdvOCGc0nASYZgX+IyDtqqv73gd6aUWA2CybCBFe+PV0SxNgBrNm4IWfwbs7?=
 =?us-ascii?Q?gKVyAuxrezedxXjKSSHpEsmtYzpzvBsr+SXr1lnBa+XvWbLVQ+nZ6+gvdrx0?=
 =?us-ascii?Q?/VX78ei3RpU5dW868S3I1ZjhXibTOUs76yAqE9TSMTNDloyia+vvlR54G3WK?=
 =?us-ascii?Q?5IJh86OqKgX3+KRlky+/D7X5mqTs1zG7Wef0OL3q80UwhITQm5apKL/jhKYW?=
 =?us-ascii?Q?AXCKNVLE7YvvBr5OvVdlBOAr63oZhL2fOk84ugW+KpqRtDaXI5xt086jJaZ5?=
 =?us-ascii?Q?cU1z9fZ21SjQum+Ei0uH8MmFyxcbILT/NAEclmicFAjMQLF/69f47HJi3e4j?=
 =?us-ascii?Q?+NiAl3QvzpYtk0SyOW2R+Y8TIBDjLWNBc5Jq+gEWNvWDfF5IxsKmKKYub4b2?=
 =?us-ascii?Q?m7yFKLBuF2ewefCJV6RdWOk/hE839pNXJkIKAQr8vvxZK1BKcNaDcdf5zUtc?=
 =?us-ascii?Q?bn+qngbLeS7XZST4rb8E75yAoTPAUcE6gpblmW7Br2GeEIOFKE4+7wCGnWPv?=
 =?us-ascii?Q?uYBlMMaoZ/5ZyP3V3jlgymQ+XfYYkxPaaQS5bY1Uh40+vxvBabyOsDsUiooy?=
 =?us-ascii?Q?ZShqvM2wOamShptTWVF7pT1CmBsfp1JtFafsqzlbyMaOwhoEYGXrZkJA8hjy?=
 =?us-ascii?Q?v+ujjhfXbwImFUQfBeRIqDFh8RwzErQVOQM7Z5q1W0+rMhO6IbuF6Xo2hdS7?=
 =?us-ascii?Q?MhHZ+DJzIJCj/H/QheB5+wYqS/nBEmDxaDmYtJlwfOrsl/GTmDDsgu51PqE+?=
 =?us-ascii?Q?0FfPFMb6VBIGonVu4p/BrUGt7R5TDHaYFhDhFfUL3M1EmpmwCSGht9bJ4e3g?=
 =?us-ascii?Q?R+0i60xVA385bxxrBVvLZVKJctu+aRWchN3BNXAaghy8Ewt6MovXuQW7bMFt?=
 =?us-ascii?Q?lU3XWmNcMhR/yUcE7WN0jqZVDk1t46waCx41AvveOONliCS8HN8kiw+rM1A4?=
 =?us-ascii?Q?5ffc//pJyU9iratKXIyq7M5lzgyPKrXNjHWIGn0lebCpWd0ZYvl3SUikO1Qc?=
 =?us-ascii?Q?4Yp00gt4ZdbwWboWaFvVJxvkSwicdSDqcCznI+Brv55SDkcIdv/eAjIAvIbo?=
 =?us-ascii?Q?YGWOgy+9fvkYoiwDdgn5xnpOpRKTvV5pAst54645sYjnOvlKplHS597creiC?=
 =?us-ascii?Q?jkoIsxM3nH762srFgo0PF9gKPpX6g1du6j37kXbCZKUMgqqjhdkFdGPgxIzy?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cba093-fade-449e-e10a-08db3bf16b21
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 07:33:47.5957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTqTGBoL6KvlrWCAk8sRyi+fhgvsh5RF+5NnxZSSM/FCRYPDLTMdICGzQk3ubZV/GbC8GqkII2K/VHw2RiMtNvCixB+GitJaNIf0VJ4MdWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
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

This patch adds the get_vq_state and set_vq_state vDPA callbacks.

In order to get the VQ state, the state needs to be read from the DPU.
In order to allow that, the old messaging mechanism is replaced with a new,
flexible control mechanism.
This mechanism allows to read data from the DPU.

The mechanism can be used if the negotiated config version is 2 or
higher.

If the new mechanism is used when the config version is 1, it will call
snet_send_ctrl_msg_old, which is config 1 compatible.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/solidrun/Makefile     |   1 +
 drivers/vdpa/solidrun/snet_ctrl.c  | 324 +++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_hwmon.c |   2 +-
 drivers/vdpa/solidrun/snet_main.c  | 112 ++++------
 drivers/vdpa/solidrun/snet_vdpa.h  |  19 +-
 5 files changed, 387 insertions(+), 71 deletions(-)
 create mode 100644 drivers/vdpa/solidrun/snet_ctrl.c

diff --git a/drivers/vdpa/solidrun/Makefile b/drivers/vdpa/solidrun/Makefile
index c0aa3415bf7..9116252cd5f 100644
--- a/drivers/vdpa/solidrun/Makefile
+++ b/drivers/vdpa/solidrun/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SNET_VDPA) += snet_vdpa.o
 snet_vdpa-$(CONFIG_SNET_VDPA) += snet_main.o
+snet_vdpa-$(CONFIG_SNET_VDPA) += snet_ctrl.o
 ifdef CONFIG_HWMON
 snet_vdpa-$(CONFIG_SNET_VDPA) += snet_hwmon.o
 endif
diff --git a/drivers/vdpa/solidrun/snet_ctrl.c b/drivers/vdpa/solidrun/snet_ctrl.c
new file mode 100644
index 00000000000..10cde502f1a
--- /dev/null
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SolidRun DPU driver for control plane
+ *
+ * Copyright (C) 2022-2023 SolidRun
+ *
+ * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
+ *
+ */
+
+#include <linux/iopoll.h>
+
+#include "snet_vdpa.h"
+
+enum snet_ctrl_opcodes {
+	SNET_CTRL_OP_DESTROY = 1,
+	SNET_CTRL_OP_READ_VQ_STATE,
+};
+
+#define SNET_CTRL_TIMEOUT	        2000000
+
+#define SNET_CTRL_DATA_SIZE_MASK	0x0000FFFF
+#define SNET_CTRL_IN_PROCESS_MASK	0x00010000
+#define SNET_CTRL_CHUNK_RDY_MASK	0x00020000
+#define SNET_CTRL_ERROR_MASK		0x0FFC0000
+
+#define SNET_VAL_TO_ERR(val)		(-(((val) & SNET_CTRL_ERROR_MASK) >> 18))
+#define SNET_EMPTY_CTRL(val)		(((val) & SNET_CTRL_ERROR_MASK) || \
+						!((val) & SNET_CTRL_IN_PROCESS_MASK))
+#define SNET_DATA_READY(val)		((val) & (SNET_CTRL_ERROR_MASK | SNET_CTRL_CHUNK_RDY_MASK))
+
+/* Control register used to read data from the DPU */
+struct snet_ctrl_reg_ctrl {
+	/* Chunk size in 4B words */
+	u16 data_size;
+	/* We are in the middle of a command */
+	u16 in_process:1;
+	/* A data chunk is ready and can be consumed */
+	u16 chunk_ready:1;
+	/* Error code */
+	u16 error:10;
+	/* Saved for future usage */
+	u16 rsvd:4;
+};
+
+/* Opcode register */
+struct snet_ctrl_reg_op {
+	u16 opcode;
+	/* Only if VQ index is relevant for the command */
+	u16 vq_idx;
+};
+
+struct snet_ctrl_regs {
+	struct snet_ctrl_reg_op op;
+	struct snet_ctrl_reg_ctrl ctrl;
+	u32 rsvd;
+	u32 data[];
+};
+
+static struct snet_ctrl_regs __iomem *snet_get_ctrl(struct snet *snet)
+{
+	return snet->bar + snet->psnet->cfg.ctrl_off;
+}
+
+static int snet_wait_for_empty_ctrl(struct snet_ctrl_regs __iomem *regs)
+{
+	u32 val;
+
+	return readx_poll_timeout(ioread32, &regs->ctrl, val, SNET_EMPTY_CTRL(val), 10,
+				  SNET_CTRL_TIMEOUT);
+}
+
+static int snet_wait_for_empty_op(struct snet_ctrl_regs __iomem *regs)
+{
+	u32 val;
+
+	return readx_poll_timeout(ioread32, &regs->op, val, !val, 10, SNET_CTRL_TIMEOUT);
+}
+
+static int snet_wait_for_data(struct snet_ctrl_regs __iomem *regs)
+{
+	u32 val;
+
+	return readx_poll_timeout(ioread32, &regs->ctrl, val, SNET_DATA_READY(val), 10,
+				  SNET_CTRL_TIMEOUT);
+}
+
+static u32 snet_read32_word(struct snet_ctrl_regs __iomem *ctrl_regs, u16 word_idx)
+{
+	return ioread32(&ctrl_regs->data[word_idx]);
+}
+
+static u32 snet_read_ctrl(struct snet_ctrl_regs __iomem *ctrl_regs)
+{
+	return ioread32(&ctrl_regs->ctrl);
+}
+
+static void snet_write_ctrl(struct snet_ctrl_regs __iomem *ctrl_regs, u32 val)
+{
+	iowrite32(val, &ctrl_regs->ctrl);
+}
+
+static void snet_write_op(struct snet_ctrl_regs __iomem *ctrl_regs, u32 val)
+{
+	iowrite32(val, &ctrl_regs->op);
+}
+
+static int snet_wait_for_dpu_completion(struct snet_ctrl_regs __iomem *ctrl_regs)
+{
+	/* Wait until the DPU finishes completely.
+	 * It will clear the opcode register.
+	 */
+	return snet_wait_for_empty_op(ctrl_regs);
+}
+
+/* Reading ctrl from the DPU:
+ * buf_size must be 4B aligned
+ *
+ * Steps:
+ *
+ * (1) Verify that the DPU is not in the middle of another operation by
+ *     reading the in_process and error bits in the control register.
+ * (2) Write the request opcode and the VQ idx in the opcode register
+ *     and write the buffer size in the control register.
+ * (3) Start readind chunks of data, chunk_ready bit indicates that a
+ *     data chunk is available, we signal that we read the data by clearing the bit.
+ * (4) Detect that the transfer is completed when the in_process bit
+ *     in the control register is cleared or when the an error appears.
+ */
+static int snet_ctrl_read_from_dpu(struct snet *snet, u16 opcode, u16 vq_idx, void *buffer,
+				   u32 buf_size)
+{
+	struct pci_dev *pdev = snet->pdev;
+	struct snet_ctrl_regs __iomem *regs = snet_get_ctrl(snet);
+	u32 *bfr_ptr = (u32 *)buffer;
+	u32 val;
+	u16 buf_words;
+	int ret;
+	u16 words, i, tot_words = 0;
+
+	/* Supported for config 2+ */
+	if (!SNET_CFG_VER(snet, 2))
+		return -EOPNOTSUPP;
+
+	if (!IS_ALIGNED(buf_size, 4))
+		return -EINVAL;
+
+	mutex_lock(&snet->ctrl_lock);
+
+	buf_words = buf_size / 4;
+
+	/* Make sure control register is empty */
+	ret = snet_wait_for_empty_ctrl(regs);
+	if (ret) {
+		SNET_WARN(pdev, "Timeout waiting for previous control data to be consumed\n");
+		goto exit;
+	}
+
+	/* We need to write the buffer size in the control register, and the opcode + vq index in
+	 * the opcode register.
+	 * We use a spinlock to serialize the writes.
+	 */
+	spin_lock(&snet->ctrl_spinlock);
+
+	snet_write_ctrl(regs, buf_words);
+	snet_write_op(regs, opcode | (vq_idx << 16));
+
+	spin_unlock(&snet->ctrl_spinlock);
+
+	while (buf_words != tot_words) {
+		ret = snet_wait_for_data(regs);
+		if (ret) {
+			SNET_WARN(pdev, "Timeout waiting for control data\n");
+			goto exit;
+		}
+
+		val = snet_read_ctrl(regs);
+
+		/* Error? */
+		if (val & SNET_CTRL_ERROR_MASK) {
+			ret = SNET_VAL_TO_ERR(val);
+			SNET_WARN(pdev, "Error while reading control data from DPU, err %d\n", ret);
+			goto exit;
+		}
+
+		words = min_t(u16, val & SNET_CTRL_DATA_SIZE_MASK, buf_words - tot_words);
+
+		for (i = 0; i < words; i++) {
+			*bfr_ptr = snet_read32_word(regs, i);
+			bfr_ptr++;
+		}
+
+		tot_words += words;
+
+		/* Is the job completed? */
+		if (!(val & SNET_CTRL_IN_PROCESS_MASK))
+			break;
+
+		/* Clear the chunk ready bit and continue */
+		val &= ~SNET_CTRL_CHUNK_RDY_MASK;
+		snet_write_ctrl(regs, val);
+	}
+
+	ret = snet_wait_for_dpu_completion(regs);
+	if (ret)
+		SNET_WARN(pdev, "Timeout waiting for the DPU to complete a control command\n");
+
+exit:
+	mutex_unlock(&snet->ctrl_lock);
+	return ret;
+}
+
+/* Send a control message to the DPU using the old mechanism
+ * used with config version 1.
+ */
+static int snet_send_ctrl_msg_old(struct snet *snet, u32 opcode)
+{
+	struct pci_dev *pdev = snet->pdev;
+	struct snet_ctrl_regs __iomem *regs = snet_get_ctrl(snet);
+	int ret;
+
+	mutex_lock(&snet->ctrl_lock);
+
+	/* Old mechanism uses just 1 register, the opcode register.
+	 * Make sure that the opcode register is empty, and that the DPU isn't
+	 * processing an old message.
+	 */
+	ret = snet_wait_for_empty_op(regs);
+	if (ret) {
+		SNET_WARN(pdev, "Timeout waiting for previous control message to be ACKed\n");
+		goto exit;
+	}
+
+	/* Write the message */
+	snet_write_op(regs, opcode);
+
+	/* DPU ACKs the message by clearing the opcode register */
+	ret = snet_wait_for_empty_op(regs);
+	if (ret)
+		SNET_WARN(pdev, "Timeout waiting for a control message to be ACKed\n");
+
+exit:
+	mutex_unlock(&snet->ctrl_lock);
+	return ret;
+}
+
+/* Send a control message to the DPU.
+ * A control message is a message without payload.
+ */
+static int snet_send_ctrl_msg(struct snet *snet, u16 opcode, u16 vq_idx)
+{
+	struct pci_dev *pdev = snet->pdev;
+	struct snet_ctrl_regs __iomem *regs = snet_get_ctrl(snet);
+	u32 val;
+	int ret;
+
+	/* If config version is not 2+, use the old mechanism */
+	if (!SNET_CFG_VER(snet, 2))
+		return snet_send_ctrl_msg_old(snet, opcode);
+
+	mutex_lock(&snet->ctrl_lock);
+
+	/* Make sure control register is empty */
+	ret = snet_wait_for_empty_ctrl(regs);
+	if (ret) {
+		SNET_WARN(pdev, "Timeout waiting for previous control data to be consumed\n");
+		goto exit;
+	}
+
+	/* We need to clear the control register and write the opcode + vq index in the opcode
+	 * register.
+	 * We use a spinlock to serialize the writes.
+	 */
+	spin_lock(&snet->ctrl_spinlock);
+
+	snet_write_ctrl(regs, 0);
+	snet_write_op(regs, opcode | (vq_idx << 16));
+
+	spin_unlock(&snet->ctrl_spinlock);
+
+	/* The DPU ACKs control messages by setting the chunk ready bit
+	 * without data.
+	 */
+	ret = snet_wait_for_data(regs);
+	if (ret) {
+		SNET_WARN(pdev, "Timeout waiting for control message to be ACKed\n");
+		goto exit;
+	}
+
+	/* Check for errors */
+	val = snet_read_ctrl(regs);
+	ret = SNET_VAL_TO_ERR(val);
+
+	/* Clear the chunk ready bit */
+	val &= ~SNET_CTRL_CHUNK_RDY_MASK;
+	snet_write_ctrl(regs, val);
+
+	ret = snet_wait_for_dpu_completion(regs);
+	if (ret)
+		SNET_WARN(pdev, "Timeout waiting for DPU to complete a control command, err %d\n",
+			  ret);
+
+exit:
+	mutex_unlock(&snet->ctrl_lock);
+	return ret;
+}
+
+void snet_ctrl_clear(struct snet *snet)
+{
+	struct snet_ctrl_regs __iomem *regs = snet_get_ctrl(snet);
+
+	snet_write_op(regs, 0);
+}
+
+int snet_destroy_dev(struct snet *snet)
+{
+	return snet_send_ctrl_msg(snet, SNET_CTRL_OP_DESTROY, 0);
+}
+
+int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state)
+{
+	return snet_ctrl_read_from_dpu(snet, SNET_CTRL_OP_READ_VQ_STATE, idx, state,
+				       sizeof(*state));
+}
diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
index e695e36ff75..42c87387a0f 100644
--- a/drivers/vdpa/solidrun/snet_hwmon.c
+++ b/drivers/vdpa/solidrun/snet_hwmon.c
@@ -2,7 +2,7 @@
 /*
  * SolidRun DPU driver for control plane
  *
- * Copyright (C) 2022 SolidRun
+ * Copyright (C) 2022-2023 SolidRun
  *
  * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
  *
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 68de727398e..86769f436b4 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -2,7 +2,7 @@
 /*
  * SolidRun DPU driver for control plane
  *
- * Copyright (C) 2022 SolidRun
+ * Copyright (C) 2022-2023 SolidRun
  *
  * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
  *
@@ -16,14 +16,12 @@
 /* SNET signature */
 #define SNET_SIGNATURE          0xD0D06363
 /* Max. config version that we can work with */
-#define SNET_CFG_VERSION        0x1
+#define SNET_CFG_VERSION        0x2
 /* Queue align */
 #define SNET_QUEUE_ALIGNMENT    PAGE_SIZE
 /* Kick value to notify that new data is available */
 #define SNET_KICK_VAL           0x1
 #define SNET_CONFIG_OFF         0x0
-/* ACK timeout for a message */
-#define SNET_ACK_TIMEOUT	2000000
 /* How long we are willing to wait for a SNET device */
 #define SNET_DETECT_TIMEOUT	5000000
 /* How long should we wait for the DPU to read our config */
@@ -32,56 +30,11 @@
 #define SNET_GENERAL_CFG_LEN	36
 #define SNET_GENERAL_CFG_VQ_LEN	40
 
-enum snet_msg {
-	SNET_MSG_DESTROY = 1,
-};
-
 static struct snet *vdpa_to_snet(struct vdpa_device *vdpa)
 {
 	return container_of(vdpa, struct snet, vdpa);
 }
 
-static int snet_wait_for_msg_ack(struct snet *snet)
-{
-	struct pci_dev *pdev = snet->pdev;
-	int ret;
-	u32 val;
-
-	/* The DPU will clear the messages offset once messages
-	 * are processed.
-	 */
-	ret = readx_poll_timeout(ioread32, snet->bar + snet->psnet->cfg.msg_off,
-				 val, !val, 10, SNET_ACK_TIMEOUT);
-	if (ret)
-		SNET_WARN(pdev, "Timeout waiting for message ACK\n");
-
-	return ret;
-}
-
-/* Sends a message to the DPU.
- * If blocking is set, the function will return once the
- * message was processed by the DPU (or timeout).
- */
-static int snet_send_msg(struct snet *snet, u32 msg, bool blocking)
-{
-	int ret = 0;
-
-	/* Make sure the DPU acked last message before issuing a new one */
-	ret = snet_wait_for_msg_ack(snet);
-	if (ret)
-		return ret;
-
-	/* Write the message */
-	snet_write32(snet, snet->psnet->cfg.msg_off, msg);
-
-	if (blocking)
-		ret = snet_wait_for_msg_ack(snet);
-	else /* If non-blocking, flush the write by issuing a read */
-		snet_read32(snet, snet->psnet->cfg.msg_off);
-
-	return ret;
-}
-
 static irqreturn_t snet_cfg_irq_hndlr(int irq, void *data)
 {
 	struct snet *snet = data;
@@ -181,33 +134,48 @@ static bool snet_get_vq_ready(struct vdpa_device *vdev, u16 idx)
 	return snet->vqs[idx]->ready;
 }
 
-static int snet_set_vq_state(struct vdpa_device *vdev, u16 idx, const struct vdpa_vq_state *state)
+static bool snet_vq_state_is_initial(struct snet *snet, const struct vdpa_vq_state *state)
 {
-	struct snet *snet = vdpa_to_snet(vdev);
-	/* Setting the VQ state is not supported.
-	 * If the asked state is the same as the initial one
-	 * we can ignore it.
-	 */
 	if (SNET_HAS_FEATURE(snet, VIRTIO_F_RING_PACKED)) {
 		const struct vdpa_vq_state_packed *p = &state->packed;
 
 		if (p->last_avail_counter == 1 && p->last_used_counter == 1 &&
 		    p->last_avail_idx == 0 && p->last_used_idx == 0)
-			return 0;
+			return true;
 	} else {
 		const struct vdpa_vq_state_split *s = &state->split;
 
 		if (s->avail_index == 0)
-			return 0;
+			return true;
+	}
+
+	return false;
+}
+
+static int snet_set_vq_state(struct vdpa_device *vdev, u16 idx, const struct vdpa_vq_state *state)
+{
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	/* We can set any state for config version 2+ */
+	if (SNET_CFG_VER(snet, 2)) {
+		memcpy(&snet->vqs[idx]->vq_state, state, sizeof(*state));
+		return 0;
 	}
 
+	/* Older config - we can't set the VQ state.
+	 * Return 0 only if this is the initial state we use in the DPU.
+	 */
+	if (snet_vq_state_is_initial(snet, state))
+		return 0;
+
 	return -EOPNOTSUPP;
 }
 
 static int snet_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa_vq_state *state)
 {
-	/* Not supported */
-	return -EOPNOTSUPP;
+	struct snet *snet = vdpa_to_snet(vdev);
+
+	return snet_read_vq_state(snet, idx, state);
 }
 
 static int snet_get_vq_irq(struct vdpa_device *vdev, u16 idx)
@@ -232,9 +200,9 @@ static int snet_reset_dev(struct snet *snet)
 	if (!snet->status)
 		return 0;
 
-	/* If DPU started, send a destroy message */
+	/* If DPU started, destroy it */
 	if (snet->status & VIRTIO_CONFIG_S_DRIVER_OK)
-		ret = snet_send_msg(snet, SNET_MSG_DESTROY, true);
+		ret = snet_destroy_dev(snet);
 
 	/* Clear VQs */
 	for (i = 0; i < snet->cfg->vq_num; i++) {
@@ -258,7 +226,7 @@ static int snet_reset_dev(struct snet *snet)
 	snet->dpu_ready = false;
 
 	if (ret)
-		SNET_WARN(pdev, "Incomplete reset to SNET[%u] device\n", snet->sid);
+		SNET_WARN(pdev, "Incomplete reset to SNET[%u] device, err: %d\n", snet->sid, ret);
 	else
 		SNET_DBG(pdev, "Reset SNET[%u] device\n", snet->sid);
 
@@ -356,7 +324,7 @@ static int snet_write_conf(struct snet *snet)
 	 * |             DESC AREA                |
 	 * |            DEVICE AREA               |
 	 * |            DRIVER AREA               |
-	 * |             RESERVED                 |
+	 * |    VQ STATE (CFG 2+)     |   RSVD    |
 	 *
 	 * Magic number should be written last, this is the DPU indication that the data is ready
 	 */
@@ -391,12 +359,15 @@ static int snet_write_conf(struct snet *snet)
 		off += 8;
 		snet_write64(snet, off, snet->vqs[i]->driver_area);
 		off += 8;
+		/* Write VQ state if config version is 2+ */
+		if (SNET_CFG_VER(snet, 2))
+			snet_write32(snet, off, *(u32 *)&snet->vqs[i]->vq_state);
+		off += 4;
+
 		/* Ignore reserved */
-		off += 8;
+		off += 4;
 	}
 
-	/* Clear snet messages address for this device */
-	snet_write32(snet, snet->psnet->cfg.msg_off, 0);
 	/* Write magic number - data is ready */
 	snet_write32(snet, snet->psnet->cfg.host_cfg_off, SNET_SIGNATURE);
 
@@ -697,7 +668,7 @@ static int psnet_read_cfg(struct pci_dev *pdev, struct psnet *psnet)
 	off += 4;
 	cfg->hwmon_off = psnet_read32(psnet, off);
 	off += 4;
-	cfg->msg_off = psnet_read32(psnet, off);
+	cfg->ctrl_off = psnet_read32(psnet, off);
 	off += 4;
 	cfg->flags = psnet_read32(psnet, off);
 	off += 4;
@@ -997,6 +968,10 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
 		goto free_irqs;
 	}
 
+	/* Init control mutex and spinlock */
+	mutex_init(&snet->ctrl_lock);
+	spin_lock_init(&snet->ctrl_spinlock);
+
 	/* Save pci device pointer */
 	snet->pdev = pdev;
 	snet->psnet = psnet;
@@ -1013,6 +988,9 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
 	/* Create a VirtIO config pointer */
 	snet->cfg->virtio_cfg = snet->bar + snet->psnet->cfg.virtio_cfg_off;
 
+	/* Clear control registers */
+	snet_ctrl_clear(snet);
+
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, snet);
 
diff --git a/drivers/vdpa/solidrun/snet_vdpa.h b/drivers/vdpa/solidrun/snet_vdpa.h
index b7f34169053..09ff676e7a2 100644
--- a/drivers/vdpa/solidrun/snet_vdpa.h
+++ b/drivers/vdpa/solidrun/snet_vdpa.h
@@ -2,7 +2,7 @@
 /*
  * SolidRun DPU driver for control plane
  *
- * Copyright (C) 2022 SolidRun
+ * Copyright (C) 2022-2023 SolidRun
  *
  * Author: Alvaro Karsz <alvaro.karsz@solid-run.com>
  *
@@ -20,10 +20,15 @@
 #define SNET_INFO(pdev, fmt, ...) dev_info(&(pdev)->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
 #define SNET_DBG(pdev, fmt, ...) dev_dbg(&(pdev)->dev, "%s"fmt, "snet_vdpa: ", ##__VA_ARGS__)
 #define SNET_HAS_FEATURE(s, f) ((s)->negotiated_features & BIT_ULL(f))
+/* Check if negotiated config version is at least @ver */
+#define SNET_CFG_VER(snet, ver) ((snet)->psnet->negotiated_cfg_ver >= (ver))
+
 /* VQ struct */
 struct snet_vq {
 	/* VQ callback */
 	struct vdpa_callback cb;
+	/* VQ state received from bus */
+	struct vdpa_vq_state vq_state;
 	/* desc base address */
 	u64 desc_area;
 	/* device base address */
@@ -51,6 +56,10 @@ struct snet {
 	struct vdpa_device vdpa;
 	/* Config callback */
 	struct vdpa_callback cb;
+	/* To lock the control mechanism */
+	struct mutex ctrl_lock;
+	/* Spinlock to protect critical parts in the control mechanism */
+	spinlock_t ctrl_spinlock;
 	/* array of virqueues */
 	struct snet_vq **vqs;
 	/* Used features */
@@ -117,8 +126,8 @@ struct snet_cfg {
 	u32 kick_off;
 	/* Offset in PCI BAR for HW monitoring */
 	u32 hwmon_off;
-	/* Offset in PCI BAR for SNET messages */
-	u32 msg_off;
+	/* Offset in PCI BAR for Control mechanism */
+	u32 ctrl_off;
 	/* Config general flags - enum snet_cfg_flags */
 	u32 flags;
 	/* Reserved for future usage */
@@ -191,4 +200,8 @@ static inline void snet_write64(struct snet *snet, u32 off, u64 val)
 void psnet_create_hwmon(struct pci_dev *pdev);
 #endif
 
+void snet_ctrl_clear(struct snet *snet);
+int snet_destroy_dev(struct snet *snet);
+int snet_read_vq_state(struct snet *snet, u16 idx, struct vdpa_vq_state *state);
+
 #endif //_SNET_VDPA_H_
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
