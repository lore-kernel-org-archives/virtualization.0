Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DA8CCA47B
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 10:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 37D9840139;
	Mon, 13 Jun 2022 10:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpv8rYgZ7YhK; Mon, 13 Jun 2022 10:56:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B3F51400AF;
	Mon, 13 Jun 2022 10:56:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D21AC0039;
	Mon, 13 Jun 2022 10:56:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D57F4C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 10:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B60D341581
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 10:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1AXv289bzBaI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 10:56:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::612])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16A0B40650
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 10:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EylFxeocHFTmXVT2OoIFuaCsdnhchTtaW0XFey5y7/OIUsTE4kYFWbJRvJ2cs9YROJWzIqUxch/+BRZ8mvPT2H5/j8FaLq+W/sLq6INbHzWFzc1Zad2buXPZ1vtxjIpb89Ni2deo0Q896R/Ew5mKj8kV8zXClSEZ9rhj4065TBq+ObWORdpcixXr2WQSmdiS/gtFoqZwaflH0V1DohRE+PFOon2Inwp7IX0gAS3foveepCxkSDfjSpiGo91jioHoxHk8zttwumxQ7y0XDeK5smobDVEBwPMCEP0VgNi5445MqtvHsJ4OSuBqEW9ZNbfgcho3q7FMMuxr/pFl2RTUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUcDXAWJpmpeTbrGidreG772nxZPl5kNXrV2Jz/BkRk=;
 b=Q14AGYbGV4aLPxCZ/sx8TFuWS89YSzpqKnpweu4nwMR7JLBzPgp96P85YtjzJnEbVdTOgGqiAMV9HuTvcFvN5WZaDWD9HL46tTq5YYJtOmUJji4WrV7RT2cCWXNYh7/Cn0usWU5AvVa1t4lCDjHJzyWrzfGJxszwH14eOrz+OqOuwrX2Wf3fJDYc2wadolSclOMW0z4TsPLy/9dl2MdIGNZr3Gl72lVDKqZ3J2JTDDqPW3IWLrqYflDMp2l8bWAUyofK0GkpTMyCy5s9gR4WivHQKwvHp2twraFzV9YyHEtLdu1AQeMHJDiaPQKqZQXxvnmyjK6a51DcukdQNDLpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUcDXAWJpmpeTbrGidreG772nxZPl5kNXrV2Jz/BkRk=;
 b=OOEYxR0JQ0sEq0nmYk4uKs4LVQy6lwN4/5c6b1qiMR/U2Q7KubnGC5MDVsgasU3k0OVp7WzR1dABjv6S85GkY+ddznPD8xb16izFxzuKrdJL1l1fdyRhcdjJHCPO3xEX2kWc2n+ZopNtm4UVsTtxihivcoZrrOqnEEKLyPwTPTpLGSscwQ57Q9M6FvaXFeleqFudmgXsUvIqEhP/w2w2remxlM/cO2wMEenL/bDdUGLVFVT6vqGoBwYsAnf/J2s7PC9sC8MoWAGzb1ko5lWLWTFOhxSJuJtVVlOjHj0fX/zZD6nty7rH1PsdxScQhsnTk1fQhjO8qYe3lIH1NLCsEg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 10:56:46 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e%3]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 10:56:46 +0000
To: Yongji Xie <xieyongji@bytedance.com>
Subject: RE: [PATCH] vduse: Tie vduse mgmtdev and its device
Thread-Topic: [PATCH] vduse: Tie vduse mgmtdev and its device
Thread-Index: AQHYfoanX8h8VX+eoEafCxiX4pE+Gq1NGeQAgAARL0A=
Date: Mon, 13 Jun 2022 10:56:46 +0000
Message-ID: <PH0PR12MB548120ADD904C733EEB1A9B4DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220612180158.462192-1-parav@nvidia.com>
 <CACycT3u5rc4H=+1Sdz9E8GEABdkuAeBQ73xw_TnBGWCWFM_3Fw@mail.gmail.com>
