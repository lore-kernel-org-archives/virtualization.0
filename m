Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0067FC7618E
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 22:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F2A1613F3;
	Mon, 24 Apr 2023 22:50:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F2A1613F3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QDwst9CI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PvF9IDnYPDwr; Mon, 24 Apr 2023 22:50:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A7B5B613D0;
	Mon, 24 Apr 2023 22:50:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7B5B613D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A97EFC0091;
	Mon, 24 Apr 2023 22:50:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBFA2C0037
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A704060C12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A704060C12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xYF_1FSDPD9l
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3417B606AA
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::604])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3417B606AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMfUm2B4co9TFCZkgcRLrefjJ3zGB6+KkfWf2XdAZkjoOZKWNztJoJ2JWpSt+giewipijwQVXIDEBgGbe8GQB1zHeQ5oto0sGSzemqgXnuWuBMpEztEEt276N5qT2ghBZZrD+ApRFdq/jlHf18gMmTxvwFObvv2gGHDHHelCK8Xt2mA1qmW0WwheJTYVQfjSvvTukha8bnVNdRkgFK9MWQWOyTSEobUCBoNF06iyTUExdbJNDGzWgmXK4P7PLbq8XLNZQUPh0rGIE/J9Tr0cEZXrZ+Kz3qBQZN2nSP8Rgf2I+052hBxfWErZfGFHbWWQVN+OYC7nXNi6NmNE58NKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzBEzNNsWW6Q/ewT1l+pAgprtq5oAtLoB502BluMUfo=;
 b=kH2dRbi9JKsjDOzZs5fRef2jNHJzRAsceAg1N0pNksiYbaKMRxjCboKvvT4ph0leLLlIeKFS/SGOBdXU2UB7KjhlntVuzb5gVA6ukAsZwr3mIdJKU+kLb7X46NhJ/R4IDuT+XJRame135ohejK2No9zd49Bhd3dw1YcAPeaooKwxSF/u4Y11Y/rmuJ6G1+Mt7GyhaxmcPnPLhtKLWYftsX6H41mhOrrRr2EqqE1D1vMIA+E9JFsBagTQYxa5482CkwaSxKaE9C/VeighooiwGVnzrzd0iv5KXmmnFiF2unFehMwaMgkJkXr0JZ33AjmD7ucda5w07K0m2hW7mhYbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzBEzNNsWW6Q/ewT1l+pAgprtq5oAtLoB502BluMUfo=;
 b=QDwst9CISuI/pcrs9YeOfJHTlTihBNnqy4XSunen2XENDD2qQyCiVQykDoifLozbdCQ3oDQl3MhSQLpX42Zm3hTX6aQqOOF6O1XWwFDenLRieniEov8pAZj8kJWoCP0vPzluBrKW/FHKlIebcmAp3lY6NzVICcU32JY9+YZFrAA=
Received: from MW4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:303:16d::17)
 by BL0PR12MB4884.namprd12.prod.outlook.com (2603:10b6:208:1ca::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 24 Apr
 2023 22:50:48 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::67) by MW4PR02CA0018.outlook.office365.com
 (2603:10b6:303:16d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 22:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Mon, 24 Apr 2023 22:50:47 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 17:50:46 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 3/3] vhost_vdpa: support PACKED when setting-getting
 vring_base
Date: Mon, 24 Apr 2023 15:50:31 -0700
Message-ID: <20230424225031.18947-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230424225031.18947-1-shannon.nelson@amd.com>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|BL0PR12MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: f846bebf-5c59-4772-5807-08db4516584e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXkhDfkXQyclWCtK7DrHKNZ8W72v/rcDYXsfJ9R+P91q1wVukMheSa3UR36v1xfJ3C807Lld0JU69JvcXsp8xHHmvlD2X18oBkhsh+UzQCLxwJ/G2lmJDyWBzg+rNwmiG1wIesEbUi1NWr641mnSNEPbtj+/XMKtkj1DmSi/IRxSVbvGKkR5OBYXDmetrSj0mzSNzPoCeKkDIYxX0DIBoRsWMz1oD3ttx9KAN9CCN+o1iMfksIGP9DJb9gE1wgo8YczjTJw9ibYewuCWr2xkkb41dwDxujNtVneQFxDizPq9O2pVK6LBUpKpHwlPJDrSWJvcTI6emGSuM6w8bdFCiMo+LzXXW9ms9QU5vNNuXAIbICqYDdtontCLWI+Vn+Z+yPzmjMcnKE0ZqcGRS9I6ZyYJHTjWLMvXB06ZVuq1V86lEli3oH/wkhcasuDO0Fjl/zhUpwMXxRsjWgLXmhQLTGS6DJZgxicDAqcLrLxP2vI8BJ/miQIHyJvlrNUeyj6G7RShNeuQfW5kWkSL+93NI3PjCXXXJoehRQW23aGXQFVjae6LK2qS14qLlMsAANXUByAs8ogk1QgbFuIiy4S8UZuSXfUYVeSf076byWJgaVrvCOKqT8r1z/Xh6b3L23/faqAoHs55CVxIuV/8MWCG7hK6GKw9LUv6Tu5ODUUAXHXQ3ST3XxsPbJ+Hjtqx34p96r2MRsrAUe9qbTHbUXUV/Oj6fHe8CAlRUKJe+b8g2Ec=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(5660300002)(44832011)(336012)(426003)(82310400005)(2616005)(41300700001)(47076005)(83380400001)(40480700001)(356005)(82740400003)(86362001)(186003)(81166007)(26005)(1076003)(36860700001)(110136005)(8936002)(16526019)(8676002)(54906003)(478600001)(6666004)(36756003)(316002)(70586007)(70206006)(4326008)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:50:47.4621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f846bebf-5c59-4772-5807-08db4516584e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4884
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
 drivers/vhost/vdpa.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 599b8cc238c7..fe392b67d5be 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -585,7 +585,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		if (r)
 			return r;
 
-		vq->last_avail_idx = vq_state.split.avail_index;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq->last_avail_idx = vq_state.packed.last_avail_idx |
+					     (vq_state.packed.last_avail_counter << 15);
+			vq->last_used_idx = vq_state.packed.last_used_idx |
+					    (vq_state.packed.last_used_counter << 15);
+		} else {
+			vq->last_avail_idx = vq_state.split.avail_index;
+		}
 		break;
 	}
 
@@ -603,9 +610,15 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		break;
 
 	case VHOST_SET_VRING_BASE:
-		vq_state.split.avail_index = vq->last_avail_idx;
-		if (ops->set_vq_state(vdpa, idx, &vq_state))
-			r = -EINVAL;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq_state.packed.last_avail_idx = vq->last_avail_idx & 0x7fff;
+			vq_state.packed.last_avail_counter = !!(vq->last_avail_idx & 0x8000);
+			vq_state.packed.last_used_idx = vq->last_used_idx & 0x7fff;
+			vq_state.packed.last_used_counter = !!(vq->last_used_idx & 0x8000);
+		} else {
+			vq_state.split.avail_index = vq->last_avail_idx;
+		}
+		r = ops->set_vq_state(vdpa, idx, &vq_state);
 		break;
 
 	case VHOST_SET_VRING_CALL:
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
