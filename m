Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7BBCDB483
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75D196F4EB;
	Wed, 18 Oct 2023 17:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75D196F4EB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Y6hg2/N5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RuzZyBtyknYL; Wed, 18 Oct 2023 17:16:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B5A5C614EE;
	Wed, 18 Oct 2023 17:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5A5C614EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9115AC0039;
	Wed, 18 Oct 2023 17:16:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD997C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E89B614EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E89B614EE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MncvMoDHGjOB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC6D161136
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC6D161136
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEj/bxhAwEkg7fQMmRVPgdsoECTbq4OB1JRCRG3nCVeHuTvvjA5eJ4K3woABvaQw/l265MLrxnwDDDyJfu2HM+JKbWQ+z44GDPAKq5epWJG/9dpj+qSSz6dF8hXx7KriTSoGdKtUsVtAbmhRrhYesFDH6fDGoVhCw4WIQd3rjBrzBpxpeKZpwL55+ZSIlrauqqSAJCHm9A6EvHEQRaCVuB04U/MBueeirjDdhSZ/wx/nWYnEaDgpR5WlkS7KejP/Ybib/1+UYGwdTx+uGfOn3vS3YI7/G2GVp7+rLopvOOh6HjGeh7Nnbq8iDILmtRRl2FxoZV96sAr3FhU2cd/Dew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u64U1vHaUjCMSpg15sklK0flAB7mos1z6H94Kmb4gsM=;
 b=ObpmFBFUcASwundJf17ouX5HXIq1+hD4eWBaFW1esQ68A9va2SltWqoJ3NfBeaCXIvOWLLMw4QKqxVh4dcpo8RdKgvrngAcRvZ8JTubWlhrli5LLZF6LNI8vFDc70NC1+iB4B325QOOrOET379xvdOnOddXYPyktm1QuHAJ0Ct+yK4buqJ1R4RtZq1eV01y+iFANdsgzTDla6WTeA+KNZdIypKmfGEILE+KvOkNWoM0fgTeHjmEpz1fFyTcQL/qOTwyjnRTpnLaMJ4ULGEWm1CkMDhy936J1e+/K4XzSNRd/oQCEjIf4IiuDDp2SKO92rsw2eKCynmFA12mHJPD06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u64U1vHaUjCMSpg15sklK0flAB7mos1z6H94Kmb4gsM=;
 b=Y6hg2/N54tfKr/Rb30K/PwbSMwKrF1WkPOLVRLcbggk6T+khh/rsG7qE5bnVmI3AUmHY3hX3c118BZ4fwrbi4cVqPZgLrEqe131tbeO1AzSUtT1J0UKZNMM56ojI5rJtb+rrkNrQXxWOFhJamUny+55O3baP/DJy8n471G52U5Ldf6AzwYhBsEDALmLrh07p6pVXrOjIND02YfktKPTZCc8bFX0lAwX8ohjY4JwThWLPgOaELbofTfPJ+PrgvQ7We7S63oCn8QHe80tV6l28DbMooFgiiXmpltyhDuVqsRMvpNpb7pCzFCOGgOq0AgIMLCaVBmabsOq1vo+F7B9vCg==
Received: from BN0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:e4::33)
 by DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:16:01 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::cd) by BN0PR02CA0028.outlook.office365.com
 (2603:10b6:408:e4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 17:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:16:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:41 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:38 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 04/16] vhost-vdpa: uAPI to get dedicated descriptor
 group id
Date: Wed, 18 Oct 2023 20:14:43 +0300
Message-ID: <20231018171456.1624030-6-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM4PR12MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 87625a0a-753f-4aee-b47c-08dbcffde708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5h0gy9lojRRmXdsIs2ENcNTm3YEt0wrdqIZWse4NkvCh000i12j/5Vkicf4UDSmQFEN++3lXJXpyI+WxUj2tnfpViuA6dvJPxA3kdFvw74S47TNH/e0QI/qBwRA6qasmTCZlSJYYF9GZUmyA+yO6E8zb+73hc1ecJwT36SaKyaMfmS00wlj15vERCNUePwxRMHRcdAORsWVu4TQ8EaRHWdh/utRlVbZ/4tBTruPcyWW24SOK1IFCeQCXiUn9R4+6bIeuA+AalG8UHiZ1DnyZfCUSlVFKeUZ5/sADdH0wZOuJPWQmyB3R3nx6SmPa10444WCR/Tf+dHva4fkyaJGjf+C5frduPc3uLJaSxYJDREbqoWRpxo7oQWF01ueHEiQjgu9DsTnPMmzEPn5le2X7r2XwmhGLbn6yz4urMePczIfQ0bevZhdAzIFkpYalNfxcWEuxMZlm5bXdv76UahnFSM58bu2HXxzBbhuGaiRMg1ohk/66GQbuXhAc7sZrng+OAJL/6jfV70G5uFc4tGLXOnZ4c/Yuv8FGf07JXJsmedBg8PP8d5HbCud3O/ZQ+xwQNNTUHJTr015FcVCBrx/R07uVJ/mM5mcZ2Yw2mOXdljOFPB++9PjkvgpceDR3jxtwJ/aNaLgb3u3sGRPIwTnDER8aTdCqKNDptNeiOMuDjrzsw+vxy4upAWbtk4dg5j0R5GvdXH5ykmOFsHV90w6vAdYVHzUpQLDWBq/DfDV5g36ihz8GknNmNGRRz3u45Ty
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(7636003)(356005)(26005)(2616005)(83380400001)(1076003)(41300700001)(36860700001)(336012)(47076005)(426003)(82740400003)(478600001)(6666004)(54906003)(40480700001)(70586007)(110136005)(70206006)(316002)(2906002)(36756003)(86362001)(8936002)(8676002)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:16:01.1433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87625a0a-753f-4aee-b47c-08dbcffde708
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
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
