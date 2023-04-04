Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13A6C761A6
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 07:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78D3561012;
	Tue,  4 Apr 2023 07:20:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78D3561012
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=dKU3ZLgb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28sVG-39vODw; Tue,  4 Apr 2023 07:20:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19DAA606F9;
	Tue,  4 Apr 2023 07:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19DAA606F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F23C3C0036;
	Tue,  4 Apr 2023 07:20:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C364C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD5F64049E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:20:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD5F64049E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=dKU3ZLgb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5KodQqtUaocO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:20:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6AEC140496
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::61a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6AEC140496
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 07:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFRxjavhcia6vyEL7OoZTPdjQTRAgg7YusSdYUv3Jd/hCq5zJ60vVuhTmm1o4tvBGpGG4aIKImU122SLSAgxqichS58KmzJzLz0MqvRqyMoxD9mCEeQ9fjNyzRGgkgXDrlSsQIHZRqRIep4FrP+QaU+yZVvsJWJwkYdJCEGeFx7g9GaHpCIUl7zOws+wYs0xACdERkNuLo7yie1gEIqGsMif0l2PQXxMVuhujIhXc6/Y+HBfI8Exz4IHZv81G7dgjIFIckB5O3KJ4B1tJXFJi/6JRQkvxbJcm9+2ViVuJJUe5D+QoIb74jNQEuH+rhd0cbuImT8IFMQyNNMzrK0qZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0tTqR0VihtN6Q6ep3kswEWCc3Q0OBr1nm7zmeCuXW4=;
 b=JGDEwMew3S4VexWN3iOYMG9pLe0dW0k6R/UhkAsCvNBQlyT6YY8i+HnSnA9ywQYbUpCbIvXlIaE2qo4szonItIF45vpLOBjWzH0LVU8r2GKFbsYQDubg3ZgaVTOvFZTMBO5L71efMC0OSI+hQD8LZq7mXMsdBX2mKlOJnEUh4c7WyllSfk8mTLRBs30TkjLQEjyPBy3FX7ZBJCNPPBVBLpdW+dIaVmEoVxtX9BoS8HabybByzS6rItaXY+GOpH+eOco4bnQkjRtmKR9yFyL3tvcmOmjJiAc1B3t0LHpDX1jtKcO37MzuHFxcgCklKVBzwp4Ho+lWAK92KYmuHct8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0tTqR0VihtN6Q6ep3kswEWCc3Q0OBr1nm7zmeCuXW4=;
 b=dKU3ZLgbdV6v9jVcfmbZdc5a1qd1Y8Hq78TgRVlMl1/v3ruE2BEMQ55FqVDfOiM8R/hSjIXxRno97w0x1CivHLm/35ndoYst8/pgCGrGs+GgOwrUohYiAs1Ydd+gugy6EoYjTuP1Dw1ibdLTtpThrAyx0bAQRjP3Hh1NmVPphGw=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AM9PR04MB7538.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 07:20:38 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 07:20:38 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Thread-Topic: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Thread-Index: AQHZZTqfsYDZLLTALE6VM1zAC7sQQq8anL6AgAAkLnQ=
Date: Tue, 4 Apr 2023 07:20:38 +0000
Message-ID: <AM0PR04MB47231B9400D7E491D1489611D4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
 <CACGkMEuQo+ojjtjH=Ne0e5wESERUPmSvCDgTXwepz=TR7fO8RQ@mail.gmail.com>
