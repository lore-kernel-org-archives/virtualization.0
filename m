Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085112E6A
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716181165; cv=fail; b=gELsZrPP59EQRQsflXtrv7zcuhrUMLnftb4Rkc+MuH+MTUcdgC2gLICq7GXoHZquXKCjrkYY6HcwKah0xei7HC/VFcM1EnBGVmVzDjs2RqsH5V45wg4dtb/R9X7NtLjeOgR20rLXUCd1DuUwu234T4MGgnqLqnRPbI+NBkSpXn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716181165; c=relaxed/simple;
	bh=XkAFv6lA0V8KqYlTFuJFIZqJGiUc7FKMj9NL6j4K8jI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GY2ytHD5gkj/eO6hrV3bI0mTxzrvJwNiF1U1McxUeUAb/N9n2tBXZWdv2tEuu4AXESwL/UZpqxk4/3tfV0Cxwy1WqX6V7RIQDOZdzAvBs7yFD89jtO/TVUxz/WGIfurwyPHSRH1o6VrkQ+1S4jNUWAR4goJ0B6rkMjO8h1ENc80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ijt34zR5; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ijt34zR5"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0951F81284
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 04:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIgxtukG1W1T for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 04:59:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B935181280
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B935181280
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ijt34zR5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B935181280
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 04:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716181163; x=1747717163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XkAFv6lA0V8KqYlTFuJFIZqJGiUc7FKMj9NL6j4K8jI=;
  b=Ijt34zR5TnoR9bPNfxNRtdAY5HJ+Sfvqv8mOiby25lzDdOUp680IQX/S
   pxiD1DVdeOZFGqWy1S6nYLpJM1URO4F55MsYFvIYa9uE6hvcsThxqxnbg
   bXb+rnXDKE/wEQ32pvsZFf0M0GCdynfdZnDUQhq0OcGgzcKSesCzmRfwK
   h8aPEFuVCen11xkqPCBhhi1cOMX8wEp6x8ZFQTSZDkfpKGBR5xuHpApm/
   A54iTInRLVE4mQn+MNX1Vj0cxieiVTzzd/9fvm4FqhqG+mmEo+HgDZkky
   Qxzci4vdnfJN4rOzfKTEFQR91HIPozXNQFuUEezCfBCn4WEJpgh8W27eJ
   w==;
X-CSE-ConnectionGUID: 8xiH771/R1CIdtGpdUXebw==
X-CSE-MsgGUID: WpsPoxQbQLumnn8B5mxcRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12412965"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12412965"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 21:59:21 -0700
X-CSE-ConnectionGUID: Usnf5tNZSomss3Jf6bkLmQ==
X-CSE-MsgGUID: krPKZaawQAOJJ61Wk267tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="63232934"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 21:59:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 21:59:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 21:59:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 21:59:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 19 May 2024 21:59:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcqNJJkamab2OerwGyUEn/TNAPzecR/+E7wiEV6D26mavzv6kVbgIlbfxvbaikC+cH1OEr2FOg9PIYoQaF5dJZh2rpNwLZaq/ADQXaK8smhLYQGeLpb1+MNZbWEqbgt/DK3gQ7U8Eg+25OCgPq9CXAQL3b3FeAZNI+hqhcQg5qjntx9dVM7+KQT9ptIxsk+U1eSnHJ5owpEeI5xDf3AA4W84fJW5MtsBFlC8ln12X7EmY7ujOYltBwPwyusMi1rnHetIDQ3yz8GMVUwrHEdpYYj+YM6q7ktszVTmJsEOGQtCh3XO/Cjz23kNwxtFyrVRwNYpByjp1njt9M8zKPyNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkAFv6lA0V8KqYlTFuJFIZqJGiUc7FKMj9NL6j4K8jI=;
 b=MCT/sIt6c4dCfW1m2R6I7xnw3VZmm/FXErwgJLpJfUPieyvgmOOUM+D6EFplkR9DearGE7fgTuekdzuA5PRnxwkPea338Gm6uV01GFp4T5tEIvxg696q3YLjAywJWKAALX5qnEqLi/7K4HWyrWRzQU0qMnDMYZoKXojjGrhDDJPFEMbp2463nfkkv7ANVy/HNlBwKxwTYUboY6EfUpG5+AfD68LGhZr5GyMHW0HH1fwrQ1iLX7dSTOvwLti+ObL2QdeAgfHLsrcR3fo1yA0XvFSeFxSeVqcj5dm3Q/ZpdmPLuPhKwJSydMJy+WUuRy3gLJT+PZN+dxjK4NtTJ4AU3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Mon, 20 May
 2024 04:59:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 04:59:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
