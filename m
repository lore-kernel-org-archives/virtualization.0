Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4042C136
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175110; cv=fail; b=Xa/gwNahR+8zlgyPZ5mak83kqzFwOG7o26q5Ot9pTZDFTChdDFuNFGaJnByxja3beTtDi8ohzL/BGtGZx7/X0+8iONrKDxFyL5X8NEwxE3oVMdVP3O9okg1s8I7CKeGCsjUgzJdgkqMuxrfh6iXf9I7Hm5OfUu/Qspl3WH9kaqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175110; c=relaxed/simple;
	bh=S46P1lJ5WGfkPeNRqlhtwwB2Pn07oEnWfIiytaTNLEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=faksOahVpxOrC5YMAzJaXjhqdgDqmH0QXxc3MIXzllF0Kr0CO8DcZ/WPABZAjLf+OGG06x5QyRMA4N0P5UAmETby0jyOjUoxbFaoNVsjau1Iibj5sYdVALO0kJrdm6zB3NrTijAgJubvdLCSpZb5GKpMT1KHuMTqz8IkoOEpfQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQrqsxJX; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQrqsxJX"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E6616070B
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:18:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q53ZY_WAicmq for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 03:18:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 85206605A9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85206605A9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WQrqsxJX
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85206605A9
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716175108; x=1747711108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S46P1lJ5WGfkPeNRqlhtwwB2Pn07oEnWfIiytaTNLEk=;
  b=WQrqsxJXa2UDA/0cJKFNg5WhlWRwggJPrsUQ9A21lXdsIQMxCi9IN3W6
   2RakaO19qcjubyEnAnO6wx61FLLbNJAauWxkRaBVVXDRsfsWCzpAPYSi0
   X1+ZARFfPB+X8+sp3Glq6ADjndycODkrodxzAucLn/LE924f9Ve8qF24e
   UFx1m3c80xHL/bQ8CtulHJMhiIn/tsjJRI/s7QAGCDvPgpEuBvEQ4tlED
   8g27V09FmQDv5i/wEHeVAZSSFeZaXn/RMfvDk3PUQBR12JpPJVxtDGmfn
   FHdaX88QmvrIshM4ZHp8M2gUYQHpYnJghUNHl/mfDPsdIBYH5lMA9g5HU
   A==;
X-CSE-ConnectionGUID: Duof+jRhSx6v5CkuoZ2h6w==
X-CSE-MsgGUID: UjTMA0AiTvC0hGwmFHhc3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="37663371"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="37663371"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:18:27 -0700
X-CSE-ConnectionGUID: FFzgdT0FTD2wgtek0PeysQ==
X-CSE-MsgGUID: m2cChMntSQmuRQULbTwseg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32411094"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 20:18:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:18:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:18:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 20:18:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 20:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3Mvx0ojhHOQYWF1TqsrmPeCPp1JK9t9hpab9p5iBtvUk/P38889jgJ38VqBfjiB1+feuGjRP/cZ8roQuaIZtcHFAL041Joj8QLnHwvne7PhSkUL3ox6yY8jQb8HdWNMF2YRbGQSRTqBbPJK2pNC0v8k/6IvUgXBm3xO9cwsBSqsgOlKK7c1G1zUMvcCOMlFY8P+WLk9QWKSrD8LiTtrtRfZd3UIowekuwXpf++V5N/6t1chCokeukbJrxBPwPL6ubU1ctKZLrwBDpPi3seQNHQmExcoJvpNNrQukubZbGpMZkHozqICjWLjb7o9+xFq9dQ9N7OkqeEsdKIJUJ16hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S46P1lJ5WGfkPeNRqlhtwwB2Pn07oEnWfIiytaTNLEk=;
 b=ks6HKmBnzhf7bW0FUXWl/7siROuLbz6b6eY6InpiZwLfCiTGKDUws3FziQlCGZbFzDH408THftrxKJaAlpvuBOVTqdJSByeSiZDsLDw2f7+OOSl93mB5hWVKhS4zXC1y+EjY+sLxRlxB+epghGPO744Ux9S26KCL4UTXkX81QtycTKfRfjpfe+WmaQgY6SHSXIimtnnirAEJteQtTnPBVTOW0B+M+cJH4n/wBYrfL2+zZVaMk92NpNaiuLCKEOlzu5I82zx31K6uKnBm+H0MIwyEhLCS3q4bQ01q75aEfRDibU6BH98l8HUXTMb8R1lFsLQ91SlHlel1y5qatBNdqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 03:18:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:18:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Thread-Topic: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Thread-Index: AQHamw8ANEvMzn0R2UW8NGE5Cyn6fbGX+hRAgAZ6ZACAAR4YkA==
