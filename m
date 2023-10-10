Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C6CCD8CA6
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 16:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F194613AD;
	Tue, 10 Oct 2023 16:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F194613AD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KOy8QsZP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fm4HbOQMTj1J; Tue, 10 Oct 2023 16:09:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E67B613B4;
	Tue, 10 Oct 2023 16:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E67B613B4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57978C0039;
	Tue, 10 Oct 2023 16:09:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 839B9C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E2D1613B4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:09:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E2D1613B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TdI6XEu4rH19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:09:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::618])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60BBB613AD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:09:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60BBB613AD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbIILN+8Qgn3NjlnGKQQ1csrVVdyWWzwm/xWG8mSo4wTs3ZwMCrdLXXgvDUOiDQ8SyfZqvOvZhn1TE93id8/Vl3gge7ovjqvH2ZZA41c/UNhWPbUIeL8oG/lU0DSn7K9aXPwoW61kf+7y55ik64c7WPp8RbP9z4TfrdizaPcWTPMIoP1mgqX03Kkmng8JGRoGGexz8cMVcsTy8sQahPgPFv6NclPjlMJCOVtkuaoRX/UjggIzP2KWbe7jUl1Wr6QkvalHF5I9g4nfM0a43JXNOWx1c+0voVZQujZGFu2/87lMWPNiSuSIrSzNxFYSA23x304zh8OgNOLv/MNx6diuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b5TLYVRx31fXlYEAb4BE403qP8kBxVWZki7gpf7ofY=;
 b=Q53uAerDI8uyoN8tgrtGjqta2avyd9NtmkDYOwpvKU30VM0Wi3gTGhtZtwc2OAE9yVqwQyRjM6q7rsAFE/ExAB82U1HlzUZeHdsLL4/sEOTCdwewPtrC9NJPhePtDrPWzo7hSv8k6+BvrRDr8H4hRb6q0VgGuNzhqV3kcViMX1ZA+zlLLZdbdG6zsPeFc6ezu2RfN9OKHfRvmqOuNKE0mhj4pD0rFsVnFTrxqEOGaX3YSUlT06E13KcSPcqlqvGm3+Gvdemi0EzGra26GmI8LwRqeNZ12IoimwI9bzBE+z5QZuz+TYS5p2DVU/BjSjn/ZmWkmD/uaK+2gIfr98Rkvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b5TLYVRx31fXlYEAb4BE403qP8kBxVWZki7gpf7ofY=;
 b=KOy8QsZPzS9If5sCu6CbXN7vTBM5yiK+OLuw5jTpUgdrwSKZj5YCMSLuznLupUsAucA0bM8E1HWNHP8UPPZyb8V8hJq4RnX3ssvBC9AVSd/Znpw/4VPg++kDRU4djh5wSn3+d4ScvR9eJI0B9tdKju28c0AK8SWKbl62yPRahA2R0PWSdeCXIdQtXQ0vUW/xQSteynWtQtEYS+ObIZLKTi9zrE+Fbsy8YqUCPU/CTbHdX6NprxkawtXnqsclFLGyiCC9n2QV971M1Sqdv8vybIZpCLXkUsSt2gg+l7VP6bEQbkIWI0+Uxl6siEOIosEo/B+WNjrKSdB4DmSH9F9iuQ==
