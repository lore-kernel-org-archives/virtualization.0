Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F43009CB;
	Thu, 25 Jun 2026 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367022; cv=fail; b=EBsdLnWqkmBqGuf+4Csa7amuqzYulUIt7o7R4CIahN0GSzEEC9/S0uSIOT4sQFonBSyLyJbo+iVeYAupZ7ePvujKWYDgXiQ6I4UnRwi+qWNpYEWuAS+auj7NLEp8dFRzLCBY8M+nhSaqIpqlgCjvQCzKpqyiU7AqfUj+4bo86+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367022; c=relaxed/simple;
	bh=k0glUQdvtLkjcEhtYHA9P9oNqPWnsh2D14JkUwXnvd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lmaQbzrzX7IiAOb/0HdSwnobjxtE5uWfT0gRUiLhckVnYO/Lq2LMEjchTxK2od5f149Pb2M7ZasbY2X5QGqirHGKsSbQIaVHgd+Ubhwneq1YmPX1V67E8M4uGQ1E3dbo4e6GFo/0Isx0fiymQml+NuEWXje6KxB4q9kMXp0ievQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZL9eSFK; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZL9eSFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367021; x=1813903021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k0glUQdvtLkjcEhtYHA9P9oNqPWnsh2D14JkUwXnvd0=;
  b=WZL9eSFKYciEiWPgAd4U3m3mL8Xf4V/zCE37hmgkTy/0jSACC3o/LPo4
   pwIzK1/lRF8WYfQjoKAJS5v+sa7Eh8uqVcr3FFnyWBeIAgPMMcgElo2Vu
   kY1Zq4bC6ar3WKaotj9TWErzBUWR0olsRpBWkqrU3M35rSU7M8AWb0RX+
   BwmJ/JNJD+CMiRPAbqGtHx8Mxx1njlVOlH8joq7dBSFsFymxueLPnI/fa
   rRdIRUN6uGA0igMXh4k4WcNY7mNeuRV/N/2bk4ZRbwK5u7Exfallf7kX/
   qEwMTDIW0BmZn0Su/GQuRhn0wxJB7wR2kQ70kgPbM2xKOSUbgsvC5+Fo4
   w==;
