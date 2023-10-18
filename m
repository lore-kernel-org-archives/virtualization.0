Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F3ACDB483
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A30E3421C6;
	Wed, 18 Oct 2023 17:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A30E3421C6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V4B6YJGP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vj24Uvev4OuT; Wed, 18 Oct 2023 17:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E54EB42191;
	Wed, 18 Oct 2023 17:16:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E54EB42191
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADFA6C0039;
	Wed, 18 Oct 2023 17:16:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49AD4C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2586C82F6F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2586C82F6F
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=V4B6YJGP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yGRdooIujlK7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::624])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B4B482F57
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B4B482F57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go8LIE97kvUwdpbCQzE2tu2OWThNOG82qgbuK2LINxN6WxVypXIjOgg5pCTvS+0goRL+FdWfIqShVAjf7URtZq+CAiW5whbQFPBepOQ11Y0ISsiix/TtbzPbgE9D4oI5OcCmwsF9xIP0fmyug/d7bzldKymVWq9QtwEmn5+oKvR6NLmZW4DRsNTbfPRXaKDBa/ivlWv0TKLG7WWJj5iDHuFQ8sxXo5k1GIRjLvCskDMy+jphB6mSm49edYVkN+Q3c4uqatyqEB7FktGyWrqH3LCjuZmIQ5VadXCjNjqZm8UvCC3DRa9cIIwNnZe8DqHxd8l8SgiFedU12IcvLnjIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxAFjgl71dKtPW1VP7nvgdxX96LoRPCBaqis2IoV/TE=;
 b=T8ZLkHdQHxVxUt8sAY28oSlLqPotiti0woS8nj4k3Kcrh3W/amWDW2Ult6bFlLmZyRIr34f9FoJD9siBf4wwKOIU4ayET08KAm9Zgg4uvqNZuC3Ggc31UkRy7BW09nHtGxHnoVA9ZQ+XmmcAtu3mX1guivJDrS2SJVsIJtG76H+Alpn7ZJHYjSW6K9BwLZ43Aj7IpSweZQ9zKGmnSEo11rk5JroGTcu+vdTbux73uXgRknXoQmt+Bx1MNCOzqBPqV0DWLgj6ov7ZwwkILDzN/QPcj0lspMwJSkuHIzY0A9uT3CLNSoR+V/nMdpYYtoF+WKS/ZleWOMCg6PlfOglDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxAFjgl71dKtPW1VP7nvgdxX96LoRPCBaqis2IoV/TE=;
 b=V4B6YJGPSSpxc63GyVPcGP643CcmZbcsaigDp7PSlbPFi3ImjiYG8DHQ9Bprc8R2VlbKDAUbNBxDfR/RZ8Q1HfKP002sHKfPP5eMkkYNXIDgsYGOyNb1eNxbddRXzU2bo6uTYtfQ2y9otABLJ7dFMEHYJ3gccPSMneNmDuODzErMuSkK2dg6y+y1FaLXMP2/ssGeSM3v1lQybH6/f0FpDU1mUEhTeHM3dDuNjiihZj5alLV7eCQAKMOLNgBv1TBXwqrJjN3g4SPM0DXn5fwfG72XFO3cpuQ+uV5x0QwIcgPNPc4MiwifHuO3W0Jvdf8B0wx/frZsfVhm8gpvAxtO8A==
Received: from CH0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::19)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:16:30 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::f0) by CH0P220CA0001.outlook.office365.com
 (2603:10b6:610:ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:16:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:15 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:16:12 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 14/16] vdpa/mlx5: Enable hw support for vq descriptor
 mapping
