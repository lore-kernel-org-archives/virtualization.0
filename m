Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A7FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Jul 2022 03:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5942F4012E;
	Wed, 13 Jul 2022 03:06:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5942F4012E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sU0HPg6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hhau8CLG81PV; Wed, 13 Jul 2022 03:06:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA6E1404BB;
	Wed, 13 Jul 2022 03:06:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA6E1404BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3459C0033;
	Wed, 13 Jul 2022 03:06:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD3FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 03:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1122342381
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 03:06:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1122342381
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=sU0HPg6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T71M05xhRbIO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 03:06:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89AD541A14
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89AD541A14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 03:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc4Gwb0B3yJPzJ0KnjMyfkwyIUFwx9rnj3bCynaI10cCerlxwnzQOuPC5cyCTQybNBHIRX2pu7/ma/6z7CJHwpYjBpBNn/RTBtXH5aFRRVjVwfD5zvN/keeobtYhMD6Gz38eBwdErJFqVFwsbITvEYIbATEEngK8nMFnf0wGkWtEp4X3RZjF3vazIpxpuSxwIdI00xl+fFgumGGlHe7kDjR4jkQly49B+1ZNbGsNoopwhvIWK/MXLGRqhCuFPS77srZxCdIqh7JutrX3hf9hbnAl++4JlCFeX+YWTjlucFCISqTSeahBM4+MaOB0ekpeDJNV0dPyhJjMnpvNheWPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBicvcr4ZaWOOB6ljLxHuNLTlY7CNTOUEAMqU4oC71M=;
 b=PaWOIQL95lDCnBevkaSBbADpc3MxXQ+KBV34tqBZ7LHf5CupxCLWkUz/r1koCsxgcMCjLVYrdu5ia4VMQC3CqQFel4FiN3B8nO9E2oTml404SUmC5zHV9l7ZDjRHhZ8flwhYyP5RGMQq3xxMcoLK9P80ih9DdoYAMCcqh71FZvMsdmYyqVaNN1Fo4WqWT1NUozDucHhfPxwtFjTOubthtBo3qyZ6BybMxkX6TBE7nqTcunmnllTbBaOaUC1NJXW4lkmi16AfOZv5/IM7tXnKNDKeMGANpC92bJAzThvaSE5uMAsNnyZZHSFOI+F9j7PqYVfAYyAMAIHDf4Srl6nw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBicvcr4ZaWOOB6ljLxHuNLTlY7CNTOUEAMqU4oC71M=;
 b=sU0HPg6Ese4wydM1QaM5owY727TANQMyRsFmKRvSC3nGSdMWo7TMAAqaRYcD4ChMdV+EPd79KxPksxUCcwwCOK9MRnnHdXTjj/KcMiq3vppYGgYecj+knBqQzx6JQvzu7kjiKV/k18o+seFDtTZydaSC/RfbLQzhdZsyzMh95qngQcAQNrLzfFA2PXPQrSbPnAp9OIGPu0c1kn5FISoQJVtnwFIzdOItWgxkqJNxkeNjfkKV5LpME+w4IbXykq6tPQz5TJNbjGRscPNCQWJozt5NeLuJMdtmCUSbAQ3FXlYKjtGx5j/3t7efxba9S1pVJMfnumyLXWj6GankNxWAKA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN8PR12MB3332.namprd12.prod.outlook.com (2603:10b6:408:66::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 03:06:18 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 03:06:17 +0000
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Topic: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Index: AQHYjU+OpP/4aLhN20eCCMO4rbOEoq1qEloggAn4zwCAAKXGEIAD0JkAgAJ/vUCAAK5SAIAAADPw
Date: Wed, 13 Jul 2022 03:06:17 +0000
Message-ID: <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-6-lingshan.zhu@intel.com>
 <PH0PR12MB548173B9511FD3941E2D5F64DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ef1c42e8-2350-dd9c-c6c0-2e9bbe85adb4@intel.com>
 <PH0PR12MB5481FF0AE64F3BB24FF8A869DC829@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00c1f5e8-e58d-5af7-cc6b-b29398e17c8b@intel.com>
 <PH0PR12MB54817863E7BA89D6BB5A5F8CDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
In-Reply-To: <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40195493-440f-4a54-753a-08da647ca79b
x-ms-traffictypediagnostic: BN8PR12MB3332:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HktW/R6cqUIAAcKabW/J4ab1ka5BtrSVlp81fhEUlqjv0R0ZWny4gvQY9o95Zhhrr9WbedHUSH5VqFAlf+jM+mmZOXDEzJBk7bj5j4NcIgwTvt48AKX1icbNdRKGJIka+sRK91IDuyDbCR/pk+QI1sFT3VFoAU+mA19GKxam8Cb7QuleVwF2Gzb8Qny1al3R5c7nvYZXo8jt2GL2hrvKEuOYCLe4DV7nnhCXKQV1Ui9qDY+fKpHmkTOIs1DzDOBWgKrAzu0SHZCiAfljhJLAGNZa33QGN581P0pZd2qIui9arOuHc5Xk97WRynkUFmejMvp5bfSBvsNXcwdi9aBLs1XW4eFcSzGzQzq7vrz9IMLtKti/sVzxl/U3NyvuhqPYDPbgj8KoT7vrvC8pYN7gP8JbasbZfWAJWvNS4QRE6cy3HOvaOSYNKThvHxHNVYTcOC4DmMFJLs7XVpM22/ja0J0hBB6sIYULTO5AW5fAQKPptlGb0fzOQJWBNASl1I+QmcWWd6AsrgCuKw6GjpQ+53KqgAoX50RnQ7jz34mDE2LgTDy28mUwp1RW7KSKurMcoy2vZQPHYr9m5qW2d+Mb5LmfS4D5CT2b8PxWQ19nnIoFt05kTHHfwUWjXg+SlxB4Qk3Cmjnw97m6vjitB7lauMeilJlq0JuzWZMZtyD0Ez/De2vSWJf8np8qc+XFw7NPRZ9Yyd6G6agiiHHINu6uH9zWwXdCp9M9hk5uq7TbyOxw4FEJwRectmemUhczWcRWS3dsrtRHGn0PL7AnYRDFJVDp62sarFQ+Z3JWVU70yYqE8WURwEEmBHt+ycY+7MjI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(8676002)(76116006)(83380400001)(66476007)(66556008)(66946007)(122000001)(8936002)(66446008)(186003)(86362001)(38100700002)(4326008)(64756008)(54906003)(53546011)(7696005)(316002)(52536014)(41300700001)(38070700005)(33656002)(26005)(110136005)(71200400001)(478600001)(9686003)(55016003)(2906002)(5660300002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzFRbnNJS0doUjhSMXVPY0JiWjg1VURlZ0lYcW9ob3I4cWJKeFdyc1F6cnZ6?=
 =?utf-8?B?Q1ZTN1NCM05Cb2REV3d0b016MktTenNhY2lIeUhWK3Q0aVJzRFZCaGUrQkNB?=
 =?utf-8?B?ZGpVNnFYWTB1T0lERGR1TEMwVWtScDlyWGJCcEhOOGVkbGw4TXZWTkFEeDIw?=
 =?utf-8?B?cS9SRXhxS3B6cXhoSHliOGt5Q1RmQUxaRGRoL1Z0bXFvaXNjNUcvZUdneW8w?=
 =?utf-8?B?TUZielNuZWg5TXdyb3AvcVhPMkNESVhxN0o3ZDh5ckNuNU1KejRDZXZjbTZl?=
 =?utf-8?B?bUNHU2d4bEJRdngyVjNuaUtlN0lKaUluTnBuR1AzeDFqNWp2MXBDZjdjRUFD?=
 =?utf-8?B?Z013VGxrcnhUM1l0NVBhV1VKYUU0Qlh3TmhHQThhbFhsYkxSTXlqWDZCNkZ1?=
 =?utf-8?B?dmgzMXA4cFAxN1RSV2sxWWdKMXFsU2R5WVVENnFZR3JxZ1M2Rlp2cXlJaVov?=
 =?utf-8?B?UGZMNyt4V3hhWk1WZnJnL2FEaEsxTG5ubGkwSkY1Y1VPTjhkcXNPZXN4NkpM?=
 =?utf-8?B?N3Y5cjBHMXdBeGZxellNVGhKdlIxd25FR2F5dFZPMHhBSUQzL2dXeXdSU1A5?=
 =?utf-8?B?cWtqK0xyNHcvUEU0dzFxczJQMVJPVGN1R0poMldUN093K1kvZHFvRWhqNVNj?=
 =?utf-8?B?UXE1YVp2YWJjQmNEVWtSK1oweVYyNXYvSlhyN09Pb0RDcXZyL3o5bFlteXRY?=
 =?utf-8?B?MWhMU08xSnY4d2xLcmoyMERFN3NIbDN6cXZQSmpGSGE3QkVoQlN5em9tRnN0?=
 =?utf-8?B?M0IzRjNXYmU2dG1qclFKaS91TWJmb2ZPYzZhRlljdVhiOXZyUVBVUUxJZkNo?=
 =?utf-8?B?KzRVc0Z0ZERkdnBhUzROSnVncGVFZCt6VmhqM29TU1hqOUdLNmZJSFBxS1Fm?=
 =?utf-8?B?OVlRTG9VY0wrVHBocXRkYWFEU3RYL3BZVUJLRmlzbHcyRjRuc1k3Q3ZBaE1K?=
 =?utf-8?B?SWNxRzdiQlpUTFdZQ0ZOaE5lMEhnSUd2ejI4UmoydkNuR3pESlhDa05tMHMx?=
 =?utf-8?B?QlNVbDBJTEltQTR3dDBwNzlwb2V4OVlpMUhSU0J3am5aa3FncHRjT0hKL0FH?=
 =?utf-8?B?VXlPZDRmWXlybVpOb3VRVWhwS0NzL2dvbHEvZTdKU1cyRkE3MDljQTdrcEp3?=
 =?utf-8?B?Z2ViUzFkUUhQUG1VSCtWSEluY1RNazJjL0pWTnVLemdMQVZBbmNzNjI0OXAz?=
 =?utf-8?B?Q0JmSlFYcXd5aTA3WG16VkJiU1JibmxXZmUvVkl6NFZLSGdGdmNBN0dqSWJ2?=
 =?utf-8?B?SHY0RGZjUTFaalV5aGZOZDJWYTVRdXBOZFc1YXhqYWpweEFTK0R3Tkx1YUl5?=
 =?utf-8?B?aFQwbUJ6NnlTV3ZrTFQxdGowaXR0Qld5NGRuWCtmRnpydjhtZkZTWE9KSTZp?=
 =?utf-8?B?OUVjWEZPaVEyWkdRbFNMYlRNNG9Jd0MyL0pRSHZrN1I2dytBMEM4eUQ1a3lr?=
 =?utf-8?B?dnNWVzN1VzZOZUZDUnk4d1M2K1l6cHNrUjB2Z3FEcFdQRVYvb1oxQXJlQnYv?=
 =?utf-8?B?UmxkWEVKdndIVXRVUlY3VDJ4ckdzSllMQ05XY1BYczhoV1dadkdUNFhMaGt5?=
 =?utf-8?B?MGt3YStOaXdWS2czVkY1Z2ltRkZYZUdsbVFJVjZwZ215dWlPWEF6cFVTalBi?=
 =?utf-8?B?N0djMnZ2N2RKWmNqTWN5T3dyLytXSVNSWEs5VnAvbGNqZnlzVE8xZWcvMGhE?=
 =?utf-8?B?SnYxUnNNT0VtQThzOFNFM3RMbVlwU0xwNTIwTm14SHViekx4cG40b2NRWWUx?=
 =?utf-8?B?WkJLNFFyRDNUMlNodER1eStJMTdTbDFPRnpwVHZ4eGU3MHkxalFHNHZ1MTA2?=
 =?utf-8?B?REhlMlovNUQxZEVvclZmRW93VUlHR0FrSFRzSHJkWnNPOThEVlh0M21malRP?=
 =?utf-8?B?YTB0WTg2RWM4RDl4NlpOZ2JkMGdPQzY2RFA3LzN2T2RRMmM1a01MOWdrSEpK?=
 =?utf-8?B?Y2J6b3hoNVF4TnVrWHMydVRrdFdILzVHdjdZL0JCTzVyNW1sbnhUcGxTWjNH?=
 =?utf-8?B?dGxROFo2Z1pYdnpTeEE4T0tyQktnTUZSY0tEVlpLY01lNUJwcUU5eUVYc0NY?=
 =?utf-8?B?NHpaUTlGRnpQb3VwMlRYaGtaUHVlZUZhK0Y5R2pnOXkwR1NKMThjNGNjT1pq?=
 =?utf-8?Q?2278=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40195493-440f-4a54-753a-08da647ca79b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 03:06:17.6739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0a+obfpT0X1DPObR6n0YdEBJzETlLqjrzD5Y7OTF+phx2FFlUFUbMSZzrLgA7OqZzcxfBYfsa8l+dgLQg8dRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3332
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIEp1bHkgMTIsIDIwMjIgMTE6MDMgUE0NCj4gDQo+IA0KPiBPbiA3LzEzLzIwMjIg
MTI6NDggQU0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8
bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gPj4gU2VudDogU3VuZGF5LCBKdWx5IDEwLCAyMDIy
IDEwOjMwIFBNDQo+ID4+PiBTaG93aW5nIG1heF92cV9wYWlycyBvZiAxIGV2ZW4gd2hlbiBfTVEg
aXMgbm90IG5lZ290aWF0ZWQsDQo+ID4+PiBpbmNvcnJlY3RseQ0KPiA+PiBzYXlzIHRoYXQgbWF4
X3ZxX3BhaXJzIGlzIGV4cG9zZWQgdG8gdGhlIGd1ZXN0LCBidXQgaXQgaXMgbm90IG9mZmVyZWQu
DQo+ID4+PiBTbywgcGxlYXNlIGZpeCB0aGUgaXByb3V0ZTIgdG8gbm90IHByaW50IG1heF92cV9w
YWlycyB3aGVuIGl0IGlzIG5vdA0KPiA+PiByZXR1cm5lZCBieSB0aGUga2VybmVsLg0KPiA+PiBp
cHJvdXRlMiBjYW4gcmVwb3J0IHdoZXRoZXIgdGhlcmUgaXMgTVEgZmVhdHVyZSBpbiB0aGUgZGV2
aWNlIC8NCj4gPj4gZHJpdmVyIGZlYXR1cmUgYml0cy4NCj4gPj4gSSB0aGluayBpcHJvdXRlMiBv
bmx5IHF1ZXJpZXMgdGhlIG51bWJlciBvZiBtYXggcXVldWVzIGhlcmUuDQo+ID4+DQo+ID4+IG1h
eF92cV9wYWlycyBzaG93cyBob3cgbWFueSBxdWV1ZSBwYWlycyB0aGVyZSwgdGhpcyBhdHRyaWJ1
dGUncw0KPiA+PiBleGlzdGVuY2UgZG9lcyBub3QgZGVwZW5kIG9uIE1RLCBpZiBubyBNUSwgdGhl
cmUgYXJlIHN0aWxsIG9uZSBxdWV1ZQ0KPiA+PiBwYWlyLCBzbyBqdXN0IHNob3cgb25lLg0KPiA+
IFRoaXMgbmV0bGluayBhdHRyaWJ1dGUncyBleGlzdGVuY2UgaXMgZGVwZW5kaW5nIG9uIHRoZSBf
TVEgZmVhdHVyZSBiaXQNCj4gZXhpc3RlbmNlLg0KPiB3aHk/IElmIG5vIE1RLCB0aGVuIG5vIHF1
ZXVlcz8NCj4gPiBXZSBjYW4gYnJlYWsgdGhhdCBhbmQgcmVwb3J0IHRoZSB2YWx1ZSwgYnV0IGlm
IHdlIGJyZWFrIHRoYXQgdGhlcmUgYXJlDQo+IG1hbnkgb3RoZXIgY29uZmlnIHNwYWNlIGJpdHMg
d2hvIGRvZXNu4oCZdCBoYXZlIGdvb2QgZGVmYXVsdCBsaWtlDQo+IG1heF92cV9wYWlycy4NCj4g
bWF4X3ZxX3BhcmlzIG1heSBub3QgaGF2ZSBhIGRlZmF1bHQgdmFsdWUsIGJ1dCB3ZSBrbm93IGlm
IHRoZXJlIGlzIG5vIE1RLA0KPiBhIHZpcnRpby1uZXQgc3RpbGwgaGF2ZSBvbmUgcXVldWUgcGFp
ciB0byBiZSBmdW5jdGlvbmFsLg0KPiA+IFRoZXJlIGlzIGFtYmlndWl0eSBmb3IgdXNlciBzcGFj
ZSB3aGF0IHRvIGRvIHdpdGggaXQgYW5kIHNvIGluIHRoZSBrZXJuZWwNCj4gc3BhY2UuLg0KPiA+
IEluc3RlYWQgb2YgZGVhbGluZyB3aXRoIHRoZW0gZGlmZmVyZW50bHkgaW4ga2VybmVsLCBhdCBw
cmVzZW50IHdlIGF0dGFjaA0KPiBlYWNoIG5ldGxpbmsgYXR0cmlidXRlIHRvIGEgcmVzcGVjdGl2
ZSBmZWF0dXJlIGJpdCB3aGVyZXZlciBhcHBsaWNhYmxlLg0KPiA+IEFuZCBjb2RlIGluIGtlcm5l
bCBhbmQgdXNlciBzcGFjZSBpcyB1bmlmb3JtIHRvIGhhbmRsZSB0aGVtLg0KPiBJIGdldCB5b3Vy
IHBvaW50LCBidXQgeW91IHNlZSwgYnkgIm1heF92cV9wYWlycyIsIHRoZSB1c2VyIHNwYWNlIHRv
b2wgaXMNCj4gYXNraW5nIGhvdyBtYW55IHF1ZXVlIHBhaXJzIHRoZXJlLCBpdCBpcyBub3QgYXNr
aW5nIHdoZXRoZXIgdGhlIGRldmljZSBoYXZlDQo+IE1RLg0KPiBFdmVuIG5vIF9NUSwgd2Ugc3Rp
bGwgbmVlZCB0byB0ZWxsIHRoZSB1c2VycyB0aGF0IHRoZXJlIGFyZSBvbmUgcXVldWUgcGFpciwg
b3INCj4gaXQgaXMgbm90IGEgZnVuY3Rpb25hbCB2aXJ0aW8tbmV0LCB3ZSBzaG91bGQgZGV0ZWN0
IHRoaXMgZXJyb3IgZWFybGllciBpbiB0aGUNCj4gZGV2aWNlIGluaXRpYWxpemF0aW9uLg0KSXQg
aXMgbm90IGFuIGVycm9yLiA6KQ0KDQpXaGVuIHRoZSB1c2VyIHNwYWNlIHdoaWNoIGludm9rZXMg
bmV0bGluayBjb21tYW5kcywgZGV0ZWN0cyB0aGF0IF9NUSBpcyBub3Qgc3VwcG9ydGVkLCBoZW5j
ZSBpdCB0YWtlcyBtYXhfcXVldWVfcGFpciA9IDEgYnkgaXRzZWxmLg0KDQo+IA0KPiBJIHRoaW5r
IGl0IGlzIHN0aWxsIHVuaWZvcm0sIGl0IHRoZXJlIGlzIF9NUSwgd2UgcmV0dXJuIGNmZy5tYXhf
cXVldWVfcGFpciwgaWYgbm8NCj4gX01RLCByZXR1cm4gMSwgc3RpbGwgYnkgbmV0bGluay4NCkJl
dHRlciB0byBkbyB0aGF0IGluIHVzZXIgc3BhY2UgYmVjYXVzZSB3ZSBjYW5ub3QgZG8gc2FtZSBm
b3Igb3RoZXIgY29uZmlnIGZpZWxkcy4NCg0KPiANCj4gVGhhbmtzDQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
