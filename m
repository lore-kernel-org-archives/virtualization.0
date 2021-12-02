Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A965DC433F5
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 03:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4402982CB7;
	Thu,  2 Dec 2021 03:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZWtrnMLuGd1D; Thu,  2 Dec 2021 03:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D2CD382C33;
	Thu,  2 Dec 2021 03:42:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2975C0012;
	Thu,  2 Dec 2021 03:42:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B366C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 124F5403BA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:42:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdXz043lh1rm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:42:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 889194039C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kumIoWpoMNhryXiGJIaWrEpBGr709uMMjASBQPkb0zhKiB9784uUZkk4WFihgjQ/SRjDmD0bIuGF+6HvIAE8Fju+n/03TUkbWtDIsf7bxrLVtRL80lvx3cCmz7rlpfDzdDUMDwJNWZyGG9lyrX2q5IiJDAHwthgw0zqy589ajTM58Aa6yLTwKi/9aJuLvnsSDw9vszFIG42Q04fvNEnBFP8kBFoazwEa7/ZR5UNZtiDe/S8r0SwbkL0pGq3jEwCBnvTKprFfjD3AYC+5DEm8vnoJZG2mCUJg0M8ygcKO6wJrQfSdc7ob392R6kaxZYpFsCF1Kw3qfY2awMhTmqb2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nnt1hnd0iNPAyW5yurNaYgTAlhxMyu4dadGajGWWfs0=;
 b=ZAMgcAbeDntOjwv0RyxY40CMk/XUYnqCfNVoYHmH1xNdH5u8kqYMvmUigeOUFivNdA31SXEOVjCgfmBnt7ug+AuWdi+ZEppMn1BEzirE4olymSIgHoM0lNj3cCLQaQUZmYJvgZ8Ws99N7hI6YHUbYZS/UrOG1iwtXuDEjOUwWaNXnAQc9ilNouSUTXpeGos9EvJbDRFcctUzfrt8hcLCutwbRuef/rATcLVkgzKp3h75QcpYN3BMU+n/L+mEQ2zNgtjGiYXeURYWRgVSI7KfDqa6aNg9hIUGZF/N2yTqPvk0PKxi04Dd53F4zfo5CP+SMkt4/NCMwAsnGiKDbgnh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nnt1hnd0iNPAyW5yurNaYgTAlhxMyu4dadGajGWWfs0=;
 b=Oghe8Lruy5yVf1WwF5hTsE3oV/g8uHNmG70ViYpefKw1sfTzx2ds8d1yXTdkT6dX5brASxnWZyJJst+BwS5mafliZD+553GP+Kb4MWZgw22siy/AZUDI7zdm/ZmbsKRwrJZyFBRFT01utQ2X8+MCXwI1QmXDirUu57N9FD9gqKKpgjYNjFxYoXKmWwx6HKk4JBMbi4v7l3yJLYgpNf5a6U6zWqsrxFn1WINIiHMyHRh6pEONKCB1yjVx0uPW+jPcD+bD2GpkEKn1ex2t/KDgAjoNf0wmz4RMoFg2QDRo6u0lwqtPhqdCGVzDiPwfJRV0newyZFRW3c9Skfv4hwvsNQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5452.namprd12.prod.outlook.com (2603:10b6:510:d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.15; Thu, 2 Dec
 2021 03:42:39 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%7]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 03:42:39 +0000
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>
Subject: RE: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
Thread-Topic: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
Thread-Index: AQHX5c+B2VmddtY5YU+cieG7gRIwFawc2KGAgACRBoCAAADu8IABJocAgAAAXHA=
Date: Thu, 2 Dec 2021 03:42:38 +0000
Message-ID: <PH0PR12MB5481B392B258AD99D96F69EEDC699@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211130094838.15489-1-elic@nvidia.com>
 <20211130094838.15489-2-elic@nvidia.com>
 <ab454062-da69-a72e-1953-716257bb464c@oracle.com>
 <20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx>
 <DM8PR12MB54808D3B8AE095A6EF145E36DC689@DM8PR12MB5480.namprd12.prod.outlook.com>
 <1b588960-dd30-3a22-2793-846d55ff5d56@redhat.com>
