Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C75C11F66
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 09:49:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D1461DAD
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 09:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D1461DAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0EC68401D1;
	Tue, 29 Jun 2021 09:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o-pqm4r7HFDR; Tue, 29 Jun 2021 09:49:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8E26440117;
	Tue, 29 Jun 2021 09:49:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35C1DC001A;
	Tue, 29 Jun 2021 09:49:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77ED4C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 09:49:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 527AE4011D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 09:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ECBmSMhX7jwJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 09:49:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::608])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D30540117
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 09:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yao+x/0MVE8gM3OZEMA8nSdzyq52iJJYve5sviETtVSuGawfQEb72pq2Wop9SMlwnRfIaosQyUeV1H5kXEs1QSLnrkcm6RcVwGb65MzmZoX6ARXtVE0ItgJVe1v5PHZxbjFK8Q8DcwQScre0Ff9iPwx32IEx7wVCmaANFiD+IzKlABGQgN2q+DbuCXqGh1CHr7mO/0WRns0ZN0a42RZ6EJUp3+UprevINy90hzqV8pd6jBWrT+JlypA9lPdelVR3Zlh5ea9ai+CjNNdTIRMJVgGpDl6v8dUS5Ha6YgLE9Vose6yCxB2qL3jGAR7Wj9Dw/59Uru33etQpOkP8vF2y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDJMnrGO+TObor5IeX6niJiuRKwcwQ/4WRw5RfTeNFE=;
 b=KRm9d+EEl/Mn5cU+3+bMVvwGagGUfBV8F7YAfw/WgQ2NOexsciHSEVZJqALt+tf2Z0Sb4x3I8HPwYiiJvsNZUlEehTOYmw49SnVx17j9Hmpcl1t4xKuY+yvfIFV5RA4D+ur3r4undAoDxuVI7X2XzF7V7RszM/EPVX7vgVNGj02CY5i3XqqXLBcC+CCPVCOZu0f/tm066I1kFC1G0mZOqsZYNfl6nHDZsEFEwwxnBXQ6n/B4Qr7zhmHGZSkIPqc1TdmOTucGpMRcU3qPOmK0JXw/l/FK2rGDtfaQUDUP2ROYkXjBdnYsFJWr9yMLw7lpO19sv2yS7YcHiyb0rBe11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDJMnrGO+TObor5IeX6niJiuRKwcwQ/4WRw5RfTeNFE=;
 b=ZYbVnGYAykkU1+kCT/iJyoXJrvv6TAYGIXk9RxSUCpT25TB+N7uFpZm6FS9Q8m0dJW1A4h6b8YTqLp5C/sYAP56gKTjVmqp60bFoPehcNQ9rBXNUrF+J7VjrG1DcyuaLt2IxcBKHp7VuvEe712pzhyGAYgB36mr3EGH+QY9JPlgrvRbl7hM5si+iMiOhIz0ni0+cJzxxE27nkD/gdJ+5RbiOpvoOhQFGrhhOoFueNhCiH8MNvGAyeNnZykhBoSGBkUoY4KKWlbmSrtrH/MDjLhXeEG0zMC/d1+fBzhL4Q8mbKULL5RedEyoLiIrV8cu4EiBHWRYsS+zeAJrbn+LT0w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 09:49:21 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb%7]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 09:49:21 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KCAAO8RAIAAAJPAgAGsGACAAAPf8IAAEweAgAAIirCAAU1RAIAAMiFQgASfUwCAAF8F0IABH3+AgABhb2A=
