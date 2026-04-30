Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704938834
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543436; cv=none; b=J2XIeHN/HXKOBXhHU61mCUiIEvXn7Qsx0xNuQRRH5ZzfGp2+c+BM0Xgyqg6ODzT2mphr10yxG+W5qMw5ITGumwhegsdCD32oDZLOMHC20jQS+82MD72i0NVssU2CtBtyOVLjn6BGf8On9E1gNNMe1xQ8bcJDjqXrFwlU0QYnTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543436; c=relaxed/simple;
	bh=oP1sNw3lOw6zB5Y/XHldmRoMKbeGbgHUXpQzx4+4Mq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qOM//xgrEofCXhw8IKmaUcMjzKnC0q6TWBAfSnH/vD1ck0mP3hj3n5r36kU1jBBzdiu+4cfoD5c4GRNAKohzflDpo+LBnJnOBvcSPiRAgs1WuGFL3KsJZN7PuOYAspQScfVEyTe/42IwA2ga59qr7G21gBNeCdxKlWBzGIB0zHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kH3hSo2u; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kH3hSo2u"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U6NV2Z3593963;
	Thu, 30 Apr 2026 03:03:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=GjFDQPDXNHcpO5qiMh
	fQwTAt8BEUXKtlfSQH1GN4nOc=; b=kH3hSo2un8OHXX2nUVQZOxKZtnf7GjZs0w
	4sspuH+9gpgZfi6CL/J1b9bd7MxdCFwGXtRiZaMvC8bqGNZwAFF3qNckFd7rpWUg
	CrHrtjdbeuEvwwW2waMA2OCbhJhziU5dgsXqQG0RCb0Y4FT1vcbKG5CoAYCtfO7m
	CSWLS/kNlfm50v8GOEZ/7NnKm07+DA1wuSQU8L1fA68y0/HDmLioWs3Ify2iZDIb
	RAgmBn2ErBXpOPJWd3Hejd78cK/4fh64ROpM7jFnkE0NOogzP0WPjeGLHTcAQQ8u
	RijYRXf3UpZkRe5LdVXVPRXwcd1ITL28AU10d6eQ1z1UabMofz1g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dse8nd67e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Apr 2026 03:03:49 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 30 Apr
 2026 10:03:48 +0000
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
Subject: [PATCH v3 0/3] vfio/pci: Request resources and map BARs at enable time
Date: Thu, 30 Apr 2026 03:03:19 -0700
Message-ID: <20260430100340.2787446-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ou6f_EeCtD1iu2B9KAFMNHRqQoh9NRWO
X-Authority-Analysis: v=2.4 cv=XLQAjwhE c=1 sm=1 tr=0 ts=69f32905 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=18-LhrYFQHd_5z6HW7oA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: Ou6f_EeCtD1iu2B9KAFMNHRqQoh9NRWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwMCBTYWx0ZWRfXz1bTEZeDZ7UD
 cT5EUaGv6PQDJBywzI7qOIfiXCTFS8zlBccn8VG93IqRTqn1S2Uygh8tIpAwqt6tr5qZNYMjpHR
 uZka/lGhis8/3IVvFhD65i7DqghznnQTJzAOR91XEvbqq1AX44SYcpMZu2AblIXVG2DgcBzinwh
 rAPvJGXAZB3xxf3R86OKobWP3XUzjZ9l06rm/UE9wVsiiEg6q6zMEH0lYvR8qruvcfAg0v9mQlT
 iv0gVPBwOZJOmlaBHBERp/8GYWqsERMhQX79SKb6Y257vlq+TKDbo4s1o6XgW20KkXKm2m+gQ9k
 ueuf8KNq+Lzxb5o1B+s+Ea5QHdsbqsxISpjk0U/OB+DjUEARw4zaok1Ml94gJg8Mou77jBQPkXN
 GB+k/M2oZhDK4nQIhGGBvpaC7b/zY5Me5KrRWsLPxEcecSz6Tod2sbrfu6dWCOt+jxwL9WT+HW6
 mgamtLYa0sm9dSU9BjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_03,2026-04-28_01,2025-10-01_01

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
have occurred and keeps the same error behaviour.

The second patch refactors that function plus the various
vdev->barmap[] accesses into vfio_pci_core_get_iomap() which returns
either a pointer to the mapping or an ERR_PTR() describing why it
doesn't exist.  This is used by callers that need the mapping, but
also by other callers to check that the resource/mapping step was
successful.

NOTE: This removes the EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap).
It does not re-add an export for vfio_pci_core_get_iomap() yet.  (I
wanted to check the preference/policy here.)

The third patch adds the resource check to VFIO DMABUF export, which
was previously able to export an unrequested resource.  Although patch
1 at first appears to fix this by requesting resources at enable time,
code using the BAR still needs to check the resource really was
acquired.

=== Changes ===

v3:
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
  vfio/pci: Set up bar resources and maps in vfio_pci_core_enable()
  vfio/pci: Replace vfio_pci_core_setup_barmap() with
    vfio_pci_core_get_iomap()
  vfio/pci: Check BAR resources before exporting a DMABUF

 drivers/vfio/pci/nvgrace-gpu/main.c | 17 ++++++-----
 drivers/vfio/pci/vfio_pci_core.c    | 44 +++++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_dmabuf.c  |  6 ++--
 drivers/vfio/pci/vfio_pci_rdwr.c    | 42 ++++++---------------------
 drivers/vfio/pci/virtio/legacy_io.c | 13 ++++-----
 include/linux/vfio_pci_core.h       | 19 ++++++++++++-
 6 files changed, 84 insertions(+), 57 deletions(-)

-- 
2.47.3

