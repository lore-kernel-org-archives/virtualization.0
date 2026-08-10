Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687339CD09
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346003; cv=none; b=Otb6LkorhcLiOyGYU+LBW8qfqZiuRX9ufoECMBU03tvjea2pa7n+SGJN6YCHif3kDpwPf10+eTOiyXrZ8dhidnJlp/pGOxjoELS7jnDurmo7ssE9UngdowyQBZ3F2Qomfbkfr5XIr0zJYfevYC2pbxLy3780rGzUr1OHtk7DLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346003; c=relaxed/simple;
	bh=LnmoEoIHzucGEVHBMwtNUytTrxg9QJ7e1LZHTMZafds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hKHjYU3geCVA1yyqnEX+D7oKWwNxyk4dQPo76ytH2ItnB0tykVnwO7BVe1+H9FENCqTGn6ZheP/YrAUThErmzylz8oyHGoCOHexUNhKOUOkYxWsa8gxP0ip6q3QiEvdxJ4CE9WDeIph5DvStk9SG+NtbISOUhVo6ZzvszL+rQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/I+JngB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/I+JngB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786346000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EryXU9pxF3wIK7cI2Iyw+BOCGpwNx4GOIKA2uqo9JSs=;
	b=C/I+JngBvZW8qsbOAxorcd7+n7A3pRvEGoiM0+Rrpaaw1p085ORXk0CvH/qYljZABcHTqx
	78Gv8TvIqn/GHlYyE6nTs6k1i8L43SovkkelQBKiOU9ziBVZ8ty1hQcFdW5yx6vfc8AKel
	W0nl8T/OU+esnIoEdId4Yx5DXI2VW58=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-YB0PuHIVM3qRvNg1swHptw-1; Mon, 10 Aug 2026 03:13:19 -0400
X-MC-Unique: YB0PuHIVM3qRvNg1swHptw-1
X-Mimecast-MFC-AGG-ID: YB0PuHIVM3qRvNg1swHptw_1786345998
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f83450a8eso1269550f8f.0
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 00:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786345998; x=1786950798;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EryXU9pxF3wIK7cI2Iyw+BOCGpwNx4GOIKA2uqo9JSs=;
        b=YrFNFO63QVV6KZgYOzfKfhHZW21X7qgBzAZyu6JvWbdLTg5BqvcaC0EjSMeB/dFFCs
         yoFtyUMgNvtXAbORm9NkvMs48zCRDl6pYfPpaQbBflwWyqU7efhNHuvR9Djx4qbmvsfI
         p60dcR40G6jcVP8wi8URw4ABZDfOYNcd67YMXUJDQgLeveIShyhK9bUvoPOJipWFq1kR
         xXB2cqICsqrlMAo3360E+Q/JZ3hEXhmlsMtDw43MV9+DDEc6FjTrxXCNQBb41Dddw0yS
         XhnGm7sMc95Hnsjf6/ANY3Zr4TkSCAqCJhGEDe8fqDaEIO7/tsoI60wU/hFo2AcMUmn4
         9b9A==
X-Forwarded-Encrypted: i=1; AHgh+Rr5dAMOJS+HIPGQiH2D+0jAAjEGgue/TyWi5hOt8coB6enF3VAQf7IIcDcpiKjdbI4nj3ssgWI61t0tW9pzpw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp/RBQyLfKP5Roozl5Nd6wUMIROD0p/nlF48FsR5xYSMgvCgU6
	oNN4iZtX5d56j9r5AYZk+iVEp3n0JqyeeZrOJh9w1U7LI3S7Fq1eoptEhGnLXBa5LTNininr7PS
	6DShjdpr5Ju4B6hrX8KRqhnmlc4w7Bvo2bzdPlp1woCw1qbvEHWWXix4spTCHfUi8gfvN
