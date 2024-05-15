Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A344D10A
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715762237; cv=fail; b=HC6nG5wdJCWADof4wZ/LpLe73rWMNxtaXDLXpVQnQootXjOsdNSxgYGVsZCp3+tzk2vRT/x5EJQDc7vrQbCdB2ejubRO63P6f9Iu6W4GBTwxg7fYNeFOBU/yn2Kfyiv0uesRZYNjr4pBC23H0dmGi9qUgo9QGx/aj1WYkW1wjjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715762237; c=relaxed/simple;
	bh=+NZWOfNuR3hyHy/j7716AAUMJLUG0N5KzitPC6Sy138=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MIyU8UiDGkZ9M7DqXDdvOn+fu17Hpu9pKatbFjCew8088JlU1X+C2L1LMtDjXmGnaCj/vOOWqSUASoSWkQYy3pnhZ2lZgmGsUZGSNWeA+H3jrPjzIAJ5UUmDBQcqIpZXAF83degC9zCrp7tG/JwpDe8w2QksF1wFw2SwiKgqX6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoaikNV5; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoaikNV5"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5BA1C41A26
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 08:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E58x0x3aEBJ0 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 08:37:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D3D9541A20
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3D9541A20
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MoaikNV5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D3D9541A20
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 08:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715762234; x=1747298234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+NZWOfNuR3hyHy/j7716AAUMJLUG0N5KzitPC6Sy138=;
  b=MoaikNV5rk6OoEHqMFffKBXDUxhsjStzS5Dx2pxF/x4IuIjXwnR1DkFP
   R0JZwWA2djSNaYIJjfk5q/MYeXgcE8kHyEt/ash9z1xMuM5dyljXIFW/t
   P33VE9UEE83lPRnWvzf/NM5at60/PA/sCuaD+pG+SIr3/LwzOgdFQ+Ul1
   3+T753qF2pAVIxtAI/syQYyFMnB07h2F9C+bQruAkcUvT9W47m5e1YT9m
   yeN955fOWMQraTgZYP7oV8muo8qyeKHER/8813/poZwsDLlreORQaR5cf
   E+tEzrsA88j5PD+mmdrDFfGwBZdzToXTUUjYY1+831jR7G6nta7gE9ejK
   Q==;
