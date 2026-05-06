Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A12D7DD4
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778035409; cv=fail; b=K0SndKQMMTByA+PsmydWQLJNZb8l/WKTm7iNHyCgeQEcTbVXhMymnbnACRWxuNp6NlvfVpHVM3EjyWUAuAoo3W1MeiJEIWDozu71PdlLVaa3bognlOdPU61PI1c/bQdwON5lU1IzZd7y1mNdtdJB4NEQWn3nsrXMx1uGVHpQgY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778035409; c=relaxed/simple;
	bh=bp8CgJvI/9SgYmEfpHgg5xq1Me2r7ODYX0I2+sV7QT0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kRtuqYxtHP4q5G/5grbT2ca/yBQXaGNBB4qT9+oinajpjNVXrkbJO78ceLT1XKFD5wgM0C+5O8P5CMyV8GyNBIsOfK/h2irB6AdAb4b4OEYFrPXKhjVqYFispVFXdJt9+Mv2x1c2RVtj8H6Gt7i3erzN+JCt6tVduFGnTTlGnPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZQ5z1gu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZQ5z1gu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778035408; x=1809571408;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=bp8CgJvI/9SgYmEfpHgg5xq1Me2r7ODYX0I2+sV7QT0=;
  b=KZQ5z1guiR7lLn1j7dTokR26NTCb1Byj7+txN8hXD1OsI9qiiDQ8eldB
   vo6ZBf42W/e830M+rF4Xb8bET2rnzbfOcqYNIzrXFJn9ozgOj1q9F0fji
   sfLcWgNAgKAMMoBmT2zO9WUP5tELOlF3hnRb2un9r/Bry3304JJ1qNRdg
   x24FfEBiPvLQ28vxLNwctcDIcSyKWsTtv5VbRHFzInOJ4iDIviEm+w0yg
   y9p0GaPljZx5etmh+BxAQeG1mcPmywxW9WBkGSeypeU82D5pSkijALpnE
   Qay9zis60wCHms6s2gN/yeNcDmwEwchLtjcBQyieLDFAJwEC1XjByz5JD
   Q==;
X-CSE-ConnectionGUID: WKlWrXViTECf+ALCFGtgTg==
X-CSE-MsgGUID: xb6HK5BUTo2uVkD8dACdsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78632736"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="78632736"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 19:43:28 -0700
X-CSE-ConnectionGUID: Xd0v5Ox4TPGgmwpBAUbACQ==
X-CSE-MsgGUID: I9fxZYOaSDCP9928HAEfhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="259353489"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 19:43:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 19:43:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 19:43:26 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 19:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7Otgx69UqFZbJdho/Jdxy+1mqhFRkgayq9INJNCdIBuhnUlk5TVxrAwQX3qmYtrMoBJBuZvusT3XzhTHQHH75IKaQXhGalihYV+WHBMJEfMNy9aT3WoWjavZG0VPxxxn7yQ6KALRdO7rk+dlQUtXBP7nJ2QzU1u7X1HXVrRyktRvCQ3wcaZu9WBJ2DlQNPqpcs9mAxx/KZe8M6IWFIMnlYloHc5GlPx4DK//t0l8qiatVlb6mjf/luz/ugpandk73c7i0OUQLZjKlMJ3b1dH1mUHHjd7MdlQilepe8oEtWft4toukM++zRlk4IwZhPJly8awDFBDsS55JwghqzsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I2QugXF0c4CR5RlMGdSUmqtcRem4s+ZuTvsfL+L2EY=;
 b=UCFIW4aAS8IU80MWC62IqEghd7g5CT9t1749Iuy4mX2tiszcnqb1I12NutU41dM6zxEqD3Qc19lMov0pZNyyDsgRIK4Lpw0B7I34LVkFP1iujm76D251qDFdusrM6v4N+189ZIb+PS5UGLscLpmY1cp0Ey3q0yxeop15bjGitQVT2KSCuFTUa6TXJSdv1GB7kfwqaOHy0z5lnHC5aYT8EzCRcnvIbaCcN4qTqFLOiwQ8dyErEulTxCuCqL9wUu6wyGIaXBsRxvXPZmh6V/FSfLt//tDDb7tVacHJ+jza7fz3egWgRYhHRWjEoyCRPM9W6iqJIxLEVOacitIhZg3hQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 02:43:24 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9870.016; Wed, 6 May 2026
 02:43:24 +0000
