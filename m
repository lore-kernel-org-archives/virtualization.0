Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D0434AB14
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209020; cv=none; b=lVj8pxp3Mwq1zBG3USfiJeCSJI2PrqQSV+JWrtxvLZ8PE6jphri5JORXX3s3UcU+iqOr+00DCKinMc8keZ1N2sQDrqi3N0w00QHGiifMA4P/iVSGzPpGvqvm8v2/a4R5JBrsawdZFXgZdCfWk/fHCDTGgw+cY/bIBp6h9oKBhxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209020; c=relaxed/simple;
	bh=uidliuKGHw2E/ldvvPAHKDIwXVmXlX9yLSj8Rr6/5q8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fCFdIGV4EUGLPgNUsbju9PWnaLJkqsxlDvfVE/RS5AjEvnfzOsdiCf1g6Zg7HszTwKrlHv3DpfwrecpDRp/Cf7u43Qh/n6svzS9tnNcZoanfcXE9HORibyAEhV/fN9B1KVMqgQwBdExIc2YlEVXF49g8bvieQ8NbwzUe87CqTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehIKw9AU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehIKw9AU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789209017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tKE4fvWSK04nXM2Txdsuz1dl1KZf76ZKjdSpilIXM+w=;
	b=ehIKw9AUG5XB2iCO5/p9yki0KcPNKBGQriw0QzkwCc6rzfn09b09qbe4o6XkzNbbFKUY80
	x1fA5JXqvXNfVB1KKax+0O2hOxndkGGTucmjC7MpW6CKn7KzEqBHVVRGQz5ri34s65HtwQ
	Vs7k8/E7zoSOAjKx/8Oz/qe21phVr/k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-Co_sBoBGMlGGMd8nkh1RKA-1; Sat, 12 Sep 2026 06:30:15 -0400
X-MC-Unique: Co_sBoBGMlGGMd8nkh1RKA-1
X-Mimecast-MFC-AGG-ID: Co_sBoBGMlGGMd8nkh1RKA_1789209015
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cf5bd2f12so18314845e9.1
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 03:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789209014; x=1789813814;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKE4fvWSK04nXM2Txdsuz1dl1KZf76ZKjdSpilIXM+w=;
        b=KWLxfZgFOaAKBHkakXYvptS5D611QaeDRCgbtyaP9NRPGYYyLB0h8y5aqflOqBVSxZ
         gDxQVGiAwLMIWTiN3vS7/a389ibh/63Ta7GHCqyJLRaCNPG3I3L8Dhyos/q5EtHH0lkR
         PAKs/vM7PzBH99En6rQOmLLetaYYlKLTTXejmb+H0Pwl1ohuAzB6QwFRj6BiduFKmwJL
         lUffy4fdqrumuXkTE06sqZvbexsjkVhExroPvP4kbatWfsKvtz7f7uGjjdp06EsMDVQQ
         V9o8O91JjnkauFQahyGQFaWDAbu1IiV7XPBvWUFHgfU5+pdC4w0IJ8wsyF6JtGMdbGYH
         vLmw==
X-Gm-Message-State: AFuF++mBxkqVlSrgtp9z2a5Y6D/LOAhLMg+dmuzVDeGGNY7E0LI7hkf/
	IR3+iWil1GJ//JXpCEBvlWdf5kv0sVDBh834/fgovh+06NK+rhJiEv3/AjX3z3poomL+koCidCp
	sSy4769sVhgjcffK6H2zHTsPLwC0rgIoF/0OVyoO0letAP2sjaWr1j3rDZZm00CqOaC4kQs9hVV
	rBLEAWZuJV45GB1ny+YAxBVj8rpdFOETG97CWh8lq052YznA==
X-Gm-Gg: AYBFou0gBHySN/A/4DZ//0UoDpBBg7LNzdQe+aMX223uLYQ0r4GzRwAXwKWEwDDejid
	qYDK8HeeVSa8gvHEbfle5WKh1nF79ACZKQvvZFS0O6drTY9SO5527kS/W80PohDX86Phgihonws
	WDDsvlfsfSoJGgYZLNQDFWSrLqW+uCy8JyO9ky7SNtVoRXeIwd9VwyhOzoBukJJyXLfrRMVuohL
	OPqjOQ6hBf+36ELFPvOStvxuaVh9BpzdZ1ImNGfWjEfsjWoQ2Zm8JDhl90WkZB0xNqUy4L+HXSi
	zWhc5A0NdEwKa6YE9Zwu3DhvMGbNrlkxkBu0qkQ8rgf7jWIcG3PGZ/yTdg+aJmiwrZg=
X-Received: by 2002:a05:600c:138c:b0:49c:fa21:1c84 with SMTP id 5b1f17b1804b1-49e6cc078b0mr17506515e9.25.1789209014525;
        Sat, 12 Sep 2026 03:30:14 -0700 (PDT)
X-Received: by 2002:a05:600c:138c:b0:49c:fa21:1c84 with SMTP id 5b1f17b1804b1-49e6cc078b0mr17506075e9.25.1789209014057;
        Sat, 12 Sep 2026 03:30:14 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e608sm12850975f8f.23.2026.09.12.03.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:30:13 -0700 (PDT)
Date: Sat, 12 Sep 2026 06:30:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtualization@lists.linux.dev
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	jiri@resnulli.us, kmehltretter@gmail.com, sashiko-bot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] virtio: fix callback synchronization and avq cleanup
 on reset
Message-ID: <cover.1789204858.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PusbzM0TnK1WCrawoDWRmCvIpvs3DhdWGcElHCcb4T4_1789209015
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Two issues with virtio device reset:

1. Karl Mehltretter reported that virtio_reset_device() promises
   callbacks are not in progress after reset, but only PCI transports
   actually synchronize callbacks - other transports leave a window
   where a handler already executing keeps running while the driver
   tears down state.

2. sashiko reported a race in virtio_pci_modern: the avq interrupt
   handler calls virtqueue_get_buf concurrently with
   virtqueue_detach_unused_buf in vp_modern_avq_cleanup, and there
   is no synchronize_irq between reset and cleanup.

Fix 1 by adding virtio_synchronize_cbs in the core after reset,
then dropping the now-redundant per-transport sync calls. Fix 2 by
moving avq cleanup from vp_reset to a modern-specific del_vqs
wrapper, which runs after callbacks have been synchronized - and is
where buffer teardown conceptually belongs.

Changes v3->v4:
    patch 1: add Tested-by and Acked-by from Karl
    patch 2: was patch 3 in v3; instead of moving
        vp_modern_avq_cleanup() to the common vp_del_vqs(),
        add a vp_modern_del_vqs() wrapper in
        virtio_pci_modern.c. Split out callback sync removal
        into a separate patch.
    patch 3: was patch 2 in v3 (legacy only); now includes
        modern transport too.

Changes v2->v3:
    patch 1: unchanged
    patch 2: split from v2 patch 2 - legacy part only
    patch 3: new in v3

Michael S. Tsirkin (3):
  virtio: synchronize callbacks after device reset
  virtio_pci_modern: move avq cleanup from reset to del_vqs
  virtio_pci: drop callback sync on reset

 drivers/virtio/virtio.c            |  2 ++
 drivers/virtio/virtio_pci_legacy.c |  2 --
 drivers/virtio/virtio_pci_modern.c | 15 ++++++++-------
 3 files changed, 10 insertions(+), 9 deletions(-)

-- 
MST