In-Reply-To: <CACycT3u5rc4H=+1Sdz9E8GEABdkuAeBQ73xw_TnBGWCWFM_3Fw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1424a93-2856-4326-b7b7-08da4d2b68c9
x-ms-traffictypediagnostic: SA0PR12MB4480:EE_
x-microsoft-antispam-prvs: <SA0PR12MB4480C77A8E9C9FF3248ACE2ADCAB9@SA0PR12MB4480.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZMWU/zPjMtgZafaWjYIt/LSt+2vK4PrJYs/K0aYyMlD2OYUHN3sBCh5A4ZsYjaCFSFyzU0eqFzb5ySaL7rBypyvs+RzpWpJ0sAkN2COWZF522DpnS/FPcDWrH67cs3Hz4qj1ZoonLKaKP/Toh8bOYbDwfGpZGvwgz8YQ2yx+579nuSPrNkmwBv7CXfJp0WqBpiRkDUvpBq9HOKpj/mfYr1OYcOsRzaigxlQv9vseMwguwf2C59E+hzMZ17vbjOGS6p2m+w8B2kJKLd7idkQJ80PNo2pxbx/yCMvQhPzvDhxY93g6xHD1Bs06mMKnA5vnJbnMNjbk/fiMzUj/+t0/lKBdBvQtdVjz4NBoEF2HkSEAy/sVDTD/tMq03u1ftGACvrbvvWIsAKymvDuCX+5R/guxGsIcKAziucFtcutLYt1TXWsgmRSECT5YFxx3hCFxgIZXqrI/wXIFjAqRp7EG8Ob1GXohrMnfT6saFxf0YxxzwI5ofTI9aJhA/1tGwNbcYVTNCzCNxK/JzMFbmvAFwwYJ/HIbU8TEp0JUDbOodSE0ScBwUskKEVtHm1Pb1IVAMJ8TWpZRM593KprX0kT4YmWs6bfN4Hffvl41vdhOkn6lXv/vnv01FMyEfl/eaH+ypgulobCY/r+qtwWrXVpcVvJEGcfI9XXJ9GMs3HoJ20a3iyXzsNugRczZmxJTUU8yvSuDykQdt38r5CdJ1nd1d6hbpLXhHt7rBsqbXgTVcT2EGsgPHPf1kWMUboSjP2QPk43oD6EsH4e4sPBpIuV9Z5JzMJANyp0zOi5Gmrky4A24ggOM3uLtFcDDXRUMCc+8karnFvpjrZmIbClfSt/+qg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(38100700002)(6916009)(316002)(54906003)(122000001)(55016003)(53546011)(55236004)(6506007)(7696005)(38070700005)(8676002)(4326008)(64756008)(26005)(86362001)(5660300002)(66946007)(66556008)(66476007)(66446008)(76116006)(2906002)(52536014)(508600001)(8936002)(9686003)(45080400002)(966005)(33656002)(71200400001)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o9ffroTvWTr/Q02szCQOLGVb7+nO6ZPbfjZP3q5k+BgchiJnQrvXJlW/v1W2?=
 =?us-ascii?Q?XHdVtOq507N/isYjj+jrTe86Ovb/sjazrDUEOPVM03nwpcdDTLzFu8Fv7+7z?=
 =?us-ascii?Q?6I576vrStxvntnP0/FXkSNUbi3OcVw7NEqa3HnDIa3SynYuaMMNgTcjskY+a?=
 =?us-ascii?Q?hu8eGKJq/qnr4yzeQHIJ/iKg1pJCPo3HeZA9G+IYnV6PxkbpK0EfA8WTEKDM?=
 =?us-ascii?Q?ILrx3B7dpHVzMW+wkU3mb2KmV7Wptn42+HoECdyeWfjH7dPPPLdUAO3vmOBR?=
 =?us-ascii?Q?IiZAfmpeV8DBK+Q9JHMeAnljihVfcgXBBraI7bPcaAjlBU4uXrCZcc9RkThp?=
 =?us-ascii?Q?fsd0saif6/J1N3Mch5vdmFueHT2rGkIUp42iFxZmibFEzphg4xaywkETt17d?=
 =?us-ascii?Q?qlSB1xwyjaJ+MKuU0DRxw/zNiYdryG9OvKNw+DAvh63cXrPBSGuxBPyipTl5?=
 =?us-ascii?Q?ETeqV2BYLGXELf0IuT5NNwjquCGTyrdMruWNOnMqFDFq3DSZYAiuNNphfyia?=
 =?us-ascii?Q?RMzMU21ZEYro/XzqDlKm01jkuQKlCiQeXeHOofcbs4ttt6g9G6LxdINSZ1Q8?=
 =?us-ascii?Q?w0HKV7gGGfWvPwb3lofqYBgcR4Gw4WnHYZATT34f5iyod3ny+SI4FrhkH9bP?=
 =?us-ascii?Q?UuDKWf/7IP1++ZchwzorIwtQ8zPFUQlEq1Zz95FV2Lj5fVsqgnlLSv2ZKbl+?=
 =?us-ascii?Q?e2fLfOaCDlXBYNnhpniPEouOjESv4QTvA5kjqNp4W2Gb0ECct4GOSxpWaSMX?=
 =?us-ascii?Q?PH0Wg7ssL+UWhU8jI0k3TWJRHCwShiFan+iHDS1Nc51QCLqKL43w+hv4DR4F?=
 =?us-ascii?Q?WKSB8d8H5auXQttaq2uxVrjmddkFTSRKT3faZfWpkH+JPP3ozuRsqtmZqq+e?=
 =?us-ascii?Q?c3jER0W8yln28ZwYvg8sVLsQR61MlY5Mn6iaf5SXufT/cYHxkY8cXaKGLEK6?=
 =?us-ascii?Q?xlG6/3Tp/zYL4K7HT85ZLPzaj0NPqTOWBRWRFcBWFtGw58oQwfS4EX3ybo+l?=
 =?us-ascii?Q?46T9Y9imOla3wRsaDll4LHazcmg1P+xMSpdtQZYaky6h23I6CmP/A4HDhytK?=
 =?us-ascii?Q?TBGKymOJ0RuUfHBRrhqciuIqVD3AH8Ri83FwNUcPN+4S2vxAMPNXeFtCqV1C?=
 =?us-ascii?Q?G61x6sqQcbMwihLLxODhV/65epp2G7prB5QhoiIslGQysGncMfY3nc4ceKRj?=
 =?us-ascii?Q?QqtRiM6ZqzYbdniQDwRlo2MfxhRPX+egWymAMWKtS1tmEEtA1pnK0Y/8FlAJ?=
 =?us-ascii?Q?dsFtJT6UBszD5NfAeIK3dFrfR7lhJoV5DhN7jgLzOL86ZQppXFUIpqOEO0bK?=
 =?us-ascii?Q?q3LkgyCmbml0q/FmHqrCjIf0C/FhlFClZBhAoZGzXjriWso/0E2qNoI7g+cF?=
 =?us-ascii?Q?3LqQQ6G6gttAHM3oQqKa0HkIpqnk8yO+uzDu7N1CMM7VY680RRL3ndjvNQDx?=
 =?us-ascii?Q?2devV/OaTYrsOBuFpksxErxMOlwv2dOZQ6LM5jnmObjxzHGqbvgYss4Nj7+7?=
 =?us-ascii?Q?KENniCRtphrXH6ryiF8ELu6fZyYoVh8lHSNAisFe8gD/ejBezwxRhjqUccm6?=
 =?us-ascii?Q?EaWKzoWTWTI6YKNPVhhPkvxYK4dR9fl6z4jtTD/ezQnicZS8uFMSuGim9FCM?=
 =?us-ascii?Q?xmP9u4VaGU6W8SUYUqofYeo4qxAGmASe80IFLBey87LNiVm48+GnDoqGtysJ?=
 =?us-ascii?Q?gv+w+7CQxO5FAVnq92yX1X9r0uZRKItoFsO8pkfp0M9EXZnAr0dcPkqKTjEq?=
 =?us-ascii?Q?hmw5YP27Ew=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1424a93-2856-4326-b7b7-08da4d2b68c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 10:56:46.3016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbJYnw52+RRLXBbEIf461+FmItEwohVe3ncU5NronZ5WGuaaBIhU3UPxKd12dHuViCw6kCnt/BouZnygOLjO4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
