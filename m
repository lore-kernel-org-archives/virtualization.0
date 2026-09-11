Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61446A603
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130265; cv=none; b=j344K/g90bF6X+QpszxDYI+kYEztYSj5mTF3E8Jka6S2/ucRXEYPK+GrGN9km9XRyJQ540mfnCSa+wdY06T3DnKOV0k6n+4LapRzVTIdBa5e0eifby0edY13O9JfQvPuaXUnJ3o9zPkkzY0LMEtsm/8MQSjLF43aVjxVwzmGJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130265; c=relaxed/simple;
	bh=KpRc4cJbkwkmh5HrpghW5jngw42IRWT9s8NB45nt8q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LX6uYt/M6CAzTroDKjoTsK8D1Ssxr2wSHsyPe/lU5qNgNSmg0OxRUK4hD/dXdzeAlNhGPLko1wVJLHVpXSKjjXNRUBkqq+y7Nvbfc5VSUmGaHMIMW2NEzeavRjh867+pW+fRGmd1wzQzmC1ige1kO8oI4u9abHcATe3WdUTx6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM4zQkVK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM4zQkVK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789130262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QX5fEdW6ISh8Lzeqap4wMGZyyUxBjtTVcogMT03UXsw=;
	b=UM4zQkVKM9HMEiN2biDfwKilVxK7rjgb/mZbvIua05+nx2YmD2OgXHBGQg+7NvndMN64+s
	1S1E2UGSZuM109hMgw2f10ifHNvBhaoRoXq5H+a/PG9HF0vF1NnfUQxFAg7DpIQ4lmApZ+
	bwHUV8QQEqf6a8HknXUg3PeFZNGMG0c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-baYUCWzZNweIuLggJFZxnA-1; Fri, 11 Sep 2026 08:37:41 -0400
X-MC-Unique: baYUCWzZNweIuLggJFZxnA-1
X-Mimecast-MFC-AGG-ID: baYUCWzZNweIuLggJFZxnA_1789130260
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e65ecd557so3369335e9.1
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 05:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130260; x=1789735060;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QX5fEdW6ISh8Lzeqap4wMGZyyUxBjtTVcogMT03UXsw=;
        b=cxlxWyIWfJqLyp0LBk3DG+yZyj6ToScCX43dpPMD/t2rg3iYXCCl8uVdPugE5IsV7D
         pvZafKeG2CBAaae6fprqw429DJ4NPkT4jFtflwirAkOno9C3KpWps944LTYljY/DLflm
         ayfDSmND8Bf7+BPvWl4l/qkq9IwQ6hvZfFmnJz67z1y3Midq6yIHvszImipQe5zpPxjh
         6ekXrAT0cv4NAEBHxTcsoEWAogpf8c++xiw4EP1Kp/7o5v5rY/l+gaHBtZkgHVgfFyVq
         xRZd2jhPxEA4aYu62ZPENxclEDHvHZ/shYD+Q9rIpp32u3+NXPKBkP/1njBzaBtlBRvu
         xZpg==
X-Forwarded-Encrypted: i=1; AKwUvBy+b0zrdYhtHjpzTlbBprTWpdIbjJwDJdpfCG3Xg5TsFd7KwNr6h1Qe3meUO6EDAvlbaPmxXNdeOZYn4H0uLg==@lists.linux.dev
X-Gm-Message-State: AFuF++n9N7w3fG/CUJIfJ9QlqbIsHPIHA66WX/36xX1KN5xh6ErEkn1v
	6eK0hSoGmy90j/h0r0UHOzjMcRT2HFztiicwXPECEDseUsl3udh+R4s/m1aeXgFZnoXVbdvxzv+
	5c7XLpknNtRgW9jegC18DCsnrz27zHCFWibOldQaLN697/gQ84f4V6jdxlhkSUodReuAd
X-Gm-Gg: AYBFou2ur7fK4AVGiS3A7mJ0WAM7BsNSXW21cnnTwx9a4mVMUIXRHNLm/t5NBozvbjp
	gj5aLHVKC2AiD6PPJAyuv+C4ne0xPHOs7G4Wicb4fXQs8oS6aNKjG7bUCD04vZ+xkirOxYpFb0C
	aZLH+o3jbiKMcOqUC+UT51n1vFzTz5sQ4ZNLx+a1KN3Z1rzqBxnQy2K9Q9sFU3yNz2KxySAzCuG
	F/2LgVNyk0jtpWIPm0uspx8rjMdUm5LKrYj4dkWLFq9uB8Z0SHB6kCzD1CbIgYNliiH5Q5IcIy9
	F87NJ20lTFm8yxZN5s+FQoS3nEWx4Apx+n4lNQUrL4qaqSrC8CUp5f601wy1CmmJ1l5qvukL5oM
	STKHF3tqRcSfXbs/BoBpx13c=
X-Received: by 2002:a05:6000:290f:b0:485:a394:58ef with SMTP id ffacd0b85a97d-486eb2eb3damr4418974f8f.30.1789130259703;
        Fri, 11 Sep 2026 05:37:39 -0700 (PDT)
X-Received: by 2002:a05:6000:290f:b0:485:a394:58ef with SMTP id ffacd0b85a97d-486eb2eb3damr4418934f8f.30.1789130259157;
        Fri, 11 Sep 2026 05:37:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bd1esm5862959f8f.31.2026.09.11.05.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:37:38 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:37:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 2/2] virtio_pci: drop extra callback sync
Message-ID: <082fd9b2bad1db0088caa38a8d738aa848bf36b2.1789130213.git.mst@redhat.com>
References: <8f71425918a148dcad1be993ccabd39582d246ee.1789130213.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8f71425918a148dcad1be993ccabd39582d246ee.1789130213.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XSB95N70siv5a09MVfXkQViX0aoaN5a81xQIWTEUqV0_1789130260
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtio code synchronizes callbacks on reset now,
no need to do it in virtio pci.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_legacy.c | 2 --
 drivers/virtio/virtio_pci_modern.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..8115aa39e01e 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
 	vp_legacy_get_status(&vp_dev->ldev);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..c9e21317c51a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -559,9 +559,6 @@ static void vp_reset(struct virtio_device *vdev)
 		msleep(1);
 
 	vp_modern_avq_cleanup(vdev);
-
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
-- 
MST

