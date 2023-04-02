Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C806C76196
	for <virtualization@archiver.kernel.org>; Sun,  2 Apr 2023 12:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38A4740986;
	Sun,  2 Apr 2023 12:52:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38A4740986
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=PckB1yET
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CTiaCuA0JysU; Sun,  2 Apr 2023 12:52:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5381F41601;
	Sun,  2 Apr 2023 12:52:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5381F41601
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AE72C0037;
	Sun,  2 Apr 2023 12:52:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4877C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C36E409E4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C36E409E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jimvBcXBBdR3
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A52C340986
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A52C340986
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq5UwxQ3gJrt6P0cv07iD2nPntdOGWrJ9aS429GPp6MyfJdWTr+Q90TIbnyHFGWLBP3QUGMEjabFKVP+0FLv/sfrdRIKWgMLhla9Y9UFnDtvQOLYCKM/Pver1KIevuyx5Dw1ZcjYSmZUxErypqtDefCbiVXaTSIq4jIEW1LjH3rtT+VA66OpuYFknDG6lpo4TmCRy3Zca+ZsIjhFEbohMannsbhjPI/6T+kPstHMT2n4tAVS8kVuuGI6pP7VwYMRWTYtMl3aS97U003Yiq1fVbo7cFN1SIdnIfxqvtbltFCQ6Y7pcs/Tgya2VPgmNMAXkN6DwZEn1FNF7iKo67NM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCWhuAu5m9J8wm3m+mXTfcEkMydZaYTkCE7DE7EgP/Q=;
 b=jikLX3+wryU3E4+L5luBdTA4I+jcrsKJ5SIQ9WcjrXGSWEQSxWS8mgOCA1fB9wZ05gH7RPpRSXQLdp4K/UmE+cIpKO54iXWnkbqazsEeoHb5cZJeUFd0zhxpVP1fFJyHKumbJGHWz7xXLNNyOJAyJEbkY9R2Zrzf16hE0KrYW5ZrHk0bgMWtMbCbVNFXTiFPC5ZnZxow1bb9pBZIZW/RMjADaq8eSviigUWzQAVRYs4fXg7elsOlkq+lPghN5CTg5rRH7fZpTnvfu7cgYhcqhQEhEYCvhihN/RFaGukvzlEEAIpjI4AfInFn2v7aazTyFqaAJM/ChPvKhnY8yhmcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCWhuAu5m9J8wm3m+mXTfcEkMydZaYTkCE7DE7EgP/Q=;
 b=PckB1yETJB5y2B5lJjKFuF9zNNAHkandW1w57d14ll1Qs+7/7hIfR3xDQoHrZ8+SW2a35UDHB9MJNm0F/an1pbeyo7eUhovo7r6pg+h2xNoe0K4/a6ey2OcyoE1OFT4g5ZwQECXxi4vY0kiM01IwZ/BmIZ9Eiqz1RnXi9xIpPzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DBBPR04MB7818.eurprd04.prod.outlook.com (2603:10a6:10:1f2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Sun, 2 Apr
 2023 12:52:38 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.030; Sun, 2 Apr 2023
 12:52:38 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ state
Date: Sun,  2 Apr 2023 15:52:18 +0300
Message-Id: <20230402125219.1084754-2-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|DBBPR04MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 313003b2-1c2f-4da9-6ab2-08db337923a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+e0zDB5mOj4J/HGe2gR6JlyI18n6Nznorw/nxenDGcPakbWEP7A0+uiWl8g61gG7+ad8Jhrc90ocIUFYHGhdbPF7DELFl/Gfka5HFO4v/EhAz9oRWi1ynPd34WjoX3rSql4W5ivk42esqQIlPUiWYUpy/iJ6OZSDguTzF5cq5I4+QdKwPXIqeXZQyUAn9jjuCyKefIjUbkathh6ab58MkeVjHVgxQTP2Qg0PWD382awW7jijBs9AwulHQvb3sIkYxdnDmkzmYd2YmX2AU9mVFt6oLgiwlEeWmiyWBfs2M92xcAmAXEiZi8erWA1tQSmUpCCZH6moq8muusyvQd4KzG2wjELdGda5BXgRqVfJXmoMU8vy6J5NCEh+Gjuf7PysuD7ObI8C2DrWlGaaqZnkY1DHEk5kqGd2aHCYr7GVQvGFA0Nq43XcXFsCHdrVYzNs6lAjzgi5uRfvE36IzMfH6UbLwS/7pf7NvO1GbhemWAoL2xeB5MOys6b+feJsewcgDgyHfrVZAK5ZBApv2YNzr/2MgVnQToYaXVvB+voYBAqWXkQvfRgPoDg2vE5j5cvO19U5p6LGARoJ5CqE+7mhGd6jofGqtJCi9b13Y9l1U24vFKKSUFzB9BvlHoHjRUV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39840400004)(136003)(376002)(366004)(396003)(346002)(451199021)(36756003)(316002)(26005)(6486002)(6512007)(66476007)(66556008)(8676002)(66946007)(4326008)(478600001)(52116002)(8936002)(5660300002)(44832011)(86362001)(30864003)(41300700001)(186003)(38350700002)(2616005)(38100700002)(6666004)(107886003)(6506007)(1076003)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LhgGU2Vjf9W62dptucT6aGCFsZlcLCKyCbootTZUnr7mv/yKbrXexiij9Ucw?=
 =?us-ascii?Q?RrGzDLCvbODyMfYRK0ax4USWg0i1K9CQFOmXP0SIXCPMMvKsa6bVJWz0VYW+?=
 =?us-ascii?Q?PWOCSL0A97BehJ6ycfKNzCzcu6TKe3DgKJ8Wgkg9kYc6DFWgWWNx5YnuRQQT?=
 =?us-ascii?Q?XANpc5v5xtlbvZF/hk86AKQs6z+9M3SxDH571NL8Z6dyMpk49Cj8IYDDs+tW?=
 =?us-ascii?Q?cdsdSATG6sPZRrNBtLB+f0is4HkB5DmLRCb69uTAq5YYV6G2/gyQNj9cLSks?=
 =?us-ascii?Q?6xh/GDnSJShzKk/CmJLoqKI9GlEdbqOWy8v75hj6lOIu3sv5Ud6IuTA7QjIi?=
 =?us-ascii?Q?pClnMqrAE46PIjE1Ou0QOGqNS/7ghBYvFAUcxH1f8YKSNmfRb4kDgN4SE2ra?=
 =?us-ascii?Q?keWuXQChLxrQUdJ70rKThreSBOzXcto4i1MuoqS4KtJ5cwx5fuFmc+N/iF7C?=
 =?us-ascii?Q?qUvQ20KMIs9da1I1sjOliNK+C1Tc39IR2M2pqY078vE0jBzRZgggDvZ08pRk?=
 =?us-ascii?Q?j83XTyhz6iGSeE4kZLrv6fkNQorBFmw+SIyqfXV93endemFOJvC6WpMmUH3S?=
 =?us-ascii?Q?4crAk4TqcTxyNQKO1DMO8atTWlrLEHu+OBO3YA77dnmXnDx1EjA8mqYT2U8E?=
 =?us-ascii?Q?7Ca8Y8g1xn2LVGo1lI79ORY5ztwWUzPyqjc/kFsaePmho0gK/n5g7VNpsYbd?=
 =?us-ascii?Q?Cx1bdjHKH0E1+zk6AKtNROuxPPhfYQyV+xwtmN4tPl/zO+uX9ZjDAEy2gBx+?=
 =?us-ascii?Q?nCRJPwAFK0N3z6nxYubOUS/zDZeJ+esMZn8TKnmgZ3MLZAIgYI4iezpDAv60?=
 =?us-ascii?Q?KFoQJx79S0R/8NuxfP6tIn8Gic83iV/FqFYawnn7pK9aHJ8jQ/4veez6cPq5?=
 =?us-ascii?Q?VD6jctAPu+Ve6SP+yoSPy3bTQk+TKZeMNftue+D0w0j+9WM0yfG3deQYS6OK?=
 =?us-ascii?Q?KY32H/wpdZH1Jg2DPTGvOi88KMdOog50pGImFYRvGiMNZ4vu/Fa+EMatwkkB?=
 =?us-ascii?Q?tNkRCO3P3DK6zyxF2iJ9md8pW7CZ5x4x4S/p2UQ1QoOcPyBrWNlwdyBM/eOt?=
 =?us-ascii?Q?2ZemYgUt7e/Eeqr7m3DcwESo4ItpyV9BVUR/qqYmQvwm7hO+dVBIgTQO4Vdx?=
 =?us-ascii?Q?VLzQodokwZt1F7NWZpPLn+wiWSDPiOg5CCiXycl2MUdxW4G2Q0dREzRrqAPl?=
 =?us-ascii?Q?EcMLecuSs+X9QY1M+rti6L6vi5Hw0XGnHT5K+zvURTjW7Q5UCiJX7wJTmcNT?=
 =?us-ascii?Q?fqNYYx0EHupvg7oWVfrw7+dJFAEzIy8cmn7ZBa9ow3mCYtENJZ4GX3wA1cPQ?=
 =?us-ascii?Q?UhVP0+k1rYETFqSDxMz3vrZuH+Ur/EBvEHakadE6XuaaXaJzAwrosy0zOvNd?=
 =?us-ascii?Q?0PYwPJLiFzwzz6fjikn8r0k5LJV9vimP2buXLqnyFuz0BG38QlGmiu+1E5oL?=
 =?us-ascii?Q?c/VidC9BFf6b7BgIvwMAPm5yN2wRJ1Zg/bGktaKqzvgoed5BgcuozGDHP7Dj?=
 =?us-ascii?Q?di2djaLGOQc4suPWIPP4nGHPNEitEAVeBAmm92+QC/QNDOnymvv3Ox6+/W6w?=
 =?us-ascii?Q?mBKwCvDhqOXuA/2jUeEWaexnXoO0i9jdkDeSYPVTe6/gY7klkQFmKym6YYfC?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313003b2-1c2f-4da9-6ab2-08db337923a5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2023 12:52:38.7727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcOOMnUSnUWmIZrhJISWMlnumbYpSwjO76lPRLcCJKid0lAEKYnUDMuVjvTWh+jXuCT67aHhst62bF2J0v8U1UdE+d3YQMLtHptYxLYCOtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7818
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
 drivers/vdpa/solidrun/snet_ctrl.c  | 318 +++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_hwmon.c |   2 +-
 drivers/vdpa/solidrun/snet_main.c  | 111 ++++------
 drivers/vdpa/solidrun/snet_vdpa.h  |  17 +-
 5 files changed, 378 insertions(+), 71 deletions(-)
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
index 00000000000..54909549a00
--- /dev/null
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -0,0 +1,318 @@
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
+	/* Overwrite the control register with the new buffer size (in 4B words) */
+	snet_write_ctrl(regs, buf_words);
+	/* Use a memory barrier, this must be written before the opcode register. */
+	wmb();
+
+	/* Write opcode and VQ idx */
+	val = opcode | (vq_idx << 16);
+	snet_write_op(regs, val);
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
+	/* Clear the control register - clear the error code if previous control operation failed */
+	snet_write_ctrl(regs, 0);
+
+	/* Write opcode and VQ idx */
+	val = opcode | (vq_idx << 16);
+	snet_write_op(regs, val);
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
index 68de727398e..daeb69d00ed 100644
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
+		memcpy(&snet->vqs[idx]->inital_state, state, sizeof(*state));
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
+			snet_write32(snet, off, *(u32 *)&snet->vqs[i]->inital_state);
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
@@ -997,6 +968,9 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
 		goto free_irqs;
 	}
 
