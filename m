Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C74C6379F
	for <virtualization@archiver.kernel.org>; Fri, 13 Jan 2023 22:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41F1441B4B;
	Fri, 13 Jan 2023 22:37:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41F1441B4B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=htQ74vLY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q46UFLXarCuE; Fri, 13 Jan 2023 22:37:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8002E41B50;
	Fri, 13 Jan 2023 22:37:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8002E41B50
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADFFBC007F;
	Fri, 13 Jan 2023 22:37:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98983C0033
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63AC041B50
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63AC041B50
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tv7Yp5-VxNBs
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BDE141B4B
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BDE141B4B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl6pmusoVIXUSQ+LFP8FUwCovq6z9OXM9iRbnvHQab4vnZ7mqzmIBcu9oHCZYdEQJWTGZRe7IGRxTSYDYmOnkphp8dvW3MBM4ZRmdHg+gcE2szMsTjTRh6jjxTr4Xge4mmI1iAAhBFttxBbPfCXxgvze3TZdSFEzLdb/o2RlwRtlakU3mkPB37RkzDaSq+rF2a7lvhII0iYp/UpOlQ9/xrlRWO46eQ9SmDJjA77sYZcXWcU/DJDC7tHayS/rWelzgzpyL9qiPEcK4RqyZSr5VVJxbDEgFiLVJ1cBK4BMlzU/iTUsslGBE7Ud0A3/SH0EwBgbSSKnoRoCIyGNyd3BgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efUrlq4iQLgu7fdEt/y7jHLNRlRp/gkvlbIC2sCdHok=;
 b=G2sAXdzFqrS9OdiiaCt9eO89Q1xS0mat7T62fzSA3HxN4+yUCuY2ET3RJ4FExH4InPWjkwvdRBPIQ8LvXX3A1PzVh89Dz6mgEznV+zEH4RXMFCRaVTRXCPqfyh2qX9L5LuseRItza6d403esIkwZToKH6I+VjgzqgFdaa6lD/WAwih71QAkr5cTxzYjBuibVnU2i/AQa9fhcLJR3jmm8VO1Gtg1QuudkxLn9ZBPJ25aHjpIAKFjbNtcA2pVqrOy8ZR5oBwK28eJASaoBcueoR7lz78++xFQMA1840ohZLznjltc2UCVzudMVePlHugso2ljVi4SJ6otJDrIboLZroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efUrlq4iQLgu7fdEt/y7jHLNRlRp/gkvlbIC2sCdHok=;
 b=htQ74vLY35tF4CSDgMrmakp8QhzcmaACQywnAQbEDEMua+2d3q0ZXtqIME3vSOFeswjNdK/Nx4pBj+n+/G0SDbRvIucbpZFKhuQmtFq0r69Pa8FjFuqO3RJLQ58T7sevnFG1nO8OSxCdYW/S41aXO59otUpdIFAlsDw/EJpTtCcwglCUBCpvyqFOlYU7qX5tVpNDvxOvQSL4NaEruA8Zd6kqMoAFIoeJtOK3wRpICeacxmR80t3jg3BSSkZKMV154TgAKRTFkwB6+Tq9q9j1eiziJg12rMS3QWOlJa+nHze+0GjUGWBDd4rXuyAGmnsOS047WpqbUf0wPJHBSJXgkw==
Received: from BN0PR04CA0154.namprd04.prod.outlook.com (2603:10b6:408:eb::9)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 22:36:55 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::d9) by BN0PR04CA0154.outlook.office365.com
 (2603:10b6:408:eb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 22:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 22:36:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 14:36:42 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 14:36:40 -0800
To: <mst@redhat.com>, <jasowang@redhat.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <kuba@kernel.org>
Subject: [PATCH net-next 1/2] virtio_net: Fix short frame length check
Date: Sat, 14 Jan 2023 00:36:18 +0200
Message-ID: <20230113223619.162405-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230113223619.162405-1-parav@nvidia.com>
References: <20230113223619.162405-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d585f7-f860-45a0-fa3d-08daf5b6ac90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILPbFXBMJHm/4fL02Ru2Qv2XADjL5lUj846uMjEDSAQVOL9YmI1xES73d2QvrhGM4frVtRgyYW70YZ2sMZUxh2hWPg0lFZ6Dniu1g9y4AZsMWw3112Yccq1EX9qR54A+Fb8Kn30quhck51j+MkXMWo1TfVgimLODXP6pHxIZbOyQycpVndKZB7PWtks/HYMgtlJ3SDrxpmm1RTtCYb0Ge67atZajw+3C5yBn50iblBb0zMrAL/fX2UUS1bP2Jtij28wYwBEopNEIN8anYtD21Oul8ns0X7OzNqb4VZZIt6weSA2AokFzqmyorrtxWUeeA2gOH91uKVcroegP/9Jll6+VjIho7gi+eqFylM/CuD3E6TsMx3VynZjhnOphL6Q0xMTkHjwf/JkDbAa/cgJ56O5H0ejJqUSBawSJ/MgNxU6nrYLwvaep4UUBwAfXsbsvsLLX8acxtkeTTGloTi9rDKzudMGc1KtH2SMJyQA6CVgT04FQF2L/UyTkR3ZqD0KEJGWcZQVwqlYWHki+MNZZofURrgUaZyY22dDBqmrBWdDDMBmP1sXIqr7nUGNPgnKicMBfXSFX3XqhRVf2DmV9ZeYfJ5bQJHbcMe1zCyCw6+sYtW8jbmB690tqhus6UL7bD5McbLZJBhb1B2SWI2+cGDSIjIsmlswkDnYQz3I3VJQ8je4I023ozYeR63Ji5c1fq0baH8Y9i2ANDj6iElq69w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(16526019)(2906002)(107886003)(26005)(186003)(6666004)(478600001)(8676002)(83380400001)(2616005)(40480700001)(70586007)(110136005)(36756003)(1076003)(316002)(54906003)(336012)(70206006)(40460700003)(4326008)(41300700001)(426003)(47076005)(4744005)(82740400003)(7636003)(86362001)(36860700001)(82310400005)(8936002)(356005)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:36:55.2507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d585f7-f860-45a0-fa3d-08daf5b6ac90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
Cc: edumazet@google.com, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

A smallest Ethernet frame defined by IEEE 802.3 is 60 bytes without any
preemble and CRC.

Current code only checks for minimal 14 bytes of Ethernet header length.
Correct it to consider the minimum Ethernet frame length.

Fixes: 296f96fcfc16 ("Net driver using virtio")
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7723b2a49d8e..d45e140b6852 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1248,7 +1248,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	struct sk_buff *skb;
 	struct virtio_net_hdr_mrg_rxbuf *hdr;
 
-	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
+	if (unlikely(len < vi->hdr_len + ETH_ZLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
 		dev->stats.rx_length_errors++;
 		if (vi->mergeable_rx_bufs) {
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
