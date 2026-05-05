Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B449251A
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002744; cv=none; b=scTyCIjXWJs+G62H/9EAQ6R/KeR9qe+qB+pFnJoPTFLbPIhTG4iXL93Ik5BmuQ71S3OhOijD6aCBQx6Bb/e10Qk02yl9INV0oNieTgpS3VKgkld3QEP2Ge6P5EAImHGwKp5aLIft5Zy56Vfjc0WMcHDSF3rEAxawCnTqgUKqzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002744; c=relaxed/simple;
	bh=LdNTDcgaxRBrQs1bwwf15/fQOML3XeLHapn0Jkbsa5E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lPffWZVvnVQ39RkKhQosS6v5QGvPcOwFh1o1JkPLZTTdA+1F+hYLBVr7mUBKeWdaOJ5HjzmHhKm2cr+Ee9KCmqq7fQDc1Ixamdn4XkvrwJOCNYQJyzkEwhh05f0E7mbXvzCricb/jjq7RHAElvIACsIzOoqkXYe+J1wAWBrpCGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SsFz7xe5; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SsFz7xe5"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EG4Kb3827822;
	Tue, 5 May 2026 10:39:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=J+1EL/c6Wr120VFRzE
	u4WRbxksb1n8IJx48fBmHAugg=; b=SsFz7xe5S88GmzvJsrYRZk2y1MFkNsEz+n
	inwa2iNv0JHMb8+JxYeK/2hCBZLd932cTnnuQih37Q3+TFCrxEQ9027j/Sb2aS4w
	VkboHWQSfPfjgJEzboh4JYfe5wuLzBGOnyEAew6AcQb3MBr0maG8tRq+lGnhKpF9
	uIJHiDPfiKIumJ2stnNomxiMzTZjoTtkYexV+CPdtGutEELgbieva4W+GwQDjhYc
	u9syDkHL8qFqpadJUBz4kib+3NML6FTx5mXwL6msfD8lVI2YYstfNjFSz34umnWB
	07x9hlHASf8dkEX9bTWTVPvtoo1Jl/K2uzlW5w7GebYAQdDTzDLA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx59tx7wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 May 2026 10:39:00 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Tue, 5 May
 2026 17:38:59 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>, Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
        Alistair
 Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Kees Cook
	<kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>, Eric Auger <eric.auger@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>
Subject: [PATCH v4 0/3] vfio/pci: Request resources and map BARs at enable time
Date: Tue, 5 May 2026 10:38:28 -0700
Message-ID: <20260505173835.2324179-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3MSBTYWx0ZWRfX3mEPYZEyZG8a
 PzT47Pq2gOhAdU/ELyCw7teHoWkhOu2e+clreO8RNzZWAqrRMrgS6uzOp0+SbHVvzgb/N2aW7r1
 yO1WIFfppTi1a4wXVdiQLsTo1hFXmEwnFZKsy8wmkUVLbSffjM1n8FfibS748uDLt2YOiLSyw4L
 uw6Aw1R+cVB4319kRTC82fLtUYHmq6ZlyI5ud6HdlFErXuQXihOdykrTHx9iW/rLpC2KLyxAdNM
 NF7EjfpVyN751F1v/M2a77VsShKjV4vWB/6WPAtTxztVmO1hAGDws9wwmArwsAmODbGxHaxa50v
 cX3AD0nHwiN6x9qn+APB0QASy8ID/h3P93bZJ3a+/PyEdQ7v9wHVOoeEFFCBsBNjkeOs7oP/7Z7
 LcVCsXh1cOLIKU90NTMu3TsOdM2Pq/H6QygHfirlEPWINsnKSG4EcbMmMs9PlqDYDaPmK1RXcFq
 sNhWTu6Wk9n7IldjKMw==
X-Proofpoint-ORIG-GUID: ZirWlsgfyoP-3DDZ4w1FwhPu6UkDKZj6
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=69fa2b34 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=fFA4BOaLBG0vzsxRvVMA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: ZirWlsgfyoP-3DDZ4w1FwhPu6UkDKZj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01

Hi,

