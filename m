Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51B1A070F
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720071407; cv=fail; b=W+xJavZUcsnXDW16SVuIuiWSAM0w99MFZ570vbcp0+wj4nHVp3ZezV5dZHpQhNaapGSx6nqcwOFMt3qvQS1GjjVuT4b0oSx3EHpe1QaJHhKismhiWQ3MNdSktShah4AH5Zb5mzaHCUaLQHvuaRxGfZVTorDHdbRehgdBSCTZ6mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720071407; c=relaxed/simple;
	bh=TK4K4B4iOqPBNV5DiqpZdKPLE19ZDFts0OJx7/EPjRM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlWps8co4YNu5fgLdVUa0ouKiAcqdawb0ZvZfH/vFxdzuOqdU8fwWlUlzDitBtFTSG1yF27mWnhwGkOEYinpuBSBHqcJvvZ0zDUe10HYh4XmohIUF14W8CF7C96xqXSc/20q2sdm/WOlcP9yFbdZ0QBYLPvUvcedEBr+LIux398=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=himWQxn2; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="himWQxn2"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 13EBF40126
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 05:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNptSA-Oj-Ad for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Jul 2024 05:36:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2414::61c; helo=nam11-bn8-obe.outbound.protection.outlook.com; envelope-from=nicolinc@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 84E33400EA
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84E33400EA
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=himWQxn2
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f403:2414::61c])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84E33400EA
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 05:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTiFmDkc1WTPlNKE7rreiwqfbvqVmj6UJUbFITXZu470Z5Ume+v5IlHqutHYI+sWnKsdllzfTDV1lpiLqSyzUHhSq9zT3xI1gD2jcL3gS11kEbsiKHGFNNqsH8Ffa4E5UCrKkHXMYFJS9s5Zfmma1NId8NSfm+trb4Kbn9KqDwRvYnDSDBw3yr6q2fRl/Dgth49zO2/v3V7gi20u8IRptRoMxsNAw+KwsLavTb9ZkkGTVPYh7JwUSdGpI4bhPTrA4GQH3twBcaXeVO+hu+Q3ImSo2N0ANbwMnviYU6JUzKH6eXHK430y4jUcujYhp5RpQ7rXEYhxex1CdJ9JwUrQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxhCexQaGAOu+zXM34A1axxvd9j6+3eOwpBUleacCL0=;
 b=g1BQzKwfGMtQNYgmA7NGega4oaw22poQfmNHy9xL8H+Hk7Z8YLC6oZ1jEj8GgilC8I9iovvRPSaYXJJAz5o48a4y/9KoWla6pSpH91gS8InoRt7tGuASXsLNV6PXmKxuwxaNEZFCqpucLXElFkRrJ7AsakEmkI95yQshk2Fb/32qeci2KcNu5dNT9ISmNzkqNcu7YIuQnPPCtdC8oJGB8e2I+NdlRPHG0cqIRq1tp6kSiSsYELPyBq4RlC44KVcdTXD2wA93Rj/Mf/3hvy95F+vscyJ2r0PJ0J6Mx6DY+LD7srvxy0VnD/2wUjoxEUsqdMOdxhbQU+QhZsREKU0Bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxhCexQaGAOu+zXM34A1axxvd9j6+3eOwpBUleacCL0=;
 b=himWQxn2i79upkHRde9LDGEMLwhBA1QNqM9L+Q7oW+7wgu5PntAhYZvnT9rAejR6MuLUBwfQeIOdvqiejk1LX+jy80R1NCtGRH9fx8zvoHrzTgilsPvBA6AbO2I7Isu7NSuoWpw1l10kD1pqQAjrL8alcYM0Gn3BgLa8hBfxPqTLab8d3tuAzW9f4ereoUfLCAIs1G8j/bl1CLo6tEG68wSZAXxp6qfQ3TXBuFMrdW5k3Fa+COItz2c6h/LLpy+sprF5FovKKnXvCL1H7r22kRFOxEe4Y3EYA8mr5q09m2gYUxHMyvd5whd0mB4GGWm4/OX8LncLQtaA2F85IMMXBg==
