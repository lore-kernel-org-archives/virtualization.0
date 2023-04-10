Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FCEC77B6F
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 10:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 930E9408BD;
	Mon, 10 Apr 2023 10:02:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 930E9408BD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=qza5825o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FagyAUeS9BH0; Mon, 10 Apr 2023 10:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33EDA40B58;
	Mon, 10 Apr 2023 10:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33EDA40B58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E232C0036;
	Mon, 10 Apr 2023 10:02:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C74DC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 167A26FE6E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 167A26FE6E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=qza5825o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JASjPUN87e-E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2028660EED
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2028660EED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 10:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK+D/NhU0taPSWrUygfy+7yW2d7OfzNdchpZ2kagwF/+61siAYKaqpGfW9UoVEtCJynQcJYFhzU5ooLPAVhsdvQJ4TWk8IAdZ2r3kAnN8tRqBQzH4kvJufezf3z44khk5wC8946nYvQmHdKk/hqTsqL7biUl0YvhnIhkfFW1JbKFzsbjx+6jNiFv2Xk4bZcf1liYELPnyg93lSJcG6znvs93t9f84WMiYyomuAqyBFV/sUsErFdxJpdCMioDqXrNBFfDJVm+4Tht38aC/83S7on8TVzCqe2DmAu4klifw1DGUmcqfyNIcJZdtRhJPtmwV1ttsadJ3Jt9c0OZEf82Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOaBJrOOQEDTR0+JHbdr0gKXwi111t6dBgm8nwra2lg=;
 b=LprOOixy79Hhc9ZQOJW8K3f4q/nDOsnlkaoz+i+u3WKFlgkZp/8D4QLVWKeMzK9l9ipW4TJsg+jR68ZSeQ5oFjvsv3H203rx/ZvudQVpQh2V/7BMjrdSlbtNG+PnwiD01c7lKKmH7zaUhfrCLIjZHxUaP38qL4+GAQOJmcpzkVWetI2Iqehgr1yFet35A3S0CgJ+B51zbTOsTfMriTe+nomR5BBUkwUYRZ7pJk6c+cp3s8SexM3bcmgX65biMLzKNZKxni6ZGfigasA6YhhN5KwYlchFmu9N4LJv5WP7SShAsvhvTdLPY7hxYPNbP8yzNXmNi+uYBIVFmqp6TnzHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOaBJrOOQEDTR0+JHbdr0gKXwi111t6dBgm8nwra2lg=;
 b=qza5825orIOTMFi/ybwAhqompqMiL6wGn/hpE+5dRMqPy1iU1kYvaF9EgJjX3JzG1PrUEzbxfMxsJkwKkzI+GBbr74BTTzpQ7Aav97CXWCkbl+5A80FiVdtqvyUrxlEOXhnMj9G5Prnu4oczO8sl5RvHKkEvENSRJ7XEP40H7og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PA4PR04MB7999.eurprd04.prod.outlook.com (2603:10a6:102:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 10:02:47 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 10:02:47 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 1/2] vdpa/snet: support getting and setting VQ state
