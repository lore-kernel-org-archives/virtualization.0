Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E11474CF
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610417; cv=fail; b=orw6fE9JauqpvNhzs8peK8E3l+eEjsNn3t/gomzJpxUpz/D6Pf+lCzVv1M4HmICb2T9F2xPpB1TuPcoJ7OOx5J3WMMm6Bxe9r5BEr4jhgLUkBT5l2lJWy5pgYRfdQYhaxcOioSqpXCdisCW7/Gc4kIvUtTqU9UmQ+mTDXLVwdEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610417; c=relaxed/simple;
	bh=/NAgCFF1PcJ7Q90JxItz4sOMhfCVb3QWl70j4oaZCgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJWiwMRD9h6P0RQ8G7TowikI4fWIJ9dqIs74Ej6aIYKm1ASU3ivmpl06rPaUcoUiPHwusGVcV19be8iKC2Jl+cDIVJkY/DA55EWdWQvif8e9rUXekB2obJxFYXj3FcPzOEcO38RK/91yvHhyUAoDS82QPDCsZZ2jQ+gOU0zthDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZJ6rJge; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZJ6rJge"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7639760878
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cod-OOztw9Qq for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 07:46:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7C7EA6086D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C7EA6086D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DZJ6rJge
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7C7EA6086D
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718610416; x=1750146416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/NAgCFF1PcJ7Q90JxItz4sOMhfCVb3QWl70j4oaZCgQ=;
  b=DZJ6rJgeDMBS7J8u2OTfaIK+oRKSomXJN4qC1SbxcdvMcdTSchOXpR7Z
   h4RcQto/frTnBnpWPWSJySRCSmgpIUuZjJPHfwrhoj5yq3lNwFrQx7jvP
   LrVuDn/+lp00QdfMxgdJ1mOCgPM2xfmFNaF78vZ8udXMGonhRxs4mEcY3
   4y9phLg61bsR8A0yprrvLrsueeE5iifcBUAWqKt6ANTY1+9vwF3+AEjOz
   VEioGmUfyJImb8dh53P7qgjF3FDtCttqnCImWl95cDPSeO6/ygy9YHmng
   wkAUR/Cl28Eg8fnNEFNtoXb3boWpfDYbiYIErZxnNbBeg7poqy9gj3dHe
   Q==;
