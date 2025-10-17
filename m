Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2C30F80F
	for <virtualization@lists.linux.dev>; Fri, 17 Oct 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682787; cv=none; b=a/M+y9TZbAxpE50mXxMYhWvffwbe0cprLAfDh5QnEuMs8bIq5T1n1uSePaU5JB7sd5DPyEr7egd5Z9eYgZY3Ftpd57acJhcOYw8tloNxJeCASD1RDxX8G8OyDHd4OQMK8LRp7x1YGO/NyjzZQnHbSQ7PTfegnxNRq/tLKVmDgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682787; c=relaxed/simple;
	bh=Eh0bw9xfLqENZ7WSEYw/OQLt15jF4Xt8KicazpJsMcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/E4H3xyKbZ+tYpq34p30Fz3PfBgfADoarDfx/T/GspculsNt4SRMQQXpkDpmSGZfSe9lRe2MaPfDuefQoP/33epkJhv1QQL/fybcrU9zZ9Hs4F5LYDNPX/548tMi4OeBun9cBzTgKgSPx9byF4Lmo7s4GH07vLk/cxD0evTXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdPek1kH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdPek1kH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760682784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUOUSWGdX6YFzL2A8L1DmUXyIE8Zv8t8/RNyJEsJ61w=;
	b=TdPek1kHeKNTD8QZfgxuT/oJaXM750+VFQynIxCEtO0weeZCxaRhowvNhUsIJazAuZlxrw
	qAKtL8Q43swA4QACcV4hoSFXTHyiIxWAkXbQF+IJCud+4DpSMdOTyv+7Ld8U2OBoJI4FM/
	gtJTsL/SStYTLF42DPgGJkBO5VS5n24=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-mmX5kGWKOGyhGnleQ4sRnQ-1; Fri, 17 Oct 2025 02:33:03 -0400
X-MC-Unique: mmX5kGWKOGyhGnleQ4sRnQ-1
X-Mimecast-MFC-AGG-ID: mmX5kGWKOGyhGnleQ4sRnQ_1760682783
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7827ef55e41so24673997b3.3
        for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 23:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760682782; x=1761287582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUOUSWGdX6YFzL2A8L1DmUXyIE8Zv8t8/RNyJEsJ61w=;
        b=gxGkoyDy6rior1NaZKuXkAHilGdLkZnxI3vjegcbOu0UXWhwOmLUgEf2Mg/betYBR6
         q6GX2pRMaGov2n5G8fnPRr213bZvSF0EJGIwcQyUQNSoz9by7XhaJQ549ybp2Ni/pltU
         NQ1e7UafCK/IHlhtHL9zBvGT8J20yL7kzpbS7DTEOiSLNbD0hMSstiwdr1b5OwuD4MC8
         bh00z4R3wOUhVnzxMSjjK9qkYFnNz3kwLcbbx142hQKihMDZVswU/ohaa3I6X8WlbVx7
         nBBgneHgDTBpaiM8cYxPXtEMq4A4B/Rmhgv2k9/3g+ADcK5WsogFTgQ8DoYojS6kp55n
         0jvw==
X-Forwarded-Encrypted: i=1; AJvYcCW0p7ysumEWLee0vvm4Msyn2/h0+8KCTL199k/C+H4N924OSUO830yqdCLBdBgokFDRnZvhFZzrl7jp+Y479w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIyrM2Vu+FoLi6Zhu54TKPe+pnt0AySp8jWiRXiA3MQ1cfnIcI
	PF3o0s31XLLZk54hsq3Hi2FnCQYQl/jHi58FXPXLSVJponIXscVl0uwtLFfKK0lVnKqNU4gJTWo
	9kHaVqZmH79TvzhSeB/BKfHYSTaZvXGWoxONsatyX3ml5s/jFpUitmPFL4tIkdEWF2Rcb5LItB9
	SEwIpVc3/kO+JdBKONQr1nz6OUo7CccY6dcyAqjFbZczk=
X-Gm-Gg: ASbGnctvVISKOW36d7fjVNnOrScYXNTIdN5d2nE2v7kLnmWHKmP/A5YlGKdlZfPFBTZ
	B2b6xqgsx29gd6oTv8gtTgr1k5Pb2JtqAMTkcQMsrnvEAiJB/vCH10jAyXpbNbYVN4f5xnfl4XX
	OwnhDs5xquPnXpFsVJf/Lcff36r/qLL+hLig2XNolnanhjxcKX0NgANRu2nzonMjPzR7WSY7WQ1
	bEdAOFtWEJb5towP8Q01LL+uxpCWT5nuiXeLXDhkX8=
X-Received: by 2002:a05:690e:159b:20b0:636:1928:b16b with SMTP id 956f58d0204a3-63e160e9837mr1907676d50.1.1760682782730;
        Thu, 16 Oct 2025 23:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfzzpU0/QnSAE3gDCuvNGr0BTm1Q2jkW11j+3JcVjYg06H1vsoa05BOh9Esr2FnoyTCv8k30KTHta7yNbDCr4=
X-Received: by 2002:a05:690e:159b:20b0:636:1928:b16b with SMTP id
 956f58d0204a3-63e160e9837mr1907665d50.1.1760682782357; Thu, 16 Oct 2025
 23:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251010085827.116958-1-eperezma@redhat.com> <20251010085827.116958-2-eperezma@redhat.com>
 <20251010081923-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251010081923-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 17 Oct 2025 08:32:26 +0200
X-Gm-Features: AS18NWA6LyX5KsRP5REs-F-lAntoOrYBFcpi5dHbv2GWv2WR1X9PGIz96C9KRbQ
Message-ID: <CAJaqyWdSgTcH1sLcmMbySgW+=G3VvjHoy5mW1xz+QNmnXhEbgw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] vduse: make domain_lock an rwlock
To: "Michael S. Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	jasowang@redhat.com, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W7m03hYHWTZNjCFmmamU1pW_W7_Vx0MLMmtnNmbaSfA_1760682783
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 2:34=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Oct 10, 2025 at 10:58:21AM +0200, Eugenio P=C3=A9rez wrote:
> > It will be used in a few more scenarios read-only so make it more
> > scalable.
>
> Well a mutex is sleepable and rwlock is a spinlock.
>
> So this does much more than "make it more scalable".
>
> "A few more scenarios" and "scalable" is also vague.
> RW has its own issues such as fairness.
>
> So tell us please,  which operations do you want to speed up and why?
> What kind of speedup was observed?
>

I think you're totally right here.

Yongji, would it work for you if we leave this conversion on top of
the series with a simple mutex, and we have bandwith to explore the
benefits of this? You were the one proposing it [1].

Thanks!

[1] https://lore.kernel.org/all/CACycT3v=3D_Nm6fefJGFEyoU+Xf5G=3DKzi0sXhhaB=
HnJQZcG-4EqA@mail.gmail.com/

