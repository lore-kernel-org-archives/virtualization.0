Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102E143C5B
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720135157; cv=fail; b=bGA2MS3JlQiVAi9QuWzHxSy8xAir0xhl33XmSPuDp45qnoRlovmuvTGt0qzr/HL/mh+WDyHFVY9DFoengwWPFeFLDd2XO8Jp2Vhlq4ZsEhhO1mrJ4OfYmaJnrxVBTxLYBZScaXmgj0SzixSVccfqKqOK+//i0oljxVzlr7y4HsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720135157; c=relaxed/simple;
	bh=lzXfi9ZflQSFvZYdLvpzIdw/echpmjiY+zo6edEzVbk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZn8HDiUs3G1oC2gALs9BYXPWquSqGk/K7ju5rlyOfc/xILgIvMb7MOCO1dU8+QuUbsECnwAmcG3EZ1+bLkYbefeVn9qHx3ceFamtQvgTuUlFdgS1sCMF6jEYu8lNz7bnmJRKIS6edSKn3oPHzttLfhnyPvKXOivsrcYQn/lcgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ImfJbMA8; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ImfJbMA8"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1A66408AC
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 23:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6hBoVp4cD5oD for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Jul 2024 23:19:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2405::600; helo=nam02-dm3-obe.outbound.protection.outlook.com; envelope-from=nicolinc@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5540640025
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5540640025
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ImfJbMA8
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2405::600])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5540640025
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 23:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWUPN5D543G2W8RNS2PMsfiCjxK7BIpmtis6BbQeYwgWW9CUkv1K/d4Nx+w8B7YOYB2DannZqt6szlkUOUFjI3b33Xai2eYYqzTNumnWjhkRdc6r+ud+mBk/LBdyI/Q5pYqr8e/gNSxBuXEn1YRWrxl4pkmXtcMm598aKaRVzQhOgSbnMYAmSQddACQQt88XheKrZUoZpiWgBjUGlk0x+o7nMljlRfCWRnXpC44UortsFviAEcwawwUk7/em8ZO8ucfG1ZxKNOi/FwGx/enpDgrJY4yKxv0jJxJ/Ed2fSRtKwuSNZqswpYhiEfqUWmcuanWn128V3WiXNE3te6JHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilbMOsbd+a1Wf0jibFOMfvmsZO77LBBjB/STe/h1tZ8=;
 b=l366e4wUPljWIzKvZNMMzAwJPrI/R6oELILZkWtKtmnYOF7Mf0/B+WwF63x6IX9c51C1dpj9Cv7s4Gpqjr3fv8bvD+1WaQPvZFD6+lknZGs+Z12eSHJq5Hu/xL2T09kIuiCGXWgphx6AyBzLs83D+UbXQ625DZ04G0x+DXcyyNOBajaW017glDa2Tbe01eCGrtDgeuNblyHS7gip1XHVExUaKWibslLPeT2UCsnkydQQ5XNTxXD7ofgODw8Insy72KzRMsO8otbw/qxxQe4Y/l06q1ySGWt4q4r6H6mbu2kYxlQw5NLei0nffcOWSgvpLqx7O7SEll0VJkCt01012g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilbMOsbd+a1Wf0jibFOMfvmsZO77LBBjB/STe/h1tZ8=;
 b=ImfJbMA8ZUWP53Xd1qlUmmIs1PgxoukhkQIW+SU9cmDMSfShdOfv4DTXQybuF7z4dodN8EQtqnZSW98KmmDdEl81SEhc0hCH/RDw7fjG3xUMF0elMhbFrFr8Yfppg49+I2HgDFGYMWYPgJQI/ueHR2+a5pgnjIVu3ZWfsrrBfZO2WDrxlV1+4AMMTzuPtxx1JkDR9ogYSDh2kkfouCvSriiltjE3GPG5yPp4TXNpbmZipLPRYYQUw9/EwqcV2wFC4AEUqDVjUGNNmSrJC80xkGtGzJ8AohFeHFWVHtGdXXZ2DA2SPJOnZgOVcFgmIA6zHz3z7ZrjX0pBk0JInHgXzw==
