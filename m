Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E126C433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 17:24:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336B764DE9
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 17:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336B764DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF32A871D0;
	Thu, 11 Feb 2021 17:24:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6w33GUUXkjws; Thu, 11 Feb 2021 17:24:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1142386E08;
	Thu, 11 Feb 2021 17:24:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0A34C0174;
	Thu, 11 Feb 2021 17:24:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43886C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 17:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 369C08714B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 17:24:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dP6+YmbVm+O8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 17:24:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 82F3E86E08
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 17:24:16 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6025683f0000>; Thu, 11 Feb 2021 09:24:16 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 17:24:15 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 17:24:13 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS)
 id
 15.0.1497.2 via Frontend Transport; Thu, 11 Feb 2021 17:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAWbyJW+l57dH4l2jYu0UmRs8/OnO1iTJQb1wEHzBSBkQxT0ZRBKuKLSsztjgzFn14GVBSov6PB2dkwqQiVFm28/TkcNVgJ7dKGbJXkaS2d+kWgzNk4oqs1wyhIvG70fKhnpuHdGid9NDk/nAizfa37K51C/MXVQOXL7yRdxPbbV5VxVehcpxUcwk12RbiXZx0AyM6jOZGAqJIx8K6xdcB/pzW28N9RI9a9+nRJLUuiBX0SkiAPOBpYzUUz9bjCBpyAtoAwx3v2epQKRXATVsTQ5m3BnHUnFJ4OSuOhS9XWYeu5QuxYd8Auak9Sg6bI3Tg8u4Oh+rWtHzL4PGHCL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOctTVjLWOwkFAl/R2WoPaQs7ZW5/7J4fFxNmCsGaPs=;
 b=Xxu7TqxIhDm/RS/4fLsGVVO5sxszANrL5xrl5jUquSnNWkxemIwOnvMxCYJIcObqybkXKsY7ztvkje+LvQm2laLjHWyNT65FpYgxFxr2GyK/FB5iC5XDhtj3v0LuBDZELHa4aClsoVBs7lfD8uGhFV3vTFOtS+ptED1k+IlaX2Zs7kA1PCgBklBhf4VHm7D7tvtYJT1cJPVAyuJANKaeZaLAownAHSV0ZPxJF2Bwt3zGyxQgCnhFCchE7a34tzue5hF+LLOQrePG60CxyVngBI76lP48UJLR/gwnmiusOUSe0aiy5HJ/3JrXiuqFPKMUfcBJcLrD2oGY0pD9+1NiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 11 Feb
 2021 17:24:11 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%3]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 17:24:11 +0000
From: Parav Pandit <parav@nvidia.com>
To: David Ahern <dsahern@gmail.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH iproute2-next v5 0/5] Add vdpa device management tool
Thread-Topic: [PATCH iproute2-next v5 0/5] Add vdpa device management tool
Thread-Index: AQHW/9t3eDhjceI0nUqk+vH20hiwsqpTI9QAgAARoxA=
Date: Thu, 11 Feb 2021 17:24:11 +0000
Message-ID: <BY5PR12MB4322DEAF77F8614A1FB9F6B2DC8C9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210210183445.1009795-1-parav@nvidia.com>
 <f5748e77-0004-4452-c413-15272a594d76@gmail.com>
