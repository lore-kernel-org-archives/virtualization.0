Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEACC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 22:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9C32D4041C;
	Tue,  9 Aug 2022 22:49:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C32D4041C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IMPiChNX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IioQm8kOVbo7; Tue,  9 Aug 2022 22:49:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90F60400B9;
	Tue,  9 Aug 2022 22:49:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90F60400B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F818C0033;
	Tue,  9 Aug 2022 22:49:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D9D9C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23FE9400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:49:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23FE9400E4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4MEl5wP41Ywe
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:49:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE0E2400B9
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE0E2400B9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB6ewb0QWOS7pz1i+tM82NF71Po+3N90Fwu/nuPzF5CPWMLrVUrWieHsjVykHFq2mpWppQ0D8Fmyozk5rEOeook89feDsdY51OIIuiCkFFfkGx/nYwJL9CExkUOA7HBSCF+f3tRiVhrpuoaFCEnrc5nMxhIRalbKnEOBbx0FNLsZfmVME3hDExj9JqViMQuT5j78P2W3s1ovRrgLEIhLJaEKo5TXqQdMYdaSyCZd/CYa9oDkyW7oQP/ESZjEj2CrQMxKeQTmhdCSdXtf679lJ+mGd3/uN0qTrYW2vxhXU63fe2dmh6P2i6FvbC7VdYCw7btsEMB4akHc7t19VeFCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNzy0TBZsMr1Zl1s+5li+KdXgyCm1jFU7YvceJDLugI=;
 b=Z1sE3C3YmFvDyK8Ba/DnTOFtu2cSVQy7FtC2T/nGP1rG2V5kiAzz1R5qGLjNZkFqi+IzIktp2exS6ezFW5kEGM2WTwzy7x/GFrZP0O4LT6/qsMc3IVCncLH0nAN8d8t2I2HrAhkjfLDPbYUoAj1ipVh2MAxPfhhBEmaQ3MDAkclcbQh7O7XR95cuphHh/D8L5UitOM/XV8hihLjUjk73l97aOTuP5lzfUa9b0KMLSYLvMH8t1TTnuKC/nj+QiO7jC9bShg7rdiob1JT6vmCzfiyhNLpu/0YkLatwbMESCvo7ZbotSKhIMnYHPY07bPmJfxE86aaqBQTYl6ICvnsqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNzy0TBZsMr1Zl1s+5li+KdXgyCm1jFU7YvceJDLugI=;
 b=IMPiChNX5LIjstZEFdTmktR35NkxDb//jb9AWHY8Ft/RoTjq4vQ/f5dycTOHgSyQcsC5EVdaLNGgB5mfUjc1VNbTAL99Acd5F4hyb0wTLVFoXCkMAqCLhMLDcFX8tKjxmOOH+jHw2gZn3CSntucN+DqtJFSQh2XRyFElXCl0ynKrbTl+mIdiqanuGzSHQ5QHA16zZYbOonh5ahRI6yl9mUi0+yc6nDfyd37BqyqzeNMKCcARkTpxmqXQ3LCBpys7vazMUpYt6Z7vHnDM3kT3NDI2M769dvIl01QmXSejtsbKNANZQ+c3w9o2GRW/4nMhyAauimxS49lvfFf2PqqsMA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN6PR12MB1412.namprd12.prod.outlook.com (2603:10b6:404:1b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 22:49:48 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 22:49:48 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Topic: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Index: AQHYpirEKDhT8iEHv0Wl5fiZieJEBK2g5FqAgAPA+oCAARNOAIAAeEKAgAAKdACAALbdAIAAAJwQgAAHyoCAAACEUIAAKRiAgAAAt5CAAAyxAIAAA53w
