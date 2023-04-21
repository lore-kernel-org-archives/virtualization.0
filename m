Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79DAC77B78
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 19:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44F0884348;
	Fri, 21 Apr 2023 19:57:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44F0884348
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zwfTcMZ+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1sIvI-imaBhw; Fri, 21 Apr 2023 19:57:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AEFA2843D3;
	Fri, 21 Apr 2023 19:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEFA2843D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9154CC008F;
	Fri, 21 Apr 2023 19:57:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E485C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7529A7001C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7529A7001C
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zwfTcMZ+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z-9itXD2TC_N
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9746460E0D
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::612])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9746460E0D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKn/5B5Zf1wlY2JEuXgws0HF4i8Lr9x0T8bDpX0l0aMo2khC+pPSh2Z6YADe3ep7975vn4dYudvhynBeTctO5EAiDqtTSaCHyYuj1fdVzo6QVu+DQBNsHus/4fPgwTFK2OFaTDsmqC7jxzwCgBiZuyC9AAuqPJ/RzQM8xxGUXUplmBcKmtlUgIVIHyyvtsTgRXmy9gJAhdsmmCyncGb1vnlNyPVUJE8Xq/gtKrIcy7lA1sQYnTmnRpYa2VllsY/S5b2QosZfTjmMWEipstsfEPF1XLk/rQgFli47C+T6EgW0b830Zuurql1EFVz4pexxFTK6aZ3+/aVtkjNJNPGN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwlP/0aNRzwpA4zxgvJUobb7af1y91HH5ZEoy/+nVTg=;
 b=GZi324OL1CzlBQTtwt/2S8s3MYCB4p0+I+9qtvC0RIh9XV8YHvgIF1G1FTrTHHa/9djRAf0SKT4p6yukoSdkOaON1wSl1fPby5ToGFueZCXtdlCj+SakTOOHcP+VQOP8rOzTbI0xWIuL0onfXb8LPEDwI1eTiZFmHEP64KJu7BTHIiMRKeaKTcUYLibDaib2iXgCetSn12XDOpz4CheCEw23abNieqlb9mMrF3UY5TQzUcYHcw2qltrv1LGMIfhhsplN64BwrQmMf5cm5q8U/Dlf6e+gb21gCFX6uAtmGgYV4XwoUdghrhWB1Pbps7x0KHmI7eL4JBxn+PLEFL7kEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwlP/0aNRzwpA4zxgvJUobb7af1y91HH5ZEoy/+nVTg=;
 b=zwfTcMZ+YZ8h4FCxzii8Mp4wx7lq114O7sRiUtPNoDfzCUCcBk8/oEgaxOPd90YgkJXHDz8Fn77rxCDs2hxnjwI3pW667CnfPl+DxiF2PQc668EXOub1UnpA31y3eIsYSmLbJfwqWsNGP3r96PzGw9cS8Q/gz61z0+T5eSrxxhk=
Received: from DM6PR07CA0117.namprd07.prod.outlook.com (2603:10b6:5:330::32)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 19:56:57 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::93) by DM6PR07CA0117.outlook.office365.com
 (2603:10b6:5:330::32) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH 3/3] vhost_vdpa: support PACKED when setting-getting vring_base
Date: Fri, 21 Apr 2023 12:56:41 -0700
Message-ID: <20230421195641.391-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230421195641.391-1-shannon.nelson@amd.com>
References: <20230421195641.391-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: b9eec500-7a4a-488f-c84b-08db42a29051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Efyz482rr7JHrJf8YnUI+fgA8vyNBHusp+iorkD98pje6ea3jKJwy8TnfX6g0cU2nBWQcHQGYsJbjJRtjdMG7yfIJUhq8fOsFYhjJISivPl66nhK9Vv3mN6YcuGwVSWE3VAuGYNfv3nT+zgWVTr7Se5/t4AAvA/bDcZlhMWhM0uhJMLg4uB2jTT57HWTukTkdaBjSa9dOhQvUNCRQzwkWO+ptXk7KpuPngen8/c9hPKLsC5v37vkJTCvexBGdagCDWymsndilA0vdymZB3qXsOPvjKgNcXxuHShSd1WiKtuw7fYRPTmSwIoVVrrgiEcJEPGajxz0iLmxD3jgRkvkeM2WKNS9RVJtd6mzX4eZBLJpCTOBxix7W+KKR63UXGCekM8PkvlNNjxj1Q0x5JhJE2k9AG/wlbqbflv8R6/QkrFY8LIaNCMfVZA45INJv4fJMWU7szsTzDm32ivFa9ZR333xDYS5Xgzz8d3OFtfDnqO+52Yvwe8AspcADkTDcvP3kQJugVYJk6oSWRy9G65sFdFx1im9eTqOHHm161q4tKrS3TpwB5+anwxq4DK3Aso5mU/etLmajb6o3/GIh9FwgGyDKJJH+yKi8FeFzitEMxSOZKEWS4Wv4vxltoKwZrT4TZVcrElvuw8sWIFE8VnsglY9NcqKaAO8F2hYYR1IhZW1+6aK2ABaLJ4+a9V/7FllPJkjSH5zaGwF8MVHU9SPAC4jpBNoJIaW/4Ut6+lIRUw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(54906003)(110136005)(426003)(83380400001)(40480700001)(36860700001)(2616005)(1076003)(47076005)(36756003)(26005)(16526019)(356005)(186003)(82740400003)(86362001)(81166007)(82310400005)(336012)(40460700003)(6666004)(8936002)(316002)(8676002)(41300700001)(4326008)(70586007)(70206006)(5660300002)(2906002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 19:56:57.5689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eec500-7a4a-488f-c84b-08db42a29051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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
 drivers/vhost/vdpa.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 599b8cc238c7..2543ae9d5939 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -585,7 +585,12 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		if (r)
 			return r;
 
-		vq->last_avail_idx = vq_state.split.avail_index;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq->last_avail_idx = vq_state.packed.last_avail_idx;
+			vq->last_used_idx = vq_state.packed.last_used_idx;
+		} else {
+			vq->last_avail_idx = vq_state.split.avail_index;
+		}
 		break;
 	}
 
@@ -603,9 +608,15 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
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
