Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A41946C0
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jul 2024 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048010; cv=fail; b=fo4K3sNzLuzUH17D+E2iwcA9rAUMYX4ZUts+ZzWBejXy1BZYnsH3a3lZLrFvxQEOqZfD5D1mlcLvY3OlwDWvajQ6zLwGpZSvr94y7Y+E2SR6pHsUSy7Khqbep17ItZSVMR1/zmkc1pnGXTIyjsw2Iq8n1QD3rj4BKfLEnRNiob8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048010; c=relaxed/simple;
	bh=n3rO4D/WPqksRT92c3WjMYe+8nZkj256Z/CXbB333YA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyEZWvmTJBsdFoNlYLvyKpr+q7aUK+hYzz0ePpDojAIhtKvyVkdH2mEJcgfxuX1PyLe3e0I5vBV5F/QVhT7CxmGmYYmbGGTeYGabwwNsHhuxJ0tFlQWMXkxLT9w4czaADtF1o4wvSJIw8d3MXW2XpwuhzHECt7gF1ap6OMAWIfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IhQqhAmn; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IhQqhAmn"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9842241A73
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jul 2024 23:06:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D_CYRK4enkQj for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Jul 2024 23:06:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f400:7e88::61c; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=nicolinc@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4F5AF41A8A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F5AF41A8A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IhQqhAmn
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61c])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4F5AF41A8A
	for <virtualization@lists.linux-foundation.org>; Wed,  3 Jul 2024 23:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0Vfc4oT6YtWdFOVyer7W9yTJkCvXWfTYj5FgcRRWOyO89L3py8LVJNMQHgrgdldA4mrifQuexRuf2MyhHWg8PKpCmiu6xIOkKufqt70ENRB5qzQqdmbE7gBRYzqUXdWxfFO+E87xwMf43kdb/HL45srZGNhZ23c44W9X6wl2ak5gsAWtUIcl+XmdJ7V22g8dE1Iq/h0swtNju2W52R85BVo8j9Ul5PNQYrEFoWrxr4OWIVVyeoQItDiTpYcL7bjG5OE11l9NAgOkkb5RojoIYt1slmUCMuhbT5LUYCbcFYoBqqtz5+dU0H15NG4M/GWh5t6nyL9IkC865dlNmxnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFypB8QquqIWlG3jKiaHR+nrvsGhowfnkzF/SjFq/T8=;
 b=JB/Hp75/dbUrbW38e+kK6yESZikSkCQGgybDv4EQ47LQl85LBbCOXkaY+/2dDVFTu7D2qHPJCxlaRvfGeV3mcNefZDzty42012lW+28mDQ1f1F2DYMxFSuCcPmbbRcpPOy3lQBWu2zoXF6ILanMbrjJ6qfty2FmYjG5BJj7tZm/VU/tWIICC6Q0U9lJIWm7p9VbA47FIRCnn+QT0EkzgwrHoKsZMXzJ8cGnzkewGGxdpdVbtZN0o4vq8Okw4jVXwfsd5KuIADl60fyAjYjTSGJbUn7jlYk+bEumDadrxk5V+WmWEYVZjB8BfICnkm3bPUzgoujvLuoSbxK25NiWcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFypB8QquqIWlG3jKiaHR+nrvsGhowfnkzF/SjFq/T8=;
 b=IhQqhAmnZFZPmssIo/UAGIk839AfgiMVQ9y12rMcH/J/UZjfD6fTD51ZL5DIMlJdGlMSElgGYb5Hz7KoLFWI912N+EgQwFEjp1BFryLZVycTeVbFtCE3E3ZBTNrhSpBchoJw32/xKQUk+WlDdADkw6Q3uccasDchNxd5AteO9GCewT69Cq4DKgPaNKrINgRnWSa6qZMKAMjzwt0//7sHrdVCRCNv4hh7DcX9/x6mathTwOTZHHq5m9XJb1VvYeDae8tpPnZYg6CKpHU1r8LRcd9gk068zOLGmhWsEu6dS8v9ORlTwemOOocKbfrdpHeYYgh962OJ3DspkQVISdgpWg==
