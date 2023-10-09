Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A47E95A8E
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80A544157D;
	Mon,  9 Oct 2023 11:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80A544157D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aHgLa5R+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V16_HEST75sN; Mon,  9 Oct 2023 11:25:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C26E741573;
	Mon,  9 Oct 2023 11:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C26E741573
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC6E0C0039;
	Mon,  9 Oct 2023 11:25:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B014DC0DD7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E3B94156D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E3B94156D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c4ctB5zOsdAV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::612])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 342254152F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 342254152F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVjEKc8B8gPjJPHPgvMjRlmMm1JnVZYepX+pm+U0nowxVkDVTRcK/azGCrPRDsTmsto6Hgu5pdSprTJVtykcFrZzNw4F36aK6c5rd88DO7Jg8/vHgMQAx4RGe/m55QVrZuNYdgpHivcLcRo+p6a3w2ibvgjzQCc23ikFyHEPu9PqoKTpUfFm+MRIVQ3YzUoLQTC2n/rS6LL6e8pKefS6/aJj8s6tVDvNCiFmPq7Y/+Zof8jLYXhNDrNA+k/pyyH8Zi2OTmslpzovwmbyHn4rMh3ZsU4grXcYv2bf7QKNc4y7zfqB1ULC0fw/cp72cbN/r9n0FS8AjzVillW7QGGyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUyxh+q8JiTvEHDFg9Oqu+9F9CPr0I46v6fSiFkbajM=;
 b=dJx04D53+G2AoxAMIkrl2MwSxtWjd1SelerBnOqrCtn2EQa+gfIl4rrLtEyMoCQdWOcsvqnZoIVggA3n+lqVfmRkcchgyLN9VfWKOel0HoDb4AXjnLXOIz8H2bwkpI8hVQdwtsHwXIeN0UiaA8+xNVUfpnJe3d22vcpGshVkG3N3aPfdr4lB/hhbdn1mPNr59GtEg/mW8+bXJKAyHMDqdTrr2Vas8iMQhze3AzvJYhV/JF2bdHvDrvXVem6qQC/EDEqjRWo+bjqaST7cRc6r5H2TXLsdEzXZv9IeFVoN/tq0qYMs5GJGYkJAhyCATWa2HR7rXQKEqazNh0kHdPV3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUyxh+q8JiTvEHDFg9Oqu+9F9CPr0I46v6fSiFkbajM=;
 b=aHgLa5R+W8/rSGqWwoqw+HFb1FQaUziOsF6OYJeIO0nqrM3apQUBtblmpVdjA+4+ZLCkEgq4726oe/n8NETcadqFQiV37LjK30QuXFmbWe/e6QPw/nO9r8k30cdXCrE+p2ixBZMot20VD92+zUZ9krU0si8DzkfKCkbJ1pqjdM3cbhczHNam1ZX8kFg9eILDS+hwg7U9wKEdfXINC8g1RzGcW3nHsCeYqVIW65Swy+O64d3rYh2PNNKXbcRSXu3oY0xJ8V+nyb6P+8F/JyNaP8M0JvZz5GGvU7iMDhn/wesMno7WFOgDLaaPSxvdzTWqbhKS2k9pVvIX8g6Ytdik3A==
Received: from BLAPR03CA0045.namprd03.prod.outlook.com (2603:10b6:208:32d::20)
 by CH2PR12MB4889.namprd12.prod.outlook.com (2603:10b6:610:68::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 11:25:33 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::a6) by BLAPR03CA0045.outlook.office365.com
 (2603:10b6:208:32d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 11:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 11:25:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:25:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:25:16 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:25:13 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 16/16] vdpa/mlx5: Update cvq iotlb mapping on ASID
 change
