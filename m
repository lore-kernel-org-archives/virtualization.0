Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B43C585B
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927117; cv=fail; b=qd8vGgN+T7piTQvBbighbUBr6iW//kocO30RwYFhRylWO8FfefLRBLMU2ZJHvIC3tjGRGAvgW2EnJCwv+qhUwkDmx4q05TN4keftNacr/G8Wd5WOeFgDEugwfIHpG1bXQm9jsSaM4kmY+WzpQm1bmgOqyP1cJiCctwvI0OXDe+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927117; c=relaxed/simple;
	bh=xmiBpVxOypuDv61O9yoFdOapRg5MdQp+rLhVHdWgSV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QyDmbQWOBW0c9UuIZ+9xXqYDYC/DMmxS0juRfTO9GjEghC+RE1KmsHDCf0KKw1nCxtZgt0WHIt32pyWjsvX0qP9yH01Hvy4K9OZLfXYnKp1G8+6Y+jk5GYqwwBPmZ74QWAhMnXJLovcDWI9rOT8NONAtwyy/WBNeZ3W91HrgxyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVNSMj1A reason="signature verification failed"; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVNSMj1A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ay3Rvb1o4K7bRFYr2JTpTvxgse/JaaE8yWL62dzOJXDG1Ej4XAPuMMGLmI7siR84SKfnX9Fd3fxz8hxlBH5evL91FFdRrSMT4h+t0zCZHQjXBq9MmgggiUXlf5pFfIR32kWlkq/4gbMnk5/HNQRGMp2WOsr4HeHnqPj+wFptSxJvnpLhDQR+o6v8diV73HCp8zSHnjI3WK9THOhet2vz2MA481PKDhFIg9vACC1f6xtUglqrT87WS+XrAzci7NRNo+Ic9RplKYL0Po+iQwSfCn/MyBACcOEf8yf/XW3koJ7DLfy4DYE7ZDygkNWXkWqN46s0znDjUhrRcNj7nfv4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/VhMBtFc5veIGoo8YR4fgT7i9ixEiXqFWyen26HB7c=;
 b=CMZDqJj6Bw8d+dltFVj4GfvMMT8+w1zZsJwgZiVYzMbRUPurqK3hdVxtQMc9Qzzm9qj7ZlMnEMOYPxuCCMOaZ+jh2yzvFgCFcKx/3L3COIpS3cplpnFhFgGjF99CkDqPZz6llUm7s/PmobZ7vMWjrORH1mQ+Pcd+mMVmsyLWZAMqUpQw3kyU1sS5UjZvR+LurV7li7KBHQ1l+hSgemW1K/l2VlYfT0tuLVipLOfufon/9YORa4LqVosg5KepCqo2VJKIC61o679GM9YPfqusa770lRnh+i6odMqQwl4v/O3lUS8O9JWwoPWnu13/CIi3FUswTqd/NXA4Qy+JDo4pcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/VhMBtFc5veIGoo8YR4fgT7i9ixEiXqFWyen26HB7c=;
 b=RVNSMj1AxugGg0dqgkNKaELlHl6OIqBGD9TL8bSVI5/RBoa7VuQyutvJZz7hh86CUJHEdatFS+n5CXrsamHyREdRtAs5wKChXqxia3k2tkk5fxnqZEVxib2E3oRFO+3n9jnvryxhH8nFqDDrIAnIemrTqVut2nu0oL5o1ZA5qrf5AECS5aXGMbrh+uX7JHr87hpfSp2rfoPrFwhgh7AHcV7EbRHd/Qdx2kDSOUvulHTOogj8rBU2msWlyLcFbjMdqPJPpDvRUEdsgCJ9PSTVgyK/yGaAw+EEQKBwiGQI66pQ3l6GNVv1Zjb9Pxievtx5laajFyrKF8P/EdH/j72Vkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 21:05:10 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 21:05:10 +0000
Date: Fri, 24 Jul 2026 17:05:07 -0400
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
Subject: Re: [PATCH v9 10/11] virt/steal_governor: Implement steal_governor
 policy loop
