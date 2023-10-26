Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F1BC25B67
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 12:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A02C6402B0;
	Thu, 26 Oct 2023 12:40:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A02C6402B0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DNzzegq7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OqMEJptr6L-2; Thu, 26 Oct 2023 12:40:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0F97C402C4;
	Thu, 26 Oct 2023 12:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F97C402C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6F30C0039;
	Thu, 26 Oct 2023 12:40:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0BE8C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 12:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D08C6149D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 12:40:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D08C6149D
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=DNzzegq7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JrNj0hJT1lGL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 12:40:07 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::615])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC7456148E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 12:40:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC7456148E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhXbPEHw3eYoh+7qUXikVLLoEjaEYHxxevhV5+h0NxvCTXWIyxX9IL69xa9f5SCvi/VTx075s/GBS0Z3Fh5MMlkaD70JwdFJtulx6CrWWpdeqnjh1XJdNN5/yjW1Yj8Wwk7E6fqNQW5IyCzVAlapBrGzcwGh/jR0n8shygmBCcga/X+7si5OHxHISSPhW/hiqOiRKD5gCKsBg4fje3mx4s9CwN3xjxX+qpWHfP6opGN9/dOrFsym2dL2sFv0IjPHFHWgiIaFH3huzOpbj579SYQeoDDULlH2Ly9zDj4HSEQ2iU8+V5x+5diUZxMS4lsdIncyu42sW6zurZT1pLi29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hKkn7MXzaT2TlLY2wyLW/9cT6jdMM93iAp8cnjfykI=;
 b=bNIbHkW/9vtoiDWxMBL7My5A6A7koB6Z0w9nhI1/QOdDgxaVZdV8Vj4QoDPou4NjnNiLsbJJZYWYi36R78hXQZfcQenYXihkcKzTfFE4d3auiRGwUYHor6KEi4HG/n3tYFicYWBaZAyRo0ysN6qxnWQkhYll+0q4kYLYvZyvXrDvwoRLPNglZ+2uLnwEoG5Jk0iI41P96/MJwZsHAl/1XWUvFtIcm25Wg1fJvOl1e37hYF9/6lh6obKnPIR0n/SO50Cw93TvQakdxm/1p3dANxq+wxGG2K6xVsFz29cgzod2ndzwfrRoPB/hF7iYPmR0nxvXCpmdCPBpbyD8vCLkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hKkn7MXzaT2TlLY2wyLW/9cT6jdMM93iAp8cnjfykI=;
 b=DNzzegq7vZHAisyvRzFrwALjltD5wMnIyrqBex8Mz8On9SNFj5nhlOeslkG4+tD49q/LwlbgcZNrFak5/Fg2Ra5kEXRrQFHnxtt+52dRmo7bSSw2aUiKoid8wdpbZXtpQb9dhp0u3/TsGTkTbbiC6zEBXh6DzM1fxseYtkk1TVkXVShAnFInlFVhzhKAYCML7b6dGOpm0j7NQkBAaYPswTZ45VUiIt9qQgEYJEd/WUWwuue3pey3ZEFnmfIxWcAC1n9zFql7sT7weBvJDD96bJvRgrDXEZOYV7IJaXEsn3hU1nZL0Ht3s0c12xBSXd1PDh5YXlYISrnZ9ScQ3GXWIw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 12:40:05 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdcb:e909:74a4:be7c]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdcb:e909:74a4:be7c%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 12:40:05 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: RE: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Topic: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Thread-Index: AQHaAP/t3dG05nYg50S7FQsh4+CEA7BZZo+AgAE4i4CAAE2RAIABG4MAgAABLoCAAAcq0A==
Date: Thu, 26 Oct 2023 12:40:04 +0000
Message-ID: <PH0PR12MB5481E1AF869C1296B987A34BDCDDA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-10-yishaih@nvidia.com>
 <20231024135713.360c2980.alex.williamson@redhat.com>
 <d6c720a0-1575-45b7-b96d-03a916310699@nvidia.com>
 <20231025131328.407a60a3.alex.williamson@redhat.com>
 <a55540a1-b61c-417b-97a5-567cfc660ce6@nvidia.com>
 <20231026081033-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231026081033-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB9178:EE_
