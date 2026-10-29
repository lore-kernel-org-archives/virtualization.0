Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793289636;
	b=PPpno1kSUsQnHdA1w2UhgaRoF7jpL9crd9xlbrwbnZ72PV0F2u8UW5X0crCrFYd101yh
	 FaLpQkEe1AjzJebT9B28bZB4wpetcBaMIgdhvgdxHGjSoUyxkdASCEOXkdRc9ABylAYGG
	 bIL5RM+y58BgNk4YhMonjJBhySUKlb09WTatMzb9z9nL6qSpD4Pp40Ju9HVAFPDhIJ8nV
	 H36ydkjUNRD7HIjTSWKUyobqLYky1uC9C/CL93TVG2SwijESbos+PJYeSTmScx5PzUH9w
	 EEexV2hyBecLmFA4e8Nkju/TOYjeq8fbvKZYD4RGDfooVnF4U9viFlJBSRDu5ukhq6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289636;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=++iK9zA7vdSqa2z9khUOayVv3ianUOElr3aNyLxohNs=;
	b=Is1GBUjBoAClfhG8FuBQWRggK8sy+xJsq0TO0yQkGooSQMDTrXZW+LpxetTWM9ro8Nmy
	 V7L+QwO74mfuxUyNOaoiW52C5KB8KIDMRtL36xt9LADdDSLtmwQ43YMjxd/aLpJ4BWoRq
	 U1yk0CGmO+bRbiidGuIFeoTsSEMJgmsO+RF3AvR2K0aoTIjSOjd2k6In6d+Y065j6rUIP
	 M5aZTSBvblWNNgpHngCkcswP7d2MsSW0o7v5SGrFXJIpIq5ELHHX+cHUBbdECB6TdW7fj
	 J7KowIzTlNTljnh03CguSlrKLXpq5C5cOHQzRCgx8j0bMRIlFpcHSeaPuufu+p0broA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="nvDqaE/G";
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1E606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AD1E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nvDqaE/G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793289635; x=1824825635;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1s7rQPzBWfF3kY4Gi4Gs8o36uSP/gZ92/BBROqe3tUA=;
  b=nvDqaE/Gs2fOkazm9NHov7e+JWKPlX2rL6Gn0CeiUiukvzhjJeadaoyh
   z6yULKM4OjtsNXU0tvpSOFnzI7GO4GZWOVe5ef3qwZsFTJelBhkaEJLju
   5Dxdf7H6iYfEY0GHTxM9xoLyYsl4qKgGRywK5czcKrEbYqBO8zQqgBGmb
   HDsjx8vMC2e/assW2pXtPX0kc2/jN7pfygNlEG+ZXqWD9JonmdOLHjYpl
   mJGOl/DJbutUUwKgbTKhTzqpRwjO+QlD2sc28Df2haY5Ztp9bsngmN0IJ
   EsWiIqYdGoEpsdVJrOsAoBz/Af8AjVzcGoZE56e+p4c8EXvJgtPBkGNzc
   g==;
