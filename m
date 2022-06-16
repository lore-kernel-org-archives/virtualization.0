Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C5BC43334
	for <virtualization@archiver.kernel.org>; Thu, 16 Jun 2022 06:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1421861106;
	Thu, 16 Jun 2022 06:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B2YId_nH8kQe; Thu, 16 Jun 2022 06:29:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7715E60D53;
	Thu, 16 Jun 2022 06:29:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 127C7C0082;
	Thu, 16 Jun 2022 06:29:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94F0EC002D;
 Thu, 16 Jun 2022 06:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73F3241A2B;
 Thu, 16 Jun 2022 06:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gKh-rzk45glk; Thu, 16 Jun 2022 06:29:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6589241A28;
 Thu, 16 Jun 2022 06:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655360968; x=1686896968;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ALMW1HSohq9R+EcuJOlef90mw8xioYa4UMKGSXSLgXk=;
 b=U0okRI83Vt+eM0QxrqVxHAaUycq3NTvUnex9uYeK+pbGP2k5EB/5RuL0
 mAU2ilnnBeCR+M5zRkruBg3MfPbkqkmvdpdxgdYvqry+3rZDXsxti/pPJ
 DBZ/I0o65etZF2brWMmzlnoV/92wtzJ4yHHh1oErNcXPPVDIS+bMH19p9
 DLE3HoK8KWf9blFMxlvdYPGEz4+tJDKDJcuCpsaVqnkUkjBrjUXpe0YQY
 s2g94x7bEYp3ps4rMN6tSWpK10ZLP2jZogg1R8vcTDr1e+p3J2Zz/BmDh
 ljWZXSwecLtN6q2OGhe8CPFCzb7Q/01rBmTK6I5RkaS1agD++yhyfT9p8 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="304618834"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; d="scan'208";a="304618834"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 23:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; d="scan'208";a="762758131"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga005.jf.intel.com with ESMTP; 15 Jun 2022 23:29:26 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 23:29:25 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 23:29:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 15 Jun 2022 23:29:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 15 Jun 2022 23:29:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzMzbRCda/FpvjEMylYTLmKFS/emrpRyARh/3IOLcaza1tMwG74oj/knFKoUqSrUzXQWHIpf+ecfIQliybsYZX1vx52niC3WuJWGUlCRm123jTdfHdgZzYUBah0o790EAM/QIvHxvQYYJLIRQUTZPmedqa6CN+EZXV4MUGPD78WfP1qUXByyXJtIV5Qz8YXMuX3pFhm3+VIwnlL+/G2/gm227HlNX9usWezJR16oeR2fS0Sac3+5TYe0Y/axYvaSI6lnKQ1k1PfTDKTZhakDjBlIDRyOAW8JXqp+PHnXLsslNMZU6Whx4zQZEatO1VLB5lYYDtePk3hfgh5yOUB2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALMW1HSohq9R+EcuJOlef90mw8xioYa4UMKGSXSLgXk=;
 b=YyXflnohkAxMwSMkyOiApZV4lyZwN0mDbsd75MBCDrGB5H9VKdG5C7sWoFOCNrbSaCjhVVqlFAg5CshK+wVbMUSGNiNsOaDY6Q8ZHeipbjQmzEe36XBZfRTPYAbbfVO0XX8uIohjj/1CcoTQqqAgzAGwQhP8orK4qEpX+lOgECkEZRAZWh8jBOZjyoh8A9IX1oMojE/+PTswJQdQP4n7Ub8P1fMMIsvkVCMQpI/Z5duISfyDtnWpp4udD2mdHahPw+yrpf8q69SVE1yFTsdCBPHgcx66Mfmv/aCuvEvyS9T8XcTAsyqMZGgkwoTM+DvGxP1zqLZ6xO9+fa9NUoqF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BN6PR11MB1810.namprd11.prod.outlook.com (2603:10b6:404:fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 06:29:23 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69%6]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 06:29:23 +0000
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
Subject: RE: [PATCH v2 2/5] vfio/iommu_type1: Prefer to reuse domains vs match
 enforced cache coherency
Thread-Topic: [PATCH v2 2/5] vfio/iommu_type1: Prefer to reuse domains vs
 match enforced cache coherency
