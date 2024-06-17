Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312D18FC8F
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610083; cv=fail; b=sQNQtNHEtu0msopupjSdrBkcT4S1vbqtb2y0hyZ82gQHL1IOtMMgOiujADYbiVzSHaI6yyrD0sbC3YXYTmZFtRieZBdozZ7m1qh4+zLVgDPCQTUmHUlpGp4U0X0i2INFLzJ6I/IdS1JHww0SRpTHZSvvpLXprlV7/pdhPIoMeNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610083; c=relaxed/simple;
	bh=aT7BHTx41YeQh20b8UoDY/V5pjkk4cqlZcK6UwiZGd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J4b61vhl6JjImg4sX7Gig6ZogYgHZZgo6/MkO1kSc0GcVZ+yQKa2frcUKe8YUfjIGtJoVkh5lLu5rELRon36T1XCdEeObKGveuXgKmgS6/2yJPG8jN2iYXidG9JiYsUHRVuFBsT5ZsEyZ/kurrjI6BDTyFOUi5geFGIW36gSLsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PsBZ/CSE; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsBZ/CSE"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0715D4080C
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kOMf1kEi8qn for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jun 2024 07:41:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=kevin.tian@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2DA9A4057A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DA9A4057A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PsBZ/CSE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2DA9A4057A
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Jun 2024 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718610081; x=1750146081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aT7BHTx41YeQh20b8UoDY/V5pjkk4cqlZcK6UwiZGd8=;
  b=PsBZ/CSEeN3y+tnYwkLbZZQYKosUoAe+KHxQcylD8WoA7d4nY+h+j14a
   X5redTN7tpUD1BF7pzXc8Xxl1A+yg0FKyftEg9cwCK3cjeT6DU/sHa9WB
   HNiMkYafG1wtw6oUA9/RkNDbAVlj3cCiMz3jrskdqEPvgzniKSoMCNWMC
   2Y0IiG77m5TBWKoo4ivwVrpMTgECMCGdwTTLBCxmX2qA1C92fBaIMu9CB
   c/6asyqhGChr7YsJxHogj7IHpoBIEUxD8g8nj+4Y+QtD04iKJUmH/18tl
   XzXXo3asPpLYQzMb1QTmG7UuuDDvNAWwdMtYUW6ZWHiw/ZFB77k8Vfrsm
   g==;
