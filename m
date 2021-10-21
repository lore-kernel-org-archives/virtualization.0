Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A952C433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 06:48:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF28E611C7
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 06:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF28E611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A194740129;
	Thu, 21 Oct 2021 06:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9-Mb_v9QKTL0; Thu, 21 Oct 2021 06:48:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F255F401C8;
	Thu, 21 Oct 2021 06:48:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80D6FC000D;
	Thu, 21 Oct 2021 06:48:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00B71C000D;
 Thu, 21 Oct 2021 06:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBCD6401B6;
 Thu, 21 Oct 2021 06:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ewnmol__4q5I; Thu, 21 Oct 2021 06:48:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5856B40129;
 Thu, 21 Oct 2021 06:48:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="227729492"
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="227729492"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2021 23:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; d="scan'208";a="444668017"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga006.jf.intel.com with ESMTP; 20 Oct 2021 23:48:24 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 20 Oct 2021 23:48:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 20 Oct 2021 23:48:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 20 Oct 2021 23:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCmxbi4wuw1ppb7P5uoHj9H0qPBgsMIe/eAiqUzey6mhhqKDLoWaWVbs4KcH1vqkGrVpfmCQMqKd+1fa8yH0p5kw6BWY2hv+Yi0hLmNWV44Yb6SskOuEY3eJb+r3OI8YQxaCca/0SXtEi1z7tX55ac7XxnHk7A3O2ylp7vu1y3WyZGolLDcTI6xtjk6b+wdk55clptvFpixYYX61FyoK3i2wUN2b7X+htHmR5Nh+BtvviQ+t0GvZio5nF4munzsAeQmKGEKB6nLDijuAv7wbUVhtmXgpDEgArvxU7LKpz9aKSsWaxegGucXxrRxZa55WOQBMG7JodoMCxBJuxbqpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeEgfjG541N2kOyrvWv6uZFKGqcBe9WomoZ+oKBhXqc=;
 b=Z3wwx1k9Qg3ZSdKIqr7y4g6L2Ot0qXehOnTeCe6/QNtUIgy4N8lv13YVnlNnV3ZWMwyFqVfzL75rngJ+mn5RVAVcyO85djaBrKGfUI38N56wT4nNLhcC5K44jfZ5hmeQxZio4ZyU0Kd47Achbr6DPjU51b8kHiWLSuN5e+zlY4tkr/tr1PN0NBF/wVg1DDVanJIwaJh1RiRTRr9qmBDCXsnHdWwUSkEbG9yFoogcuqeuVmlHAMQrTeEy4A54rD+EIyFIw/4U158J91pnHYM2TQdUCuEpf4ebzyaeFCwgJRKGKkn+Wr1sm5gVoR2qLCTPGf7cRQYBxUA4iQ3WRuGutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeEgfjG541N2kOyrvWv6uZFKGqcBe9WomoZ+oKBhXqc=;
 b=x2xHThA2n1LoBsXV3Qry7yr4OCPCSZMtko9PsCXcO/dKinVQsBxTFwSmgc/WwoIycYjGvod9KKLEXazy9CtK1SdpuAlrxTOLYhgQwYLj8IIKiBNFnl3+1lTKlPt3olV76gaSFRLiGRPH4kmB5vpziurbDHH12/bUieCGBu2+R/M=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1716.namprd11.prod.outlook.com (2603:10b6:404:4a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 06:48:22 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 06:48:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 0/5] iommu/virtio: Add identity domains
