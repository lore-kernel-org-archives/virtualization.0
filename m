Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72D9E95A8E
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 628D861257;
	Mon,  9 Oct 2023 11:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 628D861257
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nPe5FB2u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xlzZ5Ac0pHWt; Mon,  9 Oct 2023 11:25:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4821C61191;
	Mon,  9 Oct 2023 11:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4821C61191
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24108C0039;
	Mon,  9 Oct 2023 11:25:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6ECBC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E9D681EFA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E9D681EFA
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=nPe5FB2u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L1JcaZzf3kBb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F85F81FDE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F85F81FDE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km/uYejK0JdKLY0ZOuEP1RYuptg+IJBkcpwURBIloic9xv8tD+sYw8TfXltkMCqIacPBv2l8P050caeDx3ssEjT8264AXEeCWMUAP6KNOW8LvQ/2xngjGBOf2Jay20YozAR50YVFdgP848phdqITDJqNpewiiqitWFSvcMsCTbGWoA5+VoQVI7KQnq5re2lbuFrjjbOK9+e6hJXqvEantg5t/4CsEpSORQLd9tKsT+BsaYceZtIeWaofqcCMMpth8tHSwRjPanYPJGYlztc/EVxJcJHIncsu1Fe2yxQ7aat0FkIysSc7zmDjP5yHK6uiFCczoRVVsDZdgq1lQe4moA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmILL87kEXieQsFyA46Z/A2SnEkDR6phjuffw0L8hYk=;
 b=PPoEK96kq5EmT0rXh/JqojfaUFGdQ+qBkACjr6oycAFamAwoxAOuEajVNQUs6deElb1GcmIC0nAta3DUQauowbBID72AQnrCUUHhRjqWJawGQFumf7IF3z0QS3FR+gIdQTEwVZTH5dVxnNSr7kGMtM5QkJbd4/JHGvSolpH6ekmiISDNoiyo1moX+Xv5qDyuBTQQqTGefbiKLPoHybApUB6KGhIQs8TNzlKUHM/n/LVyNb8k3OzDwCFOYrbp0FezJvgKuvfVCqlTCPxA8Ln6TFz0XT6biqlNX2XdtlnT9zXep3WEKIMKXRvuGpNpboy1b/3zClyGug4DUheYVN3tIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmILL87kEXieQsFyA46Z/A2SnEkDR6phjuffw0L8hYk=;
 b=nPe5FB2uMbRG/Y45h2BHZgVn7z3Z8COr0xlo2GKNw8VXXYwgMEg47iTq2Ja1dsBvG7dSoZpKCvPmYpOBSJluq0gBBBJaSRgSXz24RhNq32w83jhFDGT9B78NpqanWDNSFGAsF5iZjGa8bqglwzhDL3wJvsVNTfGapB7jAWqlLP3NvJYDpx2TsobvTikRhZlem+sqkMVJaITBQAz0EPPylLvITd3NQGN1u/XZ0/5sOIsmtAH4dlBiSd1OAu70dIq6PPveRUu43G5E68WCcA2/jQwGq0KIYZ/hC4n+5QeBVHjk6dDpGWcvJw8d9Dsz4UusRYD+Tk6EeZWgE/wnm/v67w==
Received: from BL1PR13CA0100.namprd13.prod.outlook.com (2603:10b6:208:2b9::15)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 11:25:04 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::6e) by BL1PR13CA0100.outlook.office365.com
 (2603:10b6:208:2b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Mon, 9 Oct 2023 11:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 11:25:04 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:50 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:47 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 09/16] vdpa/mlx5: Rename mr destroy functions
