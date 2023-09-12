Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1282CA0ED4
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 13:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 406616119E;
	Tue, 12 Sep 2023 13:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 406616119E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jYbVfvy6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Twuk8qc8lFas; Tue, 12 Sep 2023 13:02:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 981B76118D;
	Tue, 12 Sep 2023 13:02:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 981B76118D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7C73C0DD2;
	Tue, 12 Sep 2023 13:02:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F4B0C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7705F820EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7705F820EF
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=jYbVfvy6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j1pDhNN3SW6m
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::625])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1E2F820AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1E2F820AF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+4IJFeu0+HtV6OBRpD9wydgZ7AfNMalbPltd6ToOsL3kVLVfBE8jfcBqzLLJC5Hyu9yq2QgsqyjaLEmY+wEKNjJ+ciYflhGlOVqWmoZY9iDH1y+MC7xg2Ag1k1GjXFndNlf9oKSW2qZRkhZrL4tq4h0tB2JgccRGWhH5JaGp6xMfkKWih+m5ag43+rV8lOp+xPkD19TKiXeEFnK7KN/ImWNOOvalMFT7/LV8dfaswgtrwvaZXgLr1kLrBNQmPhuKMhMCgwPP2uOMBKmU+UG+PXCy+g17go/uhMiF7/xzEE2OdrFlQCLJLYMaDb0FBuPXyzLCJ3MnspQyT6+vmrnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u64U1vHaUjCMSpg15sklK0flAB7mos1z6H94Kmb4gsM=;
 b=Ql+TNpsP0SGgRqK0Netrx+uv2B80La0nBGTBTujvhXlU/h/sn+tdjEPeyj8mDK2AUaJ4j8yHBpo/1PwGRWDvbpWe8fRhTKH99ijXlP2ubd02MZD8fM4PRxdUl1jpwZeUc65Z6HgfyTDXOM9Vhvkhx6NNd+S2E8cjEBpEIOsYQoPqlzKSjcrnhaecmtydjpY4RI/TpST8HUAIDUTVDMHH/Yd/LyGjEwSA4QdygsV4z6fJE4PMtVsvfbumD3tX5sjvWs/zJjCnLDs/DEz8pofVuSbYA1nG3z4dA1W/aKCgKHqiSrOaWHg8C1XKZ8Kt60UhPutC5sB43UGy5s6LhQAxYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u64U1vHaUjCMSpg15sklK0flAB7mos1z6H94Kmb4gsM=;
 b=jYbVfvy6fjzQ0PMnG6pApEc3S4H046yPOUSBJnS2XSxw0/gCrSNdH75LSFQ+AGVLvCyBEQEDWoS8bSzb0RI7FwcqRY2jG8ATDSaUlku9DxqSIMXP0n9sO97FJIGYGra1ssCHHUh+fOk0GBQRuq8IIDxEoeOZZprfveBxAu/WrUzxMJEod3lWk5S8RmHWNY/06jcD//wi9tdSK9fTqwB7+29aUAUfVHTSVUu7PkNGQOUrz8CNegQMfAMZ0ThczLKZ0BPmSynpUeSZEzXRY1zdH3ewPiOTdrwzDZmawFw+Dz4q3ubhoBHFhHCnF43un/q+bso05MPFpi/OxwxYYPYUTA==
Received: from DM6PR14CA0060.namprd14.prod.outlook.com (2603:10b6:5:18f::37)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Tue, 12 Sep
 2023 13:02:08 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::75) by DM6PR14CA0060.outlook.office365.com
 (2603:10b6:5:18f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 13:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 13:02:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 12 Sep 2023
 06:01:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 12 Sep
 2023 06:01:56 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Tue, 12 Sep 2023 06:01:54 -0700
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
 <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 <virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/16] vhost-vdpa: uAPI to get dedicated descriptor group id
Date: Tue, 12 Sep 2023 16:01:13 +0300
Message-ID: <20230912130132.561193-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912130132.561193-1-dtatulea@nvidia.com>
References: <20230912130132.561193-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b5d8a3-2eac-433d-ec69-08dbb39078ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gb1HPxQzCWQJFaPXWWVxmwHwnc4AmW4oAqnvxvE6VxG329Du5We0wTgpQJ9ukAVOnSSJTGR8X3yXXU3rk6tEw9l/euIPXQShy0ehp7MzB1LKhPbIBHNQhrs0S0dYFHpqu5PC3ioYj/0jL8IFyEalWzHz9ikEixWUOPbHwP27qF9gC0lVARBMnKE4tLzeqOmBgc1XzxoQSoEVQhTmHWd4tlI29A1gFXiVlFYN7kqKBt75qkDkZBrLDV+n7tJCfBLzxN4zSxCD+/zcJWt2REvA1PENj0IynqW3GfPTcPbSAtJk6LtTHfLK5oRkjGQXLyea7v4gxf0BRfXKn67divfyDb9Tn1LZzj2+SxeeqTaRo7v79saEEUOHg0YNbGNNEdmR4Zjt8Ro4OP5VeHRpJQMaEsH8Vep77pOsHMx6SAAHCJp2CG4oyhKztijDnSPlTE5LjjDPg7CaMW0xbX6wIopVuE3aWVzRrKVAR7D4CheKmElDbL1OkpwFPzeMvNv8VQNRQf6W81oQWbAqiFQQyf0TL1VCUbKz9nYi91trxBw9sEP8PQV4+SIjnMTHHVlRSeZgrC3PwsnkYiO9P7RjxGeqPwtGk6Zozq2tLzld/HNqUhx09Ls+fVkPSbymy9P25foYb2olqBoxWvy/w+mY5oXRTYcbbRYQQo/vys8wfyF140FsbKoPf4kIKq9+ABFF5PmTp9X2BXHs7ejA9nYJMUyiQklRHuiuhqLy+GfjqchB669eUvrDo1v36FAcmA3Te1Eu
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(41300700001)(316002)(40480700001)(26005)(336012)(426003)(1076003)(70586007)(8936002)(110136005)(2906002)(70206006)(8676002)(4326008)(54906003)(5660300002)(478600001)(6666004)(40460700003)(36756003)(36860700001)(47076005)(2616005)(83380400001)(86362001)(82740400003)(356005)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:02:08.2977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b5d8a3-2eac-433d-ec69-08dbb39078ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
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
