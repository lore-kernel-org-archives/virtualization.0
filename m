Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CB18C344
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609884; cv=fail; b=ec0D1FcIXoAW0Ji6iw0Kv44lsWigZo5Yj54OcTXNniFiNW/z/5/zkURjJGhhigpQzH69uc4ILlULHJ7eFavH9R91+IN5r8f1eFpWbYGIaEteL5jD93LvVxjz+IWnoQhnTJOckj2S333KV9cZfPp/Zb9/uQDau9C/iOpk+SMCgsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609884; c=relaxed/simple;
	bh=bRZlwZ0Twn3rQHHi9d69pXpt64EUHrfJxj6t4JsY4+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtcC9/W2HuhpnYNGdDKvTuaDBVrzOmj7bvFgmTEC8U7xkVLOL0VSS4PFTWgCllof9ertLGCCq9wSGxd6IkD6aBUL5UVbuRmeESA5RmQVEFNGJpaLhHFvOHZ8tZu74C6yMjYnBRKvCV5npGeBdOQqrYDyaVPDg9Ey9gwf4sTt1gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQByhuAB; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQByhuAB"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEDA660878
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:38:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZzweB9GIg6i for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 07:38:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 03CF46086D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03CF46086D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nQByhuAB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 03CF46086D
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718609882; x=1750145882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bRZlwZ0Twn3rQHHi9d69pXpt64EUHrfJxj6t4JsY4+8=;
  b=nQByhuABzjEGM34g2XDgs6BlzcF7gY9jtTcvzW+18UdpTpmqTYwKjS+q
   R0iLkK0UlIlPH7lQYcBHOdBaX35AjgZWxKfBw7UUb2Vdz0EjB3k78m7+z
   XAXSDXLBV/CxYF5opps9LPUAdS6TblqHUpz5LUT9u5aglJ3jp/+oWL5kq
   3JlRyNuzIq+TkZ05OrBt1OvQQXoFbT8NlqtAFtCzbv8hGsjksPGj16yto
   0zwhNZ2GAkbyFhrLniJ9x04GXX0S8M89CxJ8+7XhDhI7/EHfW3RRK1XNv
   eV7Opk1UPCyzHcYMm6yaWBJwDBVSs/1oy2+2BVBkMHKJONmFjUJ07iaqU
   g==;
