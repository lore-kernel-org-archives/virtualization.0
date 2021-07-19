Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A1FC07E9D
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43744610FB
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43744610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B98660765;
	Mon, 19 Jul 2021 10:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N07S2OdgRfcr; Mon, 19 Jul 2021 10:39:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 728B060767;
	Mon, 19 Jul 2021 10:39:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72A1EC0027;
	Mon, 19 Jul 2021 10:39:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BED6C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE89C82444
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMKWislZrO_t
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::618])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 283238248F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nshTxpKQawjkmiokkalOZUhLEkn/50qdhsY4IB0Y+sSlEyv778Zyi7v9u0F7/x9lq5B268qJnXDDViGs46DubjdfLO/hLZ6IjtNly4s6w8T+/roYMQZJXy1pR8AkBTtk0+uVDtR5HdATg6R42E4BYEmhtGnOV0lfo65WQ2YSAy5JYriTOylHMjNMqWcYW2kkJZH2PiJOusi6XmbRJ2R/7rsdY+Gl4BkaQkoykmcINwshH45YJfNJCVN//OxkqzTrWmT2KsqGVd9PIF1IY+vo5FJo4FRNp99HwbIxzl/bBi7+hNxxgWXDbAwLnmyiuxpu1RybQCP8+mkVNDgrM1mqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EfQ+lBOsFJLRpN8t3XNB3V3eeXEUiQ0k1njRKr4HAg=;
 b=APWyLa7R1Iy6nUisCAOnc61QBImpkPcUemfxk1aYtFPRsJ/fUlwDKYBMMN0xYXaDj22W69MiHZCU9xERXctiHWCeBfgFswvvO25/+2AUD98Tp4toFHWVsA8ub/Sf8U6eMHpSvFR9PczT6aq6GSAGfue6dwblUfjzrmmCfPzYcS3r3vRQyLlXi1U7DZmDgTvv9d17zaS2Fs98B4i+rlX8ELEdZ7idqkqg5MROUzn0FZ+sEdpDqHMCm+9eyc1bMV01UXnpIrVZ8BaYNd6Ayt7E4m0XVnEYMUSTuYZqeGlADKNE6w4o6Eclm5pnMq9u14Jsgm7bJsFAUHjSDFdNJuft5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EfQ+lBOsFJLRpN8t3XNB3V3eeXEUiQ0k1njRKr4HAg=;
 b=qKRTfIRoSEvVxaxLGe1lIJ7i4e4Lue6+iMwWjQ9PfCQ2tiCRVrLg8cdq6p5e74zuxbjipZVqWjlPOa15s704kluCh9CAeL8gFymC0fvdbytSFtoAbZ3mfGI9hgjTdFHhIHMyyVRV66VyKNZz1J+auQH5Wljabq3k2VRkhFsWZNgJIvzcVTs2pr8hmOA3pZNqKRB5uQXv9Y1ktpkEDkkmZUs59J5M7PXmcpWMFSvTc/zMGKnUkttBwFVwclLjntSzQ0S/RQjZ/1C1tDMxzOJm1t62SFGTHzgNS3x5rz3rje8MVVo2ipaXK4vbeiLHvENInUdCvVI9W5Oc8mwNjxPO1A==
Received: from DM6PR11CA0009.namprd11.prod.outlook.com (2603:10b6:5:190::22)
 by DM4PR12MB5085.namprd12.prod.outlook.com (2603:10b6:5:388::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 10:38:57 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::59) by DM6PR11CA0009.outlook.office365.com
 (2603:10b6:5:190::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 10:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 10:38:57 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Jul 2021 10:38:56 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 2/4] virtio: Keep vring_del_virtqueue() mirror of VQ create
Date: Mon, 19 Jul 2021 13:38:39 +0300
Message-ID: <20210719103841.1488049-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210719103841.1488049-1-parav@nvidia.com>
References: <20210719103841.1488049-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d55c1a7-bb0c-4572-e89d-08d94aa169bb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5085:
X-Microsoft-Antispam-PRVS: <DM4PR12MB50859AC983F457312E087E2CDCE19@DM4PR12MB5085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwjnTAMuE/tdKZRxFcfP+W3rMeYNQGVEouB7gnfkj5G+pQJdzhQuuf3hbqy8MZcOr5ZNFp+QM+PUCzFLOjFbuk62uNMtYJCqPq+hsPCQdsubaDznoKc3GVI2T7pK4OygMqRyMKdsQb8d7eVf4qvw16BYo7xYgIVWLIAxm7lTr4oDlCsfgVm4wg6Q5yAFtj3NB4As3TU62XQALENOUkzmQb0on9kv5sxfph6+DxU2bgJwVvHomOV58RHb4SU1JTHZAyobHoUhpFs9hKzDncIPRIS9LWyrrH7jHWb533Z+QmnEMI6Z24ssyrSvxpy//V16No6daqeq2bboBC2Q446pupOzifA/TJOxWszTa/3HMXx9FMW3QgoC6lwq42DpXtCufrkW/LBrQyNgfewDuwdrMc87AeEu/rvRCnNVaPYFvxQMwRNtIskROzzE1uyrT2vhTGN/XadrnXdF4WWcUTx8YOiybouaeyPA0nAZqVW6lc6iSzqZdsgAiRNon0+Imf5MSgY62/+0e6CCyKp/PP8I+w6p5oeLXK7DXr0I16TaYA8qCdHJSPi+ZyQ4uXYPyiDIicOtIMmSA5wgEZXjEHRUO+/7XuEF/Vcp2Z6Jhq6DVoLfh4tuEIKrQsrcLZXhsMy0q98ppYwGGdSdIggvE7n3wE3jUWTtS078SvYmjGNI4uWgKmjUTjjytp7Ksq5gBlxeH1LhXNwDxdEynzhDhi8U0A==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(5660300002)(336012)(2906002)(426003)(478600001)(70586007)(8936002)(1076003)(70206006)(6666004)(110136005)(8676002)(36906005)(107886003)(2616005)(4326008)(316002)(16526019)(186003)(26005)(4744005)(82310400003)(356005)(82740400003)(36756003)(86362001)(36860700001)(83380400001)(47076005)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 10:38:57.2549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d55c1a7-bb0c-4572-e89d-08d94aa169bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5085
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

Keep the vring_del_virtqueue() mirror of the create routines.
i.e. to delete list entry first as it is added last during the create
routine.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/virtio/virtio_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e179c7c7622c..d5934c2e5a89 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2291,6 +2291,8 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	list_del(&_vq->list);
+
 	if (vq->we_own_ring) {
 		if (vq->packed_ring) {
 			vring_free_queue(vq->vq.vdev,
@@ -2321,7 +2323,6 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 		kfree(vq->split.desc_state);
 		kfree(vq->split.desc_extra);
 	}
-	list_del(&_vq->list);
 	kfree(vq);
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
