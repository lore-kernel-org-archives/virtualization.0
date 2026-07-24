Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559563F9A0D
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930854; cv=fail; b=f66sK2FJwD45ex0HsXXoKNg7zhJNS6E8AE42E+D4aJjH0rl8LCU/26rEtQ22Pk80ubHDXnXIBlYIiATYjWmR0rcYbKeCa70DjNlK/5IGAHQSgiDabnsdAKfDIVUzfegM/U1x+nHPw+sHhBk9i3cT7hGSkFn7rC5VxamhREURLWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930854; c=relaxed/simple;
	bh=Iu+UHI6vvlOpt5/GSm5SKDDagAUgy33SwMyyznMHLEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ejmt0DRsW/i87VYP6s1lSwYDYDmBOH3867mtr9Uff26KBExXzacNnsjsr2u3NKfN0PBBXmS25O/j08y/EnfWcCQ0sUhSTH6IJVtJjbNydvciSklFOsBAru0utPbhPUHpF/VPYX4ii08doxnLRtLJaGO6JfunWcma4M3hxeyvnS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bR8/P7Kt; arc=fail smtp.client-ip=52.101.57.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bR8/P7Kt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxoNas46v6TkuYGaktSiuK7jImvjqTwL5ETtRvLT2ighfscPXekKpGZ5Pld/jXANJylqnlEvhkg3ugfo1/5cFvQzlmO2GsbITaGEiDo0xTjRTd8QDMF4F2C2pFQa8esIBkyxw7Mbi09dg8sAbEJLLPssnGWNyKA1dTeG/OX1p9HsH0iqqGH5jiCmm2DcD5WEJ8ye5cGQUwcMf+StlRjFZWOjTA+A0cyOUQsexyyH4+sXspZ+6sIOzmbW4GqDzyoK2lLQ+me3+GKMEvo9E8VWvxEGe8Sxgm9Kc/3fNzNoBHvUD7iL1XoM3WUg2J+AZXVUeHhuboc9LPZu18nRBoxOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io9YjguiAiZ5xB70z5eAF96IRTCmKgsEoVTp1f2ekwk=;
 b=cQZo6CeE9zKhDm/RGq+SCp6JZk5GZw8wfQQ7ZaK14CLZatDFQyXgvNaQ7gbPQXazIEaKxtwjPJE2IaZaFp9fkNIYVU7ShIavMB4u7i7F4OxvAIPNxjxoYucljyG2vyRY+st0TsK7g+I7GXZAozCU7MiPV9O0+VWRYxcZlINjmcFMbBD+fO8Wb4pFdQVzUUZFxllyRoR0Tge4ehs4U8iaWtQqWOkhkcCbrs3FPSmZnaKIeaba/Rx6bRLljy7++ebRkXU67jUUQE2oxT9YKnh3FDHKu9+iyy9wvxStAjp7rGS1WeqUEnwPpkpxQt0aLfUiSGLGomRGcxEAmsZvEz5eDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io9YjguiAiZ5xB70z5eAF96IRTCmKgsEoVTp1f2ekwk=;
 b=bR8/P7KtUzEILNhDTzAQaS6nOyKOB/XwPPyblPIoh50qFvfC2LMwaQIPzNcl/kv7yvKfWs+rPUoE26h8+fHk3Qzb/5JFpAzfily2lKK6NVeIgTRs3IkckBEVszxFxhOgHNYQvlh5wDucDx4xomPm6D5ejoqt9i7rv6DNjV+ZPhpp3WQ1JZcApuN2Z7zePeWmr9LVNEWlS7Sl3n4QcIjY/LL7POt66G/HZ5R9sgMRv7HKnfLx6aKr9NK1AlBILfm5jjQSIRJqEr4JvlBPE1vUWqqR0TkAuEflET9o1yAv4qLsIHHu2qNxXHgimgUw5EPQStJ+H01iv9+Wm8OZkFQeCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 22:07:26 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 22:07:25 +0000