These patches fix a potential race for concurrent calls to
vfio_pci_core_setup_barmap(), and a DMABUF missing check for resource
before the export.  Discussion on a previous series (different,
replaced by this one) is here:

 https://lore.kernel.org/kvm/20260415181423.1008458-1-mattev@meta.com

Responses in that thread indicated there wasn't a strong historical
reason to require the mapping to be performed on-demand at BAR
reference time.  It's much simpler to move this earlier, to
vfio_pci_core_enable(), and that then avoids having to deal with
concurrent requests later.

The first patch requests PCI resources and pci_iomap() of the BARs
from vfio_pci_core_enable(), moving this out of
vfio_pci_core_setup_barmap().

Some callers rely on vfio_pci_core_setup_barmap() for its ioremap()
effect, and other callers use it for its resource-acquiring effect.
The function turns into a cheap error check that both these actions
have occurred; that maintains the same error behaviour as before the
fix.

The second patch adds a call to vfio_pci_core_setup_barmap() to VFIO
DMABUF export to check the resource is reserved; previously this was
able to export an unrequested resource.  Although patch 1 at first
appears to fix this by requesting resources at enable time, code using
the BAR still needs to check the resource really was acquired.

The third patch refactors vfio_pci_core_setup_barmap() plus the various
vdev->barmap[] accesses into vfio_pci_core_get_iomap() which returns
either a pointer to the mapping or an ERR_PTR() describing why it
doesn't exist.  This is used by callers that need the mapping, but
also by other callers to check that the resource/mapping step was
successful.


=== Changes ===

v4:
 - Reorder patches to put fixes at the front: First, the early BAR
   setup to avoid the race.  Then, add DMABUF check.  Then,
   refactor/tidy.

 - Adjust Fixes: of first patch to point to early VFIO PCI commit, and
   reduce the patch to only the fix (don't add new error checks).
   Use pci_dbg() instead of pci_warn() when setting up BAR
   resources.  Add barmap[] error checking to vfio_pci_core_disable().

 - Add barmap[]/BAR index error checking to vfio_pci_core_get_iomap(),
   and use WARN_ON_ONCE() since the conditions truly shouldn't happen.

v3:
  https://lore.kernel.org/kvm/20260430100340.2787446-1-mattev@meta.com/

 - Remove the separate tracking of the BAR mapping versus the
   acquiring its resource.  Errors from failing iomap vs resource
   reservation are ERR_PTR()-elcoded into barmap[bar].

 - Remove the separate test helper, and add vfio_pci_core_get_iomap().
   This gets the iomap base or is used check for error/failure to
   acquire the resource.  Added comments at call sites explaining
   whether they want to just ensure the resource is reserved versus
   actually use the mapping.

v2:
  https://lore.kernel.org/kvm/20260423182517.2286030-1-mattev@meta.com/

 - Don't fail if resources can't be requested or iomapped, even for
   valid BARs, as this would change the userspace-observable error
   behaviour.  Specifically, if there was an issue with one particular
   BAR which happened to never be used, then userspace would never
   encounter an error for it.  Track iomap and resource-acquisition
   status per BAR.

 - Break out the checks for resource success from those for iomap
   success, in the form of the two new helpers.

 - Third patch to add the check to VFIO DMABUF export, because
   init-time requests can now fail.

v1:
  https://lore.kernel.org/kvm/20260421174143.3883579-1-mattev@meta.com/


Matt Evans (3):
  vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()
  vfio/pci: Check BAR resources before exporting a DMABUF
  vfio/pci: Replace vfio_pci_core_setup_barmap() with
    vfio_pci_core_get_iomap()

 drivers/vfio/pci/nvgrace-gpu/main.c | 11 +++----
 drivers/vfio/pci/vfio_pci_core.c    | 47 ++++++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci_dmabuf.c  |  6 ++--
 drivers/vfio/pci/vfio_pci_rdwr.c    | 42 +++++---------------------
 drivers/vfio/pci/virtio/legacy_io.c | 13 ++++----
 include/linux/vfio_pci_core.h       | 20 +++++++++++-
 6 files changed, 81 insertions(+), 58 deletions(-)

-- 
2.47.3

