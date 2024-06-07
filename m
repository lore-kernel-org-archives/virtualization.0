Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C615B150
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753131; cv=fail; b=KVvZl4/psaRCwNV5xuKtNpE8gfNHMA29JFcRh5Ix5yOOrzkit8xV9vxVNQNlqfFMLUQM1nVcZBmn92JYWGoqAoCxlU/6f424XPsOz/nqBjRix+EgFqAwD0KEhTIOajx8iJcXjq8ygbUgNnOIKKPo9k9qLLt5PzkiOftinOw8+NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753131; c=relaxed/simple;
	bh=f29GJ5Pvk8DUCwaS+H3QWGRr8TGlQr6Po1hw79Y9SWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sMxYmVTLAUlTxOryRsJ/Bu8VpwJ8jIzLxlix/szqCzAfwfw5HMvYzL6s2S1Fk1QG7vomPXhMzhqCgH6DK1bW1gbOxo13Jh5xbKvvrJO1R2g1YQgXpudli0Z7LjbyVJ8Z5gqeNsm4jX4i3RFf+PAO35G8aqhb0U5oxy5JbGCJ/iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4kwWsl2; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4kwWsl2"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9820E40B09
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:38:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id usuyJ0pRgeBO for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jun 2024 09:38:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 88A8640AFE
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88A8640AFE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M4kwWsl2
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 88A8640AFE
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717753129; x=1749289129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f29GJ5Pvk8DUCwaS+H3QWGRr8TGlQr6Po1hw79Y9SWo=;
  b=M4kwWsl2HtZPbVW5Ejc/EnhrzmMFABwHAopcSKznSbY7ZofHR4cgO92m
   pCdBkGKU7Fn2jqQIprgKIyCRhTVrwesXpmhijEp5s3DQoztfwN8BDPuf9
   taGzzABrcXPUm1k9Es8/nKpk100OPC3UJzkhxm0ze3KP7WU8+nhbc85ZU
   h9JgZU0yeRR5RvjEgQvL0Lti6EXqiFZbxbpCDr9DWdF80noEA3Qyr4LLy
   cP1FiERa/juvtKoFgW4CQMWruLrmvNqocfuJef5vCzcSaSB7JEimvW4Ac
   K8FNIpB6QXgiXk/Gpc+SZl7yY23pP2vupe9fYTFgX8Bif/z1kLS4zT/Y9
   w==;
