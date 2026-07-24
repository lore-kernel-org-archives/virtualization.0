Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC263AD537
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923224; cv=fail; b=rY6666O9292G/0oVREFBLgYQXZD7qUrwESCplS5tzICPlccrsBc60+SvrZ44wHpD2pf1YdZ2nTVzMOia1cPxcsmjdeJTsC7q8n3ad27B0khUDENt24Cca1dGvHSVbVij0IkiYL6ewfLUuDNo5N7ojhtIgQZiHWsIEUAaibASZ1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923224; c=relaxed/simple;
	bh=9ZcGWKN6H18hO9DwNx13U/THQIeNRx84MAwuZ0tNO1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KIhmpj0mNy4vmTqjKO8Sxf4C9VdlyjfaB4AhGZlB2hgcKSIYK72v7h7xVuJtkXl+7PpgTImjFh+3v3IRfHC61Fu5x/FIKw6/GCqFgOFwCGAwQNDLV4sh8LN1zTpR4fVrZuieY8MD4V2JNKrgORwGIBEkMxQapEG3Hrur/zVfrN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MPSi2uwo; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MPSi2uwo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd1+BBNRGlkmxqL+U0PWMcCUGJIxwr/e9IIEuLEVWiCTS5oMKQd0Zff5mvTlKICa2QWV0mDzuQuMZM5KqGU34ermBsFRXxeoqXOcROLPcSsiZxiRYJVXNFlr9hTQD490yuQ8VL1W//3/XnpAMaXO2rPU5COY298Bih9WBRUttPZ0CuPx+5h3NqFZOgiSiIMZZRFcfTI6rg184erGx5+Mei9fI547P6CsJ1kLuVEbJjlsbp/TBEnzwU19yJNwX6n7ECzQSGC/JKrZ2IhCAfi6SczaRFAR0cVLwtenkPjB5x94ImR+1Nmr6d7pCK8s+s8yRKeCwWh5N2QjTtd7nwCSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9ke/mQSiFbJBpocLrx7TDcdamO1VJMrpLbxFVxRdKg=;
 b=pJnHbowWVFf8F+FlnTB1Y0OfkeEWtC89o/zSh5c685M18g9/+GVG00ayXdJav7dWNd0E+GTHoxHqHkU1EEh6oYbuqt1AZpcrs8AGcI730/TwxJ375+B0CrxMYpRVD0qxO5XxJ49S6JGVlgfz0N5PCQ4LHHbPxFZtYPUmYtanRTytQQXlGG1uHPCN4+I+RihWP+UDZTWEJ0OUvGyhiotKl7TbU06k1Z8aLzIkFfvqJmykMZQdE3/jd3sV8YEa1SA1f+m3Zdb37zK210jxuf4m35Q5kR/MLMvktHL4WW8ROe7pouugjGou8FEfpLJQAxycELGw7zKeQx7M6ciHVVePHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9ke/mQSiFbJBpocLrx7TDcdamO1VJMrpLbxFVxRdKg=;
 b=MPSi2uwoiDsoceb0wf2QtYwCeK7H+XfLbV0VePMxkaoM5fB86LquOzvUFkPINfv1ZrzA8SV1vrLynVyLat4M6IQentm2mHqK9AxfarZtrO167QMb3+Dy7Q0nntXoVMR9+6GXPOfwTxHJlBtj7b1dr99uVUKqo+VaQtiKHa5ybZHwuoB6LKXQe/Bl3Q7IdPLOyL1ZLhu15j5vt181dUW2SeQVAPO6zJ3PdXpc7SIdbox1Sx8h2wC6L/wh1kGoAZMkvqKb8WPq1EiwLRQNYxNQaqQwa30nKIfK4LF/EMCede3fjytN4CRd+ieA1H2rA4q5AhyF1dAMal8AFW9qVosfmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 20:00:14 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 20:00:14 +0000
Date: Fri, 24 Jul 2026 16:00:11 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, tglx@kernel.org, gregkh@linuxfoundation.org,
	pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
	huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
	hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
	frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
	christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v9 02/11] cpumask: Introduce cpu_preferred_mask
