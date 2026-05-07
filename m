Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5439A040
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192632; cv=none; b=KPBPJqdWUgT3VtFwkShZGFq6BfqQC6ZRldEffISGWhS8ME1ZSHu4qc6rB991WCNpB51t7XX+XOcZlKxMS6ICx6L2uTl3xTRS9I5CnJuiOrunRsGTKt9+Stc96r2kjM3IuyAxh2SBIOXGkA5Ee1OQSv4MRRTTSE+CbhL3+DvvME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192632; c=relaxed/simple;
	bh=AK9TO94T0KU+04u+dGjmV3b60mJRmYIjdCC4LEd/MMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o8dDgf5QcCVj76ONVIyCaqfaNpRsPsFnJd2M4rhIb/sX2xx2iJpm5W+AH8gl15x/+8ROAQyYCIWhaS+fw5lbn/iC4qKAOZaUReWSoCCkf5g0oiShm/pMxIrL7nsUNCeQMNkXzlP6/lgOSE+plOgD4+17B7QS0MOII0tCgl32GqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZEVKBXx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZEVKBXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778192627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRctwQPPX8xkJe678Z/hFoNL2OQQ834j5nPYy6NU4ac=;
	b=SZEVKBXxxNJypMJ0F8YTnUxxt2Nncr6Q6xKNGGjpIx1ug9xjGluRD5pk5eDghvxbANHw0y
	zOafRbHXosQ1WUnJiRSGMSKnr5q2IaMAwLXC/fsTmvoRagaboynXLEujt2IQNbDkY9Klud
	ZQvIzbrHpfVeKPHkUOAyMYsErAUouWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-Np3TNTKnMHKftXgArCv1Qg-1; Thu, 07 May 2026 18:23:46 -0400
X-MC-Unique: Np3TNTKnMHKftXgArCv1Qg-1
X-Mimecast-MFC-AGG-ID: Np3TNTKnMHKftXgArCv1Qg_1778192625
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e5dfa8ec7so7095935e9.2
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 15:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192625; x=1778797425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRctwQPPX8xkJe678Z/hFoNL2OQQ834j5nPYy6NU4ac=;
        b=f5QR1gpxHBEwOWm9FR9APkXARWU0E7p1a61UdJn3AKKap+BpBNtuIXk7Lkxh4DAjB/
         shGowFWUBPNIYJVg4Mg/6kfN3eQnRORROnjYuBUgCHPqVhBXUPdIfs0ylzPdukoSmKsg
         PylpElGDf7urKug/2w/58/z9SYpywGQZVzWNz/NMRzyI9c73X7Een7CeJIZgJdlzTJ+b
         tqTkk41bGKYEEEGMrzJCPZXdNS5oxLXiPuJ+RvCZ+ADKPIcab0HZJ4h8xpLWv+iJQrLR
         d2dJ6rZD8ZzHE2PHjhHDQhS/nAcNIN2TPzVPtx/aXf7cH+VDjJsi+m1yzkLHDd7wVElu
         NDpA==
X-Forwarded-Encrypted: i=1; AFNElJ94u3jUEY9OSJOXKS9xMsEIFoyprqBCW3uBihJV2n8Y5uKqNiDa1sx1Ly6qpCAbu3GCcXQsoUZY6avH13CGAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrRIDLSp7zOnmiZSx3rOHZJSm/DP+cLN6RMfcAGJi9pKMN1jvI
	KdWQ4flxZxEjWMDG508msDmWEow6SkQPIgOwCpWSdqelktsLBfP3Jlc5ip3bVEahtUUjpb7+WG6
	fIyL1VFj9sxU8CG5mpY1yKVma/VmPEQv2l8LLfhii36gt9TP81dYCqcYezSaaDoZsu3HH
X-Gm-Gg: AeBDievYFmlcv5glC+EHwRJUgOmimfQOys5lYVYKbHYtGaPtISRq1pxRr777xGbszks
	g72oqKIaKgRnp03XkWNCy5j78yQ8NFBjp2EBLAkdow1dUjshxbqzUsgTFDND/BhKckO3hrBcWi4
	RmsusvlVYznlk5qsstFL1+H4vV3vmWRK4rA2loNrjyHSL42mXdr1wSytfKuBaLXOearxWaRGL+q
	KV8YilEKNfQaA2VHiN11PZdhKrvhU/4M/n/LkaRwl5B8uOsBbtIGeXR6sTcKUoQ/5ZMIIr8Bzyg
	3CnieaiEg9ZRP/CfVPZbBcSc9OocR+WJNv95YoiQ0E5ECTaA5yZUvaBHFRlk+mNKoyqVi1qBg6H
	O2Sm/jVgu8NOduQtCpUD+5pvtb26HBw8NLvUfgECe
X-Received: by 2002:a05:600c:2e0c:b0:48e:526e:1011 with SMTP id 5b1f17b1804b1-48e526e106bmr81739855e9.25.1778192624842;
        Thu, 07 May 2026 15:23:44 -0700 (PDT)
X-Received: by 2002:a05:600c:2e0c:b0:48e:526e:1011 with SMTP id 5b1f17b1804b1-48e526e106bmr81739685e9.25.1778192624331;
        Thu, 07 May 2026 15:23:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e65c01d7bsm4592885e9.8.2026.05.07.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:23:43 -0700 (PDT)
Date: Thu, 7 May 2026 18:23:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v5 27/28] virtio_balloon: disable reporting zeroed
 optimization for confidential guests
Message-ID: <ff5dc414a72ce6205c11313b2f272d0a1888b275.1778192416.git.mst@redhat.com>
References: <cover.1778192416.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778192416.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zklkjGp8yXczpKVIwrjaup13TdcQG1zpXqe0SQ5eyME_1778192625
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In confidential computing environments (TDX, SEV-SNP), the host
is untrusted and may lie about zeroing reported pages. Disable
host_zeroes_pages so the guest does not skip re-zeroing based on
the used_len hint from an untrusted device.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 708b0c344ae9..1eb9a6376038 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -18,6 +18,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/cc_platform.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -1117,6 +1118,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 #endif
 
 		vb->pr_dev_info.capacity = capacity;
+		vb->pr_dev_info.host_zeroes_pages =
+			!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
-- 
MST

