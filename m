Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6BCEE57DF
	for <virtualization@archiver.kernel.org>; Mon, 11 Sep 2023 07:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 728E1814BB;
	Mon, 11 Sep 2023 07:06:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 728E1814BB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UHf9PM/K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7bOI3sy1Srgz; Mon, 11 Sep 2023 07:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECC45813E5;
	Mon, 11 Sep 2023 07:06:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECC45813E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C772BC0039;
	Mon, 11 Sep 2023 07:06:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEFD8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 07:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B48CA40609
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 07:06:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B48CA40609
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=UHf9PM/K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J2Y3qng1gl6d
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 07:06:44 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::609])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9802405ED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Sep 2023 07:06:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9802405ED
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2c/PYy8ep51mWTvz9x0gO0rGLLIg8fcHHq1PBTf8SN/eQY7nnICnrbo1YAqgphhnbdlwOJZPQfH7UhRepsyWWZh7BnqwD+OvUdNFJZ02f0+vvLON/M+1pWoxG6jmIuPsAQop/g8zcvU80PW0ZUO2yAz7jdVu2z+PytBWO6sPXk3sHEpL4xix0ACSMQoEvJt5Qxw9vjP1mSJrHlJdmzyYSCECAN8Fx4ZwVmqMrPv1gJtvB5QtTHuDpn1c38kmrF/WSkvQvJXC3I5gW5qogvZYRNnY+q/dZff3QtTzTLKzH2FJfEn5KLJoxJdP5lCLFnOyNjPL2Ny5OfjiQ7eS62ZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ3vDgujYJawtbXKBVJkonnzJbjavS9oV3UOoYvAQZM=;
 b=nMwoBoYNMv4EHukB23Une4VMVodM+FWDX4lfZYLz802jFG7i/YRTwOxQVNEIPP/FSblIqMM5GKOElPwpGIkLFE4g+g9OyhyFF6p5kKD3QoHWpflGaA3D1sL8y05X2IQu9DzwjnLI9EYsK+CjfpUtXvJHtWEDmSW43QV5t3tnfTuWRpOZ0lIOwXeXDaQe887nlQ4W3x9FozR/4Ln37pxgFyZ8Zm9KeKW9BIkgMhnNzsvIXE46UugFZb6U5WGf+NOf9JxtAMdLwq4zsoO/19zk6cypzo5mu1BFvInNdAVmg61mw7IHhlqN0/BV6dO/0THd08mSQoS0w5zYb48DhlfIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ3vDgujYJawtbXKBVJkonnzJbjavS9oV3UOoYvAQZM=;
 b=UHf9PM/KLL1sk3ZK4s8yAUobL7QPA4oTr8f3njUND0dfmcxb1LVbV44WnQA8RAzoiobJM3YORkQWXrQiIwHR9Alqkq6c6n0x1vh3bQYqPgWFYyScizvqJBZ9NeB2C2dc/g9Zu7hxeSqFNg/4ef9hIRQu1xcbhMk0Ebjgd6MbApufhDxF9SfJLtY62fvj1krEV52GkZJ7qKZLpBCwN1Zl9z7opava9gT6qwASzpwEddSsB9NTkqBcSLYhjKsAVbFpRpZ6i0Zb40OjSob9nPjtYVVEcvdYQPCLH/JbxGWGosGLpZXMidO913ml83tv7a8XIm6rb3jv1PuhQf4cELYVmg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 07:06:41 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:06:41 +0000