Date: Wed, 18 Oct 2023 20:14:53 +0300
Message-ID: <20231018171456.1624030-16-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: e15a2f69-5892-41f1-b374-08dbcffdf897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZb4Ys7Mevhp9YBrGMgNOq/74H36lZyg0Cos9NozfBK3IEbXZa56x6fwd6bIkaDu1wK/MQy84qVUr7TTo+0U2dfAhgegeAgedHez0nhtmQYOcz92I+114CP5nTLA1Glh/AApAOwpW6wJCB6p2KkG6xtZLsFGYVjVWtdNZdr8phuRUqB/ZksybwvDqpLqD46Z+Od+aBaipPdXxJFRfFwpu5TsBZTrS56THtUr17CPaPQvPEDzesOaTU5zqdKw0cY3j8YjLRck5qLGySjcqyAZo29Z2HD+zN2eR2jxwf0DAgdB0rWFPhRKb7cSk9pP9KiO+yZq/QsoiaqVlvn/XUxopycAUsIi0JdAEsDOQHYDJSxifdj35/seggZkVA9RN56jHZYSAd5nXa16CPhgDKeplMvAScNcLiftgCzr3OjweXg8asWOESO51jdCtcQ1bP/hOFk+BxnaGfwyM+hlBihmnMhU9OXLlnWeb4Gqh7WT0qUW9UvmMFD98ArCyRzUrsoHAlydxvG8lMwHD+0pjYf2d98j4tidDxJK0zErSo4PDMZDnstOVM/k0508ikQ5qQMriBJaPzwRX+d4xf7VP3awuJlJ9grniD9orFdvQjo5G6OQxPZ60T9aF0DlGXqsfkt5zcGoEvhBHUdHZDFFMpYragjmCUR2d/vtfljtxC/vVqGA1wD2MZtzu2eZxNIR/5iGmolIOaFqFqNA8sWNeezme7xjo9i8T0dvISItNKRbgPpdA1OMfRTPs834Tqak9kW1
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(86362001)(36756003)(40460700003)(8936002)(40480700001)(2616005)(54906003)(70206006)(82740400003)(7636003)(26005)(316002)(356005)(110136005)(83380400001)(336012)(426003)(36860700001)(47076005)(66574015)(1076003)(6666004)(2906002)(41300700001)(70586007)(4326008)(478600001)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:30.5861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15a2f69-5892-41f1-b374-08dbcffdf897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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
IG9wLgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CkFja2VkLWJ5
OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogRHJh
Z29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Ci0tLQogZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrLQogaW5jbHVkZS9s
aW51eC9tbHg1L21seDVfaWZjX3ZkcGEuaCB8ICA3ICsrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwg
MjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMKaW5kZXggZWE3NmMwYjRiNzhlLi44N2RkMGJhNzY4OTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYworKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMKQEAgLTgyMyw2ICs4MjMsNyBAQCBzdGF0aWMgaW50IGNyZWF0ZV92aXJ0cXVldWUo
c3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZQogCXUz
MiBvdXRbTUxYNV9TVF9TWl9EVyhjcmVhdGVfdmlydGlvX25ldF9xX291dCldID0ge307CiAJc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gJm5kZXYtPm12ZGV2OwogCXN0cnVjdCBtbHg1X3Zk
cGFfbXIgKnZxX21yOworCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKnZxX2Rlc2NfbXI7CiAJdm9pZCAq
b2JqX2NvbnRleHQ7CiAJdTE2IG1seF9mZWF0dXJlczsKIAl2b2lkICpjbWRfaGRyOwpAQCAtODc4
LDYgKzg3OSwxMSBAQCBzdGF0aWMgaW50IGNyZWF0ZV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRw
YV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZQogCXZxX21yID0gbXZkZXYtPm1y
W212ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBdXTsKIAlpZiAodnFfbXIp
CiAJCU1MWDVfU0VUKHZpcnRpb19xLCB2cV9jdHgsIHZpcnRpb19xX21rZXksIHZxX21yLT5ta2V5
KTsKKworCXZxX2Rlc2NfbXIgPSBtdmRldi0+bXJbbXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBB
X0RBVEFWUV9ERVNDX0dST1VQXV07CisJaWYgKHZxX2Rlc2NfbXIgJiYgTUxYNV9DQVBfREVWX1ZE
UEFfRU1VTEFUSU9OKG12ZGV2LT5tZGV2LCBkZXNjX2dyb3VwX21rZXlfc3VwcG9ydGVkKSkKKwkJ
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
MTY1LDYgKzMxODEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyBtbHg1
X3ZkcGFfb3BzID0gewogCS5nZXRfdnFfaXJxID0gbWx4NV9nZXRfdnFfaXJxLAogCS5nZXRfdnFf
YWxpZ24gPSBtbHg1X3ZkcGFfZ2V0X3ZxX2FsaWduLAogCS5nZXRfdnFfZ3JvdXAgPSBtbHg1X3Zk
cGFfZ2V0X3ZxX2dyb3VwLAorCS5nZXRfdnFfZGVzY19ncm91cCA9IG1seDVfdmRwYV9nZXRfdnFf
ZGVzY19ncm91cCwgLyogT3AgZGlzYWJsZWQgaWYgbm90IHN1cHBvcnRlZC4gKi8KIAkuZ2V0X2Rl
dmljZV9mZWF0dXJlcyA9IG1seDVfdmRwYV9nZXRfZGV2aWNlX2ZlYXR1cmVzLAogCS5zZXRfZHJp
dmVyX2ZlYXR1cmVzID0gbWx4NV92ZHBhX3NldF9kcml2ZXJfZmVhdHVyZXMsCiAJLmdldF9kcml2
ZXJfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfZ2V0X2RyaXZlcl9mZWF0dXJlcywKQEAgLTMyNjMsNiAr
MzI4MCw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfbWdtdGRldiB7CiAJc3RydWN0IHZkcGFfbWdtdF9k
ZXYgbWd0ZGV2OwogCXN0cnVjdCBtbHg1X2FkZXYgKm1hZGV2OwogCXN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2OworCXN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgdmRwYV9vcHM7CiB9OwogCiBzdGF0
aWMgaW50IGNvbmZpZ19mdW5jX210dShzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqbWRldiwgdTE2IG10
dSkKQEAgLTMzNzYsNyArMzM5NCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3Ry
dWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKIAkJbWF4X3ZxcyA9
IDI7CiAJfQogCi0JbmRldiA9IHZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0
LCBtdmRldi52ZGV2LCBtZGV2LT5kZXZpY2UsICZtbHg1X3ZkcGFfb3BzLAorCW5kZXYgPSB2ZHBh
X2FsbG9jX2RldmljZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCwgbXZkZXYudmRldiwgbWRldi0+ZGV2
aWNlLCAmbWd0ZGV2LT52ZHBhX29wcywKIAkJCQkgTUxYNV9WRFBBX05VTVZRX0dST1VQUywgTUxY
NV9WRFBBX05VTV9BUywgbmFtZSwgZmFsc2UpOwogCWlmIChJU19FUlIobmRldikpCiAJCXJldHVy
biBQVFJfRVJSKG5kZXYpOwpAQCAtMzU1MSw2ICszNTY5LDEwIEBAIHN0YXRpYyBpbnQgbWx4NXZf
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
