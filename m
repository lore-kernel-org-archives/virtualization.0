Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708371C862D
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646231; cv=fail; b=Xjc6EbFHHIB+G6fuBaApLM/P3OVOkd9Pc8jshXc/8ULLi1v5S0Y2EBV9ScibQ1TGAtBFBc+Lp3Uq3Mf5zixF9TJgdaA6FHEYnX36HB7+/z2Qaoum952SdtjRj6TpKaxK1YAk0LicQVJsGkcUhEo5icaFN2ApswN98g1Dy5+zcNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646231; c=relaxed/simple;
	bh=KhPUIBOKy4q3Z37LX4G2JOnhjo442K9XvKHaAVtrrAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p6r/X5H36Z2kQPRoZkaGqK8Jt00S4Jv8m91ztUxZoJQcWX/w/d23yFhOx/e3JV7mEtQV+nIINYQamjKNPnv6oNxwH3tgC4MSgDFl1qFbnX+7pDNBfsM2TAaGJHduMXMcIUcnDVduYOs+9dUBikfQUC7SC5B/bMcekLsxP+49j+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dc1d0n6G; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dc1d0n6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646231; x=1805182231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KhPUIBOKy4q3Z37LX4G2JOnhjo442K9XvKHaAVtrrAk=;
  b=Dc1d0n6GiK92akunjqDT9JB1rg9myvDeZInw4S4YvPchHoAzst1E2PI2
   w/vdAp2NdHRFemBEBG74RB9sGzwQSje7BX5/qCPSgrZq+lDh23SQD5ct8
   /jyBAHQnlmzsodYiyAb19n8thqAvaknzx5k62g6qexBntEP9Ex47vyx5T
   pE2pKaID2ti/oT8mqzrCZ3btkU0SQtqPtkbijFYtuNnE6U4vMVyjvGBCl
   qHynR3Rowlrj7xPxBP91FJv5Wa6GBvGPL3WpuTB6WiQDyxtDzO4J5BiLP
   ioMykgCh4Q9hsLnRo9ipgAZuBhMngZMx+24r1W2547O6sW/M4WfZyBSMa
   A==;
X-CSE-ConnectionGUID: c8+4XgMIQ5m3Ya7k2y5I6A==
X-CSE-MsgGUID: 9K/Pkw54S6m00vWjW0wT/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92039418"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92039418"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:30:28 -0700
X-CSE-ConnectionGUID: OZqKjtewQu+PUuhHc/osTw==
X-CSE-MsgGUID: cd/FORNjT6+dGhss0FS8ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="259728854"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:30:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:30:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:30:21 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:30:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuecZU//WC99rYcBiSc6RvYLYh8XF2QdIcfJpvxjubLtTE2bv/eAXGxISPicW/vXFEaErXgbvjFHbcJh2dLw80XVM67AqLU1BgrYiY6sNK1cjBfQWre+ye78k9bIADwkEawVP1ZUoGkhw+TI/cJoN/UAtzugxeOsSC3XGLJydm/aX9NbANmWY7k/HyaH2PjxOgm4FTIch/uElRCMF39kACpIfKAAdQY4omZlwxcctLVgnwHvMbmd+0I5RlOx627pvl6sZJa/r/5ZEmDgSDc5tSmY/ugEAeswRB+OOxM6q0RGqWPMBPU4HL2YCuHumWkIqGNE/aT/AWrwhkBLMDWHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4MEukFqXNOu2kOaoGaEsEd48iKXaPelNIUbrMSvVho=;
 b=ghfDexpRDWnLgYsdxRMeAFrc6ohqvr2SO9aE/wG0Te5v4HdYgigSs4BoDLEQLWLwxbxkBZ0KoooXhtTsz4zPe6c2+yo8Z2kHCMY28Wla0Y6I4BYVF4NA49teLsnILNpevjjgDnFkTANnpMyx/JBioOGCJV4a1DVrptspd/itSiS/gcaXFOzncxZLYrB3dsi5S1F0wilCm8RuFtMGCtkJRddrY4CrYae0xNX0q1bFvmVic3vlk1iT9QYFq13ucGUJpUno5KXsbRwkRcpIHgAkAITRwoKBST0pjRbYIBVehfr/dWtEvbfQbjZA1QtpyQ2SYPmc1JRhnlm0bkOvnZPxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8560.namprd11.prod.outlook.com (2603:10b6:408:1e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 07:30:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Mon, 16 Mar 2026
 07:30:13 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: I Viswanath <viswanathiyyappan@gmail.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "ronak.doshi@broadcom.com"
	<ronak.doshi@broadcom.com>, "pcnet32@frontier.com" <pcnet32@frontier.com>
CC: "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 3/7] virtio-net: Implement
 ndo_set_rx_mode_async callback
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 3/7] virtio-net: Implement
 ndo_set_rx_mode_async callback
Thread-Index: AQHcs+B/oQoJCPx1skOVugBJykPqQLWwxZ0w
Date: Mon, 16 Mar 2026 07:30:13 +0000
Message-ID: <IA3PR11MB8986B6D7E32B5477FCC51E9FE540A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
 <20260314182809.362808-4-viswanathiyyappan@gmail.com>
