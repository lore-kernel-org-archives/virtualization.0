Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83C1922E9
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574566; cv=fail; b=t+9LaHuTlYxgK6mdQXz4wzU3TDIe6ZguF6Dra3V+JqXpqkqB4Evr+mcpGn7WgeHL7uwoMIky+ylji+R89YOv9l9EuuvUoUFKS1eiwo24lxjQymNojSjqTvhEyF6ap3Z1p7/cNJY28doSmBaOPPIdgbQZ3+/uAeqPmOa796AEIy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574566; c=relaxed/simple;
	bh=gommmyIJzXyAf9MIKR9LmBgRu7wo7UDJukjbe2JqwPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WlUT8nZv4wN60cNSek1WPtbcPhqdcjdV+J6fgBdHDOH1i9+p1vMvT1zKAh2Rt8+7AZKsC1bB+vW2H6qnrMU4yoVGcd6AphqV5Z+dJo8by+2fWu22hj+kzRiBKgQmb9HKG5uaG20XZYUQyiK6BA5VaWpkRGZxv1gqPbmTfnzfID4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLp/zHwd; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLp/zHwd"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB1D2409EF
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 08:02:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FlVsU8eOfz2k for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 08:02:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 81A36409E2
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81A36409E2
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lLp/zHwd
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81A36409E2
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 08:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717574564; x=1749110564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gommmyIJzXyAf9MIKR9LmBgRu7wo7UDJukjbe2JqwPY=;
  b=lLp/zHwddKKdtq5Kr6zUBXxp5KUiJ7PHC7EiARKRTcLQKNcA311mhAt4
   ycwcbZX9U7GQLNwiYrJE3xjhmVo3uCYeuzrMCyFdr2KOfQqC2ZkiS/bEq
   A4tgSStxQSVVd1h5dsLSV+3+MWmhcTYY/dGQOzBZ2ST6L9n5kqlVuchOW
   GZ1ZfWmNf4ZG769MaSP8yeEVWI6zOJNHqW0zfinjNEdi2RfFHObJJYX6P
   E1T9t2Wta0lSjWs/XfvRVj0HeDzaus+5yiZGKVbIIXPZkl+sjT1AJ8XDl
   FTSTcv9JQzrOPxTuFfS/B2+UPzPKht24X+jiquW7LqbK7+OMAcwGQ5SVU
   w==;
X-CSE-ConnectionGUID: 0cVjHwEwQmm3v/+YcIhnew==
X-CSE-MsgGUID: D1MCemyjSKuVLF8kxwoOGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24736177"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="24736177"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 01:02:41 -0700
X-CSE-ConnectionGUID: LPCApI+HQn+YpMOcGiXRBw==
X-CSE-MsgGUID: 1438WqLESFW7hf5Rm9ZLkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="68648157"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 01:02:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 01:02:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 01:02:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 01:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ocp3joiqTbKgNMMbb7W5CPUV7TphzJUYdmBT9y3RDiotiN5CLB4qSQ9OgyS6O8CUegoYlAbtxiXz8r8ETATbrMtEjJaP7Ab85iIhrC/SpARiN0d3JnCrJh/83cQIxlCm0M1Ji4lBNW57q7Xtd4yZ+0Jz7bqRW1gvBcYkqiGXo5r0BNM6IlhJTCqWI8+zPk/cjD3dnqaWZ1J477Ar2xR8VcJ1DycPVuenKVjEMU4FkaXjVmtGlh0qt2zOOO+cgvw68Dd3ONJojCjeQFfFAHEAqjm6EqKdZHmKpwoVcFE2FUcy9DrhaCGhdOn//FHultaznyt/kCTdDiU4b44gkJIljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL4oG0faqkyP/I915+YkPD6LjgPLl4Yny4Jlm4xb63w=;
 b=gp+U5SKl+R7TZy1z6aHBEdQYiS/LsNhoqfY2RHL5B1FgyZxm2CMCDbUUvOrhR47Nij9wvH3ZwkrKCJ24TkpoYDXQUT1OZVW+bk96hQIkd9hUkmLKY+W32E5NWLiU7mpORzZAOhYInWbGlBGpNAMRlPp9QOfG3weBKoD4Sv1vDjueyu9r17Q0Ip7zT3rr7B2J7kE98xtw+BPkLCcLi7x27YDrkH56PC3z3mD5ka6KQvGUSUdOgpBOEFhlvWIPhb5h7POdGE/FEWcKc+xtExh5AAuTwSSElXIfrQK6eqr/EldeMdcfLSciGgl2m58dG34m0ApjXHcfZDlhzsanHGJtLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7548.namprd11.prod.outlook.com (2603:10b6:a03:4cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 08:02:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:02:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v6 01/10] iommu: Introduce domain attachment handle
