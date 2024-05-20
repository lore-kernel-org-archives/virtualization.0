Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AAD527
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175254; cv=fail; b=nQUCQnN6wJCLbEiwJGD/d7PCKu3DxXuEYbRuqcpxsCaUjtRpCCnO/CBnvNjXwf5nO4v2PRo9uuFUtSx9tLy7P0tVaJaj0viHkzYqbvDULIKn1d28UpQaAkm9ydRnLH16BGiTXHV27WMS5wMx/pMvrghxFGb7eViwcMCxDph3v88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175254; c=relaxed/simple;
	bh=673AZQtUTfEzgniDDeDQ4osMV8m6615vU0X8wQB8DGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZkobjDmNkz77TPlbVUxHhPjsPdnRQLibArk9jltZ9mIJJMiRRwmoHWvlXV7Zvdo11UnkufkG+9tB7wayC58mLyJLymzK3r2k9tJYVoWm2AM2x35ko1uj+aKNC7A+KpsOw0F6wfgo34KcmjL/VSThY1kROIKfFqyzKcJRO7W3VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOi9wByo; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOi9wByo"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E913540422
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:20:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wlZnnrvDdgKD for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 03:20:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B36C6403CC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B36C6403CC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XOi9wByo
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B36C6403CC
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716175251; x=1747711251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=673AZQtUTfEzgniDDeDQ4osMV8m6615vU0X8wQB8DGw=;
  b=XOi9wByo2Gfk/QScuM3G9AWmjv4bQf8Nf3sjcA937bMkT8+pYKhc0/+X
   qHBdMztHhgdElvY063UX3vrCTNxenbgeBhQLhAUI4FWdQjLfJCVzjKtVJ
   R9LnM/3wZEbZZvt100JLLCGHdXcCxgRoWknbs+8yyrFF8YuLb7wlV4w23
   Sm1wp0jFKBVJPWMl+sC8Q095by1aVlgD0IcrlzO1NiKP/dzT9zQn5sRXp
   e/hJOD0J8ajpbsu2z5sOJ2NtZz4ww3AD74UEOJkCkOhXGKIgfyu6Y7FRy
   QJVz/g4AhQV2MeCeG+j4+qtgA85Tfe/0N5HthPfwNOGLIV7xCmKWBYu1E
   Q==;
