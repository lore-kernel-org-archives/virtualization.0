Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB44209F2E
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743801316; cv=none; b=VsxYT1IvJl+UEdnR5/6MKhbQZMQHw5K2U40OlrWT4NZKgdfA/8ADgba6m7BNwWAWyTHTO3IDSSNIAl6EuHMuw5HHNJNqVgKfszjT7ndgi1f4WiVOGnfbl0WzMvRBjO9Ult7X8IiC/JsJAF5S9NGNn+uGbVoF5EvPx56TR3N9ElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743801316; c=relaxed/simple;
	bh=v2ORapDpafgERkpHUzPjtrfKBhCT/RFfLsP2a6B2+4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BclMzSgNxnbwHy8mDu0ptOy8QLW0qFCyn0a9KM3NbUMVyhk/f1VYTCNFHVaSyHJirZhApaUVxNATCAwFwVEEFpJmLu+xhIBRDtRztNxyYmWmYT4FmGygMsjUWqjZcOl/DDcfYMefA/ApGFujSl2v6pJ+A8FYRbUVtPujYIgcYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDctaaeS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDctaaeS"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so2407947a91.2
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743801314; x=1744406114; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ucS1cIhi1yvIAjPfmLIaKa4ZPwFGctQlvybswzj8SS0=;
        b=xDctaaeSIgyavOTKmVLWKWEmGHOGYusBVw8YIbkckeFrdjfyz8B4RhmqYNa6d4lWoT
         3DHfRPoyiFNBla2QAwQspHI1d88qIMfSOiw1OKnRqC1k0ZmCLZ7GNmnCRgQVKEjH9/w3
         fHfVf8x8IpSyPSFZXrOtkO9bdF6lq2Pvg6XOB2yuQTuIpbh808ICgR65Eacp3JhXjPiR
         UZ5gmKbwlpKzi1ON73bjacm+3u7PnCLrwtwDHTh1aNZlrz7Ar87bpmrl8+RDItUMjoBw
         AkYw7obLCR0ywtrZZ05FjqoVafsAodjUlpo/jrWHc+SgOAgmVlTpwQ6LvMuo7rsfiPwF
         jB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743801314; x=1744406114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucS1cIhi1yvIAjPfmLIaKa4ZPwFGctQlvybswzj8SS0=;
        b=JDEdvbrM/oF0SfrrqqlqdXfbet92HZu9hG1TnXBmbS1HBoUQMofX6Dx5DvdLrVm5pC
         OKbvQghFTn7maK4E299tvpGGBAc77aN4g84VQSduuGeBhbRu/p1+48ZO28icUt/tTPR6
         RDky3v3y1GGZBdJnEeDT6DqC3cZWabA6wdnFp4nrMUVxADEkVjG5REzOMMlL0Icj8YlO
         r1QU9d/8dR9dZZ6WaVQJ7+9379KcZLxgZZubn/KZf0snAsLcHx3Zr06/GB8wVnlOEcFc
         oQF3DAL4+M3uKJWV+7ZqNbNOkrk+GyeekjNemCdnMrNvWOf1sBIeK7oh8slLz4BSieh1
         CHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3DL0rV3muMgOdFj+5n1kz26wVNm6SLjKaBicXUTVJhpSOUw1x6T5OrFR2llLccKgJnTNDnmbkBqhDFd0FqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo6MHuSTvO5V8SEvwo2ozMdVXHOZkiRCuvBzsW3Pbgn14zFoRy
	VtF+e8ghe1htNJfBTcUAj8DUqpFIlFMT68N7gvpd7yZp4F2+3Z2UavHq1RIMSlYve2lTFgfYDVF
	KjQ==
X-Google-Smtp-Source: AGHT+IEDdhL+lnjtcVL1Ed1bGzXYhiIsJzjfh13+tnkRQcRgpIirVPKBZIbe1qE7JT7XC/jfJQDJSp2S8E0=
X-Received: from pjbqn8.prod.google.com ([2002:a17:90b:3d48:b0:2fa:1803:2f9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cd0:b0:2ff:784b:ffe
 with SMTP id 98e67ed59e1d1-306af71b814mr1108191a91.11.1743801314494; Fri, 04
 Apr 2025 14:15:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 14:14:48 -0700
In-Reply-To: <20250404211449.1443336-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404211449.1443336-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404211449.1443336-7-seanjc@google.com>
Subject: [PATCH 6/7] irqbypass: Use guard(mutex) in lieu of manual lock+unlock
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	David Matlack <dmatlack@google.com>, Like Xu <like.xu.linux@gmail.com>, 
	Yong He <alexyonghe@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Use guard(mutex) to clean up irqbypass's error handling.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 6d68a0f71dd9..261ef77f6364 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -99,33 +99,25 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer,
 	if (WARN_ON_ONCE(producer->token))
 		return -EINVAL;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
-		if (tmp->token == eventfd) {
-			ret = -EBUSY;
-			goto out_err;
-		}
+		if (tmp->token == eventfd)
+			return -EBUSY;
 	}
 
 	list_for_each_entry(consumer, &consumers, node) {
 		if (consumer->token == eventfd) {
 			ret = __connect(producer, consumer);
 			if (ret)
-				goto out_err;
+				return ret;
 			break;
 		}
 	}
 
 	producer->token = eventfd;
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
 	if (!producer->token)
 		return;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	if (producer->consumer)
 		__disconnect(producer, producer->consumer);
 
 	producer->token = NULL;
 	list_del(&producer->node);
-	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
 
@@ -171,33 +162,25 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer,
 	if (!consumer->add_producer || !consumer->del_producer)
 		return -EINVAL;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
-		if (tmp->token == eventfd || tmp == consumer) {
-			ret = -EBUSY;
-			goto out_err;
-		}
+		if (tmp->token == eventfd || tmp == consumer)
+			return -EBUSY;
 	}
 
 	list_for_each_entry(producer, &producers, node) {
 		if (producer->token == eventfd) {
 			ret = __connect(producer, consumer);
 			if (ret)
-				goto out_err;
+				return ret;
 			break;
 		}
 	}
 
 	consumer->token = eventfd;
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
 
@@ -213,13 +196,12 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 	if (!consumer->token)
 		return;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 
 	if (consumer->producer)
 		__disconnect(consumer->producer, consumer);
 
 	consumer->token = NULL;
 	list_del(&consumer->node);
-	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
-- 
2.49.0.504.g3bcea36a83-goog