Date: Tue, 9 Aug 2022 22:49:48 +0000
Message-ID: <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220809182306-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f824d58-ff75-4f00-58d2-08da7a59766e
x-ms-traffictypediagnostic: BN6PR12MB1412:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYLi3jA5xT8YsHvwTCm2Wl+2NEun4ymoCxVngdUl6ZxBktvri645JqtBohsP+8wcB+BYOYYLv9oDlCInmKzHf2SNekD2ECdevllUryvJS4f8twy/kbsL5l15Rgl6Xs8GjdjSQ92WeoZNI/3t8WLZ1i21STf5/3Tt9dELNH4t21zIIxhgA0uds+Bobk8QQvkPpmTgQN+q1VhZnIdUHLdMz5PzWR7StenTaN8KNBIczOlrfzQ1qexNqcBIXAgkEklnP7YwvX5nHh4gZyTfE+f6rjBnelPzyCGVxS6h5IJmX3M+aoy34ZjBtIv00kKzNatuDrmzUInlct7zhBV/uLunowSAWrLzbSZK6tnlZNVA/BLBqUZRgEq9YJFQ30g5TRzoI7m9XyppIjX+41C70EwC5UHSTK1LMs6jlDR2JN0+u0DOznQSvKIGxDjLhEzeRsL8zcLZ+6DrduMHraQ3ex3IZ28C7z9KHDd9QsiRYQXKqkIgLsp/0t58/KnXxWsjIxfqZ0oYWNWeoitgBj3qmA3dlxE2ZRsNMkkl8nZx17zx/qKWTHagxvmdnK7HA2KN+QxrS5ZEqkpRJ8U0lnNIWm2YVOXHRFzczWW+4eisHksyc6YR5/iAYf6HW4ZY+QDwT+NKkZITkKBRmYzoRjhI4P6IWRBWp8SBmT8NqEz7iSALan2BrkTn3aVz7oqbzq5pdWTq/fbZ3btB3xhvJM/Ecq3N8LuwFjFdCK4mcTvozNXDrQJBkGWvJLPsQqtdVCtBKAWMTqbShp8rRxPzNQ79npaKXWMS/Lqyq7EEk4E7FQkKLQMqKbclsBrZRWGdGtY3civz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(186003)(107886003)(53546011)(6916009)(316002)(9686003)(26005)(41300700001)(55016003)(71200400001)(86362001)(7696005)(6506007)(478600001)(122000001)(38100700002)(54906003)(83380400001)(8676002)(38070700005)(33656002)(4326008)(8936002)(5660300002)(64756008)(66446008)(66946007)(66556008)(76116006)(2906002)(66476007)(7416002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OJUsqn4mDOPHjH+xe/OURp6Cm3mW6e1bzQuFxvz5FgJcYf1RIOj2IP0GoyAQ?=
 =?us-ascii?Q?u0pWsqxSG7e9xDKBX8ff0zugkv1ZwsODVP3GntCEjMS7zNbLFv1g4Hg9Arh7?=
 =?us-ascii?Q?uLabLGvCi+K/YmmdeKBu9BI+U45+aAS0Wv18KLckxSY0135GRJG4JTKrJ3p9?=
 =?us-ascii?Q?atY6lSsqW5XIo73JbAHUgHUBBG/DsbnVpL3sQ55V3uldSkIB0FcWl40v/I29?=
 =?us-ascii?Q?1VQ5mnCkXCvHniW/5wId8Z5tYSw8mA1PGwcbIfeVOlFroVqOYITm2OMHpRrY?=
 =?us-ascii?Q?Y6tGzb02ZY7JJ8HlUvSLDO4IGGBof7/tMPnWHGtDwMT0vhdeRaYhvsOb92LE?=
 =?us-ascii?Q?yFY791gbrFUvCHaKXiX/q+HpcUFfaz5k3lOgkbTMo+ISn/hdSH4OqkVTSoQh?=
 =?us-ascii?Q?A2yQytnqG/0IZystWeajhSYuUWlhQt3Y/49YNWBI6aovmeQK9ljMytAAzqJp?=
 =?us-ascii?Q?4qsDx4aE5usOPsiaO+xF5UeaDp5MUmZx8KsdjeoSxgWhqZfVuxgo9lUXjd1l?=
 =?us-ascii?Q?evcRRvWsPM7830ArwkV4nsCwNNh0cyoDczWzSjAP9FA4O/O8lZ8BYoooCd/7?=
 =?us-ascii?Q?oPyHyOmNHiGd1wHnlvlzM8sy83nPrft29Y0PLbbWUbU3+y57nstZVcisV8zL?=
 =?us-ascii?Q?5XANe5iEFs8JHLMzK0JHNIc2Swf7i4rApUUW8OL/EfAn9qtvuP/Dmc/e+dr0?=
 =?us-ascii?Q?rb296WFrFN2PxmIK3tW801WsGaSYOphRD8kzZ4BXE1gVmmAeOaf6aV4bncPe?=
 =?us-ascii?Q?3iT7Rdi+p9BuWE7h2Pkixv2G8FdENemYsQ3UH3b/0XWjQHt2sTNyaYgmnxOc?=
 =?us-ascii?Q?TRh/3n/LSR2t5fuimArJpqpWvZW6NUnmcdR5DP2V6JElGtwH/FLvUcSUblBw?=
 =?us-ascii?Q?9rkQ6sGcDk2x3MhbPEiBG0IWjMXnJM+QsS1Gv+WC5wg4qjneR/kr/ITDkfWn?=
 =?us-ascii?Q?2voVLcFmi1qsHgM365RadllleRjiydQkjFoPDUplIhq9+mgqU7ItEIhrRiiV?=
 =?us-ascii?Q?fF69uSFxEhV83zxWOalHcCr2xRqPB6V+xpqOo/Dwd3dheoB5HSmWv46ziqbG?=
 =?us-ascii?Q?g5j0s1QOy9FwcDKwB8SZtoE72UgPLsKhLB7UD1etjV93+t8G+ZvpBXOUHH+p?=
 =?us-ascii?Q?p/EAfqqO0PZSJOvMJDgkMOodEuqHqtAic7PFrD7X4vtb6HmUy3Onzybnw7tZ?=
 =?us-ascii?Q?MZSlqeUlSKcmHOktLUBQti+bg7IXU8bNZffiQ3f/6AoUBUxSa17L2r4EXdEi?=
 =?us-ascii?Q?BGwhJrWZoDhmzZME7LEwqtQkNHU5i9SysBN2SszcHgib3DppUk/iX7uaYkq0?=
 =?us-ascii?Q?/fYemgxiTkHCmbvu3vsRVP/oW6utvm6FOWjnU8xg0Kc4Qi4X/KFbLPO846Xu?=
 =?us-ascii?Q?IGE4SzygnG0F+0UUbwl0GunEhLrCFgCqfg90O4YnKkgTVTbVEV2ufvN9LFj0?=
 =?us-ascii?Q?5kvZOvNTfK/YLCWjVbzvw9uINRsUCsy6Mn0WKcX5Le1X9YLTnsTa2OWN2/Sa?=
 =?us-ascii?Q?Lvq9yr99RThrIfWJH2butxkecF0d5jqI8SASYt7jVFeuCE1D5nQ71HLTDm5T?=
 =?us-ascii?Q?ScHhCwwXBakm7E9nG10=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f824d58-ff75-4f00-58d2-08da7a59766e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 22:49:48.3811 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aofEOcZj2wWawzEmlq6R+MXgcfj1y9hm8clYgl1KaJ/YKH/PDziNu/a3Z2ClFAz9rK/cydg4YAyeqlZqvwDECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1412
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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
> Sent: Tuesday, August 9, 2022 6:26 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: Si-Wei Liu <si-wei.liu@oracle.com>; Jason Wang
> <jasowang@redhat.com>; Gavin Li <gavinl@nvidia.com>; Hemminger,
> Stephen <stephen@networkplumber.org>; davem
> <davem@davemloft.net>; virtualization <virtualization@lists.linux-
> foundation.org>; Virtio-Dev <virtio-dev@lists.oasis-open.org>;
> jesse.brandeburg@intel.com; alexander.h.duyck@intel.com;
> kubakici@wp.pl; sridhar.samudrala@intel.com; loseweigh@gmail.com; Gavi
> Teitz <gavi@nvidia.com>
> Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length for
> big packets
> 
> On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, August 9, 2022 5:38 PM
> >
> > [..]
> > > > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > > > which case the receive buffer will be reduced to fit the 1500B
> > > > > payload size when mtu is lowered down to 1500 from 9000.
> > > > How? Driver reduced the mXu to 1500, say it is improved to post
> > > > buffers of
> > > 1500 bytes.
> > > >
> > > > Device doesn't know about it because mtu in config space is RO field.
> > > > Device keep dropping 9K packets because buffers posted are 1500
> bytes.
> > > > This is because device follows the spec " The device MUST NOT pass
> > > received packets that exceed mtu".
> > >
> > >
> > > The "mtu" here is the device config field, which is
> > >
> > >         /* Default maximum transmit unit advice */
> > >
> >
> > It is the field from struct virtio_net_config.mtu. right?
> > This is RO field for driver.
> >
> > > there is no guarantee device will not get a bigger packet.
> > Right. That is what I also hinted.
> > Hence, allocating buffers worth upto mtu is safer.
> 
> yes
> 
> > When user overrides it, driver can be further optimized to honor such new
> value on rx buffer posting.
> 
> no, not without a feature bit promising device won't get wedged.
> 
I mean to say as_it_stands today, driver can decide to post smaller buffers with larger mtu.
Why device should be affected with it?
( I am not proposing such weird configuration but asking for sake of correctness).

> > > And there is no guarantee such a packet will be dropped as opposed
> > > to wedging the device if userspace insists on adding smaller buffers.
> > >
> > If user space insists on small buffers, so be it.
> 
> If previously things worked, the "so be it" is a regression and blaming users
> won't help us.
> 
I am not suggesting above.
This was Si-Wei's suggestion that somehow driver wants to post smaller buffers than the mtu because user knows what peer is doing.
So may be driver can be extended to give more weight on user config.

> > It only works when user exactly know what user is doing in the whole
> network.
> 
> If you want to claim this you need a new feature bit.
> 
Why is a new bit needed to tell device?
User is doing something its own config mismatching the buffers and mtu.
A solid use case hasn't emerged for this yet.

If user wants to modify the mtu, we should just make virtio_net_config.mtu as RW field using new feature bit.
Is that what you mean?
If so, yes, it makes things very neat where driver and device are aligned to each other, the way they are today.
Only limitation is that its one-way. = device tells to driver.

> > When user prefers to override the device RO field, device is in the dark and
> things work on best effort basis.
> 
> Dropping packets is best effort. Getting stuck forever isn't, that's a quality of
> implementation issue.
>
Not sure, why things get stuck for ever. Maybe you have example to explain.
I am mostly missing something.
 
> > This must be a reasonably advance user who has good knowledge of its
> network topology etc.
> >
> > For such case, may be yes, driver should be further optimized.
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