Thread-Topic: [PATCH v6 01/10] iommu: Introduce domain attachment handle
Thread-Index: AQHar+toIpQ65UR7IECz6QN4BL8xubG42OXg
Date: Wed, 5 Jun 2024 08:02:38 +0000
Message-ID: <BN9PR11MB52767B3B1F441D9AA656AC258CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240527040517.38561-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7548:EE_
x-ms-office365-filtering-correlation-id: d9282bd4-6fcc-434c-b3e0-08dc8535de0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?9xB1Jxqi0+9GT690bMjhnBOiPXHPdDQZp1vH0uojhyCzuyWyeH3kbzzTlmls?=
 =?us-ascii?Q?CE5dCAlPenmKXtmI7y6LN55wJ37OA4o3PZ1Lofc08DcjUHjmUI1u+yfRCf0/?=
 =?us-ascii?Q?8559tnbOWD9ShTUS9NGUT9GIPmeGpxfyj/e10gFu7oNoyK6ZcyinvdpKo1IX?=
 =?us-ascii?Q?DpO2yqR8u4tmFAIcVrIN+2eCgyCzDCRb9xyYECWrq/8it3sJBRcdG0eLLVhJ?=
 =?us-ascii?Q?avTFIABbNMBBqZtv5+zNefXuqzCg9ebUE5ODRjUxnmmvSOEklUXOmnFA7szp?=
 =?us-ascii?Q?rDWXV29nKQyI1CsUxcnkTm/EqDyLhKUuomipj31gfuPlHjFlc7F1tPBPM9WF?=
 =?us-ascii?Q?9ZgMeYpU92h3Npd22bu5PVz4XbX+qf4aFZYQvI7TrDMbMP8yfYwqQvi+z5AE?=
 =?us-ascii?Q?YVmEn8mRlRPhEjDNrQuYu9KGm1m0C5xDZpVYCljWq+XpMSbaiQjps22f3bHH?=
 =?us-ascii?Q?ixlirC4sAVubWtUPLFUE6wJiArLczfUXjwVYXbik0vJfJlbx8s2vlJu6vFfV?=
 =?us-ascii?Q?NZVimCughHRhGmx+uZU/Vss8e+BxbVnycQuIMlhDXuw9TDCqG17ov4xrt+yF?=
 =?us-ascii?Q?5vMFeIbl1D/SoKtnOyq9OMTCytGSUu48Ant9hiJBlYXBttM6l/1Ja6/hSufP?=
 =?us-ascii?Q?dW7NPV5Az3c2VNhD0VuQzx06/88rf4eP1FHhkXvP8xyiv+4p/55wNsuY3/LS?=
 =?us-ascii?Q?4WguPfDXyjVIqpVEQrWU2+CuMHwv8WBXKwap0bPo6AV/atVI4GdCxnI5QBst?=
 =?us-ascii?Q?hTING7m4X0Lw0JMCQwVKnqisCbVh94voCJy31CouE4qc2QBnOlB90K5k2fuJ?=
 =?us-ascii?Q?LVSvGQGvEAmoX2Sl0PDwv/TSq6x14JVG99ZWxWPOstMhqYlnSrIMH3v9LdIV?=
 =?us-ascii?Q?NGeswU1IvLQprQGIwzUGpMUjIoSuBvi4+OieBQ0L4avIgeT/ioSNjy8Zxc9K?=
 =?us-ascii?Q?i115+Ax6v6XppRKk8zz7KX7NEdJx114kK0NcWqiU++SH7tcJv5vU4Ptf1hJM?=
 =?us-ascii?Q?JASVKSPZQE5hVt3QS8BNjvS1aeb3hl8ZYGIZQUw6VsCgclxImOMtK+gsaLCx?=
 =?us-ascii?Q?5w9eYaEllPFqaPvChoxDRv1U1FVCttTEqHDe+Yf/wmNfW5oMOuLabF2ZZG+2?=
 =?us-ascii?Q?FcsScsOo1JALqipJyHmcBN7Zm2MIAH3xo/Z2amshU17WHJm8+DWkifTS9t6g?=
 =?us-ascii?Q?NYDSDrhP1Axv2MkKAqrsvmJqfiikOVo8bjQp+7rkybCpy8dhDFXtvldYIVlN?=
 =?us-ascii?Q?wpSEjdFrNXLltfXDKTWVX4t+kaZOzfivn5z868L0us6BUmWRZtOUZ1rcgM8t?=
 =?us-ascii?Q?PD5wXCselJLGjfJiPr2YJhzCmK5Vqb09Ruve5CiK/T2kN7wd7SY8+CyC9GpG?=
 =?us-ascii?Q?F0iebfU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tRlRYEV6+590rdYmP7n3zRWIj46tsyDBNQKi2TSQ74ByQkY6xBNXdToXMWVB?=
 =?us-ascii?Q?onGo2HJTN9tyquvYyYV6LRKrFhfyRneAzf8USOzUrhpT+3zJmiwb0AI0l1O1?=
 =?us-ascii?Q?DN0Kw9aELV70qhufYDvpoCAZxFFSTeXJ1THFuIDEw4la3/j2vo414iBPF1nC?=
 =?us-ascii?Q?GEsQgYSHX8U/a70Cxevc5eYTmaE/c0oBi7/Dfs8oCLjpV3GSl03B+Id4L/UN?=
 =?us-ascii?Q?uAhoMVTr6G/oY1pMAWbrci169UfBNq9KDKyNum0KbGQ5UTGVLkk4ocg2Fm+T?=
 =?us-ascii?Q?7Au7WBLGqbaQRqNlnu0xPDCdg4d7wgEx2fWxuGf4oKlwJHwgmZPmM4Z1E35W?=
 =?us-ascii?Q?tEBca7WlU3PfGSPY2gJVcbFMz8bIX9hZeLvyhKwasJpGNr6lE3wDBjOU6LzB?=
 =?us-ascii?Q?0iFMd1Sq5d2iAFKEteAfEDaGsSvziW4ANYN2Sd/E81Fq3kqVqkCXmyCWRODZ?=
 =?us-ascii?Q?c4gk0ZiqQDpBp0XbIYIhJkPRpnN7UxzD5KQ9uw8oy3rV4KEV8abdSX51zp4p?=
 =?us-ascii?Q?KorUe4K9tQvDLO8XExyz5u6YWjVJM3Mq1iDA0GZf6hMPXxias9Xn+FcCXgrh?=
 =?us-ascii?Q?YjIezxvCYyrww4BCoBBC3yM4BzE0Gs4+tRk9ynW5GSoAHsm1xKkfzyjGxwb6?=
 =?us-ascii?Q?Cwj9xqLAsi3KZbbYLit55mA2pVg8aJQ4Gpx9qbz4VYt809VWcOjBrIr06qB0?=
 =?us-ascii?Q?cza7f/0E8P5VbG2DKP4eK7+bGw0mqQqiTDsLy0gKWkXgHZlLAANcyht2kizd?=
 =?us-ascii?Q?4fhPvb5eN1H5r/ZqEFwix9M/aDcz8CRQ3IUq4nRdsDaoagk1UHPoWJGiJRum?=
 =?us-ascii?Q?IKSArRwMKU0yf5cSmpTSkseHfiisgRWHBT5xn4KuWL33ZCjs1S7KLJW6XFfo?=
 =?us-ascii?Q?VXztFlw0uhhWtNG1kTGtRWXRHt088iOMHMLdlPMJPktEh9cgIImEB5EGhLhT?=
 =?us-ascii?Q?cOtJUSYHMu1vNII2VWgANuRnv1rjxCb/Ayvh3KpjWtnZixuvKtkz8jB771r9?=
 =?us-ascii?Q?hT2gQtwwsT6pZeXfEm2ONJwr1ma8vWcJq9FDj+t2COIf3Bw6OcHSSl6qnnXM?=
 =?us-ascii?Q?5hxeO+kVbZ7hjwqNK2G/EnITh+7QLIfaoPFnogK0Q1IpG+onKJXTeXdLNKp3?=
 =?us-ascii?Q?XyzYCIn6DTbKynoh77MMqsRWedGque+eZ/0++CBp4EUlsZDwaGSs2d8AWmdy?=
 =?us-ascii?Q?lginxzciScJy75rfL1snr/83hlPBtbLFPUS8UAY4Cc/nYrrW4eO3o3tiaBhG?=
 =?us-ascii?Q?WK/8XOL6vJgMQDNRGEvAmQeLDIu3pdA0SRaSJf/dwEq79IsEa+osLHsoC5BT?=
 =?us-ascii?Q?MjEU/urOqmslOpFhK1luOi+92f0ti3L/XVtoCcQuiqyWOXxHAXGpXIGqrJBy?=
 =?us-ascii?Q?xI+j+Y8qVsVRehGAT4zC384uz9OP/wdvIo9mLp8ltNRkgZWHnr1cGstr8Tie?=
 =?us-ascii?Q?FLH86RHKyhjtBHLuymVgSXmFCM5zg/mLGWps8U0WSi9refgwxQ4/RnhgYxWS?=
 =?us-ascii?Q?QXIvQkWQKgpXspjLPa48saWxCGLhVut9pVNt8dP8ZklKmxVYtMIJ237SK7E1?=
 =?us-ascii?Q?K4AZoOix/xZP7XnfbAN7aU2raSGeJXFMn4SaminM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9282bd4-6fcc-434c-b3e0-08dc8535de0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 08:02:38.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVQRSmAnDs/lUokn39a2c6Xm6Qx13E/fD+BNiS+d0IX/hiDB3+dK4PBxHx/I8sZecBLdaYAq7M2cG5I4L1E64Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7548
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, May 27, 2024 12:05 PM
>=20
> @@ -99,7 +99,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device
> *dev, struct mm_struct *mm
>=20
>  	/* Search for an existing domain. */
>  	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
> -		ret =3D iommu_attach_device_pasid(domain, dev, iommu_mm-
> >pasid);
> +		handle->handle.domain =3D domain;
> +		ret =3D iommu_attach_device_pasid(domain, dev, iommu_mm-
> >pasid,
> +						&handle->handle);

