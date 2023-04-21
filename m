Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16846C7618E
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 19:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D732417D4;
	Fri, 21 Apr 2023 19:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D732417D4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=P59qhYht
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vm7So43fmE0p; Fri, 21 Apr 2023 19:57:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E564540A17;
	Fri, 21 Apr 2023 19:57:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E564540A17
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5AC8C007A;
	Fri, 21 Apr 2023 19:57:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B0B3C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE614843CF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:56:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE614843CF
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=P59qhYht
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fREi5x7AywOD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:56:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3FF884348
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3FF884348
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 19:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im60+VbpOvDg6vA1yXxy9oRH52YsEidFsX3WUstSvl8nJTJy08RILxaQdPuoPn8pgrOkmMLtRVS8ZM6+DFGLvrsIIonGEyryjPrjoZSPBWZ46cRDmvQsgwXSxWb1YVGH2LAuZuyEkke9WW3CE0LRZlPs+KPPvtV67U0KbB8aWYaRgH648/baELAlaxpvy3jEdqtaTrf4IxP6Anq+NbC04vsOKylV8hVzumvL/0yhKJPMXjvy+6XAyqqwjU3WprmAvwf1hMY5jDDTiZKPxXsTYcoBYiKbibABRONKH5pQZ5PreS9zWF2PBKkInq2aGQaGk0z2mSImRB6edKniShbljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxalENrGp6gr/e0GmBYBL2lH7huz3kNQPRLWsz2AaKg=;
 b=k0JKXQDmxlmy67fRfs9S2OnWjFEQSMwIOAVqd5hBiXDQ8/GToZpck2XJxRwHusw99+D33FtBDdODyghRJ+mJ2tCdwrSPfknRImnIBMMU3YrFXsFYLup7kRoQYgAn2c6TyHDZN0Wxe6KT7+EtntkGhOCKavtERtLIP4KieVlKa6Q1iEBb4i5gR7STFl6kA5+yiYfY+e/Q8pybgyoyl79ucVkeogXf0P/5XhBgV8+oyWQCzBspY+OByV5g62qTTFlHKIdJNTMJUT1x7S7H2h19Znw9uprfp20ZtbSiiThuFX5JpgoliD33hywdFunwInFb24gnTDQzOv/LscOWteOguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxalENrGp6gr/e0GmBYBL2lH7huz3kNQPRLWsz2AaKg=;
 b=P59qhYhttlzTA3hu0aaBxu5cps/iD5FJ9S4hRmpnBS+5g7Gspo+UTHjxgBiJPk9bS9yCLJw9Hg7HNfJke11VQJ9lAxvRrgLnZ4TO/4W3ChG2WF7MLvsxEhU+DNCv0+pPujjQJRU3KmZxvK28LejfOaKhrRGalUcJoi6qeq+KVEE=
Received: from DM6PR08CA0017.namprd08.prod.outlook.com (2603:10b6:5:80::30) by
 BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Fri, 21 Apr 2023 19:56:55 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::f7) by DM6PR08CA0017.outlook.office365.com
 (2603:10b6:5:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Fri, 21 Apr 2023 19:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Fri, 21 Apr 2023 19:56:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 21 Apr
 2023 14:56:54 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH 0/3] vhost_vdpa: better PACKED support
Date: Fri, 21 Apr 2023 12:56:38 -0700
Message-ID: <20230421195641.391-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e565c3d-78de-4f9f-3f9c-08db42a28f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxDT0Or8eGqYRYqsElr7ZlKFetcA9zQ9YAIGFo+VjoS2gOGYzX4XxxmNSKSEn+i03NYtXsHrcik5PuMgfWGyg2B6JJxfl1fP7NFbG/FTDqP1thFdZSWK+Gchw2fM3xpASzl9U+RyVcYFymmoAiSnca4F+tArYbQW6CqJTDkj3UXgEJ1EZcKScXHgattnuLvzEihFBUhvJJCWZsKxWQgnLPdu5LvUHcs/is8e6UMpSjD3QoelMe37nsQvRH4xzSVS/yZRhofvXhNjvbe6cYOKe3CffcYfsLcblFFc9Yewgg4WFRbqAv36+6tUCWEHuuoL5A+UHuIZG/TDwEq92O8JRXpwwrfB/96dmGhx2+AlQnNAkeGqxAHJLAO/9O9BQpmf1ZPflBAk3S8QGbINDLNGuuEfARmBhe9RRbopNx6BiwQ0WGJZPs7Pi0JxdIlqddaqGVryvqsCeuK6stErscjxwOlEfr78tieRS8ipT2uZCOnNOQ5rxcuVgnFDhcoLy/lmrVLinf65NBiqbN15s/ZSRHxw456uZqtM7lgtK/VXO5A/JaS2FGRzqI49ijTcioPBvTI29Qj+qhJp+HBgMVZeutAjwm/fP9NzJEIhMhBHOcYMN/RKlRA7s/wSW6C+oiKF5mSDyk8X7Gk7zBT9oYV+52Mw6jKXIdwt4vpaQbK/9BoFIlxU2a8McibqTMpnoNGBYuvUCVj1aBniNuaOp5wfUG49+FKAjRPGeGiA4T6b/SU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(4326008)(70586007)(110136005)(316002)(54906003)(70206006)(36756003)(1076003)(16526019)(36860700001)(26005)(336012)(2616005)(47076005)(426003)(83380400001)(186003)(356005)(81166007)(40480700001)(5660300002)(8676002)(41300700001)(82310400005)(478600001)(2906002)(6666004)(8936002)(82740400003)(40460700003)(86362001)(4744005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 19:56:55.6059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e565c3d-78de-4f9f-3f9c-08db42a28f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
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

While testing our vDPA driver with QEMU we found that vhost_vdpa seems to
be missing some support for PACKED VQs.  Adding these helped us get further
in our testing.  The first patch makes sure that the vhost_vdpa vqs are given
the feature flags, as done in other vhost variants.  The second and third 
patches use the feature flags to properly format and pass set/get_vq requests.

Shannon Nelson (3):
  vhost_vdpa: tell vqs about the negotiated
  vhost: support PACKED when setting-getting vring_base
  vhost_vdpa: support PACKED when setting-getting vring_base

 drivers/vhost/vdpa.c  | 32 ++++++++++++++++++++++++++++----
 drivers/vhost/vhost.c | 18 +++++++++++++-----
 2 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
