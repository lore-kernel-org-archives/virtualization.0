Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4C3DAADB;
	Thu, 27 Aug 2026 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818713; cv=fail; b=EobhvrfB5KRGLJjQr2hHTc0Ss/xpL7Jia3WIue4ixQAn100uMbc62E2jxbjrjX0CttR9s1TjbR8ukIN5YBe4b+XBje8LX6bTXtCu3Z3FFarLx0I3cIolXYDUfn1xc3e15ed7zrIazrdr7y0nwtc8mr3vxeiBuXwq/GTnpeDRBF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818713; c=relaxed/simple;
	bh=NNkrpsqzzwJQgR1UsT6qL5uS4hm6AHhbaYSX6nm2WEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oYnbLRI21vuRmHL1/mOSSboAss30pv2oL97/JHFqsxLEGGl8dzctzApxLMcYTVr2UF6lfJIWOHQfaDnMpyzz4otUj8Rb3meyXpoknCH23jrDmn+Mw67Z+XeQrXbaJ6VRWSEksGrZxV3WT+u9ZxQ4f1NpAil7X+SjyW/geFXGLNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/RFPXOh; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/RFPXOh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787818711; x=1819354711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NNkrpsqzzwJQgR1UsT6qL5uS4hm6AHhbaYSX6nm2WEY=;
  b=Y/RFPXOhilTnTxB/nIw8mtEVisn1anlfgRKUwV5f3fxpM+DQUyfWyp2Q
   OSBIeUHak004cSOXMtqTmwcEQSBzY2bscMA5ST4o4zv7sgJ/itj5g0R3T
   HtgkQMeZuPp1KIL776O6ZwQaz5wx8Nv3v1yDHkZEo7J/ZJw+ZGDpvvgBt
   +8elKtO+vzLjnkJAKkfZWRwz5JWO2M9WqY+nQOONNmFpyQrC/7HIC9tme
   jyKZIlHcKyJk9oh5P/uxNOyQ7BJXdIGF1BOw4sq3K7m3bb7qPiKoXSk6a
   X0wy6orXl/Rweq0KP6LtSXvyIofF3FW2N2OQxVSCUq6uReWWvaNZvNH8q
   A==;
X-CSE-ConnectionGUID: B5GBlMJ0RPamQwMD4ufMcg==
X-CSE-MsgGUID: he3PhgQAQU2wYUGenAv+uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="91998698"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="91998698"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 01:18:29 -0700
X-CSE-ConnectionGUID: QsPk2jrmSGuxEZl8oroQEg==
X-CSE-MsgGUID: FEu3+0SkQEeUJxBVVGFNBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="263535565"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 01:18:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 01:18:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 01:18:29 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.12) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 01:18:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNxpJ8rz+baavmM1qLFT5CAUZjBANk4/37inVcfM+X0WC1BF5oTZxfrwTYUwnRJn1N7fU2oJMyvRM9olnbPFP3vtQiRUTpvGJShH8JNOIim5KsZMqLuMgijMtK5Vx4ybzjy9siBRRW35Fk+9UE3t5FhT+f73pTrTXwZ0qxjVQJcfwfWMxpehmjHnYukEMLWWpVjT3kPaEpa2rRljK+4/Ck5TirY8+Rf/6F/sho5LopTA9nl4Q2ve6Qci0W0LQ7LFETVtKmjZqDL2y9moXRNYqoFNkXw51awlNq4ohDuwU66ZCJ4URzg5ZqBb2P0jN5eneZZGrTvCDR1fy5eY+tcaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNkrpsqzzwJQgR1UsT6qL5uS4hm6AHhbaYSX6nm2WEY=;
 b=biWWRLqTHzeCGVtwwwkq6HmOoWzxgRTGAwNLwu3ubQWXXnd8Vl4ZwUoz5224xOjWVlt+6kN8SKJUxhG5coq6dySQtwOQ/Uk+wI4gYXb96rC9ipQ1jIwpWHzFUquPRf7nOm5d1I+ujzl2sAqo68pQpYcdlz5VqDUsF7QBMCtTKnY7M73t0g4R8rdgovT2J1QsfiPrqAYsTPmRkIlAcwPwJ7Zg1Mt3l9WD15pCGawF7wjhLcPgU6umEmbD1wXH/FJowOPgMoAs/0ZM/sGxgwTc2csj//yrpmQzUUVon8l+qoX3KJQOEINTMZBlX9A5ynJEz8UYEv//CVp3bUsqPV6Ypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 08:18:23 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0339.007; Thu, 27 Aug 2026
 08:18:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
	"marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"prsampat@amd.com" <prsampat@amd.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>, "Reshetova,
 Elena" <elena.reshetova@intel.com>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "ackerleytng@google.com" <ackerleytng@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [RFCv2 PATCH 0/6] Support memory hotplug/unplug for TDX CoCo
 guests