X-Gm-Gg: AR+sD10FmTgc1z/Grb0ZpAB74zxypMQSV/xs48pQVLhD7nFwFFJqYfDB30DdWkjhX22
	U1KfYhtU1fD3RRyZ5m+LhthcOFqufwhqFcTq7/C+sJtB3Q+kuGepYFB4qdC2W+WbYOlqhZbxfZt
	pBwcmDiKVZtcX8YPFlU2BQ2qnvMLQ79Dl1nBIs5vJTTULug5GFpYVqaLiNARBXgL9h0Sxh/zHjC
	Kd3zO0fAkDCybLV+9KKZJ0kuDOJlndyh6rFY/uDd77MHjiiF6tnythWQzXZWOBNcf1vQ4FPOzh8
	J0o1zT00mmLnPJLoS7pSOzF+z213mbmJea4OadRlgONd7zlgvTKQ+SuVNBKmBIb5iSoOwETz3m/
	udUAkmtZ+IRKkcBjYtvDEpg==
X-Received: by 2002:a05:600c:8b75:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4994e70a6eamr620588215e9.1.1786345998020;
        Mon, 10 Aug 2026 00:13:18 -0700 (PDT)
X-Received: by 2002:a05:600c:8b75:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4994e70a6eamr620587165e9.1.1786345997414;
        Mon, 10 Aug 2026 00:13:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420c68fsm360359385e9.1.2026.08.10.00.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 00:13:16 -0700 (PDT)
Date: Mon, 10 Aug 2026 03:13:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lange Tang <lange_tang@163.com>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Tang Longjun <tanglongjun@kylinos.cn>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: Re:Re:Re: [PATCH] virtio_net: disable cb when napi_schedule_prep
 fails during busy-poll
