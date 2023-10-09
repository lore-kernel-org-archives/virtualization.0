Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB29E95A97
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09A9B80ED3;
	Mon,  9 Oct 2023 11:24:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09A9B80ED3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DhvWI/tQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5TxcC6EwhaUV; Mon,  9 Oct 2023 11:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 980BE80E7E;
	Mon,  9 Oct 2023 11:24:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 980BE80E7E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76097C0039;
	Mon,  9 Oct 2023 11:24:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 172BBC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E628E40A68
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E628E40A68
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=DhvWI/tQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vdwqfFW9jHhM
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::618])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5A7C40190
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5A7C40190
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4yeGg4qYqD8O/AKU+sGm7x1dyuipCFNJ49wARZLSPjtXX9OiQt0qqwvZc6Vpjcyoq9TdQUUVVUafZ8YgZxqDyG9uD1AAs3dw7F6P2NRFOa/OlAfufNeRdrzTLaYlsXEQEEpWuDDaMNrB/1IKaP5nDO69SMR74+hdbsvVqXfwasG/bJTep7tCigjrON2sbUk459eT6lKNPJA2f2YkYl5t8NZiIzmUS5YrngIqcCRfury7ILd8ZskX7Xhpjk1y7Zkp8ggkD1hknNOgL4O5PMkriailm/AWBLa7zf2aQSKaBHqKGCzKK/7w6gZ26iXWR+28ZVnR0q5ofARJP/shDWnxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILKog4btT16IMu9HXAHH95fAm+8LcOyK/4mzDrViAvI=;
 b=OQhHJ9NMa6c/EoNeWnfmWH8rPp+/eDyCXqwxWvvREgiZvydui0H+CjuM0jBN1l5aF2mUtbrBb+4Sq+u5Xnk6iql1DQuoOJj1pw4DK7xP8eaEAJKV8y1+1zqIS/6DYxYXaFC6y3XFgvkKqO5rC1vDjAXv9UuxKaszCjpXOJH+RlgIDkXXLOeA57jL0KF/CUZaIqZ+RaJMdiULw0SzGv1BfxUZ+9w2/j8yIVN4v9m9gbYnaDKBLKmsOSJdDcWl2TvASCHOMnwUHanvvmiZG5F/erZpYFPZwJ3wYrPww7Eu5q6ReCqkKPCpiWUgu0p78BK+uGFBIegtVYjJHRIcR24MZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILKog4btT16IMu9HXAHH95fAm+8LcOyK/4mzDrViAvI=;
 b=DhvWI/tQWbkP3fImzS6bOL36R4Sjx2D8iib+JYroxzKMhFGQ8tOnN4mGc3OCj5jEFkxNnYw6lZO0p+akAghgiXA/oPNK4Bc0+7OV3NsMpo9jFSwOz2EPD0T9gssFQqSUJZH5By0CKpfMygn1V4NwIFBLlQNmiRTo8yyfAJUuaCmTAJd4aF5tNuDaDR4+15w5df3SnFJbPuodcuGCIMF3GosrTTpwdhejva883gaJ343QEtJ6Ld6I3jLSIgJS4d0DW6sPmjyQwT/h1stR/4OkX/e97HaCmmQeAPyR11V8XU5/f3dg7QACBlR+5HKn87zXmCaHqrfbaPk0g9obYhqLyA==
Received: from BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 11:24:45 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::1) by BLAPR03CA0090.outlook.office365.com
 (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Mon, 9 Oct 2023 11:24:45 +0000
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
 15.20.6838.18 via Frontend Transport; Mon, 9 Oct 2023 11:24:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:29 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:28 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:25 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v3 03/16] vhost-vdpa: introduce descriptor group backend
 feature
