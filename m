Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DBDC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:26:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469FD60EE9
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 469FD60EE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1141880ED0;
	Mon, 25 Oct 2021 08:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XYCrK_XE6mAD; Mon, 25 Oct 2021 08:26:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD90B80EC7;
	Mon, 25 Oct 2021 08:26:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DE5DC0019;
	Mon, 25 Oct 2021 08:26:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24918C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13B4C6083E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:26:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GM6RiVVP1Fxx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:26:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 468D66075D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxNY4ppKeISsv9C7hAh1YnKm3PKdR8itGWSPggkZoQXI70yEEwqn9LfzNGeJ/7IugDP9tyX0qL0w/KJSZm6X1xwDyXZ2I2w5lYOi8+LDUm1Tqo98W8xhZCQmSDW6wPNMIRSuUmiZFXdqo/4gIB4cB/ccAqYzOzUSB2XO60gD2uGDntI7KT7TG8lUBn1FwSbEN5TSuh7lHHVhKwmSbbr8WJUuQ6RjGgl8dH2o7PZfYkb4dXtHDI0zeJrju9lo6M6rj7DXomnZzbSFYgZfmX9bebunh5WCRW3dsuZ3butP0FxQ4vrDF/1JFejnkNKtfRwXO/q1WS43pXARKTgeUDSzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlRVyG5fFl5S6ygehT2EHrIm1lQ6Q62INRHohe7QVgg=;
 b=G8FQOwNVA5mh92ZBW1ThNcwH0XGwNF66vhvjHCQDQHr3qVLEuoq/ENwYxolwgw9VKj/BtiN9ZS7C7vJXTZHQexIxmi2C4DLSk3kTIHoaBDq/neuZZQTZMhQR+Ax62gGemvqgxmZkl3dVu7PRs2KXUeqI/VcefLM1ahCOr/25Oaf2b4UiICplmVEXSUXefmBuomnlnLIrW0ZTnMbD5T9nvktdmOb6SZpGdLXbFXyodZfouCZ3XQwfA4MMw4P8dP2Lo0mbUZkPw/d2BQ/5yl4okyOv5+0Vrd13AM2IUzuc71I+Yo6acYgn8TjyWyWNj+tVALNPsQM1xotL9DrC6WdsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlRVyG5fFl5S6ygehT2EHrIm1lQ6Q62INRHohe7QVgg=;
 b=ROEnCkrBrXV5yy4M2rG35aGwU7AjlRze/OXb9WNqodZKr2qHjc5vUlMctF2MF/vMFZ6jBl+uKPLygSQOvddj2NLivpzFUjANjq4sH7UgWKplPpWV4jpMXyoeJjbrjqED7v8fo/M5CVIaQfU2JgqQX0JaszHpdAcUnY9lEmKfu/XiljE0MCY0GIp1zTQ2V0lSxsytpoody3e/t2hHZ+E8vwDxC2o2ZGeclEWzexjIn2aERYnFmCdOj89ue1jTJNqkkOXJK9qHXswQpiMXgVjlkRWb+TYc2jxr2biKQyXziB6dVJkrTvuQr9PIGvzO5Nm2VXHytXmXVgqAmzZ0GletlQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:26:07 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:26:07 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v4 4/8] vdpa: Enable user to set mac and mtu of
 vdpa device
Thread-Topic: [PATCH linux-next v4 4/8] vdpa: Enable user to set mac and mtu
 of vdpa device
Thread-Index: AQHXxpm0zkNyeacpXEGh5VnXVi6UqavjTwWAgAAAb2CAABJPAIAABHqg
Date: Mon, 25 Oct 2021 08:26:07 +0000
Message-ID: <PH0PR12MB54815D09EAACFC253D6759E3DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-5-parav@nvidia.com>
 <b6f5c0e9-e3e0-0f7f-d3b6-d20d9c01d27d@redhat.com>
 <PH0PR12MB54817652E2E49FD6A4F58F1BDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211025040202-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211025040202-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 500df16a-5526-4f59-4513-08d9979117c1
