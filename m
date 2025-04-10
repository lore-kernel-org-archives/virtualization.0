Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35D1DFE0A;
	Thu, 10 Apr 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287016; cv=fail; b=VYQ+WEIkqbDYjiD1vZlJ9fMks1bXXM5OZRjiZDxbIjy5saLmTzbwfx3onbJ2XdPYus12Nov3F4Llx6BU2p1n8ddfegN3PNtqyeBJIcCnE6WJRvXyFaZ+yX+cbqXy0tjChPvu4YRQm8xk7N2zm/qYDf1Wlo3+C0rNvmZgJJzx2A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287016; c=relaxed/simple;
	bh=llRELljhZ8Uz/Dz+IL5xPOfNp1pm2HUUCVdxMnJ9q6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mt5W8cLndRTGGMB7ilh2q23Ow6B60iGHou9ZclB39w51tQ4WbzFphayT84CiQPgEjXZ+6gR8ruOaG/tKNehNU5GjmQXboIPDg/gmgGgkKCG9VTLGPqwMZztd+pdfGSPp6WcdUQjsBDMtPlkCOWKbs1w/BS/bVFl/19YSdJMe0oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M3Z2Lon6; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M3Z2Lon6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5Fr5MVo+/jBmNUj/Zl/z7bzvBxTWQcIH7XnJKT/E5AGR8HfRR71on8OahXqMGHK0Gm/IZ+wOZBRZjh5FcFsSmTK/UYAd+TsBxB/BWPSMiWYR4uAe977t6Od0fhOWVwDWOSmhwsO3vv8UKikzV2jT+eWmdB3n5iqdjSLdSztRWaJPNtAgpb8YGUXy5X1LAjtknmIlG+QKEFqDk8iDBljdqZ7pb9hPlQ+z93j1eRTn3ZFxt6zlbQ9PBhdA8f0Wy4TdmMeBKRTUNp1NMuulEtINj3qdxBRLeY+ZwT8sui316tAn5aGUUJW+ezCrtAXsXoBCjy75Ec/3BTBTN+HJIyGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP/lcNtXVIT7ity84GWaer9uAx5uquFC6EQkdIEgIxI=;
 b=K+Td3BzYiHwj217RI6PsnHFKbrcBs7gbPTVvmzRRPIzrukJrzWBSn8o+X79NCU2zQKjydfVpz0mKSYV91ht1epKik4M7pzwtUYkVKhtxhra4B4tHrBRKYzjpA4X0oKrDJHElSJpsqMessc9M0PwYxkhWdNjjJOdSBVt1jI5HH+xt1IX37uFOvNOEjBBSL5KmzfpuQAB1Sm07b00tpxBnJcDvjkCs8kqLW8SpIpMFOKjhwyx6xJoqsOp0aRuIgtFkj2vC1Z5clayqHBQkg077LnaV5PLhpiyNJ149EaQkwukpmqGLbhNzoBg9e56V3Mq/l9oZWQNeEh84oiheHLJQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP/lcNtXVIT7ity84GWaer9uAx5uquFC6EQkdIEgIxI=;
 b=M3Z2Lon6OtceZGlp/wcu0qoADepGDrOwgDbmV/84O9YD59nWv2lX+W7LLQ59dMyrJ++EK793Kj2VBBUqbrHoajdBkk1mZDUbab7UKwFbqxoI0zCoxUkLP7rTRyhBcOn1jQhk7ox51BVyxX04TgC4XwuWbq/gVC7syo0LknR3imXfNnA7k7rJKVel8bk/0YO6Bdeqa9V/4wMymdfnoVp9IVbP8IuJrif5pvpgBl0ur/vAh8by33OzcZiZAxh2SdhA8O0KFlCy2WNg5QvDgxVWrCiBwAJO3Hx5nJ6E2tUaKDbl4YdN2uSv/1I8IYZIkUw65+JPUuXr7Y4ZYE8YA++K5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Thu, 10 Apr
 2025 12:10:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Thu, 10 Apr 2025
 12:10:06 +0000
