Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD479331200
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065511; cv=fail; b=K2XJiwJV8nEJP10a+xAaDopXQitKRMlTMzl7zOpbOEGuZQ1NQqM4vVl/Bxz0BePv+/j5ZCwlnh5x4Cffi+egK8ANI62vpvjLTOAYGIzsTn/zresT0P5wV7ef8L71Is2z7rZr5pDlVeBO6m8E5good1lU7lxx67gPSbkJOuSzq/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065511; c=relaxed/simple;
	bh=IrnhiWoSVKeFvcCbaxQcvFhmzysqTt37Jm02nAPrvHY=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uqCxI8N13ixXGsPUpuEj3YDPLO4C+eItv2sskuzAJPVGoNiURi/31qfV8hMPt++wcM2LGBYINktAqo8iy5N9RkOn7v26Bngla3gD90jw3wYft+iGXakZY6OrmR3xWrkzkZqLJH7gGwF57kpKP1bOALMoiAeLgcGkXRQNr9Q6cHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSQIc5tk; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSQIc5tk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778065510; x=1809601510;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=IrnhiWoSVKeFvcCbaxQcvFhmzysqTt37Jm02nAPrvHY=;
  b=BSQIc5tkki3wVkGYOKz6oA9kTd7upXcwln28tL1uF1CZCmllQY4erIKF
   9Rw3bJmmxbXlV2x2jvzUblexDjvYunLgEDFCYKYV/lEq77Xv2t2l7iCGr
   MlZqYl4wFJN/g8b+VCPzl4D760QYGbMkRODO5yJhrLXQrhep8zproAezM
   dh3kbM9gYPZzn8uqCr01X54ocnuoNuAB6KIBkPlGkxrvCXomb0M60F0qE
   MneSWHAxAy+B9jvgYEz75YqQejui6kbMbtZ/t5UmGBzJ+9gN9adXNYlwb
   5RvTbFf+PbBFhlo1sSviiE8UHbMep9wNrTTpk1wdF3D5AQjJAQhEPyqDw
   Q==;