move the setting of handle.domain into the helper?

> @@ -3382,11 +3383,9 @@ int iommu_attach_device_pasid(struct
> iommu_domain *domain,
>  		}
>  	}
>=20
> -	curr =3D xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
> GFP_KERNEL);
> -	if (curr) {
> -		ret =3D xa_err(curr) ? : -EBUSY;
> +	ret =3D xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
> +	if (ret)
>  		goto out_unlock;
> -	}

this leads to a slightly different implication comparing to the old code.

the domain pointer was always tracked in the old code but now the handle
is optional.

if iommu core only needs to know whether a pasid has been attached (as
in this helper), it still works as xa_insert() will mark the entry as reser=
ved
if handle=3D=3DNULL and next xa_insert() at the same index will fail due to
the entry being reserved.

But if certain path (other than iopf) in the iommu core needs to know
the exact domain pointer then this change breaks it.

Anyway some explanation is welcomed here for why this change is safe.

> @@ -3414,7 +3413,7 @@ void iommu_detach_device_pasid(struct
> iommu_domain *domain, struct device *dev,
>=20
>  	mutex_lock(&group->mutex);
>  	__iommu_remove_group_pasid(group, pasid, domain);
> -	WARN_ON(xa_erase(&group->pasid_array, pasid) !=3D domain);
> +	xa_erase(&group->pasid_array, pasid);

if the entry is valid do we want to keep the WARN_ON() upon handle->domain?
