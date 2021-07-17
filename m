Return-Path: <SRS0=6YK7=MJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C8C636CB
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13933611F1
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13933611F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBE8E607A8;
	Sat, 17 Jul 2021 07:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZWn8oX8r4CZd; Sat, 17 Jul 2021 07:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1090B60650;
	Sat, 17 Jul 2021 07:43:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 641A9C000E;
	Sat, 17 Jul 2021 07:43:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE42CC000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9944424B0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MyYKVGqX2j2Q
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27BE6405C8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTI1bu8TCLxsQeqf5LrAfLvdFkVmpPQeUVDM4EGWsVk2Fc9DnEg1kIJKz114vqsmUP6SHrWA8woGR2FjMlPjz18hc5nShVsFmI9ZRLGszBNYC5HCRkwm/Tdmt0l7Lkd/PN2UibrKyx/eEdCWnnXTPsRvvlFk5OKvl1pqRFTnDc4LBoqWEi0tICZYF5nX5zTj5Ns0/wLCbZ+uC3rUoNNfaFROqbJCB5bRjmBb7mk/CRIpe99tAUz6A7wFn9CFpgjFYNsqFpi2rFmPVkPGuxyXa03bXw+sS6SiBy1EfFZaPeJbyyWvQoBCa1JxBMOQyGnh0tCLtrTJioM0ddsAU/Tkaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSZ1UNceKyTkmf9cVl0nDrAl+ihz5JjKa355h11lxT0=;
 b=JezMggG+73+PP2UpU4W43j9xNHbGJIhyKaVWKfoFSmpkpitGeFVzP5Y4aGMSLxADZyqN3vm8QZu1dJ656XWzgZy8+Gx5liYnL59UoouT3HFoH+0ULn24fpEUlGnuL0/O/XHFZGYt+/0SBomnoiEKbrF7POXF0C5GofSaL0mBmi364ounJ0FIDdR7ZPFFlIEBgqhW6vXCMxdlT9iGismFrOuKo8lvgB/fFnsfnAvxvpUkd/d1bCYEErrGti9E5JeZVz+2WYTq6td9Y6NafLEx1sKmmqzxvuc7HTQEleHypu0Eo0pg2Kpg6+JpYyYRRZzaL9Sbqhggn4Ng6EbAeSeAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSZ1UNceKyTkmf9cVl0nDrAl+ihz5JjKa355h11lxT0=;
 b=LXmadDPfvLIk8umLwa6v4VnZ7YKU9BPwT3bhYjEJUiOJQ2GpeotTg9w5jieYHOyxTFJ+7TIsr3Afk0JT1Nk6ekuIV7B6y3oMWaVBPixfm2/xf4fanYBKs9L+2tgTBCFGH4XhEzxJYvZlIjKTxmqq6EVM9pSEs85QYPeJ4bZU/bXFVx/8alqp/ECFJyDzxcbGMPxWnUTZqEA1SQ7jwfTyQqwul2D+7vYZl5M3sGqZzujaqUWMOWy/wegO9rcDiwjnqAGLe/0x5uWsYBTBQhLhcswXsUrPksnVgreDnqEXlDsEDLhRi5ojU466Bus12am1bRsH/DbQYyqoiqZKvjQHtA==
Received: from MWHPR22CA0065.namprd22.prod.outlook.com (2603:10b6:300:12a::27)
 by BYAPR12MB3400.namprd12.prod.outlook.com (2603:10b6:a03:da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Sat, 17 Jul
 2021 07:43:13 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::95) by MWHPR22CA0065.outlook.office365.com
 (2603:10b6:300:12a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Sat, 17 Jul 2021 07:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 07:43:13 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 17 Jul 2021 07:43:12 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH 1/4] virtio: Improve vq->broken access to avoid any compiler
 optimization
Date: Sat, 17 Jul 2021 10:42:55 +0300
Message-ID: <20210717074258.1463313-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210717074258.1463313-1-parav@nvidia.com>
References: <20210717074258.1463313-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6285d1ce-dc61-4358-4657-08d948f68868
X-MS-TrafficTypeDiagnostic: BYAPR12MB3400:
X-Microsoft-Antispam-PRVS: <BYAPR12MB340026157B8AA0382C4A027ADC109@BYAPR12MB3400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9InYv202L/lVIUke4hy8kE+vqNt2t52WczbtVimnuDVeUSf4Y3vbNJQigZdK2KUj+JazrKtdEQBzL9qTPpmcryCq7kr6qi3CEOY3EzYhoxTc/M9sI91coFPSzs2ViAl479G4D/ZKUN3iFwg0y2U6qenqfKx479UCV8Ylrzng7vUr1E44KAZOxufxJpqSuJDTxdBk0PnGZytOHFz50FHXe+u+kKSqd20pf6ZIojto+IbNNX0XKYqx3HcJD+F1EVy5bjicv0zderiV/caS/AIXaYW0B9XHc6KTj50sE8J97bu4f69oOzkVdCB35yxzR0OJesLR10n3BDVMO0+/S8zSpu/cmQgGY0jjGbGaDuSRaoEqvIDMToJ0dTSP1UcNk+tFK0v11OxgYs6alblQcqvFOatdecv830NLazpL1KRvZBEKgVDov6IBQkWmDhPmNModn9pkCZVaZ6+dXBWYZycAaNkpcfJBo5qQdh1uM+9a/qAXIyfOJk+K0QE/ITcKAknjRjYtpWnLWuP0V6DbVgMT/aScbIzJ0j6CrmUCicyPFx9xFEtYHR/gy88snQfWY+qK/TOEq3PK5bqIFkjIanfPxRLs/1cooXgKm0vqn15R0K1g3URi4SsmAFeYdSJbc04TKDMkA0WRSuHqH68YRJMRD4B/wLbhM00+E0VfksU2kVV4vw+HM1TSll20pBEpUFqt/tsB1/KLYObLIZXFe7JMLBAwzS/WXLi7ewcl/eFKmeo=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(70206006)(70586007)(107886003)(186003)(86362001)(36756003)(4326008)(478600001)(2906002)(8936002)(8676002)(5660300002)(16526019)(82310400003)(36860700001)(1076003)(426003)(2616005)(47076005)(26005)(34020700004)(316002)(336012)(356005)(82740400003)(7636003)(36906005)(6666004)(110136005)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 07:43:13.6336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6285d1ce-dc61-4358-4657-08d948f68868
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3400
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

Currently vq->broken field is read by virtqueue_is_broken() in busy
loop in one context by virtnet_send_command().

vq->broken is set to true in other process context by
virtio_break_device(). Reader and writer are accessing it without any
synchronization. This may lead to a compiler optimization which may
result to optimize reading vq->broken only once.

Hence, force reading vq->broken on each invocation of
virtqueue_is_broken() and ensure that its update is visible.

Fixes: e2dcdfe95c0b ("virtio: virtio_break_device() to mark all virtqueues broken.")
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/virtio/virtio_ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 89bfe46a8a7f..7f379fe7d78d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2373,7 +2373,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->broken;
+	return READ_ONCE(vq->broken);
 }
 EXPORT_SYMBOL_GPL(virtqueue_is_broken);
 
@@ -2387,7 +2387,9 @@ void virtio_break_device(struct virtio_device *dev)
 
 	list_for_each_entry(_vq, &dev->vqs, list) {
 		struct vring_virtqueue *vq = to_vvq(_vq);
-		vq->broken = true;
+
+		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
+		smp_store_release(&vq->broken, true);
 	}
 }
 EXPORT_SYMBOL_GPL(virtio_break_device);
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