Date: Fri, 24 Jul 2026 18:07:22 -0400
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
Subject: Re: [PATCH v9 00/11] sched, steal_governor: Introduce preferred CPUs
 and steal-driven vCPU backoff
Message-ID: <amPiGgfR4cAF67Mr@yury>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724140732.2683314-1-sshegde@linux.ibm.com>
X-ClientProxiedBy: SJ2P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:a03:5db::15) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d852341-353e-4ce4-6716-08dee9cff1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	W3xB/94xFTL1li3SG27oCrqKn9vTUuCoQHYalYIDItmv6JKE2u+iyu+9DPAJaOK8wSHt+I6lQ1/bulTaQyzHCPiNkQ73pPLckk8b6VbH7Axy6E3XIEcADu85CaRotrYrPa3XMiuRnC8a/j2Uu4cSwqmn8BYopLUT4oH8OCfTsMq1GSL7gh/ms6y32HU0TLC1qrmhkLwcnYbp4yAIAtUGTNfaueDa4AnFppdhlu0eVHl6zc7qYEeOUi+lEtbXowHJeioaXbbFwlgURtfJTXGdKPjqKJYzep5n+2nqWrG2/uY4YnL30dgVjHV3Nvmux4Ic4sBzFld2ZoL+6iiNV20igXCX0EvdtZP1Yi3KM6c9eOaP7THKP1Qdrb/JtsP86OTrQmgq3vqu7o/TiNMizu1GeJ0Apozc/iMsiTaDOMivnvGzyEYbtecGWT470sZ82qRQw3elNq93Pc57dyIa7JQuS0565EEASs9ZNpzbFlx+QO3FhtUcfenPU4S5waBhTaLpMuJyUsVFxF4gW/a3o/mKh5CpWR5XYFVd9VcQub2JJkz3Bm95ILhrAfvnp3pxvpVw1stD/KeOurDdWIcGEx+pBsXe67Q5zPFpnHfwej2+CX8h5/6XgI7brH1nJjtH6oS1KuGgRQq8iDez7ehDaTnMovz/aFbzgvDSvuC9Qhqte90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y+EihEpHumo6DnxLgNZ7lwO0UADg6uv/zCIgAkH9raviY9MZZXN0cA3vHYUe?=
 =?us-ascii?Q?6YDCwmEy5by/AxQ7U7680b+/XYZxkCEwmrCWnxJB11tkyv9y2BocIAtHE6Ml?=
 =?us-ascii?Q?zr8xWDlM/gOiysXjodm3N8Ca2v/EnFT8DdFOhsoanSWPYa0RQjhuDgO3OBqC?=
 =?us-ascii?Q?UkmoMiETEuDExBjtOG7PMw3Jznceke9UpT6uEE8qZH0BwMj07EhcRuir/YwZ?=
 =?us-ascii?Q?MJ7De/XxpeEY5C8bXOUzyydI/zt/8jADxT1p/XxUT9aQttLWuJsiReVLMeWF?=
 =?us-ascii?Q?Wg1tVqjX1OCfRcdWBek94STb7Pzdz9Yi5TN0FlMHNsJiVV63s36DVt8fN1FU?=
 =?us-ascii?Q?IOGp0zYn3S+B7gdklQZNVLpinKidIyNcNKSRi/ADJkkQp0el0p3EU+1UgN3F?=
 =?us-ascii?Q?NHHm1bcUxUNzLwRa5ar0+SwAJkjBFqE3qCOYzP1G9YikEkdrWHMxKDpR9H9t?=
 =?us-ascii?Q?O0UQacmctoWQFE7JSV90Ml9ubp/BSisDL8kYVxDzoGO58zCczthSnEZS6Dnp?=
 =?us-ascii?Q?Glf36Fx5MmnaGyA5MmenZ/3vM9dbfcKcTmPT7AVH/BUVUxYqq24+A18oPnBw?=
 =?us-ascii?Q?j01F9fNOLyT0rnj5xHVIkF+22RJqpcXW2Ckc8vfAPlEomg8JdBE1TRV2vNcQ?=
 =?us-ascii?Q?nQMxJb2o4BoNWPKAOhKd1U0bzYQV8xnnxAMr/Apa0imGDTvqdX5hSxUhzdoE?=
 =?us-ascii?Q?Ik52MFARVRLfgUAIGdaQ3atJDyNlVf3CRZWGjjNaWdDLnqNMDlwllhlhqdjq?=
 =?us-ascii?Q?sWg68EUBExrjVnskWhGfznIsbhHQuR+mdrjPsc5Yd49XHYCSMCs/I+1b1Agh?=
 =?us-ascii?Q?SY/6sWVr0oFKv3IxVqDmZymdRQqvC6xmiZtSGAjMxK2EHMX+CjHc0qF130ok?=
 =?us-ascii?Q?C6JU7+otKhtXW/+mh5ZejS+U7QK+lLrM2Uu5+TUMJkfWoRdDrsdbJHhpPwmd?=
 =?us-ascii?Q?uFSEgElx8G5UR5++78Fw37HFQX6mth0dUICXZIlAkpcbIaSihS+8eahCNYzC?=
 =?us-ascii?Q?0dRli5vvypcXKB6OFJ8Ka7wsUNa2V0q8rR7NfxxrmsBHz2By/tDWSRQZFC6T?=
 =?us-ascii?Q?roDAq7oD6JMuU+w2bcqNcpk9/IM6EBX0UjTrkN0CjwBIp3LJ/NoIjUW/9kQs?=
 =?us-ascii?Q?0MO1V8EOOShMAfYWCDeWSH0NxLGfqpDF5lagD8GmPZM7Z4tX8oUEJew8u7hT?=
 =?us-ascii?Q?xAIipI0Ei0h1ZM12mK0dzdre8VuwKiBsaUESzL+68fR4xz6pqgv3G8CCuMrV?=
 =?us-ascii?Q?R94q5p8EzfAi3hLSJYFOpcyZRBAHuwzmsZ/p0FW25xmJ1ME6GrY6Ngn1tmhx?=
 =?us-ascii?Q?hpRocZgi3IK1f41MjExshyxxbECd8Uydh7W7bCG2d2AaGnbw57X/Yh9oMRc6?=
 =?us-ascii?Q?8927vaBR/oc2l5IaR845pCeIY7idd6n5oa/fM8OYWpjxnauVS7mHBXMPAn1w?=
 =?us-ascii?Q?afiAXo6Q0pG9OIh7Nmo13jiciA/xJ8gYYJPv/+qTRtLLscGcEJhkXjuftJnf?=
 =?us-ascii?Q?XGUqdVxvryiG75vvyLYT5qAv5LmcZ+JugFUXQ46205sO0qP0OW56lKhJU9aQ?=
 =?us-ascii?Q?g8V7lWXMPREU0F9c4HeoKpA6H96mNfFWyiOw8Ckmb0s+2lwi0z8CTbi/q6w3?=
 =?us-ascii?Q?PUWRxzV3ac8VdgepdJz0hrpaE9PISIX2jkRuvoAifUjrkn7Tkfgx3YS/i4WH?=
 =?us-ascii?Q?8tv0BGlD2z7dRPmdhUuWufhSVOy8bmUwdImCLAmIJyXDLYa3WoNzeFO9fBAX?=
 =?us-ascii?Q?+fRAfKn20A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d852341-353e-4ce4-6716-08dee9cff1a8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 22:07:25.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZmdYUTObyiVYCDLqY6FcR3ttpVOy22EsuCTrqsq/6wrp67MaC7Ff8gGyFqiap6Vn95fxTMF7iEs56ZWi9+LGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034

On Fri, Jul 24, 2026 at 07:37:21PM +0530, Shrikanth Hegde wrote:
> If you have already read v8 cover-letter then see only v8->v9,
> everything else is same. :) 

No, you submitted v9 in just a couple days after v8. Please allow your
reviewers more time to read and review the code.

Some comments are equally applicable to v8, but because you've already
sent this v9, I put them here.

Thanks,
Yury
