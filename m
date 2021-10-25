Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9568C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1F360E97
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A1F360E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5818C80DC3;
	Mon, 25 Oct 2021 12:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdWi8My7zhDh; Mon, 25 Oct 2021 12:53:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D94EE80DC4;
	Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 644F4C0023;
	Mon, 25 Oct 2021 12:53:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39F99C0021
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CFE94005C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mxNTvzZlDQ3e
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C067440265
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSDqNQ7Hm94vh2EgM+HGyE4r3A8O/ybqG88SYDJKrkKkEPelpXiiOh1iORmXd/W7Hl/BvpsPUTjopyNMnl/WkRGLhCkz+87SvNNDkUsMgMSXZRojpsuGyGAPLr/XlPvDo2Z8uv90DgFugTkXwLyoOPFgJaduOfntqJu+GW1rFb0gGzCOvKFPiJd69tNPQjCZoKfP+QHYmpk3wJGZ+u7x7z/Ar8Af3RiN6EZzXCcemZi7QYNDS9Ilap5YKjFYbxYn48rORbD1zoXYNDLcwO9+VCU0N6efOYUS+f6jjAR8sQen1Q9IFOtdM2LpblC2EbGuXK1zkcF0I2W9sPos55QaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0KDBgvwJSpDdAo0g7rEzVVVIMvw1AoYdY+5mXNLS1E=;
 b=BY/C1NoYfSNT6YzzDjbr5p0MufXqE8Xxhuyx5TR4EEtyUzENurKJQpDOBmyMO8aKBm89QfoYxJ1aJUctUNefxX+Nh0X/fSpE4/xZLCTVbxgEXgpfFcHkO33R5qhBtUSHqESGLrFTPvYZfMmyiFqzixnYmq/+TYosfOrFiMMOAF7IMUE+KteniY9aojMaymKAf+hKHnp9QMr9Y92Nj3t4lXzxf+rX/MmigamdSiPdPeqA3Xq+RdFF1BGebjCJCXj7mcVpuX/YQJfPgawHKJhIkaAB5rmDBD2ah09peNkmARslPDxvrWrf8L9DnGCk6msjJRnDfl7NoV39H3cOkmmNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0KDBgvwJSpDdAo0g7rEzVVVIMvw1AoYdY+5mXNLS1E=;
 b=nQkvtD8qBXvn4yWwHBDi550Em37aPSFSjKJ+h2yW4tvGTaA8hk3uUR4ThgAVEJC2KzPkyYRa/G+rPv0Ar60do2scxanm4GCWIUjPo3tg0Dnikw1XKrGAqAZlklOLWBtIbotBmUwccwQpSdZkknN9vYiyWsRd1b4T1W/e1SQUQ+yXsPHo3yWRLHhUnLuVlaXpzXOMgku7eEEBwjmWy6Rr9VPN1qFKN0XcDj6Hx17CvjmMWiAFQNpgQ38h7jFXZgTHqB+2y/Zw+fz2s70WS9xkMP3VgKA6S+x2yxouuWz5lzB5pZJCjVVBHE8tRvL04mINjnjvCKuW7QYDT3wmKRQbEw==
Received: from MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) by BY5PR12MB5015.namprd12.prod.outlook.com
 (2603:10b6:a03:1db::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 12:53:31 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::e8) by MWHPR1701CA0008.outlook.office365.com
 (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Mon, 25 Oct 2021 12:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 12:53:31 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 25 Oct 2021 12:53:29 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v5 0/8] vdpa: enable user to set mac, mtu
