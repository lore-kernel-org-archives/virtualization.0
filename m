Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A5FC4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 06:10:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F1F61051
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 06:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46F1F61051
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08B316068B;
	Mon,  9 Aug 2021 06:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id obTCy8tNAk8b; Mon,  9 Aug 2021 06:10:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8591560630;
	Mon,  9 Aug 2021 06:10:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67B66C001A;
	Mon,  9 Aug 2021 06:10:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF781C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 06:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CABCE60669
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 06:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c7V02J-wudjR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 06:10:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D434960630
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 06:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoG30RN49WRNFHRwgTcT+kA5zBbjLlNLD4qA7gEZisRpsFcwdCy1IhuQx0pYqaIXkPeN0a4hQT8REX3bgrAGFVXRvmMWrf9/lNfAT9Gj960iKMhqTV/FgVbQEYSe2ovk3imFbvgnc2hTFhYJz4ImLWYmWbvxEBpjCK55N5GqFl303MhKfx5SmcjIX4T3IsuCOugkwwpkobSETVh5/Z+E0Ho73kWqTGH55/P7Zzz83mvmm5dfBf4EV6//ailzoAXK7St9ymETwD4qeErTte+39KYzG+ttemISUdi2q5Kjun+o29G5cCiauJUO45T6yDEbt+3gMIe8WasUpn2vAIpA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXn7RVpmdhDrWi32UhpJAUvx/Pt+HDpe96spLPH9/js=;
 b=M/n5+w4EepnUkZnzG0+Zsje9/Q4TAEna11I/FA5s/63Y7SXDr8A1HowsvXKv4a3MhAMsQa+AEfL1MVS1NmRJlLMvVUchVJmSTYTFPMyZYZrEZYIUk8krhoZO1zueLiJi7Xu0KKTlinOPhyZl7UoHU8W/qdzEPr3RQqeWHhg8oTj1RH0TTXt8zMnKpMPz7tT4Magt28CF8h8mzLiZ41ExhOJEL80+Bln3HEMEhGek8wHPAtxUVDAG6Mqeir0jTcMfBhbaSKiXLqmNck/Ws4eZeoViogP9A3ehJkGf7oXzVQA+AuZTwtKMxQDPc8cYuoos6PIOZyN1qsBj+m0O2KainA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXn7RVpmdhDrWi32UhpJAUvx/Pt+HDpe96spLPH9/js=;
 b=eMrRFhU+xXUW6isCQceLwgm35tnh0IoFj9aSSGtlpChODF1zNVOKfpHTFVJuwmEd8LkxaichlRyMLsfx8VXKkThk1uPg+YKVw/NeWO/bmtqm52YWmy2yXoNJdK5AtmezxEKmW1gbvML4yQe+J0fAduxh3LCgNRO9cK0VvrtSbwTJO9RxO5bk3ukgpko8rIOdom/MAW5xz38NvX0zbAVQyQKDi/97b92FtslsRvSaexlxc1FS7Qul/O8ltKgoiJO6TzcWFXx9NY13+R6XLmBsWrhDmwi11hawTDTVdnBxcfplJycI3Nvum3dyDJ+op94EpZ1QXBlWK6XJVe8d/PY6jQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Mon, 9 Aug
 2021 06:10:45 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 06:10:45 +0000
To: Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAEa9oCAAGJZgIAAALAggARY0QCAACVNgIAABSwggAAFAwCAAAB4gIAAAlEAgAAAKjA=
Date: Mon, 9 Aug 2021 06:10:45 +0000
Message-ID: <PH0PR12MB54813DD5B2E36DEF5364C1A5DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <be8a0173-b7fb-eabf-bc4a-9492133674ef@redhat.com>
 <20210809052121.GA209158@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481F74DCC09018C476D7262DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809055748.GA210406@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481E4454B3785A40AB8A181DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809060746.GA210718@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210809060746.GA210718@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 218d5863-bbef-41a7-220b-08d95afc6d10
