Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED662171
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757455; cv=fail; b=bj8DaAYzHEtji4/Teo0c6UY6wI/+vhquee3wGh8CnjA+740De1LWiT3s+rxPo8Qsgs6PRmuyOZOo9qzZUPeOAKnM0tJl7o1oPW4eEzh/d4+MmrKcYU/HHvzE4uaLYDLXKkI7RVElwKATRCltXWxCYLmoHeDSj+ENc5Nyy5cNoio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757455; c=relaxed/simple;
	bh=yZMlAUGhhxiq0q2SfxQ6gh3TtSyOY+v7FhOu+Ar45kg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lgdOG5HjuthzWIMeSCUW2qYq1abjrIqBOeZbhuQXlEcT8x1XwwjueJdmxZ01nnkfuZhk22uxQGl+CiAT4jYX+6vD30auGVAGwD8GWlcLpFpHY3l8c6gFpwq+fxa+zK/GlVEPPzPrH8ZhvT1VstYOf7ucDdsYWRqDTXqPNWyWxvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2z4goFS; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2z4goFS"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EDBDE40B1F
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:17:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7Zm6jbQSF7W for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 07:17:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1F8AD405E2
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F8AD405E2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A2z4goFS
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F8AD405E2
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715757453; x=1747293453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yZMlAUGhhxiq0q2SfxQ6gh3TtSyOY+v7FhOu+Ar45kg=;
  b=A2z4goFSGEV0+ytvnMuXH+aAf64Kyqc9sTaxMKqMTTwvzVG0XUgednGQ
   rgnjxyRhWFbP4w29alxuP5+jXSVlsrKerH0Kc/+Aq4DoNA8Hxyv9WxtHc
   YB1Bf/imN2rFRIi+rj3Roo+iVTgSqo4WYiZWwHQ+LLqF+n5lOACuii1pw
   B5jFxyvlFSIp0Q1rJIi0emuGzGvwhmazeLd90n+Woj2W5s0M37/Qrm9qb
   0ZPpuqmJB+HNEiSYVD/E6mZ6u7NlqMdyHjkrAVVu2wyVcAZKi8ixwxiku
   9M0cDoqyfEXtsoLKqKZVGh5aG9qxg/y+GGfSJr0PfirjvyUYTyaARxrvl
   Q==;
X-CSE-ConnectionGUID: I8lBUo88R0CdRdnPbqBuRA==
X-CSE-MsgGUID: F59dpQlOT/maMo96RpaJGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22459307"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="22459307"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:17:32 -0700
X-CSE-ConnectionGUID: IrzaBLs1S22P0lYfxkjvmw==
X-CSE-MsgGUID: LVmcOcvCScONZ2cG8mXiig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="61780459"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 00:17:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:17:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 15 May 2024 00:17:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 00:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRY5QfWGqbGXpG9r8Nx4ZlYdb+nejifsuTLDd4pvP4flRNhH4lXpOuhfh9uUjphRuTV1LEP+aENw7UpEKbyruqWqT/jUidsIp9qt5KZzWdfs3ybfUcWCJhx0BbF0eyOz5y9hmDcg2r5uJgDoby5nJYeAmsRnOpmkUe/LeSwupiB+SjZb1EqwZOUZfAIMuqGzgCcLU1vDTkywR4F4yC3WZCxAuUTVmaVwlKcQ+ZIDP6ZHgG+5hywYwS4jjKJY6iOMuCqimZ5t80HmyU6wGJLmwS4Tlsa7iNQhcAA31Nw7eG2nvqdDQp9mLy2KTJjqfE9uhqEaivtY0zEcxm4hQlESDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsPJR72aT40xVCLq7fvAh5P94hgFZwqN0OauB19zJMw=;
 b=Wvz1KieflO4TBjNJIy3wwmXlR3wPWuQaLjvcrQ8iG3thQLMiatTd6d9qdFkLGNKblZhrCnAoRXsw3+0oJSilV34rcfIKj63ueS7HjFb9pu5kIJHSid/sRvGZfQVlR7ePx8AsuXGOsd0gEmvjjfdwGJorEiTHOJkeJ32y3Pg1bJ9zJRvbAgY0QWWYP0CTKkQraaN0u/sA1JEhgF0tR32hJdLWvijiZCtI6TVofURaEsWgY0WUyUlb6sPFvueIWIwly3jcjx/LOnPp7nNrQw3Gv9o2wRopcJ1vbMxyVesRDbSjK9SFpmPoY1VdpG1iF7G39J+DsBhTG3q7rTpEoXubyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5223.namprd11.prod.outlook.com (2603:10b6:208:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:17:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 07:17:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v5 1/9] iommu: Introduce domain attachment handle
