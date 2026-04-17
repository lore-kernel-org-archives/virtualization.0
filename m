Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96FA282F23
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403006; cv=fail; b=C3zRdhTwZOwA5lTCVLDq0dj0km3zKjLWTHyR84UP5L2mf9lCeKhpLHlFGt0uIG/VKBo2EOQhmrR8F/G+I+mdxIZk6btCWRwEqCTYDIIn+rTV08JfoDlL2HIYm2rTo3dNp/5l2HzXxA0tNUgDzgkYet2hP2bCwO5uAqL8be/zy+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403006; c=relaxed/simple;
	bh=svH0Ml1Uf05t1hZ/QJTBoJ17qNkYZffrUVen+EzIW9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hzZfFG8EOD8LYUemXhYhRMDXaxM+/vt9t1h3U3R85TIToLt8QDAt23sM2SzywgPGM182YOSjz3QBf7wls8WVtYt38Ys23A3BFsKlnBI5nsTGwwNb3BruSipjduE5YhT8e/nduMQ+tt0E3y80ZfRFZ9+/IqewWFmYmHoBstSkqj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGLIXW3z; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGLIXW3z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776403005; x=1807939005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=svH0Ml1Uf05t1hZ/QJTBoJ17qNkYZffrUVen+EzIW9w=;
  b=mGLIXW3z1IlnSLEHa7MSWF6PZwZL3C6JzRFTLJC9rg1guThsVIA+hWto
   uwRj1FzXkix8jXCJGmxLdPaHxYfQf2ifObncqicaufd6WJ3FJKLZa/+x/
   9U07QsRU9UwyB/fnbrlyItUFKiHnTzPiCPtHYDRN0B0ug48lvpApmIDB8
   zWUbTuaJ0Ixf+SHTA19KXdPX5fhl3Tq0d2bbLs3xUiQ9lLcs9KOtC+1mR
   lGfi8DVobBailqzQ4POW3ge8FdkecknAOUKWbBdVfoxLRxyTwcXktVOIF
   5cgj30U1c8DPk4aBTE0St1rCzfyLdQ7RZaFJcVEOlo8dzaCiNiC5l8vdS
   g==;
