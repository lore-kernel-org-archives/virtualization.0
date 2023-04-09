Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191FDC761A6
	for <virtualization@archiver.kernel.org>; Sun,  9 Apr 2023 09:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6824E822DD;
	Sun,  9 Apr 2023 09:10:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6824E822DD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=GI23FRoM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ly2GgnEf0z83; Sun,  9 Apr 2023 09:10:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 01B46822EA;
	Sun,  9 Apr 2023 09:10:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01B46822EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C42C3C0037;
	Sun,  9 Apr 2023 09:10:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C57BC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 09:10:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA6AD82303
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 09:10:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA6AD82303
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zk0GMric2aNb
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 09:10:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2466822DD
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::622])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2466822DD
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Apr 2023 09:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxWclakqcJG2xvJ3FOa7U3yqBdoSI63gPjN/rY/YBW1khXj+VbSJl1pSU7hYYi40IErIoSt2zWiW6fprxcYLTXoOvFf/yLEmd6zAAwIf62UlPjB7c9lc1fKsDxxbirOFIGvBuLfn/U9xLXGzxutmUGiE7ffoSQxV/Ock15u1A7vRsqSG/48K8zcWvwB+PZ+Bm/1a5RJIF6MP6pt25+Bmqe05YKpj08AyjVLXNjtn/ysHSVt7EMCQLsr16o4gWYJad1y2+QgEwUi6Ov5UyocW9AtjTE7Z27R7Kmb4MACl/smqbT5RHjT4XZjGtHGdQR0XOltN3QYizeTI+jIMEBLhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7/8zLYHrxqTX8Hu1eKE2cxu3hrNhjASZX5UWbEta+0=;
 b=U6esK5ihH7inmYBlOX0G96toGzLKwBbhERsNQPtvFQa8u2R9KcMETgcKylwjC2mTsDVe00vMyHK45PsEBY+aNxS2FW1g9Yq7xTq+MG5ubvX+3PhJyKN7XIlQW48o24+/Cwe4xeCpDXShmbukU3Z7j1i5u+FQDVvvikr9HsY4A2lB+mrIw6RGItl++c4p254cIwfIfuWpcca/z7peKaPR9Rhe9pK6p1xCgUcql7RBFNAmRHpnJOSuRX8GWqjPFdc/USsESA0shuDmKWnmUbIuIdqiUZXTKqH5peVA0mpW1Fz5TGfayfT6VuFoc62QonM3HzaYJhZoaFd/x5g/Q2sN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7/8zLYHrxqTX8Hu1eKE2cxu3hrNhjASZX5UWbEta+0=;
 b=GI23FRoMdQ412m/Rq8c9tb7zPb8rErkK6KwJ3DYw0eZ7/2kP2lvspr3JRbXMxJbIdjsP9+izNzC0bC7t8yHBrRnDpkw1XBViQRlFCjtLxFcrcjwUbFr6b0juH6wue3/uT5BEG4sbgyw8z6ppTm87UiSw2Fh+mZ9geX2Wd30fQWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PA4PR04MB9485.eurprd04.prod.outlook.com (2603:10a6:102:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Sun, 9 Apr
 2023 09:10:39 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Sun, 9 Apr 2023
 09:10:38 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Date: Sun,  9 Apr 2023 12:10:22 +0300
Message-Id: <20230409091024.3437405-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: ZR0P278CA0133.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::12) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|PA4PR04MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 662454d8-1aaf-4fca-1c4b-08db38da490b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XovdI24jp7GJ/Mi456oU/ii2QuFkP7E7Jx4vbaKVpJZyKuGnQN0cvV/isKmNwX3m02b5PsqOIoDAyyS/jUG1zZm6TxvL6JhvC92Mquahd/lwvp82NPjdmDCPNt9aoEwW7F+/4vUiUC1hIpup3M+qY1zi4sqdF1pijO+C5tCrZ+vHpZ5NB9JWb7GQwpj0fw5F2mKkJ4aUwACP2lV9dGTQReQSl6B0VaDJOpiDmW9A19XWE7fgfz+xz/ggZgPkkN3Wckd1BUm3W15Q2jfs+/aQiu1FX3FqkMlynuYro2n0OkEJC+I1KYpd0t/xRwy7kI8ImQ7eGFsEyRnBI8QyM+Zaq5+0XCIQKIGqDwzBIwB6iWsXQNSsvyGkt3dMU1ap64mx/qy9rsZQmRy8o1nQmcTj/uCFtYNNc6/r+pYYzsZrWnI1upGeWMRBkOitpkq9luw3N7vcZRMRmzR9O1btYERtKDZZLMIaH8d9nQaX5Sk1FU6n3llIh0lIdB34TuAUQbSJ6x6Th/5/RsZ7ZE+WuFpbu4BPJhCzMiS7uGgQmIeB+HP9IcUVEjKmmtZ1sapk0CM2jVG6DwqPaScjtxVHayptetEl1QMEBySTXZVgyyBlxmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39830400003)(376002)(396003)(136003)(346002)(451199021)(8936002)(83380400001)(966005)(2616005)(186003)(6486002)(52116002)(6666004)(1076003)(26005)(6506007)(6512007)(107886003)(478600001)(15650500001)(4744005)(44832011)(5660300002)(2906002)(38100700002)(36756003)(38350700002)(66946007)(4326008)(41300700001)(66556008)(66476007)(8676002)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1WjgA7/xv2JZE7npV9iA5lWpPXIlqgTGmcJnEIHr0wWg5xqtFTbxpGR3H6cE?=
 =?us-ascii?Q?z7iqOMvXOfhoTiLh4yNsiiXMcQgo6eISWOOlj2gm8dBOAsXZHqfe2c+jsIW3?=
 =?us-ascii?Q?e8xlPqdodHfy2smCCyw97lIbzvFLFc8/U8Iox9zc2W3e12frZisVtOdp2Q81?=
 =?us-ascii?Q?h1j1lOLNA7IFFRnEZuiKhR6nZAHLLBrTzko8+9IggzQv5m5y5u9eMXwqasqK?=
 =?us-ascii?Q?0g9NAkQNq+5SNUCXXQhvDDc+xqQYzhMaGEXJb/GpAQANWPg2Z6kEMhMgPhnb?=
 =?us-ascii?Q?HY/m71gpMeOnrWschjgKyFjs57kVgJexFWTYz6mU/SmkShi6ofFAk5jeKGde?=
 =?us-ascii?Q?6a6+FaCZsZjZwU9uWncFe4FC7r9LUHyZe1IO1LXI0bMMbo5WbPH8+GuO6/zi?=
 =?us-ascii?Q?Q/8bex8SyLWGTpVXEeBmDOgQGwJwtv6djWt8FPJiYtg+wXD66oR49xeLrtZT?=
 =?us-ascii?Q?YkSXFkBdtEBIA7sBHB4GvohSuYSboZeRFz1PX2sDCMmucC5LmzyCF3F1xKuG?=
 =?us-ascii?Q?H7C1ESW+Gxg5rNORBgVzxPrvbYw/WiC5YNdTDYwCyJ8ysUoUy4XcAeBiCMv4?=
 =?us-ascii?Q?Uk95xfRqMIMiXWGhT06HvPklbf7bVoqUJYSC5Jj7O0V9H9KtaKCGY6xjBup7?=
 =?us-ascii?Q?Nxi6Z/civrug9cVxuKWSMHcFKVPv/Qym1LRZbNcxMqP2ztLlzq4HV0S/9fSV?=
 =?us-ascii?Q?sVSBJLCiFqkpVSPJML6uwSRUL/9ZHLAWS3f3oCpGxe8bx6/tRnizEBLUN/wy?=
 =?us-ascii?Q?cyJroQVu0EbTiLQRbEq28RQahFEtGRCNGIMOE5w8gtUTLz1tjEIJRClq/reH?=
 =?us-ascii?Q?sw/7bvkrxotlAn64d0nsgYmt3VM2czYUlmHLO/Rzqv7HAzUdOlFMxbfeG0SM?=
 =?us-ascii?Q?jMOAbw/cU5sWEiBQK20anlfRevSt7yEHiZ6n0LpLwVlXCQv6vNR4tMP5VYvO?=
 =?us-ascii?Q?ya/NPGKToI1fG7Yk1ybbOaMcd5UldJAV+qy+Om/E5sdJxMcKr2hW9+Bx6zzu?=
 =?us-ascii?Q?E2GNY+G4umeJbaGtJpF1qRO1fgXlQSl6zzxxK3tPhNpUqzrRdNtbkZ2j4W+q?=
 =?us-ascii?Q?33hqmLQSBQJ5KMN+AKO1ua2k982A/Bv9orKI+WeOS9htRypjM7Us49MchNoA?=
 =?us-ascii?Q?Yp/VkcRMFVHW8WygdDyphe+u5QKSQ52z9QIX7K+CE3BCrwi5KVMMxj9/u0z9?=
 =?us-ascii?Q?4zpJhsCjnA93DrYXxCuoB2QP8aZAqzkxnczUGKFNptcKr2tEUzEUW5gh0bZq?=
 =?us-ascii?Q?BdmluD9jtI2Uw7kRGaceTFzE8okG+9M53rJ1+RfSaDlidh/z2K2EucFGzhFR?=
 =?us-ascii?Q?BNfxXcaqk9CYRVG8epoDf92UK2LJkqVMcBsid2+UmS+LaAZmDIZDMm9mGLj7?=
 =?us-ascii?Q?3dKTp6OoDVXq0PrHwJCMRolUfARVlIoLICpOaz8dVitvKH5Eykwqz5w9eioz?=
 =?us-ascii?Q?3MZlm9fEHLU4MCBfAzLLkEji69rWP/xyijNXGWI3LTGrGdQo9FCDAx4cqaQb?=
 =?us-ascii?Q?gXSk78nwVn8DxHZcyrZDdeXFhXhJkKG3K7bKFUPCj4Y1lK9o+x/5JtmjNTDv?=
 =?us-ascii?Q?K3cTxPNu4Cw7dbBtoz1XVcy3RWm7YDnT046TPlguG79t8XcsSCSLtJ/WDKFZ?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662454d8-1aaf-4fca-1c4b-08db38da490b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2023 09:10:38.4527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoyRhE35WKSgvQMcCEiGItnhlGqMrJHYER5p70isKfKNVzulDWwmuCL4MwF7mTYzwMKdJBfY9W5gfeuEtnDxXrO613QCQEwuUBZLMQ+uKz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9485
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

Changelog:

v2:
	- Remove wmb() from snet_ctrl_read_from_dpu - Patch 1.

Alvaro Karsz (2):
  vdpa/snet: support getting and setting VQ state
  vdpa/snet: support the suspend vDPA callback

 drivers/vdpa/solidrun/Makefile     |   1 +
 drivers/vdpa/solidrun/snet_ctrl.c  | 322 +++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_hwmon.c |   2 +-
 drivers/vdpa/solidrun/snet_main.c  | 126 ++++++-----
 drivers/vdpa/solidrun/snet_vdpa.h  |  18 +-
 5 files changed, 398 insertions(+), 71 deletions(-)
 create mode 100644 drivers/vdpa/solidrun/snet_ctrl.c

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
