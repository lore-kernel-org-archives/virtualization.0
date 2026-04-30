Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B51379ED8
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578237; cv=fail; b=YW8ektYzWyyGYLg5bGIKHsAPMSRMYodSMGzqPg/zPdkzibgjmNyhixu28/6QpjGfi3YTZ+b9liN7fE9NVVbKj6/L9fkfrDezB9lNbAsAsT8jky90bu3Iab9i7ODGkTGjXqcsByuuvmGLGcRXlBrthNCghXOyO4F0NQNmdb1E/mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578237; c=relaxed/simple;
	bh=3iQJ+QwsgnxmZGz6HEsqA+HzgXK3oel6HFHXqOGiZ70=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X5JnfIxHFMqbG06wFx5yEjLxW0GBaPflXHOua3u/GNu5ZofAmCJuhngVt20C9dlVMs5hGX3UZLfIEcDmQ2D5BQofyYCVaXBU9bDAIyTCKV3BB3wIKRH+eNB4T2LmA6qMSZUVS6x3QkflpYaL6pav8amGy3hnWsWfAkA1QtCulGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TO16R3cH; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TO16R3cH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777578236; x=1809114236;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3iQJ+QwsgnxmZGz6HEsqA+HzgXK3oel6HFHXqOGiZ70=;
  b=TO16R3cH8A/xJGJeUR6rg1JBT3dQJUjnPE/F1hRb5RG6mkvxRAshYYTX
   EnVbSKmKEHm6VDcZAq8K4BHkIqEhCpDpCfAZU4KfuPIa5eWIDsehNly31
   7KfyCSeBkUdwC5kLd4X/jkQ59ZWdynntPTDkl1tWOQaSP6P2xXLNgRIYj
   sNgFcKUUPw6rcTgCvE392+vh3fylA3yESrDBeY7EXQpbPyOfX0AS3bE4N
   IK6Kj+OUrUKW+4FFB5F7nT3szehN5WFdj/jGRsuXE6vfOCLs8U5TmrveG
   YFRTla86MaEDKtZDcFNNefpSUouWdCNTXRF8kF3HGErerenx0L8VSXqmf
   w==;
