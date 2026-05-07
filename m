Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34539A053
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192634; cv=none; b=SfB4YGzrq9wo5vzDmpn4wYeojD9CGMQ/mN0hDZBACVNBidvHvRCFhruMWgT6xKeJ4+Uen7LIL3Yc/CUKYe6GwV9dMsqWNgWvs9bVwGymu1Q0hDdewcfl/kla5oH84PfZsHd9vY/QfNWLUPKZ6AiXGzdGdfdct60f+HllOXkU08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192634; c=relaxed/simple;
	bh=LdhWu2S21/nEYuhXIUl1UmI3udDTmzhwlO4S09ZxBvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J5tfGdjcdXQVqMEmtVKwXw2Pbw+QIYwfrKn0EHVoHERbqfhIvCXUlc9TCfFEoMyS12RRPjae9w5wD15EpDOMVcgJ2fXWthy2OJS2h78L/YA7iqnDRoiaSaEKLii3nFHSAgjEWY/WOc9amUFxpAP0jXy/LJKlujzLZ/GMS4KMBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hem3mSQV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hem3mSQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778192630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dugSKqa2HC5Rex+/VdUGb27yVezCs4DCWJev6IAeQaE=;
	b=hem3mSQVBKTXj1rsU1by3Pvim71UuCtGX4dgm3UcgwUnQVVCRXjmqcMCyVX76Zv6baGZaD
	KpFAlADGD2ZgulS0ZeLjmloyb3Cic6x6nSsBz50dJfc5cEqyHAWBtZgurYDfqwxPBxLZ/W
	NpOq7hhcPUvOXpfgXPrf9wshoN8yGgw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-4UbQLgQVObusVBdGF8FVWQ-1; Thu, 07 May 2026 18:23:48 -0400
X-MC-Unique: 4UbQLgQVObusVBdGF8FVWQ-1
X-Mimecast-MFC-AGG-ID: 4UbQLgQVObusVBdGF8FVWQ_1778192628
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d127eb013so7832625e9.1
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 15:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192627; x=1778797427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dugSKqa2HC5Rex+/VdUGb27yVezCs4DCWJev6IAeQaE=;
        b=nj6vTIjUvttp6WOd4njiQT5L69vgE5pbhJhAYKyqf5tachetY2FIRE90wiIQZfeOly
         pi8bbN9EkMmV4JYKgsRyP38g13e7ohu7pgZV6QPcnop+PzxRn5O0YQshVfXhIkjAzpWR
         pITg2768xPjU9ARN/pMPSipaCPDAt8Eu5jc0qHalLdhPuvZUn+T46UbFGNJyY7BsMsKm
         MRVdWtFT2J8WHa7SucE+0a0oHv9N7NzRCqm8/ljkVBLrhe1qMB/De3vr39p+tni3byW/
         xdHXttNejwIxqyYk5j/ffmDhF7Cvbvme9atVqMMs7TEuh77uphOQa9zfzyi//hwuAQ4I
         D4AQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QguPseCpnb3Nqv82qP630vIWJSNUU7D/schF0WiZz/kLxjzj1NLITUOazKMNTxg39TA7PSKBcJ70rfWeVOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzh2tEa9iNb+dLcQutmeXFVgOjWSxgiYLAjHpdga8O7nk1O7qP3
	T/jM/I6u8aiOiIsSb4xbaE669+xVcg44VJZtd1APhs+5gvWG3E1PAOfXf1ruQDStvcWCo9Ed2IT
	lXnTjttEFnLBlkJ6V6oYBA1QWVjgmBvN9l/sFMsGbB9PWFw1w9k3Cql5H6rjdNxt9vfR1sTmt7u
	gi
X-Gm-Gg: AeBDieu6WVoUJEA3FPpGxgYm4/svcRm4ofNDGUg1YToMaLQ5ERfoxl2ssIy/dWNY5ng
	NrFNGMquLnvstklTg0YwUkbfyKjzcjWOwF4EOe69hKZv7+nuclux6eEEihVSSNQzxxDDXpGPbYl
	E+eIfrULUNKmcSgypKTK0dPGVoJaLxbCBmMv/9jx3dxsb8OiDzVz5Y06lRSOpveB52r/plJ11tH
	YqhvyZ2fcgEeTufsibQoMf0hBgYvaJjkYj0f6K4aO2PMsgH8AU09ZKV+03RgXSDwsA4Qix4XFCJ
	4mIBa/MVceFHbkABkaUAz/G+q7E/cUqNeuNqHuTRQw98i3r2XecRaMKXAHgxdV8jgMKLr4gNAjV
	LefZ02Z0tiMwZHdfv7I1tW7Sr96c/Sz99z3dr06F1