Message-ID: <amPTg78qsOw4WpqB@yury>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-11-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724140732.2683314-11-sshegde@linux.ibm.com>
X-ClientProxiedBy: SJ0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::32) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: b002bfca-9287-4d72-dd9e-08dee9c73f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|4143699003|10067099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	taOk7V5QsI1Vq1T5KdH+0gdSV6RyPFh5D1TjpvfT9JSV1Uat5dZJkLOw2eCECwkgmSL6qD8zOfIpekTom4vBfRVbNmwVVKM5RchajgEw2Yaw0KTkxSmrOSFnHD83ahQkHdaW50SE3kiwIn8LTBkjvvPKfT9pCu2SWED13lx7hCZEFDxETrbSAkVZEoSIQykr/gT+MEil6NKv5vkUzEPTfeWOzzqbGXZT5Uz7QuTq004EbBrH1qtinyrGt7V5UowuApQZ384wlmuqfm1EkD4Iev8xSmsg6RY1hJWGkaknVkfj1ch933hb+eKwIg+z6fWwHrwM2rdDRazFgV9QfoWHgkkGz4qSXyZF2WLnkofNckUVhhhoQRkvocDoYU1BsSuWy8b4ynaabG0tF8L+Mx0SSzgr17agvKhre7UTRz58n/R/wStpdrovX2JzohilFn21YblB/NIH3F59e1sS+g5yGDzQhoS4v+M4yeJLZAfWF6j4PiRGfYwjvDzZnLGf49DglhO0G+9wvsNrWmHy6/tMsV4l4bHICXRLny5e4QTZd6xmZskf9t4QpxKmKlhIm0WMya7Smfs7LMd/lFtsWaDs02mBeaPXtqR5TED6Z/6ARMLSPB3rsRmawc+bjVXBpC5+IgxGUw3c1TpnHlkRQd6JnuhB5XSWFhjt7jQ2jxU30IM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?a9rbo/n/n6An3G+YZw/0ybTPf+D8xbQdF5RzHhzmjfb9F4F0nNq1vJFC/v?=
 =?iso-8859-1?Q?6SlkPRWRktf/i3ESFmpjF1zjSCtORB2vU4e/BEuVLnB8A9GtB2sjxbDxJE?=
 =?iso-8859-1?Q?gulFmN3yrgjt07gvXK41XQ0yCYhBQaX+0T9bzcGNqCMxUBDIG2WfuGQnLv?=
 =?iso-8859-1?Q?4rwIR8BLblEdry+T0m/BharzqjYT4q+aUfPw1zRU761R5y6/VL+dXaiZfA?=
 =?iso-8859-1?Q?QT/Rk61Va95OMlTppEdj5WRptluwCWHXK8WNhFsSPw04/9bDamMzJNA76R?=
 =?iso-8859-1?Q?r9uFNYhlvlTsdEpVt3+Hq+c+6/EFATzkhlP2viMyAuSheCLN0vsLRWdTgk?=
 =?iso-8859-1?Q?HBRmJ6Zq6gbjEteXMjvPdBHab99fkyeowC8gtNQYOO2Sdd72pxr8q4tBnB?=
 =?iso-8859-1?Q?uw8G/gOB/5kjcDy2+pV0rO4185VG0w6thdiRC39jAywgmLB2hDiicHPgNJ?=
 =?iso-8859-1?Q?JbbYnn4XF/lpCebuw+5Ehf5442vIxK7TuBvY00rFd13qYPn2rTNrnqg7rF?=
 =?iso-8859-1?Q?ph8k5TRcvRQ3O1TccbpkjTsGpyAiVYtJWTVMWbTrYsIDqYKCiPMOUYo4IO?=
 =?iso-8859-1?Q?zjwv8BZDx2LYWNFC6nFU30g+PH0QBKUwHIXOirmNeeRDqdZBmt7S6wCqn5?=
 =?iso-8859-1?Q?eCTneAdk/mOt6NxAlMuEvsyvkOkT4AYNgEy516HuUvDAtI0lNVjCHqg5vh?=
 =?iso-8859-1?Q?HUQH8gUdpBc7HdTFmEb7Y6MptEWNdb3eG4CzZXJiDLuno45g52U9zbjdVD?=
 =?iso-8859-1?Q?ZxVMmyJ51J0o5piNBDmpbQUWQSXDpKIyssV2TSY1vcPurasVcuI6xLS+nn?=
 =?iso-8859-1?Q?S4jqUnjd+rTjcYazzv6kQNoc6AOcYhZdX4MDmTrvwlm0AwOH80scW6TNwj?=
 =?iso-8859-1?Q?i4Tiwe5BIYkKw4gyPv+76RA7T9IzhWsiR+Bf9VNrWJfqVwHmnjifelrdOy?=
 =?iso-8859-1?Q?wDj2+Uvd1MP96b1If4U5VsjPPQtqWUgPJ1zQMZK64o98Lvmig+m3Io4hDo?=
 =?iso-8859-1?Q?qV/oEK6RWhu2cQ2J/zHMUtLTIDExLOKkuJsW6GzjvRDJOgmjD8qUPeaglg?=
 =?iso-8859-1?Q?8CpTcWT9zXc4oHBG69d3rp6QeaIzmPx303Km8rPriWYmy3924RKbQrS25j?=
 =?iso-8859-1?Q?I3aMhXjJAqWXk8ANMmTh9Fy+uJfcR4HcV+lx2jFwoGqis4MYVU6I5LeyPP?=
 =?iso-8859-1?Q?ggGXKC3OT/9f9P8fESSeWSCY7psUuuKxePiMRNI5o3W2IfYJeJB7ofE8Ea?=
 =?iso-8859-1?Q?nXkJ+nkCURG99tHY6mKASYykCVQNbLkfVIa3no6CWcioM7e9x39VJu/Kzd?=
 =?iso-8859-1?Q?p2c8OvRLe1+Wy5onptqjT6l2iwrKCUwaJYnJmLBIq5xWQltSjyBHCMKQXS?=
 =?iso-8859-1?Q?peuvyUBiitCS9ljiI4lJxn5oV1ZtIjd7IU7Z0Z+up7HW73lOr4pdRUetDB?=
 =?iso-8859-1?Q?6dwnzZeCYAneZtjt5l5+MfxPtzfmg4T13yD48Ydx5KCiLcp/EFIG6CrbPF?=
 =?iso-8859-1?Q?varnGUlz0XCvSp/3Se1NHiyYsND6+vgOMki2wLQvG8PcgnQqPe5OpHSaIZ?=
 =?iso-8859-1?Q?tVbHdjUCJz6YlQ8wahAx2bSmvTP5ySYou+SSf831qdxwV1q+T/2DiTrKGt?=
 =?iso-8859-1?Q?x1u5AcrcdLlNv1jZfLG2J2Fn+zzB/DYD+RoVTW9pEPijmgm+fw4mna8Ihm?=
 =?iso-8859-1?Q?3IUHLsDHbgdvgoxBgVMO3jFzMahZ1eET6ssntN+cwKT3YnEqw/fZPICdi2?=
 =?iso-8859-1?Q?Dgu38jha/TJ8cHmF62QMLG+7Af31iEQIlFOTtfzVX5NIo17N6yaEM5V3Sv?=
 =?iso-8859-1?Q?erhHMwCKrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b002bfca-9287-4d72-dd9e-08dee9c73f0f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:05:10.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZgz12KxyFrwf3lowHHyccYk8IpLP4XRASQMD5AcUJgJCIjMhYrNAfk+r0TKFhaX+gwa36iXuyiMSMmScvwH8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF

