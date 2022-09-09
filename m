Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD74FECAAD3
	for <virtualization@archiver.kernel.org>; Fri,  9 Sep 2022 05:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0E7B419D4;
	Fri,  9 Sep 2022 05:00:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0E7B419D4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G3lLbfEr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KJ6KY8IcbgJs; Fri,  9 Sep 2022 05:00:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8AACF419D7;
	Fri,  9 Sep 2022 05:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AACF419D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C4CCC0032;
	Fri,  9 Sep 2022 05:00:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5B9FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Sep 2022 05:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66BD9419D7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Sep 2022 05:00:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66BD9419D7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XRCD3ttaafG7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Sep 2022 05:00:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 033CD419D4
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 033CD419D4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Sep 2022 05:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1662699642; x=1694235642;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mgJyh/nc3O1mMDaGazsyg3OXXdLg35vqlm1MLy1j6SI=;
 b=G3lLbfErMHlSjWLVBsF+xa92EEqQHu/6SsGBHNEOKCn4FA3lM5IWBvuU
 c1o8ZJVjI9OBRN+neOuqWetM3YSNRxb21M41x3q9rgPGPC1NmZzu85g+x
 qBQ6p5go4PSDbq8XCmJINQrr2QEZBPXABDeCiMH/Yl5zXShngVlBFhuFv
 TFSj3pcwWqSNREPgXIIEOrgTavY0umjBIl1yFpMufm7s+bmRKJTr1ZfqF
 wNXdH5w62bL4+5f8RNh9fVZW8Bcq5sf8anQopqegN+qQL3aa3CUcUUNh9
 n08Vl/5zEuX6lNUkDW5dplTZpJ8J8nw4s3lI9z68Bbrnovf7+hdJjeqix Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280423618"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; d="scan'208";a="280423618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2022 22:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; d="scan'208";a="645392156"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga008.jf.intel.com with ESMTP; 08 Sep 2022 22:00:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 22:00:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 22:00:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 22:00:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 22:00:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8Z2KZ6gdRAM03hPo5cwe+i8fgYxR4Y2mgPfeCwkTxgApv2QRF0PBr8jduzxP6LnHoJclLdz1uxYYJDHREr5BYvnJ7LvxgY8OBkoCAViNhckAssHInRqiTWC2B1peUvBzBJngg4YCHTW7gCVlI0KdvLBzvmELwZFp+n5eRjFc5/65tXKybG8//3zRvWM/X5pfrvFrgJMPUbbS0QV3sdCVKj8buuomq35NUZ8AmPrI+mweBkV60Y7TOUouskgBgMXz+LHVXXrlz/KsOiqRyA9xGPT0uIn1MI4K1JOO+B3ANDZXB98rDCidwlw0tepQMgI4vN3QiZLDS4bwA5A8wg2Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzUrKAZMotHmrcbg5OS+925/4yBP6oIQM2+xL16a+NI=;
 b=SS9IkrLoyRODFnc+1h8hZNcXqPY4VJLnQAeGAtzOBMXfTtDchzWK+ucOKZ2c54NhSH6YTD9JzG5asalTlJN2DYYOeJ/4xwQA1cIMIz6g0jjxNSXUWBSSM4OV3dtSIZT9jAiH189COmGZntHZy3LKoys0EEpYQQw4rtlm7Tm1iEO/7FCT80NnUDjgYZiqgF/NsIApSjBbH8vyu6gOEFzmgw92Q6AmBO22WWXMiD6C2mpEPfVmDzfeYrK0D0LupeBQ/fFBisRjCAnZrf0hYwSBnft3MqDD2PHn4NmEYxkm1G1g2rjyYlTlQ8On7n8mkp7ht2qXTcW6KD3GaHheWfHixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 05:00:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%5]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 05:00:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Thread-Topic: [PATCH v6 1/5] iommu: Return -EMEDIUMTYPE for incompatible
 domain and device/group
