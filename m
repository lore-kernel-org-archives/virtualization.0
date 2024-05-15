Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6F482E2
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757699; cv=fail; b=Ar2pEh2iK5j/DltVxuPfvvd9IowBlLJbohQbr+SHUPXHzehemhNIcDo+kkGNS/59uyFcGKfTHAoZpyiPCH25t6zUyaAuC9gKdCHC7lAPYuVsQCHZVGa9U1PU8b5LiQMnNZnYd4RbWUxYGYf3dEMo2BaIT6/NhKhKKcWAF8tIQ1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757699; c=relaxed/simple;
	bh=n+6XUmjwB6rSb5o3vsQ3cuNuy/dwMiO1LWJB/op4Wv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bQ+IxRbr+c3fEYRyp7KD4fZxByvnrEWDg2SXgbXIEcvgDHjQMThAM7dn9iCqlop1D6Gy5hOEV0Nfkkp98+0C6ovRfxGJotPMHlcqPP48gSKyUhZEWUQ8Shin1CVhe/e1xUPctl2JcYlQk9hDKIW9Y8YBqNPV7jmNCAhuDEtQYfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzvHQW7F; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzvHQW7F"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC1E4405B9
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NigsOWkJ6Z-L for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 07:21:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DB088405B0
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB088405B0
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JzvHQW7F
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB088405B0
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715757697; x=1747293697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n+6XUmjwB6rSb5o3vsQ3cuNuy/dwMiO1LWJB/op4Wv0=;
  b=JzvHQW7FaZw7OAL/qeMbCXEdcMneYV8aRPNdFnJwpBdH3Tphp9SXkQIq
   U982o8g8VUtGnD5Zj15jjev1nI+598/+pmM3RK+46rcuw7/oLdrdSYC99
   KAo+T9V4Sax4rEKU14awAFrHXhasZZ2h+GyIK3GF9zKxwaBz1F7ss5A4m
   7f52l6wH4qyf7w3CyMN/GTKZQA1YICxDP6fhirNwu8jzymF3Dass64jYN
   q+S4dADJCdfT/9Sq8nkTLUTylwpF9AZb+nb87PEVxayenHVTDIbwJ6L15
   TIqZLLTph/OZXyb4bWIxmRe5GbcndkJGEmwfqEkN/i4UHX4JKVNhwjAGq
   g==;
