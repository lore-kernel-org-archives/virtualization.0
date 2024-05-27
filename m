Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F6E33C8
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716773288; cv=fail; b=YhBQFnN2Bjko9fFoO2VNEKo4ZHvozCOYQIKIWmPybLwBJr4ASidUYqhoWIIrNB2nLgEFA6PRl1n+1WpcgRObi9O3tvwtDvnqobkzyQcp9rk6AY0dbcXO0RqBzWgbwTVoFINf59G/cFYCnW+ihq10ev+aUaPYzXrP06rjI6fD5zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716773288; c=relaxed/simple;
	bh=6/StxCyaype9Wesuy1niVYA7wJrVCGQ/eXz/32yTm3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EikjzEv02Ov1HLpfHrV9Abr9T+SQFtBrsbmpmFwKc/Lei2PNW2GbUXNyJNU56AdDlttwaYN2qbiZhwydKISJz4Fkc89nOur7fgLOLVuoPhdM6yBjeviHCHxCdsjvLHyVitnN9AfX++qRa6bhtcO5M3dOlgPgOjx0XeFkU0Eb/94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V81Vo8r1; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V81Vo8r1"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B47E2401F3
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 01:28:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoU39T2jAkkk for <virtualization@lists.linux-foundation.org>;
 Mon, 27 May 2024 01:28:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2A5C940168
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A5C940168
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V81Vo8r1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A5C940168
	for <virtualization@lists.linux-foundation.org>; Mon, 27 May 2024 01:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716773285; x=1748309285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6/StxCyaype9Wesuy1niVYA7wJrVCGQ/eXz/32yTm3g=;
  b=V81Vo8r1B9Aq5g6HxOOlz8ciDe3S0VHOKmpvLaG4q08FZdYBLZOu9ZuS
   6FwuOzR+ot4LDmsDCnnVkHKUAl7gSEWntTuOXAUPv3/blEE+gv341TSkQ
   M5d7rrmxQRD4MiCr4FjudhbObyhqWDaegjUHzxbDpj0agjRENZ9Wrzy/5
   1x7TyHc9Lh/MkpdQL7QsrJ5ahAeZdJYP0NMCBCDtiqOvjBLwPRGDDkvus
   Cae5HL/Rb+qmKQo33zDS2ZatMly/lkKU/FNRVcgV6jth2jiaC5L+Ze8OW
   KBNwdqHlbfcpZOH0+sIZoGC7pSxK50/ttUaqjg+cdX66oLYKjW02NootT
   A==;
X-CSE-ConnectionGUID: u96AnCGfR7OFJm9WLn5dgA==
X-CSE-MsgGUID: H+toTCrXTfS/Dcw8JHonmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="11706906"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="11706906"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 18:28:03 -0700
X-CSE-ConnectionGUID: B7BhECx8RlKlPUiBhHRzAA==
X-CSE-MsgGUID: u/K9MU4dRbGbejdiDzbBvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="34677126"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 May 2024 18:28:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 18:28:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 18:28:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 18:28:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 18:28:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6tT5X7trv2KL8qf9IFYeVO11bW7U829a621cOm6nWNr8ocK8ZY20+a9OPcIJaSpb9FMR3/jGw66myaDtZ/g4zTZXhFqtApvH1ROKBEZT1ZHmQR4EgcozFJU3/3QsyuN68CPACyhMqHnm11IUTWYM+tgbP556N5xhICtAh5jGUvJ042GlKPPt07bqyJDIgDJ7U/MRy+vi+GN2QgghubPbH0nFaUbG3Yar5VgPGMgTuDBsQ7bZXx5lov0LwsTa8bRCdyJWiRpH4KM/D13nWWxb4d7GER6l6WdHoir0+pCrmH3qgYktzZ5+zw/P0BLlKDqLr9Qs4dvOlaEwWdkYTYvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/StxCyaype9Wesuy1niVYA7wJrVCGQ/eXz/32yTm3g=;
 b=k06qZs2B8pk/mmDMdIO5N3rTwPemDmph6SjSbXRZXot8xbeLCS7RdXj6dRXz6NYLCt2rUAlWfpItKKWsIRnSboYktxwbvX6nlyg+5DRUz+6lS4sNR4a4rk44qhTvMrCtaH1XKMiYnHkrLwNQ9Hegl9J1y6o+PYcAlkZ9L8HDSmua+RDbxB4UPeP1187zUpL2zZsGPi30tX8yPkicivu90fUNpZ0paC+38n8aBVQSP5FbTqEgmfWkLwTmH408SDVnzaTLqJyFxiyQytEHSFypUgO+dGpgv4+kGG0mpSPkEu4sSOBZ6gE3ttTK+xax4Essu0geXyMB1Zd54b1W2j5AkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Mon, 27 May
 2024 01:27:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 01:27:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Jean-Philippe Brucker" <jean-philippe@linaro.org>, Nicolin Chen
	<nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, "Joel Granados" <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
