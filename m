Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EE2C49EA3
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4C3613BF
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4C3613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEB5060A54;
	Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WwA51AW8N9nl; Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6760E60B6F;
	Wed, 16 Jun 2021 19:12:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05F0FC0025;
	Wed, 16 Jun 2021 19:12:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8E7AC0025
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E861E405E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ipd1vKu_p8Nc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2F4B40641
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=octC4vFvZy3GUMpBK7VNLA1A5GtnjaK7MSN5kOb0qaLM6eyRrQY+ZJzlemIN/DqcZjpXPCw6ukGIJexkaiWEaTbjg1mlZba9jjkQ8Y/+UikuoBEUbIVr1gf5b9fYqURUAFa7MvivAv4393gMF73A7loJ0s2jvqQzJbQalfqWOykvgB0T/Y6SmcwTBDONP3pGrxdhOkPe9iNQultYVHN/qi/fJE6OdTd9HhvidFIHomprqH7vTouSA6KjYfgcNgAYEoKBy7XSb6B7SciN6Rjsqd1/3oK/ESDjrFrd9bKrD2JKZlJrCxR5WEKdHTPGKVg+X0tOPuUr5SU+XDaW3ZG+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sV2cStlC0hobV2IYbB0y9agueGPp0ygtjcu75Y+JBE=;
 b=NpCLA21QEQB467jPNVRCu9flWf1znG4/0Zo56/VlztzYDTLnLN+OjeKma77bCHaGFeuKfY6+yWBPfcw+F31Bpz2Xwnsl9pmIcwlpYZdwfglBnNtu0NuTxsXulkA3NeXQBkbKKXpRvnNUNDS+04AsUl4lFQRInoPEhuwi/u3AROGLKkeg5CJyOAjxyu4TZz6yNEauT/3mlbTfYYee1aa0Om/S7XsUuALjoBDl7/UDAdF+c7kVCsEyZTIDeLpSOzuGCgw4GCiXDga5q5CCQTg6hbb5AlUFxCwEtGkqbGlEYo28s6j50MZdFI5emg0rzA9gRVJhPUxCw74bbyPxyjTeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sV2cStlC0hobV2IYbB0y9agueGPp0ygtjcu75Y+JBE=;
 b=YZyoodJtOkpo1ADvB8dkETZMAJ1UAgftJwoFZ+9Qfd4uilzzpIfN1vSFVAUtWmTOJtBNvzjnHXJg40m3YX7g6B9AMgRh0lGSzQJvakKgk74ObnJh/wFMcZd1NxLxJpx4hkF/6pDmmc9lyMHbXLXZ1b6UWtjGYXv+bEQqr0lfdQckAR0aU/XgUFXeyRvsOntiUojfoMnZLpmlOj6rkHTb6a9l/cleng+kT78kkflIHtfZNxBuQfrYDXNK+GD4QYt0kPpwWt2GoMfjRcWZnFZnltbcRZsJQAItgWrDzhh6nDsVMv3qb0oxYXbgBy0wFGrblHDsIqlFcLCwQpq15Uts2w==
Received: from MWHPR22CA0063.namprd22.prod.outlook.com (2603:10b6:300:12a::25)
 by DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Wed, 16 Jun
 2021 19:12:13 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::68) by MWHPR22CA0063.outlook.office365.com
 (2603:10b6:300:12a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Wed, 16 Jun 2021 19:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 19:12:13 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Jun 2021 19:12:12 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Date: Wed, 16 Jun 2021 22:11:49 +0300
Message-ID: <20210616191155.102303-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af7d30cc-65bb-4e2c-828c-08d930faa5f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2668:
X-Microsoft-Antispam-PRVS: <DM6PR12MB266841FC1B2AFEE8D727BE88DC0F9@DM6PR12MB2668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyM7wrUJ2AKzqs90BtOwFsgUA7zOkYFDspMYa+aZ1uphga3bY6S3TDvzQr3LGw/MdhewHb5dyt0n9QCNnYD938xml7JRs42W8zl1aja9FR7piFDl2/FJ4hgwyTVu8jzYGI/EgQvwFgNqUB7T/YOnk1fZ/6ZwgadGS+Gc3bSiYPC3Fo/KSwJ7czlKTjjzsSOo9dcdtXpDfZRtcvcc/Xex8PG3Wne76apwEk71uBodaxxBl3Mf98VaLFcfoeoiJqGx/RqeRKIDx6Ztrzjh0qzs/8PATveWJaf2F/sLltUt4puU41GM7Bdy64DyAsKE3x3q79WFNVygr6jvwCHw5zkuPvVN52TUJHbUOa6SPWSZ91TyjkaSpFf3j3lt1o9vvTVcnA77njPrd4iHV8/KvxWzVcGrEbui/UFpTH4ugXZeGONrlcW1TgvM2e+ds/enczNzxbby3qnOdjBx19Pnl8vrabe6ZggKd7mS7Sy7ojpXOQY7hlesuvkL+/YfxH4Lxlw5mwB+tmH9Hn8p9DdZHrSVYK2mFibS8vP5q5alyNeKit41MNbvDFeIUONSS8qHVI3Wx9oSWH/ARSh3qL5bfNvsgnNs2aJtOqcyKDq2DKNpE6P+NPNCuIhVYwNvuJjes/uZ3xoqHRk2xVe9wqKSDbOaZw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(8936002)(356005)(36860700001)(478600001)(2616005)(336012)(86362001)(5660300002)(36906005)(47076005)(8676002)(426003)(70586007)(36756003)(82310400003)(83380400001)(82740400003)(7636003)(1076003)(6666004)(316002)(107886003)(70206006)(2906002)(16526019)(6916009)(26005)(186003)(54906003)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:12:13.2284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af7d30cc-65bb-4e2c-828c-08d930faa5f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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
Patch-1 introduced and use helpers for get/set config area
Patch-2 implement query device config layout
Patch-3 enanble user to set mac and mtu in config space
Patch-4 vdpa_sim_net implements get and set of config layout
Patch-5 mlx5 vdpa driver supports user provided mac config
Patch-6 mlx5 vdpa driver uses user provided mac during rx flow steering

changelog:
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

Parav Pandit (4):
  vdpa: Introduce and use vdpa device get, set config helpers
  vdpa: Introduce query of device config layout
  vdpa: Enable user to set mac and mtu of vdpa device
  vdpa_sim_net: Enable user to set mac address and mtu

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 101 ++++++--
 drivers/vdpa/vdpa.c                  | 337 +++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  13 ++
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   2 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  34 +--
 drivers/vhost/vdpa.c                 |   3 +-
 include/linux/vdpa.h                 |  38 +--
 include/uapi/linux/vdpa.h            |  12 +
 8 files changed, 490 insertions(+), 50 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
