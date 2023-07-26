Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB118C001E0
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 18:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 370EA41E46;
	Wed, 26 Jul 2023 18:56:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 370EA41E46
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LZ9pnSjQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YWkezisadlEa; Wed, 26 Jul 2023 18:56:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9909541E0B;
	Wed, 26 Jul 2023 18:56:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9909541E0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FB12C0071;
	Wed, 26 Jul 2023 18:56:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B22BC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C4B541E46
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:56:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C4B541E46
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qa1c183VOVqL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:56:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63F5641E0B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:56:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63F5641E0B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q10sutV6uriCtmvM/3bDuvu2gHhI0oDlDofIs209kFoF10aLfpGS9UjWBPVGWjtuA3FMRdKBjwPd1prAN2qKDNDOH/K2w/umZEaBSv8N1nlvPkkxE7dq78dlNpmqAQ2XdLjf/kbJlAko27XWvxoA/CXm2K3PvEomatkWp8YYrvNr8JKx492ND002ef/Kz54VOv8gh8BYGI21bQTbgmqQr+4JrOsxNZXEGj+0npKibTCmjhGT6vQ2YHESZHG0FKMO6VAJjukJEic1AjIVNRyJIzk07Ck+Bxgpt4VdqJNedBeNALPAKak+VQCAC6fcOhp/OkWzqB5CpxY7RB0nWbPY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8ECMQOy06vQggBjx42CVhKVaN0RHrfR4iDLzncKNh8=;
 b=AzHbkkzvLvTX+Z7Rn2sJA4A9xJdzDymbCkOD+hoaJF1BTvuMytr5PZLeOBwCv57RXWgUIMuOlrBpRi/oR9I1ARokif74s1HbYyrJaz8C5GthzTcrU5UFM6Ubt95s7+HIK7j6x21GV+jOeOUavlzhjJ6NSEoYVm9ew9KczXgcLzKGB0webxwztP+J4B1v4U9cayGBnx1iPj50E9grFS3A93OaZwi6Bx6N7LBdXeV7soJj2uVosVFtKPkrDzwJxuJu5t/yxBYiG686Si3OPIkPJvMWJkcJ9iiIOLDYHF3np1q2lW2LAkvfB0M1038m25oto2Tjx2hwbYzHPiuvX9zqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8ECMQOy06vQggBjx42CVhKVaN0RHrfR4iDLzncKNh8=;
 b=LZ9pnSjQnKKq0W6N8wEHDHNxt8hpafvUs6qq7C82ExuN+eeKMV7Lx6tWUYYjgLsYdMcyMWEIatf9GBu1BjW7InGIK57z3FYc+AeE0jDCgGInX6JLUnBvUiGmb7AXTmaWsmoFADnZibSZCqUx4D4LCUbcXkt4WbHxQVOp5D8QFK6ZhGULeq//VvLE+I0ULJKNoxDuJQVMyWtsyoQfRpgGE5hl2jmQNpg9dNA7tY3BRhFcGUNAKsusIeRm17lzT8WKPdM74N58TfuxQIp+QIWgeI736etc2PRtSO+18mlCCd5n9QSn6Mk2071w91VTuN2B+ZlFOy9io+W7ZEwmE6GCdA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:56:24 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 18:56:24 +0000
To: "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Thread-Topic: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Thread-Index: AQHZv+9e5mifEKOj4EGSlYbK7Ha8O6/MYG+AgAAFcIA=
Date: Wed, 26 Jul 2023 18:56:24 +0000
Message-ID: <8a97e0d439d74373605b00dcaef91108ced9e5ee.camel@nvidia.com>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
 <20230726143640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230726143640-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|CH0PR12MB5203:EE_
