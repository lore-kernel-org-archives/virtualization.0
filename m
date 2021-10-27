Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA47C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 15:56:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF4861039
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 15:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEF4861039
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE9754027F;
	Wed, 27 Oct 2021 15:56:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hCOcCGvMeX5P; Wed, 27 Oct 2021 15:56:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F06384010B;
	Wed, 27 Oct 2021 15:56:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D586AC0012;
	Wed, 27 Oct 2021 15:56:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F09F1C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D133040257
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:56:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8wwQ9fARuKUZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:56:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 706FC4010B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 15:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CS4syxwyAZ6laUloHggKSVxpwB0NAtyblyVbx0nm3FY8Ey2shv+tzTmHl/rQXm5gf4fDvuJjsTPPBGuKzFAxx07u/Pxh/hcahgcjDQnxENqlYn+AYKOw4B+8tyUdbxL8rAfn96VR79lPiPaBNnH0iP22xJlVSWZm79ULZHM5Q0YPVG1oh29/G0xXV9sQ++Q4ZVHYiIHWye7PGpWa8gXKSHTazPDybw5zCy8DoieE8B4pZhFdixyK+HhruuXg5grFGz4nys75iGy5dAy7hrYbPzztAnZem2xt8vPcGonukRhPj3+T7qPZPJjDCtVNlItxjjLMzobyS9Xv0DBwOT2NyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+cGWtQnLXgsEMxRebbery8KLUHRm6aIW45dRb8mJSg=;
 b=krkAQ4ibYoMSOvPuCFlh6GA0+Edxw56J0GGbQG+5JHxAfCMfUzmYk0x85CPm/VCzKnRG0koycEJ6vjsIcZ0wrVmlxmOgFvdgHgHRhOG1GbhAadtUvpk4yfGUyGa/rQPCIE/tyfc9FMHQLPZmlZVR3r3A66mf/rs7Wn218o9qci9Q2jTz2SEfZTplkr4IVgmKOm3iAHHokhqd3YhSflgR4qqxCTVx6713jcUBC/mI3WxG75S9l++NgYEpLWAwQybZHptQ+x20XK7ywZdnj2/HzcqpF9z9KAj1c6fE9IMlWEbGfXi4V7kEdeSU5NBSYi/PL6aWP+L6U1DiU7ECaarHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+cGWtQnLXgsEMxRebbery8KLUHRm6aIW45dRb8mJSg=;
 b=CSPMoABGB7qclkFLXDPaRbWdgqndEQh4QJfJVjDTuUdtGJoi4qTf7LHJRiCnBbpZkbfTdfyl4t07FRuY8sJCY/m6rg+JjhR0vsa/PiHT/Spdc7s7S2QIm8aiZi4HHInNiZESDlLs1sQ/3XvPlqPTIHTQxJDNTPK9yhP1z0qKCGe0gcLazBc27BkH46nvwcA+qm7g8/b9z13B2wY5gkp/8leYXLP4CGm4U4W3Zyrf1uk7EMJGMz3fdiaz0qBGXzimj8jb9eKtV33hzktWX43Ocf3d8/6CYYaa7qa+IGrMLI26Wyy4u4yaChTkIMJap3pTYiRhkRxAtIoZTGmb3TaB9g==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 15:56:16 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 15:56:16 +0000
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: RE: vDPA bus driver selection
Thread-Topic: vDPA bus driver selection
Thread-Index: AQHXyz+5W8bHEdMi9Ue0cOjhXwdA36vm745AgAAN1gCAAAHeEA==
Date: Wed, 27 Oct 2021 15:56:16 +0000
Message-ID: <PH0PR12MB548104D8BE92D2C5DC49A7A4DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
 <PH0PR12MB548115FD6354339B41A11CE3DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027154728.qkrtl6jtfoqlbwfu@steredhat>
