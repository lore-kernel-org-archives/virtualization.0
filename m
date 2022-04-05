Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F390C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 23:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A61B826EA;
	Tue,  5 Apr 2022 23:31:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q2SDUlu917H3; Tue,  5 Apr 2022 23:31:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 69F198247F;
	Tue,  5 Apr 2022 23:31:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40426C0033;
	Tue,  5 Apr 2022 23:31:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2805C0012;
 Tue,  5 Apr 2022 23:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FBF44173E;
 Tue,  5 Apr 2022 23:31:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HIODLyhm2HYB; Tue,  5 Apr 2022 23:31:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF3E8409F7;
 Tue,  5 Apr 2022 23:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649201513; x=1680737513;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9ld9YxnqQ/tft6SeSwMe4rrTweNCvt3iXi6pX/TyAqE=;
 b=mVIYtNAkAWGveq+Va/yQfkXiNeJQ7q+jB+AQYpXe4mu1T655xtUzVdvM
 sFvdo0izrC/EHT018G2A5UZgOhORI398xp9M8X48J0T8AMAo0mXTuqhFS
 TZN7gHQo0TUE3LdRky6roz+zAVA6FPwN91JZQfHXiBwhp+96tWyiP6MUJ
 W3pNHpcRdts7h7vKvYxHPLpj8GC9MQr/yUJejQ+uTFSZQ5HNbkyt/HY1F
 GCsUTXL2qfONgzGTKtTX4WXCOIsUDCXxeySeAWTO6q/rHhK562G5ospau
 MgcpnQ/UzcsxLSFiuR7xBvV48klmoThdpJzJWK4SwKwdrNjYchnPaFw4H w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260586445"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; d="scan'208";a="260586445"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2022 16:31:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; d="scan'208";a="790051672"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga006.fm.intel.com with ESMTP; 05 Apr 2022 16:31:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 16:31:49 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 16:31:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 16:31:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 16:31:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikK/bGFmqhRcKq7GGdaRun5tD+ymfOSEyExRD8dOVURV3UDr6WOhdEuLCSJL1zNYwryZMlOTbHqXm/mIf2cQ71CKiCw06tKg1BaPbTi40vg7OCjH3ve+nfux08ueq4tdhLH9pdCDZ4Nsvqe4/EX9XbMVxzOILJU4ilzOMTTADOQ+2oOtz1mvhrMUchs7nvrt8bhj3wZxeUFAn9+3I041xclEG+43lDW6VjKJXhA1Ot29rAg3emPWecAphB+qGDd8wd6HAxnPlz4+9GcMTaZJSertldfdgliIXwf5iQGJ/dwDvZa8BvirQAWZ7pEWLQuKT566wQrqQ8lcGZJlJGEnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ld9YxnqQ/tft6SeSwMe4rrTweNCvt3iXi6pX/TyAqE=;
 b=QW2nv/VgYuvji/uKvx3rsMmlTFFM8R9jIyOWMPEeSs1PCKm8qU5jiaK+vQbN51hObTp+28Aj08Ba0th9aPX8uJQwn/MChOqd9ZdH/X/4BW7J2rELpCBWATIodoXk6K9yE13WDsrMeBt/i9QMqSEyUBnduwdpE5jK6MH9qR4oNqOdCCrOgu8iW7obEdF/q3e8kRIA7QJqFoE79c+9D6aB0/LBgRMZuVZJHysdm9/tBt/JR3mWV77Fu5riPxP2HEnZvPGcSaYDyLxLp94cv4rN6EYmOiywX7fEQPeL3/ndaWLu04eaP/wsxM+aDYnfXOGj04TrVCQDtA3kbxsYbrrUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB3749.namprd11.prod.outlook.com (2603:10b6:a03:b0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 23:31:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%7]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 23:31:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH 3/5] iommu: Introduce the domain op
 enforce_cache_coherency()
Thread-Topic: [PATCH 3/5] iommu: Introduce the domain op
 enforce_cache_coherency()
Thread-Index: AQHYSQiEbYC3kRQ06EKEzYAnMp+0x6zhusQAgAA0Q4CAAAdUsA==
Date: Tue, 5 Apr 2022 23:31:44 +0000
Message-ID: <BN9PR11MB52769195041933E35E9D8D428CE49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <3-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <20220405135036.4812c51e.alex.williamson@redhat.com>
 <20220405225739.GW2120790@nvidia.com>