On Fri, Jul 24, 2026 at 07:37:31PM +0530, Shrikanth Hegde wrote:
> schedule work at regular intervals to implement the steal_governor
> policy of monitoring the steal time and take action on the state of
> preferred CPUs. The interval is determined by interval_ms parameter.
> schedule_delayed_work is used since interval_ms
> is in the order of milliseconds. Work need not happen instantly.
> 
> Periodic policy loop essentially does:
> - Gets the total/delta steal values and cpus to use steal_ratio.
> - Calculate the steal_ratio as below.
> 
>        steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
> 
>   It is calculated to consider the fractional values of steal time.
>   I.e 10 means 0.1% steal time. A few tricks such as divide by 10,000
>   are used to avoid possible overflow.
> - If steal value is higher than high threshold, call the method to reduce
>   the preferred CPUs.
> - If steal value is lower or equal to low threshold, call the method to
>   increase the preferred CPUs.
> - If the steal value is in between, no action is taken.
> - Save the values for next delta calculations.
> - Ensure design checks are met.
>   1. At least one core/CPU must be there in preferred mask.
>   2. preferred CPUs is subset of active CPUs.
> If not met, then restore preferred CPUs to active and stop
> requeue of the work. Driver is effectively non-functional after that.
> 
> 
> In order to help the above loop, a few helper functions have been added.
> 
> 1. get_system_steal_time()
> - steal governor takes global view of steal time instead of individual
>   vCPU. Collect the steal values across the vCPUs of interest.
> - Sum up steal time values across possible CPUs. This helps to keep it
>   a monotonically increasing number and avoids spikes due to CPU
>   hotplug.

This is questionable. See below. There should be a better way to
calculate steal ratio, rather then accounting offlined CPUs stats.

