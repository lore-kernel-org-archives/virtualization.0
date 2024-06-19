Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F147B3E1
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785071; cv=none; b=W7XfAIFiLyZRZF3X7r0pz/Zgq5xZ3SfY2FWLYJ4QtdJTrfdRcHXa+Vf85qSKXRttHCDsNz7hH+cBdzEvzEhBhjqWbmrIs9Dle7fJPa0J/68aL0lX3fPK1DEVgij3BsFMbcaLD9ZFu5lRjNb6fyX2lkeiNhxPHrnfJoDPvRltKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785071; c=relaxed/simple;
	bh=l8+zgzbP18KtI89/4El6+cz4hyjRgL8181vGXCgW+40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R8AAfHo5JLP762WFD96xYkEtt7bM7NriZhyb8bXYeXZFB02ZTje+ehleBd2Bgp9+tywcMv0e87ZzBX6IY6XsKh1ja/RgLPsLqGHlqqulbGqkuEaCS8KhstBvDz330iKlRDr2g8Lzaci1je9hlxUglEi1t/BPbtVY0SJO+cPMYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IovADmWL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IovADmWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718785068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2HochStbwK8oLLb/40dXva6vGhIzuUQPXwS/TDHqjQ=;
	b=IovADmWLh6khmAh4pLUx/J3uIsdGlLC2DsNwlaG2U6zlO1pCVWDs0zf9RXuoheL/xcahFC
	pTtCJ/nl01jvsmDYoUxYOBMFMUrMGRSTBPCpyP85QXZRfCHQpDIcvtoh8ykCnCUKQGz3RM
	lOlQAGOxjWKXF28goe6aeavsJuiOPDw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-V1kbznIsMLuaIIPLOYdrKw-1; Wed, 19 Jun 2024 04:17:44 -0400
X-MC-Unique: V1kbznIsMLuaIIPLOYdrKw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4217a6a00d8so40991935e9.0
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 01:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785064; x=1719389864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2HochStbwK8oLLb/40dXva6vGhIzuUQPXwS/TDHqjQ=;
        b=IIC7oeSv7b98Li5c/NpX199kib0Pdxe8xysrgo8ukktSbrE2usmdCmPcGnAM8xV0VT
         CIOIcssA5dhSXnmHc6/LvpR93B1Yh3l4Rk7/dDfUh3S3ozJkuPWkPTJEotLvFleUALM2
         kz+/Fvp4p3yHIF9UfF+R1iaZ1zrmcDNelwIJ2gV112aYWzRKHLHh55tJNcHc2J8ckH/w
         Kh9KWf9eLL1b4Uvbxtv4zGdKgf4Dcl3NbM52HVHYbOTbIH49FtomXOR9emyQr3l2hw1x
         qKj50bC73p7xRLbiNAunqUXinKZMRHswSfsnO7DdF0D/7qNJ0uwECdIdHz5IsYo/QduW
         9OeA==
X-Forwarded-Encrypted: i=1; AJvYcCUNHGo+z7uEzf5zQerEjxWkOn4lIu+8B6U52Q2RPmUg7pr4CfqyibYaP9avqJRnU9Z7zNHyruo0F1/XyWuyleVjCdAah23xAsrADCsK36A=
X-Gm-Message-State: AOJu0YxgLxzWtXPuuGixmRPMrO8agSxnsUjmoBchkFzz4bzwl7KRrASq
	cZ9qv5VeWCzvV+O8E4+NQ9s09ZwRrga7+7uCTC9hB4Eit4jpgeUGTjoT42JBKWBjlIPEixzeG0X
	kM2QdyjaqjEhZxrRNanXF959FIMzxbRiDECMU7+pxD5uX/fp3y0FZgL66BTP4ft0g
X-Received: by 2002:a7b:c355:0:b0:421:8060:f772 with SMTP id 5b1f17b1804b1-42475018647mr12800465e9.0.1718785063675;
        Wed, 19 Jun 2024 01:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2pE9o2OD007AYdoJfEVPwiiMzWBpLUGF75xR/hP2NwCCtwbSsxDnzYCkBs6Ypv2Wjzil+aw==
