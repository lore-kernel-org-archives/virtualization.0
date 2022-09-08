Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCACECAAD5
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 09:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C8B741A28;
	Thu,  8 Sep 2022 09:54:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C8B741A28
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wy0bGNkV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id merS2YEe-5Lw; Thu,  8 Sep 2022 09:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C5BE341A16;
	Thu,  8 Sep 2022 09:54:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5BE341A16
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93263C0033;
	Thu,  8 Sep 2022 09:54:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96818C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 09:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5ABE183F19
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 09:54:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5ABE183F19
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Wy0bGNkV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tri9gNFf1p6u
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 09:54:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 829E383F16
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 829E383F16
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662630863; x=1694166863;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tpSRmnERUU+bt5kNGshWiOS10AtbXQ84Q0iCOiE30GQ=;
 b=Wy0bGNkV6Iuta5sZSDOo0R/Osni5yoNjcNIrlcPDRv3q6DxIK0IC0M3F
 VOWrOjzBBD3F/QCc+Yz0w7+zSmTGSeqbQrJIbDNyHfaDclwSUxrRxoDWY
 U4NiulbDYg+G4EMtD5H7UlZEENym/koIEK8XrFOfngJtxfybBjt/S4LcB
 Uymu27CEfjz6I8lWiQcol0TwaUmp4EVSgvOSCLVUZojuBJHQOMKy7JNpp
 uHN7dqsGiN78tBkRHRE6bMr9iqY1sq1upTX/Uuit9JhLoxxEfUsy4xqZ3
 eggwTdGsCmok0+EOlvPR+ZaDmXgX2spig1RQqeSlRM8auypGOyqBcRqmP w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297127116"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; d="scan'208";a="297127116"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2022 02:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; d="scan'208";a="943278312"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 02:54:21 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 02:54:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 02:54:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 02:54:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 02:54:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtK+Sa1H3L9MzabahBJm8JjkTUVVoVHJCjsTqglLO6vLpRiiEKGTo5CkJSP/tPuDa3ZKw/qno/35GwdO4jcIrooS2KVsVCbuEUj/jskoA9WPIgN0f5y1LUOuFY/cg5dyWV2i+e6DG1swbI5oTVGML433N6WLCQtTReNkPNCMBPWgLO6fKpST7hma9gMN3s7mgi4UQ26My6OJ7RFsWAMOrVYvWwN5F5JwLcwREfRAgSZEqKO6QZd4ohC+0Alqry9LCuMXfIeSz33uTM7H6vlLYrNXzIi4mVvyoyBjmEoJHp7f/lvgOxOjwh0VVXvYHd+f0btmzAO3wB36Jqo9pwCh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjzgJJa1So+uPKxd1+fFSQQrE34WAQsAmphg7EiXR5o=;
 b=K+aQWyVzo4nWo7NA4qjzTwO39nnFYalMp40bykwU8VzKxsJxI9IuHZ3PGoVcWoEbu5zxI7ZZB/atk0ljAxO+M1FLgPKyulUbFcmZpjxjC/wmcYvsLFZDXL2OZ4wDgIS95d0K/cZRMtPm6ECH8KaOqAR+7mxj9Ny1sBVVr3DKbV53RuRRe69D5oy1yxTVjZX6kKQ3TRuehqS5Ndop/AB67ZiPrgdU+1ljL3GfWbrlQo5/oVllpEXQ1oAN4abMTaA0FTraJCbbx6fKG2WxAyqhyYq5l4E3zCAuIgyhMqSMdeRYjKAoGGzFUM6T04RaZQUwFbcFCZ7QuAYQwHKAJ4gW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5362.namprd11.prod.outlook.com (2603:10b6:610:b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 09:54:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%5]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 09:54:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Thread-Topic: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible
 domain and device/group
Thread-Index: AQHYsNLwCXoHuSRk00qOEfaHbTrxlq3UDMUAgAASXoCAAAnsgIAALAkAgAAs1YCAAFRzgIAAh2pAgAARlrA=
Date: Thu, 8 Sep 2022 09:54:18 +0000
Message-ID: <BN9PR11MB5276F93044F557D1473D7FCF8C409@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220815181437.28127-1-nicolinc@nvidia.com>
 <20220815181437.28127-2-nicolinc@nvidia.com> <YxiRkm7qgQ4k+PIG@8bytes.org>
 <Yxig+zfA2Pr4vk6K@nvidia.com> <9f91f187-2767-13f9-68a2-a5458b888f00@arm.com>
 <YxjOPo5FFqu2vE/g@nvidia.com> <0b466705-3a17-1bbc-7ef2-5adadc22d1ae@arm.com>
 <Yxk6sR4JiAAn3Jf5@nvidia.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5362:EE_
