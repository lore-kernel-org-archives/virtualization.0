Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74433CDB483
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B6FA421CC;
	Wed, 18 Oct 2023 17:16:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B6FA421CC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EjtSpysc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EMTNXUGHNAT3; Wed, 18 Oct 2023 17:16:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A1DF421C5;
	Wed, 18 Oct 2023 17:16:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A1DF421C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53E9EC0039;
	Wed, 18 Oct 2023 17:16:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8CC4C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 907D36F545
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 907D36F545
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=EjtSpysc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tKG5ZXBZ7CfJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::608])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9D1F6F54D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9D1F6F54D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EThE2dydt6oXrjOLoPyYsQlGJtgXpXD98CJVlB+Btnzu+Lx+FBopXGexN3NtkFy6efxrdQcb9NfGHpeaE4GFPV3zl0N40XCCYu86f97lupi/sT3I2Jpy4SnuqYc2EIWuQYPM8qbrTeDz34Y9fhrlPFgAblMhPf3sCejJgKyrzA71i2jub0k48jJngZR604l99QWcCGH/tkq9hvG9ZfJXN4LAiWuBQYi004aZQQwZqpm4x9h4GsQoa1Ixp55qR2mYhVgKqNA+TNNtnMworuf5YshC9KPBFsReU0sUSbKiX0VOUmRrs5nMwCLRuYRi5yBj+24HnGm4XSEqaJCe+jZJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BE04TjWBIEmnEIfT4KflUMZCKQcmJpsqNZEqnvGfsQ=;
 b=nUWuZ07mSd8B/UxQckhyAuilNBWhbx/36gAm+v4rUSlkKgIG5Xv0jJ0xVyE/p3gWeSC9za1XLsxSoHxb2r/k2tdca7kOyCH0XQAEMK/AUMhC8CyGInbXvhuvOpxTeIqvR3Npngpl6sIqBJQMJ60984IeJN3rRGbXPTE4qR8dOWtHefgIPcrxi8JB1DF8cU/nAd42Dv+jCTAp1BEImB+6HvuyPj9v636FTXpZDnjovRB5OXUt0m5COOCp7LZ85qHfztjqCL1+lInQQ9fKboSR7itoKt3yq1S5y1LNeqSpGP4uOoazzBH63E/piwbmiwBB29vEHhqDN/GzEBCeFOpRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BE04TjWBIEmnEIfT4KflUMZCKQcmJpsqNZEqnvGfsQ=;
 b=EjtSpyscQSl7+4idLTwA/h2aQE3rx7z/BERL5lNmZr0e1ZiU/ymURg+JHLFCQE3xFeFws85ncQ0SsdJ4TlSlGKnX25Zxo9gA3sJ/tUyUhYHwIPQZbg5Jopgi5nE1ImYmFSNF2iV97Du80pgBjovN3XS1ekYcppW6Ly6J+lWQHzfzZuCC2dVLu1NyeQu5obiSCoFfG9seVoHlNqjNDqQ4467bG/mFJsnICXzqkSHiXklSjjGRmkoS3S9ud1YzlLaSR4ddFDcdzzMDpF0kIqxc1CcNOBTPvlAkWCSAJFWn+Ft9u45EuTqHhNZss8Z2pAK9h8DWbqWobkYilSyA6FqHUw==
Received: from CH2PR17CA0026.namprd17.prod.outlook.com (2603:10b6:610:53::36)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:16:36 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::28) by CH2PR17CA0026.outlook.office365.com
 (2603:10b6:610:53::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:16:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:22 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:22 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:16:19 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 16/16] vdpa/mlx5: Update cvq iotlb mapping on ASID
 change
Date: Wed, 18 Oct 2023 20:14:55 +0300
Message-ID: <20231018171456.1624030-18-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: fb129a15-674b-4721-65e9-08dbcffdfbfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+D4Zt2S2VMRqoLgjxAYWJDcziees+cNHNFOzz0jKImWmi/rdJL0W2s6NkiMSQ7Us0iw9J7nTbCpPRwcjA3oWp1eGn1GGUNCg36fASqMuWbjVjkBifviA0szgtSh/j4ALB1WtH43sYrCg3BcqRUZ/Bin1ZxFjyRH80ghqtwQh8RFZJWv0Ii2L5g7eZ9d1GOebh9zPbJZB00/vnME/DSqCtxrFR1wlLEh7WvkKoDwiopQ0e7EuJxqB2uClwsYlmEBSWBGd+VgMD+M0kWW9V1DDmt1tjHKQUQoa/uYd+wAvCM5xXBxlJrWeQNUa8ihWBZLzoeeutq9n1F5e56ehVeG8it+huFPBJs9j7zFqlggRzh9Uomewr9QoZ5nXK3SHStyzPYXtYSpzkRWRi7RQ399foXz5J7Y/oimj3jCrbq4kaRZelO1IdYrHqY+vFfMCpIJlviIUu4tzckFrxmcYLQC3qOB/hYG7KnTD8k0bUTatfRVBbKVPtQ9PNZhZQ619V4F7c8leiJJnE+VjaopCmLF7lqHKEN+xwgDwcqEOmcGhMEhfofbNyosRjbe/oWomLBNgzKdPca1PZIVo6STtI1k8FuZ4IvxubMZssyl4VVLApxuGPDq1IytKmb5gHpO+N8uyjilpVpvHa4HWYpzyBkk+0AWpN2PqsjJhBhpyWCR14LREFNb1zlG2cz3mDrWKWiZ9Oh9xDl1nYHv5XUOqcaUW4HncEUK1bSFKKgnljVUPK/oU3AlNi5yaqo7COiPf2/E
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(66574015)(426003)(336012)(26005)(82740400003)(7636003)(356005)(47076005)(40460700003)(83380400001)(41300700001)(54906003)(8936002)(110136005)(70586007)(86362001)(8676002)(4326008)(5660300002)(1076003)(70206006)(316002)(2906002)(478600001)(6666004)(40480700001)(2616005)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:36.2817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb129a15-674b-4721-65e9-08dbcffdfbfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

