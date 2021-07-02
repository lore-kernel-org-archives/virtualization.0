Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4D0C11F68
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 06:04:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8455C613F3
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 06:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8455C613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AC9C6067F;
	Fri,  2 Jul 2021 06:04:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIwWGsCjDFfH; Fri,  2 Jul 2021 06:04:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 99F70605B5;
	Fri,  2 Jul 2021 06:04:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78616C001A;
	Fri,  2 Jul 2021 06:04:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0CF4C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA0EC60632
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 79UnvkHP0bHh
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:04:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D01C605B5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx5zJP6NC63AqIyWJGvfBVf7YWYnmLW/F9PWeFk9+SAPys1lGVfSHiAVWzdttjblAKPqHvTz5djZerji6pmPZzHrJSKQvRlJMq025r0sb7Ce1nPLyyv+1kXWEOPMMUgP5K1hEd811+Eno7DmbIuicgXKPpXixMZAEXfFy6hzOU0xFo6ToBKKL4NEyUC7BT05bcRaXKPc3ZhFQrCg8E0su5Xc9TasXTz2YufdRGEfKWm7x1ke5cp39qzSutljLco3TTx5jsjInvLxXJ17DMNkuphC9enD8pkMyL0ZbPKBjq+x+66Rs45gCOUXyYstkUjgDkv+SGb73YARHyiaOwH+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAFXQ0oxL9hvw/TJTy/TZmXhuvgekZREDOR26YUPyZ8=;
 b=ofoT/eP3DmfggA4PU9gl/5CHS8iEkPMy42U1ZAOP0aNiEZgTw598ohZKudOaWRL1rUUalMDiXHrjUZeZETM7Y34bYy5U8JvUnNYaykuH88f01HeXPuJ5d4hWlWGh0rpDcGO6SBw848Mw7eDILaQvyqRVUiNU37YPVJi9ET9rBIL3vZ8feKb5Z2g9k+qM1fIJbAH9C6+/c9QOo/McOXmapa+fUcCFK6PyLkbODv1JWI1SvYLOWR7l+31PK1hxRVDdJlZ1EvTI6Ra2QvmlgoVD4d0xQOdsUOstKqzBIcLarTl3S5LeP9JxvyHkOhwx9p5moiuHIqajn1M5VzftD05GXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAFXQ0oxL9hvw/TJTy/TZmXhuvgekZREDOR26YUPyZ8=;
 b=IcJ4SHEc32MFurWYB+4YwC6GanE/8thhF1jjb31k/bVrLkuW8i6eApieaRUwZCO3u/pEU6JFGS0xwLU/qHfC7dnpIPj8rv0qXZShRnyxb5oG8igrATRB93AvVM1VJvm/J2MvSwl9JONNj8/nVAcZbPi72AvIQNHRr+qsE9xo4hSxV/wxp4M+Wx46O62o2M+USdtls1ih5RjysWEOL1MNwFjcPq272uoJoYrrRDBx1Uro4PRJCdykZ+x75D0SueJr1u4//tO7+5j10b0zaHgyxcTtH5+n4q2tNupgPZz6jMB0SnOfxWRswsD+ufqln8a3ngJbhtnnuN4fUXz2tNyC8Q==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Fri, 2 Jul
 2021 06:04:26 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4287.023; Fri, 2 Jul 2021
 06:04:26 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KCAAO8RAIAAAJPAgAGsGACAAAPf8IAAEweAgAAIirCAAU1RAIAAMiFQgASfUwCAAF8F0IABH3+AgABhb2CAATvVgIAAFmuQgAFr2YCAADSRMIAAER6AgAFvJLA=
Date: Fri, 2 Jul 2021 06:04:26 +0000
Message-ID: <PH0PR12MB548102128B368BBE47F5F000DC1F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bf6ec662-b53d-174f-53e2-735589f83d3d@redhat.com>
 <PH0PR12MB548115ACBDA9D76526C370B3DC029@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8c78b8ed-e16c-31dd-7c1c-abd2bef6bb12@redhat.com>
 <PH0PR12MB5481737F058FDE9B947C1ECFDC019@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a23cdc3a-80cb-f5aa-e77c-4b897c8456af@redhat.com>
 <PH0PR12MB5481AC0B0D9D0AC3A62A5EB1DC009@PH0PR12MB5481.namprd12.prod.outlook.com>
 <da0c4e7f-8b59-51ed-f694-04fe5a9ed0b9@redhat.com>
