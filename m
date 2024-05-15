Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518247F7F
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759016; cv=fail; b=XS2QINQaZlC0jlxvEpVTIoajtvGrhCYQLsc2eY4AoqgwW+ZRnAwF7iw26wlpRg4KBTCGQp0B2f73Nh7ZKXuuBw7Dn3yGaB3V15u1iaNkCqEOcJPv0JhkXYoytJjF8WniQMhBRSWRVld/0qQsVKf5Vcaur1aZguN9szcs5NYrs+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759016; c=relaxed/simple;
	bh=XL9UUDFoJe+KaX4MmvNB2/GDp5fsNVY8Lz3UXPNwUnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2slIJMLtrfmpIci40Jjj8HV0Hhzyfl8cVMo6KmV6QfyR8dMh+EbvGgAfzt4PSge7GX2rIPkx/1yQ8Koh80U7+ovh3RK6EI9ZCEWs8SjhP61jnZOuHS4dNV6RweEObWrlGMdP7YbJlN9j+XJ9+CE/VpE5i0eBIGRGvgJAN1Mwu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOofavcZ; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOofavcZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43A7841850
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id etbgAIadzWqg for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 07:43:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4B76A405E2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B76A405E2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QOofavcZ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B76A405E2
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715759014; x=1747295014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XL9UUDFoJe+KaX4MmvNB2/GDp5fsNVY8Lz3UXPNwUnw=;
  b=QOofavcZXcu2ssmS/5quc8TXgTX84y97NdoOhV/9hnlVkBZy5GTyFPdh
   ONoqoWq88YdvxjzU7HK1L6o3Dkpuynpgyge+OA+x4WPpBXuC1KkLrvfjO
   mKFsEVHi/DZkA9xodoI54XqfYf944ocFsFVpEuDFn4ZukE6VURrUIzx0R
   3Mom/OwaUuj2ev/v72+YffWU1HFIB6xpEDIhhg2mA6NS55vG+y2d9sDMr
   fAtspc9xneWCB/MOt64+xPDJaiqmfyxq3FtBhj2VlqYY8ifrvsQDzXAdF
   kXy8E7EXo14zlFqhVMo95S4LND8Z8pv4zG9h2/eOeMWJ8h0aitO1oDpoT
   Q==;
