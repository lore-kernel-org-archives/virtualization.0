Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CFC2253FD
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691523; cv=none; b=TFZi2VHnFNaHsXmgRFjDsoO/+VGXf0HwN9ucM46Yt2xRbC3UEnzBKV4ffffnASfSIvrwkxeNFie9Y5xy64YS/to3MuHXPetg1va1WGxz7M+ZwQXCBtlmC6MzfkLtdqblNUabbg8RRpJeMYU89Ye+McjHEonUnz094iuLHU/UILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691523; c=relaxed/simple;
	bh=yA5W0gyjqiFInACMAabQjnKR5iVoASdT39QfR/SdyN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C1uyfhVEuT1HKe9jSjOH3lmaHdRRMZ/PApVj5zGerRMTrYADGsU2+ArAbIR2cVgAaHANHCGnNTx5M1EMqMWAI2dcDlP5Y/dMbW86flfZ4W27YWjYe8UKHxCQLpvNP7itrjnyC9ct9giTDFgmhbCuFrjch+4KEd5t987TFP/bLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgZQoEIv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgZQoEIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757691520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSPNoqFe2CICtx8x9/0bzyvcMYgkBZkWJVegup2Y/D0=;
	b=YgZQoEIvSZO7wGIGNd1Fo9m5vhhNhew8dwgA/CquoooaqPxthloRUvQZ45KEUN4XiD2dM3
	iKARncpSQNBz3qRjkXGICOIyDto73Qv+QgNq2zlyNJAl6xIBmad7KtX1FNf/Y49sgTCXIW
	qYRSYfCX/MZ88dFH2vLKNoJaKKzZ2u8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-QlfUreSJMEqVQwrsN49tzQ-1; Fri, 12 Sep 2025 11:38:39 -0400
X-MC-Unique: QlfUreSJMEqVQwrsN49tzQ-1
X-Mimecast-MFC-AGG-ID: QlfUreSJMEqVQwrsN49tzQ_1757691518
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3df3e935ec8so1025530f8f.0
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691518; x=1758296318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSPNoqFe2CICtx8x9/0bzyvcMYgkBZkWJVegup2Y/D0=;
        b=ERnupA7jvMl0skSAd3ly7yqyW+0b9Vzb+gVVMcBtweBMPHCqjJn2TAmPDDerEzAD0t
         W4P00xAtPUHmxFeiiSMU6rCkstB42OJxBaHYklim4LOAN62o2q8a+af5Q+Kbr89CrbKy
         ssPzPAuLCkgNg4+9FzLVYRnbLZkm7QUaiBfwPBY6EV1Vje8L3jTF83Wv2ZxoYqiZuMXn
         krmBHepNz7hPxYhB2YTC+/1knv9933EGcgaaLCWEPlqeRLApd7C5G5dgbmvYqEyvnPEk
         AnUiT5ppSeYeWano28NLRLBr47cF+eLw9yWuAj0UjzYgtM5Zz4igXsv6w7vgn7QOBexn
         YuDg==
X-Forwarded-Encrypted: i=1; AJvYcCWq1GPhSWvNhWSPAQvgrd95e1UcMTXHKwu3673+Cz/i6vtEpkFAaAtEO6EPxNcwNKTyblgmCtoTDymaVIAU0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVxrrjhUpUqYqWN9ZPM3io0rdlNswU1YFB0dBvjg0snxfVrL5m
	W2ZWAMVl7thtBxeNomS4yyoFURON+c4ODDaVlNzPWB8mjjzEx7ypMY+8A08Lo+Hr4N6H3xO5k32
	uYAeRFKJnpya78EegGrGaPueNNMK6FlmJw1+YSB/ELW7GAr9NN/+ji6sDW/zNR0odxYsi
X-Gm-Gg: ASbGncsDZ1WD1ETPpSO6qWFeulTmrVm4qzGluuCh1d6aNaNc/HRvfuEqI5uhlTA20HW
	1mqcoJZzqq66WaeLFuXf2yw1OaHbzxfUCCo5i2+byik69lbE3sprv67RyLt9zNeNDqyhAHGa9pA
	0Gn1zi/cyJ8sjTatG08ZEz61YkLNAb1ScXJnah/e/fXkc6k8ElA/TLBJSsnehyzp+j0dhlI7HEC
	GO8rS63CpWxJqrKctBKYCpAJVGNzWC9C3uo1Qst3LQRfctWS7gKmN4dhrrgW9E7BWk84HEDVXAt
	XGtqP3JPgHyOT1Z56E21/9k/bfFk/m6X7sc=
