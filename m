Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABE2E06EF;
	Thu, 25 Jun 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369544; cv=fail; b=TBiVLpPLEDgQWKoHeQyN80AK5P5C1hGtna7v9W2n4TPnFGF2JuHM1/5UR3QZfraRpGIwVvRhk8RjWCuLylz7pZhwcVZNInPm2gV/HVP47F0mRYvFpEAH6zVbQz5QHeCryEpDSF4qzhM4faiNIR9IZtw85pTsa0lcOhP3hpSOJ7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369544; c=relaxed/simple;
	bh=JNSTdVh2KT/osiNTTPT/G2Poc7BqTFCIxW6QRLM3J0Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iP5D21Zm0kEz0MVhef530QQhhcXQmhC43csyCimMLPIKBD5GsBm4kH+vpEYEXjEtpyJWGWTfI+odxwD+KF3FRf8mpBYOb7KhPfkP5LGt0W6aH2LTsYhS+nRTNWGjHlICRBRV7DfmE8EoYCgvyG07+jBF/uA2jlBHgcNqaf7PSJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/DZb31x; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/DZb31x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782369542; x=1813905542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JNSTdVh2KT/osiNTTPT/G2Poc7BqTFCIxW6QRLM3J0Y=;
  b=B/DZb31x/R7ijBWbTzbZIGfq7Xnlvv0JU0uZO5xzGmA8CwtTXfinaCIf
   JJS3OWOko7JgHv3EufUWMkWn8H2gPRJlqeYmVR3q8lY+EQwUO3RuqKS+d
   X2nAGLpzJ7MTFKAYqUswZmAidMOtA99rF7OgUlRpOkaN+Dsw753qqyCd9
   7mR7OaqaoqzaGM63+6x0GjWlm+usnVLz5nBI53AXqn+E1uivBhmIUuoC1
   anIefkzQ/W0CAbCh2vlGt9EQSQoEbIBXKJAh/rZzq6xP0DIb+6foGh/2r
   FJNsmSIP74Ar8UKHV4rGChfQv7aGiVg/gh+Bb61x7PMpkrbBdESa/qZgW
   g==;