To: "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: Re: [PATCH RFC v2 0/3] vdpa: dedicated descriptor table group
Thread-Topic: [PATCH RFC v2 0/3] vdpa: dedicated descriptor table group
Thread-Index: AQHZ4vnqN2270ymBDEib4ivCHmpIV7AVMKcAgAAGawA=
Date: Mon, 11 Sep 2023 07:06:41 +0000
Message-ID: <a9516f2b76d66f5292358b4509a854ebd57fb090.camel@nvidia.com>
References: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEumYw5NKGfakjm=QGxTX0JH71owt240=y0WGxQzGipXGA@mail.gmail.com>
In-Reply-To: <CACGkMEumYw5NKGfakjm=QGxTX0JH71owt240=y0WGxQzGipXGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|LV3PR12MB9185:EE_
x-ms-office365-filtering-correlation-id: 5fe384fc-2cb9-40a6-ac21-08dbb295a65f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: akwhBBJgYcLUfQhqKkd5iIvlM0hFrJQnGj6i0FSG0Z3F4h91Nz40JBwUH181m4IlQ+dMDEwk4fTBzSYIYA/I1U4wbZqTpAi+o3C+0pcy6WiQMUNyaaoGB9J9wavVjaJXyUHeVZ7cXpIf/ky83+L7B1QxZDH404Sa21HJAVue7Mh3dEG/gKU4ppV1MNZW+sDcSVC/HoN0+2GCHvjVI42D22itH4ji7MWAJUsOrENjrWwLg3UI50f8fmWb8ahagKNOIL7W+341Wc9z2o5NQCrTcG9q6VqdyzONYyszlBsTMJoP/7O6lWxYY0E8d1TX6Mbsg2zpr0HAHAhInTsIMCpPjLEzRY+z27neFrHA8C/rbQ7qw2BOFgu0rNnNjVoKZ2OksCzJOboH9DmcwCDRqg7EjQDkGZMY1JxTXuktvD/ThDKYZDB4jkPJdpus/ppm0HyjZTEKPWiEU+xmROMqGOg6HW0kywc09k06qmKyS4TdZuWOSEM7eBqIbMdJqk4eGRqWEretyorSmVL0Ow4vwRR4IOR4234LYoBfgm8rSFamYha4XZWwjusm/V5umq0M9VkBaFcQio96+DYVFVAO9jMT3aBecrMcRG5ijko6vvBdR8OY7fT3j6cUnLSZhAsRIzcm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(1800799009)(186009)(451199024)(6506007)(6486002)(53546011)(71200400001)(6512007)(478600001)(83380400001)(2616005)(2906002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(76116006)(91956017)(110136005)(5660300002)(4326008)(8676002)(8936002)(86362001)(36756003)(38070700005)(38100700002)(41300700001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0U3ZlVUZHYyVTU1ZFowZ0swZnVlQkgzeUtOclZHcDVOT1R5b1F4ajVGbGp4?=
 =?utf-8?B?ZnVwU2ZsSjFURGhCUTk1Q3UzTkR4WFJtYnBOM1B6cUF6THhtRHJsNTJtaDVk?=
 =?utf-8?B?S3ZKWDc5bUdFbUV4YTArT09zeVQxc3lCeGRZb3NJV3M3ay95TUVCT0p1Tlpu?=
 =?utf-8?B?d0xMeWtmNmR3QlJXMzdoLytaNjA3RHRKY21FSXJNZFI3SFluTXUvT3dNbVpY?=
 =?utf-8?B?T0d3VWJNTzRLbkxTc0srd1J0SmMrL2hpUjNtREJFQ3E1YWtaNnRNakthTWVm?=
 =?utf-8?B?UFJKTTZLaHl0RFIyMGRZSjkreDBCbUo0ZzlVYzJ4WlBzN0xmaExiclhIeU02?=
 =?utf-8?B?YmplWHA1dUJJQVJDQlFCMUkzNFZpUVlQSGwxaEFTMjI0UW1mSGJJcmNLRVNK?=
 =?utf-8?B?bmtPS0JVdFkydjhRVTBGVjVSaVZtVVhKS3RhUm5tM1lZdjE4b2hKcHUvb0hK?=
 =?utf-8?B?Tzh0UzRYcnJkU2RWN1gyUDRBemdYOG1pbDVvTlBPM3J0TGR1T0g5VG1tblMr?=
 =?utf-8?B?YWh5Y2hMTlZ3aURKQWJnVERnSnVqSEZEYi80dEpqQVVmYmZ3Tko0aGVqK1gz?=
 =?utf-8?B?VzIzcnEycm9JUW0zaXVUQmRsYVZDd3ZPUUs0dVRUdmJwTStOc0M3THdJc2RY?=
 =?utf-8?B?WlNPTm9WNlh3YWllUnZFZGdWOWhCNm9uSldmOGkwV3BxSHdnSU5pdXltd2xV?=
 =?utf-8?B?Z2dXREtwSkN1VDNCOVkzTk9QZUFhM2l1TmdpcWpwNFM4bGlmTGRxdnJIbUp2?=
 =?utf-8?B?elJnRGpUV3VaWXlUZ0lzYTNsR015UGcrTEVYVnNvMW1sdEtMYmdlVFUvOU1B?=
 =?utf-8?B?MFhaYThPT2l4T0YxZURVRDMrbG9JQmpEK1R5YXFyRmZyN1l3R3FHditQcUpM?=
 =?utf-8?B?MnpOWDVBWEFRZlZWRXdWLzRQL2ttNUl0TVdPVHNDb2NEUmxBZkVHNTRXV252?=
 =?utf-8?B?dzU4aHNKTUxEVFpVTElOamI1czJqYXRkbkFaYzNNS0NlcUdJSDNzbGZLR0hu?=
 =?utf-8?B?NHdhNVZGYStTcHNQclhzTXRSbWNwWHBZblF1dldxWkhvZERLZzlWaU5TY0RR?=
 =?utf-8?B?M0lzcGk4T0ZJU1Q3NFh4WmFRMlJSQ0hYVGdxVVp3UVVSYjVtSlJqNFdiNHhO?=
 =?utf-8?B?WmtsNVZUaEVETS94R2Z1WXAzYXFselVPenROT3pjTXdqT2kzV1Y1WEhTTnJt?=
 =?utf-8?B?Q2s1L1lRN3B0dUptYzhmaURUTVZycHpzb3ErbzFacG1IcHp0dE0xR1VZK1R2?=
 =?utf-8?B?SkgzNGhWaU9LMkozUkhWL0k2UGZ3UENXb0FGUFRWVkhmS0Z5OWVZLzAzK3JD?=
 =?utf-8?B?QkY3VVAraktaeGs4TGFLMG9tN0tDck1EdElMcUJjNXhpa3ZUMTlHSWdTRHpL?=
 =?utf-8?B?aVE5a2dQT3ZRQnhvQXBiVExqTW9YSzhWdFIzd3RpUlNUM2lUWEpULyt0RTNN?=
 =?utf-8?B?dVJFaG5zeEtJYzNYYWxjb2ZJbUk3WEo2R0g0eVUzbjFLcGJXR2Njcm5RVzBj?=
 =?utf-8?B?algzL29hbTIxZVZyMzc1UnNsTlR3N0xoWHRrYWRZTWVESW9vVS9pWmpVcGVC?=
 =?utf-8?B?Y2dmSktwMHQ1RTZLTmRybER5UkFZdGpxVmtyakE4N2pUcStaM0U2VnNnUDZk?=
 =?utf-8?B?ejZ3NkYxc01jZzdpa1ZLTmt0dTc1SUtyUDUwcTE1Ym03bHREZHkyNXNScTgz?=
 =?utf-8?B?MEgzUVByWktSWkNWZWJNakRDZWdhWFBveWtJUUx0ZGp3cTFjWUxDMklYZ3A5?=
 =?utf-8?B?T1AzaVRpNVFYY25UVVNSUEd0dVUyaWlXZlY0TnBLMzhWRnZTQmNLU1JIUWxp?=
 =?utf-8?B?ZEw0dXJFVndKdzRVTEVVbkV4RWxiQWZLcmVxUW52UHF4aEVLa0FaQmRmTVlX?=
 =?utf-8?B?VU9GODlYeEU4eVo3aEt4VTdaNjIvKy9EZDdYakdVeS9sRk5pSEN0WXh4cEp2?=
 =?utf-8?B?S3hKckNDMUVzM0xUVVp2RnFQNFZiQjg5eFdvdGhidExLOUJKQnN5U0xaR3h1?=
 =?utf-8?B?Q3pISmdncnVhWUFId3V0dW5GbUdpT1lqM3ZMeUY4M2NuRWR6SDBlTUhJTzJM?=
 =?utf-8?B?T2kvRXJuQ3hpeTAzTzVibGlkTUZNQ1JmdXNPajhIbzA1bVI1Rll5a1pMNUZQ?=
 =?utf-8?B?N08xTFQvUXdySUxGdkV4ZitKYWZrQi8wV2hHMjdKT3laQStrZXRjTkdqRm5s?=
 =?utf-8?B?dDZ4WnN6cGVRRlUyM3NlQmVlUkgxaC9nTlhQMW05TUVoT1kvcS93dWs3ZGxs?=
 =?utf-8?B?V2dBRGZOZzNsWkRPV1JqWExLMkhnPT0=?=
Content-ID: <96A4EBE6DF08F64E8EBC07CD14F693B4@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe384fc-2cb9-40a6-ac21-08dbb295a65f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:06:41.3839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dosLKRSXYK4ZSx3oZSJJn5pbycAHwEk8DJWwoOCGJYqWdYlpxbdJGOWNw03xIioBTcSFE4rLfcV6lTfWiRp9Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgSmFzb24sDQoNCk9uIE1vbiwgMjAyMy0wOS0xMSBhdCAxNDo0MyArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToNCj4gT24gU2F0LCBTZXAgOSwgMjAyMyBhdCA0OjQ14oCvUE0gU2ktV2VpIExpdSA8
c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiANCj4gPiBGb2xsb3dpbmcgcGF0Y2hz
ZXQgaW50cm9kdWNlcyBkZWRpY2F0ZWQgZ3JvdXAgZm9yIGRlc2NyaXB0b3IgdGFibGUgdG8NCj4g
PiByZWR1Y2UgbGl2ZSBtaWdyYXRpb24gZG93bnRpbWUgd2hlbiBwYXNzdGhyb3VnaCBWUSBpcyBi
ZWluZyBzd2l0Y2hlZA0KPiA+IHRvIHNoYWRvdyBWUS4gVGhpcyBSRkMgdjIgaXMgc2VudCB0byBp
bmNvcnBvcmF0ZSB0aGUgZWFybHkgZmVlZGJhY2sNCj4gPiBmcm9tIHJldmlld2VycyBvbiB0aGUg
dUFQSSBhbmQgZHJpdmVyIEFQSSBwYXJ0IG9mIGNoYW5nZXMsIHRoZQ0KPiA+IGFzc29jaWF0ZWQg
ZHJpdmVyIHBhdGNoIHNldCBjb25zdW1pbmcgdGhzIEFQSSB3aWxsIGNvbWUgYXJvdW5kDQo+ID4g
c29vbiBhbG9uZyB3aXRoIGZvcm1hbCBzdWJtaXNzaW9uIG9mIHRoaXMgc2VyaWVzLg0KPiA+IA0K
PiA+IFNvbWUgaW5pdGlhbCBwZXJmb3JtYW5jZSBkYXRhIHdpbGwgYmUgZ2F0aGVyZWQgdXNpbmcg
dGhlIHJlYWwNCj4gPiBoYXJkd2FyZSBkZXZpY2Ugd2l0aCBtbHg1X3ZkcGEuIFRoZSB0YXJnZXQg
Z29hbCBvZiB0aGlzIHNlcmllcyBpcyB0bw0KPiA+IHJlZHVjZSB0aGUgU1ZRIHN3aXRjaGluZyBv
dmVyaGVhZCB0byBsZXNzIHRoYW4gMzAwbXMgb24gYSB+MTAwR0INCj4gPiBndWVzdCB3aXRoIDIg
bm9uLW1xIHZob3N0LXZkcGEgZGV2aWNlcy4gVGhlIHJlZHVjdGlvbiBpbiB0aGUgZG93bnRpbWUN
Cj4gPiBpcyB0aGFua3MgdG8gYXZvaWRpbmcgdGhlIGZ1bGwgcmVtYXAgaW4gdGhlIHN3aXRjaGlu
Zy4NCj4gPiANCj4gPiBUaGUgcGxhbiBvZiB0aGUgaW50ZW5kZWQgZHJpdmVyIGltcGxlbWVudGF0
aW9uIGlzIHRvIHVzZSBhIGRlZGljYXRlZA0KPiA+IGdyb3VwIChzcGVjaWZpY2FsbHksIDIgaW4g
YmVsb3cgdGFibGUpIHRvIGhvc3QgdGhlIGRlc2NyaXB0b3IgdGFibGVzDQo+ID4gZm9yIGRhdGEg
dnFzLCBkaWZmZXJlbnQgZnJvbSB3aGVyZSBidWZmZXIgYWRkcmVzc2VzIGFyZSBjb250YWluZWQg
KGluDQo+ID4gZ3JvdXAgMCBhcyBiZWxvdykuIGN2cSBkb2VzIG5vdCBoYXZlIHRvIGFsbG9jYXRl
IGRlZGljYXRlZCBncm91cCBmb3INCj4gPiBkZXNjcmlwdG9yIHRhYmxlLCBzbyBpdHMgYnVmZmVy
cyBhbmQgZGVzY3JpcHRvciB0YWJsZSB3b3VsZCBhbHdheXMNCj4gPiBiZWxvbmcgdG8gdGhlIHNh
bWUgZ3JvdXAgKDEgaW4gdGFibGUgYmVsb3cpLg0KPiA+IA0KPiA+IA0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCBkYXRhIHZxIHwgY3RybCB2cQ0KPiA+ID09PT09PT09PT09PT09
Kz09PT09PT09PT0rPT09PT09PT09PT0NCj4gPiB2cV9ncm91cMKgwqDCoMKgwqAgfMKgwqDCoCAw
wqDCoMKgwqAgfMKgwqDCoCAxDQo+ID4gdnFfZGVzY19ncm91cCB8wqDCoMKgIDLCoMKgwqDCoCB8
wqDCoMKgIDENCj4gPiANCj4gPiANCj4gPiAtLS0NCj4gPiANCj4gPiBTaS1XZWkgTGl1ICgzKToN
Cj4gPiDCoCB2ZHBhOiBpbnRyb2R1Y2UgZGVkaWNhdGVkIGRlc2NyaXB0b3IgZ3JvdXAgZm9yIHZp
cnRxdWV1ZQ0KPiA+IMKgIHZob3N0LXZkcGE6IGludHJvZHVjZSBkZXNjcmlwdG9yIGdyb3VwIGJh
Y2tlbmQgZmVhdHVyZQ0KPiA+IMKgIHZob3N0LXZkcGE6IHVBUEkgdG8gZ2V0IGRlZGljYXRlZCBk
ZXNjcmlwdG9yIGdyb3VwIGlkDQo+IA0KPiBMb29rcyBnb29kIHRvIG1lIGJ1dCBJJ2QgZXhwZWN0
IGV4YW1wbGUgaW1wbGVtZW50YXRpb25zIGluIHRoZSBwYXJlbnQuDQo+IA0KV2UgKFNpLVdlaSBh
bmQgSSkgd2lsbCBzZW5kIGEgbm9uLVJGQyBzZXJpZXMgd2l0aCB0aGUgbWx4NV92ZHBhIGltcGxl
bWVudGF0aW9uDQphcyBzb29uIGFzIHRoZSBzdWJtaXNzaW9uIHdpbmRvdyBvcGVucy4NCg0KQ2Fu
IHdlIGFkZCB5b3VyIEFja2VkLWJ5IGZvciB0aGVzZSBjb3JlIHBhdGNoZXM/DQoNClRoYW5rcywN
CkRyYWdvcw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
