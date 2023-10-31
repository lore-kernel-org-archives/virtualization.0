Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A1AC4332F
	for <virtualization@archiver.kernel.org>; Tue, 31 Oct 2023 03:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C451241E50;
	Tue, 31 Oct 2023 03:12:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C451241E50
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AxIhd/aS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CUg8ZKOLTJ-B; Tue, 31 Oct 2023 03:12:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A0C6341E3F;
	Tue, 31 Oct 2023 03:12:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0C6341E3F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7218FC0071;
	Tue, 31 Oct 2023 03:12:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F3A9C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 03:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6A8241E4E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 03:12:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6A8241E4E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXTHBBJ2yuJ7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 03:12:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A4C541E3F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 03:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A4C541E3F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBMdRoRAC2FEJqp/Se0uwP8Gu6mTbz0srgPQMqV9EMmaZ0abco7bHuDcwshzDYvZp//ssNCp/shVh6WXR7VP5L0LWUmx/qc7ZQFJ4WEMJm/0T3c4eM3ZKCrAJkpgMSv9j8IJesmXmAKHodhZiAuQ+cCdZ1U+IP5FFieEuHZg4uBlyyRF3Wcf/9L+vn7KBHDYRs9xJoXJTVIBLN3DeMelNCq3E65chApJ5IkR4xaLrDE8frlL5sPMBbG8c4c9nTZnXHmfjvTOHHDALztjZ/SK7KiwYbyZxVsn8EXcf+ELbaHZJSN/QzdakjjKolyDvawISI59w3/C80JCHcxNHlRRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mQLjYdY4zRDOXUBkQ8+5m8ZXvie6800k1m66TbzuJU=;
 b=dwrH4Ln4iCmMEnU5UTxH0qIqNbAJscRrvRiNZcD80o9lDoQ18yj9tVaJjCgopF0Lie3mKVvc5q2IBbbzRNXpuUgllZT9JCOi2iYRRolMmMvcf3nOMErxAYNRaQpPlzsNdkK7RbNv4gl9DrkKXAQGfluGe3SdpqRdDSM2Qn9ROjZ5gNCG/F2IPJQ/TQ04+fICrtIdSUkwZI5WFEBIpyFPzL4GzBgFR5DLVgW12T6ukgu9YBPFw7ovFrwkJB+kKeU3rj5Mam123IW9jVegzb7VY60ku2EMlOR5+y0CIQ+okr8kyKC5f3SM4r+JGulVFB1o9Ui22BX1vmh8ryUcizx7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mQLjYdY4zRDOXUBkQ8+5m8ZXvie6800k1m66TbzuJU=;
 b=AxIhd/aSIPDrAl9o1XPiwF0SFcJerMbijWzdYDeO9+CcjDcwU//3gYPYtD1bAodEqdfxHG+xvfS9ico+di9vzp8PlgMoUzYN0j1X1NOiA+K4qIUpwBJKcpIQCs8/hm34dEaebWaxTH25NweKE8A43YKCb3xg2ZCfrCu7o8Od3qysKfPIzzBjzZ5xKAqLjGldgXF6Fth4vu8TN/N2hlDax1lkqhz20bQTEWMbfnwC1WrlD5Cd+nMZaOhxBCUlYsgzys/xGlJkY6dQcTlr5ST1qRwHzB2/00EO7EkwPqBEStTYv9Gyq5eBLh7X5/61dSfdph8eX+UyxorUkzOYqmK8lA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 03:11:57 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdcb:e909:74a4:be7c]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdcb:e909:74a4:be7c%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 03:11:57 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH V2 vfio 2/9] virtio-pci: Introduce admin virtqueue
