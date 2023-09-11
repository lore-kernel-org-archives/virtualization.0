Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D605CA0EC1
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 21:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85CAB418A1;
	Mon, 11 Sep 2023 21:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85CAB418A1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f3hwnXvK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VRL3Lg7ttZir; Mon, 11 Sep 2023 21:31:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C5BA4187D;
	Mon, 11 Sep 2023 21:31:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C5BA4187D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70D4AC0071;
	Mon, 11 Sep 2023 21:31:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3C1C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 21:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12437400FE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 21:31:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12437400FE
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=f3hwnXvK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SUkud2Mf1sWc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 21:31:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::608])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B22A5400F2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 21:31:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B22A5400F2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BixUlfvJW0ufmE4o6cKgjF/GmV6OcvGzs0dPvDMFmTpjngCLXD3Q8v+BJ7UEcIWzNDROV469QrTBKAx4KH1palFhVCkh/8yE2JTtwfOJ8d+4+Hup1SKFMijBJSuSs6IT3RCV7crTZMeE6d5aBNhC2lMC2iza750MDEaJaCTowewhJ5ggQscAvfF/EbgQikTFtDI7wbSNrh9+0xZILI8P5NelhdO3P5qyNz5sAEHNQkIG6TAAGPIC+S8oX5r0u6BlJ8p7SUT9Fpu7W4AngB8lSMspX7TPrWs675aACO53LTEvR26mqRNie7H+3Hr2vP83lq7BBp+bUxGnvBF9Tiv0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mkfu1o04vCr8kvLFl2xTueC5ioaW4YOYTn00cIw5cyU=;
 b=WtX/VXwGl7PQ1h5b2WK8fTjEjOj+EHri7pOMBmiA1XH7EI9uLHJpuVq+A8GTrz7rogGwbBNUZWvRR1v5dZ42HJYoiY9ChFy1Ej5Vh744WHeDmlfVkK9NRv+MH0RljxEBF5a9VJoMApXy5jKpKlXjOCEKmuVZmtuNIk7jNHwqkjRXpwxwgOfu1o0ksqQyZ878BVTtvKrEifByhXARc9VCelvQHwAuNbnb2HS/WWR7XnqYuVevkTwwnnpuYrj7/1R0eoiztqQxPNIFhwtbdyFS23yKWa3npVNDvddpLv7mBf8fFWbPs8Gt44lOOEuLttanoyIB9UjLdUxtNbS6uA1QwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkfu1o04vCr8kvLFl2xTueC5ioaW4YOYTn00cIw5cyU=;
 b=f3hwnXvKZug0wXkdtvwRQuB5pkVju6s9UCxw57NhdDn38cJTxriTjtYLDpyj8+m2kAaCtmsT+oR9ReZkq+dI48CYKq4fJFHnWI/+LHabUeuVPJfuPVz3zRwkd7bN2+X//s5xajzUUX3hjly5VMb3zb/SdTA7/3WE9u41t6UFPhQ=
Received: from MW4PR04CA0194.namprd04.prod.outlook.com (2603:10b6:303:86::19)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 21:31:27 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::f4) by MW4PR04CA0194.outlook.office365.com
 (2603:10b6:303:86::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 21:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.1 via Frontend Transport; Mon, 11 Sep 2023 21:31:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 16:31:25 -0500
To: <kuba@kernel.org>, <davem@davemloft.net>, <jasowang@redhat.com>,
 <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
 <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] virtio: kdoc for struct virtio_pci_modern_device
