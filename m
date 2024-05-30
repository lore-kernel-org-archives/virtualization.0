Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD44167DA4
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059654; cv=none; b=boHm6QmuEvOvi7QGtb4Sj4erz9I+z5GDT15gGO0dYrp1HSc28WbbNVRCCahxqqDiDmtcMjU3gyGv+8J4IHcMjacS6hosUJQSTrPyidfSEkUlL/BKuUXyYqM66F/dKng0KhZRDtiKXimkdQy8cb0cApMccF3f769vphGP6iKlUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059654; c=relaxed/simple;
	bh=Nc9zAcTlcbtJtu0DNDX60ybeN7et864qLxahu1oi48w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jff2PH5wUkvgfUcbIX4IHbB1/Nt4Vjk46ScCvXVr4hvJNUStccryiqElbhKlL8qUEBiOIajyI/67Z101228wginmsEk2TvxJRiCwgnkMM73bvjsgtBjAFTNZpHKShetHel0hik9BlvcwcFE1X5q+D6j9VSfN1peKNkih2LULR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WP589ktV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WP589ktV"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a183ad429so640453a12.3
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717059650; x=1717664450; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMESdbBicm8rFV5b2/qnQO1Ucemsh+RYgjEutwtyOXs=;
        b=WP589ktVc2DfmEW9k2STf2cLBU6yyj0bRcLVt2urdAR26aehF3cbyt3YHnq8P7fxks
         aWFUGKZy3gVMT0A3bU2bvyyjCvrMrhhukzHK9aaHQ7OWHqlC8YKhWAyKhiINZxEo0Kdh
         ahkEzjOUxtymczmx9cnTIbiTMOAFHoBsC/b3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059650; x=1717664450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMESdbBicm8rFV5b2/qnQO1Ucemsh+RYgjEutwtyOXs=;
        b=X3pVJQypxSKOuQX6UdL9hSjfjOt5dA9rRfAnka+N+iJlzkTFHFfM9+Q3Psyrrt/Xk6
         eFvBCru5zJ9EN9jSu9221SnZ1PpzR1WclYp1AbecgHyDGf/vNAsIzHAITEG5ZtVVdFmj
         3Y0FIcNHEdS7haUM/+Lb/gVOUc/J2CUQhQEUDgNNjkAzov1GqDbkh5pF5pGhagmwc49l
         x8SuDXaglrv1WO0mZ3pY0ZhWiDBQHNoibV4obyOt3442vlbJfgYFeZUaCUphDNWCl+Xg
         aAqaqGBwm5rLobFrXoAQiKN36Zz0BfJ6C8pSHiJmSZeVEraUOET8/a+SMoaSry4jouMq
         //HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkTSgg1IryeYLqsSLLq8//zgVwwBthjnHFRZ3Irh9Rsz+JDoJG8KBX/+Hdn9q8NrktgMm1x61DM80OJ5MMt/8JBlTbe/WqOHC6KBtAVsw=
X-Gm-Message-State: AOJu0YyrZlAtkccRrkvVTcgmBLviCpjR9WWX6QA3HYCXGiobHQO5g7TT
	cVBeRn6soaL56aaIfA8kgeHd0ThrJUJsrsMIz0c4/lTCjXFGBsHNpxD56BRLEWaRxqgWdPehGDF
	sPb/C1zzpKiUCvgth9w8WPv5nTopjhniG16TKxw==
X-Google-Smtp-Source: AGHT+IGi/38kJyGwLfutSxTPJr6k/n9FLOIsFidAs8BpEQDzj/X8jLb5SPS563Jljd25/lDgCZl8A5d3U9QBJ6sO07I=
X-Received: by 2002:a17:906:2411:b0:a5a:5496:3c76 with SMTP id
 a640c23a62f3a-a65e8d125admr119879566b.6.1717059650551; Thu, 30 May 2024
 02:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240529155210.2543295-1-mszeredi@redhat.com> <af09b5d3-940f-491d-97ba-bd3bf19b750a@linux.alibaba.com>
In-Reply-To: <af09b5d3-940f-491d-97ba-bd3bf19b750a@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 May 2024 11:00:39 +0200
Message-ID: <CAJfpeguV0dNiyR5jzQH7H4x0vOzFTcBgnnLDHBPU9fH23A0kng@mail.gmail.com>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Peter-Jan Gootzen <pgootzen@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Yoray Zack <yorayz@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 05:20, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> > +             if (test_bit(FR_FINISHED, &req->flags)) {
> > +                     list_del_init(&req->intr_entry);
> > +                     spin_unlock(&fiq->lock                  ^
>                 missing "return" here?

Well spotted.  Thanks.

> > -             err = -ENODEV;
> > -             spin_unlock(&fiq->lock);
> > -             fuse_put_request(req);
> > -     }
> > +     fuse_send_one(fiq, req);
> >
> > -     return err;
> > +     return 0;
> >  }
>
> There's a minor changed behavior visible to users.  Prior to the patch,
> the FUSE_NOTIFY_RETRIEVE will returns -ENODEV when the connection is
> aborted, but now it returns 0.
>
> It seems only example/notify_store_retrieve.c has used
> FUSE_NOTIFY_RETRIEVE in libfuse.  I'm not sure if this change really
> matters.

It will return -ENOTCONN from  fuse_simple_notify_reply() ->
fuse_get_req().  The -ENODEV would be a very short transient error
during the abort, so it doesn't matter.

Thanks,
Miklos
