Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5A3FFAD2
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511536; cv=none; b=PgrimSzMN2BkSuL6XIZmM0orjjKh9h58HYHQNX9d5oRN9RlBhiA2DZAEe4/MRd94VgSecMTKiYfX8W6nWw8jF4zEWIOE5xxuEvy6dyVnBj43sDfaXu6UPrM4UHOFuqvYesQC7KDm+awDAEX++ppkvdZByHRCcBsH6OLj9VCis6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511536; c=relaxed/simple;
	bh=aS/viXDpnIcjuVwxw9cSHrU+kK1uzS4ma3eXzqx5OqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kk9TRrE5Z+Jc8EFXVS/osLLAoHrWGFDQ2c0+Y248AwJ0+y4zP/OJTRij3Lt69sUCPVk5rHPWftHEc5SN//s/rz68VXY9PjPb1zYuojWnaL6XdF0YqF9PedcAfqG/55rNshU/P9L2yXwxm/sFP6eDltCyIYv7YhIB8LEuHlNwzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=rSB/XxKJ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="rSB/XxKJ"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BEwA761286452;
	Mon, 11 May 2026 07:58:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=Mi7OHQLoUkr4cAFXSK
	75uEyuAhLn6vXF3cQZija/bpg=; b=rSB/XxKJT7dfU0sYVhTW3WUalHQxDKu2OV
	QgX51bR02I23iww3DlWLa2h4XUptfsSbFBR2buUc41nfgiKS9U6e/nW01bBubnGL
	AUQ8HI9i0CL10XMPZxEhvT3LcYQ3Cs8xNIMxx3QWoMWW6wFDO4Cm5nY48hEZ4Hwq
	ji23MPfMKdixoeBwBPItesoZrJtFbi+Fhf4I7xpYfAJjozwCynryPP3mXXNoYqNT
	Wat6MgeYd/4bI6/4loGZEueV7OqffNKNBUCPdNbDD9ziOEsU4U18JnAygJAN4vZS
	90dwPF0jDH3U1Lv4lupeRkEhcFs/ba9KPIxXA4bGu6P8u9Grllpw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e2pp66e3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 May 2026 07:58:51 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Mon, 11 May
 2026 14:58:50 +0000
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
Subject: [PATCH v5 0/3] vfio/pci: Request resources and map BARs at enable time
Date: Mon, 11 May 2026 07:58:22 -0700
Message-ID: <20260511145829.2993601-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _e8Y9XhTCvtTMnDRdkIGMMavRFCh8Ob0
X-Authority-Analysis: v=2.4 cv=IP0yzAvG c=1 sm=1 tr=0 ts=6a01eeab cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=fFA4BOaLBG0vzsxRvVMA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: _e8Y9XhTCvtTMnDRdkIGMMavRFCh8Ob0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2NCBTYWx0ZWRfX2MMjYr1Lfes5
 yc78wfAueWNyXlld4YtG6yksecXWavh9HTg8hEF7UiOvZYyiFf3uRy2zuAGjPBRcoJYx8F1QhUg
 EIDCfaLi+1luoCwZezo/rXpH8RdPMTpiMIWK3+YPS+4Ro6NOf0iYd1/eQClv1CkzPZclp1UCwPo
 IZ3MPd2V3v4SOKCuhhRCi16HYViZxq0FnnJj9m+tz3/lPf7ATXu1tbReZOQkI/fBs6nrL+D8buw
 cKO76tR7Co7puvRiOVp7Mrbfs33WdBw5KRtMJEDYqvi/9We6WRXyL0kVdbs9M7GcniYsLtC/QFh
 KsCzebxW39LS8lgj+WgMWW0V3gQQ9TFPe0Zbgj5HlooosJlf+qW2MjYjv4oaLU4xco60H4jQkTb
 qQyIG6Mhg5zwxSoQKqLnldMNGdK3o765eui1J3gIjQA412hDZmUtrQ8+3YUkZEd8wwEG9zRQMYi
 hdWY1WR4t4uCHAwm0Xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01

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

(FWIW, Leon gave a R-B on v2 in
https://lore.kernel.org/kvm/20260426111606.GC440345@unreal/ though
this repost isn't 100% identical so I didn't propagate it.)

The third patch refactors vfio_pci_core_setup_barmap() plus the various
vdev->barmap[] accesses into vfio_pci_core_get_iomap() which returns
either a pointer to the mapping or an ERR_PTR() describing why it
doesn't exist.  This is used by callers that need the mapping, but
also by other callers to check that the resource/mapping step was
successful.


=== Changes ===

v5:
 - vfio_pci_core_map_bars() releases the region if the subsequent
   pci_iomap() fails
 - vfio_pci_core_disable() correctly tests for NULL/error
 - For nvgrace-gpu, check the result of vfio_pci_core_get_iomap() at
   open time then stash the BAR base for use later on.  Errors are
   checked up-front, and this avoids the perception that a
   later ..._get_iomap() might fail.

v4:
 https://lore.kernel.org/kvm/20260505173835.2324179-1-mattev@meta.com/
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

 drivers/vfio/pci/nvgrace-gpu/main.c | 20 +++++++-----
 drivers/vfio/pci/vfio_pci_core.c    | 48 ++++++++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci_dmabuf.c  |  6 ++--
 drivers/vfio/pci/vfio_pci_rdwr.c    | 42 +++++--------------------
 drivers/vfio/pci/virtio/legacy_io.c | 13 ++++----
 include/linux/vfio_pci_core.h       | 20 +++++++++++-
 6 files changed, 91 insertions(+), 58 deletions(-)

-- 
2.47.3

