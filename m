Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0D5C77B61
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 22:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC32641C87;
	Mon, 24 Apr 2023 22:50:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC32641C87
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2emaDi4V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2AtpLfXlm3T; Mon, 24 Apr 2023 22:50:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54E6B40291;
	Mon, 24 Apr 2023 22:50:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54E6B40291
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC11C0037;
	Mon, 24 Apr 2023 22:50:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9895C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A976F4151C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A976F4151C
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2emaDi4V
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R8chiQZicdbI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88F45413D3
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88F45413D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdBy2tc4EDaZ47+TcZBez5OgCKrX3UhCmy1yXjolOok28GcDCOQeegQ0QlCcr46UaUHa+kwMva8E1zRqqxK2tF4NDy1w+wj2qKv0W0JIZdwB6bDnShJLK3D4SO3rv+9YtDDychptNO/EPJNaKaUiE01hzFPM2G2ZUOXO2LKIYRPve4kCtn2aTvZbLexLORAXCMLfJEiTWycCO9gnxw8J2rDPDVqIUpTOYQXew5j9iU6KrE2TOkyk6Ib5x5bBRe++JUp/AVi8ktLJslbxGPNMaL4JgnnTXcpe7Znf1b8LzzEbSo6oDyVJNi1+oog3T98LvYysM9ioqX1IfvNEeuGVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVQ2Od0SIIYbTnLPChnAhpi3CS6GtqLz+O3CI0GI5RI=;
 b=A06dC60SrpI8KcQKA1ksnx0w3K+MzVpO9pRx7a4wLGT6uw1H3ADzaKf/Guj8fdNZzouejJieAgjc8c+VF3ofTM+BtsGPUDheZqJX/KXx8oURguG0NBopHoXxlqWezaTSIyrx76boNdTZSHmgsXpMJDHI8TU/24/QZHKG3cswVKt35P+YrnDjPv9Ddq0fw8jyKywfYn7oDq0plc0g3NfeXk9YwKfOPcEG2EzWaLPeZ3iKxs0wG6SB5nXbGrAVvG+yNqAtK9B04ya7pKnlczkPlYX9/3488iBsn1daOK83nt2f2G5DW69QMQtEzo2Wh0859Y/YE1huE9XUHt3gni8Xfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVQ2Od0SIIYbTnLPChnAhpi3CS6GtqLz+O3CI0GI5RI=;
 b=2emaDi4VqQS8IzYeXiuBl3zELKJDMYSd1Tfmr0ey93Hr2Y7vEKLK0PV4qU1oFwO5KIqXTGowNpVkd5hYDIUI+QZaClnTp4MdT2aSW5rWwpJafhGOtlJTHKtB8urtwc6/cbD4agh6Gt7Re+hKM16mABeh7hgob3hf4vgKO4YS4i0=
Received: from MW4PR02CA0012.namprd02.prod.outlook.com (2603:10b6:303:16d::35)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Mon, 24 Apr
 2023 22:50:46 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::67) by MW4PR02CA0012.outlook.office365.com
 (2603:10b6:303:16d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 22:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Mon, 24 Apr 2023 22:50:46 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 17:50:45 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 1/3] vhost_vdpa: tell vqs about the negotiated
Date: Mon, 24 Apr 2023 15:50:29 -0700
Message-ID: <20230424225031.18947-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424225031.18947-1-shannon.nelson@amd.com>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea80076-9f17-47aa-5087-08db45165781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpEpYhzq+Gx90/GvY6/HEwMrfH33d9CZ4qmu2bcVJor4Ny4G0L9mdWqpdBZErt4xy18v/M4ohRnSvWWg6kxFOe5VHvkEEWCvPJ4HBNxMREnShL//JjCo/My/v777PrXvG5kbsMZ5x5C7j8Dj2mzI6rPZ6VS3QSy/CcDPYye1OoG4IqPxNc3eTYN9uoKjWr6VCbe5hkF2PVMrsF5AQmQ6d1mEZr2MpK0Kv2qV+BNAnF4izUQSIMenYSBmuq75ll0TGR7shME0hoyxDdQalkdewW4fn3FPkOWrPDFVL6bkVnYnYTiH6vBlO3JD7URsl3KJv+Qh7Kf4XSVCx1pCfE/sWRbAVWFO+VOj6ES0ZQOkApPbCrAWR1Mbgo0dr64oYEWWJ5cFy3pPETclI23dGwocsnvIRHmw9WdeiruLRXko1DeC+mC6HuhcjXKRfez9K3kS3VoZdZy2mQ59Nd4/33DGB0dputxLWBsPD3PRkXQVQxuclV0nr4XyIbLn8GGyf+mav6tzfV2ZbkqTKu9y3GXJuLvPaq7+Qz2tywEDBTqUMFJvrg4I7TPe3OKudroII8wOu1C36onoYQ1uTeDyeAzOmvyT+oNrjmYkQhOnp37HVt3bf/JNl6+UZp3Hp+MfQxGzdKq/mkyC7uv2DAI0OHRXUtGTK8syPJ6KnukuY+yTD77KBXlVozGU+Q+cd0g7U9K6M5KaQyHs93O4ZhkmuOedUMfoHxdlVkBAKjREJ0tsPNA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(8676002)(41300700001)(8936002)(83380400001)(47076005)(40480700001)(2906002)(44832011)(5660300002)(356005)(86362001)(54906003)(82310400005)(16526019)(478600001)(36756003)(110136005)(26005)(2616005)(1076003)(81166007)(426003)(186003)(6666004)(336012)(40460700003)(82740400003)(316002)(4326008)(70206006)(70586007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:50:46.1340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea80076-9f17-47aa-5087-08db45165781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
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
Acked-by: Jason Wang <jasowang@redhat.com>
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
