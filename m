Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FACDC4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 04:03:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0E560E09
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 04:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D0E560E09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A844404C2;
	Tue, 17 Aug 2021 04:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BjafV7QuELPx; Tue, 17 Aug 2021 04:03:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4BF66404C1;
	Tue, 17 Aug 2021 04:03:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F900C001A;
	Tue, 17 Aug 2021 04:03:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7E46C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8717835FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O0hXwvB4L49H
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:03:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8583D8102F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhFSQEnLX0lT6oUgKzM6USVMN9T8jDVWdoaEWGRe5fDM0bRU1LeNnvniDZ4aYLg7VbYU6bAHS2XVOLufZv3Fmk0eXFSpfYtkmt3gxcNgCEakCtXsuXvra99M+aQwpQyAQWp5qn1U4fwkaFYqIteRFEXYEeAn/sTndpRrzdP4DFMAc6xTXICH1KYspEhVp8+udPzVS2gJMgMhuY7LZmuuaKdYfrirUam1XtKnC7DZDLWif1m6UTrhe4LCegMewa3FyYzlazFM8ZAtXvCeAS07IPQpif+ayXGv3+OWv1lfQ5QNYc5giHKGsrup3f82QE7GC2HHiX5myfn1ewbSfCUhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=452gD2DwsU9VSbKXfHtVBrRkNkMMCf4LQ62ugjkVZR0=;
 b=UCnpoQhM5nPCQJFvceNv3r1pqUCbH2J9vl6ybIptiOw0iH4C+hhl8XjKyNw3EudEWOyhOdn0YHHYlmaWbwATkE9DtFioIrOBH5c3k00W1tMbrngn6XwdAOCQ2vUi5jW+FixiLWS7WKw1DQlwBGjSIW74FprCZjfyAOsbYXvfEKHn7+LkWDFsQGZC7TXe8DamNRbeAPwaHQ1ulr/Ycb2Ve+vt5quuKVlM15MUnePfT/EHn1gXxh7oLHXH+Xo5+PlXygtVtcPX8U8tQR6Wc3oQVBywYz5ANCeCmnlujcQVX4NXhLByrXaKMivTepTA+7LM7TqKD04jepV5nD4r62Cfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=452gD2DwsU9VSbKXfHtVBrRkNkMMCf4LQ62ugjkVZR0=;
 b=eOUIrHZEYxcRzQ0G5nokfIGbCPfgOd0VFnviBKsAFxM5g5u+w8xAEZgnp4WCrwbVlgX9+EqFpJECztL1vyBH3IpJW0hDbiw0ci89CZo+18sYVtenIUS+dgHYyy0+02+Q1W8rkGVCJbO7n3WG7cTWBWCb7U2Jtcc7iKCZ05dB0ZXwdb79ElMvaRsgeSvk8WZfLTGVnd+P+diRHPS9a37i/KnXesoTzud2b6cc5UXP5nUTWMt8xIoi+LW6OXz16Q66PjrcuXpM6qlGCu30R5NH1Ud7z8B1/epreArzO/OgqJhP0aSmi+zZiz50Rc54cxCNIeKW3d6dtMTSEYOQYKZLLw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 04:03:15 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 04:03:15 +0000
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
Thread-Topic: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
Thread-Index: AQHXjSf/zh/XAFr59kGudCv/3ZyFhatsKNwAgAHI24CAAAxIAIAAKN+AgAEQfoCAABrmgIAAHygAgAAEH4CAAADEgIAALmGAgAXr6QCAABmTAIAAAuMAgAC4F4CAACysAIAAi18AgAAByyA=
Date: Tue, 17 Aug 2021 04:03:14 +0000
Message-ID: <PH0PR12MB5481B0AC416186D7B20FCB26DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
 <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
 <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
 <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
 <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
 <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
 <20210816054746.GA30532@mtl-vdi-166.wap.labs.mlnx>
 <3f26a849-d1a8-49e2-cb60-d58d7c4cbcd9@redhat.com>
 <20210816165659.GA51703@mtl-vdi-166.wap.labs.mlnx>
 <20210816153630-mutt-send-email-mst@kernel.org>
 <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