Date: Mon, 9 Oct 2023 14:23:54 +0300
Message-ID: <20231009112401.1060447-10-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 2300e617-f3c9-4e6c-c03c-08dbc8ba627c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/9jXqU6tSJpGrYmBXdPOuQ4qTbWe6702nXYaU2k7+Lbgk1kmSVwXWH+jI2nJ+QdaFf+iR7bDaTn5nsmz+a3PQoy5h+gxgZLvGJdk/5HpYDmWFUSQvn8xe1sNUIN6ySl86id6vd7HS5b/LKbD4RUc1vu7EXliAYouWKXzjQQvReozF1G2+tHfRvO6ffi+iFMOsXiY4ptbDsqufqAb4M7P83syUeGHr989s2rnkj3h8jKuQceFItSUWfXNRqOeuMD6diakN3TYmLHqZwMtlGB84vdtJPIGIXkLUUb1p0UKczm4D8+k2wEAABh+epVHTc3onEdyRtLqSDcJKYGHEKDthmnfN0tN9nqmC9n6a9+ySMH/9w6iFWxupPOzJy9/NymrYxwG0CAgnZ5LPOUqwXQzx9xguhBJ2q3E/B2KT8r8a7JvXxwhkUJc0CMsneWEBOaEsm1z+ZooANvtgwb6mx4Jhh7WHXXuJsh8z3rxTiNcIGOIYrc4qwol4/HWrf8kVbHWgtGC4fawQ75qHBn4Wh2XVl0E5W6mlWHf0HvFImqlB5Gcu/vawE8jJEAErTTKcdzSRFLluQ8fUCKA2LP5Qs9vkK8DRTzAHQ9biV5ZncrLggnsfF93ZqVouRLWtgMXmygPff4SrMupAH9RA3c2BnmjMZCtvOeWoCLNOPQ7KgIHPqRNETgtaJf0yMop2hn+HRsyIRQkZ2aNuoqM2kyKv+B1ZY4XVdAhXVeMrYrFpVXZ+q+cSZdobd0AqgNINgQx9dO
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(2616005)(1076003)(478600001)(41300700001)(66574015)(336012)(426003)(47076005)(26005)(83380400001)(2906002)(5660300002)(110136005)(70586007)(70206006)(54906003)(316002)(4326008)(8676002)(8936002)(40460700003)(82740400003)(36860700001)(356005)(36756003)(40480700001)(7636003)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:25:04.2997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2300e617-f3c9-4e6c-c03c-08dbc8ba627c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
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

