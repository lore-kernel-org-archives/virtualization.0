Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F001CE95A91
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DECE61194;
	Mon,  9 Oct 2023 11:25:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DECE61194
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SdljBuoG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HOzCX8hyRqzg; Mon,  9 Oct 2023 11:25:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B3E860C34;
	Mon,  9 Oct 2023 11:25:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B3E860C34
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78246C0039;
	Mon,  9 Oct 2023 11:25:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35952C0DD5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 00F3A60F41
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00F3A60F41
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r89pjSF-lMmJ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD6AE60C34
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD6AE60C34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBdumJDOlDNfUwpoY7KBpiLJWduF06nxrIIu71b9wo+D6rNzt13Hn6bkdlr6ZVG2KrLdWVaWuDiGYJ6hs6cNnCvKQepjY2vXMs1P5/w19iTcYN+SA3WpZaaULbAIrRAGqUezbiWOsO2ueTVJ+DKVgxtQ8uRwg6rKSkyzC0OJgTiFFoanP6YpNdiw/BuNJdks0ObQDUxG/CpzqC2hVLU/U1FXbEqUrTEy3wrPcqzqPH9vXg6moGqdyqgpTQS4sn2ppkXqTCoN7WuBzugfPYwja/FeV2lZXfLVBjrCYvluPJYpJiY8+SwlDB04dLeULjc796cxLCuiPfgKi2iGZ8VLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YoDCHkpinOQBJC5OCWVs0dAVcWKDrjzxMHgzD+IBkE=;
 b=bJUIVHvjxy0HE/Lv/K+Ae8LIEhCEfcxRtbzOBqiOf0r6opqvlRXG1U1Lkppcy8xWXt42zROsESsNISDBqVKcfhgPntLz4KQN3OZllgog6Z2mvGKOxlQ5dNo4TnHfwmNSCiZZWtjzcaVgWCGO1HZ76rvolNibwXwqP0SP/7L/kk/TK4ne6SDMfngezuCtzUYzoyltagWmGATF7KC0aJqPlp7+vksoUGloCYUqHf7GN9rVnoSbmmReoRvk0HJJ3r8PA9IYcstsFP/vDnx0MXOpnZGSmZ24SE2SUiMVgfPDkjjJNYVgMrY3lEhuOUlSKR3eWomZTxxFvJG+VdhqRmMEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YoDCHkpinOQBJC5OCWVs0dAVcWKDrjzxMHgzD+IBkE=;
 b=SdljBuoGdSS5da2eAYp0JmpjDPUIvjbo9nXosvgwPbnEDp3hYQ+hbRpF6vxO28cuim1u7w/mEaOeSbUIatt40oC22T8wSOyL0w+jngHDondBU0wFFmFZ7G4RMapgL9y9kP9tOxHli9tl0spUjYOjGBYxBgWDLzxSdDWW/QBJtVMZ3r9VoV+bz0mGIsgLqfwP6MxYeOBFHR0kGM+TWc7yJpi5jeSFhmimocgkPWZV6KK8PYSGRCyQ761mwBjAiQxrRk5dRjoYc1sYvzj6LgOJ6ecw1tl4A5ek/Q0H2tN/1jr+herWT43+xWwDuRtPpjJ5VN6BZc2ceL28hFQ8YZTwag==
Received: from PH8PR20CA0017.namprd20.prod.outlook.com (2603:10b6:510:23c::17)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 11:24:59 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::42) by PH8PR20CA0017.outlook.office365.com
 (2603:10b6:510:23c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 11:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 11:24:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:39 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:36 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 06/16] vdpa/mlx5: Decouple cvq iotlb handling from hw
 mapping code
Date: Mon, 9 Oct 2023 14:23:51 +0300
Message-ID: <20231009112401.1060447-7-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8d5458-f813-400b-f140-08dbc8ba5f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ck4vLrhzJNjydA9vZJZxurot9e+CnEh79o6FYA4OpalJPVsF2/up/d9Zv3bpzfQTXVJeAzzR2jYmoguyiX91nhsBA3V3OwssH52T+4xCwQHaKCdlVT24yA6LwhezqJp8M3sQgXzw9V9Z4L9ENF2ySPS6si/ec3TpNcl3eIbgy04ZtXr6wHoL3JpvOjcBsHFKw/F7SQionHw2+RCUlcYadOPE1p50sBrkq9NjcdRm1AGZXot1L3vdlzg0VFZAgxzWgSK4OtVUVwBlDHjKFXyQGwYuYaowimV76/QxNbMiboa2XL7ieW5F901CS20AqRiDkcl6SgX1J+R3Sxvj5uCIyCahIsapIMP2ZUCL/9ZcrQbmzGbLok7zHMyFynv8w3aNhQkS4AOwru2ILffxj3jFXlURemqAIkewtllUTM04eEd2HqYQ9vvbu/N85ARmVQvOkktUuvBsrAjqWijmHWtBhIp3+aawJAP8jfSE4CVryUAK1ZIWxYubCgQ/tDY3NYQChM8N9a5owiFtXIiUfQUMRXP/Uknky19MGLX1MJRnb+fLtezoa0k8I+d0SsYoyrNDfBPFFhRVKiYABkH1OxCaaWW7OpxZgTgJ6OT/u93rcAFYYqt7cObOFgNT/U+GgoUvfwNdGkMQcw6vcz6UXuThAb7bQeOghHbNwhZwx+oBttPLdTEbvHkPF6WdwoL2mca38sOSUCZpnRCHHfexQkO50gKPj4EwI5MmjAx7cpCf+AU=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(7636003)(356005)(86362001)(36756003)(40480700001)(2906002)(82740400003)(478600001)(41300700001)(8936002)(5660300002)(4326008)(8676002)(6666004)(83380400001)(1076003)(426003)(336012)(2616005)(40460700003)(316002)(36860700001)(70586007)(70206006)(54906003)(110136005)(26005)(47076005)(66574015);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:24:59.0132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8d5458-f813-400b-f140-08dbc8ba5f4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
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

