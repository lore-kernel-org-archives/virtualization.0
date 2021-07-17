Return-Path: <SRS0=6YK7=MJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06098C636CA
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783D9611F1
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 07:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783D9611F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E860424B1;
	Sat, 17 Jul 2021 07:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bIOJ-qtbwFfd; Sat, 17 Jul 2021 07:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 71CF0405C8;
	Sat, 17 Jul 2021 07:43:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B3A4C001A;
	Sat, 17 Jul 2021 07:43:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D6DCC000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CE3983A80
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ghb37IG7SAkw
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E2B983A5D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 07:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXIDNUsYDXFTrW9LjEXGjCRLQXnTS/JaJyjQleyjeEv9nXFLBUa1dAQL4ZKkTXBc2bObGIyi6g2775qZLX8gZUF0CyskS288MvAPuau3FxILTubqOEEU+W5qKs1RjFS7thsrB8g6gNVHlmF57wL/M8AHcjcsFBnX9FmYfmsUtDKQnpf4dmW8Nhd2DqrZ6oliBsy/imXwwhOUUUTGZsT2c55OauHdxpN/hjmUh+BlNcrEp+bXB2+KaA9Bef7bxPNVXINt3JXUMY+sRtOZ6G1Gb1V/tmgeVqI36XpydBG2bOYafEmqUKvwLPHycEP79QtDaG8NqY7gVeVXK8WQHc96EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NojxkVQkkQZKEghli7TnGV1LaSVbRqDzVZKXGt5WaWI=;
 b=loCUV8uojzZDYev3da2S68ArE2o8lNhkMBiM6HcPK8+qriy06a0ULCPzJPKhbHavfSw8s6M3h1cPe5rNBoNIxBk38ueGxEItqziqU9Xa1OE8OPv8s8/vcRr1Nss+NfTmwc801oC8c/BzTTCufjB/dDxnrkiA1fD/kZ9a7bjMM8cPONteyDyKA2RlsjQtt3lAV2Fc/I12d7evyYExaUNW0aJhvRLbz0nRbNg/q9gNMMvIRD6hcCUjaR3JRVQ5RH2R+M5ung3j22HQoOYnueS9RjfNltgdYfXmzhOjcuOpkMsRr4JPYrZpqfHYZgzpfHId2XYA91SROmogk5Ihm1FySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NojxkVQkkQZKEghli7TnGV1LaSVbRqDzVZKXGt5WaWI=;
 b=qCcdIIqXxbB2xqGNcDUzwC5acaSGtwCebHpJ0FXxX6PxfOLjS9hHwUxHjOuS0Q9yfkN266ZRZ2GExMz9KFe7mG/9tnaWi5lxVssqQo+Z6uBzfSo5L5P4YPZqarMaGcKx1kVbUoYbSscWHhGVrttQPgP5j2enqUgOtj2jAetslAc4ecdsAnSungTA0oN4bbLc5GSEm9VOEq4E3wbRKMjvLfwnahtuLIRKWslUdhr/xewUonuRASCxDiio0rLVr/XZ8xKnnEdR8gzVdsUT9HoGw/ctVURc+4OdGRlm/CqDHp59BjoBqEoW6k9kIjcQlfA49fkmeB/yGi91xyl+eV/w8w==
Received: from MWHPR22CA0062.namprd22.prod.outlook.com (2603:10b6:300:12a::24)
 by DM6PR12MB2777.namprd12.prod.outlook.com (2603:10b6:5:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Sat, 17 Jul
 2021 07:43:13 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::84) by MWHPR22CA0062.outlook.office365.com
 (2603:10b6:300:12a::24) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 07:43:12 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 17 Jul 2021 07:43:11 +0000
To: <mst@redhat.com>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH 0/4] virtio short improvements
Date: Sat, 17 Jul 2021 10:42:54 +0300
Message-ID: <20210717074258.1463313-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cbdcbd5-3f63-47e2-7068-08d948f687c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2777:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2777F5FB71AFCDF043CB063DDC109@DM6PR12MB2777.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+crnHgaG5uMPLNT0OsqvaK51qQ2wrAESuzi4HLyR6qrsMhi8/4s9DFVxKiFZjr2XhHlXG8jC/d6vVmj9ykLKzpVgeMHsX8WXIhkeGnqWYzjy5cX4ZwaiKAr8dRG49GkSAKYrwyhYyK3FmkLFni7OCHq+nM5mta+bVftI8+bOzJjOkXorwo8vECGggmq6MJP7sBG/FTiM3OX9dwMFixw/uyLlcnNuYPulxRRDlNAmPFfhpa6UMHjwyLTPfKTNCdB7aHvBdoxi6DkIv0uvKJw0Qgf7asUIvCDUYzNtU9BjA7RFrCDogLkN6+lEVnwEMFsq5QE3V7t58iZPUS1EZ7yRvliE870llceTDFa0l9uACWr+mNptbOkJCQBw/MRayDw9ft3nhtBdKoPdG6MJCHwenUJ/ywuhLOkfn6LNyGBUj4yiDWJpMeDyP7dgTPdMShtp+9CWnvsu3xC7D+TWjrwgAOEmypqFGVNGXwvMW5TrEoBGDLev/R3OPWU+e1u1IRZIAYl4/Sa4bRyFQpSt9/rR5KglrAajpm9qgG+bBBWzrTxoVWjnLNOpeisoeqKoXwIN2C6515Uba3C5sCk64Glcm2JRt8tnQy6QJUJrRLIXr9wefL0j2AbiKvwPVqal1+3ySM9YIEij9bF/ezlP8+vKjxBNnXszscHhDlv9obIQ0lmXrYu3ox6Bp5q85UlcSeNVlkkaiCfe3Y4Iag4gP/NhZxoRVf/OoD9+LajISmeikM=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(36840700001)(6666004)(316002)(356005)(110136005)(107886003)(70586007)(36756003)(5660300002)(16526019)(36906005)(47076005)(70206006)(83380400001)(4326008)(86362001)(7636003)(2906002)(82740400003)(26005)(34020700004)(2616005)(8936002)(8676002)(82310400003)(426003)(1076003)(186003)(478600001)(336012)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 07:43:12.5182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbdcbd5-3f63-47e2-7068-08d948f687c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2777
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

Hi,

This series contains small improvements for virtio pci driver.
The main idea support surprise removal of virtio pci device.

Patches 1 to 3 prepare the code to handle surprise removal by marking
the device as broken in patch-4.

Patch summary:
patch-1: ensures that compiler optimization doesn't occur on vq->broken bit
patch-2: maintains the mirror sequence on VQ delete and VQ create
patch-3: protects vqs list for simultaneous access from reader and a writer
patch-4: handles surprise removal of virtio pci device which avoids
         call trace and system lockup

Parav Pandit (4):
  virtio: Improve vq->broken access to avoid any compiler optimization
  virtio: Keep vring_del_virtqueue() mirror of VQ create
  virtio: Protect vqs list access
  virtio_pci: Support surprise removal of virtio pci device

 drivers/virtio/virtio.c            |  1 +
 drivers/virtio/virtio_pci_common.c |  7 +++++++
 drivers/virtio/virtio_ring.c       | 17 ++++++++++++++---
 include/linux/virtio.h             |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
