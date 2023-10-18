Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45953CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E37C541931;
	Wed, 18 Oct 2023 17:16:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E37C541931
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Nn1ur1k7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 56CCqnztO2dt; Wed, 18 Oct 2023 17:16:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E56741930;
	Wed, 18 Oct 2023 17:16:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E56741930
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04A45C0039;
	Wed, 18 Oct 2023 17:16:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8819DC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63C5C421BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63C5C421BE
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Nn1ur1k7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4gbovwcXisE1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91FF9421B9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91FF9421B9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXxYSf60JY0aXF3lsU03Y5CUP15zTk7Q7oq7FacUJHAg/AQprZ9Cr2kXbhsv43n8FrwZvwcU0yx31VB9n4tkKW0vF8Qz7rP1RV8Z1/Hhn5nfFKOTDDVEZnCrYPYI9aZJfKoBEUNL0X6gMJgxemwPfa7bUJq8FRxTbL9+rFKTRnYTwHOPcrhY/cRXO2hiJiVeS0R5pD899XYASrvz5FX/tnmAf7cazKs+D0DcuMurBwPKjCl6uIIYD3XoSOgUdxiDqjI3rDkeebkwATIaCGgkhUiA04+3d3Q1zPj8VApcLUGVKQAjHnT78cxvTno4jHAdl6XDzEAzYH+IomhXK30WlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb2hZXT5+/f8Ri3WhuaZoK6JttuOpOqJz8f5tpo4KeM=;
 b=iNxjNVuFcXgjxWmU2+ujfPKil9V6Fiy+1ueFpiXo093K57PKgHYYERXtjZfsg1NymTMvhWsX7hKs2h5Rq1pXRg7apVjCuaAW6xqJn6D7ZbRhyki6ELdqbJEAu0fOg24bq/32E411zD9uQikT590uQAZGeuFZ91VPODxzpZOcDHzKTWHSgWUiumLuBZ0ihO7i5bGIPNflSCSnhklK7mNl2QWMZ5zB0Vhe2Qe6w4TZCzmpOHEhW4lRmhtT4VHXEjpDbbd6jjO2aRlIgc7pjZTG2dHojOiebarWNNRxHVxQ4lquzhCEWaA6OYssPhq41J0NuUYXLm0+9Ygt/MWbw4pgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb2hZXT5+/f8Ri3WhuaZoK6JttuOpOqJz8f5tpo4KeM=;
 b=Nn1ur1k79NC5ruhUQwoIb+Pc8oXhdlGuzRbnsZ39KNyfMjmd7mDCPSIHTz6DPcbzV3o5zlX66Ga5i42rCfeBVrJe5Bzed975egex200/pmper2gYP/ndb1Yk4glmpFdlEDomFshBe3WJRIuttsPD8Q2zileR6Ze6TiWvtRca2320rHjJqzqpzkEeiejDNfBOaHJUufocyjsHyksi3Mlqw566big+ReC+dIWMFb9PWyjED/TmkZb5gjjxEGFTY8VXiq4/5krWHndLxtK6Ogh7aQe+Zc2nm3LjcpnMCxH0LLTpC94ctwGR3crotqU0PBKtY4VklSO6nwjk7ysv0P+NVA==