Received: from MN2PR14CA0025.namprd14.prod.outlook.com (2603:10b6:208:23e::30)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Thu, 4 Jul
 2024 23:19:08 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::d6) by MN2PR14CA0025.outlook.office365.com
 (2603:10b6:208:23e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Thu, 4 Jul 2024 23:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 23:19:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Jul 2024
 16:18:55 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Jul 2024
 16:18:54 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 4 Jul 2024 16:18:53 -0700
Date: Thu, 4 Jul 2024 16:18:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Jean-Philippe Brucker" <jean-philippe@linaro.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "Jacob Pan" <jacob.jun.pan@linux.intel.com>, Joel
 Granados <j.granados@samsung.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <Zoct3LVVHhDNbPBT@Asurada-Nvidia>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
 <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
 <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fc7f5bb1-25b7-4a5f-8d6b-1fa17b1af534@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc7f5bb1-25b7-4a5f-8d6b-1fa17b1af534@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9e9666-84ed-44c5-86b2-08dc9c7fb41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XJkvCbTmxGadi7sMc3SD0aPusH/ZxGFFpnyp6u5tIcEpeU8KVG4LTMP91TAd?=
 =?us-ascii?Q?v1d1Ny0j3DUHQJxQVSaUvAN82y7Wp6Eg8Ex1ZHp+zmdszrcDrujrfeGKFu2U?=
 =?us-ascii?Q?9WoVjxvTjPDQlzhL+kEqeTwz/trLmEv6znS1QABcNYW5i1oULPRR/eiwZ534?=
 =?us-ascii?Q?zTn3/buHqYSVinFA/EuEXjwnn5SgxlqHZMPfWSvGIZ+KOc1svjf7hbIkczyY?=
 =?us-ascii?Q?njiUJq3V27fPNGKy8pC07RvgVL6ToBlLUytu20PF8FbcZC0SSawnmKUYzkVS?=
 =?us-ascii?Q?LljgucBvxr9D27ajMm4q9lslA1YwEQPHvtDLHNKeqm/O75o7F4I5YYnJJw15?=
 =?us-ascii?Q?BsKsAeDSsYw6dRPthA4Ltf+Rirs5nGNKE8H638E7UfvU3ll2P/hi1bhm/UaT?=
 =?us-ascii?Q?Xdmogz4EXtYIDYHTr7UGzRBvf9Qt37Sl3mYZ0jBfCH+zd5PMD0pcbflkwu98?=
 =?us-ascii?Q?ibyd38E2GqR4uIWxGH6zdTOslKpUJtLSvF3g7tZQyCO+lR0fil04rNFDdvdB?=
 =?us-ascii?Q?IT+42xpANzAWUE1916cLYB8KGy8BftF6G7hQQMJag1YVp0ARkATOXofUVMSh?=
 =?us-ascii?Q?9/Gs6PsON6PlDcCI/eJcAkG2fGUxmOlYwa3Z1b0goElxV/HGi2GbLIp8xbAI?=
 =?us-ascii?Q?buD1Q1TnhoWLKZxlHESTLr4Nx/xcViAYEjKLmMN1VXm4JiDjLE3GMZt5bSRT?=
 =?us-ascii?Q?5AWzJ0KL7qDrlQ7qREbE4KptRFGJJY6LolkjNEWUkPabc6LHuT2LpCkl3UNe?=
 =?us-ascii?Q?g3gDoiORl6Xn0BM0gfSagTPFsHuq2FA5GbMNCwWl+ZadzHZw/CTdkhUKl+KC?=
 =?us-ascii?Q?9r7feTi9w222tbhULzbQEioE+AS/V8+kHgoyZYxnpUZQVBf2fcco68RG53xf?=
 =?us-ascii?Q?WYEHqqpWI9884O2W8GuFWiD5VHP5+7Jusnb2UgakYYHhBPMRT0W2CgtmKTut?=
 =?us-ascii?Q?EKErUjCcn1OVJYRDqvAT5EQsGj+gMTg3nGBHrLqGd0K0f2S0KaONijDEDRJF?=
 =?us-ascii?Q?teTO1BjNidnKPb1kNI2WriFe3XCAbI6/cqtEqYmb80yAFxSADXoLCsXeOPdU?=
 =?us-ascii?Q?w7uyUngD/FJ709h80NMPlWzMzT5+EdWlYblkbSi4o/kzfQOLRLQtWk29sfLW?=
 =?us-ascii?Q?CK9F7gl3HsSN43sdj5jdl8VCgSBH25DQpkPJJ7Q1AnAwsZDacenU7cK9J+gc?=
 =?us-ascii?Q?XFX2LZNCUoztthm6ott9LvTprxpkBUCY+b4JulokkW2v5m6iBZSbSsAQ0VB/?=
 =?us-ascii?Q?nMlRlrNR5qxsTQrKZJGSTXz5YkZLsIeIjwT8NMZPankxC2Di6UueY+JQhzaB?=
 =?us-ascii?Q?joTJqkf7aYLwKBZUFQd/XRf97eEoV5FCs48DSw7mo4O3yXvP759wZh31wOpg?=
 =?us-ascii?Q?7Iey7O+cghubd8pZH0RafiHl0x6HUITYTCBscr+3wqEyLZE0DTlxgjygGBFH?=
 =?us-ascii?Q?291zdaePAxVOWaTCze+WFE4F3lUfah6c?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 23:19:07.4284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9e9666-84ed-44c5-86b2-08dc9c7fb41c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

On Thu, Jul 04, 2024 at 03:32:32PM +0800, Baolu Lu wrote:
> On 2024/7/4 14:37, Tian, Kevin wrote:
> > > From: Nicolin Chen<nicolinc@nvidia.com>
> > > Sent: Thursday, July 4, 2024 1:36 PM
> > > 
> > > On Thu, Jul 04, 2024 at 10:59:45AM +0800, Baolu Lu wrote:
> > > > > On Tue, Jul 02, 2024 at 02:34:40PM +0800, Lu Baolu wrote:
> > > > > 
> > > > > +enum iommu_fault_type {
> > > > > +     IOMMU_FAULT_TYPE_HWPT_IOPF,
> > > > > +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> > > > > +};
> > > > > 
> > > > >    struct iommu_fault_alloc {
> > > > >        __u32 size;
> > > > >        __u32 flags;
> > > > > +     __u32 type;  /* enum iommu_fault_type */
> > > > >        __u32 out_fault_id;
> > > > >        __u32 out_fault_fd;
> > and need a new reserved field for alignment.

Hmm, what's the reason for enforcing a 64-bit alignment to an
all-u32 struct though? I thought we need a reserved field only
for padding. The struct iommu_ioas_alloc has three u32 members
for example?

> > > > >    };
> > > > > 
> > > > > I understand that this is already v8. So, maybe we can, for now,
> > > > > apply the small diff above with an IOMMU_FAULT_TYPE_HWPT_IOPF
> > > type
> > > > > check in the ioctl handler. And a decoupling for the iopf fops in
> > > > > the ioctl handler can come later in the viommu series:
> > > > >        switch (type) {
> > > > >        case IOMMU_FAULT_TYPE_HWPT_IOPF:
> > > > >                filep = anon_inode_getfile("[iommufd-pgfault]",
> > > > >                                           &iommufd_fault_fops_iopf);
> > > > >        case IOMMU_FAULT_TYPE_VIOMMU_IRQ:
> > > > >                filep = anon_inode_getfile("[iommufd-viommu-irq]",
> > > > >                                           &iommufd_fault_fops_viommu);
> > > > >        default:
> > > > >                return -EOPNOSUPP;
> > > > >        }
> > > > > 
> > > > > Since you are the designer here, I think you have a better 10000
> > > > > foot view -- maybe I am missing something here implying that the
> > > > > fault object can't be really reused by viommu.
> > > > > 
> > > > > Would you mind sharing some thoughts here?
> > > > I think this is a choice between "two different objects" vs. "same
> > > > object with different FD interfaces". If I understand it correctly, your
> > > > proposal of unrecoverable fault delivery is not limited to vcmdq, but
> > > > generic to all unrecoverable events that userspace should be aware of
> > > > when the passed-through device is affected.
> > > It's basically IRQ forwarding, not confined to unrecoverable
> > > faults. For example, a VCMDQ used by the guest kernel would
> > > raise an HW IRQ if the guest kernel issues an illegal command
> > > to the HW Queue assigned to it. The host kernel will receive
> > > the IRQ, so it needs a way to forward it to the VM for guest
> > > kernel to recover the HW queue.
> > > 
> > > The way that we define the structure can follow what we have
> > > for hwpt_alloc/invalidate uAPIs, i.e. driver data/event. And
> > > such an event can carry unrecoverable translation faults too.
> > > SMMU at least reports DMA translation faults using an eventQ
> > > in its own native language.
> > > 
> > > >  From a hardware architecture perspective, the interfaces for
> > > > unrecoverable events don't always match the page faults. For example,
> > > > VT-d architecture defines a PR queue for page faults, but uses a
> > > > register set to report unrecoverable events. The 'reason', 'request id'
> > > > and 'pasid' fields of the register set indicate what happened on the
> > > > hardware. New unrecoverable events will not be reported until the
> > > > previous one has been fetched.
> > > Understood. I don't think we can share the majority pieces in
> > > the fault.c. Just the "IOMMU_FAULT_QUEUE_ALLOC" ioctl itself
> > > looks way too general to be limited to page-fault usage only.
> > > So, I feel we can share, for example:
> > >      IOMMU_FAULT_QUEUE_ALLOC (type=hwpt_iopf) -> fault_id=1
> > >      IOMMU_HWPT_ALLOC (fault_id=1) -> hwpt_id=2
> > >      IOMMU_FAULT_QUEUE_ALLOC (type=viommu_irq) -> fault_id=3
> > >      IOMMU_VIOMMU_ALLOC (fault_id=2) -> viommu_id=4
> > > The handler will direct to different fops as I drafted in my
> > > previous mail.
> > > 
> > > > With the above being said, I have no strong opinions between these two
> > > > choices. Jason and Kevin should have more insights.
> > > Thanks. Jason is out of office this week, so hopefully Kevin
> > > may shed some light. I personally feel that we don't need to
> > > largely update this series until we add VIOMMU. Yet, it would
> > > be convenient if we add a "type" in the uAPI with this series.
> > > 
> > This is ok to me.
> 
> So
> 
> Nicolin, perhaps can you please cook an additional patch on top of this
> series and post it for further review?

Thank you both for the inputs. Yea, so long as we merge them
in the same cycle, it won't be a uAPI breakage. I will draft
an incremental one. And Jason can make a final call.

Nicolin
