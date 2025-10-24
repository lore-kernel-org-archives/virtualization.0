Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BF23A9AE;
	Fri, 24 Oct 2025 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285176; cv=fail; b=ABFJXSf1NxHWqLojAVemYC4Hv6HGgl5va9hjH8JZAPtEK2jX/6j0MOvX06mcWMtDv7lETO60TWEm2QW21anED7YN8xfB8u16Y8wNCLLLNeI03RY+Hv4LLLmy51tz92+0V2jkTvScFlae3nqUjlKQECFS4tuDfE/0oUyvFeu3R8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285176; c=relaxed/simple;
	bh=vrAvuY4AZ4tgry4WWFEQwSLLRWWvheDnrp2IT1z1K+k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QDwAGbTmceD2FYpS8FwBPSpVgCZbblv0h1EBl7SQIAxWQoFlXWRfTkiPXIztNJ3vRdIkN5rQdCTRllcFE2iPbJeebeVIu1DWsZsp7DTNEH39uawrL59bAXeHrSewSg6gquIAQfpjz7M3LcdOr4Nv+VvInn9266Q/nuzCBvcezjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyKgVlLH; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyKgVlLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761285174; x=1792821174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vrAvuY4AZ4tgry4WWFEQwSLLRWWvheDnrp2IT1z1K+k=;
  b=eyKgVlLHYkFOEgya/qcZ8cFwxXU3n7ygyHQlGXgNZPwE5eobwWzQhbXH
   IlOT12WPd8wIB/EUgyA2cNBsBz4ZXe9/VFDAnRqcJUmzfI/sLLPZ83liX
   ztHi4m6Wu4lIrhGqhU+AJiBpNNd3oedpo6oV+gUF36MpA77nBLVfOYP8Y
   sAScAl+3+tjFfz5zSAgiGUlMej56kWX0XSkrUDb/tTSPTC1CQrLB+x1tX
   hwwq+QRT1zKEFhN4LZSpb9UfD/w2Hyb0L2fVx1Pdzpru6mkx2Vw4YFOp4
   U7oahCnxYvkIREYSMyKd8Elw+KdWSEikcOYYPXiKBiJaYu+UL22M6u6Gj
   w==;
