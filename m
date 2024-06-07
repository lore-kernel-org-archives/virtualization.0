Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFFA15ADB3
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752607; cv=fail; b=s3OZ6aReV+ZxxjmUIVk0Jp20I9F+RQ+63tRo0gGVH6+pnnf6RDZ2yvjHZGPhMGtW5TXKlZlyX2WJaLOq0Y8QMuMt3b9Z42bc+iqNyO8KvfJSVR5HQHKV6omRnuHIZ/eh+E0kPa3VUarO+4dc61QG6RG3f/mo85otXWmZUsItivc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752607; c=relaxed/simple;
	bh=h6KMtLBJIQJ8OcYBW9ev3M+UF92gslwifDjQev0faDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qzDcvuYKYGRXKvw3x6LYyVRX5hS1ZgAdwdFovL6zStoIo11UqO4Tan3296oDIxl50eNS4Ifgp2PsHNDizUg2SwoJ5mywAmZeADRTJkGn+jboKE/SGrurcXar3zLMFQQ60h/4OIfshmptjuZj+WMYD7u/uYs8JhgmAok5WEm3P2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfIz3B/4; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfIz3B/4"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 84DDD40B09
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:30:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 09KLvEQRtTut for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jun 2024 09:30:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4113540103
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4113540103
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YfIz3B/4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4113540103
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717752605; x=1749288605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h6KMtLBJIQJ8OcYBW9ev3M+UF92gslwifDjQev0faDs=;
  b=YfIz3B/4UlEadGV08fs9d/TxXBhXWEXJBFpOXD8YpA6zCfHFYPn2iEmN
   j3dS/5sHdHv2tw5T3jN3RBRsrp0W0MBPR8hNtnV3xoHFI9Ata7ZARr9AZ
   jF41b8MRaCLIjz1/QovSDRw1APmDElTAcdKCtCaszzpNeq1b10AcHNFC5
   Z5UpUUbenJm5cAQBuuqGVFb1lGGAvTEmnJ26ITucygNpPQ+V76IaXm3uu
   39UZWlRjOvEAY5ksPfQWOeaGxg64ahMzaEDC/xWYXF/RaL9LreJM4yUBM
   QLHipsoNhcN1pMACMYmS+FljqbNcIuVxU6+faDiYbkW8KFpzVvcxVCnZ5
   Q==;