Thread-Index: AQHYsNLwCXoHuSRk00qOEfaHbTrxlq3UDMUAgAASXoCAAAVEgIAAM22AgAFUQQCAAC55AIAAuSeAgAARJhA=
Date: Fri, 9 Sep 2022 05:00:16 +0000
Message-ID: <BN9PR11MB5276D4CDC551DEA5962F9A178C439@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220815181437.28127-1-nicolinc@nvidia.com>
 <20220815181437.28127-2-nicolinc@nvidia.com> <YxiRkm7qgQ4k+PIG@8bytes.org>
 <Yxig+zfA2Pr4vk6K@nvidia.com> <YxilZbRL0WBR97oi@8bytes.org>
 <YxjQiVnpU0dr7SHC@nvidia.com> <Yxnt9uQTmbqul5lf@8bytes.org>
 <YxoU8lw+qIw9woRL@nvidia.com> <YxqwQ+3OICPdEtk0@Asurada-Nvidia>
In-Reply-To: <YxqwQ+3OICPdEtk0@Asurada-Nvidia>
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
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB5963:EE_
x-ms-office365-filtering-correlation-id: b1cb0a65-cdee-4d19-a1f4-08da92203000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5GhvV8WHAMnfCImQP7RGPkm1CA8LjNwCVgw95zDV+x79KeeOmW9UhQBOlWzs0soNeS0wU7yFVo3hVMFGCrBAm40NIZu3QylTBdh3UZsCgW3qCyBxlmNpXy7XHjk0PzGtyWmPUPcSOTZDWis9DurgvCBuTxZfXU+iKsPyYQnc0KhrJV4cmvzQEDGGQIfpflfitLQfRGPDylp9v/wZYEFt5Q3XaZqnbdWPCyyAPwMS3p/afBmOXz/UPu0GD9HKiALPpjSBuShH9Nbro6nMNxtjv9RkWymZrJo74wgC4QyHD7dXM+wy03ay4ZXEXBzOIYXN16oF2KnmbQDM5XQCThJGXLDgj6ikngRrxQL9T1hlPCOHCR1ZfgmT4WPN76zJVYk22nJiK7rjIBwZYdKnU/sQrIDiypqyt8aMidAb8M2d/Y1gcVOLacC2ENTyfGX2/fGpuIOwmrYkVGk6q9tmYbT6gIpKgUdao31oGw1I/XnGeD+1hfVMHmvXA/Qela2KljB4yznmsAIvRcevp+As6pcfGYWpHywJJe7W3o3nyrcf1aiHIdivBrPMiVq+okbcJp/aiI3Z8bbKeO5kCL4TRe2YNJ+KZ5p+c0Q1O3Ih8V03Acr3XL/4CnjxxD9riPAjh+ltZNIxe90bWqKLg5HhKZRm8YKy9EEcnZth4OYjIZGhd2OVVZlSWMJ9TRV7heu2zdCZGqRkzb0T9ICF5J/FAAi0KMPdy4WABQP3Z4fRobB92z0aipyASNC3mHBQwgUDtlDROrTAUU7CmTmP16LJZmRLGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(346002)(136003)(376002)(39860400002)(366004)(86362001)(316002)(76116006)(110136005)(54906003)(41300700001)(478600001)(9686003)(7696005)(38070700005)(71200400001)(6506007)(186003)(26005)(33656002)(2906002)(7416002)(122000001)(8936002)(52536014)(66946007)(8676002)(66556008)(66476007)(82960400001)(5660300002)(38100700002)(4326008)(64756008)(7406005)(66446008)(83380400001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ahY9FhdDLLWr/nJTHIphS7RRRGiNvRUCKpw9EqDBAmw4DIOtP01ap/k8LMg?=
 =?us-ascii?Q?c1BXLzMH/HD3MYVFLMw7r9c2Hz5EHo1vLLk948IBNSnWFZSnEGynUYHXf+JQ?=
 =?us-ascii?Q?ErARYmAHM+ETWK9FqWTcJLCTPlfHLTi2Rg24vacrkkAvsfrk/hHuhlYf0dtL?=
 =?us-ascii?Q?gbxJlv9NWeC+fwk+UcilqQGGv7A1MDX8Hr2I0Gh/iI642Gs7QeWitWUvYvh+?=
 =?us-ascii?Q?PMU6wdd2MHPyV+u+7Y+1pkZUwSj/ukKs4GVbRaIwtz9vwnpEL+bAxE0xo83n?=
 =?us-ascii?Q?S+9tiuQRnMDwrjU1SSxr+As5FVzCzTUCUCIJZfWms0UOrjT6ecZFxq7rlfIM?=
 =?us-ascii?Q?WbrfXl8lJiLGl/Y8EAy+GMKeE2yj/nnm3eSFRhLVZibDLu6HRPDn8Emwa7nd?=
 =?us-ascii?Q?Eni88rzbHSBp6m5AGoTcAf6BUgSWD+4xhUlNNiZgXOqkqZ0HGvhktiw9TYY/?=
 =?us-ascii?Q?KESBseHLF5HLMVB0r7sL+5y+IhHTB44PmSv9lWNpyfHJzJjVQ9QjINzQK25v?=
 =?us-ascii?Q?WMd17DORjXRN4pDdvD8OD2k7b5OAyj+p+QdgfVzzysFSnBo1HHCa4j3SOguI?=
 =?us-ascii?Q?aSl4BjDqLyH/6CLnDb/Z0d4dAN+bzKhw+vnpTwv+RRyGvig8REqWQ+G0geXc?=
 =?us-ascii?Q?r9XcWrPvY+2227HA89X4//o1fw+/jp/jSuzXRhHSiSF5sWoaZvxwi8l1Zc2Y?=
 =?us-ascii?Q?WpnNKdpQXldQRt4HH2ahxJGzI/MOF5jZBfkYl1e7fuwaNwnEjee5ny/Nh4T2?=
 =?us-ascii?Q?PXoT066pEPaFQgrcvISavrzSJ0MKQN9OqXL6ah2xmRjM0m7EokKeHXEW7/Ax?=
 =?us-ascii?Q?v4zWKtIalITTMXErqZFgl9xzhCuIwV8P2cIJp2rj3XbyM5W1aOwoL1BtsaiV?=
 =?us-ascii?Q?E7W3COwGNyx62cqUfPGU7Nhk1k5dtNEQ4I6/nMVhayEGW4b+qAPhreejs/kO?=
 =?us-ascii?Q?kPtX5PMW8arUBBiC6OmFBclgOiV8fnKFQWjFBHiVP/FlVvIYjUcOLpLQm9D9?=
 =?us-ascii?Q?+Awkc5nJPjSriK0OEUn27oq3wwCFK0u5Ulte5NSY7WtXIoKlsEGhusTTX0ap?=
 =?us-ascii?Q?fIVWDJtYsLO+GB+uI3b0+/ajXiUOFisrYPWmtiYGy6LYByfenn55luw1DwUr?=
 =?us-ascii?Q?R55sTMEjlROBJXSTQi4J65JZGB30IFy+CNFj0kiHwT+E7wp8HcotdHOOvBn/?=
 =?us-ascii?Q?FsFpDr2nDztVxjSRXJ0hMPp6Wk1S+0SM2RM1YCeYBT+eHEMmOY8Esi/OZOtl?=
 =?us-ascii?Q?AivRn2j/NL6wW+xm9bHKvhLwRtMqyZAAOhJ6jRej/AiZ+aBYIQdwP9v6IHuA?=
 =?us-ascii?Q?s3driH768slVgcsuDMqFEtIF6KZsjs4gASZMAl6BVi42NP91IazWlzr81ghx?=
 =?us-ascii?Q?rtenK8aNfjcrkolfmeGQ2A125xKNf/SFrmo/MwnGZcEoK2NDW/eylSK7qMSc?=
 =?us-ascii?Q?QscT98GmcVtpoHN3yYtAaeU36N6VN5vtPyh5rEcafpMvjnaiHsXeLvsFWQGT?=
 =?us-ascii?Q?ESmO5DGNaWT6WbVzIT75jN8W7Ifj6tyeS72aWX6JFUNYmsnDEH/lQzQv3K+z?=
 =?us-ascii?Q?EgCr3Pog2yaldQoqocXAaTersUbsCbK1+9S9lwTM?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cb0a65-cdee-4d19-a1f4-08da92203000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 05:00:16.8146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3a8gibbIs3HZP4J9wAJMgbrtwVhFcO+d8tmAXw1khAkI6O4RE4oTT5GFjEUXNKAdWFQVTel0EkkLu66tGPkH/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5963
X-OriginatorOrg: intel.com
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "marcan@marcan.st" <marcan@marcan.st>,
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
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "sven@svenpeter.dev" <sven@svenpeter.dev>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
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
> Sent: Friday, September 9, 2022 11:17 AM
> 
> On Thu, Sep 08, 2022 at 01:14:42PM -0300, Jason Gunthorpe wrote:
> 
> > > I am wondering if this can be solved by better defining what the return
> > > codes mean and adjust the call-back functions to match the definition.
> > > Something like:
> > >
> > > 	-ENODEV : Device not mapped my an IOMMU
> > > 	-EBUSY  : Device attached and domain can not be changed
> > > 	-EINVAL : Device and domain are incompatible
> > > 	...
> >
> > Yes, this was gone over in a side thread the pros/cons, so lets do
> > it. Nicolin will come with something along these lines.
> 
> I have started this effort by combining this list and the one from
> the side thread:
> 
> @@ -266,6 +266,13 @@ struct iommu_ops {
>  /**
>   * struct iommu_domain_ops - domain specific operations
>   * @attach_dev: attach an iommu domain to a device
> + *              Rules of its return errno:
> + *               ENOMEM  - Out of memory
> + *               EINVAL  - Device and domain are incompatible
> + *               EBUSY   - Device is attached to a domain and cannot be changed

With this definition then probably @attach_dev should not return -EBUSY
at all given it's already checked in the start of __iommu_attach_group():

	if (group->domain && group->domain != group->default_domain &&
	    group->domain != group->blocking_domain)
		return -EBUSY;

> + *               ENODEV  - Device or domain is messed up: device is not mapped
> + *                         to an IOMMU, no domain can attach, and etc.

if domain is messed up then should return -EINVAL given using another domain
might just work. IMHO here -ENODEV should only cover device specific problems
preventing this device from being attached to by any domain.

> + *              <others> - Same behavior as ENODEV, use is discouraged

didn't get the "Same behavior" part. Does it suggest all other errnos should
be converted to ENODEV?

btw what about -ENOSPC? It's sane to allocate some resource in the attach
path while the resource might be not available, e.g.:

intel_iommu_attach_device()
  domain_add_dev_info()
    domain_attach_iommu():

	int num, ret = -ENOSPC;
	...
	ndomains = cap_ndoms(iommu->cap);
	num = find_first_zero_bit(iommu->domain_ids, ndomains);
	if (num >= ndomains) {
		pr_err("%s: No free domain ids\n", iommu->name);
		goto err_unlock;
	}

As discussed in a side thread a note might be added to exempt calling
kAPI outside of the iommu driver. 

>   * @detach_dev: detach an iommu domain from a device
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size
> to
> 
> I am now going through every single return value of ->attach_dev to
> make sure the list above applies. And I will also incorporate things
> like Robin's comments at the AMD IOMMU driver.
> 
> And if the change occurs to be bigger, I guess that separating it to
> be an IOMMU series from this VFIO one might be better.
> 
> Thanks
> Nic
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
