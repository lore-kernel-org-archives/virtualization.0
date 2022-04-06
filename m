Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71162C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 07:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16AD581AD7;
	Wed,  6 Apr 2022 07:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CaZbjTxERzz7; Wed,  6 Apr 2022 07:03:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BFCD819BE;
	Wed,  6 Apr 2022 07:02:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 542BBC002C;
	Wed,  6 Apr 2022 07:02:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C89FC0012;
 Wed,  6 Apr 2022 07:02:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 648D6417BF;
 Wed,  6 Apr 2022 07:02:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kLpNSO6Q2mIQ; Wed,  6 Apr 2022 07:02:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14934417BE;
 Wed,  6 Apr 2022 07:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649228577; x=1680764577;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9yXnWPFaJPcfSAhgXMQM40zFYivmgfvuHZVyoADMm+c=;
 b=dFBg8ot5f6UeudbfGh0hVryuENz8e/s7yn0YN+l/ReHmRuGvvLYOqMDu
 ICmdexfQIdg+TmnJ1GaCbEzyQkm/VnObck0jcJqQSuQE7y+MCNzG3oqE3
 kO+yHRpYC/PBiWeyL1bleStfzSprP6n29unYz46MYLd81M7tt29HrpfrW
 eexuT9N9WU5orqyUQqAwpNArXCA67woAvVbJSqirDglIwYoN0l96hoBdi
 fNJdwtVCR2pJNtXctWFLZmLN7k1C+Px/F33ZnT5zVmsIxMXgUVIexmXL2
 LCOtjsHbHGKQYfQlUIT8nbWn5jVu0V5mleUsfzvDz0LqvkOX2GoBtP86N g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240902648"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="240902648"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 00:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="549419306"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga007.jf.intel.com with ESMTP; 06 Apr 2022 00:02:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 00:02:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 00:02:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 00:02:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 00:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBsP97RyNVSYXfzW8F4rHWni1sG/h3uEbWD6PLNUBSygD18SAKz/2QGaWvwkWKOJvIuxtC0TlRXQpImmoftz/2uSqVx3+Ehq8gxCVS6Bf314AcShdPb7pYTcSpmQcbfv3tMnkZ3Xr8f0Qqlc4td0mx6k/JeRDXojsBJz4NDEH3H0NJF0LI2CjMRA14a8ZFLXxHb/3SiyELxUuZVL7S7xq1W/ARyqWTNvXZhKbuVB9su3DqB8Gt9imp80pIbelQDu2HBfhclZTSVEFQ95Gh+uX8IHaDguzDytGDjbyiZKWbDnKY1/F58jeU9hO+TYr7k/jrvRsU3m1ZDF0Ihlm1s0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpZ5rpjZ/323Q4FiP3H6XfuAq/WWbmz2u2b2ATpZRiM=;
 b=I7SefwtHVKGK5w/dzLMRezmQMPcMjak4bDmfbhQOrh9owDU7qceXEvhUx7QP6vTIEl7X3E6wF9kehI3JoQY+9MqI3obUP2+1Ar7gotsixxCrtDuQQdVs055tSrUUgmXSkXeJJ5i9F56+fHIRR4CPi0e+xZF0gIdkjYA6POen9mE23p51vhYiMEcm9qcohDdqIunLz3cF3ev7a/0Sh912/q61+IaM/AK48mtwGcV+8Aci8YqFf5c4LHunoZ6KeDI2W5zqdi6LD5bNC6orRhoSa561uibmqvX0VLUoXnNkyrvTUNl8cozuRWCwqmHO6InLXmo9ebT7NxfMjOSLQb9NJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5885.namprd11.prod.outlook.com (2603:10b6:510:134::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Wed, 6 Apr
 2022 07:02:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 07:02:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH 2/5] vfio: Require that devices support DMA cache coherence
Thread-Topic: [PATCH 2/5] vfio: Require that devices support DMA cache
 coherence
Thread-Index: AQHYSQh+iGQB4aLBFUu6szRllIBFLqzhr6EAgAAFLgCAAMFI0A==
Date: Wed, 6 Apr 2022 07:02:36 +0000
Message-ID: <BN9PR11MB52766319F89353256863D41E8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <2-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <20220405131044.23910b77.alex.williamson@redhat.com>
 <20220405192916.GT2120790@nvidia.com>
