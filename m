Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEE5CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 075A24217A;
	Wed, 18 Oct 2023 17:15:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 075A24217A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kHb6UnbY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KSq2hoFhbIYE; Wed, 18 Oct 2023 17:15:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5415242148;
	Wed, 18 Oct 2023 17:15:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5415242148
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ABF6C0039;
	Wed, 18 Oct 2023 17:15:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A889C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 518DF40AF0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 518DF40AF0
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=kHb6UnbY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dKF57pr846gk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D42B440590
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D42B440590
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThqNc7TnddkKPsRzTgLMlKhVdf9K5CzAlErEvT6koHaBOL1lus4N6OV+MpWtZ99EOcN+IMW55OG4ACMf0zPRwBDb7zMvplmHEwKDRlRQtRvQObY9SX41YZGpix/EcUZx6DK57kXVc+25BDrzOWr6hf7fCxQmyURHTb/qa16F9O20xJa7uVvIPJoGelbJrU8/u9TWtygwD4BV/u5pjbrhLIoMHLYg1Hh2bfklAgtz24hZwNmul6ycSXpq4Bv33iQnz0E1+vENdRX3mWSlfPcqRmAkAjcwyyED9M65J0CqCBNZUR6v4OLc5XKKTz/7asvJPDJoap8sCRpLatiDz623jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfGraSspM/oHQTiyhRxKhCet3/em9Q+8FJClhoXEqcA=;
 b=e3a+u5TLS+W5Kz4LHE8aOGGNYj7OAmzP+paGK23kjFONOOTmAZFBuBRw9/HiBTBtGl4O7o9kEu77ucSZ6xUgGUfpbkzFwpH1TG6WRWZnXpkkdZHEczZm6NVY+hMD9vhqmAAhox0gi9irCvnU5RnBCrGCC6KbnBRop0caciFibRte8NkP0btjc7qX5fQzzmqElEvgk+en9C2WkNp3jIhVxEwgNXxAwfcsUc5GYYZ3ZNXAmmZOhrgydtUb7CMoqlq4ZDpkZxoXHYhCFpEB8vNB56gedVcObNH/WbzZId1h2/5EsNxn3HHb3X/IHM/MzOlgo1W0YodNE/1GsAlzParSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfGraSspM/oHQTiyhRxKhCet3/em9Q+8FJClhoXEqcA=;
 b=kHb6UnbYaTjhkBV4Plv/gn4Z9tbzHYSirvvcBl9/pdo1NNvRyiESiT56rTd9NiN+9Idj7AHlawtshGWyOM2p+RdB/7sojecnZ8SJQzROprkZpWmYvG1R7ex8A/Hiq/1KFOeN0CFOVRFh6mH6ehhSLGYZWHXHnqt8EkO+fr6DPlKFs2VKYBD1b0g7zXuH9G4vqhFb313Uxb7Zv2RaSmHy1ou0Kp3zZ7jEpNYV6UYmVR1OmN3CTF7Bjypf221Cu4DHBUFr6+sxtTywImP4PsAEkvZewg+w6QFbard4Ht15RPsGX3ZC3sqOnME/B2DcQ0icnnks3QuMtfwDyE8E6nIAfA==
Received: from SJ2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:a03:505::11)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Wed, 18 Oct 2023 17:15:45 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::e9) by SJ2PR07CA0001.outlook.office365.com
 (2603:10b6:a03:505::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 17:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 17:15:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:25 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:23 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 00/16] vdpa: Add support for vq descriptor mappings
