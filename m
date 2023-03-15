Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADFBC6FD1D
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 18:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F99481871;
	Wed, 15 Mar 2023 18:55:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F99481871
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VtFKVhuN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k5AhBIF7IKnV; Wed, 15 Mar 2023 18:55:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2DC8781951;
	Wed, 15 Mar 2023 18:55:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2DC8781951
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08E46C007C;
	Wed, 15 Mar 2023 18:55:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7E06C0035
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63FAB4188C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63FAB4188C
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=VtFKVhuN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RVgzc0J2wTs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CB2B41799
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CB2B41799
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIPu8LUvx0thUS4H0lBhQGXumtAgN2lkYtrgA24CWLn/cJQNMJgCSKEgeAJFNIp8fwQ9IpNhjARCU/K2HEDLsy+BrsisxbVgN5eN1PUHyPOBC9A4qbBum+4ufjXKwXOPWMNGUUs03ScuXFibWuXry4+zLY45IBDS20hNKmUlI/m/ijHHdNQ6zWg6AFFHBXy3JqzLbGUsawuyk9Qh7ZDvLhSgVAd/nYBApV9SDrC0qWKchmqQ5JE67XIwVzpoauODnK1R4EU00ncvTpxk/wJ7KFmli49o18Yl54LentgWE8r3hGdqRM0BPYJ1HJ0QoHBBK9H8HsNCjwCuK0cc7I799Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmCXInKkTnWaA5P73NpfxW7mlmFI0cay50DLpptfPN4=;
 b=erVsVe/sFoJ/H8qmJS43R8UmRhSB+d6G3YIF+uMK3luU9MR05TgiGoTBMRlHZ+p4xov80p8OE4P8HUC/eZ9JM/sJ8VGwlD/ts1KY8fyE7k86e4Vb589eJfHpnkfi1Qg99KwTxsipCrzrOGedEX4VbLZ16nbFO2JXceJT/UDbGj0JfwmFNaMsaCnvRph07Dmrv2Cl9Jd0CVOT4bn9f9ML4YMf4G2sMxk4sxIJAKEkJjYkS/Fs9Ke+mSiLzAVciT5b6DQH8yAP0eduuk1oz1Jfho4GQ3qeFCAuQmwFZ5gQ8Tp8vUJQHtSydhbKD//UNXmCqCvQzDKseLoXoYEajxelow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmCXInKkTnWaA5P73NpfxW7mlmFI0cay50DLpptfPN4=;
 b=VtFKVhuN9Cma2LR3+ab8TNuUkPsKCukyQR2cmu2ycMruIuhKYzcA3aQs5VVIPHOeCI/OA1KCJMoTKRYBMhFP0DPXwQd8Xl9Ht9J2vjqVeXxsLOn0GuvPghXlgbCHF3ItIG3ZzspL+0DZpmDbqD78Y7S/erDrX9RN/2RrfX544yHdfwMyp3jybAbwyEo1rJ+aX/BfhOj51vQgtphy9HldCoMYjyDyJhpP0FR4g1yWoD+sLin+5IygtBeI9CDZ6fFrfIBRsy7neA7EMmox+vGcHFJCKmfXH1o7Ky68bLlmC6jqpjjcO3oeDe2586zu/7XXOCbNbyN14/7LqkTrStZKTw==
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 CH2PR12MB5019.namprd12.prod.outlook.com (2603:10b6:610:6a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Wed, 15 Mar 2023 18:55:10 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::55) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.30 via Frontend
 Transport; Wed, 15 Mar 2023 18:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.16 via Frontend Transport; Wed, 15 Mar 2023 18:55:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 11:55:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 15 Mar
 2023 11:55:02 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Wed, 15 Mar
 2023 11:55:01 -0700
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 1/3] virtio_ring: Allow non power of 2 sizes for packed
 virtqueue
Date: Wed, 15 Mar 2023 20:54:56 +0200
Message-ID: <20230315185458.11638-2-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315185458.11638-1-feliu@nvidia.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|CH2PR12MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 850d621f-476e-482d-ec5c-08db2586cd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OZgPwiGKirUlxjEoX+NswDe9NLNGe+lBfpK40eowpPQdstT6lglvJqPXiOMQ1YJrsGGSLh9SXct1PynS5ftZTO13zu3hulJJdl6qKWzcqIkJ3Noqnmt0qr0GrkQIwrT/OnXzAzKJ3Gdazdy5kU70YVlVg7mGBI3nDq7HPUN2CF81GSQMzXA/AE4AtKLyHqujobUBJBt4FJxpBADmmM6YGNBsR3F20ZsNVAnMImzFrPWDodzGNJt8ILNB57YO8kLpIzlm45m9G/SDQGnh9qukigeNgPcAqML1Bdgz6He1fwCPPbOUsQ0iSgSmnKrU4YPY0NWFTaVQS0nmer8M1uV2iz2BH7TYySplXs4juHjoy5QSnoiAQNQFlQihRem+JupD0G+e5ltlh35va1WSwekNA+iJWaNSyJMe9XtOaDD3R+t0TWV4Cr2i0HAnMEIw/4cLaYH8hLxiTVjuk+vqWIVqWv79as9UDAVESxp7SZdOpbb4E/T5PaHJdVW8153rJ9raVidlujbSPvin99jmxqh9yTN6KsBX3+D9RgRIWA2ijdzdzqHUbdbwYNRlGmM+Vmk6JMzrHsVHjIJHtygO9tecCtjg2JJujJZq2ZgtsYJctwBBOiJFYvYbWYnU5OvBuCye60c9LqAFrApEey/x3lmLHVHo3dHjx/5LpKhIqJOnbMlwUKwRQTfIk3sv7K8/ixqM7nU2u1H3XVvepC+cAsYgDmCM0NPjIbURIZcpA8BpKaDcX5nAdmNqdFSgA0KCIUB
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(86362001)(36860700001)(36756003)(82740400003)(82310400005)(356005)(40480700001)(7636003)(40460700003)(41300700001)(70586007)(8676002)(4326008)(6916009)(70206006)(8936002)(54906003)(478600001)(2906002)(5660300002)(47076005)(336012)(2616005)(426003)(83380400001)(7696005)(107886003)(186003)(26005)(6666004)(1076003)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:55:10.3636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850d621f-476e-482d-ec5c-08db2586cd67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5019
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

According to the Virtio Specification, the Queue Size parameter of a
virtqueue corresponds to the maximum number of descriptors in that
queue, and it does not have to be a power of 2 for packed virtqueues.
However, the virtio_pci_modern driver enforced a power of 2 check for
virtqueue sizes, which is unnecessary and restrictive for packed
virtuqueue.

Split virtqueue still needs to check the virtqueue size is power_of_2
which has been done in vring_alloc_queue_split of the virtio_ring layer.

To validate this change, we tested various virtqueue sizes for packed
rings, including 128, 256, 512, 100, 200, 500, and 1000, with
CONFIG_PAGE_POISONING enabled, and all tests passed successfully.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

---
v0 -> v1
feedbacks from Jason Wang and Michael S. Tsirkin
- remove power_of_2 check of virtqueue size

v1 -> v2
feedbacks from Parav Pandit and Jiri Pirko
- keep power_of_2 check of split virtqueue in vring_alloc_queue_split of
  virtio_ring layer.
---
 drivers/virtio/virtio_pci_modern.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 9e496e288cfa..6e713904d8e8 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -310,11 +310,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
-	if (!is_power_of_2(num)) {
-		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
-		return ERR_PTR(-EINVAL);
-	}
-
 	info->msix_vector = msix_vec;
 
 	/* create the vring */
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
