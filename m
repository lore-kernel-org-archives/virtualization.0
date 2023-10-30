Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2140EC4332F
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 16:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9FA4409AD;
	Mon, 30 Oct 2023 16:07:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9FA4409AD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DLEMAFk1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wJdnPShpKNdy; Mon, 30 Oct 2023 16:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 845D940995;
	Mon, 30 Oct 2023 16:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 845D940995
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E7CEC0071;
	Mon, 30 Oct 2023 16:07:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06903C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 16:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D38B940996
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 16:07:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D38B940996
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s2N4AeLtzek9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 16:07:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D849A40995
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 16:07:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D849A40995
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmZg9PW4YcyfdzXNX68tJ1Gsu59HrLxHPQMxfLLXOPzIYFyFggvCnRyZE/I8BexVlPUFWYQlcWwy0HXAbySFv39Yl1uaUj7Gnrc6NEMANwo+Hvkr4O07WLwMnHZiqK7wk8V2bjuJlUY7nP1KLzshjyL1Lc/3QiWltUipBGyEeoUx3lEdRq2jf2zfXwIOIrkFBBap9iMrQeIaKrDMnPBnktCx/CbCNV7H4xx6HZoilSOlougbeDTjOMqPT5Z5aguokoG6ELPBxbmReLfMpeXCpgvUcZy2wyTKHv5t+NnJHaOshJrUJx8sfJxYWS7BOqUj1F1rxcL35Zc9pQODOfiopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoAGjrdPrNIY/qGNNIUck3Q3G9HOqeWHGIFSUIeM0JY=;
 b=dmi90o8PL+lptR2u3rlcd+TtcDsi/okaTiKg6+KSGp9bwr4Z2bRuP3Aox+m8SE6EyiIei8PobBF0zOsQ3r71V/w6hl7r2DGTTj9cnxHoilUYdtX1IQnkytv0+u0RbCj4LV4uLzIAlfVk7HZzbj/2MKcuSBDKYWMqbtHm7BO0MWGBeVr781xt5fSvsg6XV+LkVeseCihRWFjhQZu8MCPKRhgBTdPubdTs4ttVhw8iP4L7trvtGGLAlIvK8Ay+s83e9WAhQtlElc3hWkgo7MGw48E9U0+9gziTkzRt/+sktRNKJGCI9Y5RL+6Z/4gPPTKiyjfzNlTrpTeHlcP5mf5hpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoAGjrdPrNIY/qGNNIUck3Q3G9HOqeWHGIFSUIeM0JY=;
 b=DLEMAFk1U6f1lCNh1SsWCPvubCrtabxheRmz4QdiA1of0YaIex5EgHp3x9c5Z5UW7h8LfuYHhrhrDBIXIZN2qFhi8kfIB1HNvEBqvXEPpT0l02EecbMtmHeD7KvyTcxw0rCrh0z2OHK+ZdjZuXk9+Jj1nZ8uc1SWC41NaqQQMgRFFqY1bVWSBk1vqE8AQLHvBHuN7iBigdFORXewzTPAIng5sUWlmBVik1KlHbmqvPUyZYWHaG6HP/1R6qcA9SljR3Xt9n0bruw7rq12djE8lkS1l3QtiH6xpfAjAMtYmEZBqf15TWuv0qINs4cZmGi1wZoE6q0flChto7EW5U5DBg==