X-CSE-ConnectionGUID: +MtnEKORR+WtQidp3TzTUA==
X-CSE-MsgGUID: Bg1dySyPQzeRRfBM8IKnCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1924328"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1924328"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 09:00:34 -0700
X-CSE-ConnectionGUID: yvTkDk+tT+OTJ+A6TBHHyA==
X-CSE-MsgGUID: uKa5PQb6QsebgeeX3ej9Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5275435"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 09:00:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 09:00:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 09:00:31 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 09:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7dw55R7QH2y/o1H0Krg6QrDe1sXjJtyKa4F5Vrih1n4MfYxcWou3GRsTxhzRyq1iRE+3U1dit0gBpLt+bjF/XnCDvO54GVFGp/vqODW+nfWhVZAPEN5GEPpLXsKlLnuI955r62lE2WhqTKgZncFwenkqrTUa+P9a/nuxpt9Ny7YL1qJOJ2Hy8q8Hm8KRt8TS8NjVADzaji6eRRrZhVV7ZO2GJBQ5nx2oY73Hgp/t6zi825dhD7jK3PnAiI3XgubsA8pS9M7s/fJGYy7h4Wny4kGjK4FLVJInuP3OtGF77AI8S0Dgo/Rd60l0j/sOqtq5hgEQ7VNkPN4vWxE4sZ1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++iK9zA7vdSqa2z9khUOayVv3ianUOElr3aNyLxohNs=;
 b=w+WtNPFR1X0tRSrixPIJjnQVocHwPpYr+kD1XQQ9C9MSsG4uj5pNQpGLbuCXtLqD6/XoKFkUB/WZLoE8mpzxtymqFObJQDf2Kvp2EwQadVfzSphjiVSKVm+4MY91fnii4zIidg+2hYSBUxzYv8k6iE/z17e0UhbI0knZBKWzbEO9PRBrECndUs/Sowi0aErm+TuaD5u55rdEP8wriUof1yMR1vK/wqz5E3sxQVIL6w6Qde1yfgAKoHfq9G1ptd8/992NrCO/y2yxyZ5YwSmt2crMuHC13fc9sZQKfFcgFeEqzpLuye7VDR7Nlt2EkROPaKY1vIExt4lnJo2B2/VHXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DS0PR11MB7999.namprd11.prod.outlook.com (2603:10b6:8:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 16:00:20 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 16:00:19 +0000
Date: Thu, 29 Oct 2026 09:00:15 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Philipp Stanner <phasta@kernel.org>
CC: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Oded Gabbay
	<ogabbay@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>, Tomeu Vizoso
	<tomeu@tomeuvizoso.net>, Karol Wachowski <karol.wachowski@linux.intel.com>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, Sumit Semwal
	<sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
	"Simona Vetter" <simona@ffwll.ch>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lucas Stach
	<l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>, Jani Nikula
	<jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, Alessio Belle
	<alessio.belle@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>,
	Qiang Yu <yuq825@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
	"Dmitry Baryshkov" <lumag@kernel.org>, Abhinav Kumar
	<abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul
	<sean@poorly.run>, "Marijn Suijten" <marijn.suijten@somainline.org>, Lyude
 Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Boris Brezillon
	<boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>,
	=?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>, Liviu Dudau
	<liviu.dudau@arm.com>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann
	<kraxel@redhat.com>, Natalie Vock <nat@pixelcluster.dev>, Arun Pravin
	<arunpravin.paneerselvam@amd.com>, Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Melissa Wen <mwen@igalia.com>, =?iso-8859-1?Q?Ma=EDra?= Canal
	<mcanal@igalia.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, "Dmitry
 Osipenko" <dmitry.osipenko@collabora.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Zack Rusin
	<zack.rusin@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Thierry Reding
	<thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Sunil
 Khatri" <sunil.khatri@amd.com>, Kees Cook <kees@kernel.org>, Jesse Zhang
	<jesse.zhang@amd.com>, Timur =?iso-8859-1?Q?Krist=F3f?=
	<timur.kristof@gmail.com>, Srinivasan Shanmugam
	<srinivasan.shanmugam@amd.com>, Kexin Sun <kexinsun@smail.nju.edu.cn>, "Prike
 Liang" <Prike.Liang@amd.com>, David Rosca <david.rosca@amd.com>, "Krzysztof
 Karas" <krzysztof.karas@intel.com>, Marco Crivellari
	<marco.crivellari@suse.com>, Shixiong Ou <oushixiong@kylinos.cn>, Jouni
 =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>, "Thadeu Lima de Souza
 Cascardo" <cascardo@igalia.com>, Pierre-Eric Pelloux-Prayer
	<pierre-eric.pelloux-prayer@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Neill Kapron <nkapron@google.com>,
	"Michael Bommarito" <michael.bommarito@gmail.com>, Sam Day <me@samcday.com>,
	"Gabriel Prostitis" <prostitisgabriel@gmail.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	<etnaviv@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
	<imagination@lists.freedesktop.org>, <lima@lists.freedesktop.org>,
	<linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
	<nouveau@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<spice-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<linux-tegra@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] dma-buf: dma-fence: Close race in
 dma_fence_is_signaled() by default
