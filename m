Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA5DCD6E46
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 08:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F2CE60FEE;
	Wed, 11 Oct 2023 08:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F2CE60FEE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ja+l+VXA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AW23nx70wtaE; Wed, 11 Oct 2023 08:58:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FA8E60FE9;
	Wed, 11 Oct 2023 08:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FA8E60FE9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 706B6C0071;
	Wed, 11 Oct 2023 08:58:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44887C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEC7B410E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:58:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EEC7B410E3
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Ja+l+VXA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a1lvyEKjdVbR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:58:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::622])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9FD59416CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:58:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FD59416CE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpI+0+iy6SeHbowZxVdrctgh8cXXRcy7ZV+atcD17XirdR8BQwJC7XrdBGOwtQ5CM/twWaMLIyYsahO0PHA8IgvSTkQrJyuBlUzRKWunQnyb5GSreCFqomW63fB530l4iyXpCEGP5ozif84H5dEAfatcsb9VRt5MywH0azB1gqsfXO10jyDmKRd1ot7EFBKHt35tQ9crCogCaDmakW7atXf3PHQmi8wEFXv9qiOGnFS8QeZTT0daP3lXTEjsTWcUuVb6pdYiiDNR4xwDcp0B7vR2BCoav7bCnMeAL7ndYFNAfKWSJI/eWwCLAgWwagCEofCqxAIK/+E7QZnl2eg1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJbYKk7lfhT0twYV+CFhTtdXoHwEQr0SxMJiLqZFprY=;
 b=BBpBtf5WwxE/rmY8rfmFGJlIdPgxIqGdemtazCxE5cxctRQKIg/QWbrbYQEDlXdE8R7F2CfY1aoOjMx7v3UWIZCFiViFfCvD9urHYT/cog3qb+SXkcVSWvMCK2LEAmZmSi+lV4HynERHT2rqBELlf2HJZX3EKObSTiGxRZUmO+Zt/HNKnRUz/YHePJ6Oq6gcIm2bIF3GCuFH6I6qess+Dc3wfbG3J/nIBQNYJQ4QEr/SUJPJbzv9PnpKC7km/WP5veNhnzPrbI/xmOwjgAe3gGMGxAjZpJ0S0fdyforUFNT5ScXd5yCvh9SZHofvdddRfexM3c4qYM9CUaIYRp0ZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJbYKk7lfhT0twYV+CFhTtdXoHwEQr0SxMJiLqZFprY=;
 b=Ja+l+VXA4uA4ZgnMjW7dnLYw7k64NF8r+rxYzsEIkF25lk6G9MhCwX1G/1gn7LHDjw5g5pHrBzJ8lLITe17PZn9z8pyZoRXwYzf/gUdUWivx4PzQ9MRLP1yBxvi/tttlrSdwlmgGyhAiDkZD+oAuX6CNhenN83VAIJdcJeto77sWFJ5PIVAGLGdM20R6DFvyrVOS1VOZDACTCXUc9fsUBdL++5BOJf8nvfmEg74IiJl4LZAL6Fu7zxYSDDEuU1zvRAvvw0+tf6rpBs0wm4PKYCIl34X4mbRRA0a3iy4Qv1x9go/bPFIxNO+hSpCq5ey9B4DAnflWg+zarvBBIuajLA==
