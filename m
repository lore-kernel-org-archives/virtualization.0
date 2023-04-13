Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD1BC77B6C
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 07:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5555B81521;
	Thu, 13 Apr 2023 07:33:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5555B81521
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=G33VyKwr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1v4APGm5XYVa; Thu, 13 Apr 2023 07:33:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4FA0381518;
	Thu, 13 Apr 2023 07:33:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FA0381518
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A949C0036;
	Thu, 13 Apr 2023 07:33:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61615C0036
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3749B4101F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3749B4101F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=G33VyKwr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xMZQpthz7ASW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1175B40CAA
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::60d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1175B40CAA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 07:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdQgPoQxIrNChvgzBr4IqQf0uJg09IP3dMNdzf+dCIGz6IEa742XkRrmD1XnIEFeNxJ62x2Xq140ae5D09eXFGF96kRrjhKf0X9DoT7QWoSzSmwF0w9Uq1zaLjgvLbhyPBVdcynLTQWyU4hDIFgYtZs31oCPGwQFOW/Dg9yNyi5JRZunUAO/tJeue66/MktGjcniFrHjJzJn0RPb8h5G5rQFOrjKrcSAu7u6BU/f06NfjetVh8+hMVBycCBgld8iHY5OxRSRePmx+fhyuUXR8+9T5NrUljs3tmtsM4KViV0kv5jwJiu1nEvksvfHe+q3a3rgYHtFPDxR8enIhhbXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYXWDrgQxEhy4PQQ77qja8q9GjmAaS2Sxe4sf8scNCU=;
 b=gNB8i7xR5H06KlYB+O807oQMK3dA+1zNPtCQ4SiPBklBqUXeD/5nHHLPsh6UTSSJUYq/Wgt+uDQn06zLZ6SZ4bohmMXgWWeYJL4x581yQvenzB41IzbyTL91KI+PWUUyNLx02H8WEgfIQtqodEDD/T4psRZIEDLvmAUh92XHeQnWOfEr9hu47/zZVDmQ2q7tjdTmEGpbA0Gq+ywXnQpBJKN08L3StPnf1ISmguNQriV16Vuo5P+ayQ8iI6cy+l3tOPC7i6Wx3kP5AhOAnKl02An6D1b3JW7CeVIMP2d+dcU6hbwq4KfsYn9uG2pQYmo/VivA0XL7U6tyvruAZgRnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYXWDrgQxEhy4PQQ77qja8q9GjmAaS2Sxe4sf8scNCU=;
 b=G33VyKwrC0L5mahOnNeOL99ou4e0N63mCvJI2fkf9FC8ut3AnxNVITsle05dhXi4VPSpr/1YXmK5ZWTgWxz+ObqIfDH+S9z6oqzJrH6uY3N+cQzAFL8wnqd+FCK7fjMxFOjIWqSB+KrZeSZ+3EOIzF/XokIoqNpCXggqLRxZdaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 07:33:46 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 07:33:46 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v4 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Date: Thu, 13 Apr 2023 10:33:35 +0300
