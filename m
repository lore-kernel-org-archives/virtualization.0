Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A337C0F6
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348317; cv=none; b=Rr1iFx6KSC7yo2NFXWvV4tFPH87m5esEASGlPZ1d5OJlws7ADaKdRqM5t3NRsFVYbN3ZSJ4md3IxLmr1c7Y8jOByHNi2CxNEpN+cx+wNWyzBd8ZZ8/IJ+Aj5muBltFmLa+oPhrh5hTzOKnpomsH44y4MBlSvHwCKyHgpSVXRocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348317; c=relaxed/simple;
	bh=LnF1MwpDwash+BDtNjQ7A5icGGfMTO5ORzh/7vaPtkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iFZ/WMgaI9ZPLeF6Llqvp7Y2LM2WM3R181NXLS+ATp4UIjHjjUVuk9LNQRjlbvOlmc/ck0+LVp8THIy4nYIratzZ0z0nMjp1hi/ERzBzEui/tlLtY6jgeQDjJ8953uha6A5WjE2jxKdv+9HJqG5ofwd4MogdbhVlms63LbtS2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbwcVKmz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbwcVKmz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786348315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RK1lK8JBETRDAnHbYMzq1oGTCYnqDArIlYuPG05ZVV4=;
	b=YbwcVKmz6UIAE6uiUg2BR9duzTlITpYSUWzgIS/nuAF+P39r1RAtTsSynhFmeMb5Mt96NX
	786yRsyLtrVVznolnrVG7Y9JbHULkdJQ2c2O3ac9r0Yem5Q9A/0u8fcGFNM9y+Di9F3Rwr
	CG0r3sGJy2sbihDhZAh6AVq6i5E8LUQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-Gtke1u-LNVazrHYKVw5wZQ-1; Mon, 10 Aug 2026 03:51:54 -0400
X-MC-Unique: Gtke1u-LNVazrHYKVw5wZQ-1
X-Mimecast-MFC-AGG-ID: Gtke1u-LNVazrHYKVw5wZQ_1786348313
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496b61bd846so11846105e9.2
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 00:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786348313; x=1786953113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RK1lK8JBETRDAnHbYMzq1oGTCYnqDArIlYuPG05ZVV4=;
        b=qWfvIVvts8a3oLCYecO77S/CmoRsZABjQ3Hd4Fpmi07HgUgIc6MKU92/wcSFrLxpCk
         Fx6++MOz18L9j+ZXjgUu7pRCHv3NigAmpAi5BOo0UqOdlg8HaF3DEw5vs8avFXBJyFDA
         htaMU4fyuuRHcmmLonVtqHXDieuoeAukTIUqmYAb8WNiV6LY+3NaMXxYJtnq0WKV+lIl
         //uweAKIkK0GdfUXOqLnBylhc5WSchyi3hN6p8tEzwn1YneAdoZhAZvK35jdvVxvcE4l
         rOEt/PX3WdVFCwWlFaFeWwjbJtY0uF9c5taYujkwLXEJNKk6mi97Ig++yPgLJHylumzO
         sq/g==
X-Forwarded-Encrypted: i=1; AHgh+RrJBqX+qyWOfWFIpOXCFfWG2wu+k2HSty2QWR+3wHUUQ8UU/hxE4EiIxOdlitxhaWhyUdxfUMZin9SmFkDAUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5OzSaEzKty83VI1H1m6U//oiWx7Yq3/Pt7OF0r969fkfDa9tp
	hW/7vF3T4d/iTpq6LABV2TCvRMnqJUzsSkOf0XX5kxlXWZQ4OkccZa6PB3fbpWw9N1UhDgeJ05E
	fCa1fnkYPRLTE58mopzFe/O/TEhNhhSXTKntOHuYzR6AfiLAjPfYAkReB5ZeeOhkKQiXo
X-Gm-Gg: AR+sD10qyi05hCY94Eu1knJKnIr+sS3xpsL+OMFH0IIJUkOSy6DhjZSuO1SS2agIeEn
	dsgWVObQ9sqtlMcKq3ATHLwcfHMovTV0juRnZ1kVBTIXunzCBgXjf2IPi2GBOhuyrKURYo+hp1K
	1toMTIxA+WQgLDUcNAcqfz2QCdPpGTEFD97tDUH0tu0i+ujkjzJ9+z/suPnkodP3TbczHDjwg9p
	tlH1rXmH5DbqZR4Ati0kt3Cy69d77x6f/I4QPHlrFyiafOQ9+jrdi2ILM0XA7mjlLnhfkvckpof
	UJvjGBt7lKYzBw9ya6zeGBBLab1rSufj4+DxHPH6Kv90oTMbZZh/9fOdjOYCs5J3tVZjgQmT+cS
	IWDXT6JHfmRK+mIs65kWJ1A==
X-Received: by 2002:a05:600c:310f:b0:493:faf3:3ea5 with SMTP id 5b1f17b1804b1-4994e7432ecmr510026635e9.4.1786348312523;
        Mon, 10 Aug 2026 00:51:52 -0700 (PDT)
X-Received: by 2002:a05:600c:310f:b0:493:faf3:3ea5 with SMTP id 5b1f17b1804b1-4994e7432ecmr510026005e9.4.1786348312026;
        Mon, 10 Aug 2026 00:51:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm30513299f8f.22.2026.08.10.00.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 00:51:51 -0700 (PDT)
Date: Mon, 10 Aug 2026 03:51:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Lange Tang <lange_tang@163.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Tang Longjun <tanglongjun@kylinos.cn>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: Re:Re: [PATCH] virtio_net: disable cb when napi_schedule_prep
 fails during busy-poll
