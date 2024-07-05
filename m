Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E659C1474BF
	for <virtualization@lists.linux.dev>; Fri,  5 Jul 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174146; cv=none; b=kQQvsmcCfaR8tLehVE+qY/iiKjIqwR8Q9R1mmusB7k2Tf9/iVwQid6uyn+4Haa3ZXYusTjFoLOyBp3qSV8BKquK8iyzGQBsirm7v4nBXqpXmokJJXr+vHBihUUYbtRLQllNBi23Vt3xAezmc7Eo4+pHeTCrQ1swROxFr3m0nT8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174146; c=relaxed/simple;
	bh=rMLjExNgz/IU1O7Z+G9luUh0k8XaToBZvPbBUK3llI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Iv/opP6cyx02bxqQtpGjPANIJvRCDvytgaKAdeXjNJrxctRv8wIBqfFcw7IFC6xih4u8eD89Q+dnFsHINDhtMCTCscRcRgFzsBAPB6ifh916zuMAgwMCpJQgMl3b8E2oEP8dOZhIVwWpHsd88UKYvK8Gzp0JJ6z2fYarQZJ8esI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wr8lzHby; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wr8lzHby"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720174143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2G39rZ+nqGSoo1qiWSSlqDlIEz6QAAgqtld8n+Pdxs=;
	b=Wr8lzHby8TN2USYdofYu7gQq3q8WeN7UdsXrUOJ6WiEKEAiOfeFpQ+IZA0KnwK3WnXPj0Z
	McgeoA5R1kbYn9QT5JwGsGiRe2x05sRphv9ynlgamaua1oRYZkiE5uB8w6Ta8RgMvW3+6W
	j0ASlCHLVd8eYrXdP0O6GFtKNs5k6VI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-NmGvOBp3PgKvQk_6GC9GdA-1; Fri, 05 Jul 2024 06:09:02 -0400
X-MC-Unique: NmGvOBp3PgKvQk_6GC9GdA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-367960f4673so1281111f8f.1
        for <virtualization@lists.linux.dev>; Fri, 05 Jul 2024 03:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174141; x=1720778941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2G39rZ+nqGSoo1qiWSSlqDlIEz6QAAgqtld8n+Pdxs=;
        b=AgtxWOxjSt7ReP0FjIdV+zzjEmHTvbkO2k7Ql1Ax/yIqEMyL5LfejhIGrC/Xatx7Iy
         t2FrJb7AO2kFVkDzFI63f0hjdOg6gSwl6uSsuDNEetKPFdPlC/yhC0XQioHKJrTBFhqm
         CPhYkQA3448I3fbiUmQPR6GIwR/BwWFUQDOgX+6jVJyxAknTb9F2WevYnhv6uWQMj6Xu
         k1PI52ZHP3bLzK8RAYgIHoStKFxNrdEsWpQWW72Mpw/QW9j0uEswDLjOQ3wQ+yN0e1lq
         xB6yrtaz9TAsR30wCRhSjPlNL3CkBMSikcenBrmKq/xOaR74m0OB8Wf+BZYdvBNx+eh8
         darQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcNl9e4G8Yor0K+jqhEld4DPOAIPebDHwnt3GSaIvA0BoLW1RBSxXyDInnKuJm1BT71xgb2NEyC3cthN8zSyLrO3hVupfb3IpR4q7WETQ=
X-Gm-Message-State: AOJu0Ywfjx9x8Ik/KbdgaujSZA4MPU0FmpzkqrQY0aAxtj9ngXmC7qxH
	+Layw/h73RXyQZJiKH833dSnl1H+R+evPYwH9GmPshYQUcePRoV5IkTNnQD8yVITFH905OKmf+9
	SR/RFbITu7DB1oaNu3maOwtnlw4Wbw1mQ4QzustqPqys7h0go7ae3/UkK1Ta4RoJ0
X-Received: by 2002:adf:f8d0:0:b0:367:8fe2:7d8b with SMTP id ffacd0b85a97d-3679f76fd93mr3949981f8f.31.1720174141083;
        Fri, 05 Jul 2024 03:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMAgWFq4fXL1Je4jdABy0qUuf3ABlgDmJ2qvyznosNn3i9WEJUQp3T1tA9aMRJHM7r/dA6jg==
X-Received: by 2002:adf:f8d0:0:b0:367:8fe2:7d8b with SMTP id ffacd0b85a97d-3679f76fd93mr3949954f8f.31.1720174140593;
        Fri, 05 Jul 2024 03:09:00 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d0bd6sm55952075e9.8.2024.07.05.03.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:09:00 -0700 (PDT)
Date: Fri, 5 Jul 2024 06:08:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 1/2] virtio_balloon: add work around for out of spec QEMU
Message-ID: <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
References: <cover.1720173841.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1720173841.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

QEMU implemented the configuration
	VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
incorrectly: it then uses vq3 for reporting, spec says it is always 4.

This is masked by a corresponding bug in driver:
add a work around as I'm going to try and fix the driver bug.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 9a61febbd2f7..7dc3fcd56238 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
 
 	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
 			      callbacks, names, NULL);
-	if (err)
-		return err;
+	if (err) {
+		/*
+		 * Try to work around QEMU bug which since 2020 confused vq numbers
+		 * when VIRTIO_BALLOON_F_REPORTING but not
+		 * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
+		 */
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
+		    !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+			names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "reporting_vq";
+			callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = balloon_ack;
+			err = virtio_find_vqs(vb->vdev,
+					      VIRTIO_BALLOON_VQ_REPORTING, vqs, callbacks, names, NULL);
+		}
+
+		if (err)
+			return err;
+	}
 
 	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
 	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
-- 
MST

