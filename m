Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252F195FFF
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575366; cv=fail; b=WDdwOle7vzoCf5nO31L3qlCMDr+E4b09ek5f6QHsywXHakveNMUpdKwkYYdWFS4VBCJtKBw0ykdt7iGKm4leVVh1MV47kblwtX5YJS/qLr9czEHr3cVsGnV3DWGt3nd54/zHDFcEjWFsAm6L87JJ0nu7lwNhJDFcfmkmS+SpjnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575366; c=relaxed/simple;
	bh=zU6A1uv5W7f+FIfSJYUgMqvpOnpJnSPGpxM4bvKHgB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lvso6mZdZXy1z7syuJNohgYLduTE7m+lUBfUzdS/gvfMYXh1K6CBf+a8BbFlKRLHPnxtdGFwJYglY8MGJs294zJ1qryYqIGawLqmMIuJi68dfwkzKKll3CNxEC1aG2wISSWukp5r2eMbv68janT1L5oSW8KreMlTr0HKiqQf1mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBJrjwSb; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBJrjwSb"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C20CD6065D
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 08:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5n9aQnDaI4jw for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 08:16:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BE32660657
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE32660657
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DBJrjwSb
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE32660657
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 08:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717575364; x=1749111364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zU6A1uv5W7f+FIfSJYUgMqvpOnpJnSPGpxM4bvKHgB0=;
  b=DBJrjwSb2O35NO1rwoSmmUuytGzp7Kkrjky4AwGS586FGzpw2PZ9Gf7x
   UxqUxYW4DA9X9i9DXfJ/7rug/Z9exwAkuRROojXpf6hgtrClmVtdtRg65
   Hah3EdPWdz5KJENdpWUmpFAs0qhX76i+KtTsc961tXGHKuyEAno07ycMw
   6M9H5CEeqfctAwffLbWd0jmqVi7+jPNE6q8lZ5ei3269+6dkRHeDMACEL
   hlYhxvpROunk/8qvymZVB0SwqH5U97uR+UcBGzher2CfzkWDgrPvQ99wl
   RvS4ZUmPV+v4BX+ZZLsMp90ilauEhoen96LNqMLENAmH+y2C4Cc5alwbY
   w==;
