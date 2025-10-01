Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264F322A4FE
	for <virtualization@lists.linux.dev>; Wed,  1 Oct 2025 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317728; cv=none; b=OMOkk3ZP+JT9RirIwc6lQLrxB2z2Z9PEBvw9nYOQJH3WsREiMBIGyEKa/oQKjh2VHsAidc1Jld1ERKBRZXiWYUMJISOkrRDLbobIUbKcJgYrqa7RER4YdVDw/y6xvxmdA+Uyv3q9CQXzBG+ljTCoDFMMZNR0RsveJxLkkuQ5x8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317728; c=relaxed/simple;
	bh=MHUSi4P/U4csGmhflVuOc3gtRv4O4p5QklistO68IOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GdcVOoSkw4SO3ODbGkQ1aEhNTbuKs/U1oX3e6MmdVRztacFHqLA7NcnlYAtNxpG8252J6nOKxXqYzFXKoHh4iDdjiXlZfrDQsKJvWbi94zA9xYE8naxky5hm133ZUNrYHLbYaew3vm9OtANor0XSEm3pP9xH1yerYAfewXQRogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXdYR8BM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXdYR8BM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759317726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ql3BeV8zLppnm7zJzsQP4NuOCJwg+ayk79UQ80gXYqg=;
	b=iXdYR8BMmDBxquLWQGAE/DAvT49wRvs8MiQqLoQ0z1aWy3r4p3iPN5no0t4a28QdFSCTZI
	SyCv+OXZLw5hG0bAWEihz1eFx9D1Ms4ft/4Y56EXGUT1H18zGscclT5u5kZluC0CpfYpGw
	ni5teKlvJSlIRHZIK3EXXEyGBeMjNiM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-di9r_0iAOHif5SzWcP9mfQ-1; Wed, 01 Oct 2025 07:22:05 -0400
X-MC-Unique: di9r_0iAOHif5SzWcP9mfQ-1
X-Mimecast-MFC-AGG-ID: di9r_0iAOHif5SzWcP9mfQ_1759317724
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso4657913f8f.2
        for <virtualization@lists.linux.dev>; Wed, 01 Oct 2025 04:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317724; x=1759922524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql3BeV8zLppnm7zJzsQP4NuOCJwg+ayk79UQ80gXYqg=;
        b=vVvdufJuugmclt4Y0rQOLJg1UG+rgA1VyBdZOIvTqJC2utrWHDdP0Qj3z6GMhjc11O
         jHo4dLf7B6jVXaYsg4YNxbs64cSiVrWq/s87V7tsZVp5UMQFwIdkQ5+qz/sQDOppAuSx
         IjAwwKTXM12cUkSR5IzRlV0Q4xnWexgbe4RQNnp4tKV86C8xKoxTAddL7lfy3x46CJRp
         PhEZdbIIGW6RsQl79CAG1H7D7oljklVvhvWsDvfFOnZuRMJR2HvvD7qMQc08byM1Qk+z
         7f8qmTYOz4TgbqjYX1ejDSAcD34XQddGsqjYc0IxSIVpaz8Vv+Fb0BwzBluLVwY9iM83
         7l/w==
X-Forwarded-Encrypted: i=1; AJvYcCVPFLVnrhwqTraZjXJB0o70gP0rgBtAYrbC5DGvmZ22o+PW1oAINb27OnhJSFABs9QeP8Y1yodKPMQQANScbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxy+6ZS+wjLgrHva6etsE5frQq8FidRyGk7pGbazwPpeyyqqRvJ
	ZiFuOCQZ3YaNzA4kqUoTQNGqLXoQApfD8AYiz1IkHiu0VNzWlT7dTdXPGYrs2BMmOsjCxWkH+uF
	JoYwX5B0W6Hc3C9BgUR/4QD7wJgKJ0RYzFAmVFk586vLFSgPK++Do/jpBeBOYIityYE3h
X-Gm-Gg: ASbGncsZZVOQ4G133r6p49vwUpWVOwBkZR66VCt+e6j7hwOE3bculjeH5oTFMpqAR+B
	GDER8NImU9+99f42gUmTH+ypGftBf5RhNWRaHT/5oe2+bb4qF4NB18p5KsbjRUuYSizuSnMRgs+
	s2PhcSyU3Yx63+puoVOeuwpgTS1EygOssksl5dQ+QaCgtthOkYgdn76Umv4IdaGapWyKQwV+Z9c
	rllslRzqMrYBzlxQOotXSqWRObzHVCdsZk1cTn2z1/YWB77HdMZ2xa45bAI0cswEzhx7UnRVO6/
	ZeRu6OofGGBzpBi1GJo2EYAqiXDiXnJzMKH3Dxw=
X-Received: by 2002:a05:6000:1a8e:b0:3ec:a019:3936 with SMTP id ffacd0b85a97d-42557816dadmr2479665f8f.55.1759317723704;
        Wed, 01 Oct 2025 04:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2YMfWSirAsieLM5wvLlIAO/DtCA3N6PuMAY/Nmj+lVBGtH+Oqh6a2oWTtM5/KVZ/v7RwKwA==
X-Received: by 2002:a05:6000:1a8e:b0:3ec:a019:3936 with SMTP id ffacd0b85a97d-42557816dadmr2479627f8f.55.1759317723082;
        Wed, 01 Oct 2025 04:22:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb264sm27105223f8f.20.2025.10.01.04.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:22:02 -0700 (PDT)
Date: Wed, 1 Oct 2025 07:22:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com, jasowang@redhat.com,
	eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net] vhost: vringh: Fix copy_to_iter return value check
Message-ID: <20251001071456-mutt-send-email-mst@kernel.org>
References: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758723310.git.mst@redhat.com>
 <175893420700.108864.10199269230355246073.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <175893420700.108864.10199269230355246073.git-patchwork-notify@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZJk005YwM2ruX7kLe6GlNVdEaRpZbGM8mT1vGtnDkwM_1759317724
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 27, 2025 at 12:50:07AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Thu, 25 Sep 2025 02:04:08 -0400 you wrote:
> > The return value of copy_to_iter can't be negative, check whether the
> > copied length is equal to the requested length instead of checking for
> > negative values.
> > 
> > Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net] vhost: vringh: Fix copy_to_iter return value check
>     https://git.kernel.org/netdev/net/c/439263376c2c
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 


It's probably stable material. Does netdev still have a separate
stable process? I'm not sure I remember.

-- 
MST