Message-Id: <20230413073337.31367-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR0P278CA0122.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::19) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ea45eb-1d63-4472-6747-08db3bf16a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jGlwRres2EBNLTO5kxfogcEvzL3luaFeVMnfy9tcGEaNAozKMs12dGSIax3RaevyVTOxoI/iz/8OrM80AUkmilCj8EE1mAk+GEPeLkzO4G7J8RcPhYa1gGZ91FMayJr3smJ+2qJb8paVgl8hOgMt2JMt70Sa6b4ZILyNTuNd8EiOUXxhExnL1BF+WtdZ4UHeRipJmFaVlbkimUUkVdWVimoa2nIKxoBGhI1VwxEdOMUeGEre470ZKckxo0dkgC6/KRtQmI4drPUwhpgyEvzaasQHo3+yBMkUH2r6gAtgEHhZkw7/vz0QGyUNuhRzENTxZ0/aq72R+Q8NHMydE6aXoZT1CYk21u/F3PWS6j2DRMLvPlxGAJDbZ2BibQqSUE6LsZ1S9QECXetauvNsilOyu8SPoTQWMuM0CDidm6xC+aRhA6AE5CHjMpxKqxY3qJSM11h8uA/36a2NNHe0+Bo8Nr4DMD0bgMA2pwb198Bzp/g4MGO4GrlUwAOi+56NrU8Jd4MBlf+1HlY5TOoIj6kAZlVFo0e4jTT6R4HMrDA6Co9ZOLZwcYEMgPqDjbAi3b36x03J4nitHVJb1P32nFcH9NmcqJXb+kS9goIpzHEau8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(366004)(136003)(346002)(39840400004)(451199021)(6666004)(478600001)(52116002)(83380400001)(36756003)(38100700002)(38350700002)(2616005)(86362001)(2906002)(6486002)(966005)(44832011)(316002)(26005)(5660300002)(1076003)(6506007)(186003)(6512007)(8676002)(66476007)(41300700001)(4326008)(107886003)(8936002)(15650500001)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXjaQh6eGSAzbxO4NdAYZXixGd6Glg+H4jrN26dU8vrYRYk5rUvW+cMw5fRQ?=
 =?us-ascii?Q?h+ooCpNgJM+Q9IXRTVGpYkaP7CL2aab6YLfkWPykBr+jNIV8Lcsj0Wwj1oq3?=
 =?us-ascii?Q?r82Gf4MhADaYhKwc7i5UlQIcEph75sZ4Yy7a4RZbhDslLfAymTNJm/5PXnLQ?=
 =?us-ascii?Q?R1Z6wrcvl0hpZ7AYjKSEM0uN8q3CQKgTBzHkQVU4qK8BTvSvyBAQoaWOW/9t?=
 =?us-ascii?Q?iCChx8/rkVhjFZHiQx1/WiMVXENln2/Bmbv2OH/L6ZxN3YmvnXatcO98hyyK?=
 =?us-ascii?Q?0FxDEiY35S2MyhNE1ZWe0J8BXB/zlu4PWd2qfjOinDj0db8OL0VNkJmIFz7F?=
 =?us-ascii?Q?HBBxxTmSL812/DqdtO/C3d3JJWmzrJkPulrDEzDoppkbQICkW4Duwl4NAodO?=
 =?us-ascii?Q?wVt2oIGEN4O+lejo7jhKra1OZq8H3MNWO63Lr8u8A6KGE/xEQoZo8oH5olZN?=
 =?us-ascii?Q?Kp49X2Wjc2YXOhWrKTuAxnUDDv4MjEuO6UD1JVqgfi2RJbdHLJGZKC2UWJ4p?=
 =?us-ascii?Q?3hCoKmqeZhx8GpDqOtOVukP74lTVfyod0QfIWWweC/GMRateSZCoSdhZCl0W?=
 =?us-ascii?Q?uiCY66ZTC6GW9XoCe2G11o14fEjMuMtn6MJJZnMUQEA/5mlHNtlatHETEYUo?=
 =?us-ascii?Q?9lZc3hOoc+C4jyR2yeMJCa1L2kRl1YoGO8xVS/uGx73IO6lCznn8z/1bz+YI?=
 =?us-ascii?Q?HWqViNbu5mpQB9epmt3LJMeos6uWdzRldemzt9YsWhftCrLEoXxWnDTjKVP9?=
 =?us-ascii?Q?A4JdEHfljdPLNfNP2iSr+xRnYHf5ynLCJqMnAuE84oJvF8mVjGnHKy59HvGi?=
 =?us-ascii?Q?HFtRvwvoeUx+lMKxlc93SESntl7VWuWBR0jW/3b4Lm9Z8hVihgiSmj02R9W1?=
 =?us-ascii?Q?h/qDNV5ZU3YxXM8n/VCH/oHhjWNKw2K+MBlmJ3FEx/gE5avpMS8ZX7pjxU9T?=
 =?us-ascii?Q?ARWUXOznHSNEu/W8N5k4Yry8VBILJDmKwS6KA+OO4j7qzqrT4lJQKMqlMQVQ?=
 =?us-ascii?Q?va7tH/IpXiKJYMxIbnjo30GbzdcuKZYetHYP8zaBtD9qQpo7aN7EGnzOLM2K?=
 =?us-ascii?Q?lnwMozQCGCBEb+rpaohzFZBYv3Qh9+ZpBwY/8OSOwJGD3LveBmXIjx4ifJvL?=
 =?us-ascii?Q?Y1vh4EMDQK/8vrvqn+TotX4hKydVP71Iy2J1niVmaDb3GJRsjqfFy/m6g86k?=
 =?us-ascii?Q?5H4ElTeLJ+wp7BxA8fJEsk+VxmAz05ln8hNTKBjwNrxnaBWk25B3j1rgmekl?=
 =?us-ascii?Q?iQAWg93MM0LLQrd9f9YBca0npyJt6Svt+W9/wY+8s5ZhgsGD/gEAB6zK+EwE?=
 =?us-ascii?Q?hPTY01EuOlsG4qylbD1iT/dHDMXCsmON7T5ZdTtYl9wPJ/8DP8lj/HwSP/02?=
 =?us-ascii?Q?JzfHL+BkJYahB8Jt6w1b/x/8Yl5pq/lFwIHe0zqlBroEEwSe0oXoqYnJf48a?=
 =?us-ascii?Q?5AdydvAgpglr7wPGr2LMxY/h6LzydojE5dnYVynrLt+XS3vxbbUDQToCaHoD?=
 =?us-ascii?Q?hOqLHFd8un3xNLjiL4XP1Hhct03Fi/RWUghSRq/iLaCqFdlqe/bxoJSesonU?=
 =?us-ascii?Q?LL6fJoa2kG627FWkbq3UBdlrbRmQTOCC8V7ItIAhxeb+JZqBEyW7PlhlswxW?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ea45eb-1d63-4472-6747-08db3bf16a20
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 07:33:45.9149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2x16gQ26wsog61h+njmxhKABqCz4cCcPXeTwGh84Lt4DjVQeLRCpri+opGcOlHvS/u38l/kcI+D24m2nAY6+sf0lADhZb0URDqnrNt+l4OA=
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