VGhlIGhhbmRsaW5nIG9mIHRoZSBjdnEgaW90bGIgaXMgY3VycmVudGx5IGNvdXBsZWQgd2l0aCB0
aGUgY3JlYXRpb24KYW5kIGRlc3RydWN0aW9uIG9mIHRoZSBoYXJkd2FyZSBta2V5cyAobXIpLgoK
VGhpcyBwYXRjaCBtb3ZlcyBjdnEgaW90bGIgaGFuZGxpbmcgaW50byBpdHMgb3duIGZ1bmN0aW9u
IGFuZCBzaGlmdHMgaXQKdG8gYSBzY29wZSB0aGF0IGlzIG5vdCByZWxhdGVkIHRvIG1yIGhhbmRs
aW5nLiBBcyBjdnEgaGFuZGxpbmcgaXMganVzdCBhCnBydW5lX2lvdGxiICsgZHVwX2lvdGxiIGN5
Y2xlLCBwdXQgaXQgYWxsIGluIHRoZSBzYW1lICJ1cGRhdGUiIGZ1bmN0aW9uLgpGaW5hbGx5LCB0
aGUgZGVzdHJ1Y3Rpb24gcGF0aCBpcyBoYW5kbGVkIGJ5IGRpcmVjdGx5IHBydW5pbmcgdGhlIGlv
dGxiLgoKQWZ0ZXIgdGhpcyBtb3ZlIGlzIGRvbmUgdGhlIEFTSUQgbXIgY29kZSBjYW4gYmUgY29s
bGFwc2VkIGludG8gYSBzaW5nbGUKZnVuY3Rpb24uCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KQWNrZWQtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRo
YXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNv
bT4KLS0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIHwgIDMgKysKIGRyaXZl
cnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAgICAgICAgfCA1NyArKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0KIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCAgNyArKy0tCiAz
IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEv
bWx4NS9jb3JlL21seDVfdmRwYS5oCmluZGV4IDM3NDhmMDI3Y2ZlOS4uNTU0ODk5YTgwMjQxIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCisrKyBiL2RyaXZl
cnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKQEAgLTEyMCw2ICsxMjAsOSBAQCBpbnQgbWx4
NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9z
dF9pb3RsYiAqaW90bGIsCiAJCQl1bnNpZ25lZCBpbnQgYXNpZCk7CiB2b2lkIG1seDVfdmRwYV9k
ZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldik7CiB2b2lkIG1seDVfdmRwYV9k
ZXN0cm95X21yX2FzaWQoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQg
YXNpZCk7CitpbnQgbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2LAorCQkJCXN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCisJCQkJdW5zaWduZWQg
aW50IGFzaWQpOwogaW50IG1seDVfdmRwYV9jcmVhdGVfZG1hX21yKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldik7CiAKICNkZWZpbmUgbWx4NV92ZHBhX3dhcm4oX19kZXYsIGZvcm1hdCwgLi4u
KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbXIuYwppbmRleCA3YmQwODgzYjhiMjUuLmZjYjZhZTMyZTllZCAxMDA2NDQK
LS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbXIuYwpAQCAtNDg5LDE0ICs0ODksNiBAQCBzdGF0aWMgdm9pZCBkZXN0cm95X3VzZXJf
bXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX21yICptcgog
CX0KIH0KIAotc3RhdGljIHZvaWQgX21seDVfdmRwYV9kZXN0cm95X2N2cV9tcihzdHJ1Y3QgbWx4
NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQotewotCWlmIChtdmRldi0+Z3Jv
dXAyYXNpZFtNTFg1X1ZEUEFfQ1ZRX0dST1VQXSAhPSBhc2lkKQotCQlyZXR1cm47Ci0KLQlwcnVu
ZV9pb3RsYihtdmRldik7Ci19Ci0KIHN0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFf
bXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKIHsKIAlz
dHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7CkBAIC01MjIsMjUgKzUxNCwxNCBA
QCB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yX2FzaWQoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12
ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKIAltdXRleF9sb2NrKCZtci0+bWtleV9tdHgpOwogCiAJ
X21seDVfdmRwYV9kZXN0cm95X2R2cV9tcihtdmRldiwgYXNpZCk7Ci0JX21seDVfdmRwYV9kZXN0
cm95X2N2cV9tcihtdmRldiwgYXNpZCk7CiAKIAltdXRleF91bmxvY2soJm1yLT5ta2V5X210eCk7
CiB9CiAKIHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12
ZGV2KQogewotCW1seDVfdmRwYV9kZXN0cm95X21yX2FzaWQobXZkZXYsIG12ZGV2LT5ncm91cDJh
c2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdKTsKIAltbHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lkKG12
ZGV2LCBtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dST1VQXSk7Ci19Ci0KLXN0
YXRpYyBpbnQgX21seDVfdmRwYV9jcmVhdGVfY3ZxX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICpt
dmRldiwKLQkJCQkgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKLQkJCQkgICAgdW5zaWdu
ZWQgaW50IGFzaWQpCi17Ci0JaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JP
VVBdICE9IGFzaWQpCi0JCXJldHVybiAwOwotCi0JcmV0dXJuIGR1cF9pb3RsYihtdmRldiwgaW90
bGIpOworCXBydW5lX2lvdGxiKG12ZGV2KTsKIH0KIAogc3RhdGljIGludCBfbWx4NV92ZHBhX2Ny
ZWF0ZV9kdnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LApAQCAtNTcyLDIyICs1NTMs
NyBAQCBzdGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYsCiBzdGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldiwKIAkJCQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLCB1bnNpZ25l
ZCBpbnQgYXNpZCkKIHsKLQlpbnQgZXJyOwotCi0JZXJyID0gX21seDVfdmRwYV9jcmVhdGVfZHZx
X21yKG12ZGV2LCBpb3RsYiwgYXNpZCk7Ci0JaWYgKGVycikKLQkJcmV0dXJuIGVycjsKLQotCWVy
ciA9IF9tbHg1X3ZkcGFfY3JlYXRlX2N2cV9tcihtdmRldiwgaW90bGIsIGFzaWQpOwotCWlmIChl
cnIpCi0JCWdvdG8gb3V0X2VycjsKLQotCXJldHVybiAwOwotCi1vdXRfZXJyOgotCV9tbHg1X3Zk
cGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOwotCi0JcmV0dXJuIGVycjsKKwlyZXR1cm4g
X21seDVfdmRwYV9jcmVhdGVfZHZxX21yKG12ZGV2LCBpb3RsYiwgYXNpZCk7CiB9CiAKIGludCBt
bHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZo
b3N0X2lvdGxiICppb3RsYiwKQEAgLTYyMCw3ICs1ODYsMjQgQEAgaW50IG1seDVfdmRwYV9oYW5k
bGVfc2V0X21hcChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3Rs
YiAqaW8KIAlyZXR1cm4gZXJyOwogfQogCitpbnQgbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIo
c3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAorCQkJCXN0cnVjdCB2aG9zdF9pb3RsYiAqaW90
bGIsCisJCQkJdW5zaWduZWQgaW50IGFzaWQpCit7CisJaWYgKG12ZGV2LT5ncm91cDJhc2lkW01M
WDVfVkRQQV9DVlFfR1JPVVBdICE9IGFzaWQpCisJCXJldHVybiAwOworCisJcHJ1bmVfaW90bGIo
bXZkZXYpOworCXJldHVybiBkdXBfaW90bGIobXZkZXYsIGlvdGxiKTsKK30KKwogaW50IG1seDVf
dmRwYV9jcmVhdGVfZG1hX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKIHsKLQlyZXR1
cm4gbWx4NV92ZHBhX2NyZWF0ZV9tcihtdmRldiwgTlVMTCwgMCk7CisJaW50IGVycjsKKworCWVy
ciA9IG1seDVfdmRwYV9jcmVhdGVfbXIobXZkZXYsIE5VTEwsIDApOworCWlmIChlcnIpCisJCXJl
dHVybiBlcnI7CisKKwlyZXR1cm4gbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIobXZkZXYsIE5V
TEwsIDApOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCmluZGV4IDY1YjZhNTRhZDM0NC4u
YWE0ODk2NjYyNjk5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMKKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCkBAIC0yODg0LDEwICsy
ODg0LDEzIEBAIHN0YXRpYyBpbnQgc2V0X21hcF9kYXRhKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICpt
dmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKIAkJcmV0dXJuIGVycjsKIAl9CiAKLQlp
ZiAoY2hhbmdlX21hcCkKKwlpZiAoY2hhbmdlX21hcCkgewogCQllcnIgPSBtbHg1X3ZkcGFfY2hh
bmdlX21hcChtdmRldiwgaW90bGIsIGFzaWQpOworCQlpZiAoZXJyKQorCQkJcmV0dXJuIGVycjsK
Kwl9CiAKLQlyZXR1cm4gZXJyOworCXJldHVybiBtbHg1X3ZkcGFfdXBkYXRlX2N2cV9pb3RsYiht
dmRldiwgaW90bGIsIGFzaWQpOwogfQogCiBzdGF0aWMgaW50IG1seDVfdmRwYV9zZXRfbWFwKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGFzaWQsCi0tIAoyLjQxLjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
