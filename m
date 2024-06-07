Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750515AADA
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752655; cv=fail; b=qLigkqjMCMMpAvXlh9uJe/roWzAg0tICKGaUjpJhz0WucXQYqqOoWWiJYV3TRw7d79zcbKjH+FEFtW2JcdCVdS8IQI5vkhcczvDyoHflixxBUWeIFSlQFBa8eVp5fWtD3U8iGieVqiFcEOqN4ZNcrbLysQfBcOcNM6TZszP6vCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752655; c=relaxed/simple;
	bh=VznbZ5c1D+R6HAjMBO5APAOojn99554HchXV71m+8/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sVZSqEKIOEQPywSRagaCQzYgjGmGzuPuIVE51E+jWhH2Gk+WEU71hjZtE8m/pv4hCBAoBv8DS1tJQ5UdZwKvFnII8N2ryaCrb50vQdopVExfphFkAzzLX0LIPe9aelTpvogX1aox7fNdXb2BF3wzh1qfbCOx0kSDBPRYLjAlucA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TceN7VYa; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TceN7VYa"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81AEF60811
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hHt0OmMhPQzg for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jun 2024 09:30:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7D566607E0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D566607E0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TceN7VYa
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7D566607E0
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717752653; x=1749288653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VznbZ5c1D+R6HAjMBO5APAOojn99554HchXV71m+8/c=;
  b=TceN7VYaKFD+sVUJh31QSzWTkYJpXzJiZFYO5MnXDD5Cop3zitedSfB5
   0NQObC4shVHXJyWNRJvxyUB3DmA+tmGCeqHJ8XlCsqzLhGXi86OgnQGuj
   f7NzAhF1iOIfItLRFuhFb6nf5746hK0nsLbebjNG5pjwi48pj+1kepmZT
   eTdOlzyyUnSDbA3K09G31hS0dMhC9T7Eh2Sqap3po6ReYGHRjGxexkEr2
   KPfRtac984s/Lf4TgJEP/tzhll3KYKxG7KfzO1n+/l2loJGkIwLGpGZ6p
   UweFBDaqV6qp74Veh05MX6Tj7/mCHPavA/CBZ6QUBsImiWtfo03eG3iUQ
   A==;
X-CSE-ConnectionGUID: 76rVcLbxSsWLW182XTdLhQ==
X-CSE-MsgGUID: /5L6coK+Qz+gP8AJSCDpkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14309415"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14309415"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 02:30:50 -0700
X-CSE-ConnectionGUID: osNneOwKQ+OTwGU8ihxQpw==
X-CSE-MsgGUID: 1gNhhLhdSgC7u/RClZP8wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38197304"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 02:30:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:30:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:30:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 02:30:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 02:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9wLKH3zzN5E4Im1BHesNqs30GEICpJz5TyS2v5MTRcmtBVk7jNNtjDb8sRb6jcds8VWEaZ24YKjeMY3c0CpqTvjpJ1AofddXUsCgHQc8cR+k4S6CKoN+bFHGJFWcDPTcCTW4Tp2LI5rEiHHNvZy1HwlKMwY9oBPAaxS7BdqNjkMMxiknyUyEZ9m5OyiPZVeEhBe4gOOT+N+0/uf+CUYbJO+pwyEe1lOPovu/wvELKMxD7J/Gj2ZRZc/dWN0ZG8jt7/VJa//XVcnf4Ewyt0RjL0fhANu30uxn+AzqOhXO74qLQ0p616AKPToaJgFhnuHwrOzA59wQYIUSJPeMhPfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VznbZ5c1D+R6HAjMBO5APAOojn99554HchXV71m+8/c=;
 b=Dty49Q4gzUPtfJpKKd+Zeylp2sFi+VhV0Nzyyk+8CRBjxDFwz6vlLhvY+p/S8cX8vVRgO+54SWibx/SGariJN1ebBAyc6qCwG9pIxA4yhtjaAGHjHcCo34efqz0RtZXY+2p/JnFERl37y9L/OZixe6SXa+zm/PzLscrhhMByqaKzjSWQOVSJimtbFK4iunIsXq1+XfRCfw80Cwp3XSVkzO+ueQgP6fUIDaMfoz/enH5BMoj7LEI33Mh6YBs7SBjBw8J52rHSRDejPnN4Ladkw3upxZTG7KVVYjt5k8HPmWlX6PGB2MsxXvSMteJgwfZ5ebAYCrBYnO73HOswsf/uGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 09:30:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 09:30:28 +0000
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
Subject: RE: [PATCH v6 08/10] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Topic: [PATCH v6 08/10] iommufd: Associate fault object with
 iommufd_hw_pgtable
