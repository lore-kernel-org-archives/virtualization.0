Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E83C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 16:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AC3961178;
	Thu,  2 Feb 2023 16:35:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AC3961178
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m1PVQU+n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WoShiUKQlElf; Thu,  2 Feb 2023 16:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EADC260AC4;
	Thu,  2 Feb 2023 16:35:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EADC260AC4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1D7EC0032;
	Thu,  2 Feb 2023 16:35:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0E45C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 16:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B72660D79
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 16:35:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B72660D79
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jrd4NAqLxDQC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 16:35:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEF4A60AC4
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::618])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEF4A60AC4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 16:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLajSnvAdp/htXZfmnVERkvvw1MIIMpXEVbJLlMVpSbwZefExcxM3XXkctxueSkjmICGsPmEldm1ocRuP8+Lv4d/VL0e/H6uRprHdaoe+eSo4HKvgFbNxS0g3youUReH+bDLPQNZoU7BSVtRm73oNz9MbF+fySaog26SWtEHa/cnfNs+bylvRE3TCdXHzy4NoDUuyrCfbnri1IdOLJ9kVgK+odQlXZYmicq/j/+8z28OCYdobZ0Cs7bIH8dOPkU2CCd4PXKX0z+00F/sBoz+tRXdFT/j9lRP+WaK4uZB1Qc8xvdUXMhNGEYDInl311mUMaG/1Ln84kQU2F6bz//ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bCCKtQv3/FqHLvDlSJb0lYjWMuz9opIWiGHiBiKbsg=;
 b=f+tf5Axa0osqwCvEAbPTKEYpRrEZqrlhr53WCAiDQFo/0NT14CiUsYxpXj8ZKhn1Jn0eUz5j1cCPVYeN15QxpAZmmMrIWAJo7xe48QCQMSbmKsmb6DzIOWkRCEt/QJpt8SVHyIfZVWHgw1x9Qs9QO3d7cLbXhDOPsfWR1FAOED67D9ODtS80vGHwWfdcb5OrNKJ6ML75iU3z0AkR3h8/b8vhZr8AmpRYc0gtTYIS3+YQ4wf/UnMkzkaG1fE3y7dRUCBDhavEWQeGx5eIJTtlol9UMZYSU7h8+icyEdMiVqNWr6CNgJATp2jTnAqGAp+G3A8pi2uvWV6JMpHTDsEyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bCCKtQv3/FqHLvDlSJb0lYjWMuz9opIWiGHiBiKbsg=;
 b=m1PVQU+n5j1Mf5fA3UzdRQggzwc/op/WXr8sYJjeTn/lN27O4IdboxXLGl8r3tKR1c+4US6UFHJsqe2MlrEhge8jX69X4ceoHiAsHiaZwnwGeQ/4yxNbxznoK57Ell/8nBVTWv2CeD7gPwvxLSBEYkjV/LmfBXM9Q9jOogjPxMhBMmcLHmUE7D++EuviK7wsEEkOyJ2kRjrU8Y4ZHEHvt92QzEcq7Gix3U72FfGgZG5rJyslnRxrzx+OwqktIifsfk/dbq/lYvmYw1PVyyOaBnJ72cCgSMOXWPOW7Xp3BAFvnmRe+Fac0FEYsKIvncn3pFegA3QPPM50Xnqn0rfEOw==
Received: from MW2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:907:1::23)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 2 Feb
 2023 16:35:37 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e4) by MW2PR16CA0046.outlook.office365.com
 (2603:10b6:907:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 16:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.28 via Frontend Transport; Thu, 2 Feb 2023 16:35:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 08:35:28 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 08:35:27 -0800
To: <mst@redhat.com>, <jasowang@redhat.com>, <davem@davemloft.net>,
 <kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net] virtio-net: Keep stop() to follow mirror sequence of
 open()
Date: Thu, 2 Feb 2023 18:35:16 +0200
Message-ID: <20230202163516.12559-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: b45bc265-f6e6-4e58-86e2-08db053b83bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXjzouAocSL4YLsMxVw9V5tNHaBF9O19qWZxwo+3Vpe+0aQyx1ierZ8eslK4UGGfDWgxgzCwH9EwkPdyD9muYk+MSp5yxIBX4yzBbHNjhJR5WHgs2qke2WKAar0cC/1j5LJNTdpYQee+btN1vJlIEzueCSZaEMEB59tQnobBKwXzVe4ZZih5eZ+Y9SivnpAA1peZXj4f2esRW1wZMOCzG8SeJROplvlvM9s3uMTxRxhwwYhhb0xBnB9VZtZD0XN80AVjTVgEWcAriwZoCh6rQx4JnhS1cM7pO4U6PZmpUL+Wb27rPFA2D7dXHwMQhHkVq2ek/YCNakLTRZS8emdqalaDUe1eR64DDJy5NNcrKn4g52Eiohdg2k9CS8uQc7PnoNoSG+TfXTv8Scqm9d3u2zYJe/0AGgdOSjCb9RVtJjxLIfVJ9ipqAPHEVRVNMMevoPFkW3ft+3loBy8TceFy8p5+9VUpAdxsYiRGHaD2c1dvDbXfw7qRww1KjHvWnf9r413FHr+ym2TFOc6nBGM9kAUlWyqYR9RwarCr618G3kEujuuE1wAA0qU1x/7G/MADtJBmkbbFXO7LWQuL+jjKXcXhHphQJkttHdF6AduVAj6w5vef+Sk4ZOEvgRzi7pOik2DHbjeCB7Ai1DodBwimasGLGjFZGfskO+VgIHsROfsj3aJWnmm58c2EuiSemeZ9KaB+wQ/BGdfEaSdKfFsoxw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(47076005)(8936002)(26005)(41300700001)(36860700001)(478600001)(426003)(186003)(6666004)(36756003)(40460700003)(70586007)(316002)(86362001)(83380400001)(54906003)(82740400003)(110136005)(40480700001)(8676002)(4326008)(336012)(107886003)(2616005)(82310400005)(356005)(7636003)(70206006)(1076003)(16526019)(2906002)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:35:37.3343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45bc265-f6e6-4e58-86e2-08db053b83bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
Cc: hawk@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 ast@kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com,
 Jiri Pirko <jiri@nvidia.com>, bpf@vger.kernel.org, pabeni@redhat.com
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

Cited commit in fixes tag frees rxq xdp info while RQ NAPI is
still enabled and packet processing may be ongoing.

Follow the mirror sequence of open() in the stop() callback.
This ensures that when rxq info is unregistered, no rx
packet processing is ongoing.

Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e1a98430190..b7d0b54c3bb0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2279,8 +2279,8 @@ static int virtnet_close(struct net_device *dev)
 	cancel_delayed_work_sync(&vi->refill);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
 		napi_disable(&vi->rq[i].napi);
+		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
 		virtnet_napi_tx_disable(&vi->sq[i].napi);
 	}
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
