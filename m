Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEB219A9D
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801313; cv=none; b=Z43Rzp6JZLtMx5qGza8IrCZH+K4d2bx7BYu4Ob8lY5vbu64BkxyJ0NlY6NZX/LNFbHmms90I2H/4lmDiBjn7mFMcUD2dsD0GfEKIA2uxzywwMib0VO5hKnLWs05e9mtsxYL068l0fHTfBCyar1agf7fmVqAiT6SvApk23idHK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801313; c=relaxed/simple;
	bh=8YRrcSuqZ2X6elO3mJMg4SsPMd3wcuYxZDV9OuSa3es=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WljkvKxSK8C8bVBjWXsnUzDgOiQX5D9A4/AzIaqlBcpVP04avCqkCIpJjx79rWgfhm6vHJbAaQxc7ot6pY6t+Q358M7MOvR4OFrfI9YSFABlCZ906pfL5nWpWEXGVnUYsOX3J0Ha2VMYzTqLrkAnFFDyzAzj/7IRCo/gaxSFTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGMraJYu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGMraJYu"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso2643834a91.3
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801309; x=1744406109; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9QlPfYoNUHN0npkNqAREwoXYlnO6YkPNvJYmSOd9TNs=;
        b=hGMraJYu9OWHsU3MVLhtpUc8e+jav9XhPTIciWUm86trTKAgHi9n2ieKaJ5sIFq1Bf
         YBLdfvSin14vIbAJiWJIPO0eiitnvLpZEnxloaZNIF8VPUVFohRNvGZQ8Q4RScxwSkyV
         8+pbL6wpAegTbk9r8YJEXGpzw/DVhpXAiceXwdZ5BRPtQWSKrg/Ij5026KVfIn1cITtK
         +91kg2daJEbbe5AQxP3eWBftNum+2FVrB1XxUYKyeufGOxo6hhEPVI4eHztmWnSkQnXX
         zjM67nUkQ19oNUq3+bH8icSVfG7aYcdejtaZFLKfAi3y8MEXUMu3sfQbcFiNLggnua1G
         KROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801309; x=1744406109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QlPfYoNUHN0npkNqAREwoXYlnO6YkPNvJYmSOd9TNs=;
        b=JLpi1VxKSRBnfvOvjbMJ6BjcYxOfXP8ZYCRkhEGj5Rz0YwwmmBe6UFWy4mVgtfVcA0
         EkaoUXW7UIiHJxsL9QJKchfzF2qOiK9Y7DdbNfdv47YULfcFokfkVJczWA0xeWzSSO83
         oLiK4olvahfRKYWoowo6Wlbr0d1ygF7HIzEFPPEpo0pfp1tU/bfposf/gW2riHrDjHCb
         3LHWVcJDmWvXmaQbsj3f937ayEk603BJav1QsNUWrrs2xIV2qsJUOiVfDZD1M2bjLA/Q
         kW+8bx2cXbq7fn812Jo3W2cqRjG9gcjDzT2+xvdQTqmpuk7r5xMJi+RVKo5QtlWw7Yam
         Ok7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK/Iis5H8ds4c80j5nZSwiJ7IONZTmHtrISIviMoIQJT4iJXGas9uGgynZX8/fOUbG5wW2VXNXjhL+sGMYIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTkLB2yvCTRj0ScbQ6MYNvCFEtvG6EXESH4cyqDH43xiUJazzh
	zrcFmHpBrOexRJz7eEHGG8o9vESfnZUqoqLDFLU5XHUio3pVWIBlPypPBQpaNhRq55rFrXr+knK
	tFg==