X-CSE-ConnectionGUID: aqNm406iQ9OcH4ILtBEqIQ==
X-CSE-MsgGUID: e6goI5+1RXKsY0dSt6FnjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14121593"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14121593"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 01:15:57 -0700
X-CSE-ConnectionGUID: cBtx/zSmSjubl0hFxkBqeA==
X-CSE-MsgGUID: poj+lrEdQsukeHdkV/6y8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42466508"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 01:15:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 01:15:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 01:15:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 01:15:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkIROERC9mb3W0lvkkxe6Y18WHcxa/GE2h7S7R66OwkrO5VYv8VVh3n2Lchrfr/tSYw3l5Zs9y05VptPivJL3/TRHxP/Mvx4zuzDGtL6w5nF621NAFOElL0gHe0kOImQZOBIp7eUwOhl5JXbvfdazUJa76TAvq4UlxEqZm9jMwxgQryfMhnLHVsziGvkqCWGWXnkON3AoVd7GeLWfd4wnP6SMFNo4ZGVyYLmcjd3b5drzqm+/FtcyrwAhq7eFCB07izv6TFUxa2wqp4EyKeyZ+og2+pne90S/EHxNTSSs8BBfUuwU6a+ZEwolq79vg2qdEWRVA54KW7Q6ljxTgOHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi9K1WA7qpIuo6k0rh79wj4ZPiCz9tuPlQ1UQm90hpg=;
 b=YPmncRg8WFN8q6fPXbi6hm3fjJ5jXFIzdURYWvzyel6rJv4LcmPAmsSWhtYsznx5nKG+Ik9DKq0rkuN8OzV+kuNLTf4BdahvFgGZj4MblVEMYebpLeaJtrJlafEEtq/GeRxCF4hBQZ9b4KGU7AJd1kJjqPiQRGMjORmqmrh1O+wWylV6/YTCFeXEyQrj0Ny4Ly/wmJiKX7LIgFewCrfVxWpPG6148hGBQbCD2aBxHQ4DG+JjngnSmoLGFfBAoJGygzfXm+TdU3m7Xy177hPq6joxPzVfwx8bs5Tbppv3/3SYH7D0zxbZctaDjBuS7bEDzKD3OHrxdWyRC4es/LkovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 08:15:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:15:53 +0000
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
Subject: RE: [PATCH v6 02/10] iommu: Remove sva handle list
Thread-Topic: [PATCH v6 02/10] iommu: Remove sva handle list
Thread-Index: AQHar+tqwnlyEnOTnkSkjxonj6LyULG43azA
Date: Wed, 5 Jun 2024 08:15:53 +0000
Message-ID: <BN9PR11MB527658A85092F88329EB73E98CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240527040517.38561-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7258:EE_
x-ms-office365-filtering-correlation-id: d3d2aa10-e87b-4982-6dba-08dc8537b804
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?lJSp7xO7CpEvOy+W5crtdQ3XuXipzXXk0v4tW81yrh+MSZxrmbgilrpyPVTX?=
 =?us-ascii?Q?7FfkBAbSeHRIHkVanklTdBfEC6EpAX9+rLZdalhLwItgZ/maX54yL8TZz/9a?=
 =?us-ascii?Q?bSvz4sfUXahTNAOVX2vZohm1/yI7rWXfWN3kHFc8PlQDGq40uSmxOMg3GkOc?=
 =?us-ascii?Q?TLOyO7pzkTPrKJeeaxEJ4i4rWwnHJ9o6oUnUthVNgEzAhYNqH36HGCW3336w?=
 =?us-ascii?Q?jc17ZFlpG7WaOjaVdwd5EwSX2Qe1XxYxRTKQm8m7exPvZydXu3yuAVjNIu4L?=
 =?us-ascii?Q?95XObRciDu80DcsH6vAhItbPBx3TFQGQ2BQpavobwggHv4Jj8VUNqXL5crUb?=
 =?us-ascii?Q?m6ml6kVQM3UgjkjcMBYaeoLMxm8tL1yWElP3YYPLb1OoBDDj9wIIs5dwAXRA?=
 =?us-ascii?Q?asykKUN2Y8QO2Y/Jb5oQIoSFmATLaSmJ5qudhGfLSoJP3IYJyvdEJyM2SI2+?=
 =?us-ascii?Q?IKsVvjonMC0Um5Oitkq1pYTlGSnYrTK3S73ixLwQF8D0zIl/osPRx118vMuJ?=
 =?us-ascii?Q?fmGljkECL/J1vrcmQiRjZef/kG5WwEhHy+gzrYvQVCdDt+om6KHfT5UhFh8W?=
 =?us-ascii?Q?YBD2NELMBH4pa7KroQZ8D8rN+000hdkLklzHQ+XwH6pEngrKawHQZPIGQN/m?=
 =?us-ascii?Q?/GUPguE8cCGzHv9nZvP1TSS6lIHPHdnrLJZs3U6uOGZ7bJUyBRDuBnNd1XUR?=
 =?us-ascii?Q?dXvrq8lsZjj1S6NO4Wj/7hge1NeCWlh0gr2X3mVWFRvg1DZfwxUJj8/fRBDi?=
 =?us-ascii?Q?LIcwX4R045xqkfbExQBNjtjij6SN4Cz8VI7ap0mmJX7O8jNp1WjHM/kpkiIf?=
 =?us-ascii?Q?arhO02JtjNNjNtwaCbGnqujL/GzeUeaTdyaK1ZHfCnLfl3ZKLLWKL8+5Lj8F?=
 =?us-ascii?Q?Hj5hFBkW33nTXjp4+X59YU4XrWcAniicnoysfFkQpRTBR+jrO/nVDU8Y2vm4?=
 =?us-ascii?Q?ECNCJnxK9hc9cxYAlfOShLY/a+iM1CXLxjEzC8MwPrqcDWfigNfu0cAuGv8M?=
 =?us-ascii?Q?GH0v7x3aT4ir2aR9PE5zeeRhMGoUZwnuliNX2bUmmLswSRp7k7+LvsBZtRrW?=
 =?us-ascii?Q?1xllXbmZOj2YTLz6d90AKfhNlzpehGg7W0LKTTrr4JKaYK7AQvbSB5QhDcGu?=
 =?us-ascii?Q?kayvgul5KEyxGKWQxL0WfR/X/2Tf8nV0p4d08nkyD1Y73WXklFxIcWFCJ3pa?=
 =?us-ascii?Q?QDbX81Kq5y7+H3qDnkjAb92t/vmNxjUcHenprKOkpefpzqZfUfUZqP1TSmfy?=
 =?us-ascii?Q?MZmSPWOyrzAarhI/0tlJgsXNf+/EBhN5G3X+m1ySfGTdT2Pcf2byUhhY+EK4?=
 =?us-ascii?Q?CFQBbvxP2KbORNi/RRSqn9wGHTaZ60aMbjAHLcDYDhX2nimvsQOjBkhLZfEW?=
 =?us-ascii?Q?EMUAGRfyL1mGAVO3Su+Z1R4H8knj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yOD91JDkEaZad+akrnDCItskzPfTx2MaO0EyNwZcG7Y/gUa7MLQX/kt3ndxw?=
 =?us-ascii?Q?MUNAXLHQqFqlNli6ZdxP7E0jCnqWJIOZwwZ6YMjLtD4LmpOI3FLWJhCjAFJy?=
 =?us-ascii?Q?OOviVr8rk5p8GfyFPuRQWro5YqcA0orcmGfhYo7UEgK0Cd3G5Tvgnck6f7DU?=
 =?us-ascii?Q?Zsb1hxtpQ+uHjiGcCfeFAcdaVAPMz/IXxDQjtvhDrRo1jRHXOwz1sMKfpgMu?=
 =?us-ascii?Q?rWsn1PsyaRw3qsrmp+Q48YJiaAG02PJZl9QegMU9042CopZKxVrfken4APoB?=
 =?us-ascii?Q?jLz039+TNQlWf6+4lH2dnPQ10Yua5k61avD+IFEnzO0jxRgizb6DDx6Rml85?=
 =?us-ascii?Q?JFexFZXks13rVaqdZuZLPaGViOWrBgD4wtu7/ceRKp/EEN/RtKPxkDBzZ8WX?=
 =?us-ascii?Q?6Cqeke8e4sfDjWOR501uSfPp2v0LmJy0GDropuoCi5g4booDSKMJvEcGUf17?=
 =?us-ascii?Q?+KfQf+b9nCQfb1KE9THL1+CH3wX5zZ9Ebn5HkKE4yk5GpqjyLPr5mY1ZoCyr?=
 =?us-ascii?Q?z/Bqrnj/ym940+ppN7fwl1msJ8ZbYm4nLK251T3uJeMe3FL5iGAT4waOm7sp?=
 =?us-ascii?Q?pbVVknJZUhcbaQCCT5U7GkOOpM5+fx6ns/ivgbdGOqYeIDBnKkLDFoPJC4+T?=
 =?us-ascii?Q?hk2FAbhOF5eLvdOfsV8lc+VKMKCvgmkaW3Zzq2JpkaA/RMphtPWWFaE/OlzG?=
 =?us-ascii?Q?OxV1vHGUxKL4otRIWjjEdz2iLlKqfR7VDqKMCJ9duKjnfNty+3+9z0sc8SeL?=
 =?us-ascii?Q?QKY0bSvEPHRKQ+IXyY78GFAogMciDu/4BhQyHC9xc0iNmoSmapF8820Y2cNh?=
 =?us-ascii?Q?ar1pW84hZKbLGEyn2+HY05tyFO7VbMgr9MXE5klqA/3WHFkyotKanj0dBejI?=
 =?us-ascii?Q?5PIw8aWb6mIlVU9Xp2OOUwp7ch7uH0D40KZ8HmNVk0q+tJb1tquLNiwuaVIM?=
 =?us-ascii?Q?WWoYKIleKdc99guWoKVR9WEWCWOXzC/VHSsvEOc6Ft+UpOYj7GormQp5xtWw?=
 =?us-ascii?Q?i9qVhhHH2qmyowqhpEqxusfxFNLuYHzaBGMpVQgkWeKz6l2ZtpuLe7BCmmAK?=
 =?us-ascii?Q?KtvbNn12I+gO5TO081e7LMhERZIQZwMSYvcIqWufWiUROXeN4hdkdTqlGf99?=
 =?us-ascii?Q?BWB1I9wQTSTWhc3Di4DKFiOxVsVod9K6oGfEUs+IpTEQRAWrwUyPvCfaenR0?=
 =?us-ascii?Q?8xxYOv/2EpsP9I88IHPjLD2s+oJSu20geNJJfBzyo2rpbQJWh8Cyckd3Q3Np?=
 =?us-ascii?Q?LE1ss2qv3h9lOEpD8mgko5xkJytWXxoqGPPNXqQSmzMTtxHKMQY1/fGxM4vz?=
 =?us-ascii?Q?GjwGiE4SYicr6y2AgOCkTTdVNoKkPMlT6036TM+4P4Kbpf71F4EtruVN93Ek?=
 =?us-ascii?Q?L2xGggyUxbqZ7WnGkCam+xwuCfAVWK2C8jkxEx9iq/eqVHbR4ftfYBwUN+3H?=
 =?us-ascii?Q?T5cnhDPDPmlQc09ni3uCVEiM4CFzBkYBD1ErZJOsTzyVyLAsENYytOMHali2?=
 =?us-ascii?Q?j66nqub3iLqSU4R7yR5hFkFGtOvZA66dtWn+i9Igpk4lGfq6DBDvi5Ka4z+W?=
 =?us-ascii?Q?gMh9TfwEyzBLtbMf/oTxY1YH+INT5YS+T952jiHm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d2aa10-e87b-4982-6dba-08dc8537b804
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 08:15:53.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofY4tfFZQFDwgRB/HercUd4uAs6xZxnMpawamjDf4Ze3b+14eq6F7qhdjzNuowNzc6tyqZA/B3ehVlM5cHAIww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, May 27, 2024 12:05 PM
>=20
> @@ -69,11 +68,16 @@ static struct iommu_mm_data
> *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>   */
>  struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
> mm_struct *mm)
>  {
> +	struct iommu_group *group =3D dev->iommu_group;
> +	struct iommu_attach_handle *attach_handle;
>  	struct iommu_mm_data *iommu_mm;
>  	struct iommu_domain *domain;
>  	struct iommu_sva *handle;

it's confusing to have both 'handle' and 'attach_handle' in one function.

Clearer to rename 'handle' as 'sva'.

>  	int ret;
>=20
> +	if (!group)
> +		return ERR_PTR(-ENODEV);
> +
>  	mutex_lock(&iommu_sva_lock);
>=20
>  	/* Allocate mm->pasid if necessary. */
> @@ -83,12 +87,13 @@ struct iommu_sva *iommu_sva_bind_device(struct
> device *dev, struct mm_struct *mm
>  		goto out_unlock;
>  	}
>=20
> -	list_for_each_entry(handle, &mm->iommu_mm->sva_handles,
> handle_item) {
> -		if (handle->dev =3D=3D dev) {
> -			refcount_inc(&handle->users);
> -			mutex_unlock(&iommu_sva_lock);
> -			return handle;
> -		}
> +	/* A bond already exists, just take a reference`. */
> +	attach_handle =3D iommu_attach_handle_get(group, iommu_mm-
> >pasid, IOMMU_DOMAIN_SVA);
> +	if (!IS_ERR(attach_handle)) {
> +		handle =3D container_of(attach_handle, struct iommu_sva,
> handle);
> +		refcount_inc(&handle->users);
> +		mutex_unlock(&iommu_sva_lock);
> +		return handle;
>  	}

It's counter-intuitive to move forward when an error is returned.

e.g. if it's -EBUSY indicating the pasid already used for another type then
following attempts shouldn't been tried.

probably we should have iommu_attach_handle_get() return NULL
instead of -ENOENT when the entry is free? then:

	attach_handle =3D iommu_attach_handle_get();
	if (IS_ERR(attach_handle)) {
		ret =3D PTR_ERR(attach_handle);
		goto out_unlock;
	} else if (attach_handle) {
		/* matched and increase handle->users */
	}

	/* free entry falls through */

But then there is one potential issue with the design that 'handle'
can be optional in iommu_attach_device_pasid(). In that case
xa_load returns NULL then we cannot differentiate a real unused
PASID vs. one which has been attached w/o an handle.

Does it suggest that having the caller to always provide a handle
makes more sense?

