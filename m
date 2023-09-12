Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264CDCA0ECA
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 13:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2ABE41BF8;
	Tue, 12 Sep 2023 13:02:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2ABE41BF8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IEtkpbtD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0FIowmiCqyR; Tue, 12 Sep 2023 13:02:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D3D0F41BC4;
	Tue, 12 Sep 2023 13:02:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3D0F41BC4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3411CC0088;
	Tue, 12 Sep 2023 13:02:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39A9FC0088
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 018DA61153
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 018DA61153
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=IEtkpbtD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ev9O7NgxWDu1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::609])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 118ED6114E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 118ED6114E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BssIGCypzc2H2sUzu/04EtXTM9FPgjNuQUGshb+TxWNzcz2Kns40IsEYvm3pZptTisomsQ9Meja2RRWJKIx4iN1+dxW+JawAiROexI5TBjj+5ZLcG49eMGXMklFKPNQhdJ4syh0J9JWXU84n0nWaWos+JGshhwYJ9twFJdyeO2yxI6ZNcwemzxy1K54G+TbU5u2TVVBEE2dx3LkEcGjagry1zvpnEb/l8pX9+rXiHoq1kLpqVlxEcKE29E0OQXp+0eJPrZ35AYb2Qc3rtgoGWdOaiNsditxRxAHeaTeCIcfcSFt8/unQS1KTja2mpJQ0XHl7uEQ8PU+HeNoQ3sKVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=OQBHIX+XQQtuuLQvFwvQu+chfTbbk0oK79VCS9+pwxALqMzN8K+MakuGKv5DWPrBpXUSAmizFvwa+l27DSZkq+aoKUrNw/RzsptItg6oMSHacFYmdc7CxEFvyJ+3Cuw49rQ7s/uaJzNbI7Iye2vUYBm+a3w0U41Qrs28bzdqyeWokCib88AsUjQFoRVXN3KKFDqLUvMUe83czOBdV+xVUocV/Oa47O1mY7+dhkrMc+gjZ4DVOm+TcZnuxiwnJNQrwdXZXMVqmn/cT1w4mX0zD8cbv9HABeYMott5MspOhTuGoYoMDeUpZUlfiGcU1SjiQfTJG/d/qYTxiZuVcgr9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=IEtkpbtD1j2nvab/BD9tyDqoOuOrDOhejgSv/GKfegByGxoW/9F0E1NPONZj+sZ10OZsUWMsZHDbU7NAL3burTVKmZvDw1STTk5x6C8lFGgnbiEBJ76phgBWOcU8yHIECMCtWYYUr/u05NTqN1gF23lQnQ3nTgeYGGzleDCJf+XUiyszCnRwi6hMyJmuNmXjKeyM4WNAd2m77uvpR62YThv6XPhNrGEu8we93sWtUNFMqcnnzrIPcsITFIxvVlbfKHJTZIxsRBTyFMw1FPOJt0D2+baUjvtcaK6pAa+ilQKC+g2dlPYQiyKAw8bqNZPne5Ob+0yUKFnEBljlACIu8A==
Received: from SN6PR01CA0009.prod.exchangelabs.com (2603:10b6:805:b6::22) by
 PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 13:02:11 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::1b) by SN6PR01CA0009.outlook.office365.com
 (2603:10b6:805:b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37 via Frontend
 Transport; Tue, 12 Sep 2023 13:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.16 via Frontend Transport; Tue, 12 Sep 2023 13:02:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 12 Sep 2023
 06:01:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 12 Sep
 2023 06:01:46 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Tue, 12 Sep 2023 06:01:43 -0700
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
 <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 <virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/16] vdpa: introduce dedicated descriptor group for virtqueue
