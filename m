Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB2D28F5
	for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721349455; cv=fail; b=UvyOjjflBtJqq8lnfMzPcMpOdDcF4lRr7cdCyfCZjI20Dw8qIPdG6FjSzm7vtygTpSOjy19klWFPeprQL4qRXFar1jXOML/GP5BHRNsMsCZ3pT35vxm1i26bm6D2XmZjuq7GSMwJNlc3dGkyXDma/SSa/wPa23Z/8tp+z6Q0v4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721349455; c=relaxed/simple;
	bh=V+OsLoO1wU477WM8VOAtAiyB6AlvIUP/9oVEAyQEPAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9xBQVDzJNpecngXcscdOGneSL0cQV2F+qBOyWKHDCdKoF8a0agBvdaK1tkcEKZ3ouAQVWTo99+lH2FKIS8y2audQUjYcKj+9zU1WpGQOFqmzNQpSN9DVNL8R92aufAcYPKcQRnTbOn9t4EhcgHh1Xq03Fxub2Jf8zJ+nay2xJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kln3vFWW; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kln3vFWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721349453; x=1752885453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V+OsLoO1wU477WM8VOAtAiyB6AlvIUP/9oVEAyQEPAM=;
  b=Kln3vFWW/jDEwpiICM1ZTtcoirN7DfwqPRe5UI0eHFxo67VUiw8cHy+Q
   QSjdBgBBPPeOOabv1FGNQbNhtcABGuCE9acCKydQROR1VQpHRNQJldPiw
   oGraXu3/sk54wICHLUY7SooWEaE8akOPpcj8yBKRN8vNc23uAF40sfk95
   xINwq8vvkQlDlKvPOzcI0gIGZE5lY8q/d2k1z5Lhz++4kEVNp7cPEvEYF
   HohtXtCgxctMKmrJVjNhkHY5xeCEEg71sKPmLdvy/yKtrZR8eWM8RTzlL
   EzYB6OpZKkMtGoCAOUsTvV/ezgLrQ/jsTli5873Ylj+Jm8azYMzJAadOc
   w==;
X-CSE-ConnectionGUID: gpS3XJJpRAicavUa8jcvRg==
X-CSE-MsgGUID: Fq0e7JxsSJqNRoMLQhiE6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="18905242"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="18905242"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 17:37:33 -0700
X-CSE-ConnectionGUID: RvcEz+PGRuqSOb6oIGIr4Q==
X-CSE-MsgGUID: azbHxleYSYKyM7vMzUokYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; 
   d="scan'208";a="50696163"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jul 2024 17:37:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 17:37:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 17:37:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 17:37:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 17:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndQcXNkFA5/WzywGSqR5aVOX3psRNTSM2flm6sHkUG1pR4j/1uu3owcXmkqBwD+Z96utjAGPR85r1OBoklu64Y2MCCJvrH5C2aCruFwzwMyKTRcTzFYUtiVOvmUfBrpkhXFwaO/ws85zAFFyUpE+FMotY/WyIAFfrUxvVkJAfSDmnygJylm5ahg0PA8o86Krthhooo5VA58BnqSvSmw0YdMDd5rZ11OlwsEufXasLyODouRIdbFeAStK4tD503cAcDG8xEs6f39dlDSqfKf8QbhBWPNL6m1g5HSEbPtlGc4SsgqzXQ+jMz5XvxXXUxcIfQgzJMGZaBZzeUhdZCh7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffv2FWMCtdW7DKIbvqYTZjj2NcijP+JP5NphdddHFEk=;
 b=B5+Bhy40+JmsJkZkDCU9mcYhToqlcbg5WmGYrKkjG5hiSgYSNEh0r328IzJiTIiHJd2t7+WCFt16UAZP+Q1lsiR+HRqn3mJBQ3aEb0w44YCG6fMrY39hY2ba6nJahX9SkF6PFR4eeUyH0uS+jF+kBh7Ewqseh6ntYkkXPWnkR0AgNbs5UGEgANclKocdhwnkbY1B+3pAVFBKBWM6idxenP7QsBEBzDppx3MWfbzY4O0RLIkIO64gtoFTnaSu+9g+q3NFZOdjKIpoYo2RLTyHRDvL6Z3pfzhCJcuGMoM686v9xir62YRJJOhg8ajQ4Yh/StJzuRfqIiZgaJLrYrlCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by LV8PR11MB8559.namprd11.prod.outlook.com (2603:10b6:408:1e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 19 Jul
 2024 00:37:28 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2%5]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 00:37:28 +0000