Received: from BL1PR13CA0382.namprd13.prod.outlook.com (2603:10b6:208:2c0::27)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Mon, 30 Oct
 2023 16:07:13 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::e4) by BL1PR13CA0382.outlook.office365.com
 (2603:10b6:208:2c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.11 via Frontend
 Transport; Mon, 30 Oct 2023 16:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 16:07:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 09:06:52 -0700
Received: from [172.27.14.170] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 09:06:48 -0700
Message-ID: <4e95d66c-c382-4612-8d4b-7ff2b0acd3fb@nvidia.com>
Date: Mon, 30 Oct 2023 18:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 vfio 5/9] virtio-pci: Initialize the supported admin
 commands
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-6-yishaih@nvidia.com>
 <20231029160750-mutt-send-email-mst@kernel.org>
 <bb8df2c8-74b5-4666-beda-550248a88890@nvidia.com>
 <20231030115541-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231030115541-mutt-send-email-mst@kernel.org>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 6239e1ae-c3eb-4ccc-0757-08dbd96247a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GIAiELWGN8EcGW+8tpHL4Z/QFPnlaSjcz57WXYdMgPw6G24RoLQBEs/x5DFgOrE1p21iguYaM3cRd6jAOy7tdGGa9XzAiDXVwnepG7bjKYMU1JMUoy+Z6LHc6QRyx8av/hFCPqhNvm2Fw+kwmp5mXV0wAGz6oMRGyapTG9VBxEli4kLoXv9kyzuKCTLX8PWet14Nw0VM7OAr0ENBVqzSe7JTlNfhsVBwT83N3I8chKc0X8yrYYpPI2EjSaGJ6Qkt/GrPekubqf3tsaT6+IIkbbFxoMBRpJ5gWe/4MX50T67Dpq6iKhYL7R6ngLIVrNyndnfOwNbz43zJfMYsYxUu4fIJlKjng/u/quBzNzmQxNUNEeBRbG/xYZWR5NjihXBAvGorXOy1NUergWdUiK7ENZZBDTzVqtKMGF1XnhVMF3bMQTttxjcZyjt7xP01tQ/JXl6DV7WMSrdjb99O2mvnR+5n3CEOJMsZiQ+vCBSzC01ixnOXctTAqbeHLbs8pWw5ACSZT17vgcIBh46sgO57IVHBhfwffwPAMH295Hfc2HHXZGrodQaMymD/HtKH6dKAeV3wEbcwU+WNuam2P0W9qyfzeOvYDS/6zVP7fm5NAmQB5P/xPJX9laP5Y/lgDV+Bffs8Lf6iV0kvPSUyyFCn44XSxbblQ656z64X7bADZTos2QwzQlG69f0U+pkCtTI+yKbSSYjbNMnl20yfzCABKdiSbMSkzXtmR58voTfL7D96kbwcrM35c/SA+mi3r4ZEWB1NFdG3/SnpVbOEwMocQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(31696002)(8676002)(86362001)(8936002)(31686004)(4326008)(41300700001)(7636003)(5660300002)(2906002)(83380400001)(70206006)(54906003)(70586007)(6916009)(316002)(16576012)(336012)(426003)(356005)(16526019)(36860700001)(40480700001)(53546011)(6666004)(478600001)(40460700003)(47076005)(36756003)(2616005)(107886003)(82740400003)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:07:13.2980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6239e1ae-c3eb-4ccc-0757-08dbd96247a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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
