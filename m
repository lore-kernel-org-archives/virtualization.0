Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18398230269
	for <virtualization@lists.linux.dev>; Fri, 16 May 2025 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436861; cv=none; b=cdQNSwGh3EUcLR1fZllpFOwu/rYSLD6WkU31WkkfbGM0INGLbaa3590Ang9xJIcilBnKBs4NYt4tX3t1ZVLXOSbwcjfSL7C70at2UTZSj4Zhw4XcJGpvIHCD7F4jm7WFslnPUvUfgcj7v5Ziyc+jUpnuHe2eCqU5JWkwymk/2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436861; c=relaxed/simple;
	bh=I1ALcWIwC8w2ZTqFEjmPzQUw5bLz7mdjqS6Qdf0kmJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VOP0TdihIAbnUCmdnNWxBckRrTA9WY1o7RhajH4dDlOR5mfkSuF75dIekq5/NBQJkn3hM7Z0mXE0pMHS0jtRjHRdmO/r+OPTgMVKsYmHGLFtF2sj75VsmplkmH5+sKzeY1VvTpZVarEj5fO92Ce4O0KnBy99mVWt7bIl0cFvre4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nb4ehhtt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nb4ehhtt"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30c54b40096so2905604a91.1
        for <virtualization@lists.linux.dev>; Fri, 16 May 2025 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436859; x=1748041659; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8kDa/puR8zC/TVy/ii11k+vGNrXdae9yxfqU/1udF6g=;
        b=Nb4ehhttFUznPQaZLpuvg3LV2tvGvLfg/ttT4wqRyiZpaxfqYAFQFZ/cYA+my5Szjh
         j9l353g+QPYZ03k5KxpWo8H+OjdDz2AdmbQLUnKdw6bohMm7JuZsPtrQ7U9ow4dirPcW
         /3dv6Eax73TM1LbB+bW9kUHYpFIV5VACdMpsB7ZXum8RcU0L2hSGnKpL9EBCghv834gJ
         zH1PlQM6seCFyQ0MiVkn3lNaZj6rARrJoyqQqp3b+Y8tcRhwwSajaWCUGdDRL/WKG4Zr
         1on0Vga4OQ96cs3ueGXIFf+AUuQApqvg+zJyvJhIXlz328aaeHyyRZIIrRuje18addhO
         bEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436859; x=1748041659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kDa/puR8zC/TVy/ii11k+vGNrXdae9yxfqU/1udF6g=;
        b=ZV8RPMyrgWGu+jhSN3YcZR0gTHL7C++tVKnrcSdwQvDXOpXfB2ifLQHL4eLrEQ7XzG
         Kwk4AGVSIyl0MxKCOqAY0jKYi3/A8bPZq7iwf4sMeCPcSRelspUX40i0aO3WltjrbFJZ
         D50vWzep2seYWtO5cdb/zLjkuVt2dl4dQjqy4HgZu8Frp/RL0uJHZ7sq4n7Lw37nzQjY
         k5Go7ha0HZWXGsGXf5hcOPD/7aCm6bXGVsp3S5dP2GwVItTBraSpX94piloypwHUA/7F
         c9saQmIBJ3hG54Ab5LyFvecsCmNNGGQP4NumCnve9JiT6WY+45Vs1OEdW8+UrdeQxu35
         mTHA==
X-Forwarded-Encrypted: i=1; AJvYcCWdKe2FV+mXIPZgL6n3JN/aRxjvnefYxmPkANC4sFWkDfriNCUNdmWfrpDQpVYi16F+AR1lIQ2wRLCrRvrocA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0OoVPIvijdS+SebuQMlxvShLqvSgJRn8JVrOfzO9thpfYgHBj
	ONEPfjPqjOKnb4+GL2OTWWJObJXefOhOb3sczC+sFNrdMnqew4eZ5DVPUaYMs6gK01G0Kmnf+wS
	N/dlrcA==
X-Google-Smtp-Source: AGHT+IGms52EOzdUpeUySel370WkLvf5qcqXwBrssv6N0gEIpnS2oZ+4XnP+3IKYtmrBjEsQ2ftNzRdpjys=
X-Received: from pjbsb5.prod.google.com ([2002:a17:90b:50c5:b0:301:2679:9d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e8e:b0:301:1bce:c255
 with SMTP id 98e67ed59e1d1-30e7d5a93bamr7142197a91.27.1747436859419; Fri, 16
 May 2025 16:07:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:27 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-2-seanjc@google.com>
Subject: [PATCH v2 1/8] irqbypass: Drop pointless and misleading THIS_MODULE get/put
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

Drop irqbypass.ko's superfluous and misleading get/put calls on
THIS_MODULE.  A module taking a reference to itself is useless; no amount
of checks will prevent doom and destruction if the caller hasn't already
guaranteed the liveliness of the module (this goes for any module).  E.g.
if try_module_get() fails because irqbypass.ko is being unloaded, then the
kernel has already hit a use-after-free by virtue of executing code whose
lifecycle is tied to irqbypass.ko.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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
2.49.0.1112.g889b7c5bd8-goog

