Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958215B15F
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751856; cv=fail; b=a2jH6yCntt+qrju3RSjUdQ18faoRgFWa7BsAYUNgoFvKGYp6WfvClpbfKwFgau0TIbwiKyaUEHXVnkzw2I3ts6F2HbuD5Mefna47FCT4BdSc2340WCS8VMs+9HmnCtw1OmdkUBFeQKOyCSRjVWb/PKbpgeGiAXJS/XK4A+NxQVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751856; c=relaxed/simple;
	bh=8pXmgy6wN51M2mRb+SMi0CCjDM9y7xGSfCXj72EV82U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDC7A/e1e2IVQ3FVPXJUHi/QugKxQm+5X+xeXwYmuGhA3ZRjDppJQFXMeRbJ4jfzD3CKOUzMrbZ4pV+/gWHTx7dlmusLe58VWjPebi/mSLPdFrzUxTWAPGpuV8V0rS+wWgx/Mptknm+CnL49sBnYvdPxg+iycsyDVymCBnJTx08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mmk2xf7Q; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mmk2xf7Q"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCFC142669
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:17:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6_oIHgWDUXh for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jun 2024 09:17:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 49BAC42666
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49BAC42666
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mmk2xf7Q
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 49BAC42666
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Jun 2024 09:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717751854; x=1749287854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8pXmgy6wN51M2mRb+SMi0CCjDM9y7xGSfCXj72EV82U=;
  b=Mmk2xf7Q0M2JkG9OaCD1/CeXlSDd7PtsUI5V8Y4L9DJ0/iSaCmKi9arJ
   IfPJCv4qSudjYwne7qFHzto+qQwg2uu8WMZmGm9J3vkXf2GqWiGSJ6W/o
   wHgVCa9aTecRCRPzRBlSdEkYA7Ucb9OjsbFFzWIQOehQVJbUGz2il9L0L
   iooAYIXVF5wVjDOsG+ZArs2f5kekwKGtHKv4KWkOgWJyqSLDbC3B3K/gk
   sKFbzHbCZkSuTTFjXHs4Yay+niCVL/unHoVNCOTU8N3ghIpeDEg2ytuSw
   PL/fZFKv0sCEFwzo3KYaC7dIsaE6qRqfrKefe4+44PbuWp6Cy/UUwrNfV
   A==;
X-CSE-ConnectionGUID: Y6FZM13dTreXpD8INNI2nA==
X-CSE-MsgGUID: CXJCNXspQgywuEe36d5DYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25037971"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="25037971"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 02:17:32 -0700
X-CSE-ConnectionGUID: E9yucLX4Q32kMbyYIThDaQ==
X-CSE-MsgGUID: I9dA24kJQEqXKAinAMeKvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="38188299"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 02:17:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:17:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 02:17:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 02:17:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 02:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/SN3GA2365LqRC0ab17XIg/iQyhcgH3VZ8hRiqJs3nf06ieQTnZwpHUIMp1Haq46ATLGvoqW6yXMj1QxPicic0p0VFExR++O4HZWGeOWPb1JDwatplcLqwetJoHUuvmOcF/p/T0oduwtg3o1qb9EFaBk0kNyWUtBb0OZRyXr+G3BJUPjESV+brDjwNnvhjEVJe34KezcYE3D8E6b0fxO7w7b+6NmpSra2qY2esdodmIG7kyidSip/6vB/L43InjhVH694M4LidIyKMG/2czPkDDgjSs4E1Mm4OVMdNv8v78zoTWzCCCgmV9aTIfJulS6QaYXfddtDjuUzKxNY65DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV3uPRcUAsdJkGvX3/2u6v8lcphUg5cr+H/S90Imco4=;
 b=YaKxg/WvB+ERwNDr9Uu6aFBMLfMc6FmFMq3OZ74o+8h0wv5JFPBZE++y4OWfQkY0e9QasIe0Vk5JIhyoxG1khQd11Pri0B/aKf9WcRQACuHYkkADIjRTqSf5MvmqiOxQRQM5INMBG06Qg+IboteTSflfaKa6Pj71MUbByyrmVCH6icf4mItg3GY1R/W4AjlkeIAQxivjr1Ag74dlSKkojawVRCQB2v0H3xxi9BCUm1SaLx8dBTqnv/EvogrePRCjU7CezFXL2Ji/qV2QJ6B1yh+Zh5MTVJjASUrI2F2eGg+XCvCvy/Z+Gk8laMNhfVXengZTi1Tdg0wXxr5+IgbJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 09:17:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 09:17:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 06/10] iommufd: Add iommufd fault object
