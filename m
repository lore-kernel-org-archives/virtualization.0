Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D624E4B5
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387885; cv=fail; b=eeM1JT+58sjRKSUbkqTMEvmAYyuGYgsJi9e2yfg9aCa8XvcZRcjk3BNgkIbCZeMg3NtAEqfx5MT+KM0bppVfl+BTAnhMQ0FthzQw4xT61ECthP5LePwa8h6teuMIIGQ5MYSvnYsMnh06JqCkrPDoSJzsGHf5HtZbO2Ycv9NLZVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387885; c=relaxed/simple;
	bh=6sywRa7aWVjoQ7Am7A6YMHkCYq21112bi9aPd+RteLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=II28alI5uMBOAr9CfDVMA80xFtjSsaO1h+MCifU65LFtGgSujox6H3tmnuDn9BvOMRYfQlAUnYyF+0AdIuYi7w47p/LTNgKW2xM3KWzTgzOiK94KVFdGPQHPSRJ0meYWiPpGsVK2FkwKQyw6+y+l2df17icQcOIdE2TH3AvqSlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oDOhsDq5; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oDOhsDq5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhD2FSmmnCTjxpaxealZKTxb3U5fuCpyL5OfNd5dgxt+ySgrNzDncEfl53SjqWTUcxJepmpIqy65J5mfXYUJleon0u/Qns6M7iJJJHeB+Xl2mds6HrN0D9h3zJqNbWruHI6tDonaj41MHpWc8Um/sVfb8dfQjLIdVicChARCS4zUVMn6a4qujD3vCMZ8V6rqfRdufNJ/yVbclLa83LmmdATURdGw4k9KPugNPjvXAjYxS275LOXHZr5vRZPL/mnREO3T8h4VPeVcdDceVA6qiJnV3Q0ANAokJjtexE6lZpGeNEuBkxNObhOLSnNmnw+NxRvSxwoNsb3UYsG+80xvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QFZ8gPETv+VVwdQOxXci49JNdryVbQAdIt5VJX8BbA=;
 b=Exk3UFYiIxi/qwubPpSFd7VBAdOHSMOD/UQ+BlMSXsCINjk1KEV8YUeT/nDsEVV47w39QxEXiK+nKX0beF73tOX9eapqx/50WH9fwdMfA+qmQ6/CmqL/n2Y3An00kNpGM0FBXE2Q85PYq06zjkMxjP8ReTrkdK1DMONdXoJYXhhxc7N+3KbMKCE/IsGS7m8RGuWhMHRJXtUdIQHjjUDc+lISq8SV9VL5vq+xsknc3vuAtgM3dn6fs01eCzXVJIzsSo8QzqZcuWOewS7K05qPwQWtNJ9ueXFAw04T7nk7JGOw0ZI0BAvHrHzquKXsVZpP5XmJqYU3ZxVQoM8+SIbWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QFZ8gPETv+VVwdQOxXci49JNdryVbQAdIt5VJX8BbA=;
 b=oDOhsDq5qgur9HKNfdYiySYx0LeJyugdhoAJ7IcmPyzX+TEy/+58jpsMnDvcxV/eFvlXPD8ax/ca5w9swumLBf7VI2r6KZOfzUvb5SV6faL0tJfQxsPGZWj6J1eFdD4z8cu5ZnT2QwnGffw+cLei8kkUQUlClfiynC5U7b8mWi67gObT8R19c1FDLiQVN4fgReXtOSX54n/aDjYxiqYzr9tgQYJkY9viYECUXF4dYXoWglQfi0ouaWDGrwDFWKHuQ7NUdzFDgCluwL8/9IQy9Hq7cPN5nkqZI4k1I6XYUCVtO0dWc83uonFXI69oZKfFw9c9GULpux31OZ7T6N66ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 05:04:35 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 05:04:33 +0000
Date: Thu, 30 Jul 2026 01:04:29 -0400
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
	virtualization@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v9 01/11] sched/docs: Document cpu_preferred_mask and
 Preferred CPU concept
Message-ID: <amrbXSiJOBbGojhK@yury>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-2-sshegde@linux.ibm.com>
 <amPc_DXDkeVawXS7@yury>
 <54af8965-f0bf-4424-8b41-609c914bafad@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54af8965-f0bf-4424-8b41-609c914bafad@linux.ibm.com>
