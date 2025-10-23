Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133FC2A1BF;
	Thu, 23 Oct 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186574; cv=fail; b=JLEpt+ardH7ioTAHh1KcYNs1psKagIuHnsCz6v7hYg5gMj8QYBKc5DJBztPgs0695JzJgm2/fz6aCl6hB+W5czHpp6VnUJJmW4HfUHig5va19AUw4zpZI6y8ghdxxKhMIiUtL5a/Lw1ULJCwEn7PaVAyF41fzeWqi5ensGW0UUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186574; c=relaxed/simple;
	bh=C8vr0oj9Vy7/TfswsC6AsdcZzHHdgO8Sepj9pswaEuY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=vGjqL68hqA5ICK0ykquE7p4beVZchu6s2Sml7atKsbimgJbhnF6VOElkJkNikFN6XCx4jfChU5RbtzQQHUJ1vhc/WE/sPMFN3UjAqMCSlWXvul8X0UD9KNiQ2m7s6aUOmF/FicE8pcWvMw4UJaM6W9V6ol3spoK35geuj8Hoe80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuW2Jchf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuW2Jchf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761186569; x=1792722569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C8vr0oj9Vy7/TfswsC6AsdcZzHHdgO8Sepj9pswaEuY=;
  b=fuW2JchfZQjkwwDW/4381B2uqzH15m+5Ix6DtIPAYJs1NikuqOZtwO6Y
   1a0SCXDcZnHoCyPwv/NpKcM7LdDLznYXBfFhCh/QzS+WXWSLB5H7h+v1m
   JyAya0To8cn9iOOaiwGEK8ot0szH4/h2+Fik4hNNWoqwYtM8ZPx7+waRZ
   uL7s81Dm578e0L5eGtQDSy8hi+PweP96305Y5G1i8nzuRYt86cBhp1vtT
   XqxoRK8PsCf7IcjZS73uMW8RdJbUQrV+oiHLfXXcaNMKe7lCLFxyBkywg
   ex1CCVX+AEgTgXqyMDkH9f/Ex6fTI1I3imzjHnoGLCTefw0aboC+Zwk8A
   g==;