Date: Mon, 11 Sep 2023 14:31:04 -0700
Message-ID: <20230911213104.14391-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: c240b2d0-4c49-4c28-d77f-08dbb30e74e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqsnC0hVH3yrfx+tQ/NPp4cQomv/MkQx+9sf2KdiC+cbpkJNnTtouIXqbHVAZt4u6xW5A5miOdkrapUlGfimypvH1xzqmioOlQfTJZypvbnjvrZv0RI2tjWlMVG5Z+SFUOID8oOabVH4XM+QtEZz6kSOWvsfNCeObsYM/zXb10lHfXPUzgZErwZlUFBZiLtJJjsxs59XZoktIVOR8op397s+o9ARYCVh2u9hNTk7YxvGrEFubtbZOrUnGUFWFltcHw/0rXkwaKP0XCOUEGg5ziks8q2e5OUBxIT9SEV3v+KSZbNU+jcnS1Iu7FAeUIv0fRpv8aAEz8+SP9qpzSJeyyzmWtp7Vwe++/4deS2+xLRK3bs++UdotO6FkFjHDgkT/VCr1wb307rfFqPDFTwfZijVUZ8CELygHU/SWkjQ+2+Mkxgu5tIwyeMFmlQzbJnz5bl+LRXg4GrmBkz25lwiOanxueJS+UcEJyDWbjSjc6UHn+eN3Qh9OhpSXET96oWAsO3hMKqDm0DG3vmswKtmFIBbUAJC8hAPvKR+8RCD6hhDKhaPaumTYDBlKg6buCzGo0zgiGfbrYZbF2c7u2hsNRnEDmcHAtr/svusUqTdsmiEFjoC9wFBfNXQbAtHXRIR7VHSlB9ifGeAcAGbFwXWHCNLSOBG3eDkHhPymZrKOgmSXjZBg2IFRLPlPn18NnJiwnYGzaWL0p/dwclwVU8vXkE7+5BR5Q9Gb3oU6SwaKKuIDpqAAUOIaD/LUp7zkjBWLITJCeV7wdfqqjiYMstp4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(426003)(40460700003)(2906002)(336012)(83380400001)(1076003)(16526019)(26005)(36860700001)(66574015)(5660300002)(6666004)(2616005)(8676002)(47076005)(54906003)(316002)(4326008)(70206006)(110136005)(8936002)(44832011)(70586007)(41300700001)(478600001)(966005)(82740400003)(81166007)(356005)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 21:31:27.3457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c240b2d0-4c49-4c28-d77f-08dbb30e74e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
Cc: simon.horman@corigine.com, drivers@pensando.io, eperezma@redhat.com
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
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