Date: Wed, 6 May 2026 10:03:26 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
	Juergen Gross <jgross@suse.com>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH v2 2/8] x86/msr: Consolidate rdmsr() definitions
Message-ID: <afqhbl9pKKwsVjOy@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184521.7AADEE4C@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260429184521.7AADEE4C@davehans-spike.ostc.intel.com>
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DM6PR11MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: 369e63f4-eaa6-47b7-108a-08deab193e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ypHnf4UIWdgMkirdhNZMQJghIVBIKa1qZPNOGYMwJ9/QoZkhV2ctCERqBWc0MuMe3ekh2GatZPerSdOK5XOKut7pr/GZnzX6ToFlNHYk7dqmQLSwAXcuCkw2y+aAk77SBg5OlxFRfgl2EXSjw5dQsj5awWiY+cVJ83QbAZSWXSaXmt9VeWxuK/SXUbw9eOiXdptF6+4sOwYI2abHjvXfHG3WNVWwvFBrtb7Sa4vDr7j+jJvtsn++IV3UgFnxA+2+gOFxGJQF7oWuUEPeq2CSt/+Jt1MC5RNVSRZDZNcPttzreS4G2GuyN1ZFNuUtoXpmRhXPbTSQ1/i6NzeYAje+YXZU9EjOx5gtb1X7GaF1sEGqqLbXZ39Ao1+hm5vx3XUZQUM4u8bgM1a2osOZJjZgF5dsbUfpPIHEwnv59UBux89/ho7rz5OykWpBAQtCdXsShAmUhmTreLMI9ThHPezy/a/hcYDilgExXHzPXu5b6qk/rC003B5tPhxhRrnwnJ6fLULWf3f03kgEM5kYo+aunz7oHJ4z3UmRep+Uz2Sj+n1HIQp7WygR1GwLMBwf3IPB31wCbCutdDL+/EqhjllUoHIDW0ybAKyGM0fdpXMz8DIr0mLqszX275nOzJ/McTUTQhFAyAeAaLEj03JqbWda3tFLUMfGaxoV54/WhxNLkhpuWPVtAnGp1YfUQEXv7c8T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bqAc0OYyXmtoAlCXBNU7fuoQDcov3ucIMyFuroB8lsWvIo6e1S6cZaLvfkSx?=
 =?us-ascii?Q?tbZrtStyINl/y8Q0lscT5bL0GxkZ93PhEfE9RUsRoh1WsK1ERYsb6LsIMkUM?=
 =?us-ascii?Q?/h5FGjlGxKMDMjpE4y+c8RAy92xRsQj3lr3sJ/+srS2ff9YGgHqXwymkDENB?=
 =?us-ascii?Q?fVgsEIwIfH3qF4QdIfPy8d8j9LKx1lOVn3PGwPeyx+ssTTA1vCI/QvFYWiPt?=
 =?us-ascii?Q?nc2ARkd9650/xKQ+a5L8madnLqE19zQ2BKmp4c5tUW8451pjVAeheC9ia8zl?=
 =?us-ascii?Q?s+FKE+fAU0itvDybHo+9kA6TuOB83PsmYawm/KYZCoK1R4exAR/z++/PfJFE?=
 =?us-ascii?Q?V36eliJr3xrmB3KpL8LAmxRXfcxzkt8FHmOdIcVibymj0+qUHyaH+Pw2esgx?=
 =?us-ascii?Q?7gSfjVtk1mfR8MkuVTkJfUt4vNbbccZfhWVgFeTdvKTrWeRT+4W3zUGBmyxY?=
 =?us-ascii?Q?iIs0FGBJNsjaMxl5aUWgu9H8b+bo+YwjT+h59Ci+Djyhxsx2E+PWra9hXGcF?=
 =?us-ascii?Q?EjP6sZT/aHy+5fBjGkXYP0ytCMT2eGuV5usvD/xWRqgW8d/JcWGd7W6gcLuX?=
 =?us-ascii?Q?eDUraG488hzwvAvdFWKF2K7IGvpz7c3soC+QbzIb89y5M38dnAIHq2qIOi8/?=
 =?us-ascii?Q?VJTcAg0TEai64jgxJBNKXKoqTOv+CxcbP1Ba/TkgpkEXcelABWlzsdVHhwIQ?=
 =?us-ascii?Q?qyb6KjUBnMZcJcLP1FgzDPAg3bJ7/2CAoZm9JzKDchYMBBa996gqvUQ4M0dj?=
 =?us-ascii?Q?LztrkmPDpBXLd5TE4Q8a9ANLhxO5i8CiWbna/90wn505kND54ODnxZMGWaAL?=
 =?us-ascii?Q?xXanltcuNOjfhrYYX+yxiYrOlW1ZUzohjbkx/SlLXGhOrQYk04AcCSkWHCVE?=
 =?us-ascii?Q?IAV1Yw2FZDyjOQiqOwfKPj4/nKgQWOVRvQtxXd4CpJ0Z8ISOIuvW74P5ky2D?=
 =?us-ascii?Q?2Y9//gO51wczO7ccGiYcVeXYBDaTcsA2JDoPcOe7+G/mr9qAMdkBDzsQgi00?=
 =?us-ascii?Q?5At5NqmzI9m5t25nnP+WqWCxWP6vApWm893AwVnDpb4MF2EGhd1m9FdZ2Rqh?=
 =?us-ascii?Q?vFYwScxYffgvh9ne6dc1gnyCAwd+N7JIwYGpazEi2n92Mw960w00U61mX8ur?=
 =?us-ascii?Q?lb46b36FtQVb30jyCuozIIhVFE3SavC2Z1GWSJ6Iw1MB3V40hbfvjjdRcQQ+?=
 =?us-ascii?Q?Z8/yxV7cX0n8OBYvwTAzK0/Ivq5QZGtKlnrPz4HuJCyjX1Fs5LVWI63krD9H?=
 =?us-ascii?Q?9q3yt0Q99acPaYunmhJ/KdFKXFITwj10XA8dKaVjDBfUKWU8B7Qbeojxkh7o?=
 =?us-ascii?Q?+urqW1h5EROMqQ/UGxxC8Uy8NwpmvNolxLu2zZrtFKrTeAsnYmoTcxb6Wx/p?=
 =?us-ascii?Q?UX2cO4wZiOOuisZw38sKb2LVi1LVlqlsGIom4uAoTbFIuUZolRFQwLp0HZDt?=
 =?us-ascii?Q?hNeTQOYYPPJBxKg695cCOK2gCvKu1eNVaKaKzbwDL8qm9U/jJsopEnpq3I2a?=
 =?us-ascii?Q?3VbcYPYmKajptCOjjaS00cGwRQ5AL78KvKvz9FrhSBfFqPk8T1VGaD0v7UP5?=
 =?us-ascii?Q?s+HKumaMGte8hEkNBLtBI8Ap5J6LEGBxzeOEL4nZKzvOVDipHHsn50P9fuFu?=
 =?us-ascii?Q?0clKD4qDaXEaIFskiyPiNR+Gkl7aTSAlTqOg/xyujr6++dDHcBUHiNmTbYWh?=
 =?us-ascii?Q?5Pau3qcevBMRVXTC2AjN8+5tcbUkR28hoZHTMPjMsN+Eu4Ol4BnijztiO2rH?=
 =?us-ascii?Q?oK9Ypz27qw=3D=3D?=
