Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FEBE732F2
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 16:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4D7B6119A;
	Thu, 28 Sep 2023 16:49:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4D7B6119A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R/ssvQl7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E5eYVLHT-azJ; Thu, 28 Sep 2023 16:49:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 53E8A60B4C;
	Thu, 28 Sep 2023 16:49:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53E8A60B4C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30404C0071;
	Thu, 28 Sep 2023 16:49:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF858C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 864AB428E9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 864AB428E9
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=R/ssvQl7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VhVLxFr_K7Jq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C4EC428E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:49:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C4EC428E5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSbhbXzUlV0ef70enOM6b5s+aIdlAyUei0cCdbpWfWNTsl+zuujZTXh51T+p9elsJpTu9a/tqPJzgHtSzbuGSmR9PJmKbt79FVf8FZ29WqDiWdiChXT8nWVFHhEryUAVvcD1WEQoUAc+FygmutXevcTrXziK3qTgJiIJr30NhxzMV9FsYBM2T8Kh7A3i860M9TlpNxaKIp5ACmEoN3qy81DKIZOQMPIReJIN1SlPpAJ3a9j00TFPzo8zP10rq0D32+JHRjsWmTj4Xcktve/BH1DkkRMiJ2hUn/lFl9WEIRZOi7sqfH9suMDlcoxbCFtjeFur2WQ4cOuVtEOd3x7BIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILKog4btT16IMu9HXAHH95fAm+8LcOyK/4mzDrViAvI=;
 b=SrxpFqgpFNbAoyQoFI9VNKxnxAFWRoWIkowCN70n4wiXuxYAUULcep0JJ+nXfFdFyVqMe1KWzQRCMNoWew7Ga04BZLQOUbj63G1TtYrNMMwcDbWooLdWhOGF8zR4RX+qL5T1LvLc8sljieR18bTn1x+pZBN2zv0BQbXno8M4AfxiwVnlJMvipasowkFEENNGx36dSKwZXfpTI+b9uq6dihGibFEWzrRIrAYRwJ6PpQtQFPcKGcOap4Q6da6IcoVhtmC/Y+edAlFkMoikPKcZ+Sd0aoTAoyvNA5HUBtGZmb+aUhO5z/AapGFwKdUNJ8dVNiXjvhSOZzacIfiO91lyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILKog4btT16IMu9HXAHH95fAm+8LcOyK/4mzDrViAvI=;
 b=R/ssvQl7U7O+rKzpolGLdt7B++/mrp/DYGSWVGZqknhub6e3UFAbS0oVieJJ9dgWsSaxJPY9NO+MHjw4BNiQwTpsUPjx0k3w/0qux6b2IlLWju7/OXV0a58jYd5aHN++JYdZ/XpQ+y0BCDZ1bK0X2nrnZyKDhHOvBDjcYKiz0NTMH/Dg5xFucHOQWGtJpwPjOl2/RkUWEX9XA+qfLPowkC26tVjbiQKekzXql9IPXbmdkCmdFeQ+JooaK0rMAxXt78FyVZW/n1VwmMtlRznQiiZLugQ1z7zygUzVztBqUXQKFhlQhPW63InOC1SciBOHOoyDG/FLbOrzdXjxL4OEIQ==
Received: from MW3PR06CA0007.namprd06.prod.outlook.com (2603:10b6:303:2a::12)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 16:49:41 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:2a:cafe::ba) by MW3PR06CA0007.outlook.office365.com
 (2603:10b6:303:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:40 +0000
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
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:49:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:33 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:31 -0700
To: <eperezma@redhat.com>, <gal@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH vhost 03/16] vhost-vdpa: introduce descriptor group backend
 feature
Date: Thu, 28 Sep 2023 19:45:14 +0300
Message-ID: <20230928164550.980832-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cf670a-480e-4e43-b516-08dbc042e8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S99Teqc4zP9Pv5ViUGNESMcnYVwrrMgtuNN0QU/rransQ+H2Zi/bImHZqwxnMVytCObHpEL4aqVs8Y/5cjWHfmDaemMEECldyghzp3RKIkQA4K7Rt8bC+cpe3grtVULanXFDFNFXoU2xrn0+DS+x9GizH0niV9nbsaSEEFyUpIgVRd8hrshXgWROpdGj2ULEheDe0pwtwH8MRXO2+kGUoHWvzEuskMrXiIuHIsTQldhPQlNfsreifFa2RQSQ+MuccWOUEpWWlLYJTfilIuDdg+aSgrouCVuIcVzkhmT6sC5qnXzfLjHxrYd/xR5ibz2S6DDTFLQUasBkZJizDq7/jcQlCpOFzD0oNxPBMIPyMLtoFhq6t/elqt9Uk1eqZorh6SgbD3wzrIH0TTrfXjZ7K95N2hq14pOTAqSPQtffg7xBV0Ezkpjuxay9Xoni5vKeNnEVI9CrNR1TYeWw9mRDB4fKdbCjWy4rNRNzKYpGzgYNHsvNPE3hPSEseSorK2emgfcaX6QHR9wCR+aW8zYBtlo67N++GR0oWvJZK3BUh3bp/qLFjvnNPX3IJ/UUOxbc1j9fqzJrGyPSSLd/XiWvhluT+NuzjV2FLgEqzmfsFxT/RjuB+z2BIalxkl660gEyYdaQWN0KnzJzM2rhIiHtc8G4uH2ei8f30Wl4gu3omZmzkhiFaAjSoNdb17yc7vBaa1vg8zZTN3XoJePv4OX/9Lv8tzG7g5G1w/CzQlDTCNT3JW+70wmPMA+34GIUAyfE
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(6666004)(2616005)(1076003)(86362001)(110136005)(478600001)(70586007)(70206006)(54906003)(47076005)(36860700001)(336012)(82740400003)(426003)(66574015)(26005)(356005)(7636003)(83380400001)(36756003)(5660300002)(40480700001)(316002)(4326008)(41300700001)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:40.7961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cf670a-480e-4e43-b516-08dbc042e8c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
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
