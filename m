Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7E2820A3
	for <virtualization@lists.linux.dev>; Fri, 16 May 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436867; cv=none; b=CSYyjK6mG3awzwVXCQ9nAKjbhmj+ZaUJqSwtIV5qDz3sKQHrpr+Tm2rNRsMUYq6NV+CkVU5umKnNmGIrTzpSsJPuXG8RLtc70vjgrarbUiJ4GKiIdOgpRH01HO+8hlDaS0OTArb/gJQjwo0Bgkgf0zZVwGdvMBEcpqo8ahkdB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436867; c=relaxed/simple;
	bh=LXzlgHyJWhAACXWbAPkfKszMlKXyO2bFe2sK3lMkj8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AbxU/HvhPy46iQOm98Pkwg4BvLEyG3xKY45djheF+iD1uE+5wW+vSdSr/wA+YxpDcIjnGECQfq0nNd3igdIOFq1MwfW1Cvl8W4aKwkC/Xhacf2yEx98jdHiOakBoS4zKEPkWPn93gbXepsTvlJ1lmGpmRU/p93s6qbHYxNlP3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMn6fA+/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMn6fA+/"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740270e168aso2422481b3a.1
        for <virtualization@lists.linux.dev>; Fri, 16 May 2025 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436866; x=1748041666; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+HnZi3oDQ4eOcZyXHAiIALwrX3oRAnjbvkn+7/oMfkg=;
        b=iMn6fA+/cREpseMrZj16EQiu0O+boQTtp2ODRmnk89ZAkrQafCwvBW7Rxz+F4IAnSn
         uZu0/Vf4cSBSuWDeoPZDVNMlrXY8dtgz049vM+iJcUzwAmqwEUIjmdjKIy01kCTLDYVX
         cx555ls9GFhGxlqhkvC4aJ4kdJsUV1ZV1Lw+As4gCWuVgk+d6/YBVDro0QiugqerwF1h
         t+CEBW79hw7j3TDSic75XQQK2gTC0KWt38HyXAIS15uJGabOvVeNdUkxaxjzdFQFqs0u
         5d8ZJDC0Z4kvB+2V/EaBPVs+4Jps3VxTmzeM+Cd0K/oSWoIFmf06pe2EUVJcaDLJbGwN
         EsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436866; x=1748041666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HnZi3oDQ4eOcZyXHAiIALwrX3oRAnjbvkn+7/oMfkg=;
        b=kr0XTET7VtrndXc2qQMtvNuiV/6MyJogYZjXLLTDmCpiejH8SWcxlYrAMs+xdNiRtr
         WaM0WUFQhwbNeKMw8Nx0KarPfNFjwzYjRmsIl7mhYQ3Y+w39T5dImeM4vjoYiJkJzx+S
         e6Dg78W63O87QyY8cgOQ5h92kvOIoyxxpeKTjSqe0sXOKsvNSulMYdZw9aK2V7kNpcpt
         2qnG0xTAgHK7ymTJ94jJwPEvwhMcMB1SZ8nvpadiL8PqwbTetkOm0tPj7dQDgGuhUZsn
         JbopqRqhpLrePfZTFxqyCXvlGVDN4HaSVa5Un+XL37ndNjP0krC04DXuobZDzhA1LN6M
         BiIA==
X-Forwarded-Encrypted: i=1; AJvYcCUL8/MGyfxin7izTv+BwjO0lpRSS/FOw6veaPkYIZtdXBZwg7f39GTZin3UISoy076E+xX+bndIzbX/c4dZ8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqV4uaLeDLUNA4yVNyOFY9gIDch49RPwRJ347hxa0TVHw14woZ
	8UDX8RHDmPofksx6dKqji9yet32aF8Of9XDbcGe5RumHeidzG8WcrgvkXncs11DS53B0bgqLEtn
	C3G8Y5g==
X-Google-Smtp-Source: AGHT+IEGr4DLQ/k+zVDPTA3QzCbhpesiuJ3Rc20pXKhfdxG6vKdbrJk/l1JnNXE3bXTLhq+xJb2nY6Mhx3U=
X-Received: from pfbmc24.prod.google.com ([2002:a05:6a00:7698:b0:740:b53a:e67f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ca:b0:742:aecc:c47c
 with SMTP id d2e1a72fcca58-742aeccc69cmr4693335b3a.7.1747436865717; Fri, 16
 May 2025 16:07:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:30 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-5-seanjc@google.com>
Subject: [PATCH v2 4/8] irqbypass: Explicitly track producer and consumer bindings
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

Explicitly track IRQ bypass producer:consumer bindings.  This will allow
making removal an O(1) operation; searching through the list to find
information that is trivially tracked (and useful for debug) is wasteful.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/irqbypass.h | 7 +++++++
 virt/lib/irqbypass.c      | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
index 1b57d15ac4cf..b28197c87483 100644
--- a/include/linux/irqbypass.h
+++ b/include/linux/irqbypass.h
@@ -29,10 +29,13 @@ struct irq_bypass_consumer;
  * pairings are not supported.
  */
 
+struct irq_bypass_consumer;
+
 /**
  * struct irq_bypass_producer - IRQ bypass producer definition
  * @node: IRQ bypass manager private list management
  * @eventfd: eventfd context used to match producers and consumers
+ * @consumer: The connected consumer (NULL if no connection)
  * @irq: Linux IRQ number for the producer device
  * @add_consumer: Connect the IRQ producer to an IRQ consumer (optional)
  * @del_consumer: Disconnect the IRQ producer from an IRQ consumer (optional)
@@ -46,6 +49,7 @@ struct irq_bypass_consumer;
 struct irq_bypass_producer {
 	struct list_head node;
 	struct eventfd_ctx *eventfd;
+	struct irq_bypass_consumer *consumer;
 	int irq;
 	int (*add_consumer)(struct irq_bypass_producer *,
 			    struct irq_bypass_consumer *);
@@ -59,6 +63,7 @@ struct irq_bypass_producer {
  * struct irq_bypass_consumer - IRQ bypass consumer definition
  * @node: IRQ bypass manager private list management
  * @eventfd: eventfd context used to match producers and consumers
+ * @producer: The connected producer (NULL if no connection)
  * @add_producer: Connect the IRQ consumer to an IRQ producer
  * @del_producer: Disconnect the IRQ consumer from an IRQ producer
  * @stop: Perform any quiesce operations necessary prior to add/del (optional)
@@ -72,6 +77,8 @@ struct irq_bypass_producer {
 struct irq_bypass_consumer {
 	struct list_head node;
 	struct eventfd_ctx *eventfd;
+	struct irq_bypass_producer *producer;
+
 	int (*add_producer)(struct irq_bypass_consumer *,
 			    struct irq_bypass_producer *);
 	void (*del_producer)(struct irq_bypass_consumer *,
diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index e8d7c420db52..fdbf7ecc0c21 100644
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
 			if (consumer->eventfd == producer->eventfd) {
+				WARN_ON_ONCE(producer->consumer != consumer);
 				__disconnect(producer, consumer);
 				break;
 			}
@@ -234,6 +242,7 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 
 		list_for_each_entry(producer, &producers, node) {
 			if (producer->eventfd == consumer->eventfd) {
+				WARN_ON_ONCE(consumer->producer != producer);
 				__disconnect(producer, consumer);
 				break;
 			}
-- 
2.49.0.1112.g889b7c5bd8-goog

