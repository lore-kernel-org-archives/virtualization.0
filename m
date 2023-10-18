Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714F6CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 259AE41933;
	Wed, 18 Oct 2023 17:16:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 259AE41933
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r4gTpt2e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ONLzOeC9qFzh; Wed, 18 Oct 2023 17:16:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D32BA41926;
	Wed, 18 Oct 2023 17:16:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D32BA41926
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC38FC0039;
	Wed, 18 Oct 2023 17:16:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DE6AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCDB082F6F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCDB082F6F
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=r4gTpt2e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QkAPFfKg_Xcp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::620])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D522D82C18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D522D82C18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSBPaGY/xftjUIJl07onKTkDm6UTUIuA22yZ8DKu+QO1fmqB1Z3vs3BhEElbhrrtzo3lLUUpvNTMUNmmcKF351zWv4ULFbD4IcFiDt1jPF+he16SR1FQcyW5LHbMK/4xHri53tJRAPFLRJu+Sz/dqyA52fxJC40sYQ3lbjLeTU02Dygt58XQlwDNCR2LDbNfQuUoqq4c7NwI2U0/DfrFkaPTPNyzVB7Gw1Zz3mT/oaKfyT4sResMn6R7Om+onhU4mEJ20DI7UZHbjNvqhneUmDyK7t7/Ku45ZBBd1lwmA+w/T51TXlCzDessgNUg9wS00/L2KeQvzDwHL+2x61+6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3nj/DFK1Ax7axx5cxRwjydNEVXFy4148fMqcUXwGVE=;
 b=XKWolbvEQhuLIOqx1X0SWef3CQqMCmbkOsFA4RJUDo/cquQd/F2v/SwdF/aHWLwVtZQCvZvMPn209kV6o/7U5BL/y33vczIWbkPvk8k2p5E3XDER7xXq0magLcuHUA3QU1adeRsBUZdo+GY+8X+zSrVNxfO4ymtuRxSl9ndcCSd4xCmI8VqMRBTnPnDZ9zs/ebrxUIjYRJmYEYCiItTSIwmatO9+RDSMH6qD4mgR5069UUEPSniFyOqRN2CqYE8qkJ6m9pbiyiYYKnrRy10kXL5bd+3UXdpenzx3FI4zJRSU4fZG4zsnaKWWbx8wck5B2B+KQAHk1ImTWxcSP9GORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3nj/DFK1Ax7axx5cxRwjydNEVXFy4148fMqcUXwGVE=;
 b=r4gTpt2eHep52rYmbHmxrd78dPF6fpprrJYkrKFhzWnUYNoGqC48PE7WgJgFT88mxBN1HeiG+1seQKW5DACABHTVYluDZwd6ehARqE3wYa3vMpIJeuMVujl28k/39+tUZr140P756CUkrxrQDJEYTb3FhWwtsIHG+4+J+TXEELx7Muyw1ruE/kgsGRuzc/w3R7UZIipzZdbjNCeeZMtpChhGSyBYTLpakEDJMnYdrZlewt7lnnT4vX3FuLU18mz/bBPu6WdAXbE4AA2feTFOL2LeJtfmla9YQTumDngJMT3nHgXnHqC8nlOQ3yZGwX9KDLFci2jd5XNoNtrHDo3wTQ==
Received: from CY5PR22CA0061.namprd22.prod.outlook.com (2603:10b6:930:80::6)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:16:14 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:80:cafe::9f) by CY5PR22CA0061.outlook.office365.com
 (2603:10b6:930:80::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:16:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:16:01 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:59 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 10/16] vdpa/mlx5: Allow creation/deletion of any
 given mr struct