Message-ID: <auNtj8zYrqwtnXdK@gsse-cloud1.jf.intel.com>
References: <20261029095542.1526750-3-phasta@kernel.org>
 <20261029095542.1526750-8-phasta@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261029095542.1526750-8-phasta@kernel.org>
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DS0PR11MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a3578e-fddd-4b58-297f-08df35d5babd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|261026140227099003|4143699003|261021123027099003|261021121427099003|10067099003|261026121527099003|261009223027099003|261022075727099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: GcA/mTp3EeoLjKo9kf4JRRrRKZLtSlDNaMmvaSH66FCOzpPQZSRs/U5CmyaOEfe85COboqUvFC/IS2XNvmWk0YNjCp1HRjR7+YfGdy5ApnRrM/c67DJNNNEETe1xJ4eXeyYxwYAyvGUWo49j9UYEXcCDfM7TNvUKl7+1BKpFhcPUIHZ7WvA6SMFestx7luxt2me4h/k0MXsnbwVSD6ymbV7F2E5m+M653Aqp6BGQ/Pmr95HLeX7h0n8ZEE8HYdhSLbfaGl/CwOTcphOULwPXNSdQPy6Q/WXlAzgTmEuGea3akpjRVedIkpewnHHLYyTpkxIO3+AhjibRAVaRUb886ft7MLrmdF7945T+lnLtzd/IG2y6aaE/e4VU3HxpkZiV2nWqgMqNc8VXwNa1uxVuRCJQJXU4Y0UObzf1xQsN7ybsDvu6JeegZWipNKVjD7jLbjKyELE0sA095YtYQoMnTWlbavtkL2ZKpCSJsDWUD0zWrlktPcoD/hPddvLuWDqtDsbPcoRuxqgLAOr3uXEK2eLLRbt/8PwA/bocggz5KnHWwSyGSdhUlnDNYwOuZxjvY75hmGX+BOX/YoS8JWi6Gh0w+1MmkT3mzO9G/Wvr9SaMJoNXrUqFSvfDl42XLZeLh0EqVr6DwAWHqeRFrz9VHEFrclPMlQO9kT1wIOCPWjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(4143699003)(261021123027099003)(261021121427099003)(10067099003)(261026121527099003)(261009223027099003)(261022075727099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yhF8AzJ4SOQZjKgwpgmtJEsmjJJJQZSmg7/qT2hQva1P3tFx5+K7Yuv0XDxE?=
 =?us-ascii?Q?YGKyP6qm6UBfD/rfkSnzfmOttXOSXlYIgQEY3s/hDdvwREziNUYoATT3VAXg?=
 =?us-ascii?Q?EyV1ZxkVWVmsB4bf2H1WrARuJ1BWkpzWKvU7vBjZxefHYHIKI9fathPH1BMg?=
 =?us-ascii?Q?Mk8AL15M9nbE6rGhw7oNayZTS7ulj9k4xfkaWFXyzMAu4HCKl30YA7trp8qR?=
 =?us-ascii?Q?jE7HPC18lS8DVACLGgnTvAtkJKYeYldgyP7/2baOmlVZJYZD4zmjEQF6QSqd?=
 =?us-ascii?Q?6AG5+bexZyDihivIA/+1sqYcWy2ZsSKrtf2Sxg7ifGXqaLAO+DVmnpQYAY9u?=
 =?us-ascii?Q?/0X5ieF1oXhQ5T46RrBIgTTGTU2/rS8fiDlgydqTCFa7GwWpITBfLq5XVMPO?=
 =?us-ascii?Q?tuGFnYR5vwENoNvaBfimbbK8VFHzDgqWs9jH7vLZIh8JN4RM/3LbhFm0NlsP?=
 =?us-ascii?Q?Bh/Ji3OtkT/HlQt8VnRQCL7Sa1pkviVpdXMyW63P4TLP4dpOJ/e+rIQps3sc?=
 =?us-ascii?Q?gzIwLCo/A70cwZq4za64EOGuJYykb7JOEQev2O53+8iLbL0malpFKMc305wl?=
 =?us-ascii?Q?M6QbbZX91ZcZYPaqYjIQsVkbLkQmuB0oZzvsnJZAUvt26nnRpc1kydEK/slq?=
 =?us-ascii?Q?Og5hD3gWG0tHqDXZiVDtDYJ+A3NLPdDTX07EOWtGbaxmK8Rha/HeNsdRL7/K?=
 =?us-ascii?Q?j2TNPOQP67Ce92OnO7VF+uUTKGnkedGKW/CUoArTGCjWOu75p5XfKj1gEqPl?=
 =?us-ascii?Q?304SJqpFMsjiQkRPrybV2inV6ZIQxkq8thcDad8z+d7JaQw4/HpaiMFW3BPI?=
 =?us-ascii?Q?Neo+pd7oiPbqwUOrRe/4Wj/uqkDldwF8+C4jPpxRHDcDr7SV2OAXR8DPsuaP?=
 =?us-ascii?Q?FGZvPuF7Jf3IM7mBUWCev38v+otOOF6M6YCD3RepkIXNGX+mvvCuknak1PGI?=
 =?us-ascii?Q?6t/URpwMQsZhbz9V5HTyaXIYqz3l4n5ZeaRmyiYnR1h566xM0KnX/+T4tDhC?=
 =?us-ascii?Q?0+swB0C/53Ez5M8lOitNeERlB7rPLdqLpcENIdKp13fgv3W38Z/ee+MJkVlB?=
 =?us-ascii?Q?JKKV15VqmaV3s0bu1aEufn8upTr8JsHkYTn4RjWI30HHUodW7Xj9Y8x5XCcD?=
 =?us-ascii?Q?bScg1/3thW7vKQe5wngY3yBCkNKSJuhyKUoFNQVjFndmpGGpU79MUU56PlOu?=
 =?us-ascii?Q?tNJCk6cpYJQBOuUan7AtIV8Q53o57SPua3K+laf4u6UsRhT5Egx1tCqG0XJk?=
 =?us-ascii?Q?5cBrlRrfu0MM+TnKPzwRm3tbpqz/5hk0IwcyAXxs45t/lmMepkczpAbvEVJP?=
 =?us-ascii?Q?T7Y7tanSinbMf0apgIhDdgGEygGUlX/u0zoCV03VYQFHM9lfHkaLnXNwMC9G?=
 =?us-ascii?Q?rhBu6/NtP6w8OioKuV00NNXE7dKd2kYgjLklYSMSMlJTQ2HB8jUNBWlgyr0m?=
 =?us-ascii?Q?OZ1/+zOUR0JwAlj2dSs4xV6HHZ2gHo+pTCZMQBIQ6z29M9SoIJMa7kC3HEWp?=
 =?us-ascii?Q?ZxsMSwXPnI12wXgMvByM39w2Vafl2SJo3YdZIpnKGzrD7t/PqCyfPWpI+mEk?=
 =?us-ascii?Q?mrYKJrNxoQPDpTvZPlGgmwyNMUUIsXtYRDjIm5XPzaNV0Q4+YEwCwXidBf2D?=
 =?us-ascii?Q?znPX9w0PaoOE4qN7f8MBUF+ikYcHBjzyB18ztj7xUE9Cy7CzfcBNVaaZgdy9?=
 =?us-ascii?Q?cAqGmr6juZ3Fq2qgbs0f0Nt5F1ZQplZE1fN+64VvSX205qGUiLFixjLme0zX?=
 =?us-ascii?Q?T9a/l0vNZw=3D=3D?=
X-Exchange-RoutingPolicyChecked: dLchvVtnFtecCNNV+v+ZIIG05MtGLBr70qRjTdh1vTzrBkOTUKxwylRlWDjcLKwFLSJ56kKgUfTh2ISt5C7dnlfSI8QUelygsNRnwrA7w5ztxSoLpV4FeJzVnQ/+LKkP1gXlMiwGPYbVa3hM4F4Kndc+8hpYKSVMm/Z7iXQByCiaNgp2ptitmUZ/Sk5vegJH521FjaX6x4BPVfva0LiV79JFOG0bRAD3q36M+lFvhAvG6ctR5jjk8jmBJTFuUYZXGKbao5N3CIb1jMvbQBeuEgNy0nbDnhecn8RRqVD7zO76vaxATu4keJHpxP6tIWa9Xqa+DUGAEnb4BQDgohgw4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a3578e-fddd-4b58-297f-08df35d5babd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:00:19.1318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5xI66ER351bw+NXujpvhxkFpRqgB+f3HwPJlr35TdqYCPpvwQDo7vWQUcbhQEiONluhg4IYvB+WQX47sagy2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7999
X-OriginatorOrg: intel.com

On Thu, Oct 29, 2026 at 10:55:42AM +0100, Philipp Stanner wrote:
> dma_fence_is_signaled() contains a lockless check of the signaled-bit,
> which is set under lock protection. This is a race condition which makes
> the API fragile and has caused at least two bugs already, addressed in:
> 
> 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
> 	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")
> 
> It has been argued by some that this race cannot be closed for the
> entire kernel through locking because this would lead to a cache line
> invalidation for all parties reading that fence. While it remains
> unclear why these parties don't simply let themselves be notified about
> the fence being signaled instead of checking this repeatedly manually,
> there is a way to preserve this behavior in any case:
> 
> This patch adds a new flag for dma_fence_init(),
> DMA_FENCE_INIT_FLAG_RACY_SIGNALED_CHECK. If this flag is not set, the
> spinlock is taken and dma_fence_is_signaled() becomes perfectly
> synchronized: it can only return true once signaling of the fence is
> completed.
> 
> Disable the racy check for everyone by default. Should some parties
> really experience severe performance degredations because of this, they
> can trivially re-enable the race condition for their driver by setting
> the flag in dma_fence_init().
> 

My 2 cents - anyone arguing about cachelines probably has broken code to
begin with. I'd say don't give anyone an option to opt into a racey
check, if this regressing some peoples code the answer is likely
structurally fix your broken code.

Matt

> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  drivers/dma-buf/dma-fence.c |  2 ++
>  include/linux/dma-fence.h   | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index f7c084926ae6..1ae8c7aade39 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1119,6 +1119,8 @@ dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>  	/* Mapp the init_flags to the fence-internal flags. */
>  	if (test_bit(DMA_FENCE_INIT_FLAG_SEQNO64, &init_flags))
>  		set_bit(DMA_FENCE_FLAG_SEQNO64_BIT, &fence_flag_bits);
> +	if (test_bit(DMA_FENCE_INIT_FLAG_RACY_SIGNALED_CHECK, &init_flags))
> +		set_bit(DMA_FENCE_FLAG_RACY_SIGNALED_CHECK_BIT, &fence_flag_bits);
>  
>  	__dma_fence_init(fence, ops, lock, context, seqno, fence_flag_bits);
>  }
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 52e7ddfd2d06..ee6e8de3ebc6 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -115,6 +115,7 @@ enum dma_fence_flag_bits {
>  	DMA_FENCE_FLAG_SIGNALED_BIT,
>  	DMA_FENCE_FLAG_TIMESTAMP_BIT,
>  	DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
> +	DMA_FENCE_FLAG_RACY_SIGNALED_CHECK_BIT,
>  
>  	DMA_FENCE_FLAG_USER_BITS, /* must always be last member */
>  };
> @@ -124,9 +125,12 @@ enum dma_fence_flag_bits {
>   * These flags can be passed in dma_fence_init().
>   *
>   * @DMA_FENCE_INIT_FLAG_SEQNO64: Use 64-bit sequence numbers.
> + * @DMA_FENCE_INIT_FLAG_RACY_SIGNALED_CHECK:
> + * Legacy flag. Enables a race condition in dma_fence_is_signaled().
>   */
>  enum dma_fence_init_flags {
>  	DMA_FENCE_INIT_FLAG_SEQNO64,
> +	DMA_FENCE_INIT_FLAG_RACY_SIGNALED_CHECK,
>  
>  	/* Must always be last member. */
>  	DMA_FENCE_INIT_FLAG_NR_OF_FLAGs,
> @@ -568,9 +572,27 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
>  static inline bool
>  dma_fence_is_signaled(struct dma_fence *fence)
>  {
> +	const bool racy_check = test_bit(DMA_FENCE_FLAG_RACY_SIGNALED_CHECK_BIT,
> +					 &fence->flags);
>  	const struct dma_fence_ops *ops;
> +	bool signaled = false;
> +	unsigned long flags;
>  
> +	/*
> +	 * For legacy reasons, there is a race window here against parties
> +	 * signaling the fence. They might still be doing that right now.
> +	 *
> +	 * For most users, this window shall be closed, but there are parties
> +	 * for whom the cache-line invalidation by taking the lock might be so
> +	 * significant that they prefer to accept the race at their own risk.
> +	 */
> +	if (!racy_check)
> +		dma_fence_lock_irqsave(fence, flags);
>  	if (dma_fence_test_signaled_flag(fence))
> +		signaled = true;
> +	if (!racy_check)
> +		dma_fence_unlock_irqrestore(fence, flags);
> +	if (signaled)
>  		return true;
>  
>  	rcu_read_lock();
> -- 
> 2.56.0
> 
