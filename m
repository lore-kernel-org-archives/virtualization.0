Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D548ECAAD5
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 09:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A29E140B20;
	Thu,  8 Sep 2022 09:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A29E140B20
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uk+RHB3G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Bk3nCGoW-Zn; Thu,  8 Sep 2022 09:31:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CCE6400F6;
	Thu,  8 Sep 2022 09:31:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CCE6400F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1171FC0033;
	Thu,  8 Sep 2022 09:31:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D006C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 09:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6C7440A0D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 09:31:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6C7440A0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sY-Hy-yTOIou
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 09:31:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3EC3400F6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3EC3400F6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662629469; x=1694165469;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+M/U6R/GGMoUKoxpHoIbMrg5AGsnm531Mzld3S2nnuA=;
 b=Uk+RHB3GmsjCL3G+Ak7ajqoXBIFT58rFGwwN/53o0vLVKb1J0Bict14p
 nnTfrER6auQTUKDLI65Oe8Zh9uAnKt9nwCQV4yPkfiRNXm+evGUucmMLh
 y9IOHlG7sVLIMH3Op+XBFDlaT8/qeVERSfOPI6/lwrJramz0E5vZRsQf+
 MdkQ5zdqzKV5Nyt9KcxeOWXnuHHC5ENInmHnJNletjNuD8JTN2VYEvyan
 tQhtt7OBDdHVkJQtCcCqBUD0msRqxELuiDa+Kx4Xlvc89o03NdcIKYoJD
 OMByUkDwft26+a/UG3cv63CQKayWZyDy6esJosa+yoOF8ApunnaoC3J9k A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280150211"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; d="scan'208";a="280150211"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2022 02:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; d="scan'208";a="645004338"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga008.jf.intel.com with ESMTP; 08 Sep 2022 02:31:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 02:30:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 02:30:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 02:30:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krl3kCzFdm1mLKXctpbh4p3yvz6krGFYkFdWKrFDRKY24PcrSnsHIMghGUg7kKlfjPX4LH1FoCxPEU1mlluW1b9iR/p5TtaPRMn0MOLAmqf/hWCFZKoAh94b477do8Cy+4d8I0dCMbHdVmMvIRzvYqx4RaPfsKLPs7AjoIzSqg9vW06ddfSMCB6dJ4ZKOpaulzB4/9nfy9AYtwHIoeGN0WJUeiHShwnRkZgYUZY6qqDTeWa1z6ECCwWtHhZkpEge18FC/TPAN/EOZlqUqYz3ihlmoUVkwFaWZSCYtilTGNs9jIXKNYT6zJhfZmRMq1KOMJaXyE+RomxMiH5MYhz2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04q1Njic1Lw1awKQG5RWZfyAbO4TLSX3ks38kU72jHs=;
 b=Md0gevqvrthK1mR2FDrPwEY/pMBiySLH4RIVDXBaJ37jFuBAKBcICflArY6UW4jRjSoMsrxUFC6Aw1DqI+eqfxaMfslijlOnfSnWfqdeguTp6k+NM5SLfBzjWzt5EIxq3AEg1KNhJftYbDQE+OQUXPRqqzgvS4WUkSwTGhDyBv5BOyD73F+IiBnEv5Svv6ci1a3ZuNOz54yKu4R4LDwJaJzThFCiWZ2E+E5aj9wsn8HDyJT5PoFFuJ8TsNpUahPGhxU0pkUF/dgJLrFK/YAY5bg+HMNRx2uIcO8YeIQ+PPiSTzXVBWsAaNEbFED45axdyofS1O6L92kNUUv0Ava62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5417.namprd11.prod.outlook.com (2603:10b6:408:11e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 09:30:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%5]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 09:30:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Thread-Topic: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible
 domain and device/group
Thread-Index: AQHYsNLwCXoHuSRk00qOEfaHbTrxlq3UDMUAgAASXoCAAAnsgIAALAkAgAAs1YCAAFRzgIAAh2pA
Date: Thu, 8 Sep 2022 09:30:57 +0000
Message-ID: <BN9PR11MB52763FAD3E7545CC26C0DE908C409@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220815181437.28127-1-nicolinc@nvidia.com>
 <20220815181437.28127-2-nicolinc@nvidia.com> <YxiRkm7qgQ4k+PIG@8bytes.org>
 <Yxig+zfA2Pr4vk6K@nvidia.com> <9f91f187-2767-13f9-68a2-a5458b888f00@arm.com>
 <YxjOPo5FFqu2vE/g@nvidia.com> <0b466705-3a17-1bbc-7ef2-5adadc22d1ae@arm.com>
 <Yxk6sR4JiAAn3Jf5@nvidia.com>
