Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F32931FB
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195243; cv=fail; b=L3tn5sCEv7AgXcjfq3OlyjpmroClaylJM8pGNes7GfSjsvxIZgTdmE1skeWKU2SPcMoCh33uSR6s5gW+KWgSRjnMZ3UnRE5CzBkhhhIEm4MqPH8ojLEl+DuQ4Bqdlk6UFDSslYmh8DyrvaAhIT/hjUBYCBHvaE1WGNfdoFRSEbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195243; c=relaxed/simple;
	bh=umAlde7fXCV4I7iQtSO0+WK0NCosPUuJVDEdCu4XmKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U+rNju06k6whwJz2gJQKbjKrZBma5BzVAWsbafkQaOpIfKZdyV9pZBrCqUphg72eyn5s5GrewSFC9EPGQ2CcxQdelQDyfEHPVriuV+4P7Q5hDrRHNvhGTEOZSmExKZJZYLbSEGdR9v/uILpzBUSK6b8+IzP7lu7geigMC0FH0OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bRNTHUnI; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bRNTHUnI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Umfd7U1sf48sbvha1c34atuNr1G4QqZXNvLMRVFpOT8HBdgLhEmtQZYIWnsvpTPxkeGHvnSxHWW0GCVZWEZ9NoUhu8gcoC7FCK5PqnQ2qwX2mUkW8PjhlpbM5/yubs8AkZjN9eJi4u8pWtuvs1QlcGulxwzXXiX2tLmSElNGlZiC1y3wtmo+9KHNaF8L/mNDdWJlE5eqcyoCl31c81oKqtCIjXezQlkUwODxNd3JT0LRodzXUjwdO8pDLJLJvA+uPJGMHgEjsmEqy+wLkmETteIRxNh8bYEtOTnA4TwHQiHo6xarA/4TscdNVNAaAan7Teb7eRCjstF3WOLq8Isrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nPIChNBCo1EJWNxbWFb+7s7ut/mFZVDWMarAZyTKrI=;
 b=eW2XfvsF0XzUTLYaP8wqH8nG2YLy/GHEoJ3j5enwauSVSr4UkdzOTGv0kepwvNHsgN/MiKxB+7w4lVWwlwnOrXWlLBAZ8PHXmMIwShJtegximmqEkDTAtrMVRwBu2ji57IO7fEMPIpiJ/E11GUHZYSJJCxAtjgEVVasYDk7oL/+e/huNxiP4Nq2d2dF7LOWc241aPVmMC77nAGcGxkbVnMHKujT0q2YgbKOLzlB6WwDYv2cf7QUz9xzb8b3Oi/OrTdgHQHeVeuc2bJ70UBXkv+mqLG40ymgSzE2Ly/k8tVXHI/43KJft1USdn/EzICV0hXUoy6T85dYIn+IffaJJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nPIChNBCo1EJWNxbWFb+7s7ut/mFZVDWMarAZyTKrI=;
 b=bRNTHUnIF94W3ziOK93IUuORFvdNhX8fzri0zXeclMKUyqLNX23o5C51rOa9rqF0hmDegeGdIBFIe05x+sK8rNgOvwhWOsRvZJHsbzAM+aE8mCHzv9JmC4W1YkKnpccobJKvX2JDzumt1TD1LcFqiUf7u3bfeJZ4J62rTAXUL8AZxKEjbJFUzb5DFTb+f+b4VRdsb4nhIpBi2wVaecRgGeZJW4+87EMMQBEepmgqHE5yg2vuOoJeVswbk9QG/q8PUPC0ctx3c5DkIhPlvViPwRH+fwxhGEQucKXexBDw2eHdbKEeCJjJbcuAgkUlERVauGsHS2j1rD5ONR2cQ8JhqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:53:46 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:53:46 +0000
Date: Mon, 31 Aug 2026 12:53:44 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	peterz@infradead.org, juri.lelli@redhat.com, yury.norov@gmail.com,
	kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
	meted@linux.ibm.com, tglx@kernel.org, gregkh@linuxfoundation.org,
	pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
	huschle@linux.ibm.com, rostedt@goodmis.org, maddy@linux.ibm.com,
	srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
	vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
	pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
