Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90078215075
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801308; cv=none; b=Im6C+R3/bBk0wkWWTDmb3U0kl3zJFGpCt+KjZ8DdO15CjS2zgU1chrB3wx69+DX4GmugNTQ/IzAj7EVs3nRFYAtH1NjNqfn7LEl8/l6JGBHBdGNj9x97aqge0LiH6mPtPbWPlrxxWeJe/eoh0d3aZaGw7DLauWTefRq44ShlV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801308; c=relaxed/simple;
	bh=3eQJAa9cubM3sOJ48FmMAgTG/qqYFR22T28SrTWB6pw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=txU/Nx/16FdOk4jtMi0SDP1GJlEDF/Au6HV/zdkygHMC5eDnkQBp7KIBIB127F8xRemmCMOKy/Rqvn2Oc10bAE/hVQWEJfhWk6uZSbEa1jZBhGzmSqJWc5GUI23V/By6fmrzcR8KYVVJ6sWNxEnCKLx4TIu5ECy9pJsJPlkiCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnjHj6f3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnjHj6f3"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22406ee0243so20434635ad.3
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801306; x=1744406106; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BV0n160bdAMJIwF9gIdsee0gSXMixk7gnYOIwMBSkTY=;
        b=XnjHj6f3YJg6HrzlamLEpZn9up0EMfn1suwxdyFh+slnZQx4llu0tPxt+MOAAWqgWd
         8SHpMmk9KnDLH1L/1F/TWrNqQ24sCQA5Bf4Ck9+4Le2P1ASEsFKZcKbD+yvNXJllYgw2
         eD61ZtewTduLNKVe1BcFvRwFGerwnXvSr2W4prO6Gd3wgFGYadFo+YuMsXCTwcgK8p0T
         2m9UgczYGDRcRZOb00dTL6Uq8Mc8i9CAbV5VpnF3YnB3mxP0IwpisZRoPRHeqQRyP7UT
         VSAyzH2lpMNw2wJVmC0gA6zUQDegx6vtCcNsAMsMRB7VvEeB55BnnWuDA32zKDwx35l3
         b4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801306; x=1744406106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BV0n160bdAMJIwF9gIdsee0gSXMixk7gnYOIwMBSkTY=;
        b=lKyMkMDr+IL4u2iw83HH3AFPTrv1pNSZyW13fct2FK5vn0/ioSMPo7qBNpNUkB9/EI
         kqRII8WT7T9YTZHI9kMvZfNzPhzq5vTlDR8d8gJqIr15lIWF7qS/JV1LnXZ0Rejqvv0l
         /CiGwZzxlSQ/jK1Y6MZZhvREe8exD0rRvFdgqWKzX8dEbhhT8sfEVkaWRLZ5uyrlmWqS
         yViDwaSMXAYxp2OuleuYVqE1k2KpIlr81Wgpj0BCeCMWZYKUJTHP12rqS3CZNyjKDqSv
         1YmFXJ3FrSy4jACZmFsFW65SNkK5p05iRP/0JEHGZXiFlw658l4ifMT/KI9xSimaZGkt
         Nw4g==
X-Forwarded-Encrypted: i=1; AJvYcCUADQlVLZYczIS4osDeURtGAJbhWGAKZ2oN8lnn+xHAoest4kJTAV7f1FzCPx8XzIZT0tIQlUcWzPanBYnxiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJSsIz3N1lgBHahrYFJESk68seumVYIclSqcZll5S23W0OTL1d
	YnGarRzDZTF9gEW7NO0gFYQgvpz5lpBCKYYGbwvlHqp5KcHKy7IFPi2vnc/6Gpuz8FsjxLdj+8n
	itQ==
X-Google-Smtp-Source: AGHT+IHGnE8XslHm/Dp26htMuuamh5CyH4BkTccpSE3E94306LmR6+QWCeFh1nKaosRJPLYDlX1yhMluHf0=
X-Received: from pfcf1.prod.google.com ([2002:a05:6a00:2381:b0:732:858a:729f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e883:b0:224:255b:c932
 with SMTP id d9443c01a7336-22a8a04a526mr44725315ad.3.1743801305822; Fri, 04
 Apr 2025 14:15:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:43 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-2-seanjc@google.com>
Subject: [PATCH 1/7] irqbypass: Drop pointless and misleading THIS_MODULE get/put
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Drop irqbypass.ko's superfluous and misleading get/put calls on
THIS_MODULE.  A module taking a reference to itself is useless; no amount
of checks will prevent doom and destruction if the caller hasn't already
guaranteed the liveliness of the module (this goes for any module).  E.g.
if try_module_get() fails because irqbypass.ko is being unloaded, then the
kernel has already hit a use-after-free by virtue of executing code whose
lifecycle is tied to irqbypass.ko.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 28fda42e471b..080c706f3b01 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -92,9 +92,6 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 
 	might_sleep();
 
-	if (!try_module_get(THIS_MODULE))
-		return -ENODEV;
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -120,7 +117,6 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 	return 0;
 out_err:
 	mutex_unlock(&lock);
-	module_put(THIS_MODULE);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
@@ -142,9 +138,6 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 
 	might_sleep();
 
-	if (!try_module_get(THIS_MODULE))
-		return; /* nothing in the list anyway */
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -159,13 +152,10 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 		}
 
 		list_del(&producer->node);
-		module_put(THIS_MODULE);
 		break;
 	}
 
 	mutex_unlock(&lock);
-
-	module_put(THIS_MODULE);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
 
@@ -188,9 +178,6 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
 
 	might_sleep();
 
-	if (!try_module_get(THIS_MODULE))
-		return -ENODEV;
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
@@ -216,7 +203,6 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
 	return 0;
 out_err:
 	mutex_unlock(&lock);
-	module_put(THIS_MODULE);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
@@ -238,9 +224,6 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 
 	might_sleep();
 
-	if (!try_module_get(THIS_MODULE))
-		return; /* nothing in the list anyway */
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
@@ -255,12 +238,9 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 		}
 
 		list_del(&consumer->node);
-		module_put(THIS_MODULE);
 		break;
 	}
 
 	mutex_unlock(&lock);
-
-	module_put(THIS_MODULE);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.504.g3bcea36a83-goog

