Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4F446BD
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758281; cv=fail; b=V15W+w7yYwHHXbb/JbCAKEh/3i4SNUhJmn3Y3v6wf+loru1Zi2yZCkmYaR6OYA7WCrswYogFnXSwzvtCuPcS1Y51K3VE5xZbN6Gb4CNwIEWkvwKY9w9siuYOgjkWOgofpYoy7ztkllhyLU86F7AHd1rAdhljfYRm8Atdw28uxyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758281; c=relaxed/simple;
	bh=hzOR37GAJJJGbUfWTXVG08Ky5oh2jAC/+NQAG0SUyEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNkXSqfR4YYc+Cxq1B96OnwDvyvHiTnZPZvTmAESntybO4/9QbZsl4ezV9HVI5y99xvDajBxSBCg8vmtG2BIqHmPmiS4xtL03bx69IDfe2Vlvm3YYauFCT39tD9DMhGnztN80sIdb7dsNR6aVBgXp9FeiebwiPRD8tysjJkAo40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oyg/+XHC; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oyg/+XHC"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85475405F2
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQKfoHT5ePQ8 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 07:31:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8AFAE405EA
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AFAE405EA
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oyg/+XHC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8AFAE405EA
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715758277; x=1747294277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hzOR37GAJJJGbUfWTXVG08Ky5oh2jAC/+NQAG0SUyEA=;
  b=Oyg/+XHCNdAKza47F1sv2t1Aa4UnxmlB4Uo02P4YMhgaNJQpeQSVXheD
   hguW/DN7NpmLOmmkjk0/daQPvwJmlCLYw/P62SIEtSmlclMG/HBDwgDTc
   YIYEJRzuuhQWXp8eiM5mwG7aIqQjQH4NB/0VsvgzwGPoV7TNXYDkYS4Fi
   JLSp0zgPi548RqypWIV+mPi6uuj83ENq+L4aOq1EUBhjeqyvscbUVNUCn
   7utJgnnSTgCoqol7CPPRa2Ksu0I0q5mQgYG1mb0RTUNbwGzIH2ImxbtCS
   zV2qbTRQy1CE8GPV8LUsoSLHn06iIB9fkWrTBjHWApcLTC5x3LnjScQDM
   w==;
