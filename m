Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4063DE732EA
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 16:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC01161197;
	Thu, 28 Sep 2023 16:49:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC01161197
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Tu7V1LR0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fq_rcZizHbKF; Thu, 28 Sep 2023 16:49:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 37D7760B4C;
	Thu, 28 Sep 2023 16:49:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37D7760B4C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E953BC0DD2;
	Thu, 28 Sep 2023 16:49:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8943C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B28EF428E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B28EF428E8
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Tu7V1LR0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4RuhVXN15zfA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A688428A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A688428A5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDSIES7u2eQBZmpcDACVTbq6Ad8YqUj2GX9K/N2pPiqhOgU1arflO5FkFlubop2YVbX5fcvcfSOxjg9Z8S7bNu7qnOPgeKZ89Pr+iceiLmZ9seIqQhofnuu3Aj7IXo/h2rBz6J3eAfw9NEpxm2vC1y0/+J5JMdC6ulR1aX9Eo/99UrkEfL5Y/PhDmfnhby8IGUWT20pHhoD5N48i09tbP6IZGDuBGQgdIxsqSi1nlqtJErMLxYLtT9GA0Q0XH64tvD9Iwrp4w1zOKQzLBX/dn7WUG6Ff8RK9uBHvrVX41BdU+QHGXaL3XrwCf4b1j7pOJTAZpreI4mdxr+NkK8RbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=Ksw1+PGEvR/xzuOYZuiO4owASpDRcbnJJqXayB6TlSQCN227jsveLc3mJH/Nu7Qw7xy4NSPnFB3XsWjF1uB2XrYhLLOVLA3sw1oC6j8keeJ3VSa5fuHfQZbCwhEdovIsG29qZrqn+AoMmwMWjjmaE64YASZkrU7nDySXD/RlUePvrmXVC+vpYoLKGWp2C1hQKTMNp4kPuaadb+nkTqBklQ7G7RfSDchGFObN5jhHFbLtcUmWMnL2+KWt9EzjMtiFqZv5LEX4R1dmgfHP3KhUKexjU0BDlHtSvHSW0aYq+0mu99gCE3Zo/4Rem7bfcShr9/wvZnhJGcyXvbXk4q7chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=Tu7V1LR0tp/7qvW+VaL73wYbd2BHqNvVm/1XJc15u+JkXOG4YVrl5VOwe7mO71MmNpkGrnF/cZ0z7x553emgbnITrYOzBnhPscXFxk3Vju+hwIiknHrhjuC0z84JXniGJCLAqW/rera0CcTaOGASSM8HBAF6PpgUjGeXU7/V3lE+mUe0cwfijZvvzYzPYg/t2Kt7Dj+oirDZi3EYkZv87RTWmfNy9liFHy3aP4lwQOQhWLVynbA5BOd93skJKWVsjz1PGl81cgGnc4XVkWgrc+RcS9eHK3d0/kj73Q6jZWhtewhORpjTRUrcEOD6FuMUh4jz9FingTXtoamaEvkENw==
Received: from CYZPR14CA0028.namprd14.prod.outlook.com (2603:10b6:930:a0::7)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 16:49:38 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::17) by CYZPR14CA0028.outlook.office365.com
 (2603:10b6:930:a0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 16:49:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:28 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:26 -0700
To: <eperezma@redhat.com>, <gal@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: [PATCH vhost 02/16] vdpa: introduce dedicated descriptor group for
 virtqueue
Date: Thu, 28 Sep 2023 19:45:13 +0300
Message-ID: <20230928164550.980832-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ad0b10-3665-4d65-9f2e-08dbc042e72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kj5BJN6WuunciC+HjKzFmr1Z1UbWRPaNZJJvkWG82YHBBxVX0EUY/J5eFG3LnP/nMCZGiKJ1pCDx14rNcjGiyC2DEgkAW6/KeIGdFdg2rCAlG4Cfz/Fz92ePJCFS7ENxwXk7BqkOUYMD7HHT05XbLmC1ZfYgqKlfqFiwWqIpdKs8VXpl5MQwbYPhrS6czKPKS8FVRhWm1jUSrLuCbdpbxpdaDnc9xkXS8tW9mZXm6RZbej/Oj158huyWPAa+9jmbI3etxCv8sN+7koqUparj8k7Ypw1qFeWjppPOsodCAjuoZKkBCCAF+rukH1/APuhtbfM6X4muFShzOrA7+Osi107nTk5TqKehCWAmtkJRvV/3qqabs+U29VR/J/UaTLtHvp1VLs8ooT/4loPlGCOH7fTwOrU6mmYdlR4fSVOHXJ13KaTSAm9NnFv4BRXEcfoZ+V5rjyHnhJ4pu5kL23zUCk9aY4rNugGeNTE2iBRjpMJO4QHRz3eaOTWcIQmNMtHfGQT/NdzYjCMJ1kyQSNp/blBFHLWFcAX1kppX4tezH7q977m1RZBiSgNl1LhzMpDT9RLQkeAXlEYeCJhn8rsgvT8a9dRHfi6DDPUlc0+u4k+wiGU4wh5+t/lfb2hZPseZ2F3zv8X/jtwKPswnEFCB7GIvpr4QZovNMEpu0gbXW4ARo64727jMYHbt3c/Pmn1/B/8UfXEpMHCR2sNrCvXSVdPjtaQuJbUxyxme4E3ZfQKwIlExJSOaPDyVx3FsUx9f
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(336012)(26005)(2906002)(66574015)(6666004)(1076003)(2616005)(426003)(83380400001)(478600001)(8676002)(36860700001)(4326008)(8936002)(5660300002)(47076005)(316002)(70586007)(70206006)(82740400003)(54906003)(7636003)(356005)(110136005)(41300700001)(40480700001)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:38.1086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ad0b10-3665-4d65-9f2e-08dbc042e72e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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
