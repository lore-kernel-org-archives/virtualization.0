Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB497710C
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781993; cv=none; b=Bx9Yg9gdKN5sHeRWzTre9TOCsVbZR15PaaTm/t6GDYVHecs7mkV76Ht6zAj3I23mln4wCClc7JqkCv6OZA+VHCX05KYOCDJyI2NEJ9LeqgflmJB6Hos/tyfjRRGFzFkG9Ppsx+y6jtVU3c0e8+xixtuLcOzOgtZO5Q/+R+Gd4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781993; c=relaxed/simple;
	bh=4gdQjgz1DaGKapVycwD2csURuJEY5zmqSO9sCCv7ETA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iN1dU0Fi81QGjwt5MCi1AuIDTXSMIf94QfYXgsQFjffPLcGLekIak98IRETN7GGexswUg58HvOhdnQvF/SNMB3zTdcdnTQOSXqGuzTyO7uVsublULOjttEkgISQQj9MdpQK6SoJf33rbw3sA/I2TzAb5RuxilARRlYsiRfxWkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Umcu9937; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umcu9937"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718781990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FgbWbQVfihAnM12MewtnW5ZWjWRwpeKC35/dzxHgaNM=;
	b=Umcu9937fRz4MqKf+8wIEEMJZteBb9IC1C3bAN+yzRtVrx5SWhmHdZDv6TYaHWqmkordu8
	1ETZnzhURLBC7NnQw6Hq9GHlkj3GGbEDbYuYv4cOhLsuCsNEpOux6vuI8390/jVxGaeT0Q
	uhKx6evhCSmwjQfSqCHk+u6JomVZXkc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-pcPGCPMwMe-TYYw7fnWq5w-1; Wed, 19 Jun 2024 03:26:29 -0400
X-MC-Unique: pcPGCPMwMe-TYYw7fnWq5w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-421739476b3so55669185e9.2
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 00:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718781988; x=1719386788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgbWbQVfihAnM12MewtnW5ZWjWRwpeKC35/dzxHgaNM=;
        b=wRl7LJK51uioI0UETVJSa3+Ryyw+s0bd4a7tr/aayzKoEytKosaxRbJiLzLWlxtJVl
         uJeLssGFOy/lYckUQVY69XFbzCNYEvmI4DZoOrzmzLlr+5WMUXg+CFiK3ow4lzyNJ9oY
         TT7oU65YjM9Qx38J98jYk1dSWsbJJOhmvA8QUWQ8MeUN3Ul22AtIX5ReWwLh0Gq052j0
         Fqm0+30o9bgi8TFWNcYDzThmw/n4prG+Cf+canIMxxiVFHOfahqXcl7W4A45lGTV1V7o
         u0/vndVFgejE/BuKGUo3KO2U1AqapoNyXUKNApYpSqdAJi9prxywNKbJ9ocRgjZNvgx8
         269A==
X-Forwarded-Encrypted: i=1; AJvYcCV289+Z+xmaduMDfk1YnpVCoyan+Q9iy2iTLDe9/dS/3b8UqL/rI06eVi3qyPmMUH02tXjy/AgFhts05PHHpRGYoMKLd4Jm0rueLztomz8=
X-Gm-Message-State: AOJu0YwTJNSHuyV4ukWSjs1Q13X9cBciTFT9+qGh8UQcvAF3iX7mv9Dc
	hPz1dKDBq5eKmL5aRo9ss45NGM1IitFCe9qKvO5CmgtMvGuZbBiq8nHU34Xn+tr/f9aZ5OGS8qh
	hJvA/HaoZ1L4svtTkWvzsk3naTGvXsas6sa+rKDO7mg8RxZPcgB2FDyvxItTqu6Ng
X-Received: by 2002:a05:600c:5107:b0:424:760d:75b8 with SMTP id 5b1f17b1804b1-424760d766bmr10331695e9.8.1718781988281;
        Wed, 19 Jun 2024 00:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG19bffvewKAsHvQ49KXnt1AnJ/r5s1KJCeOSQfTJk0Bf4Gs13z0uqyapeiyh3DeSyFNOhZFg==
X-Received: by 2002:a05:600c:5107:b0:424:760d:75b8 with SMTP id 5b1f17b1804b1-424760d766bmr10331455e9.8.1718781987725;
        Wed, 19 Jun 2024 00:26:27 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9ccsm251709785e9.5.2024.06.19.00.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:26:27 -0700 (PDT)
Date: Wed, 19 Jun 2024 03:26:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240619014938-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnJwbKmy923yye0t@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 07:45:16AM +0200, Jiri Pirko wrote:
> Tue, Jun 18, 2024 at 08:18:12PM CEST, mst@redhat.com wrote:
> >This looks like a sensible way to do this.
> >Yet something to improve:
> >
> >
> >On Tue, Jun 18, 2024 at 04:44:56PM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> 
> [...]
> 
> 
> >> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> >> +			    bool in_napi, struct virtnet_sq_free_stats *stats)
> >>  {
> >>  	unsigned int len;
> >>  	void *ptr;
> >>  
> >>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> >> -		++stats->packets;
> >> -
> >>  		if (!is_xdp_frame(ptr)) {
> >> -			struct sk_buff *skb = ptr;
> >> +			struct sk_buff *skb = ptr_to_skb(ptr);
> >>  
> >>  			pr_debug("Sent skb %p\n", skb);
> >>  
> >> -			stats->bytes += skb->len;
> >> +			if (is_orphan_skb(ptr)) {
> >> +				stats->packets++;
> >> +				stats->bytes += skb->len;
> >> +			} else {
> >> +				stats->napi_packets++;
> >> +				stats->napi_bytes += skb->len;
> >> +			}
> >>  			napi_consume_skb(skb, in_napi);
> >>  		} else {
> >>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
> >>  
> >> +			stats->packets++;
> >>  			stats->bytes += xdp_get_frame_len(frame);
> >>  			xdp_return_frame(frame);
> >>  		}
> >>  	}
> >> +	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
> >
> >Are you sure it's right? You are completing larger and larger
> >number of bytes and packets each time.
> 
> Not sure I get you. __free_old_xmit() is always called with stats
> zeroed. So this is just sum-up of one queue completion run.
> I don't see how this could become "larger and larger number" as you
> describe.

Oh. Right of course. Worth a comment maybe? Just to make sure
we remember not to call __free_old_xmit twice in a row
without reinitializing stats.
Or move the initialization into __free_old_xmit to make it
self-contained ..
WDYT?

> 
> >
> >For example as won't this eventually trigger this inside dql_completed:
> >
> >        BUG_ON(count > num_queued - dql->num_completed);
> 
> Nope, I don't see how we can hit it. Do not complete anything else
> in addition to what was started in xmit(). Am I missing something?
> 
> 
> >
> >?
> >
> >
> >If I am right the perf testing has to be redone with this fixed ...
> >
> >
> >>  }
> >>  
> 
> [...]

