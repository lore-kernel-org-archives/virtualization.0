Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56A434B437
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560309; cv=fail; b=rEoHh9C2yBQd3v60EqeKXVTVz7Vd6bhhwTLTXYtv1AE+P6qMZdrhg0L+j/xhNEWyZQZe+GhmNL8iV6G3slWTz1GDxevSAo6hemxtkbjH6L0KYWNNsBE9kz791cAT41njpM69jpgG3Er974I79adk+utu6kIpFjdnv7QG3pKfsoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560309; c=relaxed/simple;
	bh=IlB10tANPeEtGdDgkgvFA6unW1XiaJS8wvOunbYQO4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jm5nq6Hfr/ErHIscpN7Svh80JQd9q5w+zVgP3qM+uLj/x9iZsfUpcxN7WDj73kkkR31OJ5K+Y3zU7noFeMzzEfJ60TuZVNOh0K54gU0/Zs30TW8zZBBma1Vve1+Bj4FDGgK5xcWngewYFpgL2i2s45BMmuIvls7a/ISVC+rSlvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FenRofuH; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FenRofuH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suQuCh3ygCi7TEhQHiptylkp0pujd360eyqXvUicX+hOQo2S4onh6f7J1R7UZ5L4PZ5sEDzJXAc2m3kRFM1leDEUA8aV1+VzcOBl5l2KvzTVfh3UxaWu7yX1Mh/0MrLSe4SEyff1aDw0O7BcyVzFCZuDbm6W0M8koVdueLfLEqOeVeX2AkCnQ4dlRkzp1OmwuwURo6hVBws1BmfYavH6XkD8GIgobcuz6hqZJd2Kdqsrte/EHt/kwUBdvWdmyemZzTFXgY8daAES1aStP12+p8B9Kc/KNkeMUBVk09YEVDwGXuANkwGf/YYb01OsQ8xptuHbb02P94CWJyo7uwjs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqMphbf31Ie7P01D4rVg/hQYpGmyzlP7dSHyECa/zaE=;
 b=f2/6+pGjM4M1r/DanS26KbrOVUoRjpMn/Dk6lzUgkeI1QGu+NaM1ZniXbBVMH1wtNbofsAn0VOwUDSz97B15wsf5tG74DjLqBdJ8MRS6mMkuVsdA/k541Tgd9NOT9Frc7V+7EAscsyB072FMJkU7i6vvd3lZbrFNfKoLCmmZjsDqiVitIJ1cURd1ZNeGCsTurguGv2PIQhJpzFTpe2t5d5aIkdU4a0taHKmOXudIiwXf2jQwxWS0sYeZRsRfONPGJnLhuCd9YJIadPUmScem4nbNmg96z7MtNTsELMcLHRoJ0+AMXgyYTsEBYoWvXf1RAgYyHcDkkmYaVdDxaS9+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqMphbf31Ie7P01D4rVg/hQYpGmyzlP7dSHyECa/zaE=;
 b=FenRofuHApIKQwQnm5lNIbNwOw70IQ9hCa2YXseobW92OsUjGWXHah3dPwG+OyTJwJULQhwlnXzpnHa2tg3J1961UglavvtgLqQ8iUl/t0uDlbLBIHx2PqmYnOVMDcvWZdWB0x4O1uAT6dNY3zX2zJSCA/+KBAk+cUWeoK4RR4SvCFgcc/LkKV3YuRx+XWPlHWo+VXflywzImLSNhr/ag0wqt68sUc6DQVGseZtA2P4xgIFKZCr4u9d9jERV2sOYicEEUZA2g8HzkLwwD/IgTf8qGOhlJEoPVYjciMarXhWU4r6ZJwkDGqBeqJpNcwRphhWmYlW/GFhvgsoIHU5AcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 18:44:57 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 18:44:57 +0000
Date: Wed, 12 Aug 2026 14:44:54 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, meted@linux.ibm.com, tglx@kernel.org,
	gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
	vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
	hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
	frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
	christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v10 01/12] sched/cputime: Add kcpustat_field_total helper