Date: Mon, 9 Oct 2023 14:24:01 +0300
Message-ID: <20231009112401.1060447-17-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CH2PR12MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1e4f64-b605-486f-d985-08dbc8ba73a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8pNfuNGDy5RWcA4mthcG8kkb1yHSIvsf4NTVpREDloZWvmkSUqmQacj+DtEKaXYR7iNYYZCxrlxECdyODzMdBpC6E2XQnFBR9jOelDo8f2GifQnMOMSlvWBKONQXczb26sto76hkN2D3a0a36/5QAO4v+PL7uEBG2hKbqSQ2UwBS4TeM1PgdFh9LUkVvrsZTx18u2gLiaPbqIkszan+mVe3qTfXynRf3SRCGiEAr4rrWFxE9IKZf1DXEj1VyV04CPh3OQjYmGyKl18E2b593oIRXxMZSPlDE0gQMz8qYMnIsPEA3dcqz/EEEjW0TZdD4XCZoBVWpOP5bTaOkagg+gr9KZpV6pYpIJKmsiJXy1zcrIafshtoTA/pveGyOQsvgbmL9xZyMEA0N2p6IA9z2tDDYyHEK7A1aq6iU4NX9QMimgagbQwABOx54tr3ggVZPiWCUNF1JBdyABl2MlACF3/ji1Q/+X753pa7lV7PYcz8pGfKiRAdl+oM9DuaMVlnTTVCDjbgeDZvejXF2ktxbk64TkYFWe/c1McALAWioh1cb1eGe/Y17aTcUuPWIhHGO4iD7CMNGIEYxcPdlv+G3T3p6FNUhydnl2HJNWlxen8NZ6LxPbtdD+3+q6nLEPDVy8s6NvAZ857/lIuZY4IVjNtOF8Hd/rrDd2OopbTybsE0CGQejKu4KjJ+UqijCxBojdBtBIdsXtacSU5eqGqEZC96VvJ8LxDkZdfENJw+5DLTHujUUP6xO0fe4+l6C0v2
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(1076003)(2616005)(40460700003)(36756003)(86362001)(7636003)(40480700001)(82740400003)(356005)(36860700001)(26005)(83380400001)(47076005)(426003)(336012)(66574015)(2906002)(478600001)(41300700001)(8676002)(4326008)(316002)(8936002)(5660300002)(70586007)(110136005)(54906003)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:25:33.1009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1e4f64-b605-486f-d985-08dbc8ba73a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4889
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
LgoKQWNrZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgpTaWduZWQt
b2ZmLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KLS0tCiBkcml2ZXJz
L3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIHwgIDIgKysKIGRyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbXIuYyAgICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICB8ICA5ICsrKysrKysrLQogMyBmaWxlcyBjaGFuZ2Vk
LCAzNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92
ZHBhLmgKaW5kZXggYWUwOTI5NmY0MjcwLi5kYjk4OGNlZDVhNWQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaApAQCAtMzIsNiArMzIsOCBAQCBzdHJ1Y3QgbWx4NV92ZHBhX21yIHsKIAl1
bnNpZ25lZCBsb25nIG51bV9kaXJlY3RzOwogCXVuc2lnbmVkIGxvbmcgbnVtX2tsbXM7CiAKKwlz
dHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiOworCiAJYm9vbCB1c2VyX21yOwogfTsKIApkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tci5jCmluZGV4IDRhM2RmODY1ZGY0MC4uNjY1MzBlMjhmMzI3IDEwMDY0NAotLS0gYS9kcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5j
CkBAIC01MDIsNiArNTAyLDggQEAgc3RhdGljIHZvaWQgX21seDVfdmRwYV9kZXN0cm95X21yKHN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1seDVfdmRwYV8KIAkJZGVzdHJveV91
c2VyX21yKG12ZGV2LCBtcik7CiAJZWxzZQogCQlkZXN0cm95X2RtYV9tcihtdmRldiwgbXIpOwor
CisJdmhvc3RfaW90bGJfZnJlZShtci0+aW90bGIpOwogfQogCiB2b2lkIG1seDVfdmRwYV9kZXN0
cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKQEAgLTU2MSw2ICs1NjMsMzAgQEAg
c3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYsCiAJZWxzZQogCQllcnIgPSBjcmVhdGVfZG1hX21yKG12ZGV2LCBtcik7CiAKKwlpZiAoZXJy
KQorCQlyZXR1cm4gZXJyOworCisJbXItPmlvdGxiID0gdmhvc3RfaW90bGJfYWxsb2MoMCwgMCk7
CisJaWYgKCFtci0+aW90bGIpIHsKKwkJZXJyID0gLUVOT01FTTsKKwkJZ290byBlcnJfbXI7CisJ
fQorCisJZXJyID0gZHVwX2lvdGxiKG1yLT5pb3RsYiwgaW90bGIpOworCWlmIChlcnIpCisJCWdv
dG8gZXJyX2lvdGxiOworCisJcmV0dXJuIDA7CisKK2Vycl9pb3RsYjoKKwl2aG9zdF9pb3RsYl9m
cmVlKG1yLT5pb3RsYik7CisKK2Vycl9tcjoKKwlpZiAoaW90bGIpCisJCWRlc3Ryb3lfdXNlcl9t
cihtdmRldiwgbXIpOworCWVsc2UKKwkJZGVzdHJveV9kbWFfbXIobXZkZXYsIG1yKTsKKwogCXJl
dHVybiBlcnI7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwppbmRleCAyZTBhM2NlMWMw
Y2YuLjZhYmUwMjMxMGYyYiAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwpAQCAtMzE1NCwx
MiArMzE1NCwxOSBAQCBzdGF0aWMgaW50IG1seDVfc2V0X2dyb3VwX2FzaWQoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1MzIgZ3JvdXAsCiAJCQkgICAgICAgdW5zaWduZWQgaW50IGFzaWQpCiB7
CiAJc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7CisJaW50IGVy
ciA9IDA7CiAKIAlpZiAoZ3JvdXAgPj0gTUxYNV9WRFBBX05VTVZRX0dST1VQUykKIAkJcmV0dXJu
IC1FSU5WQUw7CiAKIAltdmRldi0+Z3JvdXAyYXNpZFtncm91cF0gPSBhc2lkOwotCXJldHVybiAw
OworCisJbXV0ZXhfbG9jaygmbXZkZXYtPm1yX210eCk7CisJaWYgKGdyb3VwID09IE1MWDVfVkRQ
QV9DVlFfR1JPVVAgJiYgbXZkZXYtPm1yW2FzaWRdKQorCQllcnIgPSBtbHg1X3ZkcGFfdXBkYXRl
X2N2cV9pb3RsYihtdmRldiwgbXZkZXYtPm1yW2FzaWRdLT5pb3RsYiwgYXNpZCk7CisJbXV0ZXhf
dW5sb2NrKCZtdmRldi0+bXJfbXR4KTsKKworCXJldHVybiBlcnI7CiB9CiAKIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIG1seDVfdmRwYV9vcHMgPSB7Ci0tIAoyLjQxLjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