X-CSE-ConnectionGUID: kNheK2hvS9WULEdaHA9o1w==
X-CSE-MsgGUID: qrfQabS6T6u6pqRcKUejMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="40839207"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="40839207"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 00:46:55 -0700
X-CSE-ConnectionGUID: cyOyKlZpRla3+OXttIC92A==
X-CSE-MsgGUID: 3CfpAjlBSFefhwizCPrA4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41051740"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 00:46:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 00:46:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 00:46:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 00:46:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 00:46:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8999xgxWGGyK5YgDjGxrbKBm+Wcee52CBLE+Hv+kZZOd3BU1t9CjnBI5GQsBodM/3kR1bKoedWh56MveWy8pYzsvdMf39s1xFxyTuqHr50OsyJ3dQGNGNe+8hkKu9rwW76w2IH0xfKelMr+Hgw/vEJg5ml1wKSRHUJ1/W1xCkOLsYwmA3jC6CMgFGlLYrIPhCTBRgtTAyyKN27w4uZcv2HYJqENbdECqfbZ9jimPQlfa/vhn+rtGV9BGOYrgphpE89Gy8NZXthFV4i7idLEJcgkmc60Mwg9woJoICRrS0OWYaxWFySKRQEGAEFtwqB329iBjlEAocD3STho1gAZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NAgCFF1PcJ7Q90JxItz4sOMhfCVb3QWl70j4oaZCgQ=;
 b=KaAwG5VPiJwmvfACBybrCUEMhiXg6fU3nZWi/FMFYJ7Ixis50MqW1i1yGGWDxCGZ9moJfAYfQMp7hAgQbPVr5GkBSm4lXsX8u151QK1zjfsD/z7ZE6n+91SpT0ox1mRHchn8JenoTw7d4kFsqx18QyKsNBzzGUqvYhck5s6xzCIMJTelsAI40MqGghyD4A3ohBQmDJcjxogkrgqBgoYuv01NHDfdqdFYB1Z5Wvw8w8SZaA1hdnoirW9+Sk09v/Rc5PhlnAoJEv4kJPKC68tWyatdi5MA+ZqoabvfoXac2SOJZsXQZHnRNDPImTl2tCPNY2qXHJdsyZd7u4TVmS0+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 07:46:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:46:46 +0000
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
Subject: RE: [PATCH v7 00/10] IOMMUFD: Deliver IO page faults to user space
Thread-Topic: [PATCH v7 00/10] IOMMUFD: Deliver IO page faults to user space
Thread-Index: AQHav7RxBHks2DgcmEqu2PW4b2jzX7HLlWPg
Date: Mon, 17 Jun 2024 07:46:46 +0000
Message-ID: <BN9PR11MB5276C1D9AC4D3147F4594FF88CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240616061155.169343-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4662:EE_
x-ms-office365-filtering-correlation-id: 55b7c3a9-1951-4d86-25eb-08dc8ea1a3d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015|921017;
x-microsoft-antispam-message-info: =?us-ascii?Q?gal+3WpE+AaQHRFWW040kHLzuNHryuiMKnN89jEFuVIdTM4WXZfZXC2ZJC4B?=
 =?us-ascii?Q?Jh4RBDtpLFyxwNcMIVccdPoEKYhATqLGEWWmAG8UFtZTCxKRERuwSaaSvwy+?=
 =?us-ascii?Q?Z9fvRlRaSmsJIqSxH5PKIn8L1QTs5AnXbwQM42A14tmk0WGeFTzHj75IOwuj?=
 =?us-ascii?Q?TygQhXVTYtM6Y1I30WVwnMOr8MG0P53Y9zEydAi0sRgMjEi4OMrcZC/Ljniz?=
 =?us-ascii?Q?4VSsK5n2mg/wlZMWYSfNhWyd5tmx57UDKZAtPxxgHf9kCOsaBwCOtBVseCe6?=
 =?us-ascii?Q?2b6q5HpBiiiU02C81dCHSaqM69w+hHaMay5bhIob/vq1iw9YWb2xtIiHh2bt?=
 =?us-ascii?Q?ulxwL5TpaoaV45Ad43RhM6bIojpnYzmzTjh2EyEH72ed/Jy3j/vl/4Ri2hs7?=
 =?us-ascii?Q?k6cYnVtPs7MUDKB7EqfK8DtXgjFt6Hn2SWn+rEBIkmOSfq9mrD2Akia0f7fo?=
 =?us-ascii?Q?Az20vEGs902e8VxjPbr+OlqgxQUszhwKt6Gb6z7VqJGYeW1Rqzur98xJon0B?=
 =?us-ascii?Q?hljjvr4YWU23xcCwQNOEChmDcKjYKn2AL/ZthKk6qTYB+qaVKWhGvpvcReG9?=
 =?us-ascii?Q?myJnjpCh0hFlSEUfxR5At6SvsK+qfzwn2mnkfv+7thH2sc4lzPmVQr9Y4Xko?=
 =?us-ascii?Q?5GMU+ZrEblX5GkQLOlMaMhfNLuGVVydknZWWMdAdA+FeH0yb4IBcETk/xcg+?=
 =?us-ascii?Q?3Ird93dACwbLlbHPR122ti5nwN1JK5i9OlelK+liDSeUf3r0tX1cTNc0wP6r?=
 =?us-ascii?Q?EFwyIcfXpkXSlUrleJvoIauKP9namxDdTpQ8rxzhKjwfif+RCkiTTtUTdu5V?=
 =?us-ascii?Q?bxByg8iyjZiyaKwT/mIMaLVvrO9tPsqqPPY7oTZbaw2lwhEKG65qfmJrIrCW?=
 =?us-ascii?Q?BpoDayv9xIDtd8JEc7DE1Prh4NjecgTaXKZBnGYCgUL+/YwLwquJqxloRmsY?=
 =?us-ascii?Q?L8755KvqOXYV1lahsGcRCDoq86OjiCqMaxqvxPhBB/FdEvi2/kqUmL8vZYoh?=
 =?us-ascii?Q?ZbQEzJQv/Vflpiie2JSqcMhyZMqlp3KACqdyUITQuUqJB2dWHeI4KIOTUwdM?=
 =?us-ascii?Q?L6USfumTHYLqP9RS0VKyHBhv6qX5omlV3Tbnvu44yPCU9Cp9T4mHZhfXFIAI?=
 =?us-ascii?Q?2isUk/xPrhef+oNBm3P7RQU5pgKSnau0BEtQB/V+JcFfJ+nzaYV1mrwNA5m2?=
 =?us-ascii?Q?8aqPb6jxiREGsAHb5SgJ815gIPOd5dtO1z9tJFlB0w5nSrYYwrB4qvnyxkcG?=
 =?us-ascii?Q?jsVp0eK+CHVJICQ196qNPs6jskGQl3uL9zS8xwYNX5b/OHHYrNaDOUUWSTD1?=
 =?us-ascii?Q?HUxBBqgEps8cVhoQgI8UXStGxM5M6Zsf9UyaHnbrDyncRg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q/mwX+GBbFhyYKZhkicG46WGrdkj1Ub1HsgzZ8i1NT5N832yofxta6/wREFv?=
 =?us-ascii?Q?pz6XcZvb5Y+M2He+2kc1D1DSV+I6fDxUju4Gt13SFnxaas5Xckqb/Pl2+61I?=
 =?us-ascii?Q?POwTTVYxQHlS5IZwA15R+dO9h5FVeMhibQvv2oyUuVwWUJxKnNbSuOXbKcjm?=
 =?us-ascii?Q?2RHq1fPetdlSsCrAl6zA6yWzyWKZACb5by90eu+NP2Z9mftMf+S3AbVsDx6Q?=
 =?us-ascii?Q?Y0ZkjK3BGgxtCHBBm37nQXxOxu2QCvps0pGYHqnUz6MZnZ6ue0Is/4yLIyni?=
 =?us-ascii?Q?0ng+zC4pU9sZV92jZLTI//XdMUY0Sy+1OTbnFwaFdMKQ/UJjok7LAeXltfdI?=
 =?us-ascii?Q?hXov6QoqHdzJNMQyjZmuZNLIvwHTFbpvlLL+xFh1MO2iKFvTpVsZWdNDpAfV?=
 =?us-ascii?Q?4A3eJVMqin1QRMNrZNkjXw/bGgeYbDyK1WPtaLPT5yHU1JuRO8JdUUXMqknU?=
 =?us-ascii?Q?Oo44TVJ9Yo1NPFzGE+SEK+P+DCYpn0cA/YXvsVrp3cZ/aNjNpLpR1jddYeBm?=
 =?us-ascii?Q?1E6g/H1FRLNvY6C4+mhyybh3Khe/KGq8+tJfXauPB9lrNPED99IZlgRs9zti?=
 =?us-ascii?Q?7SA1j1EDPpJRQt36zKk4gF+J3Hq7j1HDL06eX/M4Fw6Gvt/Dgkqh1AVXHpdb?=
 =?us-ascii?Q?4O+gmdkLA3G82laaTIzr8pDAJA5pWc0VCBeR2YfaJucwJx46nJhqUIlJ6eeg?=
 =?us-ascii?Q?+CA2E7BK3bAHWLXSt0GR8oRqGQGHZS5uCbvzCOUZ1M9SqXIRQAWwyYOlz/rd?=
 =?us-ascii?Q?sc/lX4zHgnMNoeq4tc58G1l50RLuW0xcqIp+CivrdupOZkhxYEUQxgKW1QN4?=
 =?us-ascii?Q?h72IKIvdZJbNV6hJMhgWCAawjZDLoSnNIG52Oeig2mz3LX/8w0HgbqksTSoD?=
 =?us-ascii?Q?uCv30lziYg61RXBifxHrXNHmAuKCVQ03wxZt5xk0cT23Lhvh6L6iouAEQHn2?=
 =?us-ascii?Q?ImSH993p0ej5DTllwaEn5arsK3a02q4T7QgVvKEdK/DtHl5LhEeFlLBjfpTx?=
 =?us-ascii?Q?y7H6UAyzliG7jv4hj/8LlMrGTJFw0ZOo9QN738qDipi+0VgV+4RYwmKynrdM?=
 =?us-ascii?Q?TrV73Lh34qqm+37mrko+6Cc5mdMeOONGXJlbNe3aFk0lcnBEMKzhXqX2hGCh?=
 =?us-ascii?Q?eifSR9G48EysLeAvfP3WI9a6xM324Hr1F74SFMeXQkWH0eBFBR5G4Lp+CoCS?=
 =?us-ascii?Q?AipwG7BDLIkLeWEuZYYC2+KQFoHiJ9YstsOmCMzv8PoDXdTAbceUmyyCkf2j?=
 =?us-ascii?Q?GtqzQb48OxJ9oi8NtSsbQrUN3Z/lVrPkom0vJD9CJUnFju/n55KqN/l08INE?=
 =?us-ascii?Q?agQwAjFI4DooxagGBSrCUlkELBHHtMBDzcXaXt4F63qLsJBVuB3ZY6OpH/lu?=
 =?us-ascii?Q?t0hpO0yVeibcrdHiGeMuloLNtpcidWyrSIqyDUpB+qkXB9neFiu/iBTGmf0i?=
 =?us-ascii?Q?2fH7jJQ7klXQt3mY8eaY+D83f3YyXXer6fQY7T6wWXtVsOfNrF+68jKwG63B?=
 =?us-ascii?Q?m1CK4LSrEFqirqoegVzN8J2T93OrKKkycn6OSphh1DdgjhC9glP0dJoRhFQm?=
 =?us-ascii?Q?ziaFfxEJxznf4qICVQxJ0DfjKAx+gzmcWVaJ4DHt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b7c3a9-1951-4d86-25eb-08dc8ea1a3d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 07:46:46.9321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iPdb+ArN9LHksdm7dpG2NVZAHvTCQ2JJMLdhE1d2lajCcvv8UiVCq/9u/AdSXBaXwQdfrgFmPYmr0oyX0yqzVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, June 16, 2024 2:12 PM
>=20
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework. One feasible use case is the
> nested translation. Nested translation is a hardware feature that
> supports two-stage translation tables for IOMMU. The second-stage
> translation table is managed by the host VMM, while the first-stage
> translation table is owned by user space. This allows user space to
> control the IOMMU mappings for its devices.
>=20
> When an IO page fault occurs on the first-stage translation table, the
> IOMMU hardware can deliver the page fault to user space through the
> IOMMUFD framework. User space can then handle the page fault and
> respond
> to the device top-down through the IOMMUFD. This allows user space to
> implement its own IO page fault handling policies.
>=20
> User space application that is capable of handling IO page faults should
> allocate a fault object, and bind the fault object to any domain that it
> is willing to handle the fault generatd for them. On a successful return
> of fault object allocation, the user can retrieve and respond to page
> faults by reading or writing to the file descriptor (FD) returned.
>=20
> The iommu selftest framework has been updated to test the IO page fault
> delivery and response functionality.
>=20
> The series and related patches are available on GitHub:
> https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-
> delivery-v7
>=20

for the entire series:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
