Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF847C77B7E
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 19:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BCFB417A7;
	Fri, 21 Apr 2023 19:57:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BCFB417A7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QXxbNA99
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E4Z_N-o41OUJ; Fri, 21 Apr 2023 19:57:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86BE142913;
	Fri, 21 Apr 2023 19:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86BE142913
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C87CC007A;
	Fri, 21 Apr 2023 19:57:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DBD2C008C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EEF1F405B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EEF1F405B7
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=QXxbNA99
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MTf6L9QBngV4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24A0F417D4
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::625])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24A0F417D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USYjvQjcv6v18X35jHNqwK5qPFUlOjyBCH1/J5Fw8VnkefEhNK8cXAYn8lCVqubGRKMExsGybVB0kqVIpBGQde1jYGhLS7ZjVEDqKJJxLfAJe7jlwXybobLWpRULMnlEcm5IMpOJpd2x0ZCdReB03hXoL07wMQWFGos9OdQr/l5ZAiFYBL4JNmVXset0Piv2vK3bvybodyQB0jRPZMQzsiB2Ein1bcSurq8JrQoHJH6/Bv8OhXa6pGt2JCyZvmEkG2lcFNxQHVex6In1F+jC1mfX5uhYMYhA8nihC/W0xPbjPySGNze6Zg3dPjThzGuOkawJ1EjcFsjvABPBT4u/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHRVzUTqI+I+JlTWh+xyswXOK5JKgKvz/T6878DEo60=;
 b=XY9TxIIy5njAb9qwDKklIXNFXXBR2jkaOUSDDwu5V/oGmzIYIgR5RkCqk3scNV1f7PE0dpIbKstqN4ASYr2zt+HG54OPkF9FnV/XxVHyMwiCbng9WgkzAAYQxwR0sL08l/IP0eaNJeKd06OOyIavcV6pyQt5wT05Tpq8KqdQRxW/thQvb3vqW2TZ2cNIZLVJYYFzw8vHb8vHrWWiov2PBwz1LE7gbCJH6SPtBkgw39cyiQMA3ApWbiDa8dGitSrTr8uFG0CNeQbSBDIZZ7K5464Z6oPUZQMAy8swWc07hiB4zzNOFoPNubSYDVzGr93i1R8AOap5mRfVL7VncF8EXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHRVzUTqI+I+JlTWh+xyswXOK5JKgKvz/T6878DEo60=;
 b=QXxbNA99oHc7Gz8Z57j4v9mEa8Wwdu+4c3SQ9oRVbUk65aSBhz6AD98fTMFR6QKHUpcadkJbDSoWYxHgOGMfrqchIrMfzL8vUVzeQODTDpI1I+2gLYUTnS3TrYE7l4g2tKEomFgL84FH3U2DXuzpKYTO7xOS0o5prmlNjcfGMWU=
Received: from DM6PR07CA0130.namprd07.prod.outlook.com (2603:10b6:5:330::22)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 19:56:56 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::9f) by DM6PR07CA0130.outlook.office365.com
 (2603:10b6:5:330::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.27 via Frontend
 Transport; Fri, 21 Apr 2023 19:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Fri, 21 Apr 2023 19:56:56 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 14:56:55 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH 1/3] vhost_vdpa: tell vqs about the negotiated
Date: Fri, 21 Apr 2023 12:56:39 -0700
Message-ID: <20230421195641.391-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230421195641.391-1-shannon.nelson@amd.com>
References: <20230421195641.391-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 550e2eda-c552-49c6-71ce-08db42a28f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ephv3culXcTUHsOpxexblvrEC7OVjJ4sr1SSXegGx2yAmE/ydWtzmXy1vl3hK39zH9T8ST4Bx8O00peFK5BqMF1YaD4soNGfY8jK74Q0kLqMM+qzGaPCzY6uqBDfVxdXFeF4bAIHb3ohWaFrqUr5TqSvFqezyvG6lo9r08Ca2QCHvnpq/UvCi3EYdrVQtowbslzRf3gJuhxGhB/qS1LcFV5+wkhQwoxlUATlXjPnsLRrakDco+2hjwZrvFaSP4DHlIj342xB1OBQX7HZSHm3Xm06mKAdfCbXV5DBdgXCr8khQtobQI7gilHj5jipUTZIOz+rIljhrSmyHVXMcHSRNNnw3Y7hG2+IaHBoK8UVlv6eU1lNEbLNnku4Q/IQ0250PHqvXdsc95DLRec1AkW0AQa87XohM2bTH1Jc93OjKjf5gIXLAR7BnRt81FrZzLuTVHozAc/WL05qAmLDKN43B5XEA3RKtycCgxWYXkxlUaADwAeixggBnR6Js6cCTRbfkB3j/UZZRWhHdz5K1UqQDef4cbma9U9tWgH2yupcR7uOSvD8y9oi0Iu5YZLBvnEwcsj9KY6FtnRi963msJN8ID9uSE5bnkVk5RIjWzo5NYbXgNUkBx7bPKMev0IN4rew0Mnhr7AGBU+v1Kmhmyudwifw6OiQu6PLgWgCh2ORq0TK7aI3Gjch3llT9joyOg5X/fIVoVmLS4z4kW+2vU9IRmxdsnYMCXWBFljIM3DHR6o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(40460700003)(110136005)(8676002)(5660300002)(54906003)(8936002)(86362001)(2906002)(36756003)(82310400005)(44832011)(40480700001)(70586007)(316002)(4326008)(70206006)(82740400003)(81166007)(41300700001)(47076005)(356005)(1076003)(26005)(83380400001)(2616005)(36860700001)(16526019)(186003)(336012)(426003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 19:56:56.3347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550e2eda-c552-49c6-71ce-08db42a28f95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
Cc: drivers@pensando.io
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

As is done in the net, iscsi, and vsock vhost support, let the vdpa vqs
know about the features that have been negotiated.  This allows vhost
to more safely make decisions based on the features, such as when using
PACKED vs split queues.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vhost/vdpa.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 7be9d9d8f01c..599b8cc238c7 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -385,7 +385,10 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
+	struct vhost_dev *d = &v->vdev;
+	u64 actual_features;
 	u64 features;
+	int i;
 
 	/*
 	 * It's not allowed to change the features after they have
@@ -400,6 +403,16 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 	if (vdpa_set_features(vdpa, features))
 		return -EINVAL;
 
+	/* let the vqs know what has been configured */
+	actual_features = ops->get_driver_features(vdpa);
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->acked_features = actual_features;
+		mutex_unlock(&vq->mutex);
+	}
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