Date: Wed, 18 Oct 2023 20:14:39 +0300
Message-ID: <20231018171456.1624030-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: a99136f9-b9dd-4dbb-8038-08dbcffddd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/AXFxamzMis471aawRMtJTAGRofSof4+fq+PJpFfr9jXntEOrqRbh8QGMl8KuZl/7W5qqSVYkz9xiMvSmRKRxi2PmmfQG5Ohqkmihg7SZEvLIC7wNsrG0cURj4wHXRSG8GrzMut1N7aSSQcG7HO/3slIiKw99ICd3x9R6PrJO8XKx7Sv1yQQmn5t1onRm1YW/BhNXwkH5xtMePxz9lRAem+dYo48SdTlhNluHy/mGgFQxCDEE6QP0CgXccR7dixgOHK9lcciyY+g3nYvVX3lQeT5JwP3NmwubNnadkNKV3DtbaD9HSsq/K5uU/tZ3DySGhCl5qgH5wuPMg0mKjIjnSs2Mq95nJ7HSKOK4uk0MMnwunZRhsp5CMFwixnaMuVJcGuZo+jNVwGD7Z7xZgeZQvDrTGcU/nbtVDLf7z1YwghRI8hmimRydXVO9S1cwdH0f7bkqz8a8FnX92vXEAqOy4/SVyrGXRgPju66j6RlNkvG0KxQzoyz3sYLvVujyMUNd1/2kgwOqPiU6zRZt06dz5rJ8/b2mbjWO2iQSHuiE5d9nDMuCUi+ZuyVVlHMexYH+oS4nK7sSDhvNpbDqDmenn0Cmoe7dIeF4aDNjx8eQbD+2qcp8H9MH/a3jRQlSu52EXpAri5hGBom4/BcI9FQE6w35J4J7zCKNeYKUcwhZV/RlF5DAjTSdf7e4n6r8ozAD09hpHaXg0+l6etuslW6L3tamDbjyQEYpuZu4UPiENTYLyjArg+GUgqsR9LB7cOUwDaxv7dhkmDTANBkNjEWTG5gm77Vtusl9rdJYPPl4c=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40460700003)(6666004)(2616005)(26005)(426003)(8936002)(966005)(1076003)(83380400001)(336012)(36860700001)(316002)(41300700001)(4326008)(8676002)(5660300002)(47076005)(2906002)(82740400003)(478600001)(70206006)(54906003)(110136005)(70586007)(86362001)(7636003)(356005)(40480700001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:15:44.3683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a99136f9-b9dd-4dbb-8038-08dbcffddd1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This patch series adds support for vq descriptor table mappings which
are used to improve vdpa live migration downtime. The improvement comes
from using smaller mappings which take less time to create and destroy
in hw.

The first part adds the vdpa core changes from Si-Wei [0].

The second part adds support in mlx5_vdpa:
- Refactor the mr code to be able to cleanly add descriptor mappings.
- Add hardware descriptor mr support.
- Properly update iotlb for cvq during ASID switch.

Changes in v4:

- Improved the handling of empty iotlbs. See mlx5_vdpa_change_map
  section in patch "12/16 vdpa/mlx5: Improve mr upate flow".
- Fixed a invalid usage of desc_group_mkey hw vq field when the
  capability is not there. See patch
  "15/16 vdpa/mlx5: Enable hw support for vq descriptor map".

Changes in v3:

- dup_iotlb now checks for src == dst case and returns an error.
- Renamed iotlb parameter in dup_iotlb to dst.
- Removed a redundant check of the asid value.
- Fixed a commit message.
- mx5_ifc.h patch has been applied to mlx5-vhost tree. When applying
  this series please pull from that tree first.

Changes in v2:

- The "vdpa/mlx5: Enable hw support for vq descriptor mapping" change
  was split off into two patches to avoid merge conflicts into the tree
  of Linus.

  The first patch contains only changes for mlx5_ifc.h. This must be
  applied into the mlx5-vdpa tree [1] first. Once this patch is applied
  on mlx5-vdpa, the change has to be pulled fom mlx5-vdpa into the vhost
  tree and only then the remaining patches can be applied.

[0] https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-email-si-wei.liu@oracle.com
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost

Dragos Tatulea (13):
  vdpa/mlx5: Expose descriptor group mkey hw capability
  vdpa/mlx5: Create helper function for dma mappings
  vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code
  vdpa/mlx5: Take cvq iotlb lock during refresh
  vdpa/mlx5: Collapse "dvq" mr add/delete functions
  vdpa/mlx5: Rename mr destroy functions
  vdpa/mlx5: Allow creation/deletion of any given mr struct
  vdpa/mlx5: Move mr mutex out of mr struct
  vdpa/mlx5: Improve mr update flow
  vdpa/mlx5: Introduce mr for vq descriptor
  vdpa/mlx5: Enable hw support for vq descriptor mapping
  vdpa/mlx5: Make iotlb helper functions more generic
  vdpa/mlx5: Update cvq iotlb mapping on ASID change

Si-Wei Liu (3):
  vdpa: introduce dedicated descriptor group for virtqueue
  vhost-vdpa: introduce descriptor group backend feature
  vhost-vdpa: uAPI to get dedicated descriptor group id

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  31 +++--
 drivers/vdpa/mlx5/core/mr.c        | 194 ++++++++++++++++-------------
 drivers/vdpa/mlx5/core/resources.c |   6 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 105 +++++++++++-----
 drivers/vhost/vdpa.c               |  27 ++++
 include/linux/mlx5/mlx5_ifc.h      |   8 +-
 include/linux/mlx5/mlx5_ifc_vdpa.h |   7 +-
 include/linux/vdpa.h               |  11 ++
 include/uapi/linux/vhost.h         |   8 ++
 include/uapi/linux/vhost_types.h   |   5 +
 10 files changed, 272 insertions(+), 130 deletions(-)

-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
