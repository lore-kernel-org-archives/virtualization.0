Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BDC12002
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 05:44:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE566117A
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 05:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE566117A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71A21836AE;
	Mon, 19 Jul 2021 05:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AHeGlC2gmXSK; Mon, 19 Jul 2021 05:44:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 07EA4835E4;
	Mon, 19 Jul 2021 05:44:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD215C0010;
	Mon, 19 Jul 2021 05:44:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40976C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F1116069F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:44:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id chPNv53bSdH6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:44:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F56060685
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmV8ghl3et3iGGzq90PYleMwkw5WguM6gAheKINGZqMFB/IZMMOonpCqEs2q20Bl0adO7PNoI4HyRDvKtfV6BHljX4pSe3HR8ObUQ6FlV2RmzEiedlGLcwdSnVayIz31G11vgv/cCPpppswn113oXwaijtp8oVj3rfYxH2QX67JUaVnpFOLlCIwva9Gopnq+WZu5xOeY/SlfAWFevkbdmms7oNRypuIwNnZcuX4HbW9Dgbcqy85s2WTHzKt+q2ESydX6fFp8cX4vyVgmTds+LJt0z5nqD1XOS8Sk5YcniWfi5p8PuTAkLtMG5KcO8758McF7OXIQO99BCh9hdG6PbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBTcxCXTENb3NXIGYrYMp+vT2m7LUVCYTvet+pFOHkQ=;
 b=Fe1CtAT7tGM4PHZdnNSp/kOKPNhcM6PIGIcwugg19ePBfVo9h5oslZr45ojHseWfr800Piwxi8IO7Ola2gurZoNnjPp6pbYGMAlNpEPHZ0ioRwlwusC0369cT0ZCf1mgISVwqdcuxwttepnAkih8Sr2aqxMM8FJQKcXdMxkWGb52wD7ftx3Qi3Q6ofCrEUMGkkTUy7gF3gCRLVE5HOu0ojyUYGuwZw3DRtS6zaNjPs3JE85s5LddRjCknMpWCDIRfEZQ+LqMEtdwWv0SqdeGsUJIAX9HdJBBe8UnZjbplqOKZUQ+Ak/p0DcFliZxicRcpWp4GISNKcEIRs/VtU4YfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBTcxCXTENb3NXIGYrYMp+vT2m7LUVCYTvet+pFOHkQ=;
 b=RG+umXr2Akyhsy9ykOYzkazo8zGRn5zwnBJtFl1j/wxJZPCDDbaZCvbyWsLBEnWL/J4SgHy9CGeOydelKuMUo54teHlTTR1N3mcam1qm7wz3FI5WSJXgLqlx95Oa3XGhx9xIHuKdjj6nnbcGKse2YQi8b0N+XEfQlbCzYyj2jW+Y454ACp/rG6sohjyP2VPPVZmSsxvmEQ5qDr+2tAJyIoKks4fb52hHb7505o1a5+BMTXYUw3JSmhL4D1AKHO+U4SKWofAfJr+lJaL0xncnG53TaIw/tL7yW7PpcqahxybFAgyxfrUfOK/qYwAO5y4rTY9ErY37MwLPaW7b1SfIDg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 05:44:49 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 05:44:49 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH 4/4] virtio_pci: Support surprise removal of virtio pci
 device
Thread-Topic: [PATCH 4/4] virtio_pci: Support surprise removal of virtio pci
 device
Thread-Index: AQHXet9qXyqqP8cKqUKjOeX+GMx7yqtHo++AgAImpFA=
Date: Mon, 19 Jul 2021 05:44:49 +0000
Message-ID: <PH0PR12MB54813A3CA2397ACE87A1DAF6DCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-5-parav@nvidia.com>
 <20210717164152-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210717164152-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 699a48d8-9a23-4747-c125-08d94a78528e
