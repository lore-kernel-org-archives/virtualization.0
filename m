Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8D22E3E9
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496673; cv=none; b=UYd621izGgul0eFwYBtfqKOtHmSMyF6HSi9wgTbjYPS9xmdacu16KjKJQgt5pRvXmsgVi127PBhb6jdvTyUPqXQG3GXAUj6mz2G2I29Da0BDjangy61/Z7pKtuMwBYYroTVX4dlMns3A9Zb+pHOQAeWbu61R/BwSovfd95glJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496673; c=relaxed/simple;
	bh=bz4+/X497RFI15mRxsIqRhNBIwSZjCmNalMcue3pcXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cZbVANq+ivgcx53zDzrWFmILNM4cNxwCd+sCTZO9WERYUU/rNE5o3R4/bXcrRPqbw85OFxLt7OBkyjSjtNs9hPWXcdlQK35C7Y+KcbwCtpfaoqM/G5S0/Y02zhmsPuVdlGKlFaiuzHF+E3GV7F4fOXBuMODhM37agiFsxhb5DbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGtOZZ4p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGtOZZ4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745496670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+iBi7KEPHVPdl78TuinUFRyNTsFrvN4I3oDOUPKzwc=;
	b=OGtOZZ4pELLlpsDfRSPosBgIxy9Yo/hTbR/mPEJbTM8qtqlkiJRQ37c6WdlwPSc6VDHoRL
	jhymIOCo0UXhIyppfSzMa1XJGOT21M1GjmfXwE7gNhvKGxu8cj4GQ/gGJIsgDLXSDM9itg
	H87XgQXbrkKmHo1nCOmKtYvt/01hrUk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-x9j5U1zCPpyXNh9VQuzXiw-1; Thu, 24 Apr 2025 08:11:09 -0400
X-MC-Unique: x9j5U1zCPpyXNh9VQuzXiw-1
X-Mimecast-MFC-AGG-ID: x9j5U1zCPpyXNh9VQuzXiw_1745496668
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso5154155e9.0
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 05:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496668; x=1746101468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+iBi7KEPHVPdl78TuinUFRyNTsFrvN4I3oDOUPKzwc=;
        b=PFsNeVnwXloOStPAXH5QLEOcSDwUik5XDsYGd1N4kJshzxSm+kBA2S1yWXFWUnwK1i
         g0OlECnhCMX4LdT3nLppzzy1CI2fuIsQ0n8SnHqDfHDjxWoAHO6yXvy3+ioTgeWwdgtI
         xTXTZfbVJp+dTgt0EIS5O5gldMei1EPYXLcj34U+BBMetbFEwG9FQgm4ioovHcz8bAMf
         cmik9PSbh4aL9kYucEM+NFaISE+DsxFHp02bdN7XPrSYEE4ZuDc9deKlhk0c/IOH/A+A
         82rmwjTcZJf0fu8wgOTSUyg9c2REfPb12/5WAAna6xCBxJ/3dqhUIWEH9hAzZIikbSen
         hryA==
X-Forwarded-Encrypted: i=1; AJvYcCX9kAcZsJpGwIoP/jLzV1K/WjnVGLJHTCatkbn2D3nvb/Szb474PHhb1ESvT+bY/D09JUZkwrCnyIQquaWU7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3xVRaf5/ar/Fvp09sonScjCNxoilZQRAi9LAZdAbC4e8OL8Wu
	ccqpPizzZOT4N925ljk+GFmNrnpicFaBFaTG0885fFZ59txZkpiNGBVif6H82A6PxjJUAVyN9ab
	B2mwCuWZZr5sNAc3kBQms0jCUR0NDGjmUK6JKTncFBaY1f8wT/O0Mugi3igfCdkE0
