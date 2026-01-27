Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2A284898
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504100; cv=fail; b=ozRjA7n0aC7ac/ku8BembxMvh01yjyucZ0InDV0bRb4iFh2jO3osNw4OuUD9eKBMHBPmlt2+KuJXklrhYlQmP1p31K98yZpX1w1I9/ls9q53O5ni5RD6jtXZms6sobwA/mum/sxz+p84VLqrwuaCMcnFDgb716zlbNjIlZlmhVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504100; c=relaxed/simple;
	bh=d/T/gm1qB8uaBQys4t9X/u8fkE4Jei8ICMYrE0JB/yg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4pWaM9Sh0lYPpuQb/ur/0h8HpNkDdBHQJlgNCVRaXZzT5cKTSeOdlt2o3UhCV/xteSHelcGEsQdZXjiv9+PKi2yhpWZji80YLLty4bEyd4pB/mGDExd2yFc1+7NE0T0VqsRDKdoj2aeIviZ9aJ2kacXSFIi0mSekJ5hAqvaz3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dswwMXPN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RMBf6425; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dswwMXPN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RMBf6425"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769504098; x=1801040098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d/T/gm1qB8uaBQys4t9X/u8fkE4Jei8ICMYrE0JB/yg=;
  b=dswwMXPNL1tg8VjZXaBZHropIuSx62IdB1fZSaXubYVZF+SuIksmEw69
   0cSipoFOwiVzYKxjYpP3/IE/ODfiFKP/0p7UVhyzPxJYCk56Sf6iXW1Iy
   2Vx5pnhF4gpRvVlxqvNA/KzZ4b7IinoaX0Wv/qm89ZLOynMnWv6uD6IUD
   YOlfLK/5+RsoFShvW7vYWBUi+hNaHHVE45HGCLhC8O2dftcA3t+4s+Etx
   vfT4TZ/tl1T8jZURuZb+nkpzXjHI76LLeCDCbF7S7g2R4yq20gUL9GZF/
   Z1vJdJscD9Mvt/5HOwxfDAcPzIlMUB6/AzuUypL09p6nVABbg9SiL7Jsq
   w==;
X-CSE-ConnectionGUID: WmvJ3dW0S3+IhfteMe/5wA==
X-CSE-MsgGUID: h7k/Gw1eQoeLNbjhWqBNDQ==
X-IronPort-AV: E=Sophos;i="6.21,256,1763395200"; 
   d="scan'208";a="138772311"
Received: from mail-westus2azon11010068.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jan 2026 16:54:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5h7jfyUPafmKOQJRQFmxwTSfB09J82plS+wUAt+6l1lwHcUQHAO5lbxhihNEJ6EkttqyLGrntG9RR6vo8ItC67DAwLvVO2N954sMyf+j8MlTm/A2C15AJk921P7mTe+2/OOAciawysVkBHwEREtX7WGdoXgk6RmIEDq7CHiZQOtGfkRUy+V4epIer/LNz9DEcL5TzWYuFWQjj/HRdRMPzcLF5yY/mLbl/0vQ2c4NW0VJtM2x9KUUO++wPY2KnFgprYccy8faFcQ0kMYS9WJqd5pbb+bhj+k6u58iMcQjBl/CanjIf+QbVm+jdnzS/WB4nitpK1Y5rS8ltACRAlm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/T/gm1qB8uaBQys4t9X/u8fkE4Jei8ICMYrE0JB/yg=;
 b=HJteWcUOREWu6tnFhKI6lgBrPJ4RTt+bw28ViPT39rzNp4IG+RzQNIof/moJt9X8xKots6d1VUgjm268f4oIbWqRN28LmiD3aBz62dSXfFQ8GC1haybk2K3gUMLrh0ZAeOtUu8TqSZ9y9Fet8rJEevRRTe5xV/dmSYYidAYnHRqtHkyxMQ3vo94gBjHS1WFQ9ynQvtUUioczZfRMTY2jWR/Ssmo9Ag9fBJ2pwGwufFsnwcVqseO9LJcwcE6sAlPWRVCAQfIAqWbF32zVctm11blQUTABCCPDEykLPUcjRVfNbCPiWuxbkqNw0FhXT2VOwAgOYRvJwM+XfIKN5fxxTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/T/gm1qB8uaBQys4t9X/u8fkE4Jei8ICMYrE0JB/yg=;
 b=RMBf6425is+ErwCc3ssCVa+ZehpBcluh4M/UMlWPACwGimEiNGwp+hZnXFlwmjvf0Eiqs4W90RVo8HaZQ9BSBBSPKy64vssAskOGAqTwvxEr0iqAZ6x4w9HPrBHjAvFowbPwe1eEvqHlH/EH36T1r/fuNn0GVj0TbU8qpiiW3Y0=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ2PR04MB8534.namprd04.prod.outlook.com (2603:10b6:a03:4f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Tue, 27 Jan
 2026 08:54:49 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Tue, 27 Jan 2026
 08:54:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Alexander Graf <graf@amazon.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] virtio: silence KCSAN warnings