In-Reply-To: <Yxk6sR4JiAAn3Jf5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5417:EE_
x-ms-office365-filtering-correlation-id: 02cd2be3-fdeb-47b0-fb27-08da917cd606
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJXMX+8m1yTDC3Lxij7ocl/Jqf4O33cvyuaqUCRehGL94JY7m7CucRpxrAsOgc4z9jjKefFok4KFBnsv7+xy0C9Y0C5E0N0H7nWgCwmMbddx+SfQePPWbvDRYG72ryM4wqfLgyWYJJ6aE6urWn0nKdFzEokyGRTdXP+XrUwxBMC6MHKwRdOMQ3QS5rF1XsiLS5UMtAkGC7eCn8uAGVATlBZFiKkO7ERENibTq8T309/xIs2zmt8JiZJPHffLH/j4fKMcV1w5pvigI2x63uhkSEMxanUh6O+DI19AHsm0nzooJPfoi1Fs0Yg6Ow6pX81GId0fsNIsuzZrMrDs0z3awzdhNqKMTkq/rETXfavoQAwRCp+VSnVNoteS9vK+sd6MsBBun3nCG70MatbUk8pB1N5w/zTv2nIuCQ+39x/LP+R0sm3igfjTC7PPTtvIMG1+OSbIikrEkLNOyXa5tvZeP58GPXnVLUvrAMMd5fEzQZzcsE5XrutIUdKevkP8lCGa9InZ9VZqQ5cOAlDObApVU2BJ9qq3+OrPkgsOwgICmgfycoC5QOzAEzNJLIiNsxjSLIqr7RWHAqANnP6XpzeMH7l3d2suOx6KwpfPLhAHzAeVgGsY60fSEnofcbfireSgPcd7X9cL94LqIFViZ30pE0wPamhRkzSavwzDxj1VxDA+zvX78s8zupLxQnQgJq2ytL4dsurcppkmjfIwaYvv4uhSN2aURBEKxFaGosv/kR24ygVxHUh2Ao4SD04yqsymK/PPsaTj13ChqogoMt1vyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(110136005)(82960400001)(38070700005)(66446008)(38100700002)(54906003)(122000001)(4326008)(66946007)(8676002)(76116006)(66556008)(316002)(64756008)(66476007)(55016003)(7406005)(5660300002)(52536014)(2906002)(9686003)(8936002)(7416002)(71200400001)(478600001)(41300700001)(186003)(7696005)(26005)(6506007)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qjajnYoHTKNQSTvcwOgxMuzhpOnt59JWPw9PfZvrz9klxjaTnQn3IcterkHO?=
 =?us-ascii?Q?3dIFXggkT7UDica0O8qHRlvQJkRoj9btEY84asv1S6MLCLeyN9Rb5QDzedy2?=
 =?us-ascii?Q?5RaJoIOdavFiu/vQG3KPoouIePYQhQa9M6RWmM2m3YuOkVfUcoStA4/XGhtW?=
 =?us-ascii?Q?RhpVC/MWqHvyO7h5Q10d0yVvxE4b867Bt+D4uZ2nVpeVIXw61Ws3DZ0gPfOW?=
 =?us-ascii?Q?oLg8Kt317S36QGOuz9JA+h6fOI6oe0A9Xj583ZbH6L8TWEt7AFNKiaioWqpD?=
 =?us-ascii?Q?ORih3pgxHJEHs853r6qDFV9VlGA4Po/TOT9rMfRdVVOtaeL/mslUkVIralG3?=
 =?us-ascii?Q?q3+BTm1yw9QC73IMHFbKKWCIOzhWPyoU5YRF2x5dl2Kv2aO5tWCcw6JFKSuL?=
 =?us-ascii?Q?TKbi5lj3PItRwTcaCWd0jtoHeaXPfjcuJA/9ET0uofOFwS0kz9KS1HS6HDh4?=
 =?us-ascii?Q?gH5N1nOm7eg0WW8CLRJjUEvWq6lkPdCfcXzv140Q3o57KPF7Sa9AtIP1DTO2?=
 =?us-ascii?Q?W0ORafXVhoeR4DcyBkxhpx8N+BJDyKgN7XT4vatscfPFGyE9UiAQPm+o/vam?=
 =?us-ascii?Q?uMV1MfqGwbJx2BohKqMqOrc7rf06/NLt4VYNYdfkfPx/vhikSi/2UY080D9L?=
 =?us-ascii?Q?KkUbKN6ytu2hzAci/PWxmTTJJzYA0Th9Ei7aXSDIfQY+x7vcuatfFasFLLkH?=
 =?us-ascii?Q?8bsWji844fVol0YAJ7E6yjeWHymP2YH+kxAnSqFo9k8s72s4mhYQDMww12Wr?=
 =?us-ascii?Q?LTS14fanRwgIV6URBVoucyl7x/R2Io/x9N6fI5E8zqZhaEDNrQ5B+LaIochf?=
 =?us-ascii?Q?Ax8T2YhYdE2t+i5mALlTylrmGzJ/bsugY6wRSungvG6oeilOif8F6ViimG5C?=
 =?us-ascii?Q?Eays6zEUT2TkYcs6GciqXYIYyNy4CdgeP85+qjEfCDN5zuLIqAixAhSSrRkp?=
 =?us-ascii?Q?Ssghq9mG6Cdm7N76miiR0imH2aRvXCNmN8jPacllyz94IkCz9EVHrfk7WUqR?=
 =?us-ascii?Q?RqEECpLEh5o3E06ZU0C3qmNtOlRq/lwbNqYUipMTc3S3GiD+cfxgo9k/S0e1?=
 =?us-ascii?Q?p5j2Wyb208Hs+sJvIeJ4B6ac/s+LH8drL4XgzWN1UsiwlOI2R5+WDUMBppMw?=
 =?us-ascii?Q?MJOAjSRGrB1tbxShlWRA/ePaHTfazwT4lLZm1KJj5qQKav1sfEiKYCqkPSLS?=
 =?us-ascii?Q?71Db/8IJa+z+K4kYa+AotdgeZ7AHNEd6xraSsB5fcRDMnHbUxHAmCjun4bol?=
 =?us-ascii?Q?/kZP8kL/TIbq17WBQXLX92jKX4WFZVKI80m5gppD+xxjR/QSmxYJ0FWtuO+f?=
 =?us-ascii?Q?0s2K2ZMlKTp4n2ZoHof5Ab8Vc2MgeVJNZ6tvKZUu/4vVmHatuTx6lf6C6MEK?=
 =?us-ascii?Q?JSy7Csy91KOnqPj3zKTC32xF7kNU4t+I75DrvBvogh8a/7xmzFb6w7dtMNHa?=
 =?us-ascii?Q?CE6mob/wFjg/2UCZZqq7NswGP1rabolQ0A+irF5IY9164MLpTkGnhyy9DqDj?=
 =?us-ascii?Q?Z6utUYOiT/QdisDv1JvXZSpj6VIhYwxjdfpoXiZbTN8UOhiba9KFFP6m/W2c?=
 =?us-ascii?Q?eh4FLaKMX5hf8krDicvxDZBeDuHC8Avvc2G88TUN?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cd2be3-fdeb-47b0-fb27-08da917cd606
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 09:30:57.8788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ar7ve0/LwnTDqWL+4B0xnyiAKkRSjnNvwN05/Ycwu5IS2oI0V+/Kc1OFgzaeRGaaH08m6dOQTWiBJEXebsM2wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5417
X-OriginatorOrg: intel.com
Cc: "marcan@marcan.st" <marcan@marcan.st>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "jon@solid-run.com" <jon@solid-run.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "sven@svenpeter.dev" <sven@svenpeter.dev>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
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
> Sent: Thursday, September 8, 2022 8:43 AM
> 
> On Wed, Sep 07, 2022 at 08:41:13PM +0100, Robin Murphy wrote:
> 
> > Again, not what I was suggesting. In fact the nature of
> iommu_attach_group()
> > already rules out bogus devices getting this far, so all a driver currently
> > has to worry about is compatibility of a device that it definitely probed
> > with a domain that it definitely allocated. Therefore, from a caller's point
> > of view, if attaching to an existing domain returns -EINVAL, try another
> > domain; multiple different existing domains can be tried, and may also
> > return -EINVAL for the same or different reasons; the final attempt is to
> > allocate a fresh domain and attach to that, which should always be
> nominally
> > valid and *never* return -EINVAL. If any attempt returns any other error,
> > bail out down the usual "this should have worked but something went
> wrong"
> > path. Even if any driver did have a nonsensical "nothing went wrong, I just
> > can't attach my device to any of my domains" case, I don't think it would
> > really need distinguishing from any other general error anyway.
> 
> The algorithm you described is exactly what this series does, it just
> used EMEDIUMTYPE instead of EINVAL. Changing it to EINVAL is not a
> fundamental problem, just a bit more work.
> 
> Looking at Nicolin's series there is a bunch of existing errnos that
> would still need converting, ie EXDEV, EBUSY, EOPNOTSUPP, EFAULT, and
> ENXIO are all returned as codes for 'domain incompatible with device'
> in various drivers. So the patch would still look much the same, just
> changing them to EINVAL instead of EMEDIUMTYPE.
> 
> That leaves the question of the remaining EINVAL's that Nicolin did
> not convert to EMEDIUMTYPE.
> 
> eg in the AMD driver:
> 
> 	if (!check_device(dev))
> 		return -EINVAL;
> 
> 	iommu = rlookup_amd_iommu(dev);
> 	if (!iommu)
> 		return -EINVAL;
> 
> These are all cases of 'something is really wrong with the device or
> iommu, everything will fail'. Other drivers are using ENODEV for this
> already, so we'd probably have an additional patch changing various
> places like that to ENODEV.
> 
> This mixture of error codes is the basic reason why a new code was
> used, because none of the existing codes are used with any
> consistency.

