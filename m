Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2319FE7109A
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 12:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EC1860F83;
	Fri, 22 Sep 2023 12:25:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8EC1860F83
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GUgmIk2d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F7DB2ABYHUyC; Fri, 22 Sep 2023 12:25:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E26861098;
	Fri, 22 Sep 2023 12:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E26861098
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDDC8C0039;
	Fri, 22 Sep 2023 12:25:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 120B1C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 12:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21AFF83C90
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 12:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21AFF83C90
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=GUgmIk2d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BM-EABzvD-Px
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 12:25:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::605])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 617DF81EA5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 12:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 617DF81EA5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7LfPeWjf1wJ2jfYjgW/74s4jd5wgkmItV+fJC08QG0C3wYmZMAUPQRMpy7YFtBI4XkIRvgfdyHN5HVEt77pgrFnRFPH1KU8x+oMVbM/jEyuZuqSJuxqqbYCYBL5xB/YY0nwJmsHxl4hwpqVQ6peqhrJ6i8rbGMQwNo0uEYl3fDmIa43BcYGY2LDLfElh5oMoQgqYOg4GwBaoUa2JgsvcTGgps8B2JmIVlrwtmqIbbWWYpZE3wLWu0pZuT5OQi5gNKebYeYj42lGm5jf0xsZ8BOVA94/2eQ7kqOFd0dwwfGZ7ay2YVVIF2g78+rQg9I8Z1KnHVNcKhLF90wupUGfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rjE86fzY2mn57HR3pxGcea6nWWSdFv0dQTjt2GySBY=;
 b=VvkFQnZrRN+Db3XzN/iJrRA8QccvTkmelm8DdZ0ZT8YXbqDreEApEn69kW9u2eEOc18RlQo4vKnQYRUl8iHvy/6p1lzu0NQnR3lBkasf7T9fxfrLKcp3H4xuvQ6MsPAsXW7bcBU/FP5D7VRFgDDAZCay0hZtSSIpWVKlKiTfQL8FDEdJCYAL1Xdd+oldUx8mtiIjStYy6ycVujW1f8+KG+ZCndph6RbqcIlPilOrAyn4RdEQd2SL7sHXjfz8tP9Vfoh9nnv6eIlK28JSLyM7S0Pary6UKu/5mYIBfSBfdNQ2KT3oW8QaBvVXY471yxPsoGts3ZwTlMA47C2pW15hlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rjE86fzY2mn57HR3pxGcea6nWWSdFv0dQTjt2GySBY=;
 b=GUgmIk2dA0xQgS0D1UOsACimUl8z0nHamang7P9ooMN8kzSkX2ojUoDvphvDr6qiEL+yfWuH/Vx6Kxiq/nVbvn8PxpmXCFfW/JHZKSbBbhsoac0c7hm1qctCjnFh1o2Yf44rm4NNM03eNDZ2fm70SxSzW07j83E/JNSWPqAJAOC6vuaY5VegSs/2H7B7KITWiwWYt9eNxg5sKo1UP6S/ES7IzW42bg0L7Y9bYTr+m1hcwMWgxasi55f//s2gPmpfNPxBE17KOOCr1+xI69Wwst5knOOyJhdqepTpO30k3ox/H1PA+DJchkuTS6oU7BNAo2oYvr5pJg/921tnjEUAAA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 12:25:07 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:25:06 +0000
