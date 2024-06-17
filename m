Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E392D1862B0
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609575; cv=fail; b=BNttHd4COno5igQQnS6lPd95MtfqtSiWK5/xW+Kku7f8sVOpXHgWF/QCRhZu68tE4WVyP+cCDQGb4bdkW3vx8QAXr1W42mV1E9qinzLWnQMCMF/n4r77o521oh8DIZsAvo4F+U/dzNpPJoihKYof7T7xufNKBOjqacWaX0m1RHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609575; c=relaxed/simple;
	bh=evh6ZNIS6j0v6aUV0u7m5DwmpCv1OW4W3YD5+3Vvg10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNh042unWix7syRlWFGtt6/9i1oH9kW+EKkxfHyqL/8Kao2q4fZ1911C1P4Z81rYr+3KwM37BzQLKV3EKKw5avc90BaKYsSuv/lvW7DWZEi0ZRGJykaYNaosHRmIwA5zTmdYzACgafwJ4oxkX3+/UDqIlePr9FY0csP279RtPdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arVUSMQW; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arVUSMQW"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 639C96087B
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:32:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rDok5GCQEHvO for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 07:32:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7ABF76086D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7ABF76086D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=arVUSMQW
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7ABF76086D
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718609573; x=1750145573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=evh6ZNIS6j0v6aUV0u7m5DwmpCv1OW4W3YD5+3Vvg10=;
  b=arVUSMQWi3/Hqo+Bp4OqsZuxhCpRBy7VND6lV6wyXB/hgiNcYKNJDrVc
   4q+r+DqRuBYbMVkE+j+IFs83YbSz9Xb3aU0XE9kqAc00M8V9sO+OZEuTm
   t/dMmYoTX4cs8p+fnKwDjoKFt0+8eX2M8c754hhwwDHq7dAaRJarga4R7
   FuV8qiE68/XJRHDX+tibh9zhk91wvIqapd/4lJdp33bEPg45cw/9lMkra
   Zsbd7sIUl+hrDFNnQ9HvBa8/mjCsdIXo/oLvtr896xHYyvLGZ+St2uP3J
   fDGWOrIYrZZbX3jeqDBUUOiYgugQxlQIYNfagkUD3Fg/UKo/2bgdwTXBz
   w==;
X-CSE-ConnectionGUID: tNtcVd14QWSXPY3bB/bWxQ==
X-CSE-MsgGUID: pccEMz5vTiOwGA8obDUBug==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26055797"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="26055797"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 00:32:47 -0700
X-CSE-ConnectionGUID: ClCy2QY2TziEvYhcJYkmnA==
X-CSE-MsgGUID: rytL5quYQV+3Xzlh7LJjXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41056923"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 00:32:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 00:32:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 00:32:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 00:32:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4dpcxDe+o2Wp9aVZrnCctbPgPdxIyYC5hhYnvRJkooXeDaLzHNGOfspHTm2xJP6Ho0zONvH9r4EByi98aT6FeDv5CiQRwh/Fzs7u4ygUCUElVZuXmIHEpZKF9JRqxIPZwTTWfqmwm1SQgMrx7qkvqckmMXqUPLjb0HJN4LG1wDGBeJFBrMogz8tTmABNdxHFW6k4gC8NqcaGSq9g7uwoUy342zU7DAs+qp++ySb0/V5ye9lE3myFciIyOhbjrMkr6WWij/Th5lO3ATAjQgTRH/3pkCtRk5N5qznxvkxQCaSBZGKEYgijC7Q2mg8fLMVihZugdIoKGcoWZ++3B4mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evh6ZNIS6j0v6aUV0u7m5DwmpCv1OW4W3YD5+3Vvg10=;
 b=KMdWwYF5DMn78Cyd8ZK5ESn88SUJmHhfmhCUWCX/qpAuBaBEtDDbbw1pZUU5OLbxru9YSnyBTjdujmUfcOyiIskUSQmxX+57SjUGKTUgacfnVZGVRZlpjrf8KHBPGgv+2QZsWhHmBtAnz1eRikKoI8cjwXOP+grXErduNsPX4biyzkXH9URH6euoZ9kbSjqA6b2iggdOALPUzjVTtp1dynxNeb5rFKaILj4INl/oMvyQ0VrZdjbeydzY9d2z0WvnKYZUUzWriI9I0mJAGeAsWvQun+pG1BSbfjft/rzmaza9rMuAKU8PyZG5soxmET+7bgpbfzbNq0g+0P4cHr/37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:32:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:32:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Joel
 Granados <j.granados@samsung.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 06/10] iommufd: Add iommufd fault object
