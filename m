Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65173C41513
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEA6982CAC;
	Wed, 18 Oct 2023 17:16:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEA6982CAC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=InGIHWcY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lHmdWTaXTJ8p; Wed, 18 Oct 2023 17:16:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3753682C4D;
	Wed, 18 Oct 2023 17:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3753682C4D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14C3EC0039;
	Wed, 18 Oct 2023 17:16:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5453CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22D3682C4D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22D3682C4D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mYcScngnf0QC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4801D82C7C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:16:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4801D82C7C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj+rARdtwp+7+AS7q0gsnEM7x6jV28yYYxzfxgOqv+3BLduCa3u+1lHjyhG3//I77pp3PF1zEwuKrJaH5i3RVnSk4yzUcC+tyRAfnkr+gDDgKluPEWmhgAQn4z+wRrKiHxBJ98/6RR9XvCaHaqi+o8M7m9SRadoRaB0AO8ZfncMwXrWURxFjRRO9TvlX7JE3dicME6d2AVILB2LvVAXMMkE15BTJ5zOJfAI/qs7MeOGlK+0iNiUNf6pwQ9gqJXyVwkuYqshGljhmhLoE526D08aEIZV6uRvFu1MWRR6CSjTSX8Lbpopvt1m5ov41oeCRfpQaedWf92n9k6kMbBj+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILKog4btT16IMu9HXAHH95fAm+8LcOyK/4mzDrViAvI=;
 b=KawsJdcxemMZiWwqT8Qd5a6nUVhd60FhQiJuuNG0bpmmUeJPA5pvEiS1/ZCSNsJ7EpfdJoxAyCWLP+AG9ATLjwF+Xf+AQr8LtUyjmLf+Uu0BCpSHXY09jS5MMLfVWotN7oJX9hoI2Eu4gfoG/25p7x4+4wl1I+26KX5P7iqI6JoKo0mktb1qcp5YlO76zs8KCl8IBsdtr/fXTlRHief6xmQ7xi95uag9wpm2JmHrMYH4eQlCkKJWFUfgUGQS/MxMJ+vUV6d3TpBSY6Lt9H/mm/jh71olwjpHn2/Glypn+MuiRTO0tC2vFuNQdhXG3PqaOiBcm8ql8+H2BF7GxUaHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILKog4btT16IMu9HXAHH95fAm+8LcOyK/4mzDrViAvI=;
 b=InGIHWcYhkZD3T9eUB9/N5njheGFShSXpwrFfviZzFtfOzbYH1ReyM1U2Uvk0CUunTOdpTi7/+B0+hLthT2TEBVfST6+ABJuJ4ijHVqhvLbJqFnyDKd6cIh4oLlEDXlMiey4OuVM6sVTAsjzT+AsPpRWfOyY+0FU1+gb2yQStNZDvS79y0PJkm/nAgLHQKbuIThQaiilBj3uZqj/JadXBi74lybKEiQAH/BT9YOQun+YPlKSG4u257FKlaC6Pl143bVLXlsq7taFyjgOYFn5ETxc22vUl2+t8eWdx6/po8ygjYBID4zEt3OqkVEInpuIPFEG3G1LY1L4OZ7/DbkzPQ==
Received: from SJ2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:a03:505::25)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:15:57 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::ac) by SJ2PR07CA0002.outlook.office365.com
 (2603:10b6:a03:505::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 17:15:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 10:15:37 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Wed, 18 Oct 2023 10:15:34 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH vhost v4 03/16] vhost-vdpa: introduce descriptor group backend
 feature
Date: Wed, 18 Oct 2023 20:14:42 +0300
Message-ID: <20231018171456.1624030-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 9baee8f1-9f7e-4277-8785-08dbcffde4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWm1V7o39YwSWK+uHNaqLyxEh4EbQaw1XmxinJNGTLo6+LeXt6NiT2tWbysJj7CXJEai3glQLlZVF9p+5eetmgoFaAuYm1Adyaowpjs6yta077Pxe6VWJHJgoYQhvcXrF/lfRT6pU/VrxcZtwhebRTQeHGvTuzfLw1aZiAFDQx1SIb99swzCSVrJq+9SFcHJL+KawtqrRFvPd6qvGI27b8ISPcN3XknagZM28Xk3fZH8jQas7opMVCuuAJNFiKDCGr7kqfreKT/G8NV4s0nkt7ik1on0tUZQv1JeHMnvw6+mF29nr7286Ee9HP0bgY6OjovQTbqSuyq54DjP/iyoPtcerqtjjIw6GUEM2aK7pdFWri51YVtYXXvfyq7iFQqboauIY1Y//DMNhGBzofOU3XHaL6ngoEIno0UXqNRXEJ4Bqd3eB07kxL3ZWLnDF26MO9LlZQAidrLc/pnlUWod3A/nE8h4QmhGJOc44qdgznmjSUV2J8wEIAwgrmIDNGGPHn6FWO9oNMVeGifIgdOvfy71gqNj49krBsz8uWhf2IY9R3FBNq9aFiTkni5fh/PniGWfnVlgFm8cQqR4q7Gf8T6gYiEoLSL/ezjqmmwZuipmUaC1j1f8RvNFwMvtk2NSXiZMbs9kTbOGB/XdtfBVjMLlL9fIC99JjvLQtuj6lfBr3kkiKnPJgEel70LcYzYZGQ4+z9Wa3T6BXwOXy8l/iI9EMAyS45KzvaiSKi3Iczq/JWGQqINzJm35xeCku/g+
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(5660300002)(66574015)(336012)(426003)(83380400001)(82740400003)(6666004)(356005)(7636003)(1076003)(26005)(2616005)(478600001)(36860700001)(47076005)(54906003)(70586007)(70206006)(110136005)(4326008)(41300700001)(8676002)(40460700003)(316002)(40480700001)(86362001)(2906002)(8936002)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:15:57.3214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baee8f1-9f7e-4277-8785-08dbcffde4c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
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
