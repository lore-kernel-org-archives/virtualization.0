Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C080EC433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 03:25:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7677F611AD
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 03:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7677F611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FF96401D8;
	Thu, 14 Oct 2021 03:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-XQl2fdUBIc; Thu, 14 Oct 2021 03:25:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 67752401C5;
	Thu, 14 Oct 2021 03:25:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1848BC0023;
	Thu, 14 Oct 2021 03:25:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97D88C000D;
 Thu, 14 Oct 2021 03:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 784B240123;
 Thu, 14 Oct 2021 03:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ssOlxseiPaqW; Thu, 14 Oct 2021 03:25:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7407740004;
 Thu, 14 Oct 2021 03:25:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="225042926"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="225042926"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 20:25:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="563451279"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2021 20:25:27 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 20:25:27 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 13 Oct 2021 20:25:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 13 Oct 2021 20:25:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 13 Oct 2021 20:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enOrLLF2WoO3Y6g1vnz8nSwF0xM7v+GVje8TmgcTVMOCIKxpdkEpNykkewlf4DeQVAqGp+zfG49WAEMFvItKM/PZaVEHcOTgk4lS8sab4g5kYUT9DsA7+dcGHEUZihuOm5N+STphBfRF+ejNzdk4eRwIMRI2W7WunzHBKDQurg97Iqj8k9QihXdsV8lQfcXz8BW1T6JBaTcZb3ZiIDd76GArIIZ3xpZAQSzurmN95pXjJmZVADZe9VprdIQiCNgapa+YGXw+Q0ckLSehX3aIY/BaasuU+Xl85Ekb5XsOwOQ/ZyOtC5hQ3o5l4R/YEiAh1Y+htE7bbdINh6E1e9Qy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w1Zc2m5lx2+rnDRn9D0FUd3GTc6JqoA0PDR9TqgCVc=;
 b=Ovdv+6AkWLUDeGZ2i82l8ZrSWjyFTiNbGvjJ91OVNHo6uieIAojaU7FUSAtG+rwxdkl5EsPKqXcsAl9N+BbByFenz9gr3rg9nNhaMOAogPQ4IyJKzzyEM6SJHAROilGFG3/zqXsnZEpGFVXUtjQ/XR7VIzzFLRs8ETxEV8jnGP4Jm1F50zNwvAFulx/OzYfctbAMM+Is3+sNMwiInXodM49EVoN10fukEwrgyuZxy1It8my6dvGfNabXLABAn7VpKaOL0S5N3Z6cStdttvaT/JJLpoe0JOfmt1ic784cBHpiYf+IUxljxzhx3zsFfAVmA6A5vBI3PNSbDHbOwtuqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w1Zc2m5lx2+rnDRn9D0FUd3GTc6JqoA0PDR9TqgCVc=;
 b=WkOzJOeEYW1hCpf1dqbQBSHoCkpJGHYy8KjLf8m4Sg4eOiH5DG0VB1IyglUa8vDU0rl7q2lVPXhxPINAKw1xrYSHS7iDeTUMroT40yqM/M/ebpDZ/37SOhl1lfh9B78oqe1SYce5rsF92UOzH6aQUQjNo2RoeOAF9NsqE/kpNuA=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1793.namprd11.prod.outlook.com (2603:10b6:404:102::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 14 Oct
 2021 03:25:17 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 03:25:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 2/5] iommu/virtio: Support bypass domains
Thread-Topic: [PATCH 2/5] iommu/virtio: Support bypass domains
Thread-Index: AQHXwCxxolfOCB8Fpk2UjJm46zvieqvR0fcw
Date: Thu, 14 Oct 2021 03:25:17 +0000
Message-ID: <BN9PR11MB5433711245D7459A6A0C676A8CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
 <20211013121052.518113-3-jean-philippe@linaro.org>
