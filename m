Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA86A6A00A
	for <virtualization@lists.linux-foundation.org>; Thu,  8 Feb 2024 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707376461; cv=fail; b=EQsr2kZuTs1hxpzFuZuzUJfpx26fPCAbsP8hP+99oJbAt0PZk1VY+7l4wTCI2a44C1pr1TC++mZ+A8Re/n//5QIddDw9Pzoqyz40OEqxVL4eVuFjkGYBKOSrGjy1XYK0ZS2G+WiAR4pELm+MWF702Z7pyCCPqxgKH+rXLXFuUiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707376461; c=relaxed/simple;
	bh=7hq1lurjm5V+lUutRGFWJBoONyXCrg7+3qy4/NKUllg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AMb6xoE7wJWYA/dd2naI6M+ToeiLza17azVjItpVjMkIjkAOaVv4mRpoz/Zg8/GomyovwDysekh0C/CA7wXwPRs+GaabcNvUZd0qKDnKcQ0rm3m6wc303QmpwotWzGffG4Yx2V7X/pWkzx5+vm39FpicteAkCc7c9gos64lWpIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luj9asoo; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luj9asoo"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 583D242E80
	for <virtualization@lists.linux-foundation.org>; Thu,  8 Feb 2024 07:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tB4Kmv1Pg4aF
	for <virtualization@lists.linux-foundation.org>;
	Thu,  8 Feb 2024 07:14:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 15A1842E7E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15A1842E7E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=luj9asoo
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 15A1842E7E
	for <virtualization@lists.linux-foundation.org>; Thu,  8 Feb 2024 07:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707376458; x=1738912458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7hq1lurjm5V+lUutRGFWJBoONyXCrg7+3qy4/NKUllg=;
  b=luj9asooPk6vGDCryXOLQMGdnjCo8rfceWZvVO7zyaOi9kAxpXN4rhLI
   kFiyQ+v1Ny7BYYtLHTeNe/HOTPOY4WarGkr5rYPEMvcRNJEyc6XIBE4KF
   gZFsQgsCUUWSYYMA5SUKi4qEDzHLCcHzIvxRYKAauatLZL63CO9YhsBb+
   CyjA6Tins7nF6HNdeP2Qprhw2vxgf2//GpPGBueeawHPkpHUvgHGKDJpq
   1LmMUnqhrqL5802dU/zyBG32HoESKNJ+EjwMt/yL/8wo0Z7SEaUZXC7FV
   Q17Aiojx6sL8wkxbf2hL5q48uhkUTqZUhmC1v9aQ1/Wdk1kZKvKgGi1TQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12526918"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12526918"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:14:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1812506"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 23:14:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 23:14:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 23:14:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 23:14:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9W9VF/EkawWd9eltGT8/20MXr48svT1XKcrwxy1xU3owKtzFQvWnRXUJ7+mZgDNiuHfvDJ6eUQyKMMqjtOuy62u0ILeGumvUi0sb2wRrq8FceJxcVz1i0+ta4rwBVUT07n586TWtCEgXI5cWsztrIs74VXzqIo5ftp877H+PJihHid1qidZ5X4mR9noAAeRJc+IzYW+jEtai2BUaR3CI/2KwKEo44ucY5AQtp0aFf1A9WhBDPdtPRmFBALVLJ59JrgLFFuRBGehvnNl3CbTqLtoiCSfvpQVVn3BvI+lP+ZH3DMLDmno4mt1/VsGWVlD5j4XU3jZllYZkjHxmd3wpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQgg/neCqnRhpUDU+pGjiTa0CiZ6/Pvp1L8v+J9LqVk=;
 b=aRnpJN7CjWtPQCShjXxft9+m8Fr3dasXrnp8X6w+0IvXFcS9hWmDY7CrD956SGi34e0IUqEVQv1S3nddcoTNnTJbZaRCurxiT7TBJomW+JZMEh117Cq7opLA+/Ysr+XA/eHq01WbuhKUCbo1pkce9RXc6xLtt0rnmbHNffFg3Fw437GJWQ8gP9odxQXzW9t/69i19D8Sn4VJa+K+tpCs+ChIBVy1soiur9lvauhuR2M6VCzfO8e3GT9/bR4O7BKOcMDHEWNWBl8cm15eagbWGnSe4d7qLubrF50iYpDNojNgV9LvA+/wiYdABd1MU1JYkkE3Fpizaq0pSu5ZB/clYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB7564.namprd11.prod.outlook.com (2603:10b6:510:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 07:14:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 07:14:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "ankita@nvidia.com" <ankita@nvidia.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"yishaih@nvidia.com" <yishaih@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "clg@redhat.com" <clg@redhat.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "K V P, Satyanarayana"
	<satyanarayana.k.v.p@intel.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "brett.creeley@amd.com" <brett.creeley@amd.com>,
	"horms@kernel.org" <horms@kernel.org>, "rrameshbabu@nvidia.com"
	<rrameshbabu@nvidia.com>
CC: "aniketa@nvidia.com" <aniketa@nvidia.com>, "cjia@nvidia.com"
	<cjia@nvidia.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
	"targupta@nvidia.com" <targupta@nvidia.com>, "vsethi@nvidia.com"
	<vsethi@nvidia.com>, "Currid, Andy" <acurrid@nvidia.com>,
	"apopple@nvidia.com" <apopple@nvidia.com>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "danw@nvidia.com" <danw@nvidia.com>,
	"anuaggarwal@nvidia.com" <anuaggarwal@nvidia.com>, "mochs@nvidia.com"
	<mochs@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v17 3/3] vfio/nvgrace-gpu: Add vfio pci variant module for
 grace hopper
