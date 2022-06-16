Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E8CCA481
	for <virtualization@archiver.kernel.org>; Thu, 16 Jun 2022 06:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3326683FFC;
	Thu, 16 Jun 2022 06:45:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v4MP-3e0hhL6; Thu, 16 Jun 2022 06:45:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B49EE83FFD;
	Thu, 16 Jun 2022 06:45:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41C4FC002D;
	Thu, 16 Jun 2022 06:45:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51B1AC002D;
 Thu, 16 Jun 2022 06:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31C8E83FFC;
 Thu, 16 Jun 2022 06:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NR56-oMJyx7x; Thu, 16 Jun 2022 06:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81A0783FF9;
 Thu, 16 Jun 2022 06:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655361914; x=1686897914;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WOn9tHKFN4jySEqTpvWOLqC3Tn3IzzhbgYIbD1ZNtFA=;
 b=eRj3EXfHC8aEDLywjdSGUy/cvcd4CNUWQuXpNHDpOfPtyoEaqkOHGULr
 LkNj2p1gAoH5wyXsm39VuNzcVnICFO/+T5aFyJu5JvB1IJutkLQxepPfq
 EW55AU9niBsn0xX1SclqDthhsIatXNRD+F81fP65VS6o7+vk62remymy+
 sub5eNVH5mVF6Cl/espKjsEa43TzAZ7ypudndF3wG1RR3Ry7oNs261DQP
 VsdhalUtP8a5SK5DbU+FYd0L5eZ6v9fVKU7PUKB4yJYK61/zo6SL49rWW
 jHId5Re047CMYzYy6oArqp3sn9sr5G001nv1s4Amhj4M+GBoBiJr6Y/ha A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259035174"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; d="scan'208";a="259035174"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 23:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; d="scan'208";a="653031645"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2022 23:45:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 23:45:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 15 Jun 2022 23:45:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 15 Jun 2022 23:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyNYjBc5Eypaq2ZpdcWgveo0HohAlYYOaQcnAhtgb/XuygnvsaYISouztHHau8eO4UW3MwR4hkR3CJmUdF3R2lsU0WHzLmbc7kah1wr4QBmRjaU/lyGWUCsOyfByER7cF/JD+/fcohB5elodJzFwM1BbQvpcbGNh4wBqj+//nZg5w9ee8Y+uh3Odzmw5FZr/06RVpN1aRMHd0PatqSdITowfkopuRdnw7Xod7bzc9uSE3VrWy2REZC3Adk+l4jcb+qqqMc/ZA/kywwBOzHPtdyU7/LgciWzAIMVLzT53PcpAUaf896SbAhGmnK68VaJ+CY8jrRYOPvZgyr3F6Imsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9nje3fQMnUL+n+mM6uslYIXblaNXub4Egd78/aX0GM=;
 b=ixhNK6ekpmuUHhMrN1oP61yB6ndvXKfYhhjBaJwUok32DYqMKFvsw06k+Ft/ixXQx03/hUfgEcsKPbYhBuqUOAkK9eorI2ih/sVDzvOUHGA7qhi6J9Iwvyke3e9zZdguE8BqqIGid38DAGl2WH/9Ddv9T1dHj+nUeJMJimiAvufO4XI3GVGSjDpQJzjjtb2HnnIUK40FvWWvO0a1J5jW8hdpePIyec4oTAmUZ3bSBoN15Ww3cbgxSW7l65Q5doDWXSkmGtUPJC6n0DeYMNXVD2vGdlu4yfIDZACyjAgF/Btwke0fpCEsuRu3wl9uY9USSeiXYb2TCmczIadYyxS/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SA1PR11MB5921.namprd11.prod.outlook.com (2603:10b6:806:22a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Thu, 16 Jun
 2022 06:45:10 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69%6]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 06:45:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>, "marcan@marcan.st" <marcan@marcan.st>,
 "sven@svenpeter.dev" <sven@svenpeter.dev>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "robdclark@gmail.com" <robdclark@gmail.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "orsonzhai@gmail.com"
 <orsonzhai@gmail.com>, "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [PATCH v2 4/5] vfio/iommu_type1: Clean up update_dirty_scope in
 detach_group()
Thread-Topic: [PATCH v2 4/5] vfio/iommu_type1: Clean up update_dirty_scope in
 detach_group()
