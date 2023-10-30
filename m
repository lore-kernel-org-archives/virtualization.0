Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDFDC4332F
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 18:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E57F940362;
	Mon, 30 Oct 2023 18:10:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E57F940362
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=csDJ1oSW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3X2WD2Al8Bq3; Mon, 30 Oct 2023 18:10:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C82FB40355;
	Mon, 30 Oct 2023 18:10:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C82FB40355
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F236C0039;
	Mon, 30 Oct 2023 18:10:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B980AC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 18:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B6EC40199
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 18:10:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B6EC40199
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=csDJ1oSW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S1lwmlyncdbZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 18:10:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::618])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D3A7440185
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 18:10:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3A7440185
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2XRL5QN9uQwHkgeOYkEYYbMgSlMLS/JlqrMwCc64tv0Lv5Z9R5EsmHmoDeWSMZUyHkPbzbzlx7TdlH3QamlNR+0KBLgyAnFFPShJNXoeulxmkHbBCbizY3vuZWt4K6DiClpkwTDFxXdOnQRqEy2BD9+FKjyJeOlZ3ZVgjXnOI2NtasUeWjgb59BSXDTelztb3yRoORHS+jEfwz0JomQrFlzW06Wp+oJGWl+uzMr90HPQPIIb/OVRyujrE3YIdSzEiX1Cv6uYMIDJZxAHnfjLHBT2xoAcxQMC0yqiXrLarPYTtXz0qtQxXRUIZ0ke/kCD0u2N/ZsgqNNUiBPRXjN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DX41p2DA32Ag8XQ3bcz3boOnrj1bf831A5FJb8OAuY=;
 b=KLRW+iER1Xgr11pc9FwsHGQPdeQNOPkvZp20nrQdEQkIccaBqvBf0XlSmgYtl/pAGTch4ALJJMWKWCSHjxUQkK0yeTBHuyo992Dn9e7lLGhuxH6XKnW5E65y2WCaRI2fX++jqnENuHbaJAGBMkPAvA8JMl9fgmCxFBrlQHj0ur2EJxCHTE0wIvivd84OoWCc6C0/A5F5K3eJiojM25F+fIMJ2lpwbzRxgXBXPIvl9bCAN6v7Jwdxizr9N6sq+p8R1oHBebFcV6KIBwYBcB0QUzovMOBkMJuLAYrlgDeRzO4KnaDV6bU+2zZtMb8n28C1mnWIFqYY46TWH1yeov0xLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DX41p2DA32Ag8XQ3bcz3boOnrj1bf831A5FJb8OAuY=;
 b=csDJ1oSWqC7cy0d34ih3jlvpP9OV7ALOH1cy3QSJXOzCoom/4rEA1CiOFqIEmnKB68MLz8WP920KQywUSpzfSKNYTZoEv35Hu9kLMrFXv5Dzcx85gc2tnKEYrYY3yiYJj9wkZeezrhDloQDphVORZikOseU8rJYnl6+kzXjBpQh3xOeNdQxuOma/DyPTT1mXjThNFcbHjPVmUdhqg4CgREFAJBt+15jopY58aoSIfQryEGqb0JjHSsrEmlT0PVNxI69WRNsocQOMMicsExXn+atB66B0vXTzXybqs++KmA9a5Rn65UJKzSx5z2e2m5xf4LI2wTmIUDrF9PuI3nebTg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Mon, 30 Oct
 2023 18:10:08 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdcb:e909:74a4:be7c]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdcb:e909:74a4:be7c%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 18:10:06 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH V2 vfio 2/9] virtio-pci: Introduce admin virtqueue
Thread-Topic: [PATCH V2 vfio 2/9] virtio-pci: Introduce admin virtqueue
Thread-Index: AQHaCoENkpIXTr9HoESn9KiFa24lo7BhNkgAgAFFedCAAANWgIAAI7/Q
Date: Mon, 30 Oct 2023 18:10:06 +0000
Message-ID: <PH0PR12MB548197CD7A10D5A89B7213CDDCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-3-yishaih@nvidia.com>
 <20231029161909-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E45C628DE3A5829D438DCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231030115759-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231030115759-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7171:EE_
