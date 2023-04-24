Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A9CC77B76
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 22:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD51E403FF;
	Mon, 24 Apr 2023 22:50:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD51E403FF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lA4s6MCH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fn4fxjH3DxkP; Mon, 24 Apr 2023 22:50:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4425141C7C;
	Mon, 24 Apr 2023 22:50:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4425141C7C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A99EC008C;
	Mon, 24 Apr 2023 22:50:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDA80C007A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6D6940528
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6D6940528
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uJbJvGZ0Iff1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D20E140291
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D20E140291
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI/dGwG9q5q0gl79ZhrWfXD5vRI/eTlf8rhFvy5HuAif3hgzL9kNUL9jfxCJtp+wugyPmFJSw16z3BeJXzn8YpGLmC3nOGdqU7TwYBJCaLfDvOQZRm8CZH4SXMB+rJhpTWESRhp6cOgGr5yXMjaXGAz+SzIKo9ElU2dMvCK/9BSVY1MIZrDKSF29DTQpAGtawXAE1vy8Koh4Fqbn2QrPfbUV1Pgezw+8p7ejb9hndSmg3VIPOT3+Hu0U0Ydg5iVRnWdfR6yHNrBRDXGofPtCTVnT8euiXRgFbx7nMt/JUNY/w47sfKvdGW6XPSvhFgzrkPpN6owIoFf7kRisqJ/8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpAe5qEEnO1+zomK6GyaDVrCo+6ovCdednoXfDhPBCw=;
 b=CExd6YTprYjl+CdypwywfG3HnE0n4mqz1Vg3uwJmkwLX2kTboi2IfRijr0ybU7brsn0apXyA+OPmS3PMjz8FEiZIp3DRHmVAL9A5tbKrObCl41BgO4x2ar2rUxc8PMvjKvlj0c54GorWVawdfljyPFHJyJaqlZybnJQzYPBjbbB/4PvQX/yVow5gusy5S9RMaOVBhSSx248F+oElE++ay6x4AzJBYGCHCIA/GykG08tf38KNaDeS3BFmgCQXj7XCONBGu67sHKt+Frc4OJXky1YYrQbHXnXrZaS13Mk5WFqL5Co8OL/RVteSD5drFC/Z9Z2eQ11R4LR3xp464aOORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpAe5qEEnO1+zomK6GyaDVrCo+6ovCdednoXfDhPBCw=;
 b=lA4s6MCHJTnVefYaep534ritDYaZA71oZ54ogGtH6at3gIHAWBGpS+cg2CJrB4YQzrnLIeFmAo1mFAo7X2+3OQn2vLwKlQwO0nTKSSx04PX7ngKr2ELWqLjrqghmG8mI6Ig8bgxkyqan1nSefUxAomlK3DPqXYL2gN96CvsvkDg=
Received: from MW4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:303:16d::15)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 22:50:47 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::db) by MW4PR02CA0022.outlook.office365.com
 (2603:10b6:303:16d::15) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v2 2/3] vhost: support PACKED when setting-getting vring_base
Date: Mon, 24 Apr 2023 15:50:30 -0700
Message-ID: <20230424225031.18947-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424225031.18947-1-shannon.nelson@amd.com>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: a6707b61-0aad-4c2b-3699-08db451657ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1DoskHzFVvwj/EDT/wgtUtOb0OY+llEQ5bwP/7yqtSuYLa6ea+YZVQU/2zeH6udE4pE6ZvQE4Hz2NYlDr2FC4zsysQKt+8X99PrIt+VWPR8ZvqgzrR+40XWu5GPCmQi/eMwf9wYJVN5+AB2T5qoV9pUjuGmelmCyEJg4cD4trdFtyc+W1CIsne/8Z2wW3dbRBpiKkgQap787RQfIbLcZDH2esSDUTlNdceBAT3kvY62LCMkOpL/Jnp0Vhb6il8VTVRxC9MK6qQAYRVpgZRW2qAZ16rf8K40G6bq/aJoQDgTcJTjXsrD8GbEdSkXwGXvfEw6haJqyHyIwJJluwlEFy109eQwa/3hm9i4eI8rQc5FsJyyoTBXTcq9080Oe5einoNjdN5JHAagDDq2iK8OSpEIcV2drPHT2kW0ZUeQUmOySarSai50Cba4adyFKqkpJZhUzqugXd1QdhGSKF63O+A6klKthqZFQulXOk05waTQOiyCxQvW7EJYT5GBZ2uiULdqvIYBAl0/+l1tfpQd8RJyqYGwf/sdhytmOGef4aYNScWAxPgtfbtmhi0FrnoMWDhHRahxHtFOi5/+g5V5tJPqvx20Sd3VwkCaoIYO9l2a/C7YzFw3TEvCQVnXILug2bFvUOEz4SNmeNz/lNk7/dpb8wY+EoY5mwn2Ywt1bnOhzGZX4zqb7YLClSTRAeMHUwMlkB4ktNCEy0ULhOjTCFu4a0RoH4/eUEMJPOcahOE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(70206006)(70586007)(316002)(4326008)(44832011)(8676002)(5660300002)(8936002)(41300700001)(82310400005)(36756003)(86362001)(40460700003)(40480700001)(356005)(186003)(16526019)(26005)(1076003)(81166007)(478600001)(6666004)(36860700001)(83380400001)(2616005)(47076005)(336012)(426003)(110136005)(54906003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:50:46.8215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6707b61-0aad-4c2b-3699-08db451657ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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

Use the right structs for PACKED or split vqs when setting and
getting the vring base.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vhost/vhost.c | 18 +++++++++++++-----
 drivers/vhost/vhost.h |  8 ++++++--
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f11bdbe4c2c5..f64efda48f21 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1633,17 +1633,25 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EFAULT;
 			break;
 		}
-		if (s.num > 0xffff) {
-			r = -EINVAL;
-			break;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq->last_avail_idx = s.num & 0xffff;
+			vq->last_used_idx = (s.num >> 16) & 0xffff;
+		} else {
+			if (s.num > 0xffff) {
+				r = -EINVAL;
+				break;
+			}
+			vq->last_avail_idx = s.num;
 		}
-		vq->last_avail_idx = s.num;
 		/* Forget the cached index value. */
 		vq->avail_idx = vq->last_avail_idx;
 		break;
 	case VHOST_GET_VRING_BASE:
 		s.index = idx;
-		s.num = vq->last_avail_idx;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+			s.num = (u32)vq->last_avail_idx | ((u32)vq->last_used_idx << 16);
+		else
+			s.num = vq->last_avail_idx;
 		if (copy_to_user(argp, &s, sizeof s))
 			r = -EFAULT;
 		break;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 1647b750169c..6f73f29d5979 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -85,13 +85,17 @@ struct vhost_virtqueue {
 	/* The routine to call when the Guest pings us, or timeout. */
 	vhost_work_fn_t handle_kick;
 
-	/* Last available index we saw. */
+	/* Last available index we saw.
+	 * Values are limited to 0x7fff, and the high bit is used as
+	 * a wrap counter when using VIRTIO_F_RING_PACKED. */
 	u16 last_avail_idx;
 
 	/* Caches available index value from user. */
 	u16 avail_idx;
 
-	/* Last index we used. */
+	/* Last index we used.
+	 * Values are limited to 0x7fff, and the high bit is used as
+	 * a wrap counter when using VIRTIO_F_RING_PACKED. */
 	u16 last_used_idx;
 
 	/* Used flags */
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