> 
> 2. decrease_preferred_cpus()
> - Called when there is high steal time. It needs to decide which CPUs to
>   mark as non-preferred and set that state.
> - Get first housekeeping CPU and its core mask. Mark it as
>   protected core. This helps to keep at least one core as preferred.
>   kernel ensures at least one housekeeping CPU stays active.
> - Find the last CPU outside of this protected core mask. (target CPU)
> - Based on that target CPU, get its sibling and mark them as
>   non-preferred.
> 
> 3. increase_preferred_cpus()
> - Called when there is low steal time. It needs to decide which CPUs to
>   mark as preferred and set that state.
> - Get the first active non-preferred CPUs. This likely is the last
>   set of CPUs being marked as non-preferred.
> - get the siblings of that CPU and mark them as preferred.
> 
> 4. get_system_cpus()
> - informs how many CPUs needs to be considered for steal_ratio
>   calculations.
> - Return number of possible CPUs as get_system_steal_time computes
>   steal values across possible CPUs.
> 
> Notes:
> 1. Using core instead of individual CPUs performs better as SMT is
>    quite common and some hypervisor such as powerVM does core scheduling.
> 
> 2. This doesn't do any NUMA splicing to keep the code simpler and
>    minimal overhead. Current code expects CPUs spread uniformly
>    across NUMA nodes.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  drivers/virt/steal_governor.c | 155 ++++++++++++++++++++++++++++++++++
>  1 file changed, 155 insertions(+)
> 
> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
> index fda86777d6f0..991821a82485 100644
> --- a/drivers/virt/steal_governor.c
> +++ b/drivers/virt/steal_governor.c
> @@ -13,13 +13,18 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/cleanup.h>
>  #include <linux/cpuhplock.h>
>  #include <linux/cpumask.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/kernel_stat.h>
>  #include <linux/kconfig.h>
>  #include <linux/ktime.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
> +#include <linux/sched/isolation.h>
> +#include <linux/topology.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  
> @@ -108,6 +113,151 @@ module_param_named(low_threshold, sg_ctx.low_threshold, uint, 0444);
>  MODULE_PARM_DESC(low_threshold,
>  		 "Low steal threshold. default: 200 i.e 2%. Must be < high_threshold");
>  
> +/* Return collective steal time across system. */
> +static u64 get_system_steal_time(void)
> +{
> +	int cpu;
> +	u64 total_steal = 0;
> +
> +	for_each_possible_cpu(cpu)
> +		total_steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
> +
> +	return total_steal;
> +}

In v8 I pointed to the identical function in s390 code, and you agreed
to unify them, but that didn't happen. Please do that in the next
version.

