Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E3BC433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 03:10:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F4660F9D
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 03:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31F4660F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E91E881AA7;
	Thu, 28 Oct 2021 03:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8U93VNrmcXAI; Thu, 28 Oct 2021 03:10:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 772CC81A92;
	Thu, 28 Oct 2021 03:10:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C461C0019;
	Thu, 28 Oct 2021 03:10:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 636A7C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 03:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F8D340435
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 03:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fSdbNqdcNp-P
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 03:10:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92A38403EA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 03:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSqZCfERwnvH4OLW4KouOtkOfrRqd5/7UMJIgXfULBaYNbgP9DUedJ1vzuTlHnScat9ZTOVeiE8QKSTngGN3x6Vd67tT1NaKiVgvYuwSyYdUYnAvv3c1gl4tYU7ettzMDcZMrdvLbnJp+YnOLhUDi32mfldRSSKzvLi984i4N+MLBO/DFEWZZSDXv97uDmja7ojeFkYbo72BctInSm5OqCJwPey2spWREb6sFQ8Z02gEVqr9MfYqqHI2sD5/t9gGU0qDb/W3yT5jyHljkE7i3tlftaWl+IzdPv/zE4Ufpl+gRUDcnbE6VcPX4FwpldkagJSspQtXNvPniS2GMDWxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ALAr8gw6x2RfIapa5tIc+Y66FEM5kAuxIhwwrvkoW8=;
 b=BWkUEqHETUGFkr+kUiSSJqO8PcE2DCShoBuka5Z7ob1sLAmSZTJdViluT7vQc7Zvv8dvUyJ6pl97rIgV1bQDdqpfxqV4RtEAOR79snXDARLaVqnAno5JV1TsJGDrL4W1kGT9KL+C0I8IGQv6QfpEOUD1fiJajh1BpdKF4Fofwk8msi8Xvzh4DsgQGB1g8l1pmDgvKM0AT7l0ujqruPN1emBNEqyRyHgTT/c5ZYrp6L8lL9z+ynDW2C90EjcKPK8KD8zJB986hMk4oW2tA57JRDihbt9S4NEAUVr637LyrOHcacXRMoIbJau/VuNc7EbxRXFl9ECNatY7PWb7Mvhdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ALAr8gw6x2RfIapa5tIc+Y66FEM5kAuxIhwwrvkoW8=;
 b=V0mtjWCDAocM0nWzZ2FPPXEqPw9U94IEBCZFIAOrk7dQ5MFO6JaiGb/w9M9LdVrty1CeT72SFZgVfK/18rulbrteUL+TKnvas03fg5lUBwyR1AMFiToKVBJrzcLnGomiP10VR1MB9zW7iL/r6M7O08Nduz1L6laIwt4aBPkv4bYi28E/rBCoRoUnJxK01TvsAk9DAS2Kh1ZwFiLet2giL4uvE8jFWdET0tYab33N1umBG2MzLTO4hLPnDfSqYeiKrdH7MVaHYIULyaR+3mnFZG87eDfrwfjmgMjxrgyfRHb58VBhzm29GURSVWd2RqNdow1cNvFN+kgbXefRXO1pIw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 03:10:08 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 03:10:08 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: vDPA bus driver selection
