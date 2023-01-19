Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B544FC678D4
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 03:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BAC4610C8;
	Thu, 19 Jan 2023 03:45:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BAC4610C8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dHgzntkC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wHZWFgEhA6Bo; Thu, 19 Jan 2023 03:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A07A7610BF;
	Thu, 19 Jan 2023 03:45:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A07A7610BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C79BC0033;
	Thu, 19 Jan 2023 03:45:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 697CAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FABE610BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FABE610BF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tYsI1lKukYk4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:45:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B44D7610BE
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B44D7610BE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674099931; x=1705635931;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7akVbq0P52BNTMgJDfm7MfKXhG+VYySWKfey57WLr5k=;
 b=dHgzntkCW4GCbV+76Z1SOQgwNud92/McvG7mts4ex0tP5a81UbiVj9Zu
 /nv9hc9xFauG4AvS+kTLIm0n+BjAqvNZ1fnlM54OXQHIpRi+3cxKTcLj4
 RY67RoDCvGDKtJof09k5ly6BHZcLxo7OKNW6c/Vb6S2fIgdtLlfXbgl/u
 WJgmjXkWHQ/TKzDOJ3/BekZ9x3Qfe/q4Gh6zSxJSdBy4iGWM5UxRsPxHE
 kPMXnd9+NhLUicaFweos2uayf/6ZXqG0uB4CbBSjwwSZdk94ABUV6jiuY
 VS2AYwevSuXGzTrSD1oeEzrjby6ScYuHjWpbxMMs141jX0jqnVwTrgqfG Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="352436286"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; d="scan'208";a="352436286"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2023 19:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783912415"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; d="scan'208";a="783912415"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga004.jf.intel.com with ESMTP; 18 Jan 2023 19:45:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 19:45:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 19:45:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 19:45:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 19:45:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlbNH4rpsshthMK9jAuTyK2huyS6ead1iPK/bPe/W0DN7oBAn39IrzsqWSIPRGnDnyaEplq3fQ2sRytd8VgpVxJVBtf7icXHMKOk2704NsBA+kJmtmCMmH/TJszKFbTTFbqNItjv462Ugf6vNmWPeMV5JtNc+KfhmwX43EMD/UJ+NdxjK1R+z0y+pnXkQ0QKYRgMOUquPNrqkI3ZLJErItJOlYS8mCqww9/zTNxK//EOUU8xW/8S1uTVyO56eb6R//qRvBNk9SC81jkDxy1R0f+Kc9PPA0+lAbCTTrvqrWK7L2GxYK+8U8SpwNPqN7ntvI0FUwsTnvSNv1TsbTWw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7akVbq0P52BNTMgJDfm7MfKXhG+VYySWKfey57WLr5k=;
 b=TXNDXjMTGTNwRxg9DwdUUiHGPqwzjUaunpQXwM5iEJqse5plqalsKhpO2fTEM2czsKKW5xvyQT5aRGau0QHD3tMvIxYK+RwFvQAjIUKLx8+cxdWoa1AMxmrH8AIR8//HHNDupIdfq/8DcEY4qQfW4IrPzr15G8lH1VvuGyIGETikf31VMtWzqY3XpPZS7WNwCg5UkEraa+fzGBqATVpDiTGkzXZg6SpGWScOpM+wQWHUYyMXNw5DQewY8c4H08dLt0wEdSths59pvmRAVsRDNK8jbmBaRaVBQtX8BcQ9noAwUzA/XF/v6gvsGVFO0gC5cI7ptIorI0ua514SaV5/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7374.namprd11.prod.outlook.com (2603:10b6:8:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 03:45:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 03:45:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v2 01/10] iommu: Add a gfp parameter to iommu_map()
Thread-Topic: [PATCH v2 01/10] iommu: Add a gfp parameter to iommu_map()
Thread-Index: AQHZK2bhAG5uFdBTPE6j23ADS1S6Ba6lGgRA
Date: Thu, 19 Jan 2023 03:45:27 +0000
Message-ID: <BN9PR11MB5276FF1670244D0F0924E9948CC49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-ce66f632bd0d+484-iommu_map_gfp_jgg@nvidia.com>
 <1-v2-ce66f632bd0d+484-iommu_map_gfp_jgg@nvidia.com>