Received: from MW4PR03CA0198.namprd03.prod.outlook.com (2603:10b6:303:b8::23)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 08:58:33 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::6) by MW4PR03CA0198.outlook.office365.com
 (2603:10b6:303:b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44 via Frontend
 Transport; Wed, 11 Oct 2023 08:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 08:58:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 01:58:18 -0700
Received: from [172.27.15.31] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 01:58:13 -0700
Message-ID: <0ae3b963-f4fe-19c2-ea79-387a66e142ab@nvidia.com>
Date: Wed, 11 Oct 2023 11:58:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
 <20231010115649-mutt-send-email-mst@kernel.org>
 <5d83d18a-0b5a-6221-e70d-32908d967715@nvidia.com>
 <20231010163914-mutt-send-email-mst@kernel.org>
 <f4247e59-19cd-0d6b-7728-dd1175c9d968@nvidia.com>
 <20231011035737-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231011035737-mutt-send-email-mst@kernel.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: de93e79c-0fae-42bd-22dd-08dbca383fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qsd94v8oPOubzE+qQRsXtmwXx8wBNIHmfiD5MajrQIygDIpe06jU13z2oE76zDeFLGQ03F+qy55hstPINc7xdjeTBcg9fLRMVaAImoKWFLzEBHBol3fMF4RH8U1Lm21ZJowfTPPbUjpc9ercPa2ERG0wG3Tpj/Phz6HXRjWJ3Dum3JT6oMnZrQvQHfatJUN3iyfFp389J8jHSaYk0FtDXPPJnaqAlPPJDzgbXnjrV8qhG4UgPC7neQf7hR8HSx08dRpHHpDqLZ7PkOdCw/vY39rMXXwkmJ24He09YGp00sNdHsfTR2wF2/04UxbPDWq9igl0mSLHL7x5i2VnIqRsEqhh15kgzIK57Y3V1iqydLROFXNMbDJBdU7hlDTMbV7U/xihSD5fD6N+ntmM4wBFBjFIATbEK1sf/MC1y2/lNObZEnkf9S0uffvqScb0kAzaTc+t181ZLqFWO2+RJHDg6VywZAzO5uPYv80QR1gVgNkgayI7pBKxQX9eDEeUdz2A2UKy9T/6IHUuN9JZqgVlPej9SMyZP9gja1socsKwifyWm5rqW7t5YJtxxX1T+CLO4dOHbrR6Mo2WWtl89o1iIdocWu4UQIZ4j9vkcItBzVkxKGlsgSDkQTW8SBBEkbVgVAQShuDDdybRRiC6FRTm1jNyapAvcI6SWBB/Yho0DbwB8EdIwiDgf2iKgHUdA6EUt/Zrt0/PxvsbDeTtjoi2R83KfTo/N/awsBSuURbxfTsPvhHaWlbczA4kDtbyBTSJtaiO5c+pefilxeF1S97oIA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(64100799003)(46966006)(36840700001)(40470700004)(7636003)(86362001)(356005)(36756003)(31696002)(31686004)(16526019)(66899024)(40480700001)(53546011)(8676002)(5660300002)(82740400003)(41300700001)(8936002)(478600001)(2906002)(83380400001)(426003)(26005)(107886003)(16576012)(336012)(2616005)(70206006)(40460700003)(36860700001)(316002)(4326008)(70586007)(47076005)(54906003)(6916009)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 08:58:33.5933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de93e79c-0fae-42bd-22dd-08dbca383fa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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

T24gMTEvMTAvMjAyMyAxMTowMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFdlZCwg
T2N0IDExLCAyMDIzIGF0IDEwOjQ0OjQ5QU0gKzAzMDAsIFlpc2hhaSBIYWRhcyB3cm90ZToKPj4g
T24gMTAvMTAvMjAyMyAyMzo0MiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4gT24gVHVl
LCBPY3QgMTAsIDIwMjMgYXQgMDc6MDk6MDhQTSArMDMwMCwgWWlzaGFpIEhhZGFzIHdyb3RlOgo+
Pj4+Pj4gQXNzdW1pbmcgdGhhdCB3ZSdsbCBwdXQgZWFjaCBjb21tYW5kIGluc2lkZSB2aXJ0aW8g
YXMgdGhlIGdlbmVyaWMgbGF5ZXIsIHdlCj4+Pj4+PiB3b24ndCBiZSBhYmxlIHRvIGNhbGwvdXNl
IHRoaXMgQVBJIGludGVybmFsbHkgdG8gZ2V0IHRoZSBQRiBhcyBvZiBjeWNsaWMKPj4+Pj4+IGRl
cGVuZGVuY2llcyBiZXR3ZWVuIHRoZSBtb2R1bGVzLCBsaW5rIHdpbGwgZmFpbC4KPj4+IEkganVz
dCBtZWFuOgo+Pj4gdmlydGlvX2FkbWluX2xlZ2FjeV9pb193cml0ZShzcnVjdCBwY2lfZGV2aWNl
ICosICAuLi4uKQo+Pj4KPj4+Cj4+PiBpbnRlcm5hbGx5IGl0IHN0YXJ0cyBmcm9tIHZmIGdldHMg
dGhlIHBmIChvciB2ZiBpdHNlbGYgb3Igd2hhdGV2ZXIKPj4+IHRoZSB0cmFuc3BvcnQgaXMpIHNl
bmRzIGNvbW1hbmQgZ2V0cyBzdGF0dXMgcmV0dXJucy4KPj4+Cj4+PiB3aGF0IGlzIGN5Y2xpYyBo
ZXJlPwo+Pj4KPj4gdmlydGlvLXBjaSBkZXBlbmRzIG9uIHZpcnRpbyBbMV0uCj4+Cj4+IElmIHdl
IHB1dCB0aGUgY29tbWFuZHMgaW4gdGhlIGdlbmVyaWMgbGF5ZXIgYXMgd2UgZXhwZWN0IGl0IHRv
IGJlIChpLmUuCj4+IHZpcnRpbyksIHRoZW4gdHJ5aW5nIHRvIGNhbGwgaW50ZXJuYWxseSBjYWxs
IGZvciB2aXJ0aW9fcGNpX3ZmX2dldF9wZl9kZXYoKQo+PiB0byBnZXQgdGhlIFBGIGZyb20gdGhl
IFZGIHdpbGwgZW5kLXVwIGJ5IGEgbGlua2VyIGN5Y2xpYyBlcnJvciBhcyBvZiBiZWxvdwo+PiBb
Ml0uCj4+Cj4+IEFzIG9mIHRoYXQsIHNvbWVvbmUgY2FuIHN1Z2dlc3QgdG8gcHV0IHRoZSBjb21t
YW5kcyBpbiB2aXJ0aW8tcGNpLCBob3dldmVyCj4+IHRoaXMgd2lsbCBmdWxseSBieXBhc3MgdGhl
IGdlbmVyaWMgbGF5ZXIgb2YgdmlydGlvIGFuZCBmdXR1cmUgY2xpZW50cyB3b24ndAo+PiBiZSBh
YmxlIHRvIHVzZSBpdC4KPiB2aXJ0aW9fcGNpIHdvdWxkIGdldCBwY2kgZGV2aWNlLgo+IHZpcnRp
byBwY2kgY29udmVycyB0aGF0IHRvIHZpcnRpbyBkZXZpY2Ugb2Ygb3duZXIgKyBncm91cCBtZW1i
ZXIgaWQgYW5kIGNhbGxzIHZpcnRpby4KCkRvIHlvdSBzdWdnZXN0IGFub3RoZXIgc2V0IG9mIGV4
cG9ydGVkIHN5bWJvbHMgKGkuZSBwZXIgY29tbWFuZCApIGluIAp2aXJ0aW8gd2hpY2ggd2lsbCBn
ZXQgdGhlIG93bmVyIGRldmljZSArIGdyb3VwIG1lbWJlciArIHRoZSBleHRyYSAKc3BlY2lmaWMg
Y29tbWFuZCBwYXJhbWV0ZXJzID8KClRoaXMgd2lsbCBlbmQtdXAgZHVwbGljYXRpbmcgdGhlIG51
bWJlciBvZiBleHBvcnQgc3ltYm9scyBwZXIgY29tbWFuZC4KCj4gbm8gY3ljbGVzIGFuZCBtaW5p
bWFsIHRyYW5zcG9ydCBzcGVjaWZpYyBjb2RlLCByaWdodD8KClNlZSBteSBhYm92ZSBub3RlLCBp
ZiB3ZSBtYXkganVzdCBjYWxsIHZpcnRpbyB3aXRob3V0IGFueSBmdXJ0aGVyIHdvcmsgCm9uIHRo
ZSBjb21tYW5kJ3MgaW5wdXQsIHRoYW4gWUVTLgoKSWYgc28sIHZpcnRpbyB3aWxsIHByZXBhcmUg
dGhlIGNvbW1hbmQgYnkgc2V0dGluZyB0aGUgcmVsZXZhbnQgU0cgbGlzdHMgCmFuZCBvdGhlciBk
YXRhIGFuZCBmaW5hbGx5IHdpbGwgY2FsbDoKCnZkZXYtPmNvbmZpZy0+ZXhlY19hZG1pbl9jbWQo
dmRldiwgY21kKTsKCldhcyB0aGF0IHlvdXIgcGxhbiA/Cgo+Cj4+IEluIGFkZGl0aW9uLCBwYXNz
aW5nIGluIHRoZSBWRiBQQ0kgcG9pbnRlciBpbnN0ZWFkIG9mIHRoZSBWRiBncm91cCBtZW1iZXIg
SUQKPj4gKyB0aGUgVklSVElPIFBGIGRldmljZSwgd2lsbCByZXF1aXJlIGluIHRoZSBmdXR1cmUg
dG8gZHVwbGljYXRlIGVhY2ggY29tbWFuZAo+PiBvbmNlIHdlJ2xsIHVzZSBTSU9WIGRldmljZXMu
Cj4gSSBkb24ndCB0aGluayBhbnlvbmUga25vd3MgaG93IHdpbGwgU0lPViBsb29rLiBCdXQgc2h1
ZmZsaW5nCj4gQVBJcyBhcm91bmQgaXMgbm90IGEgYmlnIGRlYWwuIFdlJ2xsIHNlZS4KCkFzIHlv
dSBhcmUgdGhlIG1haW50YWluZXIgaXQncyB1cC10by15b3UsIGp1c3QgbmVlZCB0byBjb25zaWRl
ciBhbm90aGVyIApmdXJ0aGVyIGR1cGxpY2F0aW9uIGhlcmUuCgpZaXNoYWkKCj4KPj4gSW5zdGVh
ZCwgd2Ugc3VnZ2VzdCB0aGUgYmVsb3cgQVBJIGZvciB0aGUgYWJvdmUgZXhhbXBsZS4KPj4KPj4g
dmlydGlvX2FkbWluX2xlZ2FjeV9pb193cml0ZSh2aXJ0aW9fZGV2aWNlICp2aXJ0aW9fZGV2LMKg
IHU2NAo+PiBncm91cF9tZW1iZXJfaWQswqAgLi4uLikKPj4KPj4gWzFdCj4+IFt5aXNoYWloQHJl
Zy1sLXZydC0yMDkgbGludXhdJCBtb2RpbmZvIHZpcnRpby1wY2kKPj4gZmlsZW5hbWU6IC9saWIv
bW9kdWxlcy82LjYuMC1yYzIrL2tlcm5lbC9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpLmtvCj4+
IHZlcnNpb246wqDCoMKgwqDCoMKgwqAgMQo+PiBsaWNlbnNlOsKgwqDCoMKgwqDCoMKgIEdQTAo+
PiBkZXNjcmlwdGlvbjrCoMKgwqAgdmlydGlvLXBjaQo+PiBhdXRob3I6wqDCoMKgwqDCoMKgwqDC
oCBBbnRob255IExpZ3VvcmkgPGFsaWd1b3JpQHVzLmlibS5jb20+Cj4+IHNyY3ZlcnNpb246wqDC
oMKgwqAgNzM1NUVBQzk0MDhEMzg4OTE5MzgzOTEKPj4gYWxpYXM6wqDCoMKgwqDCoMKgwqDCoMKg
IHBjaTp2MDAwMDFBRjRkKnN2KnNkKmJjKnNjKmkqCj4+IGRlcGVuZHM6IHZpcnRpb19wY2lfbW9k
ZXJuX2Rldix2aXJ0aW8sdmlydGlvX3JpbmcsdmlydGlvX3BjaV9sZWdhY3lfZGV2Cj4+IHJldHBv
bGluZTrCoMKgwqDCoMKgIFkKPj4gaW50cmVlOsKgwqDCoMKgwqDCoMKgwqAgWQo+PiBuYW1lOsKg
wqDCoMKgwqDCoMKgwqDCoMKgIHZpcnRpb19wY2kKPj4gdmVybWFnaWM6wqDCoMKgwqDCoMKgIDYu
Ni4wLXJjMisgU01QIHByZWVtcHQgbW9kX3VubG9hZCBtb2R2ZXJzaW9ucwo+PiBwYXJtOsKgwqDC
oMKgwqDCoMKgwqDCoMKgIGZvcmNlX2xlZ2FjeTpGb3JjZSBsZWdhY3kgbW9kZSBmb3IgdHJhbnNp
dGlvbmFsIHZpcnRpbyAxCj4+IGRldmljZXMgKGJvb2wpCj4+Cj4+IFsyXQo+Pgo+PiBkZXBtb2Q6
IEVSUk9SOiBDeWNsZSBkZXRlY3RlZDogdmlydGlvIC0+IHZpcnRpb19wY2kgLT4gdmlydGlvCj4+
IGRlcG1vZDogRVJST1I6IEZvdW5kIDIgbW9kdWxlcyBpbiBkZXBlbmRlbmN5IGN5Y2xlcyEKPj4g
bWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLm1vZGluc3Q6MTI4OiBkZXBtb2RdIEVycm9y
IDEKPj4gbWFrZVsxXTogKioqIFsvaW1hZ2VzL3lpc2hhaWgvc3JjL2tlcm5lbC9saW51eC9NYWtl
ZmlsZToxODIxOgo+PiBtb2R1bGVzX2luc3RhbGxdIEVycm9yIDIKPj4KPj4gWWlzaGFpCj4gdmly
dGlvIGFic29sdXRlbHkgbXVzdCBub3QgZGVwZW5kIG9uIHZpcnRpbyBwY2ksIGl0IGlzIHVzZWQg
b24KPiBzeXN0ZW1zIHdpdGhvdXQgcGNpIGF0IGFsbC4KPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
