Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D73CDB482
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70BC24192A;
	Wed, 18 Oct 2023 17:16:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70BC24192A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KUTXn69/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GO5OSuOq_zdr; Wed, 18 Oct 2023 17:16:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 707FF409C8;
	Wed, 18 Oct 2023 17:16:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 707FF409C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 484E6C0039;
	Wed, 18 Oct 2023 17:16:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13603C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E346C42189
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E346C42189
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=KUTXn69/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4paH3DvWN9zS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::626])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90976421B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90976421B3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RODKhLcytcyJmaRu1MEW/3wFEeBr+qRc1ykeaFRtAyiampr2eQARjgrD9pO2G9NZQ8lQC7lL9e3y0FW1YQMjeVUHj6qJZe0CeDLEgnRAGuqCeR6JPAC2npLdHQIyyqKyf/xnZnLEcc2tO3VBcq/ViSQTxRqDhAEuVwBXL0K4J7rXO6P9PcQW8epXbB+kX5GY58+h2t0fzX4cEdZDi2LwnqVrB8SiltHF6HmVdshV2sl3A38Bco9QHIzqMnR6EyYLLvw5q41F38Sk86a9/v64IJ8z+lPXLV25qzjY+/ezHz9Vw/Nt+xRB+54J8HGvoxR3wXy35YEGrzbbOrJZiN+/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elzKdMTRh3uezwMcgzMejLd/DLpkMeh3g8HOvOAJXm0=;
 b=PTfAczDB5IutLYWhcuL1J25MtESt5vBfnjRezGDhrQDisu7R8E1w9jMiuRlqs+dk/bWlSl87wBdnEer8x/2npWQVOFS9dbW8ReNw4p5o8DhgyAwEWLNHLaUhhIvcTnzlLBHCLpyrhHZ/GqQeQesbeKjsTeuclk8wpHlu6x8ln54pjwryXcJI4de7C2DlHLmvPQZWrL6f4QDS/RWMP8dddFR8nbpX+3R0zqfQtm9ZNWJyf8/lewl8+yEEOiAD+D9HrV0b0cryhHvTjGZZpYP/8BKdlONewbaZuBlJmmbObeP6fl59jbVN8nDol047IkNn4xQnVJ4Xj/vrqFTrxAc0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elzKdMTRh3uezwMcgzMejLd/DLpkMeh3g8HOvOAJXm0=;
 b=KUTXn69/fiQrTcGUbeWTKJUCpB+Xjs3LTyFzwlli6YGtU0epVfL2J41TFVQHGhH07SB151l+v35q85aNm5OXcmgONi+RrtvAPF+0eHzybZ85yW2HIPKrkL72AXsyQ+YCn6cAhtx0VQQDc7bSiBryLyu7DtYvVCy4vKQppNKn0+pApCuRr4Y1oTOtbgtwPJvqtygQTSAV06klydaWm9Z9IBq1wpr8J9gVC3H1JjY3JV85mlSaH/P+dQOS85yk6ff9INO8Qj38yjg8Hgc+EnNvLG8R4KUZ6WrKTYnJlO2GFxu4vZ9KQKNhAm2fMfHhY+ga/Wua+YyLk7vbg4ClZTjKfQ==
Received: from CH2PR17CA0015.namprd17.prod.outlook.com (2603:10b6:610:53::25)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 17:16:09 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::6c) by CH2PR17CA0015.outlook.office365.com
 (2603:10b6:610:53::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 17:16:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:55 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:54 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:52 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 08/16] vdpa/mlx5: Collapse "dvq" mr add/delete
 functions