x-ms-office365-filtering-correlation-id: 71ffd9b8-ff75-40ca-4d00-08db8e0a0251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFZWFz0zDrNedLXzABLY0oE98WxjEC/xyv5vpHvbEkQsV6z7rIpeHnE2Szc5e8aUwP2/SO6dsQO7dq8QOZQNQQIMNb/cChUmNwneqvpRoCO9VkpyWF5jJiI44muC5pu4eM1meRYZaCS6oUlqCFH76Ro+q/WgntLiTLzNtb1aF2rQh9QaGzil5vyclFJBIH9UTp0pjOaPJoYWE+6MtjWOpEiueOyB5walfKZPH0qNEX363Qq0Hh8Y64nOMu2vJnfOu7Bodv7/CDqZnqkTSF24evHnlS9vGKcNII41XOdo7l3ktvPWO4bFrp+p/5gjMhG96+FTdpnwto/fgmSb1FaV9Q9m4fv0mcv0Ihl2iIgiftSyXRXROqNOdMFPFRT+0CU5cwG/g55KAslSFLxs52MmoMhIq8aUT3rZ33q1/IQ5oH3lYNL4i7ZfzWYvGp/ViuUa0ksY/qtIVRYWxfS5cb6U56+xwxtJcuAUPPRqpczN8oGanJK4HC0oO5QUxmVn4fOX7AwRbUbvAdApsdE2BsB+RXjkePJ8kYUl0oz6OPfkba5Em43MYJ0W7ijAAJgRw0z273tN6xAsgChPR6lKXa0IO4tHXm2W7VP5sfYcp9xlKcSTbPi1diJVfWZfnasgX21HcVd8x+FPe816HPvcKPBRt9pgDv7gBlsR5wDmaWuFTZY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(41300700001)(71200400001)(38100700002)(478600001)(91956017)(6512007)(86362001)(966005)(36756003)(4326008)(8676002)(8936002)(6916009)(76116006)(186003)(316002)(66446008)(66476007)(66946007)(66556008)(64756008)(6506007)(122000001)(5660300002)(2906002)(2616005)(83380400001)(54906003)(38070700005)(6486002)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFh2NllRWlFkR2VqTTNnRjUzbDNVMjJ6bDMyRTNnYzZEYkJQV05wVWhvNjdL?=
 =?utf-8?B?TU5HTVcrUHBmakJyRTJ4czZvWjVTdEJRRHNjTEhzRFNwMWpUUGZiNVZKOU54?=
 =?utf-8?B?bE4wbmRENHd0Nm56RytxOUI2VkY3N1ExdlhKSkJ6MHlFUHl3Vk5PRElCdlBm?=
 =?utf-8?B?K09OOFBqL1ZndlB3cVdlcDErdjBEV3RXTExVcTFnOUdiNklUNStHSEROTjMw?=
 =?utf-8?B?TFNOOG5TcDR6cFlCdkxrZS9NUkpNWUhlUU1yUUd3VXE1YXBlbU5OQmRKUVRG?=
 =?utf-8?B?SUsxUUFFMDdhTEZQdVozNVBCY0xMTzcwUHlKOUk3SU5WNklKT1g2eWd0YUlj?=
 =?utf-8?B?QWFBeGQyOGdHN3JIWFA3YVd2Z3NCYnZwUE51OStudFduZFQwTVZoZ1BNUy9Q?=
 =?utf-8?B?SmlMMVF3cGpEeEhVYXRqdnRoczQwMkY0N1ZWVk5WRklORkNENElJYXl4QUdT?=
 =?utf-8?B?aEhSU1RSOHZpd0NPcUloQS9WU1kzL0JFZXFwRVFHa3pVdGNtMUxvUEZ2a3Bn?=
 =?utf-8?B?STRBNC8vRW8wOVY4akxGSitWdldoRHpsNnVCUTYyUTladzdGcUlLZ2liSytG?=
 =?utf-8?B?clhHYjRtcjJMNmtFd2tDVW5RVkQ1UEtmanlMVjRSUnJkT29XcHRHNFE3OCtL?=
 =?utf-8?B?NnVmK0RZbWcvdDJseFdHeDRVNWRQeHJJUlhGQlYzS0YyeXNKeklWZndGb3hx?=
 =?utf-8?B?T2dHQzloY0drWUxhK2pINUY3UFc2MC9qUDNnYTNkZGViMEZ2VXpGTCtFTU9K?=
 =?utf-8?B?Y1ZEb3FiSVZJZnFRYmVTVXJPYTk2R2VJbkxWenE5dW9paDVCamlPWDkyZnhJ?=
 =?utf-8?B?UHQvZWNXeisrUWY0VWpmeXI3dTdEb0t5UlRWbEZyemI5VFFqYUwzVHBOT05E?=
 =?utf-8?B?MVVQSHgwb2U2cTlEdm1WUXVtQWVQU3NXR0pmMVRad0NtWjNzYkRnbTdqU0dn?=
 =?utf-8?B?Z092d2pCZGlrZVVZQWxSNHM1WWp5UUpiNDZyQlRZSDc1TTBPMnAzSXFWUmd0?=
 =?utf-8?B?Tkw2Z2FtdUMzSWtBYThWZXc5Q3RzRGRBS2tBbVpjazNmaVQ3aStkcllrY0hC?=
 =?utf-8?B?Y2hpNkEvTW9XQXp0L0c0TWEwc1IyVW5EYXRDSXBadmxsVDRLaHhCRkVyYWkz?=
 =?utf-8?B?aW43ZEI2dVJkMGpCb0lIMWJZWUhFby9qUFViS1FVTDh4cDNNWTRtQ0xjTktl?=
 =?utf-8?B?dkNOenpGR1ZpS0ppUHVoN1BQVEJCQ3JrL2lIT1MwU09BOHo2aVFybmtoVHR0?=
 =?utf-8?B?RFlGUXBISXVpQTBpaVU2aWczZm91WXpyWEJtRjhXcVdNSUx6Y1hSdUE0ZXQz?=
 =?utf-8?B?eUc5V0FhSTdwZmRSc0VxbjdJNVp4b0F4QWNsMmw1Mzh6SU5HVTBqenQ5V2pm?=
 =?utf-8?B?cGNjNWNCVkhaTzFFMm9nYk83QW1aQU9nU0dvbHBVN3FtN2piSlJyVFE1aGVa?=
 =?utf-8?B?c21QbVd3ekNNdml3WUg2dmdqZGtrK1FCaWlEaGhjR2JUb3ErZ2trQ2MxUWJH?=
 =?utf-8?B?dGZ0V1hJbit2QndkczNpbWxVNHRhT2JUSTkxcm8xNHdmS0FkRnhWK21EQlp4?=
 =?utf-8?B?eklHeXJYTldaY3FwRWdTNXdIQUVaYzJZcmwvN1haMTlQUlBsNXdwNGNsUnJ2?=
 =?utf-8?B?dUNlYzViMWpEVHdGUVhUUlhGbzlIYWV6QUVlYTBaYlJNMEptNHJCMHBOaHIw?=
 =?utf-8?B?ZVJFaXoxU1Frd3NuZWViZ0xPN2YrRytwZTNUNWg0RU12QU1KTk1QTEUrbklp?=
 =?utf-8?B?czlmZmp5VTBhWlNNV3YxYnBlMHdHRVZwVlNDWVc1L0NHYUFpUm54K0lWSnd2?=
 =?utf-8?B?NER6RE1XUDhDN2djbE5aTXliRGJrb1RiUW1sQkZUS1FPQXBJUTUvcGxrUEJO?=
 =?utf-8?B?VytnV0w2WHdBaEJXaWw0SENWaS9LV1pyZWJLVUV4dmVLWk5RczJVS2ZiTDhI?=
 =?utf-8?B?cmxSQmNWNjJYbkQ0Z0FWdkR5RW8yaDc0dVFRSkJGVzNmZFB0Y2VWN3JoTGFV?=
 =?utf-8?B?MUY3WkhLTkFYZWxrd2k3Y2MwbXBpRDlzSDNnaEtacDJualVsR1N5V1BycG5t?=
 =?utf-8?B?R0pRcGlWQkR0WEdzY0hoMFA5NElDWURIWTh3ZitQSk1tNHdBMjBHR1JJN2Mx?=
 =?utf-8?B?R0hKdU15V3VCMmNrQzVwdGFFUG1JWVdCWjkxaE4rdnc0STU3Y0wrOGcxOWRQ?=
 =?utf-8?Q?oy44SgcKEitgZWiX2kQouP0nUMNy1HX4xCp6WzcGdUo5?=
