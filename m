Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEECEE95A9A
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9879F812B9;
	Mon,  9 Oct 2023 11:24:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9879F812B9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ruk9IJ3X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id enopAFFdOjlH; Mon,  9 Oct 2023 11:24:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D2D7B80EB2;
	Mon,  9 Oct 2023 11:24:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2D7B80EB2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF557C0039;
	Mon,  9 Oct 2023 11:24:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 863B4C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5420080E97
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5420080E97
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YpOemK_q48OJ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4094480E43
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4094480E43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmqBsOoDIBN9/lWK3UIKJ9G3hU1UlrErXZ6Ollo6Z4vWRsUHEq/NwBlPEL6dJ9lZAVZpR9HwM906XqEgWviyA7MEFEHo9hPM7J7QvTjcdbJLg/RP3zYXXIygc033us8HU0j14tHJgJ7YNvkRrIysd3bqThW5jQvKbjW3pquu+Kar61HzbjHj8xyF8ouSC9ozLFfn7b0+A8oSGh4+NMakfZKdWR3csyQg1g+c+MAIER0QEMHx7C5+Q74pOSIIqKb38hsUhAa/1LVGAky3VxQbA0yGk7RScgoPyXgdrgkYikOt/dFcAEyDSPSL3oXppu9z6X1kFDa2LOMY0M/1t0A8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=asC15CuIXX2TeKTj2uWytYbbmz+lsej6MQRE+zA6aF0fsItboxs6ljNcxdJPBKnxTJAPJxHAvwdGhweePm5BAd73IpKbpFEjhafi2uj02v8WVI/fkhEMPfKVAMNIm6wiKPqSkZKRmpbIZ3pPgil2BTt93uGpa3rYlPosp7UeNAqCNpAsOIvau3c+iQtVYEXxpcwBmuDqt95VfY0rht/2xTAS19VaWmG/IPN+pMTnEOFB/HOtxDyS+VqAf/jCSnnIVgAOpEhPiDWaqgS7ygAsm+o7VFxPw6CcfopmCaAbCIvQDS+8zIxDigwPdmzW2dxdU7j9dk+yDPgFOoyT6KJoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=ruk9IJ3Xl+QhzUEeutHga6vrxIq8WHa6nZIOW7/zF1B9xiABiMmp1IxHmxRVug7YTKFC/gBSM0cIYjSaopJ0RuXHS9a/8jvr4NIjuive+lRpKQBgnfIG9F5Te4FgwaLp92MVxvyviu+fH48RzJwjSWNIUWxWVR06AWeRevG/mwxIxU/xoO3h6CdU4fhgR0/z6zq2/nPHzs/qS7UJzIURoy1dJ5X4R0Azlx+iXBMEqk9dfJzvY7hR1WzAPi+tQXKqCrkOKGQapLCrt9JBBUr2Qfy++Gl2kEQ3f5Fpwd72bAcsu++FpXENMHOedeSVbiSRXjJhv7Ax3aX3gESf8TSFiw==
Received: from PR0P264CA0241.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::13) by
 CH2PR12MB5002.namprd12.prod.outlook.com (2603:10b6:610:6d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Mon, 9 Oct 2023 11:24:47 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10a6:100:0:cafe::9f) by PR0P264CA0241.outlook.office365.com
 (2603:10a6:100::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 11:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 11:24:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:25 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:22 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 02/16] vdpa: introduce dedicated descriptor group for
 virtqueue
Date: Mon, 9 Oct 2023 14:23:47 +0300
Message-ID: <20231009112401.1060447-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CH2PR12MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6402e1-76f9-4edf-0852-08dbc8ba57a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bahy9pqa1braQgeWptccs3LXAFRXcM17+sab8gAv06vD4tF29BiKAGy23hQtjeidD9K7KCnlSGEk8234wfoCYFLggT5UA0lPpvkPXHK3LkzvOOcDzeWO59ovjWalxnmH6IfkcPPegKtZeq9thIozZ8OAd6JpSvFgfkq4sDMf7yQ2ebpczNWGkyK8iYG4HMqPvscoXspX5u4vT9bRP78i6o+HWZnN5AMhE04zpxg+B9hUTeYYqeiWfYlb9lkFpHKBuUPc6CbTkA43/aMzDCFlBGFzX+J0K+RNzIcCLufdmd8UFW7OguIlpWBXtW0LMAkQ0HXDITSKZZKw38OM02YpzdvK9+CLHISOoUa4pwyUUVSl0hcF1CXK+qCngtotypYRpck0NslzRRKIJA+qiufjWqoqGlCtnXgonp2jsSjYlyFutVq6ql0aX1j5uQ4YgXlX3pvP4c3/oOS1R0jL19lAP/nG3l3lZOS1gX2Vyv0XMqzl1yhO51Kz27pYLNoFomoal0dpn66dfMZEb7jWrLhhVSA3sxJl3BPuliv9Fr5HZ+6LkQ3CJa6uC6TD8dSy6Uru9SNe5ic0qKW0PII5E3Cbx49Bu8tqlYCRc+jBmDU6xuDJHwj8vCat5LP/prYAPATYvArF/vHgSPhwwSuD4bsGD+73qAbszAzcsIK8Tg1EaH/bo9m/O+rBwP6o6EdKyegOpEYGCN26CJr3ofocBpMPmhOF6Oroz36NnXVoukyyrG9Yi3pFgWY6HNzgJvkaEzdH
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(1076003)(426003)(26005)(336012)(40460700003)(40480700001)(36756003)(86362001)(82740400003)(7636003)(356005)(83380400001)(8676002)(4326008)(2906002)(8936002)(6666004)(478600001)(47076005)(36860700001)(66574015)(41300700001)(5660300002)(316002)(54906003)(70586007)(70206006)(110136005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:24:46.1712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6402e1-76f9-4edf-0852-08dbc8ba57a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5002
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