Thread-Topic: [PATCH v5 1/9] iommu: Introduce domain attachment handle
Thread-Index: AQHamw76XegsRd/ffUStCLWsuFz9nbGX86hA
Date: Wed, 15 May 2024 07:17:29 +0000
Message-ID: <BN9PR11MB5276F0DAE4B5F63513C38A158CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240430145710.68112-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5223:EE_
x-ms-office365-filtering-correlation-id: c053e132-dc8a-421d-1f0e-08dc74af1488
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?b81grwjmayJ1ouUUm4XIb+DDFEEfOrXp6PvF7TWQuIDnc/oiVQvJfCQLMNJn?=
 =?us-ascii?Q?Yp333WQI4Lq61RiZed0IjEVzPaKZe8W6GGIpayN2nNMIJoVfhWPSQWYOk8BT?=
 =?us-ascii?Q?VJitM2CijUG+xmdFSkcGHxxXBJGbLImHJWBEVqKETgEZ41sooCHln7PWVyLR?=
 =?us-ascii?Q?VL57GeOD63wHQ3D+0v9pFdyKCmYepWFFOuopAYUYc0aECG8ExjpWeHPfQ7Pv?=
 =?us-ascii?Q?FddkfKBnxULghmRKZVBLfv7ahsWZF51s0u0L//Mq60kb7gc4cv477bDYju0L?=
 =?us-ascii?Q?EF5XEKtVeDWJBqirA4AqG/nu+E8j0BnhJQ3nb98hMO3iLqDyGVriS2n6gSrZ?=
 =?us-ascii?Q?avD9ArLl/vKv8LQJVQiB2FDWir1HOsIsV4l9rw6h+o+Mnf0EYPtpsDJVMNZY?=
 =?us-ascii?Q?sKoUcNDGumKbpxwX3hPTIybGQU0Nao1XnNwQD9Qi/L1lh1ckESNH2nqJ8BRW?=
 =?us-ascii?Q?eLt+Np8p9mYmwi8JY8gZetWMj9DLxWLXHZTznRWC6Jm6Jy16pO7ZnCdroUkP?=
 =?us-ascii?Q?4EZLVbQ0GVCKmL0Az3Hp3og89XLdIeBgPtpicNzqI9Td5LlHfO4J6qqx87XA?=
 =?us-ascii?Q?p1/wMcNbTs11Wrbya2Ym0ES1wXCJdA4k6LKJRGw7cRU3waDuLiwsz8ULRHXD?=
 =?us-ascii?Q?Bj54/EjFZOYNWx42Qe7dsDQ+AIGpvHkmeQFzlzYTqvosMjuVE7l1xlo+UnTk?=
 =?us-ascii?Q?k4KFQ2ugCkfOzniQF/VL3sDhACB+nN0X3vJZFtlrT1bCb/bL9EfshrF8dMv7?=
 =?us-ascii?Q?BPwW1KLDkk3EpsoY2r35UTB6+bMYSD1bjoyFkGZ9FdS2VYT6zrlNL9UXdO87?=
 =?us-ascii?Q?6ReNItta0Sv3I4MS9TZ0BGOocmC6NjcTcrCAzLQAmHaV7rUU7FiiBqPc6vLe?=
 =?us-ascii?Q?s49IilsRPBDK8JL9ymW6aA6/XC5pjFvGMEEm/SVMhT2CpmPmCXN+ZNg6qj1F?=
 =?us-ascii?Q?qBZ/OXg2JJjsNUO+DQkzkA2R32P8HKe9eo3hYrQbgVUBAvEEkZYFHBBQjX2y?=
 =?us-ascii?Q?32gPH2mf8fsZrbl5nJ8+7cV977NKm9n/W8LTYy6Zd5cWZH/DaAJnUI3/2ssC?=
 =?us-ascii?Q?3rOaqO43Qn+gqS1Jh4+wF+YJjYxx2Vp/v2A9TnEpJJJwmHykB1ny/U/tVxFy?=
 =?us-ascii?Q?IZib8Gq/gZX8OQ67F91h3IRkTwhmHwHXR7z5uEceCKNHQQYMYGSeB9AFIe/O?=
 =?us-ascii?Q?SZXiXChqnMPHg/bcsb3GdzGKfzgyuR6WNH3H+/uJCB5tnIQrRG3xojJOkHJ5?=
 =?us-ascii?Q?NVZN0PbQ3azn1LisanKUCnKPzVT08CyLsL206siD/CirY65x+r1dzzkIl+Vg?=
 =?us-ascii?Q?o91nOCsStxomn/pGTPxKkDhlNnSdCIpzP4HN9fwzSJvvQBFoMy74OvYDLetu?=
 =?us-ascii?Q?UNL91yg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yFRcmbPHLsR0nh9VLk+t8gNQ/E3jVEBDF1OHRvBDtGb6oi2W9WXe6mnvBiLj?=
 =?us-ascii?Q?gflLhFefxbPOycMjzJhFq4ymP9epOPhtnsxQCmbHkTXysGyviytlWzLPkrR6?=
 =?us-ascii?Q?Iessu3v6Ry0in6IBO/TxZOXyF/tUsr3ab2luXaherAatDk/9xtFOMg64z/Vx?=
 =?us-ascii?Q?gXMWN+UUyFY/fOZS6muUUu0WEZqJFKMjdZeDeRC/hxmdesegvhCSHvT3Wylr?=
 =?us-ascii?Q?y1Hm5jJYqzuol8ejfIZW0U3ZxUuiviPIwdh57dTSjkF/rnGql5biKUGlcRAk?=
 =?us-ascii?Q?/idnPQmWEpk/0wouj8y4bwZ9DxELNwC076Wu1YB/f3mrlGR9j4CgdYkCzso3?=
 =?us-ascii?Q?822XL2rXDbBCMDqL/K2uHDwk0t++xDmvcqAV4WMsv6StwQIpVPtQ346Zy7fZ?=
 =?us-ascii?Q?5sO4elytGOvuYWFLnyPI7HX87WreO2Thg3K6W9btmmhr7vsnf6RlGQK7Myf4?=
 =?us-ascii?Q?fXD7XExm3XFvAo9TaHzQenMasMjPscbu+kHrNNNXLN9viLDTC67LSJLA3v75?=
 =?us-ascii?Q?n2eTBdHNvzPv5JNzhFv0nafNoeV8srYKWFnxdqdowVFwZpPoSCGP3lYKrZVA?=
 =?us-ascii?Q?78wH4od0dCjiBsdSkSVPSCbqkCHevePatsfro5viqhtEE4Lb8A/AcS/zr8Dt?=
 =?us-ascii?Q?SqEDc1DIf4ywIrkuJi54s10fK10wYGr3SW/1+WUf6EYpaZ5+ZkN2x665AiyT?=
 =?us-ascii?Q?QjFFecbLxurO6YVAPeGGY2Fyl7QkivjU6UV2+HD4PbEtitZZgwLPXfEpa1g2?=
 =?us-ascii?Q?fjR9If5ZzHJTHAr++fMnx47QD9DOycMQA8y5dL/34yEFJomkbfy6vYw8M/xz?=
 =?us-ascii?Q?xfbfKmhxItBAwA97jukSukt7phAt7NidWZTH90IPa8vttohF41cye9ukPfMo?=
 =?us-ascii?Q?2foIG8KyRt/yGfxUk3VXWb+y2qQn/THqs58DLsIUCsk3WmckGiO108PlRjZL?=
 =?us-ascii?Q?bRJjRR1MJaxBPP4p9KEoFrp5upzCebpf6HtJ+Y350pVAUl2/H47jYhTKu42K?=
 =?us-ascii?Q?qNizCFfBN6f4jKNnu32NDVDhuITHy1+VqiZ7thmJALiVyDAhk5FvEBqbiim2?=
 =?us-ascii?Q?TWd/WlDYxJoFMxTKlVEWGgDo5U4lH+bx0GbDinVME0qN9ljMHj+dgg3rTUmR?=
 =?us-ascii?Q?AaHx/+MBndcvVyNMmc224Sw/ODIg4MK+weomWbF2AdBsXR3OTlEoWn+5sP+Y?=
 =?us-ascii?Q?MiJmM2v01cLnc9PZ3KyxvSN+5O2clIsyY1A0FyPvLxjDYfisThxZEPeDUHYb?=
 =?us-ascii?Q?SnFNSt9GjqVAxHpKbBowC10Y2f3QCnHMkPeSL52FIer66AaEJwqfpkgUIGiJ?=
 =?us-ascii?Q?2yHaosH68vm0cPBnd7R9L9rI1mJQjaa1SK+2V0TdhGm3kCGrujhHkifhAmXV?=
 =?us-ascii?Q?opLPqsHxi/ypULOrrLPUEWhyKkDMC4rYQeDPH0dop7imM/MEWngAYRgfVKXk?=
 =?us-ascii?Q?XkLEYyvnnitM6iiipuR47HMOJ+6zJZ4z+kBxb9BAHe/0kMdicrJagEQFobwL?=
 =?us-ascii?Q?37rOq9xmIOfdnZ38yL8wuXQT7iRTtm0Atm84l4vOKhskXpH0DVyKUzFbc9Bo?=
 =?us-ascii?Q?kP18YCvC22UjKmiiWI8KFK8ExJSaSEXLhdCDNdz6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c053e132-dc8a-421d-1f0e-08dc74af1488
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:17:29.1709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wv73bUZWN/QBnwh9g+flygScKjcLnCElFjg7ALUxZRZHwnVmHBR+G5XLBC2c0ORCDQ+w0PYMEbLLplRYVs6h0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5223
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 30, 2024 10:57 PM
>=20
> +/* Add an attach handle to the group's pasid array. */
> +static struct iommu_attach_handle *
> +iommu_attach_handle_set(struct iommu_domain *domain,
> +			struct iommu_group *group, ioasid_t pasid)
> +{
> +	struct iommu_attach_handle *handle;
> +	void *curr;
> +
> +	handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return ERR_PTR(-ENOMEM);
> +
> +	handle->domain =3D domain;
> +	curr =3D xa_cmpxchg(&group->pasid_array, pasid, NULL, handle,
> GFP_KERNEL);

this could be just xa_insert() which returns -EBUSY if the entry isn't NULL=
.

> +	if (curr) {
> +		kfree(handle);
> +		return xa_err(curr) ? curr : ERR_PTR(-EBUSY);

'curr' is not an error pointer. You need ERR_PTR(xa_err(curr)).

>  int iommu_attach_group(struct iommu_domain *domain, struct
> iommu_group *group)
>  {
> +	struct iommu_attach_handle *handle;
>  	int ret;
>=20
>  	mutex_lock(&group->mutex);
> +	handle =3D iommu_attach_handle_set(domain, group,
> IOMMU_NO_PASID);
> +	if (IS_ERR(handle)) {
> +		ret =3D PTR_ERR(handle);
> +		goto out_unlock;
> +	}
>  	ret =3D __iommu_attach_group(domain, group);
> +	if (ret)
> +		goto out_remove_handle;
>  	mutex_unlock(&group->mutex);

It's slightly better to set the handler after __iommu_attach_group().

doing so is aligned to the sequence in iommu_group_replace_domain().

> @@ -2211,13 +2307,33 @@ EXPORT_SYMBOL_GPL(iommu_attach_group);
>  int iommu_group_replace_domain(struct iommu_group *group,
>  			       struct iommu_domain *new_domain)
>  {
> +	struct iommu_domain *old_domain =3D group->domain;
> +	struct iommu_attach_handle *handle;
>  	int ret;
>=20
>  	if (!new_domain)
>  		return -EINVAL;
>=20
> +	if (new_domain =3D=3D old_domain)
> +		return 0;
> +

__iommu_group_set_domain() already does the check.