x-ms-office365-filtering-correlation-id: c34c5dbc-d101-444e-bf4f-08dbd973725c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztdNWH4tfAR2ljHVPnmEWqqs+i9XFluXeLQ6j4trdasS8BdQUqgAlNwW6r+1P4g1w0YP878ADtWUFPoZt334Ucyzt/Fw5w1xJq8CDnzfZRd8tiQ3je8VC/9B/wfx9nMJHkwDdEFnKQYZlbq0ZRpAJR4U7JqgA/NrOm+l7rK2cJ2HgqWj3KF/gsUzv2h+MMdljAOwyxhChLmf7JiRNAwJna7uMmHpUJTjCFnFQ6EU1560XE4ezzdo8F3kXp+tHDeM3pOQkp+RXPvVgPy4JfK7fUsEuo5BQe93y+Nl/65Kd7oBHh9idJuihmDiSqyTQhdaWD89yz026oVnoEbO3uJCb1NnkLL9ztF8cXpYfGsOjUunqU/lyNymRM8nmLGyvlLJZm+Gs7V28p+uVhxKvNu0bE99wYQ3wlzF7bpRcnB7ONR+QMlDOgwtp9cH7vzdF53uAf6Ym5BcRAXxSEuwrNBx2/lEAC/3wi35iW+c1ao2/nSEIva4QRFiyBeNy1whJrTx6o3bBSbSgIFKBZoYvBTwBBmSLHlsarpoNaIBB24/uTNoMW3spQcgVSdAZUhDPIqspOzRS9wgAZJixAC21ApebR/B3V3SpqApgJDQXfbjaJWXVBJ9oQaBziwNe+zo3x26
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(107886003)(26005)(55236004)(9686003)(71200400001)(6506007)(7696005)(478600001)(83380400001)(5660300002)(76116006)(64756008)(41300700001)(66556008)(66476007)(316002)(6916009)(54906003)(122000001)(66946007)(4326008)(8936002)(8676002)(66446008)(38070700009)(38100700002)(33656002)(86362001)(52536014)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+AkIVStQwl89Ye/5pTJZGCab4AjcodSE22ZUnwdf07505wiGf3C17D1Ms+KF?=
 =?us-ascii?Q?ZdzGqnkAlUmRnTtFZ6jCa+wsNdio6Z4DPDHDRqtkytIvXRgk6MPPQz0arWKU?=
 =?us-ascii?Q?kNPHqJMH9b3y7zMQUnaqWbWW2q2PRr+8AjEohplMIKDi5awx6Qm+xclYcHml?=
 =?us-ascii?Q?vIEuZrdaJEqkPfS41IDQkIe2exckhXcayHstbC0+yqcEMQMhXzSMRHEonY+y?=
 =?us-ascii?Q?GCkO8vzh5W/vEjFhzXhp3/yUKcSLOv2sYDGevb8K+weiMhf1qj0ZdV6JZ65L?=
 =?us-ascii?Q?0TJooT9zr7/nhjbKuQ/nPly2zVHk1gUWnr2TKv3Hs0MwBEVFh1TJEeTw+PvN?=
 =?us-ascii?Q?emQCPHb+hI47JkHJ8+ByBlwxjUdfdth9pxNdtx5HesbMSMuvk8snWcuvic17?=
 =?us-ascii?Q?BRE1OQ6oIP0+9ZuIVfWFA+jNnhjAfIGRF0hBNO3y3vl6hV35x9uer/no/fbv?=
 =?us-ascii?Q?iq7Gi66Kiavl1nzqq7m2b55BezVjaC167NynPWAlXByv0XK7s6PrjBEdl5ZE?=
 =?us-ascii?Q?xeI8Mlzip4YJhfVvLqvMJ//QEBYcPwjBKwl0aDjLvk2Sr6eHfkmYpOYK3ZVO?=
 =?us-ascii?Q?2H1wdU1IQAVeksZB+4neATTHGDjTiOmp2TszEnj0VG23IWjRcGpcMh1NfLd9?=
 =?us-ascii?Q?KkekGo2URp4eURrDvWuiNi7II7HiXFwUlG+DUKIakqr6xuvWJPGwicXGRRtd?=
 =?us-ascii?Q?2/Xa2H/iioT8Fg9Z6zubgk2m4ucI6crwkWwz544WK8t9PhGOpvQ3wCMUH3E0?=
 =?us-ascii?Q?RwiaDe9ucYT4xcG7gnVfYh/MxjDLHER1JYnrsYeNmR6wjiUKdvuW6X/RuJdp?=
 =?us-ascii?Q?GKFzoXkt7YFXO/YBPNXE28nsTFykniz26t2CBKcEBrXAcZw0HqUb3ODm/0an?=
 =?us-ascii?Q?Lmdq7O2/10ErlXY4SKcyj+sbRSI9FIIct+IO1zgccZ9a/wrZUd2haRB9RYZL?=
 =?us-ascii?Q?zXvsMlp57Jmjjro7T9P+vFVU+1qXAAto0YC8wD5zBpJjJApdHKtOHbDcbImS?=
 =?us-ascii?Q?qA/dOLJe6tkq1dilSgJnlKUgmoZrxbJK7oDs6/myxlE7htv4Cpcbk0gr438T?=
 =?us-ascii?Q?bwadrp7OeSVAzdSNwr9umNok83a0hX/l2MBsPzYXYmXdMdNfH/LYFkBR4C7a?=
 =?us-ascii?Q?IAfMAO67fVn/d0vI7MCHc3cPV7P0H3jT819gtdG7UpGdUf0D3HXnyJ2uwYz0?=
 =?us-ascii?Q?dryRD2vibHoa5HjOfIw85c1SqtQrp5B3MFdrsAf622Fo9HuMUKHQQ3yePJ3I?=
 =?us-ascii?Q?rJy4GElc8bxarZfbTAc621A6/suZeBimnAC1EyOpSZNnPL5ThrsuFsP7Ouvu?=
 =?us-ascii?Q?Oym+aW6Rg4SFpV8EXA/+WH28ZuksZCL6Vom+6zgN6WNx/ICL/V2TqI58Zff6?=
 =?us-ascii?Q?/czrYdPYy3RY43EgcSy42l0wHxgCYwdaM2eovvHkRE9ktmE6dr4SNjE75Glp?=
 =?us-ascii?Q?R6Zzf+LmX5kicmHK4sjzqtsHbMVlLBD1wjMPaDljcopiAAutKaBqw6xyC0Tn?=
 =?us-ascii?Q?KyzwGffX8kaZKVmdcTiXKUp0JRMO7V6AH1+//1sj0+EPf+FcAt3CeReTq11Y?=
 =?us-ascii?Q?266wPAEFfmXWOcchiXE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34c5dbc-d101-444e-bf4f-08dbd973725c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 18:10:06.5964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiQKGEK3NqoJkaP051xyfD5ZfTmrr4IKb5PXnb3+Vl79gARu2ozohaKjPZqVViBtz7R0PmowDRds0qbpxklGxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171
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
> Sent: Monday, October 30, 2023 9:29 PM
> On Mon, Oct 30, 2023 at 03:51:40PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, October 30, 2023 1:53 AM
> > >
> > > On Sun, Oct 29, 2023 at 05:59:45PM +0200, Yishai Hadas wrote:
> > > > From: Feng Liu <feliu@nvidia.com>
> > > >
> > > > Introduce support for the admin virtqueue. By negotiating
> > > > VIRTIO_F_ADMIN_VQ feature, driver detects capability and creates
> > > > one administration virtqueue. Administration virtqueue
> > > > implementation in virtio pci generic layer, enables multiple types
> > > > of upper layer drivers such as vfio, net, blk to utilize it.
> > > >
> > > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > > ---
> > > >  drivers/virtio/virtio.c                | 37 ++++++++++++++--
> > > >  drivers/virtio/virtio_pci_common.c     |  3 ++
> > > >  drivers/virtio/virtio_pci_common.h     | 15 ++++++-
> > > >  drivers/virtio/virtio_pci_modern.c     | 61 +++++++++++++++++++++++++-
> > > >  drivers/virtio/virtio_pci_modern_dev.c | 18 ++++++++
> > > >  include/linux/virtio_config.h          |  4 ++
> > > >  include/linux/virtio_pci_modern.h      |  5 +++
> > > >  7 files changed, 137 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > > index
> > > > 3893dc29eb26..f4080692b351 100644
> > > > --- a/drivers/virtio/virtio.c
> > > > +++ b/drivers/virtio/virtio.c
> > > > @@ -302,9 +302,15 @@ static int virtio_dev_probe(struct device *_d)
> > > >  	if (err)
> > > >  		goto err;
> > > >
> > > > +	if (dev->config->create_avq) {
> > > > +		err = dev->config->create_avq(dev);
> > > > +		if (err)
> > > > +			goto err;
> > > > +	}
> > > > +
> > > >  	err = drv->probe(dev);
> > > >  	if (err)
> > > > -		goto err;
> > > > +		goto err_probe;
> > > >
> > > >  	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
> > > >  	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > >
> > > Hmm I am not all that happy that we are just creating avq unconditionally.
> > > Can't we do it on demand to avoid wasting resources if no one uses it?
> > >
> > Virtio queues must be enabled before driver_ok as we discussed in
> F_DYNAMIC bit exercise.
> > So creating AQ when first legacy command is invoked, would be too late.
> 
> Well we didn't release the spec with AQ so I am pretty sure there are no devices
> using the feature. Do we want to already make an exception for AQ and allow
> creating AQs after DRIVER_OK even without F_DYNAMIC?
> 
No. it would abuse the init time config registers for the dynamic things like this.
For flow filters and others there is need for dynamic q creation with multiple physical address anyway.
So creating virtqueues dynamically using a generic scheme is desired with new feature bit.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
