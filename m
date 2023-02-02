Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19162C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 05:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5CE2812C2;
	Thu,  2 Feb 2023 05:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5CE2812C2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pi6fT25w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mF-nT5We7EZ0; Thu,  2 Feb 2023 05:01:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 135AC812BF;
	Thu,  2 Feb 2023 05:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 135AC812BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F258FC0032;
	Thu,  2 Feb 2023 05:01:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D86CC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B24D610A3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:01:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B24D610A3
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=pi6fT25w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sDK-5xJj3Jcp
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:01:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CC21610AA
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6CC21610AA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA4YuBMSuVI3dUTmzNavMwdXQyAt/CWODHIUael0hXFjiLJrY8dg7tmwHP94iqcCUI1rdH0P5MH1gPhsStVSe6NFzW9NzmUXwLgIlHA2Z1O6ctA8ODHBRHBevb1BXntSZ6dIJS8dZq05xkkprFqV3m6yi8Ph7x4M6Sbip3M23io+aexH/JDERYjy8jBUIY8r+h4Sa8Vx6U5dko2pMpF0qHMStmCNB97WRhTnrWn0BDNLE5wHtJHwyWr+QdLxSZwThK0KVIPTHm/3icNPo/T3PytllCWRoacXdU0UWx4Nx8rTO548KmS6BJlHAZHRtbMv7qo/X+QanGkQaEfidj/g2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO5HULnnh0BYkJT/o+BWil1sMZO52G1Bx+6MxYfsrV0=;
 b=BRaZZK9jhZCsNfPphapEXURb9GjB1X+aYtNdGY1LNznRUnuFX3bFPf5DEkeDaWcsRNx4aMRLuStTCbqRZcgmL5g+ZQEd9Gk5PDVjfVKH7apYVe3AKnd50/ogcmJ4xFOGhSCiPOKdsGSuTWVXLNsCxKGxR1roe+OaDpkXI3jkjxL0uiHN1fe3zBAL++M4wJs+36F3LCyIaZY/3AQ00fMZLbLHxvlDDqIr141Nro7h88aw2IRHQy56ZZOX2O1a53I7K4Ldkr2OvxOkOvD4xR91U/sKeQqvLNh5HLqhAadm4YPJBJRABhT9Bg4a4b8evzXEnf1ckH839cSQ0o8LB0RV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO5HULnnh0BYkJT/o+BWil1sMZO52G1Bx+6MxYfsrV0=;
 b=pi6fT25wui26EkeYjiGN8bwuz0OYPWGMq6XzpZkmcsvMiwh3wHqEu2aJu2QnuFP4IyGPbNUTmf6kVGzr72UglcyoRhcwqOu0XtmTmK8/3nCB8A/yQ3NXNMkw6SGw4qHD7k3MWec9Tch9Hb3AQSP7dXlO8omx26hyMNMMx6M2jrs+AyqeFS+DBwPPxaiZCFF/wppas6ReWP0DgOI9mgQjYNKyeZUdZeEFPJRmWg5naFoebGQ+70hpF4L9bn/wOPC4sAUAX/a+TQwQHIKLJppDi++yaf0h3FwIUvQ+zt+Vgd52ewLIdqWOPIzx0I44GPP3Ldj9S/GpZQvklI4W5TXNBQ==
Received: from BN9PR03CA0641.namprd03.prod.outlook.com (2603:10b6:408:13b::16)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 05:01:22 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b2) by BN9PR03CA0641.outlook.office365.com
 (2603:10b6:408:13b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 05:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 05:01:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 21:01:02 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 21:01:00 -0800
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <davem@davemloft.net>,
 <kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 2/2] virtio-net: Maintain reverse cleanup order
Date: Thu, 2 Feb 2023 07:00:38 +0200
Message-ID: <20230202050038.3187-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230202050038.3187-1-parav@nvidia.com>
References: <20230202050038.3187-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5d65d4-e7dc-479f-2ea9-08db04da87a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFHjnYTTCK39E2rpHn0T6BPjo6So/xSZYV4iMDG0kItoXUXuujgh2jW9S4VYjHn4jMJTwpPv0P+XCk83N6NiIBNstSsnE7Ox0yC8RVtm5lf8EOVSzdlP7SbtI6mJ3hHTupIN6Mkrpvmfq4WKPzeImwcfPou4MxgEZ6dLJTvTS1v8MHB52bokDfznbDsoPTXGIVB3gutHuXMPj0O3IYbRkwrmTvUFpWwvUXGpre7D1qYMkZV/B5XhCM7YRfV6wXH7G7+3lHKxJtewtJSIqslrTJAvB0WC08tDbvfyTjKiDNKAGC/h/aEyfHYH9nQ0hpK9H0sGs0CUDtp3ApzIRqJzggiv5Jh8JlPn2rqxwt7dvngkMGWVexnik/hRfVefsbYYLqULBwYg8tS7ZiEcc45qwrixt0ooH2Z+xazWDFsq+rm/MJ4W4akTVSSoYhCsSLzSns1jx4BP+yYXQmE0UermDR7VdhZG9sL0t6XdI9pdVYMk93inWnEbgcDGJgXwQK0FCtWgdmLUaBZbnZWnzHRftHS+8F9MpsVesmY7pcmNGgDKQgxwodSf5Svf5IE5AztaT8wRyVvytWCAef26MJ2DF3tLlH7xHoboRB5vmNun6FSll6LpOEUHZpso1mgV67ODJFjRmRQzX3j2afHcdkctFJdAj2RDdUACisbaJuHR6F6KJvEilE9qZ5Sz6JsrsHoVDlSqKBQBku2tTW8GPFFFOg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(336012)(83380400001)(6666004)(107886003)(54906003)(110136005)(316002)(47076005)(2616005)(426003)(36756003)(2906002)(82310400005)(7636003)(36860700001)(1076003)(40460700003)(70206006)(16526019)(70586007)(26005)(186003)(8676002)(478600001)(356005)(40480700001)(41300700001)(7416002)(86362001)(4326008)(82740400003)(5660300002)(8936002)(4744005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 05:01:22.5935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5d65d4-e7dc-479f-2ea9-08db04da87a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
Cc: hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 bpf@vger.kernel.org, pabeni@redhat.com
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

To easily audit the code, better to keep the device stop()
sequence to be mirror of the device open() sequence.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b7d0b54c3bb0..1f8168e0f64d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2279,9 +2279,9 @@ static int virtnet_close(struct net_device *dev)
 	cancel_delayed_work_sync(&vi->refill);
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
+		virtnet_napi_tx_disable(&vi->sq[i].napi);
 		napi_disable(&vi->rq[i].napi);
 		xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
-		virtnet_napi_tx_disable(&vi->sq[i].napi);
 	}
 
 	return 0;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