From: Yishai Hadas via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Yishai Hadas <yishaih@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMzAvMTAvMjAyMyAxNzo1NywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIE1vbiwg
T2N0IDMwLCAyMDIzIGF0IDA1OjI3OjUwUE0gKzAyMDAsIFlpc2hhaSBIYWRhcyB3cm90ZToKPj4g
T24gMjkvMTAvMjAyMyAyMjoxNywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4gT24gU3Vu
LCBPY3QgMjksIDIwMjMgYXQgMDU6NTk6NDhQTSArMDIwMCwgWWlzaGFpIEhhZGFzIHdyb3RlOgo+
Pj4+IEluaXRpYWxpemUgdGhlIHN1cHBvcnRlZCBhZG1pbiBjb21tYW5kcyB1cG9uIGFjdGl2YXRp
bmcgdGhlIGFkbWluIHF1ZXVlLgo+Pj4+Cj4+Pj4gVGhlIHN1cHBvcnRlZCBjb21tYW5kcyBhcmUg
c2F2ZWQgYXMgcGFydCBvZiB0aGUgYWRtaW4gcXVldWUgY29udGV4dCwgaXQKPj4+PiB3aWxsIGJl
IHVzZWQgYnkgdGhlIG5leHQgcGF0Y2hlcyBmcm9tIHRoaXMgc2VyaWVzLgo+Pj4+Cj4+Pj4gTm90
ZToKPj4+PiBBcyB3ZSBkb24ndCB3YW50IHRvIGxldCB1cHBlciBsYXllcnMgdG8gZXhlY3V0ZSBh
ZG1pbiBjb21tYW5kcyBiZWZvcmUKPj4+PiB0aGF0IHRoaXMgaW5pdGlhbGl6YXRpb24gc3RlcCB3
YXMgY29tcGxldGVkLCB3ZSBzZXQgcmVmIGNvdW50IHRvIDEgb25seQo+Pj4+IHBvc3Qgb2YgdGhh
dCBmbG93IGFuZCB1c2UgYSBub24gcmVmIGNvdW50ZWQgdmVyc2lvbiBjb21tYW5kIGZvciB0aGlz
Cj4+Pj4gaW50ZXJuYWwgZmxvdy4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpc2hhaSBIYWRh
cyA8eWlzaGFpaEBudmlkaWEuY29tPgo+Pj4+IC0tLQo+Pj4+ICAgIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfY29tbW9uLmggfCAgMSArCj4+Pj4gICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9tb2Rlcm4uYyB8IDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+Pj4+ICAgIDIg
ZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmggYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5oCj4+Pj4gaW5kZXggYTIxYjliYTAxYTYwLi45ZTA3
ZTU1NmE1MWEgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21t
b24uaAo+Pj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmgKPj4+PiBA
QCAtNDYsNiArNDYsNyBAQCBzdHJ1Y3QgdmlydGlvX3BjaV9hZG1pbl92cSB7Cj4+Pj4gICAgCXN0
cnVjdCB2aXJ0aW9fcGNpX3ZxX2luZm8gaW5mbzsKPj4+PiAgICAJc3RydWN0IGNvbXBsZXRpb24g
Zmx1c2hfZG9uZTsKPj4+PiAgICAJcmVmY291bnRfdCByZWZjb3VudDsKPj4+PiArCXU2NCBzdXBw
b3J0ZWRfY21kczsKPj4+PiAgICAJLyogTmFtZSBvZiB0aGUgYWRtaW4gcXVldWU6IGF2cS4kaW5k
ZXguICovCj4+Pj4gICAgCWNoYXIgbmFtZVsxMF07Cj4+Pj4gICAgCXUxNiB2cV9pbmRleDsKPj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPj4+PiBpbmRleCBjY2Q3YTRkOWY1N2YuLjI1
ZTI3YWE3OWNhYiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21v
ZGVybi5jCj4+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+Pj4+
IEBAIC0xOSw2ICsxOSw5IEBACj4+Pj4gICAgI2RlZmluZSBWSVJUSU9fUklOR19OT19MRUdBQ1kK
Pj4+PiAgICAjaW5jbHVkZSAidmlydGlvX3BjaV9jb21tb24uaCIKPj4+PiArc3RhdGljIGludCB2
cF9tb2Rlcm5fYWRtaW5fY21kX2V4ZWMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4+Pj4g
KwkJCQkgICAgc3RydWN0IHZpcnRpb19hZG1pbl9jbWQgKmNtZCk7Cj4+Pj4gKwo+Pj4gSSBkb24n
dCBtdWNoIGxpa2UgZm9yd2FyZCBkZWNsYXJhdGlvbnMuIEp1c3Qgb3JkZXIgZnVuY3Rpb25zIHNl
bnNpYmx5Cj4+PiBhbmQgdGhleSB3aWxsIG5vdCBiZSBuZWVkZWQuCj4+IE9LLCB3aWxsIGJlIHBh
cnQgb2YgVjMuCj4+Cj4+Pj4gICAgc3RhdGljIHU2NCB2cF9nZXRfZmVhdHVyZXMoc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYpCj4+Pj4gICAgewo+Pj4+ICAgIAlzdHJ1Y3QgdmlydGlvX3BjaV9k
ZXZpY2UgKnZwX2RldiA9IHRvX3ZwX2RldmljZSh2ZGV2KTsKPj4+PiBAQCAtNTksNiArNjIsNDIg
QEAgdnBfbW9kZXJuX2F2cV9zZXRfYWJvcnQoc3RydWN0IHZpcnRpb19wY2lfYWRtaW5fdnEgKmFk
bWluX3ZxLCBib29sIGFib3J0KQo+Pj4+ICAgIAlXUklURV9PTkNFKGFkbWluX3ZxLT5hYm9ydCwg
YWJvcnQpOwo+Pj4+ICAgIH0KPj4+PiArc3RhdGljIHZvaWQgdmlydGlvX3BjaV9hZG1pbl9pbml0
X2NtZF9saXN0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2aXJ0aW9fZGV2KQo+Pj4+ICt7Cj4+Pj4g
KwlzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiA9IHRvX3ZwX2RldmljZSh2aXJ0aW9f
ZGV2KTsKPj4+PiArCXN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kIGNtZCA9IHt9Owo+Pj4+ICsJc3Ry
dWN0IHNjYXR0ZXJsaXN0IHJlc3VsdF9zZzsKPj4+PiArCXN0cnVjdCBzY2F0dGVybGlzdCBkYXRh
X3NnOwo+Pj4+ICsJX19sZTY0ICpkYXRhOwo+Pj4+ICsJaW50IHJldDsKPj4+PiArCj4+Pj4gKwlk
YXRhID0ga3phbGxvYyhzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsKPj4+PiArCWlmICghZGF0
YSkKPj4+PiArCQlyZXR1cm47Cj4+Pj4gKwo+Pj4+ICsJc2dfaW5pdF9vbmUoJnJlc3VsdF9zZywg
ZGF0YSwgc2l6ZW9mKCpkYXRhKSk7Cj4+Pj4gKwljbWQub3Bjb2RlID0gY3B1X3RvX2xlMTYoVklS
VElPX0FETUlOX0NNRF9MSVNUX1FVRVJZKTsKPj4+PiArCWNtZC5ncm91cF90eXBlID0gY3B1X3Rv
X2xlMTYoVklSVElPX0FETUlOX0dST1VQX1RZUEVfU1JJT1YpOwo+Pj4+ICsJY21kLnJlc3VsdF9z
ZyA9ICZyZXN1bHRfc2c7Cj4+Pj4gKwo+Pj4+ICsJcmV0ID0gdnBfbW9kZXJuX2FkbWluX2NtZF9l
eGVjKHZpcnRpb19kZXYsICZjbWQpOwo+Pj4+ICsJaWYgKHJldCkKPj4+PiArCQlnb3RvIGVuZDsK
Pj4+PiArCj4+Pj4gKwlzZ19pbml0X29uZSgmZGF0YV9zZywgZGF0YSwgc2l6ZW9mKCpkYXRhKSk7
Cj4+Pj4gKwljbWQub3Bjb2RlID0gY3B1X3RvX2xlMTYoVklSVElPX0FETUlOX0NNRF9MSVNUX1VT
RSk7Cj4+Pj4gKwljbWQuZGF0YV9zZyA9ICZkYXRhX3NnOwo+Pj4+ICsJY21kLnJlc3VsdF9zZyA9
IE5VTEw7Cj4+Pj4gKwo+Pj4+ICsJcmV0ID0gdnBfbW9kZXJuX2FkbWluX2NtZF9leGVjKHZpcnRp
b19kZXYsICZjbWQpOwo+Pj4+ICsJaWYgKHJldCkKPj4+PiArCQlnb3RvIGVuZDsKPj4+PiArCj4+
Pj4gKwl2cF9kZXYtPmFkbWluX3ZxLnN1cHBvcnRlZF9jbWRzID0gbGU2NF90b19jcHUoKmRhdGEp
Owo+Pj4+ICtlbmQ6Cj4+Pj4gKwlrZnJlZShkYXRhKTsKPj4+PiArfQo+Pj4+ICsKPj4+PiAgICBz
dGF0aWMgdm9pZCB2cF9tb2Rlcm5fYXZxX2FjdGl2YXRlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2
ZGV2KQo+Pj4+ICAgIHsKPj4+PiAgICAJc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYg
PSB0b192cF9kZXZpY2UodmRldik7Cj4+Pj4gQEAgLTY3LDYgKzEwNiw3IEBAIHN0YXRpYyB2b2lk
IHZwX21vZGVybl9hdnFfYWN0aXZhdGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+Pj4g
ICAgCWlmICghdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19GX0FETUlOX1ZRKSkKPj4+
PiAgICAJCXJldHVybjsKPj4+PiArCXZpcnRpb19wY2lfYWRtaW5faW5pdF9jbWRfbGlzdCh2ZGV2
KTsKPj4+PiAgICAJaW5pdF9jb21wbGV0aW9uKCZhZG1pbl92cS0+Zmx1c2hfZG9uZSk7Cj4+Pj4g
ICAgCXJlZmNvdW50X3NldCgmYWRtaW5fdnEtPnJlZmNvdW50LCAxKTsKPj4+PiAgICAJdnBfbW9k
ZXJuX2F2cV9zZXRfYWJvcnQoYWRtaW5fdnEsIGZhbHNlKTsKPj4+PiBAQCAtNTYyLDYgKzYwMiwz
NSBAQCBzdGF0aWMgYm9vbCB2cF9nZXRfc2htX3JlZ2lvbihzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldiwKPj4+PiAgICAJcmV0dXJuIHRydWU7Cj4+Pj4gICAgfQo+Pj4+ICtzdGF0aWMgaW50IF9f
dmlydHF1ZXVlX2V4ZWNfYWRtaW5fY21kKHN0cnVjdCB2aXJ0aW9fcGNpX2FkbWluX3ZxICphZG1p
bl92cSwKPj4+PiArCQkJCSAgICBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKipzZ3MsCj4+Pj4gKwkJCQkg
ICAgdW5zaWduZWQgaW50IG91dF9udW0sCj4+Pj4gKwkJCQkgICAgdW5zaWduZWQgaW50IGluX251
bSwKPj4+PiArCQkJCSAgICB2b2lkICpkYXRhLAo+Pj4+ICsJCQkJICAgIGdmcF90IGdmcCkKPj4+
PiArewo+Pj4+ICsJc3RydWN0IHZpcnRxdWV1ZSAqdnE7Cj4+Pj4gKwlpbnQgcmV0LCBsZW47Cj4+
Pj4gKwo+Pj4+ICsJdnEgPSBhZG1pbl92cS0+aW5mby52cTsKPj4+PiArCj4+Pj4gKwlyZXQgPSB2
aXJ0cXVldWVfYWRkX3Nncyh2cSwgc2dzLCBvdXRfbnVtLCBpbl9udW0sIGRhdGEsIGdmcCk7Cj4+
Pj4gKwlpZiAocmV0IDwgMCkKPj4+PiArCQlyZXR1cm4gcmV0Owo+Pj4+ICsKPj4+PiArCWlmICh1
bmxpa2VseSghdmlydHF1ZXVlX2tpY2sodnEpKSkKPj4+PiArCQlyZXR1cm4gLUVJTzsKPj4+PiAr
Cj4+Pj4gKwl3aGlsZSAoIXZpcnRxdWV1ZV9nZXRfYnVmKHZxLCAmbGVuKSAmJgo+Pj4+ICsJICAg
ICAgICF2aXJ0cXVldWVfaXNfYnJva2VuKHZxKSkKPj4+PiArCQljcHVfcmVsYXgoKTsKPj4+PiAr
Cj4+Pj4gKwlpZiAodmlydHF1ZXVlX2lzX2Jyb2tlbih2cSkpCj4+Pj4gKwkJcmV0dXJuIC1FSU87
Cj4+Pj4gKwo+Pj4+ICsJcmV0dXJuIDA7Cj4+Pj4gK30KPj4+PiArCj4+PiBUaGlzIGlzIHRvbGVy
YWJsZSBJIGd1ZXNzIGJ1dCBpdCBtaWdodCBwaW4gdGhlIENQVSBmb3IgYSBsb25nIHRpbWUuCj4+
PiBUaGUgZGlmZmljdWx0eSBpcyBoYW5kbGluZyBzdXByaXplIHJlbW92YWwgd2VsbCB3aGljaCB3
ZSBjdXJyZW50bHkKPj4+IGRvbid0IGRvIHdpdGggaW50ZXJydXB0cy4gSSB3b3VsZCBzYXkgaXQn
cyBvayBhcyBpcyBidXQgYWRkCj4+PiBhIFRPRE8gY29tbWVudHMgYWxvbmcgdGhlIGxpbmVzIG9m
IC8qIFRPRE86IHVzZSBpbnRlcnJ1cHRzIG9uY2UgdGhlc2UgdmlydHF1ZXVlX2lzX2Jyb2tlbiAq
Lwo+PiBJIGFzc3VtZSB0aGF0IHlvdSBhc2tlZCBmb3IgYWRkaW5nIHRoZSBiZWxvdyBjb21tZW50
IGJlZm9yZSB0aGUgd2hpbGUgbG9vcDoKPj4gLyogVE9ETyB1c2UgaW50ZXJydXB0cyB0byByZWR1
Y2UgY3B1IGN5Y2xlcyBpbiB0aGUgZnV0dXJlICovCj4+Cj4+IFJpZ2h0ID8KPj4KPj4gWWlzaGFp
Cj4gV2VsbCBJIHdyb3RlIHdoYXQgSSBtZWFudC4gaW4gdGhlIGZ1dHVyZSBpcyByZWR1bmRhbnQg
LSBldmVyeW9uZSBrbm93cwo+IHdlIGNhbid0IGNoYW5nZSB0aGUgcGFzdC4KCkkgYWdyZWUsIG5v
IG5lZWQgZm9yICdpbiB0aGUgZnV0dXJlJy4KCkhvd2V2ZXIsIGluIHlvdXIgc3VnZ2VzdGlvbiB5
b3UgbWVudGlvbmVkwqAgIm9uY2UgdGhlc2UgdmlydHF1ZXVlX2lzX2Jyb2tlbiIuCgpXaGF0IGRv
ZXMgdGhhdCBtZWFuIGluIGN1cnJlbnQgcG9sbGluZyBtb2RlID8KCllpc2hhaQoKPgo+Pj4+ICAg
IHN0YXRpYyBpbnQgdmlydHF1ZXVlX2V4ZWNfYWRtaW5fY21kKHN0cnVjdCB2aXJ0aW9fcGNpX2Fk
bWluX3ZxICphZG1pbl92cSwKPj4+PiAgICAJCQkJICAgIHN0cnVjdCBzY2F0dGVybGlzdCAqKnNn
cywKPj4+PiAgICAJCQkJICAgIHVuc2lnbmVkIGludCBvdXRfbnVtLAo+Pj4+IEBAIC02NTMsNyAr
NzIyLDEzIEBAIHN0YXRpYyBpbnQgdnBfbW9kZXJuX2FkbWluX2NtZF9leGVjKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2LAo+Pj4+ICAgIAkJaW5fbnVtKys7Cj4+Pj4gICAgCX0KPj4+PiAtCXJl
dCA9IHZpcnRxdWV1ZV9leGVjX2FkbWluX2NtZCgmdnBfZGV2LT5hZG1pbl92cSwgc2dzLAo+Pj4+
ICsJaWYgKGNtZC0+b3Bjb2RlID09IFZJUlRJT19BRE1JTl9DTURfTElTVF9RVUVSWSB8fAo+Pj4+
ICsJICAgIGNtZC0+b3Bjb2RlID09IFZJUlRJT19BRE1JTl9DTURfTElTVF9VU0UpCj4+Pj4gKwkJ
cmV0ID0gX192aXJ0cXVldWVfZXhlY19hZG1pbl9jbWQoJnZwX2Rldi0+YWRtaW5fdnEsIHNncywK
Pj4+PiArCQkJCSAgICAgICBvdXRfbnVtLCBpbl9udW0sCj4+Pj4gKwkJCQkgICAgICAgc2dzLCBH
RlBfS0VSTkVMKTsKPj4+PiArCWVsc2UKPj4+PiArCQlyZXQgPSB2aXJ0cXVldWVfZXhlY19hZG1p
bl9jbWQoJnZwX2Rldi0+YWRtaW5fdnEsIHNncywKPj4+PiAgICAJCQkJICAgICAgIG91dF9udW0s
IGluX251bSwKPj4+PiAgICAJCQkJICAgICAgIHNncywgR0ZQX0tFUk5FTCk7Cj4+Pj4gICAgCWlm
IChyZXQpIHsKPj4+PiAtLSAKPj4+PiAyLjI3LjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
