Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741B1C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 10:01:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BDB64EEA
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 10:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BDB64EEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BE07400B5;
	Wed,  3 Mar 2021 10:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L-KLEMzWnhGr; Wed,  3 Mar 2021 10:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id ED9E7400BD;
	Wed,  3 Mar 2021 10:01:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B934EC000A;
	Wed,  3 Mar 2021 10:01:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDDB2C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 10:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4080838C0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 10:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DyHSqP_7eiwP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 10:01:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88637838AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 10:01:38 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B603f5e810003>; Wed, 03 Mar 2021 02:01:37 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 10:01:36 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 10:01:34 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 3 Mar 2021 10:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e61J7hyvjcFZ4osthsUD0cxvPkZpIgfFz5KwwZW9x6e0hwla6QeXuVnOx6wRLh7dcFpz+E4cth7fofyBsnFPlNVkM6v/Sh65v2omUf1FJDGTMeWxL4Hm+vuAcLbBtEZ1JbSi0kQG8AuDCu4mSIwRJqZcq1yJctsFAvMVB37zpimRj/a4Ewmsls0TD+JetHy5ADTxraQ9NT2OSXuqCWtUMchquqTxXyeXqCmnAdixBWXfJSUR5TnHltQ9qckAvV/JKqVui90aEZeTPseGJ0Xe+62ZCeQ8MMiIvbLE87N0Ogau9J8JxTQD8OydDg4acdl85qFnC6Hnzi2jWm5LiVZc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52bytn6ICXEyElWCMbklgHCXOJD1UPXcTCLZO+X1YSg=;
 b=emgsgjQnwDV0NTwzchDAEK1/ej8ey1HhAfh0Gfi3hJFh19KoT//+5wgMlvqswPJiivj1zRQqLHW++LXOAyE5HO6u8Yl11bIwIimjQmM0Ypo61epGFR8NOZre884uTeI5gS1iYqNcYqqNJxBnrDVApGsvMIqtS3Cxho4984QnQu1cixOeZSdU/hs41jN4uI+HWVPJGcKpLcoC61FE5FVS1niuZ+OgrYc3vKt9ycD5Jlu+XgdMJcdDWrVOYLdRMQU1xSaqE/S8RUelWuh34F6q9VkO6ze8uRQ24NKkwVKWI5a616dmLmd93/1MSEni14RdSSztlG5A5l4KsJqfchJY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB2616.namprd12.prod.outlook.com (2603:10b6:a03:66::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 10:01:31 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::b0c7:dacb:8412:19e5]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::b0c7:dacb:8412:19e5%5]) with mapi id 15.20.3912.018; Wed, 3 Mar 2021
 10:01:31 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated random
 MAC address
Thread-Topic: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated
 random MAC address
Thread-Index: AQHXCnT6NMq2tnbxrE2zArEnohdFyKpnBSGAgAe5UACAAGT1AIAAAs6AgAAwQYCAAOFogIABdMOwgAAszgCAADEIAIAAB0XQ
Date: Wed, 3 Mar 2021 10:01:31 +0000
Message-ID: <BY5PR12MB4322C1E46CBEEA595708B9A1DC989@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-8-parav@nvidia.com>
 <97a01cb9-8278-1ed6-59b5-807c58523c82@redhat.com>
 <20210301070828.GA184680@mtl-vdi-166.wap.labs.mlnx>
 <20210301080731-mutt-send-email-mst@kernel.org>
 <20210301131951.GA196924@mtl-vdi-166.wap.labs.mlnx>
 <20210301110937-mutt-send-email-mst@kernel.org>
 <20210302053919.GB227464@mtl-vdi-166.wap.labs.mlnx>
 <DM6PR12MB43302B0E28AEFDD8A1620D11DC989@DM6PR12MB4330.namprd12.prod.outlook.com>
 <20210303063350.GA29123@mtl-vdi-166.wap.labs.mlnx>
 <20210303042750-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210303042750-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.166.131.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24e736a3-3c37-4962-856b-08d8de2b523c
