Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5571323416
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793326; cv=none; b=Iic5+CPDZBapK9uOyyT23egRyNsPRvWEOd7Mwpfn7SKDkDddSLGlmTB0KIV2jfGK2/Ul4GTvWaIwSQdLS5jJe2vt4JKYHFGdVYR2dB5OzvmKbNXJ/9uV65ANJf8M28sw/BX7nig5QUwofxPKpeGes9WV9l1YGX/0UYKq8n19IOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793326; c=relaxed/simple;
	bh=GqP4rC72lvsoKkxqh7wocjIKniwoWkJo9j4pCiPW4bo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0x97nZfbcH1qH/w13fKkWsog/PeUrDUHkMcDyw+hKQabt3wze05JHljfKNyrTEbNhwuZuHRc40fmYpyyJxdQgw8Yn4H8jer/zxdVNIZGxPbzc0hQDNnlQ7xVfJRsQHiUF/7bDB9JDh+BRBoqGc+kvkzxZ7ktohqDbQv7szCAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DRAZK5BL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DRAZK5BL"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LGOQYi2716404;
	Tue, 21 Apr 2026 10:42:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=w61+ZLNNG/rJy0/a/Z
	LfPONH+uo3mgVWgtkpMtUEY+I=; b=DRAZK5BLbpiKerMU+Jp1Vw/vNUSZtrbn1X
	3T8z4RKmJ3O47N9Vp2laROIfGqFxvgC3KttJj+YZd9wqWKgh/CdUjw/o+jeBffQy
	xO3a1r6uAn/qkKl5XXzIoUgy1X7/1iBB98ZQYidlucf99zJXnWDaCc/Ykb8pgNru
	r0XmPJwCiBItct7RKR6yu3CChe/vf1PMjHeziRdPDBzMoBSlIABAtZz/yK9THHWK
	9pZ5+siFQFraJgSZa/VdvSNWfLqTs0lIIM8rFeRLeJpZzSdEeLXuPxdT5F6ge30z
	4GeGynPpseztYpD0Ks4varS8BIzwLuD+3fGNy6Nx8IqWDTzyeguw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm7251w6a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 21 Apr 2026 10:42:01 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Tue, 21 Apr
 2026 17:41:48 +0000
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
Subject: [PATCH 0/2] vfio/pci: Request resources and map BARs at enable time
Date: Tue, 21 Apr 2026 10:41:39 -0700
Message-ID: <20260421174143.3883579-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TSZXcETC2u7nWQePiyTRxTJrRtJaOJNf
X-Authority-Analysis: v=2.4 cv=HLnz0Itv c=1 sm=1 tr=0 ts=69e7b6e9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=WbOA8YzAibo6ldFk1VgA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE3NSBTYWx0ZWRfX0YOhsfACB4xL
 xtVBZftSRAiPKS1ZNAvWPR5fbLvE7H3N5Sgp9UPat2WpuRsXW3/6fbla2URQ1ar1aspoiI6akOb
 sPqNAyQRr+G4Ef1TY2r5DsFZljIqE8t1d11CfzVkVdO0Fh8UXXJVdt3Xcj0yN8okBpG9/Hciq4O
 CCWJosbihi2D3/7dRk8Zgg5wh8GjIy4KXtWqDgtQdQXAXjiRUrAka9soyKRXdCLlmN9P8eLLH8t
 sm5uImh9H1exdQAwPdlaX4PP2Fo7a0CPty4mT3Q7EjVvJwJxzenC7zGA8nxKNfxIyB45v5wP0gw
 FTQCsPF1iLOuAjbOdkt3sS0qRgCk3sO7/9K/QQv3xlTOt+WLDNERKZWMzEbZO+8rUyGSRqo0/GE
 0uwV22KRc7Ypj+v306tXlL5QW3p1CHPPiVFM16zfz/tUjifio2/Xr54mtAImdT0e1zcK15TSEUb
 ce8+JA/o5NSuiXoBPLw==
X-Proofpoint-GUID: TSZXcETC2u7nWQePiyTRxTJrRtJaOJNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01

Hi,

This is a replacement for these patches posted to set up the
VFIO barmap in the DMABUF export path, and add serialisation:

 https://lore.kernel.org/kvm/20260415181423.1008458-1-mattev@meta.com

Those patches were motivated by the DMABUF export originally missing a
call to vfio_pci_core_setup_barmap() and so possibly exporting a range
for which resources weren't yet requested.

Responses in the thread indicated there wasn't a strong historical
reason to require the bar-mapping to be performed on-demand at BAR
reference time.  It's much simpler to move this to
vfio_pci_core_enable(), and that then avoids having to deal with
concurrent lazy requests.

Now VFIO drivers requiring the BAR resources (mmap(), DMABUF export,
etc.) don't need to do anything else, and there's nothing to forget in
future code.

The first patch sets up the barmap (requesting PCI resources and
ioremap() of the BARs) in vfio_pci_core_enable().  It can be
considered a bugfix for the VFIO DMABUF path.

The second patch removes calls to vfio_pci_core_setup_barmap(), which
were left untouched but harmless (just a stub) in the first patch.

However, vfio_pci_core_setup_barmap() did two things, requesting
resources and ioremap()ing them.  Some callers relied on it to perform
the ioremap() just before an in-kernel access to the BAR (e.g. the BAR
R/W routines, nvgrace-gpu).  These calls are replaced by a cheap check
that the required BAR has indeed been mapped, keeping the same
behaviour.

In future we could reconsider performing all the ioremap()s at startup
time, since a lot of VFIO users will never access BARs in-kernel and
won't need them.  Mapping huge BARs will cost some time & memory, and
if necessary this could be reduced by doing the ioremap() portion on
demand.


Matt Evans (2):
  vfio/pci: Set up barmap in vfio_pci_core_enable()
  vfio/pci: Remove vfio_pci_core_setup_barmap()

 drivers/vfio/pci/nvgrace-gpu/main.c | 11 ++---
 drivers/vfio/pci/vfio_pci_core.c    | 71 ++++++++++++++++++++++-------
 drivers/vfio/pci/vfio_pci_rdwr.c    | 35 ++------------
 drivers/vfio/pci/virtio/legacy_io.c |  5 +-
 4 files changed, 65 insertions(+), 57 deletions(-)

-- 
2.47.3

