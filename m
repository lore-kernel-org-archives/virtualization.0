Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DAFC001DF
	for <virtualization@archiver.kernel.org>; Wed,  2 Aug 2023 17:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 322AD405C8;
	Wed,  2 Aug 2023 17:13:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 322AD405C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dcLxT6ie
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id neU43sMGBaNJ; Wed,  2 Aug 2023 17:13:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4592F4022A;
	Wed,  2 Aug 2023 17:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4592F4022A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2085CC0071;
	Wed,  2 Aug 2023 17:13:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC8BBC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4D8040334
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:13:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4D8040334
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qHK1cpWqSmOo
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:13:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::627])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6A474022A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:13:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6A474022A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dttdudDqvQi2+hQJ3NaHb3YGylDNMZojjRe2U0NPXfIvG2qkANSrM4cbMC4RD2ZrimPa4b9CJtJhfJbn5v9s4GwMlaWJFGPE9E8D6uoD9tovU4N6qiaHMKO4xF/4aZMBGV82A8wYM3aV2wEOmddmDL7ymRSUPWsRmJnbq6WhLVATEKEg1eeqhQHynKNmD75PN5Ck6LWSFHoyYqA8HNvxbhDW+SMIIUuMzeREsuhK7M+TLowFjKHX3M/LgeSSzjUMONdpNWhboacnbKeUfwCNAZggdtdF2uOMWo6D0AGxRPOcju6InimzZKX5zHtagjteWteKIVB+yFl8rlQ3uIuGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UyKQTMFX1mut5/H2U/CfaadEbA4WrB66IyJaD16oIQ=;
 b=i+vd9N1fZ1EQsezdHymW+cek/BKhzeOZRTQurxApvnAbqJfT4msC1q7TiEjai2PEvw9XRV1eLiyomRaGcW1kaIIF1BrbpW1dUtvdXRzZ8+ZqwkrpYyJkL18UOmXff72cxsm7Q6YJLU7jy17H2eJ0AMGpyVqRDc0hZTlbmN7GR0iwsDDpNLyLV34srULRodmwb6KdFfc5AFW48VL2BhSpudmXViWm+U9sXh8Hf7N1H7LEiMZJRHirIUvIsCf1gki8TzpeqP8rLQvrdI5vaXSY1nJbHGHxiO++CsITodUR0eT/kC2rUmDoTNqSPo5EqxelDAFg+j4Y02+A59/s1virTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UyKQTMFX1mut5/H2U/CfaadEbA4WrB66IyJaD16oIQ=;
 b=dcLxT6iex1FoDKFrue6uu8T040Pt884AeBGzzd2BUFR3RaCpcGmQ5sH4+usmjW0G8Y3mUOvgSB5wRMO/iY4x26aqQcddXsSYRXnj/99tt7Gm/Heim41wTa9FuLTK6ojd3i/KqSxze+qloQHUAEJxT2H/E6ZiOOsGCFI+7jJkXmdRViOR/coovt97eWSF2u/1FU0/TAoJkywccnLvjZyHMuYvVIwjfnlTkWKEd6E28UVMIPwSfQAWz42WdVNzC0QRrp6me2e9vZsKrSKSJcl+FgNwX3QrSP3oCK270bQknNq5+SPhMM4gvZqqFvXiZ00kBlsCTruHo6nqk7k7IKd2qg==
Received: from MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::10)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 17:13:18 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::b8) by MW4P220CA0005.outlook.office365.com
 (2603:10b6:303:115::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 17:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 17:13:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 10:13:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 10:13:04 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 2 Aug 2023 10:13:03 -0700
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 2/2] vdpa/mlx5: Delete control vq iotlb in destroy_mr only
 when necessary
Date: Wed, 2 Aug 2023 20:12:20 +0300
Message-ID: <20230802171231.11001-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802171231.11001-1-dtatulea@nvidia.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BL1PR12MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: 0868c003-c92f-467d-cb1b-08db937bc43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdONbFcQg/XDn/bSE8yzrOwELtztIb22l3ZbDOlzuDXq53xarGoMujSj/nHqWWXg/iFrAUAKZuMGNWqfC7OTBl2sw3VUwDjmFpBJf9Ao4+ajmw8J2GRoi+KA4OiSvsGskJ3VxSFuF2BYNj5YEcSmwl+DUNNdAXj5g8p8P0EGIBEJ4Gh3GSOeObrnzxNnrNkxKnndqgqpsnIaYZwzdWwOfnHEGwTDeqKs6/TrVv5Q/UISlITGwhtR6+HZAkZvXEcjqTduZXiebyZPxX+UcHY+yxPdQ6Y1XP2mydC8qfYGOiLXLPXOjnDe9rfKjqMu6+4yGYkyMrl6UxZcVJ73t0UkIOllXTk7EzByLEqWgW4ks7+zFOjtWvKDYlRK0IJzh4gyaZ7byTC5bcgOtA52oXk9BM0WUW2kSmFYZCybMxNFjdMtAlc88Qo0djSLAUTyMTSStXhKrEfJgZO7MDPoqZwOsZ/PXktTtwvYexGq0eP+IFrHKzOr8IKMtQqq3luZcHuKx3ykJ7MQ6GcCcGy1yUIb/NffXlQ8C2lFaNOKhQkAm/4bnCGcQtdJKlT1FdrL4mFCFXVoR+KiCfbbdvH91HXVIt2Fas6gLCdXYeI7dHxU2HzhrRmTsogaYU0xD6VafHyzoiGUHrE9663M9C/70yXAHiX7qLAXKpE1+o+ERXa09aNUXS2pI22HrGDOi9jE4QFbIJ/F0dPzMX68CYra/GFD+xb/gKip5YUMs7KeixYJl4Siz9sPCgMUObX8xFILmEFh
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(4326008)(40460700003)(426003)(66574015)(70206006)(70586007)(186003)(2616005)(356005)(7636003)(82740400003)(336012)(2906002)(26005)(1076003)(83380400001)(36860700001)(47076005)(54906003)(110136005)(40480700001)(86362001)(478600001)(36756003)(6666004)(41300700001)(8676002)(8936002)(5660300002)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:13:18.4204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0868c003-c92f-467d-cb1b-08db937bc43e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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

RnJvbTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+CgptbHg1X3ZkcGFfZGVz
dHJveV9tciBjYW4gYmUgY2FsbGVkIGZyb20gLnNldF9tYXAgd2l0aCBkYXRhIEFTSUQgYWZ0ZXIK
dGhlIGNvbnRyb2wgdmlydHF1ZXVlIEFTSUQgaW90bGIgaGFzIGJlZW4gcG9wdWxhdGVkLiBUaGUg
Y29udHJvbCB2cQppb3RsYiBtdXN0IG5vdCBiZSBjbGVhcmVkLCBzaW5jZSBpdCB3aWxsIG5vdCBi
ZSBwb3B1bGF0ZWQgYWdhaW4uCgpTbyBjYWxsIHRoZSBBU0lEIGF3YXJlIGRlc3Ryb3kgZnVuY3Rp
b24gd2hpY2ggbWFrZXMgc3VyZSB0aGF0IHRoZQpyaWdodCB2cSByZXNvdXJjZSBpcyBkZXN0cm95
ZWQuCgpGaXhlczogOGZjZDIwYzMwNzA0ICgidmRwYS9tbHg1OiBTdXBwb3J0IGRpZmZlcmVudCBh
ZGRyZXNzIHNwYWNlcyBmb3IgY29udHJvbCBhbmQgZGF0YSIpClNpZ25lZC1vZmYtYnk6IEV1Z2Vu
aW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogR2FsIFByZXNzbWFu
IDxnYWxAbnZpZGlhLmNvbT4KLS0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5o
IHwgMSArCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgICAgICAgIHwgMiArLQogZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICB8IDQgKystLQogMyBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L21seDUvY29yZS9tbHg1X3ZkcGEuaCBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBh
LmgKaW5kZXggYTA0MjBiZTUwNTlmLi5iNTM0MjBlODc0YWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9t
bHg1X3ZkcGEuaApAQCAtMTIyLDYgKzEyMiw3IEBAIGludCBtbHg1X3ZkcGFfaGFuZGxlX3NldF9t
YXAoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvCiBp
bnQgbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVj
dCB2aG9zdF9pb3RsYiAqaW90bGIsCiAJCQl1bnNpZ25lZCBpbnQgYXNpZCk7CiB2b2lkIG1seDVf
dmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldik7Cit2b2lkIG1seDVf
dmRwYV9kZXN0cm95X21yX2FzaWQoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25l
ZCBpbnQgYXNpZCk7CiAKICNkZWZpbmUgbWx4NV92ZHBhX3dhcm4oX19kZXYsIGZvcm1hdCwgLi4u
KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKIAlkZXZfd2FybigoX19kZXYpLT5tZGV2LT5kZXZpY2UsICIlczolZDoocGlkICVkKSB3YXJu
aW5nOiAiIGZvcm1hdCwgX19mdW5jX18sIF9fTElORV9fLCAgICAgXApkaWZmIC0tZ2l0IGEvZHJp
dmVycy92ZHBhL21seDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCmlu
ZGV4IDRhZTE0YTI0OGE0Yi4uNWExOTcxZmNkODdiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEv
bWx4NS9jb3JlL21yLmMKKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCkBAIC01MTUs
NyArNTE1LDcgQEAgc3RhdGljIHZvaWQgX21seDVfdmRwYV9kZXN0cm95X2R2cV9tcihzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludAogCW1yLT5pbml0aWFsaXplZCA9IGZh
bHNlOwogfQogCi1zdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lkKHN0cnVjdCBt
bHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50IGFzaWQpCit2b2lkIG1seDVfdmRwYV9k
ZXN0cm95X21yX2FzaWQoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQg
YXNpZCkKIHsKIAlzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7CiAKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwppbmRleCA5MTM4ZWYyZmIyYzguLjYxYzEwYmE1ZTNmNSAxMDA2
NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCisrKyBiL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwpAQCAtMjYzNiw3ICsyNjM2LDcgQEAgc3RhdGljIGlu
dCBtbHg1X3ZkcGFfY2hhbmdlX21hcChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCiAJCWdv
dG8gZXJyX21yOwogCiAJdGVhcmRvd25fZHJpdmVyKG5kZXYpOwotCW1seDVfdmRwYV9kZXN0cm95
X21yKG12ZGV2KTsKKwltbHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lkKG12ZGV2LCBhc2lkKTsKIAll
cnIgPSBtbHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCBpb3RsYiwgYXNpZCk7CiAJaWYgKGVycikK
IAkJZ290byBlcnJfbXI7CkBAIC0yNjUyLDcgKzI2NTIsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRw
YV9jaGFuZ2VfbWFwKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKIAlyZXR1cm4gMDsKIAog
ZXJyX3NldHVwOgotCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2KTsKKwltbHg1X3ZkcGFfZGVz
dHJveV9tcl9hc2lkKG12ZGV2LCBhc2lkKTsKIGVycl9tcjoKIAlyZXR1cm4gZXJyOwogfQotLSAK
Mi40MS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
