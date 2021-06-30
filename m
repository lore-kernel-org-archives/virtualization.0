Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D918AC11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 06:03:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D4B61CA5
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 06:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D4B61CA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3FB7040293;
	Wed, 30 Jun 2021 06:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2KTZFCQlnSxP; Wed, 30 Jun 2021 06:03:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E2A8240004;
	Wed, 30 Jun 2021 06:03:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A58D8C001A;
	Wed, 30 Jun 2021 06:03:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95C4BC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A7186FB49
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtliGIR8UUJI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:03:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F0676FB48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 06:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls0CZne5VqQD+3O0t53oTs42t6YzKsFN+UPhjq8LG1+3DekucU39UJ6BS4uGQVBa0pol/FsTMdPbqts1jRUdaWrzCuFu6bMqC67cSmYABsADG0yZQ190meDvlZnf0IH6yxjEIWCfPQlPAbx4z6vCkubF+B0UXhyVvMCqgjTAONnf7kk5Op3ektQDxigWEPV2kU5QylhrRy4nBM4VXGsUIaaf0kWey9QnHAmsCXENtS9K8OLBVm9JHGnBd2H/VBjPPUlISKcirvLfs1hGJhiAtNRdMoGDoJxZNUSZfdUHcnk1EZUBJt3K1OfeDVM53tYwAz9AEIvxP/Z4yqM3Nr5Jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrvwOwb/avXrYIdjySDyoatW1FRytKimo1KVVbBKIW4=;
 b=UBTmRkqJEu318OSqo1RAxwdqiHEBVddk/ersbN8qK7eOMK7TEy4FD4anFpQrZADOdkX3lQdtVjl2XAxHtEvWR6d5qYLahuBaYb/uvwfIO3s4gcg40h8au6HB5t9SxpPI1QKJkzLb+zDpd2nKhnpZbai0eV2+CXlUANb7mwyWS+D/q1CMqJgTVoxe6SUEXNo9oFcR4kR9MKtvZi/UbjTPcUl3WEa5FEDmCeTe04npE9g2eExw68rdk5j4FcccmmKEOeeaRnSOGAvrob9vPkVkzBgv0NPI2LjfvISI1n/F1/EhCuinK9r6KDjAgGMyAJdodxqVYGjaR6BVV0lzoyWm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrvwOwb/avXrYIdjySDyoatW1FRytKimo1KVVbBKIW4=;
 b=cDKwd3lZiMSV+/RXcaWaw4Spm9tAswkBgcunioSU+IqUdFQpQLkThMOvs2LIXPMFJC8QL/VN6P38XTNxcK56DPdGkWvB+TH8s4zppq3EK+nM/U+/vttKZh7m2kQbl3dwb1p/uBiuK4bqQBtHRRIYwoT5QD8Y4Go/j0g6tdcr9nsy1l2/DjmZMH+6175BXerG4EgToYw1D2LULauQhryuEqtcBUGv7XTSEDkPs/rGxi/ccGfcX2eA5JBFEg/xQkmNavNJIWoFthjM+iKivSAXEh6BbSrU6ighuFT/DjguzKbOzAuonUzlfvOgatvIlOUyRetwSLOeKm1WXkafgOECJQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 30 Jun
 2021 06:03:15 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb%7]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 06:03:15 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KCAAO8RAIAAAJPAgAGsGACAAAPf8IAAEweAgAAIirCAAU1RAIAAMiFQgASfUwCAAF8F0IABH3+AgABhb2CAATvVgIAAFmuQ
