Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091DBC433FE
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 07:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9665260F1B;
	Thu,  7 Apr 2022 07:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AvSJBByCeXtL; Thu,  7 Apr 2022 07:18:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 28AEB60598;
	Thu,  7 Apr 2022 07:18:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF27CC001D;
	Thu,  7 Apr 2022 07:18:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68797C0012;
 Thu,  7 Apr 2022 07:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47C0381303;
 Thu,  7 Apr 2022 07:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9ScuoRczvGY; Thu,  7 Apr 2022 07:18:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81AE4812FD;
 Thu,  7 Apr 2022 07:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649315936; x=1680851936;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5e8ATo0klmZdaCEBi88L0q/LM7DWwEXqIrBKodph0Us=;
 b=EgRD7tRLVlcS+WR2aeBqLNmi5HboGJ77jMMJV8zqqDxMwk92yWlgqIjo
 B1adUJm+QGs+B/GcV4gHqc1SyG3I4xe71vz6A7WmuwmI3xp3JRVZZ1gbN
 J1TcB4abljwdPuNQvE0w8IDObNil7wby1g86f/+t7dgzGuM9tdSnRS5me
 oAXC9yWvNyMSwQ3W2sX6EanYHUBF+Sbympk4kDyAM0y4Gbm0euvcQxWDb
 RlyO5FtEPkChtMKtX2KwVeUTp90JnQ12LSJjASenRBXgKsITqOnsyEl5G
 Y6+OVZlVbAoSCBebO7iJdrSSRyeCFm/Et6eiiW3En1wAQnQb4//7o6XnC A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241842272"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="241842272"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2022 00:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="524261484"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga002.jf.intel.com with ESMTP; 07 Apr 2022 00:18:50 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 00:18:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Apr 2022 00:18:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Apr 2022 00:18:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krkrtgu/2y50qXXjH78qNd0drEw+SOw2aHAKY7EUgmtKREL79h0xNhmDa99KKUjXNtGH6/oKEKJI4btlRCCq7FDLb36BtS50k3+OSs9yEV8oFHk0L7y71BZDfXclzNDEYqHxACuthHA1MXu3tgb4AunYyr32qL9lSaVnQ703c9AADfywjd15sLnH5GEtvcReG0b5donwIpsPmTtFtGKf1DQBoR+c5XAmSt83zDDndns+hRVZ2RPs/AT+XwZJarwtis8iPCIHl6ISqGJbK+nbZy5lvOFVEOO/tudF/3NTpW6k/9g6e1h3rxxfe7NwWeEzpVvuGirJFoDtq4oDraoNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8j15PPB/AeE8HEaprZGW4TrUC6om0xeGAM72fywzD0=;
 b=AAHggMlEwU9v3w3SacXWyzW60+tLaTmyhnddWsqP9HfX4gUTTL9i0g0khhMcwlQu+AhWTfObZerCxSSk0A7Z7xS2hEfIIegO2A0ciNUeiEmgOiJNlyAu5+jk9yoBGgHDLjd4Itgz+s9RdenKKKKJw6tAziRLJMXozpX57eb8Z0mvVIN5aS0MuFRkzpwdPUQgY4TOw2/o3gm+qJq+yNVKLp444x/xEufHK++Pyst4ZXwRU62NupPOndmVepYEzCmQO+ssLZOj0k6Rp2Clw+/RlXNp1B1RpUSCflbzZ0H6S5tmTANhB+9so96WC6mhfL3Uh1pwg7F9djD10qPE8fb1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5707.namprd11.prod.outlook.com (2603:10b6:610:110::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 07:18:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 07:18:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 1/5] iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY with
 dev_is_dma_coherent()
Thread-Topic: [PATCH 1/5] iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY
 with dev_is_dma_coherent()
