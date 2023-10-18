Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D36CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC1316F563;
	Wed, 18 Oct 2023 17:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC1316F563
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YkPBkZFt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bw3iL9MMWVjs; Wed, 18 Oct 2023 17:16:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 354246F52D;
	Wed, 18 Oct 2023 17:16:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 354246F52D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09836C0039;
	Wed, 18 Oct 2023 17:16:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83B1CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4525482F8A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4525482F8A
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=YkPBkZFt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oHLb1hK5f1pE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7614882F6F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7614882F6F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TriHVTKDVLVqL88fTAvEOlBpYHyt3QM49N/I5eKsADbOxRFPXXICUwACO4CQghKO89F0T9bipMWDJEQqWhgxRMDhCOy3yGdl6VXxn0XOiaHkNUqfFYWDKqW/2yFYjPxIWgfTJcLN4xoFwwEwHy1CngBDr8yc9WddEKVbvz/IhjVSzzhV0YcJqSpfwbC8yxYW34t5OkGtBGfymT7vs9hNFKMQ8pUtD3GlRjHZNloBHAI9vYSginQ+51thp9l5KiCmanoaQNIHXcGSADfBYKue2t8iwzl/iO8hhPIWMmANzJZy0+mw8AGjAg09cUr15RF7Zw2wLAB/Z85NM8ziw9Rc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN0j2IV51vKRPVldubdAaR1gNfbMIxY1heIdwiqqZ4o=;
 b=jFVngTogCTSvDo16HcOeQ3yzakNZtS2qeX3drtKdrek1YnlKDAM0Dp2k3Jd8ZzZC2j0iEuWs9oLwrVa8OJ9RZ4HDrfxp6uWwCOBA/DEQi1QIMr28bq+QVNRTf2X3TRHi1Qd5oMSilMtWWmXEBA98wDHmsVd9V5JtAbhzRqUNi8vS9VV220Olyo89vsH2xZh6c9YI6ciOGWMUOES985B2gMwSQeXAATa9X7/OlmnFGEwrwIa+ifJfHv492wbLLv4ZhT0D6KGelEN4EK/R3+cSjtVaPbCkHIlEhoE2RVnLZ+Ctb0VgLFOeDTaFhncSq+ba+FE5obzF7bSEmFiBP+689Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN0j2IV51vKRPVldubdAaR1gNfbMIxY1heIdwiqqZ4o=;
 b=YkPBkZFthU2uBa1dKNAb0MUyGrxYyGVoY96v90Xiqz6wOG0jypmqjLbeKQlHPQDApuIDaZ2gnNgWc2g1pFkaDYJ7nqtgOuupjzZ9oLKnfWuiE9d5JKB29IG7v/PAZ16bY4SGBcj38SCGf1Lb9yfBcSsrtU9jo908x5wkVhM+3wFrFNs7zBUcfillycC28CokfEwRTxOvmgDdPLrresshcO4B2TUuc1Mj352Fwz1pXxknn6UhhMJBFJ7NxwV5JukQWFit/HqjSOqrVLcWne5Vnw7qKxQFLsjJXI5R283Edtbav2O3tTQAhPehAjLWqNduG5KIfvOFkiZ+DPVMqkbgaQ==
Received: from CH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::34)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 18 Oct
 2023 17:16:33 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com (2603:10b6:610:ef::4)
 by CH0P220CA0017.outlook.office365.com (2603:10b6:610:ef::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.37 via Frontend Transport; Wed, 18 Oct 2023 17:16:33 +0000
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
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:16:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:18 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:16:16 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 15/16] vdpa/mlx5: Make iotlb helper functions more
 generic