Date: Wed, 30 Jun 2021 06:03:15 +0000
Message-ID: <PH0PR12MB5481737F058FDE9B947C1ECFDC019@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
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
In-Reply-To: <8c78b8ed-e16c-31dd-7c1c-abd2bef6bb12@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2f89e48-23dd-4c41-b2fc-08d93b8cc016
x-ms-traffictypediagnostic: PH0PR12MB5450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5450A427011AE686294AAA08DC019@PH0PR12MB5450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uU14OWmZYijM9vP+0Ni3w/JBodSdMAWCkfyhR68DR7ocyGw66Uu7Q02EDrePgTaikzT5mgAoReyAU8mWFjE1D86IAf46cDeDMAJDwg56a2nKC8WBcTT1RU6UjXJC4BbPU4whkequKgAzYvLT5EHDVrYGKXbqYCRMHFvVPnARD2I8FUeXQtIoCs9BVU1r3ihgTogFuT4eCbQEH14vgiPeqf+9jEFuXIPRIF6LcOXmEc4jg50wY68w9g0bnHHMRAzTfgSerKmT5YmEzzAtKeNoGP41QD/3WQ7DdusR4zMorLb+cceWU1WZL5GwmOS2avH2wM0YHinfzMAW90l8dIFMT/GEOaKGnRRqyAQ+NGI7xT2fggK4VTG9TOZhUqvbOMgMRNk0tn2zy3w3q57wrKfM3sE47KswgJg9mtNTNcF9Pwpvy0OcBbRTXt79CcqrEevwpUpAdKzHPdAVbRmlHV+zI8ncP3xhvrP3j3cNNUL001kt//q7I3v8ToyqHec/OEiZuqRycdBilaUpnjS9Pmw9Xe2UBpr38KPlfW79YXedz3kYLuD5r01qPzKeKJeCJdqSeShl7ogt5HNNRRqR+hKAa+Ns2Nb5IcBsuMCL2Dt/yiU8ohkqpEvFzWHxbUKrY+Tcu+ZMPshaNNunfaF0emmJrsXzK9g6/RUQn0UNjTP41/SY0+uSWu1oVm5yCkqABNBNwWj0oj69ZXwjkONUf/2Rog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(33656002)(122000001)(71200400001)(478600001)(55016002)(38100700002)(110136005)(9686003)(86362001)(52536014)(54906003)(2906002)(316002)(66556008)(8936002)(66946007)(76116006)(8676002)(26005)(4326008)(66476007)(66446008)(5660300002)(7696005)(64756008)(6506007)(107886003)(186003)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3lhQkRpSzVNbE92OTAybzJISlNNQVpDVEgzZm5mSythUFNpcjQybHN6elhU?=
 =?utf-8?B?UzlFQUlOSU9VUFdKdjh4Q2NKTkkrcUYvbEN5SjM3b2ttNlkrc1BxUjRCL3JL?=
 =?utf-8?B?clQ2elNYcEJCUmNqaGx0RVBUMHRjWCtoT0RDbHFtaVQvSGM5dktpTk1qUTFH?=
 =?utf-8?B?emF2eSsyOGlQbVBRaURBSm1wUmlwSjlBVGcycHlML1N6bzZZeHdyMlV1TWZH?=
 =?utf-8?B?OEtINDJ1cDRDUUhEZlF4SFZ4eGlyTVBzejRlSlQzZ0pSaWF1czJuZ2dUMFlo?=
 =?utf-8?B?aHlUNnRvYk1NUFFsUFFmaDFVbUlqR0dWWC9Od2pGUVltcy8ramt3YjROMGR4?=
 =?utf-8?B?aUErRFk5c2h1N2JKSThNK2I3MktaVFkrWVhMVUN2VkpXRjduSFNIRklaNVl2?=
 =?utf-8?B?SXB4SkkvWXNXeVJrVDE3bWtMQVlQS2RoRmlOWkorc0N3blRrVWMySE9MMUdn?=
 =?utf-8?B?Q3ErZHcxak5oSEVLdy9VTXo3cnpLQ1NqbGE0V3MrNGk4MzVTR2JpUHpiTVRt?=
 =?utf-8?B?ZzBlQmVGVDdNSm9MemRaWTM2U25tYWpQS0QzRS82cnRKS2lUampQd0lyWjZP?=
 =?utf-8?B?b2dXS2lGd2RPa3FYbithV3M3dmhmYkFXbm9BR1J0bjhDdHZUY28rOVp0WFh5?=
 =?utf-8?B?enJGekZFY3ZIc1pScldLV3EybExzSS9jL1BtN3FlaFdlL0lXdkJyc1lsQWNW?=
 =?utf-8?B?eHRETDA2UzRzZmtzTU05YzBURkg1OTBKTlNCVmdxVGZBSlJFRllXbjNGNTFE?=
 =?utf-8?B?eWtJMDdXc0pVYW1XbWhaQUkrdVBzOEN5dnRWa2t6SVlCQldlL1JMZlVMMlRk?=
 =?utf-8?B?enBKMDVJQTd2dW1kWEc0VFdzbWlkMUZjVExpSzgzdkx0Nmx5TDhkY2NubzZz?=
 =?utf-8?B?MnB2Z1BWNTVPNEVlQ0cwMWpvTWhZaERqa0VrcUo4bXFWdndKTldqSFMzVjhU?=
 =?utf-8?B?d09pOThlc0JpUHdYTmNiVjdRbXRkcjJwS3lkSEYvTTN4bk9UZjluOVI2U3h5?=
 =?utf-8?B?QzZIVTlKRllnTndXdnJWOStiRkJpaWRodXBpRWRpUnpDWUtMWnpIUkdSalVD?=
 =?utf-8?B?N0U5RnpnNTFHWXpMQVc4cWRWbVBPTlFUYkNNVGNmZE45WjgyZ1c5d096Y2o5?=
 =?utf-8?B?WFRkYUE4MnQ3Umh0dk1vbmhtQU95NHhnQXdaM2pHaEErSWd6ZGRTNVc1cU96?=
 =?utf-8?B?clV3SHNqZmJSOUhjazB5VCthdEFEUWlVTEI2T0hUeEhMMkZTa05RUU5DbFlV?=
 =?utf-8?B?dTVMRkhDeVM0dlZQQmdxVXE2MUIrY1JMS0U0UjlmT3gydkZkem1qc3VMUk4r?=
 =?utf-8?B?b0NPeFZMaEEvVlJZWXd2bzgxNHEvZHBxWUcvQWJlSk0vakRaWWpvZ04zU3l6?=
 =?utf-8?B?Z1NmWk1OSS93RDlwM25JV3M3ZnhKQmFsSlpmeDhKNVVUOXVodk5VS2xPWHl2?=
 =?utf-8?B?eHNaMTFOdTRFSUhOa3ZzdUJaeFpFdWtxMk1ranR2WXZpRGxBQkpDNjUxbzZj?=
 =?utf-8?B?WmpJUWNxME1YRmVxQzZTVXRaeDJ3SWl1YWo5WjVMM2JibUFsZGw0bjFGN2ow?=
 =?utf-8?B?VmRWMk9zTEVpOWhHNVpQTlZyLzI1SkM0aEI1aXJoTHpJZkJ3bkNkVmVhNE5E?=
 =?utf-8?B?aFdJKzNtaHhySlhtRXY3QVRMaDA4a3JFeXlpNVVtVndENzdsT1NqRk90OHZS?=
 =?utf-8?B?T0FGK1hyem9mbHE1b25kek41c3lRaFNuZlQ5cHdMNXBrV3FESnk0QzFBZnh1?=
 =?utf-8?Q?/B6jtaEJ7/6fIR+jgf9TnFfa6ZGHDHe/8HZMeLR?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f89e48-23dd-4c41-b2fc-08d93b8cc016
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 06:03:15.3032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxoG0p5HKs2nt5vUhVumTkuXVwlTTc9uJgtiCt4UTKW7eV0ujtJFZ8+LsupmGostHLAppBkXw+ilCP+JzmGD7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
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

