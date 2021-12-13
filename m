Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551EDC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 05:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB2CC84E35;
	Mon, 13 Dec 2021 05:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CzGeGAe0sBds; Mon, 13 Dec 2021 05:58:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F04184E32;
	Mon, 13 Dec 2021 05:58:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F0CDC001E;
	Mon, 13 Dec 2021 05:58:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DCFBC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 05:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 553AF60AA6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 05:58:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VKMcylDPc2Uc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 05:58:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F37860AA1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 05:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hvg/pv1m/FoE/KCsgQZMY7oj2xhmAz4ujgkLkYrj9e2qYRsxqFDoSRzdNq8U1giBfU6yBnpPb+68cOF6t17Ixo2p0cMOYdB0vYKWZdoOc1MNRnHfQgosqMzeE6OAKCaBMC6Tq4kMWJ1nstBMl3jr1A9yt2Zc7EVRIPLgBvq3LSjKc96hcg5ZPi8oChmr+7aefYy6qAawWNMBRQwifRY/P6mPTI+XGADgPvhOoNouaNIcpiwOaoVVqTLVK8eQ4e1iM6gHYorsoIq82mI7/lRHx61/yyCB0g4U23V+b+79x7qBhKa2Qj46AFXx3JC8s4J/GC9T8PsgYRmvLjJUpNRj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeTv+/X4G/epzxLwH0cROBn7D51MVm20gYoZYbAwQZo=;
 b=Hu1Q7uRk21e/HTJs7HWWqafaHyONY2wI9cNP0/0HIkpI2dkd9LQNXl0bUjA44xjN95hXDFvLpEFHW9rWu9F/583rHISz+By7tb0ywib63BHywijPYfxaWN+xAcGgCWDGjHlgM7Eambgs3BW5fja1LQKuvKXMd7l0BmioL+Rbe0GfO94eIC4mfvI8BnwUmaoyGWVlJRZqeMJlPpqxXngJDonV7jLesHEyoWphgq5nS4qIfmdssIWUcoriyb696StnGLfNz0YKvKi0lAdmixgwNMXegdfX/qpullC0VdY7W6JrHodGwIRhhfNTlhVvMhoifzYgSnElVagLyNZDjd+EYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeTv+/X4G/epzxLwH0cROBn7D51MVm20gYoZYbAwQZo=;
 b=pJIIyJ9pjU2OmV53PHcrqvoiVUb6oDU0GhghhlbLbIChg+gpN7v/guI810CNdV/beVqRZMe6VV803PhYzBx0V3qwxGGS+W5omMM1S2ynxnezJ+5MXnQKw3M/ZtYNp//ClWkKKAPZvQ5BSr2/jvtBKnwt4wmrnGqktZRamVqdJ0tAwWduDg2Pgcc+46MtuzkQYuvIm8boo4tZvS682TIv4vkox81DxaydmtZYOtzlNU/Yof6m3O93q2NW/OL7sDwlpJkXfyFbZq+ycgypRmxdUkBGORmtULAeFKadCGqS0DxkSiaGEqzRG0G6HPQCLrROjh53kbgnKXxNKnGqFfqTBQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5499.namprd12.prod.outlook.com (2603:10b6:510:d5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Mon, 13 Dec
 2021 05:58:47 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%8]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 05:58:47 +0000
To: David Ahern <dsahern@gmail.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [iproute2-next 0/4] vdpa tool to query and set config layout
Thread-Topic: [iproute2-next 0/4] vdpa tool to query and set config layout
Thread-Index: AQHX5zRJNZQkcZPsxEOh1JEFFqiR1awg/ySAgA7/GwA=
Date: Mon, 13 Dec 2021 05:58:47 +0000
Message-ID: <PH0PR12MB5481F6E9E52E6563176C883DDC749@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211202042239.2454-1-parav@nvidia.com>
 <7472fe36-b0a9-d731-8c2f-20be0411b96c@gmail.com>
