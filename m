Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E298C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 06:29:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3578613BE
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 06:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3578613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B515A40114;
	Thu, 24 Jun 2021 06:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kKpix8fLxT4A; Thu, 24 Jun 2021 06:29:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DB8E400A4;
	Thu, 24 Jun 2021 06:29:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13827C0010;
	Thu, 24 Jun 2021 06:29:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5BBDC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 06:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 925F54054B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 06:29:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2MX7R-GOcUgp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 06:29:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 033464052E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 06:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMFKDFejFJkPoY3mmKqMgiTgPBQX4j+ohaHhStbXPqcxvCv6bwJxl10hgakzBdIgiTg+2iicWylWndNNBs+EDUTUWxfcpVw89cfg/FT7hmBdyT6IoKEYjdteNL4gcaK9uDzW8tKnLchKhPkQm67CBtOoi0hbTK6fU6a26TgvH3TOHEIJ5eJHCwGwScF0uMM0m+EsNw2D62liy51+00Co31y87ayNFF6uB5vVIdycs7r2v3tfM3PmcFvOAp9fnYmZgDLJwm9PUf7Fb06D0lndmcLx6VuCQymMkIuoKH8wNOEWnrdGSifv3ioM9G/W6UbWsXTxEYw3zcNrgTOY2JtbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wazLEkyNOpOKd3NiztsbtXAUQRWlN4LeEB3xFEpgszo=;
 b=eb6EtEUcCfZAGAdSNmaENC+S2kAhN8cwLIuQgtmfp1+EmgQPCwulGteASxhiiIaRW3QrHpuLutxIC11IhcC3o2FjXaoReTPW4QbB9wXBllpQwmYEB7IUHehHkAXpAP/1r/50MrHfaGi0p5bQLTiELfxWeeDqouu2osSBLtQ4gVugV8cetqw2dclJ50NsUR4HRHn2UxpRSFMsygSt49Hti1dmVr9EZevhDHrvFbL1b4t5+xipm0tX8jgQ6Q1eN83UluVx9HB1J9WN5LPpH7zA9GKPHPfMjZs2J6szCuxuJV4xi6LArm5XWWrutx+JnjwM9AnPBg/DDTNhm2vbLHZHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wazLEkyNOpOKd3NiztsbtXAUQRWlN4LeEB3xFEpgszo=;
 b=MNO4YM88P6IR4/6M+M/Vt4qRXWrfHLLrRP4Mrw2iZOKMFfEzqAydw/xXz1M3J8cRXnXAvhiys+qJ/K4gg8kgIxIllLkGytG7L+qxuBiD92v251MsvoTM5DXmJ72ta8CmHPKNgkiot+Uo9zP5u0RtApOV0ipLvO89Ddh1XvSB/7zQkPK5a3/XfXz9LcC27kYE3uT5kfEsZtYAnZGwlPf1EdiKMP7q4W3VC/WI2lw1KhRDtu/dmklQIECEhVngWv86CXNr2JxYnu8Lm1Yyf0RUzY2T3oz1nV4fg8Tjgo6aULWrHtOOUcRXz0UtOZb3tTl6cVvvy1u++BjozZXZeKSDPg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 06:29:27 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb%7]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 06:29:27 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KCAAO8RAIAAAJPAgAGsGACAAAPf8A==
