Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD8BE95A8E
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BEC680E9E;
	Mon,  9 Oct 2023 11:24:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BEC680E9E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VRaxj0VC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SYp1lhXzs1FM; Mon,  9 Oct 2023 11:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BB5980EAE;
	Mon,  9 Oct 2023 11:24:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BB5980EAE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD578C0039;
	Mon,  9 Oct 2023 11:24:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89276C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52FAB4029B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52FAB4029B
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=VRaxj0VC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 29fwb8WsA01v
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11726402D7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11726402D7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ3d9818wWh6FnD+K5dPjN6pT7FxjlBYRV7dg5tIdMOTPUfrrZ9J+6FEBPuO5wFmber687SlkujE2Iy6Rhc1Erk2FQlLR9aQNgkAzup6+E2jmFF1UFTfNAFaqjvu8c+Qg/MjH15qsZn5YWulEshvBJ+esuhoWDIBjsibNOU95W5/hNsx7dReOJMQnIz8JB9DGdaIz7UNUDBt/uaT3A8XuX2sJHwmq1TLWcxSzrMEniIDcBE4HW4V2l/05NvBwnphxEkG2Lh8A3gXkNS4TKyCH1UvEjAErzC8NMZ4lsfIAbdyyslHfoVfopCQqhBghcnblw9htMhnvH7yMR4XgA4nrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u64U1vHaUjCMSpg15sklK0flAB7mos1z6H94Kmb4gsM=;
 b=DUWc/92fc1tts21LHN663DMS5xT91IzZxqqlDhWinxOmIVf7ZtTsO8QfgJJYM0DIZLgdD8I25F1sYSS4VKGgDk2LuBS8oS8Wxxuo3LJKjUr4rccigA4n3MBYUQHrTWn+cDQ0s2Q5tv0Jkfzmqah1r7ieyToBC+kE1nxfflHvDwL+h2XP+YKh6xtJXXAo56glroRF07seeCKfxuauyBT4gLooTATyZHrys2s5xiv7Bc2xGB6Oh42C8aV7jRSi/g8fo1dhD2XmQVSZvgxZiLJ1uokTIpZu7hZTrDb7aYJsZYUmgJhc48VsXJfSx7kWh62VxvK4Bmk/rYdoG45bz7Ur9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u64U1vHaUjCMSpg15sklK0flAB7mos1z6H94Kmb4gsM=;
 b=VRaxj0VCg55fHht/uxDVi4YZdXiz8W82DybnF3jR3brasAnsy7JhVoxbcHM6pZ+Fd/aOjS0FT+n8ySv17fR35VXm4YZj9VYhdGnT7F6P8f7JXdMnqOa57HBV8UmGTI5ET/qrgL9PTJ2zxtnI/mvLhY4tLY5bMdgEXxBD7R1ri3HdLGjJ01I/vaJfmmo/B88BCRMFhq3s5OuMNKqfKnCIIpjTQHVtjbRabMK9wuQZncPybU7Euj7cEYU6MSP5WuiNb3r1kFQJm4TvJkOAcv3w3ZS60MvXLJ6YLLimi7hcLor9x0vDzo7m49BZIBKbPwbTR2UFZOGVSOI0RyucBiyTwA==
Received: from BLAPR03CA0085.namprd03.prod.outlook.com (2603:10b6:208:329::30)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 9 Oct
 2023 11:24:50 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::f9) by BLAPR03CA0085.outlook.office365.com
 (2603:10b6:208:329::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 11:24:50 +0000
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
 15.20.6838.18 via Frontend Transport; Mon, 9 Oct 2023 11:24:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:32 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:29 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 04/16] vhost-vdpa: uAPI to get dedicated descriptor
 group id
Date: Mon, 9 Oct 2023 14:23:49 +0300
Message-ID: <20231009112401.1060447-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e323531-6119-4d64-0a55-08dbc8ba59f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O40x9nFbR6U5s4J/IDnKsbBDIwl2RoVi0ikfU+HWPLZ0E2RoRP0tlNeKvSLfurqaGJVu9WTKPXeUyF6B8PljFqldoCeLkbCi4nW8/Ng3F3PnnyCP6pqwci08mMLtNUi7XmV7InZPni9Lprz4cVLYooQVzuWjs8s+EAki+x/KFfKkodxqMZUJETKKQvLWuQKpO6ZzrN53Nxrll0z75MBGAkG0JOYaJFdsIQNp/DgzYnX1FrDJmZlshe2iNq1ELMUFWQMKrmz7MOixMVyF7bk7lJEPJApyvipJCMv0+PXYLu8wAp+JS+/x1ONDOR9ZuuKcg4dIMda25bm2ge6UDhi0oEolxelVsLzJzQzWTOpWK93fRHMonUNECLAbrVUCt7eV1kZicocR3bUrJvxX3hzskUBkhE/bzFzGxmZp9ULBzmKfl2G9XL+rvtRF5nAaBcav7bdjhrVCyI6qg0nssDM7idCFFEKLduxt3KLeia77c1U8con1WG08jyK0IYil2Z0ynoYJO5zTeS0+M9WQpKa3H9sNCcnSFwLUy1bj1FLRsQ5hJC9G8uSrvoQYtsFCHs+vQ1NBGKHBtMP1ohvJQm7rjHMj+cHjkG1cf05kZIpUhVQk7g2ZqMEy2NDtrRcJ8wN/alI4cR9TRv65nLdf8IcA/3AfI48h/5vKFXpli6zkgwHfFT1wSKP2hQ3Hs8RvbnL7/46EWR3WGKJRnt/WWySW99BuwOJXQZjvBM/H3TCI+SgRMQKaBqDAUDDIzDj1BFkn
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(36860700001)(478600001)(47076005)(6666004)(110136005)(8936002)(5660300002)(8676002)(4326008)(41300700001)(70586007)(70206006)(2616005)(54906003)(83380400001)(336012)(426003)(26005)(1076003)(86362001)(316002)(2906002)(7636003)(36756003)(356005)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:24:49.9794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e323531-6119-4d64-0a55-08dbc8ba59f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013
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

RnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgoKV2l0aCBfRl9ERVNDX0FT
SUQgYmFja2VuZCBmZWF0dXJlLCB0aGUgZGV2aWNlIGNhbiBub3cgc3VwcG9ydCB0aGUKVkhPU1Rf
VkRQQV9HRVRfVlJJTkdfREVTQ19HUk9VUCBpb2N0bCwgYW5kIGl0IG1heSBleHBvc2UgdGhlIGRl
c2NyaXB0b3IKdGFibGUgKGluY2x1ZGluZyBhdmFpbCBhbmQgdXNlZCByaW5nKSBpbiBhIGRpZmZl
cmVudCBncm91cCB0aGFuIHRoZQpidWZmZXJzIGl0IGNvbnRhaW5zLiBUaGlzIG5ldyB1QVBJIHdp
bGwgZmV0Y2ggdGhlIGdyb3VwIElEIG9mIHRoZQpkZXNjcmlwdG9yIHRhYmxlLgoKU2lnbmVkLW9m
Zi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgpBY2tlZC1ieTogRXVnZW5p
byBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgIHwgMTAgKysr
KysrKysrKwogaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0LmggfCAgOCArKysrKysrKwogMiBmaWxl
cyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwppbmRleCAyZjIxNzk4YTM3ZWUuLjg1MTUzNWY1
N2I5NSAxMDA2NDQKLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKKysrIGIvZHJpdmVycy92aG9z
dC92ZHBhLmMKQEAgLTYxMyw2ICs2MTMsMTYgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV92cmlu
Z19pb2N0bChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdW5zaWduZWQgaW50IGNtZCwKIAkJZWxzZSBp
ZiAoY29weV90b191c2VyKGFyZ3AsICZzLCBzaXplb2YocykpKQogCQkJcmV0dXJuIC1FRkFVTFQ7
CiAJCXJldHVybiAwOworCWNhc2UgVkhPU1RfVkRQQV9HRVRfVlJJTkdfREVTQ19HUk9VUDoKKwkJ
aWYgKCF2aG9zdF92ZHBhX2hhc19kZXNjX2dyb3VwKHYpKQorCQkJcmV0dXJuIC1FT1BOT1RTVVBQ
OworCQlzLmluZGV4ID0gaWR4OworCQlzLm51bSA9IG9wcy0+Z2V0X3ZxX2Rlc2NfZ3JvdXAodmRw
YSwgaWR4KTsKKwkJaWYgKHMubnVtID49IHZkcGEtPm5ncm91cHMpCisJCQlyZXR1cm4gLUVJTzsK
KwkJZWxzZSBpZiAoY29weV90b191c2VyKGFyZ3AsICZzLCBzaXplb2YocykpKQorCQkJcmV0dXJu
IC1FRkFVTFQ7CisJCXJldHVybiAwOwogCWNhc2UgVkhPU1RfVkRQQV9TRVRfR1JPVVBfQVNJRDoK
IAkJaWYgKGNvcHlfZnJvbV91c2VyKCZzLCBhcmdwLCBzaXplb2YocykpKQogCQkJcmV0dXJuIC1F
RkFVTFQ7CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaCBiL2luY2x1ZGUv
dWFwaS9saW51eC92aG9zdC5oCmluZGV4IGY1YzQ4YjYxYWI2Mi4uNjQ5NTYwYzY4NWYxIDEwMDY0
NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaAorKysgYi9pbmNsdWRlL3VhcGkvbGlu
dXgvdmhvc3QuaApAQCAtMjE5LDQgKzIxOSwxMiBAQAogICovCiAjZGVmaW5lIFZIT1NUX1ZEUEFf
UkVTVU1FCQlfSU8oVkhPU1RfVklSVElPLCAweDdFKQogCisvKiBHZXQgdGhlIGdyb3VwIGZvciB0
aGUgZGVzY3JpcHRvciB0YWJsZSBpbmNsdWRpbmcgZHJpdmVyICYgZGV2aWNlIGFyZWFzCisgKiBv
ZiBhIHZpcnRxdWV1ZTogcmVhZCBpbmRleCwgd3JpdGUgZ3JvdXAgaW4gbnVtLgorICogVGhlIHZp
cnRxdWV1ZSBpbmRleCBpcyBzdG9yZWQgaW4gdGhlIGluZGV4IGZpZWxkIG9mIHZob3N0X3ZyaW5n
X3N0YXRlLgorICogVGhlIGdyb3VwIElEIG9mIHRoZSBkZXNjcmlwdG9yIHRhYmxlIGZvciB0aGlz
IHNwZWNpZmljIHZpcnRxdWV1ZQorICogaXMgcmV0dXJuZWQgdmlhIG51bSBmaWVsZCBvZiB2aG9z
dF92cmluZ19zdGF0ZS4KKyAqLworI2RlZmluZSBWSE9TVF9WRFBBX0dFVF9WUklOR19ERVNDX0dS
T1VQCV9JT1dSKFZIT1NUX1ZJUlRJTywgMHg3RiwJXAorCQkJCQkgICAgICBzdHJ1Y3Qgdmhvc3Rf
dnJpbmdfc3RhdGUpCiAjZW5kaWYKLS0gCjIuNDEuMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
