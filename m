Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD72C0307
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597136; cv=none; b=IpCu2/r0jTQ7Ia9Cvm+fbZPn+4SDvTIfwD6n1r2jf7BTe+ozd9D8kH1RPcPzCLEBCU58kqruMvjQZbKPknU6CCrHSqfXNMOkhcGI5QD3fzZG2W/1oRXoJ4ZCp8dxwAUkMwm8hFH7pQO3I4YUyoWeenGrGsyXYuIGAW0TJx80GIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597136; c=relaxed/simple;
	bh=T2n6S3Hip8ALDwtgzJsRE07Dwme3jNgyNJ9v+3yTLdk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hjyxmvR89wCIWHxxT0KA+69qmLaTdvF2yBe4h4zubnOKEHvK3peUMgBgI6HLt7aQOKQZUMl7BVK3XMS+VGkbRzBXL7KUQ13KKdh89LGpWnRAH3hQVqsBV/3mtSUk43OfVV5LwA4aWPO+K3gTiD0WJk2X5YPu+tUxbPfpF8TbQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMCHutBi; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMCHutBi"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c1e1a6cfbso3777718b3a.0
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775597134; x=1776201934; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dxNx3kEadxMVt+ezqmLAsD+9NFOi3aPx7y/U/ZwLHXU=;
        b=YMCHutBiOUcwS5SNrAv1jZPQbkV9r6BRM24ThhTc504hHJeXUvKPX/r2C1GHos+uwX
         iwl7o801RpNaerH+2M8AkIzTADnxwOC7y+OSxXlPLG6HwqHSnSDw44Odh0X08C/l0QJJ
         I0s6T99++zKSUTReJal++Q2GWvCv3wDMfQ7vdpJSaoi1WmF1RUU66msvZ/f+W4HVFzPg
         cbA9U/QBEdj8C7u/XCuW4mdevlQGq6dUth/M3195jB21dh69dR2VRuUNcUGEbaroBTBa
         VkyiWBXIDoJsh3mIuX3ZbYRQ4JgBufucDjUwwaxzLtpf01HWCalVmJVwiIETILCS+AKO
         3gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775597134; x=1776201934;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxNx3kEadxMVt+ezqmLAsD+9NFOi3aPx7y/U/ZwLHXU=;
        b=BsCVwO3wmbLL0uMtwtD82xQSLQxKpAMN+9uSdck7+j4OR7iBbgaA0+OPXQMtytgQ3F
         bZy5ParX6VStE7ZtH9vLvy1WxFKxXi1+jJhKfT8PSCnseUpoq5ZOsQt3bOCyMv5/Lvwl
         TXX8wvxiXk8ekLPVNl08teloSghH293sJvI/Xb+3oM4HAbvodIbbLlHAEjZSxFnYeou0
         srMN8XqcMl532xubdKiXwFzXnY4QMLPdKqKV+wt1+5C3/MPzpMuhDnhTtxhtw/A4Gu3u
         6YXL+OR2Tl7JYJF3Zo3UyHddRfjxgoG9vY7fO1dnVIoRJ9FV3P6LXPcU0Jp+QhJi3i1E
         XrKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsJD9kE37OdVd/sVcEwWQKYNvtELfXLcCIcHpyGj+CdiJioQXC3vObeWBEp5aZZwUm8LS67KB24qBXwm0flA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBA3fKq3g6bj94SpyFIcjllruzey5q0qB9VyAviXvv+SMjFaC7
	gqr4DlcYtdJe1DvH/nplNGI3ekyWm8CB9lQf9KuP9GWGw6D4KqIiRg6Cx78hrSHZCawcnIDb/v2
	Kcw==
