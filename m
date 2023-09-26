Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB46EED611
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 11:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D42AB4091F;
	Tue, 26 Sep 2023 11:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D42AB4091F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AWWeL1W2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfhSG3XCuCgS; Tue, 26 Sep 2023 11:14:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F92D40873;
	Tue, 26 Sep 2023 11:14:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F92D40873
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34F3DC0071;
	Tue, 26 Sep 2023 11:14:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42321C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19100605E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:14:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19100605E0
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=AWWeL1W2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NfvhmYFK4kfE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:14:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C239F605B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:14:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C239F605B1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcXAGDN6NnwUtLhuDJFzJl3gZu3w4Y+03xOrL4/s8z12tAGNPBMaVF1p6GhrL7ye7jo4M5q6SujGBY+YodeNGGkxUCB5AsSz2bF6Y+UtcnWH9DZJcpieCYcKgl+/h9pHH8Id9iZnqSZiVpPvaQ84WN/LUxiLtAMw6BRAlYwXG+cH3eOdcI75GB1mlPZC+t+Ra1ubv3E3dwJzhpFyFZh8zaDppiMZ7hIr0n7/2bsYz4CrjmNUGY0MUkK7X1HDBBm3L3qsFVOp4CzSJyED7Yvdz7skrQ3X2iqiQZoE5aw6kQGq7ecw8qZuMWbzjsOZWJuW+cUOixvU2EbepssIPQy2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL9GakccGJxJF6Kd236M0en00zFcN1koXsW5TfbJsWM=;
 b=NTEoCDBIgz2uqHZKRlwQXVaoB03bnylBH2gO5dzGXkJppqQH47BoB2Vs6xXnd1AJ+1YbLsfVTkNUExeb7AZIKnVEuzxQ5gZgLgq7QuxGwdVglMPeOB2GuXK4RviJ2V13wlV0A1HM5ixSQSllVU9YgNGsCVE9XnkpYyR288MGDCiX0gdXLgwqYbr7+K4PVc5ZM2w7fdPsQAwSqjGBRkOHk9Kb1nDM8JpPcq6lFzax9ciYcoDOXVFpPhgv4H6/ysBvtSDVbP0s+RrPhyE8sa/4coGCsBL8UmBAqcJwGkck/NM+6u4mCCGVG5PmBo95QU/8yz7nWU1k9U1aieJIJvK8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL9GakccGJxJF6Kd236M0en00zFcN1koXsW5TfbJsWM=;
 b=AWWeL1W2lYQ1x3gFRjOe1NIH7l3mEPJBejYF7zjXj8FXb+jduFtZ/XvBTTmplmK5TH4zqQu57XOTWg13G9S9FsxKqTKGhfRZ9ljFto6uHJeFyt75xFTpIPCCAA1kulzdUunuyT7FwaX83X+xCsQJ6lohx4xekjArxvVUYyDowwGRuSB5Z8Ex0BLdCQ+LKGwdSd7b2n6kYgGwIMfKnStxDcBI6hDV5aqFEL+ZeO/ity3Cog3aApez6l806rvs1ctIe5DhMrMf40XfqfT8qWhiur8+1A8pFwS/X2fk04J4KxbtJkgySvAJpelTc4E+UuPKl3g31UYxkWRUuLgjxQgvTQ==
