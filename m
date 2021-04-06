Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C712C433ED
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AAF611EE
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AAF611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7844D40F76;
	Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pr-Cpo2BTJos; Tue,  6 Apr 2021 17:05:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E46E40F89;
	Tue,  6 Apr 2021 17:05:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCF61C0014;
	Tue,  6 Apr 2021 17:05:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAD25C000C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90B7540F79
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R9EMShJISUxi
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::614])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1353140F76
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awt5O5i4UuIgL+98Av4PuXZO4YcHzDu6s1d6bdZJTnQYTlKIAjLCnf7PPl/e9ZTwuXxHXEoPsOL5pBltA79SVxH5QHIcHh3bZ7lEmcoUHfroKf4IqcLMKxqAChoRKfARvif45xF0rOGHHODm+nxMdKyrYYM6rGWX8Wbli/jPcS4T+W21PLKDGyXPxDkCrgDnaSAASN26ynbl+0ck0Xx1GwKiGgGyPRGNuKBh6yiGPs440YpMq09bHk2RA9fDnjY2ysQw8Bqzfs33ui65mIfr4v1k/4SCfbVwxa1ZPHJMKtGnql3sl5MMxi8LvUiPKVZ5E2kdu1UFBk1thSSQKeJiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfFgI/jdpATNPDt11N38iyE/e0Btf7VNpcOvtrxj26E=;
 b=aqJCnhdsfeudvrbWOaHBVzsA8vTYBUeOTj2SsjGrVX+QVljeF+1V0ORQAToLkEplYwnhpxu4kHW5JuJSeAld27UPuUQUoGVPaxxNV+80d0I/5yXrk07UUoqGrnjnFhQts2vvGh2UpBVpgVWl6g0qekRpu+ZIrra/DPL04GgGGXLBkvG2YXwZghghNArRY6G8jNR9mNXxBpEmkIJiAAAjwVljD2Cyd26LocZnUFkr6+O3W1foruMp6zf2o+x841ftPpJ7UeWZs4yai39lYwDGvOxfygv1FnjepiIZV4D+HwO7Eynda6rByvAqsOUJAJsJqVZomNkVK7HKpU/uODoUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfFgI/jdpATNPDt11N38iyE/e0Btf7VNpcOvtrxj26E=;
 b=qgbX5MgLZrUlMwuNjMbiB6q/C6swIF4UBgE2EVsMvg9/KIT5dDYDFDAqqHy/uc9rWcCQfG2fUnO3kx7/00V/PYgvqb8Z6Dr0qQi5KKaAw3+YIppeR+euhYpu9oxT67aRNXTiJs2YEH8O7sdlWM3efSHU648zfTuWBjrTQ9JmE4A13IuPNQ8g5QAzm0zEGEIYDNH7Fs1KxL/qG8mY1krTNyDEOQ679R8a1Z/NfZ1LzV+o5pGCaUl8Z+IB9o3QcLwyyt36X91JzoKRSXlj9aydzvHzUXysWaFotZ0c2iln1CNS0qznawd/nfbeGC/5ksM4U3qbRrSVFujALi3NTPp47A==
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 6 Apr
 2021 17:05:13 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ca) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:13 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:12 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 00/14] vdpa: Enable user to set mac address, mtu
Date: Tue, 6 Apr 2021 20:04:43 +0300
Message-ID: <20210406170457.98481-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63c4ab77-9f64-4197-c40f-08d8f91e24ed
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2766A8858C122A7C634D7C9DDC769@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFSlCDB/boJA1XzvPhTRaD6MRTq5gAewVLyDmTUl0uW6Szdzu9sqGcSP5luPw9bPVgcrEV/s9a8X79uQaFKzZKu28JxouyQsgastXIUQFEFJ3wxsrUjHcDaVtteZSMuydoVrf7lNuHvrduw9eWQhvNiYedtAeEi/Y6UX5wSYvYggyEUSNqz33fIc5zh6c/zh53Ry1vERkKWkrHB44dURg67V/bwnyguhrez6fA6pm8hNc31VnInaik1oep5IShLKmCg0iXeumm68NFVdxFnErlJc6+Pnwjn/URLfw8e+VWoUSvHtba319rbx1Y7jxJ7TKj8MrES6fm0Tgwwxe/RJPj7/HlIBWAiPdKxSX/o8/4P2DK5PCuBQFoAb8vbgI4eloDJi/n7B/0+8H1ACPIz5R4HG8mbUo11QPKdggU+DwMXoIc/IuVSENZ8KOYCenGJgStYAGZAEaChFOux92GXYFz8S4B2EW0dSZ9HgZSYtHtFW2oonNMta0FExqyMfPrbtbgVc3hVTWlLICzwDdvnWkMZZzANZ/8hCNxZ8GH6ZRlGz2VgwD8SBTzpNsjwsLnTXRtjNEnO81VQmB11wLtcoDs0otvkSZD31hKqe+5BKsGpDepJN0Aks0xYWDqKXIOhsBfX38F2jr0NQCLini94ONA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(16526019)(426003)(4326008)(6916009)(2906002)(36906005)(2616005)(336012)(47076005)(54906003)(86362001)(107886003)(6666004)(82310400003)(186003)(36756003)(8936002)(8676002)(70206006)(83380400001)(70586007)(356005)(5660300002)(82740400003)(7636003)(1076003)(316002)(36860700001)(478600001)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:13.4993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c4ab77-9f64-4197-c40f-08d8f91e24ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Currently user cannot set the mac address and mtu of the vdpa device.
This patchset enables users to set the mac address and mtu of the vdpa
device once the device is created.
If a vendor driver supports such configuration user can set it otherwise
user gets unsupported error.