Date: Mon, 25 Oct 2021 15:53:08 +0300
Message-ID: <20211025125316.67664-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a287a51-3fee-4b77-98a6-08d997b672a6
X-MS-TrafficTypeDiagnostic: BY5PR12MB5015:
X-Microsoft-Antispam-PRVS: <BY5PR12MB50156CA3174C001BCC7A9BE3DC839@BY5PR12MB5015.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6ps+gFfEAPa2tN5rWd87o4IzaJPaawqgCyp8EqCT+mTR0EU1nmvayIxksSm8S79JnNcGNNbnLJMME0yuQGPZ+w2s3dPmriIET7lCi3cgcz6ngHEuBXfWMArFz8qh9ZuOHYGhGWUdV15wxrzr+guTHvq8c5rynrDLJpEFPmk3jU+dKft08WX2ueVHI5z5h9Lu6F5J1KBuvIfBh4E7amGGBZ/LSVXGu+ZZLAXGD2w4aAs9wouOiktboNx9Ir9o6XQjjOmztB8ougFpgvgtBjq7+QdRQt3nRv7Bh64PtOCPqn5OmIp2shJDT3yJOQd5V942msrvFz0cCmgEg55InAJR381tgXc2j76xts1ltjlci4zQlcprKlGx1Fp4CkkLd9SRDd6Ie3vmeNhgZHTb1tqVfq6oqMvSyggw1Bo3nqI/LcDIzLAQLgQu2fOdWh1/UeXPhjlcZy3mPxX1joYhbvtyf/xixI0nYXKmN+WO9UE1H63ILCBySG/1xvegBWRbfQQULBSmsq5C3nthQUeTzUEHoZX4oqVZlG16QNLTXCq/ul8jPtHBCLVfBboqSrpU31FTIk8032Ba7MVz7aELheTokB9iGImPejxqIV+mJOgT4zdbddTpJIkKPPPGGkNbjTOiaLVGVH9R5UHXE03fZIqwD5kWP2KONSX9wPdwiiMzwcBx3VVFbhKWQW0e2uBP5euvJQzNUJbNaXTIY7NKFKtPw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(107886003)(2616005)(426003)(336012)(6666004)(2906002)(316002)(54906003)(186003)(5660300002)(1076003)(356005)(86362001)(6916009)(47076005)(508600001)(36756003)(36860700001)(16526019)(8676002)(70206006)(7636003)(4326008)(70586007)(83380400001)(26005)(82310400003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:53:31.1709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a287a51-3fee-4b77-98a6-08d997b672a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
Cc: elic@nvidia.com, mst@redhat.com
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

Currently user cannot view the vdpa device config space. Also user
cannot set the mac address and mtu of the vdpa device.
This patchset enables users to set the mac address and mtu of the vdpa
device once the device is created.
If a vendor driver supports such configuration user can set it otherwise
user gets unsupported error.

vdpa mac address and mtu are device configuration layout fields.
To keep interface generic enough for multiple types of vdpa devices, mac
address and mtu setting is implemented as configuration layout fields.

An example of query & set of config layout fields for vdpa_sim_net
driver:

Configuration layout fields are set when a vdpa device is created.

$ vdpa mgmtdev show
vdpasim_net:
  supported_classes net
pci/0000:08:00.2:
  supported_classes net

Add the device with MAC and MTU:
$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:66 mtu 1500

In above command only mac address or only mtu can also be set.

View the config after setting:
$ vdpa dev config show
bar: mac 00:11:22:33:44:66 link up link_announce false mtu 1500

Patch summary:
Patch-1 introduced and use helpers for get/set config area
Patch-2 implement query device config layout
Patch-3 use kernel coding style for structure comment
Patch-4 enanble user to set mac and mtu in config space
Patch-5 vdpa_sim_net implements get and set of config layout
Patch-6 mlx vdpa driver fix to avoid clearing VIRTIO_NET_F_MAC during
        reset callback
Patch-7 mlx5 vdpa driver supports user provided mac config
Patch-8 mlx5 vdpa driver uses user provided mac during rx flow steering

changelog:
v4->v5:
 - use vdpa_set_config() API in virtio_vdpa driver
 - make vdpa_set_config() buffer argument const
 - added comment for checking process capability
 - updated commit log example for add command
v3->v4:
 - enable setting mac and mtu of the vdpa device using creation time
 - introduced a patch to fix mlx5 driver to avoid clearing
   VIRTIO_NET_F_MAC
 - introduced a patch to use kernel coding style for structure comment
 - removed config attributes not used by sim and mlx5 net drivers
v2->v3:
 - dropped patches which are merged
 - simplified code to handle non transitional devices
v1->v2:
 - new patches to fix kdoc comment to add new kdoc section
 - new patch to have synchronized access to features and config space
 - read whole net config layout instead of individual fields
 - added error extack for unmanaged vdpa device
 - fixed several endianness issues
 - introduced vdpa device ops for get config which is synchronized
   with other get/set features ops and config ops
 - fixed mtu range checking for max
 - using NLA_POLICY_ETH_ADDR
 - set config moved to device ops instead of mgmtdev ops
 - merged build and set to single routine
 - ensuring that user has NET_ADMIN capability for configuring network
   attributes
 - using updated interface and callbacks for get/set config
 - following new api for config get/set for mgmt tool in mlx5 vdpa
   driver
 - fixes for accessing right SF dma device and bar address
 - fix for mtu calculation
 - fix for bit access in features
 - fix for index restore with suspend/resume operation

Eli Cohen (2):
  vdpa/mlx5: Support configuration of MAC
  vdpa/mlx5: Forward only packets with allowed MAC address

Parav Pandit (6):
  vdpa: Introduce and use vdpa device get, set config helpers
  vdpa: Introduce query of device config layout
  vdpa: Use kernel coding style for structure comments
  vdpa: Enable user to set mac and mtu of vdpa device
  vdpa_sim_net: Enable user to set mac address and mtu
  vdpa/mlx5: Fix clearing of VIRTIO_NET_F_MAC feature bit

 drivers/vdpa/ifcvf/ifcvf_main.c      |   3 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  97 ++++++++---
 drivers/vdpa/vdpa.c                  | 248 ++++++++++++++++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  38 ++--
 drivers/vdpa/vdpa_user/vduse_dev.c   |   3 +-
 drivers/vhost/vdpa.c                 |   3 +-
 drivers/virtio/virtio_vdpa.c         |   3 +-
 include/linux/vdpa.h                 |  47 +++--
 include/uapi/linux/vdpa.h            |   6 +
 10 files changed, 382 insertions(+), 69 deletions(-)

-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