In-Reply-To: <20211027154728.qkrtl6jtfoqlbwfu@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71d7d97-bd30-4352-50ec-08d999624f14
x-ms-traffictypediagnostic: PH0PR12MB5434:
x-microsoft-antispam-prvs: <PH0PR12MB5434C51EE5282A90DC0F71D0DC859@PH0PR12MB5434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8o+1pyR+ZZN5QMfyLdGD9ZsA+StOvaicK+2/TeizJCXYMOvhOpHA2KuF/KbqXWDln/Z5BjoEVjMn0irTvKEZd2nliUU7kr07956KkdImOtLnwKgWZY3hI0Xh8mZhlxQ6YlWNTm9P7nwvE2ezK4+5/L/fvIsfKI99Hv2O+CWd115KuqcRakDgQiUNYpU7GgCLotm2sq24lzvGnDAtnUnRFci1xMdrO16h40eF6koVzpodWucXwJVDQsdDI8lZ2/m0Dt1F1tvBihsxLyAYdq3aMvro62BwXS65sMJyYsLPC36rSbdEVWJ10JcRsijNVR6mGoYv84kaKKINn/OHN7COrn1TtgCGJ3TcTGEa5Pbgo7AcEDWKEI8SrMeIhmNB0OupQfkd3j7ohO8jux/Kvof9RSM0HRpUB75glj9em1rlMyKnI+7sD6C91wznaantiqIz2BoCgsfSi+bJTst6jzoFbeUR4b5SRH2xdIZ8rNIhZKJ4YTiasxgBFgKh2wL5PTjJ3U7TeyTbBHNe7VoigW5cKKeOWIumMq0CZwV5BZ40RZKVFg8hsJkmvmC52glGW+bv7/QilrUi/8glIparm0BZvZvXOx6h7DwuRztmDP3MGEOtT4d8Uv5HDD1E9b/wxQVmMjf2khHgnznlcsHpulquMg0zqwvP7pysVnC+xHqacAGbr2SBp9WVTTqkfrNIXcgvt+dPMIfCHiHJhSPFvugbsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(3480700007)(2906002)(66446008)(8676002)(33656002)(54906003)(66476007)(76116006)(9686003)(122000001)(8936002)(86362001)(38070700005)(64756008)(55016002)(83380400001)(316002)(186003)(5660300002)(71200400001)(6506007)(26005)(107886003)(52536014)(508600001)(4326008)(7696005)(53546011)(6916009)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CE4v2K4pGDFbJs19Vk5gD2VKAzo9KhsB9l0EiKAB9D9T+kzGva0vyWN+0jNz?=
 =?us-ascii?Q?ikiM4GAdwNgbXx9mjs03DUrN11qrioyYmFy8+D3NiNwcEKlztZwr/KCVW4ie?=
 =?us-ascii?Q?WbAfrW9c6A478SBq324fMqPCsekGteXIPS/4k/HCAM5sj9Ugg3qpR8G7PeMJ?=
 =?us-ascii?Q?wErGu6AEymLewn8JCJLtDv4f2hHIlLksO2fJrcuwAPdKOuj0jj0IqiH1qgr1?=
 =?us-ascii?Q?TZmMWryleGByK3Or7KiA+8Bn3LJGvGPetu+2w9WnzR3S1Pg/olF0tDxxFMr8?=
 =?us-ascii?Q?aLbcgpDTf3pBufzZCUqEB9vJxLPLeZUgBMvC1uEQStJOl3eLmrarRIbt/pWC?=
 =?us-ascii?Q?l7L2ND4/TReub/dLGim9Kz2HX5vSRBzhR4BWWBxAlyI973OaIjDtc3u/0tMJ?=
 =?us-ascii?Q?2oQifDFUY8U+QxzuIv11cmcw+lWx2FPW4RqcRoxKhdANhwycxloSL9nv+taV?=
 =?us-ascii?Q?36rq/xsHz1g2wmjzk6XZw6ETaqPK6mcE69mhnqlUvNiisU4V6o70kyrfQDnt?=
 =?us-ascii?Q?LbQYiX5cqIxY8EIGs3mOSxOPPbLN1WXw0+Es28RblCD2CR2gUsDF1knp/FHo?=
 =?us-ascii?Q?CUgoCDlUb3TN0gae/I5lGSx7TneEC12wxv871PKK9ak1BNhWyNcPCq3diwAs?=
 =?us-ascii?Q?nl1RJVa3r5uxqicjrv/ck9dQwGdIGkiFDYNrz7QVMS5Uag55ZjXP5+LFtyf/?=
 =?us-ascii?Q?oDanXh8y+jSj29ZRKal9MkivxKFiMqsw7O1CSjPvOJw3M8ngqJ/2lL6OyY1N?=
 =?us-ascii?Q?iY8qsJ9z3whD4AGiux0AedHFaf8b3i4zmpCP3gQ9ArwigMYpLz7ypIpVUMY0?=
 =?us-ascii?Q?CusG4717OjiMABY+0IYMqDb6L1bMSbqTD4UxWPV4rZIRf3AkeiGHsdSqHnr1?=
 =?us-ascii?Q?HTjTmCthU7s2YwoWH5f4TgFwtXscnlG5gadAKQzlSVSTtXl+PXW2UNq/3FdA?=
 =?us-ascii?Q?5lqdD3XrZx0c0rZg9hgjG3PfevqPSlJq+9A2lt5EyN8t/R/KZB3moZOZ0QV0?=
 =?us-ascii?Q?v4yfp+mAvPPlxd3N+3NT2gNvgZTWDwAmFC5FZkG6diGhoc+pBE9SIoh/F0Br?=
 =?us-ascii?Q?Fhq/S45vWPnwQKm22x6LskAVJqAZpjOmMUhvNZmqfPBOxtcYhrh/U7IoZSIh?=
 =?us-ascii?Q?esDx27/zUIpih0qWsetbN7OrbnmGdPsqelmuwHvxlekn+4s75GX5mWhJxmdS?=
 =?us-ascii?Q?V/hJXslvBNeZ2QOpPyGkqnq7LCzJaaneSHz4J07gjYyGcbdR8hQqoSIiGYWF?=
 =?us-ascii?Q?YvJYMnQtD3cSFcyZFxkM3QYxGlNZS9qznHJ/pD+w0uAzJ9HQn6OM8ax6nyeD?=
 =?us-ascii?Q?t77iJyNlWEDQ1REcWjl29xHBeOLdmpz20FqeFwWQuT40FGn2DxSH/qY4TZxE?=
 =?us-ascii?Q?xUJP3nz1JuAeucJ/qlI6mce+YW4fO63+feHgnnDlbrVJYXgwJ20QHmwEkeFf?=
 =?us-ascii?Q?Dw2/41eA7gUqRusp2KbnVu6vpE1TjPAZJiAP5i/pAInu0a5WKdcCOS8tKw4u?=
 =?us-ascii?Q?bnyAMGbcTLwkb/VW09eh0CEvQEhPk/wDpAikt+XWz72CcCesH31fLXoY4JwT?=
 =?us-ascii?Q?wPX7V0JvimpIEMfCpOaFSIN/N5peXGcTzKtbHq+OBqYVPEnxQcfVKBR8vSzo?=
 =?us-ascii?Q?m2ozqE30MQNn8KFr/9f7xQ4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71d7d97-bd30-4352-50ec-08d999624f14
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 15:56:16.1246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uFlWFjnSQPrbPxA48Ue5sgpsvtZd8djOfYzdff2XB+vvICfYBhsD3x1NFfAraH6AWVXL3tyCewDz6rbBnON/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <elic@nvidia.com>, Michael Tsirkin <mst@redhat.com>
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