Thread-Topic: [PATCH v6 06/10] iommufd: Add iommufd fault object
Thread-Index: AQHar+txwPSPp6CyskanS/lKKehznrG8Efnw
Date: Fri, 7 Jun 2024 09:17:28 +0000
Message-ID: <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
In-Reply-To: <20240527040517.38561-7-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4649:EE_
x-ms-office365-filtering-correlation-id: 1cbf72c1-2017-4177-f418-08dc86d2a6e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?oq7VshmeLWajkua4wLpSvbijbG6s9/fhPUIaERrrlu51I5zmhBn642Btdqxs?=
 =?us-ascii?Q?3ZzUHcEt2+3FzcJo2bHtS3q5rikthCCs3ii9NDjyoOQeRy2WPdzIdWxRnjrX?=
 =?us-ascii?Q?dSUZZOuH+j/oteFNqHRravSVTplBxgZMqDVrQUCDhMrrTMDZ3emenJp7sr2y?=
 =?us-ascii?Q?B2y/KchGdU/bZLkcpFT9GLsImNaUlNQmQ5i88aVlur8JsAq07uekYLEWViZb?=
 =?us-ascii?Q?L4lfZjqLSdSW3tWG3PYS4XBnQtiyWeJU1vJYa+tZvH3M5dcEGA9Sdfv4AFxY?=
 =?us-ascii?Q?tfaE9apikGWjtdobYc20tOgXsMt2A+OyJnSYYGbdGhe8W4nFi9wsPhjbHPd1?=
 =?us-ascii?Q?wAm1p+pCh8ZV02uWiqjNu2MPulVAaqY4UtVTPCHWnGXLyDpQ8+zFmaIswqub?=
 =?us-ascii?Q?7/g9a4T+QA1nV14gIcKF6nP1gOpjJMeIjqds8XQ/vVpXIDxhTpWXLLc0kS52?=
 =?us-ascii?Q?r4305RiFipOfNuHPvBb/nlUjTunoniJkSxdp54+P6VuBOzf/MvVBGUEVeI1Z?=
 =?us-ascii?Q?dZNejwNQQS3yX/pXYGKWXAWar254VFEENqNvxIR+dWYZWkqyNMg9lDZG3CLJ?=
 =?us-ascii?Q?pHNexOakF8PUd8YokCPENCJ5FkSPyPsiU8xkuF0VAYJAorMBA6NMlIEfUACh?=
 =?us-ascii?Q?KhoAT6GgsUaMBSKVIqGrzqknIzUwxiLBOTJAQKMy1p4QNezC1j/M9fojXMc4?=
 =?us-ascii?Q?j5hDXEyzxEdvIkbIynFFw2+N01FGWEAyO3YsW5BoMvc+NYwEneb2PLDPRaBB?=
 =?us-ascii?Q?9DyAGj+eUzeAbM7gkpcNJVg4/LQmnCzWXHKovkAK/RtssPWjJyotgkA2diwg?=
 =?us-ascii?Q?+/8I2j3JLivuysVrS2h0BlQJl3eXMcVjlKVn2RZkDMabuP8c3hSqlwZqIlCZ?=
 =?us-ascii?Q?y5NLgD0I7uKAkbOPmV8OAbvvkT8m6Oka1t7v1Sg9MwvidxBhrcaqR6z8xrc8?=
 =?us-ascii?Q?bBXgE1o/DN1In3YqI+RxsUjW2Yss02jND2xVaDoiffeXQ9Xz/4v+SyILCs7j?=
 =?us-ascii?Q?BCkMkxmP07dUTzM5Y9Vie2gw1UghMEcyYbow4I3myR5VIkVUBMCeT/2Q6mh3?=
 =?us-ascii?Q?Gk45yfkuFFr3ynVtOBV/SPNTEx1UTH4JB9xZM8ugG47+D+USAcMlBjNGeykX?=
 =?us-ascii?Q?I17lSr8yNGANkJ+9FSC1QQUpdQ+MDeuTTE4WarF8gQNs/csYr78QsgA2lyfP?=
 =?us-ascii?Q?zyLJNA16gNejs7PlOw2dZtI0gc+5TFkkvUQY2gOhFHFXJ7+zdckf3a5HYSCc?=
 =?us-ascii?Q?CLI7jN871YF3xWN6Azvr4ovOkhEQEANUIpMQ97gvHOnxyWimaYW/BTvKKnwZ?=
 =?us-ascii?Q?SQblh+E7VQZMSwcBjSOtkSvUumo09r9it++AZ/ac/s9XqHdZbNOUIN2zyjm5?=
 =?us-ascii?Q?cMFV+zkmlNRQh/JXqe24fNbclWDm?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ywm39sQrVzAp6znFvosSi6Hrmy7qr52ogI8K2TTzXnf00TvhFjw4xuOHxIwC?=
 =?us-ascii?Q?oX2e9nkj4qaV0ITbX/WKvxY70esmnLKNPhyNLWIWa3wAQpqHPlQHVqUYuu08?=
 =?us-ascii?Q?SZaHdheco/caiR9mMR7gkqSoHYoOeslglfn5ec0EGBlgm6Z0I0wIxT4F6nOY?=
 =?us-ascii?Q?qu05FGUFuJQdmhPjIviUNiiH698SgvCUswBn/H/8c895mkaFlm2h+yFUltf2?=
 =?us-ascii?Q?JZRELHb3A0Po9l1oOrKrN8x1nO5BJBWdn1H31FJe6xx13SF3Jyy/CmCpxXk1?=
 =?us-ascii?Q?UvVaZR97CbT+j97lOJaOBGekKYcL+4XSTe02cVn4561ecZatpNTAY+XD+HW/?=
 =?us-ascii?Q?kLgQr+/nPUgF2jgerl0QTWzL4OgHg+p4A4lGirkL5u9F2aNaHQyeplpeyYG0?=
 =?us-ascii?Q?SAwinnxnds3WIRe/ey5Yk1tctvEywPAjIIpoJ+Vi+OAqX+lTBcsV1GbL30Dt?=
 =?us-ascii?Q?kexxtwtaalkkauqunSZMqPAF4+HfNwsOSjYPoqV4OQel4HNbQATGRcdptJZl?=
 =?us-ascii?Q?D5iXX0Jf7FXXgHc8L+cDqNpBPTHL9pbr5zCTIxeGv9neoPHLFbH/ylc7y4ab?=
 =?us-ascii?Q?P3GhINzBbpmAcmGPZ9/7/GozNUMNTwgmPqd+cTOU/ON6v6L13MNglxQxWimy?=
 =?us-ascii?Q?8ywkv8yQTlBjEf4HW01Ff9bnkx+qSvde9qx6iCAWc0zXeRZHp3j/ZKXEhJMn?=
 =?us-ascii?Q?QlpAZs/HY1Ma7cGDv7wILXoEaomCQY2p14VZpn92ASvqcC25kAh+4L/TQLpN?=
 =?us-ascii?Q?Q+FqUoO3wjdPg6sZgWZUPiaL/Mvbw62mZb4Y7ppEt0Cx5LdQy5ro+6w3IhE3?=
 =?us-ascii?Q?bl94gHJesfTqF9qtxlGGSZJ6Wm2x2YPYoQfNg/NRW6w9BOyqwEpTseQp17lk?=
 =?us-ascii?Q?sAgZsJwTA1u/qkfABKRGNxZvXCeSolKyHHHUt/vHBqU8TlrYSJgvMiT6HGKz?=
 =?us-ascii?Q?qcnjUCzjDgKuBjdEAT3yo342GddhrssUGtEKGiU7vibZKFb09PBeSNkZnSKb?=
 =?us-ascii?Q?NzO0OTRWXEO5TjP4TcjUgguRN3+Wckf/7kTu+oGJ0Df4wn1S2CkqrkKUaNW7?=
 =?us-ascii?Q?SFw01UTV60wDOrwaRvfDD3cJn6sTpDSIBlj5bxp3qRlpRH6qiNBn0Rroxt7a?=
 =?us-ascii?Q?NckHGIysz7HESuV0VsyZPRqtapwBWoihemSg24D7okVmUolOGl6ozdQF0FGB?=
 =?us-ascii?Q?kttSvnnSz8Dg4YCKuefJOSMDyn3+73rGilVUeddNK/5hYBLx1be7eFxFYb9G?=
 =?us-ascii?Q?1kooold7Yh86aOmxF758rFZ81jAia/eXTMM+As/TVszCUgx2uCp7S4OmDZia?=
 =?us-ascii?Q?5fj6tmVTMOvEWUJXAbItXwt+kuYsERb9oKk6FLRUn844FI+xOVIFRe0YtqKq?=
 =?us-ascii?Q?wXG4KJm3qew94Lqw5bh4khoiFZ9+L//SbZsKeCZj2jzdnW3X3bamtak13iNU?=
 =?us-ascii?Q?4Qztzg7jK0LDXzNbpI3omFI6FV2Fq0h4oe6kFDR9MqAJa/K43l+cTve+KuBU?=
 =?us-ascii?Q?9x1ASjFsWoJ+Y/ZLvgZFAge/M88w1Vwr+ZO73Ih2Hk0gfuiiw+ZVOoTVhot8?=
 =?us-ascii?Q?OBVQFkkLj40WWpKPpZxaUyJvWH5VqxAXZB9/t9Yi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbf72c1-2017-4177-f418-08dc86d2a6e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 09:17:28.1213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8G0MjXx9FCwf2uBKCca4iqhC5veRpkX5hJhS4WHx8ZpvgecxgwlFaOG9LVCJi+annqXJRsZqZa+JjUc/AtGkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, May 27, 2024 12:05 PM
