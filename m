Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E853DE420
	for <virtualization@lists.linux.dev>; Mon,  4 May 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906454; cv=none; b=PFmDnAAum4WvXgDpXKuGy5a4OpR0QRGL116MrtBoJbgfvVz68CDDEgC/6G9Mz8CEzk8YT7iFAfl7yVAuHVbKgCYSgok1Y7pg+V2Rus3ElGGIjYdL5LcDZ+3XcFliUkFbPf0JEwHnSkENwb3+Ycwa3KUulJo9HzanzLCLAWJqbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906454; c=relaxed/simple;
	bh=6wZYZofD5XBH7p3dPRhe98oA4McZcgeESmYvHekXAmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QezAEqC4UkjPo7Kx1pew/4ii7HwO5RXgGQZbwUlbe3bcDn76+wmzRsH+pcIYWc+UnflFKjOw3Z1ixeZ7gau4h2Ajz8ezcnHUK1rw5sAUQBTqRiYENpmCO9RHKxqO0s0vA+JVYK0HPIM48zMBcoYEs44d5vB2KZq+SXAJnWG/87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbsB2+ee; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbsB2+ee"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2b9705613ddso24431715ad.1
        for <virtualization@lists.linux.dev>; Mon, 04 May 2026 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777906452; x=1778511252; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsUMHAzB3E1Lhy1w/m7z6HnCWQkTFKvmq9eCCZpqQi4=;
        b=sbsB2+eepOrxsPgEIT3xfT1w7ezGtC7J9QcpqVzVysDgb6gECkQ8mYOvRAVj41Otvz
         chEaOqHvGcwxaqLpTjyEu3td6FuQYFUwxIabm7VYZ0MUhplCXHpTm7gDQF+vGO/uTq79
         BWloknFxx1z2sSowDKefvuSesfmnhA2AHWzAcGPP0Yqrrl7FtOX0PubgsJFWY1wa4UFw
         7m0WhfWzgOSh1JeQSTKC9bIFYV5sYaxwb/DeMRv7F8PDrixoKnT+X5jysDtlskjfVeLx
         vWpQDDf+CQJyFnaOO3YI8oCaxPa0oPF8nH6DopWNnE1rAdTrP/GdU2/Qjh/85AB8DpMC
         swvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906452; x=1778511252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsUMHAzB3E1Lhy1w/m7z6HnCWQkTFKvmq9eCCZpqQi4=;
        b=RR91LVkr1+Y8E1PxZwh8gFwALylO+/uzFD4DzXCq3Aixoj+YW2MovEprXNPVKg1uYm
         6d2qdEKBuNQBeZ+NnZD+6LyPd9H6Rota0wGTKhPgwlWcIgLKZ0Hqg17esZptiaio78rp
         y2eyZFZpKME+egyhW9xVgRLnQyz/5JRmXAjkWU99IXf+3rkeJgVeWPrNZ4XgfCjV3lcF
         xqMwkzDZfKyng6xGdNZnTLIYISTXQI1joVE/IKbzvIfkRTNcuUFek75iHpq6rMkIhdnH
         psmO01VCMbCG8R39mtR5kPL7fr/Mrao0xizl5RTWQGSIXZXo1lgfiXF11CNcYo6G0ho5
         Ahxg==
X-Forwarded-Encrypted: i=1; AFNElJ8XZvLRzD9D/DIvbtELNSGIXoXBV0Y0PivYA8alds5r9gmv2eAmcpiEu/tVCv9SJ8fibsvhQqQ3mmWXmvdUeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK7etKJ6NywJkMOR3YlYjdKl9f0qyHUQdZvRK81JPMunopxsAi
	GC54pbCjG2X/gxIuZAw7g0SRL0dILNo+Yzxzk9f6ZaMCBTUJJZ7x4Jnt
X-Gm-Gg: AeBDiev9ARk1NPzFfbgcEc13yjBhsllQkCLFAWszMe1r4K5kiBpouMIQsZxG12bawig
	aBdgQ6QCEnFfn0KJxWVG/G9Zo0O2GyqY4iEUZeeYzivshZ3oSdaq6m6aUnilfOXDlDwU3sdxV29
	lfNBHrCM36ytldTXtITNJnvmsDkiTZCYwuWqjbFgMeR7lyAdnNaAc4589XzVu1mcQAlsjpdjoBh
	Egh2rfGUGeYqpoZx/YBNK1fLq+VbbaU2wcElOCRDvgHrQX07GgAQazCisEv6hh8MZxrIZksCnrf
	OZLn3w6/8HWUEzfs52D/Uz4JFJPBQKSr0dsBoqSBRea8bDHzu1bzABz6cdko9IYY2R4o4Wt6F8X
	MKrKbtWNps7N87cqvEIAW7PaCre1+SYBuvmf0XLhg/pIokQA/FOM8TlJ8+toyt/ACRUaFRaQALE
	uuTQd7eCET7XRPfHJHDmlYTAvhv24=
X-Received: by 2002:a17:903:4b4b:b0:2b7:88d8:efde with SMTP id d9443c01a7336-2b9f256dcf1mr95395225ad.7.1777906452391;
        Mon, 04 May 2026 07:54:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae4a127sm142842165ad.67.2026.05.04.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:54:11 -0700 (PDT)
Date: Mon, 4 May 2026 07:54:11 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 1/3] netlink: convert to getsockopt_iter
Message-ID: <afizBv-egs3PPbTE@devvm7509.cco0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-1-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-1-810ce23ea70e@debian.org>

On 05/01, Breno Leitao wrote:
> Convert AF_NETLINK's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> - For NETLINK_LIST_MEMBERSHIPS: walk the groups bitmap and emit each
>   u32 sequentially via copy_to_iter(), then set opt->optlen to the
>   total size required (ALIGN(BITS_TO_BYTES(ngroups), sizeof(u32))).
>   The wrapper writes opt->optlen back to userspace even on partial
>   failure, preserving the existing API that lets userspace discover
>   the needed allocation size.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