Received: from BL1PR13CA0110.namprd13.prod.outlook.com (2603:10b6:208:2b9::25)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Wed, 3 Jul
 2024 23:06:42 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::99) by BL1PR13CA0110.outlook.office365.com
 (2603:10b6:208:2b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8 via Frontend
 Transport; Wed, 3 Jul 2024 23:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 23:06:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 16:06:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 16:06:18 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 3 Jul 2024 16:06:17 -0700
Date: Wed, 3 Jul 2024 16:06:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Yi
 Liu" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joel
 Granados" <j.granados@samsung.com>, <iommu@lists.linux.dev>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702063444.105814-7-baolu.lu@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 478f0402-6c59-4446-11d4-08dc9bb4cd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?01asFNKhw3TEnyGzj+QTcagAvRPs33I8TUTPCr27Fm/hZh+05BzglDCv+j+Q?=
 =?us-ascii?Q?vLpikZEd0BzoSy09Oh8vHTFnRCJd3Rf7bEh703hcfoM07GuhgRsvIdavZ1IQ?=
 =?us-ascii?Q?Fx+VeUk6vomJwEcxF6NFU6qnKEHIaPtP9kU3XOiAE1QCfSMqw+atkdr6GaTd?=
 =?us-ascii?Q?lTrJ/PrWjbH6mwRk+3vqqF3/qiPGZ7f7S3rRFMK4zdoEx7xEN0WjmnMYV0bV?=
 =?us-ascii?Q?2vMqzTeOHaVIN5JzoxVTxir2POcyPlUTnUAeWGNMksnfObIu6c4nP/pTWq4G?=
 =?us-ascii?Q?NkSoc6Qyb+yXga7B7+iZtoFs78Yg3LG2HzerYOwjV9IVArUTr10CTeWvcu+y?=
 =?us-ascii?Q?g4gQhS5nj3guFIwJAZRAG12BvcQfOe3OLWMCVOdkn729TOsNrY9sECRUOvya?=
 =?us-ascii?Q?wRK7Z48jk7rbbvm+2jduaTgKLvIyJ2ar+nVZZ0lGrU1Rb87LtImP1DBEknJi?=
 =?us-ascii?Q?gXDaAgSCG+72gvqRYlRHZz/wjRAxFPYfLm6LOHyySGI3BLPNRpOd7gf7Gcy0?=
 =?us-ascii?Q?gA5D1DkTwQG3T2KLbVOqgUhOdVb2+eG+AV78X6DldtmZd1+UmxkR81ymgxHJ?=
 =?us-ascii?Q?2Ktkf4wXVOCgG3mjfOZkVm9PjZyPUrDIdU3JeyzFVkpb5gonf0OFH6lxSwDJ?=
 =?us-ascii?Q?pl+WHpSmZrRMKBV5/x/5xgleywZ94JkOWp3jBYe3IhPeqLa3uoUZWf+IRgFB?=
 =?us-ascii?Q?tC1/iXXDL8qrz0GgbDBFH9/lVMhua67mcSjjrroztZ3+OEeyQcCzuchmf4Fs?=
 =?us-ascii?Q?G1IYeeFwSvhW4yDyVqELzgQddHxpXscT7AnU1q/zW0qNf2VxYn099tCxP21i?=
 =?us-ascii?Q?HVQJlb/kCiEiPBJRSRv7mHmzUd65DsAGPG4yFSruSQRSMyssARDzt4ymQsII?=
 =?us-ascii?Q?bnNMR3LtllTec0ucC14rUmWjU/Q7MCPePpvt27X4QiT5b9xT+IDa8TwXC8Za?=
 =?us-ascii?Q?0SRsjw5qntGoD5ByRfQOppDGok2Ljc84t2bnGVPeuIhrRQ2LbEQ86F4vHCwR?=
 =?us-ascii?Q?EjaIWjH1rDJ+OCMmvLHpQI4xxT5Pix+7+epm1s3C4WNhX2rBguLmCCA6EVEU?=
 =?us-ascii?Q?gA4aH6Hc7lZGw7j2+4sZjgD8Cyu2nbIq024mxtXBvILwH2Jb7LbDSCmsx4Bb?=
 =?us-ascii?Q?k9EtO8KwW2PIvoHjXZywASTH3z/PC0Ch/CRUbjgUegqnTSQlcufbfHpbpFWl?=
 =?us-ascii?Q?YNwfCxSyxfY0rw8r0zhaiq83VXfXOzNx+YuEjRfFcToN6xFe+pw9CbcLt924?=
 =?us-ascii?Q?FDr8Kyjfw79EUo+k5AjqocIl84+foimu0AsvX3AcgWpRVZgeGmkjxS3XXDhk?=
 =?us-ascii?Q?mCjIgGxOcXwybN3WzbEPlW9tt1wqbGgkSI2RpvZZEjeLvdE10IWvWK6CXGRp?=
 =?us-ascii?Q?efuLIi3zsb+ARsf7DZN1y86s3jaSgCFjLIejACSFC2JQoJuHcq5UdCH6HJ20?=
 =?us-ascii?Q?9QCSRt/1Ntrm8bgulGNTWPln8/VMwM7L?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 23:06:42.1524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478f0402-6c59-4446-11d4-08dc9bb4cd7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

Hi Baolu,

On Tue, Jul 02, 2024 at 02:34:40PM +0800, Lu Baolu wrote:

> An iommufd fault object provides an interface for delivering I/O page
> faults to user space. These objects are created and destroyed by user
> space, and they can be associated with or dissociated from hardware page
> table objects during page table allocation or destruction.
> 
> User space interacts with the fault object through a file interface. This
> interface offers a straightforward and efficient way for user space to
> handle page faults. It allows user space to read fault messages
> sequentially and respond to them by writing to the same file. The file
> interface supports reading messages in poll mode, so it's recommended that
> user space applications use io_uring to enhance read and write efficiency.
> 
> A fault object can be associated with any iopf-capable iommufd_hw_pgtable
> during the pgtable's allocation. All I/O page faults triggered by devices
> when accessing the I/O addresses of an iommufd_hw_pgtable are routed
> through the fault object to user space. Similarly, user space's responses
> to these page faults are routed back to the iommu device driver through
> the same fault object.

There is a need for VIOMMU object to report HW fault to VMM. For
example, a HW-accelerated VCMDQ may encounter HW errors. HW will
raise an IRQ to the host kernel and the host kernel will forward
it to the guest. I think we can have a viommu->fault, similar to
the hwpt->fault introduced by this series. This viommu->fault can
also benefit nested IOMMU for reporting translation error.

I learned that this hwpt->fault is exclusively for IOPF/PRI. And
Jason suggested me to add a different one for VIOMMU. Yet, after
taking a closer look, I found the fault object in this series is
seemingly quite generic at the uAPI level: its naming/structure,
and the way how it's allocated and passed to hwpt, despite being
highly correlated with IOPF in its fops code. So, I feel that we
might have a chance of reusing it for different fault types:

+enum iommu_fault_type {
+	IOMMU_FAULT_TYPE_HWPT_IOPF,
+	IOMMU_FAULT_TYPE_VIOMMU_IRQ,
+};

 struct iommu_fault_alloc {
 	__u32 size;
 	__u32 flags;
+	__u32 type;  /* enum iommu_fault_type */
 	__u32 out_fault_id;
 	__u32 out_fault_fd;
 };

I understand that this is already v8. So, maybe we can, for now,
apply the small diff above with an IOMMU_FAULT_TYPE_HWPT_IOPF type
check in the ioctl handler. And a decoupling for the iopf fops in
the ioctl handler can come later in the viommu series:
	switch (type) {
	case IOMMU_FAULT_TYPE_HWPT_IOPF:
		filep = anon_inode_getfile("[iommufd-pgfault]",
					   &iommufd_fault_fops_iopf);
	case IOMMU_FAULT_TYPE_VIOMMU_IRQ:
		filep = anon_inode_getfile("[iommufd-viommu-irq]",
					   &iommufd_fault_fops_viommu);
	default:
		return -EOPNOSUPP;
	}

Since you are the designer here, I think you have a better 10000
foot view -- maybe I am missing something here implying that the
fault object can't be really reused by viommu.

Would you mind sharing some thoughts here?

Thanks
Nic