X-CSE-ConnectionGUID: Tzvhmc7+TGCcfDQu2eNH3g==
X-CSE-MsgGUID: /+mTGsVdTwmA1neQBHipiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="37162750"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="37162750"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:21:34 -0700
X-CSE-ConnectionGUID: ecxncX7bQSKpDQu5jq/LhQ==
X-CSE-MsgGUID: vi+jg/4qT4+hY6mwp334Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31376711"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 00:21:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:21:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:21:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 00:21:31 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 00:21:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQv044JG1LaXIqyTeHLRx3IcnfVNZ+2uIXTgHuRpicXvqSd3tV7Hi7v3OuV9x3dyge2Oh+t+5zsWDrC1IHYYJvzNIeq4qP/XinwuwULib5eAsxcdCMKExDNhMseC7vLHDnZGKaBC0boFQo00spuZ3V7MLq7T0SkX7bKxOMyfuX9s2k2AR1pS0zB6gNPvC/pLAD5sgi0V+cMeceOgDO27DYgVKc7+LbBYZ1nY9btuGXrd4vt41WdcfC86R9QbtPmulfdhfm3iZdJRNv7HyZk4lHIIDLSGys1JmMVqJhGvKSAXfJaIpt7H++Ycq0LkS+jX3CAj92h4WYOY6tLy478emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9zgiInfv8fcw/3Z/fO4PKudgDfMqUjPdSn9ebymH14=;
 b=Ymj48VjL9Aw7WvPtzTbRxcPxxxtvQ8Gr/tzFD1NHu6UbgrdNCCFvtYk7GtS2zhDnYroEI8CT0tSKUcqsfIGk4oSIhIVtn4IeB1X6vcQFhiggSXDX2cZqdBoQ6lcLTeHiCADNUocKCOAGdRuMyXiC1O/3tb3oaeahn+4JSFdJmo+P+KPiq7GcEue78pjixNeWuk4nAbJ/avNUPst8xu5alfTrALU9r2svOk4dGBk6kphK7rlG9xB46e5UGynM4vdXgVDLKX3r9XsmJe3bdg7usr1ZDHm8kcXpfCZA0tlZFf9cFB761wUcnIEWlAI6XHe5J6az5VksoH4rH00FXkThHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5223.namprd11.prod.outlook.com (2603:10b6:208:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:21:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 07:21:23 +0000
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
Subject: RE: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Thread-Topic: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Thread-Index: AQHamw8ANEvMzn0R2UW8NGE5Cyn6fbGX+hRA
Date: Wed, 15 May 2024 07:21:23 +0000
Message-ID: <BN9PR11MB527615219EEF0EF3EACCF38D8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240430145710.68112-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5223:EE_
x-ms-office365-filtering-correlation-id: a430c7a0-bedc-4b70-2753-08dc74afa061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?YEqr1AUwEfn2zKebP1lQeFPh5wfUL6NpEhgaxZlYfbPk6r7NA23ZPBYSwRep?=
 =?us-ascii?Q?QkoQCZIi4eRpfjL9FOntKn9FbRMBSS+GVpk8GXVvyPlkiSLSra8NNO/UjHxq?=
 =?us-ascii?Q?2xumUqth0f3S2BLWMv+r9BtruD5GQqmfLQl1SLB34HMsAkng83gLTgiXqAbR?=
 =?us-ascii?Q?wbPRrqNubDuzmA4tD+uUy/nWLhcCb3XrUqbuJEaIWXPKfiM0nUg9OT++KeVB?=
 =?us-ascii?Q?e1ZT76HldvXMyRaALsx0F1yqMWK3lwCCMp6LSzmeeUNSCCa3UP0r8SO6j2NQ?=
 =?us-ascii?Q?bbplirIa1XmfXySFU/eWfWegvnmJXaH/OTgN1B+cwM8CSgMsp88RJ5xUb87C?=
 =?us-ascii?Q?C+vNJl8F8lhoxVhGG332kswYaR/Xz2oXbhAIfZB0oviENhsdbBBvaXyrGse/?=
 =?us-ascii?Q?MnLK6WOrBKPkBlsXouRRgaZs/XTLZpXD59S2Xd3FsPn7jEJKQWW0jfKJwFsd?=
 =?us-ascii?Q?3rtevffOmVg1Hkv8RXtWysUERktISuzmeOzUPchK11QlU+hXZNP1G/7nER4u?=
 =?us-ascii?Q?AL2piWlCVTCs2maK4qS20AjNAgk6YVl2FfUHR4p/av/bPRJUGWUlXy4WWXom?=
 =?us-ascii?Q?IiBbTEKSnCGJl1PqNq0fq+5HvSW/iP7Kjz8YuDdf3GGKkWf0mZEZD3KFHCxr?=
 =?us-ascii?Q?usyElTvOwguGX+PaJ8Hh5nw41eePPQLjbPicGNrw1qKG22XKbB+3EGdqyRel?=
 =?us-ascii?Q?Pq3K2J94pgnvn5W6QokbS5Xpc48fbMMMhykUtlE5BtozbJaY8p3+aOoLMlko?=
 =?us-ascii?Q?SfsY5dwVL+sHgSAJhrXc+splFtAQTPV2Dnu6JFAXJM207NwM5oNlcggYBGpA?=
 =?us-ascii?Q?Gt3LrZbJjfOdWqWOPY0v5AmrlgcBIaEgt1Df7QjYlg0N1xujTO1aCuNkIsHr?=
 =?us-ascii?Q?9RlzydZqfqXhkbxa+Z/6SCYcaXvQe7SmVu2pTRkbfi3S4RX0geTcEAH70K6i?=
 =?us-ascii?Q?+u3MZTPotEwK6SjSPfItRbMJBbiLbj6dM/7LoGPA0fYwWjZ/bzHs9ITfoVO5?=
 =?us-ascii?Q?u6zUvvNYxijewYDoZrj/Ytqp3BKhxQmZaDCzVRLo+udk30EzVvwf/lJTmo79?=
 =?us-ascii?Q?npuEWr8Mb5hUbvp3RjLGAJBgNT2qsQiBR5G2lw8/9sonCvsozwnQPqFFxSlr?=
 =?us-ascii?Q?1sOWqccJS+5bxMJV1sUfA4kUYC1GW7pfBIizSGGsYJJ7spNRO29bXVKR3v+u?=
 =?us-ascii?Q?3l09oexG6FNs7PVsM0SgTk0Lf+GXM6h/LcZMAi5Y2rrRb4TvTN4JHtbT8yWo?=
 =?us-ascii?Q?HzXJRTKbTa03T9MI8928sp5skEp+qR2pTUc7SKEagIiyj1Ah466sMouBc2NF?=
 =?us-ascii?Q?IwxHsdv2DUtl/T5Mvrb+AKcFvu5sy2oy8I4HYGwPoJifuR17E9wy8KsBhKUn?=
 =?us-ascii?Q?rLUhcSs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4HnZ8Y5iCyUpQpWY/zA/rzTZtyGapHAUWALnMTSaLtjvh7GPyGtG1r0LDO6s?=
 =?us-ascii?Q?C7ArNtmDcWJw6FtNtRh7uizI0Uaog6bodhpsUvIL8uEIFHxq4VrEVcPphi3y?=
 =?us-ascii?Q?cDWp+qYjVRlykql+EFsR+JK97i/eMOV5Zdpg/xLKsx6dbX3mzpqXpY+y0K8s?=
 =?us-ascii?Q?4I5Dq2jZgNlHvADLWIKiJHlourlKyWWwcRvbSdYgELLXDNByX4k8Ivkbu1Gl?=
 =?us-ascii?Q?ZdXWkrYq/vSXZurVZCyNcxMa0Qsb9ojv7esSUnlZFCr1tox3BF5gV9IYsYov?=
 =?us-ascii?Q?kwQHNjiV7sz4x8DV6NTMSecDSUTfNui4sGw6GxPnDpBMtnHzAIx5HG86mltV?=
 =?us-ascii?Q?rnt+XXBsbo0V7BCH58TPUd8cpWDw1H0fHDyRnBRpGhThxF82VBFk+2LNYX3+?=
 =?us-ascii?Q?h3DOW+6SJBx1BuM0NnDF6latXk6Ur/TrRg2PC5IIDKtvXnZ4t7EDeQo8sDh3?=
 =?us-ascii?Q?wVJNF1BsKNqhaJ7MUK8EcZJq3RdBG5t1mem2gN5SFAHwNHPg10Odg+4zmBcE?=
 =?us-ascii?Q?YCBy3SGiyRaDFFLAqyfxSWgSOplNKoGBIITdrl9OpXvIREbtXQGtxsSicJnQ?=
 =?us-ascii?Q?mrdkupkbDRMg3b8giKxTZW5u5gFyb7+poto64p6X+jN33GfWqhr+jzkRN6BG?=
 =?us-ascii?Q?oThgTCpkvN3Ctl+tR0Uz1bd3t17NSnb6OmYZ0cmFAE2HqifVws0EdmUy6lPI?=
 =?us-ascii?Q?OeF8VN0EhNmDpKhf9VkBFaQlY7Ixpfg666blYN1dT8CN3UhwcUJ1C/pHOYp4?=
 =?us-ascii?Q?4YkdNVc7Tgm2U06I5yx5V+Z4Wds+qwBJjw8O0jFO4VsJaBveAyk/uwhvTEtQ?=
 =?us-ascii?Q?fjRO66BgOaUgh7tg9zwAuMOpU6gSC1wrgNpjQKQyGl0rWH7psI1/A2IW3UhM?=
 =?us-ascii?Q?XvCN5FuoNTCkO6alQQrXrXt7NkCIdc3Mut/h176PZ4YvNiJGhc3Lgq//pYlQ?=
 =?us-ascii?Q?jzOqr/JSzyEWBxKWgC9i+qXCC5QxulExYY9OE147Z2xlA7gtKV56M5aUxDRN?=
 =?us-ascii?Q?aRXu9W3l9Z6iYujWwJ+iSVn0WWAropOd1ihdY8XuV/++gyve4JPAMSiz3qDV?=
 =?us-ascii?Q?EQUnS86Y3RLrDuHWBdv8mVD1JpvKdVfPG61X9RVB+P72ddErLW750JuOWBgA?=
 =?us-ascii?Q?WTQt2NVuoXo/31Pn0VZARzKO4LhP2zYOy+VvHCiOZIFcBhNHL43If7KScp8a?=
 =?us-ascii?Q?n52CQCBj3mEukDphd1p9HfKfQFS7z45nrQJVdj1CjCRSh6zCZBvPoUC2zrgP?=
 =?us-ascii?Q?o/p2EFLQQpwW02Tpe7fQ56WQNGO/LQEigVL6BAs59ARkKc2woMO+88WQBbX+?=
 =?us-ascii?Q?5UGCIVPLawFvQRakXxEVXEJN7ptVDcdNs2Gd0tFYr9+plzQpBTzbrAkm3Dud?=
 =?us-ascii?Q?v5NHtWq0y2lJnNuhKtHaW7z0d0ZtWFxdinS2Nxkn+WvsdFyr/oCZY8nHVxDm?=
 =?us-ascii?Q?4D0OJWQ7thMItkcc0jnqSkYtysw2r4SBdJv/o1bReIZg82WtQpG/fKHBtGXu?=
 =?us-ascii?Q?OWlw4mDwUWMAFzUpnz4Y+Eu6bVATROMP7lsSMXk3Ey46acUbTTfoBzHS0YwQ?=
 =?us-ascii?Q?p++5dt/JEu4rTr0yqq6Gmv92+Q/5Wj7dw6ijN3DA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a430c7a0-bedc-4b70-2753-08dc74afa061
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:21:23.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pN2L3MOF5Yiiz9RrwJm8MGYZ8GhEKyJzJSM5PrGGcjhVbWE+f+kI8jICrap04zzE7XjUH6dIRrE9GfAWEzelQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5223
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 30, 2024 10:57 PM
>=20
>  #else
> -static inline struct iommu_sva *
> +static inline struct iommu_attach_handle *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>  {
> -	return NULL;
> +	return ERR_PTR(-ENODEV);
>  }
>=20

this should be a separate fix.

existing drivers (idxd and uacce) only check IS_ERR() on the return
value. A Null pointer may lead to an error reported at a later point.