Thread-Topic: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
Thread-Index: AQHamw8bLYtOgdprmEKnPZxoJChdq7GX/cMwgAbATwCAANVHUIAAA3eAgAAUQJA=
Date: Mon, 20 May 2024 04:59:18 +0000
Message-ID: <BN9PR11MB5276EEE89AB66C0EFB6D4DA88CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
 <BN9PR11MB5276A68C9DCDA201826714018CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <04288162-e5fd-48f3-bb60-a41b4ed2c244@linux.intel.com>
In-Reply-To: <04288162-e5fd-48f3-bb60-a41b4ed2c244@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5820:EE_
x-ms-office365-filtering-correlation-id: 115653a6-6617-4bf6-b377-08dc78899ab5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?cThONnJweU1IRFhWZnRXbFpmcTlxQTF0aTI3WkNGRHJjSXUvOGhwYVlwRXBK?=
 =?utf-8?B?WjdwVGhtZHlVVThYdjNpQ3FsT3VOZkErVTdPelBMc3RpeXI0N0d2aktNM3Vj?=
 =?utf-8?B?SG9TNGZLVGZSUjBobGthRDdMdnZZVUt5bFFxRmxsMzdZOVpWVHRxTnMxRGta?=
 =?utf-8?B?SzloV0Nlbm0ybjh4TXJibDA2R1NjUU5HSCtlVzlGNG1ORGpLNkx2SlpFcW1O?=
 =?utf-8?B?TlcvcVJ2R1QvUmhrdlMxbUVRMEk5NGlPeHlQZUNzRGdJbUFmaUlMR1RmNlY4?=
 =?utf-8?B?d2NYN2RNUmgwSGJ5NzgvSG9DREhOQmdWZE45Si9UVER0R1hERzJLeC9ROXhE?=
 =?utf-8?B?YUNNa3FNZnpmTUw4LzA0ejNoaEYxVDFiYU1jSjFiNW1OeGZNaUE4a2ZSL1F0?=
 =?utf-8?B?NkJwSmJvMm96akFEMndnbFQzWlpwTy9LUVdFbHBhSGVQU3dkaUY2V3BINko4?=
 =?utf-8?B?dmc3Yk14azRUT04yM3p5enBlTVNBV0pnazhRTnJnZ2g3YitRWWlnNm1HTUlB?=
 =?utf-8?B?TWUvMjlteEgvUjlmVENtMnRqQ1BjQlFrVDRldGZFWUN3cGYwUThhYkdqLzM2?=
 =?utf-8?B?bGRJbUlXMWM4UGxUMXdsSDRhMG9sSDNGVHFBQ1EyWUdWZTVybnJYd2NObHNt?=
 =?utf-8?B?UmhHejU1UW83SS9rZEVuSGpVUkVyNmVvcktRL0tGdWRBVXVCWmNKS2FzUldD?=
 =?utf-8?B?SldZdy9Zd1E4UDRMeXFlT2QvdUFKRVF1b0FlQ3kwWGNvQkw2VjAyK25pWk5D?=
 =?utf-8?B?TXIvRGNvSWxaY0NvZ2h4YWYyczIwcGs3Vm9lNHl2azFoM1hHS3F5aEw5MCtR?=
 =?utf-8?B?cVFLYVlNbC9ueWs4OGdhVFNvaTlXakovZk1PNjBUZFFESVZ1Ui9CZEtkSVNk?=
 =?utf-8?B?NlZ1K0VtNW9TYVh6TWM1M3JoUzUwN21MNHFWWG9wa284cWxabTlzOE9CeTNM?=
 =?utf-8?B?TVVLNGVkT2JSL1pZNTR1Y0kvNlVwQjQ0UStwbGFpRzI1Sy9uOUY4MVhCVmow?=
 =?utf-8?B?NzlhVHBDNDcxZzEzRTVCZ2M3Wmt0ZkFaYlNhS1RnM25IRlhmamV5dmM0VFhJ?=
 =?utf-8?B?U21ZVEVtMlNwVENPNDU0aHpkcVFDL0NYTDdlV21GUXdzOGlhWWpIYiszOTBw?=
 =?utf-8?B?eCtra3lqWU9sZENqS2FwVXVpZnlwUWNUeThJS1huNENRSTJuQSsyc0krZnJB?=
 =?utf-8?B?T010SzFYY0doMXhzYXN6QVprMGw1WUtmRVV2SDNRR1NiQ2g2S3F3Z2FuWEJQ?=
 =?utf-8?B?TWFYN3lPYW0wMGtTTXR1TVZrU090Y2tsQWJ2Q3VZVm5uSGEyNXUxTERWNlNk?=
 =?utf-8?B?WWV5VG5XL25kdjEydWNKejROVTg3VVlrQVBQMXc4WExwcCt0U1NDZDZMYnhv?=
 =?utf-8?B?SU5aQWJHamZib2V2SlYxM2tuYlY0ZnpGMnZmYWxONVhSQmlGRDQwRVBzZjlk?=
 =?utf-8?B?Zkg0blVUZmM1RFNiQVJxVmVzNmxXMzNybzZuWnlSc01WRGFkcWNxWjhDeUpK?=
 =?utf-8?B?V05NcS8ycm5LODYxY1FmODFEZXdkdzlkUWIxVFVab2ExanNPMzVEZ0xLY1VL?=
 =?utf-8?B?WlhlY3RqWFVVay9aR3dvYzhrSUtMSHAxZDNoU0RJWDd3dEdyczhnWlhGQmNQ?=
 =?utf-8?B?VTczTXQ2aTRJNldwR2p3Z2NTQklPNHF5cFFFSlRsRThLcS85ZmJvcUJlZnNJ?=
 =?utf-8?B?NXpqdStQWDVNV3lhclVjbTBCeFM1RWZ4Q1JTSXZoMHIwOVc1WjU3UVpVS3k4?=
 =?utf-8?Q?QkOQQ6LMD2mADPj4XU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1VRT0ZBbmJLdWNWNEhGRjFXanZEYUkvOElKTWQwTXpKaFVLWThHdDJhV0lN?=
 =?utf-8?B?dnNta2pPODBoRkdNa0VVbSt2eWI1S1FKdHlXYlpVZEpaYmhsT295ejc4RWd5?=
 =?utf-8?B?T1A2YlZhWVlPOFJNNGNHVEdsWFpHUUJKaS9ZRzNqWC9ydTFXd1cxSXNyT3cv?=
 =?utf-8?B?Yk11ZGZ0NnhzY2xwcVJwQnUvbThzNGdyT1MvZE1sR3l2a2J6RjJOQ3Y2TEl3?=
 =?utf-8?B?amRlcVA1eFFmTnFaMHJFTGNzanBXT3VzaVhkbXdDMERablZTQmVkZFhtd1Y1?=
 =?utf-8?B?Y1dVTCtsNndBM0o5UDBlalU3SU9mU0pjU2hyU04raThmWjlXM3ptUitTQ0d0?=
 =?utf-8?B?TW1hQS9CbjluSS9NTE1NdHk2U2tMcDBJa2NWVTZOVXVNL2lsR0o3NStzeFlt?=
 =?utf-8?B?cnRROFd6dG9TQjdIa25vY00rcTRPdFllMkc5UlFSQVJVQWZwR1ZsK21rNkUv?=
 =?utf-8?B?VE9laHp2RVBnVGZQL3dWZUNJSnNXdU45d3FhWlU0blVXNzh4UmJsM3o3Y0JY?=
 =?utf-8?B?UkJFa3NpbjlEN0NEWEpVWWIrcHpBQ09TU0hKZ0htNjg0MXg3NDdWZ3p3a1hC?=
 =?utf-8?B?VDE3VUZuMVVOMGl5dWR1enNQUFhPanZTeUVtd1J3ZVpTS0hYZlByYzdaV0pu?=
 =?utf-8?B?bUZGTzhpSXZ1ZkMxZytUZkRVUlMwUkljbFc4Tno5UXBSNkxhVHY2T295VEFj?=
 =?utf-8?B?TjlRWjdJS0M1Q20va3dyWFY2R1RjVExwMUxPTU8zZ0dBaFZSR28rdFFhSGZO?=
 =?utf-8?B?L0w1UVVYZ1ZZd0JFLzFTaTJCSFdRdnJ6OFpOTUhpVTlKVS9rUlByQWlWV2w1?=
 =?utf-8?B?ckhtMnRTcHFTY1RqNGNWTlRRRlBRSUI0Y01SRlFyUjNmQXF3Y1RmMS9pWVR2?=
 =?utf-8?B?Y0lPeDM5ZldKS2VBcGFMcmxXMGJwWDQxN0kxSzg4MnY5eS9HN2hCVThnRmJH?=
 =?utf-8?B?SUlnZ2syeFArUzJscnZPUDB6TldyUG5zZmhBenNlSjlNQkFNYWZZMjRLdmor?=
 =?utf-8?B?L1dVd0hsRjNqUHRPYjRFcUNhU1FqcFhFNjJjOWlvamtIRjlHanR1bFZ6Wjg0?=
 =?utf-8?B?eFB6M0drMzNwZEhZbDM5YmVNeXRVU3U2NTgvUzA4NkZpcThuekVKTTJ5NWhs?=
 =?utf-8?B?Q2pzMVhXTDBMblYvU01mSldwZDVQS3d1RVkrWUxBN3ExeGNCeUtPL2VOSjc5?=
 =?utf-8?B?SklHVktvbWRSNGVsb0RvdU5LYmdjc1NEdk5Bb3Z2VEJYVWFrYkRZa0xvZzhD?=
 =?utf-8?B?Qk9JQ3dJQWhvMkJqd1hrd1B3QldVdWVWN1F0bjArVzA0SURnOUVNbVdFUEFL?=
 =?utf-8?B?TmFGQjJ1clRhNm9NNStOZU53VkVIWU00aWFFN1pUeU9TYzVTeVMrZXY5bEIz?=
 =?utf-8?B?OG1ReTRPdy8wcmoycXdiVmxkL0owMTRqaDA4MGxBamZRVFNZQkFpak5mV0hz?=
 =?utf-8?B?Y0phczFNNklubjEzdWVkZEhrMksrL3U3eWJlYzlwSGNQeU1nQTd2WlVGK29Y?=
 =?utf-8?B?RUJ0T1pFQjF2c2t1TzNxOFlMREZibmtsYm1KckxXOUJlK0IweCt4Z3NMSnVh?=
 =?utf-8?B?Umo1UWxhT3dvZmtOeFFzY0V1WmZTaEk4amM4Q2VZbmFwN2JVaVVsQmM2L2hw?=
 =?utf-8?B?RGVXK0paTFUrbUtDakgwQ2RneUVHa1FLdk1QZzl1SUJQSEdXK3NmdkdFa2RX?=
 =?utf-8?B?bDRMdnAyeEluM1ZQN3ZOR2QwbDJTVXNDRGdkbWtoRGVwQ1pTc2F0VTh1THBF?=
 =?utf-8?B?ZGdPR2FzNGEwYXlvbHVObGdMVUpZR2ZVNS9nNGlJOU9QdXhiUmRaUE1lRWpO?=
 =?utf-8?B?U2ZTb2czNktZK3JSZ25IdGR3dUdHREF2eTVER2Q0RjNWb2dDWDc3U0dqNVZQ?=
 =?utf-8?B?d0ZJKzBnRlBXOU9hNzJWNTVHc0E1MFFLSVFObk5ZSCs1dzh3SURwTXRRa1hu?=
 =?utf-8?B?RGlqZW5Ga0hlS2hJN0JjZE95R2hQNERUdnNGK2liU0FVcEZBNHRlU28yS1Rz?=
 =?utf-8?B?QkF6T1lYc0RrL2NiQTNFUG92eHQ3RVNZVlQyeVdNLzlVQzhRTW1wYnNFbC83?=
 =?utf-8?B?aEszTnE3RlY1S0tZM0RHMkk0YmxmS1c1Si9ucnFvejFmN0tnWEhNUEhlemVQ?=
 =?utf-8?Q?uDZBEGA0DrJLeF5hihmup8wBM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115653a6-6617-4bf6-b377-08dc78899ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 04:59:18.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZQBKnqGOEKgS8rQn1hlQuRuSHr5ua8dTPhraZGyXNegES87bl7RsreCKsEn88CWdYPjd4sP9kQIJon/zaiWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5820
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE1heSAyMCwgMjAyNCAxMTozMyBBTQ0KPiANCj4gT24gNS8yMC8yNCAxMToyNCBBTSwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4+IFNlbnQ6IFN1bmRheSwgTWF5IDE5LCAyMDI0IDEwOjM4IFBNDQo+ID4+DQo+
ID4+IE9uIDIwMjQvNS8xNSAxNTo0MywgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+Pj4gRnJvbTog
THUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4+PiBTZW50OiBUdWVzZGF5
LCBBcHJpbCAzMCwgMjAyNCAxMDo1NyBQTQ0KPiA+Pj4+DQo+ID4+Pj4gKyAqIEBsZW5ndGg6IGEg
aGludCBvZiBob3cgbXVjaCBkYXRhIHRoZSByZXF1ZXN0b3IgaXMgZXhwZWN0aW5nIHRvDQo+IGZl
dGNoLg0KPiA+PiBGb3INCj4gPj4+PiArICogICAgICAgICAgZXhhbXBsZSwgaWYgdGhlIFBSSSBp
bml0aWF0b3Iga25vd3MgaXQgaXMgZ29pbmcgdG8gZG8gYSAxME1CDQo+ID4+Pj4gKyAqICAgICAg
ICAgIHRyYW5zZmVyLCBpdCBjb3VsZCBmaWxsIGluIDEwTUIgYW5kIHRoZSBPUyBjb3VsZCBwcmUt
ZmF1bHQgaW4NCj4gPj4+PiArICogICAgICAgICAgMTBNQiBvZiBJT1ZBLiBJdCdzIGRlZmF1bHQg
dG8gMCBpZiB0aGVyZSdzIG5vIHN1Y2ggaGludC4NCj4gPj4+DQo+ID4+PiBUaGlzIGlzIG5vdCBj
bGVhciB0byBtZSBhbmQgSSBkb24ndCByZW1lbWJlciBQQ0llIHNwZWMgZGVmaW5lcyBzdWNoDQo+
ID4+PiBtZWNoYW5pc20uDQo+ID4+DQo+ID4+IFRoaXMgY2FtZSB1cCBpbiBhIHByZXZpb3VzIGRp
c2N1c3Npb24uIFdoaWxlIGl0J3Mgbm90IGN1cnJlbnRseSBwYXJ0IG9mDQo+ID4NCj4gPiBDYW4g
eW91IHByb3ZpZGUgYSBsaW5rIHRvIHRoYXQgZGlzY3Vzc2lvbj8NCj4gDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjQwMzIyMTcwNDEwLkdINjY5NzZAemllcGUuY2Ev
DQo+IA0KDQpXZSBjYW4gYWx3YXlzIGV4dGVuZCB1QVBJIGZvciBuZXcgdXNhZ2VzLCBlLmcuIGhh
dmluZyBhIG5ldyBmbGFnDQpiaXQgdG8gaW5kaWNhdGUgdGhlIGFkZGl0aW9uYWwgZmlsZWQgZm9y
IGNhcnJ5aW5nIHRoZSBudW1iZXIgb2YgcGFnZXMuDQpCdXQgcmVxdWlyaW5nIHRoZSB1c2VyIHRv
IGhhbmRsZSBub24temVybyBsZW5ndGggbm93ICh0aG91Z2ggdHJpdmlhbCkNCmlzIHVubmVjZXNz
YXJ5IGJ1cmRlbi4NCg0KRG8gd2Ugd2FudCB0aGUgcmVzcG9uc2UgbWVzc2FnZSB0byBhbHNvIGNh
cnJ5IGEgbGVuZ3RoIGZpZWxkIGkuZS4NCmFsbG93aW5nIHRoZSB1c2VyIHRvIHBhcnRpYWxseSBm
aXggdGhlIGZhdWx0PyANCg==
