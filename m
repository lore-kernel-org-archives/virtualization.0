Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11284C6FD19
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 05:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78DB58226D;
	Fri, 10 Mar 2023 05:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78DB58226D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cXlChzsC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hFUq-2RcA_mZ; Fri, 10 Mar 2023 05:34:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E4B9681ED8;
	Fri, 10 Mar 2023 05:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4B9681ED8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE36CC0071;
	Fri, 10 Mar 2023 05:34:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACDC8C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87CB760B20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87CB760B20
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=cXlChzsC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H4yDkQLh11RO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B496260881
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::628])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B496260881
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afuuuoLCP5N02l+SOqGoJn2pbeOZ195fpygA71pkjSbY0fCde86OEMI8qh7N9C1m84k281UciVXnup3J1DMzvEm5sSqKrh9YW2K9ltoLDMg8y3680AhOnezTEZI6MsH0i2VHe3lCdfpoQ3ixYebVYXyXmG+NTvGWPJRRsZHxFv1/X6/WDOEOTU5cqfMQxMpyeCaPdDz4hFaiWqJG9/jWybWl2jxymnr5yqQCZOdz/jhgMyQpspcC2THoy6w0205SqUfFu+3KxE4Nivxkyo5rfDd6wHE9nkcASv7xOYAf0J+4SuQqe0yIFFSI3exWYyV5z8h6p/sUGeH2e40HkObTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldfJr1fk5FByGbwkxwCSA6PPc/jsF4k0GZ2CYl9Z7oU=;
 b=HoLOsEIzZGC/DfHzQhWiGxhZdUDOgqYUn7Ora2BndSKRZKBONV66TWz8k8NyLmMF6PtplQUfeWMZ7TJ8eCiF/3QpLpbABF9Yhud81Q3N+aTL+WgdV2M5uMy4YHKapUwnDpdVjNZLfaV15uqXS0ylf7eZxiVQ9VBu3B7Cl9XurdPNEo81W5MpKdwfpls+zOfhiFv7tp9LxSp8Sq4G+YsSNABQZOgsKZSjzPr3lQwdq6kbobCvTTgbP+SUZL9m2hVzu4S8MOGvi1MjKR+XUVwsYf0kTcajYk5PYBgA8PmsW4UYOrTSnv6R6pPk6/uf30GVfvhJvgLsyGzDn65Blufzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldfJr1fk5FByGbwkxwCSA6PPc/jsF4k0GZ2CYl9Z7oU=;
 b=cXlChzsCBellX/928bnFSy5CPcqFR8vZPnjNjyOqy0CjOT65jyz5G3vMK1WDqZPI61ANNv6Rkt345Zv9dL5iCuDQwoZeCH3uKs81i0rLe+DjjvUjWtalXwnaZlBwt+bmsRhw/23z0rd6N9X2SnFYnJz0vclO40WSbGM/+xs9kpaXHGr5BWadMKxVwYL9svNa/n3/7wkCAsy0cfIY+rS2RaYyTESQAZ36h48lRgrbkuDPl3/NWsU/c+JY8N+6afzrTFFb/tQlwbljuZAQMa8Ju3eVeYcOf5v2dwBvfv5Aj+VhN3FgJubt2ngJQeo33Bv03xcNfUN3E2V//cs04f2qtg==
Received: from MW4PR03CA0138.namprd03.prod.outlook.com (2603:10b6:303:8c::23)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 05:34:48 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::d5) by MW4PR03CA0138.outlook.office365.com
 (2603:10b6:303:8c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Fri, 10 Mar 2023 05:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 05:34:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 21:34:37 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 21:34:37 -0800
Received: from mtl123.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 21:34:36 -0800
Received: from sw-mtx-012-001.mtx.labs.mlnx (sw-mtx-012-001.mtx.labs.mlnx
 [10.9.150.40])
 by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 32A5YVo3007739;
 Fri, 10 Mar 2023 07:34:32 +0200
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 1/3] virtio_pci_modern: Allow non power of 2 sizes for
 virtqueues
Date: Fri, 10 Mar 2023 07:34:26 +0200
Message-ID: <20230310053428.3376-2-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310053428.3376-1-feliu@nvidia.com>
References: <20230310053428.3376-1-feliu@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: d60b213b-2226-4392-3015-08db212929cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbhRsFs8S+KlIZ5OsZ9rFR7LiWKMZpmtmc8yOT5uWVyxqJ5LokvGFzgq2iVXhAvCE8DmCiFF3lSo6C7P5lmAib/Su9xn+G8/oVQ+T3fp6EvO2hRSj31cW+ez+ek5ZG8NbUy2BaRh/CyAZNB+gGJYSTqan5gRO0NNMM0YkbXM5a0ECTdSZ9upJRzwfm8cU+mkktGbtBrmskqfdXt3h3/6GePF7flRyPOKMERw/jeuljL+Yo+y9Z5aZlZ2I+gX568IuT3rQu6hR6pNsqMRkhVj0sg/kFRILZJ+qEb4BA3dcGCKdVW3Oh4Qprbz3aiONAz2upL4/5HybwEd0Y/uBPq/uRRZ9+W4RTsMIW+UFk2BR2sNCWz3FtTIQP8/mR9qqqWetTAEmaobFLdNcmRLIl8PYyM0NXig3B8kP6JgQzI2XeV9pZwQUt3eLA0+9YgbrferkBqwLveXWEWC473E4aZF06UazbXnbXvS1++yVx1oXzXCi+B0jgPkJCOzPNT6hMkBrBijLSZn8QKWHQ6R6RlGXtul0Dm9hlZnWx+RHqY//wcuZ3v0omxuKW4+ig73Q2UYSOEmXAUdJjCqPmgdIiA+uqMS+rKYWLDC58SZ8mrzAfgMq8jOfuMpw1WjNl7MdQwMb18ukwlXhx6MxTCsO9o6Ef4H/RygomwEjrQGZxMq834TtuVfmtAtTwUFFrDFebquEB0nYN50Zy363vAH2kZvp7j4Xq0f668swsGZ8oH83SndOGhH1X1bBALVkUH4PmaE
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(336012)(47076005)(54906003)(316002)(40460700003)(36756003)(86362001)(82740400003)(7636003)(36860700001)(1076003)(83380400001)(82310400005)(186003)(2616005)(26005)(356005)(478600001)(40480700001)(8936002)(5660300002)(2906002)(41300700001)(4326008)(6666004)(8676002)(6916009)(70586007)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:34:48.0742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d60b213b-2226-4392-3015-08db212929cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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
virtqueue sizes, which is unnecessary and restrictive. This commit
removes that check, allowing virtqueues to have arbitrary sizes as
specified by the Virtio Specification.

To validate this change, we tested various virtqueue sizes for packed
rings, including 128, 256, 512, 100, 200, 500, and 1000, with
CONFIG_PAGE_POISONING enabled, and all tests passed successfully.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Bodong Wang <bodong@nvidia.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>

---
v1 -> v2
feedbacks from Jason Wang and Michael S. Tsirkin
- remove power_of_2 check of virtqueue size
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
