Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA68CD6E5A
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 11:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAF9441D6B;
	Wed, 11 Oct 2023 11:26:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAF9441D6B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l3YEz2pC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w5OqmllbXczJ; Wed, 11 Oct 2023 11:26:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7605F417CF;
	Wed, 11 Oct 2023 11:26:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7605F417CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C6A0C0DD6;
	Wed, 11 Oct 2023 11:25:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A16E1C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 11:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 541EC60BF7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 11:25:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 541EC60BF7
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=l3YEz2pC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-K6EU2eAV5R
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 11:25:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::616])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03F7E60E1D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 11:25:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03F7E60E1D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB9iYc42hTditvyMmypyTMzC4F68WvIW9nEKKdKgX5qmbBIETXDNLEEWa9vzGuh8DZeUhgQodprJtibHtA+NbYKe/60PNVI2a5wP6iHkYSzvZrg37SncDDUfBgldaNicyRH2RLg3Vexe4xW6bby0QEpxAInIjSy6AV2d8ehE2hzh9VAfgO81RKKMgnpzvyBAEgeL5fotxJ62tF9aNJcschlGfrJV4D2y0SSPLZjDOih2lOQnjWMPg8nkizZTez6OeQPmHI6yppTR7IOGIR+7zGC6c3/tBMP+Er9EuEP77qr1+cG0LVbe5v5+rZ1dnW0fFaFm71nvI5ISVFPlEt58IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKRYbL/mVXPTRzVdI6+ppF4u5YkiaQ9PlMCzbk1MX9I=;
 b=adLUrbxr80aBPcCixCZ19RGKTKEhbXZeJcHkr9Hm5QUTbil3zl8vNwcmplSSX+Lz3BtIoKA3I/hbP+SOAE2PpWoqsYHDV1kB3/n9k8MDOGvMB4u0wcoe1TuNRB0a/BrRbK+CTHnnIciSHd+sC80nUUo8CoR0xINKY4giHD4GTkPKnd4wCSewqB6DS2fw3lT7DQmvc1iil61qLU4RyHOqJC+tphwUKFuiq98n6Av7FRRgzUWi4MLrrVgTjziQLWUaYtdiztILF6q0/mczrLOvrSei/l7BvsSFRNMF6nqPfHdyEGGk7DB3YaDXcG3cq5+jtHRbFAdt3r0tGngBpeJEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKRYbL/mVXPTRzVdI6+ppF4u5YkiaQ9PlMCzbk1MX9I=;
 b=l3YEz2pCs+lkRyzc/U/FXRGfR84hOK4tZS8KKBFCDORbPmjJPhlBFC/UfGv34gWLNV13LG2YpKRZOJwxUSxpa4X0Gdzg5PbIaf2UbJIXvhI0PrlEP1ew/GGYohaQzPTm+sJURmA0nbbImyqqtzvLm6zrceDwwIq4a+1eF66oCIBPl3PdLGAa6hjTvgm35Dmny1nFjvbh7GAEzERiCTAjzEsTjwsfKJa9rNh6g5l0Y2z0X7fbz+Hi1pH5pFhGeH1pZoabGHp9DaCjLe6IZdtCj+YLTk7wGSoucgpMjzDJLBV8diZJ2n9sO+8GAwCU2I2lGxdndGW5ZtFVzo5ya4WILQ==
