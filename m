Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6943DE732F4
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 16:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E7C941BC7;
	Thu, 28 Sep 2023 16:50:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E7C941BC7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Lgtsk/BS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tnPlPoR-tknv; Thu, 28 Sep 2023 16:50:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3052441BB5;
	Thu, 28 Sep 2023 16:50:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3052441BB5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1B81C0071;
	Thu, 28 Sep 2023 16:50:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47383C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1735F8343F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1735F8343F
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Lgtsk/BS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EmdD8WG1YfgJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 235EB82F32
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 235EB82F32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwQXQlBTiFxwVkAgE+XtiEpQRYwspaBbRPvoumGu6u2UENjPBnqhF8tH4EcNu4XnbusOxOR6tITy7gDUB50LyPmR+hekA/zc5wie0NPsY1qKPYyrD8fxzm04L55fdOGjsW8urkEUyauTObBEGKR53EIxg8fGGRm2VzTg046vYju7MTX9ouFi7KNVliu/KcdGo/5IUFzYERxd+n6Q9e4tUA5uAzDngNx7vmKQzJwJrebpjiBmhaNYoMy2cZ4lYmY5MpKfi6zuvoiw/bx5uIR4l4XTUGIHTSxgGy/JhBNotx72hGPFrGJO1OwtXD+eFkZ6iiQIvoEMXxfTVr7aYeYWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnJQ5tPt3zRoEBpIfXlFPOb7QvzypqNGxupaS7vWJDc=;
 b=kSmKSsBorHuX8gV+MRk5Nzk6n2Xak+xuiffHEnvh38JRStl7hDg5WRbvoHu0YVG5yaVxdO4CoYg5ztUvoYvIbL/2PA7MEKzwTk94tT5qV3KSraBHzmpJ95Wn8hiEc6GRafBlJ+b8sAYY6FdQuvPfmkrJX4d7LEsFARfinb90FLOMiM1rVZWVcJSmOS+gIZR4B+n2crjRHuTBeN2+hsSi3puS/ekfCzldaobaCWCWoMq5BulNHUyQYxKMWHShaTygKlwLWaSu/scuzUngdMs39i0EgSU8ROShiDzCq9XLQrS1RVOjryz5nxgtMWGS8Ha+n3I4btiEgkcIKjFJslvLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnJQ5tPt3zRoEBpIfXlFPOb7QvzypqNGxupaS7vWJDc=;
 b=Lgtsk/BSTQpGh1geAwyXe/ipNtYrlgXhWQDXY1hDDJFB7qQ/LGHrUvMUAnGh4cb1xteTzx1aErl59mkTxHLVmwdG+vTKd28RHRF/Anfqs/TkcHkT9D/girZe5gGPOOMVFt48NWKiYAeOJiY322tY0XSg5QOlR4G9k+hUipKsZYdHqb73Z2uJk1FgZ0eaSBISeIB7CInj9hwddrUhA++UNWx7nUBcQ9d5BAQwHporcw3ueScWD/UymA52dyDxuTKeiryrVCp9nlq45hs24Toy+POJ+cRl14jjtdkY5XloqBaQcSiCKiXXjcQ+W5I4xBdfyk1LHv+toPYV0PVK6rxmlA==
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 16:49:59 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::d3) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:49:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:46 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:44 -0700
To: <eperezma@redhat.com>, <gal@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: [PATCH vhost 07/16] vdpa/mlx5: Take cvq iotlb lock during refresh
Date: Thu, 28 Sep 2023 19:45:18 +0300
Message-ID: <20230928164550.980832-9-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ea5f04-db78-4564-ceaf-08dbc042f3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaZ8iRDNrNMysAHH2DSBaK2oVPK/yeQPunLj9MybVEOqzfxuqqhNzzO7QacTJEcOV3/OFzwERfrZSu8cAPTYq9pZuo1lyr3fh7GJ0Ol/PuyprrPDP8EnqW683a6xAiUn6cNIojUVfBeWpNNgMK7JQsTY+TvmrNZDwqo7gE4otx1bluj8Ms4orGgqN3Ps3JljMk6YXdHiuuZySeRD11HXpiWd/wOBFx6KEOeCwbpc0oFohESihouMDkzSPpotFLs6abLS2/V0OAiX4tvIgMZJyHDi2Xrijk5QCZoMOBhRrWoNvewQr0HcpZAGYIC9WSr0Ym/iybpSOIcbghWHtdr4OMQmHo76lGqqYv42OXvYJJHikVQU0zbdjxGgQOR6IyRQDre1AJnduSkEV28rFy/S/mFmt/9npE6cNyhzptAdFKuxMST9WkuDJsmeAb6Rs+naF2tehTITwyHyQzoHfA+mxNN+afdP318rKSk60BJ8PPAojUMRnXiLj1NjXjG0in13niWG2/v2u4Byf0zxURXkWK7Bg4cmwqBnG9u2u4EvPc9gc1uaUWYTpOUK7zdykGN+V2GfZv5wi615VbOQa6xY57eL5MBIK8gPWvRZCWB7qcpcxjE6qEbpfOdBytonK9+FpjnKH8EI9ne6e0hTdavItyrf/0rIHBbNpR6hUjcL4mFByiph2rYVDjCPtSFpd6+Onoll6DUUABj1Lgn+/6nEMSLpGf5aDa3qwi0mgUK/Hsaxtxq/dTEwSYMZjhiEMvzdLC2jgjuFrfE4VqkPYaQU538FubY+h7qZBbjQGyJDhnc=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(83380400001)(2616005)(478600001)(36860700001)(86362001)(36756003)(356005)(7636003)(82740400003)(40480700001)(336012)(26005)(66574015)(2906002)(47076005)(110136005)(966005)(6666004)(40460700003)(1076003)(4326008)(8936002)(8676002)(5660300002)(426003)(41300700001)(316002)(70206006)(54906003)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:59.5426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ea5f04-db78-4564-ceaf-08dbc042f3f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