Date: Wed, 18 Oct 2023 20:14:49 +0300
Message-ID: <20231018171456.1624030-12-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c3215f-ec9c-47be-96ca-08dbcffdeed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bqa1HB4gK7K7RtQe1kOBSWjMF9TBCr1uoYaRicI4QGNh8rgpbsYqAeZT7kwCQF0iZwGanaFJtI83e3bmXUWScQ3Kj14V4Sdr/Tsj3DYbyMqLU5o6UYQhU+/em/S4+JD8754qTgSrvRetdhlT5z6dIJ9qM2f2dsrXq4xxJZrgoHVhm78yKGjk+EEVjKnoDEAWq18mpkW4y7RJlEE9lR/Yy57XoLA97/Z8W8++uGEzNPDDplZ9acD4w1f/fnXQpynC3BOi+x1ep86FfULKSa/ruY+z7/s0Esf9FFAILG2Ofqn4y8wq1TdpBtTwJ8fpOPGt6W4jImrEtBp8LGPl6jb2+46+/poPFEQKyDsry6CxFcHBpoLyHr22tDUQZ7T5UhmTtQekSQaDS+ZmaNXInRl0IGJof9HUW0pLAqVgEWlruuwH0Ay8xcdw1/i81CK2BgR7tOQsvm1Yi2cDPyvsrVimwqzXP79kwS46w8lssiEU0IDLw/9wDQ5Q0kfEims2rQwOFn9oJ8120ZrrvzoEL3vBuNrLJH/4mTh3/im3f6vErRs1xTlAfWQ7useT7WXV1qCyjEIrk4kih75qHIrRIgnDSItRrV97rn1ETAq14IuAQg3nUoy1SAUmHPwsU4BpD7clbdTpAJY8F164tj0TtSmICNTPV8XqkD2ySsTPfgfykw7L7dDe0L9Me30Pj85nxKicBdS66ToPdmYo1UVjgomNHlsVh0N81OZzUN464gIg/HQwEn9HMl1zA+teSafSNAPA
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(5660300002)(36860700001)(40460700003)(7636003)(83380400001)(426003)(26005)(36756003)(6666004)(336012)(66574015)(2616005)(86362001)(356005)(47076005)(82740400003)(1076003)(2906002)(41300700001)(110136005)(316002)(478600001)(70206006)(70586007)(8936002)(54906003)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:14.2104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c3215f-ec9c-47be-96ca-08dbcffdeed2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332
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

