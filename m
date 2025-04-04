Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD1221720
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801313; cv=none; b=NowpqbqafTyPDj7aWJ6TmeF8SlYM6VZ63KuBhqjRmptdO0tT+IlcY9ywGDqcsZBMxmUx2bfFXdx8M6gSDkX/pCIQ+oibq8yaCQ4VnDOcZdmJ3YKVT+Pz/L/qJ0WpEOJDWcpBDaGVGWHfXhZH3NjJDKk5MW+3UzOKDX40gjoV8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801313; c=relaxed/simple;
	bh=ln0aTW/Mog3QiYUyYj6SaLIFRtDT+yAljImMR/4auLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EsXwrdbGehX4Dq78YFg/6hSW8kdsI34tW/Xoza9G7YtJ7Ty5ujJGxnTXc5IhfIdNRy6V2f9tIWEbpsPjcS+7c/yOz7ROAR7OOhB9edo1fkbC1m0Ufv8McE9AIioZMRmFASq3FqWKSq/mM7qHHrMI+BYNDA27h4jij34sEWagWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5C2jNL2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5C2jNL2"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af91ea9e885so2162124a12.3
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801311; x=1744406111; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue20B1Tzy5G0qxMoWwTOp7P/8+RIOeWrrJYBbIRxnEc=;
        b=T5C2jNL2hvqtcYl7EPx3/0cYQjfocxETlSP7/7Kps9wDwHz/5qmX353dBGNOFgoj1X
         bulZXecilCiJeRjZ6MeTyJZDcxbaQNRnx658ctK26O5YJdckA6HC+PdP1o9KL3x6S+ou
         VoPweJJ0M60SeiCeRAfOVmsAqJkZEGZjVcjSc8xvy7Zt4yx0XHwHjt28hRYBg75hgeUz
         mwhiWSDix6pNWImuHtKsiYo4u8hDawGEaYgYKy9OokkZlQxMZt5KisVdw7aGjfS1FcIZ
         F+MmgGhv5MigIlPQuEMlKOq0k+mdGzGDJFvAT3CxciQpUOsHIodGvXz8qAK2Jw7Kljtt
         pI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801311; x=1744406111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ue20B1Tzy5G0qxMoWwTOp7P/8+RIOeWrrJYBbIRxnEc=;
        b=YSVKqQfdYIufovVfYq4ih2ZexXMEEdK+BjrieUT4D51U/qfbwCPa8v9NfeLeOmNw13
         r+y82uBzapsqQj9fa5XQTC69p4KhKLmXbmR0wMifzMV4hOzn1XmYLAbaw0+xh7gqrIHr
         jFJ2GAGI5YPt0YqTqk7hmZiD8KoX4eyryslYSkyQ/5Ppox6cC5PAvOcrYKepV1ad9j9f
         TjuCINOGaGL+DAM7wFv2ZpZhm1jyzCp9hfImxQq6F10V3Ao1DHemPAE0rSPWEF8M4Mmz
         8aN9YZo7jY9wjNAGFO8WBi5lM5kRYjLJS9IznfHknZjoEqifjW3qnK2jm+LknDOdtugJ
         GRaw==
X-Forwarded-Encrypted: i=1; AJvYcCVqgVWuMOpSkFAx6OBgWQDpC4tYVoXyqM4QQyT0Vh3f5tiQcUz6yDSmKohR/ggwgrNVMnEZLODVRAdHJytG3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBYJvq4UKZHNMMEbVwddgDaMsg9GEFcaNJm+Y77jyzmtWhOINd
	aQiqIdNSMUS7XHMi4YGqhuGmAgpCvIP30FnrcyCoy7A8ue07P2ti3lKrgYnVAEMOXbNt2W1fYxb
	DGg==
X-Google-Smtp-Source: AGHT+IFis7TOzLrl3LJaRKq/QGPjgSup5fUiygS7yEG7/cr8vy90lgR7IWQgZT0YqXwXkXorjxg8Vt14/hk=
X-Received: from pjbpb5.prod.google.com ([2002:a17:90b:3c05:b0:2e0:915d:d594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2649:b0:2ee:53b3:3f1c
 with SMTP id 98e67ed59e1d1-306a61208bdmr5711511a91.5.1743801311080; Fri, 04
 Apr 2025 14:15:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:46 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-5-seanjc@google.com>
Subject: [PATCH 4/7] irqbypass: Explicitly track producer and consumer bindings
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly track IRQ bypass producer:consumer bindings.  This will allow
making removal an O(1) operation; searching through the list to find
information that is trivially tracked (and useful for debug) is wasteful.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/irqbypass.h | 5 +++++
 virt/lib/irqbypass.c      | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
index 379725b9a003..6d4e4882843c 100644
--- a/include/linux/irqbypass.h
+++ b/include/linux/irqbypass.h
@@ -29,6 +29,8 @@ struct irq_bypass_consumer;
  * 1:N pairings are not supported.
  */
 
+struct irq_bypass_consumer;
+
 /**
  * struct irq_bypass_producer - IRQ bypass producer definition
  * @node: IRQ bypass manager private list management
@@ -46,6 +48,7 @@ struct irq_bypass_consumer;
 struct irq_bypass_producer {
 	struct list_head node;
 	void *token;
+	struct irq_bypass_consumer *consumer;
 	int irq;
 	int (*add_consumer)(struct irq_bypass_producer *,
 			    struct irq_bypass_consumer *);
@@ -72,6 +75,8 @@ struct irq_bypass_producer {
 struct irq_bypass_consumer {
 	struct list_head node;
 	void *token;
+	struct irq_bypass_producer *producer;
+
 	int (*add_producer)(struct irq_bypass_consumer *,
 			    struct irq_bypass_producer *);
 	void (*del_producer)(struct irq_bypass_consumer *,
diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 98bf76d03078..4c912c30b7e6 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -51,6 +51,10 @@ static int __connect(struct irq_bypass_producer *prod,
 	if (prod->start)
 		prod->start(prod);
 
+	if (!ret) {
+		prod->consumer = cons;
+		cons->producer = prod;
+	}
 	return ret;
 }
 
@@ -72,6 +76,9 @@ static void __disconnect(struct irq_bypass_producer *prod,
 		cons->start(cons);
 	if (prod->start)
 		prod->start(prod);
+
+	prod->consumer = NULL;
+	cons->producer = NULL;
 }
 
 /**
@@ -145,6 +152,7 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 
 		list_for_each_entry(consumer, &consumers, node) {
 			if (consumer->token == producer->token) {
+				WARN_ON_ONCE(producer->consumer != consumer);
 				__disconnect(producer, consumer);
 				break;
 			}
@@ -234,6 +242,7 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 
 		list_for_each_entry(producer, &producers, node) {
 			if (producer->token == consumer->token) {
+				WARN_ON_ONCE(consumer->producer != producer);
 				__disconnect(producer, consumer);
 				break;
 			}
-- 
2.49.0.504.g3bcea36a83-goog

