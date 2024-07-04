Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8971A0B09
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075064; cv=fail; b=Up5KQNrWVal1GdZ2uoGbkoqeWYEKK1C9+hIcJM3Z//kFSaLmyJTOyw73TqcVmv3cgWeAaUcKudIuARUE0l+yseeppOagNm3Gclqqqx0rKXaXm3R/FHPkGDke8An/q+HAizmKnogpXLv5coUfOC3GQMQGus82M1+98Vu4Ciknyno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075064; c=relaxed/simple;
	bh=1N7xbQJ9AWw9lxoolaiPQMdw5FrKi0vjuLTTXC8nSb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7x0FDjBfUxZP0kdVSQIo7whR7CracmZOaCd2APTVAS9K9FgIA877y0AJUNFjemhcAiwr1pgCDIMQ28+Ix9OatbEYDC+r5SMLzT3zBvncB5dlgSmccyWjkKqRKcWQT218v4uNqq2pNU2JR0QQIDAuQvO12z442TQ57dHb5bDUxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXNwHENw; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXNwHENw"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C7A5846F3
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 06:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vGnFxfqF4tl1 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Jul 2024 06:37:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4CFA1846F2
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CFA1846F2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cXNwHENw
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4CFA1846F2
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720075062; x=1751611062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1N7xbQJ9AWw9lxoolaiPQMdw5FrKi0vjuLTTXC8nSb8=;
  b=cXNwHENwnG0yfi4qOqUXsEIyuVRKplcKepW0y8o4mgkMikie45Bn9lV0
   KoUcZLg0zNVXrDbMimcL2YNnaUtbrK2egpbE5dWXXGHnctMp1O3dUP0Jj
   LJMktDfbRQA1JAKogUiGG6KA81WC30k4yGo2icPRBpx1wbke6cnYfgAAW
   ASiIaXDqB30v6k9qjssBWyf0F+/mf80HEMS9TsPJiYl6BuroMQws65x+U
   Bh7xPN5wnL2A6BsTzTelKj7Uhu8nfQIXz9Wro1Vyxk3sWyqE43H8ZM/0x
   ygglX0oc0gTFeXPfmp4xHBbXpa1kN8v+UDryOLY0zUxF6wTdWN8dkpU8F
   w==;
X-CSE-ConnectionGUID: kVR7JBBxRbGRhzhdKqdCKA==
X-CSE-MsgGUID: 7Ym6v65wRrysZRvZJVgwBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17171560"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17171560"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 23:37:33 -0700
X-CSE-ConnectionGUID: 4G+H0brmQkKEMz9x58hh2A==
X-CSE-MsgGUID: FaAHkOdaRKSaOM25e6BYyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51670110"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 23:37:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 23:37:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 23:37:32 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 23:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTqM9ZI6gC68RbejEmfDwQwDfWYF6G3GFEWSjOj8PxW8KjvS+fgi3C1QpSQow1LmQEnjJUSOr7F9enwV4xG+eQneGI6Wc5NgZAIJvql2FXljNYg56SLiUzG5yMfNxfy53CM4q7vfeZRoqlbUhDol8YkPqCjch6cszAzlPKF7pVCg8EZ+bf1kPBEIzV/tDxHdH/yo9qYrm5QriEAr4Z5+Xb96hVmyOzG/z3NqoIgIf7AOxadMKU3x0yKuTACv4Q0V2O5v0+zIuR6z6+RofEIZxHkEwl2ZVq2H9gtsVXCwecABMJs/kWcwI6m6l772ucirCpufqAWFqPImeirlrSc5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jn/L3FyBgmCafUVXqb+YeIXREInmGGg6gLQ9omd2fwQ=;
 b=L9w/L0melHLy5r1mnwOxwN3jiHquX/XxlbmWC7M9XyhM8C+9mHOTAuOvlZ3use2IYK4MBvIrk8k7AkfZqTcFB+jr1gMTLE9+bC9ogf45tP7tsfnPP3W6LGP0PB3ABa30+zKk3ch2qkbZnxKdGYddnHRqcADGl3c3KxCcQaWP9okbvMFE5PCCJV6ccPiD7PnSH2aFCRWthVmjRKG8Pwqxd8U0c677cI6h2heDtFvUF9kMGxsmH2Ax9lAX9581waiW2cWxHg5YdBXA7pOSy7GjO6rnTsj3QGCnqVoNRNpWrNkbs7+HgaRdtg/KHWeyxmXyp5PiIA/KtS+trnkg6ZuCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 06:37:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 06:37:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Liu, Yi L" <yi.l.liu@intel.com>, Jacob
 Pan <jacob.jun.pan@linux.intel.com>, "Joel Granados"
	<j.granados@samsung.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v8 06/10] iommufd: Add iommufd fault object
