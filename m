Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46950E95A91
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED740814B6;
	Mon,  9 Oct 2023 11:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED740814B6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tg1Mf7Ln
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iwYVQHEO_47V; Mon,  9 Oct 2023 11:25:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F1A682011;
	Mon,  9 Oct 2023 11:25:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F1A682011
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A9A0C0DD6;
	Mon,  9 Oct 2023 11:25:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BC46C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAF44414E4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAF44414E4
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=tg1Mf7Ln
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8HFqkk0X-c_q
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::620])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A577B4154D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A577B4154D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyp5TFienEIZqvGWFen12OZuinkxfhojYBRmaa8/0DPe//9GCyHHOjb36qGAZBN9Zo/7yFm6wFzP3M6TPYaQeXWhz63pKzw1iCTzuCL5UZIt04ToKp1AWTzNKBfKpvQoeYY7Ag6PsZGoHPfdqqrb9sKItt0qy0G30vKWbyrv0VQWMaZ0Hs5mdpEwGarFEqvFF+c4I6KH2UMGm9xASati7HMgyutTlBvLFfsEQvZ/H6WumjYDmmDAQnW/AbxA2URH/xLGS9LImOBcknHx7mhdEaIXyts7rAS0M61ENSShBu9yQqM1pAQpLfphyIjQuXsCQKaIhZyqTsFMk48tcJ7+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ARPpe47gz+MA73Ix9lUbLmF/6h5J92rUxRFMm3wXHY=;
 b=UZRJrijkEOmYcqDuyHVWkDCm/riTTFu6tvESkCYbef5kw9Drdi0KkLl0Miiq0VOVAIKMBPmyWvw4KPsP8QvD91Rw5bHt/DxF6ePAwzYpYCZ1oRuV9BFxxrg6AOKsz7S+Tho2TqpSfr2P4ZswBxUwl2OEAWG3KhzhfvE73PUJN3GjCIYNZd8rZHOglwLAb7dBn9xzjyFiy6vmT/NmsSUqeTQlNhu0CRXuYX8n1jYW7cydtLsxGNBXnHEezSktrrTA0RgD3b5vMjRmoGM2LMqYz8aXaPNoBmEpyCDYBsHde9JpnBg5Q/IumcNTblAmSyLCsre/vG1VwKXrxfcOE7RiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ARPpe47gz+MA73Ix9lUbLmF/6h5J92rUxRFMm3wXHY=;
 b=tg1Mf7LnrCcUXBAu3lg51wxvMZckyUe5eF/GemL/r++l3g9eu7QnWD7WU1j8GpBNj5g4LVaJ4Eq8f+wGlnPMsAqslsOPF0os7AUKoqLBOje9LlEIlGY0/mKorbsb5PsX8wXe54gdEBFW4jMYEC4kG2hSo4MmLshGaZTyu+yQvmeYiOU8NVtdHT4VBmzqdpQDtbrmcK5esT3CptlWTbOXXcfYe5Ek5sqQXGKc3oNDVU/+ZCBNZ91yQnVwjs5oLjI0by6vfmeWlfapLWLtLk8YSzsSxyLLQjzhs8+VFHZpEPZiXRF5DbxAEDff8+bP/Q+3AyU9wGgczyEyNr7aDYJTlA==
Received: from SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::16)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 11:25:08 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::69) by SA9P223CA0011.outlook.office365.com
 (2603:10b6:806:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 11:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 11:25:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:54 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:54 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:51 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 10/16] vdpa/mlx5: Allow creation/deletion of any
 given mr struct