X-CSE-ConnectionGUID: U+BXkCxkTd+A8GJuzPQqQw==
X-CSE-MsgGUID: 7MJNgmebSoWk/TBnjR1dSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22393176"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="22393176"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:43:33 -0700
X-CSE-ConnectionGUID: pJzZO3NySt6qWVUxrWblBg==
X-CSE-MsgGUID: EtdW4eheTmGy4drrubtCEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31076262"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 00:43:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:43:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:43:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 00:43:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 00:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U165PDbKwR0bsiQlFAoWei7r+Q5s0zYMTHk07p8LTYl1y5Rh8Umowhy2nGcNehTl2I023nWSgNCQHWj7negd3ZaSYe+vTtme9QFDIwgmFClOS/0Mgaeq1Qes9jaoE7mLXjr7SH7gzsrHgxOvWMccMb6C/ApAEDPJ2m/Y6UkPb9sHRPWolwivfCvyP+rMtaDWBNcYFjXHaX2rthH1AdSgJR7fpkkfU2MxJARS6J1r87NP72fVk7RhvQaZHBG4m/IaJ3qC9yzyWPirKeEH0I9fhU8UoyhMk0Pnjjq38IlIADSqJ9bNMk57oijGzUdzjyj+9+cmJL/jFNu9EnFYQo3/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJx225mHJbTMM2cGLxd9PIGxsftsBPQbb/4GqUjzf/Y=;
 b=F/fOE/hKTt4rtNwVW4PvKD0JYdrr2eMTUAxLI8indxnn6EzW1hCrw/NIHXkwW88xi/zOr3uZyd92wWrbKb1zEkzjdotMFqjBjn9jWyJGDEfkbsWA6h883bT1AJgQ6oeiYnhCxPYSvg/jOKrzeEBighB6CBWGI9FKvvEnaFXWICwXcO12ezvhC3PI2VanuxMFE6dZkPY72zoyOiufOGQlV3taAfxtqsdrHux3t7Rlj8ufOwELqxw7gtn09tW06N6A1xsglKOTbXWYxvyeceEWHTHhATVWaX0BtcxlGNUVGHCD01Dwyy0WW+bCD4pQxFJgmbrYLmTAEMKrIxoSizk9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7115.namprd11.prod.outlook.com (2603:10b6:806:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:43:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 07:43:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Thread-Index: AQHamw8bLYtOgdprmEKnPZxoJChdq7GX/cMw
Date: Wed, 15 May 2024 07:43:28 +0000
Message-ID: <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-5-baolu.lu@linux.intel.com>
In-Reply-To: <20240430145710.68112-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7115:EE_
x-ms-office365-filtering-correlation-id: fe715f36-1a74-4555-3306-08dc74b2b60e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZCEcuFgvJtVWSEcVSOU4vYjARQfYOZtXM4/D5Qw6eHb49dlqghlcTw6GsCQh?=
 =?us-ascii?Q?lsgGo4XDXXyfUDmxIJqsINziQq83Hoq/mV655NJSA91bxxnS3KVYH0DcA3B7?=
 =?us-ascii?Q?ZRyoJu9rrf+XBcm3uSrkja4SiG9eeY/NCWVqvSPtI/pVKVZesX2aGgLgTci1?=
 =?us-ascii?Q?VDqXpULZ/D6WY4iyWf7ifW+YahNil7zHbo4IdbfYUo7C0n5w5a9JVmPQfNg2?=
 =?us-ascii?Q?hoPU19uV9Le3uMrDJ1lIrltQk9TzjDKbYXJUHp1pU7oZwUbdvlq6v2A6tqpj?=
 =?us-ascii?Q?wZ3qO7Hf/tu/m75tTpNCCq7iX/xeC4AyWd8UG64bmM/o4e07BQlToqOfLBdz?=
 =?us-ascii?Q?i/oZd3KZ3b3XFM1Q0W5MrFZOhdjoxklE9OUf4XdMTfqqmt8OnRduN/ucledH?=
 =?us-ascii?Q?XoyihjItAgaa/7XKKVqLoOH8J6bTD5K+AF4w+H34wmFgvcSPcmUPLYJcCihi?=
 =?us-ascii?Q?TE0RUF9iRkTy+ed4IVx1RH/5e+X3m89pop/9ykjpavTKB39PVWXAtKB5XH42?=
 =?us-ascii?Q?hK3Q480mfJMLI6Mg2XQCBtEV72MWbqmI+uiMD1MtvNDOK/Cw85kRWnrWtcZ+?=
 =?us-ascii?Q?6+uRjK6NtbGKk5eqkK7i2XC6p5VsLMODLAQut75CvVz9ryOsm3IYvrqKrCzj?=
 =?us-ascii?Q?EnF8mpcQm0R69MopSamwqguu63Zpe7EApv0KSmTUGPvHwaW2apBLiUVBZsgk?=
 =?us-ascii?Q?SO0U38lsFqmRfXTUnylKnOzCb/iu5ytmtOsyQ8wi3pgPji5cLZToU8yXQ4T9?=
 =?us-ascii?Q?wQfWGh+AB2MBjG7G0BPxeMTAtJGvbuJyxQ3mupeYSTxOc3thMrjC9/1HV39j?=
 =?us-ascii?Q?0PkaivfYlol4RQH8VXPg7Ka/5a8ceLLH9Zed2iwkGNbYaRJcMxnHgS+sieZs?=
 =?us-ascii?Q?URjpUIHfrtM5NRp1A6rQw1Giya3GzbrcurJbCs25srv1TxD0U3TDlooU/G1u?=
 =?us-ascii?Q?225DOnTbSaAAqLnSuXrebXnS40ZwPJ2U+lTIpTq1+7uUy6WCxIjj6hmn2jFO?=
 =?us-ascii?Q?X/hCvvXarYG+ncGOpHCBEGXXog0YAFEhHQxVPrBV0v6uTueOvxmabcqo4DUg?=
 =?us-ascii?Q?OqLhjLp9MqevMqAbkM5AQH0g5cTU18iXy6vgLiUczJ95PGFlbttkGbCrLOdd?=
 =?us-ascii?Q?V0k0KKFQu7rhCjHztwhRr9AN08bST9QAPrUa23h6toRo2VroTlN3iMSaGr4O?=
 =?us-ascii?Q?3p8Fm3O+3Jc0WhpXEv1MOWCsDVvruqM0Uv699TD8GZ5PbPpDpK/EvNSL4kyI?=
 =?us-ascii?Q?nP4v5tMQvDwplEtmgQBcuMnghy/E3IfMK9+emlniEojA8FzhKM9P4MsXXIqh?=
 =?us-ascii?Q?D/wvLsutCpcMBwUF90CZwGYbXDJ5joS1u1KBsGCjXqqmgIGyxL9As4b06MG0?=
 =?us-ascii?Q?hoSJSrg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NdLG9ZCFofhKqR/L+u5+rUKWFdI311sjeAFkipe2IfP8EZOPIYoLQGTonE5u?=
 =?us-ascii?Q?ItS4sAXpDH54N5qD9QduEQy6PnS5ySV7kTTEgnpYPiOCFJ/gzFDMCDKo72kC?=
 =?us-ascii?Q?GAcXv3pe6OpzSES/lGN2QPTWQWQKCMZHEY7miATFrabhOPfUn8dcQrewP2OK?=
 =?us-ascii?Q?0c/LzHkGW+HLLmaZMMExAMGa7eWSNMV1lzNCeRr2mD858aCN1AkNlkCdaIj3?=
 =?us-ascii?Q?pmajkdOBhePlZjVDU9lccLcjlqvj/Z4ngYLNGN9rWGbMMoITBrCkeKfCGGXE?=
 =?us-ascii?Q?lmD/hg7I3Bo1jMqfqDI0htzBL7nI9VWRXejo4Sgzg+BgpvFr65osCg4UzrMQ?=
 =?us-ascii?Q?2oaa0+E/BGZU50nF+wvwXGTn+YNi6KL6DdaBSTJyZz3aUrwzM1Q58G1fUG1E?=
 =?us-ascii?Q?f4l+Om1YF07ZC28AO9upWFW+A3prpWJym/xQ/TVb1p+oMmtCtekvBASSICoF?=
 =?us-ascii?Q?+c+o2ElJdVY7vElzmjvER6zYzwSSfguERe2cqGWI4RyhaxtpKAOvhDTepVDf?=
 =?us-ascii?Q?9RqCt9kcxbVtbauP+9d3H/iulitM6NLGMwLe+nI7xKRVPoQf02ICcDo6O/aU?=
 =?us-ascii?Q?2ehqltoNbalSmiy08IboSBYHOJyiyE3Ykc/+zag0Ul0ivF0ZJPYiPJHoYfWL?=
 =?us-ascii?Q?jvZO9k8/IUfq3h4flL1x/lgY2CMjQs0Sl9cMrg69H3tCnrhpXbYl1mIElWlV?=
 =?us-ascii?Q?BziFGg5XoTMJqTPsYUpJej/MfZP/DpgmtzLvTZ+SiYUdDRv/OyBM2hPkSKg2?=
 =?us-ascii?Q?WjryLfzVKBuRGVutyA3a1zFXFlA21EbPfMaO0Ut8odXpLgjb4fcnQMx+siUe?=
 =?us-ascii?Q?xvBFG0k0HlDXN9OARjR6RFpiMS9wrwt0jvQexG9gUnRnks/uQsZCk+SxMqaD?=
 =?us-ascii?Q?qI7hS85P1vUpYMEFG2qgsmBwaKOVo4O9g/4x64d6D1MApx+zrwXUf1g566SQ?=
 =?us-ascii?Q?f0ldkmOm/MjsbUAEDoVEp0dr87xEuRA/hoFqhUayYw99AFR1lZIz701sd9OQ?=
 =?us-ascii?Q?ySBg9bcYvIoRSM78BGANb477qxmURro/di0gF+BIh5+0LHteK+M59LzR2r3v?=
 =?us-ascii?Q?qOxqsfREpJ6WppgGt3Ub9yf2xLE4zWXL8Q9cGIrY5qmzhjc0k6VnJTVa4Xqj?=
 =?us-ascii?Q?MEFPdYkBfHmI1wVJXkz9vLLfCuEAyuZtel3JFx1ajftOXtsPyqchMpqDWg0k?=
 =?us-ascii?Q?1nS7zYHbW37Ef3GSD3T1RUiqKLdDg0obbmlISPKDVpejq2q7RzPfBxKSBhhN?=
 =?us-ascii?Q?G7QOv/PJsZ5KZn4t6Oho5V4sO4WKOPjp04Gy5dbvLLLAiDhwl/P57/HdCWs7?=
 =?us-ascii?Q?S+wicJ16huY63OQd35nAJKK0YtMqbCemK1B8Xqx8YWKw5EywfhieDPwTKjCf?=
 =?us-ascii?Q?iFqkPg5gfEFuYC+K7OdkoQXs7NAwRNwJflDaja8gwZgjeWUBKN6/6ksoe+5+?=
 =?us-ascii?Q?gT//+sF4lp1OhnlDMYfnSKEkkuAo6Pg28yF29G+IyxfV+yNFhbPX9v4ihe04?=
 =?us-ascii?Q?UQcV0+68t6SwLboba2E+5u2PuZXzgBGCOa+ha2D8FyhYr0j30rcjjBCcLmUx?=
 =?us-ascii?Q?80i3+BfhV0/ePR3qA6yfmojgS5A5ZM18ASr5Q+0F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe715f36-1a74-4555-3306-08dc74b2b60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:43:28.6691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2L17noDIg3zDNtnn9RKrrRa/dR9bVShcWsUHsLFvi0NayKI8QdNFhEVPUTHMx/rYnG62VaDt6hTWrFAZrqgdlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7115
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 30, 2024 10:57 PM
>=20
> iommu_hwpt_pgfaults represent fault messages that the userspace can
> retrieve. Multiple iommu_hwpt_pgfaults might be put in an iopf group,
> with the IOMMU_PGFAULT_FLAGS_LAST_PAGE flag set only for the last
> iommu_hwpt_pgfault.

Do you envision extending the same structure to report unrecoverable
fault in the future?

If yes this could be named more neutral e.g. iommu_hwpt_faults with
flags to indicate it's a recoverable PRI request.

If it's only for PRI probably iommu_hwpt_pgreqs is clearer.

> +
> +/**
> + * struct iommu_hwpt_pgfault - iommu page fault data
> + * @size: sizeof(struct iommu_hwpt_pgfault)
> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
> + * @dev_id: id of the originated device
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
> + * @addr: Page address

'Fault address'

> + * @length: a hint of how much data the requestor is expecting to fetch.=
 For
> + *          example, if the PRI initiator knows it is going to do a 10MB
> + *          transfer, it could fill in 10MB and the OS could pre-fault i=
n
> + *          10MB of IOVA. It's default to 0 if there's no such hint.

This is not clear to me and I don't remember PCIe spec defines such
mechanism.

> +/**
> + * enum iommufd_page_response_code - Return status of fault handlers
> + * @IOMMUFD_PAGE_RESP_SUCCESS: Fault has been handled and the page
> tables
> + *                             populated, retry the access. This is the
> + *                             "Success" defined in PCI 10.4.2.1.
> + * @IOMMUFD_PAGE_RESP_INVALID: General error. Drop all subsequent
> faults
> + *                             from this device if possible. This is the
> + *                             "Response Failure" in PCI 10.4.2.1.
> + * @IOMMUFD_PAGE_RESP_FAILURE: Could not handle this fault, don't
> retry the
> + *                             access. This is the "Invalid Request" in =
PCI
> + *                             10.4.2.1.

the comment for 'INVALID' and 'FAILURE' are misplaced. Also I'd more
use the spec words to be accurate.

> + */
> +enum iommufd_page_response_code {
> +	IOMMUFD_PAGE_RESP_SUCCESS =3D 0,
> +	IOMMUFD_PAGE_RESP_INVALID,
> +	IOMMUFD_PAGE_RESP_FAILURE,
> +};
> +
