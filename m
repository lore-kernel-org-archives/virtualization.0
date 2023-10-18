Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7C9CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7A5C421B6;
	Wed, 18 Oct 2023 17:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7A5C421B6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Oez1GLAL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7EkHib9PLuE; Wed, 18 Oct 2023 17:16:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BB5842189;
	Wed, 18 Oct 2023 17:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BB5842189
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1806DC0088;
	Wed, 18 Oct 2023 17:16:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D04CFC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E50082F32
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E50082F32
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Oez1GLAL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5a16TkH8Uu4G
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::621])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 597DF82F50
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 597DF82F50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btC+LOXmSbno2OsIgFJWSs072DVNH9TTLZT57ONCYiblp2G45lcNrFCzYVmynfT8WIYX7SZDdfCCMVeqdz6Vzzb33jpkzCXUSV9fxrt17LFhmtWtzmT6AGdLCJD7wFqAUoO66cluaOFA9g3LqX6GCzJDXGp6Ups+voayQb8PdQ9yu9ToKv43CkWGglz6ylrC7XMKLLwuP3aOSI5tEe6VWTXcmiDyhVNZlAaBhwh6pJCidYM9GVxDsi+RtZdVyGXTZhgDUYpTj/yL2h5l66StsuUvLMtCbd7JjQ33CSzb/leLxJRU+qg5cKviOUMdx9gMuxorhpP2bWDRSZ8ATnOC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqfty/jYzKnLc/JEwSMOvq4UGNN3rkOgV9qEyvqXUKk=;
 b=n64CdEgPJ1UDXeKA3Y/TzoDiU3THuBa5cS5t71W1AzjQZEg8xMdm8ACRoGk6yul1+MzeLeqXV2FN7rjYiqaTaZAXx0ljtKxmHcNLfoU4zsfxNZT3s/smP2SDAiQAhl3b92YVOAWDuffmaWIaViBwuk3xpeAEXXZAGPx4LlYLW/ahL+5V7oO4GnFjnyzdCBsRwiM4uRTqmLOjqoZd9+ilS1rRxUi8ksXSjjQzzX/cKZyXLzBu06TsM2T0k6q1wlrKeS1J8ofrqefsOKus9nuPyPVzkQt1cviwNez2Nv8rE0t/UFtAy4FgW3E2BUjLYMw2xhbbek/xLiOpka2JvKk7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqfty/jYzKnLc/JEwSMOvq4UGNN3rkOgV9qEyvqXUKk=;
 b=Oez1GLALNnZ7ZOHXzkFw5O4oWPXVqDTzBqlvolwaBEO/3htdDPZd2tcMtzaYBFZWV1rpfBk/D9FHNmATP4ivqTZSlp/uCcf53r9ZfuaCf1e8Z+EkUsDx3eZpsEitmTcuYRT/0QgIrac1W7E9z+dzxOEEVy+Ffvg6pgNVzOUOd6HaPZycGcNSqa6oOqAy05uGb9u5PNqfJAk015DNBwadG1/9SkNegCe5d0U6tc9AX6WzgjqnyFdwTsmthSE4bgtpx82crHK6si5Eq3CTBaoIsmHBhyth5iDLxnBns0WuQrg7lvQ56n8/i0AYGhsVDxi7zj85wj06hA4A80nNh8neow==
Received: from CY5P221CA0147.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::20)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:16:07 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::e5) by CY5P221CA0147.outlook.office365.com
 (2603:10b6:930:6a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:16:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:51 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:48 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 07/16] vdpa/mlx5: Take cvq iotlb lock during refresh
