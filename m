Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C22AC433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 05:26:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EC164ED3
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 05:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EC164ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 480424BA25;
	Fri, 26 Feb 2021 05:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FJzRpR1T0-dz; Fri, 26 Feb 2021 05:26:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E9454B398;
	Fri, 26 Feb 2021 05:26:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BFE1C000B;
	Fri, 26 Feb 2021 05:26:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54571C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 05:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3ABAD84261
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 05:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rp5lcrJGPsIx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 05:26:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3CDBD8425B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 05:26:52 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6038869b0000>; Thu, 25 Feb 2021 21:26:51 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 05:26:50 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 05:26:49 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 05:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dczZ/ob2THcxDM68TYfaPwdJnvQHjK7XmiDMTsLiAF5bwPDa4bKQ1MMHNGqhWt+XGNpFD3GUPeR3XC6B+SvrNHg60071Xopuk67RdAzrpiodSxGTL/jzQClyCTz67BwDCkh9LuBqDDSe7DJrz6pbt4U0CDN1jjU5o+JXEi2Jt/KGvm4OJVMNjwDA2ahZOvIuhl5l/8PCkE9YLUJWmXp9bv1F2xbwd8fWe3gBIMswkJtrIU0IfHwLqylPXbZDqU6uyOHN6wGjHp9gjTCdQNIeICURK0ufBoK/X7rXiyAk/xQuWcNPberPMDC6zPOqcMH0prfZZ7xMEML6Iqq1aGsKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4MjtB5NlQMgDmEgdSM1tPTx7L+ifjma34wE9d2ARlI=;
 b=KPQkowimTRCaOy/2O6SlrkoQ+4xCssQYg6CX15TUuleVycIwW8q0ma1UXFx87oCE07d+9pucCAtGi9neOxxg//3osmpsmzojnmm+jdcXItFCpLNNjKsyLMDaO09hcXWG9WQV4xCGBhYrI73VGwyWHx8mqzwQt0xYCAXMzaHLoLRpyxp6lijvtIZzEz71B2HzvMadohI/ZIiLf5BzVq9cB0X2cqt9SsjdPSOJ/m4YuIuss5hAXIY/+kELBJWzT36kvab5VZAZMW919JiC27QappmDolEw5GUjk2PZiQfl8bRwEaUXoLJCrKdRC6ykgSh4d9o3j3JJnYroH4jqhjfN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB2774.namprd12.prod.outlook.com (2603:10b6:a03:71::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Fri, 26 Feb
 2021 05:26:46 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%4]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 05:26:46 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next 4/9] vdpa_sim_net: Enable user to set mac
 address and mtu
Thread-Topic: [PATCH linux-next 4/9] vdpa_sim_net: Enable user to set mac
 address and mtu
Thread-Index: AQHXCnT3fDXtAKE0B0GW+5bb2C/8uKpm338AgAMKxlA=
Date: Fri, 26 Feb 2021 05:26:46 +0000
Message-ID: <BY5PR12MB4322F19840EE3952C1ED69F3DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-5-parav@nvidia.com>
 <20210224015220-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210224015220-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.166.131.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c1738cd-312a-447f-b0b5-08d8da171c76