In-Reply-To: <1-v2-ce66f632bd0d+484-iommu_map_gfp_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7374:EE_
x-ms-office365-filtering-correlation-id: 512d9d41-4181-4abb-0f4d-08daf9cf9ac5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXsKyRwmcMM6jgR7Ux03qKu4xruHqnfKKJorqaUybbE+OrhdRYZeiDJmeX8EVsSTkZdmkbumai1vJaHQUB6fV916ADgD2xjw3eCpLQfHfV4I+EIBPPN2cdkJk7fS5XKzy/7mRBM81so7AnuUB47B2mcvmzw/n4I4noUwB6M7WAQPZyBStCH5ZF3kFYp6ygGnKy3ZsboHvULfCNv6JEkMRtr7We93y7Fka7LQbyF3UaSYaI0dCEwfq5v2cM0wWjE0L+41zaWc9/ZIvdP1v56rNfsJ9JiDMguWBEWTDpOekmunQvXhlCiDvKQd5hvOdygwR+caW8ADzto2++z3/dsnbHk8rLHpv5bl4hH+huJPuTUvt5btdDJJ3wBKNy0V1vUys+etwe0KRXfua4u9C0oMLImdPC8BWHyzkWb+uO7l+2b1eC1zoew/+rbFjinLvspM06ac43IO1y4zUSlqVngAFVlsBulyZ99WDm8r/057J6haWxByXqXTq49+gfkVJExsC85D0ARuE286hAKVYmQo3ZyFSXcbL3wXqHUvow2DNa3ysHtHyGqC5eVal7tKNvwbKD388vvmi8kQEaz8/DUwg09MA3AiZOAstZdyps/G3VQt7apx81CezjjeJqeZm8EtmOfBgCIj+LOMn+bhcSWa8QI1P80hqyA240Nvw6CQIQOe6pZ8tZTo5oLtQgYmiUtq0tJ4e6v6ArxrW9HLxC1KaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(4326008)(38070700005)(64756008)(76116006)(8936002)(316002)(66446008)(66946007)(52536014)(66476007)(7416002)(8676002)(5660300002)(66556008)(4744005)(55016003)(2906002)(83380400001)(38100700002)(82960400001)(41300700001)(122000001)(33656002)(7696005)(54906003)(110136005)(478600001)(71200400001)(86362001)(6506007)(186003)(26005)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V70RZtzN/HC2Vyvnpyc48yZ79OFEewzTIV97kSb1DxWEQqoP0Enl4R3GyPBS?=
 =?us-ascii?Q?L2yufo1OhJuwCYBJ6+g8CMvM4IQTZWAd/zGV1ir7bPEAsjmUPJOgmM2ucbTD?=
 =?us-ascii?Q?Ai+nEYv223gtgc08jrDFgcpF4RB+aR+AjRzx2ZD7ODTklNF70tWw2ry2vFIw?=
 =?us-ascii?Q?o6ACBN91TAsKNf7SyqTaSubYEhFS6p12wwq/EGw+bNDfs4j4BuufYTYzn+OQ?=
 =?us-ascii?Q?MOFZD88EYTY1J89mM+ZJeoO2doN4Og/MSRy0ncODlZ1HcYHRbOKFSVPaNT+Z?=
 =?us-ascii?Q?WKNoGdNjHNzjSVUlL1R4hezqKMasr8L2AifrWP7xom53rFlkdYeVk4yE6FPb?=
 =?us-ascii?Q?j/4OOqxPutuRVCnEI17j7lXQID48fLkTYwgbKRgJd0s7eAZOmVg7/3bVYgeV?=
 =?us-ascii?Q?QOxrN1Pt3070gpoMGeeGDzbQTejc2X+UmM6vtAlu0B7M1TkAqIwh66T5Dfc+?=
 =?us-ascii?Q?osVPhSPXnnbmTGg0vkfghgNkkJoJx3p8qnBIEBwIx5SMSwpKs9rqXvraPpfJ?=
 =?us-ascii?Q?BHJA0nEPgxPA1wOaEK/8xnKAfY2ZwcSOcakYwBl41PkLZBWcJ7OzRugJXoQj?=
 =?us-ascii?Q?rRj8hp8yE7k3dsT+96d3lnntd9lQpQB5DXQDNNF7695I/SjfIkHqXGwQEDc4?=
 =?us-ascii?Q?7Uje8BO6FqvdqXmRrCIlLKd6RO2edszBIYae+suoGG24htW0q5joAysYVAEy?=
 =?us-ascii?Q?API4TutROEezmP5mSdfEpLzcRbLBhTpCoPah0rAGXnurZLR6yLQ/y371OxNp?=
 =?us-ascii?Q?dcpPE4NuVTdQD4A0eNEZVBjnBirCpGnzzIUu1+XEZRv7PbvLC809la3m5bJj?=
 =?us-ascii?Q?YTPSFkkjZXBx4VzllfBmrey8CSTtxDB9bE6AOLbqMpNJF2bOmcQErD1B7M2Z?=
 =?us-ascii?Q?rvEqvoGUVic1oZwu9efG9VacK48gsqJRRpmVg1IwgyR1mtXRYkGYdowhQwrP?=
 =?us-ascii?Q?/KkyhFhX4P4aUxsX2c79hulbqYbxEgddFl7wkeFQPXGIKMgkacuGyyD4njna?=
 =?us-ascii?Q?Flo8Pbii6eJZR+75BYi7wzmUBUdBFUsD4chtZ2I2iQN6zNjdFrv6IGz2fCNb?=
 =?us-ascii?Q?tr3dPrck4jPe7x6EuClk3uWStrsh9pRAZG0zClMPbCE12E/ViZ4xlg2RPAd3?=
 =?us-ascii?Q?oDx9oC1Rk29aN5WGb/33jwFZMxIR+1ZknFAJKUpzr38JZkv0eRWH6mu5bOcX?=
 =?us-ascii?Q?vPK4XxDhM5ngCoOE992oLKA7/Gx5tJmRY4PhfzpaAzh1I1yt2Zw/NYPfFhjD?=
 =?us-ascii?Q?xxz/yc1vhBcsGNn6+DwpTx34Yr0F8/MHgvgJO+I4T5vf9zdVBYeTgReVFo4+?=
 =?us-ascii?Q?oljl2VtFXN5pknpif1AOcJz3BrXMMq0O6hEhylTDhSDq/2Nzie9jdXj7oHBp?=
 =?us-ascii?Q?iWk86ZXMHcSxxRwG6+yDXumyc+axGJQpf3SSA4K+6Xl5briW7I7Sq4ms/2SY?=
 =?us-ascii?Q?kwQLPyU2QWePi4rkl4gqE7uw21or7ocNfB9wf4SMfYLL9A5Dxy+U34IyEwAT?=
 =?us-ascii?Q?uQSaWJiumqjSfod9Eu+bcM49jh+LpcaXHJhUFlCeu0WaymkyhAOh+MFJCdyt?=
 =?us-ascii?Q?5KOS7dvMa+FDxaWSnf6aU5eEwyVLNzdf8NUmdv3u?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512d9d41-4181-4abb-0f4d-08daf9cf9ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 03:45:27.5873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhImZFlxTjjhEYAMo0jxG32ZRffp7cdiw//Vf57QwMKssahbl6155KdZ8tcZYWR+Wf5paRmWFgTBcaaOvWsjOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
X-OriginatorOrg: intel.com
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
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
> Sent: Thursday, January 19, 2023 2:01 AM
> 
> The internal mechanisms support this, but instead of exposting the gfp to
> the caller it wrappers it into iommu_map() and iommu_map_atomic()
> 
> Fix this instead of adding more variants for GFP_KERNEL_ACCOUNT.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
