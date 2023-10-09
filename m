Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C687E95A97
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAA1E41508;
	Mon,  9 Oct 2023 11:25:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CAA1E41508
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y9/EU3kS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6an9eULV8pEp; Mon,  9 Oct 2023 11:25:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 25DDB40190;
	Mon,  9 Oct 2023 11:25:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 25DDB40190
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D28AC0039;
	Mon,  9 Oct 2023 11:25:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01994C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3DB661193
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3DB661193
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Y9/EU3kS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KuoHMCbmRcrn
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 152A36117F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 152A36117F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naH19dQcnCle6ulZ4d2QyNUs+cNBX9gqqt+bAkV8WQaqHol8mJKRryGEkIKJe3TK9MpZJ64p5UvE7lKbpVev04ZevOMWv4V2tLDPeaSJD8udXbKuPGJ6sSxaasAToDAEllXZV+Xza9qeugL8/owp/kv0cq81qtS/5ZnPu4UPYbdlrTqurpLSj0u5CrmIKjN7dd1yPRxBcbUkTjW3vzV57FNvUjaZo0OjczGHU0XwE81pGRqUpElsx9m5hLsfTLu+bQn2z2Ps/13qh+f7ZQhMuXSQHokxS7JDzHutmEfbRiZtytZz5dicuSx5TMl/rMj9UrchkS77Y9IK+ILkaf7KcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+AGp+BRV0QlNoxWRv0zqkqDVrcRiRrwcHIbWi2U8fQ=;
 b=F3PH850YGaMja6A/jcLaYTxHzYmmMRXCC6ptnmhGzFYazt2S2th8JiwwM8gHQFl5Oj1lZNMah1cwldQEG6m+aog7h/x8kz0o5LHGDbjoDkfexvrhQ3OR/LsJNXGpJUqQwjKIdtzzu8qvavMCCVg/hNtHEO4xuzZam28m7GJG9QYYpkPfmqL6UhAI6P9tBKRPad2lVP7KVxzwCVs0hWaQPO1ZNTFb3Mxq6+W0bVs1ON43O8s9v5KEvUrYrQVMV7r3eo4xedCwA8wPpxYyG9joDWUvu8HeTfRgRRGYEuEEEM2GEwz/ywd4qjOJyeO8LSJKTnXIb47v7hkavIkOA5ZSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+AGp+BRV0QlNoxWRv0zqkqDVrcRiRrwcHIbWi2U8fQ=;
 b=Y9/EU3kSvr6sy2hdJk/w1tSAZzeuUBCDb7997Ak2c+myC/cd9EKQ20kB6LHjYQHrIF/oHo7WJ6R/rokjqcdbQeN6Rn0wGlgQIHnacZlXSzD1mCewqwB7aZsJtZFv4mlNXayKEk9/zkjtOZgclnGOlCajcATQI8LgX8947h/guwv9kx24R3a3gbsBAtk5uHhpbWzYB8yIYWEyQT4m1X/iTEaLu9lG+BVGI1k38/BRX1VMYOPwUtdapBRnrgMxgc9Ze6XL7skqneuqWdgR6ii2wtsc5PbF9bZGevNvvbZ5+M7JyuGdAa5YGxfhl0omjf36r9G2+s3TvD2o8T0/obJTrw==
Received: from MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 9 Oct
 2023 11:25:22 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::de) by MN2PR08CA0023.outlook.office365.com
 (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 11:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 11:25:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:25:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:25:05 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:25:02 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 13/16] vdpa/mlx5: Introduce mr for vq descriptor
