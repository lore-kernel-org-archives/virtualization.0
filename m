Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362F2417D9
	for <virtualization@lists.linux.dev>; Sat, 14 Feb 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093130; cv=none; b=etiKUVOLwnHz+KCMsockyzsttKMk7EqXeA8bk52O28WDNHFLYlP6ISzVRVR0V3yRZtICxIaiq9GtIGXmgjqZgO6EBetuhN+KYkkVrcTo0ie4sEusSxKDQqp9tXUz1aRIXIlEMoGYwFUT9kNkUQHwX4KN4OFzZwFjttqUGaW0e9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093130; c=relaxed/simple;
	bh=yEelQuIDmS5A4nF6l+/HEJSY7JzkT8eOu+50RPHRcm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L6jHq6k4hmjfsFHeZhrAKS5f3TEdo9F1eHC3KYHJJ2BjtlKjOJ2Q+7pLC8570CMLHPM5AOlechWVpv07ugArKguEL+yJzH8pp2UdEGHDAzCL4VL3uPx0M2kFyZIrM9HnRyv5sAVz7HxYyxvY3sYFNYcKoGORxrOw0bftXd1xJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vo9DZrym; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vo9DZrym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771093127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hGvEkNLWiFwc7xvXmNfeTPVLJWvbXxlHncgYSGzv/5o=;
	b=Vo9DZrymcApH6zTFCb14CAigQ435Eu7rpwULe8eBeZhvuXMc1dK/jpQ2bJEdCqqm3IMxJF
	0IN05htTHQ+lG5e5FME4DIr8qQoWvRRjvvwNw6N89rGqxpAmygASWZHAKWXVKvUOTs9SvQ
	f1nxi9i5d/Db0XLMgjE59KKsOrgpM6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-bqFETXCGP7iQfs-lmkIkTw-1; Sat, 14 Feb 2026 13:18:46 -0500
X-MC-Unique: bqFETXCGP7iQfs-lmkIkTw-1
X-Mimecast-MFC-AGG-ID: bqFETXCGP7iQfs-lmkIkTw_1771093125
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48372facfedso16317715e9.0
        for <virtualization@lists.linux.dev>; Sat, 14 Feb 2026 10:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093125; x=1771697925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGvEkNLWiFwc7xvXmNfeTPVLJWvbXxlHncgYSGzv/5o=;
        b=A99o4NBZ/iWBNoDL1903l2BH5za5Q/VYJdKBChgq7FLN5Li64ng+NtNOMG8npnUK9f
         tnvO6dxorPCqPrzflW3LlmNCTUbtcLVm3QWkClZfSyDTsvqAHLwjGgc5OEjzQ+TUA/7w
         6J1Cr7npCNGXqG+6B88NHzDujat6fF/9P4WjlTiRnKdtDrJQSWy1P70GNLj9nsXNlOVk
         YakDlADbKPlDDEeLFUnNtuiGdgWO4fiIofUjll7dPTt27WNiowOLlwA+jU3L5zBtOaoc
         GMtbTTbPy8fLi50XuUm6uNVofB2DQVEX9paM5WEccUJWkM5ieIsxWfz7GXsj3QE0hPQE
         V6VA==
X-Forwarded-Encrypted: i=1; AJvYcCVG/QtWoZhG7tDZjfIYfr8PjyXHFHbuyJmRl75z/yF3tBxY6AcpD4LRUhPbEAyoROiV8wGLVXgTiQ+eA91cEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFeJCn9+KigeKb7o3rgiCmWvHcCiFnsIXPWPuaScjZCottuJuG
	nN+CC+GMJxaCb4FfWH3fNBVIV7k0S3456CSzz1KQ1oYkKs+wJ+JP7VgbP24dNjZ16xOVJ15VnZP
	kx2hRmibq/7LDnpoZ2mPeMgDM4KxgaB7BsYCwQA9Cu+8t7LQmzlaIHVuNldUc8DLkwmuw
X-Gm-Gg: AZuq6aJq9CHlrdUClqTb8ltY1YMkCdI782FkxF5ZJOGG280/fl8rSaxuiM7It51HFmy
	vrDFoZ8FfLuFrNCJFLC1xc26Qq8GbBr9eCgrljz28JQLhVJ8QWHH+zfwB+5sTPRPRA3VINvTu0V
	ubVFOCaNRCNtOUh0SjuqovuaplUhXWJz2pjSERt2j/cbT409EjEq23TOKlVnbdHyx99WbDXsjxU
	oplFHT9OQdhFq+XkMNJRNiQpbSKo0JSb74Y2ez1EhrBx4Ju8GgCfVt1PmleOZRQCsXeHBCLWHjA
	EE1uhlwKeja/zQ9C6UzlGQePd+HFrWrOuqDxSQtux2Wdhi+B04mTTHf1jrwQJQAdDJl4nKg/XG3
	/VCtrQlkN/KxWY/NRTw==
X-Received: by 2002:a05:600c:40c4:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-48378f062b0mr48481465e9.4.1771093125065;
        Sat, 14 Feb 2026 10:18:45 -0800 (PST)
X-Received: by 2002:a05:600c:40c4:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-48378f062b0mr48481055e9.4.1771093124647;
        Sat, 14 Feb 2026 10:18:44 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm65320555e9.10.2026.02.14.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:18:44 -0800 (PST)
Date: Sat, 14 Feb 2026 13:18:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260214131703-mutt-send-email-mst@kernel.org>
References: <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
 <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de>
 <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
 <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de>
 <CACGkMEveEXky_rTrvRrfi7qix12GG91GfyqnwB6Tu-dnjqAm9A@mail.gmail.com>
 <0c776172-2f02-47fc-babf-2871adca42cb@tu-dortmund.de>
 <CACGkMEte=LwvkxPh-tesJHLVYQV1YZF4is1Yamokhkzaf5GOWw@mail.gmail.com>
 <205aa139-975d-4092-aa04-a2c570ae43a6@tu-dortmund.de>
 <CACGkMEtRikexX=cJz8zmuvW7mcO7uCFdG7AoHQLOezrsb5nbgQ@mail.gmail.com>
 <59529fd2-2a08-4a89-a853-27198b76f842@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <59529fd2-2a08-4a89-a853-27198b76f842@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lnbkXNzmJ4ldimTA6seNvzkm9_Af1pZGSN6-5g3uprU_1771093125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 14, 2026 at 06:13:14PM +0100, Simon Schippers wrote:

...

> Patched: Waking on __ptr_ring_produce_created_space() is too early. The
>          stop/wake cycle occurs too frequently which slows down
>          performance as can be seen for TAP.
> 
> Wake on empty variant: Waking on __ptr_ring_empty() is (slightly) too
>                        late. The consumer starves because the producer
>                        first has to produce packets again. This slows
>                        down performance aswell as can be seen for TAP
> 		       and TAP+vhost-net (both down ~30-40Kpps).
> 
> I think something inbetween should be used.
> The wake should be done as late as possible to have as few
> NET_TX_SOFTIRQs as possible but early enough that there are still
> consumable packets remaining to not starve the consumer.
> 
> However, I can not think of a proper way to implement this right now.
> 
> Thanks!

What is the difficulty?

Your patches check __ptr_ring_consume_created_space(..., 1).

How about __ptr_ring_consume_created_space(..., 8) then? 16?

-- 
MST