X-Google-Smtp-Source: AGHT+IFG/HHiS7U1SE6A/tzvJJ9amzcONWj17eofMzEa4fVAsgAjCRMKGaMbI4EF0SCoGNkBCkXglKNNX8c=
X-Received: from pjbov5.prod.google.com ([2002:a17:90b:2585:b0:301:2679:9aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51cd:b0:2ee:f80c:6889
 with SMTP id 98e67ed59e1d1-306a492209bmr7867881a91.33.1743801309333; Fri, 04
 Apr 2025 14:15:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:45 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-4-seanjc@google.com>
Subject: [PATCH 3/7] irqbypass: Take ownership of producer/consumer token tracking
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Move ownership of IRQ bypass token tracking into irqbypass.ko, and
explicitly require callers to pass an eventfd_ctx structure instead of a
completely opaque token.  Relying on producers and consumers to set the
token appropriately is error prone, and hiding the fact that the token must
be an eventfd_ctx pointer (for all intents and purposes) unnecessarily
obfuscates the code and makes it more brittle.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c |  5 +----
 drivers/vhost/vdpa.c              |  4 +---
 include/linux/irqbypass.h         | 31 +++++++++++++++++--------------
 virt/kvm/eventfd.c                |  3 +--
 virt/lib/irqbypass.c              | 30 +++++++++++++++++++++---------
 5 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 8382c5834335..c852643d8359 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -505,15 +505,12 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
 	if (ret)
 		goto out_put_eventfd_ctx;
 
-	ctx->producer.token = trigger;
 	ctx->producer.irq = irq;
-	ret = irq_bypass_register_producer(&ctx->producer);
+	ret = irq_bypass_register_producer(&ctx->producer, trigger);
 	if (unlikely(ret)) {
 		dev_info(&pdev->dev,
 		"irq bypass producer (token %p) registration fails: %d\n",
 		ctx->producer.token, ret);
-
-		ctx->producer.token = NULL;
 	}
 	ctx->trigger = trigger;
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 5a49b5a6d496..2749290f892d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -213,7 +213,7 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
 		return;
 
 	vq->call_ctx.producer.irq = irq;
-	ret = irq_bypass_register_producer(&vq->call_ctx.producer);
+	ret = irq_bypass_register_producer(&vq->call_ctx.producer, vq->call_ctx.ctx);
 	if (unlikely(ret))
 		dev_info(&v->dev, "vq %u, irq bypass producer (token %p) registration fails, ret =  %d\n",
 			 qid, vq->call_ctx.producer.token, ret);
@@ -712,7 +712,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			if (ops->get_status(vdpa) &
 			    VIRTIO_CONFIG_S_DRIVER_OK)
 				vhost_vdpa_unsetup_vq_irq(v, idx);
-			vq->call_ctx.producer.token = NULL;
 		}
 		break;
 	}
@@ -753,7 +752,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			cb.callback = vhost_vdpa_virtqueue_cb;
 			cb.private = vq;
 			cb.trigger = vq->call_ctx.ctx;
-			vq->call_ctx.producer.token = vq->call_ctx.ctx;
 			if (ops->get_status(vdpa) &
 			    VIRTIO_CONFIG_S_DRIVER_OK)
 				vhost_vdpa_setup_vq_irq(v, idx);
diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
index 9bdb2a781841..379725b9a003 100644
--- a/include/linux/irqbypass.h
+++ b/include/linux/irqbypass.h
@@ -10,6 +10,7 @@
 
 #include <linux/list.h>
 
