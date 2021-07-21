Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1BDC12002
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 09:26:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A426109F
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 09:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A426109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3E4E403B5;
	Wed, 21 Jul 2021 09:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iE6tWkxvVNmY; Wed, 21 Jul 2021 09:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C76D40142;
	Wed, 21 Jul 2021 09:26:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30E77C001A;
	Wed, 21 Jul 2021 09:26:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D01EC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5679D402DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=vmware.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h06dCVbKewZf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:26:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EBF02402D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 09:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfwDnShgIdY2LLuc7qMfRIafRCw7Fb+Ur/SbTJWfH7V34/U7JPsuOdfDwDnnyVMzf0gMdYAsttFlUkJrvOAtCZow+6zKovHZ9jwSaTHYCfkk7MYyY5HOxQOIINaRIu73CxVrC4b89kNOsPVCSTONNM/S5799m59X70oTLVvzTroEMIgWeczZ2tfWdA96LzRR1VwRyj7Ag94uj55s1NeE83wp1NN6VKNvS1DS3EOUifjnwROBBsDXm9MmcF97D4qy8mesa5qLBP8PEyKFxlUYqApPgECkyyD27FR3QRqPZg1XEER3hyeqaZnQzjAsJffnnQ9sIOt2/fN6h/QAVgOBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rptB4eWJTuxIv4Ug9+5e0lHIeNMQFLajYOsLk57gVKQ=;
 b=UWXabw4LDqCKMAwyV/R3ppbaYhSjvBhmvLNg3YEdRne4XAZP6+GFRzgBJ1Vgd0+OhcdjpW3eYpW2ZZbIVfikkdlt4HivJztzTr13L9Pm8E9IXAL9Sp8X4XcHODkSScKRKpaNrXmxjo1lEWP3LJeEPlSBjzcL2PUFY7C9l1/+qjU2SOAUlJAHzaR/BPp38jMhC7oC7QUsik9QMOzJnsxh9iWe+E/lqWrzZX5uq+YMp1UZbfdn+yeGt9zr/S6IDG8cEHvhfVgAKgoPiyMQSBpt3+wh+QFIE4ugmxGn+FDoRMPMe7ZzIbF8bFsocRGIJdZypMgxtg5StEsB8kj4tHhAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rptB4eWJTuxIv4Ug9+5e0lHIeNMQFLajYOsLk57gVKQ=;
 b=EGNTEejrpZ/Fe1BkLE1EciDqcYqHazqb0xg/998iHL2rQktkWuG2ZVPz30iYb5kB4ExZP0QXRQgPOIsMLHEWlftFCcRYa4hphT4GRIj1P74A95/nenkUOL81N9lGXZDk9E5QME79kcNHrFrpuw2FHe+MYzIh9lDKmvLyiQowVVw=
Received: from DM5PR05MB3452.namprd05.prod.outlook.com (2603:10b6:4:41::11) by
 DM6PR05MB4731.namprd05.prod.outlook.com (2603:10b6:5:17::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.17; Wed, 21 Jul 2021 09:26:15 +0000
Received: from DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::94c0:39f7:9695:56ea]) by DM5PR05MB3452.namprd05.prod.outlook.com
 ([fe80::94c0:39f7:9695:56ea%3]) with mapi id 15.20.4352.024; Wed, 21 Jul 2021
 09:26:15 +0000
From: Jorgen Hansen <jhansen@vmware.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Thread-Topic: [PATCH] MAINTAINERS: Update for VMCI driver
Thread-Index: AQHXfVIP+6abVM7c7EmQXyuZ/FLCiatLrFmAgAFyvYCAAAQFAIAABycA
Date: Wed, 21 Jul 2021 09:26:15 +0000
Message-ID: <6344A6B0-F7B7-450C-9BDF-AF9056D211F3@vmware.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
 <YPan14jucU9/u6JL@kroah.com>
 <0C3493F7-AF29-417B-94EA-26871283E65A@vmware.com>
 <YPfiNuKonyTIKcDL@kroah.com>