Thread-Topic: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
Thread-Index: AQHamw8bLYtOgdprmEKnPZxoJChdq7GX/cMwgAbATwCAANVHUIAAA3eAgAAUQJCABuhfAIAD3t9Q
Date: Mon, 27 May 2024 01:27:54 +0000
Message-ID: <BN9PR11MB52767CDCD1CDE43A3CC109D68CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
 <BN9PR11MB5276A68C9DCDA201826714018CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <04288162-e5fd-48f3-bb60-a41b4ed2c244@linux.intel.com>
 <BN9PR11MB5276EEE89AB66C0EFB6D4DA88CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524141506.GN69273@ziepe.ca>
In-Reply-To: <20240524141506.GN69273@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8346:EE_
x-ms-office365-filtering-correlation-id: 0e1977d4-100c-4b0d-7a86-08dc7dec3b92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?alJVWlFPeFJOWmREOHk5d3Y1V1NsYmdZaWdza0pQRHhxam8zbTRZMFc2bE8y?=
 =?utf-8?B?d2d1VXQrVWNBRE12dXNMdE9sS2xCWU5saWF2VHpucTZHOVBKVW14UUR0Rlda?=
 =?utf-8?B?dkhiZHArZFhCWExSZngyeUNMZWhubGtlcTFTYUliN0c3aERCLytMNTVWaE9K?=
 =?utf-8?B?N0krcThMRTF6aHNBNFIrQmR2ajVwbUtmcXM4WGZxSTZ4TnBiQkozSlJjMWRP?=
 =?utf-8?B?ck1nWm1Tb0hsRHlBVHZuUVlNQUs1UndUK21nY1B1SEp4ZDNoZG95VEttem8v?=
 =?utf-8?B?a05CRUJkZWFFU3Z1U3luSWNGQVEvZk1LOERtOTBCMVNSRXpSeVBaejFlUGxO?=
 =?utf-8?B?VlhyQnV6clJLUitxMmRIV2prbjkyODBpZjZnQ1ErSFdqM3RQdkNTa3FJOUpD?=
 =?utf-8?B?bTErTXpXNVcvdTBlNkpqSjQzK1lNZWVFcUpJQVhlR0k1SzA4OWRWbXFJSVk3?=
 =?utf-8?B?SHliL1hiM3NYU21uZ2VmNXBxZVgzT0hBUUVBTkJhb0NKYlZPVHQvTGgrSm9R?=
 =?utf-8?B?UzBRSkpJQ0FIWk9Td20zdVBLcFVWMkplcThZUXFTQkRaeFN2ZVQ4R0hwc1Nt?=
 =?utf-8?B?ajFiYzVJajRXNGl2WDVGc2EvMzdlU2F3YURpeXZUU2Z2UXlXazJvOVRDWitH?=
 =?utf-8?B?MElPbjZuM1ZFeDQ1S0Jxc2p5YnZaV2JTcS94cnhXVzQzM3V5bmt6eTJCUGlm?=
 =?utf-8?B?c0hDY1RjZHZJT3FnNXhzWWc3K3lVU2ptbDJlTDZzbjluK0JxY2JQSCs3dmhk?=
 =?utf-8?B?R1pIdXZSZFhFanlJTXV2ZEk5Sitwcm9BVjZwQjNpZk82bVRNS2cwSXNWVVhK?=
 =?utf-8?B?LzBINWpweC9MaEpvZGtMT3RwMkR2NzN2cjd5T0JDVE90c0dZQzgyaGNaMkJm?=
 =?utf-8?B?SXk4clBjZ3ZibnVOeHZBdXZINkJaRW1KSnAwV0pjbzN3Q2VvTit0V05TSVpl?=
 =?utf-8?B?MlJGS1JoaGpyOWZmWXZRa0o0bytjMzlwanR5YjA2aUdIR2huYXlIK2h6U0lx?=
 =?utf-8?B?MmRjUHpKbW1BU2F3a3dPeldNUG1FOGpHeFZaV1A4UE95WmJkVUZFM2VwOTNI?=
 =?utf-8?B?MFVhUDFvdW5VK2J2azd4c0k4NGRBSnZyZDgycDFaY283a2l3azR2alRMT0dK?=
 =?utf-8?B?Mzkrd3g1S1BhTFROS1FRcU40S3pQWTBhWkF2b3JkSm9HcFhSMU1wL21XNTRr?=
 =?utf-8?B?bERZQjVNSE1XZDZzTWlpYmVEdVFZdjRKcE1sU3ltaHdNbXlTRlUvOHBvZmtB?=
 =?utf-8?B?OEUvUmpvNXd6dXpTTE4wTkFFZkJKSHdFcGFGNzN5KzBSd0FQcmpReUthS0NZ?=
 =?utf-8?B?bk0za3d4NDNzVXJUV3dGdWdWK2RXQnArUUNWTXpmbWJmZmo1M0ZodkoreFdX?=
 =?utf-8?B?ZTdxcTliMGRzK2JyMmxRbDgwNEJTRFJVaFdiZG45bTg0d3FNcTJpV1F0ZlNO?=
 =?utf-8?B?dnZ3RUhuYW5CMU5lUUN6TS8rWkVMTEdFc0dtU1lSMmw1b2dkWjlycHI0VFcv?=
 =?utf-8?B?aWVUeXlLRTc1R1JtTmJkTDZBcGJlK1V5L2tGWjhRVXYyRTJ1L3lmbkpIWnhB?=
 =?utf-8?B?QWtCTUZIQktpc3c5R0dhWUs1YTRMMHlMSktzdmVLMCtRSmNoYlJGdzFRemtJ?=
 =?utf-8?B?TCtOWmhDbUhnRmxObmxpU2pLVjlOenRTSHd4SU85dDlqR0I0c2JoaU0vY1U5?=
 =?utf-8?B?TjkzbXM0RDNLRUx3Mm5PNUtpS1lNekpsT21sNWxmdWpHZ1RUeklMWnJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0JsOVA0YVhCRzZyOHpPUlpuWGFQMnowQmhkbjZQUTBKRUNlNVlJNUZqNU9W?=
 =?utf-8?B?R0E4TzlIUEI1OUpka2RabVpDMktuRmlLRHdEUjZFemJFZXFBZFUrNTlHY2g5?=
 =?utf-8?B?U1lRUG95K2tGTmtoZTBrK0YwWlA0bEl2TW1uS08wWlNnYTNsYmR2cHhybkdi?=
 =?utf-8?B?dkM5K2pzVWRzNUh2YnFIUmxYbzZUeDBSaFhyNHRCN0Nvd1ZPV0ZlUTZGSEhl?=
 =?utf-8?B?ZFd3dTdBT0RzVmdzU3AvMVRBM1pUT0tCVTdsZHZxZ0lJZHBTQUd0NHVlYXcv?=
 =?utf-8?B?ekU2bWVyblpqemtKK1pRbFRVYkowTFBqcVl3ajcrS3pmUnUvRkVSV3VyYVJu?=
 =?utf-8?B?bU41NHFZcmN1dHVUN0RKVUdpTUZvT1R5ekdFUmwrc0t6K3ZuanlwMzYzVHhR?=
 =?utf-8?B?eE9RWHJjVGdXVXNpamhVcDZvRkVCRDhIMVVCbEwwQ3FhV3Z6cldzV0FNOVcr?=
 =?utf-8?B?aFpGZUtQaWE2cmpuemxIQVV5anE0WUpERENiRjdTOUZieGFvelBXTkxPbzE5?=
 =?utf-8?B?a3Z1dDE3cmJMK0JtdzdhZWZFaitJOVRJUW1GbGdycXJnSWIrQkltT0JKWkFE?=
 =?utf-8?B?cXFmZUNGOFZudWFjVUt2enJzc1AzakZ6ZjZ5Q1ZuZmQ2NWFlYXBjcjNMOVVi?=
 =?utf-8?B?N3FPUVZVVTFsVXVJc3Fob1RYWFl4V1FhZUlTNjludG8wTkJrdzZoaWZOdThP?=
 =?utf-8?B?YnpJajNZVXd0K1VKdFNjaG82dWpMK3FyNnNYZ0dhY3UycWJTRGtDb1JnWEov?=
 =?utf-8?B?T005Q3dRTjluK0JZdTA0N2N6dlB5S0MwcGRMN0F3cEswUW9BeUxmRzc0K1Mv?=
 =?utf-8?B?RG1OU0U4VlI5c2dLYnVadElVcXNLU0ZsaU12U3Q5Q0hIaTBZTkhqY0E3K0hM?=
 =?utf-8?B?UzgvSkVVWXh4c3c3bTFBd1BpN1N2akN2emZBS3NYWFkvY2toRkZvVmdyRHh1?=
 =?utf-8?B?Q0pUZHJlcnZaU0NpOHBKcXlNblRsbzJkSW5xMXN2dlpTdktCK2w3VWtxd09a?=
 =?utf-8?B?ZjU1U2FtZXUwV2F1Q012TmZBTndSK0VjNGM4SDg0YUNQY0w5VzJPeG1DN3lP?=
 =?utf-8?B?ZTdFOUROUE11MXhVSEJkbEs4dlJxNE12UDZpeENtZWZHdExzVk1VdVUrODZS?=
 =?utf-8?B?Z1cxZHA1Zllzdzl0VVVvMFJoQXdOSHlXVW15bTExT3cwbUp3QktPTTJCa29a?=
 =?utf-8?B?cWdUQW05bXltY2thTnplNFZnTXdDenVrTStISUVReE05SGp1R0hmMlNGY3lj?=
 =?utf-8?B?cHAwRkFNNDUzQXJVNEozdytLQy94TnJqTDYwZHlXRkc1RmxTV1UwaUhlSFls?=
 =?utf-8?B?eVNtT1dZcXFpMGRUM0JLazBOemg1bkpjNkpVSlZJVWYyeGxrZ2s4Z1F2bjhS?=
 =?utf-8?B?S1JORU5jamZTRzRpcU92STBjeFVsbHc3ck5sNi9DREpNbDV5cVhEYkpycG44?=
 =?utf-8?B?M2NuNHFtSUxsblR4V0hmcmZEaGhIQTZ1cWtZb3JRNlIrU09ERnNMcFB5V2c0?=
 =?utf-8?B?eWlHdXJWbThWWE95UGZrT2FCNGR2Smx3MWRPWDRON1ZqYlJQdTZQL0lZNmdz?=
 =?utf-8?B?bm0wYnRLdDRuOHlHekY1OEp5cGF3MmtTYU9xWktIbGNlRldUbERUanBXZkRr?=
 =?utf-8?B?NW5Ka1JQcUtMSFJraThBR3o1M1BpTUhuVUp5VytmbGs4eXdjcXZ2UkxNUzNB?=
 =?utf-8?B?QUxJdzFDVVVuNytLWDRTRGNVZkgyRkh0UEhrMEl0clBqVTBqclhEdWo4dHY1?=
 =?utf-8?B?dEFNcW5KcEZkUUlVMUQvRkRMengrc0U2ZG8zOE52dktRREs0SGM0c01jczJX?=
 =?utf-8?B?MG5UdGZudU02b1E5aXdiNnVJZ05sNnJ3bWJFV3Rac204dTlUL2FqYXNLdTBh?=
 =?utf-8?B?WksxQ3ozcVNLUTdNTFJiU1BqNW9WM2djeHBQTlpWY0x6L1FSUzBoL25aUXZE?=
 =?utf-8?B?Y1RYdWd6RUlwZ3U2MnRxUnVEdU9abU0wV0Y3RlpvaThnSHVEQnlwbTAzK25k?=
 =?utf-8?B?QW5TUzBITitxMHBwL2FiQzRncWtuMlhMNmxWOVp5V0FWb1VOMmFRWk9ISytO?=
 =?utf-8?B?aUFld2lOTmc0REdEUmdoQ3VQN0NyTVNCZ3hNOHFxVUF6dDVIUXhXdHl5dVor?=
 =?utf-8?Q?g0Y0DSQIQbNJvvZPKIhYdemZW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1977d4-100c-4b0d-7a86-08dc7dec3b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 01:27:54.4844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxGjnImRdJpeQ+K9Omob8WjJuO5DErwNz5mijOWG7OlCh+bmpRBrkHsBE0MODRUDecXCtSaFloI2l/DWLJ5j+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gU2VudDogRnJpZGF5LCBN