Thread-Index: AQHYgRSOSTQmyikHpkmzEpoCyLPpz61RlbrQ
Date: Thu, 16 Jun 2022 06:45:09 +0000
Message-ID: <BL1PR11MB5271A40D57BEBBA0BAA4C0BB8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-5-nicolinc@nvidia.com>
In-Reply-To: <20220616000304.23890-5-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83dbb2ea-8fa0-40e8-cf97-08da4f63c1ec
x-ms-traffictypediagnostic: SA1PR11MB5921:EE_
x-microsoft-antispam-prvs: <SA1PR11MB5921582FF95F6623BD397D8E8CAC9@SA1PR11MB5921.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XG8p0J3EGqPX23CfWp61m3tZ54gR8zbJwGsX1RXRfCj44PqtrFEZ4omEXPzP1KQrdUa3GMsgerNH2DoL0T29vs6g1BWL4CJ9PJ5qk/ZWRTcTcIW9g3s5kijOcDkPNRnkPOj8xyVj41BUn8bLoz8V4fH+z2N1XSFBKGSCpbuOmvjJh9MB2nFYHf+PsatPRC4vNDX/GNgiOeFcfiwJM7dRmUdHXSLgIna8sKoJHKSH1iKoIl4NdxZYGehm00RnepmoMD1PXq7RhnQLY3JIOH3WudInzD12P2E/jeksXopTgikY5ELj6+cnPB2OWr8wzzoMcYB9euv561oTFJgQRPTEDVB+GX/yIg1Oihp196HG8dbGkTw3Y2b2+YgO9IbuHQ7BUGkEZ3mQlOamQjPA+YTXUIodXCLRkCaVLEu+VSkmrQKnHq30jnRyX+xiunwynji+kuZ2bG5zhqWkcWlT9aWP9c4cxpjRtemZCDt39LhToOo1UUQ0Mn9DNnXmcVtIkCkJ7OdDvSP4g+lhnNoeWO7ZgRDQ+r+bRKB9iA3qsVPtpvzSZdPih0WqWY8Pj4ed24VwBZeSzWfzqjLArLSmazj1wmTD3DzJRahbEUwAYHcvfPezn/TtQaQuKjnMLK3goWlyYHbEOF2ABcgAm6lsRtItljKzvQUwjnY82LaSejJDYdjcxiWt2haJCbyxOe2pTb6VI3JsVYGl3B/8b+lYMuU9bsbjBVROrog2LKPuv51gLJQWSaUHrOhvxyG0KYRqepO8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5271.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(4326008)(83380400001)(66946007)(66476007)(8676002)(64756008)(66446008)(66556008)(6506007)(15650500001)(82960400001)(8936002)(316002)(7696005)(38070700005)(110136005)(186003)(9686003)(508600001)(7416002)(52536014)(33656002)(7406005)(26005)(921005)(86362001)(54906003)(55016003)(4744005)(76116006)(38100700002)(2906002)(71200400001)(5660300002)(122000001)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0QJw7AlEjYSIm4Cf9rI9JDggP0p2pxgrohLK+1LPgbXX1hmbBmsaet2ZPYXh?=
 =?us-ascii?Q?+N2YDAX/vHefqYEnD3+xOMac0tuCsizY+gBKmJVaMgvbPF3svAwqjQ+LZrTv?=
 =?us-ascii?Q?pmOaNMfkhgM/yNv7PU0P5dBzonTmww0KkjRZyKw5DYdTVwP7DgGnUVLcLTTY?=
 =?us-ascii?Q?posLcWr/uX85ih4FWJnovSe7TcPatqAI5gF5/CcMh9H3i8zi3tsBnJ5UKh49?=
 =?us-ascii?Q?UatzfmZD4dlKXgV7Qr/B/hnZIznzyto77gh8TOyZGCOW7gaBJ07ED9GjZUbg?=
 =?us-ascii?Q?XerO3jdfWumspjQ8K+SUdwX5XAqBixWYKxhTqPRr7DNLdPqSqrO7t9Mthm2F?=
 =?us-ascii?Q?9srueKbq1Xx8FRh71LkX9GDlwypZQOuCQnOMF7nJRj3FRHmjcuGkRQAYYbV2?=
 =?us-ascii?Q?rXZ+0nfTH8XmaSVm4aPW2BOiFfA53rHtXJN1hVflGBDCePDafjQx8+3Oo/yV?=
 =?us-ascii?Q?W0Sv9u3kwCbsesyP57jseH5cO8Z0IqzESO1MWYEA61o2W7H9vGIF59dQhvw5?=
 =?us-ascii?Q?CgX96B9lH7vIxKc7d9wxhiae4cnrzVXdYtz9TLi8ido1tCz5BaSQc6ualnKx?=
 =?us-ascii?Q?uBdcIvnPE6DOLultbq6EVrXpASqfHfRJYWM1Wq7trGSgyxF6B3vlCgfusFMd?=
 =?us-ascii?Q?Mb9TlJFCK2W2PiYVR3gpmLm0XWZ3yn7jtxFUVejdcWFGoUvKLt5MdDChe5Js?=
 =?us-ascii?Q?z0tb14rMokJurTm5VPVmAmsDqxY37YPAcD2LN/kz7V0sdVJpxdldcVKSZWnJ?=
 =?us-ascii?Q?CZuJ7s1NAqaMQkqsj4Y8xLxf3sKMsiObumv1kX0RXJatClNaop6DX2V2yxBC?=
 =?us-ascii?Q?Zx5KLlOW4DOSguGhrD7AHkWwXip7GCBcF9VRVefkwp26mToE0q4yCYuRLM9x?=
 =?us-ascii?Q?eq8+KMykZ01NVnTinzFxRppjxSzTmEG8yqed5FUQzZ8jsrs882JqV7OsMYML?=
 =?us-ascii?Q?fRMcFNfElizKivVEzVs0/cdN93hpchpPNoQ3YTrYpwCPWXFQneQK5LlVfa3b?=
 =?us-ascii?Q?LoijpJTJyd4w7M1N3J7PcP6GMhhpL0m0n1ZBngZbBy8SgKVz5z8WVUA+R7bs?=
 =?us-ascii?Q?/QHwKc60H4RXrDJqf9HuoWhwMoO4inLWdz7pQr6Sskdr2+Nx0wccogWnFpSz?=
 =?us-ascii?Q?PX9QG91FIOrqZsre6Uh2NMF27CPBvAUkU14tzh7XTLVHFpmNnFFwDxHBKugw?=
 =?us-ascii?Q?kmkqTEdnwrO9jW9eZp3IAMygs2F6FHHoET4FN6lf175Cu1UyMji6l8Bjrdb4?=
 =?us-ascii?Q?UDk9IjPAV2vl+g6uO2ZcLnkXiWeQv5FEyOiMXSvInVbzv1He+ZVAKGwmwZZG?=
 =?us-ascii?Q?WFAlLovTxQEX08QCZIk/En0qaCfjagV3AXPw9NaQfGQqLpXWmEVjWEGIbeda?=
 =?us-ascii?Q?U4I3thp0MYKE/0XnZXmdjs/Ocl9cfa+Kvwd+QCLHQaDYjhRGtpyebddruX1q?=
 =?us-ascii?Q?HKiwlBjIzvBLYBFOGsndk+VXMwPNKCzM5IqOtodkDUJEHo4QpS/WMm8pjNLB?=
 =?us-ascii?Q?LItUdP3LPRlb8O12/YpEJY1H8ty8eKB++J6OuWW0s2+HnDefqeVqoR8Z+0NL?=
 =?us-ascii?Q?AtBSNdU4Xr6QUrRqv6Cxohr3032J/y8lF7djxyFvao/4VQZ8kzwWf2jgJc/W?=
 =?us-ascii?Q?+Kn3zwffI9WnRDEPX5ggIX0fKoYdwxikH67AQs+WfViikJMWXP4LELZaDld3?=
 =?us-ascii?Q?fChz3n0m+1lBUOuesCVyV5KGbkvlrB/3MqdtRNjbi1H4p3Jo+fKJezEpLodk?=
 =?us-ascii?Q?FRRRi/QIHw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dbb2ea-8fa0-40e8-cf97-08da4f63c1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 06:45:10.0069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QrqTUdZ0wTk+htFXnNTEYMLiXH1WLpxs6ugq5thyEZtQumGnAvxjhmB0x4QPZaBUuwyeXAHjBYZUCl7MF3bYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5921
X-OriginatorOrg: intel.com
Cc: "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jordan@cosmicpenguin.net" <jordan@cosmicpenguin.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>
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

> From: Nicolin Chen
> Sent: Thursday, June 16, 2022 8:03 AM
> 
> All devices in emulated_iommu_groups have pinned_page_dirty_scope
> set, so the update_dirty_scope in the first list_for_each_entry
> is always false. Clean it up, and move the "if update_dirty_scope"
> part from the detach_group_done routine to the domain_list part.
> 
> Rename the "detach_group_done" goto label accordingly.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with one nit:

> @@ -2469,7 +2467,7 @@ static void vfio_iommu_type1_detach_group(void
> *iommu_data,
>  			WARN_ON(iommu->notifier.head);
>  			vfio_iommu_unmap_unpin_all(iommu);
>  		}
> -		goto detach_group_done;
> +		goto out_unlock;
...
> +out_unlock:
>  	mutex_unlock(&iommu->lock);
>  }
> 

I'd just replace the goto with a direct unlock and then return there. 
the readability is slightly better.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
