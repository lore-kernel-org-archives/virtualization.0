Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C764FCDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78571421B5;
	Wed, 18 Oct 2023 17:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78571421B5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bp4AuE4I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tF__JPv1RFJ7; Wed, 18 Oct 2023 17:16:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C522421AA;
	Wed, 18 Oct 2023 17:16:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C522421AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 782BCC0039;
	Wed, 18 Oct 2023 17:16:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B794FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85A366F539
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85A366F539
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Bp4AuE4I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ltc80nFrrdF1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::613])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A7F06F531
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A7F06F531
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpRj7sFrdqTJF2zTAcRS2tugm6DZx6p7nxYr3PlHDgfX0eoiiNc1o4QYowH3HqaygueV/Szx/J/6bADTqfXpSMkz1+XcgSzeeF9kVOreQe9ldyP9cZ4tdwZIAUgSA+57072/ftT26IDL3Hvtl5N/YbEmr67VJlC3W2D+DYqp2zCZY9dl+jFPdqVvkFaf5aeEnREnKrFpqx2t8xQrlR5z5ZjC8oc0Hdz5o5cUmW/f8jyAFFirazbvyxbJg7NIs5gr8NVKBNo/T6Y03RaGGw405vl6St0t6FKxec3SorkLSo38duw9wSfH9JPDuQARkd/JJ0LWqcqL/vhTk/BGJV0nFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/riwkRSoi1nVotT7iLhK2hAguH78ZBh8oaLsGcPRlY=;
 b=ktq4HaNCBVPcivo0+Q9ccTnfFQ0QOr/k9PbElV1KdpYRUQKV+Z6lC8osSxN/gjZF/1lZcBYXoB6SGVspgK9oKbLiQcRFf8eM51t0myeo3u1Rc2C0CFrdMVgidmp/h+tcHj+X1rU395h4kZjvEgJrwMK4x/tAoiC4X/h3eWwkG/u0Q3ydmDq+A2h0fP3/Rd+jEPU5eBuvWFRay1MZFyHiW9S8r+U4+lCa4O4ao4hnuSlEjZVlPSmGMfvoM18CX8ZTD89N2Cus28jQDtP4f8QSXpexSD5zOmMMX8dLPbWUzcKEgKEkxuoDrSRcdQvb8Kg27JhjvGaQ5xvOUTFNgxw44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/riwkRSoi1nVotT7iLhK2hAguH78ZBh8oaLsGcPRlY=;
 b=Bp4AuE4Ixc4c8pHb2s38uxHpa7yRmGloy97Wrzb23CjJEsa26gdLKZofy7EWGyKoFfazyRExlSyA/VC2HWo/n7q0MxnDTsb2hW+QQmB+z0OmktY/MFqFB1a/1wmSnsHoVbMh7OWZ6ZLiGSTsu/A0EpRYur6P7NVKEUssWNrMCRvTzdotDW6PsrXXyWiFKlW/rkam3jTZUo5mNezRktoYM0G7Vgv3J/NhvqNvps/cOS9TZ7YjFsYo3UZjY+kTrc7XfY5kOWJNk1zylItMc/OYmgfkEKWW1a9wfDfM6KUmNP/jVc7PuHU17LhY2oncFoC2hLC/O89HUV6QerDd/g8xEA==
