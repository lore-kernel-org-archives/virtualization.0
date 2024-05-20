Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C5F101C4
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176401; cv=fail; b=cI+poWO+lV/tFUOZU/w2YD+/JpScRkb3rtzBlyGq/BCI0EAlrW58iH1kFwjokiN7rhNni+KNCHXLOupPKhM0hg3PK5UATa0UD82CTS5aqlCKK3N/027qcArLDAIOqjD3u3qafZv9WYzK37jWpBpBE8mHCjrlQITcMKBfQI5/dpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176401; c=relaxed/simple;
	bh=W/U22nrbRd82ipcnXp4uA7MS9sjljTbyIJA+bRrRcG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K9ivLuj5JPgVeVlx3jryG5XATPBFVIMVNALflGM8um/O5ozx/P7j9+UgOv+Kpo8cfksVAk6u7f+WQhBpVf5FFyOfRrhdyexTYPZJ7xQX72M7NUqM4/tIuV632hlEJkCw7ltFopFnyeRW6Lm7pDpQ04FJFHGoRIFIBz/bWxBRAbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajt6+5AI; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajt6+5AI"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0468D408B6
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZsYvttBwEGqA for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 03:39:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6A443400F2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A443400F2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ajt6+5AI
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A443400F2
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716176398; x=1747712398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W/U22nrbRd82ipcnXp4uA7MS9sjljTbyIJA+bRrRcG8=;
  b=ajt6+5AInM/ygSVApRl93CG8ThThQi+34kJCibu0QnsUlbqnurMNiC1E
   qfsCO1Rpx30eQzWc45RvOjBwievS7TEE7y/93T3KNwUQisQaFHCD96r3M
   4CCVQCOd5fyhvJIeYIpMGJQCz1Le+Fh3grSNcJyYsMLVWmj/JMotbT16j
   wHsqa0VV5OpKYkcdqJY4Yw3L8hS2x0f35WNReV3vEEk9jdH9Yzaomem/M
   ygdVmpXdqKBttF9qhirAx5ZMoTxQDH6kLPwvd5gctnHKKmhda9+oC5Ubh
   e1sI7RhyNMrMI6Cn1BoNU6gDenOpkRWkzCUrTx7nBtm/chtT/0P0th3rx
   A==;
