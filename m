Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39613C433EF
	for <virtualization@archiver.kernel.org>; Fri, 13 May 2022 18:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0CBD60C18;
	Fri, 13 May 2022 18:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nDvUGmdfSygO; Fri, 13 May 2022 18:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B70D60BCD;
	Fri, 13 May 2022 18:25:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 387C6C0039;
	Fri, 13 May 2022 18:25:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 260CCC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 18:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18AC140605
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 18:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id de7p5reSSg1A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 18:25:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11B0D40354
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 18:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7BWKEvdI9omtZiXBWch6+QU7ccRkl2Xc7NNvo0XXCU6EVcsSG45hjd4mC3U/TYya8oWzglvB1XZ2EQWT4f/9VgJidwTBTOcyRKSGVkMtV3cC4GrIp5QktTk7SmdYHCaweKP93UtIxARnGwTmlgPswGArSA8UeZ2pPFjD1eG0epgP7wINHXsnukBQqnkkJuAQDk4BqcUsvJn1myPPldVOPeeoZQAe2pRmy17Tmjg4VxnFfsOQGeBkqR6/6F13/niYQdfC4OeOvNXZVEDhdhUHENasZ24cDaWSVMskhRHQN+l3Csvj+4GzyNJwJ9jXUrrOtYzdziGrEyAhtKHzpuTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGyMBFkWpaQunby1CfFNDkXXg3Kh3XocyctvmC6Iwo4=;
 b=MFdDRDI7ucXlXw9q2w5208MJDefGCPlheplULEDOYYq1rtpiZNySZqvOTd0GOeqi4VEZXE4a69Pq071wIoxeU++uav5qNOulpqp0mj0aYGnChijkbAGAz3F22dE/IDhulhWbyo9oB7sHJZDiJqBWFEbnV5tq/IZv0gEpWlY+P8r8gPKUyfviOVQaTF2xLuqACggYlCtohFxRWXItqRsXqckhBmn/0Bw+VynSAzcf9z2RSXtVRKMEK0nISaW/Wp+S976sNm+SocEIdfyNF1rLe/rI+x+byYCKxC6jF4YZz/OhY2AZP7rFlkED3d7RndxvS/8KHwzC2FquTWe6mFm2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGyMBFkWpaQunby1CfFNDkXXg3Kh3XocyctvmC6Iwo4=;
 b=n8bL3/LbMpzXp7QyYUONnzT4JdBdVDL8GT0yGBvoSEflhb8Y/r1AEpEVEz1QsrZppgOKhoO1bg0PsZGMPq+IwNKnmqSQd8MSVVnofejLm0C4RW+kEUHNGjaIFmMleeI9p7XmKb5lt2aWW2eoHELMIKXSk8KBBIi4oE+Li6/skwQ7zyI6nU/8uOgvjX4iU1bCjIuYyByoUElZx3v9nmn5OgU8gKTfYwWpkD8AjojSSAvyV7789t1QZ53bF8A0NcuuO2AH2cxht9as2LBXA37pOZeCgnZrZ9v8wRQcxguEMwUERMbj9TYhikHP67+UjX8TrOGCmfgaiK0s71iCtQbqcw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 18:25:45 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5250.016; Fri, 13 May 2022
 18:25:45 +0000
To: Gautam Dawar <gdawar@xilinx.com>, Eugenio Perez Martin
 <eperezma@redhat.com>, virtualization
 <virtualization@lists.linux-foundation.org>, qemu-level
 <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Cindy Lu
 <lulu@redhat.com>, "virtio-networking@redhat.com"
 <virtio-networking@redhat.com>, Eli Cohen <elic@nvidia.com>, Laurent Vivier
 <lvivier@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: RE: About restoring the state in vhost-vdpa device
Thread-Topic: About restoring the state in vhost-vdpa device
Thread-Index: AQHYZW+JxbBQ1h+RIkS7iyhFOVHKbK0c5lPggAAyGwCAAAYJcA==
Date: Fri, 13 May 2022 18:25:45 +0000
Message-ID: <PH0PR12MB54811C88B389ACB495BD5AB2DCCA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <CAJaqyWcbqzvtyHcU3t1TF7Mqm2_sBX57rN8S6hHB8NXxgi=tyQ@mail.gmail.com>
 <PH0PR12MB5481AF0B02B0FB00885FF2AEDCCA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BY5PR02MB698052EE53B707C6C04C3C8CB1CA9@BY5PR02MB6980.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB698052EE53B707C6C04C3C8CB1CA9@BY5PR02MB6980.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75dd7c0d-e6c8-452c-f3ff-08da350dfef4