X-CSE-ConnectionGUID: 8M5wxpM9SKiqumVlQIp6IQ==
X-CSE-MsgGUID: OOoX8vR3SSyCD4FjksJ5Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94632154"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94632154"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:39:01 -0700
X-CSE-ConnectionGUID: VogE5PA4SBGOzHeBmvYmZw==
X-CSE-MsgGUID: sIj1oPsmRqy9pOEvOCJ63Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="249396286"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:39:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 23:39:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 23:39:01 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 23:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM2YgqoTSJIMRNFtjOuleQGPH9sZLTp17yP/d++YuH0z8XBHc66ipJc2JBcqTy9iWiRErDuHQ8v8Xlo5UbsbPaZN1hOY0Hu//vGH3ZTEM5hbv4aW2NlcXm6KaoOVor1klT79vpnltnSNmd2ywI7ifS7Pjq8Og2aHNuUxQi0X+GyHPFvMRE5CoHRKAh3SZ/H80KSed6aK3N+8pZBFwsO4v5fwGCAg+2z9zJmXBWuKfckCw0jVDjP0O15yrHhFu29VyYXpaKz4tOnS8G9RXlslUmbaGl12EkEvdZ4qhzhZdHB1f47sOwFjY9bvV9Jk86jukQTR4jMeA/IUNztJUMnWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVJu8X1BBtidz1p3sPYqM4M+wdesXnVf10AOBzUH7lI=;
 b=G7IaF/qiVLEuQIep3UaENZX12/9U9H0qTQpuDxA+XIlAbLUwcQ/OmGfL0Y/fep7yxNi0kP0aiWp9jCmgVagDED6zo9awStuff42xGUmkXhj2laH6PtC9KiKrwtZIkie9568P3iWx+f1Kz0GIJRovKqyGnj6Fxxh2c3zzZvmD6003Hxb6/rM8GwdSiS6Xqqjq3SKmbXldt3y50SaB3tQTAT6lzY9yWjDOsZXWBst8clYUVejA+NscZRpTlzx3zxqNTd30iR6mUL5KGYduip0QMdiFiSQhs6/9EOeaQUx9MbsXNEI3yIBSK4Uy++qJzNtiF0kLjzbFfSI5SHpKQ4IRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS7PR11MB9449.namprd11.prod.outlook.com (2603:10b6:8:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 06:38:59 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0113.015; Thu, 25 Jun 2026
 06:38:59 +0000
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
Subject: RE: [RFCv2 PATCH 2/6] efi/unaccepted: Set unaccepted bits for all
 hotplug memory
Thread-Topic: [RFCv2 PATCH 2/6] efi/unaccepted: Set unaccepted bits for all
 hotplug memory
Thread-Index: AQHdA9UlvvGGcWmIkkaRajltXiJfLrZOz7aw
Date: Thu, 25 Jun 2026 06:38:59 +0000
Message-ID: <IA3PR11MB91363A8CF58C51AF4DF142D292EC2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
 <20260623101739.79695-3-zhenzhong.duan@intel.com>
 <ajvNXyYwb7FXAJhP@thinkstation>
In-Reply-To: <ajvNXyYwb7FXAJhP@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS7PR11MB9449:EE_
x-ms-office365-filtering-correlation-id: 69983047-1571-4351-4aec-08ded284702b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10070799003|4143699003|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: PgwiP7eCRarzPIuwrL9Xx9D5S+SIU2NesxYHe5NcCr9Yf3Q+rMjTdnya5lSJESKwUOz7c+g4WFyNLXZ6+Mt4ClAfIgaO8xn1NiLmQA+KSWPTAHuF5160+llEf4EipiKRZxumbDiWoBzcP+kQm7U5bX30dsIX0DuveHp76MytN7JQBp78SF5NER5JyAX/cJDrcW/zXr9ZCUQUVNdEfi9d3/5uIyxV54Gmk6SUPWuC0lF/xwH2f16RWgiVsPI9Ku6cu5bk2Q88OMWZYAHk8kiGgq3OehylixBsU11tJf+nUBxpCyXdSjfC+h95xEwOcWleWKF6PVgHAsXqN1dWK8PhyrCn7aY6pslzVKwj5p3blqF4YD2VEta08xPSV8Q8BoqEQiOIw6SpYK4jy6aD/knCFa42VH2OlxA7A2SPBVBb0HiflmeISEPFHFPXgSDdH1zcchLJIyLXry/CSMLkWUDJbKX7VjK4dz3Eo4SiT85LKHIqSQTunaWdSBcw9bIXs33HDyS3OaFRsdpJ7oDvaeDRJzPitEEd6/vKvUTjdNF/ghx516xBE4z+7GGQvuO8fMOqThSzhTzf2+KLgj/lLkusVsbqbIPUgHDRHQ0FIiMZlIqyDBkXAM6UWy7q5w5GNzpuz5Rihgrq/uZMPsWAXYc34Du0wcEWDGTwM2JpEQZnGvRCZamqnCg1aICwEeGEATnjA71PDHgfgKWiG6mGNC5A9FRQrtFrAnd4EHFomaijQJ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10070799003)(4143699003)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5TdZah/nQzwlyijNdDHy2AW/pFor4ZYV7mqQut25L/Ow+OHKUWJR3w0zL00N?=
 =?us-ascii?Q?bXyAoRksTpl5Cuk3eJ2e16WWPmFFjw0KR0wEROcLPYWM8YMzRUibKDjq0Hw/?=
 =?us-ascii?Q?AWM1jRh7WfHsyiPv5FKylgl7l4oKKdFYAK9eDlyeK7R34OXFvZBpOvrJubQa?=
 =?us-ascii?Q?uLSeNY1qKJXUkC3ev2GEQx6OVocFcBWzx6LvVdPNUTzWSSv2ryavSaTHCMVH?=
 =?us-ascii?Q?DXvNIulhkXn94Qyc91LzCvjr79+8bS3cB58zMU0gmaYEu0N1Ui0h6Xn5871V?=
 =?us-ascii?Q?+7eGvVtI3ZPMifrLnevjnlrvN6NtqUO+8z/wUk1hikToKKEVpT4ZlM/4Fz+X?=
 =?us-ascii?Q?91B/cN/a/IFlV/v3PMV49RPji5zxacwmMhVtwZlhq+PHWeiBNq3ifk548GkO?=
 =?us-ascii?Q?T7ERUpM26ZjCDeNn/10NmffuE8kzhdRBqLTqObdgvtLmBGw0CVGsHBORaXaR?=
 =?us-ascii?Q?CAYQSYNYjZ3RfMXnXL6k2WkklM2/YcVXtxKW/sQ1avRUrPY7cJYAw4qjbhyo?=
 =?us-ascii?Q?RmAF1RNLY+TnrJVGj7wZ3sThdRHavlI7xwk+GJFs3X+jKBhclVPlYd1+F1j3?=
 =?us-ascii?Q?uefQcQeBYjdFO+6YFRv577bwc+X2lIjcbN5lA6gOwQmXNyCVH0EN+k544SMS?=
 =?us-ascii?Q?AcF4DyXecn8ziSuJ7m9phfrIX2OXc0c5rpwGX3WdPolMWzCZ+fPrqhdQH6qg?=
 =?us-ascii?Q?4ZV8z2vtqJdI/b2xQKGeCv+RPbQAbJSVrlJt2BSiCdqOVEYuDgqQjLmRH4IJ?=
 =?us-ascii?Q?s7Ju80oQRou2d9Fh4VR3N6g9Ebd4Q+LiaUMvkBw71ZxsyWAdzrm3NPnpS/kG?=
 =?us-ascii?Q?7MeOsc8HyW/Qbe08UVH3hiHoNluzswz3TmOcCwdJDMJG/lmhTGcQUQ9I0OmO?=
 =?us-ascii?Q?G9/ewS/Go+vps7G+SRFF/BOL+n1uAx7RtN87Gfd4u3i2F0A9aYmz9mqrZh1s?=
 =?us-ascii?Q?5MOlWFLaLx+kbw+ZNj4al2PZMwG11NDDmujH4PG3Fk8IEfcGt3Gjoh35HO8e?=
 =?us-ascii?Q?R43DEFJEUZAYRlRqcyJUO1RSzxsomEtKGrpHeE8XbMzijvgpEJotfgdUJbhc?=
 =?us-ascii?Q?cV7EaZqBhb0D2Jp6QKpWGqqRWFRng+4hUnyLp9Ij3bFgDl8n0nYhkcWPAGt1?=
 =?us-ascii?Q?Idj9FLiD7imKqqUbjJ/kvv/SjZNs8AbIOpuPf8olQowwbubp8szVLWYT/SIj?=
 =?us-ascii?Q?lfBXhokK0qmiKhlJDYh9QYmPrPZ4y7n7VPPq7oTl4B9kkPRmf5GS4BRJNwrN?=
 =?us-ascii?Q?XAiPXgvwAhm9nxy8qW9ExbxNEJNOPHgPSQhNxET5TgJvBR6mc5sMAcFbaqtV?=
 =?us-ascii?Q?mPATRy9mxRCoEXQaMLRkpTcvDzSojHnumEDqjdcI4bCvH3cuEqRsGjk54nSw?=
 =?us-ascii?Q?Jdez3EFnzMWLYY5Et/R7frMUWAeVE1aA2jGIiDibop28l2FAOTKe8OziY4Fn?=
 =?us-ascii?Q?gBjtPnx2sSWLACHWXpAzs0WCAeG1CWbn1UgiLa8ksdzGKj6eQwekweuSz+QC?=
 =?us-ascii?Q?AyvQdt7wcRzGG+9IXYndfzdfYC/eU/GFk5uI+2mD9NTtInx8F+rJrYHHYtZm?=
 =?us-ascii?Q?cOeGiAy2ibyokhUeecovOdD/NIug8BraN4fbJ0VX7E4qrGhdtYZhvOLQQu3D?=
 =?us-ascii?Q?+W/vmmJJ5karwXDrO/gQhfaf23RleLdJtiNAWjwZucU4hWvTX9c9dM4HHOJK?=
 =?us-ascii?Q?gBkVEYlq0xGGJ+Dk7BRdAvl2BBICok1X56pv0g9eOR3k+1kubGqmTFl7up0A?=
 =?us-ascii?Q?K5OBNM4INT/4915Z/ddaivt4tu0A6/smK18G8eY+9k2HFb1mncsNHCJgERDZ?=