Date: Tue, 29 Jun 2021 09:49:21 +0000
Message-ID: <PH0PR12MB548115ACBDA9D76526C370B3DC029@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
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
In-Reply-To: <bf6ec662-b53d-174f-53e2-735589f83d3d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cda7635e-59af-413b-780a-08d93ae32b87
x-ms-traffictypediagnostic: PH0PR12MB5498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5498D8DDDCC24B6E9A75A25ADC029@PH0PR12MB5498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IF0DuKSIDjuOsWx1DURtrLajxxVJnVNeMWLHu/E1Wtp7eBwjhZLRa3q5uifPfDFr10q1IkT8FZJwxj1P89ZxAbT/+vutvh5yU0lwFB+U+a2brquFibhQrHwSs6txzjfDnMv9t866P4r5Hd8+Ci8k2g/RA4VT7XFNFrcve0PcEqkM85XFdTasdJpxiz/NptxUXbvGq4WLtWOtFJLxXax7uytrHazyTY6CAJ02rxIdyUMnDnGi4wDUKgyM8rClLNqOcr+70pNggHQ5CCsQbhruW1RPdqyraQVhFP00YS4liKULObGkkMU+LVF64yECaZGDMDEthi9gyZtLvbFEBuB0zyc/EBBUUiGPT51CXYwigkGm4zOv64Nn0t+IzHw5DmKi7uqRDW7hR+em9SbqNHJWvggQe2aAqk/1P/rM9+vKCxlAZWtbiX9O6JYFpQkwtq7o+qMVHiw/y1QKiaL13raS3GzuJmuqPot+8oXzsgQSFsfW1OvUzfB3ulbHA31M8mYlUL2DFA/VFMlC2xOU0dC6ogKK/FvybpLXME81DJTug8Rkb0gdJSIMWqYRHlHAtZq/ISlMpoRMfZJN5ZoJvsZlihzrJGb1TPsDioPutEDGORWRgl4U91JNG7Fwlz+gkotWTXecaRLTqfE+a93m6NYgA8XhZWSkjjfyUYnmlqc0YBlZaj7jZFd52I7YXJbqe84DaY2chasqg3fvDLVomJTkdQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(83380400001)(8936002)(9686003)(86362001)(33656002)(55016002)(66946007)(8676002)(122000001)(66476007)(5660300002)(478600001)(54906003)(71200400001)(316002)(26005)(52536014)(186003)(7696005)(66556008)(110136005)(38100700002)(107886003)(76116006)(4326008)(66446008)(6506007)(64756008)(2906002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUh1SnQ4RzhiY1F5aWlxdWVOdFBEcHJBeVI4eEVwVS9GSTVqOHVLZWR4WEp5?=
 =?utf-8?B?UGtRWlJYSUhmYUFHWDVWU0xXUEZZWm1tcFNEM2txM05FTlI2cUE0TDJLRDlW?=
 =?utf-8?B?OGp5dUNURGVlYTY3dnpxM0J0UVoxZG5WNms4cUl2Q21KUnA1M0dKcVlKdWFY?=
 =?utf-8?B?MEU4Rm9hRE5ldzVBVFRGdkdvWlZ4Q2lINnVtdTh5REN3N01YNkJCVGZDVStV?=
 =?utf-8?B?KzlRRU9zOHh4K1o2dk1weWhxTHFMNWp6YVhjNXZmbytmajFCWk1iQ3ZONmZn?=
 =?utf-8?B?QXBCTjZiNVdLZHppWjhWZXRTcGlYcXZVZ0FTSDZITnNKUWVRb3ZtVzBCdEFO?=
 =?utf-8?B?TUpNQ2ZBZDA3d3cvY2FnVmpxbDhRbjRQVjZWTnloRE80WFo5RUx2ZGNnVVNt?=
 =?utf-8?B?YjdEVHdoUG03TkxkclhzR2RXaW1FTVl0VStISzhhaGVUWUpscDdpM2NXczFO?=
 =?utf-8?B?bnFCYkxWVHZrL2lySTJmWTNpaVFyd1M2TlpNMCthUTFPOUhCVmNlbUdrMlVq?=
 =?utf-8?B?VnNSZlZTdm9pcnFlSlJ1cnFVeXUvNFZuUm4vWWt5dVErVHpjUWtWY1huYjUz?=
 =?utf-8?B?L0lKajhqVFc2Y3pHM09vdE5zaG9WNXJyMVp1ZmZGcVc5QnZsL2w2TTJ4djNa?=
 =?utf-8?B?WFlQbDNXN05IV2MrMzdvOWVubHZnV2FPRDgzalRybW9KOERpTVRvYUlmV3pX?=
 =?utf-8?B?ckpjUUNDV1gyTUVIai9CZ1hmandPUHV3KzMxLzR5aDlYcHJubWw1NldnbG02?=
 =?utf-8?B?UUQxdzZQd3ZBZ3lTUWZzMTR0SGFOMGdPeXBxOFM0bHZLT29vUloyWDJuaDhq?=
 =?utf-8?B?RFBUVUZHYlkvUGdraHRuVWQxODdYRFpKQmFjMnFEbTNVb3R5N29NcUZ0bmlq?=
 =?utf-8?B?SEY5TXpIVUE5Z09obUJOTWZhcFR5eUM1eWFOcjhBenhPRmE3Ym9XQVV4WUdv?=
 =?utf-8?B?MzJjUEJhRnZYY1hLSmswK0FEL3liSk9OOXlsY24vTzhFMzYwclVkc0JBcWVK?=
 =?utf-8?B?Z3BiaGNncCtueWlLQUhORFUrdkxsM2RNN3JpSC9ZbUhDNGRqUDRSb0RoMlE5?=
 =?utf-8?B?SkdrRG5BZkk3VUlKazZwRjRjL0hFcUJPRUVzUUluSktRN0JuM05lY0hBWStt?=
 =?utf-8?B?c0dyL3J6dkJtQVZmL3BnUUZiUWRRTEJYaUdodzhkSjV2LzR0QjhudUhoRDl0?=
 =?utf-8?B?TzB6UlYxNWFIUXRmSFE4QWlaMlVmbnFiZllrV1JCOENlOHFIU0JiTlVsQkNx?=
 =?utf-8?B?SC94bTFsek9OenpNc0xSbmdRUHBKN1FKY01yN2RBME55Z1dWZnFHWGFKSklT?=
 =?utf-8?B?S3BaQVdvUW42R2lPZUVOaXdRd2tuSTMwdk54OTRoeGFIc2wxYm4wa0x3K3RL?=
 =?utf-8?B?Y3VXNFNqN2tyckhFZlZVd2hya2N3R0IyWkZQM2FjcDRjMTYrRUdmVkxydllM?=
 =?utf-8?B?S3NIODFvbVZ5Ky9NLzdWQ0hYVTMxb1F6emxKYnd4UTMxcjFNaHFLUmd6SWxG?=
 =?utf-8?B?dkFGVk45akpJcnpFMnpGdnIvSjdBUmF6NEZXRERjYVVDWmRNcHRJeFdlbDVJ?=
 =?utf-8?B?VDNHdCsrWTNkRHhqa3Y1SWpzNjRRZ1hBeHYwMmw4QTdTdWpkZXQ4UTQyQjVU?=
 =?utf-8?B?K3VuZkpTcWJSQjBhRFBaMzFIckZ1SWJHTEllYks5aDQ4L3VQRUJmNGI5dFhO?=
 =?utf-8?B?aW9PV1ZmT2xsTGhMTXVwaEJrcmlTMU8rN3BDNENJbVV0SGZ1TGNiSDZiREpI?=
 =?utf-8?Q?MsEE+x1oH0nXHE/rpUgMd7CPVwtGSl7+Du6QoRp?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda7635e-59af-413b-780a-08d93ae32b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 09:49:21.0796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjY/yh36k9pDBas8mWkky1QRAiOR2hINGvsJrUMqAW4HLKbw2TEITCWhrIMM127zyIXX/7eJkLSXNRjZhkbEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
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
U2VudDogVHVlc2RheSwgSnVuZSAyOSwgMjAyMSA5OjIyIEFNDQoNCg0KPiA+Pj4gUGFzcyB0aGUg
d2hvbGUgdmlydGlvX25ldF9jb25maWcgYW5kIGluZm9ybSB2aWEgc2lkZSBjaGFubmVsPw0KPiA+
Pg0KPiA+PiBUaGF0IGNvdWxkIGJlIGEgbWV0aG9kLg0KPiA+IEkgcHJlZmVyIHRoZSBtZXRob2Qg
dG8gcGFzcyBpbmRpdmlkdWFsIGZpZWxkcyB3aGljaCBoYXMgdGhlIGNsZWFuIGNvZGUNCj4gYXBw
cm9hY2ggYW5kIGZ1bGwgZmxleGliaWxpdHkuDQo+ID4gQ2xlYW4gY29kZSA9DQo+ID4gMS4gbm8g
dHlwZWNhc3RpbmcgYmFzZWQgb24gbGVuZ3RoDQo+ID4gMi4gc2VsZi1kZXNjcmliaW5nIGZpZWxk
cywgZG8gbm90IGRlcGVuZHMgb24gZmVhdHVyZSBiaXRzIHBhcnNpbmcgMy4NCj4gPiBwcm9vZiBh
Z2FpbnN0IHN0cnVjdHVyZSBzaXplIGluY3JlYXNlcyBpbiBmdWxseSBiYWNrd2FyZC9mb3J3YXJk
DQo+ID4gY29tcGF0aWJpbGl0eSB3aXRob3V0IGNvZGUgY2hhbmdlcw0KPiANCj4gDQo+IFNvIEkg
dGhpbmsgSSBhZ3JlZS4gQnV0IEkgdGhpbmsgd2UnZCBiZXR0ZXIgdG8gdGhhdCBpbiB0aGUgdmly
aXRvIHVBUEkNCj4gKGluY2x1ZGUvdWFwaS9saW51eC92aXJpdG9feHh4LmgpDQo+IA0KDQpbLi5d
DQoNCj4gDQo+IEkgdGhpbmsgbWF5YmUgd2UgY2FuIHN0YXJ0IGZyb20gaW52ZW50aW5nIG5ldyB2
aXJ0aW8gdUFQSSBhbmQgc2VlIGlmIGl0DQo+IGhhcyBzb21lIGNvbnRyYWRpY3Qgd2l0aCBuZXRs
aW5rLiBPciBtYXliZSB5b3UgY2FuIGdpdmUgbWUgc29tZSBleGFtcGxlPw0KPiANCj4gDQoNCj4g
PiBJIGFtIHVuYWJsZSB0byBjb252aW5jZSBteSBzZWxmIHRvIGJ1aWxkIHNpZGUgYml0bWFzayBm
b3IgY29uZmlnIGZpZWxkcywgdHlwZQ0KPiBjYXN0aW5nIGNvZGUgaW4gc3Bpcml0IG9mIHVzaW5n
IGV4aXN0aW5nIHN0cnVjdHVyZSBVQVBJLg0KPiA+IFRoaXMgY3JlYXRlcyBtZXNzeSBjb2RlIGZv
ciBmdXR1cmUuDQo+IA0KPiANCj4gSnVzdCBhIHF1aWNrIHRob3VnaHQsIGhvdyBhYm91dCBzaW1w
bHkgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWdfYnVpbGQg
ew0KPiAgwqDCoMKgwqDCoMKgwqAgX191OCBtYWNbRVRIX0FMRU5dOw0KPiAgwqDCoMKgwqDCoMKg
wqAgX192aXJ0aW8xNiBtYXhfdmlydHF1ZXVlX3BhaXJzOw0KPiAgwqDCoMKgIMKgwqDCoCBfX3Zp
cnRpbzE2IHJlc2VydmVkWzNdOw0KPiB9Ow0KSW4gdGhpcyBzdHJ1Y3R1cmUgd2UgbmVlZCB0byBh
ZGQgYmkgZmllbGQgZmxhZ3MgdG8gaW5kaWNhdGUgd2hpY2ggZW50cnkgaXMgdmFsaWQuDQpBbmQg
d2hlbiBzdHJ1Y3R1cmUgbGF5b3V0IGNoYW5nZXMsIHdlIGVuZCB1cCB3aXRoIHNpbWlsYXIgdHlw
ZWNhc3QgaXNzdWVzLCBsZW5ndGggY2hlY2tzIGFuZCBtb3JlLg0KTW9zdCBvZiBpdCBpcyBpbmJ1
aWxkIHRvIHRoZSBuZXRsaW5rLg0KDQpTbyBJIHByb3Bvc2UsDQooYSkgd2UgcGFzcyBjb25maWcg
cGFyYW1ldGVycyBkdXJpbmcgdmRwYSBkZXZpY2UgY3JlYXRlDQokIHZkcGEgZGV2IGFkZCBuYW1l
IGZvbyBtZ210ZGV2IHBjaS8wMDAwOjAzOjAwLjQgbWFjIDAwOjExOjIyOjMzOjQ0OjU1IG1heHEg
MTANCg0KVGhpcyByZXN1bHRzIGluIGFkZGluZyB0d28gb25lbmV3IG5ldGxpbmsgb3B0aW9uYWwg
YXR0cmlidXRlcyBhcyBWRFBBX0RFVl9ORVRfTUFDLg0KVkRQQV9BVFRSX0RFVl9NQVhfVlFfU0la
RSBpcyBhbHJlYWR5IGRmaW5lZCBmb3IgbWF4IHF1ZXVlcy4NCk5MQV9QT0xJQ1lfRVRIX0FERFIg
dGFrZXMgY2FyZSB0byB2YWxpZGF0ZSBsZW5ndGggc2l6ZSB3aGVuIHBhc3NlZC4NCg0KPiBJdCBs
b29rcyB0byB3ZSBkb24ndCBuZWVkIHRoZSByZXN0IG9mIGZpZWxkcyBpbiB0aGUgdmlydGlvX25l
dF9jb25maWcgdG8NCj4gYnVpbGQgdGhlIGNvbmZpZyBzaW5jZSB0aGV5IGFyZSBhbGwgaGFyZHdh
cmUgYXR0cmlidXRlcy4NClRvZGF5IGl0IGlzIG9ubHkgbWFjIGFuZCBtYXggcXVldWVzLiBMYXRl
ciBvbiB3ZSBtYXkgbmVlZCB0byBkZWZpbmUgcnNzIGhhc2hpbmcgYXMgaHcvZGV2aWNlIGFkdmFu
Y2VzLg0KQW5kIHN0cnVjdHVyZSBzaXplIHdpbGwgY2hhbmdlLg0KSGVuY2UsIEkgcHJvcG9zZSB0
byBoYXZlIGVhY2ggYXMgaW5kaXZpZHVhbCBhdHRyaWJ1dGUgdGhhdCBkb2VzbuKAmXQgbmVlZCB0
byBjYXN0IGluIHN0cnVjdC4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
