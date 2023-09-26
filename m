Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B9FE7D0C5
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 05:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31153613C6;
	Tue, 26 Sep 2023 05:27:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31153613C6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lSkY857e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k3uHsFFUvM6n; Tue, 26 Sep 2023 05:27:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B92166134E;
	Tue, 26 Sep 2023 05:27:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B92166134E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8047DC0039;
	Tue, 26 Sep 2023 05:27:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69CF3C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E5D06134E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:27:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E5D06134E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sf2L0m9tyUOQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:27:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA347612DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:27:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA347612DE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej1VYymaYrvDU1DrNPfyIBdxu1iY6BqFJP//vnKOIoswWo+gNpFBSaWNLw5W3EAB3mbwJRzIDbkpOqpkFNBpLa9gfo+FDr00LfU4YP+Ocl4pWqWx1/AfmIkzfSMTMdFNYwRtsmKh13mKkC0QpGfRZYI2DOKU79EsRTSZz+kyEBbtmz7DzPBTtrxuGbqaZB2aWrJNpjRnaEeROeNVwlNqZmT0IWJyqUBu6Rb6W5zICVPOv9lNPs7DABT3/gbAouDjsSWWKfUsssvs4rinUvmUBul3pv24+wEvgEXwdHpI1vF0oXh0aU/YvqXYDvlquGCm4k+iMNJTP78QFMl3cjoRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcN4yuNaSGPdspWfIXhn0FbrJwlC94yh+Fps9f3goGM=;
 b=m6qwdwiSRJuOnjyDn19v+YcD8nAb/9LJB2UMHFBaE5jSo+snnArnr3PwkLpXAgNvpnslBpoT2v3Gj5Ibwf1VKzLVBDT1S/hZOpqwS+bZqPEuC/e5XWgDkt6374YiUGfGBtWMRnGLlSE30d8P51U1z9bAAywV59lR/nro0PmVyUef7aIVaughIM/3VcrczVI71+Vws0oSESAoEL+NkpFCYS7CJkHZHKRKNUBgMBng5hlOPNa/kch67I0Q4NNud2NDj91K5wgvlveGvzD//c8vMJH2cVb1uXvpvAiYzBaTIwdVSdiWhASku4QkJe5ZMpJQdQHdjI/RbFZK9m2RIPQtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcN4yuNaSGPdspWfIXhn0FbrJwlC94yh+Fps9f3goGM=;
 b=lSkY857emmC6WCEqoT9evycDEj6fdlvAHGslXMufvWTxn1XcSpHSFbH0wUqlcmfCJFSLCt9ZM0jQVmmOoa8Bm5O2k7XflL8pFokv85N8b6TH9sJaZdLG3Flvrmr95MkRDKFaXS660edfTJflABD54/WZVVfxBd/bjKjjeCuPetLOwm0BrFeJB1dfgJboNXs9w93Zq9sqJIL6sMxUNLbTXnlkMOPFHAnD8DI8tzKYaVD7qjCDd/CI7FpzbxH9lgTpmc670EbsHnqfEksIPNELT797rLDBBXr7wKCl5jDtBbMMw4NQSKZuW9+4qLHSaMJ9JY3deuMbhNJjxsUfXUqalg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 05:27:32 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 05:27:32 +0000
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Topic: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Index: AQHZ7IkPl5ENqOgMC0yEzkOHANq/CLAlfIYAgAACZQCAAAJ1AIAAAaqAgAAD/QCAAAaKAIAAAwkAgAAF2ICAABWjgIAABYGAgAAGVYCAAHFrgIAAnJQAgAAAJ7CABBFQgIAAYeqAgAExEoCAABiE4IAACkCAgAAN5JA=
Date: Tue, 26 Sep 2023 05:27:32 +0000
Message-ID: <PH0PR12MB5481D6C85F71188B3F26BA90DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
 <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEv9_+6sYp1JZpCZr19csg0jO-jLVhuygWqm+s9mWr3Lew@mail.gmail.com>
 <PH0PR12MB5481304AA75B517A327C5690DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtfYu5zO1Dn7ErKid15DaDd3nm3yyt9kWsE-FVv-U8D0w@mail.gmail.com>