In-Reply-To: <da0c4e7f-8b59-51ed-f694-04fe5a9ed0b9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 272945e3-3258-490d-cf71-08d93d1f3f76
x-ms-traffictypediagnostic: PH0PR12MB5500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB55004E1E233995B926F2ACA3DC1F9@PH0PR12MB5500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yTEl4HjEZOCrGrLXUqZvGgZ681Ewt1DY3VHCAVAU2T2T8OLLn1xPkvpw659nNGoX/PtonY3Jb9ItjzsDh6dYfCtTuecdTDaXkGnBe3odbyTMl2n2PygXSa1Ha0+ZPSI6t9EVuX3PAi+b85DnM/EApbeey9w2NaF/Ru/ENNAnpHNtxeRdTMeUkrNx+dgax4Tmg2n1AqZm2vfCxQccRa9hfmQaxeU6e3dHAW+rqtZ8AvkkxQjRSVbl37hh3iLoC19x+zVf/2GAZtUktqUq9ZExFUSlCS0k1T0PaavWq1zCCxYnOj8pfNMt1rknLamkVx76KYJ5qbG22/s6xm42i8b/jRRUB/UQDvovUjw1DWhObp64i1LnmyUc9k6ym//KrIinc/2Tkvx0coonfgqG3bFBHjHNpM/GjweOMxdRceGWr1MjNxMf6TjtAF+sYzDXnJpbNdc/2AZ1tb0Z+ylFxwc7nEuWTZvbWCV8GLSB6ze6vuxOXqfvI5aRSTOYVXpLImTm+2ODaF81HmyLOaIATw5TCM3EyesE259o8dDeqwbMwFRnQMy/LwFMf8/8fuTV4O1MIhsh7gvTZvAn+8WYkBJSVPylbFYtFoHJuM2WyoyWEtv+XWKLO0J1rFVeReapqChW6y5g2OZyvv9HHSu2GTzYJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(83380400001)(8936002)(64756008)(66556008)(66446008)(7696005)(4326008)(66476007)(107886003)(6506007)(52536014)(122000001)(186003)(38100700002)(71200400001)(5660300002)(76116006)(66946007)(86362001)(26005)(110136005)(54906003)(33656002)(478600001)(316002)(2906002)(9686003)(55016002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEpiTlo5bFg5Z0VvS2IwVWNUeUJFK1NlZXUxTUlESVUweTBzZHVEcXlHZ0Qx?=
 =?utf-8?B?NFZZaFkza3lxYlNRWlk3NmRtM3BILzJRNnJOVVlLS1Y4SnhpbnJLWHd2dW0r?=
 =?utf-8?B?TGgwWlRtRk04eXVHMkVLWXpHbHB1Z3JiRVIrTUNsVWJUYWdRQkxyK2l0d0RJ?=
 =?utf-8?B?bFJFOG0zT3JxOHJqajRQVGNoMHlBTVZPVDVlWVJndXJDbGtDQmhwZitKTGZX?=
 =?utf-8?B?WU02TmcwYmtUbG9VOGlza1NQVEFNeUxDNWo5MzgwdjlpNEZVa3pKZm1Od0FG?=
 =?utf-8?B?NTAvWm9CYVR0MXhYRmtqMENNbHpmRUxqQWxoQXhGdGFZQnl1QTJtdjdwMGk3?=
 =?utf-8?B?WEtQaTU1Umh1clN1NC9SWUlTL0JWMUkwZTM0eFlkUXFMMnBaamRTQmpaQzly?=
 =?utf-8?B?K1RjNXcwb1VDYThJeHdhSEtzYXV5MHVSUmhlQ0pZU1hWSngxeHdHMlgwUUx2?=
 =?utf-8?B?cFRMaWpQZGFFaXBMbHRuTUowcDZqZGw5UjFrY1dKWklFUGJCNkdGSVZNTEs2?=
 =?utf-8?B?RDJvYWJXN25CeEdFVXh6MWI5YWFUR1hkSGlKVTkvbGNhQ084RS9PUlJoUGVs?=
 =?utf-8?B?NG5FMUZwakNYK3V0aUlsOGlpeGd0MlFTZVZjblBTZXJCeWtDV2RmWGgwdE9L?=
 =?utf-8?B?SmxKZnZpK0Y2N1RhUkFIRmpnNE1ZOGZKdm5wNVFtTTFWKzNSaEt2c1VTcUJK?=
 =?utf-8?B?UDZxS29uVmlrd3FRWDZFYWhRZEN1VW0vREd1ZzRLUGpRRUtTMnRqRmhtVW13?=
 =?utf-8?B?Wk1JNUJvQS8rL2h2d2tFRUNPNDYxQ1hlYnRXTitGYTJya1orcVZVTDJlWGFo?=
 =?utf-8?B?VXpoaVFzeHJhWHUwTThxamhNOGtIYWpzMmc5T0IzQzRKeG9UNEc0V0NPTnk0?=
 =?utf-8?B?OFZFNEM1ci96akZhL0ZFYWg2N2EzVzNrcXRMaE1sdWFJaFZoZFNBRTRMS09P?=
 =?utf-8?B?UWdwUHVqYnZjZlRmRlg0dG0wMjMwT0JxQVpCYm1PNk1jWExvMEh4eHRYR3Z1?=
 =?utf-8?B?Qmd6bTFSQVhLWGdaQklCblpNSlFvZk5SWndheVhRVVFCUVVrRHcvMlZQS3hX?=
 =?utf-8?B?Vkcyb2Vyc0M5eGNNWE92U2JJR1BSOGdzYmphcnBERXQvbDNETE9VTitZK1l5?=
 =?utf-8?B?WXZQYVlMWGpIeFNzM3FNSzcweE05ZFpCcHRVSXpzRUtSUUtNTTh6Y01QREU0?=
 =?utf-8?B?YmQwWW5LcU5qTmQ3djhDZUZnM29OZm1CcHl1cldudHkxdGdyWkVsR3ptamhv?=
 =?utf-8?B?U3YrRm5QSzR4cnJvdld3Q0JiSm1pcktZMEZsNmx4YjF2NWM5NlFoZjR2eG5q?=
 =?utf-8?B?NUIreUtUQWY1V2ladlRzbHRIRS9FU2pvc01zeTlFamJnSFZBb0xPeVZHM1Ry?=
 =?utf-8?B?dTR2cnpPWGp2QUtMVU5GQ2RvRGJiQ3ZsYmRmeEwwTENDZ3k3cS9aa0dvclVR?=
 =?utf-8?B?M3BkV2FML2NHVnNwSkY5UkF1NkYvNFE0aktUMjJsS00zWDQ3OHIrNmJISGk0?=
 =?utf-8?B?cTEveGtYSUFMN3kydmw0RXlOelcyczA3ZUlrRlUrY0ZNM1oyNFhrZEgvVnlJ?=
 =?utf-8?B?SWx3ekdaSm1UWWJVMEs4L3lJYS80eFdwMy9CQmF4TjdSQmRrditIdDZtWXkz?=
 =?utf-8?B?WGw0Z2kvczZTanVnSllPb1VBdGFubUFQODZoZkdiQVljYUpQdGtjb1N4eEQ0?=
 =?utf-8?B?c3ZaUVdJdWYwTTRwYnJUQmEwejQ2WjN0ZlFPYzVreXg3SEtuMmxrVGt3VmJS?=
 =?utf-8?Q?pVYPnb64VgGoGa6t1Kg2zaQ5b+3DWJSz+ksXIAk?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272945e3-3258-490d-cf71-08d93d1f3f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 06:04:26.6920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywuYXnWWP0Mtg9c1oroLkGmSAoXJCs7hqRlKfc2VFCfEXLV3BrTbkQoqzGvKsgBW3XtuEXx7bDBaHSKSWznpgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEp1bHkgMSwgMjAyMSAxOjEzIFBNDQo+IA0KPiANCj4gQWN0dWFsbHkgaXQgZGVwZW5k