X-CSE-ConnectionGUID: mysHhULiSh6lSzrv74ltOQ==
X-CSE-MsgGUID: tBOLGeRKSfeZoi5I7n6TIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="23188375"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="23188375"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:31:16 -0700
X-CSE-ConnectionGUID: 7bLQsIBYSKG+LYdfHTBbdw==
X-CSE-MsgGUID: /w27sHwGR3yJ6qZfHzDW5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31045401"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 00:31:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:31:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 00:31:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 00:31:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGYq0/+qhH9hyT0f5yVSAUXVQrBZCf/eKhk+EZLXFQfM5+uDcII8qM5e4j+ykn22kOG1aMi+fHbiFd8pOC43wLH208dGbs5fAfevwc9lveboaBgASdTM+kgpMs/QR/unRdFaxeXrg8EnT17r/NXAQsB8zRoH46YqNoOo+Vj0B2jkb8IIwbiBXYAxNrdHn8vehUloiYgOIVB2BCGLjbdiRD5halBCBDLmNRlpkK+gqEqLphNqWAGQkTtNpi3EIFJaUaZIhQDtzxjGDCi/TJ+XBElJfHTDPSMdmAqj4K8gTC/AcYDrdpZEav7FLoRVO97XnLoLNWKrVrmRYjXD/wmuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfkulaZDt7JnYGSAS1aq/PudfMHHGdz+W1tAzdZ2+mg=;
 b=VnGaD2PkeRSNlfhtor450T4MW0ifbm6dqzjppDLhTjgvaL5ciS3IG4A6kaNtXrokateSnAB8ozGSGlIdKZHmKdoHMHNeutZiAPpXPtiZi/COksmjemVOkEIbYmoRPVGd/YOZLXtuE1K2lZNhYWro1UWEPdsq8yWbZnvNcIb1nVXiR+DJts98GrMTqujqKOjF4cxukclkxVE6USdCtgVQ7py/WYJUpXMLIotwe8OooVJC4Mga1360bZ9TIvM7FSQ1hh12NMYDhroa8O/u55sgK2UYhhlZICaJzdu+0uIk1GgtBC0UCKB68BD+ifUwVrvC7FomMDY9toMNUzsVwED2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:31:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 07:31:12 +0000
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
Subject: RE: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Thread-Topic: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Thread-Index: AQHamw8FRMPPYVB/4U+b9NV7aZfqhrGX+wIw
Date: Wed, 15 May 2024 07:31:12 +0000
Message-ID: <BN9PR11MB52762A339B6E103369C22F068CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
In-Reply-To: <20240430145710.68112-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6615:EE_
x-ms-office365-filtering-correlation-id: 960a5b75-1997-498c-83e8-08dc74b0ff68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?m8Fpd9x2mLnz0x7QqTfDIsvggmalYJFALorplOHNB2H4qR9hzQ+5UyC533cA?=
 =?us-ascii?Q?HFr/m7mvzrLvslWWHOrjLe9/la2EbV1nzLef7JLsrkRwPLk4t9iVNArcjNfn?=
 =?us-ascii?Q?kljYBFabmGRI3NQKh7+wkON8DVnX6oEwZrUVVn9WZAm/hwQC0qspjObg2ynt?=
 =?us-ascii?Q?F1j01AZc5g02gZpaXhMzlvolRfEc7HC303vaMJvY4AJiSGoSLVHuvP7noBi9?=
 =?us-ascii?Q?MxhlatzwWdW6lI7Lhnh9QoJkp2JvUX9G/o+OA1S3wp2zO3mQB6LFcMg++0hI?=
 =?us-ascii?Q?yl7OBJLPcFxoUJF787vc2j8odP4mrA7aP1BkAfBl3M9kTVegwjLIufqX56Ew?=
 =?us-ascii?Q?T8S9LfWXVH3TGqMfOylAhPw/oo3Qj3lFAYMKSYeA5Ec75nmmIFqskhMJstsM?=
 =?us-ascii?Q?KD+asEE3aBtofoB4fHFun4oAZvvxSDg40Rbz65O21RkwcrG/8458FiEzOqAj?=
 =?us-ascii?Q?crHX4hQth1Lsjdr870IKDqYtMg+7oHeqXEM99OhwffnX9essxSUGzo0TqUeD?=
 =?us-ascii?Q?v+FFt7kZv4vwaR9H9p2rxTseNs5slel6/1i6hQG7dEV54gArTy+yGv94QUva?=
 =?us-ascii?Q?e0q7SPqW+I9URpRM23Zxhwrwvfi7i6xcIfYDjhzAyeydaPtdbvHB6ckbFTWp?=
 =?us-ascii?Q?Xe9yPvoP1m7NuWuq4GUyBa/K+RAUZa6sUsAWsjkVPw4yZMiVVEOGHR9FOGwt?=
 =?us-ascii?Q?2h/DN9fxW5QTRg54mR8O6yN9M1DbKDbig0gY71YFdy6hnbOgQl5mQe4iIfMW?=
 =?us-ascii?Q?fJGA+iIhvQnBFwa093mdhooUELo+edqTybko5yPTCM/FQk8FHXy0UGRk/cAC?=
 =?us-ascii?Q?UQ87ez7LmEdyY7W3/iY25qUN6e1CXtmmQaShZGi8ihs7GtWFkAYnepqKqgb8?=
 =?us-ascii?Q?scXtF/cE+AzrK7rmDoVksYa+v9u4h19j1LApUwxd8rEd6b7NgmG6eebqS84n?=
 =?us-ascii?Q?AhiGgYM7+uONCSuAdpvF9NTbnD0r929XHgOeRg6wJSJcsj2/1N1RFdiiQzXT?=
 =?us-ascii?Q?G2E+HGUpLDEyfF9aLfYUkU2nnaJte6gCgeeFBIZuFXpA8MEVDkv5Rhx0L5eW?=
 =?us-ascii?Q?mGzJokkR57pgxI9YeWiv5k0ZkprTszM988fGsWSu5XQ5DHd0Hd8RlxsRUT77?=
 =?us-ascii?Q?jmvZKGV2YlN00rSTxq+/AtD+O5if+wJKEdi4VFejpmBTaYtdb5O63sk7So2l?=
 =?us-ascii?Q?94MNcL450T0eTumViGZGYeAV9AEHH9u4avonqByxFbYy5TIXhE8Bp+fXd63A?=
 =?us-ascii?Q?lNvtcYrrjW5wSRfmfbRREFgMDejC+epmdH6Uib3QRQciU5TLXBR+NTpp21fK?=
 =?us-ascii?Q?PWLcUaMgIZ3GSQhirsNb9vLvZysNYETPAZAU3sRLL6XAbKQmubgXb3IF1gC9?=
 =?us-ascii?Q?AwaN5zE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TlD9t+Y6748B/gJKfF5MNB1ZgNKezl8xfi4NegRVodBAxke4fRXfbhPddOB3?=
 =?us-ascii?Q?ybYsvI2IxLywcThxQvzGlEnKba+6Kk6H1EtvhZ68KK4FLYYUaTkVoBlpCQUZ?=
 =?us-ascii?Q?dtn6dvlXHdls6vQAKLpCKAVAIi2sSwVF11/HB/MwVa2oUd5tJ9Q6Bs1WRKnG?=
 =?us-ascii?Q?N4otcDW42J8YI57Ge3R/8SmSd5d5KzOTRxujI4ZwStFcGdI/5/rNTvFk0uLw?=
 =?us-ascii?Q?qmzMuO1BBkR2QQDAquN67VzaOth4BiD9vqePovC7GCKtcsoZO1wJmgBBM9tS?=
 =?us-ascii?Q?GkS8EmEHynfB4uKa8FAgBfdEjxfw229VCocVSw9UlszR96Qv5QzutzHcffg+?=
 =?us-ascii?Q?9HdX1e/blV0Rq2BYz3rD2IVajq10CVwTUqT8b8QDoBYp2y/Wp4urjpfQptPY?=
 =?us-ascii?Q?W376IvF/6RSgy3QeS9WL5/wMIOM4WgVeZQ8LZ0m0t3DqfI1qJ3+wE8+GUtPf?=
 =?us-ascii?Q?avJRzfgPFmIjuO0v3GXl0k7vu3PdVZEEqPKzXwMK64TzJBHOSfgG1rWsVxGF?=
 =?us-ascii?Q?yWAlX4BcAvEBHVMqKwfdg/CUm4Hv+dzroTRTVLnAABCxP5C81CZg0Y4kLkMA?=
 =?us-ascii?Q?I2Q3Nwfl+AQRvZpAxS52sHXV1efXeDWXeUH3WERYGSkvDrPT5PEn7RYe3WE4?=
 =?us-ascii?Q?6RF5nlHtrftv7uzxMbbJ9yQG3J7Tin5fcpuWVjTtjPmHtWAmWKDMsGhnNTLG?=
 =?us-ascii?Q?pBiTgTiT7ctFeQleJyJdMX2RMG5UC7GnWrMCpUzZCecSdhpaIKhDGT2qaPUo?=
 =?us-ascii?Q?V+NovRfrfZGJB9pbulDxd6NPhvDGl1cxtPtifaMuYKcJT9ud0A2918EW1DCL?=
 =?us-ascii?Q?VH6HquujjPFbhL1cWc5+7Mbs3gCs7SMikxDUpaZngTtZfATF6uL8yY+ZSvwA?=
 =?us-ascii?Q?sG3U6uWr3uUTIqiDkn2121oeWQjWi8H9cTiuvugvEDxx57w97feTda85i9Gv?=
 =?us-ascii?Q?4JwNDYo5sUjEk910pCuxAdSWnSWpbgfVtbi0W/LC9iKDGrfyxTh9bfZLqo1R?=
 =?us-ascii?Q?bBj1FxMG9rcRyfJa7wobbejiXWrlGSysHbStRAldyMbLKGiLeC32yUx+uYpH?=
 =?us-ascii?Q?6aDMnfr6JNon1zCmzlfJtyTf8KITSZzjkRXNtQyfsi17Hmb4DJ3pN/4Gho1r?=
 =?us-ascii?Q?BeJo62aWUfkg3sAgULpMZ6EWIs9mpESr/M8TN7P23qHzZWLeL+XRb3P1qtHc?=
 =?us-ascii?Q?OtFMeczlDNWGAwhvVs9wqX+R6t4Jvu49GNGDg8YkaB5mPbLlfbduIgHVM0VN?=
 =?us-ascii?Q?kBr823gQrrwz06doQlv8dVmDIn3HepBiQLOtav4Jfr9p6D9q+cz3LsfV/LCY?=
 =?us-ascii?Q?gdDwRtFZbt3mHuTTPnGTy9fZ6InGnRzWauRSGyHfWSPf7J3mGbTQuJR5ua7q?=
 =?us-ascii?Q?1MB4iKH7lt9+vq1oZPUKk0tBrK9pu0c8laTUe17TPUEOZKDv8YMQK6ARqi/u?=
 =?us-ascii?Q?W5JDEzIydQ3SqpvOqa0Ryk4tRJoPbTIt4YKyYe32jOggFidmIfaaY3/qECka?=
 =?us-ascii?Q?Yeys15EksHRpebQKDZskxxn8Wruk12f+WGQzRf2lgwfCdu7iA9Wv7kcWMHsE?=
 =?us-ascii?Q?S6l2UNGcivgLDkNyjJssMhjiRcoaqOPhCZytUMk7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 960a5b75-1997-498c-83e8-08dc74b0ff68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:31:12.7808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVjoaS8HaxdQIcYKvTYnj2etIIMZCDZH5vpTMJ7C8IIYykfxd7oAg4mpmYbNEvzoqv427WhU3Oqcihi7OAwfCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 30, 2024 10:57 PM
>=20
> Previously, the domain that a page fault targets is stored in an
> iopf_group, which represents a minimal set of page faults. With the
> introduction of attachment handle, replace the domain with the handle

It's better to use 'attach handle' as the code does.

> +	handle =3D iommu_attach_handle_get(dev->iommu_group, pasid, 0);
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
>=20
> -	if (!domain || !domain->iopf_handler) {
> -		dev_warn_ratelimited(dev,
> -			"iopf (pasid %d) without domain attached or handler
> installed\n",
> -			 fault->prm.pasid);
> +	group->attach_handle =3D handle;
> +	group->domain =3D handle->domain;

this change also removes the warning message. Is it desired?

