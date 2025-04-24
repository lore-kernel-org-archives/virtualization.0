Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72027F751
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504688; cv=none; b=GyBvwg4PyylYg0rveE08kLuVtMKqdnmG9W2Ga4cRJcmUMPTzMJ/jvb8IVvLTUhLCOEajoXgAyh3E/hIfrMToQXT7846lo7jn/YE2WU0uIORTD3p81XtvSZNBzXWljdA5IyKxZQT3uetaRUTHGZUK+mdFtdiqSxQkQvei2BLXLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504688; c=relaxed/simple;
	bh=ITEJU5E+U8k3jYhXGW3lQ1NkLPi5MlRGY624NYpem6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nz1oQIW6vzTxpqs6W8zTQQfiBBzDHY7OfawdcUM3PmjbGuluQhBwZS2ASeKWtM6NHzNd/xPDenMC3/R1JAJM1ojp7vkDH1Gvu3TY09AIoZWPOx7CW2lNdFRh+BqVKNHmKQIovhjRnXiz9j3v6qHgkElsZp9j1Sle73ax+FGXxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYAV3m/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYAV3m/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745504683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nV8jVW/8nt8ZwTGGNIL9yTSPGZZ29xDmvRWgbdJwWX4=;
	b=hYAV3m/tTTF4hSkMk7HJveaFSX2IExNylsv0ymZn+HnLT1t1vPwaT+L9iSvxV0RkH/yJCc
	+FJLfMHVAXno2OXXmyMEpqThBRTFOJKzr9E5jLk/WDFyhD4VYNHVyxdGlQuX3p1hxzUyTd
	vQVt2xAtTdnwjFvkdy5Xs46IM02HVK8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-qt7Yflf5OvGs1c3M-ZAbsg-1; Thu, 24 Apr 2025 10:24:42 -0400
X-MC-Unique: qt7Yflf5OvGs1c3M-ZAbsg-1
X-Mimecast-MFC-AGG-ID: qt7Yflf5OvGs1c3M-ZAbsg_1745504681
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39131851046so380457f8f.0
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 07:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504681; x=1746109481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nV8jVW/8nt8ZwTGGNIL9yTSPGZZ29xDmvRWgbdJwWX4=;
        b=IBu06nGpe2pOxc+dr1O0XBZ2jc0/QCv6ahWUbMHr3uf9Nka/eLeOLCBxIW9Vv3L3XX
         oHieglh18aDLSEAM29hg+wYGYJh+N5AU+igK696GBoVn4Mj+n8yNBynY0GmL3JnBcV5Z
         aWJUE3OTVI2XqU4oVCjYMI3y2nfbIPUiagCCUxKw9q1NJgtVCU10rtclpqpyvPukC7dt
         3W61BmxVKuTsDtk0OF+NF6F0R42z0ZS+yILAKt8gMSnDHAoRotdhKQ33xepg6v7r6+gw
         WS0dWuHGXZQ/TZjONdUI5fKMomB3MuKCROTk/QNTaRQ2r3THBSiD7uQtyocerE8KC4Gc
         eJlg==
X-Forwarded-Encrypted: i=1; AJvYcCXDVVBIfpRvyBD66gsW6UjQeX/V8eFSZ5VyOjvv4y7cN61uUoYjWylkhKIkFgemYkNYreaBgr2oLeYkNCi7Bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDpkF+AnHGodgHisX6qUuYvEfiTExgd7AC13TAQjI8zrRQxR3b
	S4BBrpqTjAt3DLElUmhFth8/RJc+DQ2C851OIFvmKMUd0Dsqse/IgM1mTLX+Y596+F5EJ5QqFF/
	dCwhFRFjT7ugYwDv54f4XAyuSEjv9OJ8SoPb4hQKj8lmuGsOr8F1XCRVF/HgAmD7e
X-Gm-Gg: ASbGnctXvshPBmCaOdxPCPfFLoAHMJ2lBMrRYepWFZhPMZlhJskXz0RUND+46th3ENk
	S+C5+OJ5z2N6GwQGm41f1n7Kk3FiUU0WXeSF9cH7pTMZZWQPQKY5ABUlceJrHV6Ug9gsG0+Avjw
	VCD1jxpPZGmnqak5cPTLxwIsLkI84x176jbkQs0rHt9dmo7JqQJX/n7g30irWGeoxvN4KZfo7C7
	lf73GDkIAiRi10Y1UN5GfutthyXqyW+7AuNkLjgXV+nJPQpJahrTmesM+r+shv8qJEXWUDVAKBo
	+IlOwQ==
X-Received: by 2002:a05:6000:240a:b0:39a:ca0b:e7c7 with SMTP id ffacd0b85a97d-3a06cfaba23mr2493035f8f.36.1745504681012;
        Thu, 24 Apr 2025 07:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwBzD5hh+2Z62EditO+ortaghgO8pvR6NguSzN5/Fukq1qShODNoWcevMtBiQSBYPeBcmOdg==
X-Received: by 2002:a05:6000:240a:b0:39a:ca0b:e7c7 with SMTP id ffacd0b85a97d-3a06cfaba23mr2493006f8f.36.1745504680461;
        Thu, 24 Apr 2025 07:24:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4a7ff8sm2347237f8f.13.2025.04.24.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:24:39 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:24:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] vhost/net: Defer TX queue re-enable until
 after sendmsg
