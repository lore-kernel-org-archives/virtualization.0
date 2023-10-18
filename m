Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27E1CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A23BF40AF0;
	Wed, 18 Oct 2023 17:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A23BF40AF0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UH6KZI1l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cSUhxPBVikQw; Wed, 18 Oct 2023 17:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A25A840199;
	Wed, 18 Oct 2023 17:16:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A25A840199
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9F2CC0DD2;
	Wed, 18 Oct 2023 17:16:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDDF7C008D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABE4682F20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABE4682F20
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=UH6KZI1l
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhnDSMm4EIaw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::60e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A95DD82CCA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A95DD82CCA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzURwtcjCtj1tUS6jQQu2UZP/rQ/wgpFf1LES2ttIrN9GmB2/GDYFPq9MIrhIVZdCAEdSptw/Xy4Y6Rq6fanGcuhGNL8ZI6yHyZdU4/u0/8NUrATJ0FoEtNENbgQ56Ujkm7IlYD93PsMnEOVUExhsu60bqy1TpLmm+5E2hCysGg1DH9eCJChNZUZoj7Daj7rPkf6qcl+QEK1s6s8EUjOemvEyNxnO+TQZbU50qa9P6otVZhHUCOXF6nqvTsJAPE43vi8mSE8Dxq9kv5GP4FZ/BPqF4FZoPeKzReFvNV4FjjR9WWyr/WBIq7thZKgm8pnU4g4kWjKZwOTiwiq9HRInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YoDCHkpinOQBJC5OCWVs0dAVcWKDrjzxMHgzD+IBkE=;
 b=Re14IwBhCgykmzyR/e15rc46LVMzxobHssDfxI19/UAd0LMN0sm9TacX6KFxPH62OW01VwA0qTdnR+sKjl6sYbe27ydWvbApIe2i6Cdzt57/8sdZ3WTYAIPEgt2rkqcG6kG94qnIK2fjzsPmQcDcevHRtwCBvl86NYKFqIy9S9kVpjb20cmBsP+4e2OwX03IQgsmQ1VYqnU4t/vbl0spxE5agQiwEufcDsBy9SlnTxEZG5gjxGohNgrqf6Ei6hcgPD5mv4D6AKE6XJpRXcxngk8I6Pv5MmgeZUF/boBIjcc3IWABq77M31UXCl+awLri73vCro+TBkN9OavEpLl9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YoDCHkpinOQBJC5OCWVs0dAVcWKDrjzxMHgzD+IBkE=;
 b=UH6KZI1lHQerFcNa3JFP4358BSC5d6yAE+g47gVmFRkrn/pP1iUfONZY3MKd1rUTt+vdqKUgfWPPhnPM538bgQDHRcjCU5mG3MUCYMWiWvFBFlLzTnpp3PjADPwZqIctqR2OcNLQt1enUwtU0b4+bI9U825ncyTPHEZ169NhHzI/iQVAYuMKLw9np9SuOQLmeP5HCWr6bMiWO5E9aTj90WwEoByNqsDe9bcfPg3ARQ30LHwoPpnIS54cwI7Cdi6KZL2jhx0G6sscfbpSdqgCmDmqknJv1LknVeV9msDONPooOo9nme3sgYX2op2n5tOLEPKW8BbMb23eCSVnlonqRw==
Received: from CH2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:610:4f::37)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:16:03 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::25) by CH2PR18CA0027.outlook.office365.com
 (2603:10b6:610:4f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:16:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:47 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:45 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 06/16] vdpa/mlx5: Decouple cvq iotlb handling from hw
 mapping code
Date: Wed, 18 Oct 2023 20:14:45 +0300
Message-ID: <20231018171456.1624030-8-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9bba6b-8a41-4a77-cc05-08dbcffde81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcV/TNpo/gH9Z+tYGkZqWWveR137wA09QBnUA7PxMbr7/XaD5EHfWUqyWfqRFSAnqZH3O+aL/M75MyQem0Y4IEh1ZTXgfKyvuK0hxZooFrBdS2IHI37ebr6xhbyDEbyMrsoqPFn+XpF/WMA0tPvGGRY8dECS1o9j8xiibT3L3tLr85QnSaaIttU8OfCjehhFQO2itmHqD3G7ktblIG6p5B+BNmIwKyEPpbvTbuR+LbtZ9nVW6GXToOEBsmiEU2jDTjUt1kmk10xnUg8WrgJiIY2zxj5FrvW9ypLQreZtHzzmlMWTAbY8l3cd/cMYGIUIBHIsKiHcutqdOowSMsxIjEPFHUtEDaRNja5TODGfBoQh7HH3DwIo55w8LDzJM6ocapcMxNXnjPZF32NHUWd0dwI+gEV1Br0HaycKYgHwVg14J5Tz0s1l7nzJJAuQOJdn5xILAnkPUARHqZzBDaScM0KMPao26t87SgpIEq5V6flpSsk8kCzB+rCqP61LefjpOfJgC/V/BOu5B/I2UoFV3Qez+gCnFW6mUcw8WRWm8NM6k5YiSuXzBKJufiktDFVamVN4jWNtolvIF02Itir9Ssv2ZBopUh762569ETE/E3rLXESCktIY80uwQ5mCRYt77TxU0zx0TwkB4f2K2MZ85SRNLmnQMoUf7FlXlwTeesPQId1FQ5MBD5zuvizRt01MtzRVpETek7gRF3aJISReaZLumxzoyR3q9eMvgXQPryk=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(54906003)(478600001)(70586007)(70206006)(110136005)(82740400003)(47076005)(86362001)(316002)(5660300002)(8676002)(1076003)(8936002)(66574015)(426003)(26005)(336012)(2616005)(4326008)(40460700003)(40480700001)(2906002)(83380400001)(36756003)(36860700001)(7636003)(356005)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:02.9189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9bba6b-8a41-4a77-cc05-08dbcffde81e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
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
