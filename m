Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61271E95A91
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 171C460F03;
	Mon,  9 Oct 2023 11:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 171C460F03
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OgI1um3m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k-3oG38g4zta; Mon,  9 Oct 2023 11:25:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6075261179;
	Mon,  9 Oct 2023 11:25:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6075261179
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AB7DC0039;
	Mon,  9 Oct 2023 11:25:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA2CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58E4B408B2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58E4B408B2
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=OgI1um3m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6LBe_ZqLqtRb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C18F4095C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C18F4095C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD0EeCwCGvFWVhY4sSZ/tAJapwKaN9oRiG7jPQ24Dm2ryhzrBZcgg7+KB44ldeUFk501T2TciyH6csMk6Jpm5dMe3wdOUnyQeMjCg9fKqnuRv/d4m/Prwav5UHN28Ez8p0COXOlEu6PYNq3za79sCW1zxggE8fm64jxEwwy9cxNnkhL2zjZeK0B0S0XRpGvSUgRwz1GTq5ORGbLR1iP/VRCXAQw7cdsjJnHbEwab89Le76637DLdhtJlPiHle5PCr4rSgVYpwnoftUbgrVR25hgDOdeGQ5+XC9istwkvyqIlZ1/voHgokS98RuQIs/NF2WoTXc8H0qPyhrNg+BJ+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QovrclrVp/hpPM4yCvipuO0xAMnuUXtRKEW8YwyUiFM=;
 b=W8BNjdBSEx9LlIXX64xWIeHJybyueUD/WiB1ov1EvwBC2KtRGlfZ8yRn5W1Dt5Hsdgu/WKOrrbS2UD6IGnZoJsJWZx68xmyDexmWIg4r2V3WWUxcuRGVlStAZKXDi4ucEy0uJBjBAR81HvNwGXksMElZ3XNr5yq5Q2oG6doAhC9cuEgoQ8dIlpVfsBsyc/S04FYKagCpJ/18BziYPQ4ucDGrRDYstIXBwB8jTSzYHKqDIqHUUX1zHZ82sqICvpr7vQ3J5FvhfkDYh2Xl8X9RXMXmjsHp0KQItiI6RvQ4jVX+UCpxTZm86nVYMJrF7h6j1EHMUCDMvwS3sd9Pr7vgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QovrclrVp/hpPM4yCvipuO0xAMnuUXtRKEW8YwyUiFM=;
 b=OgI1um3mZyGSrL9ztrdTPVGUtvAaoWl8FFIcx1bgsxQ6nJT82YlAhLj8uurbwzxVYnW2AXG2xLdU16yKS+55NO70AGdYh/5+/s2yeeukMP6i+zS+PEoiQj1s9F4uKtZIh0T6LzSOBPtHNv+FyUG66EAhqadgPReBxdu94Tjg170lx401P6YGlgHqZXFfyc55Rx7J9gHnIDy+Q+fTvFs3BNDmtMMBeai4fBLbWZRwSDVgU7I96O/MrKTsX4YLMqIEpRWgTfYNEDGc4SGrPRh9xkIL0XW4/GBHqsGCXqPJRH6jbRMnpu2Co3hHDsg8/fYmvPHbVNrC/DAFb9vL8phm5w==
Received: from SA1P222CA0097.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::24)
 by SJ0PR12MB5635.namprd12.prod.outlook.com (2603:10b6:a03:42a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 11:25:24 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:35e:cafe::5f) by SA1P222CA0097.outlook.office365.com
 (2603:10b6:806:35e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 11:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 11:25:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:25:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:25:08 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:25:05 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 14/16] vdpa/mlx5: Enable hw support for vq descriptor
 mapping