+struct eventfd_ctx;
 struct irq_bypass_consumer;
 
 /*
@@ -18,20 +19,20 @@ struct irq_bypass_consumer;
  * The IRQ bypass manager is a simple set of lists and callbacks that allows
  * IRQ producers (ex. physical interrupt sources) to be matched to IRQ
  * consumers (ex. virtualization hardware that allows IRQ bypass or offload)
- * via a shared token (ex. eventfd_ctx).  Producers and consumers register
- * independently.  When a token match is found, the optional @stop callback
- * will be called for each participant.  The pair will then be connected via
- * the @add_* callbacks, and finally the optional @start callback will allow
- * any final coordination.  When either participant is unregistered, the
- * process is repeated using the @del_* callbacks in place of the @add_*
- * callbacks.  Match tokens must be unique per producer/consumer, 1:N pairings
- * are not supported.
+ * via a shared eventfd_ctx).  Producers and consumers register independently.
+ * When a producer and consumer are paired, i.e. a token match is found, the
+ * optional @stop callback will be called for each participant.  The pair will
+ * then be connected via the @add_* callbacks, and finally the optional @start
+ * callback will allow any final coordination.  When either participant is
+ * unregistered, the process is repeated using the @del_* callbacks in place of
+ * the @add_* callbacks.  Match tokens must be unique per producer/consumer,
+ * 1:N pairings are not supported.
  */
 
 /**
  * struct irq_bypass_producer - IRQ bypass producer definition
  * @node: IRQ bypass manager private list management
- * @token: opaque token to match between producer and consumer (non-NULL)
+ * @token: IRQ bypass manage private token to match producers and consumers
  * @irq: Linux IRQ number for the producer device
  * @add_consumer: Connect the IRQ producer to an IRQ consumer (optional)
  * @del_consumer: Disconnect the IRQ producer from an IRQ consumer (optional)
@@ -57,7 +58,7 @@ struct irq_bypass_producer {
 /**
  * struct irq_bypass_consumer - IRQ bypass consumer definition
  * @node: IRQ bypass manager private list management
- * @token: opaque token to match between producer and consumer (non-NULL)
+ * @token: IRQ bypass manage private token to match producers and consumers
  * @add_producer: Connect the IRQ consumer to an IRQ producer
  * @del_producer: Disconnect the IRQ consumer from an IRQ producer
  * @stop: Perform any quiesce operations necessary prior to add/del (optional)
@@ -79,9 +80,11 @@ struct irq_bypass_consumer {
 	void (*start)(struct irq_bypass_consumer *);
 };
 
-int irq_bypass_register_producer(struct irq_bypass_producer *);
-void irq_bypass_unregister_producer(struct irq_bypass_producer *);
-int irq_bypass_register_consumer(struct irq_bypass_consumer *);
-void irq_bypass_unregister_consumer(struct irq_bypass_consumer *);
+int irq_bypass_register_producer(struct irq_bypass_producer *producer,
+				 struct eventfd_ctx *eventfd);
+void irq_bypass_unregister_producer(struct irq_bypass_producer *producer);
+int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer,
+				 struct eventfd_ctx *eventfd);
+void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer);
 
 #endif /* IRQBYPASS_H */
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 249ba5b72e9b..afdbac0d0b9f 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -426,12 +426,11 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 
 #ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
 	if (kvm_arch_has_irq_bypass()) {
-		irqfd->consumer.token = (void *)irqfd->eventfd;
 		irqfd->consumer.add_producer = kvm_arch_irq_bypass_add_producer;
 		irqfd->consumer.del_producer = kvm_arch_irq_bypass_del_producer;
 		irqfd->consumer.stop = kvm_arch_irq_bypass_stop;
 		irqfd->consumer.start = kvm_arch_irq_bypass_start;
-		ret = irq_bypass_register_consumer(&irqfd->consumer);
+		ret = irq_bypass_register_consumer(&irqfd->consumer, irqfd->eventfd);
 		if (ret)
 			pr_info("irq bypass consumer (token %p) registration fails: %d\n",
 				irqfd->consumer.token, ret);
diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 28a4d933569a..98bf76d03078 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -77,30 +77,32 @@ static void __disconnect(struct irq_bypass_producer *prod,
 /**
  * irq_bypass_register_producer - register IRQ bypass producer
  * @producer: pointer to producer structure
+ * @eventfd: pointer to the eventfd context associated with the producer
  *
  * Add the provided IRQ producer to the list of producers and connect
  * with any matching token found on the IRQ consumers list.
  */
-int irq_bypass_register_producer(struct irq_bypass_producer *producer)
+int irq_bypass_register_producer(struct irq_bypass_producer *producer,
+				 struct eventfd_ctx *eventfd)
 {
 	struct irq_bypass_producer *tmp;
 	struct irq_bypass_consumer *consumer;
 	int ret;
 
-	if (!producer->token)
+	if (WARN_ON_ONCE(producer->token))
 		return -EINVAL;
 
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
-		if (tmp->token == producer->token) {
+		if (tmp->token == eventfd) {
 			ret = -EBUSY;
 			goto out_err;
 		}
 	}
 
 	list_for_each_entry(consumer, &consumers, node) {
-		if (consumer->token == producer->token) {
+		if (consumer->token == eventfd) {
 			ret = __connect(producer, consumer);
 			if (ret)
 				goto out_err;
@@ -108,6 +110,7 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 		}
 	}
 
+	producer->token = eventfd;
 	list_add(&producer->node, &producers);
 
 	mutex_unlock(&lock);
@@ -147,10 +150,12 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 			}
 		}
 
+		producer->token = NULL;
 		list_del(&producer->node);
 		break;
 	}
 
+	WARN_ON_ONCE(producer->token);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
@@ -158,31 +163,35 @@ EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
 /**
  * irq_bypass_register_consumer - register IRQ bypass consumer
  * @consumer: pointer to consumer structure
+ * @eventfd: pointer to the eventfd context associated with the consumer
  *
  * Add the provided IRQ consumer to the list of consumers and connect
  * with any matching token found on the IRQ producer list.
  */
-int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
+int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer,
+				 struct eventfd_ctx *eventfd)
 {
 	struct irq_bypass_consumer *tmp;
 	struct irq_bypass_producer *producer;
 	int ret;
 
-	if (!consumer->token ||
-	    !consumer->add_producer || !consumer->del_producer)
+	if (WARN_ON_ONCE(consumer->token))
+		return -EINVAL;
+
+	if (!consumer->add_producer || !consumer->del_producer)
 		return -EINVAL;
 
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
-		if (tmp->token == consumer->token || tmp == consumer) {
+		if (tmp->token == eventfd || tmp == consumer) {
 			ret = -EBUSY;
 			goto out_err;
 		}
 	}
 
 	list_for_each_entry(producer, &producers, node) {
-		if (producer->token == consumer->token) {
+		if (producer->token == eventfd) {
 			ret = __connect(producer, consumer);
 			if (ret)
 				goto out_err;
@@ -190,6 +199,7 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
 		}
 	}
 
+	consumer->token = eventfd;
 	list_add(&consumer->node, &consumers);
 
 	mutex_unlock(&lock);
@@ -229,10 +239,12 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 			}
 		}
 
+		consumer->token = NULL;
 		list_del(&consumer->node);
 		break;
 	}
 
+	WARN_ON_ONCE(consumer->token);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.504.g3bcea36a83-goog