X-CSE-ConnectionGUID: 1KoEzvgmReavWZSqWtu4tQ==
X-CSE-MsgGUID: fzHlHqn/T/Kexn8R/7TbeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74583493"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="74583493"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 22:52:53 -0700
X-CSE-ConnectionGUID: SqpKL0q/Ty2dKZ8wRsAhTQ==
X-CSE-MsgGUID: RFxm/cjpTKm7a8FLwO4aCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="221545828"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 22:52:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 22:52:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 22:52:52 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 22:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDM0XT2TZ4IJM7z9w71AfxqyTzz0fpRPXftBr32iBZm5GTeiI6ftrXwY+ReB3ffYew3e2nu2NAtAHJi3swArV1PtLyl3e+/8HB7DWIM1OT3J1396+HTqsBB1RrYo1w5njbXH8lsiQbGXjK14huxlpVHZQ6cduceRGvfbDE7yPz1j9NZ8A2WD7UrG3XWolEYlyMZOWCIi39OYE6jGX9L0DHvq9w3zJE1rqMi3tuK1ctKktuv89ZUpR3sfMxdw8Ko43yedykaiup5VntMUXUCAIKOBq2NPokCL8DAfqagd4nkBe2/E2EsYbdBVbIP0LF2usLiUqwKN/pbrmMh9Ci0RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSiE3lurBw229oYp+3v1eMnMGkitJSRTlXzG6lqNWXk=;
 b=iApPuruK/sXik28zNQM594cHKz5FsFkRa9miZEqn+ZVyQ7oVBhR8NIWJ2sGxBWjrJcz7vJnbGM62961lkqq5DFgU6zKQNwAYyPsbSZPyNCr22XP/0+0ZlpX5bcex329FiZ9KryW6UINrP89Dx9LDDH8aK0AGHYmplbDY+ftu9ovHITR2pBg1Cyy8FTwuT9Yvz7Qe6GE/qO50zYWitYvhn+Cx0fkOfR0KYgybEFbfTIhbBSOy8sAW24aiZbjy1BmhKIqvMt1JaR5J5GbDPWLkv0N1RjiLqy1vx+WspLssa6/peb0HWrMC4h0r7y73l+8KYR+neBUcNN1NY2cbnp4JFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6797.namprd11.prod.outlook.com (2603:10b6:806:263::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 05:52:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 05:52:50 +0000
Date: Fri, 24 Oct 2025 13:52:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Gerd Hoffmann
	<kraxel@redhat.com>, <virtualization@lists.linux.dev>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [drm/bochs]  bde4437839:
 WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank
Message-ID: <202510241329.c93f8908-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KUZPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:d10:24::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 953aa1c4-2642-4b7b-6a72-08de12c19069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3QRBgmO6TYs1vHxJwPDz1pt2761CU/uzq68QEEukmL6Zi5HVoaBK5BymYN6y?=
 =?us-ascii?Q?p0IEw3WXDB0OknUR9/L9J95Ur2nUDAu/hZprI1ME+NEkFSbg4iOca3yA00Aj?=
 =?us-ascii?Q?gnH6wOM5OZ19mtT80UBSCs3S7Up/Ueln8ohMKPoYGnXsAxhEJGOeHyqw/NY0?=
 =?us-ascii?Q?85hmLFl9sZfVcGpfIOgpUpLsr0rcw/aGte3P+cKN+c5kwev32yQsE7vn7owk?=
 =?us-ascii?Q?LK3bt3IezZ1tgIVE/1qjaftv4rg1YjMdZB+TMMMxgR0xJk5NYBA6Vov7DQLn?=
 =?us-ascii?Q?584k0XyIYcaY5nXxSLs9aUHI4No9/KCdTvwi0R8V2CW0yQhtBRFjIC25M4bt?=
 =?us-ascii?Q?qrugg8uwe4/v3Avv4yqr5ow2LU/B3EscD0jbLDKI5V0VcDndqHJ0TrpusRp7?=
 =?us-ascii?Q?tNmbuvVlwGWcxQRob+OZhBPYTUW37JED6w47KMhgpWkkz3unC3iDb5nsU1aY?=
 =?us-ascii?Q?Xg+qr4Bt5JnP9CnJdT3cXr/GhCc5CAadYePDH00X0KPzdl7CHTFROh6mYD7R?=
 =?us-ascii?Q?tUald4/ECUdz1fiUycIe+UyPxolGJI0w8lSVJft2H6VBZOC2Ls1Qiim1jNyj?=
 =?us-ascii?Q?56GtPvyJ6ubwlFtxjpNJgt9S+T8NhK4Oxoh6/Un3yEfUsRsTHW1FQTiFd0UV?=
 =?us-ascii?Q?blCOS0TThGNUTdZaGVU0Y1Bo+qyM8D7kXvkaTv+wzVEnFSAf6RJmAeQvnRb3?=
 =?us-ascii?Q?qiBLgb1NI+ibTh+LKbJzFsN30xhF85e+7dnhvlwFBNvJC1NvbIXcQn9G3yas?=
 =?us-ascii?Q?WrNRxQtLoFk4y138gjiMU4+xFAoO247HRC7oyiKKjLKy31J179a14XxXpE1S?=
 =?us-ascii?Q?TDv2fc+r4oNUSp091C4az2ul92TDHkBaOHuASXBey5veQLDG/kdQQgHeX22G?=
 =?us-ascii?Q?AD24yI/pmcUXLxaoggIHaIzr5dTXbI3QHGh5CzEZKUaNOwwzdDOuO6vs6NER?=
 =?us-ascii?Q?WlGJoGKF47cGZVqP4gnxh/IsorpQ7YfJEVbWf64eAzLfb6ndjP3lEcpqPp1O?=
 =?us-ascii?Q?gNrC0DnfO7enb2D/zw5SqRdggWTuy6BUe4Fb0qG4bvXhROOWcDMPT841FiX0?=
 =?us-ascii?Q?Oj9UWjbjoYIe1LTYbhBtYT3n9H1in08XjvzWIusxMfuKXdf39dDtNO1OMdxu?=
 =?us-ascii?Q?CkIWbK/wlKzQ24AI3NA8sS8k9Za3a8ZF7YJemLDIdn1QiD8v/o5uJXDh2eJq?=
 =?us-ascii?Q?wtnaTF4XzPbe4wDDgGE+qDKcNtUTvnDaL6xVsNAPvodrA2Jm2gq/2z/Xj+BN?=
 =?us-ascii?Q?OdDUgR5o9pCCmDNWOBWoiUNJNkE++reIUalnpT49+PK1vSVNmzWiZpjxcyO/?=
 =?us-ascii?Q?xE2EilxRkeyTq20BWi27G0/k1+AxdAsek6GEdRFr83aTS849zQZoVUglkCWW?=
 =?us-ascii?Q?xKwo1UIQctIrZ9eK+j7od50mJ18gpi87QviT+aGyCsWi9dpRIQNo9SbSSxba?=
 =?us-ascii?Q?Zd6dyORvXJmOfaPHlPjybzGQrvhhtyCvMK9PdbBJGFutRym4TXHnKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DXZ84G5tKbaXlVjBjYC07haudjZz96+rvgJTig0zzHt2K4xyBB/vpVf6FmE2?=
 =?us-ascii?Q?djXfzETr62GPzg5ifdhcgsOW/Nu0Mip/c43YMVs50AwRGlR9vJDW/J6ZpQT5?=
 =?us-ascii?Q?wyI1+izAgOIePrbd7LwYNp2tD4Jq1xedHhi6pkdEMIfYqpsJia+rVYv9rBSR?=
 =?us-ascii?Q?snReBJbrfJlB93LVJiTokkcQMr0PfD4J5QewHcJ8ZaqZloHr7I8AUihDb0Hy?=
 =?us-ascii?Q?ZLddbRjGcNlU2d89i+EgRtF685HCrP1NdS8CZNpOaE5aKN40VY3/seXEBvb5?=
 =?us-ascii?Q?lPYIMzMYTz/M3cuDZZiPwaJqLltsBXqbumxFH+OzPrtjqJAv6wcb1ab+iOhf?=
 =?us-ascii?Q?PcppwcOnU+Z/NkFh12kgTBPDRh8qNQ9VHZ2csD4XZ6/YYU0Eq8SZSxsnw2fS?=
 =?us-ascii?Q?BhBUlEE0WnbGsM2XwJ6fcW89REzGi1n/kB0hl/Jud0WsvN4gdwvabr2O09UR?=
 =?us-ascii?Q?AWRoEH7Ty50utHMJk6REPEoIfXMxqC1n/mOphm8puy3rb0PBNXBfeIKpP6Vl?=
 =?us-ascii?Q?TqeAcalTYKAmtZe00NMoK3OFO6doPN1eHN5OFNL00auicO2u/myr6K4gYRwW?=
 =?us-ascii?Q?HrDw91rjfhkT3hDj/zOEu7X4eqPvZKklbuZlcUa/Cg4ioUlUBTQuGyJAhNGY?=
 =?us-ascii?Q?ScwEBpi6Z25tS673lsKbHZHKFtfjxxp/HPBK+zwYo2MiyPaJf8fwXzXJWDaP?=
 =?us-ascii?Q?tWTnew5z6Y4jCInZnwVBVS5Eetqccc/zcoae790QJR8OyPOKjcW+i6dQARzj?=
 =?us-ascii?Q?PdJZTkrPv8y2KdNdXdKe0w27KVU9Jm+JJC63N+Lv/M5qHd8DVyUPIRDq/Cbi?=
 =?us-ascii?Q?nAYEvpvtRTO66slbeJ9uChxEk55w9OK3WK1LgsvXNiXlz2qOUGQHJN72MQkA?=
 =?us-ascii?Q?qdc/QuA9DQpYdOPPmlf9oFnTzYEzICxgAf8ht0T8nWSR1B77VFF/RfQ2Wb7W?=
 =?us-ascii?Q?4I8PaX2gFiGVN3VMIrGWJxZvoabOYXg4toXgLwZXRCTE6q/Nhd1o4ZmnyOXo?=
 =?us-ascii?Q?G18NjsCUAgs6sy0GP8SyZxGF2HP9Zr4OxypIvUVrhT6H4ZjkGTLQHzT6grHw?=
 =?us-ascii?Q?IAHuYF7MJ198jGS2mD8wsHJyRgunjLTASjRis0W+0fMrl+P+3mcLI4nZ2TlD?=
 =?us-ascii?Q?lFTarP+MRyfM+S25hzEHMcMDUy6Ye37A61N03BVs65uLMSPxLW3qRNNXkj2Y?=
 =?us-ascii?Q?/mwRGlGDmcgqpJorpfpeHaTl9qPu1X7OZyBXZTzgI5sD+YeTAQ7RYV7iPgKf?=
 =?us-ascii?Q?Jafl/Fza1p+QBydXCwc4l4ENJtcHQA+Vbtub6Ktz0ta1xrPvabPn4TPmMhA0?=
 =?us-ascii?Q?RNDAaltM3Ks39/b2TepaJ5/KByO6Ky7Gr92cTyw4Ykw6w/Hk2Cf9XJPyNVHL?=
 =?us-ascii?Q?+cd6rEKaGL2Ok3kGo0NzKPIyRP1CiDaLZD91mCU69Hf5gDHA7jCm6eqT+Jxv?=
 =?us-ascii?Q?iI/zUH7JVRxX0ELYuCGwE0BpsSjTm/PT7bNQDl+VyL4beVG4nUOaBX5ygFHF?=
 =?us-ascii?Q?l5CFtB3wiQWIEUgchj3l6xKgcfWZkqr+dxQe3DL0BH19V9RKWhKWKz/Lsoua?=
 =?us-ascii?Q?vjfWLVIEk0Nk5alsquzA4snQ2GpC+xf01hSOxKX6UXJ4p0L80/U7LeCbtc8i?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 953aa1c4-2642-4b7b-6a72-08de12c19069
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 05:52:50.1816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5KDEbDOP3lJt7l8DMWgLTQMy59F/LwvX3aJwF6ZGVq7nex+fhJqFs3wUsjrVY5K0PybCb4d+HSgmmvxxnDL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-OriginatorOrg: intel.com



Hello,

we are not sure if this issue is due to same reason as you mentioned in
https://lore.kernel.org/all/6c9eb081-45ad-4fbd-90df-ac87f0b6223a@suse.de/

and this issue is also quite random as we reported in
https://lore.kernel.org/all/202510221555.8c60c069-lkp@intel.com/

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
  vm-snb/trinity/yocto-x86_64-minimal-20190520.cgz/x86_64-dcg_x86_64_defconfig-tdx/gcc-14/300s/group-01/5

commit:
  b245bc23ff5840f1f0d54d2d76ff5facc03a51bb
  bde44378397b1969f2be5908f41083e900eb5294

b245bc23ff5840f1 bde44378397b1969f2be5908f41
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :1000         9%          94:1000  dmesg.RIP:drm_atomic_helper_wait_for_vblanks
           :1000        15%         148:1000  dmesg.RIP:drm_wait_one_vblank
           :1000         9%          94:1000  dmesg.WARNING:at_drivers/gpu/drm/drm_atomic_helper.c:#drm_atomic_helper_wait_for_vblanks
           :1000        15%         148:1000  dmesg.WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank


below full report just FYI.


kernel test robot noticed "WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank" on:

commit: bde44378397b1969f2be5908f41083e900eb5294 ("drm/bochs: Use vblank timer")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



config: x86_64-dcg_x86_64_defconfig-tdx
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510241329.c93f8908-lkp@intel.com


[   70.704709][   T11] ------------[ cut here ]------------
[   70.705152][   T11] bochs-drm 0000:00:02.0: [drm] vblank wait timed out on crtc 0
[   70.705792][   T11] WARNING: CPU: 0 PID: 11 at drivers/gpu/drm/drm_vblank.c:1320 drm_wait_one_vblank (drivers/gpu/drm/drm_vblank.c:1320 (discriminator 5))
[   70.706480][   T11] Modules linked in: intel_rapl_msr joydev ppdev ata_generic pata_acpi intel_rapl_common i2c_piix4 psmouse serio_raw bochs ata_piix parport_pc i2c_smbus drm_shmem_helper parport
[   70.707621][   T11] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.18.0-rc1-00238-gbde44378397b #1 PREEMPT(none)
[   70.708301][   T11] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.708950][   T11] Workqueue: events drm_fb_helper_damage_work
[   70.709368][   T11] RIP: 0010:drm_wait_one_vblank (drivers/gpu/drm/drm_vblank.c:1320 (discriminator 5))
[   70.709794][   T11] Code: 00 4d 8b 75 50 4d 85 f6 0f 84 5e 01 00 00 4c 89 ef e8 8d eb 74 00 89 e9 4c 89 f2 48 c7 c7 60 0b c6 9c 48 89 c6 e8 e9 d1 e2 fd <0f> 0b e9 9a fe ff ff 48 85 db 74 23 48 b8 00 00 00 00 00 fc ff df
All code
========
   0:	00 4d 8b             	add    %cl,-0x75(%rbp)
   3:	75 50                	jne    0x55
   5:	4d 85 f6             	test   %r14,%r14
   8:	0f 84 5e 01 00 00    	je     0x16c
   e:	4c 89 ef             	mov    %r13,%rdi
  11:	e8 8d eb 74 00       	call   0x74eba3
  16:	89 e9                	mov    %ebp,%ecx
  18:	4c 89 f2             	mov    %r14,%rdx
  1b:	48 c7 c7 60 0b c6 9c 	mov    $0xffffffff9cc60b60,%rdi
  22:	48 89 c6             	mov    %rax,%rsi
  25:	e8 e9 d1 e2 fd       	call   0xfffffffffde2d213
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 9a fe ff ff       	jmp    0xfffffffffffffecb
  31:	48 85 db             	test   %rbx,%rbx
  34:	74 23                	je     0x59
  36:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3d:	fc ff df 

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 9a fe ff ff       	jmp    0xfffffffffffffea1
   7:	48 85 db             	test   %rbx,%rbx
   a:	74 23                	je     0x2f
   c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  13:	fc ff df 
