Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1AD15AD9A
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752931; cv=fail; b=H9nNq9JFV1yTLQ+NBNfpfcYz7fAEptVn9kYnr/IL+ALdQKs78bN0zFZUtOJhFlxBk6qA6uwXsqV7pkJ9d8Y3M8tRUvO42Mf41I0K1y93/TcF/jW+HbBFqN0NwJDaZySVKaO1OYOjr8rJ2LktCQ96Gju5PkihTepjqquvUkyPfdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752931; c=relaxed/simple;
	bh=IgsyOgCm+mroc790JcWf2V5lk6XFt+xxbx9dYQmnmUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XcSEyl0qqF+4OLrxiBoqC0enLXt029kXKO8VHTHG55iq4plCDcIpnrtkqdN+tjYmtCpX0LmmxwNN7TBrBXUtmWkJTrfuxB26NuYEQuNkqZl8fDf7JLXV+0Fxsf2mP8yb877FcURjhcHdgfzlEfYrtVmA8v2bdsNr+nbrKKgGht8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQxdMBQl; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQxdMBQl"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECC54419FA
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id we31L-1Gycep for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jun 2024 09:35:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B8E8B419F6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8E8B419F6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iQxdMBQl
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B8E8B419F6
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717752929; x=1749288929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IgsyOgCm+mroc790JcWf2V5lk6XFt+xxbx9dYQmnmUs=;
  b=iQxdMBQlZmmlVPSsYuTf3aH1aeOy0drz+xOLyZwGLOUZtzGnLOOm2eJh
   0YMgrMRiUMHNDE1/ZfZCafxuWXq+vQfjeBVw915kILeR6F3cSzYKHqY/F
   OhKVUWOEohmobmzQvKf47xauz/szPPmwTqhDp6j34jq046nFynteqXRLu
   Z63YTu/1HgRON48GVkLgPqXwQkid6IDayqvuO4SWibcnRkYbPWM69RoNA
   0dDF7NY3NfLP4xQtmS596mV/WTff/j8eG03bGJ4wdeVIwveYkp/LcXEHC
   JnSlNBE75XtUWEpYdh/DYUg8rR73wnXi2tybJVG8sNxxXDT1Ro5OnaB88
   A==;