Date: Wed, 18 Oct 2023 20:14:54 +0300
Message-ID: <20231018171456.1624030-17-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 383acad4-aaed-419b-0348-08dbcffdfa4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49+J5IwC7lVsKS+Wt2OrDxPUJrjPYTLrWiBxygjFa1qJvpTu3XzpnaK/+lWcB87TlmkPmu2iKUuxS0KmoeCnr/lC/4dYRHD+7TEAt5xceg/JJcbeEX2JQEPp71eIlrGluNp5CvA3jv+z4pTu4NtM6OFHMJ//Tm5W3dnwWxeGoWkbIFSNj2QcRsR+AEOPOlXyKef42FS96y8r8OYMe2HPJk2LF9yW8caHe1taY/V0vj2NYhJiV54Gcf03ZLXnuIiDe2061y7hhV5mbUaFlS9+CqnjN9+fklPvicm20sCZLzYdeqUVlPxm0mJ1w3HQcdTPhd0lVJahP5OVle9Ht7ZXvF6eZoSppM8nUUGEvZhEViD4xwTnwZRm5ilKgVpahGTCEhAuNE+ulNaEslmgPA8gNz3S4AX4I365lmwksvpOdMZeSoH+x238f9CE4Ya1Mcpmn+hDWkyd93z2WxoEaQgnEsYzrjl5cj17oBj2aWuJPMQJUBt0o3LMpWI6CgY5xAlKvHcU9BhgFTJeCj7MOrjxEfyqpmN3BVxnC91kN6eLZH89rjn+8YgWODk7Y7AxP7g7lKkR3NrQGXH/vbO6eYdT2VNy/b46zXWTeUxYNm3DhH1ZWFunD7kTcWUpppu05NQ613Hx1ZZCvQ9S3QAz+YSIaiy7VityD6mUMEh/NsTHqSu1K0/kdelkOVRd1xUpZwUKnYn0/biTri7zYTbLIayQzZKHjdLn3M8e1d4NJLVXNDm56Ci3oQO/OipHZF+en/OnI12/hOxk1izHtOExR4zobg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(110136005)(36756003)(6666004)(26005)(1076003)(336012)(66574015)(47076005)(478600001)(2616005)(36860700001)(54906003)(83380400001)(316002)(70206006)(70586007)(426003)(7636003)(4326008)(8676002)(356005)(8936002)(41300700001)(5660300002)(82740400003)(2906002)(86362001)(40480700001)(40460700003)(41533002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:33.4455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 383acad4-aaed-419b-0348-08dbcffdfa4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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

