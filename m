Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD5283142
	for <virtualization@lists.linux.dev>; Fri, 16 May 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436869; cv=none; b=LZ+ua8/CBff+OxN2D271hKofXh5x7/XY7KnGCuuwbqoS/xa1FsTAdFZbJt1cPiJFh/imuo5oQzbLTLgE++VhRJ4oSzu6CKvD8JUb6iX0hvi7CVt7RT3WSaIZiUIdkvKJ6XDo9fGdZMHOQ/qHR32Wi2Wc9oqqHcFnzq464k+Ymuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436869; c=relaxed/simple;
	bh=9fbaq6CwF6vLyggy/XV/8/w2/CV/cudq3CDw85TXlSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=njWriK2u0OKtaY1j5GhCCutcT2WM/xVQaaedvYkq2nbvuJMmP5pRWh1mdadZJYtLubC3jJUan+Er4SdVUO1m8CXAGjkfSrADChihQ6+Xf+xmcd8gw2uH9UVxLkxfgfHia9zGOJRM7D3DKKAU8CuLjMq8zFwuRIhabpUFtXGalzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0fkOMCf2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0fkOMCf2"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso1652504a12.0
        for <virtualization@lists.linux.dev>; Fri, 16 May 2025 16:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436867; x=1748041667; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oe5thiWbXg0oQhkHd+uP+1sLcx+Gwe9eK60YPiQS+Fw=;
        b=0fkOMCf2Gj/UoihABpSHKL8eDE+uEKqQUWHqy1YGIyFuqhqw0E6XG6x6xqPk9xChFH
         eljQxj+Jl6cm2UKgicmzrL21oP4MiymAq2zOHNuMtRMst+MbzsxQIh5s8zOPvJANybLI
         LoC0DBBvqTCVswRfmCvmuszZub0WlE3x4ZGoAsoHVFRCnLqePDDIeeX9FA3IUXUZ/yAg
         eaSh5Dc6RYMJE+5SvoTSQ2yQR42Bo4rL92PyNCaQ8wlRidYmtuC51BGEJecrTj0TGdmf
         3dQDwax/pxZLFklv3Uja+FII8BADP3q/C+CnnGwxrhJBabpkgR9Ky20SJmSz3AHlQ0HF
         kT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436867; x=1748041667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe5thiWbXg0oQhkHd+uP+1sLcx+Gwe9eK60YPiQS+Fw=;
        b=nStvYl8+L7bhq4qL1L8gztq852YUMWwumQcc4s/h7BtfQj+aHeD744PmkQzsQLzO0v
         IPyQk5Ml0ZNrchZ2BZqr9bYZa1WSK9tXvGsE/QKqz1JOM3HL58FpBehneTyQwyYrBfEC
         xy7Nd2oFVeTRasgrnYJs2i4SCJunrWx0rOo76c+LaWvMEegc/CUZTB25/OkEMuEw48jZ
         xTfbdlO692ZFHDSYAIHcctc65rE8H3X9QfRtmeCEXb0/Wy8MuDkjjt08qiiksIJ7uQN+
         9SBWsrF6hrpxX7a9LGwVGbpv/K1WBvSqBIENjSh6b5zRafrfONue2eZhqA8z4lRK1S+r
         beXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJKvn/CO/CVcARRTg0cGXcqHsLDT3F+nWXv0f8oDGeIobDtM+D5kWqiLGLCyxxnT5R9cwwNisu5/yXibnRzw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7cIPwvDvxivG8mjKnS4dYHJp0j5RZ/aubM+Ibv9+2E3CouZRO
	vyr12fF1oiQVg/YHW7UKueFgsrIbEZI6XCV1alqL8xEipROjVQRByW6actHCGK/BDhu6cDIe1cH
	jNGPiGA==
X-Google-Smtp-Source: AGHT+IGwhN0lFa7qi9dcKhCQf1tbewsw4jw8vfokJ04Lk3TJnvb2OFxjdzkHkOC3oXEw4fYXmMusrSpK3XA=
X-Received: from pjboi16.prod.google.com ([2002:a17:90b:3a10:b0:2fc:2ee0:d38a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f96:b0:1f5:7280:1cf2
 with SMTP id adf61e73a8af0-2170cc66b99mr5833370637.12.1747436867484; Fri, 16
 May 2025 16:07:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:31 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-6-seanjc@google.com>
Subject: [PATCH v2 5/8] irqbypass: Use paired consumer/producer to disconnect
 during unregister
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Use the paired consumer/producer information to disconnect IRQ bypass
producers/consumers in O(1) time (ignoring the cost of __disconnect()).

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 48 ++++++++------------------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index fdbf7ecc0c21..6a183459dc44 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -138,32 +138,16 @@ EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
  */
 void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 {
-	struct irq_bypass_producer *tmp;
-	struct irq_bypass_consumer *consumer;
-
 	if (!producer->eventfd)
 		return;
 
 	mutex_lock(&lock);
 
-	list_for_each_entry(tmp, &producers, node) {
-		if (tmp->eventfd != producer->eventfd)
-			continue;
+	if (producer->consumer)
+		__disconnect(producer, producer->consumer);
 
-		list_for_each_entry(consumer, &consumers, node) {
-			if (consumer->eventfd == producer->eventfd) {
-				WARN_ON_ONCE(producer->consumer != consumer);
-				__disconnect(producer, consumer);
-				break;
-			}
-		}
-
-		producer->eventfd = NULL;
-		list_del(&producer->node);
-		break;
-	}
-
-	WARN_ON_ONCE(producer->eventfd);
+	producer->eventfd = NULL;
+	list_del(&producer->node);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
@@ -228,32 +212,16 @@ EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
  */
 void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 {
-	struct irq_bypass_consumer *tmp;
-	struct irq_bypass_producer *producer;
-
 	if (!consumer->eventfd)
 		return;
 
 	mutex_lock(&lock);
 
-	list_for_each_entry(tmp, &consumers, node) {
-		if (tmp != consumer)
-			continue;
+	if (consumer->producer)
+		__disconnect(consumer->producer, consumer);
 
-		list_for_each_entry(producer, &producers, node) {
-			if (producer->eventfd == consumer->eventfd) {
-				WARN_ON_ONCE(consumer->producer != producer);
-				__disconnect(producer, consumer);
-				break;
-			}
-		}
-
-		consumer->eventfd = NULL;
-		list_del(&consumer->node);
-		break;
-	}
-
-	WARN_ON_ONCE(consumer->eventfd);
+	consumer->eventfd = NULL;
+	list_del(&consumer->node);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.1112.g889b7c5bd8-goog

