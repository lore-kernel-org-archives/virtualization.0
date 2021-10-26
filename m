Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09300C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 13:03:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFF160E74
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 13:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DFF160E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C1FD606E9;
	Tue, 26 Oct 2021 13:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JTxk2wdVkjTz; Tue, 26 Oct 2021 13:03:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A9ED260A35;
	Tue, 26 Oct 2021 13:03:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80252C0019;
	Tue, 26 Oct 2021 13:03:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34144C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15EDF401DF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JHqN6nfmbD8U
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:03:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14C5A4022D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1SgORTjKnt15njNIKGrL/cgS8IMDnbLl9d5b2rjzCbvhb/RnvNoqV5MCNsk/zQY324/odVt3JuVbMeJ2COTwRZueLTxfDGp13ZXBG9znRm+WthFof4faVasQWAdVR50qAr8dKngSOeb3tGalSyZ9IE6laI24O0kc09Om9lEo+a2PWW/+1A7h3kPT/sFdVQxzBxSODtAQSOh4DwsZOe5/B7RF28jnbGO03SQ1Td9vKaLV2e1WN031nJx9OSibvBfO1LfC7K/+QvhwShDYXO/7TrlWWAiBd3TBZsTxfMKtQvsHQVefdnMi4Ib0t23YOT8degXE1H6f8B/arI81FApNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP2ZyNaM/A511yectINc8whyxFMplevEvw9AdXyOFco=;
 b=AIu9CAM5DXH46yr0kd09YVaEDc/6wG6LN/G0yTMNJACbitgdtQBTg90na+dzdfbRWEEEwB70Ete8/J38E7G6N9u8h1rm52TwXMAcHJC2As6LufozWn6eGJ8Th5BmsmV/RRcB5WlHGd5zmqMsznCMuhKK5xAaur4/iDP3uUwwzyhFREaS7DOnP0am6XIkMqbVvYV+HMpVP4YmsAkHCvWNcgUFDucjh5PstavmuL/2J6FwLd+Ad4HLvVKjrcbVaxHHHFZelFoNiGS7W9TQxhPixoO9TWpNct/r5R2NjQrLdSjrj81pd2zi9QPmkA2vcN8GBUpr+I6oyEyxW/4jQig6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP2ZyNaM/A511yectINc8whyxFMplevEvw9AdXyOFco=;
 b=IsBR7E5cP+VzEvVoL3vlf/QHZ0Lr0PiS690cAawwlup8VIESX0/QcEfnPuI/a2vBZZWUntSzv+O2YnXFsR2GUKh7f3lL85E12AdgzjEhoDl5gzdNQL4TP4+7o+PkD9ECVTQU3OT+lsSYjHVgryWJFZzgQyrYnHS/TuvF/dddd0LK3XnUqPgqccolg1lGEgzsKW7nWuDAGLolIVEhnY+FI1SNhJ/Yf3j69IOQx+/TdHDNFT4xCt+HSGNAFrvMcIZTClVLJhfINo8wVfY3VVyvavfUJyz+dac4hFHk18vX2mMk3XAFtl2F2vNUyTGSgBzm1+TSTSbPg+LMTkto9/iIGA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 13:03:42 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 13:03:41 +0000
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: RE: [PATCH linux-next v6 4/8] vdpa: Enable user to set mac and mtu of
 vdpa device
Thread-Topic: [PATCH linux-next v6 4/8] vdpa: Enable user to set mac and mtu
 of vdpa device
Thread-Index: AQHXyh5n45HsjzNtQ02jNNEx/k02OKvlPu2AgAAAOVA=
Date: Tue, 26 Oct 2021 13:03:41 +0000
Message-ID: <PH0PR12MB54810B7BE5EDCA0934F88612DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211026040243.79005-1-parav@nvidia.com>
 <20211026040243.79005-5-parav@nvidia.com>
 <20211026130125.pxdg7w473xjuftz4@steredhat>