In-Reply-To: <CACGkMEtfYu5zO1Dn7ErKid15DaDd3nm3yyt9kWsE-FVv-U8D0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB9060:EE_
x-ms-office365-filtering-correlation-id: dbd08a63-e23d-433b-ee53-08dbbe5148d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tHHy/IYUCh3gOHWEt1HnmaDJDSSZ0xkqXFfeIwkyHlsY787z8Zo+ccYCfo7iHDRvFt0c6XaFGYGxjU/UEGyskFXgZ1Z4Ka/pxe9AhE3eHd1NVP3OQbYhp6piADJkGG2CaKD7LnYWar8dE3YTgq4gVfrSE+rPMRwMDZnXygkLzsZOzpiy5GQGJ4eYtvNhBEtT8rgHBi1ps264S/ZmKzIkWx6be7tu01zYvLANF9f+rvtosKax5ZMfVjwlKedavxsj/yr3iXctZ8bkDRie0+2X9hEXtJ65E6QESYlTk5bP+MgHW09ygPSoUWAREzBM905kM6AcPztrKx0roddPtFTcNChmM3SxMMLvqD/xWAJUK78GCgNFGw3AXMV4sSpCuljzeewETTCo5qzb0cEOjtwrAzVhEyfIvjcte35USARKYMAPt3ApG2xAu2mjRyVvRlKclARFPKbW66ZA8+gdL6CtspclHW0ujD7+/yt0ykHjsmqqDwad3lP+efJLsb/7ptaUUfPYKVHJBeeV+V8w3s/N1VSN7adz95I4KyZDNp1HEHFNKAykHiCvYpg6MPPz93NHNZMXoyNnR/9LUJV0m/aLE1xiuTbaP350oaC7W3+g0zFcnDJC6JA9T2vdD/wB7Qel
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(55236004)(38070700005)(478600001)(122000001)(41300700001)(71200400001)(2906002)(558084003)(6506007)(107886003)(33656002)(86362001)(38100700002)(26005)(316002)(9686003)(7696005)(54906003)(64756008)(66476007)(76116006)(66446008)(66946007)(6916009)(55016003)(66556008)(8676002)(4326008)(8936002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXdUTGU0QkVkdTVaMkFSdlI5RmI0dE9zbHFMY3ZKZnllZEgzaFhPeVY2NytZ?=
 =?utf-8?B?dGZMZHdHWUUyTWUreFBjYXdlK2NtN2hzTkF4Q1VOVmdHR2M0T2RveDNLTTVC?=
 =?utf-8?B?Z0gwaWYvZE9QYnMwcFlEWFZzSFJuS0tWTTdFNnpWRTg2V1VhVXJoUm1kb29y?=
 =?utf-8?B?eWVxQTBrdzZmeS9HSFVYN2JYaGNwbzMyU2xLbExWM040RURRZ1JKVnBqcmsv?=
 =?utf-8?B?dHN0anZVdkN0TCtMVTVhSnAvYlVSQnBqbndYSElrdnY1ZUZYYjZoQ2xlYlRD?=
 =?utf-8?B?ZDFVRU45QzJYRXBHN1IzRVBUUjljeWhuTkZYVHhwMFhwd09HOE1OOVIxYnY2?=
 =?utf-8?B?WWJrOEwwc05EaVJwSmFldHd4T0xoaVZXK2IyR3lBaC9jU211cDd3eVV0ZDBK?=
 =?utf-8?B?ZVpjUWpsMkVZUmhocEtmcW5qSG1tcUNWKzYwNEtiTVNhVzdyb3o2SG55aHdk?=
 =?utf-8?B?RGRTV003L2ZnckVSTmRBcCsxSGhtNndzVld3S3BHeVhqM0RTcVU0eHd0bkU3?=
 =?utf-8?B?UmtYb2pqaDZkTjBWSXpwNWNoaHFVQ3dtK1d3NzZQRll3OUZVSGtNcHZKbXI2?=
 =?utf-8?B?S1NiQ09VRTJGZzEzU2k4SWN2eE02QmM1VU9MUkJVT2hhaytvbWlzcGlYQ0ZJ?=
 =?utf-8?B?S1dmQnUvc2RMTjFSVnlJTnlIaEIwcnI0d0NhNU44MEducUt3azRUSFdlbmpo?=
 =?utf-8?B?VW9acEw4VWk4TjhrVEFQQ3hNcDlQUWIyblB2c3JrYmFnYXBNZUZ4NWZCOGdl?=
 =?utf-8?B?U0RUTDlxbmhqWU95amJPa0JxQWRNVDErR2oxalIvUnNRNHl3dEJKMTd0S3pK?=
 =?utf-8?B?L0JxUUxUS0tPS3ZJWVFRaUpYbmlPalJIQTFlOU1telIyTHVtUUVYcHNPQW44?=
 =?utf-8?B?ckh3SmdpV0ttaWRoSUpVckdGQkdUVTVsQ2ZqaEgyNzdHRGtwMWdWQjlDZ1pP?=
 =?utf-8?B?N0FJZ3VDQVJDVzJuL2lzYUFXdjZmcFFqdVUrbXVaZDI5cTMvQVFCM2xXT1lI?=
 =?utf-8?B?ZVcyUDR6MkluL0FtN0pabzRwUm54eURmakl3UGMyVDVscmRGb083eWhIZEM3?=
 =?utf-8?B?OUZuTk5pY0xIeEJDWEozUjI2cGJmWE1yU2EvcHRaODJWR1NzcDJldUFxeHJC?=
 =?utf-8?B?cUhHVlRSREE5T0Jma09RNHlHYlAvWHh6OVZIZzZZOEVBSStEWUFmMkxUNkUw?=
 =?utf-8?B?b1F0d09EZWoweTh6Q0o1dmlWWWNTV1lGbTkxRklRR0I5bmk5UkxOejhZcm9I?=
 =?utf-8?B?NU03a2UvSUZZdE03WndFclZGRWJRRlhMZ1k5U2VtcG56VVBkSm9DWHhWVFNz?=
 =?utf-8?B?V3ZqejM0SkYwd2VkTG40WDFFUWNmcjZxME11Tzc1Vzl2SEQwWmlWaHVEWXVY?=
 =?utf-8?B?bzNqb2RhZlhuNWw4ekVMWk5RNzcxa21kM3c0UmtLRG04MWhmcmNoOXpiTVVn?=
 =?utf-8?B?dEtYcEU3eUNHSzlpLzhvRjlpUEZld2FtS0ZTNHRwanNKYUdQdWFlL0dkS3h0?=
 =?utf-8?B?YWdkeEZsYXYrckNCTGJPU0wrRlduanRZUTVVYmtqeVlod3VISUp1TmRrWHlT?=
 =?utf-8?B?bkY5amtrbHg1My9UaEFoRUttSU1UUk1MZWV0ckM0bnp1YmlPZzBLWHdOYUFD?=
 =?utf-8?B?aStEaHpIRGdxOHZwQzdPMzdwTTVJRVBjMnErTDR1Qm40ZWd1YlBYdFNWU3ZY?=
 =?utf-8?B?VUQyNDlrU0tJT1YyOEhsREROcjVKY3M4dkhaU2xwM1VpVnExZk1ldklYSG9s?=
 =?utf-8?B?OTUwdVNuOTJLKzAxRk96bHppcUVJcUxQSS9sTGIvdk1tN0N1YkpTc2hDVlFF?=
 =?utf-8?B?c2ZRUDNTaThPS24xVVpYSFQwV0hSV285bzdpenhBcUtiYVVXeGEvaVpZNXQv?=
 =?utf-8?B?MHpCL1V6dXVJcWdWb3dsVHdhbW52SGlVeHY4UGtHanJ5anJReC8wN1p4aHJz?=
 =?utf-8?B?U2NNbzZLOGV2eTZJc1JOUUFqYmFocXh6OHcva0V0Y2RqamY1VWtIV0hQdW5S?=
 =?utf-8?B?T3dxbkRiOC9EVHRqSXlBZlJQb1ZVQWV2by84NTJzekFSYmcwYVJQWE5kL3dS?=
 =?utf-8?B?eFZITjh5dXNDTzA1U0pISFZTRDk5WlVTSlJuMnFXZ2VKRVIwNmVuZGR6Q1c5?=
 =?utf-8?Q?8BQg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd08a63-e23d-433b-ee53-08dbbe5148d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:27:32.6788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NG6I/eKmL/uFMs2qComXB60/kwegL3or2f+gWt7x4XmO5PiJ2mJSAGtRRLNizrMEm+mQ4juXEiZcMDwhC21l8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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



> From: Jason Wang <jasowang@redhat.com>
> Sent: Tuesday, September 26, 2023 10:07 AM


> 
> If you can't find a way to make legacy drivers work, use modern.
>
Understood.
This vfio series make the legacy drivers work.
Thanks.
 
> That's it.
> 
> Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