Date: Mon, 9 Oct 2023 14:23:48 +0300
Message-ID: <20231009112401.1060447-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: d719a82a-0216-4627-de84-08dbc8ba571e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: merPLwWS2lIyOWsQFsjoG0hzTrqwl6RsyKGioZa9EJLgrRYcxG2wF3NcmbB1AMIKV8NU6PJYlN1lVsO1SgU0+vMNrJfuYodnZcIUFCEyw7/Ne6piprvC/6BSAnpWGKAXzt6z5igKYOTfeIie2/L+V57B6WWz5c3Tvia/4s//9Gc8DHJYgaFOdEYKRfLmK8ZCzWnYwYx0A9PGvHc1ugCGp3y/LT2vJlpKhV6B2QNrBNUHNUblMjktCStZKCphqlY96QseKWZkj3B7Sw/KL1NcfOygZMGhxNvGb8BuMuINQujS4AsGLG5yIKrhpIXZSivNlvvBhlOJgEK/GXivyFpHcyYIAT2MZgDNGuTxqejuep5+uWndERCtLRyLjhhHk+pAtglCScfNTkGL2gQfVnEPQuaDQVsclriZ38aKqef2DwxbHhL05Fr0uQ0j4SsEldaK+gkVLLs/1oZWldtbGPKTdzna6ok+aRtwNY4/hxjxQIZF4KHPsJsvTy4100Bi7NnC8eLw6f87MBZRG04yia6aq/QK8OMHQUqFVUdH7zxRVqSEEm/2wNTzyDaBAYK1ctPOv4Outi61wbZsibEGSeG4pLRzx7EBImGTH4r+x7CRGv028Xa6wAwZTOLyivWP4/aluUtZBlUlHyLE5EBsBhrEsHP4sBX3bp4AS1Y8qH9DHOp6h9BUr1Mq4oe7NsnlRmPet0b/BYvxKJd0vVGXX8MI/NJUf4w8P2vK6RfYP9Yi2IQzsUC3iqEbB355wgr9czC9
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(1076003)(83380400001)(2616005)(336012)(426003)(26005)(66574015)(47076005)(316002)(36860700001)(110136005)(54906003)(70206006)(70586007)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6666004)(2906002)(478600001)(82740400003)(36756003)(356005)(86362001)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:24:45.2139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d719a82a-0216-4627-de84-08dbc8ba571e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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

RnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgoKVXNlcnNwYWNlIGtub3dz
IGlmIHRoZSBkZXZpY2UgaGFzIGRlZGljYXRlZCBkZXNjcmlwdG9yIGdyb3VwIG9yIG5vdApieSBj
aGVja2luZyB0aGlzIGZlYXR1cmUgYml0LgoKSXQncyBvbmx5IGV4cG9zZWQgaWYgdGhlIHZkcGEg
ZHJpdmVyIGJhY2tlbmQgaW1wbGVtZW50cyB0aGUKLmdldF92cV9kZXNjX2dyb3VwKCkgb3BlcmF0
aW9uIGNhbGxiYWNrLiBVc2Vyc3BhY2UgdHJ5aW5nIHRvIG5lZ290aWF0ZQp0aGlzIGZlYXR1cmUg
d2hlbiBpdCBvciB0aGUgZGVwZW5kZW50IF9GX0lPVExCX0FTSUQgZmVhdHVyZSBoYXNuJ3QKYmVl
biBleHBvc2VkIHdpbGwgcmVzdWx0IGluIGFuIGVycm9yLgoKU2lnbmVkLW9mZi1ieTogU2ktV2Vp
IExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgpBY2tlZC1ieTogRXVnZW5pbyBQw6lyZXogPGVw
ZXJlem1hQHJlZGhhdC5jb20+CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgotLS0KIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgMTcgKysrKysrKysr
KysrKysrKysKIGluY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhv
c3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKaW5kZXggNzgzNzlmZmQyMzM2Li4yZjIx
Nzk4YTM3ZWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCisrKyBiL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCkBAIC0zODksNiArMzg5LDE0IEBAIHN0YXRpYyBib29sIHZob3N0X3ZkcGFf
Y2FuX3Jlc3VtZShjb25zdCBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKIAlyZXR1cm4gb3BzLT5yZXN1
bWU7CiB9CiAKK3N0YXRpYyBib29sIHZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3JvdXAoY29uc3Qgc3Ry
dWN0IHZob3N0X3ZkcGEgKnYpCit7CisJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRw
YTsKKwljb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7CisK
KwlyZXR1cm4gb3BzLT5nZXRfdnFfZGVzY19ncm91cDsKK30KKwogc3RhdGljIGxvbmcgdmhvc3Rf
dmRwYV9nZXRfZmVhdHVyZXMoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHU2NCBfX3VzZXIgKmZlYXR1
cmVwKQogewogCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7CkBAIC02OTAsNiAr
Njk4LDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmls
ZSAqZmlsZXAsCiAJCWlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMsIGZlYXR1cmVwLCBzaXpl
b2YoZmVhdHVyZXMpKSkKIAkJCXJldHVybiAtRUZBVUxUOwogCQlpZiAoZmVhdHVyZXMgJiB+KFZI
T1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJFUyB8CisJCQkJIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9G
X0RFU0NfQVNJRCkgfAogCQkJCSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSB8CiAJ
CQkJIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1JFU1VNRSkgfAogCQkJCSBCSVRfVUxMKFZIT1NU
X0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LKSkpCkBAIC03MDAsNiArNzA5LDEyIEBA
IHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVw
LAogCQlpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKSkgJiYK
IAkJICAgICAhdmhvc3RfdmRwYV9jYW5fcmVzdW1lKHYpKQogCQkJcmV0dXJuIC1FT1BOT1RTVVBQ
OworCQlpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lEKSkg
JiYKKwkJICAgICEoZmVhdHVyZXMgJiBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9BU0lE
KSkpCisJCQlyZXR1cm4gLUVJTlZBTDsKKwkJaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1Rf
QkFDS0VORF9GX0RFU0NfQVNJRCkpICYmCisJCSAgICAgIXZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3Jv
dXAodikpCisJCQlyZXR1cm4gLUVPUE5PVFNVUFA7CiAJCXZob3N0X3NldF9iYWNrZW5kX2ZlYXR1
cmVzKCZ2LT52ZGV2LCBmZWF0dXJlcyk7CiAJCXJldHVybiAwOwogCX0KQEAgLTc1Myw2ICs3Njgs
OCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpm
aWxlcCwKIAkJCWZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpOwog
CQlpZiAodmhvc3RfdmRwYV9jYW5fcmVzdW1lKHYpKQogCQkJZmVhdHVyZXMgfD0gQklUX1VMTChW
SE9TVF9CQUNLRU5EX0ZfUkVTVU1FKTsKKwkJaWYgKHZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3JvdXAo
dikpCisJCQlmZWF0dXJlcyB8PSBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQpOwog
CQlmZWF0dXJlcyB8PSB2aG9zdF92ZHBhX2dldF9iYWNrZW5kX2ZlYXR1cmVzKHYpOwogCQlpZiAo
Y29weV90b191c2VyKGZlYXR1cmVwLCAmZmVhdHVyZXMsIHNpemVvZihmZWF0dXJlcykpKQogCQkJ
ciA9IC1FRkFVTFQ7CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMu
aCBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oCmluZGV4IDJkODI3ZDIyY2Q5OS4u
MThhZDZhZTdhYjVjIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMu
aAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlwZXMuaApAQCAtMTg1LDUgKzE4NSwx
MCBAQCBzdHJ1Y3Qgdmhvc3RfdmRwYV9pb3ZhX3JhbmdlIHsKICAqIERSSVZFUl9PSwogICovCiAj
ZGVmaW5lIFZIT1NUX0JBQ0tFTkRfRl9FTkFCTEVfQUZURVJfRFJJVkVSX09LICAweDYKKy8qIERl
dmljZSBtYXkgZXhwb3NlIHRoZSB2aXJ0cXVldWUncyBkZXNjcmlwdG9yIGFyZWEsIGRyaXZlciBh
cmVhIGFuZAorICogZGV2aWNlIGFyZWEgdG8gYSBkaWZmZXJlbnQgZ3JvdXAgZm9yIEFTSUQgYmlu
ZGluZyB0aGFuIHdoZXJlIGl0cworICogYnVmZmVycyBtYXkgcmVzaWRlLiBSZXF1aXJlcyBWSE9T
VF9CQUNLRU5EX0ZfSU9UTEJfQVNJRC4KKyAqLworI2RlZmluZSBWSE9TVF9CQUNLRU5EX0ZfREVT
Q19BU0lEICAgIDB4NwogCiAjZW5kaWYKLS0gCjIuNDEuMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
