Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EA25DD1E
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752123; cv=none; b=aY7kvsLfV3uOteJ/0fEbsnPXtZq6rR+VelGsSJJEPoQxIuKA+866OjJyIqRjDl7p5Ca3ovypWa9YT0ozTkupUzf6pc9laXhHsI1HBzUYpn79R1OHE4z6k8JIS3GESANTEvxr9G0B3B9JItvW0oaDF2TyjBwMj4yLmcdrYft6BSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752123; c=relaxed/simple;
	bh=uI3gw1E4h1w8OZiZE65zRuvLc3js117NH0a6bu/n0Ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SY9O0zaxOHO3O0EXYynC9F7KAT2em2+dngO2e7PCdyZ58su4nRyQmLb5IlHMi/6bCoZ4/ghwdxC6ci8BpTAYwEvWI5B2790FfG3nt3GwTEVWN58jw6O46tdm9Yhxt3Kc+GDFwBEs1TV5SYQRuoqKfABizCAQKOfQGdptPQA3kPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQO1vxfj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQO1vxfj"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2217a4bfcc7so38877375ad.3
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 06:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740752121; x=1741356921; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4n7HNs3ibqC0TSGgnmvAohC3oIZe4ftAirZaMZ4Klc=;
        b=cQO1vxfjBa/Dn7bJohq7b41nAqqS8H0pLvZrxsdOEES4DvbTyeiLeTj+4NsxU07kop
         d/Uie4LNRsBYYN6XcwHpxLlxvEsCQ3hVVZ/v2wr/9Exa3CBPucbYWA0YgASHWN7RCCO0
         zvs7RNU6gqTi7R/oVOUehHQdb7FQoFSQAqwROfbM/qHIYeQCrQQxT7afXWqm1og7gXMP
         XDZCqTAdTLS5bN3zeYCmfPO0eJmfESNk8n8qFOqH2DzYNfutCTA8lAnJO1WzMIba/veN
         4mx8UWZBt0xooLx9eOd6ceqZOH/TTJchD8+X2lQNjXUJoDMjldzY3fGUo1lJuk6OpT3z
         uY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752121; x=1741356921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4n7HNs3ibqC0TSGgnmvAohC3oIZe4ftAirZaMZ4Klc=;
        b=k8RiwyHR/D3dQlVa1MF48erEHOFklsLv0kWPppXB2f3bpu7j+OxPIRgvbYU12nS0+7
         A+t+bSoLVvXDBVppxL9P9ZwPvS31JBbaGhQdI41TAue5RfmiUPfOooMNtkMqKnUjouPD
         SYXXnPmrGRAtlyeLL3sWn8qw1wn0koyGaUv0cJYQSt3tTw+YSeBPTriHt8Y325pJLISa
         zSFfH9k9I8XH6OOk6hsLL8PTk+7JH2B07zmAhUQUfYqhdkHFamzDNrWHrGui2qdZpUZq
         djHS15ttRAP2t9bzPoqA/jbR8TiDgURjfeMGHzB2q5uKKStPCaRHpnPjC4Q3nRF40etX
         S70g==
X-Forwarded-Encrypted: i=1; AJvYcCVDCGtL/WlAt88gWfY/0uWa5hx+oUHGjnbZSjrxa+enTlx7ZrV77aHsjH4C0N9y0rNE4ya/dJl0BOvY1v383g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwT0eFQoU/NdWjboHFZlxJjfBlGFcJvPKjJ2DgcpjzIVIpfnjYl
	xdYCoLmTbddvD1o6wIijDyTpvu4KDwDaUq1Lk8gFJKOW06Q6uvi5ldfZI4IdCDVTpPwmWbl7odY
	lCQ==
X-Google-Smtp-Source: AGHT+IFY0wutMLV/vSJQL/rvmkdGeXbcSA+g8Izv57AkofI4AiY7LTCObNflznrkj5jSTghAERF/NgqP0cM=
X-Received: from pfbdk18.prod.google.com ([2002:a05:6a00:4892:b0:730:7e2d:df66])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e88:b0:732:6222:9edf
 with SMTP id d2e1a72fcca58-734ac3311a7mr5471270b3a.5.1740752121585; Fri, 28
 Feb 2025 06:15:21 -0800 (PST)
Date: Fri, 28 Feb 2025 06:15:20 -0800
In-Reply-To: <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227230631.303431-1-kbusch@meta.com> <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
Message-ID: <Z8HE-Ou-_9dTlGqf@google.com>
Subject: Re: [PATCHv3 0/2]
From: Sean Christopherson <seanjc@google.com>
To: Lei Yang <leiyang@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org, netdev@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 28, 2025, Lei Yang wrote:
> Hi Keith
> 
> V3 introduced a new bug, the following error messages from qemu output
> after applying this patch to boot up a guest.

Doh, my bug.  Not yet tested, but this should fix things.  Assuming it does, I'll
post a v3 so I can add my SoB.

diff --git a/include/linux/call_once.h b/include/linux/call_once.h
index ddcfd91493ea..b053f4701c94 100644
--- a/include/linux/call_once.h
+++ b/include/linux/call_once.h
@@ -35,10 +35,12 @@ static inline int call_once(struct once *once, int (*cb)(struct once *))
                return 0;
 
         guard(mutex)(&once->lock);
-        WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
-        if (atomic_read(&once->state) != ONCE_NOT_STARTED)
+        if (WARN_ON(atomic_read(&once->state) == ONCE_RUNNING))
                 return -EINVAL;
 
+        if (atomic_read(&once->state) == ONCE_COMPLETED)
+                return 0;
+
         atomic_set(&once->state, ONCE_RUNNING);
        r = cb(once);
        if (r)
