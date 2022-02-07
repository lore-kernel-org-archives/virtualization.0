Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD69C4332F
	for <virtualization@archiver.kernel.org>; Mon,  7 Feb 2022 10:33:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 107204029F;
	Mon,  7 Feb 2022 10:33:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHdmW0gCU44T; Mon,  7 Feb 2022 10:33:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 92F74402A1;
	Mon,  7 Feb 2022 10:33:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 680CDC0031;
	Mon,  7 Feb 2022 10:33:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 369B4C0073
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 10:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 949D440356
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 10:33:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fp9W23S9cm5Z
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 10:33:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BBF04031D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 10:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEj8CkhWu0ZeY9wu/vdPtzQQMTbCudVeyJ8Mw3E3EH2lCXzU7k8ldm/1Lf4AoHX6VOabeDk3LNtznitdKgkTrNIrARyFfhS962x6vvUcY/RBd67i6coXZzss9FHOklU2wzAoWzzov1dBK411ZP2Vtjycpj4e5tGc8Jr1nhyhZ1U6RNW/DMgipF2Lyqo0nhGlee5ouabi5TrOekw0WI6HLAmENKOHT1CyUQ85PciSH3CQlTkJtj2Z8vFsCsEGpjS4UIGlKIqXvTQRdrvoFEawM7j3ce1sM/PoW9uzwbdlB9Bl2VK+yzED+TvTqsZX8P6WJzqV27Yg7tgi0EEh2XZxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELpbY5k9UvKSJMaUzewSbEEfN1qdOy5ypdTlSa0IYLU=;
 b=N3bkRg2hdU3H2F7+1jpcitf1Z9W2ZNAwmQDd09//+E0oYPGNYUfFMQtrKb7iW1iAMmzNC7nNuvBl7qq15YLL16POizFoHFKEH9L0DR3LKMZd8twt/22HftELO4lZGKeKcXJF+5pt97dEgIEAbhV5ksaji7K+FfSTFVLOLaJA/t06P7qMGqH8p+qAAaKj11UJqA4jLf4963JgAPPn3EHUP/nfE73WWIkLpDQDG7ROUq4m67tWj52Iw5Z5d5Z7gUXof+JICHH56EVZQK2TZauOKYf2XJPDFE13bXO3ieIpEzYV0M2d/vofc2QucUQoRbhTZqcYYo4nljOln3+p+Q/X+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELpbY5k9UvKSJMaUzewSbEEfN1qdOy5ypdTlSa0IYLU=;
 b=fXOaW+aZUiW339K5A1eCa0x1DWYH9pUiO9ubY877Tn8dYlEl+boHgVH5ua0sgXR7Xh9mNb/v1M4Iq7Nvad23zc/pd9jRdqXrH366yut/XrtakO51wGiUfQme3DK+FbVYnYvR8bKWkGQdKfip7HSI0OtCTzYN5VD+IFl1SaiWC1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by DM5PR0501MB3686.namprd05.prod.outlook.com (2603:10b6:4:7d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 10:33:34 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 10:33:34 +0000
From: Jorgen Hansen <jhansen@vmware.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v3 4/8] VMCI: dma dg: set OS page size
Date: Mon,  7 Feb 2022 02:27:21 -0800
Message-Id: <20220207102725.2742-5-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207102725.2742-1-jhansen@vmware.com>
References: <20220207102725.2742-1-jhansen@vmware.com>
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 767f90c5-5865-45c8-18a7-08d9ea254a9a
X-MS-TrafficTypeDiagnostic: DM5PR0501MB3686:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DM5PR0501MB3686936E4DF94860ADB33B94DA2C9@DM5PR0501MB3686.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mz6vkUdzEPHecGRkyCx4O++0tbNxJzg880ME2uJYRyJwwki3d7sDzhNxcDc1FKSEilprmZurLe4b4NIzc5lx+zHdz+4tp52obUXHvplOCFTAHTBtNSBf8zUVjeIr2H8K29cnUp+/VSDOCKH+HLcK/k0pro0vXoOw9+ur6RyqwLJaJSgms71Vsb75a8I1FDMXouXi+Ho9agO6Ei25QcvbIMShIiaZpeUsNe0uJCrxXWJVmzkSFPey5R5au860okm7cr0wqedZbQohHsFtfHelJ493Th6bs4dwsUhzGVFyDSCG/o0DVe3wf+rBrWLz7h7dT71bH0RhNZTnxVUXmcxkYOWZmnpmhtz5JGPf2ynPmnZLRPB2a8BI1DCDNFe3tTely1RWn9IPe8w1o92a+Uc6WOSt7Rq4KFeCBq+tUI3OpZblGUnfL07GdCxCfY4YAg3eLm9zOp4GZ+MZi78dn/+IoeNBVa95cQnSPuQu8eibIkzZ42aNM5lP9yflzS4/QWIdwaAPygrAjUqVbZwLQgv3kDdiv4AQsLtYbJsXweCaRw+E7em4gM65QtHkMvXxdRqlrSpWILTlUzTDRP7E6QdbWpkxbVXBa6XvQTXOfJW/L16lmsvalqG1G85kN2fgbz6bUrhsNlmimKqpk8UGKVBzQDFnE6nHFWjYsMZeEIwLr8UHWug0ryvZvKAuRb3e1nHdXxsmphjCO+fWD2TiG6aMbchIwLcJkltSsOOhLFj6F9Nagr8YQZuuR7vXanK8q5aZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8081.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(6486002)(38100700002)(107886003)(52116002)(1076003)(8936002)(6512007)(36756003)(186003)(316002)(5660300002)(54906003)(6506007)(2616005)(2906002)(26005)(66556008)(66476007)(8676002)(4326008)(83380400001)(66946007)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iZOgnkBVfORNYxCd8V4XgwG8tK+vssGRjrrutvCqF6PvaGSpLy8T9vO2kTZg?=
 =?us-ascii?Q?nVCvz3hrizAxCNcfDFnZFF2jCI0uJkoxm3V5cMGuOSTO1pXrax14q7c8GlvQ?=
 =?us-ascii?Q?jpEadCbmbby0sz2OJddaQ6fCzv3Zn8neuZRwAq40q661h9RaxtAdGCDMR7u0?=
 =?us-ascii?Q?gW2LgSRMFfRKmdx+c5yfj+Ul1+QI+cvexSCnx1nUDt6aKSB+ZRqtAqP2vABI?=
 =?us-ascii?Q?453Vw1EN0XMIvl5I+jQ9T4ADcxLESwmAuvybrzL+KMKPkKNx35aO//2PJLTw?=
 =?us-ascii?Q?Rh2FXdbXhzyxecF8LPiWGavpOBkG6CT0MwtLZOgIxfvyvhZ01/qdITf6qf0T?=
 =?us-ascii?Q?VrUVV3DLKu40F/ZvzaHbdLXNwSbPlbUQDSh3KwOQkJEutEuFYZroyXc4eOeh?=
 =?us-ascii?Q?0F7QQro9v3CsFf0fqxCjOB2+TiryrzEW/HMVOBpzlXV0ez6qZyZPk3r5k3AP?=
 =?us-ascii?Q?OgcW9jfX8w+oAg4a9Kiv79PbLsGV4jbc0jL0E1Tj83q2YQG4X3qg9OqoW5GO?=
 =?us-ascii?Q?CL8NEIPi9TjHiDp28U8r6TnyuHMDaIYpSTIr3zIHstdy2DTvCGKWBt2nwMKU?=
 =?us-ascii?Q?6OuNnlnROdYpPvJeyaDnYtsoboz/EItd2at7dV6t/bfHMt0M0z6KxvjsT7Xg?=
 =?us-ascii?Q?B/o6r1oQZI8hXO2RChDdbjlNk8BtOP7tOhj9AHzRzYbPJiWFDpU0A/xeWqHE?=
 =?us-ascii?Q?og4TGcVgH7z/nR3pluqw/sLDXVD2vYtkbNGLubxkXocorDW41ziZXKeAaagG?=
 =?us-ascii?Q?aHaqqMLkQhfaM4XBP+IT9LWppm61S87QR0IAi4fimSRAumdvI5tgnBp8s2Jm?=
 =?us-ascii?Q?2aI9Jbe6fStbnhntdtyPPEXDE25ua4dWZH/dwlteoizS0ezIxYIekS69EWUt?=
 =?us-ascii?Q?hGkn4/5F2O3YOi8vefPtzT48gZqyF8r8MclVdQwBY7boTSC0GKR97yK3pV5M?=
 =?us-ascii?Q?FI4/gv6xANt66YdoDDQUpGCCOZ3aBUnrNYjQiAj5bkbIY971L0Cj3W0KaehA?=
 =?us-ascii?Q?GNzYUkhrc46r9aVCBfZSkRZL0DuNV6hZvD7mL/gHErOTz9GdniB0RH7v2Ztw?=
 =?us-ascii?Q?h9WOJH5NpW1KB0hl/adC+m9uuHR5WRepqJmLwPKaJHn3xzNLHd5qn5CyGGZQ?=
 =?us-ascii?Q?oMLVPjqVru3a6axhYDmXBD2gUQo/tNOJdTCeDoSzew4LieZGNc/r1gSGT51J?=
 =?us-ascii?Q?6AX4zAETjCkbheTC0EP8ZS8qQkBr9Z216rYCGLePvWKRxuDL6mWPFmO0hBNO?=
 =?us-ascii?Q?s1RC5pQIYpnlifaJx/2mTsaqxCBvST/ShJEN3zUzBhwEW6fpeClDm/8cfPDT?=
 =?us-ascii?Q?3XtEbMKp6HKfV3vRysA6WOhyWw77Cx2YfeqNiItiCWkLND9nmHqDCqB4Z/o1?=
 =?us-ascii?Q?UBcpHpjR/YqnXFASQ8bjV2/nhJZU290zucSOyeZxjx7NHdnnDkEmXJYR3DvT?=
 =?us-ascii?Q?2f1Ov2ptL5Nwa3p7IsIq16/PzLBY2lSnZKHFbircAAzmfMhWgV+A9qMbFI2U?=
 =?us-ascii?Q?CVM4uKmWm6Jqn+Rrr4vkc8z3LVFLE900X1B/qWyyksJz/6h0PwWIRdgwotbS?=
 =?us-ascii?Q?ja5ocUdmFi9+QItY290ChB3X383QblcW7chAoEEzig95Chi3V4nnHc8Xchwj?=
 =?us-ascii?Q?QRSzTve3pTPslqrx7eZGofI=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767f90c5-5865-45c8-18a7-08d9ea254a9a
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:33:33.8437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IBpl3I2Yo42vaIjLiNrkJZEBId41PMx1rCfkd0jJ9ltGZ0jrwqa0ScAwC2C8PqUcejUL9XrJy9LwaRtGUFxRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3686
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org,
 Vishnu Dasa <vdasa@vmware.com>, Jorgen Hansen <jhansen@vmware.com>
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

Tell the device the page size used by the OS.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 4 ++++
 include/linux/vmw_vmci_defs.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index b93afe7f7119..ced187e7ac08 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -578,6 +578,10 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	/* Let the host know which capabilities we intend to use. */
 	vmci_write_reg(vmci_dev, caps_in_use, VMCI_CAPS_ADDR);
 
+	/* Let the device know the size for pages passed down. */
+	if (caps_in_use & VMCI_CAPS_DMA_DATAGRAM)
+		vmci_write_reg(vmci_dev, PAGE_SHIFT, VMCI_GUEST_PAGE_SHIFT);
+
 	/* Set up global device so that we can start sending datagrams */
 	spin_lock_irq(&vmci_dev_spinlock);
 	vmci_dev_g = vmci_dev;
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 1ce2cffdc3ae..4167779469fd 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -21,6 +21,7 @@
 #define VMCI_CAPS_ADDR          0x18
 #define VMCI_RESULT_LOW_ADDR    0x1c
 #define VMCI_RESULT_HIGH_ADDR   0x20
+#define VMCI_GUEST_PAGE_SHIFT   0x34
 
 /* Max number of devices. */
 #define VMCI_MAX_DEVICES 1
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
