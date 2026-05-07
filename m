Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA93A16B2
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144524; cv=fail; b=MWgX4/pXmEJhZ0DQUIQpGARGAo7fhHqR7qa2q/c/n+3DOaXGWZIO3ybf5xfAqQBgXr5TAQyhtHjeVOPC6aWNkALN+P4f1ZaZSB+iinc/eBs/vTl5rT5oXj0AB6F9El+k5uIgbSduHFtufuoKCutD4+aIzWHKt8Zrf1gWNLvDj0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144524; c=relaxed/simple;
	bh=IKiZSL7KzPqS14Op1yX2IwuvuPYj38t8JPKaB6lXnV4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nDwz7ZsA7ylh7/9Ckt2ToB3aNRTrqWpUeleQMWVuxMr2+6uEEHOaeubCn8fpXGdLSfdIGBxp0sC+A1DvygXrAAKvwGuHdn5stCkwSjqi8wjdjdpomlErNCfpnXpxC5pMR8WkVWnOf1be/UDioSwP8qLFuLnVaFYPPyxLhe6JlLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltVf0Wr3; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltVf0Wr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778144519; x=1809680519;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IKiZSL7KzPqS14Op1yX2IwuvuPYj38t8JPKaB6lXnV4=;
  b=ltVf0Wr3YM+nl8/M4aSi7HNsCH5ifwm10TFqlWE1SGHF+V96k17HTUCl
   yQhcFygBuXzP1Ims0b/ZWDbVCc9wl848RjmxrQd/eLPMAyaVzqKZ9qvwU
   FXRb9YXf0HPp7mG9IRmiiqgxK3EsDyNt/0oToGVzqLz6i6bnBlBfb+dmE
   5SAnKIyx9i2oTabVapKJHufyiMPyyYCj5IRNSHzWbPz1YJb3+pdymB9td
   jJr8PVv3nci/kGECrzFIO9jTJDGVpLgl94kM8yF/mr+NbZZUwSAAOnRRe
   7zk6VELlNNis1XjihMm638uyPW89BKliwdssyTMKxvf100wpVGhJPDGgI
   A==;
X-CSE-ConnectionGUID: K5Y0s12BTsiP8KPHqiQq+A==
X-CSE-MsgGUID: jgsjcFqsQ/uQM3thvZVU9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="90468027"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="90468027"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:01:55 -0700
X-CSE-ConnectionGUID: MCvye3GLQB6GtKteK45n2w==
X-CSE-MsgGUID: o3KPpQ3PSOaRRHBeFD+rQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="233316562"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:01:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 02:01:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 02:01:54 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 02:01:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXUdBKURz4dldfD1m5UNXlcZtJFZ32/xm92K0YWPLNlrTEQ77KSSMFMmrvOc7ub9Mhzy77D/QtVrKswrzLpJehXYhM5Jkxj7UNKhzB+H5R4ShzRZVKJNHP3dzYe32W/38YGK6E6eJ1Dae6ECTHgkiPCQnHfoNG4f5gvcctXurUrV3PzyJZ1CCjpnev0NAmrgaEyJFNsgGsFJyB0JAjHfvgJT/Onm/eE3gmQ6Hix6dYFrlkSV3t5V4kyOIi5GDL2WwicUzC50ak9owy/IS+65Xk4tipuDuEl4N2CvG2Wky5/SnNozfUMKI21zVAFeInU+QmeorKMMaVmcRQxqsD9QZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlWOWvCLhv/4iIy0tb50S2Fp7Ur8VnY1zNNR4iGd4dU=;
 b=Fwb+C1YZyBTBGpElZmwRp+iE+bKC13o8ujKDb8SK0/A3PWb3HOD5RyZoKWoD+SYIUmcCVMr++Dbdc+L7C7JAFXr9Mez52SGs8ncrYCdqjE/jWndfGSNpprpkY8OShTeFGYhMIUsWoC63JL9Ii1nZuDAVy4hzXLjP4wO4nKp4ttucMN1aJK97bZBdx1A/SUizQ927glX8zW+7LwgqT+IwXVkm+TRCPkJoYhHeHahLNd9EQaj4whNzi6hYH5d559efKwSLueSbbdGQFZmwZjhlIYNLioKWse8jdOCVBBAMZz4K6Qjsnams9h5ZfOsNgJVwq7IoDTF28mjaHENTBTtbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by BL4PR11MB8823.namprd11.prod.outlook.com (2603:10b6:208:5a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:01:51 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 09:01:50 +0000
Date: Thu, 7 May 2026 16:21:54 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH v2 2/8] x86/msr: Consolidate rdmsr() definitions
Message-ID: <afxLosHwN6uLpZ1r@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184521.7AADEE4C@davehans-spike.ostc.intel.com>
 <afqhbl9pKKwsVjOy@yzhao56-desk.sh.intel.com>
 <afsXCIUjib70dBYz@yzhao56-desk.sh.intel.com>
 <c3d08fd7-4938-4db2-9962-1c87dab74a2f@suse.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3d08fd7-4938-4db2-9962-1c87dab74a2f@suse.com>
