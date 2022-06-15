Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A73BC433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 07:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E828982F4A;
	Wed, 15 Jun 2022 07:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RaB_FXsw3rEt; Wed, 15 Jun 2022 07:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 76D1E83133;
	Wed, 15 Jun 2022 07:35:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AEE4C002D;
	Wed, 15 Jun 2022 07:35:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89B25C002D;
 Wed, 15 Jun 2022 07:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E885409DB;
 Wed, 15 Jun 2022 07:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0qQCQgFEYAIi; Wed, 15 Jun 2022 07:35:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B2A6410D3;
 Wed, 15 Jun 2022 07:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655278509; x=1686814509;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qjTs6Qqc+6U9DK7fvm60mvysz0KWlM5ghwtuJV99NBg=;
 b=cI5Yzdej86sD2mtgmJIPnSxrB6+ucwO73oMOKMMS/qdPkmHMousC/2Yu
 F+b4L8cQgsDO4lyYyFFDzcs9A1Iemo/oXk8pk/FXSU/U9MStkvtCTZ2gz
 B3MJFqY1ScYxf51i7FT/KJta4OYOYvccK7e7NQFtPmFz6T6fZ4sDEh+Q5
 hzEL4bp9wCkSlaZUzxk/bAuNMw3ButE80o8fLVW1t7EB85PmlX4sM/J5Y
 DAyKOS1gc9zhAdQuenSTjVjhTU+hz3GX+Y/cXgWmt6KgSi6BECOoJDfop
 Pm0vjtm+VSayq16BlE/hN5DCE9UIUuPwiFKifFjWD08KwrcSsFlqUI9xn w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="267556965"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="267556965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 00:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="674345094"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2022 00:35:07 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 00:35:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 15 Jun 2022 00:35:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 15 Jun 2022 00:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJnI56DiAFK6OBrUFjVVDeBR2VHmW/OosX1p+7aeUmMTIVJ2flVdcBAh7RYGplvJtBp1ZWVdgNBABCAzq3KbN9XG1ultZ1lgI2p0KG5yYItKyYn3DhIFqx18OKt0Jcg2RF4obSIhEwbkB8iu9XWO+9bLq5qer90L+bQHmxhoZZo1BH+avUJDxi7a0C0hlkQKHkvaCLVWp/rFiyizGTLOHXpJEh1Gx3JoJwNXM+dIetpIlhARFU5zQ7LD/HdTPMqbm0Uma81SKJ9+OoC+5980ro6MpNTDpQ9GNYQQz7GRPgs5CSm+yVzUgsc+ceMwn0VUcrZw3BoWv/k4TFeLY6/AMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmAOL4zLvaH0pBgX6k2mYHNQK0hTQ/UwZGXCmcK3IGI=;
 b=Q5v7s6vzxoNBQCCCt0ihR7B+90OWXxR1Sp38H25pizJKkhQ7umluPnSsmZgcNyVkmDzhaFGb90o/yDRaTTpw5U4eBYFhk3mDqvNe4gZF1cyi+pnbrWf+iwdwhSJIikwu2QbCHMG59xS03peQ7vewSCCNZwvZmddwYJ4ohWpLC28DsZXl4anIT8EQlC78udAMdo55z8mUePcJ8BuWyU485FB3VuvTT2snEeiJI5sv1AxwGmsBks5JexUaLJKxH1cZORn+d48oqAPm40cahLRMRxCtJi5CaObvIrjrbmZ3sFDUw5xQdEMj7D2QH91mTMVXrvh7vEr+f+3OoIrjNTKxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5429.namprd11.prod.outlook.com (2603:10b6:208:30b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 07:35:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 07:35:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 3/5] vfio/iommu_type1: Prefer to reuse domains vs match
 enforced cache coherency
Thread-Topic: [PATCH 3/5] vfio/iommu_type1: Prefer to reuse domains vs match
 enforced cache coherency
Thread-Index: AQHYeW2KrRlTv4MQ5UeMm5INXClL961FJamwgAA6IwCAAMkn0IAJQ4IAgAConjA=
Date: Wed, 15 Jun 2022 07:35:00 +0000
Message-ID: <BN9PR11MB527694346588A803F0EDD95E8CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <20220606061927.26049-4-nicolinc@nvidia.com>
 <BN9PR11MB5276DC98E75B1906A76F7ADC8CA49@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220608111724.GL1343366@nvidia.com>
 <DM4PR11MB52781590FB8FB197579DEE848CA49@DM4PR11MB5278.namprd11.prod.outlook.com>
 <YqjzXpzuBa4ATf9o@Asurada-Nvidia>
