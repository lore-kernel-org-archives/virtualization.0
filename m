Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A376C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:21:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F78E207CF
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 03:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F78E207CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EAE5685815;
	Wed, 20 Jan 2021 03:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DuYl_W1i2_23; Wed, 20 Jan 2021 03:21:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 604FC85650;
	Wed, 20 Jan 2021 03:21:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FFC9C088B;
	Wed, 20 Jan 2021 03:21:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5F48C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C46BA866EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:21:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cjpfIanBSKDk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:21:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EFB5385D21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:21:48 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6007a1cc0000>; Tue, 19 Jan 2021 19:21:48 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 03:21:47 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server
 (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 03:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OISlGYvNN4STlHXnejD7CBXuRkoEtpzGZs9md4n+NyQ44au31D1oADRGyasaiCcEWqYYpTR9Xvs6qyopWdPQL3yH+qP601yRTCMTgVMKO1FCKjZ3L62H5uaHJ0cpyepsLG4YUDOBCI4pZSeUPcny/+aBuMJnVMqPKtw7sM1ePpPlQak1R1saRLUCfXYMiOmvolCLIx4y42VLscecLGnV3rWz45fXFTmrlaNiVEFGtFuhk8QVY47Cn7EB//Vn8H9EqukLab5g5ytPXiqeG8Y0NDJ1sf51KTmREiLp6pbGtmffKVvE04XmWZXOZEmqRNXX0rlzP3KSBivnuoCpUU76lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXHQdbLTkrGDIqmJoAjUGCt9FBBoh/ATzyPx+YnlvE0=;
 b=jnVXKIKVtFREKNv/EEUPy3sGtqVDYn/hVEJriWQOQ47gEmXzSzvD8hb7yWKPrlh6hbnqMXkicsT9yPm7r37JbFXWxWfWCwW/fkTk+ctbZyqXUdkJcPogqSv4WmO/a8CZlKDYiz9q14CMAjaYpqSLX+P3FImWQ+JWTzTuFbWgBXsAUP60RjQf5R/Lg0uH4cJR+bxCTC3wPBAHPv2UOYRHB0ut26NLvjArVDTh1dmPT//t31tWqQ92ndkJhKXq7STmkpB36UK2g8UEp/NWG1e2ag9WsBW7lZVAz9Mh67eqYItXL18elSpb86qijZl6bRlR0ABeWNf5w1lyTNUFLIrU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3621.namprd12.prod.outlook.com (2603:10b6:a03:db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 03:21:46 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%5]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 03:21:46 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Topic: [PATCH linux-next v3 6/6] vdpa_sim_net: Add support for user
 supported devices
Thread-Index: AQHW404ZeuD1Nrf6EkKQQnhYNrY/9qoY6uQAgAAB4oCAAAVhgIAAAsjwgAAQXACAAoNJoIALCUSAgAAyM0CAAXa1gIAADQPggAaYp4CAAQ5YIA==
Date: Wed, 20 Jan 2021 03:21:46 +0000
Message-ID: <BY5PR12MB4322C4FE356BDAEDD91E3917DCA20@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-7-parav@nvidia.com>
 <20210105064707-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322E5E7CA71CB2EE0577706DCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105071101-mutt-send-email-mst@kernel.org>
 <BY5PR12MB432235169D805760EC0CF7CEDCD10@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210105082243-mutt-send-email-mst@kernel.org>
 <BY5PR12MB4322EC8D0AD648063C607E17DCAF0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <66dc44ac-52da-eaba-3f5e-69254e42d75b@redhat.com>
 <BY5PR12MB43225D83EA46004E3AF50D3ADCA80@BY5PR12MB4322.namprd12.prod.outlook.com>
 <01213588-d4af-820a-bcf8-c28b8a80c346@redhat.com>
 <BY5PR12MB4322309C33E4871C11535F3CDCA70@BY5PR12MB4322.namprd12.prod.outlook.com>
 <8bc2cf97-3ee4-797a-0ffb-1528b7ce350f@redhat.com>
In-Reply-To: <8bc2cf97-3ee4-797a-0ffb-1528b7ce350f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 389d551a-738e-45f5-f056-08d8bcf2846a
x-ms-traffictypediagnostic: BYAPR12MB3621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB36212A6BE157D59BA217185CDCA20@BYAPR12MB3621.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hV79w7XTPduvWj7sVvDGb9Ct/UHHawt1JvBULbmaDG/x0pfItCUxQ6M0k6A/boTuxn+wkW1uPMZtTacUAxlJ5xFNFW/vs05W0vSkVE8fhyeI3P0gHhGd0lqdJH0LFPkp+P/4v1n4tF1hg9yy/q6fgfRinw7f3QCcKOLTQMZx5KOR9bALpdLsRzm0vL4qrsMXhaJtyqUEDqrSh1OhpvNds54qms6V4+J+fzG0YjdkHKSgNHz8+UeLy1aW53ANsXni42dYnl48fgXdT4X6bekA+UC7wgIXemhIz4urnrOPoHEvxcszSF4Is8gH8oOyy0ueKgOxuiCtOt+IIWVrnG5n71/H8BP70Z4oyeyNWJJ0MYRsTteszdK2jS4WCc6yUL1h6fdx6LufgljwZI4hUEmiug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(54906003)(2906002)(6506007)(316002)(8676002)(53546011)(64756008)(66446008)(76116006)(110136005)(7696005)(8936002)(52536014)(86362001)(66556008)(5660300002)(66476007)(71200400001)(33656002)(26005)(55016002)(4326008)(9686003)(478600001)(66946007)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?S0NhYXFKVEd3NkR1cjRRVTlwU2JCR1BPS20xRlhFMDRDMy9LWjd2SXRWcmRE?=
 =?utf-8?B?aUxMOUxaNmlzd2NpR25wM3VCUFc0WGpHUjlEektBcVRPdWJvbS8vVkFIV01G?=
 =?utf-8?B?M3MrUW1UQnF4ci96SjBjeWxJb0QwcHhHYmlsK1JNTUNJS0J6clV1c2plVWhT?=
 =?utf-8?B?aXJiWE9NNDVZaTYrV2FhWm8wcGYrS0FlMmVwblcxSmM2RDk3elJXUVRQbjZ3?=
 =?utf-8?B?WXo2ZGdUOUV4V01Oci9PMElyNll2M2dKamh0YlY5YzBNeUFtM0dPcEFtV0tm?=
 =?utf-8?B?ZzFuVFF2ZnZjSmJWT244aDNtVkY1em9tVmpwcGd5MDB1THBRaGRZNzh2b2xy?=
 =?utf-8?B?LzJPWk1tdXlrekIvRjNrenNtcEdJTEphZkhGS0d0cnJqUlNxdW1uV0pOVi8r?=
 =?utf-8?B?NmtZOUp2TUFXUlhESFZ5VVIzTEs0TlFzbmlTTXVpa2JMNmNCNDVRRkdGUk90?=
 =?utf-8?B?MGtqbHJTeXNkcTFqYnM5RkxKY293R0V2c04rWHl3K3BaMWZpbmdXRkFCRXNm?=
 =?utf-8?B?akh5cFAxLzdseStBQWtaZjc5Q09uYTFOeWxCSUxRZjB4YkpMa3VZcjdrWHlZ?=
 =?utf-8?B?YnpYeWxtQ0drRHNWKzdiV3Y3ME1Hc3RnOHN1YktUUHB4U2xmMWRqSEovanRQ?=
 =?utf-8?B?MFZ6TmVLaERBN1RqYlhhaDBtM1BBOHdVdXo3TVdPSlRLeEYxMThIenl3QllU?=
 =?utf-8?B?YTVEU1BFa2Z1bER4NmswbXB5Tkx6akg4TFVSWEowWU82U2ZVMCtRS0FnajFS?=
 =?utf-8?B?UlpVejZwMmRvekFjWGo1R09sTGNFMkJBWkJDdnpyS2RxZ3B0b3RTTUtrMkhp?=
 =?utf-8?B?UlhScFkxVCswa01uU2lwYis1eFBEc1pBa0NJTDUyYTkzNmpXMnJTOUk3ajlu?=
 =?utf-8?B?c203TW1XSUZ2RDhXRHd3OTNKQWdybXVUa3IyenVtTEIvNWVKZ3dPZDdkcTcx?=
 =?utf-8?B?OExqTlJoMXdITitxMUptakJUT1BMVjdONnFZK1pza2QwYzJMQnRVUHFDY2JW?=
 =?utf-8?B?S1Z2VUZEK215SjZFRk9maWcyWjZyZHJwdVI3OUpxZit0eFBnRHF0MFdtWFFB?=
 =?utf-8?B?NnpwZGZESmpBZWU0R3FVODBnSjhSTk1VLzRFQlpoMjdkVDk5RzhCanRwOWlx?=
 =?utf-8?B?RDV2eHB0cVBNVUlDN2dQRXVlVGV5dTZUc2puZUtEVi9RNEJKQ0ZXOHlYVlE0?=
 =?utf-8?B?d2hJb1VFQkk3MVhtNzRxR2xJdXhaV0E4SVU0WkRET29HMUVyL0JsaVQraVh0?=
 =?utf-8?B?VGo5Z21OUm9naUhrOWtwQytqd2pXV2doT25SNU5DNEI4N3VqejRLWEI2eVZ2?=
 =?utf-8?Q?MTkHA97IQMbCs=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389d551a-738e-45f5-f056-08d8bcf2846a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 03:21:46.2085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7vi//M3AbPsRrnlKMNNWGyDsjLUI3V3APoT3z4EWBTqUm+FiOmpDiNYNzNzEsDK/WDIWXsjqaQbwffwghPd7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3621
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611112908; bh=BXHQdbLTkrGDIqmJoAjUGCt9FBBoh/ATzyPx+YnlvE0=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=pDFgyq2iv95iEKfEK+l7DGDbmwERza/VVc9P8yxfntvqJ9A9JvJTio+ZLI4Rw4jXK
 5OP2BGscBhXMgjxW6bJIrOg0xE0HwZhXXUY7gUxDxpA/mAWXP4iiyGLSKHVcrr3A9V
 cazjs1ScLzokf5o52+CL3eEpsd+NcSp+hcViJtKbbBCTbe0a878xjAq96Ml2qFgZv+
 IhVWa5UL/CT9WKApkmfEkQkdqdFvvz14BR+3C3zrODzl+6OiTmrQvIhd1+esVrGw4d
 1YV+C0zYkb6Ftt8ZtZg6N9tdv4/kVBAax4PKd1G1jA7bj2iuQFg0cxeWGCZxZIFZ1k
 O8ULW3+16flTg==
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, Sean Mooney <smooney@redhat.com>,
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

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBKYW51YXJ5IDE5LCAyMDIxIDQ6MzkgUE0NCj4gVG86IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZp
ZGlhLmNvbT47IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IENjOiB2aXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgRWxpIENvaGVuIDxlbGljQG52
aWRpYS5jb20+Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBTZWFuIE1vb25leSA8c21vb25l
eUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGxpbnV4LW5leHQgdjMgNi82XSB2
ZHBhX3NpbV9uZXQ6IEFkZCBzdXBwb3J0IGZvciB1c2VyDQo+IHN1cHBvcnRlZCBkZXZpY2VzDQo+
IA0KPiANCj4gT24gMjAyMS8xLzE1IOS4i+WNiDI6MjcsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4g
Pj4+IFdpdGggdGhhdCBtYWMsIG10dSBhcyBvcHRpb25hbCBpbnB1dCBmaWVsZHMgcHJvdmlkZSB0
aGUgbmVjZXNzYXJ5DQo+ID4+PiBmbGV4aWJpbGl0eQ0KPiA+PiBmb3IgZGlmZmVyZW50IHN0YWNr
cyB0byB0YWtlIGFwcHJvcHJpYXRlIHNoYXBlIGFzIHRoZXkgZGVzaXJlLg0KPiA+Pg0KPiA+Pg0K
PiA+PiBUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBJIHRoaW5rIHdlJ2QgYmV0dGVyIGRv
Y3VtZW50IHRoZSBhYm92ZQ0KPiA+PiBpbiB0aGUgcGF0Y2ggdGhhdCBpbnRyb2R1Y2VzIHRoZSBt
YWMgc2V0dGluZyBmcm9tIG1hbmFnZW1lbnQgQVBJLg0KPiA+IFllcy4gV2lsbCBkby4NCj4gPiBU
aGFua3MuDQo+IA0KPiANCj4gQWRkaW5nIFNlYW4uDQo+IA0KPiBSZWdhcmRpbmcgdG8gbWFjIGFk
ZHJlc3Mgc2V0dGluZy4gRG8gd2UgcGxhbiB0byBhbGxvdyB0byBtb2RpZnkgbWFjDQo+IGFkZHJl
c3MgYWZ0ZXIgdGhlIGNyZWF0aW9uPyBJdCBsb29rcyBsaWtlIE9wZW5zdGFjayB3YW50cyB0aGlz
Lg0KPg0KTWFjIGFkZHJlc3MgaXMgZXhwb3NlZCBpbiB0aGUgZmVhdHVyZXMgc28geWVzLCBpdCBz
aG91bGQgYmUgcG9zc2libGUgdG8gbW9kaWZ5IGl0IGFzIHBhcnQgb2YgZmVhdHVyZXMgbW9kaWZ5
IGNvbW1hbmQuIChpbiBmdXR1cmUpLg0KVXNlciBuZWVkcyB0byBtYWtlIHN1cmUgdGhhdCBkZXZp
Y2UgaXMgbm90IGF0dGFjaGVkIHRvIHZob3N0IG9yIGhpZ2hlciBsYXllciBzdGFjayB3aGVuIGRl
dmljZSBjb25maWd1cmF0aW9uIGxheW91dCBpcyBtb2RpZmllZC4NCiANCj4gU2VhbiBtYXkgc2hh
cmUgbW9yZSBpbmZvcm1hdGlvbiBvbiB0aGlzLg0KPiANCj4gVGhhbmtzDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