Date: Mon, 20 May 2024 03:18:23 +0000
Message-ID: <BN9PR11MB5276F144491F6916D992B32D8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527615219EEF0EF3EACCF38D8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <604d8d9c-6b9d-4cd3-91e7-79923b044472@linux.intel.com>
In-Reply-To: <604d8d9c-6b9d-4cd3-91e7-79923b044472@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: 9d61d62d-88d2-492d-357a-08dc787b8205
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NEJ6L2hRaC8vTTFrekoydkE4SHAvTVNDZDErMDFjcWVKOXN2TVdjRnJDZ092?=
 =?utf-8?B?WlRobVNFQWk3bzk2aStuZmYrSU9yb1cvWGg2VXRBSTNpQWlvMzJ2TkdQQ0ly?=
 =?utf-8?B?SFdPZ3BaMHhCODIyMmJRVlErRk9XcThGUUI0YlJ6Zk9VdGdjMVNrM3lBTWpY?=
 =?utf-8?B?QkJjUU5Ua0ZZRlJNL0tYRWlWWUJjaEI2dUk2ZFJKSTlES3k2ZENkczk5WG5r?=
 =?utf-8?B?MDFxNzNhSEFBZkw3ZUNpYUp2ZWx3ejFSdTIwS2llNVhRdXlOSnI3NGlEVTJU?=
 =?utf-8?B?K0loeURvSHB0VzdMZ2U0R1hpdFJVMUxlZGs5YjBlN3d2OG05NHZSbEVTMlg2?=
 =?utf-8?B?SWd1ZmhMVTF6cG1TQjExOGcvem5sQ3NrQk9HVW01YUdhQUJidTVhK3RvZkls?=
 =?utf-8?B?K0VmVUtPRFlZZWpqVkIyVC9yVFhTOUZzL3JVWlBSVzlIYXdWTG9JK2xOZnBR?=
 =?utf-8?B?MlhleXdVWkZmaWdoM25YT0tERG9tdllDdlhuRmRMdlZmVWpPa3JZanlXejZn?=
 =?utf-8?B?ZGEyeVdqRTRNbUdHRXhyaDY2UFludHNSeXZoVkJiZi9BZ0RnZCtuZFpmbTU2?=
 =?utf-8?B?RUdtTjRYaVMyaW13OEEvQlVDWVV2ZkxvUlE0OEorSEJRc3NlN2dqNnJGRGNB?=
 =?utf-8?B?V21LQTFoQnFQRnJUZGZYV3ZUVm9Obm83TW15akU4dm1hclZBakFOSTJhcnp0?=
 =?utf-8?B?U3AvWENLcXpsNnhKOU8yMW9YMEU2SDRZM25RQ0xteW1mVE5FdTdvVjR4QWxO?=
 =?utf-8?B?YkJTK0l0YXZGOHRxQ0NOS2lnU3dKUGZOWmFvV2VxWUdEa0p0N20vZnlFVHNa?=
 =?utf-8?B?MWtOMFNRSDRDQjZYOXBVRTN5T21EaDFvM0Rjd1A5WkFpTmo4OTJqUlpENDlX?=
 =?utf-8?B?eGxuSGdGTk9rMjR5ZG9LS012T0tRK1Myd3NRR3pEODVJMnFVd1R5TE5mSEt4?=
 =?utf-8?B?VGQ0RG5DTW5obGVWelVPMlpDMzVaRkJZcUkvN2FvZUZHYzZzdThPOEExbHZj?=
 =?utf-8?B?THpiN0hoS2hBUXpKREF1Z1hjajJtZVR3ZjdJS2ZJN3oyR0paVFpZVGdEN1J4?=
 =?utf-8?B?elowQjY2UXpqNHVmaUhsNWZDQWxNd0N4aDNra2dxYUcvMjlCYWtyV1JSNk5i?=
 =?utf-8?B?dmhYODE0ajdiL3lZSVk0VHFPQnRRbnFVSHNWMC9CNi9SK2RJVnNxZENmcSt6?=
 =?utf-8?B?UWpBVXIrNDNMczNRNmhFdndpakpuMDJJV1pBSGhXUFVUenYrSnZsNUVQWmFt?=
 =?utf-8?B?d0NjWnRKY3FZb1p3RE9kKzJKS1JXM3BwdTM5RXpONVZlOWJ6d3pCQTFNd0Jo?=
 =?utf-8?B?c3RpL0M0VkM0b0N4OWwzejFjYW1peXk0aUdEaEluYjVpTS9hQUdvcmQvUk14?=
 =?utf-8?B?N0M1cVZOUWVYb3p5THJkMWt3ME94eVU5VXpHZTI0QnJVYmhBa2J0ZHpTbG5W?=
 =?utf-8?B?QUN6VHZXQnZXNk4vVWpoR2FVamhla0dteFlXa01PYVZpYjVBdm1UbklyYXJq?=
 =?utf-8?B?QmFkZGU3RndVdHlYUjFTenAxcTVCK2c4ajNRalhNbXNUS2F4RjU4eExGTm1G?=
 =?utf-8?B?QWtDMkRld0I3U0lVaXlGK3hRMnZ5bGZFVlVmVUEzamR4QURrOTBGNFNlUHZF?=
 =?utf-8?B?SzA2ZTZpQWx5VzVmTmsxSTh5Wk9hUUJOYzJUOUxIQUhpeEhzRVcydXh1L2NV?=
 =?utf-8?B?cXp2aEVDUWRPcmRZS0tiOUpBTHVYeUl6OVFoTVFIZE9ac3l3dEpWWXQ1VVIv?=
 =?utf-8?B?ZnBxODJLbHBpUWxSYzgvZWg3b3RsSjNiWXhZMG9WeDBOKzV4Vlh3emY4eEZz?=
 =?utf-8?Q?mEVRBltKYhrXlhc02yveoliwqlHDZd9NRHcKU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THBxMzBVckE5MExsQlIvTU8vaUJHOGk3ZUZteEIvV20rOEJkWTRvN3pjNFVM?=
 =?utf-8?B?eHlVS2xOTHNLOU1RVWxLWWNiWHFIaURrU0JScE1FZWgvRnptZE15Y1JKWXJI?=
 =?utf-8?B?WVhMT0R5UlkwU0ZOWXFpM2xVOXpZNGxJdldpNDFSdFQ1aDgrVDNUK2VrMzV5?=
 =?utf-8?B?YVAvY1U3OEFTOFhlMCt0bEN0bm0rbmRrMTdFNUNUS3l1VHVROUtIL0NkNS9u?=
 =?utf-8?B?dExPQ1lhRmRXZU43bEdQN25BSnY5MnZBYmlGZ2JWbFExZ3ZCS21ZUXRPcTlw?=
 =?utf-8?B?UGJqSmdudHQzRnVqRTRlRXJSdjIwVHk4aVppMjQxWUwwVk9uTWZqbmhGTzY0?=
 =?utf-8?B?ZDNwWlNrK0pzc3FvdGdFMndYeGFCVGJERjJGUzZFSkNUTXUrNXJpQ0ZBbjJC?=
 =?utf-8?B?cEdsL0h4T1NBb0xZSzIyeVBNaExGSWZXdlZjdjkyUkpuZ0hvK0FUdlRGNWZy?=
 =?utf-8?B?N2Z4L204Mmc5Q3BqQzlCeWNxYkFUdXNBbWYvc0pBeHRGZDFLN2hoT0hZUW5z?=
 =?utf-8?B?Y29FbEdUOFJwNXBId1VpUVI1a0JoY0lsbzNhSXZnaUNvY3lCR0FBalA1dTJP?=
 =?utf-8?B?N3N5OVhQOHhxeEU4dTlJeE1aZkNBM2JUUW5vaEw0YisvYm9lM3hYSS8zQVJo?=
 =?utf-8?B?R0t6U05oTk5xVUhqTzNZb0FvNjkyVjhMSUsxTzVoTTkrVlNva21mNlNxOVE2?=
 =?utf-8?B?ZTMwSGMzM3J3TzBwanNFeSt1QzRONVE0RkVSdUw5TjVrSzJSY2REbEJ1UmNK?=
 =?utf-8?B?MWV2ZExBcXV3KzAyRk1PZlo5NjIxNWthdUZPZnpVNW9iMFBHOWV4QitCSm5S?=
 =?utf-8?B?TjY0SUpVWVFPcGVwblJlZmtJZjlHRzJUK2pjNHNMY0JNM2NhTzRMdzhPSW1M?=
 =?utf-8?B?RlBucmczMFFXRU9TRTB3eVhSSDVJOUpaVkV3bUt5b1o4SURQa0loR051RXB6?=
 =?utf-8?B?c3dzLyt6TVdsZ3RhUEwxQ1NBRkYzOVphL3k2ZW1VSWRHRVg1U1hxd3FXbkth?=
 =?utf-8?B?RTV4bGtqQVJ2amo0L0FIWExkOWkrM2pZcVYyajVQQm9SVXdiQi8yTmxwMWFR?=
 =?utf-8?B?RUhZRFY1UkZ3SXdENERTclFaa1lKdGlFNEJWeGFHSDl0b2E2RE5FVTZIcWJI?=
 =?utf-8?B?QkJrRHl1K3RycU5oMy9qdktxUEd5WUFBb3UwQnVEbDlLNFNFRjdGbVNlR0Jy?=
 =?utf-8?B?R25ma3Yza21WeTBWR1NWRmhmcjZpRW53VVR2MFBDSjA0bHFVQTN2b1Vib01S?=
 =?utf-8?B?UlNpR0RZT2Mrdnl2Q1RValVUV09XZ25jQjRuL1FkcXE4a1pqb1VWRDNoZk44?=
 =?utf-8?B?Q1ZLdjZ1aEhxemZQL3JxYUNheEdVZTc3OUpBR1lFckdZTDI0VDFud3pKUDdL?=
 =?utf-8?B?dmt1LzdzSjN0SDJ6RlBucGpFQXU3VW1Ic1JFZDZ3L2xyV05uZ2NxbHdhVmdI?=
 =?utf-8?B?c2R4cWNVTnlWUVN2VWlLUXdGK2ErdnlMNEY2T2pLQ0VxbXZGbUpzTTJaRXEr?=
 =?utf-8?B?TllYRGtwMXJVb1JPYm1mT0hsZWtBNTdtdk9wYkM3cmpBRkxYcnQvcjRaY3NM?=
 =?utf-8?B?S0pqelJaY01aa1Bacm0rdlo2TVIzQ1BHVE1CTStCNmhMMUhoOFNUbE8zaFQz?=
 =?utf-8?B?RzhONnZGeDJ1QnN4czlveDVRYS9JNUdPTlBNVGZuSk9wdktJd3pQRE1MSHA0?=
 =?utf-8?B?N3hSdkdydGJvRXh1YUZUVmIwdmpnd2g3ekFzWml5cHVXY2w3clRXc1J0WmY2?=
 =?utf-8?B?RzZ2NlhTWlFIRE9uWTlWVWpXbVVaS0tUUnhXbVdYK3ZudnkvaWxVM3JPVG43?=
 =?utf-8?B?WGRtd1BRN3hja1JpLzdIVTAzWldEWnI2U3lic2dwenlmb3hoclV0V0w4MkJm?=
 =?utf-8?B?T201VUZxSklaTFN4WTNTSFM3U0xBMSs5OGdRWFlCZldVU3VvK2JTOGpwcnZG?=
 =?utf-8?B?ckR6REd2dmVJZTF3WC9FVzM1a2xnVWJqeE1xY3lPR21sT0dtbUYydFpSTXJW?=
 =?utf-8?B?bDFWck0vcHZwY1RIemM1WmlkN0ltazArZzIzdlpsRnlXRGdNVHdNamx4c09l?=
 =?utf-8?B?aVF4RmlmTjlCREx3b2FiK2hXTmxtQUlkYnpreEZKY1N5OVo3dXltUW5JOVIv?=
 =?utf-8?Q?mDl0CXMs/lNNU6MnDIvjget7/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d61d62d-88d2-492d-357a-08dc787b8205
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:18:23.7350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfD1mZMS4sfrXPg7pYgVQhEKEvUxj7OSBynhiwlGx90tlwfrOcMosOKktcZ1omiVx1JWkJPRjTSl7vxbO/ogfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIE1heSAxOSwgMjAyNCA2OjE0IFBNDQo+IA0KPiBPbiA1LzE1LzI0IDM6MjEgUE0sIFRpYW4s
IEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwu
Y29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBBcHJpbCAzMCwgMjAyNCAxMDo1NyBQTQ0KPiA+Pg0K
PiA+PiAgICNlbHNlDQo+ID4+IC1zdGF0aWMgaW5saW5lIHN0cnVjdCBpb21tdV9zdmEgKg0KPiA+
PiArc3RhdGljIGlubGluZSBzdHJ1Y3QgaW9tbXVfYXR0YWNoX2hhbmRsZSAqDQo+ID4+ICAgaW9t
bXVfc3ZhX2JpbmRfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1tX3N0cnVjdCAq
bW0pDQo+ID4+ICAgew0KPiA+PiAtCXJldHVybiBOVUxMOw0KPiA+PiArCXJldHVybiBFUlJfUFRS
KC1FTk9ERVYpOw0KPiA+PiAgIH0NCj4gPj4NCj4gPg0KPiA+IHRoaXMgc2hvdWxkIGJlIGEgc2Vw
YXJhdGUgZml4Lg0KPiANCj4gWWVzLiBJdCBjb3VsZCBiZSBhIGZpeC4NCj4gDQo+ID4NCj4gPiBl
eGlzdGluZyBkcml2ZXJzIChpZHhkIGFuZCB1YWNjZSkgb25seSBjaGVjayBJU19FUlIoKSBvbiB0
aGUgcmV0dXJuDQo+ID4gdmFsdWUuIEEgTnVsbCBwb2ludGVyIG1heSBsZWFkIHRvIGFuIGVycm9y
IHJlcG9ydGVkIGF0IGEgbGF0ZXIgcG9pbnQuDQo+IA0KPiBUaG91Z2ggSSBkb24ndCB0aGluayBp
dCBjb3VsZCBjYXVzZSBhbnkgcmVhbCBwcm9ibGVtIGJlY2F1c2UgdGhpcw0KPiBpbnRlcmZhY2Ug
c2hvdWxkIGFsd2F5cyBiZSBjYWxsZWQgYWZ0ZXIgdGhlIHN2YSBlbmFibGluZyBvbmUuDQo+IA0K
DQpjb3JyZWN0Lg0K