Thread-Index: AQHar+t2z6Vp85qgr0CwRJGpENTZf7G8GrqQ
Date: Fri, 7 Jun 2024 09:30:28 +0000
Message-ID: <BN9PR11MB527606D22055A293CB4401698CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-9-baolu.lu@linux.intel.com>
In-Reply-To: <20240527040517.38561-9-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5166:EE_
x-ms-office365-filtering-correlation-id: 464a3dec-742a-49d5-67c5-08dc86d477f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|921011|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?nS3NoO4PRMyVbC/vZGAYDPU9qpy+mbLD38JRWWVIX21vu1DYzL1KWCVB9pN5?=
 =?us-ascii?Q?mNQXeUBkdiDKbydYf3DZrXIr+8kpFDxpS71ZcTAKyxiwZWfNRDRDRp1CHndM?=
 =?us-ascii?Q?eV6WJxjaOgKrS+oYq8k7wRJJZSU+lnlgmSxWQ1G3b8Yg8TaBo8VUwTtrbMc+?=
 =?us-ascii?Q?2vb39bG8unYwRIqDdExo9601XVBDmIPDzZWG62lfhHvobSUGOhpkQhBpzgKU?=
 =?us-ascii?Q?MK8p7aGid4L/uAPmZ2WJPn3HHQaC8rKuQKennNEKPr3AI39n/kEh3G5/dxKr?=
 =?us-ascii?Q?7lE1HL8abxQw8FCd8YjirXjV0Dj+mGXSlGnSXVS1KBjMiVrETvmyP9FrPgOS?=
 =?us-ascii?Q?tqtjrwUHmy9Uj0s49ONgSKr0ezraU1Q4VFbPVn0YuR1A3tq/I0XB+WxV4meL?=
 =?us-ascii?Q?onA62FMtWa3/ZK7fDdQltiNI2I5m9Cac3UsEsTU2whCC1YGD0IVanBX1Mpw9?=
 =?us-ascii?Q?dxHO5yVpycyQFGilY59V1mvxUAyoQFO2ksbfpI4/fAbXAmcF4/m4udAMtwv9?=
 =?us-ascii?Q?+Nu29ojMg9Ub9WKYdF4ssGrxu+M1FS3WiqLw2xYkPeVU6oVPeApalW1y+mtj?=
 =?us-ascii?Q?+7CwY55CLATVgfgojFwzcA1Ma2jCdBzyIUawoPvalolaFrD8QWKR3SbX1Czm?=
 =?us-ascii?Q?orWWvphXOaKGDoRgcJCHMpTLdS99oeuyETep2y8Vb0R61xBPh7HCgj4maOAS?=
 =?us-ascii?Q?/HWKCYVuf0ok2SsSCzEUPFyCJfCNWNGTVw5PsxK2wPWvc+D3MPF5ZrX65Muz?=
 =?us-ascii?Q?S/Y7vbVjgOYR6e71PsbZ3gTKmiTVEAkb07t3zCrLxT9wAfqB0ywKExFB/mor?=
 =?us-ascii?Q?GsSKTORDMfhuqUMTWRepcPE0vz4stwjZZ9MIbfsyE3kYqtLsHqUe2fhtnD03?=
 =?us-ascii?Q?91kVXqUEQ4uPxpy5ryq1EjiKHJw5U0AsIA5MdQSvxeMyVly72sdxU8FObypH?=
 =?us-ascii?Q?0URBy6mgINkPjWK0EtA8OIFgyO+sCF7uM0l46S9MYtQ6SaYMPwXnYMZwZHKk?=
 =?us-ascii?Q?bIloUvG1REPQLg8lRd9BUlJLmhZWy2ULjzxmJRWHq+f0WgQFDEw0FIPQuMQa?=
 =?us-ascii?Q?34o7w3wj0bhIsD/hdD9YAUne9suCB2G4ihCSB1F3VMGJO9mEfn7RcQsHIgXc?=
 =?us-ascii?Q?dyRlfLtQLrlSLX9IFTf7qksM+DFNspAgsVtejci6V0I3fKFeAbDxnOzHuV7g?=
 =?us-ascii?Q?xZ7ajhmpfuRadCwlIecLa8XtHAz+BEorxCZW6ppI7QQc7vMgOvQ5RTbw/8Mh?=
 =?us-ascii?Q?X+fiqP7jpBSS2wknizhEQfSgxMHOPF8/qXIgV/X20M72Ngw1YK7FQEcDE8x4?=
 =?us-ascii?Q?Ue2EqFmGa7y2riynmdHuSCvTAed80i9Vp1c2CFglg7s1gPaHk1aT3JpnjOkp?=
 =?us-ascii?Q?wWDLYe+fGntkPj6uafC012W50aA1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kxkrMT1yrqSFFexWJ0STBGgYfepb/jKunpwD92AAShGYTg0RZoTWNJnCLOe9?=
 =?us-ascii?Q?KRNc4EMdcMVt1Mw4Xvxr9h9NDwBK73oWEgsmepnHxU5qL9FidNyXvf92YWDe?=
 =?us-ascii?Q?kgJ/e0C4nAD5ZemDoTd2IpLYMexArI5GrbQZ+0fCK8/V2ABn/6/uTPbd+loN?=
 =?us-ascii?Q?rjJ5rwPQLTy34NqTAYaxak9gNUNPkABHfbNP1LWMVBrvOFVmB9WvkZSUUjty?=
 =?us-ascii?Q?a9eDLNlllPG1GIIJ+BY9O0/v0/s+d7A6hhhYBZYejiknBj6Ixkd6yiVMr0jV?=
 =?us-ascii?Q?HvY49t/7yalPcF7qY5WfO919GnIS/y/WOi15hud5seVb/8d/MwnPsJXmdQ9c?=
 =?us-ascii?Q?+sbGWg/wR0YlJMA5GlcZWku0NvjbXkrikdTQWxZCQwAIB02C6zWZmozPszjS?=
 =?us-ascii?Q?doyNQcXUTQSxGQGPBdumSV8/K0dyiO4hql/4DHln9Y/ksus6UVmqiS+dn1IQ?=
 =?us-ascii?Q?Kgi6ujfITCHYFNN1G0hJiZJtWmfn5gQaMOv4Y71bv3rHJOdw7T1FVpuRrvgP?=
 =?us-ascii?Q?FcYb8Z/UHc9z4ffg/BGeTGeizHy6mNwCT+4O39L1adi8kADufOHj+PEKp8tC?=
 =?us-ascii?Q?0w+CnrX4wPSH3X+EOWbTTMF+Z3AC14H5fbjrPKzjdbKSGeK2WjUlKk1eFu/l?=
 =?us-ascii?Q?8Xb83sLfnlvRvVSJECoPaBT5tyrdySnU7yPAW/3fv2q2vwZTvcrTb0bQsln0?=
 =?us-ascii?Q?9Lcy+BIXPh5xN5qLvqsfamNhssEeWeHrDdFxrmR2KNziZ/FzH5V41smEozlR?=
 =?us-ascii?Q?qMsfsEMaiRWzjWHGdCnHND8IE0aBvxy77WZCVU0SYMclO1g6OzPCuLcpPYEl?=
 =?us-ascii?Q?QrdyagBlzZjWmajHd7G+6mbD4X1ZUZs7uNAdAdz/vKColtysRbadaRzOPIPF?=
 =?us-ascii?Q?7HTFZcnz4qNWH+lqCPyHRh626133v9hsDuSZfE/PptPBe30tIFn+uFMgeV+w?=
 =?us-ascii?Q?h7Gi4Us8WxIvRGIP0tp/2MpWrNAGmWJ4b/LC2kg/Xiq4Hqw8184K5q1PDQW2?=
 =?us-ascii?Q?hZkhnN2g9Lu+RGi1eVrcDismfiBnwTPX8O/+pgiOZzgcQdl9LFVIAX5zs5jX?=
 =?us-ascii?Q?gQzEKpkUaK6EIwBuFdIXkP2rAciSsjqZQDUU4Lu6Pdqwv2qnpFl6jgrWKbEH?=
 =?us-ascii?Q?eL2AVJ/oH/rsh+WrFN4RR/jmb85qu22QnAAifGhetcpAGyT9WmOM85Cxg8ff?=
 =?us-ascii?Q?vVwPZ7iFM12qpuLUcb+rFOmJoTvIDRaVeDB6RF5v8B4JDRIWHpgV5CIwVUR6?=
 =?us-ascii?Q?3BLiDmi3CiRtCouK3oDS6nEpAnbJyrpmcA7RFfsRWmlT8oy3QTtJwVlFofPP?=
 =?us-ascii?Q?3N5Gac1rrf5lO0N7GMeuFJH3e/Ma9T0JqrL6AFZPZaDmPClrAmGT+NT0iV4D?=
 =?us-ascii?Q?n6gy+71bcDCbds4tWmmH414TsbuLcZl23fZGpgubWSp6OiS7P8F8y8mciIOb?=
 =?us-ascii?Q?wAC/0J0m6wQl+GWpx6Qki0wbQaBoxrOZ6IQozQ/FBSkRBJ1GeHOI7DaW3KTf?=
 =?us-ascii?Q?GLxA8bEKdP2P/bFcVn1XZEhh8Nb5dpDx/gAFLuVzDiNaEVGO15pv7VQgydSY?=
 =?us-ascii?Q?yR4r3XYSwmMzItx8CcMLtuwIHYDtzL+WywXYxtzZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 464a3dec-742a-49d5-67c5-08dc86d477f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 09:30:28.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 652qgmRR/McUPySrSx0CrN/d+RsUBrzZmjJ6/RGorMXVZ0N5gPO6iuREzL9L3sR93lN2mlOy542Yx6UWNSoIIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, May 27, 2024 12:05 PM
>=20
> When allocating a user iommufd_hw_pagetable, the user space is allowed to
> associate a fault object with the hw_pagetable by specifying the fault
> object ID in the page table allocation data and setting the
> IOMMU_HWPT_FAULT_ID_VALID flag bit.
>=20
> On a successful return of hwpt allocation, the user can retrieve and
> respond to page faults by reading and writing the file interface of the
> fault object.
>=20
> Once a fault object has been associated with a hwpt, the hwpt is
> iopf-capable, indicated by hwpt->fault is non NULL. Attaching,
> detaching, or replacing an iopf-capable hwpt to an RID or PASID will
> differ from those that are not iopf-capable.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