X-CSE-ConnectionGUID: 4uad9+avQBqaTYnb2bKXCQ==
X-CSE-MsgGUID: KZ0woqTTSNiX8Pwb6pMkkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77290331"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="77290331"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 22:16:44 -0700
X-CSE-ConnectionGUID: 25cI20RxSCmVS3w7jChEBA==
X-CSE-MsgGUID: KVxDJpSaTtK1hJHajQ95Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="230081101"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 22:16:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 22:16:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 22:16:43 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 22:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI/100yoH02i9MLQ4VamKOqDlG6Ky7id/CvwnkIjmwXXScyMZtUta8m0JEYjeTjZwBo2/wXKnMqk60NHBbOh75cnryI2bPnYC6gmPVmVowifPciMU8+6w3HaRv/SwDyB5p9nADDWfSOO2C4MxeN9RBbWHlyHWI2T3cuFgSc5kJ0/TiDkaVGW24a9qOj7hPMWlveUbcZm5H6m59uvlJECV86yQYOU6zjZUKeJyvnGDBeGqP+CNEGeCZLRSQ9Ik2tyKfm2Cw1vHRWaKc3583la/VRHtV2uMzTaClPTMj+pIT4ySKvkdcLbog8JooDF/yPcIN0wueOBBOsf+cVEBoNTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6nqWbs7tmo3Qui1ggJtImF3gHa9AJK0fswOfRAqrsw=;
 b=Bnpxz7c0O1nMs3/y7316A8VvNmzkRJHwtORQNvRXT8gEqvQO+ZYUnB79ZYi1thBqglkSDZ+P2SZBwJfHq+CWbxCgInAQ0K+tKGtZ97rG4jjImawgZdH7gHJJDOnhOS/WIxt7UCS3Xl+CxgkeOlE2L3kK2+M06qhzTdtnYKvNwb5mB3fV07myO5llvLRihrUG+xiMs2uhdm/Oas6IYaf3azqx463DpgdmwXsISvZ+tFy/TzFVzoHS7uQbzSTgkSEa/UYxBqclZ0Ki2pZ9h3Z8zDvKrWzCW6NcOQ/Ac4MJtemmwTokvoO8tvXVBM4XxMt2I8K6WL+Z+PtaL3fj1iOX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB9635.namprd11.prod.outlook.com (2603:10b6:806:4dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 05:16:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 05:16:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex@shazbot.org>, Matt Evans <mattev@meta.com>
CC: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Yishai
 Hadas" <yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>, Kees Cook <kees@kernel.org>,
	Zhi Wang <zhiw@nvidia.com>, Peter Xu <peterx@redhat.com>, "Alexey
 Kardashevskiy" <aik@ozlabs.ru>, Eric Auger <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
Subject: RE: [PATCH 1/2] vfio/pci: Set up VFIO barmap before creating a DMABUF
Thread-Topic: [PATCH 1/2] vfio/pci: Set up VFIO barmap before creating a
 DMABUF
Thread-Index: AQHczQPnp4ApdEXRY0eMmwv7SPHfRLXiSwcAgABtE4A=
Date: Fri, 17 Apr 2026 05:16:40 +0000
Message-ID: <BN9PR11MB52768421EA5D79C469B899C18C202@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260415181423.1008458-1-mattev@meta.com>
 <20260416164406.7fb3bb0b@shazbot.org>
In-Reply-To: <20260416164406.7fb3bb0b@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB9635:EE_
x-ms-office365-filtering-correlation-id: 6fd594d0-c291-4654-aebe-08de9c408247
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: Ye3fZIdNiw0McTGT0WCIjiDtRLG7whGI/rmp5Zr3P23meUFAoqVp4srgYWxpvY4at3R3PFh4k0qWVitqiIwFjiTm3o+5MvHcbCq0q5IfNdLeJmAfrpg+oTHu5EdZ66TlXFfsGc5F8bPE/GV1RwYcD4+ZbcnaCFaOT6f79nmdbAzN5NbO35dmM9hN9XMR6D5bhR7IlQvdAMFzmD9/yJ/McDriMpttuqlxfjpY/KQoH30mAMjRUVIfuRPskJUzu3JrFk9X5X0nS9z4lZ83tJpTo4Az+eufT527yJNRkzCuVskuTCP3UZ+y8oXtpMBgmKTojgW9uTPr7cXuhLkH27X/Use/SSxRg6fg6oc/cSAGqlbtQ9rwZnWH6Uh77BOY5bUCq/Xg/y4xD/pGPq6s9g/4Bf61KwFMW3F90d8WRkkXVoWzzoHo3AMxd8qxxzDY/j06elCJ1uGocKs0oj07IHRJk0xHYeDA0KyTGY3N+UOcMI0S/1amm2wGB1MfV4WX355opRl4iRzvb8+1jz0wRe2dKoPwdzstWNNum1betTaOZ5pK140EJa8Fg2jo9+IZkwqNrAdmBydvYTeJHhdGp9n7t3XQwExWqll8FpyV6qyD7Nv4dx//W6zusfLYkUHCUCqXqROl2c1ITS2lCIBYHY4g6JEHuXPvSBpuixONdzbM1vUaQ2taJ6DJkuD8wfrszBo+tclVq8tJweiFJukeoEg364p6xwS1xW1FZMxSNQ4CqL5eJ1MJE6s7aPv+7y0HB+MxWF9pteRcYnoVRkCdW7hou/CUG5FHqAWIXxQuXfmlUGw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YnyPhHDyn9P++h/60wrLr3lBg9PkiIUmM1JLmAbZDoMVO+uaBTNHhCOHGdZZ?=
 =?us-ascii?Q?8VnlVTk2Lc8dtpe1AlKp263R5jhyRsxUmowVZLQ543POwK/UJN6qXGMlbPNt?=
 =?us-ascii?Q?Gl9G6L41TQe6ZFthYsphOfZr5qgxdNWAWC6Mepi+XXWCgVa3nd9AKIvsJIEx?=
 =?us-ascii?Q?iYg3YiDLmvunpcg959h7Wh9ijyiz9If1qxwF5x52XLVy8htjXbDLkoxg7O9/?=
 =?us-ascii?Q?Vsh0Ony8S8EKTPYD7staVvkYU8npxFO0AczWuZs0bSvrCMr6omKzoO10DaGr?=
 =?us-ascii?Q?yjbZOJYUcCP/smwpOYky5siWMAKxxgR8/IKKF33pAnsx8PTjea2VMoMu287d?=
 =?us-ascii?Q?VrGPJmf+dicOqrnRHHAR3PVdmYfUXzElkIZujmB02usgsyrkGlQ7M5GxW+VZ?=
 =?us-ascii?Q?2aZQ0BIuOajM5qzR7pSaqzY5Ma68e0VxQTjF3XF+kKSPlhMsyi7PZH+ckQGz?=
 =?us-ascii?Q?IUtJemweB9pNkqbswOO9sLD0c3nUi3rlMBBKiaZBxC8BAF1Ky7vOHJWsl0TX?=
 =?us-ascii?Q?UbTLMqwscH/py/sIPdKaEdACUdlFxIMULqYzsQdBS9hRxs6Yjc1I7ZobR0T+?=
 =?us-ascii?Q?TjIeTwHO6KMWGbse78IO2kk84fmpKxsJsrBaYGhZcjgtmM/HxyS5WHxf68ra?=
 =?us-ascii?Q?CyH5U4kSHHJaqJFfpvNz2ssGG8tGSvszHzwI1F0onDS4ijLlVbDaolpmXXpd?=
 =?us-ascii?Q?4x+flPI6azBfnZbhmaJ75rGxTjh5PiIOJVnauRQQy/uxzkZHzP3DNWEQNmee?=
 =?us-ascii?Q?PilNoTkT618eCn1n2e91I9P0wVen3hS+iYmMVm9Avh859GjiSxGKcNr25Tot?=
 =?us-ascii?Q?lMvqRTsecKZj1kDroICh8TQAY2U8IdFprYcpLJzs+kpFlNWvlMKYbdRnazZS?=
 =?us-ascii?Q?4cpbgrqcRjzJYvaHRhmLDhQ+T+zgDO77NB2eaZfbiywE9veLchCtT2Eq2MK7?=
 =?us-ascii?Q?VJ+fRnlmXAI3lk/Ki7wI9p5gA3I/3VAVqBHA6Ce2mVjIr13oXrqiXHaChlS0?=
 =?us-ascii?Q?PTG5/POaObAGM85IG0GpFDWhrX9LccTQpHMKJ37nOQ4xzPyB5B21HUaR8Bdg?=
 =?us-ascii?Q?58vyM0WKxRrQv6eDpatrxAanzr+56s2OIOE8GZ3NoYTNQ7X+J4PXXxSgBFhK?=
 =?us-ascii?Q?yifbi5ZL0I58Po42dvyWEnXQGLeDpqVc5wZIOTOoXCYOOiVF7unlK6aaQf0Q?=
 =?us-ascii?Q?TF8ZkkFXbzdUqK6qrkSxW/RC2ucwD/zQ5Qbb1+1ZpNxZAdN/os9pi04mMAyB?=
 =?us-ascii?Q?DcrCfO3US7a1c0i9+B1lo+IPIGmSbBTh7BgqBxtjX1W0ARSC2SNq2z1k0v+n?=
 =?us-ascii?Q?l8XQCp6QbyKFULhFW8GSR1Hiz9qf8CVnHyArUzMzX253yItDRfJSDyushcau?=
 =?us-ascii?Q?Yb6vUUeeA0CcQCohR7yP8XkrUTvEj2xZ+3LYgO0WG14v5QX4+YXkGN4mXIjH?=
 =?us-ascii?Q?CwazlYs1YEzBYLPpful9b5Qvx7nmHE0XU1SMQIqK7iJOtqWk/p+iuq+oJku+?=
 =?us-ascii?Q?2/UuRDQ04/bq8U4yRy+THW/zdd0YMqC8SqfNkREDvejYFaPJEZSxtAAz2yxV?=
 =?us-ascii?Q?PeI7EY1mxva9S8sKnVAkf2yYPo/+3QSkoXRZlrfvbeM56bNQcdj85lG7g4Ho?=
 =?us-ascii?Q?2AJnX4VMsbM7jFVyykLg5AUGzHsfFsHVogB6xQeueaEmUudvPj+orLUyHr7X?=
 =?us-ascii?Q?iwJ0kiIi6wAg3S4msYsCf1UaTUdEC7krE5mpe/VOfyGNdppE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bwftYvtVA6pX7+89FkK3Pegzrdiznpsgo/aXWXcG4ri254UPqzzeKc+mCH3qxafFwMdW3AAIxhaeBZ8CCOVhRGHHVSZqevvMCWkQ5lTUOaNp03S21aMdlysgDNZXWh1pHrG2aB9Fxm6dytGyaWAU4iZEsYMsyXLaqGe4/07YxdCMkII0YHz9APwJqB1ztDHjWgxKR0HVRK1D8zzM/8GLOfs84GfEFp5/KIErcDdzYthv67ajA7Zrkp+NfI0mx7EpyojRTucZfY9E+0Nmi2Ef6ec9uwR8flGaIBy/3ukfgkp7BKPhIIusJSOn4zanEAgFoLW/uygw1Zomqp6VZdy2jw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd594d0-c291-4654-aebe-08de9c408247
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 05:16:41.0527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80t89prVpsSOgsVsHL+dOT1/s6aMG+C0wQR5rz6u1rIjqK6+mb+h0G/rNrs0dxu3dsYmrdmDyUSQZUb7vFuj5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9635
X-OriginatorOrg: intel.com

> From: Alex Williamson <alex@shazbot.org>
> Sent: Friday, April 17, 2026 6:44 AM
>=20
> On Wed, 15 Apr 2026 11:14:22 -0700
> Matt Evans <mattev@meta.com> wrote:
>=20
> > A DMABUF exports access to BAR resources which need to be requested
> > before the DMABUF is handed out.  Usually the resources are requested
> > when setting up the barmap when the VFIO device fd is mmap()ed, but
> > there's no guarantee that's done before a DMABUF is created.
> >
> > Set up the barmap (and so request resources) in the DMABUF-creation
> > path.
> >
> > Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO
> regions")
> > Signed-off-by: Matt Evans <mattev@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c
> b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 4ccaf3531e02..fefe7cf4256b 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -272,6 +272,15 @@ int vfio_pci_core_feature_dma_buf(struct
> vfio_pci_core_device *vdev, u32 flags,
> >  		goto err_free_priv;
> >  	}
> >
> > +	/*
> > +	 * See comment in vfio_pci_core_mmap(); ensure PCI regions
> > +	 * were requested before returning DMABUFs that reference
> > +	 * them.  Barmap setup does this:
> > +	 */
> > +	ret =3D vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index);
> > +	if (ret)
> > +		goto err_free_phys;
> > +
> >  	priv->vdev =3D vdev;
> >  	priv->nr_ranges =3D get_dma_buf.nr_ranges;
> >  	priv->size =3D length;
>=20
> Wouldn't this get a lot easier if we just setup all the barmaps in
> vfio_pci_core_enable(), conditional on pci_resource_len() just like we
> use to filter in REGION_INFO?
>=20
> I don't recall if there's some reason we've avoid this so far, maybe
> others can shout it out if they do.

I don't remember too. probably just because it's not a wide requirement
then was made in this on-demand approach...

>=20
> We already tear them all down in vfio_pci_core_disable().  It would be
> a small patch to add that, which we would mark as Fixes:, then a small
> follow-up on top of that that removes any then redundant or unnecessary
> callers (all of them).  Thoughts?  Thanks,
>=20

Agree. then the next patch fixing the racing conditions is also not require=
d.