In-Reply-To: <CACGkMEuQo+ojjtjH=Ne0e5wESERUPmSvCDgTXwepz=TR7fO8RQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AM9PR04MB7538:EE_
x-ms-office365-filtering-correlation-id: a6b7e267-b4e0-4ed3-5a46-08db34dd1765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LGrZwbiFqERLY3SJD3gnU3BHjhk5oaT4fkeAW4TKpzBU5Re+tzf6dYgu7+42chPbaXlwpRfIoEXlv02sXnQGXteOzqG6oNmCR4G1ZGAZIkRvWir4kFCblskeksDOCJwJTynaUMZNRNuM5Gc38aF3/BPonovEAja1jd9Lr8ye/+jtXwknAwN45a31glf0k4YMKmA2J0Cw+wpy6kMXv9B9Y6hzKLkwQxKsF6Lp80oXFUnK+KuvpkyRxiF4ikEBZP+/57GA++HB+MqI8coPHrM15A/v6N30LR1tdzlkK2yWowr06pHfsZGuVmK/oD88QKTXZgdv9Q/O9i5rfM0scb3Vc2kMiuwEXVSJMvAV2AmxocQU7iFfTcr3venX+2xgAY45Vzc+v0zZ1lPmcsckGo/sz1dOk60vQHJqiawzcR2Z5AYSpXjdZP8IZjY2+t15BI9obbpOV9izXU2S7Ejz4kLiUSny3eMqiyUlq1InbZp7zLyZEp7SxMqbelVwB7D6WRWrR1lxFdWjekxOHsHeRRkSZITZUtl1WB6bTiCxIldZcQBObfrunRDr88ipJWG6VDN62fyrfo4bz9c1LUBD7NbHU4GULI+rItARoMBji42jHwTV6hHoNF8zbMdTAkUW5sW1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(39840400004)(396003)(376002)(346002)(451199021)(33656002)(122000001)(38100700002)(44832011)(4744005)(5660300002)(52536014)(38070700005)(55016003)(76116006)(8676002)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(86362001)(8936002)(6916009)(41300700001)(91956017)(83380400001)(54906003)(186003)(26005)(6506007)(2906002)(9686003)(478600001)(316002)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w2RK+VLGvzXUCvJE5Au66ZPQFlwY0rZvuISwj9+mMFRPYyM7Ubk4bP1ixE?=
 =?iso-8859-1?Q?GgsXYGO08m7f+ytrNzr1q8vA4i8ahGrAgSGQOMPKt/7f2LiIK3dXoZHvMi?=
 =?iso-8859-1?Q?80mWYREGhcpDvh/W5ZBuqotv6JqpPW8+cerqRvy3bRNwA1F/tT1vwwVamd?=
 =?iso-8859-1?Q?Gy54nO5NXMxx+ksXl3Le6G0RKwDRHqCrCKrdgW6O2W8XjKUB+fY1pzxFsa?=
 =?iso-8859-1?Q?i7fFRSg+c4VWd1dNzI11jKLPTzFyXpCBrMusLPbpHoTyqpe9iJ3+fNWdU6?=
 =?iso-8859-1?Q?un6lZF7RUOw1G5SxjJnRSLn/IqfsFChCglI9ksUxEUHgzJQNCckCTDTCdT?=
 =?iso-8859-1?Q?w5+MTXVxzLETuN0/0Rk7IlHK1l+UJFVLaRuFf8xVyv6RJ8fPFW+veWgmzF?=
 =?iso-8859-1?Q?dnuAOBlzfQ3HPs/wVzRVmuB5aKUifs2/7h++WtdjalntXO6MEoPumMm8M+?=
 =?iso-8859-1?Q?e0QEm8ABgmTwCn5G1AsZCpcLvix+T3d5DQjxlDiMXZ+2/OGOlAC9RU2tZS?=
 =?iso-8859-1?Q?DFX90nBiTZ0U6FEzrLVGP3qMA57ukslYSZNNa1hLOsRjrV1bFBWFcotnQv?=
 =?iso-8859-1?Q?jOLANIDTXV3XDnO/3PiTMLTrNlrlgz5/wXUGuE1GyCB1fSvdW14IsyQtqJ?=
 =?iso-8859-1?Q?Oz4b9HYu6KmWLpRFl+T2+0w+XJFnnjiOdMqHsPp7dNZyXsRswUhEqXEXB+?=
 =?iso-8859-1?Q?CMmBlHvqzHG9D95Hb1YERrISWBXFzc2Izt4M6daE6aFcAFCJp3W44EwONK?=
 =?iso-8859-1?Q?XcgydEADKi9MhFkG854OUGyWhjTVTLV/iCRFQOsigwZ5VG49hYRm49vQjF?=
 =?iso-8859-1?Q?huXC21xh2l0VLVeS3G3iJZHrJu2Re8IGL0Z+aOIL+blTb5Mwz9ivroSaOt?=
 =?iso-8859-1?Q?dQXRGu5xVcVS3ntZ+mBHuLzSvPM4xvTyBsyFtC7gYxixob+1d/V9hJ/ixy?=
 =?iso-8859-1?Q?0k5pxQG3Qe3uy8X2U1ES4l4FjXA16ZHab8EVltWZ4wPZQjwOynJdb0Khsi?=
 =?iso-8859-1?Q?h44mU4FK0plcaADcqKDBoa9f7pHiPZflpsd4HQiKxAe2KRjN74lG9LGqwo?=
 =?iso-8859-1?Q?1QI5UYZruJAf82zpvNs6vO8l5cSfs+Q/X0JkgRXZBvVkSkL/Mk0LbxdMrf?=
 =?iso-8859-1?Q?rnH1vD7YEgm3aVrdtUyPZBjQJC0Rs/XX0wCDW1/8ELZK8uP9kTy0LvF0Ic?=
 =?iso-8859-1?Q?sVJDNWh6jhZdUEshJKhBa4pL56jg8R/SlM99cDVRrs94M9TWbuBMl+uTmL?=
 =?iso-8859-1?Q?HGEWGi3xD2Jxvr4hdpd1yiWAXDDQLNf85/j//2JvhyEE+Vyz42ckwDvG0F?=
 =?iso-8859-1?Q?cirNaKY3kA2tfCIVCO6hEouESwILK9C3tKSVvdOVhkAORNv6iBYqgPX1l/?=
 =?iso-8859-1?Q?EAPpxhlqwkRuPB0ldph2WAnFqFs9xFcQQV8AHkVzJHMMOuulMKZIa3RmR4?=
 =?iso-8859-1?Q?HjEQxM3FF7QsA9N3Sqo8xx9cYvWCuycK2rvRqBh8knlSwxFTs9khKDYalT?=
 =?iso-8859-1?Q?qTIZZJu2o37z50A+OJnB45nnjHVHXjSS2OIVEkdd/b70zGuMT3G73qn22i?=
 =?iso-8859-1?Q?6S8NAexkomiZKGIJx3a0UX6+7ay0meNSLfATarMQ7TQ3I/y2BSQQTdSSQQ?=
 =?iso-8859-1?Q?1cZdpU0H522huB9SxxToDjEzbU0f+lOo3k?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b7e267-b4e0-4ed3-5a46-08db34dd1765
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 07:20:38.7542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuPUkYdlKqvEfJzWSox3qAqL71SRjbXXVmM+BZpILsAfzGwD761094xWUmshKVGUoiZfH0qFi2h3+lM6DxJUcElQ7msc/b7YIrLyjj5MTqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7538
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "viktor@daynix.com" <viktor@daynix.com>, "mst@redhat.com" <mst@redhat.com>
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

> > + * @kick_vq_with_data:         Kick the virtqueue and supply extra data
> > + *                             (only if VIRTIO_F_NOTIFICATION_DATA is negotiated)
> > + *                             @vdev: vdpa device
> > + *                             @data: includes vqn, next_off and next_wrap for
> > + *                             packed virtqueues
> 
> This needs some tweaking, VIRTIO_F_NOTIFICATION_DATA works for split
> virtqueue as well.
> 

I meant that next_wrap is for packed VQs, but I see your point, it's no clear from the comment.
I'll fix it in v2.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