Message-ID: <amPES7GsB5sVCDjY@yury>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724140732.2683314-3-sshegde@linux.ibm.com>
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 948fb813-38ae-47a8-05aa-08dee9be2d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ogq+gFNGeIvao6mUZ4V60llhcuhFahH63yixR4NFNbZ2ugLlmBlK9sABMCcr27tzNX5BdLEsjb8GD3CCquBmc4gjusM/4UPQ830KQ0HSpYP0WbFzGsmGoU/FfyVMyMtXPuwyyvcGDieuWU9YpzeKMkSO4wsrDxu04gHUL7TZ984PU+zv4uUI8ocrQOWS5gmRMT8KFFI53M85r4N/It+9rb79BseXwP80vjyXwAVIpMROLkob65u9gRGQLnzK4hSm3jHL88XceQY4S+KOBsxxfQv/buVnTgJoCzN3Og9WrW1qQbAR5DTLjvzeE9/zQGonpDyTHbrZoTMKHsCtQ9PEOiwUNg/OnRjy9ULZTKvg6B6PHpttqxL0QvluYU3Z4QJCzBAUDSWDrlwfC8D9xi3oZX7VT3x5Xo9S1OhfXpQJIXmDV0TTN4+M7cp0PE34awuTtktqXLdly+QR1tsiBbUhB0V8Sn/1gFuSoovhu8eDLld8MfbCW8aYHmqfi0oIfxXhU5EKVn/jgwmejjotMCgaZIQhBr2r6qgB1lVMGQ+E5sHhBtFs3pGVHwIP//taAlpr3Zx5bqvKw855Q2KwFJ9JM1aobAeJAC7v+aAvfgu8bRYfBmr89yL29FXxPydWs/C0n1xz+vnvxdmtWEPAh1J8QZN/Jrpa0pATRg4OcvNXGB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXdJNGZqUzlvWEpnTk1GOVdYTlZ2bjNiN3RsZHA3VDBqem1HK2hiSktKTkVk?=
 =?utf-8?B?T0RCQmMvRDFQbFIzaEpSOFUrT1hJV0NCb1pqeU5oeXlZbDhkMHFrU0p1bDht?=
 =?utf-8?B?SVhWQlhhYVRqMnoyNERHWUZacUplenRYY2MrdDAzSVpsNFVDZ0U5WmdiZS9S?=
 =?utf-8?B?ZUNpTFp0MjZBdlJENmFTcStlM29PcCt5Wm8zdE5Oa1NkRHlFZ1BMakpIZFc5?=
 =?utf-8?B?K2lmMDc5dlZ3RGN2ZXMzT25oaWZmOVZyb2dVeDFXc1JpUXljQ2tKSlNtTWN2?=
 =?utf-8?B?ek5tTWJhVTFMUHQ5OHZaWndFOHhrbTQzSXBlSkI1NVA4NDhOZUVXQVBlaElv?=
 =?utf-8?B?WVdnNzdDdE00d3ZnRXJ6a1NWM2R2RjRjWEVXRURJMFNpbFZ1V3BNZjFTVE42?=
 =?utf-8?B?ZytHTlRWREFtb1dJNlp0ZFhCdkJqdzNaN1U5Q3VMbjZTa2tFZExRS0NCQ0JG?=
 =?utf-8?B?bjBxRG1VNVlrdHJlSWcyeERyU3ZlNHN5V0NZWEZUSnh4SDhDbGFyRGxzMStX?=
 =?utf-8?B?QUlJMVN0WXNwYXpmYURYcE1rV29oSnpLaDZXQk1sTUFJejN3S2dTZCtkUHNK?=
 =?utf-8?B?WnJ6dmx3cktkOFFRK05DVVdwOWI2UWtWdHlmSjRWVkM4bDdVNENEL1YxMXoy?=
 =?utf-8?B?WDdxeWtEVEF5SHZxSVBlbDRJNUtDelRQSEVVQzBiamJsQkZwNnBNUG0zM2Zp?=
 =?utf-8?B?RW1aT2hWYW1nTlNVYVZtYW5aSXlabngxb3c0MFBvbldxeklTRW9CbWJ1aTRj?=
 =?utf-8?B?N2I5UkZaVWVrcm9jVWNIRVJXL3RxRDh2REVlSDFmcE9DQnFhSzF3WGRWdWlk?=
 =?utf-8?B?Uyt0N0oxdEc2eEdRK0FyY0ZyNzV3VzVnSUJRa1VCOEJPZldYS1QwUkNIT2FS?=
 =?utf-8?B?VWNiaGRBUWVUTXdSQk5KZFppK3Z2WDlzUDhycEpmRUxPM3l3M3RuT3Vid1V1?=
 =?utf-8?B?TDZFUEhxL1hIcy9aY0pIdnFYS1NITWZURUxOTXZtOTJ4cERPWDM1STJZcXR6?=
 =?utf-8?B?dzBCcDBqQXpQVFlRRDlLVHYxL3VsTlFQRHQ1eTZpN1p5N1FHcUxpOXZTNnZN?=
 =?utf-8?B?dGxKaGlXYXpTU01MRUxiUG4xTzdqOGhGWnRnSHQrODFFUUNyR2tyZXlCSXAy?=
 =?utf-8?B?d3NPNmlGeWpqSnhmczVVNWJRSmF3V2tCN2hoMXlQbVQ0Tml6enFSbDlyQnMw?=
 =?utf-8?B?YzdDNnlSY1dXNytGbXcwWEhwOE95c2NFY3RsbmJYK1ZBVWRQK1RSZVRTN004?=
 =?utf-8?B?S01zTVIwNlFOOFJrOSs2MEZtZ3pSejlyamE5N3Z5Yi85ZjFsMExiL2Z6YlRF?=
 =?utf-8?B?aGJrY2lPbE80bU1lMDdRQ00vNVVTVDNjV0s4RkpQY290QytXMFBwR2dHc2FG?=
 =?utf-8?B?UjNSRllDZzJVQUtWTVhHWFFZcjJuKy9jdm9TdEJDLzQ3VkxvYWdRcnJCR3F1?=
 =?utf-8?B?UzZTR0FDV1A2ckExUXBZWUdlYUQwQzRFcERTMDBDQnVTL0NxblFyVXlob01t?=
 =?utf-8?B?UFVqTDZBQko0Tmx2R2s0UFdYRjhZVUhHeUI0WW4vbDcxSmxLN0MyZkZZOGZ2?=
 =?utf-8?B?NGJ0QktlNGFaQ2tDY1hvRWl4ZTF4SkVHYm5nNFpIdXZCQVA3UXU4S2hGbWFz?=
 =?utf-8?B?NkF1UFVhelJLd2JESCtXVTJNRFAxTEVmd2liT0xYSkRnc0xZekZFRFRZVDBR?=
 =?utf-8?B?L2Uvcng0OVRkRyt4Y0JPV1lJRzE2OXA2MXBiSFdZMkVJaXpudFM3MUp3QXVu?=
 =?utf-8?B?Rk1FZFJjV3I4QlpleEovTG5lZUJYZzZDN3ZLazJ2VnZsbWRBazROc1dnUllw?=
 =?utf-8?B?cmpRUFc2RDBiTW00eWNwMTZzcVRjWXlUbklVZjk1TGZtVG1EOTUvcTJ1cXFo?=
 =?utf-8?B?N0hFZCtkN3JUTi9MSXh6M29VYUFNWDFNd3RjeUpuMjVpVkVUQU53ajhQQ1hn?=
 =?utf-8?B?WHcrSmI4eDk0akptSUsyNUI0NVhwb0VUaWRWb3lHd3NhS3RrK3ZsaGZXZU9Q?=
 =?utf-8?B?ZGh3blpXME92NlpVZnVvVW1PRUcwc0pQM2kzeVp5M1VGWENmZXE4YTRibVdJ?=
 =?utf-8?B?a0dkWFgrNzhCMVR3MFp4eUFlYVYrcEkxWUw4eTd4WFRpdmhRbjhsUGk4eXF5?=
 =?utf-8?B?UVRYMmFWNTNyTE9FQ1hTVkpOcXc5NkI1N20zYWNNUmE2S1BmY1MybWsvQlVI?=
 =?utf-8?B?aE13TGp0WEFEWnNKNzlocjdKcDBpRkdFc1FoOFRGRE4xeG5kWkV6cTJ6RXJM?=
 =?utf-8?B?cFNjTm1PSzVJVXFzdWJHZVpXK1FqQm5mdWROOHdUdnZFcVNVMk1qSnRUaW00?=
 =?utf-8?B?N21ORi9oVjY2YjRRTUwyWXZwb01CUVRzUGFMMmM5dmduVVlKa2E1Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948fb813-38ae-47a8-05aa-08dee9be2d31
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 20:00:14.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+wAtsuWiKrCLgmhF7Myv/r+ClKD2yDsOJ+0IoljlAbZITt+UswtP5/g9cVi3wJjrojgJ7rM5mAVrGZ1JOC5yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679

