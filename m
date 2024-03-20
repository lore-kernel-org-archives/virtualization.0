Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69265466C
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Mar 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951494; cv=none; b=jX8tRcd1/eQ9fe9ykRrNaWT7Vc/2kZd9sbNmQ+H3CtUvjV15JfQMsdxfeNm+aAPcq0zCEX2TN8kks7dcEHj1iy9hpBoPtW1K7tceKBSZPX+j+aRnBLgBCfDn9azcNPane0+bjERo9KD+BNSmln9RaVyNWsVoIZ/XmrOWGBDt41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951494; c=relaxed/simple;
	bh=AA0UbQWWMDspRIn9QaELn/NgyElXsCyXOzsAvqZsR5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pNeQKm4dC2DkADD/eYthg+8tHofPvsYqrDePP1Wf9adZNNZY35JGzfAyXsJGz0wS+oIpQRvH+sRhQnsyKPFH+DIQHBzjl0xPiIHjxFkMUdq24OzLNFGSHFvmHpHwzFj7gapASDp3M+3udM1Gj6JkjhIygrpJMvGG3Qmk3aJaIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EDD58209A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Mar 2024 16:18:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.198
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KQ5t6M8CKj31
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Mar 2024 16:18:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=shameerali.kolothum.thodi@huawei.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1A50382075
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A50382075
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1A50382075
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Mar 2024 16:18:08 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V0DJX73Pzz6K6Sy;
	Thu, 21 Mar 2024 00:17:32 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E5E7140B3C;
	Thu, 21 Mar 2024 00:18:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 16:18:05 +0000
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.035;
 Wed, 20 Mar 2024 16:18:05 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Kevin Tian" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, Yi
 Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joel
 Granados" <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/8] iommufd: Add iommufd fault object
Thread-Topic: [PATCH v3 4/8] iommufd: Add iommufd fault object
Thread-Index: AQHaTQcNFocLBOqngUqDZu3K/gB7pbFBJJkw
Date: Wed, 20 Mar 2024 16:18:05 +0000
Message-ID: <ad4575588dd247fa8beae60963f36404@huawei.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
In-Reply-To: <20240122073903.24406-5-baolu.lu@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0



> -----Original Message-----
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, January 22, 2024 7:39 AM
> To: Jason Gunthorpe <jgg@ziepe.ca>; Kevin Tian <kevin.tian@intel.com>; Jo=
erg
> Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin Murphy
> <robin.murphy@arm.com>; Jean-Philippe Brucker <jean-philippe@linaro.org>;
> Nicolin Chen <nicolinc@nvidia.com>; Yi Liu <yi.l.liu@intel.com>; Jacob Pa=
n
> <jacob.jun.pan@linux.intel.com>; Joel Granados <j.granados@samsung.com>
> Cc: iommu@lists.linux.dev; virtualization@lists.linux-foundation.org; lin=
ux-
> kernel@vger.kernel.org; Lu Baolu <baolu.lu@linux.intel.com>
> Subject: [PATCH v3 4/8] iommufd: Add iommufd fault object
>=20
> An iommufd fault object provides an interface for delivering I/O page
> faults to user space. These objects are created and destroyed by user
> space, and they can be associated with or dissociated from hardware page
> table objects during page table allocation or destruction.
>=20
> User space interacts with the fault object through a file interface. This
> interface offers a straightforward and efficient way for user space to
> handle page faults. It allows user space to read fault messages
> sequentially and respond to them by writing to the same file. The file
> interface supports reading messages in poll mode, so it's recommended tha=
t
> user space applications use io_uring to enhance read and write efficiency=
.
>=20
> A fault object can be associated with any iopf-capable iommufd_hw_pgtable
> during the pgtable's allocation. All I/O page faults triggered by devices
> when accessing the I/O addresses of an iommufd_hw_pgtable are routed
> through the fault object to user space. Similarly, user space's responses
> to these page faults are routed back to the iommu device driver through
> the same fault object.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

[...]

> +static __poll_t iommufd_fault_fops_poll(struct file *filep,
> +					struct poll_table_struct *wait)
> +{
> +	struct iommufd_fault *fault =3D filep->private_data;
> +	__poll_t pollflags =3D 0;
> +
> +	poll_wait(filep, &fault->wait_queue, wait);
> +	mutex_lock(&fault->mutex);
> +	if (!list_empty(&fault->deliver))
> +		pollflags =3D EPOLLIN | EPOLLRDNORM;
> +	mutex_unlock(&fault->mutex);
> +
> +	return pollflags;
> +}
> +
> +static const struct file_operations iommufd_fault_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D nonseekable_open,
> +	.read		=3D iommufd_fault_fops_read,
> +	.write		=3D iommufd_fault_fops_write,
> +	.poll		=3D iommufd_fault_fops_poll,
> +	.llseek		=3D no_llseek,
> +};

Hi

I am trying to enable Qemu vSVA support on ARM with this series.
I am using io_uring APIs with the fault fd to handle the page fault
in the Qemu.

Please find the implementation here[1]. This is still a work in progress=20
and is based on Nicolin's latest nested Qemu branch.

And I am running into a problem when we have the poll interface added
for the fault fd in kernel.

What I have noticed is that,
-read interface works fine and I can receive struct tiommu_hwpt_pgfault dat=
a.
-But once Guest handles the page faults and returns the page response,
 the write to fault fd never reaches the kernel. The sequence is like below=
,
=20
  sqe =3D io_uring_get_sqe(ring);
  io_uring_prep_write(sqe, hwpt->fault_fd, resp, sizeof(*resp), 0);
  io_uring_sqe_set_data(sqe, resp);
  io_uring_submit(ring);
  ret =3D io_uring_wait_cqe(ring, &cqe);=20
  ....
Please find the function here[2]

The above cqe wait never returns and hardware times out without receiving
page response. My understanding of io_uring default op is that it tries to=
=20
issue an sqe as non-blocking first. But it looks like the above write seque=
nce
ends up in kernel poll_wait() as well.Not sure how we can avoid that for
write.

All works fine if I comment out the poll for the fault_fd from the kernel.
But then of course Qemu ends up repeatedly reading the ring Queue for
any pending page fault.

It might be something I am missing in my understanding of io_uring APIs.
Just thought of checking with you if you have any Qemu implementation
using io_uring APIs to test this.

Also appreciate any pointers in resolving this.

Thanks,
Shameer
[1] https://github.com/hisilicon/qemu/tree/iommufd_vsmmu-02292024-vsva-wip
[2] https://github.com/hisilicon/qemu/blob/2b984fb5c692a03e6f5463d005670d2e=
2a2c7304/hw/arm/smmuv3.c#L1310

