Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEFCC001DF
	for <virtualization@archiver.kernel.org>; Wed,  2 Aug 2023 17:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A763482173;
	Wed,  2 Aug 2023 17:13:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A763482173
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cvCPZyaC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eh07eVCUOJ-D; Wed,  2 Aug 2023 17:13:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EDA3982053;
	Wed,  2 Aug 2023 17:13:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDA3982053
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAA10C0071;
	Wed,  2 Aug 2023 17:13:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC3BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 489FA4151D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:13:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 489FA4151D
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=cvCPZyaC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T3uci7Eaup40
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:13:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::628])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68E0840AB5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:13:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68E0840AB5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IavSKqK64YjUSvBo4hps72Hs1aAbpsJDk2lYlUu5hk1AndYdMQ6CRs9yDTY0KHELrKo1t+dSnJVL+ggH9t7D6Nsbp/J9xWhwWSu+ri0QrnOpy5JaqcqF7uJLqCiAi4JcRXkl+zlj1AwcZd2zMHPJIH9W2Q646LmNe7BNwQkNfe7KsHbm0XHuJ2OsnYVVc6RgaKqOqHa9NQBgrm5llg+0oJrApwNxmbfmqOOcSJqSy30CfoGl0nxwF/PH32Uyh6HgOlbM2OrIWLeqkSUEe2dTzSCaIcyDPC5or5Vi89iDAZaeFBsS4jVi8PwTr6beR1fK7IJ4exlosyxxJoxkkWVd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3o64W6AxgCasG8EB+Q2EH9SyaH2V1AMN/IpgxvfuVs=;
 b=Hb6Dtycl6qkai1ebLP7oi+5Y8Ry0K9NPaqUEujnDgeF9ya7eXREAukAcrmYHIoSKWYtsYFc9DSbuiV4I2e5jDSrMQ4DOTea5B3I9Rg85Z1XCIj3zagLRHNr+khUJmnabkrqO466IQj20ruwulfo45WGHxV1jzbXTvUhTX2bMuinAPVxfiFFUcosB6+36jWp4rceilYwTZeListn+b88/yiZ6poJetYbEwUDDalS6wvQwVmHe8zWUqvIN7RkpXEW+eEVnD3+fJUrl9quYQxAAWdlVvoDlSuXORnPxXnZIOMbfKkBxL1+rF5vqctGLCxgPKo5vS14WE8SwmUUeWBy6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3o64W6AxgCasG8EB+Q2EH9SyaH2V1AMN/IpgxvfuVs=;
 b=cvCPZyaCfaccG4etB2GxvLGzW7+Lk1cgP0eHYtKczFv1vvUb3nmbTvyu7uzU13SfZtOANUMlMnakdDizy2XCgT1/Qdv8POug8z2l2bth8VaG04T85axBquZ2lIMtG2Vv7Ddy1biV8XC0X0CmCWLJ31402wCXzHE8VyFe+LtnbVNn7cIzVdFtLMg1V/VgFI7NM1L3SCCsPmqSM2BdFgieO7WAyQP/QqEZDvZs6pYktlJekU1keoyMtce089clFVEYm5Q3y+3CSf7GHZKpl1lQ17Q4lqzUwoC7JOg1TaKh9tAZ55KZ6rIvcDC846/K63IiyvNVsokEj/6e7pK8zFdsgg==