X-CSE-ConnectionGUID: v1VQ+kBHT0uFgKTvMrDkAA==
X-CSE-MsgGUID: pN6DhgfQSK2uL4arNQJkEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83189677"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83189677"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 22:57:00 -0700
X-CSE-ConnectionGUID: WnGJhOE6TFuIyqLwPocQ3w==
X-CSE-MsgGUID: LhqTlPJ2SO6s3mb+aCY0yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="288471957"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 22:57:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 22:56:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 22:56:59 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 22:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnNx0pok1MQVlzEkfQuENA52vSmalwVay91XuUxHwLbLPAZopDNV5n5yb9MGbDbZKGD7tR0W4sQIAmKwuR9sDjr6C4Ii5Rw9XzpCgmv4WJyD1GT/E2zg1r8dpno4ttVVjwz007Obm/l4WyGaOOkvtWUVpQMQzeSAJJyQW4vN6vGpcY77mKNXZLf5uxIZKVACJi9h/gZwHkm4EFJgb3mtStu/3DRmgWCZrdiqKrqalvgKJSntKOEWpBw4GCyXDK5/uAsi6gCDJdvGw7JLnzNRdDZdPiguBaNNVN8oEeS5aTLWvLjCjGKowAhmVM9M5hJRhqFPoqkkRx3AE3DBpOid8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt7sAMZ6K03LbHL+rnWCSXhi2VWud53+LTQLg2th2Vc=;
 b=FhgQAPpaAWY3yW85xwSj0BfpVf6iIRnKENB3X8Ohx+mihFMST0/uZsNegqeTvgbfrbJ+af4nSUyBBXfbLJWrb21QxecvjHL970NmWz2/Y7Hx733Df+ifserTcriWq3qACgNBQAARTIhcFt+UM8HqH6jkmnILJPrDBUjsJQf9DugdstZQD8qSdYWBdRe6StgHnWZrN51ijcokNRUc9ZJCSc894QrDsm84alaZTweU0x3tL4kDKB/s8fYV0SELxsrs1D28sVm+jzd2dABT/Rh1D3cvm9V5MjrBrHWggiA3oLbD943vcA1KADNGSnvSPn4+RtHi3FBAnXMGmbVtSAlqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8706.namprd11.prod.outlook.com (2603:10b6:610:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 05:56:52 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0113.015; Thu, 25 Jun 2026
 05:56:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
	"david@kernel.org" <david@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "prsampat@amd.com" <prsampat@amd.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "Qiang, Chenyi"
	<chenyi.qiang@intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [RFCv2 PATCH 5/6] mm/memory_hotplug: Support ACPI hotplug/unplug
 for coco guest
Thread-Topic: [RFCv2 PATCH 5/6] mm/memory_hotplug: Support ACPI hotplug/unplug
 for coco guest
Thread-Index: AQHdA9WriOSnxbwxy0e2dnL8H6yG7LZOw2yg
Date: Thu, 25 Jun 2026 05:56:51 +0000
Message-ID: <IA3PR11MB91366BBD50B2D371EB65EABF92EC2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
 <20260623101739.79695-6-zhenzhong.duan@intel.com>
 <ajvOP9NwqNstgNvl@thinkstation>
In-Reply-To: <ajvOP9NwqNstgNvl@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8706:EE_
x-ms-office365-filtering-correlation-id: b9b81625-9073-41da-0517-08ded27e8dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|10070799003|11063799006|4143699003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: fXCWe1oAxFEXktx8pm5rvbZ0wrgLpc1Sw2RexLF59ZDpgecaw2pltCwF6PkjuQ9KVjULwWeOytRtlGFVffJn6qNzPbKO8YAbrW2s7I2nEwSYKOC53tvDVLKAdmKHBXaikso6Z7LMVF8wVUIcGz/XITpWyG0acy7/0lzpCkm/wRTI/7WgmzPHmg4gsYKlrbljMnRY9JEai++02FHAFFLmPZYMkgYZwhNoBe2nPM//fTO2sOn7vkz1BUtoEIOU1Wj02U/PFCl5ayO0uu/15WIoJPrIvLXrHfEABCO//upw6JJUPSceHdeyeFL9m62BNTjQLSlpU/trN1HO14UCLXdbiYRTWE3m5zC1xrz/xpTWoqPeO6JAD3+iRSw3WfyRhLTmnwKjOXTesUPORdVHl74YHFcACIa9ROdrrCZhodtuQlTBXmq4G930IGXE07RTAXQ7JYcnStzHJincZxXH8rkUx+5qEIa5sHMGfgjNGpIyJHnxHgwJo+jD3PKA7nbiagIekcx2zf6+NszlOTWmMXGXtES8vaOqxm+CeMjYksMJ8O8iVTfIpB9e2cONI8eGvP8ptyetxuSk6wZBf89RPt/QTndeXjyvpO9nxD03sS66osinHyr0vXh9m/1HabmTNRUG3UG68FAXdk7/+iDEawvaUCPP48vxn77nT8EIOZMN63l5oFSiexeusBU1Rpy42qpYSF9sw1cgMvai20eaiuJQM1XVFDMBUg+DDh65+J4dXJY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(10070799003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lS6Q0imhvfBOpxlk/xrd4U6vLX/kOFmycyaPfDAEZ7oEL7mR6zAdXbwVjuu5?=
 =?us-ascii?Q?hQ9EtDNZgefzvvcpJk/ZSbaJSg2HqGZlEyHFDdKYJUK8G/7SF2P5Zmj1YaA2?=
 =?us-ascii?Q?/Rh41iZWL8b7XexfNkwSS2CnToO1nhbANLhNIt1qktrCxHs+0wFAulAsWOUK?=
 =?us-ascii?Q?L5KH3/4SagB2TCxQmaIW4L3lWLXiXmAFAU4yyGI1p9mEG3zAGA2IHmVH8dZE?=
 =?us-ascii?Q?bvVqXIwGWbJ6ITQxnqu6ucnCUdd997DnN4CQy6CntmXuR1VA2gJXjkm/4Ihb?=
 =?us-ascii?Q?gUtkbACzhhKzKs9ETsXzTN+uNsokq2oUsEz7J55YDwlQIo0s8NzrSp2Fs8Wm?=
 =?us-ascii?Q?ftiyn6OjV+3qbTHmxWFXmj7f1bHQjSBP5L3zbVtyqAQhdyjMc+xAXME1Mb8A?=
 =?us-ascii?Q?jb4DoMY+eQGS32Cxpd1Wk+YNKUhuO6ek1weSuvQAMV7KQ40B2HmnZJv59pNa?=
 =?us-ascii?Q?cgK6VRKjoWTUvpxNBZzjjKueXAhIyoMU9xLv5E+tYoMbtswPSicB2WD0gq0f?=
 =?us-ascii?Q?mGc63SWLvNUaDDdp7XOBd0cTN9PUSnr53j4MZdnnd+2RvH4Meq8fKXoDso/i?=
 =?us-ascii?Q?Y1TjNhPkD8K4oJzrcbW8DwXhUYG7/iJ8c9xRmXC/FJx/yc2piIWtDv3rVsZr?=
 =?us-ascii?Q?B2zIfkf9QZzhpeQCTbh37GDZsoVjFKYvTV/6abvts+8AR+iKqYagDHNnXW2Y?=
 =?us-ascii?Q?V77/umQEsBPj4O+1sTx0cSBBUBm/FC/D9l9cZhZovYsKout4ap0/BiuH8CmT?=
 =?us-ascii?Q?ljfASDQGBOIANw3jRPPzhV9ZShsBXm7YWiie63pG3FIVW104Ejv7CwQVBI8u?=
 =?us-ascii?Q?x1iFstMeJ7LkZ2aRVar5ghFW0AdGYhkiMxiQ4cWQEszE3YXNkaoCmB1NBhQy?=
 =?us-ascii?Q?3FmIuO51rrKZ6A1J70bl0WrlnTwyF2QO+5IvBCsKF5YzqEKmKpdfKyLE/7P7?=
 =?us-ascii?Q?G8ffT6kIY0D/xzqDwwF/PMWJS1LCGSwhI/eIm04tf0yzuDQK6cBdiaUZJRk7?=
 =?us-ascii?Q?ajdAz0dm6PziGcR/jIoj/Lpftg0z+PURjUeK+C9YcU1Nhwgfs2iHoH/UG8J5?=
 =?us-ascii?Q?D0H2PUygzo67kZdXF6Jnv5q8KhPRSiGmlWqXnxhz0IxDr95tpxg3jBLAvx+t?=
 =?us-ascii?Q?jkTNH8h+q53YvND7FyXdE/XVlbPiYPCWRKHenFR4HeeOwATgsuAKiNZRyudk?=
 =?us-ascii?Q?XiobbQWSPiodms1SGoxQztZxRjItOkdBuL219VYxpTURqbGUy1bHhReQDkY0?=
 =?us-ascii?Q?XdXbZCtP+SLaePzQqVeq/IZqwx9HnGqzNBrd130TsnYnEIoyZZJ1eR/hfSUE?=
 =?us-ascii?Q?RR8YWy8AEcWMvr797YyIkL+OLL1D4YPjv+joqvOCcmQnl1vlR0sxBGDusqVO?=
 =?us-ascii?Q?iV/7pq4maSUh0P4XYYeC0JIGkAEfTSbjBxhKmQbSz4PRHxCHXEpsgTFn6XTf?=
 =?us-ascii?Q?0A+mbAKkK41SBd8ZK11HXPdKBSZqj/Fd0rrI2vHaQex4asgs7ClkFhqo3hUp?=
 =?us-ascii?Q?l61VY2Y1Fq6CzIuNKQAotFne7W0Qja4SkqDQ+HETF9p6m+6d2/fK5MfO8UAU?=
 =?us-ascii?Q?sp1dZVKPFNuQoG1geZ2VBw5UcTyHQyOP24xOssskRtGZXYu2TisBkngfwF6W?=
 =?us-ascii?Q?wDt9LpUfgcvoM1gqv4+ZvvJFG83V/bpWzu4+Un47KKGYa6VPem9HxYB/gOkI?=
 =?us-ascii?Q?JcBGMeafFVXdBTeRHLZo1HI5//uwo4Wi+YsQK2H34a43A9QyHmNFMmz3IuYt?=
 =?us-ascii?Q?oIDtc5RjeWS1qatHYu50+YJMzijSA3xhVSUJvoxc8SIDTMUWqZfEO3GTRj1v?=
x-ms-exchange-antispam-messagedata-1: sLhX4zulrwB7FQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JdHOEVBpdfnZCPIax6XyB8F/3J/dAxCI+rWTXzePpWsciAb880f7y/1fPmmRA8Mqa8ANJx3KPiaJSA1lhUqDvnFBihSrTccXSAJcqkks7vPXs3BElAdNwIYN95q63TSEzpjYlltYfYVcVflf87VEz4aIUBjiIpISpz3Rhr+yQLY6/017FhCtV3+HSDJn8rioQ8hrAl/Eov1uPI+2jSYlB4+imjWEO8I2hPwvpQxYkXvm8WoEtGetTIXAatAQ6dAkajXIhuCRBp/cQsPGW7OQ5KGJPyTVIWiQS9V/NR0GMgFlnYKYLbXgyfFh7OTk11f0mR7fkBRaFJvNxvBpAzIVXw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b81625-9073-41da-0517-08ded27e8dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 05:56:51.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCmT2yHi3kMAJKj29j8BtXwU07Xon03h4yEqA9Rggd/wUVWUkAkEpzxC4LiHeyed3ZahyLFqjvYmt+T3e58CB83SpFUF1QIBbswyyCDnAw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8706
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Kiryl Shutsemau <kas@kernel.org>
>Subject: Re: [RFCv2 PATCH 5/6] mm/memory_hotplug: Support ACPI
>hotplug/unplug for coco guest
>
>On Tue, Jun 23, 2026 at 06:17:36AM -0400, Zhenzhong Duan wrote:
>> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
>> +	for (; range_start < bitmap_size; range_start =3D range_end) {
>> +		unsigned long phys_start, phys_end;
>> +		unsigned long unaccepted_one, plugged_zero;
>> +
>> +		range_start =3D find_next_andnot_bit(plugged_bitmap,
>unaccepted->bitmap,
>> +						   bitmap_size, range_start);
>> +
>> +		if (range_start >=3D bitmap_size)
>> +			break;
>> +
>> +		unaccepted_one =3D find_next_bit(unaccepted->bitmap,
>bitmap_size, range_start);
>> +		plugged_zero =3D find_next_zero_bit(plugged_bitmap, bitmap_size,
>range_start);
>> +		range_end =3D min(unaccepted_one, plugged_zero);
>> +
>> +		phys_start =3D range_start * unit_size + unaccepted->phys_base;
>> +		phys_end =3D range_end * unit_size + unaccepted->phys_base;
>> +
>> +		arch_unaccept_memory(phys_start, phys_end);
>> +		bitmap_set(unaccepted->bitmap, range_start, range_end -
>range_start);
>> +	}
>> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>
>Accept TDCALL under the spin lock will kill scalability.

OK, I can drop the lock during arch_unaccept_memory() and avoid race
by checking the accepting_list just like in accept_memory().

I initially wrapped this in the spinlock because TDG.MEM.PAGE.RELEASE
is a quick local TDX module call to transition pages back to PENDING state,
without the heavy VMM trapping/faulting overhead associated with
memory acceptance paths.

Thanks
Zhenzhong