cyBvbiB3aGF0IGF0dHJpYnV0ZXMgaXMgcmVxdWlyZWQgZm9yIGJ1aWxkaW5nIHRoZSBjb25maWcu
DQo+IA0KPiBXZSBjYW4gc2ltcGx5IHJldXNlIHRoZSBleGlzdGluZyB2aXJ0aW9fbmV0X2NvbmZp
ZywgaWYgbW9zdCBvZiB0aGUgZmllbGRzIGFyZQ0KPiByZXF1aXJlZC4NCj4gDQo+IHN0cnVjdCB2
aXJ0aW9fbmV0X2NvbmZpZ19zZXQgew0KPiAgwqDCoMKgIMKgwqDCoCBfX3ZpcnRpbzY0IGZlYXR1
cmVzOw0KPiAgwqDCoMKgIMKgwqDCoCB1bmlvbiB7DQo+ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCBz
dHJ1Y3QgdmlydGlvX25ldF9jb25maWc7DQo+ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCBfX3ZpcnRp
bzY0IHJlc2VydmVkWzY0XTsNCj4gIMKgwqDCoCDCoMKgwqAgfQ0KPiB9Ow0KPiANCj4gSWYgb25s
eSBmZXcgb2YgdGhlIGlzIHJlcXVpcmVkLCB3ZSBjYW4ganVzdCBwaWNrIHRoZW0gYW5kIHVzZSBh
bm90aGVyDQo+IHN0cnVjdHVyZS4NClRoZSBwb2ludCBpcyB3ZSBkZWZpbmUgc3RydWN0dXJlIGJh
c2VkIG9uIGN1cnJlbnQgZmllbGRzLiBUb21vcnJvdyBhIG5ldyBSU1Mgb3Igcnggc2NhbGluZyBz
Y2hlbWUgYXBwZWFycywgYW5kIHN0cnVjdHVyZSBzaXplIG1pZ2h0IG5lZWQgY2hhbmdlLg0KQW5k
IGl0IGRlbWFuZHMgdXMgdG8gZ28gYmFjayB0byBsZW5ndGggYmFzZWQgdHlwZWNhc3RpbmcgY29k
ZS4NCmFuZCB0byBhdm9pZCBzb21lIGxlbmd0aCBjaGVjayB3ZSBwaWNrIHNvbWUgYXJiaXRyYXJ5
IHNpemUgcmVzZXJ2ZWQgd29yZHMuDQpBbmQgSSBkbyBub3Qga25vdyB3aGF0IG5ldHdvcmsgcmVz
ZWFyY2ggZ3JvdXAgd2lsbCBjb21lIHVwIGZvciBuZXcgcnNzIGFsZ29yaXRobSBhbmQgbmVlZGVk
IHBsdW1iaW5nLg0KDQo+IA0KPiBBY3R1YWxseSwgSSB0aGluayBqdXN0IHBhc3MgdGhlIHdob2xl
IGNvbmZpZyB3aXRoIHRoZSBkZXZpY2VfZmVhdHVyZXMgZHVyaW5nDQo+IGRldmljZSBjcmVhdGlv
biBpcyBhIGdvb2QgY2hvaWNlIHRoYXQgY2FuIHNpbXBsaWZ5IGEgbG90IG9mIHRoaW5ncy4NClll
cy4gSSB0b3RhbGx5IGFncmVlIHRvIHRoaXMuDQoNCj4gDQo+IFdlIGNhbiBkZWZpbmUgd2hhdCBp
cyBuZWVkZWQgYW5kIGlnbm9yZSB0aGUgb3RoZXJzIGluIHRoZSB2aXJ0aW8gc3BlYy4NCj4gVGhl
biB0aGVyZSdzIG5vIG5lZWQgdG8gd29ycnkgYWJvdXQgYW55IG90aGVyIHRoaW5ncy4gdkRQQSBj
b3JlIGNhbiBqdXN0IGRvDQo+IHNhbnRpeSB0ZXN0IGxpa2UgY2hlY2tpbmcgc2l6ZSB2cyBmZWF0
dXJlcy4NClllcywgd2UgYXJlIHRyeWluZyB0byBoYXZlIGNvZGUgdGhhdCBhdm9pZHMgc3VjaCBz
YW5pdHkgY2hlY2tzIGJhc2VkIG9uIHN0cnVjdHVyZSBzaXplLCBsZW5ndGggZXRjIGZpZWxkcy4g
Oi0pDQoNCj4gDQo+IA0KPiA+IEluc3RlYWQgb2YgZG9pbmcgdGhlbSBhcyBpbmRpdmlkdWFsIG5l
dGxpbmsgYXR0cmlidXRlcywgaXRzIGx1bXBlZCB0b2dldGhlcg0KPiBpbiBhIHN0cnVjdCBvZiBh
cmJpdHJhcnkgbGVuZ3RoLiA6LSkNCj4gDQo+IA0KPiBJIHRoaW5rIG5vdD8gV2Ugd2FudCB0byBo
YXZlIGEgZml4ZWQgbGVuZ3RoIG9mIHRoZSBzdHJ1Y3R1cmUgd2hpY2ggbmV2ZXINCj4gZ3Jvdy4N
Cj4gDQpJIGFtIG5vdCBzdXJlIGRlZmluaW5nIHRoYXQgZnV0dXJlIG5vdyBpcyByaWdodCBjaG9p
Y2UsIGF0IGxlYXN0IGZvciBtZS4NCg0KPiBTbyB0aGUgZGlmZmVyZW50IGlzOg0KPiANCj4gMSkg
dXNpbmcgbmV0bGluayBkZWRpY2F0ZWQgZmllbGRzDQo+IA0KPiBpZiAobmxfYXR0cnNbVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFJdKQ0KPiANCj4gMikgdXNpbmcgbmV0bGluayBhcyB0cmFu
c3BvcnQNCj4gDQo+IGlmIChmZWF0dXJlcyAmIFZJUlRJT19ORVRfRl9NQUMpDQo+IA0KPiANCj4g
Pg0KPiA+IEkgbm90aWNlIHNldmVyYWwgZmllbGRzIG9mIHRoZSB2ZHVzZSBkZXZpY2UgaXMgc2V0
dXAgdmlhIGlvY3RsLCB3aGljaCBJIHRoaW5rDQo+IHNob3VsZCBiZSBzZXR1cCB2aWEgdGhpcyB2
ZHBhIGRldmljZSBhZGQgaW50ZXJmYWNlLg0KPiA+DQo+ID4gQWxzbyB3ZSBjYW4gYWx3YXlzIHdy
YXAgYWJvdmUgbmxfYXR0ciBjb2RlIGluIGEgaGVscGVyIEFQSSBzbyB0aGF0IGRyaXZlcnMNCj4g
dG8gbm90IGhhbmQtY29kZSBpdC4NCj4gDQo+IA0KPiBUaGVuIGl0IHdvdWxkIGJlIHN0aWxsIG1v
cmUgbGlrZSAyKSBhYm92ZSAod3JhcCBuZXRsaW5rIGJhY2sgdG8NCj4gc29tZXRoaW5nIGxpa2Ug
dmlydGlvX25ldF9jb25maWcpPw0KPiANCj4gDQo+ID4NCj4gPj4gV2UgbWF5IG1lZXQgc2ltaWxh
ciBpc3N1ZSB3aGVuIHByb3Zpc2lvbiBWRi9TRiBpbnN0YW5jZSBhdCB0aGUNCj4gaGFyZHdhcmUN
Cj4gPj4gbGV2ZWwuIFNvIEkgdGhpbmsgd2UgbWF5IG5lZWQgc29tZXRoaW5nIGluIHRoZSB2aXJ0
aW8gc3BlYyBpbiB0aGUgbmVhcg0KPiBmdXR1cmUuDQoNCkdpdmVuIHRoZSBkZXZpY2UgY29uZmln
IGlzIG5vdCBzcGVsbGVkIG91dCBpbiB0aGUgdmlydGlvIHNwZWMsIG1heSBiZSB3ZSBjYW4gd2Fp
dCBmb3IgaXQgdG8gZGVmaW5lIHZpcnRpbyBtYW5hZ2VtZW50IGludGVyZmFjZS4NCg0KPiANCj4g
SSBkb24ndCBvYmplY3QgYnV0IGl0IG5lZWRzIHRvIGJlIGRvbmUgaW4gdmlydGlvIHVBUEkgaW5z
dGVhZCBvZg0KPiBuZXRsaW5rLCBzaW5jZSBpdCdzIHRoZSBkZXZpY2UgQUJJLg0KRGV2aWNlIGNv
bmZpZyBjYW4gc3VyZWx5IGJlIHBhcnQgb2YgdGhlIHZpcnRpbyB1QVBJLg0KV2UgbmVlZCBub3Qg
aGF2ZSBwdXQgdGhhdCBpbiBVQVBJLg0KTW9yZSBiZWxvdy4NCg0KPiA+IFRoaXMgaXMgdGhlIHJl
dmVyc2Ugb2YgbmV0bGluayB3aGljaCBvZmZlcnMgdG8gbm90IHJlc2VydmUgYW55IGFyYml0cmFy
eSBzaXplDQo+IHN0cnVjdHVyZS4NCj4gDQo+IA0KPiBJdCdzIG5vdCBhcmJpdHJhcnkgYnV0IHdp
dGggZml4ZWQgbGVuZ3RoLg0KSXRzIGZpeGVkLCBidXQgZGVjaWRlZCBhcmJpdHJhcmlseSBsYXJn
ZSBpbiBhbnRpY2lwYXRpb24gdGhhdCB3ZSBsaWtlbHkgbmVlZCB0byBncm93Lg0KQW5kIHNvbWV0
aW1lcyB0aGF0IGZhbGwgc2hvcnQgd2hlbiBuZXh0IHJlc2VhcmNoIGNvbWVzIHVwIHdpdGggbW9y
ZSBjcmVhdGl2ZSB0aG91Z2h0cy4NCg0KPiANCj4gSXQgbWF5IG9ubHkgd29yayBmb3IgbmV0bGlu
ayAod2l0aCBzb21lIGR1cGxpY2F0aW9uIHdpdGggdGhlIGV4aXN0aW5nDQo+IHZpcnRpbyB1QVBJ
KS4gSWYgd2UgY2FuIHNvbHZlIGl0IGF0IGdlbmVyYWwgdmlydGlvIGxheWVyLCBpdCB3b3VsZCBi
ZQ0KPiBiZXR0ZXIuIE90aGVyd2lzZSB3ZSBuZWVkIHRvIGludmVudCB0aGVtIGFnYWluIGluIHRo
ZSB2aXJ0aW8gc3BlYy4NCj4gDQpWaXJ0aW8gc3BlYyB3aWxsIGxpa2VseSBkZWZpbmUgd2hhdCBz
aG91bGQgYmUgY29uZmlnIGZpZWxkcyB0byBwcm9ncmFtIGFuZCBpdHMgbGF5b3V0Lg0KS2VybmVs
IGNhbiBhbHdheXMgZmlsbCB1cCB0aGUgZm9ybWF0IHRoYXQgdmlydGlvIHNwZWMgZGVtYW5kcy4N
Cg0KPiBJIHRoaW5rIGV2ZW4gZm9yIHRoZSBjdXJyZW50IG1seDVlIHZEUEEgaXQgd291bGQgYmUg
YmV0dGVyLCBvdGhlcndpc2Ugd2UNCj4gbWF5IGhhdmU6DQo+IA0KPiB2RFBBIHRvb2wgLT4gW25l
dGxpbmsgc3BlY2lmaWMgdkRQQSBhdHRyaWJ1dGVzKDEpXSAtPiB2RFBBIGNvcmUgLT4gW3ZEUEEN
Cj4gY29yZSBzcGVjaWZpYyBWRFBBIGF0dHJpYnV0ZXMoMildIC0+IG1seDVlX3ZEUEEgLT4gW21s
eDVlIHNwZWNpZmljIHZEUEENCj4gYXR0cmlidXRlcygzKV0gLT4gbWx4NWVfY29yZQ0KPiANCj4g
V2UgbmVlZCB0byB1c2UgYSBzaW5nbGUgYW5kIHVuaWZpZWQgdmlydGlvIHN0cnVjdHVyZSBpbiBh
bGwgdGhlICgxKSwgKDIpDQo+IGFuZCAoMykuDQpUaGlzIGlzIHdoZXJlIEkgZGlmZmVyLg0KSXRz
IG9ubHkgdmRwYSB0b29sIC0+IHZkcGEgY29yZSAtPiB2ZW5kb3JfZHJpdmVyDQoNClZkcGEgdG9v
bCAtPiB2ZHBhIGNvcmUgPSBuZXRsaW5rIGF0dHJpYnV0ZQ0KVmRwYSBjb3JlIC0+IHZlbmRvciBk
cml2ZXIgPSBzdHJ1Y3RfZm9vLiAoaW50ZXJuYWwgaW5zaWRlIHRoZSBsaW51eCBrZXJuZWwpDQoN
CklmIHRvbW9ycm93IHZpcnRpbyBzcGVjIGRlZmluZXMgc3RydWN0X2ZvbyB0byBiZSBzb21ldGhp
bmcgZWxzZSwga2VybmVsIGNhbiBhbHdheXMgdXBncmFkZSB0byBzdHJ1Y3RfYmFyIHdpdGhvdXQg
dXBncmFkaW5nIFVBUEkgbmV0bGluayBhdHRyaWJ1dGVzLg0KTmV0bGluayBhdHRyaWJ1dGVzIGFk
ZGl0aW9uIHdpbGwgYmUgbmVlZGVkIG9ubHkgd2hlbiBzdHJ1Y3RfZm9vIGhhcyBuZXdlciBmaWVs
ZHMuDQpUaGlzIHdpbGwgYmUgc3RpbGwgZm9yd2FyZC9iYWNrd2FyZCBjb21wYXRpYmxlLg0KDQpB
biBleGFjdCBleGFtcGxlIG9mIHRoaXMgaXMgZHJpdmVycy9uZXQvdnhsYW4uYw0KdnhsYW5fbmwy
Y29uZigpLg0KQSB2eGxhbiBkZXZpY2UgbmVlZHMgVk5JLCBzcmMgaXAsIGRzdCBpcCwgdG9zLCBh
bmQgbW9yZS4NCkluc3RlYWQgb2YgcHV0dGluZyBhbGwgaW4gc2luZ2xlIHN0cnVjdHVyZSB2eGxh
bl9jb25maWcgYXMgVUFQSSwgdGhvc2Ugb3B0aW9uYWwgZmllbGRzIGFyZSBuZXRsaW5rIGF0dHJp
YnV0ZXMuDQpBbmQgdnhsYW4gZHJpdmVyIGludGVybmFsbHkgZmlsbHMgdXAgdGhlIGNvbmZpZyBz
dHJ1Y3R1cmUuDQoNCkkgYW0gdmVyeSBtdWNoIGNvbnZpbmNlZCB3aXRoIHRoZSBhYm92ZSB2eGxh
biBhcHByb2FjaCB0aGF0IGVuYWJsZXMgYWxsIGZ1bmN0aW9uYWxpdHkgbmVlZGVkIHdpdGhvdXQg
dHlwZWNhc3RpbmcgY29kZSBhbmQgd2l0aG91dCBkZWZpbmluZyBhcmJpdHJhcnkgbGVuZ3RoIHN0
cnVjdHMuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