Thread-Topic: [PATCH v17 3/3] vfio/nvgrace-gpu: Add vfio pci variant module
 for grace hopper
Thread-Index: AQHaWIdk/6Inz9VYRUqD8voDMXYJJ7D//HKw
Date: Thu, 8 Feb 2024 07:14:11 +0000
Message-ID: <BN9PR11MB527666B48A975B7F4304837C8C442@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240205230123.18981-1-ankita@nvidia.com>
 <20240205230123.18981-4-ankita@nvidia.com>
In-Reply-To: <20240205230123.18981-4-ankita@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB7564:EE_
x-ms-office365-filtering-correlation-id: 89df294f-72b6-45db-9336-08dc28758cbd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8mcSlHiOCqUDEFpbPePAiF+PP7gOU1kGjf6yLhR4crQ/7gqIuajpwzxc3YD9Q6hvxRVfZOFps6hr+nixJZqxI1pzjP25imQBVKZqYe5/M9wTIi9b8seK1NKLX3+Gz9dOVb/Hj0EgK58Nn7BMGTpuMBLFMTpNpBAu4aP8qO5+TI/zD8k5RS36amzROexi3Sz9rQLLgQI/SZCZAiDg7G9YktuYHEFgEu7msmCJ17nAgsgcckqDXfQN8DYfFYOp+fgkWqZrqkif8N1ylvBypFoh+LvU2RSYjyy1OtZNu1ABfNo6C9Ci4wzmh2DY+xp+HenUyTI5ScmW7PqzG1rWuryBYZRhYYsbFs8c029CO5DAENIsblTreHYQEQGxJ9beSkPxCP1QZZ2cPYawKDN/VfXCQBOU30Yq5jaJ/hzem7j/ytnpenfOKVFjRtzwqfmn4V7HyARSERmji3eP/DQd0zMlZp+IIvfT8Hfz8MbPy8yJc9uD/4l8IaI6OjC4UY1o5hsgj50rBPdzbK+O25QZcHjE/VBivOHctfDCfczVTBvFpTZRT0h12bgKCFc882tD4Svuj96A2tyY54mUrZWPMZIrmwmVL3Dwogr8pLuJrGBV/Uw95WUhG3k8q2C4HexcCp11
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66946007)(41300700001)(76116006)(64756008)(110136005)(7696005)(66446008)(6506007)(9686003)(71200400001)(478600001)(54906003)(66476007)(66556008)(33656002)(4326008)(8936002)(8676002)(316002)(38070700009)(122000001)(26005)(38100700002)(83380400001)(82960400001)(86362001)(5660300002)(52536014)(2906002)(921011)(7416002)(84970400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+4A+2qcnMTcxooa18v98AIz/fQnheaIwY6lblOEuvbrIR69Iw+H+dGFFXhZr?=
 =?us-ascii?Q?8j4T/Z+nNW1GpU/MrXCA5mAIsn5Phq7XPzI4d1zioIalUvTf5Iy1AnRg6gIk?=
 =?us-ascii?Q?tINm8B3uLJdtoy/JtF21qNrkl6XkiAFLvyaB/x6MkVcjwGvx8fDVRaq8WuLP?=
 =?us-ascii?Q?eacdhdOU3n0N1osrFbIN0+OD8jgN0BJ1Q9RCsRYNnVgma7cidaQvlG8JsnOq?=
 =?us-ascii?Q?nX7TEOevLHgTLV82xaV5y8K5kFGYIdEC92Srh1VdIvsGIxJ/rVqeE43lQ+y7?=
 =?us-ascii?Q?OIQ4P1UhwKcRyEx2gNIEU+omMGRxEE5jpq/S/dHZU5Gr3V0mbh42hEm0h9Cl?=
 =?us-ascii?Q?UmFAzKwXfYsqv3ny+SJWmVTxVMLA/kcYBkTVn/9c1hvabqy8zcCoucBVKgQR?=
 =?us-ascii?Q?31C9z0koIOHhIp9UV2DRJE+oOffeHbaZkD3fA9FbjGnrSQdyeUluMFCCXRuy?=
 =?us-ascii?Q?nfSxVrnBjBMrmziwXox2OeW/pAQBHYE7TOk+caYvao3Vis3nfXNhwMtZ3Xy0?=
 =?us-ascii?Q?OsW3rPm6qRfJtJ0MbaUPeckqTMw4al1mSSJZn0C7U4peqJ+KuSmRRILow7rq?=
 =?us-ascii?Q?dZlV/h2j/oRdnOraZzz8T/IS1YguLw5kdy/3s08neNpHa5w6EEtxpxJhEd0Q?=
 =?us-ascii?Q?MyOXd0OeDJSVhujPM2OesI+2vFylZ8brI6IpPA3q+023RKUrzpUriQPKFL8M?=
 =?us-ascii?Q?3Qnpq1KLapp3J1i2syP8F2fJE8seWeS5mKcuaUNyQUssgoPVBAapudNqzSRS?=
 =?us-ascii?Q?DYOc0oTvGhBKQoNDflTLI9BI9VR4gO7kXeIbvmaqAIKKyhFGKYjYPyNXBwh3?=
 =?us-ascii?Q?VI0mQTA0sjvaqdXHlTO7QsNGvY6ZLSMgjKaznm4Jm9PRN4ykutw5J4QrGYpt?=
 =?us-ascii?Q?pQEi6yCS+S152ouczPdMwyAGQLLkvJVFyn1zegwqsW0ElqzX7c+CPIXjfEDP?=
 =?us-ascii?Q?xvBEYCqJc7iRmzXhz/W+rHAVsuXcVH4R4hfTcy6AhSOrfa4S3L6m0zP8Ne6i?=
 =?us-ascii?Q?CU+H0VUvyqqxUfdZYoVi0o3difQsQ6NV1vR8rUyY5WadE7rJ3epWzG8FFOCz?=
 =?us-ascii?Q?F1wDv8AoMRmG94eZS9PrJR8W63G7zVJ1GfhFCnCYXtLw7fa6Xss0iUvsh/nu?=
 =?us-ascii?Q?XcxJW5sRECHvKxjXD40a7pgGq7a2oCVRKzWqBP/3y590R+OKq7fjUBazbyyn?=
 =?us-ascii?Q?qgSKGuxTjOeXyd2FyGmCULyVC8PIi1UUS2GdoqKPGa2B677mi0KLgzNOOcWh?=
 =?us-ascii?Q?NAgljeH+ehnWOLZjfKh56N3s0mELm7Is3S/B5bds78xSBY0t7hRypcEljp07?=
 =?us-ascii?Q?ZSKUcEfY9ZHETNKoVWmmoq0K7MfhCgm1eoxDRe0IjdYd5HiwTOkUNEW1/3gr?=
 =?us-ascii?Q?jSBFHTIjnvqk1awblRMno/Hr7XRCQzuNPC6bOAjtSHKo6BLslgr5WQ9Zjkpj?=
 =?us-ascii?Q?c0x7qXX0J7GAV4EAXo3CZtxLeGX45/j3gju1lsYpSoE4jDvA3lbsq1tCD8sF?=
 =?us-ascii?Q?+6ulqJrj4mjg66xIyhBzLWM0sT0Je3OazSIU/JOBz+YhS857+E+GG1AjJnwu?=
 =?us-ascii?Q?NR6fdqAbiBk8jd0aoBWDPBps0Ku1erAXMk60FEeF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89df294f-72b6-45db-9336-08dc28758cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 07:14:11.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddkwsDqNgQ1XKyOGg5T9DyQmlwD6BhBwkKImeWcywv3ELBMzbCLG4Thlq8PtVmZ+0ZnRhgOK6E+ctWetxU3JYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7564
X-OriginatorOrg: intel.com

> From: ankita@nvidia.com <ankita@nvidia.com>
> Sent: Tuesday, February 6, 2024 7:01 AM
>=20
> Note that the usemem memory is added by the VM Nvidia device driver [5]
> to the VM kernel as memblocks. Hence make the usable memory size
> memblock
> aligned.

Is memblock size defined in spec or purely a guest implementation choice?

>=20
> If the bare metal properties are not present, the driver registers the
> vfio-pci-core function pointers.

so if qemu doesn't generate such property the variant driver running
inside guest will always go to use core functions and guest vfio userspace
will observe both resmem and usemem bars. But then there is nothing
in field to prohibit mapping resmem bar as cacheable.

should this driver check the presence of either ACPI property or=20
resmem/usemem bars to enable variant function pointers?

> +config NVGRACE_GPU_VFIO_PCI
> +	tristate "VFIO support for the GPU in the NVIDIA Grace Hopper
> Superchip"
> +	depends on ARM64 || (COMPILE_TEST && 64BIT)
> +	select VFIO_PCI_CORE
> +	help
> +	  VFIO support for the GPU in the NVIDIA Grace Hopper Superchip is
> +	  required to assign the GPU device using KVM/qemu/etc.

"assign the GPU device to userspace"

> +
> +/* Memory size expected as non cached and reserved by the VM driver */
> +#define RESMEM_SIZE 0x40000000
> +#define MEMBLK_SIZE 0x20000000

also add a comment for MEMBLK_SIZE

> +
> +struct nvgrace_gpu_vfio_pci_core_device {

will nvgrace refer to a non-gpu device? if not probably all prefixes with
'nvgrace_gpu' can be simplified to 'nvgrace'.

btw following other variant drivers 'vfio' can be removed too.

> +
> +/*
> + * Both the usable (usemem) and the reserved (resmem) device memory
> region
> + * are exposed as a 64b fake BARs in the VM. These fake BARs must respon=
d

s/VM/device/

> + * to the accesses on their respective PCI config space offsets.
> + *
> + * resmem BAR owns PCI_BASE_ADDRESS_2 & PCI_BASE_ADDRESS_3.
> + * usemem BAR owns PCI_BASE_ADDRESS_4 & PCI_BASE_ADDRESS_5.
> + */
> +static ssize_t
> +nvgrace_gpu_read_config_emu(struct vfio_device *core_vdev,
> +			    char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct nvgrace_gpu_vfio_pci_core_device *nvdev =3D
> +		container_of(core_vdev, struct
> nvgrace_gpu_vfio_pci_core_device,
> +			     core_device.vdev);
> +	struct mem_region *memregion =3D NULL;
> +	u64 pos =3D *ppos & VFIO_PCI_OFFSET_MASK;
> +	__le64 val64;
> +	size_t register_offset;
> +	loff_t copy_offset;
> +	size_t copy_count;
> +	int ret;
> +
> +	ret =3D vfio_pci_core_read(core_vdev, buf, count, ppos);
> +	if (ret < 0)
> +		return ret;

here if core_read succeeds *ppos has been updated...

> +
> +	if (vfio_pci_core_range_intersect_range(pos, count,
> PCI_BASE_ADDRESS_2,
> +						sizeof(val64),
> +						&copy_offset, &copy_count,
> +						&register_offset))
> +		memregion =3D
> nvgrace_gpu_memregion(RESMEM_REGION_INDEX, nvdev);
> +	else if (vfio_pci_core_range_intersect_range(pos, count,
> +						     PCI_BASE_ADDRESS_4,
> +						     sizeof(val64),
> +						     &copy_offset,
> &copy_count,
> +						     &register_offset))
> +		memregion =3D
> nvgrace_gpu_memregion(USEMEM_REGION_INDEX, nvdev);
> +
> +	if (memregion) {
> +		val64 =3D nvgrace_gpu_get_read_value(memregion->bar_size,
> +
> PCI_BASE_ADDRESS_MEM_TYPE_64 |
> +
> PCI_BASE_ADDRESS_MEM_PREFETCH,
> +						   memregion->bar_val);
> +		if (copy_to_user(buf + copy_offset,
> +				 (void *)&val64 + register_offset, copy_count))
> +			return -EFAULT;

...but here it's not adjusted back upon error.

> +
> +/*
> + * Read the data from the device memory (mapped either through ioremap
> + * or memremap) into the user buffer.
> + */
> +static int
> +nvgrace_gpu_map_and_read(struct nvgrace_gpu_vfio_pci_core_device
> *nvdev,
> +			 char __user *buf, size_t mem_count, loff_t *ppos)
> +{
> +	unsigned int index =3D VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +	u64 offset =3D *ppos & VFIO_PCI_OFFSET_MASK;
> +	int ret;
> +
> +	/*
> +	 * Handle read on the BAR regions. Map to the target device memory
> +	 * physical address and copy to the request read buffer.
> +	 */

duplicate with the earlier comment for the function.=20

> +/*
> + * Read count bytes from the device memory at an offset. The actual devi=
ce
> + * memory size (available) may not be a power-of-2. So the driver fakes
> + * the size to a power-of-2 (reported) when exposing to a user space dri=
ver.
> + *
> + * Reads extending beyond the reported size are truncated; reads startin=
g
> + * beyond the reported size generate -EINVAL; reads extending beyond the
> + * actual device size is filled with ~0.

slightly clearer to order the description: read starting beyond reported
size, then read extending beyond device size, and read extending beyond
reported size.

> +static int
> +nvgrace_gpu_init_nvdev_struct(struct pci_dev *pdev,
> +			      struct nvgrace_gpu_vfio_pci_core_device *nvdev,
> +			      u64 memphys, u64 memlength)
> +{
> +	int ret =3D 0;
> +
> +	/*
> +	 * The VM GPU device driver needs a non-cacheable region to
> support
> +	 * the MIG feature. Since the device memory is mapped as NORMAL
> cached,
> +	 * carve out a region from the end with a different NORMAL_NC
> +	 * property (called as reserved memory and represented as resmem).
> This
> +	 * region then is exposed as a 64b BAR (region 2 and 3) to the VM,
> while
> +	 * exposing the rest (termed as usable memory and represented
> using usemem)
> +	 * as cacheable 64b BAR (region 4 and 5).
> +	 *
> +	 *               devmem (memlength)
> +	 * |-------------------------------------------------|
> +	 * |                                           |
> +	 * usemem.phys/memphys                         resmem.phys

there is no usemem.phys and resmem.phys

> +	 */
> +	nvdev->usemem.memphys =3D memphys;
> +
> +	/*
> +	 * The device memory exposed to the VM is added to the kernel by
> the
> +	 * VM driver module in chunks of memory block size. Only the usable
> +	 * memory (usemem) is added to the kernel for usage by the VM
> +	 * workloads. Make the usable memory size memblock aligned.
> +	 */

If memblock size is defined by hw spec then say so.

otherwise this sounds a broken contract if it's a guest-decided value.

> +	if (check_sub_overflow(memlength, RESMEM_SIZE,
> +			       &nvdev->usemem.memlength)) {
> +		ret =3D -EOVERFLOW;
> +		goto done;
> +	}

does resmem require 1G-aligned?

if usemem.memlength becomes 0 then should return error too.