> +/* Return number of CPUs to consider steal ratio. */
> +static unsigned int get_system_cpus(void)
> +{
> +	return num_possible_cpus();
> +}
> +
> +/*
> + *

Useless line

> + * Called when the steal governor detects high physical CPU contention.
> + * It finds the last active core in the preferred mask and mark those
> + * CPUs as non-preferred.
> + *
> + * Must ensure:
> + * - at least one core is always kept as preferred
> + * - preferred is always subset of active.
> + */
> +static void decrease_preferred_cpus(void)
> +{
> +	const struct cpumask *first_hk_core;
> +	int target_cpu = nr_cpu_ids;
> +	int cpu;
> +
> +	guard(cpus_read_lock)();
> +	cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> +				cpu_preferred_mask);
> +	if (cpu >= nr_cpu_ids)
> +		return;
> +
> +	/* Always leave first housekeeping core as preferred. */
> +	first_hk_core = topology_sibling_cpumask(cpu);
> +	cpu = cpumask_last(cpu_preferred_mask);
> +	if (cpu >= nr_cpu_ids)
> +		return;
> +
> +	/* Find the last CPU which doesn't belong to that first hk_core. */
> +	if (!cpumask_test_cpu(cpu, first_hk_core)) {
> +		target_cpu = cpu;
> +	} else {
> +		for_each_cpu_andnot(cpu, cpu_preferred_mask, first_hk_core)
> +			target_cpu = cpu;
> +	}
> +
> +	/* Only the first housekeeping core remains */
> +	if (target_cpu >= nr_cpu_ids)
> +		return;
> +
> +	for_each_cpu_and(cpu, topology_sibling_cpumask(target_cpu),
> +			 cpu_preferred_mask)
> +		set_cpu_preferred(cpu, false);
> +}
> +
> +/*
> + * Called when the steal governor detects no/low physical CPU contention.
> + * It finds the first active core outside of preferred mask and mark
> + * those CPUs as preferred.
> + *
> + * Must ensure preferred is subset of active.
> + */
> +static void increase_preferred_cpus(void)
> +{
> +	int first_cpu, cpu;
> +
> +	guard(cpus_read_lock)();
> +	first_cpu = cpumask_first_andnot(cpu_active_mask, cpu_preferred_mask);
> +
> +	/* All CPUs are preferred. Nothing to increase further */
> +	if (first_cpu >= nr_cpu_ids)
> +		return;
> +
> +	for_each_cpu_and(cpu, topology_sibling_cpumask(first_cpu),
> +			 cpu_active_mask)
> +		set_cpu_preferred(cpu, true);
> +}
> +
> +static bool preferred_cpus_valid(void)
> +{
> +	if (cpumask_empty(cpu_preferred_mask)) {
> +		pr_err("empty preferred mask. stopping\n");
> +		return false;
> +	}
> +
> +	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {
> +		pr_err("preferred: %*pbl is not subset of active: %*pbl, stopping\n",
> +		       cpumask_pr_args(cpu_preferred_mask),
> +		       cpumask_pr_args(cpu_active_mask));
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void compute_preferred_cpus_work(struct work_struct *work)

Bad name. You're not only computing here, but actually adjusting the
preferred CPUs mask.

> +{
> +	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
> +	ktime_t now;
> +
> +	now = ktime_get();
> +	delta_ns = ktime_to_ns(ktime_sub(now, sg_ctx.time));
> +
> +	if (unlikely(delta_ns < NSEC_PER_MSEC)) {
> +		pr_err_ratelimited("work scheduled too soon delta_ns: %llu\n", delta_ns);
> +		goto requeue_work;
> +	}
> +
> +	curr_steal = get_system_steal_time();
> +	delta_steal = curr_steal > sg_ctx.steal ? curr_steal - sg_ctx.steal : 0;
> +	sg_ctx.steal = curr_steal;
> +	sg_ctx.time = now;
> +
> +	/*
> +	 * steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
> +	 * To avoid possible overflow, divide the denominator early.
> +	 * Note minimum interval is 100ms.
> +	 */
> +	delta_ns = max_t(u64, div_u64(delta_ns * get_system_cpus(), 10000), 1);
> +	steal_ratio = div64_u64(delta_steal, delta_ns);

So if:

Possible CPUs = 128
Active CPUs = 8
Steal on online CPUs = 50%
Steal on offline CPUS = 0%

Then calculated ratio would be:

        (50% × 8 + 0% * 120) / 128 = 3.125%

Instead of decreasing the number of preferred CPUs, you'll do nothing
under default thresholds, or even increase.

Have you tested your driver against such a configuration?

Also, I'm not quite sure how you'd handle a case when you have half
of CPUS in your core offlined, but you manage preferred mask per-core,
so you offline or online less CPUs than expected. Can you mention that
scenario in the documentation?

> +
> +	if (steal_ratio > sg_ctx.high_threshold)
> +		decrease_preferred_cpus();
> +	else if (steal_ratio <= sg_ctx.low_threshold)
> +		increase_preferred_cpus();
> +	else
> +		goto requeue_work;
> +
> +	if (!preferred_cpus_valid()) {
> +		restore_preferred_to_active();
> +		return;
> +	}
> +
> +requeue_work:
> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
> +}
> +
>  static int __init steal_governor_init(void)
>  {
>  	if (sg_ctx.low_threshold >= sg_ctx.high_threshold) {
> @@ -117,6 +267,10 @@ static int __init steal_governor_init(void)
>  	}
>  
>  	sg_ctx.delay = msecs_to_jiffies(sg_ctx.interval_ms);
> +	INIT_DELAYED_WORK(&sg_ctx.work, compute_preferred_cpus_work);
> +	sg_ctx.steal = get_system_steal_time();
> +	sg_ctx.time = ktime_get();
> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
>  	pr_info("enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
>  		sg_ctx.interval_ms, sg_ctx.high_threshold, sg_ctx.low_threshold);
>  
> @@ -125,6 +279,7 @@ static int __init steal_governor_init(void)
>  
>  static void __exit steal_governor_exit(void)
>  {
> +	disable_delayed_work_sync(&sg_ctx.work);
>  	restore_preferred_to_active();
>  	pr_info("disabled\n");
>  }
> -- 
> 2.47.3