Received: from SN6PR05CA0028.namprd05.prod.outlook.com (2603:10b6:805:de::41)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 11:25:53 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::b) by SN6PR05CA0028.outlook.office365.com
 (2603:10b6:805:de::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Wed, 11 Oct 2023 11:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:25:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:25:39 -0700
Received: from [172.27.15.31] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:25:34 -0700
Message-ID: <3bd6e56a-d6c2-4e84-99ad-f30b57a96f39@nvidia.com>
Date: Wed, 11 Oct 2023 14:25:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
 <20231010115649-mutt-send-email-mst@kernel.org>
 <5d83d18a-0b5a-6221-e70d-32908d967715@nvidia.com>
 <20231010163914-mutt-send-email-mst@kernel.org>
 <f4247e59-19cd-0d6b-7728-dd1175c9d968@nvidia.com>
 <20231011035737-mutt-send-email-mst@kernel.org>
 <0ae3b963-f4fe-19c2-ea79-387a66e142ab@nvidia.com>
 <20231011050014-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231011050014-mutt-send-email-mst@kernel.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 6299f8c8-7198-471f-96b0-08dbca4cd423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wl93OgxIIhPXSfQJJRTVwdgTPLaoiryj9mLgaV9CaVVBdR/ZnIj+e536kyvGyiQdpZCWegNhr+AgBsK7UvCjfmUAitbGfWBZeJrmRjG5hto0KL+yuWf9Jf4q9UlaM8webLIxMRydUT0ecK7B5/mj7hJ2vVeDpatiKPn6Aty/TLVDfACnL0dQTpcJ33WHOq+1/URkqQLKGObYSquXM53odhDcLiJRaGobg3SEDnB83B4RQ3/ORhk+opCvohAG1vXE7HxXvxCEvUsDnYqdF6uq+9VLN7Pxmp8h5RNHBR+Kuzljd3gjc4Zt+7tX/QLV2yX/JgldnlO9BlhzrLe8+nXOxxhNzjV485ENTl5Jawa+3k/gtYQqWn52NKuxsy9QAz5Tfi6qdQF8shbkRlOvwP9L1Dp8xC3nzTBRUaD3Q1y3jtk9hPUFg+o+dWCYaNSOeYIo/2lqWrBxDVUvaeWULg+c2OBqJQdesLgH0RDJkC0e/Kllo7Y83PJE6Ud1lx13ofoolTjsfXxWkhlHZ33l8c9zgQ9DkNOSCNRTXYH1RieIEWsdjaWmfF/ISRKw5W7Hymzi1hqowSxxnwHR5jSMlrMukZ6IgF5S3bCxxbDy+7ll1/55dN4V5VmT6JcOBMe4+maNGxIUXo71p73TelG1YY6g3YR3g8q5312lE6T8+EnBliIPuxvG6v9xC1A/1DMnd5pyw/SGY6EcCZeltBJUJ6DhDz7jac8aojhkUYn0b7YfHnDfrpKc9bCbEs8H7Uyx4BpL4dCbjZgi4eCOpwh9noVCog==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(31696002)(356005)(86362001)(36756003)(7636003)(31686004)(66899024)(53546011)(40480700001)(6916009)(2906002)(41300700001)(478600001)(5660300002)(82740400003)(8936002)(4326008)(316002)(2616005)(336012)(47076005)(83380400001)(107886003)(426003)(40460700003)(16526019)(16576012)(70586007)(70206006)(8676002)(6666004)(54906003)(26005)(36860700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:25:52.6921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6299f8c8-7198-471f-96b0-08dbca4cd423
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 jiri@nvidia.com, leonro@nvidia.com
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

T24gMTEvMTAvMjAyMyAxMjowMywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFdlZCwg
T2N0IDExLCAyMDIzIGF0IDExOjU4OjExQU0gKzAzMDAsIFlpc2hhaSBIYWRhcyB3cm90ZToKPj4g
T24gMTEvMTAvMjAyMyAxMTowMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4gT24gV2Vk
LCBPY3QgMTEsIDIwMjMgYXQgMTA6NDQ6NDlBTSArMDMwMCwgWWlzaGFpIEhhZGFzIHdyb3RlOgo+
Pj4+IE9uIDEwLzEwLzIwMjMgMjM6NDIsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4g
T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMDc6MDk6MDhQTSArMDMwMCwgWWlzaGFpIEhhZGFzIHdy
b3RlOgo+Pj4+Pj4+PiBBc3N1bWluZyB0aGF0IHdlJ2xsIHB1dCBlYWNoIGNvbW1hbmQgaW5zaWRl
IHZpcnRpbyBhcyB0aGUgZ2VuZXJpYyBsYXllciwgd2UKPj4+Pj4+Pj4gd29uJ3QgYmUgYWJsZSB0
byBjYWxsL3VzZSB0aGlzIEFQSSBpbnRlcm5hbGx5IHRvIGdldCB0aGUgUEYgYXMgb2YgY3ljbGlj
Cj4+Pj4+Pj4+IGRlcGVuZGVuY2llcyBiZXR3ZWVuIHRoZSBtb2R1bGVzLCBsaW5rIHdpbGwgZmFp
bC4KPj4+Pj4gSSBqdXN0IG1lYW46Cj4+Pj4+IHZpcnRpb19hZG1pbl9sZWdhY3lfaW9fd3JpdGUo
c3J1Y3QgcGNpX2RldmljZSAqLCAgLi4uLikKPj4+Pj4KPj4+Pj4KPj4+Pj4gaW50ZXJuYWxseSBp
dCBzdGFydHMgZnJvbSB2ZiBnZXRzIHRoZSBwZiAob3IgdmYgaXRzZWxmIG9yIHdoYXRldmVyCj4+
Pj4+IHRoZSB0cmFuc3BvcnQgaXMpIHNlbmRzIGNvbW1hbmQgZ2V0cyBzdGF0dXMgcmV0dXJucy4K
Pj4+Pj4KPj4+Pj4gd2hhdCBpcyBjeWNsaWMgaGVyZT8KPj4+Pj4KPj4+PiB2aXJ0aW8tcGNpIGRl
cGVuZHMgb24gdmlydGlvIFsxXS4KPj4+Pgo+Pj4+IElmIHdlIHB1dCB0aGUgY29tbWFuZHMgaW4g
dGhlIGdlbmVyaWMgbGF5ZXIgYXMgd2UgZXhwZWN0IGl0IHRvIGJlIChpLmUuCj4+Pj4gdmlydGlv
KSwgdGhlbiB0cnlpbmcgdG8gY2FsbCBpbnRlcm5hbGx5IGNhbGwgZm9yIHZpcnRpb19wY2lfdmZf
Z2V0X3BmX2RldigpCj4+Pj4gdG8gZ2V0IHRoZSBQRiBmcm9tIHRoZSBWRiB3aWxsIGVuZC11cCBi
eSBhIGxpbmtlciBjeWNsaWMgZXJyb3IgYXMgb2YgYmVsb3cKPj4+PiBbMl0uCj4+Pj4KPj4+PiBB
cyBvZiB0aGF0LCBzb21lb25lIGNhbiBzdWdnZXN0IHRvIHB1dCB0aGUgY29tbWFuZHMgaW4gdmly
dGlvLXBjaSwgaG93ZXZlcgo+Pj4+IHRoaXMgd2lsbCBmdWxseSBieXBhc3MgdGhlIGdlbmVyaWMg
bGF5ZXIgb2YgdmlydGlvIGFuZCBmdXR1cmUgY2xpZW50cyB3b24ndAo+Pj4+IGJlIGFibGUgdG8g
dXNlIGl0Lgo+Pj4gdmlydGlvX3BjaSB3b3VsZCBnZXQgcGNpIGRldmljZS4KPj4+IHZpcnRpbyBw
Y2kgY29udmVycyB0aGF0IHRvIHZpcnRpbyBkZXZpY2Ugb2Ygb3duZXIgKyBncm91cCBtZW1iZXIg
aWQgYW5kIGNhbGxzIHZpcnRpby4KPj4gRG8geW91IHN1Z2dlc3QgYW5vdGhlciBzZXQgb2YgZXhw
b3J0ZWQgc3ltYm9scyAoaS5lIHBlciBjb21tYW5kICkgaW4gdmlydGlvCj4+IHdoaWNoIHdpbGwg
Z2V0IHRoZSBvd25lciBkZXZpY2UgKyBncm91cCBtZW1iZXIgKyB0aGUgZXh0cmEgc3BlY2lmaWMg
Y29tbWFuZAo+PiBwYXJhbWV0ZXJzID8KPj4KPj4gVGhpcyB3aWxsIGVuZC11cCBkdXBsaWNhdGlu
ZyB0aGUgbnVtYmVyIG9mIGV4cG9ydCBzeW1ib2xzIHBlciBjb21tYW5kLgo+IE9yIG1ha2UgdGhl
bSBpbmxpbmUuCj4gT3IgbWF5YmUgYWN0dWFsbHkgZXZlbiB0aGUgc3BlY2lmaWMgY29tbWFuZHMg
c2hvdWxkIGxpdmUgaW5zaWRlIHZpcnRpbyBwY2kKPiB0aGV5IGFyZSBwY2kgc3BlY2lmaWMgYWZ0
ZXIgYWxsLgoKT0ssIGxldCdzIGxlYXZlIHRoZW0gaW4gdmlydGlvLXBjaSBhcyB5b3Ugc3VnZ2Vz
dGVkIGhlcmUuCgpZb3UgY2FuIHNlZSBiZWxvdyBbMV0gc29tZSBzY2hlbWUgb2YgaG93IGEgc3Bl
Y2lmaWMgY29tbWFuZCB3aWxsIGxvb2sgbGlrZS4KCkZldyBub3RlczoKLSB2aXJ0aW9fcGNpX3Zm
X2dldF9wZl9kZXYoKSB3aWxsIGJlY29tZSBhIHN0YXRpYyBmdW5jdGlvbi4KCi0gVGhlIGNvbW1h
bmRzIHdpbGwgYmUgcGxhY2VkIGluc2lkZSB2aXJ0aW9fcGNpX2NvbW1vbi5jIGFuZCB3aWxsIHVz
ZSAKbG9jYWxseSB0aGUgYWJvdmUgc3RhdGljIGZ1bmN0aW9uIHRvIGdldCB0aGUgb3duZXIgUEYu
CgotIFBvc3Qgb2YgcHJlcGFyaW5nIHRoZSBjb21tYW5kIHdlIG1heSBjYWxsIGRpcmVjdGx5IHRv
IAp2cF9hdnFfY21kX2V4ZWMoKSB3aGljaCBpcyBwYXJ0IG9mIHZmaW8tcGNpIGFuZCBub3QgdG8g
dmlydGlvLgoKLSB2cF9hdnFfY21kX2V4ZWMoKSB3aWxsIGJlIHBhcnQgb2YgdmlydGlvX3BjaV9t
b2Rlcm4uYyBhcyB5b3UgYXNrZWQgaW4gCnRoZSBNTC4KCi0gVGhlIEFRIGNyZWF0aW9uL2Rlc3Ry
dWN0aW9uIHdpbGwgc3RpbGwgYmUgY2FsbGVkIHVwb24gcHJvYmluZyB2aXJ0aW8gCmFzIHdhcyBp
biBWMCwgaXQgd2lsbCB1c2UgdGhlIHVuZGVybGF5IGNvbmZpZy0+Y3JlYXRlL2Rlc3Ryb3lfYXZx
KCkgb3BzIAppZiBleGlzdC4KCi0gdmlydGlvX2FkbWluX2NtZF9leGVjKCkgd29uJ3QgYmUgZXhw
b3J0ZWQgYW55IG1vcmUgb3V0c2lkZSB2aXJ0aW8sIAp3ZSdsbCBoYXZlIGFuIGV4cG9ydGVkIHN5
bWJvbCBpbiB2aXJ0aW8tcGNpIHBlciBjb21tYW5kLgoKSXMgdGhlIGFib3ZlIGZpbmUgZm9yIHlv
dSA/CgpCeSB0aGUgd2F5LCBmcm9tIEFQSSBuYW1lc3BhY2UgUE9WLCBhcmUgeW91IGZpbmUgd2l0
aCAKdmlydGlvX2FkbWluX2xlZ2FjeV9pb193cml0ZSgpIG9yIG1heWJlIGxldCdzIGhhdmUgJ19w
Y2knIGFzIHBhcnQgb2YgdGhlIApuYW1lID8gKGkuZS4gdmlydGlvX3BjaV9hZG1pbl9sZWdhY3lf
aW9fd3JpdGUpCgpbMV0KCmludCB2aXJ0aW9fYWRtaW5fbGVnYWN5X2lvX3dyaXRlKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LCB1MTYgb3Bjb2RlLCB1OCAKb2Zmc2V0LAogwqDCoCDCoMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgdTggc2l6ZSwgdTggKmJ1ZikKewogwqDCoCDCoHN0cnVjdCB2aXJ0aW9fZGV2
aWNlICp2aXJ0aW9fZGV2ID0gdmlydGlvX3BjaV92Zl9nZXRfcGZfZGV2KHBkZXYpOwogwqDCoCDC
oHN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kX2xlZ2FjeV93cl9kYXRhICppbjsKIMKgwqAgwqBzdHJ1
Y3QgdmlydGlvX2FkbWluX2NtZCBjbWQgPSB7fTsKIMKgwqAgwqBzdHJ1Y3Qgc2NhdHRlcmxpc3Qg
aW5fc2c7CiDCoMKgIMKgaW50IHJldDsKIMKgwqAgwqBpbnQgdmZfaWQ7CgogwqDCoCDCoGlmICgh
dmlydGlvX2RldikKIMKgwqAgwqDCoMKgwqAgcmV0dXJuIC1FTk9ERVY7CgogwqDCoCDCoHZmX2lk
ID0gcGNpX2lvdl92Zl9pZChwZGV2KTsKIMKgwqAgwqBpZiAodmZfaWQgPCAwKQogwqDCoCDCoMKg
wqDCoCByZXR1cm4gLUVJTlZBTDsKCiDCoMKgIMKgaW4gPSBremFsbG9jKHNpemVvZigqaW4pICsg
c2l6ZSwgR0ZQX0tFUk5FTCk7CiDCoMKgIMKgaWYgKCFpbikKIMKgwqAgwqDCoMKgwqAgcmV0dXJu
IC1FTk9NRU07CgogwqDCoCDCoGluLT5vZmZzZXQgPSBvZmZzZXQ7CiDCoMKgIMKgbWVtY3B5KGlu
LT5yZWdpc3RlcnMsIGJ1Ziwgc2l6ZSk7CiDCoMKgIMKgc2dfaW5pdF9vbmUoJmluX3NnLCBpbiwg
c2l6ZW9mKCppbikgKyBzaXplKTsKIMKgwqAgwqBjbWQub3Bjb2RlID0gb3Bjb2RlOwogwqDCoCDC
oGNtZC5ncm91cF90eXBlID0gVklSVElPX0FETUlOX0dST1VQX1RZUEVfU1JJT1Y7CiDCoMKgIMKg
Y21kLmdyb3VwX21lbWJlcl9pZCA9IHZmX2lkICsgMTsKIMKgwqAgwqBjbWQuZGF0YV9zZyA9ICZp
bl9zZzsKIMKgwqAgwqByZXQgPSB2cF9hdnFfY21kX2V4ZWModmlydGlvX2RldiwgJmNtZCk7Cgog
wqDCoCDCoGtmcmVlKGluKTsKIMKgwqAgwqByZXR1cm4gcmV0Owp9IEVYUE9SVF9TWU1CT0xfR1BM
KHZpcnRpb19hZG1pbl9sZWdhY3lfaW9fd3JpdGUpOwoKPgo+Pj4gbm8gY3ljbGVzIGFuZCBtaW5p
bWFsIHRyYW5zcG9ydCBzcGVjaWZpYyBjb2RlLCByaWdodD8KPj4gU2VlIG15IGFib3ZlIG5vdGUs
IGlmIHdlIG1heSBqdXN0IGNhbGwgdmlydGlvIHdpdGhvdXQgYW55IGZ1cnRoZXIgd29yayBvbgo+
PiB0aGUgY29tbWFuZCdzIGlucHV0LCB0aGFuIFlFUy4KPj4KPj4gSWYgc28sIHZpcnRpbyB3aWxs
IHByZXBhcmUgdGhlIGNvbW1hbmQgYnkgc2V0dGluZyB0aGUgcmVsZXZhbnQgU0cgbGlzdHMgYW5k
Cj4+IG90aGVyIGRhdGEgYW5kIGZpbmFsbHkgd2lsbCBjYWxsOgo+Pgo+PiB2ZGV2LT5jb25maWct
PmV4ZWNfYWRtaW5fY21kKHZkZXYsIGNtZCk7Cj4+Cj4+IFdhcyB0aGF0IHlvdXIgcGxhbiA/Cj4g
aXMgdmRldiB0aGUgcGY/IHRoZW4gaXQgd29uJ3Qgc3VwcG9ydCB0aGUgdHJhbnNwb3J0IHdoZXJl
IGNvbW1hbmRzCj4gYXJlIHN1Ym1pdHRlZCB0aHJvdWdoIGJhcjAgb2YgdmYgaXRzZWxmLgoKWWVz
LCBpdCdzIGEgUEYuCkJhc2VkIG9uIGN1cnJlbnQgc3BlYyBmb3IgdGhlIGV4aXN0aW5nIGFkbWlu
IGNvbW1hbmRzIHdlIGlzc3VlIGNvbW1hbmRzIApvbmx5IG9uIHRoZSBQRi4KCkluIGFueSBjYXNl
LCBtb3ZpbmcgdG8gdGhlIGFib3ZlIHN1Z2dlc3RlZCBzY2hlbWUgdG8gaGFuZGxlIHBlciBjb21t
YW5kIAphbmQgdG8gZ2V0IHRoZSBWRiBQQ0kgYXMgdGhlIGZpcnN0IGFyZ3VtZW50IHdlIG5vdyBo
YXZlIGEgZnVsbCBjb250cm9sIApmb3IgYW55IGZ1dHVyZSBjb21tYW5kLgoKWWlzaGFpCgo+Pj4+
IEluIGFkZGl0aW9uLCBwYXNzaW5nIGluIHRoZSBWRiBQQ0kgcG9pbnRlciBpbnN0ZWFkIG9mIHRo
ZSBWRiBncm91cCBtZW1iZXIgSUQKPj4+PiArIHRoZSBWSVJUSU8gUEYgZGV2aWNlLCB3aWxsIHJl
cXVpcmUgaW4gdGhlIGZ1dHVyZSB0byBkdXBsaWNhdGUgZWFjaCBjb21tYW5kCj4+Pj4gb25jZSB3
ZSdsbCB1c2UgU0lPViBkZXZpY2VzLgo+Pj4gSSBkb24ndCB0aGluayBhbnlvbmUga25vd3MgaG93
IHdpbGwgU0lPViBsb29rLiBCdXQgc2h1ZmZsaW5nCj4+PiBBUElzIGFyb3VuZCBpcyBub3QgYSBi
aWcgZGVhbC4gV2UnbGwgc2VlLgo+PiBBcyB5b3UgYXJlIHRoZSBtYWludGFpbmVyIGl0J3MgdXAt
dG8teW91LCBqdXN0IG5lZWQgdG8gY29uc2lkZXIgYW5vdGhlcgo+PiBmdXJ0aGVyIGR1cGxpY2F0
aW9uIGhlcmUuCj4+Cj4+IFlpc2hhaQo+Pgo+Pj4+IEluc3RlYWQsIHdlIHN1Z2dlc3QgdGhlIGJl
bG93IEFQSSBmb3IgdGhlIGFib3ZlIGV4YW1wbGUuCj4+Pj4KPj4+PiB2aXJ0aW9fYWRtaW5fbGVn
YWN5X2lvX3dyaXRlKHZpcnRpb19kZXZpY2UgKnZpcnRpb19kZXYswqAgdTY0Cj4+Pj4gZ3JvdXBf
bWVtYmVyX2lkLMKgIC4uLi4pCj4+Pj4KPj4+PiBbMV0KPj4+PiBbeWlzaGFpaEByZWctbC12cnQt
MjA5IGxpbnV4XSQgbW9kaW5mbyB2aXJ0aW8tcGNpCj4+Pj4gZmlsZW5hbWU6IC9saWIvbW9kdWxl
cy82LjYuMC1yYzIrL2tlcm5lbC9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpLmtvCj4+Pj4gdmVy
c2lvbjrCoMKgwqDCoMKgwqDCoCAxCj4+Pj4gbGljZW5zZTrCoMKgwqDCoMKgwqDCoCBHUEwKPj4+
PiBkZXNjcmlwdGlvbjrCoMKgwqAgdmlydGlvLXBjaQo+Pj4+IGF1dGhvcjrCoMKgwqDCoMKgwqDC
oMKgIEFudGhvbnkgTGlndW9yaSA8YWxpZ3VvcmlAdXMuaWJtLmNvbT4KPj4+PiBzcmN2ZXJzaW9u
OsKgwqDCoMKgIDczNTVFQUM5NDA4RDM4ODkxOTM4MzkxCj4+Pj4gYWxpYXM6wqDCoMKgwqDCoMKg
wqDCoMKgIHBjaTp2MDAwMDFBRjRkKnN2KnNkKmJjKnNjKmkqCj4+Pj4gZGVwZW5kczogdmlydGlv
X3BjaV9tb2Rlcm5fZGV2LHZpcnRpbyx2aXJ0aW9fcmluZyx2aXJ0aW9fcGNpX2xlZ2FjeV9kZXYK
Pj4+PiByZXRwb2xpbmU6wqDCoMKgwqDCoCBZCj4+Pj4gaW50cmVlOsKgwqDCoMKgwqDCoMKgwqAg
WQo+Pj4+IG5hbWU6wqDCoMKgwqDCoMKgwqDCoMKgwqAgdmlydGlvX3BjaQo+Pj4+IHZlcm1hZ2lj
OsKgwqDCoMKgwqDCoCA2LjYuMC1yYzIrIFNNUCBwcmVlbXB0IG1vZF91bmxvYWQgbW9kdmVyc2lv
bnMKPj4+PiBwYXJtOsKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvcmNlX2xlZ2FjeTpGb3JjZSBsZWdh
Y3kgbW9kZSBmb3IgdHJhbnNpdGlvbmFsIHZpcnRpbyAxCj4+Pj4gZGV2aWNlcyAoYm9vbCkKPj4+
Pgo+Pj4+IFsyXQo+Pj4+Cj4+Pj4gZGVwbW9kOiBFUlJPUjogQ3ljbGUgZGV0ZWN0ZWQ6IHZpcnRp
byAtPiB2aXJ0aW9fcGNpIC0+IHZpcnRpbwo+Pj4+IGRlcG1vZDogRVJST1I6IEZvdW5kIDIgbW9k
dWxlcyBpbiBkZXBlbmRlbmN5IGN5Y2xlcyEKPj4+PiBtYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFr
ZWZpbGUubW9kaW5zdDoxMjg6IGRlcG1vZF0gRXJyb3IgMQo+Pj4+IG1ha2VbMV06ICoqKiBbL2lt
YWdlcy95aXNoYWloL3NyYy9rZXJuZWwvbGludXgvTWFrZWZpbGU6MTgyMToKPj4+PiBtb2R1bGVz
X2luc3RhbGxdIEVycm9yIDIKPj4+Pgo+Pj4+IFlpc2hhaQo+Pj4gdmlydGlvIGFic29sdXRlbHkg
bXVzdCBub3QgZGVwZW5kIG9uIHZpcnRpbyBwY2ksIGl0IGlzIHVzZWQgb24KPj4+IHN5c3RlbXMg
d2l0aG91dCBwY2kgYXQgYWxsLgo+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