Message-ID: <any_Jv9y6a8WKoL9@yury>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <20260812054033.95658-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812054033.95658-2-sshegde@linux.ibm.com>
X-ClientProxiedBy: SJ0PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::15) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: fb500b9e-e701-44ff-c06e-08def8a1ce6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	PfzZLYx9UCKkQ07iqriR9bEvKxISEYpC/JK8dHDd5uMYz0zC5dfPOEqGano7uYQCn1sUr0XjL5E18XwiqaR24IMBphYh/Xj6EbP0bVyONbvD5QnMcxXYG583yOF8lV2oiHJ+0LHZ65e3fKaJsid/SK9ZQftRMKNWcVUThJi1iTJqGIfSzpYDOVEIw01VXNOMe0lwtTc6UVTFp8WBKstn0EffpC6J9Tmw+ROkvYGWlYIzTmFYfFmw6UuMmlGXsMHKxpOfcQbnppGzWP5aStoWrg3BFjCbFaj5ThDxMX1zPJUAPYvPSNtcsIPd77UDxPLHHDAdJvswXuRe03ASgmMIiKgKWDDpXOGDqYKQ+O78g/Apx/pEXi/dvOSPMoUSKGz575yvwaDmKaTXKgjrXPUhRqTDfScAW/PstcEEt948hwFqJmxzHAIQE3B6zkgdSU6Exw7wYVrREFIa5vDzeoltacL9pwU+76QKhf5mwF9nws7Hzit6OAt8wsVQjd0btlg91Qk15WTXG7fy4Ld43z4UYhZScphvVRqqkPUm2BduAElMGWRS+aFLjbxZ9WHV70XypD7yeST5I+/HRy+10FfSeoRDJq5NTwtP6Mhn1/g41RZJOXyaf8s3RKkwQlsunAmo1QMRfIE7oLxmecAovYhGfoL3ogV9tCm8L3D/e1pum3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?21+2tMXrmPGpEs2FIR998LzA3eVfGsC5mXmBHOz7UpF/wf2p+X6b1olBBEEx?=
 =?us-ascii?Q?ADESk/MDTP1xlVczLxxoTOqNX4jWRI/L1qC2cjkqq0Y12wRH97SLba+s19Aw?=
 =?us-ascii?Q?EwPn6673gTnKZ8fkNEqSnlS+NDhnP+UFjzQrIHN5pHMmu9GlRksfswK6u1DD?=
 =?us-ascii?Q?5Fwl3Tdg29xZvvgl2Ue0aA6yjYMjUau8bbpCohnc3ccvYnM1KcycdnfslXrN?=
 =?us-ascii?Q?fI/GVOSV0E4M/ABbO4ajfL9U7G/dgrr71aId77vbVLOj137A8iUActbdYwZM?=
 =?us-ascii?Q?y6Jx0PgEEfG+1NWSqUZLo2x6NUJ4tmWuRGXAXc9Ii5fx9itb55f4HcNKVt4F?=
 =?us-ascii?Q?px+XTFgj8vRVSlsoBsoZmDpajGjoJNwE5GL8e01KsRUQRHyzFB5QPZ8rEqTe?=
 =?us-ascii?Q?VE4oyXUsdFFRS1BkUm8rYHCMLRVLTgWaIVTfgV5CS3qViLJYJi0jdNiiTx7h?=
 =?us-ascii?Q?shH9QeUU/BqdlRcfvHcAPpCJ09OscaN70+FSkoDg1FtujDZos5kRNgyND9ed?=
 =?us-ascii?Q?RsJxF77fah6r6KB7kmoqewwNsEkU0WqFm3WUTwOMxj7lwU3gadSRJcWKgWxr?=
 =?us-ascii?Q?X0hbTyxATvWsYOSwqR6UCfK/sgi6xaQZDNXZkfeSX6SW5FYjM6WqV7oPPLAM?=
 =?us-ascii?Q?K7Lc8frqA1nYuPMoo28wEFUMWs/gctXm2Uvya9huLpFf2xH0rUTjSNQaoPta?=
 =?us-ascii?Q?nTVN2RqoENTW00q63c8NIzQYPnILBhQvKoEy/+YBXiXJVNCyXELeS6RqHJMg?=
 =?us-ascii?Q?O03B9DlKx4c/bGchN9bajUyCrYWI+jC221NLNSUmcwC9oB2gHGb9yDLbNSML?=
 =?us-ascii?Q?zU3mif5YcT5SAc5jxH5RB242gAdx0DY9WXj4/xzccvqORC9Ac21FCh+QIJU6?=
 =?us-ascii?Q?pwUl3m76MNiiRl9LJ2xjcdON/ItZ0IROvHlG4r0i4N3xaoClWb6vjn57cOvv?=
 =?us-ascii?Q?HPOoqCzHWWw30ChEF1TAmEdwuYZO+81aNhZBJqrX4Llibis7AD6W8aB0f4qI?=
 =?us-ascii?Q?rCEuHZt1F+/WJ11wgkpmUyV8xnt6ZA0OlPTrg6765SeOquQU72HqS+S3GG/i?=
 =?us-ascii?Q?QYqzhI3+TmgeCIgUu7UrbRmQ05ek/QAC4meBwSl3ub2Xgwl4hJnCCzyM8EL2?=
 =?us-ascii?Q?E/7aAdKJFCrLz3pe+Xp2Ss3/DcS00ZYRb2YAr4hyklSFe+pmg9FoPhXcP5Fa?=
 =?us-ascii?Q?nogIavtERQjd+v7II0/bQM8ngM5eMCxqUdyXJuKfyfdccSEC2gCuxyc6ZSnP?=
 =?us-ascii?Q?+oUzR0b0xW78ld2AobGBY6K9PO+luD8vwpx69LHNhUmxuyKVasu3cDsnHd7b?=
 =?us-ascii?Q?w/1MD5nECgsYFkIe5//xo5ozkoAoQj4Zh8MvX2MK+notSyXKZGM8V5nOQ1LE?=
 =?us-ascii?Q?Fk8T3Hb9eb7Ve6oAv/Zv5GBS4GP8XhT6YY56C86LaClIBnQqoXNdeVCdoPq4?=
 =?us-ascii?Q?C4KA/s41s+m22K9qMlRYZ2weHlHCJ1it55p4dM0EAyc+E/4BY9rNLFOUttnH?=
 =?us-ascii?Q?P/HeAW1IAitjNIL7MNg88GrnIJXUsnpfXLq8bnXpi0IH62/IuUniy8IwSzFy?=
 =?us-ascii?Q?znh2enAcXpvP8eHnugS7ZURDd2r/C6EstfoeRKx4Pn1I2fliCl6clD+De93/?=
 =?us-ascii?Q?ZeeK7Ymwc+ZvNYohHi+GsTuL7l4X49kpDdB+8MEQdvexZN200Vx4G2PzRrQv?=
 =?us-ascii?Q?DNbAqwAtQTJcCfFaVI5bQeTWgbtKT9rJ18LKPBdWImegpHZtV9esgtCynWgG?=
 =?us-ascii?Q?mMlkxwIjdA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb500b9e-e701-44ff-c06e-08def8a1ce6d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 18:44:57.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMAe3hd8o4UrWvg89/eUpJFYJIUaxyGQH5w81XPktSaG2OSLENf1gelHRYmTbY9mPW/fAqwHQqXJHV49708hcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856