In-Reply-To: <7472fe36-b0a9-d731-8c2f-20be0411b96c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 325e78ff-6db1-4215-0dd7-08d9bdfda13b
x-ms-traffictypediagnostic: PH0PR12MB5499:EE_
x-microsoft-antispam-prvs: <PH0PR12MB54999327B18F5C136FDDD7AEDC749@PH0PR12MB5499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3aNwwWLCF5J0L6l6V8MkNspFcDFdFmzfKVveaP7v3kRH26OHrsvPMnCqi/zPuLaGw1fK7596GQKPxs6mRp9EMp8nzUSv3a9dFvMLDvwkCT8hUD7fNqmpxxkmTjm+HL3Ae9m1BnEyldA2t1Ev+9U+8TKbs6ZHz59/jhC7kjpZdhA2xPhNqYl1YYMloGqnH/Ws2zFWQ9qKVt/PVSEx7DmOhHr+VO7jIzOGvTLO3bZsPuj/r3hryJgfUwyhvsFl813K6+wmpK1F6vflFSnBQ4IRekBhAbtPnFnmzmvgI8fcLSw0ntiELog8egZl/Gt5yAz894LpSwEtATRUlJE5iUZu3hn4W6/BWbVml61Rzn+2j7YL0xvczPtvpjKsDBsR2TszgtqSNJsg8qYAl2h6oezXkZjgYNCofavjffCj/dXy7x8jJPGMGLtzS3YlEHHIBFpq9seJxBVjoRD8lQzxPvC8/jssT41nAXXCIzm/rhzigRwQuHNELrvasye23j4j9KkwppAi2WRdGdxs5kDgOcqGKhdVJhjENlMPNGlSug8CfwgAGl7ybEa9n5mUS0PK0hRfSRvpSqFDJak/kordbrGBV2IU5wYjt+hYZ27X5vtvb2CYrEJwjKVI26KtJGZyMD9+V21n8+pBbPLAQxhNJy41N9/oKK7InCKByNIs1FVIcmJ38KGCbPRrPMBw4ENbWmY/sUquzsjL9EQHeAAyL1buDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(186003)(7696005)(53546011)(122000001)(2906002)(71200400001)(9686003)(8676002)(55016003)(38100700002)(5660300002)(33656002)(64756008)(66476007)(86362001)(66946007)(6506007)(316002)(4326008)(66556008)(66446008)(26005)(52536014)(76116006)(8936002)(110136005)(508600001)(38070700005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEFMai9OTnJLb21aSm9HNFpMc0NsVnpwbXd5bFdMVjR1cDZYdkUvallHSUZZ?=
 =?utf-8?B?STB6ZW5pQjZSRUlGWENVZ0RLZUd4NFR6RXVGVStGWWViRFZ1NUNRZ0ZOM2lL?=
 =?utf-8?B?Y0hiWHo3R1czWmRBaTl0TVNZSjFsenBQb1V1L1JJTk9VMng3RGwrZ25mUWkw?=
 =?utf-8?B?cUJOU3hueUhoVE1BWUV3TnVHTGw5Qlp1N1pKMXFEdlVtdWVpRlFvbXlWRm1Q?=
 =?utf-8?B?TkZ1cGtzN01KY2VkUUlQeGFCZTNLQU03Q0FMUUd5MG45bTFWTWNud21HRk9u?=
 =?utf-8?B?OFBMTHU5T3NZOE5hbURicWJTempta1VFd2h4eUYxUXFkOThLT3FZd2NXUHlI?=
 =?utf-8?B?c0ZXQ0I0a2wxUHRIMGlJSDB1M2NESlhHZjhNalJYWmw5NndIRUdVb1czakpB?=
 =?utf-8?B?azJXVWIyTUtXN1d4Nk4zZGpsR283eloxQTBNU2JUTGxtbEkyTFZTemdFeUN3?=
 =?utf-8?B?QUtuSmZPOXhuMTFoMm00Ynh1c2xYczlwR3NlWG9XR291bFBFYUxDYjBpTlRZ?=
 =?utf-8?B?dXNueUU2YVA3OHV1aTgyNWdNbUFBWVBKeGUvcTY1YzVuL1BDbVZBZWV4ZFZ2?=
 =?utf-8?B?RWZyZ1RuWVZyZndpYmlQbk0rTFhDblpvY09EUmt2TWJ5ZVA4VE9Fc2Nla1hP?=
 =?utf-8?B?dGlubzN4a2Q2MUpiaUdadk5XR29FY3B5NnNGMkg2TEdDaG9yNXFYM0lNRVUx?=
 =?utf-8?B?bThvS05DUDVzd0JNR0dvYU1vV3hUQUtLTDNNM3RpVVRlTU1FYVdFQUZ2eXZt?=
 =?utf-8?B?bmdUV3crdkFIWU50VUp2SDRYaDVKNUljbnNDRStnY2hLbHpFZEpvMGhaYjFh?=
 =?utf-8?B?N29IdFlDQVdpZmttV0NuNzZVTFpQZTl2T1BFbmJaUU5UMUdXRGhHNllVRmtk?=
 =?utf-8?B?QmRCMmRKdlJLdVlGcG5qdk1uT3ExbEJKWXhrNTdkU3k3SkhoczJQUFVvYmY1?=
 =?utf-8?B?MEhHQTlrcFh0dEFTZjA4a2JvMGkxMkRUMkxLOEdnc0pIQ1diV0xhL2lyTmZY?=
 =?utf-8?B?cEt4MS9UcitNYTZTMFBkRStreFBoYmwycWRSVnY4OUhKQ3lMdFdQeDgyc0lF?=
 =?utf-8?B?Qlk5djhpR2ZXckVzZDFrUnJQWTc1dWVuOHRNd3hXVU1IMGJBVG1oSm1HbFlZ?=
 =?utf-8?B?MjdtclJ5dzArd0huUUo1c3BDOEhVUzE3RTlzVmtBSkh4cVk2VVZDaHVpSUkz?=
 =?utf-8?B?NGJ2SWNselh1b1RHU1pGK3R3V3dTbGRKNzJKWEZBZmdsNlkrVWd4M2xDdy9D?=
 =?utf-8?B?QVV1K3ljKzNnRlVXQ3NIdFBLUEw0QVpNN0pURTVYUFhrQ2E0UVdMRzlNaXpl?=
 =?utf-8?B?dVpHci9tclJiS1JuMm1DMDVXOSs5Q3VQNTAxT3ZkV0lZVXVwdjN1bXVkdnpt?=
 =?utf-8?B?d3M2dTZPbnB6dWxTdlk5MTd1UVYzUWltazdhSGRrWlZMQ2Vmc1FqOE5ZM3B5?=
 =?utf-8?B?YnZvSm04c2tnTnUwUnFya0Q4aEc3SjVSRzFIVVlYMFg5YTd6WmQ1M2x1bWV6?=
 =?utf-8?B?ZXJEYzE5aE1Qc1JOdHppQlJ4cS9FcTZnVWJRUVVkTnhTaHFIWmVVNmdKdGRo?=
 =?utf-8?B?aDA3Tkptelg3WU5JNmtPQTd1dDJOOUlualBWcW5Sa1hGOCtLNkUzVHBOckNS?=
 =?utf-8?B?bXQ5ZlF0WjFOcDcvVTNoYTZ1dmRZSmZ5VWZLM0crb1NvOGRXUGZCbHZISm41?=
 =?utf-8?B?eW5kRk5tSTdoNEMxd3dVaG0rUU9mOUo2cHNlVVJKV2F0Qks1c1lkbmpPOTVk?=
 =?utf-8?B?YnJyRElBN1gvUG12aVVFdWR0OHVJelJ6Q1NJak9LeEFZMlphYXNZaFFUV1Q4?=
 =?utf-8?B?Q3NjSXF0SS9IQmJQWUhKN0xNZEw3djFFSlRoT1YyZGNpeFUrRXFJV3lDVmhm?=
 =?utf-8?B?R05Vb2FKQzBIS21qenVQVDJLMXQ4cVZ3NlhWSGJKSUlyWHg4eUZxcXpXMy9x?=
 =?utf-8?B?SXpySllxK2h6Umt3Um9sdG9KRUR4M1ZmYUZDeGFPMnRqVS9yTTIzalBGWkth?=
 =?utf-8?B?RXZuVisvdWxIUkVvMkx0SGc2K3prVXplQS9TRlRoRXZ5cVAzdzB2MjRsSnRw?=
 =?utf-8?B?RzVaZWQxeFRFeFJ5b0NXMDNHQW91cjhCU0o0YWVqdGRBQnV4MUdoajFqc0pM?=
 =?utf-8?B?cEJERWxVV1V0RzViTGRkV3J1ZW5nbHluMUNtZmJQTUsybGJSTlhsSEhKZFlD?=
 =?utf-8?Q?q66RJrXhNIMxY0zxl0pP0JQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325e78ff-6db1-4215-0dd7-08d9bdfda13b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 05:58:47.7440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIcNZljbsTfo4VdjW5J5FHSncqfAQZJneuyF9stQ2w3VQgKDs2QcfO3U19PfebE0XctXyEKR8EDuOOcIKKoWLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5499
Cc: "mst@redhat.com" <mst@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: David Ahern <dsahern@gmail.com>
> Sent: Friday, December 3, 2021 10:27 PM
> 
> On 12/1/21 9:22 PM, Parav Pandit wrote:
> > This series implements querying and setting of the mac address and mtu
> > device config fields of the vdpa device of type net.
> >
> > An example of query and set as below.
> >
> > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu
> > 9000
> >
> > $ vdpa dev config show
> > bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
> >
> > $ vdpa dev config show -jp
> > {
> >     "config": {
> >         "bar": {
> >             "mac": "00:11:22:33:44:55",
> >             "link ": "up",
> >             "link_announce ": false,
> >             "mtu": 1500,
> >         }
> >     }
> > }
> >
> > patch summary:
> > patch-1 updates the kernel headers
> > patch-2 implements the query command
> > patch-3 implements setting the mac address of vdpa dev config space
> > patch-4 implements setting the mtu of vdpa dev config space
> >
> >
> > Parav Pandit (4):
> >   vdpa: Update kernel headers
> >   vdpa: Enable user to query vdpa device config layout
> >   vdpa: Enable user to set mac address of vdpa device
> >   vdpa: Enable user to set mtu of the vdpa device
> >
> >  include/uapi/linux/virtio_net.h |  81 +++++++++++++
> >  vdpa/include/uapi/linux/vdpa.h  |   7 ++
> >  vdpa/vdpa.c                     | 198 ++++++++++++++++++++++++++++++--
> >  3 files changed, 277 insertions(+), 9 deletions(-)  create mode
> > 100644 include/uapi/linux/virtio_net.h
> >
> 
> please update man page(s)
Ok. I will update them and also update patches to address comments in other two patches in v2.
Thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
