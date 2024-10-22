Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F919EED4
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Oct 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608786; cv=fail; b=u1onSeiBlFAto46azQvmS8lgHNIAfgi86lgNgt6Ig+G5vEvrgg2NtKzy6MKqD5zOc6KSLMLbG87g2EIzUvBICpQrSQHlRXo1Er2nxrVRug34LBrgEq4PZ8IO5gJY1ktdKJeTi65CFjoXvEwXNKQ/czPBeXMz9q8+xvSyXFlwr6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608786; c=relaxed/simple;
	bh=PqdVng3kb8WPLJp5NolgDZzLGcJC2LE32ClwrxpWGpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=apygRIb7KZ9VY7E55W2XZpOGk9KWSsgekCSW9BrZhiKp4lY5BBHLNivq9HfX+s217WQPpRdLA7OpGar83kXIuAv0Q8f08Wn0w2QGcSkxDWNPAJx0sqHk0OlE8BknipsBjQ/ll4lJFLUiDpVBW98aoy5QhkWq1ZdosA4JycnbrcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qB6fe6z3; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qB6fe6z3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21C0A60647
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Oct 2024 14:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87A0NSbrGNLD for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Oct 2024 14:53:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2413::613; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=jgg@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1517760604
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1517760604
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qB6fe6z3
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f403:2413::613])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1517760604
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Oct 2024 14:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx2wRKw/bk/zoYxa0inVSJ4EjJRezUtT7MQAsn1VVBqQPaJFBmx2ClBNE4eP3Xef1uyRpVKItU+C2bj1i8mfMhnE+zeKzCe0fe5hNL8E+frAh4fRzU+eP2V9SqFPMmWdmaNEYYz22bvHODDKl0rHagbyxW27jwQicd/cNwtnuO9LO7EmdAFMOOe3fwX2FK/gquKzpWLG8S3kWmrCTIwDJYmlRlpn32M5Yvh+pQ4fPAi8hjz4Z76m7JCmQhovStJ4y0W4ZilUl33xnBKSgaF+TgicTZGhQXJvKPTOVQ3rBcfMHyZKggaD0lRFNgAhZU6fneUYRwtVVF/X2rYQEjMgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGfZC34DWOJ2NxlE2XP2p399NWYYPHQCn9u/AK3heZg=;
 b=IPHnyxEfP9EYXmCgcG8LhoqksFRXgbSPzc+fWxKzW4gkCkE82GWtcpVYbzkMK0iIlZrzhj74nKjdeDmBUia1ceSwHrjht2xud9bgfQ3CK5kyEzJWJjt2fEvdCw6gkYYLMPtEJodQw/Uhc7H6fjTYpi/mpFfoTE79zA8B0crwy+dilzqEn0ndrU5yxd/SMTEm9addoJrT+rl4IusOu8wYQ1vcIyf3iUowDX9atAJtBC1xv1VEKMKtbBoZWn1LEt48x/8P1vma4W011hCtw1xQ8X8BDn3jtSuPCuyO/m40iWOJwMRnwF8piSiv6TvjXmmPggVXr2pZ/e6mvPJQaN9YKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGfZC34DWOJ2NxlE2XP2p399NWYYPHQCn9u/AK3heZg=;
 b=qB6fe6z35w+MRhmh3NBumR65bKd/mdeU4BCNBLhEZpyfglKmXOSo4N7am9hBWKtiP95ewq9fVk13Hg/xHoSHLdrHFvHJ7E2lPj5utanbHx1705Zrlu++pBl7WZ/fDAoNqoaCgPCTAi3YZctRtEpXeONSpBPeEZUtcWG9/msbpnHE9/Ft3VtPY6A94IudEDgPuuG3uO5SWRgskMpBpqvDTo8uneVh+O+3EvmnTpB5IvdUzu+4OIGAgv4MxePWZDsKUby1fF63dvaW2PsfRLMP4oxrPmaqhajD+i0013iR6HQL/2puKS1JNEBMDjXHfgcds+baz4rkWFC3PFCU1nVDsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 14:52:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 14:52:58 +0000