X-CSE-ConnectionGUID: mgE8ji+JS16Iib01LOYlOQ==
X-CSE-MsgGUID: UHyP/YVrTP+bwzGA5faa5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63049880"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="63049880"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 19:29:29 -0700
X-CSE-ConnectionGUID: a8xoPvlZS6yGK2YFhvhl7Q==
X-CSE-MsgGUID: VJkvo+B8SLine+CB0gGX6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="184424448"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 19:29:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 19:29:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 19:29:27 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 19:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVlnOUJodMEvSvN/ZPa/MQaeDHqOTi5yUmuB/2S0uAb3QhVS9b+37O4Sf1EQGuj6ooKielf3Nd3kzR08DAc2ub5EG/OaHhK3UBsG/BBgJE9J4mFkirvuf56c3X1rFx6kgYpM2tnriE4D46phvOpgeymaMX0SrTnOQGU3OJL5IY5e1cw88iTFeb+4ZH0/X0iCG/NfrkMw0Qxl4WLFdpWUL6UkIlAbrgts4BFIzE+Me5ounnY2ztpv9OXLO9Wc32uz90qs5gQeYXkNx2DHXtVGruFo+82gsRuoALAqsJiQ8n2LKro1R6j6mLvQWut4LTRNAQNS4iQbck5fSsJoYm1Z9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDqTKw43fVeCTYfuZhlqXF7WTlw/IBAsDNWMV9xhDdk=;
 b=OfmV47el+E6m2FOz2UcPxVO3rqQYo0eug5Lq8/qNN7iW9KHKl5r6Pq0j9JsDVy/xqbc4jh+8dTkysbYQ/kh0pxgTtJfNM3Tl5qCcNnovUOwzZW5EzKOEZom2NMHx36q+OJ4LSQkN/1ENl4L7prBqQ9oF2np8l8hGRoH7XodMat2UGBfPEFMXqohuO8qxkPS1b8VWkZ4XGcvWOC5FZdqnOYCTs74FzF7o8PbftK7M51o6uoCrSriQc5YbZL7ORpq7J/q5OgFnO3AH4xkOhPzVcKeEYPJvnV/weviIqRYm7ncNOlqUTHhqiuyBG5OdZG/IliD1FDxe8CMV8VKay0miBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV1PR11MB8841.namprd11.prod.outlook.com (2603:10b6:408:2b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 02:29:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 02:29:24 +0000
Date: Thu, 23 Oct 2025 10:29:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Gerd Hoffmann
	<kraxel@redhat.com>, <virtualization@lists.linux.dev>,
	<spice-devel@lists.freedesktop.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [drm/qxl]  e485883c81:
 WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank
Message-ID: <202510221555.8c60c069-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:820:d::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV1PR11MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b069380-4fd1-40c1-dfbc-08de11dbfb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BJBJc8IZQxtVtTbUE7SmosIxDPINnhMgWfev5fqHyEjGm232TGWLMS7jgXyq?=
 =?us-ascii?Q?a7O5UqX8G1Bf0HlkU3Sik7K+Vg6UgKQJnKd/g+nWasag2zWeW7ykeG+RpjKz?=
 =?us-ascii?Q?rz9lMJaDam5pLF5QFLIynAVeTBhyMlXApcZTJQ/7jrfZbKg745DRqyJ51sfX?=
 =?us-ascii?Q?c8WSxTgZKszmMwhbXIRiWWL2Or2dyh5qez1wfW/0iu8jlI8md7nmza2bbiU3?=
 =?us-ascii?Q?yYm5YQOQLQzczrgB+/XDvB+J3Oun+itZ815+3VOWSHc/1f7L2dQ9ykZz2jTf?=
 =?us-ascii?Q?ieLRvtAKnQsG0UP5z4qjcYVUHIsKJ5c5nrqRagKYcWnY4aHmeqJsymwyalNQ?=
 =?us-ascii?Q?snE0hfiLKUL/4kuy8q49X1O9ZAUIj+/4XEc0ThCfH1p6uoIxJrpeqVTyXoi0?=
 =?us-ascii?Q?jA+OLQfQjCjwKwCRWpZHFK6ECvYWj1Kq3mJ6OYJrcWU0Q/gwPUUoJCYh9VSy?=
 =?us-ascii?Q?vmC6GFPBzLni7SghSxZwxgChGttebGSiDusJkE16QHuvJlPi/rYFgIDTVaFm?=
 =?us-ascii?Q?ZaFoaX3EVfFxMWRlqsDAKdbMASk3qGU2w0fDYnUYgvQdC3bZT15sqXA0O7Tw?=
 =?us-ascii?Q?VYM5C12yic7bF49ZkBk8ZPXGwLVB5Xkpm5L7eVkTqsyv8zazx+kZIlLaKyyi?=
 =?us-ascii?Q?tOr79uN1dT7blF4o+DoggGMri36enziIFPiWpA5OFOGFvtKsfK4SXzgcysyK?=
 =?us-ascii?Q?HRdHi8dEdbc5kntGJbvyTidMqjZYzqnjpz5bsDQb/CpfWhjyKCYhJHWLtI5K?=
 =?us-ascii?Q?9oDmLdYqbXfxgw1BQ0VoaluXeVoB32gMvkSSQaYrJPUxNyH4EX5iO5Wt5+E3?=
 =?us-ascii?Q?QwJz9h9Y04pJHh9/OcPVAsmVgG4iOio+oXMkqKMb11eztApYwn+YOO2eNeGT?=
 =?us-ascii?Q?AfXQtuTuv4FXZPYreZ0wYJsQ+bA6h/5Nswife+jLgll69O4rhYweGiIOazFP?=
 =?us-ascii?Q?fxeLlhtlbWmR8BCzJvPS1DePwglSVRWYdZygInA/en5ftm12+AgwbScdAEEs?=
 =?us-ascii?Q?qw3IBL0VnxMBEoHQqWWm//Vm8pzBctzh0aydbPQtTMt0o1PGjIrbe8HFgKOj?=
 =?us-ascii?Q?kftPtxfAe+ODRq+qOtTILKRxeDI4RIWgWnmoEF2D3zz/4eKSLOlEsD0/Xv3Y?=
 =?us-ascii?Q?YO7xcah4QYD9LAU0MhmZYsdtYAZmoiua697I1hEup7hV9CEWmLiYBgogO+rI?=
 =?us-ascii?Q?ly0h7Tm5V4aZxEZstSCMQdMmKKzyDyPPJj509hYoe6ebmujhuDDbG82YAzEc?=
 =?us-ascii?Q?5JY9MfnXIRAsOnjuchFUBx5GUp34ZrlhXoGGJR15kixOlWKPHevzOPZ1nSBe?=
 =?us-ascii?Q?2S5ySudM50AZMAJb47voSt4dx87N+8n5iVfKbaifqirbCsh+mNKhAkKSLRNO?=
 =?us-ascii?Q?N4L+pz1xCcsbwkwHKeCy1S24da8Eranjtlqj8ghE5kk35GgUWBhiVhnikavC?=
 =?us-ascii?Q?GZjEbPrjB4kSPo/0F53Yw3qdk7i/5h3gL30Nodb6VFneIkLmL9vWsA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlslvpkkDul3ULZIh2qehVmWUVEwZ5RYe5XnZKdJu/WL33Mvb9Pm7GvbW85O?=
 =?us-ascii?Q?X1+nj/1owHyjAeOjNdtDxDHxpppHt2d/Qr01HBLSP0QO8HNDk0iepnJIsTAN?=
 =?us-ascii?Q?HpqcLXxcVTrrXFDCs17v8FfLREXhvtq50WdXFt1FWhebE7QNmT8mlfVfSk3m?=
 =?us-ascii?Q?sKR6RnH/Jjz1exB/Y/B3iORJtBuXnLfvAskQ1VsZsiaNCwvgbAm2HFDV9PAt?=
 =?us-ascii?Q?BQfdAzzcfLxGIBKTU0kgwq+N+9h++1DUQkzzioVZl4xsbBANnnvZfHgejBtH?=
 =?us-ascii?Q?g+tXgOKO97Ba2S93BKwHab1OcM3VRz/q/I0LG4GS0VqXd/d5nRD4+vaXeMnc?=
 =?us-ascii?Q?z9n/IRbIwFhBDBw6j4kRWq1/CwH3ASivzSCTQNi/LUgmyKb1eYmqVDDZw0/f?=
 =?us-ascii?Q?/goRwUmJacRMRHOm/C/CYl7BZFnR3MS3z9OTLP7Fo+uU+IhJyynkcAQeOmFj?=
 =?us-ascii?Q?Nwhohv8QT+3PNphOzXkfI7qZcnXDFZZmC8wC6Fx/jaG7rWQg4nGeqAiLaCNx?=
 =?us-ascii?Q?ywX+FJmsaGZkGXtyZ0JxRotV6JZ4wzn4BeD/aI9/NtXZDk7wTPvxxmyFOHKo?=
 =?us-ascii?Q?98c7PWVPfYJwyjha6io3uNJA2LPf6rR/gtSlQFMzsUHgsmk3QvZ8xVtYZs9q?=
 =?us-ascii?Q?oGQ/fm95Hf/pswIB1ZHzzoOXwPk+IBy7uP8efh2TjsiT3UrvhSFnBn/mN0gh?=
 =?us-ascii?Q?k7/gHCxvvnPaUESecsxe+wDB2qqn5nIQ80mowQP12maWRdDGiBZuUpsHaPTs?=
 =?us-ascii?Q?AB8eh6v5E3uRP7lD87ORdLb5CXmleJJtPYQ5T6BCgt2sdDtX9v196ksUae2k?=
 =?us-ascii?Q?sIoRk/hMNZzZQFjhZRXxKvsB8xA5Oc95F9n2wxylxSaETmN6vPr3HIOqRZnI?=
 =?us-ascii?Q?BXUFsxkgJhJpzpo6gYoD+AGfmu+1ZpwvUiFlKwTzY5iLcYofT1clYgLFffkw?=
 =?us-ascii?Q?BVjqlyylHs4DA5rPOOocbMkwtilXP6TJyrfbSF2B5H/9qzASopFdiTNU609K?=
 =?us-ascii?Q?k6jnuwZ+XOMPnCPTnBeoDwBMAQpnu11++4jX3Ki/+/7EiinoMJ9gcPgmPWYN?=
 =?us-ascii?Q?jEkyUEqjfxNZnjiKeaeN0vZq4YOFxbfv+Um5pxof8MUJHe5hBOFlS6xkvZV2?=
 =?us-ascii?Q?XJqXaCC9JVPwEONa2K2oJ1eEZT6rFqTxzpO4pSxLBPewfzzbm31MnX6e8yF1?=
 =?us-ascii?Q?xm0WXSN8MibWNVA1gLt9vQmjn1MsXuZeIQTJmXB/KRJd/nx0CqxTTR6gClsF?=
 =?us-ascii?Q?d20XIiVDeXRGb8LLRKLymxalbBXbPlKLsbibH4Cva/CY9lk1RvCD+dITSI4f?=
 =?us-ascii?Q?0VeW4JEuBLfZ8qKDS0EzzOeFKANBcV4cF6yLMSoRT9OmQEPgn7cr0iefjBFt?=
 =?us-ascii?Q?FlH43E68+eNa//F2+c6ek6Rn+LVAbZjh4CWiwXW5OfCP4QZyOonoNIcbiP/F?=
 =?us-ascii?Q?FIIUFWgXLFliRgJ/U3876JyKMM+B1+8Lxzq8BmpvRHGVfe7NSHjiPFKbAybW?=
 =?us-ascii?Q?w5MVrv3kUjLCdoUDPi4Kx38oLT7EyRrhmMi2ghApzl0tmN3C03uZ95jIp6KZ?=
 =?us-ascii?Q?ktyLGzLU5RH9J+x+1NKEbf8RESfyAtsCUNGjbSQD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b069380-4fd1-40c1-dfbc-08de11dbfb1d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 02:29:24.4139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDJ+9Ee1rYtbG+FUuYTzcQDC032briaXF8pA+q363TTSXRMv/0GbwS2XgNRAQ3UavPVswtzL5rLzf292wRKzxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8841
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank" on:

commit: e485883c815ee908de82547806d6edd65664b77b ("drm/qxl: Use vblank timer")
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

we noticed the issue happens randomly. 6 times out of 50 runs as below.
but the parent keeps clean.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
  vm-snb/trinity/yocto-x86_64-minimal-20190520.cgz/x86_64-dcg_x86_64_defconfig-tdx/gcc-14/300s/group-01/5

42dd66d377ccf786 e485883c815ee908de82547806d
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :50          12%           6:50    dmesg.RIP:drm_wait_one_vblank
           :50          12%           6:50    dmesg.WARNING:at_drivers/gpu/drm/drm_vblank.c:#drm_wait_one_vblank



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510221555.8c60c069-lkp@intel.com


[  256.077310][  T135] ------------[ cut here ]------------
[  256.078847][  T135] bochs-drm 0000:00:02.0: [drm] vblank wait timed out on crtc 0
[  256.080802][  T135] WARNING: CPU: 0 PID: 135 at drivers/gpu/drm/drm_vblank.c:1320 drm_wait_one_vblank (drivers/gpu/drm/drm_vblank.c:1320 (discriminator 5))
[  256.083260][  T135] Modules linked in: 8021q bridge stp llc nfc pppoe pppox ppp_generic slhc crypto_user ib_core nfnetlink scsi_transport_iscsi xfrm_user sctp ip6_udp_tunnel udp_tunnel uvesafb sr_mod cdrom intel_rapl_msr joydev ppdev ata_generic pata_acpi intel_rapl_common psmouse i2c_piix4 serio_raw bochs drm_shmem_helper ata_piix i2c_smbus parport_pc parport
[  256.094913][  T135] CPU: 0 UID: 0 PID: 135 Comm: kworker/0:4 Not tainted 6.18.0-rc1-00240-ge485883c815e #1 PREEMPT(none)
[  256.097761][  T135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  256.100575][  T135] Workqueue: events drm_fb_helper_damage_work
[  256.102578][  T135] RIP: 0010:drm_wait_one_vblank (drivers/gpu/drm/drm_vblank.c:1320 (discriminator 5))
[  256.104543][  T135] Code: 00 4d 8b 75 50 4d 85 f6 0f 84 5e 01 00 00 4c 89 ef e8 8d eb 74 00 89 e9 4c 89 f2 48 c7 c7 60 0b c6 a2 48 89 c6 e8 e9 d1 e2 fd <0f> 0b e9 9a fe ff ff 48 85 db 74 23 48 b8 00 00 00 00 00 fc ff df
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
  1b:	48 c7 c7 60 0b c6 a2 	mov    $0xffffffffa2c60b60,%rdi
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
[  256.109982][  T135] RSP: 0018:ffffc9000079fb78 EFLAGS: 00010282
[  256.112311][  T135] RAX: 0000000000000000 RBX: ffff88815e2c0000 RCX: 0000000000000000
[  256.114875][  T135] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
[  256.117530][  T135] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff476a008
[  256.120090][  T135] R10: 0000000000000003 R11: 0000000000000001 R12: 1ffff920000f3f70
[  256.122749][  T135] R13: ffff88810fe460c8 R14: ffff88810be64d00 R15: ffff88815cfb2830
[  256.125298][  T135] FS:  0000000000000000(0000) GS:ffff888408834000(0000) knlGS:0000000000000000
[  256.131615][  T135] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  256.135805][  T135] CR2: 000000000109a850 CR3: 000000016d2a0000 CR4: 00000000000406f0
[  256.137327][  T135] Call Trace:
[  256.145896][  T135]  <TASK>
[  256.147603][  T135]  ? __pfx_drm_wait_one_vblank (drivers/gpu/drm/drm_vblank.c:1301)
[  256.149778][  T135]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[  256.153665][  T135]  ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 kernel/locking/spinlock_debug.c:101 kernel/locking/spinlock_debug.c:141)
[  256.157616][  T135]  ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3))
[  256.165734][  T135]  drm_client_modeset_wait_for_vblank (drivers/gpu/drm/drm_client_modeset.c:1331)
[  256.172077][  T135]  drm_fb_helper_fb_dirty (drivers/gpu/drm/drm_fb_helper.c:373)
[  256.177086][  T135]  ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
[  256.181829][  T135]  ? __pfx_drm_fb_helper_fb_dirty (drivers/gpu/drm/drm_fb_helper.c:364)
[  256.187127][  T135]  ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:114)
[  256.192329][  T135]  process_one_work (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/workqueue.h:110 kernel/workqueue.c:3268)
[  256.197045][  T135]  worker_thread (kernel/workqueue.c:3340 (discriminator 2) kernel/workqueue.c:3427 (discriminator 2))
[  256.201991][  T135]  ? __kthread_parkme (arch/x86/include/asm/bitops.h:202 (discriminator 1) arch/x86/include/asm/bitops.h:232 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) kernel/kthread.c:290 (discriminator 1))
[  256.206956][  T135]  ? __pfx_worker_thread (kernel/workqueue.c:3373)
[  256.216519][  T135]  ? __pfx_worker_thread (kernel/workqueue.c:3373)
[  256.220825][  T135]  kthread (kernel/kthread.c:463)
[  256.224107][  T135]  ? __pfx_kthread (kernel/kthread.c:412)
[  256.229092][  T135]  ? __pfx_kthread (kernel/kthread.c:412)
[  256.233881][  T135]  ? __pfx_kthread (kernel/kthread.c:412)
[  256.239125][  T135]  ret_from_fork (arch/x86/kernel/process.c:164)
[  256.244094][  T135]  ? __pfx_kthread (kernel/kthread.c:412)
[  256.248707][  T135]  ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
[  256.254397][  T135]  </TASK>
[  256.260599][  T135] ---[ end trace 0000000000000000 ]---
[  349.555954][  T346] sh: can't kill pid 3589: No such process
LKP: ttyS0: 304: LKP: rebooting forcely
[  359.020039][  T304] sysrq: Emergency Sync
[  359.022624][    T9] Emergency Sync complete
[  359.032291][  T304] sysrq: Resetting



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251022/202510221555.8c60c069-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

