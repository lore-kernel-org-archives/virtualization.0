Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A31C433EF
	for <virtualization@archiver.kernel.org>; Fri, 13 May 2022 15:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0F6B60ECA;
	Fri, 13 May 2022 15:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dnJ5xQgim3Dh; Fri, 13 May 2022 15:08:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0AD8B60E3B;
	Fri, 13 May 2022 15:08:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD392C0032;
	Fri, 13 May 2022 15:08:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8448C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 15:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C43F840904
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 15:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ax7EYeiIN0ga
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 15:08:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::616])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73E6440012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 May 2022 15:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvOPEDISHqV58q8M3NepF9iyg2KtBV/PUIBiakZ1TMViOO5whdDjmoj9HvzhO5FpQAYS3fbnoj1EhmbDoiUgzkNdLdzdyu37HSBzSsIfjwSZYcxLGtuT7Dl2DdCR4od+dhTFA8lmZ6nLxc7wTbwJonmxZ0iyWUQ3veg6jpO9qp7Y5FOHcOM9scBkNB8RolgDjYm+Sqe/Jl6Y6rRLz4ojK1Rwi/Y7nUHNHUJkmmjCRNP6hCrMdn8WGwYCeGcQRJDk7WAPTQLdodz8MOyzqBPZGKiifOLFzIp133oOTAAMSTm2bC4XnGDCozfDbl8NBIL7vqFARWuNEcp9h+GuFt6gRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92ggeXEPfb5G0F7/Wg8luiKBzOoBZ9+M8lvT2S3Js3A=;
 b=oBeJwxNrGtF4Y4LKTjDlkN+QRAuuTJnkmIs023fP2cX6nFEMdPp9ltVyMS+oHRUp43LgK41gAp5dtJ8rPtf6IOeCG1vg0LHZB51aDF4gqRE8CwrB0yuOWwn2UGfpUsfPRiCMUhkccHo0dw1yqHaRDWeSI62VlLrNi+gFv8uMZvjF5k5ZHdp40RVm5LKvqF7wvxV7wngSNO04ENVFbz0qzlvTriDpvAG8WWphIGncBkP7kP13NdhNLsg3hjep7MrLC7ODz1BGA1XOIbCw/i0ENYcgPkPRArTIvysUEngsKC5Uh7uDWWZFoeGlWRsUMlMu4aw6aUrZkS52sqn21eYXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92ggeXEPfb5G0F7/Wg8luiKBzOoBZ9+M8lvT2S3Js3A=;
 b=LimxDk3NazlvIVu861/ZMdJzR1Gu6Rnaen4BesoNtDUCcLhQX3+PEhIXhrQeJqcQc67ipLMBVckjXLrL+ifWlLPk04zBaxuD9tmA/9LgpuIkV3jzL6q4+CEU9XYSbbgEQHN+/BQyHyKFzEavh2PupN2VgRhMktxyXuKajjvfuMkUCav8GVoXSfwVqKEirfxWSELY0Mqjijmwwn3fN6YERLApwm3fwj3a6A9Ea8mwWGW+Xu5cqbbaoWbHqBzu69NTnK3LALLFNyJDSoislengYktLBTb35/5oFaMOHfcfDB9YzcXno2lFsTWpyP5+m8V1j8OEIVDgqrvDbprmnCDZiQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BL0PR12MB2545.namprd12.prod.outlook.com (2603:10b6:207:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 15:08:41 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5250.016; Fri, 13 May 2022
 15:08:41 +0000
To: Eugenio Perez Martin <eperezma@redhat.com>, virtualization
 <virtualization@lists.linux-foundation.org>, qemu-level
 <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Cindy Lu
 <lulu@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 "virtio-networking@redhat.com" <virtio-networking@redhat.com>, Eli Cohen
 <elic@nvidia.com>, Laurent Vivier <lvivier@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>
Subject: RE: About restoring the state in vhost-vdpa device
Thread-Topic: About restoring the state in vhost-vdpa device
Thread-Index: AQHYZW+JxbBQ1h+RIkS7iyhFOVHKbK0c5lPg
Date: Fri, 13 May 2022 15:08:41 +0000
Message-ID: <PH0PR12MB5481AF0B02B0FB00885FF2AEDCCA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <CAJaqyWcbqzvtyHcU3t1TF7Mqm2_sBX57rN8S6hHB8NXxgi=tyQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcbqzvtyHcU3t1TF7Mqm2_sBX57rN8S6hHB8NXxgi=tyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c760aab-26c6-4172-9f13-08da34f27722
x-ms-traffictypediagnostic: BL0PR12MB2545:EE_
x-microsoft-antispam-prvs: <BL0PR12MB25456644FD1530C48522F48FDCCA9@BL0PR12MB2545.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LY7XUHLHfk85WscRVdbhIu3PIKVZutgjbcxh6wFy0LPDNz5+wpvLMIIWLGIGzn2QwStHmPDIjtinvUNg/WjrKMJls/PPQtX4wkpp4qEpuXffjFiHnk3SOojPRXtEX5MfJq/8rw5VEsL5cF0+3T1zZI1752LuUS2oT6N8bqgHMsWbKLV8DvIMNheBjiXwGZwPL1LZAeu9F5epyYUTJP2fDqG3XNhtWFyI2IkmyM34Yt0MERiZ3u8Sc4/fvugXpVyxW5eBW62klCECqghAM47dVTocywF83bmG26RO6s50zAVd4mBuT5OELPANs1/4ckXPwt2Gow8QU5AbiWTPxiwPira28L0Kw3e0DPGurLkhhdNFkesBAsehQCH9JPpyaeOZRRlaX/+Ot0fbNOlaiJT9Y4xFIiTjSvChLkLy+rh4vNDW7dJckHTeGT3TbBh+Bnde/tN0+T8F8Zk0pOnDwBK3BkkSD4rauwKz/or+U+0xpOfc8aASlZ4BRRFnNfqEktH5ITjUl4jfs0d6t800hVbVzjRuTuahvXylCLJu1CNYDDaqqPn4k7TJ+V59rqAW1WqzDe++IWrPdyi8xHc08hDvbhDBXOVGX+ECXIuK+w0iNxtynnUX5PSX0kM3PtklqEFyRmFtaPT6XGeozFuQ3dt3kxirkI2mJ/ioDeCwf6av8DDYpqlJq+Gx9K/7gLRLisN4B2i+TSAeUYXCzPg1cHoGONMWwX+b0WBiztWPUt8YEdo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(52536014)(33656002)(71200400001)(5660300002)(508600001)(38070700005)(9686003)(86362001)(186003)(7696005)(2906002)(83380400001)(6506007)(122000001)(38100700002)(921005)(55016003)(316002)(66556008)(66946007)(66446008)(110136005)(64756008)(66476007)(8676002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2gycythK1BOQU91MFhpaXZsZTJWRGc3V3NRZUJ1ZEdvM1hLd0o0WWF4ZUx0?=
 =?utf-8?B?UWpDZmNsemt3T1VpVXJzU0lNVU4rMDdneGdOUXNEeGh4UFVieXF0U3hpMDVh?=
 =?utf-8?B?L1R5KzhGZWZ2RHM1aEFGcXdGU0FLN2YwTUJ2NGw1cVIwUHo0MzM1RlBjWXNZ?=
 =?utf-8?B?YmdrbFZjYzJHY1lsTUxWRmEybi9XWS9mZWJvbTcyb292ZXJQK3psUjF6OE55?=
 =?utf-8?B?d2Y5OXpQWDRSRzJyTjVONGUwSjdUOWVvK0IxcUNqMnVEN1ZDZEtBL1BQSGxs?=
 =?utf-8?B?T0FtL1JiR3EwNm9vWVVJRDNMRmZwRmg3elJuM0FaWER5a2Z3MGYyQWd0VWxr?=
 =?utf-8?B?ZHBoOXJvK3NWR1NLQW5JdjNrckcybmtSYXkvMFlGMGExSHN3dDV3WGNPMFU5?=
 =?utf-8?B?alVESk4xbkdYWE1yQ1R3SlozbVdUUnR3WW5wcnJwTVBIa1BCb1dQSmdDTVow?=
 =?utf-8?B?cCtHOHBrRFdrUkcyOFlIbXhOejA0bUU3WFFuTE5nOVBxSTA5OWRHSlZzN3lQ?=
 =?utf-8?B?dTc4UnJhUy9WMGZrdk5XaGRvUEVRQW1XSUpwazUyQXAxTmgzRmtwUnpsbzBC?=
 =?utf-8?B?ZXF3UTZtMmE4Z0RwTG1hNElGdnB1VXdhWlB5VnNBS2ZWcDlvU3ErTEYrRWJ0?=
 =?utf-8?B?aEZPYTZxd0VSM3ZWNVh4QlA0emgraEs2REZQcDVMaTVCQTk1MmNJYmlTZVEx?=
 =?utf-8?B?T2ZpUlZUM3pBOFFCYTlIUDZLNGlWaEd1U2t4akxObFBBYWhlb1lTbmE0MDAv?=
 =?utf-8?B?eUFBYnh2L0hEc1JQS0VvTTdEUVQ5Z1NkdStSWHRyRThIMXc5cHo0UUVqbEd1?=
 =?utf-8?B?bEVzcGxWZlVkdys1MHMxb1pYZisyYnljUEpiN3JuNWxQY2JmUncvMzM5VmFC?=
 =?utf-8?B?M2FnbjQ5NHAxOEkxcWM1SjhBYXMzK2ZNR05FZ2YwaFFUVXQ2R0JkTjZZUUdN?=
 =?utf-8?B?NmdJdDBCdjVFSlNDaFNqUDRKZllJR3hjOEJJZlZpUmRRK2c3S3hTcXcwck43?=
 =?utf-8?B?YXBYNklVeEx4NHNoLzFURlUrUlJKd2VxY0JlVFRjeDArRnY4aWVaUkJtbWdO?=
 =?utf-8?B?bVVZd1UyMWozM2hQTExzMkhKbnU0dEc5WmlrRy8wMldKVEtKbjFIQzZrY2s0?=
 =?utf-8?B?eitmcVV0WjNGTEhoSk4vdzdYbVFvTnZEdFBoMVQwUlJJbUlva1ArakFsMHkv?=
 =?utf-8?B?bzZ6dnE0bElnOW5aM3ZXZGpsVGVkekM0dnpkK0xWdUhrRHRkdTd1MTNoaDRm?=
 =?utf-8?B?M3JhR1lOWlUrYXFkdTY4ZU5HcTM3cUFZVEJLbUhIMkRjcGZoWHgyVWhtMDZR?=
 =?utf-8?B?MzJucmtIL3RNVVVDZnZTNmtualY3aHZLRXJ1NDJEQ1hKdEZyZ2lINmZyWXBN?=
 =?utf-8?B?ZHlUdXFsR2k4UVBTd0NZYXovYlp3YjVybFM2eFM5TW51dWpUdHNxa210elYz?=
 =?utf-8?B?disvL3FkVkYvaUd5a1ZDRUVGamMxM3pkbjYzdzF1TVkxcU50VUJ3bDljZ0I1?=
 =?utf-8?B?VUFYTmZUNFZ3cUpKc1VXbUJMZXhUT3Z5N1dDVHhwODVLNEZyUGZZNmJRZDVF?=
 =?utf-8?B?dmE4eitqSHdMUVlFVDRlVTR2OTd3R2ZranYyTUpwQWlPMmhXK1crZGRCZDVE?=
 =?utf-8?B?VjdHdmtYWlFsRnpidmN6MFZvTEVWdE4vd1NnVUY5dm1MQnB1M1ZFT3ZNeFdC?=
 =?utf-8?B?bDVOaG9tMGVndlJPTmE5L0NMTjBRV2VIOVl2RzZWNFF3UWdqdEZVSzZNUVNB?=
 =?utf-8?B?a3VZSnpXK0wvay9hMWhTNnNLdHRtbVZ3S01US3NDSHdKN2xxWTFvUCtjOVQ2?=
 =?utf-8?B?RndBQmwyOGhTUFVFVlFNQ2lVQ1c0UVJNczBuS1kvQUZpRmVXZjhTV2tuQ2dR?=
 =?utf-8?B?bUtPWXJkby9ZZnpQc2lBQmVjdUZzZ0EyZWY1M2lyREh3YXkxSmo1SzhNbUZx?=
 =?utf-8?B?Si93clZyaXB0Y3E4eEJVVm90NXp2UlhhYlVNLzAvZ2QrNUpRYU42S0ZUNTdE?=
 =?utf-8?B?ZmkybWF4ekFOUlNyMU9iTTV2Q3BYV1lDemxsZ2FTdy8vNmNTY3JiZ25HRmhl?=
 =?utf-8?B?ZXNnWTIwa1VOOXM4VXhaNWxvMmYwZDE3Z2swUGdBQXZEYjhHemFjWnYzam9O?=
 =?utf-8?B?VlZkdkVjMkVXUzlENE52bjBMRTFBaThtSkVzYWVTZDhuOEF6UVpnVkNhSXJi?=
 =?utf-8?B?ZG9QMWxjRkwwc3ZrY0V3cVJnRzlJWEoxaVBLbjk2QnJDdHd1Z0NXMDNnWDI2?=
 =?utf-8?B?a2VoNnpvbUZqU3hBbVNvWDZMcmpxa0RUQnZUMzBhQUtkNTVGSTRBbjU1YW45?=
 =?utf-8?B?ejVZbFFVek8vZHdmYm4xdkMwN0JqR2Nud3B6anZjekF3UmdlWlJMNE5YQUNt?=
 =?utf-8?Q?UnVyZkUiC2BvKBG5nB4dcGt90zPi+B3tMvh2m?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c760aab-26c6-4172-9f13-08da34f27722
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 15:08:41.1677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wQwOgPR6Ias0QTUk1kMldyhWX8LT6xd/YFr8pL62MqyhrIqdsq1FQmrPZtIWTjpSf35xbc4sWTzCGXx7vDcCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
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

DQo+IEZyb206IEV1Z2VuaW8gUGVyZXogTWFydGluIDxlcGVyZXptYUByZWRoYXQuY29tPg0KPiBT
ZW50OiBXZWRuZXNkYXksIE1heSAxMSwgMjAyMiAzOjQ0IFBNDQo+IA0KPiBUaGlzIGlzIGEgcHJv
cG9zYWwgdG8gcmVzdG9yZSB0aGUgc3RhdGUgb2YgdGhlIHZob3N0LXZkcGEgZGV2aWNlIGF0IHRo
ZQ0KPiBkZXN0aW5hdGlvbiBhZnRlciBhIGxpdmUgbWlncmF0aW9uLiBJdCB1c2VzIGFzIG1hbnkg
YXZhaWxhYmxlIGZlYXR1cmVzIGJvdGgNCj4gZnJvbSB0aGUgZGV2aWNlIGFuZCBmcm9tIHFlbXUg
YXMgcG9zc2libGUgc28gd2Uga2VlcCB0aGUgY29tbXVuaWNhdGlvbg0KPiBzaW1wbGUgYW5kIHNw
ZWVkIHVwIHRoZSBtZXJnaW5nIHByb2Nlc3MuDQo+IA0KPiAjIEluaXRpYWxpemluZyBhIHZob3N0
LXZkcGEgZGV2aWNlLg0KPiANCj4gV2l0aG91dCB0aGUgY29udGV4dCBvZiBsaXZlIG1pZ3JhdGlv
biwgdGhlIHN0ZXBzIHRvIGluaXRpYWxpemUgdGhlIGRldmljZSBmcm9tDQo+IHZob3N0LXZkcGEg
YXQgcWVtdSBzdGFydGluZyBhcmU6DQo+IDEpIFt2aG9zdF0gT3BlbiB0aGUgdmRwYSBkZXZpY2Us
IFVzaW5nIHNpbXBseSBvcGVuKCkNCj4gMikgW3Zob3N0K3ZpcnRpb10gR2V0IGRldmljZSBmZWF0
dXJlcy4gVGhlc2UgYXJlIGV4cGVjdGVkIG5vdCB0byBjaGFuZ2UgaW4NCj4gdGhlIGRldmljZSdz
IGxpZmV0aW1lLCBzbyB3ZSBjYW4gc2F2ZSB0aGVtLiBRZW11IGlzc3VlcyBhDQo+IFZIT1NUX0dF
VF9GRUFUVVJFUyBpb2N0bCBhbmQgdmRwYSBmb3J3YXJkcyB0byB0aGUgYmFja2VuZCBkcml2ZXIg
dXNpbmcNCj4gZ2V0X2RldmljZV9mZWF0dXJlcygpIGNhbGxiYWNrLg0KPiAzKSBbdmhvc3Qrdmly
dGlvXSBHZXQgaXRzIG1heF9xdWV1ZV9wYWlycyBpZiBfRl9NUSBhbmQgX0ZfQ1RSTF9WUS4NClRo
aXMgc2hvdWxkIGJlIHNvb24gcmVwbGFjZWQgd2l0aCBtb3JlIGdlbmVyaWMgbnVtX3ZxIGludGVy
ZmFjZSBhcyBtYXhfcXVldWVfcGFpcnMgZG9u4oCZdCwgd29yayBiZXlvbmQgbmV0Lg0KVGhlcmUg
aXMgbm8gbmVlZCB0byBjb250aW51ZSBzb21lIGFuY2llbnQgaW50ZXJmYWNlIHdheSBmb3IgbmV3
bHkgYnVpbHQgdmRwYSBzdGFjay4NCg0KPiBUaGVzZSBhcmUgb2J0YWluZWQgdXNpbmcgVkhPU1Rf
VkRQQV9HRVRfQ09ORklHLCBhbmQgdGhhdCByZXF1ZXN0IGlzDQo+IGZvcndhcmRlZCB0byB0aGUg
ZGV2aWNlIHVzaW5nIGdldF9jb25maWcuIFFFTVUgZXhwZWN0cyB0aGUgZGV2aWNlIHRvIG5vdA0K
PiBjaGFuZ2UgaXQgaW4gaXRzIGxpZmV0aW1lLg0KPiA0KSBbdmhvc3RdIFZkcGEgc2V0IHN0YXR1
cyAoX1NfQUNLTk9MRURHRSwgX1NfRFJJVkVSKS4gU3RpbGwgbm8NCj4gRkVBVFVSRVNfT0sgb3Ig
RFJJVkVSX09LLiBUaGUgaW9jdGwgaXMgVkhPU1RfVkRQQV9TRVRfU1RBVFVTLCBhbmQNCj4gdGhl
IHZkcGEgYmFja2VuZCBkcml2ZXIgY2FsbGJhY2sgaXMgc2V0X3N0YXR1cy4NCj4gDQo+IFRoZXNl
IGFyZSB0aGUgc3RlcHMgdXNlZCB0byBpbml0aWFsaXplIHRoZSBkZXZpY2UgaW4gcWVtdSB0ZXJt
aW5vbG9neSwgdGFraW5nDQo+IGF3YXkgc29tZSByZWR1bmRhbmNpZXMgdG8gbWFrZSBpdCBzaW1w
bGVyLg0KPiANCj4gTm93IHRoZSBkcml2ZXIgc2VuZHMgdGhlIEZFQVRVUkVTX09LIGFuZCB0aGUg
RFJJVkVSX09LLCBhbmQgcWVtdQ0KPiBkZXRlY3RzIGl0LCBzbyBpdCAqc3RhcnRzKiB0aGUgZGV2
aWNlLg0KPiANCj4gIyBTdGFydGluZyBhIHZob3N0LXZkcGEgZGV2aWNlDQo+IA0KPiBBdCB2aXJ0
aW9fbmV0X3Zob3N0X3N0YXR1cyB3ZSBoYXZlIHR3byBpbXBvcnRhbnQgdmFyaWFibGVzIGhlcmU6
DQo+IGludCBjdnEgPSBfRl9DVFJMX1ZRID8gMSA6IDA7DQo+IGludCBxdWV1ZV9wYWlycyA9IF9G
X0NUUkxfVlEgJiYgX0ZfTVEgPyAobWF4X3F1ZXVlX3BhaXJzIG9mIHN0ZXAgMykgOg0KPiAwOw0K
PiANCj4gTm93IGlkZW50aWZpY2F0aW9uIG9mIHRoZSBjdnEgaW5kZXguIFFlbXUgKmtub3cqIHRo
YXQgdGhlIGRldmljZSB3aWxsDQo+IGV4cG9zZSBpdCBhdCB0aGUgbGFzdCBxdWV1ZSAobWF4X3F1
ZXVlX3BhaXJzKjIpIGlmIF9GX01RIGhhcyBiZWVuDQo+IGFja25vd2xlZGdlZCBieSB0aGUgZ3Vl
c3QncyBkcml2ZXIgb3IgMiBpZiBub3QuIEl0IGNhbm5vdCBkZXBlbmQgb24gYW55IGRhdGENCj4g
c2VudCB0byB0aGUgZGV2aWNlIHZpYSBjdnEsIGJlY2F1c2Ugd2UgY291bGRuJ3QgZ2V0IGl0cyBj
b21tYW5kIHN0YXR1cyBvbiBhDQo+IGNoYW5nZS4NCj4gDQo+IE5vdyB3ZSBzdGFydCB0aGUgdmhv
c3QgZGV2aWNlLiBUaGUgd29ya2Zsb3cgaXMgY3VycmVudGx5Og0KPiANCj4gNSkgW3ZpcnRpbyt2
aG9zdF0gVGhlIGZpcnN0IHN0ZXAgaXMgdG8gc2VuZCB0aGUgYWNrbm93bGVkZ2VtZW50IG9mIHRo
ZSBWaXJ0aW8NCj4gZmVhdHVyZXMgYW5kIHZob3N0L3ZkcGEgYmFja2VuZCBmZWF0dXJlcyB0byB0
aGUgZGV2aWNlLCBzbyBpdCBrbm93cyBob3cgdG8NCj4gY29uZmlndXJlIGl0c2VsZi4gVGhpcyBp
cyBkb25lIHVzaW5nIHRoZSBzYW1lIGNhbGxzIGFzIHN0ZXAgNCB3aXRoIHRoZXNlIGZlYXR1cmUN
Cj4gYml0cyBhZGRlZC4NCj4gNikgW3ZpcnRpb10gU2V0IHRoZSBzaXplLCBiYXNlLCBhZGRyLCBr
aWNrIGFuZCBjYWxsIGZkIGZvciBlYWNoIHF1ZXVlDQo+IChTRVRfVlJJTkdfQUREUiwgU0VUX1ZS
SU5HX05VTSwgLi4uOyBhbmQgZm9yd2FyZGVkIHdpdGgNCj4gc2V0X3ZxX2FkZHJlc3MsIHNldF92
cV9zdGF0ZSwgLi4uKQ0KPiA3KSBbdmRwYV0gU2VuZCBob3N0IG5vdGlmaWVycyBhbmQgKnNlbmQg
U0VUX1ZSSU5HX0VOQUJMRSA9IDEqIGZvciBlYWNoDQo+IHF1ZXVlLiBUaGlzIGlzIGRvbmUgdXNp
bmcgaW9jdGwgVkhPU1RfVkRQQV9TRVRfVlJJTkdfRU5BQkxFLCBhbmQNCj4gZm9yd2FyZGVkIHRv
IHRoZSB2ZHBhIGJhY2tlbmQgdXNpbmcgc2V0X3ZxX3JlYWR5IGNhbGxiYWNrLg0KPiA4KSBbdmly
dGlvICsgdmRwYV0gU2VuZCBtZW1vcnkgdHJhbnNsYXRpb25zICYgc2V0IERSSVZFUl9PSy4NCj4g
DQpTbyBNUSBhbGwgVlFzIHNldHVwIHNob3VsZCBiZSBzZXQgYmVmb3JlIHN0ZXBfOC4NCg0KPiBJ
ZiB3ZSBmb2xsb3cgdGhlIGN1cnJlbnQgd29ya2Zsb3csIHRoZSBkZXZpY2UgaXMgYWxsb3dlZCBu
b3cgdG8gc3RhcnQNCj4gcmVjZWl2aW5nIG9ubHkgb24gdnEgcGFpciAwLCBzaW5jZSB3ZSd2ZSBz
dGlsbCBub3Qgc2V0IHRoZSBtdWx0aSBxdWV1ZSBwYWlyLiBUaGlzDQo+IGNvdWxkIGNhdXNlIHRo
ZSBndWVzdCB0byByZWNlaXZlIHBhY2tldHMgaW4gdW5leHBlY3RlZCBxdWV1ZXMsIGJyZWFraW5n
DQo+IFJTUy4NCj4gDQo+ICMgUHJvcG9zYWwNCj4gDQo+IE91ciBwcm9wb3NhbCBkaXZlcmdlIGlu
IHN0ZXAgNzogSW5zdGVhZCBvZiBlbmFibGluZyAqYWxsKiB0aGUgdmlydHF1ZXVlcywgb25seQ0K
PiBlbmFibGUgdGhlIENWUS4gDQpKdXN0IHRvIGRvdWJsZSBjaGVjaywgVlEgMCBhbmQgMSBvZiB0
aGUgbmV0IGFyZSBhbHNvIG5vdCBlbmFibGVkLCBjb3JyZWN0Pw0KDQo+IEFmdGVyIHRoYXQsIHNl
bmQgdGhlIERSSVZFUl9PSyBhbmQgcXVldWUgYWxsIHRoZSBjb250cm9sDQo+IGNvbW1hbmRzIHRv
IHJlc3RvcmUgdGhlIGRldmljZSBzdGF0dXMgKE1RLCBSU1MsIC4uLikuIE9uY2UgYWxsIG9mIHRo
ZW0gaGF2ZQ0KPiBiZWVuIGFja25vd2xlZGdlZCAoImRldmljZSIsIG9yIGVtdWxhdGVkIGN2cSBp
biBob3N0IHZkcGEgYmFja2VuZCBkcml2ZXIsDQo+IGhhcyB1c2VkIGFsbCBjdnEgYnVmZmVycywg
ZW5hYmxlIChTRVRfVlJJTkdfRU5BQkxFLCBzZXRfdnFfcmVhZHkpIGFsbA0KPiBvdGhlciBxdWV1
ZXMuDQo+IA0KV2hhdCBpcyBzcGVjaWFsIGFib3V0IGRvaW5nIERSSVZFUl9PSyBhbmQgZW5xdWV1
aW5nIHRoZSBjb250cm9sIGNvbW1hbmRzPw0KV2h5IG90aGVyIGNvbmZpZ3VyYXRpb24gY2Fubm90
IGJlIGFwcGxpZWQgYmVmb3JlIERSSVZFUl9PSz8NCg0KSW4gb3RoZXIgd29yZHMsDQpTdGVwXzcg
YWxyZWFkeSBzZXR1cHMgdXAgdGhlIG5lY2Vzc2FyeSBWUSByZWxhdGVkIGZpZWxkcy4NCg0KQmVm
b3JlIGRvaW5nIGRyaXZlciBvaywgd2hhdCBpcyBuZWVkZWQgaXMgdG8gc2V0dXAgYW55IG90aGVy
IGRldmljZSBmaWVsZHMgYW5kIGZlYXR1cmVzLg0KRm9yIG5ldCB0aGlzIGluY2x1ZGVzIHJzcywg
dmxhbiwgbWFjIGZpbHRlcnMuDQpTbywgYSBuZXcgdmRwYSBpb2N0bCgpIHNob3VsZCBiZSBhYmxl
IHRvIHNldCB0aGVzZSB2YWx1ZXMuDQpUaGlzIGlzIHRoZSBpb2N0bCgpIGJldHdlZW4gdXNlciBh
bmQga2VybmVsLg0KUG9zdCB0aGlzIGlvY3RsKCksIERSSVZFUl9PSyBzaG91bGQgYmUgZG9uZSBy
ZXN1bWluZyB0aGUgZGV2aWNlLg0KDQpEZXZpY2UgaGFzIGZ1bGwgdmlldyBvZiBjb25maWcgbm93
Lg0KDQpUaGlzIG5vZGUgbG9jYWwgZGV2aWNlIHNldHVwIGNoYW5nZSBzaG91bGQgbm90IHJlcXVp
cmUgbWlncmF0aW9uIHByb3RvY29sIGNoYW5nZS4NCg0KVGhpcyBzY2hlbWUgd2lsbCBhbHNvIHdv
cmsgZm9yIG5vbl9uZXQgdmlydGlvIGRldmljZXMgdG9vLg0KDQo+IEV2ZXJ5dGhpbmcgbmVlZGVk
IGZvciB0aGlzIGlzIGFscmVhZHkgaW1wbGVtZW50ZWQgaW4gdGhlIGtlcm5lbCBhcyBmYXIgYXMg
SQ0KPiBzZWUsIHRoZXJlIGlzIG9ubHkgYSBzbWFsbCBtb2RpZmljYXRpb24gaW4gcWVtdSBuZWVk
ZWQuIFRodXMgYWNoaWV2aW5nIHRoZQ0KPiByZXN0b3Jpbmcgb2YgdGhlIGRldmljZSBzdGF0ZSB3
aXRob3V0IGNyZWF0aW5nIG1haW50ZW5hbmNlIGJ1cmRlbi4NCj4gDQo+IEEgbG90IG9mIG9wdGlt
aXphdGlvbnMgY2FuIGJlIGFwcGxpZWQgb24gdG9wIHdpdGhvdXQgdGhlIG5lZWQgdG8gYWRkIHN0
dWZmIHRvDQo+IHRoZSBtaWdyYXRpb24gcHJvdG9jb2wgb3IgdkRQQSB1QVBJLCBsaWtlIHRoZSBw
cmUtd2FybWluZyBvZiB0aGUgdmRwYQ0KPiBxdWV1ZXMgb3IgYWRkaW5nIG1vcmUgY2FwYWJpbGl0
aWVzIHRvIHRoZSBlbXVsYXRlZCBDVlEuDQpBYm92ZSBpb2N0bCgpIHdpbGwgZW5hYmxlIHZkcGEg
c3Vic3lzdGVtIHRvIGFwcGx5IHRoaXMgc2V0dGluZyBvbmUgbW9yIG1vcmUgdGltZXMgaW4gcHJl
LXdhcm1pbmcgdXAgc3RhZ2UgYmVmb3JlIERSSVZFUl9PSy4NCg0KPiANCj4gT3RoZXIgb3B0aW1p
emF0aW9ucyBsaWtlIGFwcGx5aW5nIHRoZSBzdGF0ZSBvdXQgb2YgYmFuZCBjYW4gYWxzbyBiZSBh
ZGRlZCBzbw0KPiB0aGV5IGNhbiBydW4gaW4gcGFyYWxsZWwgd2l0aCB0aGUgbWlncmF0aW9uLCBi
dXQgdGhhdCByZXF1aXJlcyBhIGJpZ2dlciBjaGFuZ2UNCj4gaW4gcWVtdSBtaWdyYXRpb24gcHJv
dG9jb2wgbWFraW5nIHVzIGxvc2UgZm9jdXMgb24gYWNoaWV2aW5nIGF0IGxlYXN0IHRoZQ0KPiBi
YXNpYyBkZXZpY2UgbWlncmF0aW9uIGluIG15IG9waW5pb24uDQo+IA0KTGV0J3Mgc3RyaXZlIHRv
IGFwcGx5IHRoaXMgaW4tYmFuZCBhcyBtdWNoIGFzIHBvc3NpYmxlLiBBcHBseWluZyBvdXQgb2Yg
YmFuZCBvcGVucyBpc3N1ZXMgdW5yZWxhdGVkIHRvIG1pZ3JhdGlvbiAoYXV0aGVudGljYXRpb24g
YW5kIG1vcmUpLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