Date: Wed, 18 Oct 2023 20:14:47 +0300
Message-ID: <20231018171456.1624030-10-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA0PR12MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: a8802d4e-9112-4cfe-0908-08dbcffdeb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LwgzQrvSPtrOmmiOo4wqw5eAgP1JlQGuBRoI092gF3A2sGkqiKj9+GOXD/4Qwq7FiXc9+vXGnH2sMI4fMCImifaLCUKlpcRws9HbfpAtyI9nOjvvZmqMS33AhoI1zCsl2sL9vsoOfYiz17mDLc8A2JnjXze28BH3JRbKqoZ6mHlYGSX7FAP76FC01sJUkbpqXN0+OGpWe7K7A13B0F/LiSwHP8AFXE5TMURoZ/2OAw1878//0+TjHn84BfAEAJS3qB5+KepmyerERt6wU5DUq02k05zARPlZQyhF2c1cSqKqoIllqkeGuu3UYx6WxWmsY/d9uEdFWr5vXV3tDEt4noA4j05kxQ29/3t5fioNdGwjR+eBEi88IxuBuUNSGRrRIGX2EByoxHfUFS19qUwD8sj0D3WG4AkAnjy7MdbOPuRyzGSdaHSkpe38Bc3U28SybYVnd17if6q40/uzWGJZmbKVNJi5JQXaDatp8wX0GwqQmn98HEA+SwNxl4zTJKOv8fpah0BKlHp5RbGlx29MZfS7Fe69IZ7hXft+roFRwxNivQ2hm3ZgzABtvGo/f7xiYblr8yRLDtqjhGtr+vxVwB6TQWeFxoVoO7hIXKSCLxHwIuZ0G0MOzm0J460H/Ljxu66IoVabK3p7BLvgFE5W7N2efVNWV2b+EgXG+lvMKpGwv2997OmVoAZArJG++5BpvXyLHqt5aI1IZoT5q4UFZ0ka9+0HCR3FKchhuXiuYilo5cb8wsFLR+KunpKlwwC
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(40480700001)(36756003)(2616005)(316002)(1076003)(2906002)(86362001)(110136005)(70206006)(41300700001)(54906003)(5660300002)(4326008)(8676002)(8936002)(70586007)(478600001)(6666004)(336012)(426003)(66574015)(7636003)(356005)(26005)(82740400003)(36860700001)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:08.8172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8802d4e-9112-4cfe-0908-08dbcffdeb9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
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

Tm93IHRoYXQgdGhlIGN2cSBjb2RlIGlzIG91dCBvZiBtbHg1X3ZkcGFfY3JlYXRlL2Rlc3Ryb3lf
bXIsIHRoZSAiZHZxIgpmdW5jdGlvbnMgY2FuIGJlIGZvbGRlZCBpbnRvIHRoZWlyIGNhbGxlcnMu
CgpIYXZpbmcgImR2cSIgaW4gdGhlIG5hbWluZyB3aWxsIG5vIGxvbmdlciBiZSBhY2N1cmF0ZSBp
biB0aGUgZG93bnN0cmVhbQpwYXRjaGVzLgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+CkFja2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNv
bT4KU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Ci0t
LQogZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIHwgMTYgKysrKystLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9t
ci5jCmluZGV4IDU4NzMwMGU3YzE4ZS4uZmRlMDA0OTdmNGFkIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3ZkcGEvbWx4NS9jb3JlL21yLmMKKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCkBA
IC00ODksNyArNDg5LDcgQEAgc3RhdGljIHZvaWQgZGVzdHJveV91c2VyX21yKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1seDVfdmRwYV9tciAqbXIKIAl9CiB9CiAKLXN0YXRp
YyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12
ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKK3N0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9t
cihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQogewogCXN0
cnVjdCBtbHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5tcjsKIApAQCAtNTEzLDcgKzUxMyw3IEBA
IHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYsIHVuc2lnbmVkIGludCBhc2lkKQogCiAJbXV0ZXhfbG9jaygmbXItPm1rZXlfbXR4KTsKIAot
CV9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOworCV9tbHg1X3ZkcGFfZGVz
dHJveV9tcihtdmRldiwgYXNpZCk7CiAKIAltdXRleF91bmxvY2soJm1yLT5ta2V5X210eCk7CiB9
CkBAIC01MjQsOSArNTI0LDkgQEAgdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4
NV92ZHBhX2RldiAqbXZkZXYpCiAJcHJ1bmVfaW90bGIobXZkZXYpOwogfQogCi1zdGF0aWMgaW50
IF9tbHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCi0J
CQkJICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCi0JCQkJICAgIHVuc2lnbmVkIGludCBh
c2lkKQorc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYsCisJCQkJc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKKwkJCQl1bnNpZ25lZCBp
bnQgYXNpZCkKIHsKIAlzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7CiAJaW50
IGVycjsKQEAgLTU1MCwxMiArNTUwLDYgQEAgc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9k
dnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAogCXJldHVybiAwOwogfQogCi1zdGF0
aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwK
LQkJCQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLCB1bnNpZ25lZCBpbnQgYXNpZCkKLXsKLQly
ZXR1cm4gX21seDVfdmRwYV9jcmVhdGVfZHZxX21yKG12ZGV2LCBpb3RsYiwgYXNpZCk7Ci19Ci0K
IGludCBtbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3Ry
dWN0IHZob3N0X2lvdGxiICppb3RsYiwKIAkJCXVuc2lnbmVkIGludCBhc2lkKQogewotLSAKMi40
MS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