Date: Tue, 22 Oct 2024 11:52:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241022145257.GB864191@nvidia.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <20241018135343.GA1914429@nvidia.com>
 <CABQgh9Hd0QCfEtVcMyXG+=KHuZdGGUA=kk5iL_ysOzfOpLh=-w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9Hd0QCfEtVcMyXG+=KHuZdGGUA=kk5iL_ysOzfOpLh=-w@mail.gmail.com>
X-ClientProxiedBy: MN0PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:208:530::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c94645d-c212-43dd-909f-08dcf2a937d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?//BtFGUUuZEg2cYIEw/TJLDDe21QRvHVvumse9bx5IK1oQiYzUjEVCFa7JWW?=
 =?us-ascii?Q?dVkLgu961A2HRXLJDGdkeFp1Zzx2tj1vomBu/A7EjU7C5tLhkNSehtuFeeem?=
 =?us-ascii?Q?84WewT77vuiSaARGX8v06gDSmZGCeg34IQJfrqz9ulHrAQ6x1VZqAqQ4dEuT?=
 =?us-ascii?Q?Br5mNYf2dMQXa9wEtdFyr6DM9OI4+ag26U3SI9VKUXlBmx9P78hZUviCAg1M?=
 =?us-ascii?Q?pNxjKHcB6DjbhJwF5hPBxdm4uQX+L8lOiFWbScGIYJReNGUmvJXyXi9+FUnj?=
 =?us-ascii?Q?CeNBynpYdeQZCIGY3gjXeomEPZ5bvYR/7GeW4CCRiDPgGLqcGOVXRBilneZ4?=
 =?us-ascii?Q?iB8+BRe/CzNfxTpoEOwdYtOJT+DGKoLtoXZuZGW2yC9z3EoJA2q/JD1l+YzA?=
 =?us-ascii?Q?y97x9gDj2AE6O48ujNi8HsgF8SHyvhBrPwLOMnp0knvvBLzItHoVLMvfVtCj?=
 =?us-ascii?Q?lmMS81XEcQ0i8/XYbLwzXovbF0N6lrtyNHyZjAbhOJ2s109gbYPxAmc22cr7?=
 =?us-ascii?Q?NRDRoq8vLUnbozys6Flkv45KIawzi02wctDGr7U51muR4Kkx0HY1qqwS48es?=
 =?us-ascii?Q?5K6nJ6obRxyfbtIKtPUB010XLZ0ViR+CIPHYXenn5/iwEG/71dadndb+xrWE?=
 =?us-ascii?Q?fsz73GV2ofSF/jgdH0QVLXyxThXEILQj7JoUmT6RYUIJpKjxVvtopm0vhRH5?=
 =?us-ascii?Q?HpaOei9R2nz3IjUkpw/aLZWaHOPPpOi7oZYWQJIv6uTNCfkLfC8cbKU9e3c3?=
 =?us-ascii?Q?BJiCFItuB5uCC+sStpJUhk0WJLyMnXRpUUdHuixitz2QarJCDuzKyn5FfB32?=
 =?us-ascii?Q?+rj+Rcr7D+drHY8ylJg28J2bPK2HF6CI7UrB1Bsn6W+BDeX1zwbv6GEJ53wg?=
 =?us-ascii?Q?7x+LMno4xhhXHH9XXJKJxqj9wMfEZm13qBu0X5tP/4dZOCLRmGTIF9iOy62i?=
 =?us-ascii?Q?eoYeVHAEqSpLJ+yiBQ5psafnPyv40Q+1Z/qp7jZk2pBSYYLwsqSARif2IZxG?=
 =?us-ascii?Q?QpR7EMJVYMCNrgIMFWyrduI3NOgXhdqITTAbb1zoUU9UzJucBxL90Yx04ExJ?=
 =?us-ascii?Q?BsYBPCcWp/GoggIms6dYPCtpU+RF3MhuHz58NEmznjyJgRETke7aS6qZ8XeS?=
 =?us-ascii?Q?inJLbYcPVjuKWbY/ZKS7hv2dbVhVfbcAr5qRl/FRiCqXEGs18nsgEcdUo6ZX?=
 =?us-ascii?Q?gFrTSGeYBRLHAzuO6CaAMv3bPAF9260cr/xjnMa5Z4ZW9LPX6mvXNEYvxvMD?=
 =?us-ascii?Q?uPhKNiGMffsUmXtJi+yuA01ACv4UGNP1AxqYoKElhF1oIwJSsmjJUpPiuteC?=
 =?us-ascii?Q?C+VvL1VQcpYhZYEnbfMZu28e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgc1+JYUTu3tQ9ZGYIHBFS+JjljSsWKGhg5TR8kQqPNjU9BaKqoVKi+yJkqI?=
 =?us-ascii?Q?EkCYaVc3G2WnidT6vxJbwKF1l/rWrYE7NwOv3P/4+wohEEr7TUcy/dKuv9xB?=
 =?us-ascii?Q?fmH6JYOKAudxikyxPyT0Y18DCNHKU7PIBl9WtxEyROK8F6h3+J6tMlVjFz5f?=
 =?us-ascii?Q?8m9DXnLQqrgBH4qRVkMpEJgeSRBxU56fUq9JmRbVE8jCYH4aQdWlU23G97kL?=
 =?us-ascii?Q?/xatBmfeJVQ9A2gVUOR/xogvlekAbR1NhDeFK+DYEkO1kURaYvwi5nJSjmoG?=
 =?us-ascii?Q?wYzfXcCPjwn31TP5kyGzS08WF4Tpw+MN5gEDrwPZeMzLTRCmgy52jXVFXkQI?=
 =?us-ascii?Q?hGfZuhC+FJGjpNge9qKXX+lFywgfdZ2qePng84HxSwJbyGBHKA6AqAZ/Dwwl?=
 =?us-ascii?Q?Z4QEnJHYs49GrcPcttCOFo6VN3rsntDBORE/V1+BYPwJ5Ax2my/hRFdC2dR5?=
 =?us-ascii?Q?h4BpsN3fj2Nns3VkC3ROkvphiAbaz0hWdYqfOHer4rEbfGmy+OFKnNNtCzhm?=
 =?us-ascii?Q?c4Z3xwqxI6xrKkXa6gOij+syc+Msvq7fPWqaS5o0H+rXWKXdJRGgl4C/eXhK?=
 =?us-ascii?Q?sdoyJ1wqM7ioNQGzywWFnSUGQkNQgZDVRJmHnXZrdKxZo3s6gHc09lw6rMse?=
 =?us-ascii?Q?kCkNFNpWtfmaCsU441Ktl4LiZUL2OPdymwvX68G8M3ROtaFIDnPIUKTMmq0W?=
 =?us-ascii?Q?gij0k9mXY4KRfu2zhStJw2SQF6Vj1FyK17s13Fs0FaBw5VdLa+BC5wqrEB7S?=
 =?us-ascii?Q?IU5ezrQemHR5Nx5Ip74rmbucRNygwQXqehNmOERm6JU2UdJLwXb+W4Y2Ke9t?=
 =?us-ascii?Q?RKJZAraK1nU9/4w0HXBEJ80K+gvpPHZymgITHs7lxuu5nXatD/pt3YE6SILp?=
 =?us-ascii?Q?Xwm2XmlmtxEfX2L8qJrTXYAZ8xW3iIkbHQ9t9NaVtTdYkn4Gc4RhrMBGnb0J?=
 =?us-ascii?Q?S+Zin0+g7E710+yMxkRONjeGIBH/KgUE5jXZNFtuubwYqv3JN2etxLSzJlXi?=
 =?us-ascii?Q?43SlTQWhOmkWYzmaxX7sr78He4aK6F7b9OWa5dsKobqrrroQcpLVpbKmsw0X?=
 =?us-ascii?Q?PEV0Y680UPmsGVZLEA56g9jbFRO4RJxsnxurz1Bs/DxdEEU1kNSHgHxuxIhD?=
 =?us-ascii?Q?jpyuTKG9oLM7sP6LP72qJPxx1WN5z2mUI1Aq1zrWyzBnDR5t26tNPpF5D9bB?=
 =?us-ascii?Q?1Ki2BuHg7NtNo/KjY/ghbk5z94m/p4USB8V+H2EXcIZnSg7tn2TofW3zVSAq?=
 =?us-ascii?Q?QvbsPjXJjiHD6vtxe2YxYWqt8twuTRAV/m0ZVHltNFI145cGQmHeZrQlE1Qy?=
 =?us-ascii?Q?GSdaxixIW6a0WCQVODJYPM2LNY7XlYsd7EGpaHSRcKtzYZczG6nYFkRrtDPN?=
 =?us-ascii?Q?l5k5glZNp/UbVXPd7lEiKg2Lq0GdWw04XGW0M5mZepKvoF/pFRgnnkY3SCwt?=
 =?us-ascii?Q?2C1gScNIm+cAOHY+RymNGV3NNnONN2z4tx/kQCyaHkhUEX0kRew1d6c5NJpR?=
 =?us-ascii?Q?40cwVx22B4RrnnLRyqQQcelhTvGIoVidNWyxkIqV84h+MEEzi2TnPk/gbcI7?=
 =?us-ascii?Q?bXUXAFIl5Az0f8Tn5PaqzkcapINObgyrX6ZPYZtr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c94645d-c212-43dd-909f-08dcf2a937d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:52:58.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpxMoVbmtxuLqBikLUNE1ivztL1EJMDpvgDDH6VZeulKKyFPan/NFjuQWnXcxD6S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920