Date: Mon, 9 Oct 2023 14:23:58 +0300
Message-ID: <20231009112401.1060447-14-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e40eb4e-7e37-40a0-9f6b-08dbc8ba6d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XC0a6D6orSTMY5p3vwAK/IhqDoAlmPn58AIaGTuHwEp1PynjFWAtvgpFyTxffI3cJzj9X3uJG60uCj67HTczzuCOSoaUxsdlxT/4Ir3WFLEsngYfh7+ZDGMXmu7RLXfXP/XuRf8gVr5znu3FGkd19+r4OlXE7pGmy1btS7AvKtsmw1fS3anOu0k5wVIofcUcccMq2Q1HC+idXLT6CucJuPOKJb4TrEN4/3otcEIJfchJeAiihCvpp2LF4jnKraols12LczlLHomi7T8cMfXjy2ZFUaFcSd00nA0wirDgppcMOXWxtzLjtDulybbkqY/85EsD2RQcLSjUISPEoArULg6asNsMLSCkDtwnLy+F1bw0yUp648bifWbGvxTFIx658Jpjy9KLHHWwXfeH7jEpe+LLyK53JdWrL35HKia843xT439rZpy/4RiDCzdpAPIq4RzLYPpHsrz0m6FliATJXK+ece6Cgx0Y1WdzxHR9Z3xl2l3biZJobpQyFEGXqLhBR45muolx/Q4DlIvO536OdooZSgwtrVJLKaRdn1sLkCmCaa4OYiMj2uQIzaaOp8fEdnvA+FE4xyDNrHwlt8j6UDj4EWCGS0jL2v8/LO5scwqFJ1OKxgbhEij/trcTi1UqdRRjuG5mqo9xA6Y94zSsfkZFTe6qm83Ys7t7ZrleuACoptZe4ni98F/AY8q7TiDZlQ8oixKPh+D2c0zoXc7ePaYXBoN2srpE818F0kwnVE=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(82740400003)(2616005)(7636003)(356005)(26005)(1076003)(336012)(426003)(66574015)(110136005)(54906003)(70206006)(70586007)(6666004)(478600001)(47076005)(36860700001)(83380400001)(86362001)(36756003)(8936002)(8676002)(2906002)(4326008)(5660300002)(316002)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:25:22.5284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e40eb4e-7e37-40a0-9f6b-08dbc8ba6d5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268
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

