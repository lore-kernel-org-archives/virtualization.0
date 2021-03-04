Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F197C433E6
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 05:58:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF14E64EF4
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 05:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF14E64EF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8BB1E43191;
	Thu,  4 Mar 2021 05:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0UEe5mgY4Q-6; Thu,  4 Mar 2021 05:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0044B43193;
	Thu,  4 Mar 2021 05:58:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84768C0010;
	Thu,  4 Mar 2021 05:58:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7F93C0001;
 Thu,  4 Mar 2021 05:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C53B284339;
 Thu,  4 Mar 2021 05:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDqO3MqYYFkn; Thu,  4 Mar 2021 05:58:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9122B84311;
 Thu,  4 Mar 2021 05:58:30 +0000 (UTC)
IronPort-SDR: Cn3kvu8uOx6R3ERxpM1VMpQOf591PxbqeQrfdplWUBw/ADMK1LBdylZY175skyoEOmEp0gYIWI
 WDNX6eujdqeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="184936802"
X-IronPort-AV: E=Sophos;i="5.81,221,1610438400"; d="scan'208";a="184936802"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 21:58:29 -0800
IronPort-SDR: Q/NHB0Yoz6gyDK7pW0hIBip1/JqAaK9fRe5D3wii0J/9PjfWoCOBJ2+3CYx3rh6Tq30WG8oyIX
 5+QJARIUE+TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; d="scan'208";a="369636828"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga006.jf.intel.com with ESMTP; 03 Mar 2021 21:58:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Mar 2021 21:58:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Mar 2021 21:58:28 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 3 Mar 2021 21:58:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3tdg9hG2oMPpGd0ruZkJfltHtLtvcE0G6Lle2Hg8ebbeB1AzgTtGq16iK3feUfWR/yirh7L2d1WBQfq+8+bCKcna64bkVnU+SM74L/GvevgmAjqK6BSxiALazlhGvHNP8eLhVQ8SxQd2z6kVidCM++DGKx5W684CpBV494IPVPqhz09732EcJhnisa1/RUNFnOUeG1VgtHFVSGrL/r+D/AR9kruDt704dQ8HRleRqA+V4xBYUdf8svHlp/jsL1HkmB0q9jBi0NWvF54Ro5fK36/znqVIEK5FpUaiW3j35KMaUJkz7SJEd6eBhElvxqbLy51Fs7D25LuM5Ok9jD5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOYjRrzb+fEPaG8i9saTDMi6/h5DwGiAmODt5bCncCQ=;
 b=hmdAnBvzlPPCop6I3nYDRZHspZisI7oXjb9iZrI/zxrcmzgv3vS2YmwJe32xwXMYLXzj3AzrcEUHIf0CWAR7cHC03/+Hhg2J13WfaxfsOlyj13OqP2slp2J9/z2LshjM1/GA4V70XBu/zcLDUvu89ErUhEWM89KJQlSvDQ5XGKF5dGg1WBSJcDqBEU5fR2f/2zib2qOqKGxuRPrg1xfEbRIl3jIHJcVWCzli40TPJWOs+oOeRqB0iuJPBpdwLn1Gu9hClOHcszZA055SjyH3/ukoQbJBvvJ8kHUzolNNNAqTEDKze9ec3PL9rYuxC6fR7zLA7L3EF1ZNRsTlt0KdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOYjRrzb+fEPaG8i9saTDMi6/h5DwGiAmODt5bCncCQ=;
 b=l3x4dZWmBjr977vd9ykZ2UklJnNGtJr/EfuBSz4NsXGeu2m0//Hm/YQLOcc4mwOiuxl75XIThaxVc2RenTJu1fI54dxPrwa/I+pIcTLgJuaX2K7kCKfslEd9wj/3yAsqqcJuIaACcbU1cfTi2RKV+LDVGyIiO/RCD0ULvlre2vY=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 05:58:27 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3890.031; Thu, 4 Mar 2021
 05:58:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Vivek Gautam
 <vivek.gautam@arm.com>
Subject: RE: [PATCH RFC v1 12/15] iommu/virtio: Add support for INVALIDATE
 request
Thread-Topic: [PATCH RFC v1 12/15] iommu/virtio: Add support for INVALIDATE
 request