X-Received: by 2002:a05:6000:607:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-3e7657c4d40mr2960032f8f.23.1757691518267;
        Fri, 12 Sep 2025 08:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU2k5VNrAMxJMJsslonyveuVI1XMMPRzh7WCfgvwmksVI/+i/xxPC3tMUE4P/r7651cJtw3w==
X-Received: by 2002:a05:6000:607:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-3e7657c4d40mr2959997f8f.23.1757691517807;
        Fri, 12 Sep 2025 08:38:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01512379sm69044125e9.0.2025.09.12.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:38:37 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:38:34 -0400
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
Message-ID: <20250912113432-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
 <20250912044523-mutt-send-email-mst@kernel.org>
 <63426904-881F-4725-96F5-3343389ED170@nutanix.com>
 <20250912112726-mutt-send-email-mst@kernel.org>
 <4418BA21-716E-468B-85EB-DB88CCD64F38@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4418BA21-716E-468B-85EB-DB88CCD64F38@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QdPoBpqowYfl1nkmfbnb9xLTM2JUiuJ1WhUeVtvBRz0_1757691518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 12, 2025 at 03:33:32PM +0000, Jon Kohler wrote:
> 
> 
> > On Sep 12, 2025, at 11:30 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Fri, Sep 12, 2025 at 03:24:42PM +0000, Jon Kohler wrote:
> >> 
> >> 
> >>> On Sep 12, 2025, at 4:50 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> 
> >>> !-------------------------------------------------------------------|
> >>> CAUTION: External Email
> >>> 
> >>> |-------------------------------------------------------------------!
> >>> 
> >>> On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> >>>> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> >>>> sendmsg") tries to defer the notification enabling by moving the logic
> >>>> out of the loop after the vhost_tx_batch() when nothing new is
> >>>> spotted. This will bring side effects as the new logic would be reused
> >>>> for several other error conditions.
> >>>> 
> >>>> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> >>>> might return -EAGAIN and exit the loop and see there's still available
> >>>> buffers, so it will queue the tx work again until userspace feed the
> >>>> IOTLB entry correctly. This will slowdown the tx processing and may
> >>>> trigger the TX watchdog in the guest.
> >>> 
> >>> It's not that it might.
> >>> Pls clarify that it *has been reported* to do exactly that,
> >>> and add a link to the report.
> >>> 
> >>> 
> >>>> Fixing this by stick the notificaiton enabling logic inside the loop
> >>>> when nothing new is spotted and flush the batched before.
> >>>> 
> >>>> Reported-by: Jon Kohler <jon@nutanix.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> >>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>> 
> >>> So this is mostly a revert, but with
> >>>                    vhost_tx_batch(net, nvq, sock, &msg);
> >>> added in to avoid regressing performance.
> >>> 
> >>> If you do not want to structure it like this (revert+optimization),
> >>> then pls make that clear in the message.
> >>> 
> >>> 
> >>>> ---
> >>>> drivers/vhost/net.c | 33 +++++++++++++--------------------
> >>>> 1 file changed, 13 insertions(+), 20 deletions(-)
> >>>> 
> >>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>>> index 16e39f3ab956..3611b7537932 100644
> >>>> --- a/drivers/vhost/net.c
> >>>> +++ b/drivers/vhost/net.c
> >>>> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >>>> int err;
> >>>> int sent_pkts = 0;
> >>>> bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> >>>> - bool busyloop_intr;
> >>>> bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> >>>> 
> >>>> do {
> >>>> - busyloop_intr = false;
> >>>> + bool busyloop_intr = false;
> >>>> +
> >>>> if (nvq->done_idx == VHOST_NET_BATCH)
> >>>> vhost_tx_batch(net, nvq, sock, &msg);
> >>>> 
> >>>> @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >>>> break;
> >>>> /* Nothing new?  Wait for eventfd to tell us they refilled. */
> >>>> if (head == vq->num) {
> >>>> - /* Kicks are disabled at this point, break loop and
> >>>> - * process any remaining batched packets. Queue will
> >>>> - * be re-enabled afterwards.
> >>>> + /* Flush batched packets before enabling
> >>>> + * virqtueue notification to reduce
> >>>> + * unnecssary virtqueue kicks.
> >>> 
> >>> typos: virtqueue, unnecessary
> >>> 
> >>>> */
> >>>> + vhost_tx_batch(net, nvq, sock, &msg);
> >>>> + if (unlikely(busyloop_intr)) {
> >>>> + vhost_poll_queue(&vq->poll);
> >>>> + } else if (unlikely(vhost_enable_notify(&net->dev,
> >>>> + vq))) {
> >>>> + vhost_disable_notify(&net->dev, vq);
> >>>> + continue;
> >>>> + }
> >>>> break;
> >>>> }
> >> 
> >> See my comment below, but how about something like this?
> >> if (head == vq->num) {
> >> /* Flush batched packets before enabling
> >> * virtqueue notification to reduce
> >> * unnecessary virtqueue kicks.
> >> */
> >> vhost_tx_batch(net, nvq, sock, &msg);
> >> if (unlikely(busyloop_intr))
> >> /* If interrupted while doing busy polling,
> >> * requeue the handler to be fair handle_rx
> >> * as well as other tasks waiting on cpu.
> >> */
> >> vhost_poll_queue(&vq->poll);
> >> else
> >> /* All of our work has been completed;
> >> * however, before leaving the TX handler,
> >> * do one last check for work, and requeue
> >> * handler if necessary. If there is no work,
> >> * queue will be reenabled.
> >> */
> >> vhost_net_busy_poll_try_queue(net, vq);
> > 
> > 
> > I mean it's functionally equivalent, but vhost_net_busy_poll_try_queue 
> > checks the avail ring again and we just checked it.
> > Why is this a good idea?
> > This happens on good path so I dislike unnecessary work like this.
> 
> For the sake of discussion, let’s say vhost_tx_batch and the
> sendmsg within took 1 full second to complete. A lot could potentially
> happen in that amount of time. So sure, control path wise it looks like
> we just checked it, but time wise, that could have been ages ago.


Oh I forgot we had the tx batch in there.
OK then, I don't have a problem with this.


However, what I like about Jason's patch is that
it is actually simply revert of your patch +
a single call to 
vhost_tx_batch(net, nvq, sock, &msg);

So it is a more obviosly correct approach.


I'll be fine with doing what you propose on top,
with testing that they are benefitial for performance.






> > 
> > 
> >> break;
> >> }
> >> 
> >> 
> >>>> 
> >>>> @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >>>> ++nvq->done_idx;
> >>>> } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> >>>> 
> >>>> - /* Kicks are still disabled, dispatch any remaining batched msgs. */
> >>>> vhost_tx_batch(net, nvq, sock, &msg);
> >>>> -
> >>>> - if (unlikely(busyloop_intr))
> >>>> - /* If interrupted while doing busy polling, requeue the
> >>>> - * handler to be fair handle_rx as well as other tasks
> >>>> - * waiting on cpu.
> >>>> - */
> >>>> - vhost_poll_queue(&vq->poll);
> >>>> - else
> >>>> - /* All of our work has been completed; however, before
> >>>> - * leaving the TX handler, do one last check for work,
> >>>> - * and requeue handler if necessary. If there is no work,
> >>>> - * queue will be reenabled.
> >>>> - */
> >>>> - vhost_net_busy_poll_try_queue(net, vq);
> >> 
> >> Note: the use of vhost_net_busy_poll_try_queue was intentional in my
> >> patch as it was checking to see both conditionals.
> >> 
> >> Can we simply hoist my logic up instead?
> >> 
> >>>> }
> >>>> 
> >>>> static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> >>>> -- 
> >>>> 2.34.1
> >>> 
> >> 
> >> Tested-by: Jon Kohler <jon@nutanix.com <mailto:jon@nutanix.com>>
> >> 
> >> Tried this out on a 6.16 host / guest that locked up with iotlb miss loop,
> >> applied this patch and all was well.
> > 
> 

