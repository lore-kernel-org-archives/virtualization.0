Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAD3BBFB5;
	Mon, 15 Jun 2026 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510096; cv=fail; b=PJrwTOsZz4VDttSnrZAqSTH2cHA7JvhxsgfPpuA5LXYF3WlKkeHlQuq06VVCCHqr3RQf0K9ye6ib/KU3ExVTJj8UmFKEDnMTzFYNNMATz3eEU0ZchDhU8fehc4XLxteHRZ/gUqYc6KpkDRKuobSSpscp2/WvEeJgyKAjsKD9bL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510096; c=relaxed/simple;
	bh=Se/xZgMaG2MxYb9C5VbFmQOD497hBzYXq1NZXnrCoAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IkYi+uDO1shlHWSrrUHIWUHCrDNWN7kzvUqEwITw508GZ51EMql+axYWiQDSCdDgMffkRZd7N5iQb/6UzyIB0+SIeTh14abrLsgAGy4WdaMl9AZMkXFUtOnruqpfCH0XpVl9jfoT4rVC2+CbAlLQd3tNgmbGgpSPvcSZ0Nvh2/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8/HtIRI; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8/HtIRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781510094; x=1813046094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Se/xZgMaG2MxYb9C5VbFmQOD497hBzYXq1NZXnrCoAo=;
  b=J8/HtIRIvDuoGTzvWFS7OtgDYHwc0PLTL1jAMMkwFGsgbQdRWPTFxYip
   iSK30lDJ+5MTMJydgI4lfH6LkjbhY4rrpe+w+FB9d380MVvZM/mMhQWmL
   NN5wF1LssU8QXrkyNnNlo02z1MfkLM5D6xyQx1xBlpY0s/A8E16Udw80/
   WNuNQCLMeAVy2nSjiCR+lpEplrM2EdIuUOWeaiNv/jkeiGTeQx6bG32vs
   ucnzqnIdtxF6PWujx8lOa9HnpI9LjTVCmZBOQUJ4Vw4LLIF+sUxZmJxZN
   D5tG1IN37XxiVTzJmg+UZD+DP5RNFn+Sx+ejt7AbLqj/rgSJikgs7ybT7
   w==;
