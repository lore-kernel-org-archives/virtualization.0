Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2603211
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279834; cv=fail; b=CqwJ9AkKxalp0PjEw2gJ4J31dqXsITWG1UTJVKWQgIbiktdfzmdQwVZztMJm9T4eD9VBr/F+tyqnlIBRro457I6f3HtkFu7Zy9hepbBIxRVetbPlXsEbqAOPfnMgAOmuVpzbOuSHuaby9YSyHMNJPml9/ga9O3CAJl+THlVgty4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279834; c=relaxed/simple;
	bh=fGjoCbXZkYDOkUHQIOEyChjg5bDzK28VoUgvyPdc130=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NNyJ8cpmLyk7HrzeRRVFles/JPFcxqw9nOGvYrn/IK5Co1l/OYLX+XXghzuNL5qRpO5wfcBe9wtVIO7d01SJn7m7X2dPpKh0M4zf8xMyGiMECXqaqweTx5IK3DM0Z+5eTMuTRz1KtspjLnGGVdtDQ0io/DOeInrDGazlJ+URS1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aq0m6g1O; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aq0m6g1O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmGObHECdErSwdHbXttGKxzJNYxCgV6zygVTgnmUd6xE+ys+kQmsfxuMiLWWQIdggvIZ0F4+quQhkwmszCWzrOayIT7cmJeivnsqkmNId6cfeZ8zJpjuZBs2XMEhMVzXwXCLoeekXBaQMnWB2QVQTUwmITRT4+WYbvARv40K0ilwn7WfPIRRIbJTYXf0P7L0Rtq+6Qp5Ph/fKGMtPNgi+r9vURQczAdsglDpPVAUF1dxlnPRDIjggWYF0FAksOy7MawZqMkHATTAuAdaQmP58zFrNbQrndxrjmWelbkrStBQjZmHA1Ns4zmLqNw3B9G6Nps68tlmjyUOUIi65HPW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEVdWgbC8fUXHE0TXaGdTSk61o6omhb2dkdOblXSL70=;
 b=jOKRwzlazE6hldKT38GfOXGGts1xXNhNM3N8YnsCtY/BHsPdRM9jX3kaXYl8OYIsWKUsvtsZSmohvaXnyXuvt/E0YEtf8BU46TdpaXmnsHB7fvRX9ZCsRvU+Z+TBR4RI/pa7L+4SqX/RVXmiksgdUWVoQkF2Z7uZmih2TmQkT2f7eyWRvMEgGoYI7zaYUdu18rP9FoJ500pgNTVUxP2CydTR+HkkcDGWI8xOsO9+eMjp3JpguSxVd/7vl73AWpOQOSJinbTpVAHs2bTPy6Dg0Lg8Qnrcgl2aA+IK+Dal1GMpojoUpuXc/+yfs/50YgfYDt+9Tq7nSJ9hv0kbhj2pnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEVdWgbC8fUXHE0TXaGdTSk61o6omhb2dkdOblXSL70=;
 b=aq0m6g1OKwFHDkDNWY8DuwY8oxhUAKs3fwHSYRA0bs1Fw/WJ5hC3BaofYnyATtanZVkmwTDjUgepT0vkD9tWWb2Ob0c55Y1Mh3CUXd/L/ER/zH+kGIGuM1YtmnV1WUgybxp13y3NqiEYlD62iA4IAksvVsMjAMmxjCFyfUWb3AyIc/nv9oQ7pXgR40ceylwqpkDC43aV0dH33Eir/mGCXxPKEi046+lVJnGRuhMaEWOf7CPTCXhOtt2d7gyo9wVqdxGxTLpZ3CqHy+RGgq1pDuTigHRR3TTCPXiUnBi1uMUQwXKoNRQLckBlhrC+oEoQvOq0ldhHyXRidTtnM7zKug==
Received: from BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 18:37:09 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::d7) by BY3PR04CA0009.outlook.office365.com
 (2603:10b6:a03:217::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 18:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 18:37:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 11:36:40 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 11:36:40 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 11:36:39 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, <axboe@kernel.dk>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH] virtio_net: Fix memory leak in virtnet_rx_mod_work