x-ms-traffictypediagnostic: PH0PR12MB5420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54201E657F8AA6A3D77A395ADCF69@PH0PR12MB5420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3BnTZ306Tv1YQuRnkRnBHu9Gj5YnNJwKiCIxfcMGt/0BldZzgayEZjxhTXHQCIM8SGo7OG02KebCmdV5m8ky875MHKlGVyDUmSJcGH0q1q5o22rBClzZ1phs0KLq7izU52uNPElk9NvIkXxF1K2hzsDVbMcv2QrWbUu/CtAG/J+vggqc1T4MeAUCfp6B9IqduBK7vejPy2yHxGg+G6CCWZ7GeDiWNU4n5Fi00geaKJTWyjp4iZriPAcJV8gMY5Vx7R4Prg2jplD+98l4Zokl7knMnpoqc0qnjuSXBJxeDjPW0mQUGu7Z2lsosdQA6B+bPBdSieE1KxxmFYuLvg11UyQ0H/wk4eeqYwigssIilGy5wMOiDi6/CHU3Bp+qzcbKdDIFdy7Rx8sJmMrEKMbKE8Lr4vWuHh3rwhEhWSZpn8IkWoKrjJHoWv7UauATO0xSifHHutLj0FTD5OLCdyNKIyDS/Nhaby57PoZsIWMntB/SyXJ4uOJk9e3hqJW9JmrTZ9K+mpnWJwPk1vjVkTXtdJ/dTHpUk5CT80s5hNqaqfrdhGRWmOfLPPjH1ZAJ5g090NHLVw8+q4fgcwiU75Nu4TT9UzBKLDUcKbMpYce3fk6GsNPHL7DY0BNOTXKo0/cKP0BWJilyor+OZYS4Cs32d6tV56k3nbpQoG1P1hxjOaQSfTHP8DDeTUPagJMNHpjfoVXeo7PeEK1DRvMdVVGl5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(83380400001)(6506007)(33656002)(71200400001)(316002)(86362001)(38070700005)(5660300002)(8676002)(52536014)(9686003)(8936002)(186003)(122000001)(55016002)(38100700002)(2906002)(66476007)(66556008)(64756008)(6862004)(66946007)(6636002)(55236004)(478600001)(4326008)(66446008)(76116006)(7696005)(26005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2Q1OUd6VWw1TTRNaEdHUkFpNHdmVDdmamhkSTA4RlROZzVUcG5FRGUxZ0NT?=
 =?utf-8?B?bUg4SENOZkgvYmJOcW5wNFJxVzJoUzdUM1FpelR1Nm1UWjFZR0htcmdEUXhG?=
 =?utf-8?B?YXRETHpDMGRjb2RHczZNT3pQMUN2b0Nqd2M2TVpUZUpCcFJSajZpMDNGMndx?=
 =?utf-8?B?K3oxOHRDK3dPRWgzWHVzTk5XVHFnNVA5WlJoak9vaUJ3a2czVmpBTjZLbTJi?=
 =?utf-8?B?TFk5cE9kVkNvWXkwUUhNNXRXdDBIckhDb3daSFp4NWZFQ3NzNDAyRi9RZEk0?=
 =?utf-8?B?eEd2dXhIMENPZmpiTFhSR3dHSFI2aVN1NE1XRWpod0FzcU5Yd3JiV0NtaTZw?=
 =?utf-8?B?NWs0MnVtV2dKWDFNOEw4MktSL3JiVjlORk1rYURFRm1JbXk0WmhScUpVMUNJ?=
 =?utf-8?B?SWJuNzFUUElUajFKeTZKMEpKWVowU0V4eEt4Sjg4Y2xpQWErc0dnK2ZQcTN3?=
 =?utf-8?B?Rmo2NEZjMTVMMnZ0WkJ1U1B5ZEwyUjNnTWs0bTZuVWZNdFNybUxXalZNTTcr?=
 =?utf-8?B?Si9jQlZtcFg3NEJVMml6d1FsU3ZGQ2YyWS8yVi94czl0SFdTUVF5WjFBY1dk?=
 =?utf-8?B?a0ZOa2NJOW5pTEZqN05aV0gyZGMzNWFobkZzR3NiL0JQQi9VTWxBMHh5L3Yz?=
 =?utf-8?B?aHlwM1FOcnZIZzc5UG1tTUVBL2p6TzhjSkVhUHFqN0tkSkNFZUI1S2hrelBN?=
 =?utf-8?B?OFc0dlRadEk1cGpFNHVNQ2RpbHJydXRGQmFNY3J4QWJKeFQ1ak8vWUViL0lr?=
 =?utf-8?B?V1FCQlgvZHlDN0Y1NFZsWG5zejUyblhFOURrUFBpUUxBcWthVjdHWW4xSUVS?=
 =?utf-8?B?ZTdDWGNIU2x4KzNXZ0FvN2szOExKMzdHQ1pBUEYrQXI4Tk41ekI2N0pRRDAr?=
 =?utf-8?B?MWgxRlVXNHR4YWI5aHBqSUF3eTU1ejJnb0tCcGErL3pSc3FZamFzQm5ick00?=
 =?utf-8?B?b3E3YkUydURXSVU3T0JDTlR6bklSOE5GaldyM21KWVZnckQrb0UwRXRxVTZo?=
 =?utf-8?B?UmJwNzNlbWZIME5DbEo5NlJmMDBGVTVJblpvWFVWemNwalhzN2J2akdJVm13?=
 =?utf-8?B?bEdxOHhJcEsyVHlpMW9hSTM1SG1rYzFKM2pYZzZ3RDNURUVDaHZaNW5VVGlh?=
 =?utf-8?B?NmJ2SmxiQ0Q0NWJaRGNuY280c1k0UmpmZFNDVFFnbUFNOHpLSHp5VEkzT092?=
 =?utf-8?B?WUNBa3FEcGREVllmUktoK1cvbWxUYXFsZERvakdPUE9WOGtRL1IwUEcrL29X?=
 =?utf-8?B?bmlXUzhleW1KUEc5VzBaaGdKaFZYK1QvbDRjNHV5aS91djQ5NzVIdnArVWoy?=
 =?utf-8?B?TEtDWHlTL2hpSGtjNTJxR0FFQ08rSnppbFpBQmkxcWgvQ2x4MUFyS0pIZkRQ?=
 =?utf-8?B?MTVlQmtHak9RYTFkL2NtYjVvTTRYSFAyNnNTcGhQSC9idXRDQ2wzM1FkN0pB?=
 =?utf-8?B?dXVsd0FLUW5idlhtcGlHTzNtQlBQQVNpRGI5dWQzNWJuaS9lUFVhb0dadlVM?=
 =?utf-8?B?WG5LZkd0Vmx5a3d1bFU2c3FyaDZDTm4xcDNzbjA2WklEQm1valVoUG5sS3Zw?=
 =?utf-8?B?NG9jMTdxZitPSjlzRXErQ2llZk03Lzl0ZEVKRGxXbnpMekYrd2JpMUZEMUxr?=
 =?utf-8?B?dkUyYVJmb1oyWFZNNElGb1E1RmIySkJ2dkR1bVJMSzFsUHFzNzZVUWxFWEFo?=
 =?utf-8?B?d2wvYVVSZVhKWC9aWUorSXJIUWp1TzVuUjhXZElHcjFWMG9oSWg5Uk5URFRv?=
 =?utf-8?Q?YfNdGNsGZfKIh98QywEYwBkvElcPeqbV5kLDy1s?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218d5863-bbef-41a7-220b-08d95afc6d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 06:10:45.5537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOGIV91gnJWnbC5CH2o2txGSjQKY7OegqloOdEeWof2suAub0torIK1X1umrrvq7kE+Ymn2sNvGusHEeoKResA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
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
QXVndXN0IDksIDIwMjEgMTE6MzggQU0NCj4gDQo+IE9uIE1vbiwgQXVnIDA5LCAyMDIxIGF0IDA5
OjAxOjQ4QU0gKzAzMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiBGcm9t
OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgQXVndXN0
IDksIDIwMjEgMTE6MjggQU0NCj4gPiA+DQo+ID4gPiBPbiBNb24sIEF1ZyAwOSwgMjAyMSBhdCAw
ODo0Mjo1OEFNICswMzAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+ID4gRnJvbTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+ID4gPiA+ID4gU2Vu
dDogTW9uZGF5LCBBdWd1c3QgOSwgMjAyMSAxMDo1MSBBTQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
T24gTW9uLCBBdWcgMDksIDIwMjEgYXQgMTE6MDc6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiDlnKggMjAyMS84LzYg5LiL5Y2INDo1NSwgUGFy
YXYgUGFuZGl0IOWGmemBkzoNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBGcm9tOiBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiA+ID4gPiA+ID4gPiA+IFNlbnQ6
IEZyaWRheSwgQXVndXN0IDYsIDIwMjEgMjoxMiBQTQ0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+ID4gICBlbnVtIHZkcGFfYXR0ciB7DQo+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMzMsNiAr
MzQsMTYgQEAgZW51bSB2ZHBhX2F0dHIgew0KPiA+ID4gPiA+ID4gPiA+ID4gICAJVkRQQV9BVFRS
X0RFVl9NQVhfVlFTLAkJCS8qIHUzMiAqLw0KPiA+ID4gPiA+ID4gPiA+ID4gICAJVkRQQV9BVFRS
X0RFVl9NQVhfVlFfU0laRSwJCS8qIHUxNiAqLw0KPiA+ID4gPiA+ID4gPiA+ID4gKwlWRFBBX0FU
VFJfREVWX05FVF9DRkdfTUFDQUREUiwNCj4gCS8qDQo+ID4gPiA+ID4gYmluYXJ5ICovDQo+ID4g
PiA+ID4gPiA+ID4gPiArCVZEUEFfQVRUUl9ERVZfTkVUX1NUQVRVUywJCS8qIHU4DQo+ICovDQo+
ID4gPiA+ID4gPiA+ID4gPiArCVZEUEFfQVRUUl9ERVZfTkVUX0NGR19NQVhfVlFQLA0KPiAJLyoN
Cj4gPiA+ID4gPiB1MTYgKi8NCj4gPiA+ID4gPiA+ID4gPiA+ICsJVkRQQV9BVFRSX0RFVl9ORVRf
Q0ZHX01UVSwJCS8qDQo+IHUxNiAqLw0KPiA+ID4gPiA+ID4gPiA+ID4gKwlWRFBBX0FUVFJfREVW
X05FVF9DRkdfU1BFRUQsCQkvKg0KPiB1MTYgKi8NCj4gPiA+ID4gPiA+ID4gPiA+ICsJVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX0RVUExFWCwJCS8qDQo+IHUxNiAqLw0KPiA+ID4gPiA+ID4gPiA+ID4g
KwlWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX01BWF9LRVlfTEVOLA0KPiAJLyogdTgNCj4gPiA+
ID4gPiAqLw0KPiA+ID4gPiA+ID4gPiA+ID4gKwlWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX01B
WF9JVF9MRU4sDQo+IAkvKg0KPiA+ID4gPiA+IHUxNiAqLw0KPiA+ID4gPiA+ID4gPiA+ID4gKwlW
RFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX0hBU0hfVFlQRVMsDQo+IAkvKg0KPiA+ID4gPiA+IHUz
MiAqLw0KPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4gICAJLyogbmV3IGF0
dHJpYnV0ZXMgbXVzdCBiZSBhZGRlZCBhYm92ZSBoZXJlICovDQo+ID4gPiA+ID4gPiA+ID4gPiAg
IAlWRFBBX0FUVFJfTUFYLA0KPiA+ID4gPiA+ID4gPiA+ID4gICB9Ow0KPiA+ID4gPiA+ID4gPiA+
IFRoZSBwb2ludCBpcyB0byB0cnkgYW5kIG5vdCByZWludmVudCBhIGRlZGljYXRlZCB2cGRhDQo+
ID4gPiA+ID4gPiA+ID4gaW50ZXJmYWNlIHdoZXJlIGEgZ2VuZXJpYyBvbmUgZXhpdHMuDQo+ID4g
PiA+ID4gPiA+ID4gRS5nLiBmb3IgcGh5IHRoaW5ncyBzdWNoIGFzIG1hYyBzcGVlZCBldGMsIEkg
dGhpbmsgbW9zdA0KPiA+ID4gPiA+ID4gPiA+IHBlb3BsZSBhcmUgdXNpbmcgZXRodG9vbCB0aGlu
Z3MgcmlnaHQ/DQo+ID4gPiA+ID4gPiA+IEFzIHlvdSBrbm93IHZkcGEgaXMgdGhlIGJhY2tlbmQg
ZGV2aWNlIGZvciB0aGUgZnJvbnQtZW5kDQo+ID4gPiA+ID4gPiA+IG5ldGRldmljZQ0KPiA+ID4g
PiA+IGFjY2Vzc2VkIGJ5IHRoZSBldGh0b29sLg0KPiA+ID4gPiA+ID4gPiB2ZHBhIG1hbmFnZW1l
bnQgdG9vbCBoZXJlIGlzIGNvbXBvc2luZyB0aGUgdmRwYSBkZXZpY2UuDQo+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+IEZvciBleGFtcGxlIGNyZWF0b3IgKGh5cGVydmlzb3IpIG9mIHRoZSB2
ZHBhIGRldmljZXMga25vd3MNCj4gPiA+ID4gPiA+ID4gdGhhdCBhIGd1ZXN0IFZNIGlzIGdpdmVu
IDQgdmNwdXMsIFNvIGh5cGVydmlzb3IgY3JlYXRlcyBhDQo+ID4gPiA+ID4gPiA+IHZkcGEgZGV2
aWNlcyB3aXRoIGNvbmZpZyBzcGFjZSBsYXlvdXQgYXMsIG1heF92aXJ0cXVldWVfcGFpcnMgPQ0K
PiA0Lg0KPiA+ID4gPiA+ID4gPiBBbmQgdGhlIE1BQyBhZGRyZXNzIGNob3NlbiBieSBoeXBlcnZp
c29yIGluIG1hY1s2XS4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gR3Vlc3QgVk0gZXRo
dG9vbCBjYW4gc3RpbGwgY2hvc2UgdG8gdXNlIGxlc3MgbnVtYmVyIG9mIGNoYW5uZWxzLg0KPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBUeXBpY2FsbHksDQo+ID4gPiA+ID4gPiA+IGV0aHRv
b2wgaXMgZm9yIGd1ZXN0IFZNLg0KPiA+ID4gPiA+ID4gPiB2ZHBhIGRldmljZSBpcyBpbiBoeXBl
dmlzb3IuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEhvdyBjYW4gaHlwZXJ2aXNvciBj
b21wb3NlIGEgdmRwYSBkZXZpY2Ugd2l0aG91dCBhbnkgdG9vbD8NCj4gPiA+ID4gPiA+ID4gSG93
IGNhbiBpdCB0ZWxsIGV0aHRvb2wsIHdoYXQgaXMgc3VwcG9ydGVkIGFuZCB3aGF0IGFyZSB0aGUN
Cj4gZGVmYXVsdHM/DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFJlcmVh
ZCB0aGUgY292ZXIgbGV0dGVyOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICINCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBUaGlzIHBhdGNoc2V0IGVuYWJsZXMgdXNlcnMgdG8gc2V0IHRoZSBt
YWMgYWRkcmVzcyBhbmQgbXR1IG9mDQo+ID4gPiA+ID4gPiB0aGUgdmRwYSBkZXZpY2Ugb25jZSB0
aGUgZGV2aWNlIGlzIGNyZWF0ZWQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIg0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IEl0IGxvb2tzIHRvIG1lIHRoZSBtZWNoYW5pc20gdGhhdCBpbnRy
b2R1Y2VkIGluIHRoZSBzZXJpZXMgaXMNCj4gPiA+ID4gPiA+IG5vdCBmb3IgcHJvdmlzaW9uaW5n
IGJ1dCBmb3IgcG9zdC1jcmVhdGlvbiBjb25maWd1cmF0aW9uPw0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IFRoZSBkaWZmZXJlbmNlIGlzIHN1YnRsZS4gSW4gYm90aCBjYXNlcyB5
b3UgcHJvdmlkZSBjb25maWd1cmF0aW9uLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEkgbXVzdCBiZSBtaXN1bmRlcnN0YW5k
aW5nIHlvdXIgY29tbWVudCBhYm91dCBldGh0b29sLg0KPiA+ID4gPiA+ID4gPiBDYW4geW91IHBs
ZWFzZSBleHBsYWluPw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJIGd1
ZXNzIHRoZSBtZWFuaW5nIGlzIHRoYXQsIGlmIHRoZSB2RFBBIGlzIGFzc2lnbmVkIHRvIGd1ZXN0
LA0KPiA+ID4gPiA+ID4gaXQncyB0aGUgY2hhcmdlIG9mIGd1ZXN0IHRvIGNvbmZpZ3VyZSB0aGUg
TVRVL01BQy9SU1MgdmlhIHRoZQ0KPiA+ID4gPiA+ID4gZXhpc3RpbmcgbWFuYWdlbWVudCBpbnRl
cmZhY2UgbGlrZSBldGh0b29sL2lwcm91dGUyIG5ldGxpbmsNCj4gPiA+ID4gPiA+IHByb3RvY29s
LiBUaGUgY29udHJvbCB2aXJ0cXVldWUgaXMgZGVzaWduZWQgZm9yIHRoaXMuDQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSB3YXMgdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCB3
ZSB3YW50IHNvbWVob3cgdG8gY29udHJvbCB0aGUNCj4gPiA+ID4gPiBjYXBhYmxpdHkgaWYgdGhl
IGd1ZXN0IHRvIHVzZSBhcmJpdHJhcnkgTUFDIGFkZHJlc3Nlcy4NCj4gPiA+ID4gPiBJZiB0aGlz
IGlzIGlzIG5vdCByZXF1aXJlZCB0aGFuIEkgdGhpbmsgY29udHJvbCBWUSBpcyB0aGUgbWVjaGFu
aXNtIHRvDQo+IHVzZS4NCj4gPiA+ID4gSG93IGRvZXMgdGhlIGd1ZXN0IFZNIGlkZW50aWZ5IHdo
aWNoIHVuaXF1ZSBtYWMgYWRkcmVzcyB0byBzZXQgb24NCj4gPiA+ID4gdGhpcw0KPiA+ID4gdmly
dGlvIG5ldCBkZXZpY2Ugd2hlbiB0aGlzIGlzIHRoZSBvbmx5IGRldmljZSBpbiB0aGUgVk0/DQo+
ID4gPiA+IFVzdWFsbHkgaHlwZXJ2aXNvciBrbm93cyB3aGF0IG1hYyB0byBzZXQgZm9yIGEgVk0u
DQo+ID4gPg0KPiA+ID4gWW91IGRvbid0IG5lZWQgdG8ga25vdy4gWW91IGNvdWxkIHVzZSBhbnkg
TUFDIHlvdSB3YW50LCBpZiBubyBvbmUNCj4gPiA+IGVsc2UgaXMgdXNpbmcgaXQgaW4geW91ciBz
dWJuZXQsIGFuZCBldmVyeXRoaW5nIHdpbGwgd29yayBmaW5lLiBUaGUNCj4gPiA+IHBvaW50IGlz
IGRvIHlvdSB3YW50IHRvIGFsbG93IHRoZSBndWVzdCB0byBjaG9vc2UgaXRzIE1BQy4gVGhpcyBo
YXMNCj4gaW1wbGljYXRpb25zIG9mIHNlY3VyaXR5Lg0KPiA+ID4NCj4gPiBMZXRzIGFzc3VtZSBm
b3IgYSBtb21lbnQgdGhhdCBhIGd1ZXN0IFZNIGlzIGFibGUgdG8gcHJvZ3JhbSBhIE1BQyBvZg0K
PiBuZXRkZXZpY2Ugb2YgdmlydGlvX2RldmljZSBvZiBuZXQgdHlwZS4NCj4gPiBIb3cgZG9lcyBh
IFZNIGtub3cgdGhhdCBhIHJhbmRvbWx5IGNob3NlbiBtYWMgaXMgbm90IHVzZWQgaW4gbmV0d29y
aw0KPiB3aGVuIHRoaXMgVk0gZG9lc27igJl0IGhhdmUgYW55IGV4dGVybmFsIGNvbm5lY3Rpdml0
eT8NCj4gDQo+IFRoZXJlJ3Mgbm8gZ3VyYW50ZWUgDQpIZW5jZSBhIFZGIHVzZXJzLCByZWxpZXMg
b24gdGhlIGh5cGVydmlzb3IgdG8gc2V0dXAgYSB1bmlxdWUgTUFDIGluIHRoZSBuZXR3b3JrLg0K
DQpBbmQgYWR2YW5jZSBndWVzdCBWTSB3aG8gaGFzIGEgZGV2aWNlIGNhcGFibGUgdG8gbW9kaWZ5
IHRoZSBNQUMgKGZvciBib25kaW5nIGFuZCBvdGhlciB1c2UpIGNhbiBvdmVycmlkZSB0aGUgbWFj
Lg0KDQpTbyBJIGRvbuKAmXQgc2VlIHRoZW0gYXMgbXV0dWFsbHkgZXhjbHVzaXZlIGNhcGFiaWxp
dHkuDQoNCj4gYnV0IGl0J3MgYmVpbmcgdXNlZCBhbGwgb3ZlciBhbmQgTGludXggaGFzIGEgc3Bl
Y2lmaWMgQVBJIHRvDQo+IGdlbmVyYXRlIHJhbmRvbSBNQUMgYWRkcmVzc2VzOiBldGhfaHdfYWRk
cl9yYW5kb20oKS4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