x-ms-traffictypediagnostic: BYAPR12MB2774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2774A6AB9C6E74EF68A49551DC9D9@BYAPR12MB2774.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mx+AVCX3WMzX4e5wotcL6IIHfC87gmMSIS4ACnpiOi1qve5I5po/OqVNPVVHIw14ahWC249o8aWifhMiZ2InYCjZl4GAIUZ8cLrxZZ4FElEuEmZkae1YdeWGeBmxXwi0ejxjiArN3OLChRiMdobCUoM4Qd4iwkifvFEyB+rcbEMKhrooY3/Zn29fV/qO84nLpTbmCGoQqgXObwXolymCk4u3hkqDz7vLzqGxmmhSHmbxqpHEK8poCJY14vPovKpy0Rdw85pWFjMmxk0oB2pNFiLPuBw7chqjRKYds0o2iqq0wRn6VSg/+31yAPDsuUWxVaCWH+DnpmTU+aDFtEaX7JCjZDRCNTewEhAKkVwUvbRQ3mlYnGuvNbCgSej16wULejF6QbIMnmOInONn0ZAEjzIPaJBCPNnPAWMh55DSanTMTh0s6PZfZGN0pC1k8RYFN156HVU42T4jCfMV4p8xclINY+e68QDdxj31F6fT80+GREsPfuxG/DdxqwXcseAyjVak03yRFu3GCjmY5I9SGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(71200400001)(66556008)(86362001)(8936002)(55016002)(478600001)(5660300002)(76116006)(8676002)(66476007)(66446008)(6916009)(107886003)(2906002)(64756008)(66946007)(9686003)(33656002)(52536014)(7696005)(186003)(54906003)(26005)(6506007)(4326008)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lH+NaOFBFIEXolCRIK2N5EU3t7pr2imNJ9i+yRl2c4GLkUwS7DZxj4u4FbhA?=
 =?us-ascii?Q?xBE3JX7vx/UHYnqHtC//O223mXGFh4kisyt41mn3F2XR3+fnLqAj401mH/m3?=
 =?us-ascii?Q?dGPRpOTVNf+lK7CE3zFk+k0exkoBOn6wdhCtcjY4sLCdisxoOelRPQQVXjdc?=
 =?us-ascii?Q?Dgf4H99ON1uNEiGd5WTodNE8y3KrPbuOcF3cEXHG9TwTWns7qRo2InjDkz9u?=
 =?us-ascii?Q?n2kWeUMklRyb+xtDG3d7pUf1IZh1Y8AwJ2ksC8mGtjp55bzieT1sN5H4e12b?=
 =?us-ascii?Q?ivgJxjypRbMStTFUKj98JgwoPSF9KqbXjEWRVyAlB66fzudug/ng7ZdsT2IT?=
 =?us-ascii?Q?XVctJlwQnvLsZZJs5nSptKlqi41ZKGfae8U1mKz2/teHvo/x/mkTzdEKdY4e?=
 =?us-ascii?Q?fe0J7d41L2dm+Ncrc1/LSCAQERy+67HwGJjq9lBQ0CsCibVX22DX0EcY8Sox?=
 =?us-ascii?Q?RY1Z4iD2AbMEJyJ983zXNqs3w1GE2D0nyMwUjipeOucDr0Yv+oYA6Suj/S2z?=
 =?us-ascii?Q?7fR8qBfV0l4pk13o/iQlRLLQQQ6RTPgfyxFd26gaxT6WTcjnfK8Q0UPBl0RJ?=
 =?us-ascii?Q?xQ/VTySrWD5gAavvMzMub2eZekfbH6YlxWqaIRWLn8z467g5a9K7vU1l6Gd9?=
 =?us-ascii?Q?OFzZw0c0JxuncMdfkt1cFZr8EW3hQ+Y6/gPC628XMe37IqhBwRq749PUYjnX?=
 =?us-ascii?Q?AKnw2JSm19l9M4oPgoy4R5npeqeX9dxUwybLK8ZzHMfuCJHf0z6BgCyha408?=
 =?us-ascii?Q?8xa5LwH3UkPdAl4Y5CthgswwZQ2ITW5hnxAgiBeQrqyVZtsD5xSY6a2t9NPS?=
 =?us-ascii?Q?bJ85/grveOuXdr++IfXUEmtqLMHpvHVmrsRagq0X+dCqX1OUn0dI0xeyX1Qr?=
 =?us-ascii?Q?avg0uPH5y7JzPfagCH8El0nz7o5+WgsdD/yzlOyO6DkCk2QDdJAvQ/y67Myc?=
 =?us-ascii?Q?sFSF1jdZ1p0wX3meCSlFfuLrmrRGXVvPqB9lv7nk+GTKnC/ZbO0ejCtCRtCe?=
 =?us-ascii?Q?axsJlXgM62ZNB2WbI+N3dNh3JvuLKUA/2X4//aPzcipNJlKiurdfnlJpt50W?=
 =?us-ascii?Q?cgggE0HcS0ev/I9CupAT9HZcGxPAxSXppJxN4nwlEMwzmB4PBjQhJgxd/FSz?=
 =?us-ascii?Q?krh2Av4F8lLEo4xeNSBvKbec+jibGe/Xsskq7X7BO8ChsB2Y/O814T6amMkh?=
 =?us-ascii?Q?uhntWbgn0RhCPzz6yb4f3TD0EF2LJzjd9mzyYHQCSsfYQQPbldo5nIu9FSZb?=
 =?us-ascii?Q?v26UabqaPiqGgjXitL8G5izIFTXxhYYxVGB8SKEAWYwl0JrL42ugBUMdluOR?=
 =?us-ascii?Q?w4faKCg8J3hPhSw4nUFgJVat?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1738cd-312a-447f-b0b5-08d8da171c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 05:26:46.8851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODqUbL642Zo+FfC7AvEK92tkXnh4GSTHYhWnhZzhsxz5IZnW/f30jOR8+4EE3bduLD5mY84NijSTShp7WbKVXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2774
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614317211; bh=v4MjtB5NlQMgDmEgdSM1tPTx7L+ifjma34wE9d2ARlI=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-header:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=Aowt5cTSb6sDHE1MngfUciM520WjpnbJSE/OQhm5ZoDCjt5A+oYLLKU3/hMBH+Hw8
 erqKvV5nJgmaRVXhSJzvxh61iMDnZD5rm/t4ZScqytC0PEh8SpS86EKJajdFcPu7Jb
 RO4/AeGvLN6YNlrGTjmfSq9yhYyzJdzu0UUcCLhM+tW3rLmO48Nduetq6RidckbkqC
 KEtcz8XystJkgkhMK9QkHNsv/cYRclas5bWmWDPUy0zlGEPhc/enJnJLdD/FviS0qq
 MlK3aaLky9xNQZ3xYlS/4m7foz2Z6VI8sgHP132TnlhmlvgLdZEf/8Ce4QmuR2GkCl
 osnqLOYNk7sUg==
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 24, 2021 12:27 PM
> 
> On Wed, Feb 24, 2021 at 08:18:39AM +0200, Parav Pandit wrote:
> > Enable user to set the mac address and mtu so that each vdpa device
> > can have its own user specified mac address and mtu.
> > This is done by implementing the management device's configuration
> > layout fields setting callback routine.
> >
> > Now that user is enabled to set the mac address, remove the module
> > parameter for same.
> 
> Will likely break some testing setups ...
> Not too hard to keep it around, is it?
>
Mostly not. In previous series, we moved away from default device to user created device without an additional module param.
So this shouldn't break it.
It gets confusing which one to use and module param applies same mac to all the vdpa devices.
So lets shift to user provided mac.