Thread-Topic: vDPA bus driver selection
Thread-Index: AQHXyz+5W8bHEdMi9Ue0cOjhXwdA36vm745AgABY+QCAAHMO0A==
Date: Thu, 28 Oct 2021 03:10:08 +0000
Message-ID: <PH0PR12MB548183B88E372BCEB2F59D67DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027161446-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211027161446-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e655b976-ad4f-47e6-4059-08d999c072d3
x-ms-traffictypediagnostic: PH0PR12MB5436:
x-microsoft-antispam-prvs: <PH0PR12MB5436527F9CA28792F21858B4DC869@PH0PR12MB5436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y8MMpCy5Hi7ajeU64sG+Xi7RoUt0SBjF1oSBzY3KJTUvrJ9JRHHqsv41NsSS5zHq6+pUC8i4UdjJ/fZpTYZiIwnQwm9xF7NaPXaTl+D8YoV0T+ffEECx6EPjIgK3ZaFplw2k1NbRQ9x1MdZktkUll9Md8X4nL9vlNg0V1tYLkpii01dS5SBDG8uPrbAVstM5zY9lF/w1dhm3lRqrtXkGgqx5QZi5T1FgmaDpwJnqhSBBTNYOw+2l6cma+0fxqfmKq1mLpFl+CFCxo4kIxRV0AS/2d13VGfJcSed842qRaVwJe5lTZ4EW2Sa2cAyiXnv0esQ0BaXj9McSe1d64QLX9/E4E/E0kD1JOFmwDk2mLZKYj/cfRDnOJCrZnVRhSiNU1Jt5siTOUley450tDzO2Mn7W6rUwjX6HBV/aIenLqxai3zJh/cTNcK3QMhoyvKqCGP6Vr3tVSEjsHQipcrg94qpxVP1n8WES5OLCZ0p46S8klKuZnpCf/XwcjdXndx6pxMYPUXCgLMYKdl5sTe5QlSMLM1T9pA1HwBdVo5Rf4RuD0VZEPi+ebSOOqQJ0DA4/AoLaolCMEN3ULZtpbV9DtMaqmPc2xiymWCrvVVveh+Sr1YsJi4BHNuz+1mOyd2mJX062xzZBUn2tAHmDmqenseI+kSobxGOp/ZG5hbU04/4inYlmmJCmZ/xShJozKkyQPWd2cC/LsSefQuXs20PkZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(8936002)(6506007)(76116006)(38100700002)(66946007)(107886003)(508600001)(64756008)(66476007)(66446008)(66556008)(71200400001)(7696005)(38070700005)(86362001)(122000001)(83380400001)(26005)(54906003)(55016002)(9686003)(316002)(52536014)(33656002)(4326008)(186003)(3480700007)(6916009)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MYWxH4D60fuE1LBrCEYWygTvhtf0PoBIz/4kG4xP2WkzUYNBgocbqN8c99HB?=
 =?us-ascii?Q?OLm9zgiAtKOwpB3f4dhbabzpVbMZvBwMIwVKSLYqhRS28wt2+wWjI98PRAfe?=
 =?us-ascii?Q?I9HVDoDl7DIe+JH2/l/wS8vH131px38OEJ/SK2iruPfSiXFhRKBCXWtmv3c9?=
 =?us-ascii?Q?AUxzoSAuiTndtAAZSKOtIkv+RpmcMmC1WDaqvyi0ORVtovHMLasEeRBymsym?=
 =?us-ascii?Q?tje9O89bGRKzjywLaMVQ95FXzZq0Y6tAFuOkoqGyhV1dL0hqnBcN4eEg5Cyd?=
 =?us-ascii?Q?BDTHidMHNRrr2qnv5cXUZbTMVX05OBKCfYjWdv+mqA3Pvu0H8/rEesRLnrTm?=
 =?us-ascii?Q?4FaxA03ia8mX4fUgiVM3vsiLJN/nE2k49311XAR3Nchsk2tsoE3wHRxBvQzU?=
 =?us-ascii?Q?OXF5If8tj8vtvYjsu3/8p6inbD0oSmaBrWO4vJEMDrd70+aSMvTo9ArwkEVo?=
 =?us-ascii?Q?llLY1zxyhU/+oibmSgsyeX5snwhi2iVPKUxr/oJQdst0FKqpVYxpQqh6UGDZ?=
 =?us-ascii?Q?/1Dq5MIdafi7XoLGoDiIadBbzHLuPg05Spi0QYpnVrLc6gPmD8vq4vykqxda?=
 =?us-ascii?Q?2I+orAwdVmER2wAYCpOk23mmiT2YLi+1VX3ZIf52BZCDLQnQ2bgPJZDz95W6?=
 =?us-ascii?Q?uPZnLVKnGCAgpdNqTLHLF/i/XDViCty+XkZeYdNPhNUxNfp4M3ZTogeJrEBC?=
 =?us-ascii?Q?+5DLgE9fotyk2kVuX4lVueWdJ3SMExUJGfawB1iIdbAJP7t7K7h7B4pSvRTc?=
 =?us-ascii?Q?4dOVpAdJrRQjQVKTqN6u14EcYR2Jt5971cNBCfI29TsxEGTm0W0D0ySzcfL6?=
 =?us-ascii?Q?rRNI5e3RfqvZNbSnYWHFsit8Bhn9hiMz2UhE9HEkL5iLdGVt7/QaKOwLF0a7?=
 =?us-ascii?Q?zthpOXe832wd1YoxZRh2DwijClsvQG6oB7EnWVQeOk3WDtHK/x+cfR955Vt9?=
 =?us-ascii?Q?iRW50tQtcC5CxveCbhCPHoOl7WlexzEp7ziE+aO0+qAr/G2qpHsukgHWmz1l?=
 =?us-ascii?Q?FkbiAuyOionoBFG+Rs82oqzk50Zm8+mEzx5SUjhg8k5igkgRE9XpcUJyaAnQ?=
 =?us-ascii?Q?ARaC9Sy8fSYExeMUEMJz37T1mYcCj6s0GtLhv/F8IVqhXhnxdoKAfRkEIQZL?=
 =?us-ascii?Q?enL+MRwtxIiQOSwD2aq3LTkcLSoUKQ10D4pZhQKlJAmklY7ulylsPDyelEDC?=
 =?us-ascii?Q?z9L50kpiLcEHOWS9Gz8o4Cl0maXH46PkoLHkuL2zQL8sjnwY4SVsJVE4Pq22?=
 =?us-ascii?Q?B05EtUDOQ+LnRgRYAyIFs4eLC7xv8ra6piQAkgF4yiJXGVeYhNGmce83fYih?=
 =?us-ascii?Q?ykDucZ8o+pg4crJtJdpoTBk9vF7fJ4FTiDmQAccazkpv8WEOjUXA2qrkogyG?=
 =?us-ascii?Q?yEsY5ucfbCsCyi5VZHr1KVLpPxHaPmRsmot+Ds7SfRkGOYF7sVcdI/hj97ng?=
 =?us-ascii?Q?cVXDgiippiArlYSeQu1AKp87qA5OBeJLC7EGyt8Hujf0asHUUrCT5duekoaW?=
 =?us-ascii?Q?V6sb4o5NDzyb4DyK4IvS/o+m3ylW2eN47kZ9K8QcCFPZPQcKpVbEZK3ZHUgf?=
 =?us-ascii?Q?wuc5Lt1eIxjLJaQiwN5PuDXBd8ajYMZyblyYEIeH2F88i3xqivb8GdRGSzYo?=
 =?us-ascii?Q?6edmgA2glQW/tx/4Gh3FFXs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e655b976-ad4f-47e6-4059-08d999c072d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 03:10:08.7808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CABcGCjw94969X1Ag49Njw2T/SiZ/rwSjhfcGen7cSwRMWMPsTrzMPtI9am17uGjg2K0GW23nIY6RlSGKX782g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>
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
> Sent: Thursday, October 28, 2021 1:46 AM
> 
> On Wed, Oct 27, 2021 at 03:21:15PM +0000, Parav Pandit wrote:
> > Hi Stefano,
> >
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > Sent: Wednesday, October 27, 2021 8:04 PM
> > >
> > > Hi folks,
> > > I was trying to understand if we have a way to specify which vDPA
> > > bus driver (e.g. vhost-vdpa, virtio-vdpa) a device should use.
> > > IIUC we don't have it, and the first registered driver is used when
> > > a new device is registered.
> > >
> > > I was thinking if it makes sense to extend the management API to
> > > specify which bus driver to use for a device. A use case could be
> > > for example a single host handling VMs and bare-metal containers, so
> > > we would have both virtio-vdpa and vhost-vdpa loaded and we want to
> > > attach some devices to VMs through vhost-vdpa and others to containers
> through virtio-vdpa.
> > >
> > > What do you think?
> > >
> > One option is, user keeps the drivers_autoprobe disabled for the vdpa
> > bus using,
> >
> > $ vdpa/vdpa dev add mgmtdev vdpasim_net name vdpa0 mac
> > 00:11:22:33:44:55 $ echo 0 > /sys/bus/vdpa/drivers_autoprobe
> >
> > And after vdpa device creation, it manually binds to the desired
> > driver such as,
> >
> > $ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind
> > Or
> > $ echo vdpa0 > /sys/bus/vdpa/drivers/vhost_vdpa/bind
> >
> > In an case of VDUSE, it makes more sense to bind to the one of the above
> driver after user space has connected the use space backend to the kernel
> device.
> 
> The only annoying thing is that manual bind is not validated.
> E.g. if one makes a mistake and binds an incorrect device, it just tends to crash
> IIRC.
Only a vdpa device can be bind/unbind to a vdpa bus driver.
Such checks are done by the kernel core.
I didn't follow when can it crash. Can you please share an example when can it crash?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