X-Received: from pfgs39.prod.google.com ([2002:a05:6a00:17a7:b0:82a:108d:4308])
 (user=linkl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c92:b0:82c:d6d3:3197
 with SMTP id d2e1a72fcca58-82d0daadb73mr18952159b3a.23.1775597133722; Tue, 07
 Apr 2026 14:25:33 -0700 (PDT)
Date: Tue,  7 Apr 2026 14:25:21 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212521.934620-1-linkl@google.com>
Subject: [RFC PATCH v1] virtio_pci: only store successfully populated virtio_pci_vq_info
From: Link Lin <linkl@google.com>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc: eperezma@redhat.com, jiaqiyan@google.com, rientjes@google.com, 
	weixugc@google.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"

In environments where free page reporting is disabled, a kernel
panic is triggered when tearing down the virtio_balloon module:

  [12261.808190] Call trace:
  [12261.808471]  __list_del_entry_valid_or_report+0x18/0xe0
  [12261.809064]  vp_del_vqs+0x12c/0x270
  [12261.809462]  remove_common+0x80/0x98 [virtio_balloon]
  [12261.810034]  virtballoon_remove+0xfc/0x158 [virtio_balloon]
  [12261.810663]  virtio_dev_remove+0x68/0xf8
  [12261.811108]  device_release_driver_internal+0x17c/0x278
  [12261.811701]  driver_detach+0xd4/0x138
  [12261.812117]  bus_remove_driver+0x90/0xd0
  [12261.812562]  driver_unregister+0x40/0x70
  [12261.813006]  unregister_virtio_driver+0x20/0x38
  [12261.813518]  cleanup_module+0x20/0x7a8 [virtio_balloon]
  [12261.814109]  __arm64_sys_delete_module+0x278/0x3d0
  [12261.814654]  invoke_syscall+0x5c/0x120
  [12261.815086]  el0_svc_common+0x90/0xf8
  [12261.815506]  do_el0_svc+0x2c/0x48
  [12261.815883]  el0_svc+0x3c/0xa8
  [12261.816235]  el0t_64_sync_handler+0x8c/0x108
  [12261.816724]  el0t_64_sync+0x198/0x1a0

The issue originates in vp_find_vqs_intx(). It kzalloc_objs() based
on the nvqs count provided by the caller, virtio_balloon::init_vqs().
However, it is not always the case that all nvqs number of
virtio_pci_vq_info objects will be properly populated.

For example, when VIRTIO_BALLOON_F_FREE_PAGE_HINT is absent, the
VIRTIO_BALLOON_VQ_FREE_PAGE-th item in the vp_dev->vqs array is
actually never populated, and is still a zeroe-initialized
virtio_pci_vq_info object, which is eventually going to trigger
a __list_del_entry_valid_or_report() crash.

Tested by applying this patch to a guest VM kernel with the
VIRTIO_BALLOON_F_REPORTING feature enabled and the
VIRTIO_BALLOON_F_FREE_PAGE_HINT feature disabled.
Without this patch, unloading the virtio_balloon module triggers a panic.
With this patch, no panic is observed.

The fix is to use queue_idx to handle the case that vp_find_vqs_intx()
skips vp_setup_vq() when caller provided null vqs_info[i].name, when
the caller doesn't populate all nvqs number of virtqueue_info objects.
Invariantly queue_idx is the correct index to store a successfully
created and populated virtio_pci_vq_info object. As a result, now
a virtio_pci_device object only stores queue_idx number of valid
virtio_pci_vq_info objects in its vqs array when the for-loop over
nvqs finishes (of course, without goto out_del_vqs).

vp_find_vqs_msix() has similar issue, so fix it in the same way.

This patch is marked as RFC because we are uncertain if any virtio-pci
code implicitly requires virtio_pci_device's vqs array to always
contain nvqs number of virtio_pci_vq_info objects, and to store
zero-initialized virtio_pci_vq_info objects. We have not observed
any issues in our testing, but insights or alternatives are welcome!

Signed-off-by: Link Lin <linkl@google.com>
Co-developed-by: Jiaqi Yan <jiaqiyan@google.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 drivers/virtio/virtio_pci_common.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index da97b6a988de..9b32301529e5 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -423,14 +423,15 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx, vqi->callback,
 					     vqi->name, vqi->ctx, false,
 					     &allocated_vectors, vector_policy,
-					     &vp_dev->vqs[i]);
+					     &vp_dev->vqs[queue_idx]);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
 		}
+		++queue_idx;
 	}
 
 	if (!avq_num)
@@ -485,13 +486,14 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vp_setup_vq(vdev, queue_idx, vqi->callback,
 				     vqi->name, vqi->ctx,
-				     VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[i]);
+				     VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[queue_idx]);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_del_vqs;
 		}
+		++queue_idx;
 	}
 
 	if (!avq_num)
-- 
2.53.0.1213.gd9a14994de-goog
