Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD909E95A96
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84F2461168;
	Mon,  9 Oct 2023 11:25:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84F2461168
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UyTqBMsM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2dafIlzh2XnS; Mon,  9 Oct 2023 11:25:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D1C6861167;
	Mon,  9 Oct 2023 11:25:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1C6861167
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4BF8C0DD7;
	Mon,  9 Oct 2023 11:25:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32DFFC0DD3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03535408AA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03535408AA
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=UyTqBMsM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LNqlxNvIspyG
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::611])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B671940888
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:25:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B671940888
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR54YzSwT/cxGJ9R0frM+IRMn6GtsZX4yDgGb1NMhfervUARASdO3NAQEL4jcKVQ3JKdNIDeMgwhrU1LnL8Q8RvA4mefiOcz8ZilLhv4fU1NTkmV7VpWn3lRTCj1RShdn840kXmqlD2ihbYWOnEEraxhTO/jNWCodwQbWPeRqkOgVTI6mr5kHUMoVbd6Qr/eKdPT1c00GiLEUUUpKrXb7r39dEF8JvGNrGocs0HtP78TjzBJPqsFxlW63qF009B/tn/L0RDTCbTe4LGlx4BwQrBLKgHE1o4Fjw/ER4uiWhq8SymqD6zZFXh2dmhC+pIY7RkTwUKpvdxp7U3vtrbjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqfty/jYzKnLc/JEwSMOvq4UGNN3rkOgV9qEyvqXUKk=;
 b=KAQlrfx9qDTnGtkQ8+psa0wgciQ68xC2ePwm8FzVzYkpqpbeYq0f3VaB+4DqG3MAMbAfnFMXkidH7pbq0n/6FyFfnMrtwWdLQnjnCI3WI3nZV5XfvZu/1XjVUC/nqEupllwmr5r3j/qwkJt62kTaNfe7GQN9qUmPE/hI/GW22YkPm7EhzOma4WIDCa6a900JUJNmTxNphZdMKz1dIisn36dKzpn788VzXomiH7jf5rYNu7kFqChNeS9rfTB/Fsiq8nL/s6Oa0NRPrKOa3+/1iH3Ul2+s7Fmt7bWH58YiIO2SeKRMgB7urOUVWLiP3M7x/GhTPPGZM+S1RTbLRUCnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqfty/jYzKnLc/JEwSMOvq4UGNN3rkOgV9qEyvqXUKk=;
 b=UyTqBMsMAAhpe0S2VLxY8lziOC1IqsF7U1hYbAC8IpOKLIhJbzxvB0Wbyjx+KsQastCYWL1UkyiufiYyj0FFy8hzNB/bitKR9s/rlvg821ad76UnnvieP48DEDcb9pkSZ6n2SR6sIwPgdGpMRI1+dflCfxW42J9YooS1+Qp662sZ4MlHLsQr+MrumLzeQHvOPB9w0jHbK+2a+XcJeQXYw7TtTB9xy2uNi8YexDcNtGKUWYDVrp65XQqrNbYbTWIeOqP3I472IM2qz74tAPG5zgimc52FCtip8GubxDMsN69V81aqdRu5TU0X1dUYA7Y0NVaCJ1ZpD5L3ik77e5XtbQ==
Received: from BLAPR03CA0032.namprd03.prod.outlook.com (2603:10b6:208:32d::7)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 11:24:59 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::5) by BLAPR03CA0032.outlook.office365.com
 (2603:10b6:208:32d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 11:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 11:24:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:43 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:40 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 07/16] vdpa/mlx5: Take cvq iotlb lock during refresh
