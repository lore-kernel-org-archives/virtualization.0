Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50D482E2
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759864; cv=fail; b=UNHu15w2C+sKjo1nEDxaEFn1WjsyboOEMeACFbBN7lI5BG0nkk7DReUdSwj+0Z91wcAsQJcMVZckW5lqwvwr6MFfkOmsDqm9zz48RWFSrrLttAgqpWODGi1lcpGEkSsOjjzzdr7rewyorYy+7W6+amqBil1Ra/nWJfqtx00KRyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759864; c=relaxed/simple;
	bh=Dmh1sFq6lNDseneGGM1CLOHs+xHXsl/0J2LkfhVMmRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N2Zx+VKr4GV9lGZdLBt1ZytSIXMrea1zqflHTdp+JbKKBkO/+qHriCdLV9TEg4xYdsQQrUn0lpo/5YtkAQYyI4ZtnsFyWrSiWM2XX3+hMU4hkfCzLt38sQXacWcWqJlWliu+IpzUjohSHjs3UgkQEUxT6gbwGE4bnM4rJBOQHRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOhuAUYQ; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOhuAUYQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD41E40386
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aD2szr3N8CkF for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 07:57:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 391E9402F0
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 391E9402F0
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XOhuAUYQ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 391E9402F0
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715759862; x=1747295862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dmh1sFq6lNDseneGGM1CLOHs+xHXsl/0J2LkfhVMmRM=;
  b=XOhuAUYQV3OiTh5NaZjoFgu7IqJBvRYEzCvH9N0UbL5ZmxNd3SuHqcF6
   WV5Pf61DaF5XJlCD9sSiZbfd+AOWz4qXIXlf51lI5W9XGc6gYVitSTfTl
   hZu4znMDtMkNKRhiP4ooWptXZEgP45fqv5yKgSBGLVix/x3spR0LDgYZ8
   NFXZIrFzFAXl5jgUidhDGnpQqcvvKRuZqT0vudanbAiFhT81cAmVW/Cox
   PfK1XUKg8kQ9aJwg8kMLqbmzaQgBRJrrbl7ak2BsrlT8VNsHfX0hXWA3O
   VYKghW7jaKhC1yNCVi+VJ5CiomBiss1q9iuZmf0ahj/4+H0iW/Ck0RO+6
   A==;
X-CSE-ConnectionGUID: GWwobOo1SAeTbpUKmZcvrw==
X-CSE-MsgGUID: 552N5PUBRqu7KjpfxG6eqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="15625564"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="15625564"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:57:33 -0700
X-CSE-ConnectionGUID: 6b1u0Fm3SZmr8fZo3CyoAQ==
X-CSE-MsgGUID: 7IVkqRuaRH2SoHa5wAbNaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35859169"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 00:57:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:57:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 00:57:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 00:57:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0CF+lGivAw8mMcFek517OdRnIMpvjEe21o6/SyjFqkOi5kex4AJrTTv8PqAKWI/MO2jIpI9HeJwQZZqVOUjcdaQ/wS6TeAi14rVJaTpPOC3g0zi7v97aIH/OQKW+2jcrkoJoTTPSfPD13M/J5BsbIVLlbpnW442quSeBvDSNehsrSfe9wjjesb5fq95tB5/erZehNCjsZMbDeB4kDQnQgPMbvGMDNNsHtPhh4CGL+/6iteLAo0ZcfdJu4cMatq2MXVk3z86crHphUzs6pNxSrRngN54BGVY9iOagKiIHHdUlzalPtqjvsqErCGXiOvQdJqbb9R/xrCiBo6MqrVasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dmh1sFq6lNDseneGGM1CLOHs+xHXsl/0J2LkfhVMmRM=;
 b=AcRs8OEUXCMI/2snLR21NagYIL3AcwtsLmSu50NztPX3baBi5uqk6Zv2dbvr6U3X3TQH4IUXAy/U+lXkURsBemsOQwSYCpda6ufTVYXNmeeGtACLEXVxuhbfrcqYZzaGtFTleYTCj2mdifK94h3bxURRRcrETujAkIbsmytv2NzpmIZvoLBgYqatZE9IBRYo0yU8vIT35izajS4qQhxVv2JTnACwHUe76eOyvQw6jWdrHq/29GtZN+XwxbZqvVgsFwg1Mn7fInD35t1ALj50sMZdhRcloF7N8Ogp8bFF5eK9HoWTkxENkhSVxdbQucr9iihgF73dtZFBl8f1FBIFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:57:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 07:57:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joel
 Granados" <j.granados@samsung.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 5/9] iommufd: Add iommufd fault object
