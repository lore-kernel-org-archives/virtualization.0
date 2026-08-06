Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F63B71A9
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024396; cv=none; b=Tzi73QF097XvUd1RoGgafk/jnhzQoThPSdUDqqkcjyfYP/jpAYqyePuV0cAFUlndHpLtcJ2hHL2XrFE2TTbE8628bui7OPTCPfUxtK2KdE2J/8Qk1pvHG2nj6ALuxfcfguzpcGogmSjvnbrmVjBJ0hUqls0zMauuyH4YN8zeglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024396; c=relaxed/simple;
	bh=m2qiwyT0gBlgrPaEvfZGXkwH8PZ+oMXWE+y7LnPQMIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l8J7k/Mk5IQhcKp4DaBL+JFVcbhk23brbE+cS67KFQNPMpa5RCtoKDZkPEuYAW/IxLmI4c+jboopCpIFb6mCmdUwMp9A+5cT4+ZYbwRg/aR8pT6L/kygv/g/AIpploGG+2e89RaRXrcsiLKIF32u088nYuJ2qQ4lSXyA/Z5BaDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exyXNusX; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exyXNusX"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so42085915ad.2
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786024394; x=1786629194; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KurGLp5j0TRPb0GM1o+RkfUsTRyZPXyOf0pcclYokSw=;
        b=exyXNusXl4rpHy2ZIb5zH87q5H243N3Y5FfNAiUregsNWqsE5zU5Tx/dtnCF+JmaT1
         S5qYFLF9q/xV+Dnq31W/rA26HkH5PadIoDQqwVHJARd7Nl3Qws+ZrQSJWwhakwG2MBZm
         ebVNGPRScdXfnB+IzrgX2GynRQHCZdvLjOyeNV9rVM/iMdcVj8n5/x/WrRizBTmTgylQ
         2VnKSwX8HQJ5wk/ZhwDqjuXuhzM1TNo7lAXEp8k2Ftgmqft/xEEvuy0lCd6ZH0xolU5V
         T7BT+CkCx0Rzk492mQbIskcOqcI2bt+qTv9SJC2JN/H8sihDekOAuJXzvkATvd7JtzVB
         55ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024394; x=1786629194;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KurGLp5j0TRPb0GM1o+RkfUsTRyZPXyOf0pcclYokSw=;
        b=BU5ZAUMIprsK72P+pABl4h8UOjtEJ9heupSTZiXMcC/GRfRDS3GNzsReL8fPO/niUO
         w9gZsWHGlwZzToHYdKj126+vDH6CL+/AfFow701gIJpdBBGEzGUhXvlYRho+T1av3eQq
         3UycGYD3wCiu/vxnoLwdkuhtaauxzfeVnlv4cgC2MLU5IIsavGz3xkVFz6WysWsdx94S
         2ix6oXjA78LCsjuqHJdzCo/w6QnEviAjCpXnNkWz2ygrZ1ym/ZJzusjmNbxe0Ah+D9Uk
         7KA1Ii6SW9Zz9VxeDotGTJVixCczIJcAzbJ/jAdVaTHXAxUwgJL/iP0UjxAvFVMPytyV
         uFSg==
X-Forwarded-Encrypted: i=1; AHgh+RpobJDGcxp4IDAj4iPUZUMgau4YocPIZEhph3h7MNZc0cZqtB1d/uWd/nZyqDSPu26a9T9Ny/xXJqtXldQz1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO044tcg7R/KpbPeazvvkL5Pmrv+6kGWBcsLsGl+QMD/AGgxo5
	NEQaL/ttRJjtBqWIQgW0Zj0wwAWoWwYPofP9A3AhynT3C1ypSwNgIOtan9C+y2vDk7D7i/YXIE+
	emolHAg==
X-Received: from plao6.prod.google.com ([2002:a17:903:3006:b0:2ca:da0a:7296])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc5:b0:2cf:906c:7d1
 with SMTP id d9443c01a7336-2d0ca946776mr183858535ad.20.1786024393599; Thu, 06
 Aug 2026 06:53:13 -0700 (PDT)
Date: Thu, 6 Aug 2026 06:53:12 -0700
In-Reply-To: <anSMBpQJ8x-vXYy2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com> <anSMBpQJ8x-vXYy2@sgarzare-redhat>
Message-ID: <anSRyFTNGC-XcFM1@google.com>
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing workers
From: Sean Christopherson <seanjc@google.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	mst@redhat.com, stefanha@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 06, 2026, Stefano Garzarella wrote:
> On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
> > The effect is harmless in practice, as this only happens while the
> > owning process (and thus the whole device) is dying, but the lockless
> > write is inconsistent with the rest of the code.  Clear vq->worker under
> > vq->mutex, like everyone else, so that all writers of vq->worker follow
> > the same locking rule.
> > 
> > This issue was found by Sashiko AI review.
> 
> Can you share a link to the review?
> 
> I don't know if it's common or not, but having the link in the commit or
> after --- will help the reviewers.

+1.  FWIW, I've been using and encouraging the "standard" Reported-by+Closes, e.g.

    Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
    Closes: https://lore.kernel.org/all/20260625212001.3B6561F000E9@smtp.kernel.org