Thread-Topic: [PATCH V2 vfio 2/9] virtio-pci: Introduce admin virtqueue
Thread-Index: AQHaCoENkpIXTr9HoESn9KiFa24lo7BhNkgAgAFFedCAAANWgIAAI7/QgABanACAADw/IA==
Date: Tue, 31 Oct 2023 03:11:57 +0000
Message-ID: <PH0PR12MB5481F2851BF40C5BBD59909CDCA0A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-3-yishaih@nvidia.com>
 <20231029161909-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E45C628DE3A5829D438DCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231030115759-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548197CD7A10D5A89B7213CDDCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231030193110-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231030193110-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB9061:EE_
x-ms-office365-filtering-correlation-id: 3c1af32a-e7ff-4871-c58c-08dbd9bf2462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8JV48FkdstWUHDrWt3wtK4w5u6HyzYIPdyzMA3XlzG82+AT9TlAyrk35ra5XHNqudvuhaL0tyKZ+Tmy+UV/exbYQ3f+85TH6MvRkZAA9TLZFoIi/sbVDvSyXhwD/wLt6R3KsA2Tt33+kEexJoizY0ySiXUGpdhgUUne+dAOcOzw+b+7kB46KQ4QYd0ZnWLzajoqAxRCD5RIgw6hJrPAn+zo75MwBcjxPoEkQ3u1/Plqhu22qHAq1mMMMnm2IhuUteaR7OWyVCUow+OwdFRtiCvXoFa5HWrDN+zXVY6L49T1n+jT+UafzFlbqXmjpHH4gbe59149ZtWUQ7ZNiYkVky2TStLPQt8UQ0wfFaSYk1zxuPLp67QckX/lc0yy5HT8HSHw9etmSkL5NTM9LT0qgABBXqa+zkY3MS59BKwgHN11j9ds8puI8QIu7JZ2tFf+y804+ds5+v+RwpgcVaOMaxVfZEf2w3fitnms9eSzsu5pJ3ReE2g6XFjPeB+Gel6JS1jDwZe9d09Tkh+8MVQasVhsA2Ku/LlojgYzB3+CNYAmVxnMbrbYNHB59oRVmFwyP+MxAlKYC7uRoV62u0sl2SMIdTwzVeZD5EaX94iOEYctF3m+Eqe6AQblkWbwztFW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(478600001)(86362001)(76116006)(6916009)(316002)(66476007)(66446008)(38100700002)(64756008)(66946007)(54906003)(66556008)(7696005)(38070700009)(33656002)(107886003)(71200400001)(2906002)(122000001)(52536014)(4326008)(8676002)(8936002)(83380400001)(5660300002)(9686003)(6506007)(55016003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fkiXX2Gwtn8T4eij56QNunCmE23lIn3jub5zVB+zpi/Ey8bI+RJCWvJrvyPm?=
 =?us-ascii?Q?BrDnPzJlf8aRNLCzQZqfEvKjsPYju0xoVUpTFehmo//kQ4JduD62jgLfrhbS?=
 =?us-ascii?Q?03GZliTxZWZ0gwblU4t725JFOvhTz/UrmFi8yug4OPYa/QWWxk69MHLCn0c7?=
 =?us-ascii?Q?V6I0TGkwHysDwjv+ps0Ldmvk6TRG8yaNTw5E8FUY5mazhinRm57uGDUYFMiJ?=
 =?us-ascii?Q?av/PK3gaIW0QrvE+OG4pO6U5DrLjRm8kRNYgu7DcD4liaHvKg2QJU2JPhSZi?=
 =?us-ascii?Q?FFlHVjjOohE1a3VfKQ0CfoYlYg6nZomr3iAPdvDk7hT8X7Dg6BHdc8+ZgCvW?=
 =?us-ascii?Q?B8aXSObGYx8STyu8n+RGsA/UTg0NWn1hocbYkvIuL/mzu+uHo+qhsi7uyHQu?=
 =?us-ascii?Q?/fydFYvJX/1+X68kDOdRlKX8Mlqr3HNJ5kSjfuCRfNJiZ5gjC1UbBjGObnDT?=
 =?us-ascii?Q?C+CgpjYKbN6ZaZ+V9iY545U94vxbMgBnKshOv4zMGUacSX4JX8vawkWInbvW?=
 =?us-ascii?Q?o69dvHanGBG8EWzXePXN1jhLa7khkZuVORxo1PIPDN0QfT4YAuRjhGxebNFl?=
 =?us-ascii?Q?Z8uXvoCNf0gOEQfVG694X3jf5gikKhYsB3gea+mRuwqikbJF7Qx9BqzjY7aZ?=
 =?us-ascii?Q?SQKfIaEr4wBwGHVQKEjCjeJmyvvETPLCnOrvmsGeqFPep/PgBFaVVHamJrTR?=
 =?us-ascii?Q?v2yRkzOiyI9jD9Gw/6XvgB4qcr6lX7j84uT2z7ehn7wVq++/6kPWINoLlsVT?=
 =?us-ascii?Q?p09LwG/U/MMwjHFr5O9qW1yDPmv7lnGBOOluudexkrXDjEIVaPXTjhu3nXuC?=
 =?us-ascii?Q?voeFkO+eqDNw4V18FvkyTHW4A3lhNYpyEILDyKH2aOi36ndIMsAeOZtINMNe?=
 =?us-ascii?Q?hYQsOHCPMqnZOAeNJd1KZ8k0srTBvfj0VcRMa3egaNjrLvw6xXxdltr4G8I7?=
 =?us-ascii?Q?P6eIDUJjRs+PGZzTq+OP2v0F/cWfLz7YR3tt3QuTGoEHxuPgc1Mvc1i3vyeM?=
 =?us-ascii?Q?Bxp6Nh2llYKaqIAsvu00dDG7TVBnPDf5+z3Gv9mY090niXh8rNwHmjIdSEwQ?=
 =?us-ascii?Q?UZMdzYKdodGQtP4IbeHjm6KHIpq3mZg0oamOhcgxSvyQISvBTEcd7KUcE5hh?=
 =?us-ascii?Q?Yb76MagEwnPS98lH1sQ0JPaG0QODlQbRPPUXGiEcQEnVIDr+9E4ie/dJAkWr?=
 =?us-ascii?Q?W+kvKudAR4i6QoE+4DxUeUKoN4d6SW6eNSPd+Xv8MXWg3mnpuh3x+bzVGO0a?=
 =?us-ascii?Q?rK9Ns5N6O8FF75yBSnQyDce7Czv3PtVqliK2B6lnR37kkWAFp4WNwA1nvkAY?=
 =?us-ascii?Q?I3khjGq1UUKSMn/0Ymm7sF8HbT3BcQoRHalZfozR6F18tYdiaDjwTXOXUM9o?=
 =?us-ascii?Q?ZRMgEQFVoTe15amQxkzCRyf5CieiLsP9/Y9Yxtn4P6K7lvCNxZgq90+O6s7A?=
 =?us-ascii?Q?yfLHSNxjrU2PVzo/ofsxsRr6orqzZ2tt1aTwQmYGYVV3tX+VPUs2gK1dBuxf?=
 =?us-ascii?Q?7lW2Ob9whAlJxMcX3UKd/8Z/oorGj0oAkAWViJHzmtI1f7A48ErDgkScjDke?=
 =?us-ascii?Q?ouhZBpKX2BOyprL00Yk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1af32a-e7ff-4871-c58c-08dbd9bf2462
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 03:11:57.5345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlmDbgqcGCGuIgsHyr04Z+HXMEJFYmtMJf/Xoy5JfVzVnJeOgRY2ChJqJ4ZtaQqJXrhQoyDJP8mv3g8uXyEbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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
> Sent: Tuesday, October 31, 2023 5:02 AM
> 
> On Mon, Oct 30, 2023 at 06:10:06PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, October 30, 2023 9:29 PM On Mon, Oct 30, 2023 at
> > > 03:51:40PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Monday, October 30, 2023 1:53 AM
> > > > >
> > > > > On Sun, Oct 29, 2023 at 05:59:45PM +0200, Yishai Hadas wrote:
> > > > > > From: Feng Liu <feliu@nvidia.com>
> > > > > >
> > > > > > Introduce support for the admin virtqueue. By negotiating
> > > > > > VIRTIO_F_ADMIN_VQ feature, driver detects capability and
> > > > > > creates one administration virtqueue. Administration virtqueue
> > > > > > implementation in virtio pci generic layer, enables multiple
> > > > > > types of upper layer drivers such as vfio, net, blk to utilize it.
> > > > > >
> > > > > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > > > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio.c                | 37 ++++++++++++++--
> > > > > >  drivers/virtio/virtio_pci_common.c     |  3 ++
> > > > > >  drivers/virtio/virtio_pci_common.h     | 15 ++++++-
> > > > > >  drivers/virtio/virtio_pci_modern.c     | 61
> +++++++++++++++++++++++++-
> > > > > >  drivers/virtio/virtio_pci_modern_dev.c | 18 ++++++++
> > > > > >  include/linux/virtio_config.h          |  4 ++
> > > > > >  include/linux/virtio_pci_modern.h      |  5 +++
> > > > > >  7 files changed, 137 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > > > index
> > > > > > 3893dc29eb26..f4080692b351 100644
> > > > > > --- a/drivers/virtio/virtio.c
> > > > > > +++ b/drivers/virtio/virtio.c
> > > > > > @@ -302,9 +302,15 @@ static int virtio_dev_probe(struct device *_d)
> > > > > >  	if (err)
> > > > > >  		goto err;
> > > > > >
> > > > > > +	if (dev->config->create_avq) {
> > > > > > +		err = dev->config->create_avq(dev);
> > > > > > +		if (err)
> > > > > > +			goto err;
> > > > > > +	}
> > > > > > +
> > > > > >  	err = drv->probe(dev);
> > > > > >  	if (err)
> > > > > > -		goto err;
> > > > > > +		goto err_probe;
> > > > > >
> > > > > >  	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
> > > > > >  	if (!(dev->config->get_status(dev) &
> > > > > > VIRTIO_CONFIG_S_DRIVER_OK))
> > > > >
> > > > > Hmm I am not all that happy that we are just creating avq
> unconditionally.
> > > > > Can't we do it on demand to avoid wasting resources if no one uses it?
> > > > >
> > > > Virtio queues must be enabled before driver_ok as we discussed in
> > > F_DYNAMIC bit exercise.
> > > > So creating AQ when first legacy command is invoked, would be too late.
> > >
> > > Well we didn't release the spec with AQ so I am pretty sure there
> > > are no devices using the feature. Do we want to already make an
> > > exception for AQ and allow creating AQs after DRIVER_OK even without
> F_DYNAMIC?
> > >
> > No. it would abuse the init time config registers for the dynamic things like
> this.
> > For flow filters and others there is need for dynamic q creation with multiple
> physical address anyway.
> 
> That seems like a completely unrelated issue.
> 
It isn't.
Driver requirements are:
1. Driver needs to dynamically create vqs
2. Sometimes this VQ needs to have multiple physical addresses
3. Driver needs to create them after driver is fully running, past the bootstrap stage using tiny config registers

Device requirements are:
1. Not to keep growing 64K VQs *(8+8+8) bytes of address registers + enable bit
2. Ability to return appropriate error code when fail to create queue
3. Above #2

Users of this new infrastructure are eth tx,rx queues, flow filter queues, aq, blk rq per cpu.
AQs are just one of those.
When a generic infrastructure for this will be built in the spec as we started that, all above use cases will be handled.

> > So creating virtqueues dynamically using a generic scheme is desired with
> new feature bit.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