Thread-Topic: [PATCH v8 06/10] iommufd: Add iommufd fault object
Thread-Index: AQHazEpuGCgtLFWT+U2ig4MVK/B+ILHloqCAgABBPYCAACvCAIAAD2FA
Date: Thu, 4 Jul 2024 06:37:29 +0000
Message-ID: <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
 <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
In-Reply-To: <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA3PR11MB7535:EE_
x-ms-office365-filtering-correlation-id: e45dde74-8a8b-425f-fdb5-08dc9bf3c6fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?D3bT7yvqtpUwmi6vOfMAyCAxqrCHaQj+TbKJrb0c8wullHxHZDTB+UqEAx2H?=
 =?us-ascii?Q?lIDWGXJFXrvMwn+cEOHYH4vkcOcrY7v3JaMZ1acgF2whu0JBsr2MlRV1Vomu?=
 =?us-ascii?Q?Sj8zxI21LdDzPc8nDqmVk7t9PYWFhXG1B7iWPdw87awTflGSg8OmMoqAd1UT?=
 =?us-ascii?Q?AteU1ut/9heP/9QJIYXwCBs+ifQ5Zy5QiSxcYfvNVrqPz/WVxiXnlEevqZed?=
 =?us-ascii?Q?hahAuQficd4JBGDqQnI5R0p0uKk54sPvKDsP73bHmZZfwMrRAGRIc9LFQpt/?=
 =?us-ascii?Q?pBnUoC1fhxSZpY0a4QTsET/K2lWnwX42yp7sfanma9qvPa2lvevNGSh4Bho0?=
 =?us-ascii?Q?1eDX7MhRCfBDK1aEPROz6ViUMH93T5NTgLZI9QOoP7VvnM/GGQRy+jNVCZoP?=
 =?us-ascii?Q?Y2G1Ma8KbeUUj2h4di21j9yINccgRPVJ5nwM3I5Ca6Z7ORqCLOcLJKQoqtr6?=
 =?us-ascii?Q?2wVu58G/MHW0oD32ZyIAJmYLYTin5J6XLX/23nvN33TnEEQa3HlX2QOMcBdO?=
 =?us-ascii?Q?T3kM9jRi8L5N6pyllb0DocAGyJ5/HNCD3m3t5qEpgSd4EjY1mFd6J3Zgaiid?=
 =?us-ascii?Q?DTSdhKuzor4zI2zAnZsmRoLso8XCe7Y93BGFKIOBILmXA4kDlr4p/u+4hN5x?=
 =?us-ascii?Q?lQ3TgFZltOg+Bjsa4rIkzYLY1Q/fcmROj6vJJQL8t+DJWFGgk8QcDC6lVePZ?=
 =?us-ascii?Q?RSq1ixrjHigzsq+dLUF8gE8CZ1yE0Xq8woz1D3seOFAjhqHdwr1mYuny1NfG?=
 =?us-ascii?Q?zhXMLqlSgQbT4nGzdywQx/xOLM9O1beFhgN5zI9G9l+1pDimDRm77QLzLocY?=
 =?us-ascii?Q?ElaJPTd7dbG/NL/zeZMQOhNZwOeML9RajmShJld6xSX/Kyz+UVHicSqIUUrX?=
 =?us-ascii?Q?pSDL9U/h9yYYQS7kLD2b0ihJYxWfpm55Ret7428y9Jr05YAj4ijfOQbT/o/5?=
 =?us-ascii?Q?kjFDzcNvyhBQwS51GjvBUClDd/StNP5NYe/03HEIfC22vr3fVu1u0AULFK5S?=
 =?us-ascii?Q?EYMVJGJwBGxWfJWnjhqncYHBC2iGPK5JJ4M6ZaHHCjXzSQ0i/sNL6aUaamRn?=
 =?us-ascii?Q?Vm7q7dN3sMM7lNlchIEFUjQe/MdC3vrNPOouz07dwbySUhur8o1jY/5ZWbDg?=
 =?us-ascii?Q?Qa7IZswRXMPQYNCpcnADrsZRYOGTyuon/n7w2vzAv1anrg0LLZxlh9z4TyMa?=
 =?us-ascii?Q?p7VUIqX8lfLfymJIRWF/WT5xHCHxAXTzIzWmt3BaGduhHuc1CBHR4W1yxl0w?=
 =?us-ascii?Q?5JxtU/PmeQ2DOLsHcNuUBucX15Thx7cFv+bL+cQo93HRVhKgAQGGcc8mzy5D?=
 =?us-ascii?Q?MWT4r31f794B5RYmtaiU3qj/Hlh/rE8tRRgnPWQp83Eo/ZbUIZ87dM2Swjnu?=
 =?us-ascii?Q?wllKMQ55VXOUIQ8A8Xk8eVh1bjweDimzY9ixRn4+HC0iYTflEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jMuPhAtFkRJkorxUkHqZpVxYZwMd/HKTCrMTn1dYFSVP1d5pAmA7CzKjnNUg?=
 =?us-ascii?Q?M77FLJvquboQcX3zKuJRlXn37KbxYVlQOQGLQuxkvc/o+ocdU7WFNqlixlYh?=
 =?us-ascii?Q?IzXdUffdOMgE3t5iZEnyUHJT4z2xeCJEDflvwg0ch5W3Zr+BtyeEzhyFwqnE?=
 =?us-ascii?Q?tULLDzuIGfikLmlFTRgk8+HlrBhwa6S75ngHXNNpwlx+41X+NST2BuoYNKQt?=
 =?us-ascii?Q?XNjt0D+8i1qnNmovG0YDG3cLawkWBRI29eWnzksBcgFhBzYdpxpMyunycV4G?=
 =?us-ascii?Q?jECvDEkSA+vS5Szu1IMuPD9pZ5aOSjzo4Jkck5x12+PJQqsqSx/vd+kJFO0B?=
 =?us-ascii?Q?Z3Cu2NlUPOSpi/LQeftXDDHYwkkWkIdbmf2956vsuvNctJBj/tc50YoxDjUW?=
 =?us-ascii?Q?QvbnX7bjdVU+dKDoYrzmlsXwbzoblypgMAMAfpf14gIwS4WdUco7J2tTXtwL?=
 =?us-ascii?Q?YIEy+sBonb7zJmDZvqqnbANkdT4LjQiMJKdQvosneAcF0ruoC2XdQZ7MUVI2?=
 =?us-ascii?Q?TGQzh66uGT71jZVKKTVwImTQHEsSP4jbOquE3lxUSDy7gatHxmj8hBd8opn4?=
 =?us-ascii?Q?e0/rtITJBCwxHM5lRoCe/LI3PZ4rnBAMZDBnVSKz6h1JvlNa7HckKohXQRob?=
 =?us-ascii?Q?m5zIy0S6KoJLfjmbCmyDhgdxv6HXFdFqQS3oNMLYVDnoENdSf/y1XbIbPH1d?=
 =?us-ascii?Q?M66CPTJlTUV65TJv4i3OkEZ6xs+xnjYFppUhwrsz6v2cd0liUt9dItK9OnXr?=
 =?us-ascii?Q?HbENleCFh5iVtGWOZY6jgHc0r1LyzAVOb4deJ/UavlQOL7RQV+rRW+I4nQ9s?=
 =?us-ascii?Q?zZMYw3KgNNJ/pp7OxOaN8NFcXWTpURDqZRPy9Km366NaqNtzWyLJZY8Fkghh?=
 =?us-ascii?Q?ReflJdQMh8V12czDS1KyY40YTeQqB5iIsDnRCzMdyJXuDC04Xc57ZXF3yd36?=
 =?us-ascii?Q?K60zGjh3HVerfDYIV/Lj9kDnK4u6DU7H0vVrf4xTWSUONavLoe9RIOiW1YQ0?=
 =?us-ascii?Q?psmpQSpeYVcRYMOGSp666xPuIxeQ37lOJo+AfwWkoG9wkvsSBVoi/VsWOGYb?=
 =?us-ascii?Q?CniV8EQU636Lcbcgl873r5yd3902MHlIU65ExKQ4Aa6H8ydZrD4ju70IcVqH?=
 =?us-ascii?Q?cU72KEiFeQS79AYOwXBJFmvD6KfXiJi86zUSxXT0JQEulb+c4m5oV3gosarV?=
 =?us-ascii?Q?1Q3oRcrachQpCEk5C++HBlzW9zXrcqq2ep8G02IxC2pJyxIejpEw+nWZZVzv?=
 =?us-ascii?Q?RIAaBCRY5iTKwcQYCFXE1JIk/BV4JCcCmnr/WtgGPLLLyt8ecyLh+HoCc4f7?=
 =?us-ascii?Q?9+1B4G3J5j6I2vSfHNHmbhQ0wjA6aIkOAYal11vnmpfUSza/lbfQxsKxI3Wk?=
 =?us-ascii?Q?faWTxMkFdDuGLdsphV0svcHIiBeggyGdE3Sghf9je/kiaICJ2Unn4oVeMkUz?=
 =?us-ascii?Q?T9jUXDd/D1kkgnQ7y8SquH5dTRvUySw7hB8QbJ84rcBdY7pSdWLW1Ls2ee0C?=
 =?us-ascii?Q?mMG21lVgDsS1O7CXt4rJiH3LrZ68GBwrX94ouQKBE3aeksgEbxBuxBQ93O/f?=
 =?us-ascii?Q?TcYKzzXJQP5Na/SKj9QZV1M3FrB7GvyQPKnWxfGk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e45dde74-8a8b-425f-fdb5-08dc9bf3c6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 06:37:29.7435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01xc15nM1gOYKxz9mAXd/JsL7m8s1mf1Z09p6Na+b11+QwOiL9opCxdLDmCRonsUfs47xoJ0AAv4tOwP/AHbHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, July 4, 2024 1:36 PM
