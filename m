Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71749642
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576143; cv=fail; b=fdEm+JlYSk7ZyKqHW0ORdW7RmOkb3mqX8q3GCxXIR9XL1VzaBCySZ3CU5VZFydk9rHXpA2vEU5scm+aF7xvLL6EObrrUHH5K8RpNDYCFeT+QyM5Q5IK6+kJVWuvRGdO8cAT5ZiMXa20AJV1wDCHXoPhN+lEBVofzCOtfdCFju9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576143; c=relaxed/simple;
	bh=XS6sqUmt94Dc8uOIynQOLtpXI1d16yvwdH7S2WuBcdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MjjSCkmKsmoSUSgB/U4NnalsynH9HqR9A9YT9joiu1MRGn05VpdX7basGDYCd0z6cu+E16fSSy5a8J7TcxsEj3TFUHQrOaS7mlN2ZT7cNCLjkU9atsNmJy90RvU7RLy2AeA5xydmfWvDaZS8gYqyi3YG3G3UssNC9rA/QapdGP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNNk51EZ; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNNk51EZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71EC760668
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 08:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2AzAT3G6jAb for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jun 2024 08:29:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9A6A360664
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A6A360664
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TNNk51EZ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A6A360664
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Jun 2024 08:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717576141; x=1749112141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XS6sqUmt94Dc8uOIynQOLtpXI1d16yvwdH7S2WuBcdg=;
  b=TNNk51EZEEc/6cgHKM/kPoH1r8Lg4TbB25tSO8KEU7HiX25/HERf8Xkc
   S9MtdAsAXHyjZDpQ8ul1Gwu3q/bsPL2vUPEGb/hheDfs/zclnWlWWFyD1
   8igUfwAnxhXiOvQKore+3oZLNqQncvyChBtO55YOeNwrHf+8fU4KL+8aT
   UOgS9w/Jpj/cqZmJaq5wEWgh+B++flJ+HZ+rimufdVFmP7axrbSGyMk4A
   Xqh9O/LinDq97BT3wOniS89SFILLFPe+e5tpYxX5JN4jqKNhVUhovggg2
   0Gks/JoTwiTJyzX6hqd2auTjvuaFvtkTK3m52fZd+9HlTS+FQIzwOCtKK
   Q==;
