Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C47CC43334
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 08:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20BFA83F91;
	Wed,  8 Jun 2022 08:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kytE4Spqv9Hw; Wed,  8 Jun 2022 08:35:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 91A9C83F9F;
	Wed,  8 Jun 2022 08:35:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2854EC0082;
	Wed,  8 Jun 2022 08:35:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0B78C002D;
 Wed,  8 Jun 2022 08:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEA7883F88;
 Wed,  8 Jun 2022 08:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKvy9HliSctd; Wed,  8 Jun 2022 08:35:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF0B183F86;
 Wed,  8 Jun 2022 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654677351; x=1686213351;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u2mgcVFnDbhjpU/Uh7wePZyTNQEPp1VD7PO9mfATzNw=;
 b=bZurF+StloMWf0nJ7+ty/lN0dzzI6D+2PpERgX8quKx3CnzwGDaQWiNd
 bPaq9aG3VQ4THhTQ9c3UGyWYODQKVWiB/apRyRRIi5xLzC3gcmw6vIhtD
 87auV4+QgNINvFhue7fOXZ8co3RMza57KgoVJLhVkO/whB2jpb2X7JIsY
 Q1NrU93hykJA1yCuGXPOzwKqYbAAf+HISOxH6aJ1RhozgRngEyfR9DPsu
 gX+lFt1qPEPwCSWvCzVEx8qXyah0j4e3Q7Ho1GDh2zFV9ErLsgd3Zs/E/
 gUeMsopQsd1bCtVDUpP2wmvoshYi6T4AN64/gQFLqRB+XudMbJIngtSoj Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="275580931"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; d="scan'208";a="275580931"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2022 01:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; d="scan'208";a="670427829"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2022 01:35:49 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 01:35:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 8 Jun 2022 01:35:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 8 Jun 2022 01:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOC3IGPPwEf3vDXzusP+HSlwBtfLkcgggtbVqBqwCZbVovAPNRs7BxDkDyR8I5mmsSC9v2VW07RyfguRm0sf8xOIf725HZbwyXFsMhsPaLWa7TFpHsmzF8l9WlA0s9ncCVooSX4goxfMMO4ez9XNOJzcrxFFMtkOmrcmtdLrLDRL1tu/SPBGelHmPCkKRA5ZiC2oG2lQIPiq7KmBGoLPov9jY1kiy4YlAb8YvHQnFIyE9+ETGnaVw7Zd9IPiXg8k+OUbiFeogdVJYlNLACjLYo4eCuP9a17ZAO+HvjajGSL95TgGSKDopyMfs4lq11oUYziTq6S3iBtRwFIrD7mu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHYdMJFMNMcPgjtUBe4kkTcabS00eYAAmtRB6t/CvNM=;
 b=HkatTQSQAjukxnKUd8RmJRQaMQTNDvdPwkTY5Jl3ko6wcrluPK0hH+ujIig8KueKA8uLpv5496lnHcReomwea/qrCO3FsyIcpGKOgVjqUMBWe1bLE5fggFkhx3IaAB3BOu0sqfupWjLXmdASpe/EzNsyTN8PZ9c7OcxYQMyhMmYf6E1v9Y4XjX3TMWSQKORqSe0jiBoF2dyRaJS5kFVkuRKZKZqX+etbVkYFy8jOUpINxnGhK0+U+Br002euYDf086e6SZXMWc2e+1jV5GXRfuZs0sV3s3QNfi5sZYF1WtOL5gItHX2viRa71LgrYofc5gYbdSds9G2PCkbxJhtbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 08:35:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 08:35:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "marcan@marcan.st" <marcan@marcan.st>, "sven@svenpeter.dev"
 <sven@svenpeter.dev>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "robdclark@gmail.com" <robdclark@gmail.com>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "krzysztof.kozlowski@linaro.org"
 <krzysztof.kozlowski@linaro.org>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "agross@kernel.org" <agross@kernel.org>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "heiko@sntech.de"
 <heiko@sntech.de>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>, "zhang.lyra@gmail.com"
 <zhang.lyra@gmail.com>, "wens@csie.org" <wens@csie.org>,
 "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "samuel@sholland.org"
 <samuel@sholland.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH 4/5] vfio/iommu_type1: Clean up update_dirty_scope in
 detach_group()