X-Gm-Gg: ASbGncvLGOoLOvZs5ahuZeiCH8URcM4gmeZipP+vIzldaAjjy3Z6ORVHo77ujEZpf9u
	5jw5MmgQO1pKz4jdDXg8zGYEBYnnQFUTLCWuO8hbp+/3ML9451WhtKqkEopgeHAiJh+bRo3fZ1C
	4SqsTvkRaObE6q6FumuOXeNQgSKgg9+euTCyS11frTRa3lZqo6xx3AEHr93z+0jn0QgG1UsxC0i
	JY7JTqYW8hWOmx7sOYOgrPQaUqHR/wlngqzCr/OzcI0Yt3mgKjgsWjiz7SbsIIcfeUz8BmG9rTg
	Qk/kJQ==
X-Received: by 2002:a05:600c:1395:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-4409bd17dfdmr21734035e9.8.1745496668274;
        Thu, 24 Apr 2025 05:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9n0roJbpJf5HRR05saKucJsNpfjrLxCLOXtUJbPRGicV0Zxwyv2cOdsaG6FPN2tpgup02FQ==
X-Received: by 2002:a05:600c:1395:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-4409bd17dfdmr21733875e9.8.1745496667950;
        Thu, 24 Apr 2025 05:11:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2b77f9sm18718025e9.25.2025.04.24.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:11:07 -0700 (PDT)
Date: Thu, 24 Apr 2025 08:11:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] vhost/net: Defer TX queue re-enable until
 after sendmsg
Message-ID: <20250424080749-mutt-send-email-mst@kernel.org>
References: <20250420010518.2842335-1-jon@nutanix.com>
 <a0894275-6b23-4cff-9e36-a635f776c403@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a0894275-6b23-4cff-9e36-a635f776c403@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lr0pRsklbOQXKm3Q2lY7aWuOKrane6Eg0Px5SW9r87g_1745496668
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2025 at 01:48:53PM +0200, Paolo Abeni wrote:
> On 4/20/25 3:05 AM, Jon Kohler wrote:
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index b9b9e9d40951..9b04025eea66 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -769,13 +769,17 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >  			break;
> >  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
> >  		if (head == vq->num) {
> > +			/* If interrupted while doing busy polling, requeue
> > +			 * the handler to be fair handle_rx as well as other
> > +			 * tasks waiting on cpu
> > +			 */
> >  			if (unlikely(busyloop_intr)) {
> >  				vhost_poll_queue(&vq->poll);
> > -			} else if (unlikely(vhost_enable_notify(&net->dev,
> > -								vq))) {
> > -				vhost_disable_notify(&net->dev, vq);
> > -				continue;
> >  			}
> > +			/* Kicks are disabled at this point, break loop and
> > +			 * process any remaining batched packets. Queue will
> > +			 * be re-enabled afterwards.
> > +			 */
> >  			break;
> >  		}
> 
> It's not clear to me why the zerocopy path does not need a similar change.

It can have one, it's just that Jon has a separate patch to drop
it completely. A commit log comment mentioning this would be a good
idea, yes.

> > @@ -825,7 +829,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >  		++nvq->done_idx;
> >  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> >  
> > +	/* Kicks are still disabled, dispatch any remaining batched msgs. */
> >  	vhost_tx_batch(net, nvq, sock, &msg);
> > +
> > +	/* All of our work has been completed; however, before leaving the
> > +	 * TX handler, do one last check for work, and requeue handler if
> > +	 * necessary. If there is no work, queue will be reenabled.
> > +	 */
> > +	vhost_net_busy_poll_try_queue(net, vq);
> 
> This will call vhost_poll_queue() regardless of the 'busyloop_intr' flag
> value, while AFAICS prior to this patch vhost_poll_queue() is only
> performed with busyloop_intr == true. Why don't we need to take care of
> such flag here?

Hmm I agree this is worth trying, a free if possibly small performance
gain, why not. Jon want to try?


> @Michael: I assume you prefer that this patch will go through the
> net-next tree, right?
> 
> Thanks,
> 
> Paolo

I don't mind and this seems to be what Jon wants.
I could queue it too, but extra review  it gets in the net tree is good.

-- 
MST