X-CSE-ConnectionGUID: wF9m9EYHQAe5ssYs4Bj6Ug==
X-CSE-MsgGUID: q0nlJ7ggTBeKTirjzkiwiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="81380984"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="81380984"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:54:54 -0700
X-CSE-ConnectionGUID: dKcPssSiTeu8FWM4ZMx2Gw==
X-CSE-MsgGUID: 0MNCKfXpRfmNDK1i4aK+3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="251682071"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 00:54:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 00:54:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 00:54:53 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 00:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpwxHLwyhd8s+HLutsMaH1UCqYHqjFk7+DumiXDJByg8ez3qtZNNmJOcOdYfPcfSsRxDCPC8zG3ej6gcn5lKXBjaI/Q8/YFd+ducpaWaAS8wSgRQxm6dSuUAbPydORU3P5xyF8Vibvud11fFOjqBMWNsZmWhcc7c7Ehp0nCav7yTmz2hlh0sR4K11mSGtTmRWeoeaPpY3vNOjo9t25PTzV46g/GKSuE7uf86cWna54idDVv8RuaOYivyudXPhSNWbtSTSpU3+A0rssJTFRIARlixG4fr9d2QSnPzEb19wUQfDGJEgDISP2jwh/sboEiXS6JMqh3v6D4YkyUbE9QjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se/xZgMaG2MxYb9C5VbFmQOD497hBzYXq1NZXnrCoAo=;
 b=BuvRCNO1wPX9urkTnDOSWkRvIwTcAHye4rgL5aaSYDWEB7md9Otjo85MFapTqd60fe4U9kn7g2ALofKUwJ/KdZK/PAdvArCfDR2h1aAfzwt4Z8E0Pn4ZbKdHz+cbx8T/i71OgCjD4BA4tuVzujgo5TBphxI1ZY52RrO6wj/EddBEcyYQdfZUSlnliymmdaMcV8E28pAg79csmw1K+3TlhMHOzuTONAGQLAU1GQnJWMcUiDDcYTsbNz3v1YACLEXrMjPgMmKuhZytHCx8hmJuqyE73XYSMbcSxCVl0Vwld1zuVAp/iX5mUOUFdZWxS7XojQKAEH33Qei3iRO46bw+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DSVPR11MB9694.namprd11.prod.outlook.com (2603:10b6:8:34d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 15 Jun
 2026 07:54:51 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0113.013; Mon, 15 Jun 2026
 07:54:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
	"david@kernel.org" <david@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "prsampat@amd.com" <prsampat@amd.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "Qiang, Chenyi"
	<chenyi.qiang@intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	"michaeluth@amd.com" <michaeluth@amd.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [RFC PATCH 0/6] Support virtio-mem memory hotplug in TDX guests
Thread-Topic: [RFC PATCH 0/6] Support virtio-mem memory hotplug in TDX guests
Thread-Index: AQHc9AWclpImMkxo/EKeAALGPSWb1LY64n8AgANNJbA=
Date: Mon, 15 Jun 2026 07:54:50 +0000
Message-ID: <IA3PR11MB91364A562299CCECF830E9E292E62@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260604093551.1511079-1-zhenzhong.duan@intel.com>
 <aiv0y-Op9bfP-CVO@thinkstation>
In-Reply-To: <aiv0y-Op9bfP-CVO@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DSVPR11MB9694:EE_
x-ms-office365-filtering-correlation-id: a8eac91c-2d49-4547-34ac-08decab3610b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: FjAiByb3tYbH5lZl3SG9mwxIHE5GpXh7X1zfNFXE7PXHnTL/FpvVmprpK4ZVUmYeYjKfhcp03WfJreyviPAf958Uep7LXwJ3bQaaVHiBgu9NqRjkz17z2gBUT2Y2E3fLDfcCWnQMgHeEnBmMFp7kQ4yDp1LSDb0crIeUW3RkYkRUkGZxAtlUYPD3smGXYW/IXXhbYUAd4ZqD7pWcgJzWG67Lfsurfk+pyED4tzDg5SMO5XIU4Ww88p8wfR4qAg26u5/cZ761emAGq2XSSgDH/zJe3SqPAdwXIHHz9IIJJ9esogW6uBVxCq5h6yiy2ttwS9xZ5Jcx4EoOlYsRzBZ/4stVrs5+F6xBcme+/4JxdpXV8CCTMXYS22PHBeXAtQLWNsVNqPaRs9uq6e180//STpyf/YbCOb+czpZNfvMt8e7biOSX+IB63PiCAnly0keqW3uPQ/Dz6bts4SSg5LafxUpsduE2VegUwU1uhSs07aPzxi1jvkB2mDfHpivZBfdm5NBuHxecNr8IT11N4XJQwczfv3sNWiZNxflx4faiX8PNiJtqdHJOH515KnnAl+7LDK74yGWoMA4Jhrs0qNYxGjxHkrQVCcxgvG+ChphkxyhY73a7m53esE4k+Qeknw9fJHNhLDWStFMoBeMIdBMmiN+OdZJbHrfbAf+DIFPh+5Uw3GRI3lXdaoTzOYv2qwYP1SlVZiLBzBcwF3lhSSICMySkS55YafIfu+hPWRm/o40J5GtWw/jO3jz3p3HLjj7S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IuM5BYAnhx18l4lpqpXtTYzp8gW2CIRAWo0WDT4fpJFVVtXJWtX7obuWdK7w?=
 =?us-ascii?Q?Bg+ND6m6sbw90Yy/HdBnGax07ym4AStH8a/izK0tpsbhOD5w26motFkYWRlq?=
 =?us-ascii?Q?RrYSJx7Oc11LsWeS5UpUoqkPP1GbIF/Ri91Y5DjmlMMNQlS1O+4jjuRp6umw?=
 =?us-ascii?Q?TiKyd4OTHtHHPZdgQzbqe59UMX68rTnjCJVIlht5aPgpX44A7wzymrQodTNT?=
 =?us-ascii?Q?gfcIpxCWXS/vlpgNMkeqIL4IDddqyvQ28XSI9N0gy5DF72EGKOlkq4ggp9G4?=
 =?us-ascii?Q?tiSxRq51+E4NjYodkBCzSMvzUMhpewAiimMFEdzYganDEayffh6thRSrp+7D?=
 =?us-ascii?Q?1PVRTvSyKvfpctzrnAmJlzdHCc6I8+fjK6Pg12F1QKPZBg1btcS4A5sSwxB9?=
 =?us-ascii?Q?ZrHqjW9CcNV+11mEQGkxW+yp/iyTS1acvC6RlP3mb+ZNdoTE7H6M3JW2vMtU?=
 =?us-ascii?Q?kD0esJ9Tr3gbil0lXwfzhe0YXHAxRKTzoiFdhHWUrwM1Smz6uBap4bVPniC+?=
 =?us-ascii?Q?c+y35X2JqdSct4/ZJfTam1C9JXlylmewIuRR/z/tRXobBo5DGT2PGsZxly90?=
 =?us-ascii?Q?jPZNB6EUQ8QBt7x6ONgpIwoXdr6UzsBbxjUXASdsKpE87wCg+C2/xV5TfNh5?=
 =?us-ascii?Q?Ijr8uoBccUHUzMbt2Aprwsyl2zNzDp6+pakLNy1QhspS55pTuNKQqeoJPC54?=
 =?us-ascii?Q?viu3evXUgq+vna1VbJcs5Rb369QwA34MSRuu1c1hJ0FEYcx2JRRRX35eRnpV?=
 =?us-ascii?Q?ryPVzPGGs6Emd/fr3Q7QR4REz5NorOtVx7HaF9oMlkDu03YqZh881e09aYgw?=
 =?us-ascii?Q?I8sPEWUHmSYZJywkFh0UTwKYRTzQjWVDIHG4VDUiRA8Pez51CLlxHODCd180?=
 =?us-ascii?Q?BuhoUKgD5wG/JOh6XNHbC1HO1o+jO5uO8cw4IAzl7pgYZ+RpkYn7A/ml/kLN?=
 =?us-ascii?Q?9uSMqScBini5mC7FSxWkgmu2WEm87AfmqQgYEfVc/6mI6W7hYqE+wftDfQfD?=
 =?us-ascii?Q?f0keXw6Z5y9ZzXTfykJSwQSO+WFeCoBBJY2nqryCoD3UOSOEnvCmVzBVd3bq?=
 =?us-ascii?Q?Whi9+ez19MetvNWgo3DWN3neHtDWI6E/no73VLIMSvN580GRrMEyZbKYqM7x?=
 =?us-ascii?Q?TSjs2DO0RJWItJVjKaEb6WueiVkppNxZQQbgKr4heLKDwPacGp9VjCuF6xeE?=
 =?us-ascii?Q?yDaD9Kl1QlH8yeqGyWiYQCUtavBfM2q+VRfvFOs4uFF7s1NVldN/P5hUUM07?=
 =?us-ascii?Q?PykNwF56sPWO738jxT6eQzenrTK9U2saubDasw+GPFNSm4mIt6yw15JmfNlK?=
 =?us-ascii?Q?+ZmkPFkbnslbf0Q/wCU19xqJKZLd6t0zbsJckC6l2XhFiG+BKuc3ferI7LXe?=
 =?us-ascii?Q?1WcG2kEdcjhNoJwZHK5HB9Pv691A2xN74m5yZP/HOKOAfOw78YX/ol9FeNBq?=
 =?us-ascii?Q?bjtzC+QL+/Dk8+pEhZirDmGpibGcpfdJ40UZsS22QpoR0bAWyTF+kRDPC9Zv?=
 =?us-ascii?Q?yCRv4U02Ik/GMyoncyLA3r9ges/rw4I0mUwJxpXMZJFuNzzYZ1PqbqDPMJGn?=
 =?us-ascii?Q?JvGffWRYAVxdNY8VoZp5jgKHM1Ug3RyM9WnpBgYYw+2XvTHHKMq/m9+UCtSF?=
 =?us-ascii?Q?qjm5PuXnwMu/O1LbRyEB0wC9VYrGblt7S57zPotoTIPFp/8V2QpufC5ZMhSx?=
 =?us-ascii?Q?LzxlxPpk5UCz7iADicv2i6zrPUeRVW7kXpLnxKxJlrD9an5FAzMmiAypoXaD?=
 =?us-ascii?Q?bUd0AQWODg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: URa/o9rkNO8jVnSWKhXW2SZuFZdqi+5xYDgctSUYbGkiK8ViuHE8nfUrQcDEVVxfudPoFhFKR5iKDWAAIzok6umh4SeJx3aYQUHHtXFUXl7UvdZxEnZO6FJpuSKMPNLOH3leoWmomgcQRGaYq+qJlH0+PpA0EJkOqrUq87bsPmovoCG4dJxE23dviGi0wf55oCZ+O/dko8uF6jBRJJFc6yCW75eElGFw2uWECWhyprOFC5TB/VIth+glMj61ARlcJVxtHQPbUmCZ0W37UfSzmccRkbcn7VXWeRn75c6uv57nRBNnso3gR83aVVjLbiCECeIYf2PfgOanBzmDJiE7Rw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8eac91c-2d49-4547-34ac-08decab3610b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 07:54:50.9013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UfhlaU4HnfyHt/hoLYNY4QDLF+dwoxY+t+LCACzyB2ZwjtO0JFUjlZfZ6971IDIfqFuJcAM1n32+Y1UlMOn1XDqFKWBMzN9RREa7VLFTN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9694
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Kiryl Shutsemau <kas@kernel.org>
>Subject: Re: [RFC PATCH 0/6] Support virtio-mem memory hotplug in TDX gues=
ts
>
>On Thu, Jun 04, 2026 at 05:35:45AM -0400, Zhenzhong Duan wrote:
>> 2. Re-accepting already-accepted memory returns errors. Ignoring these e=
rrors
>> can mislead the guest into believing re-accepted memory is zeroed when i=
t
>> contains stale data.
>
>Re-accepting concern is valid, but often overblown.

> Reaccepting memory that never got allocated is fine.

I don't quite understand. "Reaccepting" implies accepting memory that was
already accepted earlier. For that to happen, the memory must have already
been allocated on the VMM side, correct?

>
>> =3D=3D About this series =3D=3D
>>
>> This series takes a different direction, supporting start-private memory
>> and addressing the limitations of previous series [1] by implementing a
>> callback-based infrastructure that integrates TDX memory acceptance and
>> release operations with proper subblock granularity.
>
>You are presenting these callbacks as generic memory hotplug thingy, but
>it is only plugged into virtio mem. ACPI hotplug won't accept/release
>memory unless I miss something. Are you expecting them to cover non
>virtio cases too?

You are right, I didn't add ACPI hotplug in this series. I'm working on RFC=
v2
supporting both virtio-mem and ACPI hotplug in eager/lazy accept mode.

>
>And these callbacks feels like very ad-hoc solution.

OK, will drop the callbacks in RFCv2.

>
>> See Rick and Paolo's
>> discussion about using TDG.MEM.PAGE.RELEASE in [1].
>
>Having RELEASE in hotplug path without addressing private->shared
>conversion first is odd. That's the most obvious path that has to be
>covered first.
>
>Hm?

This patch series assumes that memory is plugged in as private memory
and must remain private prior to being unplugged. During the unplugging
process, memory is allocated from the buddy system and marked as
FAKE_OFFLINE. Because all free memory within the buddy system is
strictly private, shared memory can never be unplugged.

Shared memory is originally converted from private memory allocated by
the buddy system. Consequently, the driver must convert any shared
memory back to private and return it to the buddy system before it can
be unplugged.

>
>> =3D=3D Future work =3D=3D
>> support lazy accept
>
>It would be nice to have some outline on how we will get there to
>understand if this patchset is stepping stone or dead end that has to be
>thrown away later on.

I realized the callbacks are specially used for eager accept, they are not
useful for lazy accept. So, I will drop them in RFCv2.

>
>Hot[un]plug is often used to manager overcommited host. Eager accept
>might be counter-productive.

Agree, I should have taken lazy accept into consideration from start.

Thanks
Zhenzhong
