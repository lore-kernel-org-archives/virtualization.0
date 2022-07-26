Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AD1C00140
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 15:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A209E41198;
	Tue, 26 Jul 2022 15:54:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A209E41198
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qaSVPmxH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x3gAf7nv53FK; Tue, 26 Jul 2022 15:54:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F39BF40158;
	Tue, 26 Jul 2022 15:54:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F39BF40158
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0A15C0033;
	Tue, 26 Jul 2022 15:54:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1778CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 15:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF6B1415D4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 15:54:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF6B1415D4
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=qaSVPmxH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IdPa8HNOzsCZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 15:54:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2E93409ED
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2E93409ED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 15:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP11FBsbVBQU4dv1jY11pOyO7xONVuHbJrU0cbbHePZBGZRDv/PL4Isht4IlLHoi1IekrkoNfrFSwlWGuoOPX1UVrBTO6BhnPTYTVOlQuSWEuzrX4hpn1vjNu9KneNxkcTehrasm2sC7SUkYvWUqodmdQwc0Owes0n+HepZ8AtTHkv56vvIynUxH9tCtvcGb4gn6MB/9V21q/H0/wnp3nya3fMHNv8f2xmfKW1zC52gemojp5BPeuW0OdKk9JOwZ645ztz+MmePpoSnh5vwUOO6Uq2Yq6OoTlDBnlqZNm2gHKwvUSr2gLmHHyaR/hP2VY/ZsaZTI9qHd2mDh/MbDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUzlYRNnDZ/sXskDyrN8SzwuVYz3bLZ/r242GIoBQOE=;
 b=T5PvG75X37ucq78OyfCv1RY21r2gprzz8WRH+EOPmWaHkFtHcEjl44Z13BvWFR1X88B9QxgP58sI54RKPYuzmIlLh+XBRAC76oDkOUhEnDFm+7hbAS3QlsiNk38HNFf432T6Mik75LibMTT4EgdZU0TaeBHcKs9DTfMfD+dzN+d6Fjb3JtyE9oFVMIeUCiTvHTzqlOJku9NmaYOzdqEMlKdtHwfBecG9bP4gTbFYWzS+I4ikI43HiRRtWXyMRNfgI/5WJaYUriepd9yE8rvAhf/C7yiSdqh1rP841P+CypewubXijuOWaZGyAdyoDEKE0zhINemibx0m6TKdOn1NgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUzlYRNnDZ/sXskDyrN8SzwuVYz3bLZ/r242GIoBQOE=;
 b=qaSVPmxHaCWTEk5PEJaIKE0a6jPjbU9ulIxp68xWbciO3MmCSlA+m98EaaS+MrOgUOKSvz+aKnqm4GJ4HnngYMNMCeId6E213RwQUesT6pFYkD0A3NofihT0u0kqcoj+4bZEe4Zr6aJXjZv67ewXS+gQX45s/6kRL6SPZvg5j2JDF9JHslYnOiagcenJhcGZQGEX2lCW1TXVlj+vaKvxEBtLyZVa1Ap0PjT6FYA9IvqekY2Y/Pr9Z7s7APgPcNKT94Pm+E2YX0wnYyxV6P0w4I01RZfTDA23Pee+/LyopbdIvgumYZbCzOeP3t9ejFdhNxblgH0y+4kU6glQt+UBqA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 15:54:06 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:54:06 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Topic: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Index: AQHYjU+OpP/4aLhN20eCCMO4rbOEoq1qEloggBHFXgCAFRzTEA==
Date: Tue, 26 Jul 2022 15:54:06 +0000
Message-ID: <PH0PR12MB5481BE59EDF381F5C0849C08DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-6-lingshan.zhu@intel.com>
 <PH0PR12MB548173B9511FD3941E2D5F64DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220713011631-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220713011631-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da373e91-a014-4401-7a26-08da6f1f11ef
