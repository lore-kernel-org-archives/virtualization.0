Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C949CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2C7F4191B;
	Wed, 18 Oct 2023 17:15:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2C7F4191B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lZtmCB4T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gmWXU47GcjBe; Wed, 18 Oct 2023 17:15:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8C5441916;
	Wed, 18 Oct 2023 17:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8C5441916
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A89FBC0039;
	Wed, 18 Oct 2023 17:15:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B609C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C9FD61136
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C9FD61136
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=lZtmCB4T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0jPLsKUURtNU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::622])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25002614EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:15:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25002614EE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmJYR5A8aNs1/qlTyBiaF8H4uFSbrnjmuVtRv82VGjOX2Cwwz/k29fdJoVxpm0bzkN7Wc2BjBdA5D4NcXm2tZJKgvnggRK8/slYp0mKA2rj6eQoVgadwEEHPch/N6WrOfG2icEaFKCDI22nXKkNzW4NbCv6NqnXFQhU8dfhlCCJJQCDzxTfVUnZdRpH1Zsv+Mhtb3l05SIRWr9MxJmh/Ay/4if4rSmoK5qSQALk1u0LdmtslaeAv3R5Re8jFGHfhoQ0FirME+QJGPjJPdOHDungUGqUf9gyc+iixkqojx1CeWaCPT3Y/yCWk62Uyidtumjfu1HRPPbDV2rA3GuddMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=YJEZzKdlqNSSVBxtOeftWp6F+IYm1anjd92kkxaOW/AXMjMJwMt9TqlYWudhGkZA7niWOYCAAIWDMnV1UB1tnc0O4erb+dv63Lx7RvFSG0X757Y95aKOm/a6Lfz4Ael8pyXY5a+YiNx/Qnu96LCFGw/a/rW0dNsMqxWUgdVoXIt1NlcAZgDEA60LECVVRajhJK6YO30VxLaFsLR/xTsATwzMy6Li9RtY7PZvt5LgMG7MJiLMWk1ZfM95t/mUtTJhHpagLOAe9l7fQdPkeEYE75bcNb2pGC5i27dv2EQZnVUe+daOcVb7wVs1qUNh0VupBvcXkuHQ3IV7XbyKz8K8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=lZtmCB4T5+OptN5sueNbgxReNPY/IQnUGw0wFPIs5WOBBWDpZjE7X23CDZ85Skzl28oXsIHOprOjB4Tmsehi7aVz0HKBcdm1JeTMtuHfu/LdKLkAbJNsVQnoG/4D4RGpdZUQvO7QnzWpy1FL9rCvSp6MoOSCwtQtR2DTl3e85/HdPWlvuqMzr55qWAxnbF7rDBbpIffNzmwpH5wjQM/9e199i2+P0BHDHa5ljC2spNSvL7EHVuCBiA79s/d3b5wG9DnVI5z9/0WV2VEFyhurZHcu51sW632Oh63nB8oovDoIR5Bv5AW1ihmJ6mKXNZQrt++TyXPFyrWpOzSeYNf6wA==
Received: from DM6PR08CA0025.namprd08.prod.outlook.com (2603:10b6:5:80::38) by
 SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:15:53 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::79) by DM6PR08CA0025.outlook.office365.com
 (2603:10b6:5:80::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 17:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 17:15:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:34 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:34 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:31 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 02/16] vdpa: introduce dedicated descriptor group for
 virtqueue
Date: Wed, 18 Oct 2023 20:14:41 +0300
Message-ID: <20231018171456.1624030-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 6355522f-8b05-4ef0-9aac-08dbcffde20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XFUZzhXzDbegIFEx6hdNFO0fLI2aLS3CYZ4xCZvBC5vHfK3xXIa96JBSfvpD5nBdL8A8s/L57XYbkDtf7s/qTR9/bFIDOinS7CnoI1nQl0cnIqqGrR6IccEBtLtoQ8JNn7r9GBIfyA3qm+J7gpUF2NW/I2ohMivzAv9v3smwNlAw/f+Py7M3rxW1uydQmUYuFK+sw/qomkiEi6u+8OI8leBNXU3DbBDlN7DTZcuprCjemyOe+hQv6p4Bzm9IpOD+meIz0DPsKLBvXpi+/TABKol61P9gjKODdFOtf4zu6QB+gQA4aQYQKD6w1kdY/zUFXejcaU7Kg0jMUspb3pyCBvPMe15omkgOqX+DQGF9zm/dCwQqWKZ166PIMXoJNigzApHYiMg8SfbnqBp7pVnZyK8uKSFOLydffeT7+T/elemQdLw3gqpRS+EzUsOX3zzpCUF2MsYLfgK7ajqAoM34DwBfUfwdlo8+Qt9zK1+hM0tl0fzWoNupc1On6F2jKflgPBxcqAvCT9V8GRx4lT8YN4kjXKz5vMntVWHCR0k/h8RY5ck0u9ZVRDlHm/zxMZobRZlOgSoH3lK9ERFdxUez5bKdFH1Ymn8zCifTnvG58+VHN/o2e0q2hIhNWjzxsR/WKIbRZPpvMnnEtpfZ/vhlYV8sX55bzZFgJ6k2UGTzKRprzPybCjAlrNc/2L0kyrhXTmTiHWhUlEr71Hs5eLIE7nI867xGV7Q5zPTG0nKhNpYVkpL5/6l9TXdB7np0J8n
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36756003)(426003)(110136005)(316002)(70206006)(7636003)(86362001)(70586007)(54906003)(82740400003)(356005)(1076003)(47076005)(83380400001)(478600001)(36860700001)(8936002)(336012)(26005)(6666004)(66574015)(2906002)(5660300002)(41300700001)(2616005)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:15:52.7737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6355522f-8b05-4ef0-9aac-08dbcffde20b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
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
