Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CCEC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 13:12:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F7C61039
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 13:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24F7C61039
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8D5260A3F;
	Tue, 26 Oct 2021 13:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nnGe51ZKxZwU; Tue, 26 Oct 2021 13:11:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6168060A35;
	Tue, 26 Oct 2021 13:11:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35DAFC0019;
	Tue, 26 Oct 2021 13:11:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 174C6C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C7A58102D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id san2GkjpBGlE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:11:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C55D81028
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ew21A1UlNbBmf9j/OTNznMmaR7pAeZRLP8RzrqpvGz53EBh0zLDpEimPEbX4AVEHcwM3W8Z0hoGeag07w33pKv8mcKnPRSnK0MJbUmeT9eDyNI/3A/lftwhiOq8yEn1d0LrKXNOjPypTbSzWki+PVdwV2xfBuZlL8MTuOvx29Dfs0q3+Q+ILdZgXYQGoAEcw318q7DB2KNI5+ui8YIwOdU+oTEYRkp9oY5a5QuAVdTOOC3Q5jocmJJ7d7pDIYrZ4VKhXs+V5tpD6fRfnXYZ8LjI/jC83DxNDA1PvOgq5cWoZB5WqH/7gVJ8ANPk4jyW+sFBKYna30Ye308Sfjk5C5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT5Kvftu7G/Z653lKxlK3uoHSK8v2vZ2lKWS6etteAc=;
 b=Y5kUCVarXBIW8x1mYunsrxqt2oMtgYG014SX+5/eTiNHr8MREGN8X77FudSkFX7sxyL2baKdYnOsq2aemVPNnXoZoNDcMyfNg5BRJwV0GiCYUr2dH6rHKSAPqJTIuGJnkz2raUugyg3Zf11wvIQqd0rKNuSWn3wfBXCnO4iz64kRsCx5mLhQrKqy/SRVcgNeoRLsANtF3hx0iPEwoJXxlRBYsZTWoh2cfrQO/EVILGyRcKlSdCWRdSnS+NObDE66+ZXKIoECWlM3Lj6HdH8W52oMocEv1UEBjMcd31ZKZvJ0yZfNWqxlMBDVEg9sPfhO48XDPPXqAewVyaSNWA0YcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT5Kvftu7G/Z653lKxlK3uoHSK8v2vZ2lKWS6etteAc=;
 b=cZVX0Vi+xD9Rf8RO9WSX+cDzqtMgiimd7LNMNH0FPxqMEhD6Up16/g7cFPDpaTIS11vkWSucRrlvLi0kIIWD4P3kz3vHrLPNg5i6kzqK4Drzw+dPQeKx0IfiFAzLaC2lh8roh+qwfOVZDAXmEbCKuF3yc8SQGCoPHWFydDviGNyFXi5CaXbxHBeWLlDAQMBUcc33A4k8M0PSxt6CNboYFZIry7aDzvKrWBAXU/SxGpOGsk4n+/VA362q+8GL+SzO/KFmOaNddM39kTE4aY2lW6n6FJ32aWWHRwNln9aout1wMIoNkf2v+MIruGqsq5wJZk87HJvjtscp6akZ0CLceQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 13:11:51 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 13:11:51 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v6 4/8] vdpa: Enable user to set mac and mtu of
 vdpa device
Thread-Topic: [PATCH linux-next v6 4/8] vdpa: Enable user to set mac and mtu
 of vdpa device
Thread-Index: AQHXyh5n45HsjzNtQ02jNNEx/k02OKvlPu2AgAAAOVCAAAGpAIAAAJZw
Date: Tue, 26 Oct 2021 13:11:51 +0000
Message-ID: <PH0PR12MB5481893A5314B3952CAE6FA1DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211026040243.79005-1-parav@nvidia.com>
 <20211026040243.79005-5-parav@nvidia.com>
 <20211026130125.pxdg7w473xjuftz4@steredhat>
 <PH0PR12MB54810B7BE5EDCA0934F88612DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211026090803-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211026090803-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad93e309-0b46-4828-a588-08d998822cb3