Date: Mon, 9 Oct 2023 14:23:59 +0300
Message-ID: <20231009112401.1060447-15-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SJ0PR12MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: d01de39d-8987-474f-330e-08dbc8ba6e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfwS0H83RW+IgOwrIuMsijPquvm7BNM0MTqv8SNOyQk+rtrDCbdaB6xFosY48C7cFZ8FdDibMEICBKHCbP9DHXw1g5M6/W8Ir5m0guZrrnqnBKdb5Tp2OISRIPEXJ7fIWBFzwJjzZyXcn2O9VCD6fWtOd1AIp1cwayils8jtAEcZuO8UaWjOspwAnJW1o/we4EmgOv+K1T+eF6kLJKlHWSub4cRUwQuL6S/HYIr7SVRQjDHoGUfnTk7mF53V6vQRWM6SfVLJ0brvSLJFhG+MW3DR93Z35bXnxhZUJRcvsGelaeijgzxnKJUJ71g7FSbHQR7MZH2XcLQ1/9+IZolgz0AHy84x0HxVOYUBTYQ3zbTfVjUbUhT+k12Umj1xjSi/dhchNySYTzCAICZMoOfe9liE4ShCRbdU/9o8iiVe4x84sErT0zy48lMNYQZV4rZkpxdViyd6/1qlAnO4VyNJzfnCkzjVTvxB143C+TikRzxxAgc4ovacoXqp8yHn+dE99iZMdt7/XyBkGkwpR4Ah918SRfl4ntUV6hZilxsSU0DJj2SSMMU/9nbQra9y2t/cl1ZEkuadbDd66OoQ349cXN2RKfrHuxa12PDbY8TgkFCqKkNSrlneHlEX9HK9Znu41sztMKzyCZIXtzV0zdQnPpCBuktNQYlEymzzKDj8KkKW+VbZK+z2B/iqBYp3iCOdHYGmo1gTU0f4cpOIJjDWufzRBWLoaGjxIUVkosSUts0gCCnaAn8S+ShkDHzHXrTtJaB3cwuDsWvWus7WMiIq3Eo5JZgt8sop1ViS7aL8CI0=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(82310400011)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(426003)(336012)(26005)(2616005)(86362001)(1076003)(6666004)(36756003)(478600001)(66574015)(36860700001)(47076005)(83380400001)(7636003)(82740400003)(356005)(40480700001)(54906003)(70586007)(70206006)(316002)(110136005)(4326008)(41300700001)(5660300002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:25:24.2266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d01de39d-8987-474f-330e-08dbc8ba6e56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5635
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

VnEgZGVzY3JpcHRvciBtYXBwaW5ncyBhcmUgc3VwcG9ydGVkIGluIGhhcmR3YXJlIGJ5IGZpbGxp
bmcgaW4gYW4KYWRkaXRpb25hbCBta2V5IHdoaWNoIGNvbnRhaW5zIHRoZSBkZXNjcmlwdG9yIG1h
cHBpbmdzIHRvIHRoZSBodyB2cS4KCkEgcHJldmlvdXMgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgYWRk
ZWQgc3VwcG9ydCBmb3IgaHcgbWtleSAobXIpIGNyZWF0aW9uCmZvciBBU0lEIDEuCgpUaGlzIHBh
dGNoIGZpbGxzIGluIGJvdGggdGhlIHZxIGRhdGEgYW5kIHZxIGRlc2NyaXB0b3IgbWtleXMgYmFz
ZWQgb24KZ3JvdXAgQVNJRCBtYXBwaW5nLgoKVGhlIGZlYXR1cmUgaXMgc2lnbmFsZWQgdG8gdGhl
IHZkcGEgY29yZSB0aHJvdWdoIHRoZSBwcmVzZW5jZSBvZiB0aGUKLmdldF92cV9kZXNjX2dyb3Vw
IG9wLgoKQWNrZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KLS0tCiBkcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgIHwgMjQgKysrKysrKysrKysrKysrKysrKysr
KystCiBpbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmNfdmRwYS5oIHwgIDcgKysrKysrLQogMiBm
aWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwppbmRleCAyNWJkMmMzMjRmNWIuLjJlMGEzY2UxYzBjZiAxMDA2NDQK
LS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCisrKyBiL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwpAQCAtODIzLDYgKzgyMyw3IEBAIHN0YXRpYyBpbnQgY3Jl
YXRlX3ZpcnRxdWV1ZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRw
YV92aXJ0cXVlCiAJdTMyIG91dFtNTFg1X1NUX1NaX0RXKGNyZWF0ZV92aXJ0aW9fbmV0X3Ffb3V0
KV0gPSB7fTsKIAlzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSAmbmRldi0+bXZkZXY7CiAJ
c3RydWN0IG1seDVfdmRwYV9tciAqdnFfbXI7CisJc3RydWN0IG1seDVfdmRwYV9tciAqdnFfZGVz
Y19tcjsKIAl2b2lkICpvYmpfY29udGV4dDsKIAl1MTYgbWx4X2ZlYXR1cmVzOwogCXZvaWQgKmNt
ZF9oZHI7CkBAIC04NzgsNiArODc5LDExIEBAIHN0YXRpYyBpbnQgY3JlYXRlX3ZpcnRxdWV1ZShz
dHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVlCiAJdnFf
bXIgPSBtdmRldi0+bXJbbXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9VUF1d
OwogCWlmICh2cV9tcikKIAkJTUxYNV9TRVQodmlydGlvX3EsIHZxX2N0eCwgdmlydGlvX3FfbWtl
eSwgdnFfbXItPm1rZXkpOworCisJdnFfZGVzY19tciA9IG12ZGV2LT5tclttdmRldi0+Z3JvdXAy
YXNpZFtNTFg1X1ZEUEFfREFUQVZRX0RFU0NfR1JPVVBdXTsKKwlpZiAodnFfZGVzY19tcikKKwkJ
TUxYNV9TRVQodmlydGlvX3EsIHZxX2N0eCwgZGVzY19ncm91cF9ta2V5LCB2cV9kZXNjX21yLT5t
a2V5KTsKKwogCU1MWDVfU0VUKHZpcnRpb19xLCB2cV9jdHgsIHVtZW1fMV9pZCwgbXZxLT51bWVt
MS5pZCk7CiAJTUxYNV9TRVQodmlydGlvX3EsIHZxX2N0eCwgdW1lbV8xX3NpemUsIG12cS0+dW1l
bTEuc2l6ZSk7CiAJTUxYNV9TRVQodmlydGlvX3EsIHZxX2N0eCwgdW1lbV8yX2lkLCBtdnEtPnVt
ZW0yLmlkKTsKQEAgLTIyNjUsNiArMjI3MSwxNiBAQCBzdGF0aWMgdTMyIG1seDVfdmRwYV9nZXRf
dnFfZ3JvdXAoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KQogCXJldHVybiBNTFg1
X1ZEUEFfREFUQVZRX0dST1VQOwogfQogCitzdGF0aWMgdTMyIG1seDVfdmRwYV9nZXRfdnFfZGVz
Y19ncm91cChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgpCit7CisJc3RydWN0IG1s
eDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7CisKKwlpZiAoaXNfY3RybF92cV9p
ZHgobXZkZXYsIGlkeCkpCisJCXJldHVybiBNTFg1X1ZEUEFfQ1ZRX0dST1VQOworCisJcmV0dXJu
IE1MWDVfVkRQQV9EQVRBVlFfREVTQ19HUk9VUDsKK30KKwogc3RhdGljIHU2NCBtbHhfdG9fdnJp
dGlvX2ZlYXR1cmVzKHUxNiBkZXZfZmVhdHVyZXMpCiB7CiAJdTY0IHJlc3VsdCA9IDA7CkBAIC0z
MTYwLDYgKzMxNzYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyBtbHg1
X3ZkcGFfb3BzID0gewogCS5nZXRfdnFfaXJxID0gbWx4NV9nZXRfdnFfaXJxLAogCS5nZXRfdnFf
YWxpZ24gPSBtbHg1X3ZkcGFfZ2V0X3ZxX2FsaWduLAogCS5nZXRfdnFfZ3JvdXAgPSBtbHg1X3Zk
cGFfZ2V0X3ZxX2dyb3VwLAorCS5nZXRfdnFfZGVzY19ncm91cCA9IG1seDVfdmRwYV9nZXRfdnFf
ZGVzY19ncm91cCwgLyogT3AgZGlzYWJsZWQgaWYgbm90IHN1cHBvcnRlZC4gKi8KIAkuZ2V0X2Rl
dmljZV9mZWF0dXJlcyA9IG1seDVfdmRwYV9nZXRfZGV2aWNlX2ZlYXR1cmVzLAogCS5zZXRfZHJp
dmVyX2ZlYXR1cmVzID0gbWx4NV92ZHBhX3NldF9kcml2ZXJfZmVhdHVyZXMsCiAJLmdldF9kcml2
ZXJfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfZ2V0X2RyaXZlcl9mZWF0dXJlcywKQEAgLTMyNTgsNiAr
MzI3NSw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfbWdtdGRldiB7CiAJc3RydWN0IHZkcGFfbWdtdF9k
ZXYgbWd0ZGV2OwogCXN0cnVjdCBtbHg1X2FkZXYgKm1hZGV2OwogCXN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2OworCXN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgdmRwYV9vcHM7CiB9OwogCiBzdGF0
aWMgaW50IGNvbmZpZ19mdW5jX210dShzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqbWRldiwgdTE2IG10
dSkKQEAgLTMzNzEsNyArMzM4OSw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3Ry
dWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKIAkJbWF4X3ZxcyA9
IDI7CiAJfQogCi0JbmRldiA9IHZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0
LCBtdmRldi52ZGV2LCBtZGV2LT5kZXZpY2UsICZtbHg1X3ZkcGFfb3BzLAorCW5kZXYgPSB2ZHBh
X2FsbG9jX2RldmljZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCwgbXZkZXYudmRldiwgbWRldi0+ZGV2
aWNlLCAmbWd0ZGV2LT52ZHBhX29wcywKIAkJCQkgTUxYNV9WRFBBX05VTVZRX0dST1VQUywgTUxY
NV9WRFBBX05VTV9BUywgbmFtZSwgZmFsc2UpOwogCWlmIChJU19FUlIobmRldikpCiAJCXJldHVy
biBQVFJfRVJSKG5kZXYpOwpAQCAtMzU0Niw2ICszNTY0LDEwIEBAIHN0YXRpYyBpbnQgbWx4NXZf
cHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXYsCiAJCU1MWDVfQ0FQX0RFVl9WRFBB
X0VNVUxBVElPTihtZGV2LCBtYXhfbnVtX3ZpcnRpb19xdWV1ZXMpICsgMTsKIAltZ3RkZXYtPm1n
dGRldi5zdXBwb3J0ZWRfZmVhdHVyZXMgPSBnZXRfc3VwcG9ydGVkX2ZlYXR1cmVzKG1kZXYpOwog
CW1ndGRldi0+bWFkZXYgPSBtYWRldjsKKwltZ3RkZXYtPnZkcGFfb3BzID0gbWx4NV92ZHBhX29w
czsKKworCWlmICghTUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OKG1kZXYsIGRlc2NfZ3JvdXBf
bWtleV9zdXBwb3J0ZWQpKQorCQltZ3RkZXYtPnZkcGFfb3BzLmdldF92cV9kZXNjX2dyb3VwID0g
TlVMTDsKIAogCWVyciA9IHZkcGFfbWdtdGRldl9yZWdpc3RlcigmbWd0ZGV2LT5tZ3RkZXYpOwog
CWlmIChlcnIpCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmNfdmRwYS5o
IGIvaW5jbHVkZS9saW51eC9tbHg1L21seDVfaWZjX3ZkcGEuaAppbmRleCA5YmVjZGMzZmE1MDMu
LmI4NmQ1MWE4NTVmNiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tbHg1L21seDVfaWZjX3Zk
cGEuaAorKysgYi9pbmNsdWRlL2xpbnV4L21seDUvbWx4NV9pZmNfdmRwYS5oCkBAIC03NCw3ICs3
NCwxMSBAQCBzdHJ1Y3QgbWx4NV9pZmNfdmlydGlvX3FfYml0cyB7CiAJdTggICAgcmVzZXJ2ZWRf
YXRfMzIwWzB4OF07CiAJdTggICAgcGRbMHgxOF07CiAKLQl1OCAgICByZXNlcnZlZF9hdF8zNDBb
MHhjMF07CisJdTggICAgcmVzZXJ2ZWRfYXRfMzQwWzB4MjBdOworCisJdTggICAgZGVzY19ncm91
cF9ta2V5WzB4MjBdOworCisJdTggICAgcmVzZXJ2ZWRfYXRfMzgwWzB4ODBdOwogfTsKIAogc3Ry
dWN0IG1seDVfaWZjX3ZpcnRpb19uZXRfcV9vYmplY3RfYml0cyB7CkBAIC0xNDEsNiArMTQ1LDcg
QEAgZW51bSB7CiAJTUxYNV9WSVJUUV9NT0RJRllfTUFTS19TVEFURSAgICAgICAgICAgICAgICAg
ICAgPSAodTY0KTEgPDwgMCwKIAlNTFg1X1ZJUlRRX01PRElGWV9NQVNLX0RJUlRZX0JJVE1BUF9Q
QVJBTVMgICAgICA9ICh1NjQpMSA8PCAzLAogCU1MWDVfVklSVFFfTU9ESUZZX01BU0tfRElSVFlf
QklUTUFQX0RVTVBfRU5BQkxFID0gKHU2NCkxIDw8IDQsCisJTUxYNV9WSVJUUV9NT0RJRllfTUFT
S19ERVNDX0dST1VQX01LRVkgICAgICAgICAgPSAodTY0KTEgPDwgMTQsCiB9OwogCiBlbnVtIHsK
LS0gCjIuNDEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
