Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2369E95A8E
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D86882016;
	Mon,  9 Oct 2023 11:25:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D86882016
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Eg//R/Hm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V0CQvB9JPN0G; Mon,  9 Oct 2023 11:25:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AE4DB82011;
	Mon,  9 Oct 2023 11:25:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE4DB82011
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9878CC0039;
	Mon,  9 Oct 2023 11:25:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCC78C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 742F1612A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 742F1612A1
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Eg//R/Hm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jvcEnz_UIJ_Q
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EAD7611FA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EAD7611FA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+A2PJFcPjRoJEqL8KdMONbWa9KzJj5sDW5A75269KwKIySoNq1Vi9bnVezRb5JgSIzZ/x9RyGflZKKMONsFXEQjtXIdRGEhBGqsayKj2oLhOafq5wVpexFxr9VdO99A+oCwSaXgGJ4YFCKxYHKy0eE8wXsEDF0YvqSeqXtkxraagOEVH98/yewh/Pf6+Rf+gQpo/S9xXa7AEewBF3okGLsT6W44b9Sz7ZTDWnd0oQdEumvIswkIcnzsiG01SOOZpxpbXrGzCx2z9e0gDp778aV0Z8c/cjRoyrU8iBXOuxHC74WFvLW8iEHRyxS57xN4OqpF05KWHkbWpobvq7NaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy1kaZQzU+m3/SX/tOV5uK0InINX2soflKNDLMzJf7k=;
 b=JWJIPnVbhm/F59/++MNrhM2qj5dwXEZuVim3DiAsFbKspVJuOJQFGapDz7Bb7yAY8GMEBXCa9FkM3ovhE1KjtGf6bHolHgu7ZcDkFAIeegJWvGu5Um1zmJtoP6oSa+8KA2NiaQ2kgyqd7PigW7qqpCMk+t5pTJEoyhpKD9orj+Dr2joSN9Q4DtVvWIpRMfVM/d88ZfyLiP9cAyUnrJzmtfG0lPoU04E2UF4+a48yk8w6l3GTx08liFj7HektxpmB96GSOFmeXUpPMKcmGDLBqXZrZbefkJix0rxM4u8n8t3utVqB3MbqHRPlrr52T2ASGbs5s3LVTGYY7r+C3cZ9yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy1kaZQzU+m3/SX/tOV5uK0InINX2soflKNDLMzJf7k=;
 b=Eg//R/Hm6vAtS62YUqU1L8bsrGGSMqw/k8I4M8UfE/MxKcw6T5KVqvVv8LAj6sD6HL4tvBnBIXhOgixZL54S7cjY5YuA9kEuKLjdzyQdYzhkt/FQ5n4BeUYBCUKT4M4IdNJgxcHJV7BDe7l0SpEzb/ojyYsI2Sy0n5t7ODc2YdVAvIkwzq2Mux+FftNqnEsJLJl4k/CktWKe5HlQMspTCO0/mHPN+g1GKzZat2xVTNQ9sCMbfyWR7czagBF4CM5RWRx67EZxC8lzRWjk9/8CJa8b7YZ+SfEoqiqWElxfIOy+vlLfPFgmuVqdd7of+w/oVWfphxLDxYK8BYicSsnSxQ==
Received: from BLAPR03CA0050.namprd03.prod.outlook.com (2603:10b6:208:32d::25)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 11:25:14 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::fa) by BLAPR03CA0050.outlook.office365.com
 (2603:10b6:208:32d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 11:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 11:25:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:57 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:54 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 11/16] vdpa/mlx5: Move mr mutex out of mr struct
