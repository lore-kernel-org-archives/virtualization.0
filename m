Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EEFC433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:55:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75F8610A4
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E75F8610A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A50BA403D7;
	Tue, 26 Oct 2021 17:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8oY3M8ETvjBE; Tue, 26 Oct 2021 17:55:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FF3F40262;
	Tue, 26 Oct 2021 17:55:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0787DC0019;
	Tue, 26 Oct 2021 17:55:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD54BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C021380F07
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tpHdzPlhJhJv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DD6A80F01
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdtgMXuBKw63GwxYJjQYMXeazjotAV7g9r1BRuzyD5hUmjqu2Znrgs47PEqSZ9vBlmStFE4W32HXvrQfAfszTnrCBx18C4WsFO1oj+H3H1LrCSorFNsZyod/RaXMfpLsjk+0Br/2EmK3WA9PocC/8KegVNCt2eifMgImAYwMSSZQxDmlNqvuceJcgI5dxWfWimahXar6cxikCE4hMdi4gd8CnPbagkundBGbsLb02cFgDUFtwEeFZXx76aqlyHcqFq9m4R99Tu9C5q2+lTBC+Ih5RfDkN1jrOnhdr0zSIvaNqq44brWggd6mJDWm2eva7EoIufaUTZ1IP9C1YMaZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4lY7FNYbYk+jPEjJu6t851DaAICaUEjde8MyQewgus=;
 b=D90BZvA8yPHmRUGfA+KpLR13xuHYsgivPdZdU19PLDedRFzHfhPZVHWjIKL7Dzy80axVQ5ydZMvAm4nmXVP59MIHnT7idoNhQjjh2vsnKIgy8lZBdJ+ySSX4V8LXFY4QasL3hZrVyh6lCUNTdW+LeMpeSKGmAVC74yonAgy8vdW8xli9D370ExjWvKhPjFspm0ol3lFVvW4vb1sjil9Os7w+PZiRNGUQXArRcg+xs8bIUTUteVPnLK4r6AyEj9kQ3uCl4dj5WcI0Nvb+h8LfYC0DqdyUDLE+cWl2g96ga118P6+3uZppPV1WXzMcbtHJ/Ur+0DSgar3kDNAQ0I/Rvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4lY7FNYbYk+jPEjJu6t851DaAICaUEjde8MyQewgus=;
 b=pHUh0TBjxGdwfKn28Hty5k+1KgZEiSGiYKYBg817WdApDYicEgR+H/zOO0dJ6Z3jFZoxjvMWo+7bcdrcqzr24DwZ8ldKGQBjO+/rxZRG4tDL5RRbEUNKsiGiPrRzbGQkKq3va3a5NmSg/r8x9FebLKF08LzBM7nVkYCQhOXV3z+tpPDW3hG6UlY671UIM2qu7QOHo+MnhT2Ue+oNaUversMH4xKpbd+cOofxeqC4er07ta6H9woIwdH0JpUuCGJ8uP0vZKW1yRbZ3hKgz6sQRFUfQUhpiXGhp8eXP+svvZOAC8Unq7942/N1HqR5CqpZvyPx7Z2NcD2P2CQ6shdsIg==
Received: from MWHPR14CA0035.namprd14.prod.outlook.com (2603:10b6:300:12b::21)
 by DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Tue, 26 Oct
 2021 17:55:42 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::df) by MWHPR14CA0035.outlook.office365.com
 (2603:10b6:300:12b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 17:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 17:55:42 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 17:55:38 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v7 0/8] vdpa: enable user to set mac, mtu
Date: Tue, 26 Oct 2021 20:55:11 +0300
Message-ID: <20211026175519.87795-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83344d8b-3a9f-4efc-5fda-08d998a9d3ef
X-MS-TrafficTypeDiagnostic: DM8PR12MB5478:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54780B37EAAB15A8529C1118DC849@DM8PR12MB5478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQR4xzHnpVKmiL26LcB8f3Z9wnShvZJNwiGnEQ90AcaJI114ROSDoXPpM24OoBhN5MAsx0pfVyh61F99GalyEwhw5buzw0JQyeUCDoCH+ADWA3D45Ad3ez1COIYFwi/7R4vWuiWb9HwaYnv2KXodKxwkcQbTZft3BihcItbbQ6p4SaPImdWG7yEWXRsnEiQCCkL7F+X3j+cZC+KZH8GhokqFau2+dO2UOPE0k0/SaZs0CGJTrAzHA4OF2GYnFzKh1KUlxvChlHy4E1cDQWKA9GGEEe582m+a0lJweA4IprgJvKhUJHlxiPV8mdgwQTJaxT1pqplTDB38YTnByyazYpyoZbRLkeCR0E9inEZ4hK6fe2Auko2Z/31XabR+WjvmNuEXlDsqOBhXb2w72Gygk1wyF+fpewtWbDYcNOy4L/CHVdF7dqkZ75a7p5gkfQ+WalghIj0hukrGCtb2tD769N78Q1ViWBOy3beDG1eZ+XW7WVASnOOrnhFLfgGmX+yqxOp+OMJ9uosCuIMYbcccHQ8O5hrBoUJYEV9byCS8e0rdUic5GE8y0n+Y2LmV3W/OIWuMWjFFNlKuHDs4lnbHqZo+DaFBQRFbQn/+7D1JGXu9XzpRKqHWNH39SJIyvic6Kfg1YUDnAH+wDjb29253oFC2LNpbtxFh4n80L/0FMT7anxlD8zZbSVFVp/aIYevA4w/y2iEdbCpgWXu0IA24iw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(336012)(83380400001)(186003)(82310400003)(107886003)(1076003)(70206006)(70586007)(356005)(36860700001)(86362001)(36756003)(508600001)(7636003)(6916009)(8676002)(5660300002)(316002)(2616005)(54906003)(4326008)(6666004)(426003)(47076005)(8936002)(2906002)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:55:42.1041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83344d8b-3a9f-4efc-5fda-08d998a9d3ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
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
v6->v7:
 - fixed typo in device
v5->v6:
 - fixed mlx5 vdpa device mtu initialization during add
 - corrected example for vdpasim_net in commit log
 - expanded commit log description that fixes mlx5 _MAC feature bit
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
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  95 +++++++---
 drivers/vdpa/vdpa.c                  | 248 ++++++++++++++++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  38 ++--
 drivers/vdpa/vdpa_user/vduse_dev.c   |   3 +-
 drivers/vhost/vdpa.c                 |   3 +-
 drivers/virtio/virtio_vdpa.c         |   3 +-
 include/linux/vdpa.h                 |  47 +++--
 include/uapi/linux/vdpa.h            |   6 +
 10 files changed, 382 insertions(+), 67 deletions(-)

-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