X-Exchange-RoutingPolicyChecked: iHlqkTS9YqO7JDM5FgaKckvqqcIzisdAKY7XlO2HWhOEPIqjF/iSeXWs1HzhzLrfqSKtH+DGIFGzoxe7a/Zp0OTywGA+4w77PWoFNqQ0mUCfrpstszr9NUDsiz2y7fjbsfWL8pvPkD3fTUuqR5A5xPj6JSiFYXuvGEFdapeXXc251NdrAmou2aabijZm3aXi4Frzgd8JH8PxEa6QPelS1czfZuQfqO8ALX2yeco00R99pxPE5MjLR+958k6E8KdwOB0UZ/PvgrqeDx0sW3JrY64T+x0TX0MQP4kvrSPXBAdDpTd4uVCvmW8d49D2dJqJjs3uT/kM4EIGLNbfGPB3Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 369e63f4-eaa6-47b7-108a-08deab193e56
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 02:43:24.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uq3Q4R03txTOJM1iTJpSphMHPqnYi62ztyJRs8rv0M5znA4ULul8mdnd4Qmu+LnWKNXzR/Ir0Wi6sfrXuzC3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
X-OriginatorOrg: intel.com

On Wed, Apr 29, 2026 at 11:45:21AM -0700, Dave Hansen wrote:
> +/*
> + * Common paravirt and native helpers:
> + */
> +#define rdmsr(msr, low, high)					\
> +do {								\
> +	u64 __val = paravirt_read_msr((msr));			\
> +	(void)((low) = (u32)__val);				\
> +	(void)((high) = (u32)(__val >> 32));			\
> +} while (0)
Rather than direct all (paravirt and native) invocations of rdmsr() to
paravirt_*(), does it make sense to first introduce the common version of
helpers and direct the common version of helpers to paravirt_* or native_*?
So, we can have

