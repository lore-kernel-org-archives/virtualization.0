Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231EFE95A96
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 991D941781;
	Mon,  9 Oct 2023 11:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 991D941781
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Eg+YMQuD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YcxrqeVDmA06; Mon,  9 Oct 2023 11:25:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 935514095C;
	Mon,  9 Oct 2023 11:25:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 935514095C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CD5CC0039;
	Mon,  9 Oct 2023 11:25:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF65BC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95AB68203C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95AB68203C
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Eg+YMQuD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ntC_WU30Udg3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4D5F81585
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4D5F81585
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bowwe30t+StjCjy5iQfi4XfLyXhV7dVudffAvh57eHsmxaraCxOB3SsPOSyaBqNyaXMs2Ng7BlSRfnClgT8e9glXOL6X2o4+8MaGOBRS/upFkUGt2GmJ4BVU8OvklErup+9RIwTBmfrqiixPzXSfN+3hSfwSJf6demJsiKSLMwzel9xP0o8M23E1wTbDo9+rm0fh1Dwr+xmoomHVwEn7ixamQGHMnkVRqc4FcyZNeKt3d+ljoN8m5Qaz7jN/nr5kp8DJSuIFQpTFX9c0B+tFK6MHE6yJzyid+s7lGIMPxFzotiBCOtwzWHfndD6pvvyH66W6VEG+yTyoXGUUqj/ArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+I3U15Hi59woTFRPbH5j837sff+uPVTo/I0JiXr6qk=;
 b=kunyezStVwuYQHX8GEXZFRmh3bgpDBHVjzU19X35Wg5TrJdBN/FkN7gKERs+rJcIFvvn2GF/kZWPAr1kAoCs06vDoT8rtgBYWS98Kn6NkEbTgudYEq/iMXjoJ+zyZYbWv3SacrRAZhGeJGxqtQGsQa8G/4j6O7VzAunM/Q8EOgNVVfQYYu6tQg5TCR/L37Tekci96IcePIZpUBF/C29LSupj/8vkdkxGzL//9k7ZLtNuxVoC1aWr1LszExCxF0p+IiPXqrORc/m61QF6DSeg13pUlcJ47kPEiZGI69bSEwAqvlYdUgwFCZdQ2IqRrgNWQSxjEaFtLwo4U8VwcDxiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+I3U15Hi59woTFRPbH5j837sff+uPVTo/I0JiXr6qk=;
 b=Eg+YMQuD97q+R3+Aia9ooJavyDI4h66sZc/nWTPgl6WUNl75srEaA8tJlfdFGKc5wdITrVRgV5UAyms8Xp4LkdnQev4UqG6iw7Q0PO4v5SgcNUZdMrfuf/VeY5mGfqiOVeHyFJz60du9e5rFXKr7TdqdGWGu46ioVbRscBcYxQN24c7yYcf7bskF/OnOGB98Z63sCBv9YHmxTabm1DWj0X+bTizAQ7ZWL2KPpgJz5bHRTkdlx4S62egZ+MkAFckY3LVo88Z7tXRp+8h7xo/ZpLaTBNYUkpb2GSpU9wIpW6BpEhVWoGAGFj/vrdrURIJrcvtzkqogOLO02UAsdquNlg==
Received: from BL1PR13CA0375.namprd13.prod.outlook.com (2603:10b6:208:2c0::20)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 11:25:31 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::19) by BL1PR13CA0375.outlook.office365.com
 (2603:10b6:208:2c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 11:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.18 via Frontend Transport; Mon, 9 Oct 2023 11:25:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:25:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:25:12 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:25:09 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 15/16] vdpa/mlx5: Make iotlb helper functions more
 generic
