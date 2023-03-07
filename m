Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD20C678D5
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 03:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C49D40635;
	Tue,  7 Mar 2023 03:57:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C49D40635
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WWBLskir
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U5N3mbF-BVtp; Tue,  7 Mar 2023 03:57:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C2C9402F3;
	Tue,  7 Mar 2023 03:57:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C2C9402F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC3D7C0035;
	Tue,  7 Mar 2023 03:57:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D13FCC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4DB040929
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4DB040929
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=WWBLskir
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RznMAN5zJwNE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4C004091F
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::605])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4C004091F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFdbKjlNc/kzzlBVwHxxw2inW+hFGVndC3W6+fTCAAsFY6X9YOkhoCgQDmji9tL/rtqGr+lDY+ZLBacohvAqdG11PAUUzfLR8wt6oMpJcE075UACnHG/yXlZQXYxWEl4xCVyz2qf3ca5q75qyXp3ECOScdEciwjMSxCbXhTliGiz64x4LziT+9qdIewi/ii40LN/c7VrqkC4mD1eV4UBJ3mpJR5Wt/YsoZ6QLdLzB5Fkd/TgEJLk4yKjVCmiAQU0koddE1ixGRORWaMnwSTguSPihHvHbOGyPRKbUTwJmgCUYw/Vv3Sfdn6SA/5RxoobavO/zIV2RSzcpuw8i4s3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cN1TmOKGA/Qh0xyM8pDHEZ239JSfVHJUP6NnrZnl2I=;
 b=lQc9JcYYq3HywGbleKccYc4622+mW1HVPHEZKt1qdbufbrnhhqwbGZHyvqnLufYZv6qOcf5hkSgcHCU8+k7tDnUHF/BOviWGgtUMKrFZOAmKTS8NC5t52nWMtD7XCxDGM74yEpWRbFwd79KArAeGboPvjYqGFSja3EHt3xIsEqs8gONF2ADetNSf7mv7TiWIqW+iIby46Lsi32OOvEvmjH/hHC8mXksAlB+0ITk2CYwZCtFpDTePJqb44WIZmAXKHLKY6s9jWnY+3L5w7w3mvekLEcJOqp6uLoegOujaTJA7Mp679lRGY7cuXNiCDnHIKw1B3qhUaEhFamkrevXNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cN1TmOKGA/Qh0xyM8pDHEZ239JSfVHJUP6NnrZnl2I=;
 b=WWBLskir4+6UGA/2B9oVy5oA/0020PXpwyJuFhGp4sHcocCnIU3tKVfZNX5teWN0ok04QzDxjGmZMNuEcV8McWldfcgIhyeLde8y6kbFqGvkTzaOPz6SF3s92Iz2wKBGjaApNxBWEx/X1Dj75eHmBXfXmT+f0aSQIFecX1sijnno1+eKWdZQ8dZkU6gHrEzak1Yio+rXknygi5p4vUNu6QGL+/lcRq3ty98tUrtuDvGawfqz3moc2T2P+9/fL1JbEFZzRNgyTLACDfwMaWHHHqkkss24zpflS39lORy4elyh2Ak73poEQhUsnm6MT6RuZX1EFXddiwi6DuIdarHQ6w==
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 03:57:22 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::a7) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 03:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 03:57:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 6 Mar 2023
 19:57:11 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 6 Mar 2023
 19:57:11 -0800
Received: from mtl123.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 6 Mar 2023 19:57:10 -0800
Received: from sw-mtx-012-001.mtx.labs.mlnx (sw-mtx-012-001.mtx.labs.mlnx
 [10.9.150.40])
 by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 3273v7Pn019487;
 Tue, 7 Mar 2023 05:57:07 +0200
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH 0/3] virtio_ring: Clean up code for virtio ring and pci
Date: Tue, 7 Mar 2023 05:57:02 +0200
Message-ID: <20230307035705.4479-1-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c60d362-4419-4541-ac35-08db1ec00e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUgC+XSBuytgjJvdF2Vs/GyEinr/HHmj4fNw/JdqqnPr4ozf5t3K+1uCUedAelsBmKRs7cFOj2roJ+PsG3c+ghLcJqpYllbDBEBD57U+a9AeHvK3tNqHqsENskthliOv7fd6tkFpacTHJ8pXHjmWgpLzXIp/m+A3FNKhQdt2uwkcbCRcqvkqCwLlGwUds3IXQd7r+yzHE9valLfjsuyenArrkzehYy4NOk2ahtWYLhJmTz4uc7nuJxopd3+A4YZgQGmvo18f1/qC/VyFszWmvR/hOtWSdxIe4vzwMalz69HYdm541wki8l/XJf8DvoudVBkzrn6vcb3HFKoZo2hbWcZxUwYx1b1BwuGEXG5JvLDCrE7bE3PYJerGZULUlHNuYRtQMYvaAaAdpSTt2gDRGFg+xhkdK8AF9NBjYc9Iyl54JAfC/SXVM2obJ288osWnLRu0FC+lmoAw8WFQcu6pdLWt5fkmyHj9danTtI5KhML22qwT1u9qlQIxr8t081qxLweWqJmIOFm6+2VEdVeCzFHxcxGwQ4BQDoOJ9kVFoBcQvZHrOvniJxD9/oiWtLKLQ67BgCBB45ah4uslRcPQ+Q/3gaf3HIHAPeljQEn/DPN+1AqZqILJr8ccc/GbHD1kiorcWbvDjU99YU7CvYwigJr6aX8dOhEtD7VYDwtxbN3agKTIeGQ5nteHryXcaQDfYEkfQiwxshbNbv7z6xF/F22tQx3ar9IWsfNwHnSXH14lingQkPL9C99Q6/X2N6OV
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199018)(36840700001)(40470700004)(46966006)(36756003)(6916009)(4326008)(40480700001)(41300700001)(8936002)(70586007)(70206006)(8676002)(4744005)(5660300002)(2906002)(82740400003)(7636003)(356005)(86362001)(36860700001)(107886003)(6666004)(1076003)(26005)(966005)(478600001)(54906003)(316002)(82310400005)(83380400001)(47076005)(2616005)(40460700003)(336012)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 03:57:22.5255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c60d362-4419-4541-ac35-08db1ec00e67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
Cc: "Michael S . Tsirkin" <mst@redhat.com>
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This patch series performs a clean up of the code in virtio_ring and
virtio_pci, modifying it to conform with the Linux kernel coding style
guidance [1]. The modifications ensure the code easy to read and
understand. This small series does few short cleanups in the code.

Patch-1 Remove unnecessary num zero check, which performs in power_of_2.
Patch-2 Avoid using inline for small functions.
Patch-3 Use const to annotate read-only pointer params.

[1]
https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease

Feng Liu (3):
  virtio_pci_modern: Remove unnecessary num zero check
  virtio_ring: Avoid using inline for small functions
  virtio_ring: Use const to annotate read-only pointer params

 drivers/virtio/virtio_pci_modern.c |  4 ++--
 drivers/virtio/virtio_ring.c       | 35 +++++++++++++++---------------
 include/linux/virtio.h             | 12 +++++-----
 3 files changed, 25 insertions(+), 26 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
