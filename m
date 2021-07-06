Return-Path: <SRS0=EgWE=L6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BFFC07E9B
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 17:07:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC77E61C4C
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 17:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC77E61C4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E08E4058B;
	Tue,  6 Jul 2021 17:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gpxUUYKWakkT; Tue,  6 Jul 2021 17:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AF0DE40592;
	Tue,  6 Jul 2021 17:07:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88C5AC001A;
	Tue,  6 Jul 2021 17:07:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F394C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 17:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 119F5608D3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 17:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mtST6tsGVrkQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 17:07:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::628])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8830160697
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 17:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C++R4PJNxyXuLntV+yKBnqWNGuaQQA1sIw/AyeCKkiskksjZjfOd8DP+tft66dWpbhsCRXau0y+4goV6ipQCcXq2aSDANUT1uwZZvB9Z4/e6T/EJqKMmdl/L4z8XZ+gA2wXhuu9DPp38evW52IYSX4KAIZHl8o41ujm4kbQU7k6GI4uehytkA8PvdWcSdvksOxsZXHJY9r03xjpvrs+6X72FCrF+3M9k0SCEe5SDxB1ebBjmjHjS3NRsR623PxVqrDLHyCgJFAiMlftroY3Vy6t5CKl2xVKcksBv3KhpwwrJRS92pp4xOzumQhHXzK7ekEelH7Xw6ODGPMDubrDumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBOA6GM60+auRvd5nEZtNOh1Kk5RhAdSyFRZnpEMz6U=;
 b=ZX970YqnCgNVWJIdmJI/OM0u8gBWTMQxvHXfOetu+XWu7QKKu++1zuvBq0jX1mVzCBdV7mCeMTtErVQOiaDwICo6gK2oSiZjoq1mDiTD3WI9fDTXQSuzvhi9KwRmHzpqFMRx8aEZb1eP6eY0SVSTN8PqwPnvBH1YJQRjeBQu+skUciGeXVX9cXp7MAU8K/rVIrD4CiPCkN+TisCK92gsf1lbYjxWaHKGgskdR2ycrXmRs2FGFxnpocwjKnLWkGAdaJyZBzIxS3vDQ3QD4DN6O7zio3eKyLAkO6+1N6+UhaU+7TfqSM7XrX0zWBMAYB87MTz+TdXijD9eiYG9CVYBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBOA6GM60+auRvd5nEZtNOh1Kk5RhAdSyFRZnpEMz6U=;
 b=nkYKWbWukF/5fJ/JZfp2SRo9tmWuX3aZyuPdy26b4izlJVKEKmMvvEV7s2LBN0OHhiNM5lUQpQ/5u+4cQAg5d2sUiPedMqmJsesVIsGULmqwvJDGwJ5qX6VN+QG/GiGclshWfTjV3cl37L4eXdHAyqyRRK132v62MoUwLUyWwR//03+M6NFh/l2H3/FmqVuDjuQuKRRondV5O7ZUnG1Cn06vM/mh+V7XZtm7LAb9M/hqgoNuwqoLkm/MgutiUE+8Ch/fLRKSE+0t0UIYP/T/glEryKUH1MTteU0yIetuM9lLPf8vMJpLyDS3OvQVQrqsM5xeJ0/nofw7yEWVtYFXIg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 17:07:19 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 17:07:19 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KCAAO8RAIAAAJPAgAGsGACAAAPf8IAAEweAgAAIirCAAU1RAIAAMiFQgASfUwCAAF8F0IABH3+AgABhb2CAATvVgIAAFmuQgAFr2YCAADSRMIAAER6AgAFvJLCABKWcgIACYVcg