X-ClientProxiedBy: SJ0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::20) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5b3faf-cee1-4a89-fef4-08deedf80ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|10067099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	DsuUTvMydgtDMouyE5y5//jVInSbjtRMFN3yGwKernsd5wlU7/90IyVjxqUjpecBEMC6pVX1GWTMEWN5CnAOeZCSTLTY7/dhzPkDfE5C4KNcrmfoI5H9oDnTFZ3IYwCxeoEUkRR/feIZfVR8YlqzFBwOOTHsoC+7L0TkuRlA24KFM5tPn8U+QuV0vfIsaiCRXUctelzLTn7X4hlYsiKUAFuvgDnLJ5GRXV1zqnWpY8EI1vDVS3UL4QOUM+73OrsX1tSsgMk5w9rsOvkg5vPR6XEdbu+eY8O/yD3ZviYphLelUe7XXD2vueWfHbHndEzA3NUc4ZXGVWuW4ZHQ91GFREGj1i+jhS9h/EixCNQaoQldsJds2zm7BxQYls6oW6cPDFTxYICzdHXfvJFRAAxIg0cYNKS4fz9UhSLb9jk5zvSeLKkdh+0Viio+0upO0+jBrXvmQO0rXA18gBXg8fcM8NAJsNp6NiOND8WkfSacegGoOAVOnK3rNa5K/tIxL/84DI8nX5duWkp4U56/RUjO70qo94qmyZVSAQ06HppuMQu5mSXUqSYkNorXdW2sOlbYP4kf/CPsq99Xy6eV/dou+veYlvSqk4wZ4DuChLMdOyc/S+wk4Av43DLRIehQy6epBQMWjMBlDJCOqsg5IqL8JwgBrr4sI7ICrAMc1Rv7JAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qp/2KjJXUGSsCxBMdzN3ZZ3mYPcH1VSz1Qe3vUZMwsG7R4QYTi2IDqZk1Ltg?=
 =?us-ascii?Q?LywOxyjVA1gaC21fWDqRahY2bfjVCqgmO7+ltlh/BKU0VyRpAmC2XAb7DfVS?=
 =?us-ascii?Q?iOa/V1UQxQNQAW6i3AwISQvtybROAtwg1+klO4Ta7iFNdPnb6LlVhXWGBXzi?=
 =?us-ascii?Q?0eDH/gGWYQ7BrayIT1FVOLEGMHc0OWW9h3NnIv3A8g/+ynX5uWlC913euFfQ?=
 =?us-ascii?Q?B8WTLuNIxJDV8xa/B0obWNKqqnFhuWeVaQhON8IqQeRA61U9Ch3V6thpj1WO?=
 =?us-ascii?Q?ZhSVL6A7890CylaPlnA2c+5WvGVRR0y9216Dtj3Zg48mLQxhCIYyyz7gdspS?=
 =?us-ascii?Q?ZxYtP/KtsC5JScInmD+QMJAZ7UqrWIhRL04F9jip8GbcHii7WUfkSLndk9SR?=
 =?us-ascii?Q?gRlVKmsUtCF0aonbNkBmpSJtpNvc7lVVvfGJmWos/AfaxFjDlb4QckuTJSzh?=
 =?us-ascii?Q?lL6EEV+q3N4wFrC31CBEvI3V00Bm4QNLWAt2IG74YJjxQgNaUF6zSBAKlMUa?=
 =?us-ascii?Q?jO7yoQs5xKKl9YJQDKA/2ccvmbdYYMOTBnIhCDgZ96nGcM4M9DKL+zvcHnBi?=
 =?us-ascii?Q?D/vlmhvEb4cwZ5tr0Q4Zj+IJ6NEqcdwi5GGQEvzrCZLcYGmAqv475B5gUGsQ?=
 =?us-ascii?Q?Lr9Z0Oa17Sn2JPnTwiCiY0Lm100/23bHQIOmVUhrxt9tZYGpxQW5t0Vq5Kt/?=
 =?us-ascii?Q?nQaSaaCqntqOwiFN4Cfxnjt527DIO2jPK1jcPdjPy7GJc3vo5AoKJ2uTh/O/?=
 =?us-ascii?Q?xcUF8tHe8QgeZ6UgQcuQbipxREUT5Oo+Gs4uzGCKcjZaea5Ic81xHPH09vKV?=
 =?us-ascii?Q?g1C+htrs0I/4Z3qOSQc/FYZUusLnzKh67Wl3SfwBUUolXDnNaHs4teGGW/69?=
 =?us-ascii?Q?BoEAtWLPJZxONzdD1J2TS1ElziS/B6OfkXGPmnwKiffV8xgSZbwbJrOMRknk?=
 =?us-ascii?Q?0sSuCrctVKwFabHUwS4vk/M6RD+JnNZgNgzIx/wAqmfp2BtUOBkA9x8J0urb?=
 =?us-ascii?Q?HT82IftDofdc3iVh7zwqCLl6/8m869BeEWzR+xBCJzXEPox2EaC96W1y7cTm?=
 =?us-ascii?Q?FHpHALn4CGYxqPk1gVk7xUsVBemIEfVWgDUJkk0841Gfj/Y/qkA02T3K4nR1?=
 =?us-ascii?Q?GjfwhQug11wtlBIWDM+jhpAwHmfH7xhsybuGPJnb7YdEQz+MlbjZr4+if9ZY?=
 =?us-ascii?Q?ZtOhH6onrlFby7SYd7PsYp1mctqZxNZc0nJnqHHE5dXkcvFNqDa3WDfNYFz6?=
 =?us-ascii?Q?JyrgBgL6SBTjlFjWfRB2/nnjB5AsTXGyCHhHDBn/kmd33145Q7zkiv3Mh608?=
 =?us-ascii?Q?feqBh4j7spPBkVDkvWtYgb7TrnpVHeP+4PReuMrCWd4n8Xr9g/sO5i2RwPEv?=
 =?us-ascii?Q?CDz2THAWYfg2voaUWu066KEkA+gYDOonMB4tCTusrT87qQYV2fV8jI3/9PR9?=
 =?us-ascii?Q?FyAXormPdewIBNhkN5eD17VLeM6wU8hftg71OW9kQbDjCcTdw8BEqK1b42yp?=
 =?us-ascii?Q?lsXybZLN9NLlUaKx0s/TuKWB5Syoclez70MopgaAY/oCWVgh3LXF9LiQHyi7?=
 =?us-ascii?Q?db68LY/1E+g2/y4dptgMFt5HoBHIBI1QnWQl4d40Egjk8cHhOsS5PKMhKkIS?=
 =?us-ascii?Q?JJ5T4SL5SnLj3fUDeXt6dS5h7J/YOdHcDqJ/rlqlUIh1zr5RIky05YxZmeRR?=
 =?us-ascii?Q?CrHml04XlYkch1S0ul0Uyoly27y1MtbbSbdcCsafYfDlGWNHNj/01aYSrilk?=
 =?us-ascii?Q?zdyBlOT6rA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5b3faf-cee1-4a89-fef4-08deedf80ba4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 05:04:33.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7akAXIn94TC85KGcL9JXJmxm1UHyuKojXAhxPcfGrszm7bR5Ujp2fW0/myf0qc4pPJRVp18jSF6+mILh9R0+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

