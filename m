Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D649ACD98F6
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 07:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E65E4091D;
	Wed, 11 Oct 2023 07:45:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E65E4091D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TB7WxPFV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zzAp9-IhQFih; Wed, 11 Oct 2023 07:45:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 50DD240541;
	Wed, 11 Oct 2023 07:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50DD240541
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A7ABC0039;
	Wed, 11 Oct 2023 07:45:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED940C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 07:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8FAD404FE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 07:45:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8FAD404FE
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=TB7WxPFV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mLvf1EHPRqHm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 07:45:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5DCF40289
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 07:45:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5DCF40289
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIvPB8UE4DmUiE+NlU2QSW5t1lJnOCkHEkOTfyo1AewWMmwFJW20HcKgFBAYf725ERuJ1AOWjA8/MsuN7vQVzD4hep07aMml0E5LNBYx95WaS1Cf+ahlZI0BT51eAirSXjqmkldtZf7g0rS2/sRby4EPBmwW/hcPYP3XM/QhH1aWc3WbmJIGo42DTzi9+fWvRni1FtWmwMhEBLhg/Eq/srgh9fp/KJZDhm3vTSwuHDvwbQZPmks3pwYmJOyxjjXzKMmyoSuHKVx67/NFHQl2f+98VL6i7PAlIye0rXtTvnKAclnKO6iP4j3RPVfgmhFSzggj52ntZPjkE3BiVXBFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRet0gxe7aaD75y9OL6DRmiiK4iAlbrGQcNBX4GjUO4=;
 b=FbdC3Bh/euRqKj/z4bVV8QLzfjI7Ib6STKtd3Tt1nwmKTwcIs64Q+w4k7FdUjQj7uiKncJ1sjUCz/gUen6z3QNjP2PwQQaX2XTt0Je2CngGOBliYgXCusPNOq9X6adISGiY2U/JG58IsMyVpdo8WxqatptnyKSO2D0RL68aZa+/1WeoNmd/HmEoJWGyQ1izNMdA+z18CHmfwYY+IVAZGdrFH3huofnAFw7eTAQT7ddOBDkYZU6lOStkCDQ82JsyO5cLyGqYboPh0YVwMOJWYR57GvHWoDLhesw0JL5WCS7NSSCBIOBUCUO1GajkmREq9vInbSDnwqE++/Zd7RJw1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRet0gxe7aaD75y9OL6DRmiiK4iAlbrGQcNBX4GjUO4=;
 b=TB7WxPFVdh4r5qPItztdHGXn/QJBXGi8aXIMpvdVs16ktEh9w3DY09Im1dsZ1FAMYxyHSJK726+vC5IHlUdBYTAnG94WaJCNTwRZBO7NMoTSTOf8Vz0DpnYuSawzTBM8Z5FDchsqVGVSS6Mfq07vvOFCxHFsXGeMzF22k7K2NiKTZDhl7nY8bo/wozwOzQY62SKMRVPh/Eaao8LewQxz4MTGWskLZS3kGzx8LsdTaUqYN4ycNJcoVQWIn8S7o3udHbtRT9eud4OZrepMSlyZhENR7zX58JoGHc6FWWA7CZRLVgjOFr+nOE59x3O/fkp0jI5MF2SHNmiCj7B0YBwJ3A==