In-Reply-To: <20220405225739.GW2120790@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a81af7e0-4fab-4900-09f2-08da175c7222
x-ms-traffictypediagnostic: BYAPR11MB3749:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3749F66EB97A17ACDAE93AA58CE49@BYAPR11MB3749.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1yYQP7AAmIBTTJMCFRAS5iBvOFqJgFQriYeFjiwW5C/Ttv1K2+55YfTlHuSqZ9JsadWxB+nA4RdGtaRibBOwjMI9IeFGDbchwZ5NzO/jTPg68f0Aek1/sAFZ5uUV6nEqeQKyXJ4vGMquflQI27WWwkUGAgjd+v4kAYs7SBe5ujuAU7IdpI3lT9Z9Irsr/vVYtki+N18ovZaBr4qQsw+ogZHUX8CCPDHE99Wvr/ZYSQN0S6bVoppjyba4mokG3IuF5FUFb2A5kyKypc2Rf3C5AMS55cL8ZAbUlqKrPpDC9MLlET0En/aw3g0tklOXw7tK/vFXDN6NwxMAoCWWAqa1VqX7N1UDtvNzzoN5jsa+yRliXR4eHxqz0mhUaoaA3kiTm8zfb8x7zBNCzVxW8C2FXbuBrntXjFDlSpGOifMBe/xAwxacXEz8Hg3Wi/HNmz04pbsM5MqPhPd+uQk5zbO1cca/ycpKTrq2PAjUefPPir7J2hiKpMZGv4ShMptOd2bye88Swdcv/9GmvMPp/6sx+THo7PZLNJvZwJ3d+kREDT1mqClxP8d+4vP5Bu6G2m9Bk/ebutxFGyqOnBFqrsmQCREj4yLo0i7RQWhAbQSCHWUyZ2HdQjjxJLMS0t4lyGFlUZWDPM4MYN7HsUVTnYiYxc/qhxnAMWty9erwuHzoI1kcbJTfvu5M1mQzhlye5s6ZIBCUlnjrIYWWpWAOICezdQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(66476007)(26005)(186003)(66446008)(110136005)(316002)(76116006)(52536014)(55016003)(8936002)(71200400001)(66556008)(7416002)(83380400001)(66946007)(5660300002)(33656002)(86362001)(54906003)(6506007)(7696005)(2906002)(38100700002)(64756008)(9686003)(122000001)(8676002)(508600001)(38070700005)(4326008)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFFENW9rMUtkQUV0ek1UcWlHR1dkZWxzZzFpQUhsL21tcElidzc2bkVPelFM?=
 =?utf-8?B?eTJLdk5rdUx0cENtR0NBU216cVhiQWpncVBXcmhXSVVGaEkwYnZISWZlait6?=
 =?utf-8?B?WGg0TTdlYWVoVWF1aVlZMWY1UTFubS9qMDVodUp5Z3pFU3pEZlF5Nm9zdW10?=
 =?utf-8?B?SzkwR28xYWNXVDVNSzZwSFhOZks4c21BWnljS2VIZlFXeEZoYnpySllzdWV4?=
 =?utf-8?B?MjNLUlV0QzJ2SDlwZFZyR0RVQ0tRdmVRdGxQbWZRYU12YmM1S0dzV0xyeVYv?=
 =?utf-8?B?bHFPcjJocXFIQm5OeDBpaHZiZ0pkRlh4L3d5U2R2ZjArVy9NaWU5L3hNSkpt?=
 =?utf-8?B?dVRha1IxNG94OFNTcjQzNWJBbExyankyakRTSXlKL3pMc0UxTlpWYnhGYmFO?=
 =?utf-8?B?KzFJbmpaUzZsdlZINUc0TFZXTU9PQkJkeWRTQkFLYTlXSGNaTHBlaW5iL2tu?=
 =?utf-8?B?dW90b1J6NFpIUEg4WGg3NWdXTEUxZE95cWlDOU5rQ25wVEpzVVNFbXZWUXJQ?=
 =?utf-8?B?NXFSV2lhQ3FaUlRsVWU4Q1pmTkdONy8wZ3h4amlWaXd4VllSUm1FN3diaTd6?=
 =?utf-8?B?K051dWxiSXRJRGF0RjhhUVhKWUxWQzZWZm44K2ZQcDJ0Q0JVaEVKVkNRcEY0?=
 =?utf-8?B?S1Y1VysvbXVMZDJrL1FQRTJoZkRQYXB5TjZhUnRZd3pSUDJlWnQ4bjQyMXZX?=
 =?utf-8?B?c1VsV1N3Y0VZdHozUHorMDQ1MUwvWlc1UTVKVG14a09WellDUS9NeGpkb0hw?=
 =?utf-8?B?Q1JtSFI5TFhzZEw2R0ZuNWRwRmpDSU1HVVBwVFZaeVRBQXc1MDZZN2pENGVL?=
 =?utf-8?B?Z0lySjR2SkxpdWs5K0RxT0JGaWdxekRqK1FvM0lWR3RFQWF1V3hjQjIxTmwx?=
 =?utf-8?B?Z3UrWldJUUZ5RU4raU5CbjIxcFpEQ3V4bkZ5M1J1MlZUVUc5THNWTXJLZng4?=
 =?utf-8?B?TzZ6WVFzaW11MzJ3MzlOdkd1eWRRcnh4VkJoeXdOckQ3MjYremI0dnJqUlZI?=
 =?utf-8?B?QzlTZmlIanExQlhzOENtVStJVGxUQTNNRjhrTFpmVnFlUDEyNkpHTkx4dnp3?=
 =?utf-8?B?bk9ZMjVxUmRlQnVDSzhqdC8zcnVhVXZYcGthbjNJMFBrMnZKdHVJRkVNODFt?=
 =?utf-8?B?MHhvK0ExanFYOUNBVkhXL0dmQTV6dWZoRjlDWXFEY01GVjlkbk1vTUJGVm9I?=
 =?utf-8?B?dHA0UTl5QUQrLzBHbDIxVjdqVTZwQTY4MmlrbHgva2t2dWVqeHV2TDRtTnor?=
 =?utf-8?B?L0lOM1l1dzgwdjBFZlU4VUtmaGdQU1doYml6d0pqeUtGZ085aG1UblA4bXN0?=
 =?utf-8?B?SGpZenRMYVpEQ1p5RmhTTitrOVNaQ2kxNFRscEthWUFtbVg4bkllWUV0NStq?=
 =?utf-8?B?U254eGJCVzJ0RndQbXlPSWpmcWtVTndpcFd2VkZuY095TmFpaEpxN2piZTVS?=
 =?utf-8?B?U3BrUVRWaExMTkkraEswWnJnb281MGp6TGhneXRNa2ZKVXBUZUF2bHdOR0ZG?=
 =?utf-8?B?clZXQ1NvZEc5WnJXQnFhdUN3Y0xZTWYyVGVjTUFrcHFSY2xpUnFtS0hxbkxP?=
 =?utf-8?B?N21QMDNDeFFTcHcwNy85bEdNNjJRdytHdXZjR1MxSVZaODdTeVNXNkdLdU9K?=
 =?utf-8?B?eSt5aElOTnd0em94cnQ1MFVNZElvdGJqdXppZDJ3KzV5T2lUUVp1Q1o3L2cw?=
 =?utf-8?B?NGNNK0N4YlJhYzFpdFVTeis2L0EzWWVoLzdmVENCdVdwSVpzK2lxRnBhVGFs?=
 =?utf-8?B?aDl4bUZrOXUrcW1TU3ZRRmdnYlZaUVAwbUFtWlJ4RWw3MHB2VjYzeHRuaE5O?=
 =?utf-8?B?dnQ4TlIvRmxkVUt2Z0l0ditHQUNrUXRlWTRraHJibEZLNnprb3pIL3dJZmNU?=
 =?utf-8?B?V1ZNQzZ0NmNOR0NXWnJkUmNyOFhMLzJZV2VMcyttVVY3eTFiSnp6bGtxRkJH?=
 =?utf-8?B?cnZna0RucUU1bS9xMFp0Mi9Ra1RLSndTOEdwdUNJazVjWWJxUEtxL1gyVjIz?=
 =?utf-8?B?OThuSHFhZXlDU3RRRTdFVnM2UWhLN296K3NFbUNTVXc0TXVNU09lSkpnUTdG?=
 =?utf-8?B?QWpFaXJEZDlRT09oTFZrdzhDY0lUU3k4S20wa295c3FIeERuNkVOMXdGOFFx?=
 =?utf-8?B?QkVnM2RpcG15MWgwVTkrb2NMR3ZRSWdaWnpWQ0VYRDRmYkllN1JsN0xXaEpQ?=
 =?utf-8?B?Zkk1T3lIajJQQmFwNk9ML0VrWEF4RDh6U24vMlJYUlE5bGVJdDZidGpJS3VK?=
 =?utf-8?B?SFd1aE9FRUVsODVMQmZZYmZabXhvRzltRkhjRnVVK1pHbW1LSE1iRk1rU2l5?=
 =?utf-8?B?b0R5Uk1NaTFWS1RzejBBWTRCUVZwYzRNdVFKS0FZNU42S1BIOUZQQT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81af7e0-4fab-4900-09f2-08da175c7222
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 23:31:44.3735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LoproUycFzsFr3d1QfdiOOK6W6XLxgoAt5z6sK+akKad2NtiDZaMXJt3YLALySSRhoMcARRLrVsaK2BGiOupUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3749
X-OriginatorOrg: intel.com
Cc: Nelson Escobar <neescoba@cisco.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Joerg
 Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Rob Clark <robdclark@gmail.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Christian Benvenuti <benve@cisco.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEFwcmlsIDYsIDIwMjIgNjo1OCBBTQ0KPiANCj4gT24gVHVlLCBBcHIgMDUsIDIwMjIgYXQg