x-ms-exchange-antispam-messagedata-1: aJrtoKIA6sm1kg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g7DncIkmqd3+Ws8uAEN7Vi6n5ZrrSBLzjdDjIr0WJekYeGF7ouxq018vKUNjh0C1XnV2SyHSo+VvqSd96dyTjPZEPYTvQHtXJ+TgGW2DDUAyCnBn8YsehmuZFGeLQ83iP1ZSvkpjZgc4Tr0InVYmtAQMcajzlxHENgrcXhN3aVr61fo2Z3cBx4mh8Lsu3jferLRQeJzTICjolrKWBHULUN32Gyn4XqoWs8jyd2oDapyGW3BP8+41s6/ZFIPE55L3HQVqFvLQ1ZWMAHn7iEU9KIwXUmGBZzlAqPv9che1ed2+0ImdPA8zo1ravocrCOxYxZYRux+KzZAtGeW6mhAcuQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69983047-1571-4351-4aec-08ded284702b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 06:38:59.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7d7Y+p6EqrhXzH8v/6HCuCMX5OkxxVg1Nyzs65ldfFIhrHpz6AOyhy1nf9laVGwvNF3Mvv1MpQRfGh96jK6uIzUabOoqBx5+QFDMkLPor7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9449
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Kiryl Shutsemau <kas@kernel.org>
>Subject: Re: [RFCv2 PATCH 2/6] efi/unaccepted: Set unaccepted bits for all=
 hotplug