Received: from MW4PR04CA0390.namprd04.prod.outlook.com (2603:10b6:303:81::35)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 07:45:12 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::b0) by MW4PR04CA0390.outlook.office365.com
 (2603:10b6:303:81::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Wed, 11 Oct 2023 07:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 07:45:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 00:44:57 -0700
Received: from [172.27.15.31] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 00:44:52 -0700
Message-ID: <f4247e59-19cd-0d6b-7728-dd1175c9d968@nvidia.com>
Date: Wed, 11 Oct 2023 10:44:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
 <20231010115649-mutt-send-email-mst@kernel.org>
 <5d83d18a-0b5a-6221-e70d-32908d967715@nvidia.com>
 <20231010163914-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231010163914-mutt-send-email-mst@kernel.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: f14aac6d-aeb0-4a4a-dcb0-08dbca2e0009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgbbIbSckNEtGXr2etEkxQP7CYHmIWuFEA3xavLYRb1cRNS5Eu7bomWLzxqj5sP6dfNKshFgcAE4LxuumaY50IdPSVdxI4+jmPDPwQJR34+3S73NA/YeHfTCv226YChqT7IlcahTjFwQKnS+f8UoklvZN9lP6WF7AF3T0nDaCJTedlo256oybqC6G/yj8h9/KeG3tg3ZT9vGb2nCMSJmJ3jLn9AXJSgTHBGwrnxob7tsqVeNWhAFGfdAKlergL7G/xMZfY30vTTCJlEpFeC6Wl8mQfq9mQse9CuA0+v08ZOiNg10Cpa8+lezYIK3AN/3aGtNLzf5ZcFAH71xLaauIPAjo338xJBD2+SoxiYVQhGl0XqC9NpAqcEmFk0I4xjIodwnsuzcEua9wyNYMTi3E7PnDY8zmB3fi53UFxyMcHslZignYQW0dfR+SUYjfJUf4RM+1UAyyZPiFBSXjkN05ZHqQr/fvvKt4TC+ku8QrzzN73GNqXUSVnnmVyzKMbLgNM7lRb6UKDkJGOmd/QOwgiIf/MX+0WXYRfsYpiHtRafpf1iit96Q4bQP7asn/+MApZIKyyTVaQwZ9cFQbM2ciC4qBPfxtCU15HrNv4Rg0f8mug0Y7RPf8zJmsYGdeVRl2dKvpZZD0Rxp7BjgLVWyKL2KNFlZz9sarPslKtqeJgzXR+osECMQdRKmTbVxzx/nUB+LeMuBa3U17GSWCs+DLeEnZakyQAPDGWh0mmVfE9Yz9EpkzVQnLvP8osyVUpUNBFEeiIX9AUDSgPynK/GKCA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(36860700001)(41300700001)(31686004)(2616005)(26005)(7636003)(16526019)(336012)(53546011)(426003)(40460700003)(31696002)(82740400003)(86362001)(5660300002)(36756003)(40480700001)(356005)(2906002)(4326008)(70586007)(6666004)(83380400001)(107886003)(47076005)(478600001)(8676002)(6916009)(316002)(54906003)(70206006)(16576012)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 07:45:11.9447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14aac6d-aeb0-4a4a-dcb0-08dbca2e0009
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435
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

T24gMTAvMTAvMjAyMyAyMzo0MiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9uIFR1ZSwg
T2N0IDEwLCAyMDIzIGF0IDA3OjA5OjA4UE0gKzAzMDAsIFlpc2hhaSBIYWRhcyB3cm90ZToKPj4+
PiBBc3N1bWluZyB0aGF0IHdlJ2xsIHB1dCBlYWNoIGNvbW1hbmQgaW5zaWRlIHZpcnRpbyBhcyB0
aGUgZ2VuZXJpYyBsYXllciwgd2UKPj4+PiB3b24ndCBiZSBhYmxlIHRvIGNhbGwvdXNlIHRoaXMg
QVBJIGludGVybmFsbHkgdG8gZ2V0IHRoZSBQRiBhcyBvZiBjeWNsaWMKPj4+PiBkZXBlbmRlbmNp
ZXMgYmV0d2VlbiB0aGUgbW9kdWxlcywgbGluayB3aWxsIGZhaWwuCj4gSSBqdXN0IG1lYW46Cj4g
dmlydGlvX2FkbWluX2xlZ2FjeV9pb193cml0ZShzcnVjdCBwY2lfZGV2aWNlICosICAuLi4uKQo+
Cj4KPiBpbnRlcm5hbGx5IGl0IHN0YXJ0cyBmcm9tIHZmIGdldHMgdGhlIHBmIChvciB2ZiBpdHNl
bGYgb3Igd2hhdGV2ZXIKPiB0aGUgdHJhbnNwb3J0IGlzKSBzZW5kcyBjb21tYW5kIGdldHMgc3Rh
dHVzIHJldHVybnMuCj4KPiB3aGF0IGlzIGN5Y2xpYyBoZXJlPwo+CnZpcnRpby1wY2kgZGVwZW5k
cyBvbiB2aXJ0aW8gWzFdLgoKSWYgd2UgcHV0IHRoZSBjb21tYW5kcyBpbiB0aGUgZ2VuZXJpYyBs
YXllciBhcyB3ZSBleHBlY3QgaXQgdG8gYmUgKGkuZS4gCnZpcnRpbyksIHRoZW4gdHJ5aW5nIHRv
IGNhbGwgaW50ZXJuYWxseSBjYWxsIGZvciAKdmlydGlvX3BjaV92Zl9nZXRfcGZfZGV2KCkgdG8g
Z2V0IHRoZSBQRiBmcm9tIHRoZSBWRiB3aWxsIGVuZC11cCBieSBhIApsaW5rZXIgY3ljbGljIGVy
cm9yIGFzIG9mIGJlbG93IFsyXS4KCkFzIG9mIHRoYXQsIHNvbWVvbmUgY2FuIHN1Z2dlc3QgdG8g
cHV0IHRoZSBjb21tYW5kcyBpbiB2aXJ0aW8tcGNpLCAKaG93ZXZlciB0aGlzIHdpbGwgZnVsbHkg
YnlwYXNzIHRoZSBnZW5lcmljIGxheWVyIG9mIHZpcnRpbyBhbmQgZnV0dXJlIApjbGllbnRzIHdv
bid0IGJlIGFibGUgdG8gdXNlIGl0LgoKSW4gYWRkaXRpb24sIHBhc3NpbmcgaW4gdGhlIFZGIFBD
SSBwb2ludGVyIGluc3RlYWQgb2YgdGhlIFZGIGdyb3VwIAptZW1iZXIgSUQgKyB0aGUgVklSVElP
IFBGIGRldmljZSwgd2lsbCByZXF1aXJlIGluIHRoZSBmdXR1cmUgdG8gCmR1cGxpY2F0ZSBlYWNo
IGNvbW1hbmQgb25jZSB3ZSdsbCB1c2UgU0lPViBkZXZpY2VzLgoKSW5zdGVhZCwgd2Ugc3VnZ2Vz
dCB0aGUgYmVsb3cgQVBJIGZvciB0aGUgYWJvdmUgZXhhbXBsZS4KCnZpcnRpb19hZG1pbl9sZWdh
Y3lfaW9fd3JpdGUodmlydGlvX2RldmljZSAqdmlydGlvX2RldizCoCB1NjQgCmdyb3VwX21lbWJl
cl9pZCzCoCAuLi4uKQoKWzFdCgpbeWlzaGFpaEByZWctbC12cnQtMjA5IGxpbnV4XSQgbW9kaW5m
byB2aXJ0aW8tcGNpCmZpbGVuYW1lOiAvbGliL21vZHVsZXMvNi42LjAtcmMyKy9rZXJuZWwvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaS5rbwp2ZXJzaW9uOsKgwqDCoMKgwqDCoMKgIDEKbGljZW5z
ZTrCoMKgwqDCoMKgwqDCoCBHUEwKZGVzY3JpcHRpb246wqDCoMKgIHZpcnRpby1wY2kKYXV0aG9y
OsKgwqDCoMKgwqDCoMKgwqAgQW50aG9ueSBMaWd1b3JpIDxhbGlndW9yaUB1cy5pYm0uY29tPgpz
cmN2ZXJzaW9uOsKgwqDCoMKgIDczNTVFQUM5NDA4RDM4ODkxOTM4MzkxCmFsaWFzOsKgwqDCoMKg
wqDCoMKgwqDCoCBwY2k6djAwMDAxQUY0ZCpzdipzZCpiYypzYyppKgpkZXBlbmRzOiB2aXJ0aW9f
cGNpX21vZGVybl9kZXYsdmlydGlvLHZpcnRpb19yaW5nLHZpcnRpb19wY2lfbGVnYWN5X2Rldgpy
ZXRwb2xpbmU6wqDCoMKgwqDCoCBZCmludHJlZTrCoMKgwqDCoMKgwqDCoMKgIFkKbmFtZTrCoMKg
wqDCoMKgwqDCoMKgwqDCoCB2aXJ0aW9fcGNpCnZlcm1hZ2ljOsKgwqDCoMKgwqDCoCA2LjYuMC1y
YzIrIFNNUCBwcmVlbXB0IG1vZF91bmxvYWQgbW9kdmVyc2lvbnMKcGFybTrCoMKgwqDCoMKgwqDC
oMKgwqDCoCBmb3JjZV9sZWdhY3k6Rm9yY2UgbGVnYWN5IG1vZGUgZm9yIHRyYW5zaXRpb25hbCB2
aXJ0aW8gMSAKZGV2aWNlcyAoYm9vbCkKClsyXQoKZGVwbW9kOiBFUlJPUjogQ3ljbGUgZGV0ZWN0
ZWQ6IHZpcnRpbyAtPiB2aXJ0aW9fcGNpIC0+IHZpcnRpbwpkZXBtb2Q6IEVSUk9SOiBGb3VuZCAy
IG1vZHVsZXMgaW4gZGVwZW5kZW5jeSBjeWNsZXMhCm1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5tb2RpbnN0OjEyODogZGVwbW9kXSBFcnJvciAxCm1ha2VbMV06ICoqKiBbL2ltYWdlcy95
aXNoYWloL3NyYy9rZXJuZWwvbGludXgvTWFrZWZpbGU6MTgyMTogCm1vZHVsZXNfaW5zdGFsbF0g
RXJyb3IgMgoKWWlzaGFpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