+/*
+ * Common paravirt and native helpers:
+ */
+#define rdmsr(msr, low, high)                                  \
+do {                                                           \
+       u64 __val = common_read_msr((msr));                     \
+       (void)((low) = (u32)__val);                             \
+       (void)((high) = (u32)(__val >> 32));                    \
+} while (0)


with below changes in patch 1.

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 9c2ea29e12a9..7ba5bc921526 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -171,8 +171,19 @@ static inline u64 native_read_pmc(int counter)

 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
+#define common_read_msr        paravirt_read_msr
+#define common_read_msr_safe   paravirt_read_msr_safe
+#define common_write_msr       paravirt_write_msr
+#define common_write_msr_safe  paravirt_write_msr_safe
 #else
 #include <linux/errno.h>
+
+/* Short-circuit the paravirt MSR infrastructure when it is disabled: */
+#define common_read_msr        native_read_msr
+#define common_read_msr_safe   native_read_msr_safe
+#define common_write_msr       native_write_msr
+#define common_write_msr_safe  native_write_msr_safe
+

 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
@@ -181,35 +192,35 @@ static inline u64 native_read_pmc(int counter)

 #define rdmsr(msr, low, high)                                  \
 do {                                                           \
-       u64 __val = native_read_msr((msr));                     \
+       u64 __val = common_read_msr((msr));                     \
        (void)((low) = (u32)__val);                             \
        (void)((high) = (u32)(__val >> 32));                    \
 } while (0)

 static inline void wrmsr(u32 msr, u32 low, u32 high)
 {
-       native_write_msr(msr, (u64)high << 32 | low);
+       common_write_msr(msr, (u64)high << 32 | low);
 }

 #define rdmsrq(msr, val)                       \
-       ((val) = native_read_msr((msr)))
+       ((val) = common_read_msr((msr)))

 static inline void wrmsrq(u32 msr, u64 val)
 {
-       native_write_msr(msr, val);
+       common_write_msr(msr, val);
 }

 /* wrmsr with exception handling */
 static inline int wrmsrq_safe(u32 msr, u64 val)
 {
-       return native_write_msr_safe(msr, val);
+       return common_write_msr_safe(msr, val);
 }

 /* rdmsr with exception handling */
 #define rdmsr_safe(msr, low, high)                             \
 ({                                                             \
        u64 __val;                                              \
-       int __err = native_read_msr_safe((msr), &__val);        \
+       int __err = common_read_msr_safe((msr), &__val);                \
        (*low) = (u32)__val;                                    \
        (*high) = (u32)(__val >> 32);                           \
        __err;                                                  \
@@ -217,7 +228,7 @@ static inline int wrmsrq_safe(u32 msr, u64 val)

 static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
-       return native_read_msr_safe(msr, p);
+       return common_read_msr_safe(msr, p);
 }

 static __always_inline u64 rdpmc(int counter)