x-ms-office365-filtering-correlation-id: 3cbd2586-9ffe-410a-7c92-08da918018c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhgN23UQRMMUx7AKosSMMSYxCfWa+sFcRy6izuVFYe0si2Kvk/dgBSggDX3griPmCZ9UP9mln8/5uw08HzxL2jb9dsuWq9eTeyoqHVs2hYXKR5UHAxwhwJhlFYa8+TwpA9ew0GOq8f+y0FbGogXoRc3nOkk8lebGzXpIaN0olR76fgji9NlfNgv3c9BB42inRUUWV9+bTqtnTxcIlN5Guqn6iVAET0Ta2HOuRvQc7GuC0TebDWIc1LShfoMmkJ52VvL7MmAZOkevoLOBPPpy3eXGiEGTqcEr8OkB4Od8aQoaKvadT8SOsp5iy1ZklgHEzn5raXRNFyHIObdRRvVJ4TyRd6yQZfCZgEGPxPIqlXwShkDRaFRgz6stv562KoyfnjDncL9k1wOmlY37i1GI8ICczGFgqBq7nYQx7CkTeEojjA1gA0DbZkl2z9fWW/v+nM5J5GJpebnbB9d3CusC2BkBZQa1PTucqAv3OKgr6gR9DDrgxPNNICTvDaj0818jXScPd1IBElDQjLa9jtDM3ze3PCh2cC309KIFJWwqeFb6XXqM34Y6lPeMnDVP19Ec5rtb5HKyPUBmmfVPC8CDDrt5hQ3S6WDpD6AXgDdaxsE1ILYolHXeLDky/tHCmOvqW1fKIZWWyXxK246WUxn9esliF6MIIXfWb7E8373btiFMYxRX92GMcsxZNLOp21JvtcIJcmwjNwRYUxF5wavT7OQT7GO+adus8hbrD/XG5q5llOemsknmd/zpKY+Q6Jqdq1nYt6gLx5wRvcOWA9FGig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(39860400002)(346002)(376002)(136003)(396003)(76116006)(33656002)(66446008)(316002)(5660300002)(66556008)(66946007)(66476007)(7416002)(7406005)(2906002)(64756008)(110136005)(8676002)(4326008)(8936002)(52536014)(54906003)(478600001)(41300700001)(9686003)(71200400001)(26005)(186003)(55016003)(86362001)(6506007)(82960400001)(7696005)(38100700002)(122000001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vbUltzptcGoFvYsN2+2p2pRY/wXXOISp/08oj52GHKrVqN4MLUlufrzCaOWk?=
 =?us-ascii?Q?eSIsdBEaH3wBYs5WRb9MtFcMP9iFgvGmHogucJGy42DPwQj2of4WARcKfSAs?=
 =?us-ascii?Q?3N8YawqhYYHZlmiKTAqB/YBexwKJy9PO3Vif6c0tN82I6TsV3kiDIzrapnPe?=
 =?us-ascii?Q?y6R068M8TmegtEefs3/jTQy5QiGD3CHMaD32dPZAl2GKe9C48V30TuDmWr8f?=
 =?us-ascii?Q?ql2mcqqTyV1snmUn3P1xMv+mH1pnS8M0tdapt34iMzvd4jnlhLOjCBD+Bp0w?=
 =?us-ascii?Q?5eLWdXFNdy8ssnYOpBNNojHDRN8LYEDYYraO+aSUq+Tr4GaUi0vxFIGMuRtH?=
 =?us-ascii?Q?JKLmND5s37X+t4Ln/sw5QCx0po/3QA0xzqgqW3+NmOoBKX4cAeGGaTh5zOls?=
 =?us-ascii?Q?kSw3mo7X56FFgbEIWfZAxrjhJEwN2ZdL0gpTDCD+llPwafvmUzuSl/JSgPDL?=
 =?us-ascii?Q?i3tO1oaoU584DxVrhb6WvS8Sorj1zL6sYmuo0pBYt1RvTXcqvZwsc0f8YFgR?=
 =?us-ascii?Q?aApQ8a8W/VO7FNcgjzAwIZsvibSDfktm1tD5yq1oqv0puCGGhpQGlV1jj4xr?=
 =?us-ascii?Q?eImxI/p5v3XZd+lSNlmVnrIOkCTp7oIM+VQiJByIXgAdqmq6oTNAaMZmUz/T?=
 =?us-ascii?Q?H5FGbSUqNV6zyjsWDVfPMUVeMP7N/WhrcuEsvgmnJLfV1mOcAPq7747WuB6T?=
 =?us-ascii?Q?C1R4ZcwFoX9qC13rShZi4hD4S+q2KrlWptWyq4NfkzWrg7lRYhc2DLJcm6ZP?=
 =?us-ascii?Q?/wcW+LvcTx45z5r75R6iScv9V2DPl3gvf9vmvTJx/mnm6SO/Q/RUZikQwjbY?=
 =?us-ascii?Q?ijFdZEAo5DfeQAd3jPDkXiZOwAbQuytZbREf1+PqpwKH/G3Z2jsSabjk8Yu2?=
 =?us-ascii?Q?6vK0/LOZRhWeRW+jrAsMzwGsaa+AkA9kjK+r3BGArWPTXeJ+5i+iazClIK6o?=
 =?us-ascii?Q?yxokZzpMXxfaeQpvtvF1fLJnBwGZCy3NUWtNP7DixeFfi+wCPOZ7As/vmSdd?=
 =?us-ascii?Q?QAASyj8JerZY3FUbEz7R4iIL+yvALtyNRFETwSBR1dRst/5mPiAP1xvFNX9E?=
 =?us-ascii?Q?pPF9tmfU+mzpvDA1vHh4hA+W4bEGw2xmFPm6AHeGnZ4Y/9d6JLfF56jiYrES?=
 =?us-ascii?Q?Sdijucz803vcgvgg/yh3rB2Q7QGLbXFkPGJsvzZZKTclt6NPSgbAYapwCBTl?=
 =?us-ascii?Q?/x8GInI3m7m1tmuEeC/wSasNM/3dYschfNYkH+6bGUR/JlyRE7xCiISXKsZg?=
 =?us-ascii?Q?jxTpF7jA1gtChv3DNrT3olR92BUEFkdsxa6YxvJTQfpGh/L2Z4BbW3uQi5Ny?=
 =?us-ascii?Q?bldA04MXHZ46pPdcuVAZQIE94hQe4d5rZcUks5+iP3dgyZLvG+7PIeLezJBs?=
 =?us-ascii?Q?71HCeCNTLPbmbMopAnC7CedYKK5bEEVQndLWxBzrcydVygGPHZ+C9h1P2W3z?=
 =?us-ascii?Q?olF+kHsoEu98V8O6QLZfGuQuS31rtdYvo+c1lA9Zk1xBzH8xfrzjAJY1y7Yl?=
 =?us-ascii?Q?7C745igeTv7gFm/r5O+4QAj11wuOpljdmh1KCSXDrvkwwOi/12YqrTSmB0Qd?=
 =?us-ascii?Q?h7VhkhzHkTUJEnjJ3OgDCkUQ+A4WfsOtJQlVnaBI?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbd2586-9ffe-410a-7c92-08da918018c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 09:54:18.3380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTQxhXPWlrFP2/iuWcO0QW7T8BO/Xaca67FRuOEf60Awbp3zUCstUAfvreFxjpUxgl5et1YFq8zjrqgWzwqaJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5362
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

> From: Tian, Kevin
> Sent: Thursday, September 8, 2022 5:31 PM
> > This mixture of error codes is the basic reason why a new code was
> > used, because none of the existing codes are used with any
> > consistency.
> 
> btw I saw the policy for -EBUSY is also not consistent in this series.
> 
> while it's correct to change -EBUSY to -EMEDIUMTYPE for omap, assuming
> that retrying another fresh domain for the said device should work:
> 
> 	if (omap_domain->dev) {
> -		dev_err(dev, "iommu domain is already attached\n");
> -		ret = -EBUSY;
> +		ret = -EMEDIUMTYPE;
>  		goto out;
>  	}
> 
> the change in tegra-gart doesn't sound correct:
> 
> 	if (gart->active_domain && gart->active_domain != domain) {
> -		ret = -EBUSY;
> +		ret = -EMEDIUMTYPE;
> 
> one device cannot be attached to two domains. This fact doesn't change
> no matter how many domains are tried. In concept this check is
> redundant and should have been done by iommu core, but obviously we
> didn't pay attention to what -EBUSY actually represents in this path.
> 

oops. Above is actually a right retry condition. gart is iommu instead of
device. So in concept retrying gart->active_domain for the device could
work.

So please ignore this comment.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