>=20
> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *=
buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	size_t fault_size =3D sizeof(struct iommu_hwpt_pgfault);
> +	struct iommufd_fault *fault =3D filep->private_data;
> +	struct iommu_hwpt_pgfault data;
> +	struct iommufd_device *idev;
> +	struct iopf_group *group;
> +	struct iopf_fault *iopf;
> +	size_t done =3D 0;
> +	int rc =3D 0;
> +
> +	if (*ppos || count % fault_size)
> +		return -ESPIPE;

the man page says:

"If count is zero, read() returns zero and has no  other  results."

> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->deliver) && count > done) {
> +		group =3D list_first_entry(&fault->deliver,
> +					 struct iopf_group, node);
> +
> +		if (group->fault_count * fault_size > count - done)
> +			break;
> +
> +		rc =3D xa_alloc(&fault->response, &group->cookie, group,
> +			      xa_limit_32b, GFP_KERNEL);
> +		if (rc)
> +			break;
> +
> +		idev =3D to_iommufd_handle(group->attach_handle)->idev;
> +		list_for_each_entry(iopf, &group->faults, list) {
> +			iommufd_compose_fault_message(&iopf->fault,
> +						      &data, idev,
> +						      group->cookie);
> +			rc =3D copy_to_user(buf + done, &data, fault_size);
> +			if (rc) {

'rc' should be converted to -EFAULT.

> +				xa_erase(&fault->response, group->cookie);
> +				break;
> +			}
> +			done +=3D fault_size;
> +		}
> +
> +		list_del(&group->node);
> +	}
> +	mutex_unlock(&fault->mutex);
> +
> +	return done =3D=3D 0 ? rc : done;

