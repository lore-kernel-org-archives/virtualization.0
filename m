Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF61C00144
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 20:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6BBA6058F;
	Tue, 26 Jul 2022 20:53:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E6BBA6058F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lIuvizO7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VsCdfdSBQ1By; Tue, 26 Jul 2022 20:53:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 73B07600CC;
	Tue, 26 Jul 2022 20:53:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73B07600CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43070C0035;
	Tue, 26 Jul 2022 20:53:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EDA2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 20:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEDDF80B77
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 20:53:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEDDF80B77
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=lIuvizO7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bbm7BLnNWugZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 20:53:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C084780B71
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C084780B71
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 20:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjUCMsm9yrLRPLXqyea8K6+jdxwzNGW9j4jXpaho9CdFLbz7/lAdWoUOdlEzk2pLwcdK3olowl6uNnMOjTrHV6SEzMw+JlXN8HNz6C4VVSFhQibST7KlA4WWmAs75hoBNTNlr+TN3nzerhQ1SmvdC3BBEjfNSygcu/xju3r1knDTrupIDqs6kqdfEDJKaNv2DNAU0/c0MdEi5/4OiyhnpuHggtZOqlghCqUMeuczpek8Liw61Ei5UfQQA4tR78JPRuSRqDeDmlaIw1jZdEbBfHubH6nza/opkoG2Sayf8z0D8ePtLbtREVu+qec8X9AWKZJRpmQaDa/h1aWdkNhjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1/LVE8s/2AGUXjy6KG7SzTTkMrqkNKEV5NPZnl+Lg4=;
 b=X89exlpa34x/3UwOs0CYrwa7qOerMmeCauMzeqiJQHC299Nxu2hhyrypJ7mmyvSpV8lpUNbgu1rWtHSIgbEvfJg8NvoIlGj4ULDpmRLQgKYa3ycI54I4/dKPetvCgCkPkNqeiV4joKMSxIv4O1FoMd6qIV1MYomy4qe5DxJONG+Inc9F+JKJVFQJLwy9EcYVVf2L2QlMv8uyYJbvX1jS4uBWJWUcH3ROuKhrBp2e5/iriSSVGaEUl6DgpIgtrxqOOCj5azBPWHntb1maMzugOJjAm+sa+3Kok/ypNnGPs5eVmt929H0ykPFgHtfCe3pDG2/41G6y+9bjJdwOl7cfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1/LVE8s/2AGUXjy6KG7SzTTkMrqkNKEV5NPZnl+Lg4=;
 b=lIuvizO7VuS8Ohu4QZIoj6d7zrRp9yDnZzaeARNKrqaAmRdsWALRBUMkK75dhQJEnQM0i5nYKoa7h2ecHvjdyOdCrmoNiGCDQmYNfkM6omev6CG9sPlsjYQSkYP3B5JSKVXWDVLrUxPfdGuAa9ofyqJ0wgIuYbHNFgNTTNNGgRjgkUlVW/3CYsCydVSSzbPuo476e9659CCws7IN8/3mYOtD0mpGd1cFQOImBAIsxyPDlTrFo8ABmwLcQMtKHpBz/DKTBkAsNRlBuOxRRJIHN0Cpbap3MRsygfmu9qfnmfXbZ7l43oo7ErUJzpbxphCNmltmR1WI3gzijyI5Jb9r6Q==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN7PR12MB2689.namprd12.prod.outlook.com (2603:10b6:408:29::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 20:53:29 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 20:53:28 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Topic: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Thread-Index: AQHYjU+OpP/4aLhN20eCCMO4rbOEoq1qEloggBHFXgCAFRzTEIAAQkoAgAARLFA=
Date: Tue, 26 Jul 2022 20:53:28 +0000
Message-ID: <PH0PR12MB54811EB71F4D9C32DA2D6F02DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-6-lingshan.zhu@intel.com>
 <PH0PR12MB548173B9511FD3941E2D5F64DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220713011631-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BE59EDF381F5C0849C08DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220726154704-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220726154704-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68529ff2-8d3c-4825-e0a3-08da6f48e46d
x-ms-traffictypediagnostic: BN7PR12MB2689:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxlLnXJ6GZXRdpQQVfHlIEuK30sjuYqfqLdlaOBL5uy3AwAzb5JMO3g72JWgOqXDQUjW27wMKRl8MJHzgejE1dy7MA1ZZC6wwrotEFlQo4EHlQ2fH5CncX+i/Hw11RytuuJEMG3LCjxi5cKQ4rthZAmykMBL+Rl8oTDOqKMbCIeZQlzdvZqSjLwBj5222wePD1qypEz1fobg1wfY5mbQwu9Tr/gvJ1ayOhUbcer6QNCtNYyg2Ri+3W7L6cMN3YvbUyJ+HsBxeSl/XfnZ0Iu1vjDKH5Z8CDKfJ8oCy2phdwg1XUb7MKddcpIYq6NHHC4v5gMsU4uw4ZSFPAm8OpZLi3dMNtoSYD7G9SFtm+7bjzwH/7xHcvBVb+lMFbFgrEOQpjtUjQlDOlupvDlqmVqfhEXc7RFyOgpxhrAkVeXBRjctsicaufPOEVfJBEWvezxxxlCwxhSWq+M9SK60+x3YXBGEMFCXGpqrjM2Hl8zgkBGR6vKYVhC3oteXe3Pt2O7TGCxfdn99o9fIG9BM46bwzVIHK4d39BAP0oSmyriZNRqOXuuF05pzUSOcMP5OP7Ln/LdxkeuXB2xrd5zMoqd8CWLHwZaea6xY1DeSe0hKpOPKwvQHetzTqGsfd3iaCxcIlWwcNEcWO1tBMAF35pE8snz+pkUkNSBUf+OKPkT6hhQzHtT523nSUNepI3qXSsl+IL6c7gE/8n/10fxhOO4wC1A/Ny2a7FbwBFJ0iRbyVIuBWDmc8dqW9aIl1rSWBz50t4zOlECrzAoBph1LcytAIhlw0Vn29I7szNkKHSMcp44bmCxOy6J+Ac7Pb4RUfsYL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(55016003)(8936002)(9686003)(26005)(71200400001)(66946007)(52536014)(66446008)(4326008)(8676002)(66556008)(66476007)(76116006)(33656002)(478600001)(6916009)(54906003)(64756008)(6506007)(7696005)(316002)(122000001)(41300700001)(2906002)(86362001)(186003)(38070700005)(5660300002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/tm1kE5pD9Q4PWWPW3Fw61NjN2K4/28gmpAxb9Aa4foW1LwbgH2mefsTe85C?=
 =?us-ascii?Q?u/wSzVGCUF+tLDE1aBlk3VZVBsraiIYREZJNedIWhoALlkN7digpAs3y/F89?=
 =?us-ascii?Q?e03QEaVZ5Cwg/RUYrB/rcAgRB72JkYF1lyE4bHCv6UjM8b82IOsaByCpBQF8?=
 =?us-ascii?Q?+3mXK2v6sZCBHNBoKT5VU6GR6hbijdswypEwV9LyrwQI9LrM2Fpj9KmIOOzV?=
 =?us-ascii?Q?/jMb0ILyGtHPfgERPt3BdOfxVdO9XmtlJ5Fo7fhgXKuZF7yymeJD/eDJ+STb?=
 =?us-ascii?Q?pmgEFikL3TZx4Mu7o8ZMxbEpKi6eSWi98Tj4X84xxDcJxlAbu4FAa7SyfzHh?=
 =?us-ascii?Q?KtH8TA/hSerOeZDBFWJroRVSIezpyoSkglvBWM2R3oVo5p+JsDCCJKoZ5gaT?=
 =?us-ascii?Q?7FzQD/FvkVSRyl20JPikyjWJnWh9pDl5cbvcSL1PE8GuSCllc5ZdsB3PQHLY?=
 =?us-ascii?Q?cxe7UL32cq90m5WOvhGSRF31kF9cHqsEGRgfuiNt78Hcxyjvc0wveH5abCdU?=
 =?us-ascii?Q?TKYwIDwI0crgCd2WVSsyV5eP1b8ac9zJe0vnLFvDZJNjCd+QM6D72wX7uVUW?=
 =?us-ascii?Q?kQxRVRl2d17F4FtG/6PSXsEORrF2QqSMeRfC1SGwRVM5AcwRigrgb3Byki9Z?=
 =?us-ascii?Q?oEl/8ZdrM7+nxfmzyCmeazNRtCjK9i/hBI9Bftd9RfOzSvaoz1K0vYqaPNtq?=
 =?us-ascii?Q?y2wvLKQue96B3jNhnZLn4ZmpVEY2E/4hXlRf+g4lAX8AkdlRKjrI+FzTKrXn?=
 =?us-ascii?Q?NltDHtMRbx9OD61O69kOv6k/Eu7QymuzO2WH/cMuZl6DKKNKKNsfxHMqwJnt?=
 =?us-ascii?Q?osd4QGytmsFNTm4DJ4IfZotSyOFqlK6Skdu3an4zmoeKVRKFvtoEMJwVAZPd?=
 =?us-ascii?Q?f+IePQy2Xxoj8dduhqV7h/YVzmLPZriyt5i0cGVAsBHRWI8hcR+HMyejV5Rj?=
 =?us-ascii?Q?lbwAJrH8qCWVJALwcxzzic21KuhElkEcZlM9FPTgSaXT+uiHTidpxWTPwrZU?=
 =?us-ascii?Q?q7tQv6x7MEw1KsVHl3DNUtczTh68TSnj0Y1gxAYpgfOKf+5wtyPqH0FbyE0Y?=
 =?us-ascii?Q?GshfIfTo1gMZpC9dWWt5tWW7p5snRCdNalXrCJqzm3GP9R5vzysr6r68Pcf/?=
 =?us-ascii?Q?RlnjZDG38/Im/x/W58Xe7C6ORwuxHK8E+IPG1RnSdZF+jhfswtuqFVMSaG5D?=
 =?us-ascii?Q?iPwLfLTotaAqvl5E0Jhdp/+f7spjIOFLM61Y+647QipRVnqszr/ZfNuTTEfN?=
 =?us-ascii?Q?DLZmWbt8RIVYGmvWLPZVLMsxcoecBhwLX2GwHgtRFS7GCPm8PXMTC0jK8xVY?=
 =?us-ascii?Q?eTOJy1rcaMsr0FlBZHGimqUy9CQ2UuTvNUx0spbMwG0h1hxMzM0mCRYS0BJG?=
 =?us-ascii?Q?iH24dKdLD/QzGU45lvVfIwDPqx90bjqabxg1MouLW//5wWTs+a/yKooWrvhs?=
 =?us-ascii?Q?l8rxcbfXsnY9m23wRxbGwnvvLIj4FhrhBygrxcObqcCkQPMk/QyCFcMPNXt0?=
 =?us-ascii?Q?Y+xhhar76XvdBo6hoxfnxeM6ts3Nj/GfA9VZ3X8lxF10di3fGhSedx5DixJR?=
 =?us-ascii?Q?/RS7uu5vvFaAmWml7lc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68529ff2-8d3c-4825-e0a3-08da6f48e46d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 20:53:28.6924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBPwX9wII+5EpvpVXN1lgf2a9nUO27hpaErIRdFc20seEl9UAJbIKLGhyLgWPsk+GIOznAQ2UH/UugQeHdLkNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2689
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
> Sent: Tuesday, July 26, 2022 3:49 PM
> 
> On Tue, Jul 26, 2022 at 03:54:06PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, July 13, 2022 1:27 AM
> > >
> > > On Fri, Jul 01, 2022 at 10:07:59PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > > Sent: Friday, July 1, 2022 9:28 AM If VIRTIO_NET_F_MQ == 0, the
> > > > > virtio device should have one queue pair, so when userspace
> > > > > querying queue pair numbers, it should return mq=1 than zero.
> > > > >
> > > > > Function vdpa_dev_net_config_fill() fills the attributions of
> > > > > the vDPA devices, so that it should call
> > > > > vdpa_dev_net_mq_config_fill() so the parameter in
> > > > > vdpa_dev_net_mq_config_fill() should be feature_device than
> > > > > feature_driver for the vDPA devices themselves
> > > > >
> > > > > Before this change, when MQ = 0, iproute2 output:
> > > > > $vdpa dev config show vdpa0
> > > > > vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false
> > > > > max_vq_pairs 0 mtu 1500
> > > > >
> > > > The fix belongs to user space.
> > > > When a feature bit _MQ is not negotiated, vdpa kernel space will
> > > > not add
> > > attribute VDPA_ATTR_DEV_NET_CFG_MAX_VQP.
> > > > When such attribute is not returned by kernel, max_vq_pairs should
> > > > not be
> > > shown by the iproute2.
> > > >
> > > > We have many config space fields that depend on the feature bits
> > > > and
> > > some of them do not have any defaults.
> > > > To keep consistency of existence of config space fields among all,
> > > > we don't
> > > want to show default like below.
> > > >
> > > > Please fix the iproute2 to not print max_vq_pairs when it is not
> > > > returned by
> > > the kernel.
> > >
> > > Parav I read the discussion and don't get your argument. From
> > > driver's POV _MQ with 1 VQ pair and !_MQ are exactly functionally
> equivalent.
> > But we are talking from user POV here.
> 
> From spec POV there's just driver and device, user would be part of driver here.
User space application still need to inspect the _MQ bit to
> 
> > >
> > > It's true that iproute probably needs to be fixed too, to handle old kernels.
> > > But iproute is not the only userspace, why not make it's life easier
> > > by fixing the kernel?
> > Because it cannot be fixed for other config space fields which are control by
> feature bits those do not have any defaults.
> > So better to treat all in same way from user POV.
> 
> Consistency is good for sure. What are these other fields though?

> Can you give examples so I understand please?

speed only exists if VIRTIO_NET_F_SPEED_DUPLEX.
rss_max_key_size exists only if VIRTIO_NET_F_RSS exists.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