Thread-Topic: [PATCH v6 06/10] iommufd: Add iommufd fault object
Thread-Index: AQHar+txwPSPp6CyskanS/lKKehznrG8EfnwgAglwACAB3RPgA==
Date: Mon, 17 Jun 2024 07:32:44 +0000
Message-ID: <BN9PR11MB52766278644CB92F7E195E988CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240612132358.GU791043@ziepe.ca>
In-Reply-To: <20240612132358.GU791043@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4783:EE_
x-ms-office365-filtering-correlation-id: 2d654227-9197-422e-3fd9-08dc8e9fadc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?RnBHakkxb0VhZTlEUnYrWnJIeU5MQ2xNWUh4RVNwV0pEVC9XZk9mYSsrZkxV?=
 =?utf-8?B?N2hwdW1COWgwdExTY3AzcWtZMnFJTVZWNE5pNTlUNmhWY2dSbWxRQkx2VS9V?=
 =?utf-8?B?elBHeSswU1VNTUd5bW5IdmNkZnY3Q3g1SDBrWm9pamdUWnZqNGR3R3RUQVIv?=
 =?utf-8?B?TEVtNVNhdjJmbElsbWpWalNUSVc5aFVwenBtWG5jZFU0dEg2RVQ1TDZDNzg4?=
 =?utf-8?B?bzVtdnkvWmV4V2llZ3VLRWFacityaDNzTERkT2cydUgvUXcxWklsMHEreHBF?=
 =?utf-8?B?WXVzM0ZpbTlJYkFiN3RyOGlPcENsUTd2THllaTcwMHIrcnFJait5T29BS0VZ?=
 =?utf-8?B?aktNeUxpdENUdUh1b0tiK1l5ZFpFT3NQUzhrM1R4TXFRWmhnOU0xaTF4WThq?=
 =?utf-8?B?TW9waFluTmExY21yTDFPTjJnWkdwUE5oWWpET0o3Y0dJcFJvS3o4b2p5RGd3?=
 =?utf-8?B?RVV1ZDVQVXVNMEtrRGpGY05WNThyb1BLemZGSy9uaWkvdi94TG81YUhBUTJ1?=
 =?utf-8?B?c1U4MWcvR1RyejBveUxZSHFjNnJCOHRqeTQxN1NQMUwxUE5vZ1JuSUNhS013?=
 =?utf-8?B?VmlpZ2pmcG1BSDZ6SENBV1A3eUtRdlJzSFZ0L29QTWdSN3pnd2VtK0hkS2hh?=
 =?utf-8?B?VU9Ib1ZKdXRHQ1lkTHRGcXY0UFdDMS9CWE5DK1NXZjlQdmhreWtXN0FjeEJh?=
 =?utf-8?B?eno0K1lycHFVRWhTTEk5UUpKZTNERCtPOFVvSFVLOGF2ZGlwajRMYVVzelFt?=
 =?utf-8?B?RU1wTUtLYS91YlZ2cjBiakJCa05vbWRkZDg5ZXN5dnVRamtmME81M01TeG4v?=
 =?utf-8?B?ZDViVlpGdTNPOVdoY3BYK2JPbGwyWklXaTgyeUpqeCtHYm1tR1JhWkIwZDhS?=
 =?utf-8?B?S0drNXZjbWFPNTJvTU01bzkyMWE3ejBENUhLZlRoU1FKZHZFUGxMVXRWa3NM?=
 =?utf-8?B?R1Z2d3Q5WStPQmxwa3lCTi9aQWczYm5FV242Mk4yUUlNaFdmRHVyMDNTN3l3?=
 =?utf-8?B?anZxeXBJV2xhaDlwamtyWFpGbmRxVjlIYjArc2p6eWRQMWQzampkSVFYMHdi?=
 =?utf-8?B?d1lGR0JqRFVuRTRDWlhxWUdiRVFHT1pTY1BzaWNHQmh3aUxRY0FPNDl0aHhO?=
 =?utf-8?B?ekVIWkZZNXlTZUkrNDJPR3U3M1NPeG9vVXhkQXRLbVVZZzc5b1drRTNUNG1Y?=
 =?utf-8?B?aHhiR0IwaEEvM2l6QnorQkpsNi9nMFd6aFcreUxZc1ZacGdEZmxwUVEzSWo4?=
 =?utf-8?B?dGlBS2hPMzhZSGRuZU9aQW5XNytEY1dDRWtPcnpSL0luWkFKU3FNUUtXN01K?=
 =?utf-8?B?TjBqVDVuT3RrTzl0Z24vTDU4RzhPQmxaWEdqMVltb0VVMjlaaTAwNmJMUFQw?=
 =?utf-8?B?VFlmRk5xVzg4QWI0ZjlXU04rRnUxRElnUUdlQTBmY3RMcjRPNklpMWdtcmhI?=
 =?utf-8?B?WW1jQWt3U0gvZUNRMmt0RXVtQjJsTllqOWt2UU1pbmluOGZJcDR3Z2pKazRB?=
 =?utf-8?B?ZXlrODlEZWVMTWtHREQ1OEJoVlFHdDlaQW9GSjdPbkxzRFIrS0F2YjZUckt0?=
 =?utf-8?B?U2oxZkZMQ0ZobTg5bXI4TFdrcUE0bTlqc0lpMkx2elBWM3VQY0JTYjZrTUNB?=
 =?utf-8?B?YkJEQ05Tc3lidnVGSGRMeVoxRXpmSFM0L1VXUit0Qmd4eFpobUpHcUMvdzZT?=
 =?utf-8?B?a0hBL1JKRTVQVVdrTTBpY0J2a1J4WGplRm9NOXltb0dEZ3d4dm1iQUkzMm9Y?=
 =?utf-8?B?Z2o2dzI4a3UxR214NnAvb0hVTldhako5alFaQTFGZ1hEbE9YZTk2VEN3NWVM?=
 =?utf-8?Q?iS1MpW0jXbbuej5QFsakiuO8Pb18BVJSi0li4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW56dS8zK3NHU1FHb0laZ293WmZVYUM1THVYeTVSSGtkYU40SXA5WVh5ZjFM?=
 =?utf-8?B?TmJjM25HU1RzczlrQWJoc2JJU3ZVRmlzcEpPM3owL2RkRTJvdFNvU2VlMWt5?=
 =?utf-8?B?QlEwT29UcnhtN2tDMncyVUM1K2xlZU45S2pDWG42enNnYUk1eE5SLzZmUXo1?=
 =?utf-8?B?MkhEU0ZMNEhEYWg2dkI2VzNYK29uZzFPNkFNUUNjRjhmcnJWbno2T0pyMExl?=
 =?utf-8?B?Z3J0Y256cTZqMHhVZ3l1aURFUGhhSktRazU1UEhha0NjWjVtRTNFUlRjZWYv?=
 =?utf-8?B?bzFKNUNpYVpqZXlYMGg1UThYdVk1WFZXc09LdUxZY1BpUUFUMk90bExwdTVp?=
 =?utf-8?B?V1BzbERScHpqam9uNzRaeGFCa3ZUOTFXanFHcWhma1h5UWdiNWxwcDdQdlYv?=
 =?utf-8?B?N2hrMzNKUEYwS1BldFhnWFJicEl3WXUxemcvYXhGQzFVVDhabitOZzhKcDA0?=
 =?utf-8?B?cnVSSGo1N1N1aS9VNWVSRisvTGRzQXBUdjJKR2hOb0hmTGVDVDBaWDk1WVF2?=
 =?utf-8?B?UCt4Z093OFNqdW1UZEpES0V2b2xmaHhnc29CY3ZDQ1NzdHpubkhnTkgwR2VL?=
 =?utf-8?B?KzkxTElpeWN4bUVqMkJsdzFwUXpkck9ZOGZKT1R6dGEzbXVLMW1OQWZ2NUQy?=
 =?utf-8?B?T1lmU2YxOVpJbmlKOHBOb1hyUDk3TUowOHBuZWoxM1FuQ1VqY3JZYU1Dc21L?=
 =?utf-8?B?ZlQ1ZVRjV1JoNlVIRGhRU3dqUElNRWFmR0hIaDFjeWZNRFdybE1JWEs0ZlN2?=
 =?utf-8?B?ODY0NEFid2Q1VFRJQUlqVmw1M0cxUGo3aU9PYk9MeGNWOGFicWg3TWNuOTdL?=
 =?utf-8?B?RldtWDRLYlB3eExSVUM0QS9qSWhvWkJaY0RYWG1wS1Q0VFhsUHBtN1ByWFJM?=
 =?utf-8?B?cWJwcGpMbVVzNUlnTlIyL1pjd21OTXliSjkxSjRUdmwvVlByVlh3RHpsOVpT?=
 =?utf-8?B?WjdRWVA3V0N5QlZmZ3RBNkZnb3dPK041a2NGZG1tRDBvMDFaeXY1cGVqTFVp?=
 =?utf-8?B?Tm1yM0paeE5EV3FVNWhkVXkwbnRBempJQnZ5OFV1UVlXTzMzRlpaMG10UlNt?=
 =?utf-8?B?MXp0cFVIUUdydytCTGw2aWpvc0szdUFqN2tGREZqYzZJZUswYWdTaU9UcWRo?=
 =?utf-8?B?bEhkQTNhZndDWGNIcDF3alhzQzVpalVhdWx0WlZuR1ZRbk1tSTJNQlhERXZG?=
 =?utf-8?B?SUQzRlgydDM3YUo0YzB6MHQ4QTBiRHBheDJXT3dsZllTVmJORng4OWJBWGk4?=
 =?utf-8?B?NGNQS2EwNDZUQk5KVkYySGExR1hWbExPNWRmb291dkNSRFFyWm9mdnZZSzFX?=
 =?utf-8?B?amNUbG9zeDJjSGxCbVIwVmdaUFZGdnBuN0dyQUVsNURuNzV6dVlzMnU0UFZm?=
 =?utf-8?B?MnpqYzV2SnVPVGZsNEF1VElVdWxFcXYycCs0MHNsYWkyemIxZ25KdGRPVGJ4?=
 =?utf-8?B?K0k4VklMVldDMVpJMGIyVEJmajRUTDc0YWpPTXhGMUsvNTgrZ3FLaWlHZFJQ?=
 =?utf-8?B?c1RZNlpFMXYrcTNOUWdIT3owVnRZWlgwU2Z3UWh0cG8xU2hDQkNBdWY4ajhh?=
 =?utf-8?B?NFh0VzNPMTdSQ0xtTlJ3U1NzMWc1RVpHWEJvdjZSZWU4bk5lUG5wUTRjQnV2?=
 =?utf-8?B?RG05OHU3ZzRwRFQ5V09XOVBMMGJKbHpsNWJLWlRTdmFJUXo0Qk42R1k4TXhO?=
 =?utf-8?B?Q3FabEIzTERaVzJSS0o0alBUa0NqRUFxcFYyeFZHRXkvK1JSR2dUanZsNkJW?=
 =?utf-8?B?QWlvRVZ5cmxRWS9qRWc2dmwrZzF3TmIxM0Y1Mk45M0ZsUWZ2MkdiUjZZaGZ0?=
 =?utf-8?B?aHh1RFJaWmdnK3pVS2EvdkZDNlhBeWNnVE5ycFpwS3NXZ0Urby9LVXBWN2Vr?=
 =?utf-8?B?bW1kMTJYR3NCd25jamJSQ2Y3MGJmZ2hwN3RxNzB3dFNDRnV1TGNRcEhBYytZ?=
 =?utf-8?B?Sk1JYmhCWXVsVHJaazM3Y1pPU0ZZWUxTNnBsREw2U0xWcHNTS1VaOGs2cy8v?=
 =?utf-8?B?elRVN0cyZlowbGl0UlpsRUJpUWhuQysvTG9WaUdOdlJYcTgzL1NVWkNXbVFi?=
 =?utf-8?B?UEMvb0toTzJYaHJZNmgzYXIreHdPMUZFYzhldW94WEo0dlVyZXlFdWtJMzRO?=
 =?utf-8?Q?1Xtx6POG9rNmZ2vBjvTXqn70v?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d654227-9197-422e-3fd9-08dc8e9fadc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 07:32:44.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 581xyCf3XzToBu1iMnJ6YrY04lFuZ7ZPNM9NMXeydAkOP2PhEKb5l9tDySneL4kiJ5AhP3rsQb3lqorWLQD1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gU2VudDogV2VkbmVzZGF5
