Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C66AC0
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 01:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721005734; cv=none; b=DrREymPf4u1sd4yjd05FtEHb9INvh8CXBduMt02CopniQ4C7FSeJeikvBz5qof8bIF2swf4FuINt9CuqFGVlZA/6cms4TwrjqAFJJMuaVuXC+EaolxGWxxicJnC2KhwgGgzBabSS3woQJirxDOwbzSSaF6GI4X212aRuB2Sv+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721005734; c=relaxed/simple;
	bh=Pa5I0cVPLyu9hM+t7OcRoRA7sRLi4NugvS+t0stj8qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2Gp3H5G3wciGHvVUofDYCuxLWVWv+Cywfg6V7YR85z7eaM+PHLjek8cn4tqdnsdu+WFx1PZRFFOQMhv2mjUoSyZixYvIgB6ZGLLKHMo8X6xnGWZv8ln6SnJAPPTLHELlZvVNEpegrX8bOmKHYwH35jJ2g14Ohb6jsoER9jXfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoT3MViE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoT3MViE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721005726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFD7oUV9b+eqssJJfa29SNu/zafN6i0hj5VXLiDFp+I=;
	b=GoT3MViEM9p8+aVr/ExM6Dl/uiBaBH0Ve24c6o7+i1HF4Ld7U1FJVZzadkoMDqj3/yDOea
	pkNxVNPx0mWJL/bgEgV5w8PUy/i1pX+juwb4L8Xkeu/Y3i1+6bRJIYkxy82438pNTqqigk
	kC+wfJO6luKIOxR2y6DricQjhyss0dg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-aSEh_SQzOIaPoXSNG6qwJQ-1; Sun, 14 Jul 2024 21:08:40 -0400
X-MC-Unique: aSEh_SQzOIaPoXSNG6qwJQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7908626a4a6so724415a12.1
        for <virtualization@lists.linux.dev>; Sun, 14 Jul 2024 18:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721005720; x=1721610520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFD7oUV9b+eqssJJfa29SNu/zafN6i0hj5VXLiDFp+I=;
        b=R24VnQSZps7Vi4F7mhvOgfbCtmCxdF1WJ6rOkA+vRzaEDN3tqbDZhTZVklAvXFXvHP
         Onz++5CGEIX9LwzzDk0BTZ6U7zYxUr/GoaavfQca6skm9TsMPU41vpj/AzcFCEzV2P12
         9BAA+kxnxnLxDT4dt/Ww2JmokWbeeAUi2V6mfUSFOH9DEcjLg72sHkC9oGYi0SZPAMJu
         TqVty1RS1Z+GC1hIFphpwQGVQhkkYyFWCDZ0HtAcVi1Sh4Xd51nQg5DaHQkgCMdx8rn2
         5+k90wYGv/MKR8qg4laC3nX/1CkXGY4MRSZ2Euo1vM85ELnVdMSBeE0Z1hTCPxHVmPM5
         c48Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV5UpKJgudkvGKqij46K7uUZtnpevXeZKCnSZvEREgwRVJsRUN3DWfPoYuQq9nguZ0YN0A0edQzLS8eEFAuTQMJxOH+XMsJhJ1+dvLyYo=
X-Gm-Message-State: AOJu0Yy5sZRP8WXkTVXP5iIL0Lu/BC4y5yW5bRH2c05Ei3sq7VV+3kZ0
	sVaX9gc1JJRqiomX8AKDGlXxh/E6qr/Bl2snSfhfQxD4tOIM+QHj1Br12J9Ex3uzh1uSpPUDhpf
	3TWX7HfleQdl9Q6Da6ZhXTGxMcn5qRbeaqmbYY+FnDilAV74oeRphH2G9p+T3nLwd+ZjH7DoYis
	KU/N1VTKrV4uapfVXWeJSMN8gtbayqzK/iHbIdkOI=
X-Received: by 2002:a17:90a:5288:b0:2c9:36bf:ba6f with SMTP id 98e67ed59e1d1-2caee674e2cmr7215530a91.3.1721005719666;
        Sun, 14 Jul 2024 18:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzfOYW4Dode62bRmQR3obF0rhuYSCpoHB6v8yaabskH3L/XYm5x+VvgWMx3soWzdSy10hWnKT2zpLzTYDaJWk=
X-Received: by 2002:a17:90a:5288:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2caee674e2cmr7215499a91.3.1721005719219; Sun, 14 Jul 2024
 18:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240712115325.54175-1-leitao@debian.org>
In-Reply-To: <20240712115325.54175-1-leitao@debian.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 09:08:28 +0800
Message-ID: <CACGkMEtDDCtF3FrjOppS=+Fmb1uHZborXn3biuRKV4iTwHmVaw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
To: Breno Leitao <leitao@debian.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, rbc@meta.com, horms@kernel.org, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:54=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> After the commit bdacf3e34945 ("net: Use nested-BH locking for
> napi_alloc_cache.") was merged, the following warning began to appear:
>
>          WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_=
put+0x82/0x4b0
>
>           __warn+0x12f/0x340
>           napi_skb_cache_put+0x82/0x4b0
>           napi_skb_cache_put+0x82/0x4b0
>           report_bug+0x165/0x370
>           handle_bug+0x3d/0x80
>           exc_invalid_op+0x1a/0x50
>           asm_exc_invalid_op+0x1a/0x20
>           __free_old_xmit+0x1c8/0x510
>           napi_skb_cache_put+0x82/0x4b0
>           __free_old_xmit+0x1c8/0x510
>           __free_old_xmit+0x1c8/0x510
>           __pfx___free_old_xmit+0x10/0x10
>
> The issue arises because virtio is assuming it's running in NAPI context
> even when it's not, such as in the netpoll case.
>
> To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> is available. Same for virtnet_poll_cleantx(), which always assumed that
> it was in a NAPI context.
>
> Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