Thread-Topic: [PATCH RFC 0/3] virtio: silence KCSAN warnings
Thread-Index: AQHcj2h4iIohDKL1Vkmd8mad361/fLVltGKAgAAB/IA=
Date: Tue, 27 Jan 2026 08:54:49 +0000
Message-ID: <99e36842-f267-4881-8c5f-45b41df76490@wdc.com>
References: <20260127083926.865555-1-johannes.thumshirn@wdc.com>
 <fed4ce78-37c5-4bb5-86de-6d60f053dbf3@amazon.com>
In-Reply-To: <fed4ce78-37c5-4bb5-86de-6d60f053dbf3@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ2PR04MB8534:EE_
x-ms-office365-filtering-correlation-id: 9898c422-6d2c-4122-b97b-08de5d81ba8f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzVvRmlkcXBxemppYmFzb1RxZmFxTHZzRXBDOEZwTmg3b29DZ3EvREFLaFdm?=
 =?utf-8?B?ZEpxbkFONm9FUlRieDhWZ0tDMVFUMW1oT1ppdE9pUzNuNEpKR3k2Y3FaK05j?=
 =?utf-8?B?alBtYTV5bXhFQUY4Z3FSY25iWWZWa1RMcEt0em5obXNRVmlQTFM3ZFNEdjNE?=
 =?utf-8?B?Mk50R2hZRzJmUmtKT21CWXZGRE9za1ZBQUt0aTd0SW5wR3VFMitsRkJZcVRl?=
 =?utf-8?B?dWtpNkZlenBqWEw3Q0RsK04xZTg3V0RSOVhqYkp1bjhrV0JYZExLNVhWMWw0?=
 =?utf-8?B?MzJrdmN3anJRV005KzBoeE5UMkxDeXFEc25oT2MxNkVNTVB3OHNkdy9vK3d1?=
 =?utf-8?B?TGZ6WDdlK3FvTU1US0ZXWGwzRFZPajNleUZST2pucEpwSmtVRFI1QUtXRzlE?=
 =?utf-8?B?MHErOUlhWjJoUkZmenMvNjdGcGVwMFJZUEVvNlBheHlrZllRUnRTazExc2hm?=
 =?utf-8?B?SytkVzVxeWlFVnR2M25jcU5idXBTdXJiYkFwU0RiZXFPVDAyQUpPYjl0aWJI?=
 =?utf-8?B?Y1UydURTbXEwQVJpWGdZQlBDTE42YTFJUEUxejRDZi85KzlDRGpIblJuRjBw?=
 =?utf-8?B?ZTJZMjdmSkJSeFNNUksxR2hqNlp4Y3hBNWdGcldXUHhma2JoQXBXYTFNeFNV?=
 =?utf-8?B?YmhGSFRjRjFzQnFiL3pZL1pWTHBXdXJUK2ZMdmZCU0FMN3F6VlJnc1NDMmli?=
 =?utf-8?B?TlRVR3g5VWJjNGlweXlJbUpMV29KK2w4eGtNb1h2cko5SkZteEdCUFJIcDYv?=
 =?utf-8?B?b0tIaGpKNnZaZ2dqMk1qVU81NnB3RTFLNFozRHZNTnRNSFBlUHNSL3ZKdWlq?=
 =?utf-8?B?dnBESDhacGRrQ05wdVVsTDlqN0RKS1pHWm9ucVhWWDBFY3ZRRGhBKzV6VW5U?=
 =?utf-8?B?K2FLTVQ1WnZqR3F1bC9xUDBWZzRuZ1dRWFArL3RFb2JQUUQzcUJBZUN0UitN?=
 =?utf-8?B?Um12OENaVXZ2Mzg2cFRmYW1SZHlwWjFQaEJ6UEJ1N0gyL2hlUlNSeFlGL045?=
 =?utf-8?B?bVNZMlV5ZVdXcnZpUE9adm5taEIvYVc0SGt2MWtFTVpqYjR4SURJRUZMT2tE?=
 =?utf-8?B?SlA0RVdFOGpqT0Izd01Id0pSYzRlVExXZWFCT3VmZi94ZUxpWlFRVzFJaVJj?=
 =?utf-8?B?aEZZM3lDWktyUzdFeFNBM0FuUXJEVnBIM2psZmQwaHZRKzJTbzRLc2hmNzVO?=
 =?utf-8?B?VitPYlh4dXpqb2VWaURRc0RGZUJ3U3NTcG9GVFlPSnBmUlEzZmd5aWxUVU8v?=
 =?utf-8?B?MStSNHRQMHRaNlNsZzh6UGhkNU9XRDR1WGIvVUN4UTIybWVFNExicUdEUzlS?=
 =?utf-8?B?VTFDWkZ1UzFTZXlRUWhINzc2WW03dzJhMDMwL2ZLMGhZUGpIWWFjVDMzYm9q?=
 =?utf-8?B?OEMyRlJVWmh6bmJxSENSUE1lUmtmYzhobDhLc0tpWUNTbGV3dVlTS0U4MUp1?=
 =?utf-8?B?T1dhVktSQnR2RXEvekp6UlRFNzMvVnNRbWY2dTc0MjcrelgrRmlnS0hDR3kv?=
 =?utf-8?B?am9UR29ocHp2aThwYWpLSzhmOVBGeFIzWTBuRnJFclZQakxXTUt2dDRUQ2Q1?=
 =?utf-8?B?Y3MyWXBpWCtxK0RlK2c4U2JicGF5K1ArQU9OejZnOHA3Q2dHV1BaV2tpM1NF?=
 =?utf-8?B?K2hMNjhHV1NCdkZNUHRtODM4aVNUdVB4d0c5eEV6eTNSWGtVL3N2VGZSQVhh?=
 =?utf-8?B?VzA4VkRVOFg4bEI3T2VFYXpxQURDNnloRThid2xkKzR3OFhWd1M0SDJuTzFj?=
 =?utf-8?B?ZFRFT2NLd1NOSGF6d2pKZVVuQStCVmhTUFU1OEY1RTRXM09OYmVMdHIvbHha?=
 =?utf-8?B?dlJJNUVyVWl4SFlSZWhqMHRCOHR2Nlhkb2wvZnVvNFhLdnRxeGZnTlhIcGNy?=
 =?utf-8?B?VENxM2Yya3RLSGtRVkcxL3RvNE4wT0ZYWXVUc0x0NVJLdmlWOXVnUGoxeFdC?=
 =?utf-8?B?ODhIbUgwbjBvU3Z5WWhLV094bkF3S3JnYmUyUGNzdUNaRWZaY3BpWlJLL0dG?=
 =?utf-8?B?T1U4RFA0VnN3eDAxMzluaXR1WlpkTnNzckI0bzl4Q2pjSnh6dEZCUTA0VHQz?=
 =?utf-8?B?Uk1MU2xaV09wMllXTlpRaVBWVVFNaHk5enJsZjRzMmpoU3lPK1RWVTkrSUNs?=
 =?utf-8?B?ZkxubS8vQkQ5Zmc5REVvUVpRSExiZTN0dnZUZTYrOVZsbThhczBJcjZuZFBV?=
 =?utf-8?Q?l/9zFWdUwTWs4Bau2SPz4q8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wi9Kb3hIRVFDbU11NzViVk8yQUQwS3dPcTZQTWFmU3plcktvbTBVUUg4YzBM?=
 =?utf-8?B?WkFKc0trb3JFQWgweXpCU3Y4eFMwc0UyalFZb2RGdlhDak5PYytLclhnUHZB?=
 =?utf-8?B?TEMrRlAzYWJsazlBbUVDeWNTa2ZIdC9lc0loYTZ3cm1hcmQrSjBKcHROOW9M?=
 =?utf-8?B?VWRlaU5ZNHZ2MzFVTC8zLyszY2ZkRmN5YVVUWXAvRDBmNXNKa3cwQWRsZEVG?=
 =?utf-8?B?QlU0WlRZdXdSNkM1WTBIVU84TStjdFliWlFTT0ZSa3VqMWd4UUpneE1NZW85?=
 =?utf-8?B?Zkx5SHBONzVJZ2V2b3ppRENQcHZESEJLQkdKZUREcCtnYnJNN29HdHZDUjgy?=
 =?utf-8?B?eGIvWmF0b3FLNXNvWUh3c2FtSFA4V280eGl0TjNLd1dOdmFNTC9zZXRhNk1I?=
 =?utf-8?B?OWl0KzM1WE0xWkY3dmJJUkZnNlJXbGg5bW1KRk9mUis5M2tEV0pmN2lLOGNR?=
 =?utf-8?B?Tnk2NVY3eU05OFhLVXppNTYwSzdxOEo1L2NiRmQ1TnZIRHE3ZVUwQXcyT3hC?=
 =?utf-8?B?RWVTTVVuSlJuZjR2UWxtelNpVzRva001bVp4ODhPV2tsSks0V00vVDRGQlVl?=
 =?utf-8?B?bDFGdkNpMDdacE5lMnpXTnNmSWNNMEJnSnA1dGFjRnc1c2hESlNyZTgrbGdV?=
 =?utf-8?B?cDYyUkF0QjNKMXRYZzU4TXNObm1HTTJ1NTdGVzR6MGt2QWFDRnhGd0xWQ2JL?=
 =?utf-8?B?VEd3WmEwNCtxUHhUTStiQ1EyNHNPMUgvdWN1WUhzU3lTQmNmaTl0Z3VJazI5?=
 =?utf-8?B?TlRCUzhDZW5LVUhLVWM2cVdjL09NZzFtWGNRUS9BZGlaSmtGV1Azazc4OWhG?=
 =?utf-8?B?LzAwcHc2aXV6dHh5WmdELzRycXNHY050Vm9lWlpKbUVaZ09kSVpBMktyZEt0?=
 =?utf-8?B?N2FVSkFYSE1McXNwdnNZN3R2U1NDeDk2WmRQZzhhNXVUMlBPWTNRcHA2dmVr?=
 =?utf-8?B?WjdnQ2JNdjdpeG9mYjUzS3BqVjNvSWZPd0NaZS9rc0RtMkR0RVkrZ3JpU0ll?=
 =?utf-8?B?b0wxc0tyNzNBbmE3WkpYR2VoUC9qemxGbzZDSnJZL29XOG9heUlIaDRTV2g3?=
 =?utf-8?B?V3RGQ0habGd0SUJhemJhOUl3RjdwOG9ROUtZNFl2Mzl4TXV2dEY5SXFhamVj?=
 =?utf-8?B?MVpoMmhWTDAwRzRaV1hTcFdNZ0wvNFBCbnc0YkcxajhaQWI3b2M3THI4UVhy?=
 =?utf-8?B?L3NBMnVwcm5jb2x4Z0FOeWwrenRtaXVHUXRBWXN3MFVRb0ppZHRUQTIyOHR6?=
 =?utf-8?B?ZFlBbmdFcVdmYmdVTUpZNHp0bWRoYzBzeXcyL29DaGxXaHVJUk5iQ3gvZjNX?=
 =?utf-8?B?YmlneXlTWG1vUStnNitEa3FiWE5VNW16Tnd2NWUxYk5wZlN2Tk1TZnVqUFFl?=
 =?utf-8?B?Q0VvWHdUL2RrM1VNT3JteDBzeTZHKzRCWmJuS2hrbHhlZG9hSEZHM0FjdTF1?=
 =?utf-8?B?UmlEbnFmblBDRzlqdjY0SnpBRVEzWkltekJUZW1JL1FjY1piY3VLcE1scm94?=
 =?utf-8?B?ZXloRzZRVWFMbytVbGdDZXU5TTFDcFRxZG5nYTZIWWRTT2Evb2NSTnB5TENI?=
 =?utf-8?B?L2hBRlI4a0VucWJlcjhOemVqNC84NVBmNlVpNXg3ejZGWSsxQnhETTZhWkpT?=
 =?utf-8?B?T2xFam00cXh1SGx6MXFKblQ5WThuWWc2bGVud2hEYW02Q1FGNEwwSnFVVXBG?=
 =?utf-8?B?QkpiSk5ld2l3M2ZvbWFRZ1BIM0JTVmt0RTcrT2FEbmI2VUZDUytnQjlaK1Bl?=
 =?utf-8?B?Vm1Zd2JpcVZKd2xwK1NzWFo0TVdRVU04MWd1bktueFJnSk4rQkRLb2VkYmVY?=
 =?utf-8?B?YXduOU54YVg1Z2lSd3BZRSt5SU9VSDdjdjNuUDF4UDIweUVDT2FYYmltcjMx?=
 =?utf-8?B?VW9tb1FKeE50VGl4MXVGM2gwZkpka0dJdmR2cDBXTER1NlJKblFjZUcvdm00?=
 =?utf-8?B?SUhuSGdHbUVsMG5hOFV5OEFiaXlhWXQ0aHlndURRRXVKa3dOQWpVb2VXZUFM?=
 =?utf-8?B?UWJnT3J1elZzdVBqS01YOU0zdTlqQk5qL1VJQitBOGdVRGVVaW1IWHZDT1ZX?=
 =?utf-8?B?MkdNTzJGTlJjWjhnZllkN0hLVGJ3R1N5TFJGdnl4UjE3YTNVTzAxc1puUWND?=
 =?utf-8?B?QTdPQ2FNcWZZOFIrL3AzRm5vRjYwcWNURUhsR0wrZFY2aWl3NEpBQlhMeE0y?=
 =?utf-8?B?RFFydllIK21qRHZCM0RlZmFwakFMT1lTRzJ5TytCelVNZUxmeUdnMEU1b2pW?=
 =?utf-8?B?VHBiZmJKdExwcmxTV3dUMUxtNHc0cTVzSnN1T1lzY2RKR2lZMkIyVFZla1hE?=
 =?utf-8?B?TDMvNEJpcmdablplWkZqR29vbm0rOVJpeUxEcDFoRkRDU2loUHRYazVGRUJt?=
 =?utf-8?Q?+o38bYwBZjgxHgGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2716FA0E09568479F95A4FFC562D396@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mVeVHm/kYlusjKKlkrV+sWi7Nf5PDl+YkwfP+QkYOZ/++/z6c7Rn1Q0Ee4fgP21UvIG+rf14I9OjRzgcxp8bBU0tdiCaCW/Bywzc7C/huEdy2YPV74tmm0Pvlr7Suf916q2NAJ2bVJ5tgn0QlP4cFVJuy87gezri98gm6wuZdzlJNOJACtIZzXhfknykf0kTgmAZqvbFpRl7jKV7oEMrIYQSC4wu543y0KH1jgk+t/5vRQiMelsdkgMgcm5OD+GHmub4yQYKTwHbBNnIzv4a3bdMHBJ5JnUUfEyonvfc/NuTZXqBW8i6EI/BGuxBdwchxJikaj6Uo1a7z6FJBNdmHBDF7SFVYQkzpgeJQNuomsqhG8AL7R7Xs/nPNoUcQbTXopLn+RGMBIeqfmEpjtM/02fi1buKu7IXZBQ2JvrIv1ZtoP5Orv8kzFWVZAR/rOEY2QUoNxX5XQUDqc6BZth2Wu304jIMBkZM//N7Wh+BtKArdlSSmz+jJZnJriwRwn7ac4YjzWonm/BeK/vTmTTwGXoTNCofOB78vlancW21pyV3RcVGAgs9uu0r9K2yne9qhiTCBHwwqqH0SpsQnRI0u5Ywh6c9JuLjHda0VEhx9Hz5oUzmIgN4bIaH4TFJugxy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9898c422-6d2c-4122-b97b-08de5d81ba8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 08:54:49.4894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8oukTIieEx2hWcnWkCO81G8fojPgTjDKWsEEb/jeGcBaYiADk4FPv7udX2agFhf66muVFf7jShF8niDAgXhESfR59rx7fpCCGR1KUV8xts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8534

