Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8778C64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 05:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6010260F67;
	Fri, 10 Mar 2023 05:34:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6010260F67
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I4XkPZIg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AfMnM7f8UPFM; Fri, 10 Mar 2023 05:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD91660B20;
	Fri, 10 Mar 2023 05:34:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD91660B20
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CCB8C0071;
	Fri, 10 Mar 2023 05:34:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5015C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7261B60B20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7261B60B20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pB7drjSe_c8Q
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB82760881
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB82760881
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 05:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI4V7gs1JapIw090N/cuaqdK42GUGqIvpMYHfH6WAY4T5TGgqdBWFivq4i3UYjev7Y7cfppvzOOWrt/f8e8hP7hGAEHlhEaJkblBbztKe9mOJ3DCCcfOWa3lOGpLFxTyJ5becLrbzQMzfyZdAMn3/wywxk9IreJQFHWU/+WU24jSyoYiHrIdY1nMsl5aN0TI2okWgkL5b4IR2fUkGDKwdRz6srLcs80Es1XzrJtLu+31wmfrUMnFCAQGJ7yGWPmS90X6pAKPjLekCw2cGKedJ/rcLX86FiCN6vBEMhfDi3Ri2K6M04O6QxunPSMe4qkyE8XZMw9P5SNube5zu8g2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUqbMIVwysstyfmAey8B8misaUbySXRVpI13TEa0tbM=;
 b=PYVrKwEpapEdke1ULHUlKxaGlrvJtmLY193p/AIb/MR7fBim024qISdPXIIiNKJYVxBHib+oImra0t4Fd+Jrggqhe4M2x6D4/WleMs7F7hHU7YVW63CguDSI+xANXPtAYwsuNxzxNNznLN7xyU6DlUOHjmpscPzXbdqDhEXLDJSHQuQSUsAe+YQyPK0hGHOE7XW9ZbwltE07Mijj1mSJgIvmMkgvxMQbXbwWHpWjcYkgEkD4/LoHIozMQMWa/S7xOdCN6E6TxHZHRmoNAZVfFbzPE9d56hgW79a00DspQ1o8nMbBQWAOqxmneo1auM/j6QA2iZCLd6jO25PKgaFdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUqbMIVwysstyfmAey8B8misaUbySXRVpI13TEa0tbM=;
 b=I4XkPZIg43EM4WnF+lCgEuGNHUyNfXGckbCmqGEFlYcMRexR0oJYr/YaZ6DFWkV98IUmkrg9CF5RlO2wmpE5Enk7MKunAmdChVltdLIxmXVCyBaehFw1ujhR4qUKurgjkyhgCVR4bek9a9G3x4HaOaAWMNIXsnuO7Qcn1UFDHvMZly6R1f3Clye4rdr9ZS3fvWaZWsIz8CZApAw0H7js6ZY/BM57a5A2dAp2QhTtpXbK3s92AHGXAWK5CIbnjysIQvgVCrS3KTy941fh7ygnXj3ShCJSzhkjrYXLYyJhA8Fq1efG7qwywqF360lFxSpV6dnucEekCFJhrYzqRF/ptw==
Received: from DM6PR11CA0057.namprd11.prod.outlook.com (2603:10b6:5:14c::34)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 05:34:46 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:14c:cafe::c4) by DM6PR11CA0057.outlook.office365.com
 (2603:10b6:5:14c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 05:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 05:34:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 21:34:35 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 21:34:34 -0800
Received: from mtl123.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 21:34:34 -0800
Received: from sw-mtx-012-001.mtx.labs.mlnx (sw-mtx-012-001.mtx.labs.mlnx
 [10.9.150.40])
 by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 32A5YVo2007739;
 Fri, 10 Mar 2023 07:34:31 +0200
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 0/3] virtio_ring: Clean up code for virtio ring and pci
Date: Fri, 10 Mar 2023 07:34:25 +0200
Message-ID: <20230310053428.3376-1-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: ece57b16-bcc0-4a35-800c-08db21292892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OwpwFTfRtBkF6zuLpecEq/c9cjdi/aF3Q1orc/6JaapzMlEeAiaqw+ZjUoXQlHqsRj+lv6LS7xby03XGdOHVte7DrOUYfhyED+/J+rNa3xRXtjYf0/uZalzBBi23j1Bn56UAcFlC49wpY3cT7nXNDPM7GiTDregqoaGAzDZCJGnz57u39AXDDLW++TozQPGiVnUfO9cscTEXz6YOsCBOjQi4SWHuc1DUMSOhJjZ8dk8jn692bYFmj5G+qBOlNGEqcaMzsnRwU6JoG+4fH4yj0FtK6CCxGvzqZzaLvtNeoz7IOqp4bF4zi4vHrtEZnT07UYystekQqoIzopxZrzW0seklN4/qUMeuAwJi1/Xf+ptZNjIiimOsIRAIF1O4B7M0EGt2spoZ/EKDhFy8sZQAHP3iM5pbS66Ev3IBSaJ0seRMHE+JwXNL3EIL+WElaM0HN/LLxj8cSxrPjgm4sRg+3aWohnEVWkZIDupY3juqhecFOLVUA9fAdmGUv6YcKFkfNycEhpdG9DgVkibZZI8ZWBL1xxY+2AY8kwMaAJhIUDnZe1GcxG3ONPQpGGSCs751qQQ/RYmsxX6eC58VYst5GcEVGPykMi8Ddn9d07skZzBxXzMe2NFgeKBBm3PI3iyXgzfNFzERcD1gVuzlkrh9Oa0Dh3nM21dAgBJOWEF6gvmU8kiJtYtG4NjvpOMS3id7Lpju7ANLuSVzsN8Oqe6wlQP4xbbodMRkaKocoHN3/V67ONUGpRSn/s0WFtCnkeygrw9wn/O33gZcwVKhTq4J9xUXO5SiF6uyjHYpuFwZEs=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(966005)(36756003)(356005)(6666004)(6916009)(41300700001)(8676002)(8936002)(5660300002)(4326008)(2906002)(7636003)(82740400003)(86362001)(70206006)(36860700001)(70586007)(1076003)(316002)(40480700001)(107886003)(478600001)(54906003)(82310400005)(26005)(40460700003)(83380400001)(336012)(186003)(47076005)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:34:45.9716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ece57b16-bcc0-4a35-800c-08db21292892
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183
Cc: "Michael S . Tsirkin" <mst@redhat.com>
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

This patch series performs a clean up of the code in virtio_ring and
virtio_pci, modifying it to conform with the Linux kernel coding style
guidance [1]. The modifications ensure the code easy to read and
understand. This small series does few short cleanups in the code.

Patch-1 Allow non power of 2 sizes for virtqueues
Patch-2 Avoid using inline for small functions.
Patch-3 Use const to annotate read-only pointer params.

[1]
https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease

All of the patches have been verified based on the kernel code
commit 44889ba56cbb ("Merge tag 'net-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

Feng Liu (3):
  virtio_pci_modern: Allow non power of 2 sizes for virtqueues
  virtio_ring: Avoid using inline for small functions
  virtio_ring: Use const to annotate read-only pointer params

 drivers/virtio/virtio_pci_modern.c |  5 ----
 drivers/virtio/virtio_ring.c       | 48 +++++++++++++++---------------
 include/linux/virtio.h             | 14 ++++-----
 3 files changed, 31 insertions(+), 36 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