Add more vDPA callbacks.

[s/g]et_vq_state is added in patch 1, including a new control mechanism
to read data from the DPU.

suspend is added in patch 2.

Link to v1:
https://lore.kernel.org/virtualization/20230402125219.1084754-1-alvaro.karsz@solid-run.com/
Link to v2:
https://lore.kernel.org/virtualization/20230409091024.3437405-1-alvaro.karsz@solid-run.com/
Link to v3:
https://lore.kernel.org/virtualization/20230410100237.3499578-1-alvaro.karsz@solid-run.com/

Changelog:

v2:
        - Remove wmb() from snet_ctrl_read_from_dpu - Patch 1.
v3:
        - Usage of spinlocks to serialize access to control registers -
          Patch 1.
v4:
	- Rename struct snet_vq -> struct vdpa_vq_state from
	  inital_state to vq_state - Patch 1.

Alvaro Karsz (2):
  vdpa/snet: support getting and setting VQ state
  vdpa/snet: support the suspend vDPA callback

 drivers/vdpa/solidrun/Makefile     |   1 +
 drivers/vdpa/solidrun/snet_ctrl.c  | 330 +++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_hwmon.c |   2 +-
 drivers/vdpa/solidrun/snet_main.c  | 127 ++++++-----
 drivers/vdpa/solidrun/snet_vdpa.h  |  20 +-
 5 files changed, 409 insertions(+), 71 deletions(-)
 create mode 100644 drivers/vdpa/solidrun/snet_ctrl.c

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