Received: from CY5P221CA0143.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::13)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:16:26 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::bb) by CY5P221CA0143.outlook.office365.com
 (2603:10b6:930:6a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:25 +0000
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
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:16:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:12 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:16:09 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 13/16] vdpa/mlx5: Introduce mr for vq descriptor
Date: Wed, 18 Oct 2023 20:14:52 +0300
Message-ID: <20231018171456.1624030-15-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SA0PR12MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: cd83ee9a-e141-43fa-95b0-08dbcffdf5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcKMgssP9vdVKuyhJMCqPmzmE3aNah2+q5ca8h0ifg3WWRaXJPAujkOAEndDlYZKotHAjQwotDxcFWc6Xf8AQbHckJi//p2fd7GEZfy1OuixDoC7iq1RhpX63WY9fCp7YHidIOIMY6/kB6H0QnYEQPPha63naQmMAbw8/YNy3QFSpaah4aGFyW2yAJPUgJTNVotSQwAsgxzDBSYLv1ZI7BDqCjD+VdzUlYAP5vbMBv8Cum9U5n/eQuvOAgKzHv48pAEA8+mK9cTpbXgGeZBZic7KhLqZP5/iuF2fmyjX4o/TcGYdIjU+gAGfi8QDOB6nPL2mMG6kz1cxRaM++MoKhfdhq8m73favLjB/wQ+oOrQTV2SpRk7Kem/CZtrB70WVtPqwWMAD1FyrsqonK6wSeZMabpUGxte/cdhGLMrBuBQvWi5rVFpqXms/nbM2wVm2rYv0mizshfQl4hbxrwyUO5ufQn1sOZ1jUJHyCjFPU7DouoiaT37a6HQ1dt0K0tKcd2HrQ8QecXBIAaR0W+K7u7vj1tQIxeRq47vWNvtvKtr7hoYzOfn9JcRo3zLhAK5edvISQ+gsP9oYWYpKCA5nAlP2YTrPNXG9O5ah+KoXjEK50MMv4NZAkX0Luw0V4aLPioYbC2H5+rEc2qsHZIogdkEznGFBmWbqrzVbe3Eu+qPfqkf3IOLel+tbGtbKkFnCJXXvg2K2waeiEZrdu5Nmle5g6grVogYbNNSkq2iGKgg=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(1076003)(26005)(6666004)(426003)(4326008)(2616005)(83380400001)(336012)(36860700001)(66574015)(8936002)(8676002)(316002)(5660300002)(47076005)(41300700001)(2906002)(478600001)(82740400003)(110136005)(70206006)(54906003)(70586007)(86362001)(7636003)(356005)(36756003)(40480700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:25.7881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd83ee9a-e141-43fa-95b0-08dbcffdf5bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
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
IHN1cHBvcnQgZm9yIG1hcHBpbmcgdGhlIHZxIGRlc2NyaXB0b3JzLgoKQWNrZWQtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CkFja2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBl
cmV6bWFAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+Ci0tLQogZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCB8ICA1
ICsrKy0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgICAgICAgIHwgMTQgKysrKysrKysr
LS0tLS0KIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCAyMCArKysrKysrKysr
KysrLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIGIv
ZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAppbmRleCBiYmU0MzM1MTA2YmQuLmFl
MDkyOTZmNDI3MCAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEu
aAorKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCkBAIC03MCwxMSArNzAs
MTIgQEAgc3RydWN0IG1seDVfdmRwYV93cV9lbnQgewogZW51bSB7CiAJTUxYNV9WRFBBX0RBVEFW
UV9HUk9VUCwKIAlNTFg1X1ZEUEFfQ1ZRX0dST1VQLAorCU1MWDVfVkRQQV9EQVRBVlFfREVTQ19H
Uk9VUCwKIAlNTFg1X1ZEUEFfTlVNVlFfR1JPVVBTCiB9OwogCiBlbnVtIHsKLQlNTFg1X1ZEUEFf
TlVNX0FTID0gTUxYNV9WRFBBX05VTVZRX0dST1VQUworCU1MWDVfVkRQQV9OVU1fQVMgPSAyCiB9
OwogCiBzdHJ1Y3QgbWx4NV92ZHBhX2RldiB7CkBAIC04OSw3ICs5MCw3IEBAIHN0cnVjdCBtbHg1
X3ZkcGFfZGV2IHsKIAl1MTYgbWF4X2lkeDsKIAl1MzIgZ2VuZXJhdGlvbjsKIAotCXN0cnVjdCBt
bHg1X3ZkcGFfbXIgKm1yOworCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yW01MWDVfVkRQQV9OVU1f
QVNdOwogCS8qIHNlcmlhbGl6ZSBtciBhY2Nlc3MgKi8KIAlzdHJ1Y3QgbXV0ZXggbXJfbXR4Owog
CXN0cnVjdCBtbHg1X2NvbnRyb2xfdnEgY3ZxOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21s
eDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCmluZGV4IDAwZWZmNWEw
NzE1Mi4uM2RlZTZkOWJlZDZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21y
LmMKKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCkBAIC01MTEsOCArNTExLDEwIEBA
IHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAog
CiAJX21seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2LCBtcik7CiAKLQlpZiAobXZkZXYtPm1yID09
IG1yKQotCQltdmRldi0+bXIgPSBOVUxMOworCWZvciAoaW50IGkgPSAwOyBpIDwgTUxYNV9WRFBB
X05VTV9BUzsgaSsrKSB7CisJCWlmIChtdmRldi0+bXJbaV0gPT0gbXIpCisJCQltdmRldi0+bXJb
aV0gPSBOVUxMOworCX0KIAogCW11dGV4X3VubG9jaygmbXZkZXYtPm1yX210eCk7CiAKQEAgLTUy
MywxMSArNTI1LDExIEBAIHZvaWQgbWx4NV92ZHBhX3VwZGF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYsCiAJCQkgc3RydWN0IG1seDVfdmRwYV9tciAqbmV3X21yLAogCQkJIHVuc2ln
bmVkIGludCBhc2lkKQogewotCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm9sZF9tciA9IG12ZGV2LT5t
cjsKKwlzdHJ1Y3QgbWx4NV92ZHBhX21yICpvbGRfbXIgPSBtdmRldi0+bXJbYXNpZF07CiAKIAlt
dXRleF9sb2NrKCZtdmRldi0+bXJfbXR4KTsKIAotCW12ZGV2LT5tciA9IG5ld19tcjsKKwltdmRl
di0+bXJbYXNpZF0gPSBuZXdfbXI7CiAJaWYgKG9sZF9tcikgewogCQlfbWx4NV92ZHBhX2Rlc3Ry
b3lfbXIobXZkZXYsIG9sZF9tcik7CiAJCWtmcmVlKG9sZF9tcik7CkBAIC01MzksNyArNTQxLDkg
QEAgdm9pZCBtbHg1X3ZkcGFfdXBkYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwK
IAogdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcl9yZXNvdXJjZXMoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2KQogewotCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2LCBtdmRldi0+bXIpOwor
CWZvciAoaW50IGkgPSAwOyBpIDwgTUxYNV9WRFBBX05VTV9BUzsgaSsrKQorCQltbHg1X3ZkcGFf
ZGVzdHJveV9tcihtdmRldiwgbXZkZXYtPm1yW2ldKTsKKwogCXBydW5lX2lvdGxiKG12ZGV2KTsK
IH0KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCmluZGV4IDdiODc4OTk1YjZhYS4uZWE3NmMw
YjRiNzhlIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKKysr
IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCkBAIC04MjEsNiArODIxLDggQEAg
c3RhdGljIGludCBjcmVhdGVfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBz
dHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWUKIHsKIAlpbnQgaW5sZW4gPSBNTFg1X1NUX1NaX0JZVEVT
KGNyZWF0ZV92aXJ0aW9fbmV0X3FfaW4pOwogCXUzMiBvdXRbTUxYNV9TVF9TWl9EVyhjcmVhdGVf
dmlydGlvX25ldF9xX291dCldID0ge307CisJc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0g
Jm5kZXYtPm12ZGV2OworCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKnZxX21yOwogCXZvaWQgKm9ial9j
b250ZXh0OwogCXUxNiBtbHhfZmVhdHVyZXM7CiAJdm9pZCAqY21kX2hkcjsKQEAgLTg3Myw3ICs4
NzUsOSBAQCBzdGF0aWMgaW50IGNyZWF0ZV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQg
Km5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZQogCU1MWDVfU0VUNjQodmlydGlvX3EsIHZx
X2N0eCwgZGVzY19hZGRyLCBtdnEtPmRlc2NfYWRkcik7CiAJTUxYNV9TRVQ2NCh2aXJ0aW9fcSwg
dnFfY3R4LCB1c2VkX2FkZHIsIG12cS0+ZGV2aWNlX2FkZHIpOwogCU1MWDVfU0VUNjQodmlydGlv
X3EsIHZxX2N0eCwgYXZhaWxhYmxlX2FkZHIsIG12cS0+ZHJpdmVyX2FkZHIpOwotCU1MWDVfU0VU
KHZpcnRpb19xLCB2cV9jdHgsIHZpcnRpb19xX21rZXksIG5kZXYtPm12ZGV2Lm1yLT5ta2V5KTsK
Kwl2cV9tciA9IG12ZGV2LT5tclttdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dS
T1VQXV07CisJaWYgKHZxX21yKQorCQlNTFg1X1NFVCh2aXJ0aW9fcSwgdnFfY3R4LCB2aXJ0aW9f
cV9ta2V5LCB2cV9tci0+bWtleSk7CiAJTUxYNV9TRVQodmlydGlvX3EsIHZxX2N0eCwgdW1lbV8x
X2lkLCBtdnEtPnVtZW0xLmlkKTsKIAlNTFg1X1NFVCh2aXJ0aW9fcSwgdnFfY3R4LCB1bWVtXzFf
c2l6ZSwgbXZxLT51bWVtMS5zaXplKTsKIAlNTFg1X1NFVCh2aXJ0aW9fcSwgdnFfY3R4LCB1bWVt
XzJfaWQsIG12cS0+dW1lbTIuaWQpOwpAQCAtMjYzMyw3ICsyNjM3LDggQEAgc3RhdGljIHZvaWQg
cmVzdG9yZV9jaGFubmVsc19pbmZvKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQogfQogCiBz
dGF0aWMgaW50IG1seDVfdmRwYV9jaGFuZ2VfbWFwKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diwKLQkJCQlzdHJ1Y3QgbWx4NV92ZHBhX21yICpuZXdfbXIsIHVuc2lnbmVkIGludCBhc2lkKQor
CQkJCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm5ld19tciwKKwkJCQl1bnNpZ25lZCBpbnQgYXNpZCkK
IHsKIAlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2
KTsKIAlpbnQgZXJyOwpAQCAtMjY1Miw4ICsyNjU3LDEwIEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBh
X2NoYW5nZV9tYXAoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAogCiAJcmVzdG9yZV9jaGFu
bmVsc19pbmZvKG5kZXYpOwogCWVyciA9IHNldHVwX2RyaXZlcihtdmRldik7CisJaWYgKGVycikK
KwkJcmV0dXJuIGVycjsKIAotCXJldHVybiBlcnI7CisJcmV0dXJuIDA7CiB9CiAKIC8qIHJlc2xv
Y2sgbXVzdCBiZSBoZWxkIGZvciB0aGlzIGZ1bmN0aW9uICovCkBAIC0yODY5LDggKzI4NzYsOCBA
QCBzdGF0aWMgaW50IHNldF9tYXBfZGF0YShzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0
cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCiAJc3RydWN0IG1seDVfdmRwYV9tciAqbmV3X21yOwog
CWludCBlcnI7CiAKLQlpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9V
UF0gIT0gYXNpZCkKLQkJZ290byBlbmQ7CisJaWYgKGFzaWQgPj0gTUxYNV9WRFBBX05VTV9BUykK
KwkJcmV0dXJuIC1FSU5WQUw7CiAKIAlpZiAodmhvc3RfaW90bGJfaXRyZWVfZmlyc3QoaW90bGIs
IDAsIFU2NF9NQVgpKSB7CiAJCW5ld19tciA9IG1seDVfdmRwYV9jcmVhdGVfbXIobXZkZXYsIGlv
dGxiKTsKQEAgLTI4ODQsNyArMjg5MSw3IEBAIHN0YXRpYyBpbnQgc2V0X21hcF9kYXRhKHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKIAkJbmV3
X21yID0gTlVMTDsKIAl9CiAKLQlpZiAoIW12ZGV2LT5tcikgeworCWlmICghbXZkZXYtPm1yW2Fz
aWRdKSB7CiAJCW1seDVfdmRwYV91cGRhdGVfbXIobXZkZXYsIG5ld19tciwgYXNpZCk7CiAJfSBl
bHNlIHsKIAkJZXJyID0gbWx4NV92ZHBhX2NoYW5nZV9tYXAobXZkZXYsIG5ld19tciwgYXNpZCk7
CkBAIC0yODk0LDcgKzI5MDEsNiBAQCBzdGF0aWMgaW50IHNldF9tYXBfZGF0YShzdHJ1Y3QgbWx4
NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCiAJCX0KIAl9CiAK
LWVuZDoKIAlyZXR1cm4gbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIobXZkZXYsIGlvdGxiLCBh
c2lkKTsKIAogb3V0X2VycjoKLS0gCjIuNDEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