VGhlIHJlc2xvY2sgaXMgdGFrZW4gd2hpbGUgcmVmcmVzaCBpcyBjYWxsZWQgYnV0IGlvbW11X2xv
Y2sgaXMgbW9yZQpzcGVjaWZpYyB0byB0aGlzIHJlc291cmNlLiBTbyB0YWtlIHRoZSBpb21tdV9s
b2NrIGR1cmluZyBjdnEgaW90bGIKcmVmcmVzaC4KCkJhc2VkIG9uIEV1Z2VuaW8ncyBwYXRjaCBb
MF0uCgpbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDExMjE0MjIxOC43MjU2
MjItNC1lcGVyZXptYUByZWRoYXQuY29tLwoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+ClN1Z2dlc3RlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+ClNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29t
PgotLS0KIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyB8IDEwICsrKysrKysrKy0KIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMK
aW5kZXggZmNiNmFlMzJlOWVkLi41ODczMDBlN2MxOGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbXIuYworKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMKQEAgLTU5
MCwxMSArNTkwLDE5IEBAIGludCBtbHg1X3ZkcGFfdXBkYXRlX2N2cV9pb3RsYihzdHJ1Y3QgbWx4
NV92ZHBhX2RldiAqbXZkZXYsCiAJCQkJc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKIAkJCQl1
bnNpZ25lZCBpbnQgYXNpZCkKIHsKKwlpbnQgZXJyOworCiAJaWYgKG12ZGV2LT5ncm91cDJhc2lk
W01MWDVfVkRQQV9DVlFfR1JPVVBdICE9IGFzaWQpCiAJCXJldHVybiAwOwogCisJc3Bpbl9sb2Nr
KCZtdmRldi0+Y3ZxLmlvbW11X2xvY2spOworCiAJcHJ1bmVfaW90bGIobXZkZXYpOwotCXJldHVy
biBkdXBfaW90bGIobXZkZXYsIGlvdGxiKTsKKwllcnIgPSBkdXBfaW90bGIobXZkZXYsIGlvdGxi
KTsKKworCXNwaW5fdW5sb2NrKCZtdmRldi0+Y3ZxLmlvbW11X2xvY2spOworCisJcmV0dXJuIGVy
cjsKIH0KIAogaW50IG1seDVfdmRwYV9jcmVhdGVfZG1hX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldikKLS0gCjIuNDEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
