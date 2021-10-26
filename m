Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64A7C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9CC60EFE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A9CC60EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18C4F60774;
	Tue, 26 Oct 2021 04:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ryCCoGQmQQ3y; Tue, 26 Oct 2021 04:03:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A975C60736;
	Tue, 26 Oct 2021 04:03:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6956BC0012;
	Tue, 26 Oct 2021 04:03:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1043C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 836956075E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rHtmZOZj8kwh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:02:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D59C60736
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xok6HQEnuSf/jrzD+C6PP9iVGAGcs7a5ynGBhSRWqazin5bFyPctOdC/LkG8/K/0oYQXzpk9ezUQ5oqZ7MtuunNfs4sOFAzmkn+s9/oPCG6eX37/VZjJsBbpyz6446NPQQ3l/dZAVZvv9a49VJKFGdBdh4wlhfEjD46ObWx2XG/9Mzc/4s8yceQE2OPrJsKAYdwGlKzdbATDPNujJNqP9xvjmlouay3DuIlBrVhRyYFNMsazM1hltjIT0/aNz9a7/nIzFmlJlnyoTIvjn3mXNqXqFxWtgtoxwlFB5XYH9P7I1Lf0+TgUUV1Jcbsiezw8sOLPQaGjoI4Euw0vRCnJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTanfDwBPgKAwO2zb1yGWtMrWzPXD0bXJ7qrvFNihWc=;
 b=WJtO6fF1++lK3xfadF3wvBPNrUhGWHa6LYx+lasdLIhSEXKLeyWIhFYFcCUecpj+LkmA41pPWJj4JHXhdQDYFTKIznPhcu1n7YeNq071RSfOZGS4T1m4OftcGQbWLeEWt9B1UTeM6vJufNzxQl0oY974JWx4Oy1xtImqaBJRgYU/oKtRmUZI5U+RcCvcI/xlcKR8kvUpOd88KiCRBRZKtWz8vqTn3BGBJk34ofrv8Ctdo0G7vTLYD+/LSqxkmh08p4DxoIdWgCCpXtFIeL6KeEWeOZFu+leiwX+SBQ5tfC3LzXHG//1pnYaLb8GjVrqjL0WVtw3b39J+HSefYiwpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTanfDwBPgKAwO2zb1yGWtMrWzPXD0bXJ7qrvFNihWc=;
 b=XQzKtTXjC0YaHq1BIe+VOuMVbDyaLqWNTYymBuez8GxRnm8e+jUvgKnfNLSxjV6dMqpJK0Rm3NK+MqsGj15b9KnXnhm4k1jdlHhhkcBzaRPyFnQFw6+/TdaNekxGLWgAzaBiNTE9IKujJZsrbpbyUNr12q9pKvUwmat1dbnr/tM99dy7LE3QijIs6y+fVzIxLfqIVMDdX6qXAd+aGuHHtxT3fAi1KY1SfR/EvBZpEltUOj/4FUYhRshhZE6s252BDn7RePJnFbDqJcEZlVxF3njYhsikUfpmSSCk6TfWAp3YONGSlh5tpDpLHjd6+BIDpHV5OZjFQ1qk4pj1ZM49HA==
Received: from MW4P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::15)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 04:02:57 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::3b) by MW4P223CA0010.outlook.office365.com
 (2603:10b6:303:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Tue, 26 Oct 2021 04:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 04:02:57 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 04:02:55 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v6 0/8] vdpa: enable user to set mac, mtu
Date: Tue, 26 Oct 2021 07:02:35 +0300
Message-ID: <20211026040243.79005-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c8f8885-511d-4e8f-82ac-08d998357e82
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4219B767E7A6E8D1DFF45BA0DC849@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yU8XEX6T169kuWBr7iFnFz2Qu6GFI060WKZogv7C1i0eRdraZ+l+p2fDFWYenEEjJk0TAg+Iry4u91/iL17t+nP3jlDzT4Hnv53mB27ZWkiry+XjfvVqFflJrW5oF8iDSwLu1DWqAvB5mBRddtZEvrtRuuqAqRuoYtRCzYmNbrd7MizCVwPZgZF1gxk3BwGnWpxutOFTBOY91ldk0+A9UAkkfahGQI/L3vlnZL/SrpinZsK8Of+CAazKzqXNjIq4AqVnKaNRmRLrXwNcbhd+gyAdrB1cV/k0+5ZSPJHYhqLNZALV9UsiX3igDqcOVUVrLrkjLps4Y7y4CYg4jdV9HXCJ9+oocHD3wumM6dZVdKvNo1NgwW+c+99AJOd5SKH5tlszBLht75rqs4NClIUw08fTcSkg1HmimgabuLWLRffPzaMqZ5OOKmZcLlYufRfLHML5JBtO4X7Ctm6kUo1398CPeydDB0T3J6W6S+UaFkkF/w/ooPIXPDTmblE6OzDChkHdqAYrwAeaSVd364vgt1UeUGxirbvQCukHXFe3ztCp9bVdomBtJRqNe/B1L6bna0rsgby25B4IAibMaUaOGXetAw6iY2EKZ8mnS3DeAL5QGHeP2RctjDWdya2sz3BSbKBJyKhHu0hKB6c9SJ3tUZpL4lVu0gK10faTDHkzg1iEOOMoCsZz3cOsFmF70SrNIU8B/h1A/50dli/bK0URiA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(7636003)(2906002)(36756003)(356005)(1076003)(86362001)(54906003)(83380400001)(6916009)(186003)(36906005)(6666004)(316002)(5660300002)(16526019)(2616005)(426003)(508600001)(4326008)(26005)(82310400003)(107886003)(8676002)(70586007)(47076005)(336012)(70206006)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:02:57.1037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8f8885-511d-4e8f-82ac-08d998357e82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
