Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72413C4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 05:43:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C6B60F4B
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 05:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2C6B60F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FCCA40001;
	Mon,  9 Aug 2021 05:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bu_zLGy4TRBc; Mon,  9 Aug 2021 05:43:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5D09400BE;
	Mon,  9 Aug 2021 05:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B355AC0010;
	Mon,  9 Aug 2021 05:43:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BEE4C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 05:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13BD8400BE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 05:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VvjH77IkkMVO
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 05:43:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A04F140001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 05:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnZMNrZWEAoITrVUtVVexrxH8ZpR0Q8wVLKdDuABMxuDC/9IyZpnIOqcMZY3OuybZH79VpTNbApkpIy0QgdFf74zxBCrwh1nqzPPNR9XJbg3BRGDAvUTeNru1WnQ668/IzoDtZesZaiCnFG1C6K2YF/Gs2gdANDu2ek00O55HcwHQk6Gopy+fkRYIw8DM+Y0cBx275+eEf0rnpTAMPlfwKuL9JTObLSg3y9n4I46pOVp8m45VZjZ9zuXDabdszarfGn1NTwSD8dQV3CeAmC3+MEWobsC821u1MjAEPjf5PIkbbRiKL+Sbg5tzfkBe85LV0L0uLJ9w84OZxdGlVTLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8LYq1feQzMBhwQT91z0grM/ZTz+IlYbetiPJWUYAfA=;
 b=CmFkbp2V613r5R+puC4omL7sBV/eOUrvyHyWVCYxd/N0cbll8WQPmYmhXUXx85QonE67zwMEmI5/4VDfgsM4ppcg5+h8b0HnG0SvcLmiTqcCxafBBdxnw8IbFv3mNWJIrkFw43l5gA+fOPCScVXbd5ibxoq+3jSQsWkftffHFtiIOdVkgnSTrBjoXm10TGAKDwSG3XHaWUUJghePqc1MDRMm04w7jl+0RxvNW3LQjrgyXQTuCkf55TToPCW+yv60UXYTIAin7zM1BL9yMgvQRdL8q64NaTsTJmpXRmtbWOZdL6v54dHKXyvFCru8X2tofQwwe9+V/q8FZB2IlsBmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8LYq1feQzMBhwQT91z0grM/ZTz+IlYbetiPJWUYAfA=;
 b=IOjjlSMEZcA0XkFXVQGjJTspSOtNy1aGGVxPU/8V77dpGtksZkteRvoZAU1YmfJ809Tw5mlOzyObkrA+142/+gySbYSqdRhFqNlaGcbVgEI2CGQox9fX6tYDP+lei0rxengvWBy/GkBKgY0pFi8W6+m+AMr3pezOc8U7AfiQedQQ9RIier1jPOauLVn9Ix3OeYM7gAf1vBEd52b9pBX3Zz0Ye0NYqaISTuFt4YiPibU4QCjB3ClMZG3hKc4C9TE7zkdHkA3fxq1P7S/R7T04w3vW4hOaYhSJ9yX6OTSO2/5EjlXdDeFRtJdizy1y99tQJitEv8TSaFdiw75s8f+eKQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Mon, 9 Aug
 2021 05:42:58 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 05:42:58 +0000
To: Eli Cohen <elic@nvidia.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAEa9oCAAGJZgIAAALAggARY0QCAACVNgIAABSwg
Date: Mon, 9 Aug 2021 05:42:58 +0000
Message-ID: <PH0PR12MB5481F74DCC09018C476D7262DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <be8a0173-b7fb-eabf-bc4a-9492133674ef@redhat.com>
 <20210809052121.GA209158@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210809052121.GA209158@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 890e084f-50ab-4b1d-a4ab-08d95af88b67
