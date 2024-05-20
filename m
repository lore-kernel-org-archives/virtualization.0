Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A1DDD4
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176002; cv=fail; b=I8t54W+ruYHL7QJ83BG6uWGLElErivY7jTklKSk9l/iGAxvjXubaVDyHxKHYJK9vTT5i+xjfQdhQIjbf2BeP4PvxZ0zxjWifzMwse6gt7IyF/BpkGHnLlUpkAU7AZyFv2nzfyb96bhshJEvB7Jvo4wH11og6vSalrP6S8ysnNPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176002; c=relaxed/simple;
	bh=DBj+XUlIM1mxNmIDpXBo3RNG6eRRpjBhJZ/7kLFCJ8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ebUr4bhxOoSmZwzGsrwcuoAXmtTPWI39vdfFjSvmZ8BazMb12UWzN9YHPbuZ5UGy2AKzDL4SKOB3Mp/dI/B8IGitIRfEnsHlmhBjzcikCNLqD0XI3gempoerJZs1YjxcYJQHpmmyV03Psjt638ioyCLDfkaCl/G8iJj0OOd2EbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ey8R6xAU; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ey8R6xAU"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA3FE408B6
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYOy1oRAbQ8c for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 03:33:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E829B400F2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E829B400F2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ey8R6xAU
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E829B400F2
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716176000; x=1747712000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DBj+XUlIM1mxNmIDpXBo3RNG6eRRpjBhJZ/7kLFCJ8w=;
  b=Ey8R6xAUIbRAw7dEs6H1aSOuxHr4EtMC9Mh8pgo633iRuexwWyhJfehK
   So66LIaSxNCwDbQfQilCwEeD5Cc/pHF5Gz5CFyRmgFEenckwAnWY7KoIx
   6Tnwqwi4NEfg1ADedEVifLsazu+lF03jFvRVOfpV6FBCVwCFQtfbwm9vm
   Swn9l1ub7yg3MaEm/hbaVY37k5gjs8HUPoyOK9X9WYOECvNMVpg+oBTrS
   L00i7UcelbMH6iymS6GwOH9pDXlnbUQDjtvAi9w8N5XrLYOy0/9zkibd/
   Cr/8Q3Xyd2FP0xYO8V5/hcSs21je8AooJ4qu/Rhhrdb5014Vj1qeH9ze7
   g==;