Date: Wed, 18 Oct 2023 20:14:46 +0300
Message-ID: <20231018171456.1624030-9-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ee4425-fdf7-4ec1-8ce4-08dbcffdeacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rodFcS3UTwp91jSJLaHsfhaynSqlJZAsI2PldA7T0Z6t6cqMJT+tECEUGf/RwdhYVQTavQ1AvZVNF9YKPe/y6x59ixMHwQfX+0/QeVK6NPRVB0HQ+lYstGwavufnb6PxiJjQaovBe+Vd7FDYmqC9MnJ+qzNi0vZW6m1jGdVVrtImYoJowtd105/YCijlsn66yyycM65UEPhwkgbOHbiZHSqScso3KQS0DEi055mCYG+nVTgF36QT9I4ORQJ7V0+9YpQCIhx7a/pC5wV4VZf5kc2Uck8BFYFCsF1xOMpeOZGAhHS5McZVMJsD+fQFWA/SLwoYml+xZ6yf0VRmoUhhJVE6W4SFJo/crpV36ZLb0d7XOf2uVe6atzNlZv6qEZPelQyAGixzm0Tajrn8ru9pkF9zIfUaiGLfy7Ep81lmuocxz4aM+hf6VRkPDh+zRiLbQgRtMPnzLLmA9JNCEL0liCQEDZ/fZxLy0KWHWJ9WQtwT+x60E42h8Uyko5izrvtabVJspLNcCQy5Em/BC7jskWMMOZQcRUdJJDN+1K4lLS3aw831tC5jqgM2H1HaAigLFgJYX2FLgwWKg6emuGN2R5m5kyJ0XWhz6tNE4l/1vJBjkqEiuT9x2cWVEHEfuSvVgGOygIu0jndOuSefPMP1YJT+WE2C5V/IPinuelS9qom5yM1PyH518Osomb+JRsrpWJaLjjoyNcC8axkSIoLnjbdKBfcGF2E+QDl9DGxybW8xkvEbuIca4owcdFbT2VNRkRRWicvqiv/rcTwOaBWXcdWu1JD2Ul4/AEl+648hzZc=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(70206006)(54906003)(110136005)(36756003)(83380400001)(336012)(426003)(70586007)(47076005)(2906002)(66574015)(316002)(966005)(478600001)(82740400003)(8676002)(8936002)(36860700001)(41300700001)(40460700003)(26005)(356005)(2616005)(4326008)(40480700001)(7636003)(86362001)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:07.4444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ee4425-fdf7-4ec1-8ce4-08dbcffdeacc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

VGhlIHJlc2xvY2sgaXMgdGFrZW4gd2hpbGUgcmVmcmVzaCBpcyBjYWxsZWQgYnV0IGlvbW11X2xv
Y2sgaXMgbW9yZQpzcGVjaWZpYyB0byB0aGlzIHJlc291cmNlLiBTbyB0YWtlIHRoZSBpb21tdV9s
b2NrIGR1cmluZyBjdnEgaW90bGIKcmVmcmVzaC4KCkJhc2VkIG9uIEV1Z2VuaW8ncyBwYXRjaCBb
MF0uCgpbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDExMjE0MjIxOC43MjU2
MjItNC1lcGVyZXptYUByZWRoYXQuY29tLwoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+ClN1Z2dlc3RlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+ClJldmlld2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4K
U2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Ci0tLQog
ZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIHwgMTAgKysrKysrKysrLQogMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwppbmRleCBm
Y2I2YWUzMmU5ZWQuLjU4NzMwMGU3YzE4ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tci5jCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwpAQCAtNTkwLDExICs1
OTAsMTkgQEAgaW50IG1seDVfdmRwYV91cGRhdGVfY3ZxX2lvdGxiKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldiwKIAkJCQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAogCQkJCXVuc2lnbmVk
IGludCBhc2lkKQogeworCWludCBlcnI7CisKIAlpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9W
RFBBX0NWUV9HUk9VUF0gIT0gYXNpZCkKIAkJcmV0dXJuIDA7CiAKKwlzcGluX2xvY2soJm12ZGV2
LT5jdnEuaW9tbXVfbG9jayk7CisKIAlwcnVuZV9pb3RsYihtdmRldik7Ci0JcmV0dXJuIGR1cF9p
b3RsYihtdmRldiwgaW90bGIpOworCWVyciA9IGR1cF9pb3RsYihtdmRldiwgaW90bGIpOworCisJ
c3Bpbl91bmxvY2soJm12ZGV2LT5jdnEuaW9tbXVfbG9jayk7CisKKwlyZXR1cm4gZXJyOwogfQog
CiBpbnQgbWx4NV92ZHBhX2NyZWF0ZV9kbWFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2
KQotLSAKMi40MS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