LCBKdW5lIDEyLCAyMDI0IDk6MjQgUE0NCj4gDQo+IE9uIEZyaSwgSnVuIDA3LCAyMDI0IGF0IDA5
OjE3OjI4QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTogTHUgQmFvbHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgTWF5IDI3LCAy
MDI0IDEyOjA1IFBNDQo+ID4gPg0KPiA+ID4gK3N0YXRpYyBzc2l6ZV90IGlvbW11ZmRfZmF1bHRf
Zm9wc19yZWFkKHN0cnVjdCBmaWxlICpmaWxlcCwgY2hhciBfX3VzZXINCj4gKmJ1ZiwNCj4gPiA+
ICsJCQkJICAgICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQ0KPiA+ID4gK3sNCj4gPiA+
ICsJc2l6ZV90IGZhdWx0X3NpemUgPSBzaXplb2Yoc3RydWN0IGlvbW11X2h3cHRfcGdmYXVsdCk7
DQo+ID4gPiArCXN0cnVjdCBpb21tdWZkX2ZhdWx0ICpmYXVsdCA9IGZpbGVwLT5wcml2YXRlX2Rh
dGE7DQo+ID4gPiArCXN0cnVjdCBpb21tdV9od3B0X3BnZmF1bHQgZGF0YTsNCj4gPiA+ICsJc3Ry
dWN0IGlvbW11ZmRfZGV2aWNlICppZGV2Ow0KPiA+ID4gKwlzdHJ1Y3QgaW9wZl9ncm91cCAqZ3Jv
dXA7DQo+ID4gPiArCXN0cnVjdCBpb3BmX2ZhdWx0ICppb3BmOw0KPiA+ID4gKwlzaXplX3QgZG9u
ZSA9IDA7DQo+ID4gPiArCWludCByYyA9IDA7DQo+ID4gPiArDQo+ID4gPiArCWlmICgqcHBvcyB8
fCBjb3VudCAlIGZhdWx0X3NpemUpDQo+ID4gPiArCQlyZXR1cm4gLUVTUElQRTsNCj4gPg0KPiA+
IHRoZSBtYW4gcGFnZSBzYXlzOg0KPiA+DQo+ID4gIklmIGNvdW50IGlzIHplcm8sIHJlYWQoKSBy
ZXR1cm5zIHplcm8gYW5kIGhhcyBubyAgb3RoZXIgIHJlc3VsdHMuIg0KPiANCj4gVGhlIGFib3Zl
IGRvZXMgdGhhdD8gMCAlIFggPT0gMA0KDQpidXQgaWYgKnBwb3MgaXMgbm9uLXplcm8gdGhlbiBh
biBlcnJvciB3aWxsIGJlIHJldHVybmVkIGV2ZW4gaWYgY291bnQ9PTAuDQoNCmJ1dCBzZWVtcyBJ
IGxvb2tlZCBhdCBhbiBvbGQgbWFuIHBhZ2Ugb24gYW4gb2xkIHN5c3RlbS4gQSBuZXdlciBvbmUN
CnNheXM6DQoNCiAgICAgICBJZiBjb3VudCBpcyB6ZXJvLCByZWFkKCkgbWF5IGRldGVjdCB0aGUg
ZXJyb3JzIGRlc2NyaWJlZCBiZWxvdy4NCiAgICAgICBJbiB0aGUgYWJzZW5jZSBvZiBhbnkgZXJy
b3JzLCBvciBpZiByZWFkKCkgZG9lcyBub3QgY2hlY2sgZm9yDQogICAgICAgZXJyb3JzLCBhIHJl
YWQoKSB3aXRoIGEgY291bnQgb2YgMCByZXR1cm5zIHplcm8gYW5kIGhhcyBubyBvdGhlcg0KICAg
ICAgIGVmZmVjdHMuDQoNCnNvIGFib3ZlIHNob3VsZCBiZSBmaW5lLiDwn5iKDQoNCj4gPiA+ICsJ
CQkJeGFfZXJhc2UoJmZhdWx0LT5yZXNwb25zZSwgZ3JvdXAtPmNvb2tpZSk7DQo+ID4gPiArCQkJ
CWJyZWFrOw0KPiA+ID4gKwkJCX0NCj4gPiA+ICsJCQlkb25lICs9IGZhdWx0X3NpemU7DQo+ID4g
PiArCQl9DQo+ID4gPiArDQo+ID4gPiArCQlsaXN0X2RlbCgmZ3JvdXAtPm5vZGUpOw0KPiA+ID4g
Kwl9DQo+ID4gPiArCW11dGV4X3VubG9jaygmZmF1bHQtPm11dGV4KTsNCj4gPiA+ICsNCj4gPiA+
ICsJcmV0dXJuIGRvbmUgPT0gMCA/IHJjIDogZG9uZTsNCj4gPg0KPiA+IGFnYWluIHRoaXMgZG9l
c24ndCBtYXRjaCB0aGUgbWFudWFsOg0KPiA+DQo+ID4gIk9uIGVycm9yLCAtMSBpcyByZXR1cm5l
ZCwgYW5kIGVycm5vIGlzIHNldCBhcHByb3ByaWF0ZWx5LiAiDQo+ID4NCj4gPiBpdCBkb2Vzbid0
IG1hdHRlciB3aGV0aGVyICdkb25lJyBpcyAwLg0KPiANCj4gSXQgaXMgc2V0dXAgc28gdGhhdCBv
bmNlIHRoZSBsaXN0X2RlbCgpIGJlbG93IGhhcHBlbnMgaXQgaXMgZ3VhcmVudGVlZA0KPiB0aGF0
IHRoZSBzeXN0ZW0gY2FsbCB3aWxsIHJldHVybiBhIHBvc2l0aXZlIHJlc3VsdCBzbyB0aGF0IHRo
ZQ0KPiBsaXN0X2RlbCdkIGl0ZW1zIGFyZSBhbHdheXMgcmV0dXJuZWQgdG8gdXNlcnNwYWNlLg0K
PiANCj4gSWYgd2UgaGl0IGFueSBmYXVsdCBoZXJlIG9uIHRoZSBOdGggaXRlbSB3ZSBzaG91bGQg
c3RpbGwgcmV0dXJuIHRoZQ0KPiBwcmlvciBpdGVtcyBhbmQgaWdub3JlIHRoZSBmYXVsdC4NCj4g
DQo+IElmIHdlIGhpdCBhIGZhdWx0IG9uIHRoZSBmaXJzdCBpdGVtIHRoZW4gd2Ugc2hvdWxkIHJl
dHVybiB0aGUgZmF1bHQuDQo+IA0KDQp5ZXMgdGhhdCBkb2VzIG1ha2Ugc2Vuc2UuIEkganVzdCBk
aWRuJ3QgZmluZCBzdWNoIHN0YXRlbWVudCBpbiB0aGUNCm1hbiBwYWdlIHdoaWNoIHNpbXBseSBz
YWlkIHRvIHJldHVybiAtMSBvbiBlcnJvci4gVGhlIG51bWJlciBvZg0KYnl0ZXMgIGlzIHJldHVy
bmVkIG9ubHkgb24gc3VjY2Vzcy4NCg0KUkVUVVJOIFZBTFVFDQogICAgICAgT24gc3VjY2Vzcywg
dGhlIG51bWJlciBvZiBieXRlcyByZWFkIGlzIHJldHVybmVkICh6ZXJvIGluZGljYXRlcw0KICAg
ICAgIGVuZCBvZiBmaWxlKSwgYW5kIHRoZSBmaWxlIHBvc2l0aW9uIGlzIGFkdmFuY2VkIGJ5IHRo
aXMgbnVtYmVyLg0KICAgICAgIEl0IGlzIG5vdCBhbiBlcnJvciBpZiB0aGlzIG51bWJlciBpcyBz
bWFsbGVyIHRoYW4gdGhlIG51bWJlciBvZg0KICAgICAgIGJ5dGVzIHJlcXVlc3RlZDsgdGhpcyBt
YXkgaGFwcGVuIGZvciBleGFtcGxlIGJlY2F1c2UgZmV3ZXIgYnl0ZXMNCiAgICAgICBhcmUgYWN0
dWFsbHkgYXZhaWxhYmxlIHJpZ2h0IG5vdyAobWF5YmUgYmVjYXVzZSB3ZSB3ZXJlIGNsb3NlIHRv
DQogICAgICAgZW5kLW9mLWZpbGUsIG9yIGJlY2F1c2Ugd2UgYXJlIHJlYWRpbmcgZnJvbSBhIHBp
cGUsIG9yIGZyb20gYQ0KICAgICAgIHRlcm1pbmFsKSwgb3IgYmVjYXVzZSByZWFkKCkgd2FzIGlu
dGVycnVwdGVkIGJ5IGEgc2lnbmFsLiAgU2VlDQogICAgICAgYWxzbyBOT1RFUy4NCg0KICAgICAg
IE9uIGVycm9yLCAtMSBpcyByZXR1cm5lZCwgYW5kIGVycm5vIGlzIHNldCB0byBpbmRpY2F0ZSB0
aGUgZXJyb3IuDQogICAgICAgSW4gdGhpcyBjYXNlLCBpdCBpcyBsZWZ0IHVuc3BlY2lmaWVkIHdo
ZXRoZXIgdGhlIGZpbGUgcG9zaXRpb24NCiAgICAgICAoaWYgYW55KSBjaGFuZ2VzLg0K