Date: Tue, 6 Jul 2021 17:07:19 +0000
Message-ID: <PH0PR12MB548128DD7A4DC7441981809ADC1B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
 <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7a0a8bdf-4cd2-2fc2-73a5-53fb2ab432b6@redhat.com>
 <PH0PR12MB54819F782D5D7E6F9DCDF5FEDC069@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5350f5c0-c707-c3ec-8ed8-16c884467ffa@redhat.com>
 <PH0PR12MB5481030671D848D951477571DC039@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bf6ec662-b53d-174f-53e2-735589f83d3d@redhat.com>
 <PH0PR12MB548115ACBDA9D76526C370B3DC029@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8c78b8ed-e16c-31dd-7c1c-abd2bef6bb12@redhat.com>
 <PH0PR12MB5481737F058FDE9B947C1ECFDC019@PH0PR12MB5481.namprd12.prod.outlook.com>
 <a23cdc3a-80cb-f5aa-e77c-4b897c8456af@redhat.com>
 <PH0PR12MB5481AC0B0D9D0AC3A62A5EB1DC009@PH0PR12MB5481.namprd12.prod.outlook.com>
 <da0c4e7f-8b59-51ed-f694-04fe5a9ed0b9@redhat.com>
 <PH0PR12MB548102128B368BBE47F5F000DC1F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <386cf5c8-2f1f-8891-2448-5b6e98f51ea2@redhat.com>