X-CSE-ConnectionGUID: stZe0rsKQaGaMTwb/m/dNw==
X-CSE-MsgGUID: Imbd7u6LRsqWvYbYkvvcMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15574082"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15574082"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 00:41:20 -0700
X-CSE-ConnectionGUID: LorJOFDLRgqxCMZpxtPWeQ==
X-CSE-MsgGUID: y79ePnzSRyyRGOfMbI92DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="40997870"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 00:41:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 00:41:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 00:41:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 00:41:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 00:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB4L+WYbwF3sCAPe7s5+dLm9TIJWvbz+tt/1nTtK+05jSp6Gwo1ZD3TwB7iIGUfrtrAZfE0hH0Q906RyGIcJfXeyRQv5KWbzRo8B97r2Zg8TciyhIqkqozN/D7newZ/OemuE9PfiNLQm5GuQ1dtWsdePhf0bR+9JkelCdPTBY4O8d53QqwnUyef/okXdhsTu7JGgk7kRBan0X2/qUcH/tFuWEDB9Zatv75Xq0BKstXv7pKJ/FMdIm2//cicTI2ue3Ta+YxxNCPrXpCWUaQHZJfWV0zIipphSCEZdrC0XLT8l2+lVer4UPvpU3d9F7k8eGYn2TibCkMmQ8i+IRZPQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT7BHTx41YeQh20b8UoDY/V5pjkk4cqlZcK6UwiZGd8=;
 b=WORb00D/m80JFcBDtoDfTsCru9bPtfL7+b1YBGf26YbPsw22elxKLhb4dyeF+tST9VNw9Pz8p4haC6vC/7/D2HVPeB9fizoTcxWn2IzkuUqm988wrRr0jRLlT7dA37AnZa7+hLmQNuB3fCbxc/VKC6vx8KVcTixi03uQg9X+zlWD5XF9G0/uEuWAhSrb93IdsNaXTqBiiVwjUSDkx08o9II9mZpjzSae5+u262snzoSUIQXovQwhmogrQtNag6tmam1NS8N0A08Vun6enKg7ByGypXUU014yoSwxYfTDK5nupQ0TUMzKSxogTTB5OhM+lQfAzpxwA2lYmIR75dPPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 07:41:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:41:11 +0000
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
Subject: RE: [PATCH v7 03/10] iommu: Add attach handle to struct iopf_group
Thread-Topic: [PATCH v7 03/10] iommu: Add attach handle to struct iopf_group
Thread-Index: AQHav7R34enyUzDkSUKnBH2YWednBrHLk+qg
Date: Mon, 17 Jun 2024 07:41:11 +0000
Message-ID: <BN9PR11MB5276C5ED6E9CEB0B22B0CC108CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-4-baolu.lu@linux.intel.com>
In-Reply-To: <20240616061155.169343-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4662:EE_
x-ms-office365-filtering-correlation-id: 93102741-bfbf-4445-c655-08dc8ea0dc23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015|921017;
x-microsoft-antispam-message-info: =?us-ascii?Q?+nqwW3G3ZR/2cYNH1TQNPbyyhvED4U1VDGTdKO2IReS5LEAutM5ZPEcjp/hi?=
 =?us-ascii?Q?DCAW9azsnvnCl6wqpWd631AqmOtLhn9zu3yvCmhfx8PlCm4coNhOs3/jorLG?=
 =?us-ascii?Q?4neacSs+rTh//J7BtJo743NzBpzKc6hfPwr1vuOaSRjSyWAPawUsZIcEVWwS?=
 =?us-ascii?Q?yELM6zOY+WhXp6FDS4rY9K4x5VRLPJB9MKSNp3+NmLKlbrioYtHgBZYC473B?=
 =?us-ascii?Q?3hJdhx4VyTGmX2JPIcsn5Fb6I5ABFZRlblnKyNnr28iTrwdyRV/Oi2N1dQ4o?=
 =?us-ascii?Q?pwrw0q9rBLHxhOCkclvs8nr9XFkr8ctx0IeQtLyCNnJcvcgQxq75P58nXGFK?=
 =?us-ascii?Q?c7ezj4q4PnJYp8C9ZmfgFKxClWiSuu/+df8xXn9UME3L9nk0VeHU0TznoHjI?=
 =?us-ascii?Q?KY3u1oQeRQyHJNI0/GzwsnM5rb9asLuaL1y+FCF2VfsLllt+YhNzPw4obxcs?=
 =?us-ascii?Q?QwpRTaK1gSWSghrPkSIVRhqQZY7mY4cHHLCfRXM+V7RL8F6kD0/800eigCe2?=
 =?us-ascii?Q?RCRXqGeRWdIOBpoMUEMl+XH9ZFkUqUNkopNy4u4ODhddiownSYj1p4epgl0k?=
 =?us-ascii?Q?UAvRcGNgQqwXaA7uUejX5wiJutb12uMXiWW3ZnYsf7/mKxbSeICI+UvrhNoK?=
 =?us-ascii?Q?VgDMvz7dJrz4a6eO/NysWNt2oF82bjc4kMZlqrBCNslw7Xm94dc3LUFPMRky?=
 =?us-ascii?Q?0XptkTC0IrDPP+Fk0LDUxexaNpbVSuEy7xBkRBx30gzZURm7yos+3VJ0Fqvm?=
 =?us-ascii?Q?ISSbNlvcfe+uTqrZevNfpAHfK/NWw50P7eBzyV18dpD8md110W6qlUAv/7Yx?=
 =?us-ascii?Q?i5QetwsqHEqzZVMHG0JSAeVuUT3JUPLR3PT4rgJgjW0SqYrJ+DC5/xcLu73t?=
 =?us-ascii?Q?lLWUaQ3onxPGNae84HDxLBPj5CIRL77R/P/2wOZrviEvkzIdFc2nW3Jr+Tr0?=
 =?us-ascii?Q?EYGoeuZdIu3zGyrZKjju9VMFI/3nHVITAKJvnn7mz5GM8ce0vJp5vnZx6G3Y?=
 =?us-ascii?Q?I1wTW0KhM/B1lmV96/vVMCI6mMizMNjzvCAPHst4Dm1Ssid34w+i1da0dxne?=
 =?us-ascii?Q?tEZadXkEfNsM+cIupqHkE3iOHD4YrKwcKSmjPyo36/xWCtHpWzp9Xq4AhslP?=
 =?us-ascii?Q?yZQRpG4mrIm1gE2mf/6DkSNc/DWU+XWs95m01Tx1bBzCbHoJWKvfeJhKHKo0?=
 =?us-ascii?Q?pCxnNk4Ckeczvmb56R/LM0P8HlCqeZb2L8UmawsRX9HX1cTm/Do+bwqm9sqW?=
 =?us-ascii?Q?k0xXz7CGx/1dJ7fcvCZTNesE+0amyzccSmL6OWxQMjEJOQWMa/FcukNbHGgz?=
 =?us-ascii?Q?McRRyTDoD8U2EQlhGHsaQlJuR5PMCZPox+1bmR9M0iAFKS6I2bNVBYBPC9+p?=
 =?us-ascii?Q?au7GCOqyvWfP/YaY+Wnu7wR0e++v?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Lbp8ZAZgu/LbIXt2YkxED7TPcxty3AYK9nC9DxYdhtkv5CyqIdYcCw/t2Hj?=
 =?us-ascii?Q?goJ3dspFCcn8jRsJHlgyxZ/5ka5QglPgVJDp6BBVdUe3LZ+AgLpsrNUE1gHP?=
 =?us-ascii?Q?mg5+9GRYwy6J8+zEFfYMFpeStB57hxOaFZfNqQHBPikLx3xsgjqXI2NjTGyC?=
 =?us-ascii?Q?NO6RHRa5XnaUcXMyxJ4m5QJ4TYMaEiY8oMZTBbdr6uTajbAeflqcEFhIw/9F?=
 =?us-ascii?Q?Sd5JnAffODCxbamiRBcAcWBpji1GS68WEbLbi8uLk/btQek0lLN9PIAZghgo?=
 =?us-ascii?Q?i0p0FqFdF/QasJZxz3j36DyTwZjxxqj/R6gFlOZpKhGBkbK+38K9z7ir7iDE?=
 =?us-ascii?Q?3rnQmlEZEWNqNa/moTH1sWoV+4qrYcHw8qE4DA+mLa7pU6cdXMB8FyX4SNGw?=
 =?us-ascii?Q?7S1o7mh6SBdJA8wv6SsD8IAePtawMSOz43wJnqjMpQD52Weu8N8Jhu7H24m+?=
 =?us-ascii?Q?N67pxO/wtpADOwYUQ8eQzO7g/uuGfS6PK292ni9sGu3DIymbwnQ+OHCoj5rZ?=
 =?us-ascii?Q?M4wLNQi2SNAMqYSf3l30twVe6XIR73u+fQliqqwiySp8Mcikbq/uLZJmfrU7?=
 =?us-ascii?Q?VQev6Yt+fEsTowZV1IjgTEq+pukS1WwxHiI5v4T0a4Zz73+0vO2KlTYxqiMY?=
 =?us-ascii?Q?VlzxWI6hvMulR9u7UsHp5TAsdednQ7HstJSpn2bcPpKoNNV3gA3sIhVxpnOb?=
 =?us-ascii?Q?pdcLtCMlZYVEedMpSOb/M5FukajgCzXXac2FFjZia7mkwfA6k2n3s+i0Y/hH?=
 =?us-ascii?Q?3BWlvDSzRQ/f1AHGrsibpKZK5hqXDoJTc2QAhCv96FkpPTyOndgw7kN063S6?=
 =?us-ascii?Q?Og3A839ngZ6oUO2Humr80AzYDya6VFK0OA73DhqHhvgzfHYzgl708V0R28Or?=
 =?us-ascii?Q?hAX+OOoMT9QBrviCLIKa3gWQS0PAvMoeUoRhVqGaV3rIV4kh77U+KBtkxlnN?=
 =?us-ascii?Q?+pNtXuMGUHChYw59ChJ4Et+Hl5hkFqzPjJXI30FBOIN0oqW7E+wjIDBFHoHq?=
 =?us-ascii?Q?wd6d61EvkGC/sIKzsI0K/KxnGbHrubiYD7wuYQ6fuqhbaN6w0SiPWkQAm7D6?=
 =?us-ascii?Q?o5OROtSxfwWcaXheNVrT1imNRyVB78fNQEuYaRToTG0IzVz8xlDfAomprmOT?=
 =?us-ascii?Q?dK3cvEmPNj57B/w3mfhRPh2gyi0HvSPn9CsDP7Y1xLyuQp/VVewvT8HKfesY?=
 =?us-ascii?Q?gzs+8AmiqJzXi/vpgeze/fDMwQiZfvYvFqBFV+f07CTBdPjFB7QLuu1bR7oL?=
 =?us-ascii?Q?3SI5j3H0gX7FfAlm+VCESEJhEMgOVsOWPXqw2XGj1Up55G7fdDN41lFFOwFv?=
 =?us-ascii?Q?5OyQvsLelpji5fCKM9MPOVXnjiTIc/2N+kS6OsSaL0iJ4xEVKFBgjh1KGMPa?=
 =?us-ascii?Q?blemuPVnPj4yMG8jAO+sIZlVsXK2DL/26rEx23nlluLE1jiQdCTL2N3voM09?=
 =?us-ascii?Q?AAnZyxp9+13ekA/tfwzPwjFm32iv77sre8/1Ams8L054fzgHEP3nQnV2uA0G?=
 =?us-ascii?Q?VGZ1VVuY9hFGXx60fWTPDlf0c2ERFwbJwvJK6sqajtXFOKM/4BH62ZB4OaZx?=
 =?us-ascii?Q?aWfnFMINp/EGn7yiyhEoQ818gzctplkijdaFALU6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93102741-bfbf-4445-c655-08dc8ea0dc23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 07:41:11.8951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjgVfIGCBRs+XlWiGPE4ZYx/fZ5IYTfnmxXdhcckgoQii6NK8uCK+T1ktdpe+4pZdC8wg9CneJnt+vGUJbJJyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, June 16, 2024 2:12 PM
>=20
> Add a new IOMMU capability flag, IOMMU_CAP_USER_IOASID_TABLE, which
> indicates if the IOMMU driver supports user-managed PASID tables. In the
> iopf deliver path, if no attach handle found for the iopf PASID, roll
> back to RID domain when the IOMMU driver supports this capability.
>=20

above is stale.