x-ms-office365-filtering-correlation-id: 910bc8cb-9880-4acd-c031-08dbd620ae09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 74GWgWHD1iH3Moh476IU9h8Uz5yLb/yxj4zqBUYi2PzuOE3kLJ66LtB+EGagKiaa1r8PDUF0f1NYW/VI7SX1yYf2r+A1bYi3y5SdPogBRsSMHnccQdgUkZUDqMQlicxB/zdghnJvxNTlJlOxqBz3CaFTICbSTnX2K6slHvDFhNww0GFdYeYWwCL5miUa57eMQYltA16xgOFZBVRRWhariTyivA0P7kqe8ibFSFyz4PdRu3VDHIzXOPuCnPPLKxX7ptms/1tf9vGExz6YvgpuAz1QS+s5JsDUIRNV/CoFtD30HW03Jq2Qidu5zc7nwY4sHJF7dGVeQ5y/FZJnGydp5c+o0gHc7hyIrnTJ69Cx2FrlvKOX5sx8m/s9zQCAT5QW2R+K1fTEZDVtyBSzSbOQ1JhJwil89ZYMLk9Lff8anNVymToIkh6iN+JvtYy30p5/hpf4IRk5WvdfrPiZrzHkHpx+GJ89Lhl+wXfkKkoAUOYKUZDxhjVEmcfePdd4qqUZ0EACjoimHibzm1g2la8WlARrpKbYsALWYqYuqKaElKbaG1xx4B9DBjDWjNnIHqg+6Ck8sxoH+0m3bfMUns1iJWyvjj03mgB7ENNTlM0sZXLin+6Z7gtT/pSc0HFuCbWL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(122000001)(71200400001)(4326008)(2906002)(8936002)(8676002)(52536014)(107886003)(55016003)(41300700001)(5660300002)(9686003)(6506007)(316002)(6636002)(110136005)(26005)(76116006)(478600001)(7696005)(38070700009)(86362001)(33656002)(38100700002)(66476007)(66946007)(54906003)(66556008)(64756008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2X7ldA2TsajzQWRMA/bOxZMkyCGILfMFBnixS20Ai8WEywqfjgWyPqlbnhQK?=
 =?us-ascii?Q?tRgHu39ibAQnhXOx4GHvYaa13sL8mHetQIgnuG2mxSDnHfvcedyfk+l2VVqs?=
 =?us-ascii?Q?CPyOLNyNhoWH1d0pry4nCaR4z+doRhVGKeqWl/EbqbgTsBJZ3kje5Uar5Tiq?=
 =?us-ascii?Q?ldiRW9uL79iiXwdPdPMzhPAIZt9q4PhwPKDezbeVfWzMRn6OFwfQCqXKkpS9?=
 =?us-ascii?Q?2iXMwLxt258d3GSU/WDtkp6kVI6KLhavSqnlI7PLFa5vbTzPavuus0rOMfLR?=
 =?us-ascii?Q?hU1VMGEfKzzxnHCNO7H5U3+59reVV4KJbwKYytP3lsHfPjyLPnS+ewXqs+p1?=
 =?us-ascii?Q?rPeRV0Jr+uPq20IABVjpzDM4g7HGEteAgYsmBWSO/QLe7v2NUNX5p6uhgf2a?=
 =?us-ascii?Q?A782QXV5fPy+A5Ky5vGg4rkd93FD8cEbxbGevLcMV24dQvfyBDnLa7yMCQB9?=
 =?us-ascii?Q?RvUV97kWCg09e7c6a2PX5f6HIS9nCX5rWsLsAwb7R6g52f/PyweqNoCeIsQY?=
 =?us-ascii?Q?G6gRBqXlxLUB40xCTcNB8bwAzfDA1P3lWzzzstSh1JLMwM7x3+V8cseFk2jl?=
 =?us-ascii?Q?ExdXUY0hLXCpT6v7OSzMTAKkn9bifRRcVG7uMufd8+pe9VzJMF1oIJWTQxmm?=
 =?us-ascii?Q?Y2IdJGwCXljrTxCDdMbfcehV3TxepQDqZR9z7gHgm8BNpW1y+BLPwIC/61vj?=
 =?us-ascii?Q?yZYbAqbbuINk0ZljLwZfqIgOqrDbU3PVX/SiaXW7ITx2tvcYL8D9QAbFjZUi?=
 =?us-ascii?Q?GiC0iv0jnc2SaKd96+pOsUtXIxltGKME7L8ZPvX3xzNefzO5Y69xUmGeLpjH?=
 =?us-ascii?Q?ShC3svAve2iMyaYzkUT5KPuORyM966w6qWsKaunuQcqovtuJGY/HJSR2LiWY?=
 =?us-ascii?Q?SY1W18KJdN8yXjWUyVJIRQooYBfDmDYx+P/SUv+VnfKTihKx2X9TSGrAZ/nh?=
 =?us-ascii?Q?Hj6cK5goNEbEscFTIs+sxWnqr56Jn/zN4KTNRb3idSUKctTU9yoBRwZqcQSW?=
 =?us-ascii?Q?LdKYvWKhAUlESXhXFdBRr5In63vbsJ7iXawRzWVr9oqMPPicpaz67CYAbg0c?=
 =?us-ascii?Q?mx66yjLQ3fyuwmIBkA4JD8gmKKslc1kmZ0MrBLYS7rRM9js+LOuZl8Na+OqR?=
 =?us-ascii?Q?r6vGY/LjAUT5c+nOqdaO9h2NO4ItknHfb5a3WYNvjLKcQFjpD7DiHjpysCK0?=
 =?us-ascii?Q?+DxrRpfrmdb2BjiZJN+2dDsu77d5DN5k4Cg+QeQZxgwP0hMAikaPfiyzC4mb?=
 =?us-ascii?Q?QAh/Ce+Ud0iKBsgqhVVwO9KhxVzI7lVLQghILlfz5cdMoMD6D0fNow/uh0Tq?=
 =?us-ascii?Q?sAv3uioviuHp9tpa3w1nxOeuwYdl1R49i1wTN/nN7S7OlV5YGpqT9O8Fl0CQ?=
 =?us-ascii?Q?FG+ivyMLKvop0Z0xgqOqwU3Hduv2cQhzkNDCyxcPpCfF9oWSMkleolZgDOax?=
 =?us-ascii?Q?YaV5gOMjoDXBFILJ/gG+RPNQ71ItkiHEoe5YMY8lh7jOUJXQbJlbHrtUBLF9?=
 =?us-ascii?Q?IDEa8If4hiHgj+090Fjfq0+QdkJI4RmoHMk0PN6dg+IvcdnUbluPOcikaB6C?=
 =?us-ascii?Q?Z7L4WtnM2IFHbbA+rMo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910bc8cb-9880-4acd-c031-08dbd620ae09
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 12:40:04.9765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7mOafkwnxOxfeLYiB5JZsrp3nNCth0Va1O0ZQOg6TUsq6257C1KBmHYTwRSteq5MeO+iYyuwswQp09sDwQICA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
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
> Sent: Thursday, October 26, 2023 5:42 PM
> 
> On Thu, Oct 26, 2023 at 03:08:12PM +0300, Yishai Hadas wrote:
> > > > Makes sense ?
> > > So do I understand correctly that virtio dictates the subsystem
> > > device ID for all subsystem vendor IDs that implement a legacy
> > > virtio interface?  Ok, but this device didn't actually implement a
> > > legacy virtio interface.  The device itself is not tranistional,
> > > we're imposing an emulated transitional interface onto it.  So did
> > > the subsystem vendor agree to have their subsystem device ID managed
> > > by the virtio committee or might we create conflicts?  I imagine we
> > > know we don't have a conflict if we also virtualize the subsystem vendor ID.
> > >
> > The non transitional net device in the virtio spec defined as the
> > below tuple.
> > T_A: VID=0x1AF4, DID=0x1040, Subsys_VID=FOO, Subsys_DID=0x40.
> >
> > And transitional net device in the virtio spec for a vendor FOO is
> > defined
> > as:
> > T_B: VID=0x1AF4,DID=0x1000,Subsys_VID=FOO, subsys_DID=0x1
> >
> > This driver is converting T_A to T_B, which both are defined by the
> > virtio spec.
> > Hence, it does not conflict for the subsystem vendor, it is fine.
> 
> You are talking about legacy guests, what 1.X spec says about them is much less
> important than what guests actually do.
> Check the INF of the open source windows drivers and linux code, at least.

Linux legacy guest has,

static struct pci_device_id virtio_pci_id_table[] = {
        { 0x1af4, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
        { 0 },
};
Followed by an open coded driver check for 0x1000 to 0x103f range.
Do you mean windows driver expects specific subsystem vendor id of 0x1af4?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