> >
> > And example of setting mac addr and mtu:
> > $ vdpa mgmtdev show
> >
> > $ vdpa dev add name bar mgmtdev vdpasim_net $ vdpa dev config set bar
> > mac 00:11:22:33:44:55 mtu 9000
> >
> > View the config after setting:
> > $ vdpa dev config show
> > bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000 speed
> > 0 duplex 0
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 39
> > ++++++++++++++++------------
> >  1 file changed, 22 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index 240a5f1306b5..6e941b0e7935 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -29,12 +29,6 @@
> >
> >  #define VDPASIM_NET_VQ_NUM	2
> >
> > -static char *macaddr;
> > -module_param(macaddr, charp, 0);
> > -MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
> > -
> > -static u8 macaddr_buf[ETH_ALEN];
> > -
> >  static void vdpasim_net_work(struct work_struct *work)  {
> >  	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> > @@ -113,9 +107,7 @@ static void vdpasim_net_get_config(struct vdpasim
> *vdpasim, void *config)
> >  	struct virtio_net_config *net_config =
> >  		(struct virtio_net_config *)config;
> >
> > -	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
> >  	net_config->status = cpu_to_vdpasim16(vdpasim,
> VIRTIO_NET_S_LINK_UP);
> > -	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
> >  }
> >
> >  static void vdpasim_net_mgmtdev_release(struct device *dev) @@ -134,6
> > +126,7 @@ static struct device vdpasim_net_mgmtdev_dummy = {
> >
> >  static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char
> > *name)  {
> > +	struct virtio_net_config *cfg;
> >  	struct vdpasim_dev_attr dev_attr = {};
> >  	struct vdpasim *simdev;
> >  	int ret;
> > @@ -152,6 +145,10 @@ static int vdpasim_net_dev_add(struct
> vdpa_mgmt_dev *mdev, const char *name)
> >  	if (IS_ERR(simdev))
> >  		return PTR_ERR(simdev);
> >
> > +	cfg = simdev->config;
> > +	eth_random_addr(cfg->mac);
> > +	cfg->mtu = cpu_to_vdpasim16(simdev, 1500);
> > +
> >  	ret = _vdpa_register_device(&simdev->vdpa);
> >  	if (ret)
> >  		goto reg_err;
> 
> Hmm moving it here is problematic:
> this part happens before set_features so I suspect endian-ness will be wrong
> for BE hosts ...
>
Hmm. I see it. Looking for solution to it now.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