Rm9yIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2U6Ci0gY3ZxIGdyb3VwIGlzIGluIEFTSUQgMAotIC5z
ZXRfbWFwKDEsIGN2cV9pb3RsYikKLSAuc2V0X2dyb3VwX2FzaWQoY3ZxX2dyb3VwLCAxKQoKLi4u
IHRoZSBjdnEgbWFwcGluZyBmcm9tIEFTSUQgMCB3aWxsIGJlIHVzZWQuIFRoaXMgaXMgbm90IGFs
d2F5cyBjb3JyZWN0CmJlaGF2aW91ci4KClRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciB0aGUg
YWJvdmUgbWVudGlvbmVkIGZsb3cgYnkgc2F2aW5nIHRoZSBpb3RsYgpvbiBlYWNoIC5zZXRfbWFw
IGFuZCB1cGRhdGluZyB0aGUgY3ZxIGlvdGxiIHdpdGggaXQgb24gYSBjdnEgZ3JvdXAgY2hhbmdl
LgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CkFja2VkLWJ5OiBF
dWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogRHJhZ29z
IFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Ci0tLQogZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaCB8ICAyICsrCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgICAgICAg
IHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYyAgfCAgOSArKysrKysrKy0KIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUv
bWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCmluZGV4IGFl
MDkyOTZmNDI3MC4uZGI5ODhjZWQ1YTVkIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL21seDVfdmRwYS5oCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgK
QEAgLTMyLDYgKzMyLDggQEAgc3RydWN0IG1seDVfdmRwYV9tciB7CiAJdW5zaWduZWQgbG9uZyBu
dW1fZGlyZWN0czsKIAl1bnNpZ25lZCBsb25nIG51bV9rbG1zOwogCisJc3RydWN0IHZob3N0X2lv
dGxiICppb3RsYjsKKwogCWJvb2wgdXNlcl9tcjsKIH07CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwppbmRleCA0
YTNkZjg2NWRmNDAuLjY2NTMwZTI4ZjMyNyAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tci5jCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwpAQCAtNTAyLDYgKzUw
Miw4IEBAIHN0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfCiAJCWRlc3Ryb3lfdXNlcl9tcihtdmRldiwg
bXIpOwogCWVsc2UKIAkJZGVzdHJveV9kbWFfbXIobXZkZXYsIG1yKTsKKworCXZob3N0X2lvdGxi
X2ZyZWUobXItPmlvdGxiKTsKIH0KIAogdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYsCkBAIC01NjEsNiArNTYzLDMwIEBAIHN0YXRpYyBpbnQgX21s
eDVfdmRwYV9jcmVhdGVfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAogCWVsc2UKIAkJ
ZXJyID0gY3JlYXRlX2RtYV9tcihtdmRldiwgbXIpOwogCisJaWYgKGVycikKKwkJcmV0dXJuIGVy
cjsKKworCW1yLT5pb3RsYiA9IHZob3N0X2lvdGxiX2FsbG9jKDAsIDApOworCWlmICghbXItPmlv
dGxiKSB7CisJCWVyciA9IC1FTk9NRU07CisJCWdvdG8gZXJyX21yOworCX0KKworCWVyciA9IGR1
cF9pb3RsYihtci0+aW90bGIsIGlvdGxiKTsKKwlpZiAoZXJyKQorCQlnb3RvIGVycl9pb3RsYjsK
KworCXJldHVybiAwOworCitlcnJfaW90bGI6CisJdmhvc3RfaW90bGJfZnJlZShtci0+aW90bGIp
OworCitlcnJfbXI6CisJaWYgKGlvdGxiKQorCQlkZXN0cm95X3VzZXJfbXIobXZkZXYsIG1yKTsK
KwllbHNlCisJCWRlc3Ryb3lfZG1hX21yKG12ZGV2LCBtcik7CisKIAlyZXR1cm4gZXJyOwogfQog
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKaW5kZXggODdkZDBiYTc2ODk5Li41Nzc0ZjRhZGI3
YzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYworKysgYi9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKQEAgLTMxNTksMTIgKzMxNTksMTkgQEAg
c3RhdGljIGludCBtbHg1X3NldF9ncm91cF9hc2lkKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwg
dTMyIGdyb3VwLAogCQkJICAgICAgIHVuc2lnbmVkIGludCBhc2lkKQogewogCXN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOworCWludCBlcnIgPSAwOwogCiAJaWYg
KGdyb3VwID49IE1MWDVfVkRQQV9OVU1WUV9HUk9VUFMpCiAJCXJldHVybiAtRUlOVkFMOwogCiAJ
bXZkZXYtPmdyb3VwMmFzaWRbZ3JvdXBdID0gYXNpZDsKLQlyZXR1cm4gMDsKKworCW11dGV4X2xv
Y2soJm12ZGV2LT5tcl9tdHgpOworCWlmIChncm91cCA9PSBNTFg1X1ZEUEFfQ1ZRX0dST1VQICYm
IG12ZGV2LT5tclthc2lkXSkKKwkJZXJyID0gbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIobXZk
ZXYsIG12ZGV2LT5tclthc2lkXS0+aW90bGIsIGFzaWQpOworCW11dGV4X3VubG9jaygmbXZkZXYt
Pm1yX210eCk7CisKKwlyZXR1cm4gZXJyOwogfQogCiBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFf
Y29uZmlnX29wcyBtbHg1X3ZkcGFfb3BzID0gewotLSAKMi40MS4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