Received: from MW4PR03CA0096.namprd03.prod.outlook.com (2603:10b6:303:b7::11)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:13:08 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::72) by MW4PR03CA0096.outlook.office365.com
 (2603:10b6:303:b7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 17:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Wed, 2 Aug 2023 17:13:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 10:12:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 10:12:53 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 2 Aug 2023 10:12:50 -0700
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Date: Wed, 2 Aug 2023 20:12:18 +0300
Message-ID: <20230802171231.11001-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802171231.11001-1-dtatulea@nvidia.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d91cf9-007c-40ad-25b5-08db937bbddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ebzthq04FOkvko+bkA4hJChFsnc701BWXCqTZ7KAlO+zHhcFSd6zjT0c7euDAf7YyyZkZbY2AErdRGkcRmhtqrB5fBaTEYocUxWobBa69ad2Z4VQIVITWnpBTg3dDznbP5/5wbXfMYruZryzcy6fSKhloN0Qakc4FcXTKBdFKDI2rzW4KYzD9nZY2dXoSzps20Ny7mbSTxTyk2awKssEecvSxdXTMAYKzL4NO78gNn4hgIs0P6zFyUkuQNklqiavplQ7LBMzmEsBbTtXt9p0Lo3HBIet5dlPUf7Nwl/XSgVfxXWjyq8EGS9U7PYS9GzSYiDCU07JQu8ztSn12aajbc4YIagvSftCVQ/Tl4Nyqc2dF6ZV9XfR3OS0O+cKci9SNAbtuYxICn9/++p2ZVazW+Nl6XGxKo4pIcd1PxE0R+u1/12BMcramAWhwHi/GdIO9hiT83lco0Kalo7m5FK88KFkcIy1eHr5SoCAlxqZH8/khWM5zWpodsH/BmltGtmphoGHd7JgKAI0Fe5kCaKwlwCiJ5HKIfnQxG5LgqG6cfqztYEAwPnKe+l82egTF3CBFY0nwx52vnARH4BXv1rxdZDGQvEGu6wZt7q4l1dSMoG6U41LxgIh8k0ADWy55MgekFxjk7LEKKRdnF04J+yEup2KNVzhaNZVOnJ6BdSUF3zkVpcCykTM/Intial52DoSBU2oKMkEAccl9qPr1v28IUL7k0Y1z1pRjRrRZs13e/EAyFbwtlPEwoG8ylPDz2P
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(36756003)(2616005)(66574015)(426003)(5660300002)(8936002)(186003)(36860700001)(8676002)(47076005)(83380400001)(26005)(336012)(478600001)(4326008)(70206006)(54906003)(110136005)(316002)(6666004)(41300700001)(70586007)(86362001)(40480700001)(40460700003)(1076003)(2906002)(356005)(7636003)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:13:07.7010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d91cf9-007c-40ad-25b5-08db937bbddb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Gal Pressman <gal@nvidia.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

VGhlIG1yLT5pbml0aWFsaXplZCBmbGFnIGlzIHNoYXJlZCBiZXR3ZWVuIHRoZSBjb250cm9sIHZx
IGFuZCBkYXRhIHZxCnBhcnQgb2YgdGhlIG1yIGluaXQvdW5pbml0LiBCdXQgaWYgdGhlIGNvbnRy
b2wgdnEgYW5kIGRhdGEgdnEgZ2V0IHBsYWNlZAppbiBkaWZmZXJlbnQgQVNJRHMsIGl0IGNhbiBo
YXBwZW4gdGhhdCBpbml0aWFsaXppbmcgdGhlIGNvbnRyb2wgdnEgd2lsbApwcmV2ZW50IHRoZSBk
YXRhIHZxIG1yIGZyb20gYmVpbmcgaW5pdGlhbGl6ZWQuCgpUaGlzIHBhdGNoIGNvbnNvbGlkYXRl
cyB0aGUgY29udHJvbCBhbmQgZGF0YSB2cSBpbml0IHBhcnRzIGludG8gdGhlaXIKb3duIGluaXQg
ZnVuY3Rpb25zLiBUaGUgbXItPmluaXRpYWxpemVkIHdpbGwgbm93IGJlIHVzZWQgZm9yIHRoZSBk
YXRhIHZxCm9ubHkuIFRoZSBjb250cm9sIHZxIGN1cnJlbnRseSBkb2Vzbid0IG5lZWQgYSBmbGFn
LgoKVGhlIHVuaW5pdGlhbGl6aW5nIHBhcnQgaXMgYWxzbyB0YWtlbiBjYXJlIG9mOiBtbHg1X3Zk
cGFfZGVzdHJveV9tciBnb3QKc3BsaXQgaW50byBkYXRhIGFuZCBjb250cm9sIHZxIGZ1bmN0aW9u
cyB3aGljaCBhcmUgbm93IGFsc28gQVNJRCBhd2FyZS4KCkZpeGVzOiA4ZmNkMjBjMzA3MDQgKCJ2
ZHBhL21seDU6IFN1cHBvcnQgZGlmZmVyZW50IGFkZHJlc3Mgc3BhY2VzIGZvciBjb250cm9sIGFu
ZCBkYXRhIikKU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5j
b20+ClJldmlld2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KUmV2
aWV3ZWQtYnk6IEdhbCBQcmVzc21hbiA8Z2FsQG52aWRpYS5jb20+Ci0tLQogZHJpdmVycy92ZHBh
L21seDUvY29yZS9tbHg1X3ZkcGEuaCB8ICAxICsKIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIu
YyAgICAgICAgfCA5NyArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KIDIgZmlsZXMgY2hh
bmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUv
bWx4NV92ZHBhLmgKaW5kZXggMjVmYzQxMjBiNjE4Li5hMDQyMGJlNTA1OWYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKKysrIGIvZHJpdmVycy92ZHBhL21s
eDUvY29yZS9tbHg1X3ZkcGEuaApAQCAtMzEsNiArMzEsNyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX21y
IHsKIAlzdHJ1Y3QgbGlzdF9oZWFkIGhlYWQ7CiAJdW5zaWduZWQgbG9uZyBudW1fZGlyZWN0czsK
IAl1bnNpZ25lZCBsb25nIG51bV9rbG1zOworCS8qIHN0YXRlIG9mIGR2cSBtciAqLwogCWJvb2wg
aW5pdGlhbGl6ZWQ7CiAKIAkvKiBzZXJpYWxpemUgbWtleSBjcmVhdGlvbiBhbmQgZGVzdHJ1Y3Rp
b24gKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbXIuYwppbmRleCAwM2U1NDMyMjk3OTEuLjRhZTE0YTI0OGE0YiAxMDA2
NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCisrKyBiL2RyaXZlcnMvdmRwYS9t
bHg1L2NvcmUvbXIuYwpAQCAtNDg5LDYwICs0ODksMTAzIEBAIHN0YXRpYyB2b2lkIGRlc3Ryb3lf
dXNlcl9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfbXIg
Km1yCiAJfQogfQogCi12b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldikKK3N0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9jdnFfbXIoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKK3sKKwlpZiAobXZkZXYt
Pmdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gIT0gYXNpZCkKKwkJcmV0dXJuOworCisJ
cHJ1bmVfaW90bGIobXZkZXYpOworfQorCitzdGF0aWMgdm9pZCBfbWx4NV92ZHBhX2Rlc3Ryb3lf
ZHZxX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50IGFzaWQpCiB7
CiAJc3RydWN0IG1seDVfdmRwYV9tciAqbXIgPSAmbXZkZXYtPm1yOwogCi0JbXV0ZXhfbG9jaygm
bXItPm1rZXlfbXR4KTsKKwlpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9H
Uk9VUF0gIT0gYXNpZCkKKwkJcmV0dXJuOworCiAJaWYgKCFtci0+aW5pdGlhbGl6ZWQpCi0JCWdv
dG8gb3V0OworCQlyZXR1cm47CiAKLQlwcnVuZV9pb3RsYihtdmRldik7CiAJaWYgKG1yLT51c2Vy
X21yKQogCQlkZXN0cm95X3VzZXJfbXIobXZkZXYsIG1yKTsKIAllbHNlCiAJCWRlc3Ryb3lfZG1h
X21yKG12ZGV2LCBtcik7CiAKIAltci0+aW5pdGlhbGl6ZWQgPSBmYWxzZTsKLW91dDoKK30KKwor
c3RhdGljIHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQoreworCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1y
ID0gJm12ZGV2LT5tcjsKKworCW11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7CisKKwlfbWx4NV92
ZHBhX2Rlc3Ryb3lfZHZxX21yKG12ZGV2LCBhc2lkKTsKKwlfbWx4NV92ZHBhX2Rlc3Ryb3lfY3Zx
X21yKG12ZGV2LCBhc2lkKTsKKwogCW11dGV4X3VubG9jaygmbXItPm1rZXlfbXR4KTsKIH0KIAot
c3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYsCi0JCQkJc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwgdW5zaWduZWQgaW50IGFzaWQpCit2
b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKK3sK
KwltbHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lkKG12ZGV2LCBtdmRldi0+Z3JvdXAyYXNpZFtNTFg1
X1ZEUEFfQ1ZRX0dST1VQXSk7CisJbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChtdmRldiwgbXZk
ZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9VUF0pOworfQorCitzdGF0aWMgaW50
IF9tbHg1X3ZkcGFfY3JlYXRlX2N2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCisJ
CQkJICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCisJCQkJICAgIHVuc2lnbmVkIGludCBh
c2lkKQoreworCWlmIChtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfQ1ZRX0dST1VQXSAhPSBh
c2lkKQorCQlyZXR1cm4gMDsKKworCXJldHVybiBkdXBfaW90bGIobXZkZXYsIGlvdGxiKTsKK30K
Kworc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9kdnFfbXIoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2LAorCQkJCSAgICBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAorCQkJCSAgICB1
bnNpZ25lZCBpbnQgYXNpZCkKIHsKIAlzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+
bXI7CiAJaW50IGVycjsKIAotCWlmIChtci0+aW5pdGlhbGl6ZWQpCisJaWYgKG12ZGV2LT5ncm91
cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBdICE9IGFzaWQpCiAJCXJldHVybiAwOwogCi0J
aWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBdID09IGFzaWQpIHsK
LQkJaWYgKGlvdGxiKQotCQkJZXJyID0gY3JlYXRlX3VzZXJfbXIobXZkZXYsIGlvdGxiKTsKLQkJ
ZWxzZQotCQkJZXJyID0gY3JlYXRlX2RtYV9tcihtdmRldiwgbXIpOworCWlmIChtci0+aW5pdGlh
bGl6ZWQpCisJCXJldHVybiAwOwogCi0JCWlmIChlcnIpCi0JCQlyZXR1cm4gZXJyOwotCX0KKwlp
ZiAoaW90bGIpCisJCWVyciA9IGNyZWF0ZV91c2VyX21yKG12ZGV2LCBpb3RsYik7CisJZWxzZQor
CQllcnIgPSBjcmVhdGVfZG1hX21yKG12ZGV2LCBtcik7CiAKLQlpZiAobXZkZXYtPmdyb3VwMmFz
aWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gPT0gYXNpZCkgewotCQllcnIgPSBkdXBfaW90bGIobXZk
ZXYsIGlvdGxiKTsKLQkJaWYgKGVycikKLQkJCWdvdG8gb3V0X2VycjsKLQl9CisJaWYgKGVycikK
KwkJcmV0dXJuIGVycjsKIAogCW1yLT5pbml0aWFsaXplZCA9IHRydWU7CisKKwlyZXR1cm4gMDsK
K30KKworc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYsCisJCQkJc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwgdW5zaWduZWQgaW50IGFz
aWQpCit7CisJaW50IGVycjsKKworCWVyciA9IF9tbHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihtdmRl
diwgaW90bGIsIGFzaWQpOworCWlmIChlcnIpCisJCXJldHVybiBlcnI7CisKKwllcnIgPSBfbWx4
NV92ZHBhX2NyZWF0ZV9jdnFfbXIobXZkZXYsIGlvdGxiLCBhc2lkKTsKKwlpZiAoZXJyKQorCQln
b3RvIG91dF9lcnI7CisKIAlyZXR1cm4gMDsKIAogb3V0X2VycjoKLQlpZiAobXZkZXYtPmdyb3Vw
MmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9VUF0gPT0gYXNpZCkgewotCQlpZiAoaW90bGIpCi0J
CQlkZXN0cm95X3VzZXJfbXIobXZkZXYsIG1yKTsKLQkJZWxzZQotCQkJZGVzdHJveV9kbWFfbXIo
bXZkZXYsIG1yKTsKLQl9CisJX21seDVfdmRwYV9kZXN0cm95X2R2cV9tcihtdmRldiwgYXNpZCk7
CiAKIAlyZXR1cm4gZXJyOwogfQotLSAKMi40MS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