Date: Thu, 10 Apr 2025 09:10:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 3/5] iommu/virtio: Move to domain_alloc_paging()
Message-ID: <20250410121004.GS1778492@nvidia.com>
References: <0-v4-ff5fb6b03bd1+288-iommu_virtio_domains_jgg@nvidia.com>
 <3-v4-ff5fb6b03bd1+288-iommu_virtio_domains_jgg@nvidia.com>
 <BN9PR11MB52762A98AB82CD58C41A47D58CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762A98AB82CD58C41A47D58CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0335.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ad3b71-d445-4a8a-c278-08dd7828a1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C92j5+ohi1tI+haQgez8gYUHuWZ/PYjiuKadMaMSzeOQ1MZwNtOV6dC/QDK+?=
 =?us-ascii?Q?YriAQZoNTo1hLvjqEnXh/f9llVIzhYZvh5XUKNxG7+wMkKkXRrp9TzWN2OHE?=
 =?us-ascii?Q?9whuquGOyjnbSZZcmB8zYaWX3juLOy2iBKVQXNwjNU+Kafthhc/Ixpk9cXdO?=
 =?us-ascii?Q?eR0OX2F9NuUjYzn+99OsopTzHADQI+mlZFjevXTbypAiRgbNJ/13k92T47jL?=
 =?us-ascii?Q?ymzu98To4XWIGfcx7Vczh/K6rnY7x1EMq4c7n3gxu2zwQJylbAZcbJALnDXP?=
 =?us-ascii?Q?VfNGCDB9w6pKOFZba160/ycyonHmePSK/X8a+s7tDHHA56oW/0eoDsHDfC1p?=
 =?us-ascii?Q?uHPXPNmjvO+v0WxlWgmifQ6GYO1dnaRK9f4sm6lWa9nm9MZTbuPehoHatRKP?=
 =?us-ascii?Q?iiJ+FKYRYyIjoBVIviRVbECAAKNu47OlQYU7oUzoZYemrDYYSJLZihfzPzQd?=
 =?us-ascii?Q?zWb5PCZYp+rw95dIGwAYPMXRkkB/DK7SiG5L3ClF9FUsrltB68+Z5O9qSZq3?=
 =?us-ascii?Q?B+pdZEbezRq4Ih+UgRtrDG1nh9NsCmWign8FsoL81DNX6z1UH+TukVKaA6GJ?=
 =?us-ascii?Q?VkG9ZYHjlsi7bVaziqbKhqEhNTkRkp3QxFLtIXVWlA475Uvn4ECJeOcLxP54?=
 =?us-ascii?Q?N9zM+ynk/Wfo81kVX5SKh1ofsmFXWVugt3jO7GOI1rMG3d41rOFKolBnjz5F?=
 =?us-ascii?Q?Yc2IKmIpEIIp+oAwDG+xaJG5VVWADRXEed1M7uyLDUXQPG5ROzcp7XjMXKgy?=
 =?us-ascii?Q?CWPAxJwb5khIucz75o7DbmijoRrGzCAYh3hny2JWKYXvu5HastqHGQOra1Dx?=
 =?us-ascii?Q?XbZsjc3Hub8vdeNLhTAiTOMryOO5aKMtMMuUy5hx7aCTe+R8JiunXsiqtjg1?=
 =?us-ascii?Q?B18kLhSUXTmm6FkZN3M1l76actmO+W1qRzuo1/mK3eK2eWYCll0sQjqLzcmf?=
 =?us-ascii?Q?AQZDL1DDCtzQ0he+e3pj34JR4i2RzhdtD36Q1A4Aj1NCqW+7jSD0FiCeI/uS?=
 =?us-ascii?Q?jeGkSIukhuTj70iPzEQF8UqnTVQvkRHAMawNJj1BddEUJogCMZe2825V591U?=
 =?us-ascii?Q?VOJbra0XLNUGQoreJmvMvEG42n2aXKxD4SITMEkg8lsvBA196yUclua06ieW?=
 =?us-ascii?Q?I+OBVqlMohaAInYNXTDZe/yG8ZSS7b/isF3JQCAkmpYQJarHff/zlSP12PHF?=
 =?us-ascii?Q?DZUTXjQpOHk1bjW58BK/KD/YCS8ypNXEa2RDIaPW01hafA/Pm9WS5uOfbsE1?=
 =?us-ascii?Q?yfparoUENBy2m3JtUTeT/xSnYl9V7WW7mNeFkAT5nX+pUt9Y+RaWaIa06hKk?=
 =?us-ascii?Q?2gTX+iBQYl78xNknOr8CRZk5IBjKKrxex2kqgDS2efnmAw2dWZgzMkIOdaZL?=
 =?us-ascii?Q?b9KGA5rKwS+GDiE86Ve8DPp2F6ht1ewUVI/4hb3f72hLry695qVMSDaolQLz?=
 =?us-ascii?Q?sXZlcTwLz+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AtgSUlWrK6x1ifHoJ5P+JFTJaMG3wJamn2wWe+eGCDQvoPEK6eClTryhnY4H?=
 =?us-ascii?Q?WgbpFGjezGQid6JCpVRFdcyWhziiCTR+67d9Ux6YbJqfiDtzWq06l61cEEem?=
 =?us-ascii?Q?eTpFeiG3L1lbwGesRZMCmv/fmKyETD+XmLl9JOel//SVLe7wgLJzPlHlK9db?=
 =?us-ascii?Q?nzxbQPZGz/8UMTUF1lx6gkpzX396AcJX4vj2y8ZRHk8d0Bcslv80BNOKo8bS?=
 =?us-ascii?Q?h1dlddQ3RBk1he18/qqCmjThRsMEP5t8ZskcUHAoeLWwZV1shdtTUsvdLGzf?=
 =?us-ascii?Q?PmV4yQeyu9Jny/cdVtj9mORiIqwdxJfXBLDCMc1WZk3OJW2SOkcgFiwGlvjP?=
 =?us-ascii?Q?MzgqvVBPKpakU0YaKqfcXVvBD5pLUcpIcwlDMgHdj0em1gwL0ydbx+m8p07o?=
 =?us-ascii?Q?zji/bysJXo2NYuxwDfU8XWido2ltwPKPcUzmdLM6DX56G5yTK3e+TSJlbtMl?=
 =?us-ascii?Q?A78j3Vd6lpRvkLyIZ8U+WZ0OquBlM3H7WyVM+aoUMeGNGBm+up0tE80vfWBt?=
 =?us-ascii?Q?ScmnhMY8AC+BSh8z491HtxJx2GyI/vz2EBkpbRH43DAm40IHhzFuJxRnMnwt?=
 =?us-ascii?Q?Q6I3AwlTeHX+8/EpFiJzSkFU9o3mKHo7Zdo4qIlGQn/gBytd46uWYJWUXKVT?=
 =?us-ascii?Q?6oeQQwkqYjnpvHAfy9bdg19jcf5haGcJvMmIqymfK1X3QuxvDPd22dA5RIWj?=
 =?us-ascii?Q?ovYWg58DUwOEfKVA02acRcJr/6Sp9oQVfp1obhBsZYUuecLzupw8fsHa/1nR?=
 =?us-ascii?Q?wtK8Zt4qANFuVnz9Jq8WkK692TjQRBusw083rFmCEBM/LT74cv3aUC5hfLT3?=
 =?us-ascii?Q?DYVYYEus2XVLI0Y/sGjTFiHQoPkN0S8soRvJtFLC2XAmqcuKi40q0WoslVAK?=
 =?us-ascii?Q?4Gj0SJfhwQtR1bEysMtjwLiDfcE5vAAQ12669s6ifrzJbIjp1Nf62JMOvnL2?=
 =?us-ascii?Q?T3PkyWkQhyekaJM/J09T53gdtfTAhZ/1fmcCDd6HvKSjKB45dsi23sUm6GiN?=
 =?us-ascii?Q?vAZgF4CykjhD7QT2ZNWeqM3lRkyxYPsqqBb4ysFxIHG1Y5B9LGTeHLBxSBDF?=
 =?us-ascii?Q?V+AdjHXGzxa07FMfYGtWIzUZV+6NX0DQVNIazH/hmd6tydqCDtXyjIE2QrIu?=
 =?us-ascii?Q?Qyve6M7ngVADFx1+Kd4kVMgcld00JWAHVchohZ8C9Az/rPk/1thykOBryn+q?=
 =?us-ascii?Q?A7FOvFZJyi9LGX5jV7jIMdr+CPZOovPv6zhRlLUnetE9Og7UYwKd65EJy+jr?=
 =?us-ascii?Q?YGayk3OevtFv/LVv85LOrX7y3l9qhG0VmXTknXrjYMlhD9Dpfw1EJEcA3rWC?=
 =?us-ascii?Q?RzKx+XITtDun37P/qVwWrFKrW3uWTTeS1kFuMkZZ7DQyGT7Vio/qwbz4XP5h?=
 =?us-ascii?Q?xXyprYX3f8C3Z7mWQcofo4swg/GsKvTlqcRgKrYlprewzC9BBxQGTuCUNYmy?=
 =?us-ascii?Q?bFoU+/FWJpziA3fBjFJ/T/01pVQCdphMP56tBX74ML8kFzd6YCqMDMHe/bIF?=
 =?us-ascii?Q?cfx6ZUMkELkhe2sW4B6V/q4eCgG5uxk+hfNy4WPsC1Uustwiu5N+y40nZV8G?=
 =?us-ascii?Q?DVb++QzJfdBjoNHjZ4TJjMkEqspC2FQFQvihenon?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ad3b71-d445-4a8a-c278-08dd7828a1a7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 12:10:06.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pX5xXc/3TCltF1adT6VLh76ydQSWfFHs4PbGl0ROJJIZNn2171vHpWI5ROPewLpP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170

On Thu, Apr 10, 2025 at 05:55:50AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 9, 2025 12:36 AM
> > 
> > +static struct iommu_domain *viommu_domain_alloc_identity(struct device
> > *dev)
> > +{
> > +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct iommu_domain *domain;
> > +	int ret;
> > +
> > +	if (virtio_has_feature(vdev->viommu->vdev,
> > +			       VIRTIO_IOMMU_F_BYPASS_CONFIG))
> > +		return &viommu_identity_domain.domain;
> > +
> 
> Does it make more sense to keep the @identity_domain field (same
> as all other drivers) 

I think having two ways to get an identity domain is more confusion as
one will never be used..

> and rename this new ops to @domain_alloc_sw_identity() so it's clear
> that the new op is only used when identity is emulated using paging?

I think no, we had some use cases to return real identity domains too,
like DART can use this op to runtime detect if the iommu supports
identity.

s390 had something similar

Thanks,
Jason