Thread-Topic: [RFCv2 PATCH 0/6] Support memory hotplug/unplug for TDX CoCo
 guests
Thread-Index: AQHdNU8sgiI1VAhrvE6ho6EbTj9SYbaxY/AQ
Date: Thu, 27 Aug 2026 08:18:21 +0000
Message-ID: <IA3PR11MB91365F3F771C43C4BA7E61B392AD2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
 <5921ace1-219d-4947-99d9-13b56e1ec6fa@kernel.org>
In-Reply-To: <5921ace1-219d-4947-99d9-13b56e1ec6fa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|LV3PR11MB8579:EE_
x-ms-office365-filtering-correlation-id: 89d4f723-bd29-4a34-b2d8-08df0413c1e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|6133799003|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|921020|38070700021;
x-microsoft-antispam-message-info: NQqeHMz8csD5bh2SOhw8vGW9wMj+6LOIKAW41csrSVYj9hiylN0lJRRNRDw6/887saszfk4yZzTuoytzrf4dv57w61anhzaghxgIrGDZ6i5bqKBhf+mQTUG9ypsSkhmV5YaRzZf6Sq5QiVsby3aQ8fmvx1GZ7awzq0VUZWJAEaP+0neScvugJ/L9Uee+OXO+HNHRt0OCHEZ5mXMIAYQhmdjBHzNaORGV0jmfCL6ymxMIE3C10hsH/4wpOEXAGpe5RyMGbUMVe4uWxIfRFxJXnTBbhRvW84DNoNR3Sl+RJf3Cuap7Afc0KEM30XVPC+SCxfRQBUabZQ8O3q9O/gnjJbTziQcqX6+XCo+lDyzsAvcA6REmlr2lJSRE74mASPerobuhQg/wOLwKYJTK6bC1ld+jZ2VFni90HfJAwESzALyMP4TPLwHpJfq35CEYAo1HdBufrXt1eH4j3sKgaWw/625z2ljgl5WFKFYk/R0P79kp3wHZYjybUEmr/USu1neUPGOLH/+D5Rhbzug0SpMfCy8Vbo+Jrp3keVLnlcGA9DXC9e3QcxfcoAo02W5rhUWEkoW2f2Omf3gdfUT1qGHGfwoBH/VKO/LP7E/rNplwjqGAjvLvgpY48UXzf+6hkXWAspBg735LHVc1Mr9QyWQRMg4vKO1LPA78rOI3Ie/mcol0m+XOdHI+TbI+No22OXzvmDAWdHZlEf6/zIGG3Oc63rZljDfFZEIUh3qC/wwlpCu+g3noKQyFLxOzarkltFvS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHNNWWwzR0h0dG1jK3JPSlRZRWZhWFhwWXBzMkxTMzRTbHdkWkZIU1U0Zm43?=
 =?utf-8?B?NTlMVFRsU1J4Slh3NDVaZXVEK1p3a0lCVDJFWkVZV0V2Vmd0bzRUcnZSUUIz?=
 =?utf-8?B?YnllY3FnYjlVa2RQaERQUVhqckhWODB4cnk1Q0JSaWZqMVhxckcxZ2RTUDh5?=
 =?utf-8?B?REM4aHFnZDJpTmZ3WVJxcUR6akJaYmxTcDBhNVBPb01KVnlyNU9hUDFtYzBM?=
 =?utf-8?B?WGEyNWpGb2Rianh4TnpuQTBwU3lmN21MTXVzV3BsY2lJYXpVeWFiZ29xYzhr?=
 =?utf-8?B?TDc0MUI3dmRkbjkvVm5rYzZscXJ5OFZpbFo0L21LYTRjWEQyclR1cHFPSHRL?=
 =?utf-8?B?Qm1UTTNEdWJZSUNxZm9PSHVIM3ErUi8rMTV1YUNJc05XcEI0ZWd0Ukg5MW5H?=
 =?utf-8?B?cUJCNmgrT0p1bFU4ZVZwMVI4aGQ1clp5ZVdXSU92NXZxckNKSFRpNzlOa0xM?=
 =?utf-8?B?Ukd2ckZhVjJaUW9oblh5b09qaVpRdVRISVhhUHBQRm02ZDMvdG8vU0daTFdL?=
 =?utf-8?B?TGFTUzZKcnhscXVsYU8rRFBKYkNhMTJCM2pTa0V1STloVFBJZlRYeXkwNnhX?=
 =?utf-8?B?YjBxQlNuZmlQejBYSVhTTmZGUnFVUzh6YXRjTzBxYXdYRkVnTUY0Y2FuS1B0?=
 =?utf-8?B?Q0RmcFFCMFloMHZDMWRXTFZzZ2Z5SXR4Q3lNdmMvS0k3cWlGUnJ5L3lZYmdz?=
 =?utf-8?B?OEtlU3VqbGU0eGVVMXhEcGNVN1NFOVZVSlppdXhITGZCbWF2WlZOQzM0aXY4?=
 =?utf-8?B?NXNWLzNiWHVqeUcxQjBtcFlMUE5oSkNXaHhrN29pUGd2WnIxck1JTVczRUJR?=
 =?utf-8?B?NnJ6MEs0b1Y5WFIyRzZPREFwZDFmeGRMUFlMSVh3WkVSTnE0WmZ1U29sZU4x?=
 =?utf-8?B?RFB4dXpHTEo2T1EzbEsxUUZ4TURXMmZObVg5UGYwNFVCdkIvcDczMjFZK1RG?=
 =?utf-8?B?NFlPelJzd1J5TXd5WkZCVWVncHB3d01ZZWV1TnhzYytxaWlScGRlRGJzdHJ4?=
 =?utf-8?B?bUthNERkYkppeVFGM25HaVJqZ3lHWU5IbzU4UXU3U1RCSThPWEE5d1FiaHhL?=
 =?utf-8?B?Mjl5ZExPNUpOQXFRbFBaVmQweUpDU3lDSk5TRm1kekpET0U3YUZ4cm84RHlZ?=
 =?utf-8?B?NGx5WnQwTmxnN2krekxSTnZDNkE1L1BudlJiU0ZYZ1ZFcDRpcjNpQ2VydmNH?=
 =?utf-8?B?dlhjbTRXYmlDbWtMTTRUSmtrV1l4N1VCZWZ2S3dJY25VNStFR1dzNnExa0Fh?=
 =?utf-8?B?WmFXalB0VkZxaUJqdlhieUx2ZEhFODZjQU5EWVBxMmRPK1VLRzltNjBqdW5C?=
 =?utf-8?B?NnczNjNYZUNYSFYvOEdHUkZ6SWRDeGlaQ0hKYnVIV1M0RzF0WXJKUzlnVTRL?=
 =?utf-8?B?Y0NXNWdHbllyR2Vkb2hmWnk5L1A3SzNOTjhuSEFiQjgwZEJ5TkpuV0s2aGRD?=
 =?utf-8?B?YUxkdVduelY0eGdGM0ZyWFJvSGt5WXM2Q2pJK0doeWxMY1h6dUYvcDJRUVJ6?=
 =?utf-8?B?OHRUOWtadEFwMHc5d3dPZW5MV2pjYmozOWF3Z29McGNMNzIzeDhPMDhhWG9V?=
 =?utf-8?B?U0xobzJiTXpwMXFveDVLOWxVUkxEWWN1STVoM0xQRXNvVVprb2MvbnVvVkJs?=
 =?utf-8?B?N3hMdmZicjhqaCtDTUdSRlVwMEpkTExsQ3dZZEQvbU14Lzh4VGxVL1IwM0Jz?=
 =?utf-8?B?UWZidk9BZEVHaWF6U3lpYTc3S25ndUdmNk52Tm1Bd2NpSFZaTEM3eWhOREoz?=
 =?utf-8?B?S2lJRVNKcjRlQmlsN2pSUFIxRHhTNStTbzhrMS85a3FKRnFKQUpnS2xlQXB4?=
 =?utf-8?B?eVlpS09uTzVST0hvZVVQWWx6ek1kWkxVQXdvMGFLTmhsajRLRldWa3BGQzhn?=
 =?utf-8?B?RFh3RTZaSFVwbmgvcTA5OHZGN25Ga2FNbHBWcXc2QkJDa01xTENQQlkwWWxG?=
 =?utf-8?B?d1dNQldlU0RxbGJHU3ZGRkI4M1M0aUl3V3ZNNnl3aGFLK3lFSEFyVGo1TTJG?=
 =?utf-8?B?cW5PZWpSYU1lQzlnaU5wRGVudnR1ekZ1OW4rUkFUak9vNTZoL1pURTBTTlRK?=
 =?utf-8?B?YnBZNW1ldDJJRlIwN3F5c2Q1anp0Znp0N05BbzVzVlFnRUhiNTdnb2lDN0Q3?=
 =?utf-8?B?cE4wWEIrR2U3NUd0bG0yQWtndkdPZ2hWYlkrRDAwekZUK01BLzVqZFRrWE8x?=
 =?utf-8?B?eFJGdFRiQm9yMkkvMmdLSEd5WUprNTdhSXErSUhLZ2w2RTBleVFwMGVTN0ov?=
 =?utf-8?B?RmNTc2V5dnl6amZiazJNL2EvVmRvN2k1cFRxWENvOUdYOHB2SVpkSi9rMHFH?=
 =?utf-8?B?TEJ5QWErdDBwbzlEMERheEZBYlNFOE9acWt0T0ZuOVA2ZkRMWmdsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mglJ9uxiUmKFznXvFbGBtBuYcksRzql67z4cMOqQmAOLYU0UzwPwgdb4R5S8AhfPHJ7Ltk83ThDsEZ/9sNGlfWypZWohhlZCNkN+/aKOu1toAsjWun64EQX56ZgDLwDSoeq+e8m6x01Cg0kvuhgXaUebCGiyqjMPgcz64hxYNnf7gcc2sv4xbfM7eAaJMOn1HtFzIw9hh4Bi+QKLw9FRLdXO4BbhX/RNxrqz0aMa2eCV6DB0S7dca7iTvomVDIsODsrVV0FLSJgwaMHC3bHmmzdVgYRWR587b5OkwAJRf6MOc61WO62VODeSZVuhI+Oot46SXzXVB1cotgRGdjc9CQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d4f723-bd29-4a34-b2d8-08df0413c1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 08:18:21.3723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNo/ZbERyeDIxeCRDdFmChYaxAOvtIil9Qm77jkdRrRW/DvvZYMs2tQP8f0nN9kGsmk9Gmd37Zog4sc8WvNiwFvo0GIlL7Il686t76br+Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhdmlkIEhpbGRlbmJyYW5k