On Sat, Jul 25, 2026 at 07:52:24AM +0530, Shrikanth Hegde wrote:
> Hi Yury,
> 
> On 7/25/26 3:15 AM, Yury Norov wrote:
> > On Fri, Jul 24, 2026 at 07:37:22PM +0530, Shrikanth Hegde wrote:
> > > Add documentation for new cpumask called cpu_preferred_mask. This could
> > > help users in understanding what this mask is and the concept behind it.
> > > 
> > > Document how to enable it and implementation aspects of it.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202606180717.yNM0yb41-lkp@intel.com/
> > > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > > ---
> > >   Documentation/scheduler/sched-arch.rst | 58 ++++++++++++++++++++++++++
> > 
> > And there's really nothing arch-specific in your series. Can you find
> > a better place for the docs?
> > 
> 
> You are right, it initially started as a arch specific RFC, now it is
> completely generic.
> 
> completion.rst  sched-bwc.rst       sched-design-CFS.rst  sched-ext.rst          sched-stats.rst
> index.rst       sched-capacity.rst  sched-domains.rst     sched-nice-design.rst  sched-util-clamp.rst
> membarrier.rst  sched-deadline.rst  sched-eevdf.rst       sched-pelt.c           schedutil.rst
> sched-arch.rst  sched-debug.rst     sched-energy.rst      sched-rt-group.rst     text_files.rst
> 
> I don't think any other file in there are a choice.
> So, I guess I need to add a new one named sched-preferred-cpu.rst

Maybe sched-paravirt.rst?