In-Reply-To: <20260314182809.362808-4-viswanathiyyappan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8560:EE_
x-ms-office365-filtering-correlation-id: 7f1525d9-9c07-4df3-78ba-08de832ddcf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: dzY90ZIA0ou/4/l/YTfda0ltNjfnJxcF4LriEtdce4ZPgBbanLCnUNJ7SSonD0men8CMEZ++3yj+33Y0CM+nsrBQCbsV62jAud7RHUgPCrfFWPWt8up3BILdcxSi4ZED5LQdL7RxxB4yCieBYJlhtC8kjBl88ze2m0DIpojhW9qWOMdzZcwg4bncAdnFO2Zt333SpKaFnXlihrXzI98utQ2gUco9Opr8+bqQV2eqYbQf9nBhgcws9BX2wNi+sq64I68iFhonKDJ/GIL2UeEJafpj0qt3rfXhYyWrsiGFJVfVoSRTHrcxydwQH3wPc2p2eI5wfpiZxaEkfv92+iKxjYPEGDRDYJ93+GNB/+SSsecwdjoPwrzVPYfDbSXKgu8NLDq6K2d6Bz8tTyBzfPol6mDC291MUch56v4kERtMEAK5ZjRW45k6/JPf2O9atCGXSan6yscVUIxwxiqFXLS7FU+q5Htxj/O1Vx90CM5VDEEz1QLc1ag3Peuydqo1HMosfK4dxuGhpaqX+KFVnEyZhbADmUlqbl+Y5kAqoPsTky2qqqU1mJ8wL3GTS+QUadeiGZQJvruEWkMAQReEfK4TX6EKtCASlZNLjEl2x2Ogk6+gbczAxNCsvcMWRLVws3LFRzczugCOP4H3leZ/b4L6C2QC7IKLUJg335AEoZB42pRVuznMiikPWJN7XHsuL+vPNxPFkpATW3kOrFr0uNEtIVhB2P8sAVAuWDJy4EsLOBNlVcGrmb7lju9IDt8Ihr/WFLwcYPBkpjXAJBwhSFCXbP1O88SRAM1AfuHrlLD11XvULVm76G04ouo+6d60jtYf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1TgtwwkM1IA+zAoaL7qz7W2EG8pBjuWoKwvpy9M7GE6dZ1X31bRGAiOb8oLK?=
 =?us-ascii?Q?mL4RlcUmzlPpySWgrDrFXUjmvVcGs0eJWtSwYMWW9oTm5GEuM0vyTnk5i3xW?=
 =?us-ascii?Q?0EdyulDFFEj7M96gE/U+vm4QcOFVrdBDitoK7NtxjffXXfAdZe7WdBG1NP43?=
 =?us-ascii?Q?xjvFQWmBfiJjkiOySnoIpCUmDsEq6++kh059Nu73jsyahGYRM3tD+qzR5m1N?=
 =?us-ascii?Q?nrITUMZ0RINqSwcmkRLfKUW6h6kCpue64Iprx6m1h/lPCewCZV4rEowweihU?=
 =?us-ascii?Q?418y/ysnXzf9hicUZIBBhDjjwRDrFK4iN+Kwg8Lxt63ri0c1JWZram7NeFJe?=
 =?us-ascii?Q?ToCxaodToWuGpXOQ0JTskppqIKJMmqfr5nkbsoi/vOW/meYttnRsL2BlfY9/?=
 =?us-ascii?Q?ZFu1hPD17MP5MouY4XBgjyy+8RDSAjmJsRGpBYvrSCq2aqH/XdD25qtZa0y3?=
 =?us-ascii?Q?uloRpxokU6MuLiJE62SZHI/SAtL9AY2Jmf1MYTbQ61U5m050sm6j1qfFoXdw?=
 =?us-ascii?Q?QCJE+cFNfno5wkx2Q5DznOym7An4GybaAVwllvNsvOgrijjvcfVdrhrj18CE?=
 =?us-ascii?Q?V7DJwPqTOraed10CniCzz3QzfEZUlQTmieTdmlvs7VePVhWjo7OpiVCSjMod?=
 =?us-ascii?Q?ygwvRn+tju5lINUnWfh7v9tzp9WndVVfFz1o2JP9zrkGlMeb1nS6Z5bOHAic?=
 =?us-ascii?Q?sal60SDy1wYw9InpOopVHSj4lYi1V3gy450+hWrDO49zhA7gH85fzN35GuCB?=
 =?us-ascii?Q?7S8aCs8XL9uPCE/q+sJu/MapYjTeekuIPtnsRm1P2Sm6V0/MBaXDcCQXajHn?=
 =?us-ascii?Q?ysQtv3/zlA+odiDMPU1ECthTG/PSaG3KkKURL5M/sBlBQuqy6uwnWamsy3Xz?=
 =?us-ascii?Q?jGx1xD833tzKx7J3kBXbwiyAaQQSTUA0zklhM6aXzPk3iHhjPDNPH8KjVrTc?=
 =?us-ascii?Q?QWDJN8RJC4guG20LlIVbKmwORRl5p58WnOmchTf1nl5iy3wd/wKJUGgxuM1I?=
 =?us-ascii?Q?B+Do+VRVJMcw7JVGq0+j2WsbmyuGpscx8aHhW2+9HW0ilgTGV/HW+EpS/vIm?=
 =?us-ascii?Q?61H0YCFgKJw2lQdOTsTjQ7eSUcpDf6aYbBnejNd9jt10OoiUKUg0jDGsv1OJ?=
 =?us-ascii?Q?HOcICtwaLL5tBPyWbFTLlvuYLZbaTtDkDzqQqtDGOgJ/P7fMj93znPuoSbZU?=
 =?us-ascii?Q?XR5QT0yrynEmwiqdCJiq1AC+koP0n0hUrZLVNihHr8j9Kxv2UmnfHInqeIqq?=
 =?us-ascii?Q?BzujVQ7UPdN3CWgsN4e6bT5O8WONjKkT+9ysOhO3hPceweLFrME6CTZKclug?=
 =?us-ascii?Q?o4DlJobRTKBhvov2UIXFhjgFQNz3K13m7prrSIdT7Yt/73RDW4CntvZsoprH?=
 =?us-ascii?Q?5jCRhnuJ4oxURQlmctivaoD1QTbpSsOtI5NpNZlhTkXCW5wi7wdJroIwirBu?=
 =?us-ascii?Q?DaA/uQukDTZfZZP/1fkMfnkZgIWBsHYCO1d8hJ4nxTUr/anitViDmzDsf5mE?=
 =?us-ascii?Q?SW10+UfxY2ztsHIujHmej0is1kmn7MfM7NM0w2nKlA94KnYRe02lN1c54G/L?=
 =?us-ascii?Q?AgnTK/IdbA6XRvsKvMkCeLstKw+DU2hvROr5pQmsCG3fO9H2l+DoP2oI+DIP?=
 =?us-ascii?Q?Rl7KE03YujhYZGmNsrcNX3pWXXZbd674hmT49ifr4Ku091Q7yuL+0BYktoHm?=
 =?us-ascii?Q?5WJAycKXM3fwZp9gF/wpSEKVUQq58TpXn3kvPNFRXcXFzx11wkyDcjrQ3XM9?=
 =?us-ascii?Q?wYPmRNhmbXtLwxz8qOxat5Dq/piZvAU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JDJM1B2B7x2AXiJfhM/Un8TY5eYngmH7naxgHBWBfmy0uC/c2/1+RRMIopRHiU5TIuOe9yh4/bqU7wzyRxUIrGDXxJY6fp9fNKkCyJX5RGd4FZ/xV3AERssfNmK0UzmNnLu33fb6M6AUHKKSbqHPddE72qmEvAhWGbmb35JiOH6MgtPSa59OOs3tcrUJhUg7Ac0JaYq8PeTKudqCbfw3gdMR9QTyjtPaC1hFKXsbx6ZSD0tO8UA6POhsDlMzomCKzztLqv0myYGm3pCxs6T7uD/I2Q7JydIQ4sxyDadYTSXI5D/HfP2dVSDGrfVqh5eDvR+2MUiWNp/wkDAa9TcVPw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1525d9-9c07-4df3-78ba-08de832ddcf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:30:13.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcBD8CXUcr7kbWdnP9UcVT6K+uZBHslnpqhl+dXMCf3hMXWYjf9Ts3if2cXbFtfG3ZMGoeqydjiHobsziAYqDnUKxqfKzu7tQQXV0D6v0lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8560
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of I Viswanath
> Sent: Saturday, March 14, 2026 7:28 PM
> To: stfomichev@gmail.com; horms@kernel.org; edumazet@google.com;
> pabeni@redhat.com; andrew+netdev@lunn.ch; kuba@kernel.org;
> davem@davemloft.net; eperezma@redhat.com; xuanzhuo@linux.alibaba.com;
> jasowang@redhat.com; mst@redhat.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; ronak.doshi@broadcom.com;
> pcnet32@frontier.com
> Cc: bcm-kernel-feedback-list@broadcom.com; netdev@vger.kernel.org;
> virtualization@lists.linux.dev; intel-wired-lan@lists.osuosl.org;
> linux-kernel@vger.kernel.org; I Viswanath
> <viswanathiyyappan@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net-next v9 3/7] virtio-net:
> Implement ndo_set_rx_mode_async callback
>=20
> Implement the ndo_set_rx_mode_async callback and update the driver to
> use the snapshot/commit model for RX mode update.
>=20
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
>=20
>   There are no calls to netif_set_rx_mode in virtio-net
>=20
>  drivers/net/virtio_net.c | 85 ++++++++++++---------------------------
> -
>  1 file changed, 25 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> 811b90da15a9..70255d09401c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -448,12 +448,6 @@ struct virtnet_info {
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>=20

...

>  	}
>=20
> --
> 2.47.3


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
