Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B17C433FE
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 14:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44BB9416C5;
	Wed,  2 Feb 2022 14:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BP0zTLqaDYML; Wed,  2 Feb 2022 14:55:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C729741679;
	Wed,  2 Feb 2022 14:55:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BDBBC001A;
	Wed,  2 Feb 2022 14:55:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D945C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBC9740594
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28Vd6UAeybZj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:55:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA1DC400C6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 14:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJQW/9Op+vnLKE6b1BCsy9EQoIuKiudzBvtClWErIKfBbPIXEcH+/D06c4h7JjMahGcT0Igh7zsITh6Ze7a5SXtyZ++Of4C7yBl6dEbkon90KP20No33LiaTP904NPw6mT4ygcHeG1oP5uYOl5gcIcuJFc1QKy1qassVKaTbc2VFYdKQywN7hEC9LyycW1XQihUuGvTWw3M0dq/Haw5CJKuQUec17fQSp2p9+tWOyzJnVXFNZNwBKo1z5vBcjMR9z2sbjKKwAnkzD642k9alNvUFHVtqxjys3EYsSdDSe8GHPDdfsUFaRdnETOARj/ZEfKptUK6oU/ai3ViQt+tDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbWD1v3x7o97JR5HWdB3qWokM1m3uQjDwl735CQJ6EA=;
 b=XOrjdWRvfJVqIXC5M4sNlD6XERV3JaKQ1pJ+uIfgdQNIX8t2pOaYbv+yVFjS80AhItyDt2v0BjS9j/3FhrpM59NZbN31s7EaiLlUDzNBc3d/GwiuT6BJy1THnI1qttYwBWFL33jn4Q8j0Ue+gE5bd67dt5SGhjvCBgU8y9CnVNHfBlTRWjED7J6ucXfwqdkkm6JAjD/9hgYL2U+cED443aGdS//cXnOQZS9pPJf14GPt9lST/2FSfB/Fq9MGXLyjDvn9ck3hUMQczO7evxrOQvqenASfbIjk7Yc5T+b9YIw+3oUrEtRSYVx/h9uuBOCKWG8mMMIDImF+GqUb8qBBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbWD1v3x7o97JR5HWdB3qWokM1m3uQjDwl735CQJ6EA=;
 b=d/wQdn7IOs6IDTBsTmEuZADTelGUSWSCsgLSn4EcPtZnBomxfj1SPKtmP9TpmHTMu9JqelzzzLvgH6Obfaqf9dsh4pNVDvL5j9sSHL8JUipAFJuSe6ay5FAjZX7FVP6ce96kfQTR59mZFGGktJGR3O2YrmEU9aSnoZBoCL+bE2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by BN6PR05MB2803.namprd05.prod.outlook.com (2603:10b6:404:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Wed, 2 Feb
 2022 14:55:12 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:55:12 +0000
From: Jorgen Hansen <jhansen@vmware.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH 0/8] VMCI: dma dg: Add support for DMA datagrams
Date: Wed,  2 Feb 2022 06:49:02 -0800
Message-Id: <20220202144910.10349-1-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f0c6508-23a4-4112-b0c9-08d9e65c0355
X-MS-TrafficTypeDiagnostic: BN6PR05MB2803:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BN6PR05MB2803DF2768E8BBE5F03E85AFDA279@BN6PR05MB2803.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CeycaZweooq5ERnI7motEwW2j2UXegRqD/FHbyWs4bKG9+GRN/oQD5py5xgm/7Nn6Xsz6YGCiChBR48hqO/CarWeqe9I25qkn2xJltFLf1z4CStUZFLW/87jRZROIKcILARfTAm+mzA8Gl53DA9IqpgomFCou4CBSEmEvdjYzoOnYSB0CY2IGh/mp/AEYjGNgflyjQ6e+aUqIzOrVqVGXOyLJyljDFF7jmJeLEZiVJZXwlGLlt5iQ24El46S/9AZ2NfEPK9/vMkhNatsrwJV8yRPs0OMt+/E//rCHIpKh0fAVf7rxRm98A1PFQXnEIGmoTQlEUmq80xtihv5Uv6SFcSvc3C/RKRRE6sNNgx/fxRYRTXKM8kEhw8kNbWcUcHXRKljGKpQZXIXNU5hiCjBaj48A3u0PrA4GhB6blMNtHlJzzi5spnNCDsnE90dTykccBbLXKmAZQF6OrwPkGRLU6KGNbjgWpD6ltcfbJUrvmdm7QRI8D5a5a+JOml83i4y8ty6rMcDA4kUYe9Xtx46hDngZAbnqZssiRSkU70ans5gfUKz7Qra681B5PuhfohKVL1LKQMKnGyM42Et8GpoBf1wVX+0MJ6IJ8b9y9LzWTCUHOwoLI23krO126IaFjRT39uMkx59a+QAhQ2/eEKH02JmwmFbvke9Epl7HUNoQXvef/yoBBfIy4nuE/BfKCIn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8081.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52116002)(316002)(6512007)(38100700002)(38350700002)(5660300002)(2616005)(8676002)(8936002)(4326008)(66476007)(66556008)(66946007)(83380400001)(107886003)(508600001)(6486002)(86362001)(1076003)(36756003)(186003)(6506007)(26005)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jqZcWaMgFj2kBbN5NhYD4JmmUiMXpukA7cIG2BMqHK6DMIQS3V6g34SPPHQo?=
 =?us-ascii?Q?BKpWKSkLMe4tP3zLagCTnLvXIsSvYePl761/oa3QblXLAkMLcbTVExeYjiGS?=
 =?us-ascii?Q?+vwNr/iAjAJtSBTH50q58851XbpcKa3f2wyZPuNc1RI/3vjmcnEoY7AhvTvS?=
 =?us-ascii?Q?cDp2wTA79qFCweCG25DQnYqwsgStp69Jk94CUq1sbkT8Rs99KKJKIRG41Qn0?=
 =?us-ascii?Q?ZCn9oVeyuAW57OX6M2UjQf9xsdVYVuBtGYGMB9eTl7zuOyHZetce5yVwMq76?=
 =?us-ascii?Q?HInIvVfDL7941lgxiX/RkFhXW22+9AVrCTgr0x6wQzvtAZ7m7k/PrdjGsVeb?=
 =?us-ascii?Q?wF7qbFh1VvPnhtOz+lUMvTxs8N27WV07C+QI+eZAv6UJ0E4pSSc8qnZRRQWJ?=
 =?us-ascii?Q?kMCU5X0lg2GxC4Yw+5R5RkGZ7NR1ss/tsJbHPaRRA1E7+LNm7M2/v6fhZfrU?=
 =?us-ascii?Q?CC9xzi+MUK7fmPzwacnoMNxVh9i4u/ElE4ri6uJwwqdaqDelj12cDNIleYQ4?=
 =?us-ascii?Q?GKViX4B8ubpMkHPFIhYJurxSbA12WH7AaLrijX+aPyRqXp4zeabVPhH0ciFw?=
 =?us-ascii?Q?N26NgBIRDlfHzZBszV+pbwAXapXtKNEFjsUmaHrGYbVN99MOcAVjBODjPgHt?=
 =?us-ascii?Q?ZqwhoG9fSmVVDauUjGKG45b2SfQfGya8t9FQG6Hbx0MiGl9V9FP51EvGQ3CC?=
 =?us-ascii?Q?kcXlzHCWvE5HeX8woCIIxzuCGH8Or0x/RKcFW5SgxaCA3wk87t3ZWHpv/Gct?=
 =?us-ascii?Q?ZlfhWFcjb1cgOdQNSpsIr8J+EH3TXdKeRyU7gXU3j/yZlH1o5O2zu4Kfx4oV?=
 =?us-ascii?Q?H77h9sVOJuBTtQEA+zylh0LqzSLNv/tTPwkkBFl9xnzolSRCC+YEhiGb1qaB?=
 =?us-ascii?Q?gLq5CzgUQ13k8imvErTh1XNeRlq1/ohGhwvEmNCRi4NoTO6U5J277LXsJ0f/?=
 =?us-ascii?Q?W+ZMA1K5aAoYpBbvgoKy9M5qd5i0nzcADM7Yk6VkYmarfx5+VQGn1p4Wvyzk?=
 =?us-ascii?Q?2sBU6kEntUV+qoo4XS+HYKMdKHJj4DpWxW8ClGuYQRmauC1YGD9uxZmVvzbk?=
 =?us-ascii?Q?esiq207AZD4uSKsBRNjFAOeJkNmNqXRV3xI0cdjrNXymvukI1bKoHb0iXbgG?=
 =?us-ascii?Q?NolJ8N4c4Jy3uHI7QLgz2r+aZIQfnQmdobP1l3+LfXvIlyI8COzFYNrnaSmm?=
 =?us-ascii?Q?UhjW5v/qwqtPz1AoDQJbUp8oyZz2BIvW2g0XAzQxI8vd5h4JaxEJ8gfhAiYE?=
 =?us-ascii?Q?QPeSV8FzPtGOyPowubUdekST+cNx13pIHo/JzZmuwd41gkyuJlabA0CCt82n?=
 =?us-ascii?Q?9Cv0qXNX/AhYprTdtp4Z7S+0l9DZXE6Pyrt6Rj/rO3Rt84t/7Zw6q2HYblcX?=
 =?us-ascii?Q?WtuwdMLec6FBf8HOl5Y10okD6GAwuf188fvSRSNtB8ifGr2E1J/BX+ICLWnj?=
 =?us-ascii?Q?PRBocKODq8dS+4JgigvVArsLqdBmEL/SM5lmHd01wpmKd7lNyTojxtQABHA6?=
 =?us-ascii?Q?gAZRShMdb0RN7zSGegnQ00fmD5bvicd5emQdVKHntUxE4O8uOgKrwn0RG1uX?=
 =?us-ascii?Q?pbTgq34VEi0jObp4bv9drYqcjH4/j25TCHw6+lYbWmEhmLxmM+J4bIhZimtE?=
 =?us-ascii?Q?qvWv020UXJh0ECTFzVnSTnY=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0c6508-23a4-4112-b0c9-08d9e65c0355
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:55:12.0556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jik8kv9gEFIyWrsd2MjMc/4Uo8DiAZ3Etx6aP4j0QM4g+dEuQDjCF6uZt97fnkjwpBDAcWZSVNt5auOIzP8wEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB2803
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org,
 Jorgen Hansen <jhansen@vmware.com>
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

