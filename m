Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CEEC0015E
	for <virtualization@archiver.kernel.org>; Fri, 30 Jun 2023 00:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EE8341E9E;
	Fri, 30 Jun 2023 00:36:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EE8341E9E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3WV0ZJoW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CVNMncf8_Fxd; Fri, 30 Jun 2023 00:36:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5091D41E40;
	Fri, 30 Jun 2023 00:36:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5091D41E40
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C189C0072;
	Fri, 30 Jun 2023 00:36:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 112B3C0037
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 00:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEA154060E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 00:36:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEA154060E
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3WV0ZJoW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kILn1dJVEYRD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 00:36:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA6A2405ED
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA6A2405ED
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 00:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOKwovmS0+xD6x8XhSZPE8ZfDbY1xYI/lIU05Sx7aQG95lPSq4nS0DOb2yf7mxkGzD7AT0VohV0cMzbZPVWcfvJJK5XsT1TLZha2VMEUuqEOOEsDIycOxWhsswGNVkMmeANVOg3Yr0DBpi9+zXC3imGjg5NLErRlH88f8629h2+rvpWMQyBbGejyMvME5OAUGO6ufDgqPTHmpaGCR1w6QymhHjOPIYrZ5hOaynhzUeZD31mSJxHnyPBBxPqzhqt9WPvfv4y0/MJ9DBlGWYu1jJUPGxI1u8GxROnLO0f4BSlRJ1rAyUhYvLF9KzT/NeK1tHcp679cerm98hSU8aj2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1T/q9YLCa0OJtcBUtJudBMIdx/2qVqHul7jew9IK3I=;
 b=DpnlzO6Tw+M4Qpj4QbdaXFVEWRQRixnMrmQR1/m15bz0fKA3qNrRIbfAFyk50Sus7Cl8bn7lk85GDt4aTPNVKwrguE3pqtyHtnSjvMHX1BYybl+fbYPjdGK+d4cCR81lOVDqKfgIoQb5EhzUplAj+yMju/eBDIK6WU1C8Ug4sEqPriPERlTLgpfpII91yYcSBL752M1zY2p5ZMPo+XwZ3tfwRliNgtF4gekG1UypbEbeVD2UBa9Du94gq6bq4ia3eW999Zbn8yjEgbJ2ZUAsWBZfR8x2fDUPgOJkQJI8Ka/OELnr0j6OXAlw2YJ8UltJk35fggDxYiHFpTHxhrolSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1T/q9YLCa0OJtcBUtJudBMIdx/2qVqHul7jew9IK3I=;
 b=3WV0ZJoW/Co5pkKKPYY2Xo/J3y2gocHtTzYD0+LvCGUglpCfevSQZbcffPxBuKMMJEdq5vNegfDLLuoQZG5xgVn5jJazBCPERZyIDrZtLLAaO6EEry7Q+6TKb40JJgqdEciChJ1d5Xu9u8i8J92rC0XsN14SHUA3WJAUCq6IiTQ=
Received: from MW4PR03CA0265.namprd03.prod.outlook.com (2603:10b6:303:b4::30)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 00:36:42 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::86) by MW4PR03CA0265.outlook.office365.com
 (2603:10b6:303:b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 00:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.33 via Frontend Transport; Fri, 30 Jun 2023 00:36:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 19:36:40 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH virtio 3/4] pds_vdpa: clean and reset vqs entries