X-CSE-ConnectionGUID: Z5Y9mUjATW6oB9csf1ih4A==
X-CSE-MsgGUID: 2eUCKcS5Rx6TcMfjC815wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="11961090"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="11961090"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 02:35:28 -0700
X-CSE-ConnectionGUID: osq6g+4JSFuiJyAYg7AinQ==
X-CSE-MsgGUID: xDIQxSbRTS6bP5KeAPSkmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38838815"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 02:35:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:35:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:35:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 02:35:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 02:35:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d25nh8IoSIF+08ZAA6w2WAQN35qXopChZ15BsKR8jaOD2juU9BibafAYkw5aEnIxtqGGk3xjNkcxaHHpYPl1EMSmTQqcnCzztaPbS4FXeA+QQzPxM1E1DwY35KlKghJY5QXZ0ZPnklKyHvU/ES66W5UuybSX74cHPNOuJgvPtpo1s3sDJb1FaQiR7efWrr7YjUXuGe3PKYphwFRQ4EtxXVZ75GwCQTvTpeCo2jalthq2RBqJsw6JqBTe0ji1IBTON+BjFL/MuWBMjTb9QCGt/rYpfG/152HLVF9+FMrWj5go7K/PQf5uYI4gdKKI8A2JoUc3ZVfAMncuhLegaHScrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgsyOgCm+mroc790JcWf2V5lk6XFt+xxbx9dYQmnmUs=;
 b=k/FBxKsae7+IFzt6ej+xFuCtVYxYBdltlTYjjW6kJckEhgpspf7wp2/eXjLRBMXIIMl+sCnOXtLpKVn7196DxFHkt179mpmkpZXNNIMxFLU5BDtv1Yh/BozL3mWXY2batVp0pezHVPAyPsQDox7+UOWxTOW9Pz9UyMu8m/VRAqvuSiXFJtVn16kdtA1/olmORDjdayq8d+GgnpAgjWNWHZsywBhjKXw5kNI6o2kBWgJ3faZbelK9of2hdtPn3BSxpGXXypthI1ZCWDNc8LwMKQk6T/cAdfslPV/xUBxexn8jFcuJQIe6kYczPMM1H9ZzQSQ/zX8ET64IqHznlsr60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 09:35:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 09:35:23 +0000
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
Subject: RE: [PATCH v6 02/10] iommu: Remove sva handle list
Thread-Topic: [PATCH v6 02/10] iommu: Remove sva handle list
Thread-Index: AQHar+tqwnlyEnOTnkSkjxonj6LyULG43azAgAFx2ACAAcw34A==
Date: Fri, 7 Jun 2024 09:35:23 +0000
Message-ID: <BN9PR11MB527693E470478D92564A31718CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527658A85092F88329EB73E98CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <afaf133b-7175-467f-a254-060b66b9cb4e@linux.intel.com>
In-Reply-To: <afaf133b-7175-467f-a254-060b66b9cb4e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5166:EE_
x-ms-office365-filtering-correlation-id: 5c3e2e08-f79f-4a53-9eb4-08dc86d52813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eEh5TFA3VDdyVy9jY09VaW4xUVFodjdweUJPVFBXZFpWVFo0WlUxUmJSSUN6?=
 =?utf-8?B?NmoyS3ZaUmtIaU5UZjFtbnpjNWJyaVV0VFBZT2xpZWJ3aXc2S08yeVc0MFBh?=
 =?utf-8?B?YldCTmhIT0xjVTBuY1gyMlJGVFl6dlM0MkRKTlE2enBsYVc5SGt6UHNwejF4?=
 =?utf-8?B?cis4Nk1xZ1BlRDQ1WjFBNUhvWEg4VVVXOEVzY3JISDduRndBZDlGVE9ZSDdD?=
 =?utf-8?B?azJEWTVzQTNnOUE4bE9vVjQzd0wrVGlVWUhyV2xJTC9YT2M2cmNjdnpVVDMx?=
 =?utf-8?B?QlQ1ZXlYSEJOQzl2cVR5RlU0R3BXMkZtcWRNTTRWWWtTRk5BSko2cExTRkZC?=
 =?utf-8?B?UjA2Nm1HeFBkWHBHcmxlTnEyNmFJaHM5a1B4NHpKR0tjd3N3amh5ak85dzlv?=
 =?utf-8?B?T3ZRRHh6V2RiNkRTMEhlNGh0VDdqQnRkSFAyWjd6RjJpaHI5dVZRQ1JaeW94?=
 =?utf-8?B?ZGJaaTNSNUFQVS9najBWOW1OOVBSMzUxa0JzVzlnMEdCU1hJMlIzMzBqREoy?=
 =?utf-8?B?YjZCakN2L1dwdnFvd3lZN1RYM2NUZHJzV1RtK0FmbzZXc3F3TmZNZUtCaEZi?=
 =?utf-8?B?WTdxNXAyWTJHcHgwczVicGlNK091YmdYQ0xBK0JBd3Q5d3hPcHZQVkUwNmpJ?=
 =?utf-8?B?UGlEaUV1bE1TYjNoNDVYeVk4UDlvM0VmQWd5bjdRZmFDSzFEams1MkhUN2JU?=
 =?utf-8?B?TVFKb242bUhqZHdSWVR2TFpVSUFGOFpPWlNUbVRBdE0vVGNBWmxaRStLTEpP?=
 =?utf-8?B?UFVNYytJTUsvTCtXUU8yb0RJWVJOeDZXbjA2c0FCdEVmN2ZQakRMRnNxTGFU?=
 =?utf-8?B?c2tSMEpyd2JHN0ZmR21lUDVYTjhUd3h3SEV0RVJkWDlqTXJjVXF1SUl0L1lJ?=
 =?utf-8?B?UXozclZnbkJHWVk4MGxKSjRnSlRHc1ZxNng2TGovZVNEMFQrcWt3V0xubE1s?=
 =?utf-8?B?VXYvSUx1SDNKWU14UjBNRDVWanZhNkJRbDQ4bkxVRGNRN2RBa0NpdWdEOE1a?=
 =?utf-8?B?L1RlSnNiM2Nic0cydkhzTFgzb29YaFNueHh0T2tEbVJQVDlpS0VnTHpKUHNm?=
 =?utf-8?B?aXluL2lkV09ZSVNNbmxNY2FvTThUZjVXYmJoZXIyYnhqL0JOZ1Z1ZW1VcmZJ?=
 =?utf-8?B?WnBQelJFOFk5YTk4WHFiQ3pLOXZSRjdMbHMwdmxZR085NmlKV1NWMFhoV2ht?=
 =?utf-8?B?OVhzaDJkUzhsUzBmTGZHam5iMjZ4cmtPTldvenRvUktIaWk5dFI3dy9lbkRt?=
 =?utf-8?B?TWoxU2NvL1dLdCtaSXpib3ViTmlNKzZoZjA0SFpLZ0pLUDlEdHdib1JIMEFG?=
 =?utf-8?B?Y0d4MkFEbU90bU0reHJjdmtWUU9XSFBpOUVJNnJZcS9NaFVYS2EydC9qRGdQ?=
 =?utf-8?B?eWdlTWYzT0dLekM2YUxYb0NWemk5RzBmd09WYjV5dFBMNzJkamdncE9odER3?=
 =?utf-8?B?MllKUnVQczZGdzBNd2FBOFgxQm55MFBPVWhLQWpYcThhaHB4WFVOUHFNSk9W?=
 =?utf-8?B?WXJESzhsL05VZWF2VktvdC9Vc29WMjRWOVc2ckk2cktscVJsWUI5ZWdNS2xC?=
 =?utf-8?B?M3Bad1Q5MEhjSHFwS1ZYbmVXUkcwdWtEd1BJQ3UreGhaYmk5VTEvVEVCMnpI?=
 =?utf-8?B?YnhoMDNIMWY1SnJzMktXeE51RDFGRVRGTWZPT1JWYUJTRHViY2gyMi9rSHNS?=
 =?utf-8?B?YllVVWwvc3h6cXluM3o1bSttVW1OU3RwYjhBWHFQMUkrZnp6NTVvSnFnSzUv?=
 =?utf-8?B?bi9OQzlZWUh1b0hTckFjeWpWWGlmRFVPdWNTd05PUDJxdE8zZmZ2VkphcnRh?=
 =?utf-8?B?djVmMk1RejgyWDI3NzRKWFd3U1pSUjJxUUp2cHN5b3FDR0M1RHZxWGE4N2s0?=
 =?utf-8?Q?uptYW9gpWmYva?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUxidmdQbkFiVm9jNHBUeGc5clFMR0t3QWVyQkRlcFY5Nm9rWHZrcENLeS8w?=
 =?utf-8?B?NmVWb2Z2MlVWQXhjSkdadjQ1Q2pBbEFSRUpLZGplYWQ0R2lzVWRScGRZa1NE?=
 =?utf-8?B?dXA4aC8yVXBsZ09COVpITVRIVzZMSWFTdUl2UVpPNUUvUFJEeW1qR3ZNang5?=
 =?utf-8?B?RlVuMW8xUHNDT3c2aFRVZS9xN1FnU0g5dmN6eTVaN2Zid28wTGVzUEhwRTVq?=
 =?utf-8?B?SEZiUHhEZ0l4Z1FXaWJvK1Jqa2NERkFVWCtFV1ZVcGZIU2tNVmxLaHpwZyt4?=
 =?utf-8?B?S2RidXBlaWl2WGFncG5rUXJHTUx4REc1ZU5DeEZvMHVTRE1obU1CYlN6T0ZT?=
 =?utf-8?B?ZGhLNjdnMHErNDJCRFZlODBZSFBOSDZtRWQzQlhOaXd5cUFvcTNOd1l6dHFJ?=
 =?utf-8?B?N3VTVTRET2RQYW1ZZS9CdnU5d2xMLzFoU3k5T0w0VWE3dFlDOE4ySVBLYzFx?=
 =?utf-8?B?c0RUUUtsV25CY2lZc3NLRG9mbkllUFRFVTFDV2Q5bTVwSFNnbmF2Nkk2NXB0?=
 =?utf-8?B?QnZaSnJDSjE4ZnNia1M5S05Eekd2RnE4eW9nUGE5RWhXSlBoRmxIeUFFSlAr?=
 =?utf-8?B?UjhEdEF1UEtxUlBPNzlwYVhCVzBzVlNpdFo2b2pPR2VsMTBKU2VhSnQ4SC9p?=
 =?utf-8?B?ajJUQU84eVEzOTVpNWRCQmNDcEV2UyttZllwMXNTd2xzMEFBbTBURlR3L0N5?=
 =?utf-8?B?SjhMbGovOEEybktlSXpzK0R5VmFpekpvK0xLakd1SWF4Q2hvdm5HQkV1MjBY?=
 =?utf-8?B?aTlJUW5kSS9ENkZuS1VUTTlyQytPdDRHMkR1eVg4dDJhcHZUZ0NZSXNUNGJv?=
 =?utf-8?B?TDNwWmI0SzdJWVBoSFpkRHJNbUlERXNsWmY0ejk4bVhQS2tGVFpOeVp1d0xp?=
 =?utf-8?B?SHExaEx2MktCUy9qOFcvbDFFQU5lYW5HZ1p0R3Z4MEgrVWl1MUlpL1N3RGZx?=
 =?utf-8?B?QUhOZHNWM0sxemMxM1NRYVFVWmhnNFpPYnZERWhYN3V1aGJvckFwRVZDdFNZ?=
 =?utf-8?B?SGt2WitORkFKdk9uVWZ4YjRZTVAyUXhCcHl1THkvVkRQaGU3SUJmRTdNT3A0?=
 =?utf-8?B?UElUYms0WTRBbGo5NkttRmVrZU9HQ0o2eHhQcmRPaDFBSm5VaVAxeEpYUlp2?=
 =?utf-8?B?cFlUN1dUaXZ3NStmQjhaVm5zR0dDeEVyRm9mZktHMlQ3a2szamZ2eWRZam1n?=
 =?utf-8?B?RFVDTnZQSHVDOHlNa2tBTWpGWUpUMzhwWTVYMkplT0JDTmR1cVh6b0cxTTl6?=
 =?utf-8?B?Qkx2a0prd0JURDVsNVN3UFNzZXM1U25YOXpXem8yZHJyZWNxc1QvbVk2cXZG?=
 =?utf-8?B?S3Z4Wkd2M05WaDNtSHZDMEpNVm5VbjJ0QmdtYUlsVHpjS0dXVE5temFoNDht?=
 =?utf-8?B?d3Q0d1BtdzNBSndBaEhtaStkRUxIdTFSS0VZOWUrY0MrK0E4UlA1VFhsVUYr?=
 =?utf-8?B?SkN5SlZISmZWTGNhWXhsQ3psNi9hNVRqNE5qUm82WW51amN1cWF5K1RIQ21P?=
 =?utf-8?B?UUZJUldFZ1pQcG9NUWZoWEtpbitRNXZoV0d6RXlpWmZCRGtxSHVXK2lyeFNZ?=
 =?utf-8?B?WXBJZzNTZ2piR0Q2bFZBVlYwN2h2NVJubjRjRmpHVHVjVkNiV0NmME14aGJX?=
 =?utf-8?B?c0Roc2FHcm9aUldjUGdmNlVTazcvaFVPNVBVU1RLdGV3T0t3QlhoVVkxS3ZW?=
 =?utf-8?B?VERYcXpLR2VwZnp3L25oVWhsVVZERkdLcjJPMlUrcHorcmpaaW85eXlJRko0?=
 =?utf-8?B?RlprKzFyTG5KVHFUWVFtQWVrTmdpdmtqN2pHS2M4VXdFRHp5ejZreTBQYnlk?=
 =?utf-8?B?ZmUxTjFRWUlzRUFiUEk3Y0IzMm43enRuNmtpSjlEdy9iMnQ0SHRSaVZPMlk0?=
 =?utf-8?B?ZEpDaFdaMCs1VHArZU9ocVFnRnVpNHNnR2dQWXAxOGxUQVl6VmhOODRnbWsy?=
 =?utf-8?B?MmYvTDVoT01xMXFGbFdKQnVOY1VVdVF4WGNISDkxYzRVbkV3T1VlRHV6RzIz?=
 =?utf-8?B?bVpGbU4wQm1XV0V1b1pTc1JMamxraG1HMVhFZXg5MjJvZlVsdU1QUkh3V1g1?=
 =?utf-8?B?OHRINUlLNnNUNitDaFBSb2pFN1pYLzl3UzlTMzlqdzEyb1RVMkhFRkdiN1dr?=
 =?utf-8?Q?+fxG0h5xa3HyRt25nI5hUZl3m?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3e2e08-f79f-4a53-9eb4-08dc86d52813
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 09:35:23.8053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbH+Yu+BvbIGpDCUuD+lrz5I5J4o4Z8uc6xwjtvSbzmNu/4IU+bkxdP3CgIBNx59ovvABa8kztVjoZNeuDXjMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVuZSA2LCAyMDI0IDI6MDcgUE0NCj4gDQo+IE9uIDYvNS8yNCA0OjE1IFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBNYXkgMjcsIDIwMjQgMTI6MDUgUE0NCj4gPj4NCj4g
Pj4gLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGhhbmRsZSwgJm1tLT5pb21tdV9tbS0+c3ZhX2hhbmRs
ZXMsDQo+ID4+IGhhbmRsZV9pdGVtKSB7DQo+ID4+IC0JCWlmIChoYW5kbGUtPmRldiA9PSBkZXYp
IHsNCj4gPj4gLQkJCXJlZmNvdW50X2luYygmaGFuZGxlLT51c2Vycyk7DQo+ID4+IC0JCQltdXRl
eF91bmxvY2soJmlvbW11X3N2YV9sb2NrKTsNCj4gPj4gLQkJCXJldHVybiBoYW5kbGU7DQo+ID4+
IC0JCX0NCj4gPj4gKwkvKiBBIGJvbmQgYWxyZWFkeSBleGlzdHMsIGp1c3QgdGFrZSBhIHJlZmVy
ZW5jZWAuICovDQo+ID4+ICsJYXR0YWNoX2hhbmRsZSA9IGlvbW11X2F0dGFjaF9oYW5kbGVfZ2V0
KGdyb3VwLCBpb21tdV9tbS0NCj4gPj4+IHBhc2lkLCBJT01NVV9ET01BSU5fU1ZBKTsNCj4gPj4g
KwlpZiAoIUlTX0VSUihhdHRhY2hfaGFuZGxlKSkgew0KPiA+PiArCQloYW5kbGUgPSBjb250YWlu
ZXJfb2YoYXR0YWNoX2hhbmRsZSwgc3RydWN0IGlvbW11X3N2YSwNCj4gPj4gaGFuZGxlKTsNCj4g
Pj4gKwkJcmVmY291bnRfaW5jKCZoYW5kbGUtPnVzZXJzKTsNCj4gPj4gKwkJbXV0ZXhfdW5sb2Nr
KCZpb21tdV9zdmFfbG9jayk7DQo+ID4+ICsJCXJldHVybiBoYW5kbGU7DQo+ID4+ICAgCX0NCj4g
Pg0KPiA+IEl0J3MgY291bnRlci1pbnR1aXRpdmUgdG8gbW92ZSBmb3J3YXJkIHdoZW4gYW4gZXJy
b3IgaXMgcmV0dXJuZWQuDQo+ID4NCj4gPiBlLmcuIGlmIGl0J3MgLUVCVVNZIGluZGljYXRpbmcg
dGhlIHBhc2lkIGFscmVhZHkgdXNlZCBmb3IgYW5vdGhlciB0eXBlIHRoZW4NCj4gPiBmb2xsb3dp
bmcgYXR0ZW1wdHMgc2hvdWxkbid0IGJlZW4gdHJpZWQuDQo+ID4NCj4gPiBwcm9iYWJseSB3ZSBz
aG91bGQgaGF2ZSBpb21tdV9hdHRhY2hfaGFuZGxlX2dldCgpIHJldHVybiBOVUxMDQo+ID4gaW5z
dGVhZCBvZiAtRU5PRU5UIHdoZW4gdGhlIGVudHJ5IGlzIGZyZWU/IHRoZW46DQo+ID4NCj4gPiAJ
YXR0YWNoX2hhbmRsZSA9IGlvbW11X2F0dGFjaF9oYW5kbGVfZ2V0KCk7DQo+ID4gCWlmIChJU19F
UlIoYXR0YWNoX2hhbmRsZSkpIHsNCj4gPiAJCXJldCA9IFBUUl9FUlIoYXR0YWNoX2hhbmRsZSk7
DQo+ID4gCQlnb3RvIG91dF91bmxvY2s7DQo+ID4gCX0gZWxzZSBpZiAoYXR0YWNoX2hhbmRsZSkg
ew0KPiA+IAkJLyogbWF0Y2hlZCBhbmQgaW5jcmVhc2UgaGFuZGxlLT51c2VycyAqLw0KPiA+IAl9
DQo+ID4NCj4gPiAJLyogZnJlZSBlbnRyeSBmYWxscyB0aHJvdWdoICovDQo+ID4gQnV0IHRoZW4g
dGhlcmUgaXMgb25lIHBvdGVudGlhbCBpc3N1ZSB3aXRoIHRoZSBkZXNpZ24gdGhhdCAnaGFuZGxl
Jw0KPiA+IGNhbiBiZSBvcHRpb25hbCBpbiBpb21tdV9hdHRhY2hfZGV2aWNlX3Bhc2lkKCkuIElu
IHRoYXQgY2FzZQ0KPiA+IHhhX2xvYWQgcmV0dXJucyBOVUxMIHRoZW4gd2UgY2Fubm90IGRpZmZl
cmVudGlhdGUgYSByZWFsIHVudXNlZA0KPiA+IFBBU0lEIHZzLiBvbmUgd2hpY2ggaGFzIGJlZW4g
YXR0YWNoZWQgdy9vIGFuIGhhbmRsZS4NCj4gDQo+IFRoZSBQQVNJRCBzaG91bGQgYmUgYWxsb2Nh
dGVkIGV4Y2x1c2l2ZWx5LiBUaGlzIG1lYW5zIHRoYXQgb25jZSBhIFBBU0lEDQo+IGlzIGFzc2ln
bmVkIHRvIEEsIGl0IHNob3VsZG4ndCBiZSBhc3NpZ25lZCB0byBCIGF0IHRoZSBzYW1lIHRpbWUu
IElmIGENCj4gc2luZ2xlIFBBU0lEIGlzIHVzZWQgZm9yIG11bHRpcGxlIHB1cnBvc2VzLCBpdCdz
IGxpa2VseSBhIGJ1ZyBpbiB0aGUNCj4gc3lzdGVtLg0KDQp5ZXMgdGhlcmUgaXMgYSBidWcgYnV0
IGNhdGNoaW5nIGl0IGhlcmUgd291bGQgbWFrZSBkaWFnbm9zdGljIGVhc2llci4NCg0KPiANCj4g
U28gdGhlIGxvZ2ljIG9mIGlvbW11X2F0dGFjaF9oYW5kbGVfZ2V0KCkgaGVyZSBpczogaGFzIGFu
IFNWQSBkb21haW4NCj4gYWxyZWFkeSBiZWVuIGluc3RhbGxlZCBmb3IgdGhpcyBQQVNJRD8gSWYg
c28sIGp1c3QgcmV1c2UgaXQuIE90aGVyd2lzZSwNCj4gdHJ5IHRvIGluc3RhbGwgYSBuZXcgU1ZB
IGRvbWFpbi4NCj4gDQo+ID4gRG9lcyBpdCBzdWdnZXN0IHRoYXQgaGF2aW5nIHRoZSBjYWxsZXIg
dG8gYWx3YXlzIHByb3ZpZGUgYSBoYW5kbGUNCj4gPiBtYWtlcyBtb3JlIHNlbnNlPw0KPiANCj4g
SSdtIG5ldXRyYWwgb24gdGhpcyBzaW5jZSBvbmx5IHN2YSBiaW5kIGFuZCBpb3BmIHBhdGggZGVs
aXZlcnkgY3VycmVudGx5DQo+IHJlcXVpcmUgYW4gYXR0YWNoIGhhbmRsZS4NCj4gDQoNCmxldCdz
IGhlYXIgSmFzb24ncyBvcGluaW9uLg0K