YXkgMjQsIDIwMjQgMTA6MTUgUE0NCj4gDQo+IE9uIE1vbiwgTWF5IDIwLCAyMDI0IGF0IDA0OjU5
OjE4QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTogQmFvbHUgTHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgTWF5IDIwLCAyMDI0
IDExOjMzIEFNDQo+ID4gPg0KPiA+ID4gT24gNS8yMC8yNCAxMToyNCBBTSwgVGlhbiwgS2V2aW4g
d3JvdGU6DQo+ID4gPiA+PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29t
Pg0KPiA+ID4gPj4gU2VudDogU3VuZGF5LCBNYXkgMTksIDIwMjQgMTA6MzggUE0NCj4gPiA+ID4+
DQo+ID4gPiA+PiBPbiAyMDI0LzUvMTUgMTU6NDMsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4g
Pj4+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+ID4gPj4+
PiBTZW50OiBUdWVzZGF5LCBBcHJpbCAzMCwgMjAyNCAxMDo1NyBQTQ0KPiA+ID4gPj4+Pg0KPiA+
ID4gPj4+PiArICogQGxlbmd0aDogYSBoaW50IG9mIGhvdyBtdWNoIGRhdGEgdGhlIHJlcXVlc3Rv
ciBpcyBleHBlY3RpbmcgdG8NCj4gPiA+IGZldGNoLg0KPiA+ID4gPj4gRm9yDQo+ID4gPiA+Pj4+
ICsgKiAgICAgICAgICBleGFtcGxlLCBpZiB0aGUgUFJJIGluaXRpYXRvciBrbm93cyBpdCBpcyBn
b2luZyB0byBkbyBhIDEwTUINCj4gPiA+ID4+Pj4gKyAqICAgICAgICAgIHRyYW5zZmVyLCBpdCBj
b3VsZCBmaWxsIGluIDEwTUIgYW5kIHRoZSBPUyBjb3VsZCBwcmUtZmF1bHQgaW4NCj4gPiA+ID4+
Pj4gKyAqICAgICAgICAgIDEwTUIgb2YgSU9WQS4gSXQncyBkZWZhdWx0IHRvIDAgaWYgdGhlcmUn
cyBubyBzdWNoIGhpbnQuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBUaGlzIGlzIG5vdCBjbGVhciB0
byBtZSBhbmQgSSBkb24ndCByZW1lbWJlciBQQ0llIHNwZWMgZGVmaW5lcyBzdWNoDQo+ID4gPiA+
Pj4gbWVjaGFuaXNtLg0KPiA+ID4gPj4NCj4gPiA+ID4+IFRoaXMgY2FtZSB1cCBpbiBhIHByZXZp
b3VzIGRpc2N1c3Npb24uIFdoaWxlIGl0J3Mgbm90IGN1cnJlbnRseSBwYXJ0IG9mDQo+ID4gPiA+
DQo+ID4gPiA+IENhbiB5b3UgcHJvdmlkZSBhIGxpbmsgdG8gdGhhdCBkaXNjdXNzaW9uPw0KPiA+
ID4NCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LQ0KPiBpb21tdS8yMDI0MDMy
MjE3MDQxMC5HSDY2OTc2QHppZXBlLmNhLw0KPiA+ID4NCj4gPg0KPiA+IFdlIGNhbiBhbHdheXMg
ZXh0ZW5kIHVBUEkgZm9yIG5ldyB1c2FnZXMsIGUuZy4gaGF2aW5nIGEgbmV3IGZsYWcNCj4gPiBi
aXQgdG8gaW5kaWNhdGUgdGhlIGFkZGl0aW9uYWwgZmlsZWQgZm9yIGNhcnJ5aW5nIHRoZSBudW1i
ZXIgb2YgcGFnZXMuDQo+ID4gQnV0IHJlcXVpcmluZyB0aGUgdXNlciB0byBoYW5kbGUgbm9uLXpl
cm8gbGVuZ3RoIG5vdyAodGhvdWdoIHRyaXZpYWwpDQo+ID4gaXMgdW5uZWNlc3NhcnkgYnVyZGVu
Lg0KPiANCj4gSXQgaXMgdHJpY2t5IHRvIGV4dGVuZCB0aGlzIHN0dWZmIHNpbmNlIGl0IGNvbWVz
IG91dCBpbiByZWFkKCkuLiBXZSdkDQo+IGhhdmUgdG8gaGF2ZSB1c2Vyc3BhY2UgbmVnb3RpYXRl
IGEgbmV3IGZvcm1hdCBtb3N0IGxpa2VseS4NCj4gDQo+ID4gRG8gd2Ugd2FudCB0aGUgcmVzcG9u
c2UgbWVzc2FnZSB0byBhbHNvIGNhcnJ5IGEgbGVuZ3RoIGZpZWxkIGkuZS4NCj4gPiBhbGxvd2lu
ZyB0aGUgdXNlciB0byBwYXJ0aWFsbHkgZml4IHRoZSBmYXVsdD8NCj4gDQo+IE5vLCB0aGUgZGV2
aWNlIHdpbGwgZGlzY292ZXIgdGhpcyB3aGVuIGl0IGdldHMgYW5vdGhlciBmYXVsdCAgOikNCj4g
DQoNCk15IHdvcnJ5IHdhcyB0aGF0IHdlIGNhbm5vdCBwcmVkaWN0IGhvdyB0aGUgc3BlYyB3aWxs
IGRlZmluZSB0aGlzDQpleHRlbnNpb24gZm9yIG11bHRpLXBhZ2VzIHJlcXVlc3QvcmVzcG9uc2Uu
IEl0IGNvdWxkIGFzayBmb3INCmFkZGl0aW9uYWwgdGhpbmdzIHByb3ZpZGVkIGluIHRoZSByZXNw
b25zZSBtZXNzYWdlICh0aG91Z2ggbGVuZ3RoDQptYXkgbm90IGJlIGEgZ29vZCBleGFtcGxlKSB0
aGVuIHdlIHdpbGwgaGF2ZSB0byBleHRlbmQgdGhlIHVBUEkNCmFueXdheS4NCg0KU28gSSdtIGZp
bmUgdG8ga2VlcCB0aGlzIHJvb20gaWYgd2UgY2FuIGZpbmQgYW4gdXNhZ2Ugb3RoZXIgdGhhbg0K
cmVseWluZyBvbiBmdXR1cmUgc3BlYyBjaGFuZ2UuDQoNCk90aGVyd2lzZSBJTUhPIGl0IHRyaWVz
IHRvIGd1ZXNzIHRoZSBzZW1hbnRpY3Mgb2YgYSBmdXR1cmUgc3BlYw0KY2hhbmdlIGZvciBubyBn
b29kIGF0IHRoaXMgcG9pbnQuIFRoZW4gY29uc2VydmF0aXZlbHkgSSdkIHZvdGUNCmZvciBub3Qg
ZG9pbmcgaXQgbm93LiDwn5iKDQo=