Date: Thu, 9 May 2024 13:36:34 -0500
Message-ID: <20240509183634.143273-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 99262414-282d-46f8-fd89-08dc70570905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k21dj2n9dBfl6cjqG0QVyh+4oIt7r8Te25woA1CirEiL9VNECpcbWRgqqJrd?=
 =?us-ascii?Q?SlZ849VlTUjLN7wXUWKo7+NY5xwxZXYWjPBT36kBMsLHLB12G1eYTcOMDeUS?=
 =?us-ascii?Q?mP/mzAUgcoxP8/J50H0X4vidB2pENCx/C6GETB2sCTz2rEAO57mJysLl37JC?=
 =?us-ascii?Q?BWEd5fMuwcRLG6ljd8sYcUrOEqxDfyT/W1M9NbTsXaq0tqSyDvvBraRq9gxV?=
 =?us-ascii?Q?uOn63A+9kQ2JgEwdACxxMZPT1A1OUFLTw2aBHtBppSC6FkcmmQ9A2iN/StsR?=
 =?us-ascii?Q?6GtKnI5MA1hb7L9X8hkhHHY7799VBC9cE36lrhvtaXg9W1bW2GqBq58pmwon?=
 =?us-ascii?Q?30iPiPvQBz+6GWPcYK5Qrms3k8FRoiINxCihumGDOFmpxFy9Tyt3q+OvbEhY?=
 =?us-ascii?Q?T4CdWh0fCOxVfk/id7o1vrhEst57LxohmdEGyP8us83j96qIIILX5b4hqSBB?=
 =?us-ascii?Q?oKl9N2JQFADia9Z0PsDZLPIXFgTP0LaQaZvGFwGd26Qed4fGLakRkvw62pQz?=
 =?us-ascii?Q?oa+7sv5lnkNho+aRUe2EqE+U/NZYGaplvVbnMHRB7QX/ftE1BGLR5zZQH9dS?=
 =?us-ascii?Q?hJmZwwTfJPK8LYyNROYSMHNHIfQYaXhI2p9i8aXSvLgVcSud6W5iIZ5W+4pk?=
 =?us-ascii?Q?Z3nHpHkhBC8ZJ2g1BmmLY2yi061HMENPDW3WQvpc3uNlMoC6Vc3oorXr/rOl?=
 =?us-ascii?Q?QrDPbYkxETZ8GuOY0aVsPvs84f/LzKS2F1ZnpPRsZyKVLQr1T3B0/IFLtCqP?=
 =?us-ascii?Q?6QZ9sPelvRRmz5KhFvbNpuHlqXhgs+srzsDBvbaAAkgBLqGkj3uFpZw+IPiD?=
 =?us-ascii?Q?JSsPyP9aWMH/VA0h1LZbhzX51cDru2BDh1ssiU/iM991XkI/EZCSi5R/evR3?=
 =?us-ascii?Q?YzMVdWtQxTtMn4+xseD5FFi9IWqF9cYy5Nqv1NEEd2R0tIrNalmBZGB/t6A4?=
 =?us-ascii?Q?6Ubqo4wWxMQV+T8WderKESCF1spD+UtD/Ivc/uc6S5pQQH7zgd+LMFA/7HJ7?=
 =?us-ascii?Q?DG5y8hJk9TpAN9itZUSpCSMx+hT6Sqm+JCzuXnxqzTOtXp+Jrl/KWhUNX1b4?=
 =?us-ascii?Q?hjNmTwFOpWMVRTtqlHNTsUY3WuJgZ94gZoMXegt7qcGIDSyFYTyjlDEOWERq?=
 =?us-ascii?Q?V3XnYSL/AXzrItDBDS09tFjc0emek9kk0+FEChxzwOk1yfCiHDoinDT8hROn?=
 =?us-ascii?Q?xL4Cj4rLKY0p/EfEeiWXFX/W7ASQUXU+1HKeCIsb5v2gSaKETO9rYHEWWwKR?=
 =?us-ascii?Q?NUHclSgcrQq+qqGJlar9wLroROiTo4l8f5lmEBjtd88XQ5RFCCSbTcnEREEI?=
 =?us-ascii?Q?GxyZRD0jdSprDBZzt8B+nOuISqYqykHUzqhYBD5t4/KMRrAXMOiLZUPONiVe?=
 =?us-ascii?Q?FsDPr+TPzP9uhceqOQwStQyM/ku6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 18:37:09.4058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99262414-282d-46f8-fd89-08dc70570905
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769

The pointer delcaration was missing the __free(kfree).

Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
Reported-by: Jens Axboe <axboe@kernel.dk>
Closes: https://lore.kernel.org/netdev/0674ca1b-020f-4f93-94d0-104964566e3f@kernel.dk/
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index df6121c38a1b..42da535913ed 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2884,7 +2884,6 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 
 static int virtnet_close(struct net_device *dev)
 {
-	u8 *promisc_allmulti  __free(kfree) = NULL;
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
@@ -2905,11 +2904,11 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
 		container_of(work, struct virtnet_info, rx_mode_work);
+	u8 *promisc_allmulti  __free(kfree) = NULL;
 	struct net_device *dev = vi->dev;
 	struct scatterlist sg[2];
 	struct virtio_net_ctrl_mac *mac_data;
 	struct netdev_hw_addr *ha;
-	u8 *promisc_allmulti;
 	int uc_count;
 	int mc_count;
 	void *buf;
-- 
2.45.0

