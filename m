Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72693DCDBB
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705980; cv=fail; b=leyxoGudRvvbP5aF5OLSlPUh0vWWdWgVvGq+lqKNsBJ+pLreAloQCto1jN61XrvyYHpqyFSrTfvdURkHb0f7bYm/yUWkCOyxF/Ud/QcWPldUxpztzhi7p9pzPVpxiJkUIEM7UkFjQC0InQEKiQwlc9eweeqw1piHzwqMTeoa/R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705980; c=relaxed/simple;
	bh=OcpBiic7Z0y3ZQJg6O5+XDzKKsP2GE28ov4CTN/G0QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xux/IamN4F+NWKKmPgZV+KFhVgLfWDHo3C5baRXtZTh/j8EgwnuApt/VkgM5zSN+mPs2FQBxDS6WJ8gZ3coFur+LbJojkQKOqbAGGumgNm8CCj6x5IbzPycwNci2Aob2DJuSiLM3By9u5OGjwG9DRtb5WWwBlNuVs7A7Obi9DtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omP46HWc; arc=fail smtp.client-ip=52.101.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omP46HWc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4vGf0CT/NQeuJVZ0NylKTKqRw/Hyelo9pPib8CCJxzz/qbixBrq8QqXqsigOTHqExx09kLMGxHpTfCcWDZosIgs3UwLAHWphjKJeDC1ZvnzuV/vgmzqCHkL2dvj3hOYCqexViipARsefRcQAcViixt7GUnZnjh8eqcgxLBVoHQWxnabBblBrNdfaj4mYDgMDNrKWsV1eUCNo8zDEKBhoDAi4GHD2UfoELhz8id+WFVLHY4wpgKEEwUtu4VU+Ed9EYuWbwZfhbUC9+1ekvolUzYi4f2eGIqLRVCUkOmwUiQN/oevZ+gYb24OVP9GgCldwfqZQiJz6hQY0fvb9grX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEHd6QhZBudN5sAEVUXh4jD8AjnQkYMlX3WX6QcLVlY=;
 b=H7VP0Kxl3QBU011Ri2y5gUQsyusXgGxZKKx5CRGcY/NHXSGOkCtz1Iskb+ceglV8tDJ6tvbQ2Dss0fpQ1DpvpQA0XCVKQ3UZU/JUaDjsjac6IA2EfIk1PvMpFB8/5KJ8W+ATw/7pbj81ND9J3Xm+FmXWL6b7DTc3kVMEI3Zhlg+mpfa/O4wUqEQwes6rBNPIqDVdQssh31fCQ6SAG5yyOvrLwMvLxDCzHfWO4m8AWBWFBu4nhqHPx/zlsW+FSITW3CAKNWc1jA+DO6fHPpTRn1YfxIJ6cgfTCdIomIQRTblZ7GFZrCO4JvCRDcq6Z4taiy1SUNKJAdeyxqkU8vW4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEHd6QhZBudN5sAEVUXh4jD8AjnQkYMlX3WX6QcLVlY=;
 b=omP46HWcgISZhLR2mztgKr1HJ/CNXDQlMHQClZHkvCZq6R99z5UROxYSVo55rNA8Xb2Md00cvKG3t4O9LUQHS/xxQijCDQKvvlWlW6ufxqkOaMSREciYc76KZ4qhm/VAhwxvwaJrpX0IqMP71vSUYQtD3/wNv5u+9/xFIVrTXacMEfUfp/qLUzlw6IL5qmAMGPykdtDkT1BTUS8pP4Sss8ilp8r78EjHOMaFVfuUKXYw3sDwIFgnX/1TmIcvwNNhnpvdeow3CxgVvkNXaEUMOnebh6bgzkduPYsK/l0rzAYG0Df4y6XarJlyawFm+GOuVEG+/qsMCYlPgBV07Z0Sqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 07:39:34 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:39:34 +0000
Date: Wed, 22 Jul 2026 03:39:33 -0400
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
Subject: Re: [PATCH v8 10/11] virt/steal_governor: Implement steal_governor
 policy loop
Message-ID: <amBztSFLg2X72P2N@yury>
References: <20260720172250.2257582-1-sshegde@linux.ibm.com>
 <20260720172250.2257582-11-sshegde@linux.ibm.com>
 <al_IbeAa3sDrt9A7@yury>
 <c64ed18e-7863-44c3-9c7b-2f1efd1a805e@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c64ed18e-7863-44c3-9c7b-2f1efd1a805e@linux.ibm.com>