In-Reply-To: <f5748e77-0004-4452-c413-15272a594d76@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.167.131.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 380c4e63-a3a0-4d90-de93-08d8ceb1d8a7
x-ms-traffictypediagnostic: BY5PR12MB4114:
x-microsoft-antispam-prvs: <BY5PR12MB411421D7FA0B0D3FCC47B721DC8C9@BY5PR12MB4114.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9h9ayVzv77DEaotItczZswguHBAsEOmKLrAmVEEaJXPWQQsgp0w2yheO42bthk6ImPCTHZW4qaWPGOp58qsrxOqHrwwqZWSWR/NEmpEV1qx27kv6KPHsswgnzJf1RHjrjZl6MQjur4argWgosGY1qsDaaJYHkAcQ5m2nQw9lEemxNRKIrJq237RmRmC2mB2LJA17W6Sy7DfNfElqBuuscBxiZHPSeecs57BpVHVDkPlAkvwhftL1EsOG8tXA3ANZmGyVbpCPUzayvhYAF39ogY7ikkIoK4Dp2YNegLbfNKFhZojdZnvXhUul+2qgKiaiFiKbAXgoQQildS48Fwiodq/Osf2tc8HUEhWY/SBJ7HWmN/eyvXM6J2rFgnOv8tYoylVJ1IdmIIMpuwvYZa1ak9JUTMScTXhbEGbIJnIPXh8wI2ZpMU9srRqceQcq+oDZVPjs3KvzjnOzENn0IDpthMNCgJB2akVXCGkUyRWMFiz969tI6DC71EBTWieTHcDtUuRRRIrLSdKDWtMFQF4AaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(5660300002)(478600001)(71200400001)(33656002)(66946007)(53546011)(6506007)(76116006)(66446008)(66556008)(64756008)(66476007)(186003)(4744005)(26005)(7696005)(52536014)(8936002)(55016002)(110136005)(2906002)(86362001)(316002)(8676002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RnBOUTdFdnV3Y1NCQkd4eW55QVJFbmFuM3ora0dDQUt0OWRLcWVmeWorYjBv?=
 =?utf-8?B?L2hoTnNBUDJCS2tIa1p0a3ZCdmdFbVE5c1UxRDNlTDZ5MTFFU29JVUxTdmdM?=
 =?utf-8?B?QWZZaVdXazNKQWZ0ZFRxMTJVSjhjL3M2cG5VQXNDNHJUS1NkeHFaY0l3dnha?=
 =?utf-8?B?Sm5vUFFxRmNPNG8xMjJKSEhiOTVGQ3VaWmdmOFVsYnJKZFBqL05ZdnRFQWhp?=
 =?utf-8?B?QiswUGFCTDRsc1Vmc04rMWVXQ1JMS05HLzJGMXp6SndKalZpb2hhRG5Ba0oz?=
 =?utf-8?B?bVh0ZGtiOVU5M091ZHYrMUpJMzE3TzJwQy9saVBsNXJEcWtIc2UwSEF2YkNo?=
 =?utf-8?B?TURQb1lvUkE0RTdvWE9qc3VFVEJXRVdGelBnRDYvVlJyQ25OL3YrNWdOaTRy?=
 =?utf-8?B?V1lHVlJJRHUrZEdSMHEydFBoTmJXS2VLUGZCZkx0V21wM1hqL3RDTlpaVUdt?=
 =?utf-8?B?L3RUamxoUXRBbEZOYmc1cHNnSEJPQzBRa0Z3aDRHWlFybmM5N29HUTkwK0R1?=
 =?utf-8?B?TWtuV25XV1lSaGJnMWhadE5xVndVNCtMakFrSXZUKzJOVnNzZUJoMDFxeGZp?=
 =?utf-8?B?SjN5YXl3YWFKczhtRkMxdjFlYTlmTHNlTEwxMXozZ2t5blN6c0IzN0xtYmZx?=
 =?utf-8?B?M3FOL3RMYVUrMW1zNy9MWVhlQU5EWW04c3V6Z0Nrd3hPOVdhVzd2RmdjRk12?=
 =?utf-8?B?SDZncGVYZGJxOVJRN1BJQytBM1NtZm9IQTZWOFYzMlArOGtlbzNhNTdPQmkv?=
 =?utf-8?B?bEpNMk5KM3hjelVHV2UxbmFqeEpGT2RlL0RxUWJqRlUrWW8vUEZOK0d2U3JE?=
 =?utf-8?B?NVdZT0dNcGNZMTFVamV0MVk0Y3Q2RFl2SGVTRndIN0NZNVJlZlpHWWxmRm15?=
 =?utf-8?B?eWlLKzVxTm9vaDdUN2FPN0Y1OGlidU44SDUyVE9MVnRSOFVUbWhGMm0wVWl1?=
 =?utf-8?B?ekN6ZnRmS2dsUi9XWHhMalFiTmE5cGs4WG0zYmFtYW4xVHhlOXp4TW1QSEZP?=
 =?utf-8?B?Mnc4cVZwZkZxNnpyVTdGa2tQTk1KTnI4aEl2NkpoT1NwQ2xySTVla0h0UEp4?=
 =?utf-8?B?dUFTWlhTcWdIUGExaGdGRXRPTm91STBTTkZaNTIzOUlwOXRPVFJFU0NtN0Uv?=
 =?utf-8?B?cEdhZytCZ3ExOUhlNWRhdE10NTVQTDhzMU1JODUvaEh0SFR4UVpqZm1WWlEy?=
 =?utf-8?B?NGNSQ0t0MW1MQS9NdjFZSi9pK0xXditVTHdXdC95NGhJWG52RlRyQ0V2NHFR?=
 =?utf-8?B?Rm9pZzg1NzZ1dWdtZlVybDl4N2dOYk51UnNzS00xMkc1WEVDeXoxSXVGV3Nv?=
 =?utf-8?B?ekg5bEpDckl4bWFJNVZ5QXArVW1pSXhYbDlUYVhRYWI1WS8wcml3aHJKdlJv?=
 =?utf-8?B?QjdxMndmTzZZYVlGSlJqak82V1luM1pWR2NleHExMHFpMW8zYitZTTFobGUr?=
 =?utf-8?B?VGQzOGlWYTlpYkZjT2tOK0hJOXYxRTlTbXZmekJOUEhpMk9icWgvNGFSOVAv?=
 =?utf-8?B?NmQxVnZKOHZxb3N4TmFIaHQxY1VLVUhiM1UzQThKdG9EQXpZUjVjTjBWRUVH?=
 =?utf-8?B?UzRWdVdxdXFvVjhzOGgzRlJwMWRERDJpdTd1cUlTZTliSE95NGVlQjcrQy9I?=
 =?utf-8?B?R0JaTGVWL1FCUVdZZ1dXUXdWVzlJTzFKVVNucGhTNkRCVTFxV2x2SkNvblY1?=
 =?utf-8?B?UWMyRnVRVVI2TW56ZDdhb2ljTW1SVHJxV0VMZlVSa2lPbHRvVVNhVjlEbnZB?=
 =?utf-8?Q?006G5NEIs7anvsmVEDVl2CZ7cd2BLf/Rgo9OANv?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380c4e63-a3a0-4d90-de93-08d8ceb1d8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 17:24:11.0954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyVTL4FdEI9D0euDmspueTlv3KnrCjOe9a6BV10hUImstzuG0/GfwOQf0eI5Ve9guiR96WH0a0duWzKiaNSU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1613064256; bh=lOctTVjLWOwkFAl/R2WoPaQs7ZW5/7J4fFxNmCsGaPs=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:x-header:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 x-ms-exchange-transport-forked:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=ccg/BoydQ8IL+2fnbSyAcQL73DGMBfOYnWgAYIey+/9Xdg/1pQC5daRHNpaYzJcDh
 TpBZTwtjArNj5Gwhh3IZoUZ7cZmXMBwETpmfKF6KDFBx54Nqd936/cdryptiLLGp47
 Ja2FKalRJvPwEs7KrhtDhThGM4C3n+Veya4nfyhmBtq6Mn31DaUco5YBnbmQwo5CmF
 f0MgwtXkkY9njV/OAD8tYwFk7yzNizvrSMjfmCvEYvQr6UnkOhJoo4VoYc1sRUsucZ
 4s7ZAcB2XVg5Gpk14KUwGNqToFJ7C1lwTy0DljD63tvnnxDjKPN2aOU9tLvgKpGHGJ
 ayc0shgI3kc5w==
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: David Ahern <dsahern@gmail.com>
> Sent: Thursday, February 11, 2021 9:50 PM
> 
> On 2/10/21 11:34 AM, Parav Pandit wrote:
> > Linux vdpa interface allows vdpa device management functionality.
> > This includes adding, removing, querying vdpa devices.
> >
> > vdpa interface also includes showing supported management devices
> > which support such operations.
> >
> > This patchset includes kernel uapi headers and a vdpa tool.
> >
> 
> applied to iproute2-next.
> 
> I am expecting a followup converting devlink to use the indent and mnl
> helpers.
Yes. Thanks David. 
I will finish internal review next week and more test to bring here.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
