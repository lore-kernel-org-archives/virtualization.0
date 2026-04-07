Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3BF3B47C6
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565553; cv=none; b=RMzdIkvglcPDehJqzGE6GwI/uLF6bVe/HCrSRhHaTRTCrHqPspJpUbxHa1a/kTaFadmRpOWJc1h2o6xRgNfLVb2t8mZlQS/ttw+jvgXcDXH0q6Uuhu2vWSm879qhchzq7oR0m/MVB+6DDIIaiEZ4Q5VIHIMVgXgzOZbt0G4ZWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565553; c=relaxed/simple;
	bh=JwYaZFieSoHS/OxtU9ZfpeCePeV5TyjgbyG8QhxDxA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK/GAfVKIyUDAaRNtM90O5xo3B0vWR0+JUf2Chtu3RsTFvKuxqzuXqnG/tZIwnSF5i8fLhTF2i8Bz7HGFkPocaZtAiw0W+7t3eOAoOucT04gufHXSy7i6aN0cGl5dDR/bM+aMgtLGCHfZdIxGSGvA+VRKPZr9VCHzoLDrZy0qgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obNt7631; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obNt7631"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d63635d80so33485791cf.0
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775565551; x=1776170351; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ot9+pDdXlySiA+jMDM+VcjwnH3oTsfA2jyqORtCbSQ=;
        b=obNt7631j7rRuC4N3GfT5HoCtK6sPx5qr6FBtbs/dTueoNZKwsky9zil4Mz/Y6JVV4
         kbY/16+v/yLVUN9/vUhNOEY9QPGnQYLMEMr0U+e/vHuAoRCK7Fj2wZ66gKRvJ6UbvzME
         a7z3+XI+9Jbjzr7nW1IwPTpjlsZzE9N3/TNXIipiGhhZDpbKPsC20y9Ftvxoy5oeTBed
         2WUG3keU2Jb75dGDoRIWPGFcUAR0r7wFDk83BdubWr3cU0uysnOwwZwOWPe+ivPGzrzh
         oX+sjoyIlTDngXbkN/wjYU/Zs1PzZQx+Lo5cj28uK8/A3YyCIE2Uz9RhjQ+8WWcESZxF
         q+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565551; x=1776170351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ot9+pDdXlySiA+jMDM+VcjwnH3oTsfA2jyqORtCbSQ=;
        b=GVME0QWNZwZLP5bkopPNYonjGr+jhRtJh9R0bZ3ckQAa3JfFCqziy51M0xv6XknCyM
         3HqZ3r2ubImC9KWWLQ9eh28SQsTr8+c5xgcLoYHodDDm0W/+QdszEbahBOEbeKp+H595
         6ghf9qqbY7/dNKntK1xnPtveZJV3DY8QojJ6pMcu5BXueUMFm2d1jakxSkwBXZfXh7HT
         NDkZEUEb7q/HfhDptBxH2wOoB0JOv/At1tppwK1+zc06hSuORIzk/it6uIt7GMTMWJja
         FHy9qhk9712x8YBCYwmvbVoxrQvOL7FcExxRXqn/3MTAOJVlpqkTgoHV14Yg4gulJmJm
         7e/g==
X-Forwarded-Encrypted: i=1; AJvYcCWM3mgP+zxQbZl3vZuMDQ1KBEkgeQb1egbC0Ai8KM5hZ9qRjgBnto+4ZbXlQ4/0JddgndK8FsDX3HocAwcE1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy49+mplveUj9mYH+WV+1NZf2KTgtaTUF/B2nF70bPP0HhJn1u/
	q+ti4ySnoqx7dbT6Oy1dgzqjZ5uY1ailyJbjPskAEzZuJpMc1uVknus7
X-Gm-Gg: AeBDiestCtafGosbjI+1z5k/TUEyE1t7lJrUOREhpZicT6B5fWjnqcoJEDJplTdqU+t
	urJCRasI+9E0TAUw03fxmJE2oR+uSEL2vFfGccwSCCm2KQncFqyYqzDfgl4+5vVQcnb7XQsokae
	PKuyWS+bkQORNK62CuQLBVtIiS1JXTshD/Doiuhm9b3D4/yhd51heDfFw2jLVtfRHz0ncfVeiRA
	q19Cckn3g8FR4lp0Pj2bXbqHacJR7RGmY42Yj7+lp0dRhjRDnZ6bbU/tQW3ZnYOD++dYqHnO/w8
	IPDPFkiEOnJwB/oWLG5gI6BOlEckkmQFb7g9yON4dlzBCpI0EhoVw2br37J7y+d1DcqMQDqzvUz
	wb3AaOCNq8NxGIj4rMhBBZS6kpVpq+vgmZGlZZCAvdsMbXWFgmeIxLNUUpWIM9q1MzOpDDKbIvd
	6EmC//5jQMuZJHBGMJr3MD5e2AyAcSM97+wPLarURAYjA51N5SaQz3VDNrSkH/RVN+R7QSgve4W
	hhTNbVRAZ+30yF022MWCI7831bGz7D9dCzfOlyFsGqTacNGOghUAzcf8EnwTiHMhtMk0ytVJXqj
	cSkWfZZyuQcfEwP6qOye
X-Received: by 2002:a05:622a:15c8:b0:50d:7c18:c66e with SMTP id d75a77b69052e-50d7c18c9e1mr183570511cf.13.1775565550940;
        Tue, 07 Apr 2026 05:39:10 -0700 (PDT)
Received: from localhost.localdomain ([2600:4041:5c46:7000:d80b:4b87:c7c8:bd46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4d4a034asm133005611cf.6.2026.04.07.05.39.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Apr 2026 05:39:10 -0700 (PDT)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Andrew Stellman <astellman@stellman-greene.com>
Subject: [PATCH 3/4] virtio-pci: return IRQ_HANDLED for config-change interrupts
Date: Tue,  7 Apr 2026 08:39:03 -0400
Message-ID: <20260407123904.6390-4-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260407123904.6390-1-astellman@stellman-greene.com>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vp_interrupt() unconditionally returns the result of
vp_vring_interrupt(). When a config-change interrupt fires but no vring
activity is pending, vp_vring_interrupt() returns IRQ_NONE — even
though the interrupt was legitimately handled by vp_config_changed().
Over time this causes the IRQ subsystem to flag the line as spurious.

Track the return value explicitly: set ret to IRQ_HANDLED when the
config-change bit is set, OR it with the vring result, and return the
combined value.

Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
 drivers/virtio/virtio_pci_common.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 0b9d66b..1d1ab02 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -106,6 +106,7 @@ static irqreturn_t vp_vring_interrupt(int irq, void *opaque)
 static irqreturn_t vp_interrupt(int irq, void *opaque)
 {
 	struct virtio_pci_device *vp_dev = opaque;
+	irqreturn_t ret = IRQ_NONE;
 	u8 isr;
 
 	/* reading the ISR has the effect of also clearing it so it's very
@@ -117,10 +118,15 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 		return IRQ_NONE;
 
 	/* Configuration change?  Tell driver if it wants to know. */
-	if (isr & VIRTIO_PCI_ISR_CONFIG)
+	if (isr & VIRTIO_PCI_ISR_CONFIG) {
 		vp_config_changed(irq, opaque);
+		ret = IRQ_HANDLED;
+	}
 
-	return vp_vring_interrupt(irq, opaque);
+	if (vp_vring_interrupt(irq, opaque) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	return ret;
 }
 
 static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
-- 
2.34.1

