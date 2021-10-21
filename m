Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9329C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9434A61501
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9434A61501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 707614087D;
	Thu, 21 Oct 2021 16:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6eB0N8zVlSZY; Thu, 21 Oct 2021 16:35:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EAF1740868;
	Thu, 21 Oct 2021 16:35:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 870A9C0038;
	Thu, 21 Oct 2021 16:35:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1868FC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05C1D4085D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7TmG2EQp2AWc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2043.outbound.protection.outlook.com [40.107.101.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A12F40854
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8P0vVD0QMdZJY4ji32Nt5X0JLB2Q3RaKm2KMhHCJvLe9ATEESWMwQs8Z6PCKm7AT5Vrv7wQXj7z712i4+QjlwRmJJLJ5LSkg6a1mAP+TpINZ3tniasUwfOdjQOO5AGk5TFkp1x9ntwZJ7OrUDW6dYWbAuuI3yUb8azajq0jjLEmqqD5wqaxfI+ZlydRVm+OUQ9aFgWW/JZqtQnJiykIbB/+waYCV/oXCcu8Kbe1kkQ0x7JbS7/8heNH9unZpk6AtP9JmCF6ap87bK1aFF/v9nODHGWsvJXaSn29x6Oh60TopBi6Z8LWtkTAmr367En3yd64DwzSorIxCIAtDX0fQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvVU70MEsIJTRB+tt7XTLubPOvvYUCtUc/YKIFJ/v4A=;
 b=h5wYAq3gKsXCdFk6WPHxxrLLlXdBV+KGa8qNxTFFYVrbY44MjG/YXP7EfD3W4LSOIGO/rl7me6+6YcdQmxfkY9zNLN9N7IjH4rB+MQ2sSCS/Renrnkca9/H9dWGh9kp/6jdE7TmOL5n0FD/kBcfzqmRV+JKRwv1muNMn+u5xUm4sKQQSJRAnRrE7wq2B8z+5DctJcl1gnUHp5XNgjldOGcTA/daZLP9iNmJ927DXeyZB8r1JrIwJrNqp3AKcRyglXGNYdgWwQO8NbozW3aaU5k0Y0G5AjZQAIlsgeAter7P/HnsWqE5PhtuEd7YRMvO7Cx1RQmb/PY+uDyvIrUuuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvVU70MEsIJTRB+tt7XTLubPOvvYUCtUc/YKIFJ/v4A=;
 b=maJsUCO6DZzHhVnb4vVX5FelHlAKscwDz2KMH9VJPmAmdaRMHEVwbaMBP0UYtnT+7sho2n6zupYo6d5i/m9yzq7/U1NMrdJSJnxRv3QoospJEj3Nl556s/ewSJT+uWUR8k5xXXRJVDiYW6hbRpnUN667CgggLo9JVCARY2FEuesR4T1Vl4ZraXIbrL/b+H1nPO9h7Tt4AH7wqfYLnjnRlsvQ7mN02xJchWFD2Vc061qnkazKQ/abMMAviPrjHHQ0PVaZphD02rzBDTkWaSAevRHMEZhHV+kvMA/lXMDIXCktqpDOteppBvUH05zjeYACbENJywJ4P+3rwWppjoudtQ==
Received: from CO2PR06CA0055.namprd06.prod.outlook.com (2603:10b6:104:3::13)
 by BY5PR12MB3828.namprd12.prod.outlook.com (2603:10b6:a03:1a4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 16:35:31 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::16) by CO2PR06CA0055.outlook.office365.com
 (2603:10b6:104:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 16:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:35:31 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 21 Oct 2021 16:35:23 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v4 3/8] vdpa: Use kernel coding style for structure
 comments
Date: Thu, 21 Oct 2021 19:35:04 +0300
Message-ID: <20211021163509.6978-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211021163509.6978-1-parav@nvidia.com>
References: <20211021163509.6978-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3aeeed6-4af5-4f4a-0240-08d994b0cc95
X-MS-TrafficTypeDiagnostic: BY5PR12MB3828:
X-Microsoft-Antispam-PRVS: <BY5PR12MB38286B3E377B9BC5429B576ADCBF9@BY5PR12MB3828.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fq1NmHFeTYpnoAh6APD6ZvkfVO4sZL+N9u9RE2FLqKek+ABPcroVcetn4A/isrKoVOvb/pN3PrBwikrOnIMk7dNxeuCY7H/RLCYaMxulVmWae5c6snxZe3RqYiVHlf0EC4gEIUcpglLBrWx1p+689U6ARZt5tJVH05onupkGwZM0UsKHxSG53/tjRyeO9kev9a03fAhSQm0aaqW0VfNu3+A3ZbnSia4Nk4iLERfKp9W6Jm0sgJy88T/Uih2+oaZalmRZv+IJ3cg6HG81wy2sw+ZMmX3zNUSq4J3iNRtPqPv4hI1YAFdIP7N5eckU84XsReye9Sm9XXeUmS5hzMlx2NA6HBzSc5QnWVwTKe9U8CI3GekDWpGy2EYJNp40nf3SFDcxXEjRpG7rHRLONuHZGIj0IaoKWh6VOkI6QzwJydfhdyA7QARZPSg4K3ThTMAcoGAF6FCP96IW7PgnHkY2MT+nouLLLKQfAmGl6/1l4KKpGyTavQ276qKA756a+TDsEUdRxbUMPzxMoJtj8KHbdST8JMke8zowMyNhBdKLfgbde9BqaDBGiB9Y6Zom6Hl4rrXM+1He5HesJTn+T4P6A5z5qTcBDn6wz3ck6BNf0hQn3otm9FJBm1iMoe8CRe2uLKpj0qXnwe4+qk8Qd99z2Iqkzyy/wYruxKPoSocR2jENOe0NbpBS0BOYKC4nR/H3FijrbH+7PGvV+l3wgiqdXA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(82310400003)(2906002)(426003)(508600001)(336012)(356005)(7636003)(47076005)(86362001)(4326008)(83380400001)(107886003)(70206006)(70586007)(16526019)(54906003)(36756003)(8676002)(6916009)(5660300002)(36860700001)(316002)(26005)(2616005)(1076003)(8936002)(186003)(36906005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:35:31.1801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3aeeed6-4af5-4f4a-0240-08d994b0cc95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3828
Cc: elic@nvidia.com, mst@redhat.com
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

As subsequent patch adds new structure field with comment, move the
structure comment to follow kernel coding style.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 include/linux/vdpa.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 9326020a2c55..111153c9ee71 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -407,10 +407,17 @@ struct vdpa_mgmtdev_ops {
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
 };
 
+/**
+ * struct vdpa_mgmt_dev - vdpa management device
+ * @device: Management parent device
+ * @ops: operations supported by management device
+ * @id_table: Pointer to device id table of supported ids
+ * @list: list entry
+ */
 struct vdpa_mgmt_dev {
 	struct device *device;
 	const struct vdpa_mgmtdev_ops *ops;
-	const struct virtio_device_id *id_table; /* supported ids */
+	const struct virtio_device_id *id_table;
 	struct list_head list;
 };
 
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
