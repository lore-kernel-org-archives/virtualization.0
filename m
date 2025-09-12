Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE8D301020
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691022; cv=none; b=kpWxP4oS9mufj5ys3ASBa31XU7S3GYYZUrYt/LNS69q22nG/AMvegCoUYXo1X9LhmjegI5EcsxPpAx4VYC6wb+lYjd+iuI0wZ8hdYM7OOPA5nme6ahKFbHkQz0K5xg5v5fngUgvcHIg+1gw9ae0QIIzBm8zzHH9ZV7i9Bo6N30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691022; c=relaxed/simple;
	bh=xG0xQio8EPzsul4Ghf8rz0UL2N3MlY4xJdVEYnW3vwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lThDiNYih/GVYcF/7nUMGH1/ntL4dO4L9Zl8uLHJDpX3ShrHhjxtnWt+fWqGDHIg8M5LMqL/yFXplbZu6bb4QMGwHt+L8v65AT+ky8bKiXjF16SxoaQKkUXdpavmk4ilcHXwV9xR53VDq8b7OH4AsJLEV4j5inGacWujKJu3snQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fejmX1cB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fejmX1cB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757691020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1U2VojtPokeUk+tdxQA3A5MwzgzqZJ7HiBkhr5RCN8=;
	b=fejmX1cBqkzun5uJyEGLHjXSM49MfWVISG6NvgqVjQbISgE2/Qmp7pzkMYtspEcopwtCH9
	q1nBMLUEOdvGwaq7DUY4+9+TPUN5C4hU+uMnLlWNSBh1W/xRQBeufBuG1btEaVG21bNyYH
	pjMAutAQ4XV8Ga80TW7hiiwVtX1sIUo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-JlM2fGOEMkSrWVs6TPxkiQ-1; Fri, 12 Sep 2025 11:30:18 -0400
X-MC-Unique: JlM2fGOEMkSrWVs6TPxkiQ-1
X-Mimecast-MFC-AGG-ID: JlM2fGOEMkSrWVs6TPxkiQ_1757691017
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b920e0c25so13471215e9.3
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691017; x=1758295817;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1U2VojtPokeUk+tdxQA3A5MwzgzqZJ7HiBkhr5RCN8=;
        b=G6fK6Es1kAprO2zyAlF47UGNPa/w2Rst8uwNWnARS8lLPA0naJb0fwd7v5lxyvZQoX
         TxaduUE2XZCx/NdJMc8wvnjreC8Yf9QN2Vj79suX+DoHV5A9FWiCF0wgIZ6coAwV8seE
         1ZGmka5sLWvHEj6T4H4OOTPkt+O4NIw5Ax7Ea72yZ1pZ+k8tzfvZ92hOKt2ZmWyYhwC7
         JlWEF6YiCCxaEO9WH2glGZ9VTK2XRhb2HoSnkNXESAJgvlrgnl1JRRPrQMnfbgBaNOpB
         kdpPUpKeRBkCcrbAfSenGfMf/RbejlXnn8RyIlAa6oFU3u6pEYWrYSljODOCAtoiiUXd
         ukjg==
X-Forwarded-Encrypted: i=1; AJvYcCXOsDdPmQiU15sE4aXN7IiQQnkHOMdKhtqXBUTQmPfVI9Z1D6dwx2+fAjtUOoYc1v0WyoBiAuOuD6YwwFTpXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ6Z1bGaFNWUQ69uUuV+v+CjpJHobU0VyBViILNibRG6TtCjm9
	rRGVtBsWziISahmjWl2m8tSdb8lFzj8R4A5MqVxKjdYzZW64kF/r7QIU3tttWOv64fcetVM9FcB
	Ul8MUr26kjF/Iv6oVQhfXbIcTvR5a5k5EfR3mMLMSRwY06bLs7PI83/6FMM2qHz1NDZJB
X-Gm-Gg: ASbGnctLhbSnAke0eJHmKQ+3dLKPBkroOHjsx00p757DBnkns/N3bGPaBkQygogeQzo
	I7OpFGNFTGPJFYnjuICTMzJ3rbqIYZh2eCHlGexbkjSmB8BS3O4X3LnfkIhymEVBUta6dCLSKy3
	b8HUTKCmEpOH2Ouq3Oi8IUoQQhZb5v2KLCE0wj14EhfHkT/R0Dhw9wAy2XP+Gm8qH0xF0WIHx4E
	WtaFX2fT7tHi5VPdDXQjq83mAJ2GbVzJSFsVo+Lkk9OQ+V9i7He8bj9Pnipa7IMb7rAi/h/BlA2
	E27DrsLRODzHaC0p2Zoq6ybn7e/2/Y8LyNw=
X-Received: by 2002:a05:600c:c4aa:b0:45d:f7f9:9ac7 with SMTP id 5b1f17b1804b1-45f211c4cf0mr42590725e9.6.1757691017204;
        Fri, 12 Sep 2025 08:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuVm8pd2LL97DReTjaXXQ9ger3Xdm5br919kQs5cKISKVwPT+FYYKJCNez4asltdGHaL4cTA==