X-CSE-ConnectionGUID: FaH2P9q1RNKXedWsQH2kag==
X-CSE-MsgGUID: cay3m8YJT72MHOYqvwSxsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15547649"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15547649"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 00:38:01 -0700
X-CSE-ConnectionGUID: rzqtT5olRoq7ZIMI9zOK4A==
X-CSE-MsgGUID: v29lFoo0R06n5NxBZlUPKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="45482862"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 00:38:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 00:38:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 00:38:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 00:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEFdt5H0kxtwf3WQM5pYrlGGCPHZWSCVidAKxfUg7UIwWKARdWDHkVzQAd4HSAlpGRdGuUD2icNs2mXnCl/QWy1Q0+uQBT6CKpSpVxD0FFjg9ZJ/y2i6pajLxyHEXPaMUtE864EqY7hrT/Sj581xHTTOly2ph4027caSiU8o2xoPNO3A/GuNSfb6vyW7Kuo8uXA/f4wo86DYfbUgyvJ0KXlqGa2n5U+ZR4eZvRE4EDr7Ms7ADd8Z7gDhLW0ZgUsz/NYzT96gLU9kH/Yldt7wfQrh7lEy3+11pBjCJ7Oozx4W/r+VvDvnWAC2a1YkoCDNLC42mOEpkuAhs8ddwmoJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRZlwZ0Twn3rQHHi9d69pXpt64EUHrfJxj6t4JsY4+8=;
 b=NOKSuDSZhQhjgAVvuwiRrOg5MmqyYYJFMeXsb/yQH3BBGRtUP3tKeZ5jIUYckIh6p1Brmd/4oHA80z2IDslx9jZgXhpdm4hxhQscfudS/pyIjkV9vdqEyz0KA1X3L/w8+OEsZuTfbnUoVMVI/7/iFmDamddp32JYLP96V3TpmhtZDYPdfl3IZb00W1Y5ZztkQa0L9wAOixLCsLrjSkq7VQkhIv2VaDsBCQFaSQ5n2lbEVZRo6zZqdr84tnTiXhuUwW9/8BpglqBuG+/jugr8IfmWDzGoly0OU0I10OyIJSUayAP37NWLwDiDD/zaP9RR+NufFogA9xnGdFKI9Iufvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 07:37:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:37:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Thread-Topic: [PATCH v6 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Thread-Index: AQHar+t0HeiArTd/tk+nbA8gEhK7rLG8FzSggAMEwQCADJWKkA==
Date: Mon, 17 Jun 2024 07:37:52 +0000
Message-ID: <BN9PR11MB5276E6D661A23B8F9ECE64E48CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FC9E1E7CF82BF51BC1FD8CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <996ad6df-c499-4070-b3a9-1cdccfcf5d09@linux.intel.com>
In-Reply-To: <996ad6df-c499-4070-b3a9-1cdccfcf5d09@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4662:EE_
x-ms-office365-filtering-correlation-id: 5d632712-3bee-49a4-f5b7-08dc8ea0659c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015|921017;
x-microsoft-antispam-message-info: =?utf-8?B?N3UzWXdQTzVsa21kdHlPTXp1QnVibTltSHJvM0V5a2JPNDQyTkJJN2UvNExB?=
 =?utf-8?B?cHJNWW5OYVY1eDhaN1BMbFJVNFNaOWVqR3FjWDk3a0lUNXpBc1pmWlRZQXMz?=
 =?utf-8?B?UGtDWlhJcFk3dFhpNktmY2RWeHRzMWpSYTNqWGpJbjZiNE5IVGxheGMwc2lz?=
 =?utf-8?B?UDZiU0h4NGx5N0ppQTMrNjA0R1I3OTEwNmNMQ0VWYitGRUVFQi9KYU8vbGJs?=
 =?utf-8?B?UUpXSlg0K04vdjFtRC9PbTJrSEcvbGorVnNFQ29aVm8vYXVFVExwR2ZrL3VF?=
 =?utf-8?B?dTJOZW9HODNHL3ZQOTZjNFI0VG1LcDY2UTBBVk1IU2JGWkFGc2ZYYVRycVNE?=
 =?utf-8?B?NUNtQ2ZCNXJobENTYmh0bjd2VU92amZjSDhJV0NQaUhpOFRPREFqbk85SXVi?=
 =?utf-8?B?b1lxMzkvRFBnNXlBRHkrMHpmYlNvei9tQnN0ZXFsdFA1YVBwdFZ2OVFVM2pJ?=
 =?utf-8?B?cG4ybUlucXhWRWJ5ajFCVUVvZ1JVSnhWRlc5YUNaVUF6TnAwTHZJVXlQRHVm?=
 =?utf-8?B?TW1tRU5BN0pleTAxc3dsOEZ5TGw1ckVMeWNUTjR2cXdvRHg5cUFBc2QwNjc1?=
 =?utf-8?B?SWpyallCTHhwOHYvcXVFVXRiMjI3TTZVVHRhTk93THgyWEs1SUxpU05PS2Nz?=
 =?utf-8?B?K0VKWG50Z0R3QlJjVkcvZ2p6U1hwTkVDZkdMakRoUXg3ajZ5SnJEcVR5RGEz?=
 =?utf-8?B?VWV3MTUwa2d1SVNmelBCTUlMMkdpUlNycUtydHJIQ1JhdC94Ymp2VGJqQ0Qx?=
 =?utf-8?B?eGViLzFhdXBPY3RZM24zdjJBM0FKK2MrUktyTS9BT0FkSHVRR2l2TEtoallV?=
 =?utf-8?B?bWxiV0pRcWp0bWpXREgrVVFKZ2hqcDlJOWNURFJMcmRpd2lIWmV2QmNmSXd5?=
 =?utf-8?B?cmJ0YzRkOVltNWdmK0ltZGsydjZlRHNya3pRSDhDTG5HbXlVMlVwMm41cXVV?=
 =?utf-8?B?THhHWlJMOFJPTnphdXlWV3YyV0V3dU9TT2VMalVUSlFjdUZqRXo5VCtlRjBt?=
 =?utf-8?B?VjJGOURBV3YyT0Zpd1lWRUVXNGViZ3AyZXdKWXhxWjJ1K2EzZWNBNGVNZUJ6?=
 =?utf-8?B?N2pBUGJtbDR6NTZHb0lSaHhXTUsvdXZYYW5DM2E3SUI2NFZJNXF6dmtvSVpp?=
 =?utf-8?B?aUlRQlBLbmFtSmN4dmZoYVk2b1FHT2pDUmlidkxpU3hJOGJSUlM3MURFZ0Yv?=
 =?utf-8?B?MFAzbTRwL25xT0tiUkZUa0ZNaEpvZk9SRFl5N1lwalJ6eEE1WkZ0bDBmSURp?=
 =?utf-8?B?bWJFSEt2YzRoZUloNENiRmJRTnRZRjJHQ0c4WlVRSXJTQ210c2h5M1diaWZS?=
 =?utf-8?B?SSt0N05udGxMRjZZVXJWSnU2Zm5KS25sb2VDYWFvVGFqNTZMOTFvMC9LUVBQ?=
 =?utf-8?B?d0hRcWU3UzBabUs4Yk5DYWNvQm1ENEEyNXQ4R2ZPdnpSWEkwV2l1VFdlaWIr?=
 =?utf-8?B?RmpGNG50TGNNWHd5OW1RZndoSW1DSXlaZGhuaVNrMkNxbWsxcmJxRVBzWWZ4?=
 =?utf-8?B?TExyTzJFeFVxVWtDUE5IRlE4VWs1TnR3bkJ3MUVtMXB4U05MVTVaQWZtVmFx?=
 =?utf-8?B?UXhNZVl2SENPNWx0RHZubllib3R0c00zblIreVFhbEx2NVV0dm9oNVJ6YzJh?=
 =?utf-8?B?L1N0dzNNR1VxVkZXT1I3cW1xK2J1RjZBOW1MdWFyUS82M0JkZlMvOW1iSjJR?=
 =?utf-8?B?N1JjeHB3L3hXc01kcTUrVm1vb0w0b0FlY09FTnRCYnNnSkZZOHllbm8zY3BP?=
 =?utf-8?B?cDhqQU1RTE1UWGJkV3VLblRLYXB4c1htRFdtSkdWZzNRSmRZNy9yZFpxdXBy?=
 =?utf-8?B?YXlrRjQ5V01yZFlPcnowVk5VNHZYVHZNZ0RpT1daU08ybWt3bndBWjJrVlgz?=
 =?utf-8?Q?jalaeDhtfeWeQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1E5NmJuV3JvOXdhRk11Vk1VaHM4ekI3elYzbVdxZDgyQVJjbGE5aGRVcEs3?=
 =?utf-8?B?clIyZ2o4QW9rMDd1QWJCMk04dmluVVB2SnBCcWZPMlpNZmN4U1RGcVBGNUlF?=
 =?utf-8?B?OWxKMXNObWhLcERpTnp1VTFFR1JxcC95Nzk5b2hzZ0Q2eDZ6ZFFZNW9EbVBS?=
 =?utf-8?B?a3NoWUdpb3cwdjJGWEVIODFUNXUzSDltaVl6YjlYL0xCOC9zaS9MUk5zWmNl?=
 =?utf-8?B?U05BWCtCRHpLSTlnVTF6SjVoNVFuWk5kKzRZbHRNRW5xQ2l3d0N5TngydnpV?=
 =?utf-8?B?SGIzd2M4QWpodkMyMStPUVZpWmFWdlBISEUxSURDNHZ6cFFScHRlSVdGRkpk?=
 =?utf-8?B?QzhpYU9Rb2hXMWluUFFPa3crU0ZhUTh5UlIzT2J5YjNtN1pVVGpGQ1FMa0J2?=
 =?utf-8?B?SVdBRlR4TU9Ec3oyWEZPa0tBeEw2Vi93UW5zN25VOGxNbGxlNnh3TTA1eU9a?=
 =?utf-8?B?MXFES09NRFRlOFlRWlp2L2gzZnBOaXdDTmw3a3cwbkpzTTZ2b0dVZEJqV0pw?=
 =?utf-8?B?U3BkdXhMeXl3Ymg5SGVKcjN0Y1dRSXZWR3FvNGJHMnh6U0JuY0NrTnc1TjVx?=
 =?utf-8?B?blh0WXluVjRQekp4MDdiRWViSjZVTEltbkFWcXhacUxzQ0craDZ0NkQyMUIr?=
 =?utf-8?B?dFltSVN3amZVQmZqYjNsNlphZS9JSEk2T1RzT0lMeTBCV090eTFWMkYwb1Mz?=
 =?utf-8?B?bGU5dUw1cURkOTdLOXJ0NnVYSkMzRFRnTE9KZXRiOXF4ZUdhUW5pOE5SYXRQ?=
 =?utf-8?B?SWRGVTVhRkt6UGhlMGJZeEp6eGFWRnNNdlFGU0w3Kzl5c0lpQnNKYzZ0VTdj?=
 =?utf-8?B?UzZuQlBmOEkySjA5K1A0K0w3MVAwcllNSzZhT0grSkFrS0IvRXZDSUhhMGdl?=
 =?utf-8?B?d1lvdXBNa0cvTlFuOTNJMG0xTlVJWlJZU1dBRVFDR3N1emRxNTE1dEg3MDVt?=
 =?utf-8?B?TWJFZ29DVitRTzRSenJVWWJOQ0UwQ1dwZXRmcURQWXpzU1BMckxFYStuVWNX?=
 =?utf-8?B?VWRVNlZ6RDlqSGRSc3hCdWJoV1lGUWNHdEd0KzVRZkxoY3lyc2xUUHFRQTRy?=
 =?utf-8?B?SXo3bVhGby9QWldPdkxrTElLVG1RRUtWM0hmd0ZpcGFGb0FHT2x5UDV3K2JK?=
 =?utf-8?B?S1FKcTQ1MHBvWUE1NE9VMEk5OENrWi9RZWJBZVRWcFJqSVhyL1c3REdZQ2Q4?=
 =?utf-8?B?TGNJeEZpbTlYZ3o3MURXcElZOXk0VGk4dXpzdlNHa3oweDBmcmo4MEdiOEhv?=
 =?utf-8?B?UGh6UTJNMWF0WUwrc0FneXkwYXZVNi9LM2djdlBQQ1VYUzlhQWp2S0l2emVk?=
 =?utf-8?B?clFhUG1HRU16MmhhVXB0REpGYWMyR0dmWnArQXh1aDhWWHpYWmI4NVBYWUxa?=
 =?utf-8?B?a1ZCUml2N2lrUHJSU3pqV2lQQ0krQlNZWGN5cjNvVWlnVDlzU0ZlalBSb0FT?=
 =?utf-8?B?SWVHbTFtQTQvK3JiM1hRSHN2OEpOK3FwT1pSOG1QRU5pb1MyOVRSYlgwOEVW?=
 =?utf-8?B?VFp5b0hHOStzVDRXd1hZWTV6YlA1QW1ZNkp3Y0NXaGNEaTFMaTZrb1JvS3hk?=
 =?utf-8?B?TlAwclVDUjYxa0d3NDIrbEIxZHNCVXV4R2loUnB1VzY1aEdFbzMrOFUxWlFI?=
 =?utf-8?B?QXFObXhUdWR4dnQ2bkdETWFZRHBMKzlwK3ZXbTBzY3BvNjAzZFRqQlVCNTcy?=
 =?utf-8?B?V0lDWDBERkdkcVRkeEg5NlhYdStrUWpHazVSSzlQU3BtQi9JZnZuT3JUcy90?=
 =?utf-8?B?QU9YTVBtN040Y1JOOXUyMmFWd0JjOWlPTU1KSjVrQ3h4aXo0aFl5Rm5CSHpT?=
 =?utf-8?B?RGdnMTNxb2tIUGpOTDdpQ2g1Y0ZpZXI3QXlLSnNJMWVqSjh5MEYxRERlSGla?=
 =?utf-8?B?UC9qS0xQRFExV2Jwa0QzeitUZGorRjJub21jeTlETHlER0FGd3BTN21GZWxB?=
 =?utf-8?B?akFDRUVHOW9pTWY5WDlGVUxNbGJvMXZweUJkTzNOQkU3b2ZHSVRhNnpzdWlp?=
 =?utf-8?B?VzJOVHROME9GaExqZEs0bVFjMUt0VmMzQWRzTkVsdHpWalpBVm5kcU9aMkRM?=
 =?utf-8?B?Y3dUNlNpN3hESXZMVDNvZ3lqRFR2Y21CMkhYZ29FdWxUSlJ3cG9kTDBxUHEz?=
 =?utf-8?Q?magYFlg776fwBOHtR7QGaEzIi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d632712-3bee-49a4-f5b7-08dc8ea0659c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 07:37:52.9932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VanXNZJTZbaluGHQLEP0Z0bmdBXMABud/Z4YQT4OFKLAoeOo6gBVHrDpG4Y/xpe/CUMZZslVnUkLtxOj2k7n6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEp1bmUgOSwgMjAyNCAzOjIzIFBNDQo+IA0KPiBPbiA2LzcvMjQgNTozMCBQTSwgVGlhbiwg
S2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5j
b20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgTWF5IDI3LCAyMDI0IDEyOjA1IFBNDQo+ID4+DQo+ID4+
IEFkZCBpb3BmLWNhcGFibGUgaHcgcGFnZSB0YWJsZSBhdHRhY2gvZGV0YWNoL3JlcGxhY2UgaGVs
cGVycy4gVGhlDQo+IHBvaW50ZXINCj4gPj4gdG8gaW9tbXVmZF9kZXZpY2UgaXMgc3RvcmVkIGlu
IHRoZSBkb21haW4gYXR0YWNobWVudCBoYW5kbGUsIHNvIHRoYXQgaXQNCj4gPj4gY2FuIGJlIGVj
aG8nZWQgYmFjayBpbiB0aGUgaW9wZl9ncm91cC4NCj4gPg0KPiA+IHRoaXMgbWVzc2FnZSBuZWVk
cyBhbiB1cGRhdGUuIG5vdyB0aGUgZGV2aWNlIHBvaW50ZXIgaXMgbm90IGluIHRoZQ0KPiA+IGF0
dGFjaCBoYW5kbGUuDQo+IA0KPiBUaGUgaW9tbXVmZF9kZXZpY2UgcG9pbnRlciBpcyBpbiB0aGUg
YXR0YWNoIGhhbmRsZSBwcm92aWRlZCBieSBpb21tdWZkDQo+IGluIGF0dGFjaCBvciByZXBsYWNl
IHBhdGguDQoNCkkgdGhvdWdodCBpdCB0YWxrZWQgYWJvdXQgaW9tbXVfYXR0YWNoX2hhbmRsZSB0
aGVuIGl0IGluY2x1ZGVzIG9ubHkNCnRoZSBkb21haW4gcG9pbnRlci4NCg0KYnV0IGl0J3MgY29y
cmVjdCBpZiBpb21tdWZkX2F0dGFjaF9oYW5kbGUgaXMgYmVpbmcgdGFsa2VkIGhlcmUuDQoNCmRl
cGVuZHMgb24gd2hhdCAnZG9tYWluIGF0dGFjaG1lbnQgaGFuZGxlJyByZWZlcnMgdG8uIPCfmIoN
Cg0K
