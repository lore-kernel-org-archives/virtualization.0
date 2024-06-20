Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC81AED3E
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898774; cv=none; b=jNS5u/Z0VD9DKZFVAQgUcUQyig/h+OR2C6gf12VwBz9nnSJPUdJjyxCVGHij9fOgm+GJxXstU9Tag4NS9JPHHEm3sC/xsJD4N4ePAKz18Ps9bUS8LgEoX/3Dpc9n7+nv6z7tNyG8Uv0uFhhv7NLrAUtEwkSkKPLw87o77S9IhQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898774; c=relaxed/simple;
	bh=moBi9N/RFbRzoVOUAM3DlRJZlP/2IpYEuEZFZftDCro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jDJuasFLzVMKh1m6tiSCB4hL/SN1EIvMg5CLDgbH0jMqmxXsrTQf2h/luDD8IAPcmJB/NtV3qS1wQPWbLkJdd5rMRAljpxZlz1LivHnIO35otXxtPos6THg1seE38JidPBcs33sILHjJ0g2X5wl+1dy1CQBdGesk1KKEvAbXhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAX9cxaY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAX9cxaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718898771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwNNvwObBSUkOJNUIBrZAqmahLR99Pl276GZyuIXCWQ=;
	b=cAX9cxaYZDHZEGlWSgJx9TrAVd8DRxxFpUTKZppyMCJeKsAd+Km8ZX4WBbB0SiJjMCBAcL
	4k4m+YMQNJrxPezQnU1kJZD/sEyfzZaQZ6o2rQemRVOcYrTNXNbVlAuAqOiEI1xrpK2z3J
	Y34VSOq1gGUY5aBc4fNvHGs8cvqvqqw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-JWFh1uXtPBeC9fbL3rs9Hg-1; Thu, 20 Jun 2024 11:52:49 -0400
X-MC-Unique: JWFh1uXtPBeC9fbL3rs9Hg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52c983f4285so856081e87.2
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718898767; x=1719503567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwNNvwObBSUkOJNUIBrZAqmahLR99Pl276GZyuIXCWQ=;
        b=mp4qHJl1dJQKZVVgfHoOLBd7Ia8Ug4Us/WJ1YiZqOF5nk2kK++ui5j7jlH+3OsDUhL
         MIAsZQq0e0UFaxoeC5KHAlRGQkJqxXYdBpqRva8eYd6/4IN0aKFnOkpCCAIJsVPQm2AP
         ALfl2jXokWWm19tWn0w1cr+Ff0wUN+j/4GP1Z41TQkUbGphIOvsnRxD/cLBkGNS6nAE9
         eh2g3tZXOHkEjlryZUq6bUh7/gNxu02TCM7JtCwsKw5Yk2AkmcAwNOroIxlmkYjmBijh
         yOE0j2E2cUEHegZaqXVQzuTBInyKm0wEuqP46N3Bd9mIrdHXXl0/erOtTYpUM+OCBHRc
         Zthg==
X-Forwarded-Encrypted: i=1; AJvYcCVlfPAJH8Clwpv++VviyBhirboWxfKJmNu2vEJIwqKTCZGQCJ+ezzLkVgL4u9OdfWGxxrO69FMasrtdCqYZwn9reeKfmFT+p6FIb14MRfc=
X-Gm-Message-State: AOJu0YyKSJzIUQJqS+RtmWNyyvx9cWRm5+0kmXNnCJAYD3YsmaMqGcS1
	pb7T+vtNG00/acxx21rEuNJlhvZQKcRziZezejnU8atOYbdZGXRThCPyACZFJOf3tHykTkY8gFt
	5e5rRotgnAt10ElTeqS2z8ewAadkceAA2QtsG7HJPyhagoZNGzcgeskB4opfGMxHb
X-Received: by 2002:a05:6512:e94:b0:52c:8339:d09c with SMTP id 2adb3069b0e04-52ccaa56a39mr4237024e87.3.1718898767275;
        Thu, 20 Jun 2024 08:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Je/ga6tFIcspju8x5xeYXLt0pQVBD8V9mXVemMeiqup+QDAJObfNNyyUsMB9rXPQA0/+kQ==
X-Received: by 2002:a05:6512:e94:b0:52c:8339:d09c with SMTP id 2adb3069b0e04-52ccaa56a39mr4236984e87.3.1718898766077;
        Thu, 20 Jun 2024 08:52:46 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9943sm9887783a12.51.2024.06.20.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:52:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:52:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Li RongQing <lirongqing@baidu.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Message-ID: <20240620115133-mutt-send-email-mst@kernel.org>
References: <20240619025529.5264-1-lirongqing@baidu.com>
 <20240620070908.2efe2048@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240620070908.2efe2048@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 07:09:08AM -0700, Jakub Kicinski wrote:
> On Wed, 19 Jun 2024 10:55:29 +0800 Li RongQing wrote:
> > This place is fetching the stats, so u64_stats_fetch_begin
> > and u64_stats_fetch_retry should be used
> > 
> > Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >  drivers/net/virtio_net.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 61a57d1..b669e73 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2332,16 +2332,18 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
> >  static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
> >  {
> >  	struct dim_sample cur_sample = {};
> > +	unsigned int start;
> >  
> >  	if (!rq->packets_in_napi)
> >  		return;
> >  
> > -	u64_stats_update_begin(&rq->stats.syncp);
> > -	dim_update_sample(rq->calls,
> > -			  u64_stats_read(&rq->stats.packets),
> > -			  u64_stats_read(&rq->stats.bytes),
> > -			  &cur_sample);
> > -	u64_stats_update_end(&rq->stats.syncp);
> > +	do {
> > +		start = u64_stats_fetch_begin(&rq->stats.syncp);
> > +		dim_update_sample(rq->calls,
> > +				u64_stats_read(&rq->stats.packets),
> > +				u64_stats_read(&rq->stats.bytes),
> > +				&cur_sample);
> > +	} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
> 
> Did you by any chance use an automated tool of any sort to find this
> issue or generate the fix?
> 
> I don't think this is actually necessary here, you're in the same
> context as the updater of the stats, you don't need any protection.
> You can remove u64_stats_update_begin() / end() (in net-next, there's
> no bug).
> 
> I won't comment on implications of calling dim_update_sample() in 
> a loop.

I didn't realize there are any - it seems to be idempotent, no?


> Please make sure you answer my "did you use a tool" question, I'm
> really curious.
> -- 
> pw-bot: cr