Date: Mon, 9 Oct 2023 14:23:56 +0300
Message-ID: <20231009112401.1060447-12-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1037588c-8da1-43b0-564d-08dbc8ba6886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiMISNbywyjp7ySCHohJd641a1v0sXTZ7inHtLvE+SSsIkyVaNtoAp3zS5V6HIvwN1GHA7FPQGhr5a1AOzpUkAD7DimohuDeRcr/IH0+5GqMA6pnWvu33cf9zARYYRjNlFKvtC+Wh5KducIdTmy8P2JDA5MtxL3l8gsl1S7itkh96QyeC+NiATPhkBxYqGgfVRiaD6ZAOw40p2DIo4F64pmwrq0+gVrJGVxBqTif9YFfyC4BFntEkusyjn2NQ9qes1NzMzXCt2yDyA1smkGWC2GRrPl7jXU3guE5BiyDllOGfVzonNi2QoBvnC9u5c7RIssL9FV4OKbiWcWYGFcud4Vdlx1sO58JsyASae7F1tnvKxwkIdF/cHnJlFjGZylk4iNsoltknRPQG1ljlZM4JlJ9LbBdMzzSzoPBpmBiLEt6+/D8QULdcTCK/4iQgSECpf6exjWznso1V3LQtRB2eEcDAsuDKeJKxeerlAY0pXs4CO/hMkfPmNTZOwYF6FnHo4PrjLs9FAQEJ7YrdC4Asm16ePWnzIDnZgiJuTmGs9pY8wKQoP08kYEftWfhYnNl88Jp3uSF2hzO53Y4b5eYngCsm9PxqpXGlODzY8DcAvGR9f7iSbTWWQ0ZMPWi2BzW3BYcqSmzgTUYCvLWYcWucXKqmu36rTMfZHojJC0zzLqmY19oIQGL6+SInn2pilqH/xMs4AwRzJI8h3Xdd178n/fADuRBEWGnDZYVBruhIzupfA7ehkhjKNjvReygxf9Y
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(7636003)(356005)(36756003)(66899024)(40480700001)(82740400003)(2906002)(478600001)(41300700001)(8936002)(5660300002)(4326008)(8676002)(1076003)(83380400001)(426003)(336012)(2616005)(40460700003)(316002)(36860700001)(70586007)(70206006)(54906003)(110136005)(26005)(47076005)(66574015);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:25:14.4132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1037588c-8da1-43b0-564d-08dbc8ba6886
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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
OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL3ZkcGEv
bWx4NS9jb3JlL21seDVfdmRwYS5oIHwgIDQgKystLQogZHJpdmVycy92ZHBhL21seDUvY29yZS9t
ci5jICAgICAgICB8IDEzICsrKysrKystLS0tLS0KIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVz
b3VyY2VzLmMgfCAgNiArKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1
X3ZkcGEuaCBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKaW5kZXggMDFkNGVl
NThjY2IxLi45YzZhYzQyYzIxZTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUv
bWx4NV92ZHBhLmgKKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaApAQCAt
MzQsOCArMzQsNiBAQCBzdHJ1Y3QgbWx4NV92ZHBhX21yIHsKIAkvKiBzdGF0ZSBvZiBkdnEgbXIg
Ki8KIAlib29sIGluaXRpYWxpemVkOwogCi0JLyogc2VyaWFsaXplIG1rZXkgY3JlYXRpb24gYW5k
IGRlc3RydWN0aW9uICovCi0Jc3RydWN0IG11dGV4IG1rZXlfbXR4OwogCWJvb2wgdXNlcl9tcjsK
IH07CiAKQEAgLTk0LDYgKzkyLDggQEAgc3RydWN0IG1seDVfdmRwYV9kZXYgewogCXUzMiBnZW5l
cmF0aW9uOwogCiAJc3RydWN0IG1seDVfdmRwYV9tciBtcjsKKwkvKiBzZXJpYWxpemUgbXIgYWNj
ZXNzICovCisJc3RydWN0IG11dGV4IG1yX210eDsKIAlzdHJ1Y3QgbWx4NV9jb250cm9sX3ZxIGN2
cTsKIAlzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd3E7CiAJdW5zaWduZWQgaW50IGdyb3VwMmFz
aWRbTUxYNV9WRFBBX05VTVZRX0dST1VQU107CmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4
NS9jb3JlL21yLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKaW5kZXggNmYyOWU4ZWFh
YmIxLi5hYmQ2YTZmYjEyMmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIu
YworKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKQEAgLTUwOSwxMSArNTA5LDExIEBA
IHN0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfCiB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yKHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKIAkJCSAgc3RydWN0IG1seDVfdmRwYV9tciAqbXIpCiB7
Ci0JbXV0ZXhfbG9jaygmbXItPm1rZXlfbXR4KTsKKwltdXRleF9sb2NrKCZtdmRldi0+bXJfbXR4
KTsKIAogCV9tbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldiwgbXIpOwogCi0JbXV0ZXhfdW5sb2Nr
KCZtci0+bWtleV9tdHgpOworCW11dGV4X3VubG9jaygmbXZkZXYtPm1yX210eCk7CiB9CiAKIHZv
aWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfcmVzb3VyY2VzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICpt
dmRldikKQEAgLTU1MCw5ICs1NTAsMTAgQEAgaW50IG1seDVfdmRwYV9jcmVhdGVfbXIoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LAogewogCWludCBlcnI7CiAKLQltdXRleF9sb2NrKCZtdmRl
di0+bXIubWtleV9tdHgpOworCW11dGV4X2xvY2soJm12ZGV2LT5tcl9tdHgpOwogCWVyciA9IF9t
bHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCBtciwgaW90bGIpOwotCW11dGV4X3VubG9jaygmbXZk
ZXYtPm1yLm1rZXlfbXR4KTsKKwltdXRleF91bmxvY2soJm12ZGV2LT5tcl9tdHgpOworCiAJcmV0
dXJuIGVycjsKIH0KIApAQCAtNTYzLDE0ICs1NjQsMTQgQEAgaW50IG1seDVfdmRwYV9oYW5kbGVf
c2V0X21hcChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAq
aW8KIAlpbnQgZXJyID0gMDsKIAogCSpjaGFuZ2VfbWFwID0gZmFsc2U7Ci0JbXV0ZXhfbG9jaygm
bXItPm1rZXlfbXR4KTsKKwltdXRleF9sb2NrKCZtdmRldi0+bXJfbXR4KTsKIAlpZiAobXItPmlu
aXRpYWxpemVkKSB7CiAJCW1seDVfdmRwYV9pbmZvKG12ZGV2LCAibWVtb3J5IG1hcCB1cGRhdGVc
biIpOwogCQkqY2hhbmdlX21hcCA9IHRydWU7CiAJfQogCWlmICghKmNoYW5nZV9tYXApCiAJCWVy
ciA9IF9tbHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCBtciwgaW90bGIpOwotCW11dGV4X3VubG9j
aygmbXItPm1rZXlfbXR4KTsKKwltdXRleF91bmxvY2soJm12ZGV2LT5tcl9tdHgpOwogCiAJcmV0
dXJuIGVycjsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2Vz
LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCmluZGV4IGQ1YTU5YzkwMzVm
Yi4uNWM1YTQxYjY0YmZjIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291
cmNlcy5jCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKQEAgLTI1Niw3
ICsyNTYsNyBAQCBpbnQgbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcyhzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYpCiAJCW1seDVfdmRwYV93YXJuKG12ZGV2LCAicmVzb3VyY2VzIGFscmVhZHkg
YWxsb2NhdGVkXG4iKTsKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQotCW11dGV4X2luaXQoJm12ZGV2
LT5tci5ta2V5X210eCk7CisJbXV0ZXhfaW5pdCgmbXZkZXYtPm1yX210eCk7CiAJcmVzLT51YXIg
PSBtbHg1X2dldF91YXJzX3BhZ2UobWRldik7CiAJaWYgKElTX0VSUihyZXMtPnVhcikpIHsKIAkJ
ZXJyID0gUFRSX0VSUihyZXMtPnVhcik7CkBAIC0zMDEsNyArMzAxLDcgQEAgaW50IG1seDVfdmRw
YV9hbGxvY19yZXNvdXJjZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQogZXJyX3VjdHg6
CiAJbWx4NV9wdXRfdWFyc19wYWdlKG1kZXYsIHJlcy0+dWFyKTsKIGVycl91YXJzOgotCW11dGV4
X2Rlc3Ryb3koJm12ZGV2LT5tci5ta2V5X210eCk7CisJbXV0ZXhfZGVzdHJveSgmbXZkZXYtPm1y
X210eCk7CiAJcmV0dXJuIGVycjsKIH0KIApAQCAtMzE4LDYgKzMxOCw2IEBAIHZvaWQgbWx4NV92
ZHBhX2ZyZWVfcmVzb3VyY2VzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKIAlkZWFsbG9j
X3BkKG12ZGV2LCByZXMtPnBkbiwgcmVzLT51aWQpOwogCWRlc3Ryb3lfdWN0eChtdmRldiwgcmVz
LT51aWQpOwogCW1seDVfcHV0X3VhcnNfcGFnZShtdmRldi0+bWRldiwgcmVzLT51YXIpOwotCW11
dGV4X2Rlc3Ryb3koJm12ZGV2LT5tci5ta2V5X210eCk7CisJbXV0ZXhfZGVzdHJveSgmbXZkZXYt
Pm1yX210eCk7CiAJcmVzLT52YWxpZCA9IGZhbHNlOwogfQotLSAKMi40MS4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