In-Reply-To: <20220405192916.GT2120790@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd1d5368-9447-465b-35fd-08da179b6e30
x-ms-traffictypediagnostic: PH7PR11MB5885:EE_
x-microsoft-antispam-prvs: <PH7PR11MB58858129DB86C1F60B76C89E8CE79@PH7PR11MB5885.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Azv5BpEPVMypZ7ZE/68AxddWT9AhaSUULiUIPoVJ43Z/0MKytwAyzwrT8Yrxt5Dp0ZYkFzELg78LbjkYaHMquOq53uKZrUJy+lmTswDcMMmBN5RrXKckYsztRnkdaa/VZWuA+AwRKlgJlFg1ZIDDBLzT0dmUh2RcfBdPFoica0qEeg7hw8dBd0U4jeKHam3gIt1uL0tCJGFvb0lFhehH3qtC83T37r9P8Xokv4xKWU+AwTiKgHf1ft+fi/UNr/U1jPN6Yi7tD+7puHOzL8G/tmS0AbO71A/SVoL1Iew7gA4YaHECbP2FWe9HguZj6UnANprG74YMjjCFcPrr+9NaqKA/qPmwSFDN9QiE2TnHz5ZL0Tr3/HQsaU8fypcKGHtyhLj1LZGavzopgxXAt/RhVtgF2KbJp/m1hZ0xe1IEeSUUc+KNHeMLhjEVjy/7+zSnSVZeskLgwv9e2J/HPH/5rPtcArFwPJDSU+SyeVywNmVYC+tlRUCAD099uQu2LsPLwDEADO60oJTmGLKGKZ+YfdoUho5PgF2aY0Rk3XabBN5HHmPte5iLF76xk5yLYe6C0oEARuyxp2jRv3nuQ33cQdhuXd7bk3btMP60nY2D5i+GqBWYDVTu0KdKJxnsmuA3AlQWBU8ewvOV+wvZd9iGF8n3e8kjFAcIZdrTjy6vShaVMk46DF/w26JYLkrj7TGmkuaV4jyiZINYqWdrhmZIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(316002)(8676002)(71200400001)(66446008)(4326008)(52536014)(66556008)(6506007)(66946007)(110136005)(66476007)(7696005)(54906003)(508600001)(55016003)(76116006)(8936002)(64756008)(7416002)(5660300002)(33656002)(86362001)(9686003)(186003)(26005)(83380400001)(38070700005)(2906002)(38100700002)(82960400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gmd1F0kaSG5OHjvaZPLWx6NVaVyull7bel9d013fcaw/eZO66M3Nlk0keRtl?=
 =?us-ascii?Q?qXKs/c15VLZfQqrjKDz+6NRbKj/s4SC4rGViNbMb+NDxKmd8XfE3JFF2R5WY?=
 =?us-ascii?Q?n0nv4jZg9OFH6soZCsHJDj40gZMxcgWHivfd06apqJE8je4LmIrmlQJ50NER?=
 =?us-ascii?Q?iNheOoO4UGVfbz2onI8JcCEWyD3gIlHk1PTjMNb3hBMnTsCb9h3Y1kmeLoXW?=
 =?us-ascii?Q?W8bsQWFHAf2CR5QP4ru9aqvIhhy7+O8QfqGmv2KFvY/Sa8i6PFyIP2XcrZAn?=
 =?us-ascii?Q?5z7pe3JsIzs6UOOeGWVHdj3nCS0tby7si/rIKV75+ykVgXKL1bQwbMBI/MlI?=
 =?us-ascii?Q?JSqLhRJmRRwbBHlwFYdRCXI0jr83C25hmhNAGDNf5h0MZ2tTCF2k71l5bGWK?=
 =?us-ascii?Q?HCbAMCMpMBNnZAulkP3reD46EIRZ3dvHVB/5ZJtKkkUyoTxDzS/ov72nVDhK?=
 =?us-ascii?Q?2bpHACHXYHosAZGAsGyPboQLRmEzgwRZjsHRNFy2YJSI1YwZXYyuDa90MXqA?=
 =?us-ascii?Q?Y5mnSY79Hz8eZjZJa0KkSxZD0pgwieACaVwmuPPemBYl8y+oQsQU1FirHxCX?=
 =?us-ascii?Q?r+qkTzDgJWTjTEiZCQEmOK/rXxpNImDo3L+1oXW55Plrl2bwooUwjL0XgIG1?=
 =?us-ascii?Q?VjZvEsHaAd2J/s7Esb3cItMM6C2cwnJoCc3VqbGD9F3G3fdGToopNpMcZ3Gi?=
 =?us-ascii?Q?h/HnFNTktk/hoEy5fuL3rpZFbcCxEO8CNXhZX19IVoYuHI4JnCd3bwpTq04d?=
 =?us-ascii?Q?izOz6txSbXP/mv0nKwZlJJTqizYnGvh8/2rYx0OQdQZ4dvWMNZxj1dxsG1P5?=
 =?us-ascii?Q?cNiET/y45qWppgv+SQtmwiB+lgVP2JA8Xb/aJ7BDrDPpL9n2KZ1HUE4mMtoH?=
 =?us-ascii?Q?dlqg+TJCmtEsp1+Qu01XC7lbMLGTiYM5jXJH6dpPeY1opkE7KYm69HzJiH53?=
 =?us-ascii?Q?BpntXw4Xk12maVf5vCLMvSLKxso5p8u25XMOEt+2/SYGXq5OQfbAbAGVeGGA?=
 =?us-ascii?Q?RhEtSFIaE1c9Tc+efkqOVepP6Mx73Fs4Jv0mfHT7kTm9JWRlJVoaQuJ88nm+?=
 =?us-ascii?Q?HotDkb48k5pfBQFSWVKiWoKOBcp8fpuAR8GYKp85RrPaaBY02r4pMlln7dF+?=
 =?us-ascii?Q?dBYR1QPq7T66ZezYi1vT69vW0O3iJQyXEjFn+9f+RdATD1YtqwAfjYq/VSkp?=
 =?us-ascii?Q?HcRqId623/McuWWdEpoUgBrDaQG5YqHsgOLdPevAybSYNFuBK1P9c2T/6uVw?=
 =?us-ascii?Q?1e3J1hBExHlF6giKAJKQB+rfEXsKvRXXmNIpeGkcbOOpyjoipkef8lQIAnKv?=
 =?us-ascii?Q?/9cCV8eIXsvhthRjwQI1VY1LAs5jBhjwiMwYwO1vt2UesnLbubAR245RnSMY?=
 =?us-ascii?Q?jj8ZX4ZxYLod5yLxFgEWVeBZo7NyH9sLp3EAmjWKkzlC3fFaSpK/JudmfxFz?=
 =?us-ascii?Q?KN1v6PhPUxTtOow9q0i4A7Iu/lJnN6dYvlqFYqgxK2xM11g6XghiIp+VzqfS?=
 =?us-ascii?Q?1aYELPMwWCcKAtFpurpawVpA0KVaONCKLph89gy9ndocCfOxTrZKOqJy/NY5?=
 =?us-ascii?Q?fHlvn6vL5ejF6q12tXcVcD9+MuTy4QN/iqfJCgxzLtplTW0k/lsgbk2CQoxG?=
 =?us-ascii?Q?I8YaJ1mgTJgWBE7LfMvHMhKMxdpXcB1uqjK/AQpZfDvlC+8ryk53WArLR8tV?=
 =?us-ascii?Q?SKsaJJO4PHb4mDVcpWdb9FYN4t8iQENqWvya8oejN3H0SagMFpS48o7TXnWK?=
 =?us-ascii?Q?oDDpdNwP7g=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1d5368-9447-465b-35fd-08da179b6e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 07:02:36.1106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnIj9JeokweneDmdbZpx8OX+uXUvq0hi4EJf212dVk9h+hRopZ0qPTT8ZZAqihWB/l8gdLrsiJoZgLSeSfMKIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5885
X-OriginatorOrg: intel.com
Cc: Nelson Escobar <neescoba@cisco.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Rob Clark <robdclark@gmail.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Christian Benvenuti <benve@cisco.com>, Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 6, 2022 3:29 AM
> 
> On Tue, Apr 05, 2022 at 01:10:44PM -0600, Alex Williamson wrote:
> > On Tue,  5 Apr 2022 13:16:01 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > > dev_is_dma_coherent() is the control to determine if IOMMU_CACHE can
> be
> > > supported.
> > >
> > > IOMMU_CACHE means that normal DMAs do not require any additional
> coherency
> > > mechanism and is the basic uAPI that VFIO exposes to userspace. For
> > > instance VFIO applications like DPDK will not work if additional coherency
> > > operations are required.
> > >
> > > Therefore check dev_is_dma_coherent() before allowing a device to join
> a
> > > domain. This will block device/platform/iommu combinations from using
> VFIO
> > > that do not support cache coherent DMA.
> > >
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >  drivers/vfio/vfio.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> > > index a4555014bd1e72..2a3aa3e742d943 100644
> > > +++ b/drivers/vfio/vfio.c
> > > @@ -32,6 +32,7 @@
> > >  #include <linux/vfio.h>
> > >  #include <linux/wait.h>
> > >  #include <linux/sched/signal.h>
> > > +#include <linux/dma-map-ops.h>
> > >  #include "vfio.h"
> > >
> > >  #define DRIVER_VERSION	"0.3"
> > > @@ -1348,6 +1349,11 @@ static int vfio_group_get_device_fd(struct
> vfio_group *group, char *buf)
> > >  	if (IS_ERR(device))
> > >  		return PTR_ERR(device);
> > >
> > > +	if (group->type == VFIO_IOMMU && !dev_is_dma_coherent(device-
> >dev)) {
> > > +		ret = -ENODEV;
> > > +		goto err_device_put;
> > > +	}
> > > +
> >
> > Failing at the point where the user is trying to gain access to the
> > device seems a little late in the process and opaque, wouldn't we
> > rather have vfio bus drivers fail to probe such devices?  I'd expect
> > this to occur in the vfio_register_group_dev() path.  Thanks,
> 
> Yes, that is a good point.
> 
> So like this:
> 
>  int vfio_register_group_dev(struct vfio_device *device)
>  {
> +       if (!dev_is_dma_coherent(device->dev))
> +               return -EINVAL;
> +
>         return __vfio_register_dev(device,
>                 vfio_group_find_or_alloc(device->dev));
>  }
> 
> I fixed it up.
> 

if that is the case should it also apply to usnic and vdpa in the first
patch (i.e. fail the probe)?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