Thread-Index: AQHYgRSE5M8ZUAHYLkSGjazAVidGPK1RkoLA
Date: Thu, 16 Jun 2022 06:29:22 +0000
Message-ID: <BL1PR11MB52718BE8A6D1BC328CE4CF5D8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-3-nicolinc@nvidia.com>
In-Reply-To: <20220616000304.23890-3-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ec2f908-9caf-47ef-e70d-08da4f618d62
x-ms-traffictypediagnostic: BN6PR11MB1810:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1810CAF1C088231E0AFE127F8CAC9@BN6PR11MB1810.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIDsecM2cHpdAPhHvnaLAUyBe8m3arQdamiF+Eerv2BNZi7X0E58llsgKr9EroHUikS/u0/2YC0sbZqDFdYAC75ivmXuS8EAxuSNeqWnvAwqVviq5l+5oZ+NQ9L3Xzq7fB5ygqipoUDbJt7b5YeKuE/t6J7aVmGXh90Q/2oT2XgdhTDd6ZLPwBcs2DNNjmMEeNZQNroH4OR2fTTGGX0ws27E0Xp8UzFQQqwyl1eSc+M3Iu9poVDhY16pgS3JLxsd9an5+ozUSFitjBketmdxIb9tspavtncZgX29DZmJW2LFqAU88Lw2lJOOaMTLqFQJihqW1E1gSoYQ+BUso4mFgXcqovesn72pKqkH/IPrOfDBVUgVewwVZCwYvT6z7Mn0QTBeYh8SqGY0E9LnSCZLtgHTPj765O/2CMwbL5xsxngmu9lIYfeYYSDe5Mw2tue0t8AcxlAtFab7F362EU+e670jw5vuD1BvPuZDL6XX++iB67KAEwCEqwQwAO4AD34TBTqQLREoZmyXeiSQqz8pyd/SJsyhg3aPWCl78t9hNE8Wf8UAsE/Ja5oJMnDPGF0qOOEg0ZrDPeY5e+RjzN80/qUjA1RfbWh3zq9pJ8ysyLB12MtN5LmHAUTIoVtu7pT9dRCh40gPnE8+tnYrmqvmHWoyWebR+5SYJ9jAjhp3AiyRDrtkSVeA+0e9yM6aNIJAF1MdL/SMs7vrdZo41rgKm0lnCsINucxNaRyI3S2Wn7A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5271.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(71200400001)(508600001)(8936002)(52536014)(55016003)(316002)(33656002)(110136005)(54906003)(83380400001)(82960400001)(8676002)(122000001)(38070700005)(921005)(186003)(86362001)(76116006)(7406005)(7416002)(66946007)(7696005)(5660300002)(6506007)(66446008)(66476007)(66556008)(38100700002)(64756008)(4326008)(2906002)(26005)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3DVTwIkI/UPgq7NAMbF++9SbPdguki3ZZXLDToiKAfIsUPv+Y9ZW+77wxAFX?=
 =?us-ascii?Q?G/S0Tj6iAgRLjCKXS+TV88CkPW3ZRKHkh7PkbF0GZBD/io5Pg4nkp57xZKN5?=
 =?us-ascii?Q?Per1vPJOXVtBJl4JYvKgSgNWFw4LjgVImpJYk6BqkWys+bWGT3bEox5nuGXr?=
 =?us-ascii?Q?xU1mrc1f0wnTIOORjBRhFghDpJY+dj0b4aqO+yLm48Th8XuMSxma12AtFBJ8?=
 =?us-ascii?Q?MGh8es9tourucy52FhfG3osq1FN19jnsxWu5C5nrO+asxBcZyompsJJYN1af?=
 =?us-ascii?Q?d9Ip11O1FjLmVivifjIRw9pZNJfAAb16NEwzuOWtam8lgrN31a+kC2vz9qiT?=
 =?us-ascii?Q?OmTHvYHYVMkwVMmiU+wgP0m/uHajmJsiFbaoh6pjUJRHJcXFjSVV+PDBVeuU?=
 =?us-ascii?Q?+7T1B+i5S9PPIbAfGV+IZJo/WU0s37WxwA2z+KXFwg0t/1eUpGDtRPAb6NNv?=
 =?us-ascii?Q?tyLQViO62vxiI+WVxWOtI71SAN62CCCxSFrFndRDKFfE/p7TMk6XMJ4Cqy+i?=
 =?us-ascii?Q?RBIh+evIeDKEe4C0kgLqFe1mohZ/Bj0MqvoensRBvNNSllRjwIYaQCOQvhO3?=
 =?us-ascii?Q?y1VtMDrYlSI7lZVU9hXG09FO2pTc6BbMUfJvW37h7JKz4sFxdloKMYzV0pZX?=
 =?us-ascii?Q?BKaQ+BVmkePmmGz4YsmJdLiMtp25A7+iwqEhzSuPCtbMLaGQwhpNAlriCJ9x?=
 =?us-ascii?Q?4+zLGOHGB73ULgOJWC59aOBkZ18QRJKcPGyQN/3ruJ1yu0XT/Bcpm2UKW5Q2?=
 =?us-ascii?Q?5mzSvfoFcqfZMCikhrMldflKjfGF0ohwAFLZjc8SPQxHb/A+UAYd4lfG08LY?=
 =?us-ascii?Q?lrL6ExHoqVgWHzA8x3smEbXco95jTQTFTa2UeootV4MPzYiFE4Pln5nk4eUk?=
 =?us-ascii?Q?69Voh2f5F48NBfDQUzd0Cr3gKEDJ1tWvybVNpdub1MB8bBEcdD9NVWdUVjUJ?=
 =?us-ascii?Q?rQHWpAy2gOO4rX4oeEy3LnZ1VWZfkL4ssUs16su/CSbZZJCo68JwYbfAK08G?=
 =?us-ascii?Q?NRYEOUrsJnvCBXPb2SFsyWHI4y9KKVnG9b5v2Z4T9dnSWfZuoIM11feIcGr9?=
 =?us-ascii?Q?xpBKXLXpleS7MmDD/tQBBjOFGnZBLxIdGVWg37JHR84kfsYzGIQszhr9kJxf?=
 =?us-ascii?Q?wpYG3ft0fmScJj40KMppYpRyC27nBNE5qR8Exkr8sS4UZhoWX/4XRCMGOxnj?=
 =?us-ascii?Q?3pcU+lqYqc5SJkuGU1RkS1hvHuKmP9DvdaGBSoKDzs0v9cB2zDzQzEqUhvDg?=
 =?us-ascii?Q?a8Lc/JXesnBGa1+o1sQlrmp08RlA9Wj2kJVSjOQpK7da9eI2J96+aYCa/KXU?=
 =?us-ascii?Q?ixZHSzoQCFyIflExqdQpEZIzj8Akf7V0OoUDUT0hm/npYwreOKSq1z7rSeaq?=
 =?us-ascii?Q?Dq3H6/v0XYNBLTBsK87Nx/90D4hr2xvX+mQlRd0K59EM2fqLMvDkmiimNX3F?=
 =?us-ascii?Q?n7PXayG+687VFQcXvRIB15/95aCaAZSs1dxHoA+8nCBGjTKaLwMSZeiLsPwH?=
 =?us-ascii?Q?jSC3J8kNECLnoH+r2Gy/U2FsbUAYeywCluitsx6/JbILSOtf0wHARqseBEoD?=
 =?us-ascii?Q?B+8M1aXgu3N+OJiEjm5ikgHrGTauuwVTooYs4nv2P1VsMmm35r05xX6sCBuz?=
 =?us-ascii?Q?UXf06vQKPOky+0oE/xg2MqevJR9Bbb2ieTL+Uh3Tna70vlNqNW7+9SNzij9C?=
 =?us-ascii?Q?vpC4IQSMUdjvrAFe1m1EqjU7gQ8wfe7M2stZUqzLUjdexRtAoTSsx3zJoXht?=
 =?us-ascii?Q?xTc9kCgs6g=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec2f908-9caf-47ef-e70d-08da4f618d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 06:29:22.8212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCjTkRW9tbVEylX6fTgfphPaFxzmD3pYPQjfOX9WepWzMemBatgaw2j6gjUIfDzPNm0ZorwAeJQP+aFSamxaUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1810
X-OriginatorOrg: intel.com
Cc: "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "jordan@cosmicpenguin.net" <jordan@cosmicpenguin.net>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "john.garry@huawei.com" <john.garry@huawei.com>,
 "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
 "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, June 16, 2022 8:03 AM
> 
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> The KVM mechanism for controlling wbinvd is based on OR of the coherency
> property of all devices attached to a guest, no matter those devices are
> attached to a single domain or multiple domains.
> 
> So, there is no value in trying to push a device that could do enforced
> cache coherency to a dedicated domain vs re-using an existing domain
> which is non-coherent since KVM won't be able to take advantage of it.
> This just wastes domain memory.
> 
> Simplify this code and eliminate the test. This removes the only logic
> that needed to have a dummy domain attached prior to searching for a
> matching domain and simplifies the next patches.
> 
> It's unclear whether we want to further optimize the Intel driver to
> update the domain coherency after a device is detached from it, at
> least not before KVM can be verified to handle such dynamics in related
> emulation paths (wbinvd, vcpu load, write_cr0, ept, etc.). In reality
> we don't see an usage requiring such optimization as the only device
> which imposes such non-coherency is Intel GPU which even doesn't
> support hotplug/hot remove.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
