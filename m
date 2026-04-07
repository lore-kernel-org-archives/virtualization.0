Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED793B585F
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565551; cv=none; b=iNdcaj8m4XewQs2NOd2k0xgyNX/TcuvL0GfNmsqBCY7jOm5HVxCxPcN5uQzsafRgdw5bP11WFCxNCeIncjxMxf1V9LPODjnbGIcY4NwelDnuZ696vhoGm8J6mufUcCOpit6ldr4tcqAhBQXGJwiUHZ5wqx3IVesEebcrSARJCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565551; c=relaxed/simple;
	bh=8haGwctovffsjBCfNAug1BzcX2aUblVA35ARZlyTxzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9RLPAJguMpF8cCOiPz1Uh/h2ibOKrukSFU9/6qC0tWgCTnPiGUmaROggUuGmcxdOairh8AihJW5jOJ3yQp/tO22IXPWn261aXTw9cmv+zzNIdf1/3wh8t9t0QCBBnO9AWchWzNXKqfqn8YKQqhfM9YJEUCdezJ8q1klCZ2woOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlJH9F22; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlJH9F22"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d6144877aso49283601cf.3
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775565549; x=1776170349; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtXeSATuIYDREKlMtbjOkByKzTngsWqWImw9THvc+Ao=;
        b=SlJH9F22mSTw3gD4HPFAoTu68H3H42bH4PEconoqzuxmWCzM0fDWUUQE5vpcmeuPSj
         bQq3cX2dj7lfyeR3I85zfyspWZ0dp6e2e3kUEAT3XQp16txo7ab0zWZml/mOR5u6OqGq
         uaMPPPx3fZf8AP8qxXh+lBPqdTbhepxiZk1G6gr6LJqKZ6YouYvldkYjxMgnwhiTilrr
         eRb2eXccyvX9vAMiXISPus+o+9+rZcFa9anmb46eWD24faHWC+BVSrcOahWwYy1iIlkj
         k8SSSpyT6zlW7XlQhsPIug2rj5rtVN0b00r/2U41bKLn3vOrm5GDoQN+Ygip1GBT6M6m
         wR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565549; x=1776170349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtXeSATuIYDREKlMtbjOkByKzTngsWqWImw9THvc+Ao=;
        b=pFq7lbfo/ALEQv7opXmylnWjbwBxLS2eLzcjn4e+20p3Miy6NKeaIyTWgAA/bs+e66
         T17lT8mpeDdPE9/ACvBUIUy08VJFln+G0W1Q5Hi/Uew89LE0YB9v/D4hYPD172cOnUZB
         7eyJ7pjg57FaO5K8uEkZ5FdjxZe+J6EM0hB+3NRinvcNrqzBPFHYoAAzYSsL1oVwt6v/
         LfozfyvL+XNryZ4wWD6qumENZ9I61EIDOkjXTeIsvjRLcgwOgeRT0LkCRu9WJUkDSrNn
         6+WSmfgk3M7qlLfC5utR3rBNXB0DclJsOUunFvvemmvaEjbDf06sS5MwLz67An22Gn/Q
         Erjg==
X-Forwarded-Encrypted: i=1; AJvYcCXLw0PXQZdNPFoEg3cv1+CvQVwRv53W9TLeMTlpeNhKhs4qJCQ4r6ZbH+ImiACQBIKpqghl8NgeHKx5L9r6fQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy69B8TRuzkX24mqrgjK1yOQnq7Xg7fRBtxH/J7ToZfsPrKFu0U
	6ASPMjZWUxt95tEQ4IpoEBGbc0ntrcrT3+bc6p70hM+8T+pxRmpKzrlg
X-Gm-Gg: AeBDiesO71Hd8x8Trw1uSe+qRkYy2exw8lYO/fQEfBsyX/MyMn/koZM3DMDXzvidDRm
	261/wrfkBRzoDyzUdAQEral8rHY1EtxIDdiyR2PPoHy0FOEJv3JJZSb37a5/OnSFKDeAJAT+8it
	CmBA8Bw1LrlrE8QoyzYIb+pDqg+8hR/ZsCRBvOnpUwWlzfRqhFZd91Xsgmg4zhdI9ih4qfIk+WS
	MjBfFhwRyVSbVFZMBRKkVTn5p0rBR4CO0N0c8Sc7CrPZcPxDulHbQrU1LSwm7fVWZym7mGcXUUZ
	0xucK5Wn1pq2sCmDYkpfhPX+CWbHnVwtz25nok5Z4Pu4ejyUAmgpfqJEdRhauIugqAJ8rLquRqC
	nu5fwrGlF0x+rreCvLiuNOkjTbmhnRft5A04hCHGzy5nJAr9+4mXllJXjGqw/LcOPg9XppYBGQE
	60QZzjXoEOIbf3v17D/GihlJThSkFrtDCxyCtLl/OFN1HVojF1zeZgcIgAfFD9H+E1I307XwFX7
	I+/0PwaWaiviROvm66GO/+QcqF4558C81qzpoJQthm8D/nfFYSGjw+M9fqKsmTJB96MkZJzoOJE
	55oVh7MaH6yATolZXxU6YpQ5FR3lg0U=
X-Received: by 2002:a05:622a:4c1b:b0:50d:7384:a660 with SMTP id d75a77b69052e-50d7384ae96mr190732151cf.6.1775565549307;
        Tue, 07 Apr 2026 05:39:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:4041:5c46:7000:d80b:4b87:c7c8:bd46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4d4a034asm133005611cf.6.2026.04.07.05.39.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 05:39:08 -0700 (PDT)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 2/4] virtio-pci: use avq->vq_index for admin VQ in INTx path
Date: Tue,  7 Apr 2026 08:39:02 -0400
Message-ID: <20260407123904.6390-3-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407123904.6390-1-astellman@stellman-greene.com>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_find_vqs_intx() sets up the admin virtqueue using queue_idx++
(a sequential counter) instead of avq->vq_index (the actual transport
queue index). The MSI-X path in vp_find_vqs_msix() correctly uses
avq->vq_index. When the admin VQ index does not equal the next
sequential queue_idx value, the INTx path binds the admin VQ to the
wrong transport queue.

Use avq->vq_index to match the MSI-X path.

Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
 drivers/virtio/virtio_pci_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index da97b6a..0b9d66b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -497,7 +497,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
-	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
+	vq = vp_setup_vq(vdev, avq->vq_index, vp_modern_avq_done, avq->name,
 			 false, VIRTIO_MSI_NO_VECTOR,
 			 &vp_dev->admin_vq.info);
 	if (IS_ERR(vq)) {
-- 
2.34.1

