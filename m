Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A8633
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 00:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708754; cv=fail; b=Li05MnjGY1kaye1j0l1Qt/MyrjDv0vscYvnHxsymq02Hr/zw13tlQWoD9jdanoRjKGTfOT46QLB0qxJ90tifasJbbXRx/eXUIobR+lqD5Ugu5TL+fipz7DXaoVnav6aCUJ0ou42scRejbMSs94uO5rbJw4krFXSn9iA2Gl8z7SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708754; c=relaxed/simple;
	bh=qJ3dzEDyyGpAGF8QBqcEb3YRyQ5kzgMRilRE9fLzlHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XdTHbBmj5NX49NuCP3MvVed2UWmeZjwS3kpCY3EiFT48Uz9+rxKNPd0XFkpngZoaKg4Kwv4HoEUEAY612UVjm5VoYkHx+exV/SZ97zqvj0KthrTBeZis5sC8jQJRSP3S/IGo6eM71FGtum9xV2oFNGSfjxu3XRW9o4s7nrjGl5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0aonGYq; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0aonGYq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2309818C0
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 00:25:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.801
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_bKae4egzEc for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Apr 2024 00:25:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 20E3A81456
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20E3A81456
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q0aonGYq
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 20E3A81456
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 00:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712708752; x=1744244752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJ3dzEDyyGpAGF8QBqcEb3YRyQ5kzgMRilRE9fLzlHU=;
  b=Q0aonGYqaa8nbq443Az79HavyMBIukRnCpSLPh6Gy+eelqUMKEKfMmR9
   /ouIsBa+/A7QMYrTc9zFBDz95a7CSIDxUgI50IXd88dsolYaTZ4DwQF5J
   HzXA/5B2UO5+/q7II8TlZAfveRqYRnrEUTdgiqEVVnDUmf1sbGR+Ny49g
   eNRXpFW4JYIVMOx7iA8vzCQ811gn/w7vg7I2OpBpFccA0o4oV5m1iI0Zw
   VuaUTIFuOws6+gPzLihjNdRPvcGuulgU2pETt+q5jybfM5lSWLwuIqbSc
   fXDKRuIQwUkHq659ejHRXCNYZreoIzKRgiASZ8S7RZvF4JPpwLVb8gP+C
   g==;
X-CSE-ConnectionGUID: 5Qytgh7KTJu+bAI7qgPlGg==
X-CSE-MsgGUID: /Q6X83MOSCeXwnPo6rmLKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11841243"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11841243"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:25:50 -0700
X-CSE-ConnectionGUID: oVfj8MlUT0at4dLK5YGmGA==
X-CSE-MsgGUID: 5Ojd+/DxTkirTR0UxHINVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24874208"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 17:25:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:25:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:25:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 17:25:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 17:25:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBXO1t5pdfciU76HmzDKqKD+kiDJe0KwprNfklaFkPAn50mWK4xoEWTNKMqDSNFEf6RyYtpNpAON26TU8gpF9C/Wve9rGuwWZdaBFQa6Wo0K3MAwiOL/+uybS1xizWEW5DRuniZBYnJUReUWeArB45mrcFysVTthOclk3OdPXyhhhIU2UzH/T6WGv3P2BlRW9g8M6HYMMSsfeN+N6BXmsEUzRpRHESc7RMzNBG3JXDCuN3zMjAJ6kyFyf/rGrnOgUNAREn+kwovJrcOHgisGniR0F4gZqri94STB6T/ZVdr+jG0AczF0T3vgZqmtE4Yd7UjwD5aky9jvlJJ053dJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5khylKcbjAhazU1I++kQJYDebc9IjrcC04cEIsBKpbU=;
 b=Cj1KDMWSaRRwEoPr23a9X4qZjJDBDGFdbq0Yq4flCNcpIJvM6rotj5myKKOp269cRptZqJ0KuN7tczA4SQBWJKPhpySE2Xt7rkmbzkJ0BXilGY+kVV0xxGBF6KaGDy8W6mBS2wGkbWtWapkeIEYnbsvtIq88DlvUvoABGHY7n4X55OX8sWU96VM7yKbjn4uptqELGRvLI/yxTrMDw9gXMcLJTLi+tfJtN81ReoWY8/BThN8vkGfJ0pWvt3eb/OnPqzifSXq5SidQBLAEb4Qx3Q0WIjt/cbvHCOyAJ9vRCvbT0E7UPzP2HcHYNizK7wwkUqHK19CahUlKqAP/Aa5aVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Wed, 10 Apr
 2024 00:25:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 00:25:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joel
 Granados" <j.granados@samsung.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/9] iommu: Introduce domain attachment handle
