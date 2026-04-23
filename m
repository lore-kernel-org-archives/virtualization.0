Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170525A2BB
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968741; cv=none; b=YA2Vc1lzCxteR9abWseGws4FvAgpU2Avn4LKTHXmKb98S3sivcJJwvx0KFdP2E/xZ+bgXghczdN722YiCCf9cTc5bw35jLHupsvzkFkP/MX6JAIsItW1lVUwg0ZdoOSDWpp563TyOhR+rOzsrxuXntLP8I81NZICjtB98fnqYGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968741; c=relaxed/simple;
	bh=oWNEM6jnYyfWzRXF8wCV0h45OFTGIH/LQA3zNpeI+P0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iYUDDSEeCtj1nIRoEdTfH1HVPDq9pHNf4KNS7xPboR0HSqQYB0aGJI8llaCAwAovlRpLZB4RpdquypE/ovmX+cQKYj7y1NLXxETGaKLFHNa/fQpovmrN/YgBPq6DpSpAFLmx1efv/jiA+7v/8LCr20ti3Ms7RL7vN6cjM8b5gUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WSL9zXud; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WSL9zXud"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NH8t7S2499036;
	Thu, 23 Apr 2026 11:25:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=LklIq/rv1EFSTQEz+p
	2441/vx1iffgZbusssJoT0mF0=; b=WSL9zXudruPuggHDijjodQpx62ywSAdFJW
	i1swOUjuqjxoENLB+paXsoGRTT4dVcNNhRTdDQt3tL5N6AfpcH8QMA/qOn6u98Vf
	spuiRIKXjTJni4K2F3M8Wh62uIEOdgkr6XDJiLFa4CC+/J8Io8PSE1LQ5OtMYUQE
	q4sMYEzjA9+ncagqjVFVz8Td3HuICv/xdHY63z5KrD1el30CjMw61lPNV0CfONqg
	HFYviTZmGe/MqIyPcGxEJZ8AGp2FSBU/edMzV1bpmh1s33pmKbpnCHZ513Fn8/TT
	blP0Hd4FYRr52AQylQ7H4+480/+d5P/nxqizZY0X1rD4c/ciolRA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepcxsf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 Apr 2026 11:25:36 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 23 Apr
 2026 18:25:28 +0000
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
Subject: [PATCH v2 0/3] vfio/pci: Request resources and map BARs at enable time
Date: Thu, 23 Apr 2026 11:25:06 -0700
Message-ID: <20260423182517.2286030-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VKLtWdPX c=1 sm=1 tr=0 ts=69ea6420 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=k94C9gkFF5w_uSWTU5gA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: P9JcLlLeo4xlQccZvg0D8lxtzsi4tf5F
X-Proofpoint-GUID: P9JcLlLeo4xlQccZvg0D8lxtzsi4tf5F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3OSBTYWx0ZWRfX+lvHzz5cK9QM
 TQvoqpJw0TspefpslQPv5ufXvHNQcVmDWf6xE704+cNnuipC0x6/93AWpx31ID6Jyi0LACq7lnb
 /7b0QymeTcRspfl5jZvqxvaJbVL94BHI5ucscilGQ1OwSmffC/c/qrWbUjm1y0RJKoopxX5wocL
 BLyuisva/SsSd2rkNBHo8Ai/vSQx90sohiXa//poKvjtdkU6h0MqGR5qmCYLpCnowXjBZsuNHY4
 ikdQ0asPW6nuYAVyCWvOmXRYk6rUJaxo4MGfZCJutca6HxdwoHbcxfqocZQSWimdbE+OVPBL2jf
 zzhyCvZ9ibDaJVMQZwtErz9uuaoWopBwKqKDKYrt1JBSV2YORwcZi3jD94m9SaYLdPWNUrr9gDg
 PeD0nlVl1wYQ0Tg7JvplevHHyJlCjGMUJa4dOcD/zBl1wSAOwfd6d3+0v6LdbReUfQH1d2Bkpe+
 6jWI+h2j37YcRwD4Ajw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

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

The first patch requests PCI resources and pci_iomap() of the BARs in
vfio_pci_core_enable(), moving this out of
vfio_pci_core_setup_barmap().

Some callers relied on vfio_pci_core_setup_barmap() for its ioremap()
effect, and other callers use it for its resource-acquiring effect.
The function remains in the first patch, containing a cheap check that
both these actions have occurred and keeping the same error behaviour.

The second patch then removes calls to vfio_pci_core_setup_barmap(),
in favour of two small helper functions which make it clearer to
distinguish code that needs just the resource (e.g. mmap) and code
that needs the iomap as well (e.g. the rdwr routines, or virtio).

The third patch adds the resource check to VFIO DMABUF export, which
was previously able to export an unrequested resource.  Although patch
1 at first appears to fix this by requesting resources at enable time,
code using the BAR still needs to check the resource really was
acquired.

In future we could reconsider performing all the ioremap()s at startup
time, since a lot of VFIO users will never access BARs in-kernel and
won't need them.  Mapping huge BARs will cost some time & memory, and
if necessary this could be reduced by doing the ioremap() portion on
demand.

=== Changes ===

v2:

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
  vfio/pci: Replace vfio_pci_core_setup_barmap() with checks for
    resource/map
  vfio/pci: Check BAR resources before exporting a DMABUF

 drivers/vfio/pci/nvgrace-gpu/main.c |  8 ++--
 drivers/vfio/pci/vfio_pci_core.c    | 66 +++++++++++++++++++++++------
 drivers/vfio/pci/vfio_pci_dmabuf.c  |  6 ++-
 drivers/vfio/pci/vfio_pci_rdwr.c    | 29 +------------
 drivers/vfio/pci/virtio/legacy_io.c |  4 +-
 include/linux/vfio_pci_core.h       | 24 ++++++++++-
 6 files changed, 88 insertions(+), 49 deletions(-)

-- 
2.47.3