From: "Li, Fei1" <fei1.li@intel.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: RE: [PATCH] virt: acrn: Remove unusted list 'acrn_irqfd_clients'
Thread-Topic: [PATCH] virt: acrn: Remove unusted list 'acrn_irqfd_clients'
Thread-Index: AQHanksvCLqY0CXNw0iisCpi64p+7rGcM6EAgANLW4CAXbiLAIAAcaQA
Date: Fri, 19 Jul 2024 00:37:28 +0000
Message-ID: <SJ1PR11MB615385A66E65F156BE177D20BFAD2@SJ1PR11MB6153.namprd11.prod.outlook.com>
References: <20240504174725.93495-1-linux@treblig.org>
 <ZkfyfrDysJ2WnSZq@gallifrey> <Zkq183IzBA6cV9FE@louislifei-OptiPlex-7090>
 <ZplUWugKFu37t3PF@gallifrey>
In-Reply-To: <ZplUWugKFu37t3PF@gallifrey>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6153:EE_|LV8PR11MB8559:EE_
x-ms-office365-filtering-correlation-id: dc7749d8-eada-46ba-4ef6-08dca78af7fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?H3EmO5c3XQmWDg2c1W5Nh8tpoEyloE5zC+izljA4yO6kh+113hfVf6GKr9+H?=
 =?us-ascii?Q?sMW3nDhsOUHzPqHp4Obos5z0SOEnf0GfgkdrLqILB5Q6X3XnpJll2sJuALtQ?=
 =?us-ascii?Q?tNUOygk8QhLFXQgI3dYyVjFESsSZBTq5+NFp6RP3YKNrHND9kQAwBEOAwf/E?=
 =?us-ascii?Q?5Z9/4mtt1F+wKepkbAAnv04hG8CLZ7bzzSNkY8M4BYhZ3jmuOsZViUB+tV5R?=
 =?us-ascii?Q?yxfI4RPLKilMCQISYkubeobIZBQL47a5wEd+DXuviEVv2XS1DWmb4iyRnv+h?=
 =?us-ascii?Q?c0RCGMGRHzt1ydOAcuY2aYMYX6THXGXHx48niOHqxoOkmS5bmAiEfP2p9dUm?=
 =?us-ascii?Q?Qe8Q0HuM2uWzimfws1IWdL/OpfzD7KD8SODTCfmyjPoqIS/2vpzVqZXJtiNH?=
 =?us-ascii?Q?QruPO1oN3F8/2OhZrVE88fvL1P/mvUIBBo+tqJL11mbPaS47atUE4dyVdCjt?=
 =?us-ascii?Q?MzuPNDuek9njKGFYeN7PtO0hh+mZOOCnZ4fxcpR95jGJP3ljFhByKiIXnl5H?=
 =?us-ascii?Q?Q6xJiKzZide8jEKzEyNCWTt3uIA6zF0QCwcngqK1weQptFIscQNuk+lYksJK?=
 =?us-ascii?Q?nM8vD1ha8+PqJB7S8EOviFtzfKOm4G4Ytg0vE+YI+cdKAyUP+103XmVau6uW?=
 =?us-ascii?Q?Cgg5+33nZBqTer86mUYSvcv0qSL4nRSNDCJ3ZF7HSjlociyuyDM+nzL1ECYi?=
 =?us-ascii?Q?tTS7vqeKskD0e9fdDjKGSqGDVqOMfCFnecrOF0SeVpYWJWP91fx/07dXBNK+?=
 =?us-ascii?Q?z6S5CAPcWeVS2taCH8TM+Sj4AsSBQuytrJDz8DM0DVzC86rGFn+xMmJcDDOS?=
 =?us-ascii?Q?qMB8v+VQboM3l3KjhEFbkpEJiI2r9DSvE2Sy2NoFIhdUEC+wW5mjtTYLk3bo?=
 =?us-ascii?Q?vj8fDvuWP9cikBzGykJKPglXR/3Kfd7lLkS7n4YqWNY13Q5NL3aznCsxa7/c?=
 =?us-ascii?Q?sXWovV8FdEK/jhBm8ewC7Qd1qHSfzxziTmvnmr5TKozQhoOyEkTb9GnTMSRK?=
 =?us-ascii?Q?qtwfGSt0PrfJwPiLN0pVWjDdnMW8PTZ4vvokrjWL9l3AZgwcRY6gHGsBWF3c?=
 =?us-ascii?Q?9jvcwrSGsawZJAO4jGSiK2wsl/nqiqbaDK2b4RgFjLloBrkslm1oI1pRDtwW?=
 =?us-ascii?Q?sNMP1lhfMRias65YE0WX3zF+jL9KjcpVUPSHBD8TjQQtD2G4guU1pnCTW52m?=
 =?us-ascii?Q?bcxKj4+G9oU27HWWnsFuuLcDiDilvbmRocZsZ0t/jPd8y/gWFYUAqRmAL3tk?=
 =?us-ascii?Q?5F5pDahN3Pc7kNibIHe4rQGBx44iXoK4S2jMdE+RTzqauKTVtWJosXhrlIxY?=
 =?us-ascii?Q?o/lj7SH8DqphMrejzkH4LUuJnUtq+3yh3dpJRFxicJwpTIzhqQi5mT2+aIEw?=
 =?us-ascii?Q?YDI3rh4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RiyAkGwIWGPZHJln4SKcsAohk3Ae9mXDW9qs/vTCz7WE4fP4utecY3HdX7ba?=
 =?us-ascii?Q?wi/7/gen6bSA/P6x2a9Q3INLZwEguvjI7/v250eHt91Wx4hAviXW+fYKF0Xd?=
 =?us-ascii?Q?3oHTqVYZhzG0u1wHCsKkitp4CdJMDGzBNZzT4zqcFyRypB3tN/af0fJz3ZDf?=
 =?us-ascii?Q?oOAlYfEOkOW+bL44X8F/G98O6ROP4+NqUJM8zPv0wlcGqZLH1mbGkPPfX0mP?=
 =?us-ascii?Q?d3+cppsr7XRcnbp+byi/f2CxVXqtPXdkTNtvJyDAo9E+3ZPa/hRcC6O9jvFj?=
 =?us-ascii?Q?1iri3d9842NmBSegjgdHGBi8r9wrC5OfuU1aS3fz0v5D3QKnYwVItz7HZYMd?=
 =?us-ascii?Q?n5drC84LmAh+QaUXn7jx2jcrHfOxRrzDainWrzxLWWB2+1bPW0j+tAjy4vQT?=
 =?us-ascii?Q?9NCypSnCiTIdrFRvzzu3LG6CphKO8TWddUJkROjGGH67dfXJEicI7/8RBIyD?=
 =?us-ascii?Q?OP1gVdD0BmP/pW6QYu0UGG+hnLnLiP6J9e73u9hedSnfdisPid06BEIS/k3s?=
 =?us-ascii?Q?JN0VE+uGI8wDiqJ+MiGoc53rXuGVIZqyQ2bZMN1h7S7dl3OjoS2W1UsUenJn?=
 =?us-ascii?Q?KiI3fu0P7H3RaZjP+DKLQdwkyr6+tZG7OdpGK/oLTaiooRkJDBx5gfVBTUQX?=
 =?us-ascii?Q?JupQeaVeAZ+K1UR2g8VKEoghGQC87FFrDcu44WzRK0IfFJKCn/e7FPMu+gdc?=
 =?us-ascii?Q?yrCGoMhgHHkIB33yNSmoe+CYwXd/gAcePD/agnr8SAFgTRkI2EFstV1Z6IV+?=
 =?us-ascii?Q?VbcyKC60iMSlDzOxia1TutJudfr8aRxp+xSY2sXmDVMhEwzwOL+aqyh9yaCc?=
 =?us-ascii?Q?TlNZNSipQ7Y8u7RapP+Tv1yQ4dEgcxDLo//Jg/48rpeH5X504vbibM08NK65?=
 =?us-ascii?Q?NSp4oQoq/rnQhcYGxxj+/l6Dz6VSJPhvCV/4xSinuWV6xaZ1gMiKVjuvPQwO?=
 =?us-ascii?Q?0Acvl2AXBUtLHjShMEkRK/6crkEe9u3UyQ7LsmAXIAU8guf8X2xCer3HM+DJ?=
 =?us-ascii?Q?2eDTLfCKuuFU5n/v8V0UrSQ8axXWVsOJn57o0mkFAbpUoh9Ex+En+G9rlKZB?=
 =?us-ascii?Q?IlL4hvTnuGP1suv1Gz1jE4X8s9wjihu8U0jckH3hs+sctfYCiOlwIEmx0lBj?=
 =?us-ascii?Q?NdZRXCs3anGDY0v/Lm7WRGz2cGYcFkFAj9tfHs6gaEbwa0eaOJ8RpkUFUcMC?=
 =?us-ascii?Q?+How6uApHHQeMCpH7I3nVm4Z1P5P4yf6xTjUFvUl5SfC+TEAQMjSRTLyeDb4?=
 =?us-ascii?Q?G3frnrcijgk4t2eB5mRpfu2D9t6n/kowI5+pJesBAxvJvzak+dNAh7KSiOGu?=
 =?us-ascii?Q?i3sg+GgtPUVy8rWkOyEjxLVlyxVjyu2VMpfK9HGMj3ebGa64deC5H60AiE8P?=
 =?us-ascii?Q?3PWoxobVPAV47cV34M0hN4fFVxy5iFzjkkHS5EIWkHPWeNHdT1k5Nfp5CG9P?=
 =?us-ascii?Q?yY4m5MKW6Xcaug1mLAUX8g1Xr3OHj1tOwSybVQpDfjF11PO7cHx1SBixr1/z?=
 =?us-ascii?Q?Popn4TlT1UjmV+RgRoa3xjZ7RIutwE1/be5TwfmDs+uHzdo464TgMzNLQkK+?=
 =?us-ascii?Q?fsoKKaMK+it5JeP0oNE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7749d8-eada-46ba-4ef6-08dca78af7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 00:37:28.7238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1DmUowd0iwRlzUOgEUHR5Kiwm4OGoRUsDVN2K+tEwXsybfhh04MpQder7pORZ/BCwVttelQxozeJm8QuOtlvEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8559
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Dr. David Alan Gilbert <linux@treblig.org>
> Sent: Friday, July 19, 2024 1:44 AM
> To: Li, Fei1 <fei1.li@intel.com>
> Cc: linux-kernel@vger.kernel.org; virtualization@lists.linux.dev
> Subject: Re: [PATCH] virt: acrn: Remove unusted list 'acrn_irqfd_clients'
>=20
> * Fei Li (fei1.li@intel.com) wrote:
> > On 2024-05-18 at 00:12:46 +0000, Dr. David Alan Gilbert wrote:
> > > * linux@treblig.org (linux@treblig.org) wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > >
> > > > It doesn't look like this was ever used.
> > > >
> > > > Build tested only.
> > > >
> > > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > >
> > > Ping
> >
> > Acked-by: Fei Li <fei1.li@intel.com>
>=20
> Hi Fei,
>   Do you know which way this is likely to get picked up?
> (I don't see it in -next)
>=20
>  Thanks,
>=20
> Dave
>=20
> > Thanks.

Hi Dave

For this patch, you could refer to https://lore.kernel.org/all/202109100947=
08.3430340-1-bigeasy@linutronix.de/ to cc Thomas Gleixner <tglx@linutronix.=
de> to help review.

Thanks.

> >
> > >
> > > > ---
> > > >  drivers/virt/acrn/irqfd.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
> > > > index d4ad211dce7a3..346cf0be4aac7 100644
> > > > --- a/drivers/virt/acrn/irqfd.c
> > > > +++ b/drivers/virt/acrn/irqfd.c
> > > > @@ -16,8 +16,6 @@
> > > >
> > > >  #include "acrn_drv.h"
> > > >
> > > > -static LIST_HEAD(acrn_irqfd_clients);
> > > > -
> > > >  /**
> > > >   * struct hsm_irqfd - Properties of HSM irqfd
> > > >   * @vm:		Associated VM pointer
> > > > --
> > > > 2.45.0
> > > >
> > > --
> > >  -----Open up your eyes, open up your mind, open up your code -------
> > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  =
\
> > > \        dave @ treblig.org |                               | In Hex =
/
> > >  \ _________________________|_____ http://www.treblig.org   |_______/
> > >
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
