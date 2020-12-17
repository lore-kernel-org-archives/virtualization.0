Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386CC4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 18:06:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640102376F
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 18:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640102376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F216387A80;
	Thu, 17 Dec 2020 18:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q3vewX6ZP8Po; Thu, 17 Dec 2020 18:05:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 13C6A87A54;
	Thu, 17 Dec 2020 18:05:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E39EAC0893;
	Thu, 17 Dec 2020 18:05:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A0B7C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 18:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8B7C9878F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 18:05:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R6G2vTLxn5Km
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 18:05:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 12309878D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 18:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnPV0qHQViHocVwUovOb6ALtnD3MfSfKcIDXj1rh/f45p6n1hp6geZ5YnT38X7Iy8flsIOAw1aD3F6HExOpUltcyGuSPHAeZNcEZ03VppHJFvGi0QXivse5mRUweGRv3yJWc+/STEN5bt0ERalNgdg+9fZSYe5CjGP+jHlqjr15PBMopL8DCUuBarLhS4efoH6xyxUcetcVaZaXgS2pteE+H02dL5hdf3jnh2cYnbFCQtOuZnba59cusze0gbQLOnUMHaTPtKxYEDVHhZ5dgyoTHBNViA0Y9N2QPtPlWoypU+pTH2ja4p+ZwNJ3QwDIEsfl0elUhKXPy1vRUTq6/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1X0y14Z3Rb/y1BANmwgOmVuuFPEaYvXelitZU1/Rr4=;
 b=goW/07kVFOm9C/li7YJWfGyuva6G8cvoJ8HyVc/BpLMB258m6GST2YpTbNu0yWRCr89NtDZJlQF62KUPXnjgOmAB8iHFTDXYucEx/Iw98/4Z4hUHLL+CEht4E72MJo8AWFIDIkR9XKN2knRKQYcIl80kQgweVt2P6pn6PcaEOpxXZjAhexhdFVHTCn0kH75hIH1CVb/U+EBaH8p/bJ93+TN3GiwWKwnj3D2fAYv2LpMVZ2NZCvrB9DlPB5MEO24OGPwMsSQecJTLe18kmcl7GQ2r8AXQ0f+f7jE19rsHD7SiW/EuAQe0lvJt8XN22p9ojpjHXdvG6QXGa6m1MgGYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1X0y14Z3Rb/y1BANmwgOmVuuFPEaYvXelitZU1/Rr4=;
 b=v+w+iYdWIfK6c3B+N04FrAHAYHbrWixqxE/8XY0j+XmTCpuaQW54Nn9IVGuUlSn9oPoCMYLpZ94ufJ9SPeSlSvCPoghn1NqfObNU0aNjih1+dmQ43WtKRmdXQCg61Nh1VAKh542KO6Kz4j/4BOpXSQZ40MA9GG0X8uQbrieDgJ4=
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4707.namprd12.prod.outlook.com (2603:10b6:208:8a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Thu, 17 Dec
 2020 18:05:53 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 18:05:53 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
Thread-Topic: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
Thread-Index: AQHW1J9CFu7l3N5+dkqfVzS6O8PO0w==
Date: Thu, 17 Dec 2020 18:05:52 +0000
Message-ID: <30a78131-e9bb-48df-9c46-7478cb4a51a0@email.android.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2a02:908:1252:fb60:7567:c9c1:66b3:9637]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b9c5b19-89e7-4ad6-8f7b-08d8a2b664c8
x-ms-traffictypediagnostic: BL0PR12MB4707:
x-microsoft-antispam-prvs: <BL0PR12MB4707542BCCB4B4613F94FA4B83C40@BL0PR12MB4707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lTCkP1xJyf5AR7+Kmh0vxHXmttQUmdGSn6QRwSikj4vp6RAMTWhhnzzgmXpCKKBCA1LUo811dYf0lqiTImz/ypQSStxv8+BJMrq/XbXNJ1dnE+7m8mTgykIYUmMcnSCxUNzJGXwxUuwgsSCjV241tTz5Rh4Zf8SJcZBLFbDhdgMWW0EmVGQZLt32aqa1AdhsSQKvrZ3oAuzqedEZCsll8/FSTqEW2h/Xo6rJ7SkKpSPk9Lxh05EUse3yWT3nbVrrTMtxRH/d7tUwqR2eboBZJbmXXfTKUH6GTUC3eiqHurbM9+Vx3nxwCyFNkvbtp3yIwgQwgNGSu8zUKu0YZ3Tdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(4744005)(66556008)(91956017)(9686003)(64756008)(66946007)(2906002)(31686004)(478600001)(66476007)(71200400001)(4001150100001)(86362001)(316002)(54906003)(5660300002)(66446008)(6512007)(8676002)(76116006)(4326008)(8936002)(6506007)(186003)(6916009)(6486002)(31696002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aDZTZzl5K1l2VC9iT0xyd2haM1J4aS93OGkzc0FoMm81M2haM0J5RjB0UXV6?=
 =?utf-8?B?WEpDbk5yV3ZxMTVqWVEwaDNqYVc3a0xRRVBlY1ZYN2NhRjRQeG1kbGdCRGZL?=
 =?utf-8?B?eVJDb2puT1dZZmRQVk9PWFpaVGZMeEdNOWY5YWV4RzBhNGRXRXBBQTh4ZjE3?=
 =?utf-8?B?ZGZERVFVMGwrZGkrSWl2RlBtUFp0VW9YTlJOMUZpSldmalJyZ0s3MHpPSzFz?=
 =?utf-8?B?ZUtHMmszV3RBbFdHUkRHUnFQdzlhR1A0aUNuWFVTSWR6dWxmQ1JQSFFyUVRh?=
 =?utf-8?B?RHBncnB3VFJ6VDAvS0JBaFpOQWN0K0d5eFVWR2daV0JGc2hOcGgzSTFuOXR4?=
 =?utf-8?B?MW9LT1F3anR6UCtLbEQ0TmdTMzI0WUJ1NmN4SFRpekVSMzNvVGZNRmxmWlY2?=
 =?utf-8?B?Wm5zVU5IWkpBN3dxTEFadUNFZWZuc202OHBmeWRPYTA2V3JkRSthMkJBbWZW?=
 =?utf-8?B?SjdRWS9vSExhb2Yzc1dyQlN3KzNLeDdlV0QzMTJGTDg2anJONmJCdXFnOTlT?=
 =?utf-8?B?bHduYnZmNjFiVU8wd0pEMUtZTWRUM0hnS09PdHBBUzBiU0k4YXZoeU9XRWtQ?=
 =?utf-8?B?Y2x0RXVEWUE4Vm5lZGpiM2cwY2llNzIrZ1pTclBQSk5WTkxVQlJsUFBhZ09a?=
 =?utf-8?B?U0krTkRpRi9Ta29UZE1iOC80dWpXN2VOUG1CUlRRVTdrdlJOZFYzbGZxMSt1?=
 =?utf-8?B?czBMMkVVd2xzbkQ3TkhPYUJRODlSYW05ZzlIeVpjb3NHRHc5TGQ2ZGFOdUxO?=
 =?utf-8?B?cHJjTnR2WmREVTB2OThRbytwdFJ4YWtCMzFFNm1LSWk1b1NDUDRSbXlPdmdu?=
 =?utf-8?B?ZGJBM3Yyc2gzL1NTOVJMdVZnMER1eERUQzhLeitMUHZySVcyak9ycXFPMU10?=
 =?utf-8?B?QWpzT2x6QTNvcXNmSjZENlNtdTV3V1BvanFGWTNIbVdyU0RJVkJpT2RSbmpi?=
 =?utf-8?B?VDBWU1NGOEdudlp4eVhNT2hNV3VQYWFUcHBPSzJVYUtzR1R2VTQzMGlVKzNX?=
 =?utf-8?B?UzdCVXdsM3llaG1YZVNaZGlkNjVGY1JpemRrcG9CQjE3WmRQNFpqR0RYYW9N?=
 =?utf-8?B?YzVjOWg0TmwrQ0IwSVZmeUpkMzB0YUhVd0FqMVo3TlNobzlDVk1Mc1NQdVdp?=
 =?utf-8?B?OU5pRm9VYzlwV29EeFpKWXBiRFVzUWlQSldvRnBVT0d0cER2WWF4SGg1TWVR?=
 =?utf-8?B?NmVuTU1RNytFUVFyaEFkeTB3OTFQRWFvWmE5QzFlUzdLYW1nT0oxN0x4U2Zt?=
 =?utf-8?B?OWF1S0Vzc2xkOHA4TEdhK1hLSmovcUhvdm95dFNFNjFKRXQ5VmVMVy9abDFy?=
 =?utf-8?B?cXhZMzJnK0ZXLzJLU3NEOVdycTRQVUMxc0N5V3pucUJQUEdrRFhSdG84Y3RB?=
 =?utf-8?B?V0tNVWZiUzFWQ3hwcTNXdTdJaHlLNXZKUjlINkpFS2F3K2RwWWJMajNSM2t6?=
 =?utf-8?Q?ApTu2ivP?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9c5b19-89e7-4ad6-8f7b-08d8a2b664c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 18:05:52.9689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekk7LwE8NzyKZNuX91iasV8LTNeNoGItWVkJrUqGF7Eg37QBhnbkyGvikB8Og8O+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4707
Cc: Dave Airlie <airlied@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
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
Content-Type: multipart/mixed; boundary="===============8734516783512914561=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8734516783512914561==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_30a78131e9bb48df9c467478cb4a51a0emailandroidcom_"

--_000_30a78131e9bb48df9c467478cb4a51a0emailandroidcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

UGxlYXNlIHRlc3QgaXQgYSBiaXQuDQoNCkkgZG9uJ3Qga25vdyB0aGUgcXhsIGNvZGUgYXQgYWxs
LCBidXQgaXQgbG9va3MgbGlrZSB0aGUgZG1hIGFkZHJlc3MgYXJyYXkgaXMganVzdCBzdXBlcmZs
dW91cy4NCg0KQ2hyaXN0aWFuLg0KDQpBbSAxNy4xMi4yMDIwIDE3OjU1IHNjaHJpZWIgTWlrZSBH
YWxicmFpdGggPGVmYXVsdEBnbXguZGU+Og0KT24gVGh1LCAyMDIwLTEyLTE3IGF0IDE3OjM4ICsw
MTAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPg0KPiBNaWtlIGNhbiB5b3UgdGVzdCB0aGUg
YXR0YWNoZWQgcGF0Y2g/DQoNCll1cCwgb25lLWxpbmVyIG1hZGUgaXQgYWxsIGJldHRlci4gVGhh
dCB3YXMgcXVpY2sgbGlrZSBidW5ueS4NCg0KICAgICAgICAtTWlrZQ0KDQoNCg==

--_000_30a78131e9bb48df9c467478cb4a51a0emailandroidcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <C919C0A7A5799947A0A7BDC0EA272150@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdiBkaXI9ImF1
dG8iPg0KPGRpdj5QbGVhc2UgdGVzdCBpdCBhIGJpdC48L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj48
YnI+DQo8L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj5JIGRvbid0IGtub3cgdGhlIHF4bCBjb2RlIGF0
IGFsbCwgYnV0IGl0IGxvb2tzIGxpa2UgdGhlIGRtYSBhZGRyZXNzIGFycmF5IGlzIGp1c3Qgc3Vw
ZXJmbHVvdXMuPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+PGJyPg0KPC9kaXY+DQo8ZGl2IGRpcj0i
YXV0byI+Q2hyaXN0aWFuLjxicj4NCjxkaXYgZGlyPSJhdXRvIj48YnI+DQo8ZGl2IGNsYXNzPSJl
bGlkZWQtdGV4dCI+QW0gMTcuMTIuMjAyMCAxNzo1NSBzY2hyaWViIE1pa2UgR2FsYnJhaXRoICZs
dDtlZmF1bHRAZ214LmRlJmd0Ozo8YnIgdHlwZT0iYXR0cmlidXRpb24iPg0KPGJsb2NrcXVvdGUg
c3R5bGU9Im1hcmdpbjowIDAgMCAwLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij4NCjxkaXY+PGZvbnQgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZToxMXB0Ij4NCjxkaXY+T24gVGh1LCAyMDIwLTEyLTE3IGF0IDE3OjM4ICswMTAwLCBDaHJpc3Rp
YW4gS8O2bmlnIHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7IE1pa2UgY2FuIHlvdSB0ZXN0IHRo
ZSBhdHRhY2hlZCBwYXRjaD88YnI+DQo8YnI+DQpZdXAsIG9uZS1saW5lciBtYWRlIGl0IGFsbCBi
ZXR0ZXIuIFRoYXQgd2FzIHF1aWNrIGxpa2UgYnVubnkuPGJyPg0KPGJyPg0KJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IC1NaWtlPGJyPg0KPGJyPg0KPC9kaXY+DQo8
L3NwYW4+PC9mb250PjwvZGl2Pg0KPC9ibG9ja3F1b3RlPg0KPC9kaXY+DQo8YnI+DQo8L2Rpdj4N
CjwvZGl2Pg0KPC9kaXY+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_30a78131e9bb48df9c467478cb4a51a0emailandroidcom_--

--===============8734516783512914561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8734516783512914561==--