Received: from BL0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:2d::19)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Tue, 26 Sep
 2023 11:14:24 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::39) by BL0PR03CA0006.outlook.office365.com
 (2603:10b6:208:2d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 11:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 11:14:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 04:14:07 -0700
Received: from [172.27.13.90] (10.126.231.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 04:14:03 -0700
Message-ID: <c3724e2f-7938-abf7-6aea-02bfb3881151@nvidia.com>
Date: Tue, 26 Sep 2023 14:14:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-11-yishaih@nvidia.com>
 <20230922055336-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230922055336-mutt-send-email-mst@kernel.org>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7b7945-f824-4cc6-ea95-08dbbe81bdca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6t8YCNpbU23fvoh23q/8mBZN1II5KPIJmWPbTHI1Z8922TEZeOr+SThDN0Tw5PyucSkb10NwcI7T8fv9Wj4LxzU68TpozrNmwSQpDNarMcELtNOkmBkhCR9dyeUY4S7zso9knJof4TB1T8IlE912Jky4MBeB/5Eh7BuZu9W/PRlSGrEQ49qGCLRV8rxNTd4OmY2XL2O4Glw90VOG8mGtfasIpSaFR8MhnKCB8Xxggvaldsj+W7tXA2CCFVwKI33OQvaO+hJdxR7oIs6zhW2stueanC8ukkUjxY929VjWcbd1iIQf/aOOZMTPPFYBW/WKq1HG9DIXbz94TThfnxng0BhCjw8RVe6Y8/9sjbDIJYub5digZt0gKh4R9VP2gKmU6jxlugktbyfbVr4RVXSqZQk282cUDbw61vZm0E0HcjTIUnv+jEol2+hXXeVFMyIszLIKi1R3oHEisaP2vOXFKnsSySeUEzsSiG40smxUw3W+IG+ZzV0Tp7xiRWgiEUUyxrDhC+p0dvT8Z8ibK1mhVQIw9LbQefhGynHeuNCVkJI08yPZhe1yUgjpcSsZ/Ehd7VPaxYbt216rXRAbQP4J/buOQyhRpXrFrv2dz8VrrOOSVv+lPj1T8NJZkgan5baXa40k9Z9+JBgNYxu5+xu0aB+GWX0qsdbOa7pGKbRsFiKKO6QDr7F1E7V8eZ8Nm5KPZHEL83m6N0T6ILNgZkRakS5hvQbh295TnK2erM/VN6eWVZ5VwdVIrXF5KBKYVY6Thmwu8o5t02myDgnbj91dzIOhsh6IaerKXCWcdTHsdb8O9QEkmxWE/d3/raqqpCRR
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(53546011)(478600001)(83380400001)(8676002)(70586007)(70206006)(54906003)(31686004)(966005)(8936002)(16576012)(6916009)(316002)(356005)(16526019)(36756003)(5660300002)(107886003)(40460700003)(26005)(2616005)(4326008)(36860700001)(31696002)(82740400003)(426003)(40480700001)(86362001)(47076005)(336012)(41300700001)(2906002)(7636003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 11:14:24.5432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7b7945-f824-4cc6-ea95-08dbbe81bdca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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

T24gMjIvMDkvMjAyMyAxMjo1NCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFRodSwg
U2VwIDIxLCAyMDIzIGF0IDAzOjQwOjM5UE0gKzAzMDAsIFlpc2hhaSBIYWRhcyB3cm90ZToKPj4g
RXhwb3NlIGFkbWluIGNvbW1hbmRzIG92ZXIgdGhlIHZpcnRpbyBkZXZpY2UsIHRvIGJlIHVzZWQg
YnkgdGhlCj4+IHZmaW8tdmlydGlvIGRyaXZlciBpbiB0aGUgbmV4dCBwYXRjaGVzLgo+Pgo+PiBJ
dCBpbmNsdWRlczogbGlzdCBxdWVyeS91c2UsIGxlZ2FjeSB3cml0ZS9yZWFkLCByZWFkIG5vdGlm
eV9pbmZvLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBZaXNoYWkgSGFkYXMgPHlpc2hhaWhAbnZpZGlh
LmNvbT4KPgo+IFRoaXMgc3R1ZmYgaXMgcHVyZSB2aXJ0aW8gc3BlYy4gSSB0aGluayBpdCBzaG91
bGQgbGl2ZSB1bmRlcgo+IGRyaXZlcnMvdmlydGlvLCB0b28uCgpUaGUgbW90aXZhdGlvbiB0byBw
dXQgaXQgaW4gdGhlIHZmaW8gbGF5ZXIgd2FzIGZyb20gdGhlIGJlbG93IG1haW4gcmVhc29uczoK
CjEpIEhhdmluZyBpdCBpbnNpZGUgdmlydGlvIG1heSByZXF1aXJlIHRvIGV4cG9ydCBhIHN5bWJv
bC9mdW5jdGlvbiBwZXIgCmNvbW1hbmQuCgogwqDCoCBUaGlzIHdpbGwgZW5kIHVwIHRvZGF5IGJ5
IDUgYW5kIGluIHRoZSBmdXR1cmUgKGUuZy4gbGl2ZSBtaWdyYXRpb24pIAp3aXRoIG11Y2ggbW9y
ZSBleHBvcnRlZCBzeW1ib2xzLgoKIMKgwqAgV2l0aCBjdXJyZW50IGNvZGUgd2UgZXhwb3J0IG9u
bHkgMiBnZW5lcmljIHN5bWJvbHMgCnZpcnRpb19wY2lfdmZfZ2V0X3BmX2RldigpLCB2aXJ0aW9f
YWRtaW5fY21kX2V4ZWMoKSB3aGljaCBtYXkgZml0IGZvciAKYW55IGZ1cnRoZXIgZXh0ZW5zaW9u
LgoKMikgRm9yIG5vdyB0aGVyZSBpcyBubyBsb2dpYyBpbiB0aGlzIHZmaW8gbGF5ZXIsIGhvd2V2
ZXIsIGluIHRoZSBmdXR1cmUgCndlIG1heSBoYXZlIHNvbWUgRE1BL290aGVyIGxvZ2ljIHRoYXQg
c2hvdWxkIGJldHRlciBmaXQgdG8gdGhlIApjYWxsZXIvY2xpZW50IGxheWVyIChpLmUuIHZmaW8p
LgoKQnkgdGhlIHdheSwgdGhpcyBmb2xsb3dzIHdoYXQgd2FzIGRvbmUgYWxyZWFkeSBiZXR3ZWVu
IHZmaW8vbWx4NSB0byAKbWx4NV9jb3JlIG1vZHVsZXMgd2hlcmUgbWx4NV9jb3JlIGV4cG9zZXMg
Z2VuZXJpYyBBUElzIHRvIGV4ZWN1dGUgYSAKY29tbWFuZCBhbmQgdG8gZ2V0IHRoZSBhIFBGIGZy
b20gYSBnaXZlbiBtbHg1IFZGLgoKVGhpcyB3YXksIHdlIGNhbiBlbmFibGUgZnVydGhlciBjb21t
YW5kcyB0byBiZSBhZGRlZC9leHRlbmRlZCAKZWFzaWx5L2NsZWFubHkuCgpTZWUgZm9yIGV4YW1w
bGUgaGVyZSBbMSwgMl0uCgpbMV0gCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2
LjYtcmMzL3NvdXJjZS9kcml2ZXJzL3ZmaW8vcGNpL21seDUvY21kLmMjTDIxMAoKWzJdIApodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni42LXJjMy9zb3VyY2UvZHJpdmVycy92Zmlv
L3BjaS9tbHg1L2NtZC5jI0w2ODMKCllpc2hhaQoKPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZmaW8v
cGNpL3ZpcnRpby9jbWQuYyB8IDE0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Cj4+ICAgZHJpdmVycy92ZmlvL3BjaS92aXJ0aW8vY21kLmggfCAgMjcgKysrKysrKwo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMTczIGluc2VydGlvbnMoKykKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy92ZmlvL3BjaS92aXJ0aW8vY21kLmMKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy92ZmlvL3BjaS92aXJ0aW8vY21kLmgKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmZp
by9wY2kvdmlydGlvL2NtZC5jIGIvZHJpdmVycy92ZmlvL3BjaS92aXJ0aW8vY21kLmMKPj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mMDY4MjM5Y2RiYjAKPj4g
LS0tIC9kZXYvbnVsbAo+PiArKysgYi9kcml2ZXJzL3ZmaW8vcGNpL3ZpcnRpby9jbWQuYwo+PiBA
QCAtMCwwICsxLDE0NiBAQAo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAg
T1IgTGludXgtT3BlbklCCj4+ICsvKgo+PiArICogQ29weXJpZ2h0IChjKSAyMDIzLCBOVklESUEg
Q09SUE9SQVRJT04gJiBBRkZJTElBVEVTLiBBbGwgcmlnaHRzIHJlc2VydmVkCj4+ICsgKi8KPj4g
Kwo+PiArI2luY2x1ZGUgImNtZC5oIgo+PiArCj4+ICtpbnQgdmlydGlvdmZfY21kX2xpc3RfcXVl
cnkoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHU4ICpidWYsIGludCBidWZfc2l6ZSkKPj4gK3sKPj4g
KwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmlydGlvX2RldiA9IHZpcnRpb19wY2lfdmZfZ2V0X3Bm
X2RldihwZGV2KTsKPj4gKwlzdHJ1Y3Qgc2NhdHRlcmxpc3Qgb3V0X3NnOwo+PiArCXN0cnVjdCB2
aXJ0aW9fYWRtaW5fY21kIGNtZCA9IHt9Owo+PiArCj4+ICsJaWYgKCF2aXJ0aW9fZGV2KQo+PiAr
CQlyZXR1cm4gLUVOT1RDT05OOwo+PiArCj4+ICsJc2dfaW5pdF9vbmUoJm91dF9zZywgYnVmLCBi
dWZfc2l6ZSk7Cj4+ICsJY21kLm9wY29kZSA9IFZJUlRJT19BRE1JTl9DTURfTElTVF9RVUVSWTsK
Pj4gKwljbWQuZ3JvdXBfdHlwZSA9IFZJUlRJT19BRE1JTl9HUk9VUF9UWVBFX1NSSU9WOwo+PiAr
CWNtZC5yZXN1bHRfc2cgPSAmb3V0X3NnOwo+PiArCj4+ICsJcmV0dXJuIHZpcnRpb19hZG1pbl9j
bWRfZXhlYyh2aXJ0aW9fZGV2LCAmY21kKTsKPj4gK30KPj4gKwo+PiAraW50IHZpcnRpb3ZmX2Nt
ZF9saXN0X3VzZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgdTggKmJ1ZiwgaW50IGJ1Zl9zaXplKQo+
PiArewo+PiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2aXJ0aW9fZGV2ID0gdmlydGlvX3BjaV92
Zl9nZXRfcGZfZGV2KHBkZXYpOwo+PiArCXN0cnVjdCBzY2F0dGVybGlzdCBpbl9zZzsKPj4gKwlz
dHJ1Y3QgdmlydGlvX2FkbWluX2NtZCBjbWQgPSB7fTsKPj4gKwo+PiArCWlmICghdmlydGlvX2Rl
dikKPj4gKwkJcmV0dXJuIC1FTk9UQ09OTjsKPj4gKwo+PiArCXNnX2luaXRfb25lKCZpbl9zZywg
YnVmLCBidWZfc2l6ZSk7Cj4+ICsJY21kLm9wY29kZSA9IFZJUlRJT19BRE1JTl9DTURfTElTVF9V
U0U7Cj4+ICsJY21kLmdyb3VwX3R5cGUgPSBWSVJUSU9fQURNSU5fR1JPVVBfVFlQRV9TUklPVjsK
Pj4gKwljbWQuZGF0YV9zZyA9ICZpbl9zZzsKPj4gKwo+PiArCXJldHVybiB2aXJ0aW9fYWRtaW5f
Y21kX2V4ZWModmlydGlvX2RldiwgJmNtZCk7Cj4+ICt9Cj4+ICsKPj4gK2ludCB2aXJ0aW92Zl9j
bWRfbHJfd3JpdGUoc3RydWN0IHZpcnRpb3ZmX3BjaV9jb3JlX2RldmljZSAqdmlydHZkZXYsIHUx
NiBvcGNvZGUsCj4+ICsJCQkgIHU4IG9mZnNldCwgdTggc2l6ZSwgdTggKmJ1ZikKPj4gK3sKPj4g
KwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmlydGlvX2RldiA9Cj4+ICsJCXZpcnRpb19wY2lfdmZf
Z2V0X3BmX2Rldih2aXJ0dmRldi0+Y29yZV9kZXZpY2UucGRldik7Cj4+ICsJc3RydWN0IHZpcnRp
b19hZG1pbl9jbWRfZGF0YV9scl93cml0ZSAqaW47Cj4+ICsJc3RydWN0IHNjYXR0ZXJsaXN0IGlu
X3NnOwo+PiArCXN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kIGNtZCA9IHt9Owo+PiArCWludCByZXQ7
Cj4+ICsKPj4gKwlpZiAoIXZpcnRpb19kZXYpCj4+ICsJCXJldHVybiAtRU5PVENPTk47Cj4+ICsK
Pj4gKwlpbiA9IGt6YWxsb2Moc2l6ZW9mKCppbikgKyBzaXplLCBHRlBfS0VSTkVMKTsKPj4gKwlp
ZiAoIWluKQo+PiArCQlyZXR1cm4gLUVOT01FTTsKPj4gKwo+PiArCWluLT5vZmZzZXQgPSBvZmZz
ZXQ7Cj4+ICsJbWVtY3B5KGluLT5yZWdpc3RlcnMsIGJ1Ziwgc2l6ZSk7Cj4+ICsJc2dfaW5pdF9v
bmUoJmluX3NnLCBpbiwgc2l6ZW9mKCppbikgKyBzaXplKTsKPj4gKwljbWQub3Bjb2RlID0gb3Bj
b2RlOwo+PiArCWNtZC5ncm91cF90eXBlID0gVklSVElPX0FETUlOX0dST1VQX1RZUEVfU1JJT1Y7
Cj4+ICsJY21kLmdyb3VwX21lbWJlcl9pZCA9IHZpcnR2ZGV2LT52Zl9pZCArIDE7Cj4+ICsJY21k
LmRhdGFfc2cgPSAmaW5fc2c7Cj4+ICsJcmV0ID0gdmlydGlvX2FkbWluX2NtZF9leGVjKHZpcnRp
b19kZXYsICZjbWQpOwo+PiArCj4+ICsJa2ZyZWUoaW4pOwo+PiArCXJldHVybiByZXQ7Cj4+ICt9
Cj4+ICsKPj4gK2ludCB2aXJ0aW92Zl9jbWRfbHJfcmVhZChzdHJ1Y3QgdmlydGlvdmZfcGNpX2Nv
cmVfZGV2aWNlICp2aXJ0dmRldiwgdTE2IG9wY29kZSwKPj4gKwkJCSB1OCBvZmZzZXQsIHU4IHNp
emUsIHU4ICpidWYpCj4+ICt7Cj4+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZpcnRpb19kZXYg
PQo+PiArCQl2aXJ0aW9fcGNpX3ZmX2dldF9wZl9kZXYodmlydHZkZXYtPmNvcmVfZGV2aWNlLnBk
ZXYpOwo+PiArCXN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kX2RhdGFfbHJfcmVhZCAqaW47Cj4+ICsJ
c3RydWN0IHNjYXR0ZXJsaXN0IGluX3NnLCBvdXRfc2c7Cj4+ICsJc3RydWN0IHZpcnRpb19hZG1p
bl9jbWQgY21kID0ge307Cj4+ICsJaW50IHJldDsKPj4gKwo+PiArCWlmICghdmlydGlvX2RldikK
Pj4gKwkJcmV0dXJuIC1FTk9UQ09OTjsKPj4gKwo+PiArCWluID0ga3phbGxvYyhzaXplb2YoKmlu
KSwgR0ZQX0tFUk5FTCk7Cj4+ICsJaWYgKCFpbikKPj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4+ICsK
Pj4gKwlpbi0+b2Zmc2V0ID0gb2Zmc2V0Owo+PiArCXNnX2luaXRfb25lKCZpbl9zZywgaW4sIHNp
emVvZigqaW4pKTsKPj4gKwlzZ19pbml0X29uZSgmb3V0X3NnLCBidWYsIHNpemUpOwo+PiArCWNt
ZC5vcGNvZGUgPSBvcGNvZGU7Cj4+ICsJY21kLmdyb3VwX3R5cGUgPSBWSVJUSU9fQURNSU5fR1JP
VVBfVFlQRV9TUklPVjsKPj4gKwljbWQuZGF0YV9zZyA9ICZpbl9zZzsKPj4gKwljbWQucmVzdWx0
X3NnID0gJm91dF9zZzsKPj4gKwljbWQuZ3JvdXBfbWVtYmVyX2lkID0gdmlydHZkZXYtPnZmX2lk
ICsgMTsKPj4gKwlyZXQgPSB2aXJ0aW9fYWRtaW5fY21kX2V4ZWModmlydGlvX2RldiwgJmNtZCk7
Cj4+ICsKPj4gKwlrZnJlZShpbik7Cj4+ICsJcmV0dXJuIHJldDsKPj4gK30KPj4gKwo+PiAraW50
IHZpcnRpb3ZmX2NtZF9scV9yZWFkX25vdGlmeShzdHJ1Y3QgdmlydGlvdmZfcGNpX2NvcmVfZGV2
aWNlICp2aXJ0dmRldiwKPj4gKwkJCQl1OCByZXFfYmFyX2ZsYWdzLCB1OCAqYmFyLCB1NjQgKmJh
cl9vZmZzZXQpCj4+ICt7Cj4+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZpcnRpb19kZXYgPQo+
PiArCQl2aXJ0aW9fcGNpX3ZmX2dldF9wZl9kZXYodmlydHZkZXYtPmNvcmVfZGV2aWNlLnBkZXYp
Owo+PiArCXN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kX25vdGlmeV9pbmZvX3Jlc3VsdCAqb3V0Owo+
PiArCXN0cnVjdCBzY2F0dGVybGlzdCBvdXRfc2c7Cj4+ICsJc3RydWN0IHZpcnRpb19hZG1pbl9j
bWQgY21kID0ge307Cj4+ICsJaW50IHJldDsKPj4gKwo+PiArCWlmICghdmlydGlvX2RldikKPj4g
KwkJcmV0dXJuIC1FTk9UQ09OTjsKPj4gKwo+PiArCW91dCA9IGt6YWxsb2Moc2l6ZW9mKCpvdXQp
LCBHRlBfS0VSTkVMKTsKPj4gKwlpZiAoIW91dCkKPj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4+ICsK
Pj4gKwlzZ19pbml0X29uZSgmb3V0X3NnLCBvdXQsIHNpemVvZigqb3V0KSk7Cj4+ICsJY21kLm9w
Y29kZSA9IFZJUlRJT19BRE1JTl9DTURfTEVHQUNZX05PVElGWV9JTkZPOwo+PiArCWNtZC5ncm91
cF90eXBlID0gVklSVElPX0FETUlOX0dST1VQX1RZUEVfU1JJT1Y7Cj4+ICsJY21kLnJlc3VsdF9z
ZyA9ICZvdXRfc2c7Cj4+ICsJY21kLmdyb3VwX21lbWJlcl9pZCA9IHZpcnR2ZGV2LT52Zl9pZCAr
IDE7Cj4+ICsJcmV0ID0gdmlydGlvX2FkbWluX2NtZF9leGVjKHZpcnRpb19kZXYsICZjbWQpOwo+
PiArCWlmICghcmV0KSB7Cj4+ICsJCXN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kX25vdGlmeV9pbmZv
X2RhdGEgKmVudHJ5Owo+PiArCQlpbnQgaTsKPj4gKwo+PiArCQlyZXQgPSAtRU5PRU5UOwo+PiAr
CQlmb3IgKGkgPSAwOyBpIDwgVklSVElPX0FETUlOX0NNRF9NQVhfTk9USUZZX0lORk87IGkrKykg
ewo+PiArCQkJZW50cnkgPSAmb3V0LT5lbnRyaWVzW2ldOwo+PiArCQkJaWYgKGVudHJ5LT5mbGFn
cyA9PSBWSVJUSU9fQURNSU5fQ01EX05PVElGWV9JTkZPX0ZMQUdTX0VORCkKPj4gKwkJCQlicmVh
azsKPj4gKwkJCWlmIChlbnRyeS0+ZmxhZ3MgIT0gcmVxX2Jhcl9mbGFncykKPj4gKwkJCQljb250
aW51ZTsKPj4gKwkJCSpiYXIgPSBlbnRyeS0+YmFyOwo+PiArCQkJKmJhcl9vZmZzZXQgPSBsZTY0
X3RvX2NwdShlbnRyeS0+b2Zmc2V0KTsKPj4gKwkJCXJldCA9IDA7Cj4+ICsJCQlicmVhazsKPj4g
KwkJfQo+PiArCX0KPj4gKwo+PiArCWtmcmVlKG91dCk7Cj4+ICsJcmV0dXJuIHJldDsKPj4gK30K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmZpby9wY2kvdmlydGlvL2NtZC5oIGIvZHJpdmVycy92
ZmlvL3BjaS92aXJ0aW8vY21kLmgKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAw
MDAwMDAwMDAwLi5jMmEzNjQ1ZjRiOTAKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9kcml2ZXJz
L3ZmaW8vcGNpL3ZpcnRpby9jbWQuaAo+PiBAQCAtMCwwICsxLDI3IEBACj4+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBMaW51eC1PcGVuSUIKPj4gKy8qCj4+ICsgKiBD
b3B5cmlnaHQgKGMpIDIwMjMsIE5WSURJQSBDT1JQT1JBVElPTiAmIEFGRklMSUFURVMuIEFsbCBy
aWdodHMgcmVzZXJ2ZWQuCj4+ICsgKi8KPj4gKwo+PiArI2lmbmRlZiBWSVJUSU9fVkZJT19DTURf
SAo+PiArI2RlZmluZSBWSVJUSU9fVkZJT19DTURfSAo+PiArCj4+ICsjaW5jbHVkZSA8bGludXgv
a2VybmVsLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvLmg+Cj4+ICsjaW5jbHVkZSA8bGlu
dXgvdmZpb19wY2lfY29yZS5oPgo+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19wY2kuaD4KPj4g
Kwo+PiArc3RydWN0IHZpcnRpb3ZmX3BjaV9jb3JlX2RldmljZSB7Cj4+ICsJc3RydWN0IHZmaW9f
cGNpX2NvcmVfZGV2aWNlIGNvcmVfZGV2aWNlOwo+PiArCWludCB2Zl9pZDsKPj4gK307Cj4+ICsK
Pj4gK2ludCB2aXJ0aW92Zl9jbWRfbGlzdF9xdWVyeShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgdTgg
KmJ1ZiwgaW50IGJ1Zl9zaXplKTsKPj4gK2ludCB2aXJ0aW92Zl9jbWRfbGlzdF91c2Uoc3RydWN0
IHBjaV9kZXYgKnBkZXYsIHU4ICpidWYsIGludCBidWZfc2l6ZSk7Cj4+ICtpbnQgdmlydGlvdmZf
Y21kX2xyX3dyaXRlKHN0cnVjdCB2aXJ0aW92Zl9wY2lfY29yZV9kZXZpY2UgKnZpcnR2ZGV2LCB1
MTYgb3Bjb2RlLAo+PiArCQkJICB1OCBvZmZzZXQsIHU4IHNpemUsIHU4ICpidWYpOwo+PiAraW50
IHZpcnRpb3ZmX2NtZF9scl9yZWFkKHN0cnVjdCB2aXJ0aW92Zl9wY2lfY29yZV9kZXZpY2UgKnZp
cnR2ZGV2LCB1MTYgb3Bjb2RlLAo+PiArCQkJIHU4IG9mZnNldCwgdTggc2l6ZSwgdTggKmJ1Zik7
Cj4+ICtpbnQgdmlydGlvdmZfY21kX2xxX3JlYWRfbm90aWZ5KHN0cnVjdCB2aXJ0aW92Zl9wY2lf
Y29yZV9kZXZpY2UgKnZpcnR2ZGV2LAo+PiArCQkJCXU4IHJlcV9iYXJfZmxhZ3MsIHU4ICpiYXIs
IHU2NCAqYmFyX29mZnNldCk7Cj4+ICsjZW5kaWYgLyogVklSVElPX1ZGSU9fQ01EX0ggKi8KPj4g
LS0gCj4+IDIuMjcuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