Thread-Index: AQHYSQh/TPpLZZyKkUyXi1ZQWx4kH6zi6kkAgAAHtgCAAA8MgIAACRgAgAAEUYCAAAEogIAAEraAgADoPXA=
Date: Thu, 7 Apr 2022 07:18:48 +0000
Message-ID: <BN9PR11MB5276F9CEA2B01B3E75094B6D8CE69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <db5a6daa-bfe9-744f-7fc5-d5167858bc3e@arm.com>
 <20220406142432.GF2120790@nvidia.com> <20220406151823.GG2120790@nvidia.com>
 <20220406155056.GA30433@lst.de> <20220406160623.GI2120790@nvidia.com>
 <20220406161031.GA31790@lst.de> <20220406171729.GJ2120790@nvidia.com>
In-Reply-To: <20220406171729.GJ2120790@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22fda281-f893-42d1-4e51-08da1866dbf0
x-ms-traffictypediagnostic: CH0PR11MB5707:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5707883014D9342003E749908CE69@CH0PR11MB5707.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mjgxGVM+/EqvYHJB5AytpFHVz9phvYZ5P52vxcHLDwL1tolcYLMqNihbw8axleuGQ4ISfePMNkOX8reGY612fxUvYGx3tnX5QBQWQHICnEOT9odbpBKXzBi6O6NFt9vqBxZO7Dg2fHZvryz1o9lj1Izr3/LKNvQDpRndVJ3ANsC0xieweKsg69gU284+tQTdpaVHxyZ558rZGOTHlzN8b4hA671grfE6d3xaTJ/6odVH/YclSGexh3X1NqbQ33jhDu26UonBPDoUoV8joNQomDmd1Jki0cdoKheEhX5XVlpOtDTdRzfFFBB/FaY9D33bU1fFLJivN/3NqfM/wf8lpNkClfvj20Nxagf0eubjVZciThXS/W7/KF8zba/fiuY7QmiESrWfTs39jcaV2rHDQjgZTTmPUGTuWwTS69mw5G00JPEaUTWz+C+7FwvKzbZHmVfxhqMtvn710Eu96E/3aNjtnecF+2XAvf4NqM6S7sQ0/5wI3x5hsqvh+WEP624ddMZce64wV0bVCTl3S8fGLWVsn4yRVovptaTpeCLxyeSN1iXm8OHqXaIA0clmCcgZGEmP6O3a5P+5nd1tU4UBjTMnfl662aCunZyEpm7PvmGd1R0uzHOjKdIKKiijZujm8usbS3y/dkwdmh6mzvreaLl2mzzRgxd48FXJt2BFjJfoHb6wu/L3X8Nal34bfUHHeD11REfI/SsmXTbavVOxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(55016003)(4326008)(8676002)(76116006)(64756008)(66446008)(6506007)(7696005)(508600001)(9686003)(71200400001)(26005)(186003)(7416002)(82960400001)(110136005)(54906003)(316002)(38070700005)(122000001)(66556008)(66476007)(66946007)(8936002)(2906002)(86362001)(52536014)(38100700002)(33656002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A/kC1SCg4Xd3Ay+lXXrt+k3qlot0Veg2lw+584lGucDuMsgxu53GfrnpNvwn?=
 =?us-ascii?Q?2xClBb3HgGAY4EBE1web5uBpTFGMqehZIoCDj8Ydf/wsK9KG4LrgZol+ZOy4?=
 =?us-ascii?Q?z59roiLthGkSpeDFh58384cF5yqA1xs8TPHwCxZXa49drrnqngJ+yrw9xuFW?=
 =?us-ascii?Q?yYqcWDN15nEgFgJmKSDOGTMlHF86SedpBiajzNKj5Pq9BWpZ616MLWnf0TnJ?=
 =?us-ascii?Q?Fw5LPUSNZQMNmZyNI0/PvlFFURIL5M2WPDhpqYUgha6y8Y+KmgfGY1NRvpvZ?=
 =?us-ascii?Q?+ckFuKTdBdavonK8g9M4iywKR03JJFjTK2yqhBr07YgABOI6Td6YmOqrO0jt?=
 =?us-ascii?Q?on0DCgZ2YQ3J4HUPkq1sMc3pu/Z2anixZU4lBIWlnFcIxRZJ3nQI2lrM0ruK?=
 =?us-ascii?Q?T+ptMDBuVR/5HM7HRRSRSfRNRW9WBpnhxBWBTyIJaYcaM76Bo7EjQoaP/pEJ?=
 =?us-ascii?Q?PWwHDg+pbENmsi0R7ddUbjX/BjCfz3ybIyQsE0bHQiEO0weywsEvRLART6Vj?=
 =?us-ascii?Q?k1XOvUwR+jM+xxpTJO2bYrLItQB8yRsgYCoc63pvqyuJY5CuLTInERuX7QG3?=
 =?us-ascii?Q?WWbbAXhmrniuy/BrvZtxA08S+MHRx0Huc+Z8a1gkXodlPdtenjLBGVa/yiFM?=
 =?us-ascii?Q?Isbkv6Q5QdJdS0bdqfezkLa6OxkagWOed/I9JRfS6SfqWAI4pEK9IM7uMz9J?=
 =?us-ascii?Q?0N+Vf4eFKHUHTQnECreGLMLzYK8pxizg0DXbi5b0W8PI50OxuH9xE/fN22eg?=
 =?us-ascii?Q?nrmjg82FmDcgxuj7twVssqB5HyYUQTVslrZNlXDwvnDwfsiwRQLKtWzD2eYf?=
 =?us-ascii?Q?BQYcu+g/VhI+SwHJqVMCbcX2ftVq3hqLZhVPH0GassVMvwZnCJ9rZQK40Mqv?=
 =?us-ascii?Q?2gCEmEKrfE1804FgJkIyLChoGKoUBRUMZ6q1ddt7cwr27q3ItYXvjTkPpmsk?=
 =?us-ascii?Q?iJvOZNKl1qAqE4jogZr1lXKTDwPqwxmH5VhmtDEcV0cxZcqIpoChk2wwXtF5?=
 =?us-ascii?Q?KP6B4QfOgwVE42v1OMPl1RiRJQQrLb+cbZMpu56V3dKKiiOLsPQCZwps+9zF?=
 =?us-ascii?Q?X7vcFE8ATbqEDljifBnJXaQFVMOh66lFvW5krCjjDq8YPZVbIrPTzjYRIT4W?=
 =?us-ascii?Q?EMVoIQd/YwTp00jAmQ68Uaasy7myMoxIFI9CO9YApit29oEhRrGLX3r9PXFZ?=
 =?us-ascii?Q?Glf3yZ71ULm2et6oYAjrIpaBtUC5lYQc9UP15KpXoAPUInwehNfSCbpmRofn?=
 =?us-ascii?Q?gk0IkzunrKDo3/eCX3w6M5LB7rnFHB4GCm3HcREmBmf7IyvdFR25dl0CCE71?=
 =?us-ascii?Q?Q0ah8whPp60o1nG9ReXfO3NKPOFBpMxpZYppNkiXnHx9GPn/ML/ooXPMCIeu?=
 =?us-ascii?Q?YFwUePCTUEgcNvebnvzeCXp/di2DR/iq646EAccT4Z2WOqpdT+q6BL5D6LZ+?=
 =?us-ascii?Q?wDo30PJ3bsvJbk4WmXvb38hwZAcZdtJzhotE5ReV/nTDieyTPLnh4IEpJOzc?=
 =?us-ascii?Q?SEeVFzt66fkwc7CvS5o9IBAfu7KKoArR5WguaYJwSBCB0Z9wHtYtvDwACd+3?=
 =?us-ascii?Q?RllIqgrqMPTioq6sordNvN4ue/coc/6344S4mgS8jufGDhDcebX+Ah0qNGp3?=
 =?us-ascii?Q?M3a02ZegnV5x1q7OlMf8MXTpCYaQ/NHuvF2Il/ewi1NZXAtpazuqapOXmy99?=
 =?us-ascii?Q?eg1nAhDr2bN2kt7NQTYUyFZPFI+SVBFANVx7r5Zy7ZLCAqAE8sDw0xxuUOlJ?=
 =?us-ascii?Q?WvhidKLZTw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fda281-f893-42d1-4e51-08da1866dbf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 07:18:48.0161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tI6z4EE9qQUvFvSe+UKzqGjY/5+N/WNoqTxSl1w13Sb1wlXKLhKTVZchlGtAQVUZVxigP8BkLMXX5j5xA6I2zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5707
X-OriginatorOrg: intel.com
Cc: Nelson Escobar <neescoba@cisco.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Joerg
 Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, David
 Woodhouse <dwmw2@infradead.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Christian
 Benvenuti <benve@cisco.com>, Robin Murphy <robin.murphy@arm.com>,
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
> Sent: Thursday, April 7, 2022 1:17 AM
> 
> On Wed, Apr 06, 2022 at 06:10:31PM +0200, Christoph Hellwig wrote:
> > On Wed, Apr 06, 2022 at 01:06:23PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 06, 2022 at 05:50:56PM +0200, Christoph Hellwig wrote:
> > > > On Wed, Apr 06, 2022 at 12:18:23PM -0300, Jason Gunthorpe wrote:
> > > > > > Oh, I didn't know about device_get_dma_attr()..
> > > >
> > > > Which is completely broken for any non-OF, non-ACPI plaform.
> > >
> > > I saw that, but I spent some time searching and could not find an
> > > iommu driver that would load independently of OF or ACPI. ie no IOMMU
> > > platform drivers are created by board files. Things like Intel/AMD
> > > discover only from ACPI, etc.

Intel discovers IOMMUs (and optionally ACPI namespace devices) from
ACPI, but there is no ACPI description for PCI devices i.e. the current
logic of device_get_dma_attr() cannot be used on PCI devices. 

> >
> > s390?
> 
> Ah, I missed looking in s390, hyperv and virtio..
> 
> hyperv is not creating iommu_domains, just IRQ remapping
> 
> virtio is using OF
> 
> And s390 indeed doesn't obviously have OF or ACPI parts..
> 
> This seems like it would be consistent with other things:
> 
> enum dev_dma_attr device_get_dma_attr(struct device *dev)
> {
> 	const struct fwnode_handle *fwnode = dev_fwnode(dev);
> 	struct acpi_device *adev = to_acpi_device_node(fwnode);
> 
> 	if (is_of_node(fwnode)) {
> 		if (of_dma_is_coherent(to_of_node(fwnode)))
> 			return DEV_DMA_COHERENT;
> 		return DEV_DMA_NON_COHERENT;
> 	} else if (adev) {
> 		return acpi_get_dma_attr(adev);
> 	}
> 
> 	/* Platform is always DMA coherent */
> 	if (!IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) &&
> 	    !IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
> 	    !IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) &&
> 	    device_iommu_mapped(dev))
> 		return DEV_DMA_COHERENT;
> 	return DEV_DMA_NOT_SUPPORTED;
> }
> EXPORT_SYMBOL_GPL(device_get_dma_attr);
> 
> ie s390 has no of or acpi but the entire platform is known DMA
> coherent at config time so allow it. Not sure we need the
> device_iommu_mapped() or not.

Probably not. If adding an iommu may change the coherency it would
come from specific IOPTE attributes for a device. The fact whether the
device is mapped by iommu doesn't tell that information.

> 
> We could alternatively use existing device_get_dma_attr() as a default
> with an iommu wrapper and push the exception down through the iommu
> driver and s390 can override it.
> 

if going this way probably device_get_dma_attr() should be renamed to
device_fwnode_get_dma_attr() instead to make it clearer?

Thanks
Kevin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