SGkgSmFzb24sDQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4g
U2VudDogV2VkbmVzZGF5LCBKdW5lIDMwLCAyMDIxIDEwOjAyIEFNDQoNCj4gPj4gSXQgbG9va3Mg
dG8gd2UgZG9uJ3QgbmVlZCB0aGUgcmVzdCBvZiBmaWVsZHMgaW4gdGhlIHZpcnRpb19uZXRfY29u
ZmlnDQo+ID4+IHRvIGJ1aWxkIHRoZSBjb25maWcgc2luY2UgdGhleSBhcmUgYWxsIGhhcmR3YXJl
IGF0dHJpYnV0ZXMuDQo+ID4gVG9kYXkgaXQgaXMgb25seSBtYWMgYW5kIG1heCBxdWV1ZXMuIExh
dGVyIG9uIHdlIG1heSBuZWVkIHRvIGRlZmluZSByc3MNCj4gaGFzaGluZyBhcyBody9kZXZpY2Ug
YWR2YW5jZXMuDQo+ID4gQW5kIHN0cnVjdHVyZSBzaXplIHdpbGwgY2hhbmdlLg0KPiA+IEhlbmNl
LCBJIHByb3Bvc2UgdG8gaGF2ZSBlYWNoIGFzIGluZGl2aWR1YWwgYXR0cmlidXRlIHRoYXQgZG9l
c27igJl0IG5lZWQgdG8NCj4gY2FzdCBpbiBzdHJ1Y3QuDQo+IA0KPiANCj4gT2ssIHRoYXQgc2hv
dWxkIHdvcmsuIElmIE1pY2hhZWwgYXJlIGZpbmUgd2l0aCB0aGlzLCBJJ20gYWxzbyBmaW5lLg0K
PiANCj4gSnVzdCB0byBjbGFyaWZ5LCBpZiBJIHVuZGVyc3RhbmQgdGhpcyBjb3JyZWN0bHksIHdp
dGggdGhlIGluZGl2aWR1YWwgYXR0cmlidXRlLA0KPiB0aGVyZSdzIG5vIG5lZWQgZm9yIHRoZSBi
aXQgbGlrZSB4eHhfaXNfdmFsaWQ/DQoNCnh4eF9pc192YWxpZCBpcyBub3QgcHJlc2VudCBpbiB0
aGUgZ2V0IGNhbGxzLg0KSXQgaXMgYWxzbyBub3QgcHJlc2VudCBpbiBVQVBJIHNldCBjYWxscy4N
Ckl0IGlzIG5vdCBhIFVBUEkuDQpJdCBpcyBhbiBpbnRlcm5hbCBiZXR3ZWVuIHZkcGEuYyBhbmQg
dmVuZG9yIGRyaXZlciB0byB0ZWxsIHdoaWNoIGZpZWxkcyB0byB1c2UgYXMgdGhlcmUgYXJlIG9w
dGlvbmFsLg0KSWYgd2Ugd2FudCB0byBnZXQgcmlkIG9mIHRob3NlIHZhbGlkIGZsYWdzIGJlbG93
IGNvZGUgd2lsbCBtb3ZlIHRvIHZlbmRvciBkcml2ZXIgd2hlcmUgd2UgcGFzcyBubF9hdHRyLCBk
dXJpbmcgZGV2aWNlIGFkZCBjYWxsYmFjay4NCg0KDQorCWlmIChubF9hdHRyc1tWRFBBX0FUVFJf
REVWX05FVF9DRkdfTUFDQUREUl0pIHsNCisJCW1hY2FkZHIgPSBubGFfZGF0YShubF9hdHRyc1tW
RFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUl0pOw0KKwkJbWVtY3B5KGNvbmZpZy5uZXQubWFj
LCBtYWNhZGRyLCBzaXplb2YoY29uZmlnLm5ldC5tYWMpKTsNCisJCWNvbmZpZy5uZXRfbWFzay5t
YWNfdmFsaWQgPSB0cnVlOw0KKwl9DQorCWlmIChubF9hdHRyc1tWRFBBX0FUVFJfREVWX05FVF9D
RkdfTVRVXSkgew0KKwkJY29uZmlnLm5ldC5tdHUgPQ0KKwkJCW5sYV9nZXRfdTE2KG5sX2F0dHJz
W1ZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFVdKTsNCisJCWNvbmZpZy5uZXRfbWFzay5tdHVfdmFs
aWQgPSB0cnVlOw0KKwl9DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