again this doesn't match the manual:

"On error, -1 is returned, and errno is set appropriately. "

it doesn't matter whether 'done' is 0.

> +
> +static int iommufd_fault_fops_release(struct inode *inode, struct file *=
filep)
> +{
> +	struct iommufd_fault *fault =3D filep->private_data;
> +
> +	iommufd_ctx_put(fault->ictx);
> +	refcount_dec(&fault->obj.users);
> +	return 0;
> +}

hmm this doesn't sound correct. the context and refcount are
acquired in iommufd_fault_alloc() but here they are reverted when
the fd is closed...

> +
> +	filep =3D anon_inode_getfile("[iommufd-pgfault]",
> &iommufd_fault_fops,
> +				   fault, O_RDWR);
> +	if (IS_ERR(filep)) {
> +		rc =3D PTR_ERR(filep);
> +		goto out_abort;
> +	}
> +
> +	refcount_inc(&fault->obj.users);
> +	iommufd_ctx_get(fault->ictx);
> +	fault->filep =3D filep;

those 3 lines can be moved after below fdno get. It's reads slightly
clearer to put file related work together before getting to the last piece
of intiailzation.=20

> +
> +	fdno =3D get_unused_fd_flags(O_CLOEXEC);
> +	if (fdno < 0) {
> +		rc =3D fdno;
> +		goto out_fput;
> +	}
> +
> @@ -332,6 +332,7 @@ union ucmd_buffer {
>  	struct iommu_ioas_unmap unmap;
>  	struct iommu_option option;
>  	struct iommu_vfio_ioas vfio_ioas;
> +	struct iommu_fault_alloc fault;

alphabetic=20

> @@ -381,6 +382,8 @@ static const struct iommufd_ioctl_op
> iommufd_ioctl_ops[] =3D {
>  		 val64),
>  	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct
> iommu_vfio_ioas,
>  		 __reserved),
> +	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc,
> struct iommu_fault_alloc,
> +		 out_fault_fd),

ditto