In-Reply-To: <CACGkMEvu9tUWPkYqLoDzJ0gR=5RMstMhcU+OkhFtHn7TB5Ki6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d25ae8e-fec0-4429-5a29-08d96133f037
x-ms-traffictypediagnostic: PH0PR12MB5498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5498AEFB01A7DD266E6A1706DCFE9@PH0PR12MB5498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /qGT6e5z32uHFVXTfJpSjAFKyPanc8B2AFXoMuIVD+nZAhlYvvsmlRr3E/p+Cr65sm192dxWRF0GTgK2r6tIxFvAunh2WnUoHSUzdlRCV5OflyVuOGpj64Tj8e8FRprAbrTB4ZU6JYqVhxDxjxNo6EIQsEiyWGa3uBlR4vkQUZ4PfFawUY6mfA8AQ+VvA5HbtTRh/hatz3XmK9F8+GjbW02tJf6luWrdH1NX2u5Yw3CNCuvWgUrdopLDEvvbhvm3PkyiG3Y7MkO06U/kvGuCkncM1ZJf9336jkZ2NezkYAuG81DoBJR3vPAjx3nzO3l0qKkNhmJZxKV4XdrOtl24Nlu+GLn+LOf8h6BnCCX8Z2POenApfwK+0JRXtdySAYPGfzQKhtcSLtwJrt0vjTfKoqPwSM/ZxEm3Vsq/eLMb6ezfdtqwI4QuAfRE/PynePhDNA8ZNSuZ6dQcrV39fzwqGCNeNq5qmKibxPfDYVPpH7pVGqPY74O2wrr4wfN1+uLxS9srP2nOhYEHScZThBOgK95Am2pk61Px2o6jbJcf+5B5Pf91N88MwfZoM+P1mGS1EfnGv26NvaiC2DakiKM/8oVZdPa1a5LNZn+sp0wKu3bRcUtX4r1b5GcEh/YKFj4KoYh5Wwy+XJUaUAPi4qGJfZmIKhbFEOvrUpsYR8qLU8sPuKpjSvB8SvmVxYnx1EhkEUoTz5OStJ+SldiudwB+Lg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(55236004)(9686003)(55016002)(54906003)(5660300002)(6506007)(71200400001)(52536014)(83380400001)(110136005)(53546011)(316002)(7696005)(33656002)(26005)(2906002)(66556008)(4326008)(38100700002)(122000001)(66476007)(66446008)(8676002)(186003)(66946007)(38070700005)(76116006)(86362001)(64756008)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVRlbU0xdk16TmIvSnV4VUw1T3prRmtubFFTOFpOcklxRXFLWit1em01N2ww?=
 =?utf-8?B?dlA2eGw5dnF1NWlDZ1FvUHhBSHhPWHRyYUY3ekg3eHl1ZlVBMmpLelJUMFla?=
 =?utf-8?B?QXFhN0srSm5XZFhSNytWNG5tMG9EZTkxb3kwWDFTSjZwK1R3U1ZJVnNlbkxS?=
 =?utf-8?B?eFpkVFBLWmJXMkExdE9La2tYTHFUWlJESHl2ejVPN3NhMEtNVko1SEpHeURm?=
 =?utf-8?B?eG1KY3NEQSs4cDNUcXFGaHRNblNLNjhvMEFNYW5zczVKOThoYzk3ZmVoMVFD?=
 =?utf-8?B?TFV4cUxCYW1jMUhrY2FNaHRaS3BraitaQkx6cEp4QUtSd3RYZG41VnFiTjlY?=
 =?utf-8?B?dUdGV24wK3ZmOWJzbWczdEp3djh4VERxeHBkVm4vbG1rRHdqb3djN2w3cUZB?=
 =?utf-8?B?UGVCQWlKS0tzWnRtNkNQc3hsazR2c2xoL04waktXYzhhZk1rdVY5NkNvSkd4?=
 =?utf-8?B?ak9XdHZQeTFaTnhqekdZT2FSMGo3UVdkeW5paVVmTzRIcG8zTlpObWJobkUz?=
 =?utf-8?B?RTQ1WmkrZ0txMEROUkxHZ0VEYlJHOTdpbHFNU0FkUER1SFFlNHE3UnVEMWhz?=
 =?utf-8?B?RThHVkJjOGVuY05aS1VQbDdSTnlIM296WUYrYTRNdW4rQ0d3VTdzMER0RzAy?=
 =?utf-8?B?YUxlcTdkYmlRUkJzZXhYell6ZExYZkZrd0xmSUlMMEJSN2FjQitSMHdHVFAx?=
 =?utf-8?B?V3pPY2VEeFFLTElIWFpIa3RWOEl6NGhNSDNjNzB1TXpzOVNLcVU1ekpWWHZY?=
 =?utf-8?B?TmtHc04yU0YvemFEVlZleFlsc3FaNUFsR01Ga3NEU0I3dmdQU1RaSXNuSG96?=
 =?utf-8?B?NzFmbzFkamZvYTlxeDVwalcrMnpROEpKd1NESU5RNWlRM2pEOWFHSFQ0SFg0?=
 =?utf-8?B?SlRFZGhYRlFiVEFtY0d0M1lpZzBEM3RPN0RQS0lRYnJqUWNhNWlzUjl5eGRM?=
 =?utf-8?B?TUdYanZZYlA3TFREem4xTHVOdmxZNWJnZG9FNHVsbkNjNFp3ZzJlRlk5YmZW?=
 =?utf-8?B?UldrYmlhOWhoTTUzbDh1akljb1FPUWFaZDQ3a1VXZ2hJSWhSNVN6b0w0TFlo?=
 =?utf-8?B?aFduL0hVeC9CU0s2RWhmRUFsTktlaVQzNWVkTEhCcHAzL2ZwSGdwYXh3WTRQ?=
 =?utf-8?B?aWI5cTZIc1d3aTFFbjdYRkQwVU1pUXJnTHhhOEt0a3pGSVhXdnltUlQ0bCtV?=
 =?utf-8?B?R3liU1FXWUdCQURsQkVGaEM4bERTalBIMFpxSUtlaDZXZUVFYVpDK0lhcno3?=
 =?utf-8?B?Qjd2Q2NuN3UzTUVZVHkzSEpmM2pTdGRvTmlkUDNVSVZkS1R4RHVQc3EySUtv?=
 =?utf-8?B?WW9PdmRDRU9FNnBpdEE4UUY1VG0zSzJVWmNYaHhrSzIyd21XdzBYNm5KUWtj?=
 =?utf-8?B?alpSVWJBUnhRbGZBMUQydnRwWHJkSlhpcnB5Q0p2YXNOcWh1NVdHMWVsdmJX?=
 =?utf-8?B?dVdyTzArLzUveXZ4VVd4UUg5ZTk4cmhxeGsrZUswQ1RLUlBzZkhzRVVQa3dX?=
 =?utf-8?B?VnVkbkNSOVJzSktzV015OThKemFjQ1Q5R2ZZY0NWcnE1NXBjYllNN3doUG5l?=
 =?utf-8?B?Mk0zQjdPNFAwVDZONHdHejBkNmR3S1M5NlNUWlFCWFV6NXN4bk9ib0xZa0lP?=
 =?utf-8?B?TTh4TGNROGlkVWtvbENHYkthS1YvSlI3K2drTmp3bTJlQytidDFkckcwb0lk?=
 =?utf-8?B?UHFseHdRaUlpY2pQYnlHS1hZWVM2emwySzZhNjZBWi9mWFZ4VUkvTFRrM1Z0?=
 =?utf-8?Q?Oi9Ia3MyHYIMcBrWm1sKLw4djcHSsOBK62ZhAeX?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d25ae8e-fec0-4429-5a29-08d96133f037
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 04:03:14.9806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6v+fD/hyPJG5yZMF6fYk7OtCWqjwYTaNAferCDmhpB5pSov8txp8vwvz6OYTtcLB+lsTPTHwKYjOaO9EfP1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
Cc: eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCAxNywgMjAyMSA5OjI2IEFNDQo+IA0KPiBPbiBUdWUsIEF1ZyAxNywgMjAyMSBh
dCAzOjM3IEFNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gT24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMDc6NTY6NTlQTSArMDMwMCwgRWxpIENv
aGVuIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBBdWcgMTYsIDIwMjEgYXQgMDE6NTg6MDZQTSArMDgw
MCwgSmFzb24gV2FuZyB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4g5ZyoIDIwMjEvOC8xNiDkuIvl
jYgxOjQ3LCBFbGkgQ29oZW4g5YaZ6YGTOg0KPiA+ID4gPiA+IE9uIE1vbiwgQXVnIDE2LCAyMDIx
IGF0IDEyOjE2OjE0UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiDlnKgg
MjAyMS84LzEyIOS4i+WNiDU6NTAsIEVsaSBDb2hlbiDlhpnpgZM6DQo+ID4gPiA+ID4gPiA+IE9u
IFRodSwgQXVnIDEyLCAyMDIxIGF0IDAzOjA0OjM1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
DQo+ID4gPiA+ID4gPiA+ID4g5ZyoIDIwMjEvOC8xMiDkuIvljYgzOjAxLCBFbGkgQ29oZW4g5YaZ
6YGTOg0KPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMDI6NDc6MDZQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gVGh1LCBB
dWcgMTIsIDIwMjEgYXQgMTI6NTUgUE0gRWxpIENvaGVuDQo+IDxlbGljQG52aWRpYS5jb20+IHdy
b3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFRodSwgQXVnIDEyLCAyMDIxIGF0IDExOjE5
OjE5QU0gKzA4MDAsIEphc29uIFdhbmcNCj4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiDlnKggMjAyMS84LzExIOS4i+WNiDc6MDQsIEVsaSBDb2hlbiDlhpnpgZM6DQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgQXVnIDExLCAyMDIxIGF0IDA0OjM3OjQ0UE0gKzA4MDAs
IEphc29uDQo+IFdhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g5ZyoIDIw
MjEvOC8xMSDkuIvljYgzOjUzLCBFbGkgQ29oZW4g5YaZ6YGTOg0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBPbmUgdGhpbmcgbmVlZCB0byBzb2x2ZSBmb3IgbXEgaXMgdGhhdCB0aGU6
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK3N0YXRpYyB1MTYg
Y3RybF92cV9pZHgoc3RydWN0DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK21s
eDVfdmRwYV9kZXYgKm12ZGV2KSB7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
KyAgICAgcmV0dXJuIDIgKg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICttbHg1
X3ZkcGFfbWF4X3FwcyhtdmRldi0+bWF4X3Zxcyk7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gK30NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gV2Ugc2hvdWxkIGhh
bmRsZSB0aGUgY2FzZSB3aGVuIE1RIGlzDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlIGJ1dCBub3QgdGhlIGRyaXZlci4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRS5n
IGluIHRoZSBjYXNlIHdoZW4gd2UgaGF2ZSAyIHF1ZXVlIHBhaXJzOg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBXaGVuIE1R
IGlzIGVuYWJsZWQsIGN2cSBpcyBxdWV1ZSA0DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdoZW4gTVEgaXMgbm90IGVuYWJs
ZWQsIGN2cSBpcyBxdWV1ZSAyDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGVyZSdzIHNvbWUgaXNzdWUgd2l0aCB0aGlzLiBJ
IGdldA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gY2FsbGJhY2tzIHRhcmdldGluZyBz
cGVjaWZpYyB2aXJ0cXVldWVzIGJlZm9yZQ0KPiBmZWF0dXJlcyBuZWdvdGlhdGlvbiBoYXMgYmVl
biBjb21wbGV0ZWQuDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gU3BlY2lmaWNhbGx5LCBJIGdldCBzZXRfdnFfY2IoKSBjYWxscy4g
QXQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHRoaXMgcG9pbnQgSSBtdXN0IGtub3cg
dGhlIGNvbnRyb2wgdnEgaW5kZXguDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU28gSSB0
aGluayB3ZSBuZWVkIGRvIGJvdGg6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAxKSBBdCBvbmUgaGFuZCwgaXQncyBhIGJ1ZyBmb3IgdGhl
IHVzZXJzcGFjZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHRvIHVzZSB2cV9pbmRleCBi
ZWZvcmUgZmVhdHVyZSBpcyBuZWdvdGlhdGVkDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAobG9va3MgbGlrZSBhIGJ1ZyBpbiBteSBjdnEg
c2VyaWVzIHRoYXQgd2lsbA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhbGwgU0VUX1ZS
SU5HX0NBTEwgYmVmb3JlIGZlYXR1cmUgaXMgbmVnb3RpYXRlLA0KPiB3aGljaCBJIHdpbGwgbG9v
aykuDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiAyKSBBdCB0aGUgb3RoZXIgaGFuZCwgdGhlIGRyaXZlciBzaG91bGQgYmUNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBhYmxlIHRvIGRlYWwgd2l0aCB0aGF0DQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gQWxsIEkgY2FuIGRvIGlz
IGRyb3AgY2FsbGJhY2tzIGZvciBWUXMgYmVmb3JlDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IGZlYXR1cmVzIG5lZ290YXRpb24gaGFzIGJlZW4gY29tcGxldGVkLg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gT3IganVzdCBsZWF2ZSBxdWV1ZSBpbmRleCAwLCAxIHdvcmsuDQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU2luY2UgaXQgaXMgbm90IGV4
cGVjdGVkIHRvIGJlIGNoYW5nZWQuDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IFJpZ2h0LCB3aWxsIGRvLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBJIHRoaW5rIHRoZSBDVlEgaW5kZXggbXVzdCBub3Qg
ZGVwZW5kIG9uIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbmVnb3RpYXRlZCBm
ZWF0dXJlcyBidXQgcmF0aGVyIGRlcGVuZCBvZiB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IHZhbHVlIHRoZSBkZXZpY2UgZHJpdmVyIHByb3ZpZGVzIGluIHRoZSBjYWxsIHRvDQo+
IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgpLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEF0
IHRoZSB2aXJ0aW8gbGV2ZWwsIGl0J3MgdG9vIGxhdGUgdG8gY2hhbmdlDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gdGhhdCBhbmQgaXQgYnJlYWtzIHRoZSBiYWNrd2FyZCBjb21wYXRpYmls
aXR5Lg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gQnV0IGF0IHRoZSB2RFBBIGxldmVsLCB0aGUgdW5kZXIgbGF5ZXIgZGV2aWNlDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gY2FuIG1hcCB2aXJ0aW8gY3ZxIHRvIGFueSBvZiBpdCdz
IHZpcnRxdWV1ZS4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IEUuZyBtYXAgY3ZxIChpbmRleCAyKSB0byBtbHg1IGN2cSAodGhlIGxhc3Qp
Lg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IEkgYW0gbm90IGZvbGxvd2luZyB5b3UgaGVyZS4gSSBzdGlsbCBkb24ndCBrbm93IHdoYXQNCj4g
aW5kZXggaXMgY3ZxLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gUmlnaHQsIHdlIHN0aWxsIG5l
ZWQgdG8gd2FpdCBmb3IgdGhlIGZlYXR1cmUgYmVpbmcNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IG5lZ290aWF0ZWQgaW4gb3JkZXIgdG8gcHJvY2VlZC4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gU28gdG8gc3VtbWFyaXNlLCBiZWZvcmUgZmVhdHVyZSBu
ZWdvdGlhdGlvbg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNvbXBsZXRlLCBJIGFjY2VwdCBjYWxs
cyByZWZlcnJpbmcgdG8gVlFzIG9ubHkgZm9yIGluZGljZXMgMA0KPiBhbmQgMS4NCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBBZnRlciBmZWF0dXJlIG5lZ290aWF0aW9uIGNvbXBsZXRlIEkga25vdyBD
VlEgaW5kZXgNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhbmQgd2lsbCBhY2NlcHQgaW5kaWNlcyAw
IHRvIGN2cSBpbmRleC4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gSSBkb24ndCBnZXQgdGhpcyAiYWNj
ZXB0IGluZGljZXMgMCB0byBjdnEgaW5kZXgiLg0KPiA+ID4gPiA+ID4gPiA+ID4gV2hhdCBJIG1l
YW50IHRvIHNheSBpcyB0aGF0IHRoZXJlIGFyZSBzZXZlcmFsIGNhbGxiYWNrcw0KPiA+ID4gPiA+
ID4gPiA+ID4gdGhhdCByZWZlciB0byBzcGVjaWZpYyB2aXJ0cXVldWVzLCBlLmcuDQo+ID4gPiA+
ID4gPiA+ID4gPiBzZXRfdnFfYWRkcmVzcygpLCBzZXRfdnFfbnVtKCkgZXRjLiBUaGV5IGFsbCBh
Y2NlcHQgdmlydHF1ZXVlDQo+IGluZGV4IGFzIGFuIGFyZ3VtZW50Lg0KPiA+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiA+IFdoYXQgd2Ugd2FudCB0byBkbyBpcyB2ZXJpZnkgd2hlYXRo
ZXIgdGhlIGluZGV4IHByb3ZpZGVkDQo+ID4gPiA+ID4gPiA+ID4gPiBpcyB2YWxpZCBvciBub3Qu
IElmIGl0IGlzIG5vdCB2YWxpZCwgZWl0aGVyIHJldHVybiBlcnJvcg0KPiA+ID4gPiA+ID4gPiA+
ID4gKGlmIHRoZSBjYWxsYmFjayBjYW4gcmV0dXJuIGEgdmFsdWUpIG9yIGp1c3QgYXZvaWQNCj4g
PiA+ID4gPiA+ID4gPiA+IHByb2Nlc3NpbmcgaXQuIElmIHRoZSBpbmRleCBpcyB2YWxpZCB0aGVu
IHdlIHByb2Nlc3MgaXQgbm9ybWFsbHkuDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+ID4gTm93IHdlIG5lZWQgdG8gZGVjaWRlIHdoaWNoIGluZGV4IGlzIHZhbGlkIG9yIG5vdC4g
V2UNCj4gPiA+ID4gPiA+ID4gPiA+IG5lZWQgc29tZXRoaW5nIGxpa2UgdGhpcyB0byBpZGVudGlm
aXkgdmFsaWQgaW5kZXhlcyByYW5nZToNCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4gPiBDVlEgY2xlYXI6IDAgYW5kIDENCj4gPiA+ID4gPiA+ID4gPiA+IENWUSBzZXQsIE1RIGNs
ZWFyOiAwLCAxIGFuZCAyIChmb3IgQ1ZRKS4NCj4gPiA+ID4gPiA+ID4gPiA+IENWUSBzZXQsIE1R
IHNldDogMC4ubnZxIHdoZXJlIG52cSBpcyB3aGF0ZXZlciBwcm92aWRlZA0KPiA+ID4gPiA+ID4g
PiA+ID4gdG8NCj4gPiA+ID4gPiA+ID4gPiA+IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgpDQo+ID4g
PiA+ID4gPiA+ID4gWWVzLg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFVuZm9ydHVu
YXRlbHkgaXQgZG9lcyBub3Qgd29yay4NCj4gPiA+ID4gPiA+ID4gc2V0X3ZxX2NiKCkgZm9yIGFs
bCB0aGUgbXVsdGlxdWV1ZXMgaXMgY2FsbGVkIGJlb2ZyZSBmZWF0dXJlDQo+ID4gPiA+ID4gPiA+
IG5lZ290aWF0aW9uLiBJZiBJIGFwcGx5IHRoZSBhYm92ZSBsb2dpYywgSSB3aWxsIGxvc2UgdGhl
c2Ugc2V0dGluZ3MuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEkgY2FuIG1ha2UgYW4g
ZXhjZXB0aW9uIGZvciBzZXRfdnFfY2IoKSwgc2F2ZSBjYWxsYmFja3MgYW5kDQo+ID4gPiA+ID4g
PiA+IHJlc3RvcmUgdGhlbSBhZnRlcndhcmRzLiBUaGlzIGxvb2tzIHRvbyBjb252b2x1dGVkIGFu
ZCBtYXliZQ0KPiA+ID4gPiA+ID4gPiB3ZSBzaG91bGQgc2VlayBhbm90aGVyIHNvbHV0aW9uLg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkgYWdyZWUuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuDQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gUmV0aGluayBhYm91dCB0aGlzIGlzc3VlLiBJdCBsb29rcyB0byB0aGUg
b25seSBpc3N1ZSB3ZSBmYWNlDQo+ID4gPiA+ID4gPiBpcyB0aGUgc2V0X3ZxX2NiKCkuDQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gV2l0aCB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoZSB1c2Vyc3Bh
Y2UgY2FuIHVzZSB0aGUgaW5kZXgNCj4gPiA+ID4gPiA+IGNvcnJlY3RseSAoZXZlbiBiZWZvcmUg
c2V0X2ZlYXR1cmVzKS4gSSB3b25kZXIgdGhlIGZvbGxvd2luZyB3b3Jrcy4NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBJbnN0ZWFkIG9mIGNoZWNraW5nIHdoZXRoZXIgdGhlIGluZGV4IGlzIGN2
cSBpbiBzZXRfdnFfY2IoKSBob3cNCj4gYWJvdXQ6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
MSkgZGVjb3VwbGUgZXZlbnRfY2Igb3V0IG9mIG1seDVfdmRwYV92aXJ0cXVldWUgYW5kDQo+ID4g
PiA+ID4gPiBtbHg1X2Nvbmdyb192cQ0KPiA+ID4gPiA+ID4gMikgaGF2ZSBhIGRlZGljYXRlZCBl
dmVudF9jYiBhcnJheSBpbiBtbHg1X3ZkcGFfbmV0DQo+ID4gPiA+ID4gPiAzKSB0aGVuIHdlIGNh
biBkbw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IG5kZXYtPmV2ZW50X2Nic1tpbmRleF0gPSAq
Y2I7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvIGFjdHVhbGx5IHlvdSdyZSBzdWdnZXN0aW5n
IHRvIHNhdmUgYWxsIHRoZSBjYWxsYWJjaw0KPiA+ID4gPiA+IGNvbmZpZ3VyYXRpb25zIGluIGFu
IGFycmF5IGFuZCBldmFsdWF0ZSBjdnEgaW5kZXggYWZ0ZXIgZmVhdHVyZQ0KPiA+ID4gPiA+IG5l
Z290aWF0aW9uIGhhcyBiZWVuIGNvbXBsZXRlZC4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4g
WWVzLg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSB0aGluayB0aGF0
IGNvdWxkIHdvcmsuIEkgd2lsbCBjb2RlIHRoaXMgYW5kIHVwZGF0ZS4NCj4gPiA+ID4NCj4gPiA+
DQo+ID4gPiBJdCB3b3JrcyBmaW5lIHdoZW4gSSBhbSB3b3JraW5nIHdpdGggeW91ciB2ZXJzaW9u
IG9mIHFlbXUgd2l0aA0KPiA+ID4gc3VwcG9ydCBmb3IgbXVsdGkgcXVldWUuDQo+ID4gPg0KPiA+
ID4gVGhlIHByb2JsZW0gaXMgdGhhdCBpdCBpcyBicm9rZW4gb24gcWVtdSB2Ni4wLjAuIElmIEkg
cmVnaXN0ZXIgbXkNCj4gPiA+IHZkcGEgZGV2aWNlIHdpdGggbW9yZSB0aGFuIDIgZGF0YSB2aXJ0
cXVldWVzLCBxZW11IHdvbid0IGV2ZW4gY3JlYXRlDQo+ID4gPiBhIG5ldGRldmljZSBpbiB0aGUg
Vk0uDQo+IA0KPiBRZW11IHNob3VsZCBoaWRlIE1RIGZlYXR1cmUgaW4gdGhpcyBjYXNlIGJ1dCBs
b29rcyBsaWtlIGl0IGRvZXNuJ3QuDQo+IA0KPiBXaWxsIGhhdmUgYSBsb29rLg0KPiANCj4gPiA+
DQo+ID4gPiBJIGFtIG5vdCBzdXJlIGhvdyB0byBoYW5kbGUgdGhpcy4gSXMgdGhlcmUgc29tZSBr
aW5kIG9mIGluZGljYXRpb24gSQ0KPiA+ID4gY2FuIGdldCBhcyB0byB0aGUgdmVyc2lvbiBvZiBx
ZW11IHNvIEkgY2FuIGF2b2lkIHVzaW5nIG11bHRpcXVldWUNCj4gPiA+IGZvciB2ZXJzaW9ucyBJ
IGtub3cgYXJlIHByb2JsZW1hdGljPw0KPiA+DQo+ID4gTm8gdmVyc2lvbnMgOykgVGhpcyBpcyB3
aGF0IGZlYXR1cmUgYml0cyBhcmUgZm9yIC4uLg0KPiANCj4gWWVzLg0KPiANCj4gU28gZG9lcyBp
dCB3b3JrIGlmICJtcT1vZmYiIGlzIHNwZWNpZmllZCBpbiB0aGUgY29tbWFuZCBsaW5lPw0KPiAN
CldlIHNob3VsZCBub3QgYWRkIGRyaXZlciBtb2R1bGUgcGFyYW1ldGVyLg0KV2UgYW55d2F5IG5l
ZWQgbnVtYmVyIG9mIFZRcyB0byBiZSBkcml2ZW4gYnkgdGhlIG51bWJlciBvZiB2Y3B1cyB1c2Vk
IGJ5IHRoZSBWTS4NClNvIHdoeSBub3Qgc3BlY2lmeSB0aGlzIHdoZW4gY3JlYXRpbmcgYSB2ZHBh
IGRldmljZT8NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
