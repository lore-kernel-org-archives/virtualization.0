Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28EEC41513
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B56D421B3;
	Wed, 18 Oct 2023 17:16:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B56D421B3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MKly6PPV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzcpgUZnxB7Z; Wed, 18 Oct 2023 17:16:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDCC0421B7;
	Wed, 18 Oct 2023 17:16:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDCC0421B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E14DC0039;
	Wed, 18 Oct 2023 17:16:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1D49C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B06746F4FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B06746F4FC
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=MKly6PPV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E_hb_DSf3XH2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85AFD6F4F3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85AFD6F4F3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khJOpENTdd3MTcuP4EGZz3oxsfIotYaX3M3SlSxmPlRs2bd6IHNVezF+SY5z56blb0pO7h6pOeclUnSdRdWBMtOxWdtgtdyvX9fRvGVOqCCPSp//ljEGAkuZcnd4z0uecy9ty4d5lreeBXzeQSzENDx3EfSdQj5pfbkg5RvKTOefkeXd4X8d1ZzGwzFYri+u+i7k/Vc25wqM+SMujFAW50KIcRV+s0K5LM8r84K13BUxGhYHdLTDGsigLiS32I3OSiQmYC7SGjaXejsQz2FCyrP/hjQV2DYGaTRGUW9EMPgd5qvtQuiW3qCeFZzriXYzyvrmCoRckk9XkXQN46POPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmILL87kEXieQsFyA46Z/A2SnEkDR6phjuffw0L8hYk=;
 b=MF+j7+RKZs8aGoU0ScZPV9hzh52FnwzcJdJRiZ+EkfHB9/vV8XSTdEwUV58pndJK+TJ1f8vJLR4wGOm+VQ6ymmBQKORrcEJv8U77xo3jYt5wHKnCHZcXmn4+s+nfHo3irmoAQxXzwiRm4Zecb6S2dh+aXb4pceBoSFbRHUZ71yZwxk2QsfdsflENdMJgc141eb7NY5+gofD6LA4DCf6RzR0PyA7DL0IRJmj8b3r9UrRNgChxo0ju1tvi8A6bxdGeRcnz+EcuO+33Ibyktaff/Xktzoh4eEuZ3u2Vn+4UN9mBO3Ftsvb7VljI/y83TcZvQP2/t8mP3QxRkABk28klKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmILL87kEXieQsFyA46Z/A2SnEkDR6phjuffw0L8hYk=;
 b=MKly6PPV9EtsnmXliLkOQxWB9Ns59Jq09zFbCkbnm/y48+cxmzonufoWzA6CT/tkcI46lInqpyVMQFfDBjI59eCGnu5BsjcMXUU9s8Fi72I1uF807z6ZgJRDTO7HG7I5vbiD3M6qa9ne4pnnGEsHFJrgDwG1ykcl9N3pMlQN6Ks869W2lHgH94bvBtcZNbqU2nausRctqmocL979BqHKfIfJdYO4oe97MZGOeeCu9EQ69veqQVedhXOivwyoQ/vHr7VDnpCRVCmx39fYLUfcxFbVhivIXZeigwtt2OU0Ae8K7kbbbUeUqy4A0a/3Jdh0WGFmPFgQewhsZ4GxMtFiNA==
Received: from CY5PR22CA0075.namprd22.prod.outlook.com (2603:10b6:930:80::18)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:16:11 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:80:cafe::f7) by CY5PR22CA0075.outlook.office365.com
 (2603:10b6:930:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:16:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:58 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:55 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 09/16] vdpa/mlx5: Rename mr destroy functions
Date: Wed, 18 Oct 2023 20:14:48 +0300
Message-ID: <20231018171456.1624030-11-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c047f1-d340-4bfb-1f95-08dbcffded36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oosKnh16ICDOtiiBOlH1EWiZ1cPFqU7msq/3X4G+GI7q/buNgHYspwp5ZpPIZFhY2nJvwRrVU9Lm98s3H98fsLjFhxYOS/7IzxGw7bLBzZgRh0H7/Vl+nrcRM3vPuPfqkYgE/2qRzKQHC0UYK4kZZYyW2dggJbtUo8gsQngRQTrzHesQcHEjqY2P+xQEvAMwdvaculY8ybIRRZXS7w28SaXb9j9fRUrKog9xUW+x+dE/d33rZC4Mhs93S8nwqSb2HKfVUVhOywG7V13jhlK+4O5vy4VwQ06pt1nSK1ihaCvc6S9AyXOW1b8fAhfUouupBM6+5LYpIsjnOJh4XEhfWOSBfrdB8dAmfuU1PiZNyD2fcmx8OLapTs5KUOwnAtRAOH0nk9LKAWKUXjcn06b7mqRYVphLIfnQlI4mn1n/TOPrBi+FsGKTzY+NvfU64wYvl++cxKRWStDN4dMCr6mkLOq31Zh7kasPuq2vxXPq1j1YclKImXtgkcYNfBF9H9rO6tJDEoCgXTZZdYx7qaksMIKfqyoCl2A+17w7dBWmJnVTZiX80gqrTfgEdH4KMwP9IC7uybjlpkVbXuKOODKLAV+pD2NvnglkY3BwqE0kimaxc62xWacSV5/5Kf0PjRq4LAOgjKCXHz6WC4CSYDSV1MwckjgVg70/V0FTnFphqFx9LuQufl5E1Ug/jp1UavMzvRSGoDPLVjIc8MYYs3azIm8sVcsghuNu5k46b1zXD+nwUQVVW4Lv9OeXzzNoJ/Al
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(40460700003)(110136005)(316002)(54906003)(7636003)(86362001)(82740400003)(356005)(83380400001)(336012)(426003)(66574015)(478600001)(8936002)(1076003)(26005)(2616005)(6666004)(2906002)(36860700001)(70586007)(70206006)(41300700001)(47076005)(5660300002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:11.5073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c047f1-d340-4bfb-1f95-08dbcffded36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
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
