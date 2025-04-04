Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ABC221F02
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801314; cv=none; b=qmDufpShLWnS5omW1TSEB2Ag7ou8cchIAaMSj34uqrX91O4lkoWztfV4EZSAG5cLAeXwRdH2GN/WIDkktNcriwZqloN7cNmVmoI0ukf++HuPUTgaWGWNxVIBfh3PTKCal1blNMSgF08txMnOZw7f26yxYu6WGt1oE28ut2EA1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801314; c=relaxed/simple;
	bh=R8NuUhmI02N5n1m2zQQJmYcq/tgo+PabOiQg+/IuxGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CHdOTzbSxfooDYL5Wx6lsI6tLIPsiHLYaGrb8/0kqPjqj4x7tLeV68lKXMJF4G4JZn3Al9/oTd7uxLz+M1qoJ84521eE2rUgkTdjW2kKlJDnPgLN1UoSas4BZt9PXewiVdkGFOgtjBQ6o8HPhipJRowROtbt9I/POMOW9uTbcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pn2CAU8A; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pn2CAU8A"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394792f83cso1937934b3a.3
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801313; x=1744406113; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+c3CamxlMu4cATASgv0Iy6Lf5d+wt8ucP9dRv+3+Crg=;
        b=pn2CAU8AejfEX5pyxMxNMJlJ5WOUlgpr+/SIA9Y0+JraoxzKDoT7zmQkNTLVeRh07T
         KfIqOCkdK65NjcQP16FW/6Pfre+RJUdWTXhfUVScBdc+UDK/Vc5vu0pJsc19lCHNajeJ
         7cuheK2ve5rDZ2AOuGKRxLzIwfdw69cchwf0mn0zSvwy4ag34kx63ojetZVh/ddVHtww
         bdhcVG4p4e3LqwCJR9xx+tazqbx2M82rbC+mybGPNM6ChBB5sROFO2B/D6c11QDxZ+TQ
         YEJrkyedDfzu6gdL2zORipJ+NGtPtR0p50GP6jKTL7hvEMIjjvZtAGnxsLMR3uFyYnY5
         truA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801313; x=1744406113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c3CamxlMu4cATASgv0Iy6Lf5d+wt8ucP9dRv+3+Crg=;
        b=g5O2rubsXAyvuFPu4hfov2lTpIthCZel5D28sSI0sJ9rG6s2DDqWuEA4i/K6MHGkhu
         gvhqHCkyqYkfkFy9moabDlShmHS/aMdew5+f2A5picc6KJ0JWGurKyLei9KIyrtG6tYY
         wSWS/EGRIVXE/xnHoCC9S6N94AuPIoK5ocQzX53js7jCevv9LZoUrK126JyawKnDCkvv
         QRXvpHwljLD0jWZvxMAGawV5v/CY4hxmEcLbI8H/hCHDAh62QHs7OvjWSciLQ4UZq5po
         Cf+YHUAucahaON6sp6Xc9O+WsPUdG+s1nZkZIZ6kILdfOvMLCaVodgf7dMtfRjAXhreA
         1hBA==
X-Forwarded-Encrypted: i=1; AJvYcCWLBBxLGnKu5CvPuErUIKFXHy1IRXpLlJxZUd7AzU26EEYcGoXqsFri+vXXW7s6FWlfeXWjewxU88loBiQLJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUxchbJG4/zz9kszQLGB2ZblBFa2GxD9LvUMB0AmUJ/lN7SRFI
	r49u3a6SPdcq8yF6X3GGfFMJKrsRX2WAuz47kXK6M/G6Q68BOTxS4+5nPBelDebgw8Cm+F/+9u+
	GPA==
X-Google-Smtp-Source: AGHT+IF1tacFrLaohc7CkMS1gtWVWkDqbIHHrrY0gCvWvfr9O5duisiiz3XdJWCovxvuLreYisa8S4H6eT8=
X-Received: from pfbhg1.prod.google.com ([2002:a05:6a00:8601:b0:736:3d80:706e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a2:b0:1f5:75a9:5257
 with SMTP id adf61e73a8af0-20113c57dfcmr1150484637.13.1743801312641; Fri, 04
 Apr 2025 14:15:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:47 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-6-seanjc@google.com>
Subject: [PATCH 5/7] irqbypass: Use paired consumer/producer to disconnect
 during unregister
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Use the paired consumer/producer information to disconnect IRQ bypass
producers/consumers in O(1) time (ignoring the cost of __disconnect()).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 50 +++++++-------------------------------------
 1 file changed, 8 insertions(+), 42 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 4c912c30b7e6..6d68a0f71dd9 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -138,32 +138,16 @@ EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
  */
 void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 {
-	struct irq_bypass_producer *tmp;
-	struct irq_bypass_consumer *consumer;
-
 	if (!producer->token)
 		return;
 
 	mutex_lock(&lock);
 
-	list_for_each_entry(tmp, &producers, node) {
-		if (tmp->token != producer->token)
-			continue;
+	if (producer->consumer)
+		__disconnect(producer, producer->consumer);
 
-		list_for_each_entry(consumer, &consumers, node) {
-			if (consumer->token == producer->token) {
-				WARN_ON_ONCE(producer->consumer != consumer);
-				__disconnect(producer, consumer);
-				break;
-			}
-		}
-
-		producer->token = NULL;
-		list_del(&producer->node);
-		break;
-	}
-
-	WARN_ON_ONCE(producer->token);
+	producer->token = NULL;
+	list_del(&producer->node);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
@@ -173,8 +157,6 @@ EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
  * @consumer: pointer to consumer structure
  * @eventfd: pointer to the eventfd context associated with the consumer
  *
- * Add the provided IRQ consumer to the list of consumers and connect
- * with any matching token found on the IRQ producer list.
  */
 int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer,
 				 struct eventfd_ctx *eventfd)
@@ -228,32 +210,16 @@ EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
  */
 void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 {
-	struct irq_bypass_consumer *tmp;
-	struct irq_bypass_producer *producer;
-
 	if (!consumer->token)
 		return;
 
 	mutex_lock(&lock);
 
-	list_for_each_entry(tmp, &consumers, node) {
-		if (tmp != consumer)
-			continue;
+	if (consumer->producer)
+		__disconnect(consumer->producer, consumer);
 
-		list_for_each_entry(producer, &producers, node) {
-			if (producer->token == consumer->token) {
-				WARN_ON_ONCE(consumer->producer != producer);
-				__disconnect(producer, consumer);
-				break;
-			}
-		}
-
-		consumer->token = NULL;
-		list_del(&consumer->node);
-		break;
-	}
-
-	WARN_ON_ONCE(consumer->token);
+	consumer->token = NULL;
+	list_del(&consumer->node);
 	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.504.g3bcea36a83-goog