x-ms-traffictypediagnostic: PH0PR12MB5450:
x-microsoft-antispam-prvs: <PH0PR12MB5450DC772AD5CDECE46A38CEDC839@PH0PR12MB5450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SUmCdPEWiDzx1tB30EShqqRXDGUgAEzsHGCNdbftud8V2bKy/neQS2IfjcYsSrimwRzersr84gid2mL+irPGCB3i2cY7uD+XLGC+mldPh3C8nc6AuD2nqXrpDj4paBLRf2HEZe4MduFgaZCWU8g79mCzLrtAgpg9xJYWHSPF2IS3btSg3tcKaTQxDb2e5tj4+JtNmxSKoGLfIH1dvYaW8GSGMLvQzc07kazSu2wOrdPf9tqu9znL7octtUUeRrqnP8131prJ5o0nJreu3imtLXqEwaLDuUZSPDmbVXg3COGfVAAJQ0zQNYnKrmKFMeQLezzBUtC14BlChgyn5y0WlL6p0SzsZJcUoaT4FaMGhtWwc/pVvAAPdA/bPuiYUqiI4vRTs6ej9HEPfzGxxoKRjS9LExWTiMOlvQkvKanLfjoo48QS5u7ZL10nU0cD0qlhqF4lJrb9MnaBuzQcJIevQ3dAh4+zD5BqtWavzYaOv0lpdHGL9lWxM8Bvv9i8ahe7QW2Ba2Kj7IypeQgU5TvIcqNVZtQniX9AULD4W5LIPgEGjUaUnQx3Jb1Gnydxigi83Dfc6QccZR3DjaUqRNR/0RLnIlAwGO1/W40kSoqL2GW6ZOOTJ6Qg2oYpssruuEvvV49NKiUqXf/Fu6v/OwoBlCNCSubvVCSe6rOCZIftBN9h6GGC1uLmGFTJ4Tuss5P8pGvhteKudYfJSv6qVoyWXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(71200400001)(9686003)(186003)(6506007)(107886003)(7696005)(38100700002)(122000001)(55016002)(66446008)(76116006)(316002)(64756008)(5660300002)(83380400001)(4744005)(66476007)(66556008)(66946007)(52536014)(38070700005)(4326008)(508600001)(6916009)(8936002)(8676002)(86362001)(54906003)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUkrcWVCRWhpNHdhV0RPT3MxTXdma25zcTVYbHhaRDBEb01SN2FyeWZ1VVJl?=
 =?utf-8?B?RFdIczlRc1IzcldMdWwyajFKREJka2wxVHNSR011R090Y21XVDlXZTJDZ2FG?=
 =?utf-8?B?OHFPNjBQRk9paUVsOGNwcVl1RkJBaW9idTg1aG1YTWVXcGxvdkFaM0NraFZ4?=
 =?utf-8?B?Q0M0eE9tTEo3REZ2eUVsd3pnRjFJVGJsYkIrOXkwL3JTbXhtTldOQ3VxYlZq?=
 =?utf-8?B?WUoycTQ4anFwa1RjbTBwcjJSOStMR25zc0NiZXBLZUhaN2hrM2JHaHZXdDN2?=
 =?utf-8?B?VjlteEg3bUlFc1VkMVNnSzBrY3BzZkN2UkJXdnBnL2k1NEVadjhkME82c0pn?=
 =?utf-8?B?QU5WRUVwemhkM1pMK3JEUWVvajVMKzZpZmg4R1IwZ3lPd3l6NGNlbHJ4ZHZS?=
 =?utf-8?B?Mmk3MnJhZjlWalNzNi8rSXpQWWxKcTB5L3QrVWVLcyt3T0ZiSXh1ZVhET2hk?=
 =?utf-8?B?blptY2NsZmdMVW1EbDZxTC9GS25UVVJNSTAzZmsrQnhHcGRrT1pCYlNHanJi?=
 =?utf-8?B?Rm4wV2ZRbWZRUWpvY1NUdkVVaWhLTEg3a3RoWXVwcGw4M04xazNjdWVUb09L?=
 =?utf-8?B?K013NXlQc0hhbzM3VjFIMmhhbmN5WUZwRGFHS3NGVTdzYU9meTZMZHJLTEFX?=
 =?utf-8?B?YXlBOXpaZlJ0Sm1HNGxYc0ZJdDBZSEJ5bUo1ZThyL2l4dCthMDl1Szh4MnJ6?=
 =?utf-8?B?eVJrdDlDTU1ORjA3RmFRVVlUcWVySDlCcVEwUWdEWmt0dXNXSXFoK3ZWWGVI?=
 =?utf-8?B?S3NHQU5TSmRTTys4d09hY0o4V2lFZ3dRaDVJZDAybDc1eCs5L05seXE5cDZO?=
 =?utf-8?B?SkJib1lYamZldEJXUDJ1WUZqUHlYWDd3bUhOQlBoekJROENQVms0UTd4NHI3?=
 =?utf-8?B?bitKanlYT1FnWUYzOW8yY01iRk1Id3l2WHdEYzlCTmZiY3dneVhxYWJRVUUx?=
 =?utf-8?B?RXY3VjJNTllQenJsRlIyR1JvTXVDUlFGc3lNcEU5QVV1OGVNM092ZUpWMlB5?=
 =?utf-8?B?RnBxUVBhVG9BSnZCa3hqVW5LcmN5YXpaand1R3dBdHFBUzhJYnNnTTJVajVz?=
 =?utf-8?B?TWhHbnFIalY4NWxzMFpWN2RNaXA5SVg5U1prNVFmeTUreVZuZnREM1IrUkh3?=
 =?utf-8?B?alcxUGp6V3dibmdIVHdheUVLaDhKdWxuTmdqYU0vcmpJMjNZTkw2SE9tSjMz?=
 =?utf-8?B?TUJEZk9FWEIrWUg4U1gwQ21MS0ZMSktkZFBJS0JmZTZWZzJaWm4ycmhFemlu?=
 =?utf-8?B?ZHRIQmp2TWcvL2tYYU5rMWVnS0FCWWFneDNyNmVsR0FEL0hoUjNGM3VrL291?=
 =?utf-8?B?UnpXZk1UWlRHaVI4Qy9IbGRScVphOUdwOGN0d2l6N0xOSHhRZExGZlpaZEx3?=
 =?utf-8?B?YThicmN5WU9PNGRVNittNVE5WmZmWDZ6dE5NWmFjVFMrVnB0QzhMbGhZVzAx?=
 =?utf-8?B?dkoxMk9vbG1hUjl5UXRhZUtLeU1rS2htcEhiY0JBdC9NQ2cyek44L2JpdkZD?=
 =?utf-8?B?K2FueUNTdnBkcWxSTTN6b2N0UEN0NEtoZjhQeGNCQzFsOXpoTWI5UDU2Zk44?=
 =?utf-8?B?VzRQbXpIS3NCdzREaDVoVVo5ZlpRN0VsbXZmN3RXemlMMGlDTGdUMGRyWnlw?=
 =?utf-8?B?SlltMFE5SDYwV05WRlJibFdBMXRUUUtXQlN2TGgvNTRCZGNDVUxpUVpmaXJ5?=
 =?utf-8?B?ZWE2aG0rdFRMNlF3VC85RzBaMUl5V2N2a2hoWmduRHBrN1B5QXRrcmpKdkQx?=
 =?utf-8?B?UVVuT0hSMkl2dGc3NmFNZzFKYmpmOG1QZjR6bWRPRkVDeDNHV0duSGxVK1Bz?=
 =?utf-8?B?STdsYmtIc0RsUUI1UFNBOWh4RkJMT3Zid3NueThCeXBSTHRRZ29iTEdNdEZH?=
 =?utf-8?B?ME1NTm84ZFVWV2t5NjBpbEFENThQSWhHZEVHOUR4TVpHaWhTRmxsUG9Ib2ds?=
 =?utf-8?B?aTlUZDh5Zlk2QkpBZjRWN1V0aHBFUWtvdEtBZDI4TkExNm5DbFEwVVJPVFdS?=
 =?utf-8?B?ZUVhWkxLOG80Nk9UVmRGRkdwTFBMM2V0ckVaMGs1R0RxQjkzc1ZFblJSRDNu?=
 =?utf-8?B?MVp5Z0M2QWxnaG4rZit4Tk0yakxJMVc3c1BUSFpySmVxLzVlSnBaM3U1MXVM?=
 =?utf-8?B?ZDQ2R0Z5eGV6V1UvMnhMMm43dzNkSHBpWndlczlHYitEV1FpQ2R4QXQ2cit6?=
 =?utf-8?Q?yBn3vhJqXBYqJMLYV7lW1TU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500df16a-5526-4f59-4513-08d9979117c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 08:26:07.3612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHRXKzII2xd22FKa6Xdmpaz2IYgyN5hWc9Iw+UZc7aRsUwio5qZZnpP3sRbmP29xXwBJPFVc3lhm9Okcn0MVVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, October 25, 2021 1:38 PM
> 
> It depends on what will the user be able to do then.
> Inject packets? Affect RX routing? Use up networking resources?
> NET_ADMIN is a safe choice but we didn't check any capability in the past so it
> seems reasonable to keep not checking it for the time being unless we see an
> actual security issue.
> 
I will keep the NET_ADMIN as it is doing the interface config.

And also add the comment around this check as you suggest in other email.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