>memory
>
>On Tue, Jun 23, 2026 at 06:17:33AM -0400, Zhenzhong Duan wrote:
>> In coco guests, hotpluggable memory ranges are initially unaccepted.
>> While a previous change expanded the unaccepted memory bitmap boundaries
>> to include these hotplug spaces, the actual bits inside the bitmap are
>> not yet marked as unaccepted.
>>
>> Walks SRAT a second time after the bitmap is allocated and sets the bits
>> corresponding to hotpluggable ranges.
>>
>> This ensures the bitmap state accurately reflects all static and hotplug
>> memory ranges before booting kernel.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  .../firmware/efi/libstub/unaccepted_memory.c   | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c
>b/drivers/firmware/efi/libstub/unaccepted_memory.c
>> index bfbb78bd7b8a..01bed8e751ca 100644
>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
>> @@ -92,6 +92,23 @@ static void update_mem_boundaries(struct
>acpi_srat_mem_affinity *mem, struct sra
>>  		*(ctx->mem_end) =3D range_end;
>>  }
>>
>> +static void mark_hotplug_memory_unaccepted(struct acpi_srat_mem_affinit=
y
>*mem,
>> +					   struct srat_parse_ctx *ctx)
>> +{
>> +	u64 unit_size =3D unaccepted_table->unit_size;
>> +	u64 start, end;
>> +
>> +	start =3D round_up(mem->base_address, unit_size);
>> +	end =3D round_down(mem->base_address + mem->length, unit_size);
>
>We can get here with start > end if srat range is less then unit_size.

Will add a check to ignore small range less than unit_size:

+       if (start >=3D end)
+               return;
+

Thanks
Zhenzhong