MDE6NTA6MzZQTSAtMDYwMCwgQWxleCBXaWxsaWFtc29uIHdyb3RlOg0KPiA+ID4NCj4gPiA+ICtz
dGF0aWMgYm9vbCBpbnRlbF9pb21tdV9lbmZvcmNlX2NhY2hlX2NvaGVyZW5jeShzdHJ1Y3QNCj4g
aW9tbXVfZG9tYWluICpkb21haW4pDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgZG1hcl9kb21h
aW4gKmRtYXJfZG9tYWluID0gdG9fZG1hcl9kb21haW4oZG9tYWluKTsNCj4gPiA+ICsNCj4gPiA+
ICsJaWYgKCFkbWFyX2RvbWFpbi0+aW9tbXVfc25vb3BpbmcpDQo+ID4gPiArCQlyZXR1cm4gZmFs
c2U7DQo+ID4gPiArCWRtYXJfZG9tYWluLT5lbmZvcmNlX25vX3Nub29wID0gdHJ1ZTsNCj4gPiA+
ICsJcmV0dXJuIHRydWU7DQo+ID4gPiArfQ0KPiA+DQo+ID4gRG9uJ3Qgd2UgaGF2ZSBpc3N1ZXMg
aWYgd2UgdHJ5IHRvIHNldCBETUFfUFRFX1NOUCBvbiBETUFScyB0aGF0IGRvbid0DQo+ID4gc3Vw
cG9ydCBpdCwgaWUuIHJlc2VydmVkIHJlZ2lzdGVyIGJpdCBzZXQgaW4gcHRlIGZhdWx0cz8NCj4g
DQo+IFRoZSB3YXkgdGhlIEludGVsIGRyaXZlciBpcyBzZXR1cCB0aGF0IGlzIG5vdCBwb3NzaWJs
ZS4gQ3VycmVudGx5IGl0DQo+IGRvZXM6DQo+IA0KPiAgc3RhdGljIGJvb2wgaW50ZWxfaW9tbXVf
Y2FwYWJsZShlbnVtIGlvbW11X2NhcCBjYXApDQo+ICB7DQo+IAlpZiAoY2FwID09IElPTU1VX0NB
UF9DQUNIRV9DT0hFUkVOQ1kpDQo+IAkJcmV0dXJuIGRvbWFpbl91cGRhdGVfaW9tbXVfc25vb3Bp
bmcoTlVMTCk7DQo+IA0KPiBXaGljaCBpcyBhIGdsb2JhbCBwcm9wZXJ0eSB1bnJlbGF0ZWQgdG8g
YW55IGRldmljZS4NCj4gDQo+IFRodXMgZWl0aGVyIGFsbCBkZXZpY2VzIGFuZCBhbGwgZG9tYWlu
cyBzdXBwb3J0IGlvbW11X3Nub29waW5nLCBvcg0KPiBub25lIGRvLg0KPiANCj4gSXQgaXMgdW5j
bGVhciBiZWNhdXNlIGZvciBzb21lIHJlYXNvbiB0aGUgZHJpdmVyIHJlY2FsY3VsYXRlcyB0aGlz
DQo+IGFsbW9zdCBjb25zdGFudCB2YWx1ZSBvbiBldmVyeSBkZXZpY2UgYXR0YWNoLi4NCg0KVGhl
IHJlYXNvbiBpcyBzaW1wbHkgYmVjYXVzZSBpb21tdSBjYXBhYmlsaXR5IGlzIGEgZ2xvYmFsIGZs
YWcg8J+YiQ0KDQp3aGVuIHRoZSBjYXAgaXMgcmVtb3ZlZCBieSB0aGlzIHNlcmllcyBJIGRvbid0
IHRoaW5rIHdlIG5lZWQga2VlcCB0aGF0DQpnbG9iYWwgcmVjYWxjdWxhdGlvbiB0aGluZy4NCg0K
VGhhbmtzDQpLZXZpbg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