[   70.710948][   T11] RSP: 0018:ffffc900000bfb78 EFLAGS: 00010282
[   70.711336][   T11] RAX: 0000000000000000 RBX: ffff88815d8e0000 RCX: 0000000000000000
[   70.711854][   T11] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[   70.713251][   T11] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff3b6a008
[   70.714593][   T11] R10: 0000000000000003 R11: 0000000000000001 R12: 1ffff92000017f70
[   70.715986][   T11] R13: ffff88811066c0c8 R14: ffff88810ee51120 R15: ffff88815c68ec30
[   70.717248][   T11] FS:  0000000000000000(0000) GS:ffff888405a34000(0000) knlGS:0000000000000000
[   70.718597][   T11] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   70.719964][   T11] CR2: 0000560364c92008 CR3: 000000015c274000 CR4: 00000000000406f0
[   70.724517][   T11] Call Trace:
[   70.726398][   T11]  <TASK>
[   70.728373][   T11]  ? __pfx_drm_wait_one_vblank (drivers/gpu/drm/drm_vblank.c:1301)
[   70.730396][   T11]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[   70.732602][   T11]  ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:101 kernel/locking/spinlock_debug.c:141)
[   70.734628][   T11]  ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3))
[   70.736771][   T11]  drm_client_modeset_wait_for_vblank (drivers/gpu/drm/drm_client_modeset.c:1331)
[   70.738810][   T11]  drm_fb_helper_fb_dirty (drivers/gpu/drm/drm_fb_helper.c:373)
[   70.740680][   T11]  ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
[   70.742607][   T11]  ? __pfx_drm_fb_helper_fb_dirty (drivers/gpu/drm/drm_fb_helper.c:364)
[   70.749405][   T11]  ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:114)
[   70.751600][   T11]  process_one_work (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/workqueue.h:110 kernel/workqueue.c:3268)
[   70.753684][   T11]  worker_thread (kernel/workqueue.c:3340 (discriminator 2) kernel/workqueue.c:3427 (discriminator 2))
[   70.755736][   T11]  ? __kthread_parkme (arch/x86/include/asm/bitops.h:202 (discriminator 1) arch/x86/include/asm/bitops.h:232 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) kernel/kthread.c:290 (discriminator 1))
[   70.757807][   T11]  ? __pfx_worker_thread (kernel/workqueue.c:3373)
[   70.759926][   T11]  ? __pfx_worker_thread (kernel/workqueue.c:3373)
[   70.761937][   T11]  kthread (kernel/kthread.c:463)
[   70.763842][   T11]  ? __pfx_kthread (kernel/kthread.c:412)
[   70.765814][   T11]  ? __pfx_kthread (kernel/kthread.c:412)
[   70.769880][   T11]  ? __pfx_kthread (kernel/kthread.c:412)
[   70.771788][   T11]  ret_from_fork (arch/x86/kernel/process.c:164)
[   70.774087][   T11]  ? __pfx_kthread (kernel/kthread.c:412)
[   70.775966][   T11]  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
[   70.777858][   T11]  </TASK>
[   70.779512][   T11] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251024/202510241329.c93f8908-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