x-ms-traffictypediagnostic: MN2PR12MB3117:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3117F12683898413B5D8EEEFDCCA9@MN2PR12MB3117.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7bG59kjT9B7qcaEUsfO1MaqgY8coYY6aVni47DY+WDEW3obHI/VekHRWP+x2Ke7oQp/rgnFdyNfvD3QzPWVxWvrlfjDDIwvYI4dvrAOBCXhKm9Jj7nDY83nG+WOdkqWk+Oj7k3CSG2SCJxnP6VdrPboDs4iyAD77im5PKqnb4VmKA70oC5JYtVG2St7K/6abRKlE9Evxm5XRXgOJdFZzkW1LZROVeBvpbrFWOrfVV92DdNNlFeyOnRaxl9se0guDq8OHPrUy87sPHrfzZzN36XiyuCBr7z++rG/wDDspm/Ctx2q0U/91trSGMGtmM91R55f75MPWS0n8+2itQ5VBw4iaJhyDu94uPpzPEuZ3SMuEVMOeZwmDWvxxDfWkzWA3NSfZ1mYwNhMDFsGV4tl5vUNVWE6k6y9NoFbFw7Ce3rg4RqjV3cEGY9x2BXu/tz85vAKzOn/ZaGXqoCtiovaasGg7lIuzKIBNpAZEhu9cONGsX1g+l3/XVNbxyl+gBk9dMWBoQ5rN7Dphslu0Sw+dOF4qu2g73IAXy/n6mHkuDzH2WLJlLbHmuqjQlFC3IVibFUQnKqY1PMvfh5HZYjt+5XX8eu8R+pc/fzIQOuEd0RjxyvU7Dw6MwBnXXpL9Mjh2YK1BOeB7g+CjOewne8TiNL2zD/MlXfHruULag3MKomLe4JRPSYOEJ675npAFq4Cl1/3y7gnxnYLnRhz+uY4vzHaPc1IKm4+EF0LGI/O+M0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(8676002)(76116006)(66946007)(5660300002)(66556008)(66446008)(66476007)(64756008)(83380400001)(316002)(52536014)(8936002)(71200400001)(110136005)(508600001)(55016003)(2906002)(9686003)(6506007)(122000001)(38100700002)(7696005)(38070700005)(86362001)(186003)(921005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVhLWGNxM2xMSklXN0QzeTJxMHVZTUtYcEJFdUw2VVVzZlN6QkRSVm93ZnFw?=
 =?utf-8?B?d01iOFA4QUo2WUlCWFFoV09UVHJ3dVY2NTZRRnpFL0xCamNUTkZxQm1hNkl2?=
 =?utf-8?B?YktMYVgvTWpYMWozdFI1UnRJSjlwRHZwc05OcEt6OXJXK2Y1dy9PVUx6VU0w?=
 =?utf-8?B?SzJyNXNHbW9yYi90ZDhpWWZsYjIvVjNEb1ZLVHBRVjZVVFllVGJXNXJERjVj?=
 =?utf-8?B?SktkZnQ1TENTUk5IN0JsSXo2bTUxMHBaVFNjNVBGbEI0UGN3K2haUW1iQ3Zi?=
 =?utf-8?B?eENCOUduMDdEdUkxbWVmWkFSYzBLRkhYcWNPVk9OTjFQNmdBL0JvNWhSTXRj?=
 =?utf-8?B?eFdJNm9kME1JblBvditXVnpiY2NOd0FHZy9yaGx3SE44OW9FQ1hrZFIxU2JF?=
 =?utf-8?B?Zk1TdWdRY0ZoVVJUNmg1WkF6NnNjU3FsZGtIL3BiT3htSFd3S3M1V2h5d3Bv?=
 =?utf-8?B?czhjdHB4ZURoWkVIU3QyRUpEdWhidWtLeVBzM2RLR1ZJQWFBV0c0L2NJRFB2?=
 =?utf-8?B?OXpCck9ReUJ4NU5JcGp4a09NbWxrNVRmL1BvZVZjVVY1MkVZMXdMWUtyOG1J?=
 =?utf-8?B?ZW14SEViOGpyMDh6dHozRENzYmltVlpLaDBWQ1BLVmFST0xlVExuS200R1kr?=
 =?utf-8?B?TEs1cktCUFNDSVlPY0xPcVh0WXFlemtESFhocEJRejAyL3RPaERXY0ZocFln?=
 =?utf-8?B?aTdlTUFXM2cvcDFNaTBsck9ZbjMwMDdUb0JTQ3BNM2tzZHRYZ2g0S242aHBs?=
 =?utf-8?B?WWRCVDVvUGIvVDlIUG56ZExWQXpLcGRyMmh1TUlOeHRnbVJScEErNTlEZEZK?=
 =?utf-8?B?Um5Mb3VYd2QzNUovNkRtVitMSHQ3d2N4bzd5ZE5jaXJDL1BTcGY2RWkxUDkv?=
 =?utf-8?B?N0Vwa09ob1N6SytPbFFFTnlENnM3ZW1kTFdndlJpdHJPOVMzb2F2cjRZckE2?=
 =?utf-8?B?UmZtUG5HbXJ3QXNaUjFmWml4Z0lDdHFtb0t4YnhtcHBIVnI2cGhmTC9DbGVF?=
 =?utf-8?B?eG9qaFBVOVB1djVKUThoWEZKNU10NDlmOG1xZmd2WXRnUW44VHRtdy93MVV0?=
 =?utf-8?B?WjBrM2xGdDd5N2NZY3A0TzkwczZ0c3RFblUyek04SEZ3dEJVbzZJSXBtZERY?=
 =?utf-8?B?RUZhUzc1SThNbUI4NzdNMUdvTjBNa2NIMS9Fa3FaSWIrc3pkeWVHTUI4TXZ3?=
 =?utf-8?B?aFo2NmpSaWU1eEJJakZia0ZqbCswSHlyMWhMd1FvZGRFZDRjOGdESCtVajNB?=
 =?utf-8?B?M0VBL2V0aTR6NEI1OVZJZVp4bTgvVjkxNlozei8vNjdSOHVPZzF2ZGRDTlBq?=
 =?utf-8?B?cFJGTStMeFNZd1ZYem9ERUUyWDdiYjNDMDFoSE5XTDExUjNOZ2drWEJEaG04?=
 =?utf-8?B?anFHRHJPWDlWZFR3NkdSZ1BjZit1aDJ6MHlNZC9EVGJYMXhsWnBHMk01YVBm?=
 =?utf-8?B?UVlpTzVURFJsdDlnc1JaREUrUXI1TVNpTEpxNEFxcVZIOEt6SUllaEdWaCtO?=
 =?utf-8?B?VFdhcFJoSWFOYlNOWXFTYTBhT2lCeDJlQ3d3UDBXc20xU012OTdKT2pKOStX?=
 =?utf-8?B?cFQ5QUlrakJHbllyQ1Q0eXdVaG9tREtXNE92U0lpSVBrZllDeDZoTVhiNjdq?=
 =?utf-8?B?cHBCT0ZodW1ibDVha1lZZmhwcVQ1c3k2dWdWalI3Yms0aWhIUklQVXdtbmx3?=
 =?utf-8?B?TzNxcENIOTRhcXdZY3RWZU9KbDUya2JJQ1NPSkNCdE9kYUNVd3dERGF1R3dp?=
 =?utf-8?B?UGZVSHRIRVZ5OEtITENhdTl0dmY0NEsyU1V4c3FSR1dwaCtwY1ZVTVllU0hC?=
 =?utf-8?B?N0kyK29xWEl5YThNYy9Cc1VLL2hHQkdnYUR2SkRWY0VlS1ZaZEJVOW1abU1q?=
 =?utf-8?B?WTdXTCs4VWdPeTg1dEF3eHdPQTA2ZGVUbXNXdEh0MDB0RkRheGhUczJYWVAw?=
 =?utf-8?B?c3YwdVRjVjZPRW8vVmJaZFdDSW1ndkc1ZTlFTmtpazRGYUlFZlA3ekYxSks1?=
 =?utf-8?B?Q0RybTJ3dnI2V1dtQWxOUXZ1a1RjM1ArNi9TNkNpclZ5V2Fuamtzb3ZFc0hm?=
 =?utf-8?B?T1A1VDI0V1VmbitpZHdmZTBQb201dm9LRm5BYnZUYm13ZmR4TVBZaGl2UjRZ?=
 =?utf-8?B?SXdwMjkzb0NlR08vSTJ2MlJvUDY4NUpRUVJMT1pDa3BlVGRoMytPYWFsZTB1?=
 =?utf-8?B?VzAwM2hqY2hyeThmYW4xemFJNWhPWXhkZjM0ejNVcGtZU3VNaWV6Qm9GTWg0?=
 =?utf-8?B?UFJsY0JTYVNTd1FjTGdScVp3ejZHL0ZpRXFhUFhrTmg1ZFVhSEtvbStGMmR3?=
 =?utf-8?B?UTY4VHdjUDIzaUwvTmJURWR3RzRwWlIzSVNJa1l6emhyNHlqaGh2WmhCRUlQ?=
 =?utf-8?Q?fNUtk0jywSt4Q3dtaa28S8ZSCHmLcYKaHmRoC?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dd7c0d-e6c8-452c-f3ff-08da350dfef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 18:25:45.4035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFbBzS3hHffmPxGzUDnb8WvY9aWMMJv/igeRDp1n3eV88i9pj2HKtKyAzVnjerxdAwmCl656XdQPNJ6XCdW4ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3117
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgR2F1dGFtLA0KDQpQbGVhc2UgZml4IHlvdXIgZW1haWwgY2xpZW50IHRvIGhhdmUgcmlnaHQg
cmVzcG9uc2UgZm9ybWF0Lg0KT3RoZXJ3aXNlLCBpdCB3aWxsIGJlIGNvbmZ1c2luZyBmb3IgdGhl
IHJlc3QgYW5kIHVzIHRvIGZvbGxvdyB0aGUgY29udmVyc2F0aW9uLg0KDQpNb3JlIGJlbG93Lg0K
DQo+IEZyb206IEdhdXRhbSBEYXdhciA8Z2Rhd2FyQHhpbGlueC5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgTWF5IDEzLCAyMDIyIDE6NDggUE0NCg0KPiA+IE91ciBwcm9wb3NhbCBkaXZlcmdlIGluIHN0
ZXAgNzogSW5zdGVhZCBvZiBlbmFibGluZyAqYWxsKiB0aGUNCj4gPiB2aXJ0cXVldWVzLCBvbmx5
IGVuYWJsZSB0aGUgQ1ZRLg0KPiBKdXN0IHRvIGRvdWJsZSBjaGVjaywgVlEgMCBhbmQgMSBvZiB0
aGUgbmV0IGFyZSBhbHNvIG5vdCBlbmFibGVkLCBjb3JyZWN0Pw0KPiBbR0Q+Pl0gWWVzLCB0aGF0
J3MgbXkgdW5kZXJzdGFuZGluZyBhcyB3ZWxsLg0KPiANCj4gPiBBZnRlciB0aGF0LCBzZW5kIHRo
ZSBEUklWRVJfT0sgYW5kIHF1ZXVlIGFsbCB0aGUgY29udHJvbCBjb21tYW5kcyB0bw0KPiA+IHJl
c3RvcmUgdGhlIGRldmljZSBzdGF0dXMgKE1RLCBSU1MsIC4uLikuIE9uY2UgYWxsIG9mIHRoZW0g
aGF2ZSBiZWVuDQo+ID4gYWNrbm93bGVkZ2VkICgiZGV2aWNlIiwgb3IgZW11bGF0ZWQgY3ZxIGlu
IGhvc3QgdmRwYSBiYWNrZW5kIGRyaXZlciwNCj4gPiBoYXMgdXNlZCBhbGwgY3ZxIGJ1ZmZlcnMs
IGVuYWJsZSAoU0VUX1ZSSU5HX0VOQUJMRSwgc2V0X3ZxX3JlYWR5KSBhbGwNCj4gPiBvdGhlciBx
dWV1ZXMuDQo+ID4NCj4gV2hhdCBpcyBzcGVjaWFsIGFib3V0IGRvaW5nIERSSVZFUl9PSyBhbmQg
ZW5xdWV1aW5nIHRoZSBjb250cm9sDQo+IGNvbW1hbmRzPw0KPiBXaHkgb3RoZXIgY29uZmlndXJh
dGlvbiBjYW5ub3QgYmUgYXBwbGllZCBiZWZvcmUgRFJJVkVSX09LPw0KPiBbR0Q+Pl0gRm9yIHRo
ZSBkZXZpY2UgdG8gYmUgbGl2ZSAoYW5kIGFueSBxdWV1ZSB0byBiZSBhYmxlIHRvIHBhc3MgdHJh
ZmZpYyksDQo+IERSSVZFUl9PSyBpcyBhIG11c3QuIA0KVGhpcyBhcHBsaWVzIG9ubHkgdG8gdGhl
IHZkcGEgZGV2aWNlIGltcGxlbWVudGVkIG92ZXIgdmlydGlvIGRldmljZS4NCkZvciBzdWNoIHVz
ZSBjYXNlL2ltcGxlbWVudGF0aW9uIGFueXdheSBhIHByb3BlciB2aXJ0aW8gc3BlYyBleHRlbnNp
b24gaXMgbmVlZGVkIGZvciBpdCBiZSBlZmZpY2llbnQuDQpBbmQgd2hhdCB0aGF0IGhhcHBlbnMg
dGhpcyBzY2hlbWUgd2lsbCBzdGlsbCB3b3JrLg0KDQpPdGhlciB2ZHBhIGRldmljZXMgZG9lc27i
gJl0IGhhdmUgdG8gbGl2ZSB3aXRoIHRoaXMgbGltaXRhdGlvbiBhdCB0aGlzIG1vbWVudC4NCg0K
PiBTbywgYW55IGNvbmZpZ3VyYXRpb24gY2FuIGJlIHBhc3NlZCBvdmVyIHRoZSBDVlEgb25seQ0K
PiBhZnRlciBpdCBpcyBzdGFydGVkICh2cmluZyBjb25maWd1cmF0aW9uICsgRFJJVkVSX09LKS4g
Rm9yIGFuIGVtdWxhdGVkIHF1ZXVlLA0KPiBpZiB0aGUgb3JkZXIgaXMgcmV2ZXJzZWQsIEkgdGhp
bmsgdGhlIGVucXVldWVkIGNvbW1hbmRzIHdpbGwgcmVtYWluDQo+IGJ1ZmZlcmVkIGFuZCBkZXZp
Y2Ugc2hvdWxkIGJlIGFibGUgdG8gc2VydmljZSB0aGVtIHdoZW4gaXQgZ29lcyBsaXZlLg0KSSBs
aWtlbHkgZGlkbuKAmXQgdW5kZXJzdGFuZCB3aGF0IHlvdSBkZXNjcmliZSBhYm92ZS4NCg0KVnEg
YXZhaWwgaW5kZXggZXRjIGlzIHByb2dyYW1tZWQgYmVmb3JlIGRvaW5nIERSSVZFUl9PSyBhbnl3
YXkuDQoNClNlcXVlbmNlIGlzIHZlcnkgc3RyYWlnaHQgZm9yd2FyZCBhdCBkZXN0aW5hdGlvbiBm
cm9tIHVzZXIgdG8ga2VybmVsLg0KMS4gU2V0IGNvbmZpZyBzcGFjZSBmaWVsZHMgKHN1Y2ggYXMg
dmlydGlvX25ldF9jb25maWcvdmlydGlvX2Jsa19jb25maWcpLg0KMi4gU2V0IG90aGVyIGRldmlj
ZSBhdHRyaWJ1dGVzIChtYXggdnFzLCBjdXJyZW50IG51bSB2cXMpDQozLiBTZXQgbmV0IHNwZWNp
ZmljIGNvbmZpZyAoUlNTLCB2bGFuLCBtYWMgYW5kIG1vcmUgZmlsdGVycykNCjQuIFNldCBWUSBm
aWVsZHMgKGVuYWJsZSwgbXNpeCwgYWRkciwgYXZhaWwgaW5keCkNCjUuIFNldCBEUklWRVJfT0ss
IGRldmljZSByZXN1bWVzIGZyb20gd2hlcmUgaXQgbGVmdCBvZmYNCg0KU3RlcHMgIzEgdG8gIzQg
Y2FuIGJlIGRvbmUgbXVsdGlwbGUgdGltZXMgaW4gcHJlLXdhcm0gZGV2aWNlIHVwIGNhc2UgaW4g
ZnV0dXJlLg0KRm9yIG5vdywgdGhleSBjYW4gYmUgZG9uZSBvbmNlIHRvIGdldCB0aGluZ3Mgc3Rh
cnRlZC4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
