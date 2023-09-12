Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1414ACA0EC3
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 13:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96308417DF;
	Tue, 12 Sep 2023 13:02:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96308417DF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cAKboH7l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lMaLcFx3U95Q; Tue, 12 Sep 2023 13:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F0BD417CF;
	Tue, 12 Sep 2023 13:02:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F0BD417CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBE6DC0071;
	Tue, 12 Sep 2023 13:02:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51FDCC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D4ED417E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D4ED417E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w__ZMPUSi6Ww
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7F0741491
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7F0741491
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU2Qs/Y+0hNfucwN+34cCL5zoMqAkfs+aT4+bnbhjlKa1NY2kk8Zv/A8RoEB55NYRgqXL8/ksQOzlilZ/RUp9fOwqYUJ11GgabgcrMRlE3L1aUXd1l97WYd68xiNAH7M69flB50F5zJsRJp8Vnm2AsoDYVCPIR1PVZe8xf93Z8T+oJs6fohvYuPV7xb4Hu8Tu0IypwzEm5QHOqMIpO3ZScO8OIUsikokpXixRIcksQZlTR2DIF1jwoT7cFtRMsuVJKsf1dV9dt2kF5iOfdR8CvAE4pUFxHu6UT+xrTKl+SV7Cy1xB+11L1M0GTzPRHDxEfKLd+2iNDpTGMFy9KZLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCeSvy0nChMIti0ZnBRuBRUFtl31nAh7dJm/MoH4xA4=;
 b=Q7kD0uBiEAIJQ/z1TcsIXDZKcjPi1rF0wG9H7lEXNU52//Y+1b6gyYjBER0HOe6kbUibZy8U5viu6mzxzZ8cij5vzDuJCA5SrCN6E7RwOAxuSeAPrMcNFZCzRdRLVXDYtRLPufPsZ2YcXHkVN37apUUYRFZMSDNhxaiJ6ftAkdm/vxmpfTdc9yEwq+ViDLJSGz0rp4zdhA7L9RCxyF2B1jWwiw3hbUWick9vhB1c6xlHWedIZKoDbcapq3whtgGq3pjCPHcAucDXru6MgW8YOLWq/N4ZuRY+HAYvzktS/vKdyQDMdO0jOmk1Q/JRzY3xEjiRQdNOb6LEsHyVy6TvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCeSvy0nChMIti0ZnBRuBRUFtl31nAh7dJm/MoH4xA4=;
 b=cAKboH7lwjTFzyaKLLTva1tcXDZrWeu5NeOmks+qTjjA5bXo63jqSZ5SBDXItIEDsqyuM7rU0M4DyEOGGIX4wBEcuc1AbXyTtYr6E1StCzJN/pdp0fiqQ6sIFtpwhNiqSrFw26aSE1/7IbErgZ7C9jCwb9h+gVmVlvGkpqW+Fj3p+6Hhi76ETeWNt8ZlSQxTEUB8UAuhYrOhTcqsTv3dmoVBF5SOCKEKP0mAQJAX2KFsenPzrK+Ug9b3ylyWg7PZw9hbk9trLVUbQVvetOad23+zJbNX6udpU809Dl/fmxQ3mWusubUKIPay4lYOrYZNY8IWPdOZikY5PqX6qWUdMw==
Received: from SJ0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:a03:3a0::19)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 13:02:24 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::c8) by SJ0PR03CA0254.outlook.office365.com
 (2603:10b6:a03:3a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37 via Frontend
 Transport; Tue, 12 Sep 2023 13:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 13:02:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 12 Sep 2023
 06:02:06 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 12 Sep
 2023 06:02:06 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Tue, 12 Sep 2023 06:02:03 -0700
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
 <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 <virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/16] vdpa/mlx5: Take cvq iotlb lock during refresh