x-ms-traffictypediagnostic: BYAPR12MB2616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2616C0D634B351FE2C399C62DC989@BYAPR12MB2616.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lgxcGxhUpwquk5N4oB0vPkm8Dcu//lGNc28UVYl2+ayItQkhqpnlJdtlinSjGii9i2CkgZYhErkGrxDtFHFND8qOM+XSPIWwvYYxKzyuQ7Z1NW29C9qkyUqEEasd5n95cl4s5GfNwSN2nNluV9LCM19BClMd3VLJx9ptMBK3XOnsT5Um3S8ys0dNlDgDp3n8KoNH6I3+fxwj027uUyo0BUuIhb5uVlk1gIGK5UEjPvNrzMxNN3q9VqWkUIESSZSBb59wAr/lSLO/3iCZygR4k9ckxLYzI0XfJNWdmHHC9CYnftKxFv4IQTTlz74rTLTe5Z/swBVy/yOoKYDiGj4LOyyzHpogat1Dei+RC3JzoeCbr3nTqz6FNidCtKdfG7vKKkEvBnkO8aRDjZFK3BOFzDL8qBRBGeCu2q5x+ZGvM2OKI8VCFgqIhvoqo7croV1zXPQLztfKDYqVwhdE3HJX2K4fohDI38liXlkIXMbseTpBRGDgBMRRyyaR7fHqQw/s7sIccrzFXew1AHM+yfEeRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(2906002)(83380400001)(478600001)(7696005)(6636002)(26005)(9686003)(55016002)(6506007)(8676002)(186003)(4326008)(86362001)(8936002)(5660300002)(71200400001)(110136005)(316002)(33656002)(52536014)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TVBjVDU5eE9KV2hUSk1qYkJKK1ZMcmZIRUhiemJQUVJFZGx1b1pGUFpGMzZK?=
 =?utf-8?B?RWkwZGdVbmZjY1lRTTM0V25xOUprNzY0b1NHUFllMExUSmRGME9jNDVHV3hV?=
 =?utf-8?B?Z0ozeWNZem8zZFF1MzJuTGFJbDhIN09EK1RaNnEzbkV0WUlPZkF6RzJvQ1BB?=
 =?utf-8?B?Z1lPK1JEOWpvNWZLT05QcEczTE9pcWZXbEp6ZmQ2MmxUUGUwaXRvZ3kyOXpi?=
 =?utf-8?B?T1hTQnVRNHFOMmNZWDlBSmhxSG9RcE56QXNYQWVZRXNGcUxTcmxQOFpnYzZD?=
 =?utf-8?B?MUtEV0lNUWVBVDViQUlWMzMrazAvSFV0d2pYSFpRbExzVWZRRFhxMHBqdzBt?=
 =?utf-8?B?NGJ3OVArVUF4YnFHcC84cXFybFI2OHpTcnFVQjhCbWJhOFV0My9aY0oyNUZU?=
 =?utf-8?B?SjNZWEVTM0J3a0FxM3ZPVXJENVNZTzJHU0tYWTRhOHkyMzJwN1ZRU1Y5eE0r?=
 =?utf-8?B?TlFKNUd3ZkZnTGI0VTd3Vzl1TlhtTm9yTGxDeWorV3FRVlF3NmRIVFBvVHVh?=
 =?utf-8?B?SmZwbmZ1STNuL3A0NTZmeGNRWFFBYVNxb0szQm1EZDM0VUFIN201MHJNNG5u?=
 =?utf-8?B?cWgvWmNDWkViemxXa3dHMEIzQWxFT0hieXNicS96b2JoVGRGWFBUcXRmZDBt?=
 =?utf-8?B?OWxsMHJYWkhjR1lQZXVUeXB4bGNpQzdHOG14N1pDYVhoSXlwTU1GYUxncFlF?=
 =?utf-8?B?T2M2Q3hmSnN4Q0lrOHV2b05hOE5TZ240enpmWkxUWTFiRGt2NkhjS0VtNGgz?=
 =?utf-8?B?RGZWRFEyZUhTdlNMakRzVmM5QzlsekZLbU9rdDVSaVpIazFaUElkdkFHTmNw?=
 =?utf-8?B?cmYwWGFqY2NwR3dIN1VGSGYyRms3OXZJTUpLN0EreVJIaU5lS0c3dS9qbjNm?=
 =?utf-8?B?eGlUL3R2NTRjUXMyd2tFV2JqRzVkK21NSVVpbFc3dXg1SnQ5VDl3amFSRFZI?=
 =?utf-8?B?Yk5OZjFRempCeTdwTW9aOHcxTVBRU3BhdzNwK3ZWcTI3U3dDeWsxZU55Y1Nz?=
 =?utf-8?B?SXh0NDJCVEQ3NHVrdzU1ZGtlMTFFR3k3Z0lmTVVYR01FR21paGk4K3hiTDdu?=
 =?utf-8?B?ckZNL2pVMUZySTJkRCtoMmhVMDlTalpOZjk0UVhBc25ITEZPMmd6czk3YmU4?=
 =?utf-8?B?VlNsRUpqMVRlT25NRzJ6RzAwVmhwSUR1MjY2bVAvUURDVDJ2dU8xYmxQNVVu?=
 =?utf-8?B?VnlwVHRLZEU3ZTFiUGx2c1diOVN6MCtkMUxaaDFwMlJjNE9BS1VFMDlPY1RK?=
 =?utf-8?B?bVNISmcvQkdDaitCc0lUdWtqYzZjM2xxa0dwLytyempwV0lVcXNiZjVZa2tG?=
 =?utf-8?B?NVRzb250SWw2dVkyd1RUZFg4TUpES092RzVjK09wa3J5NWFNcHB2SVdsQ0Fp?=
 =?utf-8?B?SUJ5Z3RERWUzZnNMa3N2SHUyQjJ4cHI3YWg2cUZNbVBZbFRZMFFOdGpIQzJX?=
 =?utf-8?B?d2hnTHMyWGh1dWxnNzFIaG95R1QyMFA1K3Q0US9vLytHRU5pODJpQkZCeGFy?=
 =?utf-8?B?VVRPSlNxdXMrRS8wMW45ZDBoSy9GcUpONk5FUmxpMGJmbC92bHFpQjdaQzdh?=
 =?utf-8?B?dWRwMURqMTh6YVAwUmFBZE5sYUhETE9WakhSd0xsaFZTS3BneXYzanpEbnZL?=
 =?utf-8?B?aGhOS0dxaW05K2JpbXE4WWFQblJlNkM5YUhHdVg0OFB6R1RXTDhUcHo4eDFE?=
 =?utf-8?B?Qmp0ZVFNUHJOSml0L0VQemVmUk1WUFBoQXlXQWE2TVhYYjl1MnorTE1BVXoy?=
 =?utf-8?Q?50fueOukGK47R7uwmMWGc+lq5UY+InrpgaHb0AQ?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e736a3-3c37-4962-856b-08d8de2b523c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 10:01:31.6717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xf4RZCxxUKtCLGTt9XIz5pD3DSXiiskybj92WSxkH+8upz9pI5i7mX4lRmja3CpHmiGPdFYNVpknrIMU9B1nOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2616
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614765697; bh=52bytn6ICXEyElWCMbklgHCXOJD1UPXcTCLZO+X1YSg=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-header:x-ms-oob-tlc-oobclassifiers:
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
 b=Y4bLZ1ZyHCnwwflhfDK5m8UAm2PQXTbVhJxg8D5B3BkK2lPZmlt1/picprNsS6Pov
 PogRZ36CjB7ulCiMRGwm8lTJh2INbFoCnlw8bdTudtGAYKITUFldNMNWRkkV4yGyrT
 cRKMRJr66PHpgbkwGaJ7PwFvdQ+E+5ACYa1003e6FL/3C1y8+ebsb1wKi5MViJ++mY
 9jhXC2asTV72Eiv5uqZ4/Knw3NW/y8YPuRFscHvjHJcJxEfwIaNrioZn6+k0WmoKiI
 qf9GVJ+AqpEp9l/JotIGHcWS2cnrP7q/ZRkc1dp3wyJnuwYr/FH1aNQ+nRryL8oviJ
 nFreA0+jEH85g==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