IChBcm0pIDxkYXZpZEBrZXJuZWwub3JnPg0KPlN1YmplY3Q6IFJlOiBbUkZDdjIgUEFUQ0ggMC82
XSBTdXBwb3J0IG1lbW9yeSBob3RwbHVnL3VucGx1ZyBmb3IgVERYIENvQ28NCj5ndWVzdHMNCj4N
Cj5PbiA2LzIzLzI2IDEyOjE3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFRoaXMgUkZDdjIg
c2VyaWVzIGltcGxlbWVudHMgY29tcHJlaGVuc2l2ZSBzdXBwb3J0IGZvciB2aXJ0aW8tbWVtIGFu
ZCBBQ1BJDQo+PiBESU1NIG1lbW9yeSBob3RwbHVnL3VucGx1ZyBpbiBJbnRlbCBURFggY29uZmlk
ZW50aWFsIGNvbXB1dGluZyBndWVzdHMuDQo+PiBJdCBleHBsb3JlcyB0aGUgc3RhcnQtcHJpdmF0
ZSBtZW1vcnkgYXBwcm9hY2ggdXRpbGl6aW5nIHRoZSBuYXRpdmUNCj4+IFRERy5NRU0uUEFHRS5S
RUxFQVNFIEFQSS4NCj4+DQo+PiBXZSBhcmUgc2Vla2luZyBmZWVkYmFjayBmcm9tIEtpcnlsIG9u
IHRoZSBDb0NvIGd1ZXN0IGltcGxlbWVudGF0aW9uLCBNTQ0KPj4gZXhwZXJ0cyBvbiBESU1NICYg
dmlyaW8tbWVtIG1lbW9yeSBob3RwbHVnIGludGVncmF0aW9uIGFuZCBicm9hZGVyDQo+PiB2aXJ0
aW8vQ29DbyBjb21tdW5pdHkgaW5wdXQgb24gdGhlIG92ZXJhbGwgYXBwcm9hY2guIFdlIGFyZSBu
b3Qgc2Vla2luZw0KPj4geDg2IG1haW50YWluZXIgcmV2aWV3IGF0IHRoaXMgc3RhZ2UuDQo+Pg0K
Pj4gPT0gQ2hhbmdlcyBmcm9tIFJGQyB2MSA9PQ0KPj4NCj4+IC0gRWxpbWluYXRlZCBjYWxsYmFj
ayBpbmZyYXN0cnVjdHVyZTogRHJvcHBlZCBwbHVnIGNhbGxiYWNrIGFuZCByZXBsYWNlZA0KPj4g
ICB1bnBsdWcgY2FsbGJhY2sgd2l0aCBwbGF0Zm9ybS1sZXZlbCB1bmFjY2VwdCBmdW5jdGlvbiBp
bnRvIGNvcmUgTU0NCj4+ICAgaG90cGx1ZyBhbmQgdmlydGlvLW1lbSBzdWJzeXN0ZW1zLg0KPj4g
LSBBZGRlZCBjb21wcmVoZW5zaXZlIGJpdG1hcCB0cmFja2luZzogSW50cm9kdWNlZCBhICJwbHVn
Z2VkIiBiaXRtYXANCj4+ICAgYWxvbmdzaWRlIHRoZSB1bmFjY2VwdGVkIGJpdG1hcCB0byB0cmFj
ayBwb3B1bGF0ZWQgaG90cGx1ZyBtZW1vcnkNCj4+ICAgc3RhdGVzIHRvIHN1cHBvcnQgbG9hZF91
bmFsaWduZWRfemVyb3BhZCgpLg0KPj4gLSBFbmhhbmNlZCBTUkFUIHBhcnNpbmc6IEV4dGVuZGVk
IHRoZSBFRkkgc3R1YiB0byBwYXJzZSBBQ1BJIFNSQVQgdGFibGVzDQo+PiAgIGVhcmx5LCBlbnN1
cmluZyBob3RwbHVnZ2FibGUgcmFuZ2VzIGFyZSB0cmFja2VkIGZyb20gaW5pdGlhbCBib290Lg0K
Pj4NCj4+IEZvciBtb3JlIGludHJvZHVjdGlvbiBhYm91dCB0aGUgYmFja2dyb3VuZCBvciBvdGhl
ciBlZmZvcnRzIGluIGNvbW11bml0eSwNCj4+IHBsZWFzZSBjaGVjayB0aGUgUkZDdjEgY292ZXIg
bGV0dGVyIFsxXS4NCj4+DQo+PiA9PSBUZWNobmljYWwgQXBwcm9hY2ggPT0NCj4+DQo+PiAtIEVh
cmx5IFNSQVQgSW50ZWdyYXRpb246IEEgbGlnaHR3ZWlnaHQgRUZJIHN0dWIgcGFyc2VyIHNjYW5z
IEFDUEkgU1JBVA0KPj4gICB0YWJsZXMgdG8gaWRlbnRpZnkgaG90cGx1Z2dhYmxlIHJhbmdlcyBh
bmQgYWRqdXN0IGJpdG1hcCBib3VuZGFyaWVzDQo+PiAgIGVhcmx5LCBhdm9pZGluZyB0aGUgb3Zl
cmhlYWQgb2YgdGhlIGZ1bGwgQUNQSSBzdWJzeXN0ZW0uDQo+PiAtIENvbXByZWhlbnNpdmUgQml0
bWFwIFRyYWNraW5nOiBJbnRyb2R1Y2VzIGEgInBsdWdnZWQiIGJpdG1hcCByaWdodA0KPj4gICBh
ZnRlciB0aGUgdW5hY2NlcHRlZCBiaXRtYXAuIEJvdGggc3RhdGljIGFuZCBob3RwbHVnZ2VkIG1l
bW9yeSBhcmUNCj4+ICAgdHJhY2tlZCwgYWxsb3dpbmcgdGhlIGd1ZXN0IHRvIG1hcCB3aGljaCBy
YW5nZXMgYXJlIHBvcHVsYXRlZCBieSB0aGUNCj4+ICAgVk1NLiBUaGlzIHByZXZlbnRzIGFjY2Vw
dGFuY2UgYmV5b25kIHBsdWdnZWQgbWVtb3J5IGJvdW5kYXJpZXMgZHVlIHRvDQo+PiAgIGxvYWRf
dW5hbGlnbmVkX3plcm9wYWQoKSBvcGVyYXRpb25zLg0KPj4gLSBQbGF0Zm9ybSBFeHRlbnNpYmls
aXR5OiBFeHBvc2VzIGdlbmVyaWMgQ29DbyBtZW1vcnkgaW50ZXJmYWNlcy4gT3RoZXINCj4+ICAg
Y29uZmlkZW50aWFsIHBsYXRmb3JtcyAobGlrZSBBTUQgU0VWLVNOUCkgY2FuIGVhc2lseSBhZG9w
dCB0aGlzIGJ5DQo+PiAgIGhvb2tpbmcgdGhlaXIgc3BlY2lmaWMgbWVjaGFuaXNtcyBpbnRvIGFy
Y2hfdW5hY2NlcHRfbWVtb3J5KCkuDQo+PiAtIEhvdHBsdWcgJiBHdWVzdCBDb250cm9sOiBJbnRl
Z3JhdGVzIHBsYXRmb3JtLWxldmVsIHVuYWNjZXB0IGxvZ2ljDQo+PiAgIGludG8gQUNQSSBob3Rw
bHVnIGFuZCB2aXJ0aW8tbWVtIGhhbmRsZXJzLiBVc2VzIFRERy5NRU0uUEFHRS5SRUxFQVNFDQo+
PiAgIGZvciBURFggdG8gZXhwbGljaXRseSBzZXQgbWVtb3J5IHRvIHRoZSAidW5hY2NlcHRlZCIg
c3RhdGUgZHVyaW5nDQo+PiAgIHVucGx1ZywgcmVtb3ZpbmcgaG9zdCBob2xlLXB1bmNoaW5nIGRl
cGVuZGVuY2llcy4NCj4+IC0gS2V4ZWMgSGFuZG92ZXI6IExldmVyYWdlcyBleGlzdGluZyBFRkkg
bWVjaGFuaXNtcyB0byBzZWFtbGVzc2x5IGhhbmQNCj4+ICAgb3ZlciBib3RoIHRoZSBleHRlbmRl
ZCB1bmFjY2VwdGVkIGJpdG1hcCBhbmQgdGhlIG5ldyBwbHVnZ2VkIGJpdG1hcA0KPj4gICBhY3Jv
c3Mga2V4ZWMgYm91bmRhcmllcy4NCj4+DQo+PiA9PSBUZXN0aW5nID09DQo+Pg0KPj4gLSBkaW1t
IGFuZCB2aXJ0aW8tbWVtIG1lbW9yeSBob3RwbHVnL3VucGx1Zw0KPj4gLSBsYXp5IGFuZCBlYWdl
ciBhY2NlcHQNCj4+IC0ga2V4ZWMva2R1bXAgd2l0aCBob3RwbHVnZ2VkIG1lbW9yeQ0KPj4NCj4+
IFRoaXMgaXMgdGVzdGVkIHdpdGggTWFyYy1BbmRyw6kgTHVyZWF1J3MgbmV3ZXN0IHFlbXUgc2Vy
aWVzIFsyXQ0KPg0KPldoYXQncyB0aGUgc3RhdHVzIG9mIHRoaXM/DQoNCk1hcmMncyBRRU1VIHNl
cmllcyBpcyBtZXJnZWQuDQpGb3IgdGhpcyBzZXJpZXMsIGZvbGxvd2luZyBmZWVkYmFjayBmcm9t
IEtpcmlsbCBhbmQgUHJhdGlrLCB0aGUgcHJlZmVycmVkIGFwcHJvYWNoDQppcyB1cGRhdGluZyB0
aGUgVUVGSSBzcGVjIGZvciBob3RwbHVnIG1lbW9yeSByYW5nZXMgcmF0aGVyIHRoYW4gcGFyc2lu
ZyBTUkFUDQphdCB0aGUgRUZJIHN0YWdlLiBQcmF0aWsgaXMgYWxyZWFkeSBwdXNoaW5nIHRoaXMg
Zm9yd2FyZCwgSSBhbSBjdXJyZW50bHkgd2FpdGluZyBvbg0KaGlzIFJGQ3MuIElmIGhlIGhhc24n
dCB0YWtlbiBvdmVyIHRoZSBlbnRpcmUgaW1wbGVtZW50YXRpb24sIEkgY2FuIHJlYmFzZSBteQ0K
cmVtYWluaW5nIHBhdGNoZXMgb24gdG9wIG9mIGhpcyB3b3JrLg0KDQpIaSBQcmF0aWssIGhhdmUg
eW91IHNlbnQgeW91ciBVRUZJIFJGQyBvdXQgeWV0PyBKdXN0IHdhbnRlZCB0byBtYWtlIHN1cmUN
CkkgZGlkbid0IG1pc3MgeW91ciB0aHJlYWQuDQoNCj4NCj5JIGFtIHN0aWxsIG5vdCBzdXJlIHdo
ZXRoZXIgd2Ugc2hvdWxkbid0IHBlcmZvcm0gYWNjZXB0YW5jZSBmcm9tDQo+bW92ZV9wZm5fcmFu
Z2VfdG9fem9uZSgpIGFuZCBmcm9tIG1lbW9yeSBub3RpZmllcnMgLyBnZW5lcmljX29ubGluZV9w
YWdlLg0KDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgd2UgYWxyZWFkeSBoYXZlIGZ1bGwgc3Vw
cG9ydCBmb3IgbGF6eSBhbmQgZWFnZXIgYWNjZXB0YW5jZQ0KaW4gZ2VuZXJpY19vbmxpbmVfcGFn
ZSgpIGZvciBzdGF0aWMgbWVtb3J5LiBXZSBzaG91bGQgYmUgYWJsZSB0byByZXVzZSB0aGF0IGZv
cg0KaG90cGx1ZyBtZW1vcnkgYW5kIGF2b2lkIGFkZGluZyBhY2NlcHRhbmNlIGxvZ2ljIGluIG90
aGVyIHBsYWNlcy4NCg0KQWxsIHdlIG5lZWQgaXMgZXh0ZW5kaW5nIHVuYWNjZXB0X2JpdG1hcCBh
bmQgYWRkaW5nIG5ldyBwbHVnZ2VkX2JpdG1hcCB0byBzdXBwb3J0DQpob3RwbHVnIG1lbW9yeS4g
SSB1cGRhdGVkIGFjY2VwdF9tZW1vcnkoKSB0byBjaGVjayBib3RoIGJpdG1hcHMgdG8gZGV0ZXJt
aW5lDQp3aGljaCBtZW1vcnkgc2hvdWxkIGJlIGFjY2VwdGVkLg0KDQo+DQo+SW4gcGFydGljdWxh
ciwgaXQncyB1bmNsZWFyIHRvIG1lIGhvdyB2aXJ0aW8tbWVtICh3aGljaCB1c2VzIGludGVyZmFj
ZXMgdG8NCj5hZGQvcmVtb3ZlIG1lbW9yeSkgaW50ZXJhY3RzIHdpdGggdW5hY2NlcHRfbWVtb3J5
IC8gY29jbyBiaXRtYXAuDQoNCkl0IHdvcmtzIHRoZSBzYW1lIHdheSBhcyBhIHBoeXNpY2FsIERJ
TU06IHdoZW4gbWVtb3J5IGlzIHBsdWdnZWQsIHRoZQ0KY29ycmVzcG9uZGluZyBiaXRzIGluIHBs
dWdnZWRfYml0bWFwIGFyZSBzZXQsIGFuZCB2aWNlIHZlcnNhLg0KDQpNZW1vcnkgYWNjZXB0YW5j
ZSBpcyBhbHJlYWR5IGhhbmRsZWQgaW4gZ2VuZXJpY19vbmxpbmVfcGFnZSgpLCBzbyB3ZSANCmRv
IG5vdCBuZWVkIHRvIGRvIGl0IGluc2lkZSB2aXJ0aW8tbWVtLiBIb3dldmVyLCB3ZSBkbyBuZWVk
IHRvIGNhbGwNCnVuYWNjZXB0X21lbW9yeSgpIGR1cmluZyBhIG1lbW9yeSB1bnBsdWcgZXZlbnQg
aW4gdmlydGlvLW1lbS4NCg0KQ3VycmVudGx5LCB0ZHhfdW5hY2NlcHRfbWVtb3J5KCkgY2FuIGFj
dCBhcyBhIG5vLW9wIHNpbmNlIFFFTVUgaGFuZGxlcyANCmhvbGUtcHVuY2hpbmcgdGhlIHByaXZh
dGUgbWVtb3J5LiBUaGF0IHNhaWQsIHdlIHN0aWxsIG5lZWQgdG8gaW52b2tlIA0KdW5hY2NlcHRf
bWVtb3J5KCkgdG8gcHJvcGVybHkgdXBkYXRlIHRoZSB1bmFjY2VwdF9iaXRtYXAgYml0cy4NCg0K
Pg0KPkNhbiB3ZSBoYXZlIGFuIG92ZXJhbGwgZGVzaWduIHZpZXcgb24gd2hhdCBoYXBwZW5zIGF0
IHdoaWNoIHN0YWdlIHdoZW4gYWRkaW5nDQo+Lw0KPnJlbW92aW5nIG1lbW9yeSB0aHJvdWdoIHZp
cnRpby1tZW0/DQoNCkkgaGF2ZSBwdXQgdG9nZXRoZXIgYSBkZXNpZ24gdmlldyBzdW1tYXJ5IGZv
ciB2aXJ0aW8tbWVtIGJlbG93Lg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoaXMgbG9va3MgY29y
cmVjdCBvciBpZiB3ZSBzaG91bGQgYWRqdXN0IHRoZSBmcmFtaW5nLg0KDQpEZXNpZ24gT3ZlcnZp
ZXcNCi0tLS0tLS0tLS0tLS0tLQ0KV2UgbWFpbnRhaW4gc3lzdGVtIHN0YWJpbGl0eSBhbmQgc3Rh
dGUgc2FmZXR5IHVzaW5nIHR3byBtZXRhZGF0YSB0cmFja2luZw0KbGF5ZXJzIGR1cmluZyBkeW5h
bWljIG1lbW9yeSByZXNpemluZyBvcGVyYXRpb25zOg0KMS4gcGx1Z2dlZF9iaXRtYXA6IEV4cGxp
Y2l0bHkgdHJhY2tzIGJsb2NrcyBwbHVnZ2VkIGludG8gdGhlIGd1ZXN0Lg0KICAgVGhpcyBwcm90
ZWN0cyBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCkgZnJvbSByZWFkaW5nIG9taXR0ZWQgbWVtb3J5
DQogICBob2xlcywgcHJldmVudGluZyBjYXRhc3Ryb3BoaWMgZ3Vlc3QgY3Jhc2hlcy4NCjIuIHVu
YWNjZXB0X2JpdG1hcDogRXhwbGljaXRseSB0cmFja3MgdGhlIHNlY3VyZSBwYWdlIGluaXRpYWxp
emF0aW9uIHN0YXRlLg0KDQpTdGVwLWJ5LVN0ZXAgTGlmZWN5Y2xlIFN0YWdlcw0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NClVzaW5nIHN1Yi1ibG9jayBob3RwbHVnIG9mIGEgbmV3IG1l
bW9yeSBibG9jayB3aXRoIGVhZ2VyIGFjY2VwdGFuY2UNCmFzIGFuIGV4YW1wbGU6DQoNCjEuIE1l
bW9yeSBBZGRpdGlvbiAoUGx1ZykgU3RhZ2UNCiAgIGEuIEhvc3Qgbm90aWZpZXMgZ3Vlc3QgLT4g
dmlydGlvLW1lbSBkcml2ZXIgaGFuZGxlcyB0aGUgcGx1ZyBldmVudC4NCiAgIGIuIERyaXZlciBt
YXJrcyB0aGUgYWxsb2NhdGVkIG1lbW9yeSByYW5nZXMgaW4gJ3BsdWdnZWRfYml0bWFwJyBieQ0K
ICAgICAgY2FsbGluZyBjb2NvX3NldF9wbHVnZ2VkX2JpdG1hcChhZGRyLCBzaXplLCB0cnVlKS4g
RHVyaW5nIHRoaXMgc3RhZ2UsDQogICAgICBhIHBsdWcgcmVxdWVzdCBpcyBhbHNvIHNlbnQgdG8g
dGhlIFZNTS4NCiAgIGMuIERyaXZlciBhZGRzIG1lbW9yeSBibG9ja3MgdmlhIGFkZF9tZW1vcnlf
cmVzb3VyY2UoKS4NCiAgIGQuIFN1YnN5c3RlbSB0cmlnZ2VycyBvbmxpbmUgLT4gZHJpdmVyIGNh
bGxiYWNrIHJ1bnMgZ2VuZXJpY19vbmxpbmVfcGFnZSgpLg0KICAgZS4gZ2VuZXJpY19vbmxpbmVf
cGFnZSgpIGNyb3NzLXJlZmVyZW5jZXMgJ3BsdWdnZWRfYml0bWFwJyBhbmQNCiAgICAgICd1bmFj
Y2VwdF9iaXRtYXAnIHRvIGV4ZWN1dGUgc2VjdXJlIHBhZ2UgYWNjZXB0YW5jZSAoZS5nLiwNCiAg
ICAgIFRERy5NRU0uUEFHRS5BQ0NFUFQpLg0KICAgZi4gRnJlc2hseSBhY2NlcHRlZCBwYWdlcyBh
cmUgZnJlZWQgZGlyZWN0bHkgaW50byB0aGUgYnVkZHkgYWxsb2NhdG9yLg0KDQoyLiBNZW1vcnkg
UmVtb3ZhbCAoVW5wbHVnKSBTdGFnZQ0KICAgYS4gSG9zdCByZXF1ZXN0cyBtZW1vcnkgcmVjbGFt
YXRpb24gLT4gdmlydGlvLW1lbSB0YXJnZXRzIHRoZSByYW5nZS4NCiAgIGIuIFBhZ2VzIGFyZSB0
cmFuc2l0aW9uZWQgdG8gYSBmYWtlLW9mZmxpbmUgc3RhdGUgdmlhIHZpcnRpb19tZW1fZmFrZV9v
ZmZsaW5lKCkuDQogICBjLiBEcml2ZXIgY2FsbHMgdW5hY2NlcHRfbWVtb3J5KCkgdG8gbWFyayBw
YWdlcyBiYWNrIGFzIHVuYWNjZXB0ZWQgaW4NCiAgICAgICd1bmFjY2VwdF9iaXRtYXAnLCBhbmQg
Y2FsbHMgY29jb19zZXRfcGx1Z2dlZF9iaXRtYXAoYWRkciwgc2l6ZSwgZmFsc2UpDQogICAgICB0
byBtYXJrIHBhZ2VzIHVucGx1Z2dlZCBpbiAncGx1Z2dlZF9iaXRtYXAnLiBEdXJpbmcgdGhpcyBz
dGFnZSwgYW4gdW5wbHVnDQogICAgICByZXF1ZXN0IGlzIGFsc28gc2VudCB0byB0aGUgVk1NIHRv
IGhvbGUtcHVuY2ggdGhlIGJhY2tpbmcgcHJpdmF0ZSBtZW1vcnkuDQogICBkLiBEcml2ZXIgb2Zm
bGluZXMgYW5kIHJlbW92ZXMgdGhlIG1lbW9yeSBibG9ja3MgZnJvbSB0aGUga2VybmVsIHZpYQ0K
ICAgICAgb2ZmbGluZV9hbmRfcmVtb3ZlX21lbW9yeSgpLg0KDQpCUnMsDQpaaGVuemhvbmcNCg==
