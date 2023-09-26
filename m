Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4B4E7D27B
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 10:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C12B8417D1;
	Tue, 26 Sep 2023 10:51:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C12B8417D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uoO1Gqx5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s29CLksQjadL; Tue, 26 Sep 2023 10:51:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C9833417D4;
	Tue, 26 Sep 2023 10:51:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9833417D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F201C0039;
	Tue, 26 Sep 2023 10:51:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C69C5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 10:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1A6781297
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 10:51:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1A6781297
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=uoO1Gqx5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1PqVLv3NXgvc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 10:51:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::619])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D16681291
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 10:51:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D16681291
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKodSdfqrB4iqCze2aeAvJBzPPICs9A6Pdkw3l9cnIEeuTFNg6CnqAcZJxW9p8UYq3WAdbUBfe3Pu9H4FKwwjLghPUjUasNtnkkgeBxyjWWvYoPYnflUMam61HBL9ihthfO741L5WYWzC49c3JILhfmpij4RnbSMeHoyxi6MfbBUXYfZGP9A/MG6TtL329BucmBLL+wULiUgrOLziJy01jHmZmHbU10U/dD3Yg2sdtks9RORpS/XW853iKGRNqWjcrkQYAZ7UPM9hmyvcF64abP3pyZxtE+JnOGQChegi2K0FCHH2AVSMb8ZOdRaLOU88FO0r5kGK99t4tsMUY3yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNEnOb1BPuC0sPyfve7L9nten9oXY+XhGQmYI187fo0=;
 b=n0ougfBi2QlobJ6Dgz6LsrDEWZE+UA7ZiUSh093btanZgahvzXOL64CqDdpEweVzxelle6EKKa+1wOd/Bs2w3kmg7bxz0pwGIME6dkfMc5BKgCCE/I973jYTfHsFAn2WbxD2VK9UtgMDKhqkxGvrKA7MnZ4h9NnZgOTs8NXKBZOPG4T1xqW0AysMu+SBQlsWpDwOhU7VG6enKJ6WhQP+2ohkKPm/NTNtsbC/8r5FShwal1TZa/9FnF0xwrVIy5/R0P2hyLNo5Y12O1A5HOkAiY6F/L/3aBbTPWOM0dZxMriKDNpPUYSt2uriluOvL9dsan0nlMUpB7Q4BCq0zGpxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNEnOb1BPuC0sPyfve7L9nten9oXY+XhGQmYI187fo0=;
 b=uoO1Gqx5NWGnPDVETfF9De/Djfxgfd3cxEb4gGfJq8QOxf9wqOcl3W2kNIbmdQ+df0RLtdaXgyNO+XNixnOQY2Rs/w2j6y2EpFZskpT+wPkeEKIebaDVBN0o8I8HZolVKK91vM3+etI3dHpckI509FiohNhWVGfec/di+Jbpparw7X82+n5/X5U846eNcZ4F9YHcfkEIJB0JBTvTzOjo4avVuhx2DfGj1TJQ60oZoTfgabyaAu7wBgOqt2SqtFj4uA9N26tdRR4A1wdVRCFSkKk+lo5qCf3+flt4vO1EihTzepgaoffklTUE/ecFMXxgpXH4qVp12ZtuMIGqtujTeA==