X-CSE-ConnectionGUID: qTfPZCifRWKeapccTQMd3w==
X-CSE-MsgGUID: rchJuVvwQjGJwIA1cwr82g==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82836558"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82836558"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 04:05:09 -0700
X-CSE-ConnectionGUID: 88sGd+4nQ3OiTzzIbsxSaA==
X-CSE-MsgGUID: g4I1d/WrR+iLReYBiyvb1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="229704820"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 04:05:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 04:05:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 04:05:09 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 04:05:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDB0pc6HojdixXicuQg6f/70RYCd935gvVaKnyZ8E/0Jr/CqJTAOim1JDcbK3LeDlSD4XtC0OkItiJSHYtoT6qCkGm3UVlRzbOIpZQdM46LGu+FdiZ+jKk7fs2Y1Z3NVfnenPhFmnZvPP6/vH2jdMnMmqoshQ2mIQ+2MeWWIfXOhe/45d2C2GycUffPrqCCFxOOE91CaFfufBy4QMtkPMVQRD1nCgdL69UMYYMfX52qZnmH3rldGWKlvhsb1yAki9/GntgW4pxcfEuq3TFOJvWgTc5PP1SrrdaB5Ts+6IzetMBc0ZkPU5EXd49Ee4bX35fiNxMfCLDxfvdSc85pqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpZQolo12eXS8BRtHT32ZwMmMZszz8EvMF4H+Tel6HI=;
 b=UVuadUXYrJWUehVf+3q0UezY57ve0+/g5Yv0iTASOKyzidR17joXv/GRwSAgw2zatYoWrlOmEeEThFkHvY8gqOawGEUb09f+8XIo6vTlwVsvSAcch6HK9rlYIeN18oba9rJtjNWsI+aXd7QCsUeufZyyV1iILO/sfbdMET3OkmM5cEb+LQLDxYa2CJi1AygFAAXqdIzoC8BpbEAcOSWUP4scFxNpLWLiIFaLi0HpbqEeOHr5fol4kgRk41G1p/uSEop2FoGonZd9OZJnQmFuLmYGN/D8IIrcJHqFUpRt3JnkZBZLDoi2RxcY35y6I7n9xyO9r8E84vOH8NF0Qt5SDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by LV8PR11MB8678.namprd11.prod.outlook.com (2603:10b6:408:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 11:05:06 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 11:05:06 +0000
Date: Wed, 6 May 2026 18:25:12 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, Juergen Gross <jgross@suse.com>,
	<virtualization@lists.linux.dev>
Subject: Re: [PATCH v2 2/8] x86/msr: Consolidate rdmsr() definitions
Message-ID: <afsXCIUjib70dBYz@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184521.7AADEE4C@davehans-spike.ostc.intel.com>
 <afqhbl9pKKwsVjOy@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afqhbl9pKKwsVjOy@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|LV8PR11MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f12086b-dd1b-4e92-ec5a-08deab5f5489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: cK5Y7mTLsc1XM1NtcKffZxfL5qlz9ZIrUepIr7GG4TtBDbeBbD3FTuJsUPes7XAXPwl3mdseapMfBhcSVyqZXFJ2rH84L9CYYVFC/+1KOLb3V6EPCSROvkC+idm4J/NSR9jSP6CDfrEkNZNb/JVmbbJqOyFuzqFIIHTZgB/W9sNHHymSESUqGH2BGZo7WI4yhMOotaAQZ9XiGWSRPY+KZkRAG/T/ZUOsvG3xLNrJYSbqr1Kq/wnx9+Op3a3cTEtw5b9IIq44fvWK/jk+PkIVO4r4p6W4K1FFO2aoFuZHyjwEm2zF2bk73tyM7UIU1qEzrkbBZLaKhwSL2DhB03GOXM8sMKg9E6Jjr4Nrx484ZbxbxGX2r82Bn8isp0+2eLfpoaDRte+wbYEZmmiMoIT8RhUvazVXrnbYeuomcp9f2U6Y9BKCiMLlsV8Qb8Ocv/YqkSnDKtN/8wgH7/ByuksraOTzRTUYDbjjJzFa6pCGvQox1EefB836nRqCPaRpAGlQ/sCZxssNaD3pirmdJdStSAXIPwyQ5P6JkCvq+yz8GpM6QkGMhwwGV1MEunW3xfTCq2A8jbk7dWydo+PU3Uik34DDtsx0A6bXfQQ8IP4V4fO8hc4XQDJ5wCB3HyP7rTyVta1l+n5R3qB1U20TpGySugrI87i6XP9gCJ3UOlYgAUsUDy9UP4+eGHmzxQQvw0aG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZnlsl9V4hMUJlMy87iE2dVA92vEfhENTcMAlrSwABEhjmmvFWbmkfUadHSL?=
 =?us-ascii?Q?01G3UivgrKuMaUK1Ck4vBM4qRtD4GdEP2ccwpubCnP1R3ZRlu5qvQJWCAEdf?=
 =?us-ascii?Q?pXEAhK9dXoA9osPV+/FKvC4zTIRAt6amFhNqSFoiNSkzUJCDF9njiUOCTgow?=
 =?us-ascii?Q?Y+0kQEAPINTEUyQ+V8HXKjAkovzMqSe82wDCXjgdP4PxDmiiwrM6n9XP19ef?=
 =?us-ascii?Q?2EY6ohaKF42CN3LPW5Hyzv1cbWtARYkIgYubxdM9Y/r4YEx7CQEPUzmlm4KV?=
 =?us-ascii?Q?OSaMSfnoqE4fWV8UKjRjTR656cFJtDbkCVg30gLe/TMUYsSRcz8IThw1DaFp?=
 =?us-ascii?Q?IIvlnoQCsEVCasCzKNeFtkx08L3R3nicv9Nw5oO4z1c4KCKB5sT6fmw6i5ed?=
 =?us-ascii?Q?Ka3ozOAFNc+H38o0dkpf/kq8bAEyx5VWp1/+BmjEvNMvfL1wYEhkbrZcot9e?=
 =?us-ascii?Q?+kum3Q73XCvh8NkV0qiLFaYqztJTgl22p4MWeCtcgM+YRW26C1o7nQ53SR8J?=
 =?us-ascii?Q?mlrPy0wRrWB00mzZMS7pDwUTnXWxorEp+Zd1XEPhdtr6wet60sCf/Ha4P8nu?=
 =?us-ascii?Q?XzmEgaqyOXxOj1MZx+kPiuu/DHCerTZOOF01YEQ7lUc5SjXT4RgupKDhErSB?=
 =?us-ascii?Q?R1MDGLA6dL8FXStfDgr+LT5uiNK5u83kGkOMlxZKu5Q8tIszT4HhZ1kjlQXL?=
 =?us-ascii?Q?3ovpS2F+0/TFCnfWoECgYamtdMGNCKbdytzgQEdwgaK/raHoth6nY0U8hYk8?=
 =?us-ascii?Q?eLG0XsLqqogxfE6SkcOVr3HVjs3++Fm9SeRCXtk2tfneGnzXCxNwqubCeztI?=
 =?us-ascii?Q?h7vWjYI2oU9Q3Z1e8Ly2ACPKjYcU/BZM67o5bcUXFJz79hp3JRtkPwN7oTPz?=
 =?us-ascii?Q?YZ4kHCGn99ZcRteXiX9qemQq3Z/1iGhatkRKjJaeLgAlsjadGHCRMRVbrfXZ?=
 =?us-ascii?Q?QYgvBPTXcErp2aspRIuc2wejYUQcecXGBmE/f+UPBfzvX1sOmb+VX35YpN5s?=
 =?us-ascii?Q?4LknmGwiH7wHmEhj7dClKc7BBCvL8rMf1F3Waf8anHwMUZKm2xgEsYTncM7g?=
 =?us-ascii?Q?Opk0RNt/uG/lfoP4Vk+C5K6LYVk96I3x13cIHwlf9bFWKv7eAikiJ2Wc5MN5?=
 =?us-ascii?Q?FeoIXMrVRbtyBVStjBpe+VQB4OKh4GEC4kaljihQZzm4zexxuL+MIqE7jiRw?=
 =?us-ascii?Q?m4s3dUrz6gjY467B2lCaPIWlw12snFM2BteaPD5JU2iMWLhAhZevBLQ+VZI3?=
 =?us-ascii?Q?v7fjWfam6LNNQ92+ADqSeOyXrlj/YfvU0MVMTbC1guupXzGunjSnSZYl9Nq8?=
 =?us-ascii?Q?sOzZR54+3jKaBEz3SDrCn3ecFCJ5Zd5ZZnzadez8lt3PEq41pIOeDXDuiq3/?=
 =?us-ascii?Q?2SPCt1DebJXEr8005hhpsduhX+mPv3gpn9jzC5LESxnEqWMO/XEYrUpDiZ6+?=
 =?us-ascii?Q?sLnxI/j9PsGJ9PHJU2jCBxk23c4zwClQrkHrG9Jtar7juKq3Fw5CvQ7Yxpfm?=
 =?us-ascii?Q?QzISljvHfHloFSBnsCZHlrp1XIMZLyPRsomAwbMA3z2PV/EoDhPLU/BkgEHw?=
 =?us-ascii?Q?jpcvqQAL1RFp6EhOLKHf9gxxcpGH532i8vDMwH/6IdLz+m6kLRzM2GNcBWdN?=
 =?us-ascii?Q?bpcHIcimD5PMaiO1VCMb2R9hzzIY0Zp2AEFPQSix93awpZ1/6FP8jwpBk4tq?=
 =?us-ascii?Q?pkXJCuRE2Ks3cYWvTpdsK6dJr86FgRocPdlnqWP/XVszr+FdHIykTC9vX2lR?=
 =?us-ascii?Q?n9O2J30k4g=3D=3D?=
X-Exchange-RoutingPolicyChecked: WdN1KQv4BSKGrOitx70kgloxRPVXvrtgIeXHtU9rWMDV72bPTNYXszb3u1ynmFTVI9JhnKFUdlz6Qvo/3Y/TeCugMKfmjX9qMvWAeuKO77ShEjBVIR5LXxuiBjXKwlraa9t0quERyZCZ3nsmODZNdIbgp6Bb4DA1qakhHzcPJ0ixXomM+ZY+UDw9JbuAXwXMXT9ZBj/2Xcx2Te9yLtEhTOIQ96ss8/5A1uDWy+oJdWAy1zH719McUKpCWrtEU3nMhpZXN79ihY8unl73YghQnKxQDWKWsihR+rSOiAr50rsJi6wZ0M0hcHJCATZtdufdjeEeN6sxSq8xGKT2ot7vag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f12086b-dd1b-4e92-ec5a-08deab5f5489
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 11:05:06.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28ML2aaKxw23X95o250GrePzdVNfNVzyOgYi/yl0m+QspMAac7mv2/O/w0nr9wcP7Tpivx/Jcd70+ky9JWRgNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8678
X-OriginatorOrg: intel.com

On Wed, May 06, 2026 at 10:03:26AM +0800, Yan Zhao wrote:
> On Wed, Apr 29, 2026 at 11:45:21AM -0700, Dave Hansen wrote:
> > +/*
> > + * Common paravirt and native helpers:
> > + */
> > +#define rdmsr(msr, low, high)					\
> > +do {								\
> > +	u64 __val = paravirt_read_msr((msr));			\
> > +	(void)((low) = (u32)__val);				\
> > +	(void)((high) = (u32)(__val >> 32));			\
> > +} while (0)
> Rather than direct all (paravirt and native) invocations of rdmsr() to
> paravirt_*(), does it make sense to first introduce the common version of
> helpers and direct the common version of helpers to paravirt_* or native_*?
> So, we can have
> 
> +/*
> + * Common paravirt and native helpers:
> + */
> +#define rdmsr(msr, low, high)                                  \
> +do {                                                           \
> +       u64 __val = common_read_msr((msr));                     \
> +       (void)((low) = (u32)__val);                             \
> +       (void)((high) = (u32)(__val >> 32));                    \
> +} while (0)
> 
Or maybe s/common/trampoline ?


> with below changes in patch 1.
> 
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 9c2ea29e12a9..7ba5bc921526 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -171,8 +171,19 @@ static inline u64 native_read_pmc(int counter)
> 
>  #ifdef CONFIG_PARAVIRT_XXL
>  #include <asm/paravirt.h>
> +#define common_read_msr        paravirt_read_msr
> +#define common_read_msr_safe   paravirt_read_msr_safe
> +#define common_write_msr       paravirt_write_msr
> +#define common_write_msr_safe  paravirt_write_msr_safe
>  #else
>  #include <linux/errno.h>
> +
> +/* Short-circuit the paravirt MSR infrastructure when it is disabled: */
> +#define common_read_msr        native_read_msr
> +#define common_read_msr_safe   native_read_msr_safe
> +#define common_write_msr       native_write_msr
> +#define common_write_msr_safe  native_write_msr_safe
> +
> 
>  /*
>   * Access to machine-specific registers (available on 586 and better only)
>   * Note: the rd* operations modify the parameters directly (without using
> @@ -181,35 +192,35 @@ static inline u64 native_read_pmc(int counter)
> 
>  #define rdmsr(msr, low, high)                                  \
>  do {                                                           \
> -       u64 __val = native_read_msr((msr));                     \
> +       u64 __val = common_read_msr((msr));                     \
>         (void)((low) = (u32)__val);                             \
>         (void)((high) = (u32)(__val >> 32));                    \
>  } while (0)
> 
>  static inline void wrmsr(u32 msr, u32 low, u32 high)
>  {
> -       native_write_msr(msr, (u64)high << 32 | low);
> +       common_write_msr(msr, (u64)high << 32 | low);
>  }
> 
>  #define rdmsrq(msr, val)                       \
> -       ((val) = native_read_msr((msr)))
> +       ((val) = common_read_msr((msr)))
> 
>  static inline void wrmsrq(u32 msr, u64 val)
>  {
> -       native_write_msr(msr, val);
> +       common_write_msr(msr, val);
>  }
> 
>  /* wrmsr with exception handling */
>  static inline int wrmsrq_safe(u32 msr, u64 val)
>  {
> -       return native_write_msr_safe(msr, val);
> +       return common_write_msr_safe(msr, val);
>  }
> 
>  /* rdmsr with exception handling */
>  #define rdmsr_safe(msr, low, high)                             \
>  ({                                                             \
>         u64 __val;                                              \
> -       int __err = native_read_msr_safe((msr), &__val);        \
> +       int __err = common_read_msr_safe((msr), &__val);                \
>         (*low) = (u32)__val;                                    \
>         (*high) = (u32)(__val >> 32);                           \
>         __err;                                                  \
> @@ -217,7 +228,7 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
> 
>  static inline int rdmsrq_safe(u32 msr, u64 *p)
>  {
> -       return native_read_msr_safe(msr, p);
> +       return common_read_msr_safe(msr, p);
>  }
> 
>  static __always_inline u64 rdpmc(int counter)
> 
> 