X-CSE-ConnectionGUID: ip6KfA9nR3yHt4wXnzkn8w==
X-CSE-MsgGUID: FyS847HGTd+EH1gqBwZllg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12132280"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12132280"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:20:51 -0700
X-CSE-ConnectionGUID: 19g1o4JJSvG41tYjzSj/Ew==
X-CSE-MsgGUID: zlLRopUwSS6NYN7/nYf2Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="37209543"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 20:20:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:20:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 20:20:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 20:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONCUiunzxrGfEq9WrvNX9OWJIkvDjVFlLNAR7ESrIiuXC5KcooP0cnDMSTPQEGWrHTO5UuaeKCd4KnAIAnCvkgffixzDspK7QMitax3MexERE3xsJ6kWmDpmI7XFHTCCCKoE1WLy4hsBYFzh3+mDyFLk5gc6Td8KgMnlLc3XKrhS0KtgmsAQvhdiC8v27qZk63aWu47bKBhATGgcPST3hw/RZSZnPbGqzyZ/KlhRb8UdxoYHtPGtZI21wVeF5yvMjbLtdl4PrrbHivdv5+aa8jKAQTeGSGbrdBYfszK/NL6QPmaQlP3vTLBvyOvS9cF4vn3h6EJa+DWzt6SMk/TFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=673AZQtUTfEzgniDDeDQ4osMV8m6615vU0X8wQB8DGw=;
 b=OpuOyXuhZVQ4v7Lnu6ZrWTWnahqE3DKV3WuxghH54KaW918fOd9zrqq9lE0gbv334+lhK7L4MgdYc/JaNNCpnhG/umiCPHGFKqpICDYp6A2WRnoPzEI4Ei0a2X2obGlvXtX0ECbey/dXnBVY1sjDExzTfBJvgWN6XfA5EK7/0y+EBM3N6t/Foaymy6oX1go5TiZJLS5Y3PjZPlvEBUNrm5LT8ukw29ZnB3/iGMdHllxWfbZb7hzS5OHGOepVKQxzSiwP8OCsscGXdQwnCAix7FaDtOfrFJg8QcYHtOu82UkD4E6tYJ/a+ZfzrxNmORe+1BKUkZlFn5ngryDzjukJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 03:20:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:20:48 +0000
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
Subject: RE: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Thread-Topic: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Thread-Index: AQHamw8FRMPPYVB/4U+b9NV7aZfqhrGX+wIwgAa5l4CAAN53YA==
Date: Mon, 20 May 2024 03:20:47 +0000
Message-ID: <BN9PR11MB52761043C30530D29C51DAFD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762A339B6E103369C22F068CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <884a4104-27c8-4604-bd80-3b8cf84fd144@linux.intel.com>
In-Reply-To: <884a4104-27c8-4604-bd80-3b8cf84fd144@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: a8de8f00-e909-43c2-d24b-08dc787bd804
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?L2tNS1RyUWh1dFh4S01GZ0FmUWVWQ1NZUXN3SDlBTXpwT0VBTEMybEU5Q3M0?=
 =?utf-8?B?YVB5bjJGL1pOL2Z2Z2xmcjFQZk4vaGJsRXNuenFBUWhiM0wvazhTZXNsNTFE?=
 =?utf-8?B?ZWJXaTlzMEVFK0pIeTZTVm1DdmVqZVJsb1BUUUkwNk11Sy9tMTVVRUxqd0I4?=
 =?utf-8?B?SVQ0QjhvRENpMHBTK3FZc0lYSlp5QmJkKzhwcXl6c1BUbnd1YlRDWW5qN2Ey?=
 =?utf-8?B?bThjOXNicXhvbTFhQjd4ZGpiV3Y0NGw3RFU0a0NMakVOSmRXb21lVjhOcDAy?=
 =?utf-8?B?c0VaN1VuZ0g5Q2svN0dQc3I0YlcyQmJLVlJ6NVR6b2dScWlmVUYwd2Z3YzhD?=
 =?utf-8?B?WmZtRVZVSE1DU0RRVlRJYnJLcGVwOEM3V0dBUzI2aDhscGVSTlhHeGhacmlX?=
 =?utf-8?B?dmFLMElnRy8wK2xJR01PUVlCbmQ2cnNQSFFOb3pVcVZKa2NscjFlQWhQaEU1?=
 =?utf-8?B?QmtDWURaMGtUVXVIWWJWRFc5Sk5ZcDc5Y3l3UDJpR3NoNnA2bXlvRGo4dXJH?=
 =?utf-8?B?cmp3cmM3VEowYkpsR29yUTRsaFJWOHJDQkVsK1RLQzZZYmI0SVJtZVZrZkEw?=
 =?utf-8?B?QlRHS1hoL29jUk9aVlF5ZnZiK1ZkRi8wbmd0Q3AvRG5RM2MzdkVzdVA0ZFNt?=
 =?utf-8?B?c0ZQYU5FSFZmTVJZQ2ZVY2JiWHR0WTVLMXRoK21BYzRlc1BaSXlleUUvNDVq?=
 =?utf-8?B?QnBRSGxwT0JxYjZqdXlHYmo3a3lMeXhVcnhjeHVlWGFSV1VWRW1uUlJUUkFL?=
 =?utf-8?B?TU1nMG12Zkh2NFgzQU1mR2dya0M2czNJTitZRG1jNHhNUjlWYml2d2ZGUTUy?=
 =?utf-8?B?QlZzV0VZa1UyR040NzZNUG01bjd1SnRpbnIwc0lrZlNZL293NEUyMGFuaFA1?=
 =?utf-8?B?Wks0NWdQNXVLN25ia3hiaFpydlY5UUk2ek5Kay9xcW1EYmVZZWM2SUVmWlJI?=
 =?utf-8?B?dWpqaHdBWGE4c0NLczlkS3B0Y2hoVllxRkg3STN4R2hyWm42emdEWVY3M0Ez?=
 =?utf-8?B?eFJXVUsrQ25wSitNcEZiN2lVWkMvUDAvQlJqdGJDVW9aR3NFWU5BU2FkOGFi?=
 =?utf-8?B?RzhiRW1PWkNpMDh4RG0zWkE3TStGSTdmVDMwMU5PVDAzem1YaXhvVm4vdHRL?=
 =?utf-8?B?SnVoV05uRG85OXVzWTJzWm1ISlEyWTRtazVQMlFmTVR4NElmWXBndUZGaXJT?=
 =?utf-8?B?L3MwRTV2R1A1MmJvbUdWU2xCR0xNb2hBY2pteWJuVEFSL1JGT3NqajVtbDBQ?=
 =?utf-8?B?clhHbCtrc1c3QzJScGNKc3p0NVVBL1VaODdsbDUvSVREQStndU14SGRteVFh?=
 =?utf-8?B?cDJUUDlPOVpncmNRaVg5TDB0M3FDZzhjK25EUUdHaGs5YkcrRVMxemFHWnMw?=
 =?utf-8?B?V2g0cCt2NXIrek91V3U2ZjNnN3BhRUdBMjJLbEFhWXkvSWUycUwzTWMvRkxE?=
 =?utf-8?B?c0dsZks0Z0dnWUNMT2RHdlhmTGphZlFEdFY5RDNqR2d5b0pmd2dsRnIvZlMx?=
 =?utf-8?B?ZEw5N1dtek9jODlieUMreDBsUTU4bTZtUUtzQVdoUHVIb3dBbC9VMTZQbFFC?=
 =?utf-8?B?em5GbW1hQ3o5eDhVbE5uVjg1SnRWUmgzV2tpWmtqcWZ6dEw4OERxZWRwZnFT?=
 =?utf-8?B?d1ltUlJWa25VU2I1dnBuU25Odm1OTHNWL1k1Tm01RlBzeGdtSEJMczZwMGRT?=
 =?utf-8?B?dTNiRmkwNnd1WDRESGJaR0pmMGRtSUpoY0lOaEZlSzVreU0rd2RrK3diMFcr?=
 =?utf-8?B?VHRnNU5EckFnREVGNGJUZ01CdklaQUY2V0wzeFlBMGVCeXBNQzc5M0tWSFlR?=
 =?utf-8?Q?Phm75rSnV4J10k/N7IwqfDW/9jzl8N40lpMXM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2dvcnpncFo2Q2xqaUFKUkl2T2hNL3ZFNnlDUjZBck5CVW9YRUMrVTEvYVND?=
 =?utf-8?B?YTZoWFdYZlljT0N6NkFESjBBNHNtU2FOc0pkL1lZVHRsSUY4a2ZNbDlNaTVB?=
 =?utf-8?B?SVQvaW9BSk15QlVYb0xiUC9PeHBiNWd3WlZEOTNOVmNBOXMxYkhCL1k3U1gy?=
 =?utf-8?B?Q2hUb2lYRktlMU9VRjh4cmlwNGJGbU1mUi9LM2FtZ2Z0T0F6QVdidXdwM1kr?=
 =?utf-8?B?OWZCREZZWTkwWVBKZ2JFVW9nSjJqRWpPMkFwbXVIODlGMG01Y01YSmVHblZP?=
 =?utf-8?B?ejRTRlBCQmJsZ1Vmb2I2RU1QRkF6N3BTSDJIZzBpTVBvZ3d4M2R0cnZjNkNN?=
 =?utf-8?B?V3habkFSOHZ1WTBERGhSZ3ZQYTFpQTZ3c2NRREpwdTVWb1ROOTRGZXJwRGFQ?=
 =?utf-8?B?NmpLQzJFandlQUEydzBiSjBwQlNjd2ZFSGdsOFVRYjhENC9LaVJ0T244cUNj?=
 =?utf-8?B?amVtb1dIOVUyNzhiQW9lMTNEclBkWDJxZGdiKzFFQy83bVRJQ2tGNTE0aGho?=
 =?utf-8?B?QTdBRzNYQTdLbjBYWEtFVGRoSVluMDV4YkpOdTNOTmRDcjMzd2dBZWkwMGhN?=
 =?utf-8?B?d1NERHVpaG1BTVBpL2JqZWtWNTFaNk5aWGE3bTEva0FBUmplaGFwS0t5YU9i?=
 =?utf-8?B?UzJOcGEyd0xGZ0x4Qk01M0Rwc2drZVB3WVJWelgrbzNVTjN6OEY2RlZyeEpw?=
 =?utf-8?B?a2lFTlorN1Yxb1B0NmJqa0NZektZbUFQVXY2RlZRWURqeWJ2S0g2SGRxbDRt?=
 =?utf-8?B?U2JwQWE3M1JLK0VDMy9nZ2JDaXEwNTlpYWpOR0xCWWFybEwyYnNybGVKdTds?=
 =?utf-8?B?S0Z6My94QzEwdTVkVktuYnNyZWlIT2JSczY2RnBSWWMzSURGSXBheUQ5Wmgw?=
 =?utf-8?B?dUQ5dVdmdFhqRExkRzJPUVN3Mi9Qb21KYjRGdVJvMkhVbkZPZkdWTzlUMC9P?=
 =?utf-8?B?SGR4dktMVzRkQzl1T3Z6ZFdoV0VmeFlpVXRob0lXNU9MZ3RCbEU2Z3U2a1Zn?=
 =?utf-8?B?R29IaVcvM2dqOE5jSi9ickJXV2o3dHE0NHVOcGZnV1NUWEtlaEhHY2w1K24v?=
 =?utf-8?B?V1Vsck1qMURYbGVoOUFSUkhOZnFaWkxBdm1JNWk2UXZnV1R3eGxaWHUzSDh0?=
 =?utf-8?B?RnJCUzdpK3EzNExYajgxWllic0pNREZNTkczcDFsMitjVk9rVUdOUTNvSWZ4?=
 =?utf-8?B?U0g5cW1QdlJsOHRsblFGdDBEZGQyc1FVU1RiUUVJN25YclpwMllCOC94aDZW?=
 =?utf-8?B?cXg5S2tabFlVSWpiWElHbWtDMjRZTmlLSVdnandEeXc1RXBNR0JRT2wrbHpx?=
 =?utf-8?B?UjE4dkRUUE1NQWVud1lYeHZlVXJWYjZiQVhITWo4M0U0V1FjMFlTVTNTZ2hR?=
 =?utf-8?B?QytBcmpGZGFwVTdQTk5xcWdZWnVYaTR6aGlaRDR6cHVja1JON05IdGJuTjZM?=
 =?utf-8?B?dG1ON056QW5PRjJUbGxnd1p1WnVmR1JXRlRIeG5KdnFPM3F1VEp4eVBVdThq?=
 =?utf-8?B?OFp4ZFVTQm5tL1hQeTZXaTZkSWxPRElNc0VTNWtuMDQ4SGlPeml4enpaN3NY?=
 =?utf-8?B?TVh6eDhiczVENm5UT1pHVUtmWC91bG80dmRHWnVINm9LWkx2d1FWWXMvWjk3?=
 =?utf-8?B?RWRzcFFNMGxzR1QyV2xWRjNHMGV1M3JpMmoxajQ0VERlWCtBRlZXMWtqdmRK?=
 =?utf-8?B?U0N6bjE2RUlRUmJ6T29vQkFCSDFpQSs2SjlmOGF6azFNSGhRT2ZrREh0MWZT?=
 =?utf-8?B?bFBJaUNZR0xwRWlySzhDckNIeWl1T29mZlROakhWdlZzZXNMMURKUHlsT0Jh?=
 =?utf-8?B?Q0M1ZWE3Sk4rWVQvMWhZWlV0V0s5N09ibG9DYTYyQitVU3djbnJHTWtkeEtt?=
 =?utf-8?B?Y2lWU1M4R3NTV0dtbExzK1hhNjBuTktNTDhaeFc2NFhjeFE1TWlvajlIT2N4?=
 =?utf-8?B?UTNJa1RNQ1l0Q09TN1A3VWNrR0RBcVAyS0pHMERuVy9CSCtnZVBmODRERmF6?=
 =?utf-8?B?K2Z2RW4wcHdHRkxjbVZaVStmVnlXbkZKOHYzSjNyZnlqMlB0OERnL1hJQXpp?=
 =?utf-8?B?b2QrTXdZbzZQcWhJODhJRFVrWFQyMzQ0QjcyQ0hCa2NBbzlCS20zZXRhenpn?=
 =?utf-8?Q?xtsGT6lONCbq4bTincHy8EHHk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8de8f00-e909-43c2-d24b-08dc787bd804
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:20:47.9763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQ0+IncMN2VxSAfpwccFkjQsDQ7HxwCRb8XCEdrdmppEb+KGhTKJ+oWhmfMfr6OfcBR32WJkpUrz63a+H1lFkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIE1heSAxOSwgMjAyNCAxMDowNCBQTQ0KPiANCj4gT24gMjAyNC81LzE1IDE1OjMxLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgQXByaWwgMzAsIDIwMjQgMTA6NTcgUE0NCj4gPj4N
Cj4gPj4gKwloYW5kbGUgPSBpb21tdV9hdHRhY2hfaGFuZGxlX2dldChkZXYtPmlvbW11X2dyb3Vw
LCBwYXNpZCwgMCk7DQo+ID4+ICsJaWYgKElTX0VSUihoYW5kbGUpKQ0KPiA+PiArCQlyZXR1cm4g
UFRSX0VSUihoYW5kbGUpOw0KPiA+Pg0KPiA+PiAtCWlmICghZG9tYWluIHx8ICFkb21haW4tPmlv
cGZfaGFuZGxlcikgew0KPiA+PiAtCQlkZXZfd2Fybl9yYXRlbGltaXRlZChkZXYsDQo+ID4+IC0J
CQkiaW9wZiAocGFzaWQgJWQpIHdpdGhvdXQgZG9tYWluIGF0dGFjaGVkIG9yIGhhbmRsZXINCj4g
Pj4gaW5zdGFsbGVkXG4iLA0KPiA+PiAtCQkJIGZhdWx0LT5wcm0ucGFzaWQpOw0KPiA+PiArCWdy
b3VwLT5hdHRhY2hfaGFuZGxlID0gaGFuZGxlOw0KPiA+PiArCWdyb3VwLT5kb21haW4gPSBoYW5k
bGUtPmRvbWFpbjsNCj4gPg0KPiA+IHRoaXMgY2hhbmdlIGFsc28gcmVtb3ZlcyB0aGUgd2Fybmlu
ZyBtZXNzYWdlLiBJcyBpdCBkZXNpcmVkPw0KPiANCj4gTm90IGRlc2lyZWQuDQo+IA0KPiBQZXJo
YXBzIHdlIGNhbiBhZGQgYSBtZXNzYWdlIHdoZW4gdGhlIGlvcGYgaGFuZGxpbmcgaXMgYWJvcnRl
ZC4NCj4gU29tZXRoaW5nIGxpa2UgYmVsb3c6DQo+IA0KPiBlcnJfYWJvcnQ6DQo+ICsgICAgICAg
IGRldl93YXJuX3JhdGVsaW1pdGVkKGRldiwgImlvcGYgd2l0aCBwYXNpZCAlZCBhYm9ydGVkXG4i
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmYXVsdC0+cHJtLnBhc2lkKTsNCj4g
ICAgICAgICAgaW9wZl9ncm91cF9yZXNwb25zZShncm91cCwgSU9NTVVfUEFHRV9SRVNQX0ZBSUxV
UkUpOw0KPiANCj4gVGhvdWdoIEkgYW0gbm90IHN1cmUgd2hpY2ggaXMgYmV0dGVyIGRldl93YXJu
KCkgb3IgZGV2X2luZm8oKS4NCj4gDQoNCnllcyB0aGlzIHdvcmtzLiBkZXZfd2FybigpIGlzIGZp
bmUgYXMgbG9uZyBhcyB3ZSBkb24ndCBleHBlY3QgaXQgdG8NCmhhcHBlbiBpbiBzYW5lIGNhc2Vz
Lg0K
