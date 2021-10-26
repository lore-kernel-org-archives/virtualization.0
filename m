Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A4CC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B450F6108D
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B450F6108D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77316403ED;
	Tue, 26 Oct 2021 17:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pvkzZEcJg-Cs; Tue, 26 Oct 2021 17:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EAA7C402E1;
	Tue, 26 Oct 2021 17:56:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C579DC0019;
	Tue, 26 Oct 2021 17:56:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B43C4C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 978E680F3B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-ZEe0NXt7M9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::621])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB58280F07
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAx7mQED100vNvOZuFG2XK/RXsSy40r8toMXinnZ8WacsnIlD7udBiXEOvIkpcDjZ5mhHDosEsnjqNqJR/JCUSJyJF6uLqPog4mNZtSwiabME5fGns9E98Y2Svb6sXOtZ5AvFlRifjA8A/M1HoxxWU1wMZPixFT+tHPBlG/V1FN7jSLkBIcd6IZs6QIruTgmmOORKdpiHyL/vie/BELaztZZnHNSEiI0ZJjEft26823Mj8wAj9vkGu9u3aomPVD3Z0xT7gPv+kdgpPQqKzkJMowV+saMuJ+hf8OceDBUCZUfrnUICenF8O5p5TTzxRG+yeNdiSfnlk5dAN170pBOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KbaM+0icV6tkfOZ4SkRZ5QA6igr2tSElq76QAxi2Ew=;
 b=I2DKiH5NmKNwVxkr8ma0sxl9NIuSvWlFt2Ont0ZLMT5skv3nEJIbyqjM8JzsQCaUVqHkkc1jF+6Pon5NdRqDGY2I8Psu9nNlEC7IfCruQisiUBNPMUrkbFgrGjvoMFbMJdCFOQIpH9rT85bJusVYTbmQI5j/hB6S9+Ay8y8qXStWwUORgqg6rK9lRVHowzhvQD2OAoyOYiiRjpMVhk2J6t8fwTq3iii5Psn+7Wt+a0FUcF23H/tniH+qZRyzwr/BSa9pbq855pH+mXOnqySmvChI6H4bgr8seBcZ5TzKWBtCWN1GsRGc3Y7yt5UrL9fWKMylhdp0ROWwJ7jsVtX9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KbaM+0icV6tkfOZ4SkRZ5QA6igr2tSElq76QAxi2Ew=;
 b=q+4bgiFWMk4EMri/ZJ39/xJK33SDCgv1h28/XZudsjbH4+FCcuGN9CFkb1SMSsOKAe0b5cVdJVpR7mHjSKernCzhtAaz1ixAjkv/nyPdl/bznftVuqDE9NyVQ0Fc4/R9q/niiZM5c0quIJ0k7LSH0VLE+wND6wUHcaJkIcvW8vBVvVubQ+uFhS3v1oh9pToFPfLpy/ghG/2NqKUOsVUncVaKbMcP4wmoixR1G4+1JFJEftPyNCZoOclCwUn727nIpv4w9Q3MM6HTblfsWpe/hpB2HBAgd37oVn/1ztjxHbdWY2SqlaKTtbz+U0wSXgCYAbh3+C0Rd+hfuu6mM+1xww==
Received: from MW4PR03CA0348.namprd03.prod.outlook.com (2603:10b6:303:dc::23)
 by CY4PR12MB1573.namprd12.prod.outlook.com (2603:10b6:910:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 26 Oct
 2021 17:55:56 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::f) by MW4PR03CA0348.outlook.office365.com
 (2603:10b6:303:dc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 17:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 17:55:55 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 17:55:47 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v7 3/8] vdpa: Use kernel coding style for structure
 comments
Date: Tue, 26 Oct 2021 20:55:14 +0300
Message-ID: <20211026175519.87795-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026175519.87795-1-parav@nvidia.com>
References: <20211026175519.87795-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22c27389-f451-4b52-205b-08d998a9dc78
X-MS-TrafficTypeDiagnostic: CY4PR12MB1573:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1573631664D83C91E559F319DC849@CY4PR12MB1573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSkgE82nNAvWD5cmR52Vmr2dhPAoZKpm4NarqNKhhQzc5WpVkaXnEf2gTjdJPjZzn7qcBbJqO7UQGU4dxKtBPudoxCWf8eA7e7D19is6i+Yk70aur18Fe6HEDm3zSp/yG0ZFq1x4ac5dMLXjUVrnAo3T5a0Bcq05BqlYLDl0vvdqf5NAbpe/iIQiFtJB5M45qfzK4NrDdMTAEPXYU+AmV8uzzGj1Y3rPNRoLXZ8Oo5SUjYBy5pVde3C73C+XsVoxduvUhCTj2SzFcEjQ73LVGYDZF6cJJM2FYcKvgr2FMQWHtoZoqy4CuCEepkflvI6xnowvO00Y5/FeJ1C9W2ll3X5OP3JqVfRe9rq6HwiUlpbb6a+2XHuA/vZuQBhc2qJ9ftiy8+aeLktt7fQVxUYLGn+j9fImzObRhjpBdyKgqqm81Z0wZ0DlogAI/JMBowdN1qSX/+d0FNJvvh0zzIEyX+yAYQFLMyRh1UNahtFuZL2qEKtlUPSRNa6fzjgcpBeKwLfr0wHq9IyKKaiK4IcomKrZBg0biY7b61JZLQKCQBBvCoMNPITIwJ7J6HcNLCyJpsQYQgnW6Ki1MweZM9UPMt737e1ozwjpxOKYzV0ZylxC4HVYUWQvXnuC4tZbn1kMONCgDULWpsv6BLvpOn3wdh3njjLxoCQOZkEX3S6Vj9DHLEUjq24eLEh+8pXDPV1Xep8jkHZdBXd6uxmRgZjQeQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(26005)(8676002)(47076005)(70586007)(1076003)(82310400003)(70206006)(6666004)(54906003)(356005)(36756003)(508600001)(6916009)(36860700001)(2616005)(186003)(316002)(4326008)(5660300002)(2906002)(16526019)(336012)(7636003)(86362001)(8936002)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:55:55.9274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c27389-f451-4b52-205b-08d998a9dc78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1573
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
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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
