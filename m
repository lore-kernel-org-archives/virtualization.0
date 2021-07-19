Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF7DC07E95
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 14:15:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191B9610D2
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 14:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191B9610D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF9C64030F;
	Mon, 19 Jul 2021 14:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QEK60xubCUD3; Mon, 19 Jul 2021 14:15:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18E6840294;
	Mon, 19 Jul 2021 14:15:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3E69C0010;
	Mon, 19 Jul 2021 14:15:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B65E7C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 14:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5040402FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 14:15:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gvwFfBruEi-r
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 14:15:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F77440294
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 14:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izN+tIBTE/2MvTVc6+e2tP2nKpXBry5b2B7hgmUdfYs5j2grjyj2deKq8btWReF96s7TgVFpgjiS9iK34gliC1zo+k0MZKN/9fvSTO/SBux1TERO0kwpl0/wLq9fA+jGD76EzTYxQjiqc8exyBRjU/+t03uFb+fJUuloUNM0EC/MCORYfVv3JO5i4aLNlaFE05qi5cfHMNCCgrL8RJhub6JWJiwCBhnIypiKPFUC+/vfnihLEXBxrE0QDgOpABN2D1iTwgjJ7cUTJD1HPZpa/Bo2zzAQAHPCT2n3wK/eyXOz5CcQpiyEk5XnP/4TaMlISWhrRzScsTCWIyDGAsp31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zGKV7RweprnKFjwQFXT2IBjirlFtpYLeUiIEGLpXNs=;
 b=MpIlbj7/7B9nSwv/o7BoCQ/F5Ee03Xy6YZiK0TMNysxEZ9XeDcAY7ZylQDxuE4Tm/2NuEP8xt15bzTf3Hz7Al3jAajq+3aVVAtCx0SUF1Oj8TBhqnvsIEHx5Np+UHKQeX9OqautrZ7P+wa/Z3Ysy9j0ZLea6Of2CDQfH+fZU2ZODCnN2P91l3SYlTDZVZ0oolkGPPw4v6DobcdhOryiUkp4O/DtZ0Vd6UaU9366EUpv4P/+D0pzIwBPqVlpOXevMYIt7ZDiYK2jCuGzOS0S2isqC2rxZZpPo7/yoMeYIlZzspCsk6NM2UVc9xoGTge0XEqY2wXoNVJGnmmxJ9SvA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zGKV7RweprnKFjwQFXT2IBjirlFtpYLeUiIEGLpXNs=;
 b=a2BetAb2RNMIglcaYeL0BdGfqoKbInGZnGuHzKVbFDGYh5lGLXJjdNYrFqfaV74JUa9PNxYXC3kXkHL0d9Fo+0+5jsp03cB+Leejwv5QKYy7DfR7aI3L27sLDTfXjDCLB2bzWbarFw1dVjcxxlktTFR27tWOg35xy5l8TZd2LB18k6cGOAkhjLdxlaPLyWey75xj7wzd/GfvB1iN9TKmH1MGB71T780ko4dhM8gAYWKqWaPSXa8ktK+h4ydifmL6H9XQ2D4cAoF+t1beE4kQuhaImLkpy8Y/Ofj7VpnjyeFNzz/AlGw8myRGYZ9VgSEBfz0ykFvdznX80ON76Oj2Ow==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5452.namprd12.prod.outlook.com (2603:10b6:510:d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 14:15:02 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 14:15:02 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH 4/4] virtio_pci: Support surprise removal of virtio pci
 device
Thread-Topic: [PATCH 4/4] virtio_pci: Support surprise removal of virtio pci
 device
Thread-Index: AQHXet9qXyqqP8cKqUKjOeX+GMx7yqtHo++AgAImpFCAAGziAIAAIaqg
Date: Mon, 19 Jul 2021 14:15:02 +0000
Message-ID: <PH0PR12MB5481E20BD629993381E334E5DCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-5-parav@nvidia.com>
 <20210717164152-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813A3CA2397ACE87A1DAF6DCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210719080539-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210719080539-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dda5d90-c54d-40c0-12aa-08d94abf99b4
