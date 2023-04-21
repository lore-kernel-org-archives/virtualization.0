Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A406C77B76
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 19:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE44A70023;
	Fri, 21 Apr 2023 19:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE44A70023
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0xNzCH+l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SUdS3W9pSdKd; Fri, 21 Apr 2023 19:57:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 36D8D60B00;
	Fri, 21 Apr 2023 19:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36D8D60B00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DD7CC007A;
	Fri, 21 Apr 2023 19:57:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92169C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1973B41746
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1973B41746
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0xNzCH+l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ppzhIGlbXZ6X
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B500405B7
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::613])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B500405B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koHzzU30vBYJmXo49NvuKCf6FNxrdZxothx723dPsjGDHzkKf2bPPsZuXf2ORC6rnXE4uBZQ7dNdYdqmPHEsfQpjGmSuzpx3QZSYAeEDuWjrONsh0bm3c8qzflNbUqIkEQ8lOMv47kQgW3Fx/gOZQWQyHMChvQg+u5+E0Bx6E4zJYNmmmkp6/ItMCmWGMhteriGuEEWTwwqKivtXG1tNvYjfwu3oZSA7KDYgZW+3/w5Ue5JN4UepB0N+jUekVJd3qX+8MVQPPzYedRB/QzBx6uOx3zgN6sqPGblF7dPRdkjsBhHjt84OotJ9qehEmdwWGlhpeXGnuJ4MPPYlpMpfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nciF+6hKTFQDn4d2x6/S390efJ/1KvWzPt08zcXvlyM=;
 b=jDnyC0xowkBC6uNAXIcmayNj3h6rjwKbIid3yh09YrDq2Xdk6pEMLoEmK/lbBRlP6/WGkcVyG498uayshk4GJIdZOR+mI4x7NwTbiEkaaxUqvuhD9DUqn8JeTyoTR5UjTxROksenDIRwhnBGLQOrsKsbN2qugWvN0lvszZT7kzOfcZtcavEUGDbE8mHnw+n3DYMUl4rFr2X9CRhVqYHLcCu0tck/3CYfGI4WxHA9mYuwEpNvT6ye4gpazLT05GogBEdOHFmpMlgwq2ZZ2ZF6kCxqf6t1zp8K2Y0Ex9LZUb//KBEb8FkpKPKETaDzxm3ruiXgpJThqntjmOvI7pYqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nciF+6hKTFQDn4d2x6/S390efJ/1KvWzPt08zcXvlyM=;
 b=0xNzCH+l0VE0E4flvDBrjF8jItJ+oIUdHOqBhfzfXz5n3c9dgCdStnld/pR5KIsnc5HyPfsuF8bybJrFloA19vYLhfvfNSSVFkbLi5g/2l9dnyqPVzi3FMVcP+OnpRV858yF6Gt10VMXXGQyQSdNtTZUkj9u9zh7HqmqH/8+Hpw=
Received: from DM6PR07CA0118.namprd07.prod.outlook.com (2603:10b6:5:330::31)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 19:56:57 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::a5) by DM6PR07CA0118.outlook.office365.com
 (2603:10b6:5:330::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Fri, 21 Apr 2023 19:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Fri, 21 Apr 2023 19:56:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 14:56:56 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH 2/3] vhost: support PACKED when setting-getting vring_base
Date: Fri, 21 Apr 2023 12:56:40 -0700
Message-ID: <20230421195641.391-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230421195641.391-1-shannon.nelson@amd.com>
References: <20230421195641.391-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 925f0835-0b89-4820-7e67-08db42a29005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1uRICcTwl9N4q3bLG9I8iikwfmdf3NEv2gAupoOUtN5oIN1rTMnFbMaFpR+WJCKDp3ktyOjas9Csauq8DUsGVGq8bn7tfj2bayFlg2xAbkApUlptJT8dYHDirUzgTozm2w0BmVErwWdLIWKPap6uB+VciA9XJeYDCy8VuNphAF6urbu7I/96ZCOPlD2jfGPzJaXXQfsr78lbJdmyE8e838JL5NNovnJ5bT7Ubgub5vknKsxG1RM0+J3X8h+kraBpLKLQ97jZO29ZFfxdV3UoEy++9gFzkLK7JcKXHTtSyffhdc63JpNxhVtwU58ntgmF7jK4DBGmFM7QS/oB9Y4f2V5sWXa1omKUJHVRhNweUgzNNeJjPruT/pe7ave08Fezbh3syXh4iGVbW37dgXYnJYjyAUa202uoLEj1wOiP82NTQcJ17+FnY1+T2C4gXOX0ofsrQ4wVGVqSZUYviq0awcir4qK5xRUSHDx6jPFwSUrZgovA2d8zYNbtLZVf3YTWZT6/4/K5dXwZCaDAYQ1FdsgeS9v1cPVPbpjrdbGaiHBPJyHatQ5uMv7R8T6DyncbBoREGyv5KONinNZlhgxuQmsnJWDn5IY2Bxj+ToHRhwrGC7Ku9H83d653C9aWM81PfU91/toVbv6l6Ry0O2BKIXhZMk+S67TybaG8QNGXY2kwSHksgUWGUqqIYvCyAA4eq7B+BU4yerZRsFChoHsiHiErxwBpOiwYL+eOvMWIBg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(47076005)(356005)(16526019)(40480700001)(6666004)(54906003)(36756003)(8676002)(8936002)(81166007)(26005)(1076003)(82740400003)(41300700001)(2906002)(186003)(36860700001)(5660300002)(336012)(44832011)(426003)(83380400001)(2616005)(316002)(4326008)(70206006)(70586007)(40460700003)(478600001)(82310400005)(110136005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 19:56:57.0690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925f0835-0b89-4820-7e67-08db42a29005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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
 1 file changed, 13 insertions(+), 5 deletions(-)

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
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
