Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73814C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C78360F02
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C78360F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE0CF4032B;
	Mon, 25 Oct 2021 12:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4-5XWt6bEu0s; Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A60E40383;
	Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 343C9C0019;
	Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8851AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7802A4005C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ELSFXgV7HuTj
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E701D4026B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4SljyYrGjWNL0z+v1QI2KGJesUDE+rzVGQ9cpg2Mr/msZke//rolqcWZ3q4fuNPOM/QQYYLXA6o8UlFWvq3KfjrsueJdCZAhWaPRWBQE7DXuod1cQ4P7FpqTPqwWFGlHtHzntL30dMHycq2kY2ikLNpYy82Esi2SI6BCWIRWkBPDLFx6WAxM7bHI0YOrAV99i6nDw83KpYUC8gn/jBTSzIZkZNrgPXnswj6/3X9PGRXIJ8oeDxB5AfEZZR4VRcB88uPzLtPo4bBSBJJQaP6uYLVuud4dJaKXN8O4JQ70g5CJw2TLWiA9V7gJCCdT6q7/Yj1xHaLvjC9rZz+SWkIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt/R3RezyvOiksjt8Lm2md7AiBgobdBTwilsIs7ml0g=;
 b=UcA/syG2xuP67hKT0Y2sb8XjbUhjWGLlNdVZlfuR7hhppjTgnQLbzzlwb4mtn40b+kQ/Zt6G3RQUfqugnj0uM8Xwiry1msP2nj+wmHlqWNlCVUwKpJWHiHKuFNoEzOauA0egPDW0dd0rgqzYnOEJ8IBVXs6CMWiobpl44agGCv/L/89fHFfzeSDAOb0MxuD+kuw8GXZ4yaPd+f3bBpqqLqngvETMA4ZpAnR1a8sEhaCVHhOBQPT/sWlQHbo+07EtNazB+jY7q6oQAmRcebkCFwXd68urpRAOWPh3/fbhS/7rNvRtPwOGvJPLxj/iRFVf/tMJgp8FV+18abp0vHY6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt/R3RezyvOiksjt8Lm2md7AiBgobdBTwilsIs7ml0g=;
 b=WavLiBpmk/lviESDCSpT++rWpOtamgYYuPNoyxQIG493cqGnz8XaxVHW62sOi4JNcgLq9KkSWjRx2+H3NmB7uazxjAyW1IpS7KEK7PtKRb9o645tqFu2rsxpS124H9SDE/hoAoyMmHclAmZIAWcFpBipssQK5lo/Dklo07cDJEHIhLf6CtJDR1KFs/ETQC3w20rYbvcJq0FmlhcDiVOY9N+IVAIYo//s69+e9v/G3XY2nqZKvRsrEXoarRsCTHfogmgCGZyYN/uheURCSYPnoPEJc9t2F3VTy70hj8YtbmiMgKlmcN4/mKPOywYQfbExlxLdCx5Hs9y0IR9GgdkFkA==
Received: from MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) by BY5PR12MB5015.namprd12.prod.outlook.com
 (2603:10b6:a03:1db::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 12:53:34 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::66) by MWHPR1701CA0008.outlook.office365.com
 (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Mon, 25 Oct 2021 12:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 12:53:33 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 25 Oct 2021 12:53:31 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v5 3/8] vdpa: Use kernel coding style for structure
 comments
Date: Mon, 25 Oct 2021 15:53:11 +0300
Message-ID: <20211025125316.67664-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211025125316.67664-1-parav@nvidia.com>
References: <20211025125316.67664-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da7ac546-8982-4c9a-0df3-08d997b67449
X-MS-TrafficTypeDiagnostic: BY5PR12MB5015:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5015D5CC05A13335A280D9E1DC839@BY5PR12MB5015.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v15SAOWWfdR+ycMJR2f67puXJo0hgjDmqfdCen6ynUqBRE03rd9kYufr3kUVVhvXTW2iwdvjntdxg/KjO83cHitw1LxnVPnyJfbCaJ4fvxqYUQIlMrx0XvgBuhtmHGLUFGvzTDPeFfOc5pCzM8nVDEigvajkn9+LKr+U3QVYitOKi0GI5MJOquiIlCXbMSO6soaAddk5xtV/cUuuWynEmCO9WyqwnNCr5KqLP28ZOpdBI5H2TvDUQDdhE9PO+16tAa3OhLXp36zqqSecO2QiH/89iJmg+hhtY4JzbMegSmnWiPwNuky0pm2i/Cq3z+iiP4bktbF3LrNlQADEdDv6Tl1/ixiTVs5OIi0cTsx4SZwIQzkxsl78EDGlN1MZFKLWxPc/sllSZ25TtntGa5XMk52mz/7vMCOqEblaV25YfrOzZfj5CKkND/yquCYb8vxkbkL9V/1wq5g2OuwxmHz42XOusti1nwwpj5SB0V0g9y39FZm7A5HEeowFv2l73OP/loh2YDZ9EoFDaiT0dkHIsdQwDehkMWkTpcx970JrWlbO0Ygsokhwe9+OCdMmopHpgGso942GdAjhRADFxtF4nScD6qenmAK9ytbitjH9q5ihhWHcXq1q0aVAWX7X4SG68ObYZ8AYmAF8okLbxny8Yazt6oaTqo9GDfkhyQVJyvn1RCDBae6ApoT+uewB1NaxdWwEsBJtEnU9ncPsXLHwGA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(107886003)(2616005)(426003)(336012)(6666004)(2906002)(316002)(54906003)(186003)(5660300002)(1076003)(356005)(86362001)(6916009)(47076005)(508600001)(36756003)(36860700001)(16526019)(8676002)(70206006)(7636003)(4326008)(70586007)(83380400001)(26005)(82310400003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:53:33.9063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da7ac546-8982-4c9a-0df3-08d997b67449
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
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
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 5cc5e501397f..fafb7202482c 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -411,10 +411,17 @@ struct vdpa_mgmtdev_ops {
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
