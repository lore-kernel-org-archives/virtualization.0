Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70075E732EA
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 16:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1955341BC0;
	Thu, 28 Sep 2023 16:49:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1955341BC0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RMqUPGWV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fDspOGgd-Juc; Thu, 28 Sep 2023 16:49:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86B9F41B8B;
	Thu, 28 Sep 2023 16:49:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86B9F41B8B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62D95C0071;
	Thu, 28 Sep 2023 16:49:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B420C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD6C461164
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD6C461164
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=RMqUPGWV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WmvQaRKo5fJ1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CB8A60B4C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CB8A60B4C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIaa/CxF69oMvfRMNfHd5QoO+LxTveHRSVYS+gmUD/hyf5myrZQxmqrMvUuuctGXIlIt6D/qugcr/h4Xbj2sU8sO6BMml6u8K1h90jw5UepdyWMN4NXQ+vdsoDvfBZnImoLaw1SbQQqzj3NB0J3j0LPROJ1YV/NBL6uVy5e6NBtW2S6JiIM682U6vZDCsR93N99w+ASaeABieHia8O41tk92FQZRmKssDNTuqIu3b7+o6wSZDdHBVG+1j3XhEBs0RQmIxGoUSS4gbkhJxb0tp8W6gZd4PxQlZ1p/nMl1PnjxEs4bjk0AwaDF94A7R5qR1sZkD4/Ci6jmk60I6xnzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u64U1vHaUjCMSpg15sklK0flAB7mos1z6H94Kmb4gsM=;
 b=l89UZgGFsi4ekBIuMsrB9UkGtdT0o+L66g9GXTG9btPS0P+V/FRN446Oe1lIMcikx0UxS14NwVx2xWHBtuBSWbQ1mkXL+iggt2GSbRV2ovipetlNYfsB8Nl39iU7xRbfzbZ5luXmldwh/oz+n6YLgI3bdUa2oDJqbg7eNzzvFE5yJHkpx3wctwwuOmK7jpg5XORUyRpCX6OK/KK54nI58tczd9jAVw/EV3Yw3AY7zX+7JYIrKw1B5QWIyCSDAoZBxJfButBRg4xmlQRlzz/UDDpzx9jgnUUAvy84KNLj6o0QUgdjUAUlHPltOxop4VC+B0XYAXUKLgyD7uZbErrwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u64U1vHaUjCMSpg15sklK0flAB7mos1z6H94Kmb4gsM=;
 b=RMqUPGWVQyzJMkle/oL496Jo2Q32omWBRHpGGcNY9nBgPtP6sJ2aIYFq0nJwH0/e7NMxyJZZh4LqicRFcPl/JcG7vAiD0XSgi7a+GrirRVwl/cjFsG412gFk8E7+bDreaod8CNr6dW25Dgvh09LykHCSteKD1Cgz7W/iRCqLs9FZlHkDOwqgn3iQoVlIA8eccRArMZ+LsWR2rQJd7uTkUJU9fdcoCCrtbPhQmAPeV/sBaGagMIbEf8+zcbipSIWAphVeMtdGKni1GUPAX4O1fCePKf8HVKxlFcvCvbzbwCzmn1J+rMqWkRTDmoWuqTRNFHSjWkcDlpga7XkGPjiQ3Q==
Received: from MW3PR06CA0017.namprd06.prod.outlook.com (2603:10b6:303:2a::22)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:130::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 28 Sep
 2023 16:49:45 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::69) by MW3PR06CA0017.outlook.office365.com
 (2603:10b6:303:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:49:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:37 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:37 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:35 -0700
To: <eperezma@redhat.com>, <gal@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH vhost 04/16] vhost-vdpa: uAPI to get dedicated descriptor
 group id
Date: Thu, 28 Sep 2023 19:45:15 +0300
Message-ID: <20230928164550.980832-6-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: bf69fef0-7f33-441a-5fd3-08dbc042eafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3covqXVqV2bCvSqif165e1cjvj97aFhG3v7BAdqt8P+zGUeEV+8AJOweXKt1SlBDqE24q8CK7DPQcM/IXjmTyDYr+XnR7kGERe4ZaymPbkxNMqdPH7ZEwxwvDJd8jhmoWOtyH2NC135lk64Ui46dH9cHTHjsEq2NK9Z2x2nRepZQ5CIBhs4QqN2wU7qjC01Go3JB3dulhY+aXFmgeSzv9cRLuvioYAh5N0oBlh2qfQlr9nnsLzlyfeLJQkZg9Hvzqp+E+3L2shR9Y/1eBJL9vrM68mqcHyZk1TYnvaGbZu/l3eCzibYAxE7viTHL3l172YwKT6vvfrVZxlaBKeQ+lsaLgooAJusmhT4kG2uD9H8kvhAfyJSl8LckkzVg1TDlKabjlqSmPKEjSSgy9qkZCwsTkwFIZWiKSC5yxC8B+2OY6TXjpLdSw6IhWXmyeauCQJ+bzO9ZP2CHf7bh4uMWqu0fkCm0P1dneyc9zFBNcp7Wn5e4QlgmQMUXby7obd47REFBICS/PZG+D+iiw94ekl5W1UPY1Jo+fN+5bIWu95e2TP0kipNuxEFblhtzLabG4meLGSsAOosghpNgeVhZfHQ8zfU4HKDoLl2qEoHS4CZdjP+3puJ8XAlcwLCacSMcB8kPtfQ1RWvy7uxxQqe7ger6q8QGMWf6+q2WZOwZMMFbQiwkyQrIw/UfZB3GkAP6HkP0pZBMdNBsw0sA2/P12UgRKg/tSMkmLset4Jo3B2R13wq69x0MTdhXjEJ8Sqti
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(336012)(6666004)(70206006)(356005)(82740400003)(41300700001)(478600001)(7636003)(1076003)(2906002)(26005)(110136005)(2616005)(70586007)(54906003)(47076005)(316002)(426003)(36860700001)(40480700001)(4326008)(83380400001)(5660300002)(86362001)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:44.4836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf69fef0-7f33-441a-5fd3-08dbc042eafb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