Thread-Topic: [PATCH v4 1/9] iommu: Introduce domain attachment handle
Thread-Index: AQHahWSSnaztXeCebE6wTRmWhE7qM7FWccyAgAQ6xQCAA8RcAIAAxbYAgAFsagCAAAzioA==
Date: Wed, 10 Apr 2024 00:25:41 +0000
Message-ID: <BN9PR11MB52768E632932728FD41EB4038C062@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-2-baolu.lu@linux.intel.com>
 <20240403115851.GA1723999@nvidia.com>
 <3b740988-7fe6-4328-8ce2-d66d9a2ab497@linux.intel.com>
 <20240408140548.GO5383@nvidia.com>
 <4c07d54f-6c6c-47be-9e5a-3cff8162dd3b@linux.intel.com>
 <20240409233744.GI5383@nvidia.com>
In-Reply-To: <20240409233744.GI5383@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB7983:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VOxNrsBlFw0RoNxfHr7MmmhVtVn4gkeI75E4F0jDRz8ao23vuSHOgOgEHd8jTpk96agoIOUOpKC5AwVAULb5SLs72wu3A23pULNKiCXGH0tV3thsgReOmPpT8DDXDpQEdDfaSGrUSX3V7vIiJHvMNCxwreXDQl6nKh8lViCSP1du9tdz/mP31eKjCxwrxjbImEQPO9rtWuCGBd3E26Ln7ZPlPKGOymppAUUpU8Rg2wzblDkU9bNzypA8kJshypsXgxyBPv8aHhJVwe/h7s9zRf7PgPl5nwIt8q7da5H4uClwl4s2IrlYjIwM4JBJKh1H6dmdhTaYqjWmzT+W1rxWa3XTNDUjMp1eGu94E+bILCuFKdiA3WLne9uAOLZsIQvvcv94Wl53xEezh1LAyVUmnj/NKg//XxqGebnzHhNHmrRgqhI1zomVqw5YiKO3GwPTv+dyxNor7iixeO2Br9cMCDjHXxkO42c8dpxwNtKfSY4GIQcl6fqyUOSZKmLv7F1YXqt6WnzsBcV4LZsksrMCOO6T5snUTjM+wLLU73YBxPU0/gznueUHUEdkgGAZA7gL8aKbzrZfYxsLtxoXqKC35lH7l479yISIzreyu4SL3Ltx3vIS0OjCm6HubwfS1Kg96461itGpv4vXXpct37hYBZJkmiSV1EyDb3Ch88cWFhU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ofLSb7peIi4Y9pOfihqgMI2i/416VwhfmQikZ4xtFYAbS8npTJEcmkTV9qcj?=
 =?us-ascii?Q?ZoFja3lk2YFDtwIW+en+PxR1Zhv+2UdP+2LRi/wVvCs6bbno5lMXFoxGAu9T?=
 =?us-ascii?Q?S/Igzhum7MuNUkvFJDUNzF0VXKk14ktxrvH8dVyI2OEAG+zRxzBpupO7YRyO?=
 =?us-ascii?Q?SehlSmNbNtne5l1OahqkSNRb9OF0D2XyXzCA8PQg3I/y+6DATAxC4uqgQByH?=
 =?us-ascii?Q?9pps3n7v4JBUSJx7kJdt/FayRnEBeBd09tYC8JcokT0UazTZg/8YZtZQUGFw?=
 =?us-ascii?Q?8+kM99H1bSbQAc7ijJ6NXbTLrjvGwPGQRrEsSnbtCegtalVOWPEH4AjK8IJ+?=
 =?us-ascii?Q?LR+3S52sP9tJHJ5uN/ZH5NfPlxMaXQ0vRZ4Y96a0ZgnDCdgNdOhqH4W7CJoY?=
 =?us-ascii?Q?D0GJPnRfInqXcjJrzi7fb0EFRFu/s0rM55tSjQOQgZ7HldJmCBhLNRdllnQw?=
 =?us-ascii?Q?xTX4yyNMsbmUevZ2Co+8KJ5q7KdUQHR/wt/aDnw2C/mnnJdEncle19TqvRlm?=
 =?us-ascii?Q?gHQf84RyYYtnS3XiC7yW605ogjJYBInkMt7sHv6i3f9jd833pUGhNycjLb6h?=
 =?us-ascii?Q?HJkfZsUmUBvrq/oqDEo7n5bHp564jweL7r0UBFqkjQ5wtnofKl7/HWuFaZ7m?=
 =?us-ascii?Q?OJN6zCN6BN2EvQWrc9GeG4D40IemTet3Ku3ua2Hxpa7MraGcB2ddOogjohCk?=
 =?us-ascii?Q?dahBkcKBqTfOWOW5aQ+9sKfMMqcybC3G6dYkt3434bMBkh1qGT2KZe1F4MUI?=
 =?us-ascii?Q?sU8d7e24Z/dn6+LlLKEOnGRlmlLm/LEto3gGFAPkxVyv2Ml/yf7vCtr2GL30?=
 =?us-ascii?Q?9zN43wwI+8YEfwPIKcABY1XePtxh+Joup0Nnffgfxbi7eC93YQQxjt5C6Qlt?=
 =?us-ascii?Q?dfSOIPMRvuoGNmcsoXAhcAGrB/MNZZetd79WbDbAXnrEjCUdtdOCxB+1toHV?=
 =?us-ascii?Q?eKcidGn/398V+Y4/7dalxtaTaMw55AhNDruvY9rgm6qW1ix8AfkXmMGvvOd/?=
 =?us-ascii?Q?ntmS8PlV4gLjMnX7DuReOxYqrRV8phQ+MyphCy7QBxst5e0VcYaMI065gDuU?=
 =?us-ascii?Q?8JI83sGoQfHOy9k1SXVMy6pQeLWklN0dqq3DTZvVcmw1BypzUDmXWXTINgl1?=
 =?us-ascii?Q?InWNXPA4G9eaUHcLGj2pb7dEd1BMa4snMOKdSH7XUkvSyIzebXtX4nO7qBNm?=
 =?us-ascii?Q?B5K+VbZXngIHeIOFxYuxxYOdQ2QjIaBO2DjpczGpidJMEPQox2NZ1QIL3tNe?=
 =?us-ascii?Q?sF+fQQ6u9dblMm2lOy0Aw4z7vwnUtR+0cWO9LdZuFFQTmJvItFKDQOYXmG6b?=
 =?us-ascii?Q?b2jgKF34/RKAHCmwxu6qoTo1KimLUIhpr4Hp2zzdVu9I9o+YEVXlOKVFe4ui?=
 =?us-ascii?Q?gdnCQZChhLi1/Iqy97I5K6O129la0lQgAQx2cyjk47dP1UrILz08rScyQdIf?=
 =?us-ascii?Q?Fe51RP0GuFcOqZBJSe8w5aoVRkexVXRfeEdfFgWqLODMx4CFBH6BdxjkCFam?=
 =?us-ascii?Q?kRUUUNhTiYZjbpCKl/uMWb+/yCqXL/TwuK9G69HjBwx6bkc7XBRKxYpZFzNw?=
 =?us-ascii?Q?9b3NNG7OY4h+GJFRRHeizhkLvvKaUOd6oBFx9tpR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e75e54-a9d9-4f10-fba6-08dc58f4c0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 00:25:41.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTVvdFe1IlOdaX3rxTFwYlmC0h8LnwxY8yEmwt19Ez9QxrKIK2tA85LUajc1vv6xrd4dPwaNQLM0ucS98fyg5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 10, 2024 7:38 AM
>=20
> On Tue, Apr 09, 2024 at 09:53:26AM +0800, Baolu Lu wrote:
>=20
> >    The current code base doesn't yet support PASID attach/detach/replac=
e
> >    uAPIs. Therefore, above code is safe and reasonable. However, we wil=
l
> >    need to revisit this code when those APIs become available.
>=20
> Okay, I see.
>=20
> Can we do the PASID iommufd stuff soon? What is the plan here?
>=20

Yi is working on that. He will send out once the last open about ida
is handled.
