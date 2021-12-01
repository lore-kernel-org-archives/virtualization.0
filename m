Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE33C433F5
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 12:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B733C409A5;
	Wed,  1 Dec 2021 12:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I6xM6H5tEvX1; Wed,  1 Dec 2021 12:29:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 57CCA4056A;
	Wed,  1 Dec 2021 12:29:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26A9BC001C;
	Wed,  1 Dec 2021 12:29:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E235C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 12:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 602A06065A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 12:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l6WYauPsAG0P
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 12:29:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::612])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C9616061D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 12:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm2i7h6NlkwXbUaB9BYjqa3DEcNIyuv8r4BW5ZjQ3xbvUIhEo5hk+UvjQ+PSlMkVMFs7Saf/LSuYs2qSpgOOIstmwKMFk0v5TlCx3V3t9P/E21Dzh8Kb6Hgv1c8WXZNZsKcu7QOkatdwTSPz0Y9RuKsJioql20kgESJ35+kuhab6SD6Eg6Dtm3mfUMSr39GJ1pmhU/8Ii1JRhS7f34x001q3kT8YJwMIFFUm6Gf5+Unvs9DgVj9wa3yEDqrUCiCYPisgPuVnafP4SD7606Ff/rW5VyYktxMwFRQBKEDCuAFYX9VaRxQ/3zD2KuJcgRb8rUBkl14SgBH/cYVx6LoadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLoXwYJWwC3hfP2If2qXq2gu1NE0zX4c4NIHEKVvvrA=;
 b=fVA9LtQmIo2jJrB0rJmeHdizOg96Mh5Bee8XcGGx4H4H6bu84ZGfAOWPMYrySinnq40nebvOw7L7td56gDesb5LgzGFpE7VvJrx5lAvG+U3jhy1F3oPVpvBYxOP4uxo34vPu10xF7hzdsJgz1gv/IcB6aDstfbYk7TJ7DmqS2PLzX2VCeUOzQMsL2t/PhXwqWDahvtg5PCyzrie8RjgAUV71zGEsUpid96DTbg0bgMuzgtbIw4kWT8OwlLxzdhCWzH4OFzvsiZsh078iTnIxm8Jb7ZCt+oXHp8sbarVXgu8oAlYlA1phyM4RnrSiKaCDuYSF2HBC2NHEbl6dJyx/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLoXwYJWwC3hfP2If2qXq2gu1NE0zX4c4NIHEKVvvrA=;
 b=aCuhq0bKJDj5qKhGDeIbtuigUfFb4qOUV1FRtd9w6OLYrQARNmkRnWwmue9fMiepxwPxjBDpQjKeQP3FjJxvq+ej/0xNGdD6kmamR0MRfl5HevjMCqDFA7Ze4vCBQ82uaKJ+K969xirxP1cUZVeht+wVVbgYwUZDrzBgPBW+AQsA+Ljlt28X9gIlNL6P+b1JqktEeBK9mB5tsKu7llJkbHfWAi/h0ImlwT70J0DtAjp1IWory/SUk9ewtE6i702k05fidviVHVBY+haQbqGd1jXOttHZQdDMn31J10YsnLJVdM30N6nZdUUqm3YCAy9p+MZVtZgRiCGnmhKNSRAmHQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 12:28:57 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%7]) with mapi id 15.20.4755.015; Wed, 1 Dec 2021
 12:28:57 +0000
To: Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
Thread-Topic: [PATCH 1/2] vdpa: Allow to configure max data virtqueues
Thread-Index: AQHX5c+B2VmddtY5YU+cieG7gRIwFawc2KGAgACRBoCAAADu8IAAH1kAgAAHloA=
Date: Wed, 1 Dec 2021 12:28:57 +0000
Message-ID: <PH0PR12MB548132DA10588E46EADE50D6DC689@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211130094838.15489-1-elic@nvidia.com>
 <20211130094838.15489-2-elic@nvidia.com>
 <ab454062-da69-a72e-1953-716257bb464c@oracle.com>
 <20211201100307.GA239524@mtl-vdi-166.wap.labs.mlnx>
 <DM8PR12MB54808D3B8AE095A6EF145E36DC689@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20211201115838.GA3465@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211201115838.GA3465@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc4dd9e8-a51a-4577-1060-08d9b4c625bc