x-ms-traffictypediagnostic: PH0PR12MB5500:
x-microsoft-antispam-prvs: <PH0PR12MB550055E08E5C869C38EF3042DCE19@PH0PR12MB5500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bc3F6lOCiwIyc7/VM9amZwcsyvjJzC0hBurybqZCnVOC5OJhkwJpEoJzj1C3z6bs4HPp4kSTcUmK5Khh0IFknxDg4AtU5q63dMUrdyTyLJg9NtF5K4FlhzLgicuZagqwW2RsZ3p3v1J1LcBDM5TLLsUDju1aW1st34P6HZYMIUxiIPw2+W4rtYPkWGrYiaFJtnIG97eWeqK6ECtVKYxGAFQ99KCUIA7Q7VeY4WyPdWljan3iZggYO/dGiUWSfBUC6vsPc71e7JuopC6xX4RhuhmoFIwTkxLBJvCn1uvq6YAP80Txzw6XO4CSgSWy0fkkoKAaD5Jj/EoI0E8xjp6n7daTFzsVN+bzdcRZQPHlUNBI+P0OH78puX8Vqk+d5UvYR23thjKkyB7sUJqVF9vMG2N8Jl1bsQ0fSd+9p+BaNkGY0WL5dRPLIX1D+wgZFy4kzbnQi9c2SRKmv8uOqYcSHoFwp8y11aomYFqTVFKr4qk5Wr+vaNjShWCf2+pA10tEmWnMJ8KFLuGQlDGh2VqIEbSEw0JXRK5xo9F3gVjUPiak0tm64uFu+slhQMTL/7/THP/IjvC/+2cApB4PnSeN+CZBukIZ3hn9YQO+fWVEm5FglFWefv5rJkO8ysCyoE8uRzk6T1nSQUf0TzFktpgsIYUdEKbYv4nBEqMiOlrv891QtQfAGEzAXDmQ2SCRh5Jz2Oi3mkLVUYPr853431lvfQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(26005)(66446008)(55236004)(64756008)(186003)(2906002)(86362001)(6506007)(6916009)(66946007)(66476007)(66556008)(316002)(8936002)(71200400001)(5660300002)(76116006)(4326008)(83380400001)(478600001)(122000001)(7696005)(38100700002)(8676002)(52536014)(33656002)(55016002)(9686003)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUxGUnlabkNuQytSWndJY3ppYjZCWHJNMGgxM29VbmtIY3BiTU5tM0NyTXF1?=
 =?utf-8?B?dHB2UkRsNUl1NWx2U3FGSGQwWHZDN2NLYVdTZVU4MzRvNURIMm41WEgwOXZo?=
 =?utf-8?B?SEUzYkdZdVNvTEpNdlNsV0owUm9zZ3ZjWmhFVVd3VlRUWHVWOHUzOEpBcXhr?=
 =?utf-8?B?MVJzYTgzVng3enZoNDdYTEVtWFlDbW5paFVFQmQ5ekZQYTkvcUZMYkg1T3NU?=
 =?utf-8?B?QmxqNVBNaURiUDdLRTEzRitlSlhYZ3lsZjFXMXFBeTV3bnRCTTNFTnJhcU5a?=
 =?utf-8?B?VUhETTV4YzJKMmU4Sk9RS21MdFBOWnZ5alBMd05rRFk5S1RwaXhoeUVPRTRx?=
 =?utf-8?B?NDJub3RNNWMrQTNDZWZCOXB3MjlMOFo5cVVHQ3lRMXBzWmZIYlNlVHdLOUFl?=
 =?utf-8?B?NGxzMTJDcXhDWnBleGZNOHl4cG1FMjRyS1daeVdiVjY2a3VOTmZaVVJEUnVR?=
 =?utf-8?B?UUs5OUlybDFSbHBUcWdVbmJ2VHhRTlk0Q2dRM2N6NWg1RUgreGFUMUJadXhS?=
 =?utf-8?B?ZUhrUk1abEtxUWg4aGlFWXZieGovY21obTlUcGZ6UDZCcGpwUTBEVERBdnBL?=
 =?utf-8?B?L1Z6N3o5dEVXOFROSkxjRzl2MXg1WG9SL3phVFk3ZmxPbjV1TEJ1YUVmaWEx?=
 =?utf-8?B?bk14Z1ZIdzhrd0phMlF2REdqQkpuVUo2bUxzQXhicWU4TXB6SHByV3JVWVY4?=
 =?utf-8?B?UytFU2pBZUxjeWJ0a0taM25hV1RBV25sTUYrVU9YYUdsNkJUZVBKMFRjZnlp?=
 =?utf-8?B?bVlndXBVdE91dDB0eXBLS3phU0o5bzVZVWFiZ2NCSXNsRzF1Q1AvMHFxL21Q?=
 =?utf-8?B?RDQxMDZXV0tXVXpVcnhnVzNyem5RWnIvUUJ1akszUTBvbGR3bUpwZUQwbVN1?=
 =?utf-8?B?Y2tEQy8relJrbEdVS09aU0lVK1dHWlptMk51dFord0JocXpaeWQ0aUNwRFk1?=
 =?utf-8?B?dzBWYm5waUxVYjVvdGZuNmtYd2E4eDluYUpheHVtcFAxMXNSc3BNUXZ5NWRl?=
 =?utf-8?B?TFpyYzFBS0JzZ2RzNVVPa2x0TmRPUEJXZEUzWld3RlVWQmphNEJMbGxPUms5?=
 =?utf-8?B?RVgrQUF1U1RLRGJWVGgwbXowVklEVWpTb203a1dtVG1JM2l5SDlUU1E0c1V0?=
 =?utf-8?B?Y3hWYjl2QjRDZ1VhR1ZmYlRlVzVldERFaktJazEyVE5MOU1jYVlzUDRYZXBP?=
 =?utf-8?B?NkpVK2dGcElTS3M4R2hWNENMUS9qUU14QjhYNFFqQXBLdGh3ZVBmcEt3V3pU?=
 =?utf-8?B?NmNPQjRnNUdtNERDWDZteDgzU1I4SXMwV2pOMmt2WVN4dFdkaXJ1Z1J1WHUw?=
 =?utf-8?B?UFZ3NXFicHNBNkEweFRQaVdNa2ZFZkk2c21ZUXE0dGVFY1lYRlNTdzhBMFd1?=
 =?utf-8?B?SVkzUWtuUDdoM0p2R2lUVE96cm5ZREtnNXB4WittNERXTlVFM2N4OEFQQjZH?=
 =?utf-8?B?OUtxdjIxNHUrejZPR3lSc01sd3BhSk41WWRXOENyQkVJeGp5SlFjYVgydkNL?=
 =?utf-8?B?MnZ0cGMwUVEyOUoyT09pTCs1dkhGVysvZmhtM3c5QnRqTlFmZWg5YU51Vzk1?=
 =?utf-8?B?V0xJU1Z5SXBISi9xbzcvNWRSYndncGhHQWRxYWlydXZDVFh1MzBTWi8zL1Fs?=
 =?utf-8?B?dVB1Mlg2SStVVm51NlJ5MVJTZkRPZHRPR0dOQmZJdzMwYUhqRHQ5YUpKZXcz?=
 =?utf-8?B?VXA4VEd4QlZKd3REM0xnWHhHTHhyekVxNzYwZms5bkxZaHFqTEwwM0hJR1ow?=
 =?utf-8?Q?TsZ6Ue2tQmPoE7+ZhDjN585TZvk14nfAJNgVWGw?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699a48d8-9a23-4747-c125-08d94a78528e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 05:44:49.0606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHVv5H0wSJpN7qrYQ3Qo2qRkQ1r2lV8W5f4uC2UGrNVBkTtmiankAAzi0llUHqOecU2fDTHPt1BLgU5JqFkVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
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
U3VuZGF5LCBKdWx5IDE4LCAyMDIxIDI6MTcgQU0NCj4gDQo+IE9uIFNhdCwgSnVsIDE3LCAyMDIx
IGF0IDEwOjQyOjU4QU0gKzAzMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPiBXaGVuIGEgdmly
dGlvIHBjaSBkZXZpY2UgdW5kZXJnbyBzdXJwcmlzZSByZW1vdmFsIChha2EgYXN5bmMgcmVtb3Zh
bG4NCj4gPiBpbg0KPiANCj4gdHlwbw0KRml4aW5nIGl0LiBDaGVja3BhdGNoLnBsIGFuZCBjb2Rl
c3BlbGwsIGJvdGggZGlkbid0IGNhdGNoIGl0LiDwn5iKDQoNCj4gDQo+IE9LIHRoYXQncyBuaWNl
LCBidXQgSSBzdXNwZWN0IHRoaXMgaXMgbm90IGVub3VnaC4NCj4gRm9yIGV4YW1wbGUgd2UgbmVl
ZCB0byBhbHNvIGZpeCB1cCBhbGwgY29uZmlnIHNwYWNlIHJlYWRzIHRvIGhhbmRsZSBhbGwtb25l
cw0KPiBwYXR0ZXJucyBzcGVjaWFsbHkuDQo+IA0KPiBFLmcuDQo+IA0KPiAgICAgICAgIC8qIEFm
dGVyIHdyaXRpbmcgMCB0byBkZXZpY2Vfc3RhdHVzLCB0aGUgZHJpdmVyIE1VU1Qgd2FpdCBmb3Ig
YSByZWFkIG9mDQo+ICAgICAgICAgICogZGV2aWNlX3N0YXR1cyB0byByZXR1cm4gMCBiZWZvcmUg
cmVpbml0aWFsaXppbmcgdGhlIGRldmljZS4NCj4gICAgICAgICAgKiBUaGlzIHdpbGwgZmx1c2gg
b3V0IHRoZSBzdGF0dXMgd3JpdGUsIGFuZCBmbHVzaCBpbiBkZXZpY2Ugd3JpdGVzLA0KPiAgICAg
ICAgICAqIGluY2x1ZGluZyBNU0ktWCBpbnRlcnJ1cHRzLCBpZiBhbnkuDQo+ICAgICAgICAgICov
DQo+ICAgICAgICAgd2hpbGUgKHZwX21vZGVybl9nZXRfc3RhdHVzKG1kZXYpKQ0KPiAgICAgICAg
ICAgICAgICAgbXNsZWVwKDEpOw0KPiANCj4gbG90cyBvZiBjb2RlIGluIGRyaXZlcnMgbmVlZHMg
dG8gYmUgZml4ZWQgdG9vLg0KQWJvdmUgb25lIHBhcnRpY3VsYXJseSBrbm93biB0byB1cyBpbiB0
aGUgaG90IHBsdWcgYXJlYS4NCkFib3ZlIGZpeCBpcyBuZWVkZWQgdG8gY2xvc2UgdGhlIHJhY2Ug
b2YgaG90IHBsdWcgYW5kIHVucGx1ZyBoYXBwZW5pbmcgaW4gcGFyYWxsZWwsIHdoaWNoIGlzIG9j
Y3VycmluZyB0b2RheSwgYnV0IGxlc3MgY29tbW9uLg0KSXQgaXMgaW4gbXkgdG9kbyBsaXN0IHRv
IGZpeCBpdC4NCldpbGwgdGFrZSBjYXJlIG9mIGl0IGluIG5lYXIgZnV0dXJlIGluIG90aGVyIHNl
cmllcy4NCg0KPiANCj4gSSBndWVzcyB3ZSBuZWVkIHRvIGFubm90YXRlIGRyaXZlcnMgc29tZWhv
dyB0byBtYXJrIHVwIHdoZXRoZXIgdGhleQ0KPiBzdXBwb3J0IHN1cnByaXNlIHJlbW92YWw/IEFu
ZCBtYXliZSBmaW5kIGEgd2F5IHRvIGxldCBob3N0IGtub3c/DQpXaGF0IGlzIHRoZSBiZW5lZml0
IG9mIGl0PyBXaG8gY2FuIG1ha2UgdXNlIG9mIHRoYXQgaW5mb3JtYXRpb24/DQoNCkluIHZpcnRp
byBwY2kgY2FzZSwgaXQgaXMgc2ltaWxhciBpbXByb3ZlbWVudCB0byB3aGF0IG52bWUgcGNpIGRy
aXZlciB3ZW50IHRocm91Z2ggZmV3IHllYXJzIGJhY2sgdG8gc3VwcG9ydCBob3QgcGx1Zy91bnBs
dWcuDQpMZXRzIGNvbXBsZXRlIHRoaXMgb2YgZml4ZXMgdG8gbWFrZSBpdCBsaXR0bGUgbW9yZSBy
b2J1c3QgbGlrZSBudm1lLg0KDQo+IA0KPiANCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfY29tbW9uLmMNCj4gPiBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9u
LmMNCj4gPiBpbmRleCAyMjJkNjMwYzQxZmMuLmIzNWJiMmQ1N2Y2MiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jDQo+ID4gKysrIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYw0KPiA+IEBAIC01NzYsNiArNTc2LDEzIEBAIHN0YXRp
YyB2b2lkIHZpcnRpb19wY2lfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2DQo+ICpwY2lfZGV2KQ0KPiA+
ICAJc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2cF9kZXYgPSBwY2lfZ2V0X2RydmRhdGEocGNp
X2Rldik7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBnZXRfZGV2aWNlKCZ2cF9kZXYtPnZk
ZXYuZGV2KTsNCj4gPg0KPiA+ICsJLyoNCj4gPiArCSAqIERldmljZSBpcyBtYXJrZWQgYnJva2Vu
IG9uIHN1cnByaXNlIHJlbW92YWwgc28gdGhhdCB2aXJ0aW8gdXBwZXINCj4gPiArCSAqIGxheWVy
cyBjYW4gYWJvcnQgYW55IG9uZ29pbmcgb3BlcmF0aW9uLg0KPiA+ICsJICovDQo+ID4gKwlpZiAo
IXBjaV9kZXZpY2VfaXNfcHJlc2VudChwY2lfZGV2KSkNCj4gPiArCQl2aXJ0aW9fYnJlYWtfZGV2
aWNlKCZ2cF9kZXYtPnZkZXYpOw0KPiA+ICsNCj4gPiAgCXBjaV9kaXNhYmxlX3NyaW92KHBjaV9k
ZXYpOw0KPiA+DQo+ID4gIAl1bnJlZ2lzdGVyX3ZpcnRpb19kZXZpY2UoJnZwX2Rldi0+dmRldik7
DQo+ID4gLS0NCj4gPiAyLjI3LjANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
