Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B365CA0EC3
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 13:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1767415A9;
	Tue, 12 Sep 2023 13:02:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1767415A9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MhbQ1sNY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iRuFfzpdhL4B; Tue, 12 Sep 2023 13:02:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F264417CF;
	Tue, 12 Sep 2023 13:02:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F264417CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 803B5C0DD8;
	Tue, 12 Sep 2023 13:02:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4FB8C0071
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A850A417D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A850A417D5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RvQnfgsvq-tt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::615])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DF90415B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DF90415B1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKzit3GV868d3L5xHUpyvRKA3XHAHHVEDj6GZgw1vlprvqTO5qEkiWVDDeDLwwazPP7DA6OHOUPLzr0FlK1b+N7sLfWs3nivzp6OOQNO+9PCV6VfqK9dsLAZe9bKlTN7e3BtCShYkY+n+ZmDgR4YC9FctgnCLmUCif7J8/WMI5hmQLpd5NwZYxbYHJsvAGZcPmfSiu7tIiXFV/iEZIDMAW/zccqAeOA8ZiK5joIWWODJmE0m0fS2zHS8wUqTr4KSAJiKjr2cX28Gki4jJF6Dx2S/k4tRiS0zt/pitwv2MzGxrOw1V08u4fxFzpBoiEWi+smACyzihwskZIvfsuLD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILKog4btT16IMu9HXAHH95fAm+8LcOyK/4mzDrViAvI=;
 b=FleG3wx/Hqgb86ACdcsr/cljM2/X2HGjcVrO1UupUio6gLiD4lZg0go7/UA3pmHO7VrKqeSaMU2yFkMBrizad72BY6pSdC9wngBuWo7+w4v1OKophAsPkhObp1NoSwaCuDn2x/91usBmMDnBvBic23P9IWqAnTL0/AzLyTvjxlAWuSfsV2JKB7zYESMvGekdPz5khV8bgq/I5Si7hxe8+8GSBrNyp5RKGzJJdjeBYJW/Kq7WLX/uTyGNqQRAgFtKtLox8w7fUVoGUIkUVcmXOh9B1HgfCGH81iI0Vy1N7jGjiCEAirsQI0E+kUKH72d34lh/R32ZHDfG1fri4YFL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILKog4btT16IMu9HXAHH95fAm+8LcOyK/4mzDrViAvI=;
 b=MhbQ1sNYZxh/ME+pdyMeYEU0h0FZrrgphuNEKNH5Co9ESFoYRvO65HheYucgxgqvmnDbnJya0onJj5qnhujQtp1eOuwdxAKgsiwq7V1ypyrj30BPSW9uorqgj6ZONgzuZfZiti6B8vHFTbOj6fHbu1i6fS/uor9Nvg0E/O0ucqTEyH7xxDL2VnSfvrWz5A+1NlTcvUaqUt1HB0pj7xZpBHMMgvjEz1108yGyW9XdlCDJZeUCjh/XsWcyr0q0j6cJkCwUva1rk+Yce2+zeARt8SQVYJV5IiSs02iFJ0mAoFcsmmtFmWSrp9UN0/HQtYNoqC4XGszEz3NK3msD05EIAQ==
Received: from SA1P222CA0156.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::19)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 13:02:14 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::19) by SA1P222CA0156.outlook.office365.com
 (2603:10b6:806:3c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 13:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.16 via Frontend Transport; Tue, 12 Sep 2023 13:02:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 12 Sep 2023
 06:01:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 12 Sep
 2023 06:01:53 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Tue, 12 Sep 2023 06:01:50 -0700
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
 <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 <virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/16] vhost-vdpa: introduce descriptor group backend feature
Date: Tue, 12 Sep 2023 16:01:12 +0300
Message-ID: <20230912130132.561193-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912130132.561193-1-dtatulea@nvidia.com>
References: <20230912130132.561193-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: a0339d38-a04f-46dc-5fa9-08dbb3907c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imzE884gY0CmPpGIpp/Shmq1GnEFlr2VfNTl2BRbhlWwJHyVv76oKNPVMJFQbJGjaehIORrmkdxQHOSfLsItp5CYbcT6RO/K5mH7QmavyQyHgOF905UZn6LOzqLMw3hUsk14b+MDxbkWk7udPmWM/u4+l0uZ4/caRRAg9GnEXje1IsrGfIvJoMZXu7zZwmhN9rp2evFeynrHThoA8iy0To1TkndERFqJYsVX9hKGPMcoVYf38D0SLpY2gDeasBvegqpHbHlRBiq8LSYg22szdunbEIBCJ8SSeVq9WpGMxXl8JNdFviW+cA9CC72grFSr5uWFKld5FZAa83pB5tQo6dEjrsaqMiXaw4A67bhTpLL8FShHpy5l/8OqrPo9rWZBUkca/0IyiPJzIwu6k+vUveP4q0ZI4/FGbyQnyGH+O0usAb6hUG9GX+UmIKoMZS3OHT4zHSuZlrRoegEtJQxVusZhc2zuJjHhgTcm6jN+Hkfpwc2Daqzoqk6UCSUoNpRlID1SuDwxvkgnPrWpSlhWx8Ve6QfZsePHwqemcHu77rGscgDnB+4nKH/ZGFjpZTwDB4BrFJ5cSecANpkxDkLWU9ZxE8hfV15q022RibXyEEaDyRms+EQR+IUEK5wuelU/1fYYqeDE6Ye1su/f7wTO0NGPy6uOy1zQO2519gSOyOTJs9EOxdXrJOOpr5+QkBzywt74hN9hyWUDquG2XYeDH/3EjrhvyVZ2HjijGWE50VO0w/USKhBP636kDp2IqqPu
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(186009)(451199024)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(426003)(8676002)(2906002)(36756003)(86362001)(82740400003)(356005)(7636003)(5660300002)(40480700001)(4326008)(26005)(36860700001)(1076003)(8936002)(83380400001)(66574015)(47076005)(316002)(41300700001)(6666004)(336012)(2616005)(70586007)(478600001)(70206006)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:02:14.5200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0339d38-a04f-46dc-5fa9-08dbb3907c63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
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