On Tue, Oct 22, 2024 at 10:30:10PM +0800, Zhangfei Gao wrote:
> On Fri, 18 Oct 2024 at 21:53, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Oct 16, 2024 at 12:25:03PM -0300, Jason Gunthorpe wrote:
> > > > > smmu-v3 needs some more fixing to move that
> > > > > arm_smmu_master_enable_sva() logic into domain attachment.
> > > >
> > > > Will think about this, Thanks Jason
> > >
> > > Can you test it if a patch is made?
> >
> > Here it is:
> >
> > https://github.com/jgunthorpe/linux/commits/smmuv3_nesting/
> >
> > fa1528253d2210 iommu: Remove IOMMU_DEV_FEAT_SVA
> > 5675560a272cf5 iommu/vt-d: Check if SVA is supported when attaching the SVA domain
> > 94bc2b9525b508 iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
> >
> > Let me know..
> 
> With these patches, do we still need ops->user_pasid_table?

It makes no change - you need user_pasid_table to make
IOMMU_DOMAIN_NESTED work.

If you aren't using IOMMU_DOMAIN_NESTED you shouldn't need it.

> if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
>                 attach_handle = iommu_attach_handle_get(dev->iommu_group,
>                                 fault->prm.pasid, 0);
> 
> // is attach_handle expected effect value here?
>                 if (IS_ERR(attach_handle)) {
>                         const struct iommu_ops *ops = dev_iommu_ops(dev);
>
>                         if (!ops->user_pasid_table)
>                                 return NULL;
>                         /*
>                          * The iommu driver for this device supports user-
>                          * managed PASID table. Therefore page faults for
>                          * any PASID should go through the NESTING domain
>                          * attached to the device RID.
>                          */
>                         attach_handle = iommu_attach_handle_get(
>                                         dev->iommu_group, IOMMU_NO_PASID,
>                                         IOMMU_DOMAIN_NESTED);
> 
> Now I still need set ops->user_pasid_table, since attach_handle can not
> return from the first iommu_attach_handle_get with fault->prm.pasid = 1,
> but the second iommu_attach_handle_get with  IOMMU_NO_PASID,
> suppose it is not expected?

The second handle_get will always fail unless you are using
IOMMU_DOMAIN_NESTED in userspace with iommufd.

What testing are you doing exactly?

Jason
