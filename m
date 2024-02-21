Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51066364CC
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498616; cv=fail; b=jYv4BK3jumwNh6UWws6o9xyDuDsV/eN8I+fU9nbiTqv1ayKxDps12fctLjzUSI40+ZCuMSgbePev2lMxGkySKmtwsjrJONHYTuxuXzwF2CtLE+3hr0ZTXQa2VqoYHbyjKM4IhXktrzM9qFE2/UrNpvzx0raBxiLcetcSpLi3rTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498616; c=relaxed/simple;
	bh=FkVkixLB595uDE1OMisZ9ef7FtCIiMkXQyleUXU1a7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qv3+CXghRXOhmAVyrxfeT7JtDd5p4Mztxfnfb+YygvkAnzibHmkoOvk0poinfolaIuIfKSUXfoTR8/oY+LSG56GjhZdfOG6NUlmeh130H2h90cdpFQJag891AhDrG5q2xC10ebIknzva5yxL291j4VcihUvdSPSU1B+umQ3uyaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIKzp+9d; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIKzp+9d"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C397F40136
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 06:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQ0OyPofCi-8
	for <virtualization@lists.linux-foundation.org>;
	Wed, 21 Feb 2024 06:56:53 +0000 (UTC)
X-Greylist: delayed 429 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 21 Feb 2024 06:56:52 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6C6114012B
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C6114012B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nIKzp+9d
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C6114012B
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708498614; x=1740034614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FkVkixLB595uDE1OMisZ9ef7FtCIiMkXQyleUXU1a7M=;
  b=nIKzp+9duCRsLgMvYPZQCOUoK7/0ZPQgJPKaMklTo2tY80XQBWm+7LzU
   ORbtn0VjZf5JhuQfTXlg02VI69XDtVArPIkCealolNUjW/Z5OlFImMC+6
   G4UFQFkTru9co8+J3JWsL1QG/G/HU7eoBgN0CQB2uAEbiyaxHMwaHxONL
   /lBa3Dh9zZZmoRpFswTydztBWiFZftfJWxeFzKRrgWLN2sgJJbrj6sVMq
   OlRHSYZlrCAb0xD5SMZ+3UjseThe0lz1h8eAjXMUS+1uf9hFYa3MEG35R
   R8NIrbuGyGdZq4GT+nrGgAICZxtoYsCq5dE25ZjobgLVCc3yyWb1SIZJ1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2764440"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2764440"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5266166"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 22:49:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:49:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 22:49:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 22:49:38 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 22:49:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnFDO0Q9ZvYTWCDmyjXxcsYMOp1olUcZ6M1/tqeXEebXVvELQKjl5fr0KruPpWF+XpRx1mmadptwSrJzsv6xeFJTq6sihpPmzWnCMZtB3vai4zTXCR3ue3oZGwCmlivugwbjPSBZIL18A0OaSswrEmVWdvmYBb61ApsFtroGFxs0NUyiVIdYTx4WAJK7g0/qPo3a07o6UhO/c944BHbiLegWuPztqMoZJgU0LCgMNOmv1wTma+4U/zW3ZcO68bmBMf66h81Jx8hF9anvwgakXt9TF1xQQkyhI63f/hHhOW6aA7Wsp4tMl6CImY1qchpRrAGNZakvnzlg3YC8Cu/uRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkVkixLB595uDE1OMisZ9ef7FtCIiMkXQyleUXU1a7M=;
 b=VuXRiGeSqgEU55MXKDbdwGXLniJ/9TW1rFlrBfu2L8yF3do0Hr89AdS/vgeuQiplwdS5G7/HaOIROiEBMo/OA8lKEJ08oXPILnFE64sGdFzO41TIG6NF4umpW6Rj5By4B6Cyq/DwrlNFoy7y4SVaQ/tlk9A2xGB2NKlBbtUQmKJ8Tqn79hD3IZ7bsnbLOcTbP3mDbfmWeNoxN5WKsxR2Z/+tHCuZ7l8iRTdsc/3JF9nyF8K4JD3MyLYwFPV2My+sH8lfw4KPA6Cs0O7x0NoPlgqiWP6lQhh/NLWQ9loGv7T8kF73X6X/cgDTB28/bBRUHmutLNOuSWYH5XT8ij2XVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB6002.namprd11.prod.outlook.com (2603:10b6:208:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 06:49:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 06:49:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/8] iommu: Add iopf domain attach/detach/replace
 interface