X-ClientProxiedBy: BN9PR03CA0686.namprd03.prod.outlook.com
 (2603:10b6:408:10e::31) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MW6PR12MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b103616-ff35-4da7-ccd0-08dee7c46008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	E0P0wzaYackfmHUOXZr1w/VsubyE6cDqt85bk9SjhQ9i6yjhi5NS5y6jAGpOmdUCObALmlE2NVsx3kDQt55mM+X7n7TTRHB2pwCg+1gah14e8wkouCqQPHNAtuREjBxFWVXswuO7ZcUACNoYt7clLF+dtfpFBBcD2rdj9S923VNZiJQeliNNyWE4vuf3HIHf1qi0qVCvyPAXlmFydW//lheel/94lboQHuxjA4dC+UAQwznVJtyntA98uOPvZ9wN4Jx5777zSDhs415SZIpUB7KJ+uItvytI7r4pUTOz3sQ+COC67SFG0d8Sf9lqa4uOeJVN6KhSAhsjSonwHLJw2vTYjU3fCrSFRj/LBKkUsPOGmaQucv9KxLzzFFoByAcSVDlvssKQMExlt3RPtxbZF0091/HbLYoaRfRzMN/iDwaxXdPBEZYPOAJfe3TPiFIY37ZxYQXMSPsbqJUqLc4l1AkytKe1ib9VCw8Qej5FH4jleiDmTJpblXwsTpU/D5b0H/0PTvMOp0tGi6osEzZ1pqAhqxu7YBE93WIHLlJaSSkO5QhyWDqzJig4FFVWemQC2IxTibiOGkmW0G3pgEkr2wpkDaW0/+Dk7OBst/APE9wacQ0g5vozC7Kf4RBBJiW/+uNhpgMJyfhVrAY7xudMl7y0Y9ed44hSKNpIa9ledrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YLGrT8Mbi8s6q7oOM4oX5g8xNswxBHRO2cZflFNUjtUoMxd+HshuIaguA3KP?=
 =?us-ascii?Q?oAloKnqV2RM05566Y2vxjvy/UH+LKVThnU2HPAIN+c3MOUJANTv+YEDJCSyg?=
 =?us-ascii?Q?7AB3PMtP419H4e+LPBRaKtWG7wDdfIpXlwPxI6YxCHwRtrIzr5Yr+TJ51CtM?=
 =?us-ascii?Q?3N+n7sLvKGWagquWEDUMe+ayfpvksOU1qRhZqqsWV2EVJt1JETsWpynterUr?=
 =?us-ascii?Q?KHMBkoOT0LVCe6/Dqh3hFNXQR30ilNTya3NqDI7/oiZfOf7Z8+GoR8XVq2jv?=
 =?us-ascii?Q?qh1FwfwMH43e7UT8cwTSgkvB2aGOed/yrIZD8qDcYNc8AYRwg2Or39U4ssba?=
 =?us-ascii?Q?M1ubYcjvcsaxmfVrH1Iz71aAhSsQM9W3f3V8/6Y3X2VZgEzz8cLrMXQ7kuEc?=
 =?us-ascii?Q?xG6/fWXdmosk8oepJ4yTXkFdhZ7hyDf3ib5f2GXNj/0bWvM3pFH92mFP/QhX?=
 =?us-ascii?Q?hEuy/kjZkGFOdxPwvYmOoJvls1pVTKVsxboh1CuNEKVhdIIMQVB3cXipmGKB?=
 =?us-ascii?Q?/TZ5MTgbwCuaVp9/EQTxC8NA5g2sKmpcXE3ru8WuhJyudLCSvZPXLlfFb5ma?=
 =?us-ascii?Q?OW6AnCFcD+0DoEMtdsPbzun2sVQK6pGxSnVspU61ihTvq4ygwG8NbNOFMFS7?=
 =?us-ascii?Q?YKHCngOb9IvlM+VIuTgR8Dcg35N1a9Ailbptb7A+9U6y/YXU2B2vJit/1lTF?=
 =?us-ascii?Q?+rEl4/0yaQHX/DitplxCHvz7G7AoV8T/Cn1w8KdcYt+wSzYtDv/449G0QJU+?=
 =?us-ascii?Q?TZxVVAAmQN9MsZ82ohPUVfzlniIKXPTY/6OI2AwvHZy1wJZgelnP7zgvMYe9?=
 =?us-ascii?Q?//6q1RlJP5mz7L93Br4zoOaFhNgwCuoJHPl8PtWIwvGcEyx8qN6VfcKaZCOV?=
 =?us-ascii?Q?Sdmh34Z+J5twLWYK1AUQD9ymH+uoNJOXR0HIsytyYZG6EF++9sCwaEUfbzrH?=
 =?us-ascii?Q?8PE8Nz7T1Zm8/QIlpGBWzpkcKw/Zkyew+fGeWLkZUIDxIShfg45zWyaq7ze+?=
 =?us-ascii?Q?A/3oh6JNYK8Gf4HoB+gflgQutfaoHHEtpVmwXrhY5+m8JRvqTn3D8cL2JffS?=
 =?us-ascii?Q?Cap2DP+9j94Q1VhdyhvC196/Xub6vqvXoXc1KSoR8mrO+Ob+DesuyPb8kaWD?=
 =?us-ascii?Q?gpBrsmDi9Yev0ii1jvMuS3I+I1TRGDj6xx7gDUPQjYRixnWhwE2RB5Pwtc7X?=
 =?us-ascii?Q?5dtUrPISagky4gdZKHxSbqW/2Wn7yUjvVT9nCJW0Q2XABkpkLD987kYsUyGh?=
 =?us-ascii?Q?8cbNlbhQQW2VXHqR5+JYl4Uevx3kiPl5QPFlKrDCyp1UtqF1qGmh0KwAf0dH?=
 =?us-ascii?Q?a3oTYOkzB4MhBqes1d3UEQmocoTVtpXmTTxCdyAyRQBvxEKTve3fwhgm5M7F?=
 =?us-ascii?Q?dP+0hdPpO4SjCKoV1+c4xw5zGzCYBPQ78IGgLySeYrob2nKBamGrTem7lyTh?=
 =?us-ascii?Q?+/UyY54AYRko2xooGdJZ7zSulto//W8EaWRFOywaBOTeSCoXRavGtHoOrY7X?=
 =?us-ascii?Q?X+hIHT7WULtFjWQIHd3rjcTRIfGhJJnyM/H/WRy52i5YGVZHAotDf9Co4hDE?=
 =?us-ascii?Q?GyXWm6choMIkJbxxzRa3ttyVL9ntZ37Vt5mGeqPRrTmor+pbzYL+uE5qyjD7?=
 =?us-ascii?Q?zDpUxoi6ViTaBxGnJO0fElZ+xbqR/0jObG8Ks0VxeuYkjIATqK/JefmtYC0H?=
 =?us-ascii?Q?7yQCiTyT3iWiKFloc5utFru/wmQYilfndlWM718OnMNtj1Fcttm4igIjjLTL?=
 =?us-ascii?Q?+r5hn7sBew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b103616-ff35-4da7-ccd0-08dee7c46008
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:39:34.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0pMAZBX5MFxyPV/Z6NnuCkXSRxGni6zTbt3i6rF5fKna05732CAooFcjZPEsdQNiZTfZDu8wyNdx2egCqmRZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949

On Wed, Jul 22, 2026 at 12:44:03PM +0530, Shrikanth Hegde wrote:
> Hi Yury.

...

> > > +	schedule_delayed_work(&sg_core_ctx.work,
> > > +			      msecs_to_jiffies(sg_core_ctx.interval_ms));
> > 
> > If you need jiffies, why don't you have them in the structure, instead of
> > milliseconds?
> > 
> > 	schedule_delayed_work(&sg_core_ctx.work, sg_core_ctx.delay);
> > 
> 
> I would prefer milliseconds as jiffies is very difficult for users to understand.
> It depends on HZ value and one has to query from configs.
> 
> HZ can very from 100 to 1000 today. Again I will have to play tricks to schedule
> the governor at fixed intervals.
> 
> So i think it is better to use milliseconds here.
> Correct me if i am not making sense.


User provides milliseconds, then in init() you convert them into
jiffies and save in sg.delay. That's it.