On Fri, Jul 24, 2026 at 07:37:23PM +0530, Shrikanth Hegde wrote:
> Provide cpu_preferred_mask infrastructure. Define get/set macros
> which could be used to get/set CPU state as preferred.
> 
> PREFERRED_CPU config will be selected by the driver which handles
> steal time values. It is going to set/clear preferred CPU state.
> This driver will be called steal_governor and it is introduced in
> subsequent patches. It periodically samples the steal time and
> decides on preferred CPU state.
> 
> A CPU is set to preferred when it becomes active. Later it may be
> marked as non-preferred depending on steal time values with
> steal_governor being enabled.
> 
> Always maintain design construct of preferred is subset of active.
> i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible
> 
> With PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
> method returns the active state in that case.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  include/linux/cpumask.h | 24 ++++++++++++++++++++++++
>  kernel/Kconfig.preempt  |  4 ++++
>  kernel/cpu.c            |  6 ++++++
>  kernel/sched/core.c     |  5 +++++
>  4 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index d3cda0544954..34d08a3d80e1 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -122,12 +122,20 @@ extern struct cpumask __cpu_enabled_mask;
>  extern struct cpumask __cpu_present_mask;
>  extern struct cpumask __cpu_active_mask;
>  extern struct cpumask __cpu_dying_mask;
> +
> +#ifdef CONFIG_PREFERRED_CPU
> +extern struct cpumask __cpu_preferred_mask;
> +#else
> +#define __cpu_preferred_mask __cpu_active_mask
> +#endif
> +
>  #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
>  #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
>  #define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
>  #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
>  #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
>  #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
> +#define cpu_preferred_mask ((const struct cpumask *)&__cpu_preferred_mask)
>  
>  extern atomic_t __num_online_cpus;
>  extern unsigned int __num_possible_cpus;
> @@ -1164,6 +1172,12 @@ void init_cpu_possible(const struct cpumask *src);
>  #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
>  #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))
>  
> +#ifdef CONFIG_PREFERRED_CPU
> +#define set_cpu_preferred(cpu, preferred) assign_cpu((cpu), &__cpu_preferred_mask, (preferred))
> +#else
> +#define set_cpu_preferred(cpu, preferred) do { } while (0)
> +#endif
> +
>  void set_cpu_online(unsigned int cpu, bool online);
>  void set_cpu_possible(unsigned int cpu, bool possible);
>  
> @@ -1258,6 +1272,11 @@ static __always_inline bool cpu_dying(unsigned int cpu)
>  	return cpumask_test_cpu(cpu, cpu_dying_mask);
>  }
>  
> +static __always_inline bool cpu_preferred(unsigned int cpu)
> +{
> +	return cpumask_test_cpu(cpu, cpu_preferred_mask);
> +}
> +
>  #else
>  
>  #define num_online_cpus()	1U
> @@ -1296,6 +1315,11 @@ static __always_inline bool cpu_dying(unsigned int cpu)
>  	return false;
>  }
>  
> +static __always_inline bool cpu_preferred(unsigned int cpu)
> +{
> +	return cpu == 0;
> +}
> +
>  #endif /* NR_CPUS > 1 */
>  
>  #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 88c594c6d7fc..de789b274ba3 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -192,3 +192,7 @@ config SCHED_CLASS_EXT
>  	  For more information:
>  	    Documentation/scheduler/sched-ext.rst
>  	    https://github.com/sched-ext/scx
> +
> +config PREFERRED_CPU
> +	bool
> +	depends on SMP && PARAVIRT
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index b3c8553d7bd6..376d297a6292 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -3103,6 +3103,11 @@ EXPORT_SYMBOL(__cpu_dying_mask);
>  atomic_t __num_online_cpus __read_mostly;
>  EXPORT_SYMBOL(__num_online_cpus);
>  
> +#ifdef CONFIG_PREFERRED_CPU
> +struct cpumask __cpu_preferred_mask __read_mostly;
> +EXPORT_SYMBOL_GPL(__cpu_preferred_mask);
> +#endif
> +
>  void init_cpu_present(const struct cpumask *src)
>  {
>  	cpumask_copy(&__cpu_present_mask, src);
> @@ -3160,6 +3165,7 @@ void __init boot_cpu_init(void)
>  	/* Mark the boot cpu "present", "online" etc for SMP and UP case */
>  	set_cpu_online(cpu, true);
>  	set_cpu_active(cpu, true);
> +	set_cpu_preferred(cpu, true);
>  	set_cpu_present(cpu, true);
>  	set_cpu_possible(cpu, true);
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2e7cde033a31..a45f7c308329 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8690,6 +8690,9 @@ int sched_cpu_activate(unsigned int cpu)
>  	 */
>  	sched_set_rq_online(rq, cpu);
>  
> +	/* preferred is subset of active and follows its state */
> +	set_cpu_preferred(cpu, true);
> +
>  	return 0;
>  }
>  
> @@ -8703,6 +8706,8 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	if (ret)
>  		return ret;
>  
> +	set_cpu_preferred(cpu, false);
> +

Is it possible that this CPU would be the last preferred CPU in the
system? If so, you'll make the preferred mask empty.

In v9 you disabled integrity check while the steal time is withing the
threshold, so this condition may stay undetected quite a long.

Can you add another integrity check here? If you're going to remove
the last preferred CPU, you need to force-enable some alternative.
Something like:

        if (cpumask_nth(1, cpu_preferred_mask) >= nr_cpu_ids) {
                new_cpu = cpumask_any_andnot_but(cpu_active_mask, cpu_preferred_mask, cpu);
                if (!WARN_ON(new_cpu >= nr_cpu_ids))
                        set_cpu_preferred(new_cpu);
        }

        set_cpu_preferred(cpu, false);
                
>  	/*
>  	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
>  	 * load balancing when not active
> -- 
> 2.47.3