In-Reply-To: <1b588960-dd30-3a22-2793-846d55ff5d56@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53895cd1-3832-42e1-de85-08d9b545c9a7
x-ms-traffictypediagnostic: PH0PR12MB5452:
x-microsoft-antispam-prvs: <PH0PR12MB54528357803426B346933385DC699@PH0PR12MB5452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /H37KaPUhy6+JOjBL3C7yjm5lcVEJQe/qQ51CjNcK70iiJqMDG/nx2IEIhikwxT+BHHImzYkiSTKadM4B//33MH+HaCtqPlMmZcj8CKIljzcPAyP1aYu8NOv/pQG9QAK4oyUInliSPKFVAAmkbT6xvAqQ2nLTIfSfoO+QKSQ25z6B1pt53x2Savtzdjd8CmENq7M/3pyeCOZQdaeelHs4z5kV8ak/Y6Youu/Sg9aTBCEQpHO+t3c3tzyxrjReEeh5175mP7ETxmHoNC1niNBlELHEhppq9hzg/D/zryNu5HDWZZQ4wn67N4jpwAEOSNLEDiuRztBlPqLjamCfj/kfMxmiD0uTs7SAEMUde95uTAvqyidFsEVo8Dsa0V4lng/fBxIhLqL6WK6LMowe7R7+PEcDdqSwayru/BgYQAUaoTtCrPYny3BwJrasT6mBSD0JaMVtK5KIeX3R6jEfjlBo/YWIcP4lPa6b2GSPmj71fO9um7ryNo05+z0nIUowADWiqnveTyIKlvnlh+0T+AMGhOnvHK7boLVD7X1cVzh5M7gAwk5wDltDU2Wa9CbDI2rVuFhTRTzM3IgYhGEb0YjRIXg3IODiIflQbOOmj1du4wBlrBVijPDRQS9D2l0SCt5CZYA8pD9jOF+DTOWgd3pnWBUbvnDzf93y11Gn8ebJDXTJhJ6WBsdExQN9qDBMy3jY/3ff3XhwFaRaNfvWagdzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(76116006)(508600001)(66476007)(64756008)(38100700002)(66446008)(2906002)(66946007)(66556008)(55016003)(52536014)(33656002)(8936002)(83380400001)(122000001)(4326008)(5660300002)(86362001)(38070700005)(54906003)(6506007)(7696005)(71200400001)(316002)(110136005)(26005)(9686003)(186003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THphY2NNSzZyNVBDNHZwak95d3JxZjhlWmFaQWZYTDViMzNpU1FQNzQwZlRY?=
 =?utf-8?B?Q2E3VjBiOUJBWlJQT1krNzBmMGk0TmRtZnhTeGdyM29BSUFSdkJNaDJDVFNn?=
 =?utf-8?B?dG5SalpyYXhROE14ZDZsVGhCaEJSOHpwV01hNU5ERk5sRjNIQmZIaWhIZTVC?=
 =?utf-8?B?ZGNLamtiWllsTHpTSXlnRTZzeHo1NW4vMyt6dHBhUnYzc1QwODIyeEdtL1B4?=
 =?utf-8?B?Y2cyVlVTTTR0S0pLZWVtOERwOEVkZVJkM092NmloMFZEZUtVQWswaEFRQ0h6?=
 =?utf-8?B?amlRanRERldnbHlGeEF4dm85YUJ6VDYvOEZkYlE1RVFtY1Q1QUZCejJudC9i?=
 =?utf-8?B?WHd6VzgvbTdtOXNHWk9laXQ4OThDT2RJMVpoVWgwTXllOUcwUFlvamovckFU?=
 =?utf-8?B?VmpOWmlKUjg3RHpTZ2dacWJpSEFPUzRTOVJURzI3NkVMN2JQUEE2QnZJMG5j?=
 =?utf-8?B?QWV3QXFVRE95TDBVMXNPWG1Dbks2SnZNNlRNcmJZYmh1UDU1RnV4YUNKdmtn?=
 =?utf-8?B?ZElyRXFndkpSVVovN0xxZFZnOVF1Ynp2eXZTWFhUSnJZSEI4eUJtUVRlcEVw?=
 =?utf-8?B?V0h0L3ZSU2c5aEdLT28wZHJJaGY3Ui83a1lNZDVIWnR5N2g1YTdZL2M4ZTZW?=
 =?utf-8?B?QzB0RXJWTzlmZDVKN0xkOFJLNjdKcTg1YjF6N0crN3J0ZWJTS3UzR3VlRGg2?=
 =?utf-8?B?eXBCTEI4UitwVDNTRHo4M09RRzdyV2tCNDI0bkRHaTNVVThzTUE4WlNvOEo0?=
 =?utf-8?B?d0NVNUJpRUNvWEp4QzdySGRROWpQOTlYcy9DbEFIMlc1TTgyNHdJNW54ajdy?=
 =?utf-8?B?UWJtT2swNmpGenBtS1BTOEVBank0ajU5OVphRzlNelY2bzY5ZnpvcXRWTjlx?=
 =?utf-8?B?bXVWYUJTQW1BYlhVTWs5N2hSeTZ2bTJWZ0hOYzVzSEd5cXBtWmxGSkRERmlx?=
 =?utf-8?B?M0ZBMksyZi94ckhEb3pSSXlyZDY3ZUdqNkJLUTcrR3hpbzc5U3Q0dTdrb0tS?=
 =?utf-8?B?UlJPbTNtZUc1dDhPS2hNR0ZOZnZQS1o0QzRPRGNIMThmUmpKcDdBZmFXZlVD?=
 =?utf-8?B?dC9XUnVEVTlUMFBEbnRWRzZ6TTdCUjRRbEdmODJzdllwRFpUdFhVYTRIa1B5?=
 =?utf-8?B?ak9mWFc5UG5UelV3SVRCa0JBd204b1ZLMW5BelRUSUVSY2lLYzh2bXQwSDZk?=
 =?utf-8?B?bzEydkN4bmx3MUdlcXdkdFVkYXFTVm9QQll2V1JwUXFHd3MwZ0NBZnBkT1FF?=
 =?utf-8?B?RXREUGg3MVliQ20rT295THdTTDNTU2lEcjlvM3Y1UUU4Zko2OXFhV0t4cE8w?=
 =?utf-8?B?TkhKb1lyL3c0NDMyRllvZWg1QVQwSnZYc3lzZStRc0dMai93Skc0WjQ3U3g4?=
 =?utf-8?B?NzFSV1hrc1I3YytuZTlhcmlJSHhMNGZXdmx0ZzdnNkJKOTlBMGFBWmZHV1lB?=
 =?utf-8?B?QUF6OGkrU3VZWUt5ODZHekF5SDdNUS82dXVLaXVuOGF3clZucWtNVzA1Y2hU?=
 =?utf-8?B?OGpjMmxaOFYwdmViVnl4c2hsY0xXdk9TYXl5VkpVQVlBSXRBOTFzK2JhOU5Z?=
 =?utf-8?B?SkJwazFuK1F5MjRucWhKaXNpcDEyZGdvNFhaRzZMUFBjNnhqTmp1QmJKUFZO?=
 =?utf-8?B?WEVFS1N1dnB5TEgycjMyRTBxeWZuaGhjd2k3WklrTWdCWGVIenhaN1J3VWVC?=
 =?utf-8?B?OG9xb0luRGJDdDdzejJ6dGxuQUtQbWhFeEhoUko1cnN5SVp2SE5lTFBEM2xF?=
 =?utf-8?B?V2Z4b0dnR3djREFlTUxIdUNFaEdzRndkK1hseStxMzBvNTh2eTZVdS9GcjlD?=
 =?utf-8?B?S3BXVjJPaUxLL1YvMDdiMGFXNkdPNVdEWVh6WWF3UjhPRFpKdWN3U2IxN3pu?=
 =?utf-8?B?eER0RHJlcDNQTXVIVHFybnE5OXVINU5mQ1I0S0hmdlNXN0NnYnhFSEtUbEFj?=
 =?utf-8?B?ZlFsUVFaMzZMOHo5Yy9IRGM1cDVPNXd1ZWpvcTllRWxLOVlxUExiSGJDWnlX?=
 =?utf-8?B?TDhZQThlQkJENy9DeCtIR01mejhLL3loTzJLTXdjRDQ4RjB4b1FjVUVmYnVt?=
 =?utf-8?B?d3dkR0tiQ3JOUXI1TXNtaWZMZVNsQitWYXBKUFdldmYrQVMwRE01QXZOZG5j?=
 =?utf-8?B?Sm84aW9MckYrWUlDZHRTY0J1UDB3NDQ3bE1WdWY1VEJHQm9zcFBodGo0VjZW?=
 =?utf-8?Q?Up5h4Q4P64gCcd1GeIYXXP4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53895cd1-3832-42e1-de85-08d9b545c9a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 03:42:38.9232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhYFOMAqheQ8z4z4MMujSIMQ5IycqRzKxRAOwmmdqvAwq6hnFx5CR/+8PRfGVuZBQhnYkYBt9hEtu+zdbZaR0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5452
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIERlY2VtYmVyIDIsIDIwMjEgOToxMSBBTQ0KPiANCj4g5ZyoIDIwMjEvMTIvMSDkuIvl
jYg2OjA5LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOg0KPiA+DQo+ID4+IEZyb206IEVsaSBDb2hlbiA8
ZWxpY0BudmlkaWEuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDEsIDIwMjEg
MzozMyBQTQ0KPiA+Pg0KPiA+PiBPbiBUdWUsIE5vdiAzMCwgMjAyMSBhdCAwNToyNDowM1BNIC0w
ODAwLCBTaS1XZWkgTGl1IHdyb3RlOg0KPiA+Pj4NCj4gPj4+IE9uIDExLzMwLzIwMjEgMTo0OCBB
TSwgRWxpIENvaGVuIHdyb3RlOg0KPiA+Pj4+IEFsbG93IHRvIGNvbmZpZ3VyZSB0aGUgbWF4IHZp
cnRxdWV1ZXMgZm9yIGEgZGV2aWNlLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogRWxp
IENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+Pj4gICAgZHJpdmVycy92
ZHBhL3ZkcGEuYyAgfCAxNiArKysrKysrKysrKysrKystDQo+ID4+Pj4gICAgaW5jbHVkZS9saW51
eC92ZHBhLmggfCAgMSArDQo+ID4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMgaW5kZXgNCj4gPj4+PiA3MzMyYTc0YTRi
MDAuLmUxODVlYzJlZTg1MSAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5j
DQo+ID4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYw0KPiA+Pj4+IEBAIC00ODAsNyArNDgw
LDggQEAgdmRwYV9ubF9jbWRfbWdtdGRldl9nZXRfZHVtcGl0KHN0cnVjdA0KPiBza19idWZmDQo+
ID4+ICptc2csIHN0cnVjdCBuZXRsaW5rX2NhbGxiYWNrICpjYikNCj4gPj4+PiAgICB9DQo+ID4+
Pj4gICAgI2RlZmluZSBWRFBBX0RFVl9ORVRfQVRUUlNfTUFTSyAoKDEgPDwNCj4gPj4gVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIpIHwgXA0KPiA+Pj4+IC0JCQkJICgxIDw8IFZEUEFfQVRU
Ul9ERVZfTkVUX0NGR19NVFUpKQ0KPiA+Pj4+ICsJCQkJICgxIDw8IFZEUEFfQVRUUl9ERVZfTkVU
X0NGR19NVFUpIHwgXA0KPiA+Pj4+ICsJCQkJICgxIDw8DQo+IFZEUEFfQVRUUl9ERVZfTkVUX0NG
R19NQVhfVlFQKSkNCj4gPj4+IEl0IHNlZW1zIFZEUEFfQVRUUl9ERVZfTUFYX1ZRUyAodTMyKSBp
cyB3aGF0IHlvdSB3YW50ICgjIG9mIGRhdGENCj4gPj4+IHZpcnRxdWV1ZXMgaW5zdGVhZCBvZiAj
IG9mIGRhdGEgdmlydHF1ZXVlIHBhaXJzKT8gTm90IHN1cmUgd2hhdCdzDQo+ID4+PiBwb3NzaWJs
ZSB1c2Ugb2YgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAsIHdhcyBpdCB0bw0KPiA+PiBk
dW1wL2Rpc3BsYXkNCj4gPj4+IHRoZSBjb25maWcgc3BhY2UgbWF4X3ZpcnRxdWV1ZV9wYWlycyB2
YWx1ZSAodTE2LCAxLTMyNzY4KSBmb3INCj4gPj4+IHZpcnRpby1uZXQ/IFdoeSB0aGVyZSdzIHN1
Y2ggcXVhc2ktZHVwbGljYXRlIGF0dHJpYnV0ZSBpbnRyb2R1Y2VkIGluDQo+ID4+PiB0aGUgZmly
c3QNCj4gPj4gcGxhY2U/DQo+ID4+IFZEUEFfQVRUUl9ERVZfTUFYX1ZRUyBjdXJyZW50bHkgcmV0
dXJucyB2ZGV2LT5udnFzIHdoaWNoIGVxdWFscw0KPiA+PiB3aGF0ZXZlciBwYXNzZWQgdG8gX3Zk
cGFfcmVnaXN0ZXJfZGV2aWNlKCkuIFRoZSBsYXR0ZXIgZGVwZW5kcyBvbiB0aGUNCj4gPj4gdmFs
dWUgcHJvdmlkZWQgYnkgKHN0cnVjdCB2ZHBhX2Rldl9zZXRfY29uZmlnKS5tYXhfdmlydHF1ZXVl
cy4NCj4gPj4NCj4gPiBNYXggVlFzIGNvbmZpZ3VyYXRpb24gc2hvdWxkIHJldXNlIFZEUEFfQVRU
Ul9ERVZfTUFYX1ZRUy4NCj4gPiBpdCBpbmRpY2F0ZXMgd2hhdCBpcyB0aGUgbWF4IHZxcyBhIGdp
dmVuIHZkcGEgZGV2aWNlIGlzIHVzaW5nLiBVbnRpbCBub3cgaXQgd2FzDQo+IGRyaXZlcidzIGNo
b2ljZSwgbm93IGl0cyB1c2VycyBjaG9pY2UgaWYgcHJvdmlkZWQuDQo+ID4gU28gbm8gbmVlZCBm
b3IgYWRkaXRpb25hbCBhdHRyaWJ1dGUuDQo+IA0KPiANCj4gSSB0aGluayBhIGRldmljZSBzcGVj
aWZpYyBhdHRyaWJ1dGUgbWlnaHQgYmUgYmV0dGVyOg0KPiANCj4gMSkgbWF4X3ZpcnRfcXVldWVf
cGFpcnMgaXMgcGFydCBvZiBjb25maWcgc3BhY2Ugc28gaXQgc2hvdWxkIHdvcmsgYXMgbXR1IGFu
ZA0KPiBtYWMNCj4gDQo+IDIpIGl0J3MgbW9yZSBjb252ZW5pZW50IGZvciB0aGUgdXNlciB0byBz
cGVjaWZjIHFwcyBpbnN0ZWFkIG9mIGRvaW5nDQo+IDIqTisxIGNhbGN1bGF0aW9uDQo+IA0KWWVz
LiBFbGkncyBuZXcgc2VyaWVzIGFscmVhZHkgdG9vayBjYXJlIG9mIHRoaXMgYnkgcmV1c2luZyBl
eGlzdGluZyBhdHRyaWJ1dGUuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