X-CSE-ConnectionGUID: HlPx/EFdS4aq21Txh93Obw==
X-CSE-MsgGUID: 5pEoQzBoRjacO1L+eFbvyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="90006547"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="90006547"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 12:43:50 -0700
X-CSE-ConnectionGUID: eLsNDd+lQt62rAj6l2tUzQ==
X-CSE-MsgGUID: /8Es7rV1Tfil+Rjndl2TZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="233805207"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 12:43:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 12:43:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 12:43:49 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.23)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 12:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mni60y7XYU1poZth2Vf9VBbXS3Jc4vt5z4y029sa+Hlb0OrJOmaZCf/Bv2/EJG0orVRslqV0bmt71gjtoDTB34bUTE/h3JtGeGxOmYnunL8jD32hgm3JrIWvFT7iLXKc3xdoWTSNnarsyyRwthyC4VPpCKDK79YmM2eBTuT1Nei8l6Mj7R05W5ak23wIl1zjGzjv3tsM0yQX2suCCCHJcH4gcSt9XVQKK2IWlwzQqhLT/87yEQTY3Mg+JDlqI0OnNOnOmgMWnLHGdv6qtYfMoT1P0a6+krBuPmv6PrYTiPr0kg/S/7br+65NS+3a8H9XGhlzSp8Gt2qWdTexGepOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8zXK6MVQxFctuCZA/nVpfkeXAkowclcAzAZ3MHNezU=;
 b=MfiHQuEpdVqCoBmmGyGfBl+S2F5pr92+nv7YpN3I5kI18PXG00PVzLkOoZ6vH5GcgjI9e0qkMMFzG4bblFL7yaM4fVTItE8YFDv4JSefzQNOxtr5aX+jlwRvC3pCTT8ezSR6pHItYFd/zjmvO3c/QHHWJiRTp6z/Yi0HPSxysk02KxiUqYk/pF8iunydomGacciw/HawpHH2Km8fUpwZmNY+T0zIkafniR+t8jACHY0fGCneP2YjtSPY1qrUMHLp3NVEPJ8gkXrjHjiDievqQbc6Vk6hHMo3F7XqpvZ2JD41W6pejcUIroxYZ3uz2PbAjlPiBXKAraY80yocnzIpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3282.namprd11.prod.outlook.com (2603:10b6:208:6a::32)
 by IA4PR11MB8914.namprd11.prod.outlook.com (2603:10b6:208:56b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Thu, 30 Apr
 2026 19:43:40 +0000
Received: from BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19]) by BL0PR11MB3282.namprd11.prod.outlook.com
 ([fe80::5050:537c:f8b:6a19%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 19:43:40 +0000
Date: Thu, 30 Apr 2026 21:43:11 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
	Juergen Gross <jgross@suse.com>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH v2 3/8] x86/msr: Consolidate rdmsr_safe() implementations
Message-ID: <afOnbxNuGd58AGu9@wieczorr-mobl1.localdomain>
References: <20260429184517.7E078510@davehans-spike.ostc.intel.com>
 <20260429184522.BFBD67A7@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429184522.BFBD67A7@davehans-spike.ostc.intel.com>
X-ClientProxiedBy: DU2PR04CA0075.eurprd04.prod.outlook.com
 (2603:10a6:10:232::20) To BL0PR11MB3282.namprd11.prod.outlook.com
 (2603:10b6:208:6a::32)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3282:EE_|IA4PR11MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 132153ae-8ce8-487a-14a5-08dea6f0c74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: pjiDuzlgnJqo8mjkmxzs/otpE/HJDdtYomoP5jIQxSk1YI6EOzt5le3E5/ttD+leefulmX8J74fGGpJd7i+Lx8XqXMqdLIKkY4sIetll7A3M20ZK1y2acF06tXlgWEw41EH97dE1zoJmfWEmz3rE2ubYLWwJyeLmNObSgcexyPlDo+6YuYIokvrW2qAHObFMjqeAEj92zlxK6yEuxlmr0YdqfqErjTDkuOOegmk8kL8dlFXwQa+gBFHu5BVco/aRU0pB2b1FOo2z5Qx0OZ96gfgzGBYOJLtmIHXkzIXZxAXo4bkhcBLwCI8uXLTEU7jOqK+UVMgxtcr3Tg/ajOMq8NpJahBugGYjx4zoOYSxBUHOP7P0oO9xjhM7Mj8w2ziebm0XoZUgAgb0M93JaVe+IrOmKaOF+rUq7w7hYV+V9I8XQbo3Ulfae12YbZd9xGJeCaXzovDs952HJL6hSVxPVIADQkiEwEGqTIQ8Jx6WI+t0n2Fyb7iENi+oOmFotdjc+1Netaki1XPJ6plajrExqWmThCf/VycsnIKdWZ2Wo0FvDUHSFkJe9UIOCFLqdlEMFKUIAYhknf93aalu0zF3lSpsXHk0clzuzWDwQl1nq1K7N+q1Up/+mTiT+oXKnOxapVu0MzYpOj7hC5lrPT/ki5pQs/mOtFVmQFP6K3LwlC545r7FQlDD1nRgD74ebDXd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pfmbNZv+9YBNd8v4bbYx5i43pSFmoh4PaKtE59zLFb54yjyg/zh+CxA8p4?=
 =?iso-8859-1?Q?InQA3fJO2ZoQa2EfNTzbukhsoH8GXY+62jLYG5V+RSs7tyxIsfSR78mB8i?=
 =?iso-8859-1?Q?48BTImB2y1n4Wn8lZIapJxsJISr6pIby+ba+T54NjOqdzb6S4DUsOhk7li?=
 =?iso-8859-1?Q?b+y/fprC75YdA7JCLb9e1jOwRju/fVezSxSxLmCM+dEa+4oCtPoKtHQk7A?=
 =?iso-8859-1?Q?jbUCYUbUi5CidY7wgHiwlx6s3LawJcHPXFtRvPicC4WF4xKjCHRWzNai8P?=
 =?iso-8859-1?Q?xDwpQzDjnt9yHc1jqZKNiVznPRD/TQTZ2p+6kpWHX7Y373T+bmo6HxFj7O?=
 =?iso-8859-1?Q?RnWccgBoC58UW28GY7nuXyfwwt/S1rAzp2UoKGhh+31BVpFjsLuoTMWxBl?=
 =?iso-8859-1?Q?eE2BJHpGkwZ5ClpSWSPJlD06XCG7ey0OdRVq7r4J2UNgSccerKPL9VOQ68?=
 =?iso-8859-1?Q?fPWypCCKqt1dqnvbwHe9w2pMH+BVNDKQ9PijsmKjrmTksvmjI+avANX+ju?=
 =?iso-8859-1?Q?IEfoM9tVJF+/HBqceDPKvizz3fxquuTUB0pvlTOggSt+8kCVtSOF54LTV9?=
 =?iso-8859-1?Q?PFO2bBGHbE2AhiC33K9C0pW7/Gf9Hr1A8XiFI+bQTNpGLLLCkP39EcCGRa?=
 =?iso-8859-1?Q?X7g2X+DnkLIlC2GXGJ95wBM6Lv53hwUTATt6A4zZrH/Ie57PSbDLZaYcY0?=
 =?iso-8859-1?Q?8s0M2KW0ciDztfHJk0WUFnDi08QWO0Hx84Xdn/6qUILVUsNJB6XiSj4t5M?=
 =?iso-8859-1?Q?FXivK4CDc9ViogYL4ABE6GQi9Ie1Uk6dGUkaSExo+UfoTjReXLKbvE4GQb?=
 =?iso-8859-1?Q?RajbDfF9OlG3zncpCoxEZVKI2hm0fUy2qPyv8sLE7C8Q3mOBV3LYYJmzWj?=
 =?iso-8859-1?Q?9vlo3jEbyzWEMaiYZE7c4xl8n+ogDLokdZ8h7787CItklOaxqWqHmv7ZtH?=
 =?iso-8859-1?Q?0TlzJRlwm8e6Xx3bkZAxidghnKAEjzi2Jwxr11tJisPrGqYCRtIX+NA5JO?=
 =?iso-8859-1?Q?EnTU6cn3EkHPYL00Vk+nhbeHpWRR3IhDRKivNmWAsPlYYrblNB8HtTTxST?=
 =?iso-8859-1?Q?lxWr6PGvuq/0K8CKsbwsCMK7y1Dv06rX5jt1X7eNZRCV5NZepn+N2oTUla?=
 =?iso-8859-1?Q?bcjxO1cr/Mx53hV+gi86uYjSKeEgdZgQ6frG7bk5B5iqMCS/fEiqJaqXVf?=
 =?iso-8859-1?Q?a6SGB5lZRWeyGmML97st05zYRTn6+XCCHLDTN5AMlAeu7JB4MYhJQKuMa8?=
 =?iso-8859-1?Q?FHhz8VXv3YFGs9k4yUakEIb+7ZmLHqf3nZZ8/LLO0Eax2fSMl2Y2JPmDON?=
 =?iso-8859-1?Q?QNHRszNuFDY5SSiaj4bG6X3rYK5olje0jtR02tpdOZHtgBsEmoT9mXZqpq?=
 =?iso-8859-1?Q?PVkJ2LCl5vA+RwlFypMB9boDsAcaFhMyNSWM8sIv/KNx/V0Joa/0vDEzYP?=
 =?iso-8859-1?Q?b0pGWASHD+akJ2qwiNpBZ1OlxMjkg801yg5SA+ZSNduJ33g3aNLWuKGLxi?=
 =?iso-8859-1?Q?TlDONEETLZ+/vSiI8HdK/eS3aggtmMSw9H4imItICjBZh78l9Fz/bMAXju?=
 =?iso-8859-1?Q?jddLZjWHnFLEEocvK0hvaNAn+f3r+FTpY4ZrCq2uQkUePLlG1NR2A7CyG+?=
 =?iso-8859-1?Q?kVL6jKzMNJB43aiohhs5dAy2b0NVx1qQ+Rp3eAkg/7J3V/EJv/X+6bwdTU?=
 =?iso-8859-1?Q?KGwZjs4h44/2J7kDLNkMju1osV4FF27khNMBEckGrMVHbf/+ErKa1cEXV/?=
 =?iso-8859-1?Q?APvYIGY9R3RfVEpUa41OJc+235LPTG6tJO6bB/gYK91BCNFhCXKdZ2d9Jd?=
 =?iso-8859-1?Q?FOJThc477aiXiYoUZ+NbrcZgwHM6hKjzjhcVrmdZW9fFt19jUpAL?=
X-Exchange-RoutingPolicyChecked: FOd+l/pqNqj27VAZHnwcvmzGFYwOczkOOfcrNewRta7+ubU72QaIt1K/soqqkmEPDvoVQnJv+lZSvFfVrLftoo2m+t1lXKLnvhCLSQGbNA92XAw7JJNCMdSQWBGdXhQ++xN+x9RzfVSSJkanK1rVYhOWW8hF5kbH7KE+8vvyh9GbTA1xGaT1siepSbCwAHwUmrfxyJqCIKlW1CJB3/DNbf69CbE3R3FWi83/9/Gt/STaFu3h7lZmI6xO7wZ1Y0S/1x2+lz53NPt5m4U8RVWSQemU7TH+kCoN5nh/8oxHrf8MMIzZ8gZO7ICCdJBQ6GJoPWo4mJfmtdFvv07r/sjysA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 132153ae-8ce8-487a-14a5-08dea6f0c74e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 19:43:40.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmy3YPVNJCoCaCti4ryyQrXvlZmkQYbuoZ6EPqiBiAXk8T5ucoXazexLGgwBFSUIQY0xXBTQnx6AK409e3agjE9fLNOHgNoDJzBUDuOH4Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8914
X-OriginatorOrg: intel.com

On 2026-04-29 at 11:45:22 -0700, Dave Hansen wrote:
>
>From: Dave Hansen <dave.hansen@linux.intel.com>
>
>Move the existing "native" rdmsr_safe() implementation out to common
>code. Consolidate the two rdmsr_safe() implementations down to one
>by removing the paravirt.h version.
>
>Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>---
>
> b/arch/x86/include/asm/msr.h      |   20 ++++++++++----------
> b/arch/x86/include/asm/paravirt.h |   10 ----------
> 2 files changed, 10 insertions(+), 20 deletions(-)
>
>diff -puN arch/x86/include/asm/msr.h~rdmsr-dups-4 arch/x86/include/asm/msr.h
>--- a/arch/x86/include/asm/msr.h~rdmsr-dups-4	2026-04-01 14:32:56.670457110 -0700
>+++ b/arch/x86/include/asm/msr.h	2026-04-01 14:32:56.676457335 -0700
>@@ -237,6 +227,16 @@ do {								\
> 	(void)((high) = (u32)(__val >> 32));			\
> } while (0)
> 
>+/* rdmsr with exception handling */
>+#define rdmsr_safe(msr, low, high)				\
>+({								\
>+	u64 __val;						\
>+	int __err = paravirt_read_msr_safe((msr), &__val);		\

I guess this backslash could be aligned with other ones?

Other than that everything looks ok to me, boot tested it too with and without
PARAVIRT_XXL on v7.1-rc1 without issues. So for the whole patchset:

Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Acked-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

-- 
Kind regards
Maciej Wieczór-Retman