VGhpcyBwYXRjaCBhZGFwdHMgdGhlIG1yIGNyZWF0aW9uL2RlbGV0aW9uIGNvZGUgdG8gYmUgYWJs
ZSB0byB3b3JrIHdpdGgKYW55IGdpdmVuIG1yIHN0cnVjdCBwb2ludGVyLiBBbGwgdGhlIEFQSXMg
YXJlIGFkYXB0ZWQgdG8gdGFrZSBhbiBleHRyYQpwYXJhbWV0ZXIgZm9yIHRoZSBtci4KCm1seDVf
dmRwYV9jcmVhdGUvZGVsZXRlX21yIGRvZXNuJ3QgbmVlZCBhIEFTSUQgcGFyYW1ldGVyIGFueW1v
cmUuIFRoZQpjaGVjayBpcyBkb25lIGluIHRoZSBjYWxsZXIgaW5zdGVhZCAobWx4NV9zZXRfbWFw
KS4KClRoaXMgY2hhbmdlIGlzIG5lZWRlZCBmb3IgYSBmb2xsb3d1cCBwYXRjaCB3aGljaCB3aWxs
IGludHJvZHVjZSBhbgphZGRpdGlvbmFsIG1yIGZvciB0aGUgdnEgZGVzY3JpcHRvciBkYXRhLgoK
U2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+CkFja2Vk
LWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KQWNrZWQtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy92ZHBhL21seDUvY29yZS9t
bHg1X3ZkcGEuaCB8ICA4ICsrKy0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgICAgICAg
IHwgNTMgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgIHwgMTAgKysrKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlv
bnMoKyksIDM1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCmluZGV4
IGUxZTZlN2FiYTUwZS4uMDFkNGVlNThjY2IxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4
NS9jb3JlL21seDVfdmRwYS5oCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBh
LmgKQEAgLTExNiwxMCArMTE2LDEyIEBAIGludCBtbHg1X3ZkcGFfY3JlYXRlX21rZXkoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1MzIgKm1rZXksIHUzMiAqaW4sCiBpbnQgbWx4NV92ZHBh
X2Rlc3Ryb3lfbWtleShzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHUzMiBta2V5KTsKIGlu
dCBtbHg1X3ZkcGFfaGFuZGxlX3NldF9tYXAoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBz
dHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAogCQkJICAgICBib29sICpjaGFuZ2VfbWFwLCB1bnNp
Z25lZCBpbnQgYXNpZCk7Ci1pbnQgbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCi0JCQl1bnNpZ25lZCBpbnQg
YXNpZCk7CitpbnQgbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYsCisJCQlzdHJ1Y3QgbWx4NV92ZHBhX21yICptciwKKwkJCXN0cnVjdCB2aG9zdF9pb3RsYiAq
aW90bGIpOwogdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcl9yZXNvdXJjZXMoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2KTsKLXZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCk7Cit2b2lkIG1seDVfdmRwYV9kZXN0
cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKKwkJCSAgc3RydWN0IG1seDVfdmRw
YV9tciAqbXIpOwogaW50IG1seDVfdmRwYV91cGRhdGVfY3ZxX2lvdGxiKHN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldiwKIAkJCQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAogCQkJCXVuc2ln
bmVkIGludCBhc2lkKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyBi
L2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwppbmRleCAwMGRjY2UxOTBhMWYuLjZmMjllOGVh
YWJiMSAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCisrKyBiL2RyaXZl
cnMvdmRwYS9tbHg1L2NvcmUvbXIuYwpAQCAtMzAxLDEwICszMDEsMTMgQEAgc3RhdGljIHZvaWQg
dW5tYXBfZGlyZWN0X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1seDVf
dmRwYV9kaXJlY3QKIAlzZ19mcmVlX3RhYmxlKCZtci0+c2dfaGVhZCk7CiB9CiAKLXN0YXRpYyBp
bnQgYWRkX2RpcmVjdF9jaGFpbihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHU2NCBzdGFy
dCwgdTY0IHNpemUsIHU4IHBlcm0sCitzdGF0aWMgaW50IGFkZF9kaXJlY3RfY2hhaW4oc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LAorCQkJICAgIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yLAor
CQkJICAgIHU2NCBzdGFydCwKKwkJCSAgICB1NjQgc2l6ZSwKKwkJCSAgICB1OCBwZXJtLAogCQkJ
ICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCiB7Ci0Jc3RydWN0IG1seDVfdmRwYV9tciAq
bXIgPSAmbXZkZXYtPm1yOwogCXN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0X21yICpkbXI7CiAJc3Ry
dWN0IG1seDVfdmRwYV9kaXJlY3RfbXIgKm47CiAJTElTVF9IRUFEKHRtcCk7CkBAIC0zNTQsOSAr
MzU3LDEwIEBAIHN0YXRpYyBpbnQgYWRkX2RpcmVjdF9jaGFpbihzdHJ1Y3QgbWx4NV92ZHBhX2Rl
diAqbXZkZXYsIHU2NCBzdGFydCwgdTY0IHNpemUsIHU4CiAgKiBpbmRpcmVjdCBtZW1vcnkga2V5
IHRoYXQgcHJvdmlkZXMgYWNjZXNzIHRvIHRoZSBlbml0cmUgYWRkcmVzcyBzcGFjZSBnaXZlbgog
ICogYnkgaW90bGIuCiAgKi8KLXN0YXRpYyBpbnQgY3JlYXRlX3VzZXJfbXIoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiKQorc3RhdGljIGludCBj
cmVhdGVfdXNlcl9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCisJCQkgIHN0cnVjdCBt
bHg1X3ZkcGFfbXIgKm1yLAorCQkJICBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiKQogewotCXN0
cnVjdCBtbHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5tcjsKIAlzdHJ1Y3QgbWx4NV92ZHBhX2Rp
cmVjdF9tciAqZG1yOwogCXN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0X21yICpuOwogCXN0cnVjdCB2
aG9zdF9pb3RsYl9tYXAgKm1hcDsKQEAgLTM4NCw3ICszODgsNyBAQCBzdGF0aWMgaW50IGNyZWF0
ZV91c2VyX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxi
ICppb3RsYgogCQkJCQkJCQkgICAgICAgTE9HX01BWF9LTE1fU0laRSk7CiAJCQkJCW1yLT5udW1f
a2xtcyArPSBubnVsczsKIAkJCQl9Ci0JCQkJZXJyID0gYWRkX2RpcmVjdF9jaGFpbihtdmRldiwg
cHMsIHBlIC0gcHMsIHBwZXJtLCBpb3RsYik7CisJCQkJZXJyID0gYWRkX2RpcmVjdF9jaGFpbiht
dmRldiwgbXIsIHBzLCBwZSAtIHBzLCBwcGVybSwgaW90bGIpOwogCQkJCWlmIChlcnIpCiAJCQkJ
CWdvdG8gZXJyX2NoYWluOwogCQkJfQpAQCAtMzkzLDcgKzM5Nyw3IEBAIHN0YXRpYyBpbnQgY3Jl
YXRlX3VzZXJfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90
bGIgKmlvdGxiCiAJCQlwcGVybSA9IG1hcC0+cGVybTsKIAkJfQogCX0KLQllcnIgPSBhZGRfZGly
ZWN0X2NoYWluKG12ZGV2LCBwcywgcGUgLSBwcywgcHBlcm0sIGlvdGxiKTsKKwllcnIgPSBhZGRf
ZGlyZWN0X2NoYWluKG12ZGV2LCBtciwgcHMsIHBlIC0gcHMsIHBwZXJtLCBpb3RsYik7CiAJaWYg
KGVycikKIAkJZ290byBlcnJfY2hhaW47CiAKQEAgLTQ4OSwxMyArNDkzLDggQEAgc3RhdGljIHZv
aWQgZGVzdHJveV91c2VyX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1s
eDVfdmRwYV9tciAqbXIKIAl9CiB9CiAKLXN0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9t
cihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQorc3RhdGlj
IHZvaWQgX21seDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwg
c3RydWN0IG1seDVfdmRwYV9tciAqbXIpCiB7Ci0Jc3RydWN0IG1seDVfdmRwYV9tciAqbXIgPSAm
bXZkZXYtPm1yOwotCi0JaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JP
VVBdICE9IGFzaWQpCi0JCXJldHVybjsKLQogCWlmICghbXItPmluaXRpYWxpemVkKQogCQlyZXR1
cm47CiAKQEAgLTUwNywzOCArNTA2LDMzIEBAIHN0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJv
eV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkCiAJbXIt
PmluaXRpYWxpemVkID0gZmFsc2U7CiB9CiAKLXZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKK3ZvaWQgbWx4NV92
ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAorCQkJICBzdHJ1Y3Qg
bWx4NV92ZHBhX21yICptcikKIHsKLQlzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+
bXI7Ci0KIAltdXRleF9sb2NrKCZtci0+bWtleV9tdHgpOwogCi0JX21seDVfdmRwYV9kZXN0cm95
X21yKG12ZGV2LCBhc2lkKTsKKwlfbWx4NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsIG1yKTsKIAog
CW11dGV4X3VubG9jaygmbXItPm1rZXlfbXR4KTsKIH0KIAogdm9pZCBtbHg1X3ZkcGFfZGVzdHJv
eV9tcl9yZXNvdXJjZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQogewotCW1seDVfdmRw
YV9kZXN0cm95X21yKG12ZGV2LCBtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dS
T1VQXSk7CisJbWx4NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsICZtdmRldi0+bXIpOwogCXBydW5l
X2lvdGxiKG12ZGV2KTsKIH0KIAogc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCi0JCQkJc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwK
LQkJCQl1bnNpZ25lZCBpbnQgYXNpZCkKKwkJCQlzdHJ1Y3QgbWx4NV92ZHBhX21yICptciwKKwkJ
CQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiKQogewotCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1y
ID0gJm12ZGV2LT5tcjsKIAlpbnQgZXJyOwogCi0JaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVf
VkRQQV9EQVRBVlFfR1JPVVBdICE9IGFzaWQpCi0JCXJldHVybiAwOwotCiAJaWYgKG1yLT5pbml0
aWFsaXplZCkKIAkJcmV0dXJuIDA7CiAKIAlpZiAoaW90bGIpCi0JCWVyciA9IGNyZWF0ZV91c2Vy
X21yKG12ZGV2LCBpb3RsYik7CisJCWVyciA9IGNyZWF0ZV91c2VyX21yKG12ZGV2LCBtciwgaW90
bGIpOwogCWVsc2UKIAkJZXJyID0gY3JlYXRlX2RtYV9tcihtdmRldiwgbXIpOwogCkBAIC01NTAs
MTMgKzU0NCwxNCBAQCBzdGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldiwKIAlyZXR1cm4gMDsKIH0KIAotaW50IG1seDVfdmRwYV9jcmVhdGVf
bXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxi
LAotCQkJdW5zaWduZWQgaW50IGFzaWQpCitpbnQgbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3Qg
bWx4NV92ZHBhX2RldiAqbXZkZXYsCisJCQlzdHJ1Y3QgbWx4NV92ZHBhX21yICptciwKKwkJCXN0
cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCiB7CiAJaW50IGVycjsKIAogCW11dGV4X2xvY2soJm12
ZGV2LT5tci5ta2V5X210eCk7Ci0JZXJyID0gX21seDVfdmRwYV9jcmVhdGVfbXIobXZkZXYsIGlv
dGxiLCBhc2lkKTsKKwllcnIgPSBfbWx4NV92ZHBhX2NyZWF0ZV9tcihtdmRldiwgbXIsIGlvdGxi
KTsKIAltdXRleF91bmxvY2soJm12ZGV2LT5tci5ta2V5X210eCk7CiAJcmV0dXJuIGVycjsKIH0K
QEAgLTU3NCw3ICs1NjksNyBAQCBpbnQgbWx4NV92ZHBhX2hhbmRsZV9zZXRfbWFwKHN0cnVjdCBt
bHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppbwogCQkqY2hhbmdlX21h
cCA9IHRydWU7CiAJfQogCWlmICghKmNoYW5nZV9tYXApCi0JCWVyciA9IF9tbHg1X3ZkcGFfY3Jl
YXRlX21yKG12ZGV2LCBpb3RsYiwgYXNpZCk7CisJCWVyciA9IF9tbHg1X3ZkcGFfY3JlYXRlX21y
KG12ZGV2LCBtciwgaW90bGIpOwogCW11dGV4X3VubG9jaygmbXItPm1rZXlfbXR4KTsKIAogCXJl
dHVybiBlcnI7CkBAIC02MDMsNyArNTk4LDcgQEAgaW50IG1seDVfdmRwYV9jcmVhdGVfZG1hX21y
KHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKIHsKIAlpbnQgZXJyOwogCi0JZXJyID0gbWx4
NV92ZHBhX2NyZWF0ZV9tcihtdmRldiwgTlVMTCwgMCk7CisJZXJyID0gbWx4NV92ZHBhX2NyZWF0
ZV9tcihtdmRldiwgJm12ZGV2LT5tciwgTlVMTCk7CiAJaWYgKGVycikKIAkJcmV0dXJuIGVycjsK
IApkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCmluZGV4IGFiMTk2YzQzNjk0Yy4uMjU2ZmRkODBj
MzIxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKKysrIGIv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCkBAIC0yNjQ0LDggKzI2NDQsOCBAQCBz
dGF0aWMgaW50IG1seDVfdmRwYV9jaGFuZ2VfbWFwKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diwKIAkJZ290byBlcnJfbXI7CiAKIAl0ZWFyZG93bl9kcml2ZXIobmRldik7Ci0JbWx4NV92ZHBh
X2Rlc3Ryb3lfbXIobXZkZXYsIGFzaWQpOwotCWVyciA9IG1seDVfdmRwYV9jcmVhdGVfbXIobXZk
ZXYsIGlvdGxiLCBhc2lkKTsKKwltbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldiwgJm12ZGV2LT5t
cik7CisJZXJyID0gbWx4NV92ZHBhX2NyZWF0ZV9tcihtdmRldiwgJm12ZGV2LT5tciwgaW90bGIp
OwogCWlmIChlcnIpCiAJCWdvdG8gZXJyX21yOwogCkBAIC0yNjYwLDcgKzI2NjAsNyBAQCBzdGF0
aWMgaW50IG1seDVfdmRwYV9jaGFuZ2VfbWFwKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwK
IAlyZXR1cm4gMDsKIAogZXJyX3NldHVwOgotCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2LCBh
c2lkKTsKKwltbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldiwgJm12ZGV2LT5tcik7CiBlcnJfbXI6
CiAJcmV0dXJuIGVycjsKIH0KQEAgLTI4NzgsNiArMjg3OCw5IEBAIHN0YXRpYyBpbnQgc2V0X21h
cF9kYXRhKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICpp
b3RsYiwKIAlib29sIGNoYW5nZV9tYXA7CiAJaW50IGVycjsKIAorCWlmIChtdmRldi0+Z3JvdXAy
YXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dST1VQXSAhPSBhc2lkKQorCQlnb3RvIGVuZDsKKwogCWVy
ciA9IG1seDVfdmRwYV9oYW5kbGVfc2V0X21hcChtdmRldiwgaW90bGIsICZjaGFuZ2VfbWFwLCBh
c2lkKTsKIAlpZiAoZXJyKSB7CiAJCW1seDVfdmRwYV93YXJuKG12ZGV2LCAic2V0IG1hcCBmYWls
ZWQoJWQpXG4iLCBlcnIpOwpAQCAtMjg5MCw2ICsyODkzLDcgQEAgc3RhdGljIGludCBzZXRfbWFw
X2RhdGEoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlv
dGxiLAogCQkJcmV0dXJuIGVycjsKIAl9CiAKK2VuZDoKIAlyZXR1cm4gbWx4NV92ZHBhX3VwZGF0
ZV9jdnFfaW90bGIobXZkZXYsIGlvdGxiLCBhc2lkKTsKIH0KIAotLSAKMi40MS4wCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