V2VkbmVzZGF5LCBNYXJjaCAzLCAyMDIxIDI6NTkgUE0NCj4gDQo+IE9uIFdlZCwgTWFyIDAzLCAy
MDIxIGF0IDA4OjMzOjUwQU0gKzAyMDAsIEVsaSBDb2hlbiB3cm90ZToNCj4gPiBPbiBXZWQsIE1h
ciAwMywgMjAyMSBhdCAwNTo1OTo1MEFNICswMjAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4g
PiBIaSBFbGksDQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNv
bT4NCj4gPiA+ID4gU2VudDogVHVlc2RheSwgTWFyY2ggMiwgMjAyMSAxMTowOSBBTQ0KPiA+ID4g
Pg0KPiA+ID4gPiBPbiBNb24sIE1hciAwMSwgMjAyMSBhdCAxMToxMjozM0FNIC0wNTAwLCBNaWNo
YWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ID4gPiA+ID4gT24gTW9uLCBNYXIgMDEsIDIwMjEgYXQg
MDM6MTk6NTFQTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gTW9uLCBN
YXIgMDEsIDIwMjEgYXQgMDg6MDk6NDhBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiBPbiBNb24sIE1hciAwMSwgMjAyMSBhdCAwOTowODoyOEFNICswMjAw
LCBFbGkgQ29oZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gT24gV2VkLCBGZWIgMjQsIDIwMjEg
YXQgMDU6MTE6MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gPiBPbiAyMDIxLzIvMjQgMjoxOCDkuIvljYgsIFBhcmF2IFBhbmRp
dCB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gRnJvbTogRWxpIENvaGVuIDxlbGljQG52aWRp
YS5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IFVzZSBhIHJh
bmRvbWx5IGdlbmVyYXRlZCBNQUMgYWRkcmVzcyB0byBiZSBhcHBsaWVkIGluDQo+ID4gPiA+ID4g
PiA+ID4gPiA+IGNhc2UgaXQgaXMgbm90IGNvbmZpZ3VyZWQgYnkgbWFuYWdlbWVudCB0b29sLg0K
PiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGUgdmFsdWUgcXVlcmll
ZCB0aHJvdWdoDQo+ID4gPiA+ID4gPiA+ID4gPiA+IG1seDVfcXVlcnlfbmljX3Zwb3J0X21hY19h
ZGRyZXNzKCkNCj4gPiA+ID4gPiA+ID4gPiA+ID4gaXMgbm90IHJlbGVsYXZudCB0byB2ZHBhIHNp
bmNlIGl0IGlzIHRoZSBtYWMgdGhhdA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBzaG91bGQgYmUgdXNl
ZCBieSB0aGUgcmVndWxhciBOSUMgZHJpdmVyLg0KPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4N
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZp
ZGlhLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+ID4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4g
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gLS0t
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IHwgNSArLS0tLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0K
PiA+ID4gPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0K
PiA+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCBiNjdiYmE1ODFkZmQuLmVjZTIxODNlN2IyMCAxMDA2
NDQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYw0KPiA+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMjAwNSwxMCArMjAwNSw3IEBAIHN0
YXRpYyBpbnQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gbWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0DQo+
ID4gPiA+IHZkcGFfbWdtdF9kZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSkNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gICAJaWYgKGVycikNCj4gPiA+ID4gPiA+ID4gPiA+ID4gICAJCWdvdG8gZXJy
X210dTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gLQllcnIgPSBtbHg1X3F1ZXJ5X25pY192cG9ydF9t
YWNfYWRkcmVzcyhtZGV2LCAwLA0KPiAwLCBjb25maWctDQo+ID4gPiA+ID5tYWMpOw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiAtCWlmIChlcnIpDQo+ID4gPiA+ID4gPiA+ID4gPiA+IC0JCWdvdG8gZXJy
X210dTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiArCWV0aF9y
YW5kb21fYWRkcihjb25maWctPm1hYyk7DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
PiBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMgbWlzc2luZyBzZXR0aW5nIFZJUlRJT19ORVRfRl9NVFUu
IEkNCj4gPiA+ID4gPiA+ID4gPiB3aWxsIHBvc3QgdjIgd2l0aCB0aGUgb3RoZXIgZml4ZXMgaW4g
dGhpcyBzZXJpZXMuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEkgZG9uJ3QgcmVhbGx5
IHVuZGVyc3RhbmQgd2h5IHRoaXMgaXMgYSBnb29kIGlkZWEuDQo+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+IElmIHVzZXJzcGFjZSB3YW50cyBhIHJhbmRvbSBtYWMgaXQgY2FuIHNldCBpdCwg
d2l0aCB0aGlzDQo+ID4gPiA+ID4gPiA+IHBhdGNoIGl0IGlzIGltcG9zc2libGUgdG8ga25vdyB3
aGV0aGVyIHRoZSBtYWMgaXMgYSBoYXJkd2FyZQ0KPiA+ID4gPiA+ID4gPiBvbmUgKHdoaWNoIHdp
bGwgYmUgcGVyc2lzdGVudCBlLmcuIGFjcm9zcyByZWJvb3RzKSBvciBhIHJhbmRvbQ0KPiBvbmUu
DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gWW91IGNhbiBzdGlsbCBn
ZXQgYSBwZXJzaXN0ZW50IE1BQyBzZXQgYnkgdGhlIHZkcGEgdG9vbC4gZS5nDQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gdmRwYSBkZXYgY29uZmlnIHNldCB2ZHBhMCBtYWMgMDA6MTE6MjI6MzM6
NDQ6NTUNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJZiB5b3UgZG9uJ3QgdXNlIHZkcGEgdG9v
bCwgdGhlIGRldmljZSBhc3NpZ25zIGEgcmFuZG9tIE1BQy4NCj4gPiA+ID4gPiA+IFRoaXMgTUFD
IGlzIHVzZWQgdG8gZmlsdGVyIGltY29taW5nIHVuaWNhc3QgdHJhZmZpYyAoZG9uZSBpbiBhDQo+
ID4gPiA+ID4gPiBzdWJzZXF1ZW50DQo+ID4gPiA+IHBhdGNoKS4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFdlbGwgcHJldmlvdXNseSBkZXZpY2UgbGVhcm5lZCB0aGUgTUFDIGZyb20gb3V0Z29pbmcg
dHJhZmZpYyBhbmQNCj4gPiA+ID4gPiB1c2VkIHRoYXQgZm9yIHRoZSBmaWx0ZXIuDQo+ID4gPiA+
DQo+ID4gPiA+IE5vLCB3YXMgaXMgYWRkZWQgb25seSBpbiB0aGUgbGFzdCBzZXJpZXMgdGhhdCBQ
YXJhdiBzZW5kLiBCZWZvcmUNCj4gPiA+ID4gdGhhdCB0aGUgZGV2aWNlIGRpZCBub3QgZmlsdGVy
IGFuZCBmb3J3YXJkZWQgYW55IHBhY2tldCB0aGF0IHdhcw0KPiA+ID4gPiBmb3J3YXJkZWQgdG8g
aXQgYnV5IHRoZSBlc3dpdGNoLg0KPiA+ID4gPg0KPiA+ID4gPiA+IElzIGNoYW5naW5nIHRoYXQg
dG8gYSByYW5kb20gdmFsdWUgcmVhbGx5IGFsbCB0aGF0IHVzZWZ1bCBhcyBhDQo+ID4gPiA+ID4g
ZGVmYXVsdD8gIFdoeSBub3QgZG8gdGhlIHJhbmRvbWl6YXRpb24gaW4gdXNlcnNwYWNlPw0KPiA+
ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEkgdGhpbmsgd2Ugd2FudCBtYW5hZ2VtZW50IGVudGl0
eSB0byBzZXQgdGhlIE1BQywgdGhhdCdzIHRoZSBWRFBBDQo+IHRvb2wuDQo+ID4gPiA+IFNvIGFz
IHRoaW5ncyBhcmUgcmlnaHQgbm93ICh3aXRoIHRoZSBsYXN0IHNlcmllcyBhcHBsaWVkKSwgdGhl
DQo+ID4gPiA+IHZkcGEgdG9vbCBpcyB0aGUgdG9vbCB0byBhc3NpZ24gTUFDIGFkZHJlc3NlcyBh
bmQgaWYgaXQgZG9lc24ndCwgYQ0KPiA+ID4gPiBkZXZpY2UgcmFuZG9tbHkgZ2VuZXJhdGVkIE1B
QyBhcHBsaWVzLiBDdXJyZW50bHkgTUFDIGFkZHJlc3NlcyBzZXQNCj4gPiA+ID4gYnkgcWVtdSBj
b21tYW5kIGxpbmUgYXJlIGlnbm9yZWQgKHNldF9jb25maWcgaXMgbm90IGltcGxlbWVudGQpLg0K
PiA+ID4gPiBXZSBjYW4gYWxsb3cgdGhpcyBidXQgdGhpcyB3aWxsIG92ZXJyaWRlIHZkcGEgdG9v
bCBjb25maWd1cmF0aW9uLg0KPiA+ID4NCj4gPiA+IEkgYmVsaWV2ZSBpdHMgaW5jb3JyZWN0IHRv
IGFsd2F5cyBkbyByYW5kb20gZ2VuZXJhdGVkIG1hYyBhcyBvZiB0aGlzDQo+IHBhdGNoLg0KPiA+
ID4gVGhpcyBpcyBiZWNhdXNlLCBkb2luZyBzbyBpZ25vcmVzIGFueSBhZG1pbiBjb25maWcgZG9u
ZSBieSB0aGUgc3lzYWRtaW4NCj4gb24gdGhlIHN3aXRjaCAob3ZzIHNpZGUpIHVzaW5nIFsxXS4N
Cj4gPiA+DQo+ID4gV2VsbCwgd2hlbiB0aGlzIHBhdGNoIHdhcyBzZW50LCB3ZSBzdGlsbCBoYWQg
dGhvdWdodHMgdG8gbGV0IG1seDVlIE5JQw0KPiA+IGFuZCB0aGUgVkRQQSB0byBjby1leGlzdCBv
biB0aGUgc2FtZSBmdW5jdGlvbiAoVkYgb3IgU0YpLiBOb3cgdGhhdA0KPiA+IHdlJ3JlIG9mZiB0
aGlzIGlkZWEgeW91IGNhbiBiZWNvbWUgdGVtcHRlZCB0byB1c2UgdGhlIE1BQyBhZGRyZXNzDQo+
ID4gY29uZmlndXJlZCBmb3IgdGhlIE5JQyBidXQgSSBkb24ndCB0aGluayBpdCdzIGEgZ29vZCBp
ZGVhLiBXZSBhbHJlYWR5DQo+ID4gaGF2ZSBhIGRlZGljYXRlZCB0b29sIHRvIGNvbmZpZ3VyZSBN
QUMgZm9yIFZEUEEgc28gbGV0J3MgdXNlIGl0Lg0KPiANCj4gUmlnaHQuIEFuZCB1c2VycyBjYW4g
ZGVjaWRlIHRvIHJldXNlIHRoZSBoYXJkd2FyZSBNQUMgaWYgdGhleSB3YW50IHRvLg0KUmlnaHQu
DQpJZiB1c2VyIGNob3NlIHRvIHJldXNlIHRoZSBodyBtYWMgc2V0IGJ5IHRoZSBlc3dpdGNoLCBz
byBsZXQgdGhlbSB1c2UgaXQuDQpXaGVuIHNtYXJ0bmljIGlzIHVzZWQsIHNvbWUgdXNlcnMgZG8g
bm90IHRydXN0IGNvbXB1dGUgc2lkZSBmb3IgbmV0d29yayBhdHRyaWJ1dGVzIGNvbmZpZ3VyYXRp
b24uDQpTbyB0aG9zZSB1c2VycyB0byBjb25maWd1cmUgdGhlIE1BQyBmcm9tIGVzd2l0Y2ggYWxv
bmcgd2l0aCBvdnMgcG9saWN5Lg0KSSB0aGluayBTZWFuIGdhdmUgb25lIGV4YW1wbGUgb2YgaXQu
DQoNCkFuZCB1c2VyIGNhbiBjaG9vc2UgdG8gb3ZlcnJpZGUgaXQgdmlhIHZkcGEgdG9vbC9xZW11
Lg0KDQpJIGFtIG5vdCBzdXJlIGRvaW5nIG9ubHkgb25lX3dheSBmaXRzIGFsbC4NClN3aXRjaC9v
dnMgc2lkZSBjb25maWd1cmluZyB0aGUgbWFjIGFsb25nIHdpdGggcG9saWN5IHNlZW1zIGZpbmUg
dG8gbWUuDQpCdXQgdGhpcyBtYXkgbm90IGZpdCB0aGUgY2FzZSBmb3IgdGhvc2Ugd2hvIGRvZXNu
J3QgaGF2ZSBlc3dpdGNoLg0KSmFzb24gb2ZmbGluZSBvciBpbiBwcmV2aW91cyB0aHJlYWQgbWVu
dGlvbmVkIGEgdXNlIGNhc2UgdG8gY3JlYXRlIG11bHRpcGxlIHZkcGEgZGV2aWNlIGZyb20gc2lu
Z2xlIFBGL1ZGLg0KQXQgTWVsbGFub3ggYXQgbGVhc3Qgd2UgZG9uJ3Qgc2VlIHRoYXQgdXNlIGNh
c2UgYXQgbW9tZW50IGdpdmVuIGl0cyBhdHRhY2hlZCB0byBlc3dpdGNoLg0KDQo+IA0KPiA+ID4g
U28gaWYgdXNlciBjaG9vc2UgdG8gY29uZmlndXJlIHVzaW5nIGVzd2l0Y2ggY29uZmlnLCBtbHg1
X3ZuZXQgdG8gaG9ub3INCj4gdGhhdC4NCj4gPiA+IEFuZCBpZiB1c2VyIHByZWZlcnMgdG8gb3Zl
cnJpZGUgaXMgdXNpbmcgdmRwYSB0b29sIG9yIHNldF9jb25maWcgZnJvbQ0KPiBRRU1VIHNpZGUs
IHNvIGJlIGl0Lg0KPiA+DQo+ID4gSSBhZ3JlZSB0aGF0IHdlIHNob3VsZCBsZXQgdGhlIHVzZXIg
dG8gY29uZmlndXJlIHRoZSBNQUMgdGhyb3VnaCBxZW11DQo+ID4gYXJndW1lbnQgd2hlbiBib290
aW5nIHRoZSBWTS4gU28gSSdsbCBhZGQgdGhpcyBmb3IgdGhlIG5leHQgc3BpbiBvZg0KPiA+IHRo
aXMgc2VyaWVzLg0KPiANCj4gT0sgc28NCj4gLSBpZiBNQUMgaXMgY29uZmlndXJlZCBpdCBpcyB1
c2VkDQo+IC0gaWYgbm90IGNvbmZpZ3VyZWQgMCBpcyByZXBvcnRlZCB0byB1c2Vyc3BhY2UNCj4g
DQo+IGZhaXIgc3VtbWFyeT8NCj4gDQpMR1RNLg0KRWxpPw0KDQo+ID4gPiBIZW5jZSwgaW5zdGVh
ZCBvZiByZXBvcnRpbmcgYWxsIHplcm9zLCBtbHg1IHNob3VsZCBxdWVyeSBvd24gdnBvcnQNCj4g
Y29udGV4dCBhbmQgcHVibGlzaCB0aGF0IG1hYyBpbiB0aGUgY29uZmlnIGxheW91dCBhbmQgcngg
c3RlZXJpbmcgc2lkZS4NCj4gPiA+DQo+ID4gPiBJZiB1c2VyIGNob29zZSB0byBvdmVycmlkZSBp
dCwgY29uZmlnIGxheW91dCBhbmQgcnggcnVsZXMgd2lsbCBoYXZlIHRvDQo+IHVwZGF0ZWQgb24g
c3VjaCBjb25maWcuDQo+ID4gPg0KPiA+ID4gWzFdIGRldmxpbmsgcG9ydCBmdW5jdGlvbiBzZXQg
cGNpLzAwMDA6MDM6MDAuMC88cG9ydF9pZF9vZl9zZi92Zj4vDQo+ID4gPiBod19hZGRyIDAwOjEx
OjIyOjMzOjQ0OjU1DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
