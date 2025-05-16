Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC7280A27
	for <virtualization@lists.linux.dev>; Fri, 16 May 2025 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436863; cv=none; b=SFZYsa0Vrdx5lFBYpXvyAg4PuVp56HnHSm3D98+0bLhpV7SWOrd6Jhur8fEIcFAC88LKblJe1+oHEq4NKE02SuT62q+KEYNzxNqrPjqzW4RhSUNBG4AaQRSA+NQDjpVqisPCr1qZjyGQGAEMZV4upm2+z3nrq3GSxYgIk2je7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436863; c=relaxed/simple;
	bh=53lKZIp0QEDIxAnbUsZj0HBAIqsGZWy+CnuC9aywW/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pWciLXriy0UwUuxf2a+Jnu1aNzo9feP0s8bDoAEy1/tKAP530IyvAuaBDTKxY73lYpZzir3HlAEGn+saX4rr3Ul7HUKNIaWBneVPmiuEB1CC7XDgvNNQ4TlFJpHpHKnIrOatXE8wNTlfHLV7Vv13vgGGTjsppvoy6tylHRjjW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+n72xD1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+n72xD1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74292762324so2088287b3a.0
        for <virtualization@lists.linux.dev>; Fri, 16 May 2025 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747436861; x=1748041661; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NfgqeidfxQ2kyf1sJo8U3YZ4JNEzadROFUB65CCKoYo=;
        b=h+n72xD1dxyIB1Omqz7FGM6cumlU8+HnA+lZp4BBctDIzURyHZFga34bs91Se4DDX0
         vb4JEbE8qt/R+QjtmouRxB53opxx8JIrwqcUe4+WKwuZUBQZnT2rt4cRCK9SWkL18Mda
         LQkO1ia/RrjiWrF1rXpxcH20+bR0ePR62NU8se0DR0gN3t9UdcfwC9+/KZMe0ElCNPhm
         dW38W+p4a/XvveyZFgkC1CCS5kJ3iXItDPorFob3CMQE9WSY5AbtW4IWiHbFjeqPS2gw
         C/IC+hbvGZv5UliGRBk8IRs3NLHUwFypNSXkXKpzD+s2nvA9BXX+UQPALHZKkVhJokg0
         v2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436861; x=1748041661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfgqeidfxQ2kyf1sJo8U3YZ4JNEzadROFUB65CCKoYo=;
        b=QRhP43BOMhd+RBhZdtWTkpT32DmuEHqL9lowvttLYYZsMuee9MHhDiujD4b2zXfo5y
         7rTN7aBPv5VmYf7OaqhPF1CGLT2Z6jLjAyetfemvjSeHMwSDUGUEOQX/Td/CprNQqYQU
         WTu7PV3xshrsyV769/+OKrSSDw7cWuEw06MUHTbTRm7IBmAtTU3DseeFr2j+/YUv/vAt
         i+j6fxz4e5XF8ATqZhcWNkxAp8un/62sIhpLhZuuACMq6yX54N/ShsVkbWMD/QXdAGjk
         HT+LRJxX8dpnV4802y/stSj5q/sjmIw19G8tboC1L0sKX0P7f36892tCkxaFrRLFbvXv
         ePhw==
X-Forwarded-Encrypted: i=1; AJvYcCVPHroZjkf0T8xKKNc4ifsT1lbPoAd8URznxIJfveduA15cm1gr8g7HvoWah7Apiy9BEJtK0gKgktWsr45ELg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh8QYAgAXFdzwHU13QHJXqDtga3t99FNsE+9TX3LXchQl7E0i9
	Z2GUdlsJRNzFaH59nkDU2+XWXSaNnuEhqTA7U8WXuEIxJkfdEXN1DGQzR86RimPwzQpm+wuHlbZ
	MEp+lxQ==
X-Google-Smtp-Source: AGHT+IEpuk3JhFswrcOYHhuNZFtNFDjaC6SxgeOCtP19MsiXoVMuiAOEkn9SRzfq0mcswFVBZevjQHeWqN0=
X-Received: from pfst15.prod.google.com ([2002:aa7:8f8f:0:b0:742:aa0f:2420])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac6:b0:736:32d2:aa8e
 with SMTP id d2e1a72fcca58-742a97a16bbmr6249072b3a.6.1747436860987; Fri, 16
 May 2025 16:07:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 16 May 2025 16:07:28 -0700
In-Reply-To: <20250516230734.2564775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250516230734.2564775-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250516230734.2564775-3-seanjc@google.com>
Subject: [PATCH v2 2/8] irqbypass: Drop superfluous might_sleep() annotations
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

Drop superfluous might_sleep() annotations from irqbypass, mutex_lock()
provides all of the necessary tracking.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/lib/irqbypass.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
index 080c706f3b01..28a4d933569a 100644
--- a/virt/lib/irqbypass.c
+++ b/virt/lib/irqbypass.c
@@ -90,8 +90,6 @@ int irq_bypass_register_producer(struct irq_bypass_producer *producer)
 	if (!producer->token)
 		return -EINVAL;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -136,8 +134,6 @@ void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
 	if (!producer->token)
 		return;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &producers, node) {
@@ -176,8 +172,6 @@ int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
 	    !consumer->add_producer || !consumer->del_producer)
 		return -EINVAL;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
@@ -222,8 +216,6 @@ void irq_bypass_unregister_consumer(struct irq_bypass_consumer *consumer)
 	if (!consumer->token)
 		return;
 
-	might_sleep();
-
 	mutex_lock(&lock);
 
 	list_for_each_entry(tmp, &consumers, node) {
-- 
2.49.0.1112.g889b7c5bd8-goog