x-ms-traffictypediagnostic: PH0PR12MB5404:
x-microsoft-antispam-prvs: <PH0PR12MB54049A6005CB54B4CB44A0AADC689@PH0PR12MB5404.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cyKko0/pu5SBRkprae2EbgVl+qtczJcc5pR+hFTBNcG+ohCMxzYNsy66JrKc+ZU1Bh+AKCuZqmjOvWjglWi6ug7i0Clqimd9DoDkb6OCEmgjZG7cWcARMe1oUF2UOFHcuDHL3KgAXNBPkjafMxJpBJJEjLhBCOpZ7xOrR40Q4LEKG7SIHY2WVEKesrlesBQpb5LMPCwUddBUg1kLQHP5ASlD+ZpounrmKg/kSKGambXd3QiygCKVzq20J7QE8d6l81tMf2XbpLKjN54sjmvmUTkG773hYLpI4/EFz/RpydA867Or+PsJ8FPQa+ZKWXjiftzk7cdlL7GPhG1t0lotYPxBJ9cTdpv4Y2gykB0xd0wZy/zp4gpLsXazVqK45Kc6Q1fQdDUEVMGU6d6C+/1UFscNvh7FQyrH9X7kXlJUxTvglN4ZF62qhD0lFlr92MC/mGZ50QJ+cUx5AZIhedo5AZfaC8av+6DdSTwZhRzPYHbp7jtHeUmvMLX2dpT236XsPGx21oMyhQKD2rx4k9xW4TAflHtE0/jC9WS9TXOCVc7IROBYGYYvXDErvxWAn5kAWZXrsIWIPuJnrjwN+rFbD11nKWRknclvfBqslse1SaQGHsE11Ucdf46k3l08Wlel7iZvLDLuzqDiZbX49U1KLfghM2xB7dcHuhyHcupbqtAFdklqzVa/jE9LBKu9nfYlpZiPm9MneuPobZ/wDhw5qw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(86362001)(186003)(6862004)(26005)(2906002)(8936002)(38070700005)(53546011)(55016003)(7696005)(6506007)(9686003)(71200400001)(66946007)(76116006)(33656002)(66446008)(66476007)(64756008)(66556008)(38100700002)(6636002)(8676002)(4326008)(316002)(122000001)(52536014)(83380400001)(5660300002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0EbZNpkD2m7Bfgl88Ig5qPWlQCs7IH0WMYWl4CEHo+cRmB3SRX+jjRWB4DBz?=
 =?us-ascii?Q?7DutI5FvCEOPNdUbDUimjPlVrv3XbeRvULnCjEqCUqZ/eoeMZmE+4Nw7fXz6?=
 =?us-ascii?Q?oAFPIJFH1fUSEI5w9HYXF7bApxijmwFcGA0b2XdriPnZwBxJje9Z3LAo2a4B?=
 =?us-ascii?Q?2OUpDYur/hVhdZ/5m+aQ7AyuxeA1byr2jsuK0KlnSOE2x1idLIbB/RY4m+pu?=
 =?us-ascii?Q?QNjvp3koP/x9CH6Fa/uHVEmKFHqMyoCKRZ1LMV4y0crtGXRwjsE870+ffDeZ?=
 =?us-ascii?Q?/QBxr7UfEzU9LcOCcy+5Z2LhbXsQpo6FvwDFDIId1TYsfm2bPwPLsd1lKase?=
 =?us-ascii?Q?0Z3vPOp8U5CkRO90ylaa1rCRahiT7pmrt2RK/pYC6sk3TqMLFAmQq0h8laNJ?=
 =?us-ascii?Q?Nm7BpUAZAkWOXxrsy0G72K9Zpe2KcbCYlRyr0EQDXXfXlfjl9/ZHz4CsevKU?=
 =?us-ascii?Q?r+cqZMkrmUCbDiF0lJ8/CxxNKPMR5fjwttoySIuzFYrjYzp9ghNQGXnZnTgX?=
 =?us-ascii?Q?amVDB1HHX1GSSxtFJ4vx0v1XTqxb2Wl/bSDBbU2d9lt9Oc3qy6Jbj3eEk4QP?=
 =?us-ascii?Q?xLO/tdOQOR8hjmOYwuez2iDMKXNYbLRZVjXrajT86sRiKmN7ZPVG/VgHV/4f?=
 =?us-ascii?Q?1m0VfUhzyp/sefeU32YYQGUkNQjP+alzVv+bb7g/MRmEKMmtrvsG3Psc52c2?=
 =?us-ascii?Q?wJsLFPhDFKbECsOmSGoQtE6Wfpvhb6RrCwIK0hMmED1dQ3uHq3bVwjpojYTb?=
 =?us-ascii?Q?9UWozCQ/gUjxnLK/5V+2K4BMUKOFYjOPJpXQBB6yr5+y4JwRpJT/FGGMURnw?=
 =?us-ascii?Q?Yh7MpcJscqgq2xej0BRnVNq1R+/d7ZxoP/0YdUKjROSzZ5klUA8uz4Yxbf2K?=
 =?us-ascii?Q?pJcVCbC1Fak9U4lUcxEpc73y5zJUWCEaO9dWQLxNTTUw5vhdNMndiMs00wDx?=
 =?us-ascii?Q?Bjn9QBun3f99FSaN+UJfigVvWm4VKDC1vJiY3ZvpjTWsehACVJ/X8TIe+eGE?=
 =?us-ascii?Q?UKcTD2L4qXp7gkJm7JtopA/5X/MU/OT9siDlz0kYPcMSUTCLmis9GqLruRok?=
 =?us-ascii?Q?dxgnOj0lqacsNaTeV2cMcEFky8dr/LiUKg96EGuOMbzW5nSkV0dmcoRzA8GW?=
 =?us-ascii?Q?C+a7mLSrx9AOrhsVrVHAthwc5A1UB4ZqJfVbglFyEAoz04TvHNJX1VS4KUri?=
 =?us-ascii?Q?BBQnOOvag0aAa/rMo20ChP24EeAwp0W4iv+nF2O6zMkfzKVICANLbXp1mjCG?=
 =?us-ascii?Q?aQwXq178qsL7I4gek94uevDxEJXcJX+GH0tcdKHgb0xg4BKYPY6jLk/4YV8H?=
 =?us-ascii?Q?N5ma8wCuur5zIHeFW1X+ioEI0rzPqAJpGZAB14cTBj4Gh6QwU7rmbK4nFamF?=
 =?us-ascii?Q?syhB/HIcSSmDFXLiS1AvuppSYhE0k4pb5Bobu6iNxuLeR9+M9wrLE0DA2eqM?=
 =?us-ascii?Q?yKYuHyImNROsJAJeVV9lcPZt3zH6XOPJwyRt/NKTE1oe59WdHn4n4gWgD1Ee?=
 =?us-ascii?Q?mb9Opuj5K0DbdKVMwbso5jEWktHBopNRi5caA3FYIkSi0o6B/vlYGxm+KEi9?=
 =?us-ascii?Q?ZBu6dYgmvGZd2LxVJq+nxHA91Oi+8woDl3kcmsV1aWo7gVBbDivchHHVvTmR?=
 =?us-ascii?Q?tbW8VKHjct6cHVo3D2SJsDg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4dd9e8-a51a-4577-1060-08d9b4c625bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 12:28:57.7778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyJezKJ/0YS5KOdaCEKu18eXV/CIPmme3WM5X0z68oMDl50Z7aJxIPYC2avLvVswB7BKLZOnaKWQYqqGcS2knA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
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



> From: Eli Cohen <elic@nvidia.com>
> Sent: Wednesday, December 1, 2021 5:29 PM
> 
> On Wed, Dec 01, 2021 at 12:09:17PM +0200, Parav Pandit wrote:
> >
> >
> > > From: Eli Cohen <elic@nvidia.com>
> > > Sent: Wednesday, December 1, 2021 3:33 PM
> > >
> > > On Tue, Nov 30, 2021 at 05:24:03PM -0800, Si-Wei Liu wrote:
> > > >
> > > >
> > > > On 11/30/2021 1:48 AM, Eli Cohen wrote:
> > > > > Allow to configure the max virtqueues for a device.
> > > > >
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > ---
> > > > >   drivers/vdpa/vdpa.c  | 16 +++++++++++++++-
> > > > >   include/linux/vdpa.h |  1 +
> > > > >   2 files changed, 16 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > > > > 7332a74a4b00..e185ec2ee851 100644
> > > > > --- a/drivers/vdpa/vdpa.c
> > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > @@ -480,7 +480,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct
> > > > > sk_buff
> > > *msg, struct netlink_callback *cb)
> > > > >   }
> > > > >   #define VDPA_DEV_NET_ATTRS_MASK ((1 <<
> > > VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> > > > > -				 (1 <<
> VDPA_ATTR_DEV_NET_CFG_MTU))
> > > > > +				 (1 <<
> VDPA_ATTR_DEV_NET_CFG_MTU) | \
> > > > > +				 (1 <<
> VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> > > > It seems VDPA_ATTR_DEV_MAX_VQS (u32) is what you want (# of data
> > > > virtqueues instead of # of data virtqueue pairs)? Not sure what's
> > > > possible use of VDPA_ATTR_DEV_NET_CFG_MAX_VQP, was it to
> > > dump/display
> > > > the config space max_virtqueue_pairs value (u16, 1-32768) for
> > > > virtio-net? Why there's such quasi-duplicate attribute introduced
> > > > in the first
> > > place?
> > > >
> > >
> > > VDPA_ATTR_DEV_MAX_VQS currently returns vdev->nvqs which equals
> > > whatever passed to _vdpa_register_device(). The latter depends on
> > > the value provided by (struct vdpa_dev_set_config).max_virtqueues.
> > >
> 
> But currently VDPA_ATTR_DEV_MAX_VQS returns the number of used queues,
No. it doesn't.
It reports nvqs passed in _vdpa_register_device().
And this API has clear definition of nvqs = number of virtqueues supported by this device
nvqs != number of used vqs.
So current MAX_VQS is doing its job right.
For example nvqs can be be 8 and guest VM driver may just use two VQs (1 tx, 1 rx, and used vqs = 2).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