x-ms-traffictypediagnostic: PH0PR12MB5452:
x-microsoft-antispam-prvs: <PH0PR12MB54525DA78ACD8986DE8DA742DCE19@PH0PR12MB5452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qtb+TLC3j1SrHE+MpAFYxOYz7i82qUx2K5QPbAArEEGdQDpXZFwVpezQ4onnGlQaFPmV7imc6ou1NiU6A4bxR77qnxNzt7SqwzWrqODdedZvnVQXq1I1C9tAH5Xp8Qrxfcv/5HY29BmNS3tTtwCLvnacMmXIjpAYIhBiUH8HOyMmuFJIt4CV6eFB/4yUok1aJ/yq/X/FDRjq0EQ4R1Gttd48uCoZWK9qth6R1+w08m6zSUidpcesTJ1wNGQ/etoLpWVcbKpmo+84ZrjenZEvVcRb3IpLYc20YZChHeGsceg0hsM2WYwyP0uviFlx1DI0DVJnHwo4yNCZgu3mT/KO/DSNhbHTCilEc6YPNqL4J6clyd1/xu1Vty4wFgcNwG+bq5dNbQTDPCX++cly/GsKMwE4eRvRBW+IHYyEqfy4H/F/Ftqmd48ozandxxtyIcna7cR2Mc6kjLhOPPfh8Pt9uS43HBwPHh5lOxUhOBVwuBj3AliiUpFv8es+scdcD/b/LHwKp/4SQdo+MhtTCy6H1+u8xTJ+85nVNBr5gRRZEeZxxHzZidJIKjSVfqUPxTiZpi465WmTE49maIgFiUrHCM6M1mz+rAafp+YuCc28qif0rH0LSFiiXRNDcEFs0EboIXe5TS3xFmOY3U7f+un5s7YRm2B1bd1W//bg/e4VWBrNwKL1nRmCeFST8u1/3QWz/Cxb98evSCcRifXJH4fIUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(86362001)(186003)(7696005)(6506007)(71200400001)(8936002)(9686003)(83380400001)(4326008)(6916009)(26005)(2906002)(55236004)(55016002)(5660300002)(66476007)(66556008)(64756008)(8676002)(316002)(122000001)(66446008)(76116006)(38100700002)(66946007)(52536014)(33656002)(478600001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDF3YzZPbVIvVUZQdXNaL05YdkIxdDA2bkNrZStJU0tpazZLaUdYbHA2aWdN?=
 =?utf-8?B?UE1kRTFZd1JPMzlmWFhhMzRKd05sNWpxNHZwSE16Tlo4SzZ2aGNXN1pkRTZH?=
 =?utf-8?B?cThqTGxFdHZlMi9YL0ppNTMxWUtoeDk0dFZJbkQ4K2ZBOFBKYXZ2Szd3dG5N?=
 =?utf-8?B?bXFwTU9wZTh6QmwycTlLZ05ISElTeWd4NWJpQ0NLREZMT1dySXlVWjhDTmE2?=
 =?utf-8?B?UmRXUmVOZEVzcWtMSEJBc3BZUk5nSm5DK3A3MUo3S0hNOG5SVFZCbzR5VXhv?=
 =?utf-8?B?cTJ4REhqM3R2R2xZL2NFK2xQVC93aXVQZitmb1lhaTVOQmNjZ0s4OTNSdVNK?=
 =?utf-8?B?QmUrZ3RUSVZPcHMrcm94bkRoM2hzdVBNZEJscWlzRDErRjRrdEMwaURYbDdP?=
 =?utf-8?B?aldtRGxOT0Y3N0s4WStXdkV0MzBJZmlSS3orL1FNaDBwZ2IvRFlhNkFDdUpH?=
 =?utf-8?B?dmNBSklEcmJjemFNeTVZdVcxdHBtRmIyL256Y1dJNUtBb0NyclZWaWV2WmhG?=
 =?utf-8?B?NGJBUUE3UnBwMSsxL1VPUVZuK3IwN1VzelhBeFc5L3c5eWVkakh4QmNTRGlV?=
 =?utf-8?B?ZEpaOXV6aVQ3elZjaHBoNGJRTE5SK3ZoNmJFeUdRN1ZTU2JEaXpmcDZURmtJ?=
 =?utf-8?B?SHA5eW5oOVFsUUYrUmtqQUh3aHg1anBiNlhXbWtQWFRWYXYvRzdDZ3c5eUFH?=
 =?utf-8?B?L3lsSEdVTTNGM0p2bjJScHB2UURSbGFmTStXSnl4UTBzVjhacDI1TVpIa1ZX?=
 =?utf-8?B?TDkzNWRNaGN1NFpwS1hpUmxkVlZRK0o4UGZ0NXNLZENZNTdkR1ZzYmVwL1ZM?=
 =?utf-8?B?bEMxdUlBUXNDK1JUTDhSWDM3NnlRbWdybWU1ZlFuaS82NEttc04xeEcrWVFP?=
 =?utf-8?B?OFF5MXJESzN2RDBLZkJVRWFHeDh3ZlRuQW1VL2I5YzBnUHByVVV6cHRPZ3ht?=
 =?utf-8?B?bGdrbWFicWg2dTZCa2IwaWRmSlJDL1VXemdyRkNhTUZlK3pnMlRmL09DZU44?=
 =?utf-8?B?MDhoZEY2NmEvUWhXeWFsMFNxd1IrdzlZd3ZvWkMydHgzQ1hsc01EelppVWJp?=
 =?utf-8?B?alhnbk9vbWtrdUJydk1QWWMwVmdibGRVbWZ3UkR2ZzNWcEdheEo1Qm1QQmZa?=
 =?utf-8?B?YUJabzQvbkVrUEgxSENYYU45MXZoa0dEbVZVMGNyMjE5RHRrYU1XUTVPR1da?=
 =?utf-8?B?am9rbW13WTNnQy9LaUVnZnVhYUNTNVFYUS9SblJjVTFId0ErYVZPcmxrQXVp?=
 =?utf-8?B?Y2czNk1rU2lmdEpZYnBKSEZreGFyVTRHSG9FZ1UrUHVaQU1BL053WFVaR3Jo?=
 =?utf-8?B?UGp0cU1aSHRheFhhcWNFcGNaTm5xL0JJd1dDdzVYRWV2R3NoYXpiNkFyTG1Z?=
 =?utf-8?B?b0pYdnNZSE96Z2NsSWZLczJiT3dhUGErM3d5cWRpaEJMczZQTll0anpLQlpY?=
 =?utf-8?B?THBOQ0gxdkNteWRDK2pkVmZpY0d1TkFGaUExaVdkMmx2RkVlWmpMVXFJUmJL?=
 =?utf-8?B?RHRhQU5xY0RhMkYwMzAvUDYrMkV1bXFkV1JvcUJRY0hHNktPbFZ5MnNiZ28r?=
 =?utf-8?B?ai9EWDQvQklEbUw0ZVdQMWF0S04zYTlRRFNPOVg3ZGVEMzhrVEMxMjQzV3Er?=
 =?utf-8?B?SXhPbkwzSEhZblpidEdKUG8zb29LVE5RdFVrc20vcUxuZjJ2a2N5TmhUSXFz?=
 =?utf-8?B?WkNjMG1mSHBKak1acjRDazgrNjE4SGlhZkwvQlRZSVNvcU5EU3ZzUEY3Y2Y2?=
 =?utf-8?Q?m84PafrnhGJIgZbx+ciLzD/3/Xch/GGp5TFnU4c?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dda5d90-c54d-40c0-12aa-08d94abf99b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 14:15:02.6644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aKm+DTMeMGhFH6wcltr9qom40suuuaspkUuDfaaxy+i7o8ixXp3M+lOhanNB7Qd0x7kK9kMOr+O5klv+iAG8zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5452
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
TW9uZGF5LCBKdWx5IDE5LCAyMDIxIDU6MzcgUE0NCj4gDQo+IE9uIE1vbiwgSnVsIDE5LCAyMDIx
IGF0IDA1OjQ0OjQ5QU0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPg0KPiA+DQo+ID4g
PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiA+ID4gU2VudDog
U3VuZGF5LCBKdWx5IDE4LCAyMDIxIDI6MTcgQU0NCj4gPiA+DQo+ID4gPiBPbiBTYXQsIEp1bCAx
NywgMjAyMSBhdCAxMDo0Mjo1OEFNICswMzAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4gPiA+
IFdoZW4gYSB2aXJ0aW8gcGNpIGRldmljZSB1bmRlcmdvIHN1cnByaXNlIHJlbW92YWwgKGFrYSBh
c3luYw0KPiA+ID4gPiByZW1vdmFsbiBpbg0KPiA+ID4NCj4gPiA+IHR5cG8NCj4gPiBGaXhpbmcg
aXQuIENoZWNrcGF0Y2gucGwgYW5kIGNvZGVzcGVsbCwgYm90aCBkaWRuJ3QgY2F0Y2ggaXQuIPCf
mIoNCj4gPg0KPiA+ID4NCj4gPiA+IE9LIHRoYXQncyBuaWNlLCBidXQgSSBzdXNwZWN0IHRoaXMg
aXMgbm90IGVub3VnaC4NCj4gPiA+IEZvciBleGFtcGxlIHdlIG5lZWQgdG8gYWxzbyBmaXggdXAg
YWxsIGNvbmZpZyBzcGFjZSByZWFkcyB0byBoYW5kbGUNCj4gPiA+IGFsbC1vbmVzIHBhdHRlcm5z
IHNwZWNpYWxseS4NCj4gPiA+DQo+ID4gPiBFLmcuDQo+ID4gPg0KPiA+ID4gICAgICAgICAvKiBB
ZnRlciB3cml0aW5nIDAgdG8gZGV2aWNlX3N0YXR1cywgdGhlIGRyaXZlciBNVVNUIHdhaXQgZm9y
IGEgcmVhZCBvZg0KPiA+ID4gICAgICAgICAgKiBkZXZpY2Vfc3RhdHVzIHRvIHJldHVybiAwIGJl
Zm9yZSByZWluaXRpYWxpemluZyB0aGUgZGV2aWNlLg0KPiA+ID4gICAgICAgICAgKiBUaGlzIHdp
bGwgZmx1c2ggb3V0IHRoZSBzdGF0dXMgd3JpdGUsIGFuZCBmbHVzaCBpbiBkZXZpY2Ugd3JpdGVz
LA0KPiA+ID4gICAgICAgICAgKiBpbmNsdWRpbmcgTVNJLVggaW50ZXJydXB0cywgaWYgYW55Lg0K
PiA+ID4gICAgICAgICAgKi8NCj4gPiA+ICAgICAgICAgd2hpbGUgKHZwX21vZGVybl9nZXRfc3Rh
dHVzKG1kZXYpKQ0KPiA+ID4gICAgICAgICAgICAgICAgIG1zbGVlcCgxKTsNCj4gPiA+DQo+ID4g
PiBsb3RzIG9mIGNvZGUgaW4gZHJpdmVycyBuZWVkcyB0byBiZSBmaXhlZCB0b28uDQo+ID4gQWJv
dmUgb25lIHBhcnRpY3VsYXJseSBrbm93biB0byB1cyBpbiB0aGUgaG90IHBsdWcgYXJlYS4NCj4g
PiBBYm92ZSBmaXggaXMgbmVlZGVkIHRvIGNsb3NlIHRoZSByYWNlIG9mIGhvdCBwbHVnIGFuZCB1
bnBsdWcgaGFwcGVuaW5nIGluDQo+IHBhcmFsbGVsLCB3aGljaCBpcyBvY2N1cnJpbmcgdG9kYXks
IGJ1dCBsZXNzIGNvbW1vbi4NCj4gPiBJdCBpcyBpbiBteSB0b2RvIGxpc3QgdG8gZml4IGl0Lg0K
PiA+IFdpbGwgdGFrZSBjYXJlIG9mIGl0IGluIG5lYXIgZnV0dXJlIGluIG90aGVyIHNlcmllcy4N
Cj4gPg0KPiA+ID4NCj4gPiA+IEkgZ3Vlc3Mgd2UgbmVlZCB0byBhbm5vdGF0ZSBkcml2ZXJzIHNv
bWVob3cgdG8gbWFyayB1cCB3aGV0aGVyIHRoZXkNCj4gPiA+IHN1cHBvcnQgc3VycHJpc2UgcmVt
b3ZhbD8gQW5kIG1heWJlIGZpbmQgYSB3YXkgdG8gbGV0IGhvc3Qga25vdz8NCj4gPiBXaGF0IGlz
IHRoZSBiZW5lZml0IG9mIGl0PyBXaG8gY2FuIG1ha2UgdXNlIG9mIHRoYXQgaW5mb3JtYXRpb24/
DQo+IA0KPiBGb3IgZXhhbXBsZSwgaG9zdCBjb3VsZCBhdm9pZCByZW1vdmluZyBkZXZpY2VzIGJ5
IGhvdCByZW1vdmFsIGlmIGd1ZXN0IGlzDQo+IG5vdCByZWFkeSBmb3IgaXQuIE9yIGxpYm9zaW5m
byBjb3VsZCB1c2UgdGhhdCB0byB0ZWxsIHVzZXJzIHdoYXQgdG8gZG8uDQpOb3Qgc3VyZSBob3cg
dG8gYWNoaWV2ZSBpdC4gQmVjYXVzZSB0aGlzIGlzIGRlY2lkZWQgYnkgdGhlIHBjaSBob3QgcGx1
ZyBkcml2ZXIgYXQgYml0IGVhcmx5IHN0YWdlLg0KQW5kIHBjaSBob3QgcGx1ZyBzbG90IGRvZXNu
J3Qga25vdyB3aGF0IGlzIGdvaW5nIHRvIGFycml2ZSBpbiBpdC4NCg0KPiANCj4gPiBJbiB2aXJ0
aW8gcGNpIGNhc2UsIGl0IGlzIHNpbWlsYXIgaW1wcm92ZW1lbnQgdG8gd2hhdCBudm1lIHBjaSBk
cml2ZXIgd2VudA0KPiB0aHJvdWdoIGZldyB5ZWFycyBiYWNrIHRvIHN1cHBvcnQgaG90IHBsdWcv
dW5wbHVnLg0KPiA+IExldHMgY29tcGxldGUgdGhpcyBvZiBmaXhlcyB0byBtYWtlIGl0IGxpdHRs
ZSBtb3JlIHJvYnVzdCBsaWtlIG52bWUuDQo+IA0KPiBBdCBsZWFzdCBwbGVhc2UgbWVudGlvbiBp
biBjb21taXQgbG9nIHRoYXQgaXQncyBpbmNvbXBsZXRlLg0KVGhpcyBmaXggaXMgc2VsZi1jb250
YWluZWQuIEkgZG9u4oCZdCBzZWUgbWVudGlvbmluZyBhYm91dCBvdGhlciBidWdzIGluIHRoaXMg
Y29tbWl0IGxvZy4NCkJ1dCBzdXJlIHllcywgSSB3aWxsIG1lbnRpb25lZCBpbiB0aGUgY292ZXIg
bGV0dGVyIHRoYXQgbW9yZSBpbXByb3ZlbWVudHMgd2lsbCBiZSBkb25lIHN1YnNlcXVlbnRseS4N
ClRoYW5rcy4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