T24gMS8yNy8yNiA5OjQ4IEFNLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToNCj4gT24gMjcuMDEuMjYg
MDk6MzksIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IFdoZW4gYm9vdGluZyBhIFFlbXUg
Vk0gd2hpdGggS0NTQU4gdG8gZGVidWcgZmlsZXN5c3RlbSByYWNlcyBJDQo+PiBlbmNvdW50ZXJl
ZCBhIGJ1bmNoIG9mIEtDU0FOIHNwbGF0cyBpbiB2aXJ0aW8uDQo+Pg0KPj4gSSBzdXNwZWN0IHRo
ZW0gdG8gYmUgZmFsc2UgcG9zaXRpdmVzLg0KPj4NCj4+IEkgZGVjaWRlZCB0byBzZW5kIHRoaXMg
YXMgYW4gUkZDIHBhdGNoc2V0LCBhcyBJIGhhdmUgbm8gcHJpb3Iga25vd2xlZGdlDQo+PiBvZiB2
aXJ0aW8uDQo+DQo+IEFsbCBvZiB0aGVzZSBsb29rcyBsaWtlIEtDU0FOIHdhcyBqdXN0IGRldGVj
dGluZyB0aGUgaHlwZXJ2aXNvciB3cml0aW5nDQo+IGRhdGEuIElzIHRoZXJlIGEgbW9yZSBnZW5l
cmljIHdheSB3ZSBjYW4gY2FwdHVyZSB0aGF0IGluIHRoZSB2aXJ0aW8NCj4gaGVscGVycz8gU28g
aW5zdGVhZCBvZiBwYXRjaGluZyB0aGUgY29uc3VtZXJzIG9mIGZ1bmN0aW9ucyBzdWNoIGFzDQo+
IHZyaW5nX2ludGVycnVwdCgpLCBjYW4gd2UgYW5ub3RhdGUgdGhlIHdob2xlIHZyaW5nIHN0cnVj
dCBhcyAiaWdub3JlIGZvcg0KPiBLQ1NBTiI/DQo+DQpPaCBpbmRlZWQsIHRoZXJlIGlzIGEgX19k
YXRhX3JhY3kgYW5ub3RhdGlvbi4gTGV0IG1lIHRyeSBpdCENCg==
