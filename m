Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D70FC12002
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE42611C1
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE42611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4469B608BC;
	Wed, 21 Jul 2021 14:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDn3sw3lETaP; Wed, 21 Jul 2021 14:27:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD7CF6089C;
	Wed, 21 Jul 2021 14:27:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E20BAC0027;
	Wed, 21 Jul 2021 14:27:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FF2EC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E95940493
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jh2VXZJllCOd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 284844037F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP5xgi2KDGrlGbRlbjyzVnHvuIDEUgc+Noxb0tyoSr4hz/AXSXiJTE8MFjFA2egQbF/r4MLzHXVvEHdjabs5AvX9ffHINbU1iCrhBQ6mLR+4sJppq4pWHEsy9z+ZmQXru+usEATlUO/1bOeQ6SgUDZxdaAELsufink3fVe6OTt7oJ2wJc+Vrr168/k+6LBRACoFXou2KwGCxgocr1m/G2Oxjf0D/dL0b8CF2xfopTFiCb7p/rxwy1j/2X9ePN7gjX+v6SXsY/+vavFBmAQg1b3kebQk29mgqm2/lupQYJYyJ8Wft3fk4pBqcSkemYVujD+hyNV5I5je/IDk+Vq1Vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EfQ+lBOsFJLRpN8t3XNB3V3eeXEUiQ0k1njRKr4HAg=;
 b=n74ntVnHfUXYLwjw+Wbc7k//KSwpIXCpDpuUWwvqUvEGjdrgc+MmsMBNVKMABBTEt9X3haJZM3XdrEQIS4avhfpeajzDxseS9o38gHN3rlcAPUgN2GrA2HzXHUP7WUjT/7aCd6km0Vhd70K5YYJdKM4E5f0mgK7px0LsqE7xYj6EalWpFfZTB4ZDd8d9Hcr0JTjs+ZQTj28QDQ40P/QxmwAYMXL/lQ7NruzS6I0LmEIQCANH0gTsvfRFZJVo4pFCdo2JvbSk1iJTNEmzfzdeif9LaT8A7TDav7AEN958e0bDm5Iuw04JA4zfpKcLGN1ivIhGC3wNcLgXTALiPVoJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EfQ+lBOsFJLRpN8t3XNB3V3eeXEUiQ0k1njRKr4HAg=;
 b=l60ZQ/5DubZbm3vMvFVSaiAUrPBR/gQH5CvctfrM7Uw+hTt8BNamgjpvV6t4oX9CWDYREKEDT0/W0QTpPtWBEEeT9fLHPFCcMCvz359XRX+UPmLr6ZMkdSwKi/4CBIXfQwOSqFiZnuzpldJw6CNsJr4bF7a3as/w/vbYri3Njp6zwQlK9/26UYVJH5kejjM+i32TS6jiJIF+2LT3dEEDk0CEv1Duw78skD0/nIJvUe/akJdqtrCCxCsLu+Bd7r1pItfnM3Xz7yW9wqXisRv2iidIDlkzqCNI+3Lcs+1ZI2ZLoLdBbqSthYmKJASlpS0qbAIoQfE4mG0w1Yb9UtBVDw==
Received: from MW4PR03CA0141.namprd03.prod.outlook.com (2603:10b6:303:8c::26)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Wed, 21 Jul
 2021 14:27:20 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::32) by MW4PR03CA0141.outlook.office365.com
 (2603:10b6:303:8c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Wed, 21 Jul 2021 14:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 14:27:20 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 21 Jul 2021 14:27:18 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH v3 2/4] virtio: Keep vring_del_virtqueue() mirror of VQ create
Date: Wed, 21 Jul 2021 17:26:46 +0300
Message-ID: <20210721142648.1525924-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210721142648.1525924-1-parav@nvidia.com>
References: <20210721142648.1525924-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8705eafe-0939-41ca-2c37-08d94c53a622
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2382D2E8FC47DCFA6257AA8EDCE39@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNHN+MdyvCtDcxnwtQQpw7ury0xuv4rz4D0XKO0GDM4ozo9+2lNoTHHEnpY6ZRHoOZ1DVbea2/VvWS1/hI/Ee9LsNjnqjIWGD9CZWazaMAOhlrlluf74LPYm7/+dZzsDIb+lRcpDyURatHBbzLANHJ+3Rs/42TDwvJ/DTc+X3VmfwOiYRuN878XGtSjBT8sULDKC+6dMZxeHfG+KhnCmiW/3nxrRG6AcVBuzTKCz+hSKmPHsg9aPNQH7xkL9pnjAllPf3c/C4vm/zIXwD15sVllNgVbUnSIq3GXENlSB6oF7cpR3vbLVXUammcZ0lX22KrBo4B8i2pCshKnomE5bKj3WyXuNpVCqW7p3SWVFPyrWgGYr3ERP3i27bltH0Q5uVIu8st0ocRZMPWYAhy5UQXoldSXDJvXgH5ORj9PVeF9FdFn5WV1S81gSJEESYBgzBFV+EuiL9vyNn7W45rwTU2wil449cWO+581YPZke+QERqQMNwbatKD2zQOvfTXw0jjNFtQ8O4jSufP+asFx0jgBW0ZlYc8dM3CSAnz7RPlaOMqWJSlcO4sNvYDyNkaUSvvo4StfizbuolFnWgW6S8uxTsm9lRbA1QYk+zRKKK1K8gcqgZtEr7vSDjSkb8yk8vdMZD2Zoj0emU7kFNI2j7NwRd0wxFhnYphAq4Ml0u459Arl6W5HuY9cDTCoXEHVg0ok1m92LdMv85GBAMV2Tmw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(426003)(2616005)(36860700001)(316002)(70586007)(107886003)(336012)(8676002)(186003)(8936002)(4326008)(478600001)(70206006)(110136005)(6666004)(82310400003)(36756003)(36906005)(26005)(16526019)(86362001)(1076003)(2906002)(4744005)(82740400003)(47076005)(5660300002)(356005)(83380400001)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 14:27:20.1850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8705eafe-0939-41ca-2c37-08d94c53a622
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
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