TWFrZSBtbHg1X2Rlc3Ryb3lfbXIgc3ltbWV0cmljIHRvIG1seDVfY3JlYXRlX21yLgoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CkFja2VkLWJ5OiBFdWdlbmlvIFDD
qXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEg
PGR0YXR1bGVhQG52aWRpYS5jb20+Ci0tLQogZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3Zk
cGEuaCB8ICA0ICsrLS0KIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAgICAgICAgfCAgNiAr
KystLS0KIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCAxMiArKysrKystLS0t
LS0KIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBiL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKaW5kZXggNTU0ODk5YTgwMjQxLi5lMWU2ZTdhYmE1
MGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKKysrIGIv
ZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaApAQCAtMTE4LDggKzExOCw4IEBAIGlu
dCBtbHg1X3ZkcGFfaGFuZGxlX3NldF9tYXAoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBz
dHJ1Y3Qgdmhvc3RfaW90bGIgKmlvCiAJCQkgICAgIGJvb2wgKmNoYW5nZV9tYXAsIHVuc2lnbmVk
IGludCBhc2lkKTsKIGludCBtbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKIAkJCXVuc2lnbmVkIGludCBhc2lk
KTsKLXZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2
KTsKLXZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKTsKK3ZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfcmVz
b3VyY2VzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldik7Cit2b2lkIG1seDVfdmRwYV9kZXN0
cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50IGFzaWQpOwog
aW50IG1seDVfdmRwYV91cGRhdGVfY3ZxX2lvdGxiKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diwKIAkJCQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAogCQkJCXVuc2lnbmVkIGludCBhc2lk
KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbXIuYwppbmRleCBmZGUwMDQ5N2Y0YWQuLjAwZGNjZTE5MGExZiAxMDA2NDQK
LS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbXIuYwpAQCAtNTA3LDcgKzUwNyw3IEBAIHN0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVz
dHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkCiAJ
bXItPmluaXRpYWxpemVkID0gZmFsc2U7CiB9CiAKLXZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJf
YXNpZChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQordm9p
ZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2ln
bmVkIGludCBhc2lkKQogewogCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5tcjsK
IApAQCAtNTE4LDkgKzUxOCw5IEBAIHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQogCW11dGV4X3VubG9j
aygmbXItPm1rZXlfbXR4KTsKIH0KIAotdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYpCit2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yX3Jlc291cmNl
cyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCiB7Ci0JbWx4NV92ZHBhX2Rlc3Ryb3lfbXJf
YXNpZChtdmRldiwgbXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9VUF0pOwor
CW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2LCBtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFf
REFUQVZRX0dST1VQXSk7CiAJcHJ1bmVfaW90bGIobXZkZXYpOwogfQogCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKaW5kZXggYWE0ODk2NjYyNjk5Li5hYjE5NmM0MzY5NGMgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYworKysgYi9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKQEAgLTI2NDQsNyArMjY0NCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92
ZHBhX2NoYW5nZV9tYXAoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAogCQlnb3RvIGVycl9t
cjsKIAogCXRlYXJkb3duX2RyaXZlcihuZGV2KTsKLQltbHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lk
KG12ZGV2LCBhc2lkKTsKKwltbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldiwgYXNpZCk7CiAJZXJy
ID0gbWx4NV92ZHBhX2NyZWF0ZV9tcihtdmRldiwgaW90bGIsIGFzaWQpOwogCWlmIChlcnIpCiAJ
CWdvdG8gZXJyX21yOwpAQCAtMjY2MCw3ICsyNjYwLDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFf
Y2hhbmdlX21hcChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCiAJcmV0dXJuIDA7CiAKIGVy
cl9zZXR1cDoKLQltbHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lkKG12ZGV2LCBhc2lkKTsKKwltbHg1
X3ZkcGFfZGVzdHJveV9tcihtdmRldiwgYXNpZCk7CiBlcnJfbXI6CiAJcmV0dXJuIGVycjsKIH0K
QEAgLTI3OTcsNyArMjc5Nyw3IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQogZXJyX2RyaXZlcjoKIAl1bnJlZ2lz
dGVyX2xpbmtfbm90aWZpZXIobmRldik7CiBlcnJfc2V0dXA6Ci0JbWx4NV92ZHBhX2Rlc3Ryb3lf
bXIoJm5kZXYtPm12ZGV2KTsKKwltbHg1X3ZkcGFfZGVzdHJveV9tcl9yZXNvdXJjZXMoJm5kZXYt
Pm12ZGV2KTsKIAluZGV2LT5tdmRldi5zdGF0dXMgfD0gVklSVElPX0NPTkZJR19TX0ZBSUxFRDsK
IGVycl9jbGVhcjoKIAl1cF93cml0ZSgmbmRldi0+cmVzbG9jayk7CkBAIC0yODI0LDcgKzI4MjQs
NyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYp
CiAJdW5yZWdpc3Rlcl9saW5rX25vdGlmaWVyKG5kZXYpOwogCXRlYXJkb3duX2RyaXZlcihuZGV2
KTsKIAljbGVhcl92cXNfcmVhZHkobmRldik7Ci0JbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoJm5kZXYt
Pm12ZGV2KTsKKwltbHg1X3ZkcGFfZGVzdHJveV9tcl9yZXNvdXJjZXMoJm5kZXYtPm12ZGV2KTsK
IAluZGV2LT5tdmRldi5zdGF0dXMgPSAwOwogCW5kZXYtPm12ZGV2LnN1c3BlbmRlZCA9IGZhbHNl
OwogCW5kZXYtPmN1cl9udW1fdnFzID0gMDsKQEAgLTI5NDQsNyArMjk0NCw3IEBAIHN0YXRpYyB2
b2lkIG1seDVfdmRwYV9mcmVlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKIAluZGV2ID0gdG9f
bWx4NV92ZHBhX25kZXYobXZkZXYpOwogCiAJZnJlZV9yZXNvdXJjZXMobmRldik7Ci0JbWx4NV92
ZHBhX2Rlc3Ryb3lfbXIobXZkZXYpOworCW1seDVfdmRwYV9kZXN0cm95X21yX3Jlc291cmNlcyht
dmRldik7CiAJaWYgKCFpc196ZXJvX2V0aGVyX2FkZHIobmRldi0+Y29uZmlnLm1hYykpIHsKIAkJ
cGZtZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBjaV9waHlzZm4obXZkZXYtPm1kZXYtPnBkZXYpKTsK
IAkJbWx4NV9tcGZzX2RlbF9tYWMocGZtZGV2LCBuZGV2LT5jb25maWcubWFjKTsKQEAgLTM0NzQs
NyArMzQ3NCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdt
dF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKIGVycl9yZXMyOgogCWZyZWVfcmVzb3Vy
Y2VzKG5kZXYpOwogZXJyX21yOgotCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2KTsKKwltbHg1
X3ZkcGFfZGVzdHJveV9tcl9yZXNvdXJjZXMobXZkZXYpOwogZXJyX3JlczoKIAltbHg1X3ZkcGFf
ZnJlZV9yZXNvdXJjZXMoJm5kZXYtPm12ZGV2KTsKIGVycl9tcGZzOgotLSAKMi40MS4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
