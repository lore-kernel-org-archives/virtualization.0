Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9414285
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175618; cv=fail; b=UUpgQ5yHxcOtwDFa6z+JK56ZvM8BXopSQg/y25PV6wlY+EqMdgmCba1k5odyEFOQMaFU5PtWth0A2o2DKkHahTGGH/gnonFm1/AT490149EdPlCYCsF0xYCwBCp9xuas5OnSRrqhi2ifaB7O6PTpTYL2RTQPU8kzlVTgKNWRWps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175618; c=relaxed/simple;
	bh=CxVk1lRAjJQOrDIrysqZx3QelTgSSNY3v7Nz74IVtPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Br5A9InB1dubVlmXGdjhpngC4FdkOSY6geWuBowfHpGPZipYkf2m1I1d2obRN9LRL1HUMM01skXcyNQ2FIDrp24q2LZLV0H2p89/7BJGArTEEe+0GApEExLEOpOApDrrjBfOWN3jMsiOm9ST+2HtQ5AzqH9YRQ7EnCxwQ3WzJmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dF+HfQhe; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dF+HfQhe"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D60746070B
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:26:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOWCFtxU8Q8h for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 03:26:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5AB29606B4
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AB29606B4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dF+HfQhe
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5AB29606B4
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716175616; x=1747711616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CxVk1lRAjJQOrDIrysqZx3QelTgSSNY3v7Nz74IVtPI=;
  b=dF+HfQhe1sOPk+WIo54TrZDpahE5xk5Pl23xwtbgpeJRrBWyS9RaoOLi
   FeQFhFmAjTxAnSYxlfk5sQTTWK3EOzeJytES3iT/KNawgKGN40BhZwA/9
   Dp7L0lnHSYpKHUDka6GhG8tZqwgAXdW1b2r8ZwhwUfCrQtP8mbPhmAK6d
   vP+/9GoYlG+Dl55/tZLMwShBODzCL0tEdltuUwsg01l/BkXnMMS5Ybo3q
   w3PYoOuES1FUsYsmlkYOy0ibvvx2v4CxxjcBkUNKR5lsO9IW2VQBQrP0/
   IurP1mBSNDqnRAqndUzrLFVqnAkkiMNCq/jiyO9DZr7FFgeLtYg1aI3/+
   Q==;
X-CSE-ConnectionGUID: pIiH2N2mSI+qZflw4ShRSQ==
X-CSE-MsgGUID: ShqLDUdBQbuOKdIEuadxVg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="23426471"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="23426471"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:26:53 -0700
X-CSE-ConnectionGUID: JL77GzeOQsGuHvXD8cTGaQ==
X-CSE-MsgGUID: V7S2g/ppTqSC0YDk3Nqj8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="55616009"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 20:26:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:26:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 20:26:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 20:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqiUKI7B/crRIjFubM5ji3ULBvOJuTTzBaMKHKLQX9zMa90FtS9sbTXZnwA921A6R9gUi9aKXW7uZT9hvglu04xsv8/CB5ZlNoicilcSyB644MNKAVxnAdseOHeO/K05BEQTPDDxPpzOdaICytf8lmjLGBKVTUzbXLbxJavXZVjvPCr1d2Uz3eoYn3K3oXIx0miAVnNFJfLAt6tFzS6MDzh8bJ2ogp4zg/lBkQ5XTxlvUWkRa0M9zzUUjfvbv/gT8x8uam+adqgFg7qy9ztYvciMSzAZk+BNv43AdK5EF9UNA9LqyVoOHyoxwx3G+sroz1AtdVevGH8lMzzpPTWkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxVk1lRAjJQOrDIrysqZx3QelTgSSNY3v7Nz74IVtPI=;
 b=igcWeTb1JSRxkgkh3PrPS53YNCXsyUMTJWyY9vv0F08pq4QfOkIrRkyoI5dh2a7m0DlJ/Tw8Lny+8uGforLVNBfvBoF//hWLEY2MGI1qlodJA1ZQRiRDbc5didXNJVtH94XClB0DazWhAap1s2IKwpnnwE//QmoCOKpbKJqM6DI0hsymXuFFA/xUGSHbn06kgyC3kjiXd/vm8yRA/HGPvuALsYMjn/LzVQ0MSfYBhJLf87vF0yc0nwx0ulydrOfPOW+Zx05+J4RmBWxWTgCBod4a14E3Dghgyf20IUCGbMcZ51SgKO+DfcgwuLYRvKqQyWlG2pEmW8xF7Y+QIXjJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 03:26:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:26:50 +0000
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
Thread-Index: AQHamw8IPv7IV85GSUGxhOe1hMt7NbGMgmSAgACl5ACACtl+gIAHZQAAgAAtvbA=
Date: Mon, 20 May 2024 03:26:50 +0000
Message-ID: <BN9PR11MB527685B9D96675AA8A3CE78E8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <20240508001121.GN4718@ziepe.ca>
 <a03d3bf6-0610-427c-bf2a-5f6c410e220e@linux.intel.com>
 <BN9PR11MB5276F21755C883FE7EC784228CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <733e3788-d303-4b75-aa97-d97489a7f0bf@linux.intel.com>
