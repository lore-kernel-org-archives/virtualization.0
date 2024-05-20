Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A4E554
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175473; cv=fail; b=XWDWQaRqCcEIWkLfIgi/vHWriujwsx/ynin1DKNKqi+S5Gkh9ReA0v9gwjoNbVaRoG/FwejiYwRE6V+1HCqHe9Qpg/q3MTgIyNF8G642W+n/JJ8qnMCtkAX0aB1MxHv1UAoF16IsjUs21sRnq+7nbmpSRNObqoNJ4n4Of4TDEYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175473; c=relaxed/simple;
	bh=sD8eKPLrPVA6xQ+trEuGT9Po1Z28Wdwnyk09SUpNSSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d4kFkkZgV/b1cN1kBny9hztG6SsZOQ5e9mB/3CvAzsDk9MQB8BlXcUSzKWfPzElKIMcqyrZTJUkrwgh3UXvsBmYqahIeh8mBcbbQgylQSm9iU9zO8BkWttaUX7zPm5ANYIjumyu2kDerFr4e9H1IAhh3p7xJdCVGYiV/klbbGj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eP5t3uFT; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eP5t3uFT"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2D656070B
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:24:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1gQqoySb0JE for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 03:24:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1AA44606B4
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AA44606B4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eP5t3uFT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1AA44606B4
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716175471; x=1747711471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sD8eKPLrPVA6xQ+trEuGT9Po1Z28Wdwnyk09SUpNSSQ=;
  b=eP5t3uFTUe4kqobev1zjznb+lF8E2eMlf+ebe79m1iCC5+xoYi82kiG+
   E7Z6chfAwHjnx+hNWSiv4bjd3A5g8EKEfn0z3JwQ9UuiigBJ2FaADdpav
   CPaEqMq8UJ45k+sFyWHKLIFXWFxhHDDEQj2oGxjes8exYvorhXlHpSWs/
   y7c0g/kC7ICOXYx6cvlXcO9C5IECGg7K0is+FMxPwUt0H+2X9zvHoO7Pp
   +quw/GPuKIidSLuAXfM6RDEiJF/+LgHuHs/2lOMzc8atyoKA9S6tdQV6c
   SfGnapB0ftOF+l4qEIvsMJSjO8W/4gUkCIv23Ppm1NKwldM+7/jvCTnRb
   Q==;