x-ms-traffictypediagnostic: MW4PR12MB6780:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: im5GzjBr5tNnSttLUBEPUxMO0uYGW/rBA0qHeU+Ag6EgQ+tTfLTxSD6ugADLpxOlYqWr6lzJN/9Rjze/WTnU6A4vVPRDuHuiqFN4UjvNHxLC1sNznkU0d7Oo/cZeAkmfah8vl8O3I3wZ0SYB59eCDZc1p3OqXq1pSh0IgmY5yTesOAgFVqLqvAAkvuOrXSmY6uFt20HwNSrINC8loCAkRBulkl+ssAikjIM5UxK8Zv1RA7rSEx3/K41wlYlXUZZOsWA8GEdYZvylbSFeblj56u8HMixTuVs/hokq/ABrspd6DnE3dI0jzNPQWWzoLie5LgnMV4dN+m4GohZYGjHp7rALE05s8jbXPJtJN8RahEsALYXvfg47tI4cl2KlhTJm39WC7lU7zAg+Bveey4rhdmKSnIaGLdzdnhgVRy8O1K2F5NJLmThjxnXTIZaIRTbt3fgDrq54Zk055iRyvolP8d2q/J9gcY4Qf+TFH0yl87kvp99Al7zzWI2AGWxHooRUvGaxkfaTuqyo0ozCHPzBPPnSqdUzakFJqY2XaCE2kd9nejArwK7S4d7Mj+9slM3NnhDKkZrysQE03uxubxjYpJajseAy5pklUH9ZbhjnRROZ53liwtrJX/1Ha7yrR5YrW6GRWRcXR51R3p+K0TPBi875sIq5z1Ks1erNKblsAP7HsyOj+EJ3WB2a/iHbqTBjg2YgGzsSYZcB5/onHXOO47jNFqjUiOjq1MNUiG2AkOOPtVgTjW9qPfpguxn0621qVEA/H1JtYuYbLAgeuErpf9HahIaMKxQNh6SddN9Tmwbq+zIMaiE7gD60LcgcNxGe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(7696005)(6506007)(9686003)(478600001)(316002)(8936002)(33656002)(52536014)(5660300002)(186003)(55016003)(41300700001)(71200400001)(86362001)(38100700002)(122000001)(2906002)(8676002)(38070700005)(4326008)(64756008)(66446008)(76116006)(66556008)(6916009)(66476007)(66946007)(54906003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EIvXjcrbquL1q33ABSCFMkGZCeflzQStcq4jMgMd4wwgN59ltHoQqBSRen7k?=
 =?us-ascii?Q?u+T1bkkk0Y4U5q4Fcig1lmYXXcTtWRVCP6yZ6EOSwueCsUNWICaxvoh3/m2Y?=
 =?us-ascii?Q?xypYb00Xa5SbhBDFSJ8toyfI2l95X+gmi61FyuthDN8AtU4BfiGe0KPbuFIA?=
 =?us-ascii?Q?nlTP2ZR6ybD18bVK8wQRU1wTRbaZPJ5aGkU09iKjc3UxCIOuu7ODMqvBmjvM?=
 =?us-ascii?Q?kPQyEsKmv4FR9diEHLn11EfCUed29EqZ20hjbW37A+gC4dNH44fGyUrS1RKR?=
 =?us-ascii?Q?m3059OXVUvv4t9lpBL9cSYRljJA9JOiE5Zaa++tC+n7TGDRcei+tkqLwN6XZ?=
 =?us-ascii?Q?0F8E1pKsL5ggtNL3cBlqXe2lDuTdaYv92vqSn3Jqc7nr5+An/T1vcObcRQOa?=
 =?us-ascii?Q?Hqriqg6xFE1DgW/v2HrW2aujLn6RjZRBo9cDBrqvSut/rUUrTMvUJaMXFIac?=
 =?us-ascii?Q?LPbmlbxysa9atvODSYuZaARJZEVzUOb4zNc5BspI5YomnA3l/bID60FwEK8r?=
 =?us-ascii?Q?jtQi4sjedyy5ziIpQ8vZrWbUjateikrvl0HzOGFZQXgncey4hdE1w5GZMFCD?=
 =?us-ascii?Q?/70BIsdkOxerVMVgXQkB2gxROqzCHnATfSBI0ccjYuIsPxOmvicnt1O+tgwx?=
 =?us-ascii?Q?3zv5paHvNUrDSYnhcEs2NELn5G5a4WEwRnQDT3TQnY3nYUQxowtNoIZeywCW?=
 =?us-ascii?Q?RFQQuzFTL/FDvNnFKXqF/POIc1T4JwUOKMGHnTU6GE/Hk/RTV7wECGVBBpE2?=
 =?us-ascii?Q?dR3QJcAKMLu03qqzsZJToViHjRKhJQW5IF6tC0Z9p2z8OwxdGremMlr+UMKb?=
 =?us-ascii?Q?H/4/LnxXyKaB2/DrezmtQzmlNZ7fUxpFmFmfzWRG2f5uwxyqINIPYQCg8Igc?=
 =?us-ascii?Q?/O2SzvaDD2wudm7gWMqfSb44/m3LExsvqsasMbKWes2h1MpDKlA5eN7CWGT/?=
 =?us-ascii?Q?F6wdsGa3omS0t7DtfTcJcXzagCDEhF//5TuzlDHhOJzfw4+lEQ8cP+g7ehkr?=
 =?us-ascii?Q?bfweSNCi8ryoHDwSGZTiF7TDrny6jBJ7RdxnKaKOHGMIiEy8l7pU0xN4wees?=
 =?us-ascii?Q?slVSUatr5aJvTsJmbQgqjc3BR72KD4w23VqYiY4LNHohEVxE8BxEmze4bhFf?=
 =?us-ascii?Q?xt0L78KgRd9ZHjadpr1sToVGwx41USjouJH1IUMhaEaF1Gc06lRQoD2ZGX7+?=
 =?us-ascii?Q?ftgLhHFOS//9OM5jDZhHfxIPDjk1rjQv1g8LfhdMDVUSdKhtwxUACpjVx3ms?=
 =?us-ascii?Q?0uPtzl90CfiqZFkZHMvwTClbLOKjPWXOReQVVdlQ1zFLMALE0U2IgjQNAeo8?=
 =?us-ascii?Q?Is3tG09TWnWHGjCZ3zgX6Rl8oTusPxtC0FOLQv+P/7adUPOCkZ4ZtmhKGOWf?=
 =?us-ascii?Q?1uhiRbsE24vBpCXS/dERm0k5QF/tviIM0Rb09Plf5nJKnwZmiRtzYqfgJwBh?=
 =?us-ascii?Q?rM0+4PWc9XgYYY2Gc4WgZmG0+ZUVvnzlmx+BmOTX8G5WAowF15hrYQbwVycE?=
 =?us-ascii?Q?/exlJLI76eTPNPvw3nL2iiqejbfm8lpLLCIswdyzAALDsP8bVrZxM3Yq+qgP?=
 =?us-ascii?Q?bT3QP9j1BIc+mQPTKd8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da373e91-a014-4401-7a26-08da6f1f11ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 15:54:06.1297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0+GXWiXcX73fIxRFQVJX12poq7yGXowKDyAVajMoN0NEja9CydUnv34aiw0b3uulra4M1EQGpQPmU5gj1XVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
> Sent: Wednesday, July 13, 2022 1:27 AM
> 
> On Fri, Jul 01, 2022 at 10:07:59PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Zhu Lingshan <lingshan.zhu@intel.com>
> > > Sent: Friday, July 1, 2022 9:28 AM
> > > If VIRTIO_NET_F_MQ == 0, the virtio device should have one queue
> > > pair, so when userspace querying queue pair numbers, it should
> > > return mq=1 than zero.
> > >
> > > Function vdpa_dev_net_config_fill() fills the attributions of the
> > > vDPA devices, so that it should call vdpa_dev_net_mq_config_fill()
> > > so the parameter in vdpa_dev_net_mq_config_fill() should be
> > > feature_device than feature_driver for the vDPA devices themselves
> > >
> > > Before this change, when MQ = 0, iproute2 output:
> > > $vdpa dev config show vdpa0
> > > vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false
> > > max_vq_pairs 0 mtu 1500
> > >
> > The fix belongs to user space.
> > When a feature bit _MQ is not negotiated, vdpa kernel space will not add
> attribute VDPA_ATTR_DEV_NET_CFG_MAX_VQP.
> > When such attribute is not returned by kernel, max_vq_pairs should not be
> shown by the iproute2.
> >
> > We have many config space fields that depend on the feature bits and
> some of them do not have any defaults.
> > To keep consistency of existence of config space fields among all, we don't
> want to show default like below.
> >
> > Please fix the iproute2 to not print max_vq_pairs when it is not returned by
> the kernel.
> 
> Parav I read the discussion and don't get your argument. From driver's POV
> _MQ with 1 VQ pair and !_MQ are exactly functionally equivalent.
But we are talking from user POV here.

> 
> It's true that iproute probably needs to be fixed too, to handle old kernels.
> But iproute is not the only userspace, why not make it's life easier by fixing
> the kernel?
Because it cannot be fixed for other config space fields which are control by feature bits those do not have any defaults.
So better to treat all in same way from user POV.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
