Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6FEC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0F961501
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C0F961501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A4C040860;
	Thu, 21 Oct 2021 16:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id theXiiIpAPUk; Thu, 21 Oct 2021 16:35:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B47FC407C5;
	Thu, 21 Oct 2021 16:35:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC33C0033;
	Thu, 21 Oct 2021 16:35:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B641DC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 981D340838
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fyvGIYrPSwPS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::615])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 727D1407C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I68tkc7qMswWvyBLffAk4lkNkFxo0lGTazeDf6ptD/j8jHYPEQg9aj0yFEIYMSxTVxVsitKkyHMpUYAjtHUBamCnZBUTt2XUaap3QXgx4EWfOegmYvqpeR+n1gNLkU1z3xzp/0uccubPNSGWzR5zBmikJeaXHj+KUJ/xu9qLzbsTCfGKwMXT+2BjysdGdVcHxTwSl1jBVCZU7FfIWpNu3Cyt3vCFF18iK2vg2YcZc+ZJu0d+1YJC5Fe2Ufh46ch+UqVl3EQc/jAb+OsOIR1rRV7asvWdm0K/2G+liPOswDqWBcFeXPxwolf4P5Z5w6jVZr5OSspfiWAQlutscKNlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJXoVJmKSeJKEocDzXQ59mLYJ7k4X2nr+klL93MjOqk=;
 b=Sxso4+nrcv2GgXyC2E2Zhlhvzv9Qq0he9EJweQkQOVUj8ZY/HB2INoyfuny0DxaTvNmICxfO0MmHedCZpqtxZshuImvukoF+nT2AK11lGiE9xHkxwVI6yALYTFJfZPGScBgDPFQJXiJ8lvzGjHoA6W6/u6FG2o9fGmKQgTC2ryja6XNGE9LXce5aSJ2+AEzSHMl2NBAWf/g/x+aByoLnmz+XunxZDoNFWvh/q4Qhtd+shI0hL0zrOfTqZ0t12CpST/lM7Hc/5U7CN/le4yftEP5LqXhpQMEMZHWKtTFU/V3oF3CTJ3A1Y5AZwm9QpksG5oB0bT7+7gk6yyJJ8/ZOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJXoVJmKSeJKEocDzXQ59mLYJ7k4X2nr+klL93MjOqk=;
 b=fUqpBNPv+HBPSyy4b3LfDClsHMsrPmMyPpFeZ7lbPOG8p/3JzPuYx2jKikFUX2LcrO+EzZBLF7bMqj6bqA3Xe8T/UhEBm+HJCrnmzqQR6ED5TCly05WM/3CjCzwnuRtKnhS97TAWXk53/ytDokXZCBdjkoRFFCgyOAWJLoc5HJuCxOBNiKA3woHDCL8iy9XzSR8EicfJz0ODhmNCJUas1TRl2ogVZf2u1Lq3bIlJPeFSREo2/Fx13A1+MhmAxN4kCmV/8tiUEte7h4ITVxCiCx06G+n5W/a0CwqovS5NB8VmH741dMuVk82uFpTsX3qyZeGOKFPDnxwdj3ySkdd4tw==
Received: from CO2PR06CA0071.namprd06.prod.outlook.com (2603:10b6:104:3::29)
 by MW2PR12MB2362.namprd12.prod.outlook.com (2603:10b6:907:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 16:35:25 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::41) by CO2PR06CA0071.outlook.office365.com
 (2603:10b6:104:3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 16:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:35:23 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 21 Oct 2021 16:35:21 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v4 0/8] vdpa: enable user to set mac, mtu
Date: Thu, 21 Oct 2021 19:35:01 +0300
Message-ID: <20211021163509.6978-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc96d17f-2777-4c2b-f326-08d994b0c7f8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2362834DCBC4443EDD9DF7A8DCBF9@MW2PR12MB2362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/1zxEHP8klA1Zf0la6qfix2CLUHb0VpNMGjGGe9SaVpSzs5rYz4Se1Ow8Ivg/6bKIE8tpWKp6RyWfjrOIzakGZRbaaHX2dEU0pEdRzH6PzI4FZKjChq5DwdgcjmjVSzY81Q2H8eD7te6d7KiGEJX3b81nHlKZBoWpSkzUzyqnvrK700aBDVWB5IAGUj7/F7sILK559IoXxcifjhmQlLDBJAC6ekYWnPCdOku57TUpBdabxFnEmD1EEl9ts5NmKeCVlVaS/tT8RbFX8sV21Cz9n9LRss7St1HZJGslHc8Lsbe/ZiFwOu8UjILB4Zy9TOc4jjxwDbeKh2Mo/8o0jlaZRcDLgATqYMBdue63i9JMQVPhsfvpDntPRmX+MuM3YNX2qM3JwmIJSrtxqUyew8PNRHDlgS6miKODed8Rh74LnrnK0ZosAIZBFpksEn6ISRFVZEEMCzHbHNzQcrcn38UEiXSCRR9iMPRtNmujKHvrQK67VI8Hi1wR75fHn8wNK4SoKcTxU7i0c0GBgfdDMfdfiGHtaJusknkKTsFn7Y65ZBzPf8YBp9kwZ4wfDuT/lfev4mtew870+a2vRf/wFd/qKWdjU6o1srquIyfktanmj7CfjDmDFWA/OQzytUVm5xGL7SIjAaBt+AipU2MHffmHLyzSgZxuxx0jw7+M/xpvSUufBlNo/AgCQZ3mmHGRUMbk4rCwhHVECxU066NewMXA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(316002)(36906005)(82310400003)(36860700001)(4326008)(47076005)(186003)(2616005)(6916009)(36756003)(508600001)(26005)(54906003)(16526019)(6666004)(7636003)(86362001)(336012)(8936002)(5660300002)(8676002)(2906002)(83380400001)(107886003)(356005)(1076003)(70586007)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:35:23.4424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc96d17f-2777-4c2b-f326-08d994b0c7f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
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
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  92 +++++++---
 drivers/vdpa/vdpa.c                  | 243 ++++++++++++++++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  38 +++--
 drivers/vdpa/vdpa_user/vduse_dev.c   |   3 +-
 drivers/vhost/vdpa.c                 |   3 +-
 include/linux/vdpa.h                 |  47 ++++--
 include/uapi/linux/vdpa.h            |   6 +
 9 files changed, 375 insertions(+), 63 deletions(-)

-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