Date: Mon, 9 Oct 2023 14:23:52 +0300
Message-ID: <20231009112401.1060447-8-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: df07ddcd-29a2-4475-2fd4-08dbc8ba5fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6pNu0ufCgR5HLXjXutWH4pe+K8PpVLKlbzyh54pM8878HddeSxfdOTqzNV+nefhz5CtLrhzxUx0PEVIsvtWW2dxHaxwt4r5+hGpT9bHrbDipx0kxZwoMF7oTSZ2ruScJQ9mefReN+sOE4ZZKYDGZzrkJKMstKlJjBGwnv7Ao+OLF8fHXsd0pJpY2lAH1/3p5oRbH6TISgFhAxG9gJz5z7THUNjvuIBkqu2PG+KDtLCtm789BquLH9fkped+rwn/tbC57XkXiZAnuUPbR1OGoakCuF70AuNFiacCblskNJIj1Bi/hwU/edzEVhTCzkyIm1JVHJvMd5iCdO3OGXs6RLwlDqmzUajFlzth4zsvJEDXP8S0OY3/uD3LjsN4BdgDXNAq9mSoZqbFR7P7FNBxOpF9xT8HOdc4Ox0rvkwuUPDfBFydEBxIykhGQFFvKFNBNDQHZE03zqjlYajYPmyGIWQelJbv9nUWvEAhvYJREUFHBdRPkW/ULUPq4r8TBOgSVg45x75Q3G++ymH+xgCWKk4Ew4lbir6V5fGDhsFNsdVIIzk7xiP21mswRCB/TaQpmJ4CKJyeb1o1bLBq+TFuLbbK3TlJVYdQ+jtRJPPpXKoY3hRrLF89aXRaOWfasl26A+knSDfjeExepZ+la/O/A6b3PMG4JXbdO6AUr/EwLR4Id4au7gOkNxyUXxGPc77YmF4vTUCLsEWSRIq9HlpfLlAjOn52CuX7d7zEj5Zy8pTc/CFJ1iTV61BRu7FWkpJ7n+AIOK6fpaBjwyyU/gp4u+YBI8m3Gow64odmZHc5XWo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(1076003)(478600001)(966005)(2616005)(66574015)(2906002)(47076005)(336012)(426003)(26005)(83380400001)(5660300002)(110136005)(54906003)(70206006)(8936002)(4326008)(8676002)(41300700001)(70586007)(316002)(40480700001)(82740400003)(356005)(7636003)(36860700001)(36756003)(40460700003)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:24:59.5224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df07ddcd-29a2-4475-2fd4-08dbc8ba5fa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887
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

VGhlIHJlc2xvY2sgaXMgdGFrZW4gd2hpbGUgcmVmcmVzaCBpcyBjYWxsZWQgYnV0IGlvbW11X2xv
Y2sgaXMgbW9yZQpzcGVjaWZpYyB0byB0aGlzIHJlc291cmNlLiBTbyB0YWtlIHRoZSBpb21tdV9s
b2NrIGR1cmluZyBjdnEgaW90bGIKcmVmcmVzaC4KCkJhc2VkIG9uIEV1Z2VuaW8ncyBwYXRjaCBb
MF0uCgpbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDExMjE0MjIxOC43MjU2
MjItNC1lcGVyZXptYUByZWRoYXQuY29tLwoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+ClN1Z2dlc3RlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhh
dC5jb20+ClJldmlld2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4K
U2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Ci0tLQog
ZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jIHwgMTAgKysrKysrKysrLQogMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9tbHg1L2NvcmUvbXIuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwppbmRleCBm
Y2I2YWUzMmU5ZWQuLjU4NzMwMGU3YzE4ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tci5jCisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwpAQCAtNTkwLDExICs1
OTAsMTkgQEAgaW50IG1seDVfdmRwYV91cGRhdGVfY3ZxX2lvdGxiKHN0cnVjdCBtbHg1X3ZkcGFf
ZGV2ICptdmRldiwKIAkJCQlzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAogCQkJCXVuc2lnbmVk
IGludCBhc2lkKQogeworCWludCBlcnI7CisKIAlpZiAobXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9W
RFBBX0NWUV9HUk9VUF0gIT0gYXNpZCkKIAkJcmV0dXJuIDA7CiAKKwlzcGluX2xvY2soJm12ZGV2
LT5jdnEuaW9tbXVfbG9jayk7CisKIAlwcnVuZV9pb3RsYihtdmRldik7Ci0JcmV0dXJuIGR1cF9p
b3RsYihtdmRldiwgaW90bGIpOworCWVyciA9IGR1cF9pb3RsYihtdmRldiwgaW90bGIpOworCisJ
c3Bpbl91bmxvY2soJm12ZGV2LT5jdnEuaW9tbXVfbG9jayk7CisKKwlyZXR1cm4gZXJyOwogfQog
CiBpbnQgbWx4NV92ZHBhX2NyZWF0ZV9kbWFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2
KQotLSAKMi40MS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