Message-ID: <20260810032647-mutt-send-email-mst@kernel.org>
References: <20260615094550.106391-1-lange_tang@163.com>
 <1781517700.4206195-1-xuanzhuo@linux.alibaba.com>
 <19692a81.3001.19ece5f8ddc.Coremail.lange_tang@163.com>
 <1781580432.712892-1-xuanzhuo@linux.alibaba.com>
 <4118686.4d22.19ecf0ad78e.Coremail.lange_tang@163.com>
 <1781592565.1172295-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1781592565.1172295-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZYW62_d8qoP8MTcDu1gHZFk3lmR9k0g1DWo0u3Vpy54_1786348313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 02:49:25PM +0800, Xuan Zhuo wrote:
> On Tue, 16 Jun 2026 14:07:34 +0800 (CST), Lange Tang <lange_tang@163.com> wrote:
> > At 2026-06-16 11:27:12, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com> wrote:
> > >On Tue, 16 Jun 2026 11:00:29 +0800 (CST), Lange Tang <lange_tang@163.com> wrote:
> > >> At 2026-06-15 18:01:40, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com> wrote:
> > >> >On Mon, 15 Jun 2026 17:45:50 +0800, Longjun Tang <lange_tang@163.com> wrote:
> > >> >> From: Longjun Tang <tanglongjun@kylinos.cn>
> > >> >>
> > >> >> When busy-poll is active, napi_schedule_prep() returns false in
> > >> >> skb_recv_done(), so virtqueue_disable_cb() is skipped. The device
> > >> >> may keep firing irqs until the next poll round reaches
> > >> >> virtqueue_napi_complete(). If cb is enabled under busy-poll case,
> > >> >> it will lead to a large number of spurious interrupts. Explicitly
> > >> >> disable callbacks in this case to prevent spurious interrupts.
> > >> >>
> > >> >> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> > >> >> ---
> > >> >>  drivers/net/virtio_net.c | 2 ++
> > >> >>  1 file changed, 2 insertions(+)
> > >> >>
> > >> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > >> >> index f4adcfee7a80..6d675fddc59b 100644
> > >> >> --- a/drivers/net/virtio_net.c
> > >> >> +++ b/drivers/net/virtio_net.c
> > >> >> @@ -728,6 +728,8 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
> > >> >>  	if (napi_schedule_prep(napi)) {
> > >> >>  		virtqueue_disable_cb(vq);
> > >> >>  		__napi_schedule(napi);
> > >> >> +	} else if (test_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state)) {
> > >> >> +		virtqueue_disable_cb(vq);
> > >> >
> > >> >I see, but we should avoid checking NAPI_STATE_IN_BUSY_POLL directly in the
> > >> >drivers. The NIC driver should remain agnostic to busy polling. I think we need
> > >> >a better way, maybe we should rewrite virtqueue_napi_schedule instead.
> > >>
> > >> How about rewrite it like this?
> > >> static void virtqueue_napi_schedule(struct napi_struct *napi,
> > >>                                     struct virtqueue *vq)
> > >> {
> > >>         virtqueue_disable_cb(vq);
> > >>         if (napi_schedule_prep(napi))
> > >>                 __napi_schedule(napi);
> > >> }
> > >> Any comments are welcome.
> > >
> > >
> > >Another CPU could be running NAPI and has just enabled the callbacks (cb).
> > >Meanwhile, this side unconditionally disables the cb. Since NAPI on the other
> > >CPU hasn't exited yet, the subsequent prep on this side fails, leaving no one to
> > >re-enable the cb.
> > >
> > >Thanks.
> >
> > Regarding the case you described, when NAPI on another CPU exits, the virtqueue_napi_complete func
> > will be executed to re-enable cb.  and if there is still unconsumed data in the virtqueue, virtqueue_napi_schedule
> > will be called again to schedule NAPI.
> >
> > In summary, I think that the disable_cb and __napi_schedule within the virtqueue_napi_schedule func do not need to be bound together.
> >
> > Any comments are welcome. Thinks.
> 
> 
> <Your code>
> static void virtqueue_napi_schedule(struct napi_struct *napi,
>                                     struct virtqueue *vq)
> {
> 
> 							       |static bool virtqueue_napi_complete(struct napi_struct *napi,
> 							       |				    struct virtqueue *vq, int processed)
> 							       |{
> 							       |	int opaque;
> 							       |
> 							       |	opaque = virtqueue_enable_cb_prepare(vq);
>                                                                |
>         virtqueue_disable_cb(vq);                              |
>         if (napi_schedule_prep(napi))                          |
>                 __napi_schedule(napi);                         |
> 							       |	if (napi_complete_done(napi, processed)) {
> 							       |		if (unlikely(virtqueue_poll(vq, opaque)))
> 							       |			virtqueue_napi_schedule(napi, vq);
> 							       |		else
> 							       |			 return true; // return directly
> 							       |	} else {
> 							       |		virtqueue_disable_cb(vq);
> 							       |	}
> 							       |
> 							       |	return false;
> 							       |}
> }
> 
> 1. new packets (notified by irq) are consumed by napi before virtqueue_napi_complete
> 2. poll is not called by irq, maybe xsk wake up. So irq is not disabled.
> 
> 
> Thanks.


I thought more about it and - so what? It's a rare race that
might result in more interrupts. Why is that an issue?

This would be a problem:
   callbacks disabled
   no NAPI

and I do not see how this gets there.

so maybe 

        virtqueue_disable_cb(vq);
	napi_schedule(napi);

is exactly the right thing?

it's certainly simple.

> 
> >
> > >
> > >
> > >> >
> > >> >
> > >> >>  	}
> > >> >>  }
> > >> >>
> > >> >> --
> > >> >> 2.25.1
> > >> >>
> > >>
> >