Thread-Topic: [PATCH 0/5] iommu/virtio: Add identity domains
Thread-Index: AQHXwCxydUd3K77AsE6UB+M/DEvsiavdDs8w
Date: Thu, 21 Oct 2021 06:48:22 +0000
Message-ID: <BN9PR11MB5433F3792545F8B72A127EBF8CBF9@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
In-Reply-To: <20211013121052.518113-1-jean-philippe@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad887e47-7127-4edf-630c-08d9945ec650
x-ms-traffictypediagnostic: BN6PR11MB1716:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB17165C0AC63907E534B781B08CBF9@BN6PR11MB1716.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OrqpOGL/fC/T7yT8ac8mmB+e1mQSq9c1dwsvy+Y1kCv+tgJjZ4pX7A3v08mJHkdEI61rO5ubUaCDgSApIocrA9lHAn42X3jaABsZ/Fr26gEFB7/N4hCdNjwxbzMi2BwVHjrHPSo6TfH9Z/Ee8lLusU5xyn1amMbpzEv7MtuO5aoJWUGvizixGlE+w+j4dFNvJcljirAtR0bxiwGPfUpIqpg6zLkYlkj4zm29NEshhYLc5UKwRfX6idm/7DkGVMVOgs9kNU/pRkjvNsPo+drviiCkMVRjesfRgEc3a6+R7kH8+DZwvcZfmqQz4t4+lu1ypBBLrvScdaJ+t5IPWfEBk+EaUZKEFi8cT3m8I8ztS74NVpfcGSlT565ZeNshZ5IxWBz4zdvcC7d1iUT8bGF64h3H9k4vIa/Y1dAWAP7K+gqtBzJWwJCnQutnTyt05CGjsPi17IpvqKJSlxM/KQwQFkoIGGQlQdb0Jz92XS3tmKgYZiHhyVdUiPBqkmmpW4k3h4hSso7jaCOpWCrsOcSuHU9IaWrEaVtqNHRD/1mT6csBzMETia3kQiHBp5DoAyPP1klbBQ+EP4TuHHsA0mNv1PPeF1bYnpBMuypBrRlCzg9KqfGALkaCYWHgoSbTKeOXGbn0WBworLGpuspD6v+Gl8jkRMoPFdfv+uNXAvPqcT5c1QrI3xuz3OUgv7aa3B8X51l21yjuq+N4979CTHHngiqgYj2XSagDNN/NNqem2XuxIawxQi4jLFpf1204SUiuvrBElWHwZj8ryjgOZRYxAakpwSGuJ7nxpxwaUlQ+WA8zYqJSfmzin8gqascNTMTLjYZmbG5qBuL7kTydJvgrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(2906002)(55016002)(38100700002)(9686003)(64756008)(66446008)(86362001)(122000001)(76116006)(26005)(83380400001)(66476007)(66946007)(4326008)(5660300002)(6506007)(966005)(316002)(66556008)(54906003)(8936002)(110136005)(71200400001)(82960400001)(38070700005)(7696005)(186003)(508600001)(33656002)(8676002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7jBYHQR2GIv9OI5N965Ai1GUsblTb0yH+AZzVpZ8iCLPWSy+Qra8HAldYCMV?=
 =?us-ascii?Q?PKObHCbl5La7URx6i7ode68lM6RTJdJVrbSb17eP4m+mYcSZGJSryb7/exQz?=
 =?us-ascii?Q?hikDSTTD+i8acL6nqsC/LnSJl/8Qn1C6qkpM+adQE2WdxtOKAmmD+16kYp1g?=
 =?us-ascii?Q?tKEwMKWdlcdc8J6sx/agPvl5JYiLDpcBTH4x/BrHJiDchXijlhSrsfXHA2bc?=
 =?us-ascii?Q?tFtWy3Vx9UUZxO0O+fFaL2FpKDQatil8QeN5Z8uWsCSlhpSsXYTciRLOxFV6?=
 =?us-ascii?Q?gXcuJ34x9I1jqbEK7m5nBljr36cuzAKgGZRE3acXY99c1An9CxYZxPahIb2F?=
 =?us-ascii?Q?Wc5tZvsX34TimN+lgUqzRCRpWQkDYaPIJLFKwyIT3yHmuGE79nX4PGEQvXt2?=
 =?us-ascii?Q?iEuLXLQW4BH9vIvM7lZjapHesckYT1iSFrcDqoiHpAvXE5MA5PmxW9Uc6PXX?=
 =?us-ascii?Q?Z/gBhmOGWxhtcw7kylpPDjav9HBccW8B4RPZmUCFVk+7EvmPmvrFYLY7Sd+R?=
 =?us-ascii?Q?JF9Mj5EkmdfWJnY+A0+DzEUd4sI1LV79+lF+uQjrJUG28Gruyh2FJ6vcROxu?=
 =?us-ascii?Q?IEMCt1pH2OWSCxzf6nB3u7LkKR2wj4kOILNWGk/Vf1OvX77LKXNUa9yDtxxm?=
 =?us-ascii?Q?We6GPRpll5BvEsHCNGO3W1skG50p3ejnAYZSAgRVNMERQ+A3OmZoQE4SkmAf?=
 =?us-ascii?Q?93iLt/Uji0t9JPAua5M61Pg/WGj04xrqtYacrL/KLmUawIG6S9u+8TsZMsJm?=
 =?us-ascii?Q?L3VcvS4But0WwVPjHgm67bV1HprBnXluCTu8BlcVC3Mik3Uh3/To4db+/Q0O?=
 =?us-ascii?Q?TKcs0PDNBCDVFi82WZo/mWKs2fOKbP15/emwBC7SaEwHsspqW459HzZ0dddf?=
 =?us-ascii?Q?iL+xeSiXnG6vfe1fK5xAndfr3kTET8PvZzVbRCN5IRVI85x/wPTnH8udwpw3?=
 =?us-ascii?Q?5Al5R6LulDoIJpLHzKR8pvGc5748jWzFuJJJJdnmNA/IIJNBC8nvJ6d+RaN3?=
 =?us-ascii?Q?YS7cuaVo3w2qkqqQgK5jPZAkhUJdGp9D8SzmBM1GUlstyMbK+7SOFaeoNLyh?=
 =?us-ascii?Q?fgbWibBIz547fmYYUDD7vHrW5Gh2KI6CepdXR+Bm4I6LJhMQ9/2qbIIIRtgL?=
 =?us-ascii?Q?ffZL2r2R8YEgOGAhAdb/rlvtsrUOtKWmMYT11dLGOwqe0bJOYgPJ9IhWYTFy?=
 =?us-ascii?Q?0kbh9mH70IBUzvG2Y58DJzjq8Ov9vI/tkMjva9xyqCt6Q0J/k0cQfXI10aZd?=
 =?us-ascii?Q?diqV8dHriAUUV2AYaUEqmXxRaRYFy9jsIVYvBdcfoACnK7B2FlfYSiZPEGeF?=
 =?us-ascii?Q?CQoi1pDAgUBdaPPgTez1CUsg?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad887e47-7127-4edf-630c-08d9945ec650
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 06:48:22.4291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kevin.tian@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1716
X-OriginatorOrg: intel.com
Cc: "mst@redhat.com" <mst@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>, "will@kernel.org" <will@kernel.org>
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Wednesday, October 13, 2021 8:11 PM
> 
> Support identity domains, allowing to only enable IOMMU protection for a
> subset of endpoints (those assigned to userspace, for example). Users
> may enable identity domains at compile time
> (CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time
> (iommu.passthrough=1) or
> runtime (/sys/kernel/iommu_groups/*/type = identity).
> 
> Patches 1-2 support identity domains using the optional
> VIRTIO_IOMMU_F_BYPASS_CONFIG feature. The feature bit is not yet in the
> spec, see [1] for the latest proposal.
> 
> Patches 3-5 add a fallback to identity mappings, when the feature is not
> supported.
> 
> Note that this series doesn't touch the global bypass bit added by
> VIRTIO_IOMMU_F_BYPASS_CONFIG. All endpoints managed by the IOMMU
> should
> be attached to a domain, so global bypass isn't in use after endpoints
> are probed. Before that, the global bypass policy is decided by the
> hypervisor and firmware. So I don't think Linux needs to touch the
> global bypass bit, but there are some patches available on my
> virtio-iommu/bypass branch [2] to test it.
> 
> QEMU patches are on my virtio-iommu/bypass branch [3] (and the list)
> 
> [1] https://www.mail-archive.com/virtio-dev@lists.oasis-
> open.org/msg07898.html
> [2] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/bypass
> [3] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/bypass
> 
> Jean-Philippe Brucker (5):
>   iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
>   iommu/virtio: Support bypass domains
>   iommu/virtio: Sort reserved regions
>   iommu/virtio: Pass end address to viommu_add_mapping()
>   iommu/virtio: Support identity-mapped domains
> 
>  include/uapi/linux/virtio_iommu.h |   8 ++-
>  drivers/iommu/virtio-iommu.c      | 113 +++++++++++++++++++++++++-----
>  2 files changed, 101 insertions(+), 20 deletions(-)
> 

For this series:

	Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