btw I saw the policy for -EBUSY is also not consistent in this series.

while it's correct to change -EBUSY to -EMEDIUMTYPE for omap, assuming
that retrying another fresh domain for the said device should work:

	if (omap_domain->dev) {
-		dev_err(dev, "iommu domain is already attached\n");
-		ret = -EBUSY;
+		ret = -EMEDIUMTYPE;
 		goto out;
 	}

the change in tegra-gart doesn't sound correct:

	if (gart->active_domain && gart->active_domain != domain) {
-		ret = -EBUSY;
+		ret = -EMEDIUMTYPE;

one device cannot be attached to two domains. This fact doesn't change
no matter how many domains are tried. In concept this check is
redundant and should have been done by iommu core, but obviously we
didn't pay attention to what -EBUSY actually represents in this path.

> 
> But OK, I'm on board, lets use more common errnos with specific
> meaning, that can be documented in a comment someplace:
>  ENOMEM - out of memory
>  ENODEV - no domain can attach, device or iommu is messed up
>  EINVAL - the domain is incompatible with the device
>  <others> - Same behavior as ENODEV, use is discouraged.

There are also cases where common kAPIs are called in the attach
path which may return -EINVAL and random errno, e.g.:

omap_iommu_attach_dev()
  omap_iommu_attach()
    iommu_enable()
      pm_runtime_get_sync()
        __pm_runtime_resume()
          rpm_resume()
	if (dev->power.runtime_error) {
		retval = -EINVAL;
            
viommu_attach_dev()
  viommu_domain_finalise()
    ida_alloc_range()
	if ((int)min < 0)
		return -ENOSPC;

> 
> I think achieving consistency of error codes is a generally desirable
> goal, it makes the error code actually useful.
> 
> Joerg this is a good bit of work, will you be OK with it?
> 
> > Thus as long as we can maintain that basic guarantee that attaching
> > a group to a newly allocated domain can only ever fail for resource
> > allocation reasons and not some spurious "incompatibility", then we
> > don't need any obscure trickery, and a single, clear, error code is
> > in fact enough to say all that needs to be said.
> 
> As above, this is not the case, drivers do seem to have error paths
> that are unconditional on the domain. Perhaps they are just protective
> assertions and never happen.
> 
> Regardless, it doesn't matter. If they return ENODEV or EINVAL the
> VFIO side algorithm will continue to work fine, it just does alot more
> work if EINVAL is permanently returned.
> 

I don't see an elegant option here.

If we care about accuracy of reporting incompatibility -EMEDIUMTYPE
is obviously a better option.

If we think attach_dev is a slow path and having unnecessary retries
doesn't hurt then -EINVAL sounds a simpler option. We probably can
just go using -EINVAL as retry indicator in vfio even w/o changing
iommu drivers at this point. Then improve them to use consistent
errno gradually and in a separate effort.

Thanks
Kevin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
