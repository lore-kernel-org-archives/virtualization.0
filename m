Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617D18A951
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380956; cv=none; b=n4gGAVzgQcV7FtzMKrf4BFWcn0NbkhBmZlyNPTDeOtIKgTy16Xe6hhfngKHNswUa6IpCTcz1p2KEDKWZ1gHMy34NgUP8nkz1vKeoMkoPsEwhuhnUbd+FUe1N0v1QQGjRQb0bLrx4SI5cAwgD+vcbLcPw5haydAV3USDyHHQ0ovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380956; c=relaxed/simple;
	bh=zYtlk+5sfQncdxRHQdTsxikt0082PiHmmUZg7TTvIvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=Bd20CDfCpNlx08v2/N1MKvUizFvuFq6fG8PhmzvL6LWX7DC7gMdV+sCWhORQBWrWbesNYKsZcrjHx5GYdEJm3ixWEMP4sQrOsheONxrFszxAUQQ/fCP/LD2aDbSHrPZjIk/26LbzHuskFEkLNdtTrLu5fn5WC+dmra7cZLHvY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UV3Bw0Mb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UV3Bw0Mb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725380953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zrnaqsww4jvYqG6LWOK9qSkVY3XeoG7b3xEfRlLXIuA=;
	b=UV3Bw0MbmAC9LPCas0im6mZxBL6l2NbnV28xHp2RyU8X5JPBWz02CslFNzI0IWiTQ7ueCA
	teY80fmOwKi2h4wsViF6eXU+XSZpzqnwiQA3eoCSV5P1fdx9gpWOeQ0NqvasoJZS090VX8
	27LkVCxL7cH6t5upg0pkjL03QxTfFHY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-F-jjvYtMOXCVPGguDuviCw-1; Tue, 03 Sep 2024 12:29:12 -0400
X-MC-Unique: F-jjvYtMOXCVPGguDuviCw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ff24acb60dso51347545ad.0
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 09:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725380952; x=1725985752;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrnaqsww4jvYqG6LWOK9qSkVY3XeoG7b3xEfRlLXIuA=;
        b=Q4e3ETGxGnY7LCXksrn/RcXFsQeBx2O65H1qpQwQgSdKqiBdua6ROPJz0xueo2QtJR
         ll/0CNMnbCQF0UIBR3pHaNs5IEpMkzfbusocZtp13gefzeXdHAZhaz1J+AKrcwE3qVXT
         yLTR6b7pyMH2Rts7r6LrRqxGfRZGchUaEmDaTg/2I6SWyXux1HTzZzMMVBSRClUAyKQ6
         +NRsAqbvsNMCij/5CxZo+6M92aTk99baa0T1k/p3i8gAPyOJlUSJL3UfY6TX76YtVvrQ
         2q9vE47mbZsLX/0BxfJ9UkDW/esO4vNOXeDBOILyKHTH8BtjwX9S7/xka8vTQWeq8GOx
         lkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhX9oBGBfAwjloFPBREOpTMMrKg59aE8dITQY037P259pKMfggRRBej/X83HO0CIGfGUo93JaBb6lZP8twGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YymuSHjc6IIkmjg2LMgao0u0GgKKxV5isjD5fWDFTVLdP7hj9nG
	lcHd6I07zf3t8OJtEMh8qex8NsbMy+PoX9AsHpNo8W3ObR3+HUEvfG39yuVQPWe0pNzJQmi2fgC
	uTJWWukSGkvNdIZ8WLAFSlVMnwRij1hGgLKPpJCbKE87cldgE6n0HONLh/3aH8RYz
X-Received: by 2002:a17:902:cecc:b0:205:7b03:ec3f with SMTP id d9443c01a7336-2057b03ee0amr99540615ad.19.1725380951878;
        Tue, 03 Sep 2024 09:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFB7YsrYOLHMUBhndqah1OUkE6FYlc2YhqiVhS0lNKY7Sh/DddLuJw4Mh3nlZdjBuyYPz4vg==
X-Received: by 2002:a17:902:cecc:b0:205:7b03:ec3f with SMTP id d9443c01a7336-2057b03ee0amr99540215ad.19.1725380951200;
        Tue, 03 Sep 2024 09:29:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:179b:467b:fbc5:3354:8591])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9525d6sm550515ad.111.2024.09.03.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:29:10 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com,
	horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Date: Tue,  3 Sep 2024 13:28:50 -0300
Message-ID: <Ztc5QllkqaKZsaoN@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ZpUHEszCj16rNoGy@gmail.com>
References: <20240712115325.54175-1-leitao@debian.org> <20240714033803-mutt-send-email-mst@kernel.org> <ZpUHEszCj16rNoGy@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 15, 2024 at 04:25:06AM -0700, Breno Leitao wrote:
> Hello Michael,
> 
> On Sun, Jul 14, 2024 at 03:38:42AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jul 12, 2024 at 04:53:25AM -0700, Breno Leitao wrote:
> > > After the commit bdacf3e34945 ("net: Use nested-BH locking for
> > > napi_alloc_cache.") was merged, the following warning began to appear:
> > > 
> > > 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
> > > 
> > > 	  __warn+0x12f/0x340
> > > 	  napi_skb_cache_put+0x82/0x4b0
> > > 	  napi_skb_cache_put+0x82/0x4b0
> > > 	  report_bug+0x165/0x370
> > > 	  handle_bug+0x3d/0x80
> > > 	  exc_invalid_op+0x1a/0x50
> > > 	  asm_exc_invalid_op+0x1a/0x20
> > > 	  __free_old_xmit+0x1c8/0x510
> > > 	  napi_skb_cache_put+0x82/0x4b0
> > > 	  __free_old_xmit+0x1c8/0x510
> > > 	  __free_old_xmit+0x1c8/0x510
> > > 	  __pfx___free_old_xmit+0x10/0x10
> > > 
> > > The issue arises because virtio is assuming it's running in NAPI context
> > > even when it's not, such as in the netpoll case.
> > > 
> > > To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> > > is available. Same for virtnet_poll_cleantx(), which always assumed that
> > > it was in a NAPI context.
> > > 
> > > Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > though I'm not sure I understand the connection with bdacf3e34945.
> 
> The warning above appeared after bdacf3e34945 landed.

Hi Breno,
Thanks for fixing this!

I think the confusion is around the fact that the commit on Fixes 
(df133f3f9625) tag is different from the commit in the commit message
(bdacf3e34945).

Please help me check if the following is correct:
###
Any tree which includes df133f3f9625 ("virtio_net: bulk free tx skbs") 
should also include your patch, since it fixes stuff in there.

The fact that the warning was only made visible in 
bdacf3e34945 ("net: Use nested-BH locking for napi_alloc_cache.")
does not change the fact that it was already present before.

Also, having bdacf3e34945 is not necessary for the backport, since
it only made the bug visible.
###

Are above statements right?

It's important to make it clear since this helps the backporting process.

Thanks!
Leo