Cc: "Michael S.
 Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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



> From: Yongji Xie <xieyongji@bytedance.com>
> Sent: Monday, June 13, 2022 5:54 AM
> 
> On Mon, Jun 13, 2022 at 2:02 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> > vduse devices are not backed by any real devices such as PCI. Hence it
> > doesn't have any parent device linked to it.
> >
> > Kernel driver model in [1] suggests to avoid an empty device release
> > callback.
> >
> > Hence tie the mgmtdevice object's life cycle to an allocate dummy
> > struct device instead of static one.
> >
> > [1]
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.
> >
> kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git
> %2
> > Ftree%2FDocumentation%2Fcore-api%2Fkobject.rst%3Fh%3Dv5.18-
> rc7%23n284&
> >
> amp;data=05%7C01%7Cparav%40nvidia.com%7C6b16045f2b7a4e168bc008da
> 4d2277
> >
> f7%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C6379071076788198
> 90%7CU
> >
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1ha
> >
> WwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=G8R1%2BsfBPTe4P
> sOYqrv0pAhM
> > 3qFg%2F%2BWw7GmTli8%2BNNw%3D&amp;reserved=0
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 60
> > ++++++++++++++++++------------
> >  1 file changed, 37 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
> > b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index f85d1a08ed87..ebe272575fb8 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1475,16 +1475,12 @@ static char *vduse_devnode(struct device
> *dev, umode_t *mode)
> >         return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));  }
> >
> > -static void vduse_mgmtdev_release(struct device *dev) -{ -}
> > -
> > -static struct device vduse_mgmtdev = {
> > -       .init_name = "vduse",
> > -       .release = vduse_mgmtdev_release,
> > +struct vduse_mgmt_dev {
> > +       struct vdpa_mgmt_dev mgmt_dev;
> > +       struct device dev;
> >  };
> >
> > -static struct vdpa_mgmt_dev mgmt_dev;
> > +static struct vduse_mgmt_dev *vduse_mgmt;
> >
> >  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char
> > *name)  { @@ -1509,7 +1505,7 @@ static int vduse_dev_init_vdpa(struct
> > vduse_dev *dev, const char *name)
> >         }
> >         set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
> >         vdev->vdpa.dma_dev = &vdev->vdpa.dev;
> > -       vdev->vdpa.mdev = &mgmt_dev;
> > +       vdev->vdpa.mdev = &vduse_mgmt->mgmt_dev;
> >
> >         return 0;
> >  }
> > @@ -1555,34 +1551,52 @@ static struct virtio_device_id id_table[] = {
> >         { 0 },
> >  };
> >
> > -static struct vdpa_mgmt_dev mgmt_dev = {
> > -       .device = &vduse_mgmtdev,
> > -       .id_table = id_table,
> > -       .ops = &vdpa_dev_mgmtdev_ops,
> > -};
> > +static void vduse_mgmtdev_release(struct device *dev) {
> > +       struct vduse_mgmt_dev *mgmt_dev;
> > +
> > +       mgmt_dev = container_of(dev, struct vduse_mgmt_dev, dev);
> > +       kfree(mgmt_dev);
> > +}
> >
> >  static int vduse_mgmtdev_init(void)
> >  {
> >         int ret;
> >
> > -       ret = device_register(&vduse_mgmtdev);
> > -       if (ret)
> > +       vduse_mgmt = kzalloc(sizeof(*vduse_mgmt), GFP_KERNEL);
> > +       if (!vduse_mgmt)
> > +               return -ENOMEM;
> > +
> > +       ret = dev_set_name(&vduse_mgmt->dev, "vduse-la");
> 
> Do we need to keep using "vduse" as the device name. We have
> documented it in qemu docs.
Yes. I added suffix of -la while testing to ensure a new code in action.
I missed to remove it.
Will send v2 with the correction.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