Message-ID: <20260810031128-mutt-send-email-mst@kernel.org>
References: <20260615094550.106391-1-lange_tang@163.com>
 <1781517700.4206195-1-xuanzhuo@linux.alibaba.com>
 <19692a81.3001.19ece5f8ddc.Coremail.lange_tang@163.com>
 <1781580432.712892-1-xuanzhuo@linux.alibaba.com>
 <4118686.4d22.19ecf0ad78e.Coremail.lange_tang@163.com>
 <1781592565.1172295-1-xuanzhuo@linux.alibaba.com>
 <2f42f4e.1e16.19ed356b302.Coremail.lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2f42f4e.1e16.19ed356b302.Coremail.lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 84sP63GWf1zZvSh5f7MEfHI7WBX3FUg4xSbs2CLN-mg_1786345998
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2026 at 10:08:55AM +0800, Lange Tang wrote:
> At 2026-06-16 14:49:25, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com> wrote:
> >On Tue, 16 Jun 2026 14:07:34 +0800 (CST), Lange Tang <lange_tang@163.com> wrote:
> >> At 2026-06-16 11:27:12, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com> wrote:
> >> >On Tue, 16 Jun 2026 11:00:29 +0800 (CST), Lange Tang <lange_tang@163.com> wrote:
> >> >> At 2026-06-15 18:01:40, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com> wrote:
> >> >> >On Mon, 15 Jun 2026 17:45:50 +0800, Longjun Tang <lange_tang@163.com> wrote:
> >> >> >> From: Longjun Tang <tanglongjun@kylinos.cn>
> >> >> >>
> >> >> >> When busy-poll is active, napi_schedule_prep() returns false in
> >> >> >> skb_recv_done(), so virtqueue_disable_cb() is skipped. The device
> >> >> >> may keep firing irqs until the next poll round reaches
> >> >> >> virtqueue_napi_complete(). If cb is enabled under busy-poll case,
> >> >> >> it will lead to a large number of spurious interrupts. Explicitly
> >> >> >> disable callbacks in this case to prevent spurious interrupts.
> >> >> >>
> >> >> >> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> >> >> >> ---
> >> >> >>  drivers/net/virtio_net.c | 2 ++
> >> >> >>  1 file changed, 2 insertions(+)
> >> >> >>
> >> >> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> >> >> index f4adcfee7a80..6d675fddc59b 100644
> >> >> >> --- a/drivers/net/virtio_net.c
> >> >> >> +++ b/drivers/net/virtio_net.c
> >> >> >> @@ -728,6 +728,8 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
> >> >> >>  	if (napi_schedule_prep(napi)) {
> >> >> >>  		virtqueue_disable_cb(vq);
> >> >> >>  		__napi_schedule(napi);
> >> >> >> +	} else if (test_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state)) {
> >> >> >> +		virtqueue_disable_cb(vq);
> >> >> >
> >> >> >I see, but we should avoid checking NAPI_STATE_IN_BUSY_POLL directly in the
> >> >> >drivers. The NIC driver should remain agnostic to busy polling. I think we need
> >> >> >a better way, maybe we should rewrite virtqueue_napi_schedule instead.
> >> >>
> >> >> How about rewrite it like this?
> >> >> static void virtqueue_napi_schedule(struct napi_struct *napi,
> >> >>                                     struct virtqueue *vq)
> >> >> {
> >> >>         virtqueue_disable_cb(vq);
> >> >>         if (napi_schedule_prep(napi))
> >> >>                 __napi_schedule(napi);
> >> >> }
> >> >> Any comments are welcome.
> >> >
> >> >
> >> >Another CPU could be running NAPI and has just enabled the callbacks (cb).
> >> >Meanwhile, this side unconditionally disables the cb. Since NAPI on the other
> >> >CPU hasn't exited yet, the subsequent prep on this side fails, leaving no one to
> >> >re-enable the cb.
> >> >
> >> >Thanks.
> >>
> >> Regarding the case you described, when NAPI on another CPU exits, the virtqueue_napi_complete func
> >> will be executed to re-enable cb.  and if there is still unconsumed data in the virtqueue, virtqueue_napi_schedule
> >> will be called again to schedule NAPI.
> >>
> >> In summary, I think that the disable_cb and __napi_schedule within the virtqueue_napi_schedule func do not need to be bound together.
> >>
> >> Any comments are welcome. Thinks.
> >
> >
> ><Your code>
> >static void virtqueue_napi_schedule(struct napi_struct *napi,
> >                                    struct virtqueue *vq)
> >{
> >
> >							       |static bool virtqueue_napi_complete(struct napi_struct *napi,
> >							       |				    struct virtqueue *vq, int processed)
> >							       |{
> >							       |	int opaque;
> >							       |
> >							       |	opaque = virtqueue_enable_cb_prepare(vq);
> >                                                               |
> >        virtqueue_disable_cb(vq);                              |
> >        if (napi_schedule_prep(napi))                          |
> >                __napi_schedule(napi);                         |
> >							       |	if (napi_complete_done(napi, processed)) {
> >							       |		if (unlikely(virtqueue_poll(vq, opaque)))
> >							       |			virtqueue_napi_schedule(napi, vq);
> >							       |		else
> >							       |			 return true; // return directly
> >							       |	} else {
> >							       |		virtqueue_disable_cb(vq);
> >							       |	}
> >							       |
> >							       |	return false;
> >							       |}
> >}
> >
> >1. new packets (notified by irq) are consumed by napi before virtqueue_napi_complete
> >2. poll is not called by irq, maybe xsk wake up. So irq is not disabled.
> >
> >
> >Thanks.
> 
> Based on your code analysis above, I got .  thanks.
> disable_cb and __napi_schedule in the virtqueue_napi_schedule func indeed cannot be separated.
> 
> Regarding the issue of not being able to disable cb in a busy-poll context, do you have any suggestions?
> 
> Any comments are welcome. Thanks.


Add a netdev core API that basically does:

test_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state)

add documentation, either netdev maintainers merge it, or
alternatively they will tell you what to do)

> >
> >
> >>
> >> >
> >> >
> >> >> >
> >> >> >
> >> >> >>  	}
> >> >> >>  }
> >> >> >>
> >> >> >> --
> >> >> >> 2.25.1
> >> >> >>
> >> >>
> >>
> 