X-CSE-ConnectionGUID: UlPya6CURLCjMUBiipKRfw==
X-CSE-MsgGUID: itjaXyQATrqQXf6t5L/4rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="23698520"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="23698520"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:24:30 -0700
X-CSE-ConnectionGUID: vdCWvRlUQOq9Gp4+Z+zNXg==
X-CSE-MsgGUID: 5sXmYBXDS+uxUMJl3rlLqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32815953"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 20:24:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:24:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:24:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 20:24:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 20:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ3DrzwW2mTe7Gb6/MjubwpPI2OVUfXlnLLpZacbsUu23JReAfnYr+fCuLxohrnLqtjZj2oaUA74uCkJBQGmYqNS5pNrfd7kx0t83Q/fGu92b7IUq1YWOdVQIqWpmEPnO6NT7L6Bniyu7EGfcemKN7F+beFKIzQWcgQuure1DlJn53iinX8gMbWlGODxTMIRsy5gB4Vf1MGp5Mfoxn+hXjAvh362z+KPBRVcOMQ/0lrUwVSawm3yiAsX+0h69pOBkHg7sJZL8ZBTxdtkS9LCxSy1N6GyPbXp0vuUIA9l3aK7SgeiR6jbK0TN7d/OYc6iCWn5aclsPqrQF8BVTIfaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD8eKPLrPVA6xQ+trEuGT9Po1Z28Wdwnyk09SUpNSSQ=;
 b=gnuIV1iq2JsA7Z96haqeKIbcJF8kfNd9/eKRwxhKFn7UTnfclTbeGLCgjXE6uJHnq4P73kNkyHQuELTTbcXhSDLNLYZyl9UIeUCvQ1DzodhCYYYx3Qv06Er8MqCm4ciIEfh6q04iRGvGh1/GSy6c7Se3ekv9yCaA2hpCqP+n5xgcGTHW5rEIDvMOmP9xRTGnRmhdSWRDJk7++pOKCIITzjUi1sJsLo5Xh0EW36L2CjnCie9iIX3OSdi4RqF/Y7hv3JpSBO703gvPivltzxiPGyr+sM82i8jJvnf3OrhOnT/6ZPpgV+Ykex/wTisumDyBmmkIDNKlf/PMowEURo5lOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 03:24:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 03:24:26 +0000
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
Subject: RE: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
Thread-Topic: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
Thread-Index: AQHamw8bLYtOgdprmEKnPZxoJChdq7GX/cMwgAbATwCAANVHUA==
Date: Mon, 20 May 2024 03:24:26 +0000
Message-ID: <BN9PR11MB5276A68C9DCDA201826714018CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
In-Reply-To: <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6120:EE_
x-ms-office365-filtering-correlation-id: 39b6d789-4018-4f81-08c9-08dc787c5a71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NTdOWU5USkNOdVVYMjdaQVEveGZKREh4MFR0TTNKTm4xVmVOM0ZRRk9sM1hw?=
 =?utf-8?B?MEZEUjhGS3NyOGtaNlFraXdzWGdTQTVDak1rUEIxVS9iV04vYjJRTVE1ajBG?=
 =?utf-8?B?VnVhSVZaNDc2ek9jQnFrbU5jaTdua1RxMXFDZ1dJWGlWUkpEaGNQcTNibjFN?=
 =?utf-8?B?bUNzTDdtWW9BdUx1R2IrZUFRSUFCdDZVcDFFYXJENC9mYVZDT3JocEdQVFcr?=
 =?utf-8?B?aTk4VUhkZU1ZUUltQ2NDVGk3dUs1aGdjWjBESVlTVmhmQ2J3c0xvdzg2SGha?=
 =?utf-8?B?Qmh6MkRxdWR0M2FhVHhOR05GOHprd0g5bmswem9aaWtPa3hQMjhya0YzVC84?=
 =?utf-8?B?UlowWWc2MFYrR2pxdzNBOWkvblFEQ1cxMDh2QlFCZzJ1WHRuUUhLRG0ycXhX?=
 =?utf-8?B?NnhCL2NRTTcwQVlOSUpwZEhhRTFmTDNtQWM5RjFWTjF3YncvNzFwYXNLQ0px?=
 =?utf-8?B?WDd3NXBrRmNoYU56SDNnbGI2SEI5ZFMxUFJueThzdklpNFFYYlk1L2orZXBE?=
 =?utf-8?B?UkNNL2ZzOWFkQ09TeEJnb2l0R0ZFZGlJWEQvaEx4TmdUckMrejI3aTlMU3JQ?=
 =?utf-8?B?YmNxaS9LWDJ2NmFMYkRwTE1LeGNkMHNWU0ZLcm9NcVVJYXYwVEswTzRWUGhz?=
 =?utf-8?B?WFNrSkRwVU53Z0Z4dDdmcFB5UlRCM2F5ZHlCelNUQmhJUXZxZ205cHFLWHdF?=
 =?utf-8?B?NUlJQ0VSRnptV1huOFdsTytaTEhrSDFHN1VTZkpjNHZ0SG5CNWVZSDBOZzNU?=
 =?utf-8?B?YTBhdG0zK2FIakhKN0hqNVE1U2lSajFPRHVFMkw1M205UjRrNUlNaVQ2OVd6?=
 =?utf-8?B?UGlMQWpBSEViVExoTDlYdHVJZzlQV0JoL01xYTFETWdocFdBZXZGTm1RTFR1?=
 =?utf-8?B?NTZJYkV3MlBYMzRnd3h1R0NqeHBQOUgxdVRxVlNqU0VrR0xrY0RFcW9CeWlH?=
 =?utf-8?B?L2REeURYVUlNNVdjSmc0d0xXa2dvRDB1RXdMU09mbEp6T21MaVJmMFZycndv?=
 =?utf-8?B?Sm5zeU9ud0MxTnJrZnc2cW1FSnpXenFSeXdQUjFJT0FMNDNzUFE4RWxBelhX?=
 =?utf-8?B?WG1QOFRGemlXYzk5TU9waFJad1k4aTAxZEJLNThBdzVOWTZTL1FQZStXeWFI?=
 =?utf-8?B?U1JhWWlURGVGU2d4ampMdHBzOS9zT2JCM0JLUVh5a1AxREVrWkJZakxxb3c4?=
 =?utf-8?B?bjdoTDh1OStqaDFVcnJPclg2NC9yRmkxQzhDWUNwT2xjeFhpQ0ZGcE1oM2tG?=
 =?utf-8?B?d29GREtHZVlTUnlDaUhjWTZhODZjazhZWnQvaDRVYnNMeEc5NlE1enBjNlV1?=
 =?utf-8?B?b3k5TUg3Y0U5QVZGTFlqdloyRmw5Mkt2anpTeXlKUzdyTUVMdGtDVGFJK1h4?=
 =?utf-8?B?NFB4c1VoZTQwTjI4ZENINlcyejdRWWpiZHhMNUJwb1owYytnSXFsdDZ2MnZv?=
 =?utf-8?B?eFNyT3ptNE1sbW1qckVKRHVBRDhvQmtwR01xYTQreG9JRm1HcElESkZBRVZ1?=
 =?utf-8?B?VFRVNzdEQjRXODF5S1dBSHFXMFk3SmprRkpoZVlUc1VRVTl4VWpaQk5mOXdR?=
 =?utf-8?B?dzJKZ0cyRFlZS3U2U3F1T1lUQU95WkIxdXdRdXgxRFJVYlViN0tvV29kc2hP?=
 =?utf-8?B?ZU4zU0N2Tm5XRnVxbThvZDlvTDdBNXdFWnpPUlZ3WEs1QmpPbjd3SmN1S2hv?=
 =?utf-8?B?KzV2TlhvWEYrTTV4bmxDNTFTeXNITkR6Y0E0VjFNTE8vdDBUTnljYUtvK3dU?=
 =?utf-8?B?N29BVHRPTzJXQTRnb0ZrbUpZWXVqeGFrK0dIS3UxdFJPazlvUWJLNVNaTU1K?=
 =?utf-8?Q?WsOx1TEy0UI5NOWN9xhTbDgPfh1M0Pf+ZH0IE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UktYRnEwd1F0aGJsWjg3MVN6UGpzdmVISzNOdmZKWkFOWXVwRXVhcllIS1NC?=
 =?utf-8?B?cG56TlAxY3F5WHNCMVg3UzlaVGxkVVVqbmlZeUZBUHJhT3JxL2lJNGMwM285?=
 =?utf-8?B?S1hENmlSTFVHVmtEQm9JTmNPNWp3cTYwc3lUeWhuVWFCSHNjczJKUVVMYnUx?=
 =?utf-8?B?T2N3SnZGRUdFbHN5V3ZjeVhRZUtOQ0pDRE9aaE0rdTBQc2tUU0lTRUJCbWxx?=
 =?utf-8?B?elkzZWdVSENpTk5WVHdla0pUY2RSOHJTNTJRQXBuN01RNFpmb2crd3Y4em4r?=
 =?utf-8?B?dkJGQTliOGI0Zkp1ZjVWRXJnSVh0OTdKdzdDNm4ycTN3Vnl5dUF6NmVPZVZM?=
 =?utf-8?B?OHVhdEF3MFFqdDBVak5pTlFDODBhVTlLS2JLY1BnTmp0ZHA5V0FZQVlNbldz?=
 =?utf-8?B?Mjh4dEpnd1oyQkd1a3hwYWxUQ0NOUWpBbjhQQWN4cDNnU0dDWVFVRU8yamVq?=
 =?utf-8?B?RnQ3WjJhbldRSGpDcjhzWDUyUGpkUXdoeGhMckpla3MvZTk0QWN6bEI3TmM0?=
 =?utf-8?B?TGhOa1AyRGkyMXNhSCtEZ2FkL3FxU0YrQkh2Z2MwMEZLbVZFZUtDNlZ3RVd0?=
 =?utf-8?B?Q2N1QktFYjNmcmFwTk1EbDdHak5Ccmt5bkt3QU1YUkFZZUkwbGV5WDhNNm53?=
 =?utf-8?B?d0xVd0RTN05takFkUjhaV2ZpN3hQMVZVQUErY2dlWUV6RktPellrM1dQZS93?=
 =?utf-8?B?TFZoMDJERU5WOXVSeVJOVlR6MGxrckFiLzlLT1FETlI3TStvUlJUOU1hUHZY?=
 =?utf-8?B?c3cyMkNVd3p3ZzdmSHBjMTFsTFU4RG5TYmpIV0NpdUdCQmNPRDdLY0xrRmUx?=
 =?utf-8?B?bmxITmxTRzNzRDJvd0lxWWh3RklwbHg3aEFYWGxOdzl0aWs2SThmOWVVT0Nv?=
 =?utf-8?B?M1lQWDA4ZXpBZEhaaWNsbEY5VkxGcUJ2Wit3V0tnUHZnb2t1UFNXNlVSRXBH?=
 =?utf-8?B?S2Y0YlNCNFhSU3d5SVdZL3VSc3ZOK1JxZzlPbGNsMitTYnpKK1lacTIwb0xj?=
 =?utf-8?B?c3JmNVQzM1FzWE1ZWVk4ZEJkM2RWQldMVEQ3c3lvK3c4TDFzbXlIejM1cnR1?=
 =?utf-8?B?aTlzR3VYaWoxWWEwbHhNZXpxYVNIaG8rSjhUV2FuU0doaHU0VVMzR1FSeG1q?=
 =?utf-8?B?dGc3MUNRU1dBVnFHd09JU2dXNmI4MUlvcS9Pb3pjMnprQ3hCK1lWMnZkaFY1?=
 =?utf-8?B?emdkYUF4cytIYjVqY2dacE93bDd0ZnY5Q0EyV1NOMGRtY3ZSNWZhWUZ6V0Nu?=
 =?utf-8?B?U1QrMndMS1c2NHRnMWFXWGI2ZXlGVml3MEttWS8xc0lMeHhibnM5dldodnBP?=
 =?utf-8?B?Zk5DUTlMdk9zazhmMjQ1dVN2UmNDbEhGVzV4OGpvODRjSGRGOWpqUXBaQS8v?=
 =?utf-8?B?d1o3bXNKeFhraTZzY0s3TG9GNWtRSlA0Q0U2YUZQWks0SUJHLzJjU1lSOWZK?=
 =?utf-8?B?SVBrQ1pRMWw0bE1HWEZDWXk4YUJxWmxJdkk1aWJMN0JsYkxBcTAzNDNJbEFM?=
 =?utf-8?B?T2xRSkNPQVd3bGV6dVlqTkt3Q2hVNVVNK0t1RHlqMHFqUlBmSXdJUms5b1dt?=
 =?utf-8?B?dGQ3M0wwZXJ1ZFkvcVJpd1poSzEzQnVxTkF2YVk0dzZlRjJnYWtqazQ2T21S?=
 =?utf-8?B?RW5NTys5VXdkWXNuUFdJbysxSEcveFhadTVpYmxzUmpUL25MNWZKZDZNMlBR?=
 =?utf-8?B?RWJvRWtlM05DU2lPVG13ZXZodkcyMHBhT1VrNWFZM1ZiRjdSbUZmVm1CZzc2?=
 =?utf-8?B?MEwwemtWbVpzeXA3bVl6dWF3VXlhc2VUNzVPTGY4SGtNcUliRnN1RjlhL3ls?=
 =?utf-8?B?L2cwbGNxbFQwVTZiNCtOcnhtWWlOek5GdzFlQzFuNTNtbkFaam9VL3gwS3Y0?=
 =?utf-8?B?dlBTMU4xUmdYWHZUakY0MVkydUlFS29ETEpDL3pEaS9OZEVtcnFZTEEvV21P?=
 =?utf-8?B?K3NhVzg1OGRxWnc1Z1pid1RYZWIyQ0NvR085VEtFYllCRFlLNUk2TG11UDdm?=
 =?utf-8?B?ditJVkRHYlNkUThTQkM0eU1qelgxV1k5enNPUzdGcTZCaTd2NHRPVVFpcDZN?=
 =?utf-8?B?SFUzdmc3K2RKNGFWOWxrdmVJYjRuZ2M3S3VXWkc4M2VqckRFcGJmTnF3RXFT?=
 =?utf-8?Q?7j1+VPZvHhQOtg40uBZ3SlV/E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b6d789-4018-4f81-08c9-08dc787c5a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 03:24:26.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkgaGdjSTPTYG65AipARbhlyPat4OJFrFoBnitaDxfdol/67epYdPjUn0sNlA18E0H0w7CbkEn3QNItUK5I7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIE1heSAxOSwgMjAyNCAxMDozOCBQTQ0KPiANCj4gT24gMjAyNC81LzE1IDE1OjQzLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgQXByaWwgMzAsIDIwMjQgMTA6NTcgUE0NCj4gPj4N