In-Reply-To: <YqjzXpzuBa4ATf9o@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b3f2e08-9de5-49bb-8948-08da4ea18e0d
x-ms-traffictypediagnostic: BL1PR11MB5429:EE_
x-microsoft-antispam-prvs: <BL1PR11MB5429955041DDA2F710BDDFEC8CAD9@BL1PR11MB5429.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gclx44ls315XMkbb/mOK1LsfqKSbzW9+I44SNLlNNKB1MOKmYs9RbqZ6j3amspubH5RTm3TuQew8JqVs1PweGwcNd9wnmyW8m21M37irrjB97J6GhqXArAEGh2s2d0980h4kmcrEa0QeAJ/LeCotU6rgoLfhKca4YtDnQ5QSEadB9fc1+7TjeYvDiB8yC0IT3S3mFJKiV6DG19CgJNvZePzEzEZfSXZs7BPNvvOLyOMps58kltKIUmsbYKmYNG5Vp+8kupYvks56PFyn+ue2dKe2dpymK5BO48++zIeZqrD9kLsQ/tZ5ByZyzQxLUciiq3sVZtB999NzXLSKZqhTk7ziRt94meinpcDhbA6SBa5hYLvW00/htGjPI1s/6pA3glEnxUs6IG9zsFo/sCJ/uGPz/lQgSfSeUlZFwl6MANf6pYevUQtCZOKew9Ak7notoHjS+ntOnuqPal7JfkV8ygqyk4tq3qJHvQtvNOGfIZ7+kSbYmDHN+/K/NoC/GPqLl9b3bIF94pf5+tSgKGv86IBFtR6+ejb528JuQ8poM9hLZOK+l8HY5Yw7kZX/F9DhY/aQxmOp8XAV7aZaghj4y4EuJ5ga4qj2PSpHqBIBsUdxqJBAA5vaVSuiV4F1ICGNrL4tuVVj/O6neG26CBsES2G6roRVAxcCBh2/MIWToj349lpOtiAbw5x3HPuhqqJK0VkYTOr/3TabSmXtfYN6zA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(66446008)(66476007)(8676002)(64756008)(66556008)(76116006)(66946007)(8936002)(7416002)(38100700002)(52536014)(508600001)(4326008)(7406005)(86362001)(71200400001)(5660300002)(26005)(6506007)(7696005)(2906002)(9686003)(6916009)(55016003)(38070700005)(33656002)(54906003)(316002)(82960400001)(122000001)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FixdU54nkp2j0ExIDKg4vco44Ep9nEs3xx33Ys0G7pbuHo4e42WWkSg/cpC3?=
 =?us-ascii?Q?xg0J9txdDG+ASNpsBpKFlkSeNca1NDo4Us8/Q2BPhm0Pvq/elPoAiLjS/YTK?=
 =?us-ascii?Q?vi7Yzzd++hY/qc8pD5baz7rV0mUn9GfwbybDKkID6fYPCwZ5GJdJsJFubcSd?=
 =?us-ascii?Q?rLZrX/0eznWjjwDA4nQKsUbZZ4FQQ5MU6LZOAsDp+MvbklgjRJjh8uVjOzv9?=
 =?us-ascii?Q?QJ0N8Qa0OucsIHzLUA6B2sb8589/FYUUCpwcnGIdWhb0jfIBo3Brvd2DL8/q?=
 =?us-ascii?Q?Z7Wbv3JTWVE6FK9qZcgJnrLC6JP6OSupsETmaixSMUbo9qSeaJMIFcFM62if?=
 =?us-ascii?Q?+gp+K9I5Z1MCPlN/BmDU8u3nVgYZHbeccVr+FeyFEXvAfS8BkegvGKwm/wd/?=
 =?us-ascii?Q?zX3OWqhMK8xwf8M9IwzaCWzxGQpfo+XU4IA6egFduka4u+wX8Pmdl1YYJBfv?=
 =?us-ascii?Q?sHrhUULxpK4OqTxRimUAQ/lJ/Hb5ZQmYOWZQPSrAmUOe/8t3/MNtyFd0+zV1?=
 =?us-ascii?Q?Aj7xAORyCiBdUYP+Y5qpzjysmgBu70kHSiD4J82tNuJJzWFkv99HZO6xV/QD?=
 =?us-ascii?Q?XxgBmmZDftJxefMCR4h3RxuKKBNBgzbxA4HIFPkjakiXu77FgZUC29dF1XCf?=
 =?us-ascii?Q?R/Goe0XPsPs+FlANtx06192HYBGYFeYwBvGKsxKEdQ9v4DDJTi51+JZb1pfC?=
 =?us-ascii?Q?HwCGn4fb/rItd6RpDKzHwGMkWphq9D4gpB3sIiZZt1fNMlZRt6BFqFGCWY41?=
 =?us-ascii?Q?vZvJb0u98LkOgx8y0a9+b0prj+GXQnBMgo6ycR7Ejfw8x26C0rSXTmfPv7sP?=
 =?us-ascii?Q?tUplK0KjWYSj7Y30mHnn9vhfzuzo8OJM+a5hJv3E5dMAFt12uV21tSrGlpeu?=
 =?us-ascii?Q?MQ3Uvz4AgjAkuZThMja3CusgRWDVEdyOFfFI/FSksMnXrMrf4yhD6Owcaqf4?=
 =?us-ascii?Q?Senv0mMS89bZnOXwLF8y/bPCs2sBM1+AfHcP0b+YzeNDz81MTL/NTOpmE8Yu?=
 =?us-ascii?Q?iGLivg3TV/2kQuGyaHuZI2G8JrSm4YSOARYWG835IVbAs/ceT/131jmDmSZ3?=
 =?us-ascii?Q?wkBYGTDlKFtusb4wk5qQ/htFHgdjnYDfxM5voKV8GNY2f8WjzSLv+5P4k5mf?=
 =?us-ascii?Q?/DFgUv/IRvjUFd2Gxywn29dnmPMZSvQyDoNJx44NHPtsln9D7so+W/APIC/r?=
 =?us-ascii?Q?7J142KSJa22E8/OYLCjKSdH9+we7J9cIOMp2Z2NZgZ3cxouTlXc3MrB8E4D7?=
 =?us-ascii?Q?5ssiiX/IfYAYWB7XUIxB1lh5OzbKbOeQV6S+t9pyQoSz5Q55NX62BDggiiK+?=
 =?us-ascii?Q?p5QykUJs1mZd5o+AFUMOvj4zzbLWzs6Ylv03Ylcx7QaFKm1JC9BQFKLp8blS?=
 =?us-ascii?Q?2FItx8XjJT4j25IYRd9Xs69KhZVnC6n3I5it8fpPsimiHfK1rbG09YPTh3it?=
 =?us-ascii?Q?HR5PpfOwfjHGRm6H/PVkYMATiryGV8GG5+eSw+SX2XZsIhgmFRkhiC7JhwpP?=
 =?us-ascii?Q?Lp7hKuY6qhOu5MOG1OIu/BTA3nvmQnanMQlNAzomD3eh3cu0Sc9xvUd6QayU?=
 =?us-ascii?Q?QFM1BxV8Vzlep9v0GwDvLyRGNSM/z841HjJDDuOuLLgZpjJdVeL58avZC6YH?=
 =?us-ascii?Q?ueXuE8E50MZz7ocnSUbPLogJh4PLNaRKFL3+puytgb6on4hPJDCbDbQJ5ecg?=
 =?us-ascii?Q?/+dkT12834iliiV5XztPFOGfaBR3LcFh91pXvMFkt+bq/ig3EGmhkr64kD+O?=
 =?us-ascii?Q?1Xsw9+6UXg=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3f2e08-9de5-49bb-8948-08da4ea18e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 07:35:00.5987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YB3Oay9/YbjViA+rFqwL5rNvWz1hcm9jfbxfIpp/r37jw1RQTfQQFBsGeSE0ko3JyklMons88TXEE2Bm41toyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5429