X-ClientProxiedBy: TP0P295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::10) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|BL4PR11MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ce6f12-a9e1-4dc8-001b-08deac1746b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: iRTyBhmnhSIwSA3zcDgwP7LOQuNn2/d8CDrfm6HNok71Zr0EiOzLytGgs/OnTIYBq5lC0vU4du+YiY7WJvRkJz3irrlRY48b6YPynMwwOeQ88arS7Y5FirgxkBJ6mW72CrdnXG/ValBf9tNYrR2KCKxjrUNnWui+uB9z4M9y1wxs5EIrTsZpdtQjgtWKwSo+YgxQsafCeuPn/vkEYxGf2ySjmdsGAvzGmj8RiL/nZj6qa3iK9dHeoSXPaxkUpckbkMSq88Ch2+ZABQ1LLo+9Tbozlm+au27kAo5akby/XmGfQw0aXKQhs3vnEud8rBdCi9+svvYsm0b+aUbMs2nZl2OG1p2RLGa891a/UaRXfkmx06JSYzHzACAZyiXQmB4j11Lq8v/50ZZfS6svxRqPyaa7qjKUyl/HQJDdmI9VRvcbSK0j9RKRbkjCNt2OjUyOvJ5c5XxXxNJl1E87yaPnud03jXFE2xWi8mxy4b73e2sF6UTEgS4ZD44TsdHYiTnwJR3h0wM3Aw+lMfosO/Yq32yFTHKVhid/GcXe/1JsQLDWJfhhVZa+As6ay43i0xD+3hssKQxlzL6fg0QtXE1sBbTGW33ocMh6A+O14RLkKeSUAzbcjBX7S73mTc20Elhlht79xrNJ+kOwmth/Vf8F2guh5LzwSNQAndLZk4KB1clifFZHnjbSCk4xHJ/mj+/g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PorzvL82KsPczovVIzCwyRyCMD/yupgUpRrtDfiVEu2ikjVmxuyNhCUbNG?=
 =?iso-8859-1?Q?I8O3GP78lmVWU/1oUUrjsycxzI3GDs/W7vPA29BcWktzMgBidbsyQNSmrW?=
 =?iso-8859-1?Q?tbhq85fUpIN1BUoKyP2H6cV4uHfDe7XbqD3tZ5rAVWzZ/ttv79guV4p7yS?=
 =?iso-8859-1?Q?KzVu1e1+AyUPT3apYCJJNHp0iKErLup0y6yqJ+wAVRGJ1vpz+uE6JZPUJY?=
 =?iso-8859-1?Q?Wskz6kJyTYrbxWl1MaSB0+0uW5q8KHgjyPKfpDAqOXWoMra1WGnpegyUNd?=
 =?iso-8859-1?Q?1d4t+xjMq7hGrVCiZIqZdCoryZIv5ZLuFjPwh3PoVbRlNZ8utcSiYAcrTF?=
 =?iso-8859-1?Q?eO1QD5zQuujFWvl4rqQBI176/nvghRWH38lm7bZVgrDYSRmcMjSjYrHWO5?=
 =?iso-8859-1?Q?UJ52i93ujKDcimXbMpFMuaDuefYmJkrXvHNIhrYXJFTlxix9m0OmQeZCfr?=
 =?iso-8859-1?Q?SWB7z53T+sKclEq/CEAwwvnPRUNMgFI2aLIpU9jLY0NIAs//diFwTKx5mC?=
 =?iso-8859-1?Q?ZAovM85bnwS85+tr7yf/6UVR6m6E+UqiIpq8pfD51e6V3gwq3fGRBgDXtb?=
 =?iso-8859-1?Q?k7tmsU3lhWovA9Buo/Rob7Mx8QpSW0zwUZaqc6KkWAVbuiRiU6cLY7XLtU?=
 =?iso-8859-1?Q?w/wtD54QUT4KaL3rPo9AY1sll5aZa1Rn7H3aJlyNY9m9OBa/3apBs6wV9y?=
 =?iso-8859-1?Q?PICxJwYxPhr9NteC3wshxBZMX8LhSWJ+FurjG8e+51oBWhIkHnICtPa9ow?=
 =?iso-8859-1?Q?ik3ma9dTHz/kS8km8Ozlvu6hWSutMeIK+cFe87jHC3sogc9QaTqvIBnrP7?=
 =?iso-8859-1?Q?o87jzlH85uvyNPVtygGmNgLLDETn/Ztfh+Q87kGbdLMFGfoh3506CjYImj?=
 =?iso-8859-1?Q?Iyzs3nP2N7RGCHtwOMudDI5WiaRCi/yr3Qw2mfsSaX56/HrPFtDiUBVHmY?=
 =?iso-8859-1?Q?htwE1p2FHF2ICX1BdAcIo+bPJFeJWEz15YBIm3791l5rSYl4V++0L6qh8H?=
 =?iso-8859-1?Q?l40Zio4IPoyZldsY5Gx2YlU7zSThf6lfowKuC1F91targBo3OO16R0WSp/?=
 =?iso-8859-1?Q?DPbOEPDUQ1T5kSdRdX8zjAVPGdKhEnT2JRtX7acKvfUt77/tHw2uM1ykSs?=
 =?iso-8859-1?Q?oqvgKeQf2d61c9k6x8xx2q+zgtWuW84hhtxxoN7thqHV8wN/eZQR0DMpkI?=
 =?iso-8859-1?Q?XiUWN9ROuroXctJ+GXkVpRs/VdSR+eoqmt6PPdeJAhSvv63G/bMnl59Qy6?=
 =?iso-8859-1?Q?WTTmWAhEC93gINQgn49bpdu8NkyiB8lQtiQ3yzbidtAhDg34I7eCPuHuL2?=
 =?iso-8859-1?Q?mfVRKFM4Vc9iPNPbuf27bJN6iFPA9yaVWujTd34SJZeleUsx0BcUYYd1ni?=
 =?iso-8859-1?Q?kCY2wBSXNSl/+QpkxpI9YgtjeK89Whm0wHrh2oJsCG3pCA23QolNiaw+K+?=
 =?iso-8859-1?Q?6/989yt15+1TUsUubHDFCA+vt8yoyMv21mb+LN4OaUXS6Rs3Rg19N/9QKE?=
 =?iso-8859-1?Q?uW+S1VgSuEwzS6n6K6zRrg11LMYamn9aEsQnhstPh8IhVRAbsw0tt5wWgd?=
 =?iso-8859-1?Q?KpqFapacXVhjqMu+AGTnBM2cRKYCCJgOB+YVZZmALz1+iu1+KH8VhiUxDQ?=
 =?iso-8859-1?Q?vCh2MHjGLgJJe24xBiphr5nTxDaxFb9qKz2CSgXuYEELdNtO2Inddlf6Gf?=
 =?iso-8859-1?Q?f9bPU0WxJeQUb+e5WzDXEBQmBGXpTqPuAGa/mdcFOwroVb1OSkwSckGOkb?=
 =?iso-8859-1?Q?CayunKEqq64KIC8mOBvnAkutn/sqc344cBzWQ7LiTj2Jj41eXRIk7Ci4bB?=
 =?iso-8859-1?Q?bwI8Ft+ogg=3D=3D?=
