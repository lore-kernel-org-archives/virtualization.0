Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A84EB64D9
	for <virtualization@archiver.kernel.org>; Fri, 30 Jun 2023 00:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE12E400D8;
	Fri, 30 Jun 2023 00:36:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE12E400D8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tu+cx0xP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cpGuCEeMtTyB; Fri, 30 Jun 2023 00:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 584E74010D;
	Fri, 30 Jun 2023 00:36:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 584E74010D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2932CC0072;
	Fri, 30 Jun 2023 00:36:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEDB7C0037
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 00:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1FD4611AE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 00:36:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1FD4611AE
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tu+cx0xP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gmnDjQZrycto
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 00:36:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADF0C60E76
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::610])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADF0C60E76
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 00:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3ZVpeuv0Ruwgo4xzODSCVv+9gez7kh+LMDK2hcqyGzMGPQHa7tUV2fCxJ61dJlKMhtvpuyPay5m4A802lHJvFrT+MXzVqG8DuWKFS42PdRV062Y5NTNh9WWyyUVgRXavtosdeysJwAGXWKGlKZdkKHJ+E++k2zUJFz2eGmbAg2VRCMLPlFX27jaBV6DqZS/EV7tXgmccFIVuEg/Hu7upz1lzuz2BciRrLntwvHdqPXTPMVxz081UfPNiqHRJwHureYq0OTZMjAVX0mFZQ80FxzyFxM0Dntt2ASMWr69a811MTteOALnyAuJ0aTvAm2fxdUe2DH1sM/GuD1B1aXqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOUewXIZBJmmX2KwyK2gzEmkLIKWru2MWjAseoproos=;
 b=fVzLmKdoPt/ApSpmbJTsM080KQ6Y+n4qGHmTY/aGWkDD5Q8KZ3JTxHx+UZJfYe9VofGhvEUZ6lknm4iBEMym+LKD5gqaI4HqOntlboaG+rKn0I6u6xBW/ysl33ffz/gyVi2GOiDmyy1mCGNgVM6HO2exH+MOqCHXj6wuNM00IRR9knkJt8sT8Fud2X61NEd4h+4Cjwz8FYEFHk7h+foatFQ0tohS/Tp2XDhEVYv/IKXPjNbmIoVRMuLPD3gpcvZGcKmC5D7cvTGIAuYIUL2+760MCnSUXAHk1wPPPpl268gFNvbfxA2CYT4TcDZjRXlHwMgjMCaqeV9jLb9t88iiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOUewXIZBJmmX2KwyK2gzEmkLIKWru2MWjAseoproos=;
 b=tu+cx0xPyWKpyrY3sptTHt3I0yLh/yZWZJZcvIq02AguQse1RopS2dwsSgZHKzlQF18mDd+uzRZebUnuoEoFlQ0C+CrKi970X/eKnPQVxP9HR1SM8KQOOKyqZYEvhCsu9QkeMMt0DD9GPjQgSwZd+ZH2Yx+NdqglpKXX/7+UCtI=
Received: from MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 00:36:40 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::f8) by MW4PR03CA0256.outlook.office365.com
 (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 00:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.33 via Frontend Transport; Fri, 30 Jun 2023 00:36:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 19:36:38 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH virtio 0/4] pds_vdpa: mac, reset, and irq updates
Date: Thu, 29 Jun 2023 17:36:05 -0700
Message-ID: <20230630003609.28527-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: af1652ca-94f0-467a-93c3-08db790211a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaLMYQuRfQ1l6nYfNbcooMVbO1HawDQCcGRTgqnCjJ5saxweKry+slmj8/jP/8KbsEe45No6GPzwzPzv0npTQAY513NFEcOFg/bEzqDLC9x6S/zl/xSZI2G2VrpL+GBEVUFnMpu3in2w8P0GQBi8B1tzUqriNl4gvo/3J+fsSTpcQIk3hUvizPVdeK8OVKwyy50ycL+URdcZL7JobV4PfBFnJ/kgOAQkAf9gUhG7usfWZXAsbrADurW0wYx8labC9SMZwPIRvh3aNM8nQ5xv/0J92YRu/CUGpWcULBRSLRM3EUbhpvRQ66XELDc7sD4ffUVcN2UmNFGImdA56SbwODbkMGeup/trZECYA+6v2gDDX2LbFytxPPiVdz1Hb4RVKwsAUkogBYCoNngGFMosMmO6+o8+NjAQXzF2wK/WJwaEWO1rWVtuCUaCSf9wsdFmcpFDW6py2d+tPmoP74cpv7hPLSRDzA+BLQMx0xouwDULSINLiW3rLocF+DL9fpJrnlsrMVJYrje4qrgH94+s5amNCVE1oLGf3vCJ2xNzSli33Rf+1/d1AOmQBczrR6htL9wL1iJbaqtYWudqDXdYWYpFr3MwwibopalIc1SdUvwvQ1ubnABz+5loQxO9nxv9l+nzYt8PYxDGCgdSYet/3ZZoVUCPUHEZnu+9ZS4tnXSo53tEz82t++WbeGzdiUeJrLlx1eN06wW5uQme3blPIN6m8gGBeXgJKz50aNXDYEumBpdHE0wXM4h8iLXrguryp09mTsCZK5MKsX83Rkgung==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(110136005)(6666004)(478600001)(70586007)(1076003)(4744005)(2906002)(81166007)(186003)(26005)(82310400005)(16526019)(316002)(41300700001)(44832011)(5660300002)(70206006)(8676002)(356005)(8936002)(36756003)(4326008)(86362001)(82740400003)(336012)(2616005)(40480700001)(47076005)(36860700001)(40460700003)(426003)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 00:36:39.4716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1652ca-94f0-467a-93c3-08db790211a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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

v2 for internal review
 - heavily reworked NET_F_MAC patch, matches recent PR-68875
 - reordered to put "clean and reset vqs" before "alloc-irq"
   to make them slightly simpler patches
 - other minor cleanups for simpler patches


These are some fixes for device providing a MAC address, for allocating
irq resources later to support vhost use, and for properly cleaning
vq info on reset.

Allen Hubbe (2):
  pds_vdpa: reset to vdpa specified mac
  pds_vdpa: alloc irq vectors on DRIVER_OK

Shannon Nelson (2):
  pds_vdpa: always allow offering VIRTIO_NET_F_MAC
  pds_vdpa: clean and reset vqs entries

 drivers/vdpa/pds/vdpa_dev.c | 171 +++++++++++++++++++++++++-----------
 drivers/vdpa/pds/vdpa_dev.h |   1 +
 2 files changed, 122 insertions(+), 50 deletions(-)

-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