Thread-Topic: [PATCH v3 1/8] iommu: Add iopf domain attach/detach/replace
 interface
Thread-Index: AQHaTQbdnqiGZVOmpEOcHKLJUGm2irD+nkbwgBXcBoCAAA4BwA==
Date: Wed, 21 Feb 2024 06:49:35 +0000
Message-ID: <BN9PR11MB5276151E34AC91883986A39D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527629BF9A0E27E36D3925B18C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b0f5e418-8faa-45d1-b086-61f6c009c0cb@linux.intel.com>
In-Reply-To: <b0f5e418-8faa-45d1-b086-61f6c009c0cb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB6002:EE_
x-ms-office365-filtering-correlation-id: 8a8a8fb0-fb46-472a-01a9-08dc32a94450
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sK+W06GNG1eik+EAGfZc2mwVzI+B9HAdYRqAi27sZno43TKtQPca5QSDtxKXNGIURixTtcC6QwBf0oiFqoE2Eu57C8F15ASkOkF9xKbQSTX2u+u19YWpcU9Q4pR1BXphMbT6dqJTPbVlHoBsErck15+uW+qrTay6F9d+NY1xHit/0ZG/KaN/QBQVvMur4/3ingotkcypJkAXGAnc/zE5TnprDeCqpW1b08kk0iGlMUCxJq1ZhZ7I0mC02q5DyfOLp7BRYMilZPqjlxfLF4gPDbTqZU+0N6AyDQlueb4psXrYFQG+SH5fdBNnQZT95DiXJcuoLBhN3GtZrNgewjXSlrrhKQocYzB9tZGMXQ+MBANJk4LQH/HmpQuFNEjyeARIDOnvltCD10jptYxxQAyP3AQJEjs87iRpIDz4MsCD+uA+3StYKchvhasMvyysEXBzMVapxRfLNi9QwRBOjXVkq2B5QaVKo+wlkPSTw8ksjd7uilJ3wnwrkU037/OL59YP+FCLD1ourXkNmAoj4FYzFa1gIZx+1dH5RxxJoZkZJX08g0u+JV6h1S/HfbWpcSbIFKAQsjYBHAFaacEhMSmxoqBNJK1Y+EYaGZcjISC25+oaWVMFUnFX8hmyEOjw0WFJ+5ot0PRghf/dLy2luZi4rA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWg1QVZtcVpsQk9jWU1NQVZycGpYRkduV0pRTHJibzFiNTJybjQ1U0pBNFdH?=
 =?utf-8?B?bEdZaHFjbXBmOWRmU0gxb3RoVk1PNjdxYk1NWWdvVGgxY1k0WDRTYlFlTTFx?=
 =?utf-8?B?WmtSa1JLbWdHcSswKzNYaGpOaXVmUXNKR3crK0hHVHV5UVlYOTJFU2FDWitS?=
 =?utf-8?B?TC9MUm1LUEJuWlMwQUYzODJwWW9JK0FVUFZWdnNHeGp4UHRpTUVjaXJTL0w4?=
 =?utf-8?B?aUZwYUxpdVREOGQxcGlmSUJVdTFqRjZHcmYrQjZ5NlRMdUoxNkd5MFV4QSs5?=
 =?utf-8?B?emkxK1d2cUZQL0g2bjR2VlFybnVmZWtwY0hTcGZXSXJ6M05PNTFMOHVZQWVX?=
 =?utf-8?B?VUROMEw2Sy8zOTRoR1VwQ2tDWGJKN3B2VVQzeEk4YjRtTlhkb0t5cVVDVzdh?=
 =?utf-8?B?ZTdQTk1lcVRYbEhoRldHTy9wSHdqcmtPSUpPR2d4Tkhha1NyRDllbUUrRWJG?=
 =?utf-8?B?U3FZVzNuZy9WZ0NYb1N2SUFZSjJYYmRMYjE1VEdGM1JNRWVYOGFkVTlZNHlB?=
 =?utf-8?B?UnIvclN6VGRNeGZxdFJvbzNoNGxNVFhZUUwxUjc1ZXAvS3h2UDQvcVpTSFNh?=
 =?utf-8?B?cUdlSkZ0V2ZKak96d3JlQ3ozR3o4SFVkTVEzWUlCVVpPTUZreTZwYlJVNnNw?=
 =?utf-8?B?K1hNRDcxdHVidXUwYnE3OTVCWjBQT3ZVcXZzNnlwRG9zL1lJOGtxT3ZZTm4v?=
 =?utf-8?B?ZWFLakt4aWthYS8rNXd2RGxyNkMwY2phTHZhVEFiQ1dIeXBqYnBqRVhuV0g2?=
 =?utf-8?B?dHhJLzVVcUt6dXZGWU41eUllMjhLYmJjK2VBYmN4ZWdsbGNLbFJaTXFvaWU3?=
 =?utf-8?B?NE16dTBsTExLWCsxQU4xY1VFb29yNDl6c2FiVEMyMElzeXUwUXlGS3VvM0dT?=
 =?utf-8?B?SGwvZDg4bEVCdm1jcjlGTHhlQThlaERubURzZWw3Q1lsamo1cVZ4U1l3Yjc0?=
 =?utf-8?B?WGRxRzVaWnpSM0J3Sys5SGtUdE8wc0l6UmZvWFJBbXJ0b042YW5GQUQ0Yklk?=
 =?utf-8?B?SGtWY1lZcG5WS1I5L2tMSlVaWjBGQ1VPdnFac2d0NGpoY3Z0VitiQm10YmJW?=
 =?utf-8?B?bXJSaGpLZjNta1Faa0Q4WkhaUVZ2REpHYUJFRWlzOVoybThIZUovc0M4WkZQ?=
 =?utf-8?B?d0VKaFoxdjRYRmpxWXFSKzRraEtoMEtZVkhKMS93WDd4UlYxK1JXU1RzNEV1?=
 =?utf-8?B?SjloV2lXak9hM2Y4RlJ6Z1QrcTVJN291QmEvVFdFQzlHeEsrbEl0akxOeU0w?=
 =?utf-8?B?S3Z4ODdhWlBwUUVZSThFbCtSUUZQNFNMUzlaVUtoMzZaREdtRE1GdDJmaU5p?=
 =?utf-8?B?M3MyVTdBMFRaYUd6OHRVMXUvUHBIWlAxUGgwMXpsdG1mWHlRWjh6QzJiNXI4?=
 =?utf-8?B?dlpHeXN4K1orRmNaTXh1c0JpU0ZvS2tVRG1RbzB4eGtJNVNmbmtQeVQrOVBH?=
 =?utf-8?B?QmFSeHBTcGRKWjZuaGRrZnRQK0xiaWF1T1dLTnNHV3JUZHkvbFJQS1dkSDI0?=
 =?utf-8?B?UkdWY3JER3UxSDRCMC9Kam1aWjRPa3B2UlN3WDNHOUJVVHU4UWx5bU9pcWs5?=
 =?utf-8?B?dFNZTTErY3BmNzNwS01VNVo4SUtNVHFjT1lhaDdvQUVqbTZOUEhGckw1TlZp?=
 =?utf-8?B?c3ljUnAwMWMrOXRlZlJUMGpYVThXM1ZrSGkxWDhRZy8wQ0RJS3IxR05udEFK?=
 =?utf-8?B?VW01QnAwZ1NCU3VzTmNvTktoeVd0Uml6SXlLYXFMbXNjdjJaK3ZRTlFzd0xL?=
 =?utf-8?B?Wm9jUVE1b0kraG9hSCtGbGZDcU1ZS1R5QjkzS3B6WjZQNTV2QUtBdnBmZ0o2?=
 =?utf-8?B?QXhFYkphM0RXTkJsWFg0akNmVk1qRHh1L0xvSHhqbE10WGswMDlqemNiVXpV?=
 =?utf-8?B?RzZ0djdqQnU4NDFRVkVrRXNPTHY4NnRrN1ZuVGFYMWVhc29PQ3hnVDNPQUxZ?=
 =?utf-8?B?MFFZNEI0VDRRZ2J3bGszektac1I0SEZsSktmSTdRaWoxQ3dxd2w3NDZHT3hh?=
 =?utf-8?B?eVR4Y1FaWlgrdmJtZVRJaC9UclZzdlNGM2hiZENwSmFMVlQ4Zm5GS1BoUkFR?=
 =?utf-8?B?bGErcWxPcFlpUzhTOTQ0bUFoK21wSXhjU1hrMTBQMTBYYWlnUGxDeVdrSEg4?=
 =?utf-8?Q?HMPJqGrQkNVMFR3gS8q5O14t/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8a8fb0-fb46-472a-01a9-08dc32a94450
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 06:49:35.6434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TspKyzqYdLz57vmwcv2zdLHFY6upsfkFHlf8oeMnFhjShQfdjlYdx1uPFdt/lZWZKOFr57QLDsvpd6ZoXSMXWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6002
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDIxLCAyMDI0IDE6NTMgUE0NCj4gDQo+IE9uIDIwMjQvMi83IDE2OjEx
LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDIyLCAyMDI0IDM6MzkgUE0N
Cj4gPj4NCj4gPj4gVGhlcmUgaXMgYSBzbGlnaHQgZGlmZmVyZW5jZSBiZXR3ZWVuIGlvcGYgZG9t
YWlucyBhbmQgbm9uLWlvcGYgZG9tYWlucy4NCj4gPj4gSW4gdGhlIGxhdHRlciwgcmVmZXJlbmNl
cyB0byBkb21haW5zIG9jY3VyIGJldHdlZW4gYXR0YWNoIGFuZCBkZXRhY2g7DQo+ID4+IFdoaWxl
IGluIHRoZSBmb3JtZXIsIGR1ZSB0byB0aGUgZXhpc3RlbmNlIG9mIGFzeW5jaHJvbm91cyBpb3Bm
IGhhbmRsaW5nDQo+ID4+IHBhdGhzLCByZWZlcmVuY2VzIHRvIHRoZSBkb21haW4gbWF5IG9jY3Vy
IGFmdGVyIGRldGFjaCwgd2hpY2ggbGVhZHMgdG8NCj4gPj4gcG90ZW50aWFsIFVBRiBpc3N1ZXMu
DQo+ID4NCj4gPiBEb2VzIFVBRiBzdGlsbCBleGlzdCBpZiBpb21tdSBkcml2ZXIgZm9sbG93cyB0
aGUgZ3VpZGFuY2UgeW91IGp1c3QgYWRkZWQNCj4gPiB0byBpb3BmX3F1ZXVlX3JlbW92ZV9kZXZp
Y2UoKT8NCj4gPg0KPiA+IGl0IGNsZWFybHkgc2F5cyB0aGF0IHRoZSBkcml2ZXIgbmVlZHMgdG8g
ZGlzYWJsZSBJT01NVSBQUkkgcmVjZXB0aW9uLA0KPiA+IHJlbW92ZSBkZXZpY2UgZnJvbSBpb3Bm
IHF1ZXVlIGFuZCBkaXNhYmxlIFBSSSBvbiB0aGUgZGV2aWNlLg0KPiANCj4gVGhlIGlvcGZfcXVl
dWVfcmVtb3ZlX2RldmljZSgpIGZ1bmN0aW9uIGlzIG9ubHkgY2FsbGVkIGFmdGVyIHRoZSBsYXN0
DQo+IGlvcGYtY2FwYWJsZSBkb21haW4gaXMgZGV0YWNoZWQgZnJvbSB0aGUgZGV2aWNlLiBJdCBt
YXkgbm90IGJlIGNhbGxlZA0KPiBkdXJpbmcgZG9tYWluIHJlcGxhY2VtZW50LiBIZW5jZSwgdGhl
cmUgaXMgbm8gZ3VhcmFudGVlIHRoYXQNCj4gaW9wZl9xdWV1ZV9yZW1vdmVfZGV2aWNlKCkgd2ls
bCBiZSBjYWxsZWQgd2hlbiBhIGRvbWFpbiBpcyBkZXRhY2hlZCBmcm9tDQo+IHRoZSBkZXZpY2Uu
DQoNCm9oIHllcy4gTW9yZSBhY2N1cmF0ZWx5IGV2ZW4gdGhlIGxhc3QgZGV0YWNoIG1heSBub3Qg
dHJpZ2dlciBpdC4NCg0KZS5nLiBpZHhkIGRyaXZlciBkb2VzIGl0IGF0IGRldmljZS9kcml2ZXIg
dW5iaW5kLg0KDQo+IA0KPiA+DQo+ID4gcHJlc3VtYWJseSB0aG9zZSBhcmUgYWxsIGFib3V0IHdo
YXQgbmVlZHMgdG8gYmUgZG9uZSBpbiB0aGUgZGV0YWNoDQo+ID4gb3BlcmF0aW9uLiBUaGVuIG9u
Y2UgZGV0YWNoIGNvbXBsZXRlcyB0aGVyZSBzaG91bGQgYmUgbm8gbW9yZQ0KPiA+IHJlZmVyZW5j
ZSB0byB0aGUgZG9tYWluIGZyb20gdGhlIGlvcGYgcGF0aD8NCj4gDQo+IFRoZSBkb21haW4gcG9p
bnRlciBzdG9yZWQgaW4gdGhlIGlvcGZfZ3JvdXAgc3RydWN0dXJlIGlzIG9ubHkgcmVsZWFzZWQN
Cj4gYWZ0ZXIgdGhlIGlvcGYgcmVzcG9uc2UsIHBvc3NpYmx5IGFmdGVyIHRoZSBkb21haW4gaXMg
ZGV0YWNoZWQgZnJvbSB0aGUNCj4gZGV2aWNlLiBUaHVzLCB0aGUgZG9tYWluIHBvaW50ZXIgY2Fu
IG9ubHkgYmUgZnJlZWQgYWZ0ZXIgdGhlIGlvcGYNCj4gcmVzcG9uc2UuDQoNCm1ha2Ugc2Vuc2Uu
DQoNCj4gDQo+ID4NCj4gPj4NCj4gPj4gK3N0cnVjdCBpb3BmX2F0dGFjaF9jb29raWUgew0KPiA+
PiArCXN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbjsNCj4gPj4gKwlzdHJ1Y3QgZGV2aWNlICpk
ZXY7DQo+ID4+ICsJdW5zaWduZWQgaW50IHBhc2lkOw0KPiA+PiArCXJlZmNvdW50X3QgdXNlcnM7
DQo+ID4+ICsNCj4gPj4gKwl2b2lkICpwcml2YXRlOw0KPiA+PiArCXZvaWQgKCpyZWxlYXNlKShz
dHJ1Y3QgaW9wZl9hdHRhY2hfY29va2llICpjb29raWUpOw0KPiA+PiArfTsNCj4gPg0KPiA+IHRo
aXMgY29va2llIGhhcyBub3RoaW5nIHNwZWNpZmljIHRvIGlvcGYuDQo+ID4NCj4gPiBpdCBtYXkg
bWFrZXMgbW9yZSBzZW5zZSB0byBidWlsZCBhIGdlbmVyaWMgaW9tbXVfYXR0YWNoX2RldmljZV9j
b29raWUoKQ0KPiA+IGhlbHBlciBzbyB0aGUgc2FtZSBvYmplY3QgY2FuIGJlIHJldXNlZCBpbiBm
dXR1cmUgb3RoZXIgdXNhZ2VzIHRvby4NCj4gPg0KPiA+IHdpdGhpbiBpb21tdSBjb3JlIGl0IGNh
biBjaGVjayBkb21haW4gaW9wZiBoYW5kbGVyIGFuZCB0aGlzIGdlbmVyaWMgY29va2llDQo+ID4g
dG8gdXBkYXRlIGlvcGYgc3BlY2lmaWMgZGF0YSBlLmcuIHRoZSBwYXNpZF9jb29raWUgeGFycmF5
Lg0KPiANCj4gVGhpcyBtZWFucyBhdHRhY2hpbmcgYW4gaW9wZi1jYXBhYmxlIGRvbWFpbiBmb2xs
b3dzIHR3byBzdGVwczoNCj4gDQo+IDEpIEF0dGFjaGluZyB0aGUgZG9tYWluIHRvIHRoZSBkZXZp
Y2UuDQo+IDIpIFNldHRpbmcgdXAgdGhlIGlvcGYgZGF0YSwgbmVjZXNzYXJ5IGZvciBoYW5kbGlu
ZyBpb3BmIGRhdGEuDQo+IA0KPiBUaGlzIGNyZWF0ZXMgYSB0aW1lIHdpbmRvdyBkdXJpbmcgd2hp
Y2ggdGhlIGlvcGYgaXMgZW5hYmxlZCwgYnV0IHRoZQ0KPiBzb2Z0d2FyZSBjYW5ub3QgaGFuZGxl
IGl0LiBPciBub3Q/DQo+IA0KDQp3aHkgdHdvIHN0ZXBzPyBpbiBhdHRhY2ggeW91IGNhbiBzZXR1
cCB0aGUgaW9wZiBkYXRhIHdoZW4gcmVjb2duaXppbmcNCnRoYXQgdGhlIGRvbWFpbiBpcyBpb3Bm
IGNhcGFibGUuLi4NCg==