X-OriginatorOrg: intel.com
Cc: "cohuck@redhat.com" <cohuck@redhat.com>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "will@kernel.org" <will@kernel.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "samuel@sholland.org" <samuel@sholland.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "wens@csie.org" <wens@csie.org>, "agross@kernel.org" <agross@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 "sven@svenpeter.dev" <sven@svenpeter.dev>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "marcan@marcan.st" <marcan@marcan.st>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, June 15, 2022 4:45 AM
> 
> Hi Kevin,
> 
> On Wed, Jun 08, 2022 at 11:48:27PM +0000, Tian, Kevin wrote:
> > > > > The KVM mechanism for controlling wbinvd is only triggered during
> > > > > kvm_vfio_group_add(), meaning it is a one-shot test done once the
> > > devices
> > > > > are setup.
> > > >
> > > > It's not one-shot. kvm_vfio_update_coherency() is called in both
> > > > group_add() and group_del(). Then the coherency property is
> > > > checked dynamically in wbinvd emulation:
> > >
> > > From the perspective of managing the domains that is still
> > > one-shot. It doesn't get updated when individual devices are
> > > added/removed to domains.
> >
> > It's unchanged per-domain but dynamic per-vm when multiple
> > domains are added/removed (i.e. kvm->arch.noncoherent_dma_count).
> > It's the latter being checked in the kvm.
> 
> I am going to send a v2, yet not quite getting the point here.
> Meanwhile, Jason is on leave.
> 
> What, in your opinion, would be an accurate description here?
> 

Something like below:
--
The KVM mechanism for controlling wbinvd is based on OR of
the coherency property of all devices attached to a guest, no matter
those devices  are attached to a single domain or multiple domains.

So, there is no value in trying to push a device that could do enforced
cache coherency to a dedicated domain vs re-using an existing domain
which is non-coherent since KVM won't be able to take advantage of it. 
This just wastes domain memory.

Simplify this code and eliminate the test. This removes the only logic
that needed to have a dummy domain attached prior to searching for a
matching domain and simplifies the next patches.

It's unclear whether we want to further optimize the Intel driver to
update the domain coherency after a device is detached from it, at
least not before KVM can be verified to handle such dynamics in related
emulation paths (wbinvd, vcpu load, write_cr0, ept, etc.). In reality
we don't see an usage requiring such optimization as the only device
which imposes such non-coherency is Intel GPU which even doesn't
support hotplug/hot remove.
--

Thanks
Kevin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