X-CSE-ConnectionGUID: v2zMucGBTSO1qlRDYQaY8g==
X-CSE-MsgGUID: 4/kxeK8AQB+ie/I33Bb/MQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25869478"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="25869478"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 02:30:04 -0700
X-CSE-ConnectionGUID: z8jLje8aSGy+ubDi7MzAfw==
X-CSE-MsgGUID: 7DYQl8nFScmkwH8pXkD0zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="43385743"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 02:30:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:30:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 02:30:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 02:30:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHq5o8ttIBDED3+nxPEU0nqwNdddVMupjwJgeq7Czb6KRNHzj7Sp+0W3r00uzHNcl71bxNDaYU/VJVzPZWPXYWosgWUXyHY7kCoZbdJQcdHUG9lG+tJLwJDVRJU0PchnR2bg5TWNG/YmYaH2fg9SSSLVp59qDGFZzclfjVq8noQFrjsfNVnAOOTKkBN/4ch1crs24mfKpuF/1aa5fykSXA2puRSglWB/egtozqdVLyz4FGHes5C8kec6DHNg2gfk0FHSJdb1+QgNYQFAwF3vMZdkcSHxu9IS4zzWIRJCDQy2j+9b9Cd3riqBVQx5gPMiztLl3WHVsNE9UdxQvGD+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6KMtLBJIQJ8OcYBW9ev3M+UF92gslwifDjQev0faDs=;
 b=ML6YUkS2pAzmJSBaxoKlL2Lhs3J3dKAJWBLgMURWNWMj/sWXLHMpMmDlpGIuhR1ooPcXDzd+DvzRwBVSr+c1wyDvuAfOE2S8sksahAGIlRuK4nWrLBqb9b1rQO5emOh/wQIosMs/sbR2Zk7Qepi31ZmHwl66CCqcNwmmsvD3HFp1sL4F2Yu5ZvKtWeBTTfHLjjF+wborCxQ5zkpAJbDNrZQD5HyLicRN85Bv9y7G5V0I4EMJ3Gzj6Jeb50R2qh88UOWBr1easaD6j4+eC5uEJbMMFq6uSeR/OsG3WCjHHEXOfKAjdpLmv1JdLq6H8epFROu0u/eCUvLi0WF0Dw8HXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 09:30:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 09:30:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Thread-Topic: [PATCH v6 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Thread-Index: AQHar+t0HeiArTd/tk+nbA8gEhK7rLG8FzSg
Date: Fri, 7 Jun 2024 09:30:00 +0000
Message-ID: <BN9PR11MB5276FC9E1E7CF82BF51BC1FD8CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-8-baolu.lu@linux.intel.com>
In-Reply-To: <20240527040517.38561-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5166:EE_
x-ms-office365-filtering-correlation-id: 1f3d9048-fcf2-4b0d-3167-08dc86d4676e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RWYwaHdNNXJYcjF5NHhjbjZtSk95a1lyMXE3Mk5HdkxjaXovTElFVmVyZ0VQ?=
 =?utf-8?B?bnVBdkd5N2JhU1JYdFBuaUZDSndQUklkL3Y4OG9OR214dXltenBxa1R3UERr?=
 =?utf-8?B?Mk5YcUd4YUMvWGxhV01CdlFyN2ttOXNMVmR2dlI3SmlGbmdRRFJHV0d0U05R?=
 =?utf-8?B?Z1RWK2lOeWEweUtqeXpmY2kzMHNNb0QrbUlGdlRUQWgxaDRac1VPNEJCWXBq?=
 =?utf-8?B?RmV6SEh3cloxbnpmbUE5UHhnTHAzczI0Ui9VdnVqNlM2NXpkc0JnbTYyNXZ5?=
 =?utf-8?B?UFQ1cU5vMTdNNlpBRTI0cUlsRlJhb25lN3ZTTmhLZGFmeDBLSURLM25JK3pL?=
 =?utf-8?B?Nm0rZzRJRUcyanROMEhpODRPWDJ5L01jOW1iNS9UbDVHcDFBRzdGd3FLRGpz?=
 =?utf-8?B?OElGc2ZRNDBLQks4ek1xa2E1aHlrSWszd3pKVE8zMEI3UEpJYmRsaGVSajlH?=
 =?utf-8?B?WGZObnp1TVpjWkN3NEpXdE10WkR6L282QU0yTUREdG5ZVFpkbXVFc29seXFK?=
 =?utf-8?B?YS9BaWFMVU5oYWM1bDlQbzNzekhqZ3F4a3crcXFha3o3dE5VUHB0Mm1UdkJz?=
 =?utf-8?B?cnlVS0dXQVN4dGUvOU1JR0tqOFJUY1llTVRKeUtSVDVWdVh4dVNrM0xVMGxN?=
 =?utf-8?B?djVWTUJBeWMzbGdvckpaWVZYYlEwL05VNCtnajV0MWtaSzNzL2lIQitIcVVT?=
 =?utf-8?B?YzBXc0s5NlVkczVBUGM3UmxCckREclcyTmduNldrd0h4bFpHUDduZFZhOTBs?=
 =?utf-8?B?Y3VEYWJPa3pDMjl6dy9wRVJXR2trWDg4eEpZWGdrNzJCZ2pzNUxrNlgzSUZk?=
 =?utf-8?B?NHRZb3UvcHpqRWZXOU91OFNsalFzS2c5bnhXejhqd0w2SDFJdDdlT1ZxT2F3?=
 =?utf-8?B?aUJUN2NwUDBHYVdMdThrWUpsZENadlpLcnRPMWlrODJLOUZIYi9SYmY0Lzg3?=
 =?utf-8?B?N0lTYUt5ZHdSdGZQdFpKL1FMY3d6UUlKNTFRQmJqdGtJODRtM3pxREdlcHJW?=
 =?utf-8?B?NkdUZ1Vjek5hNGNMcXhTMWxnejZJMnlwTUxzY0pzNVRrRkhuZU0vREdoVjZB?=
 =?utf-8?B?SHg4TDNEa21lZEs4cUxlazhmQmtOTFFHY3FDc09YaFlTKzJ2TURneEovbmZy?=
 =?utf-8?B?MUpTY1lqR1FMdmpQc3Aydndkams5UDlPaFp6dGZnTGw3SmxjTW00bzlPWmNr?=
 =?utf-8?B?TnlYK2Nyb1J1dHlldDZ2VzhOaFByMTl3cWRqR1NBeis3SFkyb04ycTdxTjQw?=
 =?utf-8?B?V2gvT21SNGpraVdtRENia0p3Qlp4QWRaVHJuZm9LWE1YbDR1Z0ttYjcvdTFk?=
 =?utf-8?B?b2JkOUNiU01jcEo5VjVrallyckEwSTBrVlRzdHJ4d2Q5ZXhFNGFlY3hPUTdp?=
 =?utf-8?B?RFhoVGI5RGJENmVBanMxZzlJNVkxV0pvSlc3N1gvT0RoM09NZHZ2ajZTN09F?=
 =?utf-8?B?b1did0F2WmVqSnUzTlZlYUdHdkt0QTJoWFRPaGtoblJ1SzQvWlo3YURrb0RP?=
 =?utf-8?B?WjUwOENDdURpNzRTcXNQYWZ6d0ppeWR5enVyNENmZm1vOHFZWlo0eEVsM2xY?=
 =?utf-8?B?N0hWUHJrSzMyVWlZaVcvYXh1SGlrY0VyN3Bmd0o2TW9hWGxpeUw2RHM3bmpy?=
 =?utf-8?B?ZXdIQXVKUDU1NzJyTGdna2Yxb2tPYkpnWGdiMU1rTEVJWS9YOWpRcmcwdlo5?=
 =?utf-8?B?bnFacFJURC8xajRtYVlvbXJ4eml0eFp2NjJ3QjhoamRMOUhjeVZhbDdEU3lw?=
 =?utf-8?B?NTY2d1FsU3VCR3RCdGVpeTlNNjV3WENZNEJxZVJacUNvZmJsVEUrK3preWdr?=
 =?utf-8?B?U09TUzVJVXFnZXg2eGJlZ0lLTlYzTUhZRHdWdGdXNDZpSjlrTXFiN2RmRUM5?=
 =?utf-8?Q?KsBO8gnmGfyqA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2NUVDRwQ0Q5WnJDelVsQXMySTdtMHNFOHZZOUt4cHhtT2w1RFFEQVlRNHVw?=
 =?utf-8?B?UGFPaDVJN2VvbVpYb2FPcHdwc01pbmdPbGRMLzA3RWp3cTYwVndLUTVKUXRE?=
 =?utf-8?B?T2gxK093NHEvYzh2QnpjRkpDekJWb0p6NmNIUDlFL09jbDR3MlRmVVIvdDFS?=
 =?utf-8?B?c1V4bkF3djBSbGQvNEljR2E2dXF3OEFQZkp1cmtuU1hkeUFWUFBkTzUwbzVs?=
 =?utf-8?B?YWttc2xNSDVTeC8ySzFtcURZdE14M3hUUHdvR1JGbWdmYTFTTUg4RUpBOTA5?=
 =?utf-8?B?ZHdzYVIydWJFTGhVNi9RNGRJR1JuS0ZrdjBDbVJ0ODJIQ3cxOWRWQmx5dEll?=
 =?utf-8?B?NkNlUjdBQjIwcXIzYzlpK1JwTURwWmVYeGRKTFlMVzYzWFNha25wRFhtRFNp?=
 =?utf-8?B?MkVuaUxlT3JzSUtudyt2NXg1RWpDeGdxcHV4MnFjVm1ZNHM2VVdaN2JmckZn?=
 =?utf-8?B?dFVZakxGYmhwQ2QzR0M4SlcwSlBMYkYzL1NTdWdsZ2xzZFl5T3NWNURhVW02?=
 =?utf-8?B?ZTZ2TDBRRW1zU3JROEtSWHpwdDZVVkZwdzdDbmoxRWZVelVhTWRhVG96RlFl?=
 =?utf-8?B?anhSajd1MVRUOG5PYmlsbGJGNHozQ09BWSt1Z25JQTdiendESnA2OFh1NnVJ?=
 =?utf-8?B?b1NZRzQ1YngvYUNTNkVIMk9BenVjUlFndEkydk5XUnlkVXd4dVhhblR2dG8z?=
 =?utf-8?B?U3dkQVZ6cnFheTQ5a1k2MmF6ek4wcGpLRytiWWd4UUorNWpiSWUwcmZXSTdX?=
 =?utf-8?B?TjROKzRmQW9kVTc5OFJ4VG1Mb1RUZit3TUU0MHVpMHZFUmVLcDBOWFBqVk14?=
 =?utf-8?B?SVd5WHVYTWlrWmtkSEk1eWF2OTNKRUtlMndWR2FpejM1Sy83UnQ3UzNWNXJE?=
 =?utf-8?B?Y2xlS0tkcjVORzRxZVNEMnBmRnVXbVhaWUdXL1FIbFkwWXZIWW5lSkdxQ01J?=
 =?utf-8?B?ditGWFIvcUFZZ3Bnb0cwNWpGOS9ibkdmZGdGN1NXekdOUEY5SGFtaUQwN0hq?=
 =?utf-8?B?N2lORm5FcTFZYlVpZHBYTE1tdVRrQ0dvL0ZKTUI1b05jUmhsL1E0SVBGL1NE?=
 =?utf-8?B?MDVPejhVcGpnQW9rS2NVcTJwMmpTY3o0bWt1ZDhrRVRhRnVZWXg1bmZkM3FO?=
 =?utf-8?B?Ymd1eG84dURyZmpLRzZyM0RueHk3L1B6Yk5DcjVocFhOSS9rQWVZeHUyNEhV?=
 =?utf-8?B?dlJkU1ZxSnFsalNTdmZzNnF6REs4eTFHekgydmxiY1pLdkIyUktmMUFpVERL?=
 =?utf-8?B?dE1qRldkVW9CZStENDF5U0dNb0RtQ21kOU5BYll4SmJWQUVOUDJjaWlZNHpT?=
 =?utf-8?B?UTBQWDQ0T3g0MGp0QzV2dDlFOWxJMGNaT0RiV0w2aHpnRENabGlKTW1xNysz?=
 =?utf-8?B?RFFGZVIvQXRXbjJjZDRwdDJvS1diV09iWXFrbm1LZnU3eVFQckl2N2ZENGRT?=
 =?utf-8?B?dTV5dFkzd3ZPSVA0L1V1cE5vYmk3K3RqOUNnSjFhOUV4Q2MvcWE3NTVsY2Zr?=
 =?utf-8?B?ZGFMRUxJaWsyQlcwbld1a2J0bGtOUVQxbFBvYXhTM3R0NTBrajRKQnB3dzR1?=
 =?utf-8?B?czByWU9ZMDRUSnN1Qm1nMGNwd1hsRzhyQlpuVGFCRDI0ZlA0aXgxQnZNTEFj?=
 =?utf-8?B?NlBrcFdWWXl1a3VOeTBsblNVb3Nobkdmdm5UKzFxcHRMdTd5SzlnYXJ2Q2JM?=
 =?utf-8?B?YWZ2bFFvSVI5QVV5Zmo0WXlJN3BIS29zcjNmaW1nb2Frelh6NGEwT2NZcFps?=
 =?utf-8?B?RDZqSTJia0ZvRGIrVys4RDZvNjhUY25oNEloWUxMcy9VZGRRZUtid1lmdWNU?=
 =?utf-8?B?R3BKMlpOc2RlWStrZTdqTnBONGtVZGJUd2N6U1h0cGduWVk1cms0My9tRmdI?=
 =?utf-8?B?anZkaHY5SlVjZkdKZ1g5VVBzSkFDY25XTm9RNG1abCt0VkxrSjBNTk5kZjhV?=
 =?utf-8?B?TWZkbTZMS2FsSVZOZWFGU0FXR2Y3M0FvamFlcm9iS3hXemwwenRWTk9saWdm?=
 =?utf-8?B?dnZsaDAwZE5SVzhrUGVkZGIxMnhCQkZNRUQyaWJ2L0xRL0NFU2wwTWZkQ2wy?=
 =?utf-8?B?cytMV05vTzVtcjF6NXRSZWJUd0tTMnNTcmRrRzVQeGhPei9hSXdGalJydU9q?=
 =?utf-8?Q?WoR9gQC13/767JYW0/JePW2oG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3d9048-fcf2-4b0d-3167-08dc86d4676e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 09:30:00.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVt5MuyTNP0S5rzZIpKeLLo1q8ZDA4x+RTBPGry1Ik96wwUUQOaa6NsBjUpXaEf5SVwkxkM+yuraiFX3+SG/Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE1heSAyNywgMjAyNCAxMjowNSBQTQ0KPiANCj4gQWRkIGlvcGYtY2FwYWJsZSBodyBwYWdl
IHRhYmxlIGF0dGFjaC9kZXRhY2gvcmVwbGFjZSBoZWxwZXJzLiBUaGUgcG9pbnRlcg0KPiB0byBp
b21tdWZkX2RldmljZSBpcyBzdG9yZWQgaW4gdGhlIGRvbWFpbiBhdHRhY2htZW50IGhhbmRsZSwg
c28gdGhhdCBpdA0KPiBjYW4gYmUgZWNobydlZCBiYWNrIGluIHRoZSBpb3BmX2dyb3VwLg0KDQp0
aGlzIG1lc3NhZ2UgbmVlZHMgYW4gdXBkYXRlLiBub3cgdGhlIGRldmljZSBwb2ludGVyIGlzIG5v
dCBpbiB0aGUNCmF0dGFjaCBoYW5kbGUuDQoNCmFuZCB0aGVyZSB3b3J0aHMgYSBleHBsYW5hdGlv
biBhYm91dCBWRiBpbiB0aGUgY29tbWl0IG1zZy4NCg0KPiBAQCAtMzc2LDcgKzM3NywxMCBAQCBp
bnQgaW9tbXVmZF9od19wYWdldGFibGVfYXR0YWNoKHN0cnVjdA0KPiBpb21tdWZkX2h3X3BhZ2V0
YWJsZSAqaHdwdCwNCj4gIAkgKiBhdHRhY2htZW50Lg0KPiAgCSAqLw0KPiAgCWlmIChsaXN0X2Vt
cHR5KCZpZGV2LT5pZ3JvdXAtPmRldmljZV9saXN0KSkgew0KPiAtCQlyYyA9IGlvbW11X2F0dGFj
aF9ncm91cChod3B0LT5kb21haW4sIGlkZXYtPmlncm91cC0+Z3JvdXApOw0KPiArCQlpZiAoaHdw
dC0+ZmF1bHQpDQo+ICsJCQlyYyA9IGlvbW11ZmRfZmF1bHRfZG9tYWluX2F0dGFjaF9kZXYoaHdw
dCwgaWRldik7DQo+ICsJCWVsc2UNCj4gKwkJCXJjID0gaW9tbXVfYXR0YWNoX2dyb3VwKGh3cHQt
PmRvbWFpbiwgaWRldi0NCj4gPmlncm91cC0+Z3JvdXApOw0KDQpEb2VzIGl0IHJlYWQgYmV0dGVy
IHRvIGhhdmUgYSBpb21tdWZkX2F0dGFjaF9kZXZpY2UoKSB3cmFwcGVyIHdpdGgNCmFib3ZlIGJy
YW5jaGVzIGhhbmRsZWQgaW50ZXJuYWxseT8NCg0KPiANCj4gK3N0YXRpYyBpbnQgaW9tbXVmZF9m
YXVsdF9pb3BmX2VuYWJsZShzdHJ1Y3QgaW9tbXVmZF9kZXZpY2UgKmlkZXYpDQo+ICt7DQo+ICsJ
c3RydWN0IGRldmljZSAqZGV2ID0gaWRldi0+ZGV2Ow0KPiArCWludCByZXQ7DQo+ICsNCj4gKwkv
Kg0KPiArCSAqIE9uY2Ugd2UgdHVybiBvbiBQQ0kvUFJJIHN1cHBvcnQgZm9yIFZGLCB0aGUgcmVz
cG9uc2UgZmFpbHVyZSBjb2RlDQo+ICsJICogY291bGQgbm90IGJlIGZvcndhcmRlZCB0byB0aGUg
aGFyZHdhcmUgZHVlIHRvIFBSSSBiZWluZyBhIHNoYXJlZA0KDQp5b3UgY291bGQgYnV0IGp1c3Qg
ZG9pbmcgc28gaXMgaW5jb3JyZWN0LiDwn5iKDQoNCnMvY291bGQvc2hvdWxkLw0KDQo+ICsJICog
cmVzb3VyY2UgYmV0d2VlbiBQRiBhbmQgVkZzLiBUaGVyZSBpcyBubyBjb29yZGluYXRpb24gZm9y
IHRoaXMNCj4gKwkgKiBzaGFyZWQgY2FwYWJpbGl0eS4gVGhpcyB3YWl0cyBmb3IgYSB2UFJJIHJl
c2V0IHRvIHJlY292ZXIuDQo+ICsJICovDQoNCnRoaXMgbWF5IGdvIGEgYml0IGZ1cnRoZXIgdG8g
dGFsayBhYm91dCBzdXBwb3J0aW5nIGl0IHJlcXVpcmVzIGFuIGVtdWxhdGlvbg0KaW4gaW9tbXVm
ZCAoaS5lLiBwYXVzZSBhbnkgZnVydGhlciBmYXVsdCBkZWxpdmVyeSB1bnRpbCB2UFJJIHJlc2V0
KS4gSXQgaXMgYQ0KZnV0dXJlIHdvcmsgc28gZGlzYWJsZSBpdCBmb3IgVkYgYXQgdGhpcyBwb2lu
dC4NCg0KPiArdm9pZCBpb21tdWZkX2ZhdWx0X2RvbWFpbl9kZXRhY2hfZGV2KHN0cnVjdCBpb21t
dWZkX2h3X3BhZ2V0YWJsZQ0KPiAqaHdwdCwNCj4gKwkJCQkgICAgIHN0cnVjdCBpb21tdWZkX2Rl
dmljZSAqaWRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgaW9tbXVmZF9hdHRhY2hfaGFuZGxlICpoYW5k
bGU7DQo+ICsNCj4gKwloYW5kbGUgPSBpb21tdWZkX2RldmljZV9nZXRfYXR0YWNoX2hhbmRsZShp
ZGV2KTsNCj4gKwlpb21tdV9kZXRhY2hfZ3JvdXBfaGFuZGxlKGh3cHQtPmRvbWFpbiwgaWRldi0+
aWdyb3VwLT5ncm91cCk7DQo+ICsJaW9tbXVmZF9hdXRvX3Jlc3BvbnNlX2ZhdWx0cyhod3B0LCBo
YW5kbGUpOw0KPiArCWlvbW11ZmRfZmF1bHRfaW9wZl9kaXNhYmxlKGlkZXYpOw0KPiArCWtmcmVl
KGhhbmRsZSk7DQoNCnRoaXMgYXNzdW1lcyB0aGF0IHRoZSBkZXRhY2ggY2FsbGJhY2sgb2YgdGhl
IGlvbW11IGRyaXZlciBuZWVkcyB0byBkcmFpbg0KaW4tZmx5IHBhZ2UgcmVxdWVzdHMgc28gbm8g
ZnVydGhlciByZWZlcmVuY2UgdG8gaGFuZGxlIG9yIHF1ZXVlIG5ldyByZXENCnRvIHRoZSBkZWxp
dmVyIHF1ZXVlIHdoZW4gaXQgcmV0dXJucywgb3RoZXJ3aXNlIHRoZXJlIGlzIGEgdXNlLWFmdGVy
LWZyZWUNCnJhY2Ugb3Igc3RhbGUgcmVxdWVzdHMgaW4gdGhlIGZhdWx0IHF1ZXVlIHdoaWNoIGF1
dG8gcmVzcG9uc2UgZG9lc24ndA0KY2xlYW5seSBoYW5kbGUuDQoNCmlpcmMgcHJldmlvdXMgZGlz
Y3Vzc2lvbiByZXZlYWxzIHRoYXQgb25seSBpbnRlbC1pb21tdSBkcml2ZXIgZ3VhcmFudGVlcw0K
dGhhdCBiZWhhdmlvci4gSW4gYW55IGNhc2UgdGhpcyBzaG91bGQgYmUgZG9jdW1lbnRlZCB0byBh
dm9pZCB0aGlzIGJlaW5nDQp1c2VkIGluIGEgbm9uLWNvbmZvcm1pbmcgaW9tbXUgZHJpdmVyLg0K
DQpJZiBJIG1pc3VuZGVyc3Rvb2QsIHNvbWUgY29tbWVudCB3aHkgbm8gcmFjZSBpbiB0aGlzIHdp
bmRvdyBpcyBhbHNvDQphcHByZWNpYXRlZC4g8J+Yig0KDQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBp
bnQgX19mYXVsdF9kb21haW5fcmVwbGFjZV9kZXYoc3RydWN0IGlvbW11ZmRfZGV2aWNlICppZGV2
LA0KPiArCQkJCSAgICAgIHN0cnVjdCBpb21tdWZkX2h3X3BhZ2V0YWJsZSAqaHdwdCwNCj4gKwkJ
CQkgICAgICBzdHJ1Y3QgaW9tbXVmZF9od19wYWdldGFibGUgKm9sZCkNCj4gK3sNCj4gKwlzdHJ1
Y3QgaW9tbXVmZF9hdHRhY2hfaGFuZGxlICpoYW5kbGUsICpjdXJyID0gTlVMTDsNCj4gKwlpbnQg
cmV0Ow0KPiArDQo+ICsJaWYgKG9sZC0+ZmF1bHQpDQo+ICsJCWN1cnIgPSBpb21tdWZkX2Rldmlj
ZV9nZXRfYXR0YWNoX2hhbmRsZShpZGV2KTsNCj4gKw0KPiArCWlmIChod3B0LT5mYXVsdCkgew0K
PiArCQloYW5kbGUgPSBremFsbG9jKHNpemVvZigqaGFuZGxlKSwgR0ZQX0tFUk5FTCk7DQo+ICsJ
CWlmICghaGFuZGxlKQ0KPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwkJaGFuZGxlLT5o
YW5kbGUuZG9tYWluID0gaHdwdC0+ZG9tYWluOw0KPiArCQloYW5kbGUtPmlkZXYgPSBpZGV2Ow0K
PiArCQlyZXQgPSBpb21tdV9yZXBsYWNlX2dyb3VwX2hhbmRsZShpZGV2LT5pZ3JvdXAtPmdyb3Vw
LA0KPiArCQkJCQkJIGh3cHQtPmRvbWFpbiwgJmhhbmRsZS0NCj4gPmhhbmRsZSk7DQo+ICsJfSBl
bHNlIHsNCj4gKwkJcmV0ID0gaW9tbXVfcmVwbGFjZV9ncm91cF9oYW5kbGUoaWRldi0+aWdyb3Vw
LT5ncm91cCwNCj4gKwkJCQkJCSBod3B0LT5kb21haW4sIE5VTEwpOw0KPiArCX0NCj4gKw0KPiAr
CWlmICghcmV0ICYmIGN1cnIpIHsNCj4gKwkJaW9tbXVmZF9hdXRvX3Jlc3BvbnNlX2ZhdWx0cyhv
bGQsIGN1cnIpOw0KPiArCQlrZnJlZShjdXJyKTsNCj4gKwl9DQoNCkluIGxhc3QgdmVyc2lvbiB5
b3Ugc2FpZCBhdXRvIHJlc3BvbnNlIGlzIHJlcXVpcmVkIG9ubHkgd2hlbiBzd2l0Y2hpbmcNCmZy
b20gZmF1bHQtY2FwYWJsZSBvbGQgdG8gZmF1bHQtaW5jYXBhYmxlIG5ldy4gQnV0IGFib3ZlIGNv
ZGUgZG9lc24ndA0KcmVmbGVjdCB0aGF0IGRlc2NyaXB0aW9uPw0K