A new version of the VMCI device will introduce two new major changes:
- support MMIO access to device registers
- support send/receive of datagrams using DMA transfers instead of
  ioread8_rep/iowrite8_rep operations
This patch series updates the VMCI driver to support these new
features while maintaining backwards compatibility.

The DMA based datagram operations use a send and a receive buffer
allocated at module load time. The buffer contains a header
describing the layout of the buffer followed by either an SG list or
inline data. The header also contains a flag indicating whether the
buffer is currently owned by the driver or the device. Both for send
and receive, the driver will initialize the buffer, transfer ownership
to the device by writing the buffer address to a register, and then
wait for the ownership to be transferred back. The device will
generate an interrupt when this happens.

Jorgen Hansen (8):
  VMCI: dma dg: whitespace formatting change for vmci register defines
  VMCI: dma dg: add MMIO access to registers
  VMCI: dma dg: detect DMA datagram capability
  VMCI: dma dg: set OS page size
  VMCI: dma dg: register dummy IRQ handlers for DMA datagrams
  VMCI: dma dg: allocate send and receive buffers for DMA datagrams
  VMCI: dma dg: add support for DMA datagrams sends
  VMCI: dma dg: add support for DMA datagrams receive

 drivers/misc/vmw_vmci/vmci_guest.c | 339 ++++++++++++++++++++++++-----
 include/linux/vmw_vmci_defs.h      |  84 ++++++-
 2 files changed, 360 insertions(+), 63 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