In-Reply-To: <386cf5c8-2f1f-8891-2448-5b6e98f51ea2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b1f61d4-4841-4a22-889a-08d940a0838c
x-ms-traffictypediagnostic: PH0PR12MB5481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54816F2339EBAC21C727112EDC1B9@PH0PR12MB5481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +2lYwsqlMh8xKAIVVSI3kONx0vhEjRPYpcYs3YxYEIvRcey/Rlf7p+6av1TNPsjkCO8TlbaOSzgYebNcBTAZlI+wltUhPTTAdUwPbgJp5uknfw/w+k8W62i5Bnvlsoua8zQa5J6E6JrXBMAo8XtxeGbKt91lPaKsPO0HHYriRw/0pcDmZcv6SNGfN2tu13D2vbMElUaimVDWxNDjHWe/BxgX0dO9B2EQfu1vPoduapb0StYgRGM4qNEYJ+XSfgdzgYTwelCoqbUi4pdFeCPbwjCUhZvirz47/L9ONCOpF7wPzTkPmtZKQz7vr2SsOjJgQOMnoN5rNpsnKkWffiLOzHfrf5T1SbqEjJq2678EqXkNDqpUfKoLVqW5QUJ/chihE/P+9842Q3oifevbOxcGHR4TroKfoavNAYucrMvrWnBIwZgnqmstUBj4EM9Pec9Razw/nooctbYZkutB4CdXbw20kxZl+jlMYLG/Pe37h9IBSF+GZFhVnO5GNpP6nTI7ngClydU7MV0ZgJI9Pv7AeDEZQOedFaPHLQuv47jJ8Cl27fER7JwauF03rAy/BWCbFIwS814V0OhOCptqoZujqBIfcL4jdfbCVVdHSuAADtOzoAAbtORg3Mr5KLboKfECDzbGSKy0sVS3PffKwZi/tg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(54906003)(110136005)(7696005)(55016002)(55236004)(52536014)(83380400001)(4326008)(6506007)(186003)(2906002)(26005)(5660300002)(66476007)(478600001)(33656002)(71200400001)(64756008)(316002)(66946007)(107886003)(86362001)(9686003)(8676002)(8936002)(76116006)(122000001)(66446008)(38100700002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW1ZWUgyVEFXdTZzd00vUVRuZUVyLzhIRk5IbEdwRWZKR2tQWVBIQ2hLVFN4?=
 =?utf-8?B?UnhWbDNZTmQrTjAxVmxpNUJ4TVFIZ010aXl2ZTN3VUdhWEtydVBRNkYveXFP?=
 =?utf-8?B?YzRVTkxOTXdzc2RWMFE1bkY2RSszWDE3K2pRQkxOc0FaUVBrazlxeTR0RnpR?=
 =?utf-8?B?azFjYm0zRDRYdkF4Q1BGOTNQMDQ3NjZTR3JDSStoQnYrWUtlU08wQjhjNkVN?=
 =?utf-8?B?d1Q3T2g3R3RwMmFoSVBqRS9Sa0c3T3VDS0s4Q3F5bnhMaG9oazBxVnRmQXRI?=
 =?utf-8?B?cXpFdmN5R2N2SWpya2ZpazdxaFVSL21FQWFTR0gvU3Q5SVhPQkU2VkdVMHQ0?=
 =?utf-8?B?M2kraEZIUG1SOU9pR1FLRTdpdEJ0ZE9Mbkp4Ry9BSWNkeDVpTFd2SHBieXdD?=
 =?utf-8?B?aHNBdm9IUWNxZ1ZuQjZaMWVMdXNyeWtROEx4TzIyMEM0UGNDNVJPQ29icVh5?=
 =?utf-8?B?UWNEWDlVVk9uUjZMSmo5blorUUpkZktubjdJb3p5U29aQUphdHJLZTJ1VUFJ?=
 =?utf-8?B?ZldWMHByendmTWpxZ3ViOHZuSG92NjB6ZEhSVHczOU9KbEhtRDNSaVJGME50?=
 =?utf-8?B?anB1UzllUzJWTDNRVFBST3ZBVXdjUnNrZ1JjQkk4dTRmc2grYTZPU1dHZFN0?=
 =?utf-8?B?QkdaVUllZkRHVFdkYVlJSVRDSnU0NU5uMWpHTFB6VHowYU9Xc3NEYk11VEE2?=
 =?utf-8?B?Nmg1Q2dDNDQ4aHMxNzMxSWcxK2lsaXUwYm9oS3JxRmN0TXRCd0U0V1lxbEpI?=
 =?utf-8?B?Q1ZxOFU3Y2UyY1QvMjNnOTBCcVZvd0h4ZHZ0ckdGdlRXT0hoU2VralpFWUU0?=
 =?utf-8?B?WTQ1UlB5L0tuT29sQXo5bTJYaEFJbGZ5eDA0c3I2T2NhRHNRNnQzN1hPamNX?=
 =?utf-8?B?NHdlRWRBcVpYamtLQnhHTzFVdXE5ZFNaWTJqV0NxVFZGK3ZYY3Y5cVcrbUVs?=
 =?utf-8?B?MklCeXN1VTdLVWdvZFdtUjd5N2dmbHRUbUdvV3VaV2tRZk9kb1FJTnVXWVky?=
 =?utf-8?B?VEsyM1oyWDhocEhYeHhRbTByWTQrNWFIdTdQbDNJZ0E2Y3NERTkwSERVWG95?=
 =?utf-8?B?THNidmpRcGdGd3hQVWpraDRBaHBwaFJJZWhsVHZtTTFtemJzczlsd3IzWGpF?=
 =?utf-8?B?QldnSTZSUFIvNU55TzFxQ0xxZUp2OSsrRGg0VS9udXRNM2dkRTZZYjJNNjhB?=
 =?utf-8?B?bUxPUjducFM1RjZoZmVVRkpSRk9vSmk3Q2RHTDhpaFBiQ2FpOVZnZVdiZ1BV?=
 =?utf-8?B?MjMvV3EvOVhPRmZqVlNPMGNzYXQ4WXZ0ejhSd1NRd2p0cENtWnk4eUpGSkFJ?=
 =?utf-8?B?TGZmcmdXU1ZkZ09jNCt6d3BiUjErMXBNbFNERS9Za2FjTTNSenVJelpqamdB?=
 =?utf-8?B?NkYrSDFJK2hHWlFQM0RBOXBVY2xPSklzSkpaQTZRZ3RJRFRsSTBDRDZ2bU1n?=
 =?utf-8?B?Y0dsYVhQamRBWjFVZ2k2TWFLblNJSzZxd21RYXY2c2NzaUtMWVdrS1BwQnVS?=
 =?utf-8?B?YTJCbnhSVnprS2Nnb2QzR1FLWlo4dE9FdHlpMkNNai9za2dZYi9vRmxHZDhy?=
 =?utf-8?B?cDdTZ0dPVm5qbWMwam9uemZjSUs4YjcvWmpNUUJWdUxKcnhSOEVoUHROTndu?=
 =?utf-8?B?SVlFeW05Z0RsTDJNWWdsVGd0OXE2QVRIQlpyeGpvT1FrcHNMajE0c0tYSjE5?=
 =?utf-8?B?SHpuZ3JSeUZsSGFGZFUvdlN6eFFNRFl3eVJZbzNFd1R1WXF0b2RlWnlDWUtF?=
 =?utf-8?Q?LZ2AThaw3SKoZFpcNlypmN34TcGJy3Q2lE10PCc?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1f61d4-4841-4a22-889a-08d940a0838c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 17:07:19.4461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvbb/rF23AluqpkaGUHuppzX9qN5acPDqrflsmbrCb8Kh5hd020HTLKISOqFpwOT6XfZ1fpk6INMvPAySgEqqg==
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

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBKdWx5IDUsIDIwMjEgMTA6MDUgQU0NCj4gDQo+IOWcqCAyMDIxLzcvMiDkuIvljYgyOjA0
LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOg0KPiA+DQo+ID4+IEZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDEsIDIwMjEgMToxMyBQ
TQ0KPiA+Pg0KPiA+Pg0KPiA+PiBBY3R1YWxseSBpdCBkZXBlbmRzIG9uIHdoYXQgYXR0cmlidXRl
cyBpcyByZXF1aXJlZCBmb3IgYnVpbGRpbmcgdGhlIGNvbmZpZy4NCj4gPj4NCj4gPj4gV2UgY2Fu
IHNpbXBseSByZXVzZSB0aGUgZXhpc3RpbmcgdmlydGlvX25ldF9jb25maWcsIGlmIG1vc3Qgb2Yg
dGhlDQo+ID4+IGZpZWxkcyBhcmUgcmVxdWlyZWQuDQo+ID4+DQo+ID4+IHN0cnVjdCB2aXJ0aW9f
bmV0X2NvbmZpZ19zZXQgew0KPiA+PiAgIMKgwqDCoCDCoMKgwqAgX192aXJ0aW82NCBmZWF0dXJl
czsNCj4gPj4gICDCoMKgwqAgwqDCoMKgIHVuaW9uIHsNCj4gPj4gICDCoMKgwqAgwqDCoMKgIMKg
wqDCoCBzdHJ1Y3QgdmlydGlvX25ldF9jb25maWc7DQo+ID4+ICAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgX192aXJ0aW82NCByZXNlcnZlZFs2NF07DQo+ID4+ICAgwqDCoMKgIMKgwqDCoCB9DQo+ID4+
IH07DQo+ID4+DQo+ID4+IElmIG9ubHkgZmV3IG9mIHRoZSBpcyByZXF1aXJlZCwgd2UgY2FuIGp1
c3QgcGljayB0aGVtIGFuZCB1c2UgYW5vdGhlcg0KPiA+PiBzdHJ1Y3R1cmUuDQo+ID4gVGhlIHBv
aW50IGlzIHdlIGRlZmluZSBzdHJ1Y3R1cmUgYmFzZWQgb24gY3VycmVudCBmaWVsZHMuIFRvbW9y
cm93IGEgbmV3DQo+IFJTUyBvciByeCBzY2FsaW5nIHNjaGVtZSBhcHBlYXJzLCBhbmQgc3RydWN0
dXJlIHNpemUgbWlnaHQgbmVlZCBjaGFuZ2UuDQo+ID4gQW5kIGl0IGRlbWFuZHMgdXMgdG8gZ28g
YmFjayB0byBsZW5ndGggYmFzZWQgdHlwZWNhc3RpbmcgY29kZS4NCj4gPiBhbmQgdG8gYXZvaWQg
c29tZSBsZW5ndGggY2hlY2sgd2UgcGljayBzb21lIGFyYml0cmFyeSBzaXplIHJlc2VydmVkDQo+
IHdvcmRzLg0KPiA+IEFuZCBJIGRvIG5vdCBrbm93IHdoYXQgbmV0d29yayByZXNlYXJjaCBncm91
cCB3aWxsIGNvbWUgdXAgZm9yIG5ldyByc3MNCj4gYWxnb3JpdGhtIGFuZCBuZWVkZWQgcGx1bWJp
bmcuDQo+IA0KPiANCj4gWWVzLCBidXQgYXMgZGlzY3Vzc2VkLCB3ZSBtYXkgc3VmZmVyIHRoZSBz
aW1pbGFyIGlzc3VlIGF0IHRoZSBkZXZpY2UgbGV2ZWwuIEUuZw0KPiB3ZSBuZWVkIGEgY29tbWFu
ZCB0byBsZXQgUEYgdG8gImJ1aWxkIiB0aGUgY29uZmlnIGZvciBhIFZGIG9yIFNGLg0KSSBhbSBu
b3Qgc3VyZS4NCkN1cnJlbnQgc2NvcGUgb2YgYSBWRFBBIGlzLCBvbmNlIHRoZXJlIGlzIGEgaGFz
IFBGLFZGLFNGIGFuZCB5b3UgY29uZmlndXJlIG9yIGNyZWF0ZSBhIHZkcGEgZGV2aWNlIG91dCBv
ZiBpdC4NCg0KPiA+IEdpdmVuIHRoZSBkZXZpY2UgY29uZmlnIGlzIG5vdCBzcGVsbGVkIG91dCBp
biB0aGUgdmlydGlvIHNwZWMsIG1heSBiZSB3ZSBjYW4NCj4gd2FpdCBmb3IgaXQgdG8gZGVmaW5l
IHZpcnRpbyBtYW5hZ2VtZW50IGludGVyZmFjZS4NCj4gDQo+IFllcy4NCldhaXQgaXMgbmVlZGVk
IG9ubHkgaWYgd2Ugd2FudCB0byBjYXN0IFUtPksgVUFQSSBpbiBhIHN0cnVjdHVyZSB3aGljaCBp
cyBib3VuZCB0byBldm9sdmUuDQpBbmQgaGVuY2UgSSBqdXN0IHdhbnQgdG8gZXhjaGFuZ2UgYXMg
aW5kaXZpZHVhbCBmaWVsZHMuDQoNCj4gPj4gSXQncyBub3QgYXJiaXRyYXJ5IGJ1dCB3aXRoIGZp
eGVkIGxlbmd0aC4NCj4gPiBJdHMgZml4ZWQsIGJ1dCBkZWNpZGVkIGFyYml0cmFyaWx5IGxhcmdl
IGluIGFudGljaXBhdGlvbiB0aGF0IHdlIGxpa2VseSBuZWVkIHRvDQo+IGdyb3cuDQo+ID4gQW5k
IHNvbWV0aW1lcyB0aGF0IGZhbGwgc2hvcnQgd2hlbiBuZXh0IHJlc2VhcmNoIGNvbWVzIHVwIHdp
dGggbW9yZQ0KPiBjcmVhdGl2ZSB0aG91Z2h0cy4NCj4gDQo+IA0KPiBIb3cgYWJvdXQgc29tZXRo
aW5nIGxpa2UgVExWcyBpbiB0aGUgdmlydGlvIHNwZWMgdGhlbj8NClBvc3NpYmx5IHllcy4NCj4g
DQo+IA0KPiA+DQo+ID4+IEl0IG1heSBvbmx5IHdvcmsgZm9yIG5ldGxpbmsgKHdpdGggc29tZSBk
dXBsaWNhdGlvbiB3aXRoIHRoZSBleGlzdGluZw0KPiA+PiB2aXJ0aW8gdUFQSSkuIElmIHdlIGNh
biBzb2x2ZSBpdCBhdCBnZW5lcmFsIHZpcnRpbyBsYXllciwgaXQgd291bGQgYmUNCj4gPj4gYmV0
dGVyLiBPdGhlcndpc2Ugd2UgbmVlZCB0byBpbnZlbnQgdGhlbSBhZ2FpbiBpbiB0aGUgdmlydGlv
IHNwZWMuDQo+ID4+DQo+ID4gVmlydGlvIHNwZWMgd2lsbCBsaWtlbHkgZGVmaW5lIHdoYXQgc2hv
dWxkIGJlIGNvbmZpZyBmaWVsZHMgdG8gcHJvZ3JhbSBhbmQgaXRzDQo+IGxheW91dC4NCj4gPiBL
ZXJuZWwgY2FuIGFsd2F5cyBmaWxsIHVwIHRoZSBmb3JtYXQgdGhhdCB2aXJ0aW8gc3BlYyBkZW1h
bmRzLg0KPiANCj4gDQo+IFllcywgSSB3b25kZXIgaWYgeW91IGhhdmUgdGhlIGludGVyZXN0IHRv
IHdvcmsgb24gdGhlIHNwZWMgdG8gc3VwcG9ydCB0aGlzLg0KPiANCkkgYW0gaGFwcHkgdG8gY29u
dHJpYnV0ZSwgSSBuZWVkIHRvIGFzayBteSBzdXBlcnZpc29yIHRvIHNwZW5kIHNvbWUgdGltZSBp
biB0aGlzIGFyZWEuDQpMZXQgbWUgZmlndXJlIG91dCB0aGUgbG9naXN0aWNzLg0KDQo+IA0KPiA+
DQo+ID4+IEkgdGhpbmsgZXZlbiBmb3IgdGhlIGN1cnJlbnQgbWx4NWUgdkRQQSBpdCB3b3VsZCBi
ZSBiZXR0ZXIsIG90aGVyd2lzZSB3ZQ0KPiA+PiBtYXkgaGF2ZToNCj4gPj4NCj4gPj4gdkRQQSB0
b29sIC0+IFtuZXRsaW5rIHNwZWNpZmljIHZEUEEgYXR0cmlidXRlcygxKV0gLT4gdkRQQSBjb3Jl
IC0+IFt2RFBBDQo+ID4+IGNvcmUgc3BlY2lmaWMgVkRQQSBhdHRyaWJ1dGVzKDIpXSAtPiBtbHg1
ZV92RFBBIC0+IFttbHg1ZSBzcGVjaWZpYyB2RFBBDQo+ID4+IGF0dHJpYnV0ZXMoMyldIC0+IG1s
eDVlX2NvcmUNCj4gPj4NCj4gPj4gV2UgbmVlZCB0byB1c2UgYSBzaW5nbGUgYW5kIHVuaWZpZWQg
dmlydGlvIHN0cnVjdHVyZSBpbiBhbGwgdGhlICgxKSwgKDIpDQo+ID4+IGFuZCAoMykuDQo+ID4g
VGhpcyBpcyB3aGVyZSBJIGRpZmZlci4NCj4gPiBJdHMgb25seSB2ZHBhIHRvb2wgLT4gdmRwYSBj
b3JlIC0+IHZlbmRvcl9kcml2ZXINCj4gPg0KPiA+IFZkcGEgdG9vbCAtPiB2ZHBhIGNvcmUgPSBu
ZXRsaW5rIGF0dHJpYnV0ZQ0KPiA+IFZkcGEgY29yZSAtPiB2ZW5kb3IgZHJpdmVyID0gc3RydWN0
X2Zvby4gKGludGVybmFsIGluc2lkZSB0aGUgbGludXgga2VybmVsKQ0KPiA+DQo+ID4gSWYgdG9t
b3Jyb3cgdmlydGlvIHNwZWMgZGVmaW5lcyBzdHJ1Y3RfZm9vIHRvIGJlIHNvbWV0aGluZyBlbHNl
LCBrZXJuZWwgY2FuDQo+IGFsd2F5cyB1cGdyYWRlIHRvIHN0cnVjdF9iYXIgd2l0aG91dCB1cGdy
YWRpbmcgVUFQSSBuZXRsaW5rIGF0dHJpYnV0ZXMuDQo+IA0KPiANCj4gVGhhdCdzIGZpbmUuIE5v
dGUgdGhhdCBhY3R1YWxseSBoYXZlIGFuIGV4dHJhIGxldmVsIGlmIHZlbmRvcl9kcml2ZXIgaXMN
Cj4gdmlydGlvLXBjaSB2RFBBIGRyaXZlciAodnBfdmRwYSkuDQo+IA0KPiBUaGVuIHdlIGhhdmUN
Cj4gDQo+IHZkcGEgdG9vbCAtPiB2ZHBhIGNvcmUgLT4gdnBfdmRwYSAtPiB2aXJ0aW8tcGNpIGRl
dmljZQ0KPiANCj4gU28gd2Ugc3RpbGwgbmVlZCBpbnZlbnQgY29tbWFuZHMgdG8gY29uZmlndXJl
L2J1aWxkIFZGL1NGIGNvbmZpZyBzcGFjZQ0KPiBiZXR3ZWVuIHZwX3ZkcGEgYW5kIHZpcnRpby1w
Y2kgZGV2aWNlLiANClllcy4gVGhpcyBpcyBuZWVkZWQsIGJ1dCBhZ2FpbiBsZXRzIGtlZXAgdGhl
IHR3byBsYXllcnMgc2VwYXJhdGUuDQpJbiB0aGUgZXhhbXBsZSBJIHByb3ZpZGVkLCB3ZSB3aWxs
IGJlIGFibGUgdG8gZmlsbCB0aGUgc3RydWN0dXJlIGFuZCBwYXNzIHRoaXMgaW50ZXJuYWxseSBi
ZXR3ZWVuIHZwX3ZkcGEtPnZpcnRpbyBwY2kgZHJpdmVyLg0KDQoNCj4gQW5kIEkgdGhpbmsgd2Ug
bWF5IHN1ZmZlciB0aGUNCj4gc2ltaWxhciBpc3N1ZSBhcyB3ZSBtZXQgaGVyZSAodmRwYSB0b29s
IC0+IHZkcGEgY29yZSkuDQo+IA0KPiANCj4gPiBOZXRsaW5rIGF0dHJpYnV0ZXMgYWRkaXRpb24g
d2lsbCBiZSBuZWVkZWQgb25seSB3aGVuIHN0cnVjdF9mb28gaGFzIG5ld2VyDQo+IGZpZWxkcy4N
Cj4gPiBUaGlzIHdpbGwgYmUgc3RpbGwgZm9yd2FyZC9iYWNrd2FyZCBjb21wYXRpYmxlLg0KPiA+
DQo+ID4gQW4gZXhhY3QgZXhhbXBsZSBvZiB0aGlzIGlzIGRyaXZlcnMvbmV0L3Z4bGFuLmMNCj4g
PiB2eGxhbl9ubDJjb25mKCkuDQo+ID4gQSB2eGxhbiBkZXZpY2UgbmVlZHMgVk5JLCBzcmMgaXAs
IGRzdCBpcCwgdG9zLCBhbmQgbW9yZS4NCj4gPiBJbnN0ZWFkIG9mIHB1dHRpbmcgYWxsIGluIHNp
bmdsZSBzdHJ1Y3R1cmUgdnhsYW5fY29uZmlnIGFzIFVBUEksIHRob3NlDQo+IG9wdGlvbmFsIGZp
ZWxkcyBhcmUgbmV0bGluayBhdHRyaWJ1dGVzLg0KPiA+IEFuZCB2eGxhbiBkcml2ZXIgaW50ZXJu
YWxseSBmaWxscyB1cCB0aGUgY29uZmlnIHN0cnVjdHVyZS4NCj4gPg0KPiA+IEkgYW0gdmVyeSBt
dWNoIGNvbnZpbmNlZCB3aXRoIHRoZSBhYm92ZSB2eGxhbiBhcHByb2FjaCB0aGF0IGVuYWJsZXMg
YWxsDQo+IGZ1bmN0aW9uYWxpdHkgbmVlZGVkIHdpdGhvdXQgdHlwZWNhc3RpbmcgY29kZSBhbmQg
d2l0aG91dCBkZWZpbmluZyBhcmJpdHJhcnkNCj4gbGVuZ3RoIHN0cnVjdHMuDQo+IA0KPiANCj4g
UmlnaHQsIGJ1dCB3ZSBoYWQgc29tZSBzbWFsbCBkaWZmZXJlbmNlcyBoZXJlOg0KPiANCj4gMSkg
dnhsYW4gZG9lc24ndCBoYXZlIGEgZXhpc3RpbmcgdUFQSQ0KPiAyKSB2eGxhbiBjb25maWd1cmF0
aW9uIGlzIG5vdCB1c2VkIGZvciBoYXJkd2FyZQ0KPiANClRydWUgYnV0IHZ4bGFuIGV4YW1wbGUg
ZG9lc27igJl0IHByZXZlbnQgdG8gZG8gIzIuDQoNCj4gQmFzaWNhbGx5LCBJJ20gbm90IGFnYWlu
c3QgdGhpcyBhcHByb2FjaCwgSSBqdXN0IHdvbmRlciBpZiBpdCdzDQo+IGJldHRlci9zaW1wbGVy
IHRvIHNvbHZlIGl0IGF0IHZpcnRpbyBsYXllciBiZWNhdXNlIHRoZSBzZW1hbnRpYyBpcw0KPiBk
ZWZpbmVkIGJ5IHRoZSBzcGVjIG5vdCBuZXRsaW5rLg0KDQp2ZHBhIGNvcmUgd2lsbCBiZSBhYmxl
IHRvIHVzZSB0aGUgdmlydGlvIHNwZWMgZGVmaW5lZCBjb25maWcgd2hlbmV2ZXIgaXQgb2NjdXJz
Lg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
