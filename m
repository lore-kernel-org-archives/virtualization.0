Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886F7A211
	for <virtualization@lists.linux.dev>; Thu, 21 Dec 2023 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VMmAT+jh"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9a541b720aso1767206276.0
        for <virtualization@lists.linux.dev>; Thu, 21 Dec 2023 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703201025; x=1703805825; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cU9mOyLPoF6ZxNM7jnDLVtHU9dKeo3lsrx7E6D/L6sI=;
        b=VMmAT+jhdxHUcx5gXB3FGPIsGTXqa9OXEVWyVnVE9YJ8LQTOVOFdhT1Fst5TLtsNqI
         UKauTzRQXc7ktVee3XazZSWZHtAe9D7sNFROpK1UuThQTEPCX7jv6uQtDuXANKPgxJMx
         tPnFHuWZjOAiGq66SYBX7Vj2dRDvR5GoS9zIXoGOwuUZ4sRB/U/hLLp8bzyNtTsMFsnJ
         ID+5FS20h0f1r5Xw89m5VyLkTJ9pgQ2naisKcr1SfhlKx4qjFWT+YxVVRYnbCfHBMZ/v
         dgWJ06Weikd9jhADy1DyZbTbXYLwmY7Lzv+8s16w9ZaV23Zu/EaYEmVBa9A1AxN+2KbN
         V19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201025; x=1703805825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cU9mOyLPoF6ZxNM7jnDLVtHU9dKeo3lsrx7E6D/L6sI=;
        b=Mv3b6riFWiL4LX575wwkTqGdWbFkeLX26FksQ1DG5PmoL+scHmnLOEhYoP03JGGW48
         ff9SEVLN1sMiTK8BN47/sIyilybq8Uuv+WoyFNp2Zx83YwkTxvn+LMcBUnutTP5MUYsZ
         GTIc+gRVA3RDeEVIUmANQZ+lbT8evI4Ha3YU61UcID+n2OmWDOFUNJHgLNZcGaDOIihf
         acaca/bfp2ilAFTxwgg07AgEVXRCaQCRcwFmV0Be60p783MUncGammiGvwduV5Hoc0hr
         M/LThOZqSqkMPg9YD9VJLwV7RCRs60NhZCHy3oCK3KVPLpFpJrLgL2U+MBsD2WpE80r3
         V6Uw==
X-Gm-Message-State: AOJu0YzhQFRrS1464tA5G1av3y/ubgw/k/wsMlOZ8VmDVxFMTTdZEyzE
	B/UYKglbtqbmYhRfr8iRMxudgL8rHENDcOzVl4Rt
X-Google-Smtp-Source: AGHT+IHWiT1s/e6el8Gbfa2jmdYfbMdaJTd+pS4T1tXJHPKsVM+5WAmrvhPrUoUOQ5Wk4tJyK70wKIQ5Qx+mgg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:bcc2:0:b0:db5:47c1:e82d with SMTP id
 l2-20020a25bcc2000000b00db547c1e82dmr189052ybm.6.1703201025720; Thu, 21 Dec
 2023 15:23:45 -0800 (PST)
Date: Thu, 21 Dec 2023 23:23:43 +0000
In-Reply-To: <20231220214505.2303297-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com> <20231220214505.2303297-3-almasrymina@google.com>
Message-ID: <20231221232343.qogdsoavt7z45dfc@google.com>
Subject: Re: [PATCH net-next v3 2/3] net: introduce abstraction for network memory
From: Shakeel Butt <shakeelb@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 20, 2023 at 01:45:01PM -0800, Mina Almasry wrote:
> Add the netmem_ref type, an abstraction for network memory.
> 
> To add support for new memory types to the net stack, we must first
> abstract the current memory type. Currently parts of the net stack
> use struct page directly:
> 
> - page_pool
> - drivers
> - skb_frag_t
> 
> Originally the plan was to reuse struct page* for the new memory types,
> and to set the LSB on the page* to indicate it's not really a page.
> However, for compiler type checking we need to introduce a new type.
> 
> netmem_ref is introduced to abstract the underlying memory type. Currently
> it's a no-op abstraction that is always a struct page underneath. In
> parallel there is an undergoing effort to add support for devmem to the
> net stack:
> 
> https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.com/
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v3:
> 
> - Modify struct netmem from a union of struct page + new types to an opaque
>   netmem_ref type.  I went with:
> 
>   +typedef void *__bitwise netmem_ref;
> 
>   rather than this that Jakub recommended:
> 
>   +typedef unsigned long __bitwise netmem_ref;
> 
>   Because with the latter the compiler issues warnings to cast NULL to
>   netmem_ref. I hope that's ok.
> 

Can you share what the warning was? You might just need __force
attribute. However you might need this __force a lot. I wonder if you
can just follow struct encoded_page example verbatim here.