Date: Mon, 9 Oct 2023 14:24:00 +0300
Message-ID: <20231009112401.1060447-16-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|BL1PR12MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf27568-5830-40c9-de08-08dbc8ba724b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLn3o87QY/dkPzvhaJhBJJ+BOIi5zul4S3GDgvyqeI7oUsTOqJ1RWELdfyUcvf30iP/DHeHjBG9IYvHv/5Jf8MO5blBE/VfFlrZTXwkQNhRuH0enhwyqsADxK1otLRDjsBJ5ZtNwoByi0KDN4q4lXZev1cvnccfJ6NmBmm276JBjDyI5mZMzdZ9cD3fNQ/NpNGswgq0ViJqYenFthbPFoV17G55RZEqQjESjQLhEir7ok0T/Dz8kZ+Y5AZsqrefETEAvGodv8zMtqvT5KwcgZsXtJBm3+kHGZ94TJdHkYn0mb28RLS0wi0GzLnCZA8Psnw/FeuMcl+u3Q24LrsiQnMfnHhEKZZsLh+kzMB50vNoxMq4vhb+vz6ihF60dcxOhlkUPQBCSOF6Uw73N0+Yo/m1NjuYMtefz3mxICX7EaXoM1fYunUdhgOm9N6ak7430/4BIsUbD0L/+zCs7MvJJO5rR+BwH0CZAty9ygTauVMCXNVdCBY3D5hGd3IYQ5qYgmmaeiuZ0AyIlaHdwRU26gd/cnpIkmk+yIExcJIabY5PiaxvjvtCs/SQ3livk/sA2qkmjjXQyw9pS2IOABispJsruyH0A+4cV0kOuACq1NQTwtlM+7YmGNMFizWiJ/WyLtqTcnKpxZCv0WymfMjrtRuk4NE0Ses9h9s4PRo2j8LCXCP2A3/t1CjqT6XwOFROBmpbXA25PGHjdraPbgvioKHHRWw/NVU7uh06IDGPUsbw4tmkwIrxWKht+26KFDtk4WEkJDApImWG2gUhz3CBLUw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(7636003)(356005)(86362001)(36756003)(40460700003)(40480700001)(2906002)(478600001)(82740400003)(5660300002)(4326008)(8936002)(8676002)(41300700001)(6666004)(83380400001)(426003)(336012)(2616005)(1076003)(36860700001)(110136005)(70586007)(70206006)(54906003)(316002)(26005)(47076005)(66574015)(41533002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:25:30.7916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf27568-5830-40c9-de08-08dbc8ba724b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
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
dm9pZCB0aGUgc3JjID09IGRzdCBjYXNlLiBUaGlzIGlzIGFuIGVycm9yLgoKQWNrZWQtYnk6IEV1
Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBEcmFnb3Mg
VGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KLS0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3Jl
L21yLmMgfCAxOSArKysrKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL21yLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKaW5kZXggM2RlZTZkOWJlZDZi
Li40YTNkZjg2NWRmNDAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwor
KysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKQEAgLTQ1NCwyMCArNDU0LDIzIEBAIHN0
YXRpYyB2b2lkIGRlc3Ryb3lfZG1hX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3Ry
dWN0IG1seDVfdmRwYV9tciAqbXIpCiAJbWx4NV92ZHBhX2Rlc3Ryb3lfbWtleShtdmRldiwgbXIt
Pm1rZXkpOwogfQogCi1zdGF0aWMgaW50IGR1cF9pb3RsYihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAqc3JjKQorc3RhdGljIGludCBkdXBfaW90bGIoc3Ry
dWN0IHZob3N0X2lvdGxiICpkc3QsIHN0cnVjdCB2aG9zdF9pb3RsYiAqc3JjKQogewogCXN0cnVj
dCB2aG9zdF9pb3RsYl9tYXAgKm1hcDsKIAl1NjQgc3RhcnQgPSAwLCBsYXN0ID0gVUxMT05HX01B
WDsKIAlpbnQgZXJyOwogCisJaWYgKGRzdCA9PSBzcmMpCisJCXJldHVybiAtRUlOVkFMOworCiAJ
aWYgKCFzcmMpIHsKLQkJZXJyID0gdmhvc3RfaW90bGJfYWRkX3JhbmdlKG12ZGV2LT5jdnEuaW90
bGIsIHN0YXJ0LCBsYXN0LCBzdGFydCwgVkhPU1RfQUNDRVNTX1JXKTsKKwkJZXJyID0gdmhvc3Rf
aW90bGJfYWRkX3JhbmdlKGRzdCwgc3RhcnQsIGxhc3QsIHN0YXJ0LCBWSE9TVF9BQ0NFU1NfUlcp
OwogCQlyZXR1cm4gZXJyOwogCX0KIAogCWZvciAobWFwID0gdmhvc3RfaW90bGJfaXRyZWVfZmly
c3Qoc3JjLCBzdGFydCwgbGFzdCk7IG1hcDsKIAkJbWFwID0gdmhvc3RfaW90bGJfaXRyZWVfbmV4
dChtYXAsIHN0YXJ0LCBsYXN0KSkgewotCQllcnIgPSB2aG9zdF9pb3RsYl9hZGRfcmFuZ2UobXZk
ZXYtPmN2cS5pb3RsYiwgbWFwLT5zdGFydCwgbWFwLT5sYXN0LAorCQllcnIgPSB2aG9zdF9pb3Rs
Yl9hZGRfcmFuZ2UoZHN0LCBtYXAtPnN0YXJ0LCBtYXAtPmxhc3QsCiAJCQkJCSAgICBtYXAtPmFk
ZHIsIG1hcC0+cGVybSk7CiAJCWlmIChlcnIpCiAJCQlyZXR1cm4gZXJyOwpAQCAtNDc1LDkgKzQ3
OCw5IEBAIHN0YXRpYyBpbnQgZHVwX2lvdGxiKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwg
c3RydWN0IHZob3N0X2lvdGxiICpzcmMpCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyB2b2lkIHBy
dW5lX2lvdGxiKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKK3N0YXRpYyB2b2lkIHBydW5l
X2lvdGxiKHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCiB7Ci0Jdmhvc3RfaW90bGJfZGVsX3Jh
bmdlKG12ZGV2LT5jdnEuaW90bGIsIDAsIFVMTE9OR19NQVgpOworCXZob3N0X2lvdGxiX2RlbF9y
YW5nZShpb3RsYiwgMCwgVUxMT05HX01BWCk7CiB9CiAKIHN0YXRpYyB2b2lkIGRlc3Ryb3lfdXNl
cl9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1y
KQpAQCAtNTQ0LDcgKzU0Nyw3IEBAIHZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfcmVzb3VyY2Vz
KHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKIAlmb3IgKGludCBpID0gMDsgaSA8IE1MWDVf
VkRQQV9OVU1fQVM7IGkrKykKIAkJbWx4NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsIG12ZGV2LT5t
cltpXSk7CiAKLQlwcnVuZV9pb3RsYihtdmRldik7CisJcHJ1bmVfaW90bGIobXZkZXYtPmN2cS5p
b3RsYik7CiB9CiAKIHN0YXRpYyBpbnQgX21seDVfdmRwYV9jcmVhdGVfbXIoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LApAQCAtNTk2LDggKzU5OSw4IEBAIGludCBtbHg1X3ZkcGFfdXBkYXRl
X2N2cV9pb3RsYihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCiAKIAlzcGluX2xvY2soJm12
ZGV2LT5jdnEuaW9tbXVfbG9jayk7CiAKLQlwcnVuZV9pb3RsYihtdmRldik7Ci0JZXJyID0gZHVw
X2lvdGxiKG12ZGV2LCBpb3RsYik7CisJcHJ1bmVfaW90bGIobXZkZXYtPmN2cS5pb3RsYik7CisJ
ZXJyID0gZHVwX2lvdGxiKG12ZGV2LT5jdnEuaW90bGIsIGlvdGxiKTsKIAogCXNwaW5fdW5sb2Nr
KCZtdmRldi0+Y3ZxLmlvbW11X2xvY2spOwogCi0tIAoyLjQxLjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