Date: Mon, 9 Oct 2023 14:23:55 +0300
Message-ID: <20231009112401.1060447-11-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c70b86e-1fbb-4796-78c2-08dbc8ba6485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cao5gRHOxoh98YTvA4BlZno6sG9qTIB+Ue6j09rpNtSgXfXfaeckcuEGIkhjdfcfKuDJxRFg8I7tTVx1CadBvbPRkBUglqfCicXT9hXT75k0PZXheWns506Jqqj4+NATT5K8Hp3WylQhUasRMkB809RnBby6IYckGtwzaZAc/j7v760qLXW7iHGnjsokQetcp/csT6yBV2oAKAldvrzHIzZrOqZLFLuUdRRn6KEx2OsT8W+giJ29R0HYPnn389G9VaiPCUB2oHpPrNILYD0JCkh6NBol89PFBjSowcr8paAdIKr+JFra4aXmEwX8WlBM5a6shZ617djfi3x2bg4eaJMs9YEvJXJoMnIN3NKq1/qz25revD97Rum3/8Sd6Jym3gilB1YlZz2mFgPL5WoYEuEiKJ8MHANzuAPUm5RjSr+w5/p18srprUjSDgx5mI9QYY8pKhPYpFnRzKSlWb8YZcy0v5i1REe6TZVLh4TZw2jvimFHnpA45YpkGLYscJLwcfeiQPzFtkwJwmJ3RUrDvuw0kgABib0+vGdY5kJqTVyCqTPmusRekc5rh2p7xjO01vGMeZhx6JBJFhLIp2dsMMzcPrR0rPuAHYVhZp+RwHo2stdJcq4rWPsNXl9QCro7mEw3JVWR9STt/MN5iBd564kKc4AtNvse0n2/vMVoqod6nfSNyXy301jM87MRzQVeq4Sg4TYAgO+2rm609enub1b1X1nmD+ryTg/SqMsDlssIyc/ZzLXjeZ70+6vONFwC
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(1076003)(2616005)(426003)(336012)(26005)(36860700001)(8676002)(478600001)(66574015)(47076005)(8936002)(83380400001)(2906002)(4326008)(110136005)(54906003)(70206006)(70586007)(41300700001)(316002)(40460700003)(7636003)(356005)(36756003)(82740400003)(40480700001)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:25:07.7591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c70b86e-1fbb-4796-78c2-08dbc8ba6485
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
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
LWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL3Zk
cGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIHwgIDggKysrLS0KIGRyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbXIuYyAgICAgICAgfCA1MyArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIGRyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCAxMCArKysrLS0KIDMgZmlsZXMgY2hhbmdl
ZCwgMzYgaW5zZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4
NV92ZHBhLmgKaW5kZXggZTFlNmU3YWJhNTBlLi4wMWQ0ZWU1OGNjYjEgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKKysrIGIvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tbHg1X3ZkcGEuaApAQCAtMTE2LDEwICsxMTYsMTIgQEAgaW50IG1seDVfdmRwYV9jcmVh
dGVfbWtleShzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHUzMiAqbWtleSwgdTMyICppbiwK
IGludCBtbHg1X3ZkcGFfZGVzdHJveV9ta2V5KHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwg
dTMyIG1rZXkpOwogaW50IG1seDVfdmRwYV9oYW5kbGVfc2V0X21hcChzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCiAJCQkgICAgIGJvb2wgKmNo
YW5nZV9tYXAsIHVuc2lnbmVkIGludCBhc2lkKTsKLWludCBtbHg1X3ZkcGFfY3JlYXRlX21yKHN0
cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKLQkJ
CXVuc2lnbmVkIGludCBhc2lkKTsKK2ludCBtbHg1X3ZkcGFfY3JlYXRlX21yKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldiwKKwkJCXN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yLAorCQkJc3RydWN0
IHZob3N0X2lvdGxiICppb3RsYik7CiB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yX3Jlc291cmNl
cyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpOwotdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9t
cihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKTsKK3ZvaWQg
bWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAorCQkJICBz
dHJ1Y3QgbWx4NV92ZHBhX21yICptcik7CiBpbnQgbWx4NV92ZHBhX3VwZGF0ZV9jdnFfaW90bGIo
c3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAogCQkJCXN0cnVjdCB2aG9zdF9pb3RsYiAqaW90
bGIsCiAJCQkJdW5zaWduZWQgaW50IGFzaWQpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21s
eDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCmluZGV4IDAwZGNjZTE5
MGExZi4uNmYyOWU4ZWFhYmIxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21y
LmMKKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCkBAIC0zMDEsMTAgKzMwMSwxMyBA
QCBzdGF0aWMgdm9pZCB1bm1hcF9kaXJlY3RfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2
LCBzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdAogCXNnX2ZyZWVfdGFibGUoJm1yLT5zZ19oZWFkKTsK
IH0KIAotc3RhdGljIGludCBhZGRfZGlyZWN0X2NoYWluKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICpt
dmRldiwgdTY0IHN0YXJ0LCB1NjQgc2l6ZSwgdTggcGVybSwKK3N0YXRpYyBpbnQgYWRkX2RpcmVj
dF9jaGFpbihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCisJCQkgICAgc3RydWN0IG1seDVf
dmRwYV9tciAqbXIsCisJCQkgICAgdTY0IHN0YXJ0LAorCQkJICAgIHU2NCBzaXplLAorCQkJICAg
IHU4IHBlcm0sCiAJCQkgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYikKIHsKLQlzdHJ1Y3Qg
bWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7CiAJc3RydWN0IG1seDVfdmRwYV9kaXJlY3Rf
bXIgKmRtcjsKIAlzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdF9tciAqbjsKIAlMSVNUX0hFQUQodG1w
KTsKQEAgLTM1NCw5ICszNTcsMTAgQEAgc3RhdGljIGludCBhZGRfZGlyZWN0X2NoYWluKHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTY0IHN0YXJ0LCB1NjQgc2l6ZSwgdTgKICAqIGluZGly
ZWN0IG1lbW9yeSBrZXkgdGhhdCBwcm92aWRlcyBhY2Nlc3MgdG8gdGhlIGVuaXRyZSBhZGRyZXNz
IHNwYWNlIGdpdmVuCiAgKiBieSBpb3RsYi4KICAqLwotc3RhdGljIGludCBjcmVhdGVfdXNlcl9t
cihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIp
CitzdGF0aWMgaW50IGNyZWF0ZV91c2VyX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwK
KwkJCSAgc3RydWN0IG1seDVfdmRwYV9tciAqbXIsCisJCQkgIHN0cnVjdCB2aG9zdF9pb3RsYiAq
aW90bGIpCiB7Ci0Jc3RydWN0IG1seDVfdmRwYV9tciAqbXIgPSAmbXZkZXYtPm1yOwogCXN0cnVj
dCBtbHg1X3ZkcGFfZGlyZWN0X21yICpkbXI7CiAJc3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIg
Km47CiAJc3RydWN0IHZob3N0X2lvdGxiX21hcCAqbWFwOwpAQCAtMzg0LDcgKzM4OCw3IEBAIHN0
YXRpYyBpbnQgY3JlYXRlX3VzZXJfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1
Y3Qgdmhvc3RfaW90bGIgKmlvdGxiCiAJCQkJCQkJCSAgICAgICBMT0dfTUFYX0tMTV9TSVpFKTsK
IAkJCQkJbXItPm51bV9rbG1zICs9IG5udWxzOwogCQkJCX0KLQkJCQllcnIgPSBhZGRfZGlyZWN0
X2NoYWluKG12ZGV2LCBwcywgcGUgLSBwcywgcHBlcm0sIGlvdGxiKTsKKwkJCQllcnIgPSBhZGRf
ZGlyZWN0X2NoYWluKG12ZGV2LCBtciwgcHMsIHBlIC0gcHMsIHBwZXJtLCBpb3RsYik7CiAJCQkJ
aWYgKGVycikKIAkJCQkJZ290byBlcnJfY2hhaW47CiAJCQl9CkBAIC0zOTMsNyArMzk3LDcgQEAg
c3RhdGljIGludCBjcmVhdGVfdXNlcl9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0
cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIKIAkJCXBwZXJtID0gbWFwLT5wZXJtOwogCQl9CiAJfQot
CWVyciA9IGFkZF9kaXJlY3RfY2hhaW4obXZkZXYsIHBzLCBwZSAtIHBzLCBwcGVybSwgaW90bGIp
OworCWVyciA9IGFkZF9kaXJlY3RfY2hhaW4obXZkZXYsIG1yLCBwcywgcGUgLSBwcywgcHBlcm0s
IGlvdGxiKTsKIAlpZiAoZXJyKQogCQlnb3RvIGVycl9jaGFpbjsKIApAQCAtNDg5LDEzICs0OTMs
OCBAQCBzdGF0aWMgdm9pZCBkZXN0cm95X3VzZXJfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12
ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX21yICptcgogCX0KIH0KIAotc3RhdGljIHZvaWQgX21seDVf
dmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50
IGFzaWQpCitzdGF0aWMgdm9pZCBfbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX21yICptcikKIHsKLQlzdHJ1Y3QgbWx4NV92
ZHBhX21yICptciA9ICZtdmRldi0+bXI7Ci0KLQlpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9W
RFBBX0RBVEFWUV9HUk9VUF0gIT0gYXNpZCkKLQkJcmV0dXJuOwotCiAJaWYgKCFtci0+aW5pdGlh
bGl6ZWQpCiAJCXJldHVybjsKIApAQCAtNTA3LDM4ICs1MDYsMzMgQEAgc3RhdGljIHZvaWQgX21s
eDVfdmRwYV9kZXN0cm95X21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQg
aW50IGFzaWQKIAltci0+aW5pdGlhbGl6ZWQgPSBmYWxzZTsKIH0KIAotdm9pZCBtbHg1X3ZkcGFf
ZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lk
KQordm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYs
CisJCQkgIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yKQogewotCXN0cnVjdCBtbHg1X3ZkcGFfbXIg
Km1yID0gJm12ZGV2LT5tcjsKLQogCW11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7CiAKLQlfbWx4
NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsIGFzaWQpOworCV9tbHg1X3ZkcGFfZGVzdHJveV9tciht
dmRldiwgbXIpOwogCiAJbXV0ZXhfdW5sb2NrKCZtci0+bWtleV9tdHgpOwogfQogCiB2b2lkIG1s
eDVfdmRwYV9kZXN0cm95X21yX3Jlc291cmNlcyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYp
CiB7Ci0JbWx4NV92ZHBhX2Rlc3Ryb3lfbXIobXZkZXYsIG12ZGV2LT5ncm91cDJhc2lkW01MWDVf
VkRQQV9EQVRBVlFfR1JPVVBdKTsKKwltbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldiwgJm12ZGV2
LT5tcik7CiAJcHJ1bmVfaW90bGIobXZkZXYpOwogfQogCiBzdGF0aWMgaW50IF9tbHg1X3ZkcGFf
Y3JlYXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKLQkJCQlzdHJ1Y3Qgdmhvc3Rf
aW90bGIgKmlvdGxiLAotCQkJCXVuc2lnbmVkIGludCBhc2lkKQorCQkJCXN0cnVjdCBtbHg1X3Zk
cGFfbXIgKm1yLAorCQkJCXN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCiB7Ci0Jc3RydWN0IG1s
eDVfdmRwYV9tciAqbXIgPSAmbXZkZXYtPm1yOwogCWludCBlcnI7CiAKLQlpZiAobXZkZXYtPmdy
b3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9VUF0gIT0gYXNpZCkKLQkJcmV0dXJuIDA7Ci0K
IAlpZiAobXItPmluaXRpYWxpemVkKQogCQlyZXR1cm4gMDsKIAogCWlmIChpb3RsYikKLQkJZXJy
ID0gY3JlYXRlX3VzZXJfbXIobXZkZXYsIGlvdGxiKTsKKwkJZXJyID0gY3JlYXRlX3VzZXJfbXIo
bXZkZXYsIG1yLCBpb3RsYik7CiAJZWxzZQogCQllcnIgPSBjcmVhdGVfZG1hX21yKG12ZGV2LCBt
cik7CiAKQEAgLTU1MCwxMyArNTQ0LDE0IEBAIHN0YXRpYyBpbnQgX21seDVfdmRwYV9jcmVhdGVf
bXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAogCXJldHVybiAwOwogfQogCi1pbnQgbWx4
NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2aG9z
dF9pb3RsYiAqaW90bGIsCi0JCQl1bnNpZ25lZCBpbnQgYXNpZCkKK2ludCBtbHg1X3ZkcGFfY3Jl
YXRlX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKKwkJCXN0cnVjdCBtbHg1X3ZkcGFf
bXIgKm1yLAorCQkJc3RydWN0IHZob3N0X2lvdGxiICppb3RsYikKIHsKIAlpbnQgZXJyOwogCiAJ
bXV0ZXhfbG9jaygmbXZkZXYtPm1yLm1rZXlfbXR4KTsKLQllcnIgPSBfbWx4NV92ZHBhX2NyZWF0
ZV9tcihtdmRldiwgaW90bGIsIGFzaWQpOworCWVyciA9IF9tbHg1X3ZkcGFfY3JlYXRlX21yKG12
ZGV2LCBtciwgaW90bGIpOwogCW11dGV4X3VubG9jaygmbXZkZXYtPm1yLm1rZXlfbXR4KTsKIAly
ZXR1cm4gZXJyOwogfQpAQCAtNTc0LDcgKzU2OSw3IEBAIGludCBtbHg1X3ZkcGFfaGFuZGxlX3Nl
dF9tYXAoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlv
CiAJCSpjaGFuZ2VfbWFwID0gdHJ1ZTsKIAl9CiAJaWYgKCEqY2hhbmdlX21hcCkKLQkJZXJyID0g
X21seDVfdmRwYV9jcmVhdGVfbXIobXZkZXYsIGlvdGxiLCBhc2lkKTsKKwkJZXJyID0gX21seDVf
dmRwYV9jcmVhdGVfbXIobXZkZXYsIG1yLCBpb3RsYik7CiAJbXV0ZXhfdW5sb2NrKCZtci0+bWtl
eV9tdHgpOwogCiAJcmV0dXJuIGVycjsKQEAgLTYwMyw3ICs1OTgsNyBAQCBpbnQgbWx4NV92ZHBh
X2NyZWF0ZV9kbWFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQogewogCWludCBlcnI7
CiAKLQllcnIgPSBtbHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCBOVUxMLCAwKTsKKwllcnIgPSBt
bHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCAmbXZkZXYtPm1yLCBOVUxMKTsKIAlpZiAoZXJyKQog
CQlyZXR1cm4gZXJyOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKaW5kZXggYWIxOTZjNDM2
OTRjLi4yNTZmZGQ4MGMzMjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYworKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKQEAgLTI2NDQs
OCArMjY0NCw4IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2NoYW5nZV9tYXAoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2LAogCQlnb3RvIGVycl9tcjsKIAogCXRlYXJkb3duX2RyaXZlcihuZGV2
KTsKLQltbHg1X3ZkcGFfZGVzdHJveV9tcihtdmRldiwgYXNpZCk7Ci0JZXJyID0gbWx4NV92ZHBh
X2NyZWF0ZV9tcihtdmRldiwgaW90bGIsIGFzaWQpOworCW1seDVfdmRwYV9kZXN0cm95X21yKG12
ZGV2LCAmbXZkZXYtPm1yKTsKKwllcnIgPSBtbHg1X3ZkcGFfY3JlYXRlX21yKG12ZGV2LCAmbXZk
ZXYtPm1yLCBpb3RsYik7CiAJaWYgKGVycikKIAkJZ290byBlcnJfbXI7CiAKQEAgLTI2NjAsNyAr
MjY2MCw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2NoYW5nZV9tYXAoc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2LAogCXJldHVybiAwOwogCiBlcnJfc2V0dXA6Ci0JbWx4NV92ZHBhX2Rlc3Ry
b3lfbXIobXZkZXYsIGFzaWQpOworCW1seDVfdmRwYV9kZXN0cm95X21yKG12ZGV2LCAmbXZkZXYt
Pm1yKTsKIGVycl9tcjoKIAlyZXR1cm4gZXJyOwogfQpAQCAtMjg3OCw2ICsyODc4LDkgQEAgc3Rh
dGljIGludCBzZXRfbWFwX2RhdGEoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCBzdHJ1Y3Qg
dmhvc3RfaW90bGIgKmlvdGxiLAogCWJvb2wgY2hhbmdlX21hcDsKIAlpbnQgZXJyOwogCisJaWYg
KG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBdICE9IGFzaWQpCisJCWdv
dG8gZW5kOworCiAJZXJyID0gbWx4NV92ZHBhX2hhbmRsZV9zZXRfbWFwKG12ZGV2LCBpb3RsYiwg
JmNoYW5nZV9tYXAsIGFzaWQpOwogCWlmIChlcnIpIHsKIAkJbWx4NV92ZHBhX3dhcm4obXZkZXYs
ICJzZXQgbWFwIGZhaWxlZCglZClcbiIsIGVycik7CkBAIC0yODkwLDYgKzI4OTMsNyBAQCBzdGF0
aWMgaW50IHNldF9tYXBfZGF0YShzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHN0cnVjdCB2
aG9zdF9pb3RsYiAqaW90bGIsCiAJCQlyZXR1cm4gZXJyOwogCX0KIAorZW5kOgogCXJldHVybiBt
bHg1X3ZkcGFfdXBkYXRlX2N2cV9pb3RsYihtdmRldiwgaW90bGIsIGFzaWQpOwogfQogCi0tIAoy
LjQxLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
