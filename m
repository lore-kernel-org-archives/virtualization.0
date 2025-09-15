Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173621ADA4
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970184; cv=none; b=sVGpUwYmEU0xtuSB2mA7uzGXg9XRSHSH/n7Hr/Ty0tGH4lrmmEzSMR6UvatZYMJ9yfV796yPyHJpxRlo6kuQu6EQP9X5jMH3GlayxzFVISB56LVONIQWXO9LNvwXDkgJlhMRO8dvFXeM3T484tucWzFNphwW3jybj4lxyVQd1lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970184; c=relaxed/simple;
	bh=fTSNHZAQcFYsYv6n1G4GxZktpGJ8qsXioj7qp8jjd+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FBUM7+TtU5CDdpP1BG4PXd9yBFxY5mUaKGrwpyey8bLE5MRiYdABFMhhenGYfAu+pHuQrkdHG6wFhRkOvCerMXAZzt+E3dojSMEwO79rVM8OX+cUWo3wBlTO28xATNB/A/O1JpK/0c7JrPZqPsSV9HxOx2muVia1HLwvdAXfAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ygPkWgRS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ygPkWgRS"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so7303068b3a.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757970182; x=1758574982; darn=lists.linux.dev;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxwTdZBEmt4jtUv/E6BNSirMqJUJGOYRGh1YXveb5WM=;
        b=ygPkWgRSPXH+kg2hvG/tbgMXqwWhjW6Y7BnJHKAVAEBp1jk4cHwdfG30+N//70XfLY
         EbtShixmzdoYrPe5hyutot1jrpLBLlw+3pmsXr2BNnIoceFq1cR1PN+/IUw5xOx3nd2l
         Hm2td/hx4zHCEVPjzrOSw/3d0oVBqocdp0+/fos0l0nEdLInUd+Uebtb5biJnKvfIipT
         82yRcFg8aeM/wT/vt37Vvhy+gOI21ACmQRiZYzRnM/pLlfyhkStt47ugfPQFBF9/mhop
         5x3a/KbSTpKk3AjnB3AZZQKwiRdiy21xr7+CHo1iCqaYDi4GxXgLoQP7S76zK29WkJcO
         8+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757970182; x=1758574982;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxwTdZBEmt4jtUv/E6BNSirMqJUJGOYRGh1YXveb5WM=;
        b=leEirDUyk7cbrUCx9EzJgdHgzziK8LNU2uNgkNLchZ+nYs9NR0pgP45gffLqZm5WPl
         tmRUo9J7/euDDXiFTXerz34QV0krN0OjVTsTCt6k/0F+njIiT9GMap4CPvJ/qgd4jagl
         F/Vl5YQnpit/I8rwFgU3l2HHXy2JmZblk2nMN0xoN8UgKBzw+up3GxFN3c0TTF1enc16
         RgRY1s/GhUGQPqffoSkBLX2HmrFPtKflry5i/a/ehlRRoPVciq/BMvPKMD/A02aNCCy4
         5AEbPMA9aIWXqLIdisaRyg7zMq5M2OqyCNPnv9+tmkpXwD+ZkilmlBQDE+1CJLAWAe4z
         4I+g==
X-Forwarded-Encrypted: i=1; AJvYcCUGHmLuWJpfnznRDbRKXrgOBBYP8U++XfTTKZD/GCo6NbHS/bmSPLzQ7gi3fvpaBiiu7gTOGq4ZuLawdRUtZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpOwBQUWrRf6rc4ef0G9i1BaF3L0lc+8HVKWFR5NthT8iBPn3e
	fXY0L77nYB0EwPXGfTD9+FsnAiLzRltQL7PCIfLjYphIaEha5OWXkVLfb2XIvZXeQ/sbAY5frw8
	xSl7jnA==
X-Google-Smtp-Source: AGHT+IFuSpiuKJG6P8l3wSHwKGYEnnc3OxEX+l/ch1UwznTqKr0gm4ilazi12JKz5vJTRzZBy222Qo02Nhs=
X-Received: from pjbnw4.prod.google.com ([2002:a17:90b:2544:b0:32b:65c6:661a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734c:b0:24e:c235:d80d
 with SMTP id adf61e73a8af0-2602c14454amr18045793637.49.1757970181895; Mon, 15
 Sep 2025 14:03:01 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:03:00 -0700
In-Reply-To: <20250827194107.4142164-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com>
Message-ID: <aMh_BCLJqVKe-w7-@google.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 27, 2025, Sean Christopherson wrote:
> Michael,
> 
> Do you want to take this through the vhost tree?  It technically fixes a KVM
> bug, but this obviously touches far more vhost code than KVM code, and the
> patch that needs to go into 6.17 doesn't touch KVM at all.

Can this be squeezed into 6.17?  I know it's very late in the cycle, and that the
KVM bug is pre-existing, but the increased impact of the bug is new in 6.17 and I
don't want 6.17 to release without a fix.
