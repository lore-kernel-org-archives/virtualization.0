Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C73BC0015E
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 17:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F27040518;
	Thu, 27 Jul 2023 17:25:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F27040518
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oc0OfdaY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAtKqQXEDGZt; Thu, 27 Jul 2023 17:25:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 188C140297;
	Thu, 27 Jul 2023 17:25:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 188C140297
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0CAFC0071;
	Thu, 27 Jul 2023 17:25:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAEE6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 17:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E8F540385
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 17:25:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E8F540385
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nwyoA8aEbOHy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 17:25:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DD6640297
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 17:25:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DD6640297
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRQJY5NhbmGEq7UW1NqqfrSCq7dKIZHBNa1/3RHI2cb43Ul2wDPeU1u7ee5TKVTuah/w/+Xq2gsvcZn9jb+StJqRqe6MdlZO9PbUMnouZvI4YpI6BYVsvLvzS3n18YKF8qRDJ2MKun0dZaK3JwBcFiVB1+O6oKfesBfB5zbZvBPM2gcMH9Gyw7MUxvNisw3CimkkhK4XBHLzYTqtOi49Ho/ji0jCPniwwWi5HE06exLjD73j70R6j5CiuGSGnnRJ514cIWnnV7mYErWPUM0Wvi/BgSnOHYpZ7+sgnSRQozySN59plf3/CyGmtThDm+9jL7nD5c3u4nZ+EXBOLTyoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBNxB6fKcsvU0vqexNHWVhVtnGjnZwJbLJ6L8xsTMOw=;
 b=h3R8rlGPbtaA6z0h2SmMinxt2yPIHxIb4GMPiCMAsqv4ppxc2fHUtPosBybEiqGrs9K/iXNUEELHA9yQwu4iFKvVYSobW2rVNcaPoW6N/JNUF0kkoFh2Z4i59fVNdMPnHQIwo7RnrZy/XNLRbQH4TCXJS9I7cMBk5+ZFRlCquT14p7yXr2fvMfaLajidPaZBDBj8IkmSYgzIJHEHgfE3hmknnNkAGvYHD2WvJbj2KG2m58ZL59rek3nnAsBuCK3tRKK/slIJWyNOeEkOI7H2NcHKiPZnSBGJqVEx/PjVdq68Uc73Gg7yZBRWfir6ENkmkHLuU/H7+2RSINAHAaqh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBNxB6fKcsvU0vqexNHWVhVtnGjnZwJbLJ6L8xsTMOw=;
 b=oc0OfdaYRNRu8jOm1fNNSiTCACX9RoMH9kG7z21i/t/L+zXH1+HObuP2QkWuqaZrOAth8Se//5kMg6LmcmDWAd4KgW3/ptONKoGvKGgulcHQO9HQeHqiRBR1NJxCpY6HowDZg/az3UNiEq0zY7S7tW0+ybxG05sLgNQ2B9SIz9MGpEXzIYkLoEm0QauUKNU6QYYbV+oGfYX8PscaeAc8YnBhCIvetUyKHCehDj467AHkMPi7KbpPWaAVtKzAUvtnjPk0k2BljLImQq7TO1Y1ubdIGwckzfeuWlLRDNsDc5TIkP+8gjsULBnwVfAxdVthek1w+ctdaGt5nC2802ncRw==