+	/* Init control mutex */
+	mutex_init(&snet->ctrl_lock);
+
 	/* Save pci device pointer */
 	snet->pdev = pdev;
 	snet->psnet = psnet;
@@ -1013,6 +987,9 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
 	/* Create a VirtIO config pointer */
 	snet->cfg->virtio_cfg = snet->bar + snet->psnet->cfg.virtio_cfg_off;
 
+	/* Clear control registers */
+	snet_ctrl_clear(snet);
+
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, snet);
 
diff --git a/drivers/vdpa/solidrun/snet_vdpa.h b/drivers/vdpa/solidrun/snet_vdpa.h
index b7f34169053..a4213e97cfc 100644
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
+	/* VQ initial state */
+	struct vdpa_vq_state inital_state;
 	/* desc base address */
 	u64 desc_area;
 	/* device base address */
@@ -51,6 +56,8 @@ struct snet {
 	struct vdpa_device vdpa;
 	/* Config callback */
 	struct vdpa_callback cb;
+	/* To lock the control mechanism */
+	struct mutex ctrl_lock;
 	/* array of virqueues */
 	struct snet_vq **vqs;
 	/* Used features */
@@ -117,8 +124,8 @@ struct snet_cfg {
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
@@ -191,4 +198,8 @@ static inline void snet_write64(struct snet *snet, u32 off, u64 val)
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