On Wed, Aug 12, 2026 at 11:10:22AM +0530, Shrikanth Hegde wrote:
> Provide a new helper function which sums up a given type of cpustat
> over a specified cpumask.
> 
> This allows the caller's code to be simpler and avoids duplication.
> For example, subsequent patch in the steal governor use this exact
> same pattern when calculating steal time.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
>  arch/s390/kernel/hiperdispatch.c |  8 ++------
>  fs/proc/uptime.c                 |  6 +-----
>  include/linux/kernel_stat.h      | 11 +++++++++++
>  3 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
> index 217206522266..e5c7c818c178 100644
> --- a/arch/s390/kernel/hiperdispatch.c
> +++ b/arch/s390/kernel/hiperdispatch.c
> @@ -210,13 +210,9 @@ static unsigned long hd_calculate_steal_percentage(void)
>  	int cpus, cpu;
>  	ktime_t now;
>  
> -	cpus = 0;
> -	steal = 0;
>  	percentage = 0;
> -	for_each_cpu(cpu, &hd_vmvl_cpumask) {
> -		steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
> -		cpus++;
> -	}
> +	steal = kcpustat_field_total(CPUTIME_STEAL, &hd_vmvl_cpumask);
> +	cpus = cpumask_weight(&hd_vmvl_cpumask);
>  	/*
>  	 * If there is no vertical medium and low CPUs steal time
>  	 * is 0 as vertical high CPUs shouldn't experience steal time.
> diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
> index 433aa947cd57..53143c66cbe1 100644
> --- a/fs/proc/uptime.c
> +++ b/fs/proc/uptime.c
> @@ -15,12 +15,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
>  	struct timespec64 idle;
>  	u64 idle_nsec;
>  	u32 rem;
> -	int i;
> -
> -	idle_nsec = 0;
> -	for_each_possible_cpu(i)
> -		idle_nsec += kcpustat_field(CPUTIME_IDLE, i);
>  
> +	idle_nsec = kcpustat_field_total(CPUTIME_IDLE, cpu_possible_mask);
>  	ktime_get_boottime_ts64(&uptime);
>  	timens_add_boottime(&uptime);
>  
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> index 9ca6c2259dfe..c1e85550bf12 100644
> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -196,6 +196,17 @@ static inline void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
>  }
>  #endif /* !CONFIG_VIRT_CPU_ACCOUNTING_GEN */
>  
> +static inline u64 kcpustat_field_total(enum cpu_usage_stat usage, const struct cpumask *cpus)
> +{
> +	u64 total = 0;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpus)
> +		total += kcpustat_field(usage, cpu);
> +
> +	return total;
> +}
> +
>  extern void account_user_time(struct task_struct *, u64);
>  extern void account_guest_time(struct task_struct *, u64);
>  extern void account_system_time(struct task_struct *, int, u64);
> -- 
> 2.47.3