X-CSE-ConnectionGUID: i5KtW90yTY21PAS0RtEYcg==
X-CSE-MsgGUID: Oj8SIpTvRTSVET0F1Uix7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24796841"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="24796841"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 01:28:58 -0700
X-CSE-ConnectionGUID: kPf99SsiQ8mbUFFRkhstWw==
X-CSE-MsgGUID: 5r+Bmh6LS56b1SeoBSbNTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37518236"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 01:28:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 01:28:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 01:28:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 01:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFSaWOp0dd37N4DYHSu3/duuyXJ8ed03U96lSJipUJJDngHV35WND1G0p2btHP4bjAqBwXujnyAn2kjza59camIeQf1kvhO5LIapQRJOUKJ9RW3U8pGGIySlggYJ8dTgsy/k7jR4SIFij3MdzE98dIpTIgLSEZQO7OMHnlj2m/hTTaSTu9siFomx8oV1ShIInCI5GEqNbakTbccSeUioJVy6tG3HyNvtDYZIu/vUbNmHeC5E/kPHGme/pfoHLngXZVM4O4ap/8B7QeJLSfoDY4UcykN/0qCX5s7BlmhF5QjTo17Tbc7yK9+UTkXTbKowuoSqHjSo//cIs3UdhQg/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfkOdKwcMnfupDTvKubFoFRxrmt5wLyI4twM4nrom4A=;
 b=Fj0LiolNmyam3QpaME+SKEg4BJoEiFlN7/b8ufumZ7JqtE4tsqPcxinugA417BntTjvsZdkuJpHFAsTmF21QYKOLnNHYWw5XVlGnojgV+DIqydQFLmF4Fb0diKdBwkf07ZkXoNMXfWulW6FKkxjQAiFlDv4i3bcmAEHIshOLEq04IUuoB5XGu9xxu26cNZVERZC3oY0bKIInZ9KZ5YYp01ubDPZ1O1P3fbhBPT331ucpQN9IhLLlA9cm84C+u9evSuFCXQp2fbcOp5/zT5QJ5wqppGJqjsPDAc1z4U/+GcrIVAL6XTnpUpCDfH70btiD94O5iXw2/82c78c2TZy4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 08:28:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:28:52 +0000
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
Subject: RE: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Thread-Topic: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Thread-Index: AQHar+txjixJkLb+zkCCruAoIX1UvbG45C5w
Date: Wed, 5 Jun 2024 08:28:52 +0000
Message-ID: <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
In-Reply-To: <20240527040517.38561-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7520:EE_
x-ms-office365-filtering-correlation-id: 4992155e-2bc3-433e-74b3-08dc85398825
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?RzWlcPpj0k7Y70WcGtpsTjv6dEK6monu/ytHDWHk+4izsRbzS+SvO2ehBVUp?=
 =?us-ascii?Q?yeEXIxo6LeQ+4AtyzttBw2mps/DLyWnKqGg4KbjNM/iJy9FBsb4VY/VC0Imv?=
 =?us-ascii?Q?6kYOm1TdeMwFFuMHXHaJiiar/wvPOiiDNyrykGdqeTZV0m/13mB9A01gL1ZG?=
 =?us-ascii?Q?2W4VuHCLrXX6Ru48J3SwkIZZ6hVxXJZBJ7AOXP//KG4wsqZ2eY2xs3xtrW+5?=
 =?us-ascii?Q?TZRr2Eke1Pci/YygaCC6wMXQETa3rvn7FBBaWYJVl8n4N83bYxNjvhvYsyrZ?=
 =?us-ascii?Q?9+Inc7J29vVzrcdMRk8d7cWGr6L//VeDUzL5VctxnPOHrARzM+3amPGhR0b4?=
 =?us-ascii?Q?GC4yMMTByuvV3WyKJiiz9Hh3tsA33ePAVXUGthbhogKLVpaf4bQWxtrOiVUj?=
 =?us-ascii?Q?9g4hTeXsO1aMY5rJUPGIfPk1Oe6ZnYKe9DZ5LVnqjLJs9zmZscim5BlIhT2m?=
 =?us-ascii?Q?HvGDNicOn2cmxr/cnqQ8Mfn8otjr3CnwNjueM0uW+/HxYtLGaSCZTsLMV3fS?=
 =?us-ascii?Q?rfzIlHMncxWoLm9AsYaYWToC9iVN6HPUFlQiwf/6V93mZot/CKdatR8p+ldT?=
 =?us-ascii?Q?mhjHH5qpoqg+Xg3c8J+kIpduoAV7EOapvpcRrIP0yf9w2O3LFwoQ5IYXIAPI?=
 =?us-ascii?Q?e1z3iBizGmafRPI/KXreaXiLjjdJA9sq9s2yMdnTmdwXA10gSLExW7p25JE7?=
 =?us-ascii?Q?Po9GpHtIqLyG+CgbL0HCgTNS3AOT+BNggUEozWviP5TqbbU+s6rtoCZhTb3a?=
 =?us-ascii?Q?+07M6gf9ObdlY5Pe4R0tp5hR13r6nCAzvLvn70Qk86AEuu1qwnwau1mWoHYx?=
 =?us-ascii?Q?95bn2jSlWeeRN6Mr3ZUb6e4tzREC5sWfTrfOmpLCYPr4ZACNwy8Y+RF+trE7?=
 =?us-ascii?Q?5gl8YMgvxSwb5PdvF/e+FlOci/vDiu1jGn3kCfbDDKH9Jrdwf++uKJhv9/QH?=
 =?us-ascii?Q?WFs36cEeHe4VZVCMCVbWwOjABjPT3PsERTFbo3x4N76NEF2W9t4iGT2eUb+g?=
 =?us-ascii?Q?mZx2ZnXM7m+XWfks1uUTvbi83EUPXXGuewnJ8WRdf6dR7KS65shramJZwNPr?=
 =?us-ascii?Q?nctBBdjnnx21yttsi057FARompAgQMn1e3lWPKuxfrwxRaBZftc8znc226AS?=
 =?us-ascii?Q?6N4goaQdGr7TEREOzrTkeznwXP7x1YYJy+wjRG45lmB1uclLjhuLk5iWf6c+?=
 =?us-ascii?Q?1/cvNJihsivZxriI8RbGWYZWv1WNRUX2E1zJQsJrl2aIG5E6eIUnhL9jBErl?=
 =?us-ascii?Q?MJ/uAgP+RMIyZA74C9Nx3oEyGZFI51YvozmchAizxPcp3fkdu1sZMNfzXG8X?=
 =?us-ascii?Q?Xo/GCivOrP6wpAofm5ceIwD6qMGJlIKQCcAWKo7DPFkFqL4BZ+a6kRbO0Cow?=
 =?us-ascii?Q?prPBCZVMlJbSn81GMVkrUOd5gQLz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XTgNMEVYS2lKpA/GWYHOF7l7Ggycg8EmXAipZgj3nJygEOYAqJzDzoLOyVJe?=
 =?us-ascii?Q?drQTLznjY10FnRIhk7R83ayIItjohH1TwCIAVfOdTGEqpdr1FQ+1pnEKm7d8?=
 =?us-ascii?Q?LZXcXFNZuGZNGQscuZEnBp2Cv5lnf2HWBqRGgVkIb7hgHwBMJyvO7hZGk8jR?=
 =?us-ascii?Q?wmiZQYsAP3Tv3pBjqV7R7FNtYXnkhG4oq4Gfk8iOHw1L2TlRXyX9pxZWT3qQ?=
 =?us-ascii?Q?XBTbUjSPQp+bhkgauZ9bXoFpM2z3phZ+5doL4GKcekXXWK45UdMMn+GeLEtQ?=
 =?us-ascii?Q?7XyZgqxPHWUDgkboxby2vih5QP3Y+Q9fcxzIqN51MsK/thO9QCn78kxpEcRd?=
 =?us-ascii?Q?D7kDiVfLuzhboFp6C+B8+dbod9h1Df6tFe3uMdJnfMx3IpcEuqcr2WCz9wSC?=
 =?us-ascii?Q?VLjOjOvzh3efy9q1rBJDqKJu0+Htu6En5mghVbdHg9i00scuU8B/GTKqcwBG?=
 =?us-ascii?Q?jkeQNX8nUueoGmukFsC7Q0KznD4hYdrflhKeUadalbyN85jB7asOMTQCYrIZ?=
 =?us-ascii?Q?NG9h01ZDHKya4Yqzbc+Wcyelk6KmSyOnGyy+fMqTrsVTNYDIyMhL4p19Ws/q?=
 =?us-ascii?Q?/gA3QP1Hc/m7mcHRPz+S5htr5su2Hm07wRa4zBXmhlm/0WQg7GtmhXuT/T3z?=
 =?us-ascii?Q?U0N//7XSldPZgZE1+WgROqNK3pc51Icx4sZNLBsYi2OgoTlaL3RxZJ+cRvA1?=
 =?us-ascii?Q?IdgX9D5kgTeanAe4PomPXTof4nDZ4xqQW1pYyi3hg2rgWuFybV1+ZIzEtGwU?=
 =?us-ascii?Q?qPum7xnQJ6DlS9i8ggWEPglz4/RPzrw4rKUUUmkC5EbbyE0xwapowUoWLpQF?=
 =?us-ascii?Q?COv5eYHYxckN6wpnEFlAVS2NB/jRDJh8JgA8x4Z9fR9Db71AdEh9VuslH/Dv?=
 =?us-ascii?Q?lf7b+WxR/DFvdODqFdVslYEsc+txjOBYLZDOThv8yvou16VG8qGBemHtT934?=
 =?us-ascii?Q?ys1dpN/NItGH2f36C9KSNJbeWERl76EOsiwbNrIn3BoKWidOx2i8yP7DOdaP?=
 =?us-ascii?Q?TLHRKvp+fAI6W8sDsDcp0K5Y3grVNI9pYudtrsi2h33IsTFEZ8sYJ8c3jAc+?=
 =?us-ascii?Q?bsHXTvYZAPwfCyTEN1OY3ReIjmmV4kMC6TS3BJb016xUGy21cLGBjeXbZWPL?=
 =?us-ascii?Q?C83+TKwMM8I9XUUBWepEsZwiQaxBPNmqXEFwn2mcQ59iqUQMIdG2UAniekPZ?=
 =?us-ascii?Q?uUxfJcXu+ukuyV+40BE1GMXTan9rUk28CtfjEWLpmvweAIXI/JnVDhZztjL3?=
 =?us-ascii?Q?kTOH0v+TKpiTtz3vP77yJ9FnXyY0/Hm/Kvy+ZO4Kd0TXgTKIdRXseD3Fllui?=
 =?us-ascii?Q?pWNT8PV21yG6p6usyq7vVPiIpBiphVZvpkZ/VWQiz6ZMQwYgkrB0xPaVTW7p?=
 =?us-ascii?Q?wlaHtx5OblXjSKE0+2MVGe11ErHwOMvHNIrl62kEpBl91CwzoBZgFS3RIfYN?=
 =?us-ascii?Q?PFpUGAy4x9yIXMx7oK+EOxoj9xprMmxIUxVHbdE05veSJlgEk5pSWKZ2JINr?=
 =?us-ascii?Q?74MH0TTtN2wBddjXXmRgooJQJKlhQGzt7plwsip4dZ29eXgRBhQHgPlaz7CW?=
 =?us-ascii?Q?vUQJekNztKkm/P0Kb8nJ03xDyXrvJCy12E5qtp2U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4992155e-2bc3-433e-74b3-08dc85398825
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 08:28:52.3434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/zBrU8aLYfHK/EFMhnruV+14TVK21XWTk5x5A2euCdF+3yCyMscKmeat5UfnCdzAiNMOXvO3jKK88Klz/649g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, May 27, 2024 12:05 PM
>=20
> +
> +/**
> + * struct iommu_hwpt_page_response - IOMMU page fault response
> + * @size: sizeof(struct iommu_hwpt_page_response)
> + * @flags: Must be set to 0
> + * @dev_id: device ID of target device for the response
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @code: One of response code in enum iommufd_page_response_code.
> + * @cookie: The kernel-managed cookie reported in the fault message.
> + */
> +struct iommu_hwpt_page_response {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 code;
> +	__u32 cookie;
> +	__u32 reserved;
> +};

with the response queue per fault object we don't need all fields here,
e.g. dev_id, pasid, etc. Cookie is sufficient.
