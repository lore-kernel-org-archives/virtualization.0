Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938D2836AB
	for <virtualization@lists.linux.dev>; Fri, 16 May 2025 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436871; cv=none; b=KO6uFC2FmwxbdTnRCrZ1PyZpAMdAGejuuXsBBRbSuqdiD9lt16WpqI768XP482DCyB5mX6IwfnhQovZCguLnHnn9qFIIUmSE0Rzikp2wLD96WNSmecVEwzAGvpssrPhXnakjseO0ijuV0Z18Qb0rUkpyFovAzKe8ZssUjBBvjo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436871; c=relaxed/simple;
	bh=3eV70KuPSBCjK3Otg1fXvhrN4aUAqOQEKnpjeLf+MLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LpMRqv7+h1DE8zY3jC8Y/M99RDVV8+T4ve7Xn6zg8NGM4tRA1BnXnaXs9yrjz5nAm/p2yF75XtTUIaCsbc6Hm+jmd3g/D7Pg2njnoDf4dPBuWENSzUC+ga4jbr1DZ8CUBdJqZSHFSNCk0eZbLAm2oDmwyaqDtR8A5viING/RQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zy/Ywg/u; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zy/Ywg/u"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e6ccd17d6so2430444a91.1
        for <virtualization@lists.linux.dev>; Fri, 16 May 2025 16:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436869; x=1748041669; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PToc7yVowqyTNBLhp6IJYYBJ3tIDF6DyMy5BFKXkP80=;
        b=Zy/Ywg/umBBqjBmyndsDK7S9fcb9jRyqZdzHah+5BgcElmPqZw0VaT7n/0rb5EeQe9
         nY6qLJdy1u3Y9YGzRSoNdtJ4gsOfOqYvLZ4lQOTVoXQ4zXoyxeYtVSDdOuizu0I1Fwqs
         X1cYxLi+a7S0BUb/G5vd/F/zI6tFFLLkUEcBWDQAY3iDDIc1HjsYwFDzQ4FGPSBV39Az
         Xwp26V5OxSPC5QZZ/rMx9T+6j3dKMxBmaXnmELnP1RvTlNGhgNj0HKrkZfGmQs+dJYk2
         IFgqCJmaw1W7bRrio/JK8LUmSuCivQ7c2jwdeqMl9av5TtQXr/9BYiodzRYT268FylET
         1GKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436869; x=1748041669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PToc7yVowqyTNBLhp6IJYYBJ3tIDF6DyMy5BFKXkP80=;
        b=SOXS7Fb0PHy9P0IJiJvE1i46kew1AMVrtTn3DPFA1korIh65rpoAYd6BBJIwo+3Xjq
         B7OnmxUa2X3gYCBR6Yb4VHV65a9Iverd56vdmaPaJnp948BjKMt/HmK/aQfkKEC1UMnY
         kPsYFXIs6g7a3mMl3h8yiN/7dRkynLC/AC15lnWeURk/ojNERQ8fHfEkfIl1/IV1TTEC
         8d7k0VqNnqbPECZnFcAfY1l1WrhDj2ljkdsAnIYx9mnFjqNlXOBWyiqCaWu/1mEPXqeW
         qdWOElogACgm5IVCZKjQyjdrgRojBjhsbDFiHUxJ+k3tYzT973xuuYzGn/gXo5jJJf14
         JHYg==
X-Forwarded-Encrypted: i=1; AJvYcCVxZj+98/prLhbJPaZBl2qekm50KI2yg1gmyxUEeLIDy+3h0Xe+WHCeX4PXFyDPuvyCqVmXXGswo6bUQiBJGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIBd3gtnM1ykTwGm2kE8L6NmI/RkM5VksT3z3N1LLt2aB2Vu50
	Y8TYq9aMHLHhug+KJVCUOnLwbCQ3VTi9PD0PWd7H/MqiqvAKEzhABtUZxGwE/YymFVjc0qT7QOc
	GVryPkw==
X-Google-Smtp-Source: AGHT+IFMqF17coq6lIynvImodo9GEBI80OqIy5QNctbeCRw4yO4mG2Xb1BFvJbWtlWRj5T810Vi94FLEzzA=
X-Received: from pjbqj4.prod.google.com ([2002:a17:90b:28c4:b0:308:861f:fddb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c05:b0:301:6343:1626
 with SMTP id 98e67ed59e1d1-30e7d4f91ccmr6639663a91.1.1747436869330; Fri, 16
 May 2025 16:07:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:32 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-7-seanjc@google.com>
Subject: [PATCH v2 6/8] irqbypass: Use guard(mutex) in lieu of manual lock+unlock
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

Use guard(mutex) to clean up irqbypass's error handling.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 6a183459dc44..828556c081f5 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -99,33 +99,25 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer,
 	if (WARN_ON_ONCE(producer->eventfd))
 		return -EINVAL;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
-		if (tmp->eventfd == eventfd) {
-			ret = -EBUSY;
-			goto out_err;
-		}
+		if (tmp->eventfd == eventfd)
+			return -EBUSY;
 	}
 
 	list_for_each_entry(consumer, &consumers, node) {
 		if (consumer->eventfd == eventfd) {
 			ret = __connect(producer, consumer);
 			if (ret)
-				goto out_err;
+				return ret;
 			break;
 		}
 	}
 
 	producer->eventfd = eventfd;
 	list_add(&producer->node, &producers);
-
-	mutex_unlock(&lock);
-
 	return 0;
-out_err:
-	mutex_unlock(&lock);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
 
@@ -141,14 +133,13 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 	if (!producer->eventfd)
 		return;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	if (producer->consumer)
 		__disconnect(producer, producer->consumer);
 
 	producer->eventfd = NULL;
 	list_del(&producer->node);
-	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
 
@@ -173,33 +164,25 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer,
 	if (!consumer->add_producer || !consumer->del_producer)
 		return -EINVAL;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
-		if (tmp->eventfd == eventfd) {
-			ret = -EBUSY;
-			goto out_err;
-		}
+		if (tmp->eventfd == eventfd)
+			return -EBUSY;
 	}
 
 	list_for_each_entry(producer, &producers, node) {
 		if (producer->eventfd == eventfd) {
 			ret = __connect(producer, consumer);
 			if (ret)
-				goto out_err;
+				return ret;
 			break;
 		}
 	}
 
 	consumer->eventfd = eventfd;
 	list_add(&consumer->node, &consumers);
-
-	mutex_unlock(&lock);
-
 	return 0;
-out_err:
-	mutex_unlock(&lock);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
 
@@ -215,13 +198,12 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 	if (!consumer->eventfd)
 		return;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	if (consumer->producer)
 		__disconnect(consumer->producer, consumer);
 
 	consumer->eventfd = NULL;
 	list_del(&consumer->node);
-	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.1112.g889b7c5bd8-goog