X-Received: by 2002:a05:600c:a408:b0:48e:62ec:f264 with SMTP id 5b1f17b1804b1-48e676a5251mr1267005e9.17.1778192627196;
        Thu, 07 May 2026 15:23:47 -0700 (PDT)
X-Received: by 2002:a05:600c:a408:b0:48e:62ec:f264 with SMTP id 5b1f17b1804b1-48e676a5251mr1266735e9.17.1778192626614;
        Thu, 07 May 2026 15:23:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4541721a05fsm1976259f8f.30.2026.05.07.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:23:46 -0700 (PDT)
Date: Thu, 7 May 2026 18:23:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v5 28/28] virtio_balloon: implement
 VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED
Message-ID: <cfe4b3eb8c1bdb28ec19b127c821cfb1ab33638f.1778192416.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Fk0VOtcZiWO3iPP64esI_U9NFUWcGLJnACMxmcIa-Bg_1778192628
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED (bit 6): when negotiated,
the device guarantees it initializes reported pages (zeros, or
poison_val if PAGE_POISON). The device signals success via the
used length of each reporting_vq element.

Gate host_zeroes_pages on both the feature bit and the actual
page content: when PAGE_POISON is negotiated with poison_val != 0,
the device fills with poison bytes, not zeros.

Clear the feature in validate() if REPORTING is not present or if running in a
confidential computing environment (untrusted host).

Renumber DEVICE_INIT_ON_INFLATE from bit 6 to bit 7 to make room.

See the virtio spec change:
https://github.com/oasis-tcs/virtio-spec/issues/244

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh

virtio_balloon: skip zeroing for host-zeroed reported pages

Check per-page used length returned by the device to determine
which reported pages were zeroed. If used_len matches the page
size, the device successfully initialized the page (e.g. via
MADV_DONTNEED), and we set the corresponding zeroed_bitmap bit.

This requires no feature negotiation: existing devices return
used_len=0 (the conservative "not zeroed" case), while updated
devices return the page size on successful discard.

host_zeroes_pages is set unconditionally so the page_reporting
drain path checks the bitmap and marks matching pages as PG_zeroed
in the buddy allocator.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c     | 30 ++++++++++++++++++++++++++---
 include/uapi/linux/virtio_balloon.h |  3 ++-
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1eb9a6376038..f1ad842eb3d6 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -218,6 +218,8 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtqueue *vq = vb->reporting_vq;
 	unsigned int i, err;
 
+	bitmap_zero(pr_dev_info->zeroed_bitmap, nents);
+
 	/* We should always be able to add these buffers to an empty queue. */
 	for (i = 0; i < nents; i++) {
 		struct scatterlist one;
@@ -237,10 +239,14 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 
 		/* When host has read buffer, this completes via balloon_ack */
 		for (i = 0; i < nents; i++) {
-			unsigned int unused;
+			struct scatterlist *entry;
+			unsigned int used_len;
 
 			wait_event(vb->acked,
-				   virtqueue_get_buf(vq, &unused));
+				   (entry = virtqueue_get_buf(vq, &used_len)));
+			if (used_len == entry->length)
+				set_bit(entry - sg,
+					pr_dev_info->zeroed_bitmap);
 		}
 	}
 
@@ -1118,8 +1124,16 @@ static int virtballoon_probe(struct virtio_device *vdev)
 #endif
 
 		vb->pr_dev_info.capacity = capacity;
+		/*
+		 * With PAGE_POISON, device fills with poison_val not
+		 * zeros; only treat as zeroed when poison_val is 0.
+		 */
 		vb->pr_dev_info.host_zeroes_pages =
-			!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+			virtio_has_feature(vdev,
+					   VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED) &&
+			(!virtio_has_feature(vdev,
+					    VIRTIO_BALLOON_F_PAGE_POISON) ||
+			 want_init_on_free());
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
@@ -1245,9 +1259,18 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+	if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
+
+	/* Device fills with poison_val, not zeros; disable zeroed hint */
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON) &&
 	    !want_init_on_free())
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE);
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE);
+	}
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
@@ -1259,6 +1282,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED,
 	VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE,
 };
 
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index d129736cc3a8..cbaf18e0b17c 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,7 +37,8 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
-#define VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE	6 /* Device initializes pages on inflate */
+#define VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED	6 /* Device initializes reported pages */
+#define VIRTIO_BALLOON_F_DEVICE_INIT_ON_INFLATE	7 /* Device initializes pages on inflate */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
-- 
MST

