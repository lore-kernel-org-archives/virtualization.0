Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807483AEF55
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478797; cv=none; b=UqhZkLZMC1L9PpOAnlPJYpWbbqIgb0eDbonNVaiAUeZROXx07RukLravEwb7uHjjOdjPQyBOSk9x+nKKbPWHtBO8k/bmitDLGNhPqLXdWnSLsMFqN3vox2hlcStTO5BJ0m8zAVjxuiHyO1UD5o7mi4mJa3DmbLhHjQoSm+eXcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478797; c=relaxed/simple;
	bh=DPS89jnvGKfosnNmRUYPSk22BtY8EzulP4pxtvNuLic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cpf5kU5SZ9n50ElP2urBgD86wPnPlP6Z9lzesDdwrewJ3YJgd77DnqbqWUHhPt1Nat8+UAaZgg9cGc0Bb2RUZRvLSqt6bE2rh62y5J9US0ta4uU9tUfVpONKK/KwYYf9XHExmwN5jUnfPYJU6L4XkAHRNDx0+bWKAyuXGR5lMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4j0wjw3TzqzBDpk5;
	Fri,  9 Oct 2026 00:41:24 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.46;
 Fri, 9 Oct 2026 00:41:53 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <dmitry.osipenko@collabora.com>, <airlied@redhat.com>,
	<kraxel@redhat.com>, <tzimmermann@suse.de>
CC: <gurchetansingh@chromium.org>, <olvaffe@gmail.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <simona@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>,
	<chenjialong@xfusion.com>
Subject: Re: [PATCH RESEND] drm/virtio: expose GEM memory statistics through fdinfo
Date: Fri, 9 Oct 2026 00:41:34 +0800
Message-ID: <20261008164135.510-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <ce72b2f5-1343-44e9-89fe-e2de4efb7e9c@collabora.com>
References: <ce72b2f5-1343-44e9-89fe-e2de4efb7e9c@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03045.xfusion.com (10.32.131.99) To
 wuxpheds03048.xfusion.com (10.32.143.30)

On Thu, 8 Oct 2026 00:44:34 +0300, Dmitry Osipenko wrote:
> Usefulness of this change is dubious. VirtIO-GPU has different types of
> RAM, I'd expect them all represented properly instead of only shmem.

Hi Dmitry,

Thanks for the review.

Agreed that a generic memory collector does not map well onto
virtio-gpu, given its different memory types. For v2, I plan to
replace it with virtio-gpu-specific accounting and to document the
semantics of each reported value explicitly:

- Guest shmem objects: reported under the "memory" region as
  drm-total/drm-shared, based on the guest GEM object size. These
  reflect the requested buffer size; drm-resident, if reported, would
  be derived from the actual state of the guest backing pages.

- Host-only blobs (VIRTGPU_BLOB_MEM_HOST3D): reported under a separate
  region, tentatively "host3d", using the requested blob size. These
  values would be documented as logical sizes and not as actual host
  RAM or VRAM consumption.

- Mixed blobs (VIRTGPU_BLOB_MEM_HOST3D_GUEST): the guest shadow
  backing is accounted under "memory", while the logical blob size is
  exposed through a separate, documented supplementary key. This
  distinguishes mixed resources from guest-only ones without
  presenting the supplementary value as additional measured host
  memory.

- Imported dma-bufs: handled explicitly, without assuming that they
  are backed by local shmem.

Usage of the host-visible memory region would be reported separately
from the backing statistics and would not be used to infer host
residency.

The actual host allocation size and residency, including legacy virgl
resources and the host part of mixed blobs, are not available through
the existing guest/host interface. Reporting them would require
additional host/renderer support, so I propose leaving that out of
this series unless you consider it a prerequisite.

Does this scope match your expectations for v2? Are there other
memory types or accounting semantics you would like covered?

Best regards,
Chenglong She