Thread-Topic: [PATCH v5 5/9] iommufd: Add iommufd fault object
Thread-Index: AQHamw8IPv7IV85GSUGxhOe1hMt7NbGMgmSAgACl5ACACtl+gA==
Date: Wed, 15 May 2024 07:57:28 +0000
Message-ID: <BN9PR11MB5276F21755C883FE7EC784228CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <20240508001121.GN4718@ziepe.ca>
 <a03d3bf6-0610-427c-bf2a-5f6c410e220e@linux.intel.com>
In-Reply-To: <a03d3bf6-0610-427c-bf2a-5f6c410e220e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: 8386f4ec-c3e3-4b67-6b8f-08dc74b4aa5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a0E4Nlhqa2g5cnk2VE5acy82ckwwYzJEUlNRdU5xQjZpMUpaNGdSWWFvMkJH?=
 =?utf-8?B?MmxON0JtWHUwYTdQS1MzUnVURGhtVmdvZlpkdDRZQ0hUdHF5ZnpKTUtCcXhP?=
 =?utf-8?B?NG9Fbk9IQzd5bEZGVFFsSExweXFsQVFrRmhEUkpxdkJaQ0lnRnRtWEJIWStF?=
 =?utf-8?B?T0hYZ1l5TEwyZ3Z4ck1ScS9ZMm1MWnRodjR2emc1bExScDVMcGViczlNQzZi?=
 =?utf-8?B?elBxa0FkaU15cFV6Y3NvRXMyYVJORnhCWStNN3kvT2xVeWZGUE5mcTFiYlZq?=
 =?utf-8?B?azR4bnc3M3RXNldhWDRmT0lBdFRiazNiZVhlK1RJeVk2VXI4dlAyaVhQOHJx?=
 =?utf-8?B?SGhFUS84NU5IQnM4cVpPTWJrbjdSNTkxNmNYUTJZMnFPb1Z1cWFwLzVtY0tF?=
 =?utf-8?B?d0hIR3NRUXJicWU4ZWNXTW8yMWVHZ0V6Y0VvaTVkeUpudWh0NDdYV013L21Q?=
 =?utf-8?B?c3lPemlYYWMyRm5YK0RmR09LaVYvRE9kTWxWQzgydE9MRzVtSUVXNlNoTnNv?=
 =?utf-8?B?YTN4bEd3ZUFsZjFORXIvOEV6SWJrb1Q1d25QUVNPVWtpTnFaQXBpZERUZzFZ?=
 =?utf-8?B?alAvY2IwbU8yMDBUQkErQjY2ZGdacXlSWEp4dFBlcTdiR09zNE56TFpRSzlu?=
 =?utf-8?B?bVBKRjh2Q3JWNkxnOEZhZE51SVJINEFOK2xsVzNKbFdpSkd5ckZoQjl0aVFL?=
 =?utf-8?B?dDlZUTRCWXBTRytXeWFsN3VZSkZXeE5oaEZtQkVQZk9NMlBzbWpnMEhKc21I?=
 =?utf-8?B?Z0xEUVMydVAweS9ta0R3N1p3djNHUmtiL1R1S0I0b1FzNldObUgwK2gyTFVO?=
 =?utf-8?B?Nmx2Y21lUnY2NnBSWVN3S0E1c001US83MXRSLzBOYnUvU1RCMmsyTFJYY280?=
 =?utf-8?B?R2FYeW1NcXh1b3pnTkdreXJOQ1hNc1hqZ000MTZ2WHhqWEJpSWZNV1JRZ2g5?=
 =?utf-8?B?Y3hLOVc3NVB1cGQxYXNlNmpJblBvcEYzWW9TOVBsaE45U0d6M2xGM1ZKM2J1?=
 =?utf-8?B?RXZiOVdYTlp5Z3NFeis2MnJ1V05LT1hZcmpmb0xTUC9kc2NzZFlralhKc3p4?=
 =?utf-8?B?UlBJRDVHaXVUdnNNVUlaWXZiTnRUNlAxWnZRUHFEN1VBTzFGSXRadWRZWE1l?=
 =?utf-8?B?K3dHYzk2Z1Z6RmhLbC9HYzNPZUNwZmZvNEtQbXk3Y0FmZ1FscmVmSzh2UGJv?=
 =?utf-8?B?TUZrVFVzZjU1QXoxc0FmWjBCMllhTHErT0JrallZbGhORk1EZW5hTHhKeld4?=
 =?utf-8?B?NGVMdVRodXZ1TWhtVW9yc1BlSkV5V0trRkZCVCtQQ1NJelNRR3RjSGFGcWJJ?=
 =?utf-8?B?NG9tWGNvN1dBTVM3WHBJQUJueldyd2o5dnpVTGFSQzhZRDJxVlVFdjhiMGlI?=
 =?utf-8?B?cGhDRUdXQnRDL25lcEoxTUNPTTBCcDZ5ekFPWWdtZ0ZsTEgrY2hJNnZmbTFv?=
 =?utf-8?B?L1JyT1dab0crOGRNUlYwdVB4bFBUdG44WllYN1JSYTV0TUlMNHU2cXE1YlJO?=
 =?utf-8?B?VzNjdXR4SnZLWXY4K0lKZ3NiV1NUVCtFMkNRSnBTbjZ3alhiTElSMzBQbHlL?=
 =?utf-8?B?UjhJb2tlMW5HSFBnQWlPVE12NTJmd21TMkVGOExZSFA3S2NFS3Eyak13K2tO?=
 =?utf-8?B?Snp2SGNOTFVaL1M3cEF1QkI4eVQzUE9kMGJONWN0bnZNSGYzYlRNeGROdktt?=
 =?utf-8?B?OHVKYnlTdlh3bVpmVG5UbmFlWlFJSWVUTlY3ajhkS0RldkNxMU1FVlZDVEE5?=
 =?utf-8?B?dElzU0hxN2dDMS9vTjFjSlcyQUhDZThGOFZ5cy9rL0tOdjVLcHRFalN6QmU4?=
 =?utf-8?B?SG11UjRDdGVpZ3FrYXBTUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3JjM2JsYXQxcjhqWUtGSHVmejcvYlR1dStJTVRaVGl1NHNpV3I2TXhTM2pB?=
 =?utf-8?B?TmZMQjB6UmVBblE3d2Jsb2pWUEk4ZVhkekw5b0JBR1p3d0FKSDhKUTFKekli?=
 =?utf-8?B?N1dPeCthaG5hZnJ1KzBpbmFFMnh6NERIUTBRMjl2aFFzL0hKY01zNmtQblI2?=
 =?utf-8?B?UXNxeEx5YjJSVU5maEFRWkNvRS9VVFIrajRoVUpWYjZvOTFRUDQxRGEwR0pK?=
 =?utf-8?B?d0dtT2R1Vlp5SEI1SXBXMHU4QlNxSmFKR3hKRm1JNEF6T0o0MGRFVVVqRTMr?=
 =?utf-8?B?Nmp5UFE0N09SWHZzRzFuQkYrSTBwcUpNb2FtRjRvMmxYYXVvQ203SlRwSVp0?=
 =?utf-8?B?cWswMk1SbVd1U2dzeThkVEpKUW5US0dxMTZlNW43L1lHTHcrSm9hNng3RWJK?=
 =?utf-8?B?eTdXQVJGb1l6NkdFU0JjV00xTnFEdW5mZnM1d3FaWHpDMVBjYWdBVXpUeStP?=
 =?utf-8?B?MllXQTJuaVc1R251cWcraERsTFJBSCtGWjR5d1gxbThMYTBOK0Fuc01sbFZl?=
 =?utf-8?B?Y0lCK0JoZ09Nc2VWSlJRYmJGblFKbGdHNXdaWHkxWFdsUHA5R2gzK1N0Y3J0?=
 =?utf-8?B?WGF4SVNtU0puMDlndnBQM3hvOWp4c0lVRXJkWUg1Rnp6WlRzOWUyRGhEOFY2?=
 =?utf-8?B?N1IvM1o3YlgwZXBKaEM5T1k4ZGlqbmVtZlhuUGJBQ0FWdVlESlVmRFpVYUhq?=
 =?utf-8?B?RFkzcVkwRG1XUERxUkVRcUdCYXNBdEpCbjVZUzhtaEdXWDRBMUliVlB1Rngv?=
 =?utf-8?B?VDVYQUNJSGtjaDlDUHpIZXBJenVhNGxuZzNVYndadnpnLzg0S1JYTDhvTEZt?=
 =?utf-8?B?SDE3N29KUkFIRVJRMm1Sc3QwUzkrUmZZZy9TT0RvbHc3RzE0QTJTU0xjdkJU?=
 =?utf-8?B?Yk1QQU1NUFJzU2NlVnJtc2hjRWE4L1VLVHgvd3pPaWFjcDZERWlmZFlFem1Z?=
 =?utf-8?B?Mi9qN1gyZUJsTzc1aTNLeEdHYU15bkh0UTBLckE3aStGRzVmSWRjdldtZWwr?=
 =?utf-8?B?aGdoVFpKQSt0c09JWUZ1dDVSVjJKTGNHeXJ4RGxaSGFidVNVZWpPU0ZZMUJy?=
 =?utf-8?B?ZzI0L3A0TWVZQ2JrZzM3REhkcTJURDZpSis0SitTNW5idis5VnMwYVcxWmFj?=
 =?utf-8?B?OVdJL2ZKTUZCVzhFTWpldHlZRE4wWVJ4ZHkvTGRIWXJsKzQyMmdBY3U0bHNW?=
 =?utf-8?B?SDUyRGhJUlRmbHlmRHk1WXROQ3BHQjUvc2lsMjM3MlYrejVJL1lPRlBRekx4?=
 =?utf-8?B?Mk4yRTB3ZjZBbjFUajEwQ0Rrd2prMHYwWHh4enNUNEpSY1I3b2gxWjhINXVw?=
 =?utf-8?B?aEFJbnAzR0JIOU4yc1RGRDhqU2JMNTl4bnc2TFZXVXpHZlVHWDFRa2lWMGcv?=
 =?utf-8?B?Z0FUUEVTNUlwQUpYMjBKd21yRnA1aWJDMDliV0IxelNRU3FtT0FCa1VCL0VM?=
 =?utf-8?B?emM3dVg0NXR0dkMwU1ZjWnM5WXJtRUxYWnovWmgxT0R3TG40Wk81MzJjbXpx?=
 =?utf-8?B?aXVvcmRUcGRVUTJTS3R2Y0lSOG0rN0J1cHFnbVQyWWxjd1k4NTdTbHRuSHBT?=
 =?utf-8?B?RHlzRGtzSUdHajFTZEFyeDZvVzFFWHpLaDRsVndVVXRRZ1AxSlkyeEFwaS9o?=
 =?utf-8?B?UXFVc1RJM0N4SUE0cXZjWDBMQjhsc0tPNlRqK2FLRXdaMUNCUDJWUEVGV2hL?=
 =?utf-8?B?L1pMcmVHRTFZU2dpczV0SW5aTE1kOGk5WlI0Y0RXRUo4R0FoaHlXUEE1dnJx?=
 =?utf-8?B?L3ZMclNpdzB2by96dXh3NE9oWXhwVllSYzF6cnU1dS9KcG4yR0xLSUwzdGhv?=
 =?utf-8?B?WWRJTjkvZGl5M1cxdFVZUzRaUFhoOTQrNFdNVFlzdTEzTTR6L0o2MVRSbzNp?=
 =?utf-8?B?WUxKL2JJOFlhUzdGMHk1OFhCZEVTOSsrRWhwekhwNkxTYS82TUtmN2tYTFVk?=
 =?utf-8?B?aHJQYjY4SDVmbmgxRmxTbU5TRzY1OEYwWE5leTZ1ZG4wdnNpZ1RXdFRZaS9p?=
 =?utf-8?B?dkRPSnByejlCOE02S1NHQjFobHdQc0EvQTV1ZXV2Q3QxN2czWVhqU2M2UHcr?=
 =?utf-8?B?ZTFTcVJteG1SUU1uQjFmbzNjQ1JnSFU0VmtZNnVJUXcwNEJFd3N2OGE5NVRV?=
 =?utf-8?Q?fIYFiahYQTFfji6//twz9RjLz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8386f4ec-c3e3-4b67-6b8f-08dc74b4aa5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:57:28.0834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oM5oGXaBjc23fnu4ai/T7RAh1EdlJWpJsyC4yUIu4vrDPZNHonWxO7T3L1y/03oYWWOYMdfkGfO96rYHJmiufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIE1heSA4LCAyMDI0IDY6MDUgUE0NCj4gDQo+IE9uIDIwMjQvNS84IDg6MTEsIEphc29u
IEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBUdWUsIEFwciAzMCwgMjAyNCBhdCAxMDo1NzowNlBN
ICswODAwLCBMdSBCYW9sdSB3cm90ZToNCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
aW9tbXUtcHJpdi5oIGIvZHJpdmVycy9pb21tdS9pb21tdS1wcml2LmgNCj4gPj4gaW5kZXggYWU2
NWUwYjg1ZDY5Li4xYTA0NTBhODNiZDAgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW9tbXUv
aW9tbXUtcHJpdi5oDQo+ID4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUtcHJpdi5oDQo+ID4+
IEBAIC0zNiw2ICszNiwxMCBAQCBzdHJ1Y3QgaW9tbXVfYXR0YWNoX2hhbmRsZSB7DQo+ID4+ICAg
CQkJc3RydWN0IGRldmljZQkqZGV2Ow0KPiA+PiAgIAkJCXJlZmNvdW50X3QJdXNlcnM7DQo+ID4+
ICAgCQl9Ow0KPiA+PiArCQkvKiBhdHRhY2ggZGF0YSBmb3IgSU9NTVVGRCAqLw0KPiA+PiArCQlz
dHJ1Y3Qgew0KPiA+PiArCQkJdm9pZAkJKmlkZXY7DQo+ID4+ICsJCX07DQo+ID4gV2UgY2FuIHVz
ZSBhIHByb3BlciB0eXBlIGhlcmUsIGp1c3QgZm9yd2FyZCBkZWNsYXJlIGl0Lg0KPiA+DQo+ID4g
QnV0IHRoaXMgc2VxdWVuY2UgaW4gdGhlIG90aGVyIHBhdGNoOg0KPiA+DQo+ID4gKyAgICAgICBy
ZXQgPSBpb21tdV9hdHRhY2hfZ3JvdXAoaHdwdC0+ZG9tYWluLCBpZGV2LT5pZ3JvdXAtPmdyb3Vw
KTsNCj4gPiArICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgaW9tbXVmZF9m
YXVsdF9pb3BmX2Rpc2FibGUoaWRldik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7
DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgaGFuZGxlID0gaW9tbXVfYXR0YWNo
X2hhbmRsZV9nZXQoaWRldi0+aWdyb3VwLT5ncm91cCwNCj4gSU9NTVVfTk9fUEFTSUQsIDApOw0K
PiA+ICsgICAgICAgaGFuZGxlLT5pZGV2ID0gaWRldjsNCj4gPg0KPiA+IElzIHdoeSBJIHdhcyBp
bWFnaW5pbmcgdGhlIGNhbGxlciB3b3VsZCBhbGxvY2F0ZSwgYmVjYXVzZSBub3cgd2UgaGF2ZQ0K
PiA+IHRoZSBpc3N1ZSB0aGF0IGEgZmF1bHQgY2FwYWJsZSBkb21haW4gd2FzIGluc3RhbGxlZCBp
bnRvIHRoZSBJT01NVQ0KPiA+IGJlZm9yZSBpdCdzIGhhbmRsZSBjb3VsZCBiZSBmdWxseSBzZXR1
cCwgc28gd2UgaGF2ZSBhIHJhY2Ugd2hlcmUgYQ0KPiA+IGZhdWx0IGNvdWxkIGNvbWUgaW4gcmln
aHQgYmV0d2VlbiB0aG9zZSB0aGluZ3MuIFRoZW4gd2hhdCBoYXBwZW5zPw0KPiA+IEkgc3VwcG9z
ZSB3ZSBjYW4gcmV0cnkgdGhlIGZhdWx0IGFuZCBieSB0aGUgdGltZSBpdCBjb21lcyBiYWNrIHRo
ZQ0KPiA+IHJhY2Ugc2hvdWxkIHJlc29sdmUuIEEgYml0IHVnbHkgSSBzdXBwb3NlLg0KPiANCj4g
WW91IGFyZSByaWdodC4gSXQgbWFrZXMgbW9yZSBzZW5zZSBpZiB0aGUgYXR0YWNoZWQgZGF0YSBp
cyBhbGxvY2F0ZWQgYW5kDQo+IG1hbmFnZWQgYnkgdGhlIGNhbGxlci4gSSB3aWxsIGdvIGluIHRo
aXMgZGlyZWN0aW9uIGFuZCB1cGRhdGUgbXkgc2VyaWVzLg0KPiBJIHdpbGwgYWxzbyBjb25zaWRl
ciBvdGhlciByZXZpZXcgY29tbWVudHMgeW91IGhhdmUgZ2l2ZW4gaW4gb3RoZXINCj4gcGxhY2Vz
Lg0KPiANCg0KRG9lcyB0aGlzIGRpcmVjdGlvbiBpbXBseSBhIG5ldyBpb21tdV9hdHRhY2hfZ3Jv
dXBfaGFuZGxlKCkgaGVscGVyDQp0byBwYXNzIGluIHRoZSBjYWxsZXItYWxsb2NhdGVkIGhhbmRs
ZSBwb2ludGVyIG9yIGV4cG9zaW5nIGEgbmV3DQppb21tdV9ncm91cF9zZXRfaGFuZGxlKCkgdG8g
c2V0IHRoZSBoYW5kbGUgdG8gdGhlIGdyb3VwIHBhc2lkX2FycmF5IA0KYW5kIHRoZW4gaGF2aW5n
IGlvbW1fYXR0YWNoX2dyb3VwKCkgdG8gdXBkYXRlIHRoZSBkb21haW4gaW5mbyBpbg0KdGhlIGhh
bmRsZT8NCg==