>=20
> On Thu, Jul 04, 2024 at 10:59:45AM +0800, Baolu Lu wrote:
> > > On Tue, Jul 02, 2024 at 02:34:40PM +0800, Lu Baolu wrote:
> > >
> > > +enum iommu_fault_type {
> > > +     IOMMU_FAULT_TYPE_HWPT_IOPF,
> > > +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> > > +};
> > >
> > >   struct iommu_fault_alloc {
> > >       __u32 size;
> > >       __u32 flags;
> > > +     __u32 type;  /* enum iommu_fault_type */
> > >       __u32 out_fault_id;
> > >       __u32 out_fault_fd;

and need a new reserved field for alignment.

> > >   };
> > >
> > > I understand that this is already v8. So, maybe we can, for now,
> > > apply the small diff above with an IOMMU_FAULT_TYPE_HWPT_IOPF
> type
> > > check in the ioctl handler. And a decoupling for the iopf fops in
> > > the ioctl handler can come later in the viommu series:
> > >       switch (type) {
> > >       case IOMMU_FAULT_TYPE_HWPT_IOPF:
> > >               filep =3D anon_inode_getfile("[iommufd-pgfault]",
> > >                                          &iommufd_fault_fops_iopf);
> > >       case IOMMU_FAULT_TYPE_VIOMMU_IRQ:
> > >               filep =3D anon_inode_getfile("[iommufd-viommu-irq]",
> > >                                          &iommufd_fault_fops_viommu);
> > >       default:
> > >               return -EOPNOSUPP;
> > >       }
> > >
> > > Since you are the designer here, I think you have a better 10000
> > > foot view -- maybe I am missing something here implying that the
> > > fault object can't be really reused by viommu.
> > >
> > > Would you mind sharing some thoughts here?
> >
> > I think this is a choice between "two different objects" vs. "same
> > object with different FD interfaces". If I understand it correctly, you=
r
> > proposal of unrecoverable fault delivery is not limited to vcmdq, but
> > generic to all unrecoverable events that userspace should be aware of
> > when the passed-through device is affected.
>=20
> It's basically IRQ forwarding, not confined to unrecoverable
> faults. For example, a VCMDQ used by the guest kernel would
> raise an HW IRQ if the guest kernel issues an illegal command
> to the HW Queue assigned to it. The host kernel will receive
> the IRQ, so it needs a way to forward it to the VM for guest
> kernel to recover the HW queue.
>=20
> The way that we define the structure can follow what we have
> for hwpt_alloc/invalidate uAPIs, i.e. driver data/event. And
> such an event can carry unrecoverable translation faults too.
> SMMU at least reports DMA translation faults using an eventQ
> in its own native language.
>=20
> > From a hardware architecture perspective, the interfaces for
> > unrecoverable events don't always match the page faults. For example,
> > VT-d architecture defines a PR queue for page faults, but uses a
> > register set to report unrecoverable events. The 'reason', 'request id'
> > and 'pasid' fields of the register set indicate what happened on the
> > hardware. New unrecoverable events will not be reported until the
> > previous one has been fetched.
>=20
> Understood. I don't think we can share the majority pieces in
> the fault.c. Just the "IOMMU_FAULT_QUEUE_ALLOC" ioctl itself
> looks way too general to be limited to page-fault usage only.
> So, I feel we can share, for example:
>     IOMMU_FAULT_QUEUE_ALLOC (type=3Dhwpt_iopf) -> fault_id=3D1
>     IOMMU_HWPT_ALLOC (fault_id=3D1) -> hwpt_id=3D2
>     IOMMU_FAULT_QUEUE_ALLOC (type=3Dviommu_irq) -> fault_id=3D3
>     IOMMU_VIOMMU_ALLOC (fault_id=3D2) -> viommu_id=3D4
> The handler will direct to different fops as I drafted in my
> previous mail.
>=20
> > With the above being said, I have no strong opinions between these two
> > choices. Jason and Kevin should have more insights.
>=20
> Thanks. Jason is out of office this week, so hopefully Kevin
> may shed some light. I personally feel that we don't need to
> largely update this series until we add VIOMMU. Yet, it would
> be convenient if we add a "type" in the uAPI with this series.
>=20

This is ok to me.