Thread-Index: AQHW6zgLG401/TrBskO19/88pi8guKpy36oAgAC/ouA=
Date: Thu, 4 Mar 2021 05:58:26 +0000
Message-ID: <MWHPR11MB1886860008D526446026E7E58C979@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-13-vivek.gautam@arm.com>
 <20210303102848.5d879f0e@jacob-builder>
In-Reply-To: <20210303102848.5d879f0e@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b10820fc-f437-49c5-a6cd-08d8ded2877c
x-ms-traffictypediagnostic: CO1PR11MB4865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB486597FB4BE9F3B15CB714378C979@CO1PR11MB4865.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1GSP1HUHfMgjKAiZay6V7iablJwnz9d58iDfgGewagRAdpgS3VZLytBmjjoMfDo5oQhpDlZ24V9dFMNuXQ7952EBTOhPmYiE/Jh5Yvpmd5GXC5gA9b0TPzpPgULNDb/oSIMyLTOKoUUpsTwjFihaf1zs8ckiAGUq2N+eNJHpov3Bdrbq2lm/YktRf7DhzxDWz69Af2dWMI4hTicXEGTqfkOU/ZuPfsqpr9zPv87/CSgFvRur4bn41lA8wEMfsFrXcUtzpfQx+Sgp0XOiwslW4RDCa4YootLQhO7N5mwdIkvWIl6lGokWPSHEfCin+dE5DNkpBXtDXnynyZDQ93Z/c8e/HU0IJVRFrG7XNmAhnWMcM9PiRpRsQjIKM2k/tU7OGEM8sPyoAunaYQWoGFn6JJZgd4gEBQ/qvP4ZkT7kV10gyHcwirTuWLDDIO3KbTg8zC5lBpUimwf8T0XDcV/DYEOrkCvTTiqBZoz1CeDSRbDCdiVW2EwUedY4tOSVmXOHlj2fWoFJ4lHYLUwhLeDcw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(396003)(39860400002)(346002)(376002)(136003)(316002)(86362001)(110136005)(54906003)(6506007)(55016002)(66476007)(52536014)(66446008)(7696005)(8676002)(2906002)(33656002)(26005)(8936002)(66556008)(64756008)(83380400001)(478600001)(5660300002)(9686003)(7416002)(4326008)(66946007)(186003)(76116006)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?suQZiyH8EvR1yfd55C7+nx/IpEl5C+x0D+ytRA6kl4AotG9a3hL2koUs0b1q?=
 =?us-ascii?Q?JZUsO5HcmG0jdqUdl3SAHJjVFrg/NWzotfdtNK2KqHXWnaakvlm5SsHBItVi?=
 =?us-ascii?Q?IJH+s8SyRsDSVliAxi8fRxKpKKurTMdIi8DqQx1Mt9JXCpbPKmdZHUV1NPFI?=
 =?us-ascii?Q?u1RXl+RJDamk7WFvYyatX3GWQaG96SOAimoDmWIQZR97jzBo/gg9ONdHABKL?=
 =?us-ascii?Q?eQ/br24ROLxqESWlNZQ8sYLJeJH+/NRnrkYsyzUR7OKGJOxMij6Qgs9PyjMj?=
 =?us-ascii?Q?A/X4wTNucZS1G1lnG5wQQ8W4DESjkAqwLP8VR3zCTL+qZlFrvxJXUa4fsjv2?=
 =?us-ascii?Q?/PfMjWe7dnsFCPzPnVZ/mZ6aRnsXyR8tXwcIw8lt0SK5mQoKCdSZIM8QIhjo?=
 =?us-ascii?Q?1xuw3oYnK5XevvNSHslBryST/5z+DY+L+GMLO/omMTKkyrV3J+wmWuQ+9Z79?=
 =?us-ascii?Q?B0jw3dIvaKKjuMeIFPPo7NRlme6ElDVqJUcB7+XbS3RETuwAxS4CaFq7RYA1?=
 =?us-ascii?Q?JkpYiJ91mdMH8qZZduOyzPPEoraSMuuLLm78egfcLD/4c1KThqqPcFCVIuof?=
 =?us-ascii?Q?ithJAhTqgqgtWIKcK1G9HT2mAKlyRw324U6n9cpp4qLucqzCjHePpHfEGyTh?=
 =?us-ascii?Q?xtXB3edyUe5WVTnaxKw+tq5dtZ/LN5JQYTbOvp3xXMGCqMl9SZS2tpL6Geoo?=
 =?us-ascii?Q?Me2lRM9Mf+JvxF2XkiJU2rVN9Q3v6H04baZFWZshv4ZPv9XWzz0Bz9HxpKmF?=
 =?us-ascii?Q?xnMTDXemAQGOY8iJke3Ub626tyt0yfozZw9qPy3l0ppwH2SEKJfvWiVkbHiX?=
 =?us-ascii?Q?rSbm86/hCeNmhQMYrG3UDeaT3fY1Euoycsuin/d0VOPU6Vz8UuVSoT3wEF0W?=
 =?us-ascii?Q?VbVvXLF+YYBWII5RvrPd+GSMDK7JCUB/Pou+vYaJ8qgOMz7f3SVny05IR00u?=
 =?us-ascii?Q?ZIALQRjljediGi4KWg/BeG1hy0LlWS1jtHG9Rce5MiJ7+dA62UCdIwsdzkqq?=
 =?us-ascii?Q?Ttnr+pGXAo6tCwGEaQnKLUgPyPMo0FwQ56GyubmHpRbZa598uMLq4htoRTz3?=
 =?us-ascii?Q?UbbVafvLptfU0aMLiW95UCP0gXnCuo4LTElswsHXaAqC/BiHLrDg8mxicSdO?=
 =?us-ascii?Q?FXxbh7xW6E6QWn6/NNnewLPo2vOUpNgTSwaniq8+XY12gJZTnqldOB/Fddp8?=
 =?us-ascii?Q?JYtO1OeGwAE6opm8yn31/bYk9TuMcf3Z/vJQ4TeU+xyj48rrhmv1JsrXROSN?=
 =?us-ascii?Q?dz0vtQJg6xISSzvU1EWQftPQjo5haGUL4TU54dvmWADTsi1aChOSK54gf8kY?=
 =?us-ascii?Q?16DNMkyYf3htuwtCdYYgJDTe?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10820fc-f437-49c5-a6cd-08d8ded2877c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 05:58:26.9457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2J0Ei6sfKQXOhSfUcwVfrchx9AQzeosQAweVkvwmTPchdUpnpQot7+IBRaC7L4d4eGckj5Kqtk4b7AtqGOSrkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4865
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "mst@redhat.com" <mst@redhat.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 4, 2021 2:29 AM
> 
> Hi Vivek,
> 
> On Fri, 15 Jan 2021 17:43:39 +0530, Vivek Gautam <vivek.gautam@arm.com>
> wrote:
> 
> > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> >
> > Add support for tlb invalidation ops that can send invalidation
> > requests to back-end virtio-iommu when stage-1 page tables are
> > supported.
> >
> Just curious if it possible to reuse the iommu uapi for invalidation and others.
> When we started out designing the iommu uapi, the intention was to support
> both emulated and virtio iommu.