In-Reply-To: <20211013121052.518113-3-jean-philippe@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b291af32-b89d-4790-b67e-08d98ec23eba
x-ms-traffictypediagnostic: BN6PR11MB1793:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1793083CBB45C1E291DA981B8CB89@BN6PR11MB1793.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5UmVAJtRupvHSdCj2Q2edVJaPNNhN44fD30ZLU0EmUCNcrm5cbH6YFwHASFg9d/z7Rzp4PG9OJ2Xw3hkpwNI9zQsnT5Jkb8tIhwTYv7i4OiiXXqX7Djhq2VCuqb+VXL2R1kTv3XAsNCzDtNLemnoGGbizgXY/v9d1VxLjrxiGdV9+pP8bcA6DPBslFynEAjKFhOmPUbVl3AhPWdcE3Ardvh89PQIQKNcl1uDURg5UuTPgghSuvgebob7SbGBJfrebsfZ2A3RTW3hdSnggIJkopYceaXYQHMPGRqHiVCvtQw6AynntIVpdwWP4JlTZ5k2Sy4mIfMxWlc+WPAsWnlzFP0PXF8q99VpURBfMflxR1ufTSCloUl8LfcSfyWXjhv9dYZ0kcHPDQhzc9pCgiMOt7wNRWVowTajp8YiuSNLPMDORSYcUqgcEMP/hcNtyAfXuraHsw7CF5qnAE2hWRoekfcJvWp3TmaH+xUL3yesnhlTaUDN8zyZJ0pHwn3N1ixIwbfIrV9Ns4h/DsbgSDaBlU/VJ+l0/xUGGxAu2GCsDLB5z9cjWvB178kqasjmWKEaVWc5V5IQyOkul6qJ08PwI3l6rrLFDXLnb38g7iY2IltLLu985/rd7PDQM03XNCC6xaRU0tioQLlvtDVA8vUf27j26+Yl5Orr3FXEkywOQiXxsdYl65G3WqeUvV02vUWEbR9rPzWupZ96wuCMHfI8w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(82960400001)(186003)(71200400001)(9686003)(52536014)(508600001)(5660300002)(316002)(26005)(122000001)(2906002)(38100700002)(8936002)(6506007)(66556008)(83380400001)(64756008)(66476007)(76116006)(8676002)(66946007)(66446008)(4326008)(54906003)(110136005)(38070700005)(86362001)(55016002)(7696005)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9dnFU8kwbqbH6UVHrLwSYWBsBXp9YA8gLwkHQ9xZnsKwv03GS7gerlgerKNG?=
 =?us-ascii?Q?5BHdQB/8SMYOJOKJxByYX6/6QBtKOGV8bFK2FG9ZUu+IkSFFwRdTWl76aYqD?=
 =?us-ascii?Q?u+linx3cLKC7jUfCiyQg0pXg41zAAYZFoarS6U0+IaQZdzoAwl7eSpDrNDsa?=
 =?us-ascii?Q?6JMZp3Jl6DUm5OvtIHWlIfNecTBOi7ZyVNF9a5uJmUsFNAx58UPKZOdTQVo7?=
 =?us-ascii?Q?v9jYJBKi4ACgSDBzlYqioKTbV2J4fADFYuwAq7yXC1GIWhh8J6TEHEudSREC?=
 =?us-ascii?Q?dLk5RowiHRnzNBNupRKzRA8tk8TUZqC9TcHCmUvJMmJ43+QURY6wGwyFeEHj?=
 =?us-ascii?Q?b99jqcE8zeRde6QCWxeNq4bZzzR5Rwd3dVnEml7u4q0SNY0UZ1zLMb8NwOKv?=
 =?us-ascii?Q?i2R2XN6DNiSRqEGy2CW0QrymS0i1WVqbVcBdT6m9UQF/yyAPkM6ZD/fBqaDL?=
 =?us-ascii?Q?ZCi+EW1+3+Og4dFomw+Txrr+E39ASztHZsx1LVNEGPTsWHIJBmhHGnE02/Pa?=
 =?us-ascii?Q?Y+VDoTqgTzLVnITLyhrzYOhJd6YceVRbndrRx3CegjnbzU5HronqsiB5UOAC?=
 =?us-ascii?Q?Lj47Pv5t+H853+4lOHZX9YlcRUL8JfaXVjQQ7VxbWu7tvW9gIVHq3PYV20By?=
 =?us-ascii?Q?sFYKJTLJtxbUHBn0JUWAagn4A3oKCz6BAofYgfLThrY2B7XPDkCTs8Ex+G7i?=
 =?us-ascii?Q?HT5Z0yN9pr+qITcZ1p+RGtjdMSVuA4fAMSeFVbjW/q3Uk8BzWfXuEVhiA5tx?=
 =?us-ascii?Q?CrlOuzXGssdDntxZ+0GuVjuJ6ru5sJNf+gAiwq2ro6otaVHwZKbqD2vzD0v8?=
 =?us-ascii?Q?Z1vdPiGET9gTPVrr5k2FtzFjKvaroJjnk14+rfX/6Jk4GrK2bFgjZ6XvmBzy?=
 =?us-ascii?Q?OvpeYH2WdkA4vtzeEiEfYCEm6SdIXpVa2H56QFY0JCwSYuH4nqpgeu9x9man?=
 =?us-ascii?Q?JXSgsEyc82KkuqMF3hQ1c67sz5spntDs3zNIm5jSegt0Ie7Zc/ZuFFonCAP3?=
 =?us-ascii?Q?sQT5mdbfKT/1wqn1NxoLhBdTeBbGY3dnIsThaoJo/AFEh2XDukcsdJEyWTjm?=
 =?us-ascii?Q?XqnYdYXfntkJpBL+S4nOxSwxwgENsNvNkTZoU1R0ZL5k9iH+VqKrKeI2A5db?=
 =?us-ascii?Q?gaZm2UXRJ5DRblT6Wa9NzDZs+UVO3ViY21VPUiv181DwKQ4oaQwPURxCK6te?=
 =?us-ascii?Q?z6rvl9X9HJOTLn5bjECn8vR0GR6n7KKkuUhQTpH+HPJ+wgurFIvDsEjub+hN?=
 =?us-ascii?Q?8SMIGI/Dc/Gi061ZY9iyfMef67a1FjJeaR1niijS8cV90eKW+2KwmYyuIkle?=
 =?us-ascii?Q?zQOyzFNaMHeYnuIMF6QuQxy+?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b291af32-b89d-4790-b67e-08d98ec23eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 03:25:17.5186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0dLBAfSG6tCkFjCnQIXz4yTUJIIhZz5aq+VNlfa4dDhU4cOwAkq6A3dq6ya4/xp2Rg0jtqh8jgrZBEcOV2uTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1793
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
> The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a new flag to the
> ATTACH
> request, that creates a bypass domain. Use it to enable identity
> domains.
> 
> When VIRTIO_IOMMU_F_BYPASS_CONFIG is not supported by the device,
> we
> currently fail attaching to an identity domain. Future patches will
> instead create identity mappings in this case.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 80930ce04a16..ee8a7afd667b 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -71,6 +71,7 @@ struct viommu_domain {
>  	struct rb_root_cached		mappings;
> 
>  	unsigned long			nr_endpoints;
> +	bool				bypass;
>  };
> 
>  struct viommu_endpoint {
> @@ -587,7 +588,9 @@ static struct iommu_domain
> *viommu_domain_alloc(unsigned type)
>  {
>  	struct viommu_domain *vdomain;
> 
> -	if (type != IOMMU_DOMAIN_UNMANAGED && type !=
> IOMMU_DOMAIN_DMA)
> +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_DMA &&
> +	    type != IOMMU_DOMAIN_IDENTITY)
>  		return NULL;
> 
>  	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
> @@ -630,6 +633,17 @@ static int viommu_domain_finalise(struct
> viommu_endpoint *vdev,
>  	vdomain->map_flags	= viommu->map_flags;
>  	vdomain->viommu		= viommu;
> 
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		if (!virtio_has_feature(viommu->vdev,
> +					VIRTIO_IOMMU_F_BYPASS_CONFIG))
> {
> +			ida_free(&viommu->domain_ids, vdomain->id);
> +			vdomain->viommu = 0;
> +			return -EOPNOTSUPP;
> +		}
> +
> +		vdomain->bypass = true;
> +	}
> +

move to the start of the function, then no need for above cleanup.

>  	return 0;
>  }
> 
> @@ -691,6 +705,9 @@ static int viommu_attach_dev(struct iommu_domain
> *domain, struct device *dev)
>  		.domain		= cpu_to_le32(vdomain->id),
>  	};
> 
> +	if (vdomain->bypass)
> +		req.flags |=
> cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
> +
>  	for (i = 0; i < fwspec->num_ids; i++) {
>  		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> 
> @@ -1132,6 +1149,7 @@ static unsigned int features[] = {
>  	VIRTIO_IOMMU_F_DOMAIN_RANGE,
>  	VIRTIO_IOMMU_F_PROBE,
>  	VIRTIO_IOMMU_F_MMIO,
> +	VIRTIO_IOMMU_F_BYPASS_CONFIG,
>  };
> 
>  static struct virtio_device_id id_table[] = {
> --
> 2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