Date: Tue, 12 Sep 2023 16:01:11 +0300
Message-ID: <20230912130132.561193-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912130132.561193-1-dtatulea@nvidia.com>
References: <20230912130132.561193-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b933107-0402-495b-3ed2-08dbb3907a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yn1xPqP3K+26W58MnoyhosSIslV74qx/0pp3opux496KrMGoporXl5+MbMGNT5h59mcUBfwz79SxzJ8Gm3xd934svlx7+tAy5mkHG5w3gw7pK0+SGeK2mL08S1kubg8Peiou1vAKInWADJ8YVUeraZvhMCwvXzq+MYAuCkSx4/t/5EugjiK9wQQLHtQfUFBzuEQyFWTTivM/xELUJGJwNeDYxM+11NYIksWlr6/9MurM/14Tnik3iY8MJ22r4scH9yXvqZ8/s4bhkTZk8LzHLjMMwNVqHJtg2nPTHmwRLCrwngAtFvuiUG3r9Daof7u0OLpPfZZU8APmDlzHe9dBLnoEFE6BlnXHDgoIG5x4Uq/uFNNfVYdHO1GG2LJswywBIGdCZSD1YZKxLaZikwTBbIAOivnjN4bCVZEzUYxAUS1Ipx45MmN0xn5J2gbjttz1ThX5zp3fMt2Ylh05mYjbW/EuOd5BQ0Y7ryIHVi3SMawor5brFhce2/a8KZKCHlavpYFPFINA6tdQzNBBXQ/MIkBOLycvIeon8J+5jSA6cWD38iWqyx4Czi0+FgtfFrLWHD6tPyExsUutNSCAoG7HEXWJwTeBcGEvRdwqJUnZTifBxMlki15c/9E5FeHnMz7cZXj8tKRDbnZvM1QlzBLJvcYiav2z7Y0wUjKkU7IYSb9OfwmulaJMXGxodpeVucTuNhEj1VlqTDzyyvOJBOs6hWQUmMXVS876BxhNpzPZ77IImWL4RjK3P8oKxnq4uTUR
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(7636003)(356005)(82740400003)(36756003)(86362001)(41300700001)(40460700003)(36860700001)(40480700001)(6666004)(478600001)(8936002)(5660300002)(4326008)(8676002)(336012)(2906002)(47076005)(66574015)(110136005)(1076003)(2616005)(70586007)(316002)(426003)(70206006)(83380400001)(26005)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:02:11.4914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b933107-0402-495b-3ed2-08dbb3907a95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org
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

RnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgoKSW4gc29tZSBjYXNlcywg
dGhlIGFjY2VzcyB0byB0aGUgdmlydHF1ZXVlJ3MgZGVzY3JpcHRvciBhcmVhLCBkZXZpY2UKYW5k
IGRyaXZlciBhcmVhcyAocHJlY2x1ZGluZyBpbmRpcmVjdCBkZXNjcmlwdG9yIHRhYmxlIGluIGd1
ZXN0IG1lbW9yeSkKbWF5IGhhdmUgdG8gYmUgY29uZmluZWQgdG8gYSBkaWZmZXJlbnQgYWRkcmVz
cyBzcGFjZSB0aGFuIHdoZXJlIGl0cwpidWZmZXJzIHJlc2lkZS4gV2l0aG91dCBsb3NzIG9mIHNp
bXBsaWNpdHkgYW5kIGdlbmVyYWxpdHkgd2l0aCBhbHJlYWR5CmVzdGFibGlzaGVkIHRlcm1pbm9s
b2d5LCBsZXQncyBmb2xkIHVwIHRoZXNlIDMgYXJlYXMgYW5kIGNhbGwgdGhlbQphcyBhIHdob2xl
IGFzIGRlc2NyaXB0b3IgdGFibGUgZ3JvdXAsIG9yIGRlc2NyaXB0b3IgZ3JvdXAgZm9yIHNob3J0
LgpTcGVjaWZpY2FsbHksIGluIGNhc2Ugb2Ygc3BsaXQgdmlydHF1ZXVlcywgZGVzY3JpcHRvciBn
cm91cCBjb25zaXN0cyBvZgpyZWdpb25zIGZvciBEZXNjcmlwdG9yIFRhYmxlLCBBdmFpbGFibGUg
UmluZyBhbmQgVXNlZCBSaW5nOyBmb3IgcGFja2VkCnZpcnRxdWV1ZXMgbGF5b3V0LCBkZXNjcmlw
dG9yIGdyb3VwIGNvbnRhaW5zIERlc2NyaXB0b3IgUmluZywgRHJpdmVyCmFuZCBEZXZpY2UgRXZl
bnQgU3VwcHJlc3Npb24gc3RydWN0dXJlcy4KClRoZSBncm91cCBJRCBmb3IgYSBkZWRpY2F0ZWQg
ZGVzY3JpcHRvciBncm91cCBjYW4gYmUgb2J0YWluZWQgdGhyb3VnaCBhCm5ldyAuZ2V0X3ZxX2Rl
c2NfZ3JvdXAoKSBvcC4gSWYgZHJpdmVyIGltcGxlbWVudHMgdGhpcyBvcCwgaXQgbWVhbnMgdGhh
dAp0aGUgZGVzY3JpcHRvciwgZGV2aWNlIGFuZCBkcml2ZXIgYXJlYXMgb2YgdGhlIHZpcnRxdWV1
ZSBtYXkgcmVzaWRlCmluIGEgZGVkaWNhdGVkIGdyb3VwIHRoYW4gd2hlcmUgaXRzIGJ1ZmZlcnMg
cmVzaWRlLCBhLmsuYSB0aGUgZGVmYXVsdAp2aXJ0cXVldWUgZ3JvdXAgdGhyb3VnaCB0aGUgLmdl
dF92cV9ncm91cCgpIG9wLgoKSW4gcHJpbmNpcGxlLCB0aGUgZGVzY3JpcHRvciBncm91cCBtYXkg
b3IgbWF5IG5vdCBoYXZlIHNhbWUgZ3JvdXAgSUQKYXMgdGhlIGRlZmF1bHQgZ3JvdXAuIEV2ZW4g
aWYgdGhlIGRlc2NyaXB0b3IgZ3JvdXAgaGFzIGEgZGlmZmVyZW50IElELAptZWFuaW5nIHRoZSB2
cSdzIGRlc2NyaXB0b3IgZ3JvdXAgYXJlYXMgY2FuIG9wdGlvbmFsbHkgbW92ZSB0byBhCnNlcGFy
YXRlIGFkZHJlc3Mgc3BhY2UgdGhhbiB3aGVyZSBndWVzdCBtZW1vcnkgcmVzaWRlcywgdGhlIGRl
c2NyaXB0b3IKZ3JvdXAgbWF5IHN0aWxsIHN0YXJ0IGZyb20gYSBkZWZhdWx0IGFkZHJlc3Mgc3Bh
Y2UsIHNhbWUgYXMgd2hlcmUgaXRzCmJ1ZmZlcnMgcmVzaWRlLiBUbyBtb3ZlIHRoZSBkZXNjcmlw
dG9yIGdyb3VwIHRvIGEgZGlmZmVyZW50IGFkZHJlc3MKc3BhY2UsIC5zZXRfZ3JvdXBfYXNpZCgp
IGhhcyB0byBiZSBjYWxsZWQgdG8gY2hhbmdlIHRoZSBBU0lEIGJpbmRpbmcKZm9yIHRoZSBncm91
cCwgd2hpY2ggaXMgbm8gZGlmZmVyZW50IHRoYW4gd2hhdCBuZWVkcyB0byBiZSBkb25lIG9uIGFu
eQpvdGhlciB2aXJ0cXVldWUgZ3JvdXAuIE9uIHRoZSBvdGhlciBoYW5kLCB0aGUgLnJlc2V0KCkg
c2VtYW50aWNzIGFsc28KYXBwbGllcyBvbiBkZXNjcmlwdG9yIHRhYmxlIGdyb3VwLCBtZWFuaW5n
IHRoZSBkZXZpY2UgcmVzZXQgd2lsbCBjbGVhcgphbGwgQVNJRCBiaW5kaW5ncyBhbmQgbW92ZSBh
bGwgdmlydHF1ZXVlIGdyb3VwcyBpbmNsdWRpbmcgZGVzY3JpcHRvcgpncm91cCBiYWNrIHRvIHRo
ZSBkZWZhdWx0IGFkZHJlc3Mgc3BhY2UsIGkuZS4gaW4gQVNJRCAwLgoKUUVNVSdzIHNoYWRvdyB2
aXJ0cXVldWUgaXMgZ29pbmcgdG8gdXRpbGl6ZSBkZWRpY2F0ZWQgZGVzY3JpcHRvciBncm91cAp0
byBzcGVlZCB1cCBtYXAgYW5kIHVubWFwIG9wZXJhdGlvbnMsIHlpZWxkaW5nIHRyZW1lbmRvdXMg
ZG93bnRpbWUKcmVkdWN0aW9uIGJ5IGF2b2lkaW5nIHRoZSBmdWxsIGFuZCBzbG93IHJlbWFwIGN5
Y2xlIGluIFNWUSBzd2l0Y2hpbmcuCgpTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWku
bGl1QG9yYWNsZS5jb20+CkFja2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0
LmNvbT4KQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Ci0tLQogaW5j
bHVkZS9saW51eC92ZHBhLmggfCAxMSArKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUv
bGludXgvdmRwYS5oCmluZGV4IDBlNjUyMDI2Yjc3Ni4uZDM3NjMwOWI5OWNmIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAorKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaApAQCAtMjA0
LDYgKzIwNCwxNiBAQCBzdHJ1Y3QgdmRwYV9tYXBfZmlsZSB7CiAgKgkJCQlAdmRldjogdmRwYSBk
ZXZpY2UKICAqCQkJCUBpZHg6IHZpcnRxdWV1ZSBpbmRleAogICoJCQkJUmV0dXJucyB1MzI6IGdy
b3VwIGlkIGZvciB0aGlzIHZpcnRxdWV1ZQorICogQGdldF92cV9kZXNjX2dyb3VwOgkJR2V0IHRo
ZSBncm91cCBpZCBmb3IgdGhlIGRlc2NyaXB0b3IgdGFibGUgb2YKKyAqCQkJCWEgc3BlY2lmaWMg
dmlydHF1ZXVlIChvcHRpb25hbCkKKyAqCQkJCUB2ZGV2OiB2ZHBhIGRldmljZQorICoJCQkJQGlk
eDogdmlydHF1ZXVlIGluZGV4CisgKgkJCQlSZXR1cm5zIHUzMjogZ3JvdXAgaWQgZm9yIHRoZSBk
ZXNjcmlwdG9yIHRhYmxlCisgKgkJCQlwb3J0aW9uIG9mIHRoaXMgdmlydHF1ZXVlLiBDb3VsZCBi
ZSBkaWZmZXJlbnQKKyAqCQkJCXRoYW4gdGhlIG9uZSBmcm9tIEBnZXRfdnFfZ3JvdXAsIGluIHdo
aWNoIGNhc2UKKyAqCQkJCXRoZSBhY2Nlc3MgdG8gdGhlIGRlc2NyaXB0b3IgdGFibGUgY2FuIGJl
CisgKgkJCQljb25maW5lZCB0byBhIHNlcGFyYXRlIGFzaWQsIGlzb2xhdGluZyBmcm9tCisgKgkJ
CQl0aGUgdmlydHF1ZXVlJ3MgYnVmZmVyIGFkZHJlc3MgYWNjZXNzLgogICogQGdldF9kZXZpY2Vf
ZmVhdHVyZXM6CUdldCB2aXJ0aW8gZmVhdHVyZXMgc3VwcG9ydGVkIGJ5IHRoZSBkZXZpY2UKICAq
CQkJCUB2ZGV2OiB2ZHBhIGRldmljZQogICoJCQkJUmV0dXJucyB0aGUgdmlydGlvIGZlYXR1cmVz
IHN1cHBvcnQgYnkgdGhlCkBAIC0zNjAsNiArMzcwLDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29w
cyB7CiAJLyogRGV2aWNlIG9wcyAqLwogCXUzMiAoKmdldF92cV9hbGlnbikoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2KTsKIAl1MzIgKCpnZXRfdnFfZ3JvdXApKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdTE2IGlkeCk7CisJdTMyICgqZ2V0X3ZxX2Rlc2NfZ3JvdXApKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTE2IGlkeCk7CiAJdTY0ICgqZ2V0X2RldmljZV9mZWF0dXJlcykoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2KTsKIAl1NjQgKCpnZXRfYmFja2VuZF9mZWF0dXJlcykoY29uc3Qg
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKIAlpbnQgKCpzZXRfZHJpdmVyX2ZlYXR1cmVzKShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcyk7Ci0tIAoyLjQxLjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
