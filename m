Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48837C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 18:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A64840BCE;
	Wed, 15 Mar 2023 18:55:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A64840BCE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=e5f3x/SF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T-L5ahaLK3jw; Wed, 15 Mar 2023 18:55:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F287140447;
	Wed, 15 Mar 2023 18:55:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F287140447
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2ED6C007C;
	Wed, 15 Mar 2023 18:55:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB092C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F1FD404AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F1FD404AF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2K9tmKGZKXE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 721DD40447
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 721DD40447
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 18:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh3YmE0EqWM2PMXQn56P+GUZqxTqyV1hlOh6vzjnkbt4mDlOYnrstQvirEpaBeluUXjNRn6ZZkobwujW7GGk3Q8GyrqP3qR+xWY4yGr2zPCOgo29W78IThEUDZoGkGXwaH20GlMwN5kZE6rTjOd2CgWrSzQ7t/2un0Dqe0+C6P/MieQH6X3vS2SE7JZbx8BVQPbh5jyCvUrhxEvOay8ZsyT/At5k0sKGEvkliPr7vIYklJFZqpKWgcqz+WYiTyPQvmsEmjLqAce+Ajd7pdfcNxRfJhwQrIBB5KeTu625PKIFlbLCsW+tBmuhois86l4B6OAEAeqA4bq8+c8U/5VgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDN7Ca3tchA+H+D5seuvBsU03RB19Qsb0u4BnDCvaZM=;
 b=S/JUplZaG82MlBaaJk806bbMO9mzwkxEXzv0XwajmYhlBGk2g/B3hwLmG0usZvdagwPF2ydLXAdNrky/vBNp75s3YEsL+xrGcJdngZt60JoFxwXzlAGh+7qQ5OLhh1dFQ5/7hbkstHM0jij6gEquUME+fQrUK+Ip7YOP9yg9F6O7RqECNehUAraK/zdp9/G0MFImUgkyPovvOV77zbeZN6D41Xvmgu+0TCLSXR6yAEbxThPa/eK42ZJrZzvGwNqqhtBoWHolF87S0iJfcCnKt4fJMpM1xFN7M4E43UAX/Gdg0l8uIK5sSEV8OlotdDtpwSwFmUUZM8oQkmTWx70oug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDN7Ca3tchA+H+D5seuvBsU03RB19Qsb0u4BnDCvaZM=;
 b=e5f3x/SF8tEE/3hzaNVNa0iNWbitRECPBnWzRsv0B2dnaNl1ft9EMowWWsgl2UilUS8BsDtgzzaHzVa2f7PPX+S8XVUvuohQJ6h5JPnenS/rJWJI6rVlBt01ZYxcHPbZzM+Yf9dp1CIZ7LFiTkuE1VqDk6IQ5V09aiCp+mmFVQnOqAX5AYCNwkVxfAn+eRdoajAA3xtMHd9FTOfR7INTuPdNajabP85b5tOf+GUmOIo47Em3e4Ms6on502bNDRwOOtnbudybfc0UG+vN51ytdbd5w0oIFWnUiGFAHq6zYP2LzZU6RG5mG+DDqFIv0n7/gzhG0xO6a7qvUbtexvAwgg==
Received: from DS7PR03CA0306.namprd03.prod.outlook.com (2603:10b6:8:2b::14) by
 CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Wed, 15 Mar 2023 18:55:08 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::7e) by DS7PR03CA0306.outlook.office365.com
 (2603:10b6:8:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Wed, 15 Mar 2023 18:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.16 via Frontend Transport; Wed, 15 Mar 2023 18:55:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 11:55:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 15 Mar
 2023 11:55:01 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Wed, 15 Mar
 2023 11:55:00 -0700
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 0/3] virtio_ring: Clean up code for virtio ring and pci
Date: Wed, 15 Mar 2023 20:54:55 +0200
Message-ID: <20230315185458.11638-1-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b281f9-16b1-43b7-9c44-08db2586cc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQ/f9NrrK4y37gW/RWlXMShE9h0Xg9fv4vev/pa7nMUyZeyXqdos0CIgUo/TE5Q2mtpkPZK5DLwN5RxZNiU5XjFzosEWNXNQY4xw0DoMuJqmoLNP/SrhXDyyxbsfeABwCGFRZXDWy6ZD8Ga0cMd0eqkOGfIwA6O9HJbte1ml1+xKdKZk/gqgtmhD6EXlz340ZVrWdswn2ZZLVeeLVx/o/PzBcNxLpbaXx1rfEbSqODe12D78RSy1MFVirUvCvUXPTthACAiVFjnmQIBbiqy4Pdzgwa+bibI21Eu+YaLwc1xPxaHI8US4xG7Ka+1PKfN3PPv71NVRwoiEqNzcy2Doj6UaGmLqLfLO638KDDcZyXfNUZlIJSfZUrVE1ethOlYGSJGpuz6HCMc/JH01iL7GY07WzoqnZFCNLPp+vmlM77dPCD2QYzNwb4lf8oRBwpHfrfUvvHF1x5kuLudklbaigjWnNH72bTp9BxhDsZFe4i+LkjUREjVxXoQXUxTFtjtaABvSOaUejnfimuu52TxLkr5ON2vg5vPFtGmnQG0vmWfMvfr3jbs4FeraMWDKHqAcqi5dl+IOd56TZd8GZ7RMmnjUvrFtrDMe8xps3C0DAi8rljnQBW1ws3AJErKu/UjF4XvFjpProfiiIMMZJMUBpOO5VDKGpMWa84DM4Y2qwH/+w2G1u7asMklng2sX07UuqEePneCDJ4FCZvOG3i11mcpzT4CQ8VGVhHqP5rBqNSlerNhO3JAPfhH3I+DElTxos9KJefPRA4v0RROFpKWaFO4q8bUu7qykbiEWe81wwRU=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(86362001)(356005)(7636003)(82740400003)(36756003)(8936002)(41300700001)(36860700001)(2906002)(5660300002)(82310400005)(83380400001)(40480700001)(26005)(6916009)(426003)(336012)(316002)(1076003)(186003)(2616005)(47076005)(54906003)(70586007)(6666004)(966005)(70206006)(478600001)(40460700003)(4326008)(7696005)(107886003)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:55:08.5200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b281f9-16b1-43b7-9c44-08db2586cc4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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

This patch series performs a clean up of the code in virtio_ring and
virtio_pci, modifying it to conform with the Linux kernel coding style
guidance [1]. The modifications ensure the code easy to read and
understand. This small series does few short cleanups in the code.

Patch-1 Allow non power of 2 sizes for packed virtqueues.
Patch-2 Avoid using inline for small functions.
Patch-3 Use const to annotate read-only pointer params.

[1]
https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease

All of the patches have been verified based on the kernel code
commit 81ff855485a3 ("Merge tag 'i2c-for-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux")

Feng Liu (3):
  virtio_ring: Allow non power of 2 sizes for packed virtqueue
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