x-ms-traffictypediagnostic: PH0PR12MB5404:
x-microsoft-antispam-prvs: <PH0PR12MB54046E2140F5B6BC7F617D06DC849@PH0PR12MB5404.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAoFu6RtN/fahUWZtdbr9IFVvGPXv6iC61R8hXqg5yks3pLozEHRnd7TTUsuzQ8XfwMTdRz13TJoySR6VNLixSmcdanGYEMBgK7nGdwHvvELlmCn8SmussIvbr0isiySSlFgLqR1HWkY2yposyx5JX1Q4sOX5GB2InMsZnQoKF+hN7U/6sFrzkTjLXlulB+u4Z9ah5QkbNBn+AFNi9kAVxOo/oeFJCQiGYbyvDITvejDZzRbzt0K8/qixXKNCCR6Oe9ovIHjFG994ZrUSZ5nJ/4KzE7xeby0mfPaDwv4atHSvOMXZzffnpWGdcsg68S7DZ8C/R7mgDUcyxXD6Hfept1n8gUM2OSwn6J7+OJIoSgl1lCE4ARnw3gRlDYl5iHX9g52TvRaG7PmYPMkS2LTL5bwzr9m44JUwqNfYJ9og/PD/dmbIFh8TcWY1XPdAl9/158eiTUcRd6Fw++p+yibM9UKqJlEUeL72tJDixkWAk2E8cOphhqJdLG0r9Lxa4zcjzANohFlqE5vABkTHto+AATPyXf4MX18szg9fX023zjuadyxqtSE4F423YLIOaEEycf/J+qWz25b2tLAVgak6QV7JxFtUi5bt4184nP/kvXGCT5RoU+7a7pnJrd4MjAoJEP5mXRZj+vPSUsvig9xeaas68GGr5SR7U1nFURPMWgd0XtFP8iDf2rOryd6bWZbtP8rgCuAArqx5l3PvcGGoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66446008)(83380400001)(76116006)(55016002)(71200400001)(66556008)(8936002)(66476007)(4326008)(86362001)(64756008)(6916009)(2906002)(6506007)(38070700005)(26005)(30864003)(9686003)(508600001)(38100700002)(7696005)(316002)(33656002)(186003)(5660300002)(8676002)(52536014)(122000001)(107886003)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9/7fr26MLjp7rgcoeIryC96obregi11qh2t2sqt4p25JtrbL7KEoOLbbonZG?=
 =?us-ascii?Q?9CAeSxM0qlrniVooFhajXM/VxMmJF+20HtKpqIg3hu3TTFOeMTpGzDJKTUmA?=
 =?us-ascii?Q?eo527HJoF2HYWC1YC68i2AiiO5HSRpEnZPPFAH4G3WLO5mK4zppeNTr3YMQ/?=
 =?us-ascii?Q?stLXhkUsNp0Sn2UEnJJecYUXYr8CWWYh4baPQHjz9D/DkLz69sqrxNlgtYJs?=
 =?us-ascii?Q?P07x0IWXtbsvFXaJvBlFhMFa8sETSVAqppZYvQH7kxsdAfSn1GjOzsPGlPLR?=
 =?us-ascii?Q?Bzs2Sls3IG3kg3q3wXxLi1I9dEUOqStZpGFVp/RyPO23Q78f1+Uunw/1+Ynh?=
 =?us-ascii?Q?8ufaHSAfnYqQoOL8RPPmpTP+EWpEW/0+aNtUhiCMOnFhrV2g/MIi7ubgdHR7?=
 =?us-ascii?Q?dlFUVcfys8+AzHRortfxz+bft8uw0u9gR6FZOowW4Hy3uc0znbtZ625IBlFL?=
 =?us-ascii?Q?Z9Zl0bJRDRd3V6V+R4VWJcQU5td44C5Ss47zqJU7CFPX1iTyNKpmS6/+WLu3?=
 =?us-ascii?Q?pfLhQayi/jDMxE/BzfC2aNOs1sjMkptIpUgJCAcccz7J/parWgZsE974oIef?=
 =?us-ascii?Q?ERPcSMdcJc2kbHgJmPo85aHwnfdT3+7UEHSca7oUPu9+tkm1m17NAx5iB9g6?=
 =?us-ascii?Q?Vy1L0fC1n9KQpp59xHiQmDa9CRKgjT/3wAx/XrsMGycH4XS9a6hI4QnNQwI+?=
 =?us-ascii?Q?yJJzhtdHtfaSUmSKz++E7ZLHwU/i3WnXyOUTp+Fxk8Yt5sJA1AgLm/PWma8K?=
 =?us-ascii?Q?dZGALBcqAXJCV5waX7a+/RQbZEK331uuUmxXW6N8tqqMKXNlb0cATUrgQVqV?=
 =?us-ascii?Q?VHr+ssbq5/dxjSgnTDCUIzzx2NSJ3rqogOD7eK838xEhukqPiwaXVyBqCwIr?=
 =?us-ascii?Q?IPam/zSFAHRW/M6XloXPgAtB4P1+KQfL0ZwJyZxvqMtmNqOhwzzrQft8p/Vt?=
 =?us-ascii?Q?D+KpAToSzHa5XgYlVJoPjzoN9RbP1847nMmuM2ywd0dsAnjJYkPK/uoPI+F4?=
 =?us-ascii?Q?9MBxmUpOrkW9mCBzHTwjnJqFbb8ivZz4hfjm62ezFglquBeT4WcPFHFN17TP?=
 =?us-ascii?Q?urj/+tsYVSPnhdqD+LPMswgtQt9YMos3XgOgSyL0OTvRJJ3EgTNB9ITD9cSG?=
 =?us-ascii?Q?7HEfKZhlD7UqbjGC/P7wI4AUiGudBfn1H68nAU5uZqBN0qqJe7bTZ8/AwRy6?=
 =?us-ascii?Q?tuAnaJA7xdSJtkZ0xRPWGsslHvy2DGX3JavioRl9VH3NaIXQhchZ9bEdkJJD?=
 =?us-ascii?Q?4IfjLNoq/vKipmGOvtiOJ1VTRdfVY6QRiryV4+60zlgKgTkA/5v9ryooCK8D?=
 =?us-ascii?Q?UXF25NvAfrDoGwI3f0fO6CN+jdtaVUAMuMZ2VdtEOwJaovJFJOltZehhO/eQ?=
 =?us-ascii?Q?Q9Cfsn0c1OCc7hvKDiKBF/l6uLjrSNMIH6EsWd7D6FRrcO9EkLiIxqmvlXxa?=
 =?us-ascii?Q?oXnRTWjwi+CpxqDH8yNrDPIOeUqXMQSKKwwtrhY3vIMjSpl9IwirPSgoom99?=
 =?us-ascii?Q?AGbMCJO2GzoYWL6IsJmaPUPNB85dfQwe/ZgDt3YBxC+/Y91lPY+SAMtgQJbq?=
 =?us-ascii?Q?AllZsWOlv1aG+9JDrbGyf337My3oKxuD8QoMh7DbMy1SD78fPjfudFfjbQ3e?=
 =?us-ascii?Q?0ootB6Nx3x3ZCwG+xzm6/Cs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad93e309-0b46-4828-a588-08d998822cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 13:11:51.1642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zt6Ygqgj9tFcxfv7PHPgBjKMDnOHLv4/E6BtwBelroHceTYnMj8mD2MKH6rivg6ybWEvwV7XEceLqwzfv3oDdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, October 26, 2021 6:38 PM