Content-ID: <95EDBA25B6680F4DADF99FF983FD1D6A@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ffd9b8-ff75-40ca-4d00-08db8e0a0251
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 18:56:24.2644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lhskGuJwX6vLnYIxBo5JJvIK/vNCOpnFW9/+shTggqlusjkTgNLRT/Ep2tt7SSRdq7QHHTB3uYqVoGPp+h78xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linma@zju.edu.cn" <linma@zju.edu.cn>
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

T24gV2VkLCAyMDIzLTA3LTI2IGF0IDE0OjM2IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIFdlZCwgSnVsIDI2LCAyMDIzIGF0IDA5OjMwOjQ4UE0gKzAzMDAsIERyYWdvcyBU
YXR1bGVhIHdyb3RlOg0KPiA+IFRoZSBvcmlnaW5hbCBwYXRjaCBmcm9tIExpbiBNYSBlbmFibGVz
IHRoZSB2ZHBhIGRyaXZlciB0byB1c2UgdmFsaWRhdGlvbg0KPiA+IG5ldGxpbmsgb3BzLg0KPiA+
IA0KPiA+IFRoZSBzZWNvbmQgcGF0Y2ggc2ltcGx5IGRpc2FibGVzIHRoZSB2YWxpZGF0aW9uIHNr
aXAgd2hpY2ggaXMgbm8gbG9uZ2VyDQo+ID4gbmVjY2VzYXJ5LiBQYXRjaHNldCBzdGFydGVkIG9m
IGZyb20gdGhpcyBkaXNjdXNzaW9uIFswXS4NCj4gPiANCj4gPiBbMF0NCj4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlvbi8yMDIzMDcyNjA3NDcxMC1tdXR0LXNlbmQtZW1h
aWwtbXN0QGtlcm5lbC5vcmcvVC8jdA0KPiANCj4gQ2Mgc3RhYmxlIHdpdGggYXQgbGVhc3QgMS8y
ID8NCj4gDQpTZW50IGEgdjIgd2l0aCBzdGFibGUgaW4gY2MuIEJ1dCBsb29rcyBsaWtlIDEvMiBi
cmVha3MgdGhlICJmaXggb25lIHRoaW5nIG9ubHkiDQpydWxlIGR1ZSB0byB0aGUgbWFueSBGaXhl
cyB0YWdzIEkgZ3Vlc3MuLi4NCg0KPiA+IERyYWdvcyBUYXR1bGVhICgxKToNCj4gPiDCoCB2ZHBh
OiBFbmFibGUgc3RyaWN0IHZhbGlkYXRpb24gZm9yIG5ldGxpbmtzIG9wcw0KPiA+IA0KPiA+IExp
biBNYSAoMSk6DQo+ID4gwqAgdmRwYTogQ29tcGxlbWVudCB2ZHBhX25sX3BvbGljeSBmb3Igbmxh
dHRyIGxlbmd0aCBjaGVjaw0KPiA+IA0KPiA+IMKgZHJpdmVycy92ZHBhL3ZkcGEuYyB8IDkgKysr
LS0tLS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IC0tIA0KPiA+IDIuNDEuMA0KPiANCg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
