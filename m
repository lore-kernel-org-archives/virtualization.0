Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06835E1BD
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613378; cv=none; b=uGhAiq76psZZVkrbixSSioln1+Y5GvqQazFKdZep0EpMr9WJVdf6fToLPKUc6REwhtUORjd7vu0I2YcGnXKeB+SdZ+/tnfFdKyhhddk015uql8rbVpFTXrhr2GZcYu6etB4ABf5QlWtmXqpxDL3Fo1xoOsPRRuLIn4HWPN7bNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613378; c=relaxed/simple;
	bh=We5ZGXz91oTGJ0dJSujyq11OFk6rNuSPRZXQZ0H5xKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WGohabkwsnEsJflzaoEBwPQ176D8/rhExyRqQIZT4/CaaFvOP1fOMGgw3XkNA9Uhu8Em6vH/xvYOgxyLslhFasxkMhm74+OwMedCSfP9Z2Rk7NyLmgHfcMzRAom0D2CJ6qaRlr9mba6/gKHO/5jHQkYafqaQVtacpUSFUy7ayZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfJoj4dQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfJoj4dQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781613376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
	b=SfJoj4dQYvwISAdUPm3V4wMsLDeIU21Ib/9hBr3ffmiVJLGxG4OuMewjf2G0/IFDWagiIC
	hWrOp0rDeyi8zXdb/uP8GL5fAFXNinrz8IcMyb6Sijh7KAR2LjsdIzqL7pMAGl26IPJ/nX
	QlnD1nHDQ1ylUXB8BcyHoFgpDWeEOSA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-BbN5oZdWMdOI2Q-ewTlNuA-1; Tue, 16 Jun 2026 08:36:14 -0400
X-MC-Unique: BbN5oZdWMdOI2Q-ewTlNuA-1
X-Mimecast-MFC-AGG-ID: BbN5oZdWMdOI2Q-ewTlNuA_1781613374
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490c840efe6so48145445e9.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 05:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613374; x=1782218174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
        b=Z2BOw1+vQQQtqowvVTqbP7mMeqv0EfydM9amk3ZDa5/uDaZq2Mskfs9BpOeI1nFyl7
         /gMk9VF8G7uRwQzfZhYEyCSK+BBKrZmq1++yVMGGiEFHWCc5m+qnjU+3lRvrF7BfNaGL
         qxYTpCTy0KKOVtbFVrqXwADzQ3aqeE/38wadrEpBD2oxLkHSQ7Tk50dJ2gBIWqnsEN5T
         5hO+0+a4AbWAKrZntA5O4GKQHTn+k8mEuUd6/RX+RVRqbHHI2QlxEghCdN8VLP5kmAIV
         KXIx170zhQeLkmGUp5A0SmB5MZjmcRHUFbSNCPc3qzhJ3O70XBY9EHC0PhHCJHs6WxeP
         2zPg==
X-Forwarded-Encrypted: i=1; AFNElJ+zHgXHk5q95o8jM7t9HyY1b/u4K98kSJECbKNxtMDPjPlU0x7WKy1zOuNadt+pyAzmD+ricn0aloUFTJ2UNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGkc9vsCGILMiyT0B7pfvSPXhYFMNDBk+/fO6aIdV3lxRNuv8P
	qL+OawkT8O0ow8GnAf6meOBToEdwMG9bTaBK6qcL3VGJbN52FwCZrqkv3oRzcJIvbqi8G42LJka
	uzA9iSdWC5YoCG2vkok+D8ApXCS2+eZFAcKvkwfvy5oJLdolJCSopJAqjX0cdPFpD9Hy1
X-Gm-Gg: Acq92OEip5I0dnlCa4s7LaPweWlDhYTNctRZ2pTdkhRL8Ox1Jq/n7Ub3GZN6rZhoEUr
	SmzM8LArcsCUBAbhzdjt6eew5WVoaBJfU/kX4vrx4tNdwdCM89iEYRN763u/sdAglmgEzD6XCXE
	TP/T/91HssC2cMGHDncKu+CEmkAmEOmEhELgdMf5krJlvA0D7IVrD9dFYr6AaBoHMfXZ3vPqZg+
	Kc6ptvL08bsv5BMx2uADbsTlm5gvFTJ0Pw9ooNlA+vCtWkd5DH5uFB5OBfDsCDahGePeG5mbvP3
	IsAOJuMAIxSgKfHL7sLAk9uW8IP+w8JsrYff/yWa3oyIlEIA/u8MKA8vqpktwe+p7qbfi1UHjg/
	WRCajMVw/0EE7tn8uS1/voRe15PrjNKqdC7+8Rc4GZQYLCJLGyVcPzyx1ObyIBWCGgEFsZSE=
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52203405e9.3.1781613370891;
        Tue, 16 Jun 2026 05:36:10 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52200315e9.3.1781613368029;
        Tue, 16 Jun 2026 05:36:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ec56sm53027215e9.9.2026.06.16.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:36:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:35:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
Message-ID: <ajFDIHuKC31pumnY@sgarzare-redhat>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-2-tavip@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260613000953.467473-2-tavip@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uFRPG7BJmY4Sf6X25s_8q087aOUKJG8Qp7RvnDRiM6Q_1781613374
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Jun 13, 2026 at 12:09:52AM +0000, Octavian Purdila wrote:
>Export iov_iter_restore so that it can be used by modules.
>
>This is needed by the virtio vsock transport (which can be built as a
>module) to restore the msg_iter state when transmission fails.
>
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> lib/iov_iter.c | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>index 243662af1af73..067e745f9ef53 100644
>--- a/lib/iov_iter.c
>+++ b/lib/iov_iter.c
>@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
> 		i->__iov -= state->nr_segs - i->nr_segs;
> 	i->nr_segs = state->nr_segs;
> }
>+EXPORT_SYMBOL(iov_iter_restore);
>
> /*
>  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
>-- 
>2.54.0.1136.gdb2ca164c4-goog
>