Date: Tue, 12 Sep 2023 16:01:16 +0300
Message-ID: <20230912130132.561193-7-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912130132.561193-1-dtatulea@nvidia.com>
References: <20230912130132.561193-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 145c4461-2c01-42f0-ebb4-08dbb390820a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LUCawOLE4uhv70DYg3J231RtpypVoc3XBS2NgqCIcf7N9yxkXAZFwqghPTKfJfdeRw08Zys44R8cXACpX3/qDwWkSltuR/USVX0QicJZbsljo+WoXDY+WckOKU1NwALvNhTQyBZZvaHE+QFwxqStk8dyTepp72i1rp2om3a+FDK+APo5Uv1sFxBrkYmPSTc9cfDTDCdvj2k+ZZcFUQ/CoUO7p5LTwUChacQpQnsB5aOQH9yxWfyQepgcBy5USPEF0N1JkthIfOMXGRqCaJCvu3zG+eN/zcJZ3JkBlrXDszTYNq8erECNr2HTC1VsVRcvv5JK6/yHdEUbEHQxX9TFwcNrJdJqOWog7jCqXBeCsk6YtyhD0C3FS3MAwmL13aN1RYywzwXSB3c0bdNMbtlrC3Z9UkWwd5It6Jxx7hnJrJDSbdyxRBW0kw+xu6Lu79JB6XX3eAcEeMUJesX1Z/rVXMhIcn0X9xYc3QEAlDnjE6gHC0t62NA/Rf5ozRYH4EDBqR3V14GAJMg0OJsUpaqdGJ5zixPLH/Patl5ZGXaR915sN7dU3GivaH/N63rmi2bqIzUxwO9g0lI5KCmN7X4UTAZRDYWnNuOw3Rz+66A8N4VdaFkFcJyJtRPKNkSiPsV1LpR4bziOaNVK2auESbvHYnPpy9HjnlxtikmVGGgcRhRO6gpakOgDNIZH2hlc7LbSxJG0IDUatB8uiVHyp2e1x4BOAsC237r4c6p9lRHSGYolPuNgC4Pk0O7eYJCP7iJv5dVAQ1kIFdRrRN7X05j9Li3lIzOnxIIoYrWuJPpv0c=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(2906002)(70206006)(40480700001)(26005)(1076003)(336012)(426003)(41300700001)(316002)(54906003)(110136005)(8676002)(70586007)(478600001)(966005)(4326008)(5660300002)(8936002)(6666004)(40460700003)(36756003)(36860700001)(66574015)(47076005)(2616005)(83380400001)(7636003)(86362001)(82740400003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:02:24.0223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145c4461-2c01-42f0-ebb4-08dbb390820a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

VGhlIHJlc2xvY2sgaXMgdGFrZW4gd2hpbGUgcmVmcmVzaCBpcyBjYWxsZWQgYnV0IGlvbW11X2xv
Y2sgaXMgbW9yZQpzcGVjaWZpYyB0byB0aGlzIHJlc291cmNlLiBTbyB0YWtlIHRoZSBpb21tdV9s
b2NrIGR1cmluZyBjdnEgaW90bGIKcmVmcmVzaC4KCkJhc2VkIG9uIEV1Z2VuaW8ncyBwYXRjaCBb
MF0uCgpbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDExMjE0MjIxOC43MjU2
MjItNC1lcGVyZXptYUByZWRoYXQuY29tLwoKU3VnZ2VzdGVkLWJ5OiBFdWdlbmlvIFDDqXJleiA8
ZXBlcmV6bWFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1
bGVhQG52aWRpYS5jb20+Ci0tLQogZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIHwgMTAgKysr
KysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRwYS9t
bHg1L2NvcmUvbXIuYwppbmRleCBmY2I2YWUzMmU5ZWQuLjU4NzMwMGU3YzE4ZSAxMDA2NDQKLS0t
IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbXIuYwpAQCAtNTkwLDExICs1OTAsMTkgQEAgaW50IG1seDVfdmRwYV91cGRhdGVfY3ZxX2lv
dGxiKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKIAkJCQlzdHJ1Y3Qgdmhvc3RfaW90bGIg
KmlvdGxiLAogCQkJCXVuc2lnbmVkIGludCBhc2lkKQogeworCWludCBlcnI7CisKIAlpZiAobXZk
ZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gIT0gYXNpZCkKIAkJcmV0dXJuIDA7
CiAKKwlzcGluX2xvY2soJm12ZGV2LT5jdnEuaW9tbXVfbG9jayk7CisKIAlwcnVuZV9pb3RsYiht
dmRldik7Ci0JcmV0dXJuIGR1cF9pb3RsYihtdmRldiwgaW90bGIpOworCWVyciA9IGR1cF9pb3Rs
YihtdmRldiwgaW90bGIpOworCisJc3Bpbl91bmxvY2soJm12ZGV2LT5jdnEuaW9tbXVfbG9jayk7
CisKKwlyZXR1cm4gZXJyOwogfQogCiBpbnQgbWx4NV92ZHBhX2NyZWF0ZV9kbWFfbXIoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2KQotLSAKMi40MS4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