Message-ID: <apWxmL_brfi4fa4z@yury>
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com>
 <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com>
 <apMziCV_8y0xeIBT@yury>
 <53035ba4-53ec-4907-93b8-c8b957d1fa61@linux.ibm.com>
 <CAKfTPtA5Bdw89hezn1wi_p0m0dJgJJ1GYg8H93PsvsMC4bVJxA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA5Bdw89hezn1wi_p0m0dJgJJ1GYg8H93PsvsMC4bVJxA@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0486.namprd03.prod.outlook.com
 (2603:10b6:408:130::11) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 3754bab5-dada-4976-8e0f-08df07806bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|23010399003|366016|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g+r4WTYpnQeGjPQsE+khIb1jCFhDHSYBB/J6QZqbj0Tp82dcIC2hZ92c8PUxWhT4eGI0PlYBzvht64l1enRF3KOulNRYqvIXbjrEuytV+43z0x3wBI3OJYvP/l1eNnxCx2R6XYMHa0jQoS9pYNrsi5ue3qh3YYs4w5xeFF7379DA5Ybby6+Qq6Q0QpmrpUwnhBMWMciADdHLn9jOZx67q8VldaYHtOTnxS3TkZ0Ggt/aIdS2hLIuWKPSYbJsDV96I7f8wkzxz7lnZZ6tHGHUu4qrK0f3Z0omIsnhaaGbrkqei9eyHUG+kiG7oj8wXdA+uoJGDEJGDg2K2kH1QTvpo9HFtL9OU73sMPRLRn3y2HNF16CnjK0yRs4xO4YPJZomSL66zuPjKsvrxK5d8k9/W47SvW2XkwRFqsDzAguu2vn0sG888o5dqEct/P0hjXlWa0nxCti26Or3Kf2S41zzOnudW1BBW9b3wgXa03XEuKDlPH2vgr40QfIySK10ABh3MA3F+fGPUJncMQBZ4q+S/tkyjHJNImqvyRBE2IXrxE2BUiQdhepN5gmWNDjtstiNyr6TnGECDuPeVqVbnuA6re8QXRyTS9k/tR5RAd75PxBl//gCRVpE8nxmMnrcZHCR/IZO+Xn24Wfka0VijF/XRXITIdBvqKKxfWJG5l/IFf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NmoaNElKbh3RWpYDDf/oi0MH603sXH64HSyUInfU1J+yLc9B2sxga863U4Ct?=
 =?us-ascii?Q?/qIQ/wFoWKFOmnXUsJ2tmPdR/W/awUJuuxRs4T1aQIrJkYhtPpJRZGY7G9+B?=
 =?us-ascii?Q?6FJm0aVqFtj3j7fazt6UO/viiX+1D4b6DyV1HhUVhO46+CId7yN1IaNKu8jk?=
 =?us-ascii?Q?/0QhD2OzfjufLZ+2QN91s3/b/5aH3Ynzogu4TlZ3klclMCRDKjLTOfepOmEI?=
 =?us-ascii?Q?QAUCIMk32MzTTRtDKN8BBM/5j80Q6mIndHe/ipL2Kv67FbmB73W8wxHUFcjd?=
 =?us-ascii?Q?iVymsJfJ35UA4kTtXoP7m9xmcgdrPS8niUXOIFlYtXKISoR2nv9F+qe43nDr?=
 =?us-ascii?Q?lM0Mwmz0bJmibpSIRXGCMkWNevbhDlHGib2xSI7mMY68+jFjYpNiIZ4tPJO0?=
 =?us-ascii?Q?tATvNgCmB5gFN0rm12Wzh34LxHuc4cw5SYlaGKtFmfCsgidTtZ2zmvnTCcuZ?=
 =?us-ascii?Q?8ouHJs6+3p5fYrg+hs40v72F/aXeGi5lgNScefHaF7zM1HvrxnjZjo6VUCSS?=
 =?us-ascii?Q?3czhkCWIcxs0C95+D6FukUgpynJNQXt+P7a1hOdao8rf63IN/4WDqNL4X9NI?=
 =?us-ascii?Q?fwLud1sxyzq0z0WMbxZLrfZbrDWz0zsylpAAbytwQTUr+PrdeGdzG5bCHMyq?=
 =?us-ascii?Q?H3Kfltn2o5KWkL0Bk/sQU8CECHuqpTFyNe9aU/5GqTe1QezcYXsod9mnpxBy?=
 =?us-ascii?Q?TBkfyVejQJf/r5ywWeRYQ1NY9aJZfyLnbbZHrw/qU2QfaYHEY24MoTn3TaRV?=
 =?us-ascii?Q?vHnC/yg9Nv1HLSjqvMwrR+3Z92eLzo96lznENFESqwsgcUdCyMYCIjxNWRPy?=
 =?us-ascii?Q?wgR5TTpGbk1ryCljQiB+sGVK//PeAxETl4V1LtiaGPzbYWtCH0hO/JAddvg3?=
 =?us-ascii?Q?CrD+QOgMt901oftAZg6ahlFPa0vO0MCZJrahoSCoURHZ0Gk6Kf0KulsGcki+?=
 =?us-ascii?Q?Ujc/fyBPL0PAMs9Y30ZfstkLGpsQ/bFrHceWNwMR1cxuctpGkMwTdcrRMeBj?=
 =?us-ascii?Q?frppzgZROF3xbwf/Tpp6qqddyxq0hftfcANCOlUnlyf0en5guzkOhLGZIzAs?=
 =?us-ascii?Q?iXLbKRGYyT7F/wvmRzzXUg3QeXoRXFvEONAJBJWqh1qFOx9HlGcFHDI4rt5r?=
 =?us-ascii?Q?yiGlDTOd0ZKQtcwdQmWrrd+oQUlNfLxvZnRK6JnL5yFh0f2DDOmRbv6aSZDw?=
 =?us-ascii?Q?ro85WEdMylcZ16HksOOn/Rr/lMhrY7fp+FhuRVPX5ep8A8nIYW6MBSyLUBhy?=
 =?us-ascii?Q?OIdlcSg8JL4iqV3pgomp2rFjspmusKCZ9bdG1IDtBPWoISrPtwKcV3o3H5Qw?=
 =?us-ascii?Q?OEHr0nr+Jb4WyrdfzjFbRtnsQKfelNtFk9R2/v0CYntEP2LNoi11GMgy6a5P?=
 =?us-ascii?Q?DwbwXwvxvn7L9VTz2DnUzI1GMyCy3slxSwc2G5OiUM6+PhNBvxJ7owG/estO?=
 =?us-ascii?Q?SaFhZZaGRU3AIcw6G1oU534DxAVWqbdmtS42qXoBbwH7T+xsd+k7W2AJ1Og6?=
 =?us-ascii?Q?Wbda/N76kAtWik4wgaTGpiqtUakUg6mUpi9BjV5FoQT6okEu4qIYx9Z8h/4d?=
 =?us-ascii?Q?KITROH/BAnJCqAnJ0FPkFlcGnjO3u3zhfk8s9qs/vmBK2zmP70pQSHRBFrxD?=
 =?us-ascii?Q?FEbq9oh1tCJ9UFmSljAOk/YvOxSg4GlOgWG4T+bNVwSJ2CYnbT95Hfm+14zp?=
 =?us-ascii?Q?wzhDHWVWvncGNsm2Gqh48QWX25ayiWYw1jnDY5Jq9akWaIkybfE65adO/irr?=
 =?us-ascii?Q?c4PyGrwFaNU5cAEq+tUlsXusO/dk+uJg5ekaGy2gH53eRIMZernn/WHv7+Ov?=
X-MS-Exchange-AntiSpam-MessageData-1: wsd/cUqeyCdMPQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3754bab5-dada-4976-8e0f-08df07806bff
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:53:46.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz0iVVTnXqjv8xomi++nNF24220CjQjeJ1i5lthoGZjbdjGbBf/b3el35P8vGHXHYsek/6At+0+NxTFz7VtCGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

On Mon, Aug 31, 2026 at 05:09:41PM +0200, Vincent Guittot wrote:

> > Dietmar/Vincent,
> > Do you think it makes sense to enable the driver on ARM64 now?
> > Or you think it is better to delay it and once the feature is stable
> > ARM ecosystem can enable it?
> 
> It's always better to support all arch by default, unless something is
> missing which is not the case here.

ARM64 testing is obviously missed.