Received: from MW3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:303:2b::29)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:24:56 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::82) by MW3PR05CA0024.outlook.office365.com
 (2603:10b6:303:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5 via Frontend
 Transport; Thu, 27 Jul 2023 17:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 17:24:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 10:24:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 10:24:42 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Thu, 27 Jul 2023 10:24:40 -0700
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH] vdpa/mlx5: Correct default number of queues when MQ is on
Date: Thu, 27 Jul 2023 20:23:46 +0300
Message-ID: <20230727172354.68243-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|DM4PR12MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: b94676a5-c84b-49c7-385b-08db8ec6656a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyZFvwjuxgYFfSKE4ya4xybwaYPIWtdjFBTe5w5K6Ay4QE9A5meVwSqftJXms1X7uI6za0+tSQkA+tDWmYmubdtIqfvYbEoYe8dWLt7mRBjWDKJpnHA4gd9HpmgMU5ZzP9VFahUQ0XB1LyLn1A8ZgOLtVN6v641Vsk/X3RJ5Ad4YU0wUlvNJjiRQP+li06fO4DRga2oWj62h1jESIe2pK62SSq9HwDwqSLr3skEUvuxfs5XG6rk74gM99yTp2lYT7Y3zHohTAK6SoQh41GcGENxrYbv3TQOPQ+0O92kjN5Ap8b497AYHUkE2KhwxRmiMCKrnmhZStR4RTOiCpnVV8e1UnK7j5/JD/wCwNN24wzRkgeEQ/yQZ8oeH6Zz4bjmjWmCOS0Fq9Ql8Rq7wvo+7SpGFZuU0Wkla58pPCYcti042ZrfJ+YYhFOoyyJzSdR07UKbA5EIltfVX7CXKLFPLu0fwIERGPKZ2AMOFYXs6i1IilRgX6g3F4UrTWauF6bPYhjS7S5O6OWvI/WJVykiFU1/3Q2LNONTV1l8tw0UXrK9LUTONDdJumufcF8ceUcEaD3TgkcCJGJ22ju98oImAu/hfYJLyc2Rw3E3Z2BjXc8U6q4S/ChLGWut7SWlPL7c18W5xxOO+woesm5IiHloFEJimsVY6e3cwik3wKH6bJYWEUMIVFANwME3VcuKJLzOJfAEbm+0fiD27qFlWd4WX/wT+fQB5h+8nNyrM/7pp2o6D5bCV9PaL+Lied0Pi8tvf
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(2906002)(316002)(8936002)(8676002)(5660300002)(40460700003)(41300700001)(36756003)(40480700001)(86362001)(426003)(110136005)(54906003)(478600001)(82740400003)(66574015)(26005)(7636003)(356005)(1076003)(336012)(186003)(70586007)(2616005)(83380400001)(70206006)(36860700001)(47076005)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 17:24:55.8248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b94676a5-c84b-49c7-385b-08db8ec6656a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

VGhlIHN0YW5kYXJkIHNwZWNpZmllcyB0aGF0IHRoZSBpbml0aWFsIG51bWJlciBvZiBxdWV1ZXMg
aXMgdGhlCmRlZmF1bHQsIHdoaWNoIGlzIDEgKDEgdHgsIDEgcngpLgoKU2lnbmVkLW9mZi1ieTog
RHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+ClJldmlld2VkLWJ5OiBFdWdlbmlv
IFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgfCAxMCArKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCmluZGV4IDkxMzhl
ZjJmYjJjOC4uNmI2ZWI2OWE4YTkwIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCkBAIC0y
NTE3LDcgKzI1MTcsMTUgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2RyaXZlcl9mZWF0dXJl
cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKIAllbHNlCiAJCW5kZXYt
PnJxdF9zaXplID0gMTsKIAotCW5kZXYtPmN1cl9udW1fdnFzID0gMiAqIG5kZXYtPnJxdF9zaXpl
OworCS8qIERldmljZSBtdXN0IHN0YXJ0IHdpdGggMSBxdWV1ZSBwYWlyLCBhcyBwZXIgVklSVElP
IHYxLjIgc3BlYywgc2VjdGlvbgorCSAqIDUuMS42LjUuNSAiRGV2aWNlIG9wZXJhdGlvbiBpbiBt
dWx0aXF1ZXVlIG1vZGUiOgorCSAqCisJICogTXVsdGlxdWV1ZSBpcyBkaXNhYmxlZCBieSBkZWZh
dWx0LgorCSAqIFRoZSBkcml2ZXIgZW5hYmxlcyBtdWx0aXF1ZXVlIGJ5IHNlbmRpbmcgYSBjb21t
YW5kIHVzaW5nIGNsYXNzCisJICogVklSVElPX05FVF9DVFJMX01RLiBUaGUgY29tbWFuZCBzZWxl
Y3RzIHRoZSBtb2RlIG9mIG11bHRpcXVldWUKKwkgKiBvcGVyYXRpb24sIGFzIGZvbGxvd3M6IC4u
LgorCSAqLworCW5kZXYtPmN1cl9udW1fdnFzID0gMjsKIAogCXVwZGF0ZV9jdnFfaW5mbyhtdmRl
dik7CiAJcmV0dXJuIGVycjsKLS0gCjIuNDEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