x-ms-traffictypediagnostic: PH0PR12MB5483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5483CB421E44DA569CEC52EDDCF69@PH0PR12MB5483.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUCzsNXZH1ba3aCupQaDBjzlckmiU2Dm/5iAsVkNSq5ksJpn2OctNmVLJLnnV4VJ+KzvR/+W8q65otZIfd/O6NmOSQlTaUQIpqeCC0G35ox9vdutivLYH55KRRRC+0pquaEEC/pW6fDfeWw68P73STXLljgdGekZMvukX+CKQLVsEffPoMzkdEDIiiKfHueBez9gXRsvntwugPBAVULH2NpsL3GgXZCqr/JZLzlS0h1+HoU0yH7ay2FqW2F7EvmkJ3PI+U+BizqS3hgv07wFmYAaZy2i+mA7ap/me/yty2fAHyAN3l34QwpItWAM6dYnjRnqJ15fuh5kNzHizv6Eu6Y5unyuwoag3H6BRPM0gBLE2qufQiIWSTBZu1Dn7AZuTPou88SKK+/RaXZaHEG30cRHjSL8I0rfjnJnOdh3o7QQ26NloYbMHZp1/2J1ILsI5jrzre5Jq81Y/6zmy4DmLTP/cfCVso00HY8AbyZuq8WZ4T6icyON8WsYTvf2gR34PXnDoD+zObC5uko+u5OjpmewrCkxyTysZ8ABqxaVk2WAgq81aYTbwMdkO8yul0aduFGNXfvl4KWo0uCl4GMTLOpvhcLmA7/4Nnxg1Vp6pEsojiW+rhzVjGKbuFI1GlhZKLla1uuLYPw8mnNxXyn03OPrwIF6G9Ey4FilpxZdunmJpwPIMWRv6Qwf/Tc1PLC9EXYtI1lFkkJQRU5BnJpEVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(38100700002)(2906002)(66556008)(7696005)(86362001)(66476007)(8936002)(66946007)(55236004)(83380400001)(8676002)(6506007)(33656002)(76116006)(64756008)(66446008)(122000001)(110136005)(316002)(26005)(186003)(55016002)(71200400001)(5660300002)(4326008)(54906003)(38070700005)(478600001)(52536014)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE1SZTgvZmpKWTdxU0ZVanJoVnJ2Z2RpQktIM1ZENFdkOTRTRlpxRWtkbHdt?=
 =?utf-8?B?L0dpKzFCaFdOM3ZINW5hS1ZIYitlTEtBMyswbUxnN2p5OHh1L2JobjhwN1Bj?=
 =?utf-8?B?NXBadEN2eHRTQ1d3ejU1RGV2U1NnMlhCWi9WbnVidXFCMktINTh6NU1peTBM?=
 =?utf-8?B?eWYzVG5Mb1pZSC9aRUpaY3QwbEJxSWFTZk5tR0VNMy9NR005WUlPdTZLNW5s?=
 =?utf-8?B?a0pPWkZVOE9vR3BEWTMraEpCeUJhR2ducFQwN0pSWm4zdUQ1YWJsUTM4M0pR?=
 =?utf-8?B?Tit6RzVObEFpOWlMU1hjdmxkWm5oQ09WSVBVMmNqYW9nQnIwMERFMGt6djY2?=
 =?utf-8?B?bk9aZVIvanM3V0pkZy8rM0hnMllrWWZqYk56aXVkTVMrMmJ4NTRGSi9xdCtv?=
 =?utf-8?B?VEVwcnlqb0I4eS9aOFNia1dhY1BCY1NGNkZiWUJEYmQvQlp6SXgwb2EydHVQ?=
 =?utf-8?B?UTdSS0YyQXVEaWN3OGVGczRuQXBZTmQ1QWNqWEdjUEo2eVh5WXB4ZzRQK1A3?=
 =?utf-8?B?a21PSWFTUVhocktkMXVFMGRQOXhjcUx0NmpmZmZDUlFFNEwrN1ZheU5DVC9M?=
 =?utf-8?B?bWo3eDBZSlZhVUJoakgrM0t6Qmt2L0huRXBXWHFIY0F4OWs5RjVaY3VRamgy?=
 =?utf-8?B?LzBsa2MxU1F0VHJteDJmZmhaM2I4VFZva1NJU2dnV0ZMVDM5SUdicDJ0dnRG?=
 =?utf-8?B?enhjdHFVT1JGQ1ZIQnhBTm1sV0wwaHpHTWxrNm5iMWx3THUzeU11ZVdpNEJx?=
 =?utf-8?B?cDMrWlpoU2M3UVMwUXdjL0dkdWU0blNIcWVoKzE2YzR4TzI2QlRDbnJVRFh4?=
 =?utf-8?B?Sy9MUzI2SGZ2eDNaYVhVT05QcUI4OXFNemVyeXBzcjdtbndiN25ZejVmZ25r?=
 =?utf-8?B?RXZBRUxmemdLbW9FRzJOZkVPTUhSUFUxNGlEZ2RvZ3lpZ2tvekVZSzB6TTZm?=
 =?utf-8?B?YzJMdHFRVGN2OFY4S2lBMHhnZ29tdC9lUktDWlVUOEJ6UVdpVDlVQVJxaHhY?=
 =?utf-8?B?NkhiOW4vK2JVUzdmaWtwT0RIb0Z2L2dyWDkrY0dhUC80cUk1eHNwQ3N1YWgy?=
 =?utf-8?B?RWRCbW9SK1VlSXlabGhoNkxwMDFnTWpyS1d4QTVCTHJMd1BmNi9QNXNURG0v?=
 =?utf-8?B?Ykp0SXc4OHBTMXJOQThNQUN4WXNNekcyK3BmVnB1T1N1dHRZNGUxK0xYemsv?=
 =?utf-8?B?WVp5VW83eTJkYko4WFBxOE5saFVDODMwRld3aW9MUlRiSy95SHdUaFYwLzRO?=
 =?utf-8?B?M1J1czBzYW9RbkV1dXN6TWcwZWdhTitteTRycjB4OU5zUW5Rb0RCNW02THFM?=
 =?utf-8?B?MWNKY2xtbmhNcXBaK2ZITHNSQWdwZU9QTWVzNjJIRS9sWndqcVdQOHFwVnlE?=
 =?utf-8?B?REVzYnlTRnlZVDR6OU5VRUR3TWVaK29hTWRjbnR6K25yck43UzVjWVRFdGdW?=
 =?utf-8?B?UENwQTNqWmpuQ0Rwa2oycXZrWXFnUnJLUDEwSEZoT2FDK2l1N3BvM0tXVGNU?=
 =?utf-8?B?ZStIb0JKVFpCdmZqd3dHRlI3YWRRSVF0dXo0c251SjRDb24ydmJWRjNoWlZj?=
 =?utf-8?B?TGFWcVByN3lWbnpoR3JvT3RFZlo2OFN1eHNraC9EcC9qbzBIWVFmSWxQQy9n?=
 =?utf-8?B?bkhobjBDVjMyQkRHQ3RoSXVkbDN1M01NT2JuR2MyZThkSkF3YnY1enBwY3hM?=
 =?utf-8?B?SmJSc3lzQXJnSHJOVXhjTHQ4c2ttSVRXZWhTQ3hXTWNkeHN3bzBzRHIwYVRL?=
 =?utf-8?Q?MkrjVJrgY9J0czmGWs96af6vhiFNPrPGxn8Ar4a?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890e084f-50ab-4b1d-a4ab-08d95af88b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 05:42:58.4839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uej/rH2py79LTR8bFSdTHdURyUpQh5Qn+UpT+id/pW9rx7SpIsIpxLqg+Fwmw9WJccs1QHFnCvBZT1qSEAAAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