Received: from BN7PR06CA0056.namprd06.prod.outlook.com (2603:10b6:408:34::33)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.41; Thu, 4 Jul
 2024 05:36:38 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::d) by BN7PR06CA0056.outlook.office365.com
 (2603:10b6:408:34::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26 via Frontend
 Transport; Thu, 4 Jul 2024 05:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 05:36:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 22:36:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Jul 2024 22:36:24 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 3 Jul 2024 22:36:23 -0700
Date: Wed, 3 Jul 2024 22:36:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Yi
 Liu" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joel
 Granados" <j.granados@samsung.com>, <iommu@lists.linux.dev>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 13593df2-f45f-4de0-2047-08dc9beb45e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cknUYLAuUgDt4VdZXI3GjWw8c7yCISCOl4tcB2frLP1VtbAtcp97r5XB5pkE?=
 =?us-ascii?Q?F93x4mrBNPVJjnC/zlg7JPSKD0PDomdFhKtWqVeghLnFffnKE3trMISY23nx?=
 =?us-ascii?Q?VkPfI33LgTKTfrVLlyc8h25ZSBMbh+koIwPRCNzseMJdfruFBjNqkLKB34ei?=
 =?us-ascii?Q?sRj252Nja/dVgMjwWuis2hELiX4jwP3gU/FT2sN7U14uezqF3RfMeIPSzwWb?=
 =?us-ascii?Q?1ES4+t/QvrCm/rX4q+lji/g8ni099gqSCP95Du8qgAC5v+OIXrGZdwyUjhMz?=
 =?us-ascii?Q?SW3ibQ912a9xxmMVusXareRJ9S3W7BTaXi22VyJ4bJgPLlxn5ZG9o4hwN6h9?=
 =?us-ascii?Q?q0QxXB5AtJSG7t+HFBv357WmZonOgsuG1c9xgsEIIPXDbPz09uMRwSRiXz82?=
 =?us-ascii?Q?sDbWr53m8GxEWgbgGhEPJSqDKVmbQyOd+cOCaAFKARmUtPGukKdKBSGfMN3H?=
 =?us-ascii?Q?SL5pi8+LD8qnRPhw7tjW2uyFhwsoXxvKpSEq/gw9pPB2F8IqxR/WGf+W0i3R?=
 =?us-ascii?Q?NrMDx5/jAWWCleD/46gzfK11s6oORpXvIB6m9xaFdbxsyb82RjvaP6qcJwoo?=
 =?us-ascii?Q?a8xcwip71QbfS+ttkjf8s8EjgUsLqYm7pGoAJl/7RJaxNFAVQ/kTvse0C+sA?=
 =?us-ascii?Q?B5UOEReo8JWT6UPJ9oO5MqkD+gAd/TZXbATIw4WTdbx9Qi545H17Rk/9iK/i?=
 =?us-ascii?Q?SVGWGQwsOnJzCB/X2PD1hfw7uZzL4/70hcGT2z3FShh6UCahFlDaxPEaX61K?=
 =?us-ascii?Q?CiHlocUJp6gOP3da6zbDRWl6+Tl6/j+otdDmNhSDPM2um6DdTuQDMAmHMC6Y?=
 =?us-ascii?Q?csu9XDwyPIxpmMiMKdBfcnfC9F25PE2/i5VGHh6cMzyJvPS2jQuD9iX/UkJa?=
 =?us-ascii?Q?cwEtmrC8s7ZNoaE5m1iJTIkXVhUV/rPL2DuOWKpBJEYwbmUBjSuQwcCL/NJM?=
 =?us-ascii?Q?nCCgUA+MyeTecEmggOb6jyuwQGawg5FqnIzzKoYcheCSHsHX1ndXe6CAW1JF?=
 =?us-ascii?Q?DDvdNKOBePwkuwr9xyUrXksyha5KFvwCJnC30F9qYdXnX+MtTxKSi+38V5oZ?=
 =?us-ascii?Q?8b+5Eo+yr/3ZoHXrgM0P5bEHgV98nFHlgvB6SGc66g2ldZ6ORgQV2XpLuKH7?=
 =?us-ascii?Q?RX7M5iTdliJBhTxea5nfFzXeouMO1/WUGVWOSY+53SNMqbraGFVfBNuVYbiq?=
 =?us-ascii?Q?o6A4+gfcv8oYC7pzXdi1cpGnh+2PVV3/y8WLxcgHzXGkIUpoGbfp3s1oYt9m?=
 =?us-ascii?Q?GccR3BfkQ3BkPmDknfl79rFQZfWo6dPs2CupFaEOt9oihG659feGrqmiiXR3?=
 =?us-ascii?Q?w7mD9iQ0apmYy2KarKicG+6Y/T4qIB+eA6vD0FH9Opi5lFeI6I0QHpsgI8Sv?=
 =?us-ascii?Q?c49dRbgtWL+8NhoMmgQ8fYrc8jQIf/eNCMm9T7ELHACvtJYD0aNboJj+33oP?=
 =?us-ascii?Q?RyRFuV9k8AjosrJ+U992UuPxLWaOb1qq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:36:36.9778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13593df2-f45f-4de0-2047-08dc9beb45e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

On Thu, Jul 04, 2024 at 10:59:45AM +0800, Baolu Lu wrote:
> > On Tue, Jul 02, 2024 at 02:34:40PM +0800, Lu Baolu wrote:
> > 
> > > An iommufd fault object provides an interface for delivering I/O page
> > > faults to user space. These objects are created and destroyed by user
> > > space, and they can be associated with or dissociated from hardware page
> > > table objects during page table allocation or destruction.
> > > 
> > > User space interacts with the fault object through a file interface. This
> > > interface offers a straightforward and efficient way for user space to
> > > handle page faults. It allows user space to read fault messages
> > > sequentially and respond to them by writing to the same file. The file
> > > interface supports reading messages in poll mode, so it's recommended that
> > > user space applications use io_uring to enhance read and write efficiency.
> > > 
> > > A fault object can be associated with any iopf-capable iommufd_hw_pgtable
> > > during the pgtable's allocation. All I/O page faults triggered by devices
> > > when accessing the I/O addresses of an iommufd_hw_pgtable are routed
> > > through the fault object to user space. Similarly, user space's responses
> > > to these page faults are routed back to the iommu device driver through
> > > the same fault object.
> > There is a need for VIOMMU object to report HW fault to VMM. For
> > example, a HW-accelerated VCMDQ may encounter HW errors. HW will
> > raise an IRQ to the host kernel and the host kernel will forward
> > it to the guest. I think we can have a viommu->fault, similar to
> > the hwpt->fault introduced by this series. This viommu->fault can
> > also benefit nested IOMMU for reporting translation error.
> > 
> > I learned that this hwpt->fault is exclusively for IOPF/PRI. And
> > Jason suggested me to add a different one for VIOMMU. Yet, after
> > taking a closer look, I found the fault object in this series is
> > seemingly quite generic at the uAPI level: its naming/structure,
> > and the way how it's allocated and passed to hwpt, despite being
> > highly correlated with IOPF in its fops code. So, I feel that we
> > might have a chance of reusing it for different fault types:
> > 
> > +enum iommu_fault_type {
> > +     IOMMU_FAULT_TYPE_HWPT_IOPF,
> > +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> > +};
> > 
> >   struct iommu_fault_alloc {
> >       __u32 size;
> >       __u32 flags;
> > +     __u32 type;  /* enum iommu_fault_type */
> >       __u32 out_fault_id;
> >       __u32 out_fault_fd;
> >   };
> > 
> > I understand that this is already v8. So, maybe we can, for now,
> > apply the small diff above with an IOMMU_FAULT_TYPE_HWPT_IOPF type
> > check in the ioctl handler. And a decoupling for the iopf fops in
> > the ioctl handler can come later in the viommu series:
> >       switch (type) {
> >       case IOMMU_FAULT_TYPE_HWPT_IOPF:
> >               filep = anon_inode_getfile("[iommufd-pgfault]",
> >                                          &iommufd_fault_fops_iopf);
> >       case IOMMU_FAULT_TYPE_VIOMMU_IRQ:
> >               filep = anon_inode_getfile("[iommufd-viommu-irq]",
> >                                          &iommufd_fault_fops_viommu);
> >       default:
> >               return -EOPNOSUPP;
> >       }
> > 
> > Since you are the designer here, I think you have a better 10000
> > foot view -- maybe I am missing something here implying that the
> > fault object can't be really reused by viommu.
> > 
> > Would you mind sharing some thoughts here?
> 
> I think this is a choice between "two different objects" vs. "same
> object with different FD interfaces". If I understand it correctly, your
> proposal of unrecoverable fault delivery is not limited to vcmdq, but
> generic to all unrecoverable events that userspace should be aware of
> when the passed-through device is affected.

It's basically IRQ forwarding, not confined to unrecoverable
faults. For example, a VCMDQ used by the guest kernel would
raise an HW IRQ if the guest kernel issues an illegal command
to the HW Queue assigned to it. The host kernel will receive
the IRQ, so it needs a way to forward it to the VM for guest
kernel to recover the HW queue.

The way that we define the structure can follow what we have
for hwpt_alloc/invalidate uAPIs, i.e. driver data/event. And
such an event can carry unrecoverable translation faults too.
SMMU at least reports DMA translation faults using an eventQ
in its own native language.

> From a hardware architecture perspective, the interfaces for
> unrecoverable events don't always match the page faults. For example,
> VT-d architecture defines a PR queue for page faults, but uses a
> register set to report unrecoverable events. The 'reason', 'request id'
> and 'pasid' fields of the register set indicate what happened on the
> hardware. New unrecoverable events will not be reported until the
> previous one has been fetched.

Understood. I don't think we can share the majority pieces in
the fault.c. Just the "IOMMU_FAULT_QUEUE_ALLOC" ioctl itself
looks way too general to be limited to page-fault usage only.
So, I feel we can share, for example:
    IOMMU_FAULT_QUEUE_ALLOC (type=hwpt_iopf) -> fault_id=1
    IOMMU_HWPT_ALLOC (fault_id=1) -> hwpt_id=2
    IOMMU_FAULT_QUEUE_ALLOC (type=viommu_irq) -> fault_id=3
    IOMMU_VIOMMU_ALLOC (fault_id=2) -> viommu_id=4
The handler will direct to different fops as I drafted in my
previous mail.

> With the above being said, I have no strong opinions between these two
> choices. Jason and Kevin should have more insights.

Thanks. Jason is out of office this week, so hopefully Kevin
may shed some light. I personally feel that we don't need to
largely update this series until we add VIOMMU. Yet, it would
be convenient if we add a "type" in the uAPI with this series.

Thank you
Nic