To: Jason Gunthorpe <jgg@nvidia.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Topic: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Index: AQHZ7IkPl5ENqOgMC0yEzkOHANq/CLAlfIYAgAACZQCAAAJ1AIAAAaqAgAAD/QCAAAaKAIAAAwkAgAAF2ICAABWjgIAABYGAgAAGVYCAAHFrgIAAnJQAgAAAJ7A=
Date: Fri, 22 Sep 2023 12:25:06 +0000
Message-ID: <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
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
In-Reply-To: <20230922122246.GN13733@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6058:EE_
x-ms-office365-filtering-correlation-id: 9be77deb-9323-42e3-1c0b-08dbbb66f4a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+mvdPkKg4DEkaWa718rVw93zWs+T8782j9IujSjgf2y2QYWvOXXW4bshLjp/vArzKCyiC3v909HZFBKppgcHuOxfWjbEhuvrMICWy2ZB9EPvgxvYRB94AkZuZAJi1y5/kktzgHlGrg//Pt4V2M5TwVap3eBX8lfR69djMOrWxyaqacJe1kiUw3d0ixsBiGddqZHh0AqFwe+/qc/IBeqw8e4WWdRFwIhqS1wDDpv/4k90RlikGfDSGbWcA1RsYsnvsl6+Pze0b0Ojzvq4dzvg+pDT6Hn217jOdjPdqNGI73vDBIZbNr/VqN2AHIEMWwcmJYOkbuecaflKJP8tJjm5CJbPhWUfGEOFQH18m7qeCXkc1b06VHV4gZOVJFRtUptnSFowkbYKCsQdjbroXhdDCcRwmJTw7C0gWj95hvNx1iW2v+VXdTas9a/k6jrMKO9xgu8PI/USoKWagp/IiDyj0c+iW8ogsx31r7ifZmGwpol2p4TWd+q9mkPMpzGH9r8SNNynaIdtMlmfXoPOV6/S4ZTX5PVu57owSVQTOkCeW1J/N9gghf9rXMbkEEBBu5zZdC/A5AUSfQzbgziNP2ilqX5JWbzFHYo2o1D3xNmkOZPWYl+GjTyEFvQLJtWCvSw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(186009)(1800799009)(451199024)(122000001)(38100700002)(38070700005)(33656002)(86362001)(55016003)(478600001)(2906002)(71200400001)(54906003)(110136005)(4744005)(66556008)(66476007)(66446008)(76116006)(66946007)(9686003)(64756008)(6506007)(7696005)(8936002)(8676002)(4326008)(5660300002)(52536014)(316002)(41300700001)(26005)(107886003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xAU2SfV23jzNSxo6eJKwj+H3n0nPDGklmpivvecpNzUS6UR6LTK51lrgnFYX?=
 =?us-ascii?Q?aIdkRg47z2bGFgQTQdMbwUwdfFLnUdf6HZsPUdzI1VtbqEhdM23oDoqzS7/6?=
 =?us-ascii?Q?nyV+vxQYwRCBZyJdxpbZ4a16rm11NQ3xftB6N+gOxaCTMw8+1mg8Uu/u6lDC?=
 =?us-ascii?Q?G6EBYfd1z9uZGoNMf0s7zM3BSnb1wYcgSkxwWv5fK3+e+0tRY3xapU+2vsiv?=
 =?us-ascii?Q?msi1AvoAG+4pgEBcvX8V3a14rYwSDo/vlXjMuXT7x8GLF9vaxbBxnYVspDFt?=
 =?us-ascii?Q?jSYoiRygLVNePgVic0lkrx4KVDAwBh3ysca8xD5uUT1jrGmycdXcQy9o5oLu?=
 =?us-ascii?Q?WU3kmnNCn+6drZXe0BlryYrCFyhxOMd3Du1RcaRCiDGQLPCYVFKSxuk0a3s3?=
 =?us-ascii?Q?yqmjd3/iyy4k/Jpc4RRpsBjrlg8+dDcP11Wo57E+w8TWecqjeUyJ9wagb8NA?=
 =?us-ascii?Q?hgCEj1GLjo+I64QUBeFsqVUOSPmWVWXENihA8/6BPCxRuaKRZT9MzVFPgVL4?=
 =?us-ascii?Q?Yl9wouFp3rTABBwrfThfr+0UxmOpMIFjy/qbdKrKiuNHsj1hk8IDohvEMxyC?=
 =?us-ascii?Q?77xGfLCD+4sQq6ge0sTMPgiKgfYRpa8p1if6f05sFMNEqGHF9lkFDbkDIGHW?=
 =?us-ascii?Q?TaXneN8nAk29WbImug0UGWYT71qrqO1bswm3d+SpvX2WnKVFpR/bwkmaOtTj?=
 =?us-ascii?Q?mr9WT/vnOw3PnLo415+OlbfV7VvUUD19Yei4WqUtgVbhpAw0cxTPZm99d36d?=
 =?us-ascii?Q?jo9Jg7TahqcBdiViAUgEHOo/i2x83NYQxe9gH+naMIyPT8Z+hyWfn4rGUfRC?=
 =?us-ascii?Q?tc6+wOVNfV6DnCiv8JCGmvr8cLN9yiSht7hhUTQ19fxRqd4x5qF6XMOky1qN?=
 =?us-ascii?Q?d8LuqXM5nZ+14zkLIenKzB+GsIQwcYToaRcybuPaNUXV2rDEJ6vVy+c9apG/?=
 =?us-ascii?Q?459AJDMk9dvMnkKE6yxo54XEu7Wg1lesW9GhhqhzEHcBmPV3Ehxq3TzmybyV?=
 =?us-ascii?Q?M/F14WTc5Oa87ZVT9lIVN6vQQN7e7L+65Sp45nSGoyJqri4PvYKWRAO54a1T?=
 =?us-ascii?Q?5z5ARftFGDTqYr1m3/eJxq8UdV8nmJ2QueVB6fvZWuPlxGtBFrIRskWM7ojl?=
 =?us-ascii?Q?rv/jyv3eR/x/o8bCvbB0uHrMosaeh1uQEy4F7oyXvW1/Gw74FVlAHXixb3DY?=
 =?us-ascii?Q?8w1bd0xXUofUvlr93sp8fm8XL/cwb8u03oHiXsgZGsgGalbBLw+876K3mAKs?=
 =?us-ascii?Q?Ao823DBgvTR7Pb4FchxWjAJUMgEHO5uhe6EXz2XSpjNUmsv69FmtrAq99Fga?=
 =?us-ascii?Q?38yUVkjUoj8Rg4ZNv0TPLe7HOV/8ewZ3IAGrgiqSwDQABRqj40h3oitc4RMU?=
 =?us-ascii?Q?bi5xOncErddq4OW/oJdKUwwDMEEBCiSJoLOnDSLolqjyVKqnvlZbMBn/MCHG?=
 =?us-ascii?Q?9t2Ojsz+SIjpFGkvt18VokDkvPoTN+VBPK8ibDTGYYtN09LrN+wJUFZdrWD+?=
 =?us-ascii?Q?tpEFvKOKfg0wsk9hxbEJVi0mDE7+fJvn4sRpIgHHnIIAQJQQ8mt4wWJDnU3G?=
 =?us-ascii?Q?M5N4qbfFQt84r+gkARA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be77deb-9323-42e3-1c0b-08dbbb66f4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:25:06.8106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yT2QzZY/8nLOhSgDAhqiQ+NOjvzVvd/h+rD2pABLIlPd+p+qhGoBsh/ZWyGJy61B0Fmk4Dvvtv/vE9kLtg8JfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jiri Pirko <jiri@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
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


> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, September 22, 2023 5:53 PM


> > And what's more, using MMIO BAR0 then it can work for legacy.
> 
> Oh? How? Our team didn't think so.

It does not. It was already discussed.
The device reset in legacy is not synchronous.
The drivers do not wait for reset to complete; it was written for the sw backend.
Hence MMIO BAR0 is not the best option in real implementations.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