> 
> On Tue, Oct 26, 2021 at 01:03:41PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > Sent: Tuesday, October 26, 2021 6:31 PM
> > >
> > > On Tue, Oct 26, 2021 at 07:02:39AM +0300, Parav Pandit via
> > > Virtualization
> > > wrote:
> > > >$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55
> > > >mtu
> > > >9000
> > > >
> > > >$ vdpa dev config show
> > > >bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
> > > >
> > > >$ vdpa dev config show -jp
> > > >{
> > > >    "config": {
> > > >        "bar": {
> > > >            "mac": "00:11:22:33:44:55",
> > > >            "link ": "up",
> > > >            "link_announce ": false,
> > > >            "mtu": 9000,
> > > >        }
> > > >    }
> > > >}
> > > >
> > > >Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > >Reviewed-by: Eli Cohen <elic@nvidia.com>
> > > >Acked-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > >---
> > > >changelog:
> > > >v4->v5:
> > > > - added comment for checking device capabilities
> > > >v3->v4:
> > > > - provide config attributes during device addition time
> > > >---
> > > > drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
> > > > drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
> > > > drivers/vdpa/vdpa.c                  | 38 ++++++++++++++++++++++++++--
> > > > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
> > > >drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
> > > > drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
> > > > include/linux/vdpa.h                 | 17 ++++++++++++-
> > > > 7 files changed, 62 insertions(+), 8 deletions(-)
> > > >
> > > >diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
> > > >b/drivers/vdpa/ifcvf/ifcvf_main.c index dcd648e1f7e7..6dc75ca70b37
> > > >100644
> > > >--- a/drivers/vdpa/ifcvf/ifcvf_main.c
> > > >+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > >@@ -499,7 +499,8 @@ static u32 get_dev_type(struct pci_dev *pdev)
> > > > 	return dev_type;
> > > > }
> > > >
> > > >-static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const
> > > >char
> > > >*name)
> > > >+static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const
> > > >+char
> > > *name,
> > > >+			      const struct vdpa_dev_set_config *config)
> > > > {
> > > > 	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
> > > > 	struct ifcvf_adapter *adapter;
> > > >diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > >b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > >index b5bd1a553256..6bbdc0ece707 100644
> > > >--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > >+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > >@@ -2482,7 +2482,8 @@ static int event_handler(struct
> > > >notifier_block *nb,
> > > unsigned long event, void *p
> > > > 	return ret;
> > > > }
> > > >
> > > >-static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const
> > > >char
> > > >*name)
> > > >+static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const
> > > >+char
> > > *name,
> > > >+			     const struct vdpa_dev_set_config
> > > >*add_config)
> > > > {
> > > > 	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct
> > > > 	mlx5_vdpa_mgmtdev, mgtdev);
> > > > 	struct virtio_net_config *config; diff --git
> > > >a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > > >973c56fb60b9..a1168a7fa8b8 100644
> > > >--- a/drivers/vdpa/vdpa.c
> > > >+++ b/drivers/vdpa/vdpa.c
> > > >@@ -14,7 +14,6 @@
> > > > #include <uapi/linux/vdpa.h>
> > > > #include <net/genetlink.h>
> > > > #include <linux/mod_devicetable.h> -#include <linux/virtio_net.h>
> > > >#include <linux/virtio_ids.h>
> > > >
> > > > static LIST_HEAD(mdev_head);
> > > >@@ -480,9 +479,15 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct
> sk_buff
> > > >*msg, struct netlink_callback *cb)
> > > > 	return msg->len;
> > > > }
> > > >
> > > >+#define VDPA_DEV_NET_ATTRS_MASK ((1 <<
> > > VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> > > >+				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> > > >+
> > > > static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb,
> > > > struct genl_info *info) {
> > > >+	struct vdpa_dev_set_config config = {};
> > > >+	struct nlattr **nl_attrs = info->attrs;
> > > > 	struct vdpa_mgmt_dev *mdev;
> > > >+	const u8 *macaddr;
> > > > 	const char *name;
> > > > 	int err = 0;
> > > >
> > > >@@ -491,6 +496,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
> > > >sk_buff *skb, struct genl_info *i
> > > >
> > > > 	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> > > >
> > > >+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > > >+		macaddr =
> > > nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> > > >+		memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
> > > >+		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
> > > >+	}
> > > >+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
> > > >+		config.net.mtu =
> > > >+
> > > 	nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
> > > >+		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
> > > >+	}
> > > >+
> > > >+	/* Skip checking capability if user didn't prefer to configure any
> > > >+	 * device networking attributes. It is likely that user might have used
> > > >+	 * a device specific method to configure such attributes or using device
> > > >+	 * default attributes.
> > > >+	 */
> > > >+	if ((config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> > > >+	    !netlink_capable(skb, CAP_NET_ADMIN))
> > > >+		return -EPERM;
> > > >+
> > > > 	mutex_lock(&vdpa_dev_mutex);
> > > > 	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
> > > > 	if (IS_ERR(mdev)) {
> > > >@@ -498,8 +523,14 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
> > > sk_buff *skb, struct genl_info *i
> > > > 		err = PTR_ERR(mdev);
> > > > 		goto err;
> > > > 	}
> > > >+	if ((config.mask & mdev->config_attr_mask) != config.mask) {
> > > >+		NL_SET_ERR_MSG_MOD(info->extack,
> > > >+				   "All provided attributes are not supported");
> > > >+		err = -EOPNOTSUPP;
> > > >+		goto err;
> > > >+	}
> > > >
> > > >-	err = mdev->ops->dev_add(mdev, name);
> > > >+	err = mdev->ops->dev_add(mdev, name, &config);
> > > > err:
> > > > 	mutex_unlock(&vdpa_dev_mutex);
> > > > 	return err;
> > > >@@ -835,6 +866,9 @@ static const struct nla_policy
> > > vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> > > > 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
> > > > 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> > > > 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
> > > >+	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> > > >+	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> > > >+	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> > > > };
> > > >
> > > > static const struct genl_ops vdpa_nl_ops[] = { diff --git
> > > >a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > >b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > >index a790903f243e..42d401d43911 100644
> > > >--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > >@@ -248,7 +248,8 @@ static struct device vdpasim_blk_mgmtdev = {
> > > > 	.release = vdpasim_blk_mgmtdev_release,  };
> > > >
> > > >-static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const
> > > >char
> > > >*name)
> > > >+static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const
> > > >+char
> > > *name,
> > > >+			       const struct vdpa_dev_set_config *config)
> > > > {
> > > > 	struct vdpasim_dev_attr dev_attr = {};
> > > > 	struct vdpasim *simdev;
> > > >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > >b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > >index a1ab6163f7d1..d681e423e64f 100644
> > > >--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > >@@ -126,7 +126,8 @@ static struct device vdpasim_net_mgmtdev = {
> > > > 	.release = vdpasim_net_mgmtdev_release,  };
> > > >
> > > >-static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const
> > > >char
> > > >*name)
> > > >+static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const
> > > >+char
> > > *name,
> > > >+			       const struct vdpa_dev_set_config *config)
> > > > {
> > > > 	struct vdpasim_dev_attr dev_attr = {};
> > > > 	struct vdpasim *simdev;
> > > >diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > >b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > >index 841667a896dd..c9204c62f339 100644
> > > >--- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > >+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > >@@ -1503,7 +1503,8 @@ static int vduse_dev_init_vdpa(struct
> > > >vduse_dev
> > > *dev, const char *name)
> > > > 	return 0;
> > > > }
> > > >
> > > >-static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
> > > >*name)
> > > >+static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
> *name,
> > > >+			const struct vdpa_dev_set_config *config)
> > > > {
> > > > 	struct vduse_dev *dev;
> > > > 	int ret;
> > > >diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
> > > >fafb7202482c..bf9ddf743e2f 100644
> > > >--- a/include/linux/vdpa.h
> > > >+++ b/include/linux/vdpa.h
> > > >@@ -6,6 +6,8 @@
> > > > #include <linux/device.h>
> > > > #include <linux/interrupt.h>
> > > > #include <linux/vhost_iotlb.h>
> > > >+#include <linux/virtio_net.h>
> > > >+#include <linux/if_ether.h>
> > > >
> > > > /**
> > > >  * struct vdpa_calllback - vDPA callback definition.
> > > >@@ -93,6 +95,14 @@ struct vdpa_iova_range {
> > > > 	u64 last;
> > > > };
> > > >
> > > >+struct vdpa_dev_set_config {
> > > >+	struct {
> > > >+		u8 mac[ETH_ALEN];
> > > >+		u16 mtu;
> > > >+	} net;
> > > >+	u64 mask;
> > > >+};
> > > >+
> > > > /**
> > > >  * Corresponding file area for device memory mapping
> > > >  * @file: vma->vm_file for the mapping @@ -397,6 +407,7 @@ void
> > > >vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
> > > >  * @dev_add: Add a vdpa device using alloc and register
> > > >  *	     @mdev: parent device to use for device addition
> > > >  *	     @name: name of the new vdpa device
> > > >+ *	     @config: config attributes to apply to the device under
> creation
> > > >  *	     Driver need to add a new device using _vdpa_register_device()
> > > >  *	     after fully initializing the vdpa device. Driver must return 0
> > > >  *	     on success or appropriate error code.
> > > >@@ -407,7 +418,8 @@ void vdpa_set_config(struct vdpa_device *dev,
> > > unsigned int offset,
> > > >  *	     _vdpa_unregister_device().
> > > >  */
> > > > struct vdpa_mgmtdev_ops {
> > > >-	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name);
> > > >+	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
> > > >+		       const struct vdpa_dev_set_config *config);
> > > > 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device
> > > *dev);
> > > > };
> > > >
> > > >@@ -416,12 +428,15 @@ struct vdpa_mgmtdev_ops {
> > > >  * @device: Management parent device
> > > >  * @ops: operations supported by management device
> > > >  * @id_table: Pointer to device id table of supported ids
> > > >+ * @config_attr_mask: bit mask of attributes of type enum
> > > >+ vdpa_attr
> > > >that
> > > >+ *		      management devie support during dev_add
> callback
> > >
> > > s/devie/divice
> >
> > I ran checkpatch.pl and also codespell for extra check. None catch it.
> > good catch :-) Do you use any tool or its your sharp eyes?
> 
> OK so v7?
If you prefer v7 for this small change, I will do it.
Will wait for little more before sending v7 if Stefano has any more comments in rest of the patches.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