X-CSE-ConnectionGUID: 62M5zHs1ScGjiQRq1yFo8Q==
X-CSE-MsgGUID: ljhN0/aGTWOP+Xxl9SVfMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14600124"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14600124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 02:38:48 -0700
X-CSE-ConnectionGUID: y+itMNt9Q8egyrby4ZGBhQ==
X-CSE-MsgGUID: x9F5i0RRQAGfYcESZqumSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38123637"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 02:38:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:38:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 02:38:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 02:38:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcaeze9F9B3w9CJhwOTEcXJV5DZMilDf5f5mtBaUU+UoJK1eqZqDQcsND+jYYPHAIjlEx0dniD/FRmBoY7rLlL7teoiGJO2FDoHTXWTTY4/kAtfsznKyY0Ula29tuA5AIlnu9ga5hvEytFPivdttooZQ/Wq+mB47GYiEbsdV873IpdQ3BPP90LVLxFCKE9w3Fm3C/NvL+9ZhwywLh7hytG/LpCYujYH7FIk2orXuwiLryeV5MKKLlWNCN1nYCi1W6hIbsLT2fiO37hK/gnElSHFm/XNkUrgY6yZYoQeHivAFOp6a93Jb00aabP7JOp8atXnnbEr6bYFWjBRn6IpM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f29GJ5Pvk8DUCwaS+H3QWGRr8TGlQr6Po1hw79Y9SWo=;
 b=IN1oDBSm3DBdu1bPgv43NhAS/58kf6CxKSQ4DObcJACapxGdSaorpMSpLbDuiXjUzcbD4GEpHpROXaEdJUXrsO0y7BhyaIutZ/9VwR0TJxdwFvi2y+em7s9GZh9MK+5kqGGPfFdanYRAFv3RODkcwYcHS+YgtXKf1W8Rt+oI6A9skyOMticy7Y9idcNvbiUqEs24yDR/K0oEpmwHPP/7SWv6H4SGp1V/GziBsjGuxZ4i8DBeym++McNKSdbaDIZaBKmrVzUIzYUcSwKKdUIDvjsdG/PA/KxKbGknEnUXZb5lzEfPTMQ4ZRzHxxqQUReUe9JSy8Hd0EQXBX8Dt8dyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5929.namprd11.prod.outlook.com (2603:10b6:303:194::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 09:38:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 09:38:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Thread-Topic: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Thread-Index: AQHar+txjixJkLb+zkCCruAoIX1UvbG45C5wgAFxOoCAAcbdIA==
Date: Fri, 7 Jun 2024 09:38:38 +0000
Message-ID: <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
In-Reply-To: <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5929:EE_
x-ms-office365-filtering-correlation-id: 3e8313ae-493e-41d9-d6a0-08dc86d59be0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?WDdpdGt1ZkUvT09aVDhveUh0YUxNUGgreUZKRFZFR3ZUcVozdVZxaDVjSHNY?=
 =?utf-8?B?enZhUWVKMFVZSlVDNFkvWk5FVStNSmdUVmNFdnNBd0kyVWN0UDUwK3ZteER3?=
 =?utf-8?B?ZGZrbGJ2OEpBZEhRS0NwZ2N4U1RDQVlVdGRJR1F0bjM4aEhidVExQksxN2N5?=
 =?utf-8?B?T3BROEYxeGJNMk5xLyt1Nk5GS2lUaWx6bEV5SlN5WFZYUFA1T3JvT2FnRGRj?=
 =?utf-8?B?Tm93WnA4V09MUlRxOGRTY3B0N08xRFdKUVpFaUJpcncycHd6dXNRMVYzaEp4?=
 =?utf-8?B?WlZSdmcyWk5MSzVDUVoybHJGaElHYkNqb3g0RmI2U09Qc0FzZHJvRUVDYkF3?=
 =?utf-8?B?VjloNkhYRGVUWVhNaEtIakpDQXNhNzJjaW45cWE4UU04UlVjd3NMcCtHeGZN?=
 =?utf-8?B?NVowbkJ4clU2eGljTkt0cXhwdHdhRWZNcVNmL2NEanNjNzcwV2hLZUlJT25h?=
 =?utf-8?B?WGpnTU9HaDlZaXBXR3RJZDdxU0xYZkVaRWVJbnZvMmhyem8rY09jYklDRk40?=
 =?utf-8?B?NFZrMnYrcDFEWGp5SVR2aklWSWptcjlzTktoR09rekpJVldhcFlZcE5aNDhv?=
 =?utf-8?B?T2l1R1NXbU9xM0VKSzV4MHFSN3FQN25RTDhzOHpoanBqcExZWW82eEVJRm5K?=
 =?utf-8?B?ZUkyNmd0NHZOdE9Gek81R3dlR0RwMmZXY0gwSFBkUGlBYnNxQ0hBN2I4UUdD?=
 =?utf-8?B?MmlBVVRDd0s3VXlUaUVmVkVaNVpNZE0za215eFhjS2NaOEdZQkhiYnB2QXJC?=
 =?utf-8?B?OFU1ZEh3dkxCa1gzemlaOXJtZVNaTnRHKzB0SWdhYloxR1VGQVVIV1J5dEVz?=
 =?utf-8?B?aElKUjFzZHhCQUtGMHJncjZOYVRZdWsyaHA2ZnFxMVlTcFN2NzZzcFVNWWU1?=
 =?utf-8?B?aFJsVmNKZjJINS90SDdHdU5iRmNZU0lUMCtobG01QUd6cW9OU3lzSTAvV0N4?=
 =?utf-8?B?S3E0U0oyblMzU1d0RW1FRktoVjFscTB5ZHZkTExpWHB6dnJ4bnFlb3ViRVYz?=
 =?utf-8?B?R1pJd3NhTGdGWklnbDFLTTdUNEJiN25VT2Nrb2VGekJUdm05R2kweDZ5bytR?=
 =?utf-8?B?K3lQd01Tekl6NE9rOEV4clpadm9hTjJQQUczbkFmMXorSUpoS0JRMVdGYlV4?=
 =?utf-8?B?c2EyQks0eTdLSXgrOUZjVnBRWWlGYk41NDRFMUQveUpGOTBXWEdncWQrc2lK?=
 =?utf-8?B?RmVhc2NKK2RRWjBiV0tOMk50c0xVUnhCTmR5WGdvbUVocmxib1ZGQkJXNmZ2?=
 =?utf-8?B?ekVsZFBvV2tUajl6c2RsKyt1S0V2Wk1zcmxiQTdWZi9naC9iNVVoYXlCelNI?=
 =?utf-8?B?NGF6M3FPS3dkSDBuK3F6aFg3L1pyUmMwaG9HYXpoNTVjN2FRdnJjSVFnSXda?=
 =?utf-8?B?L3paeWNia2wyUHZEVEZ4RFhBYTNLYml2ZmV3TDlLMWxXWjRMaDZ4YlRIclpC?=
 =?utf-8?B?OTdNbHk0Y3RDb2toRjZlMlF1SmZqMVk0SVZJUDczVnhhMzhXL3c1alR4U2N6?=
 =?utf-8?B?eERYcUQrQTlvVXE1NWlqU3gxMzdOMzkwb2FFQVVyYUUrcWxNR1VFdXF2Wnkr?=
 =?utf-8?B?ZStkNnYwVCswSjJIU0pNZ3BzT2ZvY2lPUmpyTXF2czd4dUlFQ1E5Q0oxOXAx?=
 =?utf-8?B?eVV6YjVnc0ZsWWR6RFRMeEJ3YUo4bnVxUThHdys4SVdJUjlPdVBIRzJsYkcw?=
 =?utf-8?B?QWtnbXlHTlYwVmlUR2JYU3c2VXNVelFpZllTVDFpcW5ONEdQUTNCVFlwN20r?=
 =?utf-8?B?TFdFdDJIbStzamJCeFByek5BQnhYWU9oek8zRnBOVXJLcE9PUmJKQ0Z5a2Ny?=
 =?utf-8?B?NXZtajc0Y3dBZjhjcVBvSGZtNUJDZTFiWU1aN3N1TmtRS1lCVjZRNXRJcVVM?=
 =?utf-8?Q?hdpHFH8jaX9VR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VThZelZQdmxWdDdIeWxuOGR5NTZjZU9RbEdjbU9pdXdza3ZYWHhUOUhsdm1F?=
 =?utf-8?B?TDdReENzMXI2V1BRRXB3bEtqZEFYUFJHTzRmblpXckg1TGw4LzBGMGZ6ZlAz?=
 =?utf-8?B?Z3YxaFl5WXd4cUFyV3JXd2NwTGpXWGw2bCtHalUrcHNiYityV2NEUHNVQ09Y?=
 =?utf-8?B?TUx3a0lhNHVlWW9CNTRYMkNtMzdvZXpjS3AwbWNlUnVsYzMxelNWbjVyY2Zp?=
 =?utf-8?B?eW1nUlV5Y2JWeS83bEFTL0tydHRabm80SEpXaGJwNmlRQmZ6V05WdExBdjZK?=
 =?utf-8?B?YlpTOWtRUGtLdDBCekVKdTE4RFJlVG5aVlg3Z3UvZ29OWXFMdnlwVUFYZjV4?=
 =?utf-8?B?RDJscmoyT3dzSlVQYjVTNHRkTll4TmtjRCtuaGtFRkhBMytFb2FURUFxbHcv?=
 =?utf-8?B?OEptYjY1OVBieFdqY3R2TVZRQlpuVWlTWkdDckRib3g0L0Z6SEoxRXJDSE8z?=
 =?utf-8?B?Z1NybEJNVjJSL21oYmtyenRZbHF3VEY2SHRPbVRhbFVQVDArY1htMWpjcFo1?=
 =?utf-8?B?aW1MZ2NVbWlKZ1EvQ0pIeFNkQWtuWVJpWE0wbEw2cG5oMW1LMnIrTmZiSDZK?=
 =?utf-8?B?a2FidXhtT1QwTHU3cnN6azFQWnVoT3JFVDh5cE9ZYzB1UXlKT0w3WTBRQUxG?=
 =?utf-8?B?Vzl6K0ljQzk4U3Z6K2VEb2g2ZEMrQUNuUllFQ3d4eVpVYnNqYlRDOVpEZVpj?=
 =?utf-8?B?NVdGU1YrakdJUkl2OUpWRGdDbE5uVkl1K1FvUWJlcjFkcTNxL2NYOHA0L2Fk?=
 =?utf-8?B?dTM5N1dsS0lFZi9TS3lzdTBQRmVyZzB2ZmpYSXV4RDA0NkNpOVdrcEg5SzE4?=
 =?utf-8?B?TlJCSTVzZ1JZQXdQdVNOd2JoYkNtQlliUzg0ZU5VcWNsTEpsUldCNExYYno4?=
 =?utf-8?B?Y25ud2xrRU5yYmVpQ2EvUHFlMGtjMUlDblJFWklGdG1XUk4yWHVLWEtDdkhy?=
 =?utf-8?B?bnVMWDliMGZxUEhFMld6ZmticzJqSXcrZzBaMnFsdWlTclpDY3gzZmwwUUg2?=
 =?utf-8?B?cjdpMWF4d3JLOVN3SmlUQkp6Rkhtdjl3RW56UHJORkh5cEhQVmxwR1labzVs?=
 =?utf-8?B?aWxqL1RxZEkwSGhrQjArODI0TXJTSDl6eCtOaENFVnFYVCtTQldMeDlkK3dr?=
 =?utf-8?B?YTBXT1h3WmRUUXZCank3S1B3NmU0YmlsZXowZkI3SlVFSXBhZXErUGdKdExz?=
 =?utf-8?B?Y216M1BteWhwVW9xcnpRSmVZWkNVZjg1R0ViamtHRGhtQ3M1K1pIaGxTdmpU?=
 =?utf-8?B?c2ppNzMyMzJ6RXY3bkJ4QWRVNFNkeGpDaS9oU3gyQzRVQ0w5Qm5YNVFwR2Fw?=
 =?utf-8?B?RG5TN25hSHZEcGgvT2cwN2p5NW40MXdCem9ETU40c3VmYnF4Q1hsQmRieE9Y?=
 =?utf-8?B?MXVWUEk2ZUNRKzdRa1FFZkhCVEY5cmVHSHg4WHlxejQweUpIVzdURlJrdnEr?=
 =?utf-8?B?ZHRsVnRMRGNicUtIbWJjcDBLaU94M0paTGNETnRtRTY4WGw4alZxWDJvQmx6?=
 =?utf-8?B?Y2NZTDRReXRIQ2xSNHFkbzYrd2h2SStKUytjdXpaaTZWaUxrTjd6ZDFzOFpD?=
 =?utf-8?B?aGZud25YTzdQR3dNWDRxdXEzZFk1ZGZiemY1Q0ZBWmFHck1EbmJ1Rm5QVmlQ?=
 =?utf-8?B?ZGhDYU9hd3E4VER2WjdUZ3V6RWlZa1d1TEJBRmZlL3VqMEZnMHlRd3BuWGlr?=
 =?utf-8?B?V0Z1aGVnUHYxMXJlQ3BkYXFmc0gxdm5WbDliazFmejV3THgzVHh6S05kZGp0?=
 =?utf-8?B?ZU5WUEhHVVk0a280NVpHSGxRazdDRUFMU0VwajRqRWhySlJpck5QelZWcWpp?=
 =?utf-8?B?aEppd0hvYjhKWWIyNHdhRmF4SklRZUdkdlllZ2RTTmp1MXp3WGlYdEluejNt?=
 =?utf-8?B?djN2QVUxemJLWUtmQTF1T0xwaXI4TWpQVTdURXhBaU5KRE5VY1M1L0VWWnkr?=
 =?utf-8?B?TEN0V005LzJrTEYzTGlrWFNiWElDRDl0MlRqazlYUytsRlpYNnprQk5GOXNK?=
 =?utf-8?B?N3ZiN2ZCUnZKMmNLbFdvbjlCTE5qdjc3TERKOGM3bHBIZ2ZqdW81d2FzbCty?=
 =?utf-8?B?QzJVL1R2aG5tSThaQ2FJdlNTVkJoOHZBcmZIZ3NtMm1TTFdEVGNVb1EySnZP?=
 =?utf-8?Q?MtaAxnF1MbnCcyiwKJc2jQYLb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8313ae-493e-41d9-d6a0-08dc86d59be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 09:38:38.1027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7YLkPH7WDcxNE17iTke0DXW+bnbcMpMWGCpSktZrEObGtsir4U8X7BMftovGk6f07cQ4UV04VA96qfJtKFxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5929
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVuZSA2LCAyMDI0IDI6MjggUE0NCj4gDQo+IE9uIDYvNS8yNCA0OjI4IFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBNYXkgMjcsIDIwMjQgMTI6MDUgUE0NCj4gPj4NCj4g
Pj4gKw0KPiA+PiArLyoqDQo+ID4+ICsgKiBzdHJ1Y3QgaW9tbXVfaHdwdF9wYWdlX3Jlc3BvbnNl
IC0gSU9NTVUgcGFnZSBmYXVsdCByZXNwb25zZQ0KPiA+PiArICogQHNpemU6IHNpemVvZihzdHJ1
Y3QgaW9tbXVfaHdwdF9wYWdlX3Jlc3BvbnNlKQ0KPiA+PiArICogQGZsYWdzOiBNdXN0IGJlIHNl
dCB0byAwDQo+ID4+ICsgKiBAZGV2X2lkOiBkZXZpY2UgSUQgb2YgdGFyZ2V0IGRldmljZSBmb3Ig
dGhlIHJlc3BvbnNlDQo+ID4+ICsgKiBAcGFzaWQ6IFByb2Nlc3MgQWRkcmVzcyBTcGFjZSBJRA0K
PiA+PiArICogQGdycGlkOiBQYWdlIFJlcXVlc3QgR3JvdXAgSW5kZXgNCj4gPj4gKyAqIEBjb2Rl
OiBPbmUgb2YgcmVzcG9uc2UgY29kZSBpbiBlbnVtDQo+IGlvbW11ZmRfcGFnZV9yZXNwb25zZV9j
b2RlLg0KPiA+PiArICogQGNvb2tpZTogVGhlIGtlcm5lbC1tYW5hZ2VkIGNvb2tpZSByZXBvcnRl
ZCBpbiB0aGUgZmF1bHQgbWVzc2FnZS4NCj4gPj4gKyAqLw0KPiA+PiArc3RydWN0IGlvbW11X2h3
cHRfcGFnZV9yZXNwb25zZSB7DQo+ID4+ICsJX191MzIgc2l6ZTsNCj4gPj4gKwlfX3UzMiBmbGFn
czsNCj4gPj4gKwlfX3UzMiBkZXZfaWQ7DQo+ID4+ICsJX191MzIgcGFzaWQ7DQo+ID4+ICsJX191
MzIgZ3JwaWQ7DQo+ID4+ICsJX191MzIgY29kZTsNCj4gPj4gKwlfX3UzMiBjb29raWU7DQo+ID4+
ICsJX191MzIgcmVzZXJ2ZWQ7DQo+ID4+ICt9Ow0KPiA+DQo+ID4gd2l0aCB0aGUgcmVzcG9uc2Ug
cXVldWUgcGVyIGZhdWx0IG9iamVjdCB3ZSBkb24ndCBuZWVkIGFsbCBmaWVsZHMgaGVyZSwNCj4g
PiBlLmcuIGRldl9pZCwgcGFzaWQsIGV0Yy4gQ29va2llIGlzIHN1ZmZpY2llbnQuDQo+IA0KPiBJ
IHByZWZlciBub3QgdG8gbWVzcyB0aGUgZGVmaW5pdGlvbiBvZiB1c2VyIEFQSSBkYXRhIGFuZCB0
aGUga2VybmVsDQo+IGRyaXZlciBpbXBsZW1lbnRhdGlvbi4gVGhlIGtlcm5lbCBkcml2ZXIgbWF5
IGNoYW5nZSBpbiB0aGUgZnV0dXJlLCBidXQNCj4gdGhlIHVzZXIgQVBJIHdpbGwgcmVtYWluIHN0
YWJsZSBmb3IgYSBsb25nIHRpbWUuDQoNCnN1cmUgaXQgcmVtYWlucyBzdGFibGUgZm9yIHJlYXNv
bmFibGUgcmVhc29uLiBIZXJlIHdlIGRlZmluZWQgc29tZQ0KZmllbGRzIGJ1dCB0aGV5IGFyZSBl
dmVuIG5vdCB1c2VkIGFuZCBjaGVja2VkIGluIHRoZSBrZXJuZWwuIElNSE8gaXQNCnN1Z2dlc3Rz
IHJlZHVuZGFudCBkZWZpbml0aW9uLiBJZiB0aGVyZSBpcyB2YWx1ZSB0byBrZWVwIHRoZW0sIGRv
IHdlDQpuZWVkIHRvIGF0IGxlYXN0IHZlcmlmeSB0aGVtIHNhbWUgYXMgdGhlIGNvbXBsZXRpb24g
cmVjb3JkPw0KDQo+IA0KPiBJIGFtIG5ldXRyYWwgYWJvdXQgd2hldGhlciB3ZSBjb3VsZCByZW1v
dmUgYWJvdmUgZmllbGRzLCBidXQgSSBuZWVkIGFsbA0KPiBtYWludGFpbmVycyB0byBhZ3JlZSBv
biB0aGlzLCBnaXZlbiB0aGF0IHRoaXMgaGFzIHVuZGVyZ29uZSBmaXZlIHJvdW5kcw0KPiBvZiBy
ZXZpZXcuIDotKQ0KPiANCg0Kc3VyZSBsZXQncyBoZWFyIHRoZWlyIG9waW5pb25zLg0K