In-Reply-To: <20211026130125.pxdg7w473xjuftz4@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd666264-317a-4657-3d39-08d9988108f5
x-ms-traffictypediagnostic: PH0PR12MB5436:
x-microsoft-antispam-prvs: <PH0PR12MB5436F4DD5ED9D1032EBFE4F4DC849@PH0PR12MB5436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xTqa33i3Bvm5ohbyh9oXdERQClE2OLFUAWDaRTZy+vqKI8MRQxHhhGEIEEhiF2mHt2lsdWvOwVfs1SY7GsYQK+lxJY6Y64Mttk1FZb/2OsTekKEybi5XGqtKl2mggQq2Mel/WoBmauXTBFJBGj7V7yLnvCNl39I95GVqHtDWbU8PISbaSx1t0RSkBBRRl+YBZqvdD5xQDyI+kLHcygJUmI27GymfPm4W4tlPrjdIczUIvhq+cQ2Vngi/ijq5wK6ZA8IJWBL3HoSd+ndjbAkDjYy+nJ6vo0gtECoeYf6GXN0w0FMyETEl5ZgjPpsWASQULw/LzjG2riNiIZ2g8BjrxdksxTHg9HgvYQpjqBbwbzRhlwk6xsoVQR0n5Qcp9/uWnmJpRXREsHas1rgkGlbhfulFyIRQ7LGa4xyNI+e8eAYuv+1lNb3EgvKaxvRMr/486f+Rm2VKE5YK2+no4sdPtxXuYT9/+aqJBIVEEVI0OGBwCvJN4W3mgpSCV0Moim5FW+ukHUkqz8onJgJZIORc9Qg74cufFQTbHxDjs01qozBvzUm/v53BHcaEpPdCJ++38a8OBWPCEntTJl/rKhTplreqYZFHYqHH+f8QaxNpC53kHQidDyzrrIeZVTSLRIDBlFPW2V+ZtNiZyn7GYgZiyvTHgPTubywJXDkpT1IisVfI61Sri01bqKWM+yoyJqtckpqTxB/AtA8M3oBkoSjoTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(52536014)(6506007)(508600001)(64756008)(66556008)(66946007)(66446008)(66476007)(186003)(33656002)(4326008)(26005)(38100700002)(54906003)(9686003)(86362001)(38070700005)(2906002)(316002)(83380400001)(5660300002)(122000001)(7696005)(6916009)(76116006)(8936002)(8676002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HEfjmgpBE+Vj4RxBN5sMPKrjjygcaUIpXWUURBu2WlMj8w8RqfeUbRf0rEP0?=
 =?us-ascii?Q?ON4G57/Ug47pKGPdI4YJviER81NT6u8HSeuwrEF5218rwjfKLJuVXGTQ7610?=
 =?us-ascii?Q?hXWW7lqIqmYe7s2ZTp6lHVhT2oaqfIsdQ7gMY2fiRxyxrninkyf2EGzihgHM?=
 =?us-ascii?Q?Lyioa1dmzI/wR1JFkFn1MvwGbcxFWDjoj5fAdr+oPKxCgkVQczDKTpJZ3ja5?=
 =?us-ascii?Q?5do5gZBvJlg81PbUFjjSesGv0dzFfTdJK9Kex1S06RdUNCE29RU3HGWW0yQK?=
 =?us-ascii?Q?Q1hTLVHL36c1opXwS80mGhwwoMaR4yh0rVmHPLQcrNu6YRtJSUyjLudMRPv6?=
 =?us-ascii?Q?gRS5MTBHRmXSe6fcmW+UOsEQ/rnoy+dPlWBwlloj8OXOjmG9hrYcb5Uu70vN?=
 =?us-ascii?Q?ewpC2Zk+DBMnmvF8FjH9zlpZ2aSkSasF4LU2ySLY3g8zpw+GSCO1yJYVb3nN?=
 =?us-ascii?Q?Lob9KwskwIDkiJH7r6nAycaenC5hkqF48z0QbgtGoStFCvcddIRK9mKP56zS?=
 =?us-ascii?Q?Nkltsu2cTh0l4dZ/GTZaTZPqCQKDkIrn4RKH/+IRcs32oNhxbPE/LH9dU6Hl?=
 =?us-ascii?Q?cx1zJvvtqCBQJ39MsvkACD6WMQ/CGeH75tnxEAXSLP7kFL2ahOhfmiJJ8Wan?=
 =?us-ascii?Q?qTvLdmelHsQUkr5tDVznwhgnBhlfxjyMRIRUrHB1ZQrRgw5O9eZDzW4F1YSV?=
 =?us-ascii?Q?8h2NXZmRZv2Kd6LkMQBMaNYciuCV1KUPSQrXeWYoOCXrOeya4H51+1kSPkYl?=
 =?us-ascii?Q?X7LqYqJ9BD3mExCX1DXit7i/zIRiDGo0S/xR5/2Yy9iuWLhX4kVvftwWQu6u?=
 =?us-ascii?Q?T1FbGnzyeIALlcBSC5g/+BEABoE1q4jAKJ2/Y1g+Hd+jTJpM0NFbEp8+AR/+?=
 =?us-ascii?Q?oJku0cXnrhL9n9+g97NIi/iUunJqcBHuL3MjtsXEWJ74duFpUh10RJS3xjlK?=
 =?us-ascii?Q?2VFRJYMfh5/wdWx8zPt3qVr7MdaE+yFIyMaG5gqJ0HSS5i86Z0XI9rJCzz/1?=
 =?us-ascii?Q?WaqziTwx5W+3TCOT4SbAcyheSwI83sWqYcx3hhj7+vvUgW8BUvMbNQ9grICn?=
 =?us-ascii?Q?iGQb/NgYqarBrkQrVtzxz49HxyNiO3ujy4M6zoo2ExlUWTP0nAoLV4UxcbHo?=
 =?us-ascii?Q?eiSXGhRh6JxRl8oy0KcJRoOhPFtssM/FKF6qKPdxDtpAL7sx6znKp2O01HXc?=
 =?us-ascii?Q?VxDiP24ELxFlJSNAV7zBgtI1G11qXS7ncVdyH9Dxv7BJ7/YXa1ldbaT82Sk/?=
 =?us-ascii?Q?s9CV+5fPXy0PJiEcdZwN+xf0LytnxwT+WO8VMLjqC8ZYvJ4jFaUMLPojENw8?=
 =?us-ascii?Q?6rCx0BKfTnWLJar4z4ZHtOanpvQhIXMBzqpi/e+gPPKntDur0zOVRcLiW95x?=
 =?us-ascii?Q?s6agnf5yUUekTS+CWsR5ze71LGZNwOitNsX64mgpNGYFOok+H+Y7vStWc6gL?=
 =?us-ascii?Q?Q2VAOx56iyBlIv4BO+URz/uth4nvNPYxLZitD6ZUce5uLaXZnSmwG0RuJ5xH?=
 =?us-ascii?Q?7eavf74i0x63IUWzKk1CkK/XaDgWAYXbPA9/P5zeuLQgp7rxxykv0hfFq3qB?=
 =?us-ascii?Q?AXrBEkEmKSZ740HBHaL6VkGOiCFqiN/Ft7pLKU1lC9lOBOR7GOm6rUAr3Baf?=
 =?us-ascii?Q?VPy7/HRNT3JmWoQHBAW/qbA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd666264-317a-4657-3d39-08d9988108f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 13:03:41.6894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Erp3FU/2vxXpKRxL8/MJ552e7AQX82xMKg3Rhs9nBagofQQxm6MGp4HOs6KosKuRgqtKDbsznQ2Xe/Tc7VFw8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
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



> From: Stefano Garzarella <sgarzare@redhat.com>
> Sent: Tuesday, October 26, 2021 6:31 PM
> 
> On Tue, Oct 26, 2021 at 07:02:39AM +0300, Parav Pandit via Virtualization
> wrote:
> >$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu
> >9000
> >
> >$ vdpa dev config show
> >bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
> >
> >$ vdpa dev config show -jp
> >{
> >    "config": {
> >        "bar": {
> >            "mac": "00:11:22:33:44:55",
> >            "link ": "up",
> >            "link_announce ": false,
> >            "mtu": 9000,
> >        }
> >    }
> >}
> >
> >Signed-off-by: Parav Pandit <parav@nvidia.com>
> >Reviewed-by: Eli Cohen <elic@nvidia.com>
> >Acked-by: Jason Wang <jasowang@redhat.com>
> >
> >---
> >changelog:
> >v4->v5:
> > - added comment for checking device capabilities
> >v3->v4:
> > - provide config attributes during device addition time
> >---
> > drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
> > drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
> > drivers/vdpa/vdpa.c                  | 38 ++++++++++++++++++++++++++--
> > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
> >drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
> > drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
> > include/linux/vdpa.h                 | 17 ++++++++++++-
> > 7 files changed, 62 insertions(+), 8 deletions(-)
> >
> >diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
> >b/drivers/vdpa/ifcvf/ifcvf_main.c index dcd648e1f7e7..6dc75ca70b37
> >100644
> >--- a/drivers/vdpa/ifcvf/ifcvf_main.c
> >+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> >@@ -499,7 +499,8 @@ static u32 get_dev_type(struct pci_dev *pdev)
> > 	return dev_type;
> > }
> >
> >-static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
> >*name)
> >+static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char
> *name,
> >+			      const struct vdpa_dev_set_config *config)
> > {
> > 	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
> > 	struct ifcvf_adapter *adapter;
> >diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >index b5bd1a553256..6bbdc0ece707 100644
> >--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >@@ -2482,7 +2482,8 @@ static int event_handler(struct notifier_block *nb,
> unsigned long event, void *p
> > 	return ret;
> > }
> >
> >-static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char
> >*name)
> >+static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char
> *name,
> >+			     const struct vdpa_dev_set_config
> >*add_config)
> > {
> > 	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct
> > 	mlx5_vdpa_mgmtdev, mgtdev);
> > 	struct virtio_net_config *config;
> >diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> >973c56fb60b9..a1168a7fa8b8 100644
> >--- a/drivers/vdpa/vdpa.c
> >+++ b/drivers/vdpa/vdpa.c
> >@@ -14,7 +14,6 @@
> > #include <uapi/linux/vdpa.h>
> > #include <net/genetlink.h>
> > #include <linux/mod_devicetable.h>
> >-#include <linux/virtio_net.h>
> > #include <linux/virtio_ids.h>
> >
> > static LIST_HEAD(mdev_head);
> >@@ -480,9 +479,15 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff
> >*msg, struct netlink_callback *cb)
> > 	return msg->len;
> > }
> >
> >+#define VDPA_DEV_NET_ATTRS_MASK ((1 <<
> VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> >+				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> >+
> > static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct
> > genl_info *info) {
> >+	struct vdpa_dev_set_config config = {};
> >+	struct nlattr **nl_attrs = info->attrs;
> > 	struct vdpa_mgmt_dev *mdev;
> >+	const u8 *macaddr;
> > 	const char *name;
> > 	int err = 0;
> >
> >@@ -491,6 +496,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
> >sk_buff *skb, struct genl_info *i
> >
> > 	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> >
> >+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> >+		macaddr =
> nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> >+		memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
> >+		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
> >+	}
> >+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
> >+		config.net.mtu =
> >+
> 	nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
> >+		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
> >+	}
> >+
> >+	/* Skip checking capability if user didn't prefer to configure any
> >+	 * device networking attributes. It is likely that user might have used
> >+	 * a device specific method to configure such attributes or using device
> >+	 * default attributes.
> >+	 */
> >+	if ((config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> >+	    !netlink_capable(skb, CAP_NET_ADMIN))
> >+		return -EPERM;
> >+
> > 	mutex_lock(&vdpa_dev_mutex);
> > 	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
> > 	if (IS_ERR(mdev)) {
> >@@ -498,8 +523,14 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct
> sk_buff *skb, struct genl_info *i
> > 		err = PTR_ERR(mdev);
> > 		goto err;
> > 	}
> >+	if ((config.mask & mdev->config_attr_mask) != config.mask) {
> >+		NL_SET_ERR_MSG_MOD(info->extack,
> >+				   "All provided attributes are not supported");
> >+		err = -EOPNOTSUPP;
> >+		goto err;
> >+	}
> >
> >-	err = mdev->ops->dev_add(mdev, name);
> >+	err = mdev->ops->dev_add(mdev, name, &config);
> > err:
> > 	mutex_unlock(&vdpa_dev_mutex);
> > 	return err;
> >@@ -835,6 +866,9 @@ static const struct nla_policy
> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> > 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
> > 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> > 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
> >+	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> >+	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> >+	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> > };
> >
> > static const struct genl_ops vdpa_nl_ops[] = { diff --git
> >a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >index a790903f243e..42d401d43911 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >@@ -248,7 +248,8 @@ static struct device vdpasim_blk_mgmtdev = {
> > 	.release = vdpasim_blk_mgmtdev_release,  };
> >
> >-static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char
> >*name)
> >+static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char
> *name,
> >+			       const struct vdpa_dev_set_config *config)
> > {
> > 	struct vdpasim_dev_attr dev_attr = {};
> > 	struct vdpasim *simdev;
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >index a1ab6163f7d1..d681e423e64f 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> >@@ -126,7 +126,8 @@ static struct device vdpasim_net_mgmtdev = {
> > 	.release = vdpasim_net_mgmtdev_release,  };
> >
> >-static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char
> >*name)
> >+static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char
> *name,
> >+			       const struct vdpa_dev_set_config *config)
> > {
> > 	struct vdpasim_dev_attr dev_attr = {};
> > 	struct vdpasim *simdev;
> >diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> >b/drivers/vdpa/vdpa_user/vduse_dev.c
> >index 841667a896dd..c9204c62f339 100644
> >--- a/drivers/vdpa/vdpa_user/vduse_dev.c
> >+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> >@@ -1503,7 +1503,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev
> *dev, const char *name)
> > 	return 0;
> > }
> >
> >-static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
> >+static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> >+			const struct vdpa_dev_set_config *config)
> > {
> > 	struct vduse_dev *dev;
> > 	int ret;
> >diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
> >fafb7202482c..bf9ddf743e2f 100644
> >--- a/include/linux/vdpa.h
> >+++ b/include/linux/vdpa.h
> >@@ -6,6 +6,8 @@
> > #include <linux/device.h>
> > #include <linux/interrupt.h>
> > #include <linux/vhost_iotlb.h>
> >+#include <linux/virtio_net.h>
> >+#include <linux/if_ether.h>
> >
> > /**
> >  * struct vdpa_calllback - vDPA callback definition.
> >@@ -93,6 +95,14 @@ struct vdpa_iova_range {
> > 	u64 last;
> > };
> >
> >+struct vdpa_dev_set_config {
> >+	struct {
> >+		u8 mac[ETH_ALEN];
> >+		u16 mtu;
> >+	} net;
> >+	u64 mask;
> >+};
> >+
> > /**
> >  * Corresponding file area for device memory mapping
> >  * @file: vma->vm_file for the mapping @@ -397,6 +407,7 @@ void
> >vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
> >  * @dev_add: Add a vdpa device using alloc and register
> >  *	     @mdev: parent device to use for device addition
> >  *	     @name: name of the new vdpa device
> >+ *	     @config: config attributes to apply to the device under creation
> >  *	     Driver need to add a new device using _vdpa_register_device()
> >  *	     after fully initializing the vdpa device. Driver must return 0
> >  *	     on success or appropriate error code.
> >@@ -407,7 +418,8 @@ void vdpa_set_config(struct vdpa_device *dev,
> unsigned int offset,
> >  *	     _vdpa_unregister_device().
> >  */
> > struct vdpa_mgmtdev_ops {
> >-	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name);
> >+	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
> >+		       const struct vdpa_dev_set_config *config);
> > 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device
> *dev);
> > };
> >
> >@@ -416,12 +428,15 @@ struct vdpa_mgmtdev_ops {
> >  * @device: Management parent device
> >  * @ops: operations supported by management device
> >  * @id_table: Pointer to device id table of supported ids
> >+ * @config_attr_mask: bit mask of attributes of type enum vdpa_attr
> >that
> >+ *		      management devie support during dev_add callback
> 
> s/devie/divice

I ran checkpatch.pl and also codespell for extra check. None catch it. good catch :-)
Do you use any tool or its your sharp eyes?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