Date: Thu, 29 Jun 2023 17:36:08 -0700
Message-ID: <20230630003609.28527-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230630003609.28527-1-shannon.nelson@amd.com>
References: <20230630003609.28527-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c10d7ba-11ea-4fe9-746f-08db79021399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7GluMEOWoLhkYda+vh+TuUkKY8huYALYOyIdXt7U6hSUlNtnsF+RUL3tzM//1Rm+I9ZfHrjT6+nWVRIaJ2fa3vTSNaFs/s6630JKfEgTa9WXwiKwPBtG810fioRhviNuqF5WLXgnPgwbO253o1dBRba9s0yuJNZej5RkVwKc+nEWQp9umU3x56tlS/XS4sk8VsCwLH84U6W7GJAv6cOHWH+/TjlcEAWHhz+qZv3bux22Z+cb4w4e8KP/2rI80VV/zmHimU1n4vAi8geOqLKAS8Pd1Gww5rSRd1EeNqoi5dT44KrrQzgXCj2QnFc4D82/p+vABcaeS+pQmM6RJZrYYpmJHfMxa31E0VqbH9hSjzj4VMFyRj4kTTC0EQL2D5Jt4ktX39Hm4GylDcqTLQNvMM+g2AFB69phBI34XuazpUl95rFKDez+L+3qvwfYCbapsabeCfQM+tqK/Mg7XSVNW3sYJ4fLf8ZYYQrMWvjaj8Rs3IV6XBu2PRMymSCClapiiOd+iV2mADF3AtHcx0czkxSftAWpmtb24dY4C4SnVAiHK4clFvNlEgdToRNbkcMDTu3f0XNwed3Ws8UFh8golhfl9OLDyf0eTGEOjXBTved8sTYnB+RXDmp+/R2jb2MFc9vCXlFm3bkYsKUW50LP0VlLZ9MzVJ6JKgGpyVHpSwPlJN3Z/JIoDJ3yqyDGc4jdCsR+AS0dsCERZkpeb5c9Nahd7JXXMcDqcvva8PgVcOeH19DLktcGkgy+mQadY6dXUzrt3oJsFc3h3/VsvIo0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(82310400005)(4326008)(36860700001)(47076005)(478600001)(336012)(6666004)(110136005)(83380400001)(26005)(356005)(186003)(1076003)(426003)(2906002)(2616005)(44832011)(70206006)(36756003)(82740400003)(81166007)(40480700001)(8676002)(70586007)(5660300002)(86362001)(8936002)(40460700003)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 00:36:42.7214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c10d7ba-11ea-4fe9-746f-08db79021399
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
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

Make sure that we initialize the vqs[] entries the same
way both for initial setup and after a vq reset.

Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 5e761d625ef3..5e1046c9af3d 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -429,6 +429,18 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 	}
 }
 
+static void pds_vdpa_init_vqs_entry(struct pds_vdpa_device *pdsv, int qid)
+{
+	memset(&pdsv->vqs[qid], 0, sizeof(pdsv->vqs[0]));
+	pdsv->vqs[qid].qid = qid;
+	pdsv->vqs[qid].pdsv = pdsv;
+	pdsv->vqs[qid].ready = false;
+	pdsv->vqs[qid].irq = VIRTIO_MSI_NO_VECTOR;
+	pdsv->vqs[qid].notify =
+		vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_mdev,
+					qid, &pdsv->vqs[qid].notify_pa);
+}
+
 static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
 {
 	struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
@@ -451,8 +463,7 @@ static int pds_vdpa_reset(struct vdpa_device *vdpa_dev)
 				dev_err(dev, "%s: reset_vq failed qid %d: %pe\n",
 					__func__, i, ERR_PTR(err));
 			pds_vdpa_release_irq(pdsv, i);
-			memset(&pdsv->vqs[i], 0, sizeof(pdsv->vqs[0]));
-			pdsv->vqs[i].ready = false;
+			pds_vdpa_init_vqs_entry(pdsv, i);
 		}
 	}
 
@@ -640,13 +651,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	}
 	pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
 
-	for (i = 0; i < pdsv->num_vqs; i++) {
-		pdsv->vqs[i].qid = i;
-		pdsv->vqs[i].pdsv = pdsv;
-		pdsv->vqs[i].irq = VIRTIO_MSI_NO_VECTOR;
-		pdsv->vqs[i].notify = vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_mdev,
-							      i, &pdsv->vqs[i].notify_pa);
-	}
+	for (i = 0; i < pdsv->num_vqs; i++)
+		pds_vdpa_init_vqs_entry(pdsv, i);
 
 	pdsv->vdpa_dev.mdev = &vdpa_aux->vdpa_mdev;
 
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