IIUC this patch is about the protocol between virtio-iommu frontend and backend.
After the virtio-iommu backend receives invalidation ops, it then needs to
forward the request to the host IOMMU driver through the existing iommu
uapi that you referred to, as a emulated VT-d or SMMU would do.

Thanks
Kevin

> 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > [Vivek: Refactoring the iommu_flush_ops, and adding only one pasid sync
> >         op that's needed with current iommu-pasid-table infrastructure.
> > 	Also updating uapi defines as required by latest changes]
> > Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Liu Yi L <yi.l.liu@intel.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/iommu/virtio-iommu.c | 95
> ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index ae5dfd3f8269..004ea94e3731 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/freezer.h>
> >  #include <linux/interval_tree.h>
> >  #include <linux/iommu.h>
> > +#include <linux/io-pgtable.h>
> >  #include <linux/module.h>
> >  #include <linux/of_iommu.h>
> >  #include <linux/of_platform.h>
> > @@ -63,6 +64,8 @@ struct viommu_mapping {
> >  };
> >
> >  struct viommu_mm {
> > +	int				pasid;
> > +	u64				archid;
> >  	struct io_pgtable_ops		*ops;
> >  	struct viommu_domain		*domain;
> >  };
> > @@ -692,6 +695,98 @@ static void viommu_event_handler(struct
> virtqueue
> > *vq) virtqueue_kick(vq);
> >  }
> >
> > +/* PASID and pgtable APIs */
> > +
> > +static void __viommu_flush_pasid_tlb_all(struct viommu_domain
> *vdomain,
> > +					 int pasid, u64 arch_id, int
> > type) +{
> > +	struct virtio_iommu_req_invalidate req = {
> > +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
> > +		.inv_gran	=
> > cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
> > +		.flags		=
> > cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID),
> > +		.inv_type	= cpu_to_le32(type),
> > +
> > +		.domain		= cpu_to_le32(vdomain->id),
> > +		.pasid		= cpu_to_le32(pasid),
> > +		.archid		= cpu_to_le64(arch_id),
> > +	};
> > +
> > +	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
> > +		pr_debug("could not send invalidate request\n");
> > +}
> > +
> > +static void viommu_flush_tlb_add(struct iommu_iotlb_gather *gather,
> > +				 unsigned long iova, size_t granule,
> > +				 void *cookie)
> > +{
> > +	struct viommu_mm *viommu_mm = cookie;
> > +	struct viommu_domain *vdomain = viommu_mm->domain;
> > +	struct iommu_domain *domain = &vdomain->domain;
> > +
> > +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
> > +}
> > +
> > +static void viommu_flush_tlb_walk(unsigned long iova, size_t size,
> > +				  size_t granule, void *cookie)
> > +{
> > +	struct viommu_mm *viommu_mm = cookie;
> > +	struct viommu_domain *vdomain = viommu_mm->domain;
> > +	struct virtio_iommu_req_invalidate req = {
> > +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
> > +		.inv_gran	= cpu_to_le32(VIRTIO_IOMMU_INVAL_G_VA),
> > +		.inv_type	=
> cpu_to_le32(VIRTIO_IOMMU_INV_T_IOTLB),
> > +		.flags		=
> > cpu_to_le32(VIRTIO_IOMMU_INVAL_F_ARCHID), +
> > +		.domain		= cpu_to_le32(vdomain->id),
> > +		.pasid		= cpu_to_le32(viommu_mm->pasid),
> > +		.archid		= cpu_to_le64(viommu_mm->archid),
> > +		.virt_start	= cpu_to_le64(iova),
> > +		.nr_pages	= cpu_to_le64(size / granule),
> > +		.granule	= ilog2(granule),
> > +	};
> > +
> > +	if (viommu_add_req(vdomain->viommu, &req, sizeof(req)))
> > +		pr_debug("could not add invalidate request\n");
> > +}
> > +
> > +static void viommu_flush_tlb_all(void *cookie)
> > +{
> > +	struct viommu_mm *viommu_mm = cookie;
> > +
> > +	if (!viommu_mm->archid)
> > +		return;
> > +
> > +	__viommu_flush_pasid_tlb_all(viommu_mm->domain,
> viommu_mm->pasid,
> > +				     viommu_mm->archid,
> > +				     VIRTIO_IOMMU_INV_T_IOTLB);
> > +}
> > +
> > +static struct iommu_flush_ops viommu_flush_ops = {
> > +	.tlb_flush_all		= viommu_flush_tlb_all,
> > +	.tlb_flush_walk		= viommu_flush_tlb_walk,
> > +	.tlb_add_page		= viommu_flush_tlb_add,
> > +};
> > +
> > +static void viommu_flush_pasid(void *cookie, int pasid, bool leaf)
> > +{
> > +	struct viommu_domain *vdomain = cookie;
> > +	struct virtio_iommu_req_invalidate req = {
> > +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
> > +		.inv_gran	=
> > cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
> > +		.inv_type	=
> cpu_to_le32(VIRTIO_IOMMU_INV_T_PASID),
> > +		.flags		=
> > cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID), +
> > +		.domain		= cpu_to_le32(vdomain->id),
> > +		.pasid		= cpu_to_le32(pasid),
> > +	};
> > +
> > +	if (leaf)
> > +		req.flags	|=
> > cpu_to_le32(VIRTIO_IOMMU_INVAL_F_LEAF); +
> > +	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
> > +		pr_debug("could not send invalidate request\n");
> > +}
> > +
> >  /* IOMMU API */
> >
> >  static struct iommu_domain *viommu_domain_alloc(unsigned type)
> 
> 
> Thanks,
> 
> Jacob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