DQoNCj4gRnJvbTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRheSwg
QXVndXN0IDksIDIwMjEgMTA6NTEgQU0NCj4gDQo+IE9uIE1vbiwgQXVnIDA5LCAyMDIxIGF0IDEx
OjA3OjUwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6DQo+ID4NCj4gPiDlnKggMjAyMS84LzYg
5LiL5Y2INDo1NSwgUGFyYXYgUGFuZGl0IOWGmemBkzoNCj4gPiA+DQo+ID4gPiA+IEZyb206IE1p
Y2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+ID4gPiA+IFNlbnQ6IEZyaWRheSwg
QXVndXN0IDYsIDIwMjEgMjoxMiBQTQ0KPiA+ID4NCj4gPiA+ID4gPiAgIGVudW0gdmRwYV9hdHRy
IHsNCj4gPiA+ID4gPiBAQCAtMzMsNiArMzQsMTYgQEAgZW51bSB2ZHBhX2F0dHIgew0KPiA+ID4g
PiA+ICAgCVZEUEFfQVRUUl9ERVZfTUFYX1ZRUywJCQkvKiB1MzIgKi8NCj4gPiA+ID4gPiAgIAlW
RFBBX0FUVFJfREVWX01BWF9WUV9TSVpFLAkJLyogdTE2ICovDQo+ID4gPiA+ID4gKwlWRFBBX0FU
VFJfREVWX05FVF9DRkdfTUFDQUREUiwJCS8qDQo+IGJpbmFyeSAqLw0KPiA+ID4gPiA+ICsJVkRQ
QV9BVFRSX0RFVl9ORVRfU1RBVFVTLAkJLyogdTggKi8NCj4gPiA+ID4gPiArCVZEUEFfQVRUUl9E
RVZfTkVUX0NGR19NQVhfVlFQLAkJLyoNCj4gdTE2ICovDQo+ID4gPiA+ID4gKwlWRFBBX0FUVFJf
REVWX05FVF9DRkdfTVRVLAkJLyogdTE2ICovDQo+ID4gPiA+ID4gKwlWRFBBX0FUVFJfREVWX05F
VF9DRkdfU1BFRUQsCQkvKiB1MTYgKi8NCj4gPiA+ID4gPiArCVZEUEFfQVRUUl9ERVZfTkVUX0NG
R19EVVBMRVgsCQkvKiB1MTYgKi8NCj4gPiA+ID4gPiArCVZEUEFfQVRUUl9ERVZfTkVUX0NGR19S
U1NfTUFYX0tFWV9MRU4sCS8qIHU4DQo+ICovDQo+ID4gPiA+ID4gKwlWRFBBX0FUVFJfREVWX05F
VF9DRkdfUlNTX01BWF9JVF9MRU4sCS8qDQo+IHUxNiAqLw0KPiA+ID4gPiA+ICsJVkRQQV9BVFRS
X0RFVl9ORVRfQ0ZHX1JTU19IQVNIX1RZUEVTLAkvKg0KPiB1MzIgKi8NCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gICAJLyogbmV3IGF0dHJpYnV0ZXMgbXVzdCBiZSBhZGRlZCBhYm92ZSBoZXJlICov
DQo+ID4gPiA+ID4gICAJVkRQQV9BVFRSX01BWCwNCj4gPiA+ID4gPiAgIH07DQo+ID4gPiA+IFRo
ZSBwb2ludCBpcyB0byB0cnkgYW5kIG5vdCByZWludmVudCBhIGRlZGljYXRlZCB2cGRhIGludGVy
ZmFjZQ0KPiA+ID4gPiB3aGVyZSBhIGdlbmVyaWMgb25lIGV4aXRzLg0KPiA+ID4gPiBFLmcuIGZv
ciBwaHkgdGhpbmdzIHN1Y2ggYXMgbWFjIHNwZWVkIGV0YywgSSB0aGluayBtb3N0IHBlb3BsZSBh
cmUNCj4gPiA+ID4gdXNpbmcgZXRodG9vbCB0aGluZ3MgcmlnaHQ/DQo+ID4gPiBBcyB5b3Uga25v
dyB2ZHBhIGlzIHRoZSBiYWNrZW5kIGRldmljZSBmb3IgdGhlIGZyb250LWVuZCBuZXRkZXZpY2UN
Cj4gYWNjZXNzZWQgYnkgdGhlIGV0aHRvb2wuDQo+ID4gPiB2ZHBhIG1hbmFnZW1lbnQgdG9vbCBo
ZXJlIGlzIGNvbXBvc2luZyB0aGUgdmRwYSBkZXZpY2UuDQo+ID4gPg0KPiA+ID4gRm9yIGV4YW1w
bGUgY3JlYXRvciAoaHlwZXJ2aXNvcikgb2YgdGhlIHZkcGEgZGV2aWNlcyBrbm93cyB0aGF0IGEN
Cj4gPiA+IGd1ZXN0IFZNIGlzIGdpdmVuIDQgdmNwdXMsIFNvIGh5cGVydmlzb3IgY3JlYXRlcyBh
IHZkcGEgZGV2aWNlcyB3aXRoDQo+ID4gPiBjb25maWcgc3BhY2UgbGF5b3V0IGFzLCBtYXhfdmly
dHF1ZXVlX3BhaXJzID0gNC4NCj4gPiA+IEFuZCB0aGUgTUFDIGFkZHJlc3MgY2hvc2VuIGJ5IGh5
cGVydmlzb3IgaW4gbWFjWzZdLg0KPiA+ID4NCj4gPiA+IEd1ZXN0IFZNIGV0aHRvb2wgY2FuIHN0
aWxsIGNob3NlIHRvIHVzZSBsZXNzIG51bWJlciBvZiBjaGFubmVscy4NCj4gPiA+DQo+ID4gPiBU
eXBpY2FsbHksDQo+ID4gPiBldGh0b29sIGlzIGZvciBndWVzdCBWTS4NCj4gPiA+IHZkcGEgZGV2
aWNlIGlzIGluIGh5cGV2aXNvci4NCj4gPiA+DQo+ID4gPiBIb3cgY2FuIGh5cGVydmlzb3IgY29t
cG9zZSBhIHZkcGEgZGV2aWNlIHdpdGhvdXQgYW55IHRvb2w/DQo+ID4gPiBIb3cgY2FuIGl0IHRl
bGwgZXRodG9vbCwgd2hhdCBpcyBzdXBwb3J0ZWQgYW5kIHdoYXQgYXJlIHRoZSBkZWZhdWx0cz8N
Cj4gPg0KPiA+DQo+ID4gUmVyZWFkIHRoZSBjb3ZlciBsZXR0ZXI6DQo+ID4NCj4gPiAiDQo+ID4N
Cj4gPiBUaGlzIHBhdGNoc2V0IGVuYWJsZXMgdXNlcnMgdG8gc2V0IHRoZSBtYWMgYWRkcmVzcyBh
bmQgbXR1IG9mIHRoZSB2ZHBhDQo+ID4gZGV2aWNlIG9uY2UgdGhlIGRldmljZSBpcyBjcmVhdGVk
Lg0KPiA+DQo+ID4gIg0KPiA+DQo+ID4gSXQgbG9va3MgdG8gbWUgdGhlIG1lY2hhbmlzbSB0aGF0
IGludHJvZHVjZWQgaW4gdGhlIHNlcmllcyBpcyBub3QgZm9yDQo+ID4gcHJvdmlzaW9uaW5nIGJ1
dCBmb3IgcG9zdC1jcmVhdGlvbiBjb25maWd1cmF0aW9uPw0KPiA+DQo+IA0KPiBUaGUgZGlmZmVy
ZW5jZSBpcyBzdWJ0bGUuIEluIGJvdGggY2FzZXMgeW91IHByb3ZpZGUgY29uZmlndXJhdGlvbi4N
Cj4gDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gSSBtdXN0IGJlIG1pc3VuZGVyc3RhbmRpbmcgeW91
ciBjb21tZW50IGFib3V0IGV0aHRvb2wuDQo+ID4gPiBDYW4geW91IHBsZWFzZSBleHBsYWluPw0K
PiA+DQo+ID4NCj4gPiBJIGd1ZXNzIHRoZSBtZWFuaW5nIGlzIHRoYXQsIGlmIHRoZSB2RFBBIGlz
IGFzc2lnbmVkIHRvIGd1ZXN0LCBpdCdzDQo+ID4gdGhlIGNoYXJnZSBvZiBndWVzdCB0byBjb25m
aWd1cmUgdGhlIE1UVS9NQUMvUlNTIHZpYSB0aGUgZXhpc3RpbmcNCj4gPiBtYW5hZ2VtZW50IGlu
dGVyZmFjZSBsaWtlIGV0aHRvb2wvaXByb3V0ZTIgbmV0bGluayBwcm90b2NvbC4gVGhlDQo+ID4g
Y29udHJvbCB2aXJ0cXVldWUgaXMgZGVzaWduZWQgZm9yIHRoaXMuDQo+ID4NCj4gDQo+IEkgd2Fz
IHVuZGVyIHRoZSBpbXByZXNzaW9uIHRoYXQgd2Ugd2FudCBzb21laG93IHRvIGNvbnRyb2wgdGhl
IGNhcGFibGl0eSBpZg0KPiB0aGUgZ3Vlc3QgdG8gdXNlIGFyYml0cmFyeSBNQUMgYWRkcmVzc2Vz
Lg0KPiBJZiB0aGlzIGlzIGlzIG5vdCByZXF1aXJlZCB0aGFuIEkgdGhpbmsgY29udHJvbCBWUSBp
cyB0aGUgbWVjaGFuaXNtIHRvIHVzZS4NCkhvdyBkb2VzIHRoZSBndWVzdCBWTSBpZGVudGlmeSB3
aGljaCB1bmlxdWUgbWFjIGFkZHJlc3MgdG8gc2V0IG9uIHRoaXMgdmlydGlvIG5ldCBkZXZpY2Ug
d2hlbiB0aGlzIGlzIHRoZSBvbmx5IGRldmljZSBpbiB0aGUgVk0/DQpVc3VhbGx5IGh5cGVydmlz
b3Iga25vd3Mgd2hhdCBtYWMgdG8gc2V0IGZvciBhIFZNLg0KDQpIb3cgZG8geW91IHNldCB1cCB0
aGUgY29uZmlnIHNwYWNlIG9mIHRoZSB2ZHBhIGRldmljZSBtaWdyYXRpbmcgZnJvbSBzb3VyY2Ug
dG8gZGVzdGluYXRpb24gaHlwZXJ2aXNvcj8NCklzIHRoaXMgZG9uZSB0aHJvdWdoIHFlbXUgdmhv
c3QgZnJhbWV3b3JrIHRvIHNldHVwIHRoZSBjb25maWcgc3BhY2U/DQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