Date: Mon, 10 Apr 2023 13:02:36 +0300
Message-Id: <20230410100237.3499578-2-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410100237.3499578-1-alvaro.karsz@solid-run.com>
References: <20230410100237.3499578-1-alvaro.karsz@solid-run.com>
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PA4PR04MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a38884a-323c-4dc2-cff2-08db39aabc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdMWoghJPWMfg78Gv89avhfeGTA5M66uaYxpklDabTe2AC5/Xz+LryB5NR9odH5hZivySb2eNO/mjRU3Fstuc1jsMq1yMBURGG9EEplGWoJXY8Lasvpwrx4/DyIoAolK0sZutjpIqh1DnanXgqF6K6VxbDlcrfciYy4pgIvLL/cHjvpsd7uZdx6c2ShL+jNEx5Psg9OZHKFjTO/8m2psvO3NbqrUBfX2Kh5VlTB+pM9aYot2XC2yTWvA/7hfOjtR9T++LF1NQC+iQAKMjO1KWAd+gq9GuUZiZHNUuiUkn+8HzUiaHHARaYFpRs9YhAAXzE5NAz0TJaSjuB1pgww7Az/boWonjAyqnylASfJukwur5BqDikJoE8IWn3s9fwpHyPKVTXrv/ypppB6HfHBdS2z3/7bJrKipHiezhd2jvTjg5M6tnfqxChy5osuFG9QRctd5ZiL+ZkToUr1C1HL7NIrSvFKgbMN3G/m7qEu/JOset5RWujpCf8uMWmPRWWFgWAP8Ma7hY6H1fcQFB4Pq1wVZXiDIA6h+CwPyhZefL9B/iG+NmNz1g6t25AGa0siFFXDNOFmx9RgKQWBD5Qj583kRhdAg6Ww3umwwN0D/wZ1yfnTrict0HEtmmccdlatA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39840400004)(366004)(346002)(396003)(376002)(136003)(451199021)(52116002)(478600001)(86362001)(83380400001)(36756003)(38350700002)(38100700002)(2616005)(6666004)(107886003)(6486002)(30864003)(44832011)(2906002)(316002)(186003)(6512007)(6506007)(1076003)(26005)(8676002)(41300700001)(8936002)(66476007)(66556008)(5660300002)(4326008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O6ZIoJFpuf25RJwYMGtQ31bno7JaI5UD7cuBZJlC9XZqR0PENmft7/45ohPa?=
 =?us-ascii?Q?4BZ9KyT9S3Y97xf3s30orzdsLTUJEi9gZocPWnPeOyCWY8H9BwBLdGRHQEc9?=
 =?us-ascii?Q?AboeO/g6KtkCG7Ph+lC2aqiSd8X8L5mVstnRg9fnKImZjYzPkWLgcSvPj6Cc?=
 =?us-ascii?Q?ar8HxM9lseKSash9/qi+qqmgvLXNwM7+wy02TZP5HZyBZShV0OmqEwp5Klgk?=
 =?us-ascii?Q?SvbB1TG+FoUpZuPwXyclceebB+oYXqOuBZoHjVKTN/oF2kA2WaR7xineL7Lh?=
 =?us-ascii?Q?aBOvY35pF3rhXHZN4yrEIvdeKztoI/KbgrTkpBo6FbHw/PmqLAzOxfd59wj8?=
 =?us-ascii?Q?9L7i+3a8yjcs+wv7JnzzVWsl9oSrJk58BO8o4D4mH8+Jfz+ZZkp8e6Z9fjlw?=
 =?us-ascii?Q?2jDWubD3pLzepPE40c39MIJlKlAhXWS7d0Tpsi0DLVSxACUaoPftaMTmRIAh?=
 =?us-ascii?Q?GXxVSjLt9PusbgpDyn52AOpIw2eo1DilOMlsJo3RL7a/rCzQfX+9w6xnujZR?=
 =?us-ascii?Q?GBZsRr49RV07YxZciMQeNTl5DTc0JEKjfh9clF8h0IQseUNR7l7TRKUKXMkc?=
 =?us-ascii?Q?Nze/yS8RnpeKdHR6JfekhmX0OMcA55lVbnUIiriU5xub60sdw8bytmi26tAS?=
 =?us-ascii?Q?Yt2jCCIoDlM2S10xtbM3Tf8/poUoTk2ClgIkBSXUhTNpUte0Yl/pp7tDvnPi?=
 =?us-ascii?Q?DBDfumBoutlCjpZME0dgyUQV1xmvmQqG7hRybttIlLY8h8cZVygTgWGq11at?=
 =?us-ascii?Q?ioYkn89jEToOs/n1oNjjRSKs7f5HT+IlK71c0wRRUqDCLqUcp35JQ3TQMJAM?=
 =?us-ascii?Q?G/LssVbECuok2tiCdHmlBOBYaX5aTRrI18Kf6qqvaRiRcgfdxQAzkGghwEcn?=
 =?us-ascii?Q?H7cM5PAb8oc9x8wRWeIRJAT0gifGQ4ejtJ41xveFo2to5zQwoGdg2ULZSCXq?=
 =?us-ascii?Q?Llp4pPgn7GJW1wdnZyFdOJB2P8Y7Sfvj1/XMt4kBOD44LHZ4SW44DnCT0EMe?=
 =?us-ascii?Q?ezxFP7j9otLgWXmekr3+BO7ppwBXEEPKBhVhEzavDtAuiH9Q2kcJ496xi41J?=
 =?us-ascii?Q?o68ZAISqgvnKw77klHdUApx6ObByRkU/0SL8AxzUT+nldy8+k8WGWAo2ZntO?=
 =?us-ascii?Q?D+c/tMBBr/qrEEQvTBrMVfAJcedYvib5PsnvMtbPHbkJ4Q3f+VGp7q1GobeZ?=
 =?us-ascii?Q?bZhrjKHGkc81b3t45TOiILv9zOywLK0wNisu9pAOVmOcZG6vcOdXMlM1ZLwW?=
 =?us-ascii?Q?tFbv6w5U/oXmiweVdnKe2v85QRmVyExiP664EPv6gv87YcWpeWGBDiiz5Hfv?=
 =?us-ascii?Q?WTxJ0u7PoVTavGfJBUZDvfwjWbZUSLVTGFdUXjqGjg7zt8qk5kStk4iy/gZc?=
 =?us-ascii?Q?I/+gsw+mZhBa5ydDVNVEFRZJybIvw2Y43tkuXmrNlaOUCSPIIIiCgXR4Gawj?=
 =?us-ascii?Q?pIw0aQHbhv2h98IuhJsFNj2/psiwGfTIEHFGGNgvrY+vL6H81jTr3RxAt3E9?=
 =?us-ascii?Q?zh9LlZ4gRScaUMmdGNCcnT/hJAb/dvS9GMKyATk0SoiF/p36ltVyIeO2nSlb?=
 =?us-ascii?Q?5Icap70GXYpXXPeV91C9kLjzHTgdnOvepVe3uFhGKNxpV/XsD8AFPYyN8ezA?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a38884a-323c-4dc2-cff2-08db39aabc56
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 10:02:47.3080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUo2PVtjWSOjx3y8CgnZDpBwG5WkacqyG07jj3tScfPAo+V1GY9ll+9p/ONWsUSBPW/Ou2lWl7NKtFLcubmw1oLA5u53qvuteBrkXVOigf4=
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
 drivers/vdpa/solidrun/snet_ctrl.c  | 323 +++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_hwmon.c |   2 +-
 drivers/vdpa/solidrun/snet_main.c  | 112 ++++------
 drivers/vdpa/solidrun/snet_vdpa.h  |  19 +-
 5 files changed, 386 insertions(+), 71 deletions(-)
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
index 00000000000..f7b3b2887d6
--- /dev/null
+++ b/drivers/vdpa/solidrun/snet_ctrl.c
@@ -0,0 +1,323 @@
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
+	/* We need to clear the control register and write the opcode + vq index in the opcode register.
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
index 68de727398e..5647a75b457 100644
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
index b7f34169053..46133db3063 100644
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