vdpa mac address and mtu are device configuration layout fields.
To keep interface generic enough for multiple types of vdpa devices, mac
address and mtu setting is implemented as configuration layout config
knobs.
This enables to use similar config layout for other virtio devices.

An example of query & set of config layout fields for vdpa_sim_net
driver:

Configuration layout fields are set after device is created.
This enables user to change such fields at later point without destroying and
recreating the device for new config.

$ vdpa mgmtdev show
vdpasim_net:
  supported_classes net

Add the device:
$ vdpa dev add name bar mgmtdev vdpasim_net

Configure mac address and mtu:
$ vdpa dev config set bar mac 00:11:22:33:44:55 mtu 9000

In above command only mac address or only mtu can also be set.

View the config after setting:
$ vdpa dev config show
bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000 speed 0 duplex 0

Patch summary:
Patch-1 fix kdoc style comments
Patch-2 fix kdoc style comments
Patch-3 introduced and use helpers for get/set config and features
Patch-4 implement query device config layout
Patch-5 enanble user to set mac and mtu in config space
Patch-6 vdpa_sim_net implements get and set of config layout
Patch-7 mlx5 vdpa driver use right dma device for PCI PF,VF,SF
Patch-8 mlx5 vdpa driver uses right BAR offset for SF
Patch-9 mlx5 vdpa driver migrates to user created vdpa device
Patch-10 mlx5 vdpa driver supports user provided mac config
Patch-11 mlx5 vdpa driver uses user provided mac during rx flow steering
Patch-12 mlx5 vdpa driver excludes header length and fcs
Patch-13 mlx5 vdpa driver fixes index restoration during suspend resume
Patch-14 mlx5 vdpa driver fixes bit usage

changelog:
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

Eli Cohen (7):
  vdpa/mlx5: Use the correct dma device when registering memory
  vdpa/mlx5: Retrieve BAR address suitable any function
  vdpa/mlx5: Enable user to add/delete vdpa device
  vdpa/mlx5: Support configuration of MAC
  vdpa/mlx5: Forward only packets with allowed MAC address
  vdpa/mlx5: Fix suspend/resume index restoration
  vdpa/mlx5: Fix wrong use of bit numbers

Parav Pandit (6):
  vdpa: Follow kdoc comment style
  vdpa: Follow kdoc comment style
  vdpa: Introduce and use vdpa device get,set config, features helpers
  vdpa: Introduce query of device config layout
  vdpa: Enable user to set mac and mtu of vdpa device
  vdpa_sim_net: Enable user to set mac address and mtu

Si-Wei Liu (1):
  vdpa/mlx5: should exclude header length and fcs from mtu

 drivers/vdpa/mlx5/core/mlx5_vdpa.h   |   4 +
 drivers/vdpa/mlx5/core/mr.c          |   9 +-
 drivers/vdpa/mlx5/core/resources.c   |   3 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 264 ++++++++++++++----
 drivers/vdpa/vdpa.c                  | 383 ++++++++++++++++++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  26 ++
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   4 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  39 +--
 drivers/vhost/vdpa.c                 |   6 +-
 include/linux/vdpa.h                 | 123 ++++++---
 include/uapi/linux/vdpa.h            |  12 +
 11 files changed, 752 insertions(+), 121 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