Received: from AM0PR07CA0027.eurprd07.prod.outlook.com (2603:10a6:208:ac::40)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 16:09:42 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10a6:208:ac:cafe::95) by AM0PR07CA0027.outlook.office365.com
 (2603:10a6:208:ac::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Tue, 10 Oct 2023 16:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 16:09:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 09:09:21 -0700
Received: from [172.27.14.100] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 09:09:17 -0700
Message-ID: <5d83d18a-0b5a-6221-e70d-32908d967715@nvidia.com>
Date: Tue, 10 Oct 2023 19:09:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com> <ZSAG9cedvh+B0c0E@infradead.org>
 <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
 <20231010115649-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231010115649-mutt-send-email-mst@kernel.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1f24ab-ed0a-4c2a-e4d7-08dbc9ab4ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6rFdb3/nox7trbkgXbwgVdtVHsiU6Tqae8OLA+R8cD1Ek7qZPVGFYxmdq9XV4NQYwy2/Pz0NJvSpp8dM/7m8gCZ9dlz0AoJjbCm3zL4jC/Zt8zzdp5H8vguwKI32St0f1GJMasj0353TFaUdK4Gk2fLOLXNICTFy/QiKDfGwiDTteq6iKKyYBAZCAxwX3dYHQEo8TuIa2IjC1t4A+WmwRMVwLOz2BiWEMVQaI3T3mE356vx3J4emVDWd9d+3tFNQe264fuqmpAzwzxpzM4GDigfhl29hkm4/Zkl87zyBc3wLVb6M/S6RPI/WJxJ4dOVDidMssHH9X1vId1iPQ0bevuCo6Ol/IbawpeIrv9U1o7j/voh4P3wkBsZMyD13dbQ9pE9zEkv9tykr/Pug2m+TnTa51zWZZM+na6yWQ1+RHDaglw9XammckXzR3eF2QkyqVU3UsWG3tc10JlBnnLCrBnjFssJviPIvILJSCkOcf5quI9/v9dDy9UfqNqBTab3/qNHxx+1cPVqhraGRdhjb2suRJ94M0fmgca28I/JmAnZgcJWY/d7C/2B5Hb0Bh2V3Ac728pgNtMom+gWEbsnhI14ApIuEbtJwRno6SgAeLYLTjUwzGOOGd+QHjQfcAiwGOGDUpIYe4JZw/4YWhvL6oFlglPQzWINTn2f0rfXlOuoh4Viwmxsq39GgiCpb5atRwE5Ic8E7UFrmSPVYhnf4sKqtVic8yiBzHNdkp/MQJluY8dWNSDD1yelEBIQVGqaSj+x5d05KfLQw0fAz/fw6g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(7636003)(82740400003)(356005)(478600001)(47076005)(26005)(6666004)(36756003)(426003)(16526019)(336012)(83380400001)(31696002)(86362001)(2616005)(107886003)(40480700001)(2906002)(53546011)(5660300002)(41300700001)(70206006)(316002)(16576012)(6916009)(54906003)(8936002)(4326008)(31686004)(70586007)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:09:40.0201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1f24ab-ed0a-4c2a-e4d7-08dbc9ab4ecd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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

T24gMTAvMTAvMjAyMyAxODo1OCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFR1ZSwg
T2N0IDEwLCAyMDIzIGF0IDA2OjQzOjMyUE0gKzAzMDAsIFlpc2hhaSBIYWRhcyB3cm90ZToKPj4g
T24gMTAvMTAvMjAyMyAxODoxNCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4gT24gVHVl
LCBPY3QgMTAsIDIwMjMgYXQgMDY6MDk6NDRQTSArMDMwMCwgWWlzaGFpIEhhZGFzIHdyb3RlOgo+
Pj4+IE9uIDEwLzEwLzIwMjMgMTc6NTQsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4g
T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTE6MDg6NDlBTSAtMDMwMCwgSmFzb24gR3VudGhvcnBl
IHdyb3RlOgo+Pj4+Pj4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMDk6NTY6MDBBTSAtMDQwMCwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+Pj4KPj4+Pj4+Pj4gSG93ZXZlciAtIHRoZSBJ
bnRlbCBHUFUgVkZJTyBkcml2ZXIgaXMgc3VjaCBhIGJhZCBleHBlcmlhbmNlIEkgZG9uJ3QKPj4+
Pj4+Pj4gd2FudCB0byBlbmNvdXJhZ2UgcGVvcGxlIHRvIG1ha2UgVkZJTyBkcml2ZXJzLCBvciBj
b2RlIHRoYXQgaXMgb25seQo+Pj4+Pj4+PiB1c2VkIGJ5IFZGSU8gZHJpdmVycywgdGhhdCBhcmUg
bm90IHVuZGVyIGRyaXZlcnMvdmZpbyByZXZpZXcuCj4+Pj4+Pj4gU28gaWYgQWxleCBmZWVscyBp
dCBtYWtlcyBzZW5zZSB0byBhZGQgc29tZSB2aXJ0aW8gZnVuY3Rpb25hbGl0eQo+Pj4+Pj4+IHRv
IHZmaW8gYW5kIGlzIGhhcHB5IHRvIG1haW50YWluIG9yIGxldCB5b3UgbWFpbnRhaW4gdGhlIFVB
UEkKPj4+Pj4+PiB0aGVuIHdoeSB3b3VsZCBJIHNheSBubz8gQnV0IHdlIG5ldmVyIGV4cGVjdGVk
IGRldmljZXMgdG8gaGF2ZQo+Pj4+Pj4+IHR3byBkcml2ZXJzIGxpa2UgdGhpcyBkb2VzLCBzbyBq
dXN0IGV4cG9zaW5nIGRldmljZSBwb2ludGVyCj4+Pj4+Pj4gYW5kIHNheWluZyAidXNlIHJlZ3Vs
YXIgdmlydGlvIEFQSXMgZm9yIHRoZSByZXN0IiBkb2VzIG5vdAo+Pj4+Pj4+IGN1dCBpdCwgdGhl
IG5ldyBBUElzIGhhdmUgdG8gbWFrZSBzZW5zZQo+Pj4+Pj4+IHNvIHZpcnRpbyBkcml2ZXJzIGNh
biBkZXZlbG9wIG5vcm1hbGx5IHdpdGhvdXQgZmVhciBvZiBzdGVwcGluZwo+Pj4+Pj4+IG9uIHRo
ZSB0b2VzIG9mIHRoaXMgYWRtaW4gZHJpdmVyLgo+Pj4+Pj4gUGxlYXNlIHdvcmsgd2l0aCBZaXNo
YWkgdG8gZ2V0IHNvbWV0aGluZyB0aGF0IG1ha2Ugc2Vuc2UgdG8geW91LiBIZQo+Pj4+Pj4gY2Fu
IHBvc3QgYSB2MiB3aXRoIHRoZSBhY2N1bXVsYXRlZCBjb21tZW50cyBhZGRyZXNzZWQgc28gZmFy
IGFuZCB0aGVuCj4+Pj4+PiBnbyBvdmVyIHdoYXQgdGhlIEFQSSBiZXR3ZWVuIHRoZSBkcml2ZXJz
IGlzLgo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcywKPj4+Pj4+IEphc29uCj4+Pj4+IC9tZSBzaHJ1Z3Mu
IEkgcHJldHR5IG11Y2ggcG9zdGVkIHN1Z2dlc3Rpb25zIGFscmVhZHkuIFNob3VsZCBub3QgYmUg
aGFyZC4KPj4+Pj4gQW55dGhpbmcgdW5jbGVhciAtIHBvc3Qgb24gbGlzdC4KPj4+Pj4KPj4+PiBZ
ZXMsIHRoaXMgaXMgdGhlIHBsYW4uCj4+Pj4KPj4+PiBXZSBhcmUgd29ya2luZyB0byBhZGRyZXNz
IHRoZSBjb21tZW50cyB0aGF0IHdlIGdvdCBzbyBmYXIgaW4gYm90aCBWRklPICYKPj4+PiBWSVJU
SU8sIHJldGVzdCBhbmQgc2VuZCB0aGUgbmV4dCB2ZXJzaW9uLgo+Pj4+Cj4+Pj4gUmUgdGhlIEFQ
SSBiZXR3ZWVuIHRoZSBtb2R1bGVzLCBJdCBsb29rcyBsaWtlIHdlIGhhdmUgdGhlIGJlbG93Cj4+
Pj4gYWx0ZXJuYXRpdmVzLgo+Pj4+Cj4+Pj4gMSkgUHJvY2VlZCB3aXRoIGN1cnJlbnQgYXBwcm9h
Y2ggd2hlcmUgd2UgZXhwb3NlZCBhIGdlbmVyaWMgQVBJIHRvIGV4ZWN1dGUKPj4+PiBhbnkgYWRt
aW4gY29tbWFuZCwgaG93ZXZlciwgbWFrZSBpdCBtdWNoIG1vcmUgc29saWQgaW5zaWRlIFZJUlRJ
Ty4KPj4+PiAyKSBFeHBvc2UgZXh0cmEgQVBJcyBmcm9tIFZJUlRJTyBmb3IgY29tbWFuZHMgdGhh
dCB3ZSBjYW4gY29uc2lkZXIgZnV0dXJlCj4+Pj4gY2xpZW50IHVzYWdlIG9mIHRoZW0gYXMgb2Yg
TElTVF9RVUVSWS9MSVNUX1VTRSwgaG93ZXZlciBzdGlsbCBoYXZlIHRoZQo+Pj4+IGdlbmVyaWMg
ZXhlY3V0ZSBhZG1pbiBjb21tYW5kIGZvciBvdGhlcnMuCj4+Pj4gMykgRXhwb3NlIEFQSSBwZXIg
Y29tbWFuZCBmcm9tIFZJUlRJTyBhbmQgZnVsbHkgZHJvcCB0aGUgZ2VuZXJpYyBleGVjdXRlCj4+
Pj4gYWRtaW4gY29tbWFuZC4KPj4+Pgo+Pj4+IEZldyBub3RlczoKPj4+PiBPcHRpb24gIzEgbG9v
a3MgdGhlIG1vc3QgZ2VuZXJpYyBvbmUsIGl0IGRyb3BzIHRoZSBuZWVkIHRvIGV4cG9zZSBtdWx0
aXBsZQo+Pj4+IHN5bWJvbHMgLyBBUElzIHBlciBjb21tYW5kIGFuZCBmb3Igbm93IHdlIGhhdmUg
YSBzaW5nbGUgY2xpZW50IGZvciB0aGVtCj4+Pj4gKGkuZS4gVkZJTykuCj4+Pj4gT3B0aW9ucyAj
MiAmICMzLCBtYXkgc3RpbGwgcmVxdWlyZSB0byBleHBvc2UgdGhlIHZpcnRpb19wY2lfdmZfZ2V0
X3BmX2RldigpCj4+Pj4gQVBJIHRvIGxldCBWRklPIGdldCB0aGUgVklSVElPIFBGIChzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqKSBmcm9tIGl0cyBQQ0kKPj4+PiBkZXZpY2UsIGVhY2ggY29tbWFuZCB3
aWxsIGdldCBpdCBhcyBpdHMgZmlyc3QgYXJndW1lbnQuCj4+Pj4KPj4+PiBNaWNoYWVsLAo+Pj4+
IFdoYXQgZG8geW91IHN1Z2dlc3QgaGVyZSA/Cj4+Pj4KPj4+PiBUaGFua3MsCj4+Pj4gWWlzaGFp
Cj4+PiBJIHN1Z2dlc3QgMyBidXQgY2FsbCBpdCBvbiB0aGUgVkYuIGNvbW1hbmRzIHdpbGwgc3dp
dGNoIHRvIFBGCj4+PiBpbnRlcm5hbGx5IGFzIG5lZWRlZC4gRm9yIGV4YW1wbGUsIGludGVsIG1p
Z2h0IGJlIGludGVyZXN0ZWQgaW4gZXhwb3NpbmcKPj4+IGFkbWluIGNvbW1hbmRzIHRocm91Z2gg
YSBtZW1vcnkgQkFSIG9mIFZGIGl0c2VsZi4KPj4+Cj4+IFRoZSBkcml2ZXIgd2hvIG93bnMgdGhl
IFZGIGlzIFZGSU8sIGl0J3Mgbm90IGEgVklSVElPIG9uZS4KPj4KPj4gVGhlIGFiaWxpdHkgdG8g
Z2V0IHRoZSBWSVJUSU8gUEYgaXMgZnJvbSB0aGUgUENJIGRldmljZSAoaS5lLiBzdHJ1Y3QKPj4g
cGNpX2RldikuCj4+Cj4+IEluIGFkZGl0aW9uLAo+PiB2aXJ0aW9fcGNpX3ZmX2dldF9wZl9kZXYo
KSB3YXMgaW1wbGVtZW50ZWQgZm9yIG5vdyBpbiB2aXJ0aW8tcGNpIGFzIGl0Cj4+IHdvcmtlZCBv
biBwY2lfZGV2Lgo+IE9uIHBjaV9kZXYgb2YgdmYsIHllcz8gU28gYWdhaW4ganVzdCBtb3ZlIHRo
aXMgaW50byBlYWNoIGNvbW1hbmQsCj4gdGhhdCdzIGFsbC4gSS5lLiBwYXNzIHBjaV9kZXYgdG8g
ZWFjaC4KCkhvdyBhYm91dCB0aGUgY3ljbGljIGRlcGVuZGVuY2llcyBpc3N1ZSBpbnNpZGUgVklS
VElPIHRoYXQgSSBtZW50aW9uZWTCoCAKYmVsb3cgPwoKSW4gbXkgc3VnZ2VzdGlvbiBpdCdzIGZp
bmUsIFZGSU8gd2lsbCBnZXQgdGhlIFBGIGFuZCBnaXZlIGl0IHRvIFZJUlRJTyAKcGVyIGNvbW1h
bmQuCgpZaXNoYWkKCj4+IEFzc3VtaW5nIHRoYXQgd2UnbGwgcHV0IGVhY2ggY29tbWFuZCBpbnNp
ZGUgdmlydGlvIGFzIHRoZSBnZW5lcmljIGxheWVyLCB3ZQo+PiB3b24ndCBiZSBhYmxlIHRvIGNh
bGwvdXNlIHRoaXMgQVBJIGludGVybmFsbHkgdG8gZ2V0IHRoZSBQRiBhcyBvZiBjeWNsaWMKPj4g
ZGVwZW5kZW5jaWVzIGJldHdlZW4gdGhlIG1vZHVsZXMsIGxpbmsgd2lsbCBmYWlsLgo+Pgo+PiBT
byBpbiBvcHRpb24gIzMgd2UgbWF5IHN0aWxsIG5lZWQgdG8gZ2V0IG91dHNpZGUgaW50byBWRklP
IHRoZSBWSVJUSU8gUEYgYW5kCj4+IGdpdmUgaXQgYXMgcG9pbnRlciB0byBWSVJUSU8gdXBvbiBl
YWNoIGNvbW1hbmQuCj4+Cj4+IERvZXMgaXQgd29yayBmb3IgeW91ID8KPj4KPj4gWWlzaGFpCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