SW50cm9kdWNlIHRoZSB2cSBkZXNjcmlwdG9yIGdyb3VwIGFuZCBtciBwZXIgQVNJRC4gVW50aWwg
bm93Ci5zZXRfbWFwIG9uIEFTSUQgMSB3YXMgb25seSB1cGRhdGluZyB0aGUgY3ZxIGlvdGxiLiBG
cm9tIG5vdyBvbiBpdCBhbHNvCmNyZWF0ZXMgYSBta2V5IGZvciBpdC4gVGhlIGN1cnJlbnQgcGF0
Y2ggZG9lc24ndCB1c2UgaXQgYnV0IGZvbGxvdy11cApwYXRjaGVzIHdpbGwgYWRkIGhhcmR3YXJl
IHN1cHBvcnQgZm9yIG1hcHBpbmcgdGhlIHZxIGRlc2NyaXB0b3JzLgoKQWNrZWQtYnk6IEV1Z2Vu
aW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBEcmFnb3MgVGF0
dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KLS0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21s
eDVfdmRwYS5oIHwgIDUgKysrLS0KIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAgICAgICAg
fCAxNCArKysrKysrKystLS0tLQogZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jICB8
IDIwICsrKysrKysrKysrKystLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMo
KyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUv
bWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCmluZGV4IGJi
ZTQzMzUxMDZiZC4uYWUwOTI5NmY0MjcwIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL21seDVfdmRwYS5oCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgK
QEAgLTcwLDExICs3MCwxMiBAQCBzdHJ1Y3QgbWx4NV92ZHBhX3dxX2VudCB7CiBlbnVtIHsKIAlN
TFg1X1ZEUEFfREFUQVZRX0dST1VQLAogCU1MWDVfVkRQQV9DVlFfR1JPVVAsCisJTUxYNV9WRFBB
X0RBVEFWUV9ERVNDX0dST1VQLAogCU1MWDVfVkRQQV9OVU1WUV9HUk9VUFMKIH07CiAKIGVudW0g
ewotCU1MWDVfVkRQQV9OVU1fQVMgPSBNTFg1X1ZEUEFfTlVNVlFfR1JPVVBTCisJTUxYNV9WRFBB
X05VTV9BUyA9IDIKIH07CiAKIHN0cnVjdCBtbHg1X3ZkcGFfZGV2IHsKQEAgLTg5LDcgKzkwLDcg
QEAgc3RydWN0IG1seDVfdmRwYV9kZXYgewogCXUxNiBtYXhfaWR4OwogCXUzMiBnZW5lcmF0aW9u
OwogCi0Jc3RydWN0IG1seDVfdmRwYV9tciAqbXI7CisJc3RydWN0IG1seDVfdmRwYV9tciAqbXJb
TUxYNV9WRFBBX05VTV9BU107CiAJLyogc2VyaWFsaXplIG1yIGFjY2VzcyAqLwogCXN0cnVjdCBt
dXRleCBtcl9tdHg7CiAJc3RydWN0IG1seDVfY29udHJvbF92cSBjdnE7CmRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMK
aW5kZXggMDBlZmY1YTA3MTUyLi4zZGVlNmQ5YmVkNmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbXIuYworKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKQEAgLTUx
MSw4ICs1MTEsMTAgQEAgdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYsCiAKIAlfbWx4NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsIG1yKTsKIAotCWlm
IChtdmRldi0+bXIgPT0gbXIpCi0JCW12ZGV2LT5tciA9IE5VTEw7CisJZm9yIChpbnQgaSA9IDA7
IGkgPCBNTFg1X1ZEUEFfTlVNX0FTOyBpKyspIHsKKwkJaWYgKG12ZGV2LT5tcltpXSA9PSBtcikK
KwkJCW12ZGV2LT5tcltpXSA9IE5VTEw7CisJfQogCiAJbXV0ZXhfdW5sb2NrKCZtdmRldi0+bXJf
bXR4KTsKIApAQCAtNTIzLDExICs1MjUsMTEgQEAgdm9pZCBtbHg1X3ZkcGFfdXBkYXRlX21yKHN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKIAkJCSBzdHJ1Y3QgbWx4NV92ZHBhX21yICpuZXdf
bXIsCiAJCQkgdW5zaWduZWQgaW50IGFzaWQpCiB7Ci0Jc3RydWN0IG1seDVfdmRwYV9tciAqb2xk
X21yID0gbXZkZXYtPm1yOworCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm9sZF9tciA9IG12ZGV2LT5t
clthc2lkXTsKIAogCW11dGV4X2xvY2soJm12ZGV2LT5tcl9tdHgpOwogCi0JbXZkZXYtPm1yID0g
bmV3X21yOworCW12ZGV2LT5tclthc2lkXSA9IG5ld19tcjsKIAlpZiAob2xkX21yKSB7CiAJCV9t
bHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldiwgb2xkX21yKTsKIAkJa2ZyZWUob2xkX21yKTsKQEAg
LTUzOSw3ICs1NDEsOSBAQCB2b2lkIG1seDVfdmRwYV91cGRhdGVfbXIoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2LAogCiB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yX3Jlc291cmNlcyhzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCiB7Ci0JbWx4NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYs
IG12ZGV2LT5tcik7CisJZm9yIChpbnQgaSA9IDA7IGkgPCBNTFg1X1ZEUEFfTlVNX0FTOyBpKysp
CisJCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2LCBtdmRldi0+bXJbaV0pOworCiAJcHJ1bmVf
aW90bGIobXZkZXYpOwogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKaW5kZXggNGE4N2Y5
MTE5ZmNhLi4yNWJkMmMzMjRmNWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYworKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKQEAgLTgy
MSw2ICs4MjEsOCBAQCBzdGF0aWMgaW50IGNyZWF0ZV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRw
YV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZQogewogCWludCBpbmxlbiA9IE1M
WDVfU1RfU1pfQllURVMoY3JlYXRlX3ZpcnRpb19uZXRfcV9pbik7CiAJdTMyIG91dFtNTFg1X1NU
X1NaX0RXKGNyZWF0ZV92aXJ0aW9fbmV0X3Ffb3V0KV0gPSB7fTsKKwlzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYgPSAmbmRldi0+bXZkZXY7CisJc3RydWN0IG1seDVfdmRwYV9tciAqdnFfbXI7
CiAJdm9pZCAqb2JqX2NvbnRleHQ7CiAJdTE2IG1seF9mZWF0dXJlczsKIAl2b2lkICpjbWRfaGRy
OwpAQCAtODczLDcgKzg3NSw5IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3ZpcnRxdWV1ZShzdHJ1Y3Qg
bWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVlCiAJTUxYNV9TRVQ2
NCh2aXJ0aW9fcSwgdnFfY3R4LCBkZXNjX2FkZHIsIG12cS0+ZGVzY19hZGRyKTsKIAlNTFg1X1NF
VDY0KHZpcnRpb19xLCB2cV9jdHgsIHVzZWRfYWRkciwgbXZxLT5kZXZpY2VfYWRkcik7CiAJTUxY
NV9TRVQ2NCh2aXJ0aW9fcSwgdnFfY3R4LCBhdmFpbGFibGVfYWRkciwgbXZxLT5kcml2ZXJfYWRk
cik7Ci0JTUxYNV9TRVQodmlydGlvX3EsIHZxX2N0eCwgdmlydGlvX3FfbWtleSwgbmRldi0+bXZk
ZXYubXItPm1rZXkpOworCXZxX21yID0gbXZkZXYtPm1yW212ZGV2LT5ncm91cDJhc2lkW01MWDVf
VkRQQV9EQVRBVlFfR1JPVVBdXTsKKwlpZiAodnFfbXIpCisJCU1MWDVfU0VUKHZpcnRpb19xLCB2
cV9jdHgsIHZpcnRpb19xX21rZXksIHZxX21yLT5ta2V5KTsKIAlNTFg1X1NFVCh2aXJ0aW9fcSwg
dnFfY3R4LCB1bWVtXzFfaWQsIG12cS0+dW1lbTEuaWQpOwogCU1MWDVfU0VUKHZpcnRpb19xLCB2
cV9jdHgsIHVtZW1fMV9zaXplLCBtdnEtPnVtZW0xLnNpemUpOwogCU1MWDVfU0VUKHZpcnRpb19x
LCB2cV9jdHgsIHVtZW1fMl9pZCwgbXZxLT51bWVtMi5pZCk7CkBAIC0yNjMzLDcgKzI2MzcsOCBA
QCBzdGF0aWMgdm9pZCByZXN0b3JlX2NoYW5uZWxzX2luZm8oc3RydWN0IG1seDVfdmRwYV9uZXQg
Km5kZXYpCiB9CiAKIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2NoYW5nZV9tYXAoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LAotCQkJCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm5ld19tciwgdW5zaWdu
ZWQgaW50IGFzaWQpCisJCQkJc3RydWN0IG1seDVfdmRwYV9tciAqbmV3X21yLAorCQkJCXVuc2ln
bmVkIGludCBhc2lkKQogewogCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92
ZHBhX25kZXYobXZkZXYpOwogCWludCBlcnI7CkBAIC0yNjUyLDggKzI2NTcsMTAgQEAgc3RhdGlj
IGludCBtbHg1X3ZkcGFfY2hhbmdlX21hcChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCiAK
IAlyZXN0b3JlX2NoYW5uZWxzX2luZm8obmRldik7CiAJZXJyID0gc2V0dXBfZHJpdmVyKG12ZGV2
KTsKKwlpZiAoZXJyKQorCQlyZXR1cm4gZXJyOwogCi0JcmV0dXJuIGVycjsKKwlyZXR1cm4gMDsK
IH0KIAogLyogcmVzbG9jayBtdXN0IGJlIGhlbGQgZm9yIHRoaXMgZnVuY3Rpb24gKi8KQEAgLTI4
NjksOCArMjg3Niw4IEBAIHN0YXRpYyBpbnQgc2V0X21hcF9kYXRhKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKIAlzdHJ1Y3QgbWx4NV92ZHBh
X21yICpuZXdfbXI7CiAJaW50IGVycjsKIAotCWlmIChtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZE
UEFfREFUQVZRX0dST1VQXSAhPSBhc2lkKQotCQlnb3RvIGVuZDsKKwlpZiAoYXNpZCA+PSBNTFg1
X1ZEUEFfTlVNX0FTKQorCQlyZXR1cm4gLUVJTlZBTDsKIAogCW5ld19tciA9IG1seDVfdmRwYV9j
cmVhdGVfbXIobXZkZXYsIGlvdGxiKTsKIAlpZiAoSVNfRVJSKG5ld19tcikpIHsKQEAgLTI4Nzks
NyArMjg4Niw3IEBAIHN0YXRpYyBpbnQgc2V0X21hcF9kYXRhKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKIAkJcmV0dXJuIGVycjsKIAl9CiAK
LQlpZiAoIW12ZGV2LT5tcikgeworCWlmICghbXZkZXYtPm1yW2FzaWRdKSB7CiAJCW1seDVfdmRw
YV91cGRhdGVfbXIobXZkZXYsIG5ld19tciwgYXNpZCk7CiAJfSBlbHNlIHsKIAkJZXJyID0gbWx4
NV92ZHBhX2NoYW5nZV9tYXAobXZkZXYsIG5ld19tciwgYXNpZCk7CkBAIC0yODg5LDcgKzI4OTYs
NiBAQCBzdGF0aWMgaW50IHNldF9tYXBfZGF0YShzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYs
IHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCiAJCX0KIAl9CiAKLWVuZDoKIAlyZXR1cm4gbWx4
NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIobXZkZXYsIGlvdGxiLCBhc2lkKTsKIAogb3V0X2VycjoK
LS0gCjIuNDEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