Received: from DS7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:3b8::12)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 26 Sep
 2023 10:51:32 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::60) by DS7PR03CA0007.outlook.office365.com
 (2603:10b6:5:3b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 10:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 10:51:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 03:51:21 -0700
Received: from [172.27.13.90] (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Sep
 2023 03:51:15 -0700
Message-ID: <cf657792-c21a-4ef7-737d-402239ce557d@nvidia.com>
Date: Tue, 26 Sep 2023 13:51:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-11-yishaih@nvidia.com>
 <20230921162621-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921162621-mutt-send-email-mst@kernel.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc168d3-3e46-4140-6b5b-08dbbe7e8be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvycYj5z0jQYdFnALUQoJ5DP1bdkLpV7mdcvA0YQreu61sjxkmrxcbJQg0FK1KRNuWDXdbIQTkysoI6tNqDcF4sID0XP1gjvqVMs/fV+r97ohr+guBntJrd6WCzdKkytJWIKp1spo5vYfI0vqey7TOqHf/v8gpgFIUFdYSXZbfZCEJUjeanZOcjXv6RCcvJvXMONnEi5VgxF3ko9Th0hemzNJVBpzmsNKOto23GOgSXYeFcZW/38p6PqxG38pluWcC6QEyb0ozkWkQNVf3b2DXfuTMx8812dxyJhpAgJJ7iKCQjeqE4hbnCMrCRQIorqyB2p7rSM94i6qoWNnyQZhFM+NTtPSaMvFjD7NXRDX2PMqaAk3Of37Kyfht7M/chTnC11eGdQrOBr/xu8GxQZCsjIhuXGAM2ZjLDQexeP/5OJGqcVxAaMc72+5k21LtFp8X/Ii2C+XwYCUThWItJJugNyZMhD3FqT0HHXljtz66lHqj6L8tWOEAGPgl3yhff+w7qo/4IaurfLg4AVFApiPexUKMfHsk04jjPnhxFAVWSR2y4qYzUgMQRTnHS91Foh05DcFI5B9tv1pDmXG2uUr2IUgAlcWQzmpnFqQzRNMyosTpn6wu/bvRw6OZ/5TIMz/VJoWZrPhwqMqFt/rFUGzqwc+Lxy0CZDciEMZthD7YflUWMwHQFLxuf6a4FZi0Tjjd2dgUlYx+byKKlUCMHBmzDn91QZmDMxdKYfj4RZSpPbDJN1gyADPzo/nrto0tbefPhz5ErV3y/anJfboKPsPA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(31686004)(4326008)(8676002)(8936002)(53546011)(40480700001)(70586007)(316002)(41300700001)(6916009)(54906003)(70206006)(5660300002)(16576012)(40460700003)(36860700001)(47076005)(86362001)(107886003)(7636003)(82740400003)(356005)(31696002)(36756003)(26005)(16526019)(2616005)(478600001)(2906002)(83380400001)(336012)(426003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 10:51:32.3991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc168d3-3e46-4140-6b5b-08dbbe7e8be2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
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

T24gMjEvMDkvMjAyMyAyMzozNCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFRodSwg
U2VwIDIxLCAyMDIzIGF0IDAzOjQwOjM5UE0gKzAzMDAsIFlpc2hhaSBIYWRhcyB3cm90ZToKPj4g
RXhwb3NlIGFkbWluIGNvbW1hbmRzIG92ZXIgdGhlIHZpcnRpbyBkZXZpY2UsIHRvIGJlIHVzZWQg
YnkgdGhlCj4+IHZmaW8tdmlydGlvIGRyaXZlciBpbiB0aGUgbmV4dCBwYXRjaGVzLgo+Pgo+PiBJ
dCBpbmNsdWRlczogbGlzdCBxdWVyeS91c2UsIGxlZ2FjeSB3cml0ZS9yZWFkLCByZWFkIG5vdGlm
eV9pbmZvLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBZaXNoYWkgSGFkYXMgPHlpc2hhaWhAbnZpZGlh
LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy92ZmlvL3BjaS92aXJ0aW8vY21kLmMgfCAxNDYgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgIGRyaXZlcnMvdmZpby9wY2kvdmly
dGlvL2NtZC5oIHwgIDI3ICsrKysrKysKPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE3MyBpbnNlcnRp
b25zKCspCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmZpby9wY2kvdmlydGlvL2Nt
ZC5jCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdmZpby9wY2kvdmlydGlvL2NtZC5o
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZmaW8vcGNpL3ZpcnRpby9jbWQuYyBiL2RyaXZl
cnMvdmZpby9wY2kvdmlydGlvL2NtZC5jCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4
IDAwMDAwMDAwMDAwMC4uZjA2ODIzOWNkYmIwCj4+IC0tLSAvZGV2L251bGwKPj4gKysrIGIvZHJp
dmVycy92ZmlvL3BjaS92aXJ0aW8vY21kLmMKPj4gQEAgLTAsMCArMSwxNDYgQEAKPj4gKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wIE9SIExpbnV4LU9wZW5JQgo+PiArLyoKPj4g
KyAqIENvcHlyaWdodCAoYykgMjAyMywgTlZJRElBIENPUlBPUkFUSU9OICYgQUZGSUxJQVRFUy4g
QWxsIHJpZ2h0cyByZXNlcnZlZAo+PiArICovCj4+ICsKPj4gKyNpbmNsdWRlICJjbWQuaCIKPj4g
Kwo+PiAraW50IHZpcnRpb3ZmX2NtZF9saXN0X3F1ZXJ5KHN0cnVjdCBwY2lfZGV2ICpwZGV2LCB1
OCAqYnVmLCBpbnQgYnVmX3NpemUpCj4+ICt7Cj4+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZp
cnRpb19kZXYgPSB2aXJ0aW9fcGNpX3ZmX2dldF9wZl9kZXYocGRldik7Cj4+ICsJc3RydWN0IHNj
YXR0ZXJsaXN0IG91dF9zZzsKPj4gKwlzdHJ1Y3QgdmlydGlvX2FkbWluX2NtZCBjbWQgPSB7fTsK
Pj4gKwo+PiArCWlmICghdmlydGlvX2RldikKPj4gKwkJcmV0dXJuIC1FTk9UQ09OTjsKPj4gKwo+
PiArCXNnX2luaXRfb25lKCZvdXRfc2csIGJ1ZiwgYnVmX3NpemUpOwo+PiArCWNtZC5vcGNvZGUg
PSBWSVJUSU9fQURNSU5fQ01EX0xJU1RfUVVFUlk7Cj4+ICsJY21kLmdyb3VwX3R5cGUgPSBWSVJU
SU9fQURNSU5fR1JPVVBfVFlQRV9TUklPVjsKPj4gKwljbWQucmVzdWx0X3NnID0gJm91dF9zZzsK
Pj4gKwo+PiArCXJldHVybiB2aXJ0aW9fYWRtaW5fY21kX2V4ZWModmlydGlvX2RldiwgJmNtZCk7
Cj4+ICt9Cj4+ICsKPiBpbi9vdXQgc2VlbSBhbGwgd3JvbmcgaGVyZS4gSW4gdmlydGlvIHRlcm1p
bm9sb2d5LCBpbiBtZWFucyBmcm9tCj4gZGV2aWNlIHRvIGRyaXZlciwgb3V0IG1lYW5zIGZyb20g
ZHJpdmVyIHRvIGRldmljZS4KSSByZWZlcnJlZCBoZXJlIHRvIGluL291dCBmcm9tIHZmaW8gUE9W
IHdobyBwcmVwYXJlcyB0aGUgY29tbWFuZC4KCkhvd2V2ZXIsIEkgY2FuIHJlcGxhY2UgaXQgdG8g
Zm9sbG93IHRoZSB2aXJ0aW8gdGVybWlub2xvZ3kgYXMgeW91IApzdWdnZXN0ZWQgaWYgdGhpcyBt
b3JlIG1ha2VzIHNlbnNlLgoKUGxlYXNlIHNlZSBhbHNvIG15IGNvbWluZyBhbnN3ZXIgb24geW91
ciBzdWdnZXN0aW9uIHRvIHB1dCBhbGwgb2YgdGhpcyAKaW4gdGhlIHZpcnRpbyBsYXllci4KCj4+
ICtpbnQgdmlydGlvdmZfY21kX2xpc3RfdXNlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCB1OCAqYnVm
LCBpbnQgYnVmX3NpemUpCj4+ICt7Cj4+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZpcnRpb19k
ZXYgPSB2aXJ0aW9fcGNpX3ZmX2dldF9wZl9kZXYocGRldik7Cj4+ICsJc3RydWN0IHNjYXR0ZXJs
aXN0IGluX3NnOwo+PiArCXN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kIGNtZCA9IHt9Owo+PiArCj4+
ICsJaWYgKCF2aXJ0aW9fZGV2KQo+PiArCQlyZXR1cm4gLUVOT1RDT05OOwo+PiArCj4+ICsJc2df
aW5pdF9vbmUoJmluX3NnLCBidWYsIGJ1Zl9zaXplKTsKPj4gKwljbWQub3Bjb2RlID0gVklSVElP
X0FETUlOX0NNRF9MSVNUX1VTRTsKPj4gKwljbWQuZ3JvdXBfdHlwZSA9IFZJUlRJT19BRE1JTl9H
Uk9VUF9UWVBFX1NSSU9WOwo+PiArCWNtZC5kYXRhX3NnID0gJmluX3NnOwo+PiArCj4+ICsJcmV0
dXJuIHZpcnRpb19hZG1pbl9jbWRfZXhlYyh2aXJ0aW9fZGV2LCAmY21kKTsKPj4gK30KPj4gKwo+
PiAraW50IHZpcnRpb3ZmX2NtZF9scl93cml0ZShzdHJ1Y3QgdmlydGlvdmZfcGNpX2NvcmVfZGV2
aWNlICp2aXJ0dmRldiwgdTE2IG9wY29kZSwKPgo+IHdoYXQgaXMgX2xyIHNob3J0IGZvcj8KClRo
aXMgd2FzIGFuIGFjcm9ueW0gdG8gbGVnYWN5X3JlYWQuCgpUaGUgYWN0dWFsIGNvbW1hbmQgaXMg
YWNjb3JkaW5nIHRvIHRoZSBnaXZlbiBvcGNvZGUgd2hpY2ggY2FuIGJlIG9uZSAKYW1vbmcgTEVH
QUNZX0NPTU1PTl9DRkdfUkVBRCwgTEVHQUNZX0RFVl9DRkdfUkVBRC4KCkkgY2FuIHJlbmFtZSBp
dCB0byAnX2xlZ2FjeV9yZWFkJyAoaS5lLiB2aXJ0aW92Zl9pc3N1ZV9sZWdhY3lfcmVhZF9jbWQp
IAp0byBiZSBjbGVhcmVyLgoKPgo+PiArCQkJICB1OCBvZmZzZXQsIHU4IHNpemUsIHU4ICpidWYp
Cj4+ICt7Cj4+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZpcnRpb19kZXYgPQo+PiArCQl2aXJ0
aW9fcGNpX3ZmX2dldF9wZl9kZXYodmlydHZkZXYtPmNvcmVfZGV2aWNlLnBkZXYpOwo+PiArCXN0
cnVjdCB2aXJ0aW9fYWRtaW5fY21kX2RhdGFfbHJfd3JpdGUgKmluOwo+PiArCXN0cnVjdCBzY2F0
dGVybGlzdCBpbl9zZzsKPj4gKwlzdHJ1Y3QgdmlydGlvX2FkbWluX2NtZCBjbWQgPSB7fTsKPj4g
KwlpbnQgcmV0Owo+PiArCj4+ICsJaWYgKCF2aXJ0aW9fZGV2KQo+PiArCQlyZXR1cm4gLUVOT1RD
T05OOwo+PiArCj4+ICsJaW4gPSBremFsbG9jKHNpemVvZigqaW4pICsgc2l6ZSwgR0ZQX0tFUk5F
TCk7Cj4+ICsJaWYgKCFpbikKPj4gKwkJcmV0dXJuIC1FTk9NRU07Cj4+ICsKPj4gKwlpbi0+b2Zm
c2V0ID0gb2Zmc2V0Owo+PiArCW1lbWNweShpbi0+cmVnaXN0ZXJzLCBidWYsIHNpemUpOwo+PiAr
CXNnX2luaXRfb25lKCZpbl9zZywgaW4sIHNpemVvZigqaW4pICsgc2l6ZSk7Cj4+ICsJY21kLm9w
Y29kZSA9IG9wY29kZTsKPj4gKwljbWQuZ3JvdXBfdHlwZSA9IFZJUlRJT19BRE1JTl9HUk9VUF9U
WVBFX1NSSU9WOwo+PiArCWNtZC5ncm91cF9tZW1iZXJfaWQgPSB2aXJ0dmRldi0+dmZfaWQgKyAx
Owo+IHdlaXJkLiB3aHkgKyAxPwoKVGhpcyBmb2xsb3dzIHRoZSB2aXJ0aW8gc3BlYyBpbiB0aGF0
IGFyZWEuCgoiV2hlbiBzZW5kaW5nIGNvbW1hbmRzIHdpdGggdGhlIFNSLUlPViBncm91cCB0eXBl
LCB0aGUgZHJpdmVyIHNwZWNpZnkgYSAKdmFsdWUgZm9yIGdyb3VwX21lbWJlcl9pZApiZXR3ZWVu
IDEgYW5kIE51bVZGcyBpbmNsdXNpdmUuIgoKVGhlICd2aXJ0dmRldi0+dmZfaWQnIHdhcyBzZXQg
dXBvbiB2ZmlvL3ZpcnRpbyBkcml2ZXIgaW5pdGlhbGl6YXRpb24gYnkgCnBjaV9pb3ZfdmZfaWQo
KSB3aGljaCBpdHMgZmlyc3QgaW5kZXggaXMgMC4KCj4+ICsJY21kLmRhdGFfc2cgPSAmaW5fc2c7
Cj4+ICsJcmV0ID0gdmlydGlvX2FkbWluX2NtZF9leGVjKHZpcnRpb19kZXYsICZjbWQpOwo+PiAr
Cj4+ICsJa2ZyZWUoaW4pOwo+PiArCXJldHVybiByZXQ7Cj4+ICt9Cj4gSG93IGRvIHlvdSBrbm93
IGl0J3Mgc2FmZSB0byBzZW5kIHRoaXMgY29tbWFuZCwgaW4gcGFydGljdWxhciBhdAo+IHRoaXMg
dGltZT8gVGhpcyBzZWVtcyB0byBiZSBkb2luZyB6ZXJvIGNoZWNrcywgYW5kIHplcm8gc3luY2hy
b25pemF0aW9uCj4gd2l0aCB0aGUgUEYgZHJpdmVyLgo+ClRoZSB2aXJ0aW92Zl9jbWRfbHJfcmVh
ZCgpL290aGVyIGdldHMgYSB2aXJ0aW8gVkYgYW5kIGl0IGdldHMgaXRzIFBGIGJ5IApjYWxsaW5n
IHZpcnRpb19wY2lfdmZfZ2V0X3BmX2RldigpLgoKVGhlIFZGIGNhbid0IGdvbmUgYnkgJ2Rpc2Fi
bGUgc3Jpb3YnIGFzIGl0J3Mgb3duZWQvdXNlZCBieSB2ZmlvLgoKVGhlIFBGIGNhbid0IGdvbmUg
Ynkgcm1tb2QvbW9kcHJvYmUgLXIgb2YgdmlydGlvLCBhcyBvZiB0aGUgJ21vZHVsZSBpbiAKdXNl
Jy9kZXBlbmRlbmNpZXMgYmV0d2VlbiBWRklPIHRvIFZJUlRJTy4KClRoZSBiZWxvdyBjaGVjayBb
MV0gd2FzIGRvbmUgb25seSBmcm9tIGEgY2xlYW4gY29kZSBwZXJzcGVjdGl2ZSwgd2hpY2ggCm1p
Z2h0IHRoZW9yZXRpY2FsbHkgZmFpbCBpbiBjYXNlIHRoZSBnaXZlbiBWRiBkb2Vzbid0IHVzZSBh
IHZpcnRpbyBkcml2ZXIuCgpbMV0gaWYgKCF2aXJ0aW9fZGV2KQogwqDCoCDCoMKgwqDCoCByZXR1
cm4gLUVOT1RDT05OOwoKU28sIGl0IGxvb2tzIHNhZmUgYXMgaXMuCgo+PiArCj4+ICtpbnQgdmly
dGlvdmZfY21kX2xyX3JlYWQoc3RydWN0IHZpcnRpb3ZmX3BjaV9jb3JlX2RldmljZSAqdmlydHZk
ZXYsIHUxNiBvcGNvZGUsCj4+ICsJCQkgdTggb2Zmc2V0LCB1OCBzaXplLCB1OCAqYnVmKQo+PiAr
ewo+PiArCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2aXJ0aW9fZGV2ID0KPj4gKwkJdmlydGlvX3Bj
aV92Zl9nZXRfcGZfZGV2KHZpcnR2ZGV2LT5jb3JlX2RldmljZS5wZGV2KTsKPj4gKwlzdHJ1Y3Qg
dmlydGlvX2FkbWluX2NtZF9kYXRhX2xyX3JlYWQgKmluOwo+PiArCXN0cnVjdCBzY2F0dGVybGlz
dCBpbl9zZywgb3V0X3NnOwo+PiArCXN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kIGNtZCA9IHt9Owo+
PiArCWludCByZXQ7Cj4+ICsKPj4gKwlpZiAoIXZpcnRpb19kZXYpCj4+ICsJCXJldHVybiAtRU5P
VENPTk47Cj4+ICsKPj4gKwlpbiA9IGt6YWxsb2Moc2l6ZW9mKCppbiksIEdGUF9LRVJORUwpOwo+
PiArCWlmICghaW4pCj4+ICsJCXJldHVybiAtRU5PTUVNOwo+PiArCj4+ICsJaW4tPm9mZnNldCA9
IG9mZnNldDsKPj4gKwlzZ19pbml0X29uZSgmaW5fc2csIGluLCBzaXplb2YoKmluKSk7Cj4+ICsJ
c2dfaW5pdF9vbmUoJm91dF9zZywgYnVmLCBzaXplKTsKPj4gKwljbWQub3Bjb2RlID0gb3Bjb2Rl
Owo+PiArCWNtZC5ncm91cF90eXBlID0gVklSVElPX0FETUlOX0dST1VQX1RZUEVfU1JJT1Y7Cj4+
ICsJY21kLmRhdGFfc2cgPSAmaW5fc2c7Cj4+ICsJY21kLnJlc3VsdF9zZyA9ICZvdXRfc2c7Cj4+
ICsJY21kLmdyb3VwX21lbWJlcl9pZCA9IHZpcnR2ZGV2LT52Zl9pZCArIDE7Cj4+ICsJcmV0ID0g
dmlydGlvX2FkbWluX2NtZF9leGVjKHZpcnRpb19kZXYsICZjbWQpOwo+PiArCj4+ICsJa2ZyZWUo
aW4pOwo+PiArCXJldHVybiByZXQ7Cj4+ICt9Cj4+ICsKPj4gK2ludCB2aXJ0aW92Zl9jbWRfbHFf
cmVhZF9ub3RpZnkoc3RydWN0IHZpcnRpb3ZmX3BjaV9jb3JlX2RldmljZSAqdmlydHZkZXYsCj4g
YW5kIHdoYXQgaXMgbHEgc2hvcnQgZm9yPwoKVG8gYmUgbW9yZSBleHBsaWNpdCwgSSBtYXkgcmVw
bGFjZSB0byB2aXJ0aW92Zl9jbWRfbGVnYWN5X25vdGlmeV9pbmZvKCkgCnRvIGZvbGxvdyB0aGUg
c3BlYyBvcGNvZGUuCgpZaXNoYWkKCj4KPj4gKwkJCQl1OCByZXFfYmFyX2ZsYWdzLCB1OCAqYmFy
LCB1NjQgKmJhcl9vZmZzZXQpCj4+ICt7Cj4+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZpcnRp
b19kZXYgPQo+PiArCQl2aXJ0aW9fcGNpX3ZmX2dldF9wZl9kZXYodmlydHZkZXYtPmNvcmVfZGV2
aWNlLnBkZXYpOwo+PiArCXN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kX25vdGlmeV9pbmZvX3Jlc3Vs
dCAqb3V0Owo+PiArCXN0cnVjdCBzY2F0dGVybGlzdCBvdXRfc2c7Cj4+ICsJc3RydWN0IHZpcnRp
b19hZG1pbl9jbWQgY21kID0ge307Cj4+ICsJaW50IHJldDsKPj4gKwo+PiArCWlmICghdmlydGlv
X2RldikKPj4gKwkJcmV0dXJuIC1FTk9UQ09OTjsKPj4gKwo+PiArCW91dCA9IGt6YWxsb2Moc2l6
ZW9mKCpvdXQpLCBHRlBfS0VSTkVMKTsKPj4gKwlpZiAoIW91dCkKPj4gKwkJcmV0dXJuIC1FTk9N
RU07Cj4+ICsKPj4gKwlzZ19pbml0X29uZSgmb3V0X3NnLCBvdXQsIHNpemVvZigqb3V0KSk7Cj4+
ICsJY21kLm9wY29kZSA9IFZJUlRJT19BRE1JTl9DTURfTEVHQUNZX05PVElGWV9JTkZPOwo+PiAr
CWNtZC5ncm91cF90eXBlID0gVklSVElPX0FETUlOX0dST1VQX1RZUEVfU1JJT1Y7Cj4+ICsJY21k
LnJlc3VsdF9zZyA9ICZvdXRfc2c7Cj4+ICsJY21kLmdyb3VwX21lbWJlcl9pZCA9IHZpcnR2ZGV2
LT52Zl9pZCArIDE7Cj4+ICsJcmV0ID0gdmlydGlvX2FkbWluX2NtZF9leGVjKHZpcnRpb19kZXYs
ICZjbWQpOwo+PiArCWlmICghcmV0KSB7Cj4+ICsJCXN0cnVjdCB2aXJ0aW9fYWRtaW5fY21kX25v
dGlmeV9pbmZvX2RhdGEgKmVudHJ5Owo+PiArCQlpbnQgaTsKPj4gKwo+PiArCQlyZXQgPSAtRU5P
RU5UOwo+PiArCQlmb3IgKGkgPSAwOyBpIDwgVklSVElPX0FETUlOX0NNRF9NQVhfTk9USUZZX0lO
Rk87IGkrKykgewo+PiArCQkJZW50cnkgPSAmb3V0LT5lbnRyaWVzW2ldOwo+PiArCQkJaWYgKGVu
dHJ5LT5mbGFncyA9PSBWSVJUSU9fQURNSU5fQ01EX05PVElGWV9JTkZPX0ZMQUdTX0VORCkKPj4g
KwkJCQlicmVhazsKPj4gKwkJCWlmIChlbnRyeS0+ZmxhZ3MgIT0gcmVxX2Jhcl9mbGFncykKPj4g
KwkJCQljb250aW51ZTsKPj4gKwkJCSpiYXIgPSBlbnRyeS0+YmFyOwo+PiArCQkJKmJhcl9vZmZz
ZXQgPSBsZTY0X3RvX2NwdShlbnRyeS0+b2Zmc2V0KTsKPj4gKwkJCXJldCA9IDA7Cj4+ICsJCQli
cmVhazsKPj4gKwkJfQo+PiArCX0KPj4gKwo+PiArCWtmcmVlKG91dCk7Cj4+ICsJcmV0dXJuIHJl
dDsKPj4gK30KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmZpby9wY2kvdmlydGlvL2NtZC5oIGIv
ZHJpdmVycy92ZmlvL3BjaS92aXJ0aW8vY21kLmgKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4g
aW5kZXggMDAwMDAwMDAwMDAwLi5jMmEzNjQ1ZjRiOTAKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysg
Yi9kcml2ZXJzL3ZmaW8vcGNpL3ZpcnRpby9jbWQuaAo+PiBAQCAtMCwwICsxLDI3IEBACj4+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBMaW51eC1PcGVuSUIKPj4gKy8q
Cj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjMsIE5WSURJQSBDT1JQT1JBVElPTiAmIEFGRklMSUFU
RVMuIEFsbCByaWdodHMgcmVzZXJ2ZWQuCj4+ICsgKi8KPj4gKwo+PiArI2lmbmRlZiBWSVJUSU9f
VkZJT19DTURfSAo+PiArI2RlZmluZSBWSVJUSU9fVkZJT19DTURfSAo+PiArCj4+ICsjaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+Cj4+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvLmg+Cj4+ICsjaW5j
bHVkZSA8bGludXgvdmZpb19wY2lfY29yZS5oPgo+PiArI2luY2x1ZGUgPGxpbnV4L3ZpcnRpb19w
Y2kuaD4KPj4gKwo+PiArc3RydWN0IHZpcnRpb3ZmX3BjaV9jb3JlX2RldmljZSB7Cj4+ICsJc3Ry
dWN0IHZmaW9fcGNpX2NvcmVfZGV2aWNlIGNvcmVfZGV2aWNlOwo+PiArCWludCB2Zl9pZDsKPj4g
K307Cj4+ICsKPj4gK2ludCB2aXJ0aW92Zl9jbWRfbGlzdF9xdWVyeShzdHJ1Y3QgcGNpX2RldiAq
cGRldiwgdTggKmJ1ZiwgaW50IGJ1Zl9zaXplKTsKPj4gK2ludCB2aXJ0aW92Zl9jbWRfbGlzdF91
c2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHU4ICpidWYsIGludCBidWZfc2l6ZSk7Cj4+ICtpbnQg
dmlydGlvdmZfY21kX2xyX3dyaXRlKHN0cnVjdCB2aXJ0aW92Zl9wY2lfY29yZV9kZXZpY2UgKnZp
cnR2ZGV2LCB1MTYgb3Bjb2RlLAo+PiArCQkJICB1OCBvZmZzZXQsIHU4IHNpemUsIHU4ICpidWYp
Owo+PiAraW50IHZpcnRpb3ZmX2NtZF9scl9yZWFkKHN0cnVjdCB2aXJ0aW92Zl9wY2lfY29yZV9k
ZXZpY2UgKnZpcnR2ZGV2LCB1MTYgb3Bjb2RlLAo+PiArCQkJIHU4IG9mZnNldCwgdTggc2l6ZSwg
dTggKmJ1Zik7Cj4+ICtpbnQgdmlydGlvdmZfY21kX2xxX3JlYWRfbm90aWZ5KHN0cnVjdCB2aXJ0
aW92Zl9wY2lfY29yZV9kZXZpY2UgKnZpcnR2ZGV2LAo+PiArCQkJCXU4IHJlcV9iYXJfZmxhZ3Ms
IHU4ICpiYXIsIHU2NCAqYmFyX29mZnNldCk7Cj4+ICsjZW5kaWYgLyogVklSVElPX1ZGSU9fQ01E
X0ggKi8KPj4gLS0gCj4+IDIuMjcuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