RmluYWxseSBmb2xsb3dpbmcgdXAgdG8gU2ltb24ncyBzdWdnZXN0aW9uIGZvciBzb21lIGtkb2Mg
YXR0ZW50aW9uCm9uIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2UuCgpMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvWkUlMkZRUzBsblV2eEZhY2pmQGNvcmlnaW5lLmNv
bS8KQ2M6IFNpbW9uIEhvcm1hbiA8c2ltb24uaG9ybWFuQGNvcmlnaW5lLmNvbT4KU2lnbmVkLW9m
Zi1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24ubmVsc29uQGFtZC5jb20+CkFja2VkLWJ5OiBF
dWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L3Zp
cnRpb19wY2lfbW9kZXJuLmggfCAzNCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oIGIvaW5jbHVkZS9saW51eC92
aXJ0aW9fcGNpX21vZGVybi5oCmluZGV4IDA2N2FjMWQ3ODliYy4uYTM4YzcyOWQxOTczIDEwMDY0
NAotLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmgKKysrIGIvaW5jbHVkZS9s
aW51eC92aXJ0aW9fcGNpX21vZGVybi5oCkBAIC0xMiwzNyArMTIsNDcgQEAgc3RydWN0IHZpcnRp
b19wY2lfbW9kZXJuX2NvbW1vbl9jZmcgewogCV9fbGUxNiBxdWV1ZV9yZXNldDsJCS8qIHJlYWQt
d3JpdGUgKi8KIH07CiAKKy8qKgorICogc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSAt
IGluZm8gZm9yIG1vZGVybiBQQ0kgdmlydGlvCisgKiBAcGNpX2RldjoJICAgIFB0ciB0byB0aGUg
UENJIGRldmljZSBzdHJ1Y3QKKyAqIEBjb21tb246CSAgICBQb3NpdGlvbiBvZiB0aGUgY29tbW9u
IGNhcGFiaWxpdHkgaW4gdGhlIFBDSSBjb25maWcKKyAqIEBkZXZpY2U6CSAgICBEZXZpY2Utc3Bl
Y2lmaWMgZGF0YSAobm9uLWxlZ2FjeSBtb2RlKQorICogQG5vdGlmeV9iYXNlOiAgICBCYXNlIG9m
IHZxIG5vdGlmaWNhdGlvbnMgKG5vbi1sZWdhY3kgbW9kZSkKKyAqIEBub3RpZnlfcGE6CSAgICBQ
aHlzaWNhbCBiYXNlIG9mIHZxIG5vdGlmaWNhdGlvbnMKKyAqIEBpc3I6CSAgICBXaGVyZSB0byBy
ZWFkIGFuZCBjbGVhciBpbnRlcnJ1cHQKKyAqIEBub3RpZnlfbGVuOgkgICAgU28gd2UgY2FuIHNh
bml0eS1jaGVjayBhY2Nlc3NlcworICogQGRldmljZV9sZW46CSAgICBTbyB3ZSBjYW4gc2FuaXR5
LWNoZWNrIGFjY2Vzc2VzCisgKiBAbm90aWZ5X21hcF9jYXA6IENhcGFiaWxpdHkgZm9yIHdoZW4g
d2UgbmVlZCB0byBtYXAgbm90aWZpY2F0aW9ucyBwZXItdnEKKyAqIEBub3RpZnlfb2Zmc2V0X211
bHRpcGxpZXI6IE11bHRpcGx5IHF1ZXVlX25vdGlmeV9vZmYgYnkgdGhpcyB2YWx1ZQorICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKG5vbi1sZWdhY3kgbW9kZSkuCisgKiBAbW9kZXJuX2Jh
cnM6ICAgIEJpdG1hc2sgb2YgQkFScworICogQGlkOgkJICAgIERldmljZSBhbmQgdmVuZG9yIGlk
CisgKiBAZGV2aWNlX2lkX2NoZWNrOiBDYWxsYmFjayBkZWZpbmVkIGJlZm9yZSB2cF9tb2Rlcm5f
cHJvYmUoKSB0byBiZSB1c2VkIHRvCisgKgkJICAgIHZlcmlmeSB0aGUgUENJIGRldmljZSBpcyBh
IHZlbmRvcidzIGV4cGVjdGVkIGRldmljZSByYXRoZXIKKyAqCQkgICAgdGhhbiB0aGUgc3RhbmRh
cmQgdmlydGlvIFBDSSBkZXZpY2UKKyAqCQkgICAgUmV0dXJucyB0aGUgZm91bmQgZGV2aWNlIGlk
IG9yIEVSUk5PCisgKiBAZG1hX21hc2s6CSAgICBPcHRpb25hbCBtYXNrIGluc3RlYWQgb2YgdGhl
IHRyYWRpdGlvbmFsIERNQV9CSVRfTUFTSyg2NCksCisgKgkJICAgIGZvciB2ZW5kb3IgZGV2aWNl
cyB3aXRoIERNQSBzcGFjZSBhZGRyZXNzIGxpbWl0YXRpb25zCisgKi8KIHN0cnVjdCB2aXJ0aW9f
cGNpX21vZGVybl9kZXZpY2UgewogCXN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2OwogCiAJc3RydWN0
IHZpcnRpb19wY2lfY29tbW9uX2NmZyBfX2lvbWVtICpjb21tb247Ci0JLyogRGV2aWNlLXNwZWNp
ZmljIGRhdGEgKG5vbi1sZWdhY3kgbW9kZSkgICovCiAJdm9pZCBfX2lvbWVtICpkZXZpY2U7Ci0J
LyogQmFzZSBvZiB2cSBub3RpZmljYXRpb25zIChub24tbGVnYWN5IG1vZGUpLiAqLwogCXZvaWQg
X19pb21lbSAqbm90aWZ5X2Jhc2U7Ci0JLyogUGh5c2ljYWwgYmFzZSBvZiB2cSBub3RpZmljYXRp
b25zICovCiAJcmVzb3VyY2Vfc2l6ZV90IG5vdGlmeV9wYTsKLQkvKiBXaGVyZSB0byByZWFkIGFu
ZCBjbGVhciBpbnRlcnJ1cHQgKi8KIAl1OCBfX2lvbWVtICppc3I7CiAKLQkvKiBTbyB3ZSBjYW4g
c2FuaXR5LWNoZWNrIGFjY2Vzc2VzLiAqLwogCXNpemVfdCBub3RpZnlfbGVuOwogCXNpemVfdCBk
ZXZpY2VfbGVuOwogCi0JLyogQ2FwYWJpbGl0eSBmb3Igd2hlbiB3ZSBuZWVkIHRvIG1hcCBub3Rp
ZmljYXRpb25zIHBlci12cS4gKi8KIAlpbnQgbm90aWZ5X21hcF9jYXA7CiAKLQkvKiBNdWx0aXBs
eSBxdWV1ZV9ub3RpZnlfb2ZmIGJ5IHRoaXMgdmFsdWUuIChub24tbGVnYWN5IG1vZGUpLiAqLwog
CXUzMiBub3RpZnlfb2Zmc2V0X211bHRpcGxpZXI7Ci0KIAlpbnQgbW9kZXJuX2JhcnM7Ci0KIAlz
dHJ1Y3QgdmlydGlvX2RldmljZV9pZCBpZDsKIAotCS8qIG9wdGlvbmFsIGNoZWNrIGZvciB2ZW5k
b3IgdmlydGlvIGRldmljZSwgcmV0dXJucyBkZXZfaWQgb3IgLUVSUk5PICovCiAJaW50ICgqZGV2
aWNlX2lkX2NoZWNrKShzdHJ1Y3QgcGNpX2RldiAqcGRldik7Ci0KLQkvKiBvcHRpb25hbCBtYXNr
IGZvciBkZXZpY2VzIHdpdGggbGltaXRlZCBETUEgc3BhY2UgKi8KIAl1NjQgZG1hX21hc2s7CiB9
OwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