X-CSE-ConnectionGUID: 9Gl3nRKsRQ+Gqv6xn1awzw==
X-CSE-MsgGUID: Ph7YttpdSXmeMCKuB5/BXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12408379"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12408379"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:39:57 -0700
X-CSE-ConnectionGUID: I2tWc3qBTHujhz2cgbDiFw==
X-CSE-MsgGUID: wJWxuot3SIWPm6yyajd1dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32413284"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 20:39:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:39:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:39:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 20:39:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 20:39:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7Y0kaoA/HQ/PNhn6zVmfVdGJglyGb9JvMsjXfwPfRXT0Mz2LmcNCd/jJhzdh0tauL4aaOl3F0yQY/R9YY5p5p4484BD4FJxBziV+LrNing+5n+gl3SAph0LqVmJ0qpvLT/O3BuxFXwGwgLwPAL5duPw9DJXfhUvjzOIDomn6yGXVt3WJhhTC7KCUvD0gZ7gJ48Saz03XSmEXN9MxiGV1EBdV10B/3JgCVKq7G7LPZ9eFvqA5+MJuPDy5RxgYLUxgK6ye38wqLCj1Fy/vvtqJNkReKhYXcA44bOqTsF+iGGp0c9cae0NqxYresLUD+C2JPZQtJu1sewyBVnZTbxxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/U22nrbRd82ipcnXp4uA7MS9sjljTbyIJA+bRrRcG8=;
 b=cOipsvh6DIP7mCPFYz5Kfw9UoIufuay8miBUFO6uEVFrx//b5gwYxc6bfZ7HasGftxd3I90kG0aOAxnw79yoqMd7YiZWZlpOnsoNoES3m6FkrMQirVHaGuPL8jRK/dKKGbErFu5Dehj/V7QVrF6pXJEE72PAM+8CY9XfDGhRDVMJ4CRiNwoOhnEr92iguWSew/gzJGTgoT/V+RuX3e5rZs6HE/j/Y9449rm8Pu46S/zNCUoZ1wHvG3edYoTepgKWEgjjrpr2IUTGRlFGuwpMsMnajufYrnw41mNQZ3jpaN+rpNco1398zce3rmBa2nvStHJBtXgrxfKZbk/MJrBKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 03:39:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:39:54 +0000
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
Subject: RE: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Topic: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Index: AQHamw8P/6/4oit4lU2Ra006NwpZoLGYE2jAgAduk4CAABV6kA==
Date: Mon, 20 May 2024 03:39:54 +0000
Message-ID: <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
In-Reply-To: <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4674:EE_
x-ms-office365-filtering-correlation-id: e67c3c64-01d1-4c08-34cc-08dc787e8326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?MUh1VzZaNzJOcU1vbXdMcnl5R0VBcFpBaUFhNHJ3aHZyUzk2UDgxVFM5Z3cx?=
 =?utf-8?B?Y0FadXN2YjlmbURsYTdlSStVMFhkbXVuWktZRGpWNm9zZllxTlFVZEt5OVp4?=
 =?utf-8?B?eUluMDFOUGFJeU8zdStHWlVrU1FyYi9FSWlIa080RDJkbVhVZWZuVTh2NzVQ?=
 =?utf-8?B?Q0d5eXYvNFJLOHFGS1czeVlSenhVeTVHZC9xbEdQelNQZUNzVTZUdXk5UEtI?=
 =?utf-8?B?V0MxQjlUTExaaDVYUTJFT3dxMkZ3VHUxZ3d0VDBCdkY2MmpMRHlFMUpIMVhI?=
 =?utf-8?B?ZGMzcERJVkNYMmFRTVlmcHdzT3VLM2dZZWpHVDJTR2RKYmoyMmtBWXJ2dzhS?=
 =?utf-8?B?b1BXNktkT2xkd3F4dW1rWG1LbWIycTBicWxEekNmQVI4dzdDbmk1OFdZR3JK?=
 =?utf-8?B?QlpyNSt6Y1A5aDlEMUJnbkdDY0pEODdhVWVDRDNWTlJiZE1VMEE2U1dmNEQy?=
 =?utf-8?B?N2JjeUFvdGFNeVYwckJycUZycFdxN2w4dzB0dWF0TWdZNDl0V0MybnNVNGp4?=
 =?utf-8?B?MEVseWRZazBuZEd6ODdkSDJlNHY3bnlGNjZnK3Q3MGxtV0QzL2V3RzlTQkJK?=
 =?utf-8?B?T2VEclduTnFJb2RRWWdBbjFnTmkrNVBvcXRYSnZMN3RBeS9GR2ZMdjBvN0Vk?=
 =?utf-8?B?VFZOdG1vT3VwWFZrS2hvcXJlNUFjQU5JQ0J5SDhybUx3ZzhOTExzTGlEQnI2?=
 =?utf-8?B?TXBlYndLVUNDQVBFeTZtbXlCYlFJQXpDOXlmQmRGcVBpWUg3Q0JkdkcxdGVP?=
 =?utf-8?B?bGJ2aUNqNkM4ajJPS2poeUFzRzh3VzRpYjU5RTlYQ0dBb2ExN0tpRjkwUjgz?=
 =?utf-8?B?eWUxWXdyRk9xNkd6R1g2RnZEZmc2Uk5sTHplRWxrcHljaDBLSjU3UnpXenI1?=
 =?utf-8?B?WnFaQ3NVdlBRb2lOYWloeVZtWGJpQ1ZHNTFpU3NmOVhremRZQWw2Nk5aV01N?=
 =?utf-8?B?Tjg4RVRRdkpJTWQ3UFIzTHkwTEs2V1hGY0xNdnp3T3RIOU5SSDR2aVN4VTBN?=
 =?utf-8?B?aERFNDErQ3pPZXRPUHYxYytZUVF0eWYzRG5HckdpTCtqWDZieVl3SWV6V0Mv?=
 =?utf-8?B?NzZNeWdQTnhLN21WNzRKVldFLzB4ZzlqdWZzYVltOFpxOHdSYnoyNTkzTUcz?=
 =?utf-8?B?U28vSy9yR2tkQnk0UGswbVhGcDJ4Z1ZHWUtkaVlDS3d6NUJGcjRXUnEwbTdh?=
 =?utf-8?B?TXEwQ3hlbllRa0FqdkcyOVJjdTBhenh0RGR6MEtCRkduK0ZMQUN0aVRiVDN5?=
 =?utf-8?B?aXM1Q1dGN284c2M3ZVBxK0l5OTlSZS92VCtDbmVRSDAzWXBpQkJsbEIwb3FK?=
 =?utf-8?B?T0VBdVhIeDRCemdsUkhkbGZZMjB2a2V4QjlvTy9vMlN2ZkRNU0tIR1lIMVVs?=
 =?utf-8?B?VEFlOG5WcGxjQXFSYS8xQmwrQm0xK2ttRkRtS0pVbjV6N280R3pmd3ByNzYy?=
 =?utf-8?B?Yis0NWxlUERVbFQ0cXJ5d3Uvc0ZDTm93ckZjTWtGZER3KzhTNzdSL1VZMjZn?=
 =?utf-8?B?Sm9GQVA0YklEWk1tZE5iSzJlRmRLVjJqdHpVYXFSUzAxZXBhbWNEb0JvMUsz?=
 =?utf-8?B?YUFyQ2tKK2pNb0dmQWVEUnBNMlhkNG9YcHJZekVUUW43WVRsb1FIbVY5eTZO?=
 =?utf-8?B?Y1k1WVFiTnJYYjR1Z0d2bUVJNlk3MDFNYW9KWFpvdVhSZGlxWFA1c2kvc2Y5?=
 =?utf-8?B?NEhmTCt2bzJaNFpGYTBMa2hGQ3VyWWlhSzk1MkRrZCszUW55WnQ4THBaelBV?=
 =?utf-8?B?b0xaUlJzTDR0bjAxQ0RHZ2YvMUxqaUowQmk2cFoxd1R1bDg4aUlSZEwyWHVp?=
 =?utf-8?B?Qk9PZlY0TU1ZYVJhUUlMQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm1Iamg3RHNmTnR2N1lITm53TENZc3ByMDVHQ3VFSFF3SmpLY1lnOU40Wm96?=
 =?utf-8?B?ZUtxVzYxZnlQVUM2aHJMZFhaNTFncWFXL3RQbVd1WWkvVDZ4SFZyYVAxdDQy?=
 =?utf-8?B?UVltS3hpdkxnOEpwWHRDL25Ia3M3YTZic3pNUEkyd3BtZjJZMWI2ZFVvZ1VX?=
 =?utf-8?B?YlBuWmwvUHB1S2VqMXNMUEkvVjRaUHg4TWZzOWMvV2dnZVh6YTFiWkhLNkVy?=
 =?utf-8?B?QW52ZGxzbllFWWxWdEFybTVjYkYybGljbEVjaEhON013VUhVMGdhek1mSGxi?=
 =?utf-8?B?N2J0dGI0MWRMdk9UZ3dlbmlmOFNvRGRCbFdTVWhoRHpJWGRBZ3ZzOUxiN01Q?=
 =?utf-8?B?Q3RhZ0NMd0JWL0xYQkdrd1hIeGxzcnMyMVhRZ2tUdHA1WU1hV3B1VW9zQ25u?=
 =?utf-8?B?aEFzbUpxRFBCSTVndFZpZ2dNeU1RcFp6SWJvNkFmRUQ1TVdiTnNWMHVIR2pS?=
 =?utf-8?B?VmF0eXFTa0Q2d2JnVXZlOS8rVWpjc1YzZ2FyUkNxUWVLbDVZYi9YOFMraUo3?=
 =?utf-8?B?ZlZaempwY2JmemI1aElRRXNBN2o2dTJZUndUTVlVMDRRTmphTFhFVDJMUXVH?=
 =?utf-8?B?c1NJQjk0bWdVOGxITitTM0VjSUNXOUxoNEVrWks5bEFQOUttd0R2Q2NUcm1N?=
 =?utf-8?B?RDA1dFZCSmtaQ212RWxVS2Yydk5uTEZSM2QxNmNYRGYzN1g4Ky90WXI5eHk1?=
 =?utf-8?B?OVA1amhSemdGRVJWK1dXRGRtMTJGM3l2UytGV21RYlFnVnlWamtsYUc3cDJD?=
 =?utf-8?B?WE81R1lKMng1aG1DeFNaQ25lYkdwR1M0V0VLT2hnckx3UVQ4WnJzRDQwOGJB?=
 =?utf-8?B?VEt0VG1adWpSVlZBUHpVQm1TTVpIRnpTU1JidWdKZVRwS3BBN1pNbys1SnJK?=
 =?utf-8?B?L2p3b2QzanEzWHB5Z0hFWHhoWFFVT2tQN0g3SWc0eXZ4eU1YOTR1TXpEc1d2?=
 =?utf-8?B?UnhibjdORENZS2dFZVB6QklLaFpWUlZXWUpTYmNEQ0dTMko2QlNuRGVhUllQ?=
 =?utf-8?B?OGp6OG5ZSXpVM2ZFZUEySlBaeGhRb0ZxNWZXdkc1dEk0TFhlTlVqbU5YYW5B?=
 =?utf-8?B?dW0wL3BSVDFpQzRBL2JYNVVSalYzeG84Z1djKzFDdXlaS1F2UkhNd3JkTWo4?=
 =?utf-8?B?bDdpbnFNanBmOExFTi8rWTRMa3dMOTJSSXVKOUdPZHJlQXNQUVlxYnM4bTBp?=
 =?utf-8?B?bHBHRHZQSFBTLzlJdEtqYVFGekZVQzlIam1wTHFYdUE1TkNCYzRWYVZOMjk1?=
 =?utf-8?B?SGlWS05EL28wSnplQ1JsQWR2NEI0cVhjWmtJek81V2V4bXVnK3pSUC9NN1d4?=
 =?utf-8?B?bUZTYnZ5RjJlM3ZYakRMdWtad281bUNnd1pOZnhKbXgzU1ExcFdFMkdDSkxM?=
 =?utf-8?B?ZCs2K016WUdubmM5Vlg2blloY3hueml3Wng4WldxamsveXZnQlZJT2NVYjFP?=
 =?utf-8?B?RmtNNkNsQlJZSmROQ3BIWUVhZS9NRmVIMytsaGdNZlVOaDRJZC9rRHhkUWw0?=
 =?utf-8?B?V3dNREw0LzBSWko1MzZLMDh0RVpBU3YxQVRpSnE5bjBHR0VITU82eUtoUHR1?=
 =?utf-8?B?S3RpSGg4NG0xRjYzdHUwbG41MkJ1anRERG4yYzB2RnpXbFMvY0Vkelc3UW41?=
 =?utf-8?B?NGJURUhTQXZYWVNicEJQdVZvYUlYRDNrcXJvYXdtU1BmeGNUbnpIcmNUbTJo?=
 =?utf-8?B?Z2ZJTzZyTWNTcU5FZVowcnh6czhFY09EY0NBNHJKTFErYW83Q0tWUXRFdSty?=
 =?utf-8?B?SVJRMGo2clEveXBxc0xsOFB4eG5GdmNYdmsyQ2FZemJEc0tVTVhxSzhCY3hi?=
 =?utf-8?B?VFVBeHNRYW5lcEU0US9aNEVCMmp1UFFwVWx1aTd0MmZYSGk2cUtrMmNhTE1s?=
 =?utf-8?B?RHhBcjVTcHp5VXdDNSthSUlGNkFCdXVzdFlUcGRydnhuWnc5T2NXZGlkK3Nk?=
 =?utf-8?B?QmhNNUJzNkN2bVlra3NZaXRpUmFRdDN6b1Q2QkhZbTFjZkg1NWwyZm9tZ21n?=
 =?utf-8?B?RDdwRVdyWTYrNFpwekpGdlA5VzJ5M3dXaE1CQm00cEhXTnFrMURrSWhtQmUz?=
 =?utf-8?B?MnRCMFBkMnFNM25IczJ6c3F2cWlLTlh5SXVsM3krSEtXTDcvdjdjT21VMkpz?=
 =?utf-8?Q?oL4bRMiXwkxpkaxLEM/HqppSP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e67c3c64-01d1-4c08-34cc-08dc787e8326
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:39:54.0673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9w/rrsI/umXtt4u2V0H4cHg81uR8gnddOvq6394on1GFvE/6m7GMQWIkqjYTm6H8adoq7mw9MI8N74fC9OmTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE1heSAyMCwgMjAyNCAxMDoxOSBBTQ0KPiANCj4gT24gNS8xNS8yNCA0OjUwIFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgQXByaWwgMzAsIDIwMjQgMTA6NTcgUE0NCj4gPj4N
Cj4gPj4gQEAgLTMwOCw2ICszMTQsMTkgQEAgaW50IGlvbW11ZmRfaHdwdF9hbGxvYyhzdHJ1Y3Qg
aW9tbXVmZF91Y21kDQo+ID4+ICp1Y21kKQ0KPiA+PiAgIAkJZ290byBvdXRfcHV0X3B0Ow0KPiA+
PiAgIAl9DQo+ID4+DQo+ID4+ICsJaWYgKGNtZC0+ZmxhZ3MgJiBJT01NVV9IV1BUX0ZBVUxUX0lE
X1ZBTElEKSB7DQo+ID4+ICsJCXN0cnVjdCBpb21tdWZkX2ZhdWx0ICpmYXVsdDsNCj4gPj4gKw0K
PiA+PiArCQlmYXVsdCA9IGlvbW11ZmRfZ2V0X2ZhdWx0KHVjbWQsIGNtZC0+ZmF1bHRfaWQpOw0K
PiA+PiArCQlpZiAoSVNfRVJSKGZhdWx0KSkgew0KPiA+PiArCQkJcmMgPSBQVFJfRVJSKGZhdWx0
KTsNCj4gPj4gKwkJCWdvdG8gb3V0X2h3cHQ7DQo+ID4+ICsJCX0NCj4gPj4gKwkJaHdwdC0+ZmF1
bHQgPSBmYXVsdDsNCj4gPj4gKwkJaHdwdC0+ZG9tYWluLT5pb3BmX2hhbmRsZXIgPSBpb21tdWZk
X2ZhdWx0X2lvcGZfaGFuZGxlcjsNCj4gPj4gKwkJaHdwdC0+ZG9tYWluLT5mYXVsdF9kYXRhID0g
aHdwdDsNCj4gPj4gKwl9DQo+ID4NCj4gPiB0aGlzIGlzIG5lc3Rpbmcgc3BlY2lmaWMuIHdoeSBu
b3QgbW92aW5nIGl0IHRvIHRoZSBuZXN0ZWRfYWxsb2MoKT8NCj4gDQo+IE5lc3RpbmcgaXMgY3Vy
cmVudGx5IGEgdXNlIGNhc2UgZm9yIHVzZXJzcGFjZSBJL08gcGFnZSBmYXVsdHMsIGJ1dCB0aGlz
DQo+IGRlc2lnbiBzaG91bGQgYmUgZ2VuZXJhbCBlbm91Z2ggdG8gc3VwcG9ydCBvdGhlciBzY2Vu
YXJpb3MgYXMgd2VsbC4NCj4gDQoNCkRvIHdlIGFsbG93IHVzZXIgcGFnZSB0YWJsZSB3L28gbmVz
dGluZz8NCg0KV2hhdCB3b3VsZCBiZSBhIHNjZW5hcmlvIGluIHdoaWNoIHRoZSB1c2VyIGRvZXNu
J3QgbWFuYWdlIHRoZQ0KcGFnZSB0YWJsZSBidXQgc3RpbGwgd2FudCB0byBoYW5kbGUgdGhlIEkv
TyBwYWdlIGZhdWx0PyBUaGUgZmF1bHQNCnNob3VsZCBhbHdheXMgYmUgZGVsaXZlcmVkIHRvIHRo
ZSBvd25lciBtYW5hZ2luZyB0aGUgcGFnZSB0YWJsZS4uLg0K