Message-ID: <20250424102351-mutt-send-email-mst@kernel.org>
References: <20250420010518.2842335-1-jon@nutanix.com>
 <a0894275-6b23-4cff-9e36-a635f776c403@redhat.com>
 <20250424080749-mutt-send-email-mst@kernel.org>
 <1CE89B73-B236-464A-8781-13E083AFB924@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1CE89B73-B236-464A-8781-13E083AFB924@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xnwCA5rLgAEf4xNN_nKWjMLRX-IpAXxBV0WC4v0HnCw_1745504681
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 24, 2025 at 01:53:34PM +0000, Jon Kohler wrote:
> 
> 
> > On Apr 24, 2025, at 8:11 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Thu, Apr 24, 2025 at 01:48:53PM +0200, Paolo Abeni wrote:
> >> On 4/20/25 3:05 AM, Jon Kohler wrote:
> >>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>> index b9b9e9d40951..9b04025eea66 100644
> >>> --- a/drivers/vhost/net.c
> >>> +++ b/drivers/vhost/net.c
> >>> @@ -769,13 +769,17 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >>> break;
> >>> /* Nothing new?  Wait for eventfd to tell us they refilled. */
> >>> if (head == vq->num) {
> >>> + /* If interrupted while doing busy polling, requeue
> >>> + * the handler to be fair handle_rx as well as other
> >>> + * tasks waiting on cpu
> >>> + */
> >>> if (unlikely(busyloop_intr)) {
> >>> vhost_poll_queue(&vq->poll);
> >>> - } else if (unlikely(vhost_enable_notify(&net->dev,
> >>> - vq))) {
> >>> - vhost_disable_notify(&net->dev, vq);
> >>> - continue;
> >>> }
> >>> + /* Kicks are disabled at this point, break loop and
> >>> + * process any remaining batched packets. Queue will
> >>> + * be re-enabled afterwards.
> >>> + */
> >>> break;
> >>> }
> >> 
> >> It's not clear to me why the zerocopy path does not need a similar change.
> > 
> > It can have one, it's just that Jon has a separate patch to drop
> > it completely. A commit log comment mentioning this would be a good
> > idea, yes.
> 
> Yea, the utility of the ZC side is a head scratcher for me, I can’t get it to work
> well to save my life. I’ve got a separate thread I need to respond to Eugenio
> on, will try to circle back on that next week.
> 
> The reason this one works so well is that the last batch in the copy path can
> take a non-trivial amount of time, so it opens up the guest to a real saw tooth
> pattern. Getting rid of that, and all that comes with it (exits, stalls, etc), just
> pays off.
> 
> > 
> >>> @@ -825,7 +829,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >>> ++nvq->done_idx;
> >>> } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> >>> 
> >>> + /* Kicks are still disabled, dispatch any remaining batched msgs. */
> >>> vhost_tx_batch(net, nvq, sock, &msg);
> >>> +
> >>> + /* All of our work has been completed; however, before leaving the
> >>> + * TX handler, do one last check for work, and requeue handler if
> >>> + * necessary. If there is no work, queue will be reenabled.
> >>> + */
> >>> + vhost_net_busy_poll_try_queue(net, vq);
> >> 
> >> This will call vhost_poll_queue() regardless of the 'busyloop_intr' flag
> >> value, while AFAICS prior to this patch vhost_poll_queue() is only
> >> performed with busyloop_intr == true. Why don't we need to take care of
> >> such flag here?
> > 
> > Hmm I agree this is worth trying, a free if possibly small performance
> > gain, why not. Jon want to try?
> 
> I mentioned in the commit msg that the reason we’re doing this is to be
> fair to handle_rx. If my read of vhost_net_busy_poll_try_queue is correct,
> we would only call vhost_poll_queue iff:
> 1. The TX ring is not empty, in which case we want to run handle_tx again
> 2. When we go to reenable kicks, it returns non-zero, which means we
> should run handle_tx again anyhow
> 
> In the ring is truly empty, and we can re-enable kicks with no drama, we
> would not run vhost_poll_queue.
> 
> That said, I think what you’re saying here is, we should check the busy
> flag and *not* try vhost_net_busy_poll_try_queue, right?

yes

> If so, great, I did
> that in an internal version of this patch; however, it adds another conditional
> which for the vast majority of users is not going to add any value (I think)
> 
> Happy to dig deeper, either on this change series, or a follow up?

it just seems like a more conservate thing to do, given we already did
this in the past.

> > 
> > 
> >> @Michael: I assume you prefer that this patch will go through the
> >> net-next tree, right?
> >> 
> >> Thanks,
> >> 
> >> Paolo
> > 
> > I don't mind and this seems to be what Jon wants.
> > I could queue it too, but extra review  it gets in the net tree is good.
> 
> My apologies, I thought all non-bug fixes had to go thru net-next,
> which is why I sent the v2 to net-next; however if you want to queue
> right away, I’m good with either. Its a fairly well contained patch with
> a huge upside :) 
> 
> > 
> > -- 
> > MST
> > 
> 