X-CSE-ConnectionGUID: grpbWGHUT7qcgoj0uZEbCQ==
X-CSE-MsgGUID: unyaZEEDT4K/hISu4C8bLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11650586"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11650586"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 01:37:13 -0700
X-CSE-ConnectionGUID: F8Z2+hJdSOevu/ogerXVYw==
X-CSE-MsgGUID: oNUmkYiRSQmgh19qzfkHZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31564251"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 01:37:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 01:37:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 01:37:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 01:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtqMi8aC5TrHck20WhdrRug3p6sbpPGt1MSNa4hW/2gaobWlqxfqHbzACRBsOBrxr5Cg0NzdI1bf2KYqLg2qX0+kKGisd11/nwiVxneohotiIDdwLf0og1PSRo7P/PEGLMLY/Muq7bbxX7OvZGm4dzWXhTaQw73XvMo9sZ7aVe1TmigMcIx0MFVOnVD1BDoRjAS59pS+re4LBrQZE4xZSY3u+MKAdW7MkZpKqZD8xP2HPwEyex0gYTAOXKDumBg1t5iumuXOJNuSRrjEhXIsjmTQeS6RZxdHmBM2PzB3cBw8DmYUNIvdOorYX0ryHHWbXjRv7OgMp1LS5J1utvGIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BN5TBUQ2PmSn3jNTzA2YvYpnFrTncMARJaqYHW7d88=;
 b=lbqgd1Z9Q+pm+RvMsn8APXlLv7kKeym28sktrUnIm6C84qnc6NgEAQeatLFQ0XdRa88nfv3/OrQ3H0DGB1MMZ9sh18L1cATIFIh1APeHwVT8PJgLKKK9jP0xPt47NRhN6fQtGglrdf/uGeK+3zqjLyYv1v2ACAj1JjTv5m0EPk+gXnXf3bVsdH0OYAm8bndEfE0dhwhlBOdSkFGymurFSmpQRI/xcf8FeisBfqsEs9HqSfEBwmY+2iowxDNPRe2+os2KAuuhog+pglwAOZSsdw1CSjNQVckWZHdkcsddym+c0mKdYGkKCIMLSBxK/Kt5V9x0oJwxRWtni6/2Sa2YjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 08:37:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 08:37:09 +0000
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
Subject: RE: [PATCH v5 5/9] iommufd: Add iommufd fault object
Thread-Topic: [PATCH v5 5/9] iommufd: Add iommufd fault object
Thread-Index: AQHamw8IPv7IV85GSUGxhOe1hMt7NbGYATUQ
Date: Wed, 15 May 2024 08:37:09 +0000
Message-ID: <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
In-Reply-To: <20240430145710.68112-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CYYPR11MB8405:EE_
x-ms-office365-filtering-correlation-id: 86f13714-753e-418b-b9d8-08dc74ba3603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?61hSA5QgpvB9YgxhpCXMRxyldaVnBHOpl2gEB3dGhBuaVOxf5pOBVA9WVYJ5?=
 =?us-ascii?Q?XUGfKRa/8umDopgcpGF3u1DnshcK79FICrk5wsnG4QQnOr6q0ElbwUD8m4QZ?=
 =?us-ascii?Q?Hnf/ovhnpCE0i37iC+k7QDTQGvpJB/l+vanauwqFWZkwkOLr4wr7ECzBJ/e5?=
 =?us-ascii?Q?OgUlsJEXbwIkxT/ShalO1V3Q0QmvByUaXf5j85bfvknjyHKDZ5g8nJhNQ9XG?=
 =?us-ascii?Q?ptrT016x4Fgvkr+00x83hUSyxFgsWti1XenyYGv/DytC9P9Pl5UpycMOd0zW?=
 =?us-ascii?Q?Cm4ljWb0WU31fqanP1AhQi6ufUP0idQHm5qhyHzscaGNGvPvo38LymHX6K/G?=
 =?us-ascii?Q?+o5Z1wGtpNqOWQus5rwJEUV3PMWXuqt62xuvkBUgduZynT7G7cN6+oxKdwqo?=
 =?us-ascii?Q?Hsh60oHdngHEhxXYM5Fd88l2+RGfA24uAFNz032aogGkVVDb6adwVks2qmpU?=
 =?us-ascii?Q?qADHkwf2hXxJ3lpGv6uvBptWaby+zCBUmrmm7Da3S9wi4VUj62x8CI39Y0/H?=
 =?us-ascii?Q?jLdlWP9YDYp8MIHqEx5qvfwhMmzR+CxK9m/8JZf4nK/AkKL3FLepO7uFYvap?=
 =?us-ascii?Q?P5MZkJhDhGMaTiQgUDXPFOHM5ixraEFDPz1vUHpcHGzNE878U+oBaaIzxSVB?=
 =?us-ascii?Q?F77mSlUn/eRk6qlEe6YbWZYea3FXCL8zOpHhxcV29IYKuN5t+qacVfxZZU4+?=
 =?us-ascii?Q?vE/jOEoIYbgb6fJIWTnZmTmi/DACtUWZo2b3GrfNwYmhUQMFir2dJPuTxI9a?=
 =?us-ascii?Q?ZTjb/MJtj4IBKAXgH8JXM+Wp6da2nA7q+xVAAAm2QmHlglPbzK5SgrZxHgRF?=
 =?us-ascii?Q?xpsmgcA8r6wXtmffp2G7jo/hq5JHHskAPJVgBzLMskI2dgH2gMW1hJFRMCJT?=
 =?us-ascii?Q?4JbIhtqDAZpkC5cB+X8LIRXU20zv5UZcSDRVjrkeHj4lm/b/cngu36M0psmD?=
 =?us-ascii?Q?9u4q0U0uddiKyDZC+ZZYb6n4Ut5qQT0Ie4QZMq57thWmzohpYfY4CfqmGCDV?=
 =?us-ascii?Q?y8nAojJSUa+hyEHjb6/f7ym02UYJCLezf4FCpkJ8h0r7pzmR1J4udzdozBdg?=
 =?us-ascii?Q?30Mgihcnztou20h/C4HlE4PA8yS8QoWPnxv6pFu3heKMLVurp9fyu10F1W2q?=
 =?us-ascii?Q?YsgS5ak2bRc7/mM25Kae7UZIrjiDY3Zu7MEsQCm+4ZZNnIcNW/NVKdYNUCMP?=
 =?us-ascii?Q?D42Zhgr4lOoew1DECWctJS8rVMGdxo5YRbYLcrcDa4vZOIHIApO3gkPBuLbJ?=
 =?us-ascii?Q?i1LLX9uS93ZrfRCtxdIeU10N4h+PgdXRjJYaZ3kN9XP8iIbUFyKgoCWXDyZa?=
 =?us-ascii?Q?wyYuILbkSFpnqcEDSzydp2zcFqKCJEzoTPmSoSzPtvYCCWjvTdeyv9oh8p7r?=
 =?us-ascii?Q?sv7V1Ak=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p5h8ycVSS3JXPZ8tnSBfiqIVHEVDEumfskriFCHRuobti6c+el2+MNyYMlJt?=
 =?us-ascii?Q?6nD0p89b+b0XZneLY9EEnHPz/X/DdZ3/QGkv6Y2Z4pwvb2rjp2UElVShqn1l?=
 =?us-ascii?Q?IBrrqg7pgWXrPZpdNmVatbCU3bVL7nn3EkMY/bn1eE/qYwB/Z7PQZwQjTJXy?=
 =?us-ascii?Q?ScqVo5K4IMwMEwZ5Ja1UzLndHsbVgJ0RWke9GlQIBTwGQ3IWTfXKo1gjU45u?=
 =?us-ascii?Q?O/Qcf+lVHXsORPsRyYuCbHadikKIRnQzrrLZ5XgEx70g6g6Xeriy7yXABQKY?=
 =?us-ascii?Q?t/6LleAytqQlJ1ePdPWsFV9aOI3c3+10NL6p/v/6UrrZwRkNhSqSb1xzG1oY?=
 =?us-ascii?Q?k/SmJzcL/ost51fI9zrxdmhAMu27goH6ZxFUifks1zskv2Dm0WY49Hp8PeVr?=
 =?us-ascii?Q?kDrQB/Flrxmvo5f9h2HVBGVPN2h39ew7UDDciYbfGHa7egHBy98U6RppMaLr?=
 =?us-ascii?Q?b7Y/wOPIt7pTC5PYq5DPh4sG6bWJFUbT07Yp7AbhYF3nQuFKzFp3AIxeeoe+?=
 =?us-ascii?Q?nyVGfNBKiZo6+wqeJi3ySFce3kLa+t8mhm7hl0vGhwgwV+pq7FV4uKFQ6TUA?=
 =?us-ascii?Q?/m7ZzDNEqMFnQjwTDjmgFF6qk9mjiA+0yB/YZA6Gsrf9DHYRfjCji/ORvIgu?=
 =?us-ascii?Q?OWLpI2d/jH7ZAM57d0wANxfKoKnnd7IsvyFXnLjqU1cXaa9eI09NQMCMCKhl?=
 =?us-ascii?Q?HnhmTTVWo1kbSPX1YV4eKIE/OhZ6wdjaNdv3oo+it1BxfAqhzh5oKCC+fUyQ?=
 =?us-ascii?Q?YRaD2pkKKNPkKaNQ7Grx/1rG57gH56nWntC1EOd6X8Ziao7H3EkmSJCDbd3D?=
 =?us-ascii?Q?80/EwcxRNOU5oRMTe5LLzSF5AYqmspTazzkLAaQLjqVtZHbTMEJ/oqkdgLGN?=
 =?us-ascii?Q?Z5i6kVTFKDFktjOXFBoPVgblupx/vDrdMTfYO46EXv+WlVyPD2ueZtu5qXch?=
 =?us-ascii?Q?m5Lzo8YchNk+Um1zsvn0VlyX/6QSUBel5nZVSxrMZdhzASG8dyBXZ/2QP/BW?=
 =?us-ascii?Q?1soCWufaGlfzsfbnKUsGGp1kwDAX9LFXr4nMP3OuE/+96BSRFki4yH2HGXdW?=
 =?us-ascii?Q?sdB41tkXe4Yi5n2sPQ8/xc0v4IXmmR2D6J/9WiPNMc//VqA+VKmRvRYVW0s3?=
 =?us-ascii?Q?K8Lj0yKPyqrY9OcXOshYIJIK4KNgaVfn29mTdnWYe5BQDcd07eNFK//0XE+q?=
 =?us-ascii?Q?JvZXR/8GvAzT5cA+boC4PLN8TYsPRFBkqv82tB3Sc3eJum055oR3fkfMDNhM?=
 =?us-ascii?Q?koyZdP6SFZ9PQyujCkNw6ZgYokhUq6RLZQ2bJDe1YStKBB8z3ePLX/Ogo1KG?=
 =?us-ascii?Q?/dTGgR20iJmfsgzL2bJdS1lhFlAJ2eyJ88FZMSW2LrT5so6tgdCU1vTcwkWR?=
 =?us-ascii?Q?2yRYFauqP3YJAk1Q8U1cpkPM+eWlQvAAWkglv9/rRP1LmfK0vzgkPLFuy1k9?=
 =?us-ascii?Q?bWeF8sYRfyWKvrePF4PQfrU9N7c06je8zG4z8wSEDvL5MMjC6RjePWQQNzeV?=
 =?us-ascii?Q?kUbAJAUb+5yZSVQkYW0XMr1x7tqLWq6K6ZJIf9/NkuItqOJpVYOvAaxeL6ZS?=
 =?us-ascii?Q?zszd/uKpFyIPknFNlc0Iz+5+La+EQ3RfkAxwB2Yu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f13714-753e-418b-b9d8-08dc74ba3603
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 08:37:09.8484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1MmMYVmsvtBEvdJ87Azmqkoh+WJsQgR1NzmFVlAKuPh71mPEa3pRIsPyHDOpXj/vBy6SBUw2WxJQn8Of0ExEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 30, 2024 10:57 PM
>=20
> @@ -131,6 +131,9 @@ struct iopf_group {
>  	struct iommu_attach_handle *attach_handle;
>  	/* The device's fault data parameter. */
>  	struct iommu_fault_param *fault_param;
> +	/* Used by handler provider to hook the group on its own lists. */
> +	struct list_head node;
> +	u32 cookie;

better put together with attach_handle.

rename 'node' to 'handle_node'

> @@ -128,6 +128,7 @@ enum iommufd_object_type {
>  	IOMMUFD_OBJ_HWPT_NESTED,
>  	IOMMUFD_OBJ_IOAS,
>  	IOMMUFD_OBJ_ACCESS,
> +	IOMMUFD_OBJ_FAULT,

Agree with Jason that 'FAULT_QUEUE' sounds a clearer object name.

> @@ -395,6 +396,8 @@ struct iommufd_device {
>  	/* always the physical device */
>  	struct device *dev;
>  	bool enforce_cache_coherency;
> +	/* outstanding faults awaiting response indexed by fault group id */
> +	struct xarray faults;

this...

> +struct iommufd_fault {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;
> +	struct file *filep;
> +
> +	/* The lists of outstanding faults protected by below mutex. */
> +	struct mutex mutex;
> +	struct list_head deliver;
> +	struct list_head response;

...and here worth a discussion.

First the response list is not used. If continuing the choice of queueing
faults per device it should be removed.

But I wonder whether it makes more sense to keep this response
queue per fault object. sounds simpler to me.

Also it's unclear why we need the response message to carry the
same info as the request while only id/code/cookie are used.

+struct iommu_hwpt_page_response {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pasid;
+	__u32 grpid;
+	__u32 code;
+	__u32 cookie;
+	__u32 reserved;
+};

If we keep the response queue in the fault object, the response message
only needs to carry size/flags/code/cookie and cookie can identify the
pending message uniquely in the response queue.

> +static ssize_t iommufd_fault_fops_write(struct file *filep, const char _=
_user
> *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	size_t response_size =3D sizeof(struct iommu_hwpt_page_response);
> +	struct iommufd_fault *fault =3D filep->private_data;
> +	struct iommu_hwpt_page_response response;
> +	struct iommufd_device *idev =3D NULL;
> +	struct iopf_group *group;
> +	size_t done =3D 0;
> +	int rc;
> +
> +	if (*ppos || count % response_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (count > done) {
> +		rc =3D copy_from_user(&response, buf + done, response_size);
> +		if (rc)
> +			break;
> +
> +		if (!idev || idev->obj.id !=3D response.dev_id)
> +			idev =3D container_of(iommufd_get_object(fault->ictx,
> +							       response.dev_id,
> +
> IOMMUFD_OBJ_DEVICE),
> +					    struct iommufd_device, obj);
> +		if (IS_ERR(idev))
> +			break;
> +
> +		group =3D xa_erase(&idev->faults, response.cookie);
> +		if (!group)
> +			break;

is 'continue' better?

> +
> +		iopf_group_response(group, response.code);

PCIe spec states that a response failure disables the PRI interface. For SR=
-IOV
it'd be dangerous allowing user to trigger such code to VF to close the ent=
ire
shared PRI interface.

Just another example lacking of coordination for shared capabilities betwee=
n
PF/VF. But exposing such gap to userspace makes it worse.

I guess we don't want to make this work depending on that cleanup. The
minimal correct thing is to disallow attaching VF to a fault-capable hwpt
with a note here that once we turn on support for VF the response failure
code should not be forwarded to the hardware. Instead it's an indication
that the user cannot serve more requests and such situation waits for
a vPRI reset to recover.

> +		iopf_free_group(group);
> +		done +=3D response_size;
> +
> +		iommufd_put_object(fault->ictx, &idev->obj);

get/put is unpaired:

		if (!idev || idev->obj.id !=3D response.dev_id)
			idev =3D iommufd_get_object();

		...

		iommufd_put_object(idev);

The intention might be reusing idev if multiple fault responses are
for a same idev. But idev is always put in each iteration then following
messages will access the idev w/o holding the reference.