In-Reply-To: <YPfiNuKonyTIKcDL@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a70e299-a291-40a8-7b42-08d94c29969f
x-ms-traffictypediagnostic: DM6PR05MB4731:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR05MB473124774F108D8AA132D591DAE39@DM6PR05MB4731.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vUFmjQzKc/sAEzD89JWkWPaaiKdsVtcovWHt6G9EFGVdl0hLDm4DersRg4n92kjYjLJx6NR6/R6j0hWLLn/ISq7CWggN0yeylpZmIFjPBvSg+wp2rXGnGPMCESX9v/JOTiTw4Ow6Cc5E2WQiDK5I23fs6t5q69s18E80QxEzeMISLnNEjsCrupANxjV2+Nn1DAnhh68es+jIKS+pMdyimRkm4SeBsq+c/rS+FsNZIMPuMjAjAZwx/6Ur1cGs35vPSfqAUPzbZPn59/M0+kXw+gYqblYuxsUJ7SqFMq7QynwfQtIj1qFJMV52YP3LV3DJ5PH0usDZOySWLgiRjEz96yKREtgR6a2ryUZRzouiIViA9FNTTUCehVISnnFEVQNreqtTxsXInlK1XKygib339MaUJJAJ3gysKoJsbhdvQr17sqaY9ZIPeWtxZ+JL0Zh+C9AIJ1vESV5DSXM8cpWzfmegiweCN9SMMYhYkNPyOmgUdFO/Hh2oTGdTEPTlqTXUlY4o0PlVfgkMO0LdbrVj8IBBMycdjDtyOkdTSt3y0nr32+V7iu9O0o83tMSas2n91g2UgCH75/kTDsdSeg2elYDChv6+Lj0zAz8hjHYJhW0w7GHIwYgWfI0y/1kSyDPmnVn2XCYIgGZDGXLWWNzHrYyspXzspHGkOXyW4bIYPNGAYlIK9r7M/skmm4NOd7q8K/HVb6UgxRwQCXVLlkBuq4gTWj3NQDMowu8GTLrSUdJaPTUgeYI/PB2Vp0AzzCUJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR05MB3452.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6512007)(122000001)(76116006)(66556008)(38100700002)(91956017)(26005)(186003)(8676002)(66946007)(66476007)(107886003)(64756008)(36756003)(8936002)(6486002)(54906003)(66446008)(2616005)(71200400001)(86362001)(6916009)(4326008)(6506007)(33656002)(2906002)(508600001)(53546011)(316002)(45980500001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTlPbDdDTkxBVlo4eEthZHhtM29BNi9lVkhvN1dwVEVwSURZTGc5TEE3eHpW?=
 =?utf-8?B?TjZUS2MzYTdyU3NFQm0rTjZxOGN0YVBNRUU0OUZYY2xkdndCVjhEZU02dVNp?=
 =?utf-8?B?azArWUxmNG1Ya2YrekFqcE11ZWVacklhRGs4UUtJSW5BeFk2ZWduUTFwaE1p?=
 =?utf-8?B?TjQ3MFNFMG0yY0JKR2NQY1VuUzBQMjVySmFJUXFvUDdBR2NRaTJybXp0bWdh?=
 =?utf-8?B?QmFVSXMxL1dvdWdUYVI2N3BSR1l2TUxJa0pZYnFiajBnZ3kweFRvbXRIZldw?=
 =?utf-8?B?VFpsYnQ4cm5DU09OQ296bWo0N0FaZWIrajVRcU9XMkJiZ1Y4L0U2K09KbHZs?=
 =?utf-8?B?NnBXSUkyRmtTY3ovTjlUVzdSQnE1VmdKankxL0tsNnBDTWRkNm8yU09LWmxj?=
 =?utf-8?B?UG9ZU2liYzhUUmFDZlMrVkIwL0J6UllIVUNYR0hNS1YrYXl6RVdVSHZsNlBZ?=
 =?utf-8?B?dUttSFhUVXYzdEpyOTlBd1VUdzliQlI0U01ram12cmsyeGlPcXFIZmcralFG?=
 =?utf-8?B?V2JVTXJScmxKVFkwT041cnIwTFNtMFEvaW1saUlqWUtQOVhXeDNXVVZZSDFq?=
 =?utf-8?B?YWk3UWM0OEEvakpuUXZKZVJBUHVFRzJtVTdYdjRRWVdZZFFUaXFtK1hKRlha?=
 =?utf-8?B?WTZTcEZHNzFyNVE5NGg4UnRRL0dnYlpHUmg1UWQxMUxtZUlXT1I4bUJPSVR4?=
 =?utf-8?B?Rk8yLzFBSjRMOXBjTEtSK1UxZStVdDBGM1Azcy91eGJHTklJY2dvdXdvMmkz?=
 =?utf-8?B?L1hDdVhqZ1Q2SStTbk1ZMXNsTU5TSGNaZWdDRHhJWk9aQmZEckVZU0MxWkVB?=
 =?utf-8?B?d2cySWp6UExLTTdNd1RsOWN4RWwraHpLNWx0U0t0dXp3eUVoSUVlSis3NFpK?=
 =?utf-8?B?TVJWZGcrblZENE5CZGp0SzhDTCtmb1JYaDlqMlY4MWlSVUhDKyt0RXFtWTBv?=
 =?utf-8?B?dW5pMkNGeVZRZ240cHJkZFg0Qnh5dXUrdzZ4WThEK01raW5nNVZlaUdjQzdX?=
 =?utf-8?B?ZHYyZlgzM1AwQTBRRnVxalc4RFRHbE9RYlErZjlyeERSYmsvWWp6NEJNcU1u?=
 =?utf-8?B?UDlvanlycHQxTjY0UWxpZW5TY0hWbVc5MUptUER2YjZJWnYzK0VLMjdFMVQy?=
 =?utf-8?B?NXNRT3g5STdRWVZtdGJKY1lzbkphZ3lsZ2R5RDdzbE43RkRrWWptSnk1eCta?=
 =?utf-8?B?akg1ZERZamRQb2ZFMXlnVzVMSG0rZVJLSk9ocU9vWmFMc2pTQnNlSzZLNVVZ?=
 =?utf-8?B?ZmNKNC9HOFNEcUlLbitxeVJ4cHBoUFV2NkNBWVE2UXArRnRmWGJlQTZ1Q3Iy?=
 =?utf-8?B?aG1TM0pSanZVZEFqdHIwRjhjVU0zc3NTNEw2YlNyaERPR3M0RHBtOHB6L1Zs?=
 =?utf-8?B?VFpzeU95QnRlUFlDOFVYNWI0eDhSUnlxOEl1NGJpUU84UHpNa293WmlETU1Y?=
 =?utf-8?B?ZWFDdnpnRHZRY1V3TVBoUHJrQllTbk9qOVJ6ZDF6dlFIdHNkUEVZNnJhWDNI?=
 =?utf-8?B?MFJzLys3cFdXWk91ZXZIVEsvbXlmd0tRUXdOTDlJTVVYZmNTMzdWTmpLbnlP?=
 =?utf-8?B?V014MU1pRFVLL2d3UjJsb2JoZTVZRkIxKzViOEVKaStQSFRCZ3FKN1Q2R2NS?=
 =?utf-8?B?UWlhVEtnZnVZTkZzbkVSNU9PMFVtRkp3ZHExWWVmNGpyZjFyNmZ2ZTZLaFVp?=
 =?utf-8?B?VHAycHpBWGpoeW0xMUVPdlp4ZGszU3FUVjg1NDcwRWFoZzNDOHlYQ0hIR05R?=
 =?utf-8?Q?lBQ+CQfWUfEjN6g+/WleSvM2hYGLhFuBtdp5515?=
Content-ID: <1555F89F7BE0E44C8E4EACBE64B6AB3C@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR05MB3452.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a70e299-a291-40a8-7b42-08d94c29969f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 09:26:15.2930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYOBr3z9OspPzaBdo0IbIrDna7i9JT6R0UiElaJXIeZOIF6+JSa5H4kBjT7gNjFjoAc9n/OKgC/mAwTJgNge5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4731
Cc: Pv-drivers <Pv-drivers@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQoNCj4gT24gMjEgSnVsIDIwMjEsIGF0IDExOjAwLCBHcmVnIEtIIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEp1bCAyMSwgMjAyMSBhdCAwODo0Njox
NUFNICswMDAwLCBKb3JnZW4gSGFuc2VuIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiAyMCBKdWwg
MjAyMSwgYXQgMTI6MzksIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90
ZToNCj4+PiANCj4+PiBPbiBUdWUsIEp1bCAyMCwgMjAyMSBhdCAwMzoyOTowMUFNIC0wNzAwLCBK
b3JnZW4gSGFuc2VuIHdyb3RlOg0KPj4+PiBBZGQgbWFpbnRhaW5lciBpbmZvIGZvciB0aGUgVk13
YXJlIFZNQ0kgZHJpdmVyLg0KPj4+PiANCj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9yZ2VuIEhhbnNl
biA8amhhbnNlbkB2bXdhcmUuY29tPg0KPj4+PiAtLS0NCj4+Pj4gTUFJTlRBSU5FUlMgfCA4ICsr
KysrKysrDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4+Pj4gDQo+Pj4+
IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+Pj4+IGluZGV4IGE2MWY0
ZjMuLjdlN2M2ZmEgMTAwNjQ0DQo+Pj4+IC0tLSBhL01BSU5UQUlORVJTDQo+Pj4+ICsrKyBiL01B
SU5UQUlORVJTDQo+Pj4+IEBAIC0xOTc5Miw2ICsxOTc5MiwxNCBAQCBMOgluZXRkZXZAdmdlci5r
ZXJuZWwub3JnDQo+Pj4+IFM6CVN1cHBvcnRlZA0KPj4+PiBGOglkcml2ZXJzL3B0cC9wdHBfdm13
LmMNCj4+Pj4gDQo+Pj4+ICtWTVdBUkUgVk1DSSBEUklWRVINCj4+Pj4gK006CUpvcmdlbiBIYW5z
ZW4gPGpoYW5zZW5Adm13YXJlLmNvbT4NCj4+Pj4gK006CVZpc2hudSBEYXNhIDx2ZGFzYUB2bXdh
cmUuY29tPg0KPj4+PiArTToJIlZNd2FyZSwgSW5jLiIgPHB2LWRyaXZlcnNAdm13YXJlLmNvbT4N
Cj4+PiANCj4+PiBQbGVhc2UgZG8gbm90IHVzZSBnZW5lcmljIGFsaWFzZXMgYXMgdGhleSBwcm92
aWRlIG5vIHBlcnNvbmFsDQo+Pj4gcmVzcG9uc2liaWxpdHkuICBKdXN0IHN0aWNrIHdpdGggcmVh
bCBwZW9wbGUuDQo+PiANCj4+IFRoYXQgbWFrZXMgc2Vuc2UuIEhvd2V2ZXIsIHRoZSBwdi1kcml2
ZXJzIGxpc3QgaXMgdXNlZCBmb3Iga2VlcGluZyBtYW5hZ2Vycw0KPj4gYW5kIHBlb3BsZSBoZWxw
aW5nIHdpdGggdGVzdGluZyBpbiB0aGUgbG9vcC4gU28gd291bGQgYWRkaW5nIHB2LWRyaXZlcnMg
YXMgYQ0KPj4gc2Vjb25kIEw6IGVudHJ5IGJlIE9LPw0KPiANCj4gSXMgaXQgcmVhbGx5IGEgbGlz
dD8gIElmIG5vdCwgdGhlbiB0aGF0IHdvdWxkIG5vdCBtYWtlIG11Y2ggc2Vuc2UuDQoNCkl0IGlz
IC0gd2l0aCBWTXdhcmUgc3Vic2NyaWJlcnMgb25seSBidXQgYW55b25lIGNhbiBwb3N0IHRvIGl0
LiBJZiB0aGUgaW50ZW50IG9mIHRoZQ0KTDogZW50cmllcyBpcyB0byBhbGxvdyBmb2xrcyB0byBz
dWJzY3JpYmUgdG8gcmVsZXZhbnQgaW5mb3JtYXRpb24sIHRoZW4gaXQgaXNu4oCZdA0KYXBwcm9w
cmlhdGUuDQoNCkFsbCBleGlzdGluZyB2bXcgZHJpdmVyIG1haW50YWluZXIgZW50cmllcyBoYXZl
IHB2LWRyaXZlcnMgYXMgYW4gTTogZW50cnksDQpzbyBoYXMgdGhlcmUgYmVlbiBhIGNoYW5nZSBp
biBwb2xpY3kgcmVnYXJkaW5nIHRoaXM/IFRoZSBhcHByb2FjaCBoYXMNCmJlZW4gcXVpdGUgdXNl
ZnVsIGZvciB1cy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