X-Received: by 2002:a7b:c355:0:b0:421:8060:f772 with SMTP id 5b1f17b1804b1-42475018647mr12800265e9.0.1718785063216;
        Wed, 19 Jun 2024 01:17:43 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c16sm219568585e9.38.2024.06.19.01.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:17:42 -0700 (PDT)
Date: Wed, 19 Jun 2024 04:17:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240619041211-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
 <20240619014938-mutt-send-email-mst@kernel.org>
 <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 10:05:41AM +0200, Jiri Pirko wrote:
> Wed, Jun 19, 2024 at 09:26:22AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 19, 2024 at 07:45:16AM +0200, Jiri Pirko wrote:
> >> Tue, Jun 18, 2024 at 08:18:12PM CEST, mst@redhat.com wrote:
> >> >This looks like a sensible way to do this.
> >> >Yet something to improve:
> >> >
> >> >
> >> >On Tue, Jun 18, 2024 at 04:44:56PM +0200, Jiri Pirko wrote:
> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> 
> >> 
> >> [...]
> >> 
> >> 
> >> >> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> >> >> +			    bool in_napi, struct virtnet_sq_free_stats *stats)
> >> >>  {
> >> >>  	unsigned int len;
> >> >>  	void *ptr;
> >> >>  
> >> >>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> >> >> -		++stats->packets;
> >> >> -
> >> >>  		if (!is_xdp_frame(ptr)) {
> >> >> -			struct sk_buff *skb = ptr;
> >> >> +			struct sk_buff *skb = ptr_to_skb(ptr);
> >> >>  
> >> >>  			pr_debug("Sent skb %p\n", skb);
> >> >>  
> >> >> -			stats->bytes += skb->len;
> >> >> +			if (is_orphan_skb(ptr)) {
> >> >> +				stats->packets++;
> >> >> +				stats->bytes += skb->len;
> >> >> +			} else {
> >> >> +				stats->napi_packets++;
> >> >> +				stats->napi_bytes += skb->len;
> >> >> +			}
> >> >>  			napi_consume_skb(skb, in_napi);
> >> >>  		} else {
> >> >>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
> >> >>  
> >> >> +			stats->packets++;
> >> >>  			stats->bytes += xdp_get_frame_len(frame);
> >> >>  			xdp_return_frame(frame);
> >> >>  		}
> >> >>  	}
> >> >> +	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
> >> >
> >> >Are you sure it's right? You are completing larger and larger
> >> >number of bytes and packets each time.
> >> 
> >> Not sure I get you. __free_old_xmit() is always called with stats
> >> zeroed. So this is just sum-up of one queue completion run.
> >> I don't see how this could become "larger and larger number" as you
> >> describe.
> >
> >Oh. Right of course. Worth a comment maybe? Just to make sure
> >we remember not to call __free_old_xmit twice in a row
> >without reinitializing stats.
> >Or move the initialization into __free_old_xmit to make it
> >self-contained ..
> 
> Well, the initialization happens in the caller by {0}, Wouldn't
> memset in __free_old_xmit() add an extra overhead? IDK.
> Perhaps a small comment in __free_old_xmit() would do better.
> 
> One way or another, I think this is parallel to this patchset. Will
> handle it separatelly if you don't mind.


Okay.


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> >WDYT?
> >
> >> 
> >> >
> >> >For example as won't this eventually trigger this inside dql_completed:
> >> >
> >> >        BUG_ON(count > num_queued - dql->num_completed);
> >> 
> >> Nope, I don't see how we can hit it. Do not complete anything else
> >> in addition to what was started in xmit(). Am I missing something?
> >> 
> >> 
> >> >
> >> >?
> >> >
> >> >
> >> >If I am right the perf testing has to be redone with this fixed ...
> >> >
> >> >
> >> >>  }
> >> >>  
> >> 
> >> [...]
> >