Hi Stefano,

> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Wednesday, October 27, 2021 9:17 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: Jason Wang <jasowang@redhat.com>; Michael Tsirkin <mst@redhat.com>;
> Linux Virtualization <virtualization@lists.linux-foundation.org>; Eli Cohen
> <elic@nvidia.com>
> Subject: Re: vDPA bus driver selection
> 
> Hi Parav,
> 
> On Wed, Oct 27, 2021 at 03:21:15PM +0000, Parav Pandit wrote:
> >Hi Stefano,
> >
> >> From: Stefano Garzarella <sgarzare@redhat.com>
> >> Sent: Wednesday, October 27, 2021 8:04 PM
> >>
> >> Hi folks,
> >> I was trying to understand if we have a way to specify which vDPA bus
> >> driver (e.g. vhost-vdpa, virtio-vdpa) a device should use.
> >> IIUC we don't have it, and the first registered driver is used when a
> >> new device is registered.
> >>
> >> I was thinking if it makes sense to extend the management API to
> >> specify which bus driver to use for a device. A use case could be for
> >> example a single host handling VMs and bare-metal containers, so we
> >> would have both virtio-vdpa and vhost-vdpa loaded and we want to
> >> attach some devices to VMs through vhost-vdpa and others to containers
> through virtio-vdpa.
> >>
> >> What do you think?
> >>
> >One option is, user keeps the drivers_autoprobe disabled for the vdpa
> >bus using,
> >
> >$ vdpa/vdpa dev add mgmtdev vdpasim_net name vdpa0 mac
> >00:11:22:33:44:55 $ echo 0 > /sys/bus/vdpa/drivers_autoprobe
> >
> >And after vdpa device creation, it manually binds to the desired driver
> >such as,
> >
> >$ echo vdpa0 > /sys/bus/vdpa/drivers/virtio_vdpa/bind
> >Or
> >$ echo vdpa0 > /sys/bus/vdpa/drivers/vhost_vdpa/bind
> 
> Cool, I didn't know that. This is very useful, but do you think it might be better
> to integrate it with the netlink API and specify at creation which bus driver to
> use?
I think it is useful; for vduse case we need the ability to say "none" as well and when nothing specified it should be default driver.

More than netlink, I think we need the ability in the core kernel to make this choice.
I haven't explored what is already available to make that happen.
If/once its available, I am sure it has more users than just vdpa.

> 
> >
> >In an case of VDUSE, it makes more sense to bind to the one of the
> >above driver after user space has connected the use space backend to
> >the kernel device.
> 
> Yep, make sense.
> 
> Thanks,
> Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