X-Received: by 2002:a05:600c:c4aa:b0:45d:f7f9:9ac7 with SMTP id 5b1f17b1804b1-45f211c4cf0mr42590345e9.6.1757691016755;
        Fri, 12 Sep 2025 08:30:16 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015bf73csm34789585e9.11.2025.09.12.08.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:30:16 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:30:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"jonah.palmer@oracle.com" <jonah.palmer@oracle.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250912112726-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
 <20250912044523-mutt-send-email-mst@kernel.org>
 <63426904-881F-4725-96F5-3343389ED170@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <63426904-881F-4725-96F5-3343389ED170@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5_rVgh9KR5WhjGg-0xFYoSRLJ8zX9wDpdpVJf_S9V14_1757691017
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 12, 2025 at 03:24:42PM +0000, Jon Kohler wrote:
> 
> 
> > On Sep 12, 2025, at 4:50 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> >> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> >> sendmsg") tries to defer the notification enabling by moving the logic
> >> out of the loop after the vhost_tx_batch() when nothing new is
> >> spotted. This will bring side effects as the new logic would be reused
> >> for several other error conditions.
> >> 
> >> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> >> might return -EAGAIN and exit the loop and see there's still available
> >> buffers, so it will queue the tx work again until userspace feed the
> >> IOTLB entry correctly. This will slowdown the tx processing and may
> >> trigger the TX watchdog in the guest.
> > 
> > It's not that it might.
> > Pls clarify that it *has been reported* to do exactly that,
> > and add a link to the report.
> > 
> > 
> >> Fixing this by stick the notificaiton enabling logic inside the loop
> >> when nothing new is spotted and flush the batched before.
> >> 
> >> Reported-by: Jon Kohler <jon@nutanix.com>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > 
> > So this is mostly a revert, but with
> >                     vhost_tx_batch(net, nvq, sock, &msg);
> > added in to avoid regressing performance.
> > 
> > If you do not want to structure it like this (revert+optimization),
> > then pls make that clear in the message.
> > 
> > 
> >> ---
> >> drivers/vhost/net.c | 33 +++++++++++++--------------------
> >> 1 file changed, 13 insertions(+), 20 deletions(-)
> >> 
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index 16e39f3ab956..3611b7537932 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >> int err;
> >> int sent_pkts = 0;
> >> bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> >> - bool busyloop_intr;
> >> bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> >> 
> >> do {
> >> - busyloop_intr = false;
> >> + bool busyloop_intr = false;
> >> +
> >> if (nvq->done_idx == VHOST_NET_BATCH)
> >> vhost_tx_batch(net, nvq, sock, &msg);
> >> 
> >> @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >> break;
> >> /* Nothing new?  Wait for eventfd to tell us they refilled. */
> >> if (head == vq->num) {
> >> - /* Kicks are disabled at this point, break loop and
> >> - * process any remaining batched packets. Queue will
> >> - * be re-enabled afterwards.
> >> + /* Flush batched packets before enabling
> >> + * virqtueue notification to reduce
> >> + * unnecssary virtqueue kicks.
> > 
> > typos: virtqueue, unnecessary
> > 
> >> */
> >> + vhost_tx_batch(net, nvq, sock, &msg);
> >> + if (unlikely(busyloop_intr)) {
> >> + vhost_poll_queue(&vq->poll);
> >> + } else if (unlikely(vhost_enable_notify(&net->dev,
> >> + vq))) {
> >> + vhost_disable_notify(&net->dev, vq);
> >> + continue;
> >> + }
> >> break;
> >> }
> 
> See my comment below, but how about something like this?
>  		if (head == vq->num) {
> 			/* Flush batched packets before enabling
> 			 * virtqueue notification to reduce
> 			 * unnecessary virtqueue kicks.
> 			 */
> 			vhost_tx_batch(net, nvq, sock, &msg);
> 			if (unlikely(busyloop_intr))
> 				/* If interrupted while doing busy polling,
> 				 * requeue the handler to be fair handle_rx
> 				 * as well as other tasks waiting on cpu.
> 				 */
> 				vhost_poll_queue(&vq->poll);
> 			else
> 				/* All of our work has been completed;
> 				 * however, before leaving the TX handler,
> 				 * do one last check for work, and requeue
> 				 * handler if necessary. If there is no work,
> 				 * queue will be reenabled.
> 				 */
> 				vhost_net_busy_poll_try_queue(net, vq);


I mean it's functionally equivalent, but vhost_net_busy_poll_try_queue 
checks the avail ring again and we just checked it.
Why is this a good idea?
This happens on good path so I dislike unnecessary work like this.


>  			break;
>  		}
> 
> 
> >> 
> >> @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >> ++nvq->done_idx;
> >> } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> >> 
> >> - /* Kicks are still disabled, dispatch any remaining batched msgs. */
> >> vhost_tx_batch(net, nvq, sock, &msg);
> >> -
> >> - if (unlikely(busyloop_intr))
> >> - /* If interrupted while doing busy polling, requeue the
> >> - * handler to be fair handle_rx as well as other tasks
> >> - * waiting on cpu.
> >> - */
> >> - vhost_poll_queue(&vq->poll);
> >> - else
> >> - /* All of our work has been completed; however, before
> >> - * leaving the TX handler, do one last check for work,
> >> - * and requeue handler if necessary. If there is no work,
> >> - * queue will be reenabled.
> >> - */
> >> - vhost_net_busy_poll_try_queue(net, vq);
> 
> Note: the use of vhost_net_busy_poll_try_queue was intentional in my
> patch as it was checking to see both conditionals.
> 
> Can we simply hoist my logic up instead?
> 
> >> }
> >> 
> >> static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> >> -- 
> >> 2.34.1
> > 
> 
> Tested-by: Jon Kohler <jon@nutanix.com <mailto:jon@nutanix.com>>
> 
> Tried this out on a 6.16 host / guest that locked up with iotlb miss loop,
> applied this patch and all was well. 