Cj4gPj4gaW9tbXVfaHdwdF9wZ2ZhdWx0cyByZXByZXNlbnQgZmF1bHQgbWVzc2FnZXMgdGhhdCB0
aGUgdXNlcnNwYWNlIGNhbg0KPiA+PiByZXRyaWV2ZS4gTXVsdGlwbGUgaW9tbXVfaHdwdF9wZ2Zh
dWx0cyBtaWdodCBiZSBwdXQgaW4gYW4gaW9wZiBncm91cCwNCj4gPj4gd2l0aCB0aGUgSU9NTVVf
UEdGQVVMVF9GTEFHU19MQVNUX1BBR0UgZmxhZyBzZXQgb25seSBmb3IgdGhlIGxhc3QNCj4gPj4g
aW9tbXVfaHdwdF9wZ2ZhdWx0Lg0KPiA+DQo+ID4gRG8geW91IGVudmlzaW9uIGV4dGVuZGluZyB0
aGUgc2FtZSBzdHJ1Y3R1cmUgdG8gcmVwb3J0IHVucmVjb3ZlcmFibGUNCj4gPiBmYXVsdCBpbiB0
aGUgZnV0dXJlPw0KPiANCj4gSSBhbSBub3QgZW52aXNpb25pbmcgZXh0ZW5kaW5nIHRoaXMgdG8g
cmVwb3J0IHVucmVjb3ZlcmFibGUgZmF1bHRzIGluDQo+IHRoZSBmdXR1cmUuIFRoZSB1bnJlY292
ZXJhYmxlIGZhdWx0cyBhcmUgbm90IGFsd2F5cyByZWxhdGVkIHRvIGEgaHdwdCwNCj4gYW5kIHRo
ZXJlZm9yZSBpdCdzIG1vcmUgc3VpdGFibGUgdG8gcm91dGUgdGhlbSB0aHJvdWdoIGEgdmlvbW11
IG9iamVjdA0KPiB3aGljaCBpcyB1bmRlciBkaXNjdXNzaW9uIGluIE5pY29saW4ncyBzZXJpZXMu
DQoNCk9LLCBJJ2xsIHRha2UgYSBsb29rIGF0IHRoYXQgc2VyaWVzIHdoZW4gcmVhY2hpbmcgaXQg
aW4gbXkgVE9ETyBsaXN0LiDwn5iKDQoNCj4gPj4gKyAqIEBsZW5ndGg6IGEgaGludCBvZiBob3cg
bXVjaCBkYXRhIHRoZSByZXF1ZXN0b3IgaXMgZXhwZWN0aW5nIHRvIGZldGNoLg0KPiBGb3INCj4g
Pj4gKyAqICAgICAgICAgIGV4YW1wbGUsIGlmIHRoZSBQUkkgaW5pdGlhdG9yIGtub3dzIGl0IGlz
IGdvaW5nIHRvIGRvIGEgMTBNQg0KPiA+PiArICogICAgICAgICAgdHJhbnNmZXIsIGl0IGNvdWxk
IGZpbGwgaW4gMTBNQiBhbmQgdGhlIE9TIGNvdWxkIHByZS1mYXVsdCBpbg0KPiA+PiArICogICAg
ICAgICAgMTBNQiBvZiBJT1ZBLiBJdCdzIGRlZmF1bHQgdG8gMCBpZiB0aGVyZSdzIG5vIHN1Y2gg
aGludC4NCj4gPg0KPiA+IFRoaXMgaXMgbm90IGNsZWFyIHRvIG1lIGFuZCBJIGRvbid0IHJlbWVt
YmVyIFBDSWUgc3BlYyBkZWZpbmVzIHN1Y2gNCj4gPiBtZWNoYW5pc20uDQo+IA0KPiBUaGlzIGNh
bWUgdXAgaW4gYSBwcmV2aW91cyBkaXNjdXNzaW9uLiBXaGlsZSBpdCdzIG5vdCBjdXJyZW50bHkg
cGFydCBvZg0KDQpDYW4geW91IHByb3ZpZGUgYSBsaW5rIHRvIHRoYXQgZGlzY3Vzc2lvbj8NCg0K
PiB0aGUgUENJIHNwZWNpZmljYXRpb24gYW5kIG1heSBub3QgYmUgaW4gdGhlIGZ1dHVyZSwgd2Un
ZCBsaWtlIHRvIGFkZA0KPiB0aGlzIG1lY2hhbmlzbSBmb3IgcG90ZW50aWFsIGZ1dHVyZSBhZHZh
bmNlZCBkZXZpY2UgZmVhdHVyZXMgYXMgaXQNCj4gb2ZmZXJzIHNpZ25pZmljYW50IG9wdGltaXph
dGlvbiBiZW5lZml0cy4NCj4gDQoNCldlIGRlc2lnbiB1QVBJIGZvciByZWFsIHVzYWdlcy4gSXQn
cyBhIGJpdCB3ZWlyZCB0byBpbnRyb2R1Y2UgYSBmb3JtYXQNCmZvciB1bmtub3duIGZ1dHVyZSBm
ZWF0dXJlcyB3L28gYW4gYWN0dWFsIHVzZXIgdG8gZGVtb25zdHJhdGUgaXRzDQpjb3JyZWN0bmVz
cy4NCg==