Received: from CY5P221CA0154.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::22)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:16:19 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::51) by CY5P221CA0154.outlook.office365.com
 (2603:10b6:930:6a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:19 +0000
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
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:16:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:05 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:16:02 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 11/16] vdpa/mlx5: Move mr mutex out of mr struct
Date: Wed, 18 Oct 2023 20:14:50 +0300
Message-ID: <20231018171456.1624030-13-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: baca3d41-04a9-4979-ead1-08dbcffdf1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DzHpTO8LBf0AWSFkinLAuAlpXVQJx7pa4BZKxV05WPAi9MZpq0bkiZXNYx9kPbA/POG4BVeWWFY+UpkJIsscyz5dnD6CV/aYnfCd5PwhIwtowhM7Zu3NigdI3r5YC5rRNu2Bmr6eRzz0gdhwQDiz5TU5fNDYqYMoWZIoSzfGNMcbZhVNBcfewtYtD4T70FJoH/VsT7TQXas7+K9sczXdiJI44kVa/zWwF14caZAr0FphLx+5oKLq3NlXfKcu4tN3V7Axo/OckjCN1WuvKGIeDeLlRuZumBnw6EkaBI700RFsnyh9xSQ3gWtmfOcIWyiLJD7scs4loBaSypyHtOmQoZB9R9KDf4BbBW9qdCLsJZwg1I9YczDFiQ/yGFnM+O2MyxeX+bDKyK1rMVOR5KPWYuG3VDC2gwXu16+5MCptOO3dwYgJbBBUNJpyLHECbhZ5Gs/3BAnN/9tERap4yE7L2wtcc9cbWN1rvE8I2+tGq8aVYE0rO0TeMlFjkg59aKFixbRQXO44zc0gjfu1BOZHJt+7E5u/2uzJ6hto02R0eDjmeXI4O/WVS3lXOs15tyEOcDJEa9e60VELs5VhCxPU0T2VCNxzG4ZOrDdfJ0xl8mPPqBzh3kPV2/H/uhf3TxxI00uZII2s8Iafr7+Qu/9Tp+vfJxuvMXjfqMLWwaf2mqHeyBa1LswIao5qvnIXqLv1mrh5z00JYn7+DNMmL05UDwtI6cAZxeDmdAHuJfY+bwRG8HBb1Obfb0fQMf/X3Nb
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(2616005)(47076005)(1076003)(426003)(66574015)(336012)(26005)(478600001)(36860700001)(8936002)(83380400001)(41300700001)(2906002)(8676002)(4326008)(6666004)(110136005)(5660300002)(70586007)(316002)(70206006)(54906003)(356005)(7636003)(40480700001)(36756003)(82740400003)(86362001)(66899024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:19.2881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baca3d41-04a9-4979-ead1-08dbcffdf1e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424
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

VGhlIG11dGV4IGlzIG5hbWVkIGxpa2UgaXQgaXMgc3VwcG9zZWQgdG8gcHJvdGVjdCBvbmx5IHRo
ZSBta2V5IGJ1dCBpbgpyZWFsaXR5IGl0IGlzIGEgZ2xvYmFsIGxvY2sgZm9yIGFsbCBtciByZXNv
dXJjZXMuCgpTaGlmdCB0aGUgbXV0ZXggdG8gaXQncyByaWdodGZ1bCBsb2NhdGlvbiAoc3RydWN0
IG1seDVfdmRwYV9kZXYpIGFuZApnaXZlIGl0IGEgbW9yZSBhcHByb3ByaWF0ZSBuYW1lLgoKU2ln
bmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+CkFja2VkLWJ5
OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KQWNrZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1
X3ZkcGEuaCB8ICA0ICsrLS0KIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAgICAgICAgfCAx
MyArKysrKysrLS0tLS0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIHwgIDYg
KysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggYi9kcml2
ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCmluZGV4IDAxZDRlZTU4Y2NiMS4uOWM2YWM0
MmMyMWUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCisr
KyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKQEAgLTM0LDggKzM0LDYgQEAg
c3RydWN0IG1seDVfdmRwYV9tciB7CiAJLyogc3RhdGUgb2YgZHZxIG1yICovCiAJYm9vbCBpbml0
aWFsaXplZDsKIAotCS8qIHNlcmlhbGl6ZSBta2V5IGNyZWF0aW9uIGFuZCBkZXN0cnVjdGlvbiAq
LwotCXN0cnVjdCBtdXRleCBta2V5X210eDsKIAlib29sIHVzZXJfbXI7CiB9OwogCkBAIC05NCw2
ICs5Miw4IEBAIHN0cnVjdCBtbHg1X3ZkcGFfZGV2IHsKIAl1MzIgZ2VuZXJhdGlvbjsKIAogCXN0
cnVjdCBtbHg1X3ZkcGFfbXIgbXI7CisJLyogc2VyaWFsaXplIG1yIGFjY2VzcyAqLworCXN0cnVj
dCBtdXRleCBtcl9tdHg7CiAJc3RydWN0IG1seDVfY29udHJvbF92cSBjdnE7CiAJc3RydWN0IHdv
cmtxdWV1ZV9zdHJ1Y3QgKndxOwogCXVuc2lnbmVkIGludCBncm91cDJhc2lkW01MWDVfVkRQQV9O
VU1WUV9HUk9VUFNdOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIGIv
ZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCmluZGV4IDZmMjllOGVhYWJiMS4uYWJkNmE2ZmIx
MjJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKKysrIGIvZHJpdmVy
cy92ZHBhL21seDUvY29yZS9tci5jCkBAIC01MDksMTEgKzUwOSwxMSBAQCBzdGF0aWMgdm9pZCBf
bWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qg
bWx4NV92ZHBhXwogdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYsCiAJCQkgIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yKQogewotCW11dGV4X2xvY2so
Jm1yLT5ta2V5X210eCk7CisJbXV0ZXhfbG9jaygmbXZkZXYtPm1yX210eCk7CiAKIAlfbWx4NV92
ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsIG1yKTsKIAotCW11dGV4X3VubG9jaygmbXItPm1rZXlfbXR4
KTsKKwltdXRleF91bmxvY2soJm12ZGV2LT5tcl9tdHgpOwogfQogCiB2b2lkIG1seDVfdmRwYV9k
ZXN0cm95X21yX3Jlc291cmNlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCkBAIC01NTAs
OSArNTUwLDEwIEBAIGludCBtbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldiwKIHsKIAlpbnQgZXJyOwogCi0JbXV0ZXhfbG9jaygmbXZkZXYtPm1yLm1rZXlfbXR4
KTsKKwltdXRleF9sb2NrKCZtdmRldi0+bXJfbXR4KTsKIAllcnIgPSBfbWx4NV92ZHBhX2NyZWF0
ZV9tcihtdmRldiwgbXIsIGlvdGxiKTsKLQltdXRleF91bmxvY2soJm12ZGV2LT5tci5ta2V5X210
eCk7CisJbXV0ZXhfdW5sb2NrKCZtdmRldi0+bXJfbXR4KTsKKwogCXJldHVybiBlcnI7CiB9CiAK
QEAgLTU2MywxNCArNTY0LDE0IEBAIGludCBtbHg1X3ZkcGFfaGFuZGxlX3NldF9tYXAoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvCiAJaW50IGVyciA9
IDA7CiAKIAkqY2hhbmdlX21hcCA9IGZhbHNlOwotCW11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7
CisJbXV0ZXhfbG9jaygmbXZkZXYtPm1yX210eCk7CiAJaWYgKG1yLT5pbml0aWFsaXplZCkgewog
CQltbHg1X3ZkcGFfaW5mbyhtdmRldiwgIm1lbW9yeSBtYXAgdXBkYXRlXG4iKTsKIAkJKmNoYW5n
ZV9tYXAgPSB0cnVlOwogCX0KIAlpZiAoISpjaGFuZ2VfbWFwKQogCQllcnIgPSBfbWx4NV92ZHBh
X2NyZWF0ZV9tcihtdmRldiwgbXIsIGlvdGxiKTsKLQltdXRleF91bmxvY2soJm1yLT5ta2V5X210
eCk7CisJbXV0ZXhfdW5sb2NrKCZtdmRldi0+bXJfbXR4KTsKIAogCXJldHVybiBlcnI7CiB9CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jIGIvZHJpdmVycy92
ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYwppbmRleCBkNWE1OWM5MDM1ZmIuLjVjNWE0MWI2NGJm
YyAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNvdXJjZXMuYworKysgYi9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCkBAIC0yNTYsNyArMjU2LDcgQEAgaW50
IG1seDVfdmRwYV9hbGxvY19yZXNvdXJjZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQog
CQltbHg1X3ZkcGFfd2FybihtdmRldiwgInJlc291cmNlcyBhbHJlYWR5IGFsbG9jYXRlZFxuIik7
CiAJCXJldHVybiAtRUlOVkFMOwogCX0KLQltdXRleF9pbml0KCZtdmRldi0+bXIubWtleV9tdHgp
OworCW11dGV4X2luaXQoJm12ZGV2LT5tcl9tdHgpOwogCXJlcy0+dWFyID0gbWx4NV9nZXRfdWFy
c19wYWdlKG1kZXYpOwogCWlmIChJU19FUlIocmVzLT51YXIpKSB7CiAJCWVyciA9IFBUUl9FUlIo
cmVzLT51YXIpOwpAQCAtMzAxLDcgKzMwMSw3IEBAIGludCBtbHg1X3ZkcGFfYWxsb2NfcmVzb3Vy
Y2VzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKIGVycl91Y3R4OgogCW1seDVfcHV0X3Vh
cnNfcGFnZShtZGV2LCByZXMtPnVhcik7CiBlcnJfdWFyczoKLQltdXRleF9kZXN0cm95KCZtdmRl
di0+bXIubWtleV9tdHgpOworCW11dGV4X2Rlc3Ryb3koJm12ZGV2LT5tcl9tdHgpOwogCXJldHVy
biBlcnI7CiB9CiAKQEAgLTMxOCw2ICszMTgsNiBAQCB2b2lkIG1seDVfdmRwYV9mcmVlX3Jlc291
cmNlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCiAJZGVhbGxvY19wZChtdmRldiwgcmVz
LT5wZG4sIHJlcy0+dWlkKTsKIAlkZXN0cm95X3VjdHgobXZkZXYsIHJlcy0+dWlkKTsKIAltbHg1
X3B1dF91YXJzX3BhZ2UobXZkZXYtPm1kZXYsIHJlcy0+dWFyKTsKLQltdXRleF9kZXN0cm95KCZt
dmRldi0+bXIubWtleV9tdHgpOworCW11dGV4X2Rlc3Ryb3koJm12ZGV2LT5tcl9tdHgpOwogCXJl
cy0+dmFsaWQgPSBmYWxzZTsKIH0KLS0gCjIuNDEuMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
