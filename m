Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784BFC77B7F
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 22:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9162416F4;
	Mon, 24 Apr 2023 22:50:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9162416F4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VidzW1zX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ucEQsqTyb2ql; Mon, 24 Apr 2023 22:50:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2604541767;
	Mon, 24 Apr 2023 22:50:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2604541767
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0901EC008C;
	Mon, 24 Apr 2023 22:50:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6826AC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34B3E413D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34B3E413D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x-2bytj0KCAx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1948E410D2
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1948E410D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 22:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyODySZhN2dUzTLbhDxmXbGoyhzj5skrJoKHVYhPJVBjgq2GPUnRGhrstgQG43QY3r95mBUyn2FL/QsvkesWgqG+9c//GKWVdpDdNMIqXmIbDejO5dXcEzqXiTkX0Ln2ymSm0CGF25fjORORkcA54MfiWG+Z9YFdoxayYuDupmu5fFx0DRnq6qitTf9DCs/5qtBy9j0ymchit5a58wI8gp+jtxSEbAnaXqESFMg3h1cXI9xcrpP+y2JxwqDjSuuDLdkHGkVvaRdqZ7/L/CkMqpOw+noAJZYOdi5/f3/t4+JzH8CGDVEg2xKZchXt3lEXOebR74AqxVO9G1BXjQeDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgiAHVEqeRg2vSJYczBUdJJBNSzNEYBQRaHXxy2NYO0=;
 b=PSDIrDsRkOSV+NGrh49gOISVxW66u789y/Wc8n4Fyyxld/cmsaZVGk1kKgtaGXv2V/jSEgMfW3EaqhL0bhr7/MKr2ftQ+8NhtVEX6aNoFmfweELPOCEzaYmt+BTwqiuuY13i3m0UrfwfPKGDmAl5i4sc0aRwFH9A2fDdZtPOwBnZEzedJbBWqpXSgVUbu5/RfBNvY2D2kunJcaJGp0xf6fHXbHgTrsQWxp5QnrS073sdH6YrCC1Vb1KMWEK7kNIyFitB55DB2g2s2i7IC3i//Phx6xWwCNLd4BEUKv8km6asxifU1PnbzF2cBLvDTVGsNT5HIdCg6z1+40iz6/v6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgiAHVEqeRg2vSJYczBUdJJBNSzNEYBQRaHXxy2NYO0=;
 b=VidzW1zXDkxQtTTaOY9WZQNFxIDGZgMT2sR3oCwDQM2FwxmdEOSBG0ahO7E4Y2nVFtH/MHaF69/Tygdmi/wLYrZBC2Swkc0qJ0VuMWSwqsR5vG1+WuUYtfprtK14Fg6q6mvbT++y3tXkkSa1Fx+BhhYyCudtiaAQJRtrl3GCNuE=
Received: from MW4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:303:16d::27)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 22:50:45 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::e0) by MW4PR02CA0008.outlook.office365.com
 (2603:10b6:303:16d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 22:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.20 via Frontend Transport; Mon, 24 Apr 2023 22:50:45 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 17:50:44 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 0/3] vhost_vdpa: better PACKED support
Date: Mon, 24 Apr 2023 15:50:28 -0700
Message-ID: <20230424225031.18947-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfee815-b3fd-4962-7d02-08db4516572b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WpEACte+dW2seTZGqCDW5sSBv8qqJn2HwDJLz+qJxCAyu9ZVbzohWL5Y5MFMwFj2jY6qV2pHQ1aO3aereZfyzj7plo8voKkTtXV6jKJlq0AELH0hHAOzgvfPpTEHF8OE4s/nL3PXRSjcL3sXWc+3fwkFhs2tiEyZBdTHpewzWBWYrF2Vx7GDlDsNeb2/NdY/n5MHSoz8vpJ9/LUxgJXNeR0hRNN9rn/tEqZOyR5c41udHi340WDyCGvfPjBaBkjmoJ7WzGnGT3pokGcQGusR5askIOXGY9l4lkNTQpNoT2zttDWapI8JueJUz3f7fI8WxQer86D/ec+GBvplGztHh1zqK1/55/frRWZ7MXjHg0hO+znvitH/zZLUygvMUCcBSwx2srM69qWtmBtDUbh2uJZpxtUkArUF4glzQFWEFG/T+kzHasWDis0KTxnDXgGMztZ33Dr8J7iuKryTDR462Mk18qdMt2Zav5IkZsltDIPfQgGIcmwT4ZrvKdDS5rRci56+Vofwqvw007egN0hDQ8Gvy3vp1zg11C6kTn9a//nw1gOy2G8rRYmJdnk6Fe8AS7wBbzHkD8awgQi22b8+QOtxBVc8sfjWSPMra/h66AHXmv6RqrPL30q/bcv6dmYr5qiG1g2PJH3Wi2bUaf0TeY9D6mz/ZxBo63sTojfUoOH6d98jHXhztsk6FkJ5eNvhiag7ZQRnMKgrxlTKiAB9zr/AZAdWuT/wyWt1GfdgVjg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(40460700003)(16526019)(110136005)(54906003)(86362001)(966005)(36756003)(186003)(26005)(82310400005)(1076003)(40480700001)(6666004)(4326008)(316002)(82740400003)(44832011)(83380400001)(70206006)(70586007)(36860700001)(2906002)(4744005)(336012)(356005)(426003)(8676002)(41300700001)(81166007)(5660300002)(8936002)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:50:45.5715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfee815-b3fd-4962-7d02-08db4516572b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
Cc: drivers@pensando.io
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

While testing our vDPA driver with QEMU we found that vhost_vdpa was
missing some support for PACKED VQs.  Adding these helped us get further
in our testing.  The first patch makes sure that the vhost_vdpa vqs are
given the feature flags, as done in other vhost variants.  The second
and third patches use the feature flags to properly format and pass
set/get_vq requests.

v1:
 - included wrap counter in packing answers for VHOST_GET_VRING_BASE
 - added comments to vhost_virtqueue fields last_avail_idx and last_used_idx

v0:
   https://lists.linuxfoundation.org/pipermail/virtualization/2023-April/066253.html
 - initial version

Shannon Nelson (3):
  vhost_vdpa: tell vqs about the negotiated
  vhost: support PACKED when setting-getting vring_base
  vhost_vdpa: support PACKED when setting-getting vring_base

 drivers/vhost/vdpa.c  | 34 ++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.c | 18 +++++++++++++-----
 drivers/vhost/vhost.h |  8 ++++++--
 3 files changed, 49 insertions(+), 11 deletions(-)

-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