VGhleSB3aWxsIGJlIHVzZWQgaW4gYSBmb2xsb3ctdXAgcGF0Y2guCgpGb3IgZHVwX2lvdGxiLCBh
dm9pZCB0aGUgc3JjID09IGRzdCBjYXNlLiBUaGlzIGlzIGFuIGVycm9yLgoKQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CkFja2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8
ZXBlcmV6bWFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1
bGVhQG52aWRpYS5jb20+Ci0tLQogZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIHwgMTkgKysr
KysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIGIvZHJp
dmVycy92ZHBhL21seDUvY29yZS9tci5jCmluZGV4IDNkZWU2ZDliZWQ2Yi4uNGEzZGY4NjVkZjQw
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKKysrIGIvZHJpdmVycy92
ZHBhL21seDUvY29yZS9tci5jCkBAIC00NTQsMjAgKzQ1NCwyMyBAQCBzdGF0aWMgdm9pZCBkZXN0
cm95X2RtYV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFf
bXIgKm1yKQogCW1seDVfdmRwYV9kZXN0cm95X21rZXkobXZkZXYsIG1yLT5ta2V5KTsKIH0KIAot
c3RhdGljIGludCBkdXBfaW90bGIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qg
dmhvc3RfaW90bGIgKnNyYykKK3N0YXRpYyBpbnQgZHVwX2lvdGxiKHN0cnVjdCB2aG9zdF9pb3Rs
YiAqZHN0LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKnNyYykKIHsKIAlzdHJ1Y3Qgdmhvc3RfaW90bGJf
bWFwICptYXA7CiAJdTY0IHN0YXJ0ID0gMCwgbGFzdCA9IFVMTE9OR19NQVg7CiAJaW50IGVycjsK
IAorCWlmIChkc3QgPT0gc3JjKQorCQlyZXR1cm4gLUVJTlZBTDsKKwogCWlmICghc3JjKSB7Ci0J
CWVyciA9IHZob3N0X2lvdGxiX2FkZF9yYW5nZShtdmRldi0+Y3ZxLmlvdGxiLCBzdGFydCwgbGFz
dCwgc3RhcnQsIFZIT1NUX0FDQ0VTU19SVyk7CisJCWVyciA9IHZob3N0X2lvdGxiX2FkZF9yYW5n
ZShkc3QsIHN0YXJ0LCBsYXN0LCBzdGFydCwgVkhPU1RfQUNDRVNTX1JXKTsKIAkJcmV0dXJuIGVy
cjsKIAl9CiAKIAlmb3IgKG1hcCA9IHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KHNyYywgc3RhcnQs
IGxhc3QpOyBtYXA7CiAJCW1hcCA9IHZob3N0X2lvdGxiX2l0cmVlX25leHQobWFwLCBzdGFydCwg
bGFzdCkpIHsKLQkJZXJyID0gdmhvc3RfaW90bGJfYWRkX3JhbmdlKG12ZGV2LT5jdnEuaW90bGIs
IG1hcC0+c3RhcnQsIG1hcC0+bGFzdCwKKwkJZXJyID0gdmhvc3RfaW90bGJfYWRkX3JhbmdlKGRz
dCwgbWFwLT5zdGFydCwgbWFwLT5sYXN0LAogCQkJCQkgICAgbWFwLT5hZGRyLCBtYXAtPnBlcm0p
OwogCQlpZiAoZXJyKQogCQkJcmV0dXJuIGVycjsKQEAgLTQ3NSw5ICs0NzgsOSBAQCBzdGF0aWMg
aW50IGR1cF9pb3RsYihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9p
b3RsYiAqc3JjKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgdm9pZCBwcnVuZV9pb3RsYihzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCitzdGF0aWMgdm9pZCBwcnVuZV9pb3RsYihzdHJ1Y3Qg
dmhvc3RfaW90bGIgKmlvdGxiKQogewotCXZob3N0X2lvdGxiX2RlbF9yYW5nZShtdmRldi0+Y3Zx
LmlvdGxiLCAwLCBVTExPTkdfTUFYKTsKKwl2aG9zdF9pb3RsYl9kZWxfcmFuZ2UoaW90bGIsIDAs
IFVMTE9OR19NQVgpOwogfQogCiBzdGF0aWMgdm9pZCBkZXN0cm95X3VzZXJfbXIoc3RydWN0IG1s
eDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX21yICptcikKQEAgLTU0NCw3ICs1
NDcsNyBAQCB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yX3Jlc291cmNlcyhzdHJ1Y3QgbWx4NV92
ZHBhX2RldiAqbXZkZXYpCiAJZm9yIChpbnQgaSA9IDA7IGkgPCBNTFg1X1ZEUEFfTlVNX0FTOyBp
KyspCiAJCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2LCBtdmRldi0+bXJbaV0pOwogCi0JcHJ1
bmVfaW90bGIobXZkZXYpOworCXBydW5lX2lvdGxiKG12ZGV2LT5jdnEuaW90bGIpOwogfQogCiBz
dGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diwKQEAgLTU5Niw4ICs1OTksOCBAQCBpbnQgbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIoc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAogCiAJc3Bpbl9sb2NrKCZtdmRldi0+Y3ZxLmlvbW11
X2xvY2spOwogCi0JcHJ1bmVfaW90bGIobXZkZXYpOwotCWVyciA9IGR1cF9pb3RsYihtdmRldiwg
aW90bGIpOworCXBydW5lX2lvdGxiKG12ZGV2LT5jdnEuaW90bGIpOworCWVyciA9IGR1cF9pb3Rs
YihtdmRldi0+Y3ZxLmlvdGxiLCBpb3RsYik7CiAKIAlzcGluX3VubG9jaygmbXZkZXYtPmN2cS5p
b21tdV9sb2NrKTsKIAotLSAKMi40MS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