In-Reply-To: <733e3788-d303-4b75-aa97-d97489a7f0bf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: ff070195-6ecc-4d5f-925e-08dc787cafed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OGlJcEl5UHFYK0NCaVQwNlFkaEZKNk9kZVFlUVRKNGRTZWdjc3UyU2xKN05i?=
 =?utf-8?B?RFJuMkFLTkhvK01WbExjNXpLaG5uZEpMLzRuQzF6WlZpdEhBaFArczVWT1RQ?=
 =?utf-8?B?VkR1M3pXVncxZ0VocTV2MjBQbEZWMkpOeFZ1YkpXOTJuRVpkeTZMMVFyUUJE?=
 =?utf-8?B?MUN2R21yZm5OUzZ1bnNwZEVqTi9NMWVVaTFRRWpqTEFBZjZndGlaUC9sVkNP?=
 =?utf-8?B?RjZtS291bEpsTkRMd1YxMlNlWlgvUjk1N243dHBVb0piMnc5d281Q0h4OG16?=
 =?utf-8?B?U2dJRXAvS0R6L0hxNjhCK3Q5aThjNWhZQ0kveklMeWsyeWhrTVkvMVFtYm1u?=
 =?utf-8?B?TDdjZ0F3cmR5UWR2TnlaMDhQYkxpY3d3SUgxWDlvZnFHYUliTGZhRmw3NG5Z?=
 =?utf-8?B?d0haKytSVXMxcU1qbWdWMDN2LzkyMm5zcElEVG95Y0tTQzVaUW0rdGtKYWQ5?=
 =?utf-8?B?WnU4M3psZmltSHlLZFpGdEkvSzhzQkVYbC9IRnM0ZU9kb2lJSVZhSnV4WmJG?=
 =?utf-8?B?WW11dUl0QTd6QU9oamMzT0tlSDY5L09ENjRyNnBlakdTRUM3aDBnRDh5TVow?=
 =?utf-8?B?VnV3OWxvOERBU0N3RzVIbFZrZm5BM1duREs5cmNGbFlIM3BHZ2xtSG01M2wv?=
 =?utf-8?B?MS9OQ1ovWFpmRXZ6L2w3U1Z1RzJnK2tpWUFsOWZZU2MxVE9PN0w2UU52c2lH?=
 =?utf-8?B?NmI2MTFaSzBWbVI5dlpaN3NuTWwzVFFxSERZdDVPcThMeXhBdWNDS3dMTFZr?=
 =?utf-8?B?Sk5qc3Zvbk5uZStlL1BpczJaZXdBZnZxTWIxNlMvZ1JYY1E0L1dpWEhLN1E1?=
 =?utf-8?B?QUpTdzZpU0FMQ25qMVJzZ1RzU0FqR09xOWl1OWkxelhwNVRCc2p3MzJTUnor?=
 =?utf-8?B?WWhlTHVXc202VkUyVVRRYnNYRVhpQVpObXV2TWFtV3QzNWptOGZsQVl1UnJ3?=
 =?utf-8?B?Q2dPY2F6Wm1PeS9WNUdGRWZIRCtOdFlkRGxGa0l0WUFVc0xTMFZaNVNwYnZF?=
 =?utf-8?B?R1BXa09wdmtITGdVNnBvMFBxLzE2eldqdWNxUmpnZUMwVTQ5RlNDWkdUUVVy?=
 =?utf-8?B?elVRcE1rQWFzVUU3eCtUNVVOL1BxYlN5cFB3V0Rjd2VEOHh5UEdJdlhlWDV4?=
 =?utf-8?B?NnovMVh1ZERxazE0c0hQVGpnTkJQTnF0YkZIWnpGaUh1KzhHbzBlS21CZjBa?=
 =?utf-8?B?SmE0U081S3RuRDNBRHI3WDB3UjhScS9ESEczbnFleEJWcHd3YldnSS9TOG1O?=
 =?utf-8?B?UXRZU3dqTG5Qck5jZVlCME83UGVKdGs1dE9sU3UwQVN4K2xxbjkwbFVMTEpT?=
 =?utf-8?B?NC9PVFE0UlJXcUxFUzVrdmNtMEJsaXBWNnppMFhyQzVwUnBtVmJBSEtlMllU?=
 =?utf-8?B?TUpxNXN6ZEErZ3U4dno5VmVaRnBBYWVmNFhjWkc4QllIRzJjK0U0OWFNTlFF?=
 =?utf-8?B?V0ZiSFUxYldnU3E2MzM1NWJsUlNrTEpZWWptak51T3pVb3J2Zi9CNy9ja2tG?=
 =?utf-8?B?VEQzQUo4OFlPa2MvQmtMMFFzS1l6cXNoVnVuNGRSemNYek05UEowbkFDbEN6?=
 =?utf-8?B?TVFJMHhNby82bnk0VE9vOEF0SzYvWmx6Mmx1NFpMSmVuTmRMOVgwdlJ4akNR?=
 =?utf-8?B?bWNWQXdRWGlNckY3Yk14YzVDekhuSHNRV25PbUxmN3UyOHo0UnY3Qi83OFB1?=
 =?utf-8?B?NzFvRis1a3RaYnBCR1JPcVlUOXZPWXZPT29HY25uUmo3YzFkVm1oNDJTY3dQ?=
 =?utf-8?B?c0w3bGg1N1JOMVdTRVVPMThyWExhU3NGSDFONEF4a2NIRm9rZlh3dmlZVXJq?=
 =?utf-8?B?cnRneGpJRldDeFV0WW1BUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU1UckRJdTdlUXRvYzBaR1Q5RnJwdEYzdTJrYXBDanFaa2tNckRsLzBKblZz?=
 =?utf-8?B?cWV3VE03VExxNXludHpvV1Nsdmx5TXVERXplODRKRmF1MTRFOVRscUZqRllN?=
 =?utf-8?B?dkRvQU83MFhLeVArKzZSbk1MaW05Q1NVMTN2YWN3OXZCZVRJdys0SUhPY3BB?=
 =?utf-8?B?WndEMlhSVE0zdk5yVkhSZGRjWVhsYlMxUWwzRTZrUEZ3OFFwMyt3ZkNQTW9x?=
 =?utf-8?B?UjVxWWFFVmkrY3pHbUdxc3JndFRjMWZDazU0MWk2aG43Mlp3dnYxaTA2RWs3?=
 =?utf-8?B?R3JwM2tIUVNTNHRLU25Pa0xneG1WRjhranJRVGpxNVpWK3U0SXBHVHdwSFFw?=
 =?utf-8?B?WEw4RXdVK1JtUEdLcnpSVStEZHI4a2NrdkV3QkZINXRhL3EzdnJSdWkrSDlz?=
 =?utf-8?B?UjBhcXJFUW5ubGZ4UU1UdDRzQTRiRmlCYkJJeDRIQi9EVGhjaS81VnAxdEJK?=
 =?utf-8?B?a0M5UG5CYWVVNGh0Mkd3M2hsWHI1cGhGNVpBSXNBdW0zTGJlem5wRGtQdkpS?=
 =?utf-8?B?Zk1QWVdQQThIb0ZFZmNpN1VqMnRVbkpkMzF6bkZrV0JQcnpvZlNlV3EvMGJh?=
 =?utf-8?B?TjdnZ01aMmdxVDRZVk42SzVsQ21DWS90QW1vNmZSQmYzNGp2aW5iMG9RNzZS?=
 =?utf-8?B?QXNOdUw3TlBkd3IyVXJTZ1R1U2x6bGN6ay9WUVZoTHJHQkZ6ckk1VmpzWkV3?=
 =?utf-8?B?VUxkK0ViUkFlTnZRU3hiRlB0RGZQeStBR3N6bTdZN1dtZHEzdmlwU2VKL2JS?=
 =?utf-8?B?M0VmV0VkRk5NNUpMT0gyaVJZZzErWEQ3SDhnb2ZqU1RPUlhydU5pYkR0dWJv?=
 =?utf-8?B?eVREM04wbUlQQ1R4TmRkYUhVM0hoQk0zVXV1bXZ1RkRTUlZqLzlFeExDTGlw?=
 =?utf-8?B?TTloNXh4U3pUV3g1VkN4MG81Tlhidi9mbXFXTmcwRkRldU1kaTZta2lMTGpE?=
 =?utf-8?B?VDVwU2pVMW1abEw5c3hWeDJxazJiSEhnaXk0MW80aytsZTU2YzBxTWlhNmNv?=
 =?utf-8?B?REJsd2RiZHdLa24xQUZJdEVWZVZQZzBLNlhnRUREYnZqck9wdWo3d3B4d0tz?=
 =?utf-8?B?blcwbmZNK04ybkhhMy8wY2J1dW5aUnVMRE9Ya0xTcHB6MzBvS3E2OHUxY0N6?=
 =?utf-8?B?RWJyWnZGTXRMbkZEWUxDaFJzdEJ3VElQd1AxN083TFMyUWprZ0pSUnZaeEox?=
 =?utf-8?B?Ykc1RnBBUWovSjdsWlAzVGVDSW41dXh3bTdRTytsSFJmNGV5TU8zZjdHNWhs?=
 =?utf-8?B?YTNINTBiTkRzSUFkSkF3bUhSNklaaHo1T2hEaWNiSS9hSHZDbFlrQ0VxNHZa?=
 =?utf-8?B?YVV1ODZaVWZrakhiaVk1aWRHaDBERFdyckt1amIxUEJEdlhnWGdjY3V3Y2s1?=
 =?utf-8?B?ZGZoZ1ZQbk95WDg5L2Z3OEZSN0c5bmNmQXdIUDg3QzFXSlZxTmtzMGQraHl3?=
 =?utf-8?B?RFBadFFKUXIvRWlKMGRUdzBoOTJ4QUNrVXlaQ1hFTWs2WnRGYkxzbzl0eFdr?=
 =?utf-8?B?WmdPNmZQeEsvWnA3L2ZJZ0FHZ20yTk9yRmtKRlU2WHFzbXo2UTUySkRGa01m?=
 =?utf-8?B?YkNDa2IxM0s1NXpJTzQzRlZ1MWpNTDFyNEJwN1hMUVU3SlR5eG1FQmdKRDNv?=
 =?utf-8?B?NFJnQjZSelpkb3ZFVnJkZmVMTk5wOE01Rlh1SWErcjRPRUswWThCK21EWGpk?=
 =?utf-8?B?YWhpNjU4WkN5d203SVdHQm5mbjFyN0FJUWdya0dvenJrNmV1bXRvUGg2aFdT?=
 =?utf-8?B?VUpEUWI2Y3BkbGtNRXlmV21CWWRYVWlWQlNNNmxmWHFRREVPWDJ2clgxQkFU?=
 =?utf-8?B?MjVqUVZhZEQrSldBT20wVHpGOEVjTWZSenRsRjBWVloyZkZsOGY3SzhWelh5?=
 =?utf-8?B?bXJTeHVTWXF3dUx1Y0tKVjQ4d3doZURJYUEvQzNXYmNEK05HVmorVGYybHhn?=
 =?utf-8?B?WkE5NHJrc2RsdlZnbEhxWHZwUVlGN0FmU2tQVnlaQ2VIbzg0Nnc0MjNhdXF4?=
 =?utf-8?B?WlN6KzFXTDlIWlVDazVBOHNYN0V5b2JYaWx1Z2cvMEl5aUpmbzhKV1N0d1cv?=
 =?utf-8?B?MXRQZnNCUENLZG1lbmI0R1NIVmNnTnpvbTIwcS9aaGN1eUtlTFNqYXUwcjNH?=
 =?utf-8?Q?zI0SoHTR54//MaEUhbt5epfYH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff070195-6ecc-4d5f-925e-08dc787cafed
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:26:50.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nl244JMU6ZlDjapR03kXSOFCE14mmBB9FUh2TyNtMjgyU9HpZPGakmBvYcyTUx6Sad70F3zIJEKFYZIwYnpPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE1heSAyMCwgMjAyNCA4OjQxIEFNDQo+IA0KPiBPbiA1LzE1LzI0IDM6NTcgUE0sIFRpYW4s
IEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwu
Y29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE1heSA4LCAyMDI0IDY6MDUgUE0NCj4gPj4NCj4g
Pj4gT24gMjAyNC81LzggODoxMSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+Pj4gT24gVHVl
LCBBcHIgMzAsIDIwMjQgYXQgMTA6NTc6MDZQTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6DQo+ID4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUtcHJpdi5oIGIvZHJpdmVycy9pb21t
dS9pb21tdS0NCj4gcHJpdi5oDQo+ID4+Pj4gaW5kZXggYWU2NWUwYjg1ZDY5Li4xYTA0NTBhODNi
ZDAgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS1wcml2LmgNCj4gPj4+
PiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LXByaXYuaA0KPiA+Pj4+IEBAIC0zNiw2ICszNiwx
MCBAQCBzdHJ1Y3QgaW9tbXVfYXR0YWNoX2hhbmRsZSB7DQo+ID4+Pj4gICAgCQkJc3RydWN0IGRl
dmljZQkqZGV2Ow0KPiA+Pj4+ICAgIAkJCXJlZmNvdW50X3QJdXNlcnM7DQo+ID4+Pj4gICAgCQl9
Ow0KPiA+Pj4+ICsJCS8qIGF0dGFjaCBkYXRhIGZvciBJT01NVUZEICovDQo+ID4+Pj4gKwkJc3Ry
dWN0IHsNCj4gPj4+PiArCQkJdm9pZAkJKmlkZXY7DQo+ID4+Pj4gKwkJfTsNCj4gPj4+IFdlIGNh
biB1c2UgYSBwcm9wZXIgdHlwZSBoZXJlLCBqdXN0IGZvcndhcmQgZGVjbGFyZSBpdC4NCj4gPj4+
DQo+ID4+PiBCdXQgdGhpcyBzZXF1ZW5jZSBpbiB0aGUgb3RoZXIgcGF0Y2g6DQo+ID4+Pg0KPiA+
Pj4gKyAgICAgICByZXQgPSBpb21tdV9hdHRhY2hfZ3JvdXAoaHdwdC0+ZG9tYWluLCBpZGV2LT5p
Z3JvdXAtPmdyb3VwKTsNCj4gPj4+ICsgICAgICAgaWYgKHJldCkgew0KPiA+Pj4gKyAgICAgICAg
ICAgICAgIGlvbW11ZmRfZmF1bHRfaW9wZl9kaXNhYmxlKGlkZXYpOw0KPiA+Pj4gKyAgICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQo+ID4+PiArICAgICAgIH0NCj4gPj4+ICsNCj4gPj4+ICsgICAg
ICAgaGFuZGxlID0gaW9tbXVfYXR0YWNoX2hhbmRsZV9nZXQoaWRldi0+aWdyb3VwLT5ncm91cCwN
Cj4gPj4gSU9NTVVfTk9fUEFTSUQsIDApOw0KPiA+Pj4gKyAgICAgICBoYW5kbGUtPmlkZXYgPSBp
ZGV2Ow0KPiA+Pj4NCj4gPj4+IElzIHdoeSBJIHdhcyBpbWFnaW5pbmcgdGhlIGNhbGxlciB3b3Vs
ZCBhbGxvY2F0ZSwgYmVjYXVzZSBub3cgd2UgaGF2ZQ0KPiA+Pj4gdGhlIGlzc3VlIHRoYXQgYSBm
YXVsdCBjYXBhYmxlIGRvbWFpbiB3YXMgaW5zdGFsbGVkIGludG8gdGhlIElPTU1VDQo+ID4+PiBi
ZWZvcmUgaXQncyBoYW5kbGUgY291bGQgYmUgZnVsbHkgc2V0dXAsIHNvIHdlIGhhdmUgYSByYWNl
IHdoZXJlIGENCj4gPj4+IGZhdWx0IGNvdWxkIGNvbWUgaW4gcmlnaHQgYmV0d2VlbiB0aG9zZSB0
aGluZ3MuIFRoZW4gd2hhdCBoYXBwZW5zPw0KPiA+Pj4gSSBzdXBwb3NlIHdlIGNhbiByZXRyeSB0
aGUgZmF1bHQgYW5kIGJ5IHRoZSB0aW1lIGl0IGNvbWVzIGJhY2sgdGhlDQo+ID4+PiByYWNlIHNo
b3VsZCByZXNvbHZlLiBBIGJpdCB1Z2x5IEkgc3VwcG9zZS4NCj4gPj4NCj4gPj4gWW91IGFyZSBy
aWdodC4gSXQgbWFrZXMgbW9yZSBzZW5zZSBpZiB0aGUgYXR0YWNoZWQgZGF0YSBpcyBhbGxvY2F0
ZWQgYW5kDQo+ID4+IG1hbmFnZWQgYnkgdGhlIGNhbGxlci4gSSB3aWxsIGdvIGluIHRoaXMgZGly
ZWN0aW9uIGFuZCB1cGRhdGUgbXkgc2VyaWVzLg0KPiA+PiBJIHdpbGwgYWxzbyBjb25zaWRlciBv
dGhlciByZXZpZXcgY29tbWVudHMgeW91IGhhdmUgZ2l2ZW4gaW4gb3RoZXINCj4gPj4gcGxhY2Vz
Lg0KPiA+Pg0KPiA+DQo+ID4gRG9lcyB0aGlzIGRpcmVjdGlvbiBpbXBseSBhIG5ldyBpb21tdV9h
dHRhY2hfZ3JvdXBfaGFuZGxlKCkgaGVscGVyDQo+ID4gdG8gcGFzcyBpbiB0aGUgY2FsbGVyLWFs
bG9jYXRlZCBoYW5kbGUgcG9pbnRlciBvciBleHBvc2luZyBhIG5ldw0KPiA+IGlvbW11X2dyb3Vw
X3NldF9oYW5kbGUoKSB0byBzZXQgdGhlIGhhbmRsZSB0byB0aGUgZ3JvdXAgcGFzaWRfYXJyYXkN
Cj4gPiBhbmQgdGhlbiBoYXZpbmcgaW9tbV9hdHRhY2hfZ3JvdXAoKSB0byB1cGRhdGUgdGhlIGRv
bWFpbiBpbmZvIGluDQo+ID4gdGhlIGhhbmRsZT8NCj4gDQo+IEkgd2lsbCBhZGQgbmV3IGlvbW11
X2F0dGFjaC9yZXBsYWNlL2RldGFjaF9ncm91cF9oYW5kbGUoKSBoZWxwZXJzLiBMaWtlDQo+IGJl
bG93Og0KPiANCj4gKy8qKg0KPiArICogaW9tbXVfYXR0YWNoX2dyb3VwX2hhbmRsZSAtIEF0dGFj
aCBhbiBJT01NVSBkb21haW4gdG8gYW4gSU9NTVUNCj4gZ3JvdXANCj4gKyAqIEBkb21haW46IElP
TU1VIGRvbWFpbiB0byBhdHRhY2gNCj4gKyAqIEBncm91cDogSU9NTVUgZ3JvdXAgdGhhdCB3aWxs
IGJlIGF0dGFjaGVkDQo+ICsgKiBAaGFuZGxlOiBhdHRhY2ggaGFuZGxlDQo+ICsgKg0KPiArICog
UmV0dXJucyAwIG9uIHN1Y2Nlc3MgYW5kIGVycm9yIGNvZGUgb24gZmFpbHVyZS4NCj4gKyAqDQo+
ICsgKiBUaGlzIGlzIGEgdmFyaWFudCBvZiBpb21tdV9hdHRhY2hfZ3JvdXAoKS4gSXQgYWxsb3dz
IHRoZSBjYWxsZXIgdG8NCj4gcHJvdmlkZQ0KPiArICogYW4gYXR0YWNoIGhhbmRsZSBhbmQgdXNl
IGl0IHdoZW4gdGhlIGRvbWFpbiBpcyBhdHRhY2hlZC4gVGhpcyBpcw0KPiBjdXJyZW50bHkNCj4g
KyAqIG9ubHkgZGVzaWduZWQgZm9yIElPTU1VRkQgdG8gZGVsaXZlciB0aGUgSS9PIHBhZ2UgZmF1
bHRzLg0KPiArICovDQo+ICtpbnQgaW9tbXVfYXR0YWNoX2dyb3VwX2hhbmRsZShzdHJ1Y3QgaW9t
bXVfZG9tYWluICpkb21haW4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBpb21tdV9ncm91cCAqZ3JvdXAsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBpb21tdV9hdHRhY2hfaGFuZGxlICpoYW5kbGUpDQo+IA0KDQoiY3VycmVudGx5IG9ubHkg
ZGVzaWduZWQgZm9yIElPTU1VRkQiIGRvZXNuJ3Qgc291bmQgY29ycmVjdC4NCg0KZGVzaWduLXdp
c2UgdGhpcyBjYW4gYmUgdXNlZCBieSBhbnlvbmUgd2hpY2ggcmVsaWVzIG9uIHRoZSBoYW5kbGUu
DQpUaGVyZSBpcyBub3RoaW5nIHRpZWQgdG8gSU9NTVVGRC4NCg0Kcy9kZXNpZ25lZCBmb3IvdXNl
ZCBieS8gaXMgbW9yZSBhY2N1cmF0ZS4NCg0KDQo=