Thread-Topic: [PATCH 4/5] vfio/iommu_type1: Clean up update_dirty_scope in
 detach_group()
Thread-Index: AQHYeW2XhbiTGS3QqUuDnj2btqHn361FMWPw
Date: Wed, 8 Jun 2022 08:35:47 +0000
Message-ID: <BN9PR11MB5276FD77A2780C97BB82CBA88CA49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <20220606061927.26049-5-nicolinc@nvidia.com>
In-Reply-To: <20220606061927.26049-5-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92a48429-2813-4c42-4f12-08da4929e2cd
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_
x-microsoft-antispam-prvs: <LV2PR11MB6045A3DE26596570F4B2C9278CA49@LV2PR11MB6045.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mPbIZXTOFFo+OY3QOAjlNDH+3Bi7k7JEBNpc2zsPqIhKLWQltIRxVdaf9k4v5wxygssJuWkFAhROqHVXWf4O0VfNVVpfzEq8Og39cCfALz+NYzbwbrU3q1y1F7XofA2W7KsxBmHbGd3UO6gMFd34TzGKMIg5BdAVoMGUOwy5aOId26gGd0rRJt3AfigrtmXn1NWvXFcDhKYinJeD8FPQeE5iX/RH+KSY+XNv5Pm+mpUvQ/fhxuqn26Tf4K4cAdfOoOf3Tx9NCeq8eXx9rFvBoxptxV4ZxHFp6+B267XiHFriCIEuk61I44BLVXB236I+mXzv6UpgEN4nf9063kgnGKB0j97xBxco6mgyArRPuTq7JRklWWLXVlfFQuBPeOLG/JcaQKdZmSYULwYTJDGymG+F0gFSRXUQb4tMcSM6TKBaA4nM5mfrvyFb5ucMXYtW2h08R0v+VksdodYkJbGb3U5w4f56EY2Q/cOHYdBarufDINofDHq+FEb2U433zmrWjQvux5kBaMaJPh/mb2qjgldyYVrREnBzAbuRUgoog0OdvRqUXkKpTeQqZB+0kvLLpvxaxF+Ls4xToSJvHAgd3aPUP59z9c5I/0NMjr97Uc8QpWAfVQWCfbQ0PbVTVQCd7qQMmVJa13OIVWheyqI7ogosJFRaEM1YBa/nZMUcES8CCiSjMMWqHrb4mu+d7gd2jzUDVUcaZZfCHwyMb1DWguTdWuci/VqvqVLQwy0AVGSuJFqU1ZI6weLXB9zePruLUNO6Bx8ivZFEywbmPmtyw8Vi7GCjzpodMGEnIzL28tE6kQyhU05fNRSBXokvgMUnRZOGeKSz19M4Tur6ufDS7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(7696005)(52536014)(38100700002)(316002)(83380400001)(76116006)(186003)(7416002)(110136005)(71200400001)(966005)(8936002)(38070700005)(5660300002)(7406005)(15650500001)(508600001)(2906002)(86362001)(55016003)(54906003)(6506007)(9686003)(122000001)(26005)(921005)(82960400001)(66476007)(66946007)(66556008)(66446008)(64756008)(8676002)(4326008)(33656002)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CzN5ou86xd+IU4dj2iK0YggY15ts3p12Z6x7CyXFfYf7yD6DGqorgWFZ4qO8?=
 =?us-ascii?Q?HFnseAxY/ACXFGVewKXfzHVB4UdGwsq569EENZjkQ6ahlZ9TlOyUdMrPo+0+?=
 =?us-ascii?Q?1lzbgcCZTeHLiEzHP6pnC/Zv8OxH6YzOILz9qns2zKugLmhtM6kVue/djfI+?=
 =?us-ascii?Q?eNupFGGOOwk7B7M7Ep0V7GLTh+qlbV62q44hYJdvTFub9RMesSAxdVQH+JUf?=
 =?us-ascii?Q?VbPWGwBiICdC1u842mhV1njsFfE7DrahMsCKp092x7mgSbeEH2dlrGFFcQg5?=
 =?us-ascii?Q?4twbMicbgihGUZM9RfY0v9CSF/u1h/jBOANYpHnc9QhTZEXrlm9sJCzXM3NK?=
 =?us-ascii?Q?J+eFnAZnLymzTCjpKxOKfm7DthUoCwgprraukZLiLHUWkobD9SwlzWkBcXJ+?=
 =?us-ascii?Q?5ONPCvsfgQuDiWAtU8KLO18pTUfznBAlADgvvVPAOmqXno9I4CXqUrxzWCY/?=
 =?us-ascii?Q?Idqf0bhpNS7jUX4rdJL0VxdH1QHJlXDw2+X7HMib86W3p5csbGJz2EymP1/M?=
 =?us-ascii?Q?X0q5QlGlasx4n+xuH98BBY+pxu6QhSD470OyY40/Kqio6+fY4ZPF2sBOjZS3?=
 =?us-ascii?Q?oYOND8yinzOXIra0bS340xkCBbLapOvu8oKG+1fP/c9JoaM1mh0JXIHusrNK?=
 =?us-ascii?Q?2tvHoJ/MyHsvmI9ztK923Yd+iXCBOu1a5FcBzmbOtO4oY/m60gHOClNT36WF?=
 =?us-ascii?Q?7EwLrlBpp4h05CacDiiDiEQMeN7CqhjNqcddd+DZpNYB/duD72zes0CzKR7x?=
 =?us-ascii?Q?wJIgGOzMb6zxgb8JNcbW5N5GmLBuJ5uToW5p/TRbKAv316+s0dm+pi+Wai63?=
 =?us-ascii?Q?QrXtW1jH4uIF36nUHmxHdZBJS9GOn/h89QawMN9tH4xvuGA5uwJgEHiN7lgW?=
 =?us-ascii?Q?9TigaY1hUlEKnQYDAfZmgtmM4TadCsOa0H6nXKxYFDsi/YHavIP1iefIR5lo?=
 =?us-ascii?Q?Ptce5UBVtSSbWSPdajYOhk08/WYjgobDpoceKtf859yhigjsUpaL65J5D0/u?=
 =?us-ascii?Q?clHJhAmYxv680pxocCXTKW2XESRdxqP8m4qw9iIQWG8vHihqFXhdtwBdL3LQ?=
 =?us-ascii?Q?SQznSiJUJ1BIsw6jursGPCHCDqyrZo0hZcStvtL4PVFHicMvPzJ9Nqaxo2JC?=
 =?us-ascii?Q?t6Dkup3GGYvHQ6OamMAf8QCUzxeXhTyK6RlvcIgBqMrSTZxSRwNCMWqzehJO?=
 =?us-ascii?Q?KKLHto1Y+6X4n0kzlJPW4S4lbcPmvwwjCz9LIm4+Tcutou2/+9DYbDxZkWPa?=
 =?us-ascii?Q?AHKBrppgVMzdZan6K10NUjFStcbQo4hV2z3mePrJlwt80sn6uypChvFA6znj?=
 =?us-ascii?Q?jrThkCf2d6exJtgQXhMMNnHBgQh6mH65hFXX/xoZJyjwFClZJ/kjEy8GQA6o?=
 =?us-ascii?Q?iOn8992J9g5g7dtwH7+SUij/wcVtxVdzPctjQIF5U32GI/abiadSL6/VE/kv?=
 =?us-ascii?Q?HFTGGfp0Or5Sq6lBG7aQUV+hCB2ah3yCD0KZr4ONGlx0GalvvmU5FxdF18V3?=
 =?us-ascii?Q?/j7G6DDEywSK+40xXRP0l+/B3s4mCyeXWxc6GZYHIZ6vNwKmbPztDPZqnLKr?=
 =?us-ascii?Q?44LfT5gnTOVMuAE0V5Th2T/3aifzg8ez1Utd9q+KqqYFBtjp5ZnsDcD86Qxr?=
 =?us-ascii?Q?+F02Ed165hx6py3LhEjb3JraYY61rmZFqPezfDoeV8iCUhtIC3Hn9E9xwcMK?=
 =?us-ascii?Q?o2N1FKMFIFhnzbgCeOCJ7SR/+VSWaiX8zBRF1ycvRr+IjrPprBgdzZ33NpOH?=
 =?us-ascii?Q?Ky1iQ4p5zA=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a48429-2813-4c42-4f12-08da4929e2cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 08:35:47.3472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZ6UkAjER+9Jqw7bHJGNFW1L/QeMxm6FT29NzWH/9zcIxvZMlybKLcG6O8q6+DzGnONuQX9Fteog/RcJFqxo1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
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
> Sent: Monday, June 6, 2022 2:19 PM
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
> ---
>  drivers/vfio/vfio_iommu_type1.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> index f4e3b423a453..b45b1cc118ef 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2463,14 +2463,12 @@ static void
> vfio_iommu_type1_detach_group(void *iommu_data,
>  	struct vfio_iommu *iommu = iommu_data;
>  	struct vfio_domain *domain;
>  	struct vfio_iommu_group *group;
> -	bool update_dirty_scope = false;
>  	LIST_HEAD(iova_copy);
> 
>  	mutex_lock(&iommu->lock);
>  	list_for_each_entry(group, &iommu->emulated_iommu_groups,
> next) {
>  		if (group->iommu_group != iommu_group)
>  			continue;
> -		update_dirty_scope = !group->pinned_page_dirty_scope;
>  		list_del(&group->next);
>  		kfree(group);
> 
> @@ -2479,7 +2477,7 @@ static void vfio_iommu_type1_detach_group(void
> *iommu_data,
>  			WARN_ON(iommu->notifier.head);
>  			vfio_iommu_unmap_unpin_all(iommu);
>  		}
> -		goto detach_group_done;
> +		goto out_unlock;
>  	}
> 
>  	/*
> @@ -2495,9 +2493,7 @@ static void vfio_iommu_type1_detach_group(void
> *iommu_data,
>  			continue;
> 
>  		iommu_detach_group(domain->domain, group-
> >iommu_group);
> -		update_dirty_scope = !group->pinned_page_dirty_scope;
>  		list_del(&group->next);
> -		kfree(group);
>  		/*
>  		 * Group ownership provides privilege, if the group list is
>  		 * empty, the domain goes away. If it's the last domain with
> @@ -2519,7 +2515,17 @@ static void vfio_iommu_type1_detach_group(void
> *iommu_data,
>  			kfree(domain);
>  			vfio_iommu_aper_expand(iommu, &iova_copy);
>  			vfio_update_pgsize_bitmap(iommu);
> +			/*
> +			 * Removal of a group without dirty tracking may
> allow
> +			 * the iommu scope to be promoted.
> +			 */
> +			if (!group->pinned_page_dirty_scope) {
> +				iommu->num_non_pinned_groups--;
> +				if (iommu->dirty_page_tracking)
> +
> 	vfio_iommu_populate_bitmap_full(iommu);

This doesn't look correct. The old code decrements
num_non_pinned_groups for every detach group without dirty
tracking. But now it's only done when the domain is about to
be released...

> +			}
>  		}
> +		kfree(group);
>  		break;
>  	}
> 
> @@ -2528,16 +2534,7 @@ static void vfio_iommu_type1_detach_group(void
> *iommu_data,
>  	else
>  		vfio_iommu_iova_free(&iova_copy);
> 
> -detach_group_done:
> -	/*
> -	 * Removal of a group without dirty tracking may allow the iommu
> scope
> -	 * to be promoted.
> -	 */
> -	if (update_dirty_scope) {
> -		iommu->num_non_pinned_groups--;
> -		if (iommu->dirty_page_tracking)
> -			vfio_iommu_populate_bitmap_full(iommu);
> -	}
> +out_unlock:
>  	mutex_unlock(&iommu->lock);
>  }
> 
> --
> 2.17.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