X-Exchange-RoutingPolicyChecked: RWOt9+M/AsB5RXRCoBnih4GHk1SJKkHb3VYeYw3K4tahY01eQNcf28kFYkPDbSjGdlIJxwTpro8yqKQrfIovrHXFz2e3f4V/B86KfxdJ/+wHedkUVz8GKUOp2DmTh44O/JwfNfq/K6F3vlaZHxi3DRwN3fQodPHGQm5sEu/4Ln2dtOwiL7Dxd6xp3HY/2uBu2qYR4uL468AUOlUSxqomLGgZLu2uTySQq/9a7CwDqFxoT4gfN5203YUQTk9VMNIP46SWZF5dTJlPhcmZ/m3GXGUDhFwDp0ovQ7Q70TecEIJw7jpDauJUqe55f55WcwdrCBm+UfuC4ngcUWvtQVp5ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ce6f12-a9e1-4dc8-001b-08deac1746b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:01:50.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2g9Tno4mPpP2l3SQIYt/AfFtekhiBbknaE7gTX8zbJB2w9BHfnFc3qT0JM5pURuVvSWgiyXeHgA47G6tRsrFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8823
X-OriginatorOrg: intel.com

On Wed, May 06, 2026 at 01:09:07PM +0200, Jürgen Groß wrote:
> On 06.05.26 12:25, Yan Zhao wrote:
> > On Wed, May 06, 2026 at 10:03:26AM +0800, Yan Zhao wrote:
> > > On Wed, Apr 29, 2026 at 11:45:21AM -0700, Dave Hansen wrote:
> > > > +/*
> > > > + * Common paravirt and native helpers:
> > > > + */
> > > > +#define rdmsr(msr, low, high)					\
> > > > +do {								\
> > > > +	u64 __val = paravirt_read_msr((msr));			\
> > > > +	(void)((low) = (u32)__val);				\
> > > > +	(void)((high) = (u32)(__val >> 32));			\
> > > > +} while (0)
> > > Rather than direct all (paravirt and native) invocations of rdmsr() to
> > > paravirt_*(), does it make sense to first introduce the common version of
> > > helpers and direct the common version of helpers to paravirt_* or native_*?
> > > So, we can have
> > > 
> > > +/*
> > > + * Common paravirt and native helpers:
> > > + */
> > > +#define rdmsr(msr, low, high)                                  \
> > > +do {                                                           \
> > > +       u64 __val = common_read_msr((msr));                     \
> > > +       (void)((low) = (u32)__val);                             \
> > > +       (void)((high) = (u32)(__val >> 32));                    \
> > > +} while (0)
> > > 
> > Or maybe s/common/trampoline ?
> 
> I'd suggest __read_msr() and friends.
__read_msr() and friends look good to me.



