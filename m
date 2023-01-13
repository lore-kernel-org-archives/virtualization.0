Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1817C677F1
	for <virtualization@archiver.kernel.org>; Fri, 13 Jan 2023 22:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77F3761159;
	Fri, 13 Jan 2023 22:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77F3761159
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=k786YXip
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1O_ffE226jKY; Fri, 13 Jan 2023 22:37:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01EAD60A93;
	Fri, 13 Jan 2023 22:37:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01EAD60A93
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFFCAC0033;
	Fri, 13 Jan 2023 22:37:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6171AC0033
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E040404F1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:37:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E040404F1
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=k786YXip
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u1RMb0Vr4oQ3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F1D0400C8
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F1D0400C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euHYenux/x9w6pTas6jjp1W+mEj4ZPVXC4/Qwg58EdF2dV0U6zmj8GKn4KyttZHPhFuay1I/WqWeUjWTn5iE4D2y4UGtWJU7E5gQltAL0io2wW+TBJUn7GqE6uarGroyR6z+bYy2cnne8QAdjH/WpxWBVofB0Y8aUbQqyl9E1emWTkiWqO61BBdAd3ZFcKrIAkN42bM/mgehKXnZbNmKeL7wncNZeneoraKVOXErcl85dVUU2oDvbGPRAk8iQsAH3/ymVkEXlvkBz4ciPjSxwBTdTlWRIV+PyMBmdXEA4letoQk33SfNIrluXMdIvbP3iQ9JBXAoEX55imYGyYhJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fs8cexyEPQtXe/Wqt6dzVZq7uTF0aQLnToWno15hkGs=;
 b=K0FVWDGljnHDhgTlpdKD+YD7NQmzlvglCwRzI4NOACPhA+mS5M5bcRD7LXV3VS7Jruz+Chvyy16zqeiHmdDYkO0OtLRpol1KA7lD/RyJcyAMkM0RWu0xXV2xU9a1kQcNJLHYEIwreAxXzTyEKnrcGdO+1RdpqHhPjo/xYJNAvofJ3o4BTpxBZdiOXsjEB6lriJPchLqL91PoPoXxpjfnoqBpoemJ/iICqEw1h2KnyJNCIxu9JgVRaXWc1P0tBCf4XBPg+IyFh0fj7E/jzzhRw+YeGOgIzKRshnqE76FIedNR6lTLkzU7TMOTM9V1NPGOMm+CYlY/moS80NdnPevZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs8cexyEPQtXe/Wqt6dzVZq7uTF0aQLnToWno15hkGs=;
 b=k786YXipiebdNoBTZG62Sa0hUqWJyc2xQe3M4UinrQQIenpSxWNe7zaElGvmJ7eZOF/Gw9LF3rasg9LGX4Cp8d5hWrS5hzQshIytFhb2TQnrXRWAbpmuEwZ9bnpbgNV/WdrFhhxvd0SCOBDECl3J8oJ62gaKtddgKpJHHGvbYeV3uXtO29otpTy9w4vBNjlCU9AMoSnlGKUf9LRLodnk5xzoft75Xd6ERheBf8RGak3MEFrtqN7qgQ+6UU30dSQU6mGyArLa0pMSA4w0I1UENh6sAxeslFjw0kOX81WHM9mcNsr87SbqxVHxYekwod46f/3s/o4LwkrChwIMUNMqBA==
Received: from BN0PR04CA0172.namprd04.prod.outlook.com (2603:10b6:408:eb::27)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:130::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 22:36:57 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::c7) by BN0PR04CA0172.outlook.office365.com
 (2603:10b6:408:eb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 22:36:56 +0000
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
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 22:36:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 14:36:43 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 14:36:41 -0800
To: <mst@redhat.com>, <jasowang@redhat.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <kuba@kernel.org>
Subject: [PATCH net-next 2/2] virtio_net: Reuse buffer free function
Date: Sat, 14 Jan 2023 00:36:19 +0200
Message-ID: <20230113223619.162405-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230113223619.162405-1-parav@nvidia.com>
References: <20230113223619.162405-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: d399f21b-bcfc-4c71-62f1-08daf5b6ad60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2DVKPyGPdCGSiql2j8m7AVOThJskJ8K2DVAzL9+HBsO0buHSu5g3Cq2e4Heg8AIKUSxyU8Oxn9reIEgTuqFBWyGaYZkeekXuBrXRSqXxjxznLIu9tj4OEydxUyU2/6g3OhZV7+53i/Ol3K5slOo8fhiKOSv06gKgDli710qTIiy/AdvJeY+F6V/HmVgTdvKJvSvJ9+e1iINz4eORjYF3BcWC10vSHRX34Mi4rLCJIKy73DhHgpxigefKt72I9K7+eadx5wYmPASYLG43oJ+8SkWyMvFdPQSJBwTV8g8gY7doCbta1uOLCIGERYBPvLLSMpPeOJVI/+9dPYOpP7YQun5Y3cNxzsiVJlJZNINZCzLEfHAtygTxg9b45o8Q7ejmtU7yDkcB7jwNk9u9aW1s4WVuTYI6CWlBffmFRyxq/qWDo8eTEJw4mqdC16ygSgkV9uhH2hwWHGqjWOMulf7nO3DTYS7qbewRuhxmkj2NWTaQlyPwae69ZSdfmsRDe5JKZ/zRSBAh02pegtdlGWrCM9t24psDtyIOk1tOegvo5i4n5H+MmX2QvbjDTvtUDaTpTk19r1s8NOzlHTIV+5dFqfpDIh9ogTncqOpH2GlR17cirE+dLb8jf4bIuVu3GDJYK4Khhcb2D5FhhKyvu/JLlLjPaL9/Uu2qALRT0TgY89j6QcPkoT1GFnOCoNtc2zV/GGO0R5Qs95Z2jL9Q88Y3g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(82740400003)(7636003)(36860700001)(4744005)(54906003)(356005)(70206006)(6666004)(86362001)(8676002)(70586007)(41300700001)(110136005)(40460700003)(40480700001)(83380400001)(5660300002)(107886003)(8936002)(16526019)(1076003)(336012)(316002)(2616005)(2906002)(47076005)(26005)(82310400005)(186003)(478600001)(426003)(4326008)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:36:56.5943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d399f21b-bcfc-4c71-62f1-08daf5b6ad60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
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

virtnet_rq_free_unused_buf() helper function to free the buffer
already exists. Avoid code duplication by reusing existing function.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/net/virtio_net.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d45e140b6852..c1faaf11fbcd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1251,13 +1251,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(len < vi->hdr_len + ETH_ZLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
 		dev->stats.rx_length_errors++;
-		if (vi->mergeable_rx_bufs) {
-			put_page(virt_to_head_page(buf));
-		} else if (vi->big_packets) {
-			give_pages(rq, buf);
-		} else {
-			put_page(virt_to_head_page(buf));
-		}
+		virtnet_rq_free_unused_buf(rq->vq, buf);
 		return;
 	}
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
