Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CA1758B
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176139; cv=fail; b=QRQPsYY238sxYOP7HajmE+3RGdlrgBWp65CzRx5B48RSRbArK2yBKaNt5SK3fQ+VXlccHVZWddagnI4oulmH6y/hhD0oWuHBhwzC1VIXKEbYGjr+YRkTeV7m5ZEEKWEy38h70Jq+/ahKLTcAxw/DvKFrzZTb9kKree5Zm0PU3ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176139; c=relaxed/simple;
	bh=37pgNWITnZR6/rSiucp2gOJ2WL7v/O5ODEWVKvtzT2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+JmwJADrieOuOFl18UNQBTFaI7vxajuukcYZW9aagxzKt1Qp5K68SevIKVcgNE1y5DjluKMMelFrx2kg0ogevX5u7FNBL5mp9YD07psdOpLC5alYiFB489UYeNb22oEyzKtA8YHTAjxU2QzUI2zmDJWKyft+gp4dmXYP9M1REY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4T7JCNL; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4T7JCNL"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA396408B6
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lR0PtP8gwAeA for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 03:35:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E845D400F2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E845D400F2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J4T7JCNL
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E845D400F2
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716176137; x=1747712137;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=37pgNWITnZR6/rSiucp2gOJ2WL7v/O5ODEWVKvtzT2s=;
  b=J4T7JCNLtQw6NbUeuPJ/SZXduE9x/ghE5mQG9OXsSw28V+y9D58p8Hth
   yYcWPVYdVtxW7a7XqcMH0wZiXSVIJiBWeEGiDlFOeGBlFnEI4KCDeaIH9
   InNVokwVdYgYLjtiOTo3MDx/R4kWgbiRJRoHWoUU693ATpWu1bTJl9T9k
   naQLrfj0js1XrYkEM+XruFSBCue2klI5016R7CMddEtIhIF0yWNw7zfBZ
   CRht7IRpk9xkMRV6pwtfGGsG8QidwU9hkzi8YiwRilNAqs4u4PEGmX9mo
   Vugkfms4g/W5nG/XlayNYo7fivJvwqKnJ+A+GUfVWWiC6uojYk7ZYKOez
   Q==;
