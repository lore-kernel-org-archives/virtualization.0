Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B16E95A8E
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B86C881FDE;
	Mon,  9 Oct 2023 11:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B86C881FDE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SKc/HR0s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VyVLp1UmN9Fo; Mon,  9 Oct 2023 11:25:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 07E9981FFE;
	Mon,  9 Oct 2023 11:25:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07E9981FFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8B63C0039;
	Mon,  9 Oct 2023 11:25:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C60A4C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ABC841563
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9ABC841563
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=SKc/HR0s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id caScF84RjbaW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C76B4151D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C76B4151D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwRzzl9e3x/DsEkNLZsnsg0ch8BoX/Xkq5LZ+2Yf9A6IRaiT7MazD1WyRLPD4fEITHvl5NwBRF1LzdeDlQhCV8OWYhq24Sff4E0gjq5wu8GIFnmZE9rYMwTVM2p0xhc4mXhi4Gzb1CcY4KxOLxJMGBWBoqr7b06PHhVC7EAUVa86J0SfHmG5T92rR5c9iyO6D/ah0hQCYfz939zoUrM5Gwf7FH0aZbEEo0WhHVQuLmpUr/oxUBga2EkBd/PFN+kBiLyrEjOczl0xBQzGAhAlahQAzgn61k+DgTMU81y+liugAgsBmgSr0SbMWFJo4/uOhRr3En9CvMKj4elkiYBPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elzKdMTRh3uezwMcgzMejLd/DLpkMeh3g8HOvOAJXm0=;
 b=CADQCMUvdAHA6k4i+WBpyBb3HNUjtoUUH+VcgT9nrSUkzmh6bRsbrxZg9+K765nwrVekj2J5Gy0nlr8PHSyo1WFm8JwWGlZHi1QnjCvktgvxTg2oMhMTsbjfLkNc08sadZmZ6f+YTvOoI08E/6U/MzbwhGr1XeL8ucu8RI6/C+QSyyY503+hcMdM+iGGkgT7awUQ0GOZJz/zUJbOMkvVc7kdVvpVrAwCgS7TblfdkI7O2Aapq1tQ1KcuM4tm4k9vX1zLlllVA8L9apDScW5A2Qjj7rXOUg45HS+NpecDOsWMsDIQN6tDWqfQS09CPiXUcwSwUu0p/ivCH5EwzUjbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elzKdMTRh3uezwMcgzMejLd/DLpkMeh3g8HOvOAJXm0=;
 b=SKc/HR0sXMjPZysXJmI1igcxXatIknchiKwM1tdoApypoZDT+uKDvjw9hTdPsVfZRXo7OTqlDfHatmEspB6iU8cc4xI+Yk4hnF2YcYaq6sfvEVS1baN40zV78Gks2iDL4jZGxc8nX0fLd16Vxt4dEYm2CCA/rg6ctiArzOElWXQaIjWhuVCp4QcbwMFxspRjnaX5Af3xVjdH+xe/31R4h+8WfPoVvpWBsTjE0AKI/Zjy7nzDnMmWY4pRA/LvNPRc87/wf6Ix9fz3+gTb7scoxCdZPmqRPi6Q4PON0VQTjsQCg/pkzciaKOJ4fTXbtoTdfyK82dfxpaOxK7wD/SI3Mw==
Received: from PH8PR20CA0012.namprd20.prod.outlook.com (2603:10b6:510:23c::10)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 11:25:05 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::29) by PH8PR20CA0012.outlook.office365.com
 (2603:10b6:510:23c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.33 via Frontend
 Transport; Mon, 9 Oct 2023 11:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 11:25:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:47 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:44 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 08/16] vdpa/mlx5: Collapse "dvq" mr add/delete
 functions
Date: Mon, 9 Oct 2023 14:23:53 +0300
Message-ID: <20231009112401.1060447-9-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM6PR12MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: d6397982-5a08-453b-e820-08dbc8ba61ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2OOseJi8bJ46Ttdkw32Pd8G39naxrrlMCs3lb+5AOnx3J+fVVtyov1gP1lajmWz0HaEYKp6qMylIlLa8RK4uOOayoAqUiOIgG9SX1VrjP8yrPtRI8mMOtxuhxsLrYn6CEvp+Ar4vzFOo8kuKvee8b+dy4vKdoExaZ07XMT6trm2yPr4Y9XCjMi9m9DkRXRT+lJCPjT3VyGhFsvCdGKFq56E3HFLAc37RScBR5kkSUeTdFeHIltZXQUEi14SrtEW15e3TkNY9XFIVG8q6ptaeYP04Yznnu5+plTukGUtlkqt3dmJ0pvCRbIbxuc/ZH8CGLiSSVhpl6J7suPjCX448p+DV1eB5ya9Fzeq6ldblEzSDnvWdLwzLZ11b1ODZEQSg0C4foOaalAa9w2MbjC3Ay4fLZMtUFafsDP3FTc2cVcps70FG8RuKpjEceDYD0ePZauJiGL/ynfS6KraOaCOtSeVRBQADudk+vVwC/IzikQi6f9Bi3+agBMQ1uM2b2RDk+ZPgNDBd/MEV2VWGBbSJ3LZzvkk4plE//IN8lJ6L4XRnVLbBEWMA9QQHMO7ABpa7BbLa/VObm+tVbTVthGblfkUx9qXOzjf1ndK5QNq4Poa6JF/L+T6Ar1aXtStVmCtE+GCm5xsokgpoQaAPJTiIF90S0TjZGqQtQQPn2fe5EuseR6HnG6N4NbOJb1WDfWN9WLO8k1hCcTdwa7bxA0+S4J1c/En/77lJlZy8npS0j3DPpYQI6P/UL1rLtuRU/2x
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(1076003)(2616005)(336012)(426003)(26005)(47076005)(66574015)(36860700001)(54906003)(70206006)(70586007)(110136005)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6666004)(2906002)(478600001)(82740400003)(36756003)(356005)(7636003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:25:02.9975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6397982-5a08-453b-e820-08dbc8ba61ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
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