Date: Thu, 24 Jun 2021 06:29:27 +0000
Message-ID: <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
In-Reply-To: <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7bb241a-b741-404d-9917-08d936d96a84
x-ms-traffictypediagnostic: PH0PR12MB5481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54817237E2A7AEC4EB71F2F4DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 37hLGQXZcXaBRQVC6+xSIQtRfDL2+PTBnBBbaECm5ohXwnGUYVMbod6xm6XmbI7dwknha8+hn9wRSfPxTrOoSICMV0l1mBo46/I3Zs2GlsTER6K/re5ltvIvx6/+WbYaODamcvBa6dr7Z/aNa60qslvETk1Tc/9smMGhFVUqx1+joBZ0wJTkA7eZq1gY4MbKYGXvMaKryw0JPct+xQuIvl3/jT8xHiweqJfIbFDLHAanQf/hB1hLhHzY+Ltu9nMDO4pXwp3AanPZ/bPTQsMiDWlCnq0AxDzTai8DMPWdGhKhravj/kGYKSw/stfhqMJLAUkAjhXWsZgUcs+0SaherFNMY/SbQWsRTU0TeKoR8HVurBsenBLyG7pxqyuTR80kFyYwa1QX/HWmFldEjomVnYwwxsUQpwN8MdcOYTOTC3qhYFPr6HRMuepWMirpy++WfjtmUIkxkesvt2ySywduKDf4wEoNofd1b7uHBJZZBiGCRjXUogGp6FyO5LredPLzjeOn+4wkVvdyadOsG+mMzeRQ8hUeMmP/RLlzzBT/voUxl+xboPKitsmVvAfCHEJGUODXXqf+xUWZxc/Dghet1xxfRYIgxi04JHwJ/bQHIkk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(316002)(4326008)(110136005)(54906003)(478600001)(83380400001)(76116006)(8676002)(7696005)(64756008)(66556008)(8936002)(66476007)(66446008)(2906002)(38100700002)(122000001)(52536014)(66946007)(5660300002)(186003)(33656002)(55016002)(9686003)(86362001)(6506007)(107886003)(71200400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFJWeXVKNmdUVDA5TStUUC9Ob256YVEzV2ZYUzMyKzAxYXVOeElNTWZkWEtr?=
 =?utf-8?B?a1ZHY2JMQ0NFanFjcVNidHJjNVI4MXgzV1Z2WVZJdWRhK2xKNGpCaVcvd1Ra?=
 =?utf-8?B?a0JodTJqcWtHSXpTT3Z5ZDRFZDZKRUNGR3JVYkR3cG1zZ01UdlYweXJ2MFdh?=
 =?utf-8?B?L2xHckh4OXUxRFpHbzhIamVJRjJjcEcwK2ZzOURlcWNlanV4NzhDbHRVK2E4?=
 =?utf-8?B?TGFYNm9INVBsZnk1LzVyY1dMSU1TMXhKZlRYZ3g2bzV6SlBIcVh4YnFEbHpy?=
 =?utf-8?B?OVVPT2Q3dmZRMVNBbHVXR21XY3ZEelBuWTZCMHZlL3BIdEJIQUxXL3RoTHJE?=
 =?utf-8?B?OUNzV1J2cC9uZ0wwb3k3THVweHdXK2s5S3ZhcVIwWHJlUjFUTlJvbzd0R25M?=
 =?utf-8?B?WHBLSFJUMFhaZ0lZbmwxK2dZUFpNTE5NQXdpa3ZmRGo4RzJJeGFTYlFZN3RS?=
 =?utf-8?B?Y2N0Z2lXSy9meStJUDRaMUxkMDlRamk5bVNtdm51QVI3NElsNlBXcjVmeHhh?=
 =?utf-8?B?T3oxK3JoOXpFZjQ5ZmhlQ1hWbERpa2hFbFcrNlhrZ3BaaExadnF1WjdGUkpt?=
 =?utf-8?B?RzJUSGRPWjY1bUtpT0V1NVZnQ2pMOVJUNzR3OERnNmRadGE1KzFQcVJxeHBL?=
 =?utf-8?B?WGU1b2VqaDlFNTA0eGxWMFJVajJnTnpsbXhLZmhTV3JTdXFuWDI1ZWp2V3No?=
 =?utf-8?B?RisxTThUUWFCbGJkRlN3cmNDV1VnV3lwbC8zeldJdXFSbC9ZcHFWTHRUd1gx?=
 =?utf-8?B?L1lIenNxcFp0VTJqdXQzSWVNM3oyY2VRN2Q0MUQ4eGF6S2tzMWtkRFhCZzVQ?=
 =?utf-8?B?TU10TWExQjRWTkx0WVk4NGM2VU5TS1VISWMxZTdNaklqcGd6cFU3SldMUTRx?=
 =?utf-8?B?R3BOYzB2dE5QTSs5QU91WC91aXd0WTQwTkVEbXdyaHNYbEJoMDJUM2NiWWFQ?=
 =?utf-8?B?Y2p4UkJOcDUxcnJrVGM0dW92UjVLWVppUWI5dzMxdDV5YzlUTm1pTEdmL0FP?=
 =?utf-8?B?SFVyQzJweXRmWlh3UG0zSitHbmZZTXpzYVZHbFlKSnJxSlQwOW8wT3J6ekxx?=
 =?utf-8?B?RkhUVHJYT2FDaXg1SmljcjI4dnZuQTJZTGhPeEZKcDkrbkRvUDYwT011dEF3?=
 =?utf-8?B?M2w5a3J1SEU1RVQ3VmduY0tSUzJ1WHJDVUhSTlB0ZTF1VGV3ck1LY1NtV0Vp?=
 =?utf-8?B?Q1BVcmw1MXp1UmlOK2l5aUdUVmJWcmJKa3VXZUh0QlJ1am5iU09MSW5RVHBj?=
 =?utf-8?B?UzAyNDJIWjdRSlByTkxJdThVT0JicndKQzdpcmp5dTEvVnhrYUphVVZ4dy91?=
 =?utf-8?B?UVJRZFFwd0h2ODVBT3ljMXdacHFtYWxxbG9GZTdBY0s2SDZrbXJxVWNrYXow?=
 =?utf-8?B?MzlBS1UzdUZraHFITzY1d3N1Qk02b29KV09FY2N5L2gzdkFrSnBoaC9JSjd6?=
 =?utf-8?B?ZHpDYWljRlRPaFExYjNZeWtqUkZ0V2JzWnNmQUo3ZGZrbXVMQnByeDZVT1Jw?=
 =?utf-8?B?TDR1NzNzcG02UnpyT0ZLa0J5VUd0dUhYTkFiS2VFc2IySzNoa2Nwejh4anNK?=
 =?utf-8?B?aTZxY0pUSTBPa1Q0eHNJU2lMR2NBemdJb3dVQ1ZrdlhndU1NWHJFZzV3TG80?=
 =?utf-8?B?WThFOFdXUXNlUGEvTTBqekszK0RMM0pRL2ZlTHJYZUkrQkxIN045YWVENFVx?=
 =?utf-8?B?N3RkdTRqS3dIT0VlRkViMUVYMFBhT0ZIWDk1MW55VWpsL042VzNHUFlrZkpx?=
 =?utf-8?Q?tBrxwUKfLE3G0dxh8tqnFfM1ArovVftycvAnstp?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bb241a-b741-404d-9917-08d936d96a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 06:29:27.1388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vtMS+GcmyrXqex9gHiJ+bNxioWhSCH0SNX+hSjbN6hkBzfjjjDKhgFeH+eALp1YqCgev4U1tRt28JF940aadw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
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

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEp1bmUgMjQsIDIwMjEgMTE6MTMgQU0NCj4gDQo+IOWcqCAyMDIxLzYvMjMg5LiL5Y2I
MTI6MjIsIFBhcmF2IFBhbmRpdCDlhpnpgZM6DQo+ID4NCj4gPj4gRnJvbTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDIzLCAyMDIx
IDk6MzkgQU0NCj4gPj4NCj4gPj4g5ZyoIDIwMjEvNi8yMiDkuIvljYgxMDowMywgUGFyYXYgUGFu
ZGl0IOWGmemBkzoNCj4gPj4+PiBJcyBpdCBiZXR0ZXIgdG8gdXNlIGEgc2VwYXJhdGUgZW51bSBm
b3IgbmV0IHNwZWNpZmljIGF0dHJpYnV0ZXM/DQo+ID4+Pj4NCj4gPj4+IFllcywgYmVjYXVzZSB0
aGV5IGFyZSBvbmx5IG5ldCBzcGVjaWZpYy4NCj4gPj4+IEkgZ3Vlc3MgaXQgaXMgcmVsYXRlZCB0
byB5b3VyIGJlbG93IHF1ZXN0aW9uLg0KPiA+Pj4NCj4gPj4+PiBBbm90aGVyIHF1ZXN0aW9uIChz
b3JyeSBpZiBpdCBoYXMgYmVlbiBhc2tlZCBiZWZvcmUpLiBDYW4gd2Ugc2ltcGx5DQo+ID4+Pj4g
cmV0dXJuIHRoZSBjb25maWcgKGJpbmFyeSkgdG8gdGhlIHVzZXJzcGFjZSwgdGhlbiB1c2VzcGFj
ZSBjYW4gdXNlDQo+ID4+Pj4gdGhlIGV4aXN0aW5nIHVBUEkgbGlrZSB2aXJ0aW9fbmV0X2NvbmZp
ZyBwbHVzIHRoZSBmZWF0dXJlIHRvDQo+ID4+Pj4gZXhwbGFpbiB0aGUNCj4gPj4gY29uZmlnPw0K
PiA+Pj4gV2UgZGlkIGRpc2N1c3MgaW4gdjIuDQo+ID4+PiBVc3VhbGx5IHJldHVybmluZyB0aGUg
d2hvbGUgYmxvYiBhbmQgcGFyc2luZyBpcyBub3QgZGVzaXJlZCB2aWEgbmV0bGluay4NCj4gPj4+
IFJldHVybmluZyBpbmRpdmlkdWFsIGZpZWxkcyBnaXZlIHRoZSBmdWxsIGZsZXhpYmlsaXR5IHRv
IHJldHVybiBvbmx5DQo+ID4+PiB0aGUgdmFsaWQNCj4gPj4gZmllbGRzLg0KPiA+Pj4gT3RoZXJ3
aXNlIHdlIG5lZWQgdG8gaW1wbGVtZW50IGFub3RoZXIgYml0bWFzayB0b28gdG8gdGVsbCB3aGlj
aA0KPiA+Pj4gZmllbGRzDQo+ID4+IGZyb20gdGhlIHN0cnVjdCBhcmUgdmFsaWQgYW5kIHNoYXJl
IHdpdGggdXNlciBzcGFjZS4NCj4gPj4+IFJldHVybmluZyBpbmRpdmlkdWFsIGZpZWxkcyBpcyB0
aGUgd2lkZWx5IHVzZWQgYXBwcm9hY2guDQo+ID4+DQo+ID4+IFRoZSBtYWluIGNvbmNlcm5zIGFy
ZToNCj4gPj4NCj4gPj4gMSkgVGhlIGJsb2Igd2lsbCBiZSBzZWxmIGNvbnRhaW5lZCBpZiBpdCB3
YXMgcGFzc2VkIHdpdGggdGhlDQo+ID4+IG5lZ290aWF0ZWQgZmVhdHVyZXMsIHNvIHdlIGRvbid0
IG5lZWQgYml0bWFzay4NCj4gPiBXaGljaCBmaWVsZHMgb2YgdGhlIHN0cnVjdCBhcmUgdmFsaWQg
aXMgdG9sZCBieSBhZGRpdGlvbmFsIGZpZWxkcy4NCj4gPj4gMikgVXNpbmcgaW5kaXZpZHVhbCBm
aWVsZHMgbWVhbnMgaXQgbXVzdCBkdXBsaWNhdGUgdGhlIGNvbmZpZyBmaWVsZHMNCj4gPj4gb2Yg
ZXZlcnkgdmlydGlvIGRldmljZXMNCj4gPj4NCj4gPiBNb3N0bHkgbm8uIGlmIHRoZXJlIGFyZSBj
b21tb24gY29uZmlnIGZpZWxkcyBhY3Jvc3MgdHdvIGRldmljZSB0eXBlcywNCj4gPiB0aGV5IHdv
dWxkIGJlIG5hbWVkIGFzDQo+ID4gVkRQQV9BVFRSX0RFVl9DRkdfKg0KPiA+IE5ldCBzcGVjaWZp
YyB3aWxsIGJlLA0KPiA+IFZEUEFfQVRUUl9ERVZfTkVUX0NGR18qDQo+ID4gQmxvY2sgc3BlY2lm
aWMsIHdpbGwgYmUsDQo+ID4gVkRQQV9BVFRSX0RFVl9CTEtfQ0ZHXyoNCj4gDQo+IA0KPiBJIG1l
YW50IGl0IGxvb2tzIGxpa2UgVkRQQV9BVFRSX0RFVl9ORVQgd2lsbCBkdXBsaWNhdGUgYWxsIHRo
ZSBmaWVsZHMgb2Y6DQo+IA0KPiBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWc7DQo+IA0KPiBBbmQg
VkRQQV9BVFRSX0RFVl9CTE9DSyB3aWxsIGR1cGxpY2F0ZSBhbGwgdGhlIGZpZWxkcyBvZg0KPiAN
Cj4gc3RydWN0IHZpcnRpb19ibGtfY29uZmlnOyB3aGljaCBoYXMgfjIxIGZpZWxkcy4NCj4gDQo+
IEFuZCB3ZSBoYWQgYSBwbGVudHkgb2Ygb3RoZXIgdHlwZXMgb2YgdmlydGlvIGRldmljZXMuDQo+
IA0KPiBDb25zaWRlciB3ZSBoYWQgYSBtYXR1cmUgc2V0IG9mIHZpcnRpbyBzcGVjaWZpYyB1QVBJ
IGZvciBjb25maWcgc3BhY2UuDQo+IEl0IHdvdWxkIGJlIGEgYnVyZGVuIGlmIHdlIG5lZWQgYW4g
dW5uZWNlc3NhcnkgdHJhbnNsYXRpb24gbGF5ZXIgb2YgbmV0bGluayBpbg0KPiB0aGUgbWlkZGxl
Og0KPiANCj4gW3ZEUEEgcGFyZW50ICh2aXJ0aW9fbmV0X2NvbmZpZyldIDwtPiBbbmV0bGluayAo
VkRQQV9BVFRSX0RFVl9ORVRfWFgpXQ0KPiA8LT4gW3VzZXJzcGFjZSAoVkRQQV9BVFRSX0RFVl9O
RVRfWFgpXSANCg0KPj4gPC0+IFsgdXNlciAodmlydGlvX25ldF9jb25maWcpXQ0KVGhpcyB0cmFu
c2xhdGlvbiBpcyBub3QgdGhlcmUuIFdlIHNob3cgcmVsZXZhbnQgbmV0IGNvbmZpZyBmaWVsZHMg
YXMgVkRQQV9BVFRSX0RFVl9ORVQgaW5kaXZpZHVhbGx5Lg0KSXQgaXMgbm90IGEgYmluYXJ5IGR1
bXAgd2hpY2ggaXMgaGFyZGVyIGZvciB1c2VycyB0byBwYXJzZSBhbmQgbWFrZSBhbnkgdXNlIG9m
IGl0Lg0KDQpJdCBpcyBvbmx5IG9uZSBsZXZlbCBvZiB0cmFuc2xhdGlvbiBmcm9tIHZpcnRpb19u
ZXRfY29uZmlnIChrZXJuZWwpIC0+IG5ldGxpbmsgdmRwYSBmaWVsZHMuDQpJdCBpcyBzaW1pbGFy
IHRvICdzdHJ1Y3QgbmV0ZGV2aWNlJyAtPiBydG5sIGluZm8gZmllbGRzLg0KDQo+IA0KPiBJZiB3
ZSBtYWtlIG5ldGxpbmsgc2ltcGx5IGEgdHJhbnNwb3J0LCBpdCB3b3VsZCBiZSBtdWNoIGVhc2ll
ci4gQW5kIHdlIGhhZA0KPiB0aGUgY2hhbmNlIHRvIHVuaWZ5IHRoZSBsb2dpYyBvZiBidWlsZF9j
b25maWcoKSBhbmQgc2V0X2NvbmZpZygpIGluIHRoZSBkcml2ZXIuDQpIb3c/IFdlIG5lZWQgYml0
IG1hc2sgdG8gdGVsbCB0aGF0IG91dCBvZiAyMSBmaWVsZHMgd2hpY2ggZmllbGRzIHRvIHVwZGF0
ZSBhbmQgd2hpY2ggbm90Lg0KQW5kIHRoYXQgaXMgZnVydGhlciBtaXhlZCB3aXRoIG9mZnNldCBh
bmQgbGVuZ3RoLg0KDQo+IA0KPiANCj4gPg0KPiA+PiBBbmQgYWN0dWFsbHksIGl0J3Mgbm90IHRo
ZSBiaW5hcnkgYmxvYiBzaW5jZSB1YXBpIGNsZWFybHkgZGVmaW5lIHRoZQ0KPiA+PiBmb3JtYXQg
KGUuZyBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpLCBjYW4gd2UgZmluZCBhIHdheSB0byB1c2Ug
dGhhdD8NCj4gPj4gRS5nIGludHJvZHVjZSBkZXZpY2UvbmV0IHNwZWNpZmljIGNvbW1hbmQgYW5k
IHBhc3NpbmcgdGhlIGJsb2Igd2l0aA0KPiA+PiBsZW5ndGggYW5kIG5lZ290aWF0ZWQgZmVhdHVy
ZXMuDQo+ID4gTGVuZ3RoIG1heSBjaGFuZ2UgaW4gZnV0dXJlLCBtb3N0bHkgZXhwYW5kLiBBbmQg
cGFyc2luZyBiYXNlZCBvbiBsZW5ndGgNCj4gaXMgbm90IHN1Y2ggYSBjbGVhbiB3YXkuDQo+IA0K
PiANCj4gTGVuZ3RoIGlzIG9ubHkgZm9yIGxlZ2FsIGNoZWNraW5nLiBUaGUgY29uZmlnIGlzIHNl
bGYgY29udGFpbmVkIHdpdGg6DQo+IA0KVW5saWtlbHkuIFdoZW4gc3RydWN0dXJlIHNpemUgaW5j
cmVhc2VzIGxhdGVyLCB0aGUgcGFyc2luZyB3aWxsIGNoYW5nZSBiYXNlZCBvbiB0aGUgbGVuZ3Ro
Lg0KQmVjYXVzZSBvbGRlciBrZXJuZWwgd291bGQgcmV0dXJuIHNob3J0ZXIgbGVuZ3RoIHdpdGgg
b2xkZXIgaXByb3V0ZTIgdG9vbC4NClNvIHVzZXIgc3BhY2UgYWx3YXlzIGhhdmUgdG8gZGVhbCBh
bmQgaGF2ZSBuYXN0eSBwYXJzaW5nL3R5cGVjYXN0aW5nIGJhc2VkIG9uIHRoZSBsZW5ndGguDQoN
Cj4gMSkgZGV2aWNlIGlkDQo+IDIpIGZlYXR1cmVzDQo+IA0KPiANCj4gPiBQYXJzaW5nIGZpZWxk
cyByZXF1aXJlIGtub3dsZWRnZSBvZiBmZWF0dXJlcyBhcyB3ZWxsIGFuZCBhcHBsaWNhdGlvbiBu
ZWVkcw0KPiB0byBtYWtlIG11bHRpcGxlIG5ldGxpbmsgY2FsbHMgdG8gcGFyc2UgdGhlIGNvbmZp
ZyBzcGFjZS4NCj4gDQo+IA0KPiBJIHRoaW5rIHdlIGRvbid0IGNhcmUgYWJvdXQgdGhlIHBlcmZv
cm1hbmNlIGluIHRoaXMgY2FzZS4gSXQncyBhYm91dCB0aHJlZQ0KPiBuZXRsaW5rIGNhbGxzOg0K
PiANCkl0cyBub3QgYWJvdXQgcGVyZm9ybWFuY2UuIEJ5IHRoZSB0aW1lIDFzdCBjYWxsIGlzIG1h
ZGUsIGZlYXR1cmVzIGdvdCB1cGRhdGVkIGFuZCBpdCBpcyBvdXQgb2Ygc3luYyB3aXRoIGNvbmZp
Zy4NCg0KPiAxKSBnZXQgY29uZmlnDQo+IDIpIGdldCBkZXZpY2UgaWQNCj4gMykgZ2V0IGZlYXR1
cmVzDQo+IA0KVGhpcyByZXF1aXJlcyB1c2luZyBmZWF0dXJlcyBmcm9tIDNyZCBuZXRsaW5rIG91
dHB1dCB0byBkZWNvZGUgb3V0cHV0IG9mIDFzdCBuZXRsaW5rIG91dHB1dC4NCldoaWNoIGlzIGEg
Yml0IG9kZCBvZiBuZXRsaW5rLg0KT3RoZXIgbmV0bGluayBubGFfcHV0KCkgcHJvYmFibHkgc2Vu
ZGluZyB3aG9sZSBzdHJ1Y3R1cmUgZG9lc27igJl0IG5lZWQgdG8gZG8gaXQuDQoNCj4gRm9yIGJ1
aWxkIGNvbmZpZywgaXQncyBvbmx5IG9uZQ0KPiANCj4gMSkgYnVpbGQgY29uZmlnDQo+IA0KPiAN
Cj4gPiBJIHByZWZlciB0byBmb2xsb3cgcmVzdCBvZiB0aGUga2VybmVsIHN0eWxlIHRvIHJldHVy
biBzZWxmIGNvbnRhaW5lZA0KPiBpbnZpZGl2aWR1YWwgZmllbGRzLg0KPiANCj4gDQo+IEJ1dCBJ
IHNhdyBhIGxvdCBvZiBrZXJuZWwgY29kZXMgY2hvb3NlIHRvIHVzZSBlLmcgbmxhX3B1dCgpIGRp
cmVjdGx5IHdpdGgNCj4gbW9kdWxlIHNwZWNpZmljIHN0cnVjdHVyZS4NCj4gDQpJdCBtaWdodCBi
ZSBzZWxmLWNvbnRhaW5lZCBzdHJ1Y3R1cmUgdGhhdCBwcm9iYWJseSBoYXMgbm90IGZvdW5kIHRo
ZSBuZWVkIHRvIGV4cGFuZC4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