X-CSE-ConnectionGUID: dGkzRuiQRMCkbaQsJluRNQ==
X-CSE-MsgGUID: zWvWk5aYTIuNZKxMCtXtMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="37664689"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="37664689"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:35:36 -0700
X-CSE-ConnectionGUID: QxDelJ5HRMSiQT61iKlayg==
X-CSE-MsgGUID: xrgcJwSXT/KfB63tMGIiCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32414625"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 20:35:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:35:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 20:35:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 20:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BV86deB/B138ojmdxJ2RPFBYqPf6dYHZpQFGWJcMsFYnC72vDDqahOijYfcoephwVpWvnFH5sLUbK63xFwXJ4HSyBfd2MVzvBvZ3FHfE4SmuY6Ksevvh90SOqWPPhq6aI7/zVaSOnVNLmjxQO4qQhmTFjJITTPUR+lWHu9OwvpyW7lrIG/yaDWNt0PKcNqKXiEyQbINEoR/Izjd0UfcEoqlxRzLcACrCo3q+sOClhhxnKhDgH7Tl9X4bW/l/x0t2NeuUXpvz+ZVwxntx5CFMbqEyBKlHGtZCt8rBueKtfSf7wIpMyjaH2Ckds/rguZFuI4osM8plCFmMQNfcJDJjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37pgNWITnZR6/rSiucp2gOJ2WL7v/O5ODEWVKvtzT2s=;
 b=PbuNh+ueWTm9IgagbbMze//NIrMURm8zj8N/mQg6iM+5Qb31rQwQFSSGP64x9Ag9Yooa6zhHsI0O1Ti12wjykdxqGFL14JEO6xnyiHLMsq0jnB82WPaZVA1s3GhBEOW1InaJYktywwrulGypCXZu3RNom+5Vn/PhsLplvnKBRSM0ximPZ9oybFxZukQmQiljWD5n5ESdBkLDgkzPmWc2Rg3PBCtXm2y5QYgHWMRlaqjcof9N9O6/FCA1iIiBROSNiHxb+WswUahA6pV/CJgi7GorA3/w1DbGVyXTDhyVISqPID8N/NgNBiPSkx5XVDo/UTB561cVkqQoIbRRUrH7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB7703.namprd11.prod.outlook.com (2603:10b6:a03:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 03:35:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:35:33 +0000
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
Subject: RE: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Thread-Topic: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Thread-Index: AQHamw8ICEBQlwyqhUGpWVI9yv+BvbGYEXTggAduJACAABe3wA==
Date: Mon, 20 May 2024 03:35:33 +0000
Message-ID: <BN9PR11MB527642EC35E6B925100D0AEA8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276D582749AD8B619B11B688CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bd08d2b0-f226-4b42-8d3b-099c46435aa2@linux.intel.com>
In-Reply-To: <bd08d2b0-f226-4b42-8d3b-099c46435aa2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB7703:EE_
x-ms-office365-filtering-correlation-id: fc6d0b78-accc-481f-35d5-08dc787de7a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?b2s1NmdHVi9GQ3ZGTkVRelJaU1hCM0lLWnl0ZUorN2l5cEtrbnRYUDBicEpS?=
 =?utf-8?B?dGRsZGMrOTB5eHF5K2tGeitQVVgyRUpXa0xoQUxzQ21DcXlSWkQxSmxWWlVP?=
 =?utf-8?B?Mk9ENGIwR2FNaWl0ZWhySVpDRmhVSjFzWjhmVmkzR1RoWXJvRStzdG9RZ1BO?=
 =?utf-8?B?dUc4SnFRQkdtMEYzRDFkb08veFhVeGlDRUpvNE9nb0RKUm40WnZhVitUY1Jr?=
 =?utf-8?B?dHB4d0hYb1FMQmhDRzhIb2lZMEZTSk5SM0dCRVlhMzkrbVVoa2l2aXQwR1Bs?=
 =?utf-8?B?ZDRudE1VcVNWM3JUOHp5dkl2bVBHbGVnSUdSK1dIZURQSXVQekZTaW1sRWRU?=
 =?utf-8?B?L3JBTU5GcUZjendxQ0pNaHJxOFVEWHpVRXVmNnJ1WnI4T1d4eC9XbnZJYytu?=
 =?utf-8?B?T0Z4enlhR3JpVHMycXFNYWFQeklsdkJNZG0zRjZoRUZETVJIV3BsZXpCd3Bh?=
 =?utf-8?B?cjRnL3N1RDF5RDBaYVNLeXUxMVg1MU95bnRDVEk4Q3c4U2toaE5wbENtalMv?=
 =?utf-8?B?VHczWnhKd0hmakZtaFNtM2pqdEhiakdMMkhaUCs1YlB0cy9MbGVLUjNJY3hY?=
 =?utf-8?B?UmxJSEt3a0xkb01jRWdSMW1sRGpiR1hMc29oL01Kd2JrQi96bzR1ZEs0cFNp?=
 =?utf-8?B?c29jRkRoOFU1d0E4OGJrZjJlVThMWVd1Vzg1c2ZLbzU0eng5TUs3MDZ3R1NV?=
 =?utf-8?B?NGtzNVA1N2dUa09xa3hITGhFaUJrV0M3UUhuT2ZIZ2l5ME14RGRhUVpYN2dB?=
 =?utf-8?B?VmV1M3NkMUtOMVAwbFJmekVGOEJvOUUwVEJuZngyejF4YzRnUHYwN2dNODRj?=
 =?utf-8?B?R1BYUDVSeWVHSEo3MmFLK3V1UnhQeWVXOExUR0NodFZ6Y1pvd0VpdHNydE5x?=
 =?utf-8?B?Y0lSVkNSVkkvZlMzSjZsSkJpM1RZMngxQnFnbm01czBqRjJHaTBjaktndmlv?=
 =?utf-8?B?ZWxvM29xaHpEbVNuY3ZYSmx2NzhDa0FYQytHR3JIRnBiVDN2NjR5SXRMWU14?=
 =?utf-8?B?TEo4Tjc0RXh0cmlENnRQdldZVGhCcnRFUFRwME01QXhLMXpZZGs0Y0lqQ0pG?=
 =?utf-8?B?K1dtZUxwTWxIdytSdTV2dHhmQStYYi8zZkI4SEtpY004VENwT2pIYk1iVGxY?=
 =?utf-8?B?K1RVWHo3SHgzd0w4RUdYVVAra25FZ3N3YnpuVFNKd29LMnppMmFtRzEvWFhC?=
 =?utf-8?B?U1poaDBTV1lhNlVxaGllL3AyMEV2eVRQMkF5T2xmanJ4bVNvRHZPMHZNYk1P?=
 =?utf-8?B?Q2pqWDl3MnMwejJiNVRYL3VaY0JjRGJMcmErM3FGMlcxU2dic1FpWTBpb2xz?=
 =?utf-8?B?RFE0V0N6MXV6QldpOGhlK09iZVRsd2NSZUVIQ3U0QmdTUDFwcVo5ZDdXamlB?=
 =?utf-8?B?dXJRMW1vMmk3MUI2R2hIa1BudUNwWEcyL1FETThocWxRN1JnZXVRSlM0SDhz?=
 =?utf-8?B?ZGdZSkVUTm0yMnBzRG5YMU0rQkJ3ZmtubHFLL09acWdETmtyL2sxSDVXTS8z?=
 =?utf-8?B?b1RYU1dwdUQxU0xtRHhGNXhROUtleUlUR09CNWN1c2UwS2k1ZUhsTE5tMDNj?=
 =?utf-8?B?ampUM3A1T1FwMnBUSlA3dGpuZHFHSTV2SWZOTkFMSUErNEpORTNWRWFhVUVV?=
 =?utf-8?B?M2JaamJBQlNoWUxlTGlvU0IwSXRWZXJGSUNiaEhlL3RNeHJTMjZWTTNJNVNs?=
 =?utf-8?B?OExSN0F2WGdTMXlNVU9SVEFzYldtSk5LY29TSU43akRoT3plQVdBK3dmazB0?=
 =?utf-8?B?OC9MSmdSbXB1ME10WUJ5Y0w2UFAwUjZFV0ZJamozTjJ0ampGeWJWTEl3QWNq?=
 =?utf-8?Q?9OS81su7eGkW/Celb6xcIk8n5cg6EdeCeWO8U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDBKR2JMbGt2akFDUGxjb3o1cWZvdDFvNzZzZm14VjF6Vi95Ui9STVhVRElS?=
 =?utf-8?B?U3JJQURKaTRmaG5ZOHBhZUN5TmRRalkrMFRnb3NPeUg4eVB6c1l3S2g2WWM1?=
 =?utf-8?B?cVo1Zm5PT213ZndhSVRDVVd4SmtXV0ZkQUNzUGc1UFY5ZWZXUE9pS2RPd2NZ?=
 =?utf-8?B?R0UwZDVBRXQ0ZnhXazVBejl4M2FkbFVuSWNXUFJxdE5EbmhNWC83KzBJaDhq?=
 =?utf-8?B?emlWazE5TUIvbytTRnNvekxJU3pCaU9ZU2dLeDNSZE9XR1drZWkxeVBJN2lF?=
 =?utf-8?B?S0xZY3ovRzExdkl3RDJhREhEeEdaSkFWejBvbjJJWk5ZcnByeWpQVW92Z0xW?=
 =?utf-8?B?aWlHQS9FQXZLbVlMOGVHQkx3OVcreDQ1cjBVcWZUekNzZ2tFaUY5RFM5Zkx2?=
 =?utf-8?B?bFBiUzF2Slg5eGdZWUdVRC9wNEI2T1dNZ1FTaFo3ZjRWNU1rSFZCUUhUWUVG?=
 =?utf-8?B?UC95RjM5VFNGWmhQSFVJL3lNZ0UyYStCclNCbWE0Sm00QUNqOU5wZ2dPeFhs?=
 =?utf-8?B?UUt0cFpXS1lQUG5WU3IyeVNlMGdVdE93emhYazh3U1JvRi9mVHQvbC8zOEE4?=
 =?utf-8?B?R0hPNmF6WlM3RzRQOFdjdFkyYVFNQXNwOTJIdjNmSnBTOUFKUjlySXRpOElH?=
 =?utf-8?B?SkpVRnFLQ3c3ZS9DNzFSOGZYYXRWanJnZjJvMm5rU2UyQUJHaW1pOTJLOFRP?=
 =?utf-8?B?K1pQdzNoT0hiQlFKTGs4RDl4OTJCOGYzWGhVRFhPRGtMaVRUeGI1UXhDWjgz?=
 =?utf-8?B?dGQ5REZCa2FGcWg5VnU0M29vNzliQjRPV09BVFgwa0I1ZDhJeWszTXE3Mm05?=
 =?utf-8?B?T2ppYlI3cWMrREpFalZNcVM5ZWY0eHZ6R0RONVF4a0FKWkJlY2FNQzgzdHdy?=
 =?utf-8?B?VkhuN3R3Tlp4VDNzUmo2ZERaMkJ5SFprUlpqYTRFTklJYklrNE9ybENESzV4?=
 =?utf-8?B?czhZR2poSzFtVTY4WWZodlQvclIyeGhSMlZNTFZ3a21aVmlGam45TEovVkxt?=
 =?utf-8?B?TzQxSUlJa1VBVUxWZWkwL0hDcnNpU2p1TVF4UlZYV21iK2htcGVzV0VqdkhZ?=
 =?utf-8?B?TmhqL01NSDV0UXNlMEkzV3ZOZnRyS2FCTFlxek1kT3lGejZKUmFYMWMyRmha?=
 =?utf-8?B?UzBnNTZydGdjMTBnWC80VFJCTm52VkZzZkMvR2srbk84RzRBaW9PdGV3dnha?=
 =?utf-8?B?U2FQUFFudlNlRzZCSEJTenFNb1F3QSs2eHZSdEVtZXJuTG5qellwVkVlSHNv?=
 =?utf-8?B?NExKUkRRbktXVXlIUGtZZTBNTHNkOGlsbCtkNVVsanhDNTR5aWV1NGJVMXdh?=
 =?utf-8?B?SEcwdVRIRHJKRFJkWHQxNDhpOHU2V2VBWms0ZXhsSkY0aGplY2ZmdFltWDMv?=
 =?utf-8?B?L1AzS21IRFpnWjVkZVJjaCtwS2o1WmJyMERvV3ZZaTQ4QkVmZG1sMFRhM2p1?=
 =?utf-8?B?VEhPTWJVVHBkcVZXcjY1ZjdqQ3cwbGU0Z2RNUVNPM01XUldoRWZmZXFheFZ5?=
 =?utf-8?B?MUFXSnZpVXBaUWsxdGRDa0N5U2xFQ3lLb3ZhSGVhR1dKZGQvRXBWNW1ZWTQx?=
 =?utf-8?B?SXMwaC90cWxQNlJPRWVham9rZHh6bHZneUpwQ2FiclZacmplNlhMbW5wMnBy?=
 =?utf-8?B?RC9hV3BiczZIRnJjb2duUlJocGRYL1FhMWY0VUF5S0JSTHdlNGpUSnYwYlRD?=
 =?utf-8?B?TTBoQVRucVh0dkZzMzcwVWpNNFF1cUgzS3FmWmF6ZDBIZkx0dkNJcyt6K0p1?=
 =?utf-8?B?bk0xTmQ2MmZnZHB6NUxRQTdzcVRXaElGVjZLVGdJMittMjhuc01lZTFhU3Fz?=
 =?utf-8?B?UXprNUZDb0FUSURNdEdDNWNRdnc0eEtJMTVxQ2c5cWdmc2ZwUHR4SE8yOTI2?=
 =?utf-8?B?YzVJRm8yTDBTQk92OFp0S1ZmcDRacG92Z0pqWktYb0diZGtNWlE1NS9wYmla?=
 =?utf-8?B?M1hkdHZtOS9Uc1JramlFaXQxSTJaRmF0K1B0TlAzbDM1OC9NNElSV3RrN0dH?=
 =?utf-8?B?bnNGQllTY0RFbXJRS3lqM3YySHhnSE91YzcwTmwxUG43aFFNcU8vZm9Db1Bx?=
 =?utf-8?B?YXlobE0vL1hjaUQ1Yy9ydEZ5TUZWVWMwUzN0RUw0QkEvZWh5N3FjNmRzblpO?=
 =?utf-8?Q?PXiD6UDsULzYu3bLoJkHaLWpI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6d0b78-accc-481f-35d5-08dc787de7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:35:33.2241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMhfLJUiFYIF2cb6JPEuRdSya79OADWZj3ohsCtGLOPD/KyhPUTP9/tVNbiK26ho2QHmGyzu2osUn/0qSqVyjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7703
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE1heSAyMCwgMjAyNCAxMDoxMCBBTQ0KPiANCj4gT24gNS8xNS8yNCA0OjQzIFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgQXByaWwgMzAsIDIwMjQgMTA6NTcgUE0NCj4gPj4g
Kw0KPiA+PiAraW50IGlvbW11ZmRfZmF1bHRfZG9tYWluX3JlcGxhY2VfZGV2KHN0cnVjdCBpb21t
dWZkX2RldmljZSAqaWRldiwNCj4gPj4gKwkJCQkgICAgIHN0cnVjdCBpb21tdWZkX2h3X3BhZ2V0
YWJsZSAqaHdwdCwNCj4gPj4gKwkJCQkgICAgIHN0cnVjdCBpb21tdWZkX2h3X3BhZ2V0YWJsZSAq
b2xkKQ0KPiA+PiArew0KPiA+PiArCXN0cnVjdCBpb21tdV9hdHRhY2hfaGFuZGxlICpoYW5kbGU7
DQo+ID4+ICsJaW50IHJldDsNCj4gPj4gKw0KPiA+PiArCWlmIChod3B0LT5mYXVsdCkNCj4gPj4g
KwkJcmV0ID0gaW9tbXVmZF9mYXVsdF9pb3BmX2VuYWJsZShpZGV2KTsNCj4gPj4gKwllbHNlDQo+
ID4+ICsJCWlvbW11ZmRfZmF1bHRfaW9wZl9kaXNhYmxlKGlkZXYpOw0KPiA+PiArDQo+ID4+ICsJ
cmV0ID0gaW9tbXVfZ3JvdXBfcmVwbGFjZV9kb21haW4oaWRldi0+aWdyb3VwLT5ncm91cCwgaHdw
dC0NCj4gPj4+IGRvbWFpbik7DQo+ID4+ICsJaWYgKHJldCkNCj4gPj4gKwkJZ290byBvdXRfY2xl
YW51cDsNCj4gPj4gKw0KPiA+PiArCWlvbW11ZmRfYXV0b19yZXNwb25zZV9mYXVsdHMob2xkLCBp
ZGV2KTsNCj4gPj4gKwloYW5kbGUgPSBpb21tdV9hdHRhY2hfaGFuZGxlX2dldChpZGV2LT5pZ3Jv
dXAtPmdyb3VwLA0KPiA+PiBJT01NVV9OT19QQVNJRCwgMCk7DQo+ID4+ICsJaGFuZGxlLT5pZGV2
ID0gaWRldjsNCj4gPg0KPiA+IHdoeSBpcyBhdXRvIHJlc3BvbnNlIHJlcXVpcmVkIGluIHJlcGxh
Y2U/IG5ldyByZXF1ZXN0cyBjYW4gY29tZQ0KPiA+IGFmdGVyIHRoZSBhdXRvIHJlc3BvbnNlIGFu
eXdheS4uLg0KPiA+DQo+ID4gVGhlIHVzZXIgc2hvdWxkIHByZXBhcmUgZm9yIGZhdWx0cyBkZWxp
dmVyZWQgdG8gdGhlIG9sZCBvciBuZXcgaHdwdA0KPiA+IGluIHRoZSB0cmFuc2l0aW9uIHdpbmRv
dy4NCj4gDQo+IFRoZSBjdXJyZW50IGRlc2lnbiBvZiByZXBsYWNlIGFsbG93cyBzd2l0Y2hpbmcg
YmV0d2VlbiBvbmUgdGhhdCBpcyBub3QNCj4gSU9QRi1jYXBhYmxlIGFuZCBvbmUgdGhhdCBpcy4g
VGhpcyBpbXBsaWVzIHRoYXQgaWYgd2Ugc3dpdGNoIGZyb20gYW4NCj4gSU9QRi1jYXBhYmxlIGh3
cHQgdG8gYSBub24tSU9QRi1jYXBhYmxlIG9uZSwgdGhlIHJlc3BvbnNlIHF1ZXVlIG5lZWRzIHRv
DQo+IGJlIGF1dG8gcmVzcG9uZGVkLg0KPiANCg0KdGhlbiBkbyBpdCBvbmx5IGZvciB0aGF0IHNj
ZW5hcmlvPw0K