X-CSE-ConnectionGUID: rcg5np54RP6DZgB42Pw9Tg==
X-CSE-MsgGUID: fESKTDPwQ16U78vFoXWUyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="16074612"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="16074612"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:33:19 -0700
X-CSE-ConnectionGUID: pRspPAiaQ6+o2Edznf6HHA==
X-CSE-MsgGUID: IGxBxpDxQZKSi8/48PihuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="63621058"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 20:33:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:33:17 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:33:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 20:33:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 20:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLHdbX2JDGOu8fgJsk6h6CZkg/+Kxq1H/E3o5qTlSSQNfIs64tbS8V2YhYwRAFwI1D3zij0hggCIBVc+hWVgXGmpgQ++akqQlWVpKMH3ocWXEzM06OTatxDYfS4i46korubDIWhvzXzqnr0juODnKveGrJu9lPtJo0/SOvfSxBu9zx8oVMvNL5ZBxZ6im8dC3BzwjNyHcCh+B+FqmtxFqN33zWzCcG2co+jxX1rCaryZQD08cu/MtMrG1FuNnfkXL1x5QaWprUqmoluelZ7brEeqc484X2M9ecaUOjT9gng96V92eaR2qiPhE47lwnz7eahzNh3bUoDRVXiVU/UZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBj+XUlIM1mxNmIDpXBo3RNG6eRRpjBhJZ/7kLFCJ8w=;
 b=AOnOmPsqDzptEnBovy+8iobMVaGjn2/IrOizDB3UVuFoXCgtZFXy6ziXNq2RtmixfinkLJH6O7vuoJfWN0gm3jiTVbeIK/dcIb91TimEPqgcRpx+JQ0NqO3xapA9QH8h5gF/hmE8SmkvONjEcgNjyj6QGKzN6QfiUVaD/+w/OP6cfhfkNcms7cTvfaxIFToKvKbSeMVkbECTy1Oz60E6U/14Sj6qGWUA0WzD2yE7wekO5YWWzvRA4wmr6iHD1EiJvHPH/6aDkFmNPi2ypogR6i+bn8vjX7hvpTYaK6RL8MKx18YGZ4zBUkYpEtKkCAiawYdUp8sm20X0MXvvarWkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB7703.namprd11.prod.outlook.com (2603:10b6:a03:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 03:33:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:33:14 +0000
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
Subject: RE: [PATCH v5 5/9] iommufd: Add iommufd fault object
Thread-Topic: [PATCH v5 5/9] iommufd: Add iommufd fault object
Thread-Index: AQHamw8IPv7IV85GSUGxhOe1hMt7NbGYATUQgAd0KoCAACB/8A==
Date: Mon, 20 May 2024 03:33:14 +0000
Message-ID: <BN9PR11MB52765979B524A9362B3D773B8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e30d919c-2e28-4e01-8317-2a4d82049056@linux.intel.com>
In-Reply-To: <e30d919c-2e28-4e01-8317-2a4d82049056@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB7703:EE_
x-ms-office365-filtering-correlation-id: 21439ae0-e346-4e03-d07a-08dc787d9533
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?MEVKbStqMjJXRW56YUJGQTBPZzBvb2xodlVXRUc0OXAxcjNzYmhHS2FYUi9Q?=
 =?utf-8?B?UlU2VlJmSWZKVXpKWHFWOUxOcHZmU0pwT091NzlIWjVxeU9CR1QrcC8ramd2?=
 =?utf-8?B?WVFqeHZFZnBENWR4b1BVYzZ4THpkbWpPRWdjSzhZbWYrcXVQVENTSFhFbkcz?=
 =?utf-8?B?cUs0MGN6WmRzcVhUemVHc0pHUUJNaWtHaFJ4N2pqenJ0ZVBPSUZDbXNTTU5V?=
 =?utf-8?B?aTJXamJvemZ1Y2IxYmt3WVZiQXQzUTVFWmV0L092Y2xFKzJhYStLSFVUWS96?=
 =?utf-8?B?Yk9qQi8xSXBkTnZDNFBHa2I1ejErcjlLWVA2Sm9tSTh5MnUvSFdlZXhzNVVr?=
 =?utf-8?B?ZzZWZHE3N3owdTRvdjR2ZHdhei9IRzVnMEoyMkxxaS9GSEdwUWdWTU5xZlRQ?=
 =?utf-8?B?UHRMbXRHZGJ1YWswZU5VR2t5VUNVQWd1aDBnS3lpYzFOK3ZJeW1YOEs0Z0hM?=
 =?utf-8?B?RWR0OHhFZFBTaTNGSUtjQ0pGZ2IrWFBIWnJzTCtjZnhJTUVLVWdySU50L0R0?=
 =?utf-8?B?WksyL1ZMbXVDZnlDSmVhRnRDSWRPZ3ZrQzcwUGY0c3NwYm5YTGd4NUIrdlRw?=
 =?utf-8?B?WEtGTjBxVnhsMXIydVJySkJ1QVF1dDEybkNmUldPWjdjT2lZcEhRNzRRWUxW?=
 =?utf-8?B?SlhTVXI4ZXZCTDMxNHc5RmlsVitjMzUzelFocTMydzBqbzVlZnJzSkNsbUp0?=
 =?utf-8?B?OG4zRGpHNTdCSEFyQktKVEdpZENQWG1JVjBHbkVsMHRzUllYZStNcWtDSUpp?=
 =?utf-8?B?NExOMWNQNURRakJYZWRYTkdTM1VhV1dOZWU4T2J3dm1nMWM4Q3VPT2dlbVp0?=
 =?utf-8?B?ZXNjbklpNVZ6THltRFZFbGlZRmxGNHZuRVhMMlptY1UrZzNuSkJxcURqcGFv?=
 =?utf-8?B?VVRGTks3cVV1YjdWQkxTa1lteU1lMVFuYUxETXRhODVLZ1ZUUW50NmhKengw?=
 =?utf-8?B?L3R4UGEySGhVZEZXejJyWXBIcjdYVnVJUEk3dHZmZm03NWtQejVMaWYyTzVs?=
 =?utf-8?B?WjF2NEV3a0l6VElGOFBXb2R5djdiV3VNTFZ1djllNTIwNXRmVEgvbUZIZFRa?=
 =?utf-8?B?alVNY1dQc1FTLzRoYXJwVlY0K0tOS01xVHJXWDVwQ0F5aGJ3d3EwUDJMUTE4?=
 =?utf-8?B?Z2VkQm1tb25Fak1SYXFuVFRiUWQwQ0p5THpsT2pyaW9mMEZLVUw3UkUrdlJV?=
 =?utf-8?B?b1dBRVZvc2lDNGtkVEYwQ1VQVXRDSzhpUDcxSkJEeVp3TUEvYXBMaHJBemNB?=
 =?utf-8?B?dUJPYS9iR3lOdi8xSDM3Vlp3TGpwU2p4bEcwM1B2S2c3STBHR0Z6enVITHNq?=
 =?utf-8?B?cHozcDRkOHZhTmlDcXZnTjVpZGs3dDg4Ym4xbk1pL05jMmVqbnQwLzJPNXlY?=
 =?utf-8?B?SXBiVG45UC9OaVFlZXFnU1A4aVRQVWdVWWpkZUw5ZU1iWHM1M0NyQTRiRDJC?=
 =?utf-8?B?aWNCSjNROHJZS0czMGJ3UndCV08xS2V3M3ZtSHJIL2FMdXJLQllOOThvU1Fq?=
 =?utf-8?B?T0JOR0RLZUVpaDhKTXB4OGNXUWhHR1dROGQ1QTFUVUJNRmtzZUZ5dkx2OFdh?=
 =?utf-8?B?blJ6NTg3NXluVEVkcUNQOHlvSWY4NFU3ekRUZWtWaVl5RTdVRW5SSUcxRlNW?=
 =?utf-8?B?NzJqa1Erc1cyWmFrUkVjVVkwL05ZMCtCcWlXS1NzT05iTnkrUmxRcUtwOHlx?=
 =?utf-8?B?SERYeFdmaS9yZXIzUjVuTFN2L1BVdmZiNkwzL0RWQWlURU9JUXpId2ZwWkxR?=
 =?utf-8?B?elUyKzFiNTJiNlQxbGRaYlFjSHErRmtTWEQyL21MNE1IYUtNMWFSYjB0SFVR?=
 =?utf-8?Q?UeRIgUymfUJ/7IZy+mdVvVzY1i3Dk6i7p43tg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUZ6a3phVjZqb3BRQTQzMVoyNTBMbzlnZnhIQmtwcUcvNjRLck56SjF1MU9D?=
 =?utf-8?B?K25pSWpMM05VSWROTko3TXJLNGdGbzBEQTQ1N2ZlWmdUcmpiWGFORHlkencr?=
 =?utf-8?B?RlU0SUVEYnZrZXZyNVJoNy9pbUh1S3k5ZmhNRXBFNWtsdTdmQURMSlIxbmZq?=
 =?utf-8?B?cDhDMkdrYlphRHNFaG5QdGZrTG9ET0NqSGlOZkRMR05NeTQ2bmdpYUQ1dUo1?=
 =?utf-8?B?K0Z5RnZzR3UyY05RYko3TzBiM1JWTVNqVmRFVmZCMnoxVkgvZ20wcVgwRVRB?=
 =?utf-8?B?ZVdReW9YWHFTd3JQcXRNUlplZXlxeDU0WXNORmN1R1I4cEJqSTRIRDlUL1Z4?=
 =?utf-8?B?NHB5R20zZWtLNFNhaHljQnI3aktBSWh5enNFU3NncDJka2wwU1k0SmpJTCtx?=
 =?utf-8?B?ZDFRTGFnb0xpdHBXWTRvS001eTJSaHpWeGg2eVY2cG43QTVwSCtKWVlrcEV5?=
 =?utf-8?B?NzA2dUc4eVpOQWdyUkpvN3dLVzhCcWErV2RWNkdZbFBDeDB6ZHFrNEVtc0dx?=
 =?utf-8?B?QkJjcGk1eHk2OCtLekNSUGY4TzU3M2JCdDNTQkJZOUJKYzJ3T2VNRFM5Tzlm?=
 =?utf-8?B?RWM0WFRPcDBMVlNpK3l4cVI0ZlBqT1NrT3ZoWWZ1dkdsV21qbEZlSjRvYmhi?=
 =?utf-8?B?cTNEZ2N4WDFIZ3JzdEJVMnNmM0ZVNmJBOHlyUEhPbWZ6WFEvZ2haM1hJb1ow?=
 =?utf-8?B?Z0kwRzNGM2FldHBvdHFSM1hHMEI2clhVdEdJWk5xMC9IU3VDUDhxZDBIbjlL?=
 =?utf-8?B?ZnNaK1psclNqOE0rSS9JVURrZXVrdXRxcUZrNHYwMlZvbEtPNjNISzlESi85?=
 =?utf-8?B?cFZHMGMyWE9pTXBCc2haNzFIYm14UnZ1SE9CZUF1aW5lc0lUdjhsZ1hqUlJv?=
 =?utf-8?B?SUFIc1pTVTZITXZHS2w2VzlEZkV2V040OVBpRmgyZmhkQ1hrNFFsRnV0WEwv?=
 =?utf-8?B?RGNiY2NCeGxlaEV1OXJIS3lsSjJJTzFYKzErdTh4YTN3WDBnOHVCblZ2VWg3?=
 =?utf-8?B?SWMrTHhSNzkweXZHU1BlemJqMlBweEsxakU5NmJkQ01mdVN1MXZTd3FIY3FE?=
 =?utf-8?B?UURZMnlyZVIvUzdOd1czVzNQUFBKWE1Ib1BSYmZFMFJEd2JvSmY5dU1CYXZt?=
 =?utf-8?B?QldwMTQ4Q3dyZVg5emRSVnBBOTh3UHZSLy8xMERpZUxDZTVFYjF5enlNeXFw?=
 =?utf-8?B?SDR2ZkVjSDl3TU9tSGhmRG9oQlpNdE5RWitlOWtWbEVKbzZsY2xTaVorZm9J?=
 =?utf-8?B?R1pNMW4xSUNIUHhGYmtoM2xXT1haYzQwdy90a2szY0lpeTNaM0NtTlRZN3Z3?=
 =?utf-8?B?eEtIRDM3OE5ISkFQanlMN0k3T2F4aHYzNWhiLzNYT252WnNMbjJuWXpLaHhM?=
 =?utf-8?B?elZ2MnBYL2NpNE82TEpjZXArU045Vk5FODR4RERodXp0eDlrS0pwWmZhNHhv?=
 =?utf-8?B?ekEwZ3B2djJPWURxSGlFb1ZER1pzTFRQUHYwQlg3WDlURVk1cjNrVzdNQm9S?=
 =?utf-8?B?MEROVVhiNXZLVG9nekhRNDQ1aHB3V3VudGtGUnduQlN0RDFmR1pZaHZiaGVw?=
 =?utf-8?B?RHl5dW1FaEhNYU1nc1ZKVVZqdndtdGdqUHdjUnIybWtWbEM5a1dBSEswSDg5?=
 =?utf-8?B?OWwvN0pGVjlGd2tSTEFiQ0Izd2NwYU1LUWJzWW1XSERLSEVhWUJoYkxra2cr?=
 =?utf-8?B?bnNObVNLek0welM1SE9QalRlUE5NSG53eXBQaGJOaEprUkVwVWRIODl1K3Fw?=
 =?utf-8?B?T1JpekZZU2VIWGdrbWRQV2hSanNPQlQ1QkZHSWhoN05xT2NQZ0p2TXJNTWJh?=
 =?utf-8?B?NjZEZEVhRG5oS3FCY1pmenBwaFlEZWk3d2tKeklYdmp1V2RROEdodlIyRmNL?=
 =?utf-8?B?OTJyWEhOTFFsK0FzR2RhZlFMaGdRZHBrMGI1MjJmelpUdVp6Z2k0UUhDM3Bh?=
 =?utf-8?B?eSt1aFdhYkFKK3NXcXlGSVVCb0xmSWRDWG5MVEs5TXY5blN6bnN2N1d3UjJ3?=
 =?utf-8?B?TDNjMXRaQTlzeUlGbjVQKzc5V3V0RXVvaUFITzdNSVR0ZWJ1MVg3a3FjY3lS?=
 =?utf-8?B?eDFGTTBXS0tuMFl0aHhuR3UreW45eWplZld4N0xwR21xV3Y4NGZGZi9XaE85?=
 =?utf-8?Q?t/1GSoKotORCNw/DHcKTnEKvY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21439ae0-e346-4e03-d07a-08dc787d9533
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:33:14.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lBFkPHkUTQp7SpKfaFEgsNyFqhRsLFf8wePUedfEsdPwLWswlR1sE7b8DZYkC76wPme/lo/e+UK2vNpeBAybA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7703
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE1heSAyMCwgMjAyNCA5OjM0IEFNDQo+IA0KPiBPbiA1LzE1LzI0IDQ6MzcgUE0sIFRpYW4s
IEtldmluIHdyb3RlOg0KPiA+PiArDQo+ID4+ICsJCWlvcGZfZ3JvdXBfcmVzcG9uc2UoZ3JvdXAs
IHJlc3BvbnNlLmNvZGUpOw0KPiA+IFBDSWUgc3BlYyBzdGF0ZXMgdGhhdCBhIHJlc3BvbnNlIGZh
aWx1cmUgZGlzYWJsZXMgdGhlIFBSSSBpbnRlcmZhY2UuIEZvciBTUi0NCj4gSU9WDQo+ID4gaXQn
ZCBiZSBkYW5nZXJvdXMgYWxsb3dpbmcgdXNlciB0byB0cmlnZ2VyIHN1Y2ggY29kZSB0byBWRiB0
byBjbG9zZSB0aGUNCj4gZW50aXJlDQo+ID4gc2hhcmVkIFBSSSBpbnRlcmZhY2UuDQo+ID4NCj4g
PiBKdXN0IGFub3RoZXIgZXhhbXBsZSBsYWNraW5nIG9mIGNvb3JkaW5hdGlvbiBmb3Igc2hhcmVk
IGNhcGFiaWxpdGllcw0KPiBiZXR3ZWVuDQo+ID4gUEYvVkYuIEJ1dCBleHBvc2luZyBzdWNoIGdh
cCB0byB1c2Vyc3BhY2UgbWFrZXMgaXQgd29yc2UuDQo+IA0KPiBZZXMuIFlvdSBhcmUgcmlnaHQu
DQo+IA0KPiA+DQo+ID4gSSBndWVzcyB3ZSBkb24ndCB3YW50IHRvIG1ha2UgdGhpcyB3b3JrIGRl
cGVuZGluZyBvbiB0aGF0IGNsZWFudXAuIFRoZQ0KPiA+IG1pbmltYWwgY29ycmVjdCB0aGluZyBp
cyB0byBkaXNhbGxvdyBhdHRhY2hpbmcgVkYgdG8gYSBmYXVsdC1jYXBhYmxlIGh3cHQNCj4gPiB3
aXRoIGEgbm90ZSBoZXJlIHRoYXQgb25jZSB3ZSB0dXJuIG9uIHN1cHBvcnQgZm9yIFZGIHRoZSBy
ZXNwb25zZSBmYWlsdXJlDQo+ID4gY29kZSBzaG91bGQgbm90IGJlIGZvcndhcmRlZCB0byB0aGUg
aGFyZHdhcmUuIEluc3RlYWQgaXQncyBhbiBpbmRpY2F0aW9uDQo+ID4gdGhhdCB0aGUgdXNlciBj
YW5ub3Qgc2VydmUgbW9yZSByZXF1ZXN0cyBhbmQgc3VjaCBzaXR1YXRpb24gd2FpdHMgZm9yDQo+
ID4gYSB2UFJJIHJlc2V0IHRvIHJlY292ZXIuDQo+IA0KPiBJcyBpdCB0aGUgc2FtZSB0aGluZyB0
byBkaXNhbGxvdyBQUkkgZm9yIFZGIGluIElPTU1VRkQ/DQo+IA0KDQp5ZXMNCg==
